Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A3EE95A77
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 23:10:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 653A58652F;
	Sun,  8 Oct 2023 01:10:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="fzDM2ks3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D450386568; Sun,  8 Oct 2023 01:10:34 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18EC5864F3
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 01:10:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5a22f9e2f40so39273487b3.1
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 16:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1696720231; x=1697325031; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FjHlWI/IZGDIEtjhMhfaCuOoZe1G+i1WoqLL3qSIlDY=;
 b=fzDM2ks3VId6Rs02XQay8D15YkmE9Vz0GYNZ93cW79DeZSkEBdmMiu9+mkOvylv9OL
 08isDl6O+gBBqfQQwy44fh9K0TJOkmXw0/pcu7blPoeeHIfkbh9VGmA1CZXZJhNqj+9/
 mLqQInM0kfVO1bzN1ABMJ4hJ5VwV2s982FQTj3lIeK3xig9ZU9cRu9dJVv8Y31WO/gaa
 cZ8cN80jo8FIWLMOTulEdTcuOccWhgVL9oV3Ff8QkNRkd7keTMwanJ8cWeEXoopR4kM4
 OUxzuVwZvKvQ9h3qF0erHgzTUb4i7lfEWzVxcsx/Cr+8gcpfAiVfB6rutlyvv4JPVhMW
 jqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696720231; x=1697325031;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FjHlWI/IZGDIEtjhMhfaCuOoZe1G+i1WoqLL3qSIlDY=;
 b=gZBZ/E7B+tYSSo5eAG6VvwKsCC7+4uUp88pWMrkXI+JTaThL3moIWIz8D1JhmU4xNR
 7fyuxk56SPfRLwoys6h8pINeEOfcgB40wTkUZw1KwFgE6eDijkbTnKI+IxFR2og4M61u
 ba9c+vFa2ufDwm7WsCyLn1DcS+1sNvpCrPPo71Z4QOWtD0pFmwud0FQW/LSa1qKzVCB2
 tagxQuZxzz6LgammUI+ShQYYsWXYfcmvwEBYaYmFQJTfrNPycEQW15hSkE7Dqkp1wCn5
 h/Ac5wS3zQ0ENElkadWmu0t/fNDx/VePj1pNtfub/Vlvs4lL27hQN3hh8wAfAxRF1Q1i
 qLAw==
X-Gm-Message-State: AOJu0YzLtDTYNdM+PnDUpjHLSjFsYKctbmCxdtxQMlnUenYJNQDD8axu
 MZZpisNON+LqpauYBCMblx+8rknyyYOgGP2dnOeDcQ==
X-Google-Smtp-Source: AGHT+IEbZ0QtDZ9RBOlSHJcWzvb0v2Dzj7nbxc6YHaIUknp2psXJcWLZ/Bc/1qaAe7pWFwF8EcnA3shaoFe95mFBiWY=
X-Received: by 2002:a81:83c3:0:b0:59b:1b87:a95b with SMTP id
 t186-20020a8183c3000000b0059b1b87a95bmr13302860ywf.20.1696720230568; Sat, 07
 Oct 2023 16:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <20231006213329.03aad5f5@monakov-desktop>
In-Reply-To: <20231006213329.03aad5f5@monakov-desktop>
From: Simon Glass <sjg@google.com>
Date: Sat, 7 Oct 2023 17:10:00 -0600
Message-ID: <CAPnjgZ0Ka-1n_DfqAU_UxSq_9T5NCairDqhw8=o_qFtqqUG+vw@mail.gmail.com>
Subject: Re: [PATCH] cli: Consume invalid escape sequences early
To: Yurii Monakov <monakov.y@gmail.com>
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

Hi Yurii,

On Fri, 6 Oct 2023 at 15:32, Yurii Monakov <monakov.y@gmail.com> wrote:
>
> This commit fixes some issues with extra 'Esc' keys entered by user:
>
> 1. Sequence <Esc><Esc><Enter> right after autoboot stop gives:
> =>
> nknown command 'ry 'help'
> =>
> 2. Sequence <Esc><p><r><i><Enter> gives:
> => ri
> Unknown command 'ri' - try 'help'
> =>
> 3. Extra 'Esc' key presses break backspace functionality.
>
> Signed-off-by: Yurii Monakov <monakov.y@gmail.com>
> ---
>  common/cli_getch.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/common/cli_getch.c b/common/cli_getch.c
> index 61d4cb261b..0ee7908777 100644
> --- a/common/cli_getch.c
> +++ b/common/cli_getch.c
> @@ -46,6 +46,8 @@ static int cli_ch_esc(struct cli_ch_state *cch, int ichar,
>         case 1:
>                 if (ichar == '[' || ichar == 'O')
>                         act = ESC_SAVE;
> +               else
> +                       act = ESC_CONVERTED;
>                 break;
>         case 2:
>                 switch (ichar) {
> --
> 2.34.1
>

This is a bit unfortunate. Basically the problem (as I understand it)
is that characters are built up for processing so the expected ichar
== 0 is never passed in.

I think the fix is reasonable. Does it work as well if use:

               else if (ichar == '\e')
                       act = ESC_CONVERTED;

?

Also please can you add a test case o test/common/cread.c

https://u-boot.readthedocs.io/en/latest/develop/tests_sandbox.html

Regards,
Simon
