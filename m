Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA05C61DB2
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 19:08:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2CBC82B18;
	Tue, 10 Jun 2025 21:08:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mfqkMYL6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8F2C82B63; Tue, 10 Jun 2025 21:08:27 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9F2B82B07
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 21:08:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christianshewitt@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-451dbe494d6so71084025e9.1
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 12:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749582505; x=1750187305; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lHs6aq9H8IKH4NH9IiXI5Deww8+c/JuvGFynGOTeOWg=;
 b=mfqkMYL6mMZRLxKenLLSjIhJZc0KADZiTvi83aeLm77nk2tS3q/X+xzzVQuqbA6b65
 /mhlnLkAFnvCBtDA7s50vRaql8/ecopIWGQPGR7tzL3wehV7OdZspBGN3jdHNiKSGVF6
 gMIO+ecGpGg6Q6x28L5Vqlkpbz02Xgb3ScuVPgdQGLMetJcHlgTAqd7c5SGvq8WWzJT9
 3MffU7sR1djGb1RPaEh+MzuN57eCBf4PFYZrCLncsIaFWFloy8MCpMabpRJk5izQhrU/
 wWwGKWKGKOOtHSnu2fiN5Ev19NbMWjlBKvXF3K730DVox4n/yL1DiLJjV0e+DbWrtLCr
 lAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749582505; x=1750187305;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lHs6aq9H8IKH4NH9IiXI5Deww8+c/JuvGFynGOTeOWg=;
 b=tFJgobmQvJxKogvJtG3QWKTYnTvpswswmYqXdVZ+eYVHvWFH8iVYsdrRh26XiqXUOk
 pnyYy0FyCnYReZkTMad07ZhyjA1xTqs8zcB4MaEfYu55roPrxr1dM1y+WA1A/U8tx3Ob
 OEJp8jFuQXCvR0DQGwOJLQHECmbWNgcYzBSBCRdTqjWiypMFw4Qwp/5uBkcDsG16yrHL
 oCFyhHWPiokCdpr6FSdft7sTh+BydedU64MrWkPADZCdT08fFu9YeqpbDrGqEyP3OGtf
 JgBQST+nEmcts0hOp6gzve3omPa5YSeflzonZIC6zPZQ3rNLX498fO/TYnNjD9a0rGl1
 Gb/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUY1L+YgK5ByjUUllamhCpONFKM0CPKo0at3XT1F9IjjgUnP6Rc+bN7/9T+ZYeh/Szm6ikj/UU=@lists.denx.de
X-Gm-Message-State: AOJu0YxnV03vlND8j+hwQOHtnq00GZbowhnImtN1fOuTEcvtDLH4Y3eQ
 cI1NuQ3QdV0n8Kdekj6kT4PIitF3lSpJ9E5w7PhGaa2xwcYhPYYYjRpg
X-Gm-Gg: ASbGncvVDhI5Hnuyiz+fOrSvWWUs0/Jl+R3/mbdYYQw5Qd6IK/+fJUnCLwrTrJ3ICPY
 qmMWcRObG6fhYRUmdkqbg3RKu6ATZqYCHO6KhiZKOdWKK/04uwkh/HX/vdWsC3TXvsJ8tAEwo3X
 2TDrbPZDaoIktziymsHCpYV1A5luvwmAuLpwDvUnIauGx8F8GK5JaO32kdBQNVwsN0MLizjNPsn
 21mrBiqfBfOOBUhIJ17jORqBOIAqPENlYrjEJ/dhe1uHORsYFnuRAYyjr1/ScAtGRVX7q5GZGJ4
 KgZOkuMhGVUPQmIq5sJGhPDdPbxa9wgX
X-Google-Smtp-Source: AGHT+IFa836uzN7TAhVdWY6BsDpbOj0oWi+R/OUQ5LFcgHjmGyU/Nfhf0jKvlo1OyU1iBDpI+B1nbw==
X-Received: by 2002:a05:600c:5394:b0:43c:f895:cb4e with SMTP id
 5b1f17b1804b1-453248c7df2mr2774605e9.17.1749582504756; 
 Tue, 10 Jun 2025 12:08:24 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a5323c0819sm12821487f8f.45.2025.06.10.12.08.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 12:08:24 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
X-Google-Original-From: Christian Hewitt <christianshewitt@gmail.com
To: Loic Devulder <ldevulder@suse.com>, Chen-Yu Tsai <wens@csie.org>,
 Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Da Xue <da@libre.computer>, u-boot@lists.denx.de
Cc: Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 0/2] arm64: dts: rockchip: roc-3328-cc use 1600 ddr4
Date: Tue, 10 Jun 2025 19:08:18 +0000
Message-Id: <20250610190820.1462097-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Christian Hewitt <christianshewitt@gmail.com>

This series adds the DDR4 1600 sdram timings for RK3328
and then configures the ROC-3328-CC board to use them
to give a healthy performance boost.

The patches from LibreComputer sources have been tested
with v1.0 and v1.3 boards [0] with positive results.

[0] https://github.com/LibreELEC/LibreELEC.tv/pull/9590#issuecomment-2571670366

Da Xue (2):
  ram: rk3328: add ddr4-1600 sdram timing
  arm64: dts: rockchip: roc-3328-cc: use 1600 ddr4 timing

 arch/arm/dts/rk3328-roc-cc-u-boot.dtsi   |   2 +-
 arch/arm/dts/rk3328-sdram-ddr4-1600.dtsi | 226 +++++++++++++++++++++++
 2 files changed, 227 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/rk3328-sdram-ddr4-1600.dtsi

-- 
2.34.1

