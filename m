Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A0CDCCF9E9
	for <u-boot@archiver.kernel.org>; Sun, 26 Oct 2025 19:52:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4454682E34;
	Sun, 26 Oct 2025 20:52:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="AmipClBJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6E56832AD; Sun, 26 Oct 2025 20:52:39 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8543E800D7
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 20:52:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1761508357; x=1762113157; i=xypron.glpk@gmx.de;
 bh=QfOm/6dqN3YZ+D1PtRsD/yRYky3Gue2CJCoCIqCxFB8=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=AmipClBJo3OWdYQISVYELxpR3J1Cj+kNxyY9HFKp8hEuJLWHre8xRNUN348KVPvw
 0XEHbkvaISBqku0X6JNPX7+UXCoaQPbRC3q6ECpMzq4S7jU12xRgCjVi0MxW0oeRC
 9bcwlk79Ac6eUMttIaCHMc9m+kysK44th2pvXJkR4wLBQPKFBod2uF6m2FXv3CpoM
 iFH5Klo7xCc8kwwHPT2tn3kdCpH38aAC8auDruEJDgxht48q/f2Pu6BOMJSoNn/Ry
 u4CpXrY7ql0g3g7mH6Va2UVwI5RUxrHZ/SbA5N4IomekalUsbiVxSyOWMoNGPro+N
 JkU3DfWiwVtpywhUqA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ehlo.thunderbird.net ([61.8.128.92]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N63Ra-1u6vG83OVk-012dmJ; Sun, 26
 Oct 2025 20:52:37 +0100
Date: Sun, 26 Oct 2025 20:52:32 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: E Shattow <e@freeshell.de>
CC: u-boot@lists.denx.de, Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] doc: board: starfive: update jh7110 common description
User-Agent: Thunderbird for Android
In-Reply-To: <25d1e81a-450c-4e44-a57b-6eb7f30879ea@freeshell.de>
References: <20251024083351.237033-1-e@freeshell.de>
 <5587839a-6d4c-4c0e-ab2b-fe8249463198@gmx.de>
 <25d1e81a-450c-4e44-a57b-6eb7f30879ea@freeshell.de>
Message-ID: <65456B09-0D88-48D7-A74B-F06211DC0BFF@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pPs3Q3FDM3nORWptgdqLv8ks47Wd+yno535/EkERECqwep9YQMB
 q/LpzUHyT4h0VUMqKSx5GK9SXoRTSJtUuhP9t01iO118TySp6JYmKnGkwSfxjTIJFC1dg2F
 2oW9zBZsXc6dDaSVtGziRyEWtAvv0S4b0CDxEfY1CM9zHGyKsd7yf0l0bTdI1Kjm4VS8P9J
 PqycLu52ZjaFa+lTUiG0A==
