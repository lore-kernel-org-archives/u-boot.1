Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC5F7D40CE0
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 23:47:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65DAE88EBB;
	Wed,  6 Nov 2024 00:47:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="etBC7Vln";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7854F891B0; Wed,  6 Nov 2024 00:47:22 +0100 (CET)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33E3D88E65
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 00:47:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20241105234711epoutp017b8ee5eaefdd21240e50c0e30a594c7a~FN0wiiGeE0062600626epoutp01t
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 23:47:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20241105234711epoutp017b8ee5eaefdd21240e50c0e30a594c7a~FN0wiiGeE0062600626epoutp01t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1730850431;
 bh=YAvVj1cBt5wi3ZAUG1hsnL2nvupqKSN8/WHeAZLaQFw=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=etBC7Vln94cTQ8IJ9ltMnuwOgBvjqptZNP8gQUsBNohbD48O5E58D+MseieIb560k
 O6envLWsP9XUlNXMlSYYZxex31i2ePvuIwrWbLZJrPhgKsIDlrYGk3GoemgmcJ6nMX
 QM+hceu5Vhu2etoxsbE7ZzAh75sndDskxXltLJTo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20241105234711epcas1p3afe6c6d717df7d56f8f30bf79438a4fb~FN0wO0qei0401304013epcas1p3Q;
 Tue,  5 Nov 2024 23:47:11 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.38.231]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4XjlPB3Fysz4x9Q7; Tue,  5 Nov
 2024 23:47:10 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 16.3D.19363.E7EAA276; Wed,  6 Nov 2024 08:47:10 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20241105234710epcas1p234f3ef5a4d221119c9fc90ac9cc680fb~FN0u5zDZl0842808428epcas1p22;
 Tue,  5 Nov 2024 23:47:10 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20241105234710epsmtrp1422f9a1fbe5fc99fefd608144f7b9942~FN0u37OHH2580825808epsmtrp1e;
 Tue,  5 Nov 2024 23:47:10 +0000 (GMT)
X-AuditID: b6c32a4c-02dff70000004ba3-fc-672aae7e954e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 C9.B2.08227.E7EAA276; Wed,  6 Nov 2024 08:47:10 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20241105234709epsmtip1639e89e1767bf11e7640fe10f2ce8bd0~FN0uq35gc2553825538epsmtip1i;
 Tue,  5 Nov 2024 23:47:09 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Marek Vasut'" <marek.vasut@mailbox.org>, <u-boot@lists.denx.de>
Cc: <trini@konsulko.com>, <sjg@chromium.org>,
 <marek.vasut+renesas@mailbox.org>, <laurent.pinchart@ideasonboard.com>,
 <m.szyprowski@samsung.com>
In-Reply-To: <a3ad60cd-c8f4-4377-a30f-80f1530313eb@mailbox.org>
Subject: RE: [PATCH] boot: image-board: Mismatch a type between variable and
 return value
