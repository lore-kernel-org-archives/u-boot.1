Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4941C28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 09:25:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4862381E06;
	Sun, 30 Mar 2025 11:25:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iaxjssFT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A54D80F9C; Sun, 30 Mar 2025 11:25:44 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8558A81879
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 11:25:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5e5e22e6ed2so5376301a12.3
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 02:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743326742; x=1743931542; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=za6bX3SycGOE4pbIx//bmrZVItXqMlF89e3WzzTv/68=;
 b=iaxjssFTM+gz7xTRxPDzuiTjSUps8C8ik8VWmG+/wL01MpwNY4uQilrDljiIMVU+Ua
 QEhm/rDHOzNNJvT10/kFrXRjI4GTIbg1Xltx+7Ndob//mLgONoZTtvALlw4WTUkSDrJ4
 /BVfJzt/czDSRIIlzwPDHwTKk1QOsBpUwkA8tS7XBcDyCm9FbBBlzrhGNKCPQQNYpdPi
 ARtUh0ZZwljdLmhrh5y1iLhFbz1jo9MpLKnPkD9H9FaXZB5QSmullORsTxTvaxG+4n4y
 MY+1JInjV8eZzFtczOguPk2s2dAjrppdNmItr6QtbnEbABR8yh8FVxAwcIXK9zvQA/EM
 sxvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743326742; x=1743931542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=za6bX3SycGOE4pbIx//bmrZVItXqMlF89e3WzzTv/68=;
 b=Ry207q9EllNoVfNQOXL0+URuSaZk8jztBvym0XUr/SSLInXpKRZALrBCzgOY7T8j+V
 Ui3//ntzYrxs4LBGnHnEarvciu7mKUNS+N4nxXyeGwhKoqvSXoqzvD1yufrEm/0aIZbD
 KZAD3F8iBX+0S915Pr472/r3xaRcs4n6BiYK2aRyxSwWSdAPAIprEmXinJEU4kD+TmDw
 CZtD65wF9RLW8fchSMbpQaxTBDDr5cGCwO01j3EaBgvJbob75ViJtipcpEDNthk9+96u
 X+3GUVaOkQomvJocfjh26nsFEaO055NlukZt+4cm1r1B2wlDfBwXzWlxtIZVdOCMnL+5
 bB8A==
X-Gm-Message-State: AOJu0YyyFUEQf8+bw6/Hh+XvsNa5nQNX8zDBRKg0aBKGw9V0D4EJhX+g
 AjVfXdFhIj6g8fIhkGu059HMT3q5wo0D6aFBFS5lp70LZhH8hMit
X-Gm-Gg: ASbGncvM0yPy15+ZUwCu1t2Pyn0CNVu/0d8lalQxSHnB+tOR6EXg4/4a1qUpw6Gu9+j
 NIQjCXLUp6kjSLaJeAAcUNmu725vwAoFEiXuWQ+zwzgiV1S98FrtDzSBxKoSNCUY2LJXr5zVdAs
 ejhUCrrxqh3lC6eklukwittEALIr/Y5rfEfUbHqnXAilgWfujOaW+U05dlOUzWA/U0QcluT9A5U
 kacSfDGVbmqwYXE/j0oAP6bN3V1GZGTHtierxqySBEMvae2Rnw5Mq5NL1hUx68YmT6WPjoutCBG
 DwpfUE5udq/VPvV70xkWWPbEcKpE0o2EbdfO
X-Google-Smtp-Source: AGHT+IF0ZY+Niw3rVyuf69SRBbKB5GNwOXUSHYKTYc/mZhfzMozB/Y/sueKvI5csd/5/J73B6LipSw==
X-Received: by 2002:a17:907:97c9:b0:ac3:10e3:7fa5 with SMTP id
 a640c23a62f3a-ac738a2655emr505825466b.21.1743326741799; 
 Sun, 30 Mar 2025 02:25:41 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7196cba8esm452202466b.152.2025.03.30.02.25.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Mar 2025 02:25:41 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/2] ARM: tegra: clock: take in account PLLD/D2 enable bit
 on clock_set_rate
Date: Sun, 30 Mar 2025 12:25:31 +0300
Message-ID: <20250330092532.10187-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250330092532.10187-1-clamor95@gmail.com>
References: <20250330092532.10187-1-clamor95@gmail.com>
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

PLLD and PLLD2 clocks possess a unique enable bit within their
miscellaneous register. Take this into account when using clock_set_rate
function.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/mach-tegra/clock.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-tegra/clock.c b/arch/arm/mach-tegra/clock.c
index a375693481e..4f0cc19df50 100644
--- a/arch/arm/mach-tegra/clock.c
+++ b/arch/arm/mach-tegra/clock.c
@@ -703,6 +703,12 @@ int clock_set_rate(enum clock_id clkid, u32 n, u32 m, u32 p, u32 cpcon)
 	else
 		writel(base_reg, &simple_pll->pll_base);
 
+	/* PLLD and PLLD2 are only clocks which have ENABLE bit */
+	if (clkid == CLOCK_ID_DISPLAY)
+		setbits_le32(&pll->pll_misc, BIT(PLLD_CLKENABLE));
+	if (clkid == CLOCK_ID_DISPLAY2)
+		setbits_le32(&simple_pll->pll_misc, BIT(PLLD_CLKENABLE));
+
 	/*
 	 * Changing clocks was never intended in the U-Boot for Tegra.
 	 * If a clock is changed after clock_init() the parent rate is wrong.
-- 
2.43.0

