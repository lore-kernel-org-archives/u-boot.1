Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 436E5CED240
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 03:48:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86CBD83C16;
	Tue, 18 Nov 2025 04:48:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PtfRH2+4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E82683C32; Tue, 18 Nov 2025 04:48:14 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EC2782B20
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 04:48:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b735e278fa1so741513766b.0
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 19:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763437691; x=1764042491; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FWBqoL7aB06cZGPbyoGygw2aZjlPYSyRyWlxuznouG8=;
 b=PtfRH2+4Xot2s5dTCFyt/swEkf77C7OtueYIs3KgsKq1JfHMUpArPDuVRXwUcs6PiO
 Z1LaaWu9SIASpI5RS4r9l5LxKABRGuLgBVaZXHfzCj05iWk+TUiLP7QHHvHfvUAo+3uE
 p5Q8KEFGPXxCa/TQ8CkVJbXCCKMlj97sZz4rw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763437691; x=1764042491;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FWBqoL7aB06cZGPbyoGygw2aZjlPYSyRyWlxuznouG8=;
 b=vgNt4kExA5s0v5MGCNsn6opLgXxnv7cyJeb2OLkAqGuM67C0A/md5yE5uDPISLR0FA
 Nn0yf5uVj0P3L2BEXhdQKAgEwXv9MlIOZh4aaOrOpI100FRlfkvRevGVYg4jLGbOf+mZ
 IDEqOs7OhMO94RkVX/+yOGJtABCfbPgj8+sEgKxYN58DWeDDgJqrOdDmcOPJ6iNflHDH
 7fCkF4EL2xRyGKdqEVo6B7pWrSXAQclO63JOparRbf1Cdr4rDfEzftoTC81WlYhtPOKD
 TuzHmnz/EN8ggWftld9LyZbpHPMPchv4OZLpORm7en994p4dLpFdepWwAOm4Aiqw3NEG
 tqTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkB8XGEMixpWR7GCa+WyrqS+mRWf+YXT7uUXwfak6D3fPckF3GrzUU02X+NoHf14/j4b4Xqco=@lists.denx.de
X-Gm-Message-State: AOJu0YyLKX0kNlcfmepzaOf/Q/w8Q30bxsQFqLbRMPIyRErT8Z4quIRy
 FkSIp37BALI7kZzCHpTYnQ5uJPqpdiuv/5gEa3obYVzQ2WM1/yKn5IYWafE8dm2cx+of4MN6YkT
 fBJhG6am7a3iVXyezW0ZS0/B1VGWvRku9TphBae0p
X-Gm-Gg: ASbGncuQwOwAZWLX+HR5OYXKYjABhgL55KEG8rEF2wA5XLi4g7fnzm1v5OwRYqhG8hH
 wX2HiCVJGeO2WDGWJqZN1qguUEEeqeqj2AxVML8qV9dg82UebJVCOTjXPuiCXibPUagAsPUlofs
 fxJPcMyMStV1vFfUOtYY+hfsE8AX6NGiAwLb+ZzrebgG4oBK3jjT52K6y2TEUo5Hh7UrD23zbK+
 nXF4rFalpdxKvTuQFV3Lq4PHYzobvk/p/2ibv8SphtKftnWpYNq4WsbZNwLKXmXLMjMqtVobG4z
 fSN/I0OLShTUU4w=
X-Google-Smtp-Source: AGHT+IFdOhF/ZIFR4qNgDZkHQfdAvCpyst7B7qPkjLXO5m+zlJgzign4ecZPZPE2SI4+VnAtPMI1oVv0RGrhYWpY/RE=
X-Received: by 2002:a17:907:3c90:b0:b73:4aa5:35e5 with SMTP id
 a640c23a62f3a-b73678289bamr1615099866b.7.1763437691627; Mon, 17 Nov 2025
 19:48:11 -0800 (PST)
