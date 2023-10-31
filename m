Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F214C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 05:04:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07B4D8751F;
	Tue, 31 Oct 2023 06:04:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="I226O/1z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C63787ABA; Tue, 31 Oct 2023 06:04:00 +0100 (CET)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23F778709A
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 06:03:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20231031050355epoutp03a91656d63010e2ebc55ae1077ef667d9~TGLGAeWBQ3077730777epoutp03i
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 05:03:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20231031050355epoutp03a91656d63010e2ebc55ae1077ef667d9~TGLGAeWBQ3077730777epoutp03i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698728635;
 bh=k/lVMXSkwDPYP0Iu3CnDYSV3MhHdei31fdvzf8AziZ0=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=I226O/1z+5X6JE8kGZsGVnH/z1wkej9sLXX5QBQpcwzIqR6yO9DGGrcIGrteNMaw6
 Nppe0MuxONI/q7ktIOfCUKf6kq6gtt2mTbFWzWxeNTdZgALwiOx0Iha/jnY/tbjcSq
 PE1ke1QXkVAchZeFyQ1QIDnO18wTEbjJT7SQIny0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTP id
 20231031050354epcas1p4334df83174ee80efb318adaa66ba42fc~TGLFz5D6q0772607726epcas1p45;
 Tue, 31 Oct 2023 05:03:54 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.133]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4SKJ2K4YMsz4x9QB; Tue, 31 Oct
 2023 05:03:53 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 C4.93.09739.8BA80456; Tue, 31 Oct 2023 14:03:52 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20231031050352epcas1p49c7f9320c0200242a7851041f6e6ad93~TGLDpui2p0506105061epcas1p4H;
 Tue, 31 Oct 2023 05:03:52 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20231031050352epsmtrp1bc148850dac049360369f5fca78f8239~TGLDpG3_92446624466epsmtrp1U;
 Tue, 31 Oct 2023 05:03:52 +0000 (GMT)
X-AuditID: b6c32a37-e67fa7000000260b-7e-65408ab8b4d9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 91.88.08817.8BA80456; Tue, 31 Oct 2023 14:03:52 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20231031050352epsmtip1c08142ea0d77260f2a2a25dc1e860ec9~TGLDcru7W1482814828epsmtip1R;
 Tue, 31 Oct 2023 05:03:52 +0000 (GMT)
