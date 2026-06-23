Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14510CDB470
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 07:00:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19BDC84A36;
	Tue, 23 Jun 2026 08:59:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ncZKJfuz";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NZACgvn3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97DD8849BD; Tue, 23 Jun 2026 08:49:36 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80557800AE
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 08:49:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65N6d89B3376140
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 06:49:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=OjhIRHuAt/V
 w0p3ARphWJGQu0zd40pT4zrHoK8huZxY=; b=ncZKJfuzS+Gx7UXaqBs82nggoIE
 EaW20GFwMj22NHjqoeZdgMZzCUqfiXjX4Xa4Nbc+2fJKCHI18qQ6H9aTtI4QbnA9
 5PSwvOtBLfKKVu8zPgb/8qt/NP2vrlIC1oime/IBkVz1+WaSxJ3D4TDlHGtSKhdO
 yLH1IN/LVtpWUH+Aumf9hAU7U6wvLRWcbQJ4CtyJTkE1dIV5v/eH5pJ9NDy9z5Gn
 wyhzrI9l+wOyDEfWsZIhFwppIKCC+znM3tjevHoudT/urhhf51wbhE4eYrhURYsy
 grhd2taoQt66Qy7a8SD0LiHC6KJ1zQUyAXMU0cMWg8Z0HGl+QfAn8yDyoXA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5yebb4g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 06:49:32 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-37c648d3ca8so3477460a91.2
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 23:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782197372; x=1782802172; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OjhIRHuAt/Vw0p3ARphWJGQu0zd40pT4zrHoK8huZxY=;
 b=NZACgvn3ErUiPUQlGUsVKG21RPRuplfNetuay+YvSMZzXC0MjW3+JR25UkreDkPfLc
 EFWmJQ6mexLahx0yly5WyUIeHhkmun4LoizNBAGtCtR6YV6OyHCjj98D+4dxBmpJcj1j
 FuKnc+jWZ+61mNw489q62sBXxZYTJ1W7F7kJM83PqE9KE4jOP+6OEacQKwCE7ayhwsE5
 5U+Le3DjDEbJi3m5Z6tVl01KGOM4EWToIUm+o6MsrdJ1nsDyDiVIyspbBS3SZU04t/1I
 dkgJ12D3pgXiah7T4XV3uc07LkoVIJB8Gq4GNpbDyqYnxU9JxBxOfacBwQTZkd8CoJHO
 vznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782197372; x=1782802172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OjhIRHuAt/Vw0p3ARphWJGQu0zd40pT4zrHoK8huZxY=;
 b=Qd7ewkqEi802G5xSpWmFvEn6FSJfXrstBCSEQ170SZ82EAuR8Q1PrX4Ai4WE1V7avm
 HUZm8x5AauJdG/l39Tb9lic7ONUTnzMJsecs9P/yrcSRO4wQxIdBlh+CXfCK1e8fEdGq
 YtkwS28kAc2MlZysVPmG5ZG/RB//J0bwlmRLvGTGuDNBgWIghhVHjjJh3Gwws36wVBvC
 uxoZD2VAF4KIRDanlrEHzBgzHbQx5UHSSveuTSkLvpWOU/aVjdz/DjDExGezNkrL23qX
 Qwsf9tjYQ6S353B/8cLL4ATlsyhM/Qb8+OGhmkzy8BZ8qFfmnqMf5G3vF8PyB5J+HawH
 +P8A==
X-Forwarded-Encrypted: i=1;
 AHgh+RoVDZcU4t1+tJaOONnK3n8el8B2QOpORaHRUiwcfkYB6wyRUJ7FrPt/4D0fGvcM41k8i4rMoUg=@lists.denx.de
X-Gm-Message-State: AOJu0YxMStLg8tysgbZ1eo5bpmfF9MvOtFNJ21fuNbdhPv8hU1ds85jK
 GKzadA9lMvUPhNcl/objI48DapbqxeVsOga81dhMZbCOfYmkuXmyM+KxArb84Z5op5Q1cjtDd80
 dYGOeFeUZXzr3IrsVqiCWz2JExtkmPPV56KZ2m3UTe8M2bNLH6tsUFt9n
X-Gm-Gg: AfdE7cm1E2GzpWT+oqDaP4SLXVN7lbt3S4IKLqHH/dzjz/VtN3ecDzUKYIqip+nDjyk
 LjBlJiIVjtSnr6offDrBk6rfD25soglWCRBoFsi/kXIPUNre1ngJcC4OlHF+romias8ujIb2+7U
 GE45Gjyy0F1xRb1LI3Xz92skcAHu8p+z79CDv2/z7GGiqXxI5ksLYOH6k/9Ko3lY8yFvL6DIr/G
 VnHqh9/u8bDTCJ7KCA/aLq6i0MiCQUyGqWzJVO/DHr9pl3+n9aCHeen+qV/CLFCt8XW8u1FWXgU
 2FWmKtFoRpMO3AvVav7/jma83D6UCF5TF9DLc7rqCpIxH1TUSrppyirgaLHxq4k3J/uz/b8uDS1
 IcyBu29lelarvLIhQBeKaCtX9SKj2idLTY2rlIameRPbUI56oV/uuiwOniWwR7gcKwiPrb34vfw
 s12pOBwLCbT4FgAO8+K1vea58LEIGLBK5rdrkJlwyl
