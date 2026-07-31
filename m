Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BCBC55173
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 20:32:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A13B40F76;
	Fri, 31 Jul 2026 20:32:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2QsutFbLQ4IB; Fri, 31 Jul 2026 20:31:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EB72840F1B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785529918;
	bh=bXEosqCQf7L+8/nB+E5zVQgOFmWm3iZzkjDSvKGeGRU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qDUsNgelKuFanR/DTJVDRNMjag6Kh3/Mp2GLQ8fthACulsnjCuHOyRl8Hh1oxgN2z
	 8RCqhPT9YyUvoFV82A2HzwxSVTPtPBx7hy5qHcaN4mFX+4D2d3ryS2hUGnahdLHs2V
	 gX1/s/BNQ+x3bqgvh97gHaBQHSEMgU5JblJAgYtikvDgukRicijswrchxZ7xxSWtJw
	 Ko8/stKIloNI8NR2OYPs/5Te1OXDLxsxYaraGZjLCePIQNyKvWCIwgikXQ5tma5XGP
	 v5wrLoNhcH3061irx3c+ojmQNpy5VoxjG9yRkT/4eZx9qH/09AmO8qKw8QdK99p1It
	 3sIbq4e9kvOQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EB72840F1B;
	Fri, 31 Jul 2026 20:31:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8345E3B6
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 20:31:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 68D0C40119
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 20:31:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UlGhVWXvqD1v for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 20:31:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::232; helo=mail-oi1-x232.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6E9894011A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6E9894011A
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6E9894011A
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 20:31:52 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-495b27007d0so713926b6e.1
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 13:31:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785529911; x=1786134711;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bXEosqCQf7L+8/nB+E5zVQgOFmWm3iZzkjDSvKGeGRU=;
 b=DwomnuA3dUbwlow7RpnY+vKO81oM9X8Sh+LGmvOfnz2XCy2+XIIb+LHWe6ng/y5R5/
 INOxmMSTYR11eph3NO1jBnnsYeCAIgkKlsKtlnMuxTd0HQ1MWAd/RkuW8x5bV3w+kA4S
 i8jMj82CDpFW5ehfbSD2N4crFg4eBjy7H/hft/PXWADsl6dPxsa0Y0Q9etqF3+mXrwQv
 u7q8POVPbQfyIgAChzOo2CnWEz0zBjLIsuwQoswlPG89OnQ6TaHMK7iE4W6R7W+tuhCB
 h22Qt/ywookkwzJpRutgFZRtbWvnbxUzsjl/eqpBneMdwhsYwjSaaRS/XydhUaOQJG/h
 GM9A==
X-Gm-Message-State: AOJu0Yx8iwcHU27mSyj9oFzosQUd5YVWo3E6nNFNGpr8caE70VZvIO8G
 9VuTiis0CAOGiPKgET+tpCbit9MRkwp974W0j/l6rccYOQ81r7+UJCyGRK2nRhLw+E4=
X-Gm-Gg: AR+sD13K5y28oPuaebZpL3GxWhllnwrKMWIGM8PF9aeiw2Ovn9kt7W4mqmW5K0x6ryG
 0gSAzM2uGu0nQ0CUMwcVgrKRr+Eq6NQGxhaAMm6Vw6rF45fHJvfUoepuzGxZ+CH9B+q7PgWUn+R
 7ZRuF4/NVO64NA3FzA71DXNqBJRy7HcnDQ8lbCndhHt5MsLyBAp4x7GFwxHhi3NHf0hY57UuDBv
 SkhQyGE6EzSrRfqyrpFiV/WDrbeMi8A6cfmUNKgzuBeXkzBebgT5cNhXsE3tmUAVnLzQWZ4azs9
 YfgNsHJzW+rH7VkTdg41pC7+7WMRdTrYXgmhsL7bTWjM102EwiRlslHDu18uIeHj0haujR4Mbt3
 rrhduGfxn0fG2dI1j3W2mwl2smlutQyDUEJK0vniNOYhd8XlFKHGV6/v0B9io0F+2eJyFfWYPSw
 Jtu3HSQiD8oChkC9rQRrV1tLuvSvDowro9YYies8VA1tr1Bn+U39R4JmYMVCMOo7BGFw==
