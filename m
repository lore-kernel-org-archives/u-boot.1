Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58FECEE49A4
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 01:04:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C66F486B7E;
	Mon, 21 Aug 2023 03:04:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="c2ey2U5n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15AB586A8F; Mon, 21 Aug 2023 03:04:14 +0200 (CEST)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0AA486A69
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 03:04:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20230821010403epoutp01ebdf18ff17c8a972fe40ea639b246cdb~9QGZgsTWL1286512865epoutp01u
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 01:04:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20230821010403epoutp01ebdf18ff17c8a972fe40ea639b246cdb~9QGZgsTWL1286512865epoutp01u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1692579843;
 bh=pb5R4/uKftRLiZ4URoTj9KHJ1CElzaiG+t5Vd1rZDr4=;
 h=From:To:Cc:Subject:Date:References:From;
 b=c2ey2U5neiXs/8NXMDebnmIqxzXgbYAJvS5x5yV3moO2jWzXCOoQPsPvGN8cFadeV
 tNiUwPy9B7AGT1UWFgLwwu0szfBYLEbo27LQ2znodYjvYnqtQZnv5zAlGr7D5OzyNv
 fwtNlv5JbRJ/UMbIoelUCMnGc83q2Fu2MQjkF6Vs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTP id
 20230821010403epcas2p1618d1ba5ea4d3b59d990a58cb2fea522~9QGZQOYPQ2492924929epcas2p1E;
 Mon, 21 Aug 2023 01:04:03 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.101]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4RTZ4L45nyz4x9Pv; Mon, 21 Aug
 2023 01:04:02 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
 epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 A7.D3.32606.208B2E46; Mon, 21 Aug 2023 10:04:02 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
 20230821010401epcas2p49970d58c843b6a7a9baf272f67b26224~9QGYAvRdj0964809648epcas2p49;
 Mon, 21 Aug 2023 01:04:01 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20230821010401epsmtrp2f243d65782ce85d7c01e73138f258cb3~9QGX_1mqg0968109681epsmtrp2T;
 Mon, 21 Aug 2023 01:04:01 +0000 (GMT)
X-AuditID: b6c32a47-9cbff70000007f5e-8e-64e2b8020934
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 B9.8B.30535.108B2E46; Mon, 21 Aug 2023 10:04:01 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20230821010401epsmtip281ac24deeff429a258822e705553bcbb~9QGXx0d871197311973epsmtip2-;
 Mon, 21 Aug 2023 01:04:01 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, Simon Glass
 <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH 0/3] bootstage support for risc-v
