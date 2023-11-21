Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16DAFC61D90
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 16:35:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F09C875EF;
	Tue, 21 Nov 2023 17:35:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="X8T+G3wP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3A43875B1; Tue, 21 Nov 2023 17:35:29 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24D6A875BC
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 17:35:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1700584526; x=1701189326; i=xypron.glpk@gmx.de;
 bh=0EbQpibR1TMAS6AWZx5aivFmPUtEr8KX+7u7E+75lcY=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:Cc:
 In-Reply-To;
 b=X8T+G3wPx0744r4z8f/+sAOvLgVNIOi9DrMCtq6wVuB/kBGbPuzvIbOxtx5kVa+S
 sTWmNLZgdwXM1FSPRk8XAJzznRTlPC9jugqG4MxfJs0cw/C8+pZ1u0xwFDKIxBCyg
 xon+sAs4zNH++FsxBl4eF/3XSDHcrQmNGdG+exNXWF9Y+H60nUUT0AaxDMUuAiDgh
 DX8VRLdVmwmOQlJtvB8HzPu/CGPpDa2M+QLluOVPkDYtWUhBLpRdVc9tnB63AJFcx
 0fs+Tu4qNVPIS6vKP8ySeIFgrv2JqO/Py3G+Gk7I42hUNADyKcJT5ZDJ9nEliijzJ
 mr9QfGtwkV5ak/n+Jg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9Wys-1qzxPe0SJA-005a9E; Tue, 21
 Nov 2023 17:35:26 +0100
Message-ID: <305ad411-7087-403d-b1f4-5825c8e9d741@gmx.de>
Date: Tue, 21 Nov 2023 17:35:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] doc: clang: Update and correct support notes
To: Tom Rini <trini@konsulko.com>
References: <20231121154107.1668976-1-trini@konsulko.com>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
In-Reply-To: <20231121154107.1668976-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dNs++XVw7bbpOosKGYimJX1bUtXNqOGjvktrqzxEjAHgYD+dMkP
 APLahABYQKivnd+1HURpJbG0ZUB1eFO58CGVA3GazFHobHxvcNv2XydK4Vh2xT8sVymdeUv
 LcxPPHCdFi0Z6/vlHdAbl5jMBepoHSu9dOXgU1Ph3iuTvNw+9Nn1zXrqVBCJA+MaiCLV1Qh
 2iwDhdSk4AVQscxZ08bCQ==
UI-OutboundReport: notjunk:1;M01:P0:8137MFUTxdA=;c3a14wqI6zlyQb5R5Q40BrJMiL3
 ApFqmCWVPO5zyLzeuMUzcwAQ1pwG2z6qtETe8JAvzngrnNIQe+gMm5AKYZcS6vlKC5EBQydcG
 8DA9aFTIvWTCD86Looy82gkq39X2q87JHJGCb7BQs7orprKerZoDXBqmJupkeGHB3PCmh0i7t
 UULW2jeRbJbKK5P9fyiKlB7DOWgOaAmg5ua9jqnjS5G459cpaPQ/U1YvkafMRhMSqd0mXGbNY
 mKCX6qhMO6Jwf8TCm77ocv0WT+1fvi8pI2nwgbXMgjWM84HY6v4GoEtv3hpznicpao4vguCil
 nRR68VkHwnYkjbIaHBJE3C1AevdG2XBBgZ8EnJspIOD/fdkUG7M9uN+PBATV21pDO0XOUmrvL
 t3Zpg76HQYpPGiV0yOsvK7L7Vrsdtg21acfhlYZw9mZJatfTDHsqdPS6c67dndPHlZ/14aQXg
 x0QxqhwOZ88fe43gh/TH3F6qBP3V3QqlPRX0K2eDuztwhDCYGJDhgbaI55hF4ceJu0EFcQBp3
 YHOQcTZI6kH/G+bPIy6WhpqDFXYNkL8dhGMOlRzWIB0m9gUHdh50MCAOJQrcYXBHIvphXrw6L
 +SsJR513aXyHKclh3+HZoTZkTx6ilG8M1Bgm+0+mqYEYjIQgUAvwFgIVmgQQanoHGT5CHV+S8
 oZ8SF5GW8NrOAfudNNSEEM/UHWK2uV7f0DrLl2yqaoTa4Ej4vo0G+Wmb4joKcJe2Ylw3kqjoO
 O0fsXDSOtjXsy6e512Se2UmfAyzmlc7mGH5kyRYIaYzILL5vUmOpIsOaa0kO2hu9xSpNLDetI
 7xjmrJ/1Aqqokv4605H903dZCaUUCDk9I+DP2E05j3dXkw3Is05kotIrmQGLuUYhTaiIfV9hW
 RKEsh3UyAel3LgRkrKP7lf1rP1EH/ZlokNrwiYRoX9y8FCTe66ySi96BH3ZX3yehSY56Oma22
 /aXhfg==
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

On 11/21/23 16:41, Tom Rini wrote:
> At this point, clang can be used on both 32bit and 64bit targets without
> issue. Make note of logic we have that will inform clang of the
> architecture to build for.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Changes in v2:
> - Reword the segment about CROSS_COMPILE and -target per Heinrich's
>    suggestion.
> ---
>   doc/build/clang.rst | 22 ++++++++++------------
>   1 file changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/doc/build/clang.rst b/doc/build/clang.rst
> index cc265506c2fb..09bb988e9236 100644
> --- a/doc/build/clang.rst
> +++ b/doc/build/clang.rst
> @@ -11,14 +11,6 @@ The ARM backend can be instructed not to use the r9 a=
nd x18 registers using
>   supported inline assembly is needed to get and set the r9 or x18 value=
. This
>   leads to larger code then strictly necessary, but at least works.
>
> -**NOTE:** target compilation only work for _some_ ARM boards at the mom=
ent.
> -Also AArch64 is not supported currently due to a lack of private libgcc
> -support. Boards which reassign gd in c will also fail to compile, but t=
here is
> -in no strict reason to do so in the ARM world, since crt0.S takes care =
of this.
> -These assignments can be avoided by changing the init calls but this is=
 not in
> -mainline yet.
> -
> -
>   Debian based
>   ------------
>
> @@ -28,14 +20,20 @@ Required packages can be installed via apt, e.g.
>
>       sudo apt-get install clang
>
> -Note that we still use binutils for some tools so we must continue to s=
et
> -CROSS_COMPILE. To compile U-Boot with Clang on Linux without IAS use e.=
g.
> +We make use of the CROSS_COMPILE variable to derive the build target wh=
ich is
> +passed as the --target parameter to clang.
> +
> +The CROSS_COMPILE variable further determines the paths to other build
> +tools. As assembler we use the binary pointed to by '$(CROSS_COMPILE)as=
'
> +instead of the LLVM integrated assembler (IAS).
> +
> +Here is an example demonstrating building U-Boot for the Raspberry Pi 2
> +using clang:
>
>   .. code-block:: bash
>
>       make HOSTCC=3Dclang rpi_2_defconfig
> -    make HOSTCC=3Dclang CROSS_COMPILE=3Darm-linux-gnueabi- \
> -         CC=3D"clang -target arm-linux-gnueabi" -j8
> +    make HOSTCC=3Dclang CROSS_COMPILE=3Darm-linux-gnueabi- CC=3Dclang -=
j8
>
>   It can also be used to compile sandbox:
>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
