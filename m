Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFAA9C25B7E
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 14:19:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7253E88607;
	Fri, 31 May 2024 16:19:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gNz+05Lt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 988A7885AF; Fri, 31 May 2024 16:19:09 +0200 (CEST)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B87E887C7
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 16:19:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-6bce380eb9cso1569564a12.0
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 07:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717165146; x=1717769946; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SdA+Ja0l3niJi2ZcNdfu+oSibsez7U/ZuCEEo+TWLKM=;
 b=gNz+05LtYh27L2Dp0tqt6QEfMJaOdpmixmd4xcUfwDnQBsqThPLnFvVPey1PtyhArW
 U5jJ5zwoymg1ZO8gKoJebhb38OjWxaQtUIb7c+9OO3LGIoNwmaOKFTzQdFgj0Yf+07E5
 H0MzqNQikeo06FrvwCdsc+miPBTiAQSkEvfSckMoLVuLnDcg3jIB++FxV5XdizGFzYRo
 89yy7YEvjUXY8+ZmF1Km8HD8AMj/1yVvhTZzH+VJZWolReBLA+K7vqhle2nh+6jMG13F
 jQuznqkc3h9fQdITz1y3oGoiQHa9arCdpCJRKnK1C72Ys5B7PBQ03efhyJchSjpq2q3N
 4BVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717165146; x=1717769946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SdA+Ja0l3niJi2ZcNdfu+oSibsez7U/ZuCEEo+TWLKM=;
 b=m4WF1UXQao5Q94qpjlFtiBBpr84pTWVVx/3qnlNSt1b99dgcrCZHc+yZV3AzxPDqXd
 HBac8kQXpvOdvnWmivSRKngTj4dcjKNHi2ie5DO7qCLQ739gDEH4u9Po1cteAO+68M9k
 8QdMCY4FdxIzyJppPNrGwMB7PqyLBNgAbO3WnxspfsuO6wsxcxQ0RW1AxSKffSoJOdhw
 4d1F7cMsKb17grlSAOZuYznJX8G6tjBGqi7KWtuXSIkZZ+hWnIDf9K9gxt1QHU7ETFJc
 MAofFeSDjacL41lDFEb0xlsNWeC/SIVPXemsQRQ0TarZMXjCUqYsre3xYbW6O/7nsQf9
 Z8eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNQleeq1qVdDwK5PQTjRJYjbpXtvHJHKXyAUcIKmRJ3QUl/+8MuowUL+7OVxCyYyvtnRR0sWiJ0wmgj764/fV1Y73SrA==
X-Gm-Message-State: AOJu0YzkX+CNyRNCx4g4/cMglZ7MgwYRoYf4Y1IMbGDd2SHUxcFYr8Pm
 6MBQr2V0SIQBQl/qPkY9KVIkAa6nsAkKq46+lBPNUnlJD3LiuPza
X-Google-Smtp-Source: AGHT+IEMCC/Jd04gyuYN702kKepMvnbscSxxcOL/cNBY6a1pT0KWxxfIKoEkoT3yoHRhIJivt9WGJw==
X-Received: by 2002:a17:90a:f3c8:b0:2b4:b306:ffbc with SMTP id
 98e67ed59e1d1-2c1dc57102fmr1779761a91.17.1717165145839; 
 Fri, 31 May 2024 07:19:05 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a775ccedsm3563935a91.1.2024.05.31.07.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 07:19:05 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>
Cc: Anand Moon <anand@edgeble.ai>, Anand Moon <linux.amoon@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH RFC v2 04/23] rockchip: RK3399: Enable display cpuinfo support
 on all boards
Date: Fri, 31 May 2024 19:48:18 +0530
Message-ID: <20240531141837.13189-5-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240531141837.13189-1-linux.amoon@gmail.com>
References: <20240531141837.13189-1-linux.amoon@gmail.com>
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

From: Anand Moon <anand@edgeble.ai>

Enable DISPLAY_CPUINFO options to support on all RK3399 boards.
Its used to determine the reset cause of the board.

Cc: Jagan Teki <jagan@edgeble.ai>
Signed-off-by: Anand Moon <anand@edgeble.ai>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 configs/chromebook_bob_defconfig   | 1 -
 configs/chromebook_kevin_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/configs/chromebook_bob_defconfig b/configs/chromebook_bob_defconfig
index acfe393410..2c1a8141c0 100644
--- a/configs/chromebook_bob_defconfig
+++ b/configs/chromebook_bob_defconfig
@@ -30,7 +30,6 @@ CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART=y
 # CONFIG_SPL_FIT_SIGNATURE is not set
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-gru-bob.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_BLOBLIST=y
diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
index 95fdb418d8..f6649804c7 100644
--- a/configs/chromebook_kevin_defconfig
+++ b/configs/chromebook_kevin_defconfig
@@ -31,7 +31,6 @@ CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART=y
 # CONFIG_SPL_FIT_SIGNATURE is not set
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-gru-kevin.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_BLOBLIST=y
-- 
2.44.0

