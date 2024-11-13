Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF534D462B8
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 14:47:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3422389349;
	Wed, 13 Nov 2024 15:47:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aUz9il79";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CE7A8934F; Wed, 13 Nov 2024 15:47:20 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 127CC89270
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 15:47:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a9ec86a67feso1216426366b.1
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 06:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731509237; x=1732114037; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bpGI2Z6Yo/AxMVErfINXkhzaKlvTzGjKC/nw//UulC4=;
 b=aUz9il79i78cl/EbSSDkGFzAr2hFCdrakDuR+xUrZrznFE0r1+Om81lpd5ZQAehjp2
 4ruK0hxuFqW+L4fbGkV5o5yiFSh+ehusz0RVBt0ZApfv1Mr0RWoOSg0Rc/QGbvURXHd3
 x/3YHKV2/dnVdHmpVBmB4GH4XnTaZmt2cEe3IzRGcdkLpPdiB01RagbNKgWsm2WrqynO
 i2ngHB5HG+585MoXyZPcnb3oIb8P5XLjMDl0eYBfw2if1kFbUWpu/NZMnMFcMpDtwWkq
 82eYZ5dGaED0Bqn95gSqefP/bTaFDbhhzoiS0fJzH2NNU7EkX5klg03aJTXp0Wnu0kp0
 tzcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731509237; x=1732114037;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bpGI2Z6Yo/AxMVErfINXkhzaKlvTzGjKC/nw//UulC4=;
 b=hK5JJBCzlgSZdnO3Cgy4QPJzIupm+NcDl052uz3sFidSmKf8qB5BYnWR3ib8ozv46w
 fB8c52VupopBa2uY84HHS7pzQY+nLsilqJxR7R8RhSAxuzGNfg32n6PXHHb18GVsVAAU
 jXFJqic0R9s+LDARyXW6O3SnBLxMjuQ6QPSxlRVkgEhhqPqfr1KScyndcifPze3Og6lh
 7CWWFCW5f5/DgP6pVIpGo073xqqtmKyaYS7RonkjBdpyz4Hanx4JJP1fEta9gGoOExtA
 Wa0rFaAscxTjiWNjksml0r7xRZkVx009rS3fkad2JyicSaIPax+e0fZFjD9eGEOgc9rY
 +Qxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPlJAYIoeBxK/VAlnhIaiTCeSK8/EWQbCOlRGHgbctSlkGBvqHqrqwvmZpgIlC3y1gTpGUAJ8=@lists.denx.de
X-Gm-Message-State: AOJu0YwEOcikb71kp3AgC8Qie4/2ePsDYioTRLpsxRDjnkcErJ1Aw4sc
 WsimeAHlnZTExOYjAiq47W39WVdY6w/lH4frMb1yE6Fu3PN0ALNjZd2Dk4CC5Vw=
X-Google-Smtp-Source: AGHT+IFI46rhxAzqIAQlnbUd2+RFmxP09myPTPB3EAU94s1lVbTpozGxlJAKe/Opn7mff1nyIDedgA==
X-Received: by 2002:a17:906:3a92:b0:a99:f8e2:edec with SMTP id
 a640c23a62f3a-aa1f8926fc4mr225211566b.21.1731509237387; 
 Wed, 13 Nov 2024 06:47:17 -0800 (PST)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0e2e3ffsm887039266b.183.2024.11.13.06.47.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2024 06:47:16 -0800 (PST)
Message-ID: <5fb2f6ab-c47d-4ea0-83bf-a14d8e737cb1@linaro.org>
Date: Wed, 13 Nov 2024 15:47:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: don't print 'MMC:' if there are no MMC devices
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Dragan Simic <dsimic@manjaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Simon Glass
 <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 u-boot@lists.denx.de
References: <20241113053023.1870736-1-caleb.connolly@linaro.org>
 <20241113142437.GM3600562@bill-the-cat>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20241113142437.GM3600562@bill-the-cat>
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



On 13/11/2024 15:24, Tom Rini wrote:
> On Wed, Nov 13, 2024 at 06:30:08AM +0100, Caleb Connolly wrote:
> 
>> It may be the case that MMC support is enabled even though the board
>> we're booting on doesn't have any MMC devices. Move the print over to
>> the print_mmc_devices() function where we can only print it if we
>> actually have MMC devices.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> 
> I'm not sure I like this. What we do / don't find on startup is part of
> the not-exactly-API. It's true that if we don't print an MMC line at
> all, and we should have MMC, the user (and any scripts that parse
> console output) but now we're also increasing the code size a little bit
> too. I can be convinced this is a good idea, but I'm not there yet.

Hmm, fair enough. I'll offer some more context, maybe there's a smarter
approach here I'm not seeing.

The main place this shows up is on Qualcomm boards. Since all Qualcomm
armv8 targets are supported with qcom_defconfig (just by adjusting which
DTB is used), we can't know at build time whether the board has MMC.

I guess my thinking behind this patch comes from a bigger picture desire
to get UFS and MMC more aligned. The number of devices with UFS is
definitely going up, and I would argue that U-Boot's inconsistent
treatment of these two storage classes (obviously a result of their
relative age and support in the codebase) is really unintuitive and
weird for users (nevermind that the "scsi" command is used for UFS
devices, cute though it is).

I'm really wary to open this whole can of worms, since I guess it would
require some larger efforts and collaboration to fix. But maybe this
patch (or one like it) would be better suited in the context of some
larger effort to unify storage backends?

Kind regards,
> 

-- 
// Caleb (they/them)

