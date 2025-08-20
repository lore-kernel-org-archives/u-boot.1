Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32041CA0EF8
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 21:43:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7847E81E13;
	Wed, 20 Aug 2025 23:43:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="j/L3MLvj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E39C181FEE; Wed, 20 Aug 2025 23:43:39 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BD01801DD
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 23:43:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1755726217; x=1756331017; i=xypron.glpk@gmx.de;
 bh=u2dEsVvbG949D2vY/3QbNQTrOWViWZJbfbLh3FYN3I4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=j/L3MLvj4LLz+U5bvIKDsLEr4cKCNG7yOrja5Dbvwzk/UOMZbbOtbgI3dh3+MJ2R
 nwD/3cOiqE8ljhiyEKLkcaVExnU7QvacgL4BWhqYznjZPk8xxE6G5b05swxzFUO9U
 Zfp45tDfIm43vnDS7w9QbsdqP2/REMk6t7j3a6TDFcoxJ7jZL+wCG1OCiOQdhpV8T
 NMPRaCm7hmewyB/OXDyz7mTBoTNajpig9VqygCjmSDP6BeYwteFbC26SeV3z3pXnh
 Ag2CtK9aMFxT4N8NuICWAWi3M2kfUHw2t6fpnselpbYvBL6cuRHQ4UVdN3U8THJpL
 DPeIU9EiUG2UgqKOGQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.104] ([46.114.108.215]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMXQ5-1v50ZD4BLb-00Km16; Wed, 20
 Aug 2025 23:43:37 +0200
Message-ID: <469f383b-0045-4ea6-ac93-10aec02a654a@gmx.de>
Date: Wed, 20 Aug 2025 23:43:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] doc: Fix typos and improve wording in
 doc/build/tools.rst
To: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
References: <20250810233742.51902-1-adrianocarvalho.pt@gmail.com>
 <20250810233742.51902-3-adrianocarvalho.pt@gmail.com>
Content-Language: en-US
Cc: u-boot@lists.denx.de
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250810233742.51902-3-adrianocarvalho.pt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1FZuCKhCPDU2K3PxtvsXi2le1Osreu0CWVx6bYeKgEQsY/guLBt
 BETh9Ocvx4SUK5X4qObrZwurnb+j+XfIuNt12KN32hRXwhM2WqTmKW5Cv0oYFf49CNrrUq6
 iUxX3of0fw+veALfHW/hSnuK4ZIMFkdRTzJqo3RCKr1MOYmMbllr+atsE+of4a81fZplfFL
 nxZnlTyHzpX7V+7raR3hw==
