Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B4A8F54AC4
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 14:32:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 900F980212;
	Tue, 24 Mar 2026 15:32:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FAHNjpK3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE214807C0; Tue, 24 Mar 2026 15:32:33 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64F4180087
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 15:32:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7d743cd9e5bso3618130a34.2
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 07:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774362750; x=1774967550;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QsIgYu5LGqupXM9VEJukkUbjQFkW5MYIq9AtuZsHopY=;
 b=FAHNjpK35IsWb9KMCBnoK68CMzYf3BkCFuPle31ZnkMc84sNG6yTVgkDnEm7Pmf9jW
 mIaf5VIZ/kj9Q0UwxnQogdTah/Jur9FH2PgMkxOnp1zpl7lVaoTodONK2l0yD74gLLYG
 PA3AECTHyP+nrSvEmSPXBTOvTwpueCIMtOKMahSr/eRfXuD5pWSYc3XGFCJOp69eJgwu
 dMZNYv9OjRO1CWd6XWnR+1w2tCQi2XP6mx5MV1K2HTFqSHHjEBb6DRsghBxekYHSernd
 zkHddnDUYANvkxKR72Gmnq2rWbO+0mfoQGzVGsPeVQyW98tQWRpu7pdAaGhuOsni7l6t
 AQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774362750; x=1774967550;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QsIgYu5LGqupXM9VEJukkUbjQFkW5MYIq9AtuZsHopY=;
 b=PGV3uafl7URh626a+cYxyQ/hXhFTpB0XvEooLfU6TU7j7oXYLaosuVKjAuDdbWsk9v
 SmxTZD+Y5arqcMdMIVzclF/MNTOE2KibApI1Vg1+/pmXs4vc3Y/cvzgigmRg0WJf+W0f
 yfE5Jds8tBj/GcXVzjuYaEb4YMk2wVITZzmIDrXtwZFHCs0j1qdw5mje6YSR3STtjPHG
 Jcjo9+tKdjgJJ4XKmEociTK0RXlQQTN794T3aRuHEPNwmxG1wSdUywAlFc2XpqlGJPW/
 ydC1suNX8RZjwd5WBDFI/YJhPn8K5pXaxZ8/0vBNHhAA3qrhOiqFxQGdFZGidUJRM2Qe
 6OnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWA9FckjiQHVwzgO/orytIcH3wczbNWmaqwzVL/S0lHvECnXiwZjy96UhxmqikERIWMAn70DsE=@lists.denx.de
X-Gm-Message-State: AOJu0Yz/kdrURndkz6z82WsBVrwyAUSgRepQ5LETACR4A11oD96yxcZF
 ROMYlV99elYFvWcSLh0PWIdwQdcOG5ir+nt5Ww5pHJER26IJirxa8GYiKXfTWfuIUkLZ6PKjfRl
 0HHcQ
X-Gm-Gg: ATEYQzx3erAv4sv6vPf75KosotZyE99KpOAaVlWbo2dMSLw4ECbg/peJrObf2IGhJc9
 5EpzYxJgbtluVQd4xVUtR039z78YpkuNYtd7nNevwe9DmjshHk1URfZXogVjD5dXuBc/2/qK7k/
 m3bFuo1IreMkjT6HVp2TO4Aetr3T+GtooBPXVpIsYJDZE8hUgVAW8srfcCQrYexCPqYU4u0W1iH
 +M/O53OJA4FKVQ7BY1WLjGB2KxSHDqPOdzvsdTi7NN4gSfDdb5DoFsJDZCfpoUU0mgtahzkc3x8
 zw48uvx1MJZ1sD2qt73e6tA8SVMhaqTtWgzOf6uKKK288CWBwkDhx954lPHWQxLx7qPvq4EGxyE
 ZfjoJmbGYOztUf3yK5307RRoYeENteJvsSYMnjPAbgd9snjAW3gNPJf4vabAr7zTOfFUTw1tCwh
 DGKqsTKfH3FMRG2Qua8xQ3WjrrCwg=
X-Received: by 2002:a05:6830:4985:b0:7d7:da1d:4472 with SMTP id
 46e09a7af769-7d7eae57842mr11174287a34.8.1774362749111; 
 Tue, 24 Mar 2026 07:32:29 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:8a85:a776:3f75:a1d])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7eadce96dsm12129652a34.18.2026.03.24.07.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 07:32:28 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20260317-clk-mtk-unify-mux-parents-v3-0-a4760f5b0a80@baylibre.com>
