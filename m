Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C485DC54FCC
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 07:43:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50D6383D3D;
	Fri, 20 Feb 2026 08:43:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="X8lQ42Pj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88C9D83D5D; Fri, 20 Feb 2026 08:43:20 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98BF483AA9
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 08:43:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48372efa020so13703365e9.2
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 23:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771573398; x=1772178198; darn=lists.denx.de;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UrPvw7e8tnQG19u3qKpTO87XBpN1G+P73PByRprBRM4=;
 b=X8lQ42PjtDEOiTGdV6mOaXKWLURR6caATkLnrULgl2qOg/D0KE6vCXKxGRfhXzu1nN
 qUnvE4TrzJAsOciQCMvZ++XzoLkFs9on042SGhABz/544v/1BdRZAGT8Dm/Yn8VGKhog
 XPoGtS30NYTAlYMYjls74FRXxftJYW2QpgouAkchNcmwb4jj+sIYGbn/W8CBePBCI2Vv
 /kZQDY+SI96NxaAfG0kZJ1ws7IzDQgXdt3D2fd0J8vboQ2TbdZnfuIV1tJOyVmmCpzKf
 mFvJi1Jd+KUwIWr4z+b1GQd4v7gIisLO6kdG6LUXA1ceiVxaeNnJ5vMiJ/XhZR+FgG7j
 0fPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771573398; x=1772178198;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UrPvw7e8tnQG19u3qKpTO87XBpN1G+P73PByRprBRM4=;
 b=hR9gCLS3Np0B9nOFqFYGq0yLLXcU0mtAjl5mKaJINDcR+n0jYSnQQUjAjSpENaxX9N
 SdqRCrxgBBWePbIXdx9aViWhX6Sy2fn5vThKwnC4bIp4RR+0U6+18LSqNgX8w6BXG6XP
 gmRVpwL/vUEtafJK30KO2vOTa+FnwPzjBH/ZKM3H3+HB1BD/Wc1PULo0LEc4tJmujamS
 S3S0Fl2Fjp52oM59AepZzoKjnQD2cfO+ExEXLC2jqsCiLJQ5ORffQUevGP2d6Y2vI2YC
 kEGW87LbhrqVSTv7nWAA/WHbhOcUzCfU+F7pgY8dSXfcgPrhbDAqM3tY1ECneEL64hZP
 bEfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjqv/RjOm7qw9LvLz+YrnFnxo94IVND6WbufLMryVr9QYjsFr8gA3Mn8kxYrVls2gx1tNukww=@lists.denx.de
X-Gm-Message-State: AOJu0YzASC3xsaD9c+ozKp63ade37iOE5YQ4L9XT3oqgUFr/36kfv+9o
 kgY2USUikS9xYsKLkTkIx94npmN+fS1scWRLw8AjN6E0Bk2uoI3v9PK6SQQJckqkI8M=
X-Gm-Gg: AZuq6aImwwYu1o97JsS6XPk0b73OM/QLMAK6BqDOuToKftn79bObJAR8/uTvw2bI6tq
 MvLpk+Q2+O8juK2X1Es1pB6p0jAqfvMrMKTgFrHKk6pcgrv+CSZGHHHTd7KmxQRHg17uH0GQhyF
 tDUamcK8RaRKxztv7CHvHagx2JkIEz481UX4Ns+r7ROO2n3LYbOmSMdiKCUAvqtHSNExYt1xGFt
 /rrzLinCC9kCeeeiSVKnNNLbomPsqzMBjI4CKreAMEqRWz/7PywDtQ6QoK4Sls0xHTpJOe+dBYh
 +878BFtV+xUWmvKxFzkMLN3CGu85CgNqvpE6MUA/PJvzj28PTHu4LWBVTuYD8iEXx50rfaH49Rv
 Dbl1znOCWh1QvYFgbGWgWwj7OkbaKgchsxPoeikF/AsTc0qfURNJ29B1EpbjRQtwTKtlP0cBDe4
 R3Q2S+PPQzUeciz/kZdSDw4wHfMKl+p2llBdlAcs/ik8Dn/3kpBPvy4qNI2DQ29FUP7CCvFr4xa
 q37vKf40qtkaTRDaHyU7RjQctx7awHFgrEnzzz4njkLXV94Q7E/KPBIW6DrFnHt1GgZWVE9s8u9
 xzK5q2q3gMJEKvMj/Qe6uwRAK2mZpYyZ3y8FDgxcSXIXMQKTHje7Tu2qbVcFh8EIW1+RBJun/Ht
 Q1plFUh0mLmhaO3JGWFQQm9y3y/gbBcYIqIEcrC3QoVsw3fEpRjXrbAeH8OxPXWZkgMbXq1YkEf
 RAxEwix1Yjxci4TBTpaiZuK464OShCbhfiGOeqz4OEhmpBgS37U6P/IvAm0TjxzyGdgug=
