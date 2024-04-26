Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB88C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 10:38:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5737886A3;
	Fri, 26 Apr 2024 12:38:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="h8XdPnQ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 761D0886D4; Fri, 26 Apr 2024 12:38:40 +0200 (CEST)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40AE38869E
 for <U-Boot@lists.denx.de>; Fri, 26 Apr 2024 12:38:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20240426103833epoutp01da08502bbad4ed801770a305dc959bd7~JzkFgzqy81289912899epoutp01Y
 for <U-Boot@lists.denx.de>; Fri, 26 Apr 2024 10:38:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20240426103833epoutp01da08502bbad4ed801770a305dc959bd7~JzkFgzqy81289912899epoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1714127913;
 bh=RHW+GsqUjxPXPYXtgbvMfPp6Uf3QQm5onwqAX+7o3j8=;
 h=Date:To:Cc:From:Subject:References:From;
 b=h8XdPnQ0Y/GCDT70PyfK6eXsrfraL7WCjZDpqFXE4alHCqRzPjCjp60C+f12QDKpa
 BV9Kopk0jEBa1QNq1zeyRss1rKg37BKKJAUMnw4QbXovcV2+bMLKQ1aYk/oql10CNg
 ObM3ndfsAAceyBEQmlBahmZW5G4G4GQ/oWPi+luM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTP id
 20240426103832epcas1p4564baffda499d03e9b84646dd6b2d016~JzkE2EJCe2649026490epcas1p4p;
 Fri, 26 Apr 2024 10:38:32 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.234]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4VQq2H2cg2z4x9Pp; Fri, 26 Apr
 2024 10:38:31 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
 C2.96.10076.7248B266; Fri, 26 Apr 2024 19:38:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
 20240426103830epcas1p3720a09dd50c8ef3d16de0a6ff2ff514b~JzkDHZHBO2987029870epcas1p3l;
 Fri, 26 Apr 2024 10:38:30 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240426103830epsmtrp2065fd304945f2bf3cdfb7c55c368d09b~JzkDGrzlG2526125261epsmtrp26;
 Fri, 26 Apr 2024 10:38:30 +0000 (GMT)
X-AuditID: b6c32a39-7edf87000000275c-1e-662b842739cd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 C6.37.07541.6248B266; Fri, 26 Apr 2024 19:38:30 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20240426103830epsmtip14169f50a57c1e91f78042e1257d4cf5d~JzkC2GuNS1460814608epsmtip1v;
 Fri, 26 Apr 2024 10:38:30 +0000 (GMT)
Message-ID: <e6c74bd0-de66-42ef-a6af-0d5c058b12a0@samsung.com>
Date: Fri, 26 Apr 2024 19:38:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: U-Boot Mailing List <U-Boot@lists.denx.de>
Cc: maximilian.brune@9elements.com, curtis.machida@intel.com, Jonas Karlman
 <jonas@kwiboo.se>, greg.malysa@timesys.com, ian.roberts@timesys.com, Tom
 Rini <trini@konsulko.com>, Jae hoon Chung <jh80.chung@gmail.com>, Peng Fan
 <peng.fan@nxp.com>, sheng.tan@9elements.com
