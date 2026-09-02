Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45578C624D6
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 13:42:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0D18A80F8D;
	Wed,  2 Sep 2026 13:42:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rj0VTm4c5962; Wed,  2 Sep 2026 13:42:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788356548;
	bh=8nSgbs0qy5Cylg0ptpitkdje6NNdsMAY5MziO5geMpI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IXB8ryG1C7phog6UYJQ+FUWaO85R8tawBbDJZ4ga8JjlBaeUuIoxcNRhcCqaZkyV5
	 lCP5L5tVuSzVY7tSSv0W/PiF46Nv86nW09XeFXXUKwuQtJtQrYnNFy0soV2zkdSV4J
	 EekJnQ2uZaHshDsQJYq18KGb9odnzeptWhGxeg1NB6NB8QI2XRyGPZb80UyaZZLxkT
	 ywwV2vbWzNVKzK5P7r9bAfGSNBnY7QA+yS1I7qrw+1zmFqvGA0v0WEwdemwPIhvu+2
	 bBYvse8+vWrQCM/rSPV5Vfb/TwARtf2UDjBUzbpHXa+8MkOjkTmyhPLUMG8Fg0GUi5
	 PbrvEiTBXCA6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 28A7C80F7E;
	Wed,  2 Sep 2026 13:42:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E50992FD
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:42:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D67EF80EDB
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:42:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hkiTeAxWAO7L for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 13:42:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=bnpkO/y9
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 723B180D1C
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:42:23 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 9D84D4E414D1;
 Wed,  2 Sep 2026 13:42:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 6AB3E6053C;
 Wed,  2 Sep 2026 13:42:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8991811C79A84; 
 Wed,  2 Sep 2026 15:42:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1788356536; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=8nSgbs0qy5Cylg0ptpitkdje6NNdsMAY5MziO5geMpI=;
 b=bnpkO/y9O7qLMgcrcIA8xpPN1KmthSc8hsM5kzdgi05Wj4/PWXiHT2gUCt1lqyFIAjUhoW
 tuRKLcDLQUAQ2W4koYxDntcgqqs/VQytl6+dMnW1SRYmp2y78AO0558cGaELk/1lB8sflx
 0rEzWxoyZ5coc4uI6h86kIrYorh8WKhUjBZZb41Tbd8SDlIzQR1NyjHegYvEyYtzEI0NgL
 UWBbfZfaIdeFwWj9feZs8WTYY2+jBeE0LS5nBaZbf7zcKW8xARthAdwgQlTwA1rO765vrH
 iI8UUP9AWXD9rEaWFU5bXhuxwj55UTbCvEQI15Rc3wSCgdb4JcAbCxp9iKuXjQ==
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Date: Wed, 02 Sep 2026 15:41:33 +0200
Subject: [PATCH v2 6/7] doc: imx: ahab: add i.MX93 secure boot guide
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260902-imx93-secureboot-v2-6-5947b92a5072@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=25812;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=aav0byNmo9G6ENoy9uLVpz2Jfyo+q+nya026e26/BJ8=;
 b=owEBbQKS/ZANAwAKASsAXqAbWo8DAcsmYgBqmCeVuKEldC7O0Y2e31q9xznunLmtnT00UAckY
 V9MzWf/LWiJAjMEAAEKAB0WIQT7FK2Qhtu4QpBIBAkrAF6gG1qPAwUCapgnlQAKCRArAF6gG1qP
 A+DoD/9D8jx0q8GLHWq+RSJG1e/TxdWoSgSDQk5E1ujziPf4wMzbYSMp8/BITCDDFMRSMo4k0G7
 coe0G0tMjFa4R9dn8YIDWGJpw/8+D4gNneEuXXZ2GvRBajh5kL+pDWbHnmoEJgnu2QJWKaw5/7D
 zGjfu60Ykzgn3H+AkA/8wQoE2xCH+ahMFBi8eVnmW242kY19/HMcBcDr0n/cx7VzRRG4X3Z0ppc
 LSouz5RnvtQnvFRjpaSom0Admfq12PraS31uys4Ig0EZ/WPvk3FUbGxHx5DWftaLhhcgjgqC+fw
 DAUBAIjQGoLZiZmK3pY6kqSlZxK1YrOjnIfijfMQtZOEEC6OgByOH5zjBeKeQpYHtTLGXaSk1OZ
 KvZohwfAYzDOUOCN9HfsQotPUsb08/OxtstqCob/Y/DIfrZH8glcDy5ywt+48LRJGbP4wFTPtk9
 WOok7HNjkFPWTuJQ4b3hBLvLBCwg6tHzVg7EIdzC02hVWfubPcPubvtwO8R2ow7IIBTaSOgEnqJ
 Ob2ZhM9y2sJ5pZ/8WGLRSx5AOzeOWjIBewfGIKDaNFqNBE9LqQgVrXP7C7Gh84aqLrwrPwiGXrb
 Zmme9GkYgOiMf8f4e5gZ3aVHsNZy1ht21TEqiTR6aBYA6DJpWP7yx6sLvPGZ9vp9KjJloXWbUTN
 XQ/SRo2cOLWK2SQ==
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
 doc/imx/ahab/guides/mx93_secure_boot.txt | 269 ++++++++++++++++++++++++++++
 doc/imx/ahab/introduction_ahab.rst       |   3 +-
 doc/imx/index.rst                        |   1 +
 4 files changed, 566 insertions(+), 1 deletion(-)

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
diff --git a/doc/imx/ahab/introduction_ahab.rst b/doc/imx/ahab/introduction_ahab.rst
index aef75b5e841..8c40c840ab5 100644
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

