Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC6DC4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 11:11:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE13B8836A;
	Wed, 17 Apr 2024 13:11:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="Q7qlp11g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 742008836A; Wed, 17 Apr 2024 13:11:06 +0200 (CEST)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C06788453
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 13:11:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20240417111059epoutp04c8d94f1bb0f9ddc4216061bb1421d1fd~HDM14Dm3v0345303453epoutp04Z
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 11:10:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20240417111059epoutp04c8d94f1bb0f9ddc4216061bb1421d1fd~HDM14Dm3v0345303453epoutp04Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1713352259;
 bh=DhBPy6bNPNkxQnnmo5wFj/L9VYy6lXEOAV/yD26jKcg=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=Q7qlp11go15A+fRjuAC3jW1LQIxIKDBm5kYELQWmtHbZQGhOdlzwxIkqvAG802gVA
 ABHl4rxH8vFGbwyvrvurvd6lgZEkQk42DLh3oFb1yjJMV0x/Nren1R/F2EqWwSjSbm
 XFGvitaT80/11eaB04U949yx1OxdzDRMYrnGuLTg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTP id
 20240417111059epcas1p13161bd9f8bfc8edc154ab1641f2f40d1~HDM1IgKCD0694606946epcas1p1i;
 Wed, 17 Apr 2024 11:10:59 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.232]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4VKJ9t1X5Jz4x9Q0; Wed, 17 Apr
 2024 11:10:58 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
 epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 2A.E4.08627.24EAF166; Wed, 17 Apr 2024 20:10:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20240417111057epcas1p1ced041a5c5b78af9b752e63059dd8855~HDMz1rOam2581425814epcas1p1G;
 Wed, 17 Apr 2024 11:10:57 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240417111057epsmtrp27b40041205832d63199da7605b2bbead~HDMz1DXJJ0364903649epsmtrp2p;
 Wed, 17 Apr 2024 11:10:57 +0000 (GMT)
X-AuditID: b6c32a33-af9ff700000021b3-1d-661fae428763
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 A2.E5.19234.14EAF166; Wed, 17 Apr 2024 20:10:57 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20240417111057epsmtip10f5f90adbb0d349aea689dd2133775f4~HDMzoNes30391803918epsmtip1b;
 Wed, 17 Apr 2024 11:10:57 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Patrick DELAUNAY'" <patrick.delaunay@foss.st.com>, "'Patrice Chotard'"
 <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
Cc: "'U-Boot STM32'" <uboot-stm32@st-md-mailman.stormreply.com>, "'Peng
 Fan'" <peng.fan@nxp.com>, "'Sean Anderson'" <seanga2@gmail.com>, "'Simon
 Glass'" <sjg@chromium.org>, "'Tom Rini'" <trini@konsulko.com>
In-Reply-To: <79062d65-359c-4e1a-ae04-da5e9bea1ed6@foss.st.com>
Subject: RE: [PATCH 1/2] mmc: stm32_sdmmc2: Add "st,stm32mp25-sdmmc2"
 compatible
