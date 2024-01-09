Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F3C0C46CD2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 14:51:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1857D8786A;
	Tue,  9 Jan 2024 15:51:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="i4jc5lwO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DBBE877FD; Tue,  9 Jan 2024 15:51:00 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 769E0877FD
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 15:50:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40e4f692d06so4416405e9.1
 for <u-boot@lists.denx.de>; Tue, 09 Jan 2024 06:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1704811858; x=1705416658;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=mlNQWJOtY73Lx51nmFn9lOGGMmdqVQbVocpylY0zP6s=;
 b=i4jc5lwOGACXADn741DZ74n6fkpHAymJLR87H++cUDmF4h3uVK+9uJfzGoQtX5XoK5
 QCRMYvIXQ5B37fMypjyg7JEADSrg0wZCr3vgnO7qfuk4cMPSNl8sgv7sBFcs+A5dPVjc
 fgyjQsDfg8w4GI7sBGMUbvgjF0VPQtmndMU0Fsm1Gh8YnEk59kJVXokSBlxvJ2F4rTpl
 riKDlxc3QGUnn+UMTvVXinSDv4IObc/FRL5g7J82cE5NClQQUxEzI1+Gj1V9vH/FQ6qU
 Q/GbFS0PDTvILf8nW7Ysx6SlSVBGpHpGWnbORCC/Vu0nhqjY/QJnHLNLiyIaaqsFvfpG
 /HpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704811858; x=1705416658;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mlNQWJOtY73Lx51nmFn9lOGGMmdqVQbVocpylY0zP6s=;
 b=fqd1KRGkA+vYA2+HwROl3lPN4Qxjf9k1uQeyRxzcpuXMC+CgN2DJxsYv2g7RckiB+8
 IT93aLSudLL6LMFNvMPdCqEp07TPeuhiEq5BRVIfk6NmgSFz0TPiU4oW4EsLTnfEUflX
 ZpLzWhMfILzr7liz3tzXd5vBtoH5ZZPPjOkH4Xu1daJuNYsjYN+OPe9dgy1qWEKo+czY
 FFDTgtKNrM/5HrbKtLlTYlAFK3sCgv5iM8p8uGs0Jcwij0lbxZSuI4f/4EPEySpmbN9w
 6hLHywu4ImnRo/hbFix2DGwb2zRD6FdfTmSr+cLdiKWcT24xjgC+cuc4++VOE6BU2TnF
 oEoQ==
X-Gm-Message-State: AOJu0YxNndhInuYjWc9g4KZSFat/x68fLuQ5OdQSukQOLxJ51k4gC8uh
 Tgx9F1CqLpBIFO0ug+6cFv89nT5tYSRqFQ==
X-Google-Smtp-Source: AGHT+IFAcZdXtbkwRxjX42UuwB99KtDuQikv4AwY/maig/3CLivwFOuBI8sAh9VOFFEbuG63dY7POw==
X-Received: by 2002:a7b:ce0e:0:b0:40e:4f71:5c3b with SMTP id
 m14-20020a7bce0e000000b0040e4f715c3bmr519789wmc.93.1704811857856; 
 Tue, 09 Jan 2024 06:50:57 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 n33-20020a05600c3ba100b0040e398f8cafsm3872492wms.31.2024.01.09.06.50.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 06:50:57 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Grzegorz Szymaszek <gszymaszek@short.pl>, u-boot@lists.denx.de
Cc: Grzegorz Szymaszek <gszymaszek@short.pl>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Maxim Cournoyer <maxim.cournoyer@gmail.com>, Simon
 Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] doc: fix three-dash references in reStructuredText
In-Reply-To: <ZZktRm3O89FnozlD@nx64de-df6d00>
References: <ZZktRm3O89FnozlD@nx64de-df6d00>
Date: Tue, 09 Jan 2024 15:50:56 +0100
Message-ID: <87a5pewofj.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Grzegorz,

Thank you for the patch.

On sam., janv. 06, 2024 at 11:36, Grzegorz Szymaszek <gszymaszek@short.pl> wrote:

> The "Sending patches" and "Patman patch manager" documents refer to the
> three-dash, "---", that separates patch parts. The symbol is written in
> the documentation in the same form as it is in actual patches: as three
> U+002D HYPHEN-MINUS characters. When building the documentation, Sphinx
> converts this symbol to a U+2014 EM DASH, that is invalid in this case.
>
> Make the three-dash symbol a reStructuredText inline literal to prevent
> its conversion; that is, enclose it in a pair of double backquotes (`).
>
> Signed-off-by: Grzegorz Szymaszek <gszymaszek@short.pl>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  doc/develop/sending_patches.rst | 4 ++--
>  tools/patman/patman.rst         | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/doc/develop/sending_patches.rst b/doc/develop/sending_patches.rst
> index 5a6962f102..3f25b1d046 100644
> --- a/doc/develop/sending_patches.rst
> +++ b/doc/develop/sending_patches.rst
> @@ -121,7 +121,7 @@ General Patch Submission Rules
>     * For new features: a description of the feature and your implementation.
>  
>  * Additional comments which you don't want included in U-Boot's history can be
> -  included below the first "---" in the message body.
> +  included below the first "``---``" in the message body.
>  
>  * If your description gets too long, that's a strong indication that you should
>    split up your patch.
> @@ -253,7 +253,7 @@ to observe the following rules.
>  
>  * Please make sure to keep a "change log", i.e. a description of what you have
>    changed compared to previous versions of this patch. This change log should
> -  be added below the "---" line in the patch, which starts the "comment
> +  be added below the "``---``" line in the patch, which starts the "comment
>    section", i.e. which contains text that does not get included into the
>    actual commit message.
>    Note: it is *not* sufficient to provide a change log in some cover letter
> diff --git a/tools/patman/patman.rst b/tools/patman/patman.rst
> index a8b317eed6..e01355824c 100644
> --- a/tools/patman/patman.rst
> +++ b/tools/patman/patman.rst
> @@ -280,7 +280,7 @@ Series-notes:
>  
>  Commit-notes:
>      Similar, but for a single commit (patch). These notes will appear
> -    immediately below the --- cut in the patch file::
> +    immediately below the ``---`` cut in the patch file::
>  
>          Commit-notes:
>          blah blah
> -- 
> 2.43.0
