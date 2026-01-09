Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30987D232E8
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 07:09:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C6E38414B;
	Fri,  9 Jan 2026 08:09:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ndasSujk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CtMquN2I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0337484158; Fri,  9 Jan 2026 08:09:28 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68E5C84144
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 08:09:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 608Npoma3727542
 for <u-boot@lists.denx.de>; Fri, 9 Jan 2026 07:09:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=Y2DhxwY7vyJMQlgl7S0PjE4RwxYPyN9kS/M
 gn7s0Vvo=; b=ndasSujk5jq2kcbwGDIlCH9e/rpqUVa4Q6hdlQMyXC8O21xweHc
 1OivsBZ13J5vgn3kPDd/sq6h9SMez0MMg1Rowm/I51WjhM/jGHGQyy/OeKajT/if
 Ar3IUi/em3umF+8w36z44voSkAEV86YqakOBldN1BlAHC/nvPBMkK6oJnDc968jL
 ut636nAe/WepkBSSb1UDZuelwW4DWfCp2J/T1AyTgMOTNy2GB2N/vliRxSUYWIhq
 yhUW2Mm9xkyaTiEcuD8EJX7Mcderj8wVZQesVMPmS5h0slghZw8mVvpkv8I4kv7/
 NxMIUBXU3aQhqR4GdS9q0aNABhGJ0TXrpow==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjpmkh1jg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 07:09:23 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c1d27c65670so1563884a12.1
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 23:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767942563; x=1768547363; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Y2DhxwY7vyJMQlgl7S0PjE4RwxYPyN9kS/Mgn7s0Vvo=;
 b=CtMquN2IL0qZplOVXi02xL2pX3JVbNJU3YuiT4LMrUfsj9QFE4ZlRYAHjx1uDDbdl+
 JZC/vTuuetNooadtVWA/IEtvqvTP7c3GluS0wBmo7fIbscStx81uECo9Ydzj/YmhBGyY
 8m0H4FEXjpBADExjvK74Q5b480kx0Zv7r+ptuVHh716/Sz4SszBzE7++3GSKtas4KgKP
 fm8BiSPQTvaFa4jl8pCsEUsL7mZl2jYEO7vCatjNFden/UaFCcFeWnTZ3oOmO7AY/x32
 3WPl1PNn2GXB079T1k8vWrTVjr+3r4zIADfVUCRS54IFea/YHP74hu7K4fMZz5qsrXGK
 BBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767942563; x=1768547363;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y2DhxwY7vyJMQlgl7S0PjE4RwxYPyN9kS/Mgn7s0Vvo=;
 b=apc264zrxU759oaeZLkA21a6o5e61DSz62gZKkFv0tR57OuLsac0XMfXTI38runn1a
 C5R9ZFDVesEdNT2yvW52c1BhL01G5z+Z7a+oPUA7L6O1xGA1Qx+miOpvqe+DjMEkFCsq
 LrZpAlJb/gRnjFOd2nxjuD+JCV+okq5qnwJV2wAUZDubj196l8KJoqWORi6kVKFDB21L
 bsmFzunckZ73HPfOTz9L6E4e95PMyfvuGkb7E0im41whpPaoa4sSeOsA03imkE6q90d3
 14mTGGduG3FBcz6wranavcK4qq7Ssr3iv1dR7aonyd8GUULRZFiKSMnsG8fthnXVNtm3
 a/LQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSMfaMXahImMXQExQOpcbOXTwfAUk+OGKxbM6V5Ijoh/VbfmOYDBbU8gybSz/wywJ9q7POFqc=@lists.denx.de
X-Gm-Message-State: AOJu0YyW2zOm62ArNlPlBJv5gn1/2Hew7zMZdF+lgUYKZITPtdOoiNVc
 wXuChNftMFxaACdEKkDWbvowFdcuefQ2VsmQkVBWk2CqjzMhYqmanXnXuaKCW8Od2awqpUY+E+4
 OvimvFkYEFrWzZ1g8U6IJP7niDgXTCznUFNcSD5JqeuJlBKRR3kwZT1Pl
X-Gm-Gg: AY/fxX5shMvmI9kBArfZRaeXI1wboHZQLSo6qGAtbArciHcl6yD6N0ZVIxsZRybgkX0
 R92bOELVbYzDf0/jlZzL8XFPefakFpvqtFHnBLIsG2WLo4+inykT5kf8eIDCN41PmU43h+ONF6d
 svGYEV/u9bRQ3OQOjwOQnXw6zkTu8TaTCGT9zDpODNPMvbl+igoBstsvMarxFY9WzovhqiU7His
 YxQE/0Zh5X7+pkYJAGG8HqGvnxKnjPNL670p+9sM5r/mPkh1syhAZvHfLm3rOPjlQOyjNKT3NEv
 BpIJKUxNTFX8lanB/O9QnIh336pkRk3ku0VkuaX3o0blLgRo7f6deqwKUb7OWIx518Lv+5MQ8As
 V7clIQUTvDzJvPWQzzNGW0ea/yKlvkyt98QvMnGXwKpygvqJqn4OBbTf8K2ZKn7pdhtgbjsUMco
 0ZyfF74RWy5U7w+bUDMNYV6L5D2MO3BCIbVz+Mww==
