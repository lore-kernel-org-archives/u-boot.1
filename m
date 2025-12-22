Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70383E6749C
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 11:52:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0C5A83E70;
	Mon, 22 Dec 2025 12:52:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FwnoMVVe";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NfeuZW1a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B133183D3C; Mon, 22 Dec 2025 12:52:15 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F59683981
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 12:52:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BM80Zb93385341
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 11:52:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=26VjCT3WGc1DMHV2BuGVaRALldWoSuxVoy+
 vXLxwXSE=; b=FwnoMVVeXdN8IW1hK/OZ4533IGStB9O64M38opJM+V0ZZ5lA8pf
 NloHTT4kYK0diSKLqgAAc56A+1L0wDJXiqST2HTcEqrOE4bwNFjKyIs00QQ7z0Nc
 9Knuw/6DJqGk9khdM+gnL/J8upUKfibAv1yl8yKCzs3h4sSpfqz5thscKf3L24H5
 CJDARmwovFkCB+0B2ZNfS6BaXhbLrKm5j/mZvJiPzjkb+X8gcScBMBgKZbHlr+If
 zX5CiCDOzLA94FEvLBGvosPBqvw2TdJSe2NvmmyxNzOnaU13BfMmhYRU1Q+JEhsj
 Lquh8+J9cbwemgmHGwbrBclhFmbYjodJybQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b5mtqmwap-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 11:52:11 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-34c5d203988so8068010a91.3
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 03:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1766404330; x=1767009130; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=26VjCT3WGc1DMHV2BuGVaRALldWoSuxVoy+vXLxwXSE=;
 b=NfeuZW1aO6ZXylXekqnFIgluXzFQqlaJUd2AyucOWz+1b8J7wk+ayMqjPO0NqV5Cqe
 v3ceWUZ50YUuOv+og46BmChUBYdzuzgKnPtsBcs5FXqXvLAUuCRlGIsVIZwgikpmUhqP
 OuJ0MJBWEjh3ka44SE7Zw/MsPhkNqUM100zoHRiP7mTNx7yDYp3MiYB7nW6DgHHp0qpr
 qsNiNKp/Kr0k+6mvw4p9DN8nfYOU/wGafB8FcWJF0cMrX0kyiBTsiiBWtmpiAn50oeVj
 tYF3AXpw1BLG54d5Z/wTUVhj/P7us4pYIz/SPMWfxWbnikZNUmuBWHMiXEV/0Z+f2t2O
 Rypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766404330; x=1767009130;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=26VjCT3WGc1DMHV2BuGVaRALldWoSuxVoy+vXLxwXSE=;
 b=CBHsdTtKPaIkOXH+XK17AN57iU+HYRyZOuN7gyGwFns8wPCQKYGOu0pAaIpmhuSVCP
 yzat9Q7NguzUi7O7zy32doYkYafSQBs4ZM2pKVgpuqgV8VyCHLE63DM1GKO+jhm1bpOv
 O7nalocJvOsuIO+FN0ll59tYBIVK51HeFQNMFRD42F9IT1rCnv6Qwt2thNZSpSoMxDHh
 mpcrM8ZlmU3BY2VqtHcrIjdw4mUf0W3UGKtGtIwBjcQbP3OxyW79+9ieNQiiCo8Iacvf
 9Yo/m/LzL8jISMJ4PqlLDocGbqUA3saEBjRbfzFb92lqnqJP3iuJDhWwax2HUF7CDHVV
 N+hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWY+Qv05d2bzM4zavEenjd6OzWMohT9ZmelClgLqqfexss28TCEutN44OPIKhXZBr7dcsS8ZY4=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6pRQxC3t9pBQOBojUa50nWg2j5hLMpzC06pwEsl8XF1RWH0qR
 rl1VlVDveBuO5gyTU11GSsrY8Vp0B7EZYac4Lq+N/tMSpx/ldQ69TbN7pQ1+XfwSOuF0lBFiLRZ
 wX5yA10hwB/KLdRMxMkws3DGvLLdhoorWEXsjtOxKuNA7kFH7ZtmIWw7f
