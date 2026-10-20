Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D031606A31C
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 19:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pGkxApvg;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=SqOT8Myf
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CCAA2607C2;
	Tue, 20 Oct 2026 19:52:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1qmTnfQB4f_u; Tue, 20 Oct 2026 19:52:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 708D960754
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792525946;
	b=U6pYK8cDuU8vCvyMFeZSzr+n0tlwIa9WRSyi5/i23GLAfSMh/gqvrTYZ7Hu4HBRxBIGY
	 hY0hy/ZiFHjDQUYedat/2l7CT79AatPA0vhmoFPopXNwB07I/ry2IHHYuAYYGDCPSHAC/
	 jaxBLOzrjjhSEWpmI91CQ0WwkN4JKjtsVmYiMC9f43+waeA5Oj6XU+e4RMGQAHQBAmj/a
	 Kt+/G+4OwiBW5OGXf5U0/CRinHx4Buv8t4EYbT7NyD8X1AelvJuUNJUMzidc5CHpb0bga
	 6qItG2JRUOlem15nlljxYghzme0QiW/EpawQShyfjGN4ldSyob/999FBmuTFJXnL3Gw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792525946;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UJgPwff8b4k+Ok5K4QA39VgJ9m08NUCu3gvZma5J/Y4=;
	b=Jl8Cuj+dlcGMgzOHZNwGXnXoU/zirgVs8aPm5TLYMqtOQnpyzmCiYOFMbKaeGU65YTfi
	 pchxHdg+Q44NO1+JZUfijJ8s61kGmHF5oVui97852UxeLOOJYrQfvXPdzuimjavD9JwSn
	 6cHvB6LFUhVrRADdtS3N9XwSoyMTkxp76lUyI4mZqN0AIE6z6HtWJa30bJ4ulTi2RDCk2
	 Fil9jY/TxHRQZWCulmkCOFE7utILPD+2GEdicjhiJDwhkjOuABF7M3WsHRWfaXE9U+4WP
	 ah73b7wpwB+mCROTLGazBrgAUPY3HLuDdV450uazoACY9uLIuMXg04+eiHcT+UzfVBw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792525946;
	bh=UJgPwff8b4k+Ok5K4QA39VgJ9m08NUCu3gvZma5J/Y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pGkxApvgWrlVcr+rkM+kkP9o33gf6ChZdGQETX7SbBDbLw1I5u2Fr/OnyKFL258j8
	 aA9do4SJPGJszJKhe3NglFazogiytoEj+LS5XEXxK01WCHzZPpHvpw5Ih0FgK6H8cQ
	 f2i9Jaa7ANl+CYwwpSzWlYLYFU3BvTTll8U9e3TT3+XfteTO3CNtUDqcJ/4FWz2GEY
	 G5XQhJlezb4GAVa0Asj1EIY9WXiVmeLrr0vTaacxioFEpG/irVo8gZf8Vz+74Uh61f
	 ot5O+DJR3/qtoesOEcr975t9CMmuVxjt9YkNMfFYnP0kzEqjpmA0X+mmTVWjnQxQ9m
	 DuT2sc98X9wQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 708D960754;
	Tue, 20 Oct 2026 19:52:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 46F4D1E9
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 19:52:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2CE59810D7
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 19:52:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HsfT1Xhdid_N for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 19:52:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2A1D7810C5
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792525944;
 b=oQid6VlZcDXY4fwdHEU2ckp20mrXJB73lvy/25KC6hrJKmvG9xzGSJ0OFm443HyAr5HN
 Mz6CcsBmlc8wgsfzCy4rf4brG1VlVDZhppSjpZgtjyleywI1SzwXC8lKHZKoxjflCX11j
 6iPUAH+p3lRfKOqfQnIevOIfWtxa5PUaVzbarZbhBeD7+GEmUuoNk4msNC/LiNet4Embr
 f97738E3zVrHTDcFQO3Ib8BOOjan68/Tl3hDrZUh2ErvzUA8j/Jv74jFfbZbKUkT/FMW3
 9SYRm/HRXxHhVtIFKR9ED4FzLQKoD5Iul7XWOsP36soMXUiQ2ZGD/ataUBGK1c74WfQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792525944;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=UJgPwff8b4k+Ok5K4QA39VgJ9m08NUCu3gvZma5J/Y4=;
 b=UA4Achgbhk/AT+FrLJmAowZ5DmFUUdRmDEYei6b79zitoEjhhEBH8G36Y9YEKQ8iExBb
 PY+7MbrZYbTus2XlW5g2rOgHAX7tTQPE0Fdbyr/KBhkeSaSZV6zsFVJ/iiAS6ysIL6JN7
 S7hVlJ2EwfePGzhEHp9bxds8zRNYYTbNgwGZfyY4y3HmgoCLByEy9KOr6QxukbvHj6uGx
 GqrpHKCZAkg+OrfxRD94/CLRWeWfpLdEti1dEDU3NddzbXSeI8jKbhcKwlJL7P3etowl5
 m2410ASI1EqTAVveRlHqoCXB1YIxycuzf8CL3mIvXwvLqem7PjSCaGYcqVsUyDNW70A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=SqOT8Myf; 
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de
 header.a=rsa-sha256 header.s=s2025 header.b=SqOT8Myf
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2A1D7810C5
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 19:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1792525918;
 bh=UJgPwff8b4k+Ok5K4QA39VgJ9m08NUCu3gvZma5J/Y4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SqOT8MyfruJOElRUeB3tkYa44cxQTxjPIU+WFm1s/xccnGZRtbh7qcYhsU3MZBY+I
 0UZDIPuh2XskbGN0XpgjrVWoghOsI69MERCzVr71KJ9EgwDwk3XjfWeCOog30Tz5Xu
 iKXDtnGq2aK6jaJlVtXYQsg7AAEYYN/Kdc3e+nb4b3cVbog2JQLShQNqg6xIInF2Gz
 z27yWNfsrxxIfUPwGG0oXA/4sZ11siZK0LJcbLVWO9QB+xw/sFob0SC5ool6a+0q9R
 l+zCoNWeaYHdU6ZZwCyDuez8Nc9zGMTsd9s4f7UF9FuAxpYujzEUiCM0BcgOQGWSlb
 BMbsE8VPmV1fQ==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id F0E34B220724;
 Tue, 20 Oct 2026 21:51:56 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: u-boot@lists.u-boot-project.org, Yixun Lan <dlan@kernel.org>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>
