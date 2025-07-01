Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC67CC8302F
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 06:10:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA83381FEE;
	Tue,  1 Jul 2025 08:10:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Q1jhe5Fk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E663C82ADA; Tue,  1 Jul 2025 08:10:05 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 411FF8006D
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 08:09:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1751350191; x=1751954991; i=xypron.glpk@gmx.de;
 bh=jbHo6eg9ijD5dwmDh3N/bVo3G6LdXhH3xY9okNjQUdY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Q1jhe5FkRHhhQSEDL+p1NHG+kCUG2DEN3lCFLujDnpvv7QWf0aENqqWh3yIvXjJr
 VB3ej10SUOhnafBf38SRy03EKLLe0hx8jZLSIua8uJU1hHZMQFurCAnYfx2iHnKre
 arJY4+PIpP72x6eAF89mPgpLqKufundj4rwGEY6wj5Aw0CGNVbbs5gum/At6INNgA
 hHrvwtKekjMlKdAdb+rqHXpCeNPwFauf93I6zN5BmkbTWDn2S46ZWWDubZSozkCVT
 x/EygdeQ2vehlmQJWuh1XMD/eo0QA6z1GuYusGIb1sKzxH7gtRQoWUtVHIFFxJRRf
 utNYpVhMOFLOJ9jnag==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.154] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MzQgC-1usXHj00Js-015E3r; Tue, 01
 Jul 2025 08:09:51 +0200
Message-ID: <ec464641-8505-4e58-a162-de53fe9959c0@gmx.de>
Date: Tue, 1 Jul 2025 08:09:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/6] efi: add EFI_DEBUG_IMAGE_INFO for debug
To: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20250701034926.83536-1-paulliu@debian.org>
 <20250701034926.83536-5-paulliu@debian.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250701034926.83536-5-paulliu@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iP4O3QIlwt2LPqWflS4ppw0OxhE5CEzWXtbfmdGDmF9L2lJlqnh
 Y3wgyc+t58LqrmcYsApnQMrtAOwUQQq2VbPB3p+LhmnbnvRQTRXXMN0FhYIoKvn8M1Z7QmY
 IHdl0bJqjsduBOptCLyMrcVx5elApjUzNa7njFLXwjETB5VhmnjRIJ0yaBi8iHh/ZQ7ECJi
 RRIKLJY1c0/1ToKfX8Q8Q==
