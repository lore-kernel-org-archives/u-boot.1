Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65938C982FA
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 12:47:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 27B216084B;
	Wed, 23 Sep 2026 12:47:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sv_oIB-EckUz; Wed, 23 Sep 2026 12:47:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 622DD60846
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790167651;
	b=c5y9Tv4NxT89zje9Y9dH26SY6n+BZq5SQg8DD4TD2iTUZ18/5kP15Ng21fcSCD5rnK7X
	 RCAYhIJt5mfOD1sXFHQ9H81I+8dQq08GPw+yeFE3tnGQ1Wqau1XAOQIuMfruL/VOu99Y3
	 NNoHS1ARSL0z8MCvAXvYL3zAcvAy8xYQYsphR8N7jkcZrj0ZXYYx9U5rYwY428FvpXNOh
	 08tw9U4s7JnblXOIPnz3IFMV609c6y7zUDPRv905YivS4SK6AAoAilsaNMoi/Biz1eHz+
	 kas0HMkqpYjDhlLTTe8ooiymRf90MNBysPBRG3ydTu9CJXClwUxfaXwfgKIi/CaWqig==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790167651;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IHERyzMCT7WnDZHFCriG50VEJoowP+z2CMX5iTUlAmI=;
	b=FB0ag5JUNiklRZbxdI10aHnncWox+hL+eOta3qZzVpZtlJJXnicAc57Odb8W0LrUF7gw
	 CKq/sGedkjS2Bf1cTx8lAc+eYTVAlLa39KWTJ3c8aMjrPMKOA6hL7cqTy9fmOkqptHWTX
	 vM+1epHSgxzVl2nXl3ldi4B3qumtlE9MGeMSYOpMoaubGnb/i7QTOTuMLOBtRfnizPrXY
	 QpA7zaBR7nqQj3qowu5E0Sf1wKdrou3daaVFj8bO/oRgf6YNt6neSWYJqJ2p+2LVElequ
	 nubzUwf9kLRUQqYojsZjo3DZeeM/YG68K9NxEkc9yolYKoRQBs+2vILVRinDoRRR8nw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K2gP565W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790167651;
	bh=IHERyzMCT7WnDZHFCriG50VEJoowP+z2CMX5iTUlAmI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XGNiJXC/9FxWuzpTHdksWOpJA5sLDLEXXaF/Vs6SnekqnvAhdEPd7xUdkS7Ry1gH7
	 pow4U+T4eA7eZlzijayZnedxlSq06GgF/xBL5JLSLkck6DnbkPOmy0Wo8eXEFFAR+2
	 hKpxJO3VK71Ct5oHXzzwF2+ZfEFwUKO47BnrE6LcYLR+lmYw8DAaydjHj5Rh3KSFcQ
	 GlDzlOZv6VxEvI6tRVyC7zpgTlcStCk7vHebdCtvW7jePCgNBUHgEnGAdctHX4FbIY
	 vRIM0uzYX7JsL7svkpEftiaBDWsiSGdN2mXrBDxB5ELvpQDCd037p7FTaOpOZ2Kp5M
	 jpD5f/fozzrGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 622DD60846;
	Wed, 23 Sep 2026 12:47:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BF45128C
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 12:47:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B1113607F5
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 12:47:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y8pvxzERI6Tu for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 12:47:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0644E605E5
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790167649;
 b=AaLr3bc79J+0m+8o08l4XTY55XLdH0IdaZaIw/xneXugwd8pAjj5yeYPzVjBg7hCxzlI
 xyvhNqnsCja0D3XIE7ICwJYfmHvB+x9Pw5hhejuXjTVEBHzlbKVTJ8hc62HeJhC4u5/Mo
 VqoH1MMD/7nlW0i9Q/HFVTDbrkWmQaGFgCfhz2Q7RS6ePKf/hzOr6z2KMO3iKIlNAKXcq
 qk0rfpbOKK5WJ19wE+QSi95oetvjCYhpGSkQSPbkYbitNSj0E7iOiVYGKnhB+gQ+DQEgg
 jEizcScx0A9BEfKBRcvULc0a9JDi4KU3mvA5/r7wI/FeYrWnGApN0uFkjsHv51JstsQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790167649;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=IHERyzMCT7WnDZHFCriG50VEJoowP+z2CMX5iTUlAmI=;
 b=gADsHUTjLQarlMVEhbZ+gnkznG7dwKl1RD7sxt64W9osBiCfwt8+pSaUZn8VjusSmeoL
 i3XNmIWLzxipasbSkRqVYJV59ITOybZ7cttzAVs4CkAVWRHYNmOv50dfNNTS/N5yguOOw
 HD71FiyRwNt571WhnFy1rWsHsWyerIPt/jg4ZnC4A6NI9DgNsKCmkDHMt4eJkvV2qLAPA
 AD21ZZZ4ei/ft22BkOVW+VTQ5gQ2TOQkGWLWNorP6cbJK3wd7e8i9o/WmuAEx/J6DaUHR
 EO0La+57xkoRHWUSoKfJ7jToDKeCVP1ExyCXVhD5T/YZqowcD30jcj5HiVzuhSnAALA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=K2gP565W; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=K2gP565W
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0644E605E5
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 12:47:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B496C600AA;
 Wed, 23 Sep 2026 12:47:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 525771F000FF;
 Wed, 23 Sep 2026 12:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790167647;
 bh=IHERyzMCT7WnDZHFCriG50VEJoowP+z2CMX5iTUlAmI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=K2gP565Wd6X/NNaFKL5f76sFXtfx31gCLGr2IM1+EsKrzSlDFCjkDRDRr0jTos8Qb
 b4c2jjFQHYXvbUzndfL3Ulms5sN8BRC3UH81i/QUQULUYfEM+3onCK3YWAzPP2AVcC
 gowIm6neINBlVVoJT8Dh1nRXKhLa8BkMP1dwf5y/I40CcXtPWvcXN8qMjoJ/Pl5rJw
 Ss1GD+7hXwr/4F5v/12LodGkoZPGibEaDZoPJxcNXypeMpUWWnQE7dkSlCuQb4rmKc
 tQYCOM2R+DnzYohPy82CT0S0Kpmv21YOb4fuvxOFMOs4wxVD5ZgMm4N5wqHMTmVzzm
 G7JWVD75PYs5w==
