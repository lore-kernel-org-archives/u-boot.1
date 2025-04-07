Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0788C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 14:22:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E619810EB;
	Mon,  7 Apr 2025 16:22:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fyan6/Me";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13CA08215B; Mon,  7 Apr 2025 16:22:42 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A01D4810EA
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 16:22:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5378dqet013364
 for <u-boot@lists.denx.de>; Mon, 7 Apr 2025 14:22:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=lpQ8XLC5QWF9iui0jbt2CC0M
 cb90zzU4L/bFF36tm/A=; b=Fyan6/Mez714stl5RSxDoUIzXfoy0Z/95x+ts87P
 pcDGd2Gd3r6l+OwZDYoe7c6ufehaD3268w0Vs3jYb9ItoIGoxsQMLM9ILG2Ro8C1
 r4aJ6aRSBfDMX4mhdEJj5O+apg5TE70MxHjiNsYxbY2pcvF2t71hmwX5c+iOaX1P
 zczQKg+WUmk3IIVi7r2aM2TeAdlwq7XIBw7IlqrPLjX5ISYc85JJHOpl6mYg5HSn
 Y69WURc+cv9L+RLGjYxIquqTFYzXw3qZD/KbOTtW+m+hFqRTTTDC+Y0eYTXiAk6q
 0OuLyUuoGJVwR8tpsBoVVsSAV4ITDkXyVaUBhl6jXrbAVA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twc1cdtk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 14:22:38 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7c5e2a31f75so1417411285a.1
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 07:22:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744035757; x=1744640557;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lpQ8XLC5QWF9iui0jbt2CC0Mcb90zzU4L/bFF36tm/A=;
 b=Mz5psZVA1EuJgYLQ8mfeLKMbYfa9uggM401e20v9dafIBJFT9DmzIfesOXaTg/m0/U
 vbaHq+E1jpbpSXonZFIcnrC8k2pTw9eCcoKebb1ly2lnuJpmiwOaM8CORTZywd+cayxX
 1h/1z6d85zr5cD8Y7MeVbWd+Xk4ur802HKxGZWZBftUiVSsGVRMi1poXQulMqLp92tHW
 JeHODvaY1QvConjfQHn15rIrLM6UM3f9QaFzm2gw0BzobJZNQ6cxe0jhVZ/WWzl4PLV9
 OCS0VhPawPycBLgqwSq8W6UJUz164lqJlFsuSDqVjRhGbE3zvD+YrqjvpoSXMww4CZJB
 +ntg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTg09x0O49JGpk8SA6Vqo/kae0XEmN7WxblaaiR71jb2L990ZJVijtI0593TtkcS3vJfDGsoY=@lists.denx.de
X-Gm-Message-State: AOJu0Yxv0NkuX+dw32iG0edajSj9pfZCA4v/p7etQ+l0v30kIqSJDBBO
 GzIavFXngAxNQzKrHVgfTz+UlpcY5NRUwQHW/xjpplQ71qI2cPXOoCibriBtzkIiY4Ir+MV8Ea2
 i/jFPX4mEUJecFTDWyBAzKyAzcuAX8Obu/ZpaWc80gCnR7cL/N9a6
X-Gm-Gg: ASbGncviJL0F9a51Rx20uEYxM++yW3TNtE/HGHCY5Usi4//aQ6QRJNaiZX1nJfDRe4E
 Xz5ywEPfECfUOOFmD6JdVRRhBvdprB9agysaW2R2qoyQeSm2v1sRKSJ0JdcymlahbY44mKKHlQT
 N1WM3CO0frB6gX7H+inq1usOuHZ/lJEGLjuv9VMUAAmDg9I9EcqXtB2iSYlatKl7pCxsD6Bfuc1
 QictTi+u/R2YzNJS48IqnWdbw+XYkMIdgMoFSNM1Kboq045bV412DLmodsMtSn+3PrODFtTUyGv
 IFi1IAdSvfNJxmD2Sn2+bgiTwLIBOMEkUGgSXBkntwegXI8WqXs=
