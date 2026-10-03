Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A82CA5FE3
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 00:35:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A31FB60653;
	Sat,  3 Oct 2026 00:35:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yDSvodSELkQ9; Sat,  3 Oct 2026 00:35:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7292E60666
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790987735;
	b=fL/4SEoxPsY3lg+qfFcbte5aH1BydT7qKWqEHJC/3C/+DrOrmhbGxifGMYzIVwOkjQ1x
	 EaZSh+W97gBbSDbleixIYKkNy9bs5LzJQRuCr/6nAsZ9eNYQN4E0yutK9/wIlttsrGnTK
	 A1RncqodPFz38EFMnFvwNCderXr0NNUMYuL89ElLnp4wmB9lYKkzD/mEf+lfW4/24pVgl
	 rLDyk5putEU6I1s1WqdCkTsbW7cCWmetGZKwEzdwYMzsMzMlfq18Ke10+i+ZX3gQiP6S+
	 qbhpYe3Y0Wzg2wV/SMw6FVSdqmpV6Gjx+fM7pqHGfK/tu6MiEaI+RKJGxL2n7p7po/Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790987735;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Uf8HNQJey/dLhCBM56zAelAII/H0ESSWyfxM1ERJzWs=;
	b=j+jHsnk9s/X4ftHc2NCgWTn5yAf9mLsTEsn+rT9Sc9CeA2uKfHnlqmy9qmUiifCsE3CM
	 TR8rzervZ22xPkLDXMYS4m+2aAUC1mjU5nu+CG8B0YuX+WSgvsmYDVCoMkPrcxvBe3nCr
	 eewezqFxinDRgmPD62jkkV+xvJbY123KdUZwdlXSO/OQ2YZESGtZSkHWx6bhH9THQ0I4P
	 gxvz7TGTM3X2ILVbv/1MFF1+mjH3FjPiDesrNw4cWBGSGN+ZQ3+YKJq/nNSwWk+4YkVY5
	 C88chnDrc/ATQq0zIfk+2ddqf0McOgoX1kPB79MUAdLPP6Hi2RQHkMpFsquJ1sUrsbw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790987735;
	bh=Uf8HNQJey/dLhCBM56zAelAII/H0ESSWyfxM1ERJzWs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oWbJLchqdgj322jysiRT73kd1n8OS7YyzZ17f5jikRk6OVQERyS7d2ZWVFyDy3RNu
	 u6PzESbzwZzpPXQKbWufz7MQBRU7A4g2UAarX4FzVefAuv+SoHlxj5LjuSchKnAk/I
	 xvrY+H5sNXBY1HL+weHU3wl54qM7uNqZd1lBKEMFERekuhjVnBAH9BBoOCyM+/RizR
	 rbCBYDITChvXHyvsFlWPcMd0CAsQPTlSM6Hv5XpK6VvZs5ta+rxDGCRFo3JjGRs4Bg
	 1ibmE8rmOUFvM3NiAailv2bEYViLyMIjlEEFt9mxIW5lJOKtmwpwx4LFtDPsyiF5yt
	 JmxwXTK9TTn8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7292E60666;
	Sat,  3 Oct 2026 00:35:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B05262E0
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 00:35:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9664F811ED
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 00:35:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g3i8sZVJN05h for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 00:35:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5376D811CE
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790987732;
 b=M+EUe/HmB69VVKMfdBfFSZS458V7gx3KkLxgSN1LmUmq8lgwQR9LYn/DacRmXcp6T2WH
 Z1bKinFoghqst/W5igN5NyhPvZvV/jFrxqeOm2A9MYSHgLFseEyG2tH8g5/bXglGJ5uTz
 43IV5L0dqhdutjikgKs9d+qPxqHINlU5tk7zxC12clFM+4qZCTdSas0hFGdAEWba+uFK9
 /e1BpyPYwTjoVR9p8YgOEp+5FoobGO2ZbbD8QWzRbzHAdtL0irNsC14g6xdozhs1yubs0
 OXXjVuSbP3busVH1Xvgm1T1ASGusnTnZY1zkIA31Aez8IK5TpEdYRs5bY9xWPtP1cqQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790987732;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=Uf8HNQJey/dLhCBM56zAelAII/H0ESSWyfxM1ERJzWs=;
 b=rvmoUfz4S84P5FoarMj55w9H1Dnvxwp61fg9GBzaqUVSKJwS65vDZYMaqp+BCJzEqTCr
 FRgK7xSyrHRrW8QiYitKqzPn+x3SN/sJ+QnNO3NHTeWSSC3mOGXJd+YZ9FGPlV9fbpFzn
 WbEP3JqQl1w/kQh3UsJWUODvYj9TIxOLBB8pPBHbWU2v0FT6XeseJlh7EWp4DIbywdugE
 2XOqRI8ZPAxZ0muHDfW8fWGxXoQOvYIRDMbn+TmYJMzFF19mBQO4x5ikdp4apn7+1SD0p
 LbGgptchlffrwaHEbZ/5/2224CYxmYpTIsPz7bsUVftw3M1E/RotoAla97v6DSmdYXw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="cgu1B/NX"; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=cgu1B/NX
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5376D811CE
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 00:35:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D3EB360D83;
 Sat,  3 Oct 2026 00:35:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B8B1F000FF;
 Sat,  3 Oct 2026 00:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790987730;
 bh=Uf8HNQJey/dLhCBM56zAelAII/H0ESSWyfxM1ERJzWs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=cgu1B/NXAkD0MpK94xCboVvD8n+T/BqipMivHlg24z8QeSKBvsQzXZdQ87srg94TG
 UpTpafda71cRm6NqBRw4J2RPxoh4v6E+CfD8KpsNWJ9vuuPErvNl47GqY2eS+iBUN8
 MJwshnZesVLq41Jk4i5NKu+LXRIxa+J42I0cInj73MISnHjJ7c0twSAHh44M8uY8bh
 ZWcQYdj7KY+JstxpCx7YcMCGYBfSvde0Y9v6eEbJUhuT2Ulv22BVSN7YCD7cnYhCjN
 ViZx4ouK6xpNRK6rYgk4EIgJfgMPjUc/ifwn191x/5HC69Bf3tjxymoyn9Jzuv6Hj+
 2h7pTj6OywoIA==
