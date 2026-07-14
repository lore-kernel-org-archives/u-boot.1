Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C40BC43458
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 09:52:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93D2E84CE1;
	Tue, 14 Jul 2026 11:52:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="heNww70j";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QJR2bYgn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0ACA384CDF; Tue, 14 Jul 2026 11:52:53 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CBE884C5E
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 11:52:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66E6SPtu3718299
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 09:52:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=onDNbpqC7sopxqbB19QsbK
 mPekHaVRlHi4fXduAE4cA=; b=heNww70j7EsZXKLQDw7Om6zrl96Wo7e2QYZAHU
 Q574guy7VHrpv6fXWUhhBAJpstAd7yKgHq4bjWx2qxhLnREM9irfAz84gjkGu3He
 2Q9oxLNYF7BrEpXJoMhdVTg3PGhPbg3Wtjen5j6VxNP2Wr4a4fdbw4pstHkGARgF
 2LX4FAr4fPsgFxtKLdCNLbhIe66QyS8ob0WJwMPB32p9YOEVT9I6lYkPXHDrobr7
 w5CJuzBmgPzKJEWHN+DJlbU+Arkq1kQo+Ej6Cdh5bnWPk3bMKZZBlG3AlRMsuvDh
 STpoY3UT43N9p8mT3bVi4BEtJM8ZP2hQWFPFkeZzu2N3HLKQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd7gvjc42-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 09:52:48 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c860544c077so1949147a12.3
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 02:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784022767; x=1784627567; darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=onDNbpqC7sopxqbB19QsbKmPekHaVRlHi4fXduAE4cA=;
 b=QJR2bYgn0WDg1rZa3XbfBXtgmxeQueZdqG0c5CIoQN7eIfeX9AC0lEeo105ei+eIBP
 U6+iC/NiIKFY5RfNLJZRV/hpP/RsE/x6UsIkUzRsI41/ZLVgg3kqD0EzrFdfBCMhr6pO
 Ggd/Qve4AT2a5ZvS9CHvA/mcfjYefE1OLYG9YngfK7hpus9NWIKXbkEWb/MCG0KYAUQ2
 RqfnXdwKC0A2zHwk+a8cLhLfSkTXAmi53KR6/IU2whpKRkejec+etCMJmuNjsVlxPT65
 BhM+UXmzZDeLyav4lSTp19LZqkztwlQjhqdZTrcspec6eEyUrcnbvIciLhkKS45NwE31
 UoxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784022767; x=1784627567;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=onDNbpqC7sopxqbB19QsbKmPekHaVRlHi4fXduAE4cA=;
 b=LL/HgcnZkpuD/Ftd5TugK9PfTU3504tGCLIFo0pE+Dco6bt5So4ZLTkO83zQWqqq0r
 aOpHtyACByjgQzXct4zYGpRDGBc6fQPSRnvENotNslfw+rtICy8/LxqAi7of/QdsKX7I
 /AL7QSohZ96XfcserY5JGTHtA2x93nAV7IjkAdxkFL/4VdxSvbEe29xFzSgFa/2qWU6z
 uqr81Y2RMW/xHVEDRCueqaW0NJiSzdV08ouygalhyfR7JP1z00krdKwqyN8yaqAxx2RH
 eEokY/WAfZxJqQjOILLLOo2VvU9RPX2RG/UWxR0wjQ0uEL7cQLrSn9fmyiGAQnFPUa8H
 IOHw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp2mgofyLqm89fBliDCAEmHb2EsDnACCLiPiHyR3MQ5IFs6HK6XCuwosCiiSaOpKjY5Zgj6ZoA=@lists.denx.de
X-Gm-Message-State: AOJu0YziWf61gMrtjPtFa2KTMWW0w4EF4h7nM7r3FXa3Ol0FJiTzE3JF
 0boWd6L9k+xD7un0XO++yWwgzPEZZu/Tu8QHIEXhfT6ZlGT1O4XtuY3BdVNxHvR9jUQSp7EKwgP
 QgSD1OnrfmziyHd9H0M0fApGs+1BQq9GsaL7fvwhDTZYtuIE6/jLc2an5
X-Gm-Gg: AfdE7ckfyO5ef7IMdHqwBuVqxU9/chqIve6Uokrmz7sVl/hFKc0DSbBV289+fsoMMZd
 ZBARtzJoO4hABvoRaSqr24JzhUi6iyHj1tlwHIVxiL0a44Iqx8I20UsGaBOgs8EQjRmcY/RkyYg
 y1z2RkXu1G0ugn802qULFe0MS1zKMm0rP1nEoZ6Ssq7O9byIFWhhU6oZlXLZXbYj7T9uibIL5dI
 LEljxYH2PVrSJ7cxuIDI6UhXDO3niUGDr4HfV4L/MSDMgbnsK8y1UACrCQ8zgtWr25E8zZIVqAk
 m69StTZciNBcsT5l9FeEKds0CUvWd3RDAIQPVESKpvmJ4WaKHmhw4jpA5c3cW4f7N1UpJ3VQ51W
 qGK9Rdnv+wZkkWZsggHdaVO72jkrBZZzD7rFYUIz7KE4PBrPPCK8b4t1DKnLKJC3kP/i/afsuVJ
 XGGyPaQHl83CT+CdE9VcU+82jUMBw0NbaD26hBdDFd
