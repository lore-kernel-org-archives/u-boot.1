Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC66BC3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 08:53:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EAD588747;
	Mon, 29 Jul 2024 10:53:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vVISI44K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75C5288747; Mon, 29 Jul 2024 10:53:17 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C022188276
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 10:53:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5a156556fb4so5261780a12.3
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 01:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722243194; x=1722847994; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=22/Rv+NalUdh8baDvv/3mTcrI7sCBXr8YPzVL/319vA=;
 b=vVISI44KBcKmCp8fHpnomfiR9rxGnrlYH85cQ/MbQdFjMLZG1sgLXA0fsls/B+nIrP
 El82j9jLtOBS34uzzTo0Yf/ViWGTyLIXn3FypCVeX4GkuDaD7YlDsEW/WIFfSwVrfcL5
 m998gGhkDinjRHPBJ5RI84heFWzoGDd3p62rupdytH4ruUJ6JlfTlEOzU/VwfOLjsW0i
 lIfoddG6oLilR6XqnwItE6foexxNPCSUYoMbWVCCm26h0jS/ZeMOvl5WcQI2TPnFARGE
 9qZwaGU1APTl4O6/6DGkZjbJRV3ou4EjWB0y8kc4xrXECILx+Wj10apgjy+sKuRJUivm
 JcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722243194; x=1722847994;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=22/Rv+NalUdh8baDvv/3mTcrI7sCBXr8YPzVL/319vA=;
 b=qAyFxTfxVnBvb1XL/SESDTG6FOwzC8SDhlnk2P03LBRfhYnfQPr9Y+kwe8WFPCp8xt
 eNK3ecNZ6XbflB6k4oUArsSZ/t6JpMbeAnFtMWlX7O5wU7GE8X60F7If2XWM+YkQ71lV
 MLwY6DLvI+qU6Bpl8EreMPYF4EbHMSKYQ/gnAFiYgVFUWKd+sO5HaTqgltlX+mbZ/PKi
 gImSfDjytJXZcCerchX27c83mSMLFCnuKAqt5PVoLACj7/Aexs/uZMHO2wJK3alV2Z/d
 kmiSzPTv9u/Z0FGwmoL7S8HIASewFb206I3a+CR4EPqWdVa6bgqEGbeBFMOROn9yqEJ2
 /Dbw==
X-Gm-Message-State: AOJu0YyUDiRCfhKcVNvz05DnSn1SC6mH0D4/f044IiivFfGpt9xsCc3T
 jzXRCHonCNdij32bkWw6Ze95tJ8AlaSb7B2Ce/ma0JYTJICFyMc1ID6d9BVEFKGnnKxdnq6kCE1
 nZVUXrWyFxSOXjmtRiwMBUXb4hAdqOcXbxy/BOA==
X-Google-Smtp-Source: AGHT+IFUgIp7r0GRiTlIxwKoTmBXg/wQUrnlNc/hM0vfGW/JMGx1G33fQbPhTG0fEK5aqBDv37ixSs6wGRjngt5mv38=
X-Received: by 2002:a05:6402:40c2:b0:5a2:c1b1:4cc with SMTP id
 4fb4d7f45d1cf-5b022003c70mr4867786a12.26.1722243194174; Mon, 29 Jul 2024
 01:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-34-sughosh.ganu@linaro.org>
 <CAFLszTg1nywmyXRJ2Dgsg97Mfbps7P37jDD72dNafo0wHF3RZQ@mail.gmail.com>
In-Reply-To: <CAFLszTg1nywmyXRJ2Dgsg97Mfbps7P37jDD72dNafo0wHF3RZQ@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 29 Jul 2024 14:23:03 +0530
Message-ID: <CADg8p97S84J7wrEchCfP-Y7L8qdC4F=koyuhzV0+jYxiM=YhRg@mail.gmail.com>
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

On Fri, 26 Jul 2024 at 05:02, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Wed, 24 Jul 2024 at 00:05, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > Instead of a randomly selected address, use an LMB allocated one for
> > reading the file into memory. With the LMB map now being persistent
> > and global, the address used for reading the file might be already
> > allocated as non-overwritable, resulting in a failure. Get a valid
> > address from LMB and then read the file to that address.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since rfc: None
> >
> >  test/boot/cedit.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
>
> No, we should not start putting lmb into tests like this.

The test fails if the address is not allocated through an lmb api.
Although I can check why.

-sughosh

>
> Regards,
> Simon
