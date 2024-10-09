Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A506FCEE322
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 15:27:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17D3688B63;
	Wed,  9 Oct 2024 17:27:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hK/77dAQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 371F78806A; Wed,  9 Oct 2024 17:27:22 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EB1388B8F
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 17:27:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20c803787abso170285ad.0
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 08:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728487638; x=1729092438; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WbfIhRL1RRkzwBrFRhTZAK5fjNKQjRWlhLGTbueRf/M=;
 b=hK/77dAQrIaZ1sQWxZlZ9Hp25QodB5Z/F4wex95pzxEiC86ZEJdVgZGCjeAAYmYEYJ
 9eRJsubIHS5bK7IHSDiK+f3VZxr5xCXISPbHUopRvCFSsx5c7PqJZpTpAlNAX1vMKBE4
 ngRW6U4I+BPcFUAG3WGafN9JF2bXT7SEJygA9qYd5bxLWPk/nCf3yzL2PvTQlo1ieeJC
 pmqLAJxG6sTsmK1TLhC5g9V83kJOOhEbdwOnY2Pl3sJ/tTxCUTY8ANjbh2CGomtqe14k
 v/6T1GOuVZ3hswd0GnVQEAnzpfzLikNLp95h5p3wj3ETiLYUV6SE/1QKjNCtiPxKkYwW
 r3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728487638; x=1729092438;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WbfIhRL1RRkzwBrFRhTZAK5fjNKQjRWlhLGTbueRf/M=;
 b=rvNfn39/b/adZGsntGnPu7tTMC8Gb1dmdvE0HUKd8QCkCxxauGC4U4EFfFDD+U9vfz
 3dnRQy5XKLWaDkWevOYx6ChifLlM+nQ07OFCb/s/9lSnHX5IaSV8n3vHwx21m6oKisOK
 UUR+rBmkz93dnNTs6G63qMAYaKZ3wtRCBm8yVEJ0L4e3LiglD4kkxiRpHfCVT1UTKAAJ
 SUH8O6rEdogIhAnQ0sitFu3jneSDVbaADc7foYlYCQvkiVG0UUqKYitaVBQIEyk1NhgA
 g0npoVDB3vF4PLuxWYiuxhwhVINJ9+bcUQ1TlutmQauUDGvjNrVTswdF+HNCzk9TreJY
 ODwQ==
X-Gm-Message-State: AOJu0Yzy7OgFNOMt7ETzAOt09iCfClauMn35jcO6BtD5O+6CG3tbtcWm
 hPhwrTNh/79rHl4s+38bM022iGA7LM3PwIGRXMaig/i0Mb1yb7RMB1Zp67i/A57mBaxcgUlStwb
 E4bgIHxn0FpDwhUIjxD32MzH4DIGUonkXLsnNcA==
X-Google-Smtp-Source: AGHT+IFpjFFk+lwtM7HGOTKj3laYU4kfUvwq7ms0vP3HJtJLgSg5fxcRMc4MDjya0uL+zIHabUpJrgRV4soC6efJ5z0=
X-Received: by 2002:a17:902:e88d:b0:20b:6462:84d2 with SMTP id
 d9443c01a7336-20c6351e0bamr50864915ad.19.1728487638080; Wed, 09 Oct 2024
 08:27:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1728482473.git.jerome.forissier@linaro.org>
 <6de92bad17c86e300e3ae4d1b8b67569b350410c.1728482473.git.jerome.forissier@linaro.org>
In-Reply-To: <6de92bad17c86e300e3ae4d1b8b67569b350410c.1728482473.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 9 Oct 2024 18:26:41 +0300
Message-ID: <CAC_iWj+1xoe2_KtDAnvmXMz7+eAEMAv5CPbuMxWUUefDJa-ofg@mail.gmail.com>
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

Hi Jerome,

On Wed, 9 Oct 2024 at 17:50, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> The TFTP protocol uses a default block size of 512 bytes. This value is
> sub-optimal for ethernet devices, which have a MTU (Maximum Transmission
> Unit) of 1500 bytes. When taking into acount the overhead of the IP and
> UDP layers, this leaves 1468 bytes for the TFTP payload.
>
> This patch introduces a new function: tftp_client_set_blksize() which
> may be used to change the block size from the default. It has to be
> called after tftp_client_init() and before tftp_get(). If the server
> does not support the option, the client will still accept to receive
> 512-byte blocks.
>
> Submitted upstream: https://savannah.nongnu.org/patch/index.php?10462
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  lib/lwip/lwip/src/apps/tftp/tftp.c            | 94 +++++++++++++++++--
>  .../lwip/src/include/lwip/apps/tftp_client.h  |  1 +
>  2 files changed, 89 insertions(+), 6 deletions(-)
>
> diff --git a/lib/lwip/lwip/src/apps/tftp/tftp.c b/lib/lwip/lwip/src/apps/tftp/tftp.c
> index 74fc1fbe586..8e0c071772a 100644
> --- a/lib/lwip/lwip/src/apps/tftp/tftp.c
> +++ b/lib/lwip/lwip/src/apps/tftp/tftp.c
> @@ -57,7 +57,7 @@
>  #include "lwip/timeouts.h"
>  #include "lwip/debug.h"
>
> -#define TFTP_MAX_PAYLOAD_SIZE 512
> +#define TFTP_DEFAULT_BLOCK_SIZE 512
>  #define TFTP_HEADER_LENGTH    4
>
>  #define TFTP_RRQ   1
> @@ -65,6 +65,7 @@
>  #define TFTP_DATA  3
>  #define TFTP_ACK   4
>  #define TFTP_ERROR 5
> +#define TFTP_OACK  6
>
>  enum tftp_error {
>    TFTP_ERROR_FILE_NOT_FOUND    = 1,
> @@ -88,9 +89,11 @@ struct tftp_state {
>    int timer;
>    int last_pkt;
>    u16_t blknum;
> +  u16_t blksize;
>    u8_t retries;
>    u8_t mode_write;
>    u8_t tftp_mode;
> +  bool wait_oack;
>  };
>
>  static struct tftp_state tftp_state;
> @@ -137,10 +140,24 @@ send_request(const ip_addr_t *addr, u16_t port, u16_t opcode, const char* fname,
>  {
>    size_t fname_length = strlen(fname)+1;
>    size_t mode_length = strlen(mode)+1;
> -  struct pbuf* p = init_packet(opcode, 0, fname_length + mode_length - 2);
> +  size_t blksize_length = 0;
> +  struct pbuf* p;
>    char* payload;
>    err_t ret;
>
> +  if (tftp_state.blksize) {
> +    blksize_length = 14; /* maximum (blksize is a u16_t): 'blksize\0XXXXX\0' */
> +    if (tftp_state.blksize < 10000)
> +           blksize_length--;
> +    if (tftp_state.blksize < 1000)
> +           blksize_length--;
> +    if (tftp_state.blksize < 100)
> +           blksize_length--;
> +    if (tftp_state.blksize < 10)
> +           blksize_length--;
> +  }

I'd really prefer the alternative for this [0]. Since you havent
changed it, make sure you queue it up if v12 gets merged

> +
> +  p = init_packet(opcode, 0, fname_length + mode_length + blksize_length - 2);
>    if (p == NULL) {
>      return ERR_MEM;

[...]

>
>
> --
> 2.40.1
>

[0] https://lore.kernel.org/u-boot/CAC_iWjJjsOZYZHB+019G8xs33+Bj2FeV8MB7FfhJ-C8v8uBNng@mail.gmail.com/

Thanks
/Ilias
