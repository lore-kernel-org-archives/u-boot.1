Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC00C47DDF
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 08:42:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B68DD87C44;
	Thu,  1 Feb 2024 09:42:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fQhExl/i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8504087C45; Thu,  1 Feb 2024 09:42:47 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 810DC87C34
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 09:42:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5112a04c7acso953322e87.3
 for <u-boot@lists.denx.de>; Thu, 01 Feb 2024 00:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706776965; x=1707381765; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZDCPrbpjznQRpqMiEx/2Scs9ecf7ZhX0f8uh5B+GRFE=;
 b=fQhExl/iWCwrKh9p5vJPa/FesHJFZHT/okgV04owYgwnAvh8FFzVdxUIy5Hbnk1Qki
 fO4stS1/wOCXBwMr2HvQVpyNVenhUZstVZeAdrTL/mwcsXM+6nJ64KjcdlJf2cPYxRrj
 E9Oh+1yu6imIjinkq4wFwXVb5Pgb2clGK7Z/bcD6Z//qvNamFAZR7UlhP48Q0zJPqBtg
 FR2b13jFv5q9Tlx13iEa6X2rqGY8qU9UBETCmuRJeHjPZWvTLkD9XxA7L9voLZW9kfIt
 DOSurPB/eGFq50sgytrEfBIedZbBXXAyQXRUwrpYPL/cyeSI4ouoB0r4eAQRiloUhwsD
 nL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706776965; x=1707381765;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZDCPrbpjznQRpqMiEx/2Scs9ecf7ZhX0f8uh5B+GRFE=;
 b=VVqwVpRmp1/BsH17uYUHgVFsHth7rr2iR63fZytsfNoISRP7W3CKmIDJe9y53EIEzI
 oxwUQOCpGY3i0KRGocN1HrWUKVeyN53E3BfkRWulIUf8ezxR8Z7aq51IRTmezVbn3lOT
 dNowCOrnszqeLRW2dmOneyDT5Vz40l9JFR2XLejGDSID9gP46oDGhLTLSIGb3kJpRAz8
 UxkVTfStDzmVChtCYrVf7PV996KDIPhVHtuMrbaBN5LzS2zxoE0ZBJ4T1kbqRWmQUJGK
 FvnfYG8FMOBFTjaHE7NsopFxacx6B9uyeb4yrCBOfbFFuv3vR8RRk3gMBBTTnH6mIlbh
 zmIQ==
X-Gm-Message-State: AOJu0YypuvVqKAKq1/mdJSf00JpI6Yar/P78u21QMxjqeLCSTGc/FhxS
 wVZOvqIoZg0RFtZQcFI+u7sn36TUkvffOGRWbce2zEauDmglyIEcTq2mn+QmKsrkXSirIMhoWf2
 J4rQX1BFNG5bftd6rvTjA9i0f0PNFWYHIKBGa7Q==
X-Google-Smtp-Source: AGHT+IEYVva8S45JAoE5vdoMMfdKTZDmq9klU7gzkv+4N7CSau6SVA/6he19GMR5YSe0rWx2/3o82uv0kpGunuEJ/K0=
X-Received: by 2002:ac2:4567:0:b0:50e:f5b5:71af with SMTP id
 k7-20020ac24567000000b0050ef5b571afmr1235625lfm.40.1706776964743; Thu, 01 Feb
 2024 00:42:44 -0800 (PST)
MIME-Version: 1.0
References: <20240129210453.31070-1-heinrich.schuchardt@canonical.com>
 <20240129210453.31070-8-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240129210453.31070-8-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 1 Feb 2024 10:42:08 +0200
Message-ID: <CAC_iWjLw5iLz+MAsiQvSWnJj6BsqajDJ36fd-ikbvqDYfYJN3g@mail.gmail.com>
Subject: Re: [PATCH 7/7] smbios: correctly fill chassis handle
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
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

On Mon, 29 Jan 2024 at 23:05, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The chassis handle field in the type 2 structure must point to the handle
> of the type 3 structure.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/smbios.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/lib/smbios.c b/lib/smbios.c
> index 50072adb4e8..5a6a980ff6f 100644
> --- a/lib/smbios.c
> +++ b/lib/smbios.c
> @@ -420,6 +420,7 @@ static int smbios_write_type2(ulong *current, int handle,
>         t->asset_tag_number = smbios_add_prop(ctx, "asset-tag", NULL);
>         t->feature_flags = SMBIOS_BOARD_FEATURE_HOSTING;
>         t->board_type = SMBIOS_BOARD_MOTHERBOARD;
> +       t->chassis_handle = handle + 1;
>
>         len = t->length + smbios_string_table_len(ctx);
>         *current += len;
> @@ -548,6 +549,7 @@ static struct smbios_write_method smbios_write_funcs[] = {
>         { smbios_write_type0, "bios", },
>         { smbios_write_type1, "system", },
>         { smbios_write_type2, "baseboard", },
> +       /* Type 3 must immediately follow type 2 due to chassis handle. */
>         { smbios_write_type3, "chassis", },
>         { smbios_write_type4, },
>         { smbios_write_type32, },
> --
> 2.43.0
>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
