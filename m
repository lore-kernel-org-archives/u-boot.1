Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4213AC43327
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 08:30:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CDBB84CBB;
	Thu,  2 Jul 2026 10:30:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d/th0JzU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C13E884CBF; Thu,  2 Jul 2026 10:30:05 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D16B8846A4
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 10:30:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-698aa7ba320so687386a12.1
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 01:30:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782981003; cv=none;
 d=google.com; s=arc-20260327;
 b=lBnttgum9Hm35v2rmf4cxkhh9VcB4/ioCR6LZNv3F3nbeSSD49PFwI6remvP6Ph8dB
 PaOUtMDpZsUNpjrIWz8sm7E0/oN/rGZKIOHjn8eXblCGexUvPcC9H853UkFlpXCYtydX
 Xqf3rcmAfSWpStwBImEkywmURJtEPuaVBMJKt4v+jtL0+UyHZVtUnrTy9hmxFHQOIdQc
 wTjDY5r02nR6DG0fQ7RnlEe88lWWeL29wpCovdGYqBiF0SdGp4xGG56eNNga4uslCp6S
 M6nU1ENU+PbG8rROCd7Hd/HD2owwdMPauAEp0HzERUKEK/ypk+QiNaXPUcQecCaO1De3
 pMug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=K5tmEK11HUr71f9+KeaszkNwYT/flqtrdFn3rPToG6o=;
 fh=rTochvZ14HILlvIow1DduUKGoJDwpS7ERwOOEiixZxY=;
 b=Rb1oTamRhTAGaOA573Czok+xwflccs9mdQPI1unm/5Ss7HN/DV5GwoDnRnC8a7mezq
 NaS6L8X7ZbupMyLtB/Es0ZNAGEqxq1B5+ZHDYfR8ODOzBD2lV1S9nR0yjEhnRJbpXha+
 CMXU7A/jAdOe73aX80HhPXzUAIluw8RnSwoyhL/ViSD2k802TPqmmGcRvjPYo73QvceL
 RYsoPxvMzbIK5gnL6vkhjI8gUmCIhgKR4AnZCGRR3bAu9sbRljgDS4dt/RgNEuNXezxW
 LKrtrZZw1MYL7B01wtyG8Ii5VZC68V3fSSPrRYlkVEGx4f5/CJSfOs8SNLpJP9dvkiUz
 JQBg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782981003; x=1783585803; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K5tmEK11HUr71f9+KeaszkNwYT/flqtrdFn3rPToG6o=;
 b=d/th0JzUur5DcRSjjlZqY3zrNR6ycwfDPGG/2h3wBQ9pqXlfCB02bs728da8HCMhAa
 aH30rFWrMzmajX3GxvUIfqBb8SsaFwbabge+WGBEvZ3IPz31CjC3JOrJsYa8bbZJot4e
 LrtBt7ksz4ZAu1qYriKH3io43TuSauFpAlArA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782981003; x=1783585803;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K5tmEK11HUr71f9+KeaszkNwYT/flqtrdFn3rPToG6o=;
 b=NarzHgatkmGrgJpWeKpaOkjsVXRFNKfIRFNZTtUNpTIOgh/cDeJUiqK4tC+S2Y3STy
 KkfiBuT934VNxnXF77FeIL4GQmtSPdNwqBjuO9UxYjj7pCGC5puJjsXaV//othmpAVPN
 YNJPb2qg3lqSqhH45QachRsfC4uPDHjjj8PSwmdGk7xq+rJwYHHpiae0zwEtQlIEoucE
 +Jt5gmHfk1BNoInN2pKIWd7F5Vr5SMSWPUzrRjY+emF2Z1fQB1G4tpi2LbjuzJ77gfJH
 usOxNgOlJ1C6BNZoythuPljVF9ucatTHsn+pQGZHgd+hPxHq3Wp1WZzxYaICdo87dlGp
 RMTA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrpV0oBOfe7D09UGJc/FhZ3tEzuyHCp510rmRk1PohW49tgA7h99WfLNXdrcKtCsu2xb5I+Se8=@lists.denx.de
