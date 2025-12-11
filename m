Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9737D43356
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 21:20:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07F4583837;
	Thu, 11 Dec 2025 22:20:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yY1fjCVh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D0AC83837; Thu, 11 Dec 2025 21:17:34 +0100 (CET)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65FF683106
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 21:17:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-3f5ba2fc0d1so196994fac.3
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 12:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765484251; x=1766089051;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6Nd0LmCwA99EvIK8VHuuIhlC01BPTrrxetMYPRNjNBQ=;
 b=yY1fjCVhNi5x2bVXKfPLfDX2iW0WiGBq5p0If5EJhqK6KXw0MBRp88vlffHlEGjxol
 qFmvpwfKoUCcRpQhImMU3lWM4h1E0FrgcMQYPIlfoyziJTINn8LYoE2yUpVcMga0DZp/
 vn0iCB21PVvP0C0PnTkhbikVZPDqjOzPfq0PSnb5yao/FBBY7qzVgELO8RcVht75v/3V
 e+9t5xGZ0HHj5RWohrRkadA6D965f7aAFMZ5AIoOQ8gcNs6Rb0L97X73OghZESoJXQbw
 CXY6IKScq4QRg+eTDhqZdSSnzTfzRR5m3HDlCK87cie2tnkjBDdZR8d03GzEapRyi+lg
 efDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765484251; x=1766089051;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6Nd0LmCwA99EvIK8VHuuIhlC01BPTrrxetMYPRNjNBQ=;
 b=fi0yMpmQi+pUHMcDcvqpPKcwgIaS6BDBynHGMiuCRuOgekKtwKyNF0M3pI2EMmBfrH
 ++JMw1KVQ5Fw+MpYYAUH6ahuCt4gDB8K3UAwrJi1oC6Rp+Qp6GI4/ZUXqxd1U4cMLqoA
 76gllBqfWcvwhx5lwg/aMpq0ogBQpyHY6OGAEXcIrmUXeuzZigmyGCysjC9G5Sy2goBE
 2zelyWkFmJKki+seRQxkTIchTOzTHL9/d9bfo0uMjtkqJC1h4ursKDSdPp2Vn7gXnft/
 At/6UJ9sE/t5Sez4kwmC1YxBq7oImeB3IKFvfo7XxJL3akqCqXgu/DRmIvdLW9L1Y1JH
 TwOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXANN5tFutXN+LtkxSxaJC1T2Xe80s+BbU3wKyNxpg7icyKV3ywyc37BjUfqsWxjGUZBnF8pLI=@lists.denx.de
X-Gm-Message-State: AOJu0YxL6jd1zyj6y7LOwSXWlh8zf9hKkNHc42nnFR1t0qghEA9wRKka
 mMWzPqcIcnWQUD/VZWNK7ts1LCux4EE9URQfCzrF74I3oB4e/Wds3bJUMvvlTh+U3Nw=
X-Gm-Gg: AY/fxX5E2bcJDA9okNee3WsbcgM9UsxxwVdvuzYoqHpiNxvSEH+4qyqQDv8lrO7t3pC
 9Nthl2YzvSCocsnchgpF455gBSsYhQtu9huG0oivSoQy73cjozrWoVR6uUgnTrQDbd5b0SE8YQF
 sjimJV5OqxsjfkxjGCgr5mEGfrccKxjwMSlmbyTFnIYbkKV28G0NDaEgIe1Yeww9p2hZ5K27p4l
 rBYs3ZH18vHwUqlN1m4HHd1rkDoTDKujn+skULbG8gd6MbLOBQQ7tSfmkhKVFYuMpHJzm9eOKSQ
 TlzABioN5wxRkhz537JmUDvJojI2yhQ9F8oEYQUKH0rftaNGIy288/esMRnoLiJEu18YY6R6gUw
 OsMCoAAQOsA+NezAhCYPKLAEuisVCgT6xT1Eu5vG6Wp9HVFZZhYXuiTSIwPe03qz/0KBrZ7qQUU
 LYxUD0aCNZIIjjUOn0PR+vopDOyqCrO/KexUpQcTtHdG4q0XnY8IpJA8Jt1euP
