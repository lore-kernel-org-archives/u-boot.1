Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB451C5AC67
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 05:57:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6B6C340907;
	Thu, 13 Aug 2026 05:57:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AwGDRYa6sO6B; Thu, 13 Aug 2026 05:56:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 542754091B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786600618;
	bh=PkzIzd0I4Xj4tNXOnULV7aIiLgLcfmL3I2822siLeOE=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=IGBwI0Rlo8Ihsg9E6h0mrTs7/ObTyX7u5D9RUgonv8vIkZzFxVUTFjLcJG5m7ibNX
	 0KYSKRgagPps/NeXqrnYIPEiw7cO6zQXMSMmSWP/H2lCSRDiixM2UBumTttXjUIrH3
	 MNFIWYP5pb27eeQXp0VP1AdryAoQfgWfEHeb6MPWoRVQ2Wq0Qtj3Li8oeCNjpGAYYf
	 2crUh3wh39fthA+q50U2ArFH3auv6mTHJ6VHqgsz7/ZmdCkmhZOWEGKb55lQMnOYU/
	 3pvdqBg+EqhshsLQwNyAnZluh553e+YRaEYepBEapjsHFQcH8fXMkOAweoqMB2bbuM
	 J5X+CspT27jYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 542754091B;
	Thu, 13 Aug 2026 05:56:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 627931B8
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:56:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 54962608B4
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:56:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8mmrgI7zma-f for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 05:56:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 57D8260A90
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 57D8260A90
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 57D8260A90
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:56:55 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67D5gKQV1476981
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:56:54 GMT
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0uts32av-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:56:54 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-84842381150so2329905b3a.3
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 22:56:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786600614; x=1787205414;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PkzIzd0I4Xj4tNXOnULV7aIiLgLcfmL3I2822siLeOE=;
 b=a4XK60JqQRnLbR/vxeVMQYmjaNeA42DW0X5OgViE+7gz9npo9iIqhoJQpJZHxAS3ER
 8Zdxw2Mz0oHoV5OGTu1LaD7TUOB+JP4j0okXybiaXMpYowbMD3i/u4cxd+2myeqDjfQ+
 fshAdWWfDgB+to1AyhoZx6T1sRzR2lj0PDaeom0W70E9ljgGJpF5oRMagpq8DTEj0QhI
 meKGaaJPUAUeuiCaZYEyi15q3GaaEOWM5BXudx4jyr9VGBJjKSrdBtYamvhS30sLOx4J
 fTmQUYD7sAfJ0aql2Kg3gu21QI/dzi7HfRjMKjjo3SyNbHtPF0zopNOGutm99tP/QApa
 YyfQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrg/Btz5ygtbgubiPtbx2bR+d6Qb2OP8cHT15mzO5G5IrmgynCqFt/ptjlJDDT82Sdd94pW01Y=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxssZ1VRVsp7Wkr3CEay+IWmN4rS5/fAmk4JKRE6wFD+4pZ1yhq
 3utbrlvY69iVxSRYHMxeAYEZgC6ohoRohiy1ksYBRT5qHuXnIzJaw7bDsvvh9qkQ1c1G6fzz2Sg
 /e3ok8Gf5s8uUXGJU0VVuEiYpRpIyv1qQlYjLEG+IMVD++6Hkw2slwL3IcfPC5saNVBhzQaA=
X-Gm-Gg: AR+sD11AAZ3kgSbibc8rvcxA3NzqhZNwvLZFZ8eGXB4n5Gb7kzKVB9D0FGuCSXv2msR
 eGqw73IFPe3n8s/p89Ufpn2C6TVoSHbkfsem/TZ6FfQGBJ932eFmzieWFhK9gZXV+sc1gf9FOPL
 wPNrrWGzc+ghBBnUvxHpSgPGC+VPLRoQn+47WaJk0L9HwKg0vGbdOF2elYOiarzuLg5oEYbObL9
 Ber7ChSE3TWddpJ8wI8IZEZWDSwIaIrxsTnOi7Q9unpSnLSgZuSqQlppsUHFA4cXOp1tL542BXD
 99iPPAgGMF6iE8QGn3VzGb/BPzfSa3lWQI2lRWjfMSdibSR3kQNzfHKI3okRawOfyUpkQGwYrZP
 31Ol0kEWSSsJd0uO+aGoGXi45LLMoojPflcnfaJzbt9ROCfigUPAawzDmSkXLaoISUcRUXq4PH0
 tSJ25BpVVrNEz4hn4nkoNDdcsrOQ8n
X-Received: by 2002:a05:6a20:3d19:b0:3b4:870e:6f44 with SMTP id
 adf61e73a8af0-3cc55323ffcmr4141428637.35.1786600612979; 
 Wed, 12 Aug 2026 22:56:52 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d19:b0:3b4:870e:6f44 with SMTP id
 adf61e73a8af0-3cc55323ffcmr4141328637.35.1786600612107; 
 Wed, 12 Aug 2026 22:56:52 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31ebf7317a8sm3506605eec.14.2026.08.12.22.56.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 22:56:51 -0700 (PDT)
