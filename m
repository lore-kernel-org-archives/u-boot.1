Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6EEC531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 15:56:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A555C40741;
	Mon, 27 Jul 2026 15:56:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ia_Et3OvfiQI; Mon, 27 Jul 2026 15:56:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BAC794072B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785167803;
	bh=EfhPC6DfQAGjupG3ZsFaZgjThpkMmhXTZZv2DwPuw6A=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=oKHdK8AtgpOkTSjhhK3zsyHzs8ifGYGA3tdRCd5ux0uUqbNOUf5bgxpt7wmlTOzKh
	 deOS6aEP+2bwMayN/kua+kPw0JkrLZwAqE+dDOs6P/fOf+f1t1jPXrc3lI8dXvQ4ko
	 bOQi7rmYvvz6rrcHL6R+8PVIOqr/Y8M2Z11Jv5rUna6nNzEjbpAQb6njDKD3dNmfG9
	 j9Q3bC27EAeFPSFddhes8ql8L5D/6D/tPsmCGVIqDcV1F/EbdeX/YlJEtb5mfjayJ8
	 /cFTF/zTzEKuKLV+7zQJoSVHT5H50WQ/t/bwSDwI0sKVbNWqqsi9j/TDDvefZoS03w
	 m7rxMhinCAbaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BAC794072B;
	Mon, 27 Jul 2026 15:56:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5B85669
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 15:56:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 41D5840153
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 15:56:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u8fi3NxB8Jlh for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 15:56:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 469A440063
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 469A440063
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 469A440063
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 15:56:40 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66RDlhuP4061124
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 15:56:39 GMT
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4mq1jqu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 15:56:39 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cf1c86963bso462845ad.0
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785167799; x=1785772599;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EfhPC6DfQAGjupG3ZsFaZgjThpkMmhXTZZv2DwPuw6A=;
 b=tXY0jtxnWxtzNj5ijE1hV+hrCpHhUVVcAudAycmwHmMyHsJvMUeSV0KCggB9awSrbk
 DBrjF7kFd3SHbURzJiU4KLqPxvt48mpog4+BCJ0MvfhwVyGCY3XTvtsMTtWw5sxn+1zX
 9pV+2RRRVZr3FRzjH/cLemW92Pvrp6AI3tNpRwY4CzOJs8xaNsefvjUFD+Vv1zxxX5OC
 dcI3blv4FYjaQQao8/QYRkNzOvAyD5x3YPacLDxarnRXLFaLVIqS0pRU1NgeYuEtbM7v
 B9joPLjTek8+uPI9wVO90uEYJWstXxcjHvfuGDpjlERXVkjPRPKcOPfUvd9cwoDXBoIb
 MFFg==
X-Gm-Message-State: AOJu0YwdflTZB08ADeHMsavlOo0leaaF0dwjOVyYhvzl+shkCtkPXlaZ
 P02m3X0YZOhm0EtuxKwptTA0mpDxQ7RiBF6fDxjOegmaNWkK+iqKwvFWtTEPJa8MmlYDXpUan4w
 RZExFWEHIjq1fFVWFI013UXyCFPjIrsxywhNamnJUtlerazDfAirM4tGNEYqPAKStQeHxb08+40
 Lzehc=
X-Gm-Gg: AR+sD12jqLT+cy5EA1vYQTMrgHxv8tApQd4pfCPD0/vGtzoC4GT55w34VpLzTv79L6p
 Nk/ORFI4VGZpy43EPTc9IN0Yn6tiJS4AEkyI9a+QR9FIqAFUJ3Y6WTTOaKiNQpZQb5yYn/JKSBk
 M9E+QSpKu2E8SC0B2xP1d3spvA4jxPzGV3iY55xYNahpy74SLMLYaUIYdQ1rFjghnNrZoQC72MV
 w0u3u8uIxbZEUFZ7nlwI/PIG6WMhNJiMD0fMeLnV/SdrQcWAFdp8O8RxSacor1a85TEQJxQbpFv
 Qs5uNlVy2d2AIHdj2mlELBWaV9w1iRTATBViZPNwKqolMxLV7m3ESUBy2HgbFTgScqpQne0C7vA
 0DzIUapaOgiABDs8468NbNBfKwBL4yqSpG0LvUMmsH3fH65LLeAHUYcxZM7LTj3b20FhoaZa1tM
 O+GuvMYGQxJCBPtRt42dDIYhBAEL2b
