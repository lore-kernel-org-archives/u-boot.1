Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FCC2C2BB85
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 15:52:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72A3B88059;
	Fri, 21 Jun 2024 17:52:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iMjCOzdd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A16F4880F1; Fri, 21 Jun 2024 17:52:54 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA192831A1
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 17:52:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7163489149eso878978a12.1
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 08:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718985170; x=1719589970; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3edSnwjIlDkj9plv1lFKaGBdyzI/0KPbzip/SFsQabs=;
 b=iMjCOzddIDNQsatHQNKO7RMFMDbgo/L9rkN1a3oWmywcWcUKZdgHibYP4uFYHH/2CJ
 c/DjV2PcvUkfCQl7Fuf5QXSMMLkWZk/i/kRxJeEY+NNseySmLkyEvc9Y5hI/LoqZSSzY
 ea3b3g3xFk9o5Xw/ak30FW+/5HAyfKKGywlqCJn42IVd+no0AHwNg6DB12JjaN4Zkueg
 fQz4aRm91vNDeBOvqr9y1EPP0gLh+x/Y0N1hDLmETv+FHrdZz/NXUvwq/7w4CPFfmekI
 kh7FS9E3ryMg2kXWv8k3Ud2h+sJKFUTfmm95CXWUbm6PB5aLAM/QiH/+PVOIrDX/TwyH
 I3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718985170; x=1719589970;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3edSnwjIlDkj9plv1lFKaGBdyzI/0KPbzip/SFsQabs=;
 b=bIzvZYCNA27ejKpt/msZEyIISiTVoOsPAlGRdDDwSGlJ/b+3/b6GDqQXJnJSq8sdn0
 noJxsCrMAavT+QPdWFqgxx+v8lhcBCAqGDuPlDjPtGh8vlWn2p3cBFgMQc3E5J0kcHMI
 yzsZQVCP8v0MyMlYTzzTAo6WFW3yVXH3atl3cPL7kx+nfjamZbVRh9CC1hl6OQjbTQPv
 dYtCipVVr+KiR0OBJn1F8xAvISKw0xlVKlDpD92DmnmHeDVk9qIom0jhF0/NnRdTBK1X
 x1Gsrq55hDPeSewEqbYM4V1Cc7l0vrUkKilG/RpJQS8vqxFyqeBz4appIc978A0X2qMN
 sVhQ==
X-Gm-Message-State: AOJu0Yz36jS1+46GZc0VS2SJtOfmSuEH/LI3dV5tdX2t3CYPpkXZWZv5
 pi+3rOgrLLdRbOE9inNZLxff19ExlM3x6wRQI/O8RT3KuBbOODvyx1OhA6FXNqbdBGRT9HDdFxP
 J+EnHnBBppyUizf5V2sI4kjE++XmbmaZY4ikGsw==
X-Google-Smtp-Source: AGHT+IEWPs9dLkTL4JmVuzTF4JPM+B2etA9unD0+h2Ac4jyLnFJDJlMLEEUJFC8atsDGrHx0fZoUEDJ7blJx1RUm+Cs=
X-Received: by 2002:a17:90a:55cf:b0:2c8:81b:20f7 with SMTP id
 98e67ed59e1d1-2c8081b22e2mr3661622a91.44.1718985170111; Fri, 21 Jun 2024
 08:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240620230625.1797397-1-sjg@chromium.org>
 <20240620230625.1797397-11-sjg@chromium.org>
 <CAC_iWjKtOjR9evF81MhTVUKsn6OB5s=8O40+CZE-Y4+YfQO9GQ@mail.gmail.com>
 <CAC_iWj+uQ2z=SQpWhdZqVm02csoyFkeE-gXd7YWWS-MqYjxG1g@mail.gmail.com>
 <CAFLszTiRgwf4T6h1T5-5BiWckc7062Tgcs-2M2qi+7y_k=YbRw@mail.gmail.com>
In-Reply-To: <CAFLszTiRgwf4T6h1T5-5BiWckc7062Tgcs-2M2qi+7y_k=YbRw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 21 Jun 2024 18:52:13 +0300
Message-ID: <CAC_iWjL7kTVB-jj7VbAJDe4UZgDk55Gxax5V7csvkRsvJ8OK2A@mail.gmail.com>
Subject: Re: [PATCH v3 10/18] tpm: Avoid code bloat when not using
 EFI_TCG2_PROTOCOL
