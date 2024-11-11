Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C645D2E9E4
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 12:33:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B66ED8935B;
	Mon, 11 Nov 2024 13:33:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fdOp6Rca";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D0408932C; Mon, 11 Nov 2024 13:33:53 +0100 (CET)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C299B8935B
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 13:33:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-71e5a62031aso3415369b3a.1
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 04:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731328429; x=1731933229; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8YS9jIZLk1OE8hw7FELN3lnwfqhrFjYy7+m0ZWhvk3I=;
 b=fdOp6RcapL4B/mHboB8lfLIttCjjvUT1fpODtOIzJCXchfW5IONFw4+7kksiXfqerq
 zPsdh6vIXfSSDgPGXgXaeVNRTEhUcE3PJHuuMOc7R1W4tnpPoxwvMyvFyJxwrbmYoEYM
 OP0wENP5o1xOylJ4vjRy18GLkEF3/LUSMYDeSDH3Ta1CByOBvf5tq1DBkoa/aFIaw9lh
 lZpnGq/83agLroTzhKQUmA2N7D3xT3R8m7i/Dd+tNH0A3OuKwN+SltfznFLd9zvs7ZKA
 yxhjewYPBT+EJK9kw2IPPw6jIIUg4fdX+SULbxo4zkAtumUo//+L0CCYPcb9JczyMPK/
 IVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731328429; x=1731933229;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8YS9jIZLk1OE8hw7FELN3lnwfqhrFjYy7+m0ZWhvk3I=;
 b=Z90lQMbtAW0Elp5oYjO4AzRCkRKM2qBKlnjpKuETS74dCW0ObOV8r3ETDcstkdB8C3
 4jwiN9csDIsk1/g3o5Z9yQmRXmC9xILngOFlQs0R/lPOw9k/ZCFGcgXilavPN3Jmrknr
 rUSiW5fCxYjAZ8u6sSCKa9ooTi/3NChoXgMR1E2eyj0t8yX+hL48BcGD/N5AHzTdEXAh
 O83oIlp5jPJ5NJmtVtyJC+iKg1+/G/TS7it3uQJlh+mIwBS7I15TUUw2+KaCSWtbojPm
 YHRacuNFcliPajdQfVD5GswraoEOl/2IJPJs8nfVdp4Xxp4WsYFY/uoWwtg/bjJJmcdi
 OL5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVm8PRlBOL8eF90qJZcNNFyn+85zE1kCg3hVjEZTTYOicvlaZMfIQzmIUi8jQzU81hDyXd94tE=@lists.denx.de
X-Gm-Message-State: AOJu0YyQIreMtbCsil28xlAlH+ba7IFRhHHLOOkc2QNItpCr2NL6Bxyb
 pdBykq3gZa+GnEiInCkWjvrPRIJT/BfVwhQZ4sjznoP0CYLV6fKZIyI/2dIi6/haauJB7ZlxlLC
 GXrzWcAR3gUs4q4chk89uNfvWQ/F7Jq4K9ythJA==
X-Google-Smtp-Source: AGHT+IEymY1jGAA9W6OM+S9lyNKo7Zcr/sqkxk5PM8eCS7T+n+0X5d6SWHF2atr32EAqVPkZM/RZb4oD1TvZaaqWXgc=
X-Received: by 2002:a05:6a20:7344:b0:1d2:eb91:c0c1 with SMTP id
 adf61e73a8af0-1dc22b38ac0mr17015038637.42.1731328429273; Mon, 11 Nov 2024
 04:33:49 -0800 (PST)
MIME-Version: 1.0
References: <20241103224223.195255-1-heinrich.schuchardt@canonical.com>
 <20241103224223.195255-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241103224223.195255-4-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 11 Nov 2024 14:33:13 +0200
Message-ID: <CAC_iWj+6Xc5PCHa4RVNiXzL_e=i_fHw=jBPQ4UPAjh4u9b1JGw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] lib: uuid: fix uuid_str_to_bin() on 32-bit
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, Patrick Delaunay <patrick.delaunay@foss.st.com>
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

On Mon, 4 Nov 2024 at 00:42, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> hextoul() cannot convert a string to a 64-bit number on a 32-bit system.
> Use function hextoull() instead.
>
> Reported-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Fixes: 22c48a92cdce ("lib: uuid: supporting building as part of host tools")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         new patch
> ---
>  lib/uuid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/uuid.c b/lib/uuid.c
> index 19f33dd1477..538a1ba6aa8 100644
> --- a/lib/uuid.c
> +++ b/lib/uuid.c
> @@ -313,7 +313,7 @@ int uuid_str_to_bin(const char *uuid_str, unsigned char *uuid_bin,
>         tmp16 = cpu_to_be16(hextoul(uuid_str + 19, NULL));
>         memcpy(uuid_bin + 8, &tmp16, 2);
>
> -       tmp64 = cpu_to_be64(hextoul(uuid_str + 24, NULL));
> +       tmp64 = cpu_to_be64(hextoull(uuid_str + 24, NULL));
>         memcpy(uuid_bin + 10, (char *)&tmp64 + 2, 6);
>
>         return 0;
> --
> 2.45.2
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