X-Received: by 2002:a05:6a20:1609:b0:3bf:9e85:b423 with SMTP id
 adf61e73a8af0-3c6c8bf6deamr12567637.34.1785167798561; 
 Mon, 27 Jul 2026 08:56:38 -0700 (PDT)
X-Received: by 2002:a05:6a20:1609:b0:3bf:9e85:b423 with SMTP id
 adf61e73a8af0-3c6c8bf6deamr12538637.34.1785167798149; 
 Mon, 27 Jul 2026 08:56:38 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc419e3asm33286941eec.11.2026.07.27.08.56.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 08:56:37 -0700 (PDT)
Date: Mon, 27 Jul 2026 21:26:01 +0530
Subject: [PATCH 3/8] tools: mkeficapsule: Enable multi-payload grouping in
 config parser
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-mkeficapsule-v1-3-5b162866b092@oss.qualcomm.com>
References: <20260727-mkeficapsule-v1-0-5b162866b092@oss.qualcomm.com>
In-Reply-To: <20260727-mkeficapsule-v1-0-5b162866b092@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785167781; l=6070;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=zHc1yYsZW2/P7ljvo0N0+173kok0VPmmq7roLdOuMCA=;
 b=qU27ls8KClyciVJfF1JP7zi2j38P8SGOv/lQFfB5i/RMzrvxB3CPMI4YX6xco8SWdYxTsews9
 uJW7ZJoYBpnBUnrv9PYbaChscp1bGseLeiheoXNTgI/gcMI6pty2Zpj
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0OCBTYWx0ZWRfX2pjZ2Nzu8Cvd
 x/f+b3K0RLtEJk58DGv12my9dHXzFX411hL154Z9109LsW6UhqMl4tq3FhySa/2aD0jWmqum5zO
 jYIig6mVOY71Uy0b7116JuZLa8T1LQ4=
X-Proofpoint-ORIG-GUID: -tq3BDsqUFYW3_WCGiJQc-TOkSe22-8k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0OCBTYWx0ZWRfX/H2WEDayXBb8
 pc+DgL21kK6Z8K+6aTU5rxhoflqrvBzm3s2zzmkl1gjznZGec0qxisj19e7hN466E0CL0sfEmCy
 7LzhDqWzOqF7TaEOheLSm8Vl0TqpiRcV81vf3BMP2TGlsf+eMsuIZlt1Kyie7QZUbGzxkQKSaj7
 lCGXBP1UfKOwJ6BaFIGPOQKJWrgZAn7NF7uQ8zSvR9aRRBqiOOX3qOnoy8fbdAdxfVCwsYfkrgg
 fKtwti1IW0bf7Vv0iqU1g5smO3iUy05jVagX70WgXkW7IbtOlO7tJZut5vE33AbxNa+qX/yamLs
 ppq9cL8kk3dm5p2bLYq05VuVnB4S2EswxFPDoJtct0B8gFF65B80WFQ4DxJ56Wjc7qXxYmk3zpC
 0pyZiLgZYsWhw2lRqwlr0JV0qLaXBUzt04aPErHoqoK2CLbq2QO7t8QQ9rHNZPjJfcOGvWYW0pt
 QqTVMozeCZO3497ztbA==
