Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D0D7D59D80
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 00:32:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07E638922D;
	Tue, 26 Nov 2024 01:32:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E5XAnjuy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B63888BFB; Tue, 26 Nov 2024 01:32:50 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BE8D8922D
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 01:32:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a9aa8895facso816860566b.2
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 16:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732581168; x=1733185968; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+zNZqzRX+sxFhq+teLewyeIox16A/cj1vgQ/zFYCoDk=;
 b=E5XAnjuyVRnupp5ku3AOCNp8f1cO5xMIPceRDL4yuGKLddJxCf96qk0/P+sL1Yc2fS
 I6sd/lu2uJnjEIupkG4N+5qI3JycU0E4+Ot44+p5XZzEy1Jyn4r7bkvyuIk+TN4cpxm8
 963099iqkjuxFNlXsTFT5eBwHkEWLnhGrN1wA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732581168; x=1733185968;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+zNZqzRX+sxFhq+teLewyeIox16A/cj1vgQ/zFYCoDk=;
 b=dS7Nf7TCbZWmuEHIrXhk9WJ9MU2BpgByIrijHfpKQ62bKniLOEoTzHGwfp1R/P/at4
 D6xfnE7jIZbhDNWXD9UedqAv8+/3Uyzu0XwvDHEF4gCrOsUwiw5xT2b7g1IiaZt1g5Mb
 pEHThmqQg+m2Gk1zVvcNC96hfuIGFrtN7kgQ2fSUsRMrbbeJv5DJUJJsZYjzAy5z2eE0
 iesh7uemzXtIAfkPu2ESEEwEtgAA/YaqlEDXVA92DdZt0LlIrJpd83HH7S2/iwK3zZqU
 to19gynsGyYEIvU2/s32NHTGSMCsYP7k/CbXnJMvveYYrbgWhzYSp/sWrvfZNmqC/BKN
 LqeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUY/Fkl0jVnf73fKeTp0INMMxr+IX3oFMEce8T0aDXCvNdupH06RxGZHch/t8quXyzZn7rqe1U=@lists.denx.de
X-Gm-Message-State: AOJu0YzDZIRH+FIhuX2y/fwLti6k9vJYkVlDnO+nQFn22T1sX3JkuBVj
 zHL43ZdwtB8IIYITHj72lkmxTwQFH27cPc2XQRXCkRDxQyh5Wim4+taExTZxH1KmtkZJoBnOeOD
 Qdepbn1z0V6B6tvpNHgTTNq4zfc55MeLpk9Pp
X-Gm-Gg: ASbGncux1pW70DoO5NFn/cO0H/DGKfVGwyJA8K2ZGcbmLdZB2moaAOZVXjnTLV/l4Ek
 vSzS0y+UL9HSfZWzlovN4K3VlxWGqeb0=
X-Google-Smtp-Source: AGHT+IHJq0hOaiEji1Zk1DJG4ollP7DeX6uMbwsjavoiceVM3JJc7Z10lD2eguT6GEgopUgiJ0IDijzY7urQvF26Zhs=
X-Received: by 2002:a17:906:318a:b0:aa5:3fa9:e90c with SMTP id
 a640c23a62f3a-aa53fa9efbemr692364866b.32.1732581167829; Mon, 25 Nov 2024
 16:32:47 -0800 (PST)
MIME-Version: 1.0
References: <20241124183832.2476928-1-caleb.connolly@linaro.org>
In-Reply-To: <20241124183832.2476928-1-caleb.connolly@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 Nov 2024 17:32:34 -0700
Message-ID: <CAFLszThqtA_WBxOU-EnEvw956ZMN9KErx_C4gTzW_+p_tGu9qw@mail.gmail.com>
Subject: Re: [PATCH] common/board_f: init malloc earlier
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Devarsh Thakkar <devarsht@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Raymond Mao <raymond.mao@linaro.org>, 
 Richard Weinberger <richard@nod.at>, 
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
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

Hi Caleb,

On Sun, 24 Nov 2024 at 11:38, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Currently the early malloc initialisation is done partially in
> board_init_f_init_reserve() (on arm64 at least), which configures
> gd->malloc_base. But it isn't actually usable until initf_malloc() is
> called which doesn't happen until after fdtdec_setup().
>
> This causes problems in a few scenarios:
>
> 1. when using MULTI_DTB_FIT as this needs a working malloc (especially
>    for compressed FIT).

Hmmm, how does this work today?

> 2. Some platforms may need to allocate memory as part of memory map
>    initialisation (e.g. Qualcomm will need this to parse the memory map
>    from SMEM).

That really needs to be tidied up. When does this fixup need to be
done? I imagine it is somewhere prior to setup_dest_addr() ? Perhaps
we could introduce an event to do 'memory map' stuff?

Regards,
Simon


>
> Move the initf_malloc() call earlier so that malloc is available during
> fdtdec_setup().
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  common/board_f.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/common/board_f.c b/common/board_f.c
> index 98dc2591e1d0..bddfa6b992b9 100644
> --- a/common/board_f.c
> +++ b/common/board_f.c
> @@ -867,15 +867,15 @@ static int initf_upl(void)
>  }
>
>  static const init_fnc_t init_sequence_f[] = {
>         setup_mon_len,
> +       initf_malloc,
>  #ifdef CONFIG_OF_CONTROL
>         fdtdec_setup,
>  #endif
>  #ifdef CONFIG_TRACE_EARLY
>         trace_early_init,
>  #endif
> -       initf_malloc,
>         initf_upl,
>         log_init,
>         initf_bootstage,        /* uses its own timer, so does not need DM */
>         event_init,
> --
> 2.47.0
>