From: Yixun Lan <dlan@kernel.org>
Date: Wed, 23 Sep 2026 12:46:47 +0000
Subject: [PATCH 3/4] configs: spacemit: Add K3 default configuration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-00-basic-spacemit-k3-v1-3-fa1015f2cd1b@kernel.org>
References: <20260923-00-basic-spacemit-k3-v1-0-fa1015f2cd1b@kernel.org>
In-Reply-To: <20260923-00-basic-spacemit-k3-v1-0-fa1015f2cd1b@kernel.org>
To: u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Hiago De Franco <hfranco@baylibre.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2087; i=dlan@kernel.org;
 h=from:subject:message-id; bh=F9EylfrVqx3xoQsxHRf0ZEaI/w972Y1aAX+Zk/9AImo=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqs8pJmrP6gMgcxJAVrCSvTqoexXZoYeVUQYY+T
 UluMy8PHzeJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCarPKSRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+0YCQ/7BFp5E3TQBUDLAA6ex66IGK379x4NJqkbq95hhk59fNSJOnyn/BykF
 xn3b11Q2ZU8Cvb8MHrvdvakNE2HgJn2W4CyNN4kgMDlvvQsK1VSlTvicKdJawrnRVsIk3HoxgDz
 sjCp//Q5SDngM/MLfTSeqbWG2N1A6lKGy7yixn8+BTvTAjKI9NUirYcKR1Ra+B1SvJhb3P1JZZ0
 QtuNTflwTU8XyBLXgN/aD7o3pT0GsAfiZKBg88ZnYXF2VxcmRrbhlVYJy5uekO1tixuN4Giga3R
 oA4RE834RtKXJw5NwS29jYYb78f2T1MY7SST/yOoABsx6SJ+0aEjQgwokqATa2RErXmuCOaSDwO
 VdZHX8n1a5Id91ROSoLn9CSAcqQn0ujiHo09VHbSKX2WkhxwiEs8XFjDYvJt3XCpFvdFG7qvkkG
 QHNNCYsb4zC+VneQ2z0WP1NKS2T2QpyWqOeTpLeIb9AnxzeuuZlJEkwr2jnW5EJhDSw0I9xuSbl
 3N1bVOIt6Vm3MFehl3ytfvHzAbtnlHlqCYd8mJ3lq2/UllSAC5HTaUga3jl9GyQGfYKwj8K+Emu
 ouB5Tsj2k5w5g8KCILKeXTT9/fP+Ef6hpIDFvTPM2GexbTmyy8UXsg8CJDjpWoUb3J3WVdIEd3q
 MM6l87teVJrWrfJesICOTDKzDhKhEo=
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

Add the default configuration for SpacemiT K3 boards, using the
Pico-ITX device tree as the default.

Configure U-Boot to run in RISC-V supervisor mode and enable the
platform clock, reset, GPIO, pinctrl, I2C, PMIC and regulator drivers.
Also configure the memory layout, debug UART and basic filesystem
commands required to boot on the platform.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 configs/spacemit_k3_defconfig | 50 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/configs/spacemit_k3_defconfig b/configs/spacemit_k3_defconfig
new file mode 100644
index 00000000000..6ca41aecc41
--- /dev/null
+++ b/configs/spacemit_k3_defconfig
@@ -0,0 +1,50 @@
+CONFIG_RISCV=y
+CONFIG_SYS_MALLOC_LEN=0x1000000
+CONFIG_SYS_MALLOC_F_LEN=0x80000
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x102300000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="spacemit/k3-pico-itx"
+CONFIG_SYS_BOOTM_LEN=0xa000000
+CONFIG_SYS_LOAD_ADDR=0x102000000
+CONFIG_DEBUG_UART_BASE=0xd4017000
+CONFIG_DEBUG_UART_CLOCK=14700000
+CONFIG_TARGET_SPACEMIT_K3=y
+CONFIG_ARCH_RV64I=y
+CONFIG_CMODEL_MEDANY=y
+CONFIG_RISCV_SMODE=y
+CONFIG_RISCV_ISA_ZICBOM=y
+CONFIG_STACK_SIZE=0x100000
+CONFIG_FIT=y
+CONFIG_SUPPORT_RAW_INITRD=y
+CONFIG_SYS_CBSIZE=256
+CONFIG_SYS_PBSIZE=276
+# CONFIG_BOARD_INIT is not set
+CONFIG_HUSH_PARSER=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_PMIC=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_SYSCON=y
+CONFIG_CLK_SPACEMIT=y
+CONFIG_CLK_SPACEMIT_K3=y
+CONFIG_SPACEMIT_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_SPACEMIT_K1=y
+CONFIG_MISC=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_SPACEMIT_K1=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_SPACEMIT_P1=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_SPACEMIT_P1=y
+CONFIG_DEBUG_UART_NS16550=y
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_SYS_NS16550=y
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_TIMER_EARLY=y

-- 
2.55.0

