Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B53D0D3B7DD
	for <u-boot@archiver.kernel.org>; Mon,  8 Dec 2025 07:34:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A10E83AAB;
	Mon,  8 Dec 2025 08:34:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fC7u1mjI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4D6E83AEC; Mon,  8 Dec 2025 08:34:21 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA025839DD
 for <u-boot@lists.denx.de>; Mon,  8 Dec 2025 08:34:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-78665368a5cso37911107b3.3
 for <u-boot@lists.denx.de>; Sun, 07 Dec 2025 23:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765179258; x=1765784058; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=91LyPh/uF0ywaFL/hj+yKJmLkMThSjCWLnmFAuo2DkA=;
 b=fC7u1mjICss0Xw24ceIACjaDgN4OAWfkBzX7McPOp3sLd5H6yiOX9ZjZLftHfhh2yn
 NCNR80+ZXke0R9XEMAnDNU9IuBL+uCwoAeUCphQZ8BxPlnK0u27qlRi2Mr/FJe0teFr/
 P17Z6lGOEfdML8RWwljtysiqFiIOg5U60HrPOOwbeI4hGbnW5cT3isOCi3X94BUbrARI
 V3BRTfao3lDLIrEY9TGZSjUOMroZz96N+XVgYxXkon+BLVu5ndi2rYWmHwf2QweJLcH/
 HN3KuY3226GLSuu1oMpJxTiKjyhS8UXjctEMT7TCCBW3mT/PZ8GuLQSPpTbD6W4aDvNq
 uuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765179258; x=1765784058;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=91LyPh/uF0ywaFL/hj+yKJmLkMThSjCWLnmFAuo2DkA=;
 b=sz5CZiZAuBtVQk9SEDdw25S9gr15M7vXAE28boBsvw0mTQLMQx067HtB57owVMDHfu
 +bsjT0wZxw2VTPsmTSr2ZMs/plDqVu10wrgfpgxA2wjz9IGY/P1K3sCRXa5F4QZQHh91
 HdyQ9mrcq1Bi7bd45rxvhYvsgBiNE4a1XT3HcnuIuGQiLVGUyiexuRJRowfgn9bL1EuG
 PNde7jdsb7SYCAqHqeZ4FK/2o1Pzd/Bhq7S3to2Ios38/xoDgllBTIDzXFJAOq0WrMwi
 CCS0nQlrgI3ADToSQYDpWtUMZsimOiHuqlDHW1FkO31ycZHvEGCQ3ZaiocAi2kCV1YxH
 7+1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJmtIA6xqXqbg8ns1CeZilMiwGFpH9t0GVYOAee0+BWxI4kb04KDumFuWOFlm+I2yMo7GObYg=@lists.denx.de
X-Gm-Message-State: AOJu0YzGQ4K26Kp+y6WN9UxLKf313JtbibOkpbuZLmvq5ybegA9wczhd
 9+PTmM184Ga9tBG6zP01OtmimVMAN8Qq55my0qhb2wh5lTOppELfBrKYi84VWt0rISdKyRxv+3k
 oivlwJxFpvll/E7PA6U4jyQiOe96MfTqJt1+2flzOeIktDuaZteRrclVCVQ==
X-Gm-Gg: ASbGnct1KDnwhobaWvHPF+tyEX2eb2wRYmWWlsP9CZLBmVtvgi33QQ8nwh7Al+RT+yT
 L2hAB2pj86hDYVWD1Pundb2qwMdMvk+QbSPmbFNwEHURxo1qw3eFvMwDWRDaHm46elnsaQykkcl
 OQoQR0VzyMrgUh6Ejt1sGYybX7g+OmiVh1OnmKPMLvZoGsZksPiWPeEevsLj1Yi4h/JK69+Vgkc
 YK47uGgw17RNlyNwqJXvoNYXUsLerxLFlI55iMt5UvcZG66YTPxcMV9HttSPvpu1F8my5K/Uvni
 +HXzx3GhHNgnAjey5xUR5kDqomlDVQprkY1A/W3WMdTy9FZnwAt+lFqZSJ438qtVTNH5/1gtpq8
 pZYqjJ3k=
X-Google-Smtp-Source: AGHT+IHfomuVJ5dD8ROQa4gmjsxf2Le8uKwcBrWJDODYoKx4LIDfFaxwWWycuyxFx/oteMTHHMM3ZxhRAd5st2C5PDA=
X-Received: by 2002:a05:690c:9a0b:b0:786:506c:3cd2 with SMTP id
 00721157ae682-78c33b0a8d4mr64654717b3.11.1765179257619; Sun, 07 Dec 2025
 23:34:17 -0800 (PST)
MIME-Version: 1.0
References: <20251207111845.172933-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251207111845.172933-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 8 Dec 2025 09:33:41 +0200
X-Gm-Features: AQt7F2pZ38pfg6pFX6VvYL8Tqoarod72ayAs4fh_aQ0NushZZgEzYxd2vtITK1o
Message-ID: <CAC_iWjKm--nZM-oeiwuSh7NWE5S3DGmwt8NXHoyi4pMBakrZNw@mail.gmail.com>
Subject: Re: [PATCH 1/1] lib: uuid: add EFI_PARTITION_INFO_PROTOCOL_GUID
 translation
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Simon Glass <sjg@chromium.org>, Jerome Forissier <jerome.forissier@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
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

On Sun, 7 Dec 2025 at 13:19, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Add support for translating the EFI_PARTITION_INFO_PROTOCOL_GUID
> to a text.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  lib/uuid.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/lib/uuid.c b/lib/uuid.c
> index e0f8d55438b..0a166320e07 100644
> --- a/lib/uuid.c
> +++ b/lib/uuid.c
> @@ -139,6 +139,10 @@ static const struct {
>                 NULL, "Disk IO",
>                 EFI_DISK_IO_PROTOCOL_GUID,
>         },
> +       {
> +               NULL, "Partition Info",
> +               EFI_PARTITION_INFO_PROTOCOL_GUID,
> +       },
>         {
>                 NULL, "Simple File System",
>                 EFI_SIMPLE_FILE_SYSTEM_PROTOCOL_GUID,
> --
> 2.51.0
>
