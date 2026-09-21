Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97FBEC982ED
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 15:45:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4927440820;
	Mon, 21 Sep 2026 15:45:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sscaya5WbEIq; Mon, 21 Sep 2026 15:45:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 925564081E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790005549;
	b=OQ62T22dCKDHZSAml5QxxdTSXdrh1A2sG0MrKUwoQc7zdkaNGEVgzWiFzYN7y/xDr2lf
	 dvYigo6wKgo//4N7uykPs0TFA3Pk2iFigRGFrSqqPxOJcv2mv2vy1OnHiRU1lX3BTx65V
	 69F4uiikmpQxy7RP2p2kOpbryzbXEl/8YK0Aa4kBsGPy1Ncj3hQ8lZazZqFq/kBxPArSn
	 8q/4Gw00vmJAfQTRMI7463negk/2aoq5neXxu2hXR0719p7p9O+SPvM2p4zrpCvRx9Osa
	 6MK1Dxt3lMp9vWeP2h0BvvwEGg5uMhZeB9s2vCtf9saqE9asq7xIlJtHrj+23McooXQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790005549;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 X-Google-Original-From:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=p8ATsPg1OfuCAiGE/QAin1W2EW1QaXalaUsjHn0hL/0=;
	b=Eti02cVRyOUB0wNUrvlodMSnIQrVNlZW6f2M7YP9JW0tdBGUYPHRFjvg2LsoGOJFw6n3
	 /Tobd3MFm5SgtjtZi++D7K9YxeS2xC+SSBMqEAyiUgon9enotN2Abl7+NIjnw+gMYl8Wu
	 PPaqkfK5JXAXv2J47XE4AjHVCMqZU62kkKHsQK52B5bQsBQU8TXIjeATnJm4Te0Z3+UDI
	 J/FxtBG39avL2Z/vd7x/XHBZ2al3mGrwEpMcb8GBUU2mu6vx7Sdj2i5k6v+n6yAEc1ZSL
	 S7iTA5IUZ/uOZLMonF/tIYcN239UXKLnsJLXOQJuuZjIuIDwSgWxu9cy7/2J3FTU9wg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790005549;
	bh=p8ATsPg1OfuCAiGE/QAin1W2EW1QaXalaUsjHn0hL/0=;
	h=From:Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wQV/yXpkkIMIy3EAG7y2h/H+U/CiKcuTtHnoRQavatx8LhKx+AXGzuh4g0EHs1OVM
	 95BBy35JMLEqeRaK6etvFUg7MtW8KMXcbFLSdUVDCAT8bIHmWPP+GRroi915ccdA1K
	 yujMTCiMVMQQHiWApj6SM3iSmRZFmJVZMmWdchzLEoO6ttrqH1s7N5z3xcRmSSKd0i
	 q0ecdNQqsfG3m9CnuK1ME02D4T8b8SKUHRWqLnRJA6Dp9N+hneCDkz7QOxf7jjmPka
	 S6Tu9opaUPqCpCIWq8CA8UmZ/dtU+pnARDmKn/VOdgDcw4r4tIlV7T+1/picSflnM/
	 wjYYDgclF4tkw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 925564081E;
	Mon, 21 Sep 2026 15:45:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 04C56334
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 15:45:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DE5B0401B9
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 15:45:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 04XAMiKsJdje for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 15:45:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 8DCD7401B1
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790005547;
 b=r3/wGolD2Vq7q4bhr1LmA6b92RXnaWn3Pzo8p4SIevjfu4gy3doHEWwFvRYGZWaLMuPa
 m3OgWnH9X8g5dEQWSjGOUg0fkFsdtVx8hF8fj3sWi1ol97X5gakZHaK4ZLj+/j9xebIgZ
 WuySr6Q+hHJ693vspyyTWs3PIeMttEPn7xgmFalZh3SneTawyc6gymLsFP34CRoKnQJpn
 4fhqAV2yNgE/KX5ZzhFrHY98XBfFnYLjFBXnICmyvI4XGU9uLXV8bru+1Zdi6LB+RRrKu
 kQxrPl4HJGG0YT2nO6lukecsUcMBvEHIPndnyToSgO/PrHxs8kBqGPRyAfV9PpfhCaA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790005547;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
 X-Gm-Gg:X-Received:X-Received:Received:From:X-Google-Original-From:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=p8ATsPg1OfuCAiGE/QAin1W2EW1QaXalaUsjHn0hL/0=;
 b=MX+FmqTbbEpBpZ4MJevVk9tVyD95IPFIPx0qrs0F0DqKAXA+hRMs6fkYOnw6Kb5I4P2x
 v8GFoYADmrD96I+T/HLjSks1WtebAN3+I64pseH4RX8jQVBNhd/+37WGkQAbgPketnpLI
 K7mkTUaRd55PFJt/U0JTqEuCK+m7aPCnV+xMSkt1+RD31ZpB40DN3SieBVQlKR8uQ/pP+
 O5AX5Daua8OK/fSawcwONnT5jBi+H23BXewBP07Q1pRwtB5H5i9SO/UMMHpfgtEeT5EZB
 qZ4QISI5upF4H8mHAd74wsppOUHA8KvwrxqHPW/k+jmFFkQyIIhOWDkeNWYye1bDw4g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=lpgMErh9; 
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=lpgMErh9
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8DCD7401B1
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 15:45:44 +0000 (UTC)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DD5B03F830
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 15:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1790005543;
 bh=p8ATsPg1OfuCAiGE/QAin1W2EW1QaXalaUsjHn0hL/0=;
 h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 In-Reply-To:Content-Type;
 b=lpgMErh9HA0KmixqFjcnMmFHw4HGRZ3GMSV5tNP5APMw0Ff7cii+twxcd/89pxk3d
 cgurJ3B8nL8hOj603qP3xohp6NxgStitmmnlqKZMmk28Rw6ZBQuMAC6xGtwo0mpo4A
 2OHo6n9yOtlYXd9JIVLc/nsc8y6BpMHs3G4FFAYi5WD8bayKVcrKAysygipUWoD7n9
 GcMraAyfnAsa1KWc7Or+wxQgweGacKeeXdt4jx638+M3qve1PvfrW7JtsE/CIn6njy
 8j5EonQKtWxGO1Bl7n9Ygzs1ZzxK4VrgfBZ6CKLblUdiYlmv/T5Dr5DaI7b/IDbEtf
 Rk6MZ2CSYGnStWyTU1XE90pZccrZn/2XMzi0M9TjnDIg6OwHq7BPGqs+eUA4yjFMVj
 Vc0ryA8W+ZDXatbeKX60+/ahlgWUyllfwuTQzpa8rNMDQHitmDsG2h4G5h6SbI6GiL
 hUcqkPDKh4xdn6VYsKPBmlIrlMblJRksY/0xcoRx1pweTnVgqyS93i0MHG9ewCj0qM
 C7iKklL/VmLMGo6BTQfmeVx9wH+yXj6AGS5pXVQxfhzznwxQl7jkTPmJz1p2w9j/nd
 WfaTEeYx87yQijQxMwo+AfctQxsprHRhNOC7Q34vT+sEjDvQIbCofJvlCYUCLSOu1G
 IOujlla4JvYqEo3ZxNR4+wjs=
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49e6b5c5f44so34737865e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 08:45:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790005542; x=1790610342;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=p8ATsPg1OfuCAiGE/QAin1W2EW1QaXalaUsjHn0hL/0=;
 b=1l3NncC46TOslhBz+BEzgWuKfOl8R7L9kUZzQ58HkL0TDWKGZdqgLqYOTyb/YCmDgy
 G478p7im6n0yqjVIb8+QhqTzwbDBu8rLQapnF25iIg2ghS+RSxp5caOtuC8Tsd/+OyMM
 HE6afsFXT5W38OL0dG9/pG8ew+/281uaLi1IW1di2j8u6rMlUhF1JIdLA47lZxett2t1
 bussGtlfaU0VqPKF7nAvMrC07XRAkr4ZboKSJvaeoiBtA59RxOWNau1ilcW6LIZCwR/3
 sG7bcflE7nRf4/+yHRnTB63QfVjgmb5M9kwbwFdGV1qZrm+1QJRU90SDUCXD1MzDm3wB
 5NIw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxvHFLcUpuynUT/SMt5CljzV8PO4KJnytHEtFklEzS90B+qd8chLhN9VlUrD/hUuTflrmbGy40=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lzH+b0RokHShKqhjJ4r9GiLLllkZDq5PqtZclD+PQJCkueP5Km
 rBMTO5VZbi369dq3riQ0Lm7TUwXhxb32FmxeZU8UVy++by1u40+hHOaYG51W9MqFNHuwVJiJbkU
 q0B1LfhrdXvOFRDkDy1e5sqTHk8C5pgeAvPK6R/pwkJLt3uoJDOZq0ccf6AwrF0rzCZfkE4zQAa
 wLNL3OEPsVpg==
