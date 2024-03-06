Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD63C54E41
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 08:50:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D651876F3;
	Wed,  6 Mar 2024 09:50:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="GMtqxDoS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2F1C877B1; Wed,  6 Mar 2024 09:50:11 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9072876E4
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 09:50:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1709715008; x=1710319808; i=xypron.glpk@gmx.de;
 bh=xAVTzeRFiPzsu7lsU3LwQBi/wazPTc/Na3HNAhCU2Fk=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=GMtqxDoSjjPPoC5XNIWFt/5jaohhO0cv3GL7z7kS/IHH/KBMmas5qSCBeSNatyRW
 t6nQ3aZYzicchilTNezuBd/YWAOqhp8nJW49tNJBrCdt5zMDIzq0bHqpPFC0BnXaZ
 X5agPysERHuZSCQtbN3hjOsFRy7XBbdSihQpZP91qSxM4mW3CSKNJilmSTZwzNPwo
 uOCYmyL7R33rKX1UuguQY32XUT4ClMym/AifV6sR47XVx+p+u1pnd8ItMpD25I5jz
 KMXmboT94UgRoXz3j2bH4UEft+v5+7yboQit1RE90o+6sf8x9PGaa+1P6iEoLSk4/
 eWH91t2PU7Ru/OdM+A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.107] ([109.42.176.242]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGhuK-1rdv6Y1Lak-00DqFm; Wed, 06
 Mar 2024 09:50:08 +0100
Message-ID: <32e53e2a-6269-46bf-93e6-21d616a9ff5c@gmx.de>
Date: Wed, 6 Mar 2024 09:50:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sandbox: select CONFIG_64BIT for SANDBOX64
Content-Language: en-US, de-DE
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>
References: <4ee938f4-7e75-4348-9237-6d2cbe4ae67a@moroto.mountain>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <4ee938f4-7e75-4348-9237-6d2cbe4ae67a@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kA8G/QDrnSjh72L3xBXPSTRtvIKYDIcriiUoHYRbSgFT8pZEF0s
 8CVqTRBFmJ/wn1GYhQ3Y9qV6TizmD7YJm658pdsXgKq0CqQXx0ScMqazqYSwWSv4JHjh1dq
 MG14xNx+skOhMXWtTY7t+0gp+0AOFtM27eUyGzre8bk71RyCXV7nWA+t6l264g01YqLcxof
 1znL6JUYbvlm27OWjgH7g==
UI-OutboundReport: notjunk:1;M01:P0:kmoa+vVNpOQ=;SuFfkrJILi1dCQF0T7sYdHFdC/q
 ImlGcysMVEeesRE/rRhiGt/l65tMXvkQazujoaRKO0kqx9U1HzGLzGqISlHdqfumYjAd31/YO
 m6/fkyqqlaUOT3UlijYl0p9XTCUqjXf5KgGvych5yJhnLfZbXpSLQA1sh0Ya+vwOXswF6H0w2
 UhUVIqaBApLKiQ/M7ulWoqLMxrBg1g3q9iNyTGc7MPiX4LDTVW1Nk+s1QAQaWlvhGbtoJpfXI
 wnP7JP0YaMkhcWd7dNntzJ8pfdo+pYKGKDJoX35tl533V7v8a8VTNxttbciLPOWf7XHFFCVuV
 R95yuQ6i3k59BHz9XbheKAtutQG3Y9A32sMqCJ5KimTemYwr/YGXdvXztPPQMqUOAFjw2rfLS
 jj9gF4yU8uxnNaokCfUjjr2krBIVQL3SQ/IFf4KH1YlVDn+/A3zvp5CWMF7lXB43AxCVBdw5J
 ROxYgNVLTPtyTZd2NLk7/7YkYvIPeenVuKTHiDGRWd5YDhfmtT6A+4DigwSs8kkC2+hk6MTv9
 zA/Lnse+sWOpQ8NGud8Vcyw4op+CUEhsmjNvGgZFbtsrd2sEoiOwYh462+7q47g89OLLUJOQv
 ubeD6Ut9n5TR3o6hajYD+6DGmbxGV640NU1UPWV8+8ECEiye22ad2Ih6PCSSZXGEYQSpPvaQ5
 KQsgLj09kCksfqJ6cgbxOT0I5zy72YHfe9X6DKejyf1xzir2B232zCt2iz/KubkK049xc+FI0
 dw+qjqrVjvh78mGBQn0S33IurGo6VqBzcJOnz2erOXAyI0qJRC9FuEhWdexO4Aso5Pfl0c48z
 8xed5Vz/RGJWMJjo6tvA6akB6knCOVU4tLIzDzH60KUec=
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

On 3/5/24 16:16, Dan Carpenter wrote:
> Select CONFIG_64BIT so that we pass the -m64 option (instead of -m32) to
> static analysis tools.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   arch/sandbox/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/sandbox/Kconfig b/arch/sandbox/Kconfig
> index 0ce77de2fcb4..c431da60e8c4 100644
> --- a/arch/sandbox/Kconfig
> +++ b/arch/sandbox/Kconfig
> @@ -12,6 +12,7 @@ config SYS_CPU
>
>   config SANDBOX64
>   	bool "Use 64-bit addresses"
> +	select 64BIT

SANDBOX64 seems only to control the size of phys_addr_t, phys_size_t,
dma_addr_t.

Please, have a look at symbol SANDBOX_BITS_PER_LONG. It is controlled by
HOST_64BIT, not by SANDBOX64. Isn't this closer related to the -m32/-m64
choice?

Best regards

Heinrich

>   	select PHYS_64BIT
>   	depends on HOST_64BIT
>

