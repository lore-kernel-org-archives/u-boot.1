Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E48C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 00:46:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 903C78701B;
	Tue,  7 Nov 2023 01:46:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SAxSk6As";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 968D48701B; Tue,  7 Nov 2023 01:46:46 +0100 (CET)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F0BE869DA
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 01:46:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-41eb4210383so14614981cf.0
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 16:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699317995; x=1699922795; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lu4aa0oDnm3RlC1ApyxBYVtZ6rIiI1Cju15fW4cm5cU=;
 b=SAxSk6AsNvoAQOr/BKfZ+rCJp+rW3TYZINMvq03IVURYMlONYi0+GJA0uKvleaCkuP
 8WA2Yqty53Z96OowCq9IIi9+4037R4vHtli8n7+qn7XdyCVmLNIwtnfF0+pPL2aoG2tv
 CT3aYUEdj98MgjAZc2ah/r0c3aakjLlL8OGJIAXxjMUQMaczLQatXj91P+sGTAJ0AR/S
 mUDRd9GEXBhNZ9tw/0pigTnPFY/a795vq++l7WsyThMA0SWehEGcxwgfHvIlFIF96XG5
 3LrYwHAH6xdpeVe8r1GuMremUx/VGjBkndXEP2sN0AT/Tr1Fw4oCr/38pt6FyyAtT50R
 U5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699317995; x=1699922795;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lu4aa0oDnm3RlC1ApyxBYVtZ6rIiI1Cju15fW4cm5cU=;
 b=Z1n9GQ9heg5AQg0ydOG509U9hUeJqlF+y1+6uDR8qHJZsfUv66u7u2kEmPFQJ23McO
 /caYjs+yzg4XLiqCQPSG/op4Ys4qVoljVUIrZVQPXFwtF1LrfzrkH4wjszo1op43Y5y5
 AbRsSsGvLAsRU0kFHvBndWYTfIlZAVV9izaVuxXtC1IWGpGJk5pj6/ASc0jxEyNA+dIh
 nOswsKjb/FVEnUq9DGE5iVQwDbGmhI+GHjp+rJV/qfh6jTW0hehHyAWY5F4liCtvM750
 pgSo5eQlHPokVHfCm9TJD8Q4MuuZVdlQqXJ6CRVMBHdHQqfjfxMbcumCGBtQf51XeB8E
 6phw==
X-Gm-Message-State: AOJu0Ywbjyc5f4gFWWBMTFBD+33U8f5SvOx7ox67i2O20CplndvB1XE1
 Rfb+eGhrAPR8Nt5t8W1k9KU=
X-Google-Smtp-Source: AGHT+IGLZTZxYT55EnxzuhXLyguq0gb7xyExQyhwJ2SnUb2CTJcUwnjUX4+hRnxgkwZLp5ILPOGV5w==
X-Received: by 2002:a05:622a:1a16:b0:41e:280d:4e28 with SMTP id
 f22-20020a05622a1a1600b0041e280d4e28mr38266364qtb.40.1699317994809; 
 Mon, 06 Nov 2023 16:46:34 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 ew3-20020a05622a514300b0041520676966sm3883376qtb.47.2023.11.06.16.46.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 16:46:34 -0800 (PST)
Message-ID: <3c84d65a-fe72-8fe1-6f64-7065889641ea@gmail.com>
Date: Mon, 6 Nov 2023 19:46:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 5/4] mkimage: update man page and -h output
Content-Language: en-US
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>
References: <20230919113705.109639-1-rasmus.villemoes@prevas.dk>
 <20230928080257.2650461-1-rasmus.villemoes@prevas.dk>
 <20231011183722.GT3119521@bill-the-cat>
 <5801c81b-8bfa-6e65-6176-f94299520a62@prevas.dk>
 <15b9b0dc-ed38-5b15-f9a4-411e412f3c25@gmail.com>
 <7b7878a9-c0dd-4d3b-b888-2a6a190109f2@prevas.dk>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <7b7878a9-c0dd-4d3b-b888-2a6a190109f2@prevas.dk>
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

On 10/13/23 14:30, Rasmus Villemoes wrote:
> On 12/10/2023 04.17, Sean Anderson wrote:
> 
>> I was hoping you would respond to my most-recent email regarding this
>> series.
>> In particular:
>>
>> | Why does mkimage have to do this? Can't you just use truncate or, in a
>> | binman context, align-size?
> 
> In both cases, that just affects the size of the file, but does not
> affect the totalsize field in the fdt header.

Use `dtc -a` then.

> Wrt. binman, just as I was somewhat misled by the short mkimage -h
> output into thinking that this already worked as I expected, binman's
> fit,align documentation can also be read that way - and the
> _implementation_ certainly currently unconditionally translates a
> fit,align property into a -B argument to mkimage. So if we don't want
> mkimage to support a -B by itself, binman documentation and code would
> probably need another patch to reject that as well.

Yeah, that's a good idea.

--Sean