X-Gm-Gg: AYBFou3vcqOFz/qgeBBMt0bGD23fc52BVuxrli2UOnkRAHPQDa0ocLLUXPcz8n0QM08
 Y1zcTor4Ba15bi2inNlvkB2XsiFFiuSuXfPB/BrfEmNRBObBhBgIV45fjazGUykLTKHDktSBUcT
 voNAUbS6KXPXmpJcE61ZVsxSErULFz+rw0U3fGy6JpHtP7tCg9Zlxp7wvVoP3UTfL/V9lfTgxQD
 vGggyZ9LEvEElBWlTXTa/bn9Ze1O7YJT170cYtcgNcGIWbrlUQ7eI4S2XlgPKjqleDgceuIX6FK
 Imfx1PwzeD06rsIrQ9P5a7xdKkno1c6fUV+Dfzmwj/yY3/fN0JrxFumZiLTF5iqn30B1KyHGRBG
 ntJx62WPpJuKMYX3o2msG5GrZpad1YADYTmEtclUjpVrDdxbKhoXkwDxbe0xm+CweUaMu5MLGKV
 Caik3wCX8=
X-Received: by 2002:a05:600c:83c8:b0:49c:ff3c:973f with SMTP id
 5b1f17b1804b1-49fc573f531mr151822965e9.24.1790005542326; 
 Mon, 21 Sep 2026 08:45:42 -0700 (PDT)