X-Received: by 2002:a05:620a:370b:b0:7c7:6c20:1ae0 with SMTP id
 af79cd13be357-7c774dd6ee1mr1697531785a.35.1744035757286; 
 Mon, 07 Apr 2025 07:22:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgs9TcpNm5GvokOSAhLW4W9WZdFFADPU7oS1geLL9Ml9ZuV3twUAMNwSo7HlHZaQOA7QrBeg==
X-Received: by 2002:a05:620a:370b:b0:7c7:6c20:1ae0 with SMTP id
 af79cd13be357-7c774dd6ee1mr1697528285a.35.1744035756911; 
 Mon, 07 Apr 2025 07:22:36 -0700 (PDT)
Received: from trex (233.red-79-144-185.dynamicip.rima-tde.net.
 [79.144.185.233]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30095ea8sm12135829f8f.20.2025.04.07.07.22.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 07:22:36 -0700 (PDT)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Mon, 7 Apr 2025 16:22:35 +0200
To: Christopher Obbard <christopher.obbard@linaro.org>
Cc: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org,
 sumit.garg@kernel.org, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH 1/5] board: qualcomm: dragonboard820c: udpate readme
Message-ID: <Z/Pfq0rB4gH6+JXS@trex>
References: <20250407120536.236003-1-jorge.ramirez@oss.qualcomm.com>
 <CACr-zFDncaexKRP0JouAo5BDozZEZd+_cT-i8088qxOb-JDRjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACr-zFDncaexKRP0JouAo5BDozZEZd+_cT-i8088qxOb-JDRjA@mail.gmail.com>
X-Proofpoint-ORIG-GUID: UzIE9-s-VeLPJrVH-UCyrev7VudqQlec
X-Authority-Analysis: v=2.4 cv=KtdN2XWN c=1 sm=1 tr=0 ts=67f3dfae cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=9rMOtB7ueBl8bWGkC6audQ==:17
 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=LpQP-O61AAAA:8 a=tQN35MeQ9bI-UNblYvYA:9
 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
 a=pioyyrs4ZptJ924tMmac:22
X-Proofpoint-GUID: UzIE9-s-VeLPJrVH-UCyrev7VudqQlec
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_04,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070101
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

On 07/04/25 13:50:21, Christopher Obbard wrote:
> Hi Jorge,
> 
> Long time no speak.

hey, yeah, Embedded Recipes 2023 I think. 

> 
> On Mon, 7 Apr 2025 at 13:05, Jorge Ramirez-Ortiz
> <jorge.ramirez@oss.qualcomm.com> wrote:
> >
> > Update build instructions.
> >
> > Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> > Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> 
> Your patch subject has a typo in "udpate" -> "update.
> 

thanks!

