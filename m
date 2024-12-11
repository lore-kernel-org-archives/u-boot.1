Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC29E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 14:47:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3527F8022F;
	Wed, 11 Dec 2024 15:47:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="K+fidbjM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3976801A9; Wed, 11 Dec 2024 15:47:11 +0100 (CET)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A156E80079
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 15:47:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e3c8f39cab1so669082276.0
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 06:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733928428; x=1734533228; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PahvWSpZOaDiYRtLQHeRS+F7LllM3jT7a3Fidb4Y0bE=;
 b=K+fidbjMF1xc9IbJtDwvQSCEVVm+ilJT35cFa7zmzOQQRQFQzPASqoQ9kRWwAfx+eR
 0bxOJxccb4/8Nk522r2w8xLZTgQB8Dhgc0nS/iRbv92cmXj+71Rm7PjLjW4h9CWLrUXT
 Tei2mqaoAOAJlo7PsCNxHpJLspKbj/wy808yQrimKnC2AvpIaSaj3A10NyB0/tDbL4xC
 e66DNoxbnLxPPsgbQcSK9dRcWuvfjMTBxmqProLc9VXtMhQFLrqF4rquDPKODsLBRoF4
 uT9wxBA5cGQDQq1SNjTd7W3tXjFjOP0zk5m8bsET0wjy9zEe9sorQ7rU2+zmXa+pIi5x
 iWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733928428; x=1734533228;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PahvWSpZOaDiYRtLQHeRS+F7LllM3jT7a3Fidb4Y0bE=;
 b=Ufjl+ECu6n0Pj47plD2tNW7r9kpr8olGy0yWk1Bay/kOtiaG1d9cPLVOWqftYBCj4g
 ykIGNsJ83AdB1XH+zqjj8DR0f735RhQPwVfYEuKnpCN4WgBOwLU0xRbDQH+TBh+BuGNE
 hrTgNyUQmw41r8GZ4/XOA7G/SbfaaYbovjQihgrQjfjWHFkQlU+S4DlmNfQv647hCtod
 NhblbNwRb9BuqwfEcfr9OxrYj6jipPN4a+9oncDT+ArXe2EjZX9BhoP4CJwmbOBAC+b9
 zp/9VEil7TvQEgcHNQbdTi4uEkhBJ8u3PMnjsCgOsvqamYuaK0zif4m03wSaGI8EWx4V
 fA/A==
X-Gm-Message-State: AOJu0Yzvx75c+j9J0uxaICclfNFH2Gg15SwhAM+ZzajBLt25CvHo41KC
 wbwi+Q8+aWm3Z7+mEOjArDRvDyt6KTIsiP5mvKYt4+aiv2Q5GgywNQKqT04Cnt9xqm/a1EcB29b
 tB9EdXe1yUJEZ/REFNTIkY+Fz8FuMWnr/lKlp+w==
X-Gm-Gg: ASbGncvxlWePiVKyeN6WkCpcvP9rkPROO9u+nkq9A9K/ZZpQJtaYABZbcuiu1VZlgdm
 mEaARYeocZk7jYyY1u1XHzUYcoPte0Vs95oc=
X-Google-Smtp-Source: AGHT+IHfZ9VE221nifE/d5OlE4wmhIxhPPLduSvlEVgs5AhD9ad6z6ywpqKbsV9OraDjAB+RFbGES9M3hK/6YwxCdYk=
X-Received: by 2002:a05:6902:2e11:b0:e28:e700:2821 with SMTP id
 3f1490d57ef6-e3c8fa3596cmr2521142276.25.1733928428494; Wed, 11 Dec 2024
 06:47:08 -0800 (PST)
MIME-Version: 1.0
References: <20241211135418.563803-1-sjg@chromium.org>
 <20241211135418.563803-3-sjg@chromium.org>
In-Reply-To: <20241211135418.563803-3-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 11 Dec 2024 16:46:32 +0200
Message-ID: <CAC_iWjLW2bjggoXHaWEYSv-eLQAg-W3Zg+MVtCQuFF6JhXbiPg@mail.gmail.com>
Subject: Re: [PATCH v5 02/23] efi_loader: Fix typos in enum efi_allocate_type
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Matthew Garrett <mgarrett@aurora.tech>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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

On Wed, 11 Dec 2024 at 15:54, Simon Glass <sjg@chromium.org> wrote:
>
> Fix 'indicatged' and 'adress' typos.

I don't really like patches that changes typos. Personally it only
makes my life bisecting harder. Since Tom and Heinrich already
reviewed it, I don't mind, but this really has no place in this
patchset.

Thanks
/Ilias
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> ---
>
> (no changes since v1)
>
>  include/efi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/efi.h b/include/efi.h
> index 58838e3ff2c..cf5c4784b61 100644
> --- a/include/efi.h
> +++ b/include/efi.h
> @@ -178,7 +178,7 @@ enum efi_allocate_type {
>         EFI_ALLOCATE_MAX_ADDRESS,
>         /**
>          * @EFI_ALLOCATE_ADDRESS:
> -        * Allocate a memory block starting at the indicatged adress.
> +        * Allocate a memory block starting at the indicated address.
>          */
>         EFI_ALLOCATE_ADDRESS,
>         /**
> --
> 2.34.1
>
