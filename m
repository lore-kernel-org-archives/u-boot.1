Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC16CD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 08:54:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95B78883E2;
	Thu,  4 Apr 2024 10:54:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="bW3OAXu1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54F97883EF; Thu,  4 Apr 2024 10:54:19 +0200 (CEST)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2F9088253
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 10:54:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mk7.kang@samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20240404085413epoutp03e491636f36859abe209d289f6558ab9e~DB8tcJ4UO2717027170epoutp03U
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 08:54:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20240404085413epoutp03e491636f36859abe209d289f6558ab9e~DB8tcJ4UO2717027170epoutp03U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1712220853;
 bh=QAJPgHuhJP1oQ/sQcPkxbmALdUgXRVq0f/sbPLQeYBo=;
 h=From:To:Cc:Subject:Date:References:From;
 b=bW3OAXu1GsOW+tb4RSyvtxyaTTQU3HQcq07qSqiEWz2Z6IKfWAHjEZ+5fBmRf9/7N
 IsoMe+35i32rCXfSjF86kgSNW6GCQFmT0FgJuMlEpd9B6NJYyMkMWPcZ4TRxH22SCH
 dZHKJFPFe81NmmVKikssCaChl6+sERjWAlibaXYs=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20240404085413epcas1p30e6ae7f80c1dcf13801f2f4fb640b54b~DB8tQ5p2s2804828048epcas1p3X;
 Thu,  4 Apr 2024 08:54:13 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.243]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4V9Fm415gLz4x9Px; Thu,  4 Apr
 2024 08:54:12 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
 epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 33.45.08627.3BA6E066; Thu,  4 Apr 2024 17:54:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
 20240404085411epcas1p3f10e648bd35670e090592cb4fbb97d58~DB8rbMrrg2425524255epcas1p3R;
 Thu,  4 Apr 2024 08:54:11 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240404085411epsmtrp2352e4ed02e8e4466fd9fe3951577776d~DB8rakNA-1630116301epsmtrp2C;
 Thu,  4 Apr 2024 08:54:11 +0000 (GMT)
