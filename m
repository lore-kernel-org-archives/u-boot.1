Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F341C25B79
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 14:37:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 989BC881AC;
	Wed, 15 May 2024 16:37:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cqqs9mp/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 593F488233; Wed, 15 May 2024 16:37:46 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24CC588176
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 16:37:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-23d38cd0df6so3947062fac.2
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 07:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715783863; x=1716388663; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=A3HI6jwobBXgIhRBdZy5dGxHbzAd3Bzd+gFdMIUs344=;
 b=cqqs9mp/OIHq8mwP6G35XDWmDkSasqS9mvOpZcPaEPn1waY+7GP2FKAWa6oSZKPfzk
 8dwZOS32WVbZuS6C5ufc1MZuTqmfGmIfA+4iuTXeimhgkVg6Z0SWV2tOZ9u3Q4DI7avq
 coBPmpbTngqEtWSSdQi/SuH1Xyffmx7NK/D2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715783863; x=1716388663;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A3HI6jwobBXgIhRBdZy5dGxHbzAd3Bzd+gFdMIUs344=;
 b=XAK/PceCGbVsh/y2SJVQ4DMrR5eqKU60pEztMDWapv48uWmvmqKsChRCkdHA5Svbh1
 HoQNhgccNJbCu1A0hBhQdLoopNe1x0D3dJwpAOHZmJYh+ebBjsViZ87smL7hZ70nmqn0
 ukWwKcNYOVpWPWj1DuwtvUOLFpo1BR0Wdi24Flobf3c3mLBgSNXfEHqFLPZp2wQalH8r
 iXWQG7mnA5jDhd3DSjW1zPuA4PUir0Oh5vppVJ1PNPzgPjjKATpq/4EnZymIBpDknIFc
 9LIlfhUM5D4qGDzkhpUyFP3EX6wyUpCBSsmbA5IOBk+wQM/XIXyVvLoHfKiYdZwzPhtb
 kNHA==
X-Gm-Message-State: AOJu0Yws8jdVo4N9geWaSqw8HqU0Uc5ZYh6cL6BsbCrYrYLCpLtuO7xa
 AQMvuJyfvqpgY7lOcQ3Q02EFeeI1i+Aael66oUtS3dyz7E7d99obv29FJaBlHyA=
X-Google-Smtp-Source: AGHT+IGQxZXGcg3SfXt7oTtEUHg1t80vPADjlw7zw6NZgP+xqL55ecLrl+o3LPOMxDxSnv9SL0FXLQ==
X-Received: by 2002:a05:6870:648f:b0:233:d4b3:9b30 with SMTP id
 586e51a60fabf-24172a2371dmr18435590fac.1.1715783862760; 
 Wed, 15 May 2024 07:37:42 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43df56d482fsm83089651cf.89.2024.05.15.07.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 07:37:41 -0700 (PDT)
Date: Wed, 15 May 2024 08:37:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Tony Dinh <mibodhi@gmail.com>, Phil Sutter <phil@nwl.cc>,
 Walter Schweizer <swwa@users.sourceforge.net>,
 Mario Six <mario.six@gdsys.cc>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Nishanth Menon <nm@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Jonathan Humphreys <j-humphreys@ti.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Eddie James <eajames@linux.ibm.com>,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 uboot-snps-arc@synopsys.com
Subject: Re: [PATCH v2 4/4] include: Move snprintf to stdio.h
Message-ID: <20240515143737.GV2568172@bill-the-cat>
References: <20240515123213.1701691-1-raymond.mao@linaro.org>
 <20240515123213.1701691-5-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BjJsZ4OK3daEgnqX"
Content-Disposition: inline
In-Reply-To: <20240515123213.1701691-5-raymond.mao@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
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


--BjJsZ4OK3daEgnqX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 05:31:59AM -0700, Raymond Mao wrote:

> Move snprintf to stdio.h since it is needed by exteranl libraries.
>=20
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>

Thanks for doing the work. One problem:

> diff --git a/include/stdio.h b/include/stdio.h
> index 3241e2d493f..ecd0f996efb 100644
> --- a/include/stdio.h
> +++ b/include/stdio.h
> @@ -45,6 +45,7 @@ static inline int vprintf(const char *fmt, va_list args)
>  	return 0;
>  }
>  #endif
> +int snprintf(char *buf, size_t size, const char *fmt, ...);
> =20
>  /*
>   * FILE based functions (can only be used AFTER relocation!)
> diff --git a/include/vsprintf.h b/include/vsprintf.h
> index ed8a060ee17..fe951471426 100644
> --- a/include/vsprintf.h
> +++ b/include/vsprintf.h
> @@ -218,23 +218,6 @@ char *simple_itoa(ulong val);
>   */
>  char *simple_xtoa(ulong num);
> =20
> -/**
> - * Format a string and place it in a buffer
> - *
> - * @buf: The buffer to place the result into
> - * @size: The size of the buffer, including the trailing null space
> - * @fmt: The format string to use
> - * @...: Arguments for the format string
> - * Return: the number of characters which would be
> - * generated for the given input, excluding the trailing null,
> - * as per ISO C99.  If the return is greater than or equal to
> - * @size, the resulting string is truncated.
> - *
> - * See the vsprintf() documentation for format string extensions over C9=
9.
> - */
> -int snprintf(char *buf, size_t size, const char *fmt, ...)
> -		__attribute__ ((format (__printf__, 3, 4)));
> -
>  /**
>   * Format a string and place it in a buffer
>   *

Please move the whole thing, comment and attributes over not just the
basic prototype, thanks.

--=20
Tom

--BjJsZ4OK3daEgnqX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZEyK0ACgkQFHw5/5Y0
tyyxFwwApEq+bB6Bibk5pEJ8xn6bh3x1upCaAzW3YoCYlR9QTYEgUnn1tGwuRKGp
ahZrhVvepvm3GUMOfCNp1hkqcY+dEPzT6L2jLezwVP2pOvxCMS1QvSqHd/NQf2kh
rgyD8bVmMUXtbCMQVg0ZzkmN1xzYaykyvDSDw6R3Q43QFpWq8pLU1uN5qfEXHhXk
iGOZCxp1yKp28vDIqucyiN+qPtBPjBcjmmz+OgxWjnY12itJc1lKoL8dh43lfncW
Jganl+gWmZ5qYenUB4Gy0TX+uct4wMqzAQDrIciLVr7lr8P+myskPeO97bpHay7g
qS5WK0r7pgQ+fj9w6mADr2awTtvJsKpZOIDRs3nSfGH/YRv9c92oaY50+HKDwMow
R3iMuKyuY3v3ikfMS+LkGTY5P4k0sqXlR787dY2qoVorcyk79vzwJKqXVM/hr8K2
jqu+HxwbEx8LJFkmiTpdouzFnSidHJUPqAaKv/C6UcHIIlcxR8m/a9srEgrWuksy
Y1T/1uz1
=O4jg
-----END PGP SIGNATURE-----

--BjJsZ4OK3daEgnqX--
