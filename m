Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E8D2C4345F
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 22:34:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6596E8850A;
	Tue, 30 Apr 2024 00:34:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="Rsa9NmuM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65AC28850A; Tue, 30 Apr 2024 00:34:15 +0200 (CEST)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FFEB88224
 for <U-Boot@lists.denx.de>; Tue, 30 Apr 2024 00:34:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20240429223404epoutp0378028960517223d9b0cfafc22af12523~K4Qq7aJUl0595905959epoutp03G
 for <U-Boot@lists.denx.de>; Mon, 29 Apr 2024 22:34:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20240429223404epoutp0378028960517223d9b0cfafc22af12523~K4Qq7aJUl0595905959epoutp03G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1714430044;
 bh=pTRDWUQ706XAeE3GNHyai9CQrUIO19yOhnWMzxF9Ly0=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=Rsa9NmuMY5u8GS8SxncW7wywCIiMrZeHwu/l5f9fEnBKWfXJCEg/wtAEifYm8tj8e
 C94RuT53eBw4wMjlxQJJGJPFL6OrGzLLvPoVW+c2hvFUvA0KOaC7OXJJMdXk78ImAV
 H7U4710SgOEFe18hFUyBA5zci+RdpRaCQWMHEBcU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTP id
 20240429223403epcas1p17d29ffdd80d21ae6486868338c765e9c~K4QqjbvWd0700407004epcas1p1o;
 Mon, 29 Apr 2024 22:34:03 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.144]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4VSymV4ykYz4x9Px; Mon, 29 Apr
 2024 22:34:02 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
 36.B5.10076.A5020366; Tue, 30 Apr 2024 07:34:02 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
 20240429223402epcas1p3bd2fc856c3ae2cf53b1b223f38c30a10~K4QpFfV_R3239432394epcas1p3v;
 Mon, 29 Apr 2024 22:34:02 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240429223402epsmtrp104976bda948491118696cd6edfc2914b~K4QpEm1U11466714667epsmtrp1N;
 Mon, 29 Apr 2024 22:34:02 +0000 (GMT)
X-AuditID: b6c32a39-59dff7000000275c-78-6630205a1982
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 57.ED.07541.A5020366; Tue, 30 Apr 2024 07:34:02 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20240429223402epsmtip18d6eb55e097f7cdec236ce4200eaf8af~K4QowC2XA1970819708epsmtip1T;
 Mon, 29 Apr 2024 22:34:02 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Judith Mendez'" <jm@ti.com>, "'Tom Rini'" <trini@konsulko.com>
Cc: "'U-Boot Mailing List'" <U-Boot@lists.denx.de>,
 <maximilian.brune@9elements.com>, <curtis.machida@intel.com>, "'Jonas
 Karlman'" <jonas@kwiboo.se>, <greg.malysa@timesys.com>,
 <ian.roberts@timesys.com>, "'Jae	hoon Chung'" <jh80.chung@gmail.com>, "'Peng
 Fan'" <peng.fan@nxp.com>, <sheng.tan@9elements.com>