X-AuditID: b6c32a33-af9ff700000021b3-89-660e6ab37a06
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 50.5E.08924.3BA6E066; Thu,  4 Apr 2024 17:54:11 +0900 (KST)
Received: from mk7kang01 (unknown [10.88.105.222]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20240404085411epsmtip12c87de71b843cc61c2b9f305d064fe09~DB8rRtz6U0481004810epsmtip1Y;
 Thu,  4 Apr 2024 08:54:11 +0000 (GMT)
From: "Minkyu Kang" <mk7.kang@samsung.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>
Cc: <promsoft@gmail.com>
Subject: Please pull u-boot-samsung master
Date: Thu, 4 Apr 2024 17:54:10 +0900
Message-ID: <1ff501da866d$a93e2370$fbba6a50$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdqGbZUqRMuAGNZVR7aovJ3CiP5N4Q==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDKsWRmVeSWpSXmKPExsWy7bCmru7mLL40gw3LlC2mPjjHaDF10mZ2
 i7d7O9kdmD12zrrL7vHqwCp2j7N3djAGMEdl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY
 6hpaWpgrKeQl5qbaKrn4BOi6ZeYAbVJSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTk
 FJgV6BUn5haX5qXr5aWWWBkaGBiZAhUmZGcsetvAWtDOWfHn4TOWBsYl7F2MnBwSAiYSj17c
 Yupi5OIQEtjBKHHi8ns2COcTo8Tir3MZIZxvjBJr9rxlhGm5+mw5K0RiL6PEwonn2SGc54wS
 l69vZgOpYhPQkvi78DwriC0iYCBxYuYrsDizgIREz4s7TCC2MFDNrwvPwOIsAioS0za/ZAax
 eQUsJb68W8sOYQtKnJz5hAWiV15i+9s5zBBXKEj8fLoMaD4H0Hw9iRU/iyBKRCRmd7Yxg9wj
 IXCOXeL6g9VMEPUuEg8nbWGDsIUlXh3fAg0AKYnP7/ayQTRMZpSYtOgZI4SznlHi8KwPUD8b
 S9xcvwFsG7OApsT6XfoQ2/gk3n3tAQtLCPBKdLQJQVQrSRy4cACqU0Ji9vXtrBC2h8TJLafB
 9goJxEo8fz6fdQKjwiwkb85C8uYsJP/MQli8gJFlFaNYakFxbnpqsmGBITy6k/NzNzGCk6GW
 8Q7Gy/P/6R1iZOJgPMQowcGsJMLb7cCbJsSbklhZlVqUH19UmpNafIjRFBjwE5mlRJPzgek4
 ryTe0MTSwMTMyMTC2NLYTEmc98yVslQhgfTEktTs1NSC1CKYPiYOTqkGpo5oi13HIxOTolrY
 3q5eJxjRJmV/XYcrOH69LdOyLrc9pyZ5iXl6Rm2cK+226lzy4UJt36ViJimGEsfKO1Wf2Bqc
 DAz/Wxy6cCvTxODFebcTLnEcKzh9y/aXxz7WYEmNdYd9P5yUkvNo+HshbsMDx4WfWFesDYt5
 HMH6Oie4T2PPShGHBbK3PPQaexgnbbZkenndatOE5uLtaZwb7gce5t5cmqLlcyB5wfWmo3+X
 Ccxg//T9l2PlVcP/8z7PbPcSkWJ2XnfKWzvBuOln4525z/zF6y897z5eoxZpp16T0y2z96hJ
 YcPaM+0+AorTFNy/Oar8dLq7yVb5sdte7Zk1sT027gXd39v0o0urFZ4rsRRnJBpqMRcVJwIA
 aY8fAQ8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsWy7bCSnO7mLL40gw+z2CymPjjHaDF10mZ2
 i7d7O9kdmD12zrrL7vHqwCp2j7N3djAGMEdx2aSk5mSWpRbp2yVwZSx628Ba0M5Z8efhM5YG
 xiXsXYycHBICJhJXny1n7WLk4hAS2M0o0Tb1JytEQkJi0uwLTF2MHEC2sMThw8UQNU8ZJZ4s
 OAPWzCagJfF34XlWkBoRASOJyW9FQcLMQK09L+4wgdjCQCW/LjxjA7FZBFQkpm1+yQxi8wpY
 Snx5t5YdwhaUODnzCQvIGGYBPYm2jYwQY+Qltr+dwwxxjYLEz6fLoDbpSaz4WQRRIiIxu7ON
 eQKj4Cwkg2YhDJqFZNAsJB0LGFlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIEh7aW
 5g7G7as+6B1iZOJgPMQowcGsJMLb7cCbJsSbklhZlVqUH19UmpNafIhRmoNFSZxX/EVvipBA
 emJJanZqakFqEUyWiYNTqoFpabvyZJuJpVJrnzFVTX7Zbb5Wr+ySLAezyKvCqadn//ty7ua+
 pnKl69qZCa0tL1Wfnjp89kbmo3zbpTVOTPYrPm+6/SdGLIrlZlzh5Jz0sAlLV1W/PrnO41mK
 yt3ORV19FsvXmuxoPNcpu8svxq3mhc75EK7fS325ZHj/GQqrnRM7GbU36dHJPJYnVxTfXHaw
 1QqfLxGSy8iazS26LOT9/h/qH/5scUpPynW8Hz9twdsW3lNsE3bnvE4yu8lqaVesmD2J777Y
 85//dzf0tEQJV2TuSF+1jm9vUaVXaXFHmy/74Uvz9lvYPTnL+OHlgzouP5fi8wVOSq4PCjxi
 72xMlHAri3i1ON1Afet3pelKLMUZiYZazEXFiQA/+9vq3AIAAA==
X-CMS-MailID: 20240404085411epcas1p3f10e648bd35670e090592cb4fbb97d58
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240404085411epcas1p3f10e648bd35670e090592cb4fbb97d58
References: <CGME20240404085411epcas1p3f10e648bd35670e090592cb4fbb97d58@epcas1p3.samsung.com>
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

The following changes since commit dde373bde392c38649c8c4420e0c98ef8d38d9dc:

  Prepare v2024.04-rc5 (2024-03-25 21:56:50 -0400)

are available in the git repository at:

  git@source.denx.de:u-boot/custodians/u-boot-samsung.git master

for you to fetch changes up to 1751ba9a3b79ea5083ff5c4de58fe3bd9588f32a:

  clk: exynos: Add CMU_CORE and CMU_HSI for Exynos850 (2024-03-26 18:56:55
+0900)

----------------------------------------------------------------
Sam Protsenko (4):
      clk: exynos: Re-arrange clocks in Exynos850 CMU_TOP
      clk: exynos: Don't expose prototypes for not used functions
      clk: exynos: Fix incorrect clock lookup for non-top CMUs
      clk: exynos: Add CMU_CORE and CMU_HSI for Exynos850

 drivers/clk/exynos/clk-exynos850.c | 326
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 drivers/clk/exynos/clk-pll.c       |   6 +-
 drivers/clk/exynos/clk-pll.h       |   6 ++
 drivers/clk/exynos/clk.c           |  47 ++++++----
 drivers/clk/exynos/clk.h           |  70 ++++++++++-----
 5 files changed, 384 insertions(+), 71 deletions(-)

Thanks,
Minkyu Kang.


