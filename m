Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9056CC83F11
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 01:20:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83D52863FB;
	Tue, 29 Aug 2023 03:20:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="NhnIBPRN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 770E786405; Tue, 29 Aug 2023 03:20:36 +0200 (CEST)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B627863F8
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 03:20:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20230829012028epoutp04662e8a7108e9fc57257015ef88ef269b~-tfBD94zQ1552815528epoutp04J
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 01:20:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20230829012028epoutp04662e8a7108e9fc57257015ef88ef269b~-tfBD94zQ1552815528epoutp04J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1693272028;
 bh=4N93BkAxKcOEhJtN9sD5Yira3sY4soIghdWRD0h7qEE=;
 h=From:To:Cc:Subject:Date:References:From;
 b=NhnIBPRNJYKxT1Pz2Q7WgPrHmQPDjtqhHCw9nOfxeQPAYsHaqaw6hlAltbR8o5MZg
 D3oWA7ZpEmANp7sQ8EE0D6RTgxSAXGNNFgMmIbHngEG5u3225ILm9WcXjQnCrGzaRk
 MtTIz2vmuyt91b4q7/YAgOADVzEAlNVx5W4E7Z8k=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTP id
 20230829012027epcas2p17247f3f9198c828053307f0d3c575e46~-tfAC9RSZ1660616606epcas2p1T;
 Tue, 29 Aug 2023 01:20:27 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.97]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4RZV3Z3nxyz4x9Px; Tue, 29 Aug
 2023 01:20:26 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 C7.43.09765.AD74DE46; Tue, 29 Aug 2023 10:20:26 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
 20230829012025epcas2p1a233126199d0ec5aa2e9ca892c963b9d~-te_ixfsk1660616606epcas2p1S;
 Tue, 29 Aug 2023 01:20:25 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20230829012025epsmtrp11e6acb418f0b82bbb174e3f7d07a02c8~-te_h6kUJ2703027030epsmtrp1P;
 Tue, 29 Aug 2023 01:20:25 +0000 (GMT)
X-AuditID: b6c32a48-c86f0a8000002625-50-64ed47da9dad
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 A4.C3.08742.9D74DE46; Tue, 29 Aug 2023 10:20:25 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20230829012025epsmtip2ec389cf3bf7221bd49a4ba0160cb6211~-te_YHpYX1497914979epsmtip2q;
 Tue, 29 Aug 2023 01:20:25 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Leo <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Lukas
 Auer <lukas.auer@aisec.fraunhofer.de>, Chanho Park
 <chanho61.park@samsung.com>
Subject: [PATCH] spl: add __noreturn attribute to spl_invoke_opensbi function
Date: Tue, 29 Aug 2023 10:20:14 +0900
Message-Id: <20230829012014.2516535-1-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42LZdljTVPeW+9sUg6M/BSwu79e2aJn3ltXi
 7YuzjBbftmxjtJg6aTO7xdu9newWjw+9ZnJg91gx6w6bx57Ts5g9ZjdcZPF4dWAVu8fZOzsY
 Pfq2rGIMYIvKtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1
 y8wBukVJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BeoFecmFtcmpeul5daYmVo
 YGBkClSYkJ0x6dtWpoLZ/BWrflxla2B8y9PFyMkhIWAicfrbBlYQW0hgB6PEjB9OXYxcQPYn
 RonWBbvZIJxvjBItn1exw3RM37GDHSKxl1Fi4u47TBDONCaJIwcesYBUsQnoSmx5/ooRxBYR
 CJd41rGTFaSIWWA2o8Tc5VeZQRLCAv4SKw49ABvLIqAqcfnde7AGXgEHifdHDgHt5gBaJy+x
 +IEERFhQ4uTMJ2DzmYHCzVtnM4PMlBC4xi7x6+IKJojzXCRWf5zGBmELS7w6vgXqbCmJl/1t
 7BAzyyV2LEuC6G1hlGhu28MMUWMv8ePmFFaQGmYBTYn1u/QhypUljtyCWssn0XH4L9QUXomO
 NiGIRnWJA9uns0DYshLdcz6zQtgeEnN7D7BAQjdWYtqmCawTGOVnIXlmFpJnZiHsXcDIvIpR
 LLWgODc9tdiowAQep8n5uZsYwalRy2MH4+y3H/QOMTJxMB5ilOBgVhLhveT4KkWINyWxsiq1
 KD++qDQntfgQoykwdCcyS4km5wOTc15JvKGJpYGJmZmhuZGpgbmSOO+91rkpQgLpiSWp2amp
 BalFMH1MHJxSDUxaM+x2hM5YyXaiKSPq2FEBldMhsY/Uvdw4gl5cv58y5fnWAy/mX1FPnG4w
 deNVubP8S197lX5uLPzY8L/0HOf8+KpFN6ZdW6+fFPnCoNy+YfNK4TMh+u6Lb52d0XKk3HrB
 DbWbb8Lj5u+Mv/5p0tsyr+XZpzlCNjZfTk+oMircuM2RL0NqY+piB4ew2Jj7oa8z7kzMD08W
 Wvalp+fSiwnbpqS/WfFzd0RoZdwP6R8VSjLq6+uFnt5XWzGzak/AA3/VvXUiemkXa2eHuGhV
 e33WcfooJcdmLPRwY/HRs409s+Zlr5A8uVIj9uwVS85k+ffVepWqWcfnympN/7xp+/VbwhrN
 i37IfhfumyWR8+6REktxRqKhFnNRcSIAV8H7tBYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCLMWRmVeSWpSXmKPExsWy7bCSvO5N97cpBh/atCwu79e2aJn3ltXi
 7YuzjBbftmxjtJg6aTO7xdu9newWjw+9ZnJg91gx6w6bx57Ts5g9ZjdcZPF4dWAVu8fZOzsY
 Pfq2rGIMYIvisklJzcksSy3St0vgypj0bStTwWz+ilU/rrI1ML7l6WLk5JAQMJGYvmMHexcj
 F4eQwG5GicYfjewQCVmJZ+92QNnCEvdbjrBCFE1ikli1dBcjSIJNQFdiy/NXYLaIQKTE9yNT
 mEGKmAXmMkpsvbyUBSQhLOAr8f3kb7BJLAKqEpffvQdr4BVwkHh/5BBbFyMH0AZ5icUPJCDC
 ghInZz4Ba2UGCjdvnc08gZFvFpLULCSpBYxMqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLz
 czcxggNWS3MH4/ZVH/QOMTJxMB5ilOBgVhLhveT4KkWINyWxsiq1KD++qDQntfgQozQHi5I4
 r/iL3hQhgfTEktTs1NSC1CKYLBMHp1QDU+1Fm56AzeG3JLmrlvvnikrOWm9xR7VU99vdmb0c
 RQ2esTOCI9pWf5zRLSjAqMzOdGLqxje6d879u746Q7P3/SLmmJbOEMnnc68/2f1LTH2fufAC
 c4U0373MCVtPm86VmKlkOfnfr8dNG6u5N3dNf3Tq36RcJ/MJbT5mHdMNw/6+FeJRF+0KMdx1
 9/aexmNBXP9tv3pO+93eLdyWcGDnnngzcbZb1/uqda9wzM59paUxn9v1VJbOlp9CtQsaC6yC
 m42dqq8l1vpKz38iF7FvjXRCxOVLmkmP2mR/OO5U2HFxfUxJz4FtBlme/rqs6/vu6j218Nvy
 x/Q/g23VxvLnbVnz5XyOxNm+e1i4q0ldiaU4I9FQi7moOBEA5QW2dMcCAAA=
