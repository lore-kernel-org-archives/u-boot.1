Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF36CF34D9
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 15:26:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1813783FFF;
	Wed, 19 Nov 2025 16:26:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="az0usHkr";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KU14Z1Gr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABD2483FDF; Wed, 19 Nov 2025 16:26:02 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 100FB83FF5
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 16:25:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AJB69I91981796
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 15:25:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=o4PjT6TMBU4
 NgC8rqaAXil68QyQEASaI09nf4f7df18=; b=az0usHkrAc6mS9656qX+OUinu6c
 4ntzqJpSfVCRpDYsHrs1OutmP+xp2GdFNSrQqBBAKSka6lnQDoIpNL30p210jxkr
 bOTMvxnjCRYy1bUWw+33DInJTM1zi6j3hdgEhn7AnB+n3N0Z6xBsPr5T1fIW4536
 3+XoMGLodsxy4MN8j72meMfVKmrydxyyVYoEDMKvOolgq5IV/tN5gEl4IJ4sX+FU
 64NTBvIDuFtav7wai5RHYlEDwaaMv0hZ0oMYnnK7Wt5wJtfZUvQsHWl7gIs0565k
 3OdZnoJiXKb66Vwq1XOabipA6VhGjaIrwzChsJMiKKNZ/fd8P6WNDxJ+PIg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ahcqngpu0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 15:25:58 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3416dc5752aso20878887a91.1
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 07:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1763565957; x=1764170757; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=o4PjT6TMBU4NgC8rqaAXil68QyQEASaI09nf4f7df18=;
 b=KU14Z1GrtuOrM2xVJCQWLBCBrnePck8VNHHzxVN+lJn60wMbg0HRbsl9n3Oikv5RTT
 yobBBYUkbWh2LjOmVRIBe0tpe6x13DX/MYSaLsXsfwWo7G/PNg43U8h4+nfkIfESaV8t
 PLpY87lm8Xcne5czHPLuO43JfHn5ZRUBxFNYq6lWXzSTLRYZbHc7AeZcf8TtieAHgBjU
 H67FKJEOE8NdCz3s9WXi12dbSYU0KRNDf006G/3CqpM5ZnDblEQP32wWiB5Gw9PoQjDG
 /CRT68MYJkCtaZUzgjx+xdOctCoQMDvzHD00RpkfM6E089Wt0h0BYLQnWT7qzY625mPy
 xefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763565957; x=1764170757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=o4PjT6TMBU4NgC8rqaAXil68QyQEASaI09nf4f7df18=;
 b=R1CSYd7F+siNZkJqlPCE0vHCiamOArv3P1es25/Dsrk4lFjcbx5aokd96GsYBHmiiQ
 We1Ew1HIKayk7DrGinSrtx0rintNzRYCvL9dNx8zZNxfoPjJwU9KEufUSGVTNec5h6mt
 P3hCo9TWPNJj6TSC/K1FnKvJLma978XmE36EHdlDNjsuAHxqxYAMRQoLGCkuGWVs9uah
 MJ6bXQyODKtULYk7F17s7CCl0JD87611dj8TmpCzZ94RcTtKBx4pOfdWrG0NLFYgoX+M
 9+T5WzLIHcek4C2Lo6M+Gxwb0ahcmEhQmT1LkxyTR2fYlH8HuvcObP2qBODktdJEyLoc
 gFxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUssjSi+IRUe9PrZiZwi0TlUnxnk6ap7jEXS1Gxj5RNH0GkHm5ZwBfD2D3qO26dB/bM7fWiWoA=@lists.denx.de
X-Gm-Message-State: AOJu0Ywliw2rwk7V22BZlGSAq+ggywWJwpkBPngshqVDv73dnyWkJrgA
 kolCEIGxFbKmu1ior5yA5QHJHbeRrNDIShUK/z5YhxqW2C4hcvdGdERP5WzPjHD2xGNIS6zrjM1
 r6hW8jC8guLBM43+J2GkVgrlVOxZ6CpmDnesP4DbcsBQOWzyROiAr59vp
X-Gm-Gg: ASbGncsFeLC0KkZtA+KSbPySIAfD65aLVif8mDZ+DbgPpc2iLVVABaw1xWdabUoEuA/
 gLy/CbwkgNnjj2SqqIbVs3oVIR4p2tmZLCgDUP/3UeEINWCTdWLvCCPXBBwfnnRx70Q1a9SI0fc
 3HZ5JmRlVwzGAAfXHN/fw6SEQXa4qmThFUaU/Hg+K1qeeiWAyve0yRcW7gIWAWIw+MxLedh5MjV
 L1J1OCwuo7ki1npGNCJSsf0+1+ePcfDE2kSrsXd6Ph5bD7h0JYAAa1RSz+Vo9niRuw4/cwnDsAv
 TodyXBvJp3AvHtgXKSECFpSiFZB/Mlj/UaugS1X14KExNGAEl12nXpm2XSUnwrBLnwBR+V5GSuc
 xkLDulIzPVOy6cNKaIlA9Ka37QgBG3LYEAn4j3QE2SG4wP+IyugA3iX6TYxiggQ9bB8Wao42ZSS
 13SDMn20kOwuZ0Qw9kD/2HXqoPYHU8paF4IonMyw==
X-Received: by 2002:a17:90b:5848:b0:33f:ebc2:634 with SMTP id
 98e67ed59e1d1-343f9ea567dmr20524677a91.9.1763565957474; 
 Wed, 19 Nov 2025 07:25:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTMzrEWXxXMyIFx2yhEjMDPajj7Ls8mTo5HEJ3Wu1UFkgIS8W/91K9kjfhdTjTBKh6jlOnPA==
