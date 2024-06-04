Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF99C25B78
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 12:04:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAD5C88418;
	Tue,  4 Jun 2024 14:04:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tR4QgRnq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F38FE88428; Tue,  4 Jun 2024 14:04:53 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 889BB87B35
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 14:04:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52b8b638437so1034528e87.3
 for <u-boot@lists.denx.de>; Tue, 04 Jun 2024 05:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717502691; x=1718107491;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZSp5TY5G6VsKCCHg/5DjsQeB/AUjpxPECpxrSDXCKQw=;
 b=tR4QgRnqpU+l6h3KOcov8Z/7nNhHf+xLPXUMfgzCcHJ38C9qaPOamVtf7JjHN0vdpj
 jJkdM3cyB45qj09YioBztffekQY3S/KKzuwL6cXrs7KPA7SlMVji2lRzkEY9tn46NjIo
 2IMy2Z9jLmrkm5RTaNwd8Bv8vA0FXVXM3HAt1VasfPT6xE/TBFimAByR5i81lQIAUSx6
 TRbXY7x61d1EKWSei7hU2OZOrPtyfmRpWOrp/y6rNKcUKhJKfk+gT0tyYdrHGC3TTImX
 +pNtOPf3YhuW4jvrgiKJy+JePSeGd8a08QtZg+dTnZiTy3xh9mOkNFCUWh4BrhKULmvh
 Gw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717502691; x=1718107491;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZSp5TY5G6VsKCCHg/5DjsQeB/AUjpxPECpxrSDXCKQw=;
 b=j3/AwFb14QMXR30U7Dt8x/a5nSxdn3geWYhfzGDkS+HIiMTCgCX9kHklJ/VvSAX3R4
 Oqw7kJVwjaNlMdT9jr7x4KfCx/6rdotB4idQxVoehdLv5nXGwYAQCEBb2RvubGtkWdXZ
 PPFk44R3nUziBljqniqPYgHsU2Lp22BOQSbhZ7MAGPD8eL2hnmnLEXdWLN3G3iOLbO6l
 nAcbv0B/mgq3JsRJKzO3MbU5j6MewyXCof/Ys0pX6Ox3TvuekVr24jLkp77I5gtah9s/
 rINaK8b2psV2XjjayHvWiFkiXl39b/OQfPcYuPk5R76KCZ0DDPTOdkZTqg2Xbs/wAv0/
 Hi1A==
X-Gm-Message-State: AOJu0Yxc57CMP/56teJMjwoax2frEw4GozINM52xuz6gDyquFHA6UCYw
 LSnnpLd+9ebHiPzNRpPDS4/UMTeTii1YJvMVfkRLDLJlANPQc77YTGZn4NMZaJc=
X-Google-Smtp-Source: AGHT+IF7cFJ6mYE6p+jbVEf4KCJTSrVCQtB80KdSTkoIUDQ35Ud78DN1N8ZjMK05bftOgWNHxB1Xtg==
X-Received: by 2002:ac2:44d1:0:b0:52b:7917:9956 with SMTP id
 2adb3069b0e04-52b8980acaemr6232994e87.60.1717502690271; 
 Tue, 04 Jun 2024 05:04:50 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd0667366sm11268544f8f.111.2024.06.04.05.04.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 05:04:49 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] bootstd: Fix a handful of doc typos in bootmeth
In-Reply-To: <3bb636fd-39b7-472a-8715-e306dc8c3ac7@cherry.de>
References: <20240603-bootmeth-typos-v1-1-6edbdb469f7c@baylibre.com>
 <3bb636fd-39b7-472a-8715-e306dc8c3ac7@cherry.de>
Date: Tue, 04 Jun 2024 14:04:47 +0200
Message-ID: <87wmn429sw.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Quentin,

On mar., juin 04, 2024 at 11:47, Quentin Schulz <quentin.schulz@cherry.de> wrote:

> Hi Mattijs,
>
> On 6/3/24 11:11 AM, Mattijs Korpershoek wrote:
>> Fix some trivial typos found by browsing the code.
>> Done with flyspell.
>> 
>> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> > ---
>>   include/bootmeth.h | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>> 
>> diff --git a/include/bootmeth.h b/include/bootmeth.h
>> index 0fc36104ece0..529c4d813d82 100644
>> --- a/include/bootmeth.h
>> +++ b/include/bootmeth.h
>> @@ -40,7 +40,7 @@ struct bootmeth_ops {
>>   	/**
>>   	 * get_state_desc() - get detailed state information
>>   	 *
>> -	 * Prodecues a textual description of the state of the bootmeth. This
>> +	 * Produces a textual description of the state of the bootmeth. This
>>   	 * can include newline characters if it extends to multiple lines. It
>>   	 * must be a nul-terminated string.
>>   	 *
>> @@ -138,7 +138,7 @@ struct bootmeth_ops {
>>   	 * @dev:	Bootmethod device to boot
>>   	 * @bflow:	Bootflow to boot
>>   	 * Return: does not return on success, since it should boot the
>> -	 *	Operating Systemn. Returns -EFAULT if that fails, -ENOTSUPP if
>> +	 *	Operating System. Returns -EFAULT if that fails, -ENOTSUPP if
>>   	 *	trying method resulted in finding out that is not actually
>>   	 *	supported for this boot and should not be tried again unless
>>   	 *	something changes, other -ve on other error
>> @@ -151,7 +151,7 @@ struct bootmeth_ops {
>>   /**
>>    * bootmeth_get_state_desc() - get detailed state information
>>    *
>> - * Prodecues a textual description of the state of the bootmeth. This
>> + * Produces a textual description of the state of the bootmeth. This
>>    * can include newline characters if it extends to multiple lines. It
>>    * must be a nul-terminated string.
>
> I see we have a mix of null-terminated and nul-terminated in the tree,
> is the latter correct?

Thank you for your review.

I believe nul-terminated is correct: nul is the character, and null is the pointer.

See:
- https://news.ycombinator.com/item?id=22283217
- https://internals.rust-lang.org/t/null-consistency/16767

I'll check the tree and submit another patch to fix this.

>
>>    *
>> @@ -244,7 +244,7 @@ int bootmeth_read_file(struct udevice *dev, struct bootflow *bflow,
>>    * @dev:	Bootmethod device to use
>>    * @bflow:	Bootflow to read
>>    * Return: does not return on success, since it should boot the
>> - *	Operating Systemn. Returns -EFAULT if that fails, other -ve on
>> + *	Operating System. Returns -EFAULT if that fails, other -ve on
>>    *	other error
>>    */
>>   int bootmeth_read_all(struct udevice *dev, struct bootflow *bflow);
>> @@ -255,7 +255,7 @@ int bootmeth_read_all(struct udevice *dev, struct bootflow *bflow);
>>    * @dev:	Bootmethod device to boot
>>    * @bflow:	Bootflow to boot
>>    * Return: does not return on success, since it should boot the
>> - *	Operating Systemn. Returns -EFAULT if that fails, other -ve on
>> + *	Operating System. Returns -EFAULT if that fails, other -ve on
>>    *	other error
>>    */
>>   int bootmeth_boot(struct udevice *dev, struct bootflow *bflow);
>> @@ -264,7 +264,7 @@ int bootmeth_boot(struct udevice *dev, struct bootflow *bflow);
>>    * bootmeth_setup_iter_order() - Set up the ordering of bootmeths to scan
>>    *
>>    * This sets up the ordering information in @iter, based on the selected
>> - * ordering of the bootmethds in bootstd_priv->bootmeth_order. If there is no
>> + * ordering of the bootmeths in bootstd_priv->bootmeth_order. If there is no
>>    * ordering there, then all bootmethods are added
>>    *
>
> Shouldn't this be bootmeths here as well?
>
> (And there's another occurrence in boot/bootmeth-uclass.c

There seems indeed to be some inconsistencies around bootmeths versus
bootmethods.

To me, we should use 'bootmeth' everywhere.

Simon, as the maintainer of bootflow, do you agree ?

I can spin up another patch to fix this.

>
> Cheers,
> Quentin