X-Gm-Message-State: AOJu0YxjgpeO0KPlu1Ts1mWGipK1pxA/0fnf+3SxzemmXJDUJWi9AVkS
 RkeaTnvnf2650kC6LMvDJ9EEmbUapN1ciPJd3Uj+jPoL3glq8q5HK5eUKr8Y5zg+cIpZzn/dQIN
 950CaqnUsTqLXsOwYVxxrITTekN6NCzRfjiGBGLQdR9s3nat6hd422HxU
X-Gm-Gg: AfdE7clv/7MizAMgB/8n86l54wOv/iGFHgqEys3YQTMxrIbGHKABHt7/bgu+5Y1TVZH
 dT7clQvIAi0mafzLIhrqZApZ9Lgzm7AxBo7bdFNLvanJF6oi+CxoFgcmyvBym0jT/dq1C3A+iTr
 3BAPxnFJ+mLnIQn4iQmLYu79ZdvTRCo6vS+01MPwllMu+3j1/JClDSvUicuaseZZQlnLPao4Lcv
 m2m4fKV9IToyIb1gLMnjeZFOcEd3Yj8x7V8b79rnv1uQI9LayaWQSd3+/R134Te0pOkcKgVHw==
X-Received: by 2002:a05:6402:540e:b0:698:6e7c:a975 with SMTP id
 4fb4d7f45d1cf-6989f1b4f7emr2090108a12.19.1782981003296; Thu, 02 Jul 2026
 01:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260628082810.175862-1-heinrich.schuchardt@canonical.com>
 <20260628082810.175862-12-heinrich.schuchardt@canonical.com>
 <CAFLszTjSeUs=iysEo5-ty+utMR4mJnW4BQjWPiTGB4QndnP_zQ@mail.gmail.com>
 <9c41ab58-dc9c-4cff-9914-96e32db02351@canonical.com>
In-Reply-To: <9c41ab58-dc9c-4cff-9914-96e32db02351@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 09:29:49 +0100
X-Gm-Features: AVVi8Ccj9KMyuE0Wwl0ZNOT_05dKtDUVJxo5YAVCaijvpBdb1W89bR6AIgkKcMY
Message-ID: <CAFLszTi0O6ZwAsuRiyAvijEX_trM0bkzwU4S-F1u0B48jAN4Ew@mail.gmail.com>
Subject: Re: [PATCH v3 11/11] efi_loader: add ACPI table dump EFI app
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 u-boot@lists.denx.de
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

On Wed, 1 Jul 2026 at 14:28, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 7/1/26 14:01, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On 2026-06-28T08:27:58, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >> efi_loader: add ACPI table dump EFI app
> >>
> >> Provide an EFI binary that can dump all ACPI tables to files
> >> <table_name>.dat. These can then be further analyzed by decompiling
> >> with iasl.
> >>
> >> The DSDT and FACS tables are identified via FADT.
> >>
> >> The following commands are provided:
> >>
> >> * check - parse ACPI table list\r\n", do_check
> >> * write - save one file per ACPI table\r\n", do_write
> >>
> >> The file names are constructed from:
> >>
> >> * 4 character ACPI table name
> >> * number if there are multiple ACPI tables of the same type
> >> * '.dat' extension
> >>
> >> This matches the output of the Linux acpidump -b command.
> >> [...]
> >>
> >> lib/efi_loader/Makefile   |   3 +-
> >>   lib/efi_loader/acpidump.c | 566 ++++++++++++++++++++++++++++++++++++++++++++++
> >>   2 files changed, 568 insertions(+), 1 deletion(-)
> >
> > Did you see my comments on v2?
> >
> > Regards,
> > Simon
>
> I thought the v3 change covered them all.
>
> What did I miss?

There was one about the .dat suffix when name_size is too small. Also
allocating a buffer when it seems it is not needed.

Its fine if you don't think they are worth doing...just checking.

BTW there is also some \r\n" in the commit message in this version.

Anyway, whichever you do:

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
