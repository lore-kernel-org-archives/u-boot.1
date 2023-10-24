Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC17C07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 15:44:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB60B8727A;
	Tue, 24 Oct 2023 17:44:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="jcRcS54u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD09587974; Tue, 24 Oct 2023 17:44:09 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 782BB87966
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 17:44:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eajames@linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39OFbAd5019390; Tue, 24 Oct 2023 15:44:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=9ofSYSCEOjtlae9Kix7hxiopmr3DTmymhm67aDPzdck=;
 b=jcRcS54umaqN+vX/Ha/6YZHzifetVAPkNuG7q/iWqr3RgsXJ6CabTjPf8sRcnJ0NBt8k
 iigdcna/MPPpfrCKAdOsWro//lD1+kp1xMO8EpoOmNQ6gjDOhgBLIO/Sx0AUXqtcV2vr
 jDBYlhc50HkEOCxOn8ne2If6N8IKVSpPyhIjxcagwhm022oYc3X/G3+Ha7VIse+wb3pI
 fCf5VAw8gEtu9RoCmO0MI58GPZ9pp+lgDegk9f5pC6PUGNVc5Lvf+R3u1XO2ZeWB870T
 2AXHCm1e6FlVZLlYneJegy5eSCkUvmz9hjRSPJZG5d1sx8osp/M8ssA0RRcYQVwc4pVD Zw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3txgcts66c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Oct 2023 15:44:01 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39OFFh4A030122;
 Tue, 24 Oct 2023 15:44:00 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3txgcts61d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Oct 2023 15:43:59 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39OFSniY023786; Tue, 24 Oct 2023 15:43:57 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tvryt0qbs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Oct 2023 15:43:57 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39OFhvIv51970808
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Oct 2023 15:43:57 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2D64458055;
 Tue, 24 Oct 2023 15:43:57 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 06E0758059;
 Tue, 24 Oct 2023 15:43:57 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.72.218])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 24 Oct 2023 15:43:56 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: u-boot@lists.denx.de
Cc: ilias.apalodimas@linaro.org, sjg@chromium.org, xypron.glpk@gmx.de,
 eajames@linux.ibm.com
Subject: [PATCH v14 8/8] test: use a non system PCR for testing PCR extend
Date: Tue, 24 Oct 2023 10:43:54 -0500
Message-Id: <20231024154354.197524-9-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231024154354.197524-1-eajames@linux.ibm.com>
References: <20231024154354.197524-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IR1Wn7N9es5rOn-6bbFH8VnEbWfRR8Pi
X-Proofpoint-ORIG-GUID: L2LA93ygGVxzAhN3DRcLCzUwR1Hat6ze
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_16,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015
 adultscore=0 bulkscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310240135
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

From: Ilias Apalodimas <ilias.apalodimas@linaro.org>

We currently use PCR 0 for testing the PCR read/extend functionality in
our selftests.  How ever those PCRs are defined by the TCG spec for
platform use.  For example if the tests run *after* the efi subsystem
initialization, which extends PCRs 0 & 7 it will give a false positive.

So let's switch over to a PCR which is more suitable and is defined for
OS use.  It's worth noting that we are using PCR10 here, since PCR9 is
used internally by U-Boot if we choose to measure the loaded DTB

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 test/py/tests/test_tpm2.py | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/test/py/tests/test_tpm2.py b/test/py/tests/test_tpm2.py
index c2579fa02c..47392b87a9 100644
--- a/test/py/tests/test_tpm2.py
+++ b/test/py/tests/test_tpm2.py
@@ -239,7 +239,7 @@ def test_tpm2_dam_parameters(u_boot_console):
 def test_tpm2_pcr_read(u_boot_console):
     """Execute a TPM2_PCR_Read command.
 
-    Perform a PCR read of the 0th PCR. Must be zero.
+    Perform a PCR read of the 10th PCR. Must be zero.
     """
     if is_sandbox(u_boot_console):
         tpm2_sandbox_init(u_boot_console)
@@ -247,7 +247,7 @@ def test_tpm2_pcr_read(u_boot_console):
     force_init(u_boot_console)
     ram = u_boot_utils.find_ram_base(u_boot_console)
 
-    read_pcr = u_boot_console.run_command('tpm2 pcr_read 0 0x%x' % ram)
+    read_pcr = u_boot_console.run_command('tpm2 pcr_read 10 0x%x' % ram)
     output = u_boot_console.run_command('echo $?')
     assert output.endswith('0')
 
@@ -257,7 +257,7 @@ def test_tpm2_pcr_read(u_boot_console):
     updates = int(re.findall(r'\d+', str)[0])
 
     # Check the output value
-    assert 'PCR #0 content' in read_pcr
+    assert 'PCR #10 content' in read_pcr
     assert '00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00' in read_pcr
 
 @pytest.mark.buildconfigspec('cmd_tpm_v2')
@@ -275,19 +275,19 @@ def test_tpm2_pcr_extend(u_boot_console):
     force_init(u_boot_console)
     ram = u_boot_utils.find_ram_base(u_boot_console)
 
-    read_pcr = u_boot_console.run_command('tpm2 pcr_read 0 0x%x' % (ram + 0x20))
+    read_pcr = u_boot_console.run_command('tpm2 pcr_read 10 0x%x' % (ram + 0x20))
     output = u_boot_console.run_command('echo $?')
     assert output.endswith('0')
     str = re.findall(r'\d+ known updates', read_pcr)[0]
     updates = int(re.findall(r'\d+', str)[0])
 
-    u_boot_console.run_command('tpm2 pcr_extend 0 0x%x' % ram)
+    u_boot_console.run_command('tpm2 pcr_extend 10 0x%x' % ram)
     output = u_boot_console.run_command('echo $?')
     assert output.endswith('0')
 
     # Read the value back into a different place so we can still use 'ram' as
     # our zero bytes
-    read_pcr = u_boot_console.run_command('tpm2 pcr_read 0 0x%x' % (ram + 0x20))
+    read_pcr = u_boot_console.run_command('tpm2 pcr_read 10 0x%x' % (ram + 0x20))
     output = u_boot_console.run_command('echo $?')
     assert output.endswith('0')
     assert 'f5 a5 fd 42 d1 6a 20 30 27 98 ef 6e d3 09 97 9b' in read_pcr
@@ -297,11 +297,11 @@ def test_tpm2_pcr_extend(u_boot_console):
     new_updates = int(re.findall(r'\d+', str)[0])
     assert (updates + 1) == new_updates
 
-    u_boot_console.run_command('tpm2 pcr_extend 0 0x%x' % ram)
+    u_boot_console.run_command('tpm2 pcr_extend 10 0x%x' % ram)
     output = u_boot_console.run_command('echo $?')
     assert output.endswith('0')
 
-    read_pcr = u_boot_console.run_command('tpm2 pcr_read 0 0x%x' % (ram + 0x20))
+    read_pcr = u_boot_console.run_command('tpm2 pcr_read 10 0x%x' % (ram + 0x20))
     output = u_boot_console.run_command('echo $?')
     assert output.endswith('0')
     assert '7a 05 01 f5 95 7b df 9c b3 a8 ff 49 66 f0 22 65' in read_pcr
-- 
2.39.3

