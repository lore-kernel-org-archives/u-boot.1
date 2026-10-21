Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BB9606A332
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vrygcdJr;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=BQT1TD6K
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 90F0E408F0;
	Wed, 21 Oct 2026 16:51:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VC3MlzYXe5gi; Wed, 21 Oct 2026 16:51:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 37226408E6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792601466;
	b=d0S3sb4QfPxuZvKQmcKQBRw0ymCCL5EWHDVtAjLFw+nPNhMHjhfTFz6r3/wMuzH3xCSP
	 ct9zVFLFHxF2uFes7zOom1j/3vXFrHQufQm/ZEO96La2AglWrJVgEKrRgAzNejbpsZCs5
	 sN4N9VzL04c+NuVQNzbueZ6XLvELTAzV4+MKPvooD9wJ58iGGMFectSkSs/aiqrs8h88r
	 7ve/lV2ehehGLzB1hZCnpDylRmNmUoLMsLy2h2cbAg9GeoOKSs6+LSvbmvRvK5P08864h
	 IdWk+TF8+GCioqi2VzJuY6RnIY0ScfIsMZ9crvF6Q1VIAMG3sM/vw+Dysrx26rBaEew==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792601466;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bT+eddL5cA5L6Fqw2OCr4wYMQj88utQiOH1GyS/3LsE=;
	b=Au0fb0XT27wiuN+16chMxhCnyPcbZCbMM8Y6gFTXNkgISwNXmT89H7ikNUBBRdIB+igD
	 JyfMXO2a4gmOGUBUBOlQKCBArwuXc0HRasWBfH0dwghbioANctk4Jarjc0vhTHfnpQwRJ
	 yN78PR963wabh84gsNf5PLgOFbzHwgCbZDxmyrge/S8Eyq9t22F0ZU3jFa/HunnaVGS9q
	 brh8lr6Bcg89px5kmyCL4fDDAl4n9Kxcr7rhTeqytvs4qRd40vUMhVwxLryflH+37gfaW
	 2U4dusC1mhr2i6yisZ8MbswTMbXVSJdheL0i3W/X62qsJCrQ23NsTT/u7PdTyhUgsQg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792601466;
	bh=bT+eddL5cA5L6Fqw2OCr4wYMQj88utQiOH1GyS/3LsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vrygcdJrg6uoYJdaGWt5KbInPdH6B0d0QgLtXu7T6HVHg+oMzD72fjBtTh0b+6VgG
	 DqmFWHmJcQAOiJYrDVuKhTbgLh44GpTrblY60kwL784g5K0vwuquj99ieEr1tOFU4A
	 MmuazEr7Mb1Q0j2i05FcVCDo2omtnvsKDHU9CQtk0zQ7VFgwqD+0J+WA6BangQgK0J
	 DfUwmIuQnwtuZa+6ddf1K//VrdSuiQVLKNiY8qm2mO3FdJII/rVUWRu7o6SgACKKG0
	 GG7of4rZvJgMuadua+iLwQy9oNKI7HUjD9AcGZKKuhXM4QAquPf2eg7fEESaUIfaZf
	 OvpS8GZQmQFSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 37226408E6;
	Wed, 21 Oct 2026 16:51:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5E0101AB
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:51:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 447AC811C9
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:51:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kvwu44GzvHZV for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:51:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5001280F92
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792601463;
 b=poIsWTScE3iThcJxds0Shzl6KBxQELoQxhxXK1W5sQBfZWnADwpoQAq7oOFlSxOwcBhU
 wxVhXxLI0Dyz5A8HGsXS9JGI20rKWI10W5zlNwzv8ixoReIoRX3JaBmwNIcCynnHCMhrN
 AyscTHaz+1TpDkrzrvZLWPTwQ55Eyx6c4DLDsdeYoBvsloo7/0EgjrK/5BHvX/7/saOP8
 yoI7MUHHiRtB+d+yP2k0EMmmJ2fpsFpJBRW71AnsIj/Dfde5BDZDqSWxeDcimUS4uoWex
 wETWKHx4nmNQNN3euriz7gWCD6yxEaU97s7ydJxsDGKBaUpHsTJqRHg+xKqpQu5cSsw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792601463;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=bT+eddL5cA5L6Fqw2OCr4wYMQj88utQiOH1GyS/3LsE=;
 b=q+Wy043JfQB3HBV7kA7mFyeREg+M3HrVnis98kdHmyz+z9vDc2Yv6aAV4UofD0s7EW9h
 sjROkOrnHs/g+oL9RQuKzDa2Pv6XHWZvDLL5qpj99+H4b5uofNQVWbrt6aCdKj+dOMMyu
 HEnzgomrOKtq1VIfJ4WR0k6HMX8ISRx5KknqIXTpRqtDi0V5trBXXzAXp6vUTfe6Mx2qI
 0JS2Q4+zp+PZhBGgG5PQcOkmXLxvqLbseN2wHR4wd7InstnAzJbyWBLEkLTwnHUB/GUjq
 vXYQY4NSPGE6D5s7W9ODVHJ0P4lcCQk0jq/9dcUOeYHe+DVHXCEg5/a+7PP6CUjrNpw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=BQT1TD6K; 
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de
 header.a=rsa-sha256 header.s=s2025 header.b=BQT1TD6K
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5001280F92
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1792601444;
 bh=bT+eddL5cA5L6Fqw2OCr4wYMQj88utQiOH1GyS/3LsE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BQT1TD6Kf9cEmLa8uHCw46VmvDgpRm03OsuRrG2AKQJa62KXJDGlbiGHMuBG70bTZ
 1OnNDjGi3N8YUr/JenxICfMQEL7l/Ie6L99KMrSDQozmPDGBUexaA7geSYlNyqhePL
 TCipKK06SMIj5SEOKKIDMLAfjAM1K/iFOtgxVsQtEUqxRhUUUcXMjH4ijW69jq4lb3
 NUhpcqewJOvJQHoUw+c+NxlWN4s707JPyj++bzOk6w1zqvWG7Bx+KZvtdiLGk3kz2x
 AQgIuA200TCUhC+LAfDJsVVgva0J74uMHWcUgVmoEiYq149vLjiDO8qon2vB8FI66b
 ztVbd2BCcCscA==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 16DCEB22188E;
 Wed, 21 Oct 2026 18:50:42 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: u-boot@lists.u-boot-project.org, Yixun Lan <dlan@kernel.org>,
 Tom Rini <trini@konsulko.com>
