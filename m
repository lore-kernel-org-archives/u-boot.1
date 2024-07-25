Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A81E5C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 07:48:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D69E188800;
	Thu, 25 Jul 2024 09:48:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="QcoqNSzG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDF5D88800; Thu, 25 Jul 2024 09:48:31 +0200 (CEST)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6588C88970
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 09:48:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mk7.kang@samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20240725074825epoutp02b6f56b75e21d9291491c449447c92ed2~lZTO8UAeF1673516735epoutp02N
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 07:48:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20240725074825epoutp02b6f56b75e21d9291491c449447c92ed2~lZTO8UAeF1673516735epoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1721893705;
 bh=3AYTguwYzC4/p3vKzpRW8Iw1/6TUo+dAJ6bXmnK/fvI=;
 h=From:To:Subject:Date:References:From;
 b=QcoqNSzGL3yctNc/gSt6E61gqFNTQS7dNvBk7ykuDtMH7SvElZLB+GsIFIaYCKpMA
 YtqpPjeUVHCBKPmOr7oJ+w33Zcr7aTjSq2wdfDka2DvJpCOBLcxM4f2Lo8pG2z9GNQ
 jF11bgkCzo+ne/d3mmTHtNF+Du7K3g9hOMQFWvVw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20240725074825epcas1p3a8ca8c42cd6fdfa4ea318a215039d755~lZTOwvoGu1226012260epcas1p3q;
 Thu, 25 Jul 2024 07:48:25 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.226]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4WV30S2CLcz4x9Q4; Thu, 25 Jul
 2024 07:48:24 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
 A9.32.09734.84302A66; Thu, 25 Jul 2024 16:48:24 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
 20240725074823epcas1p322c0dce4e14b4c5379d6a703a40ad56a~lZTNm9P4M1232212322epcas1p3g;
 Thu, 25 Jul 2024 07:48:23 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240725074823epsmtrp1ecc8fa2283ea945c299fd2fe2c4ed8fa~lZTNmK4RF0517905179epsmtrp1u;
 Thu, 25 Jul 2024 07:48:23 +0000 (GMT)
