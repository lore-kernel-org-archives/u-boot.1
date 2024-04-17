Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D789DC4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 11:37:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AC6C88475;
	Wed, 17 Apr 2024 13:37:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="G+OH42pL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7708488475; Wed, 17 Apr 2024 13:37:11 +0200 (CEST)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B060788442
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 13:37:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20240417113659epoutp04451d0092aada225de0443d99e68f133e~HDjiLKypq2879328793epoutp04V
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 11:36:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20240417113659epoutp04451d0092aada225de0443d99e68f133e~HDjiLKypq2879328793epoutp04V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1713353819;
 bh=grjyb6zGYw2DIhA1C54GG91djExlNBtCRXTcaOBWyPE=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=G+OH42pLYx7S3C+SX1jJuyQsQuTHxAeuKjVglo7CoMUys9Zc+CffPsokgDayvh4tM
 R2WXNTMD+EqBnXsjVw+9qvneYj/wUtasM6RdG4HCgpIqy6q0t1gb35P1GI1iGkcpyW
 1MuWAH0kYYPBVJoqJjB3NlnZt1elWM5grH9c6vkU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTP id
 20240417113658epcas1p42d5d9546601fd684c2e10e0e439bca30~HDjhRNe0i2343823438epcas1p4n;
 Wed, 17 Apr 2024 11:36:58 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.236]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4VKJls20Dcz4x9Pv; Wed, 17 Apr
 2024 11:36:57 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 9D.38.09696.954BF166; Wed, 17 Apr 2024 20:36:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
 20240417113656epcas1p3baca249c31247bbedf276860533ce4d5~HDjfiU6XI1802318023epcas1p3L;
 Wed, 17 Apr 2024 11:36:56 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240417113656epsmtrp2c65d5550dc106c4740bccc91e64f923b~HDjfhpsIu2046720467epsmtrp2F;
 Wed, 17 Apr 2024 11:36:56 +0000 (GMT)
X-AuditID: b6c32a36-553ff700000025e0-bf-661fb459231b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 34.16.07541.854BF166; Wed, 17 Apr 2024 20:36:56 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20240417113656epsmtip16fa4ba9ef4a11743fb2974b0037cb53f~HDjfRyPoo2529025290epsmtip1B;
 Wed, 17 Apr 2024 11:36:56 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Judith Mendez'" <jm@ti.com>, "'Peng Fan'" <peng.fan@nxp.com>, "'Tom
 Rini'" <trini@konsulko.com>
Cc: "'Nitin Yadav'" <n-yadav@ti.com>, "'Simon Glass'" <sjg@chromium.org>,
 <u-boot@lists.denx.de>
In-Reply-To: <20240415212747.2678974-5-jm@ti.com>
Subject: RE: [PATCH 4/5] mmc: am654_sdhci: Set ENDLL=1 for DDR52 mode
Date: Wed, 17 Apr 2024 20:36:55 +0900
Message-ID: <01fe01da90bb$8d19e6e0$a74db4a0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG5/NRqE0+DtqCkK0jpqvLeJwVynAHQrFFSAhxp2ayxjhScAA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCJsWRmVeSWpSXmKPExsWy7bCmvm7kFvk0g8mfeC0+fci0+Nx0hNni
 x6ovrBbftmxjtJg6aTO7xdu9newObB6zGy6yeLw6sIrd4+ydHYweG9/tYPI4fmM7UwBrVLZN
 RmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtAFSgpliTml
 QKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwC0wK94sTc4tK8dL281BIrQwMDI1OgwoTsjJlv
 bjIXbOSt2H9+GWsD43+uLkZODgkBE4nnm2YzdzFycQgJ7GCUeLZ2FxuE84lRYsPaVSwgVUIC
 3xglbr6Wg+k48fEYO0TRXkaJ7r5DjBDOS0aJBf0nmECq2AT0JP4vWsgMYosIpEu0b3sFZjML
 JEm8urAXrIZTwFCiYd1TNhBbWMBV4sLlSWBxFgFViQOf34Nt5hWwlHi67yGULShxcuYTFog5
 8hLb385hhrhIQeLn02WsELucJF7M3MMGUSMiMbuzDew3CYFeDon23YuYIBpcJM7sPMsGYQtL
 vDq+hR3ClpL4/G4vG0RDM6PE0iUHWSGcHkaJfw3XoTqMJfYvnQw0iQNohabE+l36ENv4JN59
 7WEFCUsI8Ep0tAlBVKtIXHr9kglm/t0n/1khbA+JS4dOM01gVJyF5LdZSH6bheSHWQjLFjCy
 rGIUSy0ozk1PLTYsMIJHd3J+7iZGcPLUMtvBOOntB71DjEwcjIcYJTiYlUR4W4Rl04R4UxIr
 q1KL8uOLSnNSiw8xmgJDeyKzlGhyPjB955XEG5pYGpiYGRmbWBiaGSqJ8565UpYqJJCeWJKa
 nZpakFoE08fEwSnVwMTcYhh0I6rLk/1gvF/El3OxzJvvZ3Ms4Vgd96ozuHGx/HsxlqQlD50i
 XdW3f+Xnl47637NA41XPkft/+Iz8L5p/ux7JtXpnJX9M96z3rh2Ha3kKpoflRt4sSdpxS9Jq
 5vtSh7g5n97sNq3U6g7YtMg/WXPj4peCe/rPfPbYfsVvPaPYga6sJPXgFWH5+ycfcmTVPn9l
 ygmx9WHLj5psDPv/cmKHQp3PlcUsxgwPGhIL3jbliH1Xefv5j01BiWrs+75JPx/f6f011ZWp
 Qk/B1Sl7xlWXiVP2qy+6vWrBwqVZLVGpNuFW3iuO+/J895r/3Jb/C+P5jZ+mzD1xSGxDxq6N
 nhN3XpY06cxeE/mAt1+JpTgj0VCLuag4EQC7GSnZJwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsWy7bCSnG7EFvk0g96lAhafPmRafG46wmzx
 Y9UXVotvW7YxWkydtJnd4u3eTnYHNo/ZDRdZPF4dWMXucfbODkaPje92MHkcv7GdKYA1issm
 JTUnsyy1SN8ugStj5pubzAUbeSv2n1/G2sD4n6uLkZNDQsBE4sTHY+xdjFwcQgK7GSV+vT/L
 BpGQkvj8dCqQzQFkC0scPlwMUfOcUeJl0052kBo2AT2J/4sWMoPUiAhkSnTOiwUJMwukSHz9
 M5UVon45o8SaBf+YQBKcAoYSDeuegs0XFnCVuHB5ElicRUBV4sDn9ywgNq+ApcTTfQ+hbEGJ
 kzOfsEAM1ZZ4evMplC0vsf3tHGaIOxUkfj5dxgpiiwg4SbyYuYcNokZEYnZnG/MERuFZSEbN
 QjJqFpJRs5C0LGBkWcUomVpQnJuem2xYYJiXWq5XnJhbXJqXrpecn7uJERxDWho7GO/N/6d3
 iJGJg/EQowQHs5IIb4uwbJoQb0piZVVqUX58UWlOavEhRmkOFiVxXsMZs1OEBNITS1KzU1ML
 UotgskwcnFINTHWlt+yXGXFl/t/cYDvp4LUbzkxmBkLeRflzzvFkeD32/eM847XVoWqG0+Z+
 awSCxZkPbWCRlG/NPPF9i+YMwbCJ+9g2fWFhe902c4b6iarrp1xMvaP9Xm/9mbP0qcn8wgkM
 s3NFfnf07vz6quX4o6lNxUIzP/LM+rlbnnXyxcMP2qrf/4vqXNNS2qa/X+nqJ375kscWlxS3
 FakvPdGr/FpMSI13m8rJOcYfpaNzrJwWZOxk/nYvUEsjhv3/QYm6vV6By6Ywm2feW2QkzLdu
 ctk6geSlQm/VOS89CF0VpayRf/yJ24VF1e8TJNVPGp5K+DjTfnmz4fzLnjtapF5XPpURWFVq
 48H20T+6PSthphJLcUaioRZzUXEiAFV924IQAwAA