X-Gm-Gg: AY/fxX7YN/uujPTZBTQ5ZPTGKtjzmztRj/N8snEPkjSWeok93GgcehaCB1CPih+sS/q
 OVsiWp3TGSJBlfSzJD5M+kQObuoYNpLNMRIYDlfdpcnLCRPkhsQDUaQNrc5YJwomCTEJtXOOLGU
 dSJdt7XhQlo5/pQqcbGnTdW/WAsKR6wSnr0JrhYtvTw2s0qjYZ63tnr67c6Fsxe8Upep08kT21Z
 xMEKcdsylseM6L0HkMzQWvAfSnDwg6K2u4yV4RWqEaZR9vwoiQk5MSZpaCMvyAmcgW2wvfJb0PQ
 QRVgm8yBDJLSyhlWMBiO4b5e6v1WBJPjiafCi7cfwELwyZoUpaZxWt09qGJviBzXZBd9UbuiKGq
 NQakJYvnqqg7/cL19/cTIBSQSavxlkcyPoh5Uecu1RLRAFuK37+9PV8XOk8N6rr8Hk9R9Ckv19b
 rLIUaMyw3wP/gn3+CwnwjSDcYpGOln
X-Received: by 2002:a17:902:d2d2:b0:294:f310:5218 with SMTP id
 d9443c01a7336-2a2f1f904a0mr120472315ad.0.1766404330562; 
 Mon, 22 Dec 2025 03:52:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcDuZJp7RGXwOHxWKuKpdKMBWV8ajdRCN0uDRyLYEQ3MAHE74SHoTWWVmwSc9UnihPGR7Jmg==
X-Received: by 2002:a17:902:d2d2:b0:294:f310:5218 with SMTP id
 d9443c01a7336-2a2f1f904a0mr120472155ad.0.1766404330097; 
 Mon, 22 Dec 2025 03:52:10 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3d5d20dsm96656055ad.67.2025.12.22.03.52.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 03:52:09 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 christopher.obbard@linaro.org, quic_varada@quicinc.com, me@samcday.com,
 marek.vasut+renesas@mailbox.org, alexeymin@postmarketos.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Subject: [PATCH v1 0/2] pinctrl: qcom: Make pinctrl drivers default y
Date: Mon, 22 Dec 2025 17:21:42 +0530
Message-Id: <20251222115144.2146964-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: mEae4Gl22h_l3s7IYzs0FY1CDYHSi6oL
X-Authority-Analysis: v=2.4 cv=dPWrWeZb c=1 sm=1 tr=0 ts=694930eb cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=GaNeNDsxHfRChOGteXcA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: mEae4Gl22h_l3s7IYzs0FY1CDYHSi6oL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDEwNiBTYWx0ZWRfX721QkD3jwqiz
 9NP1ACbwLSqhpYam2MKxTC/kE3/f/+y7dK8V3Oki3O23hKso4n3NcWgmJriNliwuKwHtLEfFYLj
 kOdWNyX/UP6kGDVfSauNESi3nuE8sLlMP+z7yxa3ZqKsdYfca7uwXpCiWNyvFwtfZAOARh6cr37
 UJObQNSuUTg/Sxl2GrDuZ5pqWuLO3IR28hVjmaDgHsnR6B5ij9q7ZaPyM991grSH81rEI5WAtGc
 oj7WNK0JiJJX/rWh8bIJp5w5R84jV5tL9lzsv9lRtAIzgrEiOkuGS2DOKovykhwjjVkOOle6tT+
 OdXz8+vzHrVA+JZyPhSXy1buuQK1/p4vJvdNeyqfQQQr7Nj4thaLMJg1DM4qJgaLbtpSYySia8f
 lBzgF7vpIfRGsNoNUhphU4PpDLcDcKmWUbQaxWKYBiiCrvw5RMa1j3QvjysHq9m1fT3y/7Vi31G
 CadBE7jl+bPPJivWaCw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512220106
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

This is a follow-up patch series to address review feedback on the
QCS615 pinctrl driver addition:
https://lore.kernel.org/u-boot/20251112164758.1560041-1-aswin.murugan@oss.qualcomm.com/

During review, it was suggested that since all Qualcomm pinctrl
drivers are already within a menu conditional on ARCH_SNAPDRAGON ||
ARCH_IPQ40XX, they should be made default y based on the appropriate
architecture rather than requiring manual enablement in defconfig
files.

This series implements that suggestion by:
1. Adding 'default y if ARCH_SNAPDRAGON' to all Snapdragon pinctrl
   drivers and 'default y if ARCH_IPQ40XX' to all IPQ pinctrl
   drivers in the Kconfig
2. Removing the now-redundant explicit pinctrl driver selections
   from qcom_defconfig

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>

Aswin Murugan (2):
  pinctrl: qcom: Make pinctrl drivers default y based on architecture
  configs: qcom_defconfig: Remove redundant pinctrl driver selections

 configs/qcom_defconfig       | 18 ------------------
 drivers/pinctrl/qcom/Kconfig | 21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 18 deletions(-)

-- 
2.34.1