X-AuditID: b6c32a39-b5dfa70000002606-af-66a203485665
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 44.E3.08964.74302A66; Thu, 25 Jul 2024 16:48:23 +0900 (KST)
Received: from mk7kang01 (unknown [10.88.105.222]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20240725074823epsmtip23789667f13cdcfc980e69c122efdcf7d~lZTNZnNBN2874928749epsmtip2_;
 Thu, 25 Jul 2024 07:48:23 +0000 (GMT)
From: "Minkyu Kang" <mk7.kang@samsung.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: Please pull u-boot-samung master
Date: Thu, 25 Jul 2024 16:48:23 +0900
Message-ID: <005a01dade67$06c766e0$145634a0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdreZv8kVRHPP7brRR+gvvMDDbR/QQ==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7bCmvq4H86I0g/U3eSymTtrMbvF2bye7
 A5PHqwOr2D3O3tnBGMAUlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ib
 aqvk4hOg65aZAzRfSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgVqBXnJhbXJqX
 rpeXWmJlaGBgZApUmJCdceFCK1vBDIGK9/9dGxj7eLoYOTkkBEwkHjU/Yeti5OIQEtjBKLH+
 YBcLhPOJUWLPm7dQmW+MEm1r7rHBtJza0cEIkdjLKNEy/Sk7SEJI4DmjxIqPMiA2m4CWxN+F
 51lBbBEBA4ktB3eA2cICmhJXzh8As1kEVCVmHekAs3kFLCU+nn7DCGELSpyc+YQFxGYWkJfY
 /nYOM8RiBYmfT5cB1XMAzdSTuPS1AKJERGJ2ZxszyD0SAtvYJZ5O6GSCqHeR2Dn/K5QtLPHq
 +BZ2CFtK4mV/GztEw2RGiUmLnjFCOOsZJQ7P+sAIUWUscXP9BrBtzEBXr9+lD7GNT+Ld1x6w
 sIQAr0RHmxBEtZLEgQsHoDolJGZf384KYXtIdK6ezQIJn1iJpw9fM09glJ+F5M1ZSN6cheSf
 WQiLFzCyrGIUSy0ozk1PLTYsMIVHcHJ+7iZGcHLTstzBOP3tB71DjEwcjIcYJTiYlUR4l91f
 mCbEm5JYWZValB9fVJqTWnyI0RQY8BOZpUST84HpNa8k3tDE0sDEzMjEwtjS2ExJnPfMlbJU
 IYH0xJLU7NTUgtQimD4mDk6pBqaSO7WlzWJecf+PM9juqfm5med7g/m/z+pPTpslr3t7Lf1H
 St1R3f+xLvv1jx48O/WDYJ64498e9rgslm9TV6fnbbMV0hQIYNzj3CrVpjLldZ1xoq/t5PN3
 9MzWTlJvc3Ytz8kQdKg60Rabc4tZr+jB48hXu9mSeXt99V8+336754qXazt/olyZwfqYfYu+
 7xX54nAnprbHQ4PjkkKtx9ctLbuMo24knDowyVQiOef1iQ/fU43fTa7aahxis1ns/pRmiyvL
 U7Jvld/ctkVhqqeYxNPPruc2Ok+XqN66pK/c/qfr9d3806KvHD5yyzc378bUSfFZhYe0AgUE
 uSMusPA8yLotZH8nwtlV4a18gBJLcUaioRZzUXEiAKlIIVP3AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMLMWRmVeSWpSXmKPExsWy7bCSvK4786I0g18zjS2mTtrMbvF2bye7
 A5PHqwOr2D3O3tnBGMAUxWWTkpqTWZZapG+XwJVx4UIrW8EMgYr3/10bGPt4uhg5OSQETCRO
 7ehg7GLk4hAS2M0o0bl0JwtEQkJi0uwLTF2MHEC2sMThw8UQNU8ZJTa/mcAGUsMmoCXxd+F5
 VhBbRMBIonVDJxOILSygKXHl/AGwOIuAqsSsIx1gNq+ApcTH028YIWxBiZMzn7CAzGcW0JNo
 2wgWZhaQl9j+dg4zxAkKEj+fLmMFKREBKrn0tQCiRERidmcb8wRGgVlIBs1CGDQLyaBZSDoW
 MLKsYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIDlctzR2M21d90DvEyMTBeIhRgoNZ
 SYR32f2FaUK8KYmVValF+fFFpTmpxYcYpTlYlMR5xV/0pggJpCeWpGanphakFsFkmTg4pRqY
 jhXMCOiZrM59dh7fLLV1ibtOWCa8XxBSpMIRnXDEwut/03Phw6/67P+vX+l3gXNtQvPCQBu2
 SfZTp7NNNGKbWn1v35HV7k8KPLRkb+9bUya6RPGc+tEsU4kMf5V7D/2n/pq48nFhtEC3wf4l
 /9y6hMVuTf0QPff2MvMvPyQLL7o5fv8RVbJk2aX79s9e1X85HPajTcKzWY4vdmKRAZdZyrl+
 77Lit3pZ9u179iXmyluszTSYpdvmsXzmzEa7Mx+czW792V9WN71pC+fX57eXvTie+1Da/9c+
 rw8/7D19XBe6nX6oVSrTnswr6FDJJVHmkzBRhGPq3GWTZ2T2fFYPSuT+nf1uziShzayfG7/t
 VmIpzkg01GIuKk4EAHjPdrrGAgAA
X-CMS-MailID: 20240725074823epcas1p322c0dce4e14b4c5379d6a703a40ad56a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240725074823epcas1p322c0dce4e14b4c5379d6a703a40ad56a
References: <CGME20240725074823epcas1p322c0dce4e14b4c5379d6a703a40ad56a@epcas1p3.samsung.com>
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

Dear Tom,

The following changes since commit b182816c1fb436916661949213c543bf4d42250b:

  turris_1x: Normalize Kconfig usage (2024-07-13 10:42:15 -0600)

are available in the git repository at:

  git@source.denx.de:u-boot/custodians/u-boot-samsung.git master

for you to fetch changes up to 2269217bbddb3d729f6129dceda8da5b1c73ba05:

  arm: exynos: Enable TRNG on E850-96 board (2024-07-24 16:37:09 +0900)

----------------------------------------------------------------
Anand Moon (2):
      dm: exynos: Correct CONFIG_SYS_BOARD setting for Odroid XU3 boards
      odroid: Fix target platform compilation issue on Odroid-XU3

Sam Protsenko (5):
      board: samsung: e850-96: Add default partitions
      board: samsung: e850-96: Load LDFW firmware on board init
      clk: exynos: Add SSS clocks for Exynos850
      rng: Add Exynos TRNG driver
      arm: exynos: Enable TRNG on E850-96 board

 arch/arm/dts/exynos850-e850-96-u-boot.dtsi |  11 +++
 arch/arm/mach-exynos/Kconfig               |   2 +
 board/samsung/e850-96/Makefile             |   4 +-
 board/samsung/e850-96/e850-96.c            |   6 +-
 board/samsung/e850-96/e850-96.env          |  26 +++++++
 board/samsung/e850-96/fw.c                 | 131
+++++++++++++++++++++++++++++++++
 board/samsung/e850-96/fw.h                 |  12 +++
 board/samsung/odroid/Makefile              |   2 +-
 board/samsung/smdk5420/Kconfig             |   2 +-
 configs/e850-96_defconfig                  |   1 +
 drivers/clk/exynos/clk-exynos850.c         |  10 +++
 drivers/rng/Kconfig                        |  13 ++++
 drivers/rng/Makefile                       |   1 +
 drivers/rng/exynos-trng.c                  | 291
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 14 files changed, 506 insertions(+), 6 deletions(-)
 create mode 100644 board/samsung/e850-96/e850-96.env
 create mode 100644 board/samsung/e850-96/fw.c
 create mode 100644 board/samsung/e850-96/fw.h
 create mode 100644 drivers/rng/exynos-trng.c

Thanks,
Minkyu Kang.


