Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43454C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 00:01:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8353B88BD2;
	Fri,  9 Aug 2024 01:59:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YJms0IEE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BBD088BBB; Fri,  9 Aug 2024 01:59:49 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B0D587A09
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 01:59:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a7d638a1f27so61983266b.2
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 16:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723161587; x=1723766387; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2Wqu1Uvyi5YgGGYu3IARDoknlHLGsOsAO8Gfaus/WvU=;
 b=YJms0IEEqbqWkEoyI2H8H9fRoqx76Otimru/mUuiM8csDTW8ZZyMETyft/RFoR9pfw
 AbFatuefgdSMbe18mDD+PixHvIfpjPi6nSTdawX1KKg0ByyBtCpN9uTLYEiiAp5kvQ64
 +CpmRGl8WOKWLDF8YCes999zGw1YPtRmMXmtJxcFH/sE2CG1CHlzWDAgJ/ReRarBKtcN
 Pc4MHjvGdOMormgLsFC7zfXDkbomR8Yv7ZHj2acW3sikThZTL/9/NNLB59JMg3T16Ukn
 kVzG05SgCxffomHgcvaqEHX/CNaE6uA6D3p6pHzuoM475gDpCSLuMXUYwFtFY5MC90Vq
 xDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723161587; x=1723766387;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Wqu1Uvyi5YgGGYu3IARDoknlHLGsOsAO8Gfaus/WvU=;
 b=hREn2hB9f23D+6QlDIr3fnPeC+L5YZB50mN6tntXZ8W2SML/QazC1lksevLRHSQ6MM
 Ajt/Vk0CjshHpUOhaEicbFoNb7jcW3Pxc955E4rO71gTi/7J5D04z3FUfbAd8+qUs/sZ
 tr/79fjFqt6qTRtdJpKeiXelE9HQajI1LwBZJ7CKl2mrQI4JWBUBKeXocLrNaeBMHr9T
 cDAKKhcBV9VozfU0BxVCbd5dn9BK+nBGIhRsbEIcU4K78/Nm9nzz3q1JReoNByC5KPSX
 xSP/VgzGmROh60wAQTfefZy9qPMd1Qry6bvrDsGYKuQqKTsWJpShvI41xXqjZ5nETzAd
 u29Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQFYJlG/Y0oPDQzUiLdZUTHqvsmes2TYgtiH13BvRe6t6no92oymOyXkM4yRPdQDCMmQs9ghsLrMvmG0QuwiNXk7LQjw==
X-Gm-Message-State: AOJu0YylIvF9qqLMBiwPHWQGy8TeZK+K1N3TDWfjN9NRNMcJMu4meq8B
 oFZsKiLpO70ml8ll7kNwyo/q8i2WV3nKmOJkjvcKvch2gzvB1Pnr3LpY825CP8o=
X-Google-Smtp-Source: AGHT+IEwJFpqY0tIizRe4pZXyodYRLMjzObcsE2PPesXJfreeo6I0l1493Uh6G7pc8ozRQepyoBXFg==
X-Received: by 2002:a05:6402:2709:b0:599:4d01:1fb6 with SMTP id
 4fb4d7f45d1cf-5bbb23456d1mr3333011a12.16.1723161587044; 
 Thu, 08 Aug 2024 16:59:47 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9d45423sm784047866b.134.2024.08.08.16.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 16:59:46 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 09 Aug 2024 01:59:32 +0200
Subject: [PATCH 09/11] soc: qcom: cmd-db: use strncmp() instead of memcmp()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-b4-snapdragon-improvements-v1-9-7c353f3e8f74@linaro.org>
References: <20240809-b4-snapdragon-improvements-v1-0-7c353f3e8f74@linaro.org>
In-Reply-To: <20240809-b4-snapdragon-improvements-v1-0-7c353f3e8f74@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=880;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=8CasCoMgEHW8iOYaZ3r4nayrrozqXM5UfR7Wgz5krak=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmtVvorrMBpPnxeoe/4nacEdsDBtDXAcf4CxcKl
 hdkiNEnjkKJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZrVb6AAKCRAFgzErGV9k
 ttazD/9osWNfjDkfSe+be0ZZfYlrb6WYFRSqsQ+8K3rZVVYk4AgUofI0/Z76+GRmr549PkxvKyY
 YSTp8efF73vtrTnke5EuIBUit7+fsfyFCCMSXkQqETOfzsi9LVG4p9D5NBo8rZysEQzra8cpebG
 7PfkMK9WSRbpo+wpEDZiU153UA0NAe+0eGjLlsQrCSgZBb0ahI1TsU4ZyuxckIZV7qDCX9ldizl
 gjmvCkNOUjmkGdcSqmJiLmtxdzuGL9Cy5hj6unF8+ABIqAbc17H7pzwRny0gJNxF7xGOckLNTsk
 +M0P+iM82fbUmsEXUkMa5lb+ZTfhXw25Cd830eqerH4fwbw3EFA3UmxY5bsA28j/ZY3bb7d4DOi
 4OurfLsQwOMRBAwwd+UwIpEwy4XdrBauFE3Yi4r95C0vKiAhSAhbDhNOh8N3/XXHvapk5eWB9N8
 3w9rlap8tOKlPthLxYPzjP9h8SDoQoz07+7xDbRm+VFwyAospwZGFBvcyFpbwMX8DRfXdxK3kDp
 vzPujHd3sYTlCIaNOw5g+gPYxsLlNYoficsrFnRXYeBBO1DpdwptniTE/PtcpVztcfOLVsD7jT7
 9876hKrVT0i3+GmY9xMzwuvPCTFrarxwyPCZyrqZGgJwoFCep5herTpFJnH5fANSMt7LPHvPr4E
 9nTnLAYXsezv3OQ==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

memcmp() can cause aborts on some platforms and generally seems to be
the wrong approach here. Use strncmp() instead which is more correct.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/soc/qcom/cmd-db.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index 08736ea936ae..c7c5230983d5 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -140,9 +140,9 @@ static int cmd_db_get_header(const char *id, const struct entry_header **eh,
 			break;
 
 		ent = rsc_to_entry_header(rsc_hdr);
 		for (j = 0; j < le16_to_cpu(rsc_hdr->cnt); j++, ent++) {
-			if (memcmp(ent->id, query, sizeof(ent->id)) == 0) {
+			if (strncmp(ent->id, query, sizeof(ent->id)) == 0) {
 				if (eh)
 					*eh = ent;
 				if (rh)
 					*rh = rsc_hdr;

-- 
2.46.0

