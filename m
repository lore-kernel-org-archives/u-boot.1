Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6366FC982FA
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 12:47:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1CF5560847;
	Wed, 23 Sep 2026 12:47:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tgolGas6hGjW; Wed, 23 Sep 2026 12:47:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 629CA60823
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790167658;
	b=eK/bNQTJbBlzEcr3jlCC47TmKr0rZ4MXHmkgmK/bWT5u1/Y276G6yljzkaD4/Ax8AGgx
	 c6ux8cDD3F85kvP1c/npGJ9tpXsRwgWBYFe6RnU3Xe7UInE57Y0m5aJ/KRmymCskp3m+x
	 Of9Ca7DrVY8X9U8aNntw1SUOJHEYX0BJh0b6iPbvFfgae5/InMDDRjdWpLtJiqSDmOkUT
	 wzxlqZTfYUCevcaJm+TzpEA9MIYmtoGF48nBdPGgj8InXEZAneQHGOQWZBFLKBxMOA77t
	 nyqCwpNFvIMu26lcsBf/Zcw84zdQFmsEjoPxVFRMrBLH+Oazr69qsZhuSSGSPgqE51g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790167658;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9BfhHb3IuZu8aK/oKsCRv71mAw9TzSTvU5D8geoHrUg=;
	b=F2zWGzeKvzd+Ba9jGQydS+YjZZqeFByVFaRb0bHvm52iEE1xwzkLXFq45XXwaaN/2Tgk
	 igjiaXWmUyLxoySSwLoCoB/ItqOTh2lQTo0VFPqzL3m9I5Jge+b6uRYUKbIcUJUMHGejL
	 vK3s8QhK7IplavPVs6lh+J4/6bX97KSS54bUWTUTFCYzQLUFA+b3K4BFMJ8AUoYC8RPVV
	 8QST8f9dzbprP36PcD1CGX4IF8uyx8iGnuJwiynUHTA9PIzjd9dXkG+MOJFTmCCh5mgmL
	 YsYnkVATwtaLkbRVwnRxvQOYnqkc+wt2lB+MtXuXps0MiRv4naahfyRkY7MPipZ2MGA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790167658;
	bh=9BfhHb3IuZu8aK/oKsCRv71mAw9TzSTvU5D8geoHrUg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KHCeYuwUudCDSRy9ffsFCGzSDE/Oa8g4nXMdacJbrlLb8d33p3PfXL8Vcwg72Wn6d
	 SQ6Idu+Z+dIYoZri4usA5PpSQRRvXzocWyzbHfGjXOdaoCwZilcldYpAWfMmaxto9y
	 0zrFMfIa2/tkvvrkFva779pV5Nmln8WP1xAXg0XpORJT/uVdwk4HDFzgzrvDdKyf3g
	 G8IkZQi94XJfe5x/WGFxA8Dba7SFr2ptKouWh9+aIKW5G8r55nl44ccBj4+gkKzRdM
	 dolI8LYYaOJj1BF5k7Oc7hAoowTcVkL93w5j4VDRdxszCZp6Hwfzljai0MxC/LeLWr
	 WlQ5ultZeJmJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 629CA60823;
	Wed, 23 Sep 2026 12:47:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 286743A9
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 12:47:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0F09240353
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 12:47:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IK5-v2Is4wxR for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 12:47:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org AFBAF4035E
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790167652;
 b=N1srU+tE/Z6xiH68M39+rPX2XJ8NRkcCATfBe7iQWBbcM0fwbdIK4D2k8n7DI+dEJZ4u
 7Mu9Z/bXDdNPqdkDHEGcbLqsm0VOBPNpUYPUeIk3uQhCH5EBztjNt7FZPRQvhCCa7TTXx
 8sNAh7xxS3wmQQ9KcqU8Y1XcKfYWBl10nfEzm1eeqMXMD4opJq4S59AND9m6BvZrhTxQK
 KZAqnN5VgPX/lYEZUKDV1vNQ55b9ylE//QyXiVlBojLt2g4G9ug3kSHbEQgTRWPVk3yn2
 pWjpKYTBlinzT541ZDDqmQOjnLfeWmAyn5bn/aqa+0uHafA1S4KJhxiPSXQqCSrsAbw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790167652;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=9BfhHb3IuZu8aK/oKsCRv71mAw9TzSTvU5D8geoHrUg=;
 b=giKXYp5owovTrfJdgPzPIwUnMCO8/pnAxIAU83GD1A8HjG/ytZ+w4la7IH2vzs4Hj5/4
 zJ3ahxFynEkbXln7LD8O93q4GOMG5iqWvRalyuFFpQmHfhQZ9MBmO9LeOBUoWJKTAbPOv
 ltc1PMWF0yXayYsTxg54TpavO3CmorR4/qjCWCcGAthnaVNuGwD0nmRjw5ZKB0vUqnXEH
 huvrhSNmCd2TDA0ZAdDpSRyUsvG/GT1Q/2+FO6RzcvSZxE+iEdkQp1nmG/RurtppYbwiR
 +fQp0EGPDBMgjmDD+gMVA0zFy0zFUm0vRdVbFSWl11yhyfyLj4mjYkDXahRvXQP0uFQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=L3tSpjRY; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=L3tSpjRY
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AFBAF4035E
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 12:47:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5CC22600AA;
 Wed, 23 Sep 2026 12:47:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361521F00893;
 Wed, 23 Sep 2026 12:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790167651;
 bh=9BfhHb3IuZu8aK/oKsCRv71mAw9TzSTvU5D8geoHrUg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=L3tSpjRYvaD8Zib0Z1K+vYOd3HW1wIGWgRA9SOyDuay2lKIHpuvBIKrmfhZUy7a2G
 OfTZE0HP5JrV4EdmApa9kI+hlvI689pY5fM7lkamPWSpbnPRvx/kAr0ZNjjwP7e62t
 sEjS5GgJCgTNqqHHzohNBk5fNsxEfFrQjR7H5H7rlSQHgTIihHfDkf6RFOV6q8Qbx9
 HdZTudMnWJhSJ658c2Zbw4GdJRt6kR8zsLp5pZzD125a3rlL99nMNiycGbgEVjJsjL
 PGR1sSYE71nUVjmhAu1upXedBh2hhR69kb3gj1xJKDBh7FiYQiXIa/NDgIg26hdyJq
 0y5Osc4E2kanA==
