Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C0FCDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 08:23:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 617F8871AD;
	Thu, 19 Oct 2023 10:23:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lthQLteL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BAE0871AF; Thu, 19 Oct 2023 10:23:01 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D345F871B6
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 10:22:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40651a726acso66977135e9.1
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 01:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1697703778; x=1698308578;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ke2RxvGEdAc20SS0+zDV9Qfm+QXDWyQhDSVEhwDEYwE=;
 b=lthQLteLxEl3+BAvDTT7wzEOX8KexOtqQVwz3pLlZOsksPKz0LFSf+2Nud+ygefYDj
 LjpGKFrrGbzDy8/tNylSReJ80GJnVk/WIigLfJwbabvoBi5sxAS3bKOndzlPWvh+wpAF
 URcCu87F+IIsTkuk+hiLVTmK7iNn81bXS22FESjFWcBszrGZ1AEdVA1OULMOxY/AQcy6
 aZ3Z+WDzM2cQvqgPet3/xm8AJk8MWMA5UW0wZzAdJg1hyTIGAJ2MTr94minc8TuliY9T
 YJ/vHAwlrwhTj9734KunQZKPMGCNqNE4eZ+7QN70LnfebJQvwEjDplUwWuchJ6BaJ9+k
 cydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697703778; x=1698308578;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ke2RxvGEdAc20SS0+zDV9Qfm+QXDWyQhDSVEhwDEYwE=;
 b=BlkA8lFo+Nu5ha9OCA4pjBvTeD721QjD2Plzg41tiv1Lmu5KFFG7eLOjBKEM4Qto0i
 qco9jScph1d8RekinDpR5TW6HCyCfncU3v5qq1KVcKCwXywAGMKYbEAuO42x01b/yg2P
 Lpqjp4N53tUF16ahN7czmeD4hat3zjMp7rkx49Y9HeFahV+Idoe659c9UVR456GseNL7
 /Mbh6vn0/TBeAqbY8StxOi5TVGbr2awhlduYlLLOpAlgMmhoc+GNQ0lbQPutkJEN7Ry5
 TZzvedXz8/i6FKzJGDv9x38lInlEhdIBquRwir8agm2jkCSOYbTIMriKE42eFilhVfdg
 g0RQ==
X-Gm-Message-State: AOJu0Ywe58NL40zb/GxQtXXaSSdDFT/dqDiwWvHypLn3+578cC4eKRFR
 b0o4TkTRzkdgwlQ18H8ZwiTVAS4zw2itMBTtjd8=
X-Google-Smtp-Source: AGHT+IG2s9UY5sg1XjDRsmPRsDgmWxzZreZqRnGyu1LQ+EPBScvaoYHWfVXwpCvScTbds80/paxbrg==
X-Received: by 2002:a05:600c:1ca6:b0:401:b6f6:d8fd with SMTP id
 k38-20020a05600c1ca600b00401b6f6d8fdmr1228137wms.6.1697703777338; 
 Thu, 19 Oct 2023 01:22:57 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 g38-20020a05600c4ca600b004078d71be9csm3705288wmp.13.2023.10.19.01.22.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 01:22:56 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Subject: Re: [PATCH 0/2] MAINTAINERS: Add Mattijs to USB/fastboot maintainers
In-Reply-To: <20231019101812.2782fa2c@wsk>
References: <20231005-mattijs-usb-v1-0-7e79ab31ca49@baylibre.com>
 <20231018125220.4b08c62c@wsk> <87h6mnnjpm.fsf@baylibre.com>
 <20231019101812.2782fa2c@wsk>
Date: Thu, 19 Oct 2023 10:22:56 +0200
Message-ID: <875y33nhr3.fsf@baylibre.com>
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

On jeu., oct. 19, 2023 at 10:18, Lukasz Majewski <lukma@denx.de> wrote:

> On Thu, 19 Oct 2023 09:40:37 +0200
> Mattijs Korpershoek <mkorpershoek@baylibre.com> wrote:
>
>> Hi Lukasz, Marek,
>> 
>> On mer., oct. 18, 2023 at 12:52, Lukasz Majewski <lukma@denx.de>
>> wrote:
>> 
>> > Hi Mattijs,
>> >  
>> >> From discussions with Marek at Kernel Recipes, it seems that the
>> >> USB subsystem in U-boot need some help.
>> >> 
>> >> Since I've been asked and I'm willing to help, I've added myself to
>> >> the maintainers entry.
>> >> 
>> >> I have also added myself for fastboot since I'm interested in
>> >> keeping that functional as well.
>> >> 
>> >> Note that I have no previous (open-source) maintainer experience
>> >> so I will do my best to learn.
>> >>   
>> >
>> > Thanks for willing to help with maintaining the code. If you need
>> > any help - then just ask :-)
>> >
>> > Acked-by: Lukasz Majewski <lukma@denx.de>  
>> 
>> Thank you for acknowledging. I'm both very happy and a bit nervous to
>> start :)
>> 
>> Do we still use the following custodian tree:
>> https://source.denx.de/u-boot/custodians/u-boot-dfu ?
>> 
>
> Yes.
>
>> If yes, I imagine I would need write access to it.
>> 
>
> I think that Tom shall have credentials to add you.

Great!

My account is created and approved already:
https://source.denx.de/mkorpershoek

>
>> 
>> >  
>> >> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> >> ---
>> >> Mattijs Korpershoek (2):
>> >>       MAINTAINERS: usb gadget: add Mattijs
>> >>       MAINTAINERS: fastboot: add Mattijs
>> >> 
>> >>  MAINTAINERS | 4 +++-
>> >>  1 file changed, 3 insertions(+), 1 deletion(-)
>> >> ---
>> >> base-commit: 65b9b3462bec2966911658836983819ab4e4823e
>> >> change-id: 20231005-mattijs-usb-6b83dde256f0
>> >> 
>> >> Best regards,  
>> >
>> > Best regards,
>> >
>> > Lukasz Majewski
>> >
>> > --
>> >
>> > DENX Software Engineering GmbH,      Managing Director: Erika Unter
>> > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell,
>> > Germany Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email:
>> > lukma@denx.de  
>
>
>
>
> Best regards,
>
> Lukasz Majewski
>
> --
>
> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de