> With that fixed:
> Reviewed-by: Christopher Obbard <christopher.obbard@linaro.org>
> 
> > ---
> >  board/qualcomm/dragonboard820c/readme.txt | 47 ++++++++++-------------
> >  1 file changed, 21 insertions(+), 26 deletions(-)
> >
> > diff --git a/board/qualcomm/dragonboard820c/readme.txt b/board/qualcomm/dragonboard820c/readme.txt
> > index 966e9520e85..a01d24122cb 100644
> > --- a/board/qualcomm/dragonboard820c/readme.txt
> > +++ b/board/qualcomm/dragonboard820c/readme.txt
> > @@ -16,10 +16,7 @@
> >                       Build & Run instructions
> >  ================================================================================
> >
> > -1) Install mkbootimg and dtbTool from Codeaurora:
> > -
> > -   git://codeaurora.org/quic/kernel/skales
> > -   commit 8492547e404e969262d9070dee9bdd15668bb70f worked for me.
> > +1) Install mkbootimg
> >
> >  2) Setup CROSS_COMPILE to aarch64 compiler or if you use ccache just do
> >     CROSS_COMPILE="ccache aarch64-linux-gnu-"
> > @@ -33,15 +30,15 @@
> >
> >     $ touch rd
> >
> > -5) Generate qualcomm device tree table with dtbTool
> > +5) Append the dtb to the u-boot binary discarding the internal dtb.
> >
> > -   $ dtbTool -o dt.img arch/arm/dts
> > +   $ gzip u-boot-nodtb.bin
> > +   $ cat u-boot.dtb >> u-boot-nodtb.bin.gz
> >
> >  6) Generate Android boot image with mkbootimg:
> >
> > -   $ mkbootimg --kernel=u-boot-dtb.bin             \
> > +   $ mkbootimg --kernel=u-boot-nodtb.bin.gz          \
> >                 --output=u-boot.img                 \
> > -               --dt=dt.img                         \
> >                 --pagesize 4096                     \
> >                 --base 0x80000000                   \
> >                 --ramdisk=rd                        \
> > @@ -251,44 +248,42 @@ Wait for 5 seconds before proceeding
> >  [5300] booting linux @ 0x80080000, ramdisk @ 0x82200000 (0), tags/device tree @ 0x82000000
> >  [5310] Jumping to kernel via monitor
> >
> > -U-Boot 2017.11-00145-ge895117 (Nov 29 2017 - 10:04:06 +0100)
> > +U-Boot 2025.04-rc5-00020-g40a61ca0e7eb-dirty (Apr 07 2025 - 09:37:03 +0200)
> >  Qualcomm-DragonBoard 820C
> >
> > -DRAM:  3 GiB
> > -PSCI:  v1.0
> > -MMC:   sdhci@74a4900: 0
> > +DRAM:  3.5 GiB (effective 3 GiB)
> > +Core:  136 devices, 18 uclasses, devicetree: board
> > +MMC:   Bulk clocks not available (-19), trying core clock
> > +mmc@74a4900: 0
> > +Loading Environment from EXT4... OK
> >  In:    serial@75b0000
> >  Out:   serial@75b0000
> >  Err:   serial@75b0000
> > -Net:   Net Initialization Skipped
> > -No ethernet found.
> > +Net:   No ethernet found.
> >  Hit any key to stop autoboot:  0
> >  switch to partitions #0, OK
> >  mmc0 is current device
> >  Scanning mmc 0:1...
> >  Found /extlinux/extlinux.conf
> >  Retrieving file: /extlinux/extlinux.conf
> > -433 bytes read in 71 ms (5.9 KiB/s)
> >  1:      nfs root
> > -
> > +Enter choice: 1:        nfs root
> >  Retrieving file: /uImage
> > -19397184 bytes read in 2024 ms (9.1 MiB/s)
> > -append: root=/dev/nfs rw nfsroot=192.168.1.2:/db820c/rootfs,v3,tcp rootwait ip=dhcp consoleblank=0 console=tty0 console=ttyMSM0,115200n8 earlyprintk earlycon=msm_serial_dm,0x75b0000 androidboot.bootdevice=624000.ufshc androidboot.verifiedbootstate=orange androidboot.ver0
> > -
> > +append: root=/dev/nfs rw nfsroot=192.168.1.6:/home/jramirez/Src/qualcomm-lt/db820c/rootfs,v3,tcp rootwait ip=dhcp consoleblank=0 console=tty0 console=ttyMSM0,115200n8 earlyprintk earlyco0
> >  Retrieving file: /apq8096-db820c.dtb
> > -38134 bytes read in 37 ms (1005.9 KiB/s)
> > -
> > -## Booting kernel from Legacy Image at 95000000 ...
> > +## Booting kernel from Legacy Image at 155000000 ...
> >     Image Name:   Dragonboard820c
> >     Image Type:   AArch64 Linux Kernel Image (uncompressed)
> >     Data Size:    19397120 Bytes = 18.5 MiB
> >     Load Address: 80080000
> >     Entry Point:  80080000
> >     Verifying Checksum ... OK
> > -## Flattened Device Tree blob at 93000000
> > -   Booting using the fdt blob at 0x93000000
> > -   Loading Kernel Image ... OK
> > -   Using Device Tree in place at 0000000093000000, end 000000009300c4f5
> > +## Flattened Device Tree blob at 148600000
> > +   Booting using the fdt blob at 0x148600000
> > +Working FDT set to 148600000
> > +   Loading Kernel Image to 80080000
> > +   Using Device Tree in place at 0000000148600000, end 000000014860c4f5
> > +Working FDT set to 148600000
> >
> >  Starting kernel ...
> >
> > --
> > 2.34.1
> >
