Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D68D12D7C
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 07:14:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 591B189100;
	Mon, 11 Nov 2024 08:14:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="nMC9/xr+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1465389100; Mon, 11 Nov 2024 08:14:17 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8573088A0A
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 08:14:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731309236; x=1731914036; i=xypron.glpk@gmx.de;
 bh=cSai625galgriVndS1gbeMQcBAFJrN9Jt7PdG/I7u0Q=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=nMC9/xr+1Gbdysv/klfPk/HzmMkRY44dcEGg0CHAqMb9efr5z6IM9ChnM+785YsA
 7C1ix25PDLPqlGjgrT2+CNqquDR8sQe5B3ObUyPkfg8GiHcUnejSJ2JZv0cgf4dIL
 3x9k7IkfRvXquJ1IOS/jag63JDfkyUlDlLeav1wJE2+HK6J1Q49FseVxR80jPB6nu
 rMye6MxBl8cIoS2MPlvY0uUs6MAmHxbwRCnwKTJLbRb46grv001FDQR9zx5j+1uIz
 kd5fcETS1GZkuxbJULy+F2VjCpL03g+KRAsEYSmybfiTRkm3arbtPKNqrVfJyaHa1
 +4Rdr6EqZ1MN+zuhCQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbRjt-1tlNCU2maX-00ZL07; Mon, 11
 Nov 2024 08:13:56 +0100
Date: Mon, 11 Nov 2024 08:13:52 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Hal Feng <hal.feng@starfivetech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>,
 Rick Chen <rick@andestech.com>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
CC: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>, u-boot@lists.denx.de
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_12/13=5D_board=3A_starfive=3A_spl?=
 =?US-ASCII?Q?=3A_Fix_the_wrong_use_of_CONFIG=5FIS=5FENABLED=28=29?=
User-Agent: Thunderbird for Android
In-Reply-To: <20241111020808.38974-13-hal.feng@starfivetech.com>
References: <20241111020808.38974-1-hal.feng@starfivetech.com>
 <20241111020808.38974-13-hal.feng@starfivetech.com>
Message-ID: <EEAE3A6C-C3A1-474D-9DD7-83FE425FE5CA@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xOmE5Hv7+iYgGQNH0sgjUcfhE5At2COKA/ZBCV7EGXnG5pX22wC
 4pmHbRNXFSeBWgAoce2QRh+NbZ7DC7ZUGn/PHUGRjHjZ9QsSWyX6qpTFDeOQDeuB6rFYqaQ
 OI85Si3u+bQBsmaSQSfEfv7C1Mh7/7p35CAocoFBvjZNevhxacxmaorHQHAaI3gwQnuzBvi
 VBKg0sTOM7dWnMsMj5rbg==
UI-OutboundReport: notjunk:1;M01:P0:r3vtiuLasRc=;P4FFkpJBw/U1zS8uritSkx9+/3D
 X+/oD/7Atr6SuBnD0PfGsV0aaiIHfhEiZ1oAnFG8kzU+KnIy23WdjTBlaii2Tde9/7pxlAsMC
 c+ZIx8UtT/G0hKXBdKwkgbVnXvzPsU/DNYiVayh2jQtrtEGnX3oHaEQa49Xd+4PKqmN58+Q70
 KFCC0KIJTIOGE3wX4fXhyjF9njnMUcUBi8gEjjJRPE+i4gl5YpD5MQjBcPFCeJA+QLouXf0H+
 rgLjjBgDpk7lw9j8dmHf86I4u78WHhkyq4EoItVoihQbp0uq2T2Vfb9BMSTwHhsEzp1oFxZVo
 k2KdV74NVpNs4sbHQwHZrI24lurR2Bh980LRukVd7QlIDb+5lQ++GWWeQ5scirjxNQ/asJNhQ
 9zeleOZk2XOYk9ZRpuuCYLzad0Pc48p8kagCU7PL1wW+ZTgz4e9sBAYywyPpVdroUYeK6dQIc
 6EciwPHadufo/ve5prL01x647aMm3fpA8Ql+68k0rjkukM7RzWfvafDntdYN4Wq3DflsYRhZ7
 OnlxZR6UenXR6pW727Xk2V48xlgif7rYYbmK/9cQAafnWM8IGBYd+33IF6a/Sv4mK70z1GObX
 C/HCwMh0TgcwrXRzCOnFhA6y4/rZA7yLp7Gll5uY30ofgkb7Ssvb0Mw4QEtRDrVCe85GDSSRB
 tA/SDDFLDvsHUHJZkBnyw7jGlFynLGeS8g6eSBfsrSWpp9AJVVd00/rSt5iukA/izGO/y+oOo
 lqYuzXBHS5ntZrqvNajKVvSxok3LplKrn7kDoU1RgD21wA0ONiGZQJjJ0N3+CAJzMXGG02fQu
 zSky3tTk/ARL+0AxJ/p+qroPHcxdOmFWAABadd1vUUrr7ZHr3yAurUCCU1yQWhV7gKQNs07xK
 GKPM6WFK8jCmMmgZdaq2442DbQR3/NF+jSHWKPxaXPfggVQN89TXMgSuL
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

Am 11=2E November 2024 03:08:07 MEZ schrieb Hal Feng <hal=2Efeng@starfivete=
ch=2Ecom>:
>The prefix "SPL_" is not needed when using CONFIG_IS_ENABLED()=2E
>
>Fixes: 5ecf9b0b8a75 ("board: starfive: add StarFive VisionFive v2 board s=
upport")
>Signed-off-by: Hal Feng <hal=2Efeng@starfivetech=2Ecom>


Reviewed-by: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>

>---
> board/starfive/visionfive2/spl=2Ec | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/board/starfive/visionfive2/spl=2Ec b/board/starfive/visionfi=
ve2/spl=2Ec
>index 38132ecccd=2E=2Ecf7f39d5c5 100644
>--- a/board/starfive/visionfive2/spl=2Ec
>+++ b/board/starfive/visionfive2/spl=2Ec
>@@ -110,7 +110,7 @@ void board_init_f(ulong dummy)
> 	}
> }
>=20
>-#if CONFIG_IS_ENABLED(SPL_LOAD_FIT)
>+#if CONFIG_IS_ENABLED(LOAD_FIT)
> int board_fit_config_name_match(const char *name)
> {
> 	/* boot using first FIT config */

