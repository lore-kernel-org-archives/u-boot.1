Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0CACD6E4A
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 12:32:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15DDE849AD;
	Thu,  4 Jun 2026 14:30:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=binarly.io header.i=@binarly.io header.b="RceoRR/e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AC2E8486A; Thu,  4 Jun 2026 12:48:02 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E04E484715
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 12:47:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anton@binarly.io
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7e6d991991dso415293a34.3
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 03:47:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780570078; cv=none;
 d=google.com; s=arc-20240605;
 b=EM5yCSH+HliwR458mE2M3U0EcfpsH4wG52b0S8cjjLILO2VVyhzcUSAVb6UQ0qpnek
 /eQOF8JM+udTFf3UM6d8tlT4VgiH7mImKrgqcskT+FTy7bRIFxmRN9kBupLfyEGFWUo5
 QoEJTs5Q1s2xVvM6vkb+ZuBaLQdHF/odCJMqm0IvPOmrzQ0f+zpKkx9jrFlIUy2+5eSn
 7I0xx6smizVeP7NcLxKnA6fe441MZuwGBOp/9Pxtw7AanskdZAsEzCXYH1azYPK55/LO
 rmUIkQt7pXuEne29gOC12ZNG6xZtBYa2pxYifUfaM2sP8agiv7ChAvmtAQeueHF2cMRj
 v/kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=o4ruunkhEg6lwmm1waNWCpVF3NGgeYQXJAFxj9lDWyA=;
 fh=eRLhMVYjiCl2rcQv5adzD5Kj+Po2rC6iX/Ox7zWNeow=;
 b=Jktudb3S1D2cE0jt7Z1m/3BQB4MREhN0cr3eMpMCqlpRJJsOeLnmydYCimHp7sh0d2
 tTH56k0HmGzJsHnpsiIiSFGDnQl8dwLuPxHJVGb4/RDsRzfTZBWnT+xjgHIrNkeVnbyj
 KvrD2mt+zwb97JXlwzPKbL8tdh2FnJwAayFYz1qP/r5YmKfvvBo3SldTRLMf/SgfeF/9
 rjEhGKsSS0wfccM0fPz8LMNmmWBGb36UkCctEpEamtlkQw1EDtibBf1OPdmbHjc1bygY
 G+tXDDM2u7Z2iFOAEMcJllQQTAUnfKyLO5ZEZSG2+mSTtUSHrV9356J8s55Da3IJ5WVf
 WNqQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=binarly.io; s=google; t=1780570078; x=1781174878; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o4ruunkhEg6lwmm1waNWCpVF3NGgeYQXJAFxj9lDWyA=;
 b=RceoRR/e1O9DLKovzOBy5+8xan+ajIAOZ2RaRqi3bIMO2gmH5uNR/UJfz6o7o40c8a
 yDOWNkbr5ETR0gaibFJCVJtl+CaW9B+PrVCylxQCXAiJbKvidZ5nateTjwfob549bWkX
 PGk/86yDJYkL4kANFjrhSHkts59Cguvxgv9CHjtA0Yo7iAPm/KH6xuuIKGNLXE2O3y3z
 8kIY8v5pNFNWca7AXW0oEoaj8MZKM3FJY10DGFZIlxOm48zEffFiDMHhSF1bpSRJHyTt
 q64olj2Rwip1gcKXZVHIQbyQTUCfDHhmQ7qwET7rT/zCcy3biC4xVAH8/vBPptox2PvZ
 Slpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780570078; x=1781174878;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o4ruunkhEg6lwmm1waNWCpVF3NGgeYQXJAFxj9lDWyA=;
 b=A5mEf/QWOhUy6Tf2ECQEL+23sUclRRSR2dpYued8+PDAlWyjsmkrNuiUuh696N769E
 RLyK2xIjlEVL1X46XLO9u+ZmxDGXTEignky8phGGCJhsMYOQVp/RQIKKu0Xk74sXNYI0
 b2/e0VBZvQEh2baBt9myNiTSJ93D0yS/kC2aScaeuLtHF5ud2SG0C1i5Aow2GV2MhnO0
 HSB9Bi26xOfkCLIMzK4OfLfO8P3GafxSIiO28XA17zDdH/gQNqMhJLaI3eOny5oBieRn
 UzlJnejjqne00CmHdwpe/QY1cuy2CzVGTLFGufUQFAP9GHR7MVw1beUFciEUTxJuieeT
 B70A==
X-Gm-Message-State: AOJu0YzUSvPXPoOyKQZWEQZ2XhOb/0kMIQ4PmePkNt7Jml9xdcS9Q/iR
 s76nMIyWLVwe9Sv6DOrboGsPXR3jVmQdC+kA41ql6uxXc+Gd/2+KS0HC9dGi1OKtDuQ00dmnYvf
 Ma17CZ/CC4CDevLC7HBbR16V0jREBTBZvgN8OsdDQu1zban0j/O6aU/p+RdhYKGo=
X-Gm-Gg: Acq92OHj7AoAjcVZ1XhzQYadxlcTwC3rEVPE1uaBpzjBAKNE1U0U+wlnZs1CnNQAeS0
 pY8zVEdPDyRodn2SFOfG71OZv1H8TOKRVT8fQv8Cpd/LU7JDuM/MV3rTqiNO5e0KuphbJNzR6qW
 +qql+5SSxIPQ1jSq9qHJnEZ2opfbVzYSrZ8yFVaR46khlMgBEV/FvXBxLYgJXJ9ZGhF5jHlZiDC
 nDDdZBXzgUtrxsnzzJaHeTjm1mHUxG+3XJJYnUSqnhIDF5sbuwCunP1jsHRy18WqtbNIJX4nF8r
 J3TsvtS3593MGMRVqddg7n05SHNp