UI-OutboundReport: notjunk:1;M01:P0:a2tlQS0KMok=;vEus+qaLV6FuH2i9De79LycDdXD
 nYp3429HfXMfas77CpOBlyPcsFwk9jMPqHiBLwok0sVuykZ+kKLL3WIhUiSJzfe2ioKWJBW/V
 1aPiAAT8shVVJoqLrg8HKPYMe9O9cSgaW8vINe3iNJcH1y2Rby3PNCVd5+cLaWw2B/mtrhxhx
 BGKXuOhKiSfQ8lSgGHYJWAECIynJYglwaAbI2RzABheZs3Qb7tHSQD6Kc9A3xZf444e5puEOV
 6Y2BnBeWV/1Riuqc+YBT31PqDSM5DFOfr7s8VL0k9RJzbLwn3mcy9wF8kTZ68BYNaphMJXElu
 PyPr5ztH4L8oUrZv9NbJO9ZC0h6uMSq23RHupCZhi+FWIm1sHsO18qZVl9KROinK3MfFeEHKC
 DPb6UfYnth3N1cFYgG2o1VJX2KLqtdjXLIHKycGa9BQTtyhmAwSewBmsEXm/IBBzhMFaQ4E6N
 w+bjfKcuzZCvy4fAaF/zfoR5m9iKf+CgvUEh02z4cxsgBOTNTN/500Rzxk8iermAH9/Ot+q6z
 1C7JwQMRNZ9X/B2uTSo7cXi88ScEGnj4ezdfiulBFD1Bg9FiDR4bzPxe303JVPdSAADvvtfZ3
 1Eq13/LLoDSKgDuLOGG15/KnHhaF6L3FoYyNrM2yWkXuk4ZcuhbY7dQAZbIsLTGVc7Nfv7ubX
 qfXezgQ5C7wB9UAZmHsy+khE7b9DXhZwqksOSSVPmhXrZtoqRJ6e45xer395GHIhIJcTVsvRr
 wVc9Zg3Xg3qiDZb5UjSyifj7DfUDjHi9+1/jQMOleHELXB3ktamXjQnjAYXonzuhNqLGgBvvp
 soJDKJ2JjO0IVZNvRQovc4OwtMw5os6GCcwn/Ci/MQ9jDeMjgqm1PfeoLwnoAy+TO7dCxj/Mu
 HrV92+7sFAxqFDVTrvGqXSe5rMXr/y0APg1XTESZoP1aVOkqT601cPxNh56dh8bI1NKol7voC
 LTTBWQMVwsecZwJxYXGUHzXWyiRg7+DSDwmvuSI1FrSTYhMqsRiDIL/YfV9S3cNWXpn8sNesr
 j5yXrUKj9f4dl2hTfj4xBnc/Mm37C+QKPW5e5LN1zHLd9fLMutLdK7i2TsUosO5Ts90mv2g5z
 /rxN1XKWPBf4W9iIH9OUXIPO0NVLLiCse9RZgF7m5lQAqsmMLxFYGyAYa5jTziVf6Yv70WnUA
 IGqod5WL6M5dp+Xde6P5kM0Wt+2fnH+Ci3rdqsLSoffDf3ORfEBiWKtak6RMMQbXeoezuuhnu
 B35cZBQavyrsEuXByXHjkcooKTQ6HIuMm+e9pN+IvXtplvKheEIZwp5T1qPxi+EwQTrRlzhGY
 FxgK3ZJdQSvjU8XpbMJ1tRNLes1kzOGeaUD3plTiIYml0MYTYvx2IcQnRlzEnDcBlcc6+bzK1
 4kgLy6150qsb9uOlNRAFFLtqpwboEIdVtTlbadlo3MFwlZmuBQrTdukTMCLiiLceB+pVVhSCg
 CqLbeBYbjB2ztyJs9KjLxNTR4QZoZlD8s1dtutKXlt+sTXwjVwcUgo+NYBOdyi9qG5WZm41zA
 ZqyCcXqPGu63P51p0zSFOWSkCCbwefddIB45Lh/bO0QJo+P12l6m7wk8AQHkheAJh+OgMcSvt
 KRs0RWWlKrfTOxogOVXXJFUyh/XbGDENADowvmsX8Er1J9/qDB5D/rUVpC6Te/uB8nm92qGBb
 438MKohdrPCu1nzymnt6aehzZlC3bD5Dmbl1BQVaJRXxhmTBfWSlVIebKtDBDV+Iv1ykZBt3W
 OZHRFvJ9/wl/ef2C9U+GhDdt5Xxxx9GTMCaAZSijfspUewr2BUCZ3SgvCwngEUwKnlsJRhsSw
 T8ahiIwG1an1VrDgcEFnxq2ghf0I+/QNYJalVeWkqzqDorjBoihMJGwo0SMl7ajW7sH/S/dzy
 f2zoaDE4fC5/mDCvuFWkerrffCuhs49cun08urgtsGXBhlhWby90EiVAlTu8Gewh+D28J7er1
 mLc0JPx0dnXPbtuWvpcSmnK6oVKh4m09E9rQdh/dQsFbrceO05WGRdR/GpqHQCJ+psTdj8MgR
 5brujdtovyUSZtQqA1OCEKg5++9tqo5AbGUVDVAFeBZnv1u7zVsXlsLWhK7VLW6AVDJOXZvWb
 C/zO6KlhXaWGsa6Puz61YkNTkClKvr0x+hi37WU2yFY+CgQtmdwUD+zgh6NSUAJhdUQpjZBtE
 RUTt2epzBvDv0Vto6NFv0UoG1iDOpQHYUhJwAxGJwND91IwP2KlLbWmqdZmUnQXR1c/rHGg3s
 WDyVtxrvRfu1TdXEG/kQBrUvEhik9huwzilwvO4RTrTi2oWfBZ+Ovb4PNcZIp7h3iZdCFPCpI
 dFJTITjgcAMkm5Ir13ZTQHI/rhHm34SLYQf0iSeub7FJF7JovQwbUO8lXuDN7fTY0pih+czAC
 MiZbILdUDNuT2GQBiP2UjraUSLk4HSc8GWDarYObf9viFLSd4piA79HNMCU/F83ZKCGVpvXYA
 15M+82vdZzmQatBb6q/gwn1JMdFLLKtEv9vPhU4mEkTFOSAS3OszM2C+Q7DmdKgbBvS4kWrZK
 MA2zjQ9lZttOAIN66cuHfO88q+MLI7pk0olwmJrR5W126j2/KmV+InoWp9gSpAfpMLx0aYr9B
 KJoKaI3NRUlcvn0BhXejLS/IaQ0IsMN3/Fgy4229RwcpYFqkZQj2pmp81rUUmOfUhT2PzsOpA
 sGcbQJ0/Pit1zh0n6woCw1+zj3g6+J7ikn9ien/T4uyOm0HwNa1Ws8kKzNxTcCuNRn2TF4PBz
 aPOjIq8OE0JKHtITOHrPFvh0nC5CK9q4kDwapXn+4RHYxmKrYakXD4WMfw5FXv5YN6GvkhWf1
 kIoWe9vyAEDSnCxrTpD9bo5Jd0anvpWRQphbFlDvClBHpEols1gIRiHyH+EafTHpdYaHhSIdL
 Rc//ZorjO//KgAzYadQoT34T4fliKdpCXCAD1oIwYWKjaoPxvQZ4UzKJilOz6B1hB1iouL7HH
 uGKowmolJYYcEnI+y9ORygbu8sYO/tlTffNc+OWO7LIsdJFJ9YYBf7PG0dVRQVdQ87LW+ePoE
 tEihPyiwN97dZ8q/Nh6a2tPOYXsCvV65ccbQ61dsmKdP3tgjuEc1Ym01Lp0+VoWsD8j4WGF1S
 N2nr2Tx22z2X+GHA1/AlVjU1hNmg7iNSc7mrTylYnfLC+uYXDqaSh+Rq9MYayP0OCHsRIOWyv
 XcGEV6UzSmT/iU2AyH6kvAGc6s9EJ5PV3uaAxBVP7dUeuOPgaGrrwm5R67bMmC7QUHcBU3yrc
 pG9jjMPJGdwkXMUHs5akL5DrCz81uQLu2Cd+cvSPeGDn8rfiHu1kAdW4+CMh0mFr5lkvWSKbe
 A04Bq0CPK6nRomNZsFdcdVqU08t/G32y6DQrsOxaWZkVQaYpX6dU9Tx4/CSO6f2UDoCzSrYff
 wIFvH/kUrvLT23YguyKMseRec1FwD5aJwRLjZwBYPorhq29WAh97A6+LmQ6VHJXVm6HNDJjQ0
 HN/qDZaMnoI38xPKTWAQoPZTNXAkOWk6dhLWPmtYZcwrLMmR6wdRaA27KvpH7yFnc4GegFFbu
 4X1TMgKcX6ci0hy6TxH70fVbaFLZBuKY+RfaQN3zY3Vm6/z3uobR1oPHyYC5T6LTK6Hvy/Dyz
 Gr1IMg21pwRnivcIwni/hlxCCy/BTCXd6s7CmrmnE5YHIA6Fwu6bXLxsRL6SmW5Rr0isvIaDa
 GG8Srv25uNN/nf1X2nrhrTmWLnKX6cSnYeDKh/cBocFUjNle2Q5tAGMWhX9VIb0hJk9Tv0+Ph
 XFoPMjaJG2w4iw1Y8J+RYeIQACDFH7/4FtZ3W63p1whGybPxfaIqA2biEIpGac18YD3icd67/
 YQyBgHZnBTFqrpqoz8e3OP+dw0vJbrznmV2HRru48UBDeFO8JtsF8iIvRU7kw9+fj4KSuOSg3
 nXPLZVH0LHe9cjI//Xo6Sw55rWl+um6ee5i/QL1t8WVm+5dVJIgQwlv38HSwKujM9c4wYqhXF
 e3jh5e5e6ID0ZENyUNKQJTipky92KW4qaKixpASOZEe7PKEnR8e94CK2ZPjTCF0+jjYnCxgn6
 5647Jtqfv75o0+WdEPHOnn+MTIul4nWGHZh5/wwi2N4vtRofsdI6AsPx6tf6FjFF3S3DqZsqp
 /KymnK/QJsRecChetw9LYVFtkAVI+io4dM810B8s8+tLfd/xaeq1H0Vw5/TqojrxNF7NFiGZI
 B29xGsBsLD/hdzVHqa7Z5jrcho0RUObTFvR2BiJdeYp2CG4ePnMNveuE8ctWwjOZBkqhwl/P8
 f7xvhgleCvNnEGcNxGkSpfXJ31S821IO7taGqJKWSdLwwX2zYQhkBxSauQkFWmA9qE3JJGoRf
 AWek49hfEj8xmFqG6LknSg5TbVGfQJ+PAhcN32u3JJOMh6Dpi8doaRN10uPET18DGuc5bQ/fe
 BnPF35klRIvxwGUGPUmSHr/SlKbqViZ6MJn53TfODSA7t4QGXiZWdnc8eTzmjFPdWBa1GVp6S
 jW5Zb65yOOT1cmDa7wn5nKWhaoXhgTHM+O94NuIiiOGdUTkRAIkQecqy9VWJUGvOXyGdbtsnj
 QEhoRMW3lstHyj2cVvnVjNLZMmXC85iEmZ4jcqkr/kDwd8w8LeHh+f2sBtBwv1MJc6rWoMVTx
 rB1zCRGuoFIyBI3UEonYZ8dCkglLRxAul2S8/oOz7oEuyo1mNLUeNpY4vBie/0/uKzv73bDZA
 52z+gHrOKAq4jiea7L1haWkdX3PCNsRVaQ2LMC6p7sYjbk7z2/Pjt30tlFFAz/RGj8FUbESTJ
 g/EDAfOkPkdzERGmruIpfypST8iw6EOWC2IdtRGFdn8uJ/7SCfURQKoPYMi/J3we9XQRBNS3w
 knw/Fk50gUPWerFH/kWqIEjn0hBVd9ms7q8TvYpeluQ6ZCv1LG10AHslvXb8h7QpXKhKuRR74
 luKUYPTawtrZ/p4mDdmnJmjggUv8oZu9zeyPP26yU2jJcC9USlqTP8BT9/oJp4Iboe+Htk38O
 oa/KAoKGVYCAM+dHRnOU/Zmgp7ZQ8mKXUOuT+HxMnn8fMGVYnVkHCssxO9i0EhOh9eyUNyLBL
 lehN4AAoQJ8jynFipqDYuIOclo=
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

