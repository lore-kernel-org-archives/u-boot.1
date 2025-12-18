Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C22ED6E2B1
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 17:18:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 052F2800AB;
	Thu, 18 Dec 2025 18:18:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ziPv79Nj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C85D836A3; Thu, 18 Dec 2025 18:18:08 +0100 (CET)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B58E80077
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 18:18:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-3e80c483a13so539872fac.2
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 09:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766078284; x=1766683084;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eox0s6RATSzOm5+dz2c8/Saa5Pi51aOubqsTjX5Ktuk=;
 b=ziPv79NjQEEG6UhC/Gc3nBFTEn3nI9j7a2lSX+XVTtC+KQJ4ds284hqv97OOBLxFNt
 Obam7F4zAs3E7Wsojsi+fmHfHAiO3Azt+lIGE+i+ohl5VYl/wku/4b1yu1o5sH7ejOsq
 rBwPsYpu0hH+XTzcssSUVwq6rYMHnRDmW1LfkAW6vBSJJRtMQgcUV/rBLYANR/tellKx
 j38+RGu761M1Nh6l7AmNH/dT1shHPb045MZSEOhOJINmA6Bz7SvG5Hvr9duySW5EFpkK
 LI3/Azt/FYFFJ8jYYDuqzGgO9Gqz1rUPA+NwtIR/PLdMNWNvocw7zpHaY7knwbclhOg2
 mbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766078284; x=1766683084;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eox0s6RATSzOm5+dz2c8/Saa5Pi51aOubqsTjX5Ktuk=;
 b=ekjcPD5TqTX3z1sTgU+O9RhKtW1h2MTkymdQE82aSraDv3EuONziTSiKFVLiGcwuFP
 SbJN2cD98eBKAfquHfYvUHjoODzQqr8O4G43KruAwVJwW8IZmmwuHWz90JS6GB2R8kdA
 IfGf0Oxl6uwjdv98G1Fs10bJjZg9pLE/gq6KTDFOLbu8lyYBQr21lzo1SHfjkwZjrFyI
 Vf/oencl6FNIUgObpMsG27BQ90bryhoXjpdUIrU3yBLL3/WU9k0Lkjf0D7KpH8G3joid
 +cN9PY//hix9vBX68NQUJTLir9ZgisJzu8Yu5wy82lFxJiq/WmWwm/m/1U8vXvO1cbz1
 zYqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2Tdscpk5efPCQ8fnipbbCkxGbfDJlTvHpslVthi2ejv4Q+eniXnCVotjHPXp8bkqab8TXt3o=@lists.denx.de
X-Gm-Message-State: AOJu0Yxb3zgl3jlfJ8Uf9i5R4C0uswlGFNxyRB4dgQWkBEAudIwLUxhL
 nFAQdNCcEZxO/Mu6uxg/szLM/wILpRBa2KfPhlV8vpFYjyZg2tsU9SlurH0tQOpxEr8=
X-Gm-Gg: AY/fxX43ZnOF4PwCFDYencIhUbQt/3Zk6sWyrab4ocu4UvdZeIXmfvECChPafTaTTQs
 FYeAmJks6sa7UStjbi0yxCVlj4wMKMQcaGifzRrkQc7jOpJzJ+Nf14nSmphorKJpd2r9x5lG+0e
 rfzSS5wI5DzxDz+7WH0i5hm7D0JgS44pQKZTkmpZGTwyfD7BOSM+7ne+NPlDRskZtaQgzVz+AmQ
 xouMmYg58wV0rGaJMzvdnIlVLNpcuEXxCEIfk0YfhG7MXqMpE1R1whJQAo0i8BQneSvFjl9B0cy
 ZGxc8hzReVbSSdCSgI6SzxTPefUFUuWl5/iij57f+4pNPIqmPJbXk90RHZTNQYz+fcHaBsQhf3k
 xxHo6XBTJkTYAi3VobShCQ8K9VmtecJkIwc4YzdtQyUgaBAZC6yXvRAyM5xo6CT4kkmgsbwX7Xi
 KWnYgO/vp56HOSF2FFT1Gkwv1Z4g==
