Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8DC5FF886F
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 12:16:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AA9283EF9;
	Mon,  4 May 2026 14:16:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DyqBaJUa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5340D84669; Mon,  4 May 2026 14:16:30 +0200 (CEST)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EE4F8466B
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 14:16:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c7ffe8eeaf2so880120a12.0
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 05:16:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777896986; cv=none;
 d=google.com; s=arc-20240605;
 b=Pd13ydNLbJJp1uaX/AgFtV7QXLq2UZt6gigwAHBT/k5AW2uqP48Hjzh533lxPIIJ+w
 o6791kqZVNXyj0ZHZVX31RNSMeT00PjoRljwVrYF7uweHuZKUEscBokfNF1fDug6uZsQ
 aKPtsJHTduzQV6lknFRuzGtw+8ifpNTV1CEOWF++AKZV00n2q6I1rSBpHj+gP3LTZbrw
 brWGXn6bTJ0vLJ7H+On+NQzSZ/vEM5nycpFse7FX151D9RZ/kwqAYOfHI4n3p2cxFT4A
 eQv/OpVNNovXjiBPbVOS1BMIFlXR30izOv8ZSCfkE9xb3Xp+BzazhmI2tgeohkrZSOw1
 AcSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YcqxN7jKw0P8vtlR08mLDWTUwYfYvjX/i9ohWxhxJAg=;
 fh=ixPjPCx5xgdIUn8LPkrsmUbkXVg64bndNxLiI/trGnw=;
 b=aM+YGWW3gyowMwTiTOv/+MIXp4qDnSleiebvNgYZPZ8LaS3DXILIpf4suHyiPbG5e4
 e92EWghF/3ngSETTO1Sy80BOcpnQ2jRTMtKuXdxDaGpjLspbqmyeBFwl8r+s+7ZpODpU
 LuAYwIGtWTLcWIqH9Kjc6Aahvn83FeVYJveKmUcqKA0TvHJ9lwQPHErXsdyayLFKL9gl
 klN7AkiEt0p77XVQT4UK15fwHbW0YTDvnrnoDv+I1ElwEHFX/p3c+9d2vqk/UQljA/mb
 u/OU7SO63nfMSKcn3ug+PpuQcB7xqf+RU6cHVT78PQjQfAeQbn1vQo2RErOnPTFeiIJ0
 QP/Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777896986; x=1778501786; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YcqxN7jKw0P8vtlR08mLDWTUwYfYvjX/i9ohWxhxJAg=;
 b=DyqBaJUaWYduwgIDqF2ZUNUw7RYTpW7kPpSDqcf2uW+5/gyp5hEIMRDW6qDD5SDgGC
 Fjdl73k/MVNGV+/qw2tN4D/HN1vyUWFNRzqNF0j2G+uEzYn9W0YjuUbkJGsGMdQcywcw
 8WNDH2BpOeCajVVB952bXrn8okrBh9chWM940=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777896986; x=1778501786;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YcqxN7jKw0P8vtlR08mLDWTUwYfYvjX/i9ohWxhxJAg=;
 b=l1+vCzyPPzfAGmMevmbiXBYVSk69ZZPCHZQ2kxv8YJXmIciaaPz+bn+8I0qQW0GfWd
 nMP+ce+LU5TitHSZ6RnkuNrgvYr0ZWrS2b8CVfhBKx2QyA7jVA4H6F9o3V1IMXoKpblB
 /lEcKBMJZrzbyiauihKddad+EWise3pjlitdAImXvCjjtLXkFq2CnUIlO9C1tSvoPE0V
 mYQxUgKW21sz9ez7WlbEHK/GgVetN19m+3ju2LQWj5XS27rP3wlQc3h8Kt91sWL9hcF9
 m0xC0HrhjV3oVniIMR4GsKiaAhhPdZeobzO+XC334rLSl6RuC/rx9PDFLpxqDPlRbdqz
 JQwQ==
X-Gm-Message-State: AOJu0Yz4uvgB28/ZIesCEz9HZH7gPovNZb476vCL+gC4IGAgBjPgDigi
 +Vf2LuZ5iUyS7tj6nU7DZ6ES3a1G2kTTQvMc/q6sv3asYdmxrpAAkHveogkcNk66FlI3TwVIeh0
 67F0b5mmuAD3B3+cRTp1uRYnUhrwQQFzs39ZcL+Rf
X-Gm-Gg: AeBDievxKNmiSKykJTI//yBNvD57WIYKOWM+0b5u3LzFY5dQ7gvD0eWNXQK2KX7vcxq
 l2sxKfAybT3rM25MyGigZgrdBLGd284F0WDaOGqreuWRjRIEXIaBcKg6wdXEL/Sc+qc2ZEWiB2m
 OxLep2qH2M8u4CuAMdqXpazN8jPAdkG+OMThKMRGkTt3laH+a1MvpVu9uUy6BBjZPgPW3LGa41R
 Bw2k1URtxo9qQtFaGhWBOTQ0E4Y+aP2YH5lhg5gnm5yOs2t1SYXZSuELVPSEqfUWFOlS541PA9T
 6gfhFFdPNfr68BrL
X-Received: by 2002:a05:6a20:7350:b0:398:840d:39aa with SMTP id
 adf61e73a8af0-3a7f1bc3644mr9798401637.29.1777896985808; Mon, 04 May 2026
 05:16:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260503-simplefb-memory-region-prop-v1-1-21828b8cf13a@mainlining.org>
In-Reply-To: <20260503-simplefb-memory-region-prop-v1-1-21828b8cf13a@mainlining.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 06:15:39 -0600
X-Gm-Features: AVHnY4I10sZ38Vlj9Sgc5zJaJ1FW-T4apZODNpgMBuBKGaWQAV955-b5v4jG6D0
Message-ID: <CAFLszTj2aBqhwawr1F22kSh+MkY8zreb8RAV-_ZqpZ0ffcS3FQ@mail.gmail.com>
Subject: Re: [PATCH] video: simplefb: Parse memory region from memory-region
 property
To: Aelin Reidel <aelin@mainlining.org>
Cc: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Tom Rini <trini@konsulko.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>
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

On Sun, 3 May 2026 at 23:09, Aelin Reidel <aelin@mainlining.org> wrote:
>
> Linux' simplefb driver allows setting the memory-region property to a
> phandle to a node that describes the memory to be used for the
> framebuffer. If it is present, it will override the "reg" property.
>
> This adds support for parsing the property and prefers it if present.
>
> Signed-off-by: Aelin Reidel <aelin@mainlining.org>
> ---
>  drivers/video/simplefb.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
