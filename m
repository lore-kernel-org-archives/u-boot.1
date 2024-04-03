Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22610CD11C2
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 01:05:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FD6187947;
	Wed,  3 Apr 2024 03:05:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="ZNzb8SQr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B2A5879CC; Wed,  3 Apr 2024 03:05:07 +0200 (CEST)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 827BE8787C
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 03:05:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20240403010502epoutp036cb53272d88950e9e36d5aa7b302d2ea~Cn5xUSM_g3008130081epoutp03R
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 01:05:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20240403010502epoutp036cb53272d88950e9e36d5aa7b302d2ea~Cn5xUSM_g3008130081epoutp03R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1712106302;
 bh=JW76TfiLYcAm9E5bfJw4lFQ1FrxLO2SiDTf6nj37eeU=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=ZNzb8SQrHBseWmmKxdejn3nVfxyrpiwLwZJfnjoHiP7ByxDPZRIj4J2Ym0RQIea7v
 pW28ZFq+oIjkMZeTl4b1AxQHHvXvhDXJ5CtJ5+iCzVd11fopko7cdbktVxJCpxTgtI
 F1u3wP1ia8Km80xwr1mJ+lZBWU+UrGsLK4DUCpus=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTP id
 20240403010501epcas1p4ba5b85c7450d82c98e6e1a8391504be6~Cn5xGDEi12491824918epcas1p4v;
 Wed,  3 Apr 2024 01:05:01 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.234]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4V8RP853gzz4x9Q9; Wed,  3 Apr
 2024 01:05:00 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 60.AE.10158.C3BAC066; Wed,  3 Apr 2024 10:05:00 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20240403010500epcas1p4d80ecd23a24e0fee4f483575cdf08818~Cn5vt2tNm2491824918epcas1p4j;
 Wed,  3 Apr 2024 01:05:00 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240403010500epsmtrp2bf9e9592939cf6fc2e4f029c377dd25d~Cn5vtNnPs1062310623epsmtrp2s;
 Wed,  3 Apr 2024 01:05:00 +0000 (GMT)
X-AuditID: b6c32a38-8e1ff700000027ae-a6-660cab3c3a0c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 51.C2.08924.C3BAC066; Wed,  3 Apr 2024 10:05:00 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20240403010500epsmtip1efa3e8a4974cbe44764724e429d01d3a~Cn5veX5xn1903819038epsmtip1a;
 Wed,  3 Apr 2024 01:05:00 +0000 (GMT)
Message-ID: <39525ef4-3549-458b-9163-ee43e65e6981@samsung.com>
Date: Wed, 3 Apr 2024 10:05:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] mmc: Convert hs400_tuning flag from u8 to bool
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Hai Pham <hai.pham.ud@renesas.com>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Paul Barker <paul.barker.ct@bp.renesas.com>, Peng
 Fan <peng.fan@nxp.com>, Sean Anderson <seanga2@gmail.com>, Tom Rini
 <trini@konsulko.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Language: en-US
