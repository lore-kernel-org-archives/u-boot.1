Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74773606A92B
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 16:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aMNS/Bbv;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=pigmoral.tech header.i=@pigmoral.tech header.a=rsa-sha256 header.s=zmail header.b=rCrGNotG
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D938C81194;
	Thu,  5 Nov 2026 16:42:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4kmH4UIqGXBy; Thu,  5 Nov 2026 16:42:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EFD7081181
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793896975;
	b=FhmddRNrCNBF15NzFtPHg4H5vJU4s8WWadV55Fzt0oYkZZd1SrfRZ3irPEkhPAUDm3U/
	 7PGCFDcK6IL10Dr9XRtdZzv8nRXEme3bLG7mmpdpYFKM8WXYshqBDaBuMRgZspNbnXgSW
	 5vfZ0Oc6SowjIKEDMVaQuDUVnBQYOcMZu+j6eUI3tayOrYXaTrhreDY5OBlFj2fgtUaPB
	 ISyLAPCjosasXwrLh5IcRXw/Q81Km3bYGGOiRVgT/b2XMTjXlTQB9LxhBid2zOXXx8qeX
	 1o3tOwXSw7C+0xPPYYObRQA/8hUuO79dwyuUF7LOq0nFktD9Sm6ORtHSYT61xxYjPog==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793896975;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-ZohoMailClient:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=eBEL69puMcSZkdx3b79hVPV6CAlFcbkd1EUq0LWmvQc=;
	b=poBc+EE9Oh+SBZQb22M8NUWh9KBOUv1GRO8kGDA43yNTD4EF4aruTuLvh1UvyGpNxWmm
	 UemrO4/CpXaoo1wjqgv2YuGKp6DMgIC73/9/AnanEvi4z6rh4X75jd1W124R/FlBmCHvi
	 Ei4cPj9bjYDH9A+dLWA1bXGsl800WYhR6N/L6AvQXRQALnTyQV9/5NKUN11Cyv93Ry34O
	 yLsJevPrgh5zJQN+HR+T9AoRzwVvnOtsDGp/6+0+ObEoAS85Gg5s3mpFosTnhK2tWZT/m
	 nQqe0UQak7HkKDBX6nOBXYg73crxibCKzS+k1L0VKYjucP+Qges4aswmYRUKEw+cUlg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=none header.from=pigmoral.tech;
	dkim=pass header.d=pigmoral.tech header.i=@pigmoral.tech header.a=rsa-sha256 header.s=zmail header.b=rCrGNotG;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793896975;
	bh=eBEL69puMcSZkdx3b79hVPV6CAlFcbkd1EUq0LWmvQc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aMNS/BbvF9+8R51xvpPPApid8BpQGm/PwOrPR2cCR9fJMhr0x8p45no+sFHAxbfho
	 0SWbeStwVjO/Cw3NK3XrN+XIX88Vzn7uTBOz1+LXVaKoxftJ2emL18pJlggOqKwIxD
	 R+5FU4lFSTOZUEYi6lL12EShfchgYQ2kv2s2Pbk+LEBuDZzMYmALexldZicdTcXAmt
	 A2aX9I09swvI5NurZT1G4G9URpKtGCM1OrfrsVDFARkbL5Odc19BfSsMwEqaMlQHIC
	 Vjxsw6DOlPeLDZQ0SY4xA3vekcYJDwOn0mPsTvmSy0F7drkZDiOu7HVPtiw0C6XWE3
	 BXlbkhUThhNQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EFD7081181;
	Thu,  5 Nov 2026 16:42:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C50C552B
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 16:42:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B6B9C80AD0
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 16:42:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RIgpBLt-IYlU for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 16:42:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EDFEA81136
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=rCrGNotG
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EDFEA81136
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 16:42:49 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=rCrGNotGo3k9DmfH2Cmzbqg5gXpZX9vPBQIlzHfVAbIHV1p3bTK35LEc6ELKZPdIo43eUwCkUSU6Y6RTMIDsXhRJvi/4UKS5RsG0N1BERqOwg5f7qhRg6FpH7Rz1t1aZ6WSj9nc/Y+sQj+vTrZwvTxpGOdfPmrbc7IYM8C85deY=;
 c=relaxed/relaxed; s=zmail; d=pigmoral.tech; v=1;
 bh=eBEL69puMcSZkdx3b79hVPV6CAlFcbkd1EUq0LWmvQc=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793896956176889.3651358827376;
 Thu, 5 Nov 2026 08:42:36 -0800 (PST)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Fri, 06 Nov 2026 00:40:42 +0800
Subject: [PATCH 4/5] configs: spacemit: k3: Enable SPL support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-k3-ddr-v1-4-1e60e1d78020@pigmoral.tech>
References: <20261106-k3-ddr-v1-0-1e60e1d78020@pigmoral.tech>
In-Reply-To: <20261106-k3-ddr-v1-0-1e60e1d78020@pigmoral.tech>
To: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>, 
 u-boot-spacemit@groups.io