X-Received: by 2002:a05:6a21:389:b0:3bf:95f4:dad7 with SMTP id
 adf61e73a8af0-3c11077486dmr13565185637.41.1784022767483; 
 Tue, 14 Jul 2026 02:52:47 -0700 (PDT)
X-Received: by 2002:a05:6a21:389:b0:3bf:95f4:dad7 with SMTP id
 adf61e73a8af0-3c11077486dmr13565152637.41.1784022767051; 
 Tue, 14 Jul 2026 02:52:47 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b9081d5c3sm28180537c88.9.2026.07.14.02.52.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 02:52:46 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Subject: [PATCH 0/3] tools: qcom: mkmbn: Updates to support ipq5210
Date: Tue, 14 Jul 2026 15:22:37 +0530
Message-Id: <20260714-ipq5210-v1-0-0b98251aabbd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOUGVmoC/yXMywrDIBSE4VeRs66gh2hoXqVkYc3YnkVumpZCy
 LtHmuU3DP9OBVlQqFM7ZXylyDxV2Jui+A7TC1qGamLD3rS20bKsjq3RjmGH4EK6p0j1vWQk+f1
 Lj/5yxvqpwe0a6RkKdJzHUbZOMdh7RMdtpP44Tu0bxf2IAAAA
X-Change-ID: 20260714-ipq5210-52e1da5af9fc
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEwMiBTYWx0ZWRfX0nNRSbsK/YQ8
 6pO720SJKr9oi447pCURO9MkJGrDi2gyhepsZvewXuUZSMRyCAm1SpV2g8XABAJGeladv5qgvOQ
 wOxwT3MwO612cmngCjSajIGKD+oRtkH6Wvj4VMd5YIsst2IlxDJsrxBBRDOVm5we2p8i2VIY7Bi
 ggmTTAYLs8RpRcaWR8lnovD3lesS8yn6nlC7UlFmg7BbHFmAXRdPHT+mbwyMYPf4baRXGzdufhS
 E9XIBQWVcmN+AZSHsgAVngT6FDkyWm27lIAnfft93yZ7XbOcr96C+nOpSpHMHyt/i6IxuqYybI3
 Q0EWB80Y5Xg1YUoSFyrj+TjHB9DbGqHNrQcU3iK1tiRkmncVETSqCrW9U7djrIlaHO88f7Ul9sy
 Xhhu6+x85Xf84UX8XzQ+Cu98UA406pYNmf6/CO9k8DnT8npVH161EgbCUtlXEzQ0DCazceG2iyU
 dVC8En8buMlAvRGHUgw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEwMiBTYWx0ZWRfX5aye3wmKXkHn
 Ip37/JGseSFZx+aCIc2grRgBPzDqQZlxgvo2/dSitfuk14ExuScxQIp83YvzoZ/MD41svmwhuKT
 uhgMtcKBlmftQZMzjrT/rlyBFCa2Hqw=
X-Proofpoint-GUID: p3UOm47QQcFShLOrERchyvUnc8SOvDut
X-Proofpoint-ORIG-GUID: p3UOm47QQcFShLOrERchyvUnc8SOvDut
X-Authority-Analysis: v=2.4 cv=NYjWEWD4 c=1 sm=1 tr=0 ts=6a5606f0 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=SaGplcZz0KPe9PN_EewA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140102
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

As part of adding Qualcomm ipq5210 SoC U-Boot SPL & U-Boot proper support,
the mkmbn script has to be upgraded to create images that can be used
in the ipq5210 SoC.

These changes are to address the feedback in the 'Qualcomm IPQ5210 SoC
bringup' series [1] to use mkbn.

1 - https://lore.kernel.org/u-boot/78ff6a8d-5c63-4bc2-bf1e-6b71b8f9c6cf@linaro.org/

While at it, fix the MBN version number for ipq5424.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
Varadarajan Narayanan (3):
      tools: qcom: mkmbn: Fix ipq5424 MBN version
      tools: qcom: mkmbn: Add support for ipq5210
      tools: qcom: mkmbn: Add support to create multi-elf

 tools/qcom/mkmbn/mkmbn.py | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)
---
base-commit: 2e266ec527c20dabd53dc1b19950ce5b77cf2f24
change-id: 20260714-ipq5210-52e1da5af9fc

Best regards,
-- 
Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

