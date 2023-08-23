Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78ED5EE4993
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 15:11:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A51638645E;
	Wed, 23 Aug 2023 17:11:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NXFQGZRb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 970BA864C1; Wed, 23 Aug 2023 17:11:22 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE6238640C
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 17:11:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-986d8332f50so766699066b.0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 08:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692803480; x=1693408280;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ZqyPI1IwWtVCVEoN00hhKd+gUzlhrNfZ+bem0GSaO0M=;
 b=NXFQGZRbqJvU6p/BWcDvv4jgVsmjipYUf4540ZK9rqWRJm9MWn6wuoyby7o8i29Fa0
 7AtgQqZil0EUVwAVSQE5khfitf7rR8LbW5P9eDAeFWBxIkyPLDWZMVEprpVOK5RXUeGX
 q/m+EzaOVcxK3YP6v71J2kocUPktXepJxk6yCxaDpbCkiz0wstePdBasfR/G60okcDj5
 /Z+72YN8wzy2WCzu7SFhLzV4fC+8zZZu8awV9CxDflagyOkNwKXUBNF5wuE9XWzTuDxc
 2uAioxXDU4M/52O9nz4AYS7rwx9bB3tHWg3CcWb2sMQGD9tXFRs/CQlEODoOXMVdYdP4
 9FGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692803480; x=1693408280;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZqyPI1IwWtVCVEoN00hhKd+gUzlhrNfZ+bem0GSaO0M=;
 b=hXXo0UYhttx26uxVOnSiD/LCCtXKum44MvLQzYSQpZR3pekpqMIjJJGZrZARPkP08L
 SVTotmHOomImWvfBvyi5YPFgppFDw0GS5SKGMsIojI8kXUhOKWC1bFr400Md5W0SPLAB
 d0Z27WDLiFzfrOzIwmqwgR8dEuP9QdT3/o6ttPaSD7QZP1p/0LaSohHpEYaXiWQ6xk6Q
 tqT38RqGKYqEdz+bVKnun5ldK6uEjhS2cDJG66NSjTqcvlhCAHnkreJTU0N+QtJ/CmfY
 YVjyyUkl4WQpuqGhFunhdo67k7736fQJopuMXAp+g8sFj6WuMXkE9jhoG3kyCsct3tIk
 Fcqg==
X-Gm-Message-State: AOJu0YxhVN0QI7Np49WgZGKDrK9viIP9xIwhPjlrxZldwaAWoj5JLdld
 vRiRXFEycGGhC1FuZRiNkE4CrFboimfa1g==
X-Google-Smtp-Source: AGHT+IHd5+MUJmklM5MBrmEfeXqcONhrXm9Z8bD1eTck1rH2DUMKCcORBMKZyNwjemYSG/FNkVlrwg==
X-Received: by 2002:a17:907:7715:b0:9a1:f21e:cdfe with SMTP id
 kw21-20020a170907771500b009a1f21ecdfemr940977ejc.58.1692803480082; 
 Wed, 23 Aug 2023 08:11:20 -0700 (PDT)
Received: from [127.0.0.1] ([46.211.148.241]) by smtp.gmail.com with ESMTPSA id
 ci16-20020a170906c35000b0098e34446464sm9896560ejb.25.2023.08.23.08.11.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Aug 2023 08:11:19 -0700 (PDT)
Date: Wed, 23 Aug 2023 18:11:18 +0300
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Simon Glass <sjg@google.com>
CC: Thierry Reding <thierry.reding@gmail.com>,
 Thierry Reding <treding@nvidia.com>, u-boot@lists.denx.de
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1_17/19=5D_ARM=3A_tegra=3A_dt-set?=
 =?US-ASCII?Q?up=3A_convert_TrustZone_remove_into_config?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAPnjgZ2G6V3WqO6ZP4Fsuuz4AWKV6LMQ4Fxmk=nRmOsEZ7zpag@mail.gmail.com>
References: <20230822112217.4646-1-clamor95@gmail.com>
 <20230822112217.4646-18-clamor95@gmail.com> <ZOXq0SrF9h0Z9uHw@orome>
 <86A72122-840F-46B1-9C25-0B6F5AFB82A1@gmail.com>
 <CAPnjgZ2G6V3WqO6ZP4Fsuuz4AWKV6LMQ4Fxmk=nRmOsEZ7zpag@mail.gmail.com>
Message-ID: <B16634BB-1C5E-4AA5-83AF-AE6037A03B44@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
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



23 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80=2E 17:54:21 GMT+03:00,=
 Simon Glass <sjg@google=2Ecom> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=B2(=
-=D0=BB=D0=B0):
>Hi,
>
>On Wed, 23 Aug 2023 at 05:47, Svyatoslav Ryhel <clamor95@gmail=2Ecom> wro=
te:
>>
>>
>>
>> 23 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80=2E 14:17:37 GMT+03:=
00, Thierry Reding <thierry=2Ereding@gmail=2Ecom> =D0=BD=D0=B0=D0=BF=D0=B8=
=D1=81=D0=B0=D0=B2(-=D0=BB=D0=B0):
>> >On Tue, Aug 22, 2023 at 02:22:15PM +0300, Svyatoslav Ryhel wrote:
>> >> Remove of TrustZone nodes is required by many product devices
>> >> which require repetable calls of same function from device board=2E
>> >> To simplify this, TZ remove is converted into Kconfig option=2E
>> >>
>> >> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail=2Ecom>
>> >> ---
>> >>  arch/arm/mach-tegra/Kconfig    | 14 ++++++++++++++
>> >>  arch/arm/mach-tegra/dt-setup=2Ec |  7 +++++++
>> >>  2 files changed, 21 insertions(+)
>> >
>> >I kind of preferred the original because it's very explicit=2E There's
>> >also no big advantage in consolidating this because the code is unlike=
ly
>> >to ever require changing (the libfdt API is quite stable and these nod=
es
>> >are all hard-coded anyway)=2E This new variant put non-generic code (i=
t
>> >requires a Kconfig option after all) into a generic place, so it seems=
 a
>> >bit backwards=2E
>>
>> So you say that I have to add same function to boards over and over for=
 all devices I plan to mainline? Unneeded code duplication in action=2E
>>
>> List of devices which need this:
>> - transformers t30
>> - transformers t114
>> - grouper
>> - lg x3
>> - endeavoru
>> - tegratab
>> - wexler qc750 and basically ALL t30 and t114
>>
>> Ok, fine=2E Dropping and moving on=2E
>
>Where is the binding for this node? I have never heard of it=2E

This is manipulation of linux kernel device tree=2E Vendor bootloader can =
establish trustzone while u-boot cannot since vendors do not provide trust =
OS image=2E To have a compromise linux trees have trustzone set which allow=
s them to boot on vendor bootloaders, while u-boot removes it before linux =
kernel boot allowing the same tree to boot on u-boot as well=2E Without rem=
oving those nodes linux kernel will just stuck=2E

>Regards,
>Simon