X-Received: by 2002:a05:6a20:e292:b0:342:c634:e272 with SMTP id
 adf61e73a8af0-3898ead8ff4mr8884551637.28.1767942562306; 
 Thu, 08 Jan 2026 23:09:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEl+cu67oXHncAveyjmOTxbTWgVOYUT6B4KoGmABVDC0OnRNGps57GfQLA64HnuRQfrJlPTmg==
X-Received: by 2002:a05:6a20:e292:b0:342:c634:e272 with SMTP id
 adf61e73a8af0-3898ead8ff4mr8884525637.28.1767942561787; 
 Thu, 08 Jan 2026 23:09:21 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-819bb4c85bfsm9471943b3a.30.2026.01.08.23.09.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 23:09:21 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, joe.hershberger@ni.com,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 ravi@prevas.dk, quic_varada@quicinc.com, quentin.schulz@cherry.de,
 javier.tia@linaro.org, simon.glass@canonical.com,
 marek.vasut+renesas@mailbox.org, ansuelsmth@gmail.com,
 michal.simek@amd.com, mwalle@kernel.org, jan.kiszka@siemens.com,
 javierm@redhat.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v2 0/4] Add partition type GUID support for environment
Date: Fri,  9 Jan 2026 12:39:08 +0530
Message-Id: <20260109070912.4106466-1-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YNiSCBGx c=1 sm=1 tr=0 ts=6960a9a3 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=uxajwLBANOCmf5AMRP4A:9
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: tfB0cxOHzB_Pb_uora3w8tM_JT3k4Gpl
X-Proofpoint-ORIG-GUID: tfB0cxOHzB_Pb_uora3w8tM_JT3k4Gpl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA0NyBTYWx0ZWRfX2nIP2AD4yD4k
 HI6ROcncUdUccsaqgM/cYT2bwtdbEjazJZv9np+3RKv4clMtUdsRlyFFlDrJsR59AlsVoTyCgol
 a67aEHZRq+qyu5BH7o/1HRxDsB0eloviYnIICaJ+oJz/pLvIywvxNVh5Fb8Lrf0lBxWe/LRevkA
 ahqM1MHJcw+sZ6avC8GQE2TfrtRaurnWmm1pGLKkIzYCIZPbmfo9opIKIIZHbndHBXkWGVNRCmc
 naxvUSIU1fh6sUzabUTYEJ2GfoFDzVxNDKDiW6I3XP/p+sdbiJaBPWyOW+J8VVg6r2wjjxcmxET
 E4t1FEZ1DLRJiEYxWrF+/4mGRZ3q0emBE2Td5bu65R8k+P+ljDcAnGgsYH/IUTOU2w9KUDMVGWi
 CnLKu61P0sQkDgFi77D6z6Q24ZWUVkXjjOBtNm7x1ddMSfxAd4aIikv8ZObtmHe8LG4XRRS3Fk2
 wXoSD50GybTyuAO7Zrw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 impostorscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090047
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

This series adds support for locating partitions using GPT partition
type GUID instead of unique partition UUID. This enables the saveenv
command to work with partitions identified by their type rather than
unique identifiers, providing flexibility for systems where partition
UUIDs may vary across devices but types remain constant.
---
Changes in v2:
- Compute blk_find_max_devnum(UCLASS_SCSI) only once in scsi_get_blk_by_type_guid()
- Introduce a Kconfig choice config to select between UUID-based
and type GUID-based partition lookup methods.
- Enable above new config in qcom_qcs615_defconfig and qcm6490_defconfig
- Link to v1: https://lore.kernel.org/u-boot/20260108064947.3237361-1-balaji.selvanathan@oss.qualcomm.com/

Balaji Selvanathan (4):
  disk: Add partition lookup by type GUID functionality
  scsi: Add partition lookup by type GUID for SCSI devices
  env: scsi: Add support for partition type GUID based environment
  configs: Enable partition type GUID for QCM6490 and QCS615 boards

 configs/qcm6490_defconfig     |  5 +++++
 configs/qcom_qcs615_defconfig |  5 +++++
 disk/part.c                   | 39 +++++++++++++++++++++++++++++++++++
 drivers/scsi/scsi-uclass.c    | 34 ++++++++++++++++++++++++++++--
 env/Kconfig                   | 31 +++++++++++++++++++++++++++-
 env/scsi.c                    | 13 ++++++++++++
 include/part.h                | 21 +++++++++++++++++++
 include/scsi.h                | 11 ++++++++++
 8 files changed, 156 insertions(+), 3 deletions(-)

-- 
2.34.1

