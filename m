Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B26C77B7C
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 13:49:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8464C82B18;
	Wed,  2 Jul 2025 15:49:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QV0deSgX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B61FE81FEE; Wed,  2 Jul 2025 15:49:55 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D543C800D7
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 15:49:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-60c4521ae2cso12192356a12.0
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 06:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751464193; x=1752068993; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NAF9tDes6TjxZ120MaH+ZCXk+77MZ2vkwhtiulYFIuk=;
 b=QV0deSgXHGjMrUI4+HsYPRSOU+XT7BySzKbBspYKFRsmZbJuGX5Ip0Dkwz3yYJE9Lp
 7v4pp7ZtPbrbTHAHFzn3IBYht9pfSYrW3mQ5iCgNJ+ss1Kx7AFTMYIRyhYMStHJCwRFt
 M6M5H8mxEZEwgrrpKpn+pIri730k1fC7CyG8KKnWFOs/xtPs1yM/J6LXfhyinkTjayH7
 gFPeL0zT7CszJc3dvo8S1AWLwKvrU1SkVZ4tpaZl1JCJsiDXtmNAu4tR1dEWkhRzrVqo
 czNFioDtkqyqEnXgb+Cj4tBVIrc8db0+tSJweoYz42aQsVsZF9+i9mQEjheZgbjGJ7SE
 NLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751464193; x=1752068993;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NAF9tDes6TjxZ120MaH+ZCXk+77MZ2vkwhtiulYFIuk=;
 b=ITP4fmX0oEuWiBWPKphNWAnPACgkGHNLNQqvlOfyx6au1xsTlOfrvLeS0W6q6u+UE0
 hXdtrAzPtsnWLTWDepRVfIp731QLuwLwhoJ6mMqC5jzkdjuR0vy/ieRC2Jzer/dxHNz3
 uaN7adjLxZ3g+FJ28ewIcNbwaMT4eOfgFmzpqTZpP+fbpZy5hzQUPESaWAKBfH2amsef
 ym1Zq9/HWJqaFrGDP2AdohW2/ILFQ9QePAohSLYuLJ06l6QkoYyyYvcwkQngQI8242OT
 ST5+CBsMRW39DrHhlxlICDdAbqiQxrKAqOq+Z1j4y+kJxmHjvDQdev0N0pjYClg+orNa
 j90w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1hh8y0alV5TzoK9rw46IOtNL7mxKwWIxHkPteTHEKiadRvF6JNBYUjJMrZAuQt7SVECEEqsw=@lists.denx.de
X-Gm-Message-State: AOJu0YzH/rgu9I5WUOwFcgG+NSiBGm+NXve+qeEUepdhP4tzvI0M9Y/D
 iYVXnrugw0SSvbA5T/PLD4bUU9MVDEJTR0bDtNS1VeKGFlWsfeCsj3r1
X-Gm-Gg: ASbGncu1atL6M5L8CqIJFwib31BVTd503Bfd4SDe6FfK/sGBb6lZpZZSoQ9FZ3xVp3U
 32rgX+kqjPdi5MmzpD+HF/Eezos30n6U4eOM4jhr7veTkJyVOzBeJkaTPMzk1a6J5Rkc2my2gfg
 iUHZ6Tp34jNb3lvDzo4L1L2lC/dsjvyCT4igYZcHj9PZur9M8j4cRYuYi5yjC8gGHjszl6sTg6/
 N+jBRyf+4oc1YFUyJELPj23Wr7PV4rssMuQ3xqdNAPkPg1XPSKh0TDsnml9+E4gS720qN6nBMfY
 5EJI3vYnrCTZGtRnSeIH8zT3lrxkKXeX4bTejKXBTVnv1H9jey5LCBk9hKBZKjkPR2bPNYRSvsW
 COKJBoalD
X-Google-Smtp-Source: AGHT+IFGBDB8qEkLQnCEqfJ2vbcjpZ7MsB1zIjuJ/TStIMQSUkJ71w4mF0/ptzYW+yefddLDx2Nycw==
X-Received: by 2002:a17:907:bd8a:b0:ad8:9844:1424 with SMTP id
 a640c23a62f3a-ae3c2e1aa56mr270350966b.61.1751464192934; 
 Wed, 02 Jul 2025 06:49:52 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:aac:705d:1f00:7f2f:5fbe:4831])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae353c01bd1sm1101810666b.92.2025.07.02.06.49.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 06:49:51 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1 0/2] Enable RNG support for KASLR on Toradex arm64 TI SoMs
Date: Wed,  2 Jul 2025 15:49:35 +0200
Message-ID: <20250702134942.1483436-1-ghidoliemanuele@gmail.com>
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

This patch series enables RNG support to automatically populate /chosen/kaslr-seed on the following Toradex arm64 TI System on Modules:
- Verdin AM62
- Verdin AM62P

This improves kernel security by supporting Kernel Address Space Layout Randomization (KASLR) using a runtime-provided seed.

Emanuele Ghidoli (2):
  configs: verdin-am62: enable RNG support for KASLR
  configs: verdin-am62p: enable RNG support for KASLR

 configs/verdin-am62_a53_defconfig  | 4 ++++
 configs/verdin-am62p_a53_defconfig | 4 ++++
 2 files changed, 8 insertions(+)

-- 
2.43.0

