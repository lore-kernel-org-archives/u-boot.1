Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F518CD5BD5
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 12:58:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB8A484866;
	Wed, 27 May 2026 14:57:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=binarly.io header.i=@binarly.io header.b="h4BSb5pS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1F318341A; Wed, 27 May 2026 13:27:49 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 321ED803C6
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 13:27:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anton@binarly.io
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-69de16f5f79so370813eaf.0
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 04:27:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779881266; cv=none;
 d=google.com; s=arc-20240605;
 b=Vy2/liVfMOJGkkyGcvw5pEjZgZmV0ojMkhfT4534St9ApRAFd7zvOah5MldLTyVHCj
 WE+TYx92G7Isfn0Yk6lQi2BKULN6prpi27tfTvUJ/CdJBJSXMCkl5kXAmTo0Hh59S3t4
 pWscg/AlenLo2TigSpR/PeIy026bNJ3MzQkGAoAhvhRZ63O281YYs+983aUOZPUrN8/h
 TI0rUmYUtSMZjcE2ve/TDjGYuR5gAPgCH2akwxXY9bXmnJbUfZqFA2RGd6hD6XC/xxga
 jdcIa314WKtGj6AJnR/FKdxTJQGPyLgR9bXpQKHmaLhKCQSQHzOYOV2nOU08CZSzLmEb
 Y6Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zh00vI+Oc1jJQaVwWin9m0LEzXai/QVrMcjZV9LVkoE=;
 fh=eRLhMVYjiCl2rcQv5adzD5Kj+Po2rC6iX/Ox7zWNeow=;
 b=X/+acYkT+Mzd9vS9FN6jJWDb6xF0x7DCppdZH55kpWZgHn/58oI2Co52WCVnJZTrOY
 UuAJbeQxqBxyyspQWgwvXVS/lc4cA7OkiHjiO+eDDk95IfLA59bT2ec0P/Rouac8eL04
 WLTcB8G1RBxDaPRqep2KKFEw2ZXwBTo8voVkJd1tKG8pnMPmHHiw/SkaeNh328pBBLP0
 XFP0Z3kaMNGUDi+0OS84+XmZqXqNmHQxG6urgQdnkQAkvh17f3HVWUdwt6RUzo9K8Q8i
 JeFJxIlRPkzu6QUpMzoGWWJNBVQbVrnb/NJL44jMKaoeJ5h/AS/E5/CoU5+714355NA/
 pfSA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=binarly.io; s=google; t=1779881266; x=1780486066; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zh00vI+Oc1jJQaVwWin9m0LEzXai/QVrMcjZV9LVkoE=;
 b=h4BSb5pSVSA/7sRAyHi+lNB55yr7ydGxHL9SmY5voGt9zH3UjovxWjpODsHp1Wqoop
 p8DXUpan5mSR6Qwk+SHsnsgYpYOxsKQQrc9MUPY3R4iWbpm2zNhfjl2Aj6/EjcVzfAVw
 eu5eNagAsBIGxQneDQkEWJ8VXoN0C2+mml2Lv9d86pAoiAG3VI8QYTn2b/7Bovsa1QNF
 1zyRjyr0iB7ut9f+JBc7TnFxsbK+eY4e4yYtKo59ENVZLNgqkunTn3cPwYOXXk1SoUtq
 xyQqxIMjh9MjuT+NvKMBzdkzEYZiJv38rEI9Uu+n5QMOO/IUIA8Vzt3ZxB/OXyyiHwHc
 JrvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779881266; x=1780486066;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zh00vI+Oc1jJQaVwWin9m0LEzXai/QVrMcjZV9LVkoE=;
 b=V/P1EsuggiFxyeuqsahix8P19YnOio09Ab/dCpFTEh+CzvUUsG6kdDVxUZsuZ9hvwu
 oZO5KxtCHVGcsgKb9tIzdrNr/lGTUpMDPXANokm56s9YNpRY+wgOOy5io9246os1e39S
 sZhbC51c2NHtYiaj4o6yFDPSnteVAM20acHQmB6OSaNcnJuBpqmnGt067df9iqVQexPc
 FAQB576JvOo4+1KegSsWtFFkvQr6/t85/WHmEfS5utb75KEq41nW30sXe+4D4vRtr30Q
 zy8FQAagzFPakqxmetYFfceLQnmUFQ+OxM25uFyrTLHuGnIMBdnM2I+n4iNlv3YREtMp
 VK0w==
