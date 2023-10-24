Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6989CC00A8F
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 15:45:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AC448797C;
	Tue, 24 Oct 2023 17:44:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="D/TTLefU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AEFF87975; Tue, 24 Oct 2023 17:44:20 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 490AD87963
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 17:44:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eajames@linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39OFZ7aI032191; Tue, 24 Oct 2023 15:44:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=fH51xLpxgP6XHM0qgO9VXUJFSMDD9qXLdnojpBQw0RQ=;
 b=D/TTLefU6R0N8iGPjz6S0xc9O+Csx+tEKgaaghneqKHmDGJiMq7A0TV8k+GQ9QBdQxkT
 3OIN7op4VtSYM2w/RqhVuKXHGpujJXZQNFuKwFg48gQVOYxy64h7zUjweP+i0tFMPqSa
 HG5ognIuMPnR5JtFtwTJDt6e9c+rYtOV5yxd1yXY6C4zHtVYK74EVyGCqHHkiqaQb3vp
 CCAUBC78anyQ/PyBmyy1L3rGGvM1K5nlg6IsbERMH1DEG/TNckpmfp+2Ts0+iQz06tGQ
 sT9ay7bI/hBQauEW7TXoLq64gwXtW/JbpScNlEX5BZwTmfg4KSsYlodUEVVZ6RpZMw2L Wg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3txgpr8gen-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Oct 2023 15:44:00 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39OFZwZ0004022;
 Tue, 24 Oct 2023 15:43:59 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3txgpr8gar-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Oct 2023 15:43:58 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39OFdn0w023807; Tue, 24 Oct 2023 15:43:57 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tvryt0qbr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Oct 2023 15:43:57 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39OFhuiK49349170
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Oct 2023 15:43:56 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AAE7558043;
 Tue, 24 Oct 2023 15:43:56 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 35E9558055;
 Tue, 24 Oct 2023 15:43:56 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.72.218])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 24 Oct 2023 15:43:56 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: u-boot@lists.denx.de
Cc: ilias.apalodimas@linaro.org, sjg@chromium.org, xypron.glpk@gmx.de,
 eajames@linux.ibm.com
Subject: [PATCH v14 6/8] doc: Add measured boot documentation
Date: Tue, 24 Oct 2023 10:43:52 -0500
Message-Id: <20231024154354.197524-7-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231024154354.197524-1-eajames@linux.ibm.com>
References: <20231024154354.197524-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PwKDqBTxV2qYdpLI6khKgX6rjV1wpaMv
X-Proofpoint-ORIG-GUID: WylKt6M7KGkPgYKaS0OdFK4u7hen8E02
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_16,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=827
 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310240135
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
Changes since v12:
 - Add a bit of detail about OS usage and what pieces are measured

 doc/usage/index.rst         |  1 +
 doc/usage/measured_boot.rst | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 doc/usage/measured_boot.rst

diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index 98b4719c40..bf53bb6bda 100644
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
index 0000000000..0aad590859
--- /dev/null
+++ b/doc/usage/measured_boot.rst
@@ -0,0 +1,31 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Measured Boot
+=====================
+
+U-Boot can perform a measured boot, the process of hashing various components
+of the boot process, extending the results in the TPM and logging the
+component's measurement in memory for the operating system to consume.
+
+By default, U-Boot will measure the operating system (linux) image, the
+initrd image, and the "bootargs" environment variable. By enabling
+CONFIG_MEASURE_DEVICETREE, U-Boot will also measure the devicetree image.
+
+The operating system typically would verify that the hashes found in the
+TPM PCRs match the contents of the event log. This can further be checked
+against the hash results of previous boots.
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

