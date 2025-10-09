Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35293CCD184
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 12:58:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6300840F5;
	Thu,  9 Oct 2025 14:58:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=qti.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WlNKU1NB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 291268393C; Thu,  9 Oct 2025 08:05:59 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD46A8393C
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 08:05:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=qti.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=venkyada@qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598I5cNS002380
 for <u-boot@lists.denx.de>; Thu, 9 Oct 2025 06:05:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=vwQyPEjGYUzHe+b9w4SAgoH2RmIyBuAqpk4
 PxJkeyTE=; b=WlNKU1NB9f72pjHq/r1/8hYn6OUC5dNztHwf2k2kdFBCUhIQ/T6
 rYXplK4h3tYmq0D5Ayb4COGET7utp5MyfuVRGXrG2kn/5Du4denbHQtPJXNQJoMC
 smAEA6shHRD/WIXbXbqqDWSlqbn2JxeDwHznwmPvGDvUtFZBfSpt9Xqu2wO9bpYp
 N5CQqXWIVLSL7ocPz2Bgh/rEucfpbOUz/1HhzfnquURxVfuwu8389jx0+Uzv/Kh1
 YF8aY7hU1WcXYhKzr6qB4fXG0DAOVhBZbxOW6lNwYJBgAD8YPeF+VIlcAbUKqa2X
 k+ArtfBdZEJyn55ZpeH0aEhdLjGnVJVqvNg==
Received: from apblrppmta01.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4ksnvs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 06:05:54 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
 by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 59965pQm004236
 for <u-boot@lists.denx.de>; Thu, 9 Oct 2025 06:05:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 49jvnmb95x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 06:05:51 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59965prS004231
 for <u-boot@lists.denx.de>; Thu, 9 Oct 2025 06:05:51 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-venkyada-hyd.qualcomm.com
 [10.147.253.48])
 by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 59965pjK004230
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Oct 2025 06:05:51 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4799199)
 id 271115C3; Thu,  9 Oct 2025 11:35:50 +0530 (+0530)
From: Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>
To: u-boot@lists.denx.de
Cc: venkyada@qti.qualcomm.com
Subject: [PATCH] .mailmap: update e-mail address for Abbarapu Venkatesh Yadav
Date: Thu,  9 Oct 2025 11:35:46 +0530
Message-Id: <20251009060546.1596688-1-venkyada@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX/8HwBtSHbqxD
 KGZHaEFP0jYG4J+aAXB/rBCp8LRwafpuDHVM4pHskHF0be332lXQaIsgvrLuT0BRCJl1IC+W87U
 Aq/su36Uu4UB1Ekd02Ea/McvjwhXcX9qo8QhYVhoHe2tMDKcPn8NJgDWfZMBPLsV78Vcyd/23vj
 d2+P7ecF/7IJSe1Z4KMQ6sCc41X2JYZz6IwjC6oA0AdX13YCjONI74cQbC7O+iGZ35sihCMm0tm
 2SrhZNEdgTt98aQW/xbOlRpb5j9MWmsUCaXYdBkuRLeAZouRDSd4M8byBx3mwmfVszNbpIoIr8H
 BoB6gU/f+2PYUljOtrVUOck/E7QjsSAE3cQmbNYrbf/oUxUxX5Eb9meTzIGeUDRLLvhfCX7HppX
 XOcvlsg47/q2DllLTncOhsbfERm9Sg==
X-Authority-Analysis: v=2.4 cv=CbcFJbrl c=1 sm=1 tr=0 ts=68e750c2 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=k-42gJp3AAAA:8 a=sozttTNsAAAA:8
 a=zd2uoN0lAAAA:8 a=Am4ss40yAAAA:8 a=6ohNodAXAAAA:8 a=YNz4dp2XrEg6_m3QogAA:9
 a=uCSXFHLys93vLW5PjgO_:22 a=lf-hbUz_c89dky27wAWH:22 a=0gLUg1G2xj6MhZ7RLP3J:22
X-Proofpoint-GUID: jeH7CjoLGJQgA8imb4rfMs-L9QXuMwE9
X-Proofpoint-ORIG-GUID: jeH7CjoLGJQgA8imb4rfMs-L9QXuMwE9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1011 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121
X-Mailman-Approved-At: Thu, 09 Oct 2025 14:58:33 +0200
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

Update e-mail address.

Signed-off-by: Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>
---
 .mailmap | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index f15697ca2df..f1b93d168e9 100644
--- a/.mailmap
+++ b/.mailmap
@@ -140,7 +140,7 @@ Tom Rini <trini@konsulko.com> <trini@ti.com>
 Tomas Thoresen <tomas.thoresen@amd.com> <tomast@xilinx.com>
 TsiChung Liew <Tsi-Chung.Liew@freescale.com>
 Varalaxmi Bingi <varalaxmi.bingi@amd.com> <varalaxmi.bingi@xilinx.com>
-Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com> <venkatesh.abbarapu@xilinx.com>
+Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>
 Vikhyat Goyal <vikhyat.goyal@amd.com> <vikhyat.goyal@xilinx.com>
 Vishal Patel <vishal.patel@amd.com> <vishal.patel@xilinx.com>
 Wolfgang Denk <wd@denx.de> <wd@atlas.denx.de>
-- 
2.34.1

