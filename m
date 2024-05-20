Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05306C04FFE
	for <u-boot@archiver.kernel.org>; Mon, 20 May 2024 13:33:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0357886C3;
	Mon, 20 May 2024 15:33:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=fancydomain.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=fancydomain.eu header.i=@fancydomain.eu header.b="knyl6Y+w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1998C8869E; Mon, 20 May 2024 12:43:56 +0200 (CEST)
Received: from mx.walter.deinstapel.de (mx.walter.deinstapel.de
 [IPv6:2a01:584:9::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0191A88020
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 12:43:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=fancydomain.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jasper@fancydomain.eu
Date: Mon, 20 May 2024 12:43:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fancydomain.eu;
 s=mail; t=1716201833;
 bh=+AC9Y2LOxcTLckcZxk1l705p2cQ2JAfi7x9GNYdm0Ns=;
 h=From:To:CC:Subject:In-Reply-To:References;
 b=knyl6Y+w+wHN0ubKIJPcclWrrAAWSiJgyCaIewZc17NWqtvWdknudxfVubyERJjuf
 3M9+ITiBjmbWGX4VOIzIuxk5JoSchwMtdu6qqcwuVFSqZ6lM7qj0XBqbV+61lZcSjn
 1DMDJe4a9HbiirzrpLlFDyr6ai/I9QjqBdKQMOWunqarkN0v6P8N5E8J+jvz6sHR/u
 8xrthenucRr023l40OBsNyfoK2N6HQFad1pABXSIl7LpK03np0XxefI2T5LRpgt2M8
 x4TWUoK6I9P2Vw/68/mpYINATpWsVTPwv+sOQfGTz0HkfixmwWDlWsuYC0MJJm9Prq
 HKgkLIdYBjrjQ==
From: Jasper Orschulko <jasper@fancydomain.eu>
To: Tom Rini <trini@konsulko.com>
CC: u-boot@lists.denx.de, joe.hershberger@ni.com,
 Michael Glembotzki <Michael.Glembotzki@iris-sensing.com>
Subject: Re: [PATCH] env: Invert gd->env_valid for env_mmc_save
In-Reply-To: <20240517185144.GM2568172@bill-the-cat>
References: <20240510113834.826783-1-jasper@fancydomain.eu>
 <20240517185144.GM2568172@bill-the-cat>
Message-ID: <4EDE5074-4AE2-4FFA-A713-9A9060232836@fancydomain.eu>
Mime-Version: 1.0
X-Mailman-Approved-At: Mon, 20 May 2024 15:33:14 +0200
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Tom,

you are right=2E If this patch is to be merged, we should change all the o=
ccurrences=2E That was an oversight on my part, sorry about that=2E I'll se=
nd an updated patch to the mailing list later this week=2E

My colleague Michael can give more technical background on this than I can=
, so I'll let him do explaining here ;)

Best,
Jasper

On 17 May 2024 20:51:44 CEST, Tom Rini <trini@konsulko=2Ecom> wrote:
>On Fri, May 10, 2024 at 01:38:34PM +0200, jasper@fancydomain=2Eeu wrote:
>
>> From: Jasper Orschulko <jasper@fancydomain=2Eeu>
>>=20
>> The A/B update strategy of the env's has a gap in the first 2 calls of =
saveenv=2E
>> The env's are stored twice on the first memory area if:
>> gd->env_valid =3D=3D ENV_INVALID=2E
>>=20
>> u-boot=3D> saveenv
>> Saving Environment to MMC=2E=2E=2E Writing to MMC(1)=2E=2E=2E OK
>> u-boot=3D> saveenv
>> Saving Environment to MMC=2E=2E=2E Writing to MMC(1)=2E=2E=2E OK  <-- !=
!!
>> u-boot=3D> saveenv
>> Saving Environment to MMC=2E=2E=2E Writing to redundant MMC(1)=2E=2E=2E=
 OK
>> u-boot=3D> saveenv
>> Saving Environment to MMC=2E=2E=2E Writing to MMC(1)=2E=2E=2E OK
>>=20
>> Signed-off-by: Michael Glembotzki <Michael=2EGlembotzki@iris-sensing=2E=
com>
>> Signed-off-by: Jasper Orschulko <jasper@fancydomain=2Eeu>
>> ---
>>  env/mmc=2Ec | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/env/mmc=2Ec b/env/mmc=2Ec
>> index 7afb733e890=2E=2E2bef30c973c 100644
>> --- a/env/mmc=2Ec
>> +++ b/env/mmc=2Ec
>> @@ -299,7 +299,7 @@ static int env_mmc_save(void)
>>  	ret =3D 0;
>> =20
>>  	if (IS_ENABLED(CONFIG_SYS_REDUNDAND_ENVIRONMENT))
>> -		gd->env_valid =3D gd->env_valid =3D=3D ENV_REDUND ? ENV_VALID : ENV_=
REDUND;
>> +		gd->env_valid =3D gd->env_valid =3D=3D ENV_VALID ? ENV_REDUND : ENV_=
VALID;
>> =20
>>  fini:
>>  	fini_mmc_for_env(mmc);
>
>Can you please explain a little more on how you get to this problem? The
>same code / test exists in env/fat=2Ec, env/sf=2Ec and env/ubi=2Ec=2E In =
the
>case of env/mmc=2Ec it's been that way since introduction in:
>commit d196bd880347373237d73e0d115b4d51c68cf2ad
>Author: Michael Heimpold <mhei@heimpold=2Ede>
>Date:   Wed Apr 10 10:36:19 2013 +0000
>
>    env_mmc: add support for redundant environment
>   =20
>    This patch add support for storing the environment redundant on
>    mmc devices=2E Substantially it re-uses the logic from the NAND imple=
mentation,
>    that means using an incremental counter for marking newer data=2E
>   =20
>    Signed-off-by: Michael Heimpold <mhei@heimpold=2Ede>
>
>as well=2E Thanks!
>
>--=20
>Tom
