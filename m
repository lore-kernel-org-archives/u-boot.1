Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7C6606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 17:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uth7oQ+3;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=KUHW4jIu
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 281988105C;
	Thu, 29 Oct 2026 17:36:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mcQvMohYnZ-O; Thu, 29 Oct 2026 17:36:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E179480BE2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793295390;
	b=PN2ZPJmX4zR0VzQWKfjqZpS4FE9dvVsTVvyZt8mYn5p7kEnvyvz96RA3iwVOLLeGHZNL
	 GCu+wcIlvqHyfsmc0NlJMTnrhE8f5HAdPialWazDJPxkalz0Q9d9rNUadFTXcLXlUrT7I
	 GqU9mVpS+q1CaHYXAo2B/fCu52bX4i7yiMGLy3qqA1hes3GdLg6j1EFu6LBE2JOe6EXX4
	 gnJLhiqOechxbDJAW04AtRP1m18a/hs/2dmFoUjmrQ1HwGAj8vlFemMhlVNigYBkZ3pKU
	 acg0/iBMZGsmQTIde31qgS0ymN09euQerTSGI4ECM4LUvuDgZ5qKlWNmPgDAEAvN7GQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793295390;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ht8yGAaVnDW1X13l/yastMrVK5YGrTqy9txgKHoTm8o=;
	b=kLL1DtswRKkRZQ12r7pXwtl7aV6nA7tLhIwBuahfxlsWSvxDu0dJ2flRsebet8soqI7C
	 Gq+6IWa4Fo2pnTbq+41e3Yl+7JqnkKMTU+HMDJkEOwZxHN1ZBYzxtAxSO0ablyEtykFJz
	 Mpt+Tum+TpfQXnWYnzu8JkQKu4WFbBDobg8LpJV+CavaEeLyOxiqyA0IUrc3FOvlXJGzV
	 2fk0Af9fbN5ccCh/RH8w+biFOYHtNGu2tFfc3PnM0J/ky+sHAqZb+fTooCyUw2so2t+i5
	 Yd+SOzx4wQd62SFDRF7V/09KfUI1NOMFbZikA6jl8jwwHhoUO++QbhuEKKdejFoDrBw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793295390;
	bh=ht8yGAaVnDW1X13l/yastMrVK5YGrTqy9txgKHoTm8o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uth7oQ+3q/EP4Q3xi6g40braNtZ9/aHWd7c32/eNfGOD5JRT4ETSvmk/iDZKUpVxr
	 ubaZBgT8TUnVOG9HyWGlFt63nTI9JyXzdAuxVDjnq3HTmZJQU6ZPSbT6l6XCMiXdpq
	 976ktkfdx98HGV/MruJWWv9CON6+ZoNlPgXuPn5IZ+IZHAVvT2Xh/vvPbIx3NfeSOt
	 o+DnoEUGIXphb4/DrnbanYeSFsUdPygrzDHhrZdxAHVnvjbQDXxc8IxdoPJgzWEvcQ
	 lHNqX2sGP4A8XJDeECitAwBxC5WtEPHDf/sj+6nmSI4aRG3lBpso8wUKxR19gK4Pwh
	 f2JLTOK+Ys/1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E179480BE2;
	Thu, 29 Oct 2026 17:36:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 403082FE
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:36:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 226F860A72
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:36:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Aph2VvKsz3_v for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 17:36:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5F90360A79
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793295383;
 b=OkCFnat3lDENvLNb000yOgsVh5+w+uMPSyS+l0PjN153xdUBSy/+jzlLBqYS6R/ZPkNq
 f561HiBaNN/gIF3EOXTWCvuJxQXQ8bkJfhohVwnF2h3Gwi3YiyLQv9HZDgAAkjQHrU8A/
 qYoHq/847Wq3LqZtoNAUaMppCRxTDykzn/78JFeDKl+4Qhie+ygNg90v6lwYnqeJmae50
 ioAOLVGC+wsZmX3wAl4jgByxl6gJoFfTtU+R5bq2L/syJAn7bvV5zd2Ewj6KyiTAbTm8K
 DGcDe3jX7YdZno8Y1dpIa+/GrIbRt2Mx/ons+6kCFcs5muxnM1CYqWGtI6Yw/kNopBw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793295383;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
 bh=ht8yGAaVnDW1X13l/yastMrVK5YGrTqy9txgKHoTm8o=;
 b=Nxm4ITrbskL2tg8+hN109aEW1SPZWoIhztlRNN9dGCY0ClC0M4xQnqD90RuCHxdhn5bL
 lF/dbMRvFhKRw+m7YBbPfrFkII47LTAuPjz5dh+K9A+xQUpFZ4F5tH1ZSdMvneB4B/Knu
 yHj76kTIfZGeEb0zxYODfDyoGxH4AaMKLo7pNmiTeVHpf5wOdleTRgZqMHN1KEaJU2x8g
 YU1VZKS1R2CCfSePNf6sBRCuORWy0L8e0235FUsoTNeg8jJEwKdicsAWMlqx3fGrqWy1p
 ULLRZsGu7xVoFXbO3sLvc4h8x2x6V8lqUT52de5CU7+WgOwpyn1SMB0KdPni8R8v2Eg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=bootlin.com;
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=KUHW4jIu; 
 arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=KUHW4jIu
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5F90360A79
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:36:22 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id D3B201A13AA;
 Thu, 29 Oct 2026 17:36:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id A75996076A;
 Thu, 29 Oct 2026 17:36:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 212DF10329125; Thu, 29 Oct 2026 18:36:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793295378; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=ht8yGAaVnDW1X13l/yastMrVK5YGrTqy9txgKHoTm8o=;
 b=KUHW4jIuz4wVt5IN9eI3fuabGt87IV2DdTaSApkDuVYpvsdY3/BwEpfZdHWPFviRpZ5TUO
 9p9czRNJ47D8uadZe8iKuRqrN+8AGgEYWC3DCTLiccS9wlv8E5ZxqIkea1fvIFemVgk8dz
 C+FrB36Lt6PgCXcvT8uc1fdBYAG5BRX7fElG3ut9n6EmnBL7wZOJRN469cOCbcbEd1W/a5
 3b3W3uplq2vlyJh1WS6BqutjYjCKF2q4OPoFURbyS/ufxp4DJSTsjesbpwqqodcaJ7QgXv
 Ao7TsisMt4W7ZB+XMU6SSyDpuYAkn0d+qtEhrVFrtXln/1HxtT7erLvN7Z7nxw==
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Date: Thu, 29 Oct 2026 18:35:29 +0100
Subject: [PATCH v6 6/9] doc: imx: ahab: add i.MX93 secure boot guide
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261029-imx93-secureboot-v6-6-27b9c987e25f@bootlin.com>
References: <20261029-imx93-secureboot-v6-0-27b9c987e25f@bootlin.com>
In-Reply-To: <20261029-imx93-secureboot-v6-0-27b9c987e25f@bootlin.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org
Cc: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Marek Vasut <marex@nabladev.com>, Denis Mukhin <dmukhin@ford.com>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?utf-8?q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>, 
 Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Simona Toaca <simona.toaca@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Christophe Guerreiro <christophe.guerreiro@non.se.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Lei Xu <lei.xu@nxp.com>, Joseph Guo <qijian.guo@nxp.com>, 
 Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=14044;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=jJ7gs2LjQshJGoW0FRPUhOc4Y0VSaZXLvPNMbhcrTZg=;
 b=owEBbQKS/ZANAwAKASsAXqAbWo8DAcsmYgBq44PtYZ+y5MnmYZhq52D+1vRz2C75auVymGrk1
 Y28e53rBn+JAjMEAAEKAB0WIQT7FK2Qhtu4QpBIBAkrAF6gG1qPAwUCauOD7QAKCRArAF6gG1qP
 AxI9D/9yDGpR3IHaNEgZnQTyWq2o1QlaDAjtbyQFDIbOYCDLAeYBKP/tErITmt8pGeLCFX9sNfq
 E/lfxzX6fA5cWnsXdZW6dIlTOcKxtfjHim9/ZG3K3r4jGPJdLId3Ln2o30XtjaVIoUz9pDlyQEX
 GSCjJtfrV/n6jpwmmRMOPwWWYo3lfyWj7i1HVR7eYvcDfwueqDrF22Ohawpf3n/PocB78REYnUE
 BFTq/wABONR49vRLLXQSwAmJ6iWgyIkT1lCL6zOCFWzt0/XqrBcX5RvXPGQx0S3wm7SCHD5OFfL
 lH8zq6FaDaUMF3mrnWwlQoZHzch0Ew0j8weqEXFVvAWgDpjdUK8YrChNMVxHtA1EqWu5HjP2vaE
 UNPzwTBVEy0f87ZYkYQawi955JDqvkcHTsIl6FGEzDRxlmplMLwvI8U3wJBh9u/A/I+fsN6ViZ0
 8mtbCHSjScN4W+/cXAX6MiY5uC04eg6+mZ0hGeDgckI/4H7eUneRP56fYbQ6W32dN2JG1mgcaLb
 4ZtCJz7BLKAPj93xngYd8WMCAta6LVFbeHoIcJV5SzJMuSKQPhtTEE6uNpHgT1ZwoIUg8c+86t8
 dSe+PoifAM/VJoHMLHGqdJ7UeKv9lRyIApFoLxmth2eK55IjGb4el0DK92yPywVE8fdWWaqd0qa
 tPIGRygNl8ITHWQ==