X-Received: by 2002:a17:90b:520d:b0:36b:b4a1:2939 with SMTP id
 98e67ed59e1d1-37d16146408mr18313402a91.15.1782197371967; 
 Mon, 22 Jun 2026 23:49:31 -0700 (PDT)
X-Received: by 2002:a17:90b:520d:b0:36b:b4a1:2939 with SMTP id
 98e67ed59e1d1-37d16146408mr18313357a91.15.1782197371562; 
 Mon, 22 Jun 2026 23:49:31 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37d4eede23esm8951704a91.2.2026.06.22.23.49.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 23:49:31 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, tien.fong.chee@altera.com, anshuld@ti.com,
 alif.zakuan.yuslaimi@altera.com, tingting.meng@altera.com,
 alice.guo@nxp.com, marek.vasut+renesas@mailbox.org,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org,
 sjg@chromium.org, varadarajan.narayanan@oss.qualcomm.com,
 andre.przywara@arm.com, afd@ti.com, h-salunke@ti.com,
 alchark@gmail.com, mkorpershoek@kernel.org, dinesh.maniyam@altera.com,
 luca.weiss@fairphone.com, balaji.selvanathan@oss.qualcomm.com,
 danila@jiaxyga.com, aswin.murugan@oss.qualcomm.com,
 ycliang@andestech.com, n-francis@ti.com, mateuslima.ti@gmail.com,
 jamie.gibbons@microchip.com, david.wronek@mainlining.org,
 james.hilliard1@gmail.com, philip.molloy@analog.com, ravi@prevas.dk,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v6 06/11] spl: Include SMEM driver in SPL
Date: Tue, 23 Jun 2026 12:17:59 +0530
Message-Id: <20260623064804.3988799-7-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260623064804.3988799-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260623064804.3988799-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 8mgcJKQRqKqhtuSmLr846DeRxPWM__bM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA1MyBTYWx0ZWRfX1IjnLkYylBZT
 OBxqciCdzIcWEv5iVygX+X/f3xeNm/2q1FoTvWYD2t18cy32o2iO9H2yku0beshEvyNCo13UEvf
 y6WUCDiqlKZtIIVs+maGZmGUaVYQuis=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA1MyBTYWx0ZWRfX2Msh1IkAUMRT
 rjAV13uG242R0UtzkNPROn6qoETXLx8O9MmhHdI0QGChBVVaob6mPk8tG+hbc+ayzWE4J+6E723
 LEQXmL5POnNNJOJLH86+SBMmhhNaPHPIR7s9YWOqqC171pxObzqJbVxfNmVQf5UDa/hQl3JDu9W
 dq57zU5EE4D1W2owp53GDdndywwA5oo/dX7BDU+6bMWVFaJAO8EWDz3OusVbPf+gjvg1mF8g1VM
 P9FAI5Facv/y5XPN/2EQr2W/nLQuigyl6FkoAdkC9bEbXQ6l1aRFK256BVyNuAceKmKaJfskrxI
 0CqoA7GLuDDjrF7YhAjMrDKUb0NF31s91RSNPvkActhvukCgRKk8FVyE/IY2sBoJALRsCG2jeQ6
 7G3GBBZZ89e2jbS4J2CTaKvm3BeoiDI8n9Drx8PP+WsURafvioz3K1Oi1pCj3EmERIdk09GD0K/
 hQUwMrphZEtF4teiDZw==
X-Proofpoint-GUID: 8mgcJKQRqKqhtuSmLr846DeRxPWM__bM
X-Authority-Analysis: v=2.4 cv=YpI/gYYX c=1 sm=1 tr=0 ts=6a3a2c7c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=cm27Pg_UAAAA:8
 a=EUspDBNiAAAA:8 a=urvU1upnej4-CWmsP9sA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230053
X-Mailman-Approved-At: Tue, 23 Jun 2026 08:59:38 +0200
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

Add SPL_SMEM config to enable/disable SMEM driver in SPL.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
v3: Pick R-b Simon
---
 common/spl/Kconfig | 8 ++++++++
 drivers/Makefile   | 1 +
 2 files changed, 9 insertions(+)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 5fa94098e49..88db96807b0 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1387,6 +1387,14 @@ config SPL_RAM_DEVICE
 	  be already in memory when SPL takes over, e.g. loaded by the boot
 	  ROM.
 
+config SPL_SMEM
+	bool "Support SMEM (Shared Memory manager)"
+	depends on SMEM
+	help
+	  Enable support for the Shared Memory Manager. The driver provides an
+	  interface to items in a heap shared among all processors. This enables
+	  the drivers in drivers/smem as part of an SPL build.
+
 config SPL_PCI_DFU
 	bool "PCIe boot support"
 	depends on SPL_PCI_ENDPOINT
diff --git a/drivers/Makefile b/drivers/Makefile
index 43d0ba33281..ead082450ca 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -74,6 +74,7 @@ obj-$(CONFIG_SPL_SATA) += ata/ scsi/
 obj-$(CONFIG_SPL_LEGACY_BLOCK) += block/
 obj-$(CONFIG_SPL_THERMAL) += thermal/
 obj-$(CONFIG_SPL_UFS_SUPPORT) += scsi/ ufs/
+obj-$(CONFIG_SPL_SMEM) += smem/
 
 endif
 endif
-- 
2.34.1

