Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED2E1EE57C5
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 20:22:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50DC283A5A;
	Wed, 31 Dec 2025 21:22:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="qgzpToNI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A45F483DA9; Wed, 31 Dec 2025 21:21:59 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5031183700
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 21:21:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1767212485; x=1767817285; i=xypron.glpk@gmx.de;
 bh=a75QL0WBDF0hkzTT2NFjKEmbtn/wYD3mBDHCkHGGnio=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=qgzpToNISKFyAnT7soPuFrxlDMWQghe2CBssZ/jbAmO7YjeQH3rcV26oeBJ1aatN
 DOKBCqhPd9jGIg7pd4s54cXPX/CnoMtT8z5cQEAc8rBIaqNFPrSvol4Ylh33CE3L8
 /2Pblh/Wsx+p8T6lHG0SEsBzsCXRC+QSk2zXyeoCeHjDjB9AHtM7BbhZk1JPKN93g
 b9J9qAHXFSKs1gri4yUmhyS7oAjTieMPPBfkJbgKE+BD+KKtxprGNw0usrbzLKnim
 2C7UQ9ryP8kvjJRgCqlDI5UwCN896WPHUACAvjoAEDztO6DJxF+iPAw4cFowyy6X/
 L0asdps1K9WubsL5Ow==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ehlo.thunderbird.net ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVN6j-1vRWAU08Hf-00Yn4r; Wed, 31
 Dec 2025 21:21:25 +0100
Date: Wed, 31 Dec 2025 21:21:21 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: j.ne@posteo.net, =?ISO-8859-1?Q?J=2E_Neusch=E4fer_via_B4_Relay?=
 <devnull+j.ne.posteo.net@kernel.org>, u-boot@lists.denx.de
CC: Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Andre Przywara <andre.przywara@arm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Simon Glass <sjg@chromium.org>, Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ye Li <ye.li@nxp.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Sidharth Seela <sidharthseela@gmail.com>,
 =?ISO-8859-1?Q?J=2E_Neusch=E4fer?= <j.ne@posteo.net>
Subject: Re: [PATCH] Update links to doc/develop/falcon.rst
User-Agent: Thunderbird for Android
In-Reply-To: <20251231-falcon-v1-1-19c85b9660e6@posteo.net>
References: <20251231-falcon-v1-1-19c85b9660e6@posteo.net>
Message-ID: <D4AE599F-7966-4F5A-9D56-8C346F9BD6C2@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RQpCiYAy9DxUEB9c/PGD1mbHi604EklwAOAVjlz1wE4UuInRgfc
 Ea1IUcvYxQQgutn9WMqlluXQeWNjobMmG3iBW1vf71e7BP9qo5uKOY9nU9j0BDcJef3f2IE
 3CRAu/j7qrU+7D9GU4bYKF9kTHesuoqlr1+sRRZh3fFCwSz0KT0JF+UpBsD6eg2kNR35rqo
 g8ptuIQrLzv4nKUyuK0pg==