Date: Thu, 13 Aug 2026 11:26:41 +0530
Subject: [PATCH 1/2] qcom: capsule: build fw_images[] dynamically from the
 partition table
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-qcom-capsule-dynamic-fw-images-v1-1-e595ff79496f@oss.qualcomm.com>
References: <20260813-qcom-capsule-dynamic-fw-images-v1-0-e595ff79496f@oss.qualcomm.com>
In-Reply-To: <20260813-qcom-capsule-dynamic-fw-images-v1-0-e595ff79496f@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Biswapriyo Nath <nathbappai@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786600603; l=32095;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=y4sYz1WI47VuNYpplj3NTsNJad3ds/Wk64QFbhMGI/A=;
 b=/pf1/rrNVenDiFXvIZLcfLwch1NDZ8mX4DTpY5PTN3hbbB4wIsN9V3iIcin5VCmh+LTHdLCCq
 NNJ9uor1hh2Du7SrwP6Vii23daidpnfKtRmqRX5s68x5H2AJP0Em6Uj
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: g3HaZT5rv5J6wVSBlfnCJse7K3r0s9xp
X-Authority-Analysis: v=2.4 cv=aPDAb79m c=1 sm=1 tr=0 ts=6a7d5ca6 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Qi8HFNkdNF7v-_dflKcA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: g3HaZT5rv5J6wVSBlfnCJse7K3r0s9xp
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDAzOSBTYWx0ZWRfX6qJe2NarCYHw
 knDh7jP5IHQ9K4aQ4MQq//pvLBUeRCIec8gbT2YBnstHtgvwIGm4LUhGck6cflIWhhbuP/CpaU5
 5qVMX162qyGQK9ZE3kzt58bcfhDAOd4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDAzOSBTYWx0ZWRfX1NSPaZ3+jCqA
 7SwWOVPezTKOGWRzdUagHQmEGtjPKSYeiUvDK8xGsXcDB4KREJFDc+YvS4ecaLSg2/GlW0vz+yE
 0jgdejs8gsGMePV17yF4Z4BOwGezE0vvd91DEwQ952pYRwzB+3DAl+RbFaoZ7HbKXJXfL8LGaT9
 JNCGxcq1t4olXAG/KFMdUdC0HTQdx69XfKoWv4BcDMIfbleG9oWQSxtDUFhvm+bcDjqnqK6n4FN
 j9jvHTfc5R21TvPoQzietH2FaNHQzAYk8yTurmYJXkGF93iA4CI/6IEushcTMVg20szuF2ZQZfq
 aYzkHoyyQKXj+2kbRVU83NqbO/xSfYIULv1V52PMiXruTwkN2web3GvCPODBvIT9wrNCFb7JtdE
 NFYVWHq/yRjKPVqN7nQV9UH8Z+10tQysLRz1sX67vtVPpGPL1cL/wU7aVIpDT48/AlWYQGXz4ST
 +2fXeWcH/0eXFAQ086w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130039
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PkzIzd0I4Xj4tNXOnULV7aIiLgLcfmL3I2822siLeOE=; b=n+N3zYUWdQpSTpNZ
 5JV/fCa/BmEHcrD6zJyKqrnejzotMgzFu/lBXPq55pQNP9xI6CxBmdWHP+nkrO/R
 1KhdgDf4zuXYons2LEMWu7KklXSsq93s8jSVbMtg3zwFpiXfhCdZ71RXg+W/dcvA
 ljjt5Owx017pnduhZUjfhs/N4Drna15SpswJ/PCbnSvKBioVO2lc0kl8iY4cL8DD
 SDUZDdVNlHBpK8o2sFEwN5gjR22mBViJ2I+AmVMDPVbc93XRDHYKwv5/tcJDc098
 i9mX3Yfx7IQnCL6Vo1ET3oAPnHOHfhTPYVVD3oNv1Abt+SWLhwq/Wycg+sySmbdI
 Ok4Qug==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786600614; x=1787205414;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PkzIzd0I4Xj4tNXOnULV7aIiLgLcfmL3I2822siLeOE=;
 b=cnVtOwGjT0wem3aH+Wt/KOmj1mf7DyQFdvMWCdwxvV/oyDUFrl3fbIyo3KfJay1o63
 +AJ0MhgjZP0g/9RQOpqFIpgxZVpJ0qpsuQj8bZ4EMPR8YcMDMhh2h7zat5GhPhHzDwHy
 TfQYgPmz+DMtrxWEUOni1NKySS/PaPrNbG1ix6dPGNFkMwnjPKPgUqT7fQMipqlACCeJ
 bOGEoimO1rgOwF41/L6reB6Xa1wRBH9O3x/9pKGT8w1CbYxStdHe1lkZWFc5NtrbRkkj
 hbkA898VGTPv+GoDrhBpetNjecZpzYkcy/t/v3HXTAHwe8/0dwyr62B2moS664yS8NRw
 Chxg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=n+N3zYUW; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=cnVtOwGj
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Balaji Selvanathan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Capsule update on Qualcomm boards only ever handled a single image:
U-Boot itself, found by find_target_partition() and hardcoded as the
lone fw_images[] entry. There was no way to update any other firmware
component (xbl, tz, hyp, aop, devcfg, qupfw, ...) through a capsule.

Replace this with a table, qcom_image_map[], that maps each
partition_base to an image_index and fw_name. Scan every partition on
every probed block device; each map row with a matching partition
contributes one entry to a variable-length fw_images[] and to a
matching dfu_alt_info string. num_images is set to whatever was
actually discovered, so a component missing on a given board is simply
left out.

U-Boot's own image keeps image_index 1. Rather than a separate code
path, it is now expressed as three boot-source-gated rows (uefi/xbl/
boot), so find_target_partition()'s uefi-over-xbl priority and A/B slot
selection are reproduced by the same generic scan rather than
duplicated logic.

image_index values are frozen once a capsule references them, so
qcom_image_map[] is meant to only ever grow by appending new rows;
existing indices must never be renumbered.

Since dfu_alt_num can no longer be derived positionally from
image_index once components are missing on a board, this also adds a
strong efi_firmware_get_dfu_alt_num() override that looks up the
dfu_alt_num recorded for each image_index while building the DFU
string, falling back to the generic (image_index - 1) for anything it
doesn't recognize.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
This patch depends on following series:
https://lore.kernel.org/u-boot/20260813-efi-firmware-dfu-alt-num-v1-0-43f034253b21@oss.qualcomm.com/
---
 arch/arm/mach-snapdragon/capsule_update.c | 757 +++++++++++++++++++++---------
 1 file changed, 530 insertions(+), 227 deletions(-)

