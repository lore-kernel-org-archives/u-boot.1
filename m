Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61408C2BD09
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 17:52:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6E5288655;
	Mon,  1 Jul 2024 19:51:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=collins.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collins.com header.i=@collins.com header.b="oVNAJq6S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E54488670; Mon,  1 Jul 2024 19:51:57 +0200 (CEST)
Received: from mx0b-00105401.pphosted.com (mx0b-00105401.pphosted.com
 [67.231.152.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02AA3884EA
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 19:51:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=collins.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=brandon.maier@collins.com
Received: from pps.filterd (m0346905.ppops.net [127.0.0.1])
 by mx0a-00105401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 461GgUQw003281; Mon, 1 Jul 2024 17:51:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=collins.com; h=cc :
 content-transfer-encoding : content-type : date : from : message-id :
 mime-version : subject : to; s=POD051818;
 bh=0fFMdJubBrm0YGhJleljHoyLgsWewSrIYcJzJAea5MM=;
 b=oVNAJq6SD/swMkWsDox7rr+VyhMYoHtoilHje/x7nSeFxwCocWvqHH6s4jUy0hzaGq1A
 lMZt+RNKx4H5m8+oCCt/eZAWzyxi+LgLyJ4+cHghPua5KsWS7mEMtCWYUOJZAZR7Ss83
 yPAUvVk3wgZuX9/Lcm20OwJ2d3twPaDlnPjardZG4qTqXMa4kUzYGpBfp01IfTOjL/Mp
 Y3iwPzelZMzW5wI/Msac0DozrMDFgyZYLK7eZr8Hm2+xIoc6KEkYBUmy4pb6qP8fStHa
 z4ASQ2E/tXDFBJFNxfR3IFfvBh5WaptUFVhfkJ6lKokYJJu9iSOV8/SNQmNYIosscTCB Dw== 
Received: from xusxph004rp050.rtx.com (xusxph004rp050.rtx.com [128.13.120.147])
 by mx0a-00105401.pphosted.com (PPS) with ESMTPS id 4027mx7rrs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 01 Jul 2024 17:51:52 +0000
Received: from xusxph004rp020.corp.ray.com ([128.13.120.224])
 by xusxph004rp050.rtx.com (8.17.1.19/8.17.1.19) with ESMTPS id 461Hppkx032703
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 1 Jul 2024 17:51:51 GMT
Received: from ciulimr01.rockwellcollins.com
 (snat-utc-mailhub.rockwellcollins.com [10.172.224.19])
 by xusxph004rp020.corp.ray.com (8.17.1.19/8.17.1.19) with ESMTPS id
 461HppQ8013486
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 1 Jul 2024 17:51:51 GMT
X-Received: from localhost (unknown [10.148.204.208])
 by ciulimr01.rockwellcollins.com (Postfix) with ESMTP id 1D3FF300042F;
 Mon,  1 Jul 2024 12:51:51 -0500 (CDT)
From: Brandon Maier <brandon.maier@collins.com>
Date: Mon, 01 Jul 2024 17:51:41 +0000
Subject: [PATCH v2] tools: patman: fix `pip install` with Python 3.12
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240701-python-3-12-fix-patman-license-v2-1-7de3d039e6ac@collins.com>
X-B4-Tracking: v=1; b=H4sIAKzsgmYC/0XNywqDMBCF4VeRrDuSifHWVd+jdBHjWAd0IomUF
 vHdG7rp8oPDfw6VKDIldS0OFenFiYNkmEuh/OzkScBjtjLaWN1qhO2zz0GgAjQw8Rs2t69OYGF
 Pkghq7Hok0w04NSpHtkh59Tu4P7KnGFbY50jun220xabCypaItm9rAwhDdDIGKVfHFG8+LAtLK
 n1Y1Xl+AeV7blG1AAAA
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Brandon Maier <brandon.maier@collins.com>
X-Mailer: b4 0.14.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_17,2024-07-01_01,2024-05-17_01
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_17,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0
 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407010134
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407010135
X-Proofpoint-GUID: F_q-qnlRr_Fg74rA9FvPs67cGBjLSO9r
X-Proofpoint-ORIG-GUID: F_q-qnlRr_Fg74rA9FvPs67cGBjLSO9r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_17,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_default_notspam
 policy=outbound_default score=0
 priorityscore=1501 malwarescore=0 clxscore=1011 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407010134
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

Installing patman with `cd ./tools/patman && pip install -e .` fails
with the error below.

As described in the error output below, the license line is not allowed
to be only defined in the setup.py. We remove the 'license' field
entirely, as the Python Packaging User Guide recommends using projects
classifiers instead[1] and we already set the GPL-2.0+ classifier.

> $ cd ./tools/patman && pip install -e .
> Obtaining file:///.../u-boot/tools/patman
>   Installing build dependencies ... done
>   Checking if build backend supports build_editable ... done
>   Getting requirements to build editable ... error
>   error: subprocess-exited-with-error
>
>   × Getting requirements to build editable did not run successfully.
>   │ exit code: 1
>   ╰─> [61 lines of output]
>       /tmp/pip-build-env-mqjvnmz8/overlay/lib/python3.12/site-packages/setuptools/config/_apply_pyprojecttoml.py:76:
>           _MissingDynamic: `license` defined outside of `pyproject.toml` is ignored.
>       !!
>
>       ********************************************************************************
>       The following seems to be defined outside of `pyproject.toml`:
>
>       `license = 'GPL-2.0+'`
>
>       According to the spec (see the link below), however, setuptools CANNOT
>       consider this value unless `license` is listed as `dynamic`.
>
>       https://packaging.python.org/en/latest/specifications/pyproject-toml/#declaring-project-metadata-the-project-table
>
>       To prevent this problem, you can list `license` under `dynamic` or alternatively
>       remove the `[project]` table from your file and rely entirely on other means of
>       configuration.
>       ********************************************************************************
>
>       !!

[1] https://packaging.python.org/en/latest/guides/writing-pyproject-toml/#license

Signed-off-by: Brandon Maier <brandon.maier@collins.com>
---
Changes in v2:
- drop the license in favor of license classifiers
---
 tools/patman/setup.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/patman/setup.py b/tools/patman/setup.py
index 2ff791da0f7..bcaad69a1c2 100644
--- a/tools/patman/setup.py
+++ b/tools/patman/setup.py
@@ -3,7 +3,6 @@
 from setuptools import setup
 setup(name='patman',
       version='1.0',
-      license='GPL-2.0+',
       scripts=['patman'],
       packages=['patman'],
       package_dir={'patman': ''},

---
base-commit: 8937bb265a7f2251c1bd999784a4ef10e9c6080d
change-id: 20240701-python-3-12-fix-patman-license-51891e28b1f6

Best regards,
-- 
Brandon Maier <brandon.maier@collins.com>

