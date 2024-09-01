Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82107C54FC6
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 20:10:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02D1D88A13;
	Sun,  1 Sep 2024 22:09:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ec6EuFn1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E40788916; Sun,  1 Sep 2024 22:09:56 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4FCA88637
 for <u-boot@lists.denx.de>; Sun,  1 Sep 2024 22:09:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-70f6118f1b5so2315543a34.0
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 13:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725221392; x=1725826192; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=geXMy7FYkFaN1lJDrxxbGC9UV5YlHMANGcIwlgKhB90=;
 b=Ec6EuFn1GhidAPJLy5qznyRcPQHIbaGhuFw5EUOD+l9GWTXZF+JAGS/eSIn0b3R/NV
 rTMIyo3hjh9u79i705kp70C6GQcaZsu0GxQL7f5yVbbyjHwdsAyZ6AeTo2ooif2mMo8Q
 JFVWn/AdTZ3Q3mHVQ8BMzPDUzTRF1hH6ExOjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725221392; x=1725826192;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=geXMy7FYkFaN1lJDrxxbGC9UV5YlHMANGcIwlgKhB90=;
 b=i6YnDDEDR2B5qnwGv/WPbNrjmcDPlddZwSA1OPR86r7zqHnTYS0IFchO5ooWLaw5jB
 KpnxW/4Prcl4Thh2XXhDHRNztodHqZZRJdmVnJI9w6yw91TWM+EbqCQPQSvc4yRf/JD3
 KJZmVe4dvjDi8gOENz1dOBjd4xjnNxkWj4QHHgHYbmIXskeCpANkv2yoCi5qxaa0bzuH
 2LgVSDf3rZXi/IY6RIlprfzlNBFeTuArnc+F/nctIixSdvc9/SislbgqBmsBbYE8J6OF
 INXq43FHlNJUhFlejw5DiTaDAl0gHqPXgiDUlB6/GgLnr2xW40UPeBOrCKgc+xiKV1AA
 ydLA==
X-Gm-Message-State: AOJu0Yy/thGAkj8dW9cW3bScA7gDuq/3NbuT0bZ/Yc93ONNtwvtbP75z
 SFiHEQqIK9mJzhI43yDJF0G+NRbQh53sdytAqV3f/mnxnr71sX1maysLK6dPtShd0oyCyqfxhh2
 A4JWu1LIIELt5liM1TL5ZJNYXDb0HRZkzkBgR
X-Google-Smtp-Source: AGHT+IGT2TL8unLqql4cPgTnoek8zdqGORLpm9dpcpKS5nqPkXkT6PNJLMzewQ2OKiE8onq2n72fvy/Ni+APZyaC5uM=
X-Received: by 2002:a05:6830:600e:b0:709:3839:b7d2 with SMTP id
 46e09a7af769-70f5c42b04bmr14814126a34.31.1725221392482; Sun, 01 Sep 2024
 13:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240831031706.2654697-1-daniel@0x0f.com>
In-Reply-To: <20240831031706.2654697-1-daniel@0x0f.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Sep 2024 14:09:41 -0600
Message-ID: <CAFLszTj2h9tvUEWjO1nqwQ1gmNvvUV1t6ewJv4qgbRfoupaeRQ@mail.gmail.com>
Subject: Re: [PATCH] spl: spl_load: fix comparison between negative error code
 and unsigned size
To: Daniel Palmer <daniel@0x0f.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com
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

Hi Daniel,

On Fri, 30 Aug 2024 at 21:17, Daniel Palmer <daniel@0x0f.com> wrote:
>
> read could be a negative error value but size in spl_image is unsigned
> so when they are compared read is used as if it's a unsigned value
> and if it's negative it'll most likely be bigger than size and the
> result will be true and _spl_load() will return 0 to the caller.
>
> This results in the caller to _spl_load() not seeing that an error happened
> as it should and continuing as if the load was completed when it might
> not have been.
>
> Check if read is negative and return it's value if it is before comparing
> against size in spl_image.
>
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>  include/spl_load.h | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/include/spl_load.h b/include/spl_load.h
> index 1c2b296c0a2c..7de834f402b8 100644
> --- a/include/spl_load.h
> +++ b/include/spl_load.h
> @@ -83,6 +83,10 @@ static inline int _spl_load(struct spl_image_info *spl_image,
>
>         read = info->read(info, offset + image_offset, size,
>                           map_sysmem(spl_image->load_addr - overhead, size));
> +
> +       if (read < 0)
> +               return read;
> +
>         return read < spl_image->size ? -EIO : 0;
>  }
>
> --
> 2.43.0
>
