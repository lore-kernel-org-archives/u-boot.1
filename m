Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBC5606A31C
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 02:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Cl5Uduio;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=axZPWij1;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=vSrybvVw
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5EEE1810E4;
	Fri, 30 Oct 2026 02:08:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hdq8xKQGuXVr; Fri, 30 Oct 2026 02:08:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 80B1780A89
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793326121;
	b=Y/yIEl1oDVZb7iiGzLM7gOtT9UIe0S4yfjeZ4fQac1YGvSs+Fp6l4RFZF0c4y94X2Gag
	 R7y2lATWNTIF1Be8SXJByOdWeffpiqFMMbrPzfU+AhSWHiijrnBylU3H0vYGmX0RjxLDc
	 D6IaZACvvwOen0PnNHVaBOXMJvYYgrup1RPwOe8codZk1GT7JaSzju9/mwt4Dx+vBUsyD
	 n5NK7VmsoZR+Wng4AeMLIqbp1tXU8Se6Y09bj1bnKbcbCRKWdhYklALW6smtL9qxuSTyY
	 BWLfypD+YKD4VRXSf2Swu+H+GUtYtLASYtGY6SHB0BFrtPIiQ07VUIOfXODgmHlVAaQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793326121;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=w9bAa4TCQ3c4/N3lNTDw4F2ZWItqfQzc/+4gky3GA58=;
	b=YyM70hQnblwoMLAYCCo6J5YTlIWGBx/PhHUGPrTblgRD9/An1/OphjcGWTQgQxZk2GS4
	 sa8jKJQ+5Se6UiHXRWuXrj0UJb3B0i/q+ER+Zwgp9Sk6EKFWf2PTGx+ut/jyEGEQPouhc
	 0uwrkzjvhiHlAlngIZZrq8eLymh+C4OxZGKWUN++3PMSA/2Frlk4ySrOAgSj9v474Kjqk
	 7ZwVDohKFpUP4oUACLyg9NHbx2aVHT6mA3vg6aYbr4JeCf8MBuKHQKe3dRHaxxbgSyA1/
	 gz/LhzLBlR/ye5oZWqekx3gu8uGKnAPl3ZEWqLftRRyZtRnFS8ICI5wbnxVHF4TJPwA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793326121;
	bh=w9bAa4TCQ3c4/N3lNTDw4F2ZWItqfQzc/+4gky3GA58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Cl5Uduio6yf8VwICqRcnt6Zf6zzvozK1LE2PwEiqqV7cIFH2TdEBgSFL8CtomjEEz
	 xVkIYEA0jc2v8s60/xK6l1Pvvq9YGig9W2dlwSGegbaHdDSqW6qmTtXNhUC4Fvwpg7
	 4XQXHXnjl6lKlYj8L6P2ilUsFpg2mzOCcC+UzAn5dviSV1DsnyvWbDW/6V9HuEyezL
	 0WpDbcokZQUBtjrPNYnwRw0ZTXjinLdtQOR+zgvKLsbo154p6wNIe5khcCJxzQWfYI
	 yuRrb55xgVmlmkajOKnrUY2V5RGam9bDNRlzphzgaM9ev9km/0EJTrjmPFNmaKmXfb
	 sJ1tcMhdRZBDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 80B1780A89;
	Fri, 30 Oct 2026 02:08:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id 4D02A362
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 02:08:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with UTF8SMTP id 3E8214057E
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 02:08:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id wdoGfuHeifXS for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 02:08:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 34112405E8
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793326116;
 b=bTObVHLorVzDsR0qTeKfo/Ou3whrfPS7jBOqKcQJ5OF+3MUpxGI0Il/Hv2vmBZxLcmWF
 un1hy+WY70OJ7lnLSbo332pRwAqxnmxcKnL76wcn73Uh7J90Ef4JxHLJZwwsvmzzI7wTr
 EnDsE3szvgl1o3NEFli/CuuNGUbdSR7kPbTcEw5d++gugyDs79kpKl5m2NtM0chGguRcR
 YHisy/hOZoWxFhn81AaV/V5c+vlVSSpbD6BqjH5Bqs09GpYYOLGGPFyzhkUCaNxjOHlNi
 LJC/tMvttNXg3OevzMG43PJYQQNcP+tCNJETXBDJVlmsL56Cc1cH5m6O2Vnha5e72wA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793326116;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=w9bAa4TCQ3c4/N3lNTDw4F2ZWItqfQzc/+4gky3GA58=;
 b=LX9xo11+Oiq1/HUGf4DTznPjzOvcWbYrTdQC6CyTDgD/ctMhVeiTihY2f44RxVH/bv69
 TjeY1olEEkP2pdisNYcHk4nge3j7qTXbTjrpCuCNS31rxe/BOnKef9LW8CFxSHUIL81Lt
 OuoeDX11drtbnh8QMlvcdjTON6G/KMeccaROn4g/0ekKO6aoEvuQjaT97jU4S0mFaoAxh
 rzaToX7JWgcgNoXFJ8OMjUCKy8m6+627DNddJNvVKahN8LDLjCiU4Mj+UxIyLy75k8D7I
 j0HY3ng4+chgd8XR0KgPEKOxsOUDAWXVTFZw7OEX0Ywpnvg82h4w/4tr7nPkNVeigNg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=axZPWij1; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=vSrybvVw; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=axZPWij1; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=vSrybvVw
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp4.osuosl.org (Postfix) with UTF8SMTPS id 34112405E8
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 02:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1793326112; bh=w9bAa4TCQ3c4/N3lNTDw4F2
 ZWItqfQzc/+4gky3GA58=; b=axZPWij1hEVftVdVK28xK3i7Bn0m7/uwbz8NmJaLyEYje45Ccu
 8gIlxmcfr1PM37KDNTg7qsI29Md9+GRS622FSxodpHNxM6e0ThjTOLRIb7O3jWfI8vj6b/jOmPi
 4WqfF5x1LBGXAFq0/JOhUBqmHu6iDNjZCYELW9xNAUwwa0Pg7WjmXckNOQtTWmlGnvjQX8kmmjY
 Z9kx6N57NZalHMAP7FTQpf2aLzFGdmM4EgA/m7WNLBMoag0PrjXSfbjjrA+dy6AGbHVfVg0CE0G
 zTdNyLUvwo4CjsrrtWEiBJKU2enk4ZSHHYKaMIln0RdeuiqyhadqapYbUynk+eocBsQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1793326112; bh=w9bAa4TCQ3c4/N3lNTDw4F2
 ZWItqfQzc/+4gky3GA58=; b=vSrybvVwqUKTlxFzjU6d/QbBYQDBn0NIjGpG6MuJwwWxUBz7d+
 33vWXOJL/4YNWSp8yZ4CN1h/uMAlMaOtWtBA==;
