Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1189DC83000
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 07:01:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2337682D4E;
	Mon, 30 Jun 2025 09:01:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="l+8LRn6Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABFB682E35; Mon, 30 Jun 2025 09:00:59 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8518D800C1
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 09:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55TLvC5x014890
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 07:00:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=iRw+jfCSsi2
 Td2SzTGpvk9KqY9UMXd2nrJXMk8Vlp38=; b=l+8LRn6ZfHbhzJOGZmkKK29Jmpd
 OLemSnk1TT2Tlwf8F6ZX6uyvUNfJ+Di221fxfab8BTdk/J2cD5jmTjs4DTRzZlel
 csdcIwXuqQMYG+87NuP9BBxZ/yaTwzTA/Le7cb/3Nz0ccPuhregPZPa0eQEdh+M2
 zn0hPn7iUgNzxXFIfZ1w1fAz/nxvXAyCCNNMmiI37QK2i1rXiS584pwrfva09q5H
 VMls3Fl9Zoou1BjX2amwDsw0DoLzfLIH3zoM0mXq9ETfFx3igxenVFWFryL2LA3E
 iCPZO+Y9fZiiHzMVOQ+1ItmJlgAqg/Dh+n7IX3XNNyuU4h3JoGsE16i9GVw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j63k3ugj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 07:00:53 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-7394772635dso3138220b3a.0
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 00:00:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751266853; x=1751871653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iRw+jfCSsi2Td2SzTGpvk9KqY9UMXd2nrJXMk8Vlp38=;
 b=i4yxWC1QRne6X5XzdZdPRKvYRLJUHCFFhN+RyX96P4j5H1fLY5EDN2Lr8a98Ama8yn
 gPPauWNOjAP2j8g2/4H9YPG2dE8EWV8tJTR0UXLmupPbwT5MmaFVrnPWkS8kklIzu6lH
 gN21jiHLjwpiu8KNcoH/rY6qvkM6TW6q/rGRZzDK9O1U9zgvR/1DZMN4iDmENMhJ1B7p
 BJIn2EjEYheRkI/lJh9DQIlKfr67XbY1tg7qpup5Oz8Mg7NcV/+aZcYPgLRfcFGwqFV/
 UKHmrQ0oX3xFYTgCP82+Bj8CRhIdEli4+KVlLCWZF6YZStVlH6RzfSLdn8EQahJkxxLj
 wwmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmRrZpZANSXqaRmyp7/DrYYcuSGr+ZwvYw/Eh8biXLDwvf6y5i3XHy//FQtl2/chANymqGc2g=@lists.denx.de
X-Gm-Message-State: AOJu0YypP3zZ3b2MqAAPlmnoghwZ6ER1iEMum+qK2++JkMXE7k5/gWAF
 Ai6a7Py0cZ7XqhJfSibr9sPqsNSigyKynSeDBG0hq94FCXd+E+HnnjspgV2uA0wjXbWd801FFbo
 22IMf6J4dz7jtAXEWPF6+9N8/58W7nYHGxfNKiIl0W+nb+Aurgc9iEtnK
X-Gm-Gg: ASbGncusNQN2YAAle+OGtk8wMSB3Y7Ijcn5hDa58y9p+4vfBiQcHB7F1M7gsLsOX6qD
 F2P95x/KjITzuH35lndwywl+wEAQS8+AfuiWVO/T2+3IJVNYMCuFbIhE4A2x9tmExobfQsbaMrC
 ElPGQIYhd2Fw9oVHN7NE0Xqi2apMoIHAIqz49KlAnIbSF16hBoxEvjML5ARSW8HyK4+OcaFOvUE
 lVtyv3mw0aYOUdfNqSHqmMukNHZDIPJq4429qVqpegi0Yktx62fIDddtHwtEtFkdbkLKPVfmiFv
 txD/fiX8PGIDu07C7y9yReSqZx2chm/SyWM+sxIDI5viUfQw3XDY6kg6KRQ9AEt6gG1br9MVk+m
 WdFDavk2XlgPB6to+/WLix59SclTHdt/pdR+Y5yJb7FgyFvE6x/M=
