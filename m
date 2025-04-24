Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1531C369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 21:43:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 571E8809D4;
	Thu, 24 Apr 2025 23:43:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hpe.com header.i=@hpe.com header.b="jL1OyVyR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04B8280F9C; Thu, 24 Apr 2025 23:43:53 +0200 (CEST)
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com
 [148.163.143.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F9AB8082A
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 23:43:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=verdun@hpe.com
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
 by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OKtdW6029304;
 Thu, 24 Apr 2025 21:43:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pps0720; bh=GDYSILDDiLWaxpzHXTZL+OsHUPs1QvFKynXsk
 w+ICbU=; b=jL1OyVyRa5LicLpFD0YS6b4yzPQg3Ev2YMWRUcX6zZo4BqVNviffM
 x9Pzsu8m08OPDbqUdZkiOE7GnP1eYvFZdGINeIVhxp9W+q8kRNdIV6sV6oYYUYbr
 zhwd469NSrEu7ZDEM7JN63tR+o0ZkD+zj8FFqHLskWly7fyaP9RbNBPGUFFXThRv
 7qEfoYWMnLsZFYJ+jGra6f531dasZd8GeuuuiWV5X9pPpJv8TOH0U19OYEAwNR9q
 dZDFI3bWaM0TufQtgCQeYHZz4slwm1AKn7G6Y2TJZ5WTREvTSCo7170PHPNFphgU
 huiFXr8cX4hbuq5psRVl85ymYymha3rWg==
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
 by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 467vru099p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Apr 2025 21:43:48 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by p1lg14881.it.hpe.com (Postfix) with ESMTPS id DE9E1805E9C;
 Thu, 24 Apr 2025 21:43:42 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
 by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 7577B808B94;
 Thu, 24 Apr 2025 21:43:42 +0000 (UTC)
From: verdun@hpe.com
To: verdun@hpe.com, jmverdun3@gmail.com, u-boot@lists.denx.de
Subject: [PATCH v1 0/1] *** Initial Wiznet W5500 support ***
Date: Thu, 24 Apr 2025 21:43:34 +0000
Message-ID: <20250424214335.57230-1-verdun@hpe.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: bvmdp9oinXMwPksJelZ8b4r3h23Ii-6m
X-Authority-Analysis: v=2.4 cv=H+bbw/Yi c=1 sm=1 tr=0 ts=680ab094 cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=XR8D0OoHHMoA:10 a=MvuuwTCpAAAA:8 a=aXvv4oq-kdLZ0ugRKMIA:9
X-Proofpoint-ORIG-GUID: bvmdp9oinXMwPksJelZ8b4r3h23Ii-6m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDE1MiBTYWx0ZWRfXxKctyVaaC2lT
 RdQxOrhC7HvHqNaOEnw+0oxGSpC8VSQ/tlFO+L1ywEkzAioSV+YRrcjrctokOL1KRam8IpvQzw5
 PuWnm/2cTV+GhLHStYuxQNgq3z7Lxz8C5rL1yHFpaIUq8NUyRZ+9IRIio8cH0dQqqYG9ITZaqIu
 66UqKSc0AluSAF56esdX1spJQ7hxQPWZvEiewOzB7OfETQhlPL3LJ7kbFB39cVe3QeXxC41pWlO
 LNcDoBQdYiF4hsANWES1o4HnqIcmf26sJixaYjjNs9AkQ7BD5GdqmRyF6e6Vd9XApbc+V/LDj1t
 sLRxdOEOCVWaddW7SHPBd4QN1EZEaZElgziS+Dsr2WWNO6f34R/Anr1k5tkeFWcHbzprqlfr95A
 /oStH1Fd
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_09,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0 mlxscore=0
 mlxlogscore=767 adultscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2504240152
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

Jean-Marie Verdun (1):
  Initial support for Wiznet W5500

 drivers/net/Kconfig  |  54 ++---
 drivers/net/Makefile |   7 +-
 drivers/net/w5500.c  | 508 +++++++++++++++++++++++++++++++++++++++++++
 drivers/net/w5500.h  | 135 ++++++++++++
 4 files changed, 662 insertions(+), 42 deletions(-)
 create mode 100644 drivers/net/w5500.c
 create mode 100644 drivers/net/w5500.h

-- 
2.43.0

