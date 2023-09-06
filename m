Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9DE8EB8FB6
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 12:10:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E94E286553;
	Wed,  6 Sep 2023 14:10:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="gZy15mVy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5466386519; Wed,  6 Sep 2023 14:10:44 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B57C086571
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 14:10:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1694002235; x=1694607035; i=xypron.glpk@gmx.de;
 bh=S48rDx/XPAdv4yk9g2v7K7KjJchx289jsDUa8Illqgo=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=gZy15mVyANqvcv05Ddwb0X/f6ZGh6YjOqvYhyQtT+l9exdgY4I6GQBV7DCgTtDQIF46LOSo
 LfkCeVLR2EzofCuZBRN8BnHSPrpB7pSpXsZH5oiBDtQW9lMrjNlfdT8LLZgAhOf2Zehi37p78
 Iea23STQ3WXkP4rEH1SeZJbwZ2k/3fBHHQUQ6saY5aygyCZAJ1S58hj07SWmxs6fUMwPbjaff
 H9f5epMtXlIC0FM411PhVytXzvEWK0ea3Vyw2jtpwyY+VIyc9z/DhFR576K/TQPLhrup4Z3X6
 3lBIR5z50+OdLaS5nUki/aG+YjMlvkJ+z/cJpZIWtMm+8zBId5jg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbRfl-1q2rqs3CED-00bw6b; Wed, 06
 Sep 2023 14:10:35 +0200
Message-ID: <2ce99268-a437-4304-a1d4-f86b8ceaaffe@gmx.de>
Date: Wed, 6 Sep 2023 14:10:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/11] spl: Convert semihosting to spl_load
Content-Language: en-US
To: Xavier Drudis Ferran <xdrudis@tinet.cat>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, Stefan Roese <sr@denx.de>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <marek.behun@nic.cz>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Sean Anderson <sean.anderson@seco.com>
References: <20230731224304.111081-1-sean.anderson@seco.com>
 <20230731224304.111081-10-sean.anderson@seco.com>
 <ZMtnBC/Dn6mcFZwe@xdrudis.tinet.cat>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <ZMtnBC/Dn6mcFZwe@xdrudis.tinet.cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0jdooeLfR5xm6HHLGJ43LWJFzIbchXrYoXcnhSEq+p3slQpQxyy
 VHfx1dzxz84oYopMF0IuCNL8EGp+nxDMhzD9B/o7jZ1bV7R75FZXprezLK7NJbaRz9exyUm
 1pY8/yz7SMbSn7z4ND+wim5gUqd7lLfLUQGY4Cu6PRRiUVTh9v8BbmsoNljzX4gKc4T37t+
 y3yy6QhXchE49oVbFKV4g==
UI-OutboundReport: notjunk:1;M01:P0:97DYIiTOAoA=;X/VO0TLPMwQD40a5cqEVIUpGcCa
 Y6uUHxp2MrVDU3a8AllxY9adjjvbZjeYWf8BkNXPnFu4E/ni1EKOgAKMpTCxZxG3gGe1Za+I3
 O6EGOXheM1XNAiHYwSGhbLgkmuc7oy33+Wh6DxPzwt6vnxqODXuKybMbHW1+qWTJD3RHBK85s
 VrF0G9IhVjldg/NuJb1JwUPDPxGBrW9Vx6c6xs+Z+dirvLzQ0qqMYp6CFC3lztkxoXG4oOGTX
 2A6PelfOajczAGdXLiNSaGwa0JY1VJrshWaWm3z1ZIx7xy86+3PsdxjDvvoHZgV5wXl1jOXhH
 Vr/b99+9uoKTEsAjUwC0Il800ODs9USiGguVh8mkwSbd/5QH6FkSY1UT3NysSbu0DSyy/sJmr
 5mRfPNKMjmXFDcAFMRoaljH3QR/6XdQ63Sw+tlNyMheYNxdcN6C6/1pAiJSdYQj/aB2HhAesF
 DKzV5NIGvQr826QyX+aYqwtdIhrC25RMZJBrM2NbcRCRY9Uw7wqzs+BKCPiGjWaewqs1JMkhA
 qSwtvv1Y5AZrI7pZUYsiBCulg4SrZOoaA7LJthKCJz3jC8n075OBXabxs3T5dE0I+LPucxepd
 Lpe0aKVhWEjcDeYPqHtXK1X0U/jpjuOYA0SU+0CRItdW4k35ZXxxSBFf8/xrvaBI4H653GroZ
 i3hOvOR51sB66vKcZ3/4cAuUJjX0xS8kKV7rv/uYjmT17dspPOtDQ354sgAlHjDvI1aVKL+cZ
 DLTWwVz+XjRNa03tA3vR93S0/9zbYo+NpcoYnrlMpI42P4vxLbGga4QRioziUwaw9Z/iirxEj
 dmvJ0SIzDY8v5SWw+SDHBge7T7mW+Yx3ds/fxS9PvgFpqlgZV4maoHq+/G4V+cKNpUTPndrui
 nv2gdknm8lHtHE5GsW6ziGAEk95D59FpK+1MPvvu4gj4tiH6flW8ofWaLJl1GGrwpHDL9CctR
 AX3A1dp5+zmZUBrPp9VLJhwqzek=
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

On 03.08.23 10:36, Xavier Drudis Ferran wrote:
> El Mon, Jul 31, 2023 at 06:43:01PM -0400, Sean Anderson deia:
>> This converts the semihosting load method to use spl_load. As a result,=
 it
>> also adds support for LOAD_FIT_FULL and IMX images.
>>
>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>> ---
>>
>> Changes in v5:
>> - Rework to load header in spl_load
>>
>> Changes in v2:
>> - New
>>
>>   common/spl/spl_semihosting.c | 43 ++++++++++++-----------------------=
-
>>   1 file changed, 14 insertions(+), 29 deletions(-)
>>
>> diff --git a/common/spl/spl_semihosting.c b/common/spl/spl_semihosting.=
c
>> index 5b5e842a11..e7cb9f4ce6 100644
>> --- a/common/spl/spl_semihosting.c
>> +++ b/common/spl/spl_semihosting.c
>> @@ -9,16 +9,16 @@
>>   #include <semihosting.h>
>>   #include <spl.h>
>>
>> -static int smh_read_full(long fd, void *memp, size_t len)
>> +static ulong spl_smh_fit_read(struct spl_load_info *load, ulong sector=
,
>> +			      ulong count, void *buf)
>>   {
>> -	long read;
>> +	int ret, fd =3D *(int *)load->priv;
>>
>
> should ret be long to hold smh_read() return value ?
>
>> -	read =3D smh_read(fd, memp, len);
>> -	if (read < 0)
>> -		return read;
>> -	if (read !=3D len)
>> -		return -EIO;
>> -	return 0;
>> +	if (smh_seek(fd, sector))
>> +		return 0;
>> +
>
>
> I never used smh, but why would this not be :
>
> +       ret =3D smh_seek(fd, sector);
> +       if (ret)
> +               return ret;
>
> (why does smh_seek(), smh_write(), smh_open(), smh_close() return
> long, by the way? the implementations return either 0 or smh_errno(),
> so int would do ?)

The return type used should match the implementation on the host side.
The ARM documentation explicitly refers to register R0 which will match
the length of long (or unsigned long).

For smh_seek, smh_read(), smh_write()  we should investigate if the type
should not better be unsigned long to handle a number of bytes exceeding
2^31 on a 32bit emulation or system. But that is beyond the scope of
this patch series.

Best regards

Heinrich