UI-OutboundReport: notjunk:1;M01:P0:gnVCuEZtqmQ=;3ZJLo3QuIro3zsIcPQuuC7NfnSo
 2BV2kQJflVzSrpZql2+RfYVdnET1s8Ep80o0DZU0DkwpaZ1A4Ruo2L8+ZYQOiZTyczpn2dLFa
 5bP9SGQI2wo8GKck91H3hepnYspc1D5bMZ5YVuyoE5wm7kkdPvml2WTQNz2MfenqcpWB2NnZk
 /IjHDO0dUcsMbXV2o91g9UwqZYTVIsJRvs4ZtuKyrLUZhagkDXmYLxoibEy1m2Ff0P153zFP2
 sEF3oRY+iXX6L82iGvz4uibhap5LTGP5XryG+yG0GV0Izcxs2NVn8IGFj9mB08g8Q+JGDlKR+
 65Vz/ueX7nIu5TaTxQ61BVahqwyDBDBDvGzyBsoembiItET7ahRNbFu2Od9eN4MLIh8yb65t4
 ucyjHxxMZ6XollWD9HiAkDAmtVJjhnCy3Wz2vMc+8/liTT3qgXk5c/2PtR35ZSEHFiyoX//6+
 wd7iNkma/+P/2l4vWCm4uLLyqx+Q2dsHJENEqQp58m1ehx6Py4HmMW+Adzekt8m3i615c8JRq
 68Hjkljcgi1J1KVb7xKxYQba7Rects+kvcvYIBp/0qXVf5VsaZQiEnDTXEMH94Q9v8BzTga2u
 cPyrOT797Rdegh4Snl4py3v8mr7T1pZqP28GJQjJ7EMx6XFD5r7J7ZxB+HAyHlLLmnttaY80L
 NnwLbvwTMLzeAVi1lAIkXlmVkw3KjalyByUYrnvK/uO2uI6/o6RB/cDqCby88YKe2LrxmMLrP
 lLtp51P+Mn916+QPoHzFdCUcU/LljkuIdKRqZYEZ3WDXfwtBlvpU7i1uOVPoAfMHu1G7ZxPot
 e/atO7hTIOktnMuz/mVhQBngzh8Z/jGo/0VZkyRn1Mr2W5fLHZ35mdqB4YgmzZI296jn03XFk
 ZJpK5HlNrH1f/jHMt4TItWpTTvxJNrVMlBMPzcrZWTxDEDtant0AEDydIbqNCQ1tFUDcYG5z0
 1IjCexpzQY1rMuMn0nFiM4OjkcnrxpQAd7ZDSrd4fofI5653VjC/1LF/x0vA6gfA5smamUS24
 QM01XQHhbSHxo8g4zlpA5nSrW9G0YHCOAuF6IARhQNp7zOq7afz3mh8us9b8B7kWt2gl6GSn7
 TGEuy407SCgP8+FRUI+2JIwyLEhyqacas7z3Yb2o2BNfWqpUPWpa9jFWadOGGGjgALjwYkokN
 DvYMFXGLBcAAICQsKmvkTxyoQCwzWe9NnCouQGUV9872jvQ62GKFC3dBU3m2FPEBJ5sMOFD9v
 cjv8JLIh4MfPE2jv4OqVBfKEM+89auPCoqcaIlQplJe7GvVLRsTMwQM+FQgWBnITlq6HnZVT1
 vhUfIuiXa7zy3aZn8MPkOo01SSWSULc+T0Epn2/4hfCc4/4Zd1jgjZbvIwBIHfJFczOpQQso5
 xGtRPpA61BSZosmuB4mX6QRZpDxDKVoG2msd9IBBAZhGRL4091vamXMQSjL+qxyOVhELcm5Jc
 eywdP97waSAIcl73FpEKccGP1SUP0lj6cijbNq0M/h+u0jB7IHA7ZzfVPbeCQ2N2wj3sMHFPg
 rbEleIdmeZ+1RrIxePsdwXqjRZa1EaUGAD2vCb3tYKW3PyTCq6WtV9EgmvLH4n6S0KP75h3ft
 TYukUueBku3p/pWb1J9t+/49kwUaBux5eDKHv/8Bw4k/v9ciD2ORQoeEKicr45xTej4xkw4vW
 saSsXdGXK/r/iBj3mOaz4FzzA4yBIXXRHYtldEv3bPqmCBIo9bDQgIG8ik3ySFEOQLnkmADqT
 yNVKnJmVDRNO/z75BrdWq0OWqQgBc3x44Kj+bKE3QCaFlcdYlzsgn4RlHBou9a07lDjkhnmL6
 TqyffWo3K2wXdTpcNeowF6JIoeZs16ZLt2kzFfTb3Jla9p8wEq8wC5KC1GTaTSTxfPqx64Gpz
 UU4hdNJLE9sd6m/FsEtWNr7irUTWBEIGF5AKi5Kroam5eUiLfUSU8M84Yzxp9HSqwpWEf8jwz
 q8+Y/RRSzgLzS2j5Em1+lK/h11+U18hD1vlLHfEbYRv7K3jvwU7tpBxMXnPKIQM2FZLQoxFvY
 LAwrZ9Hgil+J2NFRUhXKWR3BNTfWReQhRQIqD8ObWbOBaHrBAbun7jOiwBHo3574no3x/TZiC
 dSofAzPcOSpja87pDOPe0Em6hgfHJ74C4dzUpcvTTRk+x3pqLYDbj9WXYCIn2t1ftMRpNyYSf
 /ddOFJOrodZ04A+VNThAVGQf43D4UDlZVf0EPZYrn7bxjABOBYUQweYuPQjZwAVAEY9XrheW1
 l1zhYziqNeduECn/xSRt2Qxu6oQesYGsCg/dHpSczW0A3k5v9JEKcAjYOf9QXw+45Qhxu+lDo
 PUw/G9FzLj4aGGbu3Y486yv1cN7ATEPSxfFjIq9pV9k9OwnzKk7cc4+ft1BOfdg+oNobvME96
 bGEvLdz+cSu4KCyLAkgWRHKFBUFcYse2yXuUvcu/LoJAlOpyWjyYhl8XHZbKceIfAXdknAbT4
 /Zjp/yCPwS8fcToO30RZm+OMBbwgcLGJd3u5D2ON9gSKNwMJPBg0awjjUvAunFKopixmlijGk
 5nlL1TcZfh9a0TewGuAbQc0kLU+cEC0t7OVfUxMi9ttRQwwGO+NyMFLRPoN3/q8p96thlYrsn
 PvKsF8ixGeSWlMZJOSaThlkzoAIODdhisH2f698w0/Y335RoDM/pwjvcjxM07YrTyMZFlBJor
 18F+cTeXKmKpUAHU9PUdc0NEHkYr8GiagO/QGoXCDqyCSpN+QGwlrhGAzSO3Z+SzijgIn6nRk
 my1zH4wknQFTON1QvtThEG1CjmhESN5psE2dUwYCzQ8ictMi0n9b9V/D6djd/v0gSMjFsBwfr
 W+8jxES20TIdZPzexh6Kj4sNPUgli7GG3Z1oNFY5xAseW5MSnKdjQRLBfPHCWHRh6XAFLQp20
 29gAOpSdCF3aHzJjItEO4oxfoR7AFfBhjr/A9Xzp5nJCdLc+QJFw0R/dUgm34SSRBox5ZQcKd
 oOSEWs8TpfO8c1QTILAk+UmKLneDx0YUFh9hsoZ+tt3Y/nYPvxmy1kuyZUtgqW0qNuJT4x67G
 iAoWWpdgud3qQnjzl/2TDY8NAJ5sB5NWmZgdwl1sWLVVauetBF+XMjn+Ngpor5NI4efLrc+/N
 r24JSyym3fXqtIjVRmPwPMtfYsCF671H0T3AVOmKE4maGcprnVeWDxYO5uPznw/1b1xS3H1H5
 zgSZaCBnZjrA+SQenY4TfslkvDgZnL1Ed1kYx+INcc0RklUBumDxD5/EoO7ItWaSriL1imUqF
 mXcBKlaXAfs9ykcPbaPw6qs+LV+oYpGSo0ne4flYW8LVbMtUXbGRxybxl1qm8vVYkjZTaykQh
 EbkjxDMvoljk4BSQVYSm2++l+swt9sn1xp6hxIeY6Fd3u8lXtTyH3tZFE8NHXt0qNb5vb1S3H
 jCkcRmkgWoUwbCUym0gwuC2ADfEOhJjaK2nEJXQt0x+0wnX5qzIBkiZcPM2jACRewqu2ZHRt/
 7MGsLFGzzli5lidcyhaAFLua2xZl7i8EW15AH0V1h7TKUwr/xqli3of+0h1ur2XLC4wDgxhSU
 RaB87soRZ6c9ocyR6w929u3EciDU4ozPrl2Sbj/9kLw43Pnc4glLT4nhgnRJy+jSqBsl7skb7
 yALFYXN7Cn7suQfcsyODXenepZxibC7ZjtikZNsG1Yy6d8xgJ7XN4aPOZft/J+8GHGPx2SJ+p
 52VAGTNGKDK8pCWxduOo9+F7IA2gbyynNQPVR9LXvL2DugMwEPg2ImtRb+vzznOQ2riYF9pHM
 TfalbSirjE6BB5w3B0OjdM7CzfN0NF/c/9971h70MqSMfiYFzWw6fqlDLnoje03vxz9Gv0zQW
 NXpbn3zfBngBIzQuxkFAB9eJgmYsaWtoCVVjYmxWMlXWMbfsMwx8FV+8OKLLXnMBdwN3SsS9u
 F5XPw4tJ1cpzYaVH36ObPCFgr3b4AAbW0SkwDEbo4RjnFH3waWyM+upiNTNZBiz+zaMNDQ9Kx
 kaOv9oulsy0IkjEuIfNnct2Gqoa1bwx7i3ArjHcsz3f11lju1Ak9eMh3ocddqAUsk7A1hVlzh
 J8tKiK8ihkBgvHqFuTGLp3CXTzjwqR9Uec7BKLXTM5WuThvsAou3gFvhGVk8dqtyrTGPKVQX1
 NJdIGlRewta6jq5b+IViUiWQD3R2wzvJKzaS0MWthksBCKJPg1TYLhDliLZ243PxWmcj0WyXv
 VpedkK8CNIo1nRYL0UgfwZFpsjreZabvurFUAnlusYqHYTZLBX0KVO53r06g3DVM/UmbyPjRv
 NFimhGkd+CdqAOfQCrS5qXfa+lO08GNu9otFClRLcGPxYdPGAPqZ2npMB3KDocvIzVjxKuxsM
 +t0v6RmJDUXJcQWZKx50duOMK/JGizq3iO2jWufveLpCH5C6SD82xQEKsx+j1L+GobliO19JN
 XqeN3fAWTBvb8WNdxTn9hHTyuQh5wKTU3UHKvd7adIqGil1OglA9QCvooCTKAe+zJo+ULSDNp
 0kjK8AJqmStXLyfhGusBxjAyh6Mkj5ewjFD304WZt+iMpwIQS5rik9ORnlT8KkOZc7AP0VVHa
 /sf907rXZsL932PTC5Vc3rqWn54gj/Xx2uE/D7N/XzLWp0tF8psRDe3vRPlgN5FpV+wmKt4oT
 3Go4wLzSinQMmkWASW9g7l8QzNtJyz5YtezlJPTUA1BkwP3JlG//p+pjg0Atdf9j87knxLwTf
 A9CDfzpraQ4j4Zk2c11ZYO2olKoTolDDpBTzvOzrarxURa/4cQmORrtD/KhyVHtB4utHoE0G7
 jMNqLLONglAviSH56M6fAK0mx2l1RpQqc+BMi3WHa+yO6YndSPvPl3DjBd9iFoTZFEv9PEae2
 JVtnyj8ns28Kv2mjf6lXn6eiwqigl0KHe8LWycN3G+TScDg+n3zHsdUVRyeKM/zIzZIdTkvRG
 PvkphyYhPkzJIV+TBS6HsaLUWqI1AqmrmgbtX+FCC7sYZVRYaM20lIbfpiaFenFQYC3HkFTsi
 cTxTY1nXH4L6dRmiGDMhOLSlkthM69W+Swbe0BgYsSHXD8ucuwix3o3okrXUgbN5LiXUpslVw
 vCJrJfRHBVv4do8jvnv+sSrZGxg7X0UAntjpmuwOrx80hoand0NkztGfJmfrlz7s3dYMX4oLL
 zVGhtYEnUNcUIa0FrY5lHGbmLF543Wx5jpUBeu
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

