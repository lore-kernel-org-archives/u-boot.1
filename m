Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82CDDCA5FD6
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 16:27:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 502BD60BF1;
	Thu,  1 Oct 2026 16:27:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BpeuFSw4V0JN; Thu,  1 Oct 2026 16:27:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0D15960A7F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790872034;
	b=bDk8+cvdHZc7mK6+N/3rT+tjqtFsD4bftV8YDWl5fnpNJ18wyEaRML2QyA7uv5KtaGc1
	 1WcK7GbZjO1sIymTJ3bagylqMhJbHumu4yNdZpxAeI3dA54OgWjQ3Xmy2iqbSa4yAn/r+
	 +w7pM5VGk+/TosDNO+Q+VRgHNnAW8LcjnL1q7GrFKDWqHi9jQrK6rSsdrE2laKWDbFgic
	 KGxGUlbJJnU+tTglks6CbsVplO5DWCx5H8ajO6pjBUYW0o6uZeh1fmfFPQCS3KO/moi0a
	 a1mjBKWFrn4I3XCzORqkfu1sbm8k1wTymuxPU9mTGTKYY3yA8b9GO1LJ4s4tgELIdlA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790872034;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=CUZczcwfYDlpjG9jeSYQOj45bjaIQzGLjXy7GRkyn1o=;
	b=FE5FUpBd89Bk1UAFtGukwxD7+lsmoSBT8P5gWQ8vZCpIWgzinpIr2XVDvVE+FWUwuLrc
	 nOYNH/wcV1BwaxSE5A68mtS8xvuX11cCQjoLd9atjbm0KArNlVs2RQs3e4TB/4QpG3Hx7
	 r994w48pb9CJYi3zxWQzDSsLrGLLFESNcJUi9f3s47geHuzDSluoUjzc99HQcrbsoZmyQ
	 Vo8y/fvufI/LpiJm25oCBDkehc7xfd9YyyA29D5ZXWQObzVb7sQASDh4MW9R73rORyA2C
	 0gNOf7tXyQ1yE602/kaEHhf0fA5nzibpcVs/gRqAzciN7RFDR2BXw2wOLYu9snzZrbg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=vMu40fkf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790872034;
	bh=CUZczcwfYDlpjG9jeSYQOj45bjaIQzGLjXy7GRkyn1o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fJZAKjwSflc959lDYBpPv7Mkiy5+stVQvNvu34jZNbTDR//7hrxfyJL3fiJh6uyKd
	 Drvgb2mlClKtorr+/zpt85+5s/BkUP4a54jF5VwBY7ptK7NnLD2AMkdwHBz1w0o9Ug
	 2ww1wzTY381dfRHie9shNb+GW7DFEJIIyNepEngNj3BpSwtIf3/J0ILu0D4pxq7zLg
	 fGCQdDsb8gXZOJ+cJTvj07NJev8+u8KaJqeVMUZS6LkRE03odSr3NQ9862J+1kQym6
	 RblpiHGqCojcObhrw746XuNVhu2v78aeyActg+EtGgoXjljo6KdVke9S0Ptv9TIX0K
	 7atRGT/R3Xgvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0D15960A7F;
	Thu,  1 Oct 2026 16:27:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BB006263
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:27:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A4F0360B0E
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:27:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LfsUg8jLb12s for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 16:27:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5EA0960A7F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790872029;
 b=KAhe7BIIw8MFNmW61g1gSOJugfQOfrFBkwbDAfkmdIQ5Fc6FTXc5rSgOB4dnEtJ7ZDSP
 3aTFJO4h4bdOH1iUiOoCEDJ9DKdjHzaM/lQahb0Va89q2SE524FR49gxtuaQkcRrG8I7n
 zDDZ3QEyS6GYWFLOogs/jfUAVwHyvhAF9IlxIJwvDsQFYJUI14kF4fU8VUT+SRfpOpIvC
 HDxYaC9kRrJuhRQo3pj/A34Cu/xRLximtHwkCwxBeo/V/YcLvPvuAAPnlGrTcDc/YL6dJ
 FLtbvcKab/iBXOSxldmL7U1CthQ+QDpVvSc1ICt3M0tqyE6z54FOARAOBYY9xKsdHIg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790872029;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
 bh=CUZczcwfYDlpjG9jeSYQOj45bjaIQzGLjXy7GRkyn1o=;
 b=SRJgjEbO6F9U/6peOPDDUPHSyoRMAQSvhiCCl8/r6g9J831/DcZPsa0HujN0C936OVJj
 pfUC2qkJEh+d3cvjgTG2FMbtwPYjQAH5lGr9KuUV42161jxMbGicnWCHp1l7WFrIiJTD8
 Hqc9nE0cCH+vszsXr2ig5jmcwi9OeCBySFHKhEE+hzv3aDQTZ48Ojj1Wd9a+lFfWplhXv
 ny6jTeuIoStzuBonzKnTCGFkuPYRKQmnoEkbcJHWu59SM1OCUos90u1LRfNzKueixoayR
 RbGkBbFdB1X2Wd02eUDhmHForOdRZVGel/6cKX+msdYmlyL8eProIlj3Uc3W7r/zl1g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=vMu40fkf; 
 arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=vMu40fkf
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5EA0960A7F
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:27:08 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 0256E4E4208F;
 Thu,  1 Oct 2026 16:27:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id CA80460343;
 Thu,  1 Oct 2026 16:27:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A2839103282DF; 
 Thu,  1 Oct 2026 18:27:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790872025; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=CUZczcwfYDlpjG9jeSYQOj45bjaIQzGLjXy7GRkyn1o=;
 b=vMu40fkfCafJW6CitIvDbFdRW8kqGoGoKGuhLz8L97UwNbzeXyWVT8yl6mpC05RAs/9U/y
 T3hoqDPsI4nv3DmEpzA9Bp+Sai8ZIO1y3TyxprtV9ivHL8IXyBxlAAMH+TrFEBDU2bkZqI
 7//JnI+1KJkeB1hN8/2m0/hmaXkQ5PBylQFn87aq88Wg+i7rE+NsBmSX1qkUOji26tIL93
 V0GrTvZfuYP3HSGJeSGgcMmtevjggnkRvjdCYZIA8zWn2ktb8cXz5DpyeJDjavCswBLdrh
 XyBRjmNrozc14uxvlmWxC1Wky7GMvBsVnO+yILul0qMIEJzZYV8IP/nJF9mg8A==
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Date: Thu, 01 Oct 2026 18:26:22 +0200
Subject: [PATCH v5 5/9] doc: imx: ahab: add AHAB introduction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261001-imx93-secureboot-v5-5-d97dea41bd1f@bootlin.com>
References: <20261001-imx93-secureboot-v5-0-d97dea41bd1f@bootlin.com>
In-Reply-To: <20261001-imx93-secureboot-v5-0-d97dea41bd1f@bootlin.com>
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
 bh=GFC9WCi75eCEVjSHP1dmmWqQmPQ/ubaZ4B4JGNRYS6w=;
 b=owEBbQKS/ZANAwAKASsAXqAbWo8DAcsmYgBqvom4QoihKhFgWPnSB9QiT9Fyb3/zESTXyFkir
 ATZruJwe42JAjMEAAEKAB0WIQT7FK2Qhtu4QpBIBAkrAF6gG1qPAwUCar6JuAAKCRArAF6gG1qP
 A6kmEACpZYmDWHHxt8ak2qW9KAjZ/BZghIWD3YdTNgw2U+u1EjS7x3rMRb7701PM4foE2gnK1IP
 faIVR+73i8FMv86Nrecv12X+45bVrS5LxvDsb0add+Hinb8/JHVNv0rYCNQxzh+PnGEGoljgSaU
 D91be/xj3ESIIbVNI4RPFrmQ7si/3rQ6/oxpzmFHA74KHve1YykQxe/XC6vCZ/yNmUN13brtfcx
 a00GXQXp4LiFUWQn+EvQGa98qY/WgD+ftxw1vLH/nUre6AFsWqwBDpnELcSU98GiOnEKtmFAa09
 FPowtaLiYYa7ajpF17jOpd9r0bolcnIQ8aF3B5gp/2LQCnxFAWi8gDC7eg8bhs6h6VY/jBplbpR
 J3ONhgu+UveJjfIaj/PkwKrTZ0dtVpHgWJl5Bf7zuZYKtUsXNcoiynJ+dlNsIYbw0xt1sHFgkxw
 NMFpIkIFzgmriDYuNIqBH0x6pIwOwJzfI3fslWsmxi1nNxr6wm3oGxZSfzeDSvE5nUInCsOTPwJ
 JdOo6Bo2sXdzOBhEPaSc7AeYy2NcXCuqRvqvV+fZAnZ/UJeuUmzEY0EiElxN7RDsZZwzGH+nyeB
 PUF/bdx5VrtGKhkomrIjfjlEO1uEn75MBRfsDVGGm1//R8yOapvyB9oYABKGioOlLp5ecd+JHVL
 eTP4mcMDilMz3sw==
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
2.55.0

