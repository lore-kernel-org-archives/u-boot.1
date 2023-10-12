Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8CD4CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 15:08:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B848186D0C;
	Thu, 12 Oct 2023 17:08:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="PDZEmMRf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD3DF86DEE; Thu, 12 Oct 2023 17:08:27 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C64486A6B
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 17:08:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eajames@linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39CExo5i019637; Thu, 12 Oct 2023 15:08:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=jn1CuOQlD8TncjWrIhCkv2EPcuIj/KwN7OeTS/m7+I8=;
 b=PDZEmMRfFgeg/VqogD0yuzmdOYZEX1dwHN70Ahi/dvCeCYmDy/vKtIeXbZ5fAfYfbcXo
 chuXaR2e1xyL7VIOe7EX4hGbUmYyLoJdM23Ks3FJP3OBNQxkzJFb9tIgh5tCWq8v68XX
 g2MldX4Iq4T9G4yNo3nugts4ua8Td164rC77POjnO02bRdegaJuwwcu/XBFRDUfEbk5G
 2MdvxepotlSd6OMwwg27uQWVRJVLW7L87EgFNI4dupNtEZg3zk9I6IUAEAPPOanNqa/7
 ulvClfI5rRJuWF6rLx2fTCOTau+LyY5F+wPrKrB4Jhm43w/dz02KZtY3zgymYo7ONKjF FQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpk248dxd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 15:08:22 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39CF09WI023238;
 Thu, 12 Oct 2023 15:08:21 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpk248dvw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 15:08:21 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39CEHmEs023032; Thu, 12 Oct 2023 14:45:54 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tkmc1ym22-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 14:45:53 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39CEjrLQ48169370
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Oct 2023 14:45:53 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E7AD558062;
 Thu, 12 Oct 2023 14:45:52 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CBF8C58064;
 Thu, 12 Oct 2023 14:45:52 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.148.23])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Oct 2023 14:45:52 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: u-boot@lists.denx.de
Cc: ilias.apalodimas@linaro.org, sjg@chromium.org, xypron.glpk@gmx.de,
 eajames@linux.ibm.com
Subject: [PATCH v12 6/8] doc: Add measured boot documentation
Date: Thu, 12 Oct 2023 09:45:49 -0500
Message-Id: <20231012144551.679551-7-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231012144551.679551-1-eajames@linux.ibm.com>
References: <20231012144551.679551-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kddFtkHjCLyToYg6LwyyK5i99wThA56Z
X-Proofpoint-ORIG-GUID: 3gaguj8NVFC9FblGR0-CFKn5O3Jkj1wx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0
 mlxlogscore=878 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310120124
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

Briefly describe the feature and specify the requirements.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 doc/usage/index.rst         |  1 +
 doc/usage/measured_boot.rst | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)
 create mode 100644 doc/usage/measured_boot.rst

diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index fa702920fa..fb043a8923 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -14,6 +14,7 @@ Use U-Boot
    partitions
    cmdline
    semihosting
+   measured_boot
 
 Shell commands
 --------------
diff --git a/doc/usage/measured_boot.rst b/doc/usage/measured_boot.rst
new file mode 100644
index 0000000000..8357b1f480
--- /dev/null
+++ b/doc/usage/measured_boot.rst
@@ -0,0 +1,23 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Measured Boot
+=====================
+
+U-Boot can perform a measured boot, the process of hashing various components
+of the boot process, extending the results in the TPM and logging the
+component's measurement in memory for the operating system to consume.
+
+Requirements
+---------------------
+
+* A hardware TPM 2.0 supported by the U-Boot drivers
+* CONFIG_TPM=y
+* CONFIG_MEASURED_BOOT=y
+* Device-tree configuration of the TPM device to specify the memory area
+  for event logging. The TPM device node must either contain a phandle to
+  a reserved memory region or "linux,sml-base" and "linux,sml-size"
+  indicating the address and size of the memory region. An example can be
+  found in arch/sandbox/dts/test.dts
+* The operating system must also be configured to use the memory regions
+  specified in the U-Boot device-tree in order to make use of the event
+  log.
-- 
2.39.3

