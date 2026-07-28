Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F66BC54F4D
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 16:04:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B6299608D9;
	Tue, 28 Jul 2026 16:04:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3YyDLqiGyPV4; Tue, 28 Jul 2026 16:04:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 27E5C6088F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785254687;
	bh=sgje5h0JJ/yY8Raju0bjbeR8Va1/H0hRQQwOXteHqVw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N6uTM6P1ZPUoVJzoNf6tM0jhv6Ov1Y7Rq+Kq4YSIMBzOYVSzwTrhUqwTWPZCGVe/6
	 g6dE90f4f40DJvJ0RUBZKoVPWo6v1hBsOKo57JDyTNlGauRZM/fm/uSz/K1UQIxDfr
	 YHkaB72wanrTzJFtx7Aq0axCFvcloRrpF+rvBJk7pkd4pr9UZ7rlMfX6ptpUgaCcZI
	 YuuQ556A8wqV7aYefDUUD0+iC9GZnJbghm8k6plL66RSRPFNx5+3NpBtHKehOWMZX+
	 3QCWJyK5Xr7ff54xTE03BB3qrmY1NJyqKQm1P9R8HMcZHACdD9AOh5jlYB7eGx6nOz
	 0DDERYLGyoWQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 27E5C6088F;
	Tue, 28 Jul 2026 16:04:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1EF2A490
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 16:04:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 10D3E4094D
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 16:04:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1InON9zicBPX for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 16:04:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::336; helo=mail-ot1-x336.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org EAEDC408BC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EAEDC408BC
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EAEDC408BC
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 16:04:44 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7ec1e9d3359so45484a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:04:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785254684; x=1785859484;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sgje5h0JJ/yY8Raju0bjbeR8Va1/H0hRQQwOXteHqVw=;
 b=dB2ZHMwcJy1wXSysqNZSEPiDxi+xSnSJf0871Kz+auoXfPlbcmKIWShpePXm6pJbsS
 JfHY5w27V6h/Ej681+edepVw/c2m4UFnwPFz+1nyNCD4FrVvlXPj+Avp5kDR8vmxZ7Az
 PiyxEJOgp583wGVooPFDUoBt98GstcDJOxzMOvNUrItq3hgQqzWYug6TYoZklHGK/FPd
 k1EbcneXT8Ms0ba2hYnLxG9T09vjm9c48HUxuPxK6ZV4+NDJLYdyCj9MA2z/8uNZxqGm
 5fUc+xRXRd+4YIH8Zw9TB1n0mhHfmRSqTteaCKrfy4kJCLJA+U5StkEW99EL1cCb43C1
 P5gw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpOYcTFPOf6l/rv240lm5r41R+hOgFEh+Il1rXf4bGb41AS8NFfy7FBfhZkZb8KxvMrvhroaOQ=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzlpP/7wt+SG+MAjWHJZZLneyjyrLfhjewL75/+DsqX7HR1stMT
 VOfO7nAyZWehiYQadYZLbqu9rMkW2in5cdSAXLGAP/T7vFNtYnj1miIyQ9GBNZDPuU0=
X-Gm-Gg: AR+sD13ORRAft9qhpSRCq1dVuTpNBUxKxWcadKB3IcyGb8T/EabLF2pDdvyZyg3sEhY
 hfISLf1M8Cbg/Cio6hPZ6+DSgqujDB2xcqJHEds4unH35POo/9ia3Zrj24WC+xQvwpWy1hhJn8R
 Q9QC0Do2uZp6cfRSYlx57Z6tA+BuG2wgKiesGWjbjMBKjNNN4llDENTaGyoYlISfS3b6vktARc9
 eJ9nFERKZ0fF5TqemUzBgUqjcjlQZQyOdP96RRW2i19NCfB5c/Q34p6rhoxujgvbgK1VLLD+K2t
 QVOzqrexaCOabzf/zuv3cLEXv3mq5qH2fj+gR16orP4S83VBRgyz7lYrZbIZRdkMNPvclJ4ylO1
 NKMOJlkg9rM8opGdfLWTrNi+lHQv0AQwMD7WSNmWDmO4IZ1Cm1yPvC2N0SdonPBCg1Sstc3UfNH
 RAWqu8KL8SnPtuSk+uvtYfJBt2T7DW2pWZ6gCJnlIQgVVGbqMwVthd
X-Received: by 2002:a05:6830:82f9:b0:7ee:7ac0:9380 with SMTP id
 46e09a7af769-7efff24c640mr1671403a34.20.1785254683646; 
 Tue, 28 Jul 2026 09:04:43 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3026:75d1:db9d:8984?
 ([2600:8803:e7e4:500:3026:75d1:db9d:8984])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f00d9a9396sm57811a34.26.2026.07.28.09.04.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2026 09:04:43 -0700 (PDT)
