Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA2ACC6FD1F
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 01:17:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79AB38817C;
	Wed,  3 Apr 2024 03:17:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="TjaYELxK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EED3B88188; Wed,  3 Apr 2024 03:17:54 +0200 (CEST)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87B638811A
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 03:17:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20240403011748epoutp028303ffdc9affa7c5740e790630c40dce~CoE65bO0U0095400954epoutp02P
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 01:17:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20240403011748epoutp028303ffdc9affa7c5740e790630c40dce~CoE65bO0U0095400954epoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1712107068;
 bh=HI5cTInw4/YiGIdKNmqfWjYAbva0repBvhzMdtSPu94=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=TjaYELxKecl/obyFASOvx1VctYgLUH2KYgx0q6iKuI+UL+/JGimOZrpnWgii5FRiH
 9nJ8r6pi/XjW6NkfcW9BQdJe/+HxcZEEDGMGgJR7ZM9ACt5JFEVjj3rPl199V+vLbX
 BsooaXqyLcnKicdcUGfvbiBtCn/Ik7szSkoyoNvw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20240403011748epcas1p3f8ccc1b1dc4cf2b39130f7e6642fe166~CoE6r8xUD0822108221epcas1p3d;
 Wed,  3 Apr 2024 01:17:48 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.135]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4V8Rgv0xXQz4x9QB; Wed,  3 Apr
 2024 01:17:47 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 21.C3.09662.93EAC066; Wed,  3 Apr 2024 10:17:46 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20240403011745epcas1p115e30f0b5a36ec0b1d33d7b1443259ec~CoE4aBWqa2516325163epcas1p1D;
 Wed,  3 Apr 2024 01:17:45 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240403011745epsmtrp18ce8e5134b41959d54360ef2a5405fcb~CoE4ZPY7S2100021000epsmtrp1W;
 Wed,  3 Apr 2024 01:17:45 +0000 (GMT)
X-AuditID: b6c32a35-053ff700000025be-99-660cae39674e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 FF.B3.19234.93EAC066; Wed,  3 Apr 2024 10:17:45 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20240403011745epsmtip22302197fed368655dcf2d7aca1341f43~CoE4HMQ5Y2795127951epsmtip2Y;
 Wed,  3 Apr 2024 01:17:45 +0000 (GMT)
Message-ID: <39a993c9-ce67-4f04-84cb-017f627b37b2@samsung.com>
Date: Wed, 3 Apr 2024 10:17:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] mmc: Add generic tuning flag
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Hai Pham <hai.pham.ud@renesas.com>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Paul Barker <paul.barker.ct@bp.renesas.com>, Peng
 Fan <peng.fan@nxp.com>, Sean Anderson <seanga2@gmail.com>, Tom Rini
 <trini@konsulko.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Language: en-US
