Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83843C30653
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 08:01:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CC54884FB;
	Wed, 26 Jun 2024 10:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b/edPAcK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98253884F6; Wed, 26 Jun 2024 10:00:54 +0200 (CEST)
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com
 [IPv6:2607:f8b0:4864:20::a30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 457CE884EA
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 10:00:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-4ef746cb3a2so1071802e0c.3
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 01:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719388851; x=1719993651; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+FeNyG4XyYDLzwJlk17xBEMOL/MpkCrIfABopEN5/0M=;
 b=b/edPAcK3DIhcSjdYfW1jkNHzB82IOh4kPU9iOc4H2ouk7kWcqieKv+Wh7jFv68Zhs
 lZW9kqLO/TfYdMnrIou3Gnc+8B00r4O3LoSRp7yI+YwWN29OND5fR82wBDelXwL1u4oE
 RaAOwQ+1ptAOpLJ54+MBpUhha0+iUry3hAOhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719388851; x=1719993651;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+FeNyG4XyYDLzwJlk17xBEMOL/MpkCrIfABopEN5/0M=;
 b=JT9CMa6apZUWcEWCbvuFeCqTgmKYdZcRS76MuDdzW3crOrBBGjwjcR64Nh4fbP1F9T
 AEIWALWKOqzOXKSENfl5LPVn1NQl67Z+M5dvAGQYJhrKee1D8SSfOUkhQe7I4MfeYY+q
 0LcoYFU1Z3qkiwC7OSPnUIv9PzBJidjF4+Ay+dAGgjDDiGd/JLeNwVXL+VNPfF4QqSG9
 TtjHj8l4EYKeG/PbuzYXDYYw0NKNecqyQGTnSHimJZNDrpFv0fePcHDyRVtYjcZfyspm
 rCzq8dIFk/ElEGCcYKB3pL9wd28r6cROv3Zm/CNFB4+s6txfobr5m/WAopk3+LuXpeeK
 ynwg==
X-Gm-Message-State: AOJu0Yy64zMxOcKAqJIgMf5zuNE/cyikjqmqko5y7MC0KMZAs2ah5dnG
 b0wwYLXjwpLE+e+2Mda2OIkhoxiEtl+lPtysyF9/YF99ZvJ9UOGUvhKe9ZhP4Q0jssdRn5RBNCw
 u/tyfUr116H4JtTdEtjzFRFmzMKGNqUHWQ6yE
X-Google-Smtp-Source: AGHT+IGK3TXMt/HYnSi7lNjLZtdROj6Y9/4Pfhp+B2+lVrvAAUPGJZWFQk0OFTFsesUm8AH7SR66+tzE/dG+zc43Qbs=
X-Received: by 2002:a05:6122:4592:b0:4d4:21cc:5f4f with SMTP id
 71dfb90a1353d-4ef6a73950emr7276155e0c.11.1719388851051; Wed, 26 Jun 2024
 01:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240624170041.1024-1-bage@debian.org>
In-Reply-To: <20240624170041.1024-1-bage@debian.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 26 Jun 2024 09:00:40 +0100
Message-ID: <CAFLszTg=n1fa8itjbw9t2X7hwjXMr2=o4GaR=5wj27WT1seW3g@mail.gmail.com>
Subject: Re: [PATCH] doc: fit: Make data-size a conditionally mandatory
 property
To: Bastian Germann <bage@debian.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On Mon, 24 Jun 2024 at 20:08, Bastian Germann <bage@debian.org> wrote:
>
> Before 9d0750064e (doc: Move external FIT docs into the main body), the
> FIT property data-size was not a mandatory property and still it is not
> expected to be set alongside the data property.
>
> Move the data-size property to the "Conditionally mandatory property"
> section, where it actually belongs.
>
> Signed-off-by: Bastian Germann <bage@debian.org>
> ---
>  doc/usage/fit/source_file_format.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Can you please add a PR here?

https://github.com/open-source-firmware/flat-image-tree

>
> diff --git a/doc/usage/fit/source_file_format.rst b/doc/usage/fit/source_file_format.rst
> index 7727ab77c5..15990e3ff5 100644
> --- a/doc/usage/fit/source_file_format.rst
> +++ b/doc/usage/fit/source_file_format.rst
> @@ -254,9 +254,6 @@ compression
>      zstd                  zstd compressed
>      ====================  ==================
>
> -data-size
> -    size of the data in bytes
> -
>
>  Conditionally mandatory property
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> @@ -276,6 +273,9 @@ data-position
>      not relative to the loading of the FIT. This is mandatory if external data
>      used with a fixed address.
>
> +data-size
> +    Size of the data in bytes. This is mandatory if external data is used.
> +
>  os
>      OS name, mandatory for types "kernel". Valid OS names are:
>
> --
> 2.45.2
>

Regards,
Simon
