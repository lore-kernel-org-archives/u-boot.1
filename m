Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0CA606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 00:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xKpjX8KB;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=bnYGQHJc
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DBCCB4084B;
	Thu, 29 Oct 2026 00:17:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2SaIwaUmfn6K; Thu, 29 Oct 2026 00:17:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 43DE440852
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793233036;
	b=HeYKtX6UmccUmHt8TuE/fHBwazdArgO+zH6BG+kChXPV85BFA7Sql4o9KVKKgFyPur9I
	 jh1OC7WdhQx1iuKyJmDuospGAXCa0XXU2htJGPJh9A5mGI5oR6qzMg0Y4kha9Mm2ReMsq
	 3gue+B74SF4RoJlvg98atLnZL8e2hYG2DP7AvJf/sZBrF6fCHjKXzVEZiUrucfdsNPQZ6
	 MxA71oYKd67fbYhma0nZxm8S2R/dmIvtXqkeSqAgkslbhhvS9Xg0xOr+hPRb+YPzQ+q6C
	 ngeqOJnBS9HPlFSppRjefuJV6p/l7ApemLCQRAPr6HRa4l0AxtDL6XpOmn+LJWfirBw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793233036;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+p+EexNByLcLcCW3scRxtEewav13rSPTIng2CQ4eFHc=;
	b=c5+Ko34mTF0x2l/Smnchhv6Gcby/8sjo8NqCT72MR15gjXSP/kPPshkGe1VWOaMaXux2
	 iGrJqeaH5M7GTydo+NV2piqWZ3UtnNrTfau81DsS8ze7wxkc/IG8ZJkAqGyBHIhdZ9qGm
	 vqSni7RQskSGvgtkGRQQJH/f4b76KwObqZwSCfU33Y7tW4T2bWLKSuQmDWXfNbIG6cR4P
	 pA1O66z/kL7uiku6Px+i7gswROWpZady1e89a04whC8Ae9MltXN9cD/UT/3YdJZOld/Dt
	 o8YlPWID2g9pgNeaZmGeuhL7vxmNLL3gcRVlQlIZG/AGIF+dtlyIyqWgaqv5IblFviQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793233036;
	bh=+p+EexNByLcLcCW3scRxtEewav13rSPTIng2CQ4eFHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xKpjX8KBvdicgvVrAG3yD1erxnyKY0SHSBynDGMOyj/UqWDj+gMT20+HEOlHQYX7p
	 qAxLXVtH/QEKwOrH3a4ztV2KBfMwNWygUqIl2vi5g12QZtCumVr8aoDtUZQakM0Yr0
	 J/n1xoOBn1z0s3fu0JFZeOgvUcnyvHWfL8wgkAGi9tIj+PqSmbhNxTsbJoTfrn23Lf
	 ZrjLuKyZOCJPJx0tMGOVMqkWEcG3l3LdMa1nBZj1C7CaDdTdPEusXgqNqQBRLp5JZl
	 UaHY7uLf/GhRj9Fx0+idT/U5iM+ZXCC3f7vnQ+cr33zZY455jfNlkVg7q8TCr8WtsE
	 kWH613Go8DztQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 43DE440852;
	Thu, 29 Oct 2026 00:17:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CFC76356
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 00:17:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C1AB180F91
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 00:17:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KrRNjd2-9iWS for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 00:17:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1438680F97
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793233032;
 b=IPNQ5bqKZDeQRh0XVcY+4CDy1O3tXQ6EysEJ2Z5f3283NMwVWqKQdlWZtT2Nndz4K9d5
 +qsGOct19x3a58NVLNobUA1X4hmuXqXcreCC/MEKWi/tT2aUaes6YvVVUwT2J5CkcFx31
 4bthT7P6Z7QYt3CC9DmlcGRtt5T9VUX/PR9ormajJJxwCq8Q1bfIrZaDop3xPWBFNM4PB
 fLbjyVehw+BzLk25v57sEOBnZAzgh4boot1Vvv7B8yoqaVQoM0AKiv59GOjr8cmiAmIrQ
 MJNf9HVIMriHMqbC4r5r7C/4oxYd7DKSZj9OJZczRlhffBS7o8v7Sf29OldPzU50/tQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793233032;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=+p+EexNByLcLcCW3scRxtEewav13rSPTIng2CQ4eFHc=;
 b=OmkycSxxJeI4K8xiKtXaXenG5EaUkQqOH1jfoR5sA14x/vw05bJJj52wlXVEN7iUeABS
 VnIpzBQVZgOMjvoC9lpUPYAaEVkWZy6wwJINZWlWUN9Fl5e3dEjmKcZRXYHvkaBSJ73w4
 bBWK90C2l17X8jUX6LY5gBdNXlO3sg9uPWHjqUjZMNtCT9nE+WQhpcuObtwL1d4+4yUqu
 tE9Xxp/raJ9ly22O6l7qnus2rZZMa3WiH2z0xPNfLj4P5fbyI2pGgnuN/YCYostWVOgMp
 O5dTK0CQ0TEgfcq+D0RpJFLfZw1eAdNouTE6vOtyKgUj1wrBwoLiB4xIN8TAomYofaw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=bnYGQHJc; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de
 header.a=rsa-sha256 header.s=s2025 header.b=bnYGQHJc
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1438680F97
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 00:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1793233013;
 bh=+p+EexNByLcLcCW3scRxtEewav13rSPTIng2CQ4eFHc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bnYGQHJcr0706BuC4AI9OBoz7TSEIz0iwJVQRrGG+1eRsukC1q5zXPmtde6C7LaDr
 ptmBVokddYnDLQm4kfEc/rilbuDa8coR8+QTStjcO580CGNbnOA+GwmFp3WZ5gYA3L
 lVmbav6u3M13RvbvXjZ1vVZn77qjgQXLHav5pmtu8YTnps4VVltCkibfqxSNeeDH85
 g+r2JPMdIqH6aXEnvyr1+c7HBWGLCEHfwWtFIMe3reHtSTNwwiIwpPfKYzllm2X6FU
 SpIKeUjg1SQ8ispWwGyVvfpu3npuDDKW3dhg1I15iUYQeSujES0RBWDwknq8gVPuhB
 2UpryhLFgvnUA==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 2C60CB2208BF;
 Thu, 29 Oct 2026 01:16:53 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: u-boot@lists.u-boot-project.org
