Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F4ECC5B543
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 16:38:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A66F082B07;
	Tue, 10 Jun 2025 18:38:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hpe.com header.i=@hpe.com header.b="KlOlcvIG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9980282B26; Tue, 10 Jun 2025 18:38:51 +0200 (CEST)
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com
 [148.163.143.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9373882B07
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 18:38:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=verdun@hpe.com
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
 by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55ADflir020198;
 Tue, 10 Jun 2025 16:38:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pps0720; bh=xQZ/VrEQUmuYMWiJ9y1FibYIXiI5lK3t0RRYo
 p4hGFI=; b=KlOlcvIGXBWe+W/XeR92GGTbJYVAl3QIRMBJURanjzSbHBNDIBXG5
 SkKcIuz7wzAgdT9HoIjkGq3C7WCJDoEFndxJQxa6PiXLZnG5S47rn5/mSRu19I0b
 2xpyRujM3ll+/oMzcQMnAZT3Ns/SAxfiCGG13BBcljBPIgmjXc4T5xumkHzaUdnp
 1fU4XJzKkSfxil0JPTs388Uk2uKAx/4LJRtQB3VsdQ/ExEak7KC7pmpBIaQ13fOu
 z+J/8oksAiG2BAb+d/LWVsMW6MsULMmy1COf4vZvzbZolSg5sdLA/mk4qx4m0ojZ
 qRy2nZA+5B8qTfhBsBJcX+4iDT+Ve/6kQ==
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
 by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 476ntf9rfu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Jun 2025 16:38:46 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 6D29A132D6;
 Tue, 10 Jun 2025 16:38:37 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
 by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 25B9D80793F;
 Tue, 10 Jun 2025 16:38:37 +0000 (UTC)
From: verdun@hpe.com
To: verdun@hpe.com, jmverdun3@gmail.com, u-boot@lists.denx.de
Subject: [PATCH v1 0/1] Enhance soft spi performance
Date: Tue, 10 Jun 2025 16:38:34 +0000
Message-ID: <20250610163835.26874-1-verdun@hpe.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=J+eq7BnS c=1 sm=1 tr=0 ts=68485f96 cx=c_pps
 a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17
 a=6IFa9wvqVegA:10 a=MvuuwTCpAAAA:8 a=b96TdsHHKQmtfY91Jo4A:9 a=YFvOVtL4Ki0A:10
X-Proofpoint-GUID: e0G-fipC8eXrx3uN3WaPTCJo3_InInPy
X-Proofpoint-ORIG-GUID: e0G-fipC8eXrx3uN3WaPTCJo3_InInPy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEzNCBTYWx0ZWRfXxrVSTQj82WXS
 XrHFa73vShJ9nWTcGohU75LwQXJn793ewHUTcRpN3BnJDwnm6qMeS05p8M4lNSvgI2/z7f0BJ8f
 m3UhvSLqj+9VH1+52z5r/aL/u+ESl9OpMdgkpun/pqcnHAt51IerWsVP9IgU83oLTiSNSEZ0D+3
 qNrAdaAU66aiLhrg/jRZv82Z89AQRTOBUH7U3THyFYEl0Sf47FGCF3xx3CDWeUUsAnSXi9PARBa
 8ZDhBYWX8z50sKDioq1gDLcJjeGbPn0KaJGBt9kBo5v8e1ZZCH7jlfsds3zPG0CyBxDtR/Kxh9y
 Sm3pwwpqfHvapv0tY8F06Qg689VpGijWGTNylrol5G+1Invy1dxGZZ2wsW1nWJTbqDjzIG7GuMY
 Aelj1Sjo
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_08,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=755
 malwarescore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506100134
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

From: Jean-Marie Verdun <verdun@hpe.com>

v1
Add a test to enhance soft spi performance when delay is set to 0

Jean-Marie Verdun (1):
  soft_spi performance enhancement

 drivers/spi/soft_spi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.43.0

