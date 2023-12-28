Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0ACC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 15:13:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E28B1879F9;
	Thu, 28 Dec 2023 16:13:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="T/5kURAv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 942C0879FF; Thu, 28 Dec 2023 16:13:51 +0100 (CET)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6D0487954
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 16:13:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5ca5b61f101so1790796a12.0
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 07:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703776427; x=1704381227; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p/puAxBJi0oj/fm6fVNoDdtofduuLzF9Iv4if2ESMM8=;
 b=T/5kURAvjZ0hY6WyPGANHxK3ofoVqT59/k5FGl6vyAJhG0EipntcVDxlib8NqJTEqO
 on1rX5M7f/lkuQdce2QA34hGBYlM8UPltwgmdFi18zYHCdYq8vKsINE9ZNOCJddNKLfI
 xxWh7LVNyArUVRqs7W4CSNpJceI862Y6o9mEvzSqQUTrdNAg0o67O+RQt6wBw4VV1MYm
 GLgevk7p3YsczIXAKrz04oTpBUWJpeQN5+RuAXj0DnuA1eRnNBsvZZRGGwem4QByKGAB
 QyO7RJhFsdx4ux4cbvt1crDOMSx6a0CVYSum5nnNsd7gp7+tLtwT5QgAq4jd51VQQC/R
 6Kow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703776427; x=1704381227;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p/puAxBJi0oj/fm6fVNoDdtofduuLzF9Iv4if2ESMM8=;
 b=uyxUmNei2QbG8I2ybpGMRYomYkZkaQV2TefloeNCZnXeaGmK4XK/pK4blf3toC8LO1
 JKe97qo+Z0SgMIIP1O2JDkHqEjxUaqZSPtRnST6pASs0qRpR9t/SXEpqTtIQCJJIuJFk
 lw3VQP+XoE9qv2ad3n2pUXfbnXsgCBqNlpX1s7c7izfCuW0sRnKEu2kKn+levDIx8Vak
 rXHtq/QYrdmnxn4nGC8XDMgmRoARosUOqEi3j0pQg/NMYVaVXEDUC0xazN4nosI+kOt2
 od5trO0efzlo7O/A3c5nChE3Chx8bT2he2iZvDSW9cZiyBCTFQQLnz4tZLKNYRwyHtlE
 EJ7w==
X-Gm-Message-State: AOJu0Yx318y8zFFIJ6uF20OfNvZFdF51Mi2k2JuDvHio0IO6YvpUTQpL
 7/vCJh/HCD7QxeDYzlbzYUhJDyu7I77OyTWLN/GWf+ck7XIoVA==
X-Google-Smtp-Source: AGHT+IHmQzYGSJrzc6SOXFwepiqaJ6GP2G35X58WLyi5FXxQOzLM+W4RcZyFs7TwIpCBQP33qS/+8w/wcGx2LrBXy0A=
X-Received: by 2002:a05:6a20:66aa:b0:190:228e:4c26 with SMTP id
 o42-20020a056a2066aa00b00190228e4c26mr4534689pzh.31.1703776427027; Thu, 28
 Dec 2023 07:13:47 -0800 (PST)
MIME-Version: 1.0
References: <20231222213110.660402-1-raymond.mao@linaro.org>
 <20231222213110.660402-2-raymond.mao@linaro.org>
 <CAFLszTh7f2oy_Aw5Oq1m0Eo4h496dZenhBeYrW9DbB_FxnFADA@mail.gmail.com>
 <CAEfUkUKWUA7Y=4oyo=E-yV-3hFc-dAyLykrZgfY6_v3HwuwKpA@mail.gmail.com>
 <CAFLszThvqUQpL3zBPsKQkPKcKZz1RUtyVAgE6EOLAvmrHtwJMQ@mail.gmail.com>
In-Reply-To: <CAFLszThvqUQpL3zBPsKQkPKcKZz1RUtyVAgE6EOLAvmrHtwJMQ@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 28 Dec 2023 10:13:35 -0500
Message-ID: <CAEfUkUJvL2o3=4a8mXGK4+T3LWXh6bhNmQMz+ybZUAziuKrL=g@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] bloblist: add API to check the register conventions
To: Simon Glass <sjg@chromium.org>
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
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Simon,

On Thu, 28 Dec 2023 at 08:38, Simon Glass <sjg@chromium.org> wrote:

> Hi Raymond,
>
> On Wed, Dec 27, 2023 at 4:06=E2=80=AFPM Raymond Mao <raymond.mao@linaro.o=
rg>
> wrote:
> >
> > Hi Simon,
> >
> > On Tue, 26 Dec 2023 at 04:48, Simon Glass <sjg@chromium.org> wrote:
> >>
> >> Hi Raymond,
> >>
> >> On Fri, Dec 22, 2023 at 9:31=E2=80=AFPM Raymond Mao <raymond.mao@linar=
o.org>
> wrote:
> >> >
> >> > Add bloblist_check_reg_conv() to check whether the bloblist is
> compliant
> >> > to the register conventions defined in Firmware Handoff specificatio=
n.
> >> > This API can be used for all Arm platforms.
> >> >
> >> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> >> > ---
> >> > Changes in v2
> >> > - Refactor of bloblist_check_reg_conv().
> >> > Changes in v3
> >> > - bloblist_check_reg_conv() returns -ENOENT if OF_BOARD is disabled.
> >> >
> >> >  common/bloblist.c  | 13 +++++++++++++
> >> >  include/bloblist.h | 12 ++++++++++++
> >> >  2 files changed, 25 insertions(+)
> >> >
> >> > diff --git a/common/bloblist.c b/common/bloblist.c
> >> > index 625e480f6b..ba17dd851a 100644
> >> > --- a/common/bloblist.c
> >> > +++ b/common/bloblist.c
> >> > @@ -542,3 +542,16 @@ int bloblist_maybe_init(void)
> >> >
> >> >         return 0;
> >> >  }
> >> > +
> >> > +int bloblist_check_reg_conv(ulong rfdt, ulong rzero)
> >> > +{
> >> > +       if (!IS_ENABLED(CONFIG_OF_BOARD))
> >> > +               return -ENOENT;
> >> > +
> >> > +       if (rzero || rfdt !=3D
> (ulong)bloblist_find(BLOBLISTT_CONTROL_FDT, 0)) {
> >> > +               gd->bloblist =3D NULL;  /* Reset the gd bloblist
> pointer */
> >> > +               return -EIO;
> >> > +       }
> >>
> >> Where does the magic 4a0fb10b value get checked?
> >>
> > The magic and version of register conventions cannot be checked now
> since there is
> > a bug in the spec. PSB:
> > ```
> > X1[23:0]: set to the TL signature (4a0f_b10b)
>
> That should say 0f_b10b
>
> However, currently we have switched to `4a0f_b10b` in both TF-A and OP-TE=
E.
I don't want to break the dataflow that is currently working.
I prefer to make patches to TF-A, OP-TEE and U-Boot at the same time when
spec v1.0 is ready.

[...]

Thanks and regards,
Raymond
