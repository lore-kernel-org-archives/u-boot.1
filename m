Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B57831091916
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 20:02:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0E4384035;
	Thu, 19 Mar 2026 21:02:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eErn9Kq+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A214083FE9; Thu, 19 Mar 2026 21:02:13 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22F1983E36
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 21:02:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7d4c383f2fcso1011914a34.0
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 13:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773950530; x=1774555330;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=x8i/wWklJMQx/xz0ZRWwjA4a/5DJ9qfezP4fqFs3hDk=;
 b=eErn9Kq+9es+uG4WwGJ75Fc6QwJeqv9KGHDB187Fdt7BVDEA/99k1hp0HUvvSpYJPC
 +UwEXlrCNa/IRzYOt+ZcYw9uj+i7byPqf+E6cW20LwpyPS7d6ry23Td6iWEYNfNEgQgT
 7k8Piph0CodAUYyQN/UGWjfb8zglwo5qIcyn/bHo8+ZgeUft7NwESqBN6tpKdwUWa+Xr
 nKJLNhnu4GtA4kj46BXmD14upz+VMH5YThJB3u80ta49XcdRbCNwQYhsfXeF1ixcwcvy
 9x/1uipTsoeK/3RG7drEu2tgAAZK44ucdV9158WJRK2bEXVow+AuVPls8Np8qinnrmjl
 7/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773950530; x=1774555330;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=x8i/wWklJMQx/xz0ZRWwjA4a/5DJ9qfezP4fqFs3hDk=;
 b=RxE9WGCEqXS8RFXUk1P4kVvJgPVgrxxLxR575IZzNRUmqkwZ/sys4d9vGM+DFbkrzH
 LoUxncOX83HCsIVSG5oaNjQ6IK201clepIG4FnLKEVApBjJnArHLozb2/d1INAQHLYAw
 GVpp9pkBv8i0X9dzFT2l/MBAHWaMk1/G+1CurMMqDRRUTIXtL8Cy+5EeYYiIHV73K9ND
 fesqj2WWMIxoIg53cLN030rwdDFxE7Y9Wqmh38/el6eUjCCBoAbANxQE/JbToHWvYSBX
 5tLWoBfkSM9kdI5xzRejR6SrUZ1A+f1fRFIULXapQ3hdJ8gTiFj3M/9nBtD6xA3rpGHh
 UXKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWM1oy0jwN15Xxk21yhej3enRyZVWN6ERofXEj44P+AQt5kSDldkesqDO52smaM3aBcFs3QK5w=@lists.denx.de
X-Gm-Message-State: AOJu0YzAKB4gVUcMxwIQqH0XLTcnyH4yt1DZnU6t1p15DnS3vjc9hAFB
 U8EE8FutA32vQyAWDACc03N9AS5HR5HrSf5qRIM3zfu1WidAOv/3svKuepJ/UWtYYW8=
X-Gm-Gg: ATEYQzwtASYgJUFizPP1e/pbHsnLW+Y705cYAH3IASzvW/3yomtH99RNbZYjw3SQ+B7
 +UsgKm5Nu0weZZcVbKzbzlke83fL9aw8eTwp59SRYdvPKdrd0AEB1qwHO5K22OPxqgiYVIN3Xbo
 fykuAT2WB8Bc6ZyaRgnBWneukFxRBxFcar6p833Sv+BcwqtfLuvRl1xu6Frr/4yNDrLUN39sbcZ
 LZIF13yb83kJLC13K5I1tmdUrrjosI4Ekwy+6i8VjmYZGrflIeXYHept5LsB1DFH97pl5x15CP2
 NS9zJd6t0yZGdVT17N12GUaSMiVqynSLap8gQzma0LfeYhOUb9+UxI20E2znS8BCu0zKIEnu90W
 3ijUph/pa7LKDOOv4h4GL8ua2JHJrcePe2HYY2bOg1UvsXqHJenN4XG8xow/QX+ZvqthXUY3y/e
 Xf47lMtExJJY70WUa9pOeHPqyybYtD
X-Received: by 2002:a05:6820:2216:b0:67c:1d14:fcff with SMTP id
 006d021491bc7-67c22f5feb7mr449549eaf.29.1773950529667; 
 Thu, 19 Mar 2026 13:02:09 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:244c:fc8c:8216:1344])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67c252acd32sm2826eaf.3.2026.03.19.13.02.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 13:02:09 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 19 Mar 2026 15:00:05 -0500
Subject: [PATCH 02/17] arm: mediatek: mt7988: drop dram_init_banksize()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-mtk-init-fix-dram-v1-2-6171ec141f40@baylibre.com>
References: <20260319-mtk-init-fix-dram-v1-0-6171ec141f40@baylibre.com>
In-Reply-To: <20260319-mtk-init-fix-dram-v1-0-6171ec141f40@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=803; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=5YxYwBj+GLcJ+SKV1LOxkYDzDzwZMU7xomshW6GAxMs=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpvFXUuhuGi/vJO5qJYrulDOYbzgAfRemElS897
 ZVQEEtuZw6JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabxV1BYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AIpEH/iC4aR7ADgDUmFMnQ6utW7TgVTYITUgcUzWwK6i
 LkUjUExZdYpC+0U5ZgsVmP0EzGvn32a7hCJtPfUv4Z4fGHQ8n+X8o9kEU3MrJB6OOHD0GiirquA
 IfGEOgdVphcfK6RoLsmcEal7wQz1MQOTStjnBnqgpxxFYgMIsSRYdDwfTkx6yfe1Xvx2gdwebCW
 QdXOeH4xHnZqfnnmNCJJhp7DXlcn9GbYTYZYdFD781GwEq6Kolo8Gt6+n+VyfkAJ+OnwVfxiq83
 iXXBajRmqKvfdyeULda+P4YcUeZU34XUgd9x3+isaWoYNpNp616FP4lY4IAuATRZ9XxRcgTxJZm
 0EJ8=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Drop override of dram_init_banksize() weak function for mt7988. This is
effectively the same as the default implementation, so we do not need
to override it.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/mt7988/init.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-mediatek/mt7988/init.c b/arch/arm/mach-mediatek/mt7988/init.c
index 7ff843585ec..7f4d934bfe9 100644
--- a/arch/arm/mach-mediatek/mt7988/init.c
+++ b/arch/arm/mach-mediatek/mt7988/init.c
@@ -26,14 +26,6 @@ int dram_init(void)
 	return 0;
 }
 
-int dram_init_banksize(void)
-{
-	gd->bd->bi_dram[0].start = gd->ram_base;
-	gd->bd->bi_dram[0].size = gd->ram_size;
-
-	return 0;
-}
-
 void reset_cpu(ulong addr)
 {
 	psci_system_reset();

-- 
2.43.0

