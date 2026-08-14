Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF035C5CFCF
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 17:08:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 90D0840CFE;
	Fri, 14 Aug 2026 17:08:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eH7uBS3GWGE5; Fri, 14 Aug 2026 17:08:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9546F40CE4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786727288;
	bh=4nod3fo5tKApb5oi8W0FH/eacaj19bE07O9m878/a2s=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=v+WEJAZwheN0v4OIjFbTJoRuTIxCYF5JlXp8ayWrdHyLe15L4dVU1n6tGw0nzsUDr
	 pVpdijqFTmXkpvX7NVSv+wcOA6TW25Tt1uJo6uwwIrTCOliLDuRuKzkF8/sE9ZEgBI
	 cVAusAwO+fVuAsWWd2ibLoWSo54i0oQsd59yK+a0NybnyOFqsqSXj9zr0+g8o5kbXc
	 /PFxwNsvpOoMexmqpJAnyjtLEchKWHT5n+4g6KRtSBfIv7t7PIQHcWWfOdg+Tw0y/e
	 JyRUGxijQuCttfMPfvGYiDLvCFdFc7T7VM7eOT0b58NgtWHC7ZJpf9ORHNnFH7bbXF
	 2V9vZksdbrxjA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9546F40CE4;
	Fri, 14 Aug 2026 17:08:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 94D7A2B2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 17:08:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7AC5B400B9
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 17:08:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mWZVpeBxnHbV for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 17:08:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C2CA94005D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C2CA94005D
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C2CA94005D
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 17:08:05 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id B9FB24E41235;
 Fri, 14 Aug 2026 17:08:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 8EEFD6046D;
 Fri, 14 Aug 2026 17:08:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6256C11C4EF2C; 
 Fri, 14 Aug 2026 19:07:56 +0200 (CEST)
Date: Fri, 14 Aug 2026 19:07:12 +0200
Subject: [PATCH 3/5] doc: imx: ahab: add AHAB introduction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260814-imx93-secureboot-v1-3-0c3c78020d03@bootlin.com>
References: <20260814-imx93-secureboot-v1-0-0c3c78020d03@bootlin.com>
In-Reply-To: <20260814-imx93-secureboot-v1-0-0c3c78020d03@bootlin.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, Denis Mukhin <dmukhin@ford.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Alice Guo <alice.guo@nxp.com>, 
 =?utf-8?q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marex.vasut@mailbox.org>, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=29799;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=1eOo5V+iAboILlT9IRXmZq1+6iby7cc80aftKwwgbb0=;
 b=owEBbQKS/ZANAwAKASsAXqAbWo8DAcsmYgBqf0tUcZH1l7VHFRL3iGMfgcRS/c/MrlvPK+Oz7
 9b/ZNzdawyJAjMEAAEKAB0WIQT7FK2Qhtu4QpBIBAkrAF6gG1qPAwUCan9LVAAKCRArAF6gG1qP
 A5GcD/9RFBcYWYCA6IuPgkHBE7GD7/zjuZEdU+qqlFdkLpZWAPjbSo4Xbb9Q7LEZ0oLCMHfoN0v
 rGKU1jqkgbtTe5OHRV92IIqvDBrZPiwY1zO8ATgsgfkK5QqLHGe7+PNu5Aknaq8Ff0elMa3Lfo3
 5s/WHMbunEEXaUbapybd5wqRtrAncZx4Cn8vfvn4lZkzH8RvNR6RxkGoRdMl+EUJtN3tQnq+Ckb
 Z15IDree16Q7FOBGH2a9d+5PojIB5N8L5pNW3Ly1ZOgYYiJv4L1Vkl7tpIDviC+xKqF4Czvq0MU
 pUB1nx/YrpAT2ElkaFvhdUdEQvQB7L51nL06QGuPmhupIpAY8M2pvasOGIJCTGn6WzHSFxUB3Qa
 8dg7HQJTAVjf3rkurivm4F6VYv83TADGF3W4R4PjdYpIIjEzRs5sXVHCZWMdj9bpfRLWzPPVi3B
 ocZ9EW7gVURbCjQ24d8k0WOkF3nflPXDoqGUu4v7FOT0/q4INSKIRmVNd77xMUfc302GUrEfdlk
 TvVMfb5TlZEP1n1a5i3diPkvVPu/Lf9rMgKcdkE9Pjcxs21bRNS/TE8fFqrSNYPgI3e45PCzy/E
 Pv7RAxNEkB9FSS5UoI36ZHNFWyO0vMyrQmWgwkdlOghKLwFwrBk9HIuQDxKP+CzH2xMxTUuDZ60
 gAkpDN2uTGEQn+w==
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
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29_via_U-Bo?=
 =?utf-8?q?ot?= <u-boot@lists.u-boot-project.org>
Reply-To: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

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
 doc/imx/ahab/introduction_ahab.txt | 445 +++++++++++++++++++++++++++++++++++++
 1 file changed, 445 insertions(+)

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

-- 
2.55.0

