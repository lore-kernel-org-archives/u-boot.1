Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13EBBCD4F54
	for <u-boot@archiver.kernel.org>; Sun, 24 May 2026 05:03:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 137AC8484C;
	Sun, 24 May 2026 07:03:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="X/niEWjz";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zxr45V3o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E707984865; Sun, 24 May 2026 07:03:48 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5970080398
 for <u-boot@lists.denx.de>; Sun, 24 May 2026 07:03:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=gurumoorthy.santhakumar@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64O4oAVx3660493
 for <u-boot@lists.denx.de>; Sun, 24 May 2026 05:03:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=oyrLytATtwPoIkt4X+5MvMtkT8ZflOW4K8T
 cHIn9nxE=; b=X/niEWjz2XUKH+CcFZgh8Wzxvz3Tia/CN65LA5/e+pT6wfExF50
 hn6Kver8WD7/9Io/4VgNwGfM1CqPh1hKLRWj903J5tR3QF4NIpm39MBMm4dOWURE
 HkDh8zheDGlE1iaofRjEsXOO7NjDNMbawIvF/h66O6UQissor+3BOLh5hw7wrMOE
 QwcwuLXn8kOWcAqoTSQp3Cg/acvauoDeh9UBdzAkP7ANgC0ng2f0pJjYKoqS+hT6
 gP/IaqRwT8S6RL3aNgvJJ4aJbqZQfI0ado2qDwKgNcc26I57RTAbsUju8kkijZrC
 OdLh399GZ1v02dkOdJwpjLgAYpRv/a0YzzQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb1kmjuff-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sun, 24 May 2026 05:03:44 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3692f395339so8688381a91.1
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 22:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779599024; x=1780203824; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=oyrLytATtwPoIkt4X+5MvMtkT8ZflOW4K8TcHIn9nxE=;
 b=Zxr45V3oWJBFIKECJ40F3fKuc98tzjEZSZTtyNe46YFmb6sO2klTjKUeP8S3UPqFt7
 GCdqTrb1Ebd4FQQSHV96eDIMPCb1ypQpP6T9pzZhZhbfpDhc4BrFI9xiomvESWLMqHqr
 y9RlWwGngoxHjTiaMmSdu1T2s4e6qA8Xov4GIbHybaRhrlWJJmv9qnFDvNpplGnIw8JM
 TCfxDt2TTiMdMj3xlT4WWw05BrYPNohaAtbGOB3awg9W4gJvq8FXANUK+jBp0dHUDU0T
 pz+atBc+oEm/j3Z06wpGdYWGVYgF0BchQY+Ak7/iP44bbHWagJ5dtkiFmB+V7kuMz/E4
 13oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779599024; x=1780203824;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oyrLytATtwPoIkt4X+5MvMtkT8ZflOW4K8TcHIn9nxE=;
 b=bc+mkMa5d033b2BuXs5b9HKOA2Hh5YWUVlkCjPCJa5rA51w/6hLAKvzQkJ+ns47cVy
 cROWw99vwePgBcuSAGNd3GiNqpmHM4kfGqz7Y5DXM4WN+9jwoqJ9MxF9qgnTf61WpFNU
 6Nn7285RXDxhw7GbKAiDRsEoJXI6d9BDcyx9MRZBhm31bn2oBfwkjMFJBBrK9AHcOM/l
 pgOHOh+2RseQtzWS1tZ7qi7K5/WErfrteOWzjwdKsNgyPXdv+bfGJDxOcEsyJy4MhEua
 ylGNqx/3Z7EJP2RBZxe/hgqmzmrip/9hVy8BgYMlpa7L9YDfjJRDADW17s9ExY6ayoHk
 LY+w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Yi8YvJs4d639c44mE9Lxi3/FmfjylDvuoEI6zZnjlTNsBZM3VL88eu+26YcE9MfAxkYjRW8Y=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6h994LaJU/GqHG0HG9xXn581kdZqV6Hi3HgPqobNQ8vPIZlEo
 v89+kvBKVsQCzSx6oPEmRQfS9Yjf/SFrXNK7+U+0hmkZS4F7SWDD7lCYf9N/exbqpoI4UtR5M9B
 DHmFSJKdOMqe2p64+KsVqTCrBn1/RXEFyu0A9qZXI08abObVkVOwl5gxV
