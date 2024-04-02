Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B71CD1284
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 23:53:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D4DE88195;
	Wed,  3 Apr 2024 01:53:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="myBPps9r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A665088199; Wed,  3 Apr 2024 01:53:49 +0200 (CEST)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADEE48818F
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 01:53:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20240402235339epoutp032107c10c167d96f7cfd07f41a8279da7~Cm7cepbsh2255422554epoutp03b
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 23:53:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20240402235339epoutp032107c10c167d96f7cfd07f41a8279da7~Cm7cepbsh2255422554epoutp03b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1712102019;
 bh=VWq6p82CkW05TUbImcSNwx6MxT2nvWGkZ+JlbhH4yA4=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=myBPps9r3YfbFdb7H8+5K2xYTuapZekhYMbxV7WLqYlSB3RIxMrp83mXSIhyQAUUP
 /n2l8YXuE7eqGkw5JlxLbzaqqX2Sq3/XyHKUZIrhagPUIFpwIBVSY3BfxTx8dGTqX7
 dvvdS7Lno5wrA5xfqclJD+691X6mE7idbxT7offU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20240402235338epcas1p3927d8fd8a33b2457b2deb70a64537819~Cm7cRiI3E1710617106epcas1p32;
 Tue,  2 Apr 2024 23:53:38 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.38.234]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4V8Ppn6XKSz4x9QH; Tue,  2 Apr
 2024 23:53:37 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
 epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 44.60.19431.18A9C066; Wed,  3 Apr 2024 08:53:37 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20240402235337epcas1p4fce814a4edf451277db5040e6edfa403~Cm7ap0WO81519715197epcas1p4S;
 Tue,  2 Apr 2024 23:53:37 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240402235337epsmtrp1390f478b5f83a6678ec76194e68986b6~Cm7apKKrM3232932329epsmtrp1P;
 Tue,  2 Apr 2024 23:53:37 +0000 (GMT)
X-AuditID: b6c32a4c-1d1ff70000004be7-c9-660c9a81ab04
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 29.2D.08924.18A9C066; Wed,  3 Apr 2024 08:53:37 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20240402235336epsmtip17e2e1a817a14485e82b5b619fd45cc87~Cm7aYwUtt0404704047epsmtip1r;
 Tue,  2 Apr 2024 23:53:36 +0000 (GMT)
