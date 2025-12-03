Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE864D12D6F
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 14:47:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C29684006;
	Wed,  3 Dec 2025 15:46:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yqOjshbx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 830FB80077; Wed,  3 Dec 2025 11:19:55 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54FF1828A2
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 11:19:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-64162c04f90so12041350a12.0
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 02:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764757190; x=1765361990;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hXbWKDMbdjk8MVQ+e63xtDOVjiplIyEx1SXPsLeInKc=;
 b=yqOjshbxw/9kEmjLo673FFuVtG/izDDXYTOT6abIZ9qfv9PCcNk2DJMknmTALlXKWg
 yEwt/6HlfMmf/cIdhnmPVRJQP6EFtY3MSEfohWgiFUIKrNoVBmUS2XBGP1rFj/FBTcx2
 qPFmMUbn7haRDWihRHHrL5g91kgyesx9H60I17pM8L4KX7QyZtgb17OvimIcOJL0S8XY
 DwKpXjYsup7XCo70c9o6ZsgsJ0IRq/lUOuFtwCZhfkh2pq1/8YBhg5/gBphjg/RqRHy/
 FlSvI9dEHipski/tH8oINs2XdcyvDfHmiKS1bGsokG9LzbVDGk6uSbr2dDlesKGOucDU
 dQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764757190; x=1765361990;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hXbWKDMbdjk8MVQ+e63xtDOVjiplIyEx1SXPsLeInKc=;
 b=wJ271d92bEbHK2IDtQtGZrdux/74eFwJMlTqbxSAzSUIHBuv/GHvhiav0x9di1AWRS
 nNrOm2fzinxU5U4iaXc2WvMRUvno4M/oqLVyTHZXdMtvuDP7kiGybuDqo4dKql9QpRFz
 KAY+NetdF/fRzb9jPE0s9u07CYUfk2h+yHNth+xGmcwaW9F2ac7BHTwYnumG7TpnrkIY
 oL7Wz4JjdYMd3Ty3yLCzthpmDx0nt5aiybFmWIEfbhwv2WEOyMXMpFqOrJ0bpo7w13QT
 ZQxIUsm+Th1Sb6R8MSWv0XiAWY96pWOHxMTooaaj4Kq4pq1fG3t8e7C1J8CyUdxsKgrx
 wlEw==
X-Gm-Message-State: AOJu0Yy3qkbXLuMtcpF7X20okLJwEpD5YwB/PI/LNky3wmIjJyIr1QQ7
 4O52SK9Mn8+uLLxp/RbMjuZMcUmuyf8WfU10ILr62ONMoHXFVUc1NYOyNVCfmz2P9y0=
X-Gm-Gg: ASbGnctjeQ9pxGQXdd9MZB0N/ZpUZ1zdPJRATaK7ly5s1mz1oRGhX65nVhEjAoY/zT8
 fYOgPN2y4Jfiett+vUcUBnfNg6Avmh9sq5Q36CA/p40sG5V10D9eVF9YjoD6LoXfzjbU8xP06B7
 CIrL+c1lnRFAD7rxxKZUegAEpIEvdFfrIhJZZfycPBFYv8ayS4sF7E6Y+pw3RToYyaUFmi+ePvN
 Hu8Wyd2uHKE150+Blv3EjHyr5lGIeLPBgxF+sB7Ct5mO2w/V5xR2aCxk26AgIlgHBPCsx+f7npM
 k8tEPAXpdY8vBdkZO6oLfo9s605OAudrudz+rA+4kVV8swE7KQNs3T/QWFcG/rsDmV89Naf3xlJ
 uOY/wzR7Yis986ljlFr6iZK4UTG11FYkFvD0n5MbmxHJI7cxCm+jF4Ty6etCTehKDKH1e5lrVDC
 UlIKdJBfA=
X-Google-Smtp-Source: AGHT+IEYkG3H28AT2S6ZeuzFFiVFedklOfNPw33UenD8UQTPsBgXlkRRp9I1MGAKEGrdiF1TCjryyA==
X-Received: by 2002:a05:6402:5209:b0:641:54ce:1bf9 with SMTP id
 4fb4d7f45d1cf-6479c47c2f9mr1322125a12.14.1764757189776; 
 Wed, 03 Dec 2025 02:19:49 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64750a6ea4csm18123928a12.4.2025.12.03.02.19.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Dec 2025 02:19:49 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Wed, 03 Dec 2025 11:19:10 +0100
Subject: [PATCH v2 1/4] panel: Add missing comment for the timing argument
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-topic-am33-evm-lcd-v2026-01-v2-1-262cf4f34eb5@baylibre.com>
References: <20251203-topic-am33-evm-lcd-v2026-01-v2-0-262cf4f34eb5@baylibre.com>
In-Reply-To: <20251203-topic-am33-evm-lcd-v2026-01-v2-0-262cf4f34eb5@baylibre.com>
To: u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Yannick Fertre <yannick.fertre@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Sukrut Bellary <sbellary@baylibre.com>, Fabio Estevam <festevam@gmail.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1062; i=msp@baylibre.com;
 h=from:subject:message-id; bh=jjaf2QtdpNs0Zdz6W+uBGfcOJaKY+u0CY4SpeCu2MWk=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkwDvg1eucz/P7xcwmkWfLkjyuRXZxWvv7ekyQ7/R17Hw
 2577nXpKGVhEONikBVTZOlMDE37L7/zWPKiZZth5rAygQxh4OIUgIl8lWNkeChu9KlHobk2d6Gf
 1kXO5Wrcq1ZXcbfO+Hi4evbC+OadBxkZ1h+WmLziQIbYytaiA3Mued9iV5jDfvHVhJM2M1qULjJ
 M4QUA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Wed, 03 Dec 2025 15:46:17 +0100
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

For completeness add it.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 include/panel.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/panel.h b/include/panel.h
index ab417bc91ed1d23aadc64e861bb721418199fb0f..6c5e2c000fc79f271876daa179455f16da5bc3af 100644
--- a/include/panel.h
+++ b/include/panel.h
@@ -29,7 +29,7 @@ struct panel_ops {
 	 * get_timings() - Get display timings from panel.
 	 *
 	 * @dev:	Panel device containing the display timings
-	 * @tim:	Place to put timings
+	 * @timining:	Pointer to the timing for storing
 	 * @return 0 if OK, -ve on error
 	 */
 	int (*get_display_timing)(struct udevice *dev,
@@ -60,6 +60,7 @@ int panel_set_backlight(struct udevice *dev, int percent);
  * panel_get_display_timing() - Get display timings from panel.
  *
  * @dev:	Panel device containing the display timings
+ * @timing:	Pointer to the timing for storing
  * Return: 0 if OK, -ve on error
  */
 int panel_get_display_timing(struct udevice *dev,

-- 
2.51.0

