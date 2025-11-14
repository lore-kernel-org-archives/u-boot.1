Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2BD3CE7B15
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 14:48:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4544A84105;
	Fri, 14 Nov 2025 15:48:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dLfBm2L1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB7848411C; Fri, 14 Nov 2025 15:48:10 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEA9383EF5
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 15:48:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b73669bdcd2so185929466b.2
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 06:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763131688; x=1763736488; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Dyev5/vYvg63gF9vN94D2U09Y6mxZ19tygnNFNOKqRQ=;
 b=dLfBm2L1FOtXGz/LI3W/fAGV2tOLrocRtzlIcaoDNm6PtpWy7JGGEWIp8X08IGu/Ww
 o+Jnws3126udkLv3I23B/xJxS1EoDMZ878DG9Vgy/6JKIx4Nx0Z45Qml1gC3RhIvnQF6
 Xbn8etKjqXJ26F1nETxcZ+otmeJqDUs0SM8crKs/CcQPkQTUVZXxn/O/2MMRu4CG6VPC
 2Kw6pzke5fNffGZJglZCHrkFuGGakaFn/cUDmaF5Y/8D/g/rcBigiuhuflahROmpUOyl
 S20oGUGy0OkIg9JV9LC0y4eWZTxB3Syf0ztQIenyqAzZG+5CwwddB3XPtvVh9m+uGZGS
 PK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763131688; x=1763736488;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dyev5/vYvg63gF9vN94D2U09Y6mxZ19tygnNFNOKqRQ=;
 b=TImAyLk3h6+dXg1tMJW9wt3WxgKU4miEknhz4tFI5Sb7cKRFqyeKJnAm/fTHN4qvZN
 pXUQGnL80QjkxL9qBUWMxVq0Y0nTZAyZD5MHCLLy15Eb1D84Kx/U6ClxU99tmcBfYv+U
 AUrQZAcvS03+aDnI0kmzeYh46/wVC/WzVuEkutaBdR5B6f/Q1VQfCJDjRJc4UIWmPiRY
 k8UfjsMxAZPmkD+tqjIvFfkf42hqbe1b53yjBMZlyE6rPIudE6o2sXN2V5E5St3Vbp0/
 8VHw5qKd8zqkg7MEUxLH3Ihzd9lBk3Gy8qF5V2Mkh+YgoQKLmVGYeZLHtxeX3Jd98EVC
 NBJw==
X-Gm-Message-State: AOJu0YytrrrVxXkv4GKdHuIcvRYotBU4hT7rSKPFpbLip8v00DA4KVIg
 o2ekhq82qles5KXS5KmKOhyP9ph/ntbB2eB3UrtumSUtFkN1jYax02E0EilxgVF+BiU=
X-Gm-Gg: ASbGncv6OKckhOFYvl28+4BC+Wcs8iTThvoqzjUrBrNbxLhnt/wUyTtqOCd2+df9V7d
 v1D7daVqNYuKnjRtS0Gb05w25APGkhol7QOfsmRYqcLkXhB0OxMe6tE2McPVpIIFvlKo1EBZ7JH
 SjZ9gdHMDGvTmWGlXsC8wCxPwURbWFzsCwb8SHFS42M6kQdOM5L/5ev2yfq7LfkHvIC3xAqCVig
 rylIfUOsTCJ0oQPuwrk4fJIGUZujCn8ZLdovWsr15Sb3v4p2mBOorv1bM9jGU5za+eYrWDBgaLV
 n2zUhnDZHCozCz9IhmduIlxREXvR5Ort3l9svDNKJtcrl68o86uNJ8X3wFVsoBtCOwe2tIxv/Tl
 q5Hxxao7+2NoPZ3XXl9ChBEUqvQ4lm1MdGu0CPzczqvcm+fzOHugMmprjOqK1z7KFiYtnJvb/gx
 CUvP47Dg/Emp7hoq2C8gBARsLj
X-Google-Smtp-Source: AGHT+IELbiGfYgO10laHPzwBQKXGVBnneOy4ReOG1ietvgIsUbdgBl4Jgrg+D/xp90h/2NfImUo4Rg==
X-Received: by 2002:a17:907:2681:b0:b72:5d08:486c with SMTP id
 a640c23a62f3a-b73678f076cmr318410566b.27.1763131688253; 
 Fri, 14 Nov 2025 06:48:08 -0800 (PST)
Received: from toyger.fritz.box ([2003:a:736:9300:5f3f:e54d:4d77:4470])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b734fad41f1sm403678066b.23.2025.11.14.06.48.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 06:48:07 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
To: u-boot-qcom@groups.io, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH] phy: qcom: snps-femto-v2: assert reset in probe
Date: Fri, 14 Nov 2025 15:47:21 +0100
Message-ID: <20251114144722.173021-2-casey.connolly@linaro.org>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The power on function for the phy only deasserts the reset, so the phy
might be in a weird state that we don't clean up properly.

Assert the reset in probe() so that when we power on we will have the
phy in a clean state.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/phy/qcom/phy-qcom-snps-femto-v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/qcom/phy-qcom-snps-femto-v2.c b/drivers/phy/qcom/phy-qcom-snps-femto-v2.c
index 04f0f0e7817d..e782de07ebc5 100644
--- a/drivers/phy/qcom/phy-qcom-snps-femto-v2.c
+++ b/drivers/phy/qcom/phy-qcom-snps-femto-v2.c
@@ -173,9 +173,9 @@ static int qcom_snps_hsphy_phy_probe(struct udevice *dev)
 		printf("failed to get resets, ret = %d\n", ret);
 		return ret;
 	}
 
-	reset_deassert_bulk(&priv->resets);
+	reset_assert_bulk(&priv->resets);
 
 	return 0;
 }
 
-- 
2.51.2

