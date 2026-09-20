Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2D1C982DA
	for <u-boot@archiver.kernel.org>; Sun, 20 Sep 2026 15:49:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F2F2440DCC;
	Sun, 20 Sep 2026 15:49:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aSu2lb0v50yp; Sun, 20 Sep 2026 15:49:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org F0F5640AE0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789919340;
	b=FcAY6JGjToelGkHChwYuEk64hcudHD/ewuSmZqTEyoU0yRczHUqV6h0IhINXiJxom9Id
	 VkBQ6NoKW5uo+RSlwttxs16WCOWLr4U11MijiPUEiaBiQW8CYt6hDwVCWkCwg5XeYNFnc
	 rgndEVxKNEzPjlogo3ksYM6MctDik/STyNAhub5w6PGPg7zuJQwYQgVnBdUEDbRn3QIAz
	 xxcPpSCy356vz1VUCzK28r9bktWdIgpwEtTxczj7sMVGQ+ISVP1wDNEIhGA9X4krXWHKc
	 s0kWjaCGs5IHVJK7PQSM3mzcUmHdeY+L/hOyjcdGMhXSHqm2JSPIhUybtefd5un4NNw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789919340;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xdNbJMvHJpJEN5c9vkubVhxfgTff7Xru51K1MvzXBR8=;
	b=Or2NeoS5ViV+HGARsKWSPiaYDFsusL6zOVSVAb/qrU96iSRqygOb174DFnXuZU9JLIR1
	 C/4G4ryOUzrzH9DNucIDhEYdg8bmEQ9+kfgkjGss+fMPeKWIvoj6LzNcQR4tgbpFUo54X
	 yZ4FsTOUBQeBkb339vn7iLFuL1eh7u+YA3sv+8KwYKAZMFM5wvMDDxwAPPb0zCcU59Beg
	 LrTVIbnx5Lu6lEeHO3LB930/KYivJ4vGgNzu41ZM4FFbxgtWvlS5GDCo90LzkNWqjZU9m
	 s/se/NvVLVWnD+Yg9BwYavcqPxP6EhgMk5PNYhLXIyFcW6lx6JJto/jK//bQW9s6/iQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789919340;
	bh=xdNbJMvHJpJEN5c9vkubVhxfgTff7Xru51K1MvzXBR8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MmbxUsJ4e5btOBmsyZHPmRm+vgSLl/NVkxjvJHwVR+NhMJZRAacm/E1PdQwIWLpmw
	 S7cad02DXNWfyNXgvWOR9vZJHVqqSxK7qr9k6P9Rcgj5IcX8yT+ENhr5UK3q9rVfF1
	 gySc4YveCttsxNLNPbzCyD/XEjcl6EY5NMJujCH4I/Q3bI1d5M9Y/ju0FsUddAUl95
	 184YkC4r6nIOtaFNp8Zo0vau/w3xSuq3LKe+P9VPPSeMpBsq2fgnu/WvBuUTti8tHH
	 Uq2WPGPQP4+X5djJIFwDeI+1OqHWFPuF23zy6nd1WXjvkGVy5QHuIt7pijwsEiA3jN
	 sdIYC5j2nOdgg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F0F5640AE0;
	Sun, 20 Sep 2026 15:48:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id ABEE925B
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 10:24:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 91DC94005A
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 10:24:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g0qmDwO1kWu9 for <u-boot@lists.u-boot-project.org>;
 Sun, 20 Sep 2026 10:24:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 28D0440062
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=185.125.188.122
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789899868;
 b=d9v949hoMr0cpINFndrtwX6WuLF9ySppAG9GuWG6poOsmmZUXqazHUMgzNZk6oVxTJyG
 tfyiLiafDzrqlWgMYBBacAnJX8DaFrZgwLhUL2/vCYaVJTQBbgdKweQKh8iFOXgCxz3xD
 tYzg1NBQNAoJqHw0waGMwbojHdY+RvPW1IUUIma04765VMLyslWWszxWkFb+90T+ezL1w
 +IgmNC4NW1NJwUxCNsC/ZgaiLHjlFbReBFe3m0gtRUnEYogrOkwXkt8K0WumqL8IngyHn
 Hy8EuqzqB2Zqd5jcbja9bOx3u7DumXU1NVQEYUWLnFPRpi2wboVt010q1DBoT3qxn/Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789899868;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:MIME-Version:References:In-Reply-To:From:Date:
 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
 Content-Transfer-Encoding;
 bh=xdNbJMvHJpJEN5c9vkubVhxfgTff7Xru51K1MvzXBR8=;
 b=iI2Wm0/mQDeoRtVn9AGYJOXcOMInOWxsV2Zq4s3zJx816RdzxoDiCHzXs8CSO4cn21EY
 Wd5qJg7wUEpFoBU/sC4fEVmFdGYi12PXiSOnW7VLB4RD/Gd1up8rtgz9VYDf7HtDu3H5T
 BpSAv/MW83QMbkF49+n4rxoiU4cKwYjIq9dgoRNMwn7XTPIwkyjEB13ffX43H2FMjAaqg
 D7r13afDom04FCxlr69XqMl1aOIPi4V3zNGuJMS8gCW7uEW29qbyZY2SYtUNCJTdi5wqm
 BoTMfReS54+PLF8mXV7gHTeLhDMyQYEd/AtrO5TBnLAlky9BIsAm9XbSnBkyJNWUJdg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=BuGazDek; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=BuGazDek
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 28D0440062
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 10:24:26 +0000 (UTC)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8E5243F167
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 10:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1789899863;
 bh=xdNbJMvHJpJEN5c9vkubVhxfgTff7Xru51K1MvzXBR8=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=BuGazDekFj+zzVXZB/kFkiWtPv29H6z87I/569YvPdHxu3Masb56wYFi6znKeMFGL
 /Bk2BUOPJkR/yDr3F9o9sMKVp4iX6+9TkalenJ31NFH7rh8SdnpkrKt4mw1b1l1mdq
 fUd0DrmgeRAuMU8nPcJIiHqwwlRsOpk5Mrn+sbIZUFw4tkjPiPykb8+WMSEu8NneHz
 9ekl1Gu+z1N597k1vp3zFayvUQgdAF1uBMVnbFwWYLIQv+wckI45eiAk2IIGoHkFvn
 JREmHG4W92Jb1ZqF7z7uObfW6Xh+h4zzbQO+7KHjClMEBRhd63eRdKRaEGihtdCe/L
 rwCH5kK6Y45Xc2gi96ieNno9RBjuYaHnQBgnXEr2NSCF9jlHcxyaj3If+1EGn+KXkR
 58Kj4CxR9uovCgeTrbiHj8leajQB+Lt50NAIUAH0ox0MUZOMvX4a/rZq0nKTTn1uDy
 zSbyW2uf5enAikWHHHXOsl8COZbaa0xtasCYTTkoIMcMVdzbv9bsisZEm8QpLF/Sh1
 1bXHwGRJ1SBB8qVFpzUGYG3+BtSRR05iq4IvZMoWe52YCgJbaden3ZoG/dEES8fdLL
 hxJJQ6YteL6plYtTLE+PZrkbZmCD4GkhEvarZiLkvfF2df6h2hj8/nefyy6O7d1R2E
 DVWtFZzbl1YexYEXr+QLKLE8=
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-6a5d57a8d51so2760438a12.1
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 03:24:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789899863; cv=none;
 d=google.com; s=arc-20260327;
 b=YsTxK56GN1SiXp0Ijfq7dQN78fR/I/LD60s6BnLAv+CM3me36cfV4JACQ99ij9wsp7
 u5ivnUSo3clqxHwDz4a7b0xiLXfDCWwvcQ3GMH/Opw0H31RHVmm8U8KY+n2xwNC182Ms
 SKPx8lJERbGywGopteRwrkQh1siqOZG4gN98rSsp+VVtvlHpOoMklLsdIZRaOeGuzhLQ
 HoSLyPVRzHzu/y/WPvHrPl5k19gXKQykPcJmrEtV0Bp+Irbhd3h2c3usCM0WIBBwZyGi
 0shzVT4PYFujYDmLytDxHLW1haGGaMvW9lvSy8EkX0OQl/fCzMuk8BVpX2csnOnPqWB6
 HCHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=xdNbJMvHJpJEN5c9vkubVhxfgTff7Xru51K1MvzXBR8=;
 fh=qgasSHWK9ABu1C4X6rYrv/IN0O2UMctworj4pvZ1u7s=;
 b=nVF8QjBvuHh648Y2aIqhSiwRJG2QC7cyGzaJc3/iAM462Rlun3a2aIhfUwIojO01wj
 KRT+8FmgoWaaFUAQkf0HlWy+aDxB3DDlGf1w8+TDRbkKPejHz30gLPIY1UWkDUEuDgMX
 TMmI+jfYibfOxJfiMQURPaaL/1btGAdCwTeWMG8EnjicjQWtL6BM5YjR4v1Z3e+WtMuW
 zbJviNBARskcSqNGGviCaCo3OOTlC31AYvW6PWgatbYa00AIcRnWpu+z316OlGX7Vs5T
 0AEJH8lxdUDYS9YqUGElcMnzsTTpYWXZIntaMC/Xb9fdUYBQFxh8R7zavwU9LrTzUAvr
 P4FQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789899863; x=1790504663;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xdNbJMvHJpJEN5c9vkubVhxfgTff7Xru51K1MvzXBR8=;
 b=fuymbqZY5atmM9CILLecFFTh9pBudMjgd76+2bXDD1tR3yeehFi+8BOMcViN2Y0ADC
 hU7IKvQkM7J6DFuSOpRRmXlb0j25qyWO10oJlTQBboiMW3vPStpcsTlkwQl2CazMPNkX
 fZj7haASvE18GR0YEfElEA79/y4nmmGbwOdK4nzhNLNeX7OIXcPUGEURQ1NTlDdhmN6P
 8GABkDQ7eYb7Yy9FGAS96tFdAquIVaO5ObvmfYlWYTT/+KstyZTIkEZVt5C67PG7tE4t
 JZej5JipAEWJ6YuQo/OGYxPHEFsCBQjGOrHtYCD7IeTXj6f8i5+Phioppx4INF7NyMEB
 dLVQ==
