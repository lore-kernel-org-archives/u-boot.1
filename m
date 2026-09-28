Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C850CA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 13:41:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2699E80DEE;
	Mon, 28 Sep 2026 13:41:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mt9Cyf6eDJUI; Mon, 28 Sep 2026 13:41:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 667EA80E00
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790602911;
	b=WLoWAF4gijsPsFn7aLKtN863+H/tIINNToH9gBiQCIHRcDYRA9Kktyc/X0WW37n0cyHQ
	 JTTywcy7Gn/EOov0vPraQPuSVl3nATLhhzHhWbu0ydPR5Mv3DFR+DTI1tn2SazyYPoGYM
	 1RNsU2VztTK2HVoHOyYLYP+iaO6VVObypfXO3qzP/cl6D6ElrF4Q4Rlc9g203jVxjc7Br
	 RLeyvgz5dr1HpNzZbwNbDwB2vv0vEf4gcYY8tzSgnfyENbH1yEP+tULHutg2xz9JRdByq
	 ZHOpKnQoELOahDt10ZxK7Rnpns8jn7oufoFWUpI+0pnyjKkuEvxN0RAqjYfjbzRSNyw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790602911;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=oKgeQ0GEq4NJdEG7jd2hRHS2qwkg+o6hBS5PRcLc1Ec=;
	b=YbNg6kuT0gtjtZvFymz+uPrLwsrqImYW8DUGwkAQ0syzGGQNLFWXVgvSFQvbRNKS1FwJ
	 r7m6EVtKWCoXMRth0Tp46Pyz7g5fMKoHs+9XxK3VPOptd1RE3cKE/BIkSFZ5d0klA9jcU
	 oHL8BC6UzOkZSaYe8teH6W2Bpim5DoIvu5BZdYOLPb3gQx2AM82r/nsCP9a/CGmOGMNt1
	 FWdo80NZoacqYgoCrSgPoZxTm/5Smj3ANkUFBL7Sq9yq86gSC8+1q/TYt05ketozrgC30
	 kxCC4AvfZIqIw8JPo4Xf0CLhZhPhcsGmN14kd2ac8Q90c2EUzJLh23tL+BAiOXLg5mg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b="P/zXbJf8";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790602911;
	bh=oKgeQ0GEq4NJdEG7jd2hRHS2qwkg+o6hBS5PRcLc1Ec=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=YGFBxqu17RoiViaK0doXA4hb4E7FYzaSkuVi5OQo8E+XgiHEDoISb+6/DVspMc0uM
	 tv9kuXUBndAnB53yfzBthRylTtICUEq976iWZ36jJ4aw5lOxEg6hYEjL+dOEJEU+vQ
	 ZBJPqXAikNdm212CCpvYATR2oAs6Gk0whK71Q0MxNwg9ElhvF4wOrMrbXAVIxib89v
	 WWmm97qRsS02/faC7yNb2lmD03jqZpLRqiOJGsw0CfmM+l49H2iGMSgCResHgPVgjh
	 pz+63WCe48mjLOendOgpx9r4xvYKYJgnsWCcCgtOZ1y48X6tbkDmcF+YJO4JdSM80r
	 aCR4LK6oOm/+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 667EA80E00;
	Mon, 28 Sep 2026 13:41:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8408F335
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 07:39:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4AF5380DA2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 07:39:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ki31frVWe2Us for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 07:39:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D0C2A80CC3
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790581143;
 b=m4xp6YJNzi66gQxO4f8/wBSkVbIkX1+xbloAEopwG4LwtB3leA+jUmkHEFl+XW0FCI/1
 O7dCnNp53ZwbR+uTVcgeVzIt3vuIOlsgOYQNRLVmG71HTa6S4fywzF/i/jsyNH8V6uxqe
 D9Stw/D2mW3wp3uVgziCv+LmTo8vuN9pvI7JPFyXxDZBrywHAKnx56/6c9gjOejPxobPX
 UoQfVfHRo+7IXyV72BRFS5gn2oFulRgYPfXQmmF2dqwwG9E3xfVF0/7cM8U4K7eKiFZGt
 rFocwODUcZ3+VNRo8RZxPqERIJYodYvkutB4F8j6KBqJjTE2BhYKmUB/tEFnxSE6Caw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790581143;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=oKgeQ0GEq4NJdEG7jd2hRHS2qwkg+o6hBS5PRcLc1Ec=;
 b=KnkjM/KyXsxhJ3CcwO8UQBknmKWOH0k9GMDrUx/Gw24BJNStfAEoHl0EC6uDYDYwZvvC
 IZAad49pp9zQZzWswSIOFmh/KmvF/0y7+ojFrPbM31QrlmJAup5DxvPmqXGna169zqb59
 7zL+0J1M0D5dyxfqB7Dzz0LQHQmqyKGNK03aoIULXQwJxZREjAcu3JlhN17PLNOTn0mr3
 XRlZKgO5TF4IrvdRejEVZIM/THJJ88NmFE2gI9vyW4ni/9sYDYyNjUPZtZsuFkCM16AsW
 4mYqNFv9/g2jDFhJHThSVc5GXbx0B1UkCob2kexttPGbg7SXOCidIQH/2JLPnS+fP2g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b="P/zXbJf8"; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+dinesh.v.adlinktech.com@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=P/zXbJf8
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D0C2A80CC3
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 07:39:02 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 298AA6025A;
 Mon, 28 Sep 2026 07:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D417AC4AF15;
 Mon, 28 Sep 2026 07:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1790581140;
 bh=ZXwRXkmFIx1gkn7++StEKHQa0uHuOJnReBpOGc7sToY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=P/zXbJf8kUDYMG2Ak/NNL0RdQKgBFrSEB9LZp9XuT5y36/XUK80FKX8AbXC2mMBHS
 WA4RlTaYdQITmyvIjLmJd8ae4uxCRKRpnG8ezNCMuyZKu2Ld9LMwjs/1gwtQyu0YCv
 GUcaF2R6tlQJJvAmjaPijU8rKd/pRqJZhXMZskgO1iOLsL0LZyW+RyjupNwvi1LfsJ
 7nnyNUBI9wk2SUaFNWKwSMJtgB6pvS8i4+9eKSrTuT0GLrtbIZVs967zmIiPCglGe3
 rvchhbaI06GQUZKIkVe9nbW7dClY10B33nPWHgeVj7km9c4fUmhtY/oivfJ63nZWC+
 StihV19bys/LQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id C1A23CA5FA1;
 Mon, 28 Sep 2026 07:39:00 +0000 (UTC)
