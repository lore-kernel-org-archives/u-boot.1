Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341C5C88E59
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 16:36:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CA56F606BA;
	Fri, 11 Sep 2026 16:36:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rp8IL7gX93w4; Fri, 11 Sep 2026 16:36:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org EB24F60662
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789144603;
	b=CrjVXGqNTWzQLKBXoEokF4yE4Vr82hH+HW/h8Vfkfv0uDT3tJmhUQ1h4bTqHMPWgPV/Y
	 1EX6tpVEPZ1JgbZcK2N+0nrJn9i8CTjThoWUrEV54kPyfpIfa7caupYwrJo5SeK/9vX/5
	 54EdcgtcgmQsMhsECRnKXIzfmVT4QRon9pmUTEISylnTH4ikFXtOK38fMUW50sT7qjC/q
	 fBKEhciivc8tT9LyCRnYEnzLYslb/fLbiqOoL/EgAKiphu1zRAORflqzHAjuTEymBHQAp
	 sC/GtpmxcmGj3hZtsrg8IZjgiL0Kg/cralyNfoDzcVgnfJTUJI1HUnj96YDPYDJWyVQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789144603;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=M9oPzfFrib0nv8MOhZT8qCg8grDM7qDEtO9sff1YpVk=;
	b=UcjmlZCEAYGJDModam7VFyADeLa8x3o21OuhA+2uc+neha96luCVO15SmuVKTBZPYDIc
	 EuRstGr9lqwdwghiaDbb1ZCgUetR8MPdc/vrl5wSdZOyta8a+J+mWWCqHRjnmJlmTbtvz
	 uWV0Tfbkrx4efeJ4u4fKRy09mopGvZ0TOzQQ8jos8N2KiqWwPsLCFLFmaTBM5zRJW4UuB
	 9UNr71T5emzIl33fNhmY3dUHxmlI1yu0E+ZgRqgQBkmI58k9mzvNs5U0oLv/+9dR5f5rZ
	 2ooTfXKdvXqA53edyTOHLuckkxMT5nwiAe77LzsIweGgwBuigottvkB382laRzLZLAA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789144603;
	bh=M9oPzfFrib0nv8MOhZT8qCg8grDM7qDEtO9sff1YpVk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OpURqG3YcKqwYbdqHg8UQs2kcExZ/yuww+/OisvMYFc0PsRe33s8SZ41P5gGYNIN9
	 GEza6U3vvwZivrEV6R7xBlTJeVF7DVYKNgHihF/04GGn9RGutoDpu68SZd1I3rDAcX
	 hHok9uxcMNmNSctmPP2mmAWbaOcC2RjdTBZ0S/cDUwllGSui1LR4kXNosTHPznobE3
	 bPw0BHe6up1yXXX+gspDcgr0WDH+xyRNTmO8VRckORl9kHqbQvbko3jJAKi6teC74N
	 7k1HAoni6FX/91/j4hTwfZGY0nyliXuQ3B9uLgc4MJ4NlQFKqQi2JpxIxAASI56s7f
	 ArYz8N0dymipA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EB24F60662;
	Fri, 11 Sep 2026 16:36:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 908E949D
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 16:36:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 76DEF407EC
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 16:36:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ge0JlO58K-us for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 16:36:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D7C18406A7
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789144599;
 b=T3g4dzrgdCS/Pp2AIk0OCa0NkRc2oz2H1JsPKrfh76JWVHwbAQ1nyXsXqyRQ56wirITx
 ShiBz1D37BWzPp0n7MYi4KfV2TACE/ABHF9BxfJ21TooIIRCMLAWbKMUY/fZGDcLi7cZ7
 qS/3c5ATTV4jk06bunBI9ChGfdCp8MGzf/TamsM3+Jp2KR8S3vElj3+SgOlWDBYaByIHB
 4gtz1sQXKkjeA0NZHBWTupg17rVfvrv0d6H8HqAp55TLDDRTBq4VwuT1X2qGlxl/X1SAP
 7cV9LodR4pinLjELAtCBQ/Ky1FV9erXbGQOM0P86I34N+S08viCDJ3fO8uVC/cvMdlg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789144599;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
 bh=M9oPzfFrib0nv8MOhZT8qCg8grDM7qDEtO9sff1YpVk=;
 b=IApk/2lgxPYTEhiRzdyOds8MHNTTsXhQA2eAaIIRaV3M9DE6v+/47359H3jHD+AYkxCG
 mCzLSV0lye+2nHPw9dlFyAfg+NC8yNprILNSrpWcS999ylN2fIL2OO/QZzpLAC1xE6T3c
 c1YL+YUj3d4JyDcu+38gNPp94LR8neYrGjGJEinZ1WnvDmKpTAPzC1DKvnM5+OY/UyFTF
 wm2nspQWUC0q6zAbyZTHgwuMSX2WbPRJPNxiAZHhaxooFN/d41Qe09G/BWrOXWWqH3ybv
 iaqtbnjVfr+7ln3n/fwVsy9DuJOQv5EqMxdGj2NpAgYmxUcAxrV5S+pfYGPLltLQkCg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=vH6PVeI5; 
 arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=vH6PVeI5
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D7C18406A7
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 16:36:38 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id B3EE84E401EF;
 Fri, 11 Sep 2026 16:36:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 87FEE601A3;
 Fri, 11 Sep 2026 16:36:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 84F6511C7AFC2; 
 Fri, 11 Sep 2026 18:36:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1789144591; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=M9oPzfFrib0nv8MOhZT8qCg8grDM7qDEtO9sff1YpVk=;
 b=vH6PVeI5zAjVSY1/JIYV56GRtSmEAVV064J1wKfmu+ra21Jne1abeZAeWDaWUfK+p71DVI
 olCQjjFBTg35/APf+S6azJapCMjitSU7cfP5Y/G0wrAwRBN0l9qQU6mu9kxXqBBsJKH0lu
 OrRpYf7QSW1wibmdM6a00PxWE7TxkReERtSS6Mch0mdQRiNUESyqZ0Umi5CVX9ZPDhYe2T
 fnuQHDJI0M5d39hQ0A+T8bVACiDlWoryqmw893HFBlGLZ45pkGE1ZND3fL9x857yLeusI+
 Cm/5lWtca17jb2wpuT+j0hlh5MkDshmAIbNskL+KrUAwhy/2dNCMNjDz5BY00Q==
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Date: Fri, 11 Sep 2026 18:35:08 +0200
Subject: [PATCH v3 5/7] doc: imx: ahab: add AHAB introduction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-imx93-secureboot-v3-5-542a99793af0@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=31447;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=n6LyultODkMXnez6FLqYE35G8A1MZ/9yUgoKlfepPAc=;
 b=owEBbQKS/ZANAwAKASsAXqAbWo8DAcsmYgBqpC3pPyJ8nH7qE9z8oEhhkQiy5Yk42lGRmaALS
 YiB14h85eWJAjMEAAEKAB0WIQT7FK2Qhtu4QpBIBAkrAF6gG1qPAwUCaqQt6QAKCRArAF6gG1qP
 AyqeD/4nhgkfWT4pmObBbcCssXZVcaEbLyDktCO+vQMIha6mv4GYLQIgME7trpQ9QQcSRF8OUgZ
 FTVcVv7jyMybMZpwt4LnAgzPHf4rXi5FUPYqWxHjtP9NmkBV5fqdARk/ClKNXuQJWy+EJaFTg7+
 lQdhoS56GOncvAbuEAR/Seg1duc9w1WhafbZNU32M/Z/RkGGS1ZshaqCi/kIXspDMu2TsiujLod
 3sWPYrBHNSEbDDLDDXVaWHbfnfrkVqK5FcBr7VHEcnbuuL0LovM5Q613VQG2Pi8qjfXPePTxEPM
 V0sGvwovWzqTDcEm7l5/inzKIHdRdeKhly/OkfSPcIn1JY6l/c2wpha4edfc0exS468APV+eRJm
 /lz88yKRAWsZHyT1LNF9e2Wgw51MeWfIOqY7i8rPPNAoxH1U9v9MRXz/pJ9nm/TC3tYa9ROvm6g
 2QBxNRygChkiKbepWueWA+t3j84jf0tbt9VSUrX+DtXI9qQsRW0l1N3W0S7qXGBNsXq5xEbLvqK
 Gjj48blANzLOpAea+q1DPWVwQjqbysech+AuYA5ItoIaq391JBkQUHfX38KuqYg3NwpBbKfGF5Z
 44iQO2KYb7OnHK/p2b/t6M4qVHMMXfh9MM5tmLFP/m27pDzdE64Xi1VIdvhz9HmcMDOfcqMvi28
 IISl1by6INQKAJA==
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

