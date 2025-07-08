Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D44C83F09
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 16:51:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3374283390;
	Tue,  8 Jul 2025 18:51:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mZ5cABwM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FD25833C0; Tue,  8 Jul 2025 18:51:20 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F31BE832F0
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 18:51:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a548a73ff2so4386145f8f.0
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 09:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751993477; x=1752598277; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Qb4VuBxSBrzOutViOJzoMJgmhOrAPB64Gcv9ogJutrA=;
 b=mZ5cABwMWoq2KgNFRa949EEdZ+Ylxjv8TfHm8Zj05cEJ/pSwbDW9ZhhMtXBZVvsLRD
 68TUOCe2FsBRiTE2g3rVYTBRuEYEtAf6U42S3QPJ5xYJ915MKFDG0nyLHrgEQIv90GFn
 K+oIb1vGt0/VM1Tt0BEzrh+NObpajj758IoLckuslwdQTVmH8OJuCn8Cj4keIsCGSp0p
 Xk/cMIIca1SATKrIT6JKM2vETHVD351ZOrNPn88/blAUPdOhDO8Na+AqKOWGGH1IiyXy
 wwhNauPOOEYpQMPWTfMF6godj+W/hN3vU/Y41MRJHLGuNo1hEN4BHBXsRsZG/W4sGbmA
 8www==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751993477; x=1752598277;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qb4VuBxSBrzOutViOJzoMJgmhOrAPB64Gcv9ogJutrA=;
 b=hclZ+Nfpwm2+T2IwsP1jjNZ5DxzCYPFbZYDZv+jHocctuNmTfx0ckDTR549gKIpSU3
 YcHwJllVbxnuHNm8LznBQN0mgKs+JP+lgM5qumjB3YiFWdMXOz0sqrvrdmMUA2CvSwv7
 JYyBJ9TJIalOEe+WiXWSYoz+eQpVqizyEZr/gmNah2Q5zVV75KT3KGsMkFjsSqgEMldK
 jimkEjNoyrUXS5MJ8tSQoud067NybIQJuDhFjSvflL3hEEsbPTsC8VBpUSfXK9ZJxO5y
 bAG888OGmjwW/iEVL/WdOJw9QGb7ozQvis/wC4qIsquUW8JoBxWpYO5fmDh5KVS8HUfJ
 bZtg==
X-Gm-Message-State: AOJu0YznvqAn3oicW9ex/TS4IxqvT1/i90ebwMP+VhxJ4GkkDMZBVgHu
 Y4uG86HElmxxakaDwLZSqirNZu9LPkE5u6JwEHQeHSsw/1K1g0f8KnLBOkpZIH7hFTk=
X-Gm-Gg: ASbGncslvXhnKQtHKKYGRlNwQr5c0RlwCRzNjhEEiqCnSKfODNqqr7lur43GiyuECvj
 Rnp/mcyz6lmkUiKWKuzGbzbo2z4kARoJiZPuwx6JFGmnMKBiisO6/Nj3EP4N66eht/dfut1AGCK
 woQ7uKySP5IrjXlM3jMCjaTKgMaI4318iaLI0bXk/hEO6glQrWOIHslSrp1Is4tmVZhe9juubre
 n+T2fuYneX8uN3ZAcLbuGu5sh1h2c006BQKgXdYWNnseTT0dQAa/Zfkup9wjTdoyckjRXg9n4+7
 72yLCLm7/7uVNJ7dn5WTn6o91h/Dd0T2MJB5HeCNM8xp1+3uL2MHSwXPaerHHQ7XUwvR2+cdcbk
 x6ndXUa2PVRGcsaPj0ZZI464=
X-Google-Smtp-Source: AGHT+IHdqG5EWWgeok1cZsY9exqswhiOZhtSLaSVJJUMdkhEYyXniPmoyWgGKnA4hcB2JNeVy+hyqw==
X-Received: by 2002:a05:6000:151:b0:3a5:1222:ac64 with SMTP id
 ffacd0b85a97d-3b5e32020e3mr121191f8f.38.1751993477359; 
 Tue, 08 Jul 2025 09:51:17 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:e07:801:a08:6480:3e01:6cde])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47030ba29sm13232481f8f.2.2025.07.08.09.51.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 09:51:16 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH 0/3] net: Address some issues reported by Smatch
Date: Tue, 08 Jul 2025 17:51:15 +0100
Message-Id: <20250708-net_fix-v1-0-292b9aa20f31@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAINMbWgC/x3NQQqEMAyF4atI1haqM7XiVUSGWKNmYZVERBDvP
 tXlz/vgXaAkTApNdoHQwcprTFHkGYQZ40SGh9RQ2tJZb2sTaf+NfBpff0eHofp4V0HSPSqZXjC
 G+fEL6k7yDJtQ8u9F2933H8D80ntyAAAA
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>
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

Smatch reported some issues including a macro that was missing outer
parens, a comparison of an 8bit type against a 32bit define and a
comparison that was always true due to being an unsigned type.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Andrew Goodbody (3):
      net: Add parens to macro PSEUDO_HDR_SIZE
      net: Incorrect NOP macro used for test
      net: wget: Fix comparison of unsigned variable

 include/net/tcp.h | 2 +-
 net/tcp.c         | 2 +-
 net/wget.c        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
---
base-commit: d1d53c252a4a746db5ebcdf0d6de3aa0feec504e
change-id: 20250708-net_fix-784f5ac63756

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