X-Gm-Message-State: AOJu0YwJV0gzCEeamE8tTzyJXejAVAngPi4AH5Jai1EWfKyg+tWpe8M/
 OX/mNRDsN3XGegG2MNnapM/wFAqw/qC4l3jV0elsZSRDotgv2CBhKZ7hOrxvqsQlth9yzz8Aee3
 L3o1ijMdG4HPOL0CdTxlHBactGBw/iO6tLZECkPIzlw==
X-Gm-Gg: Acq92OFu+tpdX4GsYH5ewKKue014vwgmyUS/YDteP//hzxR6uHUlpc/8Dx7U/YW9htq
 5PI5kwAcNniQ/DUH5S/lztR/o/utrgY1GHKaghseMGO56Ztj2Jz7yJIGvRtWbqRzwGQH1/WkSMM
 eeOc/qN0qc1EzAeQx+HiAeF9J31xjQ+rCztTmhdvULyx7qcnG02nNm1CGYFbkWxy458PNeyQvOr
 zdXcUMTQdvsregb38PAhvAjPP2LbVAswnG7xhTrVn2c9K7DLmLsXpM7xIngdHWeclErLu/P3+l1
 7uxvRo77Jw2AjOqmEg==
X-Received: by 2002:a05:6820:4b97:b0:68b:7825:e68f with SMTP id
 006d021491bc7-69d7ecd5b92mr11434952eaf.49.1779881265732; Wed, 27 May 2026
 04:27:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260522183228.GZ1858239@bill-the-cat>
 <20260526104744.33248-1-anton@binarly.io>
 <CAFLszTj1rx67qY7AHB70w2+zUSGFYFgAocTbVtibt6rZp7pjRQ@mail.gmail.com>
In-Reply-To: <CAFLszTj1rx67qY7AHB70w2+zUSGFYFgAocTbVtibt6rZp7pjRQ@mail.gmail.com>
From: Anton Ivanov <anton@binarly.io>
Date: Wed, 27 May 2026 12:27:32 +0100
X-Gm-Features: AVHnY4IyxyOCfIPYiEHoClIf5kacRUkti7Giithq9_GTOLSJvl7zDSHpRiVWpEI
Message-ID: <CAPWaX56Teeo1_=eG3P_E5zp=NzYypsbRsA8ZSan+pG5MgUO26Q@mail.gmail.com>
Subject: Re: [PATCH v2] fdt: Check return value of fdt_get_name() calls
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com, vr@binarly.io
X-Mailman-Approved-At: Wed, 27 May 2026 14:57:27 +0200
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

> Is this a person? If so, can you use his/her name? As it stands it
> seems like an orgnisation rather than a person.

We changed it to personal email in all the patches.

Thank you,
Anton


On Wed, May 27, 2026 at 5:46=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:

> Hi Anton,
>
> On Tue, 26 May 2026 at 14:41, Anton Ivanov <anton@binarly.io> wrote:
> >
> > From: Binarly Vulnerability Research <vr@binarly.io>
>
> Is this a person? If so, can you use his/her name? As it stands it
> seems like an orgnisation rather than a person.
>
> >
> > fdt_get_name() can return NULL and set len to a negative error code.
> > fdt_find_regions() does not check for this, leading to a potential NULL
> > pointer dereference and a buffer out-of-bounds write. fdt_next_region()=
,
> > fdt_check_full(), and display_fdt_by_regions() also lack validation.
> >
> > Add NULL checks and propagate the error code from fdt_get_name()
> > to the caller.
> >
> > Signed-off-by: Binarly Vulnerability Research <vr@binarly.io>
> > ---
> > Changes in v2:
> > - Rewrite commit message to be concise per maintainer feedback
> > - Don't mask fdt_get_name() returned error
> >
> >  boot/fdt_region.c           | 5 +++++
> >  scripts/dtc/libfdt/fdt_ro.c | 3 +++
> >  tools/fdtgrep.c             | 3 +++
> >  3 files changed, 11 insertions(+)
> >
>
> Regards,
> Simon
>
