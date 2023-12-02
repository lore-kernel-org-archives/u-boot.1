Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A6C1C4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 18:28:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DE388774B;
	Sat,  2 Dec 2023 19:28:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HQ0K6xM4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E55B18773E; Sat,  2 Dec 2023 19:28:32 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4BE18773E
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 19:28:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5d3758fdd2eso29032527b3.0
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 10:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701541707; x=1702146507; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rWklXsUAvvlfsL3Yx0h5DfBLmH/uXh0uTqQ8ZnuhDhU=;
 b=HQ0K6xM4muS9rMyB44zi9FHiNZQCzaCsZqNYEbiHnzVpmKbyNvGi9DAjTkoNLLilpK
 +oOwKjYX/mAQI7qt/S5cy0bZ2NouUmAWUrBX7I9PWyRkDybqn8Zc0CXdENZP5TecVuqF
 M/uo4rCjUEYTYpbV55d6W4Duhkpy/iXJexJio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701541707; x=1702146507;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rWklXsUAvvlfsL3Yx0h5DfBLmH/uXh0uTqQ8ZnuhDhU=;
 b=KYpaxS2LWt9d7CMq1ilN/IguGBCRa/0aFxpJyMgeOHxYYQ/EXQpoHglsViuLPHtTR5
 P0FlJrddly5TV0vAy9ygdXDD+8U2jnRz39xn79eSLOUTZMz9/m5valx4dw3cTViAE9wh
 BIIJxRJ0njKKTglT58QDWSkmrZ9UIBgUgS80wlKNQDITaYZQpQInkFLQbyA24SErqY+F
 wEcKL4TpM+J6IFhyswO2s8mbcV1R9J9PkkBX5/UgS5bMsJSmf1D2QNdEZKCLm1LkU0ga
 Y9LBI/osrYbBJDnREyeaATtRZ1gg+CwzSgcqiNhpRAWTioGCY4bWJhXWkmw+IswGDiGg
 JGNA==
X-Gm-Message-State: AOJu0Yxf/1DJQBu/27JQp5wPxgsCcYmJMOlf2Sg7L64fcgumwGmSXPS2
 qUrnZdKlTy0IgpEoV1JhbDH+VF7JhLeRBiaG++kptA==
X-Google-Smtp-Source: AGHT+IF2PCheEsLbFFp5/N2SZaBoJL3frLrA/rwKyWJ9ieLOrjIA7uGzGGP5tSMPBoJ6sWn/X10nkYgKOjCjkC1yzqQ=
X-Received: by 2002:a81:4ec9:0:b0:5d6:fd56:d73e with SMTP id
 c192-20020a814ec9000000b005d6fd56d73emr1417659ywb.5.1701541707450; Sat, 02
 Dec 2023 10:28:27 -0800 (PST)
MIME-Version: 1.0
References: <20231127171058.165777-1-ilias.apalodimas@linaro.org>
 <20231127171058.165777-3-ilias.apalodimas@linaro.org>
 <CAPnjgZ2PtQQ81x-SqMs6NKSjMKFGShT65Rrtfc-CDOsdBxgJDQ@mail.gmail.com>
 <CAC_iWjJ52eK-v30T6XC1jHDDLvcuOX0p43PW8UCfakRPxMkQCw@mail.gmail.com>
In-Reply-To: <CAC_iWjJ52eK-v30T6XC1jHDDLvcuOX0p43PW8UCfakRPxMkQCw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 11:27:14 -0700
Message-ID: <CAPnjgZ2Ubr6kNfn+7bg+F_CV4H_wZMKaPq8F8njSfQNUF02+iA@mail.gmail.com>
Subject: Re: [PATCH 2/2 v2] smbios: Fallback to the default DT if sysinfo
 nodes are missing
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: trini@konsulko.com, sean.anderson@seco.com, neil.armstrong@linaro.org, 
 heinrich.schuchardt@canonical.com, mark.kettenis@xs4all.nl, 
 Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
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

Hi Ilias,

On Wed, 29 Nov 2023 at 23:50, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> [...]
>
>> > Changes since v1:
>> > - Tokenize the DT node entry and use the appropriate value instead of
>> >   the entire string
>> > - Removed Peters tested/reviewed-by tags due to the above
>> >  lib/smbios.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++---
>> >  1 file changed, 90 insertions(+), 4 deletions(-)
>> >
>>
>> Can this be put behind a Kconfig? It adds quite a bit of code which
>> punishes those boards which do the right thing.
>
>
> Sure but OTOH the code increase should be really minimal. But I don't mind I can add a Kconfig
>
>>
>> > +
>> > +       dt_str = ofnode_read_string(ofnode_root(), nprop->dt_str);
>>
>> Could this use ofnode_read_string_index() ?
>
>
> Maybe, I'll have a look and change it if that works
>
> [...]
>
>>
>> Any chance of a test for this code?
>
>
> Sure, but any suggestions on where to add the test?
> SMBIOS tables are populated on OS booting, do we have a test somewhere that boots an OS?

They are written on startup, right? They should certainly be in place
before U-Boot enters the command line.

> Any other ideas?

Probably a test in test/lib/ would work. We actually have
smbios-parser.c which might help?

Regards,
Simon
