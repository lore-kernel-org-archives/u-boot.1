Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C285FC0218C
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 05:54:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F033680F98;
	Mon, 27 Jan 2025 06:54:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="T+TXpPyX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05BAB80F96; Mon, 27 Jan 2025 06:54:17 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CE9880FF2
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 06:54:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1737957249; x=1738562049; i=xypron.glpk@gmx.de;
 bh=/VpVezwy/6mjhR8RnhNQ6iQdmolZ5wwLtG6i1HYEpX0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=T+TXpPyXhJDpbsZQ4paaUuhXIp6Nam2Tg1yLFvbTHN3nNkta1lcL689bnEWLawqu
 0KD4iITivagDslP9fmXdJ/rVnq6Q8m62cLTvUa5GxZrix19q6jq5b/6jNehkLeQXU
 UHdOKBKfUrO7oMl5nI0iA+oN3a2VE+DMtwphOMBXZ1H6kMLi6OrLgEvqDhqpTE4Na
 Wbapgb+/tMPyTlewlgg6BYCdJDO+5jCmNZEnLmwwBPNFDLsctNVQrtfGuDuVJEtq3
 iCiLhvprl6FrnUrPWEdu3sYOwxezBhigXz9p7PaU0vQbvVDXGxVvPyr5DVvzKqDlK
 ZYsO+MoeCJPqRqn3xA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGhyS-1tg9hb1OBm-000CPx; Mon, 27
 Jan 2025 06:54:09 +0100
Message-ID: <b956d263-7b3d-4f79-b829-c2cc194d46be@gmx.de>
Date: Mon, 27 Jan 2025 06:54:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] examples: fix building on arm32
To: 1425075683@qq.com
Cc: "Brunham, Kalen" <kalen.brunham@intel.com>, Tom Rini
 <trini@konsulko.com>, u-boot@lists.denx.de
References: <tencent_207D2C7A640737D8D4836580A0303D275109@qq.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <tencent_207D2C7A640737D8D4836580A0303D275109@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LM9VGos+CRlc5f+0y2FeoC6BVWlyIeqS7fqKwV8I5RmKrGRkmUL
 NlCXqbM64MVngFmGKf2cd3bM7Zf8sR+pdmQ0+tE5DvhHNvknH1sTSNh6HqxBJVpYvQnOrTN
 GyDCpSZKv1bINI2PJxFSz+y2p5kiecjMjEmlP1hisavPXsQgp11wdhpdzhcBlVpYdUE7j7s
 qc9FyKUvYumFiRPmV21FA==
UI-OutboundReport: notjunk:1;M01:P0:rwv2jrp1Pzw=;ZedeBcd/e1wz5LjAPe/A6Rejyu8
 naNypDX+WUXbAqxDyGspyJu5vjIS0r4W7sqUeQBOxtdQ0lDW8aLyfmyMJ5VZU9i0LW2UUuFnV
 9xl+ofbxALzfYEZgbhM0unE+kyJ45lp/qeSVKPS0hjU9IvAtr2CjYp1vefLSWgaZ5vHp4S+6v
 vwzTo7RSJ61/szjk5JwSy3mx0AIOT3ODY0GSWLWMhKpZb3q2djyaucH6pFP6MtyqZQPADAmt9
 Zv4QOx44RqeMXKEg+ooSplGq0rVCFKniA3x9sHvMSuKgapk53M5LvE8f8udV9QNxsg55NETag
 0TkstkXVoiLTwLwajfJqEfSbflsnA9VCl0MvNSEEYGdJ42I3IhmGGNPhb0d/ISzln6/hg/Fy0
 yoFcbNcap9hj65ld6UkQHptnUPvpRfCv1SDpzC+DV9kY3zTpzE7as2Qhi3jeOzMxI4iugH209
 BVAawmN7UxsIW//ecFWFo/mvciLng8VaPGJ0SVVCfpf165NzY/q1dzwgsuatrt4SLekxHxZNv
 dFex/xF9kFnxCO1GuyNAz8DkVJjyh734eMUroWTAB6vK+nofX90RIs8w46/0+7iPwpJLb3MOe
 Hpcflq7/D3iIq9/oQ8RpM8Seo97JRSUDJRkrRF+N2lVxXNuVC8Hatjecfy+weY2/4m2ZWVRdM
 ZHbeXg9lqI1Av5IpxZQi71TMS4f3PYZS6ZKOdF704iXuv9QQhsbxZrClL+CUiTDSEx8XTNwcK
 b+TSgEWhf41N+s1S0dwofqTKdxHLjk1l3tf0j8lhnQky0zNf/gpwtbKxxlt7vLpaR6+b1kHaQ
 C+1PucG9NZVqo6TbBNNSzDQWAyG+BzVhlTwDkz6KZkXA4yLnK55IHHnMIauPi89tTVnk9eKYw
 F5WdGzKIGsLAPApeNCMIoj2bdygJpvPZxdZQMShAn/jNS5kxlXBS5/CazV3iRixafXr+z+4P/
 jhSxnpl6d5i1XEb0eveZYWr5o81JneQfXBaTxUqfK3UClmNhC7gF9VZ+8UobDpbX7rmE3nxgF
 2Q5WuWiw4lB9dcBOrcter8D7DUcYjZDNQAkJhUD/4BsTP5O7+N/i044Y8u5uvnKv5+o+cS1Ec
 BBWGvJD3+0Qlng7qwt4jt500fpkJCHY6BibcSH9fnwVqmELq2t7mG/KfHbzvNiOM0mpNZWOMM
 htQqFD7ysgAVRmpBK9KZQN8Z9Z1GAHZeZpzMbdDIqFl5GsEeP4PvM0D3V/px0XWIjglSjbK/o
 Q7eZ28oEmnX9Pmj7zVpNXLoWwTeoKSwcLk/2a6s504v2806PAXkPldo6nyWo6VPVBaNE4OtqA
 mHwRlqLiFjfiuG/cHImHb/GSIT4xT9gRgnL05p1lmiJX/c=
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