Message-ID: <c6f554f2-6d59-4b9c-b26f-4231a1ba644c@samsung.com>
Date: Wed, 3 Apr 2024 08:53:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: dw_mmc: Don't return error if data busy timeout
To: Yang Xiwen <forbidden405@outlook.com>, Peng Fan <peng.fan@nxp.com>
Cc: u-boot@lists.denx.de
Content-Language: en-US
From: Jaehoon Chung <jh80.chung@samsung.com>
In-Reply-To: <SEZPR06MB6959712A2AFE3C6C9B49FC2296792@SEZPR06MB6959.apcprd06.prod.outlook.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42LZdlhTT7dxFk+awb6Vhhb/bu5ht/ix6gur
 xdu9newOzB5n7+xg9Nj4bgeTx+bXL5gDmKOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwM
 dQ0tLcyVFPISc1NtlVx8AnTdMnOANikplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1Jy
 CkwL9IoTc4tL89L18lJLrAwNDIxMgQoTsjM2NlxgLJjOWbHnxWK2BsZ17F2MnBwSAiYS988d
 Yupi5OIQEtjDKDGxfzkLhPOJUeLJ311QzjdGiZ6GTcwwLWf2LmCDSOxllLh16RQrhPOeUeLk
 y5msIFW8AnYSE88+BrNZBFQkOjY+YIGIC0qcnPkEzBYVkJe4f2sG2CHCAp4Sy+9NAtsgIuAm
 sevidjCbWUBCYsmh+6wQtrjErSfzmUBsNgEdie3fjoPZnAKxEv9eN7NB1MhLbH87hxnkIAmB
 R+wSK5ZvAkpwADkuEse/JUN8ICzx6vgWaABISbzsb2OHqG9mlFi65CArhNPDKPGv4TobRJWx
 xP6lk5lABjELaEqs36UPsYxP4t3XHlaI+bwSHW1CENUqEpdev2SCmX/3yX9WCNtDYv6hH8yQ
 wNoADKwvj5kmMCrMQgqXWUj+nIXkn1kImxcwsqxilEotKM5NT002LDDUzUsth8d5cn7uJkZw
 WtTy2cH4ff1fvUOMTByMhxglOJiVRHh/enOmCfGmJFZWpRblxxeV5qQWH2I0BcbQRGYp0eR8
 YGLOK4k3NLE0MDEzMjaxMDQzVBLnPXOlLFVIID2xJDU7NbUgtQimj4mDU6qBqfDuRLHS1ugD
 v+Rsaj48me7hmzxP/dTCyQk1Byz+z/PQS7/UdMKjJq9bkWm1qPXF69cTDiiEqghL2n5P5zVX
 PndEwmWDmxovK/PCObP5dI+Etp94+Hhy9PQ/3232rzNj3XDO4k6uwTHJtWefspbuDTU3urtp
 bfKE+ftOaX/ePHnRtyvGT6SNpT1D/UXMjkbVnQi+0pHdv7QlaOXP4Ow83zm5TjPaFUr1V/l8
 Zc85wRAT9n6/Sx37igf5l3ykjMK/S5yZaib/7a9NUbapeqvx76iELy5pH2SZ3/jOzrUw+NEv
 tFnCMuH0ZdZMo/9HzkcFLlxtUPBVv7v+QM7jWxeZg49uW/HARszbWiM9r2KxEktxRqKhFnNR
 cSIAfl//yhQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsWy7bCSnG7jLJ40gwOzWS3+3dzDbvFj1RdW
 i7d7O9kdmD3O3tnB6LHx3Q4mj82vXzAHMEdx2aSk5mSWpRbp2yVwZWxsuMBYMJ2zYs+LxWwN
 jOvYuxg5OSQETCTO7F3A1sXIxSEksJtR4tieYywQCSmJz0+nAiU4gGxhicOHi0HCQgJvGSVe
 ncsFsXkF7CQmnn3MCmKzCKhIdGx8wAIRF5Q4OfMJmC0qIC9x/9YMsF3CAp4Sy+9NYgaxRQTc
 JHZd3A5mMwtISCw5dJ8VYn6MxIwFN1kg4uISt57MZwKx2QR0JLZ/Ow5mcwrESvx73Qx2GrOA
 usT6eUIQ5fIS29/OYZ7AKDQLyRWzkEyahdAxC0nHAkaWVYySqQXFuem5xYYFhnmp5XrFibnF
 pXnpesn5uZsYwUGvpbmDcfuqD3qHGJk4GA8xSnAwK4nw/vTmTBPiTUmsrEotyo8vKs1JLT7E
 KM3BoiTOK/6iN0VIID2xJDU7NbUgtQgmy8TBKdXAFNq9zTNa78BUE+dP73Z9nh0+ZdKdt2wx
 f9091phK2qdzv5FQvnNOJ/NSyA/1if66lc6vmvbH8pkcut+wwdi55f5jnuLpheu7TwS+Nfq2
 ImDlxg+327/48Z6/1JUbqqzHrc598sHE1T/kbn+89NcmQ829L6/01T+pxq8v7rxVjRfbVi30
 997mhIh9Nyqbj7VvEOBi/nd4g9E5rfy0zTca3l6sz3y492tmUffC1peRZunXHFij5mnYSeUm
 Z9QYfrl9X8t/1iX2Vf/4dW9OEl05yX7DsUfil+xOZ//feKbm7erDuvV/P0SuDN36beoPnmbx
 T1uZA5vSGKOnioZZTGk5MT3mlllGefTvaXVTAh/fC1ViKc5INNRiLipOBAB1vOzW6QIAAA==
X-CMS-MailID: 20240402235337epcas1p4fce814a4edf451277db5040e6edfa403
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240402235337epcas1p4fce814a4edf451277db5040e6edfa403
References: <SEZPR06MB6959712A2AFE3C6C9B49FC2296792@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <CGME20240402235337epcas1p4fce814a4edf451277db5040e6edfa403@epcas1p4.samsung.com>
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

Hi,

On 1/26/24 12:29, Yang Xiwen wrote:
> As described in [1], some poor hardware or cards would fail to release
> the bus and keep driving data lines low. Ignore it and send the next cmd
> directly seems okay for most cases.

I didn't test on my board. But it's not same with below patch.
Did you check all cases?

Best Regards,
Jaehoon Chung

> 
> [1]: https://patchwork.kernel.org/project/linux-mmc/patch/1424458179-5456-1-git-send-email-dianders@chromium.org/
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  drivers/mmc/dw_mmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
> index 400066fa99..e103664145 100644
> --- a/drivers/mmc/dw_mmc.c
> +++ b/drivers/mmc/dw_mmc.c
> @@ -262,8 +262,8 @@ static int dwmci_send_cmd(struct mmc *mmc, struct mmc_cmd *cmd,
>  
>  	while (dwmci_readl(host, DWMCI_STATUS) & DWMCI_BUSY) {
>  		if (get_timer(start) > timeout) {
> -			debug("%s: Timeout on data busy\n", __func__);
> -			return -ETIMEDOUT;
> +			debug("%s: Timeout on data busy, continue anyway\n", __func__);
> +			break;
>  		}
>  	}
>  

