Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E514ECD98C5
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 12:20:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7503484704;
	Mon, 15 Jun 2026 14:19:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="M3NOWD7A";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="izw/4hhZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D84C484872; Mon, 15 Jun 2026 14:19:53 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C50DF83FEE
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 14:19:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FAqaCR270390
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 12:19:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=zRdnaoEz9m3
 7h/JHpoM0f63PNrVyMCmjwe4Ety6meQI=; b=M3NOWD7AvL8YgvvAB/ke8DFs8Zi
 0zcuTQvrMaVG53kuk8DclWA9fZZ/qEGnhWRdXhiD1JeC2J7ZVUpCBiWKvnszXAbT
 gNXykEtp1U2HmKpIBFQSCqAoAWcakI/DzqOKLuifTDtWOqMLpoSaHnDCUw5wEs8w
 fT1lN+xP0fgUGvjedFesXD89EVfB8yjzK4vQybWs7RmzktmxtIBNq1EkxT367mxG
 90vnX7M9qkYsioCbgy42zrdITNJCMwyQ0Yn9ifYpLst2HRwKEn3+kw10jLapgv/0
 taqHxRUA+Wiye+vnv+HO0muv9BNCBi2R90wL4OTbnytHz4foGOPavfkZOvg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etegurpxe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 12:19:50 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8423f3e4728so2372554b3a.2
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 05:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781525989; x=1782130789; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zRdnaoEz9m37h/JHpoM0f63PNrVyMCmjwe4Ety6meQI=;
 b=izw/4hhZCK5lwGONtYlqWOkAaqjzi33tro5SCxmuxRmoB/5SfSw0BNhlZxnKcMX0TW
 otvYBSC3yJF9u7EvJ+Eav3kXW212Ea1dTlhwPoNSQLoSbVpcIxNDMGw+kZvnHRvqwtTF
 ok+Ea+Iw8mj7J3Kj9Fg/3gwq08l3IbjdS8i4en65ETwZRTNN0kMnMFQX9Qof4VtGG4YG
 3hXPYAYZqYWCW1BzmhHXF+NsSoc1c5bohU38+afVzWa+irhNf2QSHSJVulVbQ7e9ZJtv
 2YJWW95Onp8FOHkC9pu+vd4RBK5WdHWlDQO6qmPhZnbcbz/o5GgaKWzM8w9glybnRT7W
 kXjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781525989; x=1782130789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zRdnaoEz9m37h/JHpoM0f63PNrVyMCmjwe4Ety6meQI=;
 b=GEbz46bIZamzsRWjDi+bs1NzP8TRNNqfGBDqxIBKk86zwPPcgdUokJficXEgZ2bXdv
 RFbcSm2eOhPsmgwsuRmGYYVivRQUgOhXCkOsezO2+KrqFS1lZhRCa89FzSnXrZygTU+4
 89WNLoSwkHZJkBYueXteG72hA5WJbm+ujb34zFS8sH6OdOvLG8akB4lPrp9YFnIwQ3IW
 NCzgcv3UH8erbyGR14SAYc7rQMYi7Ft+mAsQPjIaf6J6LbJIt9SiKQOD1r1cliCWvupQ
 g80RCOxCeoQPGk4LzzKylT3T4hH7D8HZmXh4RoEsH/u8wBGB6KoeDXI+KZT2PoCVhyVY
 lt9Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+c5BXFayn1GLKDHJtNo02LHRWy10W75EjaFQw93tjjKk9Z20iXkooipZCmg2Y4C3Cm2RxlyFc=@lists.denx.de
X-Gm-Message-State: AOJu0Yyu+r9y83AxNfS7cxDh7RsdEpPHO5g14reRIIJQrFFThlBHRn5h
 snUXlkzRPBy1AtqJTcT5Zxcf5KoLfTnt4cQB1DCLrKlJm4/rNYeIAM/DFvLS90+RQR3egtIZSqF
 2aB57Xry9vkuO5Q7mKfd4Ai/Ee+QVFeVB6e+pNvem+rCF5mIDgBJ5JOmy
X-Gm-Gg: Acq92OEH5D8f5vpfeVO0sJlzVJZKddCecKAiLDxZh68sr9Y8/uwJB0k7KPwglKwHZ6+
 IH3CrrXWgc/IJD2VDtyikM+rdCr57GPbYd2wamP1G8VY9TGJspmgonVWoc0lXBD0AFoEWDi1LRR
 X4HCN7CgAh2BTNLPF6jV4LZj+Fh6oB0HcYwjDLneHpRdKjT7/bMLstDfze6awArGk/DVBLMd+Rd
 I487NM4hrEPkBAv0CTNETaLPFQ/NM6fBxvrUwTMr+ikur9nrNEIda1r1kidPkudXxTBr0Xswf7s
 6dWkNHXpKtSM90my9kM3Fk9OOkbhLW6O7gR39gd9fa6Z/ii4V/ji7xXPt8xYniQ26JckwWFhgcN
 XYCLHPdKPHwIe4VfXOEu2hIaaLBqWhBvSi9LIP/P8UmnVAJsYvmWdfOUcJ2/YA36w5kp0XGCgcX
 O1lViE7iCjpl2ul4gZuA6+i2oWkokj1z1sOLNbACFw
