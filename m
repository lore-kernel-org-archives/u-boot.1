Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA58C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 05:45:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CA63876A2;
	Wed,  1 Nov 2023 06:45:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="cG3rREhB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A104C876A9; Wed,  1 Nov 2023 06:45:30 +0100 (CET)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1BB0876A2
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 06:45:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20231101054521epoutp0236f194e60559f719f86c7bf9cbccdc4c~TaYkAuX152784627846epoutp02N
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 05:45:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20231101054521epoutp0236f194e60559f719f86c7bf9cbccdc4c~TaYkAuX152784627846epoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698817521;
 bh=HOFC0q3DfOiSZQkjxTT9gP+1MFAy/OmuEcHK7CH5bnc=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=cG3rREhBghUg8gb0l9grdd1Ti1fKAyOFMSTqFUttwwEB5qQPqZwyC7Dfs3palA0ud
 k5XJ7+uzWsY3hFiyyf5XWUtQMtRckmuWOxqX5HglDgB3aWRSUfiuWjqgyDzbcUW1XC
 D5xJH4jEYVeDyv9DDmLqycDTN5I9NIRfAYI/OWwc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20231101054521epcas1p270a845efc6ecd7066b80deb5e235b68a~TaYjkHE5C1849018490epcas1p2m;
 Wed,  1 Nov 2023 05:45:21 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.36.134]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4SKwvh1f7Pz4x9QK; Wed,  1 Nov
 2023 05:45:20 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 C0.CC.19104.AE5E1456; Wed,  1 Nov 2023 14:45:14 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20231101054513epcas1p1c4b5311986dee4aa5a686877a9f78d2e~TaYczubnb2429024290epcas1p1k;
 Wed,  1 Nov 2023 05:45:13 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20231101054513epsmtrp22e0015c67988c15232e6d70a2bae2693~TaYczH5r71114311143epsmtrp2k;
 Wed,  1 Nov 2023 05:45:13 +0000 (GMT)
X-AuditID: b6c32a4c-80dff70000004aa0-d1-6541e5ea30e7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 2E.EF.07368.9E5E1456; Wed,  1 Nov 2023 14:45:13 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20231101054513epsmtip2a1770e88848d7ed33ae5d7241b22c220~TaYcqE-O40746007460epsmtip2J;
 Wed,  1 Nov 2023 05:45:13 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Bin Meng'" <bmeng@tinylab.org>, "'Peng Fan'" <peng.fan@nxp.com>
