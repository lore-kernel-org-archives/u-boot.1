Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB20E9A049
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 13:09:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4507683936;
	Thu, 19 Feb 2026 14:09:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hhwMYzDo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C05F783A47; Thu, 19 Feb 2026 14:09:28 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EF978366F
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 14:09:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-65baa72399fso1198826a12.0
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 05:09:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771506565; cv=none;
 d=google.com; s=arc-20240605;
 b=aIBd0eS9VytvBiPfGwSTtvF9a3WH6UBJxhKt4pVt09c2InO9Auc8u18neFL4buAMOO
 ae+W1RSRAz0yaux2+8uxYdF+054+pgq3AiDynawfIRg8DiLu2xlEPk3HZkDS+OtPcktb
 g/fVpiLucefA5fToYpyx1o43cbq4sM+jnw2ACC8gCADzFtSKkdz+8LbbsCaYxkYSfVUz
 o7Fs2ypxeQ+eIvqsXJSizbDtUKpsJ2AZJRlFkRq8/uQKfRlVt3NZuF5aIixJORUBj2RP
 w216LmTAUXlUdCeWZc8iocfLBivEH/GP905UwnTj6AEG+kp7FD3tfV3SgT7GCs6kirAD
 5u9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tUrZ1aMXxImC86esPuoKqGC0Vwppm9va0Lync2byJzs=;
 fh=ed0Ie8kN2ZRpM9JpRUh2QtwLMXwIkJzbEqpXUxMla1Q=;
 b=U6Z7yqLmp7A+qOQy1lFzp8+0HquxP3E6QucyqOFrSmRcO57ewS/29DT/ozgf3Ge94R
 +hgDk77eENHGm0LEhXUtQ6nukHkTOfBg6ux6OGtP13tcPcJISCqAUV7oLIv4INOfiLcK
 Gy1oT0nt2SQPQUUUn2pvN3YzP+P/k35z/W4vtyPt9NdShlfcLA+8FlLUk47L1Vfllja4
 qdJJZA9dbjKHWg16KftBeRq+T+wpzYezraZoHKlxyy/OL8c5VF9aLbuYv5/BdjOTLTdd
 kazAq47ZWj0mq8FR484XcQGmYjvHMDe1+XUWSaBcpdqlnEijd8658iTMv0SvaCq+1Rra
 8YVg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771506565; x=1772111365; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tUrZ1aMXxImC86esPuoKqGC0Vwppm9va0Lync2byJzs=;
 b=hhwMYzDoOZByZFCx1pCKJXRLOELP0TqK6w8C3EGFjfi9fn8uBNRevTJ3QPRfefBXuH
 SzbWyUbITVNUebfpRa9q377l85gR+0SXBXEbKU5u6rTe+LV0+L5b8Q9VV3atYK5n3uNA
 hOPbmB1ycpyYsdlECGsDfmpBDBdkcEb046jfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771506565; x=1772111365;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tUrZ1aMXxImC86esPuoKqGC0Vwppm9va0Lync2byJzs=;
 b=uHdIpEMbK+wG2fRfPE/gtN+2wuiiM1qaFl1WpK4gtIY92ABHY/+fZ4YaJFVRie/8Jz
 enjFeikH9i/PGTm6KYmZ5Yj95C3q4p7IbQe17aW5rz/ZnhtjIRIkm70Z+hIZ0EKS/TjA
 PoCupo8WV/t27twWBpzCpaj/W2k15IlMuH3/qGRqH5seeFB1Q0DdxneFSOTq6fGHuIGG
 StAukqc6p/xjf+zalqElVVc1MDOMfYK5BgG2qyPLpP9/nMZgIPaNIkfbyxjSEaFdeYpp
 RgsXZE4ccEecbHF1Wu+AFP27tCrWV6FXEtHehZWVy5T6Qo3Y5mYrQuXDEst8MBXkjSZl
 yorg==
X-Gm-Message-State: AOJu0YyoB+kd9fyNlxAh5l+96zqTwyQOnz9MBbAEOZIaORziOPF4gqXe
 idvbtBVsByPC78EwkVEk42PiHJU1uf67ddk9cbT7c4w/Wnq1ZZjXSpJHdDN8tT4QRLgqnSACyfM
 u8lUlYWSbKmhJIQJNhHduK1Bt3srvc7UtFrem3EtuSCIcC44e46o=
X-Gm-Gg: AZuq6aKG/qLocFYBzc9RDTWxgsuli72rOD+O9TArFLsawysc986QyZJkLjVR2PFWXph
 kMI6ycdAHPg0K0sZHJLmf8qHfOE6FzUa73nZkBzJyYrPJc8L21sVHZD+75SLLkMiJ6RzM4n2yiE
 V9mLTYoAYZ3pVF/uWH/9HRtARF8usscgfCrMjh7jkPddr6/NnL/p2uDJla4kMgy6wzYT3cJIzuO
 95tNwzbRyxKsXBBCugXcGF7Bg+CUeev9WmRQn96p+8DRnWtjT8Bh56ehjluZ78IsK6k/HG8MSVB
 SyXAow==
