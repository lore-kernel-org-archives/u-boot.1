Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF9CE81BD3
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 17:59:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 911A88397D;
	Mon,  9 Feb 2026 18:59:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IP5B0LbN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEB9D8397D; Mon,  9 Feb 2026 18:59:48 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3B6B80325
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 18:59:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-59e17afd2d5so3713953e87.3
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 09:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770659986; x=1771264786; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AXzY34Jp0SNshE3Gid0msZlBl8W6hOIC8mrVqXfA+9I=;
 b=IP5B0LbN/G2oHuoAQQ+U3Duvl1uYrX6O3OR3mclNEBnERjZFTajmRFLgcvrCej2ukQ
 7FemImRe2ZJ/wU4vQAZyCAzsiKgFVFieJtNaSZMWbqHO+y5SKb+1G92zDCPJWU9/GetK
 s+PR4mIgqjqRA/ScKpgHnw5t63uKkuvPQoPCrXWQ+8T+mcuB6/YG1no+eCaAEFTpJ/un
 FOJg8DHJtmMs2pIqyx8nyGXsiQsbuWzDFBq3P3lHSm2xiVDKiUmS3EwNKnx/i7OvQDFb
 qQlbCq6e+fNq8L4ERG/IH7jQDpPRPGD3U+IB0bx5S5coS4hTkAlp+Kk4epTb557zkU3a
 B3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770659986; x=1771264786;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AXzY34Jp0SNshE3Gid0msZlBl8W6hOIC8mrVqXfA+9I=;
 b=Z9YZDImlIIIJMJ7qYUhGOn5bqNL2HkuEp/USYwMy9cU5PDeI0Ulecg4LFG+a4kfvqf
 e6Vkm6iLNntC6pXenXW/bs90RDqLRsN+VhEFaxo4/iWU9UEB5Nl8zBpUofqBx+K1EjbL
 n2mavsmW3oZeIqPgYqef7JBwtKAwXR5qRUnSMzXT1qFh45KnA8eo8r47CSbNsgtJ2Spq
 QgoLqyW7bAlG8dWHfrFKWCIarEoT6v5koJ7t9yjRBeGqj7t9Qu9JOVxXztfyt1ut1oat
 LGOo3oHCTjARLFkBwOb7N770Drrk0D4i61im3mcTlf17eIuHqTLeJp1lsJD4ZsYCOwoQ
 uilg==
X-Gm-Message-State: AOJu0YzDoQ4GZOzIEj+BJyRLmnURGhYdFFtEfXZBeTCBNAB84q7SYrRd
 oisY9K/oEvWop7TVsXhMeZZ1ZZ+k9LE9lE9rmmwBmnFWGWrfCaKi2jLN
X-Gm-Gg: AZuq6aJb82SUXiAmD5NDWCBtAYNXaSw4lPfveynSG2FhTeiTh5fLJlveowlpRtIhLbn
 Ba4HQUhAVEKn5M4/mMECb9naa12tV2tJmtR0k15GS2K9FkuT4EMf5c7Mb9t56i88TyF1FGqsS6z
 A/EuOr5iLvkQEnaKN8TbMbQ5J0tVKxSlzVwBaqmLOmh6w6nwuYEcj5AR7L354VKIQVOGBiPnl+H
 ngW32kDP5L6e0t0yWxbB8tg9XmM1pC7gahMvp+iUxFlJf2ghNWJv9VF2kf6HXBic7ZBPnFOcfdM
 U2jKZqpm0WJ6/5O6jyzNd+qMoqQxgs2SVeq31t4jY8nrrmRRXjxpzoiMj+TzFC5qCURJMlUTO43
 BkvLI7e0ZSLaqAIQBcoJb30DdtnKA8gLZ3jo94Y72pma5zflHH3BT/ovjeffZK7QZkFtd43TM1O
 Uf
X-Received: by 2002:a05:6512:4001:b0:59e:479:917c with SMTP id
 2adb3069b0e04-59e45160c98mr4152642e87.39.1770659985800; 
 Mon, 09 Feb 2026 09:59:45 -0800 (PST)
Received: from xeon ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59e44e21c9fsm2756688e87.77.2026.02.09.09.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 09:59:44 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Ion Agorria <ion@agorria.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/3] ARM: tegra: improve tegra_get_chip_sku logic
Date: Mon,  9 Feb 2026 19:59:33 +0200
Message-ID: <20260209175937.32010-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
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

Add T20 A04 SKU id, default fallback for Tegra20 SKU and debug prints
for unknown SKU.

Ion Agorria (3):
  ARM: tegra: ap: add support T20 A04 SKU id
  ARM: tegra: ap: add default fallback for Tegra20 SKU
  ARM: tegra: ap: add debug prints for unknown SKU

 arch/arm/include/asm/arch-tegra/tegra.h |  1 +
 arch/arm/mach-tegra/ap.c                | 12 ++++++++++++
 2 files changed, 13 insertions(+)

-- 
2.51.0

