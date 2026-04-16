Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B09F8D75E
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 15:49:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D84F8405A;
	Thu, 16 Apr 2026 17:49:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="s8BOWlpl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33F2883EEF; Thu, 16 Apr 2026 17:49:53 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11C27840AB
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 17:49:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1776354584; x=1776959384; i=xypron.glpk@gmx.de;
 bh=kiXQ3+t7+K9B0Djv/pyMjcxU2HzYG72AP8NNwNjcLhg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=s8BOWlplDYALilCoKhMlg1DWcxikQOmg2vwwPDVgq10AROkkaS0Kc3sXqUM9ebQQ
 wllNlWTU3AA9MuGOwHVjzDlsFAul19xsMlTEnm5FD0gRyJdf6RhrEa/C6AZ7kxgwo
 ddJ35+9g0fW+Y9OGYexgrkKC2RLLsJEPeKF3xq3tnQ2PH3MfxUnOYMBhPwzjMnmHV
 xuW2hlvAhjWGnJiPgQqceKXbEMCehJD4hhCLjl4uzgK0tqAKYSkYfvyZfL4uT041t
 O2FQ1bVlgg32ytfw9nqcsIfn468nKn4MgaG1QCG72CtKIaXUU5ExbDXlm2X8bCLTX
 Bw3avY51T8m4TB3opw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mnpns-1vckqT3cPi-00hUbb; Thu, 16
 Apr 2026 17:49:43 +0200
Message-ID: <816f3c33-8a7f-42b8-8461-0d89521d66b6@gmx.de>
Date: Thu, 16 Apr 2026 17:49:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] doc: usage: autoboot: update content
To: Ferass El Hafidi <funderscore@postmarketos.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Anshul Dalal <anshuld@ti.com>,
 Martin Schwan <m.schwan@phytec.de>, David Zang <davidzangcs@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>
References: <20260416-ui-cosmetics-v4-0-b843ba661b3f@postmarketos.org>
 <20260416-ui-cosmetics-v4-4-b843ba661b3f@postmarketos.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260416-ui-cosmetics-v4-4-b843ba661b3f@postmarketos.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oI2DZkRgXBMtHUS8zpo8Eb/AenZVCVreiOKMOWzjLYO3qp7KuaW
 fI44ahQNv7hV2so7OU7WbrVF3ejCNj18ca0C1LExX8XaF2PXJxd4QduTrx6WUliQzFMcsI9
 YlPU8bBaGY0cxJULIqtNyisJdz0dtKnqV3KcsbQxvDC6dgZV4cXBAEeZZ+n4coo3PgP7ntz
 emrlCMFNfshgtbuPfQSLA==
