Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA30CA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 01:04:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A86BC60D62;
	Fri,  2 Oct 2026 01:04:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NjoM8RxhXT47; Fri,  2 Oct 2026 01:04:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C749760B5C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790903049;
	b=qkIwBwZ/CYBg9BA8HWR4CWQtmW481+cC6xbTISRiuFbw+H83SvZSPZGLwQkySa3lFyKJ
	 2TaLBbQvpmg/JN3VlgmRrrW+Bqm2B3boP5l8Z2j4x38tH66o4AyFGc7WYfJn8GrYa95i+
	 zJuBJb5rO5fJHgFdekmYNdhHZF1yF62tgZIZtK5ghJWUeL4HzGd4D9KsYAVDDuglbL2Hc
	 9Q8ikQRbLXU1Dp10Yfa1OddJZgvkRLs9XKaTtOwf1XxpNDxoA/TjUrG1cUL08nH45hPJQ
	 An2a8YFf9tV0JMD6DlGqmNiKIg73wXxec4pOBHx+I4eVU4GzwGVhe2cxAgF1Zx7XKNw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790903049;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6JTXnNxjK6SFtB/70w69hOrKvhwmAbJ9RfpZHSCxpcM=;
	b=OohgSAIH9bFLB4a7Ft+rEZL2PAC3h9TYxk/dzwC1aIgseonZThIEnjbPXU9q7dvCn1Hz
	 Sx89U440Bpvtxus3MLFrixe6ymi6GlzwiusWzqeCANg2UcEMo7MsVecTt/h4yEw5CE5FP
	 HLoaldtanOw5ZJmBWrspDCuVsZ7WL9xcn1HnzL/AszuVloEcvwJnwxB28F750K+3Dfi7r
	 DW9cH5Oy7xeSVoA+MwjF2GpUBzO4sOGigqnXtbbT0l1/oEzIFrZMlusp6/mh9oFVHVVOQ
	 OFnNTaKLPeD71QxPlSYtvL/70orNuFPOT+5rk+SH1ajXv4eP12nnq1+kDVkvhl2NWZQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790903049;
	bh=6JTXnNxjK6SFtB/70w69hOrKvhwmAbJ9RfpZHSCxpcM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YK0pPyw+cFyOTFTOsotUWS9Y+jFLaEGJOJ1AcE9/bltyV2j2YGjr4hRU5hWhIrBk7
	 93ItwtQyluMtRm4EPlatu4hA7JSNhYnEhw8vbkQPvtr/bOwELWcQjtY4tCX1FOIsx2
	 GO24CPYRRY4MpqHgFZ2R/RN1SCy8qUP4WWWm0wsSlrt6GE5z46hxFQTMQdYrsqpT6V
	 szShstWXEr/mGJ2wfUXnnEE+WOnxqrIobCXZS/ODE8yC9JddFtj3aHtC4/7bbQOmee
	 Rkb0viRP7L91rOPUFIzIOKYnyab802Fe/15kzUmd89aWS0mdoZDbo+cy0zJVp0j5Lt
	 lQBYujmI8AD1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C749760B5C;
	Fri,  2 Oct 2026 01:04:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1DF0732A
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 01:04:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 100EC810A6
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 01:04:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xUO4-ErBZUs9 for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 01:04:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EEA5A809E9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790903046;
 b=lhdVJsKHZLXN6x5Tq58mQU53+UsDO+4CpcxlZqObFbKpbwd5t8terlERQEXWn9BXwTcc
 cV9Ol5EmWt3u2emU7yEUXL57FGTHQC7hjv0BTW8UBpYrPwG5oj4bcyab/JgW4hUYx2d28
 h2O3hlnhSdXP8oLr58W4HbBrPwc4PlTdpK1e0SG33icjtiE1krMwtlYck4rwzE6/84WkS
 fimo/YKSa+uuV5c5ciIH3rRvYL0GPSLzBK3yzKNpu3osiYAs+UHlmq7Easc+Z92NLMdUO
 Mbe3BaI7OIHnbEfnkUFvNq4jj2TJtphIprHfxl+XR8NqA4TxC52olWcysql/GvXYVUg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790903046;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=6JTXnNxjK6SFtB/70w69hOrKvhwmAbJ9RfpZHSCxpcM=;
 b=MVPgc2lovdkcsvOY3cfIvv7TmnBn4km3/EuxcLrkppoQ3S4lMcFvdpNeP42+BXw1vnQ5
 9PGN05P/4izsyxCO2wgVlB43fwgIiqpnwxo9fA/V3YNWdr6YAek8pKFa72Hb4Ir3mVkRG
 43q4TXmXsi+okNQlJ/GF0akA63+8aTGyVjkOMfvzfbtpcwmANVLKCCo3y3iMQfRRVoE6+
 IRj3Rwrzp3bh5EzzC4LyZmOO9sXIq66cTnIoUZbhqjqcfaE7vq/DANrJeKMUgmrolJMkU
 Lg9vW5LXG6EKHJ7kPQ6PPFuFvk5RWeWPMCOTbUfKWvVdtjTVX0D0vpk9otK2UzF0iPw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="l0cSZ/3I"; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=l0cSZ/3I
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EEA5A809E9
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 01:04:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7B95C601FA;
 Fri,  2 Oct 2026 01:04:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641161F000FF;
 Fri,  2 Oct 2026 01:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790903043;
 bh=6JTXnNxjK6SFtB/70w69hOrKvhwmAbJ9RfpZHSCxpcM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=l0cSZ/3IOKBWyG8i4aZXlzPyYUAtC7JAhyOMxGmb2fv/1YurSDK8ga3aqpaX24ich
 lFOpxSWyQiEL5IbIX8eJH948JQKQ55pYA7PVM0Anz3/l5BUj/Z+70jr1gHzbbyK97x
 ATpLU1c/MjcgqOcCEBGczBa6fr7V2APe/RooD1I0ExgHydQkvZnHkPWaN0GH9TK8ys
 BnQm6oDgZNs1OzsICFAYDCSFACMTm59grTKgpx1iMIVzw1YiuctJRmf2SgQ5bKp2+7
 qNdaYGOxSGd4T/KXjlPYC3EXZTMPndwhHx/pyKu1icTINflcmYeRRqSPx5PADQQuW5
 jrOWOeBo3USCQ==
