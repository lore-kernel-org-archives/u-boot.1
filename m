Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B32C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 05:44:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5F43876A9;
	Wed,  1 Nov 2023 06:44:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="u8FDyGWY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61DA487B65; Wed,  1 Nov 2023 06:44:39 +0100 (CET)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 007E78769D
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 06:44:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20231101054430epoutp011850eca5f8b911b849371abd74d5f0fa~TaX0ugoWT2934729347epoutp01W
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 05:44:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20231101054430epoutp011850eca5f8b911b849371abd74d5f0fa~TaX0ugoWT2934729347epoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698817470;
 bh=Odj1MTWUmWU/fuNBIdKYO06KkU8o+gtnWbRDVFylwAw=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=u8FDyGWYUATqwV733TQo7rJHRRdoEHq4vGr2S8Uk5PgCBx/KdQHrrxZ+r3KZO9l5n
 SnoVOTqguHWh697f8TNX7pf2VLCDagdRUMjjuiVu+61iofqwjmipHk5pYBQsx2ZXHl
 G0eIU3AWfRBC4O9RNydRDeBWcgepi98UD7l4Hcd4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20231101054430epcas1p266a2ed7ff047e32d365c92d4868d9978~TaX0ddL4G3181431814epcas1p2J;
 Wed,  1 Nov 2023 05:44:30 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.36.133]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4SKwtj2FcPz4x9Pv; Wed,  1 Nov
 2023 05:44:29 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 19.9C.19104.DB5E1456; Wed,  1 Nov 2023 14:44:29 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20231101054428epcas1p48aa039b0f577ec71e90090cf32c80240~TaXy9wIv70525705257epcas1p4P;
 Wed,  1 Nov 2023 05:44:28 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20231101054428epsmtrp2a7f120ae19e53be2debaa3ae920eb5d4~TaXy9EyZ31058810588epsmtrp25;
 Wed,  1 Nov 2023 05:44:28 +0000 (GMT)
X-AuditID: b6c32a4c-559ff70000004aa0-45-6541e5bd7e8c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 62.EF.07368.CB5E1456; Wed,  1 Nov 2023 14:44:28 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20231101054428epsmtip2b0534b57154f3463b509796095bb45db~TaXyywLQm0927609276epsmtip2B;
 Wed,  1 Nov 2023 05:44:28 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Oleksandr Suvorov'" <oleksandr.suvorov@foundries.io>,
 <u-boot@lists.denx.de>
