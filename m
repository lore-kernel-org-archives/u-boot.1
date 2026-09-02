Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91DB3C61DD6
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 16:40:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AB94C40819;
	Wed,  2 Sep 2026 16:40:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uX2F5JnK7t0d; Wed,  2 Sep 2026 16:40:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788367217;
	bh=FJype9nu0IYgujwqbBBn87MFrL25ncV0/1JgfDxBQLU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BRCyDQD+sVbcn2Wbcvry1VH/oCPVjRhFkfEAPQMzDQpzeNRtPswt3S80p2vB/BtUl
	 5EyZinZtWZj8MKDLhnhq3LHExdkd+b55HytqNR48oGjxK+GveJh174N41rATW6+79u
	 Ocg/cwrvydZnaDFp7JK9u7go3epU0w3snX9dUol1uASTcWats0dKXxz4UT+K/hM4l9
	 jaDY6kkZAXwbvO5jVO3e+RGGL7qI0pRqLsrU4n5AY3xvILPXRZYp0v7qh64KXSQq8m
	 F31sHdeqHuVIxEIFPfBQ0PhRWmRs8rc1S3QROLZwswWZWIgzlYtlcA+zugDo9r3Z5O
	 rbTUA88ETkpzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9F5D040815;
	Wed,  2 Sep 2026 16:40:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 76FBF2B2
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 16:40:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5C9AC40815
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 16:40:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MtAizC8zi85j for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 16:40:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=REdLEbUS; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=d932JqP2
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3DF1C40810
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 16:40:13 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682FZ9G11967771
 for <u-boot@lists.u-boot-project.org>; Wed, 2 Sep 2026 16:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=FJype9nu0IYgujwqbBBn87MFrL25ncV0/1J
 gfDxBQLU=; b=REdLEbUStWcZpF1qdDI7354WSWOvRu7qe53tAV+k77klh7km89g
 dj78/5g65cOsAkqoe4mdr4iUyrfvHKXGMDGQXK/skMxq/SxRhgYd+BTv4+W1/uIc
 QfQ3aE25qTVjuQLIphrsVSORkRc2ozKrmbxPLkoW92fhIg7Uslu3i6nvTBIZawtq
 PcuZdIoHVxhd+GbHycktYkYVX+Rg3FVM7NRy4TaoXGZsganohFrkLV5wQs+yojuW
 eNFvyOAEDET+5i+kaummOFsNSKE4F5SpSHLIxEmLgfboJBCT9NxZv9besPzdx6xh
 QHzHG5f8uFx8C6kv8I7h7jXxYx2p7iC/a3g==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gej2c9fnj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 16:40:12 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc1d85c012dso2251909a12.2
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 09:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788367212; x=1788972012;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FJype9nu0IYgujwqbBBn87MFrL25ncV0/1JgfDxBQLU=;
 b=d932JqP23/qZrvNuHVls3Pgp1gHaLJ9WhGlx06j4yEdphNC0Q7RdS+c/3cv8q7JgPf
 HE4+3B272gXbD6DbyIrEUZzqZw7W1P+vbgYi7CQPseWXJ1OQOJfF+tj0L163idYZSj8R
 gck1KCf58Lg+bUOefAC+ao7szFlPerjsyfhkghm9/daz+ChSiEHGp5m8YMHO3HFP38UD
 bDTVeSzAZG0cEcQxq3hqaGipGWwEVNKS4XgywbdHKnuMHW0I8F3gTyP77yNdlqqHm5Pd
 TYw6CdljyajMnT3bnSdr42gtG2fosRoz65FSB/JBAoK149xCyrKPvthbCXjtv1HGS7YB
 DgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788367212; x=1788972012;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FJype9nu0IYgujwqbBBn87MFrL25ncV0/1JgfDxBQLU=;
 b=GxNPuSyERSZ4Vpzb86W4Bx8Q36WRkj/tHAp9PB2fplt3MeYcoxpbt0dJ68eoIyvdC8
 xm0/5dLFhuMfcB+ELZ1B3tE3qkLn13oM1wK1R1YZwTP5JLzCvl7hkN1SObkRc9fa6nKk
 +JVc1Ag0G0u7CKG3B4sAD1OQqHJY8NZC9XbSWGFDAI9NrKY8DGT0PQ/pQcXMgm3wPdM2
 IgtF+YrHy4BG9GWSi34eXHDN3hrzd1FU71Vt/7bZqMyhcPy/AWaYBBj1D9dyfqYnGtUB
 rBtLX60TyOWaRP436B+OrZ6OKd0dfMBjQvdkU4bRi0V5tIMKMjd4TjgioVlXxIvAoC6s
 Q/eA==
X-Gm-Message-State: AFuF++kv3ALgFuzZkBBomIsnQgXmjKyKZg6UHGcE5VD19XRnL09IrGtB
 QtO1LeEmesgjyO7EG1tuKIStzhoI2naos3LYUZYbPTOyHoQ46A9zkS8Dfwvxe1wtLjWKyJFffSQ
 RIsown8Un1dfw6t+2IaZ4HtNOZ/bk3w65yoAeUMCVa+w/55I83U8iCwxzGlaVTSkNGM4k/XL3ty
 qQAro=