From: Yixun Lan <dlan@kernel.org>
Date: Wed, 23 Sep 2026 12:46:48 +0000
Subject: [PATCH 4/4] doc: spacemit: k3: Add Pico-ITX board
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-00-basic-spacemit-k3-v1-4-fa1015f2cd1b@kernel.org>
References: <20260923-00-basic-spacemit-k3-v1-0-fa1015f2cd1b@kernel.org>
In-Reply-To: <20260923-00-basic-spacemit-k3-v1-0-fa1015f2cd1b@kernel.org>
To: u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Hiago De Franco <hfranco@baylibre.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7980; i=dlan@kernel.org;
 h=from:subject:message-id; bh=dd7vetXP+05jcrNd/Ra9yG9ptmNsuxJaRRv7caf8M20=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqs8pNSbbyUDMMOsFq5iW2oINBkZ5zoJbhnvYZM
 D1WFb1d0ZGJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCarPKTRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+2zJg//RAiDV6kA0TgS3kpd688OuV7gq8lzpZ7W9wh3mfI/jhbp6PnATuac2
 AWtb5ye/1bNwMb6UDv2fVIyj9yAfijz1QotQJu2qtjGWpRggYv3VHakByosd2R7FdM0n+D+x96V
 UraTtvxaBilsSizDsEBgJ/mmfjADiTkqFeVJBoJhv8ythXdc0PxzE5KDlqRrX+C8Er0Nac8c4nt
 6r+AByW8bkltew13WQkBr9YDzmmACHtTJ1p3N+3Rm29gPWsNgcjR9GDHjzvTIw1GGZJj4Tkcym+
 lFGPy3xgATKI7wICAuuzyKKDdTR90sMLzHa+F8oIkYy2WpbjNjCRNFJqlytuI3hcZ8+KD1uM0Q1
 pqJkxV+nNn6vBH8P1LIr0T3yfaKkQFBfmtetPR/agrc8ibAiweyQ2HJgJ3bnCwUu9M+XO8qfkA2
 tvAgmxqqFNJ1CXVfY9cU9GKgFPWi4meYmOuKmNo65ewRCTTSZBxM23NumWAsGeOsamkY7cjYKjO
 cOJI9CokH0T5NSJZXSINc5uG4iDh78kKYYW99L1mebwEODCLjlluVZS+qhi0y1BW/J0pDHmoiUn
 FyJAZWuCkR5thpuDLbuoLB6Y9Yfnzn7yNaa1hQOUsqSrLW2zl6yvCkQ6N2/I69YA4dMtJ5Xk4en
 kjUyrJ2QOVtSog+67LrPXAWVD4Allo=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
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

Add documentation for how to test the mainline U-Boot on SpacemiT
K3 Pico-ITX board, currently it still rely on using vendor FSBL.bin
file to initialize DDR and boot U-Boot proper, and the opensbi
firmware is built from an on-going mainline branch.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 doc/board/spacemit/index.rst             |   1 +
 doc/board/spacemit/spacemit-pico-itx.rst | 204 +++++++++++++++++++++++++++++++
 2 files changed, 205 insertions(+)