Am 31=2E Dezember 2025 21:01:30 MEZ schrieb "J=2E Neusch=C3=A4fer via B4 Re=
lay" <devnull+j=2Ene=2Eposteo=2Enet@kernel=2Eorg>:
>From: "J=2E Neusch=C3=A4fer" <j=2Ene@posteo=2Enet>
>
>README=2Efalcon was converted to HTML in 2023=2E
>
>Signed-off-by: J=2E Neusch=C3=A4fer <j=2Ene@posteo=2Enet>
>---
> cmd/Kconfig                 | 4 ++--
> common/spl/Kconfig          | 2 +-
> doc/board/ti/am335x_evm=2Erst | 2 +-
> 3 files changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/cmd/Kconfig b/cmd/Kconfig
>index b71ac554c0b=2E=2Efca2a0b0e39 100644
>--- a/cmd/Kconfig
>+++ b/cmd/Kconfig
>@@ -620,7 +620,7 @@ config CMD_SPL
> 	help
> 	  Falcon mode allows booting directly from SPL into an Operating
> 	  System such as Linux, thus skipping U-Boot proper=2E See
>-	  doc/README=2Efalcon for full information about how to use this
>+	  doc/develop/falcon=2Erst for full information about how to use this
> 	  command=2E
>=20
> config CMD_SPL_NAND_OFS
>@@ -629,7 +629,7 @@ config CMD_SPL_NAND_OFS
> 	default 0x0
> 	help
> 	  This provides the offset of the command line arguments for Linux
>-	  when booting from NAND in Falcon mode=2E  See doc/README=2Efalcon
>+	  when booting from NAND in Falcon mode=2E  See doc/develop/falcon=2Ers=
t
> 	  for full information about how to use this option (and also see
> 	  board/gateworks/gw_ventana/README for an example)=2E
>=20
>diff --git a/common/spl/Kconfig b/common/spl/Kconfig
>index 4b10e9c3880=2E=2Ef0612acf0c2 100644
>--- a/common/spl/Kconfig
>+++ b/common/spl/Kconfig
>@@ -1209,7 +1209,7 @@ config SPL_OS_BOOT
> 	depends on ARM || MICROBLAZE || PPC
> 	help
> 	  Enable booting directly to an OS from SPL=2E
>-	  for more info read doc/README=2Efalcon
>+	  for more info read doc/develop/falcon=2Erst
>=20
> config SPL_OS_BOOT_SECURE
> 	bool "Allow Falcon Mode on secure devices"
>diff --git a/doc/board/ti/am335x_evm=2Erst b/doc/board/ti/am335x_evm=2Ers=
t
>index 40e144948a3=2E=2Ea54439de29f 100644
>--- a/doc/board/ti/am335x_evm=2Erst
>+++ b/doc/board/ti/am335x_evm=2Erst
>@@ -274,7 +274,7 @@ into memory, then written to NAND=2E
> Falcon Mode
> -----------
>=20
>-The default build includes "Falcon Mode" (see doc/README=2Efalcon) via N=
AND,
>+The default build includes "Falcon Mode" (see doc/develop/falcon=2Erst) =
via NAND,

Thank you for the suggested changes=2E

Inside =2Erst files, please, use document links=2E
See https://www=2Esphinx-doc=2Eorg/en/master/usage/referencing=2Ehtml=2E

Best regards

Heinrich

> eMMC (or raw SD cards) and FAT SD cards=2E  Our default behavior current=
ly is
> to read a 'c' on the console while in SPL at any point prior to loading =
the
> OS payload (so as soon as possible) to opt to booting full U-Boot=2E  Al=
so
>
>---
>base-commit: 8f520c0d5656196ec4912c837cc156a399350c33
>change-id: 20251231-falcon-7a97211ecbbe
>
>Best regards,

