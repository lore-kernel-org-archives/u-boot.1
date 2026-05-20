Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36F3CD4F54
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 20:41:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55D5484707;
	Wed, 20 May 2026 22:41:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MgVUu67h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAD048470E; Wed, 20 May 2026 22:41:19 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0788A841D7
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 22:41:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-bd2087858c4so1150705666b.0
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 13:41:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779309677; cv=none;
 d=google.com; s=arc-20240605;
 b=aKD0MDjr/mFvZEbwYuGONwLmdawdVKEfSLVLUkSVOgQ8zaTOcnSRdNTstI3O+CFPzR
 NhUr0gtEgmzGoyKfjSaZgnLbIZdeWgcDq6xmguAIeCd9pCJeImUF7HAXd3JeIEbXv7CH
 edUOVRQQW7XAo6UJKf8B5zI+8DOdWrVJBJl4UbP6XiM17B400Ml2rGtEJZg5ZKX3/GAq
 690HPBD/ZjpVo0rHURSjK7+RHBCUAynllMCen7t03Xb1HkTWMX0LbCPYBMsD/EucX/6T
 X7//iCYqYKd550VsS9G0h2p4OCyjp8HYdNfZEupa5lU5OPBwTKIWlFwKGn/xfCQuc8I8
 GHag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3a+k4f4nDBFfzuyRl218G+7VFTr7ZIPsgyESGiYL3IA=;
 fh=XDQ4511iSd3tg4VokEtBPEEdWZ4AfGFIMtZAB7YN+QM=;
 b=jlQdBk1rJtnPxS29mDv8dfsdX86UKHeiaoGknlH9YR345251EB+Io75/JLfZMtpAXQ
 25qTiD2rgvNnheEcjJwiaUl/XJpcj0qRcT8hgat4Tkl91z83nnqa5E012v2LIUDJNVLd
 Osb5A74Qf4dGib/j7RVBZ51D8jZx42FVv0b5nJLrQ3j7WU9C4yK5MkLt0ls55FQ820fo
 9QE4Oq1YgvgPQiruspSqEd5KynL2s+lw4NX331I5OWbEuYTeDnVPd8pCsSnDqSEBVgys
 C2gObKwy7/F2UBLEimzAKspqfiPq8wvAxWxFCA4D7MehTPJriCY6xecfoxH+wQ8m5w+7
 xi9A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779309677; x=1779914477; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3a+k4f4nDBFfzuyRl218G+7VFTr7ZIPsgyESGiYL3IA=;
 b=MgVUu67hB9DGeQQYBkxRPMq/Pj8NTYsSQK/bQ8PyXyiHLrBug15gyMJC0GdQy8pAHJ
 X/G8buCKevmBXCiK1bjRcYv9yWJnBj2quCkx5mFBTN5TYBT+xQxzGU1zdW5Xif6yzM9l
 GopFq/+DXtFUmkNuej308uY7VoVUDU6/fq4cU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779309677; x=1779914477;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3a+k4f4nDBFfzuyRl218G+7VFTr7ZIPsgyESGiYL3IA=;
 b=IYT4Mc2tRf65LyyxhikTblRIJyTQpGaBkifOG7+DwWDG4C0t1VQWbtDWq28K9ZvZYp
 qGJ13cTbhSdhiJ+3KqRnU5g1P7XuERDJvPXWiT3f0746PNx7tsEPnCY2rqcS1yOv5Jkn
 CNXs/RcW5fmuXts3gG7Ecw1yKQCLq94CNB5S1Obozjkrwcqvx+0SD5amBVsitj8g0mpc
 QhZ8cO1vWL5sag7GkupW3gzIEQzW0IGQtIIbS1YCZcIWuOunZOjPqOMxvY3yCg82Poyr
 +RFxZlp4VFTAtFPOv7uoOCfbJ2j+7cWrQF+xqvsaTagISYY4T2nlYw8KUv1gzgv0Ottk
 Oycw==
X-Gm-Message-State: AOJu0Ywlm2EJLHKc/H2z0QF1p6CJJ3w8QRVsgqSE2ODPrGD8SYLfyiM+
 SH+mjfnem+3Em4SAkzT7yCDZjPUKGwL6zDg1kP8N6Tx6PAXXnQcblDhfrGmVCxkdu6w8NeYrPMW
 PA09QNYErQDRJfLrKWMY3W8CmjIaK0B9+pAtaaGfDnKxhQKTuJFBf3z5+