diff --git a/doc/board/spacemit/index.rst b/doc/board/spacemit/index.rst
index a5e35ee12ab..735ccdcc7b9 100644
--- a/doc/board/spacemit/index.rst
+++ b/doc/board/spacemit/index.rst
@@ -7,4 +7,5 @@ SpacemiT
 
    bananapi-f3
    k1-spl
+   spacemit-pico-itx
 
diff --git a/doc/board/spacemit/spacemit-pico-itx.rst b/doc/board/spacemit/spacemit-pico-itx.rst
new file mode 100644
index 00000000000..dd29e3c31c8
--- /dev/null
+++ b/doc/board/spacemit/spacemit-pico-itx.rst
@@ -0,0 +1,204 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+SpacemiT K3 Pico-ITX
+====================
+
+Building
+~~~~~~~~
+1. Install the SpacemiT riscv cross compile toolchain_, or skip it if riscv toolchain is installed.
+
+.. _toolchain: https://archive.spacemit.com/toolchain/
+
+2. Setup cross compilation environment variable:
+
+.. code-block:: console
+
+   export CROSS_COMPILE=<riscv64 toolchain prefix, e.g /opt/spacemit/bin/riscv64-unknown-linux-gnu->
+
+3. Before building U-Boot, OpenSBI should be built first. OpenSBI can be
+built for SpacemiT K1 SoC as below:
+
+.. code-block:: console
+
+   git clone https://github.com/spacemit-com/opensbi-upstream opensbi
+   cd opensbi
+   make PLATFORM=generic
+
+4. Then build U-Boot as following:
+
+.. code-block:: console
+
+   cd <U-Boot-dir>
+   make spacemit_k3_defconfig
+   make OPENSBI=<OpenSBI-dir>/build/platform/generic/firmware/fw_dynamic.bin
+
+This will generate u-boot.itb
+
+Testing
+~~~~~~~
+Currently, in this stage, the U-Boot SPL isn't ready, and has no ddr initialization code
+Thus please test with fasboot command via USB download.
+
+First, retrieve Bianbu Linux image from archive_ and extract the FSBL.bin firmware.
+
+Second, hold the FEL button of Pico-ITX board, then press reset button and release it .
+The board will enter into firmware download mode.
+
+.. code-block:: none
+
+   sys: 0x10001200
+   bm:2
+   usb_init : enter 3296,3072
+   usb_core_init : enter
+   DWC3_GRXTHRCFG:0x4400000
+   ROM: usb download handler
+    rst
+   done H
+   setup= 0x1000680 0x400000,
+    rst
+   done H
+   setup= 0x290500 0x0,
+   setup= 0x1000680 0x120000,
+   setup= 0x2000680 0x90000,
+   setup= 0x2000680 0x200000,
+   setup= 0x3000680 0xff0000,
+   setup= 0x3020680 0xff0409,
+   setup= 0x3010680 0xff0409,
+   setup= 0x10900 0x0,
+   usb_rx_bytes : start len[4096]
+   setup= 0x3020680 0xff0409,
+   setup= 0x3040680 0xff0409,
+
+Run following command to test:
+
+.. code-block:: console
+
+   fastboot stage FSBL.bin
+   fastboot continue
+   sleep 10
+   fastboot stage u-boot.itb
+   fastboot continue
+
+.. _archive: https://archive.spacemit.com/image/k3/version/bianbu/v4.0.7/
+.. _uboot: https://bianbu-linux.spacemit.com/en/device/boot#21-firmware-layout
+
+Booting
+~~~~~~~
+Sample boot log
+~~~~~~~~~~~~~~~
+.. code-block:: none
+
+   sys: 0x10001200
+   bm:2
+   usb_init : enter 3296,3072
+   usb_core_init : enter
+   DWC3_GRXTHRCFG:0x4400000
+   ROM: usb download handler
+    rst
+   done H
+   setup= 0x1000680 0x400000,
+    rst
+   done H
+   setup= 0x2f0500 0x0,
+   setup= 0x1000680 0x120000,
+   setup= 0x2000680 0x90000,
+   setup= 0x2000680 0x200000,
+   setup= 0x3000680 0xff0000,
+   setup= 0x3020680 0xff0409,
+   setup= 0x3010680 0xff0409,
+   setup= 0x10900 0x0,
+   usb_rx_bytes : start len[4096]
+   setup= 0x3020680 0xff0409,
+   setup= 0x3040680 0xff0409,
+   fastboot_handle_command: max-download-size
+   usb_tx_bytes : start len[14]
+   usb_rx_bytes : start len[4096]
+   fastboot_handle_command: 00072b20
+   Starting download of 469792 bytes
+   usb_tx_bytes : start len[12]
+   usb_rx_bytes : start len[469792]
+   usb_tx_bytes : start len[4]
+   usb_rx_bytes : start len[4096]
+   fastboot_handle_command: continue
+   usb_tx_bytes : start len[4]
+   j...
+
+   U-Boot SPL 2022.10 (Sep 07 2026 - 11:31:13 +0000)
+   LPDDR5 total size: 16 GB, data rate: 6400 MT/s
+   DDR training consume 5625ms
+   ..
+   OpenSBI v1.9-72-g13a401f8
+      ____                    _____ ____ _____
+     / __ \                  / ____|  _ \_   _|
+    | |  | |_ __   ___ _ __ | (___ | |_) || |
+    | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
+    | |__| | |_) |  __/ | | |____) | |_) || |_
+     \____/| .__/ \___|_| |_|_____/|____/_____|
+           | |
+           |_|
+
+   Platform Name               : SpacemiT K3 Pico-ITX
+   Platform Features           : medeleg
+   Platform HART Count         : 8
+   Platform HART Protection    : pmp
+   Platform IPI Device         : aclint-mswi
+   Platform Timer Device       : aclint-mtimer @ 24000000Hz
+   Platform Console Device     : uart8250
+   Platform HSM Device         : spacemit-k3-hsm
+   Platform PMU Device         : ---
+   Platform Reboot Device      : spacemit-p1-reset
+   Platform Shutdown Device    : spacemit-p1-reset
+   Platform Suspend Device     : ---
+   Platform CPPC Device        : ---
+   Firmware Base               : 0x100000000
+   Firmware Size               : 416 KB
+   Firmware RW Offset          : 0x40000
+   Firmware RW Size            : 160 KB
+   Firmware Heap Offset        : 0x57000
+   Firmware Heap Size          : 68 KB (total), 1 KB (reserved), 14 KB (used), 52 KB (free)
+   Firmware Scratch Size       : 4096 B (total), 1472 B (used), 2624 B (free)
+   Runtime SBI Version         : 3.0
+   Standard SBI Extensions     : time,rfnc,ipi,base,hsm,srst,pmu,dbcn,fwft,legacy,dbtr,sse
+   Experimental SBI Extensions : none
+
+   Domain0 Name                : root
+   Domain0 Init Order          : 0xffffffff
+   Domain0 Boot HART           : 0
+   Domain0 HARTs               : 0x0*,0x1*,0x2*,0x3*,0x4*,0x5*,0x6*,0x7*
+   Domain0 Region00            : 0x0000000100000000-0x000000010003ffff M: (F,R,X) S/U: ()
+   Domain0 Region01            : 0x0000000100040000-0x000000010007ffff M: (F,R,W) S/U: ()
+   Domain0 Region02            : 0x00000000d4017000-0x00000000d4017fff M: (I,R,W) S/U: (R,W)
+   Domain0 Region03            : 0x00000000e081c000-0x00000000e081ffff M: (I,R,W) S/U: ()
+   Domain0 Region04            : 0x0000000000000000-0xffffffffffffffff M: () S/U: (R,W,X)
+   Domain0 Next Address        : 0x0000000102000000
+   Domain0 Next Arg1           : 0x0000000102091398
+   Domain0 Next Mode           : S-mode
+   Domain0 SysReset            : yes
+   Domain0 SysSuspend          : yes
+
+   Boot HART ID                : 0
+   Boot HART Domain            : root
+   Boot HART Priv Version      : v1.12
+   Boot HART Base ISA          : rv64imafdcbvhx
+   Boot HART ISA Extensions    : smaia,smstateen,sscofpmf,sstc,zicntr,zihpm,smcntrpmf,zicboz,zicbom,svpbmt,sdtrig,svade,ssstateen,v,f,d
+   Boot HART PMP Count         : 16
+   Boot HART PMP Granularity   : 12 bits
+   Boot HART PMP Address Bits  : 38
+   Boot HART MHPM Info         : 16 (0x0007fff8)
+   Boot HART Debug Triggers    : 4 triggers
+   Boot HART MIDELEG           : 0x0000000000003666
+   Boot HART MEDELEG           : 0x0000000000f0b509
+
+   <debug_uart>
+
+
+   U-Boot 2026.10-rc4-00501-g9fba7b59df42 (Sep 22 2026 - 13:08:33 +0000)
+
+   DRAM:  16 GiB
+   Core:  433 devices, 15 uclasses, devicetree: separate
+   Loading Environment from nowhere...Loading Environment from nowhere... OK
+   In:    serial@d4017000
+   Out:   serial@d4017000
+   Err:   serial@d4017000
+   Net:   No ethernet found.
+   =>

-- 
2.55.0