Cc: Tom Rini <trini@konsulko.com>, Yixun Lan <dlan@kernel.org>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, E Shattow <e@freeshell.de>, 
 Huan Zhou <pericycle.cc@gmail.com>, Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3340;
 i=junhui.liu@pigmoral.tech; h=from:subject:message-id;
 bh=1/uW9tlvcDCpDejwc4mAVwjAvKa1CUa+eOU9OL8ouAI=;
 b=owGbwMvMwCWWvDb1VEXc8j+Mp9WSGLLebDyr9F7ouHRL6d2lV6/rMxX5zLx6KMBJTIbTcQrjJ
 NPTfxYkdZSyMIhxMciKKbJw+Yv/s9bh+XZEoPU+zBxWJpAhDFycAjCR0xsYGb65Nr0WdNq+qthw
 elpV8dv/c+uks35tUU1+JaU/R29F2AJGhq11lUzhBwtqZJvXfGN8cuuu4Z870edeWj5TKP3XoXL
 3IgsA
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=openpgp;
 fpr=15B30CC69C4BF0CC3C08F85A2A90CDC122DF37BF
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable the clock, reset, I2C and EEPROM support needed to read the DDR
part number, along with the K3 RAM driver for LPDDR5 initialization.

Place SPL at 0xc0801000, leaving 4 KiB at the start of SRAM for the boot
image header. Limit SPL to 256 KiB and allow another 64 KiB for the DDR
PMU firmware, placing BSS after this reserved area at 0xc0851000.
Reserve 4 KiB for BSS and set the initial stack top to the end of the
512 KiB SRAM window at 0xc0880000.

  0xc0800000 +-------------------------+
             | smtimage header         |   4 KiB
  0xc0801000 +-------------------------+
             | SPL + DDR PMU firmware  | 320 KiB budget
  0xc0851000 +-------------------------+
             | BSS                     |   4 KiB reserved
  0xc0852000 +-------------------------+
             | Free space              |
             | GD, early heap, stack   |
  0xc0880000 +-------------------------+ <- stack top

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 configs/spacemit_k3_defconfig | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/configs/spacemit_k3_defconfig b/configs/spacemit_k3_defconfig
index f49442951c8..c2975759b51 100644
--- a/configs/spacemit_k3_defconfig
+++ b/configs/spacemit_k3_defconfig
@@ -8,8 +8,17 @@ CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0xa0000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="spacemit/k3-pico-itx"
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x20000
+CONFIG_SPL_STACK=0xc0880000
+CONFIG_SPL_TEXT_BASE=0xc0801000
+CONFIG_SPL_BSS_START_ADDR=0xc0851000
+CONFIG_SPL_BSS_MAX_SIZE=0x1000
 CONFIG_SYS_BOOTM_LEN=0xa000000
 CONFIG_SYS_LOAD_ADDR=0x102000000
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_SIZE_LIMIT=0x40000
+CONFIG_SPL=y
 CONFIG_DEBUG_UART_BASE=0xd4017000
 CONFIG_DEBUG_UART_CLOCK=14700000
 CONFIG_TARGET_SPACEMIT_K3=y
@@ -17,14 +26,20 @@ CONFIG_ARCH_RV64I=y
 CONFIG_CMODEL_MEDANY=y
 CONFIG_RISCV_SMODE=y
 CONFIG_RISCV_ISA_ZICBOM=y
+# CONFIG_SPL_SMP is not set
 CONFIG_STACK_SIZE=0x100000
 CONFIG_FIT=y
 CONFIG_SUPPORT_RAW_INITRD=y
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=276
 # CONFIG_BOARD_INIT is not set
+CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_BINMAN_UBOOT_SYMBOLS is not set
+CONFIG_SPL_I2C=y
+CONFIG_SPL_DM_RESET=y
 CONFIG_HUSH_PARSER=y
 CONFIG_CMD_TLV_EEPROM=y
+CONFIG_SPL_CMD_TLV_EEPROM=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MTD=y
@@ -47,6 +62,8 @@ CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_NET_LWIP=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SYSCON=y
+CONFIG_SPL_CLK=y
+CONFIG_SPL_CLK_CCF=y
 CONFIG_CLK_SPACEMIT=y
 CONFIG_CLK_SPACEMIT_K3=y
 CONFIG_SPACEMIT_GPIO=y
@@ -54,6 +71,7 @@ CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_SPACEMIT_K1=y
 CONFIG_MISC=y
 CONFIG_I2C_EEPROM=y
+CONFIG_SPL_I2C_EEPROM=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_MTD=y
@@ -69,6 +87,9 @@ CONFIG_PMIC_SPACEMIT_P1=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_SPACEMIT_P1=y
+CONFIG_RAM=y
+CONFIG_SPL_RAM=y
+CONFIG_SPL_SPACEMIT_K3_DDR=y
 CONFIG_DEBUG_UART_NS16550=y
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_DEBUG_UART_ANNOUNCE=y
@@ -77,3 +98,4 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SPI=y
 CONFIG_FSL_QSPI=y
 CONFIG_TIMER_EARLY=y
+CONFIG_SPL_LIB_RATIONAL=y

-- 
2.56.0