Message-ID: <97226293-adb8-4b89-98aa-e4909bef9fff@baylibre.com>
Date: Tue, 28 Jul 2026 11:04:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] serial: mtk: use ulong for clk_rate
To: Julien Stephan <jstephan@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Carlo Caione <ccaione@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.u-boot-project.org,
 Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>
References: <20260727-serial-mtk-clock-fixes-v1-0-1d5542de3d28@baylibre.com>
 <20260727-serial-mtk-clock-fixes-v1-1-1d5542de3d28@baylibre.com>
 <CAEHHSvayHDYp9+4SKOhYKk0j5ya2gmXbJSP7zVQBx344P1jS-g@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAEHHSvayHDYp9+4SKOhYKk0j5ya2gmXbJSP7zVQBx344P1jS-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785254684; x=1785859484;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sgje5h0JJ/yY8Raju0bjbeR8Va1/H0hRQQwOXteHqVw=;
 b=nNjG7X/z0G+eTfMCJtgGyHFe7UejoDv+nb9pPID14+9uFVnSLKgpMpBaNEN738Vmdp
 +HlpGqdKRN5f2x4OfiP9+8YlNTKVqPCL/xeFtc8PGVvHm302MiuLO7CT+4LobURNbA2m
 Vg24JJ7WS2lTTuq5QootSTHMC4KjhV1IsqjwXkpaONDcMNdNR/e8U1f8QOJq42OeM6k7
 g1P8OnjMrN70IsHEr+u9gmCK05n+zsGAurwATp00N3NZx1vB/3JyVqwbAFmKBAkA1VRE
 KcqR/3eQQGabDFeEqFdunXcwdfmaygPMC8s9iva1MejBxOHBdHwRNixMam2TS0kSjjdH
 fGUw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=nNjG7X/z
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

On 7/28/26 10:57 AM, Julien Stephan wrote:
> Le mar. 28 juil. 2026 à 01:25, David Lechner <dlechner@baylibre.com> a écrit :
>>
>> From: Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>
>>
>> Use ulong for return value of clk_get_rate() in the MediaTek serial
>> driver.
>>
>> IS_ERR_VALUE() does a signed 64-bit comparison against the range of
>> possible error codes. If clk_get_rate() returns an error, assigning this
>> to a u32 truncates the top 32 bits making the value smaller, defeating
>> IS_ERR_VALUE() and producing a garbage divisor that hangs the UART.
>>
>> Fixes: 3b17f2e2c2a9 ("serial: mtk: add support for using dynamic baud clock souce")
>> Signed-off-by: Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>  drivers/serial/serial_mtk.c | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/serial/serial_mtk.c b/drivers/serial/serial_mtk.c
>> index 01cc415efdd..64b3287f8eb 100644
>> --- a/drivers/serial/serial_mtk.c
>> +++ b/drivers/serial/serial_mtk.c
>> @@ -213,7 +213,7 @@ static int _mtk_serial_pending(struct mtk_serial_priv *priv, bool input)
>>  static int mtk_serial_setbrg(struct udevice *dev, int baudrate)
>>  {
>>         struct mtk_serial_priv *priv = dev_get_priv(dev);
>> -       u32 clk_rate;
>> +       ulong clk_rate;
>>
>>         clk_rate = clk_get_rate(&priv->clk);
>>         if (IS_ERR_VALUE(clk_rate) || clk_rate == 0)
>> @@ -266,6 +266,7 @@ static int mtk_serial_of_to_plat(struct udevice *dev)
>>  {
>>         struct mtk_serial_priv *priv = dev_get_priv(dev);
>>         fdt_addr_t addr;
>> +       ulong clk_rate;
>>         int err;
>>
>>         addr = dev_read_addr(dev);
>> @@ -282,10 +283,10 @@ static int mtk_serial_of_to_plat(struct udevice *dev)
>>                         return -EINVAL;
>>                 }
>>         } else {
>> -               err = clk_get_rate(&priv->clk);
>> -               if (IS_ERR_VALUE(err)) {
>> +               clk_rate = clk_get_rate(&priv->clk);
>> +               if (IS_ERR_VALUE(clk_rate)) {
>>                         dev_err(dev, "invalid baud clock\n");
>> -                       return -EINVAL;
>> +                       return (int)clk_rate;
> 
> Hello David,
> 
> This is a functional changes, maybe deserves a separate patch?

I checked all users and nothing check for specific return values.
Everything just logs the error or only cares about pass/fail. So
I don't consider it that significant of a change. Maybe I should
have mentioned it in the commit message though.

> 
> Cheers
> Julien
> 
>>                 }
>>         }
>>
>>
>> --
>> 2.43.0
>>

