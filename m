Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D9AC83F1A
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 09:00:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CA798380E;
	Thu, 24 Jul 2025 11:00:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ldkjjWqP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37B5483666; Thu, 24 Jul 2025 11:00:35 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78440837E4
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 11:00:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NMXNmO022030
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 09:00:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=nf1kkJmIEWj
 cTE7sJj6B1FxNGxNMeATicK3+KhoUpEI=; b=ldkjjWqPWnSqRzdBLlWdeoyPt+o
 6lhf5onlztI67wmaz0wwKDtiNHUnJaNdjkRwQkBiLOhvxhDEa/fuYvF1dz5L+CxX
 OX1n+1NXwqPRcWmjKILIvppD7ha1T4ZRqVCDpv5OKojZEGRG46BuKUOEie0dJZmt
 oSEqp/yBWO7hZiVtlUfGrleHm3d7zPizRoRNBwvQPbrnI6h/B/dqGUmMsmogi5wt
 1A48cDynaFol/R+j1cXzGY5HzqZ96cEKQ1X37Hn4YdTXdAce4NsReMIbCCzozkkA
 Hs/C6BR9zZQO/Rc3yVe/4+8Rgmcfrz8/iKSBqrhe98VI9KU+j/MySLU27HQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48044dqw6q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 09:00:27 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b39280167fdso733309a12.0
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 02:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753347626; x=1753952426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nf1kkJmIEWjcTE7sJj6B1FxNGxNMeATicK3+KhoUpEI=;
 b=MOyK/vZLX7A2uXusw30yz64BAgxJYBXEoF4UsuQy1dQTaeUsv7KgfZ8sF/sJDmsJoO
 +0/poi5Nq8ZLy7P0EndER2Q+vGNBAnQ5yXtSLzD+qyQNiHanwA6WVLvpd1/vu+BNZxEw
 /GAddLyEigpmR3tvPyz3D9qApfeAKbhwgCGFcevEkzAi2k5Dh6O6RZUNkdEY3KnUaWkM
 n+k/iQmDBWvYXkt3DXKQA6+l1fSRcI9NPcXX394KRIyM7azwFwgl9n+gGmZ8s10ETDJP
 UFW1cRpZNtMGcC9ZWspWiURpRkK3GQ7JSkJMbCpP6rHq1FXibnj2cXIc+SRvdzSYCOnV
 6INw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLP2DTN/d4yRkBNxlDiF4IPkkC7HUU09JqWZBgDfwBPtokjf+7diqN1Us3c5WyJP3doLLHY+w=@lists.denx.de
X-Gm-Message-State: AOJu0Yx0NFTe4JMVy/GCNJLZdoBMPK3XV4Z9w7vIJ7E+vAyExTzjOBCK
 +aPlj08ao69BwaJ9vkaml9WEG6bnAzlEVHJo3/Vpmv85suaxI95bV1dCvfGjSDTKfEv9iOg+yg3
 MuEBAw/hv92MvEEnJPZQSkhePWA6f8F0OY7MYpCUJjDCA4IYeTb6y4Cj2
X-Gm-Gg: ASbGncsnntYsrR9gKR8CFpK2egNedReOo0XdIi6m1W4lJKHci4fLdyixVSQobXywT8l
 sF4D7J3AaZgeFxtkbyTop5bM8SgbQ4DyeosMEDXx+hp340mFODvw2JouW23fwLqlaS8itjRQ6JC
 LFEPToQFhNut8JTXP1HjWHZPCKzQ1gjOve0yKmW6zFrCYQKxzfkaorvwFM9G7PDvGI0eeW312xi
 uAHleaAER/KtGDBPYT9T3+dDpmSa7VK7H3c80XlW5MQn4V0uQ5mDmFxTURfcVp8i/O3D3uhr5mR
 Ru+Q/MdnFRTaOD83f0/49U3XFOilYMWvDx8bbuyfCA0oxJeFIoXIyMtkV4F+85B0thsvxabMUgS
 WhVmX4zdGkmmkyXXhPblvdigfL0kPSsNIyoR38laSkr3daXly0QvlkHJUmZ6tFNyewYC/
