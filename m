Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66638606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 06:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YSUJKVmr;
	dkim=pass (2048-bit key, unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=pjA1fBZ7
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DBA594081C;
	Wed, 21 Oct 2026 06:24:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hNKadMIt4Rda; Wed, 21 Oct 2026 06:24:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D87364080C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792563886;
	b=RSqqS3ggKI9SCANf9kyOfbiKQVOqDCbJpIEui9I880/M0a/1a1lrprXH5Vb77KskMTMq
	 /I7ZT2fJATaP33eki6HF2yaKPdomWPJL0gB+C4hk9uLy3XWKPL3eryIEJDvEUnAEFNwYj
	 KZ7mRQFn2CrWhf0y/yjaeZBznVkwssUNPx7rb2NyQiBTHgVRIBqf3mxGIVkZARJ5E6u0s
	 mel8LEDh7Ha4c7QhznNtSoOaiPKoJjyJq2zrZXN7WNZknF2MiIvoSmHhiX1UkmW/UoZxi
	 Ao57zmXHolf0de8ABGFRtYM9MzIs3yOldoNnugDvad0xJgaYenH/xydlX6LM+BZbdrQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792563886;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Virus-Scanned:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Q0WIEw5nlIWKhWSTl6NwwudT2lzIxlgOztSla+5uyAk=;
	b=AXND4yMkft882Nip6f0ndiLjwBDPPVbe5ZMYUopLd54HkR3jxJ/zeFKM1HCe11md+epv
	 Sf8pZv+4A6Wz24gILIColZEVXz0opfMkcOL3h7n6DDmqIu4Mv5eqQv8b/C01oqiN3ZvLA
	 nO2xEJV5l3ssuWTklH0JgCF+Gn1lUN4cXlgIzBDbfPHA7Zv2oEFPJ0LsNfcCPh1d6NauZ
	 Ai0dd82rFQsCtIH1WffZeFxfWPmycpj/8tpfIfUmfFrqjygNpnxvFdgL6S/8aIZKOE3tI
	 m+2R9hPjJuctpBKPcf3lGPw6nJ0WgyPAXL5QNc5rJjnEq51ZAi6afhdqbYorwk42aiQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=ew.tq-group.com;
	dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=pjA1fBZ7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792563886;
	bh=Q0WIEw5nlIWKhWSTl6NwwudT2lzIxlgOztSla+5uyAk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YSUJKVmr/3DRXS4IIf4hb7B/Qm4RZG976Bt7L4VM9sZa13Koy1ZKCdPIpzuHoHkJl
	 QvoWXHPlcjyo+0xJqcY3KIQupsaiJnHda06+2RB87oY23DUMaHUJHLROLjzbeDy7XK
	 +rPi7ylKvwOt/aS1QyU9S6jB0D+NfFESldHYfWeXMCoHl+b154GRnZFm7fD9POHZ/4
	 dB19OGuMkNDT1UQmLMacv14sT/rgAS2+CZ85JVNkv2AyQM5M/yoW9OvSd9IlwcQgB7
	 uoDSfZcBaSmG85K0yCTJHAAR8PpIRLVq0KZzJi/dOv6VDZQPRYjXL+LC86kq9Och0f
	 KMelKelNchDwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D87364080C;
	Wed, 21 Oct 2026 06:24:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C89F2930
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:24:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AEBDA4080C
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:24:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dv_1E4zvAXzz for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 06:24:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0D7D340790
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792563882;
 b=pRPpUA3swtrrCj9HdYqXrpUsAnfgIp8UHUe/Vd7qGQwjFKf40J04BoWZGMC3eegqoK4p
 Y6ahu2sRM3uCDR/pqI2ZTSv8Gy2AR+PvbD2iGji02/ToyWShK23u4BaMr/3Ys+KLVUwWp
 6RotU8paCIQNfI1w1A33hW8unDVel+CBGdHiI+cworn0TYnaXFu6cUs9bieqWvinwEzOV
 vcG+MN1qTHhrs1VNr+uWUrsTv//p6gzWOBksUV0WQBumQ4Jeyer7/8UtCj11SIi1ZwRkz
 4HhgYZp2TpeVdBnzXD2qzWq7Gx9gdLaN6AECmY4ZDi10B9G76rVCBLEfrm6rECIoB4A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792563882;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-Virus-Scanned;
 bh=Q0WIEw5nlIWKhWSTl6NwwudT2lzIxlgOztSla+5uyAk=;
 b=UYMBM9uhHq0wiUtOhq9cARHa5GgN3NSxYSbdcsyqHbTla0xnQlygt1QSnUQqfIxSHzRk
 HcWt1ezxGrBRzl4ZcJr4Mdw5e17xRfXVw5qdHmx8N4tSiJxdn0idn+tZBfXCDcF2GtPVb
 T7ESXPwbkOofJbiEPyLvP1vIlzGT9EfbPhroP2ZUh5x8OyDqRD/d9kyaXPYhKzsMy3Xdj
 NCBXxTjYvdAOk3hBPoJM0kkeOuWLY7182aYax8FTcHShpDBjUqb8kpl+C46v+0qV+yuWU
 4XAEOAnSBKZ/rF/OcuChQ0fxemo0SDY1ou0rnQrk89Lle66xiEo3Hlqhl5HwfBvNPLg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=ew.tq-group.com;
 dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=pjA1fBZ7; 
 arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=alexander.stein@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=pjA1fBZ7
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0D7D340790
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=Q0WIEw5nlIWKhWSTl6NwwudT2lzIxlgOztSla+5uyAk=; b=pjA1fBZ7gjEJu+sOW6mKqf6HdR
 2xCAhVGUsKcwvU7bH8ZHs4aq6v56u29XXPVGcyVTuF/wEIQ3gelcXxy8nnzShM48YVYZ8DN+YD6kh
 dPBoqHV7aN8rnIj1sOzmoEVgoydIOsyqPZzADH6j/9CLpVKkBhYJ/UMwQrzXrUV3jx4a1Mq7u611Y
 jXNYh2s/QWRlaWcEgotSV9dGjLmnTQkVLy2KnVa/GiaC4k5cSP2BuJaWbqaXH3GcrKEYiTl9pvceF
 6N6PMz0x4SNOeJOhwT50T78Gn1nlYpBW0oLjFfO/EvWLUXO8deceGZ9WYmXgvebFA8APyC5mleVBT
 OIQeRG6Q==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1xJPkc-000CJB-2W; Wed, 21 Oct 2026 08:24:38 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy08.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1xJPkc-00035Y-0R; Wed, 21 Oct 2026 08:24:38 +0200
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 u-boot@lists.u-boot-project.org,
 Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: [PATCH v2 1/1] imx9: clock: Add missing UART clocks
Date: Wed, 21 Oct 2026 08:24:33 +0200
Message-ID: <20261021062434.2098697-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28159/Tue Oct 20 08:24:12 2026)
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

