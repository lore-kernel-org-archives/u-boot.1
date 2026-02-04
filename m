Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A91E8B383
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 00:22:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 312C683DFF;
	Wed,  4 Feb 2026 01:22:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Dex9zOu0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B25E83DFF; Wed,  4 Feb 2026 01:22:55 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27E7C83BC7
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 01:22:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b8de761c13eso742731266b.1
 for <u-boot@lists.denx.de>; Tue, 03 Feb 2026 16:22:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770164568; cv=none;
 d=google.com; s=arc-20240605;
 b=HseBl+nZfbW5NmbAl1SSKHmbU/vHAIdOWWic/Zvg1xQBUK3rtNbVj5bHJz52EYJgOb
 uS8SfcNWZ+Gr6x7OdklYp3gwaoOzsnNqfEwot6uIIIwmca9nhF8xzDDLTvo0f+3V/QwD
 NdC7zNhygtbT38qAso7OZ1Ajw9w2FQbaPhLOMV+UYUKi5sCA/dd3w2oChavJBjJDt3U4
 OWZ6OeDvGOU28MUWP+BUfcDsZ2sfERadEmPgR5bK14JZk4lLOwQYxJ4lqjGshfbcbIqY
 CzsUmF+5XluCXcSoNXfC8yNW0I4b5WdtFBvej1wL12c2zB4R+EGul6upNBcVdXiJ+zn7
 /AXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CwPyZ8Ic8ttm1KjXosNrJsxh2cDT8PiCC4+GXtlifsQ=;
 fh=ed0Ie8kN2ZRpM9JpRUh2QtwLMXwIkJzbEqpXUxMla1Q=;
 b=YdBTi5FRY6e6Jwg4h1oLl5+bK309xHokjpZWtQyHc9DjB5ulAbJWlF9zZyzB8bPxi5
 1xvSOt+oBKFC0aCf++G+ldWN3Byo+zEreCMFHrhibxKKT13n/XE0+7eNoblM6wTBofMR
 p4nSffp5bdJ5er8dN7zF4RtPdw9A1wTW4VWQtqKb/pIjABNBli0/a5aqCxHqW95ajsRX
 n0Bcj7LWESg0wDaH917fVXQAGMOliJ9hUUFJuXTGUU01Bx5LJUWEeUdbkVKLCHyA/Ij7
 u24WFDlppRae44ztZ1EProe4L8a3oGyearuZ2xLLl8a2EHquMqwQWPpIWV8KYKY0/dnz
 f0fg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1770164568; x=1770769368; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CwPyZ8Ic8ttm1KjXosNrJsxh2cDT8PiCC4+GXtlifsQ=;
 b=Dex9zOu0JLHpUxse6B+zlU5d8iNQoizYU9ATAObHsAlQ/xyQv0vxbESX0xlTdUObEg
 EKtAtJQP0bZm/yvuX1SG015DoYYf72aYRt49r9fYBwr1hY4HI8pK04aZxOnriyAt2Ivt
 Exe8QhKJ8hExQkxrkzzVlOzUXYHYr9F+EEL/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770164568; x=1770769368;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CwPyZ8Ic8ttm1KjXosNrJsxh2cDT8PiCC4+GXtlifsQ=;
 b=HVkMSTcb5L1+VGWD91MRBfBnsmni3bzl628RSqCu7hUtIG6HsKuSZj5BrnzNFNzgnO
 b/DO/5MzWmziRhaEOibt3DDK/PpbQY6NGfPUASj9Gw+FhvO5bLuQL5bzx4YZtTAbgDW/
 toh2YKTYxrAnTNu+AMMPww0PmTTlA/RUQuJdRwSOXTFbcOUuA9yxle07/WixelOvUUgQ
 iQSYMMYEyiKbCYxpMugSEvO/P/gd4frH0tGgcRdD0jQcRjH6zWa50ynXHyEfWdB+EVIi
 +7SPo1RpW882ZAR0bxLiNGGWzI/pU0hYQpKy3wg5CmBuBR0cjd7NdAfXeip2SrPvynRO
 7Ing==
X-Gm-Message-State: AOJu0YwrDE+R6s7rFFYGpHui+Aj96NqYkRsKbhu2CyIGPhrWBiFoXp7n
 U7Idn3+6ah3yCwTxkttDLxXfal5E98eo2mi4GwUQ0eemKWCv+hxPSANh8qbGXbaltg5KHkkkpEL
 rN+SQvPKOiHRHvpZNSyshQUXazgsbZG9ktMU96lJw
