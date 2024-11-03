Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC628D11180
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 16:17:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4318F88E14;
	Sun,  3 Nov 2024 17:17:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="dw4FKfja";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2680688E19; Sun,  3 Nov 2024 17:17:09 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C88F788D70
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 17:17:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730650625; x=1731255425; i=xypron.glpk@gmx.de;
 bh=EC9m159P+uZ7C+pLYpbptt14mE0UbBt0j+J9sZyJxCo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=dw4FKfjagkZ1vedBG4CwDNhW7ADbAjuffD9bH8Ihm+b2AYdixxS+Q/KpVH4l6uHn
 L+tzEuh8ogFGUnlVsAcCQL6dM/oKiLT06CyRCOMIkQfBxxKBjYRzTgBuwExpRc5+O
 Bx5fjKg1L+3/Owq0wM14wR2Eg0ab3CojHEwRtscp4/DBGLvkCKA21tBORctAJusqB
 gmFs7WKfR4rP/KvhsvBFkQWtN6Y8qfam1BGGTuEMdMoHtmt6zE+wuTx1LvZPolzKm
 ElgtWTyFpL7CEVUMxEZN+9yoI74JN0PaMjYsOu89nBdUw20USYJa3sk2IS70vCm2v
 dFwDO9AhS716KJZdsg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAONd-1t0BJL3oMd-00H9y9; Sun, 03
 Nov 2024 17:17:05 +0100
Message-ID: <a415142d-de3f-40f6-af40-ea5babe0dfe8@gmx.de>
Date: Sun, 3 Nov 2024 17:17:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] kernel: Document ALIGN macros
To: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241103002828.624931-1-sjg@chromium.org>
 <20241103002828.624931-2-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241103002828.624931-2-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Rn13TaU6sSFm34q+pc925nlEgpgW73mvjY/7w0Sp8Hd/PCq/hf+
 PYAptEfyW3r6ZAG8keiVudzzk0sdZnYD8CNan//k34xxOabz3G8T545jxQ5J37fSq38mc99
 Ukqphb8VpVQqyAmZcVDQzT5dYk+LuOQV0Z64JSMyWShdxXQX+2tf0ULG6JEA2mWDLBRuyiK
 f8ULz7jxfuIueUJMq492Q==
UI-OutboundReport: notjunk:1;M01:P0:uL40ZSrrMeA=;iXVnTfUy7lo1nbN1FGO4XJlb8NX
 3+z6++a1jYQxATfoxCL/g3Wg6JLAZ1F8w2uU2fT3EP4cf1idqzkXh/TvWZswzfwbZLxbst/bF
 Wn0XY9O76cNa67vRRG2cEt7T3182lkFHfiiUCxnz7R4Jmfk5FkWRwD2rObqqRkcB1Ao6IwNwj
 XDma27Nm/uLi45vWs+hROfNrHWHyl3IhF9wCNfGHLdcNkzd1LpSkyzwQpmLcVF1/VVI5MRBBz
 CliAocV1Qnj2JWHGkxRmFNvf/SJTsAJFdhT2l15dsIyyJeVG6JkG3P0bj7rkSBT0jnRrLhqCq
 vXNrYHJkvcp5C7c/9U6dO4P2b5dzBxPoXeRfptUWA/RcpQ1PfYoProA/dDMg3zfCNpY4QiVhd
 hqIVVSE7bl25ApgTe7o4O26DO+x3XjAzraXLT9f9ivaqR+GUq5OtEHHxOIaZWb3g7j/wj2Ian
 nUfEFUgdmIFQvGW8AOo3sbC2YzAQ0lyfBrRb0abcmAy3jpqVt7hxGaA9GwWxaEhDE91Cm958s
 uUjsH0yYspN1p6K7sURRSD+/hNgV537EA5iU9ZhTt6mud1FtVlewDX57UObDpcTGAk37W4EJL
 31kGLNUHR2tekx0HDHNQpZq8OFkkP5V19g1VCD9AEhBo2EpL7SF0rj7e2iEZBx6HDt8Ed3bC7
 RO7yHT6GPTIIa4h6NvYjAD5Lg/DgwjwuR2rjYVD8BAESixda4mUZ+0ajqq9FI6xhYQYfHKXoV
 by6YUt9gVlVo2UAwDevLa4gyO7YRGTGX3t2lkeYMXEHJ5XvkuWMHEZXSV1W3+/ZGRqHBKeprH
 UolKKlBwWIULOLVGTFeOdQpA==
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

On 11/3/24 01:28, Simon Glass wrote:
> Add comments for these macros, so it is clear what they do.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>   include/linux/kernel.h | 31 +++++++++++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
>
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 9467edd65ab..e5557257e6f 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -35,9 +35,40 @@
>
>   #define REPEAT_BYTE(x)	((~0ul / 0xff) * (x))
>
> +/**
> + * Rounds a value up to a given alignment
> + *
> + * Note that @a must be a power of two
> + *
> + * Returns the lowest value >=3D @x which is a multiple of @a
> + *
> + * For example ALIGN(0x123, 8) =3D=3D 0x128
> + */

Thanks for describing the macros.

We follow
https://docs.kernel.org/doc-guide/kernel-doc.html#function-documentation
for function-like macros:

/**
  * ALIGN() - Rounds a value up to a given alignment
  *
  * @x: value to be rounded up
  * @a: alignment factor. @a must be a power of two.
  * Return: lowest value >=3D @x which is a multiple of @a
  *
  * For example ALIGN(0x123, 8) =3D=3D 0x128.
  */

Please, apply the same to all macros.

On the webpage there is also a rule for object like macros.

Best regards

Heinrich

>   #define ALIGN(x,a)		__ALIGN_MASK((x),(typeof(x))(a)-1)
> +
> +/**
> + * Rounds a down to a given alignment
> + *
> + * Note that @a must be a power of two
> + *
> + * Returns the highest value <=3D @x which is a multiple of @a
> + *
> + * For example ALIGN_DOWN(0x123, 8) =3D=3D 0x120
> + * ALIGN_DOWN(0x120, 16) =3D=3D 0x120
> + */
>   #define ALIGN_DOWN(x, a)	ALIGN((x) - ((a) - 1), (a))
> +
> +/**
> + * Rounds a value up to a given alignment-mask
> +*
> + * Note that @mask must be one less than a power of two
> + *
> + * Returns the lowest value >=3D @x where the bits set in @mask are 0
> + *
> + * For example __ALIGN_MASK(0x123, 0xf) =3D=3D 0x130
> + */
>   #define __ALIGN_MASK(x,mask)	(((x)+(mask))&~(mask))
> +
>   #define PTR_ALIGN(p, a)		((typeof(p))ALIGN((unsigned long)(p), (a)))
>   #define IS_ALIGNED(x, a)		(((x) & ((typeof(x))(a) - 1)) =3D=3D 0)
>

