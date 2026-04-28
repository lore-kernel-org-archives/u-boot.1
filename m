Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A353FF885D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 07:32:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ECFC84658;
	Tue, 28 Apr 2026 09:32:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bqoO/3vf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CTAGmqWU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2046984657; Tue, 28 Apr 2026 09:32:34 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D40A483FB5
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 09:32:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63S3kSns2112686
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 07:32:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4tTgkmkCWwNMQKBkIPN9IIDo/9S8e7nQ/BFZ9cRqAf4=; b=bqoO/3vfbZ9DmHNb
 5d68RgsSg4rBIowRxl1L78UReDM8aFPN8WAWa5Dbbueezlss6W78+4gLxEIdrTCt
 QccgQeh4RVyonevL0v5+4t+OGXhSsYJAQsuh9oxSpR6rKSHQ/ctzpJ0BcGolyEmp
 uPTwtVw9ktXWwxsJb60HTANuv0tC3TuMtigIG2LFjX2Z4wvK05PgAqyL6akRVydG
 +iHhWO08nsLqAoNHCNNeUeh0BkpEtPl9WF/d3u2zBJrJDN5xi69UwTCw8PrxAfdj
 hZRkd5kuPMXpCQpENbjc5oJaxcnDJpezATXKBSJMYCfnRHEpXVLDuA5HXgCMe9IF
 2hXsqA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtdmbjck4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 07:32:29 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b2e91add2aso14055295ad.1
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 00:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777361549; x=1777966349; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4tTgkmkCWwNMQKBkIPN9IIDo/9S8e7nQ/BFZ9cRqAf4=;
 b=CTAGmqWUNz6ykilf6DE2AIZXFWglTsgJn8rbNshecelIZsQ6akC8gd7svrAIfyYTjF
 wqMYKKpZHJaDuGowOJR8M4rn+Cv81YW1JFNMC3IXSc5oDyVEeurxURQO16zhnPLFmZxQ
 UX/CwGGGQSVOZMuTubMKAP+ZJEbvloq38/3uRQgClpLst9qoAABWU8UZW6qZ/3/KnKKs
 8f7kKzAX7psm15n3geDAZvKaU5TmTmSqE5qF5AKSpzBilLPi168qDADX4fMKY0BREn4L
 OamRSvgW7MUy/hDmkvPMVnpxxH5q02B7XHjzJsewWd78+xoC44BbBx1iedrQQ+hRbFoF
 M2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777361549; x=1777966349;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4tTgkmkCWwNMQKBkIPN9IIDo/9S8e7nQ/BFZ9cRqAf4=;
 b=aL/4i978XmXdMkKf18HrVOYrL/G9+N7CQdB4B5OY4k/PRwAGDUDGguxOWJuN3qF0wG
 pCAu4VPAPm4+mZGK6ySH058YkmP2CU5hsEC0LuQ8HzOt0kOZFMhA9D/SnAQ3AwhfNFj0
 yfSudIHmDc7O/OLZMCXXRBPT7hDmAdmNC/M85h9v0YpmM6LpzUrn4LxiW8qoVdkC5igA
 SVej/hzl+zn52KF/4Ut4XbSySLogzpx/TJDMqUEgkmIs5HCPDecjRqaVUvFo12gqb84H
 /4ulKeJ6H7+PatxtxCPeZhz+T0nmZp5CxHq70qQkwxd8tI7BGN7M84FY3wVLvRmLU/qE
 7Erg==
X-Gm-Message-State: AOJu0YzvrzHX62aun7Pu1IGb+nWt2712CU91/bJFex6B6S34gg8yBMnk
 74IuuQKye74wck70DVue7LIDEGiDc61AGbv4FZ/GpM1Ej2RGaMsVJEM2QLrydwCYpbwqq+DVOny
 KPomT0NFZcXRjLYQ0wR/pKe21A27MuuGV3W1EGTx2YKHm89kOiuLKjloG
