Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B121C83F14
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 07:48:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB265864EE;
	Tue, 29 Aug 2023 09:48:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ixi0LCrG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFAEC864C8; Tue, 29 Aug 2023 09:48:08 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58110864EF
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 09:48:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693295283; x=1693900083; i=xypron.glpk@gmx.de;
 bh=5IdIDzKzMEbQOhPrxxc7bDMEa8HW1OkzReiQACGCPqk=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=ixi0LCrGvLBPqt8EJ2h+tqfZy4ezizuP8FzNfSQ7lKAtnl+4UwhYCDs0EPlYE7XRcA6skmn
 kLs69mwkKiD10e0kIswFab1j3yA4kfFN5v86J0us3LscrHZYp7ejdxS2s2OA2Wr6/qwBdgaO9
 jf+Gz31CQ8GGsrj2R76s1i2alslGgkebOe/ffyEsBoZo7biOLr6bEDIRBsNjcMKIKkhIURZtW
 0Ka11ppL80OdiW89KzEGDVGmbZuJPlFENCNLuOgRq4t20RT+7vYhJX04MTjOW/B07w8X7rUXT
 wYK25ymgiuSblEFl6+0fHIKV6Ptbl+Dj1X1SjsmwiX/0NS/OuWWA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([62.143.244.162]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSbx3-1q843n3w6b-00StMq; Tue, 29
 Aug 2023 09:48:03 +0200
Message-ID: <37154629-dbcd-4d49-88ff-28aac4e037b5@gmx.de>
Date: Tue, 29 Aug 2023 09:48:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] doc: board: toradex: verdin-am62: document update
 u-boot wrapper
Content-Language: en-US, de-DE
To: Marcel Ziswiler <marcel@ziswiler.com>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>, u-boot@lists.denx.de
References: <20230828220154.483362-1-marcel@ziswiler.com>
 <20230828220154.483362-3-marcel@ziswiler.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20230828220154.483362-3-marcel@ziswiler.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IG+twVW/dH5+lr2E2QMh4E8sM14nJ2eHXGhz8VkHi7N+6OMQx9Z
 Oy38Qo7E/g7YFI0A0IyWzUO5fOBlPVfUPgWGMPQ4bFdnxIqI81R4VJlfnYSejHoTYOyZ3U/
 UpUwRy9jZXQ2ptQ9SO6ctQIaopC7Xfn5T3ShiPGtyuYGYS723TtZhdvOS2+ZOoXVIygwsTN
 zPQ3PEqp6unZt9SCMirSw==
UI-OutboundReport: notjunk:1;M01:P0:YH6f+3nNbjY=;VZvaspgukP0GpaCrdMgyhlm8zPa
 HEdrgoAxBac/eIWdS8FzgSt1sD69PVdXOvF0m96kcfqcsVwd6UYZurjYLDRCLWrK7zCzv8hO8
 ZjqARS7KPBEyhFQe0zpOWgDKUOJeJohymyT7BNZVNDFHRY++/nV7q7J3JpTaLpdA2X3SurID9
 ki3IvFVsVmIzC6QoHOiNT1Ixv6POk8Z62SQk6xeuVxzgp4xYiaKJO6fdrLKy0wKJuQPngITEY
 gGwr7YyOvnVN6MQvJDV5exZyvIm5Lhz/yli5Q2xzrDW0sV0tuQX3ruXqpG5jkzis1imLYv+fJ
 mcb4vucTQQrchzzSMFUaE6WjqVIOrfNlYowroV0Y8YSFVc/Xf005MhvjlQ2paekB1wtk6I8MR
 zDxfLtapmKoDL2VGPG69t2mpkp9qELVGTbyx08XuJpqlLfqbi3+2IzDIIwMvKIkx4hADMpTPI
 R6wAMM6NkcrwXxyEoPbODgwSz5o9RYKMDY6PzUk0jN144RDdYNjTB8SleJzlMU+EfFApfniA/
 nhvgxECaixJPviiTNOcfLjfK7V1KYxq116ylR2RnZ2oiYiUAjBYndQruNPyDtMAw6TYd0eT0v
 JYIXbURf7bsBB3n/TvHlJIPhpwQOiXuZr6SSzAGOxC9XFxfBTqxGP+ENUMBPY/OLarbBfkmGO
 AJp4wCtX8CCQElAEAks+c9cJEvYcDQM9/63BgF8UDNBUBwy2qUrbBWGoiIxbiCAczxT+9uG6N
 9WLtNzWTXd57Nqcx9AjLoH9ks+MRNNEGOjHMcauuEfDb+leGAGO7okA7rVA0WcTy48HN0vALO
 xdgFcqSaOjObwRvryD2F5nk+W6Q3PPJ1WBWnx+8AMMDczLnTwbuuj8iQiB6Z86o7UPXHuKxXB
 Okj9hYbHj952tZddpkACqCRFM7ArE/rp+Un2ghGmss5zqNY3hedFAsQGg/ssRxKfbCTOLyKzk
 qdFPQc1/D8wXivCxf2Umc6/xQhg=
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

On 8/29/23 00:01, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>
> Now with the update U-Boot wrappers having been sorted out, document
> their usage.
>
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>
> ---
>
>   doc/board/toradex/verdin-am62.rst | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/doc/board/toradex/verdin-am62.rst b/doc/board/toradex/verdi=
n-am62.rst
> index ecc7e0777cb..e8d90273288 100644
> --- a/doc/board/toradex/verdin-am62.rst
> +++ b/doc/board/toradex/verdin-am62.rst
> @@ -74,6 +74,20 @@ Flash to eMMC
>       =3D> fatload mmc 1 ${loadaddr} u-boot.img
>       =3D> mmc write ${loadaddr} 0x1400 0x2000
>
> +As a convenience, instead of having to remember all those addresses and=
 sizes,
> +one may also use the update U-Boot wrappers:
> +
> +.. code-block:: bash
> +
> +    > tftpboot ${loadaddr} tiboot3-am62x-gp-verdin.bin
> +    > run update_tiboot3

I wonder what the prompt '>' refers to. The rest of the document uses
'=3D>' as U-Boot prompt.

To make copying easier consider using

.. prompt:: bash =3D>

The html rendered page will contain a =3D> before each line but you would
not need to type it here.

Best regards

Heinrich

> +
> +    > tftpboot ${loadaddr} tispl.bin
> +    > run update_tispl
> +
> +    > tftpboot ${loadaddr} u-boot.img
> +    > run update_uboot
> +
>   Boot
>   ----
>

