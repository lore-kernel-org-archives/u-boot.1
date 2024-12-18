Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF9EE77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 12:15:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2095080239;
	Wed, 18 Dec 2024 13:15:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ATDOmjVW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43F9180243; Wed, 18 Dec 2024 13:15:47 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 134EF80214
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 13:15:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-6ef60e500d7so46068827b3.0
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 04:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734524144; x=1735128944; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eKBDYIJY7KMqgdMsNAmNisj8icCCJUyCuWkga3gde3s=;
 b=ATDOmjVWkSx3XwGecEYSuHsx/2VmNk/OLaFAJwlRh9yTmLBR9cdTAxb0P4/DI+xgn9
 of9mkP84383JMzuaqFcVDy7CtMWx5onlk7ePDhzbCCDeJK4Y3cpeMW3AUTxoRzhP/XwZ
 A7QPu7W/upVBvvuipJEv2St4phslBHMiXX+/Of3qJ6185HzS1oGBoWQaArL65D7M8nCa
 jagw9LZPmkNNuB1ZvXfUMGFyzt9oCTuZc0+39HeQhUD7BJa/teLEBQvxcWaXxe1P4Cpw
 jnGys9R8LBoCW2B3YUwDfJCa7U/x01Bl8UVUjBOJByLGzTpB7uUrjX3lG/jdWT/gP4cJ
 WUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734524144; x=1735128944;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eKBDYIJY7KMqgdMsNAmNisj8icCCJUyCuWkga3gde3s=;
 b=cckVAuAwrNkrKUe31Er/CT9TMu1fqWXMfGybjYXJYZKniM9W20wfBv06EG6KYFYn1W
 PvdDHtWZZx9EzbMjWoNBIpaTYURNfRI7meSIT93oEhGD5b/NAV02rX4s13Fh1VidnIdf
 FuqTK1QcxkqEm42jvKD1DZ/A9vQsSx3czfA+OuR5k83Crs+zUZ1q6DQu5YV0zCj//EwD
 HGlCTlJUAYyso5P5RedLz+rFNgIc4zDm/RzE+uVZtx7VNb7RFhqRqScRNwYqivaXN1yY
 k9SVYPumSMbVJG/pbFhfwOM5GxS35cNnh2yS+y0Itk4kSXk5lby+aF7xS0fTlgTaPc3b
 Qchg==
X-Gm-Message-State: AOJu0YyyTng5e6tp1w1+DEn7V4vx85z/Ddkt1/lcfn7iTwTx0en9kuAs
 heS24/nBxQ7iDACbb6pkgUMldC/xsfQUPyVyc1EztR+J99Xx/t2cfB/eBTtlN1vjMNE33K0y9hp
 3uLpGMfck4IXd5ky3+upEinW4ziF0n4b6RptyNA==
X-Gm-Gg: ASbGncuYVpRUCjjnPb54BQXq2jcoa0CFLzQWN1tHkHm/o/7s5/jaa+gQwXIH2IwNpYV
 YgE4sl07AveuhE7SHtb0R8o3gjrIeWT+ypgcA4g==
X-Google-Smtp-Source: AGHT+IE1lT9YnB3lekiZ+KKXs0J4hIqfTd/O/jjDjbWb+6QZNryheRmjGppaT9j4UOv4mpnbVbOfvvwXGgqFW2jIUqk=
X-Received: by 2002:a05:690c:7489:b0:6ef:94b3:72f6 with SMTP id
 00721157ae682-6f3d26c386amr16403007b3.42.1734524143941; Wed, 18 Dec 2024
 04:15:43 -0800 (PST)
MIME-Version: 1.0
References: <cover.1734448827.git.jerome.forissier@linaro.org>
 <73f839b31900ffadcea27a6d58bd9ac5d65a9f1c.1734448827.git.jerome.forissier@linaro.org>
 <CAC_iWjJvjS7rNx+owtGPJ8cg6kQrP-spnzTSz9TjVYbErPCx4g@mail.gmail.com>
In-Reply-To: <CAC_iWjJvjS7rNx+owtGPJ8cg6kQrP-spnzTSz9TjVYbErPCx4g@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 18 Dec 2024 14:15:08 +0200
Message-ID: <CAC_iWj++BP3XPfGE=Cr+S+SMQJcopNRHS1NVbFsUASTvR+FsPA@mail.gmail.com>
Subject: Re: [PATCH 1/5] common: board: Simplify array with function pointers
 with CONFIG_IS_ENABLED
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Jonas Karlman <jonas@kwiboo.se>, Devarsh Thakkar <devarsht@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>
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

On Wed, 18 Dec 2024 at 14:03, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Jerome,
>
>
> This doesn't apply on -master, can you rebase it? OR was it meant for -next?

nvm it's on -next

>
> Thanks
> /Ilias
>
> On Tue, 17 Dec 2024 at 18:00, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
> >
> > From: Michal Simek <michal.simek@amd.com>
> >
> > Convert all simple cases where current ifdef is used with using
> > CONFIG_IS_ENABLED.
> > The change doesn't have impact on code size and it is only cleaning up
> > description.
> >
> > Checkpatch is reporting issue:
> > space required after that ',' (ctx:VxB)
> >
> > When space is there another warning is coming up:
> > space prohibited before that close parenthesis ')'
> >
> > but there is no way how to fix it that's why leave it like it is.
> >
> > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > Reviewed-by: Tom Rini <trini@konsulko.com>
> > [jf: s/Simply/Simplify/ in subject]
> > Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> > ---
> >  common/board_f.c |  49 +++++-------------
> >  common/board_r.c | 128 ++++++++++++-----------------------------------
> >  2 files changed, 46 insertions(+), 131 deletions(-)
> >
> > diff --git a/common/board_f.c b/common/board_f.c
> > index 54c48d42ee9..a4d8850cb7d 100644
> > --- a/common/board_f.c
> > +++ b/common/board_f.c
> > @@ -872,12 +872,8 @@ static int initf_upl(void)
> >
> >  static const init_fnc_t init_sequence_f[] = {
> >         setup_mon_len,
> > -#ifdef CONFIG_OF_CONTROL
> > -       fdtdec_setup,
> > -#endif
> > -#ifdef CONFIG_TRACE_EARLY
> > -       trace_early_init,
> > -#endif
> > +       CONFIG_IS_ENABLED(OF_CONTROL, (fdtdec_setup,))
> > +       CONFIG_IS_ENABLED(TRACE_EARLY, (trace_early_init,))

This looks fine and I am nitpicking but the last comma seems
unnecessary. Can we remove it, or that's just CONFIG_IS_ENABLED()
works?


> >         initf_malloc,
> >         initf_upl,
> >         log_init,
> > @@ -885,16 +881,12 @@ static const init_fnc_t init_sequence_f[] = {
> >         event_init,
> >         bloblist_maybe_init,
> >         setup_spl_handoff,
>

[...]

Thanks
/Ilias
