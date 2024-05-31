Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE54C25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 06:50:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DB188829B;
	Fri, 31 May 2024 08:50:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="k1Can4Vy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5FA988781; Fri, 31 May 2024 08:50:15 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAE6D88270
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 08:50:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a6341cf2c99so170354366b.0
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 23:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717138213; x=1717743013; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HiVwBEpKpWcj8+iVw0VIQEUKUYg/MBIdoGOhrv3/LA0=;
 b=k1Can4VyUVV3X9+Jguc5SrNx66L77qVBnTQw8ykVnZMZdC5dRGxaRrEpA2MGoijpBT
 8SQA38vg/WRXA8POr5zuUyJt9Tpv+b0PeJ2y2HqUbkXYmlqW6i4N7YlB56fIavxdL/OW
 Tc664Ke3CARrG6QMYtquK9QzLE7I5mRQMIKy4LOa0qGSct1dkxBMuOpjDBLkzTFwYKza
 7nL/rbmq3RXGSZBaSmE1TIeJi3bCn5EPgSpaCcVxYmUzkP75bbiveqFHF7ajlbNmTb1k
 /hrkwGWt4FaSEIfRMcYs95859/QpeiW2BtSGDivweGO2a5E/XQfwjrjp2D2nbxoXVZfD
 pqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717138213; x=1717743013;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HiVwBEpKpWcj8+iVw0VIQEUKUYg/MBIdoGOhrv3/LA0=;
 b=oDWTZKPFya0aUKUIyjXBNTLpJBFxYGQgfcW+Ia2e+H6Mw/W+yG9v79f9wHQ0t1yUay
 k0CvNL3419UZ0Pcn/BfALcv3kQUAWS2W3N2T/k8EhU5UhGDux0KRJ3irG1A+CKT9AVz5
 KFJdn4tHf1J3Lzn/K1MBebUwaDUNaRZyL7A/FnJm+vraDatklNGAliMe15YCEgpsvs56
 BnTfF8wKh+vZMxyU/0ck5pg45aWrCqIrkmBMRxpi8jDRQPbpCa0T24a7p88mhmx+MYNP
 tQ8gZwdoarsHFdBDCtSJ6CFPTIdJvu2HC60xS3r9dLwacEd68j4Qbeg/nGLN3mEcvjNI
 9ooA==
X-Gm-Message-State: AOJu0YzeVDuNrVL62hiWxwKt1tj0r1L/IreTCm9pKBC9UqQA3hyGbInV
 hOF4BBc6ojNkRvcVyx6KQC3QlDDDAfQ9TcSu/cdJSDztNAZ9aq7UQBPVa+OyxFU=
X-Google-Smtp-Source: AGHT+IHQDRFLFVrywcz+ZztmFdJsiMfHAfo3aFDN7Yt6YCi9vGUdz0HYnKwjZDGMH8umXCs8WDR39Q==
X-Received: by 2002:a17:906:1c8b:b0:a65:d7f7:f3f5 with SMTP id
 a640c23a62f3a-a681f87e6aemr51440066b.8.1717138213161; 
 Thu, 30 May 2024 23:50:13 -0700 (PDT)
Received: from hera (ppp089210091242.access.hol.gr. [89.210.91.242])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a67eb344485sm52746666b.200.2024.05.30.23.50.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 23:50:11 -0700 (PDT)
Date: Fri, 31 May 2024 09:50:06 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Stefan Bosch <stefan_b@posteo.net>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Ilya Lukin <4.shket@gmail.com>, Sergei Antonov <saproj@gmail.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: Re: [PATCH v3 24/25] test: Remove ASN1 library test
Message-ID: <ZllzHmTQAb-Pg23U@hera>
References: <20240528140955.1960172-1-raymond.mao@linaro.org>
 <20240528140955.1960172-25-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528140955.1960172-25-raymond.mao@linaro.org>
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

On Tue, May 28, 2024 at 07:09:35AM -0700, Raymond Mao wrote:
> With MBEDTLS_LIB_X509 enabled, we don't build the original ASN1 lib,
> So remove it from test.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Initial patch.
> Changes in v3
> - None.
>
>  test/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/test/Kconfig b/test/Kconfig
> index e2ec0994a2e..558a9cd49b4 100644
> --- a/test/Kconfig
> +++ b/test/Kconfig
> @@ -32,7 +32,7 @@ if UT_LIB
>
>  config UT_LIB_ASN1
>  	bool "Unit test for asn1 compiler and decoder function"
> -	depends on SANDBOX
> +	depends on SANDBOX && !MBEDTLS_LIB_X509
>  	default y
>  	imply ASYMMETRIC_KEY_TYPE
>  	imply ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> --
> 2.25.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

