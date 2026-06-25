Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B6A5CDB479
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 15:30:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B45BE84962;
	Thu, 25 Jun 2026 17:30:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Jt8Dm/1A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91920846F4; Thu, 25 Jun 2026 17:30:30 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1166084962
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 17:30:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c12180b4117so60831966b.3
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 08:30:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782401427; cv=none;
 d=google.com; s=arc-20260327;
 b=MKAxciSCGIQZ+ebvvUD1VaGv6BDCmkzBA3zBlNKLOotEOJrCRpsnjGgADfYA3P+3mb
 w5v7RPL6BlOVhgDb0QdKJxfGIv35RIrx5oeLrjE98K1hJrTb3X5TSdfvwlYhJ0FhJP3x
 kO5d6Zd1rPpya4c6yzPahJzWjL97NMkZRGW8A0iSEx7YUbjbFzCw+vXsSODanErG6/UM
 q0ZDyaq3itORZZyir9tnklC8a1RgqckaYIO2HnM4aC9rmt+2vSZlJA+F3nFBMhiv2FwM
 PKPeXvuiim5+dxZ77gxgOhCCSxEdsBy+sr/sx+EgOjQXU+WFiZ4JT0XcsL5IcLelVJrK
 o0vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=E7Qkkmv4zX4aivauKesFupLvPudgvHMLQomamrtSRAU=;
 fh=aR7hUKKh2HNrGYKdSC4xLsytBE5cNispTjSDyWyCqOE=;
 b=E0MOA9VBbWhaZMBpRwsNlqatucCBV/IsFREjuYHtNr7uvdMb3LIlbfqtZwhhqjx6F7
 SCNwYqHdTVXhx9qlur63LLrvqPOMEmJLubGUwa0hVWBNd5ZmwAVjpsvyuuwvE+3svRmv
 QqA1I6DepQAKb2JCfUdYB2c2hNIL8ayKT/pcLwC5zrZ6HYGTi73Tz0BDALIVxbbc/W0b
 srQ5qmnzqPOJ12urOVhdl4qabbYUqZS99X1X7HKG3mhvzGVIOrXcdazdLS3uijk6L8DW
 lZv4YQ86ph2O4TWiSG0ju8uwZDhUJpS9Ks6letQ4OWytu+m7FJ28N7DGo/0i75luuvxV
 G2Pw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782401427; x=1783006227; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E7Qkkmv4zX4aivauKesFupLvPudgvHMLQomamrtSRAU=;
 b=Jt8Dm/1AE8QpAF2fsjMKytCfx/iIaEGGQU9yzqm2ftKESYS/OlyccrSBAwFgbu73Nc
 yoo0WIoaXfPkLeNJK6CpVi3nkh2rV0GJqcDxYwlG7K+Ymj1T1tbLpHcV/MB9O35Vof50
 7SujxbPpC7llkmSPo1OWTfDnrDimDOg9f8L2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782401427; x=1783006227;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E7Qkkmv4zX4aivauKesFupLvPudgvHMLQomamrtSRAU=;
 b=UE62CFLoFEwfep6Q5nhBpBv2hVB3YxjhYF1ZKXYwZ52R8V6GGUlbHB9Gvaayby4zA2
 19Cxl8y5F7Ha337FgEmzPPssUg9fozMbRLzNajlCDAZtRakDYKEzV0nT0AguS/HU553n
 w8XJb7sMKn1/c31QK567/my1XgdblZccI3DPaL4/1rvz/KYRhC1qdVNsbBtYQXjB87QJ
 iHjoJrMGZRbz1n7GQtEuh16a02gRPZkYIGF30nrS3wslaRaKzW3v5WUTiYgQNW2a3/Mv
 JsXQ1QkOxlgahPZjS0g7ENwATSh5Eog2Ga/U4vvhzyoDC/MkywF5an7tmHDN9dfUMLxr
 sAdQ==
