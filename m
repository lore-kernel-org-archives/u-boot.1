Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C74EC25B78
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 16:16:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A36F8850D;
	Tue,  4 Jun 2024 18:16:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=collins.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collins.com header.i=@collins.com header.b="QZ0vf8mO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D91187D46; Tue,  4 Jun 2024 18:16:28 +0200 (CEST)
Received: from mx0b-00105401.pphosted.com (mx0b-00105401.pphosted.com
 [67.231.152.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07F15884EF
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 18:16:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=collins.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=brandon.maier@collins.com
Received: from pps.filterd (m0346902.ppops.net [127.0.0.1])
 by mx0a-00105401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 454D2lAA018429; Tue, 4 Jun 2024 16:16:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=collins.com; h=cc :
 content-transfer-encoding : date : from : in-reply-to : message-id :
 mime-version : references : subject : to; s=POD051818;
 bh=sehCcUXVxz+5bAv1bM5Ca63k2VPgW9ZPXF5bmL+IAKA=;
 b=QZ0vf8mOusX6462zVQlFXaXNYM0ZVmfYzHEU4dA/jrZnJBKu03puSDkvEHFIzIWvORdK
 NtLa+AsTsCMgpWNEESb/1HFdrW17+UhxfgUtv+8NJfR+rWtYJYJLFFdwexYwz+oKLrY3
 /279uBvAzOCt3zPKKlNxdQsre8Q/sAkgnBZQfjzgn648w0k0eE1dscTX4BnHPyzlBQw/
 QbqZJpFPdce//kGTvBxRfXMYf53/FcwaKd+zCvtPBC2awnDBQb/syjLh3OeIt+ALILE0
 NueVYCd1miTWbhDkn9vN1l7Bwc3ouKYbxR7rxLRrOgaSorYRejByOC2tmXw6f9d7N7yc GA== 
Received: from xusxph009rp050.rtx.com (xusxph009rp050.rtx.com [128.13.125.147])
 by mx0a-00105401.pphosted.com (PPS) with ESMTPS id 3yhxxcd7ns-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Jun 2024 16:16:24 +0000
Received: from xusxph008rp020.corp.ray.com ([128.13.124.224])
 by xusxph009rp050.rtx.com (8.17.1.19/8.17.1.19) with ESMTPS id 454GGMRw020302
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 4 Jun 2024 16:16:23 GMT
Received: from ciulimr02.rockwellcollins.com
 (snat-utc-mailhub.rockwellcollins.com [10.172.224.19])
 by xusxph008rp020.corp.ray.com (8.17.1.19/8.17.1.19) with ESMTPS id
 454GGLC1013086
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 4 Jun 2024 16:16:22 GMT
X-Received: from bspbox.kirk (unknown [10.148.204.208])
 by ciulimr02.rockwellcollins.com (Postfix) with ESMTP id B4CB410029B1;
 Tue,  4 Jun 2024 11:16:21 -0500 (CDT)
From: Brandon Maier <brandon.maier@collins.com>
To: u-boot@lists.denx.de
Cc: Brandon Maier <brandon.maier@collins.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 3/3] tools: patman: fix deprecated Python ConfigParser methods
Date: Tue,  4 Jun 2024 16:16:07 +0000
Message-ID: <20240604161607.1133032-3-brandon.maier@collins.com>
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
 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040130
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=995 malwarescore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040130
X-Proofpoint-ORIG-GUID: L3Rv9sG11PuZk2feBml7SqAlZjHpzpUU
X-Proofpoint-GUID: L3Rv9sG11PuZk2feBml7SqAlZjHpzpUU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_default_notspam
 policy=outbound_default score=0
 impostorscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2405010000 definitions=main-2406040130
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
 tools/patman/settings.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/patman/settings.py b/tools/patman/settings.py
index 636983e32da..68c93e313b3 100644
--- a/tools/patman/settings.py
+++ b/tools/patman/settings.py
@@ -59,25 +59,25 @@ class _ProjectConfigParser(ConfigParser.ConfigParser):
 
     # Check to make sure that bogus project gets general alias.
     >>> config = _ProjectConfigParser("zzz")
-    >>> config.readfp(StringIO(sample_config))
+    >>> config.read_file(StringIO(sample_config))
     >>> str(config.get("alias", "enemies"))
     'Evil <evil@example.com>'
 
     # Check to make sure that alias gets overridden by project.
     >>> config = _ProjectConfigParser("sm")
-    >>> config.readfp(StringIO(sample_config))
+    >>> config.read_file(StringIO(sample_config))
     >>> str(config.get("alias", "enemies"))
     'Green G. <ugly@example.com>'
 
     # Check to make sure that settings get merged with project.
     >>> config = _ProjectConfigParser("linux")
-    >>> config.readfp(StringIO(sample_config))
+    >>> config.read_file(StringIO(sample_config))
     >>> sorted((str(a), str(b)) for (a, b) in config.items("settings"))
     [('am_hero', 'True'), ('check_patch_use_tree', 'True'), ('process_tags', 'False')]
 
     # Check to make sure that settings works with unknown project.
     >>> config = _ProjectConfigParser("unknown")
-    >>> config.readfp(StringIO(sample_config))
+    >>> config.read_file(StringIO(sample_config))
     >>> sorted((str(a), str(b)) for (a, b) in config.items("settings"))
     [('am_hero', 'True')]
     """
-- 
2.45.1

