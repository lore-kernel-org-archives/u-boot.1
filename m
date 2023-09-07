Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C9DEC875B
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 21:46:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2634186996;
	Thu,  7 Sep 2023 23:46:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g+R751GB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E81D686A3C; Thu,  7 Sep 2023 23:46:15 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18B9186995
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 23:46:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-1d544a4a315so1063880fac.3
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 14:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694123171; x=1694727971; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GHBwlAFbO4DJPJFYm6e7sAqFbZdcACTmO3tMhietBRo=;
 b=g+R751GBEsH+3orQ22rcKhaP9toR9ILPZfXFygGuXurq95o6wAirmXJ+6JCxgw40bq
 31n4JjQ/mbEWgymgTfIxqBb5M2hhcFabk8z0XsFqHG6+33mZ68FLe++IdFEU3ONcs48C
 kEFf3LFRZFfeN6lIz+B3LBYOYBuHenvRfWTN/dgMaZiacsyhzDu3iTamCauR5Ol9MD9u
 oeebj8lc2U0qViqyRyt6woqQZiFBnQXtuJAe4geKRMXPy3x/1FuDWJjBv/feorQ72J33
 UPasrovkdYnajYiyaPdPI7gDeq2Y728ANwnqgOEoBIYbZQ+l/F81GJYbDCMvRKrj8m7r
 Yj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694123171; x=1694727971;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GHBwlAFbO4DJPJFYm6e7sAqFbZdcACTmO3tMhietBRo=;
 b=T2uKQ86OR2MjiE0Ldvax3sDkcaw2DAcsGUdrUTg1J+TC5gclVhJW8NVYQy1j0MXhrU
 zfbK4/lUY4l8nPxXkxzkvyIdWbrOQHk2udtq8XWN1OLvadKH1h1LFoddfY2MgI/1qhqu
 1URKK2GfCaJYIZwoJoWGijGpvrpojVAyMEkfj3z9zWiabw8XnEFJ/il1PB87VjG8IYrz
 dJ4zm6wqmCRVb6AsG8rrLZSyW5AEWiDBJp6myp5MlUZM22GTtY5StJo9NsRfW6uKTfdc
 qDKXWGMpH4yfllV6Yj3W7orr22hYE4oeA85NAw98l2Er8Q/Qis3lzZYq96zI1Xhkkzhz
 GAdw==
X-Gm-Message-State: AOJu0YxLteOsvJjSqDpcgueO20zwU5oFyEy/TDfh/QLyvOR3UhzogSLZ
 10J9MJmJUdNItiZOPStPdtA=
X-Google-Smtp-Source: AGHT+IG/G0+osPABYXxySnR3o1wfwSAStxkgL6DZ283yAl+SowS+lZPYF4MAhDlC85XpHNFNIS6sog==
X-Received: by 2002:a05:6870:51c7:b0:1b7:308e:6cd9 with SMTP id
 b7-20020a05687051c700b001b7308e6cd9mr967165oaj.5.1694123171609; 
 Thu, 07 Sep 2023 14:46:11 -0700 (PDT)
Received: from ?IPV6:2001:470:42c4:101:5e8a:6beb:5c9f:2779?
 ([2001:470:42c4:101:5e8a:6beb:5c9f:2779])
 by smtp.gmail.com with ESMTPSA id
 br9-20020a05663846c900b0042b0ce92dddsm71004jab.161.2023.09.07.14.46.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Sep 2023 14:46:11 -0700 (PDT)
Message-ID: <1e85f9ce-f3df-fb56-9855-59fb7cb70a67@gmail.com>
Date: Thu, 7 Sep 2023 15:46:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 0/4] mtd: ubi: Enable accessing RO filesystems in UBI
 vols
Content-Language: en-US
To: hs@denx.de, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Kyungmin Park <kmpark@infradead.org>
References: <20230812000606.72319-1-CFSworks@gmail.com>
 <5e986e31-388b-3e48-2a48-04bbd61651f0@denx.de>
From: Sam Edwards <cfsworks@gmail.com>
In-Reply-To: <5e986e31-388b-3e48-2a48-04bbd61651f0@denx.de>
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

Hi Heiko and Simon,

Thought I'd follow-up to keep this discussion going. The main thing I 
would like to decide first (as it lets me start relying on it in boot 
scripts) would be the UBI access syntax:

=> ls ubi 0:rootfs /boot
=> ls ubi 0:2 /boot

Do those look good? Should I be trying to mimic the accepted syntax of 
fs/ubifs/super.c:open_ubi()? Perhaps "ubi 0!rootfs" and/or "ubi 0_2"? 
Not using ':' leaves open the possibility for logical volumes (LVM2/UBI) 
to contain partitions - not that I expect anyone will want that. :)

Cheers,
Sam