X-Received: by 2002:a05:600c:83c8:b0:49c:ff3c:973f with SMTP id
 5b1f17b1804b1-49fc573f531mr151822495e9.24.1790005541953; 
 Mon, 21 Sep 2026 08:45:41 -0700 (PDT)
Received: from ?IPV6:2a02:908:1242:30e0:aec3:c221:8373:654c?
 ([2a02:908:1242:30e0:aec3:c221:8373:654c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc55cd8a8sm294994665e9.0.2026.09.21.08.45.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 08:45:41 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
X-Google-Original-From: Heinrich Schuchardt <xypron.debian@gmx.de>
Message-ID: <69076012-7d9c-4603-be4b-f39beebaf9f3@gmx.de>
Date: Mon, 21 Sep 2026 17:45:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] boot: image: Keep the image-type table out of xPL
To: Alexey Charkov <alchark@flipper.net>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>,
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz
 <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Johan Jonker <jbx6244@gmail.com>, Aristo Chen <aristo.chen@canonical.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>,
 u-boot@lists.u-boot-project.org
References: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
 <20260918-spl-fit-compression-v2-1-28e946f57357@flipper.net>
Content-Language: en-US
In-Reply-To: <20260918-spl-fit-compression-v2-1-28e946f57357@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 9/18/26 12:52, Alexey Charkov wrote:
> print_decomp_msg() names the image it is about to unpack, which drags
> uimage_type[] and its strings into any phase that links image_decomp().
> That is about 2.5KB, measured on a Rockchip RK3576 SPL, spent on one line
> of progress output in a phase built for size.
> 
> Name it "image" there instead. U-Boot proper is unchanged.
> 
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>   boot/image.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/boot/image.c b/boot/image.c
> index 185d52ba492f..a7dc69e858ad 100644
> --- a/boot/image.c
> +++ b/boot/image.c
> @@ -416,7 +416,12 @@ void image_print_contents(const void *ptr)
>   static void print_decomp_msg(int comp_type, int type, bool is_xip,
>   			     ulong load)
>   {
> -	const char *name = genimg_get_type_name(type);
> +	/*
> +	 * The image-type table and its strings cost about 2.5KB, which is a
> +	 * lot to spend on a progress message in a phase built for size.
> +	 */
> +	const char *name = IS_ENABLED(CONFIG_XPL_BUILD) ? "image" :
> +			   genimg_get_type_name(type);
>   
>   	/* Shows "Loading Kernel Image" for example */
>   	if (comp_type == IH_COMP_NONE)
> 

The print_decomp_msg() output is irrelevant to end users.

Do we need print_decomp_msg() at all in XPL?
Even for main U-Boot this should only be a debug message.

Best regards

Heinrich