X-Received: by 2002:a05:6808:4481:b0:492:8920:81ca with SMTP id
 5614622812f47-4af5e031e79mr3021591b6e.5.1785529911304; 
 Fri, 31 Jul 2026 13:31:51 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:fa40:746f:401a:3b75])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4af58ce0a1bsm1445791b6e.2.2026.07.31.13.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 13:31:50 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 31 Jul 2026 15:31:27 -0500
Subject: [PATCH 2/2] arm: mediatek: use phase-aware PSCI reset on MT8195
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-mtk-mach-phase-aware-reset-v1-2-90b918aa52f5@baylibre.com>
References: <20260731-mtk-mach-phase-aware-reset-v1-0-90b918aa52f5@baylibre.com>
In-Reply-To: <20260731-mtk-mach-phase-aware-reset-v1-0-90b918aa52f5@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=770; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=ke8R4vP/VbSOlUKNuatYyHboPR0E5duLPHT0vhv+2Ak=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqbQYt95kpaxHCFJws6s9SaaFIcWeuercGALS5F
 E2ZVXuot7mJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCam0GLRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A5HcH/1e9qFMG82cqmamfekfUhai+yvjEp2zmhi+/PYA
 YT26aRfj84hpSnNr6OHJFXXaHluBt/MoM2SkdX8G/GRaMpT/OrSZQ9BuuXScLtimIUo1lvKnmc2
 SNf7CTp2MJ4EDFyEANrlwxCLcyVru0VoLuJ8aj7zxiiu+DF1XLEO9zii2QtUdMXFVjLqhEytbsL
 mv+ErxmJYRtN/Q77th6FSEn7y0crpPpWc6lF+c3UhyarC004z4sBXbdEVFAv1LxLPcydYiVanR4
 SlW9DBCXxDG6lre24YEw9bcYJxGldb7BLItW3/N6rJBUa5uUiiKlHXINWC1SfxrhxNjL4+dhxCd
 Ptrw=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785529911; x=1786134711;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bXEosqCQf7L+8/nB+E5zVQgOFmWm3iZzkjDSvKGeGRU=;
 b=C6WZ+zteHEjHlqG+s3koY4HFprIDbnhIbi2wm9CLKHlKPwDCa0LFbIvbyD4C0PimSN
 T5h6iYgEq54P9As+E8F0evAlQBssGa3TcZxA47wCxDD2vAgNJYumVcD8aQyNsTjd25XU
 FCBlxdN2gLx0q3rchi5HU4Cmmui9DnqVZCb6TmMh54pwKKUh8pSCDXpE9SvOhEeG7EYC
 BHw6f8MTeZuALUz83YMUiG+aN4nXW4Z7uqM2zNXvDr9iarryY+Oe7hnX3FN81Nk9PcGJ
 e+Jk+tqk3lSCGeAxUbLK5A6tvz0mTUNHfHuCYOrREClZRSP9H6IjaESUlhE4DOi9wHZ1
 6TIg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=C6WZ+zte
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Change IS_ENABLED() to CONFIG_IS_ENABLED() to prepare for SPL support.
PSCI is not available in the SPL stage and would cause a lock-up if
called.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/mt8195/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mediatek/mt8195/init.c b/arch/arm/mach-mediatek/mt8195/init.c
index 83cac9d01d6..6afb7330b4e 100644
--- a/arch/arm/mach-mediatek/mt8195/init.c
+++ b/arch/arm/mach-mediatek/mt8195/init.c
@@ -38,7 +38,7 @@ void reset_cpu(void)
 {
 	struct udevice *wdt;
 
-	if (IS_ENABLED(CONFIG_PSCI_RESET)) {
+	if (CONFIG_IS_ENABLED(PSCI_RESET)) {
 		psci_system_reset();
 	} else {
 		uclass_first_device(UCLASS_WDT, &wdt);

-- 
2.43.0

