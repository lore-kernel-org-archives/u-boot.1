Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C20CFCD4F3D
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 15:19:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E30384707;
	Thu, 21 May 2026 17:19:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=analog.com header.i=@analog.com header.b="Xl4+GyQ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABDF4846F9; Thu, 21 May 2026 15:54:48 +0200 (CEST)
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com
 [148.163.135.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 137FC846DD
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 15:54:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=analog.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Caleb.Ethridge@analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
 by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64LDCfao416892; Thu, 21 May 2026 09:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=DKIM; bh=PaGut
 8EinJaFjrEmdzBnL6Xc/EWAW4eMVoER52fsR3Y=; b=Xl4+GyQ3cdwVifNCgN1MN
 Xda/PUkrryuX0ah1kTGezB/HEPuASAVTI3mLdrIYzoK1+aP7YNYcdCdWa7OQeldB
 tM3qxkHVle8him/b/4AmC93a62u/egvaUO0YLlNAcVFCdeHavE9nx47bs+1ACjNN
 5lin/pEcxSt+hBcQdcc+Ou5iJYmCIO549sVBKPyX0ZsvuDvl8esEw/ye+egNssLR
 DxJbFG8vyzwya2bEhk9dKrx+bBaat05CM4JdsuZORKTEUvrbGTTTXMGQt/U/+jfC
 Px/FkRhm29axRNNU7iOar33Fl4nHnK/3R53KEZXDbRIMqd1D9I9XB5D97ebVZCJq
 A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
 by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4e9e6wvkpy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 May 2026 09:54:42 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
 by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64LDsfra046913
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL); 
 Thu, 21 May 2026 09:54:41 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 21 May 2026 09:54:41 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 21 May 2026 09:54:40 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 21 May 2026 09:54:41 -0400
Received: from cethridg-sml01.ad.analog.com (cethridg-sml01.ad.analog.com
 [10.75.142.63])
 by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64LDrkqk016286;
 Thu, 21 May 2026 09:54:36 -0400
From: Caleb Ethridge <caleb.ethridge@analog.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <malysagreg@gmail.com>, <philip@philipmolloy.com>,
 <sjg@chromium.org>, <linux@analog.com>, <jcethrid@gmail.com>,
 Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v6 08/16] dts: sc594: Fix gige-reset line on EZKIT
Date: Thu, 21 May 2026 09:53:19 -0400
Message-ID: <4100784f1ddbafacb2d18bdadda9fa17de78a054.1779370141.git.caleb.ethridge@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1779370141.git.caleb.ethridge@analog.com>
References: <cover.1779370141.git.caleb.ethridge@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: I8fIv02P4nIa9Wgh7KvZZ_5clh7yes1u
X-Proofpoint-ORIG-GUID: I8fIv02P4nIa9Wgh7KvZZ_5clh7yes1u
X-Authority-Analysis: v=2.4 cv=K8gS2SWI c=1 sm=1 tr=0 ts=6a0f0ea2 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=nBfrgO8htoWmQGbQ5IAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE0MCBTYWx0ZWRfXw0o3X7z66GU4
 mgnu1axHVda3Z5heds+2DXoRqkDxGtPy2pz1boMzvghl4H8SPOHoi/HaQPMYPwDzG5HfAWZ9R3h
 P2q7F1JLsbs7n4V4y3RYYPnBwIm0zn4Gh7y9/sAcjcaOVSON9Ls6jYUjaGxxb0B3QldUT5VPga6
 XM02uEQTWEILEMjsPOcNuu0qgShmK9FJMZ6vmhbBc4NIy7sbIIIOSiTabPU1vik8+XRTgo/4FLD
 XJS/Ld4BxjAjsweaB7pviXIB1Q3CVhTxCjV43D6PmoqktMNDiW1iAhHlJyG5e3nAy7/6reqcEL9
 4HfEnMmHmo8Kw96zLo9YnVnE77Ie48qdXVC5hzHmC45O1SbFtQA1m0OBmVJEoV4jKqW21/Iergb
 Xvx3BnPorWfP1kE2GEWXdoaMuThd2ELaQ/zlgYz03+5tZWpiW8doCUUeOr8pAHKfNTrZyXz0hc1
 G/ZewfMNnq1hi+aZFlA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210140
X-Mailman-Approved-At: Thu, 21 May 2026 17:19:00 +0200
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

The gige-reset line on the EZKIT was updated for the
sc598 but not the sc594. This commit aligns the two .dts
files since they are describing the same hardware, the
EZKIT carrier board.

Fixes: be7937847b7c ("board: adi: Add support for SC594")
Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
 arch/arm/dts/sc594-som-ezkit.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/sc594-som-ezkit.dts b/arch/arm/dts/sc594-som-ezkit.dts
index dea9a6e27f2..396502b6745 100644
--- a/arch/arm/dts/sc594-som-ezkit.dts
+++ b/arch/arm/dts/sc594-som-ezkit.dts
@@ -130,7 +130,7 @@
 
 		gige-reset {
 			gpio-hog;
-			gpios = <15 GPIO_ACTIVE_HIGH>;
+			gpios = <15 GPIO_ACTIVE_LOW>;
 			output-high;
 			line-name = "gige-reset";
 			bootph-pre-ram;
-- 
2.34.1

