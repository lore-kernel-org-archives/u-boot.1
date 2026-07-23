Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 863F1C531D1
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 15:04:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 40F9160A6E;
	Thu, 23 Jul 2026 15:04:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PT7XXg1nt7TU; Thu, 23 Jul 2026 15:04:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8D4D360A64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784819097;
	bh=Q0fKAZqiU3vIT4nSRRYb4C+RutE7mHxkh/r6IDIKyFs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RV7heR094XCEantCXkRLoK5ExRQpQqnpMrtDRXbdW7Z7BpyscOXKDtC+eun4FkPqW
	 57Rp6TQ5r1m7UBcMQuwYLc9OrNU5w+9Yai9dQHhTVDABT5zAOYp6S8rUuGJRzPFfaZ
	 GwiVOIr2Buc3KuVTbdzoIuoLCD2atQYqTFboJxbBqBiM6fjtquAtIst4YY6obmzUiV
	 9Bd2xtDHNqereCDm09H5fwz0HwWC+yTBcUxJ8bcg02x55QDPnhBQNIRCL6mGhisLvI
	 /IQnT98TmgGmstMADS3TKP+Oh13yGjJ1JnYz/kyfzKbKd20uRY92RLK09vwSmkdWWd
	 clqPCcVnMsVYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8D4D360A64;
	Thu, 23 Jul 2026 15:04:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 590B3429
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 15:04:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4B753401DD
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 15:04:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UUb7nh8ycjWG for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 15:04:55 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 13E464020F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 13E464020F
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 13E464020F
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 15:04:54 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74FE380287; Thu, 23 Jul 2026 17:04:53 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DB2780087
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 17:04:51 +0200 (CEST)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c1c4c7ddaf6so124467366b.3
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 08:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784819091; x=1785423891;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q0fKAZqiU3vIT4nSRRYb4C+RutE7mHxkh/r6IDIKyFs=;
 b=CY7oDpn7oL6OwdrGe4x+4oT2UIZWjcc7pffT+Gca6+I+pgceu5NzCYHn8kBJuMfIIP
 +QbwH20QjxkGs0sZLNejpEk0jvAkoWfIW/TnhA27k6bZObXuk2E9sIYqgzfXNV14NmWh
 4b3xDCpaUlydzjoVjkHsWSHXpFQDvHNGDum9CxPuXZlqu9IGH3VY4OgOi+GOkDGeAJDt
 Mv0chRKAcc8UCxCOaCugUgcu5GAGE1+BffpcpwcAQZ4FJR69UdV/EPjDWLBtuzQjDWkM
 rdnRIYuE6S8mw9omZ+Tt2sJYjcwAfBOqBeO/sLMDIpbMFaRiMo9FW9py54ZvLhR4psSg
 SzXw==
X-Gm-Message-State: AOJu0YwkV3VUQQd0jgLuwKKsRmChqtxiRB8TMkqYWoxyASlOzeZ40iZe
 OyZclqSxRUNt5OXjZM8LCF4TML0bDDyyVbfFl38eWBOPMf1iy8x5MSnlwFaKqN9feYY=
X-Gm-Gg: AR+sD1213HiiZQcj3+tCC4LOTFZ/mJN3mOPzbcaFmMSmypx6J2SZfrRFjaLnylIAe3f
 ZoYynNv1RfDlBnLMuVQEiNcmBlMDaPGnd89zZL3jQ5j4yKwXyOZOue/4iCPzw2X0HqE2j2jWCjF
 toO5ce8OJ09Dpd0SJ4pBxtLUOHLtQRnhFJFshyqshmIzGvxNYyIvDxQiyn2kol7SssORCt+DyOK
 XaWE90OxEiLw3cTmrZ8eSqQvhpwjjiPed6+SZ/2/5GrgXF6r60lLat1WI25ovWyQbBB8gZsweSP
 6yz1yoSCHAtJmmlZWAORw5GppeMzIem/wRcNbSf7jENL9Tog6M+crvns+Pdt0GMr+h36k+GqUA4
 +6SnvCUG9yOJzquGk5AdsOHtXeOWexeDEesNC0KURQafrV1REceB/jVDZKDGVzXpNur0Bna5Fj7
 k4+3AzX/oWaJ8+bOHZpcbyFnwRQavigUBv