X-Gm-Gg: Acq92OE3G1IXLIceMLdqP5uwQUs/b/tPffQLpqKGRnlnIscvKq0wohgAciplDHdSWSc
 j5pLdFvBvaNPUnuMPpbRbcAPoiH0BtM14sRgQDpj9UbmPXV7rHxLIR8qgeFl6ALzk+VRxIEpZRB
 z7TAXl7y+gvliv/7aXjwBao5U202QOVTivRivTqzpUUJ9pK1zhh6yJL2uupLuprymJPBGffP9bq
 Xgt9FZyUsTcUzJrfG93dDsFK/pnhU4fDbP1n+ETOB5+fr9nbkRQCN2Rx2LKHJzU+/qq2YKVqxfd
 664BEg==
X-Received: by 2002:a17:907:a1a4:b0:bad:f032:fc78 with SMTP id
 a640c23a62f3a-bd51777c836mr1038481666b.1.1779309677374; Wed, 20 May 2026
 13:41:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260515203311.2555651-1-sjg@chromium.org>
 <20260515203311.2555651-7-sjg@chromium.org>
 <2ca02f73-20b9-22fe-5ec3-97c56c0f11bf@gmail.com>
In-Reply-To: <2ca02f73-20b9-22fe-5ec3-97c56c0f11bf@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 May 2026 15:41:05 -0500
X-Gm-Features: AVHnY4J8svt9-aEfbeH9pjNsMSk_GES2lLaL3KvZswSG7HJ4Do_ANR-jswuAvuw
Message-ID: <CAFLszTjKn5Zoj54yM+9yaHN_SKSPf+EgQ_j70pE6qSFKApuTRQ@mail.gmail.com>
Subject: Re: [RFC PATCH 06/11] lib: getopt: Add getopt_pop() helper
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

Hi Sean,

On Fri, 15 May 2026 at 15:40, Sean Anderson <seanga2@gmail.com> wrote:
>
> On 5/15/26 16:32, Simon Glass wrote:
> > Callers that consume positional arguments after parsing routinely write
> > the same shape:
> >
> >      algo = gs.args[gs.index];
> >      /* advance past algo */
> >      return hash_command(algo, ..., gs.nonopts - 1, &gs.args[gs.index + 1]);
>
> I think it's better to be explicit.

Do you mean that you don't want a function for this? My goal here is
to try to reduce code size by turning common operations (here, getting
the next arg, later perhaps getting the next arg as hex) into
functions so we can share code.

More generally, we should start to think of arg parsing at a
higher-level, so that perhaps one day (which a fuller arg description
for each command) we might end up with something which parses the args
in common code, thus allowing commands to just use the args.

> >
> > Wrap that in a small inline helper that returns the next positional,
> > advances gs.index, decrements gs.nonopts, and returns NULL when no
> > positionals remain. The same helper doubles as an iterator:
> >
> >      while ((arg = getopt_pop(&gs)))
> >          process(arg);
> >
> > stddef.h is now included from getopt.h for the NULL macro.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >   include/getopt.h | 23 +++++++++++++++++++++++
> >   1 file changed, 23 insertions(+)
> >
> > diff --git a/include/getopt.h b/include/getopt.h
> > index 5a9e7802e65..013431807ff 100644
> > --- a/include/getopt.h
> > +++ b/include/getopt.h
> > @@ -10,6 +10,7 @@
> >   #define __GETOPT_H
> >
> >   #include <stdbool.h>
> > +#include <stddef.h>
> >   #include <linux/kconfig.h>
> >
> >   /**
> > @@ -126,4 +127,26 @@ static inline int getopt_silent(struct getopt_state *gs,
> >       return __getopt(gs, optstring, true);
> >   }
> >
> > +/**
> > + * getopt_pop() - Take the next remaining positional argument
> > + * @gs: State, after getopt() has returned -1
> > + *
> > + * Returns the first parked non-option (``gs->args[gs->index]``),
> > + * advances the index, and decrements ``gs->nonopts``. Returns NULL
> > + * when no positional arguments remain.
> > + *
> > + * Useful for consuming positionals one at a time after parsing::
> > + *
> > + *     algo = getopt_pop(&gs);
> > + *     return hash_command(algo, ..., gs.nonopts, &gs.args[gs.index]);
> > + */
> > +static inline char *getopt_pop(struct getopt_state *gs)
> > +{
> > +     if (gs->index >= gs->argc)
> > +             return NULL;
> > +     if (gs->nonopts > 0)
> > +             gs->nonopts--;
> > +     return gs->args[gs->index++];
> > +}
> > +
> >   #endif /* __GETOPT_H */
>

Regards,
Simon
