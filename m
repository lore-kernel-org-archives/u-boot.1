Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E396BD6ACF4
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 17:12:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2976A896C7;
	Wed, 27 Nov 2024 18:12:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CyV5KJ4g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09B63897B5; Wed, 27 Nov 2024 18:12:18 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A017A8958D
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 18:12:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5cf6f804233so8146463a12.2
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 09:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732727535; x=1733332335; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HzCOpJZeY7XkuMFJJjD9XuezcXATCZ2mEPW6l1xiMHc=;
 b=CyV5KJ4g8cBKbu9wiWYwAqdLCrsZMlGOFJPot5wJ4g+OzVg0upZlGM3AKGUzgNIgof
 mWHWmLkDOWOItUt8m0NF560IzWdJOeGZPaSnHrBa1jLE91TAGH5nSastZb+WMLaT2Pt2
 57cf0XqHdGqXCeHJfsVQojdCEs5icec2belA0N3pnN1tA0dzPDJaig2edVlwwzPDD+eY
 x3IF/w47/dtPLF+G/EsGo3AAJW/lwEqsua/19x72GPa+l/yAqJsAquTVXDjE+UuZBiY/
 rXg/pa8jdHHnS4pT/Pal/rvkZP7eKefuElwtf7hGIhjlWhQA/9DbBUR9JKQZ3VkT7Cde
 kRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732727535; x=1733332335;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HzCOpJZeY7XkuMFJJjD9XuezcXATCZ2mEPW6l1xiMHc=;
 b=BeOMxUAXN3X5/Oc4pqawFDpq8nbi6tMFXPc7inS0lBu8awHmM8gyvg4TvkNrUkkIbK
 RdOx2yU6gBpBlVBCHDHQeIxKw8n/1PpQRtvEJadehxEwuSUejpN1SLbutEaICylOMyk8
 QEFqMoBS1O4mtb4+fRuO0b458tIEqMZENCc10X4pRDL5lQXhy7RlGYeqnF2vF+x7kgJp
 3yM558KyYi9DtjvXUSTajDWIo4Po4pLiOHgE2HHWEZaMeISWCyDdEv3RBJ6vKq7OHzuJ
 NLT8L4uuBO0rxmTM68yqPmd1Ld7jnV6lVjVBmjstD3vFg5ZWvR4iKbhSMwdBUa7dyyM+
 G6uA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvDLBpmV8b38ZBe1iw/A0uW2gbScvBurvr84vhjWfPn8tgIBtBCtSFJLanAJDqm6CM/TLbkVM=@lists.denx.de
X-Gm-Message-State: AOJu0Yyu8eVXNm1NSpyRiP4DvK+QiLuLzMEeR6aDrm9tDaUgAWyqO+Af
 QWdE9jcAksNhxN2d7+VFz8UqrRFhhASEAJruzKtdYo2LsLp7oWC4jA2pyGz8scE=
X-Gm-Gg: ASbGncuGKxQXDYzbQYG8Iq4DXlAOgBQzwHaHpHw6i/I4+4Ot0tvITHnva1X27qH10dF
 25dOvROwZI62QKOtAsvRKhNuqrtm9bqzqRCS63Ee/jsQtYk9188HmMq58QWIkbPZ8jDS5iN7Gya
 u8cWHyDSpwyp7WVe2blyodOJSmUa4Xye/b48L2YKvdmUYmCWWLprpcARdPrPNkl0YEBFwLc9XtM
 pT/O7/ZEf2mJUXiapatQE23rc1I/x7gLP2DcNd6U6AIkmFVtK8ZRPuPAQY8Il+Vi1dM/naiBb4X
 vaSCsZMfSP9HJBZIGOLhxlznCnydpwUq
X-Google-Smtp-Source: AGHT+IGXg0jc37eLvs64cXRdI9Qrd1zjqIpCm7TT7YS6hQeswJEnydVD4Z7I9HiYraQBDToPqNhcNg==
X-Received: by 2002:a05:6402:5210:b0:5d0:81dd:4886 with SMTP id
 4fb4d7f45d1cf-5d081dd48b6mr3208021a12.26.1732727535063; 
 Wed, 27 Nov 2024 09:12:15 -0800 (PST)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d01d41a5fcsm6329677a12.78.2024.11.27.09.12.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2024 09:12:14 -0800 (PST)
Message-ID: <d89d7d04-8ff9-460d-844f-c85129c5ba77@linaro.org>
Date: Wed, 27 Nov 2024 18:12:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dm: core: ofnode: safely fallback in ofnode_lookup_fdt
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, Jonas Karlman
 <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20241113052050.1862420-1-caleb.connolly@linaro.org>
 <CAFLszThAmn_NU-PoYopjx17Bk6QxgbFaCWJjKdMAG5JzLJWdEg@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFLszThAmn_NU-PoYopjx17Bk6QxgbFaCWJjKdMAG5JzLJWdEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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

Hi Simon,

On 27/11/2024 17:52, Simon Glass wrote:
> Hi Caleb,
> 
> On Tue, 12 Nov 2024 at 22:21, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> Under some conditions it's possible to hit the null condition here like
>> when running with OF_LIVE and using the ofnode API before
>> initr_of_live() is called. There is very little null
>> checking for this in the FDT framework, so returning null here can
>> result in weird null pointer conditions.
>>
>> Instead let's return the control FDT in the fallback case, this is
>> usually what the user was expecting.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>  drivers/core/ofnode.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
>> index 950895e72a99..7a7f25fc537c 100644
>> --- a/drivers/core/ofnode.c
>> +++ b/drivers/core/ofnode.c
>> @@ -152,9 +152,9 @@ void *ofnode_lookup_fdt(ofnode node)
>>                 uint i = OFTREE_TREE_ID(node.of_offset);
>>
>>                 if (i >= oftree_count) {
>>                         log_debug("Invalid tree ID %x\n", i);
>> -                       return NULL;
>> +                       return (void *)gd->fdt_blob;
>>                 }
>>
>>                 return oftree_list[i];
>>         } else {
>> --
>> 2.47.0
>>
> 
> Eek I really don't like that, since it will silently return an
> unexpected value.
What's the unexpected value? The only caller for this is ofnode_to_fdt()
and the return value for that is never checked. It seems clear to me
that in practise NULL is the unexpected value here.

> I think we should panic. Do you know what code path
> gets you here?

Hmm, I don't exactly recall. Should really have made a note when I wrote
this patch :/

Guess I'll drop this from my dev branch and come back when I figure this
out again.
> 
> More work is needed in livetree to sort of the rough edges, sadly...
> 
> Regards,
> Simon

-- 
// Caleb (they/them)

