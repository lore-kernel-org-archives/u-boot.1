Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D65C2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 04:34:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 114A887702;
	Mon, 24 Jun 2024 06:34:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uVANoV9X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CD8387923; Mon, 24 Jun 2024 06:34:20 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B55E1876D3
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 06:34:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2c70c08d98fso3086368a91.0
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 21:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719203656; x=1719808456; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T1bLInjVzIQEjwbKUX8FEODR3+132nSIrXW69XRpLvw=;
 b=uVANoV9XhdO2jJ5Pff1Lj45JGFtb75hYorC1eCwkNsSJlNmOJjOr8ycY7Fj5vqFcZV
 PndNgJvjW8Zh14olBoLAqj3fCPkUK+TQMQuys3W/W3/onihgDzX2OUVfjlPOEjJT7AoQ
 CI/pWV8C9DEzx8EWT/9qXyUomX51mgFSDoEJiZxkS7s/JY22za3cm+08h+vRUc65AgDh
 zLupVqfdD8um6siXpvJK8K2hZkJ7sPQDV2xLaitFLV2OMtuItsMbiqOi/wC1NMgo0/xd
 5zT7LqMSGv/yKzEs/9W5MTXZwpGZnvxx+R4WYAWDHFIChCqZoWPweL2YfGnIx7ka/Z1V
 VCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719203656; x=1719808456;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T1bLInjVzIQEjwbKUX8FEODR3+132nSIrXW69XRpLvw=;
 b=MZ4MgsiGhtfaw75gtHppsIhC6U+wJay9nb+VbIjgTfdAz8C2pCV3BuNT2rs3voxueR
 zwE6XOmdLxBanMoIKJQOnMhpevQrPgXKBSmI8lBkMT1zHEHtisEGDvw0gAUaVuoZcoCP
 Xvy3RxOkqezwMx0yGIYr34n85DBjfsb5G0bEEFhNzBBqlsOV5nmL15bWDsJzaGddEID7
 kxkPx2K6HZDeh/AeXrqq38QcdI4uqEhriobI0gcvcxusbFGpKpXETqDaLUOS/N+y7cyX
 WFnFjpi280bB3ujwYwp43am9bzCUZ8TqgjQcirI6mYSqb+rF0fUtS/h40zzf4bIrZcg5
 tmcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+4uAlNB2P+Tum114T/F+LZlGGFUOR/yP+imkT7Y/DcjdFor44xCrMuUH/n6c/TGAz+HPx3ElFnKNutxlpxNpiVq+UrA==
X-Gm-Message-State: AOJu0Yz9AiHTKGHAQcKeGrPIcSV2676nweHQkB/fwWz26bBFmY9soFXA
 SqYDQ6yM1xZ51WxvEOebBKrg48RH3MYf1bBX7DY23aBjiNS2n0iHMicea3pF4OCGt8o/pjuPxLs
 1xcw2i3r/Yb/SyFZKg06g9/HaGrjxzILbxhI9sw==
X-Google-Smtp-Source: AGHT+IEuf2T9uHNhsaYtXvQAwNGb/gj+R7UFJDDPUsmgt7AF15clu9Gf27wGMapSYt02wRgqGBY9oGFSbdkShltQzQI=
X-Received: by 2002:a17:90a:7444:b0:2c8:84b:580e with SMTP id
 98e67ed59e1d1-2c85829734amr3116496a91.41.1719203655964; Sun, 23 Jun 2024
 21:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240623114838.14639-1-ilias.apalodimas@linaro.org>
 <20240623114838.14639-2-ilias.apalodimas@linaro.org>
 <CAFLszTg+OA3Dt_9Yjiu5X=Rhnt5g6HRcXQYopg_mQVnyp0=2iw@mail.gmail.com>
In-Reply-To: <CAFLszTg+OA3Dt_9Yjiu5X=Rhnt5g6HRcXQYopg_mQVnyp0=2iw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 24 Jun 2024 07:33:39 +0300
Message-ID: <CAC_iWj+3nrRDP9p_jESyQi3qjsRS892x7S_JKGVsPQoDWUkfVA@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] tpm: fix the return code, if the eventlog buffer
 is full
To: Simon Glass <sjg@chromium.org>
Cc: xypron.glpk@gmx.de, trini@konsulko.com, 
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Tim Harvey <tharvey@gateworks.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Sean Anderson <sean.anderson@seco.com>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Michal Simek <michal.simek@amd.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
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

On Mon, 24 Jun 2024 at 00:52, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Sun, 23 Jun 2024 at 05:48, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > We currently return 'No space left on device' if the eventlong buffer
> > we allocated is not enough. On a similar check later on that function
> > during the call to tcg2_log_init() we return 'No buffer space
> > available'. So switch both error codes to -ENOBUFS since we are always
> > checking a buffer and not a device.
> >
> > Fixes: commit 97707f12fdab ("tpm: Support boot measurements")
> > Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >  lib/tpm-v2.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Thanks

>
> For better or worse, we mostly use -ENOSPC for this sort of thing. But
> this will at least make the TPM error stand out.

The TCG spec is an EFI one. Since we moved that code to u-boots core
we had to convert the return values from efi to int etc. We need
mapping to be as precise as possible.
The reason I switched this to ENOBUFS is because it seemed more
appropriate. I just wanted that function to be coherent on the return
code, I can switch both errors to ENOSPC just as easily.

/Ilias
>
> >
> > diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> > index a67daed2f3c1..91526af33acb 100644
> > --- a/lib/tpm-v2.c
> > +++ b/lib/tpm-v2.c
> > @@ -554,7 +554,7 @@ int tcg2_log_prepare_buffer(struct udevice *dev, struct tcg2_event_log *elog,
> >                 if (elog->log_size) {
> >                         if (log.found) {
> >                                 if (elog->log_size < log.log_position)
> > -                                       return -ENOSPC;
> > +                                       return -ENOBUFS;
> >
> >                                 /*
> >                                  * Copy the discovered log into the user buffer
> > --
> > 2.45.2
> >
>
> Regards,
> Simon