Am 26=2E Oktober 2025 20:07:28 MEZ schrieb E Shattow <e@freeshell=2Ede>:
>Hi Heinrich, thanks for the review=2E
>
>On 10/26/25 02:56, Heinrich Schuchardt wrote:
>> On 10/24/25 09:33, E Shattow wrote:
>>> Updates to the JH7110 common descripton:
>>> - add detailed overview of JH-7110 SoC and boot process
>>> - drop descriptions of deprecated StarFive loader modes
>>> - refresh build directions grouped with SPL debug advice
>>> - reduce usage instructions into common methods shared by supported
>>> boards
>>>
>>> Redundant/deprecated sections of each board doc are dropped accordingl=
y:
>>> - deepcomputing fml13v01
>>> - milk-v mars
>>> - pine64 star64 (also add inclusion of JH7110 common description)
>>> - visionfive2
>>>
>>> Signed-off-by: E Shattow <e@freeshell=2Ede>
>>> ---
>>> Preface to reviewers: SD Card / eMMC modes are officially deprecated i=
n
>>> the published StarFive JH-7110 Technical Reference Manual=2E The reque=
st
>>> for supporting documentation was not answered in the upstream review
>>=20
>> The boot ROM was not changed=2E Ubuntu preinstalled images boot fine wi=
th
>> U-Boot on SD-card=2E Booting from eMMC works fine too with a bit of
>> patching of the first partition=2E
>>=20
>> It is unfortunate that StarFive is not inclined to document how booting
>> from eMMC or SD-card works but this does not mean that it is irrelevant
>> to U-Boot users and developers=2E
>>=20
>> Please, keep the existing information=2E
>>=20
>
>There is opportunity to do the work ourselves if we choose to[1] do or
>otherwise I'm not convinced this information can stay=2E I will expand on
>this, below=2E
>
>>> process and accordingly was rejected from the upstream process=2E This=
 does