Date: Wed, 6 Nov 2024 08:47:09 +0900
Message-ID: <02ea01db2fdd$0799f610$16cde230$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWYBI3lGCY/lDFaDJ+kyBD9pSs1gL1O7t1Abi+5kSyDYb4QA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42LZdljTQLdunVa6weNJEhadE5ewW6w9cpfd
 onXlHTaLjru32C2+bdnGaDF10mZ2i7d7O9kd2D1mN1xk8ZjdMZPV49WBVeweZ+/sYPTYOXsf
 k0ffllWMAWxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6
 bpk5QMcoKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMC/SKE3OLS/PS9fJSS6wM
 DQyMTIEKE7IzznbOZys4L1Bxf+0l5gbGJbxdjJwcEgImErd/7WLvYuTiEBLYwyix68FNKOcT
 o8TFdbtYIZxvjBLffs1hhmnpudkKldjLKPG84SoThPOSUWLNtMlMIFVsAnoS/xctBOsQEXCV
 2LVtMSNIEbPAFEaJCX/ughVxCthL3Gzfyw5iCwtES+y5u5EVxGYRUJGYefgHC4jNK2Ap8eJ3
 HyPEagWJn0+XsUIMdZKY+6sFrJdZQERidmcbM8gCCYGP7BIz9k6DanCROLH4E5QtLPHq+BZ2
 CFtK4mV/GztEQzOjxNIlB1khnB5GiX8N19kgqowl9i8F+YcDaIWmxPpd+hDb+CTefe1hBQlL
 CPBKdLQJQVSrSFx6/ZIJZv7dJ/9ZIWwPiX8T/jNDgugoo8TNKYtYJjDKz0Jy+CyEDQsYmVYx
 SqUWFOempyYbFhjq5qWWw2M0OT93EyM4MWr57GD8vv6v3iFGJg7GQ4wSHMxKIrzzUtXThXhT
 EiurUovy44tKc1KLDzGaAoNzIrOUaHI+MDXnlcQbmlgamJgZGZtYGJoZKonznrlSliokkJ5Y
 kpqdmlqQWgTTx8TBKdXAFCT8w8q/J4v7gP3C5vpd+SILNhdMPr7p++oo78m82hPP/XM+m+l1
 /Eb0veZtAr0uR091HjhXqbAvLvRRRuTUTvkyq2UKgbMnhjVc53p0+/XZS29P2was+qjbbBiV
 +lpiRfbrN8rJ3uIX1hbee3dCaP4/Vm9Rp2MBa26Lii/87f2nbkKSc52kYid/SR/zYtdVr/+9
 nlQ2xX0/p4b778nMb7U/T3uiIqWaHCq1fA3f1vdGLxTOPZnbwuybJCI+QbxRf8Y8y7apOt/6
 t7+9eJdna+h9Nb8LOrO3pbxSv141rWWz7/OdHCc3M70/aHZV/Qbnp6iz7ruNFT4kvjasYTso
 8NqqUCn9/qxNPwuTSyMnNiuxFGckGmoxFxUnAgBL+E+/FQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrALMWRmVeSWpSXmKPExsWy7bCSnG7dOq10g8OfWC06Jy5ht1h75C67
 RevKO2wWHXdvsVt827KN0WLqpM3sFm/3drI7sHvMbrjI4jG7Yyarx6sDq9g9zt7Zweixc/Y+
 Jo++LasYA9iiuGxSUnMyy1KL9O0SuDLOds5nKzgvUHF/7SXmBsYlvF2MnBwSAiYSPTdbWUFs
 IYHdjBI9u5Qh4lISn59OZeti5ACyhSUOHy7uYuQCKnnOKDH79So2kBo2AT2J/4sWMoPYIgLu
 EmsffGQBsZkFZjBKbH7hBtFwkFHi38FlYA2cAvYSN9v3soPYwgKREhfmNYAtZhFQkZh5+AdY
 M6+ApcSL332MEEcoSPx8uowVYoGTxNxfLewQC0QkZne2MU9gFJiFxF3AyLiKUTK1oDg3PbfY
 sMAoL7Vcrzgxt7g0L10vOT93EyM4kLW0djDuWfVB7xAjEwfjIUYJDmYlEd55qerpQrwpiZVV
 qUX58UWlOanFhxilOViUxHm/ve5NERJITyxJzU5NLUgtgskycXBKNTBd4PWbw/CHMfOhYvR2
 3Sn9zXPvOeqfbPf+x37h9BVt1ybz9+tvG/SHseQvu/nusvo/s7V3PwTMq+dhti98Vy+w7V7x
 15jvnqE3zht4yH9a/brTvsxGke/s7RWsM2W+eMfrZ9dKK13OrRHu/fFyrt1GDZH0N05qU3tm
 zvBi1/yhOCP1UuMN32UTZQrY3MW2zNJsWMJgw704ds0SgZIbXPOOmk1cXL6hvv3UB74gy3eL
 na88WbZuW6+4iJ5S7ey0OrnqS6xblZPzbx7g/bAi523dbqfZX5+9C8tUtSlrPvBV4Fbl5vyg
 u6Iv2c5m5xceuPK2r3uZZmz+9id5fnuYMv7K7plwW0Y++mlyUa90dLYSS3FGoqEWc1FxIgCI
 xExG0wIAAA==
X-CMS-MailID: 20241105234710epcas1p234f3ef5a4d221119c9fc90ac9cc680fb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241105221151epcas1p2096fdad52d8b4977f707e4b1b3a47849
References: <CGME20241105221151epcas1p2096fdad52d8b4977f707e4b1b3a47849@epcas1p2.samsung.com>
 <20241105221149.507119-1-jh80.chung@samsung.com>
 <a3ad60cd-c8f4-4377-a30f-80f1530313eb@mailbox.org>
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
> From: Marek Vasut <marek.vasut@mailbox.org>
> Sent: Wednesday, November 6, 2024 7:57 AM
> To: Jaehoon Chung <jh80.chung@samsung.com>; u-boot@lists.denx.de
> Cc: trini@konsulko.com; sjg@chromium.org; marek.vasut+renesas@mailbox.org;
> laurent.pinchart@ideasonboard.com; m.szyprowski@samsung.com
> Subject: Re: [PATCH] boot: image-board: Mismatch a type between variable and return value
>
> On 11/5/24 11:11 PM, Jaehoon Chung wrote:
> > phys_addr_t can be used unsigned long long type with CONFIG_PHYS_64BIT.
> > But hextoul() is always returning to unsigned long. It can be assigned
> > to unexpected value. To avoid wrong behavior, change from hextoul() to
> > simple_strtoull().
> >
> > Fixes: a4df06e41fa2 ("boot: fdt: Change type of env_get_bootm_low() to phys_addr_t")
>
> Looking at:
>
> 7e5f460ec457 ("global: Convert simple_strtoul() with hex to hextoul()")

Thanks for informing it.

>
> do you have to update any of the other hextoul() calls too ?

I didn't check other hextoul().
During booting with initramfs on RPi (32bit), I found the problem that is not working fine because of this.

>
> Maybe we need hextoull() ?

IMO, We need hextoull() for some cases.
If there is no objection, I will send the patch for adding hextoull().
And I will check entire cases.

Best Regards,
Jaehoon Chung

>
> > Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> > ---
> >   boot/image-board.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/boot/image-board.c b/boot/image-board.c
> > index 1757e5816d84..977343a8995c 100644
> > --- a/boot/image-board.c
> > +++ b/boot/image-board.c
> > @@ -547,7 +547,7 @@ int boot_ramdisk_high(ulong rd_data, ulong rd_len, ulong *initrd_start,
> >   		/* a value of "no" or a similar string will act like 0,
> >   		 * turning the "load high" feature off. This is intentional.
> >   		 */
> > -		initrd_high = hextoul(s, NULL);
> > +		initrd_high = simple_strtoull(s, NULL, 16);
> >   		if (initrd_high == ~0)
> >   			initrd_copy_to_ram = 0;
> >   	} else {
>