X-Google-Smtp-Source: AGHT+IGd3DQsNLq5XZzZYej7wM4mMaDME2D6Vz7njfSqPXHAI8GbIZnV2rkAU2852kv/Q2iM0MkVRw==
X-Received: by 2002:a05:6820:1c89:b0:65b:3857:b830 with SMTP id
 006d021491bc7-65d0eae0caemr89353eaf.56.1766078283776; 
 Thu, 18 Dec 2025 09:18:03 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:e5ea:76dc:e589:2d5e])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65cff214d66sm1316372eaf.9.2025.12.18.09.18.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 09:18:03 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/8] clk: mediatek: implement of_xlate and dump
Date: Thu, 18 Dec 2025 11:16:58 -0600
Message-Id: <20251218-clk-mtk-improvements-v1-0-72db131ba148@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22OQW6DMBBFr4K87rQM4EBQVOUeUVQZPCQjYpvah
 qaKcve6oeqmXb6R/ntzE4E8UxBtdhOeFg7sbAJ8ykR/VvZEwDqxKPJCYoES+ssIJo7AZvJuIUM
 2BtBd3m016hKxFGk6eRr4+tAejit7ep+TPa5HYSgE9bC32e5Hjr/yNAY9TzApn/ygXQ8LAkKFD
 W70thkaWe879XnhztNz78zrd/U/Zw7KG9DpR0OaVaQRwgfH/pw6TbmREB244W2eQvSkzJqpscS
 aZK4rrP5mOhUIEhiObeY8n9i+WLpGcbzfvwCEFD+7UAEAAA==
X-Change-ID: 20251215-clk-mtk-improvements-db0b9d1d3113
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=21101;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=HIhmLuXmiGcK7Pff9yFyux886ocd6dc93IVlTiugDrs=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpRDcPqeYYTAz5WZZFVTspAZi1QKCb2mRcHmnV7
 WKHkLeLrKqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaUQ3DxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ASLIH/iGfQhLpU/pojMQiAICDnXGL0YKu3ZYvbjTMq8t
 tx60oaKuA/KVcdyCo5x/28RhS47v7DGN5VgvBV/9K5ts9pbw09wp98NIP4UtGZ9R1teJVBeO19O
 +AA5I+tJrM1ChsxHFRFEgEaiRQHaVPvJew/nBunBZWNjNJUss/8PA7mB8XI8JQQmd7UaV4T0nGc
 9UNTxzUv3EB/wEIZs+HVgON+9TXi9naiPUeWSVmWiv5vx/rSI7ClGzzfh2hf/VUKtXDVVpBGgnW
 3PqgdhxqJN2DvozMnr9Ubwl//ysG0SOG8mfUjSU8aDrEEE2urZvDusIqiEeRnIZXTd/8mxiWMgM
 7pR0=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Thu, 18 Dec 2025 18:18:40 +0100
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

I started looking into fixing some bugs in the mt8365 clock driver and
realized that there was no way to inspect or debug the clock trees.

I set out to implement the dump function to help with this. The driver
architecture didn't make this easy since there was no way to know the
number of elements in each of the clock arrays. The first few patches
in this series are adding fields to the data structures to hold this
information.

Once that was fixed, I was still getting crashes due to other bugs. To
work around this, I implemented the of_xlate function to validate clk
IDs as early as possible and return errors instead of crashing when
requested IDs are invalid. This also makes use of the new size fields
to prevent out of bounds array accesses. There is one driver that remaps
IDs, so there are a few extra patches to handle that as well.

Then finally, I was able to implement the dump function to print out the
clock tree information without crashing. Below is an example of the
output. As you can see, it shows that there are quite a few obvious bugs
(denoted by error!) in the mt8365 clock driver that need to be fixed.
The additional information can also be used to check for more subtle
bugs such as incorrect parent clocks, dividers, multipliers, etc.
These will be addressed in a separate series.

=> clk dump
 Rate               Usecnt      Name
------------------------------------------
 26000000             0        |-- oscillator
 13000000             0        |-- dummy13m