X-Received: by 2002:a05:6830:6314:b0:7d9:b189:d938 with SMTP id
 46e09a7af769-7e6e94fd426mr4470395a34.10.1780570078546; Thu, 04 Jun 2026
 03:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260527112518.16085-1-anton@binarly.io>
 <20260602183052.65247-1-anton@binarly.io>
 <CAFLszTjpFQLXSJYp-Ceh7XaVhbzWczZKGZAgnPuV1J4kxKGkRQ@mail.gmail.com>
In-Reply-To: <CAFLszTjpFQLXSJYp-Ceh7XaVhbzWczZKGZAgnPuV1J4kxKGkRQ@mail.gmail.com>
From: Anton Ivanov <anton@binarly.io>
Date: Thu, 4 Jun 2026 11:47:47 +0100
X-Gm-Features: AVHnY4LRoak0D84L-8k9D_3II5fr4GwVRpHqyrgrGUeDWN3Zy37zm3hAv4Rs-OE
Message-ID: <CAPWaX55XWFLcMGRuaUuXXn__MX_UG4J8QTd6rvXZmJ4WSOCy9w@mail.gmail.com>
Subject: Re: [PATCH v4] image-fit: Validate external data offset and size
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com, vr@binarly.io
X-Mailman-Approved-At: Thu, 04 Jun 2026 14:30:17 +0200
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

Thank you for the review. The feedback is addressed in v5.

> On your uint32_t question: yes, that's the right direction, but it may
> be best as a separate patch.

Agreed - we'll be happy to follow up with that as a separate patch once
this one is merged.

> drop the FIT_SIGNATURE gate so
> non-signature callers are protected too, and use if
> (CONFIG_IS_ENABLED(...)) rather than #if if you keep any config gate.

As we understand it, non-signed FITs can only be checked against
the valid addressable range. For signed FITs, we can also check that
(offset + len) does not exceed FIT_SIGNATURE_MAX_SIZE. We cannot use
CONFIG_IS_ENABLED(...) rather than #if because FIT_SIGNATURE_MAX_SIZE
depends on FIT_SIGNATURE. Therefore, CONFIG_VAL(FIT_SIGNATURE_MAX_SIZE)
is undefined when signing is disabled, and referencing it here would
result in a compilation error.

Thank you,
Anton


On Wed, Jun 3, 2026 at 6:08=E2=80=AFPM Simon Glass <sjg@chromium.org> wrote=
:

> Hi Anton,
>
> On 2026-06-02T18:30:52, Anton Ivanov <anton@binarly.io> wrote:
> > image-fit: Validate external data offset and size
> >
> > fit_image_get_data() uses the data-position, data-offset, and
> > data-size FIT properties without bounds checking. A crafted FIT
> > image can specify values that cause out-of-bounds read during
> > signature verification of an untrusted FIT.
> >
> > Validate that the external data offset and size are non-negative,
> > and that the data region fits within the FIT image bounds.
> >
> > Signed-off-by: Anton Ivanov <anton@binarly.io>
> >
> > boot/image-fit.c            |  16 +++++
> >  test/py/tests/test_vboot.py | 165
> ++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 181 insertions(+)
>
> I think I have lost track of the versions here. But we are now on v4.
>
> > diff --git a/boot/image-fit.c b/boot/image-fit.c
> > @@ -1087,8 +1087,24 @@ int fit_image_get_data(const void *fit, int
> noffset, const void **data,
> >
> >       if (external_data) {
> >               debug("External Data\n");
> > +             if (offset < 0 || offset > UINTPTR_MAX - (uintptr_t)fit) =
{
> > +                     printf("Invalid external data offset: %d\n",
> offset);
> > +                     return -1;
> > +             }
>
> The offset < 0 check is after the offset +=3D ((fdt_totalsize(fit) + 3)
> & ~3) addition on line 1082, so we could have a signed-overflow window
> is still open
>
> Should return -EINVAL as -1 is actually -EPERM
>
> On your uint32_t question: yes, that's the right direction, but it may
> be best as a separate patch. Changing the prototypes of
> fit_image_get_data_position(), fit_image_get_data_offset() and
> fit_image_get_data_size() to use uint32_t matches what was done for
> image-fit-sig: Validate hashed-strings region size. Please go ahead -
> it lets you drop the < 0 checks and do the bound arithmetic safely in
> unsigned. The callers I checked pass the result through as integers,
> so the churn should be small.
>
> > diff --git a/boot/image-fit.c b/boot/image-fit.c
> > @@ -1087,8 +1087,24 @@ int fit_image_get_data(const void *fit, int
> noffset, const void **data,
> > +#if CONFIG_IS_ENABLED(FIT_SIGNATURE)
> > +                     if (len > CONFIG_VAL(FIT_SIGNATURE_MAX_SIZE) -
> offset) {
> > +                             printf("FIT external data is out of bound=
s
> (offset=3D%d, size=3D%d)\n",
> > +                                    offset, len);
> > +                             return -1;
> > +                     }
> > +#endif
>
> Please split into two checks so the subtraction can't underflow (if
> (offset > max || len > max - offset)), drop the FIT_SIGNATURE gate so
> non-signature callers are protected too, and use if
> (CONFIG_IS_ENABLED(...)) rather than #if if you keep any config gate.
>
> > diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
> > @@ -563,6 +563,171 @@ def test_vboot(ubman, name, sha_algo, padding,
> sign_options, required,
> > +        ('off-bounds data-position',
> > +         {'data-position': 0x7FFFFFFF}, 'FIT external data is out of
> bounds'),
>
> lower-case hex
>
> Regards,
> Simon
>
