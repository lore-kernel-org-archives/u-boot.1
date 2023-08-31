Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1111BC83F10
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 07:53:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58EBF8656D;
	Thu, 31 Aug 2023 09:53:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="UmMADhnW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DE208656D; Thu, 31 Aug 2023 09:53:09 +0200 (CEST)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3B5E86570
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 09:53:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20230831075301epoutp043050fc5f7f76ce1f315d2f982efce385~AaIVXWqj91762017620epoutp04V
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 07:53:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20230831075301epoutp043050fc5f7f76ce1f315d2f982efce385~AaIVXWqj91762017620epoutp04V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1693468381;
 bh=CRwR/rfatqDyyaAvSxF6Rd0d/q18BmlVqBZCmW0Q2JI=;
 h=From:To:Cc:Subject:Date:References:From;
 b=UmMADhnWYoBeiRkGkOaihlIyDEsU4MRQ6wOGYdaS71Z4m+JfgKOduc+/qxVN1fm32
 54YsagIFcNd+SOHhzaE0z6GuEU0NsxVB/5B8pLLL8t99gjwz3PedWdj6/mQZpNE2O8
 PizGHi3GBJprJXmnkSjtsuLVwVD0Kikn9bVeo/gs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTP id
 20230831075301epcas2p27eec1c1589f98f8365d5abc0dfc41258~AaIU68PdN1391313913epcas2p2o;
 Thu, 31 Aug 2023 07:53:01 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.98]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4Rbtgc45tTz4x9QK; Thu, 31 Aug
 2023 07:53:00 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
 epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 D7.FC.09649.CD640F46; Thu, 31 Aug 2023 16:53:00 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
 20230831075300epcas2p4dabae61e98d5f49fc1fffc5c62df9050~AaITy45092885728857epcas2p4I;
 Thu, 31 Aug 2023 07:53:00 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20230831075300epsmtrp2134b90d6ee5820107bb044d51b392cbb~AaITyP0NV3014930149epsmtrp2H;
 Thu, 31 Aug 2023 07:53:00 +0000 (GMT)
X-AuditID: b6c32a46-b9ffa700000025b1-dc-64f046dce98b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 DD.C6.18916.BD640F46; Thu, 31 Aug 2023 16:53:00 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20230831075259epsmtip169981c4c92e7467542cc249924011ba5~AaITo0UuC0297402974epsmtip1_;
 Thu, 31 Aug 2023 07:52:59 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Cc: Eugen Hristev <eugen.hristev@collabora.com>, Simon Glass
 <sjg@chromium.org>, Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v2] fpga: define dummy fpga_load function for debug build
