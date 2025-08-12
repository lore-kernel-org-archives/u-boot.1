Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B23C87FCB
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 10:37:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08E1183253;
	Tue, 12 Aug 2025 12:36:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nQITjYvl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4196583257; Tue, 12 Aug 2025 12:36:57 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F32B83236
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 12:36:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3b914186705so194403f8f.0
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 03:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754995014; x=1755599814; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NnmVwJmKyUJ5XOIPfi0yUX08NampTl64LRZpzV/9xfc=;
 b=nQITjYvlyETmvPjhcxYUyIEWD5KNVZTCr+VtDvhqTC2HXOttawc3o0Rfmt+tT0B+Nw
 q30pM9KbVmIAHyThpjRtRWZyUsGFJH41mnRRDarvuJAGFW9VkWF+5NfwVdP/Aa6Eq22X
 Vx3wyx5iUuHsdEnU8DeGDhlvjkiLbdnJWgAXRMpoNJks98geK0RZlTfaOgrGOm/AXnM5
 UObkQpJEP7exirksuXkWMDFqJpy3eh/VYUn1D4os8ZLl8o9WvNWjo3UGGuI0STBcJemS
 dDCpZdEou71e+zzERy+TCyyAEVmsWCnZ32SKBZS8sLdeR3PaeVRNPGsoGqBBZOnOs/Pw
 6Z+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754995014; x=1755599814;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NnmVwJmKyUJ5XOIPfi0yUX08NampTl64LRZpzV/9xfc=;
 b=maxTd+/RZM7vktG3Hx9pkc09eciqnVB6kq9zLswGufkNfdD5otPsCJsQP+QAf/yw84
 V0BFFDJl4F1aZHYqzsP7246EbKq9UlUxGWQ59Nkxij3XxNFUM2sbfLJP4lgCPsOzWrkL
 pLDbqlaq8l0NN91fvy3Nn5QvRUwlcsVk4m9Khb1gTrGTmvONKrF+N/RPw2J8qdnBULb6
 mBMvId9aXxCK03VXdEdQqurbJJWXhWRUkFgYkyi3W5WLPk7jY8Ugl8q6rdrEe9SpBjhp
 XVAyar75s/CpJnj35g/bx02FLuHAXTppzMnl7ITJXzmOvMIrJlId4TUKrBo5lNjyCAgH
 wYiA==
X-Gm-Message-State: AOJu0YzAFz5IoukPpTPc7BNIq8ZaebPi0zIbIdZaHr+Ipedt3pOm3nAO
 JswfUnz889b2bX4oPUUiROga7GtEXMT0paLgJMLzEKxPuCWPq5px3Zp0Kek7wIKD/TA=
X-Gm-Gg: ASbGncte0WsBRSxNe8HrrLi9mdyRIPv32ThhVJV84ogxEBecbYSeu6DtI3c5Y1WgWn0
 94Wf7gpBBMsZSXOFmTEsff64Rpzde2iJ1Tvi86tjS05qDOhhXl2FuR/0QMATr9qbM77XPw0+5K2
 X/G4fFLh6mNlnfDNgcvRd7n8a/ESRgI21pdhKWlGeGMfbg0i5W8Zl3ba257NZAOhTQV02u9QIYi
 qsXCXWUl8gk+H6Tn35nJ+10IK9uMrLVlFf3SxNfek+ibWv5MnjbWsyB0at2LSZOE10jgoaxPZ9b
 1l3TL7TKRXb+xyHoeEk7GAUgkKmLnqxWY3yWyqkGaRaE3eOZR7HGbLaECQpuJmWTrmo6aVm9Hku
 O6mYVyAhC/WIiMU6h6vccrOzYBhb5pbPNjUjw0uLSpDPStAHuJxg=
X-Google-Smtp-Source: AGHT+IETa4WeA0pmie+0OftapEmCJ7vj5cUKj5jw6Bxzv+ZSG49C9PvrzBPO1d/gmq0aTvYVp+JP0Q==
X-Received: by 2002:a05:6000:25c7:b0:3b8:ef61:bab7 with SMTP id
 ffacd0b85a97d-3b900b503d5mr11000285f8f.27.1754995014372; 
 Tue, 12 Aug 2025 03:36:54 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:97a2:1bc7:9f2e:6519])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8e054036bsm34109370f8f.31.2025.08.12.03.36.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 03:36:53 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 12 Aug 2025 11:36:53 +0100
Subject: [PATCH] sound: rt5677: Cannot test unsigned for being negative
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-sound_rt5677-v1-1-52105f86182c@linaro.org>
X-B4-Tracking: v=1; b=H4sIAEUZm2gC/x2N0QqDMAwAf0XyvIIWnN1+Rcaoaap5iZLoEMR/X
 /XxDo47wEiZDN7VAUo/Np6lQPOoAKcoIzlOhcHXvq1D453Nm6Svru2z6xz5HDDji0JCKMkQjdy
 gUXC6IqF9vfSilHm/L/3nPP9iSJRvdQAAAA==
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

In rt5677_bic_or the call to rt5677_i2c_read returns an int so old
should also be an int to receive that value and then be able to test it
for being negative which would indicate an error.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/sound/rt5677.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/sound/rt5677.c b/drivers/sound/rt5677.c
index b5c997c6dd5..a9d1e94951a 100644
--- a/drivers/sound/rt5677.c
+++ b/drivers/sound/rt5677.c
@@ -94,8 +94,8 @@ static int rt5677_i2c_write(struct rt5677_priv *priv, uint reg, uint data)
 static int rt5677_bic_or(struct rt5677_priv *priv, uint reg, uint bic,
 			 uint set)
 {
-	uint old, new_value;
-	int ret;
+	uint new_value;
+	int old, ret;
 
 	old = rt5677_i2c_read(priv, reg);
 	if (old < 0)

---
base-commit: 7807ed921314cd7af83fd88162d0b8c6fb20a9ca
change-id: 20250812-sound_rt5677-e2f8cfc9e8dc

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

