Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01143C67861
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 09:50:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8380C87BF4;
	Tue,  9 Apr 2024 11:50:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gGICipYA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E50F87C7E; Tue,  9 Apr 2024 11:50:26 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 299128799C
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 11:50:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-416a208d496so4232585e9.1
 for <u-boot@lists.denx.de>; Tue, 09 Apr 2024 02:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712656223; x=1713261023;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=L8gvry7XBOMNBjaMQJtbs1f6XpMxC22JG0XNUwcgM+g=;
 b=gGICipYAeLMYMTvEzsPIa+lnMuVeMvC81gGrd3bLu6BURc8JNGo4UhYZPWlasKonMV
 UL/84mW/ZXmPWGp6hOQKAaRROJAlsnRYhqFstp+Q7wqUDlikFoHZBfCBoB1zYo90tJ1b
 wce9/N5HViKNTz8l33S72KugwBgSdpQ3gIBMyoYIY8mLhCTNhu8XEfVpi8f/0SNtA6Tz
 wRRFzQfMbfyIaVmLiVGWdj/3yFBqJiq+wMmKXsHv5SzK92R1h4Gxm+wyMe7Ro+0OboVv
 GtehZzDYJVdh0Aj8GZUPY0pkSjEmagaih4e0QQEH0ESawW+4JNeqo9JaVxRkLqWucp1x
 tO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712656223; x=1713261023;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L8gvry7XBOMNBjaMQJtbs1f6XpMxC22JG0XNUwcgM+g=;
 b=plUn/DAOkCClScYyQYVgdtq25RuYFKX8oSfJaLh2+rBW2KFuRgAnyG5IaU5SjHm6B8
 ZXoMTbQYv0ymXIL1oZIQ+9dY5tZRU7EIa1Sr2NKIXfvV3E6XzMzoPd1oPx7+0Iqg3XTF
 hAdvLnt1IDFDXwLLCpYQu/4C71MkYAjmu2ApLDXKvB/HGWzp1Q1zc1q75g5crjOyqdAW
 2/FMSGAjyt9o8NfLQly2xb5p4fLz07XA0zuGIxdTg5ySascD5VSs32iix/sT06TbS1ca
 2rgNZ02UxC54lrbaw4CoggJTT1cUjrx0MdQpkJbSA0JiyHRj7Ixc1QTsUntqzc+YNJ1n
 7F2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHZg1pgWpxBehMKRp3rv8Eoq1CRumQtsmTid/x93dZxczQFz1cK+ZmatHNkR0QIbyz2KAChNjs8KLp7m2fUj1H1OSM9Q==
X-Gm-Message-State: AOJu0YyrecjnucOXj76UJ3Kw9RPGazm6ngg9qZ6cYGI6/ncVOlEIT5xi
 B57DYKChA+Tnn5H1mvJcRy0iKIHTntFBYWiOcGlgtgBKRguJfvsDfNsNmbmikhA=
X-Google-Smtp-Source: AGHT+IGuW2ba8VuJ6m+FVLMeKHZTxjAVieAMSP5JR78146gb+hv0sxUKv1HdyDbCAZocO3PldD/BCw==
X-Received: by 2002:adf:f4c8:0:b0:33e:363b:a7dd with SMTP id
 h8-20020adff4c8000000b0033e363ba7ddmr7789139wrp.20.1712656223611; 
 Tue, 09 Apr 2024 02:50:23 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 d4-20020adfa344000000b003462374f350sm1134476wrb.26.2024.04.09.02.50.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 02:50:22 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Subject: Re: [PATCH] doc: build: update docker image to latest
In-Reply-To: <20240408201107.GC6531@bill-the-cat>
References: <20240405-doc-container-img-v1-1-f1e0ec59f5d9@baylibre.com>
 <20240408201107.GC6531@bill-the-cat>
Date: Tue, 09 Apr 2024 11:50:19 +0200
Message-ID: <87pluy50h0.fsf@baylibre.com>
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

Hi Tom,

Thank you for the review.

On lun., avril 08, 2024 at 14:11, Tom Rini <trini@konsulko.com> wrote:

> On Fri, Apr 05, 2024 at 08:16:19AM +0200, Mattijs Korpershoek wrote:
>
>
>> commit cacc0b2678c0 ("CI: Move to latest container image") updated the
>> docker container image.
>> 
>> Reflect the change in the documentation.
>> 
>> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>
> I'm fine with updating this for now, so:
>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
> But I think longer term we/I should reword the section to be clear
> that's an example syntax not a "recreate the current tag" since only I
> can push that result.

I agree. I will do another reword later to explain where to find the
reference image (pointing to .gitlab-ci.yml)

>
> -- 
> Tom
