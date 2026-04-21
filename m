Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A2CF8FA6F
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 13:00:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 612F583E36;
	Tue, 21 Apr 2026 15:00:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bOeX281r";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NF2Mx3jh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F07FB83E76; Tue, 21 Apr 2026 15:00:23 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54BF683BC8
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 15:00:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63L6eTpr3574225
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 13:00:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=D31wzSf2cMXbkwgcSAgk09
 9doGU3xjVWxQJYR6g19Gc=; b=bOeX281rE7ZTN1gH0d1J/pit2JmT0HU7tYpA0W
 B74Ia9WJnhdbM4J2DEsJjSRwW3pd7koHini5Ibn9eoX80Z198kgYB07kwchj0Yj4
 pJsAgC0wwiCeELgL9ZtVfcwOxh71lePXc59SSOjg4/2ntRqdm9kxPcsLkrLmGFyQ
 +Ek+SGugHOowuIrrMuF2wphtRXwfkFlI1UdGsyPaF8AMHgKMeHJ84En0MJx/RD3/
 FqiEOF+QUhJNCciCon2/30qDRBM7jIw/XKOXw0vcXiLCb/NcO8MpZUbfzjvdW0UU
 +qylxvn/XJ5H87gDaoa6WPo9oKPsNyax0h+YdQF3JvAGz0Vg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dp465hb3x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 13:00:18 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-35d99c2908cso4121813a91.0
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 06:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776776418; x=1777381218; darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=D31wzSf2cMXbkwgcSAgk099doGU3xjVWxQJYR6g19Gc=;
 b=NF2Mx3jhMiStGp5i/adzmfrfAb73Nn4cpTGlPu2DEEcVXR5m235t4VvyLDPcZYWZkE
 44tmOK+Kv0zUSzMff0DEYlJayiyrmztkJOJmRxHxOjZ4JtLJKndL9XhbNczkVnlW5GKR
 qPUccAtJQLbKYi5JfsuxZxRWawsmiKPyEI8Zs+o7bA4vDTPbo5AXgWV3btG7SBK46wuf
 BNVTV80QRRxMbfmsGdU73QdWMJsZSCehn8LAWPcNgucnIvpwMNjjZAOq61RmcdhFZla5
 pL2hVS0OIFE2u9hsM/OWgi18hebtBySz8SoWTsjK9aKJCT+DdEVEdaX5Wm0L4eq3gnZ4
 5nkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776776418; x=1777381218;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D31wzSf2cMXbkwgcSAgk099doGU3xjVWxQJYR6g19Gc=;
 b=VJ/k1fpCS5aC895aCyOQf2qfwXDMhkKdJJ6L1OxBz+Mh69kuviOy+lXxs1HMgcR57f
 EfVJkrOfnKQV58DR/qmua/vSrciHfW2lwkt/g9L3kXTkxUyTqR+NrPBSaKQeoFbJGKYC
 mhKcyk+jiyeYHspYv6Yvm4ESgURJnSsvAKao1OgEPoaJkiB3j5YX/OCwy0/+EinuRqiD
 QTJz59pWD7gZA2QVpx8GNrgMs6a3pQ7s7VjYP0kNIJaO3ttO3qtU/C5VwEDe+nwBIVpU
 6l0iAaKMIpkGmzi+AJkvGMRXA+R0zLbx6fuZWWJnnt2/najsUb1pdA1fyvEeLVeU2Q8y
 KzZw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ugNqa9W6bsdQslj01wiUSZbWJseeRUzu00xJ5eBzX+b7IYUACPF2izg6rA22iC1a+Pe1Q83o=@lists.denx.de
X-Gm-Message-State: AOJu0YzqkbyvrNw9cpN7ABEfPQbxTsfu4gex57RgAwVnnye4CDNNGzGo
 QrRlj4/nCQv8n8tnFK67VoLkhN51zn1Y3kWO7VcRWPN4xDghJzCIJL67D/2xWKghq2E7bolMuqx
 /3O/y1Z8kL7TNvGH/SH9rLO+hMk0hrWe0/32aGTo1ktDrXuEhnrnxHi7H
X-Gm-Gg: AeBDietR45oRbJfEMqq2IOtID0KN4uqJ1C32mvft5bbSVUAg7VNNMf1vgo3/NOyerIi
 byAxZ9pMbrCuZKC21KKuTUilgxnH/5O8THHCmN7OtSafqAhSsGlaaKMef3ljgB5tdDyCdtadFOC
 2AvlvZES6xaS3xUFSZ/Sm2g+CIPdm+hgpBEP7vxSLiEH51wpIc6vOM8YILbfojXsQltjkDQHkV8
 i6/Ugt/S8x2wgdQwOsLHQTSyj+gp3c26seieoG+20QizWxtFi7D3l0U21XuxscCJs64OW7mravW
 zD4ais5HngrytZovewtwoebNRJ9fI1r72J2sp65CZkLw86ZN+v1x5C+10HjYOG5jYRafKV1QmXl
 kr81A8J2CE9+y7fcgNBYgoy5pYX5B37kQj0yIvoZZ3dZ5gstnvNFAFVT+tQlfhGFYYIpxQfiIS7
 sqdXRa0wvx+dVleD6k9ANXzfD++wEI5tYN8ypZdt7lSz7zaBIUGudy3UKdYI/e