X-Gm-Gg: AZuq6aIVDNnqF7nt+tpd6RvlKzUOG1tnnWIte7zCH8ENr0/SMRJiTSe0tkhyn1tfXPL
 6JbRnrCbbNc+k1x5vdEW+FtsdVEqRl0L9pQAVReWQa77eE0J1x5t89b0ZKTs2J4mzKmmlkd/3HZ
 zklwCQ1NlStvaH+xbZFb/a+gPF0Jqgm0sWXg5S3fJ5rJBxUceJkJvXInzy9ppl+yx46woLyzbBy
 Ars0JCry++W76whj/aG1UPRombucz6ihr2MYWsUp+70jjMUZRTNXkbO/GJVLkJQufLmt9ifQq2w
 Hs1ZROw=
X-Received: by 2002:a17:907:804:b0:b86:f999:15ba with SMTP id
 a640c23a62f3a-b8e9f17f56emr73448366b.18.1770164568443; Tue, 03 Feb 2026
 16:22:48 -0800 (PST)
MIME-Version: 1.0
References: <20260128000340.1504375-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260128000340.1504375-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 4 Feb 2026 13:22:50 +1300
X-Gm-Features: AZwV_Qhodb3lPEjMBjkxQzP182whFgE2E6vuNkiUOY62N0OiCX0HZR_Rm10lHuA
Message-ID: <CAFLszTi2oP-vmCoPNayrKfVi8xMide3g5mR6XdcUgpaReyPtkg@mail.gmail.com>
Subject: Re: [PATCH] gunzip: Implement chunked decompression
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