mt8365-topckgen syscon@10000000:
Parent device: mt8365-apmixedsys syscon@1000c000
[FCLK0] DT: 0, Rate: 0 Hz, Parent: default-0
[FCLK1] DT: 1, Rate: 26000000 Hz, Parent: default-0
[FCLK2] DT: 2, Rate: 75000000 Hz, Parent: default-141
[FCLK3] DT: 3, Rate: 75000000 Hz, Parent: default-141
[FCLK4] DT: 4, Rate: 52500000 Hz, Parent: default-141
[FDIV0] DT: 52, (error! should be 6), Rate: 699999695 Hz, Parent: apmixedsys-0, Mult: 1, Div: 2
[FDIV1] DT: 6, (error! should be 7), Rate: 546000000 Hz, Parent: apmixedsys-1, Mult: 1, Div: 2
[FDIV2] DT: 7, (error! should be 8), Rate: 273000000 Hz, Parent: apmixedsys-1, Mult: 1, Div: 4
[FDIV3] DT: 8, (error! should be 9), Rate: 136500000 Hz, Parent: apmixedsys-1, Mult: 1, Div: 8
[FDIV4] DT: 9, (error! should be 10), Rate: 68250000 Hz, Parent: apmixedsys-1, Mult: 1, Div: 16
[FDIV5] DT: 10, (error! should be 11), Rate: 34125000 Hz, Parent: apmixedsys-1, Mult: 1, Div: 32
[FDIV6] DT: 11, (error! should be 12), Rate: 364000000 Hz, Parent: apmixedsys-1, Mult: 1, Div: 3
[FDIV7] DT: 12, (error! should be 13), Rate: 182000000 Hz, Parent: apmixedsys-1, Mult: 1, Div: 6
[FDIV8] DT: 13, (error! should be 14), Rate: 91000000 Hz, Parent: apmixedsys-1, Mult: 1, Div: 12
[FDIV9] DT: 14, (error! should be 15), Rate: 45500000 Hz, Parent: apmixedsys-1, Mult: 1, Div: 24
[FDIV10] DT: 15, (error! should be 16), Rate: 218400000 Hz, Parent: apmixedsys-1, Mult: 1, Div: 5
[FDIV11] DT: 16, (error! should be 17), Rate: 109200000 Hz, Parent: apmixedsys-1, Mult: 1, Div: 10
[FDIV12] DT: 17, (error! should be 18), Rate: 54600000 Hz, Parent: apmixedsys-1, Mult: 1, Div: 20
[FDIV13] DT: 18, (error! should be 19), Rate: 156000000 Hz, Parent: apmixedsys-1, Mult: 1, Div: 7
[FDIV14] DT: 19, (error! should be 20), Rate: 78000000 Hz, Parent: apmixedsys-1, Mult: 1, Div: 14
[FDIV15] DT: 20, (error! should be 21), Rate: 39000000 Hz, Parent: apmixedsys-1, Mult: 1, Div: 28
[FDIV16] DT: 21, (error! should be 22), error! clk_get_rate() failed: -2, Parent: apmixedsys-11, Mult: 1, Div: 2
[FDIV17] DT: 22, (error! should be 23), Rate: 1248000000 Hz, Parent: apmixedsys-2, Mult: 1, Div: 2
[FDIV18] DT: 23, (error! should be 24), Rate: 624000000 Hz, Parent: apmixedsys-2, Mult: 1, Div: 4
[FDIV19] DT: 24, (error! should be 25), Rate: 312000000 Hz, Parent: apmixedsys-2, Mult: 1, Div: 8
[FDIV20] DT: 25, (error! should be 26), Rate: 832000000 Hz, Parent: apmixedsys-2, Mult: 1, Div: 3
[FDIV21] DT: 26, (error! should be 27), Rate: 416000000 Hz, Parent: apmixedsys-2, Mult: 1, Div: 6
[FDIV22] DT: 27, (error! should be 28), Rate: 208000000 Hz, Parent: apmixedsys-2, Mult: 1, Div: 12
[FDIV23] DT: 28, (error! should be 29), Rate: 104000000 Hz, Parent: apmixedsys-2, Mult: 1, Div: 24
[FDIV24] DT: 29, (error! should be 30), Rate: 26000000 Hz, Parent: apmixedsys-2, Mult: 1, Div: 96
[FDIV25] DT: 30, (error! should be 31), Rate: 499200000 Hz, Parent: apmixedsys-2, Mult: 1, Div: 5
[FDIV26] DT: 31, (error! should be 32), Rate: 249600000 Hz, Parent: apmixedsys-2, Mult: 1, Div: 10
[FDIV27] DT: 32, (error! should be 33), Rate: 124800000 Hz, Parent: apmixedsys-2, Mult: 1, Div: 20
[FDIV28] DT: 33, (error! should be 34), Rate: 456999909 Hz, Parent: apmixedsys-5, Mult: 1, Div: 1
[FDIV29] DT: 34, (error! should be 35), Rate: 228499954 Hz, Parent: apmixedsys-5, Mult: 1, Div: 2
[FDIV30] DT: 5, (error! should be 36), Rate: 450000031 Hz, Parent: apmixedsys-3, Mult: 1, Div: 1
[FDIV31] DT: 35, (error! should be 37), Rate: 149999977 Hz, Parent: apmixedsys-8, Mult: 1, Div: 2
[FDIV32] DT: 36, (error! should be 38), Rate: 74999988 Hz, Parent: apmixedsys-8, Mult: 1, Div: 4
[FDIV33] DT: 37, (error! should be 39), Rate: 37499994 Hz, Parent: apmixedsys-8, Mult: 1, Div: 8
[FDIV34] DT: 38, (error! should be 40), Rate: 18749997 Hz, Parent: apmixedsys-8, Mult: 1, Div: 16
[FDIV35] DT: 39, (error! should be 41), error! clk_get_rate() failed: -2, Parent: apmixedsys-12, Mult: 1, Div: 13
[FDIV36] DT: 40, (error! should be 42), error! clk_get_rate() failed: -2, Parent: apmixedsys-39, Mult: 1, Div: 4
[FDIV37] DT: 41, (error! should be 43), error! clk_get_rate() failed: -2, Parent: apmixedsys-39, Mult: 1, Div: 8
[FDIV38] DT: 42, (error! should be 44), error! clk_get_rate() failed: -2, Parent: apmixedsys-39, Mult: 1, Div: 16
[FDIV39] DT: 43, (error! should be 45), error! clk_get_rate() failed: -2, Parent: apmixedsys-39, Mult: 1, Div: 32
[FDIV40] DT: 44, (error! should be 46), Rate: 180633600 Hz, Parent: apmixedsys-6, Mult: 1, Div: 1
[FDIV41] DT: 45, (error! should be 47), Rate: 90316800 Hz, Parent: apmixedsys-6, Mult: 1, Div: 2
[FDIV42] DT: 46, (error! should be 48), Rate: 45158400 Hz, Parent: apmixedsys-6, Mult: 1, Div: 4
[FDIV43] DT: 47, (error! should be 49), Rate: 22579200 Hz, Parent: apmixedsys-6, Mult: 1, Div: 8
[FDIV44] DT: 48, (error! should be 50), Rate: 196608001 Hz, Parent: apmixedsys-7, Mult: 1, Div: 1
[FDIV45] DT: 49, (error! should be 51), Rate: 98304000 Hz, Parent: apmixedsys-7, Mult: 1, Div: 2
[FDIV46] DT: 50, (error! should be 52), Rate: 49152000 Hz, Parent: apmixedsys-7, Mult: 1, Div: 4
[FDIV47] DT: 51, (error! should be 53), Rate: 24576000 Hz, Parent: apmixedsys-7, Mult: 1, Div: 8
[FDIV48] DT: 53, (error! should be 54), Rate: 390000000 Hz, Parent: apmixedsys-4, Mult: 1, Div: 1
[FDIV49] DT: 54, (error! should be 55), Rate: 195000000 Hz, Parent: apmixedsys-4, Mult: 1, Div: 2
[FDIV50] DT: 55, (error! should be 56), Rate: 599999909 Hz, Parent: apmixedsys-9, Mult: 1, Div: 1
[FDIV51] DT: 56, (error! should be 57), Rate: 299999954 Hz, Parent: apmixedsys-9, Mult: 1, Div: 2
[FDIV52] DT: 57, (error! should be 58), Rate: 149999977 Hz, Parent: apmixedsys-9, Mult: 1, Div: 4
[FDIV53] DT: 58, (error! should be 59), Rate: 74999988 Hz, Parent: apmixedsys-9, Mult: 1, Div: 8
[FDIV54] DT: 59, (error! should be 60), Rate: 624000000 Hz, Parent: apmixedsys-10, Mult: 1, Div: 1
[FDIV55] DT: 60, (error! should be 61), Rate: 54600000 Hz, Parent: apmixedsys-0, Mult: 1, Div: 52
[MUX0] DT: 61, Rate: 54600000 Hz, Parents: default-141/*default-18*/default-8/default-16
[MUX1] DT: 62, Rate: 124800000 Hz, Parents: default-141/*default-33*/default-11/default-7
[MUX2] DT: 63, Rate: 124800000 Hz, Parents: default-141/*default-33*/default-7/default-15/default-8/default-30/default-23/default-34
[MUX3] DT: 64, Rate: 312000000 Hz, Parents: default-141/default-19/default-26/default-7/default-23/default-11/*default-25*
[MUX4] DT: 65, error! clk_get_rate() failed: -2, Parents: default-141/*default-5*/default-11/default-25
[MUX5] DT: 66, Rate: 546000000 Hz, Parents: default-141/default-8/*default-7*
[MUX6] DT: 67, Rate: 208000000 Hz, Parents: default-141/default-41/*default-28*/default-40/default-29/default-42/default-43
[MUX7] DT: 68, Rate: 208000000 Hz, Parents: default-141/default-41/*default-28*/default-40/default-29/default-42/default-43
[MUX8] DT: 69, error! clk_get_rate() failed: -2, Parents: *default-141*/default-28
[MUX9] DT: 70, Rate: 832000000 Hz, Parents: default-141/*default-26*/default-27/default-28
[MUX10] DT: 71, Rate: 546000000 Hz, Parents: default-141/*default-7*/default-24/default-12
[MUX11] DT: 72, Rate: 546000000 Hz, Parents: default-141/*default-7*/default-24/default-12
[MUX12] DT: 73, Rate: 24576000 Hz, Parents: default-141/*default-53*/default-23/default-7/default-30/default-12/default-24/default-19
[MUX13] DT: 74, Rate: 24576000 Hz, Parents: default-141/*default-53*/default-25/default-23/default-7/default-26/default-12/default-24
[MUX14] DT: 75, Rate: 832000000 Hz, Parents: default-141/default-54/*default-26*/default-12/default-24/default-8/default-13/default-28
[MUX15] DT: 76, Rate: 109200000 Hz, Parents: default-141/*default-17*/default-20/default-10
[MUX16] DT: 77, Rate: 273000000 Hz, Parents: default-141/*default-8*/default-19
[MUX17] DT: 78, error! clk_get_rate() failed: -2, Parents: default-141/*default-44*
[MUX18] DT: 79, Rate: 45158400 Hz, Parents: default-141/*default-48*
[MUX19] DT: 80, Rate: 90316800 Hz, Parents: default-141/default-45/default-46/*default-47*
[MUX20] DT: 81, Rate: 98304000 Hz, Parents: default-141/default-49/default-50/*default-51*
[MUX21] DT: 82, error! clk_get_rate() failed: -2, Parents: default-141/*default-22*
[MUX22] DT: 83, Rate: 416000000 Hz, Parents: default-141/*default-27*
[MUX23] DT: 84, Rate: 546000000 Hz, Parents: default-141/*default-7*/default-8/default-9
[MUX24] DT: 85, Rate: 499200000 Hz, Parents: default-141/default-32/default-27/*default-31*
[MUX25] DT: 86, Rate: 499200000 Hz, Parents: default-141/default-32/default-27/*default-31*
[MUX26] DT: 87, Rate: 136500000 Hz, Parents: default-141/*default-9*
[MUX27] DT: 88, Rate: 499200000 Hz, Parents: default-141/default-32/*default-31*/default-9/default-14
[MUX28] DT: 89, Rate: 136500000 Hz, Parents: default-141/default-32/*default-9*
[MUX29] DT: 90, Rate: 1248000000 Hz, Parents: default-141/default-24/*default-23*/default-26
[MUX30] DT: 91, Rate: 24576000 Hz, Parents: default-141/*default-53*/default-25/default-26/default-23/default-7
[MUX31] DT: 92, Rate: 832000000 Hz, Parents: default-141/default-24/default-23/*default-26*
[MUX32] DT: 93, error! clk_get_rate() failed: -2, Parents: *default-141*/default-35/default-36/default-37/default-38
[MUX33] DT: 94, Rate: 228499954 Hz, Parents: default-141/*default-35*/default-36/default-37/default-38
[MUX34] DT: 95, Rate: 195000000 Hz, Parents: default-141/default-52/*default-55*/default-56/default-57/default-58
[MUX35] DT: 96, Rate: 34125000 Hz, Parents: default-141/default-12/default-18/*default-11*/default-13/default-54/default-23/default-30
[MUX36] DT: 97, Rate: 1248000000 Hz, Parents: default-141/default-19/default-27/default-18/*default-23*/default-7/default-26/default-15
[MUX37] DT: 98, Rate: 1248000000 Hz, Parents: default-141/default-26/*default-23*/default-25/default-6
[MUX38] DT: 99, Rate: 156000000 Hz, Parents: default-141/default-28/default-20/default-9/*default-19*
[MUX39] DT: 100, Rate: 34125000 Hz, Parents: default-141/default-25/default-26/*default-11*/default-12
[MUX40] DT: 101, Rate: 832000000 Hz, Parents: default-141/*default-26*/default-12
[MUX41] DT: 102, error! clk_get_rate() failed: -2, Parents: default-141/*default-22*/default-10/default-33/default-11/default-23/default-7/default-8
[MUX42] DT: 103, error! clk_get_rate() failed: -2, Parents: default-141/*default-22*/default-10/default-33/default-11/default-23/default-7/default-8