In-Reply-To: <33db14f4-f3f0-4e5f-a256-2ce9b5c505fd@ti.com>
Subject: RE: [GIT PULL] Please pull u-boot-mmc master
Date: Tue, 30 Apr 2024 07:34:01 +0900
Message-ID: <050301da9a85$55bc1b90$013452b0$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLL5QV8MagdXjSN7vdPQs3dQnF4zQDNSJaEAfSQ6k8BxNOLda95CuIg
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUxTZxTee++FFrfiTanjXfdhcxUnZkALLbttgJAM4S7OhcyYDAhhd/Ra
 OvqVfqGTH93cmDCJDD+WwTYBKYk1gcHQAmujLXGVgWiZfCSC8MNlliFBsA63Wtf2wrZ/zznn
 efI8OedwUX5rvJCr1pkZo47WEPFbsMvDqRlppSLxIfFsTwp5c9UHyNHVGYwMzN9FSP9tO0qu
 rqjJkaVJjHwyP46R645HcaRr7SmHPNP8I4d84K7n5D9PTZ/NowZb5jjUeVcAoRavOjjU9aYJ
 hLoxOwCo3uUBhPLNOBHK7VxHihNKq3OqGFrJGEWMrlKvVOtUucS+AxVvVciyxZI0iZx8kxDp
 aC2TSxS8U5xWqNZE0hIiK62xRFrFtMlEZOTlGPUWMyOq0pvMuQRjUGoMMkO6idaaLDpVuo4x
 KyRicaYsQvyguqrTP4IaGpMOP5weRGzgz60NIIELcSlsHDyHNIAtXD4+AKDzy8coW6wC2Hb5
 EoctHgN4OrwANiVnJ7vj2IEbwEtLbiw64OMBAG/9jUdxPJ4On3W0o1EswAtg+N7VmAeKDyHw
 m8/q46KDBFwBu667IpjLTcJlsN27PdrG8BQYGn0YM+PhcuixBRDWWASf/NYVowvwQtj9qzja
 RnEBbK2vi6WGeDsXXgx+Es/yC6Crq39DmwQXff0cFgth4GQdhxUcA9De6YljixMAhm3TG+os
 eMV+Com6oXgq7BnKYN0S4XLwRCwExHnweB2fZe+EE39s5hTCuXvPNigUnL+rZXe1BKDbb0eb
 wPaW/+Vu+c+gDSAO8CJjMGlVjElikP17yUq9tg/EvnSPfAB8/WAl3QsQLvACyEUJAe90e8Yh
 Pk9JH/mYMeorjBYNY/ICWWSRX6HCbZX6yJvrzBUSqVwszc7MkpKSbAmRzBu7bWX4uIo2M9UM
 Y2CMmzqEmyC0Ic22Cx1DP9hXLk6GCsqwvNzClJJvp2p+VipuTvpvfR9aSx0uqapxlruwLu+r
 C2Eiw3MhPeu9fW+Pj4/Nt32Rb205ci5zwbt2vnzxr737S3coQjXbfu8O2nYHj545qTrsO9jz
 3LWyGy8Zg9BhldxXTghfrn39SrLbstNmHG765bXM2pyZ3T0c5yuhRMUScnQ0mDzlMr+b+FHv
 AUrQ+V3H++tzdMWu2h2pRZZZ+oUPO53W/jgp7/i18hYbOR3uBdWYh7rvWR6x+IpyU5r1GiS/
 X5zd8HTrsV3+vX2tb1hLKPmIVvEopD7o3u+w32F0CZ+Gi1R3yiZ/+rxhrLEP6wjMTBGYqYqW
 7EGNJvofiezQLy4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsWy7bCSnG6UgkGawd11vBbnPx1ntDj96QaL
 xcv795gsLl5Zymzx6UOmxck3V1ksft4/x2LxY9UXVos9n/+yW0ydtJnd4u3eTnYHbo/r0+w8
 ds66y+6xeM9LJo9XB1axe5yYcInJ4+ydHYweG9/tYPI4fmM7k8fe7T+YAjijuGxSUnMyy1KL
 9O0SuDKWXDzJXNArXPHx+k6mBsbv/F2MnBwSAiYS066uY+1i5OIQEtjNKHHm4WZ2iISUxOen
 U9m6GDmAbGGJw4eLIWqeM0p87p/BClLDJqAn8X/RQmYQW0TATaL/3FqwQcwCh5gkela2skF0
 PGOUuPDvIFgVp4CVxLITe1hBpgoLmEosPCQPEmYRUJX4c/ojI4jNK2ApcbDhJRPEEQoSP58u
 AysHWbDusgFImFlARGJ2ZxvzBEaBWUjcBYyMqxglUwuKc9Nzkw0LDPNSy/WKE3OLS/PS9ZLz
 czcxgmNBS2MH4735//QOMTJxMB5ilOBgVhLhnbJQP02INyWxsiq1KD++qDQntfgQozQHi5I4
 r+GM2SlCAumJJanZqakFqUUwWSYOTqkGJl02p0yRrlVrH22516rTIFc42/3uhmoHVe4p6pan
 Zb1mNsc2lm6W2+JqsZypKLX/hPGmJWbVh1eYBT5c+mrJ5WUe061VUu66+JUxSbhXWkhucVH4
 tazWOF+FfzYvQxT30bl9796fVFOLbY3oknL6of1dwvjp156zNvUTcuZHLwo4bP0z3qrht8qN
 FeZZkhyX3s601f5j8uqHZvo0WRWxUznitd03avZemZ4SvS6Ma1q31tHPjW92XeAXNnMRmSg6
 o1FX38LwrY5lwRoB5W2106R+Oa2Wusw39+CCnRtSVu73O/Fbcw/jnrfhX16Z5Ny70CUtu75t
 ZWrynR9K7DE5GzduF4gsdvsb2hcukqipxFKckWioxVxUnAgAQyKyZfQCAAA=
