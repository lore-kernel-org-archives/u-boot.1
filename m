Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 670D4EE57DE
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 08:09:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71D6686564;
	Fri,  8 Sep 2023 10:09:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="HjYn5VYF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DBC7865D0; Fri,  8 Sep 2023 10:09:24 +0200 (CEST)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35007864AB
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 10:09:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20230908080916epoutp010a621292f0e66aea9419fa47ec30cda1~C3gy06Ci61954319543epoutp012
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 08:09:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20230908080916epoutp010a621292f0e66aea9419fa47ec30cda1~C3gy06Ci61954319543epoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1694160556;
 bh=l5wPW0vE5djqECZYvMVhNRzzDro1NaCbj6gxMYFEBcs=;
 h=From:To:Cc:Subject:Date:References:From;
 b=HjYn5VYFQnXesrpJ8DYFaL7rGQeq26aoQI8PqPPpg3ExOenVEUkik9cqyo7jOnPmX
 dbqwS/8DHDfvS8+9CmM7ls9ZaeDndpl0XhQUECaztffz4PAMjJLE7CTxPZXhRUDCef
 bBSHzvRX1JdNPWgbNH5/j/6HzMDN/A+eE1LwhwKk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTP id
 20230908080915epcas2p197738b519ebbce2fedfb8c515eecd426~C3gylL9Zr0683306833epcas2p1I;
 Fri,  8 Sep 2023 08:09:15 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.92]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4Rhpff6m68z4x9Pv; Fri,  8 Sep
 2023 08:09:14 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
 epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 56.B4.09660.8A6DAF46; Fri,  8 Sep 2023 17:09:12 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
 20230908080912epcas2p311f577b1f5d36af18333daf4a327e7c9~C3gvlXYpA2833528335epcas2p3M;
 Fri,  8 Sep 2023 08:09:12 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20230908080912epsmtrp15b281cd4a795a63e958db6b735ae7dc8~C3gvkv6Ba1192411924epsmtrp1p;
 Fri,  8 Sep 2023 08:09:12 +0000 (GMT)
X-AuditID: b6c32a47-d5dfa700000025bc-33-64fad6a82b62
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 EB.83.18916.8A6DAF46; Fri,  8 Sep 2023 17:09:12 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20230908080912epsmtip1a2e5f15727d48ea6d0833792829f8632~C3gvbgLA32089420894epsmtip1Z;
 Fri,  8 Sep 2023 08:09:12 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH] spl: add __noreturn attribute to spl_invoke_atf function
Date: Fri,  8 Sep 2023 17:08:56 +0900
Message-Id: <20230908080856.2819538-1-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRmVeSWpSXmKPExsWy7bCmue6Ka79SDP6/1rG4vF/b4tuWbYwW
 b/d2sjswe8xuuMjicfbODkaPvi2rGAOYo7JtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1
 DS0tzJUU8hJzU22VXHwCdN0yc4AWKSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIK
 zAv0ihNzi0vz0vXyUkusDA0MjEyBChOyM94f38Ra8IWvonWGYgPjPp4uRk4OCQETiTfT21i6
 GLk4hAR2MEo0Xr7IBuF8YpTYv2k+I5xz9+ASZpiW8z93skIkdjJKLN94GKp/GpPEgSs72UCq
 2AR0JbY8f8UIYosIWEgcO7iaBcRmFtCW6Pw8hR3EFhbwlOh/dIEJxGYRUJX4+vgKK4jNK+Ag
 sbjtB5DNAbRNXmLxAwmIsKDEyZlPoMbISzRvnc0MsldCYDq7xP/5ixghrnOReHPvPSuELSzx
 6vgWdghbSuJlfxs7xMxyiR3LkiB6Wxglmtv2QH1mL/Hj5hSwvcwCmhLrd+lDlCtLHLkFtZZP
 ouPwX6gpvBIdbUIQjeoSB7ZPZ4GwZSW653yGOsBD4svnS0wg5UICsRIdx4ImMMrPQvLLLCS/
 zEJYu4CReRWjWGpBcW56arFRgTE8RpPzczcxghOalvsOxhlvP+gdYmTiYDzEKMHBrCTCu1rk
 V4oQb0piZVVqUX58UWlOavEhRlNg4E5klhJNzgem1LySeEMTSwMTMzNDcyNTA3Mlcd57rXNT
 hATSE0tSs1NTC1KLYPqYODilGpgElOdoGgfqaz19+bIip+bhjbp7bM9+F4tcrVpjz5O56WHE
 V7k5T296bo/OuVJbcb5SOH7Bvc4/VguvyC7bvOJanqrkxX77Pbts7i/KTPRv6G1zllTbx35B
 vuOcSP4heWGdwyJTpj0JfpJf9OS8/r2jdzwdjXLPH81c/67C4/RJfpsvJnHBIftMs04EprXp
 /T/a3aZzPvo0axu/Rdd14xlxreJe7zea/jmRreP44c2NiWrXPvBLi79snLph5+TOD/Oi5dUS
 FxQe6ueavez/yVWrPOpZZktwJpvsfvZTUKFvjYVC7Mk3/no/IvLOxtooNVUZ2jsz5r/+zmH0
 wL5bSvHJdvZ33Y8+fpd3lXP1u6HEUpyRaKjFXFScCACp+aNc8QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmluLIzCtJLcpLzFFi42LZdlhJTnfFtV8pBvO2S1tc3q9t8W3LNkaL
 t3s72R2YPWY3XGTxOHtnB6NH35ZVjAHMUVw2Kak5mWWpRfp2CVwZ749vYi34wlfROkOxgXEf
 TxcjJ4eEgInE+Z87WbsYuTiEBLYzSvxoXsoMkZCVePZuBzuELSxxv+UIVNEkJokzXxpYQRJs
 AroSW56/YgSxRQSsJFZ/eQYWZxbQluj8PAWsWVjAU6L/0QUmEJtFQFXi6+MrYDW8Ag4Si9t+
 ANkcQAvkJRY/kIAIC0qcnPmEBWKMvETz1tnMExj5ZiFJzUKSWsDItIpRNLWgODc9N7nAUK84
 Mbe4NC9dLzk/dxMjOLy0gnYwLlv/V+8QIxMH4yFGCQ5mJRHe1SK/UoR4UxIrq1KL8uOLSnNS
 iw8xSnOwKInzKud0pggJpCeWpGanphakFsFkmTg4pRqYpu8sSY8uVWvZMseNLW/9zTSj/Ilh
 60W/HeP8c9zzt9ySBrNMwwsKPWfnOct/536l1sPfpe/Gxrrun97Woqn1+n1f9p3SZhcMP8dt
 3iD74o2TjVfivTV31mTG3LdmsF3def1/0eTEZavuJ1WdCq37pKsa7rf26pr9ihc9vBZWLtxb
 17iyKuByaDv7bFd1Vbs9hRXLzS672d9aYqZysFqA60r2+6mKMSt2S1+Qm6r9Vv+H+f2Wa2kZ
 oYKrvx9eNdfh7nuxy4zXqo+6nzMN0rebvOGcmfdF75kSU9p33OpOerX92PO7Xb+SGtQvyMv0
 ndrB9+iKtmp9xfppXQJnOWcprppScIPFWbr63+YfZ99HKLEUZyQaajEXFScCAKDvYg2eAgAA
