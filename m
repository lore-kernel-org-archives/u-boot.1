Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 718BBC5DF9C
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 01:02:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9EA2280D1B;
	Tue, 25 Aug 2026 01:01:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M1Xk_EUkcnOV; Tue, 25 Aug 2026 01:01:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787619716;
	bh=3F7kmsX7pbq/rANSh1KQNmI/FW5fO3RtcHVJN8ElAZc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w/ItOWOrWa54gMIzJcmNJhHXvIfYWDSDOJvlEBJ0R0H7e6eTqtTMGs4rleudzOcsM
	 Ll+s2ArPRo94NLsrrLeV/iVNPXCk9o5zfB8SQL0Mi5oqZnXRfDB2R96Y66jalqqWTB
	 0zeS3BHRtCSwckG3a5AJTd8n5iw7UVvF6yPmIAFX6IRcVDKPGeDLk/m/NxYGuwR0r6
	 x9bOLE2y6rgA/4I1t4HqEG7ahgMEu1PkDG7KEhi4ZvFNxFm7fjUcrV3XY4bvkMAw9Z
	 Q77c2K+hZzXtJKn6QQnQooTws6PWvlt79dZQ2TW28DexKwbqfY9N9MCG3Yr+Oqt6Jr
	 T2YOGF/WO7ugA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 68F4E80CE9;
	Tue, 25 Aug 2026 01:01:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A914D336
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 01:01:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8F7094005F
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 01:01:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l35fZCzwbDdy for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 01:01:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::231; helo=mail-oi1-x231.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=fCoLIfRG
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4052B40050
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 01:01:51 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-499f6e0bbabso3492543b6e.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 18:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787619711; x=1788224511;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3F7kmsX7pbq/rANSh1KQNmI/FW5fO3RtcHVJN8ElAZc=;
 b=fCoLIfRGRM0HQKjEGnH8hCQZACuBGO/vixJN4tZASA8ZCjMvuvRX5iUx45H6Iv+qMm
 cpUZoICggl6IcVEKGhon0N1RrvUo7FjKJpvClXntj/JZfBX+ZkM+DEhjbOTl6uoiWE6c
 IzrFINs/w3N0FIWnUAFOvxFM3U32qUjGCm3NWfM+1sajCQrhmAn51l5Ul3V4M0eWob7A
 5FnTBZnKCjfiByPfL8N5xivJ/7uzWUe53kqfW18gpgWCYyxpvNhBLT2NRW4J+AxsxsE5
 hjUvpVevL6L7mQ4NEVe1gkwXqsAJLnX/aZl2PwBxDaHP8k8ndBHPu/D2RBUWluzAVHQl
 XbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787619711; x=1788224511;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3F7kmsX7pbq/rANSh1KQNmI/FW5fO3RtcHVJN8ElAZc=;
 b=rb4alexuc6fulOSpqaImmUXr+/fAUdtNv2i47tHrurwkHxexHLvi7OmQoQrvLUkBC1
 78OMYIeDmbuEtzja83sJAdg39pN3FXuhTfQtohBVbWLHto1eBaxIm5Y3o0AOPtpQ6tZy
 R3cfSZ6pOEiWDsYO/5nmqASudrJQfmmqnNT5XHVo3Uddtthtg4gjHTbvVKj59CYcCLsu
 2ItwcUPaxX1l8sc+ZcNGgmG/AK1ZI0UU35xZabGoHVWEzDzBL7tbR6lZ4Qhur+aw7/UG
 iGm2mSdtMaxbh9kbkG1ZKMj01hxIbDHDF1AR6ebBpm/xrCSQ1o9r9/1p+otlFc7VGeiA
 +j8w==
X-Gm-Message-State: AFuF++mKRUIYUJmO9JcuHCKE/eq3LZUXTx1ONmF5F3nQj0xmQFADjlSy
 h/bkk8thHeBEsRKwYB/+qDYc8f8xucSkU499jduY6JfZuTKfNLGpH1T1EYmM8y7svliirTwaG37
 TPAfneOY=