X-Gm-Message-State: AFuF++nhZ1zr9cX3Akliy+1pI4FhtvLQutlsnYxRyp+5VJRpJVo+cEru
 WYE8iTiJqNZlzMc918C5ZnLH+qkDCYLixLKjkdgfy/ZaHWD2UaZ3WVb/oxTfkawwHT53oHCYRgn
 fTGNJE7Q/mKy8zAXNRtDD2C8OeFhQPSGVk6RmjHdu05YeIREDcd6z/e6OTAAQeXeu3Br5nKUiPe
 paCDqXID5Ez+SHC21G7Lou2lyXP0gkGb+vpKFlt46XbNx6gQ3F/qzuVfNw8XxEHusdO0eu1zk=
X-Gm-Gg: AYBFou0L6idIHqAYnkwMouW6hUsl8xzU3l6G5a9g0IR3IMTa7SUJ8PWt8CGJMDosa8G
 rFFuHXa2jeDQSaHV3i6TY2eVJPIacFQo8n2XGLTW8zr8YIT+1Fo8DplBq/XShZJcIjvK4Ujxupg
 ddcNhKciDSMCgkOweUnV63hXx5gJkScq2r+EGr9AmJegg4tkkzgAQRPDIbCg==
X-Received: by 2002:a05:6402:551a:b0:6a6:32fa:cae with SMTP id
 4fb4d7f45d1cf-6aa56514857mr5450610a12.19.1789899863090; 
 Sun, 20 Sep 2026 03:24:23 -0700 (PDT)