X-Gm-Message-State: AOJu0YwJfaN/1vqQ4ldyo+qkJd2UtfVcAKUFIOp7ZqqJ8A0aMn7U3yGH
 Xmey2W9Fd4kPSl6la777Iia+3OWZjF6jE9S/cknWC6W/4WJ7IyLAmvd+E/EIgNCuJF5aJHoiRkn
 U+43CysGgWNGF4lEuVx9BhzIzTsYngoEzsiQPSLdP
X-Gm-Gg: AfdE7cnTtGsQCL6l46nQHtvAPXZzMiXa6yGz87og1VMYg/u+vU5UyZQZDoK206Pj4lP
 c+fB4A1C5+V1TYZJrU+XSwzF34RVJaVVCxKWvdvB4+DlSnDAgGwQ2lXV/qgbADbmHTVbO/HgILI
 Bo/NGP8Av+RmFlHymR2mt4O7ZT1q/maL7Ta0QdYZxzMbLaMEx+cg3qAn3YiC7YuwcEf0RCVj5RI
 xfEGoVJ151ns8xWSet0xbk5ZSY6qZEDQYkIODlc2giDLkqF6pQ6thLaZdgKUlquBFxktmghhw==
X-Received: by 2002:a17:907:f496:b0:c04:93d7:3c12 with SMTP id
 a640c23a62f3a-c1205ef27ffmr264395366b.25.1782401427456; Thu, 25 Jun 2026
 08:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260624-ml-switch-ml-links-to-patch-msg-id-v1-1-da694b9ba71c@linaro.org>
In-Reply-To: <20260624-ml-switch-ml-links-to-patch-msg-id-v1-1-da694b9ba71c@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jun 2026 16:30:15 +0100
X-Gm-Features: AVVi8CdHjJZxQEYnLGgipagcFwdA7rGJ_RFGXp6b3maFfRwpr3T_VBTQWlsB4L8
Message-ID: <CAFLszTg+EqM+gqmZLrz-M2HRLCR8BrUcEswJ9=e+9Ty-cQtLvw@mail.gmail.com>
Subject: Re: [PATCH] treewide: change email links from mailman to
 patch.msgid.link with message-id
To: neil.armstrong@linaro.org
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Simon Gaynor <simon.gaynor@ezurio.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Alice Guo <alice.guo@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Xuhui Lin <xuhui.lin@rock-chips.com>
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

Hi Neil,

On 2026-06-24T14:39:42, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> treewide: change email links from mailman to patch.msgid.link with message-id
>
> In preparation of the migration of the mailmain mailing-list currently
> hosted on the denx.de infrastructure, migrate the links in the code,
> comments and documentation to http://patch.msgid.link to be future proof
> and always link to the expected content data and uses the message-id in
> the URL which will help find the appropriate e-mail in the future.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>
> arch/powerpc/config.mk                   | 2 +-
>  board/boundary/nitrogen6x/README         | 2 +-
>  doc/chromium/chainload.rst               | 4 ++--
>  doc/develop/historical/generic_board.rst | 6 +++---
>  lib/efi_selftest/efi_selftest.c          | 2 +-
>  tools/rkcommon.c                         | 4 ++--
>  6 files changed, 10 insertions(+), 10 deletions(-)

Typo: 'mailmain' should be 'mailman'. Also the message says 'http://'
but the URLs use 'https://'

> diff --git a/arch/powerpc/config.mk b/arch/powerpc/config.mk
> @@ -32,7 +32,7 @@ archprepare: checkgcc4
> -# See http://lists.denx.de/pipermail/u-boot/2012-September/135156.html
> +# See https://patch.msgid.link/1348500648.2514.2.camel@petert

Trailing slash is inconsistent - nitrogen6x, chainload, generic_board
and rkcommon have it; this one and efi_selftest.c don't. The
lore/msgid.link convention seems to be to terminate with '/', so
please add it here and in efi_selftest.c

Regards,
Simon
