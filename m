Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE67BC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 20:07:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F325C874D6;
	Sun, 12 Nov 2023 21:03:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IXCekVoU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F75386BF7; Sun, 12 Nov 2023 21:03:41 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3A3C87456
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 21:03:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5bf812041a6so39752787b3.3
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 12:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699819417; x=1700424217; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pnxnboXgeOzkKHGHToBUoS+33AdyY93nNBSw62agh5o=;
 b=IXCekVoUt1xXPxxQibZcGsHTtm6qI72Vb3XOekm+f8Y2IcZJw2KG0rCipeDqHFBxkI
 bcE0FKbbc3vJ3SpSucbvdtWIbIHD80HJ8YqgZWKltJv48EENFwaam3F2KrtlvS6tNgHK
 wDclqz8q+4buDXlnzwHmbqH0U1abDOmtlc8Sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699819417; x=1700424217;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pnxnboXgeOzkKHGHToBUoS+33AdyY93nNBSw62agh5o=;
 b=jRy8aa0ENoMItw6rVyUGQToNuKUeR0+1LWfn3TIG+GgZi5GJhBft74848BShgX9xJA
 NkuoC61gVfRm7mI46if9rghPVICv2xmGZiMvco+Hd/Ugx6kXIJ+KPAhUGb5yZbPQ4D6E
 Kj4VUcFIFocJp2D8xqcEkwy+vNRuU1S3U2LUaECIA91xpNAq2SViJt+rxwRDtbv9Tbr0
 N5uHq4s658RG7hQAXiBXDPgARQB3F27eS2lauhsctltXolxpffDTra4W1yrWaJtjQ+H2
 7EANz72+LzeJYvyLWvM+HOwrQSzrtzpryW9qGKkQFRPIA0kh0qVQcUw/vNhdcdQIG7l7
 p9zA==
X-Gm-Message-State: AOJu0YwmAYvjHCNo3Wx9TFCd85xKovQfhvYXbTkOp8c0yjyvahnJuykb
 i039NINNuDUiI1H9u1UhPLARpCXvq8Cv9kzbRXyiaQ==
X-Google-Smtp-Source: AGHT+IFugJfqP0khflXdpXoxHhEnX1W9sEoxIbhdasBw5sqvD5vlueTH6GH1rY/O1Mav4VjlOeimdAiAmno4NAhPrNs=
X-Received: by 2002:a81:84c9:0:b0:5a8:102:fe3e with SMTP id
 u192-20020a8184c9000000b005a80102fe3emr4686907ywf.11.1699819417032; Sun, 12
 Nov 2023 12:03:37 -0800 (PST)
MIME-Version: 1.0
References: <20231112143811.3606-1-stefan_b@posteo.net>
 <20231112143811.3606-2-stefan_b@posteo.net>
In-Reply-To: <20231112143811.3606-2-stefan_b@posteo.net>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 12 Nov 2023 13:01:15 -0700
Message-ID: <CAPnjgZ2bp9+qn9hfqKdYQZS3p1PDWWcHm+io_YsUM541HSx8FQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] common: board_f: change calculation of gd->mon_len
 to fix s5p4418 reloc
To: Stefan Bosch <stefan_b@posteo.net>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Sun, 12 Nov 2023 at 07:40, Stefan Bosch <stefan_b@posteo.net> wrote:
>
> ARM and MICROBLAZE: Change calculation of monitor length (gd->mon_len)
> to fix relocation at boards with s5p4418-SoC. At s5p4418, _start is
> after the header (NSIH) therefore the monitor length has to be
> calculated using __image_copy_start instead of _start in order the hole

whole

> monitor code is relocated.
>
> Signed-off-by: Stefan Bosch <stefan_b@posteo.net>Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>
>  common/board_f.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/common/board_f.c b/common/board_f.c
> index d4d7d01f8f..d2e4d9eae2 100644
> --- a/common/board_f.c
> +++ b/common/board_f.c
> @@ -283,7 +283,7 @@ static int init_func_i2c(void)
>  static int setup_mon_len(void)
>  {
>  #if defined(__ARM__) || defined(__MICROBLAZE__)
> -       gd->mon_len = (ulong)__bss_end - (ulong)_start;
> +       gd->mon_len = (ulong)__bss_end - (ulong)__image_copy_start;
>  #elif defined(CONFIG_SANDBOX) && !defined(__riscv)
>         gd->mon_len = (ulong)_end - (ulong)_init;
>  #elif defined(CONFIG_SANDBOX)
> --
> 2.17.1
>
