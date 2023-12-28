Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFCB9C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 13:40:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A24187AAA;
	Thu, 28 Dec 2023 14:38:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ViZ+59ar";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C91B087AB9; Thu, 28 Dec 2023 14:38:10 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A490887AB6
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 14:38:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-28c91894510so679340a91.1
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 05:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703770686; x=1704375486; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FZV0jgqYcMfqMbvqtw/GxftfqeNNez0ZeJe1Jvqb+XE=;
 b=ViZ+59arFc6yKFN1mtc44k4BDUaPfJDMgL73S8wYsQspOVXRCgUvdP5UMfbSu0Ois9
 CycB5U2qAofObpEhPVSNd+PNJmSN+FUUhzm0hnZyaFOUEIHPoXoP7TJ6gvIQkETmIXsV
 GzKl+F9MDz8oL8n1t0l+ketfIHJkrivpKSzSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703770686; x=1704375486;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FZV0jgqYcMfqMbvqtw/GxftfqeNNez0ZeJe1Jvqb+XE=;
 b=Y5yuId4hvtzoY7SPIPoM2MY+B1tkBS+g/eMkM7eAfpDZ+XEmdsDuvjB6N+ZEuo8yxN
 KsvJGN0IxCwSbZUCKMAmafzlPEXnhDf4ZvIcdvNhNwu28u8aiHpGuZPGXl1j2lB0sNGU
 MSGgt+WHG2mp3O1XUeP2jXMn9u0GmyPPzO0d+zUDwLh7+BHAovwbW2Cb3FrbHsvW8wu6
 NWSaX+yNCu1633h95jN9x0shAPlLeIF7QBxMmgYbg5aqSGIWTFS3O0vXBnZ5bos9iIh5
 Dx3Sa0JbMNatxgo1pWln9Wr3dkzBhk2H30EoitSIulX2nIKA2rI8RlOYpdQLPSnBfXFZ
 QEJg==
X-Gm-Message-State: AOJu0YwyyOuWH3bTneBKDerkDG5UhOUGrLJifDI1ueuAmxI30j+xymi1
 iY24oBKctP6n9vEa9eHYMGRSoJruxAbdUHorJVv9bOolvlRa
X-Google-Smtp-Source: AGHT+IFjuK0ac9DdZFOWz2+Pn1RVjKJuFDei84r9kBq3lBaTSExH0GVCdBV3fxdb1bWK0bAIwSYxZaLheuYuTOF72kw=
X-Received: by 2002:a17:90a:fe8d:b0:28c:7de9:253 with SMTP id
 co13-20020a17090afe8d00b0028c7de90253mr1829365pjb.40.1703770686232; Thu, 28
 Dec 2023 05:38:06 -0800 (PST)
MIME-Version: 1.0
References: <20231222213110.660402-1-raymond.mao@linaro.org>
 <20231222213110.660402-2-raymond.mao@linaro.org>
 <CAFLszTh7f2oy_Aw5Oq1m0Eo4h496dZenhBeYrW9DbB_FxnFADA@mail.gmail.com>
 <CAEfUkUKWUA7Y=4oyo=E-yV-3hFc-dAyLykrZgfY6_v3HwuwKpA@mail.gmail.com>
In-Reply-To: <CAEfUkUKWUA7Y=4oyo=E-yV-3hFc-dAyLykrZgfY6_v3HwuwKpA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Dec 2023 13:37:14 +0000
Message-ID: <CAFLszThvqUQpL3zBPsKQkPKcKZz1RUtyVAgE6EOLAvmrHtwJMQ@mail.gmail.com>
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

On Wed, Dec 27, 2023 at 4:06=E2=80=AFPM Raymond Mao <raymond.mao@linaro.org=
> wrote:
>
> Hi Simon,
>
> On Tue, 26 Dec 2023 at 04:48, Simon Glass <sjg@chromium.org> wrote:
>>
>> Hi Raymond,
>>
>> On Fri, Dec 22, 2023 at 9:31=E2=80=AFPM Raymond Mao <raymond.mao@linaro.=
org> wrote:
>> >
>> > Add bloblist_check_reg_conv() to check whether the bloblist is complia=
nt
>> > to the register conventions defined in Firmware Handoff specification.
>> > This API can be used for all Arm platforms.
>> >
>> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
>> > ---
>> > Changes in v2
>> > - Refactor of bloblist_check_reg_conv().
>> > Changes in v3
>> > - bloblist_check_reg_conv() returns -ENOENT if OF_BOARD is disabled.
>> >
>> >  common/bloblist.c  | 13 +++++++++++++
>> >  include/bloblist.h | 12 ++++++++++++
>> >  2 files changed, 25 insertions(+)
>> >
>> > diff --git a/common/bloblist.c b/common/bloblist.c
>> > index 625e480f6b..ba17dd851a 100644
>> > --- a/common/bloblist.c
>> > +++ b/common/bloblist.c
>> > @@ -542,3 +542,16 @@ int bloblist_maybe_init(void)
>> >
>> >         return 0;
>> >  }
>> > +
>> > +int bloblist_check_reg_conv(ulong rfdt, ulong rzero)
>> > +{
>> > +       if (!IS_ENABLED(CONFIG_OF_BOARD))
>> > +               return -ENOENT;
>> > +
>> > +       if (rzero || rfdt !=3D (ulong)bloblist_find(BLOBLISTT_CONTROL_=
FDT, 0)) {
>> > +               gd->bloblist =3D NULL;  /* Reset the gd bloblist point=
er */
>> > +               return -EIO;
>> > +       }
>>
>> Where does the magic 4a0fb10b value get checked?
>>
> The magic and version of register conventions cannot be checked now since=
 there is
> a bug in the spec. PSB:
> ```
> X1[23:0]: set to the TL signature (4a0f_b10b)

That should say 0f_b10b

> X1[31:24]: version of the register convention used. Set to 1 for the AArc=
h64 convention specified in this document.
> ```
> Signature (4a0f_b10b) takes all [31:0] and no space for version of the re=
gister convention.
> This needs to be updated on TF-A and OP-TEE as well after the spec is upd=
ated.
> For now I will just skip the checking.

We should fix the spec instead.

Regards,
Simon
