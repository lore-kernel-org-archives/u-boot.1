Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E2FCA5FC4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 12:26:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E2DA640D06;
	Fri,  2 Oct 2026 12:26:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XPFA7DVV-eWB; Fri,  2 Oct 2026 12:26:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 07DC540C88
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790943977;
	b=Ouy7Q31GnqF4HGZjoYlk7gJoTwp+Exmk3e76Y9r3pia9VPCrW5xA76g4l90GnLqHYapG
	 v/1tJQRxz/3e3lJkM+ozNFkROK5Lw3GsArmiWgZKHjRj0E10IFJ8+LOkB1FD0ZX5B/lGF
	 QBttTvxHgSVKSf2Myu931OZ4vWoyMZSa1FIRxPQtP39EVQA/CxeBbUycH9tbHXXWMXu5N
	 DL5F1c3s15WlO13sUIVKyti15ldy3SIURTtAn4GUkSpNT1CvSOdxC5Rvc72kkbihFugCE
	 O4RjklmbvSsrsEmGoDMOpQTVk7R4DMDueHEXl0rBYqoafcoA+Ed+PBHByEV0+Cnvn1Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790943977;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Received:From:
	 To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-originating-ip:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=benQypfP7Cej4hgefA98uRPaFMq4mdzCL4YJPLqrhHM=;
	b=Xb6trTpza22OiNgoFfbet202Mh/icJtfhdBXut2TqoV5q984y8meKQ7vfvwDLqyfOqPV
	 /YfJ5g1N/fWknoOj1HOfBvdvcqcdSNgzUEF9n5mD3h30v7DwGnZ4pWswMbY9qHaEDR8RD
	 6yyQJNRt8coRMKv/ay25A3S/iqD4cA3uvKraj2A9lFhmqAXpWPijeup6kMGrqVVmn1Buq
	 hQKZOxZTOmrrqxVkpuMn8pHrXZypEz0tB0jH9PCl6cug7HtIqvoEriPFvu+C+yZ0SPebu
	 eS5K4rBq7k1UXwR36Sl/9HPtXVtYxBsLl3uzHJSmk3VNmFq4tI1rkH7aB50Dmj2uXjA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790943977;
	bh=benQypfP7Cej4hgefA98uRPaFMq4mdzCL4YJPLqrhHM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EkpeypjxVcaPbKKGfVy3F5JYKXjc7XBQNQ0mI11M/gxvGnQQxhzR0aLcXkd2SoRqr
	 duaWV6cq2dpqyEc7Ch+NlznMLkZ65UOk/5bRTTLGLzuB2Lemi2m+7OSyUby9UUHAgw
	 R0YHF6DnRxR3TX3cFrGu7CKxYfCXB+TbUA7ooAD7Wq+LKq/CdmwOUS9SIQ8jzlzWQM
	 yTwk5Q0T2XYofAu2OvfBpqwsVC24PYKobLh+9MXvkhCIkCDiSZ5exfnLYea55Ni4j5
	 hidXtg24P1Uh24SGGACOHUpEegbn2/4p1tI/FXRxR0scSsOdHLg5btcI7lfZs4dobg
	 YfUOksM65Fprw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 07DC540C88;
	Fri,  2 Oct 2026 12:26:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 81A1B32A
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 03:09:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 67D938113C
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 03:09:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xo5z-JDVtM6Q for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 03:09:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4B8028112F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:18f0:1e00:4::4"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790910570;
 b=FcR7BwTEAdj/+6Z/tUO+182nldWDnfFpCKlDmDTJcQpbOq8GQScsgZ5qS2T8DAR1KYrk
 OHz1fMjQJuglZ7sugmn2Q7cwkzgexHjTT9PLEVxxQMXkJSxBJa5L2CSPmUwAKZVR1+SZU
 Xvb5R7T/aQgJmH5H5HDJF4fkw9o3VAESMAFxAf7H5Yn/mvGIEv6I6xljFG8IzYy+mXFRI
 igQluG+KMwp5+KCgrr8i3WRaMT0Jys3sABMc37zS3BVeLNNvIN+ePHYX4ISUPph1+dE1S
 wuihTkvwxJQMADfCzVO/4Qff6nJKRsp5tijD8Kb7oQ558YVrR5LJ/a6ByQwwnsHT67w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790910570;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:X-Amp-Result:Received:Received:Received:
 Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
 References:In-Reply-To:Accept-Language:Content-Language:
 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-originating-ip:Content-Type:
 Content-Transfer-Encoding:MIME-Version;
 bh=benQypfP7Cej4hgefA98uRPaFMq4mdzCL4YJPLqrhHM=;
 b=rIhP7jWPxteChvO5a1MlTiqA6pQ4mmcrZLJmKKhhMElKEuqgimR45n5o+GKmGmgJwPug
 bo42U8/jmb/04RgwbF81gQ+rxZ9SP75sgJ/HDfb4tA5rYIFGKMZs5yTJotjg0WMWa8YfW
 IohgR7Lv0dWevvj3EwMdfdmXg8OJhjfz4fTnL+1vaMjjGT/I/xM1xYgaPaa//vhNod90e
 zedzeBCKhNox9Xu7H9ugEJxvECeILQwe/C+fPTRbKdFSVX4l4Lt+XMqOLM3+8OeGxk6YV
 GNxBcJrjBLsWM0KtzaVCxhkJ0+s4a2L0hJQBjSkOMeY+9xL4hqEB8+YUU0pJY0dssSA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=infineon.com; 
 dkim=pass header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256
 header.s=IFXMAIL header.b=T+jQ89xP; 
 arc=none smtp.remote-ip="2a00:18f0:1e00:4::4"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:18f0:1e00:4::4;
 helo=smtp2.infineon.com; envelope-from=takahiro.kuwano@infineon.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256
 header.s=IFXMAIL header.b=T+jQ89xP
