Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE4C5CD98CF
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 13:10:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3147C84105;
	Mon, 15 Jun 2026 15:10:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ez08D4dc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F368E846A4; Mon, 15 Jun 2026 15:10:38 +0200 (CEST)
Received: from mail-yx1-xb12d.google.com (mail-yx1-xb12d.google.com
 [IPv6:2607:f8b0:4864:20::b12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A44BF83FEE
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 15:10:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-660e9ea23cbso1622173d50.2
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 06:10:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781529034; cv=none;
 d=google.com; s=arc-20240605;
 b=EeqFNaCGId+RraxSZDscug5MifVVwlGWE8JV6ctEdZ+qf6fCX4CzfxooZJZRAm72QD
 D6fzA/60qGgKqfYFE/0V1oBudyn8TZaGnNvYgDIRBR1PAmyIM/FTouwT4kMaV6BWLvDr
 GXTGm4nG327i/MbjyUCp9OGWfYm1Lz60AEfJ4AQxM3u3OJPublAfMcc+wjR49xbO8lTq
 txWWxvvcPzD/jTNWJJjh/vIdcUGRs4IwPzl2SD4UhEtZh0TbHdu5xbud58saMYdmzH08
 dAC6TSNdm3xCI7AL5BTicyPTTuexZAFPtN/aFJbPFCsi+pAIXv44ogymGJQGCW4bLwg4
 n04A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bxqtx4X422YL1zMj+TA4dCJx0cf3D2HQ6pqBvSCRN1s=;
 fh=F1g9JCAMPZIsmmAfp/vapo88p6hpnQuU8mOv+m+nz5E=;
 b=WDmLe8upryQO/GSPwB/11OtdpzD1AyGZk/WmhlYwOQjhNKLEdNoHfSbHovGHSixeqa
 MWVs7yJxYHbJOKyoTXcfVlIlLNoGnqSq7miVtgC7cUqzHaIb6ZoUtY2psY1dGEsQOWvd
 sjeKPR3Tp53jhqodXyFbvPjYWgwnbwuCN6H4GzVoUesb/Vk8InEa/1O2VCL/2T1EiSZp
 KLLgOlgcV0540uqlpvfq0GMcs4AbLW8wndVKlEpC3/nrWsnnwuhGnQJNYA47o12b/fsX
 Sm6L2qN6CvVVbA0L7zi4wA9Jmy438AetI9LTOzB2iCC+15i44vvWuJlSkg3LYuJ5EV52
 o6lw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781529034; x=1782133834; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bxqtx4X422YL1zMj+TA4dCJx0cf3D2HQ6pqBvSCRN1s=;
 b=ez08D4dc8ESAWlKAfyV4C9nkLMvb+YW+4VRC1g6QhA4w7IsxHL8ityPkWMeUkJWtYn
 q+i2xi9zSfMS/ICcGaZJ/9/LxCjRF+jNU68RUyJfg2CZn6DgbYq5YiujMUy1fiH3/Mp5
 F9VPbXI1eX+5SuCZim0RM4n2p2aZQ5Nmh9CWRlHod3SM1mT/Q/PX/16V6IYsj4hBx31s
 lnimrrhR2VhTNeOQ4LfXUVZs8d8CM0R2npGaK1/JoFYqybyYh4HQBNKw2xW/EzBmYTij
 s3J4gJWmC/xeOWkfyT8IXgyLZQKPtpEZFo7VRQKKtr8yTXvSOGBjt5/rp/p9qwlQjzRk
 J9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781529034; x=1782133834;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bxqtx4X422YL1zMj+TA4dCJx0cf3D2HQ6pqBvSCRN1s=;
 b=PENaAhaeTVLNIUkDN3JcVUSkTd9cxAtrc9NTX3wH6gfBg5WW3XXzhfFHk95ChOC05e
 0KrCx53YX1p2G03Au8wwTBB5zIntcNmuqxBxabshxllcJ+G9jWTSmn2EvzfpjCyQgDkF
 5SVmehmmMKW5231MyFB1+iKt80O5IHYqCLTrtVd7Lt3d1fHnguYhRO9if442MdeMywdy
 yK2xiI6JXF7EqvHAWgvJ46p0jp2R5ycb7Ft9gBMlB3fJxtkxSjG6wOKa34Nft5M7zA8B
 /Pf04rJDxALYCmVnHrzJ0XCADe6Hz9COuibomoEjSoP7bTGyPZc7tngTcN7MIErmFFuC
 uMOA==
X-Gm-Message-State: AOJu0Yx5dFqxzCXMn4m9LedaR2Z9gxDJOuYnNm60kyTjsD65uAZjA7rm
 Sw3m4+M+JCpbxMetKMfG67yooP1hEPMBA1i+EjeolmkkE74oiMVvVRnZrEalvMm1vVFjm8bPeyO
 yRysCWfJAEgXUolwMQ78TOIXoM/ZFiofVzK6mZiUYPA==
X-Gm-Gg: Acq92OHOiJ+LSUvmpvRd2j/Jb9DjO2EYdo1NlBd95XBBj12Lvjavz4ZqRroxs0ETkSC
 Lz/7nwqq0kEhPnCXmw48ogX+odpZlj/Le9GsSLLUil2dE76A9G7XAFkSEdNmvQkaB9aL+3o/Sfa
 nvRDyV0KFjlLb4i2/XZCwVIO11YNPUkVb5bf6NyHDKKH4/hppQPeInHSWaytxFHmkkslqvsl5zl
 zPWTyooiKw8xSprQvHfGPIqvizzvO6HpAxkj0KGJRNXxNnBdo+7GkmDDnCEAB+ynqsfkWiPMM21
 h8QfFyPGXvMpgOp3P3t2nsDpwCBHngba8RtELcB4zSoiRCYZbpbCiyr7qr6INS6hkbmoGcvU0u5
 IMUL3RgDd8fCR5enQpkPMIwdOZZkP2jHX/NOMhGmQdKerWArZr3UvgqhgrbdulnzjIAC9669yTK
 CUILw4Ptl78m0Ejt7URFbA3XtdcqC6smkT4UHv6YHnTOov40hWNoD9VXir19qJUElavgNx2Hcw4
 rzxOMKWKtui9BSj/KzH4CwgY7BDQgRT9jMmZ1og0s8oL24wAN1WVH99VelbGg1MFwMr8O/ZRZkB
 /oFpR7vqgpMfpTwfHL7UYbl1N7YDCdi4SBmq8XEzdFKifkHq0KGeeMmMU4ljufj4+nO2Whu40K4
 nfwYC6Q==
X-Received: by 2002:a05:690e:14cc:b0:65d:7d86:7758 with SMTP id
 956f58d0204a3-6627838aef2mr11315572d50.59.1781529034309; Mon, 15 Jun 2026
 06:10:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260610105243.193355-1-ludwig.nussel@siemens.com>
 <20260610125204.v2.3.db7fbeb8b6e8499f4d031c04cb5cd8175873b643@changeid>
 <CAC_iWjKN4URBGikcEeTHp7dQPf7QasESmPOmys9piEnsVt-fWw@mail.gmail.com>
 <c3cbd9b8-56b1-4884-bb8a-8a98498a6c09@siemens.com>
 <CAC_iWjJPY9VK89fB5+isWb0v5+uBZnr05kQoGGOYu_X=7G8Wtw@mail.gmail.com>
 <7a8ab625-448f-4a63-ac2b-7b071a9a9f1e@siemens.com>
In-Reply-To: <7a8ab625-448f-4a63-ac2b-7b071a9a9f1e@siemens.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 15 Jun 2026 16:09:57 +0300
X-Gm-Features: AVVi8CcSEr1Xq5q9_mk9StJI2SeQJkx9Bbae0zxsyl-EbsOz6irL2RlAYOnssr4
Message-ID: <CAC_iWjL0z2+=94CfjZx1BV6bCSSN2PyVwPSgCJNhs6r3Z4F3BA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] tpm: allocate tpm event log if missing
To: Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>, 
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
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

Hi Ludwig,

[...]

> >>>
> >>> I'd like the eventlog to be initialized before calling this (look below).
> >>
> >> What if I removed the log parameter from those tcg2_* functions instead?
> >> The event log belongs to the tpm device IMO, so should be initialized
> >> with the device.
> >
> > Measured boot EventLogs etc are primarily described by the TCG specs &
> > EFI and we only have a specification for it there. The DT describes on
> > how to pass it over to linux with sml-base etc.
> > However, in the EFI case the Eventlog is allocated as ACPI memory. So
> > you cannot allocate the EventLog a priori, until you figure out what
> > method you are using to boot. We also have use cases people using it
> > only for RNG, due to limited memory, so we can't just allocate it on
> > the device bringup. And lastly... Some first stage bootloaders do not
> > initialize the TPM & drivers. What they do is prepare an EventLog and
> > expect U-Boot to replay it once the TPM is up and running. In that
> > case we obviously need to preserve what we have instead of starting
> > from scratch.
>
> Ack, we are on the same page here.
>
> > My main concern is that I *don't* want the EFI and non-EFI code to
> > deviate. I have some patches that I am playing around for quite some
> > time and rebased them last week for this reason [1]. If you think
> > those help your use case or make your life easier feel free to include
> > them.
>
> Good idea and orthogonal to what I am doing I think. This duplication in
> EFI stressed my brain too but I can't care about EFI right now :-)

It is, but the deviation in EFI is pretty minimal atm.
- EFI calls tcg2_log_prepare_buffer instead of tcg2_measurement_init()
-- That's what my patches fix
- EFI has it's own version of tcg2_measure_event() -- That's easy to
fix as well,.

>
> IIUC you are centering the change around calling
> tcg2_log_prepare_buffer() in efi_init_event_log(). What do you think
> about aiming for tcg2_measurement_init() as central starting point
> instead?
> That would allow to remove even more duplicated code.
> It should be sufficient to have tcg2_measurement_init() accept an
> optional pointer to pre-allocated log buffer memory. Attached patch
> maybe explains the idea better (just as idea, won't compile).

I agree. In fact I mistyped the functions names on my previous
email.... I really meant tcg2_measurement_init(). The patchset I
pointed you to already converts tcg2_log_prepare_buffer() to static.

>
> >> I am not sure what the intention of the current api is tbh. The event
> >> log basically documents when and how PCR registers were extended. We
> >> have to build that log ourselves as the TPM doesn't do it for us. The
> >> api weirdly allows to have partial local logs even though there's only
> >> one set of PCR registers.
> >
> > Where?
>
> The elog parameters of tcg2_log_prepare_buffer() and tcg2_measure_data()
> are not related to the dev parameter. So it looks like the intention is
> to be able to call it on the same tpm but with different event logs.

Ah no. The reason was that the non EFI code was retrofitted way later,
and it was eiaster to just allocate the buffer on the spot. I always
had the idea of abstracting this even more in the future

Cheers
/Ilias
>
> cu
> Ludwig
>
> --
> Ludwig Nussel
> Siemens AG
> www.siemens.com
