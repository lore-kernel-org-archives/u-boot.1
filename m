Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91292CD4F26
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 11:11:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C799F849E9;
	Fri, 19 Jun 2026 13:11:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ablVK7kW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P/y3MVDv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CB78849EB; Fri, 19 Jun 2026 13:11:25 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBC63847C3
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 13:11:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65J7PrgR007028
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 11:11:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2cOPwR0pbGJuDRKRkd72lMuUadpeJk7hMk7AhSOTWU0=; b=ablVK7kWTNjzbmjx
 /gUCyGaABxuT+oARjwd8/FnrvoTTwFo2Js0UuVeoPaeYdaYjIcDd2V0lho02wmsN
 4FhYiwyDbjLHcIgnwKgyjn79UnoUJEBmlAxBIPrMCP9CScvXfSX+wfESHi49Wfd0
 vPZVAfI6BePogTAwLFnm0nZzKIBQLapv1rGCrZ6h3SpratmBjWkbqCLJsZBk5P1j
 Xyk2GnbhOoUqE/ofHTuQXsV6aTlY3zj/uvzZkCild9AezMjGuoFZhqhZgNCnqOW4
 CYvzH1n/Bi44c6b+OQtP8khZAERkPkJzjBOJj3eUhaahrtzilkh8OR741XTuEAe1
 Nnj9Yw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evm20kpe1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 11:11:21 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-37ca4367860so2385087a91.1
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 04:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781867480; x=1782472280; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2cOPwR0pbGJuDRKRkd72lMuUadpeJk7hMk7AhSOTWU0=;
 b=P/y3MVDvTej2VBREYscI5X6HtN9Zie1Imsm3Uw47UJy3YodMsGx5jKbMZtn1UHyjq6
 KrRLRFeoHIMcMvMcwwGd802tvQts2TQlonwIQ4CYLAUMg9NOI83AeGjI6HNYY9E/h8rE
 RraFIVl510QyqqFt6jyg5gvSOxRXh/mfZ8YfVzswRAYJrhMOyb0TREkGX5zeq00aiwNr
 RmAoD7NVimLveAWd84LnS7IvfkEHfNciER/VjuK9Gte1UgLcVi7SO/FkdJwm3pxIlGKW
 wqDNf2xdSvbeJXXJ1Ql6V6P1ec5GeFtnh80rENUEQURh4SRopvm1UcSPSoqLrDpDNn2S
 /Lug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781867480; x=1782472280;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2cOPwR0pbGJuDRKRkd72lMuUadpeJk7hMk7AhSOTWU0=;
 b=XdTghBlkMCzgwW86QIREv5nx6Jn4QnPCIyVUyVKdj3ld6JrHYOIWwmvEj3mZ+GQbyw
 Pf+YAihb/9hK2DgwYOFUjSPkzoUs0c06l356TtICWDnOx8y84p79Ph1jtq+QvxByzP9W
 FcY0Bc3CLkvjIsBNeqTY7myhInC0zz0gnmqFioilNlQDlTfzacHyrbCveTd9nzjaXrz6
 3KpChtKpWZ4LTrLZXWgPzkQZa90EFnjBFr6qfeBeW84zU4UAiltzPhjT2tYpIPYuPxF/
 Kbr70XSj9F6zzqtDf+O9nVGTD9P3hGyRCnRR7MX9v3Kdg0puIYHCs8RZhmPNpZ2ns4y9
 TQ/w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/PDWtzcPenkGqb6rqPH2mUcxjv+kfWM84tYokqLcGFVGV6bue6TRER+5WZsguylxVW0l53vXM=@lists.denx.de
X-Gm-Message-State: AOJu0Yy1Cmud6lYU0dV8xv5GaB8tvoWWlAzm6vVo/ou1iFNEHjiJefGk
 FA9JhmMr95Ugz24Nq4DpUUINVGFk1hq4fVfdopyuyoFZK8jLvviqcRKZbKLaMIFhTMX0XSOVoOY
 kr1gTVlzCnxs/tptvKip4Djns6at7FmicAu+YIRPhIToKX8lD3rSIDIB8E3d4Wt8D
X-Gm-Gg: AfdE7cmCFC01kOwTMYj02EeMsvQadD56ZznFZIdQfXfKO6vxSDA5Mta0njRvurmDb6k
 MxS+k0Lnz/2RWmqxL0VX3HYVI3DqpIOfb4jmwXL0QQa3gUpIWyD9TEx3hJzGPSqIRzLo5eOB1Fd
 OafUdmKLWl6w0aRNgve0J+k00Tfl9Y9nMf8XRu02Sb3jLQsU+wtTdM0FhC+exVMG9kA2MxJU7if
 DonCCnustXiSwe88wZENHJcV5durEgBzIYQslxVrQUESvZYcNQ1KjAYns9m4oTBbr2nbRaUGk6B
 TSP4ORBGeGt0MOIFmFAgQBqrrnJW4enjNWaQFAbwZ/hU6eunqCEUJf4YXuZua8gm6HNye4iLoMo
 dMfiatN8q5NZHEV/o1hI0mzShYVF/lowoLxHYjlKzrHp2Zs3tehxNzzJKgPxs934ELs66jhlvxh
 UKGw2Kxf70HTUQH7vLmkRBql5+Zjfg8ajdio6a7QU=