X-Proofpoint-GUID: -tq3BDsqUFYW3_WCGiJQc-TOkSe22-8k
X-Authority-Analysis: v=2.4 cv=TemmcxQh c=1 sm=1 tr=0 ts=6a677fb7 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=Gi3W0aG783zyUBqSyZYA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270148
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EfhPC6DfQAGjupG3ZsFaZgjThpkMmhXTZZv2DwPuw6A=; b=I3nAOV6tQrLob1FS
 IX2ROzr/vthsheNNv+ghQ9izifDW539ug1pKGqP2QDdreTy5MCyiwkc8cB1bjhhp
 MgiGlmdX3Rq/1+G5EqSE4pP2sUdb+BM++QFsJI3ZRg2guAJ9kycV4JVAqVu+IOM/
 MekJG5fDrU39tS880hhp5NW0Rz+jE0qVZyKvur+uDulcmzGQAt8WsJ2ATMweVDdV
 4LebK/mBRbwa//7URs44s4edWM5Yv/3VWHE/jrOhG4XWJb8fq3r80rfckBMFg3Ku
 huUjj0bIuDFm7yznkQY2RQNm/+QyijjVaf7xgrJq9EG7GAsHsjtZ3QRoHtHx2lHJ
 zVttwQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785167799; x=1785772599;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EfhPC6DfQAGjupG3ZsFaZgjThpkMmhXTZZv2DwPuw6A=;
 b=VZfBRSrU+U5ZwMd6/INOyNCWKEgsIYc7yL/nX4jgETRx3qEUCz3CycNa0jRQOcneTR
 bL85TmZg9SpRTFmPhwFmUxXrV9zOPnfO6awssvkByZwqanPgsiD4ioZz100CgcB6ZLCI
 JunIs9cr9nQ64uGlR8c3ym6h3o+JdEcvTzDFqI/LqvvOYc87Cx1akAr62KqPJKpBBBv6
 KRntRlJtnGvGGhR4HSggB6roC4hUz3ZHW1jeOglLsnHv0GVlBprc5njx6p7z3GomwTPI
 mGKAvSft6rGEOdx83PVu5nVjxSPt+s3hxy7Zfkmq3d+1Yu0nfnYUGx3nNoLBPtJ0vlRS
 DugQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=I3nAOV6t; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=VZfBRSrU
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

Extend the config file parser to automatically group multiple payloads
with the same capsule filename into a single multi-payload capsule.

The parser now operates in two phases:
1. Parse all payload entries and group by capsule filename
2. Generate capsules based on grouping:
   - Single payload: use existing generation path
   - Multiple normal payloads: create multi-payload capsule
   - Mixed/non-normal types: generate separate capsules with warning

This allows users to specify multiple firmware images for the same
capsule file in the config, and the tool will automatically create
an optimized multi-payload capsule when possible.

Example config usage:
  [capsule1]
  image-guid: <guid1>
  hardware-instance: 0
  image-index: 1
  payload: payload1.bin
  capsule: update.capsule

  [capsule1]
  image-guid: <guid2>
  hardware-instance: 0
  image-index: 2
  payload: payload2.bin
  capsule: update.capsule

This will generate a single update.capsule containing both payloads.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 tools/mkeficapsule_parse.c | 115 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 113 insertions(+), 2 deletions(-)

diff --git a/tools/mkeficapsule_parse.c b/tools/mkeficapsule_parse.c
index 12f5f04b824..4a07006e2f8 100644
--- a/tools/mkeficapsule_parse.c
+++ b/tools/mkeficapsule_parse.c
@@ -299,6 +299,63 @@ static void params_dependency_check(struct efi_capsule_params *params)
 	}
 }
 