X-Received: by 2002:a05:600c:1c07:b0:477:561f:6fc8 with SMTP id
 5b1f17b1804b1-48379bac86bmr403881235e9.5.1771573397834; 
 Thu, 19 Feb 2026 23:43:17 -0800 (PST)
Received: from localhost ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31f0370sm98478555e9.11.2026.02.19.23.43.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 23:43:17 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Feb 2026 09:43:16 +0200
Message-Id: <DGJMCUYMMMGA.2LW9CCQPBKT2N@linaro.org>
Subject: Re: [PATCH 3/5] efi_selftest: remove unnecessary initializations
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
To: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 <u-boot@lists.denx.de>
Cc: "Heinrich Schuchardt" <xypron.glpk@gmx.de>, "Ilias Apalodimas"
 <ilias.apalodimas@linaro.org>, "Tom Rini" <trini@konsulko.com>
X-Mailer: aerc 0.21.0
References: <20260219184400.257008-1-vincent.stehle@arm.com>
 <20260219184400.257008-4-vincent.stehle@arm.com>
In-Reply-To: <20260219184400.257008-4-vincent.stehle@arm.com>
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

On Thu Feb 19, 2026 at 8:43 PM EET, Vincent Stehl=C3=A9 wrote:
> The UEFI function LocateHandleBuffer() always writes to the value pointed
> to by its NoHandles argument (in the test, `count'); remove the unnecessa=
ry
> initializations.
>
> Remove also one copy to buffer_size, which has become unnecessary.
>
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  lib/efi_selftest/efi_selftest_manageprotocols.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/lib/efi_selftest/efi_selftest_manageprotocols.c b/lib/efi_se=
lftest/efi_selftest_manageprotocols.c
> index 0334a074866..7fe7b285011 100644
> --- a/lib/efi_selftest/efi_selftest_manageprotocols.c
> +++ b/lib/efi_selftest/efi_selftest_manageprotocols.c
> @@ -219,7 +219,6 @@ static int execute(void)
>  	 *
>  	 *	handle1, handle2
>  	 */
> -	count =3D buffer_size;
>  	ret =3D boottime->locate_handle_buffer(BY_PROTOCOL, &guid1, NULL,
>  					     &count, &buffer);
>  	if (ret !=3D EFI_SUCCESS) {
> @@ -257,7 +256,6 @@ static int execute(void)
>  		efi_st_error("LocateHandle failed to locate new handles\n");
>  		return EFI_ST_FAILURE;
>  	}
> -	buffer_size =3D count;
>  	ret =3D find_in_buffer(handle1, count, buffer);
>  	if (ret !=3D EFI_SUCCESS) {
>  		efi_st_error("LocateHandle failed to locate new handles\n");
> @@ -303,7 +301,6 @@ static int execute(void)
>  	/*
>  	 * Check that the protocols are really uninstalled.
>  	 */
> -	count =3D buffer_size;
>  	ret =3D boottime->locate_handle_buffer(BY_PROTOCOL, &guid1, NULL,
>  					     &count, &buffer);
>  	if (ret !=3D EFI_SUCCESS) {