From: Jaehoon Chung <jh80.chung@samsung.com>
In-Reply-To: <20240224223235.287889-1-marek.vasut+renesas@mailbox.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIJsWRmVeSWpSXmKPExsWy7bCmga7Nap40gylLVS22r2pmtnjbXGzR
 uvIOm8Wfkz9YLX6s+sJqsfXeBCaLqZM2s1u83dvJbvF172c2B06PlS9ms3vsnHWX3ePVgVXs
 Hmfv7GD02Dl7H5PHgcnnWD02vtvB5PHtzESWAI6obJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4
 UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoPuUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZK
 qQUpOQWmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZ0/e8ZCn4yFfxYa1kA+Mv7i5GTg4JAROJ
 I/d3MHYxcnEICexglDiz7hMLhPOJUeLTmQ9QmW+MEpeaTrLDtFx88g0qsZdRYt3CP0wgCSGB
 94wSM2/zgti8AnYSy9//ZAaxWQRUJGZsn8gGEReUODnzCQuILSogL3H/1gywocICXhLL2g8C
 DeXgEBFwl3jxhxdkPrPADCaJ3wvfsYLUMAuIS9x6Mh9sF5uAjsT2b8eZQOo5BdwkHrUIQpTI
 S2x/O4cZpFdCYAeHxN9dL5kgjnaR2HTzMCuELSzx6vgWqGekJD6/28sG0dDMKLF0yUFWCKeH
 UeJfw3U2iCpjif1LJ4NtYxbQlFi/Sx9iG5/Eu689rCBhCQFeiY42IYhqFYlLr2H2SkncffIf
 aq+HxK7pH1khATeTUeLWpY1MExgVZiGFyywkf85C8tAshM0LGFlWMYqlFhTnpqcWGxaYwGM7
 OT93EyM47WpZ7GCc+/aD3iFGJg7GQ4wSHMxKIrw/vTnThHhTEiurUovy44tKc1KLDzGaAmNn
 IrOUaHI+MPHnlcQbmlgamJgZGZtYGJoZKonznrlSliokkJ5YkpqdmlqQWgTTx8TBKdXAlHBt
 cvqaPgHmj6ICuT2ck05ntxtZuId2rTeMzD3T3KC44mms6krrX7Wnz2keXLl78qJtF5pcTRet
 8Vy3uHzLacu1yu0O266UMfftnneGq6s16nEDQ2v0CkaLd55Xdr01N5o0j+u97JZbno0K9vmx
 S6O9pOY1lZuL3ldKbvjaFHnXJ+broTe/fy173vP8x5K7dz5ayajLO/zYV311s9q2ZwyndBMv
 C73ke53xZ4dNyZG97ybdEtOMqiqLO/b1+NG/kkHc97b92he18O61nADbzGuqvKtF3qxxmVVc
 J5mWM+Pxkc1PzrNGVsS+yr3HENDI1Cmxcek0U0GmbLaEzEzRNxq7rbdPkJbTTdfTSxCepsRS
 nJFoqMVcVJwIAInK1KhEBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42LZdlhJTtdmNU+awYYXohbbVzUzW7xtLrZo
 XXmHzeLPyR+sFj9WfWG12HpvApPF1Emb2S3e7u1kt/i69zObA6fHyhez2T12zrrL7vHqwCp2
 j7N3djB67Jy9j8njwORzrB4b3+1g8vh2ZiJLAEcUl01Kak5mWWqRvl0CV8b0PS9ZCj7yVXxY
 K9nA+Iu7i5GTQ0LAROLik2+MXYxcHEICuxklem80M0MkpCQ+P53K1sXIAWQLSxw+XAxR85ZR
 YtWlCywgNbwCdhLL3/8Eq2cRUJGYsX0iG0RcUOLkzCdgNaIC8hL3b81gB7GFBbwklrUfZASZ
 KSLgLvHiDy/ITGaBWUwSZ79OB6sXEnCVuDzrBdgcZgFxiVtP5jOB2GwCOhLbvx1nAunlFHCT
 eNQiCGIyC6hLrJ8nBFEtL7H97RzmCYxCs5AcMQvJoFkIHbOQdCxgZFnFKJlaUJybnltsWGCY
 l1quV5yYW1yal66XnJ+7iREcX1qaOxi3r/qgd4iRiYPxEKMEB7OSCO9Pb840Id6UxMqq1KL8
 +KLSnNTiQ4zSHCxK4rziL3pThATSE0tSs1NTC1KLYLJMHJxSDUwr3v9/coPpf96teZOfG1Ym
 ZN+dvvV3c1Azr3DbjrkvD+8x4iqqlj3NHqMt9GuS7q3fpz8X2XR1HAhZZCz+86ZX7uzXop94
 422T+RS4o15mif3ZoORaJhcZuLTj11bH55uTgx5fupa7rqP0y7zOjEXLpuvOs5xkxzWjZ/sJ
 U/uc7GX55s+rfhXYyMnvKbiaKqLz4OtB/zqJao3tx+/K68xfwLTzzIZP4l7KMRfby2ZtPHh/
 +dR8Nlmuc+xHrFYdm57/PndvocLBqrbVrd6Hs9+vdPz976TUw8SD3d+2c/HuyrVwy1p0JTT5
 xgGGBUovMh792nZazfTbr/9TNDb/eie18Hm1xxbOm4vE1itwfp+/SomlOCPRUIu5qDgRAJkt
 LVceAwAA
X-CMS-MailID: 20240403010500epcas1p4d80ecd23a24e0fee4f483575cdf08818
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240403010500epcas1p4d80ecd23a24e0fee4f483575cdf08818
References: <20240224223235.287889-1-marek.vasut+renesas@mailbox.org>
 <CGME20240403010500epcas1p4d80ecd23a24e0fee4f483575cdf08818@epcas1p4.samsung.com>
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
> This hs400_tuning is a flag, make it bool. No functional change.
> This will be useful in the following patch, which adds another
> more generic flag, where the compiler can better use the space
> now reserved for the u8 to store more flags in it.
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
>  drivers/mmc/mmc.c | 4 ++--
>  include/mmc.h     | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
> index 83f9ae8bb7d..07d87c993a6 100644
> --- a/drivers/mmc/mmc.c
> +++ b/drivers/mmc/mmc.c
> @@ -2027,9 +2027,9 @@ static int mmc_select_hs400(struct mmc *mmc)
>  	mmc_set_clock(mmc, mmc->tran_speed, false);
>  
>  	/* execute tuning if needed */
> -	mmc->hs400_tuning = 1;
> +	mmc->hs400_tuning = true;
>  	err = mmc_execute_tuning(mmc, MMC_CMD_SEND_TUNING_BLOCK_HS200);
> -	mmc->hs400_tuning = 0;
> +	mmc->hs400_tuning = false;
>  	if (err) {
>  		debug("tuning failed\n");
>  		return err;
> diff --git a/include/mmc.h b/include/mmc.h
> index 2b9a6aa8ee0..afca123b386 100644
> --- a/include/mmc.h
> +++ b/include/mmc.h
> @@ -736,7 +736,7 @@ struct mmc {
>  				  * accessing the boot partitions
>  				  */
>  	u32 quirks;
> -	u8 hs400_tuning;
> +	bool hs400_tuning:1;
>  
>  	enum bus_mode user_speed_mode; /* input speed mode from user */
>  };