X-CMS-MailID: 20230908080912epcas2p311f577b1f5d36af18333daf4a327e7c9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230908080912epcas2p311f577b1f5d36af18333daf4a327e7c9
References: <CGME20230908080912epcas2p311f577b1f5d36af18333daf4a327e7c9@epcas2p3.samsung.com>
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

spl_invoke_atf function will not be returned to SPL. Thus, we need to
set __noreturn function attribute to the function.

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 common/spl/spl_atf.c | 8 ++++----
 include/spl.h        | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/common/spl/spl_atf.c b/common/spl/spl_atf.c
index 2c10252834f6..3bdd013a35fe 100644
--- a/common/spl/spl_atf.c
+++ b/common/spl/spl_atf.c
@@ -187,10 +187,10 @@ static inline void raw_write_daif(unsigned int daif)
 	__asm__ __volatile__("msr DAIF, %x0\n\t" : : "r" (daif) : "memory");
 }
 
-typedef void (*atf_entry_t)(struct bl31_params *params, void *plat_params);
+typedef void __noreturn (*atf_entry_t)(struct bl31_params *params, void *plat_params);
 
-static void bl31_entry(uintptr_t bl31_entry, uintptr_t bl32_entry,
-		       uintptr_t bl33_entry, uintptr_t fdt_addr)
+static void __noreturn bl31_entry(uintptr_t bl31_entry, uintptr_t bl32_entry,
+				  uintptr_t bl33_entry, uintptr_t fdt_addr)
 {
 	atf_entry_t  atf_entry = (atf_entry_t)bl31_entry;
 	void *bl31_params;
@@ -251,7 +251,7 @@ uintptr_t spl_fit_images_get_entry(void *blob, int node)
 	return val;
 }
 
-void spl_invoke_atf(struct spl_image_info *spl_image)
+void __noreturn spl_invoke_atf(struct spl_image_info *spl_image)
 {
 	uintptr_t  bl32_entry = 0;
 	uintptr_t  bl33_entry = CONFIG_TEXT_BASE;
diff --git a/include/spl.h b/include/spl.h
index 93e906431e7d..01ed8f58afd8 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -770,7 +770,7 @@ int spl_ymodem_load_image(struct spl_image_info *spl_image,
 /**
  * spl_invoke_atf - boot using an ARM trusted firmware image
  */
-void spl_invoke_atf(struct spl_image_info *spl_image);
+void __noreturn spl_invoke_atf(struct spl_image_info *spl_image);
 
 /**
  * bl2_plat_get_bl31_params() - return params for bl31.
-- 
2.39.2