X-Gm-Gg: AeBDiev3nUOeHvW+j3Qe86xTC8ztmgyJILEbp3XI/YJKje12ebU3KMfbG8L3CVkhZQE
 LmBiNpYrdeQMEDnRbZoyrdNuCshb0z9rO0/SLpOamCl+ooI5jsuilN+DKXkmx0+4+SYvxiGfYtP
 5RXqJmYvevOmy5mGdTgNNl8ySnUKySv1z9ufWjsw/4AQtD55amaPHRp+AlSqASyT2/LYin47AVC
 Nr20jcoqLcR9vmmkLYo9qW7rivcxD1zWPRuuZ4iRN7IAQa8tufB5c0bTWyQvqy9R13xW/xxaGHK
 FbuksM24W+VsJuitC4GY2K6m9p3TM34ABly1jtVJnEfbFyJai1Ip+q+AUTqPoqvOBLlZL2IjPJA
 NCeItfXaXEU5Mv9VlGspzoJZJDbZg+ze3C2CF2S9ZxRDpCm5FHUG3QWTGEFlCgr0lvGgDU9GmLj
 E+1YPtAKsImdLCoZx5jvrAzsq2XJoXkXtVglFF/Pg1oMmtP2qPG00N17R2xURC
X-Received: by 2002:a17:903:32d0:b0:2ae:8253:1452 with SMTP id
 d9443c01a7336-2b97c3f6883mr20224695ad.11.1777361549315; 
 Tue, 28 Apr 2026 00:32:29 -0700 (PDT)
X-Received: by 2002:a17:903:32d0:b0:2ae:8253:1452 with SMTP id
 d9443c01a7336-2b97c3f6883mr20224375ad.11.1777361548803; 
 Tue, 28 Apr 2026 00:32:28 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b97aabaecfsm16054405ad.36.2026.04.28.00.32.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 00:32:28 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 13:01:46 +0530
Subject: [PATCH v4 4/8] env: scsi: Fix ENV_SCSI_HW_PARTITION default value type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-type-v4-4-b7051dc45a88@oss.qualcomm.com>
References: <20260428-type-v4-0-b7051dc45a88@oss.qualcomm.com>
In-Reply-To: <20260428-type-v4-0-b7051dc45a88@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Javier Tia <floss@jetm.me>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, David Lechner <dlechner@baylibre.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michael Walle <mwalle@kernel.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777361510; l=808;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=yFPA4vVoA1gqMQT36ZAMnHRVHWkTYJ9li13/7jEwVNU=;
 b=zG9BuOn+XlWekJ6Jy7qNCPHlQrQY2Shn44gHnitzcjjUF7xNxd5CQZC4jh8RwTnkOagBfC6yl
 rVKQjSzb4AQAvJap8HqIx3O0npnA1i5pKOYOIyiP3erdfO00lDVhD1I
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: 6HSz_tJXmdcd4qPMrejokoq1oer-c3mn
X-Authority-Analysis: v=2.4 cv=PcrPQChd c=1 sm=1 tr=0 ts=69f0628e cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=cm27Pg_UAAAA:8 a=EUspDBNiAAAA:8 a=wm42RT4n-9NobrmUzRcA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: 6HSz_tJXmdcd4qPMrejokoq1oer-c3mn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA2OSBTYWx0ZWRfX+B0klA4Co1Vy
 t3u6XQHeM0H+Wga2a4CkTICNdkvdWONhiKpz/GE/YRbbNsqFAqTNVVACVb17RP2ozfqKmr5xg47
 EdoISG9MtCU0tsQWK9SU67ND++dCbVBQiVn/iTYdFkiMcD/KzrIrTXHx3uDXfroIZF6EPHurCdy
 bZYXgWwEPl45IoUZp1e4gp+22gNeFoOC0olG5ehv/0PoV5BdZycNBVfSXY7oXkw833cC9qGCqFA
 Z6/DYnotDAcCmDVSWQ+AyTXnXmneJ00iit+QwaN1q+fTIVo/PyDum5db71HzuOc04wwrzbmKRgX
 d5UmGB7MqQK9w+ojrOAy1VWlOyuP8ES0r4GkOp7TyCqZrAcAsKP5udwa2e/J+loQssnsowm8agr
 Q7SfmsbxbTbGYdnipLuWrldk0nj/LkKuoJoKqLBy6rB2XNrUzynZzzVgJCUt7CuV8m9UcpdSwgd
 MwJxZ1A0dP1jJkvkXsg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280069
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

Change the default value from integer 0 to string "0" to match
the string type of the configuration option.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v4:
- Newly created in v4
---
 env/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/env/Kconfig b/env/Kconfig
index 7abd82ab6f3..71a27894f90 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -783,7 +783,7 @@ config ENV_MMC_USE_DT
 config ENV_SCSI_HW_PARTITION
 	string "SCSI hardware partition number"
 	depends on ENV_IS_IN_SCSI
-	default 0
+	default "0"
 	help
 	  SCSI hardware partition device number on the platform where the
 	  environment is stored.  Note that this is not related to any software

-- 
2.34.1