From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [GIT PULL] Please pull u-boot-mmc master
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRmVeSWpSXmKPExsWy7bCmga56i3aawe69vBbnPx1ntDj96QaL
 xcv795gsLl5Zymxx8s1VFouf98+xWPxY9YXVYs/nv+wWUydtZrd4u7eT3YHL4/o0O4+ds+6y
 eyze85LJ49WBVeweJyZcYvI4e2cHo8fGdzuYPPZu/8EUwBGVbZORmpiSWqSQmpecn5KZl26r
 5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdKSSQlliTilQKCCxuFhJ386mKL+0JFUh
 I7+4xFYptSAlp8C0QK84Mbe4NC9dLy+1xMrQwMDIFKgwITtj/6ZrzAVHeSuOfn7A1sD4hauL
 kYNDQsBE4uoFxy5GLg4hgR2MEncWX2GEcD4xShw8fx3K+cYoMfnCCvYuRk6wjrY5h1kgEnsZ
 JdZPOc4K4bxnlFgw8x1YFa+AncSM4xcZQWwWAVWJ9ZcuMkHEBSVOznzCAmKLCshL3L81A6ye
 WUBc4taT+WA1IgJ6Eo/PHgUbyiwwkUniUOs2sEFsAjoS278dBysSFjCUeHzzBCtEs7zE9rdz
 mEEaJASWcki07J3MBnGri8TFvXOg7haWeHV8C5QtJfH53V42iIZmRomlSw6yQjg9jBL/Gq5D
 dRtL7F86mQkUTswCmhLrd+lDbOOTePe1hxUSfLwSHW1CENUqEpdev2SCmX/3yX+oEg+J+/dy
 QcJCArES0650sk9glJ+FFBazkPw/C8k7sxD2LmBkWcUollpQnJueWmxYYAqP4uT83E2M4FSr
 ZbmDcfrbD3qHGJk4GA8xSnAwK4nw3vyokSbEm5JYWZValB9fVJqTWnyI0RQYIxOZpUST84HJ
 Pq8k3tDE0sDEzMjYxMLQzFBJnPfMlbJUIYH0xJLU7NTUgtQimD4mDk6pBqb9q4v29V/799hA
 ZpdC8vQ4czHmFzzX1/ywvdV6QfCPt/1i35xikzhnr9UhdSXblB1EdCdWRYjZXvg7TWLa4bx0
 bfXSpXc+fE1bLMZcvyLpHsO0HK4EpkrrfJ6qk4kX9AuLMtaZSQb9im//5FqwawFz/p+3ug2S
 hr82nnCYu/2f0txrt3sKVshcvbLx+py97rE7V/Os/FHx/q9CbY6f4ZKpfxc0rLoUeKreT+Wf
 x/GEoxP1L1W1vpy+jmVz24toWctzUxkOr93sMDmUtWeCJ5NJwO8dV+5pr8wymbff6HlQsnen
 +zXXqF1bc757/suPiFn422CN+UVJqedzyty8Ti2961qh1PvOt+jPj9jeS1VKLMUZiYZazEXF
 iQANSisoPgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsWy7bCSnK5ai3aaQVu/tsX5T8cZLU5/usFi
 8fL+PSaLi1eWMlucfHOVxeLn/XMsFj9WfWG12PP5L7vF1Emb2S3e7u1kd+DyuD7NzmPnrLvs
 Hov3vGTyeHVgFbvHiQmXmDzO3tnB6LHx3Q4mj73bfzAFcERx2aSk5mSWpRbp2yVwZezfdI25
 4ChvxdHPD9gaGL9wdTFyckgImEi0zTnM0sXIxSEksJtR4tO2j2wQCSmJz0+nAtkcQLawxOHD
 xRA1bxklbu+5zQJSwytgJzHj+EVGEJtFQFVi/aWLTBBxQYmTM5+A1YgKyEvcvzWDHcRmFhCX
 uPVkPliNiICexOOzR1lBhjILTGaSmLtyCzNIgk1AR2L7t+NgRcIChhKPb55gBTmCWUBdYv08
 IYg58hLb385hnsAoMAvJullIVsxC6JiFpGMBI8sqRsnUguLc9NxkwwLDvNRyveLE3OLSvHS9
 5PzcTYzg+NHS2MF4b/4/vUOMTByMhxglOJiVRHhvftRIE+JNSaysSi3Kjy8qzUktPsQozcGi
 JM5rOGN2ipBAemJJanZqakFqEUyWiYNTqoFpZXhwzrprVdZ/9ZqPq+Sw3Hn4dcKzZzsFn6TJ
 PHYoLp67MIz7/qZ3s1Z9upX5/GRbaVPW+fm8Exv0/m6wC/gxobTVViO1fvqlfK2f0f0r77sk
 JtasNTc69HaNQAVny5P5pQx8Iv5TTMuTJykfL1j3ZNWkyk0NFk9+lJ1Z/ESdZ7c6R4XGPPdT
 KwS1bRI3ZfZe0ZS2/RrHZ7C+jL3xy+QTzyNDT2x5dcVL8PC2ekXTjUtEZaR9WO8xZsm5H9Lr
 tA1jqNmjudYx5HpJWOzdLtEpO42KVXSDbXaoyhjujdh0Usv9xKvSDmVXlqKEc8VPb8/vex7A
 luHdH6uWdP3hL7l3VpfeTDt20uZl8d3WwHglluKMREMt5qLiRAAus1NoDgMAAA==
X-CMS-MailID: 20240426103830epcas1p3720a09dd50c8ef3d16de0a6ff2ff514b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240426103830epcas1p3720a09dd50c8ef3d16de0a6ff2ff514b
References: <CGME20240426103830epcas1p3720a09dd50c8ef3d16de0a6ff2ff514b@epcas1p3.samsung.com>
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

Please pull u-boot-mmc master into u-boot master branch.
If there is any problem, let me know, plz

Best Regards,
Jaehoon Chung

CI: https://source.denx.de/u-boot/custodians/u-boot-mmc/-/pipelines/20547

The following changes since commit d097f9e1299a3bdb7de468f0d9bbc63932f461cd:

  Merge tag 'fsl-qoriq-2024-4-24' of https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq (2024-04-23 17:53:06 -0600)

are available in the Git repository at:

  git@source.denx.de:u-boot/custodians/u-boot-mmc.git master

for you to fetch changes up to 1776213dadef4b578f98bcf18beb152f8975a8bf:

  mmc: arm_pl180: Limit data transfer to U16_MAX (2024-04-26 15:32:06 +0900)

----------------------------------------------------------------
Greg Malysa (1):
      mmc: Support 32-bit only ADMA on 64-bit platforms

Ian Roberts (2):
      mmc: sdhci: introduce adma_write_desc() hook to struct sdhci_ops
      mmc: sdhci: Fix potential ADMA descriptor table overflow

Jonas Karlman (2):
      mmc: Imply HS200 cap with mmc-hs400 prop to match linux
      mmc: Add support for the no-mmc-hs400 prop

Maximilian Brune (1):
      mmc: arm_pl180: Limit data transfer to U16_MAX

cmachida (1):
      mmc: sdhci: programmable clock calculation needs multiplier +1

 drivers/mmc/Kconfig          | 18 ++++++++++++++++++
 drivers/mmc/arm_pl180_mmci.c | 10 ++++++++++
 drivers/mmc/fsl_esdhc.c      |  2 +-
 drivers/mmc/mmc-uclass.c     |  7 +++++--
 drivers/mmc/sdhci-adma.c     | 43 +++++++++++++++++++++++++++++--------------
 drivers/mmc/sdhci.c          | 26 ++++++++++++++++++--------
 include/sdhci.h              | 21 +++++++++++++++------
 7 files changed, 96 insertions(+), 31 deletions(-)
