Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A10606A31C
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 17:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OS3hkG9z;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=epdS6GLl
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 145F560A6F;
	Thu, 29 Oct 2026 17:36:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hbGiijpVP0Lm; Thu, 29 Oct 2026 17:36:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5A53460A71
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793295382;
	b=mU27KreY36XiHU4grw8+8x1SN1yaHQ8hk2+9fWHtsHPim6E3bFmyjBCUG7aA6FeJ+xYB
	 ET1PTZLmGxe85/D7Yr7mxXJI32PuSSreN8+jQdQgUdG+PrZlFpagERXWjASuwqK7HaIgP
	 Az0FhfWR6FIByYaaLEOnhSgAo6aS6VL2J/AgfOSTn7Qxy9yY1SiUArf6ndGKUTlLRNhTV
	 4XRaofNMFodz/zVp1sIB43MQiFTvkQaepMDLN9lG7iFBk25Y7BLoo+hxq0LSib726v3gX
	 x2DO/FhhzmPnwzv9SMoks0f28O3zOjNLY6mGtqr1Iy3x2Z3k7AHtxT8HU2oaH9XlzFw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793295382;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=SXQXG9IH7BYi3xkfXisJxzUeDxDT67mQ0JUG0v7pz5U=;
	b=hzk1HreHl/O32yF3jqKBK5ltulkEAYSLYvhPFSrprKgwa3sOMckGMIXzxXjgV6W4mUrt
	 8y7VkGzQgWdIoUFdWuf8V0m0Xh6qPDRud/OWCUa06pE5tR8izjHmLK5Qbu/4HaquWBx9e
	 jny6iuTDzk7AKXr1M5+YCyOPVbVysTbuNTS96/SP+ix/t5qQbLU1vj1rmBgidrrXQ/96n
	 Cu1fAoSMMG9E4gB9wVt2pj5/V5mGYnf5DBcBDWVDorcOHHZpHXLDkaY1r6WDk9631vc8V
	 cZ4IlByRo++MNz6fw1HYiQpjaF/e3CXlwVn1MFWkopwcYOEhI9qxpUoOtzM2ou64wVg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793295382;
	bh=SXQXG9IH7BYi3xkfXisJxzUeDxDT67mQ0JUG0v7pz5U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OS3hkG9zOR4lIHPTw4q2oUInRoAruQyss1dcH6CDkpmC/yo6djdQe3RH/w5b7hbex
	 vyO2Pm4myCK2MAvRCuqzI15a4WwgLlFAq5WvKTzPeGcho+79HQhrezYz36T6xL5p5J
	 tLaC8CveTToB64kJaONdu3cQe72+2HSlyKiXP7ZwdA3Gq9WEccOYJ5AXTIV6bHtfql
	 onTE1ewGKFnc93NePOZPU8+yCl6rFokaGftG9aY3vgnBjcK648e9Ex2wxzHhYokPfp
	 Lg1vvXEjOAh1CjOGuN5mDfn0T3c3A6zamvtJC1MWMYfjVCw9SaBJi2OEuCCYwW0BpL
	 NR3Fi8rgQigIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A53460A71;
	Thu, 29 Oct 2026 17:36:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 68D02120
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:36:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5A57F81090
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:36:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7z-wVY9g8iTB for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 17:36:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2B7D280AD3
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793295378;
 b=oDWsiFrw2HnPLgzY435zWc2U4jI2GbGAtr99EnKWFPUA1682wKqV+YC2KLa5ZjE0tiY7
 l4GsbyXsm0Q4fuhOAOkF2dBvKy0tafLS+sdaQJQgSt6Fzba/YhYY0tGdwvk/3ui32HV60
 mqzhv+g3nK2BiYStV0t53n1qiqBM7LpJVE+tDO/C7SWkvemoUkJ8f+NRs9b0x9z2ww31Y
 vDr8gywXgpCfzrt/5oWTsxVUpuXP2KQXkXsUqc0Pn3JetusPt5fOcvtyzpSL9Epmiw9aD
 4JZiqIheefZkq8OIFOANkrgKEHlwn8HBV7kyRDS0t7/Ta1rWkLfpJrvZqVbIAt9sDMQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793295378;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
 bh=SXQXG9IH7BYi3xkfXisJxzUeDxDT67mQ0JUG0v7pz5U=;
 b=O7PnYHAnmRp1mBml0WmL0s/OxWPke5hX1aVnGPWw/Siki2SZEN+v9IKg0lzbfQZX0l+A
 C9v1Wobr3RroDEYoFZ18Qh0zN4n+NNqIgtoCiNJQ7fy/ekMiwwnux16TNAimWNP5Sc0uS
 aoVlZR5qEIers0X/H5tre8F1F0N6BBAkfmZG/uOUE/08II+3EcyprDU25EiY5p7EmQQIi
 f8fIygD/6NfSfLYEjrtkiCAgiXyIpROTC7BQW6qGc9tHHMVCAAtgOwuLiuWiO2OWcgW/n
 lW1cs71nHhUiNSMSo34aCVvJ3drfI0VjUpCJnwDnB0vxdmvCONeNqolprwN2789WsFA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=bootlin.com;
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=epdS6GLl; 
 arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=epdS6GLl
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2B7D280AD3
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:36:17 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 289E74E4139E;
 Thu, 29 Oct 2026 17:36:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id EFD916076A;
 Thu, 29 Oct 2026 17:36:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6D6C0103290E9; Thu, 29 Oct 2026 18:36:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793295369; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=SXQXG9IH7BYi3xkfXisJxzUeDxDT67mQ0JUG0v7pz5U=;
 b=epdS6GLltXXB3QR98pjKKgA7P+oVhyvRAL3tnQ4DtAYxIjKn2KgRM85YNRcTrxUtDeDK1G
 s0fOkKcB+Fc67Ic94bH+LVpKuGmtCFMTnbB5pGMJD0ayT9x+8Pa+jbUmLPAzH/HzN2JiJ2
 w2bVapWGbcZcZJkScerrCcos7SViKBgPBYcGpo51Rh+Ghru/jVAv6n9bP4TNqpMxX+89FU
 FcEuHTwR8rtcowO3j9SFV9MZ+qEIveoiW85jrAePoXG5abcz0Gjtke7nbVqbXpmcDUogl0
 p7mSDsTgg1JE35lbVgSgSpXqDyh21PNHoX/z6radtkJOIFWC++MBEhkqZVNbGA==
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Date: Thu, 29 Oct 2026 18:35:28 +0100
Subject: [PATCH v6 5/9] doc: imx: ahab: add AHAB introduction
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261029-imx93-secureboot-v6-5-27b9c987e25f@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=31516;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=i/L2l+LCEWBxqbhDGJ3HZPMVdbJND0cAMUF8stb1xOg=;
 b=owEBbQKS/ZANAwAKASsAXqAbWo8DAcsmYgBq44PsfeODWgti+Rz2+jZHbYOfKihS5fINqHDxb
 gpQucMcNEmJAjMEAAEKAB0WIQT7FK2Qhtu4QpBIBAkrAF6gG1qPAwUCauOD7AAKCRArAF6gG1qP
 A2DZD/wNWxczfVtnFk7cKYzJ2sQ092PV6OmuSgeG0we+xEovLZzSpyFaq2iB0eu0pTeceR+z7vH
 uZgIa5+LysQjXuVTln4COM9lW2+7fx2y685yVhq3i4ha4Ovvh09MwaDXxDU+FFiS2d9iSu7nd+o
 vB2NrL2gLm5Rr88Clr4sPl/kbJdBmRz9AOmJLGPiT7lVB0pG5GRtKolJcTSelm4XBZpcTlWWk5z
 Gp3IlVULvlqVBIrLLzSctZvmr8oQrO5gnSL5by/vpBcL5Ml4cOVevfcet8nlAP2eevsA3xPReF0
 emGbNEpzjquXx6SI88CvuXDy4IFl0S4mm4QIeRdvlPJicepskLhVi7MbWlBA6jFVtGclrStMvRG
 94U8syGxS0JMDyDJiZaNEg0QxRIQRLoQPj26HOzVQDznOX35X4gN3wqjrsAZmFfNSlM8GaGo2I+
 fauukTgCtM/aMYNlnoBmlParZMzqc9eKJ0DvHoe7cysd9DkPaRwWSQShizEmiNajOl5Kl0JEJpV
 J+y1MDVSF9GPloVLJAh93/73CzZyhFkmdP/YiMDXNsItgeW7AgOZ7OAswjNg5bsXWa/Vi4i4YSb
 Vjr/v3GVMeYFGmRkaHPOp+FRlIJq9Vn9/sgE1hHhphxR7ET8UEb0mRRGX/k5dJh1ns4cdiFck7a
 uuiNJ0brZCcbWmA==
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add an introductory document describing the AHAB (Advanced High
Assurance Boot) secure and encrypted boot flow, covering the
following topics:
- AHAB architecture overview (SCU, SECO, PKI tree)
- AHAB secure boot and encrypted boot flow
- PKI tree generation (ahab_pki_tree)
- SRK Table and SRK Hash generation (srktool)
- SRK Hash fuse programming and sanity check notes
- i.MX 8ULP/93 secure boot support

