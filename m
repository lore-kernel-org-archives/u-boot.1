Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DA7E784AC
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 13:02:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BB3F87167;
	Mon,  2 Oct 2023 15:00:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YXtrTuab";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E794870DE; Mon,  2 Oct 2023 14:42:54 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A136B870D1
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 14:42:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=viraniac@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-523100882f2so21518512a12.2
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 05:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696250572; x=1696855372; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=223ACxqdg0nkH/otEslobyv6NbTjepSS6radzJ3oKRU=;
 b=YXtrTuabvTvQVKP+PLnS3ZMud1DgES9VLOIogVYNAD1/3HAQCwjLa/NsYUSCLKPg6e
 rYgnL1DvXQJbkGokdXf4l/7BrxExscEubo6oGyfwbk80vY9PNVwzvBQADc1g2igeFUOl
 ZXO0L82rMyioEfUQ1IcYgnPyQ4ykyLYd7hKyh2kkPDrWiiphpj0q/u/aMnjeFKQHRK9V
 u002/Z9HErqv5ujBfPgbFmdpVvfRxZz52DxDAJBfyAPWsl6gZ0QG47wW2usQu1g3Gh12
 9Ap5cyLNpuY735aGu87rqR6cpmaNVXRf990ckid9kIk8ZAjreijajD/EXRZhtMbVvNNG
 46lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696250572; x=1696855372;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=223ACxqdg0nkH/otEslobyv6NbTjepSS6radzJ3oKRU=;
 b=bjb0dHTwAkc9scfRYpxHHRljCpugSSYraOUd+/RRS7d6IEEoBHsNLY16WXUhLwbPrm
 HKosRT9lrYbVNpy2NSnnrTtoO08LKM3cOcbbAMuZH/2VrV1NUJ9PQ5AfPxyP47h+eFw5
 8XLuQ3hka91zjHaSUM+rclHke4Ntg9sqGCqaMEOX2wCoIfhFT9VMWe4zqt2PF/T7b4TN
 dx3SXzzoB3Fhd1QZr+wXKfIZteuFn3vvfHsoEKBA7heH/r9zb4PlUrty9xVf4v/sMlwq
 Xtp4ZM1zxqXQ60xbpMOPchLK04PTxJskz18530YNLyyDmIFwfNpLDJtbkC2tRjUIXWxT
 TtGg==
X-Gm-Message-State: AOJu0YyMz8VjS9sqqMB++FuFiq8EDWGfcDZioMAGaTGv2uYoPr5ItTdC
 R8YiSio6AfRlRtjOYO/d41rm0/AHC467ACFh4oo=
X-Google-Smtp-Source: AGHT+IFM0S4Jaz62/xLUfPnV6C/g2LTEFE6cUVUwDSWSjCCzD+dBNNvWpcZu4kYzAeJB/ldpX+oavH7WtppgEZF+dHs=
X-Received: by 2002:aa7:cb13:0:b0:526:5c70:7318 with SMTP id
 s19-20020aa7cb13000000b005265c707318mr9354689edt.6.1696250571925; Mon, 02 Oct
 2023 05:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <20231001161336.31140-1-viraniac@gmail.com>
 <20231001161336.31140-2-viraniac@gmail.com>
 <20231002122626.047b4043@donnerap.manchester.arm.com>
In-Reply-To: <20231002122626.047b4043@donnerap.manchester.arm.com>
From: Gunjan Gupta <viraniac@gmail.com>
Date: Mon, 2 Oct 2023 18:12:40 +0530
Message-ID: <CAJAzxbVw_TZ+eJ6uh63nCp5ggZR76k5bup49TkUtZV426M3R+Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] sunxi: dram: Fix incorrect ram size detection for
 some H6 boards
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Ondrej Jirman <megi@xff.cz>, Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 02 Oct 2023 15:00:05 +0200
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

> >  bool mctl_mem_matches(u32 offset)
> >  {
> > +     dsb();
> This looks a bit odd, do you have an explanation for that? And are you
> sure that is really needed?
> I understand why we need the DSB after the writel's below, but before that?

I started with Ondrej Jirman's patch from LibreELEC's tree that had a
dsb call added
after the first writel call. That reduced the frequency of the errors
but didn't removed
it completely. My reason for moving it before the writel was to make
sure any memory
access is completed before starting the actual logic for the test.
That reduced the
frequency even further, but didn't resolve the issue. I did try
removing it leaving only
udelay added to the code, but that brings back the issue.

> The only thing I could think of is that we are missing a barrier in
> mctl_core_init() - which is the function called before mctl_mem_matches().
> Can you move that dsb(); into mctl_auto_detect_dram_size(), right after
> the mctl_core_init() call (where you add the udelay() below)? And I wonder
> if a dmb() would already be sufficient?

Sure, I will try experimenting with it.

> I noticed recently that the clr/setbit_le32() functions don't have a barrier at all, maybe
> that should be fixed instead?

I haven't done much of the low level programming myself. Mostly have
done user space
programming along with fixing minor kernel module compilation issues
due to kernel api
changes. So I wasn't sure what all places to debug. But if you point
me to places with
things to try, I surely can give time playing around testing the proposed fixes.

> > @@ -623,6 +623,8 @@ static void mctl_auto_detect_dram_size(struct dram_para *para)
> >       para->cols = 11;
> >       mctl_core_init(para);
> >
> > +     udelay(50);
> The location of that udelay() looks a bit odd, any chance that belongs at
> the end of mctl_channel_init() instead? And how did you come up with that
> and the value of 50? Just pure experimentation?

Before adding the udelay, I added 7 print statements to print all the
members of the para
struct. That itself solved the issue along with the dsb added to the
top of the mctl_mem_matches
function. This is what gave me the clue that a delay is needed there.
The value of 50 is
indeed from pure experimentation

Thanks & Regards
Gunjan Gupta