On Wed, 28 Jan 2026 at 13:03, Marek Vasut
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
> This depends on multiple fixes, and the actual unit test for gzwrite command:
> https://lore.kernel.org/u-boot/20260127235156.1503207-1-marek.vasut+renesas@mailbox.org/
> https://lore.kernel.org/u-boot/20260127235310.1503239-1-marek.vasut+renesas@mailbox.org/
> https://lore.kernel.org/u-boot/20260127235339.1503312-1-marek.vasut+renesas@mailbox.org/
> https://lore.kernel.org/u-boot/20260127235914.1503663-1-marek.vasut+renesas@mailbox.org/
> ---
>  lib/gunzip.c     | 77 +++++++++++++++++++++++++++++++++---------------
>  test/cmd/unzip.c | 12 +++++++-
>  2 files changed, 64 insertions(+), 25 deletions(-)
>
> diff --git a/lib/gunzip.c b/lib/gunzip.c
> index d31bbb2ba03..0e4bca28a5e 100644
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
> @@ -124,7 +126,7 @@ void gzwrite_progress_finish(int returnval,
>  int gzwrite(unsigned char *src, unsigned long len, struct blk_desc *dev,
>             ulong szwritebuf, ulong startoffs, ulong szexpected)
>  {
> -       int i, flags;
> +       int flags;
>         z_stream s;
>         int r = 0;
>         unsigned char *writebuf;
> @@ -132,14 +134,23 @@ int gzwrite(unsigned char *src, unsigned long len, struct blk_desc *dev,
>         ulong totalfilled = 0;
>         lbaint_t blksperbuf, outblock;
>         u32 expected_crc;
> -       u32 payload_size;
> +       unsigned long i, payload_size;
> +       unsigned long blocks_written;
> +       lbaint_t writeblocks;
> +       int numfilled = 0;
>         int iteration = 0;
> -
> -       if (len > 0xffffffff) {
> -               printf("%s: input size over 4 GiB in size not supported\n",
> -                      __func__);
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
>         if (!szwritebuf ||
>             (szwritebuf % dev->blksz) ||
> @@ -181,7 +192,7 @@ int gzwrite(unsigned char *src, unsigned long len, struct blk_desc *dev,
>                 return -1;
>         }
>
> -       payload_size = len - i - 8;
> +       payload_size = len - i;
>
>         memcpy(&expected_crc, src + len - 8, sizeof(expected_crc));
>         expected_crc = le32_to_cpu(expected_crc);
> @@ -211,35 +222,44 @@ int gzwrite(unsigned char *src, unsigned long len, struct blk_desc *dev,
>                 return -1;
>         }
>
> -       s.next_in = src + i;
> -       s.avail_in = payload_size+8;
> +       src += i;
> +       s.avail_in = 0;
>         writebuf = (unsigned char *)malloc_cache_aligned(szwritebuf);
>
>         /* decompress until deflate stream ends or end of file */
>         do {
>                 if (s.avail_in == 0) {
> -                       printf("%s: weird termination with result %d\n",
> -                              __func__, r);
> -                       break;
> +                       if (payload_size == 0) {
> +                               printf("%s: weird termination with result %d\n",
> +                                      __func__, r);
> +                               break;
> +                       }
> +
> +                       s.next_in = src;
> +                       s.avail_in = (payload_size > chunk) ? chunk : payload_size;
> +                       src += s.avail_in;
> +                       payload_size -= s.avail_in;
>                 }
>
>                 /* run inflate() on input until output buffer not full */
>                 do {
> -                       unsigned long blocks_written;
> -                       int numfilled;
> -                       lbaint_t writeblocks;
> -
> -                       s.avail_out = szwritebuf;
> -                       s.next_out = writebuf;
> +                       if (numfilled) {
> +                               s.avail_out = szwritebuf - numfilled;
> +                               s.next_out = writebuf + numfilled;
> +                       } else {
> +                               s.avail_out = szwritebuf;
> +                               s.next_out = writebuf;
> +                       }
>                         r = inflate(&s, Z_SYNC_FLUSH);
>                         if ((r != Z_OK) &&
>                             (r != Z_STREAM_END)) {
>                                 printf("Error: inflate() returned %d\n", r);
>                                 goto out;
>                         }
> +                       crc = crc32(crc, writebuf + numfilled,
> +                                   szwritebuf - s.avail_out - numfilled);
> +                       totalfilled += szwritebuf - s.avail_out - numfilled;
>                         numfilled = szwritebuf - s.avail_out;
> -                       crc = crc32(crc, writebuf, numfilled);
> -                       totalfilled += numfilled;
>                         if (numfilled < szwritebuf) {
>                                 writeblocks = (numfilled+dev->blksz-1)
>                                                 / dev->blksz;
> @@ -247,14 +267,17 @@ int gzwrite(unsigned char *src, unsigned long len, struct blk_desc *dev,
>                                        dev->blksz-(numfilled%dev->blksz));
>                         } else {
>                                 writeblocks = blksperbuf;
> +                               numfilled = 0;
>                         }
>
>                         gzwrite_progress(iteration++,
>                                          totalfilled,
>                                          szexpected);
> -                       blocks_written = blk_dwrite(dev, outblock,
> +                       if (!numfilled) {
> +                               blocks_written = blk_dwrite(dev, outblock,
>                                                     writeblocks, writebuf);
> -                       outblock += blocks_written;
> +                               outblock += blocks_written;
> +                       }
>                         if (ctrlc()) {
>                                 puts("abort\n");
>                                 goto out;
> @@ -264,6 +287,12 @@ int gzwrite(unsigned char *src, unsigned long len, struct blk_desc *dev,
>                 /* done when inflate() says it's done */
>         } while (r != Z_STREAM_END);
>
> +       if (numfilled) {
> +               blocks_written = blk_dwrite(dev, outblock,
> +                                   writeblocks, writebuf);
> +               outblock += blocks_written;
> +       }
> +
>         if ((szexpected != totalfilled) ||
>             (crc != expected_crc))
>                 r = -1;
> diff --git a/test/cmd/unzip.c b/test/cmd/unzip.c
> index 725fcf91458..7c54cc7a815 100644
> --- a/test/cmd/unzip.c
> +++ b/test/cmd/unzip.c
> @@ -100,7 +100,7 @@ static int dm_test_cmd_zip_gzwrite(struct unit_test_state *uts)
>         struct blk_desc *mmc_dev_desc;
>         struct udevice *dev;
>         ofnode root, node;
> -       int i, ret;
> +       int i, j, ret;
>
>         /* Enable the mmc9 node for this test */
>         root = oftree_root(oftree_default());
> @@ -122,6 +122,16 @@ static int dm_test_cmd_zip_gzwrite(struct unit_test_state *uts)
>                         return ret;
>         }
>
> +       /* Test various sizes of decompression chunk sizes */
> +       for (j = 0; j < ARRAY_SIZE(sizes); j++) {
> +               env_set_ulong("gzwrite_chunk", sizes[j]);
> +               for (i = 0; i < ARRAY_SIZE(sizes); i++) {
> +                       ret = do_test_cmd_zip_unzip(uts, sizes[i], true);
> +                       if (ret)
> +                               return ret;
> +               }
> +       }
> +
>         return 0;
>  }
>  DM_TEST(dm_test_cmd_zip_gzwrite, UTF_CONSOLE);
> --
> 2.51.0
>

Rather than an environment variable, you could create a variant of
gzwrite() which allows it to be passed.

Regards,
Simon
