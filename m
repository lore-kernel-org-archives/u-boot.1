Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DAD5CD11C2
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 01:03:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A9D6881BF;
	Wed,  3 Apr 2024 03:03:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="nch9jVpg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF73A881C0; Wed,  3 Apr 2024 03:03:34 +0200 (CEST)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 355BE87947
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 03:03:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20240403010329epoutp02e1d4b561a49564c3f4b477cd946817d4~Cn4bYBi6Q2005620056epoutp02X
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 01:03:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20240403010329epoutp02e1d4b561a49564c3f4b477cd946817d4~Cn4bYBi6Q2005620056epoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1712106209;
 bh=NqpgYdXhL4aLbX1KJ1i5RzeFQL8nydkbwgw2tZQzZCg=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=nch9jVpgnLBj3AZVkADU7gy4liBYy0KQxLO5VLWxfarSYtJtHJ1WNCyxNdb6DkT2c
 qRg1GkgBXt0LZLoD2VRbLqOeeKjsNLbst1my7ZWLcUAGEzFORaHxZnCKyu1XqeZt1m
 3nOiKp9xQxAyYxTIRivGi+bGYXHaEuqY+Rq37ijc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20240403010329epcas1p2a7bc3d83e203b14b674978811c2ca968~Cn4a_taPF0866508665epcas1p2T;
 Wed,  3 Apr 2024 01:03:29 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.133]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4V8RMN0TjPz4x9Pp; Wed,  3 Apr
 2024 01:03:28 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
 F3.EA.10076.FDAAC066; Wed,  3 Apr 2024 10:03:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20240403010327epcas1p1d0bafb3ae76703de8ca5c8c7ad50f9a8~Cn4ZUPp3b1506515065epcas1p10;
 Wed,  3 Apr 2024 01:03:27 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240403010327epsmtrp23cd2e1edebf458bbb865d8ff8035494f~Cn4ZTIMxi0943409434epsmtrp2h;
 Wed,  3 Apr 2024 01:03:27 +0000 (GMT)
X-AuditID: b6c32a39-59dff7000000275c-08-660caadff43a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 2B.52.19234.FDAAC066; Wed,  3 Apr 2024 10:03:27 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20240403010327epsmtip2b8489b1498f3ff23c06e9e56e3235701~Cn4ZB3Wtv1426914269epsmtip2g;
 Wed,  3 Apr 2024 01:03:27 +0000 (GMT)
Message-ID: <9afc6e0c-7484-46dd-ac64-44a2051b0ab1@samsung.com>
Date: Wed, 3 Apr 2024 10:03:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: renesas-sdhi: Stop transmission in case tuning
 block transfer fails
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Hai Pham <hai.pham.ud@renesas.com>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Paul Barker <paul.barker.ct@bp.renesas.com>, Peng
 Fan <peng.fan@nxp.com>, Sean Anderson <seanga2@gmail.com>, Tom Rini
 <trini@konsulko.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Language: en-US
