Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8BE6C4451C
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 06:08:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6BB4D6074A;
	Wed, 22 Jul 2026 06:08:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yfKJA8zyWC12; Wed, 22 Jul 2026 06:08:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E19496071B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784700506;
	bh=5+SKdk5l0vRsov+IRkQsvEdXLkPsXugI78RVMRPCD9Q=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=LeNoo2BJqUgltBg8H6EaFoloXbQ3JCVKJaYRmmaHPeHIXPusFA+PL628aSnLj9f++
	 BfTkaBC5wRQeJn7j3IVKxrC3bfJHNNhFe4ySqtdX2PxHLmw+/mbyQuJhpvwxCXVZDi
	 pP2vmweM79Eyozi37/+eflhd68yViVgvHOXiK8oqoNzLzKUrVsPh9mmAO7+VNklbL3
	 YgZIH2+xrIxCfv7nh2AS+OkeNORw+Bph3Q1S6VuuXDqIJsXF49IeeA1np3DgFAtVQz
	 lQRejZRNQPzi9VxEzQs/M4RuERPyUYV4oj82MAeW1y+LATjVALPn9UUWJ/ezaplgfl
	 QvUWhsePCleYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E19496071B;
	Wed, 22 Jul 2026 06:08:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CB94542A
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 06:08:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B19BB40735
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 06:08:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y2WUtjXJ2QMp for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 06:08:22 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=jorge.ramirez@oss.qualcomm.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5F89B405F4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5F89B405F4
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5F89B405F4
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 06:08:22 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id A37BB8494B; Wed, 22 Jul 2026 08:08:20 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F898803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 08:08:18 +0200 (CEST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M53Xbp3767502
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 06:08:16 GMT
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjnu4rhmh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 06:08:16 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c110a3b6aso142075191cf.1
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 23:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784700495; x=1785305295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5+SKdk5l0vRsov+IRkQsvEdXLkPsXugI78RVMRPCD9Q=;
 b=FT4vfwRSaRyHoL3fJzBd3UOluyHdj8s5LhJ37vIlJ8gpBdzbL2plKhy79Oxf840i3P
 IZbqNT5TUtXbOvpV79GxN66jpsl7161jdavbZDkwa3wrC9YuV78M29ynpA++PkS7yrWA
 mtVFNYed9MdVhzjq2vpQpIOY76cl3Pr15KG/c7sJ6GGd99q6vFhGuDEA+b1bUvnsYJRa
 gRSUQBMRBuqRqeYqr5E65QHnaU8b2J8N0O/VBHebHWju/88LW85eaSCI/KiP2euysK2i
 Fa7ykZ9am0ANacUS0kSg7TYFM6k/DjBRjhmBRqABTk5xIGRzkQt6TCf4diIQRekXNasK
 /AZg==
X-Gm-Message-State: AOJu0YxfJfPWUv5ejjZDvW8CaxB3HT1Ao54aqw7ARZTavSyrauQys3aZ
 UEwoc2Ld4XFWqbG47dt0INHT+OpEi6q7F8UBss8uAnMOAbBdGAc41IXW0EXhbe9qhGQvAiPKDPP
 XAjJNIQa4JGHVmulEu3/BWfmsCuYcendgpodjwbWfs59mNfxRiTg3+ARe
X-Gm-Gg: AR+sD13xV+spNY0g1SQFRxjcYLN9lehW+fSxFQuZg8hzyvMEKQd07ULuAz7sZ6z0z8Y
 CHPYGp8jKWsCLzPq0b7y71mzY1upJryiJ2CjK7qJJTWXJJEkhgm3Rp4BR9WC5V2KuaP0YOTSKxJ
 olr1Ia6TfiKvBf1jsw7L1juiNGGqUSyCb/AbUdEYcoTd8xuKejlQQUodj5U/wV1Czm+MjFM/KvM
 WdpyUtpNEPGGz7yz4KC5/F0vCAXiv5nQmHCLGV1xsTwrfLo1Db2VvKhp92aiYr+rcTWCOcQh0++
 8ThpjgKKRcFQf0R2q3B9hgK7WvJrQA20KOmLQuJjdwVW1lapI5SzkkMCGBBw5PbVwkWnrQgVGEr
 plzeT/Owc8+uNGGGl6S87z6I8X3jj2WvoV0tbNoFW9QuufPgLQJc=
X-Received: by 2002:a05:622a:15ce:b0:516:d83c:edb6 with SMTP id
 d75a77b69052e-5213d2b72b4mr205193361cf.12.1784700494333; 
 Tue, 21 Jul 2026 23:08:14 -0700 (PDT)
X-Received: by 2002:a05:622a:15ce:b0:516:d83c:edb6 with SMTP id
 d75a77b69052e-5213d2b72b4mr205193081cf.12.1784700493812; 
 Tue, 21 Jul 2026 23:08:13 -0700 (PDT)
Received: from trex (182.red-79-144-196.dynamicip.rima-tde.net.
 [79.144.196.182]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49565373200sm110860865e9.5.2026.07.21.23.08.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 23:08:13 -0700 (PDT)
To: jorge.ramirez@oss.qualcomm.com, neil.armstrong@linaro.org,
 trini@konsulko.com, jens.wiklander@linaro.org,
 ilias.apalodimas@linaro.org, bhupesh.linux@gmail.com, n-francis@ti.com,
 marek.vasut+renesas@mailbox.org, shawn.lin@rock-chips.com,
 igor.belwon@mentallysanemainliners.org,
 yoshihiro.shimoda.uh@renesas.com, alchark@gmail.com,
 tuyen.dang.xa@renesas.com, padmarao.begari@amd.com,
 macpaul.lin@mediatek.com, jstephan@baylibre.com, bb@ti.com,
 j-mcarthur@ti.com, venkyada@qti.qualcomm.com,
 hayashi.kunihiko@socionext.com, dlechner@baylibre.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 1/5] ufs: decode string descriptors as UTF-16 big-endian
Date: Wed, 22 Jul 2026 08:07:43 +0200
Message-ID: <20260722060805.1428110-2-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260722060805.1428110-1-jorge.ramirez@oss.qualcomm.com>
References: <20260722060805.1428110-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Spvsk9VHr21DGZ1wXEtijm0guKhaLf59
X-Authority-Analysis: v=2.4 cv=KLhqylFo c=1 sm=1 tr=0 ts=6a605e50 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=2lELrtOEK2EaG96G7mOeag==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=JJ5SyZhPYCvuiZDi1AAA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA1NCBTYWx0ZWRfXzBbcKKHrGhIc
 KINYfWKB8Stq0BNdcwcvY/CutKutYfRLAizqdswUiNpH4iSFlCz3YF3CDgHI+smV8085KGRWcXH
 NT364x/Z6qSFQB9kY/CjHPJHD7Lv4dKX7/nnHRsyzamEH36x7Q0uadccyG3/ZCpQxaqRu8Y4nEW
 YS+9q7y0lZyZbrkn6rdNkYjl1SwUmVNCtJDHOGBoneOl/ogWp1haR/YTPPjOMU2wGMdQMVOjzu1
 kEmYqRj9oF9rqLTmZODrrlFtol9+2AtSq1hOrrZ1a44RtXdEz6myrgG0HdNaRiy2Qc4NFz/aC59
 Ynig/+A1f74X+0H8Q5A7T8OZddWkRAd6rpDV6QNRECa3IshjUwLw2VZAnN9rBMUu/yXohwSE0il
 yHalAgEOug9jmvGiYx+tq+jzImZubmSwB3OOQTGwV/xLWKGGoR8x9RUN6KvUd0aVl6nrvEYz+73
 T2D8bViSde/X1uLWD0g==
X-Proofpoint-ORIG-GUID: Spvsk9VHr21DGZ1wXEtijm0guKhaLf59
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA1NCBTYWx0ZWRfXzzSs2YViyMVN
 PqJwDvbgDFJW1cqzuzqvuM3+v0j3vo8Hjwe2IvQAdKppaEivtZf/GdH4o3Xk5GMtgzuzx4guCJa
 dnbyKh1LXfIU6Y6OGiRnOjZ4FwBdnOc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220054
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=5+SKdk5l0vR
 sov+IRkQsvEdXLkPsXugI78RVMRPCD9Q=; b=SHjcpQVGIqN7Z89JWQ8Tgp2Puso
 XA/RJ5VmVKGMnLohSg24VuXRo+BWiBUms3ac1qtua3N4zF1Ci2iLutt0FU6s8l+t
 ukaxnA9p9R3F+Y8WY1RL0f9Pa5ZjPE6oShVC/UpJp0mb8tFtL2J3tQ+6Qv1FlQoH
 U6DWAlowt+3Mh0VsKPlrfpAOwXxX2l6aRcqgWuxJnb2ZLMM7O0CYbcopEARE+ISm
 6Y0pCzPPWf4Nb+d3Qkaav3+GpZoHiU247nKY/gZkYNV5NdXyhH0HEoyLcF62ltdK
 gisqzHdp2fGWUpJ2JcPYTpbL7elbehVtRHOzZ+YrMYbK2Weeu3AETzFio0A==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784700495; x=1785305295; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5+SKdk5l0vRsov+IRkQsvEdXLkPsXugI78RVMRPCD9Q=;
 b=Uv9nmrcdQ6NFmZArwdcVC3hen++t4ptLf/pPGW8UN8pYMycUzfWe1R8iQgh0cSXYQw
 FuyAgEAYWW2f4URU3hi5KB3XCLh0skyXkSi+9fEtAf9dBxHYsewJNNoYSJ1agajkn9eI
 B4ogJzw4OOd1CERjxN2y2Eg/cH3xOOoiDFkcz13l2EX9zf25WJWvbgB1e56bFYfLWZy0
 cHybFt1ad4Cb2NKXtGhTqzIE+V6D6I6zbZPPCXbdZxZJTzENdvuPiqt/X8OQIxLClbdG
 xTaD7TxXiznkJYd3TCgx5/d4Zp8VQb2GukFhk9hVSOJhhG9QL+AftIJpcSHz5PcwGHve
 IxEw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=SHjcpQVG; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Uv9nmrcd
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SHjcpQVG";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="Uv9nmrcd"; 
 dkim-atps=neutral
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
From: Jorge Ramirez-Ortiz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

UFS string descriptors are UTF-16 big-endian (JESD220), but
ufshcd_read_string_desc() fed the raw bytes to utf16_to_utf8(), which reads
host-endian code units, leaving dev_desc->model blank. Byte-swap to host
order before decoding, matching the kernel.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
---
 drivers/ufs/ufs-uclass.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index 6a51f337e47..8f120fbbee8 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -1533,6 +1533,19 @@ static inline void ufshcd_remove_non_printable(uint8_t *val)
 		*val = ' ';
 }
 
+static inline void ufshcd_str_desc_to_cpu(u8 *desc, u32 size)
+{
+	u16 *p = (u16 *)&desc[QUERY_DESC_HDR_SIZE];
+	u32 len = desc[QUERY_DESC_LENGTH_OFFSET];
+	u32 i;
+
+	if (len > size)
+		len = size;
+
+	for (i = QUERY_DESC_HDR_SIZE; i + 1 < len; i += 2, p++)
+		*p = be16_to_cpu(*p);
+}
+
 /**
  * ufshcd_uic_pwr_ctrl - executes UIC commands (which affects the link power
  * state) and waits for it to take effect.
@@ -1765,6 +1778,8 @@ static int ufshcd_read_string_desc(struct ufs_hba *hba, int desc_index,
 			goto out;
 		}
 
+		ufshcd_str_desc_to_cpu(buf, size);
+
 		/*
 		 * the descriptor contains string in UTF16 format
 		 * we need to convert to utf-8 so it can be displayed
-- 
2.54.0

