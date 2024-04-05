Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92454C67861
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 07:51:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1769E88478;
	Fri,  5 Apr 2024 09:51:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="HtYYx6Bp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A6EC88478; Fri,  5 Apr 2024 09:51:27 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5333388477
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 09:51:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1712303483; x=1712908283; i=xypron.glpk@gmx.de;
 bh=bG6f9BsyjHutGS0MzrEa7vXbe3/gOGcuBPgyqC+coug=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=HtYYx6BpGbveP11NOj/1AZXx1zFqi8husFfqmIvvdSgqDK0gdlt5dh7TESJJiQ8L
 J9n75tYn8Y/4F2FqLnDXTTJlkxO2wf0ZirY8EdPfFhzmMCpOyVxw5H/KW9TZP+vmq
 9RA8RbWhx7mcIMHIY6DGr+13Enn85X4e8Vr98t+nnSU7QTKNOnWPrOOYrdJcPJvfa
 f/8ru1s1TWXDbWVa3uKSAiKUzsSmUm/16h3neu9B5TsuZQJdmzffsOSVe4YAW1bME
 oiuHA8h7BBQzTg2+AVFjzVa3WU5TyGypb5ZIqoRRui5/qi41ETLzBv2lFJwZLNz09
 q5SOBZ0ixUfhPLFrzQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfYLQ-1sTv2h2KQC-00g0hl; Fri, 05
 Apr 2024 09:51:23 +0200
Message-ID: <d64ce286-5088-4f18-a7c8-aed96842a03f@gmx.de>
Date: Fri, 5 Apr 2024 09:51:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: build: update docker image to latest
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
References: <20240405-doc-container-img-v1-1-f1e0ec59f5d9@baylibre.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240405-doc-container-img-v1-1-f1e0ec59f5d9@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2ORzEfQzBqA7wVqLFpcBA7CsXXlmmW780ht9Yy84TP2JzH4CPK6
 C2NOAKymJt8FR4EczbcJ8AEfDRPNdMC1rOzwijGYXoIr2YeJ79/zh6f2RD51OxBd4/V96GO
 oJx5iitVQkep+px2cADbCG+6kEUWs6OffXTt4G5XXsqFOK5aVCcS2rpSN31yQLX0CKtcgTl
 mKGUTEKOs/ruZa67isHZg==
UI-OutboundReport: notjunk:1;M01:P0:k2kgONlltKg=;4FvqILKGFezjMMB+O6X317Ykjay
 Y5qp1ExUGuYfD+AkIUxc4E84UiAqkVqbMb1aeu38cE7n8iA5meGjllXT7rb7fcaQW1dvDP+X/
 g4KD/PPSBpTzgzgWZUthgOQ7t2V/wi93QCCnKkANwcIRl5vqacomY4SwwGmYi0wkfDFkzofy5
 Pdd/YSlxTwMjMFA9jxN+yIqRwaXqpPst3mxEahPzJDW5bTAUi0HMs2KRhw9thyJo+JBDjEdz0
 qQC50XMq1Vg2s8k3hz5DnkxQDSOVDj08GlHpuB3s7rd4NwqDFVSc8TidhA1kxb4xODe3tcWJS
 HdcFQrrfL6BlRpmPxl2s2yrkau5XUNHF1fq/cvvfnhzhgm3hYpEuQvhxg4GKE+yyzGX1e1JOe
 xC42+jS7n5MNE6iRuIsm1uLtptHaZijUUE/+yX76/A7UY1Jf21njywpKNb4ugt2LY11NHxyb8
 Y3DxMxFeOr/bF0/miw5w/AYp2FJ3SG6VLesHRKpstODry4Irkaolh04uJlaC9HXeQ1ryDpca0
 QppTLYh7iHrvgvc9JRDdxYEm5B6LXJgONPyqwsPVqbrgtQmhy+BcA3atANYAa3dPZ45qd3H9t
 fHNn4dO6tFQYx6mrixsyPdK2AgSw+zFSgQihIh4rDacYBkIESH2mxUxlYqCs/8lk8z/nNQ189
 nEwZ5BJWyrgU7e5ExKtaAjpojkaxE12uGN3wCsw0kQXfxW99nK/S4HnyHdBZq4FLKFcgv6K8A
 5H9zRjVX4LPFvTRTMnaHDWi1uHyY88+yki1VndlMYFo/CWT0eOpNPTLp6YDQ7vTXMpO1qJ+EA
 aBzfJl8ORERf16usbxQHnIA2w3iiDNRT0bo/dW1Qiz3ic=
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

On 4/5/24 08:16, Mattijs Korpershoek wrote:
> commit cacc0b2678c0 ("CI: Move to latest container image") updated the
> docker container image.
>
> Reflect the change in the documentation.
>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
> Note: maybe we can consider doing the doc change each time we update
> .gitlab-ci.yml ?
> ---
>   doc/build/docker.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/doc/build/docker.rst b/doc/build/docker.rst
> index 953d1b28a063..45659b3b89dc 100644
> --- a/doc/build/docker.rst
> +++ b/doc/build/docker.rst
> @@ -11,4 +11,4 @@ Or to use an existing container
>
>   .. code-block:: bash
>
> -    sudo docker pull trini/u-boot-gitlab-ci-runner:bionic-20200807-02Se=
p2020
> +    sudo docker pull trini/u-boot-gitlab-ci-runner:jammy-20240227-14Mar=
2024
>
> ---
> base-commit: cdfcc37428e06f4730ab9a17cc084eeb7676ea1a
> change-id: 20240405-doc-container-img-904d56d5efcb
>
> Best regards,

