Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 532BDC87FDA
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 15:24:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A029B842EE;
	Wed,  6 Aug 2025 17:24:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iZqHhYr2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96C94842C7; Wed,  6 Aug 2025 17:24:41 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C8C884307
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 17:24:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-459e1338565so251305e9.2
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 08:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754493877; x=1755098677; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0sy/HVvflcM5WUSKwcKPqvYmbMERubvHFwyEhFUIZZI=;
 b=iZqHhYr2jq/NRGobZGO0g8T/lxLIdXEmx/F1fKoPerQv/fAUG7SAX6woLhZU0LLJY3
 q4gizMBQ8yXJq0fCgdgfkifqjykWRH09aS9yOaPlbYrJ2J6nc2dv8OE750iwE38b6rLs
 pTAmC4nLK2QXXhTeLSXgWnFG5QULtWglMre0voRxzAaf/NjOCB79tGH541VCrtfQagmn
 14Mqt+DL63bOCC97+sj33/orOknkLh9Wa5k8aQgB6ItXUrjkqvcDv2/Kt2Ny77hYEnTF
 26PsW7pH75yWB28OO7wfM0PxSKq3shaKVWyHyjgg766dQ1c8ZRvqryRzhoSXYGW4jBOP
 iq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754493877; x=1755098677;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0sy/HVvflcM5WUSKwcKPqvYmbMERubvHFwyEhFUIZZI=;
 b=fLbC42rWoNANf1U6DbyQur3eg6GKdof08L4vlDVNXGtqNd3yxLQZ0Q/gK5bDMCQcho
 y7mVjsp5EcJtnXlJpEzKPPOYSMcwDNIQ6k/rZCNnx3o1Nl0xZs3Qf7tPFBS49hm5dEc5
 mLXsbnuv/a9y4meIBjVXTCzC/bExv+vgLZgf0pKx1qNqCGcvgoyz2oMD8DX0aAyIIdJG
 QJTVqzvY4cWoNm3KGyyVqMlBVE8ZfqSde6sAXUbnH8r00ZzKAi4carPPtwykj0vRXMER
 qgGFaGiXr2O3Oz3fHlhnFtZaopctJinlMFEWTCghlszx/ZLBhCZ3XqJoziF1OY/xB30W
 0U0g==
X-Gm-Message-State: AOJu0YyfSFJs0DViBaM78J9oyhxRTaR5K28MUhRtuaKuUsLxJlVLehef
 V2qgV3CxOhqVvvlWr9q4a/g9wvZsdsDGmo52VR3tGqgnwQNSfhuP89bqnJf8z0Sf84+3tM49DpN
 8wqru
X-Gm-Gg: ASbGnct9l8xSAO0CZpITv5ggS5HzdyXG5GZET3LKi4jyQQ2mSk8o0lxUiX2aI4y4cW7
 w8heqEpbFDg34yrnLn61Y7D+XpEbukr/WfuiA7EkxVE4Belbwv4W78np0VpYyml6VOd3tQQlmCR
 qYPuGQAHigI3e5yclGERyQ80bbwRLCPvFD4GiMgu+rh3PI6z+eEgPhHUjam5dfUsfYiguUtG0x6
 OW+tHBKeFkv/aTBoGRmYHZ7G5SYOgY4RvPyUrg1WTEWkyGFPaimANBoMkxUDC2eWPPJiSkUCA9N
 syaab9ac4IBXV3ApBnQGBKqxCGWxeWEsS+1xOe186yQfzah0b+1WbWERr4VomzcQ4v8QJdPht8i
 BKLgvQGA6nKzT7gx3OU0ZSyRluVEFqrOd0LnFmRTGE8hggzdD9x73yq0MfnvICA==
X-Google-Smtp-Source: AGHT+IG8DtEQK+fZph8DwHVThKKcb6+lySEm1mV8HTitLMKWTsWcpf3pxgMdwKvU0qjMh1aUiW9PQA==
X-Received: by 2002:a05:600c:3ba3:b0:458:bc2c:b2ed with SMTP id
 5b1f17b1804b1-459ebb7ca05mr10759295e9.7.1754493876663; 
 Wed, 06 Aug 2025 08:24:36 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:6501:9a0d:7129:a02b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4595cfea56fsm98132075e9.1.2025.08.06.08.24.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 08:24:36 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 06 Aug 2025 16:24:33 +0100
Subject: [PATCH 1/2] phy: cadence: sierra: Remove variable that is not
 assigned to
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-phy-cadence-sierra-v1-1-2f0830caaacb@linaro.org>
References: <20250806-phy-cadence-sierra-v1-0-2f0830caaacb@linaro.org>
In-Reply-To: <20250806-phy-cadence-sierra-v1-0-2f0830caaacb@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

In cdns_sierra_pll_bind_of_clocks the variable 'i' is declared but never
assigned to before its value is used in a dev_err. There is nothing
obvious to assign to 'i' so remove its use and just put a default of 0
in the dev_err call in its place.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 2c9d5a12127..46a728405cc 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -602,7 +602,7 @@ static int cdns_sierra_pll_bind_of_clocks(struct cdns_sierra_phy *sp)
 	struct udevice *dev = sp->dev;
 	struct driver *cdns_sierra_clk_drv;
 	struct cdns_sierra_pll_mux_sel *data = pll_clk_mux_sel;
-	int i, rc;
+	int rc;
 
 	cdns_sierra_clk_drv = lists_driver_lookup_name("cdns_sierra_mux_clk");
 	if (!cdns_sierra_clk_drv) {
@@ -614,7 +614,7 @@ static int cdns_sierra_pll_bind_of_clocks(struct cdns_sierra_phy *sp)
 			 data, dev_ofnode(dev), NULL);
 	if (rc) {
 		dev_err(dev, "cannot bind driver for clock %s\n",
-			clk_names[i]);
+			clk_names[0]);
 	}
 
 	return 0;

-- 
2.39.5

