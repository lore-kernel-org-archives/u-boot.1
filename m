Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29477C5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 17:08:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E754340CF7;
	Fri, 14 Aug 2026 17:08:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 26eL-rauI65z; Fri, 14 Aug 2026 17:08:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A3A6C40D25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786727293;
	bh=6b9Tj65IqkbaD9k1DUgw6WnZD2kaWr99qFTQFP9CN6E=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=FtNyosdBLK+ysMCoJWWftgt5EyuA5X9TSfr7GLva7TNbdiNS/pkkFeeqNmTXHv7FU
	 6DXwNO39uFHtaJXKCWSp5gaYkouWhGEN03vzyA8rSV0xJFAZK8cy2PXw6uWOInxNpo
	 sMjQAqw0FsdXTOz5Q4OTugWkyYI6WEBWtPQqjG+5t7z1HXyL8U+vCoLyEs0yVllqyk
	 sayHKMj/DubVUGCZJwYZwKm/itDjuJEG/Iw4pP6N7/oVdXsrgnPWhcSRUHUyLlVN63
	 gI9ds+c4xZvJ48DM3RIOxTHuzhdVYZJ0DHSVIN595wchUiRxwrtQy+dUWugGuU4SjL
	 9L3Y2GMISqoLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A3A6C40D25;
	Fri, 14 Aug 2026 17:08:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 213B2361
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 17:08:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 07D6F400B9
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 17:08:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id buUEg9_uy-Tz for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 17:08:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B97CE4005D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B97CE4005D
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B97CE4005D
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 17:08:11 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 14C404E41233;
 Fri, 14 Aug 2026 17:08:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id DD08C6046D;
 Fri, 14 Aug 2026 17:08:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DEC2411C4EF28; 
 Fri, 14 Aug 2026 19:08:02 +0200 (CEST)
Date: Fri, 14 Aug 2026 19:07:13 +0200
Subject: [PATCH 4/5] doc: imx: ahab: add i.MX93 secure boot guide
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260814-imx93-secureboot-v1-4-0c3c78020d03@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12653;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=m2dxf6HXfElpJAgYLUz/Cz2ggjirkA2EBkYBeTUAOdQ=;
 b=owEBbQKS/ZANAwAKASsAXqAbWo8DAcsmYgBqf0tUsnZc6yiHHLtLQ+b7Xfw0HPFX4mxP+EpD5
 72cf6g334GJAjMEAAEKAB0WIQT7FK2Qhtu4QpBIBAkrAF6gG1qPAwUCan9LVAAKCRArAF6gG1qP
 A0sLD/96HaNDGQf8oiGDfJ2ova6Pg3WpWsXRtkrb4tRqO28ckWkxjq0Fk+GD5hFhbvJ6TtH+0B9
 p6DPd76nPcwgZP/Cbzq0x8DsQtKi8ZBglCLZjHgu6+wOwL5jqOeHXRNG3ixwmHLsfjxQ0RjAZhw
 DFIWYp1iuTDAs1EkjKNcxsgKxTrfsiuHc2EJQscJWh+3+e/a7pt6fqwr1F3Pv/F8PZc3DJDcNfC
 kG4YXmZFPspc4YfGJ0lYmwDK4/pGWI7/wpGkGS5SrXLCmuq45Ji+o3QmILMICISr5jipg//4gr0
 aaywyx4ogk6XMJofZbxD7gQa07a8rg4XSLOqgx7X2jR6VS5pBTtfrZ738e8Q0ZSfmiyjhIEATCu
 cC9L0CvaVwwgpJSCh7Dci0Je+VxnyPIcngQhtrFK1TIgl7UMEA3psAwfIrWjzF881Vu7+X6vNEj
 MNHJ3D+85GS8tKJK/uok7TYYi2bov4Ee73Y7vLZnasTYZG+Ur9sSFxvZX+vQ3sKsj4DsSn/jwOm
 Yal+hTmVRy3phdjm+l+nSLlc96mtln7XP13+6xyXbupuveOrC9D4CtjHGF5YbB+wRxTQKAy//A6
 i2+T2fdSGDT+g68zjJihKof2hdL92AHAQcIZphSzAhUh7EpTPMyGWrRrij1oScWAjJnigOFiFn/
 OIzlqkkf3C8zTlQ==
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

Add a step-by-step guide describing how to securely boot an i.MX93
image using AHAB.

