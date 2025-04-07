Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21CC0C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 12:05:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F7CB82E28;
	Mon,  7 Apr 2025 14:05:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="psb9yTrN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A43882B45; Mon,  7 Apr 2025 14:05:47 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C147D82B45
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 14:05:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5378drNC016227
 for <u-boot@lists.denx.de>; Mon, 7 Apr 2025 12:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=eI3PJeAoutXZyRmWw2gTLr3i8Jf3H1FjRZ1
 AmJLowjg=; b=psb9yTrNrASn21mrcER4DXNX+hIuVCnDLORrLA+5AXp0nW2WkPH
 j4aHh+t0Ewf5Cch/wvqOj3oLGIssT95FtvjTkl099KNbFPILn5AQ2g/aYr+q/Lg0
 C/YHMDexT5bxIV9bGaxpha2+Eojoz8il2jKw5IxpRSDey9CdjNXYSeW1ujr1glgV
 r/331Ki615jinFlOdVnEBCiFAkQ0mM84gJl6DoN4lcO/lwpfTtUHZN197I0iz9Ks
 WlHihj9jl+PVF1mPnLtAw+2I4Zd+V71bk7I4FuEgHQ1E0c+3BrTjntP98zuTkyqZ
 /LBJwWcQI2r1p67R6J9HJwyt8f5Gq3tMCzw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twdgc5xq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 12:05:43 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7c760637fe5so757141785a.0
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 05:05:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744027542; x=1744632342;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eI3PJeAoutXZyRmWw2gTLr3i8Jf3H1FjRZ1AmJLowjg=;
 b=lGqV8sJVp2t+6WMrz09+RaB7qGApkoUALOke2koxWOJRyZH0s8BVyQBBBHCdmBcTrk
 2+i+do4eOpFzIKBoL8hVpycjl3xjxYVsS6D55hiQacwbzLBrMa2HuVdbMBW2O7Y/pQOo
 g4/0tix5xrhWlhYNn94UabZXHp2qiDJs/wkLAGdxHooXlPSrFXcbKLWMj3W2ca1ZKMrE
 r6OVNt3fFgR0YhvP8iqY51c2TgKGqAX18dwa3xqzsL30JzDo1EGVlBo8GnVucVNTleRD
 6Y5UM/iKZi9ZUOS5WtLkLjuMUmiPxXjgw5LjEsrvhd663GfxW97m1osDIs4SHATV52OS
 3jyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTkiUbqAlw93eUArRzkQM/jHKFfatzHbt9pBmZD2EXwTzsfZUosiD2YORwLF7OYbw2OSUY0YM=@lists.denx.de
X-Gm-Message-State: AOJu0YyNHq3uXfXFWYsAcdA8afX+WnouOpl9hcLnV+DYOz/vCGhuksFY
 V4rt4MdDrqmK8uFJTfMv5lU0zStG+/CPJdPqwHyTv/s45B8XTU74oYCAXclnMlNZQmWHGi8r8Cm
 zETxKXuR0vBpqCA0mbi60mGxoZoQRgn8RtnPJgYgRkQE0VVbyFdEO
X-Gm-Gg: ASbGncshgLUjycbbAe6MeMPoTXMSc9RD03POw5YGdUO37QCfjIWavZIVb1oLetEtf+/
 6czLJhzJ7cajIXJQr0fYrfu0z5Z4tSFSFTxTrc6gVC1BTzI6oTc33qCQRJPT6RksubTG8FNdBX0
 53D1FxQcOcXIs8NMUQQsWT5mNGLIUmmylv0XfTwqbhR594FfXjVRNZMEtV0MmnvdnMYBgaYWKIu
 IVUrRYLmunwhAR7RDCQ9JyeuSqNjZp40jVmj3GpNwS+a/Aa98KGrlTcECiXEAGN3YsVcUgwicWN
 rORldAD4vmkkrm5Zd///PnOe+6XglifP56k4lyheWieO3vlQaMa9sVGU6QdwFgvAwg7S7w==
X-Received: by 2002:a05:620a:17a7:b0:7c0:bb3f:e285 with SMTP id
 af79cd13be357-7c77dd62725mr1062955585a.24.1744027542405; 
 Mon, 07 Apr 2025 05:05:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErzzobM/LSCaThxAiwvoM9XesnAGVoCUTmvsUARd3twjeSUE3rjGbUmI8IJmk4WB76uzWocQ==
X-Received: by 2002:a05:620a:17a7:b0:7c0:bb3f:e285 with SMTP id
 af79cd13be357-7c77dd62725mr1062951985a.24.1744027541951; 
 Mon, 07 Apr 2025 05:05:41 -0700 (PDT)
Received: from trex.. (233.red-79-144-185.dynamicip.rima-tde.net.
 [79.144.185.233]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30227e3bsm11753374f8f.100.2025.04.07.05.05.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 05:05:41 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, neil.armstrong@linaro.org,
 caleb.connolly@linaro.org, sumit.garg@kernel.org
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH 1/5] board: qualcomm: dragonboard820c: udpate readme
Date: Mon,  7 Apr 2025 14:05:32 +0200
Message-Id: <20250407120536.236003-1-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=PJgP+eqC c=1 sm=1 tr=0 ts=67f3bf97 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=9rMOtB7ueBl8bWGkC6audQ==:17
 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=LpQP-O61AAAA:8
 a=k8iY8VpXQeIN41IowpoA:9 a=NFOGd7dJGGMPyQGDc5-O:22
 a=cvBusfyB2V15izCimMoJ:22 a=pioyyrs4ZptJ924tMmac:22
X-Proofpoint-ORIG-GUID: 3mjG_5F9skkTLEwbcGl-E9X0_iZUS_or
X-Proofpoint-GUID: 3mjG_5F9skkTLEwbcGl-E9X0_iZUS_or
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_03,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070086
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

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
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

