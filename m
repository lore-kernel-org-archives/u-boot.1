Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B2AC8302F
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 06:58:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF68981FEE;
	Tue,  1 Jul 2025 08:58:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fw71U0K0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C21182ADA; Tue,  1 Jul 2025 08:58:01 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D90548006D
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 08:57:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5613OZTj032109
 for <u-boot@lists.denx.de>; Tue, 1 Jul 2025 06:57:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=j87aWE8gfUXctPbs4tNhNQ6s9OFr1GvvGMS
 bIrKSHz0=; b=Fw71U0K0qBxMI93ZnzHXa+OHunq4/phdhrE4T8FbqInYhQ5wn9G
 cfmYmoZn8GniPRxpPxjVTIx6YWqd0oJwhyanvnKpkWu6TZGQ9ljxIRmbyG6ayPOi
 YV9ObRtdvTadXqOjFr/Kuvo4NmaKc8a+sHJAQqrVPuXANsZro1T/hqJ7Pf6uJYHj
 ZoqciMacY3XOqujslwUu74IBOR87FSzKidzcVnX1TZMnbOgdq4NgZoJ8MLYx6lpj
 s0ejJAvRAAlf4YLZf+xi2ly02ocLIJo+OTNjjt0r1x3N7KY/8MzbFd2HIXdaKbGj
 LiI6jRX76w9JMeeG/Kr0Xmp7Xtf2diuGtoA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j63k7mk6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 06:57:54 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b2fa1a84568so4094456a12.1
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 23:57:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751353074; x=1751957874;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j87aWE8gfUXctPbs4tNhNQ6s9OFr1GvvGMSbIrKSHz0=;
 b=TL8lEE7g5yxgTf438tM9ZVdKcXlKFohumiG3VjIyFg3mHlhPAeD2t2ZsSWJueXoKs/
 8My+pMXgbIhIAJ8sJUbKSN+M96msxGEGruZ7V+KcVS5fZjpYorUxk9frcA/zXMwHh/un
 u+izZEFW7y8pMBtAJr5Jcct4wo5z0cjbDePZGHM+wd+AaG1C8SJgXiI7t9rZbL/xf5Sq
 M87OVW04Dn6C34Ep0xSWHseyQQ/9MQ9U2wmmCa9ZazzUfQ8qy6IgzKj5MJ6bC8m3YwJS
 fv/fwUDiGv10CRxZxfkK4Cw9FrBK5JDmV1DrvsyPXUenjOgyr6ixlJ8tZTsYYDio8liv
 FSow==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuBYVBFPh8PyIn2jN2wBlo87q6c+E5Wyt7ShDbRXLp3w1s6nPYa0SZHDM6vX6VW3J22ssd6EU=@lists.denx.de
X-Gm-Message-State: AOJu0YwdGlcUk6qEaGYlYZCmEfpBemnyOT3cbfByB0hs18PICmTJvSuY
 QHy1Xq06qARjuhOesbz5pMVHozKluk/a6hNyZ7Jev/b25MXMuas9xiwYu8tr2ZTFPdZ2MImCtHc
 SgA/vA9LKgjnX5gPBIFeBXHaPRWxmZU6oCjEOAQpvQIUXMHBrVJInu7CY
X-Gm-Gg: ASbGnct66noxh3+ZkKW2EbQ92VwM0iiMcORUI6e88jWs8eg+bOASvageLy1vZ4Ybtk1
 dPUjthXHJXTz+uT9g/xhNvh/I1cb2mFWSuSx66EKt/tB8X9tMiWo6KpQMsEW0ngJmiPrpWc58sU
 fCUGzZ2KSRjZqDixFwrY5Rrdl9v7Eb0ByqJUJ785AwZVdQhsbqBfa4RSr+HXSCQbY5rY0TlfSRo
 tuhbrIPjmGOiClO4NItpm8vLQzwzDvzdFDJPhWhUI8a/C+Tigbf3+xrUnMD2ciM0kxVKfohJXYr
 XmPVV2L0pLNCK1tfFg1LRL9XKE5LBY2qCW5Sr5R8rxEZFi598qM6HLgWsmBEQ4P9xSmYe6xWHTA
 ReSsKrk2AutHG46m0y3/JcZfUg3/sA3Yv9x8cZ5h+FbW5sarj8g8=