UI-OutboundReport: notjunk:1;M01:P0:5ydtPQDyBiY=;tz55CuYqvGBgORPFWr/uJ2Wsfnm
 cbe/4nR9eVwghK60RaQZuy4GWd01bExrqFLIManzJP6CHyPiO81TdBO1gLNfxCbRUkJeboCmI
 iV1iLTKQNa60dhpo5iwX65xuV2Th1wjwjJxER8CqHDZmKRUBL1BS6I4IJQB/ohko5jy1XXd03
 LKT72pCl8AQOqwtNzLVwNXjJTKBZnZyEBZkhhL2o13u9m/Icyr979imm2MkSHYDyhYxkg67gl
 sbbtP21vBHM4Mj4niXtCr/VHFkB1VeFyds5KLTC/hskCRjia6r0TTDV1wv2Ou05TWhheC8ysG
 oBAYTkU81VlXqa0x0I26OqVY2KVT6TBjv4ju5cj0lOlqSxRBE/zm7JWOO5Te1JExKBFWbdAbu
 H7aZLcGECQo6HfAb75cdmGyKr6ugD7Layxp2irFMJzyj0uMSUArabJQDIgGUSgWPBJfgyDQMl
 Nrju9H7vWmux8WAdp/FCrQlGgOvh0Nw5u7cH8BsimioPw/lZqJ4fLIxv+92C/LBIpGM/ZQMFu
 8JY8s1LQBnGEGRJty1U4PiLTgH6zrsapxziA2PhNao3L+7jzQqh2zLHgu8NJtf5Hf3RVxbO9h
 NhqARV5vH0cq6hYWjqXWmdFmDEeM91TakROEpp0mN1DzDwsqGlFo1Knlvqev5zVWLhmGJf3L0
 vC/3EtatshTLs1Jb9PoDFsHAcS7sqA9LB6XnqFAkcSZheNqOlQ32VzCqR6V8y+6D8+BgEQ1X9
 yTaKe04sg1xV1z2D4dARbR9GHSuRf8rjmkIPE7HI3LRdJnD0VQXx8PCv2IfxYHgvOQFDmeVUa
 zOC2CHYjHNPeIO1tsb8UA/ZwYt96/VFd8j9FGQNIQ3JLWO/j9SNYGvHbA2HcKOIlT6NRJW+lU
 AeZEKrotpIDxqtIxOxklM4VcDPl7OcYdGqbnNVtQgeacF3tESWnVawCPnvKbuC58ZGLmGMfzZ
 JLddORoVTtiaiH3ekN9jLQyU2SiBoFU6G8DyBj2k/dbd6yWWNke/ajyFONfbEw57LDmbLgfkH
 lqfZ3wXH2g5SO2UF23gJ8LOOUtNOQvIj1YVsjB3GiQe6UzfACu9Dakg5bJUq/6UGTDG1Jh4lI
 4WLCbpRhSPc6o3IbdLHlrtkMKmV5DP0zo24d6YzpVaFv3rrQCqiPEuU6RtS+McDOguSYOfwkT
 FcSTp9Iu7THvWwjfg1mOh0/rSDhOepjYNJ5lpqeXGOirhMOiPvFVPaaaubqHelUsdDI5rN4yB
 pkLHVdadYqW0su1QfjeqAJfMG5Ks5rbKZxuRROR0MTJcWwgk6SYmK6bGsj3fLzWJ1M8XGsocI
 APCTXDhj0wUOBWgf1ng3heIaohp3BRNFKaETi5TU4dM/bdcnDxKRUX+1FHy8bDRBlORgqodNT
 CeSH/nLUWlr97K5O637/AjOeS9lauk9tuSHsE7c2j+KsFyd3pqzZvnGuSt1TiLLNIGgEqvXqU
 aaFD2wBroOOws24gl8pguy4nuibm5pmkF5PSGZ+P20zmkERuvByNmvr9cRHt3XSO1v7enWxqe
 DrHy23J7rtJeSoCdHnep/E5tWt1BAQkr8GMK8NsYurXWfe3xWtHshXyp8pDy4CvY1ef/iOkIp
 cF/723dWBbaQyU+c2Tak3EZ/qUjeex8XbtTcVqzCifIFuSCHR+exV2SL5pvTceaSoyUwGqjlK
 WTV0fYIaXPh8e52ppLgb6gFEmuWrLmBPFaBmLuh8mYi6eEiiM8mKbKDfym8OYpYvi0v3P1XZo
 hfOqFohQELZR0emDs6/sujSQdYLGEnWQui7Mk/X9Da5UavnrML+knWs5QDBs5guNm67QYHSvw
 7yeX9ZEZALyaqMBybH7JwlJB7ynfAHwgCpUVPsN7SbWk/fnBOssxFwN50c+10y3UfJc1h9vWm
 YHehb5lEJ9ab8kkXf9CKzWcFcH8oFlzVuPnMcNUjQwDEi4wI4pket99kTrTZgbeT4k1M8oSdJ
 +cSw8LsG0Xi8vtLE0K7k/LuWBDrMfqEHRecvdk2wct+zhBUUPUCMN8R6bcm7Qh4XxO2rLX/6j
 pFEsZS9ov/c0vRHy0hzdMFrcBdQoWW0jUb/jVVHmN2CnABK9rQRjGXaRNCKohamzj2ijg6+m0
 VmBJyWMkS7f0//nFmVEsZGcQFTi2vY5KY42UU8RjL5xOISn8argMEpna6BvfipSx31ESkQmsR
 E/EviDSwjU0N+CgWkL2Eyqqd9LMpppfC2Wz1G0eLQGR1oDkLKgLXTy0zcAG9Lf6evjY5RjLYz
 Xo3VYvarNdbhuK+cqFWxUgE/3uhtJjCUKJ0flV1lZCPeIB4lhlxMT7LChHXN5e9ajeefZywIF
 NoBgfJiJReSf/viWi7t16qu8mcksapKPHE4jxc6MPW8IUIekSlnMFiVqGx35WrAQYp31izjMZ
 RdVdEzNM3UcY0GoKdNwaLN5NuOxipSNzB7u3RNwNj6hT+0qyyz1dGTsUprEfLFA3oK7N47+QB
 z79mLC8Xd/A9uRJf60VK7yQMr4e1GvC1x6N4+xqZLgdrRK9UH8VdLWbGIkKE/KmnnjX5KUo4d
 hUnHyTiAAu3R/95gIDLz9TmPbob2zubnaEeAncXEDg89TdmBzN9vUr5s9tfuBag2PUN8xhMg0
 CCpCbYXHXltyO1ONDSj9TjUaJixns6cg1AuK2K6exdTORXexUKhewKOQFx5o7ZZ4Wesy3EwSr
 VYjIIp/ykzm4gzfnwbAXe1eYuClL0kkWfl5Xf0CxUc1urc0keLpy24/c4Ufh4STaOLDgwx/8c
 o7vfNIdHYYFSQxiJAON5BShrCVCXK6sdP6Qd6BqfZJO7PS42Uo1ySLpTOqKHA3b4s2e8gs1nO
 97G78WtIODy6vUjGlE9227aDwtsobBBhdkNRfBh6FPkoPzfRu+eqAZHzA0/1O1iaMtYFKwJVg
 jcxbzURVSQvwhrC/RhxIZRAV3X/BOQ3RTm97lngz9B0y5KV0GgVJWTYkIngiaTS16/DAoBoLb
 EFYmFBBH6XQFLUIBZ8vuVaUJfpXIHC03Vie4h34eFPdgfaFrovyDUMHSWr+WsqS6kcfX0gbuV
 joUEsjHM18dA6GCSQNelpRqqR8S3JCSVX4VyrTny2YPdRIjM7uO2DWV2BLvTZHZx4s7AihEI4
 GJx/31SLoVMWPLqhd7t54U49AjwPTCYeqviBx03dNWVEmgFQB7ciiECC5cjqhWBNTQo3z2HVn
 IeiU872b/W28ibcZ4BFDQ1cbLVQyMvPYc0Q6q9aGYR8nnz5OOiPhFSxFyexAXCR2oqs+bgZmQ
 +2GMGVZ4aCYyvFZn1ljfNwdyxBhJJ2EABQPTty501RvUJvI3JJd6ve/tC/b0ejy6dhmLfyax0
 +8Bpdo7obIHsj7lLbBuvr7e8mBtiQm40imwVLF/wnVIQyXJHSp+rSVCZyFDRCJkOJcyhml/KF
 j/55BRBFAOx1Af8zjnA27gwh/65IU7IbqYDLB7e6YAiL7lMo8KijfWNlf5YSUnRB/F8pRtjuh
 +X5EGNv4UAm7r1GRt6wIAaKBabAAdHCZamdaTqNrpLjLqMA9F3HMgKPbjLir9iU4CVPNFz+AK
 rg==
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