diff --git a/arch/arm/mach-snapdragon/capsule_update.c b/arch/arm/mach-snapdragon/capsule_update.c
index 586682434b7..9a5b1578a27 100644
--- a/arch/arm/mach-snapdragon/capsule_update.c
+++ b/arch/arm/mach-snapdragon/capsule_update.c
@@ -21,35 +21,109 @@
 #include "qcom-priv.h"
 
 /*
- * To handle different variants like chainloaded U-Boot here we need to
- * build the fw_images array dynamically at runtime. These are the possible
- * implementations:
+ * fw_images[] and update_info are built at runtime from the board's GPT
+ * partition table (see qcom_configure_capsule_updates()): the set of updatable
+ * firmware components varies per board, and U-Boot itself may live on one of
+ * several partitions depending on how it was booted.
  *
- * - Devices with U-Boot on the uefi_a/b partition
- * - Devices with U-Boot on the boot (a/b) partition
- * - Devices with U-Boot on the xbl (a/b) partition
+ * qcom_image_map[] maps each partition base name to a fixed capsule image_index
+ * and a slot-independent firmware name. U-Boot's own image is image_index 1 in
+ * the same table, split into boot-source-gated rows so the right partition is
+ * picked for the running boot source: uefi/xbl (or the legacy "aboot" alias)
+ * when flashed as XBL, boot when chainloaded from ABL.
+ */
+
+/**
+ * struct qcom_image_map - maps a GPT partition to a capsule FMP image
+ * @partition_base: base partition name, without the _a/_b slot suffix
+ * @fw_name_base: slot-independent firmware name; the FMP GUID is derived
+ *                from this, so it must stay constant across A/B toggles
+ * @image_index: fixed image index for this component, frozen forever once
+ *               a capsule ships referencing it. image_index 1 is reserved for
+ *               U-Boot's own image (the three boot-source-gated rows below);
+ *               exactly one of those is ever selected per boot.
+ * @boot_source: if non-zero, this row is only eligible when qcom_boot_source
+ *               matches. Gates U-Boot's own image: uefi/xbl need
+ *               QCOM_BOOT_SOURCE_XBL, boot needs QCOM_BOOT_SOURCE_ANDROID.
+ *               0 means any boot source (every real firmware component).
+ * @alias_base: optional second base name this row also matches (the legacy
+ *              "aboot" alias for U-Boot on the xbl partition); NULL for none.
+ *              Matched both slotted ("<alias>_a"/"_b") and bare.
+ * @match_nonslotted: also match the bare, non-slotted @partition_base. Some
+ *                    boards don't use A/B for U-Boot's partition (e.g. a
+ *                    single "boot").
  *
- * Which partition actually has U-Boot on it is determined based on the
- * qcom_boot_source variable and additional logic in find_target_partition().
+ * Every row matches "<partition_base>_a" and "<partition_base>_b".
+ * @alias_base and @match_nonslotted reproduce the uefi/xbl/aboot/boot name
+ * handling find_target_partition() used before U-Boot's image joined this
+ * table; the firmware component rows leave both unset.
  */
