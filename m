Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6229DCD11C2
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 01:18:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5295881C8;
	Wed,  3 Apr 2024 03:18:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="sTGijEs+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85A9C881C7; Wed,  3 Apr 2024 03:18:18 +0200 (CEST)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 351EC8811A
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 03:18:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20240403011814epoutp02b3266bdcb31540fb26c091fc95802083~CoFTDYZjx0095200952epoutp02k
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 01:18:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20240403011814epoutp02b3266bdcb31540fb26c091fc95802083~CoFTDYZjx0095200952epoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1712107094;
 bh=Jrd/7CAu5NQSbbOooTzQH7IO/LC1XJYuCzBmmkJBUJY=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=sTGijEs+DZtyQ9kY6R7bwpepAGffhpFDD6egMqw+pmc6A4RulwfGa1IzMsUT3cwoI
 5CkKBUT4JhNsmxaTSIbdyi42eCcAeaR3uPK2QinscbxPjtfcMKd1cMWGRchI4mJpDm
 T4xTLxw8eWrfchFs477N8Y36L1Wz8W3jAiyy2xeM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTP id
 20240403011814epcas1p15fb85d60f4a0cd87068515b15cd4de2a~CoFS1Gxt80994609946epcas1p1X;
 Wed,  3 Apr 2024 01:18:14 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.133]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4V8RhN3kGpz4x9QM; Wed,  3 Apr
 2024 01:18:12 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
 90.ED.10076.45EAC066; Wed,  3 Apr 2024 10:18:12 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20240403011812epcas1p487b39de044af6e75cca9bc4b8c9b0ee6~CoFRJoocQ0547705477epcas1p4C;
 Wed,  3 Apr 2024 01:18:12 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240403011812epsmtrp262fcb0d15af2fe893b8044a322f3943e~CoFRI4Og61849118491epsmtrp2N;
 Wed,  3 Apr 2024 01:18:12 +0000 (GMT)
X-AuditID: b6c32a39-7edf87000000275c-20-660cae542c9e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 DE.04.08924.35EAC066; Wed,  3 Apr 2024 10:18:12 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20240403011811epsmtip14900350f39317e6755f885c556a93272~CoFQ2Selk2896128961epsmtip19;
 Wed,  3 Apr 2024 01:18:11 +0000 (GMT)
Message-ID: <e4ca5de9-eb6b-4ea4-a19a-df000d737ed4@samsung.com>
Date: Wed, 3 Apr 2024 10:18:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] mmc: renesas-sdhi: Do not access SCC during
 tuning in send_cmd callback
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>, Hai Pham
 <hai.pham.ud@renesas.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Peng
 Fan <peng.fan@nxp.com>, Sean Anderson <seanga2@gmail.com>, Tom Rini
 <trini@konsulko.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Language: en-US