X-Google-Smtp-Source: AGHT+IEFvsXRQ/gWgq6/ON9PAmm5EnNDomahOJcoRy7NzRwzUgPCKsoeMRTJmezREFAj9kQtsux/jQ==
X-Received: by 2002:a05:6871:413:b0:3d2:cf03:54f3 with SMTP id
 586e51a60fabf-3f5bd7dc98amr4170379fac.3.1765484250958; 
 Thu, 11 Dec 2025 12:17:30 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:1635:b560:bfdd:f758?
 ([2600:8803:e7e4:500:1635:b560:bfdd:f758])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f5d5156631sm2205157fac.19.2025.12.11.12.17.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 12:17:30 -0800 (PST)
Message-ID: <6f9237e4-3313-4eeb-92e9-cda520e97f51@baylibre.com>
Date: Thu, 11 Dec 2025 14:17:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] clk: mediatek: add MT8188 clock driver
From: David Lechner <dlechner@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Stefan Roese <stefan.roese@mailbox.org>, Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, Yao Zi <ziyao@disroot.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Sumit Garg <sumit.garg@kernel.org>, Julien Masson <jmasson@baylibre.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Sam Shih <sam.shih@mediatek.com>, Ian Roberts <ian.roberts@timesys.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Heiko Schocher <hs@nabladev.com>, =?UTF-8?Q?Duje_Mihanovi=C4=87?=
 <duje@dujemihanovic.xyz>
References: <20251209-add-mt8188-support-v2-0-31dbfcf7303c@baylibre.com>
 <20251209-add-mt8188-support-v2-2-31dbfcf7303c@baylibre.com>
 <878qf95s5q.fsf@kernel.org>
 <6bf9671d-c70b-41ae-b8b0-ec303dfed484@baylibre.com>
Content-Language: en-US
In-Reply-To: <6bf9671d-c70b-41ae-b8b0-ec303dfed484@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 11 Dec 2025 22:20:27 +0100
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

On 12/11/25 11:55 AM, David Lechner wrote:

...

> PLL clocks
> ----------
> 
> This is just a guess, but I suspect in Linux, since CLK_TOP_ADSPPL is
> just a 1:1 divider clock of CLK_APMIXED_ADSPPLL, they took the shortcut
> of leaving out CLK_TOP_ADSPPL from the clock tree and set the parent
> of CLK_TOP_ADSPPLL_Dx to CLK_APMIXED_ADSPPLL instead of CLK_TOP_ADSPPLL.
> 
> The actual full picture should be like this:
> 
> 	77, /* CLK_TOP_ADSPPLL */
> 
> 	...
> 
> 	FACTOR0(CLK_TOP_ADSPPL, CLK_APMIXED_ADSPPLL, 1, 1),
> 	FACTOR0(CLK_TOP_ADSPPLL_D2, CLK_TOP_ADSPPL, 1, 2),
> 	FACTOR0(CLK_TOP_ADSPPLL_D4, CLK_TOP_ADSPPL, 1, 4),
> 	FACTOR0(CLK_TOP_ADSPPLL_D8, CLK_TOP_ADSPPL, 1, 8),

Correction:

 	FACTOR0(CLK_TOP_ADSPPL, CLK_APMIXED_ADSPPLL, 1, 1),
 	FACTOR1(CLK_TOP_ADSPPLL_D2, CLK_TOP_ADSPPL, 1, 2),
 	FACTOR1(CLK_TOP_ADSPPLL_D4, CLK_TOP_ADSPPL, 1, 4),
 	FACTOR1(CLK_TOP_ADSPPLL_D8, CLK_TOP_ADSPPL, 1, 8),

FACTOR0() means the 2nd argument is a APMIXED clock ID and
FACTOR1() means the 2nd argument is a TOPCKGEN clock ID.

> 
> Instead of:
> 	
> 	-1, /* CLK_TOP_ADSPPLL */
> 
> 	...
> 
> 	FACTOR0(CLK_TOP_ADSPPLL_D2, CLK_APMIXED_ADSPPLL, 1, 2),
> 	FACTOR0(CLK_TOP_ADSPPLL_D4, CLK_APMIXED_ADSPPLL, 1, 4),
> 	FACTOR0(CLK_TOP_ADSPPLL_D8, CLK_APMIXED_ADSPPLL, 1, 8),
> 
> So we could either follow Linux and use CLK_APMIXED_ADSPPLL everywhere
> instead of adding CLK_TOP_ADSPPL. Or we could be more correct and add
> the missing clocks.
> 