From: Jaehoon Chung <jh80.chung@samsung.com>
In-Reply-To: <20240220083853.34497-1-marek.vasut+renesas@mailbox.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIJsWRmVeSWpSXmKPExsWy7bCmvu79VTxpBp8OW1lsX9XMbPG2udii
 deUdNos/J3+wWvxY9YXVYuu9CUwWUydtZrd4u7eT3eLr3s9sDpweK1/MZvfYOesuu8erA6vY
 Pc7e2cHosXP2PiaPA5PPsXpsfLeDyePbmYksARxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7x
 pmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QPcpKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yV
 UgtScgpMC/SKE3OLS/PS9fJSS6wMDQyMTIEKE7Izeo5eZC84L1px+8EP9gbGVYJdjJwcEgIm
 Es/fvWPrYuTiEBLYwSjRtek/C4TziVHizZLpCM6kL3PYYFrWXT/ECpHYyShxafJuKOc9o8TV
 ZevAqngF7CRmdX8EaufgYBFQkZjfVwwRFpQ4OfMJC4gtKiAvcf/WDHaQEmGBeInjEzRATBEB
 d4kXf3hBJjILzGCS+L3wHStIObOAuMStJ/OZQGw2AR2J7d+Og9mcAq4SPXPmMEHUyEtsfzuH
 GeLOLRwSfx6bQNguEv/3NLFC2MISr45vYYewpSQ+v9sL9r6EQDOjxNIlB1khnB5GiX8N16E+
 NpbYv3QyE8h1zAKaEut36UMs45N497WHFSQsIcAr0dEmBFGtInHp9UsmmPl3n/yH2ush8Xnp
 DkZIUM1glFjwroNpAqPCLKRgmYXkz1lI/pmFsHkBI8sqRrHUguLc9NRiwwJTeGwn5+duYgSn
 XS3LHYzT337QO8TIxMF4iFGCg1lJhPenN2eaEG9KYmVValF+fFFpTmrxIUZTYNxMZJYSTc4H
 Jv68knhDE0sDEzMjYxMLQzNDJXHeM1fKUoUE0hNLUrNTUwtSi2D6mDg4pRqYZs0XPd+w6aL7
 Nx33JzIZkv9fhbTLxHr1PkqfXbJ2+4l1f869kHl33nzB0ZQ5kn9kJ6jc/rdqd+6+y7MzPPeJ
 RBxZHbtg7xfbFlaDHrWQJnajm+q9zCrrTlcK/XNttzqQMdWi4vz8O0v/ZjyaPq3xgNFU4ebm
 1MOrMuJbMo++XTO/62TRsZmdtn97fBfM32HxSv9sq9uRH89nRNaEWfYWs5z3yW3QZPwr4RXi
 3pBa0qdXlSUU/TJp85sT4vvnCkdseqB8wXuvRMztysVdr9vXTP/+Uv2TqkykuOOOIleb4x3T
 dBdE7pRVjEjfZrbFocG957geZ6tzVJV+44Z6qWdyF4XCd+3eqB3tHfyr8KCUEktxRqKhFnNR
 cSIA3RXueUQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42LZdlhJXvf+Kp40g2WnFC22r2pmtnjbXGzR
 uvIOm8Wfkz9YLX6s+sJqsfXeBCaLqZM2s1u83dvJbvF172c2B06PlS9ms3vsnHWX3ePVgVXs
 Hmfv7GD02Dl7H5PHgcnnWD02vtvB5PHtzESWAI4oLpuU1JzMstQifbsEroyeoxfZC86LVtx+
 8IO9gXGVYBcjJ4eEgInEuuuHWEFsIYHtjBIHl3hDxKUkPj+dytbFyAFkC0scPlzcxcgFVPKW
 UaJr0RM2kBpeATuJWd0fWUBqWARUJOb3FUOEBSVOznzCAmKLCshL3L81gx3EFhaIlzhy+DEj
 SLmIgLvEiz+8ICOZBWYxSZz9Op0F4gQXid+XrzOC2MwC4hK3nsxnArHZBHQktn87DmZzCrhK
 9MyZwwQyh1lAXWL9PCGIcnmJ7W/nME9gFJqF5IpZSCbNQuiYhaRjASPLKkbR1ILi3PTc5AJD
 veLE3OLSvHS95PzcTYzguNIK2sG4bP1fvUOMTByMhxglOJiVRHh/enOmCfGmJFZWpRblxxeV
 5qQWH2KU5mBREudVzulMERJITyxJzU5NLUgtgskycXBKNTB1OXGcVDZx40h4NO3J6uDK7//f
 +dk+typ/m9K4oLvK27wrStriX8qf42yHvnWGGm5JjdEwv7Vb+OuGMtvdViUz3j1Xfx+5TYcv
 aRlPcOndvBUhHLGdP3fVTvX3UGcocj/Y/DyJp69O4ZNFyIQnOSX73a/OZp+6ZNmLpImXPlf3
 L5yzdKb2OfGlL5jumBifXjL/nPFhmdxbzFEsES6fIyyvN7x9LitpG3P3TPzf+K87npmf+nl4
 Bf8BJsaX7EvOhiibR9+3ZM2Y2fOQ+0VjtZj5uwOhahd+TTXnO3ft67S7Ed/Wrzz5+9WWY66X
 turPdjt54EhUaGA05+/fC6pKq3UvNrXeljWa9S345qyz1w+2KbEUZyQaajEXFScCAO/JOlMa
 AwAA
