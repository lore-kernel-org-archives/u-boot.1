Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 631F1C46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 16:24:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA00B87956;
	Wed, 27 Dec 2023 17:24:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="f6rULp6U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 352D08798B; Wed, 27 Dec 2023 17:24:55 +0100 (CET)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E723C87956
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 17:24:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5cde7afa1d7so1640543a12.1
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 08:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703694291; x=1704299091; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B1x4zZI5pGzVqFXyDVCC8TxiAvZHVtyipf1tG2j75Gc=;
 b=f6rULp6UgniD2lavf1mhXEDCgPjaRkALXQZ4QVCRpH9rOEJLKznX6WSaT0oPHQobo8
 pWlkDADrev+VqfSqqww8L+Ds862nRGAxlj+b8Jh8qMEpWjdXh1rLrJIrA3Zrq20fsllA
 tDgBloYEzQnM12fBEVy7SjJACEt1zMWHhiTWuqEb3sgjCxzOyXEzDrXKKbs7QDwElBJJ
 rFYhFerGP0qMOJ8nYzcOcfHH8FkPwPhD4fBn50YqxPTC3yDgQrN0wR3uzQUQ83kiCwGC
 TGVVtn0vSCFN/9mH+nNWR4H2UboJ3ii3mPvozNy8Z/T18D9PE3gzTU/rCx4/OHzhcjgx
 Ajdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703694291; x=1704299091;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B1x4zZI5pGzVqFXyDVCC8TxiAvZHVtyipf1tG2j75Gc=;
 b=Cw1TemGJNOpJoPj1HiJNhSRFpHc/Jm3GigEOqDna7BPLGv3VL/Kuy2JJrBljKQ6EFl
 We+pa4YhfklLqIhLvVQRWzivE+yUXvAc/WbDKuiKqYzzPHLKuiuRnsOmOY1JOB1MhWUU
 hD87xliPjGqrQ1nRXI6Yuc0ZJhusV1AUYYGZy8xJcG3TsQSmkVP9NbuHVq4t1qaSu8l2
 z20i5D3JnTQEUPqGxNi5uBTIOJ0L7m6N7VTQN2kWXPdIHe092K9ztkdQRKJHPk4Q9JT5
 95hJZp1oyHEcGVquvGYLdUc8xVcvH4Fvk//UGeuNAXdtHNhLlaq48F/V9aydxmjflxTm
 nXAQ==
X-Gm-Message-State: AOJu0YzgCfHQ1A+oDqU10d+Te7jp4+CM1SLj6LM+XTVWLNA5fY1lXq0p
 fuSWam9i76fIDaHKpZqWT80VDovkJSFZ3hgpv81KZIUaEVcCIQ==
X-Google-Smtp-Source: AGHT+IGsvk+Z9EmKhzsH9/ZdXAiTINDFyPH3+2B7ZBc6JWebNgVNcofwLMwRpqRxCZtcascqRDTLUMPeFyv+CE2v3tw=
X-Received: by 2002:a05:6a20:728b:b0:196:3b76:9880 with SMTP id
 o11-20020a056a20728b00b001963b769880mr296469pzk.56.1703694291309; Wed, 27 Dec
 2023 08:24:51 -0800 (PST)
MIME-Version: 1.0
References: <20231222213110.660402-1-raymond.mao@linaro.org>
 <20231222213110.660402-3-raymond.mao@linaro.org>
 <CAFLszTgW9Gqn8RhDN_2DBFJm4ZpLB6eHd07xhQmJQOMiiK59-g@mail.gmail.com>
In-Reply-To: <CAFLszTgW9Gqn8RhDN_2DBFJm4ZpLB6eHd07xhQmJQOMiiK59-g@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 27 Dec 2023 11:24:41 -0500
Message-ID: <CAEfUkUJsUUeKN=z0SNTVH_hrcmu872J5b=wHufyfbx2h_-0YRw@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] bloblist: check bloblist with specified buffer size
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, jwerner@chromium.org, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>, 
 Shiji Yang <yangshiji66@outlook.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Baruch Siach <baruch@tkos.co.il>, Michal Simek <michal.simek@amd.com>,
 Qu Wenruo <wqu@suse.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sean Anderson <sean.anderson@seco.com>
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

On Tue, 26 Dec 2023 at 04:47, Simon Glass <sjg@chromium.org> wrote:

> Hi Raymond,
>
> On Fri, Dec 22, 2023 at 9:31=E2=80=AFPM Raymond Mao <raymond.mao@linaro.o=
rg>
> wrote:
> >
> > Instead of expecting the bloblist total size to be the same as the
> > pre-allocated buffer size, practically we are more interested in
> > whether the pre-allocated buffer size is bigger than the bloblist
> > total size.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> > Changes in v2
> > - New patch file created for v2.
> >
> >  common/bloblist.c | 2 +-
> >  test/bloblist.c   | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/common/bloblist.c b/common/bloblist.c
> > index ba17dd851a..db3fbb20cf 100644
> > --- a/common/bloblist.c
> > +++ b/common/bloblist.c
> > @@ -384,7 +384,7 @@ int bloblist_check(ulong addr, uint size)
>
> Can you please also update the function comment for bloblist_check() ?
>
> Yes. I will update it.

[...]

Regards,
Raymond
