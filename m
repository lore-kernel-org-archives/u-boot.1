Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72039C02199
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 12:23:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A42F680821;
	Sun,  9 Feb 2025 13:23:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JON78W4t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C132180834; Sun,  9 Feb 2025 13:23:46 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B8D080805
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 13:23:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5dca468c5e4so4278891a12.1
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 04:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739103824; x=1739708624; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fmNhYKCkWEP7YJ0NB5ISWJndER//XZgTNBkKSMI+eM8=;
 b=JON78W4t8S7if1NAgum/tFYmtcUpMX4SuIAqUEFOcxL3FkqF08tttQXIDwUwOBY9Xg
 8a4/U54sd2IT1Th+I1MHx2rtndWezysKdI3GFgjv602X1/y/LmQ+4eWfqetHZ10N7UlG
 PBYGs5DdX7zJ6o6OWqKKjPpSlUDvWjU4sYw5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739103824; x=1739708624;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fmNhYKCkWEP7YJ0NB5ISWJndER//XZgTNBkKSMI+eM8=;
 b=S8n1rxPHpsvSCUW4g8S4iS1Z6spbOWqV8D1vrWKNDZujXhqsINcheINgMieLrbQ8KR
 8C8Ky7GCNGguWJU658h76o4fFj70p2tfY54LfsLjOCzF+LsTiktMw3QWUepSVg+XtnRu
 y8gcbT3fmN1+MUF6ZU4ryOwEDpGiP1DNiZdKrpNocF1dCj8mg+fEOcRpm8yBtUcGpc8f
 0tRuYbsxcB3mwYpfGeMRki+mILdaBEjI3fXfnJSV1Kuzn7OeX4XCfobU1+XCI4Y/Q09g
 BfQPtmUKQZrvjc5hzo20Ut4mCvZ3UDWTZZ5zQL7Gi0+5gA/EBacEkFkGqYronUXx+Tia
 ZQTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWI3otJnWJy3Yr+AHYOe80MBgi00k63exN/B4IL5bf5XKMjOHWqZvWOWBjqKOe4YqYO1KSgyM=@lists.denx.de
X-Gm-Message-State: AOJu0YxfWM1i7ntWqEcwLuJqMexBY2EAjZC6kYUkZ7KHHEe4gEr5+RIR
 m7oaHcsZKhDLBGZhkc/y0fSG74MoEgaAw7tn7qrhwRqh8XR/qLy9bM1mEXNK2dORqhcpMGiZbgY
 AyBxJ4jMwcl396Vu5THWKlv9ubO/+myQKYXMv
X-Gm-Gg: ASbGncvooTHH8O5MZqb2VuoQI51ynLBERV/wlXvlOOIT6zxdm50yxwQtM/fPZ8o1YBM
 HNtQlvQwbWgydqbhQ7npBSOmB1qh7+Avv6x2aAT6VbPsDeX5AqcqXo1b3zYEdNzINQRNspccwVA
 ==
X-Google-Smtp-Source: AGHT+IGvQi2nnCFnRUJH0ri2but80iLfQlKGlVcWnIR9eTrodYda9H4e2BxMP/pIELLb1qL5k9uqX8ojVUSpKgW4Lt8=
X-Received: by 2002:a05:6402:a01c:b0:5dc:72e1:63ee with SMTP id
 4fb4d7f45d1cf-5de44feb981mr12763220a12.6.1739103823968; Sun, 09 Feb 2025
 04:23:43 -0800 (PST)
MIME-Version: 1.0
References: <20250207172116.117749-1-heinrich.schuchardt@canonical.com>
 <20250207172116.117749-3-heinrich.schuchardt@canonical.com>
 <CAFLszTiDkiMmAaNq1KuJ-hRonJhg2-Qis2V-EZhEyamFBfuAAg@mail.gmail.com>
 <CAM=mAOkhXskRtmmoS5vohy3a+-MYKqYpG+nW=oVn2AfVrnhDog@mail.gmail.com>
