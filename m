Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC651D5E154
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 10:39:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2151789082;
	Fri,  8 Nov 2024 11:39:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="i31UZZvc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C97E489083; Fri,  8 Nov 2024 11:39:01 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6754088B8F
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 11:38:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-539e13375d3so2241190e87.3
 for <u-boot@lists.denx.de>; Fri, 08 Nov 2024 02:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731062339; x=1731667139;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ChoqMoh2T+eig/XpTTE8Tcj5u81rqtdZXLhWcSY6EWc=;
 b=i31UZZvcMOeqPDuP4dsGKAQW5uHlojD78/aBZ95rxzQ5/npGlNEVJkjzFkYcmEFZqY
 LCZZsXB4WKEaV2270BsbitTcEGcnlcZA73gq3cLVTa2SxnDgv22FLrq1lCI9b4DDym1T
 WXYFr7vOvDnIDqjaXBqTO0qdjn/6ZHFOLmNJLUmcRsJeAdfEsAz9rFfbTCvq7a+rv935
 JTBH5LHpflvjL1fW2fCvd3P40mGNXU385qfTm9WkCvf24VsHaVzrJWRU/ivBtkgajc5A
 /VC0jrpzwqWgDS7S7LcsoQbLpMCIPrjBfRl1IbIhkqpx4H58q/+sOG0UqWY4oovQdxSF
 Rsqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731062339; x=1731667139;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ChoqMoh2T+eig/XpTTE8Tcj5u81rqtdZXLhWcSY6EWc=;
 b=ED68ClbUaoWLEOstshzCyM7W5+03xB26qZ+yUgTsu8R1sHZJ8gOZoQvEDO47YUjxmD
 XF+U/fyadnnLI/LYPWhb30riUaSTPF001cYSC1qAbHwLOpmNDafFaXpEQgPLkcQjxO17
 Jug3fpxjTcc9AQnZjIKGuER2d3U8FFgTniQZhqROmizbALKSoZERYaRlfg2tTd0V2mkP
 vHr/G6T4OxjxtPiIxeZhyujyvyMj08KRKInJySaTvX+Is+zUeca32M+k3YCB/h/KTcTA
 l8ueYEhP+5ZDGr2nU1oOumWzj9TAj7JqTuZ3YtenKkc1D908qSnBnaLgwvusMIXT9LZH
 9ZVw==
X-Gm-Message-State: AOJu0YwL2MERdp7oZqQp17mytbCmpgSMoz3XvCvriVk4MrqLWcMhab1Q
 sqhLTQBMQZe0YiP68xmTjJWVlMtV6o1ZmIpXldLlgJaePP2kO3Qhaaze2PPrL7A=
X-Google-Smtp-Source: AGHT+IFW8QVCN5MP2DyN8EOgoayKfgEaOrqjB9pOITOne1wJM368GLG5uI8OkEwJOgIwljEbs4P55A==
X-Received: by 2002:a05:6512:3d1d:b0:539:fc45:a292 with SMTP id
 2adb3069b0e04-53d8626c94amr1266790e87.43.1731062338516; 
 Fri, 08 Nov 2024 02:38:58 -0800 (PST)
Received: from localhost ([2a01:cb19:8f40:f900:f167:cb53:a707:1347])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b05c202asm59621335e9.30.2024.11.08.02.38.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 02:38:58 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Guillaume La Roque
 <glaroque@baylibre.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
Subject: Re: (subset) [PATCH 0/6] Add support of Android Boot Image version
 2 and non-AB image
In-Reply-To: <173106070708.3295577.5479637179760743078.b4-ty@linaro.org>
References: <20241017-adnroidv2-v1-0-781c939902c9@baylibre.com>
 <173106070708.3295577.5479637179760743078.b4-ty@linaro.org>
Date: Fri, 08 Nov 2024 11:38:55 +0100
Message-ID: <87jzde3t8g.fsf@baylibre.com>
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

On ven., nov. 08, 2024 at 11:11, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> Hi,
>
> On Thu, 17 Oct 2024 18:10:24 +0200, Guillaume La Roque wrote:
>> Actually bootmethod android only support android boot image version 4
>> and with AB image, some old platform wtill use android boot image
>> version 2 with AB or without AB slot.
>> 
>> This patchset add support of both version 2 and non-AB slot images.
>> It's fixed in same time a boot issue seen on khadas vim3{l} board with 16GB eMMC
>> 
>> [...]
>
> Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)
>
> [3/6] configs: khadas-vim3{l}: fix userdata size
>       https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/895b54998e57a5d099c09915341dd9312e0ad7a7

Great, thanks a lot, Neil !

>
> -- 
> Neil