UI-OutboundReport: notjunk:1;M01:P0:XyZSQ1q/e2c=;kgTYBIxKqQzszF3xSKju+UeeRya
 V9nFX6MZHc3OVqVEVsHgFUuYf2gTJw0uHjqL/8gIetQEjHXPl0FszXZtoiXx3my6RO3XNC3y+
 Wk5PJsOh42JezR5euVCgnowUv9gXLg9LugnJY0QScHJvp+TxmmB5O8tvNie+J1a2gkc2dYBR3
 P7ROz1aUH1hiy89ZGJXdauvasx/b3Ax+4iYsOKYaftvK5FdBgVWPnf0K6XLx2RNUdty3YNWBu
 EeuRSOJ5P9+FDYPY3MtJSfA6BWNcBswcjx7EpuzPh8afxx6yLY2VpBI+mCktjmREVE0R3dUFO
 E0dqkDyZQLSUDuFGkjyI9rAjFvUh4PXEzjwgI2q9GByh2F2b/3zwK3uDA0YVZLJF6eVUA6wbN
 aqmsKA1ltMa5WlfVLtjKXLASlOyHvxzLgyrUcYErVSat4Xt412t8kORZi/+O6wNExd4jhRsan
 JiYgsutF/IENO/zVB2MXCaE8HZXdJxpt9HvP0xiPWTthMJr/qcUks4nHdGjGvCms8oHm2lBcL
 zZdnEEJ71ZDNBYn1bqLEfPnLEldz1yY3TbbNZm7+9vB+kQW3eGXXSJIYIu7r9rTrhBap5xk09
 QU33F14hPX+408cKswSdkqanxPrReiCyqYjhfNRJ5+lqPs1iW9zjA+5vUdNViD1XRNhFTlcQ7
 qX5L3EHMKxYKnVFfrddjRPF+GTgtV+fakYPEgM6VN3ObHr7wF7Q+XAlS0/B9xzl+EWpYGCYkO
 KaNTSs+TcbIamoQqA9mM6CRHk6uxXEH+I+zriLXzgq7tWt0CfSbUZQV1gcxo1FsclMgP5EfqL
 hKn212EIjbNMt3zG9Kjy20/cCPFcj1d9C6iNrgafaZ3M/Y61C3aL+xOpbQWtsTBUyatj0HZ1U
 UG8UsQxYgaCAzMeZu4EvOeTsv7+DwDpEAItmbrApH5u6lSeVQZ2ELbXrZpL+4wh/lMP7hF/mT
 MgZfzQEQ4FTbB7dUKnJ2p7iJP5rHYdrixCwLfy5nURhjKD4BAdh0SgSiuCquO2ruk3oP8g2Lr
 BZO3O4cvFMpqJCEnv2kjza7ZXfiYXNZKQmTTmAxfEh6WB0iNtgib7zUf63FMzbZadq78ZnMTB
 ms6u7mjJjUE4uyVg8eSrae4Z7Z/R2KRgXgQ0xhJRyAHGp2+hjXErSdJeMms1ZKPVfNykpEVlK
 o2kLJKH+aCN8zrPErqz4dWBmyfi6VfTxcuHMEhPhYcXYohOgxiV01nTat8hw98eZeX2H4nSNw
 Pnor5r9Fyq21PVHopRkBQefe0H5XI7wc55KvIQ0Dnb8galZy8HG39Ia222HJkNnt6GAuy50ps
 p/nc8wmlPtww3RcheghFvOGyjoCEMoZf51xN4GQjIhq1IHghykpa52k78+vWM0FgL4MBQWq9N
 2zNjgcioe+KTUefNnEwNMPtu6T680DKAx8ZqxmLk7OOtqYsTKO+BdP8K2X3kuYW/X31MUMKWS
 t2DvhEzRpSXQpnGuRqgrHhZQ/lGDT6lGQl9/GOvNerIRhJSgLFbtgNbqU/jGmCJu13ff3Gw4l
 0FayXSMEur65PHyfMRD1Z02r4X56PleMLCKtuLWJSOL9I2O3hG4MA698oZr469nYH+cm9m969
 KVGQ0bQZYMv2akMF5E/3Vng7Ep5osSqgeNf2zxjAhbUwlnzNAQtdy1LmbnZhCi8bfStkR998m
 19QU8Cgh6HXPCerRE9KT+4jvx8Ms97en/Gk2qoTTN7JIOozdzuLhVjfcBKWjKNSLo0QKD0/Wu
 hsD4eOvnTjTt4NC2y8YvQ/jlbFiGUpluCDbW04YR0FMax0n9FfMvZUgsAX9hBDJh+L/Bvq88A
 5cVfbMeBxd5tF1VuO5t+ehBfFkSMvoeSaQ5HQtyKFRRxsJiBl4SNdyAoLP6Alix/cd7eUwGuv
 7iXIX3x0xIUWrq/60Wq9L6NfZ3yADH7POIJZ0DPxvsqBZZUVeIKkPdFiyNznecsILA56DCYpe
 OsXjsVxZg7+mE176haSomf/UrhA6SOBe1+M4j8UI9u0v2ssu983UAf/ll0huEdavT6J6scNmO
 v1SHghGjtuUyLdbgLMQ3wYfHWLO52Rjr4q2k1x1y81yQOI6FY6ZuInZDatPUlBKJLgA/gbkHR
 D9Xrq8Va2imOBbWjtfpI6mN431PBV8lE4p9fdvoE+Ozj087ESWQ2kcIct55sHKgOi+CRhsfD7
 DZ1Mh89iM8rEHO5av2+gSojuORBwVCDrODZAi27zFHE2ih56ppwZH4pGgIKPVBlbmaUQuKu7t
 G+zGnPPZ/GSukcAnNiHQyGdnkNHXi9a/ygwKOgE3io5XKwZKpRTPPXJKT8SOaAjcMpfZZsw/7
 RS5fsuAYA1bWGPdYRnkNxnlty3RnWiDxmRs9FvjnVy+NNhwKSE3ePHag4Uoqgx80lFybrnpkN
 wZpFOs4e6rbLvbrg4JptnNqw4JUOubRcuzFaCCm2V3IUQlhGQnjnSBy38dxGnydzxJrwIHKmz
 BoFruvDt4E7lPmo6bczdRrtQmAEdUhDwm3gXtPJvJ5mbGpTd/UjLGEvDHpUZp5KGzL92zJNJN
 S5lJA+TRL0dFCVc1+JyrfFk6j97xgLGdLR0onj8QMQ5HA8n/ZoOKQx3cjoAHopeC9b0BCrOui
 V80r1rhkIiWHwn3YiRefJV9ANyj6LaS0cgBz3KLJ0TL3t2i0wlXyWut0tvaxozFzUsXtd6G2u
 KiukRWP1GxjwoL2+CX0ApaGTH7HOMrptLogb2b2OWCXkT/fYc2XPuWw0j2GXY4WD7dT9hJlPM
 4BnAfpT0wm32FdDCT6yU9xWhEjgVz5G3kSeHqpwwL/XH7Af/gV3hNMtPLoju8h3sylWSAeiCK
 7vwE05wVMND+b+1sEbR62TquEv9eeAl2bLyybiRdWbWuYj8A8WSOvFAFEt80q2BHp1/lVAgFh
 4i9TFJz54Fwxj1+3vqCmdkOdnfFT8MOCPNfB+bN2EQaO+jOsWIFxZr/Xf81hjRr8ofAEaKZsN
 Yx1XHqJK5GH5Qv0HWroKbbdKPn8gLqiMK/TRRr/dcHT20m1zRy+xAHffm41ESngqU1TQ07qZe
 BzNmCogEvhbHmWqUXzsPCYeN8gd1x32Ae1u02VazqnYvfwuDcqH9Vdo89Cq/8zACHljwiyAYN
 uZCGiS7yLP5ex1QiKgiLBtFSGowvXJ1fxXmpc/0E4gDy02k5pDcVMXYUhX5/mp0FfSQfdUghJ
 B5ly+9/xJSEhtGsq062QNxAAB+PNkIJOFzMQXYi5Ryol6SKxUiWvxiPo66x5KIgalpWq9D+vY
 1EQ1L7Oh2UH3SJzHuNktuFNQpA/EoetHteTM3v7pAWrlfpXi19g8cDitFL/qjEc3+uzTo04zp
 G6yp/WhIg1WTn9fbtJjdslQu+4ELd5gUJjOWyGCZSNfhJqqN7D+pJVND1Jq1vrZkD0+vqTvlF
 4wO55GYzsHbAGCOBuDz6Lr3IKzYoR92eEuH5O5T+EEe8hBqaJyVKbIILcwGYdGCg8Kb7TE/Ly
 HRLtDH+nAl5G5qzIpHGox3RTfWjCdmU55+rHdCsHk4ctEF4nQoFrW/gKTVfTBAOCwuOwT8tOW
 MB7BktbyaZ2fk/JVrpAZUfd3gLGlAPYAO5UxIsc1T2fWd6huhie8SjIrdQTHLl7yQSG9APV0J
 de18gy98jABzpg23g96suB1pObrLl6u+qtXsHKDCWXdG1HPSx8CU9S4yHR/2mDF5rpHbfEOa8
 NO7KxHiRPzZNvCsPOuY1LeosKvGvSrnJbDmn56gOb96b5e0D2Siz84l00r5eg8dhY7GbIEaY9
 vHBsa9ZnoTXjZlc+gE2Gp8GMAkKP8P3YQLavP066jyJcXYR5SgiFCm6pLXqp4rwTQTp+gsu0v
 389/AbKg1HlxDgm9L15Nc6ii90VjpQRJWClQuarGBa57RY4DutQS98GZmY9OSLvOLaIQCtfrx
 cSIYSZKSBpozPJDhSV3ImKbZ3l9NcxJEsah+f3L7wj2kWNJUMSmGgKWtPcF2T/Qt3gdCuz2ui
 BC+SdcLu62MxDxar9D9nuuD7AvqfcBKhEN9ugGNMhM51Iotw3YkqEpiDj0QRhbpZu/9Aor2Ow
 AA/0KMr5wGXQ8PkDaVBn8drPE8HkS+IrrxGMNTmI+taApXmxAqHqFujYOcP9utpTo5LnSucpk
 Y7PCAOi9tUaMt6BO+mXIEBZhnn+ECLcWzzHBs+5SiS8eQjePy1ZrO0m9uwFI0018e8b01cwg+
 7j8g1JPNEg0NCqer6YJKGZSq6FW79M9fD+zTJno+c8jPZGhH/zOIMKc5607RtBS3VOYvAGuaW
 uA3xCMeen8sm5oCwcO3At04ZM83kp6CmldkANhzGnD4aUk/jrU0pbDsMY9je2XQVCUvJc3BP5
 QpdBnimcFInwvlc7QCVkxUtW5L6oL9PZgCIQ22inMh+zLJf/N6U78MNCvlWRGZOTyQkzUGb6W
 YnZGFUafrrRo6YkT6dyGcQg0RizYWPFrbN6GXZXjM229a55Z848r+KpI2v0BaWrIPBfEd5AJ0
 QoF1oXDkGg5upohkXqok+b3tT55N2VukE60NAK5FkILBbK+1nS2bz5eRKRT8V/rsMMCyRQGXs
 A5AKMO38aBGjvtvO+sQuB2oYOjKhaP++gXpZN/McCZXXtBWkPnRCrH28pqy4PR2Xz0iUdkG6T
 trqbtwVr9Dt91QfFsga9TZv7Fs1AKSv/s2FATKqa4j22ISNefzhoP+Dpsgv+TJRSPb9PIPNsI
 /kSr1oP75SgGbrW4w5fHqD8U6WiwrRtow7JLAnPiln/W2rfIkQ==
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

