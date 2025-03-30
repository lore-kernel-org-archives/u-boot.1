Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7405EC28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 09:25:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E11798129B;
	Sun, 30 Mar 2025 11:25:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jx4cCiRD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8393081E18; Sun, 30 Mar 2025 11:25:43 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D12880F9C
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 11:25:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ac2dfdf3c38so641871566b.3
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 02:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743326741; x=1743931541; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=t66+wvmhKKUORCcbyNGh3ooQgVmnxS/oKpB6+6ftKs8=;
 b=Jx4cCiRDvv6luukhTXU/mAG8OVhrpRtqO69b8xYVtzSFrGWGv1KjAPs3ji+GHcgwdy
 gMX79RWZHnBTNNAbU0ibQLqNXVIm9PEqx20X204nCsEVsYblC6eH9vVCaC4Fjm6Im9BA
 wE7knmg6UdEoqUHwdggVhE7iuZPI9clBsOtKDuNKvs/U1IXSgV9HA9gKcDLtNkCCZfuW
 k/M7t55RWKKAtyTrRQE48NV/2piEoLJYxPszUJZGtej8vMXQyH6qSx/BYLjcPPA+070c
 VU6fUx58Fc00D9T1EQq7vyd2itgzirUDcCQ3u8e/uUeKHobrK1E+0T3dHWzsUqQAjbuf
 BQhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743326741; x=1743931541;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t66+wvmhKKUORCcbyNGh3ooQgVmnxS/oKpB6+6ftKs8=;
 b=ZR2YQgmeRzFMU4wmBNsg6QdfclD0vsvBc0w1I66mk/mCVeweieuO0txDF7/Q2tOz0C
 w6bppBLEbu3+YEIBFNlFXjA5uIQNxqtYcDH0vxSTdPBVW3rG7AVONkgxfRevnbt1jF6E
 mSaYaNPvBXaRkorMHFh4fLXtTxR+08Oo6Pit1jACUL46PKpt/kAEs86Cy9tb4lcjYG9B
 mU1FvOfK10KcTY+HAyeRUUS37/AYby7sINmn9RMIHYWFpq2f4JtWW5K72my6IUIXutew
 w+FoG6XyBalssdkYUsaU8+jGgOXQD0bWSF/PN9z8FxLpcMCLoUcdVMZ84WBnFvvNNKDn
 uaDQ==
X-Gm-Message-State: AOJu0YwGzre3fvaB5PCjm6bvHnFZMyNnNrkA4HEsMcRMQpo0hPh7bUVx
 9oBOgvrJhzYwo1xE3RMvUxR80BRUkCYafNYacXnpMSF1IeMUItz/YUoh+w==
X-Gm-Gg: ASbGncspWEveELv847CYJeXPDGkbxEIY1Y5yT5MQNJ5mXWGSAzuiqVfmooW9KDMKuKJ
 vtLhqaPNjhaxBSEzWFe+014IzCEhHyM+HAsn4RLq5NZHwGk2uidD7dnhYIe+O/yQ9qyTeNKE/9U
 7tmf/K3LSOaHrAGCQaJ5m+KYgRVYkfwIwF5eomegTElsncOrsisR4gaIgdCUuMgB9EI8x6u+zWc
 y4Tf3JoxsFVJTnaT4J0AEtJ4O79mtoVEZS7VZhadSpdbDGhLP0yTu8ldw3jlJ4oMkeIXFEW3hqg
 /5UipqSrxOYaPXADrbkr4KvuIPF6GwA8lzJc
X-Google-Smtp-Source: AGHT+IH3vaJ74o9iUB3rq3AsMmN0ctgDIcemJflM80dyDi4/Ts0F7Ks0WbtTVTmMqQ/KrkN5Tv9GUg==
X-Received: by 2002:a17:907:c920:b0:ac3:bbc8:ecab with SMTP id
 a640c23a62f3a-ac738a151e3mr359801066b.11.1743326740846; 
 Sun, 30 Mar 2025 02:25:40 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7196cba8esm452202466b.152.2025.03.30.02.25.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Mar 2025 02:25:40 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/2] ARM: tegra: fix PLLD/D2 relates configurations
Date: Sun, 30 Mar 2025 12:25:30 +0300
Message-ID: <20250330092532.10187-1-clamor95@gmail.com>
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

Fix PLLD2 info table entry on Tegra124 and Tegra210 which unlike on
Tegra114 and lower does not match PLLD.

Take in account PLLD/D2 enable bit on clock_set_rate call. Those two
seems to be only which have this bit.

Svyatoslav Ryhel (2):
  ARM: tegra: clock: take in account PLLD/D2 enable bit on
    clock_set_rate
  ARM: tegra: clock: fix PLLD2 info table entry on Tegra124 and Tegra210

 arch/arm/mach-tegra/clock.c          | 6 ++++++
 arch/arm/mach-tegra/tegra124/clock.c | 4 ++--
 arch/arm/mach-tegra/tegra210/clock.c | 4 ++--
 3 files changed, 10 insertions(+), 4 deletions(-)

-- 
2.43.0