From: Dinesh kumar v via B4 Relay <devnull+dinesh.v.adlinktech.com@kernel.org>
Date: Mon, 28 Sep 2026 13:09:00 +0530
Subject: [PATCH 4/4] doc: board: Add ADLINK LEC-iMX95 documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-lec-imx95-v1-v1-4-9e0c9b94ccbe@adlinktech.com>
References: <20260928-lec-imx95-v1-v1-0-9e0c9b94ccbe@adlinktech.com>
In-Reply-To: <20260928-lec-imx95-v1-v1-0-9e0c9b94ccbe@adlinktech.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Alice Guo <alice.guo@nxp.com>, Primoz Fiser <primoz.fiser@norik.com>, 
 Johan Jonker <jbx6244@gmail.com>, Simona Toaca <simona.toaca@nxp.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Dinesh kumar v <dinesh.v@adlinktech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790581138; l=6098;
 i=dinesh.v@adlinktech.com; s=20260928; h=from:subject:message-id;
 bh=D+6NvNmIm0LJXudZ7/tH+ziEcMPon/ZUEWt4pu5Yg7M=;
 b=IKKZbcSIOnoOALbxS+UI6z8J8HHpbw1EMqCal1vexaLheZtPdt1lAgHfBJW9nLfx0Bo4blCCE
 +aDpIgqS45UAgb9hF8gJJf7aOxbXfZ8fQ+CpYkUFIj+GZQ4hcYolAno