On 01.07.25 05:49, Ying-Chun Liu (PaulLiu) wrote:
> From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
>=20
> This commit adds the functionality of generate EFI_DEBUG_IMAGE_INFO
> while loading the image.
>=20
> This feature is described in UEFI Spec 2.10. Section 18.4.3.
> The implementation ensures support for hardware-assisted debugging and
> provides a standardized mechanism for debuggers to discover the load
> address of an EFI application.
>=20
> Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>


Hello Paul,

with
https://patchwork.ozlabs.org/project/uboot/patch/20250429084138.239990-1-h=
einrich.schuchardt@canonical.com/
I got this output:

Debug Info Table Dump
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=3D> dump
Modified
Number of entries: 0x00000002
Info type 0x00000001
   Address: [0x00000000bdd47000, 0x00000000bde5aabf]
   File: /shellriscv64.efi
   Handle: 0x00000000beeb17a0
Info type 0x00000001
   Address: [0x00000000bdbeb000, 0x00000000bdbee1ff]
   File: /\dbginfodump.efi
   Handle: 0x00000000bef12890
=3D>

I found the PE-COFF headers of the EFI binaries in the provided locations:

(gdb) p *(char[0x44]*)0xbdbeb000
$1 =3D "MZ", '\000' <repeats 46 times>,=20
"RISCV\000\000\000RSC\005@\000\000\000PE\000"
(gdb) p *(char[0x84]*)0xbdd47000
$2 =3D "MZ", '\000' <repeats 58 times>, "\200", '\000' <repeats 67 times>,=
=20
"PE\000"

This looks good.

Tested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
