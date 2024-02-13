Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75258C48260
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 14:08:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B178087CEC;
	Tue, 13 Feb 2024 15:08:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="ioosmlWL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADF6687D66; Tue, 13 Feb 2024 14:17:21 +0100 (CET)
Received: from mx0a-00176a03.pphosted.com (mx0b-00176a03.pphosted.com
 [67.231.157.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80E5487CEB
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 14:17:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ian.ray@gehealthcare.com
Received: from pps.filterd (m0048300.ppops.net [127.0.0.1])
 by m0048300.ppops.net-00176a03. (8.17.1.24/8.17.1.24) with ESMTP id
 41DBgpxq001957
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 08:17:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 gehealthcare.com; h=from:to:cc:subject:date:message-id
 :mime-version:content-type:content-transfer-encoding; s=
 outbound; bh=0Yi28sjpUCNvnSmv5o7rpMvBgKwgN41qCgMjDhqWcOc=; b=ioo
 smlWLdkEotysvD4bi7DRXrJqUnFrjxBwdm4AAXLJOCoYyKQSP0SBvX/duDoR4sPt
 FuPSKgasjjBxdq9COCCItMhHwa0RJS93YghpK1NOGOGpHCUQnWZ22u9HFGIv1eGs
 vanWGzEEte6udkzEajAYjNGsRBXYVN2mzq4qaG19r4Va4qpi9fOZsTcgGs2kOCKy
 +sL5N/OAE8dB7DUq08fYyxc2bS2GT1rOyYJ84ve6Yb08x807CF029A2YN/KKdB/D
 oEltHdDdc34jjunY3WdcGixAYC4NTsIk6RFR7PLx38n5k18u/SHIp1fcc8IufNqm
 u8amDXtottN9B9LK3CA==
From: Ian Ray <ian.ray@gehealthcare.com>
To: sbabic@denx.de
Cc: u-boot@lists.denx.de, ian.ray@ge.com, HuanWang@ge.com,
 Ian Ray <ian.ray@gehealthcare.com>
Subject: [PATCH] MAINTAINERS: Update after GEHC spin-off
Date: Tue, 13 Feb 2024 15:17:06 +0200
Message-Id: <20240213131706.64-1-ian.ray@gehealthcare.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: sey6qSQoQe56sQU3M3fnascCklROyPXj
X-Proofpoint-GUID: sey6qSQoQe56sQU3M3fnascCklROyPXj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_07,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=778
 mlxscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 clxscore=1011 phishscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401310000
 definitions=main-2402130104
X-Mailman-Approved-At: Tue, 13 Feb 2024 15:08:18 +0100
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

Update our email addresses, from @ge.com to @gehealthcare.com, after GE
HealthCare was spun-off from GE.

Remove Antti, who no longer works on the project.

Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
---
 MAINTAINERS                  | 2 +-
 board/ge/b1x5v2/MAINTAINERS  | 4 ++--
 board/ge/bx50v3/MAINTAINERS  | 2 +-
 board/ge/mx53ppd/MAINTAINERS | 3 +--
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 46ba17647f..338b7b6348 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -453,7 +453,7 @@ F:	drivers/timer/mchp-pit64b-timer.c
 
 ARM MSC SM2S IMX8MP SOM
 M:	Martyn Welch <martyn.welch@collabora.com>
-M:	Ian Ray <ian.ray@ge.com>
+M:	Ian Ray <ian.ray@gehealthcare.com>
 S:	Maintained
 F:	arch/arm/dts/imx8mp-msc-sm2s*
 F:	board/msc/sm2s_imx8mp/
diff --git a/board/ge/b1x5v2/MAINTAINERS b/board/ge/b1x5v2/MAINTAINERS
index 3196ddbb51..7312f4be1a 100644
--- a/board/ge/b1x5v2/MAINTAINERS
+++ b/board/ge/b1x5v2/MAINTAINERS
@@ -1,6 +1,6 @@
 GE B1X5V2 BOARD
-M:	Huan 'Kitty' Wang <HuanWang@ge.com>
-M:	Ian Ray <ian.ray@ge.com>
+M:	Huan 'Kitty' Wang <HuanWang@gehealthcare.com>
+M:	Ian Ray <ian.ray@gehealthcare.com>
 M:	Martyn Welch <martyn.welch@collabora.com>
 S:	Maintained
 F:	arch/arm/dts/imx6dl-b1x5v2.dts
diff --git a/board/ge/bx50v3/MAINTAINERS b/board/ge/bx50v3/MAINTAINERS
index c165048336..53a8d88a90 100644
--- a/board/ge/bx50v3/MAINTAINERS
+++ b/board/ge/bx50v3/MAINTAINERS
@@ -1,5 +1,5 @@
 GE BX50V3 BOARD
-M:	Ian Ray <ian.ray@ge.com>
+M:	Ian Ray <ian.ray@gehealthcare.com>
 M:	Martyn Welch <martyn.welch@collabora.com>
 S:	Maintained
 F:	arch/arm/dts/imx6q-b450v3.dts
diff --git a/board/ge/mx53ppd/MAINTAINERS b/board/ge/mx53ppd/MAINTAINERS
index 146a460e7e..19e4ea7593 100644
--- a/board/ge/mx53ppd/MAINTAINERS
+++ b/board/ge/mx53ppd/MAINTAINERS
@@ -1,6 +1,5 @@
 GE PPD BOARD
-M:	Antti Mäentausta <antti.maentausta@ge.com>
-M:	Ian Ray <ian.ray@ge.com>
+M:	Ian Ray <ian.ray@gehealthcare.com>
 M:	Martyn Welch <martyn.welch@collabora.com>
 S:	Maintained
 F:	arch/arm/dts/imx53-ppd*
-- 
2.39.2

