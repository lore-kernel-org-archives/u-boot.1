Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA61D13C3C
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 16:00:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E590883EE2;
	Mon, 26 Jan 2026 17:00:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ai4SG25n";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QTU46Yt0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30CCB83C04; Mon, 26 Jan 2026 17:00:05 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1467683E9F
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 17:00:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60Q8U8VN860194
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 16:00:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=qdJwO5BY8+H
 hRGjzkKFxrxZU34Mgf2Sm9jJe1lKXDD0=; b=ai4SG25n1PACcWfbCFdJYrF1qte
 yB1QOLaDqcCTBLJ4sVx49ISSFXpdFq3C4IZ/tDu+lJm8nVZ8iVvRbBXliNEy+Soo
 oTkmY080KSox51cToRLELttc4x6unW50hvzoJ9bLVJcA0SZt88AdTdcChqyiudny
 RjlQD6s05dNC2jlttbdyelMhAJGuRGrDKAVMMIVwhscoWeWV4zmeAyTZL70ZbLqX
 m93w0+79UnExzEn7HlJ4HVhKheDUIxS0Hf1818yqdkAv4C1ilb6E2hEgjFz4pQoC
 MfYaLEv6ycatTEPkqusCj/GfrEN5+967vqf241pLkbqVuPo7LQSYoRnf6xA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bvwtycg5h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 15:59:59 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2a0a4b748a0so98215935ad.1
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 07:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1769443199; x=1770047999; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qdJwO5BY8+HhRGjzkKFxrxZU34Mgf2Sm9jJe1lKXDD0=;
 b=QTU46Yt0FF0boHFOCgYTGcy+lU6U2/LWVzMr+nulo/DbwapHWvScCwDMRNo8HzgMvI
 KUCrZyuifqOIW/BBb7rCvuYOLAQhW+AaaW6fmEQntFg31WU7x4eywJJInoDtpiaDgPBn
 T0l3FnPFRd7AYcG0waPgTtvpBJEl4FqAdoJ+4mLCg2CcUWYAdrvMSPR7SL9FUG1HpqRY
 2xOBZz2ui7eXOCM5+FLjBldt/um15aNQxGE7x/++PiEiwCtW2BH36Io14MhfAC9iHxuY
 4tvwD/sjP6W5Fgjj6hfRIJamFU0L3fwDqy5x6ANzyw0jWzANoUiRPHogsX1jzM0AieQ2
 rgBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769443199; x=1770047999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qdJwO5BY8+HhRGjzkKFxrxZU34Mgf2Sm9jJe1lKXDD0=;
 b=nsfRDJ+RMWlLgunC5Hirnd92Ku8evgpUcPiUQvkvz2euO40od7cwLhc+MDOH4a6PrC
 Jsqobw9S+nWl9f+hmdkV1a8Kf97N2P4CWqjoPeVOAZRF3HuwUEugyarfM8ior1gnqdqs
 5jyB4b2/HhClw5XAIqwcxHZyjlqyairptqr1+exKOEScftX3bdN0iMtl7wMOC2veFC4I
 taIG4wKialUphKzGavVj5Hvf971pjmSwiB5L/4awV6JPJQkxZf0fsIK/LRigT1tP+tqW
 2iovtR0JDQfhweD+LoL/gYhbN/KBEYRGTPL2VsfNtZmyjAHMuwj3DSjq59iwFsSoLlvM
 hGXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUXdycuMVZGDiFiMvj2ZP/2VhNY0A+FR1A9vgPulB+0q4xuKEeJtUu4wSmk87u3Mr/GttZwpM=@lists.denx.de
X-Gm-Message-State: AOJu0YxKQIxnwLiNElkVhhrelNBHSScOPX/YzoKCTv+lcvLI9S89/wYU
 Zo/WCMgPFUr1lRDgeeEWpCcxpO5nxHfsufM8/aAgQXYfX0gYoTUTJq0g5tpSDgfnOImOvmoinq6
 SK7mzwuk3KK8WR3xD3vpMAQaCQdG7pmuP64quLyT4TsuKFSbsZ3cHRyIx
