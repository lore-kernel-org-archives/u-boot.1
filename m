Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCA6C10DCE
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 11:36:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D16886E5E;
	Wed,  6 Dec 2023 12:36:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hB/rGieX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DDFE86EEB; Wed,  6 Dec 2023 12:36:23 +0100 (CET)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E69686D10
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 12:36:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2c9f751663bso49177731fa.1
 for <u-boot@lists.denx.de>; Wed, 06 Dec 2023 03:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701862580; x=1702467380; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GNFCqsP2pJAVf7wSeSfWbKyGNhFkHRXjBQPzhJRDjqE=;
 b=hB/rGieX2sm20mZLYIwbzKdmZ0LmFDAPAs0k+Ps50c5rm8KR//06n2W0mdbsb+1D/I
 CooaWXUm5+AetdPB2G+Uf68yU2/oG1r6JGHLb4uUAEMVsWr7wn+gPZv2PQn7Yb01pstH
 WBtUqlyJsxm4gomnd2/KtAO2ouSlyIrcF4tBCzaa3NV5NumBPdiZ7WEzFPb6NqhbZv5s
 LixU1VxG77HNlyWaNsMCaAYl6tX8WVJ3/kP40c6MQAGsmI6xZZPE+q78FjbXj5wdnrgj
 px+ZjjqcXFEFBbq1xDSpt8QYoIi410UznLCVePiwzKer+FNKbbthvYMBPsji3C9rTkxO
 EEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701862580; x=1702467380;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GNFCqsP2pJAVf7wSeSfWbKyGNhFkHRXjBQPzhJRDjqE=;
 b=tRTCeYZpbVlpnMiBjuulrxx93aJUyxNTMY9TJF3EbSmtvZmiTgfCsBj4oqEyNWbicF
 Mchoyr/MzDrf6NaeKDAQZ/fX2OnuNa9BZwnSkY1b/f5iFkx/Fw2n84D3wS7G/JGuXjbD
 G+OWUV5gKIjfe4q/4iEprFw4B9qICn74mLhZfHDs7V6pmmgKAbQC13zqgdRjSwWZK1hT
 XbsnYAzUsrLF7QJNJWnrkHYgulamXm1EM6LY5RZZXVOHChQLTCqxV7VhxfC9vuX3R/18
 QUNNJZANJTtz52YXOemDqa7tu0WVSYbruXUsV4OpTRJ2bm1GPmr3OuxR8y9olgvEG3KW
 7rcg==
X-Gm-Message-State: AOJu0YzLbzDTeM4/zG4ttef/UM3zgImXqahFNrKZ9/2O2jO43h3NDF91
 XATkyBoWe7r/QNGL6ZAgoSasmz2WNfqbBd2MRrHecQ==
X-Google-Smtp-Source: AGHT+IE0dSX/ez/xTWYo36/h3JBOw7kBSFAnITuRD6RRRiO2LGtMmIUYV1gMiopSXgLg8d3J1BNg1KUmhNc2dHE+Mlw=
X-Received: by 2002:a2e:8005:0:b0:2c9:fece:5be6 with SMTP id
 j5-20020a2e8005000000b002c9fece5be6mr253857ljg.54.1701862580494; Wed, 06 Dec
 2023 03:36:20 -0800 (PST)
MIME-Version: 1.0
References: <20231127171058.165777-1-ilias.apalodimas@linaro.org>
 <20231127171058.165777-2-ilias.apalodimas@linaro.org>
 <CAPnjgZ2Vo22gasW05um2og==yRoC33YB3eW=xXVt2dE9xqDgVw@mail.gmail.com>
 <CAC_iWjJE=-rOhOLVe4d7sUH8DEJjn5hdHoHpKe70d4gmB7---Q@mail.gmail.com>
In-Reply-To: <CAC_iWjJE=-rOhOLVe4d7sUH8DEJjn5hdHoHpKe70d4gmB7---Q@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 6 Dec 2023 13:35:44 +0200
Message-ID: <CAC_iWjLrmk2AwxoO8tDtG8notrLQuSdRtqzLpTzBRuM1QO0wzw@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] smbios: Simplify reporting of unknown values
To: Simon Glass <sjg@chromium.org>
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

[...]

>
>>
>> >                 str = "Unknown";
>> >
>> >         for (;;) {
>> > @@ -151,8 +151,7 @@ static int smbios_add_prop_si(struct smbios_ctx *ctx, const char *prop,
>> >                 const char *str;
>> >
>> >                 str = ofnode_read_string(ctx->node, prop);
>> > -               if (str)
>> > -                       return smbios_add_string(ctx, str);
>> > +               return smbios_add_string(ctx, str);
>> >         }
>> >
>> >         return 0;
>> > @@ -231,7 +230,7 @@ static int smbios_write_type0(ulong *current, int handle,
>> >         t->vendor = smbios_add_string(ctx, "U-Boot");
>> >
>> >         t->bios_ver = smbios_add_prop(ctx, "version");
>> > -       if (!t->bios_ver)
>> > +       if (!strcmp(ctx->last_str, "Unknown"))
>>
>> That is really ugly...checking the ctx value looking for a side effect.
>>
>> Can you not have smbios_add_prop() continue to return NULL in this case?
>
>
> Hmm I don't know, but I wonder why I am not just checking t->bios_ver for Unknown.
> I'll have a look and change it

Ok, this can't be changed as easily.  smbios_add_prop() will not
return NULL in any case. It returns an integer. With the cleanup, it
will always writes 'Uknown' and not return 0 anymore.
I can add that default value you suggested but the ctx->last_str is
still used on the next line anyway.

Thanks
/Ilias

>
> [...]
>
> Thanks
> /Ilias