X-Received: by 2002:a05:6a00:1f18:b0:842:74e3:48a5 with SMTP id
 d2e1a72fcca58-8434cd4488cmr13793923b3a.16.1781525989243; 
 Mon, 15 Jun 2026 05:19:49 -0700 (PDT)
X-Received: by 2002:a05:6a00:1f18:b0:842:74e3:48a5 with SMTP id
 d2e1a72fcca58-8434cd4488cmr13793894b3a.16.1781525988770; 
 Mon, 15 Jun 2026 05:19:48 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434accae18sm10434823b3a.17.2026.06.15.05.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 05:19:48 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, aswin.murugan@oss.qualcomm.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@denx.de, marek.vasut+renesas@mailbox.org,
 kever.yang@rock-chips.com, tien.fong.chee@altera.com,
 clamor95@gmail.com, jbx6244@gmail.com, frieder.schrempf@kontron.de,
 briansune@gmail.com, andre.przywara@arm.com, hai.pham.ud@renesas.com,
 dlechner@baylibre.com, emanuele.ghidoli@toradex.com,
 nguyen.tran.pz@bp.renesas.com, j@jannau.net, contact@paulk.fr,
 balaji.selvanathan@oss.qualcomm.com, quic_varada@quicinc.com,
 luca.weiss@fairphone.com, danila@jiaxyga.com,
 david.wronek@mainlining.org, peng.fan@nxp.com, me@ziyao.cc,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v1 7/8] qcom: smem: increase SMEM_HOST_COUNT for newer SMEM
 versions
Date: Mon, 15 Jun 2026 17:48:27 +0530
Message-Id: <20260615121828.1798789-8-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260615121828.1798789-1-aswin.murugan@oss.qualcomm.com>
References: <20260615121828.1798789-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfX/Yke0Vcb1mzF
 Ic00xUrycBCdktuR4ncTWBWDRUMNqyUd5wJFNuMn4Xuo7Rhbtm2desof3MMXTp+31kFZLZvuwIo
 1kUQQEn4VGbzyZA9RaQrBxeQ1NxfIwiq3SLr/U1bt18+FAsR6XSQHWj/9pXYLQk8+/LXgQXKhAR
 VXIbrT2BWraxrSgcQogTs6nOpirOOmmI82J8dFsDBzKFwdf1P/rxwXn4GoKHHbSzPvke+HpAPXC
 dHqi1wUMrrcDHaYpsenkGLK0G5WZDYuYaQBpHMgCw4Awdlt++kjKyiDdUAwlZbaq5woOvfVbXeL
 F5mov9fPd6BMA55QwMqBOBD/l3DULIYNHY/E3PxNEsTkbRcJWFPjZ+a/zmiLOBb7h0pgUqnz7Aa
 gK4sAQJDq7RvHXyrvjaHTs5Gh8vLO0m3bgPFFribWMG+rIDw5BI3YqOFNgwTLxaTbpJy6eHkqPl
 zBIPYvewmtLYnIib2gg==
X-Proofpoint-ORIG-GUID: om1yEKy-V5QiUBiIDwBww8KVZVxnBp3K
X-Authority-Analysis: v=2.4 cv=HMvz0Itv c=1 sm=1 tr=0 ts=6a2fede6 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=dluG079SF-FDyRJlmAYA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfXxpqWkSDBDONi
 0b+NlGEBclEmyuAuiidphjNpi/57l7s/sTNhvwNaZmMA2MSM040MLZU3UHz0fITOuVcK3G522Qw
 UmF/WMMWO73KfHgHov1QfV3hqNKvmtk=
X-Proofpoint-GUID: om1yEKy-V5QiUBiIDwBww8KVZVxnBp3K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150130
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

Increase SMEM_HOST_COUNT to accommodate newer SMEM versions
that support a larger number of remote processors.

This prevents failures during processor ID validation when
handling platforms with extended SMEM host entries. Shikra
platforms require a higher host count for proper SMEM handling.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/smem/msm_smem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/smem/msm_smem.c b/drivers/smem/msm_smem.c
index 7a50d5a5792..100ea086db0 100644
--- a/drivers/smem/msm_smem.c
+++ b/drivers/smem/msm_smem.c
@@ -85,7 +85,7 @@
 #define SMEM_GLOBAL_HOST	0xfffe
 
 /* Max number of processors/hosts in a system */
-#define SMEM_HOST_COUNT		25
+#define SMEM_HOST_COUNT		30
 
 /**
  * struct smem_proc_comm - proc_comm communication struct (legacy)
-- 
2.34.1

