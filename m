Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68CCCDB483
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 08:53:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34CE186AE6;
	Fri, 13 Oct 2023 10:53:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WU8Z8H83";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14E1486AE6; Fri, 13 Oct 2023 10:52:43 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 592FC86E77
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 10:52:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rickchen36@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2c5039d4e88so9801051fa.3
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 01:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697187144; x=1697791944; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q+ztkUC9WoZSALBbR4FTYGNl6xa90LFWssehlAAsbZY=;
 b=WU8Z8H8346tfZcKJuRvSy2x2Jz0U0QdB5ppPGZmrG9SywVQbok4LYfAPEUyTN1DY6B
 lo53F1DrkXvcMYv/szqI7FqlCcva9fR6My24OXeYHooVzA+T8vRnpjV7/gVakObdhqEJ
 JsLgFge58iJxWXYNhLSwJoX863NVTTzj5VFIkAAXJ0FdE0nmPBzpT3wBuifW56UYH01t
 mucmDI1t9z3jxJaw/DbUgj2EbA6ehB75KlG45oTUKIP1bsfjt3D/G3qN3Op8laW8Sudr
 NI514wkFTFm0UNpVVdZ+2LCGifdBGvYfoWCmYjj+KrcfciYLZZ3RZA4tJE2+gSdgPFbU
 x9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697187144; x=1697791944;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q+ztkUC9WoZSALBbR4FTYGNl6xa90LFWssehlAAsbZY=;
 b=teTH3UfkYjC5SASJxaeO2DD9jy0xhKCU8WpwHen9mFzlZb4KJyVC2K+9VP7cdmnTKU
 tkC/2kCky/Dn/NfhTqdkLP5CS38T26HUvWgAuDW+B4ldklOVgMtw0sXugy3tMzWpRATt
 Y4lrrjBym9sX1dlaAspAo5/YCqOSPdFmVP0FqHQnFMH9Ae3HUSLdExw/xvKm1yGGee0q
 Z9MpZtPsLtO+nZel0fAp22FSmBJd7CwfCUTq+de1RaFaPuTczwemS7dXSGy6o+AwQGt2
 WgA82pTzBpU5b5tA25ilBt6akGORdvONL1pZY1oHBS2Zyp80ldpgTvOvKXlKlAZtE803
 hEyg==
X-Gm-Message-State: AOJu0YxNw97lSV1J4xxuK1wgasD6GdY5nnqGaXiMezMbUuecYgiq1c+J
 KhvwBHkKElVYb4/T8FQY1UIFE3mbg1UODqqcVYT7vYOMTeU=
X-Google-Smtp-Source: AGHT+IE9ahxbvuAC5NPtLYMuf6AclNYHcsZIsTxM1ZyPb5bBUXbXeQsGHO2WkDQSNMb46OMmGm3W4fDaDzPTaMHhatI=
X-Received: by 2002:a05:651c:10:b0:2bf:a961:2374 with SMTP id
 n16-20020a05651c001000b002bfa9612374mr23029329lja.47.1697187143996; Fri, 13
 Oct 2023 01:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231012230359.2005249-1-trini@konsulko.com>
 <20231012230359.2005249-7-trini@konsulko.com>
 <SEZPR03MB8064C345D63766D2E86B2184C1D2A@SEZPR03MB8064.apcprd03.prod.outlook.com>
In-Reply-To: <SEZPR03MB8064C345D63766D2E86B2184C1D2A@SEZPR03MB8064.apcprd03.prod.outlook.com>
From: Rick Chen <rickchen36@gmail.com>
Date: Fri, 13 Oct 2023 16:52:12 +0800
Message-ID: <CAN5B=eLiOLFWcraQ9WFZxGqo-d9dSLjfE+ZiNFVx1C_fdH9M9g@mail.gmail.com>
Subject: Re: [PATCH 7/7] riscv: Remove common.h usage
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: rick <rick@andestech.com>, Leo Liang <ycliang@andestech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

> From: Tom Rini <trini@konsulko.com>
> Sent: Friday, October 13, 2023 7:04 AM
> To: u-boot@lists.denx.de
> Cc: Rick Jian-Zhi Chen(=E9=99=B3=E5=BB=BA=E5=BF=97) <rick@andestech.com>;=
 Leo Yu-Chi Liang(=E6=A2=81=E8=82=B2=E9=BD=8A) <ycliang@andestech.com>
> Subject: [PATCH 7/7] riscv: Remove common.h usage
>
> We can remove common.h from most cases of the code here, and only a few p=
laces need an additional header instead.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Rick Chen <rick@andestech.com>
> Cc: Leo <ycliang@andestech.com>
> ---

Reviewed-by: Rick Chen <rick@andestech.com>