X-CMS-MailID: 20230829012025epcas2p1a233126199d0ec5aa2e9ca892c963b9d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230829012025epcas2p1a233126199d0ec5aa2e9ca892c963b9d
References: <CGME20230829012025epcas2p1a233126199d0ec5aa2e9ca892c963b9d@epcas2p1.samsung.com>
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

spl_invoke_opensbi function is not returned to SPL. Thus, we need to
set __noreturn function attribute.

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 common/spl/spl_opensbi.c | 7 ++++---
 include/spl.h            | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/common/spl/spl_opensbi.c b/common/spl/spl_opensbi.c
index b0f40076c345..e2aaa460468c 100644
--- a/common/spl/spl_opensbi.c
+++ b/common/spl/spl_opensbi.c
@@ -43,11 +43,12 @@ static int spl_opensbi_find_uboot_node(void *blob, int *uboot_node)
 	return -ENODEV;
 }
 
-void spl_invoke_opensbi(struct spl_image_info *spl_image)
+void __noreturn spl_invoke_opensbi(struct spl_image_info *spl_image)
 {
 	int ret, uboot_node;
 	ulong uboot_entry;
-	void (*opensbi_entry)(ulong hartid, ulong dtb, ulong info);
+	typedef void __noreturn (*opensbi_entry_t)(ulong hartid, ulong dtb, ulong info);
+	opensbi_entry_t opensbi_entry;
 
 	if (!spl_image->fdt_addr) {
 		pr_err("No device tree specified in SPL image\n");
@@ -74,7 +75,7 @@ void spl_invoke_opensbi(struct spl_image_info *spl_image)
 	opensbi_info.options = CONFIG_SPL_OPENSBI_SCRATCH_OPTIONS;
 	opensbi_info.boot_hart = gd->arch.boot_hart;
 
-	opensbi_entry = (void (*)(ulong, ulong, ulong))spl_image->entry_point;
+	opensbi_entry = (opensbi_entry_t)spl_image->entry_point;
 	invalidate_icache_all();
 
 #ifdef CONFIG_SPL_SMP
diff --git a/include/spl.h b/include/spl.h
index 92bcaa90a4af..93e906431e7d 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -862,7 +862,7 @@ void __noreturn spl_optee_entry(void *arg0, void *arg1, void *arg2, void *arg3);
 /**
  * spl_invoke_opensbi - boot using a RISC-V OpenSBI image
  */
-void spl_invoke_opensbi(struct spl_image_info *spl_image);
+void __noreturn spl_invoke_opensbi(struct spl_image_info *spl_image);
 
 /**
  * board_return_to_bootrom - allow for boards to continue with the boot ROM
-- 
2.39.2