From: Jaehoon Chung <jh80.chung@samsung.com>
In-Reply-To: <20240224223235.287889-3-marek.vasut+renesas@mailbox.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sb0wTZxz2vbter7qasyK86WastVkGGdCTlh0EyKJGGzFZo+6Li2KlB2Ut
 bddriSxZJDZjm+hGZ3BYcBWBD7QL26xKwaHARpiWLcxANilgSbqtYMootQiR6FpONr49v+d9
 nt/fl0BF13ExUWG0MhajxiDFN2K3fkyXZx7tfKVM7uwU011uO0pH7Cz9cccETq/cW+LRS+4n
 PPrmVD1CN3zp5dOR3s/4dLw3hr8tUHWEm/iqbuckXzXb5+arfpnwAVV30x1E1XfxV57q+zkf
 olocdmBq4pi+QMdotIxFwhhLTdoKY3mhtPhIyd4SZa6cyqTy6LekEqOmkimU7jukztxfYUj0
 J5VUaQy2BKXWsKw0u6jAYrJZGYnOxFoLpYxZazArzVmsppK1GcuzjIw1n5LLdysTwpN6XSQW
 5Juj8PR4cAKrASsp54CAgKQCxr0eNIlFpA/Ap9EEvzGBFwC86rrD54JFAO//OQ7WHGebH+Hc
 Qy+AN3y3MS74B0DX6DMkqRKSRbB70JuwEwRGyqBj3sLRW+C9yyEsibeRO+Cj8UZ+Em8lGTjW
 1Ion5SnkARheESZTomQjAn9qbV7Vo2QaHA+5VtPj5Juwa3FoFQvI/dDr8PM4zQ7YFWlGk2ZI
 +gj4SWQa47reBz8P1L2cYCucHbrB57AYxuZ6cc5gB7C9rZ/HBecBfF7zO86pcuDd9otIsj2U
 TIff9mRz1TbDufh5XpKGpBB+Wivi1DL44PEMspZ/MvSCx2EVnJxverm5MQBnY11IPZA41y3G
 uW5Q57qBnP9XvgowN0hlzGxlOcNSZuV/5y41VV4Hq583I88HvorMZw0AhAADABKoNEW4XCwo
 Ewm1muoPGYupxGIzMOwAUCau40DF20pNid9vtJZQijy5Ind3joKmcilpmnB4tIoRkeUaK6Nn
 GDNjWfMhhEBcgwgYucDmP5U+1v51y4xeWBXMqUqRtefuzPhBqBQM25fxZ/mjly74UzdNecIn
 JUVPPBm1/r9PX7AeOSU+ey322h8y3tMDZc17eg4PHazvEdqRQf2DF4TXUx5O/SswdCn76Mir
 t+PahmPha6K6+1ONr2+YGzqo3uCY8qw8DmDqKw+9FQ1xR02JQr4QPde30198eXr05vJmRzTo
 HsQyz9x9h2yxWrcsOU4cbl2q7ehs8VK7CiwL1dHCwPbQu1+4rixSwjPynzHXie/apiOGW+89
 P77X5lS+MSeW4eiugPyjtO35/bKFPccNHwTe/w2v8wbt1SMjltBMm47Z9I3t4eChfinG6jRU
 BmphNf8CkFOLFEUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LZdlhJTjdkHU+awbYmZovtq5qZLd42F1u0
 rrzDZvHn5A9Wix+rvrBabL03gcli6qTN7BZv93ayW3zd+5nNgdNj5YvZ7B47Z91l93h1YBW7
 x9k7Oxg9ds7ex+RxYPI5Vo+N73YweXw7M5ElgCOKyyYlNSezLLVI3y6BK+Pt5wfsBR8lKm49
 uMPSwPhHpIuRk0NCwESiac59ti5GLg4hgd2MEpfvrmeBSEhJfH46FSjBAWQLSxw+XAxR85ZR
 YvXnm6wgNbwCdhI7j25mB6lhEVCRmPihCCIsKHFy5hOwMaIC8hL3b81gB7GFBVIl9iy8zwJS
 LiLgLvHiDy/ISGaBWUwS/9qfQd3QyCjxdfNyJpAGZgFxiVtP5oPZbAI6Etu/HQezOQXcJDZP
 PM0KMohZQF1i/TwhiHJ5ie1v5zBPYBSaheSMWUgmzULomIWkYwEjyypGydSC4tz03GLDAsO8
 1HK94sTc4tK8dL3k/NxNjOAY09Lcwbh91Qe9Q4xMHIyHGCU4mJVEeH96c6YJ8aYkVlalFuXH
 F5XmpBYfYpTmYFES5xV/0ZsiJJCeWJKanZpakFoEk2Xi4JRqYJpVV3ZgX7Heq925Wq+5Zt12
 ULQp9WSRb/I75ro0oM7T1VQn8V/m96QfRj0T3h1X53Ar/xa4VMXi/83fQv//sX3isOnX6WBc
 cGb5Ia1fLP8dY80XeXtdTrwZzzH1RdKMX2/f9PKqrM/bJT6DMas47p+21vbPxs+F5gaevDHt
 1MH7p947OkRmpbz7u1Dzp8UkVxFjy2OSn/5U28iulwru/j3z1W3JjYXXvFN+2FTbdy/eE+y6
 UvZoDvsj80+tOySyub/f+S+58MrKb1dmcFsfuPTDR3LRvmXTlzzs19hW6bI/2s80W0Vtbf0T
 sXn6B5eEtjNc4c1u1bRrtjcp+B8Rmf16Ev89plcZgV932n8yiFBiKc5INNRiLipOBACSni8H
 IAMAAA==
