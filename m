Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA67C54ED1
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 18:25:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5B3E82E28;
	Sat, 24 May 2025 20:24:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="V9jHABVY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54C8E82E76; Sat, 24 May 2025 20:24:58 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B923082D2B
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 20:24:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-70e2e50e1caso4927737b3.1
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 11:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748111094; x=1748715894; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Lot1/JrTIsY78wgDh93eEKVRJiqgPdyoFsbuUXWjVJM=;
 b=V9jHABVYJtPLtEhn3rBJf1Q1Ig9Kwg9vPg39JHmQCbNniQ3sRF0Fzjq0EYTrTLu3x0
 Ds5IUWbAwKEkU70nGoJmz7vIjCWeG0pUN2hg9LxLJP7jo2AFUMdpobUpX1BAlFe/EcAI
 EQnwuzzmO2GCHaGwanytLdNMl4s3KsHRbna/448krXVkUz2SXKruZ9eCF0zjXXwzd2Ji
 bpGWg92RjkBwwgUZ4qNQx3zgWv3DH4Krqh4njJRXCKJLewH4X5VzahJTcOOxMtYvMGTJ
 2nfaiXw+wUMltqAAUR93p8Qr36e9ULJOnN3xFE5xQ765Pr3ju4Ue40VrCAYOE17TA/Wj
 m/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748111094; x=1748715894;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Lot1/JrTIsY78wgDh93eEKVRJiqgPdyoFsbuUXWjVJM=;
 b=bRDU7A/xdxIVbSqhWADnbYdcUw+PWtEy31U75NHcoPT7NtVICm6EJM+bRWzv9Uj3m9
 DEJeCJV6sd5lg+jCxFysBQ+nTf+XoK1Hv8+3QZ1YEqQnoYUvsVWXlvivu2y9P/asQW1Q
 aM6+zZcaT/ts0/miFmEfd2hJhi43vL+GWKQ0dwa05J5w8vFk+bZBSHEEXpj/QlGoeH8c
 u1VhUkSwdOLx8d7LN6tyyIoO9Plps04F103D7zpzk8jrjq8DErJxJFv5g9hNyNMmuXEs
 21gnXDboiUd7YqXc5awv85x+Zvrrz74XIld62Ek+VaIGWr4oGMSIb36/dUKLU7U8VVYc
 ZaVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/hPbma2bvxnCbAINsWGGpvOuLtbYWdiCijI7CKNtovlNhmRFl+teqT1Hekg0Gx7702f3k2MI=@lists.denx.de
X-Gm-Message-State: AOJu0Yw2qDKPQK8A2zJNUs7/Edq5sLy/YPVvSii8TPLmQlZ3iYUAHc72
 TDJc4IEOgv4ZOfurYGKCxmCf51ZQdBIZyla1tBpTdAQGgFjEU53z5wKRs/7t+p/OdJjaJdjHMPc
 GVSa8akglnyqoU1ehwqhSgILe81H3RUU1SvUf9Nllhg==
X-Gm-Gg: ASbGncvpMnAAhu8N7pEc94Vma56svHJA3nnspDSlxXGNS81GeITr5BpnFSx18empm1p
 DiTfTL0RVeuGIv0W/WBRUdstz5tGt3srXrX7Ptfma4kf2jnvYm5EIbJyTRMj+Rln/riHo15gJeK
 OyQNo6rIEwholmTcFIwOiheoKbBpky1nzz8A==
X-Google-Smtp-Source: AGHT+IFPnpuUKTAVhEvnkUGhw96GyDsn/Fl2i0Nc17qXD81TRXy5MLROf05Txwo5CnJdgKkPtVw7QUV4JvtZ+pxA4cQ=
X-Received: by 2002:a05:690c:4909:b0:70d:f9b0:b6b5 with SMTP id
 00721157ae682-70e185b3e75mr86782927b3.13.1748111094463; Sat, 24 May 2025
 11:24:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250524141348.965322-1-sjg@chromium.org>
 <20250524142603.GG100073@bill-the-cat>
 <CAC_iWjKckRrKSjn=RG3BAdo5zi-h_-bnYBSVWh9Y0BCqREzZCg@mail.gmail.com>
