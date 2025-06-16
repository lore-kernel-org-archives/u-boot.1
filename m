Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10894C71159
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 20:58:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6159881E18;
	Mon, 16 Jun 2025 22:58:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="XPeNE5Vx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2351682B18; Mon, 16 Jun 2025 22:58:26 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A0BD81760
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 22:58:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fmartine@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750107502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8CTcsgRPEKsBpJv6NwEfjIqPfDnwgwswua+DqfvZls8=;
 b=XPeNE5Vxb6kKGxWtANq8uyx5a8dgLJWXRAJ5yyzcnJfEE0lJL/WEGE8vNe1829lD+OhlpK
 YLhroTUh+rEXtiHOeOfmPc93U2LqwReHLaxWyWv5r1iHPp4HImE/JAiaooqv8X8rhRfd9u
 OPNPGreFEaokWUWDFlgMODCtp1AvM+M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-s-x8-KpgNeSIsgj8P4R3jg-1; Mon, 16 Jun 2025 16:58:20 -0400
X-MC-Unique: s-x8-KpgNeSIsgj8P4R3jg-1
X-Mimecast-MFC-AGG-ID: s-x8-KpgNeSIsgj8P4R3jg_1750107499
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-450d50eacafso29457785e9.3
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 13:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750107499; x=1750712299;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8CTcsgRPEKsBpJv6NwEfjIqPfDnwgwswua+DqfvZls8=;
 b=lHJ2j4ecZS98aeY5ZcXZhdCnVhhJBSonIK14ehc25jZsEcDe/3qEgL0ngW1PejZIUR
 w3m8UDUM5SxhHPSgGNSYo9DV6Vxj9Z2+McC6/DzlhircIvPBMu96KxC8aHrQ346HcAS3
 4k9bHYMsgrlYABHIyUTfGWiT/fKTkQLkjUytWWrqePRMGqGPZ5ZqworI/JxtkIrPqD2q
 XwpeZpvE2OXXxLfuo+zME1MiGkSjIeO36DlZ9E8qllF11q5pvAhd+QVSIk2vvnVQfAXE
 /+UkwovxgXND2gPctP5LTASwQAyA/ZQ3773VnlVSbXdz+6P8/zhJjms98mznatCHJZpJ
 OvuQ==
X-Gm-Message-State: AOJu0YyXzyO2bm+KC6rOuuJDX9IQJq9eBzqpwr7VLWPQHT4y1E6CL5s4
 mEvq9L7HTGr+k/XPnEZjP2XxFHzIFZpvhTkU68rv/nTXSk6RPNS10jmv50sIkem/yjeJ4OQhlw1
 VD2EN81os0fqpKhMhuzM2LJcAjXf6V+p9Vy7kZytFldc0eS2/8ZjRSxw=
X-Gm-Gg: ASbGncubrUDCFajXrOG3UyDjxG2q4snrqsO8/YD/Jz9njBw8i0ELitBGu77NUchhiv2
 jli7O4PXQwLNAOdqSuEDh6xwgXm3yaEPqCco/gg5ED8claXuBcmaz+eWAVqaSrfsRf00JDMOLQi
 TuL6V9bshAsTxqckSAXr0cbcY5RzjkQ5zXTuiizrbWH/ti23cIs7HSnDjPz8Ydbg6JMxhEdazts
 WaoMEYrnQUNix2t/XwSdX0b87jTBo4VbW4aX0f6m9LsTpP2BxK+gO3NkPunGTvMzgmvL4fD+qjy
 fJn4bk0SQw/mw28XnfM0wwjgZ2qaPx2+/p21a/248C0239hyu3dAO5Xvv6dYE8AY+iDHbNGJjXP
 x1ZfM
X-Received: by 2002:a05:600c:3e8d:b0:43d:40b0:5b with SMTP id
 5b1f17b1804b1-4533cab7786mr78794645e9.25.1750107498788; 
 Mon, 16 Jun 2025 13:58:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZhsvu70B9ARsXqjRTGhD+dVr5Xg1r0sb8GaaN2yjWZYahszlOdmolOETgkBKA3Wbdchb2MQ==
X-Received: by 2002:a05:600c:3e8d:b0:43d:40b0:5b with SMTP id
 5b1f17b1804b1-4533cab7786mr78794565e9.25.1750107498407; 
 Mon, 16 Jun 2025 13:58:18 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532ddd29ffsm153690425e9.0.2025.06.16.13.58.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 13:58:17 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, Simon Glass
 <sjg@chromium.org>
Subject: Re: [PATCH] test/py: Re-add setuptools to requirements.txt
In-Reply-To: <20250616191632.GJ1382132@bill-the-cat>
References: <20250616185353.1733300-1-javierm@redhat.com>
 <20250616191632.GJ1382132@bill-the-cat>
Date: Mon, 16 Jun 2025 22:58:16 +0200
Message-ID: <87ikkvz9nb.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LlSWkFqUbWT2TaE1AhU0IA_UImi_XPjTrqWSDNjn7kQ_1750107499
X-Mimecast-Originator: redhat.com
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

Tom Rini <trini@konsulko.com> writes:

Hello Tom,

> On Mon, Jun 16, 2025 at 08:53:32PM +0200, Javier Martinez Canillas wrote:
>
>> The commit 859621b47f9e ("python: Recreate test/py and tools/buildman
>> requirements.txt files") recreated the python requirements but dropped
>> the setuptools module that is used by the test harness.
>> 
>> This leads to the following error when trying to run a test:
>> 
>>     pytest --build --bd sandbox test/py/tests/test_net.py
>>     +make O=/home/javier/devel/u-boot/build-sandbox -s sandbox_defconfig
>>     +make O=/home/javier/devel/u-boot/build-sandbox -s -j8
>>     Traceback (most recent call last):
>>       File "/home/javier/devel/u-boot/build-sandbox/../scripts/dtc/pylibfdt/setup.py", line 23, in <module>
>>         from setuptools import setup, Extension
>>     ModuleNotFoundError: No module named 'setuptools'
>>     make[3]: *** [../scripts/dtc/pylibfdt/Makefile:33: rebuild] Error 1
>>     make[2]: *** [../scripts/Makefile.build:398: scripts/dtc/pylibfdt] Error 2
>>     make[1]: *** [/home/javier/devel/u-boot/Makefile:2079: scripts_dtc] Error 2
>>     make: *** [Makefile:177: sub-make] Error 2
>>     Exit code: 2
>> 
>> Fixes: 859621b47f9e ("python: Recreate test/py and tools/buildman requirements.txt files")
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>
> It's not pytest that requires setup tools, it's pylibfdt. You're not
> able to build sandbox, is the problem. And that's a documented
> requirement for building U-Boot in general for a number of platforms.
> This doesn't belong in test/py/requirements.txt which is why the "make a
> requirements.txt" tooling drops it.
>

Got it. Sorry for the noise then.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

