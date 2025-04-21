Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A4B7C369AB
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 10:54:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C01581E1F;
	Mon, 21 Apr 2025 12:54:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="V/5HGJNv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76C3181E25; Mon, 21 Apr 2025 12:54:10 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54F6A81DE3
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 12:54:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1745232847; x=1745837647; i=xypron.glpk@gmx.de;
 bh=gQT1mxMP7r5nGbR8QyMgGp6vW0ZzJst8orVTzGoT6Ks=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=V/5HGJNvZAXIHGPBbayJKkw+8Y5LOzHWsrChT7RBIp/yId13DBp9C5SExmpUzT2/
 3wQKXbChE/bsk/GBuZmbyAFikyKu9ci1BNQDFMtODrS5FQYhDXw50nP5PCE13WjaN
 RnvQqiRPkZEZFQRP89rgCGG3oFr8C/pZq2EQaAkVhPpP9snIaLbghAcfpDyAsYjIj
 vaV5vjhwQVOUyKPTdukkTi0ppfKK6wI4NtPbmUEp9fHyNXKz8Y+upc6Wu4cqGEyFK
 E3xvvYvjrxbu+poAro6gabjjTMZziMjW9YfZBAG0+wBqTRpJkn9uID59GQl890md2
 VRJfsVMw40j+h/TSEA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2f5Z-1u7eWv3LFn-00FNJX; Mon, 21
 Apr 2025 12:54:06 +0200
Message-ID: <dc45b705-739a-4e6d-bf8f-79a052fa9c53@gmx.de>
Date: Mon, 21 Apr 2025 12:53:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: Kconfig: Fix typos
To: Aristo Chen <jj251510319013@gmail.com>, u-boot@lists.denx.de
Cc: aristo.chen@canonical.com, trini@konsulko.com,
 ilias.apalodimas@linaro.org, jerome.forissier@linaro.org, sjg@chromium.org,
 mkorpershoek@kernel.org, michal.simek@amd.com, ibai.erkiaga-elorza@amd.com
References: <20250420081210.292644-1-aristo.chen@canonical.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250420081210.292644-1-aristo.chen@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6iMXmIFGwolVRf5SdBX+mcUXyTfRswBSMQo5bDnTsRgk7Ra/43g
 p2mgCqfhgTflLR7HsVZrYYfQCWrfvRIiQucvZok/dahEwdU2dHSlj3fhVIzrMmZDlUSpF3u
 dca1IHNviXCKi64oBQafkFk6GaMvLx7GuImyVBnyfbiOgWiTyUvGAsmlkDJsqAnbyWKl4P9
 siQtyayc4GHiV7Bm/a+Zw==
UI-OutboundReport: notjunk:1;M01:P0:fh3OKhLNixA=;eo8OuBDsskF5PyrnaxJxeb/CGTp
 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
 oO9JyCvr4w==
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

On 20.04.25 10:12, Aristo Chen wrote:
> fix the following typos
> - from "categorys" to "categories"
> - from "indivdually" to "individually"
>=20
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> ---
>   cmd/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index c2ce519d1e3..6e722279205 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -5,7 +5,7 @@ menuconfig CMDLINE
>   	  Enable U-Boot's command-line functions. This provides a means
>   	  to enter commands into U-Boot for a wide variety of purposes. It
>   	  also allows scripts (containing commands) to be executed.
> -	  Various commands and command categorys can be indivdually enabled.
> +	  Various commands and command categories can be individually enabled.
>   	  Depending on the number of commands enabled, this can add
>   	  substantially to the size of U-Boot.
>  =20

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
