Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64FC6C54F30
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 18:00:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9759B82E76;
	Sat, 24 May 2025 20:00:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RsdTUBwa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C7B482E76; Sat, 24 May 2025 20:00:31 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C866782E28
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 20:00:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-70a57a8ffc3so8379137b3.0
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 11:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748109627; x=1748714427; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4NULFow4LOVxBllFvN7WuvMKM9yX7LP6pcaqsMBj460=;
 b=RsdTUBwaUnZMhi4BH8a7rsoaHAofkT+poFxeQU5EPnohkBRcqn2/GpVvppcb5JkIjX
 Gk/UA69JQC/nF1QQPAHxjptGzZ+ChT3R4KgN3+5ufc/k8WPtaB29Y4+8fwsOuJCudhS4
 tO2h7bXAmiRBC9ZeAO3K6oHaH3gj/ob5Zcy4gX/d5vD0dlmq8IqfeDjtAD9hE0gcqH/W
 Gr7Da2LSh40mQTDZOVcwRtpWXRcg8/W9CAIdPipIQ5f478XyJHzr3kduq2nEqtaDV0tY
 US+i1qTjn2Xn7q2L/Ylh4ez0HUzbDlXWvsFrDvO0Z8imd8BqlucZ3SVnzuUNg8NOIDaB
 HM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748109627; x=1748714427;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4NULFow4LOVxBllFvN7WuvMKM9yX7LP6pcaqsMBj460=;
 b=OfLaeKvhuZUdrMALtsDziIfJUK4syr+tpTHI3FWiv5Ukq6GlQw8NO5SsNA19C6ieEo
 6nQUpjjQfED4ztgd6e6ViyOJTc7+FmGleI28XqV21MsbL7wWf7U9iJNQVEkcFXIdFh+y
 Ea7EffGvGuxtA27I++hvWfWEnjdEesexyCx3+y1GqFMKTZNgJntN+IAm7WliaG6uA55X
 8bS7/PB4UC58i1Vw+m1hxmqkdERG9CAABzShYh58f7xkjoKWeltGhXAy+Bgc9VtwdYbi
 +wBiYBhspq9b1Xgi39GaE7IUM27LnhpZgaHYtHBSsCv1nwRT/Od4896GjQvSN5uFNlDS
 kcWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUc+wJIdkkedWQwlPjicTRAdD1BkS3RmSklNsfl5qnSAul8vjw0fFcmb/Xd5G6/Fw4SBqBO+L8=@lists.denx.de
X-Gm-Message-State: AOJu0Yy6Y2DqSnfAtgw6HYPwqyMILxc2bNUp8TfY9FJVTk3UW/Xv1Sui
 B/FzCkcb6gB/eTPmAwvSQceqyoq3+CFdkHqLMX6Inw+i9EeIUOW1wj8aDujrmAL7GNIxECo9jAR
 Fa8jj2f6F27PC1fqByLUnOWKpPGw8w9tJm62y0l2+Aw==
X-Gm-Gg: ASbGncsXT3lDLLFqUU3VTqhUfOikDQN7aON5UnxkkbIdWNJtIc0UmJhht8uFtjCNAYE
 myLedCqnnvI6XkaEuP3UMFg7W7TiuVMufF3f14iMUkVxqlZB8eL2EDZQvOaCviWZrVQTT+bpXvh
 em6pN3CevBha6/rdNz3/1j31nmos7d6x9ERQ==
X-Google-Smtp-Source: AGHT+IFqjp6RAqnm8N98GZECcEzCY9taf5ZBfp6IhmpHFOifrmcYQq3PTvzCN5hg4Qirh7SN7RxVd+xRE7zVGpqUqv0=
X-Received: by 2002:a05:690c:c:b0:70e:1b53:b9c2 with SMTP id
 00721157ae682-70e2d98468cmr30883997b3.3.1748109627510; Sat, 24 May 2025
 11:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250524141348.965322-1-sjg@chromium.org>
 <20250524142603.GG100073@bill-the-cat>
In-Reply-To: <20250524142603.GG100073@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 24 May 2025 20:59:51 +0300
X-Gm-Features: AX0GCFun-062wnBVqE1SFVgTuVvegv8LUw0FDQajP1VL_Snh9vA-6pKluS0W_9g
Message-ID: <CAC_iWjKckRrKSjn=RG3BAdo5zi-h_-bnYBSVWh9Y0BCqREzZCg@mail.gmail.com>
Subject: Re: [PATCH] tpm: Export the function to set up the TPM log
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Raymond Mao <raymond.mao@linaro.org>
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

Thanks Tom

On Sat, 24 May 2025 at 17:26, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, May 24, 2025 at 08:13:46AM -0600, Simon Glass wrote:
>
> > In some cases, we may wish to set up the TPM log under full control of
> > a driver in U-Boot. Export the required function to make this possible.
> >
> > This avoids calling the weak function tcg2_platform_get_log() when the
> > caller already knows where the log is.

This doesn't make too much sense to me. If the caller knows where the
log is, he needs to replay it in hardware.  Which also means you need
to check the logs vs the active PCR banks.

This has all been abstracted in tcg2_measurement_init().
The UEFI subsystem calls tcg2_log_prepare_buffer(), but that's a
remnant from when measured boot was only supported in EFI. I was
planning to get rid of it and call tcg2_measurement_init() from EFI as
well.

Is there a reason you can't use that? Is it slowing down the boot time
significantly?

Thanks
/Ilias
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  include/tpm_tcg2.h | 9 +++++++++
> >  lib/tpm_tcg2.c     | 2 +-
> >  2 files changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/tpm_tcg2.h b/include/tpm_tcg2.h
> > index eb6afe49e77..189a93ee840 100644
> > --- a/include/tpm_tcg2.h
> > +++ b/include/tpm_tcg2.h
> > @@ -345,4 +345,13 @@ void tcg2_platform_startup_error(struct udevice *dev, int rc);
> >   */
> >  u32 tcg2_algorithm_to_mask(enum tpm2_algorithms);
> >
> > +/**
> > + * tcg2_log_init() - Set up the elog
> > + *
> > + * @dev: TPM device, used to find the number of PCRs
> > + * @elog     Platform event log
> > + * Return: zero on success, negative errno otherwise
> > + */
> > +int tcg2_log_init(struct udevice *dev, struct tcg2_event_log *elog);
> > +
> >  #endif /* __TPM_TCG_V2_H */
> > diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
> > index c314b401d0b..9909d9e14d5 100644
> > --- a/lib/tpm_tcg2.c
> > +++ b/lib/tpm_tcg2.c
> > @@ -220,7 +220,7 @@ static int tcg2_log_append_check(struct tcg2_event_log *elog, u32 pcr_index,
> >       return 0;
> >  }
> >
> > -static int tcg2_log_init(struct udevice *dev, struct tcg2_event_log *elog)
> > +int tcg2_log_init(struct udevice *dev, struct tcg2_event_log *elog)
> >  {
> >       struct tpm_chip_priv *priv = dev_get_uclass_priv(dev);
> >       struct tcg_efi_spec_id_event *ev;
> > --
> > 2.43.0
> >
> > base-commit: bab54f5942c428be698216224fd10b91d974d4da
> > branch: tpma
>
> This is based on mainline, but you forgot to CC the TPM maintainer.
>
> --
> Tom
