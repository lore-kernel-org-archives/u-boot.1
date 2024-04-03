Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD87EC6FD1F
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 01:02:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 372BD88158;
	Wed,  3 Apr 2024 03:02:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="YbeD3kBg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EDB288158; Wed,  3 Apr 2024 03:02:56 +0200 (CEST)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E624F87947
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 03:02:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20240403010250epoutp04b3878e3e92a851f3f907fd8a8e5d9f80~Cn32hX9JR3111731117epoutp04j
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 01:02:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20240403010250epoutp04b3878e3e92a851f3f907fd8a8e5d9f80~Cn32hX9JR3111731117epoutp04j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1712106170;
 bh=VCNA6XLYzSj4sEuWAfNE5tFjNJE9j8xzdXs8z+cGzNc=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=YbeD3kBgNxG/kU1KhAJ9YO3upAWjykkPTxki5xkKfH35J92wb/d4yRo7FdLYVkHg5
 DXzgXumRU6E5aZHZznB07lE7xIKab74/a/6hooiqno5lZPhnl88P8dCKqTi6u1+T3R
 8nCcD1IIcJGwoSYAY+HWBQCBbSm0P722Es1Dh/gk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20240403010250epcas1p29baa320620efca2245648114322ab1fe~Cn32VkqHw2935129351epcas1p2C;
 Wed,  3 Apr 2024 01:02:50 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.144]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4V8RLd062zz4x9Q0; Wed,  3 Apr
 2024 01:02:49 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 41.6C.08627.8BAAC066; Wed,  3 Apr 2024 10:02:48 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20240403010248epcas1p4bc0f170bdb71b5ef6e374f56b7a89429~Cn31CT6K12428624286epcas1p4-;
 Wed,  3 Apr 2024 01:02:48 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240403010248epsmtrp208d2546c1fe0885c513bb378c99ceef7~Cn31BnynB0937409374epsmtrp2j;
 Wed,  3 Apr 2024 01:02:48 +0000 (GMT)
X-AuditID: b6c32a33-af9ff700000021b3-27-660caab8c850
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 17.12.08390.8BAAC066; Wed,  3 Apr 2024 10:02:48 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20240403010248epsmtip1193ece8d4dd6c6d1bb8423e65c022458~Cn30ky9hV1997819978epsmtip1n;
 Wed,  3 Apr 2024 01:02:48 +0000 (GMT)
Message-ID: <d590f409-5b31-435e-9ca2-9f4fd0db01d5@samsung.com>
Date: Wed, 3 Apr 2024 10:02:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: tmio: Check INFO1 for completion during DMA transfer
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Hai Pham <hai.pham.ud@renesas.com>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Paul Barker <paul.barker.ct@bp.renesas.com>, Peng
 Fan <peng.fan@nxp.com>, Sean Anderson <seanga2@gmail.com>, Tom Rini
 <trini@konsulko.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Language: en-US
