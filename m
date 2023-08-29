Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 868F7C83F12
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 04:28:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFFD9864C8;
	Tue, 29 Aug 2023 06:28:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="tCoHI0/5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5527880282; Tue, 29 Aug 2023 06:28:41 +0200 (CEST)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A85B864DA
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 06:28:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20230829042833epoutp02dbf970751404bcb5ec36c44d177f3d5a~-wDO2L4fd3171831718epoutp023
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 04:28:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20230829042833epoutp02dbf970751404bcb5ec36c44d177f3d5a~-wDO2L4fd3171831718epoutp023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1693283313;
 bh=vVCzGpuGcztegABdNGE9jQA/roD3yvAucjjwgQPx0oA=;
 h=From:To:Cc:Subject:Date:References:From;
 b=tCoHI0/5mSvqe0dpLgrq8Ckqy/jt8w62gYpafAX1Re1YbKeKwAqzAXXBAQA9Yex/D
 oRXeRlhOQaXrnIAc4dR+pYltyUgBDHjCno0iUIaeE2YnQE+zTlMT5UbSu3n7lpPEls
 QsUyVhCQoR9neHRV/TRpaS3nNjz0x3n/XFQYbmWc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTP id
 20230829042832epcas2p2ca69f3c7f922be06b1a0de6b73c9d740~-wDN_DgF-1643816438epcas2p24;
 Tue, 29 Aug 2023 04:28:32 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.89]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4RZZDb3Cjrz4x9Q7; Tue, 29 Aug
 2023 04:28:31 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
 epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 E6.ED.09693.FE37DE46; Tue, 29 Aug 2023 13:28:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
 20230829042831epcas2p4a8a4cd85cdfe73e8dac914b274d5c351~-wDMzg1tF0766007660epcas2p4P;
 Tue, 29 Aug 2023 04:28:31 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20230829042831epsmtrp2198a99cf7ac20db356802df6a25c9f08~-wDMy6z-t3146431464epsmtrp2W;
 Tue, 29 Aug 2023 04:28:31 +0000 (GMT)
X-AuditID: b6c32a45-84fff700000025dd-70-64ed73ef90d3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 BE.52.18916.EE37DE46; Tue, 29 Aug 2023 13:28:30 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20230829042830epsmtip2ceed185d2ddc3347dc98e632a990409a~-wDMmsgyk2146521465epsmtip2E;
 Tue, 29 Aug 2023 04:28:30 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Simon Glass <sjg@chromium.org>, Nikhil M Jain <n-jain1@ti.com>, Marek
 Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v2] spl: bootstage: move bootstage_stash before jumping to
 image
Date: Tue, 29 Aug 2023 13:28:03 +0900
Message-Id: <20230829042803.2606011-1-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMKsWRmVeSWpSXmKPExsWy7bCmme774rcpBj/uilpc3q9t8aatkdGi
 //9zJotvW7YxWrzd28nuwOoxu+Eii8e8WSdYPM7e2cHo0bdlFaPH8RvbmQJYo7JtMlITU1KL
 FFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4CWKymUJeaUAoUCEouL
 lfTtbIryS0tSFTLyi0tslVILUnIKzAv0ihNzi0vz0vXyUkusDA0MjEyBChOyM9Zd6GIteCJc
 0XziNVsD4yaBLkZODgkBE4m7N46zdDFycQgJ7GCUWPd1BiuE84lR4uWHg4xwzpaD15hgWr7v
 WM8EkdjJKPH3UgdU1TQmieeXv4JVsQnoSmx5/goowcEhIlAusXiXDUiYWUBbovPzFHYQW1gg
 SGL9pp+MIDaLgKrEpgnbmEFsXgEHiTvTT7KBtEoIyEssfiABERaUODnzCQvEGHmJ5q2zmUHW
 SgjsYpfY+2A/G8RxLhJ7Xr5ih7CFJV4d3wJlS0l8frcXama5xI5lSRC9LYwSzW17mCFq7CV+
 3JzCClLDLKApsX6XPkS5ssSRW1Br+SQ6Dv9lhwjzSnS0CUE0qksc2D6dBcKWleie85kVwvaQ
 2NpwAOxBIYFYiRlbLrNNYJSfheSZWUiemYWwdwEj8ypGsdSC4tz01GKjAkN4lCbn525iBKc+
 LdcdjJPfftA7xMjEwXiIUYKDWUmE95LjqxQh3pTEyqrUovz4otKc1OJDjKbA0J3ILCWanA9M
 vnkl8YYmlgYmZmaG5kamBuZK4rz3WuemCAmkJ5akZqemFqQWwfQxcXBKNTBZ3F3q3nTR+Gbv
 9TCzbcIuN/2Ybx55ss0mNEylcFGZzQaWtgBh7usL9D7Oybfr/ZuvZD4t0Efy84uCbo6TDiGX
 rFfbPmB3/V5V7LB+S/KP9IvOG3l0NpZHpU1rfrF/wp57jzxevTygL++j5bi4/5WX98bAxPtN
 hjtjVe9beaZsf6/b5nr3Rd7hdw72aQtXmJaFH+oW70jrqfKp2Mi3s2kP39nIg/vWLrF3Mfyq
 eiNYj/fhlHX/2LZZz3MO5WvLtL8zVfj39QUPJ20T7Don3rw5YuVzhYbzf5Zs6D+/T+f19ZKl
 ZlLihvtz/696qrpHa0r/Wq/WVQnrj3Qwc/XLztn8ViFdOFM56ub3Evmd8Z+UWIozEg21mIuK
 EwGZV/YaBgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPLMWRmVeSWpSXmKPExsWy7bCSvO674rcpBm+7rCwu79e2eNPWyGjR
 //85k8W3LdsYLd7u7WR3YPWY3XCRxWPerBMsHmfv7GD06NuyitHj+I3tTAGsUVw2Kak5mWWp
 Rfp2CVwZ6y50sRY8Ea5oPvGarYFxk0AXIyeHhICJxPcd65m6GLk4hAS2M0o0dc5gg0jISjx7
 t4MdwhaWuN9yhBWiaBKTROf5t2AJNgFdiS3PXzF2MXJwiAhUS5zZow4SZhbQluj8PAWsRFgg
 QOL1hxksIDaLgKrEpgnbmEFsXgEHiTvTT7KBtEoIyEssfiABERaUODnzCQvEGHmJ5q2zmScw
 8s1CkpqFJLWAkWkVo2hqQXFuem5ygaFecWJucWleul5yfu4mRnAYagXtYFy2/q/eIUYmDsZD
 jBIczEoivJccX6UI8aYkVlalFuXHF5XmpBYfYpTmYFES51XO6UwREkhPLEnNTk0tSC2CyTJx
 cEo1MGX4KN+6973pc6a3b/bZo/vC1V5uOS8wv9IrzuiKUR6XYrnccXHWI5ebb4Z9f6x+3qvy
 YI7BrH9F5uKMEQfzAj+raK37o8Aluqtqi06TcVL39YXfsyeVJ2x/Gq7yfMkN77ijMXMto79r
 aCUfiP/1f64Ra7adYrtNXeXnV30/b4rz9QR8YOy80ygy7cxsIZnO9Aq+pbGiZ7fwnErUkplb
 uOyUy7lvJRmtNdOPZQZJ31MM3npiidS3TvMjtfNdHlQcF+k4fuDSeo4Lfuw7nOO/um/Q5N29
 P1Bgnv6h94vdPFaeqfIzFzG0CvY+pi0xQe7iz/f5F0Vf6001k1OaeLj/xIxMzklVn+Z3v1fm
 a/P6rMRSnJFoqMVcVJwIAMX5pFKyAgAA
