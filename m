Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D591105F7BA
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 15:21:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 356DD84370;
	Fri, 13 Mar 2026 16:20:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="H4Jz46pR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 879048436C; Fri, 13 Mar 2026 16:20:57 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 410828438A
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 16:20:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-466ebbf7ff7so856602b6e.1
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 08:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773415254; x=1774020054;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lNi8ymfobvmg8CvyLkljL0GPXqtLonIN8AijeIhjp6A=;
 b=H4Jz46pRDZPXt9PjQqGQATtq2/XDCG8JDFelP++fVKqeAhOzg1TLGjAkkdEL7UlI/x
 937aM5Y/Jcc0Na6VZdY1it79blAHJVSHe3wOU/kCm0xgqoQhBhnwbnRG7FOe1Liq2IPa
 K6it+AcKpR0TktZXiKG5SauWaH9g9Bdl/477h4knJc3xrTV7JjkkKx6birmlCiFRAjD8
 en7frbF9oa6RHaORKAqq0B6tIpG/F5oxmXyaS4rTlkdlUseOM6Wqg/CWXRY7GWiJKRYy
 8UpZyhr1JxN73wznwHnTAM2YiFmGYi9n2Kx5gnfYvI6IT90HdgEAcYzIkEE7frYGogl9
 5e5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773415254; x=1774020054;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lNi8ymfobvmg8CvyLkljL0GPXqtLonIN8AijeIhjp6A=;
 b=TasOg5k2O4AWms7ErmzdLLSBKH6OS5S/fWcI1hsh6vxtt7O0G4DtGKD4siMXK9HBd7
 zx3zvQphmFthRs0R5VpMvM1aXAz9GCLw9YOGBHh0xWmcesYAGPnO16fpjIN91h0H8g+M
 lXRm118CwoN0OeKw12xDCZyhVVKVP+Oz8I81OmNHgVw1Cn8XE7rMct8uy3UVx0akIkiW
 FxgKRioySI8AE0iyYC+/XHvMFRqPqTexMUjBWi4+7KKqwh3qpJXJMuFDzRrmlMq7FraR
 k96tCkFfeSB+ZU9mnvJVa88fHHUPx6XGCzeFYCuT5gn/JZbuf1ykV02Oy2IiDuEiwN02
 U5Zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNcYSieJez0GCSj5Cjmw9q2DX5fnanQzihJN9umNqpIU8KyolfIJPC33eq1P0gZHf8f4RWYuk=@lists.denx.de
X-Gm-Message-State: AOJu0YwX2Kc/QC20zYWKzxdGL4NSU1QfBl9t4dVP3hdAuhbGKF5Y18vm
 y2KdQtbAsgZMYfM8CnpP/zr2FZdyLHPzaHNGCHoByXVLYBryrACXlnHIvss/ouyPA79aSbU9sY5
 teong
X-Gm-Gg: ATEYQzwsG4YUEAcw6VY8wVtC2amNwEL1jmVyrpMRyWxhe7eDFQ0LAn2VOxDaRdV39fb
 fWLz+h95mr9aMoKzV9tT+1OqKtmyl51EYklJ8b+hw99qUX7E8V/04c5aU9PyCDYBjCrzcJQEiLR
 umADR9RdtjLSXVqqT+JTd6ZmfSmG8L1+bPlNFsI5HMcA/PGOCgg1QjPIm5isjn8geVw2uXXmd2o
 UPrerHeEF4vaDAw5tK2QsJkkHM9iJEzHeoEbaPQghY2ur4ctYKTmTzOl2fpxU5VnTKPfkeEE6NO
 V2idccgAoNknAZ8Z8yE6gGL8s/Uy0wA3sGXhfbhQaY5D+EUdukZAliSPo4Jod352lbTYyibs9Xn
 ms1hpz8tkNZooqHk6i0vzuhZY4lIklFOl5VFDH9cA7znNSwM17snnnop6IyqRWOZDEZaoKA6FOc
 9QCBGsnA16dos05/4uvFWHJwQN+rqNedXqku5LOdllT3Lc4I5vYU3LDFr6A0zC/kpsKg==
X-Received: by 2002:a05:6808:1203:b0:467:32c1:acf1 with SMTP id
 5614622812f47-467572f2d47mr1673969b6e.39.1773415253944; 
 Fri, 13 Mar 2026 08:20:53 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:bf:9982:ff59:466?
 ([2600:8803:e7e4:500:bf:9982:ff59:466])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-417a2372b13sm4961368fac.10.2026.03.13.08.20.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 08:20:53 -0700 (PDT)
Message-ID: <e90dde67-8881-4b0e-97a7-e0ec01c502dc@baylibre.com>
Date: Fri, 13 Mar 2026 10:20:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/16] clk: mediatek: replace xtal2_rate with struct
 mtk_parent
To: Julien Stephan <jstephan@baylibre.com>
Cc: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260310-clk-mtk-parent-cleanup-v1-0-66175ca8f637@baylibre.com>
 <20260310-clk-mtk-parent-cleanup-v1-1-66175ca8f637@baylibre.com>
 <CAEHHSvak-Ebscv7u7STNYOp05o33sUbGsB6bSbhyVrwFu13o+w@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAEHHSvak-Ebscv7u7STNYOp05o33sUbGsB6bSbhyVrwFu13o+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 3/13/26 9:49 AM, Julien Stephan wrote:
> Le mar. 10 mars 2026 à 16:34, David Lechner <dlechner@baylibre.com> a écrit :
>>
>> Replace the hard-coded xtal rate for PLL parents with struct mtk_parent.
>>
>> This avoids declaring the same clock rate in multiple places and will
>> allow future drivers to use an arbitrary clock.
>>
>> The variable is renamed to something that better indicate what the field
>> is actually used for.
>>

...

>> +enum {
>> +       CLK_PAD_CLK26M,
>> +};
>> +
> 
> Can we define these enum values in a common header?
> For example, CLK_PAD_CLK26M is defined in various different soc
> specific drivers.

I would rather not, they depend on which external clocks are available
on a specific MCU. So they will rarely be the same. As you will see
in the later patches, more are added and they aren't always the same.
And the values need to be sequential for the lookup array, so we can't
have one enum that works for all SoCs.

> Also clk-mt8189.c uses defines instead of enum, so maybe we should
> stay consistent.

Hmm... I did that one first before I established the pattern. The values
are arbitrary, which is why I went with the enum here. I can clean that
up when I apply the patches.

> 
>> +static const ulong ext_clock_rates[] = {
>> +       [CLK_PAD_CLK26M] = 26 * MHZ,
>> +};
>> +
