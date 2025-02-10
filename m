Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92618C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 04:35:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAD2B80548;
	Mon, 10 Feb 2025 05:35:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="UmKJnEPN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 647C5807FE; Mon, 10 Feb 2025 05:35:20 +0100 (CET)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3D82803B5
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 05:35:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mk7.kang@samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20250210043513epoutp0435743d3e68e0deab4ea70e8c2053cc48~ivrpY6yfS1789017890epoutp04Z
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 04:35:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20250210043513epoutp0435743d3e68e0deab4ea70e8c2053cc48~ivrpY6yfS1789017890epoutp04Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1739162113;
 bh=VksEovrpqGsXaVRuOyoYtNUVSdoZ+4i7sYyOmcbOPtE=;
 h=From:To:Subject:Date:References:From;
 b=UmKJnEPNnTxak4sAFyMDLXSMFnMlaHtsqeJJBKHAMxOqK5BGwvApcNrFWkpXZrHfl
 jiTZbuppU19lHU8dk48lWjQzREv9/5BKpwrwligiFV00z98MWilTsDoVzpigC+zBZ8
 pwBfFVhB2zIBkgNEnb+no1oxyLfe2v5G5k+Ho6SM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20250210043513epcas1p3843be917ae4400c70d0259e06a185ada~ivrpGbDM51706217062epcas1p3C;
 Mon, 10 Feb 2025 04:35:13 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.225]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4YrsFD3Ffcz4x9QJ; Mon, 10 Feb
 2025 04:35:12 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 18.49.21650.FF189A76; Mon, 10 Feb 2025 13:35:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
 20250210043511epcas1p33ed93b581644b1a1a14a8710afeaaf97~ivrnjXNpL1734817348epcas1p3P;
 Mon, 10 Feb 2025 04:35:11 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20250210043511epsmtrp2ae63c6b5dca94bded9f06c4088d0bbbe~ivrnim0AD3195231952epsmtrp28;
 Mon, 10 Feb 2025 04:35:11 +0000 (GMT)
