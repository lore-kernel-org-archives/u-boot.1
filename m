Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9775C54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 17:08:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4269F82E67;
	Mon, 26 May 2025 19:07:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hpe.com header.i=@hpe.com header.b="grX+JYBP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F2C082E67; Mon, 26 May 2025 19:07:58 +0200 (CEST)
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com
 [148.163.147.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEF4F82DB7
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 19:07:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=verdun@hpe.com
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
 by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QH2isR005093;
 Mon, 26 May 2025 17:07:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pps0720; bh=L38Mt2vVwJzEACTJb6mYtSRv+pUGtHpYK7vYS
 t3kwUc=; b=grX+JYBPNKMoCH/g/gDYCwwBV6XOdzGzg1p/XA2zKx6SQRRnBRctb
 2kEI44qVqVX0KdrPfOGvMjuf9oiQ+iX9GBqls9PKJgCdYKOx2JhX6fabvCXkOKaa
 ieA7txe59kW+ZrnkFqD8P81o0v+WLp+Df69v9419a5gqhD8PHkIQLdQEueNGK2v3
 6f9XIpkYASubq0HqipuUeoij3g1ovYNQvOfnxk+brsHngMTRHxEHkjrUD/GFgmuI
 /f++ApBiIPwZ+G13XVtKad+KW69SfvGs9G2JEPPvA+qUlweFlxfo5rej4txWgrRo
 WdMPXil6NPq0A6pX7cbp3qJdl/8zksh2w==
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
 by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 46vnxyb7g9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 May 2025 17:07:52 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 0F9A280044F;
 Mon, 26 May 2025 17:07:19 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
 by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 5E029809741;
 Mon, 26 May 2025 17:07:18 +0000 (UTC)
From: verdun@hpe.com
To: verdun@hpe.com, jmverdun3@gmail.com, u-boot@lists.denx.de
Subject: [PATCH v6 0/1] *** Initial Wiznet W5500 support ***
Date: Mon, 26 May 2025 17:07:11 +0000
Message-ID: <20250526170712.4133-1-verdun@hpe.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDE0NSBTYWx0ZWRfX+Z3DYsxWK7Kp
 tShN47Uc9s2e/DUbEl9Kyd4VeJPOHZI56lDG0v7Nf0zzBQB8u/GynvX8THuf7w0yXRyIrk3eG6H
 J3c+83FJLBV7/Q5MvbCnDbe4ed3gkfSCE5yCj3vUaSR7OlTf4/49YjFeaN5T82WloM1c3b8TDtL
 sPA4UGBKmO3yScIFWlXjUTjOxoF+JVTz3Btnm6S4M4U4OKhSqatSTrlZof5IcjTwZnMpMBFm3gN
 TDGb7F3z8vxQcljPeilXEB9AL40ppm3sNU0fJarWp0dW4wSIJrtsDATstpcc+8iHkcxqAQyXWUg
 0KG1lKyLds7R1QjBT7iu6uM1klfTopzgMWsLKiukCMTmV5Ii3NvwGKPXGkDsPV0HHznNf+rz7eP
 vBPnSSI7
X-Proofpoint-GUID: _DW406StBrNRn47ca4R5yOEDF3-mCIla
X-Proofpoint-ORIG-GUID: _DW406StBrNRn47ca4R5yOEDF3-mCIla
X-Authority-Analysis: v=2.4 cv=H+Pbw/Yi c=1 sm=1 tr=0 ts=68349fe8 cx=c_pps
 a=A+SOMQ4XYIH4HgQ50p3F5Q==:117 a=A+SOMQ4XYIH4HgQ50p3F5Q==:17
 a=dt9VzEwgFbYA:10 a=MvuuwTCpAAAA:8 a=_lroCgBNtfBhefZ1LIIA:9
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-26_08,2025-05-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2505160000 definitions=main-2505260145
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
 drivers/net/w5500.c  | 610 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 620 insertions(+)
 create mode 100644 drivers/net/w5500.c

-- 
2.43.0