X-Developer-Key: i=dinesh.v@adlinktech.com; a=ed25519;
 pk=2+xm2aDQjQT68aPFzfLMgdZrQGpCMUU3Qp1CwWoRlus=
X-Endpoint-Received: by B4 Relay for dinesh.v@adlinktech.com/20260928 with
 auth_id=1074
X-Original-From: Dinesh kumar v <dinesh.v@adlinktech.com>
X-Mailman-Approved-At: Mon, 28 Sep 2026 13:41:44 +0000
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
Reply-To: dinesh.v@adlinktech.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Dinesh kumar v <dinesh.v@adlinktech.com>

Document how to build and boot U-Boot on the ADLINK
LEC-iMX95 SMARC module.

Signed-off-by: Dinesh kumar v <dinesh.v@adlinktech.com>
---
 doc/board/adlink/lec-imx95.rst | 183 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 183 insertions(+)

diff --git a/doc/board/adlink/lec-imx95.rst b/doc/board/adlink/lec-imx95.rst
new file mode 100644
index 00000000000..eab759d04df
--- /dev/null
+++ b/doc/board/adlink/lec-imx95.rst
@@ -0,0 +1,183 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Adlink SMARC iMX95 Module
+==========================
+
+ SoM: https://www.adlinktech.com/products/Computer_on_Modules/SMARC/LEC-IMX95
+ Carrier: https://www.adlinktech.com/products/computer_on_modules/SMARCStarterKits/I-Pi_SMARC_IMX95
+
+Quick Start
+-----------
+
+- Setup environment
+- Get ahab-container.img
+- Get DDR PHY Firmware Images
+- Get and Build OEI Images
+- Get and Build System Manager Image
+- Get and Build the ARM Trusted Firmware
+- Build the Bootloader Image
+- Boot
+
+Setup environment
+-----------------
+
+Suggested current toolchains are ARM 15.2 (https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads):
+
+- https://gitlab.arm.com/api/v4/projects/tooling%2Fgnu-toolchains-for-arm/packages/generic/gnu-toolchain/15.2.rel1/arm-gnu-toolchain-15.2.rel1-x86_64-arm-none-eabi.tar.xz
+
+.. code-block:: console
+
+    $ export TOOLS=<path/to/directory/with/toolchains>
+
+    # Update your package list
+	$ sudo apt update
+
+	# Install the aarch64 cross-compiler toolchain
+	$ sudo apt install gcc-aarch64-linux-gnu binutils-aarch64-linux-gnu
+
+Get ahab-container.img
+----------------------
+
+Note: `$srctree` is the U-Boot source directory
+
+.. code-block:: console
+
+    $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-ele-imx-2.0.2-89161a8.bin
+    $ sh firmware-ele-imx-2.0.2-89161a8.bin --auto-accept
+    $ cp firmware-ele-imx-2.0.2-89161a8/mx95b0-ahab-container.img $(srctree)
+
+Get DDR PHY Firmware Images
+---------------------------
+
+Note: `$srctree` is the U-Boot source directory
+
+.. code-block:: console
+
+    $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.28-994fa14.bin
+    $ sh firmware-imx-8.28-994fa14.bin --auto-accept
+    $ cp firmware-imx-8.28-994fa14/firmware/ddr/synopsys/lpddr5*v202409.bin $(srctree)
+
+Get and Build OEI Images
+------------------------
+
+Note: `$srctree` is the U-Boot source directory
+Get OEI from: https://github.com/ADLINK/imx-oei.git
+branch: main
+
+.. code-block:: console
+
+    $ git clone -b main https://github.com/ADLINK/imx-oei.git
+    $ cd imx-oei
+
+    $ make board=mx95lp5 oei=ddr DEBUG=1 r=B0 all
+    $ cp build/mx95lp5/ddr/oei-m33-ddr.bin $(srctree)
+
+    $ make board=mx95lp5 oei=tcm DEBUG=1 r=B0 all
+    $ cp build/mx95lp5/tcm/oei-m33-tcm.bin $(srctree)
+
+    $ make board=mx95lp5 oei=dat DEBUG=1 r=B0 all
+    $ cp build/mx95lp5/dat/oei-m33-dat.bin $(srctree)
+
+
+Get and Build the System Manager Image
+--------------------------------------
+
+Note: `$srctree` is the U-Boot source directory
+Get System Manager from: https://github.com/ADLINK/imx-sm.git
+branch: main
+
+.. code-block:: console
+
+    $ git clone -b main https://github.com/ADLINK/imx-sm.git
+    $ cd imx-sm
+    $ make config=mx95lec all
+    $ cp build/mx95lec/m33_image.bin $(srctree)
+
+Get and Build the ARM Trusted Firmware
+--------------------------------------
+
+Note: `$srctree` is the U-Boot source directory
+Get ATF from: https://github.com/nxp-imx/imx-atf/
+branch: lf_v2.14
+
+.. code-block:: console
+
+    $ export CROSS_COMPILE=aarch64-linux-gnu-
+    $ unset LDFLAGS
+    $ unset AS
+    $ git clone -b lf_v2.14 https://github.com/nxp-imx/imx-atf.git
+    $ cd imx-atf
+    $ make PLAT=imx95 bl31
+    $ cp build/imx95/release/bl31.bin $(srctree)
+
+Build the Bootloader Image
+--------------------------
+
+.. code-block:: console
+
+    $ export CROSS_COMPILE=aarch64-linux-gnu-
+    $ make lec-imx95_defconfig
+    $ make
+
+Flash to SD card
+-------------
+
+.. code-block:: console
+
+	$ sudo dd if=flash.bin of=/dev/sd[x] bs=1k seek=32 conv=fsync
+
+
+Boot
+----
+
+Boot sequence is:
+
+* SPL ---> ATF (TF-A) ---> U-Boot proper
+
+Output:
+
+.. code-block:: console
+        U-Boot SPL 2026.10-rc5-00542-g2b8902913c19-dirty (Sep 28 2026 - 10:58:03 +0530)
+        SYS Boot reason: por
+        Normal Boot
+        Trying to boot from MMC2
+        Parse v2x container failed -14
+        Load image from MMC/SD 0x136c00
+        NOTICE:  BL31: v2.14.1(release):lf-6.18.20-2.0.0
+        NOTICE:  BL31: Built : 17:41:10, Sep  2 2026
+
+
+        U-Boot 2026.10-rc5-00542-g2b8902913c19-dirty (Sep 28 2026 - 10:58:03 +0530)
+
+        CPU:   NXP i.MX9596 Rev2.0 A55 at 1800 MHz
+        CPU:   Extended Industrial temperature grade (-40C to 125C)
+        Model: Adlink LEC iMX95 on I-Pi SMARC Development Board
+        DRAM:  3.8 GiB
+        Core:  270 devices, 23 uclasses, devicetree: separate
+        MMC:   FSL_SDHC: 0, FSL_SDHC: 1
+        Reading from MMC(1)... *** Warning - bad CRC, using default environment
+
+        In:    serial@44380000
+        Out:   serial@44380000
+        Err:   serial@44380000
+
+        BuildInfo:
+        - ELE firmware not included
+
+        switch to partitions #0, OK
+        mmc1 is current device
+        Net:   WARNING: no MAC address assigned for MAC0
+        imx_get_mac_from_fuse: fuse read err: 0
+
+        Warning: enetc-0 (eth0) using random MAC address - 1e:2c:49:99:cc:07
+        eth0: enetc-0 [PRIME]WARNING: no MAC address assigned for MAC1
+        imx_get_mac_from_fuse: fuse read err: 0
+
+        Warning: enetc-1 (eth1) using random MAC address - 86:60:fa:e7:ef:59
+        , eth1: enetc-1
+        Hit any key to stop autoboot: 0
+        u-boot=> net list
+        eth0 : enetc-0 1e:2c:49:99:cc:07 active
+        eth1 : enetc-1 86:60:fa:e7:ef:59
+        u-boot=>
+```

-- 
2.25.1