X-CMS-MailID: 20240429223402epcas1p3bd2fc856c3ae2cf53b1b223f38c30a10
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240426103830epcas1p3720a09dd50c8ef3d16de0a6ff2ff514b
References: <CGME20240426103830epcas1p3720a09dd50c8ef3d16de0a6ff2ff514b@epcas1p3.samsung.com>
 <e6c74bd0-de66-42ef-a6af-0d5c058b12a0@samsung.com>
 <20240426155154.GK1054907@bill-the-cat>
 <33db14f4-f3f0-4e5f-a256-2ce9b5c505fd@ti.com>
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

Dear Judith,

> -----Original Message-----
> From: Judith Mendez <jm@ti.com>
> Sent: Tuesday, April 30, 2024 5:40 AM
> To: Tom Rini <trini@konsulko.com>; Jaehoon Chung <jh80.chung@samsung.com>
> Cc: U-Boot Mailing List <U-Boot@lists.denx.de>; maximilian.brune@9elements.com;
> curtis.machida@intel.com; Jonas Karlman <jonas@kwiboo.se>; greg.malysa@timesys.com;
> ian.roberts@timesys.com; Jae hoon Chung <jh80.chung@gmail.com>; Peng Fan <peng.fan@nxp.com>;
> sheng.tan@9elements.com
> Subject: Re: [GIT PULL] Please pull u-boot-mmc master
>
> Hi all,
>
> On 4/26/24 10:51 AM, Tom Rini wrote:
> > On Fri, Apr 26, 2024 at 07:38:30PM +0900, Jaehoon Chung wrote:
> >
> >> Dear Tom,
> >>
> >> Please pull u-boot-mmc master into u-boot master branch.
> >> If there is any problem, let me know, plz
> >>
> >> Best Regards,
> >> Jaehoon Chung
> >>
> >> CI: https://protect2.fireeye.com/v1/url?k=aa60f1d5-cbebe4f5-aa617a9a-74fe485fb347-
> 9095c5a77eabfca7&q=1&e=d67a142c-0b69-4de3-be99-de9292c603f2&u=https%3A%2F%2Fsource.denx.de%2Fu-
> boot%2Fcustodians%2Fu-boot-mmc%2F-%2Fpipelines%2F20547
> >>
> >> The following changes since commit d097f9e1299a3bdb7de468f0d9bbc63932f461cd:
> >>
> >>    Merge tag 'fsl-qoriq-2024-4-24' of https://protect2.fireeye.com/v1/url?k=93e2c287-f269d7a7-
> 93e349c8-74fe485fb347-247fe01368500b3b&q=1&e=d67a142c-0b69-4de3-be99-
> de9292c603f2&u=https%3A%2F%2Fsource.denx.de%2Fu-boot%2Fcustodians%2Fu-boot-fsl-qoriq (2024-04-23
> 17:53:06 -0600)
> >>
> >> are available in the Git repository at:
> >>
> >>    git@source.denx.de:u-boot/custodians/u-boot-mmc.git master
> >>
> >> for you to fetch changes up to 1776213dadef4b578f98bcf18beb152f8975a8bf:
> >>
> >>    mmc: arm_pl180: Limit data transfer to U16_MAX (2024-04-26 15:32:06 +0900)
> >>
> >
> > Applied to u-boot/master, thanks!
> >
>
>
> A patch in this series caused a regression for AM62x SK with the
> following error:
>
> Error reading cluster
> spl_load_image_fat: error reading image u-boot.img, err - -22
> SPL: failed to boot from all boot devices (err=-6)
> ### ERROR ### Please RESET the board ###
>
> Git bisect showed "mmc: sdhci: introduce adma_write_desc() hook to
> struct sdhci_ops" to be the offending commit.
>
> Could someone point me to the next steps to fix this issue?

I will check this problem. Thanks for pointing out.

Best Regards,
Jaehoon Chung

>
> regards,
> Judith