X-AuditID: b6c32a35-09bdf70000005492-9b-67a981ff5683
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 BD.F6.23488.FF189A76; Mon, 10 Feb 2025 13:35:11 +0900 (KST)
Received: from mk7kang01 (unknown [10.88.105.222]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20250210043511epsmtip1ff86763a6389934761955157b85f1c71~ivrnXMHvU0204802048epsmtip1-;
 Mon, 10 Feb 2025 04:35:11 +0000 (GMT)
From: "Minkyu Kang" <mk7.kang@samsung.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>
Subject: Please pull u-boot-samsung master
Date: Mon, 10 Feb 2025 13:35:11 +0900
Message-ID: <00bb01db7b75$2be04630$83a0d290$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Adt7XiK5Uckb5cFFTXWyiJf8Ak7pLg==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKKsWRmVeSWpSXmKPExsWy7bCmvu7/xpXpBrO+2FhMnbSZ3eLt3k52
 ByaPVwdWsXucvbODMYApKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE3
 1VbJxSdA1y0zB2i+kkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafArECvODG3uDQv
 XS8vtcTK0MDAyBSoMCE7Y+r5A6wFM7gqTk2+z9bAuJiji5GTQ0LAROLipcUsXYxcHEICOxgl
 lt94xw7hfGKUaH//hRnC+QaUOfCLHaZl0sxeVojEXkaJNcdvgCWEBJ4zSiw6Vw5iswloSfxd
 eJ4VxBYRMJA4MfMVG4gtDBT/deEZmM0ioCrxvXcbmM0rYClxavtOVghbUOLkzCcsIDazgLzE
 9rdzmCEWK0j8fLoMaqaeRNvhtcwQNSISszvbwC6VENjELrHxyx2ggziAHBeJpbOrIXqFJV4d
 3wL1gJTE53d72SDqJzNKTFr0jBHCWc8ocXjWB0aIKmOJm+s3sIIMYhbQlFi/Sx9iGZ/Eu689
 rBDzeSU62oQgqpUkDlw4ANUpITH7+nZWCNtDYsL0JSyQ8ImVuH3yLvsERvlZSN6cheTNWUje
 mYWweAEjyypGsdSC4tz01GLDAkN4DCfn525iBKc3LdMdjBPfftA7xMjEwXiIUYKDWUmE12Th
 inQh3pTEyqrUovz4otKc1OJDjKbAgJ/ILCWanA9MsHkl8YYmlgYmZkYmFsaWxmZK4rwXtrWk
 CwmkJ5akZqemFqQWwfQxcXBKNTB1c8vH3p77aW9p9P2CRMkT365HnQhO17nuPWOr3+bt5/8s
 3Pf9ysJzDf4rG7sWb1zQWMTqv+v40oqSkMo+LrU7FuZbOWOmsoceqwjoPPVj7/HyqerPHMw+
 XNWv2mKZ4qwTJrnii+MGD7FFW6zPzHP40mT/en1RE7P3YvnT3H/e+v4w0eUR0RPLvHSybwnL
 Q6+Oj3/WXlM5trPW3YmV++Gu4ujEbd2/utXM/vgrbva7UiHOcaX2st5NsUpZ7flV28+tX333
 cvj6efHxfZq9sx0quxQcHUvrZ2s6/Juxrv38f76QON5rrIZaN949E7r5zvljgJB/FMu8snee
 /q8lhHgW6ljvb2m788UpLdFp3yUlluKMREMt5qLiRAAvS39O+AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCLMWRmVeSWpSXmKPExsWy7bCSnO7/xpXpBmtPKFtMnbSZ3eLt3k52
 ByaPVwdWsXucvbODMYApissmJTUnsyy1SN8ugStj6vkDrAUzuCpOTb7P1sC4mKOLkZNDQsBE
 YtLMXtYuRi4OIYHdjBL3F59hhkhISEyafYGpi5EDyBaWOHy4GKLmKaNE09IbjCA1bAJaEn8X
 nmcFqRERMJKY/FYUJCwMFP514RkbiM0ioCrxvXcbmM0rYClxavtOVghbUOLkzCcsIK3MAnoS
 bRvBJjILyEtsfzsH6gIFiZ9Pl4GVi4CUHF7LDFEjIjG7s415AqPALCSTZiFMmoVk0iwkHQsY
 WVYxSqYWFOem5yYbFhjmpZbrFSfmFpfmpesl5+duYgQHrJbGDsZ335r0DzEycTAeYpTgYFYS
 4TVZuCJdiDclsbIqtSg/vqg0J7X4EKM0B4uSOO9Kw4h0IYH0xJLU7NTUgtQimCwTB6dUAxPr
 C9ZE0UVRZk+KLZp2Rueq3VvsMHlf2bZXkcbOV+/VMXXc0dyv6FZoFDM90VRWVMx7yzKb1Z9M
 mOJfXHa4/l/reVeocl926fbmTSu2MSROPHC1M+nIUa2svfyPd3/cHfzfMafMvf3YV5+/3E4f
 Kx7tl/XPPvFPd15V5930sN31IUnSZ7yOr5iQf/eOWOe7M+t/2HSppleoW8bMKBbM+3o5s+7m
 jMRmrh+9PMY+DBelrZfPD3FbHP6sZaH1gR+VOtI/7ghv+u6/9WPn5ynZ+/Oy1cqeld10NBV/
 cNxsUmNacvqD46oakizCnEw/F6lt6p/p67XqhaziGZ9DqfcP2HdeeZxmU7r3gpvz4zdxy5RY
 ijMSDbWYi4oTASBYIx3HAgAA
X-CMS-MailID: 20250210043511epcas1p33ed93b581644b1a1a14a8710afeaaf97
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250210043511epcas1p33ed93b581644b1a1a14a8710afeaaf97
References: <CGME20250210043511epcas1p33ed93b581644b1a1a14a8710afeaaf97@epcas1p3.samsung.com>
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

The following changes since commit 97c125e6bb441a8062bdd28e82f17b1da1224416:

  Gitlab: Add results.xml to the list of artifacts as well. (2025-02-04
11:57:36 -0600)

are available in the Git repository at:

  git@source.denx.de:u-boot/custodians/u-boot-samsung.git master

for you to fetch changes up to 16218681a5407c1973b3009f21b010a1c09b212e:

  board: samsung: e850-96: Provide bootstd default env (2025-02-05 19:15:12
+0900)

----------------------------------------------------------------
Sam Protsenko (7):
      configs: e850-96: Enable options for updated env
      configs: e850-96: Enable U-Boot environment on eMMC
      configs: e850-96: Enable more EFI features
      configs: e850-96: Enable Standard Boot
      board: samsung: e850-96: Load LDFW from EFI partition
      board: samsung: e850-96: Report LDFW loading failures
      board: samsung: e850-96: Provide bootstd default env

 board/samsung/e850-96/e850-96.c   |  7 ++++++-
 board/samsung/e850-96/e850-96.env | 37
+++++++++++--------------------------
 board/samsung/e850-96/fw.c        | 45
++++++++++++++++++++++++++++++++++++++-------
 configs/e850-96_defconfig         | 23 ++++++++++++++++++++---
 4 files changed, 75 insertions(+), 37 deletions(-)

Thanks,
Minkyu Kang.


