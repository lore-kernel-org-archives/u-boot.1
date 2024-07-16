Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C57C3DA4B
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 02:51:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB59B86BF1;
	Tue, 16 Jul 2024 04:51:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="PiIB0g0q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69BCC8894E; Tue, 16 Jul 2024 04:51:43 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 305DF87919
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 04:51:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1721098289; x=1721703089; i=xypron.glpk@gmx.de;
 bh=2xB9yzsyEat+9GFeSpUuKcclr5hxM9lt0h75HQcecPQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=PiIB0g0qEDW1evIZNzxv8HaC2xqRwkOqbXgpERdQGjPQdBVRaPGYoCJamAO+ZhtX
 C8s/iwdkvCcK9tw/Owfr//yY/jXEW8kw+2aTEV8XEljLzvJQOKkksvvAO+3mlc3eM
 KKf6VpM9PxSkqhBPA7tnhpoyK5XRrAWXbzU6R2PmScuVgbFnXc9wxrQdaCntYUr66
 eCIm3ivjzYX9Tw6F2J+1JKcxAmjAPNUe/WfdV1eB03n8BE5bnxFOCO7gePobJJqP6
 rdcHmXVRlviotnSiJll9CUajtxKwUbt815naw5qOT0w90/FiUN7o42N7i/RIj3B6K
 K8rjY+zGaarytKO9eQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.93.80]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVNB1-1st1uw1M4V-00HuFg; Tue, 16
 Jul 2024 04:51:29 +0200
Message-ID: <7629786a-5fde-4f3a-8d81-c1428b8ed437@gmx.de>
Date: Tue, 16 Jul 2024 04:51:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: fit: add ELF image to list of image formats
To: Maxim Moskalets <maximmosk4@gmail.com>
Cc: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>, u-boot@lists.denx.de,
 trini@konsulko.com, sam.povilus@amd.com, sjg@chromium.org, bage@debian.org
References: <20240715193300.11770-1-Maxim.Moskalets@kaspersky.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240715193300.11770-1-Maxim.Moskalets@kaspersky.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7AWcFZFJGjBS0+pSn/9TjmW9OBldtsVcHb8KbmEXGTCvY8Y8j0+
 6p8GI5RoDaOMmgwp+xJ0uITiooYr8YxQnst/bQSVE3f9y9AFURBr4V1fdpUbEIDLVxXQA/n
 1HErWKqMw0VfOBwW/FQWDyl7xjVSVHjnj341x5tlEmZUG+LwMdS504LmM4Q1tWVo9PhaS3O
 qdxZzLSL4n0vcxWrG8Ifg==
UI-OutboundReport: notjunk:1;M01:P0:QfjXMN/2S6M=;yhUexnsDhy1s2zUwrS52fICRb1J
 paBUGkUrCggX98JRHvzt2I9mea+dZ2WzUAIhrCd1MMH/al2e/3EkEpfEmcMtt8OLNLv6u+8id
 ws610j8tKWazHBpNyPHw3IgmqlnVzxwzU25uD/KqoY1FFuq46H7g7D8XJabqVPpsEM2G1WW3G
 e3HbMj6F4FDmfaysNjgNXsXGXCFGBgrA8l4ndYk206CpeB8Hl5sF9x8RzllNdJ4/SVVGWv9mS
 2rA5NvqEV3yo6h7sdsjhfbNPegMBw1+4Roka00G8wGIMGn1O4bO5yhjt4ltgxzxNj7EDgNoXx
 Etqr/4TcPGlo2HWi6wbN3juS8HCnPM3SlLIvUSg5z9c1BPlN3bWcNBW7Fv04FpwWsajc581Sr
 gNTQCi6+1po5ecOPLybT0sDQkounlQx1ylQ5y1Lse28RQOVYyw/Muh68Ly0yhNZcFQt95XeZB
 p0L4bpO7xq5A0VdycmFiRdYd4ezGyGlnZ8SUp6g4rflVyVUfirKOb1/l+G40XMYdSrLCFmVUn
 4htJov4J5IkTbwLAxgI8VHsQZpwgVxFYD43wnoQRUnpq3IHO6XUqmUSPE390wKJ6xLD1QW4kv
 o1U8EZmWm2lXOP6Lg55MSEc1Kr1cFXpp364rbtAdsJ6JKPAyNnKtz+KN61Ifx1dlC+2XzUoeO
 HE4i5iKak0wPK+zpVuX2Xi48W9GddlFs12E+SL7t5xCzEIe+Sz+BsYFjGFmAwJeV00nnf2Dk/
 dO7tgKk39C7CVHFZB2/oiMxVWXgoDIhI7RP44KbFsH36O1rMy2sAljDfzUXso88g15/bWLgVp
 qxjUGfG93scrLqlQzuq7iJEw==
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

On 7/15/24 21:33, Maxim Moskalets wrote:
> Signed-off-by: Maxim Moskalets <maximmosk4@gmail.com>

Please, always provide a commit message. Otherwise looks good to me.

This series suggested to eliminate source_file_format.rst:

https://patchwork.ozlabs.org/project/uboot/list/?series=3D414308

Best regards

Heinrich

> ---
>   doc/usage/fit/source_file_format.rst | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/doc/usage/fit/source_file_format.rst b/doc/usage/fit/source=
_file_format.rst
> index 15990e3ff54..cb5da5af2dd 100644
> --- a/doc/usage/fit/source_file_format.rst
> +++ b/doc/usage/fit/source_file_format.rst
> @@ -287,6 +287,7 @@ os
>       arm-trusted-firmware  ARM Trusted Firmware
>       dell                  Dell
>       efi                   EFI Firmware
> +    elf                   ELF Image
>       esix                  Esix
>       freebsd               FreeBSD
>       integrity             INTEGRITY

