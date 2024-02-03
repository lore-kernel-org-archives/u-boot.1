Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F606C4828D
	for <u-boot@archiver.kernel.org>; Sat,  3 Feb 2024 06:56:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A981880D1;
	Sat,  3 Feb 2024 07:56:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="QqT81lAw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33364880D2; Sat,  3 Feb 2024 07:55:59 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36210880C9
 for <u-boot@lists.denx.de>; Sat,  3 Feb 2024 07:55:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1706943353; x=1707548153; i=xypron.glpk@gmx.de;
 bh=ekJ7LhaWSRkzKpczBS1Rt3IVVIjfDKDkUsAH5s+xi/M=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=QqT81lAwvavaDN26gBWTGN5x4wivYLEMfk4tSFRJhjvEhQXV9iFY8wh6XiiR69YR
 jDXbKV24mpBvCrAsR9ofChdeyAdpd5T1xZWD6NgGY5QVrlrvdds/Ma34/Jk9JP49H
 FMWo3aoTguP/YcWlTIjeUZnhBiLezCiitwwxUqWcjVhxgPVdHs/fbNOrTZ1COwO6K
 tTx11Bn2yjxMOSFTU23YnpqTGTDpsnurGBcSCGDr+r3Ureq5q5PmJU/EHs3ysRaey
 j7ufHeuE3qjmA8cC40W2qq/jlByg2eW6urt+Yfobkuqxrf5fteGErs11is2XvzDp+
 AmiGk+URwvTb8h0+eA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MwQTF-1rCyzs2iwP-00sQee; Sat, 03
 Feb 2024 07:55:53 +0100
Message-ID: <eea108f1-8cc7-486e-b324-4b0cf031be06@gmx.de>
Date: Sat, 3 Feb 2024 07:55:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test: cmd: mbr: Fix Smatch static checker warning
To: Alexander Gendin <agendin@matrox.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Dan Carpenter <dan.carpenter@linaro.org>
References: <Zb2rU_JCEkRionLj@alg-gentoo>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <Zb2rU_JCEkRionLj@alg-gentoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fT54PVmseeNkVqZR0F2IoY6bDRTiuvIz2/Gg1QxF+8gY26UscUA
 eni8wM4wQ2Jbi+zVWZWEb/5ff5i3IQJrZ/d6lvVCQXQTcs8ejH3vtztpYTylXyRzfKbXne+
 zPmkEte2+4qAmWnvxYtaYvjhhx3dO9cL3yKS5QG8I6GU06UqTBU/76OWnTm3ApmhT8rm42d
 hnMl2WiRo4CGzLA6n8ICg==
UI-OutboundReport: notjunk:1;M01:P0:6BftEvslLu8=;RqeoevxSEx5aSFeGmMreLt50G7/
 ZXNjdoMgpo1IWQuqizB0TaUOOgzVqYzI/zEk1bR+ggAiIyNgvgHX8Ctqttflkmfc7sI/cylB8
 6nWvTGpgsEP1ZWCb49Q4OgJbrGcuogBdoJmYPCeNu4oILX5Y0Nu1V1dGJMV5/R8KYBxuBFXUN
 848Dg3mk0vG4qTgF2tVqq2BhbNw7GQwP2JUUbwdZwpr30H3Lc2PdwWIseAJEZOm4NIKhLZGu4
 ORVh+rO9JLWYgaKmZkXDXRd7toESPGN4c1QPfx+g3UkyTI9bDUq00+2B6auclakKul2iX1rmj
 Bruep/A31luWFphYNLN+bLeNHfi58Uxydo9wHXJSwR/szAbtaLDBjJNUOnE2A6Oz7PjKsUT2+
 R1e7IJqdoMfV6pgaip3lUYrNaC3e4gtoInn3TjyZsjWR98wB2VWrOq9KYFk5tc3Bt9NIoHrJS
 LbhrymTIIuxkyoPTiNKbHcP7K+Qtqlkt35PMl5Caxje64vMmZwXFRpd6JLzW6gd26FOE3xbSj
 h9ktPsyrNSJzfxu3egAFYLlmkfrHFAJYnMNGjEjEFg4mo6NL2LIxrHGurbEk3G4F0mm2Exjde
 +KCVnQ8prpWAOgD0rqaBKq46vSeh02jRCxoOYZiajvzuzRxPeDiA9irS+/LSLmM9UO8/Q8pzD
 HxrlChHOvn5NL8uBEQoz9QY4AIHzJsUtUsDyxPkzcV3cgBH2MmJewlllnfibOo25OXf36G5uh
 UllOD2xx0GeezevBwNaUjgIwVXC0UT5PQRqQy0EHBJXa+l/C9utsfcsOGV/YEk38qrWpAdsU2
 DjP3lFmJhF83hcjorYCn39r7BMvcCLQqBBtBnpH8t21Bg=
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

On 2/3/24 03:56, Alexander Gendin wrote:
> This patch fixes Smatch static checker warning:
>          test/cmd/mbr.c:243 mbr_test_run()
>          warn: sizeof(NUMBER)?
>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Alexander Gendin <agendin@matrox.com>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   test/cmd/mbr.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/test/cmd/mbr.c b/test/cmd/mbr.c
> index 46b78e706c..235b363290 100644
> --- a/test/cmd/mbr.c
> +++ b/test/cmd/mbr.c
> @@ -240,7 +240,11 @@ static int mbr_test_run(struct unit_test_state *uts=
)
>   	ut_assert(ofnode_valid(node));
>   	ut_assertok(lists_bind_fdt(gd->dm_root, node, &dev, NULL, false));
>
> -	mbr_parts_max =3D sizeof('\0') + 2 +
> +	/*
> +	 * 1 byte for null character
> +	 * 2 reserved bytes
> +	 */
> +	mbr_parts_max =3D 1 + 2 +
>   		strlen(mbr_parts_header) +
>   		strlen(mbr_parts_p1) +
>   		strlen(mbr_parts_p2) +