On 1/27/25 05:15, 1425075683@qq.com wrote:
> From: Liya Huang <1425075683@qq.com>
>
> Refer to the commit a3c101a61348 ("examples: fix building on arm64")
> fix for arm32. crt0.S does not even build with
> CONFIG_API=3Dy, CONFIG_EXAMPLES=3Dy:
>
>      examples/api/crt0.S: Assembler messages:
>      examples/api/crt0.S:32: Error: lo register required -- `ldr ip,=3Ds=
earch_hint'
>      examples/api/crt0.S:33: Error: lo register required -- `str sp,[ip]=
'
>      examples/api/crt0.S:39: Error: lo register required -- `ldr ip,=3Ds=
yscall_ptr'
>      examples/api/crt0.S:40: Error: lo register required -- `ldr pc,[ip]=
'
>      make[2]: *** [scripts/Makefile.build:292=EF=BC=9Aexamples/api/crt0.=
o] Error 1
>
> Use valid register names and instructions.

Hello Liva,

Thank you for reporting the issue that you experience and suggesting a
patch.

I am not able to reproduce your problem using

make qemu_arm_defconfig
make menuconfig # to add CONFIG_API=3Dy, CONFIG_EXAMPLES=3Dy
export CROSS_COMPILE=3Darm-linux-gnueabi-
make

https://developer.arm.com/documentation/den0013/d/Application-Binary-Inter=
faces/Procedure-Call-Standard
lists IP, SP, PC as aliases for registers R12, R13, R15.

I am using gcc 4.2.0 and binutils 2.43 on Ubuntu 25.04.

Could you, please, share some detail on how to reproduce your issue:

* version of U-Boot (commit in git)
* operating system and architecture
* installed version of gcc and binutils
* used defconfig
* used commands for building

Best regards

Heinrich

>
> Signed-off-by: Liya Huang <1425075683@qq.com>
> ---
>
>   examples/api/crt0.S | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/examples/api/crt0.S b/examples/api/crt0.S
> index d2a97557817..d33e1c4aa4d 100644
> --- a/examples/api/crt0.S
> +++ b/examples/api/crt0.S
> @@ -29,15 +29,17 @@ syscall:
>   	.text
>   	.globl _start
>   _start:
> -	ldr	ip, =3Dsearch_hint
> -	str	sp, [ip]
> +	ldr	r0, =3Dsearch_hint
> +	mov	r1, sp
> +	str	r1, [r0]
>   	b	main
>
>
>   	.globl syscall
>   syscall:
> -	ldr	ip, =3Dsyscall_ptr
> -	ldr	pc, [ip]
> +	ldr	r0, =3Dsyscall_ptr
> +	ldr	r0, [r0]
> +	bx	r0
>
>   #elif defined(CONFIG_ARM64)
>

