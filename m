Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8BB3C001B0
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 17:48:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 291E486913;
	Wed, 16 Aug 2023 19:47:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bWsrTfJ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C172869F1; Wed, 16 Aug 2023 19:47:58 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 988C6868B6
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 19:47:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-99c353a395cso920378666b.2
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 10:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692208074; x=1692812874;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Zvb4EMhuQrNM/UaQO5x+8B7j7oOOcRVDoATvzK0v9HU=;
 b=bWsrTfJ/YHSE5d3CIRjN7R53c+xt7CgwdGzuPszxDCRa4M6CV89Rj3w7sH0lR8leI+
 eSekQlVaZT+GetBYV/zhCJb8pRIoxk+qpxy9Nb4vGs3T/4iVHSXTtg0oHN8flURyITn1
 OkHH8EbQI3Ef6mSIEEUvUuPPOxqNCqM5UxzKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692208074; x=1692812874;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zvb4EMhuQrNM/UaQO5x+8B7j7oOOcRVDoATvzK0v9HU=;
 b=KDPEw0Y8SJt974M4i5OqC30qG1z5FnqY5qYZky622oFzQZfsccaK8OqnjhT/YrZFf/
 btZsJ3S0vAfLl5VT53KUWGIlt3wy2ajuRAXu4z+Lywn6Sf/0NC4RtbSURjPUjF55zU1N
 A44X7NZDGT1Rv2Hjq7DomYfMbynpDdLhwLtdy9sfGdrIAGIfzIkJKoqSh3/IlLEkgjLX
 b3hE6+mbkv1rHndVcB3p2Q4xLxyb82B/fqJ8wWBEdtG8JNz1qrmVm3dnqpE9xVV//BYe
 8uAP5ShKPkxk+6glt4+QBR6VdqDBdKkE3jAGnhQlJ6LUapTU8stHX6L9m1x34LQVvd7q
 NIYw==
X-Gm-Message-State: AOJu0YyLzpEfqSUOYw0X1VeHGWIx/i7oPnURQRjzRsrx71jgHl/HEZgN
 GLxS/Tm2znOkMw1xDcrnZHUAmIOmlWIxTGyfSusqmg==
X-Google-Smtp-Source: AGHT+IGn1OFTu9kNngAij5DxCSjUSZjzX8qHAZHisGsqEvd0IreL1w7+N4WKYoNojowmuplHF4f4NjdIdHeEODsWroA=
X-Received: by 2002:a17:906:fd84:b0:99b:d178:f059 with SMTP id
 xa4-20020a170906fd8400b0099bd178f059mr2223557ejb.35.1692208073931; Wed, 16
 Aug 2023 10:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAPnjgZ0vPwd9v+V8Pg5Bo87OELD-vokB7ZrvU3Bv5dQ_O9z6Sg@mail.gmail.com>
 <877cpusybz.fsf@meer.lwn.net>
In-Reply-To: <877cpusybz.fsf@meer.lwn.net>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 16 Aug 2023 11:47:42 -0600
Message-ID: <CAPnjgZ3Lo4Na7YeKPFaY30bwsv_gBGapN_DXeab+k7yhCF3uww@mail.gmail.com>
Subject: Re: Doc style for method functions
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Jonathan,

On Wed, 16 Aug 2023 at 11:15, Jonathan Corbet <corbet@lwn.net> wrote:
>
> Simon Glass <sjg@chromium.org> writes:
>
> > Hi Jonathan,
> >
> > I would like to do something like this:
> >
> > struct part_driver {
> >    /**
> >     * get_info() - Get information about a partition
> >
> >               ^ causes error
> >
> >     *
> >     * @desc: Block device descriptor
> >     * @part: Partition number (1 = first)
> >     * @info: Returns partition information
> >     */
> >    int (*get_info)(struct blk_desc *desc, int part, struct
> > disk_partition *info);
> > ...
> > };
> >
> > But this gives:
> >
> > scripts/kernel-doc:292:
> >    print STDERR "Incorrect use of kernel-doc format: $_";
> >
> > Without the brackets on get_info() it works OK. What is the purpose of
> > that check, please?
>
> That's how the kerneldoc syntax was defined, well before my time as the
> maintainer.  This could be relaxed, I guess, but one would have to look
> at the parsing code to be sure that the right thing happens all the way
> through the process.  I'm not entirely sure it's worth it...

I see. It is inconsistent, since we use () after normal functions.

I think I can fix it just by removing that check.

Regards,
Simon
