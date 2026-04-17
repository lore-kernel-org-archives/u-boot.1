Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A747F43688
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 09:39:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF427841C2;
	Fri, 17 Apr 2026 11:39:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AuqzgTvc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DZrlh2TD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAB2F8423F; Fri, 17 Apr 2026 11:39:42 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C65A683BC8
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 11:39:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63H8tYqQ1971715
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 09:39:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=HQoZYkUR7ue
 FrS3ztDg/84oKaI7qkoYLCgggHgAvV4A=; b=AuqzgTvcsbnl+e4iEUSuKxh2Zh/
 /N2IspH7737JrQKN1CpMnxyL2nFT21+xlrJcVTC2QFc7/dPDctOf3N5NraW/dJDY
 H0GM/MxMq1zBM74ILGAi8Qvka8uAm4E99WG4FJG7CCKhaMrR5YXGStLxVIk12NrH
 cw00EYb5YXYMII3+9A2KPprFfVd99HSCIGAy5Lg9+r4Q9b0a6zqqzasCKFfjZXmI
 xF85CyE8L7r4krMgoOg0YeOuThOX1w9WWQIPzlApivb/xiopRwls02uImbm3Hbi/
 w4weUGD6xtCl1fJ7b96XBazFwUqEYzEKH4OsSpvzvcSBlWom/lnp7pB0rog==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkhsh85mw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 09:39:38 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-82f7bec24fdso367627b3a.2
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 02:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776418778; x=1777023578; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HQoZYkUR7ueFrS3ztDg/84oKaI7qkoYLCgggHgAvV4A=;
 b=DZrlh2TDiRHN7nRMyZ6Fvn7xUm+AtNma/s+uXiZ0WJLi0LBscMj8iqhrTxe1waA+Un
 oOxLeLuTXD2c1XGYig22QNjaEFuqaHiEviqX+MOgqclqGtfaU10+GG8QQ0qkCY17MSlz
 TW/e77691W5DB7eHiXBzpwBrJlFohuMd1SBEBO3sY98B8fgPnqw5YOpLAoCSy5dO/Kcp
 /akJbpzgxVxeSg2ULlPWMZ2SOfNnNZ/zWhEdiAsNyiH9mynmm67KsjFVF0l73fJ7WTKF
 td2+E65Gjmhx6m5PvzTA9tb4WqH+eLrF2ECUU8m8NWBzvuX0auyGAKJIM/XDopNWdB0u
 Xu+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776418778; x=1777023578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HQoZYkUR7ueFrS3ztDg/84oKaI7qkoYLCgggHgAvV4A=;
 b=AQLOyA2CI8pvSZNNIsKCyR+6JT6narOFEfp+Waxeb/B+gmOqDhFtmGI+pHYoB7dnJ7
 crrSQLF6rMMdcOE4Jp7lHCAic3RUMm5csPSFNB9bMxUwvkVBDRbdLasli+iRyWLb5nMI
 RfGKuhTEEBM7Xi8P4NNWSJJJ78Mg6fnFZu5lJu/gZtTLQnOXV9BxIQwR6/imnelBXrT2
 adfF7/OE8/4cdMFpu06uMqD0tGgk3H9qh3M4j0p3tSyZ8b6b1/lenapFQD3PNoRhgNim
 q0E7AzYRxbgeDfigT1bi80VmsUizcHzWd40JkGuD56ISl1OVNBKZdW9KP+RJ3T+k3wSU
 ehWA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/qUKzETpyJ30mDGkCROy6XvBZyoVqNlSkJnMXr5meIW7qViJ37f161ggOhEEgVzjJ9bGTIqK0=@lists.denx.de
X-Gm-Message-State: AOJu0Yy8NWiwDTgyROCMn2+tWeHpSnjMX+FJtRFSMEtrnXT6KHIYjtO9
 +9jsXr1WIFjtpETBDXnnUKSHPDyqD/s4vAEPcRGWRW/qbu+skNdZfy011+CG3DzGsuJ64nsuepu
 HfokAaf+nbfcfmI15oVmYjU7x+kfm9B/lXRzI6sWBMg5FSWPzTHGss1uH