X-Gm-Gg: AZuq6aJJPLH5FpyiF+TOzp+x13U8y2iinUH4mYK1r80JoHYMnuNOURKv/I4xnv8KFcQ
 p6HfosfnA3/S/QkrqX2djISf4dN9KOfCFd9WtnQtar8wQF66CnR4R35QwxRlQ3863q1tmUfFOaN
 qvjMk3v8oUlhVyKqXH6wYVbVpfxWO1G9oDKK7PytwCLMV8CBPAyLpdB53vAfdHHX91G5G56ZTWE
 T+t1K4BbYFsmvBU9noULcdt6VJbrTDpqkWyEf/ZSr+SWX+F57hspbf8HHOYW5TSsnZSaXQDlP61
 Z3hlfVi+Rw49o9A7xzHZtqNE7yawNRxuNuyukaUnpqM4s80XNKXPUZTwxBBbu0VwRFtASzstr1v
 rz+P+T+Dbo3KXUXUQOXmI179LawnH+AKwWrKWyWNW1NNM4ldD2Dk/tMjH4R3QisNKyu9sxh3HsU
 0romGRA4mDfEewi7stsMaeZY/qf9Dw0kQ9jNGUkQ==
X-Received: by 2002:a17:902:f70d:b0:2a7:757b:35ad with SMTP id
 d9443c01a7336-2a84530eb6amr50607025ad.42.1769443199150; 
 Mon, 26 Jan 2026 07:59:59 -0800 (PST)
X-Received: by 2002:a17:902:f70d:b0:2a7:757b:35ad with SMTP id
 d9443c01a7336-2a84530eb6amr50606725ad.42.1769443198683; 
 Mon, 26 Jan 2026 07:59:58 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a802fd929asm93245505ad.90.2026.01.26.07.59.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 07:59:58 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, aswin.murugan@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, rui.silva@linaro.org,
 david.wronek@mainlining.org, ilias.apalodimas@linaro.org,
 luca.weiss@fairphone.com, jorge.ramirez@oss.qualcomm.com,
 stephan.gerhold@linaro.org, quic_varada@quicinc.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1 3/3] board: qualcomm: Remove SCSI scan from default preboot
 environment
Date: Mon, 26 Jan 2026 21:29:38 +0530
Message-Id: <20260126155938.2717540-4-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260126155938.2717540-1-balaji.selvanathan@oss.qualcomm.com>
References: <20260126155938.2717540-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 88T7tPwFMplW0xrTdsOtnUPULwbkkpdJ
X-Authority-Analysis: v=2.4 cv=BteQAIX5 c=1 sm=1 tr=0 ts=69778f7f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=22eT9C0fHbvWDeABP3MA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: 88T7tPwFMplW0xrTdsOtnUPULwbkkpdJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDEzNiBTYWx0ZWRfX4hTc+Gu+dAJF
 8x1gPriDYBT4mXBNEKRTfxYilo7fLsaR7tbBhz7P0wDNJ77WxtY86FVSLhNNsXqOjxXBovGjMOq
 5sglMP4AtHKUFesKVfly2Mr5dh8WDI09vETHjHNtJOBT0ye1Wz6jYk4MX3OWl6pDI6EP3UCPTkW
 RogyhhJbLyV/UPRFW5jU2IoeEiCLIWDVv3rq4156J8VpHIY2asWOzKAO/puo5Pp2L+eSEPWshm0
 FxgVLnR6Z+VjZ7kX+hJKFL4Eb/RALrRdY3s0t7SFO9ob6eLUxsJ60kNiyVTMwJ6KV6vPNvLMrVW
 KUM9UFmZt+szRI7gfSMOu6zlA+C0gUtieXtdmgLxManggK8gumDmQNTBSMNmgg/f3x7LqjMdZxq
 qJBA/RlhTFaoQkFQ8KOUBPZulDJqXeXsQhW3e5MgaQd0wm6V878YAvW0kIKZDKe8VjXDGNNh7u7
 bzSjxEe9FR9dvFjk2Kg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_03,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601260136
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

Remove "scsi scan" from the preboot command sequence in the default
Qualcomm board environment. The SCSI scan command fails on eMMC-based
boot configurations, causing unnecessary boot delays and potential
error messages during the preboot phase.

This change improves boot reliability on platforms using eMMC storage
as the primary boot device.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 board/qualcomm/default.env | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/qualcomm/default.env b/board/qualcomm/default.env
index dbf6f4e7260..7cfa8e0ce2a 100644
--- a/board/qualcomm/default.env
+++ b/board/qualcomm/default.env
@@ -1,7 +1,7 @@
 stdin=serial,button-kbd
 stdout=serial,vidconsole
 stderr=serial,vidconsole
-preboot=scsi scan; usb start
+preboot=usb start
 fastboot=fastboot -l $fastboot_addr_r usb 0
 do_boot=bootefi bootmgr
 bootmenu_0=Boot first available device=run do_boot
-- 
2.34.1

