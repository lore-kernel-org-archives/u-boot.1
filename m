Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 102D3C54E90
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 18:37:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A41083108;
	Thu, 22 May 2025 20:37:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hpe.com header.i=@hpe.com header.b="N6ZYosBY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9C258310F; Thu, 22 May 2025 20:37:26 +0200 (CEST)
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com
 [148.163.143.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6632B830E9
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 20:37:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=verdun@hpe.com
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
 by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54MEmnxn029238;
 Thu, 22 May 2025 18:37:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pps0720; bh=w8aoH4HuSthhDdXiC6iy1Jpzk0RvrezxVyExL
 ouFqEc=; b=N6ZYosBYznCjEohjBjyzbEJOK56Zirjo69HsausqGsvZHNFmxdnyt
 qNOCddf1nBFXKJmA5sQ+Qqan1Lp1k/OTvsmiG8njPU3OHVUiFbVCQgBG3aaqlGZs
 ohQhemqwKRc2wAHV9zC1rswn5wd2CKqtfA/WjD4x/b6jhqMLA3APTSNQT9H3kL4h
 hEJiZ3hM9ow0ctx4ZkOLWp4RQNuv0fcMd7bDYXv6JcvkLu6eaWY9X8zQ2T+hK07y
 L90xDnrwxhzChWYClHigtMjDxVqm/ApOySkXTeIWR+uYVETw6i0GPvRCmDOBB/n3
 UP482e1mEhtB2Lxh0hxKfMr+Gm52gBQEw==
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
 by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 46t60rsu3c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 May 2025 18:37:22 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by p1lg14881.it.hpe.com (Postfix) with ESMTPS id A8C97805E4B;
 Thu, 22 May 2025 18:37:21 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
 by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 52AF6804000;
 Thu, 22 May 2025 18:37:21 +0000 (UTC)
From: verdun@hpe.com
To: verdun@hpe.com, jmverdun3@gmail.com, u-boot@lists.denx.de
Subject: [PATCH v5 0/1] *** Initial Wiznet W5500 support ***
Date: Thu, 22 May 2025 18:37:10 +0000
Message-ID: <20250522183711.22708-1-verdun@hpe.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Zhb5rdTOiarhXc5yYGmysp1jOU5xfWp0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDE4NyBTYWx0ZWRfXy4NTY3B7rC7q
 R5bzTxEZg3B540ZmARJfXhjCShlyrRnai/zY2ZVDKImuvybfuyzvqyHcRp4jLQCvayJjJUg/sKh
 8ySRp7ITexZRUGLr19Cgkx+DSaGhEkc8qmDCMaJVMIPR2ZlPdbTnidtuDM4/f/dfVfpGFgO67+O
 T1mUOebF6OJfI9q/SfS2iaEQLJT47tL8aNWz8opZEYAwR1Cf8WNeZ5hGwAX4nkMjwwrkKUbfrz6
 P8AKenrOqmaXqhdW28aj7mivTusiX/IZxBBu7NdJlXtIx9Kmt/v25TerE3jp7AfuZhTQ6n4w1Rl
 J75evUUoKQk7AEmIMQyuxiUHZ89Evfe0GCvv9ZfNi/wliQ6gISMwjo7JFNxTYH7Zn6cCQii05Wc
 dknPoiTY
X-Proofpoint-GUID: Zhb5rdTOiarhXc5yYGmysp1jOU5xfWp0
X-Authority-Analysis: v=2.4 cv=MtlS63ae c=1 sm=1 tr=0 ts=682f6ee2 cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=dt9VzEwgFbYA:10 a=MvuuwTCpAAAA:8 a=_lroCgBNtfBhefZ1LIIA:9
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_09,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015
 spamscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 mlxscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505220187
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

v5
Remove of_to_plat init
Remove unused cmd variable from probe
Remove socket open command from hw mac setup code
Remove read back mac address command from hw mac setup code
Improve comment about RX_RSR register usage
Check error code of spi_write calls
Check error code from spi_command
Enhance some if statement
Order variable definition per line length
Return ENOMEM in case malloc fail
Return EAGAIN in case of failure during packet reception
Remove all spi related functions call to pack the code and
avoid redundancy
Use pointers to call xfer instead of straight data

v4
Fix some comment typos
Remove unnecessary IFDEF
Drop w5500_eth_tx_hand_f definition and struct element as they are unused
Reorder function to avoid predefinition
Reorder variable definition per data size in functions
Fix return value with spi_read and spi_read16
Drop return value definition into spi_write16
Define MAX_PACKET_SZ to 9000 bytes
Use dynamic allocation for readbulk
Realign readpoll_timeout call
Add comment to enhance loop clarity on receive buffer length
Remove mode variable into write_hwaddr
Invert some direct if loop for indirect as to reduce code complexity
Remove imr variable into w5500_socket_intr_mask function
Drop rtr variable into probe function

v3
Remove Global definition
Replace polling by read_poll_timeout
Remove unused function
Add empty lines before returns statement
Remove declaration and code mix
Switch to dev_dbg
Relocate read/write helpers to top of file
Remove include and incorporate it into the code

v2
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
 drivers/net/w5500.c  | 610 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 620 insertions(+)
 create mode 100644 drivers/net/w5500.c

-- 
2.43.0