UI-OutboundReport: notjunk:1;M01:P0:5l9kiLrvEbU=;sNAnYrpTrNo00XXhGVZgju9NldX
 XVaystgKfMQOvVqb+Hd1HN/WbajpccHzYm1+iw+4Y2Dh94O9z3VPmPL+peuL5s5/1ngm91iiT
 gSLhdHaXPuaJs9n4ancsr2bo1MAJjT6WG+DHBx7x+Jcl42XUlBjmE7uOrVeR3BvydjRqUdAIp
 FMtZaLigzST3JN9etKYRpJZCnQTV74BFqOieVx7nQET97bNx37iX6oq22fJQMuWDIa7puo6g3
 WmDcclJrQee+NZy1zO0Vly6KAE3TjNXo9/F+6vhp+Pk05W8oSvE+aiiaFC4pL5NlrLnOqbiaB
 yXQLcWmJONtSpTiaxvYEDcKJgSOyMNNRAjkENLMh9Y4U4Se2Cs0JlFrUcg8cGYDA0eMTQHWud
 CO+TU13UA4NbIoauGnnMYKzzpGmatBAbsFDm6NcVyOFEtcrjL4uDFv3Pb8jRX2/fFwwsO9nRs
 eM9okKmKFbxwUE+N2ApLTOcwSaE2bnrDNwMOjtYFjBWpESWeGzlFEHU/MT4oOxoTIXx+rkwnd
 +5nDF88JZ05nbQp61PhNu7uBQPP2wcrwyIveYNdI5Pda4gjs3qn7BiGPFixYH8aIdvrlVxxfM
 xPfccLYgxKamm6ixzqwy8GuabiX+5zBjTGka/BO7Um1V7pnS0kcxtDa8r5kDjuQBq20tUUjCV
 t+z7FkmlOLrPjnNA76gn7rKAaoz9hwleEkWodbNVXrHZO28DLsDRF+w3dYLRzLqg4Qvdmcq0f
 iWTQILbm1P9qDAzUhffaDrM61CMRXFSYr5bbIhufYJRc4WA7NEpnPPwOLro7TQX4CuqhmQMwt
 O8llPkfKtjBaxmJrgY8M60exhqN9ilZyc46VWxaCXRWhNRGxh3yKIHVsP8oboGkgzjHkDizcR
 7HUkBnO6+a1WRs3uWrS+JzwdwMsRCCIc2l94UgQDYb+hEycHhQfbyjAR/EK3LN789zloE3W5P
 3P7t1xy+OFbGwLblwQ66jkZ3QEJJ/1jbBMk5dZZgJ8L2VRoQQrcH3+iyYWWUqKKlOshQt5ycg
 kkLhBO+8zhuBLP8f2V7lZZohGsViIOt6DaR2MeagJPZrZra9i29O1u0ZvFBWy8Ptl2nQ84Cii
 UTwGmqSnMjUP7ZO8/pNWiPJSzjTWcJ20bW2EHF/LRKohAg69rkuIAqoY4d0FZzARDpfJ6dGLg
 8MicFiArwTb66mrfZRFkZ1IjWaSRzNxUk/nwx/JV9bfHvMAvs1LIRk0s3LJ5qQhV6aeKgwrOu
 ursBP1i1RR/t2mZz635UzfmpBCzWn1iHb7N9k1PbSl+/Q0y1KtK98fHclTDAbBOh/znTXba+I
 7nY1g9nELsTTy6dzEfQDwHhk/nP8mx+F5OUIPohBwkTViexYs2IWSQbRPMa6qhkapFMNVbY1N
 X2WvuPX1rCBE/TzC5PaQhXdt0oZul9gnfxDEFchxmNi13j56fqgLjNMig/hWIx5lGJeFtaZPo
 oC/QwQ5avF6Yvwfwa9Jup2M/JbO6gnsv7/8fm7ZrF4lMhXPu7R9On1mdXFuikomF0r8AuI8Us
 07pMUTcPBirLnoSnXmGwsUQuqm0WI+NsrSK832Or6WK0YjYNhxdEgSsw+CXF+Lv26KpGlfbuh
 ovdvzBVHbdU13sXOSjOUKciG2beRVH2ia1wS+KjGtMFNPM60q2Z6YoGjm4YQWVBCLj6co/Qep
 7iuPLHXKuYMGEqzJZGDC7kXxQ4PA34nCWioU8vu/65xJx0dYGAW7UaW8sANfkCEDG1spOHuIR
 ugOLjyP5k9t342xVY/wqeMFZuvPKi420hHhvUrgg3KK6jbI5b4BzeGlOMvvQ+HwxYU8Fh+55Q
 osQvkpGysWj9c4HCBSWgy9fajOeqAnJB3rV86NcnWOTD9hrIQjIzWjoUSBPTaTKUCmE8XbKl5
 EUlm3xRI07hFz/DrIhs17NcMp8GbUl3idMY4WAZSFwk7EUzi+lZTkDdZcZ6r4wp4sFKFIsRum
 Te4vjUx+HVkATX9QgCekH5cdhaMl/bjO3qd3jzWwTVtkmxHM54RNH97OhuQ+cMJDpgfs+4ciM
 s2RSV8IPOVY1SNhJKEHuGq9QV7e3dRbPS0IH9IyyGsgE+vYC/pMzBaCiTVs9N12B3gHLRDp7p
 ViwDyb4g00z1whAcnoVMHPEy5S1is+MuanATTl/Kz18pWKJ4VRzMRvODr/RyPitRZN1qSf9+5
 Vkcjf86MOnZXpHNzkOw6LblD6uRsxFX2YKgJpoyuiUbEYT9yLOmvjt4L+7VXa7H3JW9UijvGz
 LTxteuxoJO74lKzJG1qK9mL1drk+J49isun0LQ1vQwRtKXT0zVs7Q3kOVzKHAQ1Of1z+y+ZmI
 F8jq7K6k4ph7vpYfhzOQxoT8eyUO5QsiIeJwdyItsg/W6YXOgRWOGzOTlj+c6/bH8wpFE5lf1
 0EvVG22M3/9qvVBzEfyjhObFE2P83VK2B+zqAWuqqueKktDIkZUXIhLkhC8WTggUYClh23egq
 y5MH4XHzj7M0uX0HsjZ44skALp9qZ6c3l0GAJ21pQlFaoQgdy1gN7FtRAPyXvUeT0V352iRwS
 5zee2W0GXZOT0eIUQ/ENqNHH34TyJyxSccfydoBt9q1wvSTIyfiRduBXFk5zkQIwjKHQan43F
 bu71Kuq1+d9v8j26WUMP84hrVUkPMRnDF0Jk8vBnEfFjhCTxm3e+9MuthqN+ivXUKOYxleubO
 /wjtrqZlXdi38Gt6UwLi0zAtEauYhzD9BB1op7NRNkijgltknefBKjIdQYkInBBO2oHYId9As
 I326579vNRnTgA+oe4vluhluTJ1VfEifcIw//t6WqVPr4drP7dqrMhw4KAlCthYaEfH8qgrFC
 sSUFTKKNo3Bcsz2dMA+83NzJlM5TJfr+q3IWubOrMbs6ulW6Nt4sNhtpXUh6jo2jDdQ4ASTTu
 K0ADMf8ecQKcqM6TSFCSDWh/TbDEbFNbKQ10qcVrLAW9noNWwYo7KrB//DVEiHVeG7Rg8A7wW
 JIftHsuV18qzb28pQqma9CqlhLpSyfF/P334p9+eYUXOQVcByZ4zrr/h6TCRCY3CnNo3uIBVR
 KSn+pbkL19dDsDyolgOSHe3nFQqHDQyWmDNz57BA71GqqdzfgS/+VX4juZB5GakKXdVfgJXdB
 T7C2XIR0QiiC3xME4Xn+34U4SOuShCBXguH1wkNW3Wx7GyV4bFC0mmjiBFk6/peSd6lS335zb
 nQocRwkDTZ8WkZs6m1SesZ3hw5/ANZn70qEXSPuOuBaCDZOo+/nJoyxfHp+wuBeENlmFblydA
 aw6rkK+iivUifpYMxpJtCydHOp80I0VqnTSJpQ1cC6IPFNQ4Dw3YfRzscAFSApvodvv2IsC8E
 BDmrlycEZXCXwJM3AR5J0eVsAhHv0F7o4+OersClm4INCuIGA/48KYTJ7OCjOg6HJ2uCGlH12
 +mcjAon0ZR6ZIv6dcipZYSDgz8jTtWXFG9DpaYnRf15u27kwMk6cjyTK042M15cyEg38CFD0n
 0Ockqn2b4qvRF4NW6P8OFSRxanGpRncDahVKOozuP+7C3iw9eANo6EiCVvIqGmRNeLe2tQ7XP
 i+/loHAQbGQsHbyB7DqJlDgN7qtiwvuZRpbKvw44SHYe3L2UAKJyKRq/RDWWWCvmOvowgIEjo
 zxFo6ccO/ndQ+Sdd2pHK+2djxJuxoupQzXony2PMH5Kmjya3uLH6ql98+aN6OUzpniWyGwvyM
 9itr5cbKvbve0uxUWeL5bQwW8HZvdMlhC87jvnZ8t1O0CHx8cBXb2mblEVF+S79g1kpND8j9o
 rGLS8INBtByLmqnHotftdvotZfrf8OExBssP42WYqHcOXO0JUDhD+8dw8EOjUgagTO9IdZECO
 kHASNKrxUARLQepN1Ftf7va2oHuR0S3tHV8s8EU5sVFXvQdPvlcs5m3U2d7zTdMepcZb88EnA
 hYWrM4cKYgRDjPeHkhrMfbQB9jm68pHYXirCNMqlHjxIb3DaR/2IY6Yk7cpSdaK3fdU6N4kr3
 HDZx5mXQQjJFHXzFB3TTPXwxjt+88oR15teiejqg1ssnmdUSoKKrbt7RBDz+B/KLCxbOWt6Fh
 TRasKnWbNZQHsogbxW6x2Gkhv6ERbICwih47aw/wYEJwjToWbpkiCzgW9JHUzyGk7TsBhxoOa
 kAOoji0dTnbqSOf6du0GmSQKUD/npBa3X6qDCc5VZRSLh2trMesEWVZloNj1ThgOpZYNaQ1oR
 bQZnEUE9bFpdqKZUUI9kWoO1VkJCFtHb/Jxxkp02lVn1wPM+XHogX3LlfZLPxVh/kypIjpsE6
 5j3P0BFfmITBjwZ3+joBJzkseH0LX2vH2zrXYDLyHibCFXceAspG/SKSfCaeVbIYsXf574WlP
 hhm31sj+6XWqX/kK6jVbC7qBASi9adq+zxvejKn86h1CHf4g/ztC1CMVbuHjZNMudC+fRupgS
 Plm7uRUp8dKTr3CB/fbk+tCeFyKthqVIZfoY+N4BSZ88FXOpoJIYeOgCbTdEf/dfUra62t2RH
 0I6dpcs8ir43pemhoR8UGHdRNV+64E88miGwNv731K6dEOLut2HPae6ry/PC04cOr4UCk3Hq7
 T4zUpCwlsQb4GuBtB4z3eoqAnLQqlXImNgNwLYIilaX/yMjAlg5gU9KJPIgiO/fc7Tt8NKVii
 D+GHSsR7syF/Xd3LnSIC1q4bE+31iSYvn70OsqiBx3sfuld1Rx9DQ4ZKVs8aCXiEOZsWw8JtZ
 +RpSy5uS/Jw90QPPSo/RS55PIr+6Vx/ehWopEQ0Gziy14KO4VM520lbIRdqYEQcUofkIUF7kY
 vULzlgVLpTSoVWLG7aMVBAPu9jj0+ktLbpnywb9rzdl+eNaLFHW+to7tZCNfHoajX5Ys0oFQU
 8R9AXgoe0xKoCJG/1ehttJ6Njsl3MBTGEYelRlCBrGjH5Oyq4IrcR/r7RDLKT4J+96FeHS8GN
 TeZgzv457m/oY1jWbexz4zhoIrOvyqaiMRBkacERsiF3Z06TwqkO61TjSzSs8aPc5IVBkUk0q
 odftB34mZnHnRzZBWqkSRB9DaI+VMr8DF86CKqIjdJiDYCBOxDE1XbpTFXx62nCX4dl+d8ZEk
 SS3XtxTA7ATEDFi7ufPj80/naRszSXLGk03wKgLTYV1zvcHiqId+TnLJmEh4fXw8k4hYAF1Bh
 McItP/5WmlK9rF+i9cz7psHPWKX7gjCHWFEwIu58WS6q8qo5NLy5XvlPBY21UP+JhilbzvKg+
 Ug9bL3wG6zp5MwUQQjTPKqEyFuqOeyjO833q8P4a4tH5XpA66vU8q5dSBMFgJUC/wheq7YmIQ
 cmGspCn8im1Wgh/mNZIgVpZ0YuJEya5r2rZZdXfPl3BvuXiArBYefOaKv3sdUKJSCCRq0pEvb
 TcHQpBr4SMAPLGtSKxs2nuWEvHLdn43Cl+T8fjB3fEgXSwxWPEGNa1OuKBWQ3avDsKVXMNza0
 ZMTaHItvDVe8m0RWYX3q/oAw62ICtKglpqv3jdTVHW3EIVSXrf8bp0jRxA47dD/33Uv/1JsoX
 C41S4HsJuS3MXk+0XMI0Ld1FBU1/MZcF6L+TyZOSBF96s6qk6MHuvpAJw
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