-struct efi_fw_image fw_images[] = {
-	{
-		.image_index = 1,
-	},
+struct qcom_image_map {
+	const char *partition_base;
+	const u16 *fw_name_base;
+	u8 image_index;
+	enum qcom_boot_source boot_source;
+	const char *alias_base;
+	bool match_nonslotted;
+};
+
+static const struct qcom_image_map qcom_image_map[] = {
+	/*
+	 * U-Boot's own image (image_index 1). Exactly one of these rows is
+	 * selected per boot:
+	 *  - boot_source gating makes the uefi/xbl (XBL) rows and the boot
+	 *    (ANDROID) row mutually exclusive;
+	 *  - uefi is listed before xbl, so it wins image_index 1 when both
+	 *    partitions exist and the generic "xbl" row below stays a normal
+	 *    updatable component;
+	 *  - when U-Boot is on xbl (no uefi), the xbl row here claims that
+	 *    partition first and the component row is skipped, since one
+	 *    partition can't be two capsule images.
+	 * The per-row fw_name makes the FMP GUID differ, so a U-Boot image
+	 * built for xbl can't be flashed to the boot partition.
+	 */
+	{ "uefi", u"UBOOT_UEFI_PARTITION", 1, QCOM_BOOT_SOURCE_XBL,     NULL,    false },
+	{ "xbl",  u"UBOOT_XBL_PARTITION",  1, QCOM_BOOT_SOURCE_XBL,     "aboot", false },
+	{ "boot", u"UBOOT_BOOT_PARTITION", 1, QCOM_BOOT_SOURCE_ANDROID, NULL,    true  },
+
+	{ "xbl",         u"QCOM-XBL",          2, 0, NULL, false },
+	{ "xbl_config",  u"QCOM-XBL-CONFIG",   3, 0, NULL, false },
+	{ "uefisecapp",  u"QCOM-UEFI-SECAPP",  4, 0, NULL, false },
+	{ "tz",          u"QCOM-TZ",           5, 0, NULL, false },
+	{ "hyp",         u"QCOM-HYP",          6, 0, NULL, false },
+	{ "aop",         u"QCOM-AOP",          7, 0, NULL, false },
+	{ "devcfg",      u"QCOM-DEVCFG",       8, 0, NULL, false },
+	{ "qupfw",       u"QCOM-QUPFW",        9, 0, NULL, false },
+	{ "xbl_ramdump", u"QCOM-XBL-RAMDUMP", 10, 0, NULL, false },
+	{ "cpucp",       u"QCOM-CPUCP",       11, 0, NULL, false },
+	{ "shrm",        u"QCOM-SHRM",        12, 0, NULL, false },
+	{ "imagefv",     u"QCOM-IMAGEFV",     13, 0, NULL, false },
+	{ "multiimgoem", u"QCOM-MULTIIMGOEM", 14, 0, NULL, false },
+	{ "apdp",        u"QCOM-APDP",        15, 0, NULL, false },
+	{ "rpm",         u"QCOM-RPM",         16, 0, NULL, false },
 };
 
+/*
+ * Fixed-capacity, no heap allocation:
+ * one slot per qcom_image_map[] row. Only one of the three image_index 1
+ * (U-Boot) rows is ever used, so this is larger than the real maximum.
+ * update_info.num_images is set at runtime to the number actually found, which
+ * varies since not every board has every component.
+ */
+static struct efi_fw_image fw_images[ARRAY_SIZE(qcom_image_map)];
+
 struct efi_capsule_update_info update_info = {
-	/* Filled in by configure_dfu_string() */
 	.dfu_string = NULL,
-	.num_images = ARRAY_SIZE(fw_images),
+	.num_images = 0,
 	.images = fw_images,
 };
 
-enum target_part_type {
-	TARGET_PART_UEFI = 1,
-	TARGET_PART_XBL,
-	TARGET_PART_BOOT,
-};
+/*
+ * Worst case: every fw_images[] entry on its own LUN (each needing an "&scsi
+ * N=" or "&mmc N=" group separator) with a full-length "<name> part <num>"
+ * token. See qcom_build_dfu_string().
+ */
+#define QCOM_DFU_STRING_LEN	(64 * ARRAY_SIZE(qcom_image_map))
 
 /* LSB first */
 struct part_slot_status {
@@ -67,20 +141,6 @@ enum ab_slot {
 	SLOT_B,
 };
 
-static enum ab_slot get_part_slot(const char *partname)
-{
-	int len = strlen(partname);
-
-	if (partname[len - 2] != '_')
-		return SLOT_NONE;
-	if (partname[len - 1] == 'a')
-		return SLOT_A;
-	if (partname[len - 1] == 'b')
-		return SLOT_B;
-
-	return SLOT_NONE;
-}
-
 /* Shamelessly copied from lib/efi_loader/efi_device_path.c @ 33 */
 /*
  * Determine if an MMC device is an SD card.
@@ -98,206 +158,407 @@ static bool is_sd(struct blk_desc *desc)
 	return IS_SD(mmc) != 0U;
 }
 
+/**
+ * struct qcom_partition_info - a selected partition for one component
+ * @name: partition name as found on disk, e.g. "tz_a"
+ * @part_num: partition number on the block device
+ * @devnum: block device number @name lives on
+ * @uclass_id: uclass (UCLASS_SCSI/UCLASS_MMC) of @devnum. @devnum and
+ *             @uclass_id are carried through instead of a struct blk_desc
+ *             pointer so partitions found on different LUNs (e.g. Kodiak/Lemans
+ *             split xbl/xbl_config onto one LUN, tz/hyp/aop onto another) group
+ *             back into the correct per-device DFU string tokens
+ * @fw_name: slot-independent FMP name (from the matched map row's fw_name_base)
+ * @image_index: fw_images[] image_index (from the matched map row)
+ */
+struct qcom_partition_info {
+	char name[32];
+	u32 part_num;
+	int devnum;
+	enum uclass_id uclass_id;
+	const u16 *fw_name;
+	u8 image_index;
+};
+
+/*
+ * Used only within qcom_configure_capsule_updates() (scan -> resolve -> build).
+ */
+static struct qcom_partition_info qcom_partitions[ARRAY_SIZE(qcom_image_map)];
+
+/**
+ * struct qcom_slot_cand - one candidate partition for a map row's slot
+ * @part_num: partition number, or -1 if no partition filled this slot
+ * @active: A/B "active" flag from the partition's slot status
+ * @devnum: block device number the partition was found on
+ * @uclass_id: uclass of that block device
+ * @name: partition name as found on disk
+ */
+struct qcom_slot_cand {
+	int part_num;
+	bool active;
+	int devnum;
+	enum uclass_id uclass_id;
+	char name[32];
+};
+
+/**
+ * struct qcom_row_cand - candidate partitions for one qcom_image_map[] row
+ * @slot: indexed by enum ab_slot (SLOT_NONE for a non-slotted/alias-bare match)
+ */
+struct qcom_row_cand {
+	struct qcom_slot_cand slot[3];
+};
+
 /*
- * Determine which partition U-Boot is flashed to based on the boot source (ABL/XBL),
- * the slot status, and prioritizing the uefi partition over xbl if found.
+ * Candidate table, one entry per qcom_image_map[] row, accumulated across every
+ * scanned block device before a single resolve pass picks one partition per
+ * row.
+ */
+static struct qcom_row_cand qcom_cands[ARRAY_SIZE(qcom_image_map)];
+
+/**
+ * qcom_match_partition() - test a partition name against a map row
+ * @name: partition name as found on disk
+ * @map: candidate map row
+ * @slot: output, which A/B slot (SLOT_NONE for a non-slotted / bare-alias match)
+ *
+ * Every row matches "<partition_base>_a"/"<partition_base>_b". U-Boot's rows
+ * may also match a bare non-slotted name (@match_nonslotted) and a legacy alias
+ * base (@alias_base, both slotted and bare).
+ *
+ * Return: true if @name belongs to @map
+ */
+static bool qcom_match_partition(const char *name,
+				 const struct qcom_image_map *map,
+				 enum ab_slot *slot)
+{
+	char cand[36];
+
+	snprintf(cand, sizeof(cand), "%s_a", map->partition_base);
+	if (!strcmp(name, cand)) {
+		*slot = SLOT_A;
+		return true;
+	}
+	snprintf(cand, sizeof(cand), "%s_b", map->partition_base);
+	if (!strcmp(name, cand)) {
+		*slot = SLOT_B;
+		return true;
+	}
+	if (map->match_nonslotted && !strcmp(name, map->partition_base)) {
+		*slot = SLOT_NONE;
+		return true;
+	}
+
+	if (map->alias_base) {
+		snprintf(cand, sizeof(cand), "%s_a", map->alias_base);
+		if (!strcmp(name, cand)) {
+			*slot = SLOT_A;
+			return true;
+		}
+		snprintf(cand, sizeof(cand), "%s_b", map->alias_base);
+		if (!strcmp(name, cand)) {
+			*slot = SLOT_B;
+			return true;
+		}
+		if (!strcmp(name, map->alias_base)) {
+			*slot = SLOT_NONE;
+			return true;
+		}
+	}
+
+	return false;
+}
+
+/**
+ * qcom_scan_device() - record candidate partitions on one block device
+ * @desc: block device to scan
+ * @cands: candidate table, one entry per qcom_image_map[] row
+ *
+ * Single pass over every partition on @desc. Each partition is checked against
+ * every eligible map row (rows whose boot_source doesn't match the live
+ * qcom_boot_source are skipped) and recorded into that row's A/B/NONE slot. One
+ * partition can match several rows ("xbl_a" feeds both the U-Boot xbl row and
+ * the generic xbl component row), so the inner loop doesn't stop at the first
+ * match.
+ *
+ * Candidates from an earlier device aren't overwritten, so the first device
+ * wins when the same partition table is exposed on more than one (e.g. mirrored
+ * UFS boot LUNs). The candidate table is global rather than per-device so the
+ * later qcom_resolve_images() pass can apply uefi-over-xbl priority even when
+ * the two partitions live on different LUNs.
  */
-static int find_target_partition(int *devnum, enum uclass_id *uclass,
-				 enum target_part_type *target_part_type)
+static void qcom_scan_device(struct blk_desc *desc, struct qcom_row_cand *cands)
 {
-	int ret;
-	int partnum, uefi_partnum = -1, xbl_partnum = -1;
 	struct disk_partition info;
 	struct part_slot_status *slot_status;
-	struct udevice *dev = NULL;
-	struct blk_desc *desc = NULL, *xbl_desc = NULL;
-	uchar ptn_name[32] = { 0 };
-	bool have_ufs = false;
+	int partnum, i;
 
-	/*
-	 * Check to see if we have UFS storage, if so U-Boot MUST be on it and we can skip
-	 * all non-UFS block devices
-	 */
-	uclass_foreach_dev_probe(UCLASS_UFS, dev) {
-		have_ufs = true;
-		break;
-	}
+	for (partnum = 1; !part_get_info(desc, partnum, &info); partnum++) {
+		slot_status = (struct part_slot_status *)&info.type_flags;
 
-	uclass_foreach_dev_probe(UCLASS_BLK, dev) {
-		if (device_get_uclass_id(dev) != UCLASS_BLK)
-			continue;
+		for (i = 0; i < ARRAY_SIZE(qcom_image_map); i++) {
+			const struct qcom_image_map *m = &qcom_image_map[i];
+			struct qcom_slot_cand *c;
+			enum ab_slot slot;
 
-		desc = dev_get_uclass_plat(dev);
+			if (m->boot_source && m->boot_source != qcom_boot_source)
+				continue;
+			if (!qcom_match_partition((char *)info.name, m, &slot))
+				continue;
 
-		/* If we have a UFS then don't look at any other block devices */
-		if (have_ufs) {
-			if (device_get_uclass_id(dev->parent->parent) != UCLASS_UFS)
+			c = &cands[i].slot[slot];
+			if (c->part_num >= 0)	/* first device wins */
 				continue;
+
+			c->part_num = partnum;
+			c->active = !!slot_status->active;
+			c->devnum = desc->devnum;
+			c->uclass_id = desc->uclass_id;
+			strlcpy(c->name, (char *)info.name, sizeof(c->name));
 		}
-		/*
-		 * If we don't have UFS, then U-Boot must be on the eMMC
-		 */
-		else if (IS_ENABLED(CONFIG_MMC) && is_sd(desc)) {
-			log_debug("skipped SD-Card (devnum %d)\n", desc->devnum);
+	}
+}
+
+/**
+ * qcom_pick_slot() - choose the best candidate slot for a map row
+ * @rc: candidate slots for one row
+ *
+ * Priority: active A > active B > non-slotted > inactive A > inactive B.
+ *
+ * Return: the chosen enum ab_slot, or -1 if no candidate was recorded
+ */
+static int qcom_pick_slot(const struct qcom_row_cand *rc)
+{
+	if (rc->slot[SLOT_A].part_num >= 0 && rc->slot[SLOT_A].active)
+		return SLOT_A;
+	if (rc->slot[SLOT_B].part_num >= 0 && rc->slot[SLOT_B].active)
+		return SLOT_B;
+	if (rc->slot[SLOT_NONE].part_num >= 0)
+		return SLOT_NONE;
+	if (rc->slot[SLOT_A].part_num >= 0)
+		return SLOT_A;
+	if (rc->slot[SLOT_B].part_num >= 0)
+		return SLOT_B;
+
+	return -1;
+}
+
+/**
+ * qcom_resolve_images() - pick one partition per map row from the candidates
+ * @cands: candidate table filled by qcom_scan_device() across every device
+ * @partitions: output array; room for ARRAY_SIZE(qcom_image_map) entries
+ *
+ * Walks qcom_image_map[] in order, so U-Boot's own rows (image_index 1) resolve
+ * first and land in partitions[0]. Two dedup rules:
+ *
+ *  1. One selected partition per image_index. The three U-Boot rows share
+ *     image_index 1, so once one is picked the others are skipped -- this is
+ *     the uefi-over-xbl priority (uefi is listed first).
+ *  2. Never claim the same physical partition twice. When U-Boot is on xbl (no
+ *     uefi), the U-Boot xbl row claims that partition and the generic xbl
+ *     component row, matching the same partition, is skipped.
+ *
+ * A row with no candidate on this board is left out, so num_images varies per
+ * board.
+ *
+ * Return: number of partitions written to @partitions
+ */
+static u32 qcom_resolve_images(struct qcom_row_cand *cands,
+			       struct qcom_partition_info *partitions)
+{
+	u32 count = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(qcom_image_map); i++) {
+		const struct qcom_image_map *m = &qcom_image_map[i];
+		struct qcom_slot_cand *c;
+		struct qcom_partition_info *p;
+		bool dup = false;
+		int sel;
+		u32 j;
+
+		if (m->boot_source && m->boot_source != qcom_boot_source)
 			continue;
-		}
 
-		if (!desc || desc->part_type == PART_TYPE_UNKNOWN)
+		sel = qcom_pick_slot(&cands[i]);
+		if (sel < 0)
 			continue;
-		for (partnum = 1;; partnum++) {
-			ret = part_get_info(desc, partnum, &info);
-			if (ret)
+		c = &cands[i].slot[sel];
+
+		/* rule 1: one selected partition per image_index */
+		for (j = 0; j < count; j++) {
+			if (partitions[j].image_index == m->image_index) {
+				dup = true;
 				break;
+			}
+		}
+		if (dup)
+			continue;
 
-			slot_status = (struct part_slot_status *)&info.type_flags;
-
-			/*
-			 * Qualcomm Linux devices have a "uefi" partition, it's A/B but the
-			 * flags might not be set so we assume the A partition unless the B
-			 * partition is active.
-			 */
-			if (!strncmp(info.name, "uefi", strlen("uefi"))) {
-				/*
-				 * If U-Boot was chainloaded somehow we can't be flashed to
-				 * the uefi partition
-				 */
-				if (qcom_boot_source != QCOM_BOOT_SOURCE_XBL)
-					continue;
-
-				*target_part_type = TARGET_PART_UEFI;
-				/*
-				 * Found an active UEFI partition, this is where U-Boot is
-				 * flashed.
-				 */
-				if (slot_status->active)
-					goto found;
-
-				/* Prefer A slot if it's not marked active */
-				if (get_part_slot(info.name) == SLOT_A) {
-					/*
-					 * If we found the A slot after the B slot (both
-					 * inactive) then we assume U-Boot is on the A slot.
-					 */
-					if (uefi_partnum >= 0)
-						goto found;
-
-					/* Didn't find the B slot yet */
-					uefi_partnum = partnum;
-					strlcpy(ptn_name, info.name, 32);
-				} else {
-					/*
-					 * Found inactive B slot after inactive A slot, return
-					 * the A slot
-					 */
-					if (uefi_partnum >= 0) {
-						partnum = uefi_partnum;
-						goto found;
-					}
-
-					/*
-					 * Didn't find the A slot yet. Record that we found the
-					 * B slot
-					 */
-					uefi_partnum = partnum;
-					strlcpy(ptn_name, info.name, 32);
-				}
-				/* xbl and aboot are effectively the same */
-			} else if ((!strncmp(info.name, "xbl", strlen("xbl")) &&
-				    strlen(info.name) == 5) ||
-				    !strncmp(info.name, "aboot", strlen("aboot"))) {
-				/*
-				 * If U-Boot was booted via ABL, we can't be flashed to the
-				 * XBL partition
-				 */
-				if (qcom_boot_source != QCOM_BOOT_SOURCE_XBL)
-					continue;
-
-				/*
-				 * ignore xbl partition if we have uefi partitions, U-Boot will
-				 * always be on the UEFI partition in this case.
-				 */
-				if (*target_part_type == TARGET_PART_UEFI)
-					continue;
-
-				/* Either non-A/B or find the active XBL partition */
-				if (slot_status->active || !get_part_slot(info.name)) {
-					/*
-					 * No quick return since we might find a uefi partition
-					 * later
-					 */
-					xbl_partnum = partnum;
-					*target_part_type = TARGET_PART_XBL;
-					xbl_desc = desc;
-					strlcpy(ptn_name, info.name, 32);
-				}
-
-				/*
-				 * No fast return since we might also have a uefi partition which
-				 * will take priority.
-				 */
-			} else if (!strncmp(info.name, "boot", strlen("boot"))) {
-				/* We can only be flashed to boot if we were chainloaded */
-				if (qcom_boot_source != QCOM_BOOT_SOURCE_ANDROID)
-					continue;
-
-				/*
-				 * Either non-A/B or find the active partition. We can return
-				 * immediately here since we've narrowed it down to a single option
-				 */
-				if (slot_status->active || !get_part_slot(info.name)) {
-					*target_part_type = TARGET_PART_BOOT;
-					goto found;
-				}
+		/* rule 2: never claim the same physical partition twice */
+		for (j = 0; j < count; j++) {
+			if (partitions[j].devnum == c->devnum &&
+			    partitions[j].uclass_id == c->uclass_id &&
+			    partitions[j].part_num == (u32)c->part_num) {
+				dup = true;
+				break;
 			}
 		}
-	}
+		if (dup)
+			continue;
 
-	/*
-	 * Now we've exhausted all options, if we didn't find a uefi partition
-	 * then we are indeed flashed to the xbl partition.
-	 */
-	if (*target_part_type == TARGET_PART_XBL) {
-		partnum = xbl_partnum;
-		desc = xbl_desc;
-		goto found;
+		p = &partitions[count++];
+		strlcpy(p->name, c->name, sizeof(p->name));
+		p->part_num = c->part_num;
+		p->devnum = c->devnum;
+		p->uclass_id = c->uclass_id;
+		p->fw_name = m->fw_name_base;
+		p->image_index = m->image_index;
+
+		log_debug("qcom capsule: %s -> image %u (part %u, dev %d)\n",
+			  p->name, p->image_index, p->part_num, p->devnum);
 	}
 
-	/* Found no candidate partitions */
-	return -1;
+	return count;
+}
 
-found:
-	if (desc) {
-		*devnum = desc->devnum;
-		*uclass = desc->uclass_id;
+/**
+ * qcom_build_fw_images() - populate fw_images[] from the discovered partitions
+ * @partitions: partitions from qcom_resolve_images(); entry 0 is U-Boot's own
+ *              image (image_index 1), the rest are components
+ * @num_partitions: number of valid entries in @partitions
+ *
+ * One fw_images[] entry per partition, in the same order, so fw_images[] and
+ * @partitions stay index-aligned. .image_type_id is left zeroed:
+ * efi_gen_capsule_guids() derives it from CONFIG_EFI_CAPSULE_NAMESPACE_GUID +
+ * the DT compatible + .fw_name, as it does for every other board.
+ *
+ * Return: number of images written (equal to @num_partitions)
+ */
+static u32 qcom_build_fw_images(const struct qcom_partition_info *partitions,
+				u32 num_partitions)
+{
+	u32 i;
+
+	for (i = 0; i < num_partitions; i++) {
+		fw_images[i].fw_name = (u16 *)partitions[i].fw_name;
+		fw_images[i].image_index = partitions[i].image_index;
 	}
 
-	/* info won't match for XBL hence the copy. */
-	log_info("Capsule update target: %s (disk %d:%d)\n",
-		 *target_part_type == TARGET_PART_BOOT ? info.name : ptn_name,
-		 *devnum, partnum);
-	return partnum;
+	return num_partitions;
 }
 
 /**
- * qcom_configure_capsule_updates() - Configure the DFU string for capsule updates
+ * qcom_build_dfu_string() - build the dfu_alt_info string for the partitions
+ * @partitions: partitions accumulated across every scanned block device
+ * @num_partitions: number of valid entries in @partitions; also the number of
+ *                  valid fw_images[] entries, with matching indices
+ * @buf: output buffer
+ * @buf_size: size of @buf
+ *
+ * Builds an "interface devstring=alt;alt&interface devstring=alt" string (see
+ * dfu_config_interfaces() in drivers/dfu/dfu.c for the grammar), grouping
+ * partitions by originating device (devnum+uclass_id) with '&' so partitions
+ * split across LUNs (e.g. Kodiak/Lemans has xbl/xbl_config on one UFS LUN and
+ * the rest on another) still resolve. efi_firmware_raw_set_image() always calls
+ * dfu_write_by_alt() with a NULL interface/devstring, which forces the
+ * multi-interface '&'-grouped parser, so a single-group string would silently
+ * drop every partition on a LUN other than the first.
  *
- * U-Boot is flashed to the boot partition on Qualcomm boards. In most cases there
- * are two boot partitions, boot_a and boot_b. As we don't currently support doing
- * full A/B updates, we only support updating the currently active boot partition.
+ * dfu_alt_add() assigns each token's dfu_alt_num by its position in the parsed
+ * string, so fw_images[i].dfu_alt_num is recorded here as tokens are appended,
+ * not derived from image_index (which isn't contiguous or string-ordered once
+ * components are missing). Relies on qcom_build_fw_images() having already
+ * filled fw_images[0..num_partitions) from this same @partitions array.
+ *
+ * Return: true on success, false if @buf was too small
+ */
+static bool qcom_build_dfu_string(struct qcom_partition_info *partitions,
+				  u32 num_partitions, char *buf, size_t buf_size)
+{
+	int prev_devnum = -1;
+	enum uclass_id prev_uclass_id = UCLASS_INVALID;
+	u32 i;
+	size_t len;
+
+	buf[0] = '\0';
+	len = 0;
+
+	for (i = 0; i < num_partitions; i++) {
+		struct qcom_partition_info *p = &partitions[i];
+		char token[48];
+		bool new_group = p->devnum != prev_devnum ||
+				  p->uclass_id != prev_uclass_id;
+
+		if (new_group) {
+			char prefix[24];
+
+			if (i != 0)
+				len = strlcat(buf, "&", buf_size);
+
+			switch (p->uclass_id) {
+			case UCLASS_SCSI:
+				snprintf(prefix, sizeof(prefix), "scsi %d=", p->devnum);
+				break;
+			case UCLASS_MMC:
+				snprintf(prefix, sizeof(prefix), "mmc %d=", p->devnum);
+				break;
+			default:
+				log_err("qcom capsule: unsupported storage uclass %d for %s\n",
+					p->uclass_id, p->name);
+				return false;
+			}
+			len = strlcat(buf, prefix, buf_size);
+		} else {
+			len = strlcat(buf, ";", buf_size);
+		}
+
+		if (p->uclass_id == UCLASS_MMC)
+			snprintf(token, sizeof(token), "%s part %u %u",
+				 p->name, p->devnum, p->part_num);
+		else
+			snprintf(token, sizeof(token), "%s part %u",
+				 p->name, p->part_num);
+		len = strlcat(buf, token, buf_size);
+
+		if (len >= buf_size) {
+			log_err("qcom capsule: dfu_alt_info string truncated\n");
+			return false;
+		}
+
+		fw_images[i].dfu_alt_num = i;
+		prev_devnum = p->devnum;
+		prev_uclass_id = p->uclass_id;
+	}
+
+	return true;
+}
+
+/**
+ * qcom_configure_capsule_updates() - Configure the DFU string and fw_images[]
+ * for capsule updates
  *
- * So we need to find the current slot suffix and the associated boot partition.
- * We do this by looking for the boot partition that has the 'active' flag set
- * in the GPT partition vendor attribute bits.
+ * Scans every probed block device, recording candidates for every qcom_image_map[]
+ * row, and builds fw_images[] and the matching dfu_alt_info string. 
  */
 void qcom_configure_capsule_updates(void)
 {
-	int ret = 0, partnum = -1, devnum;
-	static char dfu_string[32] = { 0 };
-	enum target_part_type target_part_type = 0;
-	enum uclass_id dev_uclass;
+	static char dfu_string[QCOM_DFU_STRING_LEN];
+	struct qcom_partition_info *partitions = qcom_partitions;
+	u32 num_partitions;
+	struct udevice *dev;
+	bool have_ufs = false;
+	int i, ret;
+
+	memset(qcom_cands, 0, sizeof(qcom_cands));
+	for (i = 0; i < ARRAY_SIZE(qcom_image_map); i++) {
+		qcom_cands[i].slot[SLOT_NONE].part_num = -1;
+		qcom_cands[i].slot[SLOT_A].part_num = -1;
+		qcom_cands[i].slot[SLOT_B].part_num = -1;
+	}
+	memset(partitions, 0, sizeof(qcom_partitions));
 
 	if (IS_ENABLED(CONFIG_SCSI)) {
-		/* Scan for SCSI devices */
 		ret = scsi_scan(false);
 		if (ret) {
 			debug("Failed to scan SCSI devices: %d\n", ret);
@@ -305,41 +566,83 @@ void qcom_configure_capsule_updates(void)
 		}
 	}
 
-	partnum = find_target_partition(&devnum, &dev_uclass, &target_part_type);
-	if (partnum < 0) {
-		log_err("Failed to find boot partition\n");
-		return;
-	}
-
 	/*
-	 * Set the fw_name based on the partition type. This causes the GUID to be different
-	 * so we will never accidentally flash a U-Boot image intended for XBL to the boot
-	 * partition.
+	 * Check to see if we have UFS storage, if so firmware MUST be on it and
+	 * we can skip all non-UFS block devices.
 	 */
-	switch (target_part_type) {
-	case TARGET_PART_UEFI:
-		fw_images[0].fw_name = u"UBOOT_UEFI_PARTITION";
-		break;
-	case TARGET_PART_XBL:
-		fw_images[0].fw_name = u"UBOOT_XBL_PARTITION";
-		break;
-	case TARGET_PART_BOOT:
-		fw_images[0].fw_name = u"UBOOT_BOOT_PARTITION";
+	uclass_foreach_dev_probe(UCLASS_UFS, dev) {
+		have_ufs = true;
 		break;
 	}
 
-	switch (dev_uclass) {
-	case UCLASS_SCSI:
-		snprintf(dfu_string, 32, "scsi %d=u-boot.bin part %d", devnum, partnum);
-		break;
-	case UCLASS_MMC:
-		snprintf(dfu_string, 32, "mmc 0=u-boot.bin part %d %d", devnum, partnum);
-		break;
-	default:
-		debug("Unsupported storage uclass: %d\n", dev_uclass);
+	uclass_foreach_dev_probe(UCLASS_BLK, dev) {
+		struct blk_desc *desc;
+
+		if (device_get_uclass_id(dev) != UCLASS_BLK)
+			continue;
+
+		desc = dev_get_uclass_plat(dev);
+
+		/* If we have a UFS then don't look at any other block devices */
+		if (have_ufs) {
+			if (device_get_uclass_id(dev->parent->parent) != UCLASS_UFS)
+				continue;
+		} else if (IS_ENABLED(CONFIG_MMC) && is_sd(desc)) {
+			/* If we don't have UFS, then firmware is on the eMMC */
+			log_debug("skipped SD-Card (devnum %d)\n", desc->devnum);
+			continue;
+		}
+
+		if (!desc || desc->part_type == PART_TYPE_UNKNOWN)
+			continue;
+
+		qcom_scan_device(desc, qcom_cands);
+	}
+
+	num_partitions = qcom_resolve_images(qcom_cands, partitions);
+	if (!num_partitions) {
+		log_err("qcom capsule: no updatable partitions found\n");
 		return;
 	}
-	log_debug("DFU string: '%s'\n", dfu_string);
+	if (partitions[0].image_index != 1)
+		log_warning("qcom capsule: U-Boot's own partition not found; configuring components only\n");
+
+	qcom_build_fw_images(partitions, num_partitions);
+	if (!qcom_build_dfu_string(partitions, num_partitions, dfu_string,
+				   sizeof(dfu_string)))
+		return;
+
+	log_debug("dfu_alt_info: %s\n", dfu_string);
 
+	update_info.num_images = num_partitions;
 	update_info.dfu_string = dfu_string;
 }
+
+/**
+ * efi_firmware_get_dfu_alt_num() - resolve an image_index to its DFU alt number
+ * @image_index: fw_images[].image_index to resolve
+ *
+ * Strong override of the __weak default in lib/efi_loader/efi_firmware.c.
+ * Qualcomm's fw_images[] is built at runtime and its image_index values aren't
+ * guaranteed contiguous (a board may lack some components), so dfu_alt_num
+ * can't be derived positionally -- look up the value recorded by
+ * qcom_build_dfu_string() for the matching image_index instead, mirroring the
+ * scan efi_firmware_get_image_type_id() already does.
+ *
+ * Falls back to the weak default's image_index - 1 if not found, which
+ * shouldn't happen since every image_index passed in comes from fw_images[].
+ *
+ * Return: the DFU alt setting number for @image_index
+ */
+u8 efi_firmware_get_dfu_alt_num(u8 image_index)
+{
+	struct efi_fw_image *fw_array = update_info.images;
+	int i;
+
+	for (i = 0; i < update_info.num_images; i++) {
+		if (fw_array[i].image_index == image_index)
+			return fw_array[i].dfu_alt_num;
+	}
+
+	return image_index - 1;
+}

-- 
2.34.1