Cc: E Shattow <e@freeshell.de>
Subject: [PATCH v2 1/2] configs: spacemit: k3: enable spi nor flash in main app
Date: Wed, 21 Oct 2026 09:50:01 -0700
Message-ID: <20261021165016.1395485-2-e@freeshell.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021165016.1395485-1-e@freeshell.de>
References: <20261021165016.1395485-1-e@freeshell.de>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable sf command and env storage in SPI NOR flash. SPL is not yet
upstream so this is only in the main app.

Signed-off-by: E Shattow <e@freeshell.de>
---
 configs/spacemit_k3_defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/configs/spacemit_k3_defconfig b/configs/spacemit_k3_defconfig
index 586305c62322..afe3a3b42939 100644
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
@@ -44,6 +48,8 @@ CONFIG_SPACEMIT_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_SPACEMIT_K1=y
 CONFIG_MISC=y
+CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_PHY_GIGE=y
 CONFIG_DWC_ETH_QOS=y
 CONFIG_DWC_ETH_QOS_SPACEMIT=y
@@ -61,4 +67,6 @@ CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_SYS_NS16550=y
 CONFIG_SYS_NS16550_MEM32=y
+CONFIG_SPI=y
+CONFIG_FSL_QSPI=y
 CONFIG_TIMER_EARLY=y
-- 
2.53.0