Cc: <u-boot@lists.denx.de>
In-Reply-To: <4b928129-d4d8-4cda-a5e3-7bf97547f366@samsung.com>
Subject: RE: [PATCH] mmc: pci: Drop the superfluous cast
Date: Wed, 1 Nov 2023 14:45:13 +0900
Message-ID: <020901da0c86$95a4afc0$c0ee0f40$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQF4D8qehBMKVpuZIXIG4yU8qUFklgKyiRdBAam7V7axBgtQcA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPKsWRmVeSWpSXmKPExsWy7bCmge6rp46pBs8vc1qcnzid1eLHqi+s
 Fm/3drI7MHucvbOD0WPjux1MHnt6T7MGMEdl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY
 6hpaWpgrKeQl5qbaKrn4BOi6ZeYAbVJSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTk
 FJgW6BUn5haX5qXr5aWWWBkaGBiZAhUmZGesuNvDVLCQp+Lt13uMDYwfOLsYOTkkBEwkpuye
 wQhiCwnsYZR4vjali5ELyP7EKNF2fA8ThPONUWLRn7OsMB0rft9mhUjsZZTo3DKNHcJ5yShx
 ee5TdpAqNgE9if+LFjKD2CICrhIX5m5lA7GZBaQkmk7uAtvHKWAv8XVaP1i9sICFxNTVy8Di
 LAIqEt+/T2QBsXkFLCVObFvMBmELSpyc+YQFYo68xPa3c5ghLlKQ+Pl0GSvELieJLUf2M0LU
 iEjM7myDqnnLLvFxkwiE7SLxdnkPG4QtLPHq+BZ2CFtK4vO7vWwgz0gINDNKLF1ykBXC6WGU
 +NdwHarDWGL/0snAgOEA2qApsX6XPkRYUWLn77lQi/kk3n3tYQUpkRDglehoE4IoUZG49Pol
 E8yuu0/+s05gVJqF5LVZSF6bheSFWQjLFjCyrGKUSi0ozk1PTTYsMNTNSy2Hx3hyfu4mRnBK
 1PLZwfh9/V+9Q4xMHIyHGCU4mJVEeA+bOqQK8aYkVlalFuXHF5XmpBYfYjQFBvhEZinR5Hxg
 Us4riTc0sTQwMTMyNrEwNDNUEueN+dSeIiSQnliSmp2aWpBaBNPHxMEp1cAUUR66dHp8TNur
 dvbQbecyVBLjGb/M+3Uu99t6pQ4DzhcGXoorn2fpTtO5G3Bhd8rX0keN7BLGB+fek6vVV/vU
 a9C/qCjkXpWv5rWdf7Yqnp4VVv/7pMWLM9O33GM1qlk9aR/r5ulP3ym1bqsUX7hT49u2Q6ol
 uqHL4qTzKpaUrfwdfJB50cX/PRkLNZQ3PZ1U/U7/xLs3JjNuz+O84ngxWFL7u8Xrtf2fnu78
 ZMx1J/HCw6lq1pGr591g0k34EFaxtOOi27IZoWtdY32D9lStTXo8R5cn5tKvu37WF+Skzwrc
 0r/1t3lj8eqET6nqp97tSMkQm2F0RNffUeqE7eEEqauvvj9137KGvbA+qs8sVYmlOCPRUIu5
 qDgRAPzgGk4SBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsWy7bCSvO7Lp46pBluuGVicnzid1eLHqi+s
 Fm/3drI7MHucvbOD0WPjux1MHnt6T7MGMEdx2aSk5mSWpRbp2yVwZay428NUsJCn4u3Xe4wN
 jB84uxg5OSQETCRW/L7N2sXIxSEksJtR4ubek6wQCSmJz0+nsnUxcgDZwhKHDxdD1DxnlHh+
 8AEbSA2bgJ7E/0ULmUFsEQF3ic9L1zOB2MxAvU0ndzFCNOxllPjX/gqsgVPAXuLrtH52EFtY
 wEJi6upljCA2i4CKxPfvE1lAbF4BS4kT2xazQdiCEidnPmGBGKot8fTmUyhbXmL72znMEIcq
 SPx8uowV4ggniS1H9jNC1IhIzO5sY57AKDwLyahZSEbNQjJqFpKWBYwsqxglUwuKc9Nzkw0L
 DPNSy/WKE3OLS/PS9ZLzczcxgqNCS2MH4735//QOMTJxMB5ilOBgVhLhPWzqkCrEm5JYWZVa
 lB9fVJqTWnyIUZqDRUmc13DG7BQhgfTEktTs1NSC1CKYLBMHp1QDU/CHM2GTGy0P3LP+wVMu
 fGW9o/qnsIvcj1+7dsc93KUYkfVKq9o/OKi7/K91LcP7y2cq5+ZoXxHSV/VqnLh6SkXGx+Di
 pH2LFXIUi+dVtGtaG9ZNKt8laHRIU4N/2aXMAK+jKk+iXLcfWs7i/u/S8rVy+qLvSm283p5d
 FPDWxvtAoKKVx8GzV0Q8BARV86K1y5dkc1+4IDht+pFZKZXajRcvKfLZtV3JkJlwYFZDgWrK
 t54fqowerp+uxyWd3TL77rsqk5INLAxfUzJeRqucjTrMfPKyvEWQ+Kmtn1a4OL87/PEtj77C
 +wrui99qTmxauLMy+3/KohkzbbyV6no5Dt179+lUeMOyVqew5x3tSizFGYmGWsxFxYkAEjs3
 XvkCAAA=
X-CMS-MailID: 20231101054513epcas1p1c4b5311986dee4aa5a686877a9f78d2e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231031060900epcas1p166ee69d14c52c948df7a9e8c298be45b
References: <20231011110052.2958231-1-bmeng@tinylab.org>
 <CGME20231031060900epcas1p166ee69d14c52c948df7a9e8c298be45b@epcas1p1.samsung.com>
 <4b928129-d4d8-4cda-a5e3-7bf97547f366@samsung.com>
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
> Sent: Tuesday, October 31, 2023 3:09 PM
> To: Bin Meng <bmeng@tinylab.org>; Peng Fan <peng.fan@nxp.com>
> Cc: u-boot@lists.denx.de
> Subject: Re: [PATCH] mmc: pci: Drop the superfluous cast
> 
> On 10/11/23 20:00, Bin Meng wrote:
> > dm_pci_map_bar() return a value of (void *) already, hence no need
> > to cast it again before assigning to host->ioaddr.
> >
> > Signed-off-by: Bin Meng <bmeng@tinylab.org>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
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
> >  drivers/mmc/pci_mmc.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/pci_mmc.c b/drivers/mmc/pci_mmc.c
> > index 9fb7044029..4d163ccba0 100644
> > --- a/drivers/mmc/pci_mmc.c
> > +++ b/drivers/mmc/pci_mmc.c
> > @@ -50,8 +50,8 @@ static int pci_mmc_probe(struct udevice *dev)
> >  	desc = mmc_get_blk_desc(&plat->mmc);
> >  	desc->removable = !(plat->cfg.host_caps & MMC_CAP_NONREMOVABLE);
> >
> > -	host->ioaddr = (void *)dm_pci_map_bar(dev, PCI_BASE_ADDRESS_0, 0, 0, PCI_REGION_TYPE,
> > -					      PCI_REGION_MEM);
> > +	host->ioaddr = dm_pci_map_bar(dev, PCI_BASE_ADDRESS_0, 0, 0,
> > +				      PCI_REGION_TYPE, PCI_REGION_MEM);
> >  	host->name = dev->name;
> >  	host->cd_gpio = priv->cd_gpio;
> >  	host->mmc = &plat->mmc;


