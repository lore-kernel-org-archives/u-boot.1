Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 771D6CFA74C
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 07:12:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB89088FA9;
	Fri,  4 Oct 2024 09:12:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xvhYI33t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7AF188FE3; Fri,  4 Oct 2024 09:12:26 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4551D88F6B
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 09:12:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-71dba8b05cbso1809240b3a.3
 for <u-boot@lists.denx.de>; Fri, 04 Oct 2024 00:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728025942; x=1728630742; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Dw1fCeS2d3Bme8LZb3D7qHPWs2Azt7Lgv7c1u5tWQCQ=;
 b=xvhYI33tguBEqnS1Z1Gyk9qYgEwKbZnm+4VqVAMdpUZ2L1to5lNJ+sxMtoj/UoZ5TN
 v1hdJnpukg+l4wFbp0WDexUHYJRIUCG+zZcrbiSyeBkAPNpX2mzFZeZI5cuk6cJN1qTZ
 WoFh4QuAqUDB9NInDhSAkKZcUxUEhSvce/S2QganLLfIfq3dM3UTEsK1bvFWs3Jmjh7r
 rhmSeYJCriTsK9Sr6BZUXtgVXPvgCLTcdHQ/6MdWRMd5LUNHIkHUu3CC3yy1som/djai
 yVfrbllMcBIHb1zPHU3FKD7DbMLslPtIiV1qvAtcEg9BNzNJMJnc5ZCs87ehKcANkrbg
 +ZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728025942; x=1728630742;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Dw1fCeS2d3Bme8LZb3D7qHPWs2Azt7Lgv7c1u5tWQCQ=;
 b=tTshN+ZV8S8kYZr7xaLLruZSwXtm23HJeUYvBh5oY58u0FPtCdYqkSGqklQyhUNkpT
 3NbsegUbhAIPGNc5Avf8DZpCTY/LihlIfMBk38JmHUStFRArCGOarp5yHC7hOOo64tMt
 92WF+ysCH2YZElpMd+NBmC+8X3MVrZ81UFlnrMHFzwmCQXRNFZUBC8hBggWSWG8vyj3O
 KkBW7uGsvVIJFJTilv6VyYniOSZaLjYQoaN5/IN/zrRJVCTdJlxP/pDqNi8tCeCALDUx
 E9rMVrTwNj0GF23T6Cr/7kNBXl9yA/m+fJbwU73jVKBmXJBD3qHSJEdLii+o//7/onJY
 KXkQ==
X-Gm-Message-State: AOJu0YyEtF067eCyt6WxvEku51Vwz39EJl2V0+7f1cx2gBBq8TMpbVza
 Dz1Z6w7DXnM3v4s8pPmlChZnFcBDer1BPI4DVPACxsWl2SqvhAgTg+brdgfx/C9EWr2oNylQmM6
 n49sXyAXiGEyXlDEv9fnFAQQVKGQQ/PzIPnTXtg==
X-Google-Smtp-Source: AGHT+IFNr2V4UkH1kq/1alqbRjri+A1gqUiwcCIGRY+NHAEyDLmpGJHi48racLzDccer/jfGoR0345+1cJ55dMFcjqs=
X-Received: by 2002:a05:6a20:d805:b0:1cf:3c60:b8d3 with SMTP id
 adf61e73a8af0-1d6dfa3687fmr2947394637.19.1728025942688; Fri, 04 Oct 2024
 00:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1727968902.git.jerome.forissier@linaro.org>
 <c14ec8b9788c30c205f7b605c9d2b46ebdcdcc91.1727968902.git.jerome.forissier@linaro.org>
In-Reply-To: <c14ec8b9788c30c205f7b605c9d2b46ebdcdcc91.1727968902.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 4 Oct 2024 10:11:45 +0300
Message-ID: <CAC_iWjL-oYMkYEZCdcyE7F8x0WPByaELOcYc6Bhz5afXj1Ysvg@mail.gmail.com>
Subject: Re: [PATCH v11 20/29] net-lwip: lwIP wget supports user defined port
 in the uri, so allow it.
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>, Maxim Uvarov <muvarov@gmail.com>, 
 Tim Harvey <tharvey@gateworks.com>, Anton Antonov <Anton.Antonov@arm.com>, 
 Jonathan Humphreys <j-humphreys@ti.com>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
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

On Thu, 3 Oct 2024 at 18:47, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> From: Jonathan Humphreys <j-humphreys@ti.com>

A short description is missing here

Thanks
/Ilias
>
> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  net/lwip/wget.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> index e8768fc2acd..b495ebd1aa9 100644
> --- a/net/lwip/wget.c
> +++ b/net/lwip/wget.c
> @@ -349,12 +349,6 @@ bool wget_validate_uri(char *uri)
>                 ret = false;
>                 goto out;
>         }
> -       s = strchr(authority, ':');
> -       if (s) {
> -               log_err("user defined port is not supported\n");
> -               ret = false;
> -               goto out;
> -       }
>
>  out:
>         free(str_copy);
> --
> 2.40.1
>