X-Received: by 2002:a05:6a00:2195:b0:748:f80c:b398 with SMTP id
 d2e1a72fcca58-74af6f08c99mr15333377b3a.15.1751266851619; 
 Mon, 30 Jun 2025 00:00:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYUu/8/y4v7MBSNXjVGspvEWKmNhUST+mlWTFH/Ww0QwybOF3HXzOC2eyCaGBb+X7zDIUPSA==
X-Received: by 2002:a05:6a00:2195:b0:748:f80c:b398 with SMTP id
 d2e1a72fcca58-74af6f08c99mr15333344b3a.15.1751266851196; 
 Mon, 30 Jun 2025 00:00:51 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74af540b443sm8383634b3a.15.2025.06.30.00.00.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 00:00:51 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 balaji.selvanathan@oss.qualcomm.com, quic_varada@quicinc.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1 2/2] configs: qcom_qcs9100: Fix fastboot buffer address for
 QCS9100 board
Date: Mon, 30 Jun 2025 12:30:40 +0530
Message-Id: <20250630070040.734486-3-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250630070040.734486-1-balaji.selvanathan@oss.qualcomm.com>
References: <20250630070040.734486-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ZKfXmW7b c=1 sm=1 tr=0 ts=68623625 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=gmEqoM0KDesFiAEcSG0A:9
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDA1NyBTYWx0ZWRfX3KgQrpDenN+f
 AH4yzmLKWkXumvLPbgO4bYUht3MKBiZQBu9MMSkreOOqZURWBynjQ9Mym5SfRnxh2vE6Gybt/J8
 l/XQ5KZIFH9zl01DaVLkoA1fClOvtmeQl1jQogYd7nWSAb3lTEJSyoP2BApFuXD5+nFv6IPyyx/
 ePUeOAV8j5u9VgQ50H/V//hGf11r5Iz25I4Tn+o1LnlTiY6BJXslYgZAQ8nNop3CB1+UTxUbE2g
 Y+IRxPaZkx/ARaUa0t7so1DLdU5g/BeYb1L6tx/hqg16Fk60+HAlEt56VyXa/lVOnu+T0t7Opr9
 KopPnJHujq0MWz3tqsSkDCz8ZhvbIiSbzqQQ3AgZ7Us8wwjpe7Y6wmDThTu8Oc30MqlspS7g/aD
 5lhatxTc+hcUuhKoYukTSfbTo7Z/Fw2SV+t6aR2HLnPrzaaO7GkFPOdNGJlPkMXa8BG7fwwi
X-Proofpoint-ORIG-GUID: O_RVagV3meY_-6x-qLOlZAXx88gg2fz_
X-Proofpoint-GUID: O_RVagV3meY_-6x-qLOlZAXx88gg2fz_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 mlxlogscore=760 spamscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506300057
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

The default value of CONFIG_FASTBOOT_BUF_ADDR is 0, which causes
NULL pointer dereference during fastboot commands.

Set it to 0xdb300000, a safe and sufficiently large region in RAM
of the QCS9100 board, to prevent crashes and ensure reliable
fastboot functionality.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 configs/qcom_qcs9100_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/qcom_qcs9100_defconfig b/configs/qcom_qcs9100_defconfig
index 10ff4d25398..5b6475dcfe0 100644
--- a/configs/qcom_qcs9100_defconfig
+++ b/configs/qcom_qcs9100_defconfig
@@ -15,4 +15,6 @@ CONFIG_DEBUG_UART_CLOCK=14745600
 CONFIG_TEXT_BASE=0xaf000000
 CONFIG_REMAKE_ELF=y
 
+CONFIG_FASTBOOT_BUF_ADDR=0xdb300000
+
 CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs9100-ride-r3"
-- 
2.34.1

