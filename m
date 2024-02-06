Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9503AC48297
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 14:06:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F29BF87C7D;
	Tue,  6 Feb 2024 15:06:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dCDqEI1m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66EBD87C7E; Tue,  6 Feb 2024 15:06:03 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07A7887C78
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 15:06:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a380a1fa56fso116220466b.0
 for <u-boot@lists.denx.de>; Tue, 06 Feb 2024 06:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707228360; x=1707833160; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AcEtIF8YNTquqe3Fuc9aWghuwLOcakAegwyM57EibbM=;
 b=dCDqEI1mV9cM4SnjeaBIie9xOqUu5+I3cooe+CxfDyAXdnBOeW16PPZj6+yPXXeLiB
 Inc4LXml+IbIIukWkjSVkhUIGZEbWEwiEspmGecrecpe4kQzPR0uVTNDmVMKKRbFCsaQ
 Zs+Cf9R4zIRl/zdFOqiqqhIUOe0aJ+Z9OEsSRA/ePWKq61wFJ7WjZq1dXeLiAl/D/1gm
 jbpAefOZljlcG0GikLxm+WeoG7AMRmBiFIlVWpiGjh6S1U4lRHuYszeAnpkWf0822SfD
 EcdnnzxhogLVO96nCiTq/SjK34qud6vpInu3ajpd/M46iN9vWfLOWlf+qWFRDQgN1DVL
 jbvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707228360; x=1707833160;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AcEtIF8YNTquqe3Fuc9aWghuwLOcakAegwyM57EibbM=;
 b=EouWIe5MQqi4teK///RRwQIjACUJHX3aCV9EcYE1VzdFb64Iw5ZTjBUHG/7mR93mAd
 czUpbn6mgjotMwqPXOtDLkoGTnx69qKSQDYb9Qz1OhXPCjZR5p1hzAQzaj5sOeC9Q+S2
 MTYSQ39R4b3mYmXt2saZwwxz/envuXuQygyI1J7i3YWVoXEt2zoTs5mrHIEK7f+iPAv0
 vP0ZPE6f0boLS/CRbGIt48ZfOxFvmJ5p4E9nomHBKZhk3bA5WD03ibqtWrsehDYVRUgg
 dY8UmvaKi6KFoD5FkOkqPzg92SYytRdRXjAmfqqyYGxK3/hMuY8dIx4YEd8WBpEJI8Y4
 X0eA==
X-Gm-Message-State: AOJu0YzX4fEE7dTWmFXJq0RiLgKlVzLukomeq40umLvUEoyzjcVxJfsb
 66EhobXZGMpM8vinj0tBoknRncfECmm8kUnBCWwr1NZ0CJJJFoFgvDNUEPg9LEs=
X-Google-Smtp-Source: AGHT+IGSyWCPSjeLyXwhsH1DYp6u1PHnUm2tBvDel59ZWG1DO4iaK32QCiK6CGjAdAga2nRglIekuQ==
X-Received: by 2002:a17:906:c102:b0:a38:32bc:bd24 with SMTP id
 do2-20020a170906c10200b00a3832bcbd24mr1431346ejc.36.1707228360467; 
 Tue, 06 Feb 2024 06:06:00 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVimi611oX/rQyprbICOy2HqbGSY4wjwdIVLIDqZp1+87dFqAouZBx7S6ap7eZLsnadGDbxodbOOBz0FD+fTHtGGSFPNqwYxzsB7QEEh1DA/FwwjrCBGYmjevrOFQ==
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 q19-20020a170906361300b00a36c499c935sm1192732ejb.43.2024.02.06.06.05.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 06:05:59 -0800 (PST)
Date: Tue, 6 Feb 2024 17:05:55 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: jihongbin <jhb_ee@163.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com
Subject: Re: [PATCH] xyzModem: Correct xmodem blk verification conditions
Message-ID: <99934d6a-5fb5-459d-a757-a5fe6d3ccfb0@moroto.mountain>
References: <20240205065850.7556-1-jhb_ee@163.com>
 <bd80e95c-b2bb-4ff2-8943-7a185a310546@moroto.mountain>
 <5cd09ba8-49a1-4ed7-8610-c62097caa45e@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cd09ba8-49a1-4ed7-8610-c62097caa45e@163.com>
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

On Tue, Feb 06, 2024 at 09:05:33PM +0800, jihongbin wrote:
> It may be that there are relatively few people using this function, or the
> length of the transmitted data is less than 128byte * 255 byte, so the
> triggering conditions for the above problems are not encountered;
> 
> I actually discovered this problem during testing. Continuous transmission
> always fails at block 255.
> 
> The following is the protocol's definition of blk cblk, cblk = 255 - blk
> The original content of the agreement
> (https://www.menie.org/georges/embedded/xmodem_specification.html) is as
> follows:
> -------- 3. MESSAGE BLOCK LEVEL PROTOCOL
> Each block of the transfer looks like:
> <SOH><blk #><255-blk #><--128 data bytes--><cksum>
> in which:
> <SOH> = 01 hex
> <blk #> = binary number, starts at 01 increments by 1, and
> wraps 0FFH to 00H (not to 01)
> <255-blk #> = blk # after going thru 8080 "CMA" instr, i.e.
> each bit complemented in the 8-bit block number.
> Formally, this is the "ones complement".
> 
> <cksum> = the sum of the data bytes only. Toss any carry.
> 

Thanks, this is good information.  Unfortunately, your patch is not
correct.

Originally you wrote "When the blk sequence number is 255 and cblk is
0, the original XOR condition produces a result of 0, and the judgment
condition will be unsuccessful."

If blk is 255 the cblk should be zero as you say.

common/xyzModem.c
   375    /* Validate the message */
   376    if ((xyz.blk ^ xyz.cblk) != (unsigned char) 0xFF)
   377      {
   378        ZM_DEBUG (zm_dprintf
   379                  ("Framing error - blk: %x/%x/%x\n", xyz.blk, xyz.cblk,
   380                   (xyz.blk ^ xyz.cblk)));

0xff ^ 0 is equal to 0xFF so it won't print an error.  Good!

With your patch, there is an issue with type promotion so the condition
is always true and it will mark everything as a "Framming error".

-	if ((xyz.blk ^ xyz.cblk) != (unsigned char) 0xFF)
+	if (~xyz.blk != xyz.cblk)

Both xyz.blk and xyz.cblk are type unsigned char.  If you take the
~ of an unsigned char it's going to be 0xffffffXX where XX are the
a variable bits.  That's never going to be equal to xyz.cblk.

You could truncate it to char like this:

+	if ((unsigned char)~xyz.blk != xyz.cblk)

But then it works exactly the same as the original condition.

regards,
dan carpenter