X-CMS-MailID: 20240403011812epcas1p487b39de044af6e75cca9bc4b8c9b0ee6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240403011812epcas1p487b39de044af6e75cca9bc4b8c9b0ee6
References: <20240224223235.287889-1-marek.vasut+renesas@mailbox.org>
 <20240224223235.287889-3-marek.vasut+renesas@mailbox.org>
 <CGME20240403011812epcas1p487b39de044af6e75cca9bc4b8c9b0ee6@epcas1p4.samsung.com>
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
> Do not access SCC when sending commands during tuning operation as that
> will disrupt the tuning operation. The tuning operation is adjusting the
> SCC settings itself in execute_tuning callback.
> 
> When renesas_sdhi_execute_tuning() is called by the MMC core code, a loop
> which consists of renesas_sdhi_prepare_tuning(), mmc_send_tuning() and
> renesas_sdhi_compare_scc_data() iterates over each SCC tuning tap.
> 
> The renesas_sdhi_prepare_tuning() configures the SCC tuning tap number into
> hardware, mmc_send_tuning() triggers transfer of tuning block which depends
> on the bus mode for which the bus is currently being tuned, this information
> is supplied by the MMC core code, and finally renesas_sdhi_compare_scc_data()
> tests the received tuning block for validity.
> 
> Because renesas_sdhi_prepare_tuning() configures the SCC tuning tap into
> the hardware to fit the tuning operation, mmc_send_tuning() which triggers
> command transfer using renesas_sdhi_send_cmd() must not manipulate with
> the SCC in any way. Currently renesas_sdhi_send_cmd() does unconditionally
> call renesas_sdhi_check_scc_error(), which may adjust the SCC tuning tap
> position by writing RENESAS_SDHI_SCC_TAPSET, which would overwrite the
> required tuning configuration set by renesas_sdhi_prepare_tuning() and
> disrupt the tuning operation.
> 
> Fix this by skipping the renesas_sdhi_check_scc_error() call in case the
> MMC subsystem is in tuning state. This way, the SCC settings are left
> unmodified by command transfer during tuning operation.
> 
> Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> Tested-by: Paul Barker <paul.barker.ct@bp.renesas.com>
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
> V2: Add RB/TB from Paul
> ---
>  drivers/mmc/renesas-sdhi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/renesas-sdhi.c b/drivers/mmc/renesas-sdhi.c
> index 29a742f404e..c4d0733b621 100644
> --- a/drivers/mmc/renesas-sdhi.c
> +++ b/drivers/mmc/renesas-sdhi.c
> @@ -798,9 +798,12 @@ static int renesas_sdhi_send_cmd(struct udevice *dev, struct mmc_cmd *cmd,
>  #if CONFIG_IS_ENABLED(MMC_UHS_SUPPORT) || \
>      CONFIG_IS_ENABLED(MMC_HS200_SUPPORT) || \
>      CONFIG_IS_ENABLED(MMC_HS400_SUPPORT)
> +	struct mmc_uclass_priv *upriv = dev_get_uclass_priv(dev);
>  	struct tmio_sd_priv *priv = dev_get_priv(dev);
> +	struct mmc *mmc = upriv->mmc;
>  
> -	renesas_sdhi_check_scc_error(dev);
> +	if (!mmc->tuning)
> +		renesas_sdhi_check_scc_error(dev);
>  
>  	if (cmd->cmdidx == MMC_CMD_SEND_STATUS)
>  		renesas_sdhi_adjust_hs400_mode_enable(priv);

