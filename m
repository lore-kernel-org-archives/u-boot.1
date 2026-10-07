Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F26CA6004
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 05:41:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C2E780F10;
	Wed,  7 Oct 2026 05:41:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 23vFc5vp0vR1; Wed,  7 Oct 2026 05:41:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6E35680EFA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791351688;
	b=Cc0oIKJVGsWuS/0FY5iZA6puskaQvmdvYgtcZXqA6GNUvJNMdf37caQyGqn9XD381Xao
	 7qEb8PFqzYl2VtElHUcZEY7HP1W978aCbtvFgjN3xTQ8jk/cXmF1b3FIy963oGrHCAkIX
	 au80wUc4A5zhVBX70Iu7Xuj5RcFVER1udLRTLh4dnET4EFZxhXL2GHCwKDk1P9rDaxDSR
	 xMQjSpxDD/oaANptJT6AsqobK54tUprfmIUOH+gboNRnw4iHz74R7lXxR7DXnFltjHBrl
	 gvr8opwcfhluYMOCmTtU99OLQmDFgflm8xAL4A430fFGhZ4/4c/GdU80374sSIY7q3g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791351688;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Aal2OQReXtyOjCupyom5RMKbMhsAXAmRRbMEhEqIvew=;
	b=qTIf1LkAenLSMBHPz3NoVFMEEsdanFYhs62PVX4n9U+qVu0b6Vv/VMbRb8Z2LxdsjcLs
	 yUpYCJbMz1nK7FEVmK5WUaza3NvojkDHqc2BOJZrxg5L2zyUy7LC5impYtdihsF20sSIN
	 SqhN+LXrroFCEURr5pGOPq5OAFMwT+36eCKhHY2+nzrAPJPRo86YKVCOQblo6NZNY9ghg
	 jDtHLUGojsszeXNdw1ZUN1Bj7YpLDYlmA0FvaAe1+7QolrLjERx/K/yasIwfvTdK7YWEg
	 Z9VLqylUGrxzcVL7BG4pqlTumJteL3Wqeau88sh4UMGt48Ag6Rz3ocdk5EFdQH0AJbg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791351688;
	bh=Aal2OQReXtyOjCupyom5RMKbMhsAXAmRRbMEhEqIvew=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rtn8rLc5uHa9rgCajtGjQyiaE6aVA+IT4pPm3l0L0bAdbSsIM4hw0FwizxmCQ4Iqa
	 YsEq7CgOoWi9DG2Foc9yncmWczpHDXQNhD1t6yqxEt/4xNG7Tg7zjDavEku5FOe8pK
	 DkzIMHymegrt8a8kR4/hRdKJSjH8jNwPzD0YacJJ4mRBUd5iDQ3DmkxP4/wew0yIdj
	 dT76VbRQBOL2GLXFqmNzPBojpmMma9X/U372ZdTGiw59v4q9ryQrNzfbvg6BBqfg3b
	 1ZizEkXahHfRKIVsnYNnsgiUXHYtKa8gLyryLD9oMZd8gYPaBnf9bdQry8ltiIBMY1
	 PZ95yfHz+gNhw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E35680EFA;
	Wed,  7 Oct 2026 05:41:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E01D1317
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 05:12:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C67C44070E
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 05:12:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ofx5jsjyPTyx for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 05:12:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 33F504070C
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791349927;
 b=mTlFvzAvyDGhQWkW/YNP+f2gAFZHF6S6wC+QKovG3q3oHkwQ7iwJdOf4tCvOOWViaWL2
 F88vi0nKvlQbrG7XxQEfVjOn5BybpbEUAa91LhaYJkZ+MfUUXKLyNauXhm546xPrumVa/
 nEKXnQVRY1RSIGNNrGn3uZPytr9aIA46JCrTz6PZ4VmwfqYAt2qCZMPHDDW8xr29JtFCC
 U+xQ7v0eGrD4d14V6MYEMyINYsH1qx32ZYPF7/SatY3HIM/x3DkNud1FP8KQe32mSiN+M
 79DJGwCrhp6VggFctGcI026V6fQA1UyqEr2c3mdaFS2HOElSkwrqdZm+C6fLgtp5Btg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791349927;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=Aal2OQReXtyOjCupyom5RMKbMhsAXAmRRbMEhEqIvew=;
 b=j67X3zcMVzs/VWILOkmL7BKdk54BFW8BwdBxEOzYHc6F2ha5WIXRiPsHORAl7SrY8955
 Y+4HEnDCWCguaLUqABUVEN4tLaNSjuvhYUlhtIJt3XouIaonGNQg7RoHQJwhXfvenjH7q
 fLx+MuGAtsGvti7GIYTnYUkeREyVetJ7k+1sjGUVVe4jevluJJ2xSs6Dq9NZHlN+AJ6TK
 8yTo1K30Wa0muLpMLY9xOgSRTtUvhcM+6/6S6F8bpNKPLX/XOqdWxCWP1IeN2hk35jiBo
 KCumerlPiy8aodwwFZHMyw8cEL7VFkUHvsV4CgcaOTWG6dSlVfzlGcMHY6TK7HdCksA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=CjYrRVU9; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=CjYrRVU9
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 33F504070C
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 05:12:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7CE8543EBC;
 Wed,  7 Oct 2026 05:12:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEDA31F0089B;
 Wed,  7 Oct 2026 05:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791349926;
 bh=Aal2OQReXtyOjCupyom5RMKbMhsAXAmRRbMEhEqIvew=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=CjYrRVU9gA7mRwRA0v7mg2aZjOZEVLsJJn/Qu5LTKkEbQfEs8ljDdCHoXmE0RzjXS
 7IvdUODIP7R9dO2kfpCiUQGdYQOKaLd98b69kh3LLOBduEBFwHSfGOjIZFnvwyrVWP
 M2FOzU3PLIvS1JvxKKlEzlZe7I27rfyZpgp3ML2nUO04yHypYGP7+ngBiaJilhU4Kw
 vzxiz2WfIuKOzlAJJCuku3ZEbNmUpkzv6ekrB100ZS+TRRAGINIFAcCOaglCboMtIs
 J2xuJqlpILvqla5ZsjsExDvDmUM8DO2HdAJwaKx+MPdp7f0UmUn9PXeBJGbtDrPpkm
 8RcblQUvbluYQ==
