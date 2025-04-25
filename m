Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 365F9C369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 01:08:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33AAE81FC0;
	Fri, 25 Apr 2025 03:08:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hpe.com header.i=@hpe.com header.b="RO5TOvOC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E48881E14; Fri, 25 Apr 2025 03:08:12 +0200 (CEST)
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com
 [148.163.147.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3B85810EB
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 03:08:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=verdun@hpe.com
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
 by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P12awV000709;
 Fri, 25 Apr 2025 01:08:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pps0720; bh=tWdV+XRvaPoLxoGkEEk0KDcCJXVSiqiiUl9CT
 Lja6n8=; b=RO5TOvOCegVmUqIdzltk9GuVIEA61dlo4arGnVKLSDF7P8QbsB0xW
 6HiI21CItKIEuNwWxw7W1EiYowiqME4Sl+RDibI1AfH5uPlpoHEAwWtE0PKiQdIl
 1sThtphYk+RsnL5zFAgIZUgB2vhPtlcYNm8/lDbsMBmkIuURQr2q8IAN/hCDYFLO
 GL/zQLOGm1153z4PU+4EVtsBxJ9H8x0er6BkX8MG5e2XeQ5IPx7lyWqv+YZkYK5I
 qMO6NboVN3qZJNm7UoYY4nXK8N8LRGmK6OBb4MBwHrC28oEKwGvHXrMwzuj9fh/5
 AA9GJallxJERRf48On/rh83wvj09N6f+w==
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
 by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 467464n7h2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Apr 2025 01:08:07 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 8E92213190;
 Fri, 25 Apr 2025 01:07:33 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.39])
 by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 13486800ED8;
 Fri, 25 Apr 2025 01:07:33 +0000 (UTC)
From: verdun@hpe.com
To: verdun@hpe.com, jmverdun3@gmail.com, u-boot@lists.denx.de
Subject: [PATCH v2 0/1] *** Initial Wiznet W5500 support ***
Date: Fri, 25 Apr 2025 01:07:26 +0000
Message-ID: <20250425010727.7946-1-verdun@hpe.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDAwNiBTYWx0ZWRfX4+Xfx/qVvRTm
 lvEFnxC4VV46mA8VrzwDX/HZbD2ThvAiK4rsFy3ZmL8UPc2/TnYJLRljwasFn3MZ4DrXlfeXn3j
 lrb3OdDQHuW27iVlSZGEx5SKsOmycIOYuqfsAakrGvniXYY9TFzgimPmYrDuVUvgmb5P0AbgkEI
 S+LGXdTe8Dt/mjuDbs/cp9DgX8v0ReqdPml2PSw0d+keDN5s8tXjIshuICurgiObzWZ4Qw0bNCq
 QudHBUPrLtm7yoxVu5C7YWYIS/BPi/S4YZFUxp8ox/2j04fwTmCFBNwsEDwMAg2mcf92rYkJwW7
 J7texZ46AFQrK5k9kWyFHH0OGiYB1DV2nYLWKf5ycQIHXgCvL60aFSVQvAJpM+T1lBcUqJNuS12
 k7CsWA7K
X-Proofpoint-ORIG-GUID: lX1YZGWgnbJN6rfd9YTC8N2D6SQWsn9s
X-Authority-Analysis: v=2.4 cv=bNMWIO+Z c=1 sm=1 tr=0 ts=680ae077 cx=c_pps
 a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17
 a=XR8D0OoHHMoA:10 a=MvuuwTCpAAAA:8 a=RWng0oHPIUSWLZTX1TwA:9 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: lX1YZGWgnbJN6rfd9YTC8N2D6SQWsn9s
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_09,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=751 impostorscore=0 suspectscore=0
 clxscore=1015 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2504250006
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

Rebase source tree to create patch against top of tree and avoid issues
with Kconfig and Makefile
Recheck checkpatch.pl output as to minimize issues to CHECK state
CHECK issues reported are coming from copy/paste section from the linux
kernel driver, and aren't processed as being strong issues.
command ran scripts/checkpatch.pl --no-tree v2-0001-Initial-support-for-Wiznet-W5500.patch

Jean-Marie Verdun (1):
  Initial support for Wiznet W5500

 drivers/net/Kconfig  |   9 +
 drivers/net/Makefile |   1 +
 drivers/net/w5500.c  | 508 +++++++++++++++++++++++++++++++++++++++++++
 drivers/net/w5500.h  | 135 ++++++++++++
 4 files changed, 653 insertions(+)
 create mode 100644 drivers/net/w5500.c
 create mode 100644 drivers/net/w5500.h

-- 
2.43.0