X-Received: by 2002:a17:902:e5c8:b0:2bd:5ae4:26d1 with SMTP id
 d9443c01a7336-2c7195c4c5amr25940385ad.17.1781867480283; 
 Fri, 19 Jun 2026 04:11:20 -0700 (PDT)
X-Received: by 2002:a17:902:e5c8:b0:2bd:5ae4:26d1 with SMTP id
 d9443c01a7336-2c7195c4c5amr25939815ad.17.1781867479798; 
 Fri, 19 Jun 2026 04:11:19 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c72089a6b2sm22619585ad.2.2026.06.19.04.11.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 04:11:19 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Fri, 19 Jun 2026 16:40:29 +0530
Subject: [PATCH v4 6/8] arch: arm: dts: remove Lemans EVK override DTS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-snagboot-v4-6-385497442db2@oss.qualcomm.com>
References: <20260619-snagboot-v4-0-385497442db2@oss.qualcomm.com>
In-Reply-To: <20260619-snagboot-v4-0-385497442db2@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, Simon Glass <sjg@chromium.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Peng Fan <peng.fan@nxp.com>, Anshul Dalal <anshuld@ti.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, George Chan <gchan9527@gmail.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781867429; l=1348;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=ZZ7AQ4MUR0PySPSUzNLuNi6j6BvZD4rpr51f6tUGcOg=;
 b=QgDqAcgC8FFYMQYto7aprSF3r9rN/DLqrmsSXJashd82Hufds0JSbo2Uz7c8wrY9fNcpulYZQ
 lDa2/epfDUiDpsQhM+VWzAyuuXY7sOWyDkSAEM37RKLzwrvkr4K2Y4u
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDEwNCBTYWx0ZWRfX5RslXNX6Fac/
 lawlz5EIEmPyS8n82X/5M5dRkCssCGXY5nNTrfRsgHxaKvogUIJchrp9b9FAs2bM2ujuVZRSP3y
 MhIu2yi9GTu+O8sLG2r7+5XqzfY0iLzMN130ERXXnbQ4NJ9EKrpevcMMuXdvxgP4IgS53DAn3Dx
 9jUBzrJ7JNTvDcLsdqpkn250wsbYW9wHl4E3MXIA47Ij/YdWdpiIhvdcMiM5swwv0yzlepwJZ0f
 /thsObak8emWDF2hvJVWjnJsqPi4VbuUDsJshPXZGSxpKIJIeCwl1+zm0tCoTadaSMBZtCQe9xa
 UCn7E1bJ3Jb2UTuFf85iGBHT1AX+EhceSeQbXGoVyVV+j7OH5LI3XDxJRE7J+hO05DTMUOXHTqV
 VK1VtRErDzy1OdD3LBrqxilCAGn/z/Bd8EGlt26pwk+nZUmPZWKNAQnZIKVZFGDAwuF42g0Q95V
 39sentN20ba3GPl7bXw==
X-Authority-Analysis: v=2.4 cv=GKw41ONK c=1 sm=1 tr=0 ts=6a3523d9 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=ZgaKLAyxbO7a4fke8goA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDEwNCBTYWx0ZWRfXxqdfb7/WehCl
 VWPfj3vlUdlW8cGx3pLqNq4Oli5ereeoelMy/k0dgQ935aqjIVURvv0oGEqhMWLKgLvG/S5wZ4E
 TbkDYRz5IWcYfNreh9/36zVZxDKFilk=
X-Proofpoint-GUID: vUHdrh9BXeY8dpHvKpZAOtLKGnbDg7yu
X-Proofpoint-ORIG-GUID: vUHdrh9BXeY8dpHvKpZAOtLKGnbDg7yu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190104
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

Remove Lemans EVK override dtsi: arch/arm/dts/lemans-evk-u-boot.dtsi
provided the following SMEM modernize series is picked:
https://lore.kernel.org/u-boot/20260618-b4-modernise-smem-v3-0-472391477988@linaro.org/

Memory node is not required as we can read the memory info from SMEM.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v4:
- Newly added in v4
---
 arch/arm/dts/lemans-evk-u-boot.dtsi | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/arch/arm/dts/lemans-evk-u-boot.dtsi b/arch/arm/dts/lemans-evk-u-boot.dtsi
deleted file mode 100644
index cdd3d32f61a..00000000000
--- a/arch/arm/dts/lemans-evk-u-boot.dtsi
+++ /dev/null
@@ -1,19 +0,0 @@
-// SPDX-License-Identifier: BSD-3-Clause
-/*
- * Copyright (c) 2026, Qualcomm Innovation Center, Inc. All rights reserved.
- */
-
-/ {
-	/* Will be removed when bootloader updates later */
-	memory@80000000 {
-		device_type = "memory";
-		reg = <0x0 0x80000000 0x0 0x3ee00000>,
-		      <0x0 0xc0000000 0x0 0x0fd00000>,
-		      <0xD 0x00000000 0x2 0x54100000>,
-		      <0xA 0x80000000 0x1 0x80000000>,
-		      <0x9 0x00000000 0x1 0x80000000>,
-		      <0x1 0x00000000 0x3 0x00000000>,
-		      <0x0 0xd0000000 0x0 0x01900000>,
-		      <0x0 0xd3500000 0x0 0x2cb00000>;
-	};
-};

-- 
2.34.1

