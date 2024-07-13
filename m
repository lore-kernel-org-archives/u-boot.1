Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D9FC3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 15:15:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 954BC88887;
	Sat, 13 Jul 2024 17:14:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hGI0S9wk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E64288804; Sat, 13 Jul 2024 17:14:01 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1021088817
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 17:13:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-79f083f5cb6so179642585a.3
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 08:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720883638; x=1721488438; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GDMYSG4pYppCoWlmzoBUOb1TcjIslqrZT+KgJG7K+y4=;
 b=hGI0S9wkSKj73kFbvBd2R8EY+k3jPSk/wZYs2Ws81iHgYu+Y1Avou6S7uSPmtx6rJ2
 VWR+D9TEQSmEz4XlnS7HzqoD9Z6LJS9fatJNCN45iXi/nCE3+kzbCLFEsNEW/zbFYQl0
 0QTjImMoBmdB7wdMc8VE8n91g8fV/6Fzh90wQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720883638; x=1721488438;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GDMYSG4pYppCoWlmzoBUOb1TcjIslqrZT+KgJG7K+y4=;
 b=mxDFZx+qrQQxgKk6jlDgwrAAGx6HkdYTVi3fcNc6YEOhNrx5Oi83uTEsk0KlRRQNIs
 5z+vg/T/8hvVax8hc7zCg33nmtMM2kJ6SnmSTYjzB7uZVN+ZcrZ+cJmrrzlCxo2XZZAh
 xJJjJpwxPD00ODclO0MH7J7z6rTXhXUWwPt91DjbkgKoXjXk5lSHTPZppyPfDYr+CVDc
 twl0NN/3YfXeIXkm34A4nNFNgvjb7WFiwSbDAW4PfmNn4fy4JX2IelfiixIcU/scZLUf
 NrUucq8MWxzrUKPiCgXD5nghsYRp5PIdCbqAWwkHLrZZH3c9Wqhj57i1Ozkg2uicmbQZ
 hxnw==
X-Gm-Message-State: AOJu0YxYXtZq4oIFlAdrV5CwU9IK95bkFnViErkrsrHN+oDhrETAdvQD
 nP6PY+6J/12QvFFiUg+HEp1hyJejhywALfXtKl9w/gG/0D1virQ8nF8QXs5R3vcKau4ty/hC3CN
 NS50QQSh826YFs/l88IyV/LPzpK0vOmYUZdzJPR9tkgGd0JU=
X-Google-Smtp-Source: AGHT+IFciE7Aqco0fZ4U1Vs4pP02V2JrNQbc9AOUgmknJ1T1X9OzBwPZJGGadWjAyefZMVL3pzln5WHPocIXP9gNMaM=
X-Received: by 2002:a05:6214:c65:b0:6b5:9146:6251 with SMTP id
 6a1803df08f44-6b61bc7f1a6mr172554456d6.12.1720883637895; Sat, 13 Jul 2024
 08:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240709230709.2228061-1-trini@konsulko.com>
In-Reply-To: <20240709230709.2228061-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 13 Jul 2024 16:13:46 +0100
Message-ID: <CAFLszThLtRZTK-AVYn8LUbXsPnbEHKpda-+0ESdkAH4v-dLM-Q@mail.gmail.com>
Subject: Re: [PATCH] test/py/requirements.txt: Bump zipp to current release
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Wed, 10 Jul 2024 at 00:07, Tom Rini <trini@konsulko.com> wrote:
>
> A security issue exists with zipp before v3.19.1, and the current
> release is now v3.19.2. While the change in versions numbers is large, a
> manual inspection of the changelog shows that it's not as big as might
> be implied.
>
> Reported-by: GitHub dependabot
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  test/py/requirements.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
Reviewed-by: Simon Glass <sjg@chromium.org>


> diff --git a/test/py/requirements.txt b/test/py/requirements.txt
> index c1dd636931f7..6d3030cf90cd 100644
> --- a/test/py/requirements.txt
> +++ b/test/py/requirements.txt
> @@ -27,4 +27,4 @@ testtools==2.3.0
>  traceback2==1.4.0
>  unittest2==1.1.0
>  wcwidth==0.1.7
> -zipp==0.6.0
> +zipp==3.19.2
> --
> 2.34.1
>