On 4/16/26 16:57, Ferass El Hafidi wrote:
> The autoboot documentation is quite outdated. While converting to rST
> for being publicly accessible in the docs website, document all basic
> autoboot options in there instead of referring to the README (which
> no longer mentions any autoboot configuration option), and don't instruc=
t
> defining CONFIG_AUTOBOOT_PROMPT with a C #define (as CONFIG_ options may
> only be defined in Kconfig).
>=20
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> ---
>   doc/usage/autoboot.rst | 31 ++++++++++++++++++++-----------
>   1 file changed, 20 insertions(+), 11 deletions(-)
>=20
> diff --git a/doc/usage/autoboot.rst b/doc/usage/autoboot.rst
> index 3b6f040008b..5d16fd2c3a2 100644
> --- a/doc/usage/autoboot.rst
> +++ b/doc/usage/autoboot.rst
> @@ -3,18 +3,28 @@
>   .. (C) Copyright 2001
>   .. Dave Ellis, SIXNET, dge@sixnetio.com
>  =20
> -Using autoboot configuration options
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Autoboot configuration options
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>  =20
> -The basic autoboot configuration options are documented in the main
> -U-Boot README. See it for details. They are:
> +The basic autoboot configuration options are:
>  =20
> -::
> +CONFIG_BOOTDELAY, "bootdelay" environment variable
> +    The "bootdelay" environment variable sets the delay in seconds
> +    before automatically booting.
>  =20
> -        bootdelay
> -        bootcmd
> -        CONFIG_BOOTDELAY
> -        CONFIG_BOOTCOMMAND
> +    To disable the delay, it can be either set to 0 (to still accept ke=
y
> +    input to stop booting) or -2 (to also disable listening for key inp=
ut).
> +    Setting to -1 has the effect of disabling autoboot.
> +
> +    The corresponding configuration option defines the default value of
> +    the "bootdelay" variable.
> +
> +CONFIG_BOOTCOMMAND, "bootcmd" environment variable
> +    The "bootcmd" environment variable defines the command that is run =
if
> +    the user does not cancel the boot process.
> +
> +    The corresponding configuration option defines the default value of
> +    the "bootcmd" variable.
>  =20
>   Some additional options that make autoboot safer in a production
>   product are documented here.
> @@ -84,8 +94,7 @@ CONFIG_AUTOBOOT_PROMPT
>  =20
>       ::
>  =20
> -        #define CONFIG_AUTOBOOT_PROMPT \
> -                "\rBooting in %d seconds"
> +        \rBooting in %d seconds

The default is 'Autoboot in %d seconds\n'.

Why would you put a carriage return at the start?

Best regards

Heinrich

>  =20
>   CONFIG_RESET_TO_RETRY
>       (Only effective when CONFIG_BOOT_RETRY_TIME is also set)
>=20

