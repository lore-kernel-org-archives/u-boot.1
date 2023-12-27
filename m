Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E51C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 15:11:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EAA487823;
	Wed, 27 Dec 2023 16:11:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ux5yfP0Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEFFA8793E; Wed, 27 Dec 2023 16:11:54 +0100 (CET)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 844FD8775F
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 16:11:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6d99980b2e0so3012829b3a.2
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 07:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703689911; x=1704294711; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=14HSa+RtaqLdvWTFNsht9WY1c7jPP9I2/pZrgNA79xg=;
 b=Ux5yfP0YpDno7WiEpyTZWsIG64cTXjHnqiwCaPwaPgYVLepCXTPWnwhUJFOy6tSPvX
 ULflM3EmFwjWtWQzuxhY9LzobIXjEKcwT6lDCoTYdPWZtd/rsM5dWiKxT8+O933lKvm+
 SD+T9baw2d3DP/0F+JMPdYiDQVHnUSPc7V/ve+jH4jDfNcOok8HITiFEaH4Pp6E9ZMc0
 fWAXnqpxF+3j6YYK4OVEhZ7Wr11PnjHHOMfyqShhnICBfcMydYQ09SGDvIs+DGYVklKi
 sUO40BrNeHvAeQSTaDnmvLgWZapcJD7Ofbwp1WoAC5W5ZftqVzhoRCxyGYUdp7TCWJHr
 ltuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703689911; x=1704294711;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=14HSa+RtaqLdvWTFNsht9WY1c7jPP9I2/pZrgNA79xg=;
 b=EXTnMGa+bCtmwFT8V1ZBpISYBH5f8yVIk9dEIzF2s+AM0ZjGR1nnj5t8qF1SBQlPKm
 jpLeWgtw7amIm1yEhREK/BDm3mGhnwzbtDP5DZpjLpUYcqD0euVDJzl2EtPVmocYe9ZY
 0RginH892MO1QHzaMpZ9BBXpoG2xJTdBrt+LHFfVuT5yR3onnr58PyQK3Kn5ihZT+EL2
 qrfEYPNsyjhVIX+qTVX8z4Yfg63MFMXtbszTY68IXHQ6IgFAHakAKBixG271GLQr4zRv
 HDazCyvDS5tWKBV2LqnZVC4K+JJcgOIz/7LXyQ7Y7/c+UJJ9vJMJJMntzTY7lU4y2xKE
 pUTw==
X-Gm-Message-State: AOJu0Yw9SQJZFxMuJKvFRL1sijh/bRcm1OrGCDTWwsbnaBlE2qRKy1gE
 TOS0ZfqlTgvolUCJsdLcoz5JzYvlDH72ru5ewJbl2bsaGMWsQg==
X-Google-Smtp-Source: AGHT+IFQDJuh9c9K9ITNOzQj5X0Qeu/WIzWd2lvFZ7L6YZH27dGTVJrTipdpsCpnIZrbd1AexuEZYiFXtkWq3JnJHgI=
X-Received: by 2002:a62:5e03:0:b0:6d6:9bfb:c65b with SMTP id
 s3-20020a625e03000000b006d69bfbc65bmr9342184pfb.0.1703689910885; Wed, 27 Dec
 2023 07:11:50 -0800 (PST)
MIME-Version: 1.0
References: <20231218181901.337515-1-raymond.mao@linaro.org>
 <20231218181901.337515-13-raymond.mao@linaro.org>
 <CAC_iWj+xY7-JioFgU5XG3+cPmhGTmGN2_jdigHELAOD+XL=yHQ@mail.gmail.com>
In-Reply-To: <CAC_iWj+xY7-JioFgU5XG3+cPmhGTmGN2_jdigHELAOD+XL=yHQ@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 27 Dec 2023 10:11:40 -0500
Message-ID: <CAEfUkULxwgQ+=w7pnoGiFomprd9Ye=AUrH5uzM100sf-Hv52hA@mail.gmail.com>
Subject: Re: [PATCH v3 12/14] bloblist: Add alignment to bloblist_new()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jwerner@chromium.org, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Ilias,

On Wed, 27 Dec 2023 at 05:10, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> On Mon, 18 Dec 2023 at 20:20, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > From: Simon Glass <sjg@chromium.org>
> >
> > Allow the alignment to be specified when creating a bloblist.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> > Changes in v3
> > - Keep the flag argument to align to FW handoff spec up to commit
> 3592349.
> >
> >  common/bloblist.c  |  5 +++--
> >  include/bloblist.h |  3 ++-
> >  test/bloblist.c    | 40 ++++++++++++++++++++++------------------
> >  3 files changed, 27 insertions(+), 21 deletions(-)
> >
> > diff --git a/common/bloblist.c b/common/bloblist.c
> > index 1c97d61e4a..6d079c58f7 100644
> > --- a/common/bloblist.c
> > +++ b/common/bloblist.c
> > @@ -349,7 +349,7 @@ static u32 bloblist_calc_chksum(struct bloblist_hdr
> *hdr)
> >         return chksum;
> >  }
> >
> > -int bloblist_new(ulong addr, uint size, uint flags)
> > +int bloblist_new(ulong addr, uint size, uint flags, uint align_log2)
> >  {
> >         struct bloblist_hdr *hdr;
> >
> > @@ -365,6 +365,7 @@ int bloblist_new(ulong addr, uint size, uint flags)
> >         hdr->magic = BLOBLIST_MAGIC;
> >         hdr->size = size;
> >         hdr->alloced = hdr->hdr_size;
> > +       hdr->align_log2 = align_log2 ?: BLOBLIST_BLOB_ALIGN_LOG2;
>
> nit, but can we write this as a full ternary operator in the next release.
>
> Yes, I agree. Will change this in V4.

Regards,
Raymond
