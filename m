Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB45C54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 06:18:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79B9287FB6;
	Wed, 27 Mar 2024 07:18:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="t+5ApLy6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D92988803B; Wed, 27 Mar 2024 07:18:24 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC73187FAC
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 07:18:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-dcc71031680so5732339276.2
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 23:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711520301; x=1712125101; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=D97LS1Acl0CgQOB50OGnQo9PVejOodaoUpvQxdyGtZQ=;
 b=t+5ApLy6vBslHx/Q40YR8YejLXnIWsr/xlZ3OsbRCIUGCnAA2AO5sNtcguK9qW/t6v
 aoG4veYmLs4UgAtskF5ILdlrbfIGzhCUVCoKcCulX1MO5qZfc7QnCfTOo81Numlv65fW
 cuqtT57ILkY4s397Vwxfm07foSA/JmdQ2Wn/wa3inmtdmCIwosin6OZKM9xVy0kRYw+S
 xzFq2zq7JhiSFZ4jwdNzgkOX/FeeQlueKd09btFUbyuIZCpxPBpFyXfwGuYzsV/9GZwa
 SbtyPrc1I3SVss5CShjSjZTKpTct3JD1wBvrpn2olDb6YuUFqUqkKAC9eDxAGoFJx52D
 V8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711520301; x=1712125101;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D97LS1Acl0CgQOB50OGnQo9PVejOodaoUpvQxdyGtZQ=;
 b=qsDGluYaX8T/96Bpbz/Sld80+dK7cmd+a+/qvlJN9yqGdMZr21N91VRbTU5KWy2fw9
 b5e9s+QyxEtt35FGgYZBdStotCykGnFzFSS5hbnSw+u+r0vNPzzwhksCQjaBPyvFoF25
 k6UOuO71fR/rpbtfuM5JAxwp5DaUEAqFoFfupH0nXrdynhk3twsHEEz3nz9Z6B6+uwql
 KbmlmlmDOKp4i4cK4rYk+S1pPkRK5tdmehm4VXwio8P9JkYxRyzz/5ccfSmihzaVqcLK
 8807dr/sxPYrQOg5wcA6+IbDC9K8UZQmfUZF6z2XzU1+Gb/mAZWE3iycjQz4pqTN2iSY
 ljMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3uw7bYypd5WS3i58ImQdzk3eMRA7mRIr6DPvNIyFcnRXGWHJ0bDyTnhzHMEMMR4vJAV6kt7Zzjdi1ccXhqcUG7LXkyg==
X-Gm-Message-State: AOJu0YzEy3gDXImaAL/nRmrbkRup0EIE3rC/kjN0uPXwwruS0EqfFKaU
 wZwnj0eP7m/j3Qi11Y9BhaTs8E15p1KuWSrFZiCjElsI+jKdWUndR5YtkiPo7yVBH7llNfla1NG
 deBxBk+FJoN5oLnyidZcdXmRKV0BEp2Oa9IN4XQ==
X-Google-Smtp-Source: AGHT+IHPcCK6Kgdpgb/xXD06UytHWZJJapk5cGSCA9jl2K8hXPo9CJiU0DVjOHb2cEFPpkuT24G6ZlK8qIJbxDpDIgs=
X-Received: by 2002:a25:c548:0:b0:dc7:4cb1:6817 with SMTP id
 v69-20020a25c548000000b00dc74cb16817mr1849308ybe.22.1711520301446; Tue, 26
 Mar 2024 23:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <e821d722df61654ed64798cfa698e8e915a30764.camel@gmail.com>
 <CAPnjgZ3xUzbs0MGJybA2xg_AQ=nshQjD+rCL=gVAj81UMetgzg@mail.gmail.com>
 <20230710201339.GZ148062@bill-the-cat>
 <CAPnjgZ3539F3s_oN4GE8r4CH4B67BSF=7JkN_fFmwxYEPyP8Lw@mail.gmail.com>
 <8fa4eead45bf25f5fa4611c71e68d21a94b094a7.camel@gmail.com>
 <CAPnjgZ3zWV-JZ=B9rXtS7+XsCxZ1ML8m2Xmz5byD79F9jb090Q@mail.gmail.com>
In-Reply-To: <CAPnjgZ3zWV-JZ=B9rXtS7+XsCxZ1ML8m2Xmz5byD79F9jb090Q@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Wed, 27 Mar 2024 01:18:10 -0500
Message-ID: <CAPLW+4mDY-cD+CvnpKskb-4JNzQ2dweRREFt6Ks+azYjQPeRLQ@mail.gmail.com>
Subject: Re: [BUG] fdt_pack_reg in common/fdt_support.c can cause crash from
 unaligned access
To: Simon Glass <sjg@google.com>, David Virag <virag.david003@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

[snip]

>
> So I suspect the answer might be that we have a problem here, on ARM.
>
> One solution might be to add a helper like put_unaligned_be64() which
> uses a CONFIG to indicate whether 32-bit-aligned 64-bit read/write is
> supported, and either just does the write, or calls
> put_unaligned_be64().
>
> Another option might be to adjust fdt_pack_reg() to write the cells
> one at a time.
>

Hi Simon, David,

Just stumbled upon the same issue on E850-96 board when trying to boot
the kernel using `bootm' command. It's an ARM64 board (Exynos850 SoC).
Did you by chance find any solution to this? Looks to me it actually
needs some sort of fix. I wonder why more people don't see this error
on other ARM64 board. Anyways, would be happy to help out fixing it,
so please let me know if you have any advice on this.

Thanks!

> Regards,
> Simon
