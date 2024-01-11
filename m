Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE387C4707B
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 07:30:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED55687A61;
	Thu, 11 Jan 2024 08:30:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="u5SCkYNZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD809878C8; Thu, 11 Jan 2024 08:30:35 +0100 (CET)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF873876EA
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 08:30:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2cd8bd6ce1bso1539871fa.1
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 23:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704958233; x=1705563033; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yZnUPkksJMY6Ol+2OjG5aJTQ5c9PQ74rcgIILLLpV0c=;
 b=u5SCkYNZK5bbi2wH5NZ2d1sTzypnYwTmv6s73iwqwAsBs4xy31QyDbWvs5QEzlgZmG
 j+lmquT3WyJlJifAYiorRJlBuvPu+3JXPmpA9BysqL9E/4Y3im//gBRNe9lJ1cWhhYkC
 WvUrqCyFkiFK3KRwt07p8vzyfI7KtQ7X7OKtYTm77u1SCSlTZ3jbDx2kYOfTjypigj7x
 64jCJBNxKlReIxJMhSyKmmTW5aBZ9jM+fowK+D6P+f1IZ2lDYn6i2+2QX1tN9kn3z2w6
 jPETauDal/ALPY4R2JPEXP9BwoTdpnnSvvFfr7C86ucU5DV1oCu7qBtU4rXJ1dAPWFMk
 WFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704958233; x=1705563033;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yZnUPkksJMY6Ol+2OjG5aJTQ5c9PQ74rcgIILLLpV0c=;
 b=pXNmFQ7Bax29If95GKpS3bAgyyhHrovO723JLioFCwb1ZKVrPN7OdhNCfqb10vlAuP
 PHH7Wbddqr1ilEqJhUuxZTrITSZHhx3wAku7kBrvaqp1a5jKlBS+HxNCTsxaZ2zqXC3h
 G2mRJ1TwJvOZA+ixAN5AuNbwhHJnZ4JhF78fESH+dy463lHcgQzJxG9skV+8G7JisHzm
 cZWWKG9KRiNim4Wo6wWqry6fCkImzxxkh7RSyS2rwU0FSzyHhOs8opxc/s5R/xKQotHt
 xDtupnj6rL9apsMHhXwdQvft1S1tN1QkrY2yrVAf/CvwqkZ2tVA/mWlNPfL3e27WyU0y
 xxiQ==
X-Gm-Message-State: AOJu0YwvUgWp0XHuDndM/ttCbdGovuluEv5/vuOqvN3FkP6EOqu3YqCg
 ZYOfNKzw+nW6+knQ8d/odsRqGQDcHI966WkHvnssDxtjCIlRUw==
X-Google-Smtp-Source: AGHT+IHG6YRc2TXt9AdKKXMXANK8Xw0EvOd9Fej1pCrwt7x5XrIE3J4hvb3bcLeaYhqPY4wwWh5lmYeuZtDIJm3o5OE=
X-Received: by 2002:a05:6512:68:b0:50e:c952:2d3e with SMTP id
 i8-20020a056512006800b0050ec9522d3emr209071lfo.188.1704958233097; Wed, 10 Jan
 2024 23:30:33 -0800 (PST)
MIME-Version: 1.0
References: <20240111063408.9807-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240111063408.9807-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 11 Jan 2024 09:29:56 +0200
Message-ID: <CAC_iWj+ReJ7eQseZo3Ho4qyRoSg+F4cSn_cVCc1SkjBn0+PvUA@mail.gmail.com>
Subject: Re: [PATCH 1/1] smbios: buffer overflow when zeroing entry point
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>,
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

On Thu, 11 Jan 2024 at 08:34, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> A SMBIOS 3 entry point has a different length than an SMBIOS 2.1 entry
> point.
>
> Fixes: 70924294f375 ("smbios: Use SMBIOS 3.0 to support an address above 4GB")
> Fixes: 1c5f6fa3883d ("smbios: Drop support for SMBIOS2 tables")
> Addresses-Coverity-ID: 477212 ("Wrong sizeof argument")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/smbios.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/smbios.c b/lib/smbios.c
> index 41aa936c4c..25595f55ab 100644
> --- a/lib/smbios.c
> +++ b/lib/smbios.c
> @@ -591,8 +591,8 @@ ulong write_smbios_table(ulong addr)
>         table_addr = (ulong)map_sysmem(tables, 0);
>
>         /* now go back and write the SMBIOS3 header */
> -       se = map_sysmem(start_addr, sizeof(struct smbios_entry));
> -       memset(se, '\0', sizeof(struct smbios_entry));
> +       se = map_sysmem(start_addr, sizeof(struct smbios3_entry));
> +       memset(se, '\0', sizeof(struct smbios3_entry));
>         memcpy(se->anchor, "_SM3_", 5);
>         se->length = sizeof(struct smbios3_entry);
>         se->major_ver = SMBIOS_MAJOR_VER;
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
