Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8A4C04FFE
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 07:03:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B3E988273;
	Tue, 14 May 2024 09:03:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WGzpUWdG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8192388279; Tue, 14 May 2024 09:03:55 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EFAE87128
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 09:03:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4200ee47de7so19746595e9.2
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 00:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715670231; x=1716275031; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TjSbvefoBvBC+u5oIgvuM0pJ4VO+3usxYhuPEM/dQQg=;
 b=WGzpUWdG9aFWgfqWjojIv86vkh9mWHqTr5KYMAwrtBy+g8vvArEMii0tjEicvgBNuz
 GRrilMDz48k5zdvuKijC6ZXNnJ+wDVpd/GS01pOSxjIkMKC/kzyY5SuxCrSzue1X+6h4
 gMkrsqzZjf0DZkq2rHJH3vVc/vpYcOZAa5Oy7Ln1rU8uB+NtK4aBtLBatbFM3N0ao31I
 4PsBbJcge5RnD7Zhx8TCB+U2/nWta/Hz2j6L/anCN8aL51rfHpKzG2WIgpGks09Rat+m
 0KFKy6o451t5y2jQvk2cpwnM46JdXJITkPyeoOm37BWWPBwVEkzskeUf2uvZeUt/zePR
 IUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715670231; x=1716275031;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TjSbvefoBvBC+u5oIgvuM0pJ4VO+3usxYhuPEM/dQQg=;
 b=Idhep3gkbYZirr90T6/EMw9ySZ0EUPuGxobOG6zvN7aoDnXWWWJwaZLx46q0oHZgsT
 EGUxUkGVoLOwxDsxjAjyhoEuhE8HzoruJUnNGdUBz3rps5iw47Ooy0bskasY+rvxWfii
 dYXn8VHNGsHQg+eMv/a45jUU4THYbRMXBZyx5xPf+pKAcsYTUitpgZneiCpK7r8vLn8v
 fzIE6XhYMD4iYQeC1jPV2faVc5JBBNBtlj2SmynWNuwl1ZVGm7mSBIi39uaILxt0VxV4
 rn4vDxJ7vbmMZ7Dg4Yd36kWq+vvbjzHjfAfUWaBs60/ObADR+ze3C2gcjQm4EECn84jv
 Xx4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuxoy/uuY8/TmsQ48+P2p+CRRv81gS/CGGn85Q73Ar3VBxEUF5iM5IfoT3EfUYf3EGYndAC60F4iGrET25l7SA7fywpQ==
X-Gm-Message-State: AOJu0YzXZZFafjv9bJ83RAV/mfwPS57n26g6LQbyTqls0SpPHx+2wvtB
 4t2sDk4C4IA0R5t9Qzs/bUKL3cUZjG2igZA+VxJKTTBxSZgJ5XU67/QuA6iMto0=
X-Google-Smtp-Source: AGHT+IEtoCCa8tn5vIlu54n7WRbap9DOLtkAP+LuB6EY0ayu8o5pPOQiGVPyilLHkxlcFngiT0EzeQ==
X-Received: by 2002:a5d:4248:0:b0:34c:bf58:abde with SMTP id
 ffacd0b85a97d-3504a632f8fmr7980944f8f.27.1715670231199; 
 Tue, 14 May 2024 00:03:51 -0700 (PDT)
Received: from cymric.caleb.rex.connolly.tech ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502b895731sm12935440f8f.42.2024.05.14.00.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 May 2024 00:03:50 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Sam Day <me@samcday.com>,
 Sumit Garg <sumit.garg@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PULL] Please pull qcom/qcom-main
Date: Tue, 14 May 2024 09:01:24 +0200
Message-ID: <20240514070339.3372871-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.45.0
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

Hi Tom,

This patch for master fixes framebuffer video on almost all Qualcomm platforms
where the framebuffer is initialised by the first stage bootloader.

The following changes since commit 5c5565cfec92eb7377ff7fe197612c6a813bb6c7:

  Merge patch series "arm: davinci: Migrate da850-evm to OF_UPSTREAM" (2024-05-07 11:59:26 -0600)

are available in the Git repository at:

  git@source.denx.de:u-boot/custodians/u-boot-snapdragon.git qcom-main

for you to fetch changes up to 3ceaa825869bd43e9a2ec00a90589cc84885bd40:

  mach-snapdragon: do carveouts for qcs404 only (2024-05-14 09:00:41 +0200)

----------------------------------------------------------------
Sam Day (1):
      mach-snapdragon: do carveouts for qcs404 only

 arch/arm/mach-snapdragon/board.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)
