Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9105FCF044A
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 10:39:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FE9D8918D;
	Wed,  9 Oct 2024 12:39:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gEehvPaF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFDF689165; Wed,  9 Oct 2024 12:39:15 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6472880A5
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 12:39:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7e9fd82f1a5so2493961a12.1
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 03:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728470351; x=1729075151; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ljs55rF7lzpu2WItsIIWrQYsRPGiDLPqLB+i6hL38cM=;
 b=gEehvPaFRvgq5PEfCW/bLoGHJNVA2uwjcwo4Fy3O0xiM8EjIIhw8O+VYbMT/j5pdTm
 jgSaR04yXK3sjQB1PycK6RKJ09CCoVDrbPsmtr6yr6VUQu71wBc6BH+fxbYxljwEvPUd
 HFt8So67ogiscUUpe5tp3ODKLa41niLwUCeGxma8XBmPx/vmoOnSgBphtasYdXwOXorK
 VzV4TOxT1FHsh0ecVAOWVJm/P8tJ39MGyzShI+HazlpB1hzcsdKtQ3DJmnBpEZsUBJih
 i786UIpMEv4MLwspXOnHz2VAgiwYDFPc3W9pYNjpYOmLGyl85SJXYdxRSuFR3TKNpkKT
 5yag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728470351; x=1729075151;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ljs55rF7lzpu2WItsIIWrQYsRPGiDLPqLB+i6hL38cM=;
 b=hhp4oTMyQNpHBW2Hw372Gsm7BqxxPRgPsXvzSjCk5B1dflb3bRc9jTrL1RZzXoZmdp
 pV6z2lTc3LQO42t9begy+jn2svwBA4RoX53+wldNZTVi8bkscgzZtag+Nar07jCodJvD
 VU5RyyEoQP6EbiEvg57XXwOF/+fp3cUjWKXQsOnzAU/YHd4a2r5aarRjtg/ZpIQgZQZl
 W8SzyxurmcLyQLvJqnOJzujWmEeOphjNE3hNTUUsoufGmCi4173GoSx2OcNiQ2vJj7zZ
 y2EvS/YtKT080haJIDSMXgpBaCbcHWy2ffN+Gd8YMHpUarpMG7rohxbfgOM6J1qwF0HH
 ImrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzYdPUublLOm4m1XyUZpVqzn+5Kis8JPHa8itwHYf6ZpsXC4xvpuhHyA2RZe0V7MdH/LYC2Yg=@lists.denx.de
X-Gm-Message-State: AOJu0YyfnImrKAJ1oO+7rQ+BLcekiNCUG3al5FLS+SgZ8xpD0+Sbo9SG
 jnADbgm7S0IZCfBHXFC2aowT8k9+UOH5pxw0nYUI/vHjkk56YigD9sj+qz0thDivSQwyZ2c7qGv
 Ae4gmBGpkxBI8MnRv/q1HLdoQNcEBHsrvDLYboQ==
X-Google-Smtp-Source: AGHT+IG16Tre2kbk5DpLMaGjQfS4PxcrTrq3Q9wyarUrYh7wEZeZOxG5R+Wn0FozqX6Q5hIo/lHOQ5UgrwGwrQ3T5i8=
X-Received: by 2002:a17:90b:23d2:b0:2e2:8d60:d0a1 with SMTP id
 98e67ed59e1d1-2e2a21dc707mr2096975a91.6.1728470351452; Wed, 09 Oct 2024
 03:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <20241008230205.108375-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241008230205.108375-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 9 Oct 2024 13:38:35 +0300
Message-ID: <CAC_iWjK+WdgwyGeGfR+7rhYX_Jyhj5uO=OB+3RS=-dWuJUsgaw@mail.gmail.com>
Subject: Re: [PATCH] net: correct wget_connected debug messages
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
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

On Wed, 9 Oct 2024 at 02:02, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> * Remove duplicate debug message in wget_connected()
> * Correct typo 'Connctd'
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  net/wget.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/net/wget.c b/net/wget.c
> index b4251e0f293..f978adc9f0a 100644
> --- a/net/wget.c
> +++ b/net/wget.c
> @@ -248,7 +248,7 @@ static void wget_connected(uchar *pkt, unsigned int tcp_seq_num,
>                         wget_send(action, tcp_seq_num, tcp_ack_num, len);
>                 } else {
>                         debug_cond(DEBUG_WGET,
> -                                  "wget: Connctd pkt %p  hlen %x\n",
> +                                  "wget: Connected Pkt %p hlen %x\n",
>                                    pkt, hlen);
>
>                         pos = strstr((char *)pkt, content_len);
> @@ -273,10 +273,6 @@ static void wget_connected(uchar *pkt, unsigned int tcp_seq_num,
>                                 }
>                         }
>
> -                       debug_cond(DEBUG_WGET,
> -                                  "wget: Connected Pkt %p hlen %x\n",
> -                                  pkt, hlen);
> -
>                         for (i = 0; i < pkt_q_idx; i++) {
>                                 int err;
>
> @@ -288,7 +284,7 @@ static void wget_connected(uchar *pkt, unsigned int tcp_seq_num,
>                                           pkt_q[i].len);
>                                 unmap_sysmem(ptr1);
>                                 debug_cond(DEBUG_WGET,
> -                                          "wget: Connctd pkt Q %p len %x\n",
> +                                          "wget: Conncted pkt Q %p len %x\n",
>                                            pkt_q[i].pkt, pkt_q[i].len);
>                                 if (err) {
>                                         wget_loop_state = NETLOOP_FAIL;
> --
> 2.45.2
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