X-Received: by 2002:a05:6a21:6001:b0:239:c7c:8de8 with SMTP id
 adf61e73a8af0-23d49040174mr9521732637.12.1753347626283; 
 Thu, 24 Jul 2025 02:00:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFoDEa0LMH0DcAi1+n0t4C6ixb5bJo5/CVvvD0/AY3HLyoBfZg4jg8DR1tL8ZpbKfDXZbAFw==
X-Received: by 2002:a05:6a21:6001:b0:239:c7c:8de8 with SMTP id
 adf61e73a8af0-23d49040174mr9521678637.12.1753347625894; 
 Thu, 24 Jul 2025 02:00:25 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-761b061a514sm1161395b3a.114.2025.07.24.02.00.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 02:00:25 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 balaji.selvanathan@oss.qualcomm.com, adrianox@gmail.com,
 moritzf@google.com, sjg@chromium.org, maks.mishinfz@gmail.com,
 javierm@redhat.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1 2/2] capsule_update: fix partition match to exclude
 uefisecapps
Date: Thu, 24 Jul 2025 14:30:09 +0530
Message-Id: <20250724090009.569341-3-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250724090009.569341-1-balaji.selvanathan@oss.qualcomm.com>
References: <20250724090009.569341-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BJ6zrEQG c=1 sm=1 tr=0 ts=6881f62b cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=ZLdwFymHKL66s0hxc-gA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: A8iQ364YaSJjCE6Dqdrias1BhSXTG3bj
X-Proofpoint-ORIG-GUID: A8iQ364YaSJjCE6Dqdrias1BhSXTG3bj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA2NSBTYWx0ZWRfX17t9sq41KdhS
 drCs37xmT15skppmANQhrNu9n9SXfLrF6b4TQ1KwFiLmHchSk28MApY1sH1haL9zhLQ1MEuFk79
 JC60oEwMUMO5em1lL8unfBnJBGG+EieiQVbcGfPIW7z6QNyUbxE/bSyRMvZueGBpDR8Y2CVGOnQ
 gwhKUXEJHGc6UU3YjP7ayOX8FN1fWJnMAS3y+1q15RxhGGyBtDJ78hktoH+01GfG2j9NDMXJBYr
 rjCwgtIy1rrV76b68zgThfoquKyAkiH8P2osK5MNlV+FIWCTlnAOCZ8SWETqjgOi+A8kXN3vW9S
 qg3PEQPz1EHOk9PrWbuR6wmHEOv2j7WdfeNtONTrWdGpU3pCEi4YK0hESXEAYyDCZY3uGeP3IrS
 nteruPDQbOlOGWvzQrhMTNNMe/dLc7eiEt/hT9B/JnGGSGDOCErssgQcQfnYoTz4pCApHAoa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_01,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 mlxlogscore=803 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507240065
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

- Update partition name match to use "uefi_" instead of "uefi".
- Prevents incorrect matches with partitions like uefisecapps_a/b.
- Ensures only uefi_a and uefi_b partitions are considered valid.
- Fixes capsule update logic when identifying target partitions.
- Avoids flashing to unintended secure apps partitions.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/capsule_update.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-snapdragon/capsule_update.c b/arch/arm/mach-snapdragon/capsule_update.c
index 4dced4961b6..11ef4a0f4b9 100644
--- a/arch/arm/mach-snapdragon/capsule_update.c
+++ b/arch/arm/mach-snapdragon/capsule_update.c
@@ -136,7 +136,7 @@ static int find_target_partition(int *devnum, enum uclass_id *uclass,
 			 * flags might not be set so we assume the A partition unless the B
 			 * partition is active.
 			 */
-			if (!strncmp(info.name, "uefi", strlen("uefi"))) {
+			if (!strncmp(info.name, "uefi_", strlen("uefi_"))) {
 				/*
 				 * If U-Boot was chainloaded somehow we can't be flashed to
 				 * the uefi partition
-- 
2.34.1

