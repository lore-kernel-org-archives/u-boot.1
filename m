Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A53EC3DA6D
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 06:50:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75F8081E72;
	Mon, 19 May 2025 08:50:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="Vokb97/c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84F1B81F66; Mon, 19 May 2025 08:50:10 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AFC6803DF
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 08:50:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J00Q4T000806;
 Mon, 19 May 2025 06:50:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=UDRzbmzqMEluaIji38eMO2
 lmDRWSOu5u87sb29hGWy0=; b=Vokb97/cO8j/nr9J1JxT5eM81ho7MmF44Ux8xz
 xju3Acil2jHBsuvangHXVOYDb5zVH8u04MVJ1I4bF6oGsuwNLEJB2pAoiC5jXTy4
 WVtCcKP6HbuL9ug+hARCDneqPSUpqag1XlePHM4PBFaeX7vyUoGTVVQOjXsSedR5
 yo0KLzAi6+kv2hWo6jTCugJQUPLZABoLXzcszQb9oP7q6ezsIw8ffkg/vlyPNv23
 Ll1WWwLLadRU1ln5P/usQzHWadRETJ+IMbI+Gea3wYphhphrysrER5b5p5aXHJjr
 WANpJ4j98jkh+EvYKY7vUweP45MeuqncHZBEqiYUjl3Iu8Gw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46pkr9u9bj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 May 2025 06:50:03 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54J6o3ZW018860
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 May 2025 06:50:03 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 18 May 2025 23:50:00 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <trini@konsulko.com>, <marek.vasut+renesas@mailbox.org>,
 <sjg@chromium.org>, <quic_varada@quicinc.com>,
 <di.gerasimov@gmail.com>, <quic_vkarunam@quicinc.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH] cmd: Flush destination buffer only if it is available
Date: Mon, 19 May 2025 12:19:34 +0530
Message-ID: <20250519064935.3832233-1-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: JwNx4jLQhVfT2O9mXTf2U2sreaC6gxNk
X-Proofpoint-ORIG-GUID: JwNx4jLQhVfT2O9mXTf2U2sreaC6gxNk
X-Authority-Analysis: v=2.4 cv=DdAXqutW c=1 sm=1 tr=0 ts=682ad49b cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=egeJB3ooJo5USmLp7B4A:9
 a=zZCYzV9kfG8A:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDA2MyBTYWx0ZWRfX5YMfOEhwPUmA
 sPsH8mc5ZND+z/JGYznlV6kOz7mnAsAP9bAX8IdURvevCvUbC8pDo9H006wqcorGETlAZSg+LWB
 LC+MP5ozXvNNt7cnqGlve1A5BKb65ovKSvJ/2UsqTtB3uu3zk/r8oLN5t0ULy+iFFTB/T/FHEvJ
 B/pWFe35LPt6KfaqfYmyfNqcL383bkqtMto20ayrsn4/hQQwmxRaYoFK5i0/XA8dB17eqUHL2th
 EqgwoNJhwNiXx9R+iwKkPsuQLr2EKcoWJejO2wM5+jBzSqjjVjRsDfSpIJAxJsTc69nmWm4pf43
 qSFoqvPBWWDhdltXkm9JKGwWR5oGa5jridkE7NazXqIDC0/LGp/vqj/AVrdwJy5CtCJkJMJgGRq
 glKCz5Z+1jORpKrRPcnJeazsUqWHpA7+ZPiHvWM684xxVnSH0wbKkxzAraDxbws7+VYU6XWT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_02,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=663 clxscore=1011 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505190063
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

From: Vandhiadevan Karunamoorthy <quic_vkarunam@quicinc.com>

There are code paths in do_imgextract(), where 'dest' could be zero.
Hence, avoid cache flush of 'dest' doesn't point to any data buffer.

Signed-off-by: Vandhiadevan Karunamoorthy <quic_vkarunam@quicinc.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 cmd/ximg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/cmd/ximg.c b/cmd/ximg.c
index 29d7c3279b3..8907b579d4c 100644
--- a/cmd/ximg.c
+++ b/cmd/ximg.c
@@ -265,7 +265,8 @@ do_imgextract(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		puts("OK\n");
 	}
 
-	flush_cache(dest, ALIGN(len, ARCH_DMA_MINALIGN));
+	if (dest)
+		flush_cache(dest, ALIGN(len, ARCH_DMA_MINALIGN));
 
 	env_set_hex("fileaddr", data);
 	env_set_hex("filesize", len);

base-commit: 1b5e435102aa29a665119430196cb366ce36a01b
-- 
2.34.1

