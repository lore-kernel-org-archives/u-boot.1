Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F84EB8FAD
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 05:18:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF105868BC;
	Wed,  6 Sep 2023 07:18:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="XGauUoEz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6016B8695F; Wed,  6 Sep 2023 07:18:39 +0200 (CEST)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 596318652A
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 07:18:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20230906051832epoutp04fc277d6e02992be5e75899d90ee4ce08~CN5KPgad60735107351epoutp04w
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 05:18:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20230906051832epoutp04fc277d6e02992be5e75899d90ee4ce08~CN5KPgad60735107351epoutp04w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1693977512;
 bh=ErNk7xRKP6P1cXyYb/WKoRYMID4/XYuuVJny7xrPx/g=;
 h=From:To:Cc:Subject:Date:References:From;
 b=XGauUoEzy/hnuSZsXty2AxK0FSGJ/IKyyhnmzuvpbZMyq3+BfMNcoWLMi9WcO3G4o
 tLZmJJb9R/+M6rU/ue1HXNbarE45G75DlEe/jcjop3CTBsIpdRnfD+M3Y4pVEn0yOH
 agHbKRyYQVLjdmDVdhiM6AcvCPUPN8D3kVQbtJlU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTP id
 20230906051832epcas2p1fe424743fd0fa63ce80e05b1efc9c45c~CN5J2KreU1174211742epcas2p19;
 Wed,  6 Sep 2023 05:18:32 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.88]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4RgVyb3GGZz4x9Q0; Wed,  6 Sep
 2023 05:18:31 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
 epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 93.65.19471.7AB08F46; Wed,  6 Sep 2023 14:18:31 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
 20230906051831epcas2p31b9a8d38140b0cde3aee89f5038edd69~CN5I85QiT2596225962epcas2p3B;
 Wed,  6 Sep 2023 05:18:31 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20230906051831epsmtrp124525451f74db7e2488ae9d90d9ca7f7~CN5I8QJk00596705967epsmtrp1c;
 Wed,  6 Sep 2023 05:18:31 +0000 (GMT)
X-AuditID: b6c32a4d-dc5ff70000004c0f-0a-64f80ba777f3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 6B.3F.08788.6AB08F46; Wed,  6 Sep 2023 14:18:30 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20230906051830epsmtip1842eb19103b2441913a893306c0bb279~CN5ItFIj_0505605056epsmtip16;
 Wed,  6 Sep 2023 05:18:30 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, Simon Glass
 <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v3 0/3] bootstage support for risc-v