Cc: "'Peng Fan'" <peng.fan@nxp.com>
In-Reply-To: <e8ec2104-cd32-4eeb-ab62-9902f7b31896@samsung.com>
Subject: RE: [PATCH] mmc: spl: select SPL_BLK for SPL_DM_MMC
Date: Wed, 1 Nov 2023 14:44:28 +0900
Message-ID: <020801da0c86$7ad94020$708bc060$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGy5VFYxFRAXs+ZCoWU4BBezWD6hQIfIhDyAW6YvN6wltRTwA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHKsWRmVeSWpSXmKPExsWy7bCmvu7ep46pBvOn8Fo8fTODxeLHqi+s
 Fm/3drI7MHscutrJ6nH2zg5Gj43vdjAFMEdl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY
 6hpaWpgrKeQl5qbaKrn4BOi6ZeYAbVJSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTk
 FJgW6BUn5haX5qXr5aWWWBkaGBiZAhUmZGfca1Iv2Mxd0TllBVMD40zOLkZODgkBE4l/L3ay
 dzFycQgJ7GGU+LX9LTOE84lRonHNcVYI5xujxNuN15hgWg4vms8KYgsJ7GWUaP0P1fGSUaJ/
 11x2kASbgJ7E/0ULmUFsEYEQib73y8FsZgFliQN/boPVcArYS1y+fYANxBYWsJE403mMsYuR
 g4NFQEXi9wd3kDCvgKXEnEWf2SFsQYmTM5+wQIyRl9j+dg4zxD0KEj+fLmOFWOUk8f7zdVaI
 GhGJ2Z1tYLdJCLxll+ju/gHV4CKxdtksKFtY4tXxLewQtpTE53d72SAamhklli45yArh9DBK
 /Gu4zgZRZSyxf+lkJpBLmQU0Jdbv0ocIK0rs/D2XEWIzn8S7rz2sICUSArwSHW1CECUqEpde
 v2SC2XX3yX/WCYxKs5D8NgvJb7OQ/DALYdkCRpZVjFKpBcW56anJhgWGunmp5fAIT87P3cQI
 TohaPjsYv6//q3eIkYmD8RCjBAezkgjvYVOHVCHelMTKqtSi/Pii0pzU4kOMpsAAn8gsJZqc
 D0zJeSXxhiaWBiZmRsYmFoZmhkrivDGf2lOEBNITS1KzU1MLUotg+pg4OKUamOx/L1bhs7p9
 6EKNTsmzvQxel6KvZwmUJ3Q/WHDNXKruD+NuvvAVklyd7S+tb0pvfLqi0l2D8dLlTQd32mR/
 Yf3tvCPw29eaHV/C/izVkWW/vLX/hcOMe5Xf7i780Fk0c25Qn/nj9en7G9MEC3/48ur82qod
 NfHFLA9Vbd9rUyco5qWdy2KZuXzTb6NfbvMPFUj0mP3SnZ+2Ubzg+mS7Gbl258KaxRpOeE/P
 mzxx1bFqsWIuwYvOp198W79OVLCHKWXyFZ+i7vc2vlU8z8M1Ze58SbYtklZecPGb/k2RSRKr
 LkzbXJg/lzf27NJl7zJuby/88XxyQkd49qqL/n/qbP8UvXpzQCnn35IvLG9SI8OVWIozEg21
 mIuKEwHKPiNPEQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsWy7bCSvO6ep46pBt8OGFs8fTODxeLHqi+s
 Fm/3drI7MHscutrJ6nH2zg5Gj43vdjAFMEdx2aSk5mSWpRbp2yVwZdxrUi/YzF3ROWUFUwPj
 TM4uRk4OCQETicOL5rN2MXJxCAnsZpQ4Pr2ZHSIhJfH56VS2LkYOIFtY4vDhYpCwkMBzoJrr
 uiA2m4CexP9FC5lBbBGBEIm+98vBbGYBZYkDf26zQ8w8wSjRc7OLCSTBKWAvcfn2ATYQW1jA
 RuJM5zFGkPksAioSvz+4g4R5BSwl5iz6zA5hC0qcnPmEBWKmtsTTm0+hbHmJ7W/nMEOcqSDx
 8+kyVogbnCTef77OClEjIjG7s415AqPwLCSjZiEZNQvJqFlIWhYwsqxilEwtKM5Nz002LDDM
 Sy3XK07MLS7NS9dLzs/dxAiOBy2NHYz35v/TO8TIxMF4iFGCg1lJhPewqUOqEG9KYmVValF+
 fFFpTmrxIUZpDhYlcV7DGbNThATSE0tSs1NTC1KLYLJMHJxSDUyK99dGf1aqfslXzzPVYO/K
 wH2Oz6dbJ/xcfFu8Wjv3ZGzj+0SVXTbrNRy7+SLslEUTVI8a/k/kaVo4tcrnLdOdt2dXtL9I
 WaIRskj7vfzZVZdZjpVPXJBnrzGrszjaYtPCwMde3ZoGB5vndj9IYPnO97U4WOvD/ENezPYv
 GbxezP6Xm/fgp/JfJ4Y+4ffXrvJGil9rMDBftPvoFh6bg1lLC5MzLk19cUHyVDdfkf275+dP
 iV9/L2ivldxw51XeE8bNv1+6Z2yW2JH4RkcnPKOJ4bbdt7CnV43e+QncfaatfbKYo/q0rR6j
 YStDqLCLfKbla523687M51M7W/E58LDtpL+KMxJZvk9yONHqqK/EUpyRaKjFXFScCADNAQcP
 9gIAAA==
X-CMS-MailID: 20231101054428epcas1p48aa039b0f577ec71e90090cf32c80240
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231031050352epcas1p49c7f9320c0200242a7851041f6e6ad93
References: <20230823154547.10711-1-oleksandr.suvorov@foundries.io>
 <CGME20231031050352epcas1p49c7f9320c0200242a7851041f6e6ad93@epcas1p4.samsung.com>
 <e8ec2104-cd32-4eeb-ab62-9902f7b31896@samsung.com>
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
> From: U-Boot <u-boot-bounces@lists.denx.de> On Behalf Of Jaehoon Chung
> Sent: Tuesday, October 31, 2023 2:04 PM
> To: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>; u-boot@lists.denx.de
> Cc: Peng Fan <peng.fan@nxp.com>
> Subject: Re: [PATCH] mmc: spl: select SPL_BLK for SPL_DM_MMC
> 
> On 8/24/23 00:45, Oleksandr Suvorov wrote:
> > mmc_bind() in mmc-uclass.c calls blk_create_devicef() which is
> > defined in blk-uclass.c, so SPL_BLK is required by SPL_DM_MMC.
> > Implicitly select SPL_BLK for SPL_DM_MMC.
> >
> > Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
> > Reviewed-by: Tom Rini <trini@konsulko.com>
> 
> Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Applied to u-boot-mmc/master. Thanks!

Best Regards,
Jaehoon Chung

> 
> Best Regards,
> Jaehoon Chung
> 
> > ---
> >
> >  drivers/mmc/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
> > index de01b9687ba..d24677de076 100644
> > --- a/drivers/mmc/Kconfig
> > +++ b/drivers/mmc/Kconfig
> > @@ -46,6 +46,7 @@ config SPL_DM_MMC
> >  	depends on SPL_DM && DM_MMC
> >  	default n if ARCH_MVEBU && !MVEBU_SPL_BOOT_DEVICE_MMC
> >  	default y
> > +	select SPL_BLK
> >  	help
> >  	  This enables the MultiMediaCard (MMC) uclass which supports MMC and
> >  	  Secure Digital I/O (SDIO) cards. Both removable (SD, micro-SD, etc.)


