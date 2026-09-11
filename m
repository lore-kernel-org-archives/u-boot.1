Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57174C88E53
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 16:44:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AE2BF6068C;
	Fri, 11 Sep 2026 16:43:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id weTXFrZ-v7cT; Fri, 11 Sep 2026 16:43:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9EF1160625
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789145036;
	b=Jcwhv3ycm1pmCF4uWTSaxIhk/V5MnNdIUKFr708eRnv2v+bdPA+sS/ElSJHnPpVUtlEF
	 NCH7Mpkzq88wUmVnWzj7+q0/31xVAxA2N0VNkn3MzKgSeTfOwei01b/SOCSn9uUoJ6qbR
	 LZ67smaiAyAQWOqFcnKJ/H5vQ84YxNCIOTDEV3Jlpug3zyApS6pkbDXc6f4ROrDHXsfoW
	 fFhLJ8HYtvRIbTHsKIkFO+NtgY1tN+kdaEXrkfPCMXN++yM4CYhpD5KQS5Y7u64/KfyPd
	 hAgbvl8HDNK56G2zmjUcVNFc1UpcEdgOYHDUt2O95tf/h1A07xAF7MfiRI2J4gEGXKg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789145036;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1RMR0bo+ZNn/lyb6MApZld1Ja7OAS5A+Uz2nXc8AtkY=;
	b=WLsOVQW7jt9u+0cToZsX0a90935Zlom0kfoqF7Aifc8D/1BhuQ/tqI9g00U9jt5OMoFQ
	 ErwIqnqu3ZJzX5kBRcLRE4z5aQd8Gz3QF0OSwpqvRIspXFnDzOueRxUPHXrzFnbdW9sBZ
	 /KXgcU9+IBnfUdY4xfY7VfbzWyj26kcOB5zTU62Dkh1DU0MCWXiv75mcEK9LL/NDHlisW
	 gRwr4X9ih5PI3pWnMgjI3ebp/29Dfd7EarITGPCh1VTKRyVxLwe+qH7WdV8fRFnltsndD
	 rLoeG7JxK3+E8VXZUWDSbMdmVP30uWz0gf6feou6SURmSIJVN6QW1adH1aApkGT4ZiA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789145036;
	bh=1RMR0bo+ZNn/lyb6MApZld1Ja7OAS5A+Uz2nXc8AtkY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CwBTXw4VzM59DDtQflcF/zap0+rjy68F0mSZXnMgHxYATb93TCdbMTHisptN2jttz
	 U4MDc83rWiVR+zZ+fb8l5XIqmBQt6b2Iviwj08//j7VbT2f0e25hLRjn2hohl7EybJ
	 6ThGW3lnIyyUqiICqWiRAL+DCo/Bjai2Zok7zaTkvw/KG6SGBQJ2rIufhaz1MwEdbQ
	 u+B0Yhr2U4ngxmG0faMF8RtaVvQquxSMt5B/0VHeZGs4Iq6MqIbWRd20KV7hXGL4HY
	 MipQDFfF3zhU3ddef/xEGwdVic6it5czBKMgH83nm5yOaqiife8fQNgt86IjC2iZB6
	 OZlZTJ3Ww9TmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9EF1160625;
	Fri, 11 Sep 2026 16:43:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4FAC149D
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 16:43:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 35CBF4006B
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 16:43:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O-netfsrYGgk for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 16:43:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 41EF1402ED
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789145031;
 b=lnu7HcoZpgxOC0JS5kFBBtXqHZIDjlQs7x7R8uafYycL1o+AlZUX9ny09FmjVvv35ouc
 +ENOoQ9xVhcuGL6BUjDs9vpQ7KlzXiLWevA5h8YN/QgqhRFUoASI6N/4I3gh3cdqSkNXb
 k5bWLRT5FMi0wD0P6o0YhMe/Wvwg5Xg5KzJkJWlGplF/wZn2P7Y+mJnFSxSdRqjSJY41T
 u3oK9Gkb8Qt0eVZyO8VrH4KXSVBVHMVH9MZBh3PMGHc50j08BSR4UHquZ3WBxn6wvnX2X
 X9JJinU6T0A/050Nh0Q/oGI0//RIjtxdp5yMEJE8qQ31RCq20sxOKjOV7dXuPNctBWw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789145031;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
 bh=1RMR0bo+ZNn/lyb6MApZld1Ja7OAS5A+Uz2nXc8AtkY=;
 b=TvoYnRli6+rRBmkYDx+4mNbK7VzXL2L0rCa1M0MGnYYPeKxcLkGjB2gOZli70x5YFWJc
 r8kFM77JJi8GNiOofpPC8oj31W7zeW2f9/1wkgQ/cjUyW8J2fAg1olZBLIV6SR7Y/jVWf
 sEKFktzKbR4Msh2VFc/LdjHYsrg8Wv4miSmzppeCoD7pV3ozQrletXI+RAZCFNiA1LdP8
 WtKF9VGzxKpNjOIoYmmTpw6Y0sVRdF5TpY+i3zycVqyu5N1cex2rsr1S8qB5rKXDgik5u
 B2TIorpGPmgBW9L1zyDWQ9qNbBAeKtdaoeKqNwS6iUXNqDhfF2mqdOLQaLhV8LZi5HQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=HZgtviqA; 
 arc=none smtp.remote-ip=185.171.202.116
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.171.202.116;
 helo=smtpout-04.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=HZgtviqA
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 41EF1402ED
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 16:43:50 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id DDB87C63A10;
 Fri, 11 Sep 2026 16:37:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 11F29601A3;
 Fri, 11 Sep 2026 16:36:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BC45711C7AFAD; 
 Fri, 11 Sep 2026 18:36:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1789144598; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=1RMR0bo+ZNn/lyb6MApZld1Ja7OAS5A+Uz2nXc8AtkY=;
 b=HZgtviqARe5Q/h/1yl247J8/7YrJWOBw9OSJiwRw1SVZx6Rp8kA2tbenBOyFgfzvFXNP4D
 Xy4ciHtLzkuBKgSiM2VrwEVRWrjr73CMvDvCPisIqZMCHD95i1/rn6xC9ptGsc+K1FWpKm
 LgTJc95j9bJaOw6hE++Vuo39NLCAnP/zbA0MnTJJ6w+OSUXWS9jWJi0/XpFda6muVD0eJL
 UgPSfuoXr0APHHG0jUM0z40e7RvBAJzv2fB1DN5ltThicsLJPM1T3v9RhgG+tjylBIWgmw
 Ha8HywVO6fHxJvnGtipWQ/7q9iEp+H9wbuluj1WZdKprqOM3DsB8/U75YHbxRw==
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Date: Fri, 11 Sep 2026 18:35:09 +0200
Subject: [PATCH v3 6/7] doc: imx: ahab: add i.MX93 secure boot guide
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-imx93-secureboot-v3-6-542a99793af0@bootlin.com>
References: <20260911-imx93-secureboot-v3-0-542a99793af0@bootlin.com>
In-Reply-To: <20260911-imx93-secureboot-v3-0-542a99793af0@bootlin.com>
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
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=13687;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=VAXzv/6aJcsTuyH9V500nuB0RuGGO/XnJpXTZ+WyyjM=;
 b=owEBbQKS/ZANAwAKASsAXqAbWo8DAcsmYgBqpC3pVVUwifaXQwJe3UNevzmPJJoKJ3HVCNhoj
 5DQHuqPAGyJAjMEAAEKAB0WIQT7FK2Qhtu4QpBIBAkrAF6gG1qPAwUCaqQt6QAKCRArAF6gG1qP
 A3jFD/9ZWD/IWAxpxTxkzvQuHjkGHJ8T4ii+IfV+9X1afX7Hul7pJHHdspXrQLSiu3D3KK/W4Ir
 9P6a7HjnnmheezWWVm1LVkaO5LsfZCOBL4EMG6yugMjoVaN1+oOtYFSDUzPMhFROL3ZP/3rMmsr
 8RbZIaIBnBErnF9O5gEndFkvywq+CK/dG4RRFXb0i8DzR9cMIqEKzc8/mHPsz5274Y/5mVLcdC4
 0aZHY7wRnMLjfw/16Vl7lJJ+W6fARR9VUrgqVchUZ9elvQrj6eo/SHkCmf3HKe4NjyLsZgA9z5M
 H07dCjJu/TC1TSBpkJR3C5IN1xcSyMndzcpmRJeG5uCNtV8g4SVWETFg0qNgS6TM1MW1Xv0IgeD
 H2RPr22fkvsuVVjYo9nPWF3ct8+c3SbkRb/bZzpXqx1MIic+eB2dZ987xeKOxj87fB+CfVSYUYo
 RPPJtGvBgx64bWrLlXFWsbRu0QSjzzTTM4dr0eu7PqXK6VqRs+WEN+i2UlK1wiOxlDrKcAITvyu
 m5bydr8e+Ydg352+CJQBsrIm4/hteOhKxCtE6uTLS14CbLI1atO7TGE1arD2gN3AEcmTI3tFkQA
 coWVE+ebaR7XBCBkvpvRIyZFVTwJFeBuftfFc/vN5W83hxVvnB5PZwyKQYqHJQFwT2FPvcLyYHt
 yzBJ0Gqkm4nG5Ew==
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
 doc/imx/ahab/guides/mx93_secure_boot.rst | 294 +++++++++++++++++++++++++++++++
 doc/imx/ahab/introduction_ahab.rst       |   3 +-
 doc/imx/index.rst                        |   1 +
 3 files changed, 297 insertions(+), 1 deletion(-)

