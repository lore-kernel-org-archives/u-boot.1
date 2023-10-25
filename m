Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 667D0C25B6B
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 23:13:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CB1586FA6;
	Thu, 26 Oct 2023 01:13:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JV6rjWvA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5393687055; Thu, 26 Oct 2023 01:13:23 +0200 (CEST)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF955874D9
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 01:13:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-41cd7a3e8f8so2345851cf.0
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 16:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698275599; x=1698880399; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bXPo4dYWVfMyNW7ut3HlPXgLCDEhwipvrf6VcFYp9wo=;
 b=JV6rjWvA8o2JaIxYQ6I4HDSIh3dbvkeX9LRs4r/5dUccnYLM4yFbNasCSXTOyA6yQH
 fnLbitLKfMV9Esh+XxazUGo5w0UPXl2RpmLlURRTfdHY/59vRD+7L5RKq5CWKFCZW9Yt
 T31db9KkeEu4D6Hq8yB+n7jYDX0Saz6VFU2yrRM0yfkECQhXP3O6BzXrv72aQcFeuvE3
 2tf2kwvH2fGt2yUShgJsKdML3ty7MplYTHnyQTDvEAxEG2Hpx4GGig9C74M9ixSYnRrO
 nsfyTj7tjGUdRMC3HKrbKnYWz5VDMwQLh8q5q6uYQZ09AonzgWScqAAbGMFAodUHPRsc
 7eiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698275599; x=1698880399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bXPo4dYWVfMyNW7ut3HlPXgLCDEhwipvrf6VcFYp9wo=;
 b=ZrzQg2EtOWsoU5utTQ2k1l5w8i/y/34VPopnFzhlKgsnNK/bGvSw4bN/rF7V5r+tHF
 qa+kbbGu3LbOmgmfAU87Pwcp30mALLrt8PSLelNsCpxcK27r034bF9XvJt+CbC0Tawfr
 YkaBH4DzOYze7vv3I6BuVqo0Y+FV3lOJHrGCSF+LXN2cM04Wm9OmAl79hQw/dsSgoA0h
 yTdPQ/H9EKAgqGPQKbjPixA/opGrnORIlcqMgrDvJSRTdTnImar2HB9h+JLQ3u81x24w
 SMq+O742mogk09xGe/e3hquQdJs6QYcC2IJWTDRKpbtmvsAxot7eE/Ix3Bz0I/xvXDDJ
 ucGg==
X-Gm-Message-State: AOJu0Yw6itTsP/Ir7i0Q93E7e4w0BFFfudVc9SSIMquQqtjHfiXKQ+JT
 pHoZu697oA+ra3+LaVHnuJwU/1xWp40=
X-Google-Smtp-Source: AGHT+IGUkKA/5+Nj9M87SzCzeoSnsfWDG3SSHE5dslIfcVzpmfjPDoOMmbtlHUYUlgPb1SpjILzZAQ==
X-Received: by 2002:ac8:5741:0:b0:418:125b:2cfb with SMTP id
 1-20020ac85741000000b00418125b2cfbmr23490949qtx.3.1698275599188; 
 Wed, 25 Oct 2023 16:13:19 -0700 (PDT)
Received: from aford-System-Version.lan
 ([2601:447:d002:5be:449a:a220:d0aa:3d6a])
 by smtp.gmail.com with ESMTPSA id
 x10-20020ac8730a000000b004180fdcb482sm4576814qto.81.2023.10.25.16.13.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 16:13:18 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: marex@denx.de,
	aford@beaconembedded.com,
	Adam Ford <aford173@gmail.com>
Subject: [PATCH 2/3] configs: rzg2_beacon: Realign ENV location and offset
Date: Wed, 25 Oct 2023 18:13:10 -0500
Message-Id: <20231025231311.8701-2-aford173@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231025231311.8701-1-aford173@gmail.com>
References: <20231025231311.8701-1-aford173@gmail.com>
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

The ENV size and offset were changed to different
values in Beacon's downstream release.  Change them to the
same values as the downstream for consistent behavior.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/configs/rzg2_beacon_defconfig b/configs/rzg2_beacon_defconfig
index 7b14d225b5..534f641e84 100644
--- a/configs/rzg2_beacon_defconfig
+++ b/configs/rzg2_beacon_defconfig
@@ -3,7 +3,8 @@ CONFIG_ARCH_RMOBILE=y
 CONFIG_TEXT_BASE=0x50000000
 CONFIG_SYS_MALLOC_LEN=0x4000000
 CONFIG_SYS_MALLOC_F_LEN=0x2000
-CONFIG_ENV_OFFSET=0x0
+CONFIG_ENV_SIZE=0x2000
+CONFIG_ENV_OFFSET=0xFFFFE000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="r8a774a1-beacon-rzg2m-kit"
 CONFIG_RCAR_GEN3=y
-- 
2.40.1

