Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 197ADCA5FF1
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 05:41:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D1DB780F6C;
	Wed,  7 Oct 2026 05:41:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tDuT3DceiTVp; Wed,  7 Oct 2026 05:41:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4C86380F71
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791351690;
	b=o6cUt9g4+FNl7cg11ybn+MiuTPdzAJVCm7HXdCjx2ToTuYl3/Onj70uyMkhJFq2WcRXQ
	 VOtBgzNy3T1pQkkmpSsW+aj9ELezKQbt2WoUi6xDaXju40D1zHxKeYg5O0G033BrBU6BE
	 gVOHMQsam75tK0+LK6CZ4R+p5+Hv6UTJ6DqFBdXPzRMVbjoSPbgQKOd/7+rNr41RROB+v
	 T+RGeEvUotDNbDrlda0xJ1euIAUwwF3R4m87N1ct8Y0dF8riu/Tvobay8KnayHsv5aPkv
	 v0Dsqp9vY8mlbhM8irzCwMCCsh08Zj4GvV1MGXbojxMLspZxenapnUaCX9Jq20oXagw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791351690;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=T27HtTo+jL2V1kEdETtemdenSrt7aMrHt77JnSO8+iA=;
	b=D9ogS81ZBVMI/tP9Zansxqw+iUVRBXL58aQb779yCCL3L7fS66NMCk4BCHgkH83d0ckY
	 fMXmm1zuAbI0zuQiRedIwWTCY0zLv6MlvA46pOS7Ow3WdLxs4Wfwv6q48DXq+G/k4tW+B
	 l+qjACkNDJfgYEMMIJ4gTc5zzZXth5iU6gBUpLFhR5AE2i2F5F7hyZ3hBNqVHjRet8MmU
	 u+sIS7uu7LrSEPhO9Zq4AoKa8rMUgjP2OC0ceL/VZR9ZQnO9Pz+IH9GzLHBpMjaYyQtjS
	 0Vyv3EXQazcnV0wPQXyERZI2yzU+Ue2p1WqqxcdGLb3CitsJOhVwhqAxhrfU2NtAytw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791351690;
	bh=T27HtTo+jL2V1kEdETtemdenSrt7aMrHt77JnSO8+iA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T5xXEQZJtXSHAHpS35lCZ468zL/suw7HOWOcmuerVAZ3yLoWrQsb67sNGRX9cC84G
	 wcAwmkLqwj4LPUq/vvznQ6QmlFqzxPC3hUA+qI+DDr4ISSLImc4n8bVIS6J3ufdUo6
	 NjEqTXgecZEizN1BMucLjpqoSIycvUQqCMQTna1eNeaKs3nSi8RwL5jn9o844Z9MO1
	 pHdQKBb63xTmxVrrsuGJM4saLshlsLsW3ScUY65obZGH1nJ3zxqFtYlF8B8eZvhhlO
	 7c43K/oR+akAm78q7r/w8UgsW5FPtB5l6qpuq6YeWK0Y5+dxYDigISUhIE4mwNBt1A
	 Gtq9G8njZ++rg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4C86380F71;
	Wed,  7 Oct 2026 05:41:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0395A317
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 05:12:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DE049400D0
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 05:12:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gRucFMAudl3F for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 05:12:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 75A1F40070
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791349929;
 b=eBn7HVBpArjKWPIVFN4pVSpEj5rtxPnuTUP9IXLghZ29JQjrB2pHzueOiR1p7C/43qdZ
 WkRUWPpS2ahV/P3UkKFGaAisYEMhUKInsFA8rHa/4lw5CDmhsTfd3pbM61x7vtfdasbaP
 KDWULCY1vDXoezcin7rqgEXumj25FDHdzko7t3wZ6q7vgk2kf0GERJuSEI0FnRosPJZWO
 JH9oRswQHFIBx7YZDEa8oHF/lWkrn6OuPUdxphBBp+tHZLus92tNaafh1I0gQUccgf9Wt
 SSqdDMQgRseQTFYVCDwEfmhS8LgUW+x0eekkQYQ6HXu4JXeqYJNl1KMpBiD6a+zbhzw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791349929;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=T27HtTo+jL2V1kEdETtemdenSrt7aMrHt77JnSO8+iA=;
 b=m3GpHak0uvMznENMldhyFU7xXZvWtVGpBdXZSuPeC+AelaMt93d2AK0uPKVWteVwWDvL
 E6xYK+2Ev+Y62CmUoyRjztz/drGO8Hzm2ctSxBPzdafAPDXNcNhLLQqvKS9D1qRlm3rG+
 XulAM1QnRyNSHrf/9LCNUW/ArjGIGW7IyCE8n3WQvFFao65sjz2g7dLKMWTRqhOPCOyAc
 7gTtYldQhd0o4llGwi1Y21aJ2H04iL49eSbfaZSNtuKil3rdr7wqhZsYY1ZyvV7mk3LKo
 /vEWp6PSQPKTcLB3lB/WymoNN2Bp45URNqrHF7xW4nCVjUsyUXG0rljVmjnoMwIF1uQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=MPfJKAud; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=MPfJKAud
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 75A1F40070
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 05:12:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0083840171;
 Wed,  7 Oct 2026 05:12:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA15D1F0089B;
 Wed,  7 Oct 2026 05:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791349928;
 bh=T27HtTo+jL2V1kEdETtemdenSrt7aMrHt77JnSO8+iA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=MPfJKAud+RQ+aNRrG+I+THz48Tz40Dvuz2E069NOaWYnxrrjm0YOnD3XsMPb8phEz
 B7ID5SNm5KoR0Lt10Ouy3GpLZLO64gLbLijoVsq2laVyj71ra6S/X6VhI2bzDYY/sA
 CirUpSKpH8xWQqncdPYTLTQ1H7VF7QGUzVaMikCYFf1CwZQDeg94n2GbHNIo5sEAdw
 EoHnCCPyY0p8l9lyO9ka+h7OWMwlFxyi14xrSBrgQJ9t5Ldcy44PFPmLfp3UioNT/w
 b1fj6az7Ja7j0YSgSEV7S9aWYzO9sjax7XOzhOQSqz4w8aTnPOi10c7hUj10d/GvDO
 P+NlyEhVGJTiw==
