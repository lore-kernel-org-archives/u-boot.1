Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5CD6C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 08:19:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63FFD82CED;
	Mon,  7 Apr 2025 10:19:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z4Lq/7C5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 668D982C55; Mon,  7 Apr 2025 10:19:38 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15F1682C87
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 10:19:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53766VtN001298
 for <u-boot@lists.denx.de>; Mon, 7 Apr 2025 08:19:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=wDB/co1H/Oz
 plI+jx+ztCBTdGs8uFmkSYkeur/uObnY=; b=Z4Lq/7C5IwtZqd6JXMP2XmypnTo
 VNukGZdQCgIuHIYXXz9roHA2oF+7j+cglqdd+baW0rKEB4Z4wHj+Mq5XePCiIfWT
 zEZiNBFaJJ31zUFdUhRHNPDXUHOjDi5cAOHRqZEa/awJGLeko4Nq8v03YZATWZj4
 hCK9V6jueUzTEet/+ik3uhqFjTTscKG/hpxrVZAQm2G3VGqEN0+fgzeyG8nxFGWs
 RfUW52A6h+EYPSi9ykOAgVhR0zO8Q5/T2/FwCJfqeHMADSCiC2RQwPPcLp2T2Zc+
 eyj0PldTHzMn9n2wUY9RQUS5aD5AFxp34d2/6MnDNEBM3sqD4PaDilwLIOA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twdgbeqm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 08:19:34 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7c54a6b0c70so358061985a.0
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 01:19:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744013974; x=1744618774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wDB/co1H/OzplI+jx+ztCBTdGs8uFmkSYkeur/uObnY=;
 b=nl4GYSFirTPDBmoMEYBopyA/YGn9mYQ3tSdjJ+k9HBJdqovKbOhzQ9R8wfLbh8wul4
 RGFMHdyNR+zzdGmfiyn3gQwfIg4VPPa2J2SX8XZnEFW9Ahkgdx/cMzMjKFSbTR62lEVB
 UImerMkahibpBZMDwpgH9zMQRCChKg0M3EdeM2HshLQjdVLH9E/njDwfhygw+ekuIRvY
 i7PwVh8+1dHgRsv0+YVQ1ox0PHBtGtrP43MXfvfy98+/l11sd7SYbtD1HvpFwGihmpD0
 z8hANKG+IEBaAxnxij6DMv4paTFeSkePfKbCtgCsIFDp7TLc/kppBssLDk5ynWQOVHaL
 Cqvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMTP5a9wclmSdl8AOrTNXaqqdGrSwNwiiSFONpn87e3hv0ogYmCPeDOmGaQI2njKWJPmtkn8k=@lists.denx.de
X-Gm-Message-State: AOJu0Yy5WfLId9BnabXuooai9pI921sxei90GjfWHH4hnowtQzUGzJj8
 qfV6DyuiFPlLwpKx6UtIRgrbjdR2bc3uFIofp+yOq8XBnhl6NMuHhtRtH4Ds046PtAa3Kj9/V22
 pAI/jAnbZYdnbgW7M5s+jvhYCaI6w8r4/gCM1SErouzD8w7wegbXr
X-Gm-Gg: ASbGncsH2FFkhp69nLXIG0qIx1QXfxnRaWnLwdZ/CXttBLvZIvoX3oHgT74c8PdcFRA
 YxPUiLA+bWJk4U4330UetdFN4k+HuGQYfZQnb8vjVVS1Q+2KTn9wsERUVZ0giEU0cGgArCeoiua
 OKEQJHpkap3FLu7tHqUljdm4uewm5VKwSxM4oUYNOMxP8HACcx46lQN2nontNHn1+5b/UMLjxYm
 Baznr5Apbi9JNSciHeaIXeUv150DFKz+RfkVDKlkcr4zdDfHc2gYh+4n9ZUIa+zrtl2DVn/Zu/0
 xv3vnxdZzjLHsXhK+9O/NcIFoEpHAnQ9j+/FF4raisWd3VUgrIK+E5T1cI5Ifu4vvr3/XQ==
X-Received: by 2002:a05:620a:4588:b0:7c5:4ac6:79de with SMTP id
 af79cd13be357-7c775a130dbmr1500051985a.24.1744013973842; 
 Mon, 07 Apr 2025 01:19:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGU0u9Z409FE0Z1dZVmmQHdU5A8vC0HhZAoeRKdng/Dn5Lutq7Qtuonx0YBumzCUGIHHalXTg==
X-Received: by 2002:a05:620a:4588:b0:7c5:4ac6:79de with SMTP id
 af79cd13be357-7c775a130dbmr1500050285a.24.1744013973524; 
 Mon, 07 Apr 2025 01:19:33 -0700 (PDT)
Received: from trex.. (233.red-79-144-185.dynamicip.rima-tde.net.
 [79.144.185.233]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec169b4e4sm125815155e9.20.2025.04.07.01.19.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 01:19:32 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, caleb.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH 1/7] board: qualcomm: dragonboard820c: udpate readme
Date: Mon,  7 Apr 2025 10:19:21 +0200
Message-Id: <20250407081927.138915-2-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250407081927.138915-1-jorge.ramirez@oss.qualcomm.com>
References: <20250407081927.138915-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=PJgP+eqC c=1 sm=1 tr=0 ts=67f38a96 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=9rMOtB7ueBl8bWGkC6audQ==:17
 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=LpQP-O61AAAA:8 a=k8iY8VpXQeIN41IowpoA:9
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=pioyyrs4ZptJ924tMmac:22
X-Proofpoint-ORIG-GUID: oL6dSkQhZC8yO4pwUPdj1_UygHgbCP7d
X-Proofpoint-GUID: oL6dSkQhZC8yO4pwUPdj1_UygHgbCP7d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_02,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070058
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
---
 board/qualcomm/dragonboard820c/readme.txt | 47 ++++++++++-------------
 1 file changed, 21 insertions(+), 26 deletions(-)

diff --git a/board/qualcomm/dragonboard820c/readme.txt b/board/qualcomm/dragonboard820c/readme.txt
index 966e9520e85..5817c837fdf 100644
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
+5) Append the dtb to the u-boot binary
 
-   $ dtbTool -o dt.img arch/arm/dts
+   $ gzip u-boot-dtb.bin
+   $ cat u-boot.dtb >> u-boot-dtb.bin.gz
 
 6) Generate Android boot image with mkbootimg:
 
-   $ mkbootimg --kernel=u-boot-dtb.bin             \
+   $ mkbootimg --kernel=u-boot-dtb.bin.gz          \
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

