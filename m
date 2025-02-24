Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C60C8C021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 23:07:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9932E80F7B;
	Tue, 25 Feb 2025 00:07:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SFMJ7Ee6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A52E980F67; Tue, 25 Feb 2025 00:07:00 +0100 (CET)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AB4D80F12
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 00:06:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3d04932a36cso51192455ab.1
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438417; x=1741043217; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FLjPxxvNwl1Izdu8dNxj7jwuxoUTg5WIavhcch5Y3JA=;
 b=SFMJ7Ee6to02nWKD9hqF7MSpS0Ob/nV99jPgSsNSu0Ps1IDs4XrugpD/DsZjNR2bdj
 ki9pAehfXLQV7hWFIFnxP7qAAgorz3DAbUG7qEaszWPH+eXDnKRA8BTh3I1YhrvPZfpO
 qH7IGweoRiJVQY5jWcfFYmsYesujwbMemllu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438417; x=1741043217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FLjPxxvNwl1Izdu8dNxj7jwuxoUTg5WIavhcch5Y3JA=;
 b=MbD0eGBI3jpw779UGvuUqqK0vswxJtamfYr2uwhLoQ21oRu3F6YhUfDTffDuK8yiBb
 ua4RwyFDd00t7Xev8TMyNNajh1MlGfClqZolBmpNM7DrY65WNxx6E8ws4ek04PgFRLIR
 06nbAsSPCw0ovgEkatUKHNmamB43kQdhhCE9WhM+Ngnyugn+/+7Rkdgxvshi2VC7RWFI
 O2fjyi2D8rIxXKhLpkAmo79Re8ep4ZHrG0wgNCls3XG8xDNH8bNcxcdpMlCRlNIy3goU
 dOEl3nY2eL4G8Vmqs1NI72SFcIBIfPqYmZf7AdeH4t/TES5+jDGuGJmnoDKQ/NzviEwg
 Mp5Q==
X-Gm-Message-State: AOJu0YyAFT7ggsbIMzHDj+rk2YSsPKFvRhomvv7DiYlpoC9ne9jSG4E1
 u2kkKk3BUhQ9rZ20iFc5bxTJnDG4Q8gp6I1rEwVqMHKXTNxD3mBOtLSmHhTKwafk1hKpwlyVC98
 =
X-Gm-Gg: ASbGncui1md8VTWZa8TUdUkXCT2tl17GJQhXT9ajjh0lEmD0RJ9Z8zswx1GSUx9ZeMN
 WXwrnbDnN7xAxAiKG5E/d4J6QSXIWPWEyqmsbf1TS/eko11+laNM3rk+i6+u5STZluAMrfC47jh
 xyuNx1khb8adWBL5oXloy9ff3oU0FiIQtela1LZ96oRxNg22eN+CP6Ne8gjj+YD6qERML4j9IzY
 /xJkBH3k4GKJNeo6MIw/QQQqoVwIvBt9Lw9S2vkzZmM5IHXcFhB9I/0Ffg0sToPjTkXlPOCPCCB
 WZlFM+Xdo3/CeFCQSJ4Ngq9ICYNgnPGhAfEKK+mtbqMgrkl4ROuySQF7ZjcOsUk=
X-Google-Smtp-Source: AGHT+IGWPovqRsWP4VLe2BTW4w6n6v8vsxSxrO+nmy0ei5rg3hU/nD0bUsrcwZkwcG4paUM84Cs/ig==
X-Received: by 2002:a05:6e02:b4b:b0:3cf:bb6e:3065 with SMTP id
 e9e14a558f8ab-3d2f915366emr13622475ab.0.1740438416766; 
 Mon, 24 Feb 2025 15:06:56 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.06.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:06:55 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 01/44] x86: Expand x86_64 early memory
Date: Mon, 24 Feb 2025 16:05:50 -0700
Message-ID: <20250224230640.2665206-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224230640.2665206-1-sjg@chromium.org>
References: <20250224230640.2665206-1-sjg@chromium.org>
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

The SPL and pre-reloc malloc()-space is not large enough to start up
with a display. Expand it.

Switch the order of SPL_SYS_MALLOC_F_LEN and SPL_TEXT_BASE since this
matches what 'savedefconfig' gives us.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 configs/qemu-x86_64_defconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index 792ba06c2b8..af275e8ce8f 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -1,13 +1,13 @@
 CONFIG_X86=y
 CONFIG_TEXT_BASE=0x1110000
-CONFIG_SYS_MALLOC_F_LEN=0x1000
+CONFIG_SYS_MALLOC_F_LEN=0x1800
 CONFIG_BLOBLIST_SIZE_RELOC=0x20000
 CONFIG_NR_DRAM_BANKS=8
 CONFIG_ENV_SIZE=0x40000
 CONFIG_MAX_CPUS=2
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="qemu-x86_i440fx"
-CONFIG_SPL_SYS_MALLOC_F_LEN=0x3000
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x4800
 CONFIG_SPL_TEXT_BASE=0xfffd0000
 CONFIG_DEBUG_UART_BASE=0x3f8
 CONFIG_DEBUG_UART_CLOCK=1843200
-- 
2.43.0

