Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B72C00A8F
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 18:05:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F08D587998;
	Tue, 24 Oct 2023 20:04:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="fLm6oMnt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99EFC87967; Tue, 24 Oct 2023 20:04:23 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48A6A8799B
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 20:04:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5a90d6ab962so36544527b3.2
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 11:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1698170659; x=1698775459; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gsBuwVocoOl2mRapch5QnQ+wlUNgWqtFQchYMQPg1mk=;
 b=fLm6oMntJYenU5oGGtw0QDdZWxo7mP0GEiiqFZUUFFLKYFkVRo6h/lWL2igt+kupwn
 pMK6C6xxWT3jxdIeBHNAhzJWLg+t+20qkxDqqpS3JCzATjpz8tRh1oj2qruGTS9BWA5j
 WJWftL5+a0hCkTMN5SO/t8hKC0lKKyrx1p+lL2MZXL2+yXgEwXVyYC+Cpjxbf5y6JH/8
 FWLzXnzEd8ob4fcw7GtU3pBZlKCC300+BYTijIo0hFMGBaAroSet+yva5Jc8z7dwPigr
 r5DfVV1cKT6wW6ME0adFa5/ku4hr4gzOZT9Pl9xhysLVYvh/8dFoOx/+fEyuNugrhkfZ
 ybvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698170659; x=1698775459;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gsBuwVocoOl2mRapch5QnQ+wlUNgWqtFQchYMQPg1mk=;
 b=OYU8MCkeFJHma0S3KhfxGOaUFCsIE7PsbEHSXxMWc3PJWQvmGPwOj3aiL8OF3NRGp6
 sVqSDN+YiuCLZOn5cnM/jCuNhqhkUdBhmxjKyL8szPdC+qdnR3+EZZ+2UFrlzuNVipSO
 ic+xar3BQqdFSRPziIY85k6w3nlASe4cnF61WjcJR162Zhr8r7rzBovSYYbjBA0uWfs1
 octPLbMBpzYVNEzr+b4Y94JeClnfvV4JfOfuI5EqYi28qAdIjDkZP4QfJAW2t8rev154
 t0v4a5Sxqp+cf6Idx1nhle7+uKBGhrsD98NXZFkGhHtWSRNAEVZFmE/V0x/AHyavu2Mu
 pMBA==
X-Gm-Message-State: AOJu0Yx6eRQDj2O3d9nj89eEm6AiFl+aH2wDx6W4sK92U18uIvJudf07
 6iSEHAybbENvYrp/lk0nn+q4OV9XTPuMdRtsDb4lGg4M9617kM5Gr20ISD9e
X-Google-Smtp-Source: AGHT+IF8NB/oI0QOZn447ufAbZcXxAW7Wc7aypkhEU1z6Wlfszjz5LdIhjMdx29Iul5vZRgWv//YKKPOLP3Mlb5tWG8=
X-Received: by 2002:a0d:d6d7:0:b0:5a7:bb95:681c with SMTP id
 y206-20020a0dd6d7000000b005a7bb95681cmr16494206ywd.36.1698170658996; Tue, 24
 Oct 2023 11:04:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231024115915.16565-1-tom@tom-fitzhenry.me.uk>
In-Reply-To: <20231024115915.16565-1-tom@tom-fitzhenry.me.uk>
From: Simon Glass <sjg@google.com>
Date: Tue, 24 Oct 2023 11:03:16 -0700
Message-ID: <CAPnjgZ3iV7H3Nkw8gfTAFcM7QGixBzZxg0=nNORZVL7U34d1gg@mail.gmail.com>
Subject: Re: [PATCH] doc: gpt: fix example of echoing variable
To: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Cc: u-boot@lists.denx.de
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

On Tue, 24 Oct 2023 at 05:00, Tom Fitzhenry <tom@tom-fitzhenry.me.uk> wrote:
>
> ---
>  doc/usage/cmd/gpt.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

It could use 'print' instead, I suppose.


> diff --git a/doc/usage/cmd/gpt.rst b/doc/usage/cmd/gpt.rst
> index f6115ecb0ee..ea43218fa21 100644
> --- a/doc/usage/cmd/gpt.rst
> +++ b/doc/usage/cmd/gpt.rst
> @@ -192,7 +192,7 @@ Get the information about the partition named 'rootfs'::
>  Get the list of partition names on the disk::
>
>      => gpt enumerate
> -    => echo gpt_partition_list
> +    => echo ${gpt_partition_list}
>      boot rootfs system-data [ext] user modules ramdisk
>
>
> --
> 2.42.0
>
