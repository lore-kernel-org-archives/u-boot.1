Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA35CCF9F8
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 10:22:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86537836D1;
	Mon,  3 Nov 2025 11:22:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HHDKfbAl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15D0683700; Mon,  3 Nov 2025 11:22:08 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6865183642
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 11:22:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7c2878bdf27so2384914a34.2
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 02:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762165324; x=1762770124; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ItYtlW+q5uoGpMvxqjIFgCMQ9RxdaEIRIuz5NCsckb0=;
 b=HHDKfbAlE/+7D6661mcBOZ5QaR45y1HfRCAIl+JcMYOaGPIMsfJL9LfwTf/yBer06x
 lOW1iENAFs/H8j6+x1WfUwWBBF/+kxSP6XvFuRcG8mXiBBUktcA+sBTvpDTowZZyOoKM
 E66BvZGJ7XkadjdYe3d4zLmB80RCz3e5mnvgT04vIWajUrUS7SZN8DhvBbu8/tDSkUuJ
 i/H3ZDn9jFeobV2CtrfAQQzIfs9T00PgSB8P3oEVCbTN7u/MzazGbCD7H+Wv7vsRxn8I
 FJcb2oeBWlXJcLmxozP+wMrIi5oEdNZBIlTsxFVVz4wZYAAvDgymcGx+U2lSB+7kgyeR
 8cfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762165324; x=1762770124;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ItYtlW+q5uoGpMvxqjIFgCMQ9RxdaEIRIuz5NCsckb0=;
 b=GYlMZhqU4GysD7FJYrMz3d3HJEHZenenR7YeYszTvF2a6Lok2PoFlJA5Z+wR+qkLOl
 47xpxfdIZuWHt6+aPb0B7yyVRMN9GRdnhGythVzE44lMzw1XbreQu9RCworWv8/7PK+r
 ZKKMphJ7thAOmX80fjPSz3hZoPMBbwcM0atnQ4MC1bL8v9MLOyPkg3Is0tBulf3E2yBI
 Pe99qEEiGcmzgIktfu9t71wv0Qm2NGFtYduL7wAr6PLb0UbY4d+bOy0juJrMoB1/iiWW
 DrKvLFWKeRT5/6bMTRLfeH36oHcq17ELWHWcHE6g5xzrZ4w1P+hKUV++EtAfjJxOVwcm
 hT0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW57KZ9D/qQZx2L7oiVcATMWchmWtntZfWAEWgLicrtOiSZxQ6qgPmS+30LQz+lweJr+omv/Tc=@lists.denx.de
X-Gm-Message-State: AOJu0YyzOYEspEeQPHxRF3TniAce4QS5MKvSyyNu819Y9lOxLjsnTsUi
 qEojisHEo6mQNE7qG7/rcqtRWh0FrjTt4jt81/8JHQGdjlIr2xNSnJyKZEoysgZgSNk4Hp3BdWg
 1Qo7xZyvu7Wv8HOq53jGFSGaYzj29/LShH/hvOpc=
X-Gm-Gg: ASbGnctfLa4foX1jWT8cnivZiBbabA9RVZW+WpM9KhL1HxSdinP/ffvH7XPGzLgNR9M
 fuqdc7kz95TX1wCOY3NQ4QN+MlREYqVMrrN5vR755guJdJNCp/VkkeBcUkg27LEXCwkZqfsiD/8
 Dv5sL2jbsbcqlJet7LGEjfvtwn8bp0YAzRC4f1sQEIX6THzPifkck8yEj5uscCozo0o3BWwIYYU
 j85KpcGbpt4ixTY1BtsA0S0yjGOJlcv5E1OroJo44FIo5c/ZffHKpOi7E+csw==
X-Google-Smtp-Source: AGHT+IGgRcWzMcAIzSAQieJOM/q3oApTbjlG+sC0R1V9UB3aW2biEoiv5b9iN50Bj8HSUQRuIZNl7ZrLlvmhZOgkPyg=
X-Received: by 2002:a05:6830:4901:b0:745:9272:4a34 with SMTP id
 46e09a7af769-7c696727e0emr6717664a34.16.1762165324029; Mon, 03 Nov 2025
 02:22:04 -0800 (PST)
MIME-Version: 1.0
References: <CAN7C2SArdbhag_56MwOMGoaEYSLiHbHHo3KFhUS5U03ntEJbGA@mail.gmail.com>
 <0f8fa8d4-3cab-4555-af1e-03feaef81ca5@cherry.de>
In-Reply-To: <0f8fa8d4-3cab-4555-af1e-03feaef81ca5@cherry.de>
From: Sune Brian <briansune@gmail.com>
Date: Mon, 3 Nov 2025 18:21:53 +0800
X-Gm-Features: AWmQ_bnNvAFzRCUBYaW1mGEk4RgZcR_VNCSe0EW6hiO7ljyRPwM5mV-S86QXWm0
Message-ID: <CAN7C2SAENNStCB0nNfKRCmks85DporS=ZUprrQ6wCW0ZJXRrLg@mail.gmail.com>
Subject: Re: [DEBUG] rk3399-nanopi-neo4: SPL SD init may report -5 due to SD
 power-on timing
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

> Can you try to apply
> https://lore.kernel.org/u-boot/20251031145951.535376-1-c.stoidner@phytec.de/
> and see if it helps? It seems like the implem in U-Boot doesn't exactly
> follow the MMC spec and this supposedly fixes it. My RK3399 board has
> the vmmc-supply always on (not configurable by software) so I cannot be
> impacted by any change.
>
> If this isn't enough, you need to specify in the regulator node how long
> it takes for the regulator to be stable. We don't want an average, we
> want the worst case scenario so that all boards work, if you only have
> one NanoPi NEO4, then so be it use the delay necessary for yours, people
> can increase the delay later on so it unbreaks their unit as well. This
> is what Jonas recommended already.

> Quentin

Appreciated the suggestions.
But I had resolved the issue.
Turns out it is wrong on the delay path.
This is just my blind guess.
If you read through the mails, me and Joans.

The inherent solution is to comment out the regulator
in the SD node of the dts in order to sense the SD
card, but this is a very bad method.

The actual issue [1] and I have tried (works).
[1] Revert "power: regulator: Add vin-supply for GPIO and Fixed regulators"
https://patchwork.ozlabs.org/project/uboot/patch/20251101203429.1603832-1-jonas@kwiboo.se/


Bests,
Brian
