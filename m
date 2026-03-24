Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1013F54AC4
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 14:37:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F26080212;
	Tue, 24 Mar 2026 15:37:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UVVtkS2D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8953982A9E; Tue, 24 Mar 2026 15:37:33 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BCDA80087
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 15:37:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7d7fdb922a5so3079830a34.3
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 07:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774363050; x=1774967850;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2+dSDaFt7cZtKIJtLDuFZPPUCHWEaf+feei3h8Ec1fA=;
 b=UVVtkS2DI3J23MR2NqblqKizb+NtTNXEVr8Sqvp7cTa07VOPJbTQtVqgoa+eRi3aG/
 bxobi+w69ehoEn1EecFoFRrMtPNaNrOaJ7SxSL6/pgcQWLgSYOXnSvsmi2mF+2pswdBC
 zSLa1OE/eXWbNo/RpiJL4N684HmTfv2KjCx61nTZAN6gRtL7aXyMCZTVYjKw4CGSmxUP
 iSLqhzv/OeuMk1j00/64oEiocLQAj7/qXFNpb/iTCj6d669wRAEwTNiPcXiKw0HA0hiI
 GfqLkLSyZnKlCAJeOqv4R/O15omuOAaEz+IyduXFJNBLh2z9AhJfSh5TXCcM/b1WIfP3
 hVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774363050; x=1774967850;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2+dSDaFt7cZtKIJtLDuFZPPUCHWEaf+feei3h8Ec1fA=;
 b=gucebylqxV4V9OdBK4IPOtyvlUly3Tt6AIi7H+q+Tiss1uWkUMcgyMjx/oGcY5Wblc
 odW71uJpf2O0jWIXrA1OwJcpBeSlh6abJ2q8/fbCvlIC7QF816rEP0NlYtv1pyn71EzG
 qg03LcSIHUb6iq/VYRygl/rfG/7ZaD3yvw+CXAZ60k4uTDSKfW6giF17qLDzd9vAKMtJ
 x5d6FblHphhHHo/QXJzK5ElTEUYolTjW+YhdjMaLXi3wZTwyNXo3zRSUaa+qjRCobss2
 9qKcUdICRSVz1lMnJaSMnL2RFhOcPrMMXgUqStVd/dJ5Z05GDRGxB8L5OMIUAKIXptej
 FAig==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkEEGve/kZRVOCO6eh4y6Kthrk3+JItCKbvCrbQeY3/Sn6cMhoHujQu8dHIknLAGEQIJpuuFA=@lists.denx.de
X-Gm-Message-State: AOJu0Yzq2+w7tNnxGa++JdpP7EBTgT9sYnpi5faZ1PcI8sGhbgib+gDW
 7MX8u2tS6gc61khQIR0TavTPNUMSZRtKmo/tnmgkRBWKmKQ9QEeq1QNaxD5ylWwpbCqszdZHNTC
 vzvTy
X-Gm-Gg: ATEYQzyZvqFAGZkN6yakwn7sOmwN41iX2fHil8VCTE4c2HCnquj2ENks8PqibEoSxP1
 6kxATSC35uv9X+0MJp8spgRztw1bREMMd86M08R6BSM5I5Jh5MiZylEJXOOxyQatc5fCeQQFylh
 78o9gG0SSUJAO7M8+D1bLQHArDXfPK8XHILWn0T9AQYk9AddtqH7e5/RAsdftQ3rCsPXWhZK77U
 ifwJ8tuZEJXTQMWCPH0zde/2EDS+6C2UbQRAd424e3uMyJKb7wOeUdRV9lWRV/NJF7OX5H3d0pq
 GUrFLA6RgGgSDz2Pyx6hCHrSNr05JJ0dZ1uoEV1md4GE2A5kFzi4BuNvDLocYQc83fjVyHpu3TX
 AgR1a0xDKl7SpH5EGVN+s8l1QGNps2N0RloE5CNLttP/94Z7G9eJvMv4Jmv1Js4bVS7gOx6YeUl
 ZZWuY+0CeywKonRFJGH62tR5dmJxs=
X-Received: by 2002:a05:6830:6f88:b0:7d7:cb13:3fef with SMTP id
 46e09a7af769-7d7eaf9abccmr10775409a34.20.1774363050050; 
 Tue, 24 Mar 2026 07:37:30 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:8a85:a776:3f75:a1d])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7fbee2c6dsm9534208a34.1.2026.03.24.07.37.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 07:37:29 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20260303-mtk-clk-8365-drop-map-v1-1-17f81c375290@baylibre.com>
References: <20260303-mtk-clk-8365-drop-map-v1-1-17f81c375290@baylibre.com>
Subject: Re: [PATCH] clk: mediatek: mt8365: drop topckgen map
Message-Id: <177436303839.2186727.18214912334910121056.b4-ty@b4>
Date: Tue, 24 Mar 2026 09:37:18 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=310; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=tLfHUWwtzxiv5+NL2/uq0BEXORjitdszdr+zDuOk4UA=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpwqGhCzXVoknE2bVhS+l+6OPyszgcOO0Q79MpK
 MHnyJQCtwmJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCacKhoRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ArIwH/1V8j/u+s1z/9Po4HRrEoOlOOVdkdqu3CDmA3rp
 ebhQn7MpxgsJblxeXfcoZXiHu8ceHjJoai4ghcaWRa/BaBkD5UNuvBnapxzF5d8FMsQ0jAu9M4S
 eoOS5t0Vug3m/8RHhLnOPhE+TBXQsRhy8noB87hsUtrsZOZAG0HIr2uBl1Qe9VNyNIZ6hBZAjvS
 0sOQVbtcpc9UKkvo/XwRW1JxigQJYZP2UfTLoad2UkiaeBROHrdsvQxMhlDqMiwJ5deQ95nQf/U
 E3Wsa1tJPa7JA3hL9dAmSCYB656ijntXg6903TNvRAbHVgMs3slUtXGN0lr9YfIuMhiegJNvzZp
 bDao=
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

On Tue, 03 Mar 2026 16:17:47 -0600, David Lechner wrote:
> clk: mediatek: mt8365: drop topckgen map

Applied to mediatek-for-next, thanks!

[1/1] clk: mediatek: mt8365: drop topckgen map
      commit: f017d8fe9dbb6693b9938735a23162b7f1a156de

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

