Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77068C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 09:54:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 136EA82D06;
	Mon,  7 Apr 2025 11:54:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SeFKwiU0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EA9382D6C; Mon,  7 Apr 2025 11:54:40 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F68282CF8
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 11:54:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ac6e8cf9132so450077266b.2
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 02:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744019678; x=1744624478; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=C3n2PuuWnWOD/L1fJQM7pnU396SH5A/zTXL8NXUqE74=;
 b=SeFKwiU0Fg/BfKva9MMnFxEHB8DAaDUt2hFvzBmd/vAJJFRQvksIp6T6mCTIPuZLRW
 2QuGkxmtilHrmLlzSELeNeHpnLQauOme0Lm9/pMHLIGnKYw/V/FBnSccHRxp0kUPLyat
 SAo7EEabTtVYrMMcZfZAdVZWqWbrFmBiD3WFpBTUO1qPQAJVpFbqwmdkLU2JvhFj78vO
 Oh7xK9iz7gZZIvvAujlQ0Rqbxo4OuMWrO3y+bn3S+yCfCe+roFwasBnXRSY6Wo/TsMqc
 jBMOMjuyxdp/5cHBdMkr/IdFZpikyrCCozFUvAR//ijxURCuASYdMOS+R8YP2gIbpYPN
 JcKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744019678; x=1744624478;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C3n2PuuWnWOD/L1fJQM7pnU396SH5A/zTXL8NXUqE74=;
 b=OD17M/7LHi4NvGnfD5aKnIEmaRjc/Ahi82BNfIaQaHx0fuOn7I3Xm4Iu5Rvdui33qh
 +M8WLpM09F57kvfHzNFn6UlDF3c4wznl+2sCq0U1hcEoZOJAknJsQzqLCAMJ7ggwoLRc
 h+Gt2WLhSiehg4Pv++sZ8vgKj5G6WyuEzy1BDMqMQcYgTNDn3JaEt04dCPIrRNxIO+Uw
 T1wuXv60N/OXB+AliDwuQyeaEdCd6jPU1C5Vui4PSVG9rlGq3fArC3xV5gWHSOryiksG
 Wh7+ZCI2YGBo9Fg8wej89p8eP0I6w9MJY+elMe5XSKPF8Ou16yz4VaPm4b9q5zIT1uIn
 eelw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVM4p/9QgK1t0Kapt2rsRjSNTWcerAnePP5HYtk02XWvV8JtUEdWmP2LWgrUbMYDRXHC42XXNs=@lists.denx.de
X-Gm-Message-State: AOJu0Yw2h2npgv8claEgjJm6/XS5TS6wCmGslg1KZ7DV1/6oCBqhevJe
 kJ4thwjek1W7wslgx4AjkaFSnEHA92fASPLY9vAAcmUqKiv9AAzPtG9rNVG7ReA=
X-Gm-Gg: ASbGnct+KfPAh12oqzoRbVwFAy1tvDeyV7JlaK5jxSdfDvWKUVhzfEFNc8j1bjQWJ4b
 XPSdZumkZ2GkCwIRFkneyDTbhWNd/bzbDfT2yZXUicfzriEYPRXgJ2N8Dw1iR1rfD9CLKYaUf7e
 7fk2r21LKGDig5qh5jK+xEHx58DNl1u/DjKW15/pWB/Fnupt7CBlAay3mG6BK+YWveI4Qq7kRO1
 7o0yrljiMVAmXtL0u40AnTpf0fd6gSoBqcs1IOHx8tJem/v7Dx4XP3HX/ULTLRUcHMGGzA/BGGP
 5lxKgYQISa760Z+w88UWzekRQBsi7bdsbv/ohk5fgbLcG+2OLTj6IXO4yPLN0Ngycv11
X-Google-Smtp-Source: AGHT+IHJgtNbCdSAhSio4tP3RS4dkPnM8cOtOikQTin6eWSbYMUiMz1ArI55a0+XESMiIC3aM/EyTA==
X-Received: by 2002:a17:906:d204:b0:ac3:cabc:1be7 with SMTP id
 a640c23a62f3a-ac7d1c3945emr917250866b.48.1744019677885; 
 Mon, 07 Apr 2025 02:54:37 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:7d3f:b102:5311:c65b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7c013f6b5sm735733766b.109.2025.04.07.02.54.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 02:54:37 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Subject: [PATCH 0/6] usb: host: ehci-msm: Clean up and fix crashes
Date: Mon, 07 Apr 2025 11:54:20 +0200
Message-Id: <20250407-ehci-msm-fixes-v1-0-f8b30eb05d07@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMyg82cC/x3LSwqAMAxF0a2UjA2YgghuRRxU+9QM/NCACKV7t
 zg8XG4mQ1IYDS5TwqOm11khjaNlD+cG1lhNvvVdK14Y+6J82MGrvjCeBVH6IAgIVKc74Q/1Gad
 SPtET7B5gAAAA
X-Change-ID: 20250121-ehci-msm-fixes-b1ed17a1eaea
To: Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>
Cc: Sumit Garg <sumit.garg@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Jianfeng Zhu <JianfengA.Zhu@sony.com>, Jacky Cao <Jacky.Cao@sony.com>, 
 Sam Day <me@samcday.com>, u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14.2
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

The ehci-msm driver has several subtle issues and stale code. Most of them
are minor and do not cause issues during normal usage. The last patch is
the most critical, it fixes a reported crash when stopping/re-configuring
USB, which has been around for a few months now.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
Stephan Gerhold (6):
      usb: host: ehci-msm: Fix pointer check
      usb: host: echi-msm: Drop ulpi definitions
      usb: host: ehci-msm: Disable clocks after all register accesses
      usb: host: ehci-msm: Use clk bulk helpers
      usb: host: ehci-msm: Drop redundant EHCI register writes
      usb: host: ehci-msm: Register ULPI PHY through NOP wrapper

 drivers/usb/host/ehci-msm.c | 146 ++++++++++++++++++++------------------------
 1 file changed, 67 insertions(+), 79 deletions(-)
---
base-commit: 0efe8ea57fc7a1a6fc5f64fb3cf6bc4a1a4fc219
change-id: 20250121-ehci-msm-fixes-b1ed17a1eaea

Best regards,
-- 
Stephan Gerhold <stephan.gerhold@linaro.org>