In-Reply-To: <CAM=mAOkhXskRtmmoS5vohy3a+-MYKqYpG+nW=oVn2AfVrnhDog@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 9 Feb 2025 05:23:32 -0700
X-Gm-Features: AWEUYZkb9u3hQoMhUJTuA0vC0XJGYdrTBxzoreHlU_8Ve6DM3S4NYz9QDvoeKmE
Message-ID: <CAFLszTiB5U-pNYoR3T8qBKvtPH6g6HU=QMdKE_AeWo+V64ojpQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] riscv: dts: starfive: DeepComputing FML13V01 binman
 config
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Hal Feng <hal.feng@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>, 
 Sandie Cao <sandie.cao@deepcomputing.io>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, E Shattow <e@freeshell.de>,
 "E . Shattow" <lucent@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 "Leon M . Busch-George" <leon@georgemail.eu>, 
 H Bell <dmoo_dv@protonmail.com>, Lukas Funke <lukas.funke@weidmueller.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Matthias Brugger <mbrugger@suse.com>, 
 Andreas Schwab <schwab@suse.de>, Nam Cao <namcao@linutronix.de>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Heinrich,

On Sat, 8 Feb 2025 at 12:57, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
>
>
> Simon Glass <sjg@chromium.org> schrieb am Sa., 8. Feb. 2025, 18:16:
>>
>> Hi Heinrich,
>>
>> On Fri, 7 Feb 2025 at 10:23, Heinrich Schuchardt
>> <heinrich.schuchardt@canonical.com> wrote:
>> >
>> > Add the DeepComputing Framework motherboard (FML13V01) to the binman
>> > include for the starfive_visionfive2_defconfig.
>> >
>> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> > ---
>> >  arch/riscv/dts/starfive-visionfive2-binman.dtsi | 17 +++++++++++++++++
>> >  1 file changed, 17 insertions(+)
>> >
>> > diff --git a/arch/riscv/dts/starfive-visionfive2-binman.dtsi b/arch/riscv/dts/starfive-visionfive2-binman.dtsi
>> > index 4cce001e80d..63289405fbb 100644
>> > --- a/arch/riscv/dts/starfive-visionfive2-binman.dtsi
>> > +++ b/arch/riscv/dts/starfive-visionfive2-binman.dtsi
>> > @@ -16,6 +16,16 @@
>> >         itb {
>> >                 fit {
>> >                         images {
>> > +                               fdt-jh7110-deepcomputing-fml13v01 {
>>
>> fdt-1 is better than repeating all this information multiple times
>
>
>
> Thank you for reviewing
>
> Non-speaking references like fdt-1 lead to coding errors. This why we don't call our C variables i0000 - i9999.
>
>>
>> > +                                       description = "jh7110-deepcomputing-fml13v01";
>>
>> That should be a description of the board, e.g. its marketing name.
>
>
> The devicetree jh7110-deepcomputing-fml13v01.dtb has
>
> model = "DeepComputing FML13V01";
>
> for this JH7110 board. I could make the formatting a bit nicer.
>
>>
>> > +                                       load = <0x40400000>;
>> > +                                       compression = "none";
>> > +
>> > +                                       blob-ext {
>> > +                                               filename = "dts/upstream/src/riscv/starfive/jh7110-deepcomputing-fml13v01.dtb";
>>
>> This should not be blob-ext. It should be using the normal:
>>
>>    u-boot-dtb {
>>    };
>
>
> Then probably all occurrences should be updated in this file.
>

For this board I see:

CONFIG_SPL_OF_LIST="starfive/jh7110-milkv-mars
starfive/jh7110-pine64-star64
starfive/jh7110-starfive-visionfive-2-v1.2a
starfive/jh7110-starfive-visionfive-2-v1.3b"

so really we should not need to write this out in full. Binman
supports handling the OF_LIST. It looks like you can just delete
arch/riscv/dts/starfive-visionfive2-binman.dtsi and still get an
image, since there is already arch/riscv/dts/binman.dtsi

> Best regards
>
> Heinrich
>
>>
>> > +                                       };
>> > +                               };
>> > +
>> >                                 fdt-jh7110-milkv-mars {
>> >                                         description = "jh7110-milkv-mars";
>> >                                         load = <0x40400000>;
>> > @@ -58,6 +68,13 @@
>> >                         };
>> >
>> >                         configurations {
>> > +                               conf-jh7110-deepcomputing-fml13v01 {
>> > +                                       description = "jh7110-deepcomputing-fml13v01";
>> > +                                       firmware = "opensbi";
>> > +                                       loadables = "uboot";
>> > +                                       fdt = "fdt-jh7110-deepcomputing-fml13v01";
>> > +                               };
>> > +
>> >                                 conf-jh7110-milkv-mars {
>> >                                         description = "jh7110-milkv-mars";
>> >                                         firmware = "opensbi";
>> > --
>> > 2.47.1
>> >

Regards,
SImon
