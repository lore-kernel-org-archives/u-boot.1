Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075A4CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 16:22:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9895874BB;
	Thu, 19 Oct 2023 18:22:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="ol7cDTdN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C74AA87256; Thu, 19 Oct 2023 18:22:05 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A79B0874AB
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 18:22:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eajames@linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39JGJUHf008882; Thu, 19 Oct 2023 16:22:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=fH51xLpxgP6XHM0qgO9VXUJFSMDD9qXLdnojpBQw0RQ=;
 b=ol7cDTdNwklWV2Ci0APnOXWsSmcqV70R/mBPg6/NB3Jw4/2H878IYLlnq86u9yUxKboy
 Dcx59hGn7X+1Ql9TiSpVpN3C4pVNP3xI7f5V5BumSf3qVYlaf2oP2mMeDQT8nqgwYj/9
 tEmrz/B8PTZyUIChSS1Ex7q0DD1HB+azV0tBwHWLlk58pfm/U49ijigOinB4itb4kuJU
 zQrSQReVoBVcAg7DamtPWGWqoriG1IKt9YTxM2MR3of9asmjnE8rvUj4D+cPq0gCuQ4S
 Za7j0C5L6fp+AzTLwadbqXd0y4OpMIGQrOETPvXDdM3axYWno95iQBIwQb0+HRXM5Tko 0g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tu7vfg642-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Oct 2023 16:22:00 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39JGJl1H009688;
 Thu, 19 Oct 2023 16:21:59 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tu7vfg63n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Oct 2023 16:21:59 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39JFBQ3h019884; Thu, 19 Oct 2023 16:21:58 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tr8121guh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Oct 2023 16:21:58 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39JGLvcc59900408
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Oct 2023 16:21:58 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C662D58056;
 Thu, 19 Oct 2023 16:21:57 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A14AF58064;
 Thu, 19 Oct 2023 16:21:57 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.89.2])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 19 Oct 2023 16:21:57 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: u-boot@lists.denx.de
Cc: ilias.apalodimas@linaro.org, sjg@chromium.org, xypron.glpk@gmx.de,
 eajames@linux.ibm.com
Subject: [PATCH v13 6/8] doc: Add measured boot documentation
Date: Thu, 19 Oct 2023 11:21:54 -0500
Message-Id: <20231019162156.80982-7-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231019162156.80982-1-eajames@linux.ibm.com>
References: <20231019162156.80982-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PPNtLtq25UiT2uo2Y_2cSh1Qmtwl68X2
X-Proofpoint-ORIG-GUID: p-i2oMZRGAqW9akMydzfMHmazsukK9H7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_15,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 mlxlogscore=847
 lowpriorityscore=0 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190138
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