X-Gm-Gg: AeBDiets9d1CJTkwfLm11WzzOO+fdztGwYlQnJwK6k+N/3YjxOXVduTkFxJoavIP9Yk
 HyzWaXpNclA0hL+YrZWpWfuwS/ROdZs5o7pUfyx9q8dzhJ+3QcgRYPgcgDfHjn4343MwkTZ6w7W
 uvjoFUJfKj1IxpJUSzXRybWvmQMYv/vINA5yoBgTvwXv7qnH9klyDk9CU8s8Oli6LSrVeeMzjFe
 LxfrhGIHSXKJDV9p/LjpH4dwtORzbGLx9kaBfLvcLHkI1gsGdmNTKOWVyahnXlH0TrULorAXCuh
 jqjmBnm/2LY/9to5lSAZeE2fh05Z8eW7Yxd4zp4ZI/iqBoR1qSeeRWaJENq8AKOku7y3QNn7JmM
 8M/QxFFFGrjwF3Bwy+OzU8u3ayM2FprjyjGbLu9joNJn30/j/TejsCQ/tGHFhtZobALVF0Dv14V
 1nBos+degNssG8sdXePQDqdg30mUBxZgdO/iKltHLBKfsamtL5lys=
X-Received: by 2002:a05:6a00:1749:b0:82f:2d48:f906 with SMTP id
 d2e1a72fcca58-82f8c81a841mr2216136b3a.12.1776418778319; 
 Fri, 17 Apr 2026 02:39:38 -0700 (PDT)
X-Received: by 2002:a05:6a00:1749:b0:82f:2d48:f906 with SMTP id
 d2e1a72fcca58-82f8c81a841mr2216101b3a.12.1776418777866; 
 Fri, 17 Apr 2026 02:39:37 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8ebb3fa2sm1371612b3a.29.2026.04.17.02.39.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 02:39:37 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, quic_varada@quicinc.com,
 balaji.selvanathan@oss.qualcomm.com, dlechner@baylibre.com,
 aswin.murugan@oss.qualcomm.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1 1/1] configs: Rename qcs9100 defconfig to lemans defconfig
Date: Fri, 17 Apr 2026 15:09:24 +0530
Message-Id: <20260417093924.3357296-2-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417093924.3357296-1-aswin.murugan@oss.qualcomm.com>
References: <20260417093924.3357296-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=d6/FDxjE c=1 sm=1 tr=0 ts=69e1ffda cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=iclKAJSfXiXEgfrDgKkA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: MlWP-ZexI_7NygeyJ01ssu7GOOlp0YTh
X-Proofpoint-ORIG-GUID: MlWP-ZexI_7NygeyJ01ssu7GOOlp0YTh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDA5NSBTYWx0ZWRfX+rG6cg2AHXhX
 8R5yvDG4ZS4xh3UwwqNr6fg5uXyrU28uaBa3TdXJIdqqj/hZSJFQfVs6VNugpkDEhdP564QvjA2
 mcYGeHpn/nIbw6SPX0lHNKojX/Tcu1X+CDfsnTN6k2UNb/5L/oBlaTmIG1K+La16kBKS+koEoYs
 2juX1FAmuucI0GW3qyYUBx1mwjDt3BQOTBe5YEUGBIy/DrHE8SumYL46SxZiwMCGadl9f8b43rx
 KAmxpR9wzpeW9Uz0cK6rM6SpvrcwSSWdwX7UK7dDwHvyMp0PKV9pJOnyTsmKqSOSPD91EByoRJD
 bzysY8bQaljDP0DcrkyO8imkJfTd43JvfrAy7xJdMA6sptKRMTx0H4wP7T+PURhKoQbtEcXSaSv
 1keQf1p0MsB/gEhjVx3/wEcX0VLR6B+PzQ0vPLCxNJXOrRJvRa8yAO3Obg+jJav5s9mUei3648Z
 u9dKjJPNB/1sQNdQn+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_04,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170095
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

Rename qcom_qcs9100_defconfig to qcom_lemans_defconfig
and update the defconfig to select lemans-evk DTS instead
of qcs9100-ride-r3.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 configs/{qcom_qcs9100_defconfig => qcom_lemans_defconfig} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename configs/{qcom_qcs9100_defconfig => qcom_lemans_defconfig} (91%)

diff --git a/configs/qcom_qcs9100_defconfig b/configs/qcom_lemans_defconfig
similarity index 91%
rename from configs/qcom_qcs9100_defconfig
rename to configs/qcom_lemans_defconfig
index 082106157bb..ad40d5206c0 100644
--- a/configs/qcom_qcs9100_defconfig
+++ b/configs/qcom_lemans_defconfig
@@ -9,7 +9,7 @@
 CONFIG_TEXT_BASE=0xaf000000
 CONFIG_REMAKE_ELF=y
 CONFIG_FASTBOOT_BUF_ADDR=0xdb300000
-CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs9100-ride-r3"
+CONFIG_DEFAULT_DEVICE_TREE="qcom/lemans-evk"
 CONFIG_ENV_IS_IN_SCSI=y
 CONFIG_ENV_SCSI_PART_UUID="71cb9cd0-acf1-b6cb-ad91-be9572fe11a9"
 # CONFIG_ENV_IS_DEFAULT is not set
-- 
2.34.1

