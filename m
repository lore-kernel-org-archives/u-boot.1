Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3AE6C43458
	for <u-boot@archiver.kernel.org>; Sun, 12 Jul 2026 05:50:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27EE98467B;
	Sun, 12 Jul 2026 07:50:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="a6jI/rDL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB0BB848A1; Sun, 12 Jul 2026 07:50:47 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD471844F6
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 07:50:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1783835444; x=1784440244; i=xypron.glpk@gmx.de;
 bh=jwRyY1FDgP/jItqkYU7Tpc6KmuqmoDYT+L5DLhbNrDk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=a6jI/rDLViVhgR3F4sk4oqvMIE/VF2E0RbC8cYJobdPW3bC4E0myRpmcx7zS2AvD
 DasA4DMHeQ5BiRCFrpuO6aacc2uLql5HF1pNI2cCKKokhKT/tiYF77HiXFrQTg8XP
 fXAuf1zNrV4dn392Mgq0V0oD2leQWDrMbMcaOW1jSjZ/i3JlD4DjJFJ/JOrw5Zrpg
 64eabVGJ/XB+1ef3bMbnZobBrPS4Zzbg5PX2NXKrUy7/XYTtHUWQe0TOfWT42XFA0
 XvGmatrWhcMDny2aq/4o1CapHgKa1v0xs3kbiUZm4+dmW6V+6awx/eE26Ob8bs8oF
 nhy8+/ZIE3pOWKHu/A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mj8mb-1xEZWw41Vl-00bwGu; Sun, 12
 Jul 2026 07:50:44 +0200
Message-ID: <adc8133d-c3ac-42ab-80db-0d1d7f134f0a@gmx.de>
Date: Sun, 12 Jul 2026 07:50:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] efi_selftest: free handles on teardown()
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260626-rev-v3-0-12a0c0fc0965@arm.com>
 <20260626-rev-v3-1-12a0c0fc0965@arm.com>
 <056cc92b-4c2f-417e-a48c-f15aa9786328@gmx.de>
Content-Language: en-US
In-Reply-To: <056cc92b-4c2f-417e-a48c-f15aa9786328@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XRJc1Dd+Q92Hd8qKGEfHqbJOjkSCb/yJ8d0weoPQ1JH+JVVjSSh
 plfwRCJCcfSqQxD8yCr3EFEKKeItjhiqB76vsH6FqozohyEDu8sAlYfU1gr3HoSQD9HLn8k
 cKuIwIv3aUVQ81qG0VNoWhp443bvCXagY1NUQcWendTtmT1gldWo1XSm862as1EiIBeYMA9
 8sbo738U5Iy68eUMjse1A==