X-Received: by 2002:a17:90a:164f:b0:362:bfd6:a875 with SMTP id
 98e67ed59e1d1-362bfd6a93fmr685122a91.1.1776776417388; 
 Tue, 21 Apr 2026 06:00:17 -0700 (PDT)
X-Received: by 2002:a17:90a:164f:b0:362:bfd6:a875 with SMTP id
 98e67ed59e1d1-362bfd6a93fmr685052a91.1.1776776416390; 
 Tue, 21 Apr 2026 06:00:16 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cb92sm130117335ad.50.2026.04.21.06.00.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 06:00:16 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: [PATCH v2 0/3] Enable eMMC and SD card support for QCS615
Date: Tue, 21 Apr 2026 18:30:07 +0530
Message-Id: <20260421-emmc-v2-0-0ebd3322b676@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANd052kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIzMDEyND3dTc3GRdk2SDRCMLM3Nzy6RUJaDSgqLUtMwKsDHRsbW1AKziXsd
 WAAAA
X-Change-ID: 20260421-emmc-4c0a286779be
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Sajna <sajattack@postmarketos.org>,
 Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776776410; l=1625;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=TO4mj2gzX+NN/yULqjstFfUtJ3tm8IfzHLcqpGmAQ2Q=;
 b=rj5HpriXRoysjFIdPubQp+PEFk3EAm3TYkTpFAmXTVEIKXeA0OLUAu2QA7sNGCF9NQoCBJC81
 cSDs6SCVUQWB2Y/vI6InqHZGHqUdZMvVYHNTy7RLzmiTQRkZHX8XWAj
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDEyOSBTYWx0ZWRfX+4IbgCM3MGVA
 37FF8kxFc1+kLV0cpo8W427CGIPKNBhissSUybMJjsXy5YZMeCP5qHv+PvsiQn33/gIapQudwml
 bIZ90Yjj9l53lSLOGzwWAu8YnlvbJCTr58ZDpp3x8HTEplk1Bih3DJXMTWGSuzyNvmsbprRGSU1
 MiWQY+NavxpVBxtIcgHRJ3Rg29OtJuqIXojLwn41UVUloou8zxF+G6tPi1FaGOSf0hCNwjri4qm
 wxMLRs+fO0vNQB3UJ8FCLFtcf8d9cnen61VwlYM6d6zM35izOEKT+DYmSB5UbzImx4NtnGS2WYV
 QM0vfwSw+r7wMunEuiriUXAvvJ1MiucJmiEuc8xSlRCUUyjpHCeRC6yDKQ44wvI5zu7QmKdtH/R
 XIPEZRALF2NycU7DwUyfzWqqqDttjZ0ttvGcPR84VixBX3aqs0bEclgmgLMCOIZ9LqibNsj26Aw
 z2mcReJhtri+uRrWeCA==
X-Proofpoint-ORIG-GUID: mNzIz4hOypHLlgkOOBhAdCwaCcdb7Cye
X-Authority-Analysis: v=2.4 cv=YOSvDxGx c=1 sm=1 tr=0 ts=69e774e2 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=9gW7mo8bt9U-28u8YEYA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: mNzIz4hOypHLlgkOOBhAdCwaCcdb7Cye
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_02,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015
 spamscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210129
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

This patch series enables eMMC and SD card support on the Qualcomm
QCS615 platform by adding the necessary clock support, fixing device
type detection for proper EFI boot handling, and addressing controller
timeout issues.

Patch 1 adds clock support for SDCC1 (eMMC) and SDCC2 (SD card) controllers

Patch 2 fixes the block device removable flag to correctly distinguish
between eMMC (non-removable) and SD cards (removable).

Patch 3 limits the maximum MMC transfer size to prevent controller
timeouts that occur with very large block operations

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Moved removable flag update from generic mmc-uclass.c to platform-
  specific msm_sdhci.c driver.
- Set CONFIG_SYS_MMC_MAX_BLK_COUNT to deal with controller timeout.
- Link to v1: https://lore.kernel.org/u-boot/20260324-emmc_sd-v1-0-883a45538b6e@oss.qualcomm.com/

---
Balaji Selvanathan (3):
      clk: qcom: qcs615: Add SDCC1 and SDCC2 clock support
      drivers: mmc: uclass: Set removable flag based on device tree property
      configs: qcom_defconfig: Limit MMC transfer size to prevent controller timeout

 configs/qcom_defconfig          |  1 +
 drivers/clk/qcom/clock-qcom.h   |  2 ++
 drivers/clk/qcom/clock-qcs615.c | 46 ++++++++++++++++++++++++++++++++++++++++-
 drivers/mmc/msm_sdhci.c         |  7 +++++++
 4 files changed, 55 insertions(+), 1 deletion(-)
---
base-commit: e3405917a1806971d9e72a94186b299f05581e1a
change-id: 20260421-emmc-4c0a286779be

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

