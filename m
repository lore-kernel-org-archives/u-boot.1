Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A891C71136
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 12:04:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6037F82BCD;
	Tue, 17 Jun 2025 14:04:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="gobs1eW0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9413C82C2F; Tue, 17 Jun 2025 14:04:02 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92D7482BA1
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 14:04:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1750161840; x=1750766640; i=xypron.glpk@gmx.de;
 bh=lli1ybLwAeXIXEa9xloIJJxAfBztGR5zyPAMTnpmlz4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=gobs1eW0WpQU7uS1k+5Vgt90Y1cVtDLxiFisCzF+GsVXY5/0mnm/xPNBBU0THBf+
 kjpTxkPZpHwCug450+0CyMOBLFviAC8ikkljOyNzwRZexxHn8dSvW+DCP70Wu2mye
 XVC56a4pOZWRMtjsGt5f2D6poERhMd8E8Xrt6osWEeEO2H6R2O6PCfQ6wHA7KWHLU
 LBNigUtOPKggw/I5IS3u79KrOXoJt8vlzeGwN0YmbKxd6kTdkAi/QdEqbCzJXZwfi
 yzhuhVow1uRqxd4Dv4cR4Xw99774ZjcgKVsM7r//BHulcBB14pTDfYFoJYPdDp7Ii
 1+i5qRbiJyUxiJx4Sg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MowGa-1v96Bd3yj0-00nzDt; Tue, 17
 Jun 2025 14:04:00 +0200
Message-ID: <d8b6371b-e9db-4536-9be2-ab7c80cb79e7@gmx.de>
Date: Tue, 17 Jun 2025 14:03:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: cmd: wget: remove erroneous note
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 U-Boot mailing list <u-boot@lists.denx.de>
References: <20250617113333.2546767-1-jerome.forissier@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250617113333.2546767-1-jerome.forissier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Xwhe5++fsLNQU0RhNFwptnCxVIIKwebRm4qSvK/3ejYPwVWOtyu
 bfB8fCU+ruNBgzBtmRw2z2l2QV3qeAP45OLVbHFCVD1NaKEabstxe1Dea0XHlcuolZosbJk
 IXQT48f1dvC+/ndMNKGeB0oDsM3VhF88yC0JuFveqrTRg1Bps7Hlxu8cPSU7OVreXz+JjAn
 PV6AS/e2ZIeptHN7fvJ4g==
UI-OutboundReport: notjunk:1;M01:P0:pjXiFucULqs=;xjS2Lirw2ph9MGJk8pxzc1Y7PA+
 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
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

On 17.06.25 13:33, Jerome Forissier wrote:
> The note about U-Boot not being able to verify server certificates is
> false now that WGET_CACERT and WGET_CACERT_BUILTIN have been added.
> Remove it.

Thank you for the patch.

I can't find the string WGET_CACERT_BUILTIN in origin/next. Do you mean=20
CONFIG_WGET_BUILTIN_CACERT?

Otherwise

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

>=20
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>=20
>   doc/usage/cmd/wget.rst | 7 -------
>   1 file changed, 7 deletions(-)
>=20
> diff --git a/doc/usage/cmd/wget.rst b/doc/usage/cmd/wget.rst
> index 44033aaff39..06df2842549 100644
> --- a/doc/usage/cmd/wget.rst
> +++ b/doc/usage/cmd/wget.rst
> @@ -185,13 +185,6 @@ TCP Selective Acknowledgments in the legacy network=
 stack can be enabled via
>   CONFIG_PROT_TCP_SACK=3Dy. This will improve the download speed. Select=
ive
>   Acknowledgments are enabled by default with lwIP.
>  =20
> -.. note::
> -
> -    U-Boot currently has no way to verify certificates for HTTPS.
> -    A place to store the root CA certificates is needed, and then MBed =
TLS would
> -    need to walk the entire chain. Therefore, man-in-the middle attacks=
 are
> -    possible and HTTPS should not be relied upon for payload authentica=
tion.
> -
>   Return value
>   ------------
>  =20