From: Bradley Morgan <brads@mainlining.org>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com,
	brads@mainlining.org
Subject: [PATCH v2 4/4] doc: arch/powerpc: add a booting and porting guide
Date: Fri, 30 Oct 2026 02:08:31 +0000
Message-ID: <20261030020832.26572-5-brads@mainlining.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261030020832.26572-1-brads@mainlining.org>
References: <20261030020832.26572-1-brads@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Nothing explains what runs between reset and the prompt, and porting a
board is scattered over whatever README a sibling board happens to have.
Add a page with the boot flow, booting a kernel and the file by file
porting steps.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 doc/arch/powerpc/index.rst   |  1 +
 doc/arch/powerpc/porting.rst | 78 ++++++++++++++++++++++++++++++++++++
 doc/arch/powerpc/powerpc.rst |  4 +-
 3 files changed, 82 insertions(+), 1 deletion(-)
 create mode 100644 doc/arch/powerpc/porting.rst

diff --git a/doc/arch/powerpc/index.rst b/doc/arch/powerpc/index.rst
index 0663b305af3..66bffaa9270 100644
--- a/doc/arch/powerpc/index.rst
+++ b/doc/arch/powerpc/index.rst
@@ -10,3 +10,4 @@ PowerPC
    powerpc
    boot
    pbl
