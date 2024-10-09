Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0BACCEE338
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 17:39:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BC6988CC5;
	Wed,  9 Oct 2024 19:39:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="caHj2oKz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B419688D9E; Wed,  9 Oct 2024 19:39:54 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05DFB88CAE
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 19:39:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20b7eb9e81eso84543955ad.2
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 10:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728495590; x=1729100390; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n61i5PIJ/rGfhWJLzltqmI+TgeuuoLNePTKv/6figFk=;
 b=caHj2oKzBQPTGZPuo6ABeNXBlZ7NuO1dgEcG/kj8fwmjrJvCyJ/BCTVOIFWcFb4/Ri
 TzMhfmyiHmUliRJNAfeeSnQbuuuK6cEEXu9wC34msCNALBMFpw2v0+N0Orup+hW1thMN
 0roFyE6irtLsS1yp7ZAS9PpaW6Qyb6jtN2RzBsoema6J2C54fX+O7WdQE+DTOVq4+Pw9
 MbK7KgF3GiF83xg/j8780LxDM4EQjD6fJNXS5n+beGsF9yJ9Yb5XT6cqzeVWLFKjVA6W
 v2YKWU4xOLoYAlfWrIxIBCVJXfFGHbq/FcInSS5amvbqHRgoZJjAsEKUL7rOlALCGb2h
 yW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728495590; x=1729100390;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n61i5PIJ/rGfhWJLzltqmI+TgeuuoLNePTKv/6figFk=;
 b=XS1v02mhbbEX+oM6ayejSFIGN54ZyGniDvY6mjBguy2DTLBdtOQrpKB0QSnSmXQI1X
 Sl841BAqbvFKDATvZ9PkPnauL/1EnSe31J5VWoV4V0vpbbL15CZJ6ttvoqBNEtjE0nPQ
 yYJL+fSCDbIJaYwqKevUbPsNDMDSYKTk797fD+uUTzrBzE/uZ/JpUh+VIfx+hhA8YdK9
 WCvHiebBgdZOdgtOHKUFvJQRCYTvx4N40OVlCOtxek8M4MqcMdJhbmHaNTHdGEYfTzdC
 +1BnXrXoh4tc0HMjiF13fJlbK1N2WsPcDjV8yZB61uhQDIlBrVR9zdtgddTiyjUR3mNH
 5Hxw==
X-Gm-Message-State: AOJu0YxmIIvWE0obfmV0ZpAf7XrUhTHxne7SS5C2OK5MazfMqc9/v0Rw
 8zXqEjlOFIqyP/bXp5MfJwMIE/TMXyJv3exr3sbu+bisYWj8BDd+/D+pmkpYlLQQ/LNEieuDFE9
 axS97JfnjGheZZQjQG6vMvg+t5ckI6x83mqUHNQ==
X-Google-Smtp-Source: AGHT+IHOmCdG2nBSA0Y67G4RATtecijMV/hc2Spi89zdGInOg/oFFbep+Sj5+SMzRgnrkr/4XHD6c6fOr6bSRVKuKY4=
X-Received: by 2002:a17:902:f54d:b0:20b:684b:fce8 with SMTP id
 d9443c01a7336-20c6370b6c6mr41847695ad.14.1728495590390; Wed, 09 Oct 2024
 10:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1728482473.git.jerome.forissier@linaro.org>
 <6de92bad17c86e300e3ae4d1b8b67569b350410c.1728482473.git.jerome.forissier@linaro.org>
 <CAC_iWj+1xoe2_KtDAnvmXMz7+eAEMAv5CPbuMxWUUefDJa-ofg@mail.gmail.com>
 <513c3a74-a33a-4261-899e-30038f8ff878@linaro.org>
In-Reply-To: <513c3a74-a33a-4261-899e-30038f8ff878@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 9 Oct 2024 20:39:14 +0300
Message-ID: <CAC_iWjJKo7+xYXg0kjTi26ELdDOT1tQoa_C4g2KPDOOh_8QfPA@mail.gmail.com>
Subject: Re: [PATCH v12 18/21] net: lwip: tftp: add support of blksize option
 to client
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>, Maxim Uvarov <muvarov@gmail.com>, 
 Tim Harvey <tharvey@gateworks.com>, Anton Antonov <Anton.Antonov@arm.com>, 
 Tom Rini <trini@konsulko.com>
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