mt8365-topckgen-cg sysconx@10000000:
Parent device: mt8365-topckgen syscon@10000000
[GATE0] DT: 136, (error! should be 0), error! clk_get_rate() failed: -2, Parent: topckgen-142
[GATE1] DT: 137, (error! should be 1), error! clk_get_rate() failed: -2, Parent: topckgen-141
[GATE2] DT: 138, (error! should be 2), error! clk_get_rate() failed: -2, Parent: topckgen-142
[GATE3] DT: 139, (error! should be 3), error! clk_get_rate() failed: -2, Parent: topckgen-141
[GATE4] DT: 130, (error! should be 4), Rate: 18749997 Hz, Parent: topckgen-40
[GATE5] DT: 131, (error! should be 5), Rate: 18749997 Hz, Parent: topckgen-40
[GATE6] DT: 132, (error! should be 6), Rate: 52500000 Hz, Parent: topckgen-4
[GATE7] DT: 133, (error! should be 7), Rate: 75000000 Hz, Parent: topckgen-3
[GATE8] DT: 134, (error! should be 8), Rate: 0 Hz, Parent: topckgen-0
[GATE9] DT: 135, (error! should be 9), Rate: 0 Hz, Parent: topckgen-0
[GATE10] DT: 121, (error! should be 10), error! clk_get_rate() failed: -2, Parent: topckgen-112
[GATE11] DT: 122, (error! should be 11), error! clk_get_rate() failed: -2, Parent: topckgen-113
[GATE12] DT: 123, (error! should be 12), error! clk_get_rate() failed: -2, Parent: topckgen-114
[GATE13] DT: 124, (error! should be 13), error! clk_get_rate() failed: -2, Parent: topckgen-115
[GATE14] DT: 125, (error! should be 14), error! clk_get_rate() failed: -2, Parent: topckgen-116
[GATE15] DT: 126, (error! should be 15), error! clk_get_rate() failed: -2, Parent: topckgen-117
[GATE16] DT: 127, (error! should be 16), error! clk_get_rate() failed: -2, Parent: topckgen-118
[GATE17] DT: 128, (error! should be 17), error! clk_get_rate() failed: -2, Parent: topckgen-119
[GATE18] DT: 129, (error! should be 18), error! clk_get_rate() failed: -2, Parent: topckgen-120

