Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51270606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 00:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CuTQ9fVC;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=hW4nFPjZ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 226CD606F6;
	Thu, 29 Oct 2026 00:17:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V8KYrwqnWOQW; Thu, 29 Oct 2026 00:17:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6ABAC606FA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793233031;
	b=HITgqje0Fx67quBrOJ6SfJ63Tv9+qsfmMYVCMUAhl5915JZPyun5/pVrHjB0o4EVhF4U
	 HzbkikrCfgtWKiDE7R3nchfm068R5f2fnUIbOLOF417ZTnD29s7nDjxE5l1BFVJpMvlcf
	 dF7O0H0yRq0x79tnOhxPAzE+w9kyVubbiizTQfujaXnYVFR8/ZFIkQQ/ehbi5lxlyq2e5
	 6q1E91g0iry3X8FFvvXZEAGvXN5x64WVw2eRUlAc6L6sLB0LzHj7hUG08GPNiLLfSytRv
	 cDh+vXlSrjukpGj8XWZkExesGi2rmgv9jPko1SxeQ0LyFCS4+bICd7Z0F2PBNh34+1g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793233031;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RoU+vS0BWMOru7OXBX0QbZhxRtrcvF74T2uZ31yahb8=;
	b=Z4a3GwQcJ4wFY7qSH1WQeSBgrVVg8CmGGA537K5bt43lLX35Vxr+KMHJ0Yuv/9AMfi1O
	 9YuBrvxGqY6/yi7idxfN2DfvaUcFncvORfVlsFZq2GdLp1KRpvLj2AbeZNWDPbV2+zB6A
	 WXpWr4QAdouJ/Bs+pPGblGcdJDDBA+lik8OQb15k7LU0vClguKsKNeF3GZlc5e5T9WGsy
	 zTTOBzttP9M4UJhbaATTY1RmSjSBti/xEPCN0uXNc/F4vCZ3MMOfTaoQxkrj+LiPiO49b
	 +BEFRMtXn+XS++7RHpJ1zo8urEtXqcJcvTV8IIHB76cPKP6etBkGhdqsrhrJUdxDo7g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793233031;
	bh=RoU+vS0BWMOru7OXBX0QbZhxRtrcvF74T2uZ31yahb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CuTQ9fVCtF8qyTMZm48EGY5CmVTSjEwe6TEjSokM2Maid/IxejhscfRuqwJj78J+k
	 oQwHATCpIF8NtytuptyX+Oe8tNc4MjDtKJyH2VNhquh/bwEvX42IRalKGYusXth86+
	 HASEAZcVZW7CFm5gAFkB/77UtYmVSFVuDbzKFGa3G2BHmsE9wYxeGoXyRBvYILS02H
	 uv6BZEq0nNNnjVZ/ATUNRmA/I+/bE8zXn8c/kkWQupcvpz7uMw5pQdrdKoRnYApVQy
	 VnyuUooMKliawx4pZf3NnFLdOFASJXUB/QQhiu7XSCGafEYWSE7lwIHJUfEf8oYJ4l
	 5wwG9Jc9Ch7/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6ABAC606FA;
	Thu, 29 Oct 2026 00:17:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id EE640356
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 00:17:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D462A80F97
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 00:17:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aBoMpme2M6Pn for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 00:17:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DEF6180F91
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793233029;
 b=KdaetUZC1YwfpS5IWUlS2mXOh9CkzWbsBokAdv96ikCA1EKp4n7ZjrAaGuWlvbPNoRuX
 ZXqsUbA3kD7Ht2gbsW5S7pGG2lym/uoqHYf33IQUf2XIljuuvIdlPVJebt5ok/zrnKMd+
 4GBArTRwXBLEIxFYyzVH24J+7gdOeJaQEniYVeRLy2zrh3zEM+im4uP35T6omwoDd1H2g
 z5d27NAFOozUlGPcyVPOPloqz05j1NBjhHbvq+10+YCDLIJq/YzvYCPutKqE8kcX/SfDX
 SLhmMroQVS5HwOJWtgO80bQTY0EzELzTQC/FrnQCzWfoIip7pP73z+6Iye6si0Es88w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793233029;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=RoU+vS0BWMOru7OXBX0QbZhxRtrcvF74T2uZ31yahb8=;
 b=c0wiW94MUn9bfGfidDLs+K3cjtMUKWR6+MrH0OfWCNAHnaZ6YNc/CwuBVLw/0yhwxrZI
 ExWnseotDMCcCyAHg/7EgIME8kaoTRlUqV6SN66xItF80znNpFYYz1om3KfP6aDQbH+JX
 PteNOS1D3ja5GlGjx0+WAXNH3adGlkdq+vUFjH5vGSYZ5/yuwTAXink+2NEVMc0W3CxYB
 xzr3ObmGyHwO2Mw8qS7gKwkbUFipbI0exZsZdICVRbGWQ5CwWErdvQxBcFXeiPOHR3XKx
 0j35K/mpVFbl1zJHBQ1Q3UufaPFPyw55ijXme9Xla6sJl8mczX0wkbaGfQi10nc2Z7w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=hW4nFPjZ; 
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de
 header.a=rsa-sha256 header.s=s2025 header.b=hW4nFPjZ
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DEF6180F91
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 00:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1793233012;
 bh=RoU+vS0BWMOru7OXBX0QbZhxRtrcvF74T2uZ31yahb8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hW4nFPjZ39k+tYr5EZHOYeSCP80oLEpJ0X8GLxAevbG2m+dvv3cQGZt+kJ356AmD/
 LwO/v1a3/kG9I+vP0kPd0w/LUqWfmhME0mMAMZrRvcSl1JUKp1IKxmIANCguiWSELv
 D6Q329mC0ghRBEguQrP3gdqOS50muK1+ui7hg+65XtNvSoeW4kCdYBoD6hrJzzEiuw
 EaWHZrzjsikkfhOFo5TMZPUyLNBbBuZ+lu19kqyAMM1jDPYhnwUjaDGBYnQjDuG1JN
 CnoTq7wSdCqv6Pge7sJFouKV2T8PiHWlBYY6YbHYZt7pKCMIYKfS5C4uAJjNBoGUHa
 elGYzC4U5T7Sg==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id F2D27B2208B2;
 Thu, 29 Oct 2026 01:16:51 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: u-boot@lists.u-boot-project.org
