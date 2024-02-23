Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D3CC54798
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 17:41:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E45A88791E;
	Fri, 23 Feb 2024 18:41:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YsEpn0vr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FD5A8795D; Fri, 23 Feb 2024 18:41:34 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EA3487653
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 18:41:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33d066f8239so680924f8f.1
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 09:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708710090; x=1709314890; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RaQ4sgxn8yj9Zk6yrhDznr9Lq7Znufh6/YHLt2hqhjU=;
 b=YsEpn0vr+heuwsB5yhHSQ86mtBQRZpwKlyXLEx/ONyUEWPd1UiySiz4UGXqQUE/1w7
 vdKwwHNCc7rfcRGBpcq5ZqGJF0Zl3UvU0ZOuUqfoA9KWt1i+B7lpwKymgq5uSfKKJxm5
 jltjO/MUIc9cRqM3+kAjhBCgiIXJWbh6tZO2to6pmuzc0u2/qYK+K4bUyB+AaeDHmtH3
 HMlfQwuVPgx8zFJ58Ql1MVcRZZlyizua+ugu3JN9QYjVkvTCHvLdzWLV85TPp79uOgl2
 /pPLhLtIA837Iw63dulksx29WWHlFCE9XKAuiN76B32Sljkw6nj9A55A9D+aLqg3i7Zz
 rrKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708710090; x=1709314890;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RaQ4sgxn8yj9Zk6yrhDznr9Lq7Znufh6/YHLt2hqhjU=;
 b=Ceu19OUxNgahD2yRy0JNReLk3nPCNp1CMObvM4572J0CCwU/CNq6eqhUKEeyyuDN4u
 K6Iz8WtGGSq2HYdO7ilFpxVIAyGCbPjhpypA469mFwjpdXUdoMxTuUjbvt13HdSoO1f9
 VchWYN4kFLVpdf45iRdvEqHJ0RVqqJrbgZowHerjcqSKZOI1THOhCOMgmvPBiDxzPm3P
 Z2kMyLTuaGhTgcqP3qKozTKE4bCF8BnhJbIC4ELYStl7k+KIp5kS0BVVHpm+ASraHahQ
 BA28hymmaeQKtKnR8TVUesHqwIKEm/sv0/E+L0rHmcjTh7w/rxWYmrX10ogPvRvCHCZP
 8fIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhpwTAGq39BF4MrdQj8ViGJTHF8bg1ysWIOkMlR6UP10PZSh0SyQ4YsCN8GpAVZUzsNmi4nNg3l3Zf2+fd/Gf5CM5hCw==
X-Gm-Message-State: AOJu0Yy4QwXa0ueK00JlkW6KU8mc9ttGBVgYAIovSmQZO3XNOkHvev9/
 hZAWB4OSbApGeija9hll3aDU7WcjjwVBY/U1gzT3GCeDmKZwuSgxBvWteqkt+xQ=
X-Google-Smtp-Source: AGHT+IGe2UARjfOrnupZh46SQeaz08dl65OQw42ThcACfTENK172+AZxyg1xR7pK3aDPdYzd22OTDA==
X-Received: by 2002:adf:ce83:0:b0:33d:27cf:6208 with SMTP id
 r3-20020adfce83000000b0033d27cf6208mr368779wrn.7.1708710090299; 
 Fri, 23 Feb 2024 09:41:30 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 m3-20020a5d64a3000000b0033b6e26f0f9sm3649827wrp.42.2024.02.23.09.41.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 09:41:29 -0800 (PST)
From: neil.armstrong@linaro.org
To: trini@konsulko.com
Cc: Neil Armstrong <neil.armstrong@linaro.org>, u-boot-amlogic@groups.io,
 u-boot@lists.denx.de
Subject: [PULL] Please pull u-boot-amlogic-fixes-20240223
Date: Fri, 23 Feb 2024 18:41:24 +0100
Message-Id: <20240223174124.866683-1-neil.armstrong@linaro.org>
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

From: Neil Armstrong <neil.armstrong@linaro.org>

Please pull this simple config fixes for the Khadas VIM3 Android
setup to fix an Out Of Memory error for AVB.

Thanks,
Neil

The following changes since commit 5e4a0c7f4a2c9d4670b75a6a2056243b1a56512b:

  Merge branch 'qcom-fixes-2024.04' of https://gitlab.denx.de/u-boot/custodians/u-boot-snapdragon (2024-02-22 11:34:59 -0500)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-fixes-20240223

for you to fetch changes up to fc0a7431e1729f456690468f2e9570fcc2c18175:

  configs: khadas-vim3*_android: fix AVB oom error (2024-02-23 18:22:50 +0100)

----------------------------------------------------------------
- fix AVB oom error for Khadas VIM3 Android configs

----------------------------------------------------------------
Mattijs Korpershoek (1):
      configs: khadas-vim3*_android: fix AVB oom error

 configs/khadas-vim3_android_ab_defconfig  | 1 +
 configs/khadas-vim3_android_defconfig     | 1 +
 configs/khadas-vim3l_android_ab_defconfig | 1 +
 configs/khadas-vim3l_android_defconfig    | 1 +
 4 files changed, 4 insertions(+)
