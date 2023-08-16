Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21161C001B0
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 06:55:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A3878697E;
	Wed, 16 Aug 2023 08:54:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="BjHi1mYY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E6A78699B; Wed, 16 Aug 2023 08:54:58 +0200 (CEST)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31D75867E2
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 08:54:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20230816065451epoutp01256f4b9a1d8b7b48c71c129bca5c6690~7yqQUwD-Y2652926529epoutp01t
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 06:54:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20230816065451epoutp01256f4b9a1d8b7b48c71c129bca5c6690~7yqQUwD-Y2652926529epoutp01t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1692168891;
 bh=0wFB7qiFn29XTJfY9mBgQfqGPnQgcDnAM0GI9c1VAwY=;
 h=From:To:Cc:Subject:Date:References:From;
 b=BjHi1mYYBAWLsgrra/De3jh6PW9YL4eJcz4yW2S8BUncS8gzQ41YfSh9J+WuvWEF/
 nClvOn/E4Pnm5jnJsomkwVWkI4R9IN1yyL/mAm8fQWhd0P0RjHhfP2XRQ2YoneVTCo
 MZRE+8W5E16vdHlFRzRCTVWly3xje6lGLQVsJCaE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTP id
 20230816065450epcas2p19c79473b0003ddf261d3b94bca30e02d~7yqQC67KA1705117051epcas2p1O;
 Wed, 16 Aug 2023 06:54:50 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.91]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4RQf5P6pK0z4x9Q0; Wed, 16 Aug
 2023 06:54:49 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 CD.61.49986.9B27CD46; Wed, 16 Aug 2023 15:54:49 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
 20230816065448epcas2p3bf66892f15a6dc8e082a5f296b307bec~7yqOUw-Ql2691926919epcas2p3N;
 Wed, 16 Aug 2023 06:54:48 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20230816065448epsmtrp296c298513e8b1dfea12c31e14acf914d~7yqOUN-jX3023230232epsmtrp2o;
 Wed, 16 Aug 2023 06:54:48 +0000 (GMT)
X-AuditID: b6c32a43-5f9ff7000000c342-de-64dc72b943ea
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 26.54.34491.8B27CD46; Wed, 16 Aug 2023 15:54:48 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20230816065448epsmtip23edc34d6ccc0a844aa532e6f04de9f40~7yqOJTqsz1790017900epsmtip2S;
 Wed, 16 Aug 2023 06:54:48 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH] fpga: define dummy fpga_load function for debug build
