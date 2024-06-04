Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64070C25B78
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 16:31:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDEB188481;
	Tue,  4 Jun 2024 18:31:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=collins.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collins.com header.i=@collins.com header.b="hiWzTBtz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2AA388476; Tue,  4 Jun 2024 18:31:45 +0200 (CEST)
Received: from mx0b-00105401.pphosted.com (mx0b-00105401.pphosted.com
 [67.231.152.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F700883DB
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 18:31:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=collins.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=brandon.maier@collins.com
Received: from pps.filterd (m0346901.ppops.net [127.0.0.1])
 by mx0a-00105401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 454EBp8c006996; Tue, 4 Jun 2024 16:31:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=collins.com; h=cc :
 content-transfer-encoding : content-type : date : from : message-id :
 mime-version : subject : to; s=POD051818;
 bh=7INeGduV5BVKgjdQDQ0nV7upVwOsAolq/KiNj1MOnO0=;
 b=hiWzTBtzo+1dyv2M6QVD5TQEXjtPC0nzB0RmmuN2K8mxzzKSwSgAfqcZI8TAEIyOycIW
 ULNkY6lth9QZvWmEOfPq0kQVeOfYzUGuqB5ROvxqETgVEq/nyRpihymRQ/fKda0CIamA
 tGv/sLtu/0rFOF847ECW3ow0j9N+/MvWmwAdG2w1maLYOgSmpoGVTas/rot2MRWhOdyc
 5b7BuYgZKvAYDb67jugnpCt7Vy9v+q6CmCD9wEaxX9IfB7O3ROkUD/7ZvdCRuLTGfHOx
 waUiKrqaRVD4YMdyAeJmoHvL+eB8k1BaeyQcLRlO9ZvF31e4hQzAnrEA+LgJXd2RnxEX HQ== 
Received: from xusxph009rp050.rtx.com (xusxph009rp050.rtx.com [128.13.125.147])
 by mx0a-00105401.pphosted.com (PPS) with ESMTPS id 3yj4fq9swa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Jun 2024 16:31:39 +0000
Received: from xusxph004rp020.corp.ray.com ([128.13.120.224])
 by xusxph009rp050.rtx.com (8.17.1.19/8.17.1.19) with ESMTPS id 454GVcpi000864
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 4 Jun 2024 16:31:38 GMT
Received: from ciulimr01.rockwellcollins.com
 (snat-utc-mailhub.rockwellcollins.com [10.172.224.19])
 by xusxph004rp020.corp.ray.com (8.17.1.19/8.17.1.19) with ESMTPS id
 454GVcWv018351
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 4 Jun 2024 16:31:38 GMT
X-Received: from bspbox.kirk (unknown [10.148.204.208])
 by ciulimr01.rockwellcollins.com (Postfix) with ESMTP id 5150630016BC;
 Tue,  4 Jun 2024 11:31:38 -0500 (CDT)
From: Brandon Maier <brandon.maier@collins.com>
To: u-boot@lists.denx.de
Cc: Brandon Maier <brandon.maier@collins.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 1/1] tools: patman: fix `pip install` with Python 3.12
Date: Tue,  4 Jun 2024 16:31:34 +0000
Message-ID: <20240604163134.1149752-1-brandon.maier@collins.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 definitions=main-2406040132
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040132
X-Proofpoint-GUID: pd5nkJnlaqRM6M1MU3hCvzZk7usr8W07
X-Proofpoint-ORIG-GUID: pd5nkJnlaqRM6M1MU3hCvzZk7usr8W07
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_default_notspam
 policy=outbound_default score=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2405010000 definitions=main-2406040132
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

As described in the error output, the license line is not allowed to be
only defined in the setup.py.

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

Signed-off-by: Brandon Maier <brandon.maier@collins.com>
CC: Simon Glass <sjg@chromium.org>
---
 tools/patman/pyproject.toml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/patman/pyproject.toml b/tools/patman/pyproject.toml
index fcefcf66960..9e6079cb57e 100644
--- a/tools/patman/pyproject.toml
+++ b/tools/patman/pyproject.toml
@@ -17,6 +17,7 @@ classifiers = [
     "License :: OSI Approved :: GNU General Public License v2 or later (GPLv2+)",
     "Operating System :: OS Independent",
 ]
+dynamic = ["license"]
 
 [project.urls]
 "Homepage" = "https://docs.u-boot.org/en/latest/develop/patman.html"
-- 
2.45.1