Signed-off-by: Jérémie Dautheribes (Schneider Electric) <jeremie.dautheribes@bootlin.com>
---
 doc/board/nxp/index.rst            |   2 +
 doc/imx/ahab/introduction_ahab.rst | 459 +++++++++++++++++++++++++++++++++++++
 doc/imx/index.rst                  |  13 ++
 3 files changed, 474 insertions(+)

diff --git a/doc/board/nxp/index.rst b/doc/board/nxp/index.rst
index b28e5b6ceb9..29a90297675 100644
--- a/doc/board/nxp/index.rst
+++ b/doc/board/nxp/index.rst
@@ -29,6 +29,8 @@ NXP Semiconductors
    mx6sabresd
    mx6ul_14x14_evk
    mx6ullevk
+
+   i.MX AHAB secure boot <../../imx/index>
    rproc
    psb
    quickboot
diff --git a/doc/imx/ahab/introduction_ahab.rst b/doc/imx/ahab/introduction_ahab.rst
new file mode 100644
index 00000000000..f6494e3c121
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
+       ┌┬─────┴─────┬┐   │          │          ││        |
+       ││Load ELE FW││─────────────>│          ││        │
+       └┴─────┬─────┴┘   |          |          |│        │
+              │          │   ┌┬─────┴─────┬┐   ││ ┌┬─────┴─────┬┐
+              │          │   ├│Auth ELE FW││   ││ ││Start CM FW││
+              │          │   └┴─────┬─────┴┘   ││ └┴─────┬─────┴┘
+              |          |          |          |│        |
+       ┌┬─────┴─────┬┐   │          │          ││        │
+       ││Load CM  FW││   │          |          ││        │
+       └┴─────┬─────┴┘   │          │          ││        │
+              │          │   ┌┬─────┴─────┬┐   ││        │
+              ├─────────────>├│Auth CM FW ││   ││        │
+              │          │   └┴─────┬─────┴┘   ││        │
+              |          │          │          ││        │
+              │          │          |───────────┘        │
+       ┌┬─────┴─────┬┐   │          │          │         │
+       ││Load  CA FW││   │          │          │         │
+       └┴─────┬─────┴┘   │          │          │         │
+              │          │   ┌┬─────┴─────┬┐   │         │
+              ├─────────────>├│Auth CA  FW││   │         │
+              │          │   └┴─────┬─────┴┘   │         │
+       ┌┬─────┴─────┬┐   │          │          │         │
+       ││Start CA FW││   │          |          │         │
+       └┴─────┬─────┴┘   │          │          │         │
+              |          │          │          │         │
+              |          │          │          │         │
+              |          │          │          │         │
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