X-Received: by 2002:a17:907:b045:20b0:c12:74b8:9d3 with SMTP id
 a640c23a62f3a-c1c5074ff1amr113739966b.3.1784819090950; 
 Thu, 23 Jul 2026 08:04:50 -0700 (PDT)
Received: from alchark-surface.localdomain ([193.32.126.214])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32f1127fsm248769566b.55.2026.07.23.08.04.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 08:04:49 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 23 Jul 2026 19:04:25 +0400
Subject: [PATCH v2 3/5] clk: rockchip: pll: fix RK3588 frac PLL result for
 k=-32768
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-rk3588-fracpll-v2-3-382d113f3a80@flipper.net>
References: <20260723-rk3588-fracpll-v2-0-382d113f3a80@flipper.net>
In-Reply-To: <20260723-rk3588-fracpll-v2-0-382d113f3a80@flipper.net>
To: u-boot@lists.denx.de, Elaine Zhang <zhangqing@rock-chips.com>, 
 Jagan Teki <jagan@edgeble.ai>
Cc: Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Finley Xiao <finley.xiao@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Alexey Charkov <alchark@flipper.net>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1250; i=alchark@flipper.net;
 h=from:subject:message-id; bh=dIuAfc8EMGVMgiHRLgNH6vYlqbFKY6g2whmc799GtUA=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQl6VY/Mp3MeOn8lXsHOabqRkp/O/fsPFfr7bDwQ7x6d
 tPOHFNa2DGRhUGMi8FSTJFl7rcltlON+Gbt8vD4CjOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GRrpGOsYMXBxCsBUC29kZFitceTazWuqxiuEyp9vzr3ZNdvo9eJLjE4+AdNEqxd96ExiZNjzd1e
 SwRahjasdeRhLut9+/vzAKE/dW29xZuOPx0uupjAAAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1784819091; x=1785423891; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q0fKAZqiU3vIT4nSRRYb4C+RutE7mHxkh/r6IDIKyFs=;
 b=3pqLnmvhAHWEr7+VJlbLpfb/7QmLnIxTIYvN8S3lm2iLzsXY9TFTcBUGeXjx3JWZKg
 cqJ/y/6eYW0bjXiNFN1XGUjNABLStRlfALaXXRswUGjLci0TnNFb8up9TN5xmKfG4TQE
 lO1vqOkLvHN8Fh7WW6mHvobVYQ1IdIpqlo3RUKWLyRef7oZFgikYrXiObfG377owa25R
 SnSk3HkBiWKRuYGuIBR1HnApHjRLt3eybCnrvhoQV4RmY0N/6cDslwhqxHHyb+ZFxDYL
 CRPUkNr21mV0jYfDcPDcowmGzcO/I72KypOx3rShNYNkRrx9wI7niI8syjmo6V9ufZFD
 svLw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=3pqLnmvh
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=alchark@flipper.net
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=flipper.net header.i=@flipper.net header.b="3pqLnmvh"; 
 dkim-atps=neutral
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

Current code needlessly sets the k value to 0 when it is calculated as
-32768, which is a valid value for the RK3588 frac PLL. This results in
the PLL output frequency being higher than requested when the requested
frequency is exactly halfway between two integer-multiplier PLL output
frequencies.

Negative values of k cannot be greater than 32768 in magnitude either,
because that case has been handled just above the enclosing if statement,
so the check for k > 32767 is redundant.

Fixes: 6bfb37e70209 ("clk: rockchip: rk3588: fix up the frac pll calculation")
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/clk/rockchip/clk_pll.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/clk/rockchip/clk_pll.c b/drivers/clk/rockchip/clk_pll.c
index 69d2d182dcb5..6cef5a36ccfe 100644
--- a/drivers/clk/rockchip/clk_pll.c
+++ b/drivers/clk/rockchip/clk_pll.c
@@ -182,10 +182,7 @@ rockchip_rk3588_pll_k_get(u32 m, u32 p, u32 s, u64 fin_hz, u64 fvco)
 		 * Round up to avoid overshooting requested rate for negative k
 		 */
 		k = DIV64_U64_ROUND_UP(ffrac * 65536, fref);
-		if (k > 32767)
-			k = 0;
-		else
-			k = ~k + 1;
+		k = ~k + 1;
 	}
 	return k;
 }

-- 
2.54.0

