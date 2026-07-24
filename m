Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13666C531F9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 08:45:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B2C2081114;
	Fri, 24 Jul 2026 08:45:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B0fwTYC4nBNP; Fri, 24 Jul 2026 08:45:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 380BF80DC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784882724;
	bh=LAVSrCEpsw0uw3szkMiGzgP74NXkBrOOXaEDJCeZW+0=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ee0p6p+l98dnuVd1ngJ1MnCM40Cfg4pvwcV8X09ogrmWM0nXs1ltRvUt/pd4EfyRU
	 S5P5F6qIw1pusZN2gTOSHJCsHQPK9KD6uzJzQw5TfpqU0JRe6VqbcgqlgYuWXabOPF
	 zTw+i5uXhal1qWwh2gwhCzzATf+1mbARL+2LkAWdH1D53UUUl3ZBaIi4yXFjCOKj1x
	 e3GOLXTG+6VJxayWN+YNSO0IA0fd+Y4jSPSm65ro3EOhmlvB+XoNtjrxtUJt7ixgPN
	 7NMfH8h8SVBnLsGhNunugLkno1ElaZrB3yVHqWqI151GA46xNIBcKl/1uBQNf9VXVT
	 CagL8/lrxVeVQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 380BF80DC1;
	Fri, 24 Jul 2026 08:45:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 63638A47
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 08:45:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5534860666
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 08:45:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FnZeF4LLArme for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 08:45:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org CB00360638
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CB00360638
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CB00360638
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 08:45:20 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so1603485e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 01:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784882719; x=1785487519;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LAVSrCEpsw0uw3szkMiGzgP74NXkBrOOXaEDJCeZW+0=;
 b=QNMMxZtwc6DwmRLt1nus89KhihtlhZVPkKsarSV/fbpWdNAlpUX2HB2+HR5dbheQvf
 8wkso4lEFaLfORBy0NFNyXHLZHmwfGzOnNN+Jjppan9MeNdb6P1kvQTumd8ieD/wl2Tb
 bnC+Nh+bH4MGdheuitVaU4MS/SFdQZ7VjLNMHRUxwxnn779Yn/Iau/Tz7Xz4fT7Y245l
 sT+dd60fMtfiGXkgleJdhdXAW7fTTs36w+3F2fKaLdmJw0mn4aL1dVaJarsOeAlEfxY5
 CXBzMJYLlaLChjDFRPnAmFNU4pTnFXifrgRZqn82Fa2itLekzl8AoDN0WzR2gUuQNDED
 BHAA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpTf2lyGwTXAArroOk5Pt6bAeIMCvF3lGrjvDvoxMbsNXcMy0zyGAnvKrzJ6K3jxFx7aYfkeXk=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzBDg176uBaYqAfz7o1jJQ3KEUukbiKS/lZRhEAWCRhULag5VAP
 U2P2hLOsEZDDyaspovqJM+OYojIOTmExPSDugnyUpotgls8h2UXvSZYGFIXkpEanmcI=
X-Gm-Gg: AR+sD10lMYyREC094vyf6nvCKMAGjjdvb61ohHmW8Gb7l7G6Kp8JomAa9ViGkpcWj6b
 Sb4FKybTtJZTJGjnIX0veIVncZBgWThQU/xrCRW+9c2u+bIBATkRr4EeOBHCnDDF/Cdy25/bY5V
 bVd6rDmz5D1AtRiefTF4UI7kiq4yLwAAdBRNiQOJogJuTU67SzfI8PjfwSBxTqpu8iXHRvifSDW
 SYa+sKAcgIet/NVv9HkGWJHUP5lsIWnQT159uVSV4f4YoLe+C6R5mo/U+luzlAAQo8wvg/O2dgv
 AsvvVdRIu2aihV6AVzLMA6YTJjQK8sokT50xU0awglqtn7JO7ttsbuV19Qrpnb6tK/sKIdujM9M
 HkwBy85JUxKlxlQb3MDQJpW5LmQK/p2yiua6LdZBS1jtYhl3pIPfRdl6nGn39YHZJSVloEppRm1
 ODQv1um/vmEka6KsnMO6Oh1/878fdj0tg7YvHRqniWs5h4HwBvYdzx6KPxjC5N13i6+i2b9o5fY
 dP3359n59OofD0=
X-Received: by 2002:a05:600c:2b06:b0:493:e583:7053 with SMTP id
 5b1f17b1804b1-49573cf4c3cmr49845485e9.35.1784882718671; 
 Fri, 24 Jul 2026 01:45:18 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-87-0-90-136.retail.telecomitalia.it. [87.0.90.136])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957afac187sm51534245e9.11.2026.07.24.01.45.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 01:45:18 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Fri, 24 Jul 2026 10:45:09 +0200
Subject: [PATCH] arm: mediatek: use phase-aware PSCI reset on MT8188
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-ccaione-upstream-mt8188-spl-reset-v1-1-08da6554ecd8@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNUQrCMBCE4auUfXahiWJXryJ9iOmoK7aGbCpC6
 d2N+vjB8M9ChqwwOjYLZbzU9DlVuE1D8RamK1iHavKt37ed33GMoU7Ac7KSEUYeizgRtvTgDEN
 hCQHo3EH8dqDaSRkXff8+Tv3fNp/viOUbpnX9AEA5DimFAAAA
X-Change-ID: 20260724-ccaione-upstream-mt8188-spl-reset-8aaee719823d
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784882719; x=1785487519;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LAVSrCEpsw0uw3szkMiGzgP74NXkBrOOXaEDJCeZW+0=;
 b=bfYOxn/liv7PNm1C1m67pvZSilhH9FR7Oo/vwR3eKv3gdIjgGRRG4HAhx/EWm7wbwO
 Q3z/Aq0rxqNWdtNh3qGKBhze+EFciAG2XJIZVWCmfWIq4u5Mh2OeKVyNEA9aH6yZOu5F
 T4hXB8PLbbLz3kcLStCeTCjiasbxs/FSvdWDJErO8b/EJdOndEfDJyyKZTKeS771BR1i
 QpInCLs6SyhYqaZkdVvMKUUZruiTeDBsVMejAY8kWMi0Gc/0y5eb5JOitUthBo1EwWqc
 EEA0TWCrSOzXF77r19CvhmahoRqvXe8mgChVJejfHuwoVe5wD31wAl7Ht/cbeWemnN+j
 dpng==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=bfYOxn/l
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

MT8188 reset_cpu() checks the U-Boot proper PSCI symbol even when the
function is built for SPL. A standalone SPL download agent runs before
BL31, so fastboot acknowledges a reboot request and then stalls while
attempting an unavailable PSCI system reset.

Use the phase-aware configuration check so SPL falls back to the
watchdog reset provider. U-Boot proper continues to use PSCI as before.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/mach-mediatek/mt8188/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mediatek/mt8188/init.c b/arch/arm/mach-mediatek/mt8188/init.c
index 1108bc19373..b2cdec8c218 100644
--- a/arch/arm/mach-mediatek/mt8188/init.c
+++ b/arch/arm/mach-mediatek/mt8188/init.c
@@ -33,7 +33,7 @@ void reset_cpu(void)
 {
 	struct udevice *wdt;
 
-	if (IS_ENABLED(CONFIG_PSCI_RESET)) {
+	if (CONFIG_IS_ENABLED(PSCI_RESET)) {
 		psci_system_reset();
 	} else {
 		uclass_first_device(UCLASS_WDT, &wdt);

---
base-commit: d0c49353a648e135f269a2953dc9326505ba87de
change-id: 20260724-ccaione-upstream-mt8188-spl-reset-8aaee719823d

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

