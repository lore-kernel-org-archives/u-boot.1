Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2055FC2BD09
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 13:01:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D2F0885CF;
	Fri, 28 Jun 2024 15:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FT5ncdCw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CA08881BC; Fri, 28 Jun 2024 12:23:12 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7ED1B87D40
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 12:23:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a72517e6225so53092066b.0
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 03:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719570190; x=1720174990; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MqsgQ1eLQ0uiSW4nlzjnB3sCbmoe62JZW1v1i4GDWP0=;
 b=FT5ncdCw019tx7FsJuF6aBWLKo+HWyZZIzlZ7s50jpE6MTztDPIeZOOUs2tzkdsjtT
 0IxCbrmYnHRjqdNyKvw7JKjxCxI6InRKxCfUHR9CY1U8ap3WUxGA2yp5yPFmR/r6gNbI
 +mu6C8P+Kfql/TWuo8LxA4F418QplWcKN4YM62O+T1+gc8/GUqBV1CtYAmMO/ngGAAWp
 mzvoF1RhhPS4x2qQ6Am/NE6DgPIwDJzfUDm2ogWgxJPvdvGb39ua9V4y41H5rJmUF01l
 W1FNXUV9nvuQB5hyehI9TP7We1dJazsGLsQOMxBaz5NQ0LG/GE5InjtDRfUF+oyYAEIX
 WjZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719570190; x=1720174990;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MqsgQ1eLQ0uiSW4nlzjnB3sCbmoe62JZW1v1i4GDWP0=;
 b=eSFK0Nk8jp1SjZnZ4j8ztYyPqTVqn31N5gmHeSL1bdkOcBaWRbhivMhzfH6nyL03GG
 e1RvMH1jX9A7aElwOKS12FJAdcutBZzITXGe0qZuQGbgkarvm4RO7+BU/ERnc8a0laC7
 RPIT2dhzaAU0TV70aL0kO6BGoFT1r7CVekkXAhz69uKS03ctTB8jwVEEQFSKlEqcygBr
 eKF9Q8kY+g0BDAprhiWkEWXRtmrjrrZyv/oRKRbzTAQu2uZ+QLlnttx4dr2pfFhStzPR
 cAGpviRKzskOPmzwltbQ34AAc1L7WpDN37iAqRtwyuGyUkrvWulF7TXOK9CCiG0zkmPt
 WM7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrkvebdPmRlsH/XsLB1FE2RMMmXlV12PGwvTnmRFFq8zZnc8kQpiCfriUwFRFJ4P4Hk4m25sAvZUYO5rbCwh4wT/fy8w==
X-Gm-Message-State: AOJu0Yyj0iv83WVFOwkgza5d6UnCaCvowGJ9SO3d4oCx2vrC/6mbnpfl
 /mZ4lH44orKXGLTuyi/hw0nv9KgyhqRPl97sMtg7ZPRZyKs1t1isMjgR9A6Mb6Q=
X-Google-Smtp-Source: AGHT+IENOK4lyqsP/C8G9OL/LSuejh4RLzbOPyh/vsC53PQVajvsTQbEU6Pj24oQWwBk6lN+2hZQPQ==
X-Received: by 2002:a17:907:874e:b0:a72:8323:4298 with SMTP id
 a640c23a62f3a-a7283234518mr590607166b.68.1719570189850; 
 Fri, 28 Jun 2024 03:23:09 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::18f8? ([2a02:8109:aa0d:be00::18f8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72aaf63914sm65811366b.87.2024.06.28.03.23.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 03:23:09 -0700 (PDT)
Message-ID: <7fcaa045-2d27-483e-84d1-72c0434854d2@linaro.org>
Date: Fri, 28 Jun 2024 12:23:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] power: regulator: Trigger probe of regulators which
 are always-on or boot-on
To: Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Ben Wolsieffer <benwolsieffer@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>, Dragan Simic <dsimic@manjaro.org>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Kostya Porotchkin <kostap@marvell.com>, Matteo Lisi
 <matteo.lisi@engicam.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Sam Day <me@samcday.com>,
 Sumit Garg <sumit.garg@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, u-boot-amlogic@groups.io,
 u-boot-qcom@groups.io, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20240626235717.272219-1-marex@denx.de>
 <CAFLszTjwbWdKqs_UBqXvr2F2ahoGd0-BFE-XLNr3-uq73ZLFHg@mail.gmail.com>
 <b84e8b10-8698-41f2-9648-0b3f5c399b02@linaro.org>
 <CAFLszTijRhB1dRraPBQSTU3ypJ_wJU7yghJ9c9Rk-XcbcfvkFg@mail.gmail.com>
 <38150a1b-6c71-4b42-a8ec-6b0de8ad6848@linaro.org>
 <CAFLszTg078XuQ5WxUVvMktA95zZm+PHs+MtVu2eL-xZYYkHxFA@mail.gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFLszTg078XuQ5WxUVvMktA95zZm+PHs+MtVu2eL-xZYYkHxFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 28 Jun 2024 15:00:50 +0200
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

>>>>>
>>>>> This is reading a lot of DT stuff very early, which may be slow. It is
>>>>> also reading from the DT in the bind() step which we sometimes have to
>>>>> do, but try to avoid.
>>>>
>>>> Could we set up the livetree pre-bind? What about MMU? On armv8 at least
>>>> this would have a huge impact on performance. I've done some
>>>> measurements and there is at least 1 order of magnitude difference
>>>> between parsing FDT with no caches vs parsing livetree with, it's huge.
>>>
>>> That seems like a great idea to me, in general. The fact that SPL sets
>>> up the MMU on armv8 makes it more practical.
>>
>> Well, on qcom we don't use SPL (yet?), we did have a cyclical dependency
>> since we rely on DTB for the memory layout, although I have some patches
>> to do all the memory parsing in board_fdt_blob_setup() since that's
>> needed for multi-dtb FIT. So I guess we could enable caches at the same
>> time.
> 
> Yes...it seems that enabling cache in SPL has become common on armv8.
> 
> As to the memory layout, I'm not sure what is happening there, but it
> seems that the DT does not describe it in general (at least not until
> U-Boot adds the nodes).

I suppose this depends on the platform. On Qualcomm we use DT as the 
source of truth as it lets us support many platforms (with totally 
different memory maps) with a single U-Boot binary, at least for 
development this is quite nice.
> 
>>>
>>> But for this series I believe we are going to have to define what
>>> happens in what phase. We have power_init_board() which is the old way
>>> of doing this...but perhaps we could use that as a way to start up
>>> regulators which are needed.
>>>
>>> As to my question about whether this happens in SPL / pre-reloc /
>>> proper, I forgot that we have the bootph tags for that, so it should
>>> be fine. The main issue is that in U-Boot proper we will re-init the
>>> regulators even though that has already been done. Probably that can
>>> be handled by Kconfig or a flag in SPL handoff.
>>
>> Ensuring that it isn't done multiple times sounds like the right
>> approach to me.
> 
> OK...I wonder how we can solve this. Needs some though.
> 
> 
>>>
>>>
>>>>>
>>>>> Also this seems to happen in SPL and again pre-reloc and again in
>>>>> U-Boot post-reloc?
>>>>>
>>>>> Should we have a step in the init sequence where we set up the
>>>>> regulators, by calling regulators_enable_boot_on() ?
> 
> Regards,
> Simon

-- 
// Caleb (they/them)
