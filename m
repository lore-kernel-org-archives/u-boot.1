Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC993CF042E
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:59:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73CE189145;
	Wed,  9 Oct 2024 03:57:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dA5r25EH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B57F38913B; Wed,  9 Oct 2024 03:57:34 +0200 (CEST)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ABAC8914E
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:57:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-45aeed46f5eso29986131cf.3
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728439049; x=1729043849; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lMRRBbnui9V0AF2ORfPwlOsOLmaANhx0mzLtrFg/ibM=;
 b=dA5r25EHkFHLwzA8KheDPVlwaoxTdXFqgwB8EPbt60hlNakE7wwJZPWHc8vZ+dLR9m
 BMtglWYRG/vSt1ziA/dTDJsyFqj4gBYDHpzkJtEBq/ZpokqCkGWl4W6tuc/7dLpooVZs
 hTGKIOFvt7rxz6ooxDBxtujlU6GdU0dU1xaBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728439049; x=1729043849;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lMRRBbnui9V0AF2ORfPwlOsOLmaANhx0mzLtrFg/ibM=;
 b=bK8+EXzW+7vIOHCU/dfTUZM7gBCd8q/45HH/jVObkReKiEsYyQsEfaED4gVU3siRNc
 UWKWpXB9nLT1tfWrw5BABqQRRG5xdfuhUXHGU7ieoB/NrueIFwx6jVrwOznKncikD/X2
 lgOBmnknp61oQwQle7eirI3UqRhi1QxejEyhXNu1Q6IqgvvJ+KKD2hq4gQncictsMUnm
 ZLfVYbmOgmgRo/i04ykAuPAM5RbztSYciKW5yShQb1pQTs3ODA5Lj5g+a11IzMDWGgfr
 ZMocuTQ0VBvXrQao6NSqT4IBRnITtNMVMTwctsbz4yOnjURd8JPe6lcZcMjF9A03pM6V
 hrPw==
X-Gm-Message-State: AOJu0YxrGooldpXr8DD9WF0Gi4Cn+Ug1kn5xwCMSAYpmEZdfagbJ/7/z
 +257wlHa9cC6/9AbBjdUySOHTc8A9M9iT0LLEjl2e74M+jlaYgoUtHQa+4mskyXGoh/3hXW5BJN
 tk1hItjy8wg+B1i8A2LMzg+dwLwGB4zPVeP/U
X-Google-Smtp-Source: AGHT+IHcVR2qblVosMCFxWtj2wre9i++0U6v6vmScF3j5BRQ8hRAcCaj+lr3D+VM9W925v0QguLojciCa4nn2i92dmg=
X-Received: by 2002:a05:622a:1c18:b0:458:3be2:d2d6 with SMTP id
 d75a77b69052e-45fb0e4f093mr16493231cf.47.1728439049422; Tue, 08 Oct 2024
 18:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <20241008094646.4052174-1-jerome.forissier@linaro.org>
In-Reply-To: <20241008094646.4052174-1-jerome.forissier@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:57:18 -0600
Message-ID: <CAFLszTiDKovJh7CbEzuHDbp2e9R+ePJsZJuYiRbyzeQSdX8sUw@mail.gmail.com>
Subject: Re: [PATCH] net: wget: check strict_strtoul() return value
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, Marek Vasut <marex@denx.de>
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

On Tue, 8 Oct 2024 at 03:47, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Check the return value of strict_strtoul() when processing the
> Content-Length header as recommended by Coverity [1].
>
> [1] https://lists.denx.de/pipermail/u-boot/2024-October/567050.html
>
> Reported-by: Coverity (CID 510464)
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  net/wget.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>


> diff --git a/net/wget.c b/net/wget.c
> index b4251e0f293..a3821495e03 100644
> --- a/net/wget.c
> +++ b/net/wget.c
> @@ -256,7 +256,12 @@ static void wget_connected(uchar *pkt, unsigned int tcp_seq_num,
>                                 content_length = -1;
>                         } else {
>                                 pos += sizeof(content_len) + 2;
> -                               strict_strtoul(pos, 10, &content_length);
> +                               if (strict_strtoul(pos, 10, &content_length) < 0) {
> +                                       wget_loop_state = NETLOOP_FAIL;
> +                                       wget_fail("wget: bad Content-Length\n", tcp_seq_num, tcp_ack_num, action);
> +                                       net_set_state(NETLOOP_FAIL);
> +                                       return;
> +                               }
>                                 debug_cond(DEBUG_WGET,
>                                            "wget: Connected Len %lu\n",
>                                            content_length);
> --
> 2.40.1
>