mt8365-infracfg syscon@10001000:
Parent device: mt8365-topckgen syscon@10000000
[GATE0] DT: 0, error! clk_get_rate() failed: -2, Parent: topckgen-141
[GATE1] DT: 1, error! clk_get_rate() failed: -2, Parent: topckgen-141
[GATE2] DT: 2, error! clk_get_rate() failed: -2, Parent: topckgen-141
[GATE3] DT: 3, error! clk_get_rate() failed: -2, Parent: topckgen-141
[GATE4] DT: 4, Rate: 54600000 Hz, Parent: topckgen-61
[GATE5] DT: 5, Rate: 54600000 Hz, Parent: topckgen-61
[GATE6] DT: 6, Rate: 54600000 Hz, Parent: topckgen-61
[GATE7] DT: 7, Rate: 54600000 Hz, Parent: topckgen-61
[GATE8] DT: 8, Rate: 136500000 Hz, Parent: topckgen-89
[GATE9] DT: 9, Rate: 136500000 Hz, Parent: topckgen-89
[GATE10] DT: 10, Rate: 136500000 Hz, Parent: topckgen-89
[GATE11] DT: 11, Rate: 136500000 Hz, Parent: topckgen-89
[GATE12] DT: 12, Rate: 136500000 Hz, Parent: topckgen-89
[GATE13] DT: 13, Rate: 136500000 Hz, Parent: topckgen-89
[GATE14] DT: 14, error! clk_get_rate() failed: -2, Parent: topckgen-69
[GATE15] DT: 15, error! clk_get_rate() failed: -2, Parent: topckgen-69
[GATE16] DT: 16, error! clk_get_rate() failed: -2, Parent: topckgen-69
[GATE17] DT: 17, error! clk_get_rate() failed: -2, Parent: topckgen-69
[GATE18] DT: 18, error! clk_get_rate() failed: -2, Parent: topckgen-141
[GATE19] DT: 19, Rate: 54600000 Hz, Parent: topckgen-61
[GATE20] DT: 20, Rate: 54600000 Hz, Parent: topckgen-61
[GATE21] DT: 21, Rate: 832000000 Hz, Parent: topckgen-70
[GATE22] DT: 22, Rate: 546000000 Hz, Parent: topckgen-71
[GATE23] DT: 23, Rate: 546000000 Hz, Parent: topckgen-72
[GATE24] DT: 24, Rate: 54600000 Hz, Parent: topckgen-61
[GATE25] DT: 25, error! clk_get_rate() failed: -2, Parent: topckgen-141
[GATE26] DT: 26, Rate: 54600000 Hz, Parent: topckgen-61
[GATE27] DT: 27, Rate: 54600000 Hz, Parent: topckgen-61
[GATE28] DT: 28, error! clk_get_rate() failed: -2, Parent: topckgen-141
[GATE29] DT: 30, (error! should be 29), error! clk_get_rate() failed: -2, Parent: topckgen-141
[GATE30] DT: 31, (error! should be 30), Rate: 54600000 Hz, Parent: topckgen-61
[GATE31] DT: 32, (error! should be 31), Rate: 54600000 Hz, Parent: topckgen-61
[GATE32] DT: 33, (error! should be 32), Rate: 54600000 Hz, Parent: topckgen-61
[GATE33] DT: 34, (error! should be 33), Rate: 136500000 Hz, Parent: topckgen-89
[GATE34] DT: 35, (error! should be 34), Rate: 416000000 Hz, Parent: topckgen-83
[GATE35] DT: 36, (error! should be 35), error! clk_get_rate() failed: -2, Parent: topckgen-141
[GATE36] DT: 37, (error! should be 36), Rate: 54600000 Hz, Parent: topckgen-61
[GATE37] DT: 38, (error! should be 37), Rate: 24576000 Hz, Parent: topckgen-73
[GATE38] DT: 39, (error! should be 38), Rate: 24576000 Hz, Parent: topckgen-73
[GATE39] DT: 40, (error! should be 39), Rate: 24576000 Hz, Parent: topckgen-73
[GATE40] DT: 41, (error! should be 40), Rate: 24576000 Hz, Parent: topckgen-73
[GATE41] DT: 42, (error! should be 41), Rate: 24576000 Hz, Parent: topckgen-73
[GATE42] DT: 43, (error! should be 42), Rate: 24576000 Hz, Parent: topckgen-73
[GATE43] DT: 44, (error! should be 43), Rate: 832000000 Hz, Parent: topckgen-75
[GATE44] DT: 45, (error! should be 44), Rate: 24576000 Hz, Parent: topckgen-74
[GATE45] DT: 46, (error! should be 45), error! clk_get_rate() failed: -2, Parent: topckgen-141
[GATE46] DT: 47, (error! should be 46), error! clk_get_rate() failed: -2, Parent: topckgen-141
[GATE47] DT: 48, (error! should be 47), error! clk_get_rate() failed: -2, Parent: topckgen-141
[GATE48] DT: 50, (error! should be 48), error! clk_get_rate() failed: -2, Parent: topckgen-141
[GATE49] DT: 51, (error! should be 49), error! clk_get_rate() failed: -2, Parent: topckgen-142
[GATE50] DT: 52, (error! should be 50), Rate: 499200000 Hz, Parent: topckgen-88
[GATE51] DT: 53, (error! should be 51), Rate: 499200000 Hz, Parent: topckgen-88
[GATE52] DT: 54, (error! should be 52), Rate: 499200000 Hz, Parent: topckgen-88
[GATE53] DT: 55, (error! should be 53), Rate: 499200000 Hz, Parent: topckgen-88
[GATE54] DT: 56, (error! should be 54), Rate: 54600000 Hz, Parent: topckgen-61
[GATE55] DT: 57, (error! should be 55), Rate: 54600000 Hz, Parent: topckgen-61
[GATE56] DT: 58, (error! should be 56), Rate: 54600000 Hz, Parent: topckgen-61
[GATE57] DT: 59, (error! should be 57), Rate: 1248000000 Hz, Parent: topckgen-97
[GATE58] DT: 61, (error! should be 58), Rate: 34125000 Hz, Parent: topckgen-96
[GATE59] DT: 60, (error! should be 59), Rate: 34125000 Hz, Parent: topckgen-96
[GATE60] DT: 62, (error! should be 60), Rate: 54600000 Hz, Parent: topckgen-61
[GATE61] DT: 63, (error! should be 61), Rate: 54600000 Hz, Parent: topckgen-61
[GATE62] DT: 64, (error! should be 62), Rate: 54600000 Hz, Parent: topckgen-61
[GATE63] DT: 65, (error! should be 63), Rate: 54600000 Hz, Parent: topckgen-61
[GATE64] DT: 66, (error! should be 64), Rate: 54600000 Hz, Parent: topckgen-61
[GATE65] DT: 67, (error! should be 65), Rate: 54600000 Hz, Parent: topckgen-61
[GATE66] DT: 68, (error! should be 66), Rate: 499200000 Hz, Parent: topckgen-85
[GATE67] DT: 69, (error! should be 67), Rate: 499200000 Hz, Parent: topckgen-85
[GATE68] DT: 70, (error! should be 68), Rate: 499200000 Hz, Parent: topckgen-86