Cc: E Shattow <e@freeshell.de>
Subject: [DNM PATCH v1 6/7] reduced SpacemiT K3 vendor BSP: add UART (no SPI)
 defconfig
Date: Wed, 28 Oct 2026 17:15:54 -0700
Message-ID: <20261029001555.1890775-7-e@freeshell.de>
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

Drop QSPI SPI MTD CLK and RESET as a new defconfig
---
 configs/spacemit_k3_uart_nospi_defconfig | 44 ++++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 configs/spacemit_k3_uart_nospi_defconfig

diff --git a/configs/spacemit_k3_uart_nospi_defconfig b/configs/spacemit_k3_uart_nospi_defconfig
new file mode 100644
index 000000000000..9a8c5cb18406
--- /dev/null
+++ b/configs/spacemit_k3_uart_nospi_defconfig
@@ -0,0 +1,44 @@
+CONFIG_RISCV=y
+CONFIG_SYS_TEXT_BASE=0x102000000
+CONFIG_SYS_MALLOC_LEN=0x1000000
+CONFIG_SYS_MALLOC_F_LEN=0x80000
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_ENV_SIZE=0x4000
+CONFIG_DEFAULT_DEVICE_TREE="k3_spl"
+CONFIG_SPL_TEXT_BASE=0xc0801000
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x8000
+CONFIG_SPL_SIZE_LIMIT=0x72F00
+CONFIG_SPL=y
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
+CONFIG_SPL_CRC32=y
+CONFIG_SPL_I2C=y
+CONFIG_SPL_YMODEM_SUPPORT=y
+CONFIG_CMD_TLV_EEPROM=y
+CONFIG_DM_I2C=y
+# CONFIG_SPL_DM_I2C is not set
+CONFIG_SPL_SYS_I2C_LEGACY=y
+CONFIG_SPL_SYS_I2C_SPACEMIT=y
+CONFIG_MISC=y
+CONFIG_I2C_EEPROM=y
+CONFIG_SYS_NS16550=y
+CONFIG_SYS_NS16550_IER=0x40
+CONFIG_TIMER_EARLY=y
+CONFIG_SPL_LZO=y
-- 
2.53.0

