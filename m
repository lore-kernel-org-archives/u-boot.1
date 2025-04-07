Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C04C36018
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 17:56:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F345882F10;
	Mon,  7 Apr 2025 19:56:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jQJRQQpu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E499582F65; Mon,  7 Apr 2025 19:56:31 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78E5182E76
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 19:56:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5378dxc2023157
 for <u-boot@lists.denx.de>; Mon, 7 Apr 2025 17:56:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Lh3YUWlgnoaddJXBTDfDYp
 eA5PPqzwyMJg/+Kg1CPME=; b=jQJRQQpu7huLcvs9wZVuDTo7eRALERGIrQyGCI
 cLMH/AsrVEwxT75v+g+60gMuETIemFvKoAS4DKXqCtCd5NSyFfl6UfjK4iRMdBGQ
 piAR+M4iCA2jL/LnBJuSvrbyTVymZ/+SHDJ9CrOZGPL6AREqsWIgs6pEj2wf5PcC
 laHoer70Z0K3UXcDjtHjhVg0IkV1zmdCDY8tFyda2HVKwrnUfFzblx5SyymXPeeA
 rZ+5oWQNEy4BeRBFaekYERgoD1RdfEEG7Oz/rxAO90uSpPXUwNUw8mnhXWI1nVXP
 4H7BfuNsby6ooTDawDSiMdT/L/XwzYuuHBdqCN2WeWvUqMKQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twcrd2v5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 17:56:27 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7c53e316734so860734185a.2
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 10:56:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744048587; x=1744653387;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Lh3YUWlgnoaddJXBTDfDYpeA5PPqzwyMJg/+Kg1CPME=;
 b=XUCrR6XhQYGG3C39YQXxdabJ/2Y4yVO0y+VUdgZxFYxjc87uq+EGDkSOWhEyoDuh3K
 tqF3VH1dtbnqqrmCzTl4Wkr7M/Vm3FQnapQ8uLHILIcPZYIYlvc5FkNewI5/NYiQaTvg
 XtCADfV2QSj5LEUeKff/jl7hZd71yXSw4j46BKH1tBV0uuSObzvY+Rtdmqd+yPtFP6ak
 upPhhoxLFRqgIhHUWHewgf+E6kMT5ky9/eAT9nmbml/EnZ+bijPj5YO3qSY8BObRCGDp
 JRiz9x9vNjdPeGVC8uIABsFGe/lCCXc9gL+xRUUkD7WzGn02WL49IDG+lejeyx1QM3/k
 XN5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3R45fMup/zxhLS2pPT2ZPflW4jq9XYYHepmDHSR3znrrgEGcYi/6kntXTwC/EyYkM6/KAaRY=@lists.denx.de
X-Gm-Message-State: AOJu0Yy3SwQNJh0s/pLvIMWC1loZpSwLWREprLlkOB8qW6GsT2mJjXNR
 skWWErCJo3p8GZ0Mc142J9eEctHPBvUlEJfS75Rjv8yu3OYhytcgoIVw1yo403y+tbJa+eagFz4
 gJSQe9Aic55XHsqvi4+lQyYW/oF/qOcx2xAHpQX4UVUGhHNtKQ24X7BZbSirS
X-Gm-Gg: ASbGncsKg6BJlxzR8aZgBjJuuKVXpHuCjXwRgXcqkK9ecOwWJ/UH3Xtfdh/+lwp6tym
 RU+hleVGQpjiSLK3EY34mRkWLSlDkGrgBIIDfhhKaTonOhH9TuAebhiqOV9PIluZn32N1tmTtQ4
 BoBkKmVMS2TE8XmpJSpDgicOYqov4SDD62PYinY/EJQbSwuMqT1rb2gzUoJmH44BfoT3KY2SOu7
 1bYgPJg8H7TudAuAreahGINKTGyVBKPW9qd6WQJsRT1HyJuvKlNq/d6F+bGP5TtLRlXpbHSo4IU
 Z+FvTU0rp7mStEniiFLoRHKk1Qya+g5ipcC8R9+41JgUcLelK5IvLTF55xUTlRaJDgQ=
X-Received: by 2002:a05:620a:438d:b0:7c7:5afb:5878 with SMTP id
 af79cd13be357-7c775a2d7cfmr2334069385a.25.1744048586863; 
 Mon, 07 Apr 2025 10:56:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFt9BlkRtwXu4wqOPV5QvkeOR2+Xdb0nYHV1UH/Wz5JmPMS415/QYuzAHlIpA7yOQjL991/9g==
X-Received: by 2002:a05:620a:438d:b0:7c7:5afb:5878 with SMTP id
 af79cd13be357-7c775a2d7cfmr2334066185a.25.1744048586522; 
 Mon, 07 Apr 2025 10:56:26 -0700 (PDT)
Received: from trex.. (65.red-79-144-193.dynamicip.rima-tde.net.
 [79.144.193.65]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec342a1fesm139346005e9.3.2025.04.07.10.56.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 10:56:25 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, neil.armstrong@linaro.org,
 caleb.connolly@linaro.org, sumit.garg@kernel.org
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH 1/5] board: qualcomm: dragonboard820c: update readme
Date: Mon,  7 Apr 2025 19:56:13 +0200
Message-Id: <20250407175617.3494506-1-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: XU30LPbIPQ-5ixJrOXV6K1IfmyYwO6lU
X-Authority-Analysis: v=2.4 cv=QuVe3Uyd c=1 sm=1 tr=0 ts=67f411cb cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=K4l/FCcx7sfGu+4G7WjjoA==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=LpQP-O61AAAA:8 a=k8iY8VpXQeIN41IowpoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=cvBusfyB2V15izCimMoJ:22 a=pioyyrs4ZptJ924tMmac:22
X-Proofpoint-GUID: XU30LPbIPQ-5ixJrOXV6K1IfmyYwO6lU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_05,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070125
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

