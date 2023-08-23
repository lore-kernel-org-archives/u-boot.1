Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66712EE49A0
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 11:47:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD09C864B6;
	Wed, 23 Aug 2023 13:47:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AsjWPN1m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAB30864D2; Wed, 23 Aug 2023 13:47:15 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9438864A6
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 13:47:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-99357737980so725983466b.2
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 04:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692791233; x=1693396033;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=6ifTN7WuZGrU3fIhHGpiYbeKy77ExnX+IsH/KVWN0Fk=;
 b=AsjWPN1mVmmanTbAs79Xuv33CbtrBzH309BQI/XKJfWQKNrnp0k1+wYaWb72KkAQtA
 LyxkzyA/R4VGyTlxD2cfyCyU6ldghOqFUeun8G2+86VAWlFaTMoWy0VqixV9pU1GPCrz
 Is30T2ejPAEHseAYCc1bhJnEHh85uWr+8zB7wJ3YW1ZFSgIMjkrIVbten3OIlXe5lkdb
 G58odLmf+hpiciEvlxIQBPDH+FH3uxCHnPE89L09dDFGu320LFQo44UShX38Z2YmnjI2
 UeDPUrV7uZPaJK9UM0ECkrM2a+JJv2KvW+VbBGsjKfy6yYC037slt9t7hcU93CFSHCd6
 DtOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692791233; x=1693396033;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6ifTN7WuZGrU3fIhHGpiYbeKy77ExnX+IsH/KVWN0Fk=;
 b=NIAYXY9cT2on/mH3OOOO892NhLXRPPv0gEglRI4QkRJdbQZ551z+FjWTz7rPWJcgOI
 lFDn/i8fty1aG6pERRTW72OAtXgzK2t8Xp5IcQnf3eAxoTvbLhDmHNMSRg4H2JOzF3pE
 /Vj/sRHiD93mYV0470zmCLEorAutlYQscWtAZAi4whxnbdZn9f2Am0o5gbDtwtpNap8z
 GGv6Ya83vtI+V5JyLDk45RkWji3QrqXECRHSvAc85it1epfSGVzDItA0BySwpoSD+xU5
 08hEJlepOCgsk+FT2ngpMhXEx41puln6H33+SETbL1L7zqnM1KksPR3qANVXiXXU1JvT
 +X2A==
X-Gm-Message-State: AOJu0Yz2ybEwGfLSzuHfPhsccxzCowJ5I81jGDGy5QSLvrqgHAHH8F4m
 7+GYhE6kEXrYcDx6pWudBWGwDANSzjuyBA==
X-Google-Smtp-Source: AGHT+IF4WCV65sMBIgxtqDLPrlBn8bmlCEVDed/WukYnPKnK/5ZXXG8pJcDhoVQ7az6IgLdW7sWTNA==
X-Received: by 2002:a17:906:3018:b0:99e:6a0:5f64 with SMTP id
 24-20020a170906301800b0099e06a05f64mr10363187ejz.36.1692791233125; 
 Wed, 23 Aug 2023 04:47:13 -0700 (PDT)
Received: from [127.0.0.1] ([46.211.10.167]) by smtp.gmail.com with ESMTPSA id
 dv11-20020a170906b80b00b00997d7aa59fasm9830566ejb.14.2023.08.23.04.47.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Aug 2023 04:47:12 -0700 (PDT)
Date: Wed, 23 Aug 2023 14:47:11 +0300
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
CC: Thierry Reding <treding@nvidia.com>, u-boot@lists.denx.de
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1_17/19=5D_ARM=3A_tegra=3A_dt-set?=
 =?US-ASCII?Q?up=3A_convert_TrustZone_remove_into_config?=
User-Agent: K-9 Mail for Android
In-Reply-To: <ZOXq0SrF9h0Z9uHw@orome>
References: <20230822112217.4646-1-clamor95@gmail.com>
 <20230822112217.4646-18-clamor95@gmail.com> <ZOXq0SrF9h0Z9uHw@orome>
Message-ID: <86A72122-840F-46B1-9C25-0B6F5AFB82A1@gmail.com>
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



23 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80=2E 14:17:37 GMT+03:00,=
 Thierry Reding <thierry=2Ereding@gmail=2Ecom> =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=B2(-=D0=BB=D0=B0):
>On Tue, Aug 22, 2023 at 02:22:15PM +0300, Svyatoslav Ryhel wrote:
>> Remove of TrustZone nodes is required by many product devices
>> which require repetable calls of same function from device board=2E
>> To simplify this, TZ remove is converted into Kconfig option=2E
>>=20
>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail=2Ecom>
>> ---
>>  arch/arm/mach-tegra/Kconfig    | 14 ++++++++++++++
>>  arch/arm/mach-tegra/dt-setup=2Ec |  7 +++++++
>>  2 files changed, 21 insertions(+)
>
>I kind of preferred the original because it's very explicit=2E There's
>also no big advantage in consolidating this because the code is unlikely
>to ever require changing (the libfdt API is quite stable and these nodes
>are all hard-coded anyway)=2E This new variant put non-generic code (it
>requires a Kconfig option after all) into a generic place, so it seems a
>bit backwards=2E

So you say that I have to add same function to boards over and over for al=
l devices I plan to mainline? Unneeded code duplication in action=2E

List of devices which need this:
- transformers t30
- transformers t114
- grouper
- lg x3
- endeavoru
- tegratab=20
- wexler qc750 and basically ALL t30 and t114

Ok, fine=2E Dropping and moving on=2E

>Thierry
