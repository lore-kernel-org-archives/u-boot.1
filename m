Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2829C83F17
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 07:08:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0779482F14;
	Mon, 28 Jul 2025 09:08:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Hi72++/V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5403482F8E; Mon, 28 Jul 2025 09:08:06 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D5BE82F00
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 09:08:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1753686478; x=1754291278; i=xypron.glpk@gmx.de;
 bh=RWAvOBUbytCqrzdqqvpXsRVP9a87oAKUF18gcVz8VdQ=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Hi72++/VynEXACr9PHQgGZ1P90zObZz3RzmpxOUUaG1HiXUgyb3+hdLQWB0BIxhx
 bGmxjjbRifLkp7ExRfHMExu2Bz/nszVY1s/UX5SOaytmCLS8BEaKPqb4zpmluWul0
 eeo4TP6w/1GPSH8+LQOTYFgsCW49je2cJKlEOEpyselVr/aybes2lHP12dccZSBWv
 /FRBzYeUMjO/gD50FvhOGtXxAsffB2RlQXCh2xFs2UxPpZIpYJxieKAkdnVwPZQ+S
 N1igigiT25ynuEiQyACLreCoGxJmRhAiK5Q3+4sy/tLFmtsdZ7rWE8h4HgD4nHjTl
 xRsbPUA9g4Ph8ywc0Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCsPy-1up3PB2aVU-005QOp; Mon, 28
 Jul 2025 09:07:57 +0200
Date: Mon, 28 Jul 2025 09:07:55 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: dinesh.maniyam@altera.com, u-boot@lists.denx.de
CC: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tien Fong <tien.fong.chee@altera.com>, Kok Kiang <kok.kiang.hea@altera.com>,
 Dinesh <dinesh.maniyam@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>
Subject: Re: [PATCH v7 01/12] drivers: i3c: Add new i3c uclass id
User-Agent: Thunderbird for Android
In-Reply-To: <20250728065612.6039-2-dinesh.maniyam@altera.com>
References: <20250728065612.6039-1-dinesh.maniyam@altera.com>
 <20250728065612.6039-2-dinesh.maniyam@altera.com>
Message-ID: <F6F17ED3-FEF7-4DEA-B3AB-C6C94AC8B45E@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WqgYZ28Cif5Ns3NR3ScNndVOzwWZcTuz99OI81Z9GiB0KH6hyHb
 wYn4p7oQ4ZlCmEsgBN43XkxJIxjq3NVdHGqLHIMaFog10pFyESnIADojzdxeDppP6Ar/xiB
 cb+ucZmPTbnLvV3ca6c/ZO6kyVef+FgsR07PgoxXtKnBFMCtPnqiWnT1CirN6tqVBMRJSsA
 mD4Gv5BSoOALlrnlPxj8Q==
