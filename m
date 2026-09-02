Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49996C624D6
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 13:42:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F44380EC7;
	Wed,  2 Sep 2026 13:42:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4rC1f3f5mnX8; Wed,  2 Sep 2026 13:42:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788356540;
	bh=P0NaZhI8Smm6d4p612Z0Z4/gTuBMK1/2o0awUyyi6bo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=td9gIA0CfO5Q3Jo2ruxheP1Jn0iIFkvNoKV5fXbE6tm0K72pyUEJHlTJKtUx2EwLz
	 DpLJkfIUCdeMV52oJ29z1A2fOI4yZBXJ20QdTFR4QjJONTaaOZZyPzTp63hs1uxLSJ
	 Bu3MnJRp6qgwakRVBuYzme70f+KwWEXoA3jH/HQWn+hmjwywWzYOsADRXvZ9VzlDv6
	 Obf3bvAEP/r+ILfVNt3JoxcufPgGfMg2QJsPRvccXzpUiQg1btRXVi3VtYlQ7h2kwC
	 odWhHVHb+2hSc9ltyLGKBqsMbKbqjF8BVQN5zcnx3IEsBXehHyxClr1IWA+CJLXgiT
	 5eJyZ7r6VYLxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B0BE280D1C;
	Wed,  2 Sep 2026 13:42:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D31A230
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:42:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 333F440A4D
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:42:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5ls9c_AXlheS for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 13:42:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=o84T2YzE
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BE1C540A46
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:42:16 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 84F391A195E;
 Wed,  2 Sep 2026 13:42:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 572776053C;
 Wed,  2 Sep 2026 13:42:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9CAB511C79786; 
 Wed,  2 Sep 2026 15:42:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1788356528; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=P0NaZhI8Smm6d4p612Z0Z4/gTuBMK1/2o0awUyyi6bo=;
 b=o84T2YzEzKXVJFdWs3+fY7Z4B/vrJcm3iGXCifKPE3tcM3BpfAQH6GPZ+qTtxWMkxMIuX7
 rkt5HuM9PDn9AzRLXWpp67mbPIatJ0P/FQ34k5YAQ2ii4tPiwbybicfoNxs2RtfZw3FS2a
 7C4jBltJObm+daveFrm5hUVYBlDqcflEP0ILCXqoKbXh5QCnO1EicfZZKJ5L9OXn2PH3d6
 y9ArMv56jEUNP3JLwchSY3Zk3MIfP8B2NWXZeaCjc4iI7q8llBhXwU4RxBBIkNcfaR5bMP
 glAqr7IG44F54utiOzZO0IWuAwCIemaAYY1moDAYTLDQPA4Iz8HbPyR/+0A/JA==
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Date: Wed, 02 Sep 2026 15:41:32 +0200
Subject: [PATCH v2 5/7] doc: imx: ahab: add AHAB introduction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260902-imx93-secureboot-v2-5-5947b92a5072@bootlin.com>
References: <20260902-imx93-secureboot-v2-0-5947b92a5072@bootlin.com>
In-Reply-To: <20260902-imx93-secureboot-v2-0-5947b92a5072@bootlin.com>
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
 Christophe Guerreiro <christophe.guerreiro@non.se.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=60392;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=4Me5D4jW26YOEE1x2BiV6NwzqTSB0wL8fW+KSE0L0WI=;
 b=owEBbQKS/ZANAwAKASsAXqAbWo8DAcsmYgBqmCeVREnwLwtSruaBWXT5LXGw1CYBe1dcNfNIi
 u4EKdM4A4OJAjMEAAEKAB0WIQT7FK2Qhtu4QpBIBAkrAF6gG1qPAwUCapgnlQAKCRArAF6gG1qP
 A4v7D/0fuzg4iq2FxhJI+YpVQZPUBySG/RQ2KIR+5p7Ji3odNZ3Qu3MvkQYWrtGxkBkct+vPRsx
 hobgOD+12vafQ3vDapRu2OyuO9cb0UtE5OvngdLQ1ScsoV/l26PKYcdEHW+ECaZPE2Dxg6P8quQ
 L51eF1gD00JSlYza7ePX6DWP4G1ubtA3JLSjvNanvgHF4Tvcb87GW20kHI6ny932BNRzMcNNRMV
 yR1+SIahpt9QLaO0Ol97TTRvANlkdAb0FL+K4//c8FPeKJAcG3WF0uHE8XPIm5zQJQZmTo+sMvi
 /lRWdFgYdB18Gl6rPskrpJQ1irNrrgdh6/a36ruGC9zawEsAsjHMC/i4leBfMuzCjaazc2vu8RD
 bBrkftZAfVuuwYLUzxBTWSWvFB/2V+qNmNy3zRNHS4pdhfqZHHy2u1pYEChqXATNepGmnjGE7oy
 +vHZJ3RlApzyWEmyEo6dKRPozEhf66zeM91cX1vM/4I4ynYDtvAtY1nfWDtAwyN4urxAfjeIEV0
 Bthgnf4fljMwmi1axfisQogJcOUAxLeBpW60U6sbBVVYp4D3tEbC/vKfTdeBEpPUN5VYr2FCVWq
 TbGUkFmuumQY8gJvNBQALSMDOJlSBNjPgS+c+CZQ1leqh1N6LZVyv/5gm1jUVKvOHt4bjA5ZUI2
 /87iYRuwHRTWQrw==
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
- PKI tree generation (ahab_pki_tree.sh)
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
 doc/imx/ahab/introduction_ahab.rst | 464 +++++++++++++++++++++++++++++++++++++
 doc/imx/ahab/introduction_ahab.txt | 445 +++++++++++++++++++++++++++++++++++
 doc/imx/index.rst                  |  13 ++
 4 files changed, 924 insertions(+)

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
index 00000000000..aef75b5e841
--- /dev/null
+++ b/doc/imx/ahab/introduction_ahab.rst
@@ -0,0 +1,464 @@
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
+       Cortex-M(CM)     │   EdgeLock Secure   │    Cortex-A(CA)   │   uPower(uP)
+                        │    Enclave(ELE)     │                   │
+              │          │          │          │         │         │        │
+       ┌┬─────┴─────┬┐   │   ┌┬─────┴─────┬┐   │         │         │ ┌┬─────┴─────┬┐
+       ││   INIT    ││   │   ││   INIT    ││   │         │         │ ││   INIT    ││
+       └┴─────┬─────┴┘   │   └┴─────┬─────┴┘   │         │         │ └┴─────┬─────┴┘
+              │          │          │          │  ┌┬─────┴─────┬┐  │        │
+       ┌┬─────┴─────┬┐   │          │          │  ││Load CA FW ││  │ ┌──────┐  │
+       ││Load uP FW ││   │          │          │  └┴─────┬─────┴┘  ││     │  │
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
+       Cortex-A(CA)     │   EdgeLock Secure   │    Cortex-M(CM)
+                        │    Enclave(ELE)     │
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
+The first step is to generate the private keys and public keys certificates.
+The AHAB architecture is based on a Public Key Infrastructure (PKI) tree.
+
+The Code Signing Tools package contains an OpenSSL based key generation script
+under keys/ directory. The ahab_pki_tree.sh script generates a PKI tree
+containing 4 Super Root Keys (SRK), possible to also include a subordinate
+SGK key.
+
+The AHAB supports both RSA and ECC keys, a new PKI tree can be generated by
+following the example below:
+
+- Generating a P384 ECC PKI tree on CST (starting from v3.1.0):
+
+  .. code-block:: console
+
+     $ ./ahab_pki_tree.sh
+     ...
+     Do you want to use an existing CA key (y/n)?: n
+     Do you want to use Elliptic Curve Cryptography (y/n)?: y
+     Enter length for elliptic curve to be used for PKI tree:
+     Possible values p256, p384, p521:  p384
+     Enter the digest algorithm to use: sha384
+     Enter PKI tree duration (years): 5
+     Do you want the SRK certificates to have the CA flag set? (y/n)?: n
+
+The diagram below illustrate the PKI tree generated:
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
+The ahab_pki_tree.sh script is also able to generate a PKI tree containing a
+subordinate key of the SRK, this key can be used to verify the signature
+included in the final signed image.
+
+Users should set the CA flag when generating the SRK certificates.
+
+- Generating a P384 ECC PKI tree with a subordinate SGK key on CST (starting
+  from v3.1.0):
+
+  .. code-block:: console
+
+     $ ./ahab_pki_tree.sh
+     ...
+     Do you want to use an existing CA key (y/n)?: n
+     Do you want to use Elliptic Curve Cryptography (y/n)?: y
+     Enter length for elliptic curve to be used for PKI tree:
+     Possible values p256, p384, p521:  p384
+     Enter the digest algorithm to use: sha384
+     Enter PKI tree duration (years): 5
+     Do you want the SRK certificates to have the CA flag set? (y/n)?: y
+
+The diagram below illustrate the PKI tree generated:
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
+2.2 Generating a SRK Table and SRK Hash
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The next step is to generated the SRK Table and its respective SRK Table Hash
+from the SRK public key certificates created in one of the steps above.
+
+In the AHAB architecture, the SRK Table is included in the signed image and the
+SRK Hash is programmed in the SoC SRK_HASH[511:0]/SRK_HASH[255:0] fuses.
+
+On the target device during the authentication process the AHAB code verify the
+SRK Table against the SoC SRK_HASH fuses, in case the verification is successful
+the root of trust is established and the AHAB code can progress with the image
+authentication.
+
+The srktool can be used to generate the SRK Table and its respective SRK
+Table Hash.
+
+- Generating SRK Table and SRK Hash in Linux 64-bit machines:
+  - In i.MX 8/8x family, the expected SRK HASH is of 512 bit.
+
+    .. code-block:: console
+
+       $ cd ../crts/
+       $ ../linux64/bin/srktool -a -s sha384 -t SRK_1_2_3_4_table.bin \
+             -e SRK_1_2_3_4_fuse.bin -f 1 -c \
+             SRK1_sha384_secp384r1_v3_usr_crt.pem,\
+             SRK2_sha384_secp384r1_v3_usr_crt.pem,\
+             SRK3_sha384_secp384r1_v3_usr_crt.pem,\
+             SRK4_sha384_secp384r1_v3_usr_crt.pem
+
+  - In i.MX 8ULP/9x, the expected SRK HASH is of 256 bit.
+
+    .. code-block:: console
+
+       $ cd ../crts/
+       $ ../linux64/bin/srktool -a -d sha256 -s sha384 -t SRK_1_2_3_4_table.bin \
+             -e SRK_1_2_3_4_fuse.bin -f 1 -c \
+             SRK1_sha384_secp384r1_v3_usr_crt.pem,\
+             SRK2_sha384_secp384r1_v3_usr_crt.pem,\
+             SRK3_sha384_secp384r1_v3_usr_crt.pem,\
+             SRK4_sha384_secp384r1_v3_usr_crt.pem
+
+    Regenerate the SRK HASH (SRK_1_2_3_4_fuse.bin) by using SHA256 with
+    SRK_1_2_3_4_table.bin:
+
+    .. code-block:: console
+
+       $ openssl dgst -binary -sha256 SRK_1_2_3_4_table.bin
+
+- Optionally users can check if the sha512sum/sha256sum of SRK_1_2_3_4_table
+  matches with the SRK_1_2_3_4_fuse.bin:
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
diff --git a/doc/imx/ahab/introduction_ahab.txt b/doc/imx/ahab/introduction_ahab.txt
new file mode 100644
index 00000000000..4a5b6f795c4
--- /dev/null
+++ b/doc/imx/ahab/introduction_ahab.txt
@@ -0,0 +1,445 @@
+          +=======================================================+
+          +       i.MX Secure and Encrypted Boot using AHAB       +
+          +=======================================================+
+
+1. Introduction
+----------------
+
+The i.MX 8/8x/8ULP/9x family of applications processors introduce a new secure
+boot concept. Due to the multi-core architecture, the Security Controller (SECO)
+and System Control Unit (SCU) in i.MX 8/8x, and Edgelock secure enclave (ELE)
+in i.MX 8ULP/9x are heavily involved in the secure boot process.
+
+Step-by-step guides are available under doc/imx/ahab/guides/ directory,
+users familiar with AHAB architecture and CST PKI tree generation should
+refer to these documents instead.
+
+1.1 The AHAB Secure Boot Architecture
+--------------------------------------
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
+------------------------------------
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
+-------------------------------------
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
+1.1.3 [i.MX 8ULP/9x] The Edgelock secure enclave
+-------------------------------------
+
+EdgeLock™ Secure Enclave is the security subsystem based on a dedicated core
+(RISC-V) to manage security tasks with a tight control on security resources
+along with other enhancements.
+
+The secure enclave has a dedicate ROM which is responsible to initialize low
+level security features and to authenticate the secure enclave firmware
+previously loaded by the boot management core.
+
+The secure enclave firmware provides security services at run-time to different
+ domains of the SoC, one of these being the capability of authenticate images.
+
+The secure enclave firmware is signed and distributed by NXP and is always
+authenticated in OEM open and closed configuration, instructions to download
+this FW are available in the Linux BSP Release Notes.
+
+Details about Edgelock secure enclave can be found in the processors Security
+Reference Manual (SRM).
+
+NOTE: The terms Sentinel, S400, and EdgeLock secure enclave (ELE), and ELE
+are used interchangeably throughout the document.
+
+1.2 The image container
+------------------------
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
+The final binary is generated by the imx-mkimage tool.
+
+1.3 The i.MX8/8x secure boot flow
+----------------------------------
+
+As mentioned in the introduction, due to the multiple cores architecture the
+i.MX8 boot sequence involves SCU ROM, SCFW, SECO ROM, and SECO FW.
+
+The diagram below illustrate the secure boot flow overview:
+
+System Controller   │  Security Controller  │     Cortex-M     │   Cortex-A
+      (SCU)         │        (SECO)         │                  │
+                    │                       │                  │
+ ╔═════════════╗    │   ╔═════════════╗  ┌───────────┐       ┌─────────┐
+ ║   SCU INIT  ║    │   ║  SECO INIT  ║  │  │        │       │ │       │
+ ╚══════╤══════╝    │   ╚══════╤══════╝  │  │        v       │ │       v
+        │           │          │         │  │  ┌──────────┐  │ │ ┌────────────┐
+ ╔══════╧══════╗    │          │         │  │  │ Start M4 │  │ │ │  Start AP  │
+ ║Load SECO FW ║    │          │         │  │  │   IMG    │  │ │ │    IMG     │
+ ╚══════╤══════╝    │   ╔══════╧══════╗  │  │  └──────────┘  │ │ └─────┬──────┘
+        ├──────────────>║Auth SECO FW ║  │  │                │ │       │
+ ╔══════╧══════╗    │   ╚══════╤══════╝  │  │   ┌────────────┘ │       │
+ ║ Load SCU FW ║    │          │         │  │   │              │       │
+ ║   and DCD   ║    │          │         │  │   │              │ ┌─────┴──────┐
+ ╚══════╤══════╝    │   ┌──────┴──────┐  │  │   │              │ │    Load    │
+        ├──────────────>│ Auth SCU FW │  │  │   │              │ │ Add AP IMG │
+        │           │   │   and DCD   │  │  │   │              │ └─────┬──────┘
+ ╔══════╧══════╗    │   └──────┬──────┘  │  │   │              │       │
+ ║   Run DCD   ║<──────────────┤         │  │   │              │       │
+ ╚══════╤══════╝    │          │         │  │   │      ┌───────────────┤
+        │           │          │         │  │   │      │       │       │
+ ╔══════╧══════╗    │          │         │  │   │      │       │       │
+ ║ Load M4 IMG ║    │          │         │  │   │      │       │       │
+ ╚══════╤══════╝    │   ┌──────┴──────┐  │  │   │      │       │       │
+        ├──────────────>│ Auth M4 IMG │  │  │   │      │       │       │
+ ╔══════╧══════╗    │   └──────┬──────┘  │  │   │      │       │ ┌─────┴──────┐
+ ║ Load AP IMG ║    │          │         │  │   │      │       │ │     Run    │
+ ╚══════╤══════╝    │   ┌──────┴──────┐  │  │   │      │       │ │ Add AP IMG │
+        ├──────────────>│ Auth AP IMG │  │  │   │      │       │ └────────────┘
+ ╔══════╧══════╗    │   └─────────────┘  │  │   │      │       │
+ ║Start SCU FW ║    │ ┌──────────────────┘  │   │      │       │
+ ╚══════╤══════╝    │ │                     │   │      │       │
+        │           │ │   ┌─────────────────────┘      │       │
+ ┌──────┴──────┐    │ │   │                 │          │       │
+ │  Start M4   ├──────┘   │     ┌──────────────────────┘       │
+ └──────┬──────┘    │     │     │           │                  │
+        │           │     │     │           │                  │
+ ┌──────┴──────┐    │     │     │           │                  │
+ │  Start AP   ├──────────┘     │           │                  │
+ └─────────────┘    │           │           │                  │
+        ┌───────────────────────┘           │                  │
+        │           │                       │                  │
+        v           │                       │                  │
+ ┌─────────────┐    │   ┌─────────────┐     │                  │
+ │Request SECO ├───────>│ Auth AP IMG │     │                  │
+ └─────────────┘    │   └─────────────┘     │                  │
+                    │                       │                  │
+
+
+Notes:
+All boxes enclosed by double dash (═) are performed at SCU/SECO ROM level.
+
+The sequence below explains the i.MX8 and i.MX8x boot flow:
+
+1  - At reset, the SCU ROM and SECO ROM both start execution.
+2  - The SCU ROM reads the boot configuration and loads the SECO FW (First
+     container) from the boot media to the SECO TCM.
+3  - A message is sent by the SCU ROM via MU requesting the SECO ROM to
+     authenticate the SECO FW which is signed using NXP key.
+4  - The SCU ROM loads the second container from the boot media, this container
+     must contain at least the SCFW which is signed using the OEM keys.
+5  - The SCU ROM loads the SCFW to the SCU TCM, a message is sent via MU
+     requesting the SECO FW to authenticate the SCFW and DCD table.
+6  - The SCU ROM configures the DDR and loads the M4 and AP images included in
+     the second container to their respective load addresses.
+7  - The SCU ROM request the SECO FW to authenticate the M4 image.
+8  - The SCU ROM request the SECO FW to authenticate the AP image. This image
+     is the initial AP core software, depending in the U-Boot target it can
+     be the U-Boot and ATF or only SPL.
+9  - The SCFW is initialized and starts the ARM Cortex-M and Cortex-A cores.
+10 - From this point additional containers can be loaded by Cortex-M and
+     Cortex-A cores and authenticated by SECO, the AP SW must interface with
+     SCU by calling the sc_misc_seco_authenticate() API function. In current
+     U-Boot implementation the additional image can be the Linux Kernel binary
+     or the U-Boot proper and ATF. Details about current U-Boot implementation
+     can be found in AHAB guides included in doc/imx/ahab/guides/ directory.
+
+1.4 The i.MX 8ULP/9x secure boot flow
+----------------------------------
+
+The secure boot sequence involves multiple cores booting up at same time and
+Edgelock secure enclave ensure authentication of any boot software being loaded.
+
+The diagram below illustrate the secure boot flow overview for dual boot
+scenario in i.MX 8ULP:
+
+
+    Cortex-M(CM)     │   Edgelock Secure   │    Cortex-A(CA)   │   uPower(uP)
+                     │    Enclave(ELE)     │                   │
+          │          │          │          │         │         │        │
+   ┌┬─────┴─────┬┐   │   ┌┬─────┴─────┬┐   │         │         │ ┌┬─────┴─────┬┐
+   ││   INIT    ││   │   ││   INIT    ││   │         │         │ ││   INIT    ││
+   └┴─────┬─────┴┘   │   └┴─────┬─────┴┘   │         │         │ └┴─────┬─────┴┘
+          │          │          │          │  ┌┬─────┴─────┬┐  │        │
+   ┌┬─────┴─────┬┐   │          │          │  ││Load CA FW ││ ┌──────┐  │
+   ││Load uP FW ││   │          │          │  └┴─────┬─────┴┘ ││     │  │
+   └┴─────┬─────┴┘   │          │          │         │        ││ ┌┬──v──┴─────┬┐
+          │          │   ┌┬─────┴─────┬┐   │┌────────┤        ││ ││Load &Start││
+          ├─────────────>├│Auth uP FW ││   ││        │        ││ ││   uP FW   ││
+          │          │   └┴─────┬─────┴┘   ││        │        ││ └┴───────────┴┘
+   ┌┬─────┴─────┬┐   │          │          ││        │        ││
+   ││Load CM  FW││   │          ├────────────────────┼────────┘│
+   └┴─────┬─────┴┘   │          │          ││        │         │
+          │          │   ┌┬─────┴─────┬┐   ││        │         │
+          ├─────────────>├│Auth CM FW ││   ││ ┌┬─────┴─────┬┐  │
+          │          │   └┴─────┬─────┴┘   ││ ││Start CA FW││  │
+   ┌┬─────┴─────┬┐   │          │          ││ └┴─────┬─────┴┘  │
+   ││Load ELE FW││   │          │          ││        │         │
+   └┴─────┬─────┴┘   │          │          ││        │         │
+          │          │   ┌┬─────┴─────┬┐   ││        │         │
+          ├─────────────>├│Auth ELE FW││   ││        │         │
+          │          │   └┴─────┬─────┴┘   ││ ┌┬─────┴─────┬┐  │
+   ┌┬─────┴─────┬┐   │          │          ││ ││ Load SPL  ││  │
+   ││Start CM FW││   │          │          ││ └┴─────┬─────┴┘  │
+   └┴─────┬─────┴┘   │          │          ││        │         │
+          │          │   ┌┬─────┴─────┬┐   ││   ┌────┤         │
+          │          │   ││Auth CA FW │┤<───┘   │    │         │
+          │          │   └┴─────┬─────┴┘   │    │    │         │
+          │          │          │          │    │    │         │
+          │          │   ┌┬─────┴─────┬┐   │    │    │         │
+          │          │   ││ Auth SPL  │┤<───────┘    │         │
+          │          │   └┴─────┬─────┴┘   │         │         │
+          │          │          ├─────────────────┐  │         │
+          │          │          │          │      │  │         │
+          │          │          │          │  ┌┬──v──v─────┬┐  │
+          │          │          │          │  ││  Run SPL  ││  │
+          │          │          │          │  └┴───────────┴┘  │
+
+
+The diagram below illustrate the secure boot flow overview for single boot
+scenario in i.MX 9x:
+
+
+    Cortex-A(CA)     │   Edgelock Secure   │    Cortex-M(CM)
+                     │    Enclave(ELE)     │
+          │          │          │          │         │
+   ┌┬─────┴─────┬┐   │   ┌┬─────┴─────┬┐   │         │
+   ││   INIT    ││   │   ││   INIT    ││   │         │
+   └┴─────┬─────┴┘   │   └┴─────┬─────┴┘   │         │
+          │          │          │          │  ┌┬─────┴─────┬┐
+          │          │          │          │┌>││   INIT    ││
+          │          │          │          ││ └┴─────┬─────┴┘
+   ┌┬─────┴─────┬┐   │          │          ││        |
+   ││Load ELE FW││─────────────>│          ││        │
+   └┴─────┬─────┴┘   |          |          |│        |
+          │          │   ┌┬─────┴─────┬┐   ││ ┌┬─────┴─────┬┐
+          │          │   ├│Auth ELE FW││   ││ ││Start CM FW││
+          │          │   └┴─────┬─────┴┘   ││ └┴─────┬─────┴┘
+          |          |          |          |│        |
+   ┌┬─────┴─────┬┐   │          │          ││        │
+   ││Load CM  FW││   │          |          ││        │
+   └┴─────┬─────┴┘   │          │          ││        │
+          │          │   ┌┬─────┴─────┬┐   ││        │
+          ├─────────────>├│Auth CM FW ││   ││        │
+          │          │   └┴─────┬─────┴┘   ││        │
+          |          │          │          ││        │
+          │          │          |───────────┘        │
+   ┌┬─────┴─────┬┐   │          │          │         │
+   ││Load  CA FW││   │          │          │         │
+   └┴─────┬─────┴┘   │          │          │         │
+          │          │   ┌┬─────┴─────┬┐   │         │
+          ├─────────────>├│Auth CA  FW││   │         │
+          │          │   └┴─────┬─────┴┘   │         │
+   ┌┬─────┴─────┬┐   │          │          │         │
+   ││Start CA FW││   │          |          │         │
+   └┴─────┬─────┴┘   │          │          │         │
+          |          │          │          │         │
+          |          │          │          │         │
+          |          │          │          │         │
+
+More details on the boot flow can be found in respective Security Reference
+Manual (SRM).
+
+
+2. Generating a PKI tree
+-------------------------
+
+The first step is to generate the private keys and public keys certificates.
+The AHAB architecture is based on a Public Key Infrastructure (PKI) tree.
+
+The Code Signing Tools package contains an OpenSSL based key generation script
+under keys/ directory. The ahab_pki_tree.sh script generates a PKI tree
+containing 4 Super Root Keys (SRK), possible to also include a subordinate
+SGK key.
+
+The AHAB supports both RSA and ECC keys, a new PKI tree can be generated by
+following the example below:
+
+- Generating a P384 ECC PKI tree on CST (starting from v3.1.0):
+
+  $ ./ahab_pki_tree.sh
+  ...
+  Do you want to use an existing CA key (y/n)?: n
+  Do you want to use Elliptic Curve Cryptography (y/n)?: y
+  Enter length for elliptic curve to be used for PKI tree:
+  Possible values p256, p384, p521:  p384
+  Enter the digest algorithm to use: sha384
+  Enter PKI tree duration (years): 5
+  Do you want the SRK certificates to have the CA flag set? (y/n)?: n
+
+The diagram below illustrate the PKI tree generated:
+
+                             ┌─────────┐
+                             │   CA    │
+                             └────┬────┘
+                                  │
+                                  │
+         ┌───────────────┬────────┴────────┬───────────────┐
+         │               │                 │               │
+         │               │                 │               │
+         v               v                 v               v
+    ┌────────┐       ┌────────┐       ┌────────┐       ┌────────┐
+    │  SRK1  │       │  SRK2  │       │  SRK3  │       │  SRK4  │
+    └────────┘       └────────┘       └────────┘       └────────┘
+
+2.1 Generating a PKI tree including a subordinate SGK key
+----------------------------------------------------------
+
+The ahab_pki_tree.sh script is also able to generate a PKI tree containing a
+subordinate key of the SRK, this key can be used to verify the signature
+included in the final signed image.
+
+Users should set the CA flag when generating the SRK certificates.
+
+- Generating a P384 ECC PKI tree with a subordinate SGK key on CST (starting
+from v3.1.0):
+
+  $ ./ahab_pki_tree.sh
+  ...
+  Do you want to use an existing CA key (y/n)?: n
+  Do you want to use Elliptic Curve Cryptography (y/n)?: y
+  Enter length for elliptic curve to be used for PKI tree:
+  Possible values p256, p384, p521:  p384
+  Enter the digest algorithm to use: sha384
+  Enter PKI tree duration (years): 5
+  Do you want the SRK certificates to have the CA flag set? (y/n)?: y
+
+The diagram below illustrate the PKI tree generated:
+
+                             ┌─────────┐
+                             │   CA    │
+                             └────┬────┘
+                                  │
+                                  │
+         ┌───────────────┬────────┴────────┬───────────────┐
+         │               │                 │               │
+         v               v                 v               v
+    ┌────────┐       ┌────────┐       ┌────────┐       ┌────────┐
+    │  SRK1  │       │  SRK2  │       │  SRK3  │       │  SRK4  │
+    └────┬───┘       └───┬────┘       └────┬───┘       └───┬────┘
+         │               │                 │               │
+         v               v                 v               v
+    ┌────────┐       ┌────────┐       ┌────────┐       ┌────────┐
+    │  SGK1  │       │  SGK2  │       │  SGK3  │       │  SGK4  │
+    └────────┘       └────────┘       └────────┘       └────────┘
+
+2.2 Generating a SRK Table and SRK Hash
+----------------------------------------
+
+The next step is to generated the SRK Table and its respective SRK Table Hash
+from the SRK public key certificates created in one of the steps above.
+
+In the AHAB architecture, the SRK Table is included in the signed image and the
+SRK Hash is programmed in the SoC SRK_HASH[511:0]/SRK_HASH[255:0] fuses.
+
+On the target device during the authentication process the AHAB code verify the
+SRK Table against the SoC SRK_HASH fuses, in case the verification is successful
+the root of trust is established and the AHAB code can progress with the image
+authentication.
+
+The srktool can be used to generate the SRK Table and its respective SRK
+Table Hash.
+
+- Generating SRK Table and SRK Hash in Linux 64-bit machines:
+  - In i.MX 8/8x family, the expected SRK HASH is of 512 bit.
+    $ cd ../crts/
+    $ ../linux64/bin/srktool -a -s sha384 -t SRK_1_2_3_4_table.bin \
+	  -e SRK_1_2_3_4_fuse.bin -f 1 -c \
+	  SRK1_sha384_secp384r1_v3_usr_crt.pem,\
+	  SRK2_sha384_secp384r1_v3_usr_crt.pem,\
+	  SRK3_sha384_secp384r1_v3_usr_crt.pem,\
+	  SRK4_sha384_secp384r1_v3_usr_crt.pem
+
+  - In i.MX 8ULP/9x, the expected SRK HASH is of 256 bit.
+    $ cd ../crts/
+    $ ../linux64/bin/srktool -a -d sha256 -s sha384 -t SRK_1_2_3_4_table.bin \
+	  -e SRK_1_2_3_4_fuse.bin -f 1 -c \
+	  SRK1_sha384_secp384r1_v3_usr_crt.pem,\
+	  SRK2_sha384_secp384r1_v3_usr_crt.pem,\
+	  SRK3_sha384_secp384r1_v3_usr_crt.pem,\
+	  SRK4_sha384_secp384r1_v3_usr_crt.pem
+
+    Regenerate the SRK HASH (SRK_1_2_3_4_fuse.bin) by using SHA256 with
+    SRK_1_2_3_4_table.bin.
+    $ openssl dgst -binary -sha256 SRK_1_2_3_4_table.bin
+
+
+
+- Optionally users can check if the sha512sum/sha256sum of SRK_1_2_3_4_table
+matches with the SRK_1_2_3_4_fuse.bin:
+
+  $ od -t x4 --endian=big SRK_1_2_3_4_fuse.bin
+  0000000 01b04697 0253376b 2066fe56 aaef9a91
+  0000020 e62e09d8 14fb7e36 d5b38d05 0982edab
+  0000040 7ada6576 2f6b4f59 1fd9347e 46e7305d
+  0000060 46e34bf0 89780bd1 c809e714 a17e2f4e
+
+  $ sha512sum SRK_1_2_3_4_table.bin
+  01b046970253376b2066fe56aaef9a91\
+  e62e09d814fb7e36d5b38d050982edab\
+  7ada65762f6b4f591fd9347e46e7305d\
+  46e34bf089780bd1c809e714a17e2f4e\
+  SRK_1_2_3_4_table.bin
+
+NOTE: The commands above cannot be used as reference to program the SoC
+      SRK_HASH fuses.
+
+The SRK_1_2_3_4_table.bin and SRK_1_2_3_4_fuse.bin files can be used in further
+steps as explained in AHAB guides available under doc/imx/ahab/guides/
+directory.
+
+3 Known limitations
+----------------------------------------
+
+- Due to a limitation in i.MX8QXP B0 silicon it's not possible to use RSA
+4096-bit SRK keys with an additional subordinate SGK key.
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