UI-OutboundReport: notjunk:1;M01:P0:CwDnuHcfG0k=;09QHSPpCai9AhEP2Yq0OJbZy72M
 JG19zArr6QuYn6zOFdvGhdkNH7H2RYkLribLCti0bmSAx6h5dcSvB6P37+ccfEjiSrPL61Xzs
 7bqOprtHH4zzqYB8M8ZcGF9a6MQRQL15232O72hHyrhFOCUNOFjD6VeXGBoIuiSF3UtCHsVqV
 uhWd7ZLTL3UGuD9lEEGS/4ILwYnDKbdBOEFS4HFhsKUsx1vNGh/QXeNatIiWK2Z0slb6dJIhE
 uhYt1mf/nw2Eqs4JGFVBEa7CQq4jr4eY9CYBCHJ5hJv4UkxuK6WG/Hj/yx0EWSJyNAZkHPu7s
 eglB4CyTfWQSqmFjIuX8n4j1y8Ithq9TTW8Cz/zf589IcLc/mukh75zkPlvkKFz38tJbmHnDN
 F26zj5lbz50H9AP8okksRpdDuW03apvEj3M5liYSoMB4W7183b2ireB3XQ8r0hLvhQHwD4A4G
 kapcjybZvKkoMubcK5ViCGWJHCojnu1K+wQzNxbWrcBN1ZUBLm/TRpDUMqC1E+roX4fUJPJkZ
 RtSg4oq7der+sBccgHCwiOGBAR8w8ds9gHllxe6L1Wd0Kx2OERr5AuhRT+Au6dqlC6ZAFc+xC
 vlkpLTmqukTVTI4c4VbQfSUy9xngx75+xB1DIdvQUrMBdgJcYxs9O2MLK48qwGWlvdujy9cgH
 LHef8rjkd6zheXHyuMUcdIedshFB0wq5ydUrvTim9K5PBZEqjNRd9j8AeCbYqD40pRvo6VINk
 jGhtkQY7040d3bnGPd79QUgWnK2Q3kVHURjjD0vZj7cbfs9cru095qX/Pb/W9KMpbnj/BPv4X
 fxJhEFp0r7pInK59U4wkkBihdKKZDx8Mi0yalcBG7F8Mxgxx+TDwvDvLesKFTt0bOn8O4jGZn
 g+JGljI1Tdd8gJAMtKthLq8Y8T6fDaqcVn4mxWEfguRr1iAnlNELuwNS1BPIlhAVmGQrsehFq
 6xvUGsyCauNiZX+qlEVKzM5jebJB8HPF0MxYzNbaLASFjGmkz1PI8LK3VPVI1oy4tRYCeBWPH
 pYeixYIn4XwRrQYvyLQDTPuVQf/dJTw0hYi4ExGOrmNMWDNrHk7IZi40tJBLVPBpBX+kEuMw4
 9VqxB9KsVPNybPtK7aSJP36AE9oVnvUwEgioipd8rmsSpxGJtJxtCzr5tMe4yGhrbUX1QjB3k
 oGEHpM8oHj0gnfIj/Kby6e2PsuD0LKk5xEKFXw+5aSaGDW83lwkcWjSOdd37WKQ5Fb588yWGF
 3vSKdfZrccHMI9upCEYwnGwCtihtV8MnKQl3j4NbfFYP8lozSxdP0BGOXzyHjGlutQDxng8Qd
 8TIzYSHvbouZinhd0BM8FI71QvU4wcxWc8Zq3619hh1H+8+oh9dU6IQML7q4J6BBKMrO9gHmt
 hwi+K7DhmYXuw4NJyhRMsKDngs1HyuEVpWBUYxvej+sFWA5W7iJjzFNblDezcIlSI4irmURGV
 WdizhLMJs/lOhw4cYMhPlCyaLAonuQO+fM219FFZrMWJHYMUZ4mpZAiJSQcQgctLXNIsKO2Kq
 jH22BrZ1fn/4Z1ALZoUUVmiX+AKhRBYYErbOlMfkv8+1Hg3YXx5xJWCEBx8maqrXPGWkUzb+O
 kWOna7Fy07loYV2soN1EFqD1xO363wn7+saVGdpyLK3y10iKG5/dMc1ZXmotLEho7OCKPgPzc
 4e7m3M7jnNzSLvcEf13zxRvqqkIZbIUka3oFomH29jpIeCNak7xXyII34L6MLsxRX1/KYvfa1
 W1RlwwCeLxHWIdrao9j4rF0s5sJviI/Yo0zPvxYkeCq9S+eCembOLzL1mPMbz7TIAfnwEIurC
 K1ndn7bCL4AFuzLff9lKTANFgL1L6QVaf9LpmRxWzJ/gBhS16Wv5Z73vIxs9fCwp4lA9FBOWQ
 HHQenMLohSLZ+lUvbv/SrAPUmB4+Hfimli1xLlfen8TkTtDnATY/7dfusl7/GWyezhXBaKGE3
 hVHwj5s3ghTIZ6W/uThrmfl+ku+lnF4xr1kpS2LXqPIhCapLo3VIPUH97hzMERJh9h+c1Zg7B
 caE9tFxYvOY273/EQxsrXohlUwAqsgb+OGiAD/RtxhV8IRJARjd8vECfzTeUhKX6xs3tthSrY
 miz/zSeovkiJ6wEarxoHaV/Hh9ayl2OzVWQ0CGQbEYDw2uu9rE3d1nIefpcYSSdhYX7cNFYFr
 H31HXdLL1IYeek1Rks7+C5D6PrbEDlodJw+JOfB2hcCowxdoQWc5Z3t5Z6jIrZBrTihdFWqiq
 PUQt+bBj6s5MosWsvfC7dlrzNzVqHN+PuL6056xjFKcaHb7yfIBwuSA0dBE2ec5cmo2T1BFhX
 5wDv3yAvO4W88KvifPrQNMORIAJ/wosWc0DL5OkDgCMnvClSWTL0w6Ps36LaXrNHWI7+HIoR6
 RUbQtbdLxD3vXX7kBQTSN60hG6GqQ12cs0hdz0C5CLRKjDuu4C8wZhlNM7CHVrmM/DoClQ/8S
 DQvMQdSBAEdgVIYYsXOjHyoLn+a5LmvSBI3XZg7oPhEjBULzhXNfcdDWp2IInea5pSkABtfnb
 Q6pKLZ5I9Ruu2bO3Y2taB/mbvCHuIYEwoooKcMuYDU0fLV7RIrdpVE7QRv58YYRShSKHIfdo5
 IfB1uPtsdp+GUbNyeulSp9hychqKewsOLrin5W2Ggqto4rJoQfotFlDY/sRHc+yGAYSr6Z7Zg
 yzgK5D3QlVZKO7SLPHqZsxr0NIYhBxUPuiHhDcKZ3NXQEWcXg3DhqSux+s4M/8dWNaG31yfYv
 GoU8CkH+JApuffFNhJlAYTnVmNFRqs7fNaAy/Yag+b/eHRsNnb3OQyn50Ht9UcwLdM5v1iA2D
 V6G3dsMyDbTOI8IakjmyQJh6X+4Xl9/Ilf2EqFkPiBLqKAHkBVedg8nHV3HKdwoyoNHzW0JBI
 svhG9Y2tJMCws778diARGYnlmlLI0JiOxoS57c/9D88WsfGTgIijhhONOCMefxTrpapOBEN8l
 l35XuOe6WUhxz6cMlfF1+DL1CwtUV7oEgpH7cQYmF2sHg/iL06epIesQ358tzbRLKsBo1ucJc
 z4m2BGslJjpW+5UJ3waQ6iWzBEntHZV2XL9PIAk1qTA+nxK1dq8e3XyQfFW7dAqvub5Z+v4mj
 vR4ZKUsbXFqfjE+e+NIB6R2u9gr93qYurk7B23BTxjxJ+VLEcOrac7d70Q4Y8WBjxwgViZLPa
 Zyc1YU+kpQfoFEntOwNS8/v/mG1Kn9VG4KIC/VcQv9QfDapAI5FJdZEBUyadEAoJKJIOoM4Ml
 rUu9N6X6lbhT5vCqpxaCvleO4Re0z/B98113XbEyzZwxmybI+SY29YrOgsRngWI3UzNMQtm45
 a5hRA1xpj6/uvxe1u/a7RicoDIw4kmAEOehqQJKdfmPuwn7LCEHE1K7Sth8H9dA8SOSVcNzTg
 xsp8VQjFreBg/LvjeQcpVYbFb4cjxNd+lQZttkP6ls59IAGgh2LKkkUya++yfmWWnkvHhm2ex
 a7Lu0gOaxl5q2rEWmrt56zsgae/BK3w5UQcoW1aFaW7zBcmVFMjuPhZCf13JrxnSNfuwshMNk
 G8o66eMrn6/F2u0HHehmgINVixTAEHqfEgDjKhOs15rxQqrdMVBplSMoFmqbxhcQPvlksEeUW
 LBcoP9QikX6qcEN0KMjq1d+giZPLd7I53sgwKHhNh5HxY0BBWBAmvw+q1Pg4WDexlPB0FwGHp
 mx8oR8vaKwqJpIK1PN0ESH8E0sD7gOf1ZXG6o8P76h0mP1ueh08Gkc7zTCWlB8aSWLeNagPx5
 PigPrniPqoMeZvtmxASLg70uTLhjtfKW0KeFbCD3u3Mvg1GyNianeSYNZ0MZvD4ZcfoUDD7fc
 5yqvtA2GWRgRbW0bm9JfKSMhjR/E7T2Xb/Hr7hPh0VaylSVXyuKGiiNoh3wqKC27n6rYY907I
 ZxZE3VGkFH8s0wuLhx4uuXdhiQeA4hmgFWj0rORnT5pSpnE1Y4l4gCmlUad4m7jTh/3NQbQVz
 9GaF1JVXDtU6/PbX2KpXc5KnnQ3KTWnv74kInSGJhr3d3iGJS3LXP4wSfb7yhG4hPpyXi8ebt
 K0UxJj9cXO+nVxxvponvzY4K1tWC9+eAv19mU65cQvJbvfKkpJvFNWsygnbdnq6OCPJ2/p97n
 K+pf0ZWI/+9u45jAiEOG2VO9IyErdmDCtOV5Yn268rwOJtq7aru2T6iAunv2QY2lICNaSEyMI
 nw01dcTjP/1yV6+dzGD0BtE6U6E9EjLfyxLaPvs9Ym2SVBd+q3NCjhTYjF0ME1OwcWZYm2X92
 YlaMh/X69PcY4aE0JJ5hkVTEahjLzZWe9rc7LxHil1h02WsPxEqRdGaMfJDhWSvnQSWcrpXFd
 3vyhvvx2QWNfXVsES8ZOpipelXjB39BxL6YglwrVZc7HbvfOTZvkxsBf10B8+bYC1U3TWYAV2
 Oe+12J+G2vgs1VtCPOhuadMJCsGBV8ghh6I233sikNV26DjthycPCrHr0mXUTxMI0gYwkGZBe
 yY9gxNV3RwgjU4eU4/g2oeqcxtckQEt633VyCuf4wh+xk+4QSzYGd6EV9w4EZl150u/yhQQL/
 UnHw7axHL56sb4s2iOYbW4yTGjqUc80lhAhQ3UOGQh9ZBiA9GUW1KTW1VDcZEBkbXIhfJ0Umi
 qzfBAYaT4v1NnWJ7MFtaGAi49IQf+ykTmRjlVc3dmx/NYROoJXOswxFkiQ/j6xjcDMWIsFWpA
 GK1dNCBQkUpAuKh3yC9DVfzFtsswQBA3/TjUX0atx65tnhTmaeKrV7uidwvKehoRcobL0ka5y
 g4s5gu9X8PkcBSywVuVGWxC+9OIlQUhw6rJCG2eHJy/wXY9yCFq6lPwQq705DAva5TObORgPk
 3cZf80grhLzQ3YZWknw+j1SLl92K1+IatxE0hkk0/cPgYh6OpO9e1H+rGNLEprBDg2WgzpQTn
 llDyxFa3xc8/o80PGwsrECIvUgVUvagZgbhzL/rDY1a67KVVUQvhBiI8GJR/E78OQ5YN5aoeL
 kj8jvZ/HUW5BH3O+uV61mgDM5PgP5misfYWNCN8u+KBbW2x7VAJ/jSZPuyVIQ5GIUxqY4Z4bB
 X0sFxk4y0MlWISWqnGq/8K4qmFrG+vFyo+reITmXn7yCa39TRCmu2SkmQjtVI3bLkpcCWNGf3
 jeI8KI+FCd/0yZCtles8JKXylY8qLXwK8QuFpRCkdj6xAF9HhS+J/r280qr+fjRk1DTiNkk2Y
 kvdwOWBtEcWPfHvTtaVtoV5uosYlhh1rf+dbeCGwGDBgluUxNkKOox4A1JscAfVk3x+z1bFu5
 94dhVK6LsoKpkcY59Pnl/bDEmQAZ+TFdeHvH0g0W3b9rGu2Voae7zCorB/aFOx6Pj5maJuo3R
 F9q24uKyMtWEo6IOM1ZWI0g4IBgBd3+7pdCsy07Cu3JT5DjKz6cyerVKNVbjqhxFA0wW7UNKC
 xrRCK0//mhlhJUR4IJ17tVSoWvXTXsCK9r/DeA2V6rBxecWG7R1T+Ml7Ybh00eftmRA8IYqcd
 Uw9+3WyUp0A3imOCvnZmcYfSBqUUD+ItRT7GOZBQl3z4yxL2auZkVkYi+fJpw3M5SGRMTce0A
 H0/jfagVJvMyDBKpj6jS17xsGWPA3Rhlono2ZbP7l6h21/C4NtuJhFs+71lVn+QsPzgTOvwgS
 jj3ZeZc7rFkpuLX06iVNrVN5b5cuLx95UnpWVkJEoeazYss/Ghq5pqcjpnPHO7q0GW4seeLN7
 pGCdJPUP5ryFTmqWEgQ4FwlFJPhGvxxdxGzY1ox+i9Q+p0DtPMCywm4EvOWc4liOqHNaPvhfk
 =
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

