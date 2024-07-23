Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F7E5C3DA63
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 13:39:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C70C1887CD;
	Tue, 23 Jul 2024 15:39:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IpG7vwd+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BFEC887CD; Tue, 23 Jul 2024 15:39:02 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 125E188846
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 15:38:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-70365f905b6so3621073a34.0
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 06:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721741937; x=1722346737; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=O/4DehQAXFUtwWfhcS1lj2tRRzgt6GzFGsAI8vFjBIM=;
 b=IpG7vwd+jfWrm1LznbdGyg+uZkk8aMTOWhj2nmHxGkg4LgNTjx+9dXAKQX2+KH1wCr
 5gfix/ZzZEa/x8HiYoWmd7l7mSju97uNRAWKQnRwrlhnknTCiVFOCJo9eLHhBoriuEoa
 nZA0iyb7mmIoydqZ+wegUNvoVM75UWHfI8TIModCFM2gjMWizKCcLpgYxcXznFhwt4Qg
 gPW4pVIdmwDpXOs5gLFHK4ylvYNdN/yymvw7IE7yeK58YXeqketV+jWiV/C7qpiAqVuN
 IRHgzbBbB/UW27yWP5NmLD+UmwgNLzRfSHNvYQ/y+775mGkUE3M6gvoGwDKTT1NxCdLe
 5DIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721741937; x=1722346737;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O/4DehQAXFUtwWfhcS1lj2tRRzgt6GzFGsAI8vFjBIM=;
 b=jjiOUkn8w8/pMksqppX1i1ZsMfyTBzr8gJZCwLTCtRvjqXbWhPlKrtdZVnYwA3t1no
 Tz9GSnHawVMBYpfWZ6/QbRwrMHOUZIjkkUyB5VJ7EzcSVhfWcyjzeQenw1RQSEuwCc3L
 ax7qFHW1IjfyNxdSrw4uAGasIC2WyW08Zig5PB4ziCKVkhL/HnWF2ovRcMSmsMcUR+8W
 0SJqLbShRGZHE1PJ1jyI40IIdUbsdqmSHFemRge6DGxAwhM91TRXfsGJUPDetRjZK4On
 40y4dOf39S1hKd3DRc4+EFAJ5DA9ITW3oO8covb9q/HKEmzzJ4i7jK09tK/i6FNbACJC
 zbxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiRpFPigaabl3GNP++oT03KWX340wLAAb7AnmZco7fBV/o5lR4+1uk8mgIqSsdM0P5oIh1lz0ZD0esRMgYn4w0Buzm/w==
X-Gm-Message-State: AOJu0YzahdZEFtB4EnnHJP/eUNHLnaTdESAccNzPzEqVfhaKsWd5C+ry
 yGZ/yMEHNxyq7aCv9wq/XwyLLJcwJatkFr/B9mGNL17U5PUhYDehUzVnwz0gWVbGqN/ffU5szLj
 NBMfTjItZBtficjT0tmXmC0nRBlNlMwIK/1raJQ==
X-Google-Smtp-Source: AGHT+IEQeD1uLxz3h7VWfnJ/aramoAbJOy+agDyNwAjcljtCVPeKzoUQepZ01S572DprOib9H8j0IUDpdckTbZArLQA=
X-Received: by 2002:a05:6870:d3cc:b0:260:fdd5:4147 with SMTP id
 586e51a60fabf-2638df231c8mr8657133fac.15.1721741936576; Tue, 23 Jul 2024
 06:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240715112302.652527-1-lukas.funke-oss@weidmueller.com>
 <20240715112302.652527-2-lukas.funke-oss@weidmueller.com>
 <CAFLszTgX8Tfn=qC_ZBMR2M+iwFAOLKQhGQg8w42F1saAmZq4Eg@mail.gmail.com>
 <CAC_iWjJR=wXX-kv5cmzE38gOCX8FYduX7xhtmm_QHe911GXaPA@mail.gmail.com>
 <CAFLszTgpy8o37ZKYZaNKBt42ihXNWHzH3FNW1g5tLLuwnTeR+A@mail.gmail.com>
