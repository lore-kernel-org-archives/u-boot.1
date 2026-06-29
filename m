Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB54C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 17:05:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC71A84A6E;
	Mon, 29 Jun 2026 19:05:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QQcglbU1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E158084A4C; Mon, 29 Jun 2026 19:05:29 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B77FB84A36
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 19:05:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andreas.zdziarstek@gmail.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-45fd464d51fso2050043f8f.3
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 10:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782752727; x=1783357527; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i2ImVtQUSjoamRevqTWscMpyH/jPFHCoDmDyPkQn2xg=;
 b=QQcglbU1STeb5nwtCr6m1ciT7S9/ZabiLOjNwp0lYwerDyALhdtVHwMX/Ek4Vn6Jea
 n0hmx7o4etCh9G6afOfiuiWB3+f/dDpbv4CyDU2U1ulGsXA0LLPy2xqaowKoFRsGgzYR
 sX4dKIAglJ86VmOKFyjXVNYFghCoQw8IOgbmYK/Bueaphp5k9ugGikpi26v/UaTubSBq
 VoVIo3W+JLGebj0YE/vpGvPj+KdbnfjjTimoT+stkVYqs8Z3AfPpcVWuXORRS8iDMEBh
 c8W+WDINEJ6xzREhHoRp3uUtt4KZH1KlbwMwsT25hERdsmATRIgvah9XJoNRR9yQQTdY
 DPuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782752727; x=1783357527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i2ImVtQUSjoamRevqTWscMpyH/jPFHCoDmDyPkQn2xg=;
 b=FJbwHaXA4V88woza3bRECACfTL6cxSMzZMjFKO2V4l7MT2Bl3KCRrRkQzb4v+pVNcL
 opLJu6NPlXa/wOG3LhhPcr2yNdqeGqgAPYzhfOnDz38iMcj1ROgWwwpNcDWITY6NYHUy
 GqWuBkgOZS2w/vbGy8Jplvn7fX9SX6abyW66hPT3ua8HXAOHjdHygmwHX70WRJGWgCoG
 qwP8vSllw8KH8omSv097DNxw32FOYuM/hQzfJTkrGUZ6pcgTYu/Ql5OGv9mCEdtwEgzZ
 YRQsBPiCpw1tSyTQcabgWTqbIUpplKVLICGySnr7xc9y3WJnncZrrC3VUKK2MaAMg9h1
 U54g==
X-Gm-Message-State: AOJu0YzQQg9AvMks1ohif+KNPjpvHvaEiy22OqMUNYl+8Lay+Mbh57zU
 rKsBeKUwvm0N/2Rm6o7nu/n1bYfN2CBEF5qvAwr0UyttBevCIp25J3c/S3aRqScQ
X-Gm-Gg: AfdE7cmjZN+qR5+P+RbW/inDXndJuHPQ7k205kc0/4D/Nylobbjg+2QUEcteZEugDoO
 QFUiaTXwWgounG2P/iBMZ2ZXpPRlbqQroofgi/y8ZEoiipkHbr5YrLRPWH5PIYfInvPwdjhpuH6
 NlKkO8zMUxLhLo/A0heIbsODJHE4kpn/V1Fya1GvO/o8iXt8ce/72eYkECkVxvgXsMIi2XdXJpI
 k54D7WNOaYWrzI3p3zbt0A5n1IceGGbES5itWKrBql4DF98T2shV8neTiRXQdeDY3g2cn6Wwp12
 eN6viId/7qziP7uyzt4HK3uEzuXppC5As7mMFSDjs6v1A0VcoLYXYhWOrwga4LbLyMhS1r5BdpW
 NS3j0Can0T5bX1hXv7wdXGXIKtA5opNZEbC2wt65cl4abp8BpF9Vaf5ciTMvQXtF+jPxCOlcOyC
 YIAUBvXf43RZLXtoEjOhDF9YtwqjNPk5m4KnhgBEr3m/pIwgIStsh2YIdbPgRPMCQ=
X-Received: by 2002:adf:f20e:0:b0:464:8d68:618a with SMTP id
 ffacd0b85a97d-47552c52849mr8224f8f.32.1782752727151; 
 Mon, 29 Jun 2026 10:05:27 -0700 (PDT)
Received: from turbine.fritz.box (p5784ea85.dip0.t-ipconnect.de.
 [87.132.234.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46cf775a4f0sm41791121f8f.17.2026.06.29.10.05.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 10:05:26 -0700 (PDT)
From: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, jonas@kwiboo.se, quentin.schulz@cherry.de,
 Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
Subject: [PATCH v2 2/3] rockchip: rk3568: make the TSADC trigger a first
 global reset
Date: Mon, 29 Jun 2026 19:05:16 +0200
Message-ID: <20260629170517.1436613-3-andreas.zdziarstek@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260629170517.1436613-1-andreas.zdziarstek@gmail.com>
References: <20260629170517.1436613-1-andreas.zdziarstek@gmail.com>
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

Same rationale as the watchdog: the default second global reset leaves
the SoC hung. Set the TSADC to the first global reset as well, so a
thermal shutdown reliably resets the whole SoC.

Signed-off-by: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
---
 arch/arm/mach-rockchip/rk3568/rk3568.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-rockchip/rk3568/rk3568.c b/arch/arm/mach-rockchip/rk3568/rk3568.c
index 87bd443e9c4..50b61b7cd26 100644
--- a/arch/arm/mach-rockchip/rk3568/rk3568.c
+++ b/arch/arm/mach-rockchip/rk3568/rk3568.c
@@ -40,6 +40,7 @@
 
 #define CRU_BASE		0xfdd20000
 #define WDT_GLB_SRST_CTRL	BIT(1)
+#define TSADC_GLB_SRST_CTRL	BIT(0)
 
 /* PMU_GRF_GPIO0D_IOMUX_L */
 enum {
@@ -156,6 +157,9 @@ int arch_cpu_init(void)
 	/* Make WDT trigger a first global reset */
 	setbits_le32(&cru->glb_rst_con, WDT_GLB_SRST_CTRL);
 
+	/* Make TSADC trigger a first global reset */
+	setbits_le32(&cru->glb_rst_con, TSADC_GLB_SRST_CTRL);
+
 	return 0;
 }
 
-- 
2.53.0

