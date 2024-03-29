Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F67DCD128A
	for <u-boot@archiver.kernel.org>; Fri, 29 Mar 2024 00:03:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FC26880E0;
	Fri, 29 Mar 2024 01:03:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="pcX95VEQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 393DC88150; Fri, 29 Mar 2024 01:03:52 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 555D587B71
 for <u-boot@lists.denx.de>; Fri, 29 Mar 2024 01:03:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1711670579; x=1712275379; i=xypron.glpk@gmx.de;
 bh=ZAMAAhYbZPpAwDAdi7ISUH+6OZpM+Z9F5fdZX/DiPQI=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=pcX95VEQDdhZfY8KDmNaCUK4zWNxJDQLAkmsBdiX3Y71EVFzk6gzvYvgG1IgirEb
 gwZwknkEUin+icZLY66edRD+xZ56Kp+cODszTxkWXBsqCLsSaReEGsVnoeNVPmRT+
 YwFhvsUOwtF68VsgtDpa1tkkcJ8w9k2Ks38HLgkXJi/rcNShn8WVxmxXEC8h3oVbv
 Wn5CWzdsfSIZuCYN4b6IK4wWqmjqo3P3P8/wtIMnYMR6qnFRf2UwaNqGGHco7+AAi
 06RltN2iqpxKgCYDYdr21wq6Vw5j6udwNdkljv72f+0jXY2G+4mRSy/tVzR7bvnpA
 +gqfuW8MxGvKr/8bbQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9Fnj-1rt26m39Ox-006S57; Fri, 29
 Mar 2024 01:02:59 +0100
Message-ID: <a79a11aa-439f-45bb-99ff-7a16e1263c33@gmx.de>
Date: Fri, 29 Mar 2024 01:03:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] part: Check all partitions in part_get_info_by_name()
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng@tinylab.org>,
 Johan Jonker <jbx6244@gmail.com>, Joshua Watt <jpewhacker@gmail.com>,
 Steve Rae <steve.rae@raedomain.com>, Petr Kulhavy <brain@jikos.cz>,
 u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20240328222951.11431-1-semen.protsenko@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240328222951.11431-1-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lYfq3cloAk39hwXGN52QIeSvOe5uL46fAZEV1B2lhPEb6HzuN05
 As87F8zTjqqdAfRpm1RuFmubm56koc4ycgzGoRafSsGuTOPu0pm74aIn0YEr63unPrT/mfR
 Qnqjq1qUS5zQ3AjG6lXUiXDplTaqVkLNGQae6gsX+/EF9iXN4XXkEzTvj1U2fnrWkSXpli8
 QaOtd4EOnz6WrM6mHeEPw==
UI-OutboundReport: notjunk:1;M01:P0:NmwdfAeZEiE=;Zj2K/M341jSYZSOeubTJAGupdNO
 7OTCYhVt2q4kzila2Bfq1tJOXkd3aJPFJHJOqHfX7ucl05CrXy3e6ErpnnuBpMzP27z0Krdxx
 T/KRADtwRyRPYzvpdnileV2vDrDDGvMppk/UFHVdDpWIsu9mRZQGUmX5a0grxFa7GvOjR2bIt
 xKQggZye8niBw7cq/G000AQaatPhbgKRKJZ3bHwK0bLKn/O38Dnp7x4h7HC6UIMmP81fioxVn
 Jfgcr6BtXsOiGMsR0C8WKHjs14RqzFumWUj9LGgFfJuuZLg9aL+Pc9Eymhja3n4UN2Pdiv+Fg
 7C9jyndQJ9b4Ie1Rs8dMZR3SRGjDDIVnhkZjuDqYlcH3cGIhArSdYqwbdaRJhVnJ+z3Q97Y0e
 XHvgOz95LrIUj9NWh8d3XfGTK40PH2lCVTYWzPToL0c4Pxj85sKNwOIrSnICRqJMF/QaMeELe
 X+vZa5uCFarv5pKCFjNkeYWPEES7Y23xR25LgvgOv0uS+6fJ4/HPANnoFyeYz2fbcp5INHYLv
 pF6uSrHbotdK0UC3UnlOCRgRNR+Ieiyb8fRHPk++zeo5zenZRfRZENubMCssdR6UreDRJVbXb
 KQxfDZJTx6IA/I3JpG1YSEfSoaNkAtYRxMw47IHkxQGi06GfA4kU+PUoEw3HBP7oV3vGkKLRJ
 b3rt34OgwmpCAwuCAgaz91No/UOlidDxe3M1RAM1cdq74BQPIFNHhh7OdVSxLLkxiFVTM+Pl1
 Rcvi7zxq9W9twg0Y+xKlKmZEIbWnssrYre4MJoJNtpaWTx1skrqhQAocswKdL6T9FBsP0t9CX
 d0OQrJNlJVA8GWI6wyPLsvu9PC5Yb35HRhn7K2WbJo/xk=
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

On 3/28/24 23:29, Sam Protsenko wrote:
> In part_get_info_by_name() the inability to get some partition info
> shouldn't be a reason for dropping out of the loop. That might happen
> e.g. if the partition is hidden or unused. An example of such case are
> Samsung devices, where they use the "unused" GUID type
> (00000000-0000-0000-0000-000000000000) to indicate that the partition
> should be hidden from the OS. Such partitions might not be seen in
> "part list" output, which creates "gaps" in numbering in between of the
> visible partitions:
>
>      Part    Start LBA       End LBA         Name
>        1     0x00000400      0x0000a3ff      "efs"
>        5     0x00026420      0x00026c1f      "dtbo"
>       12     0x0003f390      0x0074738f      "super"
>
> In that case, the loop in part_get_info_by_name() would break after
> partition #1, so any attempt to obtain "dtbo" or "super" partition will
> fail. Fix that by continuing to iterate over the remaining partitions to
> make sure none of the visible ones is missed. That makes "part" command
> (e.g. "part start", "part size") able to work with such tables.
>
> Fixes: 87b8530fe244 ("disk: part: implement generic function part_get_in=
fo_by_name()")
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   disk/part.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/disk/part.c b/disk/part.c
> index 36b88205eca7..08c9331e059c 100644
> --- a/disk/part.c
> +++ b/disk/part.c
> @@ -717,8 +717,11 @@ int part_get_info_by_name(struct blk_desc *desc, co=
nst char *name,
>   	for (i =3D 1; i < part_drv->max_entries; i++) {
>   		ret =3D part_drv->get_info(desc, i, info);
>   		if (ret !=3D 0) {
> -			/* no more entries in table */
> -			break;
> +			/*
> +			 * Partition with this index can't be obtained, but
> +			 * further partitions might be, so keep checking.
> +			 */
> +			continue;
>   		}
>   		if (strcmp(name, (const char *)info->name) =3D=3D 0) {
>   			/* matched */

