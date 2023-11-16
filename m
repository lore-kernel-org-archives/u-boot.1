Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3308C2BB3F
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 02:36:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DEBC87467;
	Thu, 16 Nov 2023 03:35:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Let+C9GK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 854698745A; Thu, 16 Nov 2023 03:35:50 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1376087479
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 03:35:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9e2838bcb5eso48576966b.0
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 18:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700102146; x=1700706946; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qcseZ9PzQJoe3O3NcwCrgCCs2bzvnB7kx6+JjunOXNU=;
 b=Let+C9GKSYLDhX3qM5hJBYx2p30ZzKXlFTRs62ZXsU1ISlTmRqWhL7B6IEXuWogUtB
 iV5QhqeCD1SrUSXxdzX1QOZexJHG3E7BH+yprIwDv4X05jon+Y1h/9oTrWh5le2HGuGq
 27VrbT94e93kKabUs/85oD9Wm7I2G/urvvVvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700102146; x=1700706946;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qcseZ9PzQJoe3O3NcwCrgCCs2bzvnB7kx6+JjunOXNU=;
 b=dxUmOL9jYkYbmajZldOvuETbJnRP7u8/XiyhS8zm6oAkqNvP43UYxY6d56ERGsYH74
 8pPW43dyCG6MAQGJHKHCNGctBNt7nHF4hyvt8MHwOqew6eA9ahnjKeWSAiufcvtzCnp2
 rF21X6m+lPAotcX3pgxAFiK8bEFOjV5X18hTxPbu08EO8jpf5pDN3tTQfW8JNeEL8IyN
 1WlLpm/0fvIAa6mWszBIZE/LpavHBX3EgwBf6AnPfgC91EOzaBiOi9n8UMM7VlyPEysL
 E21D7MpAkgObgW5SnGGDvTFMeStOge3LTM3E6fIbCxYkWJ5S3b5OmKRuvjraWYtEX2rR
 Utjg==
X-Gm-Message-State: AOJu0YwFzzsz0I2jBoFkSjwA2V31BbqsRcG5BYA0MgjuJTSa4LQT/BeV
 htxBeS3USyJZNI+/dOG8fStnaZ3PHY3lEI3jTURSrBs5+yaSruJbrMA=
X-Google-Smtp-Source: AGHT+IGX0UX4gMvhP+Q2r1HCnt7eYl0GJ1Dli0j7irwYde3+1g9yfidW0RfHZAy4RFT0zOalQRI7giaVHBJrZemKicg=
X-Received: by 2002:a17:906:ca5b:b0:9be:30c2:b8ff with SMTP id
 jx27-20020a170906ca5b00b009be30c2b8ffmr10653116ejb.61.1700102146505; Wed, 15
 Nov 2023 18:35:46 -0800 (PST)
MIME-Version: 1.0
References: <20231115183522.1.I4cbfd34d576c0ad66a74c6ec3e8024adabc73573@changeid>
 <ee2def9d-c931-466a-bf78-507887de41c9@gmx.de>
In-Reply-To: <ee2def9d-c931-466a-bf78-507887de41c9@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 15 Nov 2023 19:35:34 -0700
Message-ID: <CAPnjgZ1-tQxSa1sY_f3BsJpPu+9tLkyrvt2vG0nqu=xegyi4mQ@mail.gmail.com>
Subject: Re: [PATCH] bootstd: Avoid freeing a non-allocated buffer
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Shantur Rathore <i@shantur.com>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Heinrich,

On Wed, 15 Nov 2023 at 19:18, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 11/16/23 02:35, Simon Glass wrote:
> > EFI applications can be very large and thus used to cause boot failures
> > when malloc() space was exhausted.
> >
> > A recent changed fixed this by using the kernel_addr_r environment var
> > as the address of the buffer. However, it still frees the buffer when
> > the bootflow is discarded.
> >
> > Fix this by introducing a flag to indicate whether the buffer was
> > allocated, or not.
> >
> > Note that kernel_addr_r is not the last word here. It might be better
> > to use lmb to place images. But there is a lot of refactoring to do
>
> We need a discussion about memory management. We currently have:
>
> * malloc
> * EFI - AllocatePages(), AllocatePool()
> * lmb
> * preassigned addresses like $kernel_addr_r, $fdt_addr_r

Yes indeed. There have been discussions already, but we need to do
this on the ML.

>
> EFI manages memory on page level. It needs to provide a complete memory
> map to the OS with flags for different types of memory. Currently it is
> not aware of where files are loaded and might allocate those regions for
> its own usage.
>
> lmb does not track any allocations but tries to recreate a memory map on
> the fly whenever a file is loaded.
>
> It would be preferable to allocate memory for files and require to
> explicitly unload a file before reusing the same memory area.
>
> We should start a separate thread on this topic.

Indeed. If you start it, I will reply with some thoughts.

The nice thing is that with bootstd we can start to tidy all this up
and make sure it has tests.

>
> > before we can remove the environment variables. The distro scripts rely
> > on them so it is safe for bootstd to do so too.
> >
> > Fixes: 6a8c2f9781c bootstd: Avoid allocating memory for the EFI file
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Reported by: Simon Glass <sjg@chromium.org>
> > Reported by: Shantur Rathore <i@shantur.com>
>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>

[..]

Regards,
Simon
