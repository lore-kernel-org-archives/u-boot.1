Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF16CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 14:41:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B018865A8;
	Sun, 15 Oct 2023 16:40:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="cF/3TvjW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CB4F865A8; Sun, 15 Oct 2023 16:40:48 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F136886529
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 16:40:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9b95622c620so638058566b.0
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 07:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1697380801; x=1697985601; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6bwQCEEKgZav3FERCenSxhvwqsES9Clty+YQiA1gRQc=;
 b=cF/3TvjWwGEaPA9mK1lC21TXttMgCspbRVt72hTEsfTdksVXE7r5+q/aqDfmtoVUOQ
 EYOkGRL276sqO69GpU7SJY9HGj2v+N7ichYoJkDEBYKx3S6ttDUhLGjJuWQ65ufHra8V
 pdGLxHfkxqD4mvVvX3cHIV6I5HKyKtTabdG0Jd1VJdj57OEoqVZGrZfcMb/r9lrabkez
 OBOzdLZ780X56/PJ1Yl/Qla/fP42WDsNDEAITE2RwN+Lu0rWzVOWUjiuodG/0j1Ojkms
 wdkiv7QE5RIh5i4qkMh9+DbFz8TLWB2Yf1JzVg+rXh6oaG7OD1vE393w5lVfk2OzVwPy
 GsGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697380801; x=1697985601;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6bwQCEEKgZav3FERCenSxhvwqsES9Clty+YQiA1gRQc=;
 b=g5eEtyvZA6TDuTa6J2zVd3q28E22g7djX+xy8PblSF/UJGUeBxB0go6Ob35aMSRh+E
 /CZalV49Q6OoZHMk6qITwdIY3q0E88Ri8aLog6w7wZ8kUkNQCQjvK20DJ/9bBs83grcK
 Wby7vIV6IirfL8XyiDBsCxxfxRfr/Y8Rrr0sYsgl9FEDnhhP/4a+2kszo398KDJGlBTE
 N/S9o5oyYGE2EDVlsLx+rU+8yGdANaOXO8rMDJRIjzjAayHNUs+tl7CQl16TCR+pts8R
 04glWBFCjW4HeeYNF+y0dbZ2XycapwYO1i3yuZ8Uzx9YLrRZ2wS+0f6eyY+3qR4P0deZ
 sA8Q==
X-Gm-Message-State: AOJu0YzmNy/2J906Szqje6a9TqMuYvP3m/u4B5RWj5YFGGy7c/+2KZaX
 fro0hkXL9caXRGK3d1GlfrVjC4sez18OzMmKNG6MNfO5UuuIcj/a4pI=
X-Google-Smtp-Source: AGHT+IEnhMnyqYHYs3kM7b65QkBaKNOdGdV7uHctnCjUaNShTuoRQHrOEjhZs9dzzElUM2hVBAbD859sNjqYnLjidHk=
X-Received: by 2002:a17:906:7387:b0:9ba:a38:f2b2 with SMTP id
 f7-20020a170906738700b009ba0a38f2b2mr18849404ejl.41.1697380801179; Sun, 15
 Oct 2023 07:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231007191308.2222470-1-trini@konsulko.com>
In-Reply-To: <20231007191308.2222470-1-trini@konsulko.com>
From: Simon Glass <sjg@google.com>
Date: Sun, 15 Oct 2023 08:39:44 -0600
Message-ID: <CAPnjgZ0wo3pcTOgJ+9s53kNwnuxK0pHApmJbbmv7eJe_XDhrAA@mail.gmail.com>
Subject: Re: [PATCH 1/2] command.h: Add a U_BOOT_LONGHELP macro
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

Hi Tom,

On Sat, 7 Oct 2023 at 13:13, Tom Rini <trini@konsulko.com> wrote:
>
> In order to be able to discard unused long help texts without further
> linker lists, add a macro for defining the long help messages which uses
> __maybe_unused.  This allows us to discard them as unreferenced as part
> of the link.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  include/command.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/include/command.h b/include/command.h
> index 34ea989b39b4..a836ea795ab6 100644
> --- a/include/command.h
> +++ b/include/command.h
> @@ -322,6 +322,9 @@ int cmd_source_script(ulong addr, const char *fit_uname, const char *confname);
>  # define _CMD_HELP(x)
>  #endif
>
> +#define U_BOOT_LONGHELP(_cmdname, text)                                        \
> +       static __maybe_unused const char _cmdname##_help_text[] = text;

I just noticed this...do you really want the ; at the end? The only
purpose I can see is if you want the macro to compile to nothing.
Otherwise it is more normal to put it on the invocations, isn't it?

> +
>  #define U_BOOT_SUBCMDS_DO_CMD(_cmdname)                                        \
>         static int do_##_cmdname(struct cmd_tbl *cmdtp, int flag,       \
>                                  int argc, char *const argv[],          \
> --
> 2.34.1
>

Regards,
Simon