X-Received: by 2002:a05:6402:551a:b0:6a6:32fa:cae with SMTP id
 4fb4d7f45d1cf-6aa56514857mr5450602a12.19.1789899862685; Sun, 20 Sep 2026
 03:24:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260912124454.13578-1-aristo.chen@canonical.com>
 <CAFLszThi6tJ+aCJvEkOkf1J3BNjzvKtmEoRETm74bdgS5rCnEQ@mail.gmail.com>
In-Reply-To: <CAFLszThi6tJ+aCJvEkOkf1J3BNjzvKtmEoRETm74bdgS5rCnEQ@mail.gmail.com>
From: Aristo Chen <aristo.chen@canonical.com>
Date: Sun, 20 Sep 2026 18:24:11 +0800
X-Gm-Features: AcwNN1W1WY1fsbHf_t1IVDCTlQ0yFH8PHr8h0Hsdo-xm-0mB9tfndxaw5xu3YRk
Message-ID: <CAA=k7=nQdWtEWmNN+fCinodz3jiZMjMuwiQ8Ui6vL0hZDKe1EQ@mail.gmail.com>
Subject: Re: [v1,0/5] tools: mkimage: support shared image data through the
 image-data property
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 20 Sep 2026 15:48:55 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Simon,

On Sat, Sep 19, 2026 at 4:43=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Aristo,
>
> On 2026-09-12T12:44:46, Aristo Chen <aristo.chen@canonical.com> wrote:
>
> > The 'Shared image data' section of the Flat Image Tree specification [1=
]
> > defines an image-data property [...]
>
> Thanks for the thorough cover letter and the hardware numbers. Also
> for taking this on while I am on a patch holiday :-)
>
> Please add user-facing documentation under doc/usage/fit/ describing
> image-data. A short section (either in multi.rst, since this lands
> most naturally in multi-configuration FITs, or a new file) covering
> what the property means, the resolved form mkimage produces, the
> encrypted-sharing rules and a pointer to the external spec. Right now
> someone trying to shrink a multi-board FIT has no way to discover this
> from the U-Boot docs.
>
> Also we have example files and this feels like a case where a new
> example would help - see doc/usage/fit/

I will fix this in v2

>
> Just to check - patch 4 is closing a validation gap opened by patch 2
> rather than fixing a pre-existing bug, since data-less images did not
> exist before image-data was introduced. Would folding it into patch 2
> make things easier to follow? Either way is fine.

That is the right reading. I kept it separate mainly for review size:
the resolve patch is already the largest change in the series, at 360
added lines, while this is a 45-line edit to a different function, the
region collection in fit_import_data(), with its own reasoning. A
small follow-on patch seemed easier to follow than growing the big one
further. In v2, I will update the commit message to explicitly state that i=
t
completes the validation for the new property rather than fixing a
pre-existing problem. If you would still rather see it folded into the
resolve patch for v2, that is easy to do.

Thanks for the review and for the patch-holiday exception! I will also fix
other concerns you pointed out for patch 2.

>
> Regards,
> Simon

Best regards,
Aristo
