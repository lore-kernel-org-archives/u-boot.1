Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C7CACD4939
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:02:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 411D186C75;
	Thu, 21 Sep 2023 03:02:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UsiMC29G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DE2D86B55; Thu, 21 Sep 2023 03:02:49 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B76E86C65
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-50307acd445so789629e87.0
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695258167; x=1695862967; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XinUxMBTpVJFecw1xk8+hcgmj/TRXaYR0NBvNYesOtg=;
 b=UsiMC29G+kWkBdDDiJnNW0VDW0qM5t9OkiNpgXeLdvYZBfBv0GmuxTzAXIEoL9G4Sk
 nT7QuAZzMXanLfa2wBkRFaH3C146VqoE1CJj/66CEXGZjY6hFblG/EmVEyY6g5zIXxsP
 eq/WQkQ7xl1hT1liMJ7SIZXlUcptI+GeFiaAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695258167; x=1695862967;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XinUxMBTpVJFecw1xk8+hcgmj/TRXaYR0NBvNYesOtg=;
 b=hLvIS7CeXd9ukrv3PkifbE7KUzApwitXwMpqxbOWj1kopWMBJVfJXp/ZsoQ17UXUfW
 zQW9Z+JTV6lfaLP6Xz7DXNnWsPOqBjJJ9JRt//3s1zIRRQUP3gUbxoGMnYYoBbiNtL9O
 qbhdnfv75bTLVFcrQ/RNkIUVuQ8K6dtHMvl/sJZ0JBN7hTJ93kE6BerKBcJl/favslJT
 nmYXouAk2hE04kd7/TqUEwFftx5+27pE22Ut4GSW/wv7wtJTv1yLipMaS/QDQ9K9vM1O
 3RHeE6590Vle1G9nDi5Ucm7yuADZFCnJRbTldTFo9r1RyxNp5uZ91iutfmiXHLY9d0CI
 MtYQ==
X-Gm-Message-State: AOJu0YwAszFTD1oxvJu7/sJkR/g+qmsERBBzRWexKZ6HFUesdnIcAY9E
 4di5HGuF8ViN4vYKzKiH73ddv+T1WjIUB+qWk3X/dw==
X-Google-Smtp-Source: AGHT+IGoZLk1/Y8RAIq9sl/VcKlpPNiSMK+epQpKgB/hS1VRPEOtWAYnSw0Dxg8NMaJCp3Tq9Cfm3+0GbhZAwxw/cdY=
X-Received: by 2002:ac2:5dd7:0:b0:502:d302:e025 with SMTP id
 x23-20020ac25dd7000000b00502d302e025mr3375775lfq.2.1695258166644; Wed, 20 Sep
 2023 18:02:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230915101640.1166332-1-masahisa.kojima@linaro.org>
 <20230915101640.1166332-2-masahisa.kojima@linaro.org>
In-Reply-To: <20230915101640.1166332-2-masahisa.kojima@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Sep 2023 19:02:17 -0600
Message-ID: <CAPnjgZ1FdD0kXNBYjcjt=HoBEuurGUasjYD0Hj523oQTqV1m8A@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] net: wget: prevent overwriting reserved memory
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
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

Hi Masahisa,

On Fri, 15 Sept 2023 at 04:17, Masahisa Kojima
<masahisa.kojima@linaro.org> wrote:
>
> This introduces the valid range check to store the received
> blocks using lmb. The same logic is implemented in tftp.
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---
>  net/wget.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 73 insertions(+), 7 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/net/wget.c b/net/wget.c
> index 2dbfeb1a1d..9690e4539c 100644
> --- a/net/wget.c
> +++ b/net/wget.c
> @@ -4,16 +4,20 @@
>   * Copyright Duncan Hare <dh@synoia.com> 2017
>   */
>
> +#include <asm/global_data.h>
>  #include <command.h>
>  #include <common.h>
>  #include <display_options.h>
>  #include <env.h>
>  #include <image.h>
> +#include <lmb.h>
>  #include <mapmem.h>
>  #include <net.h>
>  #include <net/tcp.h>
>  #include <net/wget.h>
>
> +DECLARE_GLOBAL_DATA_PTR;
> +
>  static const char bootfile1[] = "GET ";
>  static const char bootfile3[] = " HTTP/1.0\r\n\r\n";
>  static const char http_eom[] = "\r\n\r\n";
> @@ -55,6 +59,29 @@ static unsigned int retry_tcp_ack_num;       /* TCP retry acknowledge number*/
>  static unsigned int retry_tcp_seq_num; /* TCP retry sequence number */
>  static int retry_len;                  /* TCP retry length */
>
> +static ulong wget_load_size;
> +
> +/**
> + * wget_init_max_size() - initialize maximum load size
> + *
> + * Return:     0 if success, -1 if fails
> + */
> +static int wget_init_load_size(void)
> +{
> +       struct lmb lmb;
> +       phys_size_t max_size;
> +
> +       lmb_init_and_reserve(&lmb, gd->bd, (void *)gd->fdt_blob);

That function should be changed to const void * but we plan to move to
ofnode anyway, so let's not worry about it.

[..]

Regards,
Simon
