Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7170CC19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 12:39:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF767810ED;
	Fri, 28 Feb 2025 13:39:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="rpVVVlxs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94CD98110C; Fri, 28 Feb 2025 13:39:01 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83A7A80BA4
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 13:38:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1740746326; x=1741351126; i=xypron.glpk@gmx.de;
 bh=r/2xicE5Q+ws6NGSW220byXoHufWytcFCdfZmAd6zg0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=rpVVVlxsYs9Yx/JU+ZLnHG8g1s7XJGwK0Mt8epNvwIDVGctNwk5IYMGN2aCAuxnB
 G+xTkqONVcWbFpaWceQXXCwRCJsm+eu/5+bs46T9+h2R6rZYNsQq725gz29TYH/bd
 WCD3ZNm3jI/5OF8kRxdf430t3MolMCOWNX6buzzYr/LDj/RIROvk1w+SumN7qNZx/
 v7ac4g0oLCBfEfDrmL3xOKQZ27YSCuI/kFqTZ/XgmjGjs1mTVQ7+fO4e/Yy3FA/Zp
 DUcfrsYEGVOaIsP6ohtEUb2m3iv9Xi1N70C5DBLBRjb/EIVoLltpLBCWN6g/mnsXY
 IcBhoJGw3rE8EZuPxw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M4JmT-1tniel0wwD-00Dg0N; Fri, 28
 Feb 2025 13:38:46 +0100
Message-ID: <df59292e-0681-4cc3-bd2b-c75181091bd8@gmx.de>
Date: Fri, 28 Feb 2025 13:38:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] arch: introduce symbol HAVE_INITJMP
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Simon Glass <sjg@chromium.org>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, u-boot@lists.denx.de,
 Yu-Chien Peter Lin <peter.lin@sifive.com>
References: <cover.1740499185.git.jerome.forissier@linaro.org>
 <2589612a53a9e9feb67b8e8286e87893359676d1.1740499185.git.jerome.forissier@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <2589612a53a9e9feb67b8e8286e87893359676d1.1740499185.git.jerome.forissier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+sVGrFwF1pcKQQw1RHiP/oD0IVLR+MNl5wJHBOtWmhYaU+Lsm7O
 PPO/HYhXf7gDQBg53U2wzFIPw+IE4sQ6cGsWZeF4wqvCItedbn8WucDavWAOT+NxGNrKt8p
 CasoE4x7koeZu6pZT7ZesqmpmJWh4z483xsMeG/f2AZBJZ+n74VVPO6yPJYwSwAv01ibvcm
 QMr8cKcOJtd54v5zXpd3g==
UI-OutboundReport: notjunk:1;M01:P0:CKuDhPsLf08=;41g/mxAG8nKtESX93EH3EmQigr5
 seLRH9W/fRYAsBAbUOdYzH4EgSmCxTMnUhARv3FkZI9DWJqfhzeGitdDjHRDaBi2B8d897Vs/
 hqsQLmJ8EGVXOoi00BFy+vxIJqhWDM2oKv8ch9CgNQ6f0KJUSSbFNOyNEZyHr/79AKSIc1KQP
 uZr1LIQT03+Jv8/7rmKWv67NLGFM9f2ktUq4M6BFAFmztwgvssU6FhPCjcRek2niwokwBbw+2
 Ib2BDwk6GuJOBVd+R585FspoC1lGFkZOmXiJTU77qVUKtGls9v4FjhYPnL/rE6ERrrFEya3r4
 fDlaI2y+hl1g5+mxfeCxVkgOHq6vcfVb5Gzl/BDJDRtX4T9v7FHC2Rx2lCxnDi5nkqdaI67J+
 ey+nD2zROpAmSzg8cNCs9w4XUlFIFC5p84X3vrj0LrDXcKRZYZlp2ImDLFVSRsXPpSioXWEzx
 x1BIM9BAeBSINFEr0zkYHgwaEReAhPVGi9N3/L5ySkJORsAh/PSK/ebpVokJya1AVeNeT8uZs
 ZGgMFYcI8xfbfmy1FzwdI768/MzhZsfLV2Jf/9UMg+7GqcCVKJR6iLMT53Omb9IbVlqNpCAgJ
 /oYcTfIv3o2rlAbTxjQPvFiehUArSLqaorVK+durTUENv+dnGPgd/nw7SmCHE9av6qK25qRFZ
 MF3FiUq1uQyoKo3usr7DXgcyi5ykyJjDRcJMl5qbTWSAv2Y8yB1oWLEiGhbOVpgKAPakQ2ROW
 vVgfZngmap5N0CYaSLYsp0nky/A8kHn8f6spa0xpi1t+UZPF1JLov13p2hZJT9UkGIwbGqSX5
 muN4a+Qo2esk8HqMW/HBSa4gR5GtVJvaLYNyXQ0UGWya8dTSpoWxAD7KrxjZ73rAdb3zB6Bxs
 4Ej1aTRggXjep+9RpPTY7QV15prpDCjMyhyEKYMSSRfabMcchewQtUEN5nkPxkWAzCZT16xQP
 +sI0y0jgZ39n4ZqBrM9YG54MUs8jM4AfD3eOhfaPiDZ5mzPq8lX9w3XHuY09E9UiWwN4Qr7Z7
 yFDl1tduG+ewE450s6nQw4ddr7qOs2KEIyFCZVdS7oA7APL1hmwSUA8nlV9CLAhbwRKlvof+J
 4fEOyAVyKv2Yg0rrtBLd/z+JIafPUCuOcz5LXhJyJpgB3jmfAWj9vBF9WmhePie+k0ei8o+pT
 YZZjhXJY43+nn6TuM45vc6fon46tmKL+YVEl+OT1bjlBedEgEV4nMsgh4LYMQyigbiBWta8UE
 Y3torgEWJ+jRbla33LGmAi7u5JYbVpz+uqrRllsJaiTiogPWuE9ZgQYREpnb1o8TLYVeE/2Nf
 JlvcUpDEbX6R7KK7z/6hYed7Op/tBtJWT7yYE+10csAP8J7pdYUMZglUVuoonxtGkAB9/qXVt
 hkww/ONE9nY4JcBV2DoXFHmBEcxPNK+IJzuSd3wTnvF2Jw66ULRUiDz+7z
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

On 25.02.25 17:34, Jerome Forissier wrote:
> HAVE_INIJMP will be set by architectures that support initjmp(), a
> non-standard extension to setjmp()/longjmp() allowing to initialize a
> jump buffer with a function pointer and a stack pointer. This will be
> useful to later introduce threads. With this new function it becomes
> possible to longjmp() to a particular function pointer (rather than
> to a point previously reached during program execution as is the case
> with setjmp()), and with a custom stack. Both things are needed to
> spin off a new thread. Then the usual setjmp()/ longjmp() pair is
> enough to save and restore a context, i.e., switch thread.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>   arch/Kconfig | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 35b19f9bfdc..8d5b54031b3 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -13,6 +13,12 @@ config HAVE_SETJMP
>   	help
>   	 The architecture supports setjmp() and longjmp().
>
> +config HAVE_INITJMP
> +	bool

HAVE_SETJMP controls if /arch/<arch>/lib/setjmp.S is compiled.

Please, add the missing dependency.

	depends HAVE_SETJMP

Best regards

Heinrich

> +	help
> +	 The architecture supports initjmp(), a non-standard companion to
> +	 setjmp() and longjmp().
> +
>   config SUPPORT_BIG_ENDIAN
>   	bool
>