On Wed, 9 Oct 2024 at 19:30, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
>
>
> On 10/9/24 17:26, Ilias Apalodimas wrote:
> > Hi Jerome,
> >
> > On Wed, 9 Oct 2024 at 17:50, Jerome Forissier
> > <jerome.forissier@linaro.org> wrote:
> >>
> >> The TFTP protocol uses a default block size of 512 bytes. This value is
> >> sub-optimal for ethernet devices, which have a MTU (Maximum Transmission
> >> Unit) of 1500 bytes. When taking into acount the overhead of the IP and
> >> UDP layers, this leaves 1468 bytes for the TFTP payload.
> >>
> >> This patch introduces a new function: tftp_client_set_blksize() which
> >> may be used to change the block size from the default. It has to be
> >> called after tftp_client_init() and before tftp_get(). If the server
> >> does not support the option, the client will still accept to receive
> >> 512-byte blocks.
> >>
> >> Submitted upstream: https://savannah.nongnu.org/patch/index.php?10462
> >>
> >> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> >> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >> ---
> >>  lib/lwip/lwip/src/apps/tftp/tftp.c            | 94 +++++++++++++++++--
> >>  .../lwip/src/include/lwip/apps/tftp_client.h  |  1 +
> >>  2 files changed, 89 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/lib/lwip/lwip/src/apps/tftp/tftp.c b/lib/lwip/lwip/src/apps/tftp/tftp.c
> >> index 74fc1fbe586..8e0c071772a 100644
> >> --- a/lib/lwip/lwip/src/apps/tftp/tftp.c
> >> +++ b/lib/lwip/lwip/src/apps/tftp/tftp.c
> >> @@ -57,7 +57,7 @@
> >>  #include "lwip/timeouts.h"
> >>  #include "lwip/debug.h"
> >>
> >> -#define TFTP_MAX_PAYLOAD_SIZE 512
> >> +#define TFTP_DEFAULT_BLOCK_SIZE 512
> >>  #define TFTP_HEADER_LENGTH    4
> >>
> >>  #define TFTP_RRQ   1
> >> @@ -65,6 +65,7 @@
> >>  #define TFTP_DATA  3
> >>  #define TFTP_ACK   4
> >>  #define TFTP_ERROR 5
> >> +#define TFTP_OACK  6
> >>
> >>  enum tftp_error {
> >>    TFTP_ERROR_FILE_NOT_FOUND    = 1,
> >> @@ -88,9 +89,11 @@ struct tftp_state {
> >>    int timer;
> >>    int last_pkt;
> >>    u16_t blknum;
> >> +  u16_t blksize;
> >>    u8_t retries;
> >>    u8_t mode_write;
> >>    u8_t tftp_mode;
> >> +  bool wait_oack;
> >>  };
> >>
> >>  static struct tftp_state tftp_state;
> >> @@ -137,10 +140,24 @@ send_request(const ip_addr_t *addr, u16_t port, u16_t opcode, const char* fname,
> >>  {
> >>    size_t fname_length = strlen(fname)+1;
> >>    size_t mode_length = strlen(mode)+1;
> >> -  struct pbuf* p = init_packet(opcode, 0, fname_length + mode_length - 2);
> >> +  size_t blksize_length = 0;
> >> +  struct pbuf* p;
> >>    char* payload;
> >>    err_t ret;
> >>
> >> +  if (tftp_state.blksize) {
> >> +    blksize_length = 14; /* maximum (blksize is a u16_t): 'blksize\0XXXXX\0' */
> >> +    if (tftp_state.blksize < 10000)
> >> +           blksize_length--;
> >> +    if (tftp_state.blksize < 1000)
> >> +           blksize_length--;
> >> +    if (tftp_state.blksize < 100)
> >> +           blksize_length--;
> >> +    if (tftp_state.blksize < 10)
> >> +           blksize_length--;
> >> +  }
> >
> > I'd really prefer the alternative for this [0]. Since you havent
> > changed it, make sure you queue it up if v12 gets merged
>
> Sorry about that, I forgot. The code you propose in [0] needs a few
> adjustments: >= not >,

There's a cnt++ in that code after the loop, so it's either with > and ++ or >=

> initialize cnt to 1 to account for one digit at
> least, and do nothing if tftp_state.blksize == 0. We can get rid of
> cnt and it still looks good and even better IMO. So how about this?
>
> diff --git a/lib/lwip/lwip/src/apps/tftp/tftp.c b/lib/lwip/lwip/src/apps/tftp/tftp.c
> index 8e0c071772a..7012aad9d91 100644
> --- a/lib/lwip/lwip/src/apps/tftp/tftp.c
> +++ b/lib/lwip/lwip/src/apps/tftp/tftp.c
> @@ -141,20 +141,18 @@ send_request(const ip_addr_t *addr, u16_t port, u16_t opcode, const char* fname,
>    size_t fname_length = strlen(fname)+1;
>    size_t mode_length = strlen(mode)+1;
>    size_t blksize_length = 0;
> +  int blksize = tftp_state.blksize;
>    struct pbuf* p;
>    char* payload;
>    err_t ret;
>
> -  if (tftp_state.blksize) {
> -    blksize_length = 14; /* maximum (blksize is a u16_t): 'blksize\0XXXXX\0' */
> -    if (tftp_state.blksize < 10000)
> -           blksize_length--;
> -    if (tftp_state.blksize < 1000)
> -           blksize_length--;
> -    if (tftp_state.blksize < 100)
> -           blksize_length--;
> -    if (tftp_state.blksize < 10)
> -           blksize_length--;
> +  if (blksize) {
> +    /* "blksize\0.\0" with . = 1 digit */
> +    blksize_length = strlen("blksize") + 1 + 1 + 1;
> +    while (blksize >= 10) {
> +      blksize /= 10;
> +      blksize_length++;
> +    }

Yea that looks ok


Thanks
/Ilias
>
> >
> >> +
> >> +  p = init_packet(opcode, 0, fname_length + mode_length + blksize_length - 2);
> >>    if (p == NULL) {
> >>      return ERR_MEM;
> >
> > [...]
> >
> >>
> >>
> >> --
> >> 2.40.1
> >>
> >
> > [0] https://lore.kernel.org/u-boot/CAC_iWjJjsOZYZHB+019G8xs33+Bj2FeV8MB7FfhJ-C8v8uBNng@mail.gmail.com/
> >
> > Thanks
> > /Ilias
>
> Thanks,
> --
> Jerome