From: Yixun Lan <dlan@kernel.org>
Date: Wed, 07 Oct 2026 05:11:33 +0000
Subject: [PATCH v4 3/4] configs: spacemit: Add K3 default configuration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-00-basic-spacemit-k3-v4-3-c44d09937088@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2184; i=dlan@kernel.org;
 h=from:subject:message-id; bh=mexySMVoX+dZiLIkX+izNCll2mPWrF1euYYxlxGXTvk=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqxdSVZhD3s4X9CkKPUn6Ur1SQfA+WIWruuApUg
 nLCKJIQgySJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCasXUlRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+0mPw/9Gy3hVcZGXZqLBXkUof0JzEmT2Lj2SVmQLXf8MTJFWkQ4vQEH9y0rr
 oi8VZMbmFVujbURZobngGV4sh6qccuVwR+nhMt7H53qLP4VDwK4BLUxxqBsb1XUd6jX8aZKYKXy
 hbPfBnvpTOFrLS90dQy+uO/JL8r/ieu/xcgA7AXwZBfh4n1qProFzUeLfFpeq331k7+a3H4quvj
 yD0g7LjEeK4MlaoD4xo+Xww2rLnOytJTLKFOYOBh+QQug791y+Wt3RwcIUKxMxtAcluDrl3Be3+
 Ay+ny5o8uyZybIXZNfiugYzvlv/MI3hdoX1ztUQEoZQ3wEV9GFb4qZ4UVBGVgG3hkt6pxk1683v
 jTdc4r97iERzyk2WpnM3VLI4j43b5sz2A9mEQofX3p8eKwmxK2RFQH5mn8CiU+Wj1qApwcCZeYq
 ts4SWNbK8+m5MvbbNrD6VPITlTyjTzvGJBZmnTpBoFkiiasBNFGZv9qINXsKHBeWUgVqyxdVyO1
 49bEdXgrGL7KFCgKw78qSjoGPagF8N3H/vEYLjABJbwoXcOa01HZWLXdW7h+mNahYn+uNIY5OSC
 VzdlXV3+YvQcibbrBB635JHzHujlK0AF5RYWstjWC25Eu3WfVI4aYqtj9Y/rlC1NcTTFZF9uMgo
 YuNzdcec8BRYaYqSz4kf3fUQrsrRfo=
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

Reviewed-by: E Shattow <e@freeshell.de>
Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 configs/spacemit_k3_defconfig | 51 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/configs/spacemit_k3_defconfig b/configs/spacemit_k3_defconfig
new file mode 100644
index 00000000000..a6d1f35a93e
--- /dev/null
+++ b/configs/spacemit_k3_defconfig
@@ -0,0 +1,51 @@
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
+CONFIG_DEVICE_TREE_INCLUDES="spacemit-k3-u-boot.dtsi"
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