diff --git a/doc/imx/ahab/guides/mx93_secure_boot.rst b/doc/imx/ahab/guides/mx93_secure_boot.rst
new file mode 100644
index 00000000000..2a966ffed1b
--- /dev/null
+++ b/doc/imx/ahab/guides/mx93_secure_boot.rst
@@ -0,0 +1,294 @@
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
+The existing file structure is automatically collected by the nxp-imx93cst
+etype and submitted as a single signing operation: the container header
+and the signature block offsets are read from the i.MX container header,
+so the offsets in the CST configuration file are always correct, whether
+the ELE FW is bundled in the image or not.
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
+The paths to the SRK table and the certificate can be modified via
+changes to the nxp-imx93cst device tree node(s) or via the environment
+variables.
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
+The SRK private key (``SRK1_sha384_secp384r1_v3_usr_key.pem``) must be located
+next to the certificate so that can find it.
+
+Environment variables can be set as follows to point the build process
+to external key material:
+
+.. code-block:: console
+
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
index f6494e3c121..0da9f49f010 100644
--- a/doc/imx/ahab/introduction_ahab.rst
+++ b/doc/imx/ahab/introduction_ahab.rst
@@ -292,7 +292,8 @@ scenario in i.MX 9x:
               |          │          │          │         │
 
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