X-Received: by 2002:a05:6402:399c:b0:65b:f5fa:afdd with SMTP id
 4fb4d7f45d1cf-65bf5fab2dcmr5969878a12.5.1771506565368; Thu, 19 Feb 2026
 05:09:25 -0800 (PST)
MIME-Version: 1.0
References: <20260219003351.388722-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260219003351.388722-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Feb 2026 06:09:12 -0700
X-Gm-Features: AaiRm51glp3jVbfs2lECmbuk2NSCjpxGgkxAMUwYv8zAkPrOteLcGD6i_SyplK0
Message-ID: <CAFLszTj42WZF3DTOt4HxskNW3qyZJ5_pQ66RsBNdbr13rXTFeg@mail.gmail.com>
Subject: Re: [PATCH v2] gunzip: Implement chunked decompression
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Alexander Graf <agraf@csgraf.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome@forissier.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
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

Hi Marek,

On Wed, 18 Feb 2026 at 17:34, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> The current gzwrite() implementation is limited to 4 GiB compressed
> input buffer size due to struct z_stream_s { uInt avail_in } member,
> which is of type unsigned int. Current gzwrite() implementation sets
> the entire input buffer size as avail_in and performs decompression
> of the whole compressed input buffer in one round, which limits the
> size of input buffer to 4 GiB.
>
> Rework the decompression loop to use chunked approach, and decompress
> the input buffer in up to 4 GiB - 1 kiB avail_in chunks, possibly in
> multiple decompression rounds. This way, the compressed input buffer
> size is limited by gzwrite() function 'len' parameter type, which is
> unsigned long.
>
> In case of sandbox build, include parsing of 'gzwrite_chunk'
> environment variable, so the chunked approach can be thoroughly tested
> with non default chunk size. For non-sandbox builds, the chunk size is
> 4 GiB - 1 kiB.
>
> The gzwrite test case is extended to test various chunk sizes during
> gzwrite decompression test.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Alexander Graf <agraf@csgraf.de>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Jerome Forissier <jerome@forissier.org>
> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
> Cc: u-boot@lists.denx.de
> ---
> V2: Rebase on master
> ---
>  lib/gunzip.c     | 76 +++++++++++++++++++++++++++++++++---------------
>  test/cmd/unzip.c | 12 +++++++-
>  2 files changed, 64 insertions(+), 24 deletions(-)
>
> diff --git a/lib/gunzip.c b/lib/gunzip.c
> index 76f3397fced..20cc14f9688 100644
> --- a/lib/gunzip.c
> +++ b/lib/gunzip.c
> @@ -8,8 +8,10 @@
>  #include <command.h>
>  #include <console.h>
>  #include <div64.h>
> +#include <env.h>
>  #include <gzip.h>
>  #include <image.h>
> +#include <linux/sizes.h>
>  #include <malloc.h>
>  #include <memalign.h>
>  #include <u-boot/crc.h>
> @@ -119,7 +121,7 @@ void gzwrite_progress_finish(int returnval,
>  int gzwrite(unsigned char *src, size_t len, struct blk_desc *dev,
>             size_t szwritebuf, off_t startoffs, size_t szexpected)
>  {
> -       int i, flags;
> +       int flags;
>         z_stream s;
>         int r = 0;
>         unsigned char *writebuf;
> @@ -127,13 +129,23 @@ int gzwrite(unsigned char *src, size_t len, struct blk_desc *dev,
>         ulong totalfilled = 0;
>         lbaint_t blksperbuf, outblock;
>         u32 expected_crc;
> -       size_t payload_size;
> +       size_t i, payload_size;
> +       unsigned long blocks_written;
> +       lbaint_t writeblocks;
> +       int numfilled = 0;
>         int iteration = 0;
> -
> -       if (len > 0xffffffff) {
> -               log_err("Input size over 4 GiB in size not supported\n");
> -               return -1;
> -       }
> +       /*
> +        * Allow runtime configuration of decompression chunk on
> +        * sandbox to better cover the chunked decompression
> +        * functionality without having to use > 4 GiB files.
> +        */
> +       const ulong minchunk = 0x400;
> +       const ulong maxchunk = SZ_4G - minchunk;
> +       const ulong chunk =
> +               CONFIG_IS_ENABLED(SANDBOX,
> +                                 (clamp(env_get_ulong("gzwrite_chunk", 10, maxchunk),
> +                                        minchunk, maxchunk)),
> +                                 (maxchunk));
>

As you mentioned in the last version, there is a compression test in
compression.c - could you add a version of this function that takes
maxchunk as an argument and call it from that test? Reading an
environment variable to avoid passing a parameter seems pretty odd to
me :-)

[..]

Regards,
Simon