+   porting
diff --git a/doc/arch/powerpc/porting.rst b/doc/arch/powerpc/porting.rst
new file mode 100644
index 00000000000..de4c0e8f525
--- /dev/null
+++ b/doc/arch/powerpc/porting.rst
@@ -0,0 +1,78 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. Copyright (C) 2026, Bradley Morgan <brads@mainlining.org>
+
+Booting and porting
+===================
+
+How it boots
+------------
+
+On a NOR boot the CPU comes out of reset in the top 4K boot page, at
+CFG_RESET_VECTOR_ADDRESS. That page holds .bootpg from start.S and
+.resetvec from resetvec.S. From there:
+
+* start.S sets up the early TLB and a stack and calls cpu_init_f for the
+  early CPU and memory controller setup
+
+* board_init_f runs the init sequence, brings DRAM up (or just sizes it
+  on RAMBOOT) and picks where to relocate to, then calls relocate_code
+
+* U-Boot carries on from DDR, board_init_r brings up the rest and you get
+  a prompt
+
+On RAMBOOT boards the BootROM has already applied the RCW and the PBI and
+loads the image for you, see :doc:`/arch/powerpc/pbl`. Where an SPL runs
+first it brings DRAM up and loads U-Boot proper, and the P1010 and P1020
+NAND boards push the DDR init down into a TPL instead. The image layouts
+are in :doc:`/arch/powerpc/boot`.
+
+Booting a kernel
+----------------
+
+Nothing special, the board READMEs have the usual recipe. P2041RDB:
+
+.. code-block:: console
+
+   => tftp 1000000 uImage
+   => tftp 2000000 rootfs.ext2.gz.uboot
+   => tftp 3000000 p2041rdb.dtb
+   => bootm 1000000 2000000 3000000
+
+The rest is normal U-Boot business, see :doc:`/usage/cmd/bootm` and
+:doc:`/develop/bootstd/index`.
+
+Porting a board
+---------------
+
+Start from the board that is closest to yours, same SoC and same boot
+medium, and clone the pieces:
+
+* a TARGET_FOO entry in arch/powerpc/cpu/<family>/Kconfig, with the
+  ARCH_MPCxxxx select for the SoC, SUPPORT_SPL or SUPPORT_TPL if you need
+  them, and a source line for the board Kconfig
+
+* board/<vendor>/<board>/ with a Kconfig (SYS_BOARD, SYS_VENDOR and
+  SYS_CONFIG_NAME), the Makefile, board code with board_early_init_f and
+  friends, and ddr.c
+
+* include/configs/<board>.h, or the shared one a sibling board uses, for
+  whatever has not moved to Kconfig yet
+
+* a defconfig in configs/: cp the closest one to configs/<board>_defconfig,
+  make <board>_defconfig, tweak it, make savedefconfig and copy the result
+  back
+
+* a dts in arch/powerpc/dts/, added to a dtb-$(CONFIG_TARGET_FOO) line in
+  the Makefile, with CONFIG_DEFAULT_DEVICE_TREE pointing at it
+
+The fiddly bits are CONFIG_TEXT_BASE, the DDR timings, the boot medium and
+the RCW and SerDes protocol. Copy them from the evalkit board and only
+change what the schematic says is different.
+
+First boot
+----------
+
+Do not flash until the image runs from RAM. Load it over JTAG, or tftp it
+from a U-Boot that already works and run it, same as :doc:`/arch/powerpc/pbl`
+says. If nothing comes out of the serial port, check the baud rate, the
+boot switch, the RCW and the DDR setup, in that order.
diff --git a/doc/arch/powerpc/powerpc.rst b/doc/arch/powerpc/powerpc.rst
index 8ce28569ebe..8ee4f19870b 100644
--- a/doc/arch/powerpc/powerpc.rst
+++ b/doc/arch/powerpc/powerpc.rst
@@ -153,13 +153,15 @@ Four things:
 
 * a dts in arch/powerpc/dts/ if OF_CONTROL is used
 
-No magic here, other architectures do the same.
+No magic here, other architectures do the same. The long version, with
+the files and the commands, is in :doc:`/arch/powerpc/porting`.
 
 More reading
 ------------
 
 * :doc:`/arch/powerpc/boot`
 * :doc:`/arch/powerpc/pbl`
+* :doc:`/arch/powerpc/porting`
 * doc/README.pblimage
 * doc/README.ramboot-ppc85xx
 * doc/README.mpc85xx-sd-spi-boot
-- 
2.47.3

