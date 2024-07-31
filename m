Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24108C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 07:26:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 802DE88934;
	Wed, 31 Jul 2024 09:26:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Giwr2e5G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19F3288969; Wed, 31 Jul 2024 09:26:13 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 061B088886
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 09:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5a3b866ebc9so7494136a12.3
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 00:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722410770; x=1723015570; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MoLH43Gj875qxiJucIdsVf9IjKJwm/jw3TGs51pS/Sg=;
 b=Giwr2e5Gc5kNjQYpTuH8ErGJNilol1lnejvlgOLiNX2w6pQzbB5bDk/NJKLK7V/bpl
 vaSRvERlfqKFBoIxfAfrC5x0M4SJg3HXz3SediSfuLgHrh1+TCA1Jk4tqFwLIJJd+9u8
 sA4UwZ4MqAAGgGiXzyRza7eUnOUAA4Bxj0BGaOLrqyYw53hDura94Pd8QAYkxVDIYSZ0
 SFfQGIp8VQ6D1j9qYiAjr3q2L9fSBaqj1gSWELbQa3vVE1MhiKIWFHaSnzKGc30CSKeF
 rnpd1pz9UXgrqrkYbbBSjKqnnGxokdqBz3umyLF+FX7vySYDhKMvraUUdLs6mKIkMZYi
 s4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722410770; x=1723015570;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MoLH43Gj875qxiJucIdsVf9IjKJwm/jw3TGs51pS/Sg=;
 b=tbcHIwoFm+sgNqlttGy9amLhS0yA93A5hkk2AAxclr/Nr7NT+x+GYW27YNn6FCJ09C
 maFEIDwb7K+RbkR9ZMi3V4/hFKEeGPQcJyAqe/npQks7tuY75qruXslu6wm2/KF3yPiW
 YQ8u+WLGMkHc8OhejfASvdUVcRsRaAgWV0GW59IadMyVEILpV/G7kAGjCMo2W5pFCEpC
 Jh6oGt8XCOz8iYNfkvYHs1vL8XiVC7XbRhnFBtCM6t0vROBo1k/ajWObsINKsaaRd70I
 2smdIMgYhiUKi9j3aEtJTtzNuJZVoMBVDOSU5A/lgwOc79pflgcoSBlwHq831Acmy7Ca
 h13A==
X-Gm-Message-State: AOJu0YzI7aab81CmHHEzahZiRwbHvaXpOuSTNK9h1gqOIBASjgFzvWyR
 voxzXeTACAcf/DT4ZDsxMxqDdAAhkdj79iR/DzLeewAKFCZXKQcLZeGxR7o9I2WAFl+Wmusu5Us
 VXWSA+jCGX9cMaq70nfA1QcHaBnS+FEF61GceKrHkOGOL11dq
X-Google-Smtp-Source: AGHT+IEkueYp7+e0IqLeFNP2DABeCozXTh1axMBjgHYudgjGFG8SvMX4BGHrZ43B9wYDQS+K1q602xA9eab5fLchYME=
X-Received: by 2002:a50:d615:0:b0:5a1:7362:91d9 with SMTP id
 4fb4d7f45d1cf-5b020bbde56mr7282925a12.22.1722410770278; Wed, 31 Jul 2024
 00:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-34-sughosh.ganu@linaro.org>
 <CAFLszTg1nywmyXRJ2Dgsg97Mfbps7P37jDD72dNafo0wHF3RZQ@mail.gmail.com>
 <CADg8p97S84J7wrEchCfP-Y7L8qdC4F=koyuhzV0+jYxiM=YhRg@mail.gmail.com>
 <CAFLszThRiRLXE2Nz7CM4_tDCM6=6d1v4snsDfYBCnvPnoXVPYg@mail.gmail.com>
In-Reply-To: <CAFLszThRiRLXE2Nz7CM4_tDCM6=6d1v4snsDfYBCnvPnoXVPYg@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 31 Jul 2024 12:55:59 +0530
Message-ID: <CADg8p96UnUpeV51Dsr82rKs6vz-9TPBmoz6HTq+i4G0me6MR8w@mail.gmail.com>
Subject: Re: [PATCH 33/40] test: cedit: use allocated address for reading file
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

On Mon, 29 Jul 2024 at 20:58, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Mon, 29 Jul 2024 at 02:53, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > On Fri, 26 Jul 2024 at 05:02, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Sughosh,
> > >
> > > On Wed, 24 Jul 2024 at 00:05, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > >
> > > > Instead of a randomly selected address, use an LMB allocated one for
> > > > reading the file into memory. With the LMB map now being persistent
> > > > and global, the address used for reading the file might be already
> > > > allocated as non-overwritable, resulting in a failure. Get a valid
> > > > address from LMB and then read the file to that address.
> > > >
> > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > ---
> > > > Changes since rfc: None
> > > >
> > > >  test/boot/cedit.c | 6 +++++-
> > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > >
> > >
> > > No, we should not start putting lmb into tests like this.
> >
> > The test fails if the address is not allocated through an lmb api.
> > Although I can check why.
>
> Neither am I, but you did put the tcg in the same region so perhaps
> that is an issue?

I now remember the issue. The cedit_fdt() function uses a random
address(0x1000) and tries to load the settings.dtb file to the
address. The load command uses the lmb_alloc_addr() API function to
reserve and use this address for loading the file. This worked earlier
because of the local nature of the lmb memory map. But it does not
work anymore, as this clashes with some existing reservation resulting
in the test failure.  So this change is very much needed.

-sughosh

>
> Sandbox is designed so that low memory regions can be used in tests. I
> pointed you to the memory-map docs.
>
> Regards,
> SImon
