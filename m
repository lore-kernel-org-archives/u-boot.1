Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED62CA5FC5
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 13:43:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8E60660B34;
	Wed, 30 Sep 2026 13:43:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a4FNaXjVEgNj; Wed, 30 Sep 2026 13:43:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6100F60B23
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790775822;
	b=ReNStzrxGrmu/kaPvJgoC7QihUFWO3qoP9NYsH/RFC4nIr9gictEI20o/CloVTWGvOuC
	 0AhvYlJlsdEqUXBd/x7fIK7a2E6j88Urv/JbQngpXnWSnL+zowgDTO5GwwDJdcGyAGxrT
	 m4zuhHgikuTM0GLN1BTm7Czl7kY+29suc3w6KWP5roEBPr7MD/d/JoFWsv4S4qLgP0SXt
	 DjEMBf3d4gAqtkouUofsRZYGI0ZD5idu+s1AKc6gW5lkCePRnwcswyJcOAlaSKq5xnd8k
	 ArB3cMGu4d98kgmx8ylHoiFuUznZL/VuKaV+ca5BSOvb7BdLZwzhLaemUvUQ7HDqfXA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790775822;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=A6d6chuwoMqYM3brfrXBzroPAu0WIrdT53EgAbW5H54=;
	b=dsfq5CPMdpgnNtWuQ+kftN2vPuNi8TVYmsySZA4ocfykG0kr29my+O2Onnk1LOPfYeD2
	 KUVf0crCyeq+zdIZuBrMy/sAVpKu/Y3Ma+QlrMEczSIfPrJg4uZUxkzCsuEbZYRcuPaSI
	 Ycn5CKcvC6kJOVYjzmZiHNh8p6HCgcVF0YwEuh0z+WF0j4fqCFy1++WbRQ0+09cA2XgmY
	 6FQbVesFq/RMpTrY5ahX/+/0zHnsw1RUlya2y7D6xdT5POlwfuv1281XEOKT2FUgs8eAt
	 5UI4/cRXQbCesUbEXm6mPDueOfQ51Nc+2W8cag1jgCQNO4Lr1IkQQU9HUIVbHYfrNnA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790775822;
	bh=A6d6chuwoMqYM3brfrXBzroPAu0WIrdT53EgAbW5H54=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=v+EveXoU5LhrAWnyO5pxY6rZY2vLXjXhpvP43fPx1mVZIcYTGYIpefs3R/hr8lHcM
	 7kGp2CipeHxTSZoVYPuplEbdalpxClrpAdgp4xDPyJxsY8iTPqUm6xk0wIvqwhOJdM
	 Oophmzl+HrNTKOuodpLSF8CvDrYodCNqcGivWZJQWl5LdkthprSlGM/2UxVVrlg0SF
	 lXSfSV+Psv2PZsVZA0zaWI/82bZqgL4WNDFhO/21Eao9lapdyEowapSYxz9Ak6lPEH
	 Xa2+2+Hdi4GEYuPnpxvGQht/tAzKf1faRmGb1oTGtU1tVST3V3TOVkmO0545ws3fSI
	 SNXlxbH03EoXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6100F60B23;
	Wed, 30 Sep 2026 13:43:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 58BA33AC
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 13:43:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 567E3400AE
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 13:43:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yQmfDzZmjDPW for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 13:43:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org E0B844009F
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790775819;
 b=Nz5ZOW03TlbvoiOin8ZED1J7DOnFM5Wrml9jNBQEXP54MxUmmjpzPOwAV2kg9bGxz7g1
 N07IQOSZxK6JZr8mvnVD+Hk8mEC9FbJpcnz1LqV8gnD8ROJ4/1fPOXLKASQRb1tzndl8F
 Ws2UD0IVoXhoTI+9IJdveGdduEo/6hc7fQBoJPOoE28jBN5tLnZTqR0q0iz0pXCre4aH7
 C87M14RnHtTxe56ltmMTzzfC/h/H6dMRjp4O3qJRN49AHOZDLKiUmJiwKHrlH4lI1o3Pf
 iM3AZ5u2gjADz83HYsy6ST7kJt6fFwZuUrQADPyB3m1PRxwX/WoinruvI+4mlUPXPGA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790775819;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
 bh=A6d6chuwoMqYM3brfrXBzroPAu0WIrdT53EgAbW5H54=;
 b=tOYKcKpsZE5GsyDLZrFZIKvnK7lifSnkJvN8T5gqvFuH9CIabhJDO3pHs/eiLqVOzDRT
 Esrrk5BzNbkkmtMqoHgm/CJtCSsFjXw6tGAnd2B2+VxoRvrtxQzIVbq3c+wwMD2ccBKra
 DOrTQ6rTkgfD6dg1TyKU91ZLZ0Wpb1s1O5KwIfl4YxdsYEjAQQBXlNQeEWY6cFJ4UpToi
 RxAVkC/ELPplMY4nty2ja3jlRdJemL/eGBP3n0zELUL9LhSCXlzUGpcLE17stq7IGnp2+
 Iu6O9SDrspo/ZCrSW+VTb3UJiT2ChNfOFx8TY5+vbTDNTwQEFxrdPK2myZHVrAE6tJg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=Lx1nZrEp; 
 arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=Lx1nZrEp
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E0B844009F
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 13:43:38 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id A72CF1A107A;
 Wed, 30 Sep 2026 13:43:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7971A60749;
 Wed, 30 Sep 2026 13:43:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4618F103298C9; 
 Wed, 30 Sep 2026 15:43:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790775810; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=A6d6chuwoMqYM3brfrXBzroPAu0WIrdT53EgAbW5H54=;
 b=Lx1nZrEpaNiYLbN6FOonyc3y6neSj8bOGJHz2aC11jcLujTKiDn71Eq0Xs6wcboWwGN8Dh
 GD+JtnShaA5ilDkXhleo7V/+dsMsUfFi67YV6h3zokKVTB7b2ezUIPo7EYKM9r2uZ74W+u
 u4GBlN0TXrqUqfZh8Qt+wrH1rYoN0ZI3GImiHJJMx5aUqxVNK/mJF2V/exbyGjzhpr/GfL
 WxhoTiMQOCIncghKE6nwf7amv9QmpY3tN8CYEuL2vSxNHC7sQ44+2CX4Gnd4SOhUsdhvBh
 Xks1BbVLJPuwZ/I+HltbieTo/yRFvBNWPw3mhZUUj0SRLR8QbO6b1FW0UV0Vag==
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Date: Wed, 30 Sep 2026 15:42:39 +0200
Subject: [PATCH v4 6/9] doc: imx: ahab: add i.MX93 secure boot guide
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260930-imx93-secureboot-v4-6-f968a1b14dc5@bootlin.com>
References: <20260930-imx93-secureboot-v4-0-f968a1b14dc5@bootlin.com>
In-Reply-To: <20260930-imx93-secureboot-v4-0-f968a1b14dc5@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=13999;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=jnNWl4yQbY06jyLrkICDIB9Fx5qZDMn0CWRt+L0v+2Q=;
 b=owEBbQKS/ZANAwAKASsAXqAbWo8DAcsmYgBqvRHZwauACgh5MxL7QOfSlIkFqQQRe5ODIN8W8
 JbVMlIi/ZSJAjMEAAEKAB0WIQT7FK2Qhtu4QpBIBAkrAF6gG1qPAwUCar0R2QAKCRArAF6gG1qP
 A3QKEACcrYlq1/02xc91fTccLHTfJoAtAue/sb/3TpkNnCkmDIXXWExhL9xhCILQnDibV+HcFTJ
 mKwGRyIx68iMSnGIJIgu096OmIQWVUBCRSNe4fviuPCp3I2DpwCex1zHaPTJP/hbKdNAr0Vz0sl
 /a/bNYZP2yCsznFVOFeTI1enBfgxvyiUtQsCbJccH7P2C/p/Fur8+mUlvLp6RE8Q3kpRqTPSrp1
 NLPSF2+qv2AVyDk4D6doPMGrzt0pmB5mC5iiqv5N6jOzH/t9EQbiY+c4hXTVqRCu/VPYQxEneLw
 aqtpNFeFGMKykfEFHN2wBbL/mIf+/475iJGF/3WRf9SsKM8yzs9xRxncx4ZdaOTesziPc0on2ny
 JSPBlfHuE2tRPmT7h51ZxSZFXh9h6IOTfyU1IHMvvaMu+MSANegqv4e9PSbh/ZznsB7tAXffzDh
 lmxJKUKds0/fNDC23HKv5r8uCLKH+BTdOmyLMIQ73NnybLrssToSyyMAU/K+UFehxXJOFdnvfKS
 x2pu7o3gz8ILEWrxZ8NG4YyQCRsaOI2hGkPkRUcAFCmBr2t0g3BN4T7GWMiwhEoXgI2oDzCms91
 X2oItUEY5iC7rp64UxpOlD9Ay27AqKzcQIgicwd0XiNLplNp3V/6qopDMFV2RidNYRDqIwypJHs
 udzHjpDn+qACOMg==
X-Developer-Key: i=jeremie.dautheribes@bootlin.com; a=openpgp;
 fpr=FB14AD9086DBB842904804092B005EA01B5A8F03
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add a step-by-step guide describing how to securely boot an i.MX93
image using AHAB.

This guide is largely based on the following documents:
  - doc/imx/ahab/guides/mx8ulp_9x_secure_boot.txt, from uboot-imx
  (lf_v2026.04), originally written by Utkarsh Gupta
  - doc/imx/habv4/guides/mx8m_spl_secure_boot.txt, from this tree,
  originally written by Marek Vasut

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
2.55.0