Message-ID: <e8ec2104-cd32-4eeb-ab62-9902f7b31896@samsung.com>
Date: Tue, 31 Oct 2023 14:03:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: spl: select SPL_BLK for SPL_DM_MMC
Content-Language: en-US
To: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>
From: Jaehoon Chung <jh80.chung@samsung.com>
In-Reply-To: <20230823154547.10711-1-oleksandr.suvorov@foundries.io>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDKsWRmVeSWpSXmKPExsWy7bCmge6OLodUg7ePLS2evpnBYvFj1RdW
 i7d7O9kdmD0OXe1k9Th7Zwejx8Z3O5gCmKOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwM
 dQ0tLcyVFPISc1NtlVx8AnTdMnOANikplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1Jy
 CkwL9IoTc4tL89L18lJLrAwNDIxMgQoTsjO2fX3HWPCYveLY0++sDYwr2boYOTkkBEwkHp0/
 xNLFyMUhJLCDUaLv0xZmCOcTo8Tdg4vYIJxvjBL7305ihGlZtvomO0RiL6PE54swzntGieu3
 DjOBVPEK2Em82HCIFcRmEVCVODtlMiNEXFDi5MwnLCC2qIC8xP1bM9hBbGEBG4l7c5rBepkF
 xCVuPZkPZHNwiAj4SOzcxQ0RlpeY/mod2Eg2AR2J7d+Og5VzCrhI3Jm+lw2mZvvbOWAvSAjc
 Y5c4P/k/M8TVLhL/f/xggrCFJV4d38IOYUtJvOxvY4doaGaUWLrkICuE08Mo8a/hOjSYjCX2
 L50MdhGzgKbE+l36EGFFiZ2/5zJCbOaTePe1hxWkREKAV6KjTQiiREXi0uuXTDC77j75zwph
 e0hM6PrBNIFRcRZSsMxC8v4sJP/MQli8gJFlFaNYakFxbnpqsWGBMTy6k/NzNzGCk6GW+Q7G
 aW8/6B1iZOJgPMQowcGsJMJ72NQhVYg3JbGyKrUoP76oNCe1+BCjKTByJjJLiSbnA9NxXkm8
 oYmlgYmZkbGJhaGZoZI4761nvSlCAumJJanZqakFqUUwfUwcnFINTAfqFh2QO6OzKvUBU9tt
 /8ajjz/vYOizyggsW/hjP1PhlKC/zZKpJjt21n61s92fbWUzvUq+crW06qdXilzTZ9plW7Hy
 3tLMS9p75k4ur3pj1ps3r4U0Js2f359419f7s2lh+jutdZsnP1Ze0qL4uK2+05Rt7hwFLW/W
 YzN0lyqWmk3nPeucXfjGKMh73TrjrrN9VzkW3jnQXmW/+bHCnYnCd09981g/d97/l+wrFVzE
 dvmWxm53eRissHlp085701xm7RP8VLpozvUPDRyu8etTWA9VPHbzvGa1SLKiMl5kPa/CDk5X
 o02bMsNdFv/9neDC9L86sMKLuZG96vG8qm+bNtXcuDJbIWXi4VOu35RYijMSDbWYi4oTAUgc
 Z00PBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsWy7bCSnO6OLodUg0Nd0hZP38xgsfix6gur
 xdu9newOzB6Hrnayepy9s4PRY+O7HUwBzFFcNimpOZllqUX6dglcGdu+vmMseMxecezpd9YG
 xpVsXYycHBICJhLLVt9k72Lk4hAS2M0o0dg1nQkiISXx+elUoCIOIFtY4vDhYpCwkMBbRokv
 B7lAbF4BO4kXGw6xgtgsAqoSZ6dMZoSIC0qcnPmEBcQWFZCXuH9rBjuILSxgI3FvTjPYeGYB
 cYlbT+YzgYwXEfCR2LmLGyIsLzH91TpWiFXOErOf7wJrZRPQkdj+7ThYK6eAi8Sd6XvBLmMW
 UJdYP08IpnX72znMExiFZiE5YhaSZbMQOmYh6VjAyLKKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0
 L10vOT93EyM45LW0djDuWfVB7xAjEwfjIUYJDmYlEd7Dpg6pQrwpiZVVqUX58UWlOanFhxil
 OViUxHm/ve5NERJITyxJzU5NLUgtgskycXBKNTCF82z4oXPNzSa/MvpFZvO5NyUbgiZciDln
 vOqW77QntwXTNH+KM3u3zeOT2jLtrkFbQONMzxmHLojdXB/ofWT9/BQZVedCmd13Tj/1tPr1
 azLTI52yTcxrv0Q/te10WMUh3uMckPQldN/qyg83m9cucun+43Pj/DQX3rdO0xXLrzadKG4z
 yUgscFz9ZKKQyeN//i+l7yrclg0+trPO0o23XOXdHLOefcFWi4Sj8y7Ha7as/+u3QtL/a/bP
 bXuWvBVRl7vyXDQuyuuFvLTQxPa7y05+Ofp01va6PXFl2X7cGRyv2dKOGtotuNwtGb2W73P4
 vWNVMpv6H7wKeDlNLOPFpcLDN36YPQ3Z8siZ13G6EktxRqKhFnNRcSIAY7HPY+gCAAA=
X-CMS-MailID: 20231031050352epcas1p49c7f9320c0200242a7851041f6e6ad93
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231031050352epcas1p49c7f9320c0200242a7851041f6e6ad93
References: <20230823154547.10711-1-oleksandr.suvorov@foundries.io>
 <CGME20231031050352epcas1p49c7f9320c0200242a7851041f6e6ad93@epcas1p4.samsung.com>
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

On 8/24/23 00:45, Oleksandr Suvorov wrote:
> mmc_bind() in mmc-uclass.c calls blk_create_devicef() which is
> defined in blk-uclass.c, so SPL_BLK is required by SPL_DM_MMC.
> Implicitly select SPL_BLK for SPL_DM_MMC.
> 
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
> Reviewed-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
> 
>  drivers/mmc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
> index de01b9687ba..d24677de076 100644
> --- a/drivers/mmc/Kconfig
> +++ b/drivers/mmc/Kconfig
> @@ -46,6 +46,7 @@ config SPL_DM_MMC
>  	depends on SPL_DM && DM_MMC
>  	default n if ARCH_MVEBU && !MVEBU_SPL_BOOT_DEVICE_MMC
>  	default y
> +	select SPL_BLK
>  	help
>  	  This enables the MultiMediaCard (MMC) uclass which supports MMC and
>  	  Secure Digital I/O (SDIO) cards. Both removable (SD, micro-SD, etc.)

