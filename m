Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED940E7719E
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 07:49:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 705E880141;
	Mon, 13 Jan 2025 08:49:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="DujgscdJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4779C801CF; Mon, 13 Jan 2025 08:49:41 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 428248007D
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 08:49:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1736754575; x=1737359375; i=xypron.glpk@gmx.de;
 bh=LeBfVOI4v4WgOSuKQbdJOhfBthkJBfh5Cg1QMJ8oGbQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=DujgscdJkIielQMtSCELt7MZ7lpEOQC979y33F4kkgIW+VaZcz8EsXGBw+Qk9nT0
 xiIFc/4/HA4Eoa9xc4DxlJEzOatmUlqk53sol5rxH80dqGZvakz35NMQ442T9TcFk
 L2pjp/uDWQu23L4i7ET/Fr8nswo+dcfiM+m/bgGIAexhFV7/q63dFQ8s0IJXPGFT5
 dQfBg5GltquZvuCP3siLPIzHlsmXANhwBorcWUehz7PME8SvP7b+VYFz1pg2WrBXl
 rN8/j2m07kJZ2+Egph2Ikm9qKvMrClvRpwl7UQaTO8NxHwRiURwYsq64I2fzG71pj
 rw64jk0tdPfFWsFtWg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mz9Yv-1tKgKi29Vz-01465u; Mon, 13
 Jan 2025 08:49:35 +0100
Message-ID: <e865e678-3319-4b89-b2c9-28a2ddea46f1@gmx.de>
Date: Mon, 13 Jan 2025 08:49:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] bootstd: Fix incorrect struct name in
 bootmeth_setup_iter_order()
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
References: <20250112034213.13153-1-semen.protsenko@linaro.org>
 <20250112034213.13153-4-semen.protsenko@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250112034213.13153-4-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+o1LCl9pP7vS6pllWpyrDBhuUzWG/Uvnv9ZDhtKGfXNws25MPq3
 kXPNA7gle01vWKH8Y+H7RXlBGuzCAbjj4rUxWKu2WcFNVg/8jqsJ2TNkANuNryq59whbJdj
 2DPCRZE7SZ/tTxrlRtrNJAqE+3ywrN0rBml9rbo2AlcCqyw7m3zsAp2ppUZgzaQlE00pkyf
 74HpKGF6cLsk7DIbPoOYg==
UI-OutboundReport: notjunk:1;M01:P0:sSB+OfKhlJ4=;LTNi9B3xHO2eZeO0v6Xv0hv4mig
 fo/HJASAYYxGk/Iy7qYTBHXnkf9il0EUzR76vrR+wRX1BTZEqXFbrSSQN22pwiS86FYmQ9OgG
 vRJ0pf84rB+HDUPGh3MkG+f5I33rggYPOuKByT+BrkuQBlS5DxZ9RgZL4gVWopSa1ruPAtP6F
 fU/9ahYVSH5+31UgHW0v6lzHY3QtzJpdL0EgC8YSWQOqpeKxI2AsXdUZLs94611i9N1RQeYw2
 R+ak0KnYeEXmM9cMrFyCxqCoyyZ+vP5/Yl7NLHKDL7EqN5aA0Z/ZcXuxsvs5mIzPijRFIpIie
 iYs5qh5a8aDF7OG7KU1zdrP9rgVSVApuD+VAUG4Qcei2lV7zwBDXbebT266JxWsgiNRufo1mn
 lhEh44/g8MZWqe/fSXHYfUUZhg5po9I2okYZi7urXPXnx0QkuNmY27a1TFXJsijazejPiHVzG
 2FhInflPexJf7XdeER7841nG1cjbQadyPdYDWaE1j1jdpjTyF0YSaH1Gy6pLffyCPReJUDz4T
 5fUiRBCCJ8wyeaLMdCqA1EcVS16HY2aJ6kXJqsGc6jjJZqm/vA+STZnA4DY9F+1mxBUx5bo4S
 1duXPc0uM3gCyFpe7aHaNKBZr+/43UVPJAwRIVtz/sPb48yGScFgdxN7vDS1ayDdk3nL4Dv2x
 BOLJ1ammqT3hP5WrITdxfOVuEdV5DERJJWCFp72zVPReXI3cmtvXHF0qzPKvYed/lXnPxGG3v
 5hgZyuaQ4k1QAxSBAjdmDnEhthaMuLAnwB4e6olN17yug0aUvnciS/Iicgvq71dJ5vp6aEvU7
 EYq0hjFoyGqHmimV4hBAiWL53rJyDIX/okarolqYxkTNVCEAXxoW70Bt77P5ddxEWvOt/rIzr
 TZcpCMuO4eThPrxI4YhpPh9ITceaImWrMCJKFm6vqyQ5wfsxUGuJ7giXB/gq2mf2hzb3RVNcp
 k76GQiFV3pFBSTMhqVDWFZijlsCC6QqJlKa1kM3I3cYNZsTyRqJdt0Uw2Im32sn8cq6xsWGeQ
 sBubtDoJ+FDN3RXowTaD4Hk4e93YYZ9W1JssQHhwGixjgZ6cqR1RemH+6aaV1WFgM0pdb3sZE
 2JVismjcmH/7GzB1P29pTkxfozPbnn
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

On 1/12/25 04:42, Sam Protsenko wrote:
> There is no such thing as struct bootmeth, it's probably a typo. This
> issue doesn't affect the execution as it's a pointer, and pointer sizes
> are the same for all data types. But it can be confusing, so make it
> struct udevice, as it should be.
>
> Fixes: a950d31abe98 ("bootstd: Add the bootmeth uclass and helpers")
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>   boot/bootmeth-uclass.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/boot/bootmeth-uclass.c b/boot/bootmeth-uclass.c
> index 049389403191..2496e8c1d8a8 100644
> --- a/boot/bootmeth-uclass.c
> +++ b/boot/bootmeth-uclass.c
> @@ -139,7 +139,7 @@ int bootmeth_setup_iter_order(struct bootflow_iter *=
iter, bool include_global)
>   			goto err_order;
>   		}
>   		memcpy(order, std->bootmeth_order,
> -		       count * sizeof(struct bootmeth *));
> +		       count * sizeof(struct udevice *));

I found this description of the field:
@bootmeth_order: List of bootmeth devices to use, in order, NULL-terminate=
d

As the list is NULL terminated, shouldn't we copy the NULL value, i.e.

     (count + 1) * sizeof(struct udevice *)

so that we can still identify the end of the list?

Best regards

Heinrich

>
>   		if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL)) {
>   			for (i =3D 0; i < count; i++) {

