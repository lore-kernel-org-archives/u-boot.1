Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83FB1EC0461
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 09:18:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 234A283F69;
	Tue,  3 Mar 2026 10:18:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=lixiang.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=lixiang-com.20200927.dkim.feishu.cn header.i=@lixiang-com.20200927.dkim.feishu.cn header.b="0sbuRC5c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 692CA83F6D; Tue,  3 Mar 2026 07:29:48 +0100 (CET)
Received: from lf-2-36.ptr.blmpb.com (lf-2-36.ptr.blmpb.com [101.36.218.36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84BE883F75
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 07:29:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=lixiang.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=suruitong@lixiang.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lixiang-com.20200927.dkim.feishu.cn; t=1772519375;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=75szUCEjcFpJhEXcP9ETTkDaWTeZNLlAsCzi8g83xUk=;
 b=0sbuRC5cICTWdfD9XU68gpfcz45Y+k9W031y9dMx7YYgnqn4zkBFPqyDz4E5eMu9ruzJMg
 yr+YPigg4b1ku6nc7lbsFKP1XkPNp/GPEfQgTJ/qvTaZsSmsbtZO80/guwPIIz+pQFDKIN
 ymw0IAAS3n0iHXuRnppdPJXnJibYHDd5OpVF0BkRtnTJkuLQz0gZF9X0FDFWj6vsLklced
 J6OueNDvOnGof+LAkYo7YrhrxQz0uxZv0FmNMEMdmv2C0mhkBmpAcJZs2Ka+JSkRo1jq58
 M5YnSadTfAxNj/SzXYjsASVTTsl1beclcOM+3ufkX/+BiXBv6KPv0sCcGr5qNQ==
Cc: <mkorpershoek@kernel.org>, <trini@konsulko.com>, 
 "Ruitong Su" <suruitong@lixiang.com>
References: <20260303062926.3335004-1-suruitong@lixiang.com>
From: "Ruitong Su" <suruitong@lixiang.com>
Subject: [PATCH 2/2] fastboot: Wire UFS backend into command and getvar
 dispatch
X-Lms-Return-Path: <lba+269a67fcd+7a9b10+lists.denx.de+suruitong@lixiang.com>
Received: from SSOC4-SH.company.local ([220.248.55.70]) by smtp.feishu.cn with
 ESMTPS; Tue, 03 Mar 2026 14:29:32 +0800
To: <u-boot@lists.denx.de>
Date: Tue,  3 Mar 2026 14:29:26 +0800
Message-Id: <20260303062926.3335004-3-suruitong@lixiang.com>
Mime-Version: 1.0
X-Original-From: Ruitong Su <suruitong@lixiang.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260303062926.3335004-1-suruitong@lixiang.com>
X-Mailman-Approved-At: Tue, 03 Mar 2026 10:17:57 +0100
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hook the UFS flash backend into the fastboot command dispatcher
(flash, erase) and the getvar partition-size/has-slot lookup path.

This follows the same IS_ENABLED() pattern used by the existing
MMC, NAND, and SPI flash backends in fb_command.c and fb_getvar.c.

Signed-off-by: Ruitong Su <suruitong@lixiang.com>
---
 drivers/fastboot/fb_command.c | 8 ++++++++
 drivers/fastboot/fb_getvar.c  | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
index 18d86988f4c..aaf5b1eaf6a 100644
--- a/drivers/fastboot/fb_command.c
+++ b/drivers/fastboot/fb_command.c
@@ -12,6 +12,7 @@
 #include <fb_mmc.h>
 #include <fb_nand.h>
 #include <fb_spi_flash.h>
+#include <fb_ufs.h>
 #include <part.h>
 #include <stdlib.h>
 #include <vsprintf.h>
@@ -354,6 +355,10 @@ static void __maybe_unused flash(char *cmd_parameter, =
char *response)
 	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_SPI))
 		fastboot_spi_flash_write(cmd_parameter, fastboot_buf_addr,
 					 image_size, response);
+
+	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_UFS))
+		fastboot_ufs_flash_write(cmd_parameter, fastboot_buf_addr,
+					 image_size, response);
 }