X-Received: by 2002:a05:6a20:734e:b0:21c:fa68:9da6 with SMTP id
 adf61e73a8af0-222c9986fe7mr3618000637.8.1751353073929; 
 Mon, 30 Jun 2025 23:57:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlRC8aWz4sxh6sx35tIt+TAGuEvGBCxw2pvbzueOdegXe6KY+5QtFKKF39Q5UYx6wLyTG+IQ==
X-Received: by 2002:a05:6a20:734e:b0:21c:fa68:9da6 with SMTP id
 adf61e73a8af0-222c9986fe7mr3617967637.8.1751353073476; 
 Mon, 30 Jun 2025 23:57:53 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b34e3026c51sm9554662a12.30.2025.06.30.23.57.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 23:57:53 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: sr@denx.de, casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 balaji.selvanathan@oss.qualcomm.com, hello@paulsajna.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1] watchdog: qcom-wdt: Drop read check on write-only WDT_EN
 register
Date: Tue,  1 Jul 2025 12:27:38 +0530
Message-Id: <20250701065738.1644669-1-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ZKfXmW7b c=1 sm=1 tr=0 ts=686386f2 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=oqPD5ApjgXJCjJyYgbsA:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDAzNyBTYWx0ZWRfX53dS9gX4CXcI
 wUhqb46Op/EN1hspo/SwwkA5zt3goJHXX0sMQW9bt+VKE37W/5DvkM4EsjNXfrYUhXk/ZyzLVzE
 U5kc6gsky6EeDaqLnkuoG80mxpgFGRwk3g3htcnAUZlzRmbgg5cVSlxATUVqg86/FdgsBE/bXVE
 v0zo+bb0aiInSKACSoH+GtDw/6QVGI6vKj1CFwO2/uZ7ORf0/omD3pGHNHgW/uc8wK3uJQ0RD0O
 YZZOAzf4K78eIQPsVP2fFJ4ZD9+W4M5vVIRyRKa4bXiMTfMBN7VpbEXvrPVHyNLa4mJCoe8S7/D
 4TvIJG87pPsIrC/fQqs93eez9RjYBw1xzi1eOsEVCgdoxI8ZOBs+QZ4efXSR1Xqz5o53gz+g+mF
 MMZKd4XRn21u6qbMoVqIRopr2U4Jc8mfbaTjhFJkw3F7p6rDKNVUkFZUwJkpYBjezjKJ3/P8
X-Proofpoint-ORIG-GUID: mZcF7reZnFM0rugNO0a40yc3cBxGJR_v
X-Proofpoint-GUID: mZcF7reZnFM0rugNO0a40yc3cBxGJR_v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 mlxlogscore=924 spamscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507010037
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

On some Qualcomm platforms, such as Dragonwing boards, the WDT_EN
register is write-only. Reading it back after enabling the watchdog
can return invalid data or cause unexpected behavior.

In particular, the check:
  if (readl(wdt_addr(wdt, WDT_EN)) != 1)
may fail even though the watchdog is correctly enabled and running.
This leads to misleading error messages and unnecessary failures.

Removing the read check ensures compatibility and avoids false
negatives on platforms where WDT_EN is not readable.

This work builds upon this previous submission:
https://lore.kernel.org/u-boot/20250625094607.1348494-1-gopinath.sekar@oss.qualcomm.com/

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/watchdog/qcom-wdt.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
index af97b27e311..e4ebb1f31d4 100644
--- a/drivers/watchdog/qcom-wdt.c
+++ b/drivers/watchdog/qcom-wdt.c
@@ -82,10 +82,7 @@ int qcom_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 	writel(bark_timeout_s, wdt_addr(wdt, WDT_BARK_TIME));
 	writel(bite_timeout_s, wdt_addr(wdt, WDT_BITE_TIME));
 	writel(BIT(0), wdt_addr(wdt, WDT_EN));
-	if (readl(wdt_addr(wdt, WDT_EN)) != 1) {
-		dev_err(dev, "Failed to enable Qualcomm watchdog!\n");
-		return -EIO;
-	}
+
 	return 0;
 }
 
-- 
2.34.1