Cc: E Shattow <e@freeshell.de>
Subject: [PATCH 1/2] configs: spacemit: k3: enable spi nor flash in main app
Date: Tue, 20 Oct 2026 12:51:10 -0700
Message-ID: <20261020195126.1325187-2-e@freeshell.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020195126.1325187-1-e@freeshell.de>
References: <20261020195126.1325187-1-e@freeshell.de>
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

Enable sf command and env storage in SPI NOR flash. SPL is not yet
upstream so this is only in the main app, and depends on vendor SPL for
clocks setup ahead of SPI NOR flash probe.

Signed-off-by: E Shattow <e@freeshell.de>
---
 arch/riscv/cpu/k3/Kconfig     | 1 +
 configs/spacemit_k3_defconfig | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/arch/riscv/cpu/k3/Kconfig b/arch/riscv/cpu/k3/Kconfig
index 5474ac112437..07b490a718dd 100644
--- a/arch/riscv/cpu/k3/Kconfig
+++ b/arch/riscv/cpu/k3/Kconfig
@@ -14,5 +14,6 @@ config SPACEMIT_K3
 	imply RISCV_TIMER if RISCV_SMODE
 	imply CMD_CPU
 	imply OF_UPSTREAM
+	imply SPI
 
 endif
diff --git a/configs/spacemit_k3_defconfig b/configs/spacemit_k3_defconfig
index 586305c62322..b333e708d01b 100644
--- a/configs/spacemit_k3_defconfig
+++ b/configs/spacemit_k3_defconfig
@@ -4,6 +4,8 @@ CONFIG_SYS_MALLOC_F_LEN=0x80000
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x102300000
+CONFIG_ENV_SIZE=0x10000
+CONFIG_ENV_OFFSET=0xa0000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="spacemit/k3-pico-itx"
 CONFIG_SYS_BOOTM_LEN=0xa000000
@@ -35,6 +37,8 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_DEVICE_TREE_INCLUDES="spacemit-k3-u-boot.dtsi"
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_NET_LWIP=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SYSCON=y
@@ -44,6 +48,7 @@ CONFIG_SPACEMIT_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_SPACEMIT_K1=y
 CONFIG_MISC=y
+CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_PHY_GIGE=y
 CONFIG_DWC_ETH_QOS=y
 CONFIG_DWC_ETH_QOS_SPACEMIT=y
@@ -61,4 +66,5 @@ CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_SYS_NS16550=y
 CONFIG_SYS_NS16550_MEM32=y
+CONFIG_FSL_QSPI=y
 CONFIG_TIMER_EARLY=y
-- 
2.53.0