X-Gm-Gg: AR+sD10KgxVsr74qKdh3MdhbUx5SMY2XNDDkioN4oFGn2h2OURR3AC/hGqFg6omRKv8
 urpgo2P+0flEWVxdwvIoScIMJN/FA0fj+IiUC+7SW31Q7jVZ4kvww60AoSebZlbsqFYE3prHSrC
 1MzfOXc+Sp9oceAblKdfuZguWadIB8/UrP8TH0rOMIXWgyVJJwVcnncc6OGXlsd8FGWw7uY4H1z
 HCxXCst5/u5/QOGBcG1FhfMTDcmvFFGMUfWFVykDd/2HI1G3IpmzfA0CIC2hvTydSW4/8kUSd6v
 aHNMZ7Edyh5QbICDZIBCOvdcAvqRE/Rs8tah6kFe+lxmvC44yzYTr+V1i/Nk0NON6/zsvDOSNjx
 tnI3fKnHBw4yHTTDQr34+lAobQv3rB65RxjK42wsliGaWkN+8npF0Eyc0QcKfGx2ElLRbO8RgjV
 YNpduHE3ytvhWHiMJ3ftsssGaMZQK5k6vlK1u5rWTp9YaGBOuxvmvEsGSHcyIFMrVKV6mMVV0=
X-Received: by 2002:a05:6808:3093:b0:4b3:17ae:16dc with SMTP id
 5614622812f47-4b350470e00mr2782890b6e.9.1787619710595; 
 Mon, 24 Aug 2026 18:01:50 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:29ca:5dba:5fc1:6f13])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b32c834da6sm4652590b6e.12.2026.08.24.18.01.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 18:01:48 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, 
 Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>
In-Reply-To: <20260807-serial-mtk-clock-fixes-v3-0-8cc94d313b57@baylibre.com>
References: <20260807-serial-mtk-clock-fixes-v3-0-8cc94d313b57@baylibre.com>
Subject: Re: [PATCH v3 0/4] serial: mtk: clock rate fixes
Message-Id: <178761964290.2485046.17390999510594404839.b4-ty@b4>
Date: Mon, 24 Aug 2026 20:00:42 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=842; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=O1xQEzWKx9zKW7AiJxvTb1HfwKlXDPcduohxkGHHMlQ=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqjOl1AXet2TtIwEZ8ukQAgTuVRgLEZgd2kdrSj
 +kjR8k/mcSJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaozpdRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A/BwH/RyPDduwwdhhbcbkvQggJZHUI9wh6pahHnlbK2q
 OD6ZBJV9QK0/2FwUmGa4swdkg/Lw2hAk1hrbt0JYqmITS67JwsxiFhAbmP+2c0zuz0zCDDbD7WR
 bDFkoZ/mONaaMhyOesuRweIsaWDvaBwM/SA/zhY2LUxxRlgCqAbz9L/zQ/E2yo4oRZZIsF5s4JI
 w7cvDixOMhbynoheTraz09DGIp3BlcLRetCdx+fw9mOyW8Pl47yLxcKgvyDQj+6funIwgU0Mpgx
 6K0CzhLjge3JHTTr1ayg5WRGMU1hi6PM//DLGySbhZKMw428JGfd1s7qrKBZTbxdS5qR0OlqMLW
 +gNY=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

On Fri, 07 Aug 2026 13:59:38 -0500, David Lechner wrote:
> serial: mtk: clock rate fixes
> 
> While working on SPL support, we noticed a few bugs in the MediaTek
> serial driver related to clock rate handling. Here are the fixes.

Fixed the clk_is_valid() vs. clk_valid() issue while applying.

Applied to mediatek-for-next, thanks!

[1/4] serial: mtk: use ulong for clk_rate
      commit: 50c148cfcaa30a584a827a5b54a2864c5dc8a998
[2/4] serial: mtk: guard clk_get_rate() with clk_valid()
      commit: 71f33b1834f6850d00d844696495333a733c1856
[3/4] serial: mtk: return error value from clk_get_rate()
      commit: be8761822e434d22ea07d3568b16f0ae68619bdb
[4/4] serial: mtk: drop check before clk_bus enable
      commit: c42e44689b8c07aee616e7cc03bc92d756b8dfb5

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