From: Jaehoon Chung <jh80.chung@samsung.com>
In-Reply-To: <20240224223235.287889-2-marek.vasut+renesas@mailbox.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEJsWRmVeSWpSXmKPExsWy7bCmvq7VOp40g/2zmS22r2pmtnjbXGzR
 uvIOm8Wfkz9YLX6s+sJqsfXeBCaLqZM2s1u83dvJbvF172c2B06PlS9ms3vsnHWX3ePVgVXs
 Hmfv7GD02Dl7H5PHgcnnWD02vtvB5PHtzESWAI6obJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4
 UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoPuUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZK
 qQUpOQWmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZ7densRVM5qvY87aVsYFxI3cXIyeHhICJ
 xMYHjxm7GLk4hAR2MEosWviXESQhJPCJUeJSow5EAshesuYPK0zH4jNtUB07GSWm/9/BBuG8
 Z5Q4dO4EG0gVr4CdxIWPR4CqODhYBFQk3t6OhwgLSpyc+YQFxBYVkJe4f2sGO4gtLGAh8fjL
 C7ByEQF3iRd/eEFGMgvMYJL4vfAd2GJmAXGJW0/mM4HYbAI6Etu/HQezOQXcJE5fa2KBqJGX
 2P52DjNIs4TADg6JBd8aWSCudpHYPOk5I4QtLPHq+BZ2CFtK4mV/GztEQzOjxNIlB1khnB5G
 iX8N19kgqowl9i+dzARyHrOApsT6XfoQ2/gk3n3tYQUJSwjwSnS0CUFUq0hcev2SCWb+3Sf/
 oSHnIXFn8gZoYF1llDjWtYtpAqPCLKSAmYXk0VlIHpqFsHkBI8sqRrHUguLc9NRiwwJDeHQn
 5+duYgQnXi3THYwT337QO8TIxMF4iFGCg1lJhPenN2eaEG9KYmVValF+fFFpTmrxIUZTYOxM
 ZJYSTc4Hpv68knhDE0sDEzMjYxMLQzNDJXHeM1fKUoUE0hNLUrNTUwtSi2D6mDg4pRqY2EOK
 vfh2KOev6Pz6ZF1ziN9czpT1J9kLDjnabpab9EKXtzwtVn2G+Ix1NmFSCZYyb4Q/M7CKvy4X
 eZ33xd7WyVM4J2Sau9vxgtw5TjmL/234ZPHopOWW0MlnWA06Tb/cNbrXJRT5Xlr8yYOFZSrv
 xbM/h2Yy5ub3Hbv10dDIq9rmtrKljW+xDltX+80bJ4rUZz66coJnb6n2/FIbzlXrNk/pbfHZ
 I1bzQZDXc+rqpzuTm/NYkly3Ky9vknIsCtp4MNK0+l/6iouhnz5N/5JTFL/3jOqnqSH/sut2
 7tuiab9ufg+/3ZfzyqdXTq8Ofy/4R6j8xQN97Y+FRwpnnRM+9DH5mE25nODBdLcOF10lluKM
 REMt5qLiRACLJPlSRQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42LZdlhJXtdyHU+awYQnShbbVzUzW7xtLrZo
 XXmHzeLPyR+sFj9WfWG12HpvApPF1Emb2S3e7u1kt/i69zObA6fHyhez2T12zrrL7vHqwCp2
 j7N3djB67Jy9j8njwORzrB4b3+1g8vh2ZiJLAEcUl01Kak5mWWqRvl0CV0b79WlsBZP5Kva8
 bWVsYNzI3cXIySEhYCKx+EwbYxcjF4eQwHZGiXmTXzFDJKQkPj+dytbFyAFkC0scPlwMEhYS
 eMsoseU5K4jNK2AnceHjEUaQEhYBFYm3t+MhwoISJ2c+YQGxRQXkJe7fmsEOYgsLWEg8/vIC
 rFxEwF3ixR9ekK3MArOYJM5+nc4CcUIjo8Sri18ZQRqYBcQlbj2ZzwRiswnoSGz/dhzM5hRw
 kzh9rYkFZBCzgLrE+nlCEOXyEtvfzmGewCg0C8kZs5BMmoXQMQtJxwJGllWMoqkFxbnpuckF
 hnrFibnFpXnpesn5uZsYwZGlFbSDcdn6v3qHGJk4GA8xSnAwK4nw/vTmTBPiTUmsrEotyo8v
 Ks1JLT7EKM3BoiTOq5zTmSIkkJ5YkpqdmlqQWgSTZeLglGpg2thY1DA74EW/wZUjhdM7RQ6w
 hUixzqoI+vUsZ82yKM24p89tQ/oiGs0Sbd0fvSq7tmfGr6lTDE3/fX974deuj/Objln8EwrK
 Vv7/IDHc7r9IzZ45YtMsltss4gpbdrthu/KuysX7KmU3tovN/n5C7Kbs5OJLkseXRuzJ+lrK
 dWXdHSHfVdeDYjiMNu4UsT4zT+TNg+bQ7kyNGr2z3pw3tFJihS7JVDZU37tyVkLK40+uJOPB
 a/rTGe6eYZW2k/5Zk2HVu+p0lkdN5ob/W3u3rJmdHPRg54qH31gilB8kfTnkkqJ6fovBQlV9
 17qpS7WMHq5z7Xx2sUc011Ej8dTXW7+eTPp8pPfT21OuT/POWyuxFGckGmoxFxUnAgC3lyXJ
 GwMAAA==
X-CMS-MailID: 20240403011745epcas1p115e30f0b5a36ec0b1d33d7b1443259ec
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240403011745epcas1p115e30f0b5a36ec0b1d33d7b1443259ec
References: <20240224223235.287889-1-marek.vasut+renesas@mailbox.org>
 <20240224223235.287889-2-marek.vasut+renesas@mailbox.org>
 <CGME20240403011745epcas1p115e30f0b5a36ec0b1d33d7b1443259ec@epcas1p1.samsung.com>
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

On 2/25/24 07:32, Marek Vasut wrote:
> Set generic mmc->tuning flag when performing tuning to indicate
> this condition to drivers. Drivers may use this to bypass various
> checks during tuning.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
> Cc: Hai Pham <hai.pham.ud@renesas.com>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Sean Anderson <seanga2@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
> V2: Use bool var:1;
> ---
>  drivers/mmc/mmc-uclass.c | 8 +++++++-
>  include/mmc.h            | 1 +
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
> index 328456831dd..304bd5eaee2 100644
> --- a/drivers/mmc/mmc-uclass.c
> +++ b/drivers/mmc/mmc-uclass.c
> @@ -124,7 +124,13 @@ static int dm_mmc_execute_tuning(struct udevice *dev, uint opcode)
>  
>  int mmc_execute_tuning(struct mmc *mmc, uint opcode)
>  {
> -	return dm_mmc_execute_tuning(mmc->dev, opcode);
> +	int ret;
> +
> +	mmc->tuning = true;
> +	ret = dm_mmc_execute_tuning(mmc->dev, opcode);
> +	mmc->tuning = false;
> +
> +	return ret;
>  }
>  #endif
>  
> diff --git a/include/mmc.h b/include/mmc.h
> index afca123b386..5c1be5c5b1e 100644
> --- a/include/mmc.h
> +++ b/include/mmc.h
> @@ -736,6 +736,7 @@ struct mmc {
>  				  * accessing the boot partitions
>  				  */
>  	u32 quirks;
> +	bool tuning:1;
>  	bool hs400_tuning:1;
>  
>  	enum bus_mode user_speed_mode; /* input speed mode from user */

