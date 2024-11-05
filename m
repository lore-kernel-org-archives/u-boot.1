Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E567ED3610E
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 19:22:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 790F48917B;
	Tue,  5 Nov 2024 20:21:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hqHyzHs0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18E9388CA2; Tue,  5 Nov 2024 20:21:58 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0DF0891CE
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 20:21:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a86e9db75b9so910264166b.1
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 11:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730834515; x=1731439315; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JO6AUgRzsUa7ENcvy31LU3u5bJnpcBrSj+VDJITuxfk=;
 b=hqHyzHs0Q5syHi/n6xROD1dlIpiY7XoQezlLEiXeRsnYFJUn4WTWpXR4Uc2KVD5T9K
 SeebfQojWDIcHA02k3R9HAermO034Sw5CStHnvuRi5xNvzjo9GxbHA7zxLpC+XfagnSL
 /JjWV7n3e20tuL1YXtY/Ke9LxPqbGxTYVDrnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730834515; x=1731439315;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JO6AUgRzsUa7ENcvy31LU3u5bJnpcBrSj+VDJITuxfk=;
 b=YrBiMpgrUB/gWSh1D63nUOZN8SWqkXDtN9VLqNd84YiN6fRmhxJqzpXUarrRq8B4Bl
 X7Fo3WE0aJOrvBtZdasGJz6PK42HVmiEOZYMbifelQcTl32rc92Ri5bwj5PFdSWq5oPC
 ByEh1wULq/BBF+MjyKcnNXdcKdKtRcPu929Cvq8A765R4/dm81KISlV2Pzjj6GvSEvKs
 snZyPm0AUSrvk2rwP0rc8cgQpmY9d+1U2BfwS0iuKCKxXuvE+cPjU5LuOvcS+vv6MGzo
 l2lOmKZUMLzF0r1kyQ4U11HPE4RxIPUW8M3ONGw4/3TF4M5GuUubnu93cKp/YkfRoaub
 8L5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbwAHNns+ZMBZ1o9X4BR0kysGTB6Saiw8BwjmDnhMRNwJqH9ldtPsQavYUoOXyhzlRfXXXAis=@lists.denx.de
X-Gm-Message-State: AOJu0YxidyW5IgFBYsZaSmLOVQRELvVY0BZ9BeQIeiQjzNtBpkaMFxL7
 6Cak17QDc7NxwnBqU6FO/2e5t5M3IUrLVYLvUz4+7AFBQfcDv9r7FHL4Ntqro8soxcqMu9uCH5t
 13kXnOnLD/AKpqP+CDvdq7KgZ7dUr/SLPEodr
X-Google-Smtp-Source: AGHT+IE9/354PmSNLtBfEZjU9FTCZJ/Pb1kTbA+qAtUeAjerCaDff7El5dr75Nb4LEnyuLiVbX/7YglsyiTc0IvVWWg=
X-Received: by 2002:a17:907:8693:b0:a9a:e6:a031 with SMTP id
 a640c23a62f3a-a9e50ba22d9mr1748140366b.59.1730834515248; Tue, 05 Nov 2024
 11:21:55 -0800 (PST)
MIME-Version: 1.0
References: <20241104133954.840994-1-sjg@chromium.org>
 <20241104133954.840994-5-sjg@chromium.org>
 <FAADE9B2-6D3B-4975-8A5F-F96CADCD1B65@gmx.de>
 <20241104213422.GX3600562@bill-the-cat>
In-Reply-To: <20241104213422.GX3600562@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 5 Nov 2024 12:21:43 -0700
Message-ID: <CAFLszTi1sH0sRyBWG604OsRv7rd67tMq6R-SVGA1X0jfUyed-A@mail.gmail.com>
Subject: Re: [PATCH 4/9] docker: Adjust packages for arm64
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
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

Hi Tom, Heinrich,

On Mon, 4 Nov 2024 at 14:34, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Nov 04, 2024 at 09:58:50PM +0100, Heinrich Schuchardt wrote:
> >
> >
> > Am 4. November 2024 14:39:48 MEZ schrieb Simon Glass <sjg@chromium.org>:
> > >The package names are slightly different for arm64 and we don't seem to
> > >have a linux-image-kvm package. Provide a different set for arm64
> > >
> > >Signed-off-by: Simon Glass <sjg@chromium.org>
> > >---
> > >
> > > tools/docker/Dockerfile | 12 +++++++-----
> > > 1 file changed, 7 insertions(+), 5 deletions(-)
> > >
> > >diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> > >index c9d794082c8..c4c3dc5a901 100644
> > >--- a/tools/docker/Dockerfile
> > >+++ b/tools/docker/Dockerfile
> > >@@ -39,7 +39,12 @@ RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_
> > > RUN wget -O - https://github.com/foss-xtensa/toolchain/releases/download/2020.07/x86_64-2020.07-xtensa-dc233c-elf.tar.gz | tar -C /opt -xz
> > >
> > > # Update and install things from apt now
> > >-RUN apt-get update && apt-get install -y \
> > >+RUN if [ "$TARGETPLATFORM" = "linux/arm64" ]; then \
> >
> > Please, use 'arm64' and not 'linux/arm64' as variable value.
>
> Getting back to your previous comment about documenting these variables,
> I took it that these are NOT free-form but rather what Docker (et al)
> require for proper multi-architecture containering.

Yes, that's my understanding (limited though it is so far)

Regards,
Simon
