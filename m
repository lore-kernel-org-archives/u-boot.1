Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B940CD1288
	for <u-boot@archiver.kernel.org>; Sat, 30 Mar 2024 21:42:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D621087E2E;
	Sat, 30 Mar 2024 22:42:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="jhRQUYiq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E372882A1; Sat, 30 Mar 2024 22:42:34 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3800F87873
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 22:42:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1711834942; x=1712439742; i=xypron.glpk@gmx.de;
 bh=HzDuaBN+HRuOfZYWK2HeTc0/NVVKYLGuxUXvfxC0flQ=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=jhRQUYiq3YOpB7KXbvwz3LddD4NqCPKBnQyWlVwjp97Cyr8YX+Lkc2eIJjBZ2UUz
 FuYvxvp4powT89z9wMb5DJi5ThUerGNO0O0+DRc8qE5/9EvjLYKGWAAuIq2fADcov
 HiL+0GjcMBBKzeMSC5qlRDGwRiNs1HRHqk768/8J3tQlHqUM1lwuwiR6WIObzYbEJ
 IWMXIxshcP+KmbX11/c5x19y5TEmHZGgNelNS/Q+l8Ixx50VUDiaSB1fC/cFFqGHf
 jciCpcobYVkmJ9fgsqcX8KVZ87gUVXgK2byuyABCJMAYNcHqz1HK2j2tyJjXEADGH
 AzdRBVy4kwDK7xLEeQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNt0M-1sAZrK3A1A-00OKR9; Sat, 30
 Mar 2024 22:42:22 +0100
Message-ID: <adb0dd0d-dfd2-4c02-95d5-1c301da24269@gmx.de>
Date: Sat, 30 Mar 2024 22:42:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib: add missing line breaks in debug messages
To: Maxim Moskalets <maximmosk4@gmail.com>
Cc: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>, sjg@chromium.org,
 trini@konsulko.com, u-boot@lists.denx.de
References: <20240330111121.5935-1-Maxim.Moskalets@kaspersky.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240330111121.5935-1-Maxim.Moskalets@kaspersky.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1/xpSzY6qoZdU0yMvW6T8SG6joyn7iZ5h+6a7hzfDPGBKMNt7E9
 M/VmDtdxE6ztS5llZORFaJGol63V28k7dSBoGppP84nA9IsPLNvbyc19PDV+RLWhhQTWhim
 BVTrlTilHTxZnCFOS2l6+ZZPNv/EA+xG7Ri6Flv1Ntx/q/d6XTwu+2nc470fg+pbbHyQh8g
 1W9i26uzRXNcItEtTsPuQ==
UI-OutboundReport: notjunk:1;M01:P0:W5LQnlpPzEw=;2+oAUhCg8onMU0hQfuiF9rXpnRC
 vJTr0njdyI/eIv0AAE1lZqZO+uqHpivN8TpyenD2z78C1sDgAd7uO6VBimq5/fDQlE7QRuFHS
 ioWKS7fxihtODoBJIhcJyeTAsmW3V3PiMJ+3hzyzDEFrt9JELSPfggPlyFi08Iu54q6Ffu190
 IUOmOnrBCe8WpP28yMyzplWuZlbloWhH86oLj1KyVn2xiT8JGnIWyDO35fu7jVqawVcfpsaWi
 DuRZfYfDqVBiJ44Ppdoh3QGF6qXNXY+xGgvfW613upXS82fEmny0a++X9I9t8NjZVad8jM1+H
 +3wV/eTo+w6gYyyof54MCNW9KDUqL0dfoKTJqxBmb6WVaY7oybv5mDqN8vp9fhQQS+QkkNnay
 fZ+xrRrhVBgReqecpSz2yVWxxP27BiQ3bPb9VSmnsigVjMkUFdfd4DcHUVDzdHsUdsT8rrTwq
 YPXcra8DG2Y4gZMg/vKfEBqlrLO3xr44WY/MVeWRVvHgpv37u1DKgaroX8NHv7EbY1X64eWwV
 G/3eOmgFglC7ScqGBwOVeo5B1fO09+650D1jJbJxgNhD9lBOTsGHmUoRKqFE/WItI/lNsfzx8
 C/DfoNsAU3XYX/Q7SVOzUgOk/IEQR2jR7mleJbe+b9Igk/XAgs9sGQ7TWOJ/tqksIicUJyMev
 bvyfUCtKnzNLMP3RBEIOxEQSPq7qwKkwPtwciq/LxH7JdvQkPDDxPKjohAYQadCGysBWo1t8t
 xil2vuLl4RqVGZO1M3NLL+aapjxgiGrJ0HbySj+cYlu/YJCOk06Cij4GEi2KAOCNAIlDb3D03
 Au5jFjvqt68F6cKNY55ekNJhoFGgrGcpzITci8/0X/FoE=
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

On 3/30/24 12:11, Maxim Moskalets wrote:
> Add missing line breaks to improve debug log readability.
>
> Signed-off-by: Maxim Moskalets <maximmosk4@gmail.com>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   lib/rsa/rsa-verify.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/lib/rsa/rsa-verify.c b/lib/rsa/rsa-verify.c
> index 1007b6979a..d3b4f71d6b 100644
> --- a/lib/rsa/rsa-verify.c
> +++ b/lib/rsa/rsa-verify.c
> @@ -342,7 +342,7 @@ static int rsa_verify_key(struct image_sign_info *in=
fo,
>   		return -EINVAL;
>   	}
>
> -	debug("Checksum algorithm: %s", checksum->name);
> +	debug("Checksum algorithm: %s\n", checksum->name);
>
>   	/* Sanity check for stack size */
>   	if (sig_len > RSA_MAX_SIG_BITS / 8) {
> @@ -444,13 +444,13 @@ static int rsa_verify_with_keynode(struct image_si=
gn_info *info,
>   	const char *algo;
>
>   	if (node < 0) {
> -		debug("%s: Skipping invalid node", __func__);
> +		debug("%s: Skipping invalid node\n", __func__);
>   		return -EBADF;
>   	}
>
>   	algo =3D fdt_getprop(blob, node, "algo", NULL);
>   	if (strcmp(info->name, algo)) {
> -		debug("%s: Wrong algo: have %s, expected %s", __func__,
> +		debug("%s: Wrong algo: have %s, expected %s\n", __func__,
>   		      info->name, algo);
>   		return -EFAULT;
>   	}
> @@ -470,7 +470,7 @@ static int rsa_verify_with_keynode(struct image_sign=
_info *info,
>   	prop.rr =3D fdt_getprop(blob, node, "rsa,r-squared", NULL);
>
>   	if (!prop.num_bits || !prop.modulus || !prop.rr) {
> -		debug("%s: Missing RSA key info", __func__);
> +		debug("%s: Missing RSA key info\n", __func__);
>   		return -EFAULT;
>   	}
>

