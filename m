Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E16B6CCF9EB
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 12:53:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 512EE83621;
	Fri, 24 Oct 2025 14:52:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56C0683623; Fri, 24 Oct 2025 14:52:58 +0200 (CEST)
Received: from inet12.abb.com (inet12.abb.com [138.225.1.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 641E78331F
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 14:52:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=wolfgang.wallner@br-automation.com
Received: from brsmtp01.br-automation.co.at (unknown [10.43.60.20])
 by xe-s-netms03z.xe.abb.com (Postfix) with ESMTPS id D05276317A4;
 Fri, 24 Oct 2025 14:52:55 +0200 (CEST)
Received: from extmail.br-automation.com ([192.168.112.26])
 by brsmtp01.br-automation.co.at (HCL Domino Release 14.5)
 with ESMTP id 2025102414525323-28570 ;
 Fri, 24 Oct 2025 14:52:53 +0200 
Received: from ATEGGE4852.br-automation.co.at ([10.43.64.79])
 by extmail.br-automation.com (HCL Domino Release 14.0FP3 HF8)
 with ESMTP id 2025102414525544-18223 ;
 Fri, 24 Oct 2025 14:52:55 +0200 
From: "Wolfgang Wallner" <wolfgang.wallner@br-automation.com>
To: u-boot@lists.denx.de
Cc: "Heiko Schocher" <hs@nabladev.com>,
 "Bernhard Messerklinger" <bernhard.messerklinger@br-automation.com>,
 "Wolfgang Wallner" <wolfgang.wallner@br-automation.com>,
 "Jaehoon Chung" <jh80.chung@samsung.com>,
 "Svyatoslav Ryhel" <clamor95@gmail.com>, "Tom Rini" <trini@konsulko.com>,
 "Zixun LI" <admin@hifiphile.com>
Subject: [PATCH] gpio: Return -ENODEV if gpio_hog_lookup_name() is empty
Date: Fri, 24 Oct 2025 14:52:45 +0200
Message-ID: <20251024125251.39886-1-wolfgang.wallner@br-automation.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on BRSMTPINTERN2/InternSMTP(Release
 14.0FP3 HF8|December 13, 2024) at 10/24/2025 02:52:55 PM,
 Serialize by Router on BRSMTPINTERN2/InternSMTP(Release 14.0FP3 HF8|December
 13, 2024) at 10/24/2025 02:52:55 PM,
 Itemize by SMTP Server on BRSMTP01/Eggelsberg/AT/B&R(Release 14.5|June 06,
 2025) at 10/24/2025 02:52:53 PM,
 Serialize by Router on BRSMTP01/Eggelsberg/AT/B&R(Release 14.5|June 06,
 2025) at 10/24/2025 02:52:53 PM,
 Serialize complete at 10/24/2025 02:52:53 PM
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

If CONFIG=5FGPIO=5FHOG is not set, then gpio=5Fhog=5Flookup=5Fname() is emp=
ty,
and thus does not initialize any of its parameters. It does still
return 0 though, and so any calling function might assume that the
parameters have been initialized successfully.

Change the return value to -ENODEV in this case, as the function
would in the case when CONFIG=5FGPIO=5FHOG is set but the gpio hog
could not be found.

Signed-off-by: Wolfgang Wallner <wolfgang.wallner@br-automation.com>

---

 drivers/gpio/gpio-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-uclass.c b/drivers/gpio/gpio-uclass.c
index 3d9f8b32b8d..7559b8dc7e2 100644
--- a/drivers/gpio/gpio-uclass.c
+++ b/drivers/gpio/gpio-uclass.c
@@ -378,7 +378,7 @@ U=5FBOOT=5FDRIVER(gpio=5Fhog) =3D {
 #else
 int gpio=5Fhog=5Flookup=5Fname(const char *name, struct gpio=5Fdesc **desc)
 {
-	return 0;
+	return -ENODEV;
 }
 #endif
=20
--=20
2.51.1

base-commit: b10c055d4e1b5153a331a61ef82a5b01b5bb4c45
branch: us/gpio=5Fhog