Received: from smtp2.infineon.com (smtp2.infineon.com
 [IPv6:2a00:18f0:1e00:4::4])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4B8028112F
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 03:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1790910570; x=1822446570;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Jv1NK0/JlL033n7itnFmUdRdk5SIZF2DmLRMCjFZ/V8=;
 b=T+jQ89xPna4YYMggeNuoN9Og2CKW/51H74JUl0KRZPVstkcWSbQvficK
 IJ6jl97nbQps9OwSAeUGwn15NzklkgrA4hlEkTvN9V01LIHiHNEIpwVkL
 2cJbgzowtnVRx5sVeEzAxO/Y4viINb5Z6/jLcRa3pLWbKdNolGvZsuxQW w=;
X-CSE-ConnectionGUID: vmGYm3SIRrim8+/t8nGAaA==
X-CSE-MsgGUID: x/HTOvpRS9uLyn/ZmS9wGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="181876421"
X-IronPort-AV: E=Sophos;i="6.27,135,1787004000"; d="scan'208";a="181876421"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE812.infineon.com) ([172.23.29.38])
 by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2026 05:09:26 +0200
Received: from MUCSE811.infineon.com (172.23.29.37) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 05:09:25 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE811.infineon.com
 (172.23.29.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 05:09:25 +0200
Received: from MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14]) by
 MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14%12]) with mapi id
 15.02.2562.049; Fri, 2 Oct 2026 05:09:25 +0200
From: <Takahiro.Kuwano@infineon.com>
To: <vjardin@free.fr>, <u-boot@lists.u-boot-project.org>
CC: <trini@konsulko.com>, <vigneshr@ti.com>
Subject: RE: [PATCH v1] mtd: spi-nor-ids: gd55lb02gf: add SPI_NOR_DUAL_READ
Thread-Topic: [PATCH v1] mtd: spi-nor-ids: gd55lb02gf: add SPI_NOR_DUAL_READ
Thread-Index: AQHdTIs6VFk37gpiRUa4fOjxEvR9ErbpnDWQ
Date: Fri, 2 Oct 2026 03:09:25 +0000
Message-ID: <7867546d20dc4990b8749a0709fdf44a@infineon.com>
References: <20260925011422.290027-1-vjardin@free.fr>
In-Reply-To: <20260925011422.290027-1-vjardin@free.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.161.6.196]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 02 Oct 2026 12:26:15 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

> The GD55LB02GF supports Dual Output Fast Read and Dual IO Fast Read
> according to its datasheet, but its entry only declares the single
> and quad reads.
>=20

Please confirm the datasheet link [1] and add Link: tag followed by
the link if correct.

> Signed-off-by: Vincent Jardin <vjardin@free.fr>
>=20
> ---
>=20
>  drivers/mtd/spi/spi-nor-ids.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.=
c
> index 31a2ba49a87..59247b3f4b9 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -233,7 +233,8 @@ const struct flash_info spi_nor_ids[] =3D {
>         },
>         {
>                 INFO("gd55lb02gf", 0xc8601c, 0, 64 * 1024, 4096,
> -                    SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES)
> +                    SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> +                    SPI_NOR_4B_OPCODES)
>         },
>  #endif
>  #ifdef CONFIG_SPI_FLASH_ISSI           /* ISSI */
> ---
> base-commit: a06e89ab05eaa2b8344d521319399333cd760ae5
> branch: for-upstream/mtd-gd55lb02gf-dual-read-v1
>=20
> --
> 2.43.0

Thanks,
Takahiro

[1] https://download.gigadevice.com/Datasheet/DS-01015-GD55LB02GF-Rev1.3.pd=
f

