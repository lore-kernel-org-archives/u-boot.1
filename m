Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B508C35FF1
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 16:02:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9808381E3E;
	Fri, 14 Mar 2025 17:02:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SFfgonzd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7C2681E14; Fri, 14 Mar 2025 17:02:37 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD68381D25
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 17:02:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ac25313ea37so451231866b.1
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 09:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741968155; x=1742572955; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HrE8PSb2jzHJTWpmUQi6APtQ3CBAqq/i1miVwoKw8Xc=;
 b=SFfgonzdgSGMa8YY1kUd0Q4FIR/GGrn290PbuXClhnFWvdJWicRfXZfA8mhcwTQm12
 sMgwiMlrKXFXl8PYPkf8BBrS2Le1FeCpcSU3qOCaywOPAvQ7avzdtiSBwCGNDKw4iVWz
 YkwmWtLnrGjm3zG1ULcx44W5XSiYhZs2DbHgwgLS6R+jXnhsJuQ5SulSFz7MfmyA+dUp
 QvBON4zJ/70L591aRjinXO4jA0mhQjj5lhixTsI+grVVCr52QZ+SQgXMnhhlIS9yBp1h
 9cKDm2KZa1FWbFUq9ldnzPZbq37OD+aP3xJK3Sd4iMdRJwI0hleOvcOLj6mNJ/QZOlTP
 pllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741968155; x=1742572955;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HrE8PSb2jzHJTWpmUQi6APtQ3CBAqq/i1miVwoKw8Xc=;
 b=wI/ClDLZ6ZHFVMCJTF1AsWGHLz+8pMbpPf8+D79ZpY9VF9NnTiqez7Wn594XvvrK6+
 kt99p4VyTcYDrrbWsqXFKPXVHO0+XfHW0OBH8rVSLfpJG6ENXp6+MnDpFKtREJKhagUr
 fxCWbFC4BcvIZumMK+lFNf/Vk5E6/ONwatroRZAqDs9DqqiWefsQK+pRmGek7gZ1E3/F
 o/wZCCRWO4TY7Ghsgx/s/iEy52vqj+htkkUSQzerqMbAMKYxvM8IaZ63058+Z4NuZ5sx
 bF/bUJ9wcrCIBSMMDIRB2SaAfDXE1s3VFC7Rj9x9ZG3azeZgbyh1vH0mFp1Fp4p5Qy7A
 iYbA==
X-Gm-Message-State: AOJu0Yx8tZ+RnsC9x4nKgRSQz5cS+VfgIsEzUhjCsqcVwObH6GgSjH4X
 Zt+iREDFWiAitzjLoHXt+1rme7bdJgzt8s/2pxA1XXEYbTFdrjqI
X-Gm-Gg: ASbGncvsOGbRyb8K8v0tblt2Qm/KLR31X9+8Uf8M6eLxuThAKQLkujImaxDraPNdvM3
 DAJ8ZEgIjkiSHlvvMkR0vY876e63Y/TrcV3oL0QhO3kXU4EvhIfT+XK70Jr/WyYvbPzczxNipsm
 pZr8ul/3ZxJzPh0AgxTdHZJ9OEUA+FsMPKHzAs22lNq8QZCNVz44SZ0eTm/cgdLOIlAOD9iBpU3
 O4N7sPYce95QTrVkLHtMidll9Urv570Jj9rJPnybbzFq+SzY8YxuroO/pCP0Mxe2LRIjBhCvwTv
 IvYqCdEyLzakdLQuL3qa5pXn6j9F3U9acUpC
X-Google-Smtp-Source: AGHT+IFQfPG+edAowylynvfau8WQY7CfN7/tWTD+JyT6LYFOmui3T160H+zi0FNSU6yQpfuLZXozIw==
X-Received: by 2002:a17:906:360e:b0:ac3:3fe7:b254 with SMTP id
 a640c23a62f3a-ac33fe7b511mr133577266b.4.1741968154820; 
 Fri, 14 Mar 2025 09:02:34 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac314a47fdcsm242953066b.146.2025.03.14.09.02.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 09:02:34 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/4] ARM: tegra: update bindings to fit video changes
Date: Fri, 14 Mar 2025 18:02:12 +0200
Message-ID: <20250314160216.36327-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Update bindings for special cases of video subsystem users. All other
devices should work with updated video drivers as is.

Svyatoslav Ryhel (4):
  ARM: tegra: lg_x3: upgrade bindings
  ARM: tegra: endeavoru: upgrade bindings
  ARM: tegra: p1801-t: enable HDMI
  ARM: tegra: tf700t: upgrade bindings

 arch/arm/dts/tegra30-asus-p1801-t.dts  | 12 +---
 arch/arm/dts/tegra30-asus-tf700t.dts   | 96 ++++++++++++++++++--------
 arch/arm/dts/tegra30-htc-endeavoru.dts | 17 ++---
 arch/arm/dts/tegra30-lg-p880.dts       | 34 ++++++---
 arch/arm/dts/tegra30-lg-p895.dts       | 55 +++++++--------
 arch/arm/dts/tegra30-lg-x3.dtsi        | 82 ++++++++++++++++++++--
 configs/endeavoru_defconfig            |  1 +
 configs/transformer_t30_defconfig      |  2 +
 configs/x3_t30_defconfig               |  1 +
 9 files changed, 204 insertions(+), 96 deletions(-)

-- 
2.43.0

