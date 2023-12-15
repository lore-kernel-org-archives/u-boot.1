Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34BA5C35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 13:14:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 823C287BA0;
	Fri, 15 Dec 2023 14:14:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oKZymbE/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADAF487BA3; Fri, 15 Dec 2023 14:14:19 +0100 (CET)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6912487B88
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 14:14:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5c68da9d639so353419a12.3
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 05:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702646056; x=1703250856; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xa6rpRKbJuxj7z5VyaePKPP8Ji/R6F9XlQ99tGU2thg=;
 b=oKZymbE/c3woTWYzLFLVEfd9KRm0ZfrqO8mwaDa3crTKx/Nr4fMkVUVbYHLWWbv4Rc
 crEam9Qw8QKSSMuHCqySb00QsCIPFrw1iMTBlVVX7jm9L2aNEHIpAx3HeJVfGNit2mMl
 INgtVmP51fzGvPBNKIUTW+4hVwRQojRArBUprCgMdYUPNKeccpsvxnLEbQtSvIn/RRvu
 qNoKYKKtBZVcI05wNwIcVaVUM+mVM2K2qGPM9ZSQIrwvsJmVUP9Qq6Nxgbvg/I1INGXX
 5y7DEc73aEmS6DUxn99l4kiMdYwYZzlRSYNXgv745uw+K+w+IsWxpAFphzxytZjPlKs8
 +wlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702646056; x=1703250856;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xa6rpRKbJuxj7z5VyaePKPP8Ji/R6F9XlQ99tGU2thg=;
 b=Y4g1Gz03Yzw1EcfIwv6AxLHTVBI64EHujzLM2He0zxNwaD+XBjXuCA+dwqlrk3S1Ab
 b+0M92JszlaylgxWt7LZLXDVVt39+4AKLPm7MJyoDD+CR03xm7Rd3XcnJTuH4iEBJiYI
 iV1WgH0eoJLjQsc1BCHYvfl0kO30n19BfqL0VwgtsT3+ytTTt+zHe+mWyJgL+q8sFYiV
 0mit4M5IWPXPdUZWgDlSkka/K0LexgUrccYRMUaDeYEPfCuBGmwC2POK6lN0ZeQHfLgT
 jUvP02+gn1dlbOFuSjMeyUZBatXkCOx9oT+QRupYpt+9pWT7z6dv8dflra59F35p/61q
 tqMQ==
X-Gm-Message-State: AOJu0YyeG04g4KSAfGJjfqCBWDCm3Lg0XVAQ8KBZ5n9NFr58u2HkN7y2
 CiD0IpSMqFjAYUGWXiI/chzfd+tONVV40OXBb/IpBg==
X-Google-Smtp-Source: AGHT+IGavffLPni4n0dN3nHbPrJ1PRsIxwBjv/DzKrHfPxNtYd3F/fOvNQ848aryfSMLdPbKefyn5nLdRBKwqAjF5Eg=
X-Received: by 2002:a05:6a20:918b:b0:18f:97c:823b with SMTP id
 v11-20020a056a20918b00b0018f097c823bmr7445647pzd.69.1702646055737; Fri, 15
 Dec 2023 05:14:15 -0800 (PST)
MIME-Version: 1.0
References: <20231215041919.2197788-1-sjg@chromium.org>
 <20231215041919.2197788-9-sjg@chromium.org>
In-Reply-To: <20231215041919.2197788-9-sjg@chromium.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 15 Dec 2023 07:14:04 -0600
Message-ID: <CAPLW+4mgHT-ZDW3_gaVTs3qo4pr6eJwUzqD=QOhU8H5U88qZ2Q@mail.gmail.com>
Subject: Re: [PATCH v2 09/16] doc: Mention fastboot dependency on CMDLINE
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
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

On Thu, Dec 14, 2023 at 10:20=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
>
> The fastboot 'boot' command only supports running a U-Boot command if
> CONFIG_CMDLINE is enabled. Mention this in the documentation.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Suggested-by: Tom Rini <trini@konsulko.com>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>
> (no changes since v1)
>
>  doc/android/fastboot.rst | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/doc/android/fastboot.rst b/doc/android/fastboot.rst
> index 1ad8a897c853..933a652538c7 100644
> --- a/doc/android/fastboot.rst
> +++ b/doc/android/fastboot.rst
> @@ -127,6 +127,7 @@ Boot command
>
>  When executing the fastboot ``boot`` command, if ``fastboot_bootcmd`` is=
 set
>  then that will be executed in place of ``bootm <CONFIG_FASTBOOT_BUF_ADDR=
>``.
> +This is supported if CONFIG_CMDLINE is enabled, which it normally is.
>
>  Partition Names
>  ---------------
> --
> 2.43.0.472.g3155946c3a-goog
>