Update build instructions.

Be sure to use the u-boot-nodtb.bin image, as the Snapdragon platform
prioritizes the embedded Device Tree Blob (DTB) when present, rather
than the external one. The external DTB—modified by LK—is the version
required by the DB820c.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Christopher Obbard <christopher.obbard@linaro.org>
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>>
---
 board/qualcomm/dragonboard820c/readme.txt | 47 ++++++++++-------------
 1 file changed, 21 insertions(+), 26 deletions(-)

diff --git a/board/qualcomm/dragonboard820c/readme.txt b/board/qualcomm/dragonboard820c/readme.txt
index 966e9520e85..a01d24122cb 100644
--- a/board/qualcomm/dragonboard820c/readme.txt
+++ b/board/qualcomm/dragonboard820c/readme.txt
@@ -16,10 +16,7 @@
                      Build & Run instructions
 ================================================================================
 
-1) Install mkbootimg and dtbTool from Codeaurora:
-
-   git://codeaurora.org/quic/kernel/skales
-   commit 8492547e404e969262d9070dee9bdd15668bb70f worked for me.
+1) Install mkbootimg
 
 2) Setup CROSS_COMPILE to aarch64 compiler or if you use ccache just do
    CROSS_COMPILE="ccache aarch64-linux-gnu-"
@@ -33,15 +30,15 @@
 
    $ touch rd
 
-5) Generate qualcomm device tree table with dtbTool
+5) Append the dtb to the u-boot binary discarding the internal dtb.
 
-   $ dtbTool -o dt.img arch/arm/dts
+   $ gzip u-boot-nodtb.bin
+   $ cat u-boot.dtb >> u-boot-nodtb.bin.gz
 
 6) Generate Android boot image with mkbootimg:
 
-   $ mkbootimg --kernel=u-boot-dtb.bin             \
+   $ mkbootimg --kernel=u-boot-nodtb.bin.gz          \
                --output=u-boot.img                 \
-               --dt=dt.img                         \
                --pagesize 4096                     \
                --base 0x80000000                   \
                --ramdisk=rd                        \
@@ -251,44 +248,42 @@ Wait for 5 seconds before proceeding
 [5300] booting linux @ 0x80080000, ramdisk @ 0x82200000 (0), tags/device tree @ 0x82000000
 [5310] Jumping to kernel via monitor
 
-U-Boot 2017.11-00145-ge895117 (Nov 29 2017 - 10:04:06 +0100)
+U-Boot 2025.04-rc5-00020-g40a61ca0e7eb-dirty (Apr 07 2025 - 09:37:03 +0200)
 Qualcomm-DragonBoard 820C
 
-DRAM:  3 GiB
-PSCI:  v1.0
-MMC:   sdhci@74a4900: 0
+DRAM:  3.5 GiB (effective 3 GiB)
+Core:  136 devices, 18 uclasses, devicetree: board
+MMC:   Bulk clocks not available (-19), trying core clock
+mmc@74a4900: 0
+Loading Environment from EXT4... OK
 In:    serial@75b0000
 Out:   serial@75b0000
 Err:   serial@75b0000
-Net:   Net Initialization Skipped
-No ethernet found.
+Net:   No ethernet found.
 Hit any key to stop autoboot:  0
 switch to partitions #0, OK
 mmc0 is current device
 Scanning mmc 0:1...
 Found /extlinux/extlinux.conf
 Retrieving file: /extlinux/extlinux.conf
-433 bytes read in 71 ms (5.9 KiB/s)
 1:      nfs root
-
+Enter choice: 1:        nfs root
 Retrieving file: /uImage
-19397184 bytes read in 2024 ms (9.1 MiB/s)
-append: root=/dev/nfs rw nfsroot=192.168.1.2:/db820c/rootfs,v3,tcp rootwait ip=dhcp consoleblank=0 console=tty0 console=ttyMSM0,115200n8 earlyprintk earlycon=msm_serial_dm,0x75b0000 androidboot.bootdevice=624000.ufshc androidboot.verifiedbootstate=orange androidboot.ver0
-
+append: root=/dev/nfs rw nfsroot=192.168.1.6:/home/jramirez/Src/qualcomm-lt/db820c/rootfs,v3,tcp rootwait ip=dhcp consoleblank=0 console=tty0 console=ttyMSM0,115200n8 earlyprintk earlyco0
 Retrieving file: /apq8096-db820c.dtb
-38134 bytes read in 37 ms (1005.9 KiB/s)
-
-## Booting kernel from Legacy Image at 95000000 ...
+## Booting kernel from Legacy Image at 155000000 ...
    Image Name:   Dragonboard820c
    Image Type:   AArch64 Linux Kernel Image (uncompressed)
    Data Size:    19397120 Bytes = 18.5 MiB
    Load Address: 80080000
    Entry Point:  80080000
    Verifying Checksum ... OK
-## Flattened Device Tree blob at 93000000
-   Booting using the fdt blob at 0x93000000
-   Loading Kernel Image ... OK
-   Using Device Tree in place at 0000000093000000, end 000000009300c4f5
+## Flattened Device Tree blob at 148600000
+   Booting using the fdt blob at 0x148600000
+Working FDT set to 148600000
+   Loading Kernel Image to 80080000
+   Using Device Tree in place at 0000000148600000, end 000000014860c4f5
+Working FDT set to 148600000
 
 Starting kernel ...
 
-- 
2.34.1