X-Gm-Gg: AYBFou2xhfDCw+ZNpHZ6gG8r0vBzXgQW9hanJDbB/k9Ias4WTo6TxYTr9T9wY2KS334
 FmlYQ329LtH4M2daTZ6o2yJHD2TKr4WKCUmLKvDfVwXu8HE2YuWc1e5BIBtwxa+ewvWXWJRSJz1
 8n65LwWS+NKHPQIezLjpiyflYzW9USgPy3v9NNZd0mA5hLeZdEgIw0vOecZ+HAn+O1I7WlGbpNi
 Kblrrnxu2Qz+7dedS0lXiydD1sRan0cQPQ27HQ8ch5z0MbRAW5ofQMrk++YXda6vSp911ENSmc4
 z3AOVw1DnXtYkNsZhU6pJyJ9lfyItx0MMENyi3XIuzJsr0dv3HQunNIwbic251CifTFFiKDD2a4
 usHlSg5+G5IGUpEwvQGI0SFIHrkoUmlz32PnA05RuNMr7QegsaymO5bBtnPVo1gM0MQROWz/AVd
 QacsqRTYzUpa20/x3tWaylBh/QZ/Fz
X-Received: by 2002:a17:90b:3985:b0:398:bc52:825b with SMTP id
 98e67ed59e1d1-39aee22218dmr7254204a91.21.1788367211569; 
 Wed, 02 Sep 2026 09:40:11 -0700 (PDT)
X-Received: by 2002:a17:90b:3985:b0:398:bc52:825b with SMTP id
 98e67ed59e1d1-39aee22218dmr7254124a91.21.1788367210992; 
 Wed, 02 Sep 2026 09:40:10 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1430e8c6fcbsm12933927c88.0.2026.09.02.09.40.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 09:40:10 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: [PATCH] u-boot-config/domain-map: Add Qualcomm domains
Date: Wed,  2 Sep 2026 22:10:06 +0530
Message-Id: <20260902164006.1719873-1-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE0NiBTYWx0ZWRfX+dbZCNxEd5e0
 Dr0MuI19s8JNMIHqleIoBtvcwypD3Zc1B4H21vuZSIwlQ2pCnL+KT8IC3/vqhZEqe6SC64fpIyR
 kvwjFCy7UjmGur0UF9ReWdQ7WtMGtLM=
X-Authority-Analysis: v=2.4 cv=G+ss1dk5 c=1 sm=1 tr=0 ts=6a98516d cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=yPCof4ZbAAAA:8 a=D_SbEOMbAAAA:8 a=dlI4R5ZWAAAA:8 a=alK4_DS-AAAA:8
 a=voM4FWlXAAAA:8 a=q4EbjTsoAAAA:8 a=esMgTZ_AAAAA:8 a=Eu3THEkdAAAA:8
 a=ZUspVpn8AAAA:8 a=COk6AnOGAAAA:8 a=mNtOeJMeAAAA:8 a=iAFBedzOAAAA:8
 a=KT5DMVwHAAAA:8 a=ffc_oyir8pEg7wEa3GAA:9 a=3WC7DwWrALyhR5TkjVHa:22
 a=Pp_2e9zuwDcBULsfUjaf:22 a=_Et68LT86lDbNqPJMOLW:22 a=rOCknGvZllDBBwZ8Yz5I:22
 a=IC2XNlieTeVoXbcui8wp:22 a=uNhm6R9DS5Qfov_5BjUx:22 a=91EuRUVwvQDZu5d2EpNN:22
 a=HjarTRYKmK9vqEerbgQS:22 a=0UidKOZYlGDRLaJBBQYF:22 a=TjNXssC_j7lpFel5tvFf:22
 a=_FGNsZxrd-dVGcz-3RuP:22 a=-9PEDyzq7e7TNty0XWlh:22 a=4TA6af0zd5UJHFvUsFuP:22
X-Proofpoint-GUID: zqBBq3vcT5GygXnP6CPve6YAnCJuDQtE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE0NiBTYWx0ZWRfX++bMHySQ4Yj9
 KBCmBTVXdMZ5fuwaXwa3cq1loGU42ti21zVEXaCFdSefbk35f0i+gTTBbeEcxtsrS8NT8O/e4uO
 G+qK7dD9KnaZa5XaZvuFLTiWntb4j0lcAVsl6necAo3o7BYz0ZvxFAvYPmux8wJSd+HYqppqwor
 XofTq5bncprEduEJPIXfzvjSV4puCbbr6qMZvFhKERJhf3cd6g27cIscRWFezLZe8xJZVFW7IWB
 VkK7CimerNMgu3LDTRv0QJ8+2K3YE8ZhJ1GoWSYTM3FSXgCJxkNjyHmXXqC7cfQIhnV54nz5AFR
 ddjDaBQPFIegM9eyzDitx0GpmwrmJzsmsx+KKnnfvSPLjD2Ga3vzhmT5wwbrPRtQRma7xYA/sGC
 kPU9spGwRSA1ZR6U9Ri9zKqAN5/I+35ubVvDw2lt37H21sC9piXHZcWQHCIt4F4rpc1EmxHO59N
 2in4Dd45xoRyutBuKJQ==
X-Proofpoint-ORIG-GUID: zqBBq3vcT5GygXnP6CPve6YAnCJuDQtE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020146
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 u-boot-config/domain-map | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/u-boot-config/domain-map b/u-boot-config/domain-map
index 0d2dbae..73f476b 100644
--- a/u-boot-config/domain-map
+++ b/u-boot-config/domain-map
@@ -252,6 +252,7 @@ oracle.com		Oracle
 ornl.gov		Oak Ridge National Laboratory
 osadl.org		Open Source Automation Development Lab
 osdl.org		Linux Foundation
+oss.qualcomm.com	Qualcomm
 ossystems.com.br	O.S. Systems
 ovro.caltech.edu	OVRO
 ozlabs.org		IBM
@@ -278,6 +279,8 @@ protei.ru		Protei ltd
 psyent.com		Psyent
 pwav.com		Powerwave Technologies
 qlogic.com		QLogic
+qti.qualcomm.com	Qualcomm
+quicinc.com		Qualcomm
 qumranet.com		Qumranet
 rdc.com.tw		RDC Semiconductor
 realtek.com.tw		Realtek
-- 
2.34.1