X-Received: by 2002:a17:90b:5848:b0:33f:ebc2:634 with SMTP id
 98e67ed59e1d1-343f9ea567dmr20524629a91.9.1763565956931; 
 Wed, 19 Nov 2025 07:25:56 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-345bbfc8eefsm3083157a91.4.2025.11.19.07.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 07:25:56 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com, marex@denx.de,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 rui.silva@linaro.org, luca.weiss@fairphone.com,
 quic_varada@quicinc.com, mkorpershoek@kernel.org, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Subject: [PATCH v1 4/6] arch: arm: mach-snapdragon: Make USB speed fixup
 configurable
Date: Wed, 19 Nov 2025 20:55:28 +0530
Message-Id: <20251119152530.4175628-5-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251119152530.4175628-1-balaji.selvanathan@oss.qualcomm.com>
References: <20251119152530.4175628-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDEyMyBTYWx0ZWRfX+3gVVn7THa3K
 oCCym2lFNk7GmifRbY4c4CfL7BKI09cWq8B/JIIfoYWwkWgMAN4PHSnoBV3xJspOmbe/BrGC4QH
 2NN3c+QmUETmmzUxiPOUxMjeNQYALnlHqRk35pO24ZWL6Vlv9pi1ExLs7T36UxqrW7cbyvw2bJU
 luqHQUb4Eyq7yICjop3lrMpNM5IjFfS6ZQZuOkYGotuJWAhsi0ZPI3sSXwLog2/NT7j9kDdD2g2
 IlbjDlx6JHrrUoF/OAvEBO+QdTHRW709kjSdK24xdd5cunDgrXPK9VQZs5lXFjlY4fAIDgL7GiN
 s+iClWJLzkr4CTLH/9FD5E97oIsdpd2a3a2o3oBrByw6AM9uhqL8blLv86BnKv3DIfP4cf7oYOg
 VyTgy1yEj0MpehSljfYuoPdC+gxoDQ==
X-Authority-Analysis: v=2.4 cv=ApfjHe9P c=1 sm=1 tr=0 ts=691de186 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=AhJC8zaAl2eY2UkKhXUA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: h9oydmh4zYIHQFsGjjdlNqjlmVqLbjOh
X-Proofpoint-ORIG-GUID: h9oydmh4zYIHQFsGjjdlNqjlmVqLbjOh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_04,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511190123
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

Add CONFIG_QCOM_USB_FIXUP option to allow platforms to disable
the USB speed limitation fixup when they have proper super-speed
USB support in U-Boot.

Currently, U-Boot limits USB to high-speed mode on all Qualcomm
platforms by fixing up the device tree at runtime. This was
necessary because most platforms lacked super-speed PHY drivers.

However, newer platforms now have proper QMP PHY drivers that support
super-speed USB. For these platforms, the fixup is counterproductive
as it prevents the hardware from operating at its full capability.

This change:
- Adds CONFIG_QCOM_USB_FIXUP (default y) to maintain backward
  compatibility with existing platforms
- Wraps the fixup code with #ifdef to allow selective disabling
- Allows platforms with super-speed support to disable the fixup
  via their defconfig

Platforms without super-speed PHY drivers will continue to work
as before with the fixup enabled by default.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/Kconfig    | 10 ++++++++++
 arch/arm/mach-snapdragon/of_fixup.c |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index 976c0e35fce..6c53aeef597 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -29,6 +29,16 @@ config SYS_MALLOC_LEN
 config LNX_KRNL_IMG_TEXT_OFFSET_BASE
 	default 0x80000000
 
+config QCOM_USB_FIXUP
+	bool "Enable USB speed fixup for Qualcomm platforms"
+	default y
+	help
+	  Enable runtime fixup of USB device tree nodes to limit USB to
+	  high-speed mode. This is needed on some Qualcomm platforms where
+	  U-Boot doesn't support super-speed USB.
+	  Disable this for platforms that have proper super-speed USB support
+	  in U-Boot.
+
 config SYS_BOARD
 	string "Snapdragon SoCs based board"
 	help
diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
index eec2c0c757e..6a64168f67e 100644
--- a/arch/arm/mach-snapdragon/of_fixup.c
+++ b/arch/arm/mach-snapdragon/of_fixup.c
@@ -27,6 +27,7 @@
 #include <stdlib.h>
 #include <time.h>
 
+#ifdef CONFIG_QCOM_USB_FIXUP
 /* U-Boot only supports USB high-speed mode on Qualcomm platforms with DWC3
  * USB controllers. Rather than requiring source level DT changes, we fix up
  * DT here. This improves compatibility with upstream DT and simplifies the
@@ -115,6 +116,7 @@ static void fixup_usb_nodes(struct device_node *root)
 			log_warning("Failed to fixup node %s: %d\n", glue_np->name, ret);
 	}
 }
+#endif
 
 /* Remove all references to the rpmhpd device */
 static void fixup_power_domains(struct device_node *root)
@@ -157,7 +159,9 @@ static int qcom_of_fixup_nodes(void * __maybe_unused ctx, struct event *event)
 {
 	struct device_node *root = event->data.of_live_built.root;
 
+#ifdef CONFIG_QCOM_USB_FIXUP
 	time_call(fixup_usb_nodes, root);
+#endif
 	time_call(fixup_power_domains, root);
 
 	return 0;
-- 
2.34.1