MIME-Version: 1.0
References: <20251113115516.947835-1-marek.vasut+renesas@mailbox.org>
 <CAFLszTg0ByjUGgX4MSbU=i0oG7fuidM4J0J128ER6Aq+r6HW9A@mail.gmail.com>
 <81115588-50c7-4ecc-975e-13994101955f@mailbox.org>
 <CAFLszThNLoS7j0pe_8G93dHtX91j331DCBiUgWpUPXi4Oi2-9w@mail.gmail.com>
 <c5300029-9bab-4a06-b426-ccc443d0928c@mailbox.org>
 <CAFLszTiV2jTWcWU+27QxX82Ap9YnhZNTK1sXrFvF_e53ydc5_g@mail.gmail.com>
 <706283a7-2ba9-4b8c-8cb4-3db42759acc9@mailbox.org>
In-Reply-To: <706283a7-2ba9-4b8c-8cb4-3db42759acc9@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 17 Nov 2025 20:47:58 -0700
X-Gm-Features: AWmQ_bmXrY24SZwbYZlmONp5m9TMUUEUN0oQsLWxMG7mWuUi9N3rINSg5Ph4RLQ
Message-ID: <CAFLszTh5MaFqC-pP5z4j8jLs4qmUR-jhS5wYob2kkVTFDQB0Vg@mail.gmail.com>
Subject: Re: [PATCH] boot: Assure FDT is always at 8-byte aligned address
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>
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

Hi Marek,

On Mon, 17 Nov 2025 at 19:25, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 11/17/25 6:04 PM, Simon Glass wrote:
>
> Hello Simon,
>
> >>>>> The problem should be fixed higher up, in its callers, etc. For one
> >>>>> thing, the caller knows whether it is a DT or not, so putting this
> >>>>> logic here is messy. See boot_get_fdt_fit()
> >>>>
> >>>> This is triggered by a fitImage with DT embedded in that fitImage as
> >>>> non-external-data. That DT is at 4-byte aligned address, so how can the
> >>>> caller deal with it ? The caller gets a fitImage, which itself is at
> >>>> 8-byte aligned address, but the DT in it is not at 8-byte aligned
> >>>> address, so that DT has to be relocated somehow and that happens here.
> >>>
> >>> OK, but don't put the code in here...see boot_get_fdt_fit(). But even
> >>> then, why does it matter where the FDT is?
> >>
> >> The FDT has to be at 8-byte aligned offset.
> >>
> >>> We are going to use
> >>> fdt_openinto() at some point and put it elsewhere, right, so we can do
> >>> pre-boot fixups?
> >>
> >> Look at the fit load code, cca. 10 lines below, it checks the FDT for
> >> validity using fdt_check_header() . At that point, the FDT must be at
> >> 8-byte aligned address already:
> >>
> >> 2294         } else if (load_op != FIT_LOAD_IGNORED && image_type ==
> >> IH_TYPE_FLATDT &&
> >> 2295                    ((uintptr_t)buf & 7)) {
> >> 2296                 loadbuf = memalign(8, len);
> >> 2297                 load = map_to_sysmem(loadbuf);
> >> 2298                 memcpy(loadbuf, buf, len);
> >>
> >> ...
> >>
> >> 2309         /* verify that image data is a proper FDT blob */
> >> 2310         if (load_op != FIT_LOAD_IGNORED && image_type ==
> >> IH_TYPE_FLATDT &&
> >> 2311             fdt_check_header(loadbuf)) { <----------------- this
> >> 2312                 puts("Subimage data is not a FDT\n");
> >> 2313                 return -ENOEXEC;
> >> 2314         }
> >>
> >>> Perhaps we should deprecate FITs with internal data, too?
> >> We cannot break compatibility and stop supporting old fitImage, so this
> >> is irrelevant here.
> >
> > OK, so please create a function which can detect an FDT header without
> > it being aligned, like the other code you wrote. Then it will be safe
> > to call that here, even if unaligned.
> But we actually do want to detect unaligned broken FDT header and either
> fix it up or stop processing, we don't want to perpetuate handling of
> broken FDTs and pretend that is OK, it shouldn't be I think. Hence this
> fixup.

The decision as to whether something is an FDT is made a lot earlier
than the actual processing of it. For the former there is no need to
allocate and copy. For the latter we need to.

Anyway, you are doing the patches, so do what you think is best. But
please create a function for this, rather than lots of little
hand-crafted checks around the place.

Regards,
Simon