This guide is largely based on the following documents:
  - doc/imx/ahab/guides/mx8ulp_9x_secure_boot.txt, from uboot-imx
  (lf_v2026.04), originally written by Utkarsh Gupta
  - doc/imx/habv4/guides/mx8m_spl_secure_boot.txt, from this tree,
  originally written by Marek Vasut

Signed-off-by: Jérémie Dautheribes (Schneider Electric) <jeremie.dautheribes@bootlin.com>
---
 doc/imx/ahab/guides/mx93_secure_boot.txt | 269 +++++++++++++++++++++++++++++++
 1 file changed, 269 insertions(+)

diff --git a/doc/imx/ahab/guides/mx93_secure_boot.txt b/doc/imx/ahab/guides/mx93_secure_boot.txt
new file mode 100644
index 00000000000..45a70926d51
--- /dev/null
+++ b/doc/imx/ahab/guides/mx93_secure_boot.txt
@@ -0,0 +1,269 @@
++=========================================================+
++       i.MX93 Secure boot guide using AHAB               +
++=========================================================+
+
+1. AHAB secure boot process
+----------------------------
+
+This document provides a step-by-step guide on how to securely boot an
+i.MX93 boot image. It is assumed that the reader is familiar with basic
+AHAB concepts and with the PKI tree generation. Details about AHAB can be
+found in the introduction_ahab.txt document and in processors Security
+Reference Manual Document (SRM). The i.MX93 signing procedure is
+integrated in the U-Boot build thanks to binman.
+
+1.1 Preparing the environment to build a secure boot image
+-----------------------------------------------------------
+
+Secure boot image preparation requires the U-Boot build system to build
+the image and the Code Signing Tool (CST) to sign it.
+
+Based on boot mode, the following files are needed to prepare the boot
+image:
+
+- All boot modes
+  - Edgelock secure enclave Firmware (ELE) (Optional).
+  - DDR PHY initialization firmware.
+  - U-Boot proper and SPL.
+  - ARM Trusted Firmware (ATF).
+  - OPTEE (Optional)
+
+The ELE FW is distributed by NXP and is already signed using NXP keys.
+In the following sections, <work> designates the repository where all
+parts have been downloaded and built.
+
+1.2 Preparing U-Boot to support AHAB secure boot features
+----------------------------------------------------------
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
+1.3 i.MX93 AHAB image layout
+-----------------------------
+
+The i.MX93 flash.bin image is built by binman and is composed of up to
+three containers. The ELE FW container is optional and is provided by NXP,
+it is appended at the beginning of the image when the file
+mx93a1-ahab-container.img is present in the build directory. The SPL and
+U-Boot containers are built by the nxp-imx9image etype and signed by the
+nxp-imx93cst etype.
+
+            *start ----> +---------------------------+ ---------
+                         |   1st Container header    |   ^
+                         |       and signature       |   |  Authenticated at
+                         +---------------------------+   |  ELE ROM/FW Level
+                         |          Padding          |   |
+                         +---------------------------+   |
+                         |           ELE FW          |   v
+     *start + 0x400 ---> +---------------------------+ ---------
+                         |   2nd Container header    |   ^
+                         |       and signature       |   |  Authenticated at
+                         +---------------------------+   |  ELE ROM/FW Level
+                         |          Padding          |   |
+                         +---------------------------+   |
+                         |            SPL            |   v
+                         +---------------------------+ ---------
+                         |   3rd Container header    |   ^
+                         |       and signature       |   |  Authenticated at
+                         +---------------------------+   |  SPL Level
+                         |          Padding          |   |
+                         +---------------------------+   |
+                         |    ARM Trusted FW (ATF)   |   |
+                         +---------------------------+   |
+                         |       U-Boot proper       |   |
+                         +---------------------------+   |
+                         |      OPTEE (optional)     |   v
+                         +---------------------------+ ---------
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
+             +----------------------------+ ---------
+             |                            |  ^
+             |                            |  |
+             |      Container header      |  |
+             |                            |  |
+             |                            |  |
+             +---+------------------------+  |
+             | S | Signature block header |  | Signed
+             | i +------------------------+  |
+             | g |                        |  |
+             | n |                        |  |
+             | a |        SRK table       |  |
+             | t |                        |  |
+             | u |                        |  v
+             | r +------------------------+ ---------
+             | e |       Signature        |
+             |   +------------------------+
+             | B |                        |
+             | l |        SGK Key         |
+             | o | Certificate (optional) |
+             | c |                        |
+             | k |                        |
+             +---+------------------------+
+
+The certificate block is divided into:
+
+                    +---------------+ ^
+                    |  Public key   | | Signed
+                    |  Permission   | |
+                    +---------------+ v
+                    |   Signature   |
+                    +---------------+
+
+The first block (public key permission) verifies the Signature block
+preceding (between SRK table and Certificate blocks), while the second
+block (signature) is verified by the SRK table block.
+
+In case not using the subordinate key, the container signature is
+verified against the SRK keys directly.
+
+1.4 Signing the images
+-----------------------
+
+Internally, Command Sequence Files (CSF) are used. The CSF files contain
+all the commands that the AHAB executes during the secure boot. These
+commands instruct the AHAB code on which memory areas of the image to
+authenticate, which keys to install, use and etc. The CSF is generated
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
+- `crts/SRK_1_2_3_4_table.bin`
+- `crts/SRK1_sha384_secp384r1_v3_usr_crt.pem`
+- `keys/SRK1_sha384_secp384r1_v3_usr_key.pem`
+- `keys/key_pass.txt`
+
+See the introduction_ahab.txt document for the PKI tree generation
+procedure (ahab_pki_tree tool) and for the SRK Table generation
+(srktool, use the SHA256 variant for i.MX93).
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
++--------------------+-------------+--------------------------------------------------------------+
+| DT property        | Variable    | Description                                                  |
++====================+=============+==============================================================+
+| nxp,srk-table      | SRK_TABLE   | full path to SRK_1_2_3_4_table.bin                           |
++--------------------+-------------+--------------------------------------------------------------+
+| nxp,srk-crt        | SRK_KEY     | full path to the SRK Key SRK1_sha384_secp384r1_v3_usr_crt.pem|
++--------------------+-------------+--------------------------------------------------------------+
+
+Environment variables can be set as follows to point the build process
+to external key material:
+
+  $ export SRK_TABLE=$CST_DIR/crts/SRK_1_2_3_4_table.bin
+  $ export SRK_KEY=$CST_DIR/crts/SRK1_sha384_secp384r1_v3_usr_crt.pem
+  $ make flash.bin
+
+1.5 Programming SRK Hash
+-------------------------
+
+As explained in introduction_ahab.txt document, the SRK Hash fuse values
+are generated by the srktool and should be programmed in the SoC
+SRK_HASH[255:0] fuses.
+
+Be careful when programming these values, as this data is the basis for
+the root of trust. An error in SRK Hash results in a part that does not
+boot.
+
+The U-Boot fuse tool can be used for programming eFuses on i.MX SoCs.
+
+- Dump SRK Hash fuses values in host machine:
+
+  On i.MX93 family, the SRK Hash uses sha256 and dump 8 words fuses
+  $ od -t x4 SRK_1_2_3_4_fuse.bin
+  0000000 db2959f2 90dfc39c 53394566 e0b75829
+  0000020 85e6f3b1 af00983d e5e804fe 7a451024
+
+- Program SRK_HASH[255:0] fuses:
+
+On i.MX93:
+
+  => fuse prog 16 0 0xdb2959f2
+  => fuse prog 16 1 0x90dfc39c
+  => fuse prog 16 2 0x53394566
+  => fuse prog 16 3 0xe0b75829
+  => fuse prog 16 4 0x85e6f3b1
+  => fuse prog 16 5 0xaf00983d
+  => fuse prog 16 6 0xe5e804fe
+  => fuse prog 16 7 0x7a451024
+
+1.6 Verify AHAB events
+-----------------------
+
+If the fuses have been burned properly, there should be no AHAB events
+after boot. To validate this, power on the board, and run ahab_status
+command on U-Boot terminal.
+
+No events should be returned after this command:
+
+  => ahab_status
+  Lifecycle: 0x00000008, OEM Open
+
+          No Events Found!
+
+1.7 Close the device
+---------------------
+
+After the device successfully boots a signed image without generating any
+AHAB security events, it is safe to close the device. The chip lifecycle
+should be changed from OEM open to OEM closed. Be aware this step can
+damage your board if a previous step failed. It is also irreversible. Run
+on the U-Boot terminal:
+
+  => ahab_close
+
+Warning: Please ensure your sample is in OEM Open state, OEM SRK hash
+has been fused, and you are able to boot a signed image successfully
+without any SECO events reported. If not, your sample will be
+unrecoverable.
+
+Now reboot the target, and run:
+
+  => ahab_status
+  Lifecycle: 0x00000020, OEM Closed
+
+          No Events Found!

-- 
2.55.0