On 7/12/26 07:26, Heinrich Schuchardt wrote:
> On 6/26/26 16:47, Vincent Stehl=C3=A9 wrote:
>> In the block device selftest, make the handles pointer global and free =
it
>> also in teardown(), to simplify error handling.
>>
>> We also need to nullify the pointer after freeing it on the normal path=
,
>> to avoid freeing it a second time during teardown().
>>
>> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
>> ---
>> =C2=A0 lib/efi_selftest/efi_selftest_block_device.c | 14 +++++++++++++-
>> =C2=A0 1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/efi_selftest/efi_selftest_block_device.c b/lib/=20
>> efi_selftest/efi_selftest_block_device.c
>> index 9c4be834eeb..b5f6f9353cd 100644
>> --- a/lib/efi_selftest/efi_selftest_block_device.c
>> +++ b/lib/efi_selftest/efi_selftest_block_device.c
>> @@ -58,6 +58,9 @@ static const struct compressed_disk_image img =3D=20
>> EFI_ST_DISK_IMG;
>> =C2=A0 /* Decompressed disk image */
>> =C2=A0 static u8 *image;
>> +/* Handles buffer */
>> +static efi_handle_t *handles;
>> +
>> =C2=A0 /*
>> =C2=A0=C2=A0 * Reset service of the block IO protocol.
>> =C2=A0=C2=A0 *
>> @@ -276,6 +279,15 @@ static int teardown(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return EFI_ST_FAILURE;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 if (handles) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r =3D boottime->free_pool(h=
andles);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (r !=3D EFI_SUCCESS) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 efi=
_st_error("Failed to free handles\n");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn EFI_ST_FAILURE;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return r;
>> =C2=A0 }
>> @@ -303,7 +315,6 @@ static int execute(void)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 efi_status_t ret;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 efi_uintn_t no_handles, i, len;
>> -=C2=A0=C2=A0=C2=A0 efi_handle_t *handles;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 efi_handle_t handle_partition =3D NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct efi_device_path *dp_partition;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct efi_block_io *block_io_protocol;
>> @@ -372,6 +383,7 @@ static int execute(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D boottime->free_pool(handles);
>> +=C2=A0=C2=A0=C2=A0 handles =3D NULL;=C2=A0=C2=A0=C2=A0 /* Avoid double=
 free on teardown(). */
>=20
> Thank you for fixing the memory leak.
>=20
> handles is a static variable. Why do you explicitly set it to NULL?
>=20
> Best regards
>=20
> Heinrich

Sorry I misread the patch.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret !=3D EFI_SUCCESS) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 efi_st_error("Fa=
iled to free pool memory\n");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return EFI_ST_FA=
ILURE;
>>
>=20

