Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E06F53D73
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 16:45:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96B6B840CF;
	Mon, 16 Mar 2026 17:45:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Iiqh0eYH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 119B884105; Mon, 16 Mar 2026 17:45:07 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09A9084088
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 17:45:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-46704177543so3153878b6e.2
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 09:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773679503; x=1774284303;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kK3+gcLHIDS/kooUI7fCs2ncXiMP/rL+kkad4UiiPxs=;
 b=Iiqh0eYH5KgtVZ0Jth4Blrx7DP4+0B2MvBC0nKMklF7INe5ryK0DLuC9NBjT8HubRE
 oZZaVOxeL3qNUOLhfQdHHVpjYLCrFoERiEyTwt4uH5QipefyZ9LP/oWLJnGKiaCxpk6J
 JZCmGnl4MnHQJEBigWu37fCDPyCiGlUzBgS/WelnA9bUd9wfvVk6jILqi6O1MDgs+8qx
 ZaMNYLvghosu68s1TInpXfHnoYOvKfMGewQGEB7OZ8byyZE/Ws6jXzFm0NIBZ4Kt78N5
 VZO9Ib3YOaPGOGiaeTfeODfRMcCA39sQuo11PduXwK5VYV1jqYwN8SuWeKb4nEJseSnX
 R4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773679503; x=1774284303;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kK3+gcLHIDS/kooUI7fCs2ncXiMP/rL+kkad4UiiPxs=;
 b=jzJjaUf0hDZ70soGdO6jAliSHY8940bhhwNweWdjPgI8LzAshjtCJ//VajKTeGIfN3
 4/46Pp5XRoKmV0vgL74mxoZERgoFSJ3PwEz+aX5jARPoOzjlsP9hUXCI0d7KLBwkOtjC
 90Gnu96nFQzX+ZLxLihYeNiDcYfmr5Bd6Ql4BK9p8iTLdNAGMJOXUguxNUuxVLuQXxTa
 zBi3Bhhqv8Z/H1EZT8oRxlPsgipI/dnBVHSh/rQPdhmUH9XeDyhCRhTJ5AQHoC3I8N/L
 OPsTY61KRUI40d09/PP7OyVYT3MHTdUHd4A2riM6SePCOTN7MLDQvPou2yOS9pSHDc6B
 3uvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvJDkp4UkkcHNnlBAuzJOWgTDMb2EZ0Tatn8ofmXizonCey4y78AFYu7ctylEHudgvuG32qjI=@lists.denx.de
X-Gm-Message-State: AOJu0YzONqIyy9GMplAhTwHPcLnsrkueVZBCQVxjYFdhuk+RZ2nXULVd
 PYOYxrr+QycHuEJn9Epy46HOFbWbVZ6n2YckqRKoU7YY7jyUfVnLNqjTJ4bY7QLpguU=
X-Gm-Gg: ATEYQzxlysTNN9VXdR051yEW3u6CtBVp+ODbym32EBqDJJ7Y8UDeZzQQ0mL4srdt2RU
 gQYCIaaf5FdFg7FGgbtZWtUXMLflPAN+BWU8TJb38f6wk/rGyO6dlKxbCjgvTWV83l2Krwlilrv
 djPP071j0vcem29Ljmy2DIGnPOKj/PdYSQ98qwGU3fPSd+IZqNwVACenAwT5UPT7AH7TZK1fAAa
 WkAtsx1rsx9KCkb3vVSFZ01bJytiI8kbTCvVR3bjCG8GUixrxr1zT/Qp/592QzKJMCcH+iatcIM
 7XCbiB6I179OxVkroibsf1mMsXSp4CScp1wpOxe/zxq96H+fpk8mdidr6vkxZ4fSGioFKIP+fDc
 IeiqIPe5VSNE3MUp8DHGMDIU2XHHxaLKbZ1JScjhD4p3llT7kLYTmQGkXY1nNL0EgN26bkpixvK
 G5wm4V57AcGdwqWuP7ZqzRwzk/YMcjFpWI6v8nht3DUwk1t5SJSaVk1HAJlFXVFLhvqU22k+CzP
 g==
X-Received: by 2002:a05:6808:6ec3:b0:450:42c9:4cd0 with SMTP id
 5614622812f47-4675742b4eamr7841207b6e.49.1773679502503; 
 Mon, 16 Mar 2026 09:45:02 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e504:a034:1152:a664?
 ([2600:8803:e7e4:500:e504:a034:1152:a664])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-46744873a6asm8498119b6e.9.2026.03.16.09.45.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2026 09:45:02 -0700 (PDT)
Message-ID: <1551e090-9731-44cf-8729-292837ec1c1b@baylibre.com>
Date: Mon, 16 Mar 2026 11:45:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/13] clk: mediatek: unify mux clocks
To: Julien Stephan <jstephan@baylibre.com>
Cc: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Macpaul Lin <macpaul.lin@mediatek.com>
References: <20260309-clk-mtk-unify-mux-parents-v2-0-b084ea74b99d@baylibre.com>
 <CAEHHSvZ5=-wm7J0e5RHsw3zx9KSQJEHZXa+ypuVuhQXWiNjoFA@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAEHHSvZ5=-wm7J0e5RHsw3zx9KSQJEHZXa+ypuVuhQXWiNjoFA@mail.gmail.com>
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

On 3/16/26 4:59 AM, Julien Stephan wrote:
> Le lun. 9 mars 2026 à 22:29, David Lechner <dlechner@baylibre.com> a écrit :
>>
>> The MediaTek clock driver currently have two ways to indicate the parent
>> tree that contains the parent clock. This adds to code complexity and
>> makes it more difficult to know the "right thing" to do in new drivers.
>>
>> The plan here is to convert all mux clocks to use the more robust option
>> of using struct mtk_parent to specify parent clocks. Then we can remove
>> dead and duplicate code and macros.
>>
>> The conversion to the static const struct mtk_parent arrays was done
>> by script to minimize the chance of error (and save time).
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>> Changes in v2:
>> - Rebased on updated dependencies.
>> - Link to v1: https://lore.kernel.org/r/20260302-clk-mtk-unify-mux-parents-v1-0-32f45085f4d0@baylibre.com
>>
>> ---
>> David Lechner (13):
>>       clk: mediatek: mt7622: convert to struct mtk_parent
> 
> Hello David,
> 
> Is there a reason to have 2 different series to convert to struct mtk_parent?
> You are already doing this kind of cleanup in [1]. Can we merge into
> one single series? Specifically we end up doing this cleanup into two
> commits for mt7622..
> 
> [1]: https://patchwork.ozlabs.org/project/uboot/cover/20260306-clk-mtk-remove-clk-bypass-xtal-flag-v2-0-b253b49f17b2@baylibre.com/
> 
The reason is that I didn't plan ahead so well. :-/

I didn't know that I was going to make these changes when I sent the
other series.

I suppose we could move the other patches to this series and swap the
order of the series.