To: Simon Glass <sjg@chromium.org>
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

Hi Simon,

On Fri, 21 Jun 2024 at 17:57, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Thu, 20 Jun 2024 at 23:49, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > On Fri, 21 Jun 2024 at 08:32, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Fri, 21 Jun 2024 at 02:06, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > It does not make sense to enable all SHA algorithms unless they are
> > > > needed. It bloats the code and in this case, causes chromebook_link to
> > > > fail to build. That board does use the TPM, but not with measured boot,
> > > > nor EFI.
> > > >
> > > > Since EFI_TCG2_PROTOCOL already selects these options, we just need to
> > > > add them to MEASURED_BOOT as well.
> > > >
> > > > Note that the original commit combines refactoring and new features,
> > > > which makes it hard to see what is going on.
> > > >
> > > > Fixes: 97707f12fda tpm: Support boot measurements
> > > > Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > (no changes since v2)
> > >
> > > There was a discussion in the previous version, bout enabling these on
> > > CMD_TPM as they are required.
>
> For reference [1]
>
> >
> > Or switch this to an imply instead so you can disable it ?
>
> The thing is, we need to be able to easily disable unwanted features.
> My reading of that thread is that U-Boot doesn't use SHA384/512 from
> the 'tpm2 pcr_extend' command today.

It does, it was mentioned on the thread you referenced. commit
89aa8463cdf39 ("tpm-v2: allow algorithm name to be configured for
pcr_read and pcr_extend")

> Even if it did, I would think it
> better to allow the supported algorithms to be controlled. At worst, I
> would expect a separate option to disable that subcommand which would
> remove the implies.

To control the algos you need to compile, you need to control the
algorithms the TPM supports. Otherwise, you are leaving security
holes. We don't configure the supported PCR banks today iirc.

If we need the fix for those platforms for the release so badly, why
don't we just disable the TPM? It's going to be useless and
potentially dangerous without SHA support. Any idea why those
platforms use it for?

>
> Some tpm code recently added puts a table and some functions in
> tpm-v2.h - could someone fix that? tpm-common.c would be a better
> place.

Do you mean commit 954b95e77ef0a8? If that's the one, I don't mind
moving it there.
Those values though are described in [0], which is primarily for v2.0.
Nothing prevents you from using it in v1.2 but all of the values apart
from SHA1 are useless. Also, we don't support measured boot with 1.2
anyway so I didn't see the point back then.

> Also we already have a list of hash algorithms in U-Boot
> (common/hash.c) so should use that, >and respect the fact that certain
> algos may not be supported.

That seems tailored for a very specific reason. Do you want to fill it
in with EFI internal definitions?
We could adjust some lookup functions which seems common.

>
> If there is a requirement that (for a certain situation / protocol) we
> need to support everything, then let's have a Kconfig for that.

We do. The difference here is that the *TPM at runtime* dictates what
you need. So you can't blindly disable stuff.

> It is
> what my patch was trying to work around, perhaps. For boards which
> don't care about extending TPM in this way, or don't use the more
> expensive algorithms, it avoids lots of code bloat.

Ok, I disagree here. That's potentially dangerous. Because someone,
might need the TPM, easily misconfigure it, and end up with broken
measurements.

>
> One of the principles of U-Boot is to allow configurability in these
> situations. It shouldn't be too hard to have the best of both worlds
> (supports all reasonable cases by default / allow unwanted cases to be
> dropped).

It's not. We can have the TPM configure the supported algorithms once it starts.
IMHO that's the proper way to do it. Everything else is just papering
over the problem -- which even worse no one will care to fix.

>
> So I'll await your reply on the above before figuring out where to go
> with this. For this release I'd just like to get the board working,
> but I understand that the TPM stuff is very-much in flux, perhaps in
> -next.

This is a very complex problem. Even if we configure the TPMs banks
based on the supported algoriths, a previous stage loader might have
enabled more. So you end up breaking that in that case...

Let me see if I can configure the TPM on boot....

Cheers
/Ilias
>
> Regards,
> Simon
>
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20240610145920.3302001-3-sjg@chromium.org/

[0] https://trustedcomputinggroup.org/wp-content/uploads/EFI-Protocol-Specification-rev13-160330final.pdf
-- search for EFI_TCG2_BOOT_HASH_ALG_SHA512
