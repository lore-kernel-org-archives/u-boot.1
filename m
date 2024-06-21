Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A525CC27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 14:58:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FA598840F;
	Fri, 21 Jun 2024 16:58:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jn0Xx4YQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C73FB884C6; Fri, 21 Jun 2024 16:58:00 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C3C8880F1
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 16:57:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6b501a4344bso9246286d6.3
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 07:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718981877; x=1719586677; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ht25f2ICSjpZr9cgYMZ78UPU45JFDUatdPt4/AkVCtI=;
 b=jn0Xx4YQidd4ncbhdzC8Z5bIg+jWd7lHvZnRzOpd7KtiJqTY/uIOTvj+tsRtmN/Cl3
 DKFQqbr88kUUz/mSH4ipZtl8RjNpiRmXpx1esE9zUVua0tiYMIcszQrgCCxUJpq8rk5M
 HivwxD2eQdz5oj2vTdAle0s3mnhMZ2BoKhniQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718981877; x=1719586677;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ht25f2ICSjpZr9cgYMZ78UPU45JFDUatdPt4/AkVCtI=;
 b=B36Xr9HbbR4LzZL7agry80ZgraNuvlrjvOEedweyhHFaZ5uSpIHEUggYJCeCSreaZe
 nyo6qYjQ827p3dQuDSagw7l3ZgR9zU+5tsIhL1rZJQHvg83iz85igzYwDUwnahYXEyiz
 xn4apd7OIdxm70W6Aw7OAtISaUnI1x/plBPCypIXCYbOL/aJs/7WLXVJeAX6+aRw0NgR
 2X6bHg2DIXDVCbcFYGCcPmUNNxC61Pc2gQi+QCemtMgj0aBakJfDFrWqfSHZvqh1QIR1
 az4STrtT8YqMmIP99QSLHBJ7cgDoegrvSxHCbD8OmoVZQzVCm+9zD44L+226WgTkBJ+G
 7wOQ==
X-Gm-Message-State: AOJu0YyyJysjTebosdOIMmewCI6UuXZXpCN1XKaTXt34mN+2gZH8PAgN
 gwuoej3UqBybbHuPO9XUzU6yF+MRKUKMpOEPqWe62Zt2lLTrbx68O/WVLQFYWGx+t7P3X+mOYvg
 QY+y46XZtfqaNoLt13v349zbUlruLpXhQu1U9
X-Google-Smtp-Source: AGHT+IGMtKFHo+URtAQnYImciB5Lbm4JjhPDM3oES/A9oE6Q6R9iCnU54xGyCNVC1eXN5LTkmoCOSNGOPRTlkJf8pao=
X-Received: by 2002:a0c:ca92:0:b0:6b5:34b:8c02 with SMTP id
 6a1803df08f44-6b5034b8dbamr82211786d6.27.1718981876888; Fri, 21 Jun 2024
 07:57:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240620230625.1797397-1-sjg@chromium.org>
 <20240620230625.1797397-11-sjg@chromium.org>
 <CAC_iWjKtOjR9evF81MhTVUKsn6OB5s=8O40+CZE-Y4+YfQO9GQ@mail.gmail.com>
 <CAC_iWj+uQ2z=SQpWhdZqVm02csoyFkeE-gXd7YWWS-MqYjxG1g@mail.gmail.com>
In-Reply-To: <CAC_iWj+uQ2z=SQpWhdZqVm02csoyFkeE-gXd7YWWS-MqYjxG1g@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 21 Jun 2024 08:57:46 -0600
Message-ID: <CAFLszTiRgwf4T6h1T5-5BiWckc7062Tgcs-2M2qi+7y_k=YbRw@mail.gmail.com>
Subject: Re: [PATCH v3 10/18] tpm: Avoid code bloat when not using
 EFI_TCG2_PROTOCOL
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Eddie James <eajames@linux.ibm.com>, 
 Michal Simek <michal.simek@amd.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Sean Anderson <sean.anderson@seco.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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

On Thu, 20 Jun 2024 at 23:49, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Fri, 21 Jun 2024 at 08:32, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Fri, 21 Jun 2024 at 02:06, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > It does not make sense to enable all SHA algorithms unless they are
> > > needed. It bloats the code and in this case, causes chromebook_link to
> > > fail to build. That board does use the TPM, but not with measured boot,
> > > nor EFI.
> > >
> > > Since EFI_TCG2_PROTOCOL already selects these options, we just need to
> > > add them to MEASURED_BOOT as well.
> > >
> > > Note that the original commit combines refactoring and new features,
> > > which makes it hard to see what is going on.
> > >
> > > Fixes: 97707f12fda tpm: Support boot measurements
> > > Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > (no changes since v2)
> >
> > There was a discussion in the previous version, bout enabling these on
> > CMD_TPM as they are required.

For reference [1]

>
> Or switch this to an imply instead so you can disable it ?

The thing is, we need to be able to easily disable unwanted features.
My reading of that thread is that U-Boot doesn't use SHA384/512 from
the 'tpm2 pcr_extend' command today. Even if it did, I would think it
better to allow the supported algorithms to be controlled. At worst, I
would expect a separate option to disable that subcommand which would
remove the implies.

Some tpm code recently added puts a table and some functions in
tpm-v2.h - could someone fix that? tpm-common.c would be a better
place. Also we already have a list of hash algorithms in U-Boot
(common/hash.c) so should use that, and respect the fact that certain
algos may not be supported.

If there is a requirement that (for a certain situation / protocol) we
need to support everything, then let's have a Kconfig for that. It is
what my patch was trying to work around, perhaps. For boards which
don't care about extending TPM in this way, or don't use the more
expensive algorithms, it avoids lots of code bloat.

One of the principles of U-Boot is to allow configurability in these
situations. It shouldn't be too hard to have the best of both worlds
(supports all reasonable cases by default / allow unwanted cases to be
dropped).

So I'll await your reply on the above before figuring out where to go
with this. For this release I'd just like to get the board working,
but I understand that the TPM stuff is very-much in flux, perhaps in
-next.

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20240610145920.3302001-3-sjg@chromium.org/
