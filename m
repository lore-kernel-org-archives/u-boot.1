Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0875DC2BD09
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 11:16:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8489B88709;
	Fri, 12 Jul 2024 13:16:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="MvB4aivD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9214988777; Fri, 12 Jul 2024 13:16:07 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98B4088667
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 13:16:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1720782957; x=1721387757; i=xypron.glpk@gmx.de;
 bh=y2eUcZVsFl195gVaQN7S0l0Md47TJABeh2XVb4+E9yA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=MvB4aivDaJF75X4Xh9HQuTgmzOBRPf67mNdiibvRnL3SPXyRc/CvAdShgA9vg3ki
 4gPvPCTPyvUQwLxvPIo7sm+dmTJUKLVJZMh1QQsheal5rAVz2OeJ1aMwTUzDQl2l1
 UU5gbZM7+cBPfsIk5YfGRML1xL1cR0MGDIgZ7tIY75S3jVtHygY+q6VKwBlMlu9GC
 C4cHcVZ7XOE//5fDyEpvsDOzSDIEJG1hrIQraKq+qp1YcpihwzWsUb6tibqbSGQOK
 y7D6ib6pNozT5of45H45bK0sRdFiIgcZjEEQeyUp/9Y6f10BZJRVC+ilOgeSk3/Iv
 mDtdMZg9cUaqKyOXNg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([62.143.93.80]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfHAB-1rrEsY1vVz-00ocV4; Fri, 12
 Jul 2024 13:15:57 +0200
Message-ID: <85482355-3c1d-49cd-9b43-ba031fbfc707@gmx.de>
Date: Fri, 12 Jul 2024 13:15:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ext4: Fix zalloc()
To: Richard Weinberger <richard@nod.at>
Cc: Jixiong.Hu@mediatek.com, sjg@chromium.org, patrick.delaunay@foss.st.com,
 ilias.apalodimas@linaro.org, seanga2@gmail.com, trini@konsulko.com,
 upstream+uboot@sigma-star.at, u-boot@lists.denx.de
References: <20240702194223.31998-1-richard@nod.at>
 <20240702194223.31998-2-richard@nod.at>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240702194223.31998-2-richard@nod.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8fw/XGHOn6K+yz2N3plt9rj2k618i6DcxTalVC0+xnE0G4Vnd4K
 seH7cgCwTf6qzaHcdTgr7ROAg0ISGFwtG065rQZAuYkpAERgUSmD8vDpNhbrmxFVlgGtyob
 JzObMgB0VthriGdESTjhY3s2L2luzreJkYBy4++ejecNR74aa9GW6fkDg34o8MqLv2T1813
 F0QcTaUoWydiqINWNUolQ==
UI-OutboundReport: notjunk:1;M01:P0:1J44XqmmMAU=;7zBf29zPekw184LKNQ6vFvhlHV5
 Z5SuzTVtfE5YSqjdiVQcA3H4QYgSTCtn3WoNHktOVwhAFqrKOjikaEQ16QdT5007nwI7NuMEg
 CXX0JekJVn6jce99DnDKg7n3auo196uFApIDLtV4w7XLPKvim74uQx1iKuBVb6fPiIOY2bGaS
 6/l3c37fTodA3WL6KFm7ZsICk7CXdNdGcd2UOHidjegc4cL0AFM6ZHtzNK8gz2UAnDIyImxZg
 ZcDwLOSVeFz3lL/GtXC1yoE940wtIKzJ4eePLDE+hj1fNVWsswkWVreIn02Op3HB5Kn57Uarg
 2YiNVpcVHQ0WqcYiHps2sPcuOZDqk3ugoB/Wxk3P5vi+lLabJLSfhjF5uIW9gVapSLIAShfgg
 RLhbEjw2TaD1aWoXygOe+2D8T/7xz9A34RoIaxWv0gdl1FmGsdslXQJXdTHsnGbhTXJh4f1GV
 9T1TE6bhTwtOh1q17iCFU+O2lfcExvUDJvxqwknBKrVNKceo2vEDNd7V5pBEgPG05SECpGl5q
 3s6h7d/O4afkt4r6TQPk1uRbuT543q4DIjnPncdDgLQyhvdhcSW7vwUtXEghrIo3YP81ooHiZ
 poqzWv7Bpw744Jl0QZ+Nl2BDearTC9vnM7OhL7ZgGLujzxQRoRYpSOZ7NQS71qbYwwj002B7n
 oEVWR3rOy6yUJDm5uijWiADZ+O6+MHDx6adZSYYNRewqNT9ZeOFsBnXoTUM/3yq0XyeewWTya
 6TJLyutUKaLhwd5ki0halGQrPx07YUg4V8ODl+QbY8tRVkBZbOtFl0CxyC52K+GWGXEvNTkcM
 JLxK46498NgTvJSFOydPhzbA==
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

On 02.07.24 21:42, Richard Weinberger wrote:
> The zalloc() function suffers from two problems.
> 1. If memalign() fails it will return NULL and memset() will use a NULL =
pointer.
> 2. memalign() itself seems to crash when more than 2^32 bytes are reques=
ted.
>
> So, check the return value of memalign() and allocate only of size is le=
ss than
> CONFIG_SYS_MALLOC_LEN.
>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
> FWIW, I didn't investigate further why memalign() fails for large sizes.
> Maybe this is an issue on it's own.
>
> Thanks,
> //richard
> ---
>   fs/ext4/ext4_common.h | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ext4/ext4_common.h b/fs/ext4/ext4_common.h
> index 84500e990a..0d1f72ae01 100644
> --- a/fs/ext4/ext4_common.h
> +++ b/fs/ext4/ext4_common.h
> @@ -43,8 +43,14 @@
>
>   static inline void *zalloc(size_t size)
>   {
> -	void *p =3D memalign(ARCH_DMA_MINALIGN, size);
> -	memset(p, 0, size);
> +	void *p =3D NULL;
> +
> +	if (size < CONFIG_SYS_MALLOC_LEN)
> +		p =3D memalign(ARCH_DMA_MINALIGN, size);

Memalign() is called in many code locations.

If memalign() has a bug, it needs to be fixed in memalign. We should not
try to work around it in all callers.

Best regards

Heinrich

> +
> +	if (p)
> +		memset(p, 0, size);
> +
>   	return p;
>   }
>