>>> not function anymore in U-Boot SPL to be loaded by BootROM with the
>>> [RGPIO1:RGPIO0]=3D1 and [RGPIO1:RGPIO0]=3D2 configurations=2E Use of S=
D Card /
>>> eMMC within U-Boot Main is not affected and functions normally=2E Asid=
e,
>>> the
>>> effort is begun to reverse-engineer the BootROM and gain an understand=
ing
>>> about what we would be supporting; for example the specific circumstan=
ce
>>> of the XMODEM too-man-NAK bug in StarFive loader code, or introducing =
a
>>> patch upstream to accommodate users that continue using deprecated mod=
es=2E
>>> Meanwhile the documentation needs to be updated to reflect what is tru=
e
>>> and verifiable now=2E
>>>
>>> The support enabled in starfive_visionfive2_defconfig for many methods=
 of
>>> data transfer is well-documented elsewhere and does not vary enough to=
 be
>>> repeated in the JH-7110 common description or that of the supported bo=
ard
>>> documents=2E This will be deserving of a brief mention in a future upd=
ate
>>> so that users may easily ref link to the enabled methods in sections
>>> where
>>> they are documented=2E It is not clear if this will belong in the comm=
on
>>> description or per-board so it is omitted here=2E
>>>
>>> There's some plainly wrong information remaining for the supported boa=
rds
>>> also deserving of correction in a future update=2E
>>>
>>> -E
>>> ---
>>> =C2=A0 doc/board/starfive/deepcomputing_fml13v01=2Erst |=C2=A0 32 -
>>> =C2=A0 doc/board/starfive/jh7110_common=2Erst=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 597 +++++++++++++++---
>>> =C2=A0 doc/board/starfive/milk-v_mars=2Erst=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 73 ---
>>> =C2=A0 doc/board/starfive/pine64_star64=2Erst=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 77 +--
>>> =C2=A0 doc/board/starfive/visionfive2=2Erst=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 449 -------------
>>> =C2=A0 5 files changed, 511 insertions(+), 717 deletions(-)
>>>
>>> diff --git a/doc/board/starfive/deepcomputing_fml13v01=2Erst b/doc/
>>> board/starfive/deepcomputing_fml13v01=2Erst
>>> index 5d9612483b4=2E=2E9777f4c6303 100644
>>> --- a/doc/board/starfive/deepcomputing_fml13v01=2Erst
>>> +++ b/doc/board/starfive/deepcomputing_fml13v01=2Erst
>>> @@ -9,38 +9,6 @@ The DeepComputing Framework motherboard (FLM13V01)
>>> can be combined with a
>>> =C2=A0 U-Boot for the board uses the same binaries as the VisionFive 2=
 board=2E
