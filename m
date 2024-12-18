Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30675E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 19:24:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8FF18021D;
	Wed, 18 Dec 2024 20:24:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=writeme.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=writeme.com header.i=sinan@writeme.com header.b="Uy2bexG6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E79BC80291; Wed, 18 Dec 2024 20:24:19 +0100 (CET)
Received: from mout.gmx.com (mout.gmx.com [74.208.4.201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 638F78021A
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 20:24:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=writeme.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sinan@writeme.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=writeme.com;
 s=s1089575; t=1734549853; x=1735154653; i=sinan@writeme.com;
 bh=Y+PxXSeAMAxU+77NzgVX3MhvG3tJBjKfQNttEzaHddo=;
 h=X-UI-Sender-Class:Content-Type:Message-ID:Date:MIME-Version:
 Subject:To:Cc:References:From:In-Reply-To:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Uy2bexG6GR8ATsv6FdPa8hYTmFg+xSc1a1A0HovrlrfoxyvLPaRTCfeykUiixT7i
 JxQfaxt1AdzyjYQvmL8p28SQqQbokhdAHCb5Mtfz2YpvTLcCK4daYfHwnw3tnF2zu
 Jhxgye08hSG0UD5BLFhJLrox/2axZ9KGROuVGaIGaTMzRw7TBaGQ9QghfGPfaF+id
 JHzEcd+PpV+EyhP5AyAG78/0xw79sZbw59maL0uZe7HKsrc7CJ+Nu0H6WXgOLu4Nz
 LmPweFgMRVfsq9gElqoiOBW6Rzt9PuZE+E/vHgez2oQTSnyqkUXol2rw8LFytsfvB
 23zWoFhtzGMt/muHRA==
X-UI-Sender-Class: f2cb72be-343f-493d-8ec3-b1efb8d6185a
Received: from [192.168.4.12] ([208.111.77.233]) by smtp.mail.com (mrgmxus004
 [74.208.5.15]) with ESMTPSA (Nemesis) id 0LqSBz-1u1TCP3knJ-00pabh;
 Wed, 18 Dec 2024 20:24:13 +0100
Message-ID: <9b5879fe-878f-46ff-a141-083a8fcf3147@writeme.com>
Date: Wed, 18 Dec 2024 14:24:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] powerpc: mpc83xx: Fix timer value calculation
To: j.ne@posteo.net, Mario Six <mario.six@gdsys.cc>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241215-mpc83xx-misc-v1-0-8cd6daae4f93@posteo.net>
 <20241215-mpc83xx-misc-v1-1-8cd6daae4f93@posteo.net>
Content-Language: en-US
From: Sinan Akman <sinan@writeme.com>
In-Reply-To: <20241215-mpc83xx-misc-v1-1-8cd6daae4f93@posteo.net>
X-Provags-ID: V03:K1:Nvtz0tkiBDSppyiGrGFj/kCnRVtoUKWW8QdvlsC/F5uUjzhz48m
 efsQhrb7J8KNolbolE1CMhLr+U957bgRNEM+bXsHJG4i87AK1nnxX5U4yRiN5qBBwPEezbk
 sBYMNUMmjzkJ/D1bXa9HTZhYgDUM+gvAFwR7n9/sJurP3wJSvYnLmEAEmn/seHaGeAPShAH
 l1UYcIuwYf2hnaQ3dNklA==
UI-OutboundReport: notjunk:1;M01:P0:46sYnt2Je/g=;uHiUqll7+85AOCHDKxPGr79OrHB
 R/fbsIUi4x8Mht7P//xH4iMp7qrT8TbrDNZo233jb1SqX1PpOUw/0b/Dzij2Pw7LeZfRWwfTm
 ZSRGkgNnn6jO978aLshRnjQwa571gZfE5vAPXtiW5Cf/cxdcK3I7kWlOK/AjElBy7zl+kAt4g
 ipQ4KeaXX51uxOIHsaqKtom0XDZMshuLZVlyOO7ue8oeT2asiP/TmZV4fXxmjzIlifI7gOM1Q
 mPefVO6b2UEhGsiMEpnJ87VCRyINKLdfLn9WLiG29yLAJdn9ufWAqsH2C8SAYolXMQ+CDdSZh
 LXszsQbD5K7TeDz/dTYI9gkJ71DeDnWdHNmI6zKg9SlqkY80tY5tYKQ1G4Kd5P1wJ2QbikNJV
 yXzJlAo2dM1vDkJ0WwyQnt/CCU6jdQWIrNcY2tQn/EF10/JBdCqif7gYszVTPDZmDpRlvL2YN
 0SONShyir+sBaiARX3iAt/oQFVY0zCVnPYmib7v002+SKSpVEqOsExqOvE8lk7gno+qKszRX1
 jY7G2KRZZGK/9jdKg028NB9KBfvVW0FAYV9JqQTAZ6F8WLD72dkuUxMoux+y76YC8mO87z1et
 BWKXeKKMNK7ndbgBeaU3wlUhlvJ2DkM85Gd1Uka2nttGdn1KcDOwUP8JISJ1M2kNtILSeKqPK
 jGk7VSH8zI5DmBLOiZNLksI6ddQK20Na40Smsm8zp8IxlJ1skU6V4M1qgLQIAyNQqeAfdHr6H
 KQnyeaHRibglLO9nHnilM5FrMuU2np+ofjMd+da+5ugbBdTz7i6Zw5XasS/7DA8KmKDm0tuTG
 7OrCTjumcXnTJpwBYW6yaLB7cJXZYrqUd6r+CSJsWiYTqo8uul96gATdbpcXBkZ+N5nOHkDlx
 FIkaWvetYFm25NFWOWP01wNkhKbpFm6BgRGKVyFexHQ87o4n6JREWUh1lbG/praS/ovYpvU4H
 Olt4sOacDLu2QFAm1fgy9EJhTOII5XuSnirwCMAIytIDMvjMDal6jIQhJD8erb+731fOJHUot
 RV84jWN/AiCPmpi5MDBLJi6OlWT5KOPr3MeQYEMR551rKktzasnHc3/SWFXlmvkUcnyGoQWpH
 7wyfAGZibBUMrbS2fd94T89398YzZywPQTP+hR4WOhXnhxB/gTIdyiSq2mxu5vQitfxO7Bm2U
 =
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 2024-12-15 10:18, J. Neusch=C3=A4fer via B4 Relay wrote:
> From: "J. Neusch=C3=A4fer"<j.ne@posteo.net>
>
> TBU and TBL are specified as two 32-bit registers that form a 64-bit
> value, but the calculation only shifted TBU by 16 bits.
>
> Fix this by actually shifting 32 bits.
>
> Signed-off-by: J. Neusch=C3=A4fer<j.ne@posteo.net>
> ---
>   drivers/timer/mpc83xx_timer.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/timer/mpc83xx_timer.c b/drivers/timer/mpc83xx_timer=
.c
> index 9da74479aaa678bfab861950a770b216b604c433..f92009e4ccc8256d4c5f4d11=
e414dfc141f5a043 100644
> --- a/drivers/timer/mpc83xx_timer.c
> +++ b/drivers/timer/mpc83xx_timer.c
> @@ -206,7 +206,7 @@ static u64 mpc83xx_timer_get_count(struct udevice *d=
ev)
>   		tbl =3D mftb();
>   	} while (tbu !=3D mftbu());
>
> -	return (tbu * 0x10000ULL) + tbl;
> +	return (uint64_t)tbu << 32 | tbl;
>   }
>
>   static int mpc83xx_timer_probe(struct udevice *dev)
>

Reviewed-by: Sinan Akman <sinan@writeme.com>