Date: Thu, 31 Aug 2023 16:52:47 +0900
Message-Id: <20230831075247.137501-1-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIKsWRmVeSWpSXmKPExsWy7bCmue4dtw8pBhtWSVtc3q9t0broNqPF
 3uMXWS2+bdnGaPF2bye7A6tH66W/bB6zGy6yeOy4u4TR4+ydHYwefVtWMQawRmXbZKQmpqQW
 KaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gAtV1IoS8wpBQoFJBYX
 K+nb2RTll5akKmTkF5fYKqUWpOQUmBfoFSfmFpfmpevlpZZYGRoYGJkCFSZkZ7y6f5u94B1X
 xcGpR9kaGBs4uxg5OSQETCQ2rO5gAbGFBHYwSlya5N/FyAVkf2KUWHPyLBucs+vsHGaYjtb5
 c1kgEjsZJX4d3c4O4Uxjkji6cCcrSBWbgK7EluevGEFsEQFbidfPz4LZzAJVEv8+7WACsYUF
 PCXW31kJFmcRUJX49Xgb0DoODl4Be4kfF3hBTAkBeYnFDyRAKngFBCVOznzCAjFFXqJ562xm
 kLUSAvvYJd7cO84CcZyLxPWpr9khbGGJV8e3QNlSEp/f7WWDmFkusWNZEkRvC6NEc9seqMeA
 1t6cwgpSwyygKbF+lz5EubLEkVtQa/kkOg7/ZYcI80p0tAlBNKpLHNg+HeoAWYnuOZ9ZIUo8
 JH7cqIMEbazEtNktjBMY5Wch+WUWkl9mIaxdwMi8ilEstaA4Nz212KjACB6hyfm5mxjBaU/L
 bQfjlLcf9A4xMnEwHmKU4GBWEuGNNXuXIsSbklhZlVqUH19UmpNafIjRFBi2E5mlRJPzgYk3
 ryTe0MTSwMTMzNDcyNTAXEmc917r3BQhgfTEktTs1NSC1CKYPiYOTqkGJimVgOznVX6OvlKG
 LrLmr2bdDGnYcM/xwatpOSc0pmYorAkJUFy5f4rWXn5F1ke+S/jNn52Jlbau5xSJfnFm31qG
 2+uyP0/QTK/V/erEtaeqMjdmxeXpO8Qu/l7k1386PWahUOzktTqHDwgGv9h8S+GOpIn5nY2r
 H2mdU1Fq3brq7JbrDYpPLpZw7Q0/3Lq39J7Ka4bWiWHyx0J2nV1zU/HS9Ur+3Msbe7ZLSnYd
 4VylIP7v+/m5KwrMn0+zOcOXdofN12/lTvmdyglfbtz9fCzAd9l9gwO9lz237Pu7gNfwsYCB
 6JyVPIGuhrM2176efmPaFMXVM0sdtDvYT5Yt4t7/Se8DRwq3pEva5GX2c44osRRnJBpqMRcV
 JwIApUk1oQQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPLMWRmVeSWpSXmKPExsWy7bCSnO4dtw8pBpcmMltc3q9t0broNqPF
 3uMXWS2+bdnGaPF2bye7A6tH66W/bB6zGy6yeOy4u4TR4+ydHYwefVtWMQawRnHZpKTmZJal
 FunbJXBlvLp/m73gHVfFwalH2RoYGzi7GDk5JARMJFrnz2XpYuTiEBLYzihx+s1CJoiErMSz
 dzvYIWxhifstR1ghiiYxSZzZfBsswSagK7Hl+StGEFtEwF7iReNWFhCbWaBG4sSx58wgtrCA
 p8T6OyvBalgEVCV+Pd7G1sXIwcELVP/jAi+IKSEgL7H4gQRIBa+AoMTJmU+gpshLNG+dzTyB
 kW8WktQsJKkFjEyrGEVTC4pz03OTCwz1ihNzi0vz0vWS83M3MYLDUCtoB+Oy9X/1DjEycTAe
 YpTgYFYS4Y01e5cixJuSWFmVWpQfX1Sak1p8iFGag0VJnFc5pzNFSCA9sSQ1OzW1ILUIJsvE
 wSnVwOT+5MjlupsxR9WVjoUsthdIe/VB85++VKBMctgdo/ifwvcrVq1cXWdwTbG+zqLyRmxC
 vdGCa0f37TSocHK+O/3xOgOfrecKHpVbTdzmz+pusOLiIWMJzQLTW48Xl6s5qGeu2rPmy4M+
 0yWPXSd4q376tHjz5+sFzt/mZFuwmHtdY5s165al04L65BAh42m7Xlc/4Z59tNX5b9hWhUqt
 vKVZGzlCO/dN2fzr4bwlgZUb+MSTbjo85/L1tHotcKLxY+vJtzabTOJd9s6v4J8wbXbbuccX
 PL6uUNpU3nO1eKnMpOOPXeXFHHyXdNowNZnpGm6pM0osc3j7KrgkVEalfU/fqeYIsQzmdU82
 7qzs+qrEUpyRaKjFXFScCACM+p2ysgIAAA==
X-CMS-MailID: 20230831075300epcas2p4dabae61e98d5f49fc1fffc5c62df9050
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230831075300epcas2p4dabae61e98d5f49fc1fffc5c62df9050
References: <CGME20230831075300epcas2p4dabae61e98d5f49fc1fffc5c62df9050@epcas2p4.samsung.com>
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
CONFIG_FPGA or CONFIG_SPL_FPGA are not enabled.
When CC_OPTIMIZE_FOR_DEBUG is enabled, unused code will not be optimized
out. Hence, fpga_load function must have a dummy implementation to avoid
the build error.

../common/spl/spl_fit.c:591: undefined reference to `fpga_load'
collect2: error: ld returned 1 exit status

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
Change from v1:
- Rewrite the commit message to include a CONFIG_FPGA

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