From: Yixun Lan <dlan@kernel.org>
Date: Wed, 07 Oct 2026 05:11:34 +0000
Subject: [PATCH v4 4/4] doc: spacemit: k3: Add Pico-ITX board
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-00-basic-spacemit-k3-v4-4-c44d09937088@kernel.org>
References: <20261007-00-basic-spacemit-k3-v4-0-c44d09937088@kernel.org>
In-Reply-To: <20261007-00-basic-spacemit-k3-v4-0-c44d09937088@kernel.org>
To: u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Hiago De Franco <hfranco@baylibre.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, E Shattow <e@freeshell.de>, 
 Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8452; i=dlan@kernel.org;
 h=from:subject:message-id; bh=kXS+w4bDJn8iw9jTTernp89kGVXtHlaN4nCYBfQxCSE=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqxdSYUODjmdODaAWViFS27CrbXRufevql+QD2+
 DXDSC3okz+JAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCasXUmBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+37hA//anOD8l9us5ld7CK9W9VACHXEaXwnt6XOT2+p0TXigTGMrWkaKfZEe
 I54AVAf2N8BdvZ6zM2qAHhN/LJPZoSEgn5lx49atsA861CqLtRQ8kDmzFNEhBOq3MypmeyCpWx6
 Czr1idA+lKYRCKqcCq+Zz1iPre9yNnOGSdv71hB4O5FSWlzbm6ywJpQJgKZTA/h/6g6z61SpSsY
 9FymG9GYAvQJU1zuMMHDNbK9LPprAhgaMSEytMla3wvKPkP7O6uhSTUXV3UB9DzeSN0Tul36vKq
 KWYtIHZhs3T2EyHORrjlsk06oXK6mn25H2HBeHrlztPSFPzH++mVeXC9obgZCWVz9/Flt2Unu8I
 yPh2cAYTY2x1bz08C7oAKj23NVY1oXpPiqcxL8Icx0kpC0nklPLsMMtm3vJNB/wYzG29UFojKC8
 cxa4OgdeTCN2xuBoN9LP1qD6HBZ2LvRUmdQfk8opGC3CKrM0AL+GdL6C1wqLMCqpcuGKSC3C6HE
 nIJP/O4HxGRQeP9JFKenqyOcR6wwnY0BgcSKQfeGB8OHWDJTKlLuN6At43pMJxIHMRxs3zBLvJy
 6rQGXDhOS+esTSmCuesvLBRkYHZEXvdPyHkIh879cIc3XOJ8qHkb/byuwHwUE8kSGyXJNvz6Ilr
 H2ZFTjhH+Lk2+1qJHp+0F/tCKmi1tE=
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
 doc/board/spacemit/spacemit-pico-itx.rst | 200 +++++++++++++++++++++++++++++++
 2 files changed, 201 insertions(+)

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
index 00000000000..18d11d6671b
--- /dev/null
+++ b/doc/board/spacemit/spacemit-pico-itx.rst
@@ -0,0 +1,200 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+SpacemiT K3 Pico-ITX
+====================
+
+Building
+~~~~~~~~
+1. Add a RISC-V toolchain to your PATH
+
+2. Setup cross compilation environment variable:
+
+   .. code-block:: console
+
+      export CROSS_COMPILE=<riscv64 toolchain prefix>
+
+3. U-Boot for SpacemiT K3 SoC requires OpenSBI in-development generic
+platform object fw_dynamic.bin to be included in the Flattened Image
+Tree blob. OpenSBI may be first built as below:
+
+   .. code-block:: console
+
+      # Clone OpenSBI fork sources with K3 specific patches
+      git clone https://github.com/spacemit-com/opensbi-upstream opensbi
+      cd opensbi
+      make PLATFORM=generic
+
+4. Then build U-Boot as following:
+
+   .. code-block:: console
+
+      cd <U-Boot-dir>
+      make spacemit_k3_defconfig
+      make OPENSBI=<OpenSBI-dir>/build/platform/generic/firmware/fw_dynamic.bin
+
+This will generate u-boot.itb
+
+Testing
+~~~~~~~
+Currently there is no U-Boot SPL build target. It is required to use 'FSBL.bin' vendor
+board support package SPL for DDR initialization and testing u-boot.itb. Please test with
+fastboot command via USB download.
+
+First, retrieve Bianbu Linux image from archive_ and extract the FSBL.bin firmware.
+
+Second, hold the FEL button of Pico-ITX board, then press reset button and release it .
+The board will enter into firmware download mode.
+
+   .. code-block:: none
+
+      sys: 0x10001200
+      bm:2
+      usb_init : enter 3296,3072
+      usb_core_init : enter
+      DWC3_GRXTHRCFG:0x4400000
+      ROM: usb download handler
+       rst
+      done H
+      setup= 0x1000680 0x400000,
+       rst
+      done H
+      setup= 0x290500 0x0,
+      setup= 0x1000680 0x120000,
+      setup= 0x2000680 0x90000,
+      setup= 0x2000680 0x200000,
+      setup= 0x3000680 0xff0000,
+      setup= 0x3020680 0xff0409,
+      setup= 0x3010680 0xff0409,
+      setup= 0x10900 0x0,
+      usb_rx_bytes : start len[4096]
+      setup= 0x3020680 0xff0409,
+      setup= 0x3040680 0xff0409,
+
+Run following command to test:
+
+   .. code-block:: console
+
+      fastboot stage FSBL.bin
+      fastboot continue
+      sleep 10
+      fastboot stage u-boot.itb
+      fastboot continue
+
+.. _archive: https://archive.spacemit.com/image/k3/version/bianbu/v4.0.7/
+.. _uboot: https://bianbu-linux.spacemit.com/en/device/boot#21-firmware-layout
+
+Booting
+~~~~~~~
+Sample boot log
+~~~~~~~~~~~~~~~
+   .. code-block:: none
+
+      sys: 0x10001200
+      bm:2
+      usb_init : enter 3296,3072
+      usb_core_init : enter
+      DWC3_GRXTHRCFG:0x4400000
+      ROM: usb download handler
+       rst
+      done H
+      setup= 0x1000680 0x400000,
+       rst
+      done H
+      setup= 0x2f0500 0x0,
+      setup= 0x1000680 0x120000,
+      setup= 0x2000680 0x90000,
+      setup= 0x2000680 0x200000,
+      setup= 0x3000680 0xff0000,
+      setup= 0x3020680 0xff0409,
+      setup= 0x3010680 0xff0409,
+      setup= 0x10900 0x0,
+      usb_rx_bytes : start len[4096]
+      setup= 0x3020680 0xff0409,
+      setup= 0x3040680 0xff0409,
+      fastboot_handle_command: max-download-size
+      usb_tx_bytes : start len[14]
+      usb_rx_bytes : start len[4096]
+      fastboot_handle_command: 00072b20
+      Starting download of 469792 bytes
+      usb_tx_bytes : start len[12]
+      usb_rx_bytes : start len[469792]
+      usb_tx_bytes : start len[4]
+      usb_rx_bytes : start len[4096]
+      fastboot_handle_command: continue
+      usb_tx_bytes : start len[4]
+      j...
+      U-Boot SPL 2022.10 (Sep 07 2026 - 11:31:13 +0000)
+      LPDDR5 total size: 16 GB, data rate: 6400 MT/s
+      DDR training consume 5625ms
+      ..
+      OpenSBI v1.9-72-g13a401f8
+         ____                    _____ ____ _____
+        / __ \                  / ____|  _ \_   _|
+       | |  | |_ __   ___ _ __ | (___ | |_) || |
+       | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
+       | |__| | |_) |  __/ | | |____) | |_) || |_
+        \____/| .__/ \___|_| |_|_____/|____/_____|
+              | |
+              |_|
+      Platform Name               : SpacemiT K3 Pico-ITX
+      Platform Features           : medeleg
+      Platform HART Count         : 8
+      Platform HART Protection    : pmp
+      Platform IPI Device         : aclint-mswi
+      Platform Timer Device       : aclint-mtimer @ 24000000Hz
+      Platform Console Device     : uart8250
+      Platform HSM Device         : spacemit-k3-hsm
+      Platform PMU Device         : ---
+      Platform Reboot Device      : spacemit-p1-reset
+      Platform Shutdown Device    : spacemit-p1-reset
+      Platform Suspend Device     : ---
+      Platform CPPC Device        : ---
+      Firmware Base               : 0x100000000
+      Firmware Size               : 416 KB
+      Firmware RW Offset          : 0x40000
+      Firmware RW Size            : 160 KB
+      Firmware Heap Offset        : 0x57000
+      Firmware Heap Size          : 68 KB (total), 1 KB (reserved), 14 KB (used), 52 KB (free)
+      Firmware Scratch Size       : 4096 B (total), 1472 B (used), 2624 B (free)
+      Runtime SBI Version         : 3.0
+      Standard SBI Extensions     : time,rfnc,ipi,base,hsm,srst,pmu,dbcn,fwft,legacy,dbtr,sse
+      Experimental SBI Extensions : none
+      Domain0 Name                : root
+      Domain0 Init Order          : 0xffffffff
+      Domain0 Boot HART           : 0
+      Domain0 HARTs               : 0x0*,0x1*,0x2*,0x3*,0x4*,0x5*,0x6*,0x7*
+      Domain0 Region00            : 0x0000000100000000-0x000000010003ffff M: (F,R,X) S/U: ()
+      Domain0 Region01            : 0x0000000100040000-0x000000010007ffff M: (F,R,W) S/U: ()
+      Domain0 Region02            : 0x00000000d4017000-0x00000000d4017fff M: (I,R,W) S/U: (R,W)
+      Domain0 Region03            : 0x00000000e081c000-0x00000000e081ffff M: (I,R,W) S/U: ()
+      Domain0 Region04            : 0x0000000000000000-0xffffffffffffffff M: () S/U: (R,W,X)
+      Domain0 Next Address        : 0x0000000102000000
+      Domain0 Next Arg1           : 0x0000000102091398
+      Domain0 Next Mode           : S-mode
+      Domain0 SysReset            : yes
+      Domain0 SysSuspend          : yes
+      Boot HART ID                : 0
+      Boot HART Domain            : root
+      Boot HART Priv Version      : v1.12
+      Boot HART Base ISA          : rv64imafdcbvhx
+      Boot HART ISA Extensions    : smaia,smstateen,sscofpmf,sstc,zicntr,zihpm,smcntrpmf,zicboz,zicbom,svpbmt,sdtrig,svade,ssstateen,v,f,d
+      Boot HART PMP Count         : 16
+      Boot HART PMP Granularity   : 12 bits
+      Boot HART PMP Address Bits  : 38
+      Boot HART MHPM Info         : 16 (0x0007fff8)
+      Boot HART Debug Triggers    : 4 triggers
+      Boot HART MIDELEG           : 0x0000000000003666
+      Boot HART MEDELEG           : 0x0000000000f0b509
+
+      <debug_uart>
+
+      U-Boot 2026.10-rc4-00501-g9fba7b59df42 (Sep 22 2026 - 13:08:33 +0000)
+
+      DRAM:  16 GiB
+      Core:  433 devices, 15 uclasses, devicetree: separate
+      Loading Environment from nowhere...Loading Environment from nowhere... OK
+      In:    serial@d4017000
+      Out:   serial@d4017000
+      Err:   serial@d4017000
+      Net:   No ethernet found.
+      =>

-- 
2.56.0