In-Reply-To: <CAC_iWjKckRrKSjn=RG3BAdo5zi-h_-bnYBSVWh9Y0BCqREzZCg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 24 May 2025 21:24:18 +0300
X-Gm-Features: AX0GCFufX1AY3byKd-2b1jIBWw7pW2k1ibmF83xayvL3WOCt8Pvu0yZujZyfvIA
Message-ID: <CAC_iWjLjQ-fK1ZyXEEN=R+Up_Fxok7TGm50_2XrSkdTFTYbNLg@mail.gmail.com>
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

On Sat, 24 May 2025 at 20:59, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Thanks Tom
>
> On Sat, 24 May 2025 at 17:26, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, May 24, 2025 at 08:13:46AM -0600, Simon Glass wrote:
> >
> > > In some cases, we may wish to set up the TPM log under full control of
> > > a driver in U-Boot. Export the required function to make this possible.
> > >
> > > This avoids calling the weak function tcg2_platform_get_log() when the
> > > caller already knows where the log is.
>
> This doesn't make too much sense to me. If the caller knows where the
> log is, he needs to replay it in hardware.  Which also means you need
> to check the logs vs the active PCR banks.
>
> This has all been abstracted in tcg2_measurement_init().
> The UEFI subsystem calls tcg2_log_prepare_buffer(), but that's a
> remnant from when measured boot was only supported in EFI. I was
> planning to get rid of it and call tcg2_measurement_init() from EFI as
> well.
>
> Is there a reason you can't use that? Is it slowing down the boot time
> significantly?
>

Oh and looking at it a bit closer, calling tcg2_log_init() doesn't add
an EV_S_CRTM_VERSION event which makes the generated eventlog violate
the spec. So that function should just remain static

/Ilias
> Thanks
> /Ilias
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > >  include/tpm_tcg2.h | 9 +++++++++
> > >  lib/tpm_tcg2.c     | 2 +-
> > >  2 files changed, 10 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/tpm_tcg2.h b/include/tpm_tcg2.h
> > > index eb6afe49e77..189a93ee840 100644
> > > --- a/include/tpm_tcg2.h
> > > +++ b/include/tpm_tcg2.h
> > > @@ -345,4 +345,13 @@ void tcg2_platform_startup_error(struct udevice *dev, int rc);
> > >   */
> > >  u32 tcg2_algorithm_to_mask(enum tpm2_algorithms);
> > >
> > > +/**
> > > + * tcg2_log_init() - Set up the elog
> > > + *
> > > + * @dev: TPM device, used to find the number of PCRs
> > > + * @elog     Platform event log
> > > + * Return: zero on success, negative errno otherwise
> > > + */
> > > +int tcg2_log_init(struct udevice *dev, struct tcg2_event_log *elog);
> > > +
> > >  #endif /* __TPM_TCG_V2_H */
> > > diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
> > > index c314b401d0b..9909d9e14d5 100644
> > > --- a/lib/tpm_tcg2.c
> > > +++ b/lib/tpm_tcg2.c
> > > @@ -220,7 +220,7 @@ static int tcg2_log_append_check(struct tcg2_event_log *elog, u32 pcr_index,
> > >       return 0;
> > >  }
> > >
> > > -static int tcg2_log_init(struct udevice *dev, struct tcg2_event_log *elog)
> > > +int tcg2_log_init(struct udevice *dev, struct tcg2_event_log *elog)
> > >  {
> > >       struct tpm_chip_priv *priv = dev_get_uclass_priv(dev);
> > >       struct tcg_efi_spec_id_event *ev;
> > > --
> > > 2.43.0
> > >
> > > base-commit: bab54f5942c428be698216224fd10b91d974d4da
> > > branch: tpma
> >
> > This is based on mainline, but you forgot to CC the TPM maintainer.
> >
> > --
> > Tom
