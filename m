Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A59C4332F
	for <u-boot@archiver.kernel.org>; Mon, 30 Oct 2023 07:33:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FFFD879FD;
	Mon, 30 Oct 2023 08:32:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="ajHIeqGi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7046A870BB; Mon, 30 Oct 2023 08:32:38 +0100 (CET)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B20D8879EA
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 08:32:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20231030073231epoutp027aa95e6939f43270ab45a24df149c325~S0jjV5D611529515295epoutp028
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 07:32:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20231030073231epoutp027aa95e6939f43270ab45a24df149c325~S0jjV5D611529515295epoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698651151;
 bh=0q3i0UCD6EfxR9kYbpIf1xarbmPU4afcMNTxO5H19tQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ajHIeqGicKScmrVUwypYAoMlkGb7fAyXd9gAZX2Kpc3IXv0tDkod+AuwgBtfwkx/A
 WYr0MQAad65sMvg3sF6DISboMpyl+9Hc+K0TlGoNPq0Z6/g9O+dg0Ll5ZbqSMKhkWW
 RBNKjuP5MWpbQauP7sJpH8MKS3CkdrtY2MJep+yw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20231030073230epcas2p4051be0751abcf29e7319d62b24b80589~S0ji8jbCN3064430644epcas2p4D;
 Mon, 30 Oct 2023 07:32:30 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.100]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4SJlNF6yTfz4x9QJ; Mon, 30 Oct
 2023 07:32:29 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
 epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 9B.15.10006.D0C5F356; Mon, 30 Oct 2023 16:32:29 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
 20231030073229epcas2p1012dde729d0a79382c86a5a8bbc46ae5~S0jiCxjhj2123721237epcas2p1i;
 Mon, 30 Oct 2023 07:32:29 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20231030073229epsmtrp2337fb27039af8ae549eac81a641d1e06~S0jiCJln_2856128561epsmtrp2s;
 Mon, 30 Oct 2023 07:32:29 +0000 (GMT)
X-AuditID: b6c32a45-3ebfd70000002716-a5-653f5c0d9461
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 49.A2.08817.D0C5F356; Mon, 30 Oct 2023 16:32:29 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20231030073229epsmtip12e83fb865903597f8aec82b8b8cfdf3f~S0jh0tOLY0286002860epsmtip1n;
 Mon, 30 Oct 2023 07:32:29 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Rick Chen <rick@andestech.com>, Leo
 <ycliang@andestech.com>, u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH 5/5] configs: visionfive2: Enable JH7110 RNG driver