X-CMS-MailID: 20240403010327epcas1p1d0bafb3ae76703de8ca5c8c7ad50f9a8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240403010327epcas1p1d0bafb3ae76703de8ca5c8c7ad50f9a8
References: <20240220083853.34497-1-marek.vasut+renesas@mailbox.org>
 <CGME20240403010327epcas1p1d0bafb3ae76703de8ca5c8c7ad50f9a8@epcas1p1.samsung.com>
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

On 2/20/24 17:38, Marek Vasut wrote:
> The current code uses the state of tuning block received by SCC to
> determine whether or not to send transmission stop command. This is
> not correct. Use the state of tuning block transfer to determine
> whether or not to send transmission stop command instead, because
> the transmission stop command has to be sent in case the tuning
> block transfer failed.
> 
> This requires two changes, separate variable to store and check the
> state of tuning block received by SCC, and another separate variable
> to store and check return value from transmission stop command.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> Tested-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> ---
> Cc: Hai Pham <hai.pham.ud@renesas.com>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Sean Anderson <seanga2@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Sorry for late. Will apply to u-boot-mmc/master, Thanks!

Best Regards,
Jaehoon Chung

> ---
>  drivers/mmc/renesas-sdhi.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/renesas-sdhi.c b/drivers/mmc/renesas-sdhi.c
> index 316b75b35fe..c4d0733b621 100644
> --- a/drivers/mmc/renesas-sdhi.c
> +++ b/drivers/mmc/renesas-sdhi.c
> @@ -568,8 +568,8 @@ int renesas_sdhi_execute_tuning(struct udevice *dev, uint opcode)
>  	struct mmc *mmc = upriv->mmc;
>  	unsigned int tap_num;
>  	unsigned int taps = 0;
> -	int i, ret = 0;
> -	u32 caps;
> +	int i, ret = 0, sret;
> +	u32 caps, reg;
>  
>  	/* Only supported on Renesas RCar */
>  	if (!(priv->caps & TMIO_SD_CAP_RCAR_UHS))
> @@ -612,8 +612,8 @@ int renesas_sdhi_execute_tuning(struct udevice *dev, uint opcode)
>  		if (ret == 0)
>  			taps |= BIT(i);
>  
> -		ret = renesas_sdhi_compare_scc_data(priv);
> -		if (ret == 0)
> +		reg = renesas_sdhi_compare_scc_data(priv);
> +		if (reg == 0)
>  			priv->smpcmp |= BIT(i);
>  
>  		mdelay(1);
> @@ -624,9 +624,9 @@ int renesas_sdhi_execute_tuning(struct udevice *dev, uint opcode)
>  		 * eMMC.
>  		 */
>  		if (ret && (opcode == MMC_CMD_SEND_TUNING_BLOCK_HS200)) {
> -			ret = mmc_send_stop_transmission(mmc, false);
> -			if (ret < 0)
> -				dev_dbg(dev, "Tuning abort fail (%d)\n", ret);
> +			sret = mmc_send_stop_transmission(mmc, false);
> +			if (sret < 0)
> +				dev_dbg(dev, "Tuning abort fail (%d)\n", sret);
>  		}
>  	}
>  

