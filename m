Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 839D6C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 19:49:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AACCE87B52;
	Thu, 28 Dec 2023 20:48:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m32plq4i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03069879E9; Thu, 28 Dec 2023 20:48:33 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8685787B4D
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 20:48:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3bbbdf0b859so1965178b6e.3
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 11:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703792906; x=1704397706; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JJ1gFYDQP+AovV6oNL/V6WI6PdlYN3TsuI6+jNROYPA=;
 b=m32plq4ihY9Z1ioqAkjMN6KJAa7aLbgK80aEB3CEgqua4Yz0PmtFbvVP9zWE9e2OC1
 V2DnmYCqR+WukOR4rpoYPxBYz3gqYhozfwNru1R7MOTHsZDzDQR9NnWxgg+xPNhtdG6p
 sTmpZFb1B7QHb8ep86NTPrj5MQQk8MXa4NPbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703792906; x=1704397706;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JJ1gFYDQP+AovV6oNL/V6WI6PdlYN3TsuI6+jNROYPA=;
 b=FEbITM47KVTLyNC6lhaJhzUkihO8RUnxVTus5h9+j2zXCkOVtk88ORKkMOcRVqbivJ
 mevq4Ym/TO9Y1dHK177ywPn3C3kqtsh3z3j9jhSg9ulyKu9W3C1DC9bHNYiMm356h2Ro
 1dCLNoG0UjWpN/1O0xgjoJNNr3s5DJUOhkeJgrcKKgcGWma+xLKvLw436ANFtOt2/sat
 HBbcZ1L3ZOCciXGLvDpHVYbDbIQ43GsBrfk8ROJ9yF3n9pb+affwR5c4vCUQH9PfQGCN
 gLBogFmREJWJFpJJmFNDND4/BUjt50UGLnqaJalKNbiDHwd6jxAgs87e46zhTs6eJMxz
 oyQA==
X-Gm-Message-State: AOJu0Yyk5Vt/RO25NrojEBzerGW7ZokdI6MyOnGKfFtmLjsfomPOe/oO
 rXKr/JsjNmqyppL5BUUqFYBTFtHt7czt7PsKRYKBTbSQuwt1
X-Google-Smtp-Source: AGHT+IECH9ZOEVQsUHGvwv0GHkMyWH8TUcZX/vYvZdBBP9F6WFR2tD3QH68L6tBBgLl7SIfXLGDUH0RUdx3UsF6eL+U=
X-Received: by 2002:a05:6808:3847:b0:3bb:c5df:ffe0 with SMTP id
 ej7-20020a056808384700b003bbc5dfffe0mr4833975oib.107.1703792906318; Thu, 28
 Dec 2023 11:48:26 -0800 (PST)
MIME-Version: 1.0
References: <20231222213110.660402-1-raymond.mao@linaro.org>
 <20231222213110.660402-2-raymond.mao@linaro.org>
 <CAFLszTh7f2oy_Aw5Oq1m0Eo4h496dZenhBeYrW9DbB_FxnFADA@mail.gmail.com>
 <CAEfUkUKWUA7Y=4oyo=E-yV-3hFc-dAyLykrZgfY6_v3HwuwKpA@mail.gmail.com>
 <CAFLszThvqUQpL3zBPsKQkPKcKZz1RUtyVAgE6EOLAvmrHtwJMQ@mail.gmail.com>
 <CAEfUkUJvL2o3=4a8mXGK4+T3LWXh6bhNmQMz+ybZUAziuKrL=g@mail.gmail.com>
In-Reply-To: <CAEfUkUJvL2o3=4a8mXGK4+T3LWXh6bhNmQMz+ybZUAziuKrL=g@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Dec 2023 19:48:15 +0000
Message-ID: <CAFLszTgJhutKUc91yYDSc1pih7K-ReEA2m-b1UdJfVzKBPFdtw@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] bloblist: add API to check the register conventions
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, jwerner@chromium.org, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>, 
 Shiji Yang <yangshiji66@outlook.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sean Anderson <sean.anderson@seco.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Baruch Siach <baruch@tkos.co.il>, Michal Simek <michal.simek@amd.com>,
 Stefan Roese <sr@denx.de>, Qu Wenruo <wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Raymond,

On Thu, Dec 28, 2023 at 3:13=E2=80=AFPM Raymond Mao <raymond.mao@linaro.org=
> wrote:
>
> Hi Simon,
>
> On Thu, 28 Dec 2023 at 08:38, Simon Glass <sjg@chromium.org> wrote:
>>
>> Hi Raymond,
>>
>> On Wed, Dec 27, 2023 at 4:06=E2=80=AFPM Raymond Mao <raymond.mao@linaro.=
org> wrote:
>> >
>> > Hi Simon,
>> >
>> > On Tue, 26 Dec 2023 at 04:48, Simon Glass <sjg@chromium.org> wrote:
>> >>
>> >> Hi Raymond,
>> >>
>> >> On Fri, Dec 22, 2023 at 9:31=E2=80=AFPM Raymond Mao <raymond.mao@lina=
ro.org> wrote:
>> >> >
>> >> > Add bloblist_check_reg_conv() to check whether the bloblist is comp=
liant
>> >> > to the register conventions defined in Firmware Handoff specificati=
on.
>> >> > This API can be used for all Arm platforms.
>> >> >
>> >> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
>> >> > ---
>> >> > Changes in v2
>> >> > - Refactor of bloblist_check_reg_conv().
>> >> > Changes in v3
>> >> > - bloblist_check_reg_conv() returns -ENOENT if OF_BOARD is disabled=
.
>> >> >
>> >> >  common/bloblist.c  | 13 +++++++++++++
>> >> >  include/bloblist.h | 12 ++++++++++++
>> >> >  2 files changed, 25 insertions(+)
>> >> >
>> >> > diff --git a/common/bloblist.c b/common/bloblist.c
>> >> > index 625e480f6b..ba17dd851a 100644
>> >> > --- a/common/bloblist.c
>> >> > +++ b/common/bloblist.c
>> >> > @@ -542,3 +542,16 @@ int bloblist_maybe_init(void)
>> >> >
>> >> >         return 0;
>> >> >  }
>> >> > +
>> >> > +int bloblist_check_reg_conv(ulong rfdt, ulong rzero)
>> >> > +{
>> >> > +       if (!IS_ENABLED(CONFIG_OF_BOARD))
>> >> > +               return -ENOENT;
>> >> > +
>> >> > +       if (rzero || rfdt !=3D (ulong)bloblist_find(BLOBLISTT_CONTR=
OL_FDT, 0)) {
>> >> > +               gd->bloblist =3D NULL;  /* Reset the gd bloblist po=
inter */
>> >> > +               return -EIO;
>> >> > +       }
>> >>
>> >> Where does the magic 4a0fb10b value get checked?
>> >>
>> > The magic and version of register conventions cannot be checked now si=
nce there is
>> > a bug in the spec. PSB:
>> > ```
>> > X1[23:0]: set to the TL signature (4a0f_b10b)
>>
>> That should say 0f_b10b
>>
> However, currently we have switched to `4a0f_b10b` in both TF-A and OP-TE=
E.
> I don't want to break the dataflow that is currently working.
> I prefer to make patches to TF-A, OP-TEE and U-Boot at the same time when=
 spec v1.0 is ready.

Yes, sure, but we should fix them too!

>
> [...]
>
> Thanks and regards,
> Raymond

Regards,
Simon