This is based on doc/imx/ahab/introduction_ahab.txt from uboot-imx
(lf_v2026.04). Originally written by Breno Lima, with contributions
from Ye Li, Vanessa Maegima, and Utkarsh Gupta upstream in
uboot-imx.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Jérémie Dautheribes (Schneider Electric) <jeremie.dautheribes@bootlin.com>
---
 doc/board/nxp/index.rst            |   1 +
 doc/imx/ahab/introduction_ahab.rst | 459 +++++++++++++++++++++++++++++++++++++
 doc/imx/index.rst                  |  13 ++
 3 files changed, 473 insertions(+)

diff --git a/doc/board/nxp/index.rst b/doc/board/nxp/index.rst
index b11730e1eac..07cf9b220d9 100644
--- a/doc/board/nxp/index.rst
+++ b/doc/board/nxp/index.rst
@@ -31,6 +31,7 @@ NXP Semiconductors
    mx6ul_14x14_evk
    mx6ullevk
    nbxv3
+   i.MX AHAB secure boot <../../imx/index>
    rproc
    psb
    quickboot
diff --git a/doc/imx/ahab/introduction_ahab.rst b/doc/imx/ahab/introduction_ahab.rst
new file mode 100644
index 00000000000..e6376229383
--- /dev/null
+++ b/doc/imx/ahab/introduction_ahab.rst
@@ -0,0 +1,459 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+i.MX Secure and Encrypted Boot using AHAB
+=========================================
+
+1. Introduction
+---------------
+
+The i.MX 8/8x/8ULP/9x family of applications processors introduce a new secure
+boot concept. Due to the multi-core architecture, the Security Controller (SECO)
+and System Control Unit (SCU) in i.MX 8/8x, and EdgeLock secure enclave (ELE)
+in i.MX 8ULP/9x are heavily involved in the secure boot process.
+
+Step-by-step guides are available under doc/imx/ahab/guides/ directory,
+users familiar with AHAB architecture and CST PKI tree generation should
+refer to these documents instead.
+
+1.1 The AHAB Secure Boot Architecture
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The Advanced High Assurance Boot (AHAB) feature relies in digital signatures to
+prevent unauthorized software execution during the device boot sequence. In
+case a malware takes control of the boot sequence, sensitive data, services and
+network can be impacted.
+
+The AHAB authentication is based on public key cryptography in which image
+data is signed offline using one or more private keys. The resulting signed
+image data is then verified on the i.MX processor using the corresponding
+public keys. The public keys are included in the final binary and the SRK
+Hash is programmed in the SoC fuses for establishing the root of trust.
+
+In i.MX8 and i.MX8x families the SCU is responsible to interface with the boot
+media, managing the process of loading the firmware and software images in
+different partitions of the SoC. The SECO is responsible to authenticate the
+images and authorize the execution of them.
+
+1.1.1 [i.MX 8/8x] The System Control Unit (SCU)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The System Control Unit SCU is a subsystem equipped with a programmable M4
+core, which is responsible to handle the resource allocation, power, clocking,
+IO configuration and muxing.
+
+The SCU is also responsible to interface between the rest of the system. In the
+secure boot flow the SCU interfaces with the Security Controller (SECO),
+requesting the image authentication.
+
+The System Control Unit FW (SCFW) is responsible to control all the
+functionalities of the SCU. This firmware is distributed in a porting kit form.
+Instructions to download the SCFW Porting Kit are available in the Linux BSP
+Release Notes.
+
+Details about SCU can be found in the processors Reference Manual (RM).
+
+1.1.2 [i.MX 8/8x] The Security Controller (SECO)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The SECO is a M0+ core dedicated to handle the SoC security subsystem. The
+controller communicates with SCU domain through a dedicate message unit (MU).
+
+The SECO has a dedicate ROM which is responsible to initialize low level
+security features and to authenticate the SECO firmware previously loaded by
+the SCU ROM.
+
+The SECO firmware provides security services at run-time to different domains
+of the SoC, one of these being the capability of authenticate images.
+
+The SECO firmware is signed and distributed by NXP and is always authenticated
+in OEM open and closed configuration, instructions to download the SECO FW are
+available in the Linux BSP Release Notes.
+
+Details about SECO can be found in the processors Security Reference Manual
+(SRM).
+
+1.1.3 [i.MX 8ULP/9x] The EdgeLock secure enclave
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+EdgeLock Secure Enclave is the security subsystem based on a dedicated core
+(RISC-V) to manage security tasks with a tight control on security resources
+along with other enhancements.
+
+The secure enclave has a dedicate ROM which is responsible to initialize low
+level security features and to authenticate the secure enclave firmware
+previously loaded by the boot management core.
+
+The secure enclave firmware provides security services at run-time to different
+domains of the SoC, one of these being the capability of authenticate images.
+
+The secure enclave firmware is signed and distributed by NXP and is always
+authenticated in OEM open and closed configuration, instructions to download
+this FW are available in the Linux BSP Release Notes.
+
+Details about EdgeLock secure enclave can be found in the processors Security
+Reference Manual (SRM).
+
+.. note::
+
+   The terms Sentinel, S400, and EdgeLock secure enclave (ELE)
+   are used interchangeably throughout the document.
+
+1.2 The image container
+~~~~~~~~~~~~~~~~~~~~~~~
+
+Due to the new architecture, multiple firmwares and software are required to
+boot AHAB supporting devices. In order to store all the images in a single
+binary the container image structure is used.
+
+At least two containers are needed for the boot process, the first container
+must include only the Security Subsystem FW (SECO/ELE FW provided by NXP).
+Additional containers can contain one or multiple images, depending on the
+users specific application.
+
+The final binary is generated by the binman tool.
+
+1.3 The i.MX8/8x secure boot flow
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+As mentioned in the introduction, due to the multiple cores architecture the
+i.MX8 boot sequence involves SCU ROM, SCFW, SECO ROM, and SECO FW.
+
+The diagram below illustrate the secure boot flow overview:
+
+.. code-block:: text
+
+   System Controller   │  Security Controller  │     Cortex-M     │   Cortex-A
+         (SCU)         │        (SECO)         │                  │
+                       │                       │                  │
+    ╔═════════════╗    │   ╔═════════════╗  ┌───────────┐       ┌─────────┐
+    ║   SCU INIT  ║    │   ║  SECO INIT  ║  │  │        │       │ │       │
+    ╚══════╤══════╝    │   ╚══════╤══════╝  │  │        v       │ │       v
+           │           │          │         │  │  ┌──────────┐  │ │ ┌────────────┐
+    ╔══════╧══════╗    │          │         │  │  │ Start M4 │  │ │ │  Start AP  │
+    ║Load SECO FW ║    │          │         │  │  │   IMG    │  │ │ │    IMG     │
+    ╚══════╤══════╝    │   ╔══════╧══════╗  │  │  └──────────┘  │ │ └─────┬──────┘
+           ├──────────────>║Auth SECO FW ║  │  │                │ │       │
+    ╔══════╧══════╗    │   ╚══════╤══════╝  │  │   ┌────────────┘ │       │
+    ║ Load SCU FW ║    │          │         │  │   │              │       │
+    ║   and DCD   ║    │          │         │  │   │              │ ┌─────┴──────┐
+    ╚══════╤══════╝    │   ┌──────┴──────┐  │  │   │              │ │    Load    │
+           ├──────────────>│ Auth SCU FW │  │  │   │              │ │ Add AP IMG │
+           │           │   │   and DCD   │  │  │   │              │ └─────┬──────┘
+    ╔══════╧══════╗    │   └──────┬──────┘  │  │   │              │       │
+    ║   Run DCD   ║<──────────────┤         │  │   │              │       │
+    ╚══════╤══════╝    │          │         │  │   │      ┌───────────────┤
+           │           │          │         │  │   │      │       │       │
+    ╔══════╧══════╗    │          │         │  │   │      │       │       │
+    ║ Load M4 IMG ║    │          │         │  │   │      │       │       │
+    ╚══════╤══════╝    │   ┌──────┴──────┐  │  │   │      │       │       │
+           ├──────────────>│ Auth M4 IMG │  │  │   │      │       │       │
+    ╔══════╧══════╗    │   └──────┬──────┘  │  │   │      │       │ ┌─────┴──────┐
+    ║ Load AP IMG ║    │          │         │  │   │      │       │ │     Run    │
+    ╚══════╤══════╝    │   ┌──────┴──────┐  │  │   │      │       │ │ Add AP IMG │
+           ├──────────────>│ Auth AP IMG │  │  │   │      │       │ └────────────┘
+    ╔══════╧══════╗    │   └─────────────┘  │  │   │      │       │
+    ║Start SCU FW ║    │ ┌──────────────────┘  │   │      │       │
+    ╚══════╤══════╝    │ │                     │   │      │       │
+           │           │ │   ┌─────────────────────┘      │       │
+    ┌──────┴──────┐    │ │   │                 │          │       │
+    │  Start M4   ├──────┘   │     ┌──────────────────────┘       │
+    └──────┬──────┘    │     │     │           │                  │
+           │           │     │     │           │                  │
+    ┌──────┴──────┐    │     │     │           │                  │
+    │  Start AP   ├──────────┘     │           │                  │
+    └─────────────┘    │           │           │                  │
+           ┌───────────────────────┘           │                  │
+           │           │                       │                  │
+           v           │                       │                  │
+    ┌─────────────┐    │   ┌─────────────┐     │                  │
+    │Request SECO ├───────>│ Auth AP IMG │     │                  │
+    └─────────────┘    │   └─────────────┘     │                  │
+                       │                       │                  │
+
+Notes: All boxes enclosed by double dash (═) are performed at SCU/SECO ROM
+level.
+
+The sequence below explains the i.MX8 and i.MX8x boot flow:
+
+1. At reset, the SCU ROM and SECO ROM both start execution.
+2. The SCU ROM reads the boot configuration and loads the SECO FW (First
+   container) from the boot media to the SECO TCM.
+3. A message is sent by the SCU ROM via MU requesting the SECO ROM to
+   authenticate the SECO FW which is signed using NXP key.
+4. The SCU ROM loads the second container from the boot media, this container
+   must contain at least the SCFW which is signed using the OEM keys.
+5. The SCU ROM loads the SCFW to the SCU TCM, a message is sent via MU
+   requesting the SECO FW to authenticate the SCFW and DCD table.
+6. The SCU ROM configures the DDR and loads the M4 and AP images included in
+   the second container to their respective load addresses.
+7. The SCU ROM request the SECO FW to authenticate the M4 image.
+8. The SCU ROM request the SECO FW to authenticate the AP image. This image
+   is the initial AP core software, depending in the U-Boot target it can
+   be the U-Boot and ATF or only SPL.
+9. The SCFW is initialized and starts the ARM Cortex-M and Cortex-A cores.
+10. From this point additional containers can be loaded by Cortex-M and
+    Cortex-A cores and authenticated by SECO, the AP SW must interface with
+    SCU by calling the sc_misc_seco_authenticate() API function. In current
+    U-Boot implementation the additional image can be the Linux Kernel binary
+    or the U-Boot proper and ATF.
+
+1.4 The i.MX 8ULP/9x secure boot flow
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The secure boot sequence involves multiple cores booting up at same time and
+EdgeLock secure enclave ensure authentication of any boot software being loaded.
+
+The diagram below illustrate the secure boot flow overview for dual boot
+scenario in i.MX 8ULP:
+
+.. code-block:: text
+
+       Cortex-M(CM)      │   EdgeLock Secure   │    Cortex-A(CA)   │   uPower(uP)
+                         │    Enclave(ELE)     │                   │
+              │          │          │          │         │         │        │
+       ┌┬─────┴─────┬┐   │   ┌┬─────┴─────┬┐   │         │         │ ┌┬─────┴─────┬┐
+       ││   INIT    ││   │   ││   INIT    ││   │         │         │ ││   INIT    ││
+       └┴─────┬─────┴┘   │   └┴─────┬─────┴┘   │         │         │ └┴─────┬─────┴┘
+              │          │          │          │  ┌┬─────┴─────┬┐  │        │
+       ┌┬─────┴─────┬┐   │          │          │  ││Load CA FW ││ ┌──────┐  │
+       ││Load uP FW ││   │          │          │  └┴─────┬─────┴┘ ││     │  │
+       └┴─────┬─────┴┘   │          │          │         │        ││ ┌┬──v──┴─────┬┐
+              │          │   ┌┬─────┴─────┬┐   │┌────────┤        ││ ││Load &Start││
+              ├─────────────>├│Auth uP FW ││   ││        │        ││ ││   uP FW   ││
+              │          │   └┴─────┬─────┴┘   ││        │        ││ └┴───────────┴┘
+       ┌┬─────┴─────┬┐   │          │          ││        │        ││
+       ││Load CM  FW││   │          ├────────────────────┼────────┘│
+       └┴─────┬─────┴┘   │          │          ││        │         │
+              │          │   ┌┬─────┴─────┬┐   ││        │         │
+              ├─────────────>├│Auth CM FW ││   ││ ┌┬─────┴─────┬┐  │
+              │          │   └┴─────┬─────┴┘   ││ ││Start CA FW││  │
+       ┌┬─────┴─────┬┐   │          │          ││ └┴─────┬─────┴┘  │
+       ││Load ELE FW││   │          │          ││        │         │
+       └┴─────┬─────┴┘   │          │          ││        │         │
+              │          │   ┌┬─────┴─────┬┐   ││        │         │
+              ├─────────────>├│Auth ELE FW││   ││        │         │
+              │          │   └┴─────┬─────┴┘   ││ ┌┬─────┴─────┬┐  │
+       ┌┬─────┴─────┬┐   │          │          ││ ││ Load SPL  ││  │
+       ││Start CM FW││   │          │          ││ └┴─────┬─────┴┘  │
+       └┴─────┬─────┴┘   │          │          ││        │         │
+              │          │   ┌┬─────┴─────┬┐   ││   ┌────┤         │
+              │          │   ││Auth CA FW │┤<───┘   │    │         │
+              │          │   └┴─────┬─────┴┘   │    │    │         │
+              │          │          │          │    │    │         │
+              │          │   ┌┬─────┴─────┬┐   │    │    │         │
+              │          │   ││ Auth SPL  │┤<───────┘    │         │
+              │          │   └┴─────┬─────┴┘   │         │         │
+              │          │          ├─────────────────┐  │         │
+              │          │          │          │      │  │         │
+              │          │          │          │  ┌┬──v──v─────┬┐  │
+              │          │          │          │  ││  Run SPL  ││  │
+              │          │          │          │  └┴───────────┴┘  │
+
+The diagram below illustrate the secure boot flow overview for single boot
+scenario in i.MX 9x:
+
+.. code-block:: text
+
+       Cortex-A(CA)      │   EdgeLock Secure   │    Cortex-M(CM)
+                         │    Enclave(ELE)     │
+              │          │          │          │         │
+       ┌┬─────┴─────┬┐   │   ┌┬─────┴─────┬┐   │         │
+       ││   INIT    ││   │   ││   INIT    ││   │         │
+       └┴─────┬─────┴┘   │   └┴─────┬─────┴┘   │         │
+              │          │          │          │  ┌┬─────┴─────┬┐
+              │          │          │          │┌>││   INIT    ││
+              │          │          │          ││ └┴─────┬─────┴┘
+       ┌┬─────┴─────┬┐   │          │          ││        │
+       ││Load ELE FW││─────────────>│          ││        │
+       └┴─────┬─────┴┘   │          │          ││        │
+              │          │   ┌┬─────┴─────┬┐   ││ ┌┬─────┴─────┬┐
+              │          │   ├│Auth ELE FW││   ││ ││Start CM FW││
+              │          │   └┴─────┬─────┴┘   ││ └┴─────┬─────┴┘
+              │          │          │          ││        │
+       ┌┬─────┴─────┬┐   │          │          ││        │
+       ││Load CM  FW││   │          │          ││        │
+       └┴─────┬─────┴┘   │          │          ││        │
+              │          │   ┌┬─────┴─────┬┐   ││        │
+              ├─────────────>├│Auth CM FW ││   ││        │
+              │          │   └┴─────┬─────┴┘   ││        │
+              │          │          │          ││        │
+              │          │          │───────────┘        │
+       ┌┬─────┴─────┬┐   │          │          │         │
+       ││Load  CA FW││   │          │          │         │
+       └┴─────┬─────┴┘   │          │          │         │
+              │          │   ┌┬─────┴─────┬┐   │         │
+              ├─────────────>├│Auth CA  FW││   │         │
+              │          │   └┴─────┬─────┴┘   │         │
+       ┌┬─────┴─────┬┐   │          │          │         │
+       ││Start CA FW││   │          │          │         │
+       └┴─────┬─────┴┘   │          │          │         │
+              │          │          │          │         │
+              │          │          │          │         │
+              │          │          │          │         │
+
+More details on the boot flow can be found in respective Security Reference
+Manual (SRM).
+
+2. Generating a PKI tree
+------------------------
+
+The first step is to generate the private keys and public key certificates.
+The AHAB architecture is based on a Public Key Infrastructure (PKI) tree.
+
+The Code Signing Tools package contains an OpenSSL-based key-generation tool
+under the linux64/bin/ directory. The ahab_pki_tree tool generates a PKI tree
+containing four Super Root Keys (SRKs) and can also include subordinate
+SGK keys.
+
+The AHAB supports multiple key algorithms. A new PKI tree can be generated by
+following the example below (the P-384 ECC key type is selected here):
+
+- Generating a P-384 ECC PKI tree with CST (starting from v4.0.0):
+
+  .. code-block:: console
+
+     $ ./linux64/bin/ahab_pki_tree
+     ...
+     Do you want to use an existing CA key (y/n)?:  n
+     Select the key type (possible values: rsa, rsa-pss, ecc, dilithium, ml-dsa, hybrid):  ecc
+     Enter length for elliptic curve to be used for PKI tree (Possible values p256, p384, p521):  p384
+     Enter the digest algorithm to use (Possible values: sha256, sha384, sha512, sha3-256, sha3-384, sha3-512):  sha384
+     Enter PKI tree duration (years): 10
+     Do you want the SRK certificates to have the CA flag set? (y/n):  n
+
+The diagram below illustrates the generated PKI tree:
+
+.. code-block:: text
+
+                            ┌─────────┐
+                            │   CA    │
+                            └────┬────┘
+                                 │
+                                 │
+        ┌───────────────┬────────┴────────┬───────────────┐
+        │               │                 │               │
+        │               │                 │               │
+        v               v                 v               v
+   ┌────────┐       ┌────────┐       ┌────────┐       ┌────────┐
+   │  SRK1  │       │  SRK2  │       │  SRK3  │       │  SRK4  │
+   └────────┘       └────────┘       └────────┘       └────────┘
+
+2.1 Generating a PKI tree including a subordinate SGK key
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The ahab_pki_tree tool can also generate a PKI tree containing subordinate
+keys for the SRKs. These keys can be used to verify the signature included in
+the final signed image.
+
+Set the CA flag when generating the SRK certificates.
+
+- Generating a P-384 ECC PKI tree with subordinate SGK keys using CST (starting
+  from v4.0.0):
+
+  .. code-block:: console
+
+     $ ./linux64/bin/ahab_pki_tree
+     ...
+     Do you want to use an existing CA key (y/n)?:  n
+     Select the key type (possible values: rsa, rsa-pss, ecc, dilithium, ml-dsa, hybrid):  ecc
+     Enter length for elliptic curve to be used for PKI tree (Possible values p256, p384, p521):  p384
+     Enter the digest algorithm to use (Possible values: sha256, sha384, sha512, sha3-256, sha3-384, sha3-512):  sha384
+     Enter PKI tree duration (years): 10
+     Do you want the SRK certificates to have the CA flag set? (y/n):  y
+
+The diagram below illustrates the generated PKI tree:
+
+.. code-block:: text
+
+                            ┌─────────┐
+                            │   CA    │
+                            └────┬────┘
+                                 │
+                                 │
+        ┌───────────────┬────────┴────────┬───────────────┐
+        │               │                 │               │
+        │               │                 │               │
+        v               v                 v               v
+   ┌────────┐       ┌────────┐       ┌────────┐       ┌────────┐
+   │  SRK1  │       │  SRK2  │       │  SRK3  │       │  SRK4  │
+   └────┬───┘       └───┬────┘       └────┬───┘       └───┬────┘
+        │               │                 │               │
+        v               v                 v               v
+   ┌────────┐       ┌────────┐       ┌────────┐       ┌────────┐
+   │  SGK1  │       │  SGK2  │       │  SGK3  │       │  SGK4  │
+   └────────┘       └────────┘       └────────┘       └────────┘
+
+2.2 Generating an SRK Table and SRK Hash
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The next step is to generate the SRK Table and its respective SRK Table Hash
+from the SRK public key certificates created in one of the steps above.
+
+In the AHAB architecture, the SRK Table is included in the signed image and the
+SRK Hash is programmed in the SoC SRK_HASH[511:0]/SRK_HASH[255:0] fuses.
+
+During the authentication process on the target device, the AHAB code verifies
+the SRK Table against the SoC SRK_HASH fuses. If verification succeeds, the
+root of trust is established and the AHAB code can proceed with image
+authentication.
+
+The srktool can be used to generate the SRK Table and its respective SRK
+Table Hash (certificate filenames must be separated by ',' without spaces).
+
+- Generating SRK Table and SRK Hash in Linux 64-bit machines:
+
+  - In i.MX 8/8x family, the expected SRK HASH is of 512 bit.
+
+    .. code-block:: console
+
+       $ cd crts/
+       $ export CA_CRT="sha384_secp384r1_v3_usr_crt.pem"
+       $ ../linux64/bin/srktool -a -s sha384 -t SRK_1_2_3_4_table.bin \
+             -e SRK_1_2_3_4_fuse.bin -f 1 -c \
+             SRK1_"$CA_CRT",SRK2_"$CA_CRT",SRK3_"$CA_CRT",SRK4_"$CA_CRT"
+
+  - In i.MX 8ULP/9x, the expected SRK HASH is of 256 bit.
+
+    .. code-block:: console
+
+       $ cd crts/
+       $ export CA_CRT="sha384_secp384r1_v3_usr_crt.pem"
+       $ ../linux64/bin/srktool -a -d sha256 -s sha384 -t SRK_1_2_3_4_table.bin \
+             -e SRK_1_2_3_4_fuse.bin -f 1 -c \
+             SRK1_"$CA_CRT",SRK2_"$CA_CRT",SRK3_"$CA_CRT",SRK4_"$CA_CRT"
+
+
+  Make sure the output contains the following line:
+
+    .. code-block:: console
+
+       Number of certificates    = 4
+
+- Optionally, users can check whether the SHA-512/SHA-256 digest of
+  SRK_1_2_3_4_table.bin matches SRK_1_2_3_4_fuse.bin:
+
+  .. code-block:: console
+
+     $ od -t x4 --endian=big SRK_1_2_3_4_fuse.bin
+     0000000 01b04697 0253376b 2066fe56 aaef9a91
+     0000020 e62e09d8 14fb7e36 d5b38d05 0982edab
+     0000040 7ada6576 2f6b4f59 1fd9347e 46e7305d
+     0000060 46e34bf0 89780bd1 c809e714 a17e2f4e
+
+     $ sha512sum SRK_1_2_3_4_table.bin
+     01b046970253376b2066fe56aaef9a91\
+     e62e09d814fb7e36d5b38d050982edab\
+     7ada65762f6b4f591fd9347e46e7305d\
+     46e34bf089780bd1c809e714a17e2f4e\
+     SRK_1_2_3_4_table.bin
+
+.. note::
+
+   The commands above cannot be used as reference to program the SoC
+   SRK_HASH fuses.
+
+3 Known limitations
+-------------------
+
+- Due to a limitation in i.MX8QXP B0 silicon it's not possible to use RSA
+  4096-bit SRK keys with an additional subordinate SGK key.
diff --git a/doc/imx/index.rst b/doc/imx/index.rst
new file mode 100644
index 00000000000..cc5f427de92
--- /dev/null
+++ b/doc/imx/index.rst
@@ -0,0 +1,13 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+i.MX AHAB secure boot
+======================
+
+This section provides documentation for the NXP i.MX AHAB (Advanced
+High Assurance Boot) secure boot mechanisms, covering the AHAB
+architecture introduction and the i.MX93 secure boot guide.
+
+.. toctree::
+   :maxdepth: 2
+
+   ahab/introduction_ahab

-- 
2.56.0

