Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3384C25B78
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 16:16:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B587187FB5;
	Tue,  4 Jun 2024 18:16:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=collins.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collins.com header.i=@collins.com header.b="Nuj6Yru5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9311A88501; Tue,  4 Jun 2024 18:16:27 +0200 (CEST)
Received: from mx0a-00105401.pphosted.com (mx0a-00105401.pphosted.com
 [67.231.144.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B76D87D46
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 18:16:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=collins.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=brandon.maier@collins.com
Received: from pps.filterd (m0346907.ppops.net [127.0.0.1])
 by mx0a-00105401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 454D1sIi017972; Tue, 4 Jun 2024 16:16:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=collins.com; h=cc :
 content-transfer-encoding : date : from : in-reply-to : message-id :
 mime-version : references : subject : to; s=POD051818;
 bh=O7MXxgbkjth3MzJh2cOJ8iei4KQW0hWV1qkH3hq4VLM=;
 b=Nuj6Yru5LXrbu8PBNzVt3Y0gwPdkXWcZUDPQBdGpj6LEiQvhTw3bIESDa5YSys3ooivp
 e/UoD53+CtuoH0nOxB0ySLgvdyOM7LMixEjzw6F/tfwQVDYmxn8lHGSukhujbVUlwAmR
 WdLe0Yzs/2gmRVu6NzwjAhcQV4gszZ919izV9Kw0UvM9KM91ikr1JsN/1W2DZOa/xKhn
 AS37vf5ji8UvMQUgBAsw7p4lkdLhqx/RQsnJnw87R2oqXUGpUM0NdOCOW/C2RkzQGYnn
 379OxaV8KeTLolATvnjH9tdjCw8dtfkkHT116keQMTV1U/bgXtM53/834yD9idVPR1Zh Kw== 
Received: from xusxph009rp050.rtx.com (xusxph009rp050.rtx.com [128.13.125.147])
 by mx0a-00105401.pphosted.com (PPS) with ESMTPS id 3yhhvu2wfj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Jun 2024 16:16:21 +0000
Received: from xusxph004rp020.corp.ray.com ([128.13.120.224])
 by xusxph009rp050.rtx.com (8.17.1.19/8.17.1.19) with ESMTPS id 454GGJZh020293
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 4 Jun 2024 16:16:20 GMT
Received: from ciulimr02.rockwellcollins.com
 (snat-utc-mailhub.rockwellcollins.com [10.172.224.19])
 by xusxph004rp020.corp.ray.com (8.17.1.19/8.17.1.19) with ESMTPS id
 454GGJSW024949
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 4 Jun 2024 16:16:19 GMT
X-Received: from bspbox.kirk (unknown [10.148.204.208])
 by ciulimr02.rockwellcollins.com (Postfix) with ESMTP id 7478710029B1;
 Tue,  4 Jun 2024 11:16:19 -0500 (CDT)
From: Brandon Maier <brandon.maier@collins.com>
To: u-boot@lists.denx.de
Cc: Brandon Maier <brandon.maier@collins.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 2/3] tools: binman: fix deprecated Python ConfigParser methods
Date: Tue,  4 Jun 2024 16:16:06 +0000
Message-ID: <20240604161607.1133032-2-brandon.maier@collins.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604161607.1133032-1-brandon.maier@collins.com>
References: <20240604161607.1133032-1-brandon.maier@collins.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 spamscore=0
 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxlogscore=832
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040130
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=807
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040130
X-Proofpoint-GUID: XC-cEAoA9n0jVmiIazhDZ3LqtdmZbsvF
X-Proofpoint-ORIG-GUID: XC-cEAoA9n0jVmiIazhDZ3LqtdmZbsvF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_default_notspam
 policy=outbound_default score=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=918 adultscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040130
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

The method `ConfigParser.readfp()` is marked deprecated[1].

In Python 3.12 this method have been removed, so replace it with
`ConfigParser.read_file()`.

[1] https://docs.python.org/3.11/library/configparser.html#configparser.ConfigParser.readfp

Signed-off-by: Brandon Maier <brandon.maier@collins.com>
CC: Simon Glass <sjg@chromium.org>
---
 tools/buildman/bsettings.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/buildman/bsettings.py b/tools/buildman/bsettings.py
index e225ac2ca0f..aea724fc559 100644
--- a/tools/buildman/bsettings.py
+++ b/tools/buildman/bsettings.py
@@ -29,7 +29,7 @@ def setup(fname=''):
             settings.read(config_fname)
 
 def add_file(data):
-    settings.readfp(io.StringIO(data))
+    settings.read_file(io.StringIO(data))
 
 def get_items(section):
     """Get the items from a section of the config.
-- 
2.45.1

