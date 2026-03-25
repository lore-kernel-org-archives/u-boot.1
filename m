Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0F3109C059
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 19:01:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E42B83FD3;
	Wed, 25 Mar 2026 20:00:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G/hny2+8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08A9A83FC6; Wed, 25 Mar 2026 20:00:31 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D197983F60
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 20:00:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d9c98e437cso124997a34.0
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 12:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774465227; x=1775070027; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MCLjJTnbX7Ov0OE5hw+rtvI/0iJAL1M3jDdYvML7vCo=;
 b=G/hny2+8SXjZmEtiMQo4j+wfVbN+mCWt4BOBiY+zjoW0a238WQuHVTvaLZpD2ZASxU
 krqIb+2KFwCcybE072L68ZxptyQQigMw7NWuuJQatbqmXqclX/X4cOskd7QUSIRP+N4b
 S+xGMmvNBI4d22MbbSBCzH/NhZjvKcRYTb1kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774465227; x=1775070027;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MCLjJTnbX7Ov0OE5hw+rtvI/0iJAL1M3jDdYvML7vCo=;
 b=ZFDuqeqmONgqFBLkvs1L66mY9OUya62NFSaQzK4JtQOJwCkNXDkrvHHxXORZWuPQ1D
 SdmQPQN6l1D1BCGSNE2yJss5kP5XTtJnsNL6PnvDIEfD2p1FVzMRz+KBMJ2LJixHDenJ
 HlWFoGr0MwLL0Ey5ZozudxCjcLkCV+t+abB2V4qzcHvzK2Nq3OS1abdHDrRKfxtVg7NU
 MWnkYdCP1qXsRwTL++TtFWx8rl4aDkaFEPcZUp0iMAWYTYtzEg6EpYzmTgv7jB3K4eI0
 rAswRVwU1T3xpqFukdtS12NT91I0eId2FOvGV2ZttQeBCM0HpCJ5FGHT4zNhiAmmQkyL
 FuxQ==
X-Gm-Message-State: AOJu0YwQBpbrecm77sxKZ17y+cVIweeJEDC1RhAeugbiKbXlxG/KYKtR
 expj0c+t/r6Y+CbTmSo0A4o5GsYgycAocuVfM5zyRTUtmMVZ1uVymKrtRRUKOMweiot5nJy1idv
 k2ZV5p9o=
X-Gm-Gg: ATEYQzzOYjP2IdYtuh9Jg7UfDS5N6p0wYjyAtQAQIJNp+Ph4po2CjffQ0SHXQU4lKW8
 NxvPAh+NYsKMDTQF/jqYle3sJuBai2GXcgpP/qcVtWPd6P0Xhh+D8fbuGWVXFYxu6/VlSx3Cj/4
 Q0/AOCXMfAQRmZCe2ybtDXYs3uPwvXRKdbOMUzdWt2m7wPteV4wgRW9kzVKLoZ/+yk0LewXIp9z
 g69kTvK/Sv1Z+w9oUoonzandHKrGKyJ5IVtfRQqAIwbOLo9+3oHCLFJSHdsAxnJg1cNsjIGPwWT
 qndn6SJy5MvkuwM7yEYKjMxqhW1V/VdJWMnNocE98Ow72hA4QG8rRFo43TegPMRAB8Xt9nPXBq+
 A/429K9XptZfSWTlyuzlqeNT9VstBS0r50EnE5rUAiya8gxdXm5gXbqCcPXU9TJmHRG4oDd3Ia5
 qzlOLrr3B4cki9tPvO4PpnnyCQ22YGyD2VZYmsnyL8qAxiv55+5nyeGSUBIX8PkYV0GccTxtcwd
 sOZ7DuPNniDQ/PF+6sFiklax5embqAU5bBzGbcBGKKYlD2F/z8=
X-Received: by 2002:a05:6820:168c:b0:67d:ef28:8dca with SMTP id
 006d021491bc7-67dff3dd541mr2540109eaf.24.1774465227407; 
 Wed, 25 Mar 2026 12:00:27 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67e0a9e18desm550887eaf.3.2026.03.25.12.00.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 12:00:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Subject: [PATCH] arm: rockchip: Guard call of board_early_init_f in SPL
Date: Wed, 25 Mar 2026 13:00:25 -0600
Message-ID: <20260325190025.3428560-1-trini@konsulko.com>
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

Today, no platforms call board_early_init_f, and rockchip provides a
weak default function. Change this to not providing a weak function and
only call board_early_init_f if CONFIG_BOARD_EARLY_INIT_F is enabled.
This will allow any potential future needs to be taken care of, and make
future consolidation easier.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Kever Yang <kever.yang@rock-chips.com>
---
 arch/arm/mach-rockchip/spl.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
index e989c148079a..8026cc0abb8d 100644
--- a/arch/arm/mach-rockchip/spl.c
+++ b/arch/arm/mach-rockchip/spl.c
@@ -97,11 +97,6 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
 	return MMCSD_MODE_RAW;
 }
 
-__weak int board_early_init_f(void)
-{
-	return 0;
-}
-
 __weak int arch_cpu_init(void)
 {
 	return 0;
@@ -111,7 +106,8 @@ void board_init_f(ulong dummy)
 {
 	int ret;
 
-	board_early_init_f();
+	if (IS_ENABLED(CONFIG_BOARD_EARLY_INIT_F))
+		board_early_init_f();
 
 	ret = spl_early_init();
 	if (ret) {
-- 
2.43.0

