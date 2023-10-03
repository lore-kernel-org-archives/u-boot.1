Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B42DE75428
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 06:25:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF4EE871EB;
	Tue,  3 Oct 2023 08:25:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WXGH9oXS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5251C87217; Tue,  3 Oct 2023 08:25:50 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A09286CA4
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 08:25:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-50306b2920dso620614e87.0
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 23:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696314346; x=1696919146; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ybLG6Qek8WwJVoU6QbyikHdy7zLUf2u9g3TaVCNzEAM=;
 b=WXGH9oXS4x1P3n+4OynnzzB9kLfvgXVqMJ3R9ZWYZHLhMLhqwoZbbcNo/0lYQTIam8
 s+bezPjyAZZjlzwHRY+/nf9TpNVleV+sLV7e65MIXCMojsh7fzPaWLqEBSILsf68SVSp
 9mHPEY/0VlQBnCw9bo0QyuHuqYQW04pqnHbFL3by4kaEuLGCPHi5t8qfeky+mRgCowdw
 B1olYk1k7VSKsG1LFGp/4l1IGUQjQtpPjOQZSguM6QoGxv5G2tldcpEpfMXo/Gzo0pV6
 NhaU6K/SzbplMrpEkwR4y9igRHyEnhV598vYgeMOGlbOZyiAKcJ/C79HhNX1qCvxQpBy
 18uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696314346; x=1696919146;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ybLG6Qek8WwJVoU6QbyikHdy7zLUf2u9g3TaVCNzEAM=;
 b=B0WneydMVaNOMiQ8bveVEvfmMv+oUZzUsafy/ip6sJmVyWcolnnp1U266gdvV7cFsw
 T569w5rhPiiGx5Mqs96f5oLdbJW2f+AcIFpJ9BNQsvq7u2cJS7+FqKg4AaSM2XWoMJaO
 pwPFCtJNX/1zV6mZhLtUIewmJcSxWXH5VH4F9cGgrSY4cfkzcCoPYTVLaM85t+HkuFoa
 g1tk3zr9PsPOwfx0HwwdrfhGOvWO3+O+ZHrEGtoe6E9AWzKOyvSeBlgrcyobvmnfmCM0
 H0KvZialq953pK3eyAfZzZVjZM7KnFaiEngo/yjb5jaC3BApjV4A3OXp492Jmbs0J08Z
 tqUw==
X-Gm-Message-State: AOJu0YyXMTSK/TVAJmdlMfqtxGuTulCsT1plXYMd9eshfkomWOJfFReH
 mlu3JRMVyoFVS277Xm4rR68L2FfdOHc=
X-Google-Smtp-Source: AGHT+IGWd3XC427GwLx+qTU1srapdj4jbz6Pe+d1aI1G5q9FlZhRCCNB4G8k66yDTC3QUcwbUU3Qiw==
X-Received: by 2002:a05:6512:3b06:b0:4fe:8ba8:1a8b with SMTP id
 f6-20020a0565123b0600b004fe8ba81a8bmr1332736lfv.7.1696314346468; 
 Mon, 02 Oct 2023 23:25:46 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 c10-20020ac244aa000000b005031641b40asm74615lfm.159.2023.10.02.23.25.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 23:25:46 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 0/3] Video: Keep fixed/gpio regulator counter in balance
Date: Tue,  3 Oct 2023 09:25:31 +0300
Message-Id: <20231003062534.42325-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
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

The commit 4fcba5d556b4 ("regulator: implement basic reference counter")
have made it more important to keep fixed/gpio regulators enable/disable
state in balance.

The regulator_set_enable_if_allowed function is more relaxed and will
wrap all cases where the regulator is busy, already active, missing or
if DM_REGULATOR is not enabled. 

These patches are an expansion of similar Jonas Karlman's patches.

---
Changes from v2:
- no changes, re-sending

Changes from v1:
- check return of regulator_set_enable_if_allowed for -ENOSYS
  to avoid error caused by disabled DM_REGULATOR (Jonas Karlman suggestion)
---

Svyatoslav Ryhel (3):
  video: pwm_backlight: use regulator_set_enable_if_allowed
  video: simple_panel: use regulator_set_enable_if_allowed
  video: tegra20: dsi: use regulator_set_enable_if_allowed

 drivers/video/pwm_backlight.c     | 13 ++++++-------
 drivers/video/simple_panel.c      | 10 +++++-----
 drivers/video/tegra20/tegra-dsi.c |  8 +++-----
 3 files changed, 14 insertions(+), 17 deletions(-)

-- 
2.39.2