Only clock for LPUART1 has been added to init_uart_clk().
Add the missing clocks as well.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Changes in v2:
* Remove unecessary comment
* change subject to "imx9: clock"

v1: https://lists.u-boot-project.org/pipermail/u-boot/2026-October/636085.html

 arch/arm/mach-imx/imx9/clock.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/clock.c b/arch/arm/mach-imx/imx9/clock.c
index cc0a7729d94..b05194502cd 100644
--- a/arch/arm/mach-imx/imx9/clock.c
+++ b/arch/arm/mach-imx/imx9/clock.c
@@ -592,16 +592,40 @@ u32 get_lpuart_clk(void)
 
 void init_uart_clk(u32 index)
 {
+	u32 gate;
+
 	switch (index) {
 	case LPUART1_CLK_ROOT:
-		/* 24M */
-		ccm_lpcg_on(CCGR_URT1, false);
-		ccm_clk_root_cfg(LPUART1_CLK_ROOT, OSC_24M_CLK, 1);
-		ccm_lpcg_on(CCGR_URT1, true);
+		gate = CCGR_URT1;
 		break;
-	default:
+	case LPUART2_CLK_ROOT:
+		gate = CCGR_URT2;
+		break;
+	case LPUART3_CLK_ROOT:
+		gate = CCGR_URT3;
+		break;
+	case LPUART4_CLK_ROOT:
+		gate = CCGR_URT4;
+		break;
+	case LPUART5_CLK_ROOT:
+		gate = CCGR_URT5;
 		break;
+	case LPUART6_CLK_ROOT:
+		gate = CCGR_URT6;
+		break;
+	case LPUART7_CLK_ROOT:
+		gate = CCGR_URT7;
+		break;
+	case LPUART8_CLK_ROOT:
+		gate = CCGR_URT8;
+		break;
+	default:
+		return;
 	}
+
+	ccm_lpcg_on(gate, false);
+	ccm_clk_root_cfg(index, OSC_24M_CLK, 1);
+	ccm_lpcg_on(gate, true);
 }
 
 void init_clk_usdhc(u32 index)
-- 
2.55.0