X-CMS-MailID: 20240417113656epcas1p3baca249c31247bbedf276860533ce4d5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240415212758epcas1p3febcc8e7dc5522365087bf80ba22b573
References: <20240415212747.2678974-1-jm@ti.com>
 <CGME20240415212758epcas1p3febcc8e7dc5522365087bf80ba22b573@epcas1p3.samsung.com>
 <20240415212747.2678974-5-jm@ti.com>
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



> -----Original Message-----
> From: Judith Mendez <jm@ti.com>
> Sent: Tuesday, April 16, 2024 6:28 AM
> To: Peng Fan <peng.fan@nxp.com>; Jaehoon Chung <jh80.chung@samsung.com>; Tom Rini <trini@konsulko.com>
> Cc: Nitin Yadav <n-yadav@ti.com>; Simon Glass <sjg@chromium.org>; u-boot@lists.denx.de
> Subject: [PATCH 4/5] mmc: am654_sdhci: Set ENDLL=1 for DDR52 mode
> 
> According to the device datasheet [0], ENDLL=1 for
> DDR52 mode, so call am654_sdhci_setup_dll() and write
> itapdly after since we do not carry out tuning.
> 
> [0] https://www.ti.com/lit/ds/symlink/am62p.pdf
> Fixes: c964447ea3d6 ("mmc: am654_sdhci: Add support for input tap delay")
> Signed-off-by: Judith Mendez <jm@ti.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
>  drivers/mmc/am654_sdhci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/am654_sdhci.c b/drivers/mmc/am654_sdhci.c
> index 38f1ad28ec4..dee56dfdbaa 100644
> --- a/drivers/mmc/am654_sdhci.c
> +++ b/drivers/mmc/am654_sdhci.c
> @@ -287,12 +287,14 @@ static int am654_sdhci_set_ios_post(struct sdhci_host *host)
> 
>  	regmap_update_bits(plat->base, PHY_CTRL4, mask, val);
> 
> -	if (mode > UHS_SDR25 && speed >= CLOCK_TOO_SLOW_HZ) {
> +	if ((mode > UHS_SDR25 || mode == MMC_DDR_52) && speed >= CLOCK_TOO_SLOW_HZ) {
>  		ret = am654_sdhci_setup_dll(plat, speed);
>  		if (ret)
>  			return ret;
> 
>  		plat->dll_enable = true;
> +		am654_sdhci_write_itapdly(plat, plat->itap_del_sel[mode],
> +					  plat->itap_del_ena[mode]);
>  	} else {
>  		am654_sdhci_setup_delay_chain(plat, mode);
>  		plat->dll_enable = false;
> --
> 2.43.2


