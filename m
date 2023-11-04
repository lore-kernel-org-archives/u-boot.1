Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41256C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 15:35:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 653DF870BC;
	Sat,  4 Nov 2023 16:35:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B0ndXFZI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A94A6870BC; Sat,  4 Nov 2023 16:35:25 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F04E8708A
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 16:35:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3b4145e887bso1633174b6e.3
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 08:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699112119; x=1699716919; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Is9bYnZoa9Ia/ljgC302IwC99pSN1vD90wLtE/KKKzc=;
 b=B0ndXFZISsP56sEWIR2AFcdPCiSLj6SwV9Q+Oof44orFa9fT6vvhtrViypC7E5h8Tl
 iA7PXIEfWRJH0iN0PwTazMUaFD7E4KzQ2ssDdEzxXYDs8fLy9oOSrrcd5XubNhS/6Dwl
 MbH0l20iXgwsjyitosEmkjW2rptdnCXG5k5z88tIFDkKebYrdgJIwIi8DBahN7oUzzvD
 s3AMcOg1wyuwoGCwNt3dPAKPE7Ukc8qTxj3WdVxXGHrwleClP6XW/P1iZLn8UMohh5Qu
 84R7YO3mszAu9Tcb325BL4yCNFmqwQGrXP4vht1K5/6bgz7VN0VK5g50+Tg4rs+3MaPW
 KT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699112119; x=1699716919;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Is9bYnZoa9Ia/ljgC302IwC99pSN1vD90wLtE/KKKzc=;
 b=qHNwy3RL2ujYzB3rD2q4c+CCBdBcJlnpYRRCf49RJ88ag69/uqSdyMe57UoVLNzltV
 3JqqdOmjWtZ7kumsm9SASogyIZq1p0mSjHoCnAfZY/IHYB0lA8EkylXMfUPYWpDvCyAO
 aIOf/ZnXpJ46EmC8okFJ2tuslh4+B9A1Y6rGxNbhDpVZHNkB082d/myMqDsoQn+3UwZ/
 /UXxVP7A5lKR2QnEjbtXVTIvpqYgvBDXXJfYPq5zVjUJ+XeJOkZZzDByCyy23X+Of2eD
 05ZtNWzEc+Lawxz3XoY9NkmIMTm24X9/04zVhA/m4Lf9BOYIgpkkLK7qaviZF+puPXBZ
 QLJg==
X-Gm-Message-State: AOJu0Yy12rC5Xs28EQlZJfrLGrJcqXd2m3wEQkOluj69mkC4rNwqeqsE
 aYzdp2Fiqt3EjqYNAJ8drzY=
X-Google-Smtp-Source: AGHT+IG35GQpngCwk3ltU26MeqxCB2v/wVCocFJfmbDv9wPVu1iwk+szcmKESrm1skticxCUx1HTcg==
X-Received: by 2002:a05:6808:10c4:b0:3a7:1e98:80ad with SMTP id
 s4-20020a05680810c400b003a71e9880admr30628952ois.9.1699112119572; 
 Sat, 04 Nov 2023 08:35:19 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 v17-20020a05620a091100b0076f18be9a64sm1649086qkv.81.2023.11.04.08.35.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Nov 2023 08:35:19 -0700 (PDT)
Message-ID: <1059a193-8543-320a-4d88-19afe46771a6@gmail.com>
Date: Sat, 4 Nov 2023 11:35:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RESEND 5/5] clk: ccf: call clock provided ops directly for
 endisable()
Content-Language: en-US
To: Yang Xiwen <forbidden405@outlook.com>, Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de
References: <20230818-clk-fix-v1-0-49ec18f820bf@outlook.com>
 <20230818-clk-fix-v1-5-49ec18f820bf@outlook.com>
 <f996c4ea-81c6-815e-cab1-2d0b09b22135@gmail.com>
 <f94b7313-0dd4-477b-b144-d3b2d08d14ad@outlook.com>
 <SEZPR06MB695927A6DEEEF8489A06897396A7A@SEZPR06MB6959.apcprd06.prod.outlook.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <SEZPR06MB695927A6DEEEF8489A06897396A7A@SEZPR06MB6959.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 11/1/23 16:33, Yang Xiwen wrote:
> On 11/2/2023 2:50 AM, Yang Xiwen wrote:
>> On 11/2/2023 2:19 AM, Sean Anderson wrote:
>>> On 8/17/23 13:04, Yang Xiwen via B4 Relay wrote:
>>>> From: Yang Xiwen <forbidden405@outlook.com>
>>>>
>>>> Calling into CCF framework will cause a clock being enabled twice
>>>> instead of once (clk->enable_count becomes 2 rather than 1), thus making
>>>> it hard to disable (needs to call clk_disable() twice).
>>>> Fix that by calling clock provided ops directly.
>>>
>>> Can you describe this scenario more? From what I can tell, clk_enable
>>> doesn't
>>> increment enable_count for CCF clocks.
>>>
>> Well, it's hard to describe clearly. But I can only tell this patch
>> fixed the issue when i was trying to write an Ethernet driver[1] which
>> calls clk_disable() and expects the clock to be disabled after that.
>> Also I found that CCF driver does not have a corresponding test file. I
>> will try to write a test for that in next release.
> Okay, fine. I read the source again and let me try to explain the whole
> thing to you briefly. Let's see what happens when we are calling
> clk_enable(gate).
> 
> The source of clk.c is listed below and labeled for clarity:
> 
> ```
> 1	if (CONFIG_IS_ENABLED(CLK_CCF)) {
> 2		/* Take id 0 as a non-valid clk, such as dummy */
> 3		if (clk->id && !clk_get_by_id(clk->id, &clkp)) {
> 4			if (clkp->enable_count) {
> 5				clkp->enable_count++;
> 6				return 0;
> 7			}
> 8			if (clkp->dev->parent &&
> 9			    device_get_uclass_id(clkp->dev->parent) == UCLASS_CLK) {
> 10				ret = clk_enable(dev_get_clk_ptr(clkp->dev->parent));
> 11				if (ret) {
> 12					printf("Enable %s failed\n",
> 13					       clkp->dev->parent->name);
> 14					return ret;
> 15				}
> 16			}
> 17		}
> 18
> 19		if (ops->enable) {
> 20			ret = ops->enable(clk);
> 21			if (ret) {
> 22				printf("Enable %s failed\n", clk->dev->name);
> 23				return ret;
> 24			}
> 25		}
> 26		if (clkp)
> 27			clkp->enable_count++;
> 28	} else {
> 29		if (!ops->enable)
> 30			return -ENOSYS;
> 31		return ops->enable(clk);
> ```
> 
> The following steps are executed:
> 
> 1. Actually, a "fake" clk is passed to clk_enable() and only clk->id is
> valid. The actual clk is "clkp";
> 2. Initially, we runs till `ret = ops->enable(clk)`(line 20), i.e.
> ccf_clk_enable(clk);
> 3. Thankfully, ccf_clk_enable() calls clk_get_by_id() to get the real
> clk and call clk_enable(clkp) again so we won't have an endless loop here.
> 4. So ops->enable(clk) actually equals to clk_enable(clkp). It's obvious
> that there is a `clkp->enable_count++` inside the nested function call
> since it's still 0. Now it becomes 1;
> 5. The nested clk_enable(clkp) now returns to the outer clk_enable(clk);
> 6. Unfortunately, there is a `if (clkp) clkp->enable_count++;`(line 26)
> afterwards. Now it becomes 2.
> 7. Finally, we got a clk being enabled twice. "clkp->enable_count" is 2 now.

OK, thank you for writing this up; it is clearer now. Please include this in
your commit message.

> Obviously it's not the intended behavior. We can either fix clk_enable()
> or ccf_clk_endisable() to resolve this. But I choose to touch
> ccf_clk_endisable() since it's less commonly used.

Hm, what if we added something like clk_raw_enable, which just did

> 19		if (ops->enable) {
> 20			ret = ops->enable(clk);
> 21			if (ret) {
> 22				printf("Enable %s failed\n", clk->dev->name);
> 23				return ret;
> 24			}
> 25		}

and the same thing for disable.

--Sean