Date: Mon, 21 Aug 2023 10:03:47 +0900
Message-Id: <20230821010350.324112-1-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLKsWRmVeSWpSXmKPExsWy7bCmmS7TjkcpBjfmclpc3q9t8fbFWUaL
 b1u2MVq83dvJbvH40GsmB1aPPadnMXvMbrjI4nH2zg5Gj74tqxgDWKKybTJSE1NSixRS85Lz
 UzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA9ioplCXmlAKFAhKLi5X07WyK
 8ktLUhUy8otLbJVSC1JyCswL9IoTc4tL89L18lJLrAwNDIxMgQoTsjMWTPrHUrCPpeLThSuM
 DYznmbsYOTkkBEwkTl34xdbFyMUhJLCDUWLCyu3sEM4nRompV4+wgFQJCXxjlGj5LgjTsanl
 ChNE0V5Giaa9p6DapzFJzNx7gAmkik1AV2LL81eMXYwcHCIC5RLH7vGDhJkFtCU6P09hB7GF
 BQwlnvzYwQpiswioStx83MEIYvMK2EsserudBaRVQkBeYvEDCYiwoMTJmU9YIMbISzRvnc0M
 slZCYBe7xNdL01ggjnOR2H10KSuELSzx6vgWdghbSuLzu71sEDPLJXYsS4LobWGUaG7bAw0K
 e4kfN6ewgtQwC2hKrN+lD1GuLHHkFtRaPomOw3/ZIcK8Eh1tQhCN6hIHtk+HOkBWonvOZ6gD
 PCTaT9xkh4RgrMTKdVdZJjDKz0LyzCwkz8xC2LuAkXkVo1hqQXFuemqxUYExPEaT83M3MYLT
 nZb7DsYZbz/oHWJk4mA8xCjBwawkwiv9/WGKEG9KYmVValF+fFFpTmrxIUZTYOhOZJYSTc4H
 Jty8knhDE0sDEzMzQ3MjUwNzJXHee61zU4QE0hNLUrNTUwtSi2D6mDg4pRqY/Eum3j/96Kq2
 Uk9f86otn4X8DQ9fL9g1Z0fbP48iCZnO3RKd52/uddSaWXGGs4Ol/qzOV48q7u17jFdnMRi+
 8RKe2mbm7cnM8/KA1inZay9nmBSdFdC3ePrjI5duisvsGXcmfJ3dkr4m/2tifsqiK4bsbA0O
 z3gbfmU48WTMa/03XeWdipyB+6T4a1tPvvcTOBf85Pnj46I+nIcKcx+ZbF0QuK3upvO6S8f/
 efndtek9vu9jLKPV8ZdlN1/5eymobf7veO7Mt41P5p2z19x6/OrXWbGVyz+9e8s3dcHvhLuM
 2xTYDWt6TliJznMVC/dy6E8qm2K0b3FX4fpzrz/dkFxyXvN9WbSem/0RwZts2UosxRmJhlrM
 RcWJAM32zJEABAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHLMWRmVeSWpSXmKPExsWy7bCSvC7jjkcpBrMmaFtc3q9t8fbFWUaL
 b1u2MVq83dvJbvH40GsmB1aPPadnMXvMbrjI4nH2zg5Gj74tqxgDWKK4bFJSczLLUov07RK4
 MhZM+sdSsI+l4tOFK4wNjOeZuxg5OSQETCQ2tVxhArGFBHYzSjxf4g8Rl5V49m4HO4QtLHG/
 5QhrFyMXUM0kJolVn/6ygCTYBHQltjx/xQhiiwhUSzx/tIMNxGYW0Jbo/DwFrFlYwFDiyY8d
 rCA2i4CqxM3HHWD1vAL2EovebgeawwG0QF5i8QMJiLCgxMmZT1ggxshLNG+dzTyBkW8WktQs
 JKkFjEyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNzNzGCg1BLawfjnlUf9A4xMnEwHmKU
 4GBWEuGV/v4wRYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvt9e9KUIC6YklqdmpqQWpRTBZJg5O
 qQamyj8X+5nFpzouef+roGRq2EE1zV2qJY/tpk3nFkx9fkLzQpDOa3OzLf8SP8f9TwrYu/7m
 rFMaQjtWOQT84qiu6lpi/c308wmm6dx/RFe7Z64OMll1+Plr4dIrhw/vumclU/duesYDB7F9
 xX0V6WtmcPj2txrJOgs+Kja9+cpn8v37r/keTt3G7NvZGfJt9dFbP0vX7Av2X5yT5j/Nv3pd
 iKjCw38tvD9EP4jXPXEwSFw6a8KGsMtn2uY3e+2e8fHE9lcJ9zhF4jykeES1npQcX5a38oGP
 ZxHH7Kd73BL8pZ6rbeR86LthwmS+iN8Hsyd9ffPpZ6/ZadkJ9aw18o0ar97dCpzqtUYsMdT/
 pOXDHUosxRmJhlrMRcWJAK9eNZ+xAgAA
X-CMS-MailID: 20230821010401epcas2p49970d58c843b6a7a9baf272f67b26224
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230821010401epcas2p49970d58c843b6a7a9baf272f67b26224
References: <CGME20230821010401epcas2p49970d58c843b6a7a9baf272f67b26224@epcas2p4.samsung.com>
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

Chanho Park (3):
  riscv: bootstage: correct bootstage_report guard
  riscv: timer: add timer_get_boot_us for BOOTSTAGE
  timer: riscv_aclint_timer: add timer_get_boot_us for BOOTSTAGE

 arch/riscv/lib/bootm.c             |  2 +-
 drivers/timer/riscv_aclint_timer.c | 22 ++++++++++++++++++++++
 drivers/timer/riscv_timer.c        | 21 +++++++++++++++++++++
 3 files changed, 44 insertions(+), 1 deletion(-)

-- 
2.39.2