UI-OutboundReport: notjunk:1;M01:P0:zok/KN3Vs5U=;B3htrYQ3+djYLR21W83ma4XW9Y9
 7PCqI+ObSGaw56Hrh+cRueqJrQ3a34Nrcd8AkeGGpfU2fFoVoomJRHvbGE+srgbYcrSrjdMeX
 yIhHx87/XizDFG5jX4K6566Hzu0qphXRos6MvZUTb1K3wIFVtuMuCZSi8cYKiYln1IfQ2obzm
 yUPGY01Lj80jx2y72WCK4vcANK14Lgef8H1eDyf8Uv9/zGdWLxhQ43+XmrgvyuRyy4cAbVag0
 oJW5BnI6PkfFLBCgTvd4ivoX0tW31pnk34BVsr69tBuBNYHyEhsubhqrX3aoSTPh+6QEusATV
 vUMarGIld5sCd3z8eIkppSb7COo4qDnuGkDJggBm4uiUlzpTjhmO6VGQNYEIlW5MBLWuOJEO7
 wYJbTEwJnXBIWfrgWlyUEtGSMKI1/AI3epeVze5b6pk/lpUKRr136x+YwV9jsqb66T5Mhb5Gg
 TWtZUsoKPMiuM+yN+VxgmtSm5dxXsfg2Za4hWXyb1GB2zQ6tXb8fwT8T5s7vHkMdEJ3t4a49s
 7zgXlXTT5DLeZS0xsVY35x7S5muc56oPz9tfsrrKTHCKb3KZ6qp8fau33p/8vG3WuWXkzOzWn
 NxK8vSwy7m1zw7u9RWdHV8NFq7oYNGFGQRyCpXZZ9wLPUpPSa3GYxOiVKxiBq9ey7uq1Ac2qD
 v0K050cyyRqhacVYiW0HzEaQ7bPuMgN+cLmIYVs0a5ohr7E/kR5jq2DFWKGKfsCdJ4CwVPEOJ
 Zare2AHbsbpwZIR+y2yqT9TCqzLOTBldIr2MlMD4ZC3kzX1num2/am/PjClWJKUUxEFkFOvxC
 t9rTRS0oujg3cwXFU9HpNDWXY8Zln43+z5oRBQl+R870h+tCA/vvPPZhoRw0AtPYko4s1yMJd
 qSrcYr56AMOYlBfaqDsT3qW1+sr7OQcIzmA9ZeeehK9QdYEXaGLYw4JiLcL3zF2xXLIMkTN5I
 JmQsAoEHO6enDP/cdIgUxhAii5S1M69dNfdwEQdVowzG+/R1pGapO8A+PkzMblSBV7CKmDuHK
 gsavxVMzvx3LPJwj8PySSniFESuUNbGoHWgto36AstzVDYygZPClpk2F0qps+XY+eSUlMo9F7
 a5duwmjs4OqG2B3qYbvn/T38gO3d5tKZxtbxtRb9l4/WOrsUXHahZ5u7SGm8wrbBGMDwHWMuj
 +h19vLJtDMlGsV1eQ62tkyQHf2W37ki27zJ+gnG/AstwRFAyzOshudf6K+AQ7MnH7wgdF9pRv
 np68K1rwDfV1+2TD36/GVSfk38MW+GmQj/5Qb9BgHbj1At5saiNDArqTk/7kbC0Xf7rbbN/Fq
 epfNplzMs+pwBr6Sr315WVekS/6KPPbcXshUBBKSw9IokDMC1BiuuBJ71fzJUdgVLyb+ZiDpS
 DZkd2IY9en+PxywbpZ1iZvri84SwpNiFv2/6s+NeKO2qY5oMq+Z+ZCTtFWxB61+sTvHr4cBHR
 ith4ut+6BRtDbca3PY778FReBUU1okeUrkS2kgTJAqL26J7X5z3anfoIwYbXOUuYjH3j48Q10
 tW1Rcxm5y/TuMit4WKHCC1fnY0+Bv15f/bbPnXxYNxNyKdGMamerVDCTScJjEnJjJPYf7VjrR
 s6yAlZB3gemeZMD3KU9w1t8kE08vMRsVvq42Ym8/DWIlW5lKIXNC+/OimwRkZ4TX1G50O1uVY
 RYyo8eszW2/2IiV7tSdfgsYzvoAq2R66/qr0xmNampCgtdhZdrEwoO52XOQqbN83wK+TUGPVy
 QW73m8aaTnBbiit8ZwYM589iNHosItz2OGSIblfNLB3Z09ls99PXUe7tJhGQuperIwHvlYFKD
 BT1t0pwilAdjbPcqHYG5uDPDM4pQPLh+su5tGul46/8zMCcF+MXdb+nruLjKWdTPmpdTVN5Bc
 uM0T+CMW/ZIeElJK33zgHimCKHpKc/XfhsrKlUSy75c9cxMKExlPqeCRzDSBGt7CSk5savfE+
 RwSpjhVsNvg5ciVQz7sj01iKnGr6/+uycQeUICBnmafFyCxFfwVgJrDpvjwkDBlNQ8I7cf7hN
 s7vqNiKURKjxL5jtXwhQkeSfaleDVdsC0bIj18nyVLm/QMSLJLHYbS/c07zAk/bM0t1uk7CUh
 xkjqcfSroP2ltD23f+cOSErR59XE6Tcw11eInjBY4ZZcUjebdKEetBiGtbMfDv3HLMiXQxFr+
 rzA0h5rD61TC4OjERcofMv8SXr3Tz8CAub0r7kqux3qg+EQ9z1ASWDnugwaBrT9wSg3qZlHi1
 T6ATYhrj6e6rOjmVzkhErPyD9gLZ8ewkKKISgoTczaBYjYd+f90IuNVf0xyu9g4LRSf90K2YE
 E2CS7sTUNbSvH5kHTSxqZfFTu/OfFh827PWq555y9zBK1ZC5zl/9gEvKaA0CfspypuJlcmj/H
 LQrJNe+EF2hU80MJ1WK/mqviyJKsKuyvZoFZvwM93UR5R780U6xn/ImNh/5d0O9ov1tX6+W3Y
 JP4Bi6EAt4hMvuypWKhA5vY0y5rZkIoToY1gJponLTtSMixKX4DRbvQWFW1yapn+L8qW78vfJ
 U0Of6N7fP53GbGGHBu9sU6JA6hEAEL3mQCwY8Zv3LGFMNX961TbZneBzTZeFhbcJ/VTct1b7z
 hwA0ly78Nb91cuj2E4iNi5wEVs2CIeuD+7jwylEJ5mKUUBzEG7GtqcJmYv4acsMFbhWcUkP84
 jR0yvcGobB1MNAfp+Axwsf4tzw2uG3Viy/mT7MGr5831bUIP5Ijx7u2pocCnBzoPBZ48EmSxO
 Qla2akxwxX9XM6rpH4HOTyBPufX2pNs8LStrOrnJwrkbwlhcluKnas/2XB8IXV5xZnltoc3Um
 bXzb3dCAwNlzmOf2J2NfUkSJ7JRtX491iAg+RPeehfy8yMCQlSEGwDiaPEFkecBbOExUucN4T
 lW3XwX6Q12WDPA9wkMW9jnNS6t2oMBZhG+rdXAx8uwbfD9LqDJMlCBhntcpb/HWVl3qGRMN0L
 nVktG88lCPkJEgxSM7xQdY3oyLs4fo/S/hAQNXpDoQmk5QoWJZP539q42hqP1h+eLsNdT9IBW
 +nc3LsP3csD447xgGSjPNL8U5Jq4usNKjjisfqV5n2P1NaUsK1ZVqcC0G1Yck/w2vKo17n2iY
 Lccjniwd80bkCJlbyD+dE1HLaZDu7PT5Zwsnk8Cb0HFti7br9MUJx151ih6pJPQu6Tjl3uY0V
 TyW0aUjpdVuHfyRCCvYQMy3O3p0xD9NrI1+ZJRnQ7QOsMKwWbKb2MOdX0EWJUL/s58lIxyUY7
 HWamg5jWXpnj6oFzgpnWvMQyRLXBbberlI8dXA1/BUdfhy65SgGYtuSQEisgoc2iFcJ7pKSX2
 vA90696QcoF2SSvjtoF9Itxh8/Ryp7xlf/BsLg0cYd5WVyuoupEBrKdpIzp0/KGSge/og3E5G
 7BmSmZKQiL2YImwLA2To1GQDkrCtQeZtXWV+SGl2Z4Y1cTjcrDZ99c4wmRvmmiQAQNiILwWu2
 z+IHEcZWgBQGeY1htEGcWvYeWbPwrxes3+MHX+BuSluWvzE+Kh/a0
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

Am 28=2E Juli 2025 08:56:01 MESZ schrieb dinesh=2Emaniyam@altera=2Ecom:
>From: Dinesh Maniyam <dinesh=2Emaniyam@altera=2Ecom>
>
>Add i3c general uclass id=2E
>
>Signed-off-by: Dinesh Maniyam <dinesh=2Emaniyam@altera=2Ecom>

Reviewed-by: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>

>---
> include/dm/uclass-id=2Eh | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/include/dm/uclass-id=2Eh b/include/dm/uclass-id=2Eh
>index 270088ad94f=2E=2E1d259b439ff 100644
>--- a/include/dm/uclass-id=2Eh
>+++ b/include/dm/uclass-id=2Eh
>@@ -78,6 +78,7 @@ enum uclass_id {
> 	UCLASS_I2C_GENERIC,	/* Generic I2C device */
> 	UCLASS_I2C_MUX,		/* I2C multiplexer */
> 	UCLASS_I2S,		/* I2S bus */
>+	UCLASS_I3C,		/* I3C bus */
> 	UCLASS_IDE,		/* IDE device */
> 	UCLASS_IOMMU,		/* IOMMU */
> 	UCLASS_IRQ,		/* Interrupt controller */