X-Gm-Gg: Acq92OFup5my5YNJU/TiSWYyzE5ny6eoJ2pn0hWLR25x2k90cNvscRHxIvRxcycX4kW
 bj7SnHLo7v4yJWfVcsGzYUCv72H8HLnkQuAQ9whJIuVP/RDvTvlF7srY0yXR05l3S+gePH/S7bT
 2RKbU0qTgcJGf1a7ov44cNYhX/Uv0auwuyDPRVSakv401B3V5trYCMBiyMFhJ3y+DzOK4G2r+OU
 MYMKGGjXdrYSIdPSX9FHfkSg4TEHgiTejEBCwYnUnhYKQeCi3WzHjemZZP+ZfYf2wAGmIYyYOQy
 m/64svC6wC0Os2osXuujOMvzfBmxhXvpSYqaNthBPu3kmt1DrgrSxqcKikPJKN6BL2ub/AyqKDn
 M8Gc8ITGZF8XKJIy+UMmP14+Y76Ujsds32kvDMGoPjqThRCsiBErWvM47lDAPLUHY65eFT/msif
 hnYfotWfCGJYcCKZlKQsGLLmyQ/qj8oF9tVWL2P2CtBe9jho7qPjVAeEHfgbcybAqAPw==
X-Received: by 2002:a17:90b:5343:b0:368:83e6:ca95 with SMTP id
 98e67ed59e1d1-36a671e98dcmr8233482a91.0.1779599023765; 
 Sat, 23 May 2026 22:03:43 -0700 (PDT)
X-Received: by 2002:a17:90b:5343:b0:368:83e6:ca95 with SMTP id
 98e67ed59e1d1-36a671e98dcmr8233451a91.0.1779599023259; 
 Sat, 23 May 2026 22:03:43 -0700 (PDT)
Received: from hu-gsanthak-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a67759969sm2680341a91.1.2026.05.23.22.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 22:03:42 -0700 (PDT)
From: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
X-Google-Original-From: Gurumoorthy Santhakumar
 <gurumoorthy.snthakumar@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 gurumoorthy.snthakumar@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: [PATCH v1] misc: qcom-geni: add DM_FLAG_PRE_RELOC to geni-se-qup
 driver
Date: Sun, 24 May 2026 10:33:28 +0530
Message-Id: <20260524050328.414639-1-gurumoorthy.snthakumar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDA0NyBTYWx0ZWRfXyBQNTR7i+pLp
 jloLcM1M8vINSWTIzcDZ7FHsJ32Fg37sMrHItwXnlte6FuNmc9S3x/b50+BlJMiZJDlltb1VqPN
 XTsApi7zyzhfXjOjXpzfNdYly2L9btZClxWHwixhrHx0KO4rc1rOkZSp7zS81YdHi4gFxSgsVvp
 QYVZzCBDCAUlf1Q86ZX1t2142ld8uGECWRA7+TihDZlC+auNU3iKczq9pw+CIRTkiKF98/v9yd2
 G8szaND8bhprdAJ4+gzA/r6kT9UUTn8FK8iwX163dvC9ukzHznH6Y7ZaBiM40R2DS+hUpIsRlj0
 vCAdOd3nqRP/keDXXNI98dN2BaIulBnL4RWwNFjvJm7LZEJ2ck3OI54cHVXchTYSzLmui7UKgww
 U/VYkyngAS739qJ+qQFanoC7ChtmkwaTN4pvHtXjuilx/4xoFS3cbBbY78X57v5VwBPjDido3vs
 tVF+hZENxMvXYnMKz+A==
X-Proofpoint-ORIG-GUID: n7i4QbM0UU4Kl2SCjP-fHz3vClOsRSod
X-Authority-Analysis: v=2.4 cv=cN3QdFeN c=1 sm=1 tr=0 ts=6a1286b0 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=FO6vfd2--i3Di8_6MhIA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: n7i4QbM0UU4Kl2SCjP-fHz3vClOsRSod
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605240047
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

The GENI SE QUP wrapper driver (geni-se-qup) needs to be bound during
pre-relocation to allow its child devices (such as the debug UART) to
be discovered and probed before relocation.

Without DM_FLAG_PRE_RELOC, the qupv3 device is skipped during the
pre-relocation DM scan, which prevents early serial devices from
being bound. This causes serial_find_console_or_panic() to fail with
"No serial driver found" during serial_init().

Add DM_FLAG_PRE_RELOC to the geni_se_qup driver so that the GENI SE
QUP wrapper and its children are bound during pre-relocation, enabling
the serial console to be initialized correctly.

Signed-off-by: Gurumoorthy Santhakumar <gurumoorthy.snthakumar@oss.qualcomm.com>
---
 drivers/misc/qcom_geni.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/qcom_geni.c b/drivers/misc/qcom_geni.c
index a62ae6a2478..cbad7bd3bd2 100644
--- a/drivers/misc/qcom_geni.c
+++ b/drivers/misc/qcom_geni.c
@@ -576,5 +576,5 @@ U_BOOT_DRIVER(geni_se_qup) = {
 	.of_match = geni_ids,
 	.of_to_plat = geni_se_of_to_plat,
 	.plat_auto = sizeof(struct geni_se_plat),
-	.flags = DM_FLAG_DEFAULT_PD_CTRL_OFF,
+	.flags = DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
 };
-- 
2.34.1