mt8365-apmixedsys syscon@1000c000:
Parent device: mt8365-apmixedsys syscon@1000c000
[PLL0] DT: 0, Rate: 1399999390 Hz
[PLL1] DT: 1, Rate: 1092000000 Hz
[PLL2] DT: 2, Rate: 2496000000 Hz
[PLL3] DT: 3, Rate: 450000031 Hz
[PLL4] DT: 4, Rate: 390000000 Hz
[PLL5] DT: 5, Rate: 456999909 Hz
[PLL6] DT: 6, Rate: 180633600 Hz
[PLL7] DT: 7, Rate: 196608001 Hz
[PLL8] DT: 8, Rate: 299999955 Hz
[PLL9] DT: 9, Rate: 599999909 Hz
[PLL10] DT: 10, Rate: 624000000 Hz

---
David Lechner (8):
      clk: mediatek: add array size fields to clk trees
      clk: mediatek: add array size fields to cg gates
      clk: mediatek: add array size field for id_offs_map
      clk: mediatek: organize infrasys functions
      clk: mediatek: add of_xlate ops
      clk: mediatek: clarify mapped vs. unmapped ID
      clk: mediatek: mt7623: set unmapped IDs to -1
      clk: mediatek: implement dump callbacks

 drivers/clk/mediatek/clk-mt7622.c |  21 +-
 drivers/clk/mediatek/clk-mt7623.c |  24 +-
 drivers/clk/mediatek/clk-mt7629.c |  23 +-
 drivers/clk/mediatek/clk-mt7981.c |  13 +-
 drivers/clk/mediatek/clk-mt7986.c |  11 +-
 drivers/clk/mediatek/clk-mt7987.c |   9 +-
 drivers/clk/mediatek/clk-mt7988.c |  18 +-
 drivers/clk/mediatek/clk-mt8183.c |   7 +-
 drivers/clk/mediatek/clk-mt8365.c |  10 +-
 drivers/clk/mediatek/clk-mt8512.c |  10 +-
 drivers/clk/mediatek/clk-mt8516.c |   7 +-
 drivers/clk/mediatek/clk-mt8518.c |   7 +-
 drivers/clk/mediatek/clk-mtk.c    | 669 +++++++++++++++++++++++++++++---------
 drivers/clk/mediatek/clk-mtk.h    |  43 ++-
 14 files changed, 675 insertions(+), 197 deletions(-)
---
base-commit: 930eff5416ea98ebd09cec73f5d06a7033b4d52e
change-id: 20251215-clk-mtk-improvements-db0b9d1d3113
prerequisite-message-id: <20251211-clk-mtk-fix-dup-parent-doc-v1-1-41816d98f857@baylibre.com>
prerequisite-patch-id: 2ae6231f7dcfd6fb770d0633c3feb5ee2a3dab1a
prerequisite-message-id: <20251210-arm-dts-mediatek-switch-mt8365-to-of_upstream-v1-1-71317e50d414@baylibre.com>
prerequisite-patch-id: 3520ac6a30d21a4efac14c4d2cae0d72912f9f13

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