From: Yixun Lan <dlan@kernel.org>
Date: Sat, 03 Oct 2026 00:34:42 +0000
Subject: [PATCH v3 4/4] doc: spacemit: k3: Add Pico-ITX board
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-00-basic-spacemit-k3-v3-4-dea68cd1bd7d@kernel.org>
References: <20261003-00-basic-spacemit-k3-v3-0-dea68cd1bd7d@kernel.org>
In-Reply-To: <20261003-00-basic-spacemit-k3-v3-0-dea68cd1bd7d@kernel.org>
To: u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Hiago De Franco <hfranco@baylibre.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7989; i=dlan@kernel.org;
 h=from:subject:message-id; bh=qpU86wBzYBeKKYMF32aCJ5eNii+DoYThm0DoExZq8bo=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqwE3DCaf23rDyROTDkZEgMFbpk5zCX9XUxQkmO
 tdHOaHBOxiJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCasBNwxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+1OrxAAnFf0sJpi+Ra0dz/7CcTsz7gz2bvaBs8MeuAvbQeAw6yt0vXRIiXF/
 dhprRTpZbyqzf6GbTrDenNnRcj6DPWFPOAOHrxcIhsCEeoTh6Ub3/oTuLDEmXDfayZKSgi4YEQD
 zcCsZe80C25gSIKmhMYIE5zBlaiiP94kxjZM1cEiSIpA+qRL0jgVPIFzjwvB3l/CV0U+ZhkoEQD
 LT3s/haNtQDDTpIwbEDZMMlJG3f8/AMi8EYAGbAQ9Ipu+OXGGFW2zZWXZ4EApl8+R/mPsiL+uB7
 fPdLxyoMxGj3kI55h1nIizQxRxAQsXVlDV5o+4mpsHNuykIfzSEHHPNRttkLum6UpZIE6hzO+Zx
 CeiAxdnY4KVbbTWyL2NZdgQ0tcxiRUwgo+T0cGbMwfoBNwDarUtk7Lfc6dTKiZzz58pNhBglo/k
 1vfs0QeR+LtfoxwYXUW/lzri/tiNj3GHi+1hIB5XBfQ2tKCzEatFrYthPxy7VvCscurzUaRAX+W
 R3nMF1I9nQxbuBsEUn3DxNA722PBRjWrwsb82Op6v0hND+P524se+d4T07cP+TJP6nCLEErrccV
 sn+RRTMC98tLTWBn0efvfau9/DJfQS11WuB2Zj7FVkFyr2C1PU3rCr3tIypVpaO2K6t/e5JwVTb
 cABwM1BTw1JCzry6ist7cdrUN4kKOE=
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
index 71854e5735b..51918f0acc7 100644
--- a/doc/board/spacemit/index.rst
+++ b/doc/board/spacemit/index.rst
@@ -8,4 +8,5 @@ SpacemiT
    bananapi-f3
    k1-mmc
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
2.56.0