>>> =C2=A0 Currently only serial console output is supported by mainline U=
-Boot=2E
>>> =C2=A0 -Building
>>> ---------
>>> -
>>> -Setup the cross compilation environment variable:
>=2E=2E=2Esnip=2E=2E=2E
>>> +Zero Stage BootLoader
>>> +^^^^^^^^^^^^^^^^^^^^^
>>> +
>>> +JH-7110 ZSBL is typically StarFive loader code in BootROM selected by
>>> RGPIO2
>>> +pull-down=2E
>>> +
>>> +=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>>> +RGPIO1 RGPIO0 StarFive loader function @ 0x2A00_0000
>>> +=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>>> +0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1-bit=
 QSPI Flash offset 0x0
>>> +0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SDIO3=
=2E0 *(deprecated)*
>>> +1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eMMC5=
=2E0 *(deprecated)*
>>=20
>> I think we should replace "deprecated" by "not recommended by StarFive"=
=2E
>
>The deprecated loader functions are not reliable and new designs
>substitute transistor logic that omits these modes=2E I did consider some
>alternative word choices and "deprecated" gets the point across quickly=
=2E>
>>> +1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 UART =
Serial XMODEM loader
>>> +=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>>> +
>>> +StarFive loader code is assumed to copy content to SRAM @ 0x0800_0000
>>> and test
>>> +for StarFive SPL header followed by a jump to SRAM=2E
>>=20
>> "is assumed" means what here? Is it "We don't know?" or "It is the
>> BootROM's duty"? Please, provide an unambiguous description=2E
>>=20
>I agree, I don't like this word choice "is assumed", with the meaning of
>"We don't know?"
>
>Do you know what BootROM code does ? I think it looks like it does at
>least what is described here, but there is some OTP and checksum action
>that I don't understand myself=2E
>
>What do you suggest to say here?
>
>>> +
>>> +First Stage BootLoader
>>> +^^^^^^^^^^^^^^^^^^^^^^
>>> +
>=2E=2E=2Esnip=2E=2E=2E
>>> -
>>> -Booting from SD-Card
>>> ---------------------
>>> -
>>> -The device boot ROM loads U-Boot SPL (u-boot-spl=2Ebin=2Enormal=2Eout=
) from
>>> the
>>> -partition with type GUID 2E54B353-1271-4842-806F-E436D6AF6985=2E You
>>> are free
>>> -to choose any partition number=2E
>>> -
>>> -With the default configuration U-Boot SPL loads the U-Boot FIT image
>>> -(u-boot=2Eitb) from partition 2
>>> (CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=3D0x2)=2E
>>> -When formatting it is recommended to use GUID
>>> -BC13C2FF-59E6-4262-A352-B275FD6F7172 for this partition=2E
>>> -
>>> -Booting from eMMC
>>> ------------------
>>> -
>>> -The device boot ROM tries to load U-Boot SPL (u-boot-
>>> spl=2Ebin=2Enormal=2Eout) from
>>> -sector 0 of the eMMC's main hardware partition=2E But this conflicts
>>> with GPT
>>> -partitioning=2E Fortunately eMMC can alternatively load U-Boot SPL fr=
om
>>> a backup
>>> -position=2E
>>> -
>>> -For U-Boot SPL (u-boot-spl=2Ebin=2Enormal=2Eout) starting at sector 2=
048
>>> (position
>>> -0x100000) write the following bytes to the eMMC device after GPT
>>> partitioning:
>>> -
>>> -=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> -Address Bytes
>>> -=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> -0x0000=C2=A0 40 02 00 00=C2=A0 00 00 10 00
>>> -0x0290=C2=A0 40 02 00 00=C2=A0 00 00 10 00
>>> -=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20
>> Please, don't drop this information about booting from eMMC=2E
>>=20
>> Best regards
>>=20
>> Heinrich
>>=20
>
>If you have a code listing for BootROM instead which details these
>address and byte references then I will be excited to learn more and
>expand on our description with citations=2E
>
>I do not, however, wish to continue with this booting from eMMC
>information as it is=2E No matter how much time we both have sunk trying
>to compare vendor BSP OS images, etc=2E:
>
>- it is not a feature that is supported today in U-Boot SPL
>
>- suggestion violates GUID Partition Table published standard
>
>- what I do understand now about JH-7110 BootROM[1] is I have no
>confidence in this information anymore about StarFive loader booting
>U-Boot SPL from SD Card / eMMC
>
>At our discretion we may contribute to this public document[1] and there
>will be no hesitation from me to introduce - on the basis of verifiable
>fact - upstream support and summary here for **what the immutable
>StarFive loader in JH-7110 SoC is doing**=2E Going the other way around
>looking at vendor BSP OS images is not acceptable to me after having
>sunk multiple days into that effort and discussing with you briefly in
>the past, there are too many unknowns and unexplained errors and the
>result violates actually published standards=2E
>
>1: https://codeberg=2Eorg/hrv/jhre
>
>=2E=2E=2E snip
>
>-E

Hello Hal and Minda,

Could you, please , chime in=2E As board maintainers and working for StarF=
ive I would like to hear your view=2E

Best regards

Heinrich