Cc: E Shattow <e@freeshell.de>
Subject: [DNM PATCH v1 5/7] reduced SpacemiT K3 vendor BSP: add UART SPI
 defconfig
Date: Wed, 28 Oct 2026 17:15:53 -0700
Message-ID: <20261029001555.1890775-6-e@freeshell.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029001555.1890775-1-e@freeshell.de>
References: <20261029001555.1890775-1-e@freeshell.de>
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,UPPERCASE_50_75,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Do Not Merge

Informational purpose only, to aid mainline development of SpacemiT K3
support.

Minimize config to only YMODEM load and SPI as new defconfig
---
 configs/spacemit_k3_uart_spi_defconfig | 61 ++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 configs/spacemit_k3_uart_spi_defconfig

diff --git a/configs/spacemit_k3_uart_spi_defconfig b/configs/spacemit_k3_uart_spi_defconfig
new file mode 100644
index 000000000000..734df7eba4ca
--- /dev/null
+++ b/configs/spacemit_k3_uart_spi_defconfig
@@ -0,0 +1,61 @@
+CONFIG_RISCV=y
+CONFIG_SYS_TEXT_BASE=0x102000000
+CONFIG_SYS_MALLOC_LEN=0x1000000
+CONFIG_SYS_MALLOC_F_LEN=0x80000
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0xA0000
+CONFIG_SPL_DM_SPI=y
+CONFIG_DEFAULT_DEVICE_TREE="k3_spl"
+CONFIG_SPL_TEXT_BASE=0xc0801000
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x8000
+CONFIG_SPL_SIZE_LIMIT=0x72F00
+CONFIG_SPL=y
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI=y
+CONFIG_SYS_LOAD_ADDR=0x102000000
+CONFIG_TARGET_SPACEMIT_K3=y
+CONFIG_SPL_OPENSBI_LOAD_ADDR=0x100000000
+CONFIG_K3_BOARD_ASIC=y
+CONFIG_ARCH_RV64I=y
+CONFIG_RISCV_SMODE=y
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x102300000
+CONFIG_STACK_SIZE=0x100000
+CONFIG_FIT=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x140000000
+CONFIG_LOGLEVEL=6
+CONFIG_SPL_MAX_SIZE=0x70F00
+CONFIG_SPL_PAD_TO=0x0
+CONFIG_SPL_BSS_START_ADDR=0xc0874000
+CONFIG_SPL_BSS_MAX_SIZE=0x3000
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_STACK=0xc0880000
+CONFIG_SPL_ENV_SUPPORT=y
+CONFIG_SPL_I2C=y
+CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_SPL_DM_SPI_FLASH=y
+CONFIG_SPL_DM_RESET=y
+CONFIG_SPL_SPI_FLASH_MTD=y
+CONFIG_SPL_YMODEM_SUPPORT=y
+CONFIG_CMD_TLV_EEPROM=y
+CONFIG_ENV_IS_IN_MTD=y
+# CONFIG_SPL_ENV_IS_NOWHERE is not set
+CONFIG_SPL_CLK=y
+CONFIG_SPL_CLK_CCF=y
+CONFIG_SPACEMIT_K3_CCU=y
+CONFIG_DM_I2C=y
+# CONFIG_SPL_DM_I2C is not set
+CONFIG_SPL_SYS_I2C_LEGACY=y
+CONFIG_SPL_SYS_I2C_SPACEMIT=y
+CONFIG_MISC=y
+CONFIG_I2C_EEPROM=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_RESET_SPACEMIT_K3=y
+CONFIG_SYS_NS16550=y
+CONFIG_SYS_NS16550_IER=0x40
+CONFIG_SPI=y
+CONFIG_K1X_QSPI=y
+CONFIG_TIMER_EARLY=y
+CONFIG_SPL_LZO=y
-- 
2.53.0