Date: Wed, 17 Apr 2024 20:10:57 +0900
Message-ID: <01e001da90b7$ec103130$c4309390$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHEDEWbNqTCtiddf3YFOsrAgyEnTQGl9sm9Aa0R2j2xfr7mQA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBJsWRmVeSWpSXmKPExsWy7bCmrq7TOvk0g1snOC1+nnzPbjFp/TV2
 ix+rvrBabL03gcni25ZtjBZTJ21mt3i7t5PdYuHW5SwOHB6zGy6yeDzt38rusXPWXXaPVwdW
 sXucvbOD0WPjux1MHgf3GQawR2XbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp
 5CXmptoqufgE6Lpl5gBdpaRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMC3QK07M
 LS7NS9fLSy2xMjQwMDIFKkzIzni/5zRrwQaeigmXVrI1MM7g6mLk4JAQMJH43VfTxcjFISSw
 g1HizNlbbBDOJ0aJ/c/vMMI5q6fvYe5i5ATreHPgKBNEYiejROf2X1BVLxkldj9fzAJSxSag
 J/F/0UJmkISIQAujRMv7LWAOs8AlRomZZ0+CVXEK2EvM+7QXzBYWCJK4s/c3K4jNIqAqsfPO
 UTYQm1fAUmLx7zOMELagxMmZT8DqmQXkJba/nQN1k4LEz6fLwHpFBJwklm6azwRRIyIxu7MN
 bLGEwFoOieaZN1kh3naR2H61FKJXWOLV8S3sELaUxOd3e9kg6psZJZYuOcgK4fQwSvxruM4G
 UWUssX/pZCaQQcwCmhLrd+lDLOOTePe1B2o+r0RHmxBEtYrEpdcvmWDm333yH6rEQ2LhDPYJ
 jIqzkHw2C8lns5B8MAth1wJGllWMYqkFxbnpqcmGBYbw6E7Oz93ECE6yWsY7GC/P/6d3iJGJ
 g/EQowQHs5IIb4uwbJoQb0piZVVqUX58UWlOavEhRlNgWE9klhJNzgem+bySeEMTSwMTMyNj
 EwtDM0Mlcd4zV8pShQTSE0tSs1NTC1KLYPqYODilGpgmOtXK1RWHMsbHHPbdkDUzovBVkHf/
 Z9HPB4L5Ht2c1hyUt87t4r+Qew7L5JfXX+PIPhI0UWjfjMcafY/TX3QXfJ3Efa3pv9oZ21fp
 /zMStY3eTS/R4BFsrrozIVPspJS/kFXv9wCLysZZnbILk+qO7NuuMYnpxRmJqKdJ3ReWe236
 O8Nr5jnxdcWBESx/Fseyu27VMV9+T8A66DWTHRd73T+rpeEWU3Ttag0kTNNMDmqZXN2pl91Y
 J7JI8GHv6d4mAWtj29oHTyLKNPn2Xqv0YbyQICfx5/z/+T5XXi3cqnU3+bFZooibflnPO43H
 O65a3M632Rwbf0HUctHZgIPfduxnObNW91TPxKDPuUosxRmJhlrMRcWJABrnTlE7BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsWy7bCSnK7jOvk0g7tNKhY/T75nt5i0/hq7
 xY9VX1gttt6bwGTxbcs2RoupkzazW7zd28lusXDrchYHDo/ZDRdZPJ72b2X32DnrLrvHqwOr
 2D3O3tnB6LHx3Q4mj4P7DAPYo7hsUlJzMstSi/TtErgy3u85zVqwgadiwqWVbA2MM7i6GDk5
 JARMJN4cOMrUxcjFISSwnVHi0M2ZLBAJKYnPT6eydTFyANnCEocPF0PUPGeUaJv5nBGkhk1A
 T+L/ooXMIAkRgTZGiRPLFoBNYha4xihxfvEfNoiW44wSC9quMoG0cArYS8z7tBdshbBAgMT3
 Y8eZQWwWAVWJnXeOsoHYvAKWEot/n2GEsAUlTs58AlbPLKAt8fTmUyhbXmL72znMEKcqSPx8
 uowVxBYRcJJYumk+E0SNiMTszjbmCYzCs5CMmoVk1Cwko2YhaVnAyLKKUTS1oDg3PTe5wFCv
 ODG3uDQvXS85P3cTIzjStIJ2MC5b/1fvECMTB+MhRgkOZiUR3hZh2TQh3pTEyqrUovz4otKc
 1OJDjNIcLErivMo5nSlCAumJJanZqakFqUUwWSYOTqkGpraofK33r925pos7tLIZ7Enylf35
 jOOA6NPim99PZf1fVHlqbsEBL8adnaFH7oqL6kgXZZezumoon2F5V3PSr/1ydl6CMe9pngLB
 Jzc9Ss/6Cv1+25xmcq5dRnTb4n5hMcuOrgdW0SHBT7cxt39l2M2m5h0Q87vvQeGt/0/L/29t
 U3zw6xvzxef+H8q4trfMuNuvv//6rFDnk7eK22/52x7Si7eZyv/zyFErpVd3o081s09f/E2w
 103Ie161TeJ2B+0E97WSDSxrWwv02FtWMN+3teJPb/rGb3HCQJYn8ID4Ilv+pPWth1f51Wzo
 NuK40HmdUXvF+vA2gZOVXn1y55/pvTJ6fHt3AzfnUz0lluKMREMt5qLiRADK4IUOIwMAAA==
X-CMS-MailID: 20240417111057epcas1p1ced041a5c5b78af9b752e63059dd8855
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240417090230epcas1p2688df3c6263283a23019c72b5553570a
References: <20240308142614.2700185-1-patrice.chotard@foss.st.com>
 <CGME20240417090230epcas1p2688df3c6263283a23019c72b5553570a@epcas1p2.samsung.com>
 <79062d65-359c-4e1a-ae04-da5e9bea1ed6@foss.st.com>
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

Hi

> -----Original Message-----
> From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
> Sent: Wednesday, April 17, 2024 6:02 PM
> To: Patrice Chotard <patrice.chotard@foss.st.com>; u-boot@lists.denx.de
> Cc: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>; Jaehoon Chung <jh80.chung@samsung.com>;
> Peng Fan <peng.fan@nxp.com>; Sean Anderson <seanga2@gmail.com>; Simon Glass <sjg@chromium.org>; Tom
> Rini <trini@konsulko.com>
> Subject: Re: [PATCH 1/2] mmc: stm32_sdmmc2: Add "st,stm32mp25-sdmmc2" compatible
> 
> Hi,
> 
> On 3/8/24 15:26, Patrice Chotard wrote:
> > From: Patrick Delaunay <patrick.delaunay@foss.st.com>
> >
> > Add compatible used for STM32MP25 family.
> >
> > Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> > Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> > ---
> >
> >   drivers/mmc/stm32_sdmmc2.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/mmc/stm32_sdmmc2.c b/drivers/mmc/stm32_sdmmc2.c
> > index a2b111a8435..d4982a14281 100644
> > --- a/drivers/mmc/stm32_sdmmc2.c
> > +++ b/drivers/mmc/stm32_sdmmc2.c
> > @@ -789,6 +789,7 @@ static int stm32_sdmmc2_bind(struct udevice *dev)
> >
> >   static const struct udevice_id stm32_sdmmc2_ids[] = {
> >   	{ .compatible = "st,stm32-sdmmc2" },
> > +	{ .compatible = "st,stm32mp25-sdmmc2" },
> >   	{ }
> >   };
> >
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> 
> Thanks
> Patrick
> 


