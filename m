Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79056C27C79
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 17:41:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9350884CA;
	Thu, 20 Jun 2024 19:41:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kxXqL00h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3EF686784; Thu, 20 Jun 2024 19:41:47 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D80E888223
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 19:41:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=knaerzche@gmail.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42179dafd6bso14353795e9.0
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 10:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718905305; x=1719510105; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D1FBI2J0vpJB1j3ekokfwFvoPDzbkAO9krCqqxSoiXM=;
 b=kxXqL00hYzoaprCVYmX46EYjXW755KpGJa752wBGeaomwrirNZPIwbw+qresFIEvhm
 opc/A37iNXTBaAfI76eqo/isUXjU3ugzcqNsbvEnMYLEet7mb5lT47YDioiwia3E332P
 g1IhNG/7k0kxmO6kJDSD/5ntQYdfapVB5PpGVa6m7SL49onSgthC6PRXhFjEQAoPFH+z
 T243fhCTd4E3C+n+pp5oCJbZAKhBGadNp0whKsz22Ir4fufbc/zPLZ+BX0hW4BSBpO/c
 R4GODRAFynnjc2CD0PPFhkWgAOcAsBclpqyOCWLeKbuqPX3JiIdJiItXGQG5rP2pT91d
 FcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718905305; x=1719510105;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D1FBI2J0vpJB1j3ekokfwFvoPDzbkAO9krCqqxSoiXM=;
 b=ckun6LflJm01x6r2LgI+n6uukYOJLORqPFOUs5kGAxkHMkUFq/HnX4MEXsbzY8H7aj
 3LzGUbLHGf2b/hORYCciCKdtzmxghWdt9MjrjlcItpFBGf9YR4cQ6HGoGE1aIb/WDm2m
 7LQIeC4gjlT1r/66caH38l9p6UDWzhhpi3DDNzyplUPKQjqhVFgnc4vL3UiKZP6SPhT7
 1qtYyNwt1Et6VeF3KsjW4tRydhesPwEWreDNszDsXignfTUEsjDZ8ov+Xt4Mcop4vhv3
 t7Qzu4n3L5OYxp6h0aNrUGgHirCvnIoKaA8TFY6cTyRFgMa6CuR5+8UYgXxE8LtZGUjr
 q3Xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU99IynpcaEFc7ebqiFJoOvMf37yz70DfuCju4Pcj6clPonCMFkPzUOkwbKv9V8jhYB98qmKY+oP+xnQZB8zvuu8tgdlw==
X-Gm-Message-State: AOJu0YzINXQ0vdblXqEnjD4MVgnQZRt5hJWllbiiKSnuz5joJS9bSqvX
 Gl+5yoImsBSxUKlYz8QE5dBFNeDwxPHYfIIWlFvQ9mtV5eQDjUI=
X-Google-Smtp-Source: AGHT+IFPMhRcOQjo997F3dWkCcizKbRLUioVxMY0Ifei3JkLoVqdyW3IZ+3w+w9u5uO17q9kxnimtw==
X-Received: by 2002:a05:600c:4449:b0:424:7eb8:963a with SMTP id
 5b1f17b1804b1-4247eb89733mr19821355e9.7.1718905304783; 
 Thu, 20 Jun 2024 10:41:44 -0700 (PDT)
Received: from ?IPV6:2a02:810b:f40:4600:67df:1240:90e2:3b31?
 ([2a02:810b:f40:4600:67df:1240:90e2:3b31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4247d0c9e27sm33354635e9.23.2024.06.20.10.41.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 10:41:44 -0700 (PDT)
Message-ID: <d5f90fe2-230d-477b-8d4e-ff6088acebee@gmail.com>
Date: Thu, 20 Jun 2024 19:41:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 2/2] rockchip: remove support for Theobroma Systems
 RK3368 Lion
To: Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <foss+uboot@0leil.net>, Klaus Goger
 <klaus.goger@cherry.de>, Heiko Stuebner <heiko.stuebner@cherry.de>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20240620-tsd-http-git-clone-v1-0-666e8d6a8949@cherry.de>
 <20240620-tsd-http-git-clone-v1-2-666e8d6a8949@cherry.de>
 <09a91cfd-080a-4c39-8887-c36b42fc8ba2@gmail.com>
 <20240620170830.GQ68077@bill-the-cat>
Content-Language: en-US
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <20240620170830.GQ68077@bill-the-cat>
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


Am 20.06.24 um 19:08 schrieb Tom Rini:
> On Thu, Jun 20, 2024 at 07:03:26PM +0200, Alex Bee wrote:
>> Am 20.06.24 um 12:24 schrieb Quentin Schulz:
>>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>>
>>> No meaningful changes were made to this SoM since February 2021. Nobody
>>> from Theobroma has booted anything recent on that product since July
>>> 2021 at the latest. The product isn't available to buy anymore and
>>> disappeared from our website.
>>>
>>> This product is therefore unmaintained and it would be disingenuous to
>>> say the opposite, so drop support for RK3368 Lion.
>>>
>>> If you're a user of Lion, feel free to revert this patch or contact our
>>> sales/support department.
>> That's a pretty interesting support-strategy. While I really don't care for
>> this board, please don't go ahead and remove the whole TPL-/SPL-part for
>> RK3368 in yet another pointless "cleanup"  only because lion was one the of
>> last/only user. Even if EOL RK3368 is getting finally interesting in
>> regards of display pipeline as we are finally getting a OSS gpu driver [0].
>> I'm planning to add a board which uses TPL/SPL soonish (when my rare spare
>> time allows).
> Please update the MAINTAINERS file for the relevant to your future
> platform, or even better possibly get a skeleton of this platform
> posted. Thanks.
>
I don't think the whole platform would get removed as it has several users
(and is maintained) - I just was a bit worried that TPL/SPL support could
get removed, but now noticed there is one more user: evb-px5. So: sorry for
noise.
So I will go the usual way via upstream DT (linux tree) addition and so
forth.
