Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3FAECE564
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 09:22:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8839D88FC1;
	Tue, 10 Sep 2024 11:20:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Q4ITwJzv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1E7A88FB9; Tue, 10 Sep 2024 11:20:44 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE02688F73
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:20:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42ca6ba750eso21825755e9.0
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 02:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725960038; x=1726564838; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5R77FTIvtPNu08lHr7vGlHnrY8zzK4MdH2DqP4QqLdQ=;
 b=Q4ITwJzv/E+LcDWtCkVgQaOR4GO4SUL5rWWmfq5ATfumJ12KVz1+0stK8uhhE30QU1
 Xq2k8NNKEjUWNN9l8h2OxCM291R1C2BNciYP0vwfE+5og6jGrupfvy0voNlYSsYwakPq
 b5Re3rYLWFLUFzlYd6i1k/rg8pXjEDOG9CZRcnVlpNTi4OYagxdllAqOkfJ+ecEI/RxK
 9R9bwQpdXPlrquHyA5rVSuf6TQd980ApT2INHVjlMCWXtVaZ/RCboBpXJsXZ8uWs15ON
 kYRpBNR+E5YTn+S5iTOgztsge+rif79VXzuKggh0Ii8bSatWy/1WSD9wycrXErNEJF53
 tlNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725960038; x=1726564838;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5R77FTIvtPNu08lHr7vGlHnrY8zzK4MdH2DqP4QqLdQ=;
 b=W69NTPkOELB7OEIT/3YEhVIPqB4wROOUmqZ+ntO/UB7FkVsy3LjCT6yfjIqaEP6Ylk
 Ibz9gbYO+EBq8RyGBq9gZ/1F0i8pBdQ2cn+TdlMy+g8WvcIYXA/D11YXCos7+lHN+tyR
 fZbkLjMKPpoX8mQtO3khCHSeFRpWQW0zcMRq2LMAljojZp+5fbYiA+xelw5w8tZ3mOXL
 ZD6LmNFkueAfJXE73P9BljxBRqyfAsAAqwcUH7lBX91YSdBmxDHidkKssCYEaSaE5Y6v
 EDS8TfKAjaxc9Wh4auLcppE+P6iq5EOfYYWXXgnM6/EBTWssDIwd9wgrfobsPoBVigFj
 a1cg==
X-Gm-Message-State: AOJu0YyoNRHhDncYqcTf1vrNnBLAxAgpEkOavKs+msTgMEnXlt5dCrAY
 Vl3ItHvPD/rO05RivwfYkgJTN9jVGITkOh9d7TaJMgVrwy86lPJ6zwbA68jX/Ek=
X-Google-Smtp-Source: AGHT+IEBvVe/puofqkx6sxa26WEIyjLtFDg6XaacrzLz9XpMtG2Zui9jayy02bzK54V9wSaqgDETIg==
X-Received: by 2002:a05:600c:4f08:b0:42c:b54c:a6d7 with SMTP id
 5b1f17b1804b1-42cbde1a7b6mr13899315e9.14.1725960038071; 
 Tue, 10 Sep 2024 02:20:38 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42cb099acf6sm101256245e9.9.2024.09.10.02.20.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 02:20:37 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 10 Sep 2024 11:20:29 +0200
Subject: [PATCH 12/13] ufs: core: remove link_startup_again logic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-topic-ufs-enhancements-v1-12-3ee0bffacc64@linaro.org>
References: <20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org>
In-Reply-To: <20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org>
To: Tom Rini <trini@konsulko.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1234;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=NrIM0ZBahJTnOEZXBhlRGdNy6U8dDMrbIU2LDji0hxk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm4A9aUhOolvgxKvpxtsAo2w+OO3eef2gtQ1ljlzB6
 r6BIojGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZuAPWgAKCRB33NvayMhJ0XH2D/
 0fV7p0ujSUyT3mzPtmxDpVu6QuvyvQGjaQ7ImIn71kpU5DLhSbYw4yovTa+0Aa6V1e97yXJ7f6TehB
 VWbPGSDbqYcAydyo+Wsjjt0u4GcwQHYgWJsslZkLNM7xtb2pEznhBOlx0/OrbCKfAPlYwVtSSf1lb+
 sbik85E5WhXb7KMXczlmtf/d8L+22F8kkwhj+HP5xj5XvuK3zdyUH4WDbBZgvLw1TAx9XKOGkFmStQ
 InWZteD2pv5TPPHz1DdKyk4Nl2h0bBCucResnkmEI7IAcwhCmGgT2zFZRcw8UAsvfTB0f3yej3lAjn
 T/JbATTSd+MOXK/9ebm65kQQL0mWN3nQJ4v6fyxs6sz3fW4A3DleoG8OMk4+afQRb3GxNoKzzoXAaM
 W3Z+UQxAcllTpjTO+ro7hmD14tIdNtQPKQUjTnpawwp6fMxHgzyJUQXq1iizbn4krCY6oJtTZah+eI
 zrQGlmLMjc2D/v/juZdl4YbLbKUjFXxS4ZVzg/dp6dW5LIqtcU3cnT3wzD+D+u2YUBaG1UWnEupjJ4
 7JQpf5oCWnkMREPgpVQTzETUmdh19+pw5M7yghSJ/FTd+1P/1OHmDNpL3qY4zhO+4ZzzgaCpQus91V
 K/woFGvfKbOcQ2y6rGbNGWzCEYS7tYZo9Gnr5cX9hwBit1oIvktFxVXr0U0Q==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

The link_startup_again logic was added in Linux to handle device
that were set in LinkDown state, which should not be the case since U-boot
doesn't set LinkDown state are init, and Linux sets the device active
in ufshcd_init() for the first link startup.

While it worked to far, it breaks link startup for Qualcomm Controllers v5,
let's just remove the logic.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/ufs/ufs.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index d2df5c26f76..e34e4586224 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -462,9 +462,7 @@ static int ufshcd_link_startup(struct ufs_hba *hba)
 {
 	int ret;
 	int retries = DME_LINKSTARTUP_RETRIES;
-	bool link_startup_again = true;
 
-link_startup:
 	do {
 		ufshcd_ops_link_startup_notify(hba, PRE_CHANGE);
 
@@ -490,12 +488,6 @@ link_startup:
 		/* failed to get the link up... retire */
 		goto out;
 
-	if (link_startup_again) {
-		link_startup_again = false;
-		retries = DME_LINKSTARTUP_RETRIES;
-		goto link_startup;
-	}
-
 	/* Mark that link is up in PWM-G1, 1-lane, SLOW-AUTO mode */
 	ufshcd_init_pwr_info(hba);
 

-- 
2.34.1

