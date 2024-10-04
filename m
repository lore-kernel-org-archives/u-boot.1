Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61453CFA749
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 06:12:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBC3688A0E;
	Fri,  4 Oct 2024 08:12:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UvCgS90S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DFEC88FE3; Fri,  4 Oct 2024 08:12:07 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3B9C88FAF
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 08:12:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2e09fe0a878so1307804a91.1
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 23:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728022323; x=1728627123; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vuGMIgMa0HjIW6TI0gkGBb9CFzueAG68RbqfwgXk9GU=;
 b=UvCgS90SZMrzby1NYJESBGhWxMXp6aZXcz5i+HTe3BM9IGsjhNOGQCFMSySrL3L4os
 OQ9Je57AxHrKs+RYNxvAsGhAiv+L+KlKz6nbUnd/Kurj/qclZEXCUW4EK0c51bef/ylz
 ueSc/py6qW14d/K5v8Gamplyv8SSTMWWZziZyLziSZOiXJTxMV18tvif9FeK3hkKu/sm
 pfR3TveYAF0Gjak48Zy4CpyYL77+ZkoD0jZVHBPSU3liu4XpR/OBSAw2wV5ZYn9kDRS7
 wfVw8vHL6X4ir35zqK8NG6zDa1CMe0sucglm+VFTgCG1JY5XMNSXc+uVMRcCXTbYQMLA
 rqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728022323; x=1728627123;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vuGMIgMa0HjIW6TI0gkGBb9CFzueAG68RbqfwgXk9GU=;
 b=qcWp/NRbhWiMwHQyQhwTYcQqp1W9YhblmUh/aoOF/Hvfq4qvLieOfUvIDGGfzZq61g
 rwRn7a++C7hkIyAhRQLg/5g2xw6gQ2H0JXkW5eKcMLGkSIe8AeIIXkb1KgNQFPHb7i23
 aPCu+HDx96MLO7jJOYLq3YSm4hl/HG4xvWqY5U5WSlmoc+sU9SyHQN5B00fP9VUTWH6n
 U0okSenjplKNOIjU/WVAF2oEgCtPfyM01rW7a9aUEXmNffAN5p0upIKB6fBJfn+PBl6l
 VrpnutkP2Y+dARb8xH6UippxKxygRL3FWxWApDvj/JRhf6dYPz9erapNCayPkXP3ozkX
 VNYQ==
X-Gm-Message-State: AOJu0YzZAjhM465iBDvEdg0xvWq0uDVsuTyAWaPvig/hIr57recktbgJ
 PX10dEE70F5OsiVlq5Ng62pLZyNxA+nQ/kssYVVh0QC+c1oQH6Tlgp8CahPgJTM5VGI+OYx12VC
 gcZrQebCauknBLZmPk1Q1HgXLZvTwiHNfQf3Qbb7YDda6cvaoKss=
X-Google-Smtp-Source: AGHT+IFIXDaEyHnMzhwfLU+Jgs9zqJYEgB7wUppqORaYkhpgcig+JhZZfhxyOBJ2OOgTCdbWgH59zcBK8xjovcdcjDM=
X-Received: by 2002:a17:90a:458b:b0:2d3:d09a:630e with SMTP id
 98e67ed59e1d1-2e1e6212e23mr2176065a91.1.1728022323273; Thu, 03 Oct 2024
 23:12:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1727968902.git.jerome.forissier@linaro.org>
 <c29c2aa6fc0f1a97afff121e2f42abcac5b671f2.1727968902.git.jerome.forissier@linaro.org>
In-Reply-To: <c29c2aa6fc0f1a97afff121e2f42abcac5b671f2.1727968902.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 4 Oct 2024 09:11:27 +0300
Message-ID: <CAC_iWj+Q9VSVPqGBveYm5+PYQXm0CKRg5==z=VJPd0G4-7U0ug@mail.gmail.com>
Subject: Re: [PATCH v11 14/29] lwip: tftp: bind to TFTP port only when in
 server mode
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

On Thu, 3 Oct 2024 at 18:47, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> The TFTP app should not bind to the TFTP server port when configured as
> a client. Instead, the local port should be chosen from the dynamic
> range (49152 ~ 65535) so that if the application is stopped and started
> again, the remote server will not consider the new packets as part of
> the same context (which would cause an error since a new RRQ would be
> unexpected).
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  lib/lwip/lwip/src/apps/tftp/tftp.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/lib/lwip/lwip/src/apps/tftp/tftp.c b/lib/lwip/lwip/src/apps/tftp/tftp.c
> index ddfdbfc0c1b..74fc1fbe586 100644
> --- a/lib/lwip/lwip/src/apps/tftp/tftp.c
> +++ b/lib/lwip/lwip/src/apps/tftp/tftp.c
> @@ -454,10 +454,12 @@ tftp_init_common(u8_t mode, const struct tftp_context *ctx)
>      return ERR_MEM;
>    }
>
> -  ret = udp_bind(pcb, IP_ANY_TYPE, TFTP_PORT);
> -  if (ret != ERR_OK) {
> -    udp_remove(pcb);
> -    return ret;
> +  if (mode == LWIP_TFTP_MODE_SERVER) {
> +    ret = udp_bind(pcb, IP_ANY_TYPE, TFTP_PORT);
> +    if (ret != ERR_OK) {
> +      udp_remove(pcb);
> +      return ret;
> +    }

This should be sent to lwip as well right?

>    }
>
>    tftp_state.handle    = NULL;
> --
> 2.40.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