Date: Mon, 30 Oct 2023 16:32:04 +0900
Message-Id: <20231030073204.150030-6-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231030073204.150030-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42LZdljTTJc3xj7VoGWuhcXl/doWb1+cZbS4
 d03O4u3eTnaLw1M/MFo8PvSayYHNY8/pWcweHz7Gedy5tofN4+ydHYwefVtWMQawRmXbZKQm
 pqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gDtV1IoS8wpBQoF
 JBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBfoFSfmFpfmpevlpZZYGRoYGJkCFSZkZ1y6ep6p
 YDdrxZHOzywNjE9Zuhg5OCQETCQ+L/bsYuTiEBLYwSgxed85FgjnE6NET8tPNgjnG6PE6b4p
 zF2MnGAd39qfMEEk9jJKHGtZywrhTGOSuP1sCitIFZuArsSW568YQRIiAqsZJbbtb2YHSTAL
 aEt0fp7CDrJcWMBZoutuJkiYRUBV4sHdPrBeXgF7iRVvV7NC3CcvsfiBBEiYU8BBYsmU/0wQ
 JYISJ2c+YYGYKC/RvHU2M8gqCYF77BK3V56F+s1F4uEFRoijhSVeHd/CDmFLSXx+t5cNoqRc
 YseyJIjWFkaJ5rY9UE/aS/y4OQXsBGYBTYn1u/QhypUljtyC2son0XH4LztEmFeio00IolFd
 4sD26SwQtqxE95zPrBC2h8TqPz+gATWZUeJex1K2CYwKs5A8MwvJM7MQFi9gZF7FKJZaUJyb
 nlpsVGAIj97k/NxNjODEqOW6g3Hy2w96hxiZOBgPMUpwMCuJ8DI72qQK8aYkVlalFuXHF5Xm
 pBYfYjQFhvREZinR5Hxgas4riTc0sTQwMTMzNDcyNTBXEue91zo3RUggPbEkNTs1tSC1CKaP
 iYNTqoFpBVvj7n3nMrccXtG6bEKSocyt2/83PnFMZA9/Wri5TbzWYFWUfeqG1fMV47N6Lx0Q
 9n378EKEZM3cR0J7Uq7e3OF5UvTtu49uivMiBTR4mrOKr+b/m5N2e95czt6jX99wHZk4VXlX
 E8/WEq7wyYeqrfnLNki9P5DVO1nnVtPxeZ5q3TXelldOcn2b9dK+lv3ZNcvnnFeLrtXt0Zug
 0bPhnodygTXH5MN1sY8UC13c5mR+OJDyvoHj/sOtq0/wiiYbX41T8dew5tgvddf4bHPzlaYt
 X152fz2WenKzY02Y8H1dBetzLB92Te6ZxF18NvrbpwKrL1uFAq6bSUQ9n825NF1LuzimRave
 d3fP7elPlViKMxINtZiLihMBiHivxRUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPLMWRmVeSWpSXmKPExsWy7bCSnC5vjH2qwZS/ihaX92tbvH1xltHi
 3jU5i7d7O9ktDk/9wGjx+NBrJgc2jz2nZzF7fPgY53Hn2h42j7N3djB69G1ZxRjAGsVlk5Ka
 k1mWWqRvl8CVcenqeaaC3awVRzo/szQwPmXpYuTkkBAwkfjW/oSpi5GLQ0hgN6PE/PnNzBAJ
 WYln73awQ9jCEvdbjrBCFE1ikpj9fgMjSIJNQFdiy/NXjCAJEYH1jBI/lr9nBUkwC2hLdH6e
 AtTNwSEs4CzRdTcTJMwioCrx4G4fWAmvgL3EirerWUFKJATkJRY/kAAJcwo4SCyZ8p8JxBYC
 Knn85hNUuaDEyZlPWCCmy0s0b53NPIFRYBaS1CwkqQWMTKsYJVMLinPTc4sNC4zyUsv1ihNz
 i0vz0vWS83M3MYLDWEtrB+OeVR/0DjEycTAeYpTgYFYS4WV2tEkV4k1JrKxKLcqPLyrNSS0+
 xCjNwaIkzvvtdW+KkEB6YklqdmpqQWoRTJaJg1OqgalUr3JCzsEfjQsMC1QZujXPySa/336l
 huVGzGED7ojgtal+kXbLLohqi7Ra2olO7bEpeHK8/8iygqyCSfbBUS+37bu2hvPOTcmTNszT
 +4riNRVftAs15fzRz3r2YBuDlIK42z8z0wjd+pc3LvwLsOf7emv1C1aBqIMly+9zZdjaWvLe
 t90xLVTmYux1lgPvs0q2TWh0eOjZ/syf4f5J03uMGQc2nMzfPvPoxWTRF0+K7EQz5m5X5+yx
 aXmnt/Zoer3XFZX5S1olw7feyloqy7d436WEB1tm+dmGuc3oZr6tM8XmJ4OX8Ur9yAaLnKkb
 DacFJBeEFi/MfqtT1LbktPixXXWnncwZDablt1isUGIpzkg01GIuKk4EAG2s6TjSAgAA
X-CMS-MailID: 20231030073229epcas2p1012dde729d0a79382c86a5a8bbc46ae5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231030073229epcas2p1012dde729d0a79382c86a5a8bbc46ae5
References: <20231030073204.150030-1-chanho61.park@samsung.com>
 <CGME20231030073229epcas2p1012dde729d0a79382c86a5a8bbc46ae5@epcas2p1.samsung.com>
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

Enables JH7110 RNG driver to visionfive2 board.

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 configs/starfive_visionfive2_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index b21754feafce..b15e7d24db19 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -120,6 +120,8 @@ CONFIG_SPL_PINCTRL_STARFIVE=y
 CONFIG_SPL_PINCTRL_STARFIVE_JH7110=y
 CONFIG_PINCTRL_STARFIVE=y
 # CONFIG_RAM_SIFIVE is not set
+CONFIG_DM_RNG=y
+CONFIG_RNG_JH7110=y
 CONFIG_SYS_NS16550=y
 CONFIG_CADENCE_QSPI=y
 CONFIG_TIMER_EARLY=y
-- 
2.39.2