Date: Wed,  6 Sep 2023 14:18:11 +0900
Message-Id: <20230906051814.1393464-1-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAKsWRmVeSWpSXmKPExsWy7bCmhe5y7h8pBl8niVlc3q9t8fbFWUaL
 b1u2MVq83dvJbvH40GsmB1aPPadnMXvMbrjI4nH2zg5Gj74tqxgDWKKybTJSE1NSixRS85Lz
 UzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA9ioplCXmlAKFAhKLi5X07WyK
 8ktLUhUy8otLbJVSC1JyCswL9IoTc4tL89L18lJLrAwNDIxMgQoTsjNeXj/KXnCNteL/ja+s
 DYxHWLoYOTkkBEwkrnYdZOti5OIQEtjDKNH77wIzhPOJUeJK+3J2COcbo8S3k1uYYFrOrzwD
 1bKXUWLu7JeMEM40JonO/kVgg9kEdCW2PH8FlODgEBFIlHh8uB7EZBZwlDg31QikQhhozrS9
 +xlBbBYBVYmNW76A2bwCDhLv7rWxgJRLCMhLLH4gAREWlDg58wnYcGagcPPW2WCHSghsY5c4
 +eEBG0S9i8TxDhWIM4UlXh3fwg5hS0m87G9jhygpl9ixLAmitYVRorltDzNEjb3Ej5tTWCGu
 1JRYv0sfolxZ4sgtqK18Eh2H/0JN4ZXoaBOCaFSXOLB9OjQ4ZSW653xmhbA9JHbMbAGLCwnE
 StyeOIFtAqP8LCS/zELyyyyEvQsYmVcxSqUWFOempyYbFRjq5qWWwyM1OT93EyM46Wn57mB8
 vf6v3iFGJg7GQ4wSHMxKIrzv5L+lCPGmJFZWpRblxxeV5qQWH2I0BQbwRGYp0eR8YNrNK4k3
 NLE0MDEzMzQ3MjUwVxLnvdc6N0VIID2xJDU7NbUgtQimj4mDU6qBqXDe6qvclleaGStanZte
 iV8LevxqGmcCy/TmZd86K3sjeXg1BDt/1qRUP93xa51B2Zn30jLb9ibnhmSeFImOLynItWfa
 JZqmcaUi7tiiitlKjnOftEpzFFZ83JGtmbFiwbEDqoZnlY+unZXu0ljcGNd0Il/tqofazfk8
 2tmGcTMPeds/5WZU1BM0vnQw/7b28dOK7Btq1DP52QQzhDR3O+lOtqnrs+wNEPyvEnIhv0ap
 srbSW3GKoNqW0qvZF5brthsYBqz4tNPNQHNOoyz7lHvsJ1/F/3N5v3rmiRq9Hd7cAkuvN3RX
 xTJseJLaHlyWcoQ/QuT5r/PN/P1zPzaa8iXNdKnrmd6bOD8iXImlOCPRUIu5qDgRAIv/6XED
 BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPLMWRmVeSWpSXmKPExsWy7bCSnO4y7h8pBsd/WFpc3q9t8fbFWUaL
 b1u2MVq83dvJbvH40GsmB1aPPadnMXvMbrjI4nH2zg5Gj74tqxgDWKK4bFJSczLLUov07RK4
 Ml5eP8pecI214v+Nr6wNjEdYuhg5OSQETCTOrzzD1sXIxSEksJtRYtbKZmaIhKzEs3c72CFs
 YYn7LUdYIYomMUlcn78YrIhNQFdiy/NXjCC2iECyxMWeLrAGZgFniTvntrOC2MJAG6bt3Q9W
 wyKgKrFxyxcwm1fAQeLdvTagKziAFshLLH4gAREWlDg58wkLxBh5ieats5knMPLNQpKahSS1
 gJFpFaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcBhqae1g3LPqg94hRiYOxkOMEhzM
 SiK87+S/pQjxpiRWVqUW5ccXleakFh9ilOZgURLn/fa6N0VIID2xJDU7NbUgtQgmy8TBKdXA
 5KS6+7j76v9rVrM9Kxc+5ZlwwKEzdeOnObP9Lax7ArXYnW4sTkhb6afu+OeJQ3+CMEeVXeLm
 YC5b+d6ZVe5Hjv7e7rXsl6Nhz66WQx+XvXdxPy8yZ0tadlP4r5lOcTFCx9lv7bKce+DVltvJ
 jfqzdj9+yfvlY4FQedcU/YOyffwZbxO9BP6xB6+tvc12NErBJSDZJMfEMuvy17XrVpx6lpL5
 6t5Kl1duS99emqp/We//0isXdnjl23pPvJussv9yvnBFBycbE+tt91Sz7Ql3KxjmFPQ46nJ1
 ruy1KuNMCZnz8Z7gLaMJXkUq/55Y6eYdXD7v6xHe1poP8oEfdig3L9j4xVArba5mc9kUtXtz
 lViKMxINtZiLihMBkhHzyLICAAA=
X-CMS-MailID: 20230906051831epcas2p31b9a8d38140b0cde3aee89f5038edd69
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230906051831epcas2p31b9a8d38140b0cde3aee89f5038edd69
References: <CGME20230906051831epcas2p31b9a8d38140b0cde3aee89f5038edd69@epcas2p3.samsung.com>
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

This adds to support bootstage for risc-v. timer_get_boot_us function
is required to record each boot stages with microsecond timestamp.

Changes from v2:
- Add a Leo's RB tag of 1/3 patch
- Add a description of the calculation formula
- Correct the divisor value typo of 3/3 patch

Chanho Park (3):
  riscv: bootstage: correct bootstage_report guard
  riscv: timer: add timer_get_boot_us for BOOTSTAGE
  timer: riscv_aclint_timer: add timer_get_boot_us for BOOTSTAGE

 arch/riscv/lib/bootm.c             |  2 +-
 drivers/timer/riscv_aclint_timer.c | 23 +++++++++++++++++++++++
 drivers/timer/riscv_timer.c        | 22 ++++++++++++++++++++++
 3 files changed, 46 insertions(+), 1 deletion(-)

-- 
2.39.2