From: Jaehoon Chung <jh80.chung@samsung.com>
In-Reply-To: <20240220083827.34473-1-marek.vasut+renesas@mailbox.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEJsWRmVeSWpSXmKPExsWy7bCmvu6OVTxpBms+WFhsX9XMbPG2udii
 deUdNos/J3+wWvxY9YXVYuu9CUwWUydtZrd4u7eT3eLr3s9sDpweK1/MZvfYOesuu8erA6vY
 Pc7e2cHosXP2PiaPA5PPsXpsfLeDyePbmYksARxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7x
 pmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QPcpKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yV
 UgtScgpMC/SKE3OLS/PS9fJSS6wMDQyMTIEKE7IznvfeYiqYIlRxc8oT9gbGT3xdjBwcEgIm
 EjPvunQxcnEICexglNj+7jNrFyMnkPOJUWL/Z16IxDdGiSeNn9lAEiANG77PYoRI7GWU2Dvz
 JzOE855R4vy5BrB2XgE7iVdTvjGC2CwCKhJX29+wQMQFJU7OfAJmiwrIS9y/NYMdxBYWCJBo
 +rmTHeQkEQF3iRd/wDYzC8xgkvi98B3YTGYBcYlbT+YzgdhsAjoS278dB7M5BVwl/q/rYoGo
 kZfY/nYO2EESAjs4JL5s28IIcbaLxPu+c1AvCEu8Or6FHcKWkvj8bi8bREMzo8TSJQdZIZwe
 Rol/DdehOowl9i+dzARyHrOApsT6XfoQ2/gk3n3tYYUEJK9ER5sQRLWKxKXXL5lg5t998p8V
 wvaQmL3hHRMktGYwSjxcvIZxAqPCLKSAmYXk0VlIHpqFsHkBI8sqRrHUguLc9NRkwwJDeHQn
 5+duYgQnXi3jHYyX5//TO8TIxMF4iFGCg1lJhPenN2eaEG9KYmVValF+fFFpTmrxIUZTYPRM
 ZJYSTc4Hpv68knhDE0sDEzMjYxMLQzNDJXHeM1fKUoUE0hNLUrNTUwtSi2D6mDg4pRqYqnd3
 2RjmXPP7Hzj7qUGOuPourRvbz9VczlA5FhgcMafh7PsvbLLS0qkP2zyevI5/kNfocFvXM/F6
 2+l3ejtiZuno1u2z1Fox7/AP5ZOy0x5vuH6h91Faf6FeW/Wiv5f7es5Nu7O4LVv5xd1PT+48
 vZY45fr7h0+nbqhU+K7bc3fi8v9zb+h7yXnWCleumSksUSFg5LvgxkRmntsmcw+cbeYo9kqy
 mbZSr0atK9fWbwWLRsLClc/PCfqXPNpSHZG6T13zf2b1bmfRjo1m4n0TVivpSKwS6as/uVzz
 i/EWh60/P8lY/25+cW/1MwX5+s2JOQ/e/Mnet+GmPrv42Y8OAZWTdSrnTV37deHm8p//nJRY
 ijMSDbWYi4oTAehxM79FBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LZdlhJTnfHKp40gyOLlCy2r2pmtnjbXGzR
 uvIOm8Wfkz9YLX6s+sJqsfXeBCaLqZM2s1u83dvJbvF172c2B06PlS9ms3vsnHWX3ePVgVXs
 Hmfv7GD02Dl7H5PHgcnnWD02vtvB5PHtzESWAI4oLpuU1JzMstQifbsEroznvbeYCqYIVdyc
 8oS9gfETXxcjJ4eEgInEhu+zGEFsIYHdjBKXGywg4lISn59OZeti5ACyhSUOHy7uYuQCKnnL
 KLH+xwpWkBpeATuJV1O+gfWyCKhIXG1/wwIRF5Q4OfMJmC0qIC9x/9YMdhBbWMBPYtGmB0wg
 M0UE3CVe/OEFmcksMItJ4uzX6SwQN7hIfH7yGMxmFhCXuPVkPhOIzSagI7H923Ewm1PAVeL/
 ui4WkDnMAuoS6+cJQZTLS2x/O4d5AqPQLCRXzEIyaRZCxywkHQsYWVYxSqYWFOem5xYbFhjl
 pZbrFSfmFpfmpesl5+duYgRHmJbWDsY9qz7oHWJk4mA8xCjBwawkwvvTmzNNiDclsbIqtSg/
 vqg0J7X4EKM0B4uSOO+3170pQgLpiSWp2ampBalFMFkmDk6pBqaiuoCc19bulZVdKhOcnSct
 Pd5st8Zhjs+jvz7ebBNiXFJCjs16dVcv9tvKtEqRw7PXzQz6Gvx/xfndHrbv1DqeehlUTyhZ
 KNJx4cny+Xs9LqxJ/VxqbSzQphuWnuiwfRXXj2wnta8rXu6ftitP94B2aKnGw+fv1fIPCGeY
 hn7ds3dD1CS9Yw6txaWWVRaH5MxKAnXfpG3Zn3dgyuzvASG5Zzf87yo+8PWl07ytLB97sp5/
 0dnzfml8kVOFde3D4qtT628KL/GYLBS23UumY/kDt0cOEWbeW1Wt5Cqv/G9+v+Rsak5eZ/WZ
 f1mRN7Uzc7d0u8b5hBiZXHkR1XBh+WHm20kpTNvnBty5l8VsZqzEUpyRaKjFXFScCAByN4Vd
 HwMAAA==
X-CMS-MailID: 20240403010248epcas1p4bc0f170bdb71b5ef6e374f56b7a89429
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240403010248epcas1p4bc0f170bdb71b5ef6e374f56b7a89429
References: <20240220083827.34473-1-marek.vasut+renesas@mailbox.org>
 <CGME20240403010248epcas1p4bc0f170bdb71b5ef6e374f56b7a89429@epcas1p4.samsung.com>
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
> In case a CRC error occurs during DMA transfer, the transfer completion
> flag is not set in TMIO_SD_DMA_INFO1 and the transfer would eventually
> time out. The timeout could be very long in case the transfer consists
> of a large amount of blocks, the base timeout is 10 seconds and every
> block adds 100 us more.
> 
> In case a CRC error does occur, a completion flag is set in a different
> register, TMIO_SD_INFO1. Use this other completion flag to detect DMA
> transfer ended and stop waiting for TMIO_SD_DMA_INFO1 completion flag.
> This reduces the lengthy timeout in case of an error. The unconditional
> check of TMIO_SD_DMA_INFO2 register for DMA related errors must not be
> skipped in any case to actually recognize the DMA error and report it.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> Tested-by: Paul Barker <paul.barker.ct@bp.renesas.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Sorry for late. Will apply to u-boot-mmc/master, Thanks!

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
>  drivers/mmc/tmio-common.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/tmio-common.c b/drivers/mmc/tmio-common.c
> index 890c496b535..719c4830bc3 100644
> --- a/drivers/mmc/tmio-common.c
> +++ b/drivers/mmc/tmio-common.c
> @@ -299,7 +299,13 @@ static int tmio_sd_dma_wait_for_irq(struct udevice *dev, u32 flag,
>  	struct tmio_sd_priv *priv = dev_get_priv(dev);
>  	long wait = 1000000 + 10 * blocks;
>  
> -	while (!(tmio_sd_readl(priv, TMIO_SD_DMA_INFO1) & flag)) {
> +	for (;;) {
> +		if (tmio_sd_readl(priv, TMIO_SD_DMA_INFO1) & flag)
> +			break;
> +
> +		if (tmio_sd_readl(priv, TMIO_SD_INFO1) & TMIO_SD_INFO1_CMP)
> +			break;
> +
>  		if (wait-- < 0) {
>  			dev_err(dev, "timeout during DMA\n");
>  			return -ETIMEDOUT;

