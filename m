Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D24C02198
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 17:14:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2931180A29;
	Sat,  8 Feb 2025 18:12:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V7UTBfLK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B650E808AF; Sat,  8 Feb 2025 18:12:41 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 915C880B9E
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 18:12:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3d03ac846a7so9793905ab.2
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 09:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739034758; x=1739639558; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cfnl4x9ZQu7LnoT3iQSqV04RWnOIGHU6v9wf600TAKo=;
 b=V7UTBfLKyFYUf4LObrT9eZS4L/UIr2n9Ux/uPgw5BkaUfPmAAlI0vh+stJX51BGYZE
 8iiy077JM6QBSbbFXJEl63zhUYwZDBuhd3dbP70kiIp9TpO3F/rhls4pKs7UEPV/PJf+
 07BgcQUFkchlndV1YRK9tS/qfdP+OMlIJgPaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739034758; x=1739639558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cfnl4x9ZQu7LnoT3iQSqV04RWnOIGHU6v9wf600TAKo=;
 b=HvtU7R4QbLi4irUrjUMD1A6nqo0wl2AiFkGppV11J1TyUXKEbKMqhy0D16Syz6vhSu
 fTXYt3KQP7jqCChPw+20HRiiB8YCnLgFwBa/BN9yffG5Kjyxh3StYaYwhT4Yv7YzrERY
 CfKAH0XM1dle/bboiSpq89B7uP6ihv7VknhlmP6/gLUHOIh370zslNHo/pYU2yL8l6Wl
 FolHt+9/ljdBk+W01mk9+EBzG8kG9TCmo2E5UO15yFR6vn3oel0OYM9XgeuhPu80SpM+
 EgBlwVLlYPjcKWZNVU60NMq+STXO3DPIX41X8ztmYbPOzmImnGPuxpBeToVLz43My7yF
 jptA==
X-Gm-Message-State: AOJu0Yyx2i3iOCOdVOgBoHAGFMwWqz91iIpy1ihDJWW2d6p5NUyCiTeG
 25F7RRdM32uizobsXWTstsQdRx4iXeg1V4GsZbTAc2xgI6DAHvAIVAQmO1dD9zq2e2+HVqGsvPE
 =
X-Gm-Gg: ASbGnctMKyl+R0qgjC118bNHx1m4eHkEfDQd8XzphuD2PB1OkgHYLnBiM8cIa0/Y/0Q
 ns4WulQ365883AT2kJYHkTNVId+He47yWqkXJvWCT45ystW9mctw45Itw9NVcVxV0GFiCa4u/Pj
 LWGV8RAJtoXYdhaQTZl5JX8w/lWOtEPzx28w/RURVS3HV9U79j72Q2nlG01VswScuC0naKnMDMU
 zhF0rxyW1mnI/xwlz6NE0d2Mj3m3YRQz602dbtFRFk8N1T6QzkljgzZaH613NSq1cF/S8lL6Npg
 7nQHcG8VDmADNYNHTvHoyQLxBlKTR/YaE80spipy415rxjrFLw7k
X-Google-Smtp-Source: AGHT+IEJ7cTDevyxyzv4I4UZXarToEC0pZWnHyISNRSgmyOJZEUiu4Gvf6pXQa8bew3m4/NGQnullQ==
X-Received: by 2002:a05:6e02:3421:b0:3d0:255e:fdc with SMTP id
 e9e14a558f8ab-3d13deecd04mr68357365ab.15.1739034757763; 
 Sat, 08 Feb 2025 09:12:37 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ece80badb5sm371754173.68.2025.02.08.09.12.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 09:12:36 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>, Janne Grunau <j@jannau.net>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 14/29] efi: arm: Don't do the EL2 switch when running under
 EFI
Date: Sat,  8 Feb 2025 10:11:34 -0700
Message-ID: <20250208171154.1305761-15-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250208171154.1305761-1-sjg@chromium.org>
References: <20250208171154.1305761-1-sjg@chromium.org>
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

The previous bootloader has likely done this already, so avoid trying to
do it again. This fixes a crash in QEMU when booting from EDK2

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/lib/bootm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/lib/bootm.c b/arch/arm/lib/bootm.c
index 974cbfe8400..688c2f3f29b 100644
--- a/arch/arm/lib/bootm.c
+++ b/arch/arm/lib/bootm.c
@@ -16,6 +16,7 @@
 #include <command.h>
 #include <cpu_func.h>
 #include <dm.h>
+#include <init.h>
 #include <log.h>
 #include <asm/global_data.h>
 #include <dm/root.h>
@@ -186,8 +187,10 @@ __weak void setup_board_tags(struct tag **in_params) {}
 #ifdef CONFIG_ARM64
 static void do_nonsec_virt_switch(void)
 {
-	smp_kick_all_cpus();
-	dcache_disable();	/* flush cache before swtiching to EL2 */
+	if (ll_boot_init()) {
+		smp_kick_all_cpus();
+		dcache_disable();	/* flush cache before swtiching to EL2 */
+	}
 }
 #endif
 
-- 
2.43.0

