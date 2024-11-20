Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06C1D63939
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 13:37:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33617894B2;
	Wed, 20 Nov 2024 14:37:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bvXrP/Ki";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAA48895CF; Wed, 20 Nov 2024 14:37:01 +0100 (CET)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 860F689647
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 14:36:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7f8b37edeb7so5071274a12.0
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 05:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732109817; x=1732714617; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k/ibjneSli7eMcaGdQerQnYm2N+8REGUBWpqkCju1dQ=;
 b=bvXrP/KiR4gclnVDFf8l+muxleURyX/hpbHd8IdLUC2LPPxh4MnODBT+cAgN/3up8p
 jt3ouJvLU7kfK2fd4p27YHf6fUJkKaDb/N2xI1dQIDTWrPiXtuehb+4lHyhPpgBmNKMq
 18GI9TkJeIPByPMoqYCDkN9VfFsaSiug3muO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732109817; x=1732714617;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k/ibjneSli7eMcaGdQerQnYm2N+8REGUBWpqkCju1dQ=;
 b=ZauZKtsY4LyKDkmdguinXK8MEhVUh2CYmCT3XE0UPS4TbNREEH+38o8yrZ10mlHUTf
 SSZO0G/l1lS/Q/0aBWD6MYZrj+BlOmvYzc7+z1tGsFJSo7fvvv9rZZcwp3QR8k/S02Ex
 4NYklZTapqPVp9NFAoRLPvSkeoiRncKP5yyv85PpSaOASQTpytc3ieYOUQSQeCUO/oFK
 Lg1PDnvoQplZW+CHmvgFQu5BGtx/Dn68hYAHpspfqlnLD6NGwO00a8ay14N1k6MIqJeL
 WMUF24ytvlLjX2AjjeRb/ypFVgo/bT2yTp6XROryLdu2kGrcAnN5nZPnfzY6ud5KjTz9
 YkiA==
X-Gm-Message-State: AOJu0YxV6skj0yX5cd+8qh6f1pnE3evtevuvVyBUoDM+s1gno2Kp80gl
 H9cX3Jz2cwcpGCslElmBC8kNsFNZmumy7TO3HBfOLUmpXN0+TDnum5b/Sjgx+OQAWoS5wOU5PLU
 Rf9TyLcnQArtpdRSulY5bRoJUyiUp9iZ+D5of/TpWSMWymQ8=
X-Google-Smtp-Source: AGHT+IEBbikThmLDKKm2tbVl+mNbW2nWSri/dF0gtDxL90Ke0gwWtQegxySrfnknKLJ/LM7Neyo6MDff01I0zNUqX44=
X-Received: by 2002:a05:6a21:60a:b0:1db:ff57:562b with SMTP id
 adf61e73a8af0-1ddaff54c91mr3487818637.31.1732109817125; Wed, 20 Nov 2024
 05:36:57 -0800 (PST)
MIME-Version: 1.0
References: <20241120104029.886860-1-paul.henrys_ext@softathome.com>
In-Reply-To: <20241120104029.886860-1-paul.henrys_ext@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Nov 2024 06:35:46 -0700
Message-ID: <CAFLszTi1eue=sm0Mv6Q4cTB-ATE6oD6qMFkJJWPAbc=NiWK1Ew@mail.gmail.com>
Subject: Re: [PATCH 1/1] tools: binman: etype: Allow to replace 'NAME' in node
 names
To: Paul HENRYS <paul.henrys_ext@softathome.com>
Cc: u-boot@lists.denx.de, paul.henrysd@gmail.com
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

Hi Paul,

On Wed, 20 Nov 2024 at 03:40, Paul HENRYS
<paul.henrys_ext@softathome.com> wrote:
>
> This change allows to replace both 'SEQ' and 'NAME' keywords by respectively a
> sequence number and the name of the FDT to provide more flexibility in the node
> name for the device trees included in the FIT.

This seems OK to me, but it would help to understand the motivation
better. Can you expand this a bit?

>
> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
> ---
>  tools/binman/etype/fit.py | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
> index e0c1ac08d8..b9ebc3afd0 100644
> --- a/tools/binman/etype/fit.py
> +++ b/tools/binman/etype/fit.py
> @@ -732,6 +732,7 @@ class Entry_fit(Entry_section):
>                  # Generate nodes for each FDT
>                  for seq, fdt_fname in enumerate(self._fdts):
>                      node_name = node.name[1:].replace('SEQ', str(seq + 1))
> +                    node_name = node_name.replace('NAME', fdt_fname)
>                      if self._fdt_dir:
>                          fname = os.path.join(self._fdt_dir, fdt_fname + '.dtb')
>                      else:
> --
> 2.43.0

Please update the documentation (near the top of this file) and
regenerate entries.rst

It also needs a test so that coverage passes (binman test -T)...

[..]

Regards,
Simon
