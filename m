Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2A3CCD1BF
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 15:13:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B561C838BB;
	Fri, 24 Oct 2025 17:12:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D550683677; Fri, 24 Oct 2025 17:12:32 +0200 (CEST)
Received: from inet11.abb.com (inet11.abb.com [138.225.1.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CF2E837B6
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 17:12:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=wolfgang.wallner@br-automation.com
Received: from brsmtp01.br-automation.co.at (unknown [10.43.60.20])
 by xe-s-netms02z.xe.abb.com (Postfix) with ESMTPS id 091E07284;
 Fri, 24 Oct 2025 17:12:30 +0200 (CEST)
Received: from extmail.br-automation.com ([192.168.112.26])
 by brsmtp01.br-automation.co.at (HCL Domino Release 14.5)
 with ESMTP id 2025102417122729-28977 ;
 Fri, 24 Oct 2025 17:12:27 +0200 
Received: from ATEGGE4852.br-automation.co.at ([10.43.64.79])
 by extmail.br-automation.com (HCL Domino Release 14.0FP3 HF8)
 with ESMTP id 2025102417122964-18298 ;
 Fri, 24 Oct 2025 17:12:29 +0200 
From: "Wolfgang Wallner" <wolfgang.wallner@br-automation.com>
To: u-boot@lists.denx.de
Cc: "Bernhard Messerklinger" <bernhard.messerklinger@br-automation.com>,
 "Wolfgang Wallner" <wolfgang.wallner@br-automation.com>,
 "Julien Masson" <jmasson@baylibre.com>,
 "Marek Vasut" <marek.vasut+renesas@mailbox.org>,
 "Mattijs Korpershoek" <mkorpershoek@kernel.org>,
 "Mayuresh Chitale" <mchitale@ventanamicro.com>,
 "Paul HENRYS" <paul.henrys_ext@softathome.com>,
 "Simon Glass" <sjg@chromium.org>, "Tom Rini" <trini@konsulko.com>
Subject: [PATCH 5/9] image: Fix typos in image.h
Date: Fri, 24 Oct 2025 17:12:01 +0200
Message-ID: <20251024151219.100970-6-wolfgang.wallner@br-automation.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251024151219.100970-1-wolfgang.wallner@br-automation.com>
References: <20251024151219.100970-1-wolfgang.wallner@br-automation.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on BRSMTPINTERN2/InternSMTP(Release
 14.0FP3 HF8|December 13, 2024) at 10/24/2025 05:12:29 PM,
 Serialize by Router on BRSMTPINTERN2/InternSMTP(Release 14.0FP3 HF8|December
 13, 2024) at 10/24/2025 05:12:29 PM,
 Itemize by SMTP Server on BRSMTP01/Eggelsberg/AT/B&R(Release 14.5|June 06,
 2025) at 10/24/2025 05:12:27 PM,
 Serialize by Router on BRSMTP01/Eggelsberg/AT/B&R(Release 14.5|June 06,
 2025) at 10/24/2025 05:12:27 PM,
 Serialize complete at 10/24/2025 05:12:27 PM
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

Fix some typos in include/image.h.

Signed-off-by: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
---

 include/image.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/image.h b/include/image.h
index fc2f2487095..9a1c828416d 100644
--- a/include/image.h
+++ b/include/image.h
@@ -654,10 +654,10 @@ int boot=5Fget=5Ffpga(struct bootm=5Fheaders *images);
  * boot=5Fget=5Framdisk() is responsible for finding a valid ramdisk image.
  * Currently supported are the following ramdisk sources:
  *      - multicomponent kernel/ramdisk image,
- *      - commandline provided address of decicated ramdisk image.
+ *      - commandline provided address of dedicated ramdisk image.
  *
  * returns:
- *     0, if ramdisk image was found and valid, or skiped
+ *     0, if ramdisk image was found and valid, or skipped
  *     rd=5Fstart and rd=5Fend are set to ramdisk start/end addresses if
  *     ramdisk image is found and valid
  *
@@ -739,7 +739,7 @@ int boot=5Fget=5Ffdt=5Ffit(struct bootm=5Fheaders *imag=
es, ulong addr,
  * @param bootstage=5Fid	ID of starting bootstage to use for progress upda=
tes.
  *			This will be added to the BOOTSTAGE=5FSUB values when
  *			calling bootstage=5Fmark()
- * @param load=5Fop	Decribes what to do with the load address
+ * @param load=5Fop	Describes what to do with the load address
  * @param datap		Returns address of loaded image
  * @param lenp		Returns length of loaded image
  * Return: node offset of image, or -ve error code on error:
@@ -812,7 +812,7 @@ int fit=5Fget=5Fnode=5Ffrom=5Fconfig(struct bootm=5Fhea=
ders *images,
  * boot=5Fget=5Ffdt() is responsible for finding a valid flat device tree =
image.
  * Currently supported are the following FDT sources:
  *      - multicomponent kernel/ramdisk/FDT image,
- *      - commandline provided address of decicated FDT image.
+ *      - commandline provided address of dedicated FDT image.
  *
  * Return:
  *     0, if fdt image was found and valid, or skipped
--=20
2.51.1

