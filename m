Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E5FC54E58
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 15:13:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 668408807F;
	Fri, 15 Mar 2024 16:13:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="vKffYRXF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 973FD88074; Fri, 15 Mar 2024 16:13:12 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A61387FEE
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 16:13:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ptosi@google.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5684073ab38so4157476a12.0
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 08:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1710515589; x=1711120389; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZBdYuGQYh97THsVhymEVwlxMAqVgoZGKEHaRhrvJ3z4=;
 b=vKffYRXFL4dcFb3yQ72Vx+by5jwsqptkcNMQmN8T/6CvhHK9OMEO4tTUHErjqghSji
 fyPLWh8J35oJilSMf1Q7VkTVQMJPFywZHgFW0M4qQE3wH6IkdEtmsq7Mwr2imzI9ynNm
 9b5EfKPW76GjdV8wNooLZr5NZMIK+JANhJdxlb3Du/0w2eJHTMPvXdG4Ha0QW7dCXpRA
 MtBF99MeMoLCP9xOgYQTGASgBbgB1iFEwAsE3Rufe1W1t/irR55c34eG7YgI4B1Rt+Cp
 qLhiSs8AEI7egU5Tw1FOjt8HuOMNBIu8iyTm0foxyUwVAyTConLOAdce9cr6NoXL7rw0
 P62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710515589; x=1711120389;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZBdYuGQYh97THsVhymEVwlxMAqVgoZGKEHaRhrvJ3z4=;
 b=fZnYDrp6Uem3UDK+lZoLsG13Aad6vhbXy7wA6AQcqsDYV8NhwMKuAaM5QniEOfI9Uy
 Yw9VdypHcWxA8DBhdlzr3oCxGkbLaT1B1w8g7VJHFeeF0/E35nuo8S/gJXiJsXzaZRoD
 SZkFT2HdsNVTghvmt8Z+Eqt45scJr/6+kmJbcSQIqdkXuJI9jw6KahxotzXfKTli5bs+
 b9IyJFBSsSoWi6B7SMcvBJYJm24oe6L4aP8ehd71f6jhBf/lgd8uFqBcEjq7FuOryv8e
 74t1S3CPgdKQLPEM7u0JM3nXZa250y/lIlu532Zo5XLuk2z64vrDkQZ82FIEBBkGAIGp
 +QBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnRVaIthGiOQVCPjYQLiHbfNzAaUGZcD702SIfQGxEoSVLllSYPr/FtVc5fjZf4Bj+NHg8bG3oKphkrDuxT1NQFGSYXA==
X-Gm-Message-State: AOJu0YxembmzwZGQgSzzpCqLA5EJsxhNBaHZd6YLPHjvygKW+slm00cp
 J0qbY/4Ej+LjR5M60N6XtQriim45V5pOy1CoooJuWbEadgETQwas0MQNSViYgw==
X-Google-Smtp-Source: AGHT+IFjpFPmK/mTxDEaiv2t0JYp/LRD9u38bisiYXgC1gOs8oOCWM09GKcj/MB8WAV0XBN1k7MPSg==
X-Received: by 2002:a05:6402:550b:b0:568:14e4:12a4 with SMTP id
 fi11-20020a056402550b00b0056814e412a4mr5383115edb.11.1710515589152; 
 Fri, 15 Mar 2024 08:13:09 -0700 (PDT)
Received: from google.com (64.227.90.34.bc.googleusercontent.com.
 [34.90.227.64]) by smtp.gmail.com with ESMTPSA id
 v21-20020aa7d655000000b00568a08a9aacsm1610908edr.22.2024.03.15.08.13.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 08:13:08 -0700 (PDT)
Date: Fri, 15 Mar 2024 15:13:04 +0000
From: =?utf-8?Q?Pierre-Cl=C3=A9ment?= Tosi <ptosi@google.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Marc Zyngier <maz@kernel.org>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH 1/2] arm64: Reduce add_map() complexity
Message-ID: <vozturnswioy4b46tp5j45tq4kv7gnfkklwnw2bipn3mi3q2zi@4f4q2bwf7qun>
References: <20230214133814.4173549-1-paul.liu@linaro.org>
 <20230214133814.4173549-2-paul.liu@linaro.org>
 <CAOMZO5B=EYPSNXkr=FM+iRvRYiv9fysB8DfhntuhQ_jhkKz38Q@mail.gmail.com>
 <875xxvratg.wl-maz@kernel.org>
 <CAOMZO5DBzEcga0-QGBBP3twT6imLuCv0cD6EYLOTwGN47wTxsA@mail.gmail.com>
 <87zfv7pojq.wl-maz@kernel.org>
 <CAOMZO5AMi_5XqYUodPcfiFtbn9A7P1HVn__F-BLavLqnwMeNkg@mail.gmail.com>
 <CAOMZO5CqH1OuVQDNH7+CuzPbBt9M8F7OOhDgCZZ0ad7rBfT52w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5CqH1OuVQDNH7+CuzPbBt9M8F7OOhDgCZZ0ad7rBfT52w@mail.gmail.com>
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

Hi Fabio,

On Fri, Mar 15, 2024 at 08:56:17AM -0300, Fabio Estevam wrote:
> Hi Marc,
> 
> On Sat, Mar 9, 2024 at 11:36 AM Fabio Estevam <festevam@gmail.com> wrote:
> 
> > Does the log below help?
> >
> > https://pastebin.com/raw/1i1VBA0a
> >
> > If not, please send me a debug patch and I will be glad to run it here.
> 
> I'm sorry to bother you, but have you had a chance to look at the log
> I shared with you?

I had a quick look through your logs and notice that U-Boot master attempts to
map addresses in the high VA range e.g.

  Checking if pte fits for virt=ffffffffe4000000 [...]

while the logs that boot successfully only use the low VA range e.g.

  Checking if pte fits for virt=80193000 [...]

Unless that has recently changed (since I last worked with U-Boot), U-Boot on
AArch64 only supports identity mappings and therefore was only taught how to
program TTBR0_ELx (i.e. is only able to map low virtual addresses). This means
that the code - with or without 41e2787f5ec4 - would be unable to map addresses
such as 0xffffffffe4000000.

Now, given that 41e2787f5ec4 only affects implementation details of add_map(),
I am surprised that reverting that commit changes the arguments received by the
function such as virt. As a reminder, add_map() is exclusively used on mem_map:

  for (i = 0; mem_map[i].size || mem_map[i].attrs; i++)
          add_map(&mem_map[i]);

> 
> That's the only issue preventing colibri-imx8x from booting mainline U-Boot.

If I read the U-Boot configs right i.e.

 - configs/colibri-imx8x_defconfig: CONFIG_ARCH_IMX8=y
 - arch/arm/mach-imx/imx8/Makefile: obj-y += cpu.o
 - arch/arm/mach-imx/imx8/cpu.c: struct mm_region *mem_map = imx8_mem_map;

There is a possibility that your mem_map is getting modified by MACH-specific
code. In particular, enable_caches() seems to dynamically get the MMU mappings
from some RPC mechanism (see get_owned_memreg() and sc_rm_get_memreg_info()).

Could it be that whatever services those requests might be returning unexpected
values? Instrumenting arch/arm/mach-imx/imx8/cpu.c and dumping mem_map (and
the RPC messages) with/without the patch would help clear this up.

HTH,

> 
> We would like to get this fixed for U-Boot 2024.04.
> 
> Thanks for your help

-- 
Pierre