From: Yixun Lan <dlan@kernel.org>
Date: Fri, 02 Oct 2026 01:03:13 +0000
Subject: [PATCH v2 3/4] configs: spacemit: Add K3 default configuration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-00-basic-spacemit-k3-v2-3-fd6779a0317c@kernel.org>
References: <20261002-00-basic-spacemit-k3-v2-0-fd6779a0317c@kernel.org>
In-Reply-To: <20261002-00-basic-spacemit-k3-v2-0-fd6779a0317c@kernel.org>
To: u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Hiago De Franco <hfranco@baylibre.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2087; i=dlan@kernel.org;
 h=from:subject:message-id; bh=slJFcJl5wuI08Ip+ispm/jnk/JXNz0zgQbNoQf+CP7c=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqvwL0L9+8DyRba/D0jciVF30EPJs8oFWdjHaZu
 s1DgPDWokCJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCar8C9BsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+3wVw//Y7BWlf0GsW8xyGgexWFblj8a4+9xDrWDr4Uj+GoWp72K0PoFmbFkc
 qZkSHDvS1dQDzRWaELFXR60jb4csBTloCdNkszSmpU4Dq0VtgISMyPwE1fJqDPQ7X6TxaRkVkMk
 IrCnIaE9Ceo261eSdFNcc0DsuySYWE+Wl/0EyThlmm5PwKRt1CpCETPqjWbSiQ9FoAmBJjThHFL
 DrbXbuGhPHXElcrg5beQTl7AJW++NCWkjKYY1JTvyuFACY/aUNQlRlxhNxRiUX8VJN8Y5N62LmC
 iILH5lt6RLM913gUMveRm7vxhzk/TRojZYD4bONjWMiSicVi0M8VMac3Tl44aGRJCyP/Mxhr7vM
 NEqqGQC6Vdoo7hZTqc5qKKDEnJ4AD3OWC7nqMLDhvjGRCRnnO6AnS9DuMGTx3vs/EBcy3Ih4hx8
 N2JGrrSsBP15XzWrzrhpCuUb/kuV2Cs27vGQ79e8+gO4Sl4wF8AXCe1j1IGViW5IinlGqgcEe/p
 BThOBK4BHzP9U9KSCHhOWFt6kJtj6CQ6uf5PpgnYbSu0FkyYz1ILqjtZ6VBukj1bKfXvsJYB+/W
 BtL3iDT1iRro40zl6XIgWbu8+NcItN6yzsWx582rx80mGg/E8JcqG0Q5U6XQ95tOY+2XbF3Vk6A
 ux5eCpfDG+/05RUrNJB3jyTLokTl3g=
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
2.56.0