In-Reply-To: <CAFLszTgpy8o37ZKYZaNKBt42ihXNWHzH3FNW1g5tLLuwnTeR+A@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 23 Jul 2024 16:38:20 +0300
Message-ID: <CAC_iWj+RW3SF9g7VYBx=OwV3-qP2uzUE8HN1vznp0i3M4P5Cvw@mail.gmail.com>
Subject: Re: [PATCH 1/1] tpm: call tpm_tis_wait_init() after tpm_tis_init()
To: Simon Glass <sjg@chromium.org>
Cc: lukas.funke-oss@weidmueller.com, u-boot@lists.denx.de, 
 Lukas Funke <lukas.funke@weidmueller.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
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

Hi Simon

On Tue, 23 Jul 2024 at 15:47, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias
>
> On Mon, 22 Jul 2024 at 08:35, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi all
> >
> > On Sun, 21 Jul 2024 at 13:08, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi,
> > >
> > > On Mon, 15 Jul 2024 at 12:23, <lukas.funke-oss@weidmueller.com> wrote:
> > > >
> > > > From: Lukas Funke <lukas.funke@weidmueller.com>
> > > >
> > > > tpm_tis_wait_init() is using the 'chip->timeout_b' field which is
> > > > initialized in tpm_tis_init(). However, the init-function is called
> > > > *after* tpm_tis_wait_init() introducing an uninitalized field access.
> > > >
> > > > This commit switches both routines.
> > > >
> > > > Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> > > > ---
> > > >
> > > >  drivers/tpm/tpm2_tis_spi.c | 10 +++++-----
> > > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/tpm/tpm2_tis_spi.c b/drivers/tpm/tpm2_tis_spi.c
> > > > index b0fe97ab1d0..5a4dbfd3ccb 100644
> > > > --- a/drivers/tpm/tpm2_tis_spi.c
> > > > +++ b/drivers/tpm/tpm2_tis_spi.c
> > > > @@ -256,17 +256,17 @@ static int tpm_tis_spi_probe(struct udevice *dev)
> > > >         /* Ensure a minimum amount of time elapsed since reset of the TPM */
> > > >         mdelay(drv_data->time_before_first_cmd_ms);
> > > >
> > > > +       tpm_tis_ops_register(dev, &phy_ops);
> > > > +       ret = tpm_tis_init(dev);
> > > > +       if (ret)
> > > > +               goto err;
> > > > +
> > > >         ret = tpm_tis_wait_init(dev, chip->locality);
> > > >         if (ret) {
> > > >                 log(LOGC_DM, LOGL_ERR, "%s: no device found\n", __func__);
> > > >                 return ret;
> > > >         }
> > > >
> > > > -       tpm_tis_ops_register(dev, &phy_ops);
> > > > -       ret = tpm_tis_init(dev);
> > > > -       if (ret)
> > > > -               goto err;
> > > > -
> > > >         priv->pcr_count = drv_data->pcr_count;
> > > >         priv->pcr_select_min = drv_data->pcr_select_min;
> > > >         priv->version = TPM_V2;
> > > > --
> > > > 2.30.2
> > > >
> > >
> > > This needs a Fixes tag for a5c30c26b28 (HEAD) tpm: Use the new API on
> > > tpm2 spi driver
> > >
> >
> > Yes please we need a fixes tag
> >
> > > The old code set up the timeouts first, then did the wait_init.
> > > Presumably the point of wait_init is to wait before doing the init, so
> > > we should try to keep that behaviour, unless it is actually wrong.
> > >
> > > So my thought would be to move the setup of the required timeout into
> > > tpm_tis_ops_register(), instead.
> >
> > tpm_tis_ops_register() is setting up the bus accesses and I'd prefer
> > to keep it that way.
> > Since this is a static function, we can fold it in tpm_tis_init(),
> > which makes more sense
>
> Since this is used by i2c and SPI we need to make sure that both work.

The tpm_tis_wait_init function is SPI-specific right now. It was SPI
specifric before a5c30c26b28c6 as well. The i2c driver was after the
refactoring and it doesn't call tpm_tis_wait_init(). However, I think
we should call it on all drivers.

The only bus-specific bit is how we read back from the TPM. So I think
the right thing to do here is
1. Teach tpm_tis_wait_init() to call the proper bus function rather
than the hardcoded tpm_tis_spi_read()
2. call it from tpm_tis_init()

That way we'll call it regardless of the bus the TPM happens to sit on.

Regards
/Ilias

>
> I believe the way it used to be, some initial values were set for the
> timeouts. The naming is somewhat confusing I suppose.
>
> Regards,
> Simon