=20
 /**
@@ -378,6 +383,9 @@ static void __maybe_unused erase(char *cmd_parameter, c=
har *response)
=20
 	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_SPI))
 		fastboot_spi_flash_erase(cmd_parameter, response);
+
+	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_UFS))
+		fastboot_ufs_erase(cmd_parameter, response);
 }
=20
 /**
diff --git a/drivers/fastboot/fb_getvar.c b/drivers/fastboot/fb_getvar.c
index e8aa0e09aa6..d761592eb57 100644
--- a/drivers/fastboot/fb_getvar.c
+++ b/drivers/fastboot/fb_getvar.c
@@ -10,6 +10,7 @@
 #include <fb_block.h>
 #include <fb_nand.h>
 #include <fb_spi_flash.h>
+#include <fb_ufs.h>
 #include <fs.h>
 #include <part.h>
 #include <version.h>
@@ -135,6 +136,11 @@ static int getvar_get_part_info(const char *part_name,=
 char *response,
 						     response);
 		if (r >=3D 0 && size)
 			*size =3D disk_part.size * disk_part.blksz;
+	} else if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_UFS)) {
+		r =3D fastboot_ufs_get_part_info(part_name, &dev_desc,
+					       &disk_part, response);
+		if (r >=3D 0 && size)
+			*size =3D disk_part.size * disk_part.blksz;
 	} else {
 		fastboot_fail("this storage is not supported in bootloader", response);
 		r =3D -ENODEV;
--=20
2.50.1

=E5=A3=B0=E6=98=8E=EF=BC=9A=E8=BF=99=E5=B0=81=E9=82=AE=E4=BB=B6=E5=8F=AA=E5=
=85=81=E8=AE=B8=E6=96=87=E4=BB=B6=E6=8E=A5=E6=94=B6=E8=80=85=E9=98=85=E8=AF=
=BB=EF=BC=8C=E6=9C=89=E5=BE=88=E9=AB=98=E7=9A=84=E6=9C=BA=E5=AF=86=E6=80=A7=
=E8=A6=81=E6=B1=82=E3=80=82=E7=A6=81=E6=AD=A2=E5=85=B6=E4=BB=96=E4=BA=BA=E4=
=BD=BF=E7=94=A8=E3=80=81=E6=89=93=E5=BC=80=E3=80=81=E5=A4=8D=E5=88=B6=E6=88=
=96=E8=BD=AC=E5=8F=91=E9=87=8C=E9=9D=A2=E7=9A=84=E4=BB=BB=E4=BD=95=E5=86=85=
=E5=AE=B9=E3=80=82=E5=A6=82=E6=9E=9C=E6=9C=AC=E9=82=AE=E4=BB=B6=E9=94=99=E8=
=AF=AF=E5=9C=B0=E5=8F=91=E7=BB=99=E4=BA=86=E4=BD=A0=EF=BC=8C=E8=AF=B7=E8=81=
=94=E7=B3=BB=E9=82=AE=E4=BB=B6=E5=8F=91=E5=87=BA=E8=80=85=E5=B9=B6=E5=88=A0=
=E9=99=A4=E8=BF=99=E4=B8=AA=E6=96=87=E4=BB=B6=E3=80=82=E6=9C=BA=E5=AF=86=E5=
=8F=8A=E6=B3=95=E5=BE=8B=E7=9A=84=E7=89=B9=E6=9D=83=E5=B9=B6=E4=B8=8D=E5=9B=
=A0=E4=B8=BA=E8=AF=AF=E5=8F=91=E9=82=AE=E4=BB=B6=E8=80=8C=E6=94=BE=E5=BC=83=
=E6=88=96=E4=B8=A7=E5=A4=B1=E3=80=82=E4=BB=BB=E4=BD=95=E6=8F=90=E5=87=BA=E7=
=9A=84=E8=A7=82=E7=82=B9=E6=88=96=E6=84=8F=E8=A7=81=E5=8F=AA=E5=B1=9E=E4=BA=
=8E=E4=BD=9C=E8=80=85=E7=9A=84=E4=B8=AA=E4=BA=BA=E8=A7=81=E8=A7=A3=EF=BC=8C=
=E5=B9=B6=E4=B8=8D=E4=B8=80=E5=AE=9A=E4=BB=A3=E8=A1=A8=E6=9C=AC=E5=85=AC=E5=
=8F=B8=E3=80=82
Disclaimer: This email is intended to be read only by the designated recipi=
ent of the document and has high confidentiality requirements. Anyone else =
is prohibited from using, opening, copying or forwarding any of the content=
s inside. If this email was sent to you by mistake, please contact the send=
er of the email and delete this file immediately. Confidentiality and legal=
 privileges are not waived or lost by misdirected emails. Any views or opin=
ions expressed in the email are those of the author and do not necessarily =
represent those of the Company.