+#define MAX_CAPSULE_GROUPS 32
+
+struct capsule_group {
+	char *capsule_filename;
+	struct efi_capsule_params_array params_array;
+};
+
+static struct capsule_group groups[MAX_CAPSULE_GROUPS];
+static int group_count;
+
+static struct capsule_group *find_or_create_group(const char *capsule_filename)
+{
+	int i;
+
+	/* Search for existing group */
+	for (i = 0; i < group_count; i++) {
+		if (groups[i].capsule_filename &&
+		    !strcmp(groups[i].capsule_filename, capsule_filename)) {
+			return &groups[i];
+		}
+	}
+
+	/* Create new group */
+	if (group_count >= MAX_CAPSULE_GROUPS) {
+		fprintf(stderr, "Too many capsule groups (max %d)\n",
+			MAX_CAPSULE_GROUPS);
+		exit(EXIT_FAILURE);
+	}
+
+	groups[group_count].capsule_filename = strdup(capsule_filename);
+	if (!groups[group_count].capsule_filename)
+		print_and_exit(MALLOC_FAIL_STR);
+
+	groups[group_count].params_array.count = 0;
+	return &groups[group_count++];
+}
+
+static void add_to_group(struct capsule_group *group,
+			 struct efi_capsule_params *params)
+{
+	struct efi_capsule_params *new_params;
+
+	if (group->params_array.count >= MAX_PAYLOADS_PER_CAPSULE) {
+		fprintf(stderr, "Too many payloads for capsule %s (max %d)\n",
+			group->capsule_filename, MAX_PAYLOADS_PER_CAPSULE);
+		exit(EXIT_FAILURE);
+	}
+
+	/* Allocate and copy params */
+	new_params = malloc(sizeof(struct efi_capsule_params));
+	if (!new_params)
+		print_and_exit(MALLOC_FAIL_STR);
+
+	memcpy(new_params, params, sizeof(struct efi_capsule_params));
+	group->params_array.params[group->params_array.count++] = new_params;
+}
+
 static void generate_capsule(struct efi_capsule_params *params)
 {
 	if (params->capsule != CAPSULE_NORMAL_BLOB) {
@@ -324,7 +381,8 @@ static void generate_capsule(struct efi_capsule_params *params)
  * @cfg_file: Path to the config file
  *
  * Parse the capsule parameters from the config file and use the
- * parameters for generating one or more capsules.
+ * parameters for generating one or more capsules. Payloads with the
+ * same capsule filename are grouped into a single multi-payload capsule.
  *
  * Return: None
  *
@@ -333,6 +391,8 @@ void capsule_with_cfg_file(const char *cfg_file)
 {
 	FILE *fp;
 	struct efi_capsule_params params = { 0 };
+	struct capsule_group *group;
+	int i;
 
 	fp = fopen(cfg_file, "r");
 	if (!fp) {
@@ -343,11 +403,62 @@ void capsule_with_cfg_file(const char *cfg_file)
 
 	params_start = 0;
 	params_end = 1;
+	group_count = 0;
 
+	/* Phase 1: Parse all payloads and group by capsule filename */
 	while (parse_capsule_payload_params(fp, &params) != -1) {
 		params_dependency_check(&params);
-		generate_capsule(&params);
+
+		/* Find or create group for this capsule */
+		group = find_or_create_group(params.capsule_file);
+		add_to_group(group, &params);
 
 		memset(&params, 0, sizeof(struct efi_capsule_params));
 	}
+
+	fclose(fp);
+
+	/* Phase 2: Generate capsules */
+	for (i = 0; i < group_count; i++) {
+		group = &groups[i];
+
+		/* Check if all payloads in group are normal blobs */
+		int all_normal = 1;
+		int j;
+
+		for (j = 0; j < group->params_array.count; j++) {
+			if (group->params_array.params[j]->capsule != CAPSULE_NORMAL_BLOB) {
+				all_normal = 0;
+				break;
+			}
+		}
+
+		if (group->params_array.count == 1) {
+			/* Single payload - use existing function */
+			printf("Generating single-payload capsule: %s\n",
+			       group->capsule_filename);
+			generate_capsule(group->params_array.params[0]);
+		} else if (all_normal) {
+			/* Multiple normal payloads - use multi-payload function */
+			printf("Generating multi-payload capsule: %s (%d payloads)\n",
+			       group->capsule_filename, group->params_array.count);
+			if (create_multi_payload_fwbin(group->capsule_filename,
+						       &group->params_array) < 0) {
+				print_and_exit("Creating multi-payload capsule failed\n");
+			}
+		} else {
+			/* Mixed or non-normal capsules - generate separately */
+			fprintf(stderr, "Warning: Cannot combine non-normal capsules. ");
+			fprintf(stderr, "Generating separate capsules for %s\n",
+				group->capsule_filename);
+			for (j = 0; j < group->params_array.count; j++) {
+				char temp_name[256];
+
+				snprintf(temp_name, sizeof(temp_name), "%s.%d",
+					 group->capsule_filename, j);
+				group->params_array.params[j]->capsule_file = temp_name;
+				generate_capsule(group->params_array.params[j]);
+			}
+		}
+	}
 }

-- 
2.34.1

