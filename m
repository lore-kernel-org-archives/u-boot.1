Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEFCEC47258
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 08:40:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA1AB87BDB;
	Fri,  2 Feb 2024 09:40:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="EF8X5qim";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39B7887BDB; Fri,  2 Feb 2024 09:40:56 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4342987956
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 09:40:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1706863251; x=1707468051; i=xypron.glpk@gmx.de;
 bh=Tp7cGli5yE8DVLAfJv0HDkvU7dFjjPXmsPYJfDoe5tQ=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=EF8X5qimznUnZsrZPfAQgbz+MKBPjMrMlyi3OBSFu0TG4hoZFmFaoGDaNxtXbLAy
 pPdFDDtJxfEfWqweq6FURJqEuMtK4as2yQqW3XRO8Z1tPYBJLm9kHY9BcaTsDeIWZ
 jH7j9G90cvQfxOmONRkFxahCZ6rEfw+GusNeUpcE4aDtlIjh+Cw+7bijqj6ctVNyQ
 6GVubeUyPLhGzqStXl/R1hNwD6y0Awf+WYeqxnCfirb48H+F3UzQThSLZIzGnfYR0
 HTm1frqt2rzIou9eYq5AeW1zCZ72dkF6uusB0zcVQiE9T53uht4WriUM9P+0ogY1Y
 Qq7IfEvI5QmTCs8uVA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.88] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4s0j-1rVYFo1JJf-001xFJ; Fri, 02
 Feb 2024 09:40:51 +0100
Message-ID: <76dff51f-c9d5-477e-8ab2-0832073d2f33@gmx.de>
Date: Fri, 2 Feb 2024 09:40:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] doc: imx: imxrt1170: Document imxrt1170-evk board
Content-Language: en-US
To: Jesse Taube <mr.bossman075@gmail.com>
Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Alon Bar-Lev <alon.barlev@gmail.com>, u-boot@lists.denx.de
References: <20240201150004.1343366-1-Mr.Bossman075@gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240201150004.1343366-1-Mr.Bossman075@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xuuInKDPMABJ4aMy4inr5ozpVPAOVx5nIhXA0avGUF8gWn9WBNz
 JV81Ish4Ihh/kfL5qNPNpUYkXrVbqMZ065IHAmFbZ4Zw5k4HKR5c7NZ85BBW2WRDVI/X1zr
 ztxzFfap8gCswxvGTSuda08MebD7aytyIYQHtfhci1NJ8yJIqiubnRkQ3na424Fh52HaGnT
 PR0WdZK6vF4T3CzGOBNeA==
UI-OutboundReport: notjunk:1;M01:P0:to/DwnusKyk=;t4e05ZvZ0haWfaVSO21WhGkEL+9
 5EajxU+Tqr3ckgmyY8t7SbmmMr0+VivgYbVTHe2o2Cwnmm7AgGmb/Uqtv6kvw8gy8wbsdhfhX
 BGM6j0UDB4DsCW7K6xU3CHL9T2DnPf3SJxibsS8aWH9ZXU/TrZ3T8vpLfKGX2LVFJGV8b4QVL
 ua/D4X+zjXCKb3iK3+tPbYqzn3COV1W8l0q2MIA6fA7/S3XjoFrNYmRg2gTGr9SaYuBQM6gN7
 W0dDh5gHm2vqVj5M0p1M21jiSpu96Szyx+rFuJicQ5FNYwKI6I137OBmBcSRvVafZd7XMfo67
 g4RbLCr5IX4tOgLZG91PRLjro328xbeQbWLtDJRQa7lotYst9mB9LR+p2/k8SaTK320SXaKbX
 Fp0pdB4/n26wweu+NJzDgaC6r3+ggcVp7wGVnkWeoYfGGpnYEwKLI5KgfpGDKuaBewMYOnep3
 4nvlTFtT0qfi6ojn/YrBFgszOyfMqpND2cGiHIuszpCi5lmRhA81rb8kv9mfMAoB49i43AYC5
 b8UwDT0RIU6gY3af7IlnkH3H7ITSBWXQb9c/lUuOOwafjSAtskQ7AwtLEkYf7sRb7mAjPKnB5
 AxYfjo7zVaAHMV3JwLVlf5/H10SN4YQg84vS2M1m5jnFuVNs3+SeVU6C4tQwPR1It7OB1sRxZ
 FzGR2jx9qgA9Pk/UMUlp7+fZBXr1ny9zCCJgh6HuifYwLtyZnA7EW4x29SUwjsRlcWkOrx3kn
 wOza/wIalOaAoU9pWH7LOWdpjQPA34oOqCpIviRqkhGIv7uxPtyJCZg+jUuxAK9jM76Z7sGf2
 mscFKcDFJyb2dmwIV4f7XxsXtgPoTxk2nxv9mVjjYdnwc=
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

On 2/1/24 16:00, Jesse Taube wrote:
> Add documentation for imxrt1170-evk.
>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> ---
>   doc/board/nxp/imxrt1170-evk.rst | 42 +++++++++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
>   create mode 100644 doc/board/nxp/imxrt1170-evk.rst
>
> diff --git a/doc/board/nxp/imxrt1170-evk.rst b/doc/board/nxp/imxrt1170-e=
vk.rst
> new file mode 100644
> index 0000000000..4acccdcc93
> --- /dev/null
> +++ b/doc/board/nxp/imxrt1170-evk.rst
> @@ -0,0 +1,42 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +imxrt1170-evk
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +How to use U-Boot on NXP i.MXRT1170 EVK
> +---------------------------------------
> +
> +- Build U-Boot for i.MXRT1170 EVK:
> +
> +.. code-block:: bash
> +
> +   $ make mrproper
> +   $ make imxrt1170-evk_defconfig
> +   $ make
> +
> +This will generate the SPL image called SPL and the u-boot.img.
> +
> +- Flash the SPL image into the micro SD card:
> +
> +.. code-block:: bash
> +
> +   $sudo dd if=3DSPL of=3D/dev/sdX bs=3D1k seek=3D1 conv=3Dnotrunc; syn=
c

This location conflicts with GPT partitioning. Does the SoC support an
alternative location for the SPL?

Best regards

Heinrich

> +
> +- Flash the u-boot.img image into the micro SD card:
> +
> +.. code-block:: bash
> +
> +   $sudo dd if=3Du-boot.img of=3D/dev/sdX bs=3D1k seek=3D128 conv=3Dnot=
runc; sync
> +
> +- Jumper settings::
> +
> +   SW1: 1 0 1 0
> +   SW2: 0 0 0 0  0 0 0 0  1 0 0 0
> +
> +where 0 means bottom position and 1 means top position (from the
> +switch label numbers reference).
> +
> +- Connect the USB cable between the EVK and the PC for the console.
> +  The USB console connector is the one close the ethernet connector
> +
> +- Insert the micro SD card in the board, power it up and U-Boot message=
s should come up.

