Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B155606A323
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 11:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=d5dXdje4;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=UVsb/q+s
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 647C4407C7;
	Tue, 17 Nov 2026 11:37:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8cmTXlej9H7A; Tue, 17 Nov 2026 11:37:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A17D5407A4
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794915460;
	b=C4Vz7FYrBqwILqBENKh/0M7iC9EeMZLZQSBG8HY2tN+5Vx5/zeLNro7DU2baMfxtVYS8
	 dkvr68WueQxoxLO2Pc1RRnx7dSkKJjpMa7ANbSvi+u2dSBGF8bnk38BfFt/A4dB886A2f
	 A+k58OexVhbKq+NP1ABB2y4vWazR2T7/Foh4XxNF8E6XE0sZdcqI0Y28Qyr/QXGvs2tVu
	 temB61YuFre4gQ7gIeXtKXb6T/gxlTVcJhITVg2LRe3AOxInTKEIEcul5sWBQ47K0sSJN
	 2fYPkSdIsy9a3PNNhK0xzjvPfLCjyyL8iUIlKDB9+7l76/tiUrXNQNm4FRhrOsFcqEw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794915460;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Infomaniak-Routing:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=eehK20zDjJD5pdq5vBF9991/jdDyuEuVdpDl+nVKMnw=;
	b=NDrskmbCxJQqLafFEEv477mD0Y3GK07sHkVV4+KahhR/I1KpjZM4ecmCzWV/hSqWU0iB
	 O8F8r6agNa9O7lpoRxEm8sLF+4O2U1DewHWADWf8xsJX1UtAHxLY3+ZyKFIQ7+EKazg+I
	 lpm+C/vgkHFunrJaiZXWn/n3R5mUb9abQXyJiv5GXooEtghaGxwt9gFjqzB/6FQ6nvsi4
	 v+aNa1b1twiTVdhN5nLdMF7EX7Jc79UxZuW2fXjsdtgok9pYoXe2IHwK6ZZTTgl+UQQPQ
	 3ZQ3ot0K0UwNUgs+EuW2sTOxSmjKOqBhvQSI2sxLV5PyNa/vQJb//iZKZY9YcMasd/g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=0leil.net;
	dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b="UVsb/q+s";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794915460;
	bh=eehK20zDjJD5pdq5vBF9991/jdDyuEuVdpDl+nVKMnw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d5dXdje4w+7g5+DQsliku18gQWVu2abNooSjDz5foxUwcoDvWdfqEfP8XKONxQA/Z
	 aV7Hup8cLLS3E+GALyvH0r4FIjGOqjsh6Of9nsmNjrUrdCHgidLY3LgBalOU8uWTJj
	 LUoMTIOpepPGoXE9y3NfjuDTcaB53ne0Zry1GoVlxixD9giuYOnuNeDl5irfa0ONay
	 Ahli0WKbQ/OYLs7XOs84Rb4pszN+3DIhZmLkwq9dXrTh435Lhk/QkQWvnlySVyqFtB
	 GKUd0P/XuMiaCUD97cGcaMxHCQobzgnh8ofdFoSAnhhYF21rKj7ZtztgezgLbq/q1v
	 qrAWM0tVH3MpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A17D5407A4;
	Tue, 17 Nov 2026 11:37:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E272449B
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 11:37:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C8CDD405AA
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 11:37:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d070nxxNirEg for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 11:37:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E6BED404FF
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=83.166.143.169
X-Greylist: delayed 8273 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 17 Nov 2026 11:37:33 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=UVsb/q+s
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=83.166.143.169;
 helo=smtp-8fa9.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch
 [83.166.143.169])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E6BED404FF
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 11:37:31 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jTN4k6hygznrx;
 Tue, 17 Nov 2026 12:37:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794915446;
 bh=eehK20zDjJD5pdq5vBF9991/jdDyuEuVdpDl+nVKMnw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=UVsb/q+sjhLfCd29iiN0BRPCjp9Vy0+BkNyHhSHRYiPXPMo1a+9hox15Y1+HnNFz8
 MAfNcQXxELIOpXJF0n6SywGRQK9Qeb9Z59EQRZRXEvvwdL+G+RShB3CxTZdvuribrB
 kRMfIuXglNYILkOZkCg9NnFeWmHfAlm6fe1ThjqrQqbTwqp8nvGU6k9HeU0cSRnxmO
 yrL+3S+hkCQazV5pgBdob8O+41QG/k9dVexoLymbVfReI4OyNg9LTfVmOTfcAYOcas
 4eheO7Tci+cfCR3HsCjqAnONwGX7PtL+b10CGfeTcxQJeNRt47PXH19bvoE/GuzlP/
 ZtikYUr8fW3PA==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jTN4j6hyvz82J; Tue, 17 Nov 2026 12:37:25 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 17 Nov 2026 12:37:11 +0100
Subject: [PATCH next 2/8] clk: rockchip: use simple formula instead of
 hardcoded offset for PLL_CON()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-rk-clk-better-con-names-v1-2-25521d4e37c3@cherry.de>
References: <20261117-rk-clk-better-con-names-v1-0-25521d4e37c3@cherry.de>
In-Reply-To: <20261117-rk-clk-better-con-names-v1-0-25521d4e37c3@cherry.de>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Alexey Charkov <alchark@flipper.net>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

All PLL_CON()s are in the PMU_CRU (CRU_PMU in TRM) but the base register
of the clock driver is RK3506_CRU_BASE so we need to account for the
start of the PMU_CRU as offset for the PLL_CON.

No intended change in behavior.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/include/asm/arch-rockchip/cru_rk3506.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3506.h b/arch/arm/include/asm/arch-rockchip/cru_rk3506.h
index 2f79e5eaf09d..9ddd6215fc53 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3506.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3506.h
@@ -48,7 +48,7 @@ struct pll_rate_table {
 #define RK3506_SOFTRST_CON0		0x0a00
 #define RK3506_GLB_SRST_FST		0x0c08
 #define RK3506_GLB_SRST_SND		0x0c0c
-#define RK3506_PLL_CON(x)		(0x10000 + (x) * 0x4)
+#define RK3506_PLL_CON(x)		(RK3506_PMU_CRU_BASE - RK3506_CRU_BASE + (x) * 0x4)
 #define RK3506_SCRU_BASE		0xff9a8000
 #define RK3506_PMU_CRU_BASE		0xff9b0000
 #define RK3506_PMU_CLKSEL_CON(x)	(RK3506_PMU_CRU_BASE + 0x0300 + (x) * 0x4)

-- 
2.56.1