On 11.08.25 01:37, Adriano Carvalho wrote:
> Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
> ---
>   doc/build/tools.rst | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/doc/build/tools.rst b/doc/build/tools.rst
> index 5bfa05b2325..495e6deb365 100644
> --- a/doc/build/tools.rst
> +++ b/doc/build/tools.rst
> @@ -8,7 +8,7 @@ Building tools for Linux
>   ------------------------
>  =20
>   To allow distributions to distribute all possible tools in a generic w=
ay,
> -avoiding the need of specific tools building for each machine, a tools =
only
> +avoiding the need of specific building tools for each machine, a tools-=
only
>   defconfig file is provided.
>  =20
>   Using this, we can build the tools by doing::
> @@ -30,8 +30,8 @@ installed all required packages below in order to buil=
d these host tools::
>      * diffutils (3.7)
>      * openssl-devel (1.1.1.d)
>  =20
> -Note the version numbers in these parentheses above are the package ver=
sions
> -at the time being when writing this document. The MSYS2 installer teste=
d is
> +Note that the version numbers in parentheses above are the package vers=
ions at
> +the time of writing this document. The MSYS2 installer tested is
>   http://repo.msys2.org/distrib/x86_64/msys2-x86_64-20190524.exe.

The URL is not valid anymore. Please, remove the sentence.

Best regards

Heinrich

>  =20
>   There are 3 MSYS subsystems installed: MSYS2, MinGW32 and MinGW64. Eac=
h
> @@ -50,7 +50,7 @@ Launch the MSYS2 shell of the MSYS2 environment, and d=
o the following::
>   Building without Python
>   -----------------------
>  =20
> -The tools-only builds bytes pylibfdt by default. To disable this, use t=
he
> +The tools-only builds pylibfdt by default. To disable this, use the
>   NO_PYTHON variable::
>  =20
>      NO_PYTHON=3D1 make tools-only_defconfig tools-only

