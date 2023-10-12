Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE00CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 07:41:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6155286D30;
	Thu, 12 Oct 2023 09:33:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ivQMN1QX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F17286D3D; Thu, 12 Oct 2023 09:33:28 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 284E686D62
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 09:33:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697095996; x=1697700796; i=xypron.glpk@gmx.de;
 bh=QkTG6GxutOCioRrk5ynX0PAhjuSPaKtF/ernuOlh80Y=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=ivQMN1QX+AveGQA9qwXfsotBwZbmOVrLlf0ATMaodcKcy+XY9j4LKGOP17w6EspVB3b7SQqH52w
 2hm4uZbW5StV/0EF7Qif1fswYEsj5ws+nNdytmr5WlyBa0RXQ2H5Qozz7sogEd4P6ESQT1G/02gT/
 GvZh4VA0fkgZfgJEa/mk8cTsaY0HZNez+JPXEjzmZQs8qYJ/SONHLSMPiKHLPtOeLQNnCkEzIoVk/
 H72y0kf2yI+a7SHGg2HcY+T44JqtA1dc5KKKZtozl/xACbWLLeNruZh/fDsCAQnm3xHgA2fuGcojh
 TTYs/NmbA4jKRfym40uNjJzc7SteuW65gDQQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXGvG-1r4elm3Zrq-00Yfmx; Thu, 12
 Oct 2023 09:33:16 +0200
Message-ID: <a5d7450d-92cc-4687-86bd-b6636749dd6e@gmx.de>
Date: Thu, 12 Oct 2023 09:33:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/26] arm: imx: Add newlines after error messages
Content-Language: en-US, de-DE
To: Sean Anderson <seanga2@gmail.com>
Cc: Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 uboot-imx@nxp.com, Fabio Estevam <festevam@gmail.com>,
 Nitin Garg <nitin.garg@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@denx.de>, Ye Li <ye.li@nxp.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-6-seanga2@gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231012015626.3487451-6-seanga2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ob0PtTR+5V+1UqIi2megaD45L4UhB4PEc+k6FrbtFbR7bDQGEXq
 1GgzxPMtWP82H72kO9q3TOf6QN7yRyZLRMlEj/1pAg8YWqnX5Gg0heokfAmGqx6UAPwANA6
 cJTedL9IXF/pV+UWWC/haWcqlzWDRBXNrq+BjFqN+Kagnxlm+VcRsrJ0wRFPvyz/LkHexys
 qRcq/G2OPTxkLP8WeCkiQ==
UI-OutboundReport: notjunk:1;M01:P0:DudBjTq4lhE=;Hr9qgQga7GGS5NlNZCPLxcGIx5L
 LyCGwl1BNy3YNhbrMmch+l3P8vh64yUb64mEWQne3cnWoyJbfMMkE+AhN1gBgpjvaqTKrQ2Zg
 aWfrX76G1d8d9H3XrBpArpA5z5woeZZMYhdf4jLO3grUR/Jwz+W279EZkSZJDo50YQkAc+M+o
 NGTy1VGce0CxeJYhXGCAuplq2CGdiZGw2dMCwAAvecXfnXXBQfz6V/d/r6SR9CZXO1rzolIe9
 f1X2K6BAppqEaWH9cN5KiVPMLDE1tj2co0YO0Y5pEHE4VNEvqivQ3z+Gbgb5GV69zHrBOhzO7
 TWltoIOFSmOqDE3/iB/iFdHYejHgd+twbnjXTeZvPXnxu3K5psjhaCfFfGSSUXBBviHF8FTnk
 oUowQZ+CUCXYKW5XSeUk6rHlHXM+zR4rWFCJRPWX4se7RTi3qdDoyWyHIMfJdM+AyGERBDbD+
 ktqYmEPWK16zZA4t3dIR+2gXHQkGO/GL0LKC4Swod6kNWdNJhUv41a7EutHQHcs3MQcA2zlAQ
 cQ/6pLZLe7UENTpSTH0LONOxt2FNoCIaCx48+F1PYmnh5c9+D948faFg9mAHHpsPYG4mTemtw
 7fRzbEWI0DGK2xgiGev9SyWc7voF6umvcRvSdbwA+qiQ2S+wIwiEivoqPMiyZmBtOgQW0d1lZ
 vXbBNInrLOxAp7E+pm37mzPWygcuqSMtyuqtT7vaeCZBp4RPehg55A73y0Tu09auyR7DI1qP6
 PtRoq73GbIZHOZxtCCAV4qLSEI/n1FMaB6RbK5Tqgj6s6/MBxxvawJq5z3wAJQqixpZOyPZY1
 qvXFVZB0dORuVDhA0Ihyoa/A5ASHIBBPMM0h4p5Ejw3r36WPpNA0apgEoxrIXpu5g4CM7JBAl
 l0RwNwubPUzlc6peIDqx+bt40FYXbnhoqbn4zXNYsFhmNuGj98a4m+zalJbB58pN4hFy4TMcs
 Ubb7zrljsxIFGVfwzswlkJGf9DA=
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

On 10/12/23 03:56, Sean Anderson wrote:
> These error messages are missing newlines. Add them.
>
> Fixes: 6e81ca220e0 ("imx: parse-container: Use malloc for container proc=
essing")
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
>   arch/arm/mach-imx/parse-container.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-imx/parse-container.c b/arch/arm/mach-imx/par=
se-container.c
> index d7275a58c17..c5df78d1c58 100644
> --- a/arch/arm/mach-imx/parse-container.c
> +++ b/arch/arm/mach-imx/parse-container.c
> @@ -85,13 +85,13 @@ static int read_auth_container(struct spl_image_info=
 *spl_image,
>   	}
>
>   	if (container->tag !=3D 0x87 && container->version !=3D 0x0) {
> -		printf("Wrong container header");
> +		printf("Wrong container header\n");

Please, use log_err() and add

    #define LOG_CATEGORY LOGC_ARCH

to the top of the file.

Best regards

Heinrich

>   		ret =3D -ENOENT;
>   		goto end;
>   	}
>
>   	if (!container->num_images) {
> -		printf("Wrong container, no image found");
> +		printf("Wrong container, no image found\n");
>   		ret =3D -ENOENT;
>   		goto end;
>   	}