References: <20260317-clk-mtk-unify-mux-parents-v3-0-a4760f5b0a80@baylibre.com>
Subject: Re: [PATCH v3 00/16] clk: mediatek: unify mux clocks
Message-Id: <177436271754.2186727.16177791250237077392.b4-ty@b4>
Date: Tue, 24 Mar 2026 09:31:57 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2467; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=teL8NSFnnDsdQX0fx3Ji0bJNStJdhv40UKsZ2sYb1pw=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpwqB0U4Cx5AM1AkILXsc+MeYBrIQQnwc7ltNCp
 ga38DuX0FuJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCacKgdBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A6OwH/3+nCyoImnyZ4TJFdawxkrFlGc5OTwJPqfL4neW
 rIbAV+bES7YR+a1RocGo2O35zbrQ7G18x3j/Pt3ztViV6iI0hpMDTR4sJqz6jRc1f52dNYYecN/
 ItgwuKQckZqduVCEjwXMC7ZRXzWRYyt15/je6yRavGGrIZ6UlEhdkYfngAkT3lRrku86pqj65KV
 gLleACt8po7A4CUjB17o0G6F3vUhATW4IP6+N3FauqiMBXDFlNQZ2u4wWVDFPNGRW6bZfjVMlAg
 8ObeHG2ZQkHr4uZP/0I3wTPQaOmnI3fOxArEQUW6O/0h432ahv9LVFaO/H3XRmXhUCiW/8IQ5W7
 L4EM=
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

On Tue, 17 Mar 2026 18:23:13 -0500, David Lechner wrote:
> clk: mediatek: unify mux clocks
> 
> The MediaTek clock driver currently have two ways to indicate the parent
> tree that contains the parent clock. This adds to code complexity and
> makes it more difficult to know the "right thing" to do in new drivers.
> 
> The plan here is to convert all mux clocks to use the more robust option
> of using struct mtk_parent to specify parent clocks.
> 
> [...]

Applied to mediatek-for-next, thanks!

[01/16] clk: mediatek: mt7622: convert to struct mtk_parent
        commit: c846980ffbdaba188783d2af4a1d8d7ad67e783e
[02/16] clk: mediatek: mt7623: convert to struct mtk_parent
        commit: 4693dee8c78c1a700c702763d08940755956c3ab
[03/16] clk: mediatek: mt7629: convert to struct mtk_parent
        commit: 06066ccab34108d894359414341da062f810dd80
[04/16] clk: mediatek: mt7981: convert to struct mtk_parent
        commit: 1e70e760e8bc2fe0824cea041bd3022eab7e610c
[05/16] clk: mediatek: mt7987: convert to struct mtk_parent
        commit: a9dd7e267ab2ff462a5b4c60073f382a669ebc6a
[06/16] clk: mediatek: mt7988: convert to struct mtk_parent
        commit: 3ac446ca371c04ee36f114fd0933591e0f1c49a0
[07/16] clk: mediatek: mt8183: convert to struct mtk_parent
        commit: 70e8a11645a9c246808e2e518873965372da5626
[08/16] clk: mediatek: mt8188: convert to struct mtk_parent
        commit: da736d825e2e10c7a6140019e8971ab6148cf25d
[09/16] clk: mediatek: mt8195: convert to struct mtk_parent
        commit: a32728fd4fb1a7abc39461c7ff3835fc504ba2fc
[10/16] clk: mediatek: mt8365: convert to struct mtk_parent
        commit: 791595026ae78abfe08106f37f61b813110afb19
[11/16] clk: mediatek: mt8512: convert to struct mtk_parent
        commit: 3afd6e6859f747bb75d2402974023abb173645cf
[12/16] clk: mediatek: mt8516: convert to struct mtk_parent
        commit: 2b17165ddcae5a41f6d59cb4de18eca6727d4363
[13/16] clk: mediatek: mt8518: convert to struct mtk_parent
        commit: 789687608ac2677ef59a08ce5bdb82108c1e65d0
[14/16] clk: mediatek: remove use of CLK_BYPASS_XTAL flag
        commit: babd92ba57f832c8404ad4ae56554c3f02b35403
[15/16] clk: mediatek: remove CLK_PARENT_MIXED flag
        commit: 309c97dee1a4f58372b9f4861b77cf6b8585a925
[16/16] clk: mediatek: refactor duplicate *_mux_get_rate()
        commit: 738ad722432e271ce278e9aa46e99d64d79880a2

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