X-Developer-Key: i=jeremie.dautheribes@bootlin.com; a=openpgp;
 fpr=FB14AD9086DBB842904804092B005EA01B5A8F03
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a step-by-step guide describing how to securely boot an i.MX93
image using AHAB.

This guide is largely based on the following documents:
  - doc/imx/ahab/guides/mx8ulp_9x_secure_boot.txt, from uboot-imx
  (lf_v2026.04), originally written by Utkarsh Gupta
  - doc/imx/habv4/guides/mx8m_spl_secure_boot.txt, from this tree,
  originally written by Marek Vasut

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Jérémie Dautheribes (Schneider Electric) <jeremie.dautheribes@bootlin.com>
---
 doc/imx/ahab/guides/mx93_secure_boot.rst | 297 +++++++++++++++++++++++++++++++
 doc/imx/ahab/introduction_ahab.rst       |   3 +-
 doc/imx/index.rst                        |   1 +
 3 files changed, 300 insertions(+), 1 deletion(-)

diff --git a/doc/imx/ahab/guides/mx93_secure_boot.rst b/doc/imx/ahab/guides/mx93_secure_boot.rst
new file mode 100644
index 00000000000..bfc17b7ad79
--- /dev/null
+++ b/doc/imx/ahab/guides/mx93_secure_boot.rst
@@ -0,0 +1,297 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+i.MX93 Secure boot guide using AHAB
+===================================
+
+This document provides a step-by-step guide on how to securely boot an
+i.MX93 boot image. It is assumed that the reader is familiar with basic
+AHAB concepts and with the PKI tree generation. Details about AHAB can be
+found in the :doc:`AHAB introduction <../introduction_ahab>` document and
+in the processor Security Reference Manual (SRM). The i.MX93 signing
+procedure is integrated in the U-Boot build thanks to binman.
+
+1. Preparing the environment to build a secure boot image
+---------------------------------------------------------
+
+Secure boot image preparation requires the U-Boot build system to build
+the image and the Code Signing Tool (CST) to sign it.
+
+The following files are needed to prepare the boot image:
+
+  - EdgeLock secure enclave Firmware (ELE) (Optional).
+  - DDR PHY initialization firmware.
+  - U-Boot proper and SPL.
+  - ARM Trusted Firmware (ATF).
+  - OPTEE (Optional)
+
+The ELE FW is distributed by NXP and is already signed using NXP keys.
+In the following sections, <work> designates the repository where all
+parts have been downloaded and built.
+
+2. Preparing U-Boot to support AHAB secure boot features
+--------------------------------------------------------
+
+The U-Boot/SPL provides extra AHAB supported functionalities that include
+extension of Root of Trust, checking any events(issues) after image
+authentication, chip lifecycle status, securing the target etc.
+
+The support is enabled by adding CONFIG_AHAB_BOOT to the defconfig file
+used by your target:
+
+  - Defconfig:
+    CONFIG_AHAB_BOOT=y
+  - Kconfig:
+    ARM architecture -> Support i.MX9 AHAB features
+
+Enabling this feature allows the SPL and U-Boot images to extend the Root
+of Trust by using the AHAB API call via ELE FW. It also enables binman to
+automatically sign the SPL and U-Boot containers while building
+flash.bin, as described in the next sections.
+
+3. i.MX93 AHAB image layout
+---------------------------
+
+The i.MX93 flash.bin image is built by binman and is composed of up to
+three containers. The ELE FW container is optional and is provided by NXP,
+it is appended at the beginning of the image when the file
+mx93a1-ahab-container.img is present in the build directory. The SPL and
+U-Boot containers are built by the nxp-imx9image etype and signed by the
+nxp-imx93cst etype.
+
+.. code-block:: text
+
+              *start ----> +---------------------------+ ---------
+                           |   1st Container header    |   ^
+                           |       and signature       |   |  Authenticated at
+                           +---------------------------+   |  ELE ROM/FW Level
+                           |          Padding          |   |
+                           +---------------------------+   |
+                           |           ELE FW          |   v
+       *start + 0x400 ---> +---------------------------+ ---------
+                           |   2nd Container header    |   ^
+                           |       and signature       |   |  Authenticated at
+                           +---------------------------+   |  ELE ROM/FW Level
+                           |          Padding          |   |
+                           +---------------------------+   |
+                           |            SPL            |   v
+                           +---------------------------+ ---------
+                           |   3rd Container header    |   ^
+                           |       and signature       |   |  Authenticated at
+                           +---------------------------+   |  SPL Level
+                           |          Padding          |   |
+                           +---------------------------+   |
+                           |    ARM Trusted FW (ATF)   |   |
+                           +---------------------------+   |
+                           |       U-Boot proper       |   |
+                           +---------------------------+   |
+                           |      OPTEE (optional)     |   v
+                           +---------------------------+ ---------
+
+The first container includes the ELE FW which is signed using NXP keys,
+this container is authenticated by ELE ROM.
+
+The second container includes the SPL which is signed using OEM keys,
+this container is authenticated at ELE FW level.
+
+The third container includes the U-Boot proper and the ATF. The SPL is in
+charge to load this container and also to interface with ELE FW to
+authenticate the additional container.
+
+The signing procedure is slightly different when compared with HABv4
+series. On AHAB the signature is directly included in the container, the
+CST is responsible to sign and handle the "Signature Block":
+
+.. code-block:: text
+
+               +----------------------------+ ---------
+               |                            |  ^
+               |                            |  |
+               |      Container header      |  |
+               |                            |  |
+               |                            |  |
+               +---+------------------------+  |
+               | S | Signature block header |  | Signed
+               | i +------------------------+  |
+               | g |                        |  |
+               | n |                        |  |
+               | a |        SRK table       |  |
+               | t |                        |  |
+               | u |                        |  v
+               | r +------------------------+ ---------
+               | e |       Signature        |
+               |   +------------------------+
+               | B |                        |
+               | l |        SGK Key         |
+               | o | Certificate (optional) |
+               | c |                        |
+               | k |                        |
+               +---+------------------------+
+
+The certificate block is divided into:
+
+.. code-block:: text
+
+                      +---------------+ ^
+                      |  Public key   | | Signed
+                      |  Permission   | |
+                      +---------------+ v
+                      |   Signature   |
+                      +---------------+
+
+The first block (public key permission) verifies the Signature block
+preceding (between SRK table and Certificate blocks), while the second
+block (signature) is verified by the SRK table block.
+
+In case not using the subordinate key, the container signature is
+verified against the SRK keys directly.
+
+4. Signing the images
+---------------------
+
+Internally, Command Sequence Files (CSF) are used. The CSF files contain
+all the commands that the AHAB executes during the secure boot. These
+commands instruct the AHAB code on which memory areas of the image to
+authenticate, which keys to install and use, and so on. The CSF is generated
+using the CST Code Signing Tool based on input configuration file. This
+tool input configuration file is generated using binman, and the tool
+is invoked from binman as well.
+
+The SPL and U-Boot containers built by the nxp-imx9image etype are each
+wrapped in their own nxp-imx93cst node and signed individually by the CST
+tool. For each container, the container header address and the signature
+block offset are read from the i.MX container header itself, so the offsets
+in the CST configuration file are always correct, whether the ELE FW is
+bundled in the SPL container or not.
+
+Per default the AHAB keys and certificates need to be located in the
+build directory, this means creating a symbolic link or copying the
+following files from the AHAB PKI tree directory into the u-boot build
+directory for the CST Code Signing Tool to locate them:
+
+- ``crts/SRK_1_2_3_4_table.bin``
+- ``crts/SRK1_sha384_secp384r1_v3_usr_crt.pem``
+- ``keys/SRK1_sha384_secp384r1_v3_usr_key.pem``
+- ``keys/key_pass.txt``
+
+See the :doc:`AHAB introduction <../introduction_ahab>` document for the
+PKI tree generation procedure (ahab_pki_tree tool) and for the SRK Table
+generation (srktool).
+
+The nxp-imx93cst etype is configurable using either DT properties or
+environment variables. The following DT properties and environment
+variables are supported. Note that environment variables override DT
+properties.
+
+.. list-table::
+   :header-rows: 1
+
+   * - DT property
+     - Variable
+     - Description
+   * - ``nxp,srk-table``
+     - ``SRK_TABLE``
+     - full path to ``SRK_1_2_3_4_table.bin``
+   * - ``nxp,srk-crt``
+     - ``SRK_KEY``
+     - full path to the SRK certificate ``SRK1_sha384_secp384r1_v3_usr_crt.pem``
+
+
+The SRK private key (``SRK1_sha384_secp384r1_v3_usr_key.pem``) and the
+``key_pass.txt`` file, which contains the passphrase protecting the private
+keys, are required by the CST tool as well, and will be searched for in
+relation to the SRK table and certificate paths.
+
+When the key material is not located in the build directory, environment
+variables can be set to point the build process to it. In the example
+below, CST_DIR designates the CST installation directory, that is the
+directory holding the crts/ and keys/ directories generated when creating
+the PKI tree:
+
+.. code-block:: console
+
+   $ export CST_DIR=<path_to_cst_dir>
+   $ export SRK_TABLE=$CST_DIR/crts/SRK_1_2_3_4_table.bin
+   $ export SRK_KEY=$CST_DIR/crts/SRK1_sha384_secp384r1_v3_usr_crt.pem
+   $ make flash.bin
+
+5. Programming SRK Hash
+-----------------------
+
+As explained in the :doc:`AHAB introduction <../introduction_ahab>`
+document, the SRK Hash fuse values are generated by the srktool and
+should be programmed in the SoC SRK_HASH[255:0] fuses.
+
+Be careful when programming these values, as this data is the basis for
+the root of trust. An error in SRK Hash results in a part that does not
+boot.
+
+The U-Boot fuse tool can be used for programming eFuses on i.MX SoCs.
+
+- Dump SRK Hash fuses values in host machine:
+
+  On i.MX93 family, the SRK Hash uses sha256 and dump 8 words fuses:
+
+  .. code-block:: console
+
+     $ od -t x4 SRK_1_2_3_4_fuse.bin
+     0000000 db2959f2 90dfc39c 53394566 e0b75829
+     0000020 85e6f3b1 af00983d e5e804fe 7a451024
+
+- Program SRK_HASH[255:0] fuses:
+
+On i.MX93:
+
+.. code-block:: console
+
+   => fuse prog 16 0 0xdb2959f2
+   => fuse prog 16 1 0x90dfc39c
+   => fuse prog 16 2 0x53394566
+   => fuse prog 16 3 0xe0b75829
+   => fuse prog 16 4 0x85e6f3b1
+   => fuse prog 16 5 0xaf00983d
+   => fuse prog 16 6 0xe5e804fe
+   => fuse prog 16 7 0x7a451024
+
+6. Verify AHAB events
+---------------------
+
+If the fuses have been burned properly, there should be no AHAB events
+after boot. To validate this, power on the board, and run ahab_status
+command on U-Boot terminal.
+
+No events should be returned after this command:
+
+.. code-block:: console
+
+   => ahab_status
+   Lifecycle: 0x00000008, OEM Open
+
+           No Events Found!
+
+7. Close the device
+-------------------
+.. warning::
+
+   Before closing the device, please ensure your sample is in OEM Open state,
+   OEM SRK hash has been fused, and you are able to boot a signed image
+   successfully without any AHAB events reported . If not, your sample will be
+   unrecoverable.
+
+After the device successfully boots a signed image without generating any
+AHAB security events, it is safe to close the device. The chip lifecycle
+should be changed from OEM open to OEM closed. Be aware this step can
+damage your board if a previous step failed. It is also irreversible. Run
+on the U-Boot terminal:
+
+.. code-block:: console
+
+   => ahab_close
+
+Now reboot the target, and run:
+
+.. code-block:: console
+
+   => ahab_status
+   Lifecycle: 0x00000020, OEM Closed
+
+           No Events Found!
diff --git a/doc/imx/ahab/introduction_ahab.rst b/doc/imx/ahab/introduction_ahab.rst
index e6376229383..621724711fb 100644
--- a/doc/imx/ahab/introduction_ahab.rst
+++ b/doc/imx/ahab/introduction_ahab.rst
@@ -292,7 +292,8 @@ scenario in i.MX 9x:
               │          │          │          │         │
 
 More details on the boot flow can be found in respective Security Reference
-Manual (SRM).
+Manual (SRM) and in the :doc:`i.MX93 Secure boot guide
+<guides/mx93_secure_boot>`.
 
 2. Generating a PKI tree
 ------------------------
diff --git a/doc/imx/index.rst b/doc/imx/index.rst
index cc5f427de92..daf846947cc 100644
--- a/doc/imx/index.rst
+++ b/doc/imx/index.rst
@@ -11,3 +11,4 @@ architecture introduction and the i.MX93 secure boot guide.
    :maxdepth: 2
 
    ahab/introduction_ahab
+   ahab/guides/mx93_secure_boot

-- 
2.56.0

