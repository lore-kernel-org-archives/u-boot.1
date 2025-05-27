Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC3EC5B542
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 22:06:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85F17831AC;
	Wed, 28 May 2025 00:06:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hpe.com header.i=@hpe.com header.b="lOZGMf66";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D848083197; Wed, 28 May 2025 00:06:33 +0200 (CEST)
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com
 [148.163.147.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D60388315B
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 00:06:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=verdun@hpe.com
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
 by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RHX9vf023350;
 Tue, 27 May 2025 22:06:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pps0720; bh=qaoKdzCICbCX8RFXtey9jcojpIyRodCJDlGbL
 jhlIjM=; b=lOZGMf66aOtUqERSQJfaawV/UvXjDEMYCftcl1JjSyM+GzMlyZOqx
 C9MyWixDs+TdPPuWfSwqabRFArFE0VosJQUBVYcZVD5POj2R6lYf6yY7YEgLrBo7
 CXmeXSafYtUjO9xsTy3wM1vnwJqPIQ3nH4CRsWUvbXUn9BSQHFmpw5VOPIAfs8HG
 tNv9Q5jkUdGWlJ7W4sNGDK6fpL5jr8BU5ZLoSCaanoPINRbrVzUFwzh99W5Xyfgd
 0NziVeeOJxG2XkxLmshsfqGFPRJ1O8CgArrjO9LOHxpN6+QWPey62RVyPv0tRktP
 RNqX8hpxl5M2R/IueLGxIWmlLI5r+HbSg==
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
 by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 46wbqee531-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 May 2025 22:06:28 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 8F3E0800479;
 Tue, 27 May 2025 22:06:27 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
 by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 321638065E2;
 Tue, 27 May 2025 22:06:27 +0000 (UTC)
From: verdun@hpe.com
To: verdun@hpe.com, jmverdun3@gmail.com, u-boot@lists.denx.de
Subject: [PATCH v8 0/1] *** Initial Wiznet W5500 support ***
Date: Tue, 27 May 2025 22:06:17 +0000
Message-ID: <20250527220618.7415-1-verdun@hpe.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDE4NiBTYWx0ZWRfX6g1PLdEzavd0
 ZQfFOKt3YEY5WMQHeJfflK+HCr9HXga9Ufi5F2udOhGsPjvDJDkFDAvr3wFmAUw8JL3IkVt/7yp
 dsZHCjSHEFxm+FULDOt87sXNdVBqQ3JEDsKF+fnzDwB+9PdkDU+FBxoKgcvPXVk/ya7dpCSKlDk
 33t88uYsDnpNLH0KPDQSjQVPrN5Pa8TZAihrLW+Ui4kcdOjtryVgSHfwuXF3x693pG8ZwAp22xt
 eiDyl0p93s1PjekbwUjYM/yGkAFs0zSY6WRXjckbjtZ+z2xNH6r7KT78xqAQ7Y7ogICXVANclVL
 r61GtDKvmQCjtDpNNSdD/hF0qyBeBsCgK4NjgGlgkbeLTng74CFeEx4KEofnYHV/CLBsxsc7AZi
 1mXakMYn
X-Proofpoint-ORIG-GUID: kv0vTMRwGuwLD5oRThHZRWX6nGdLNL03
X-Authority-Analysis: v=2.4 cv=Lbg86ifi c=1 sm=1 tr=0 ts=68363764 cx=c_pps
 a=A+SOMQ4XYIH4HgQ50p3F5Q==:117 a=A+SOMQ4XYIH4HgQ50p3F5Q==:17
 a=dt9VzEwgFbYA:10 a=MvuuwTCpAAAA:8 a=s174YLH-HrNVaCUGjpMA:9
X-Proofpoint-GUID: kv0vTMRwGuwLD5oRThHZRWX6nGdLNL03
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_10,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505270186
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

v8
Fix error propagation from dm_spi_xfer calls and successors
Fix memory allocation check into probe

v7
Fix bug exposed by using LWIP TCP/IP as primary network backend

v6
Switch all log to dev_dbg call

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
 drivers/net/w5500.c  | 621 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 631 insertions(+)
 create mode 100644 drivers/net/w5500.c

-- 
2.43.0

