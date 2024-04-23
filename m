Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD663C4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 12:23:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FE2888530;
	Tue, 23 Apr 2024 14:23:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="feGVTgww";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FBB188585; Tue, 23 Apr 2024 14:22:59 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D2B2884FD
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 14:22:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1713874961; x=1714479761; i=xypron.glpk@gmx.de;
 bh=Oq4MvAZ8ptaGP1DvC0Fnka9HGsK3NNG3NZhCwfGFJxU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=feGVTgww8K2tnOJkBpSjF+/NM2Lipl0B1It032OXNIj2FnAgBST0kD0GLsnHw1lx
 u4o+jAf5ycMpYvzfpBKDlIxw67g6srnL0NCPJ1yzU3JjhXV4285R6G61GkEiYiybz
 K8Npg0SxUA4KtGZcHbe5lyXAzWbmHik1s5wbb4w52fJZ+A3b9jXfDyeZbhJoPdRng
 6rYy6AasaaqWEjAtAiLw8BpxEhd3t1FrqUDmtzhWN1WJtWvC54DLXYii3Sw8LaWf6
 ZW9dKlhUx+PcLZeHysk5NyEPflhFDZg9eGitKUmnIHgjrac49/AI0+fOCSXQpRc/M
 HiBJL6fjHeZ0m8Cs7A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([62.143.245.32]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8ofE-1sjubu3tHK-015s9m; Tue, 23
 Apr 2024 14:22:41 +0200
Message-ID: <3e5b4720-78b8-40ad-a783-de1e7792e7eb@gmx.de>
Date: Tue, 23 Apr 2024 14:22:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] board: starfive: Call spl_dram_init() for DRAM
 initialization
To: lukas.funke-oss@weidmueller.com
Cc: E Shattow <lucent@gmail.com>, Lukas Funke <lukas.funke@weidmueller.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Chanho Park <chanho61.park@samsung.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Yanhong Wang <yanhong.wang@starfivetech.com>,
 u-boot@lists.denx.de
References: <20240423091429.178653-1-lukas.funke-oss@weidmueller.com>
 <20240423091429.178653-4-lukas.funke-oss@weidmueller.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240423091429.178653-4-lukas.funke-oss@weidmueller.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FoSAiayAyM/KNG+45Ut523NAxsKHCXoDPxxqOFIEagVKSocNmw4
 HEVFiS6LCfSsGtr7KGMlV04yNXLoynEeisNDZg40UwUE1dREETZpsN/mUl86diGUqXAVq5E
 eMga2jWilSHXYPBMYyGTMHt0kYz2+uTK8MiSAmd89nCZjzA8tdtqNMBM31DlR9qG6+eCLVA
 Z+caoyWq6d2yes8htDNKw==
UI-OutboundReport: notjunk:1;M01:P0:k0CnfORHtRM=;deYC9NZBsdWfjsJKw8Jb68gZz3o
 io9faBxxExuJdulBDz7NPmRv9ruoehf1ngscZxUeRxCVqOqI4cNtOndTG08n5wGEXewNlzTDV
 jAzizCYslm3i/bZIgtUGn6ZS76IMvaP5Atmt4uq1Kc9wFBSTVnCoA69XwuMOrZSSD3Nz/Obk3
 gzkeFWcYY2qR9fGOZc2AvIfUV1z/vzCDGXj9U3A29/p/VwF1mmFL7fDIzZk/nX1JofxZZ15Jr
 gDmQD11P7WTxQ4weYk8lJonj+rn3ZvtF60XrRgbAt5ZsRVnZAumpph/vB7q+xsTidqSBoXFll
 W0owE1QB+CBXl56tTQCJyuAIy/t5wOpSfaBoWIbuIZVfHUAXK6Jye4wXZ0gdX++zeje7lcqYI
 RbivXW+rX7/gbb+8MAp22uozuzC2wMrJkRocSUxt9/OKlDzKbUVY/KeXu8M4+NJH0IfIJRJ2b
 IGsAF/R7xhgVnCRDNVmAbCsFLfHqo9J16wIcOfxe9VW2Vi+T9ttAFGaSjoxo7z4PB7L2YKS6n
 kFimkWCJ5koE51CbVlr+z5gfpw9Xkar2sBFOxR9Cf2C7m3ZS8B7Dg+BCWDvxOyEKcvhmF8Enu
 tULfJlflatsT3phf9zUKP15NWzXjcqD9QT1uXnZfrKTXGZsjVjB4Uh/Rz6nNqm3xn/LG80mUH
 V9Ic7fxmVlhmsNzO/ezZcyo8gdfKflOqEaoxfTYwS4N0dlJBqZ6MEb+FpLqdPx7K+rA2/he0t
 GzTcKFj4bvE5YQ0mH1WLAt4l/kUWVDLRXy+yDx0TmjBHJavm9i2vJWWNi9lF2kktIoISu34e5
 mgUTyhY8Q+AvSR44tWS8kblwBtYiua6Eepiw9Ov3mf/eE=
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

On 23.04.24 11:14, lukas.funke-oss@weidmueller.com wrote:
> From: Lukas Funke <lukas.funke@weidmueller.com>
>
> Call spl_dram_init() since this is commonly used for dram initialization
> in u-boot.
>
> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> ---
>
> Changes in v2:
>   - capitalized acronym DRAM
>
>   board/starfive/visionfive2/spl.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfiv=
e2/spl.c
> index 45848db6d8..ca61b5be22 100644
> --- a/board/starfive/visionfive2/spl.c
> +++ b/board/starfive/visionfive2/spl.c
> @@ -285,9 +285,9 @@ int spl_board_init_f(void)
>
>   	jh7110_jtag_init();
>
> -	ret =3D spl_soc_init();
> +	ret =3D spl_dram_init();

We want to be able to use git bisect. This requires that the source
builds after each individual patch.

This change must be in the same patch in which you rename the function
for the VisionFive 2.

Please, resubmit your series with two patches: one for SiFive, one for
StarFive.

Best regards

Heinrich

>   	if (ret) {
> -		debug("JH7110 SPL init failed: %d\n", ret);
> +		debug("JH7110 DRAM init failed: %d\n", ret);
>   		return ret;
>   	}
>

