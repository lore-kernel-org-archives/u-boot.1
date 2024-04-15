Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB68CC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 11:51:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99C9388216;
	Mon, 15 Apr 2024 13:50:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="n3O/F3Pc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87C3E88207; Mon, 15 Apr 2024 13:50:57 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B368B87D5F
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 13:50:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 43AED411E6
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 11:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1713181855;
 bh=UtzxNnTA/VmFXmVRwLjWOugIkpJKQGL17xO3ULu9enc=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=n3O/F3Pckdy7zCzjfblsp+gP/OzUBmYHhHu49lM9oINayJXpuhoIeNqYxRU82AvGK
 0Jf+r2xT3496N5yJc/jDda3lhe9eHXhSGoLBYQUFCHdD0ElQX4IzOK8nVYpWLikKBV
 8BDxMw2fV6RR3JhJup09SbpfZFtNNW5hl3rJq4miX3yf3U+0iQ3v6olx43u6KxHvLu
 L7XUBdkOhnfLM0lp3jwNep+fOgAdB0ZKZ3tAfeVqLwNRYoxQzHAXDGiEztoQG4CiNR
 SsbApbPpv0WrcwxB9n8cxwPL5AYYGdORb6w5y4KJmyZKh3KSY5692igmoxKx85kWMA
 Wu60x9Hr6EB+w==
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-343d7cd8f46so2392406f8f.2
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 04:50:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713181854; x=1713786654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UtzxNnTA/VmFXmVRwLjWOugIkpJKQGL17xO3ULu9enc=;
 b=hDEHBB1JHZFTG51Rccv0bIQtuSI/t1TPn63vwuZ/yYQV2C1hAhWGootn+USzZpiq63
 99RwBuPQm/W3Od6J6pO7KFWGpzfArJwg2jCNp7KpMEE/vhOIq+thISP72ZqiHzicbcZ3
 K33m2WIfZ3iN5OsjmlHYTMoh+PIMGeOyUREjIixqfYGFnQk8XbDN0j1zHg/8JrQySyFx
 44vXaVm+2SV/jGO9yDag7ZULcMWVX9CtfzZAk+4nfZ788n6HDnzmdridme0FbMb8jKtP
 GK0Os4jD2Cr9GkLa5EtE3zyZvQ7BX2Oc9MlsC3u9gMmN11q0Ioz/ApKnOtfVcA94PuGd
 WQxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7zZq27MxFAw1VoioxH+5hiTEaXaeosRlPQSW79+P7csHWCt1f2oFdzyEMPUa1pf0D7IGN2Y4XAAgR3yrWh1qZSC+KvQ==
X-Gm-Message-State: AOJu0YxQ4lSHx34qWR+ziu2D0vZWxIqYixOltnrrQN4iNd5e1I1VgRtT
 i3MIDiUWj8VmGYFcOmes9l5/NJvGNkAZZPwj+1qyN6hpFsVmW2p5zB+DpbaI/70Nc/oEd/Urlmz
 hn8Xk9sEJJCgraNyk5RT8w9tOE8IJzz1z72I7nLqyM/Evh/PWU379MPcGW1tjUohzf+M=
X-Received: by 2002:a5d:58d4:0:b0:346:dace:5310 with SMTP id
 o20-20020a5d58d4000000b00346dace5310mr6197696wrf.22.1713181854787; 
 Mon, 15 Apr 2024 04:50:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGYuwYaVbpXvr7IP3UIWgGQ0MdmgZ1TAfyOI1G8GCl4/cimJ1yXCa1TO8XMjAyY5xh3hOApA==
X-Received: by 2002:a5d:58d4:0:b0:346:dace:5310 with SMTP id
 o20-20020a5d58d4000000b00346dace5310mr6197679wrf.22.1713181854511; 
 Mon, 15 Apr 2024 04:50:54 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 j10-20020adff00a000000b003469e7f5c52sm11924130wro.80.2024.04.15.04.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 04:50:54 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
Cc: Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Shengyu Qu <wiagn233@outlook.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, E Shattow <lucent@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 4/4] configs: visionfive2: enable SPL_YMODEM_SUPPORT
Date: Mon, 15 Apr 2024 13:50:35 +0200
Message-ID: <20240415115035.46199-5-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415115035.46199-1-heinrich.schuchardt@canonical.com>
References: <20240415115035.46199-1-heinrich.schuchardt@canonical.com>
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

We can use U-Boot for recovering JH7110 based boards via UART
if CONFIG_SPL_YMODEM_SUPPORT=y.

* Send u-boot-spl.normal.out via XMODEM.
* Send u-boot.itb via YMODEM.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 configs/starfive_visionfive2_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index fa80d489f5e..e2d83c62b28 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -62,6 +62,7 @@ CONFIG_SPL_I2C=y
 CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_SPI_LOAD=y
+CONFIG_SPL_YMODEM_SUPPORT=y
 CONFIG_SYS_PROMPT="StarFive # "
 CONFIG_CMD_EEPROM=y
 CONFIG_SYS_EEPROM_SIZE=512
-- 
2.43.0