Date: Wed, 16 Aug 2023 15:54:37 +0900
Message-Id: <20230816065437.836392-1-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRmVeSWpSXmKPExsWy7bCmqe7OojspBh++CFhc3q9tsff4RVaL
 t3s72R2YPVov/WXzOHtnB6NH35ZVjAHMUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6
 hpYW5koKeYm5qbZKLj4Bum6ZOUCLlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF
 5gV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGYdbQwrecVRsetXH3sC4lr2LkZNDQsBE4vbpP4xd
 jFwcQgI7GCU2nf/IApIQEvjEKPG+Nw4i8Y1R4svOTXAd12Z8Z4NI7GWU2H3+MlT7NCaJdUfX
 M4FUsQnoSmx5/ooRxBYRsJV4/fwsmM0soC3R+XkK2CRhATeJTw0rwWwWAVWJKw0z2EBsXgF7
 iVUTG4HiHEDb5CUWP5CACAtKnJz5hAVijLxE89bZzCB7JQQms0s8ffyMDeI6F4nTX/qZIWxh
 iVfHt0BdLSXx+d1eNoiZ5RI7liVB9LYwSjS37YGqt5f4cXMKK0gNs4CmxPpd+hDlyhJHbkGt
 5ZPoOPwX6jJeiY42IYhGdYkD26ezQNiyEt1zPrNC2B4S7d8WQsMzVuL/lYuMExjlZyF5ZhaS
 Z2Yh7F3AyLyKUSy1oDg3PTXZqMAQHqPJ+bmbGMEJTct5B+OV+f/0DjEycTAeYpTgYFYS4e3h
 vZUixJuSWFmVWpQfX1Sak1p8iNEUGLoTmaVEk/OBKTWvJN7QxNLAxMzM0NzI1MBcSZz3Xuvc
 FCGB9MSS1OzU1ILUIpg+Jg5OqQamKu1zTau/C/29brhkfRmn2ivXhWbHo++eFOGOjVcr17Bk
 c8iL1fz+tLf6SkabSmeV2TmTZXNvKYT6NUkka+UVLlraVXh33dM7slv/Zec3Pci/lJGxxH2L
 aE/Psns8007tm9XNcc43sLd9xYJFR/naXLT4tVfrMu4/uy/nzSpe93MXWV8zrfoeVpGc8qTo
 rYW0zOPKLV0KJ29MrJy36vWuvuN6Vyq2GK2uVfd2mnfwfn+54zOnugqfnyx2EYLiTK96+pcf
 TpqixFuxJ2BPW0XRbkmTsmQXLtb8MJcrv68LX1P9MS1+VyTLKaZJv32ZZRattOhQk7i8WONX
 HPOVl2uNsgwzu1cobv/r72igdVGJpTgj0VCLuag4EQCUOvvu8QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplluLIzCtJLcpLzFFi42LZdlhJXndH0Z0UgxkLzSwu79e22Hv8IqvF
 272d7A7MHq2X/rJ5nL2zg9Gjb8sqxgDmKC6blNSczLLUIn27BK6Mw60hBe84Kja96mNvYFzL
 3sXIySEhYCJxbcZ3NhBbSGA3o8S1jfwQcVmJZ+92QNUIS9xvOcIKUTOJSWLnM28Qm01AV2LL
 81eMILaIgL3Ei8atLCA2s4C2ROfnKWC9wgJuEp8aVoLZLAKqElcaZoDt4gWqXzWxESjOATRf
 XmLxAwmIsKDEyZlPoMbISzRvnc08gZFvFpLULCSpBYxMqxglUwuKc9Nziw0LDPNSy/WKE3OL
 S/PS9ZLzczcxgkNMS3MH4/ZVH/QOMTJxMB5ilOBgVhLh7eG9lSLEm5JYWZValB9fVJqTWnyI
 UZqDRUmcV/xFb4qQQHpiSWp2ampBahFMlomDU6qBKf423/UL+y/IFWvP36vz/6CMQlWH8DHf
 I04yImX31fc1+v+a+bXh2bSiktOGM0pbHffl39R7JRny2Krq0916tQNnb627VlB98KXcRN4F
 NWqCxT2hHvP+pkuvKz9ukrb7zFzVGLVlWwTY0qJWma3zvqVXZ/Hr09m57h/c4v/Ff51556/E
 nCbhmGOf35zbk27rfvqVYOTemwcFhGXTPzGH5k/JLp7j6jjj4vKIXemSpzemx+hXt1ta3quO
 1Mv70Vz38nCh3u+C/GUfpmq6pfBebT52Y6b0+bsqwqu27d37/ZmMSqDhlPC6ay59DcH24i8n
 CywSfH88YrZ4gU33cu5DCuuDjgetrNdxd738QVbTXomlOCPRUIu5qDgRABE8dBOgAgAA
X-CMS-MailID: 20230816065448epcas2p3bf66892f15a6dc8e082a5f296b307bec
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230816065448epcas2p3bf66892f15a6dc8e082a5f296b307bec
References: <CGME20230816065448epcas2p3bf66892f15a6dc8e082a5f296b307bec@epcas2p3.samsung.com>
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

This fixes below build error when CC_OPTIMIZE_FOR_DEBUG is enabled and
CONFIG_SPL_FPGA is not enabled.

../common/spl/spl_fit.c:591: undefined reference to `fpga_load'
collect2: error: ld returned 1 exit status

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 include/fpga.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/fpga.h b/include/fpga.h
index ed688cc0fa3b..44f2755a3f10 100644
--- a/include/fpga.h
+++ b/include/fpga.h
@@ -60,8 +60,16 @@ int fpga_add(fpga_type devtype, void *desc);
 int fpga_count(void);
 const fpga_desc *const fpga_get_desc(int devnum);
 int fpga_is_partial_data(int devnum, size_t img_len);
+#if CONFIG_IS_ENABLED(FPGA)
 int fpga_load(int devnum, const void *buf, size_t bsize,
 	      bitstream_type bstype, int flags);
+#else
+static inline int fpga_load(int devnum, const void *buf, size_t bsize,
+	      bitstream_type bstype, int flags)
+{
+	return FPGA_FAIL;
+}
+#endif
 int fpga_fsload(int devnum, const void *buf, size_t size,
 		fpga_fs_info *fpga_fsinfo);
 int fpga_loads(int devnum, const void *buf, size_t size,
-- 
2.39.2

