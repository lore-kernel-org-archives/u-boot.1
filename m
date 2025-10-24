Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB20CCF9E0
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 15:12:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34F2C836EE;
	Fri, 24 Oct 2025 17:12:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD3E583700; Fri, 24 Oct 2025 17:12:32 +0200 (CEST)
Received: from inet11.abb.com (inet11.abb.com [138.225.1.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 316FA836EE
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 17:12:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=wolfgang.wallner@br-automation.com
Received: from brsmtp01.br-automation.co.at (unknown [10.43.60.20])
 by xe-s-netms02z.xe.abb.com (Postfix) with ESMTPS id A2EB07285;
 Fri, 24 Oct 2025 17:12:29 +0200 (CEST)
Received: from extmail.br-automation.com ([192.168.112.26])
 by brsmtp01.br-automation.co.at (HCL Domino Release 14.5)
 with ESMTP id 2025102417122696-28976 ;
 Fri, 24 Oct 2025 17:12:26 +0200 
Received: from ATEGGE4852.br-automation.co.at ([10.43.64.79])
 by extmail.br-automation.com (HCL Domino Release 14.0FP3 HF8)
 with ESMTP id 2025102417122925-18297 ;
 Fri, 24 Oct 2025 17:12:29 +0200 
From: "Wolfgang Wallner" <wolfgang.wallner@br-automation.com>
To: u-boot@lists.denx.de
Cc: "Bernhard Messerklinger" <bernhard.messerklinger@br-automation.com>,
 "Wolfgang Wallner" <wolfgang.wallner@br-automation.com>,
 "Marek Vasut" <marek.vasut+renesas@mailbox.org>,
 "Martin Schwan" <m.schwan@phytec.de>,
 "Masahiro Yamada" <yamada.masahiro@socionext.com>,
 "Mattijs Korpershoek" <mkorpershoek@kernel.org>,
 "Michal Simek" <michal.simek@amd.com>, "Simon Glass" <sjg@chromium.org>,
 "Tom Rini" <trini@konsulko.com>
Subject: [PATCH 4/9] boot: kconfig: Fix typos
Date: Fri, 24 Oct 2025 17:12:00 +0200
Message-ID: <20251024151219.100970-5-wolfgang.wallner@br-automation.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251024151219.100970-1-wolfgang.wallner@br-automation.com>
References: <20251024151219.100970-1-wolfgang.wallner@br-automation.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on BRSMTPINTERN2/InternSMTP(Release
 14.0FP3 HF8|December 13, 2024) at 10/24/2025 05:12:29 PM,
 Serialize by Router on BRSMTPINTERN2/InternSMTP(Release 14.0FP3 HF8|December
 13, 2024) at 10/24/2025 05:12:29 PM,
 Itemize by SMTP Server on BRSMTP01/Eggelsberg/AT/B&R(Release 14.5|June 06,
 2025) at 10/24/2025 05:12:26 PM,
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

Fix typos in boot/Kconfig.

Signed-off-by: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
---

 boot/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 022ec05de0a..9adb051400f 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1780,7 +1780,7 @@ menu "Image support"
 config IMAGE=5FPRE=5FLOAD
 	bool "Image pre-load support"
 	help
-	  Enable an image pre-load stage in the SPL.
+	  Enable an image pre-load stage.
 	  This pre-load stage allows to do some manipulation
 	  or check (for example signature check) on an image
 	  before launching it.
@@ -1812,7 +1812,7 @@ config IMAGE=5FPRE=5FLOAD=5FSIG
 	  u-boot.
=20
 config SPL=5FIMAGE=5FPRE=5FLOAD=5FSIG
-	bool "Image pre-load signature support witin SPL"
+	bool "Image pre-load signature support within SPL"
 	depends on SPL=5FIMAGE=5FPRE=5FLOAD && IMAGE=5FPRE=5FLOAD=5FSIG
 	select SPL=5FFIT=5FSIGNATURE
 	select SPL=5FRSA
--=20
2.51.1