X-CMS-MailID: 20230829042831epcas2p4a8a4cd85cdfe73e8dac914b274d5c351
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230829042831epcas2p4a8a4cd85cdfe73e8dac914b274d5c351
References: <CGME20230829042831epcas2p4a8a4cd85cdfe73e8dac914b274d5c351@epcas2p4.samsung.com>
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

Regarding IH_OS_OPENSBI, IH_OS_LINUX and IH_OS_TEE, there is no chance
to stash bootstage record because they do not return to SPL after
jumping to the image.
Hence, this patch separates the final stage bootstage code into
spl_bootstage_finish and call the function before jumping to the image.

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
Changes from v1
- Separate the final stage bootstage code into spl_bootstage_finish.
- As Simon suggests, call the function before jumping to the image.

 common/spl/spl.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 0062f3f45d9a..eaf2f076ddd1 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -738,6 +738,19 @@ void board_init_f(ulong dummy)
 }
 #endif
 
+static void spl_bootstage_finish(void)
+{
+	int ret;
+
+	bootstage_mark_name(get_bootstage_id(false), "end phase");
+#ifdef CONFIG_BOOTSTAGE_STASH
+	ret = bootstage_stash((void *)CONFIG_BOOTSTAGE_STASH_ADDR,
+			      CONFIG_BOOTSTAGE_STASH_SIZE);
+	if (ret)
+		debug("Failed to stash bootstage: err=%d\n", ret);
+#endif
+}
+
 void board_init_r(gd_t *dummy1, ulong dummy2)
 {
 	u32 spl_boot_list[] = {
@@ -865,12 +878,14 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 	case IH_OS_TEE:
 		debug("Jumping to U-Boot via OP-TEE\n");
 		spl_board_prepare_for_optee(spl_image.fdt_addr);
+		spl_bootstage_finish();
 		jump_to_image_optee(&spl_image);
 		break;
 #endif
 #if CONFIG_IS_ENABLED(OPENSBI)
 	case IH_OS_OPENSBI:
 		debug("Jumping to U-Boot via RISC-V OpenSBI\n");
+		spl_bootstage_finish();
 		spl_invoke_opensbi(&spl_image);
 		break;
 #endif
@@ -881,6 +896,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 		spl_fixup_fdt((void *)CONFIG_SYS_SPL_ARGS_ADDR);
 #endif
 		spl_board_prepare_for_linux();
+		spl_bootstage_finish();
 		jump_to_image_linux(&spl_image);
 #endif
 	default:
@@ -890,13 +906,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 	debug("SPL malloc() used 0x%lx bytes (%ld KB)\n", gd->malloc_ptr,
 	      gd->malloc_ptr / 1024);
 #endif
-	bootstage_mark_name(get_bootstage_id(false), "end phase");
-#ifdef CONFIG_BOOTSTAGE_STASH
-	ret = bootstage_stash((void *)CONFIG_BOOTSTAGE_STASH_ADDR,
-			      CONFIG_BOOTSTAGE_STASH_SIZE);
-	if (ret)
-		debug("Failed to stash bootstage: err=%d\n", ret);
-#endif
+	spl_bootstage_finish();
 
 	if (IS_ENABLED(CONFIG_SPL_VIDEO_REMOVE)) {
 		struct udevice *dev;
-- 
2.39.2

