Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2ED5C61CE8
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 19:40:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2677882B0E;
	Mon,  9 Jun 2025 21:40:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hpe.com header.i=@hpe.com header.b="cbPeQRVe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4F9382B33; Mon,  9 Jun 2025 21:40:05 +0200 (CEST)
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com
 [148.163.147.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71D928007D
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 21:40:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=verdun@hpe.com
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
 by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 559JXhXQ028147;
 Mon, 9 Jun 2025 19:40:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pps0720; bh=AqVMxYtwuRze2u3dt9DXE31Y0PTAeYHqUDBEW
 Y767zA=; b=cbPeQRVeK5MylDfZujE6przdnbs54sOQP79HHpT8xtCWvhmIgGDci
 F5aH+/KTag3bQlMUKJSYAq3qYyb+96q8Q9hw6PBcZ2Yq/HUm9BJRhqaPxrWcBWUB
 eysYJjksspAgIOBSqFQxkO2t/1XryfGIfZwLXM1XdrTOLukK6dJ6vHWfkTK/oSk0
 NiEEHNI2G1JRUCr09r3VHQvzIfWq97XaHfx9Nm+DHfbuw+Dc0m8On1RjDKprN4c1
 IdtPUv+Jkly8O3xn61RNWxnz0gzQRdjh4HfPP1cbN6hF6PLq8qB7w5D5UZ1le0e1
 StQlBTM+Ip5JR9WLMmq0yU3ihZKCFXn4A==
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
 by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 475ys7ua25-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Jun 2025 19:39:59 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by p1lg14880.it.hpe.com (Postfix) with ESMTPS id EBA6380020C;
 Mon,  9 Jun 2025 19:39:36 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.39])
 by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id ACA87810ADF;
 Mon,  9 Jun 2025 19:39:36 +0000 (UTC)
From: verdun@hpe.com
To: verdun@hpe.com, jmverdun3@gmail.com, u-boot@lists.denx.de
Subject: [PATCH v9 0/1] *** Initial Wiznet W5500 support ***
Date: Mon,  9 Jun 2025 19:39:31 +0000
Message-ID: <20250609193933.4298-1-verdun@hpe.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ZF1gUGekuDil-XfQU-lZt-Q9dQ3mIGWl
X-Authority-Analysis: v=2.4 cv=NsrRc9dJ c=1 sm=1 tr=0 ts=6847388f cx=c_pps
 a=A+SOMQ4XYIH4HgQ50p3F5Q==:117 a=A+SOMQ4XYIH4HgQ50p3F5Q==:17
 a=6IFa9wvqVegA:10 a=MvuuwTCpAAAA:8 a=s174YLH-HrNVaCUGjpMA:9
X-Proofpoint-ORIG-GUID: ZF1gUGekuDil-XfQU-lZt-Q9dQ3mIGWl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDE0OSBTYWx0ZWRfXwaq2maybHjZm
 B0CxvdrngqRzHGcaj1uHG7R2lIjM7PEVvnSC2sp58imoUqMwUMrcm6ZyGH8m6rFbi5zv+XQBDG2
 Bqozh60D6YUaS3+HYNOQqr6oGI/MUD1W5xmLfBJmaO+Rg/EYHIs8iIPmNGC1535CpUkcn5K4qRR
 gF9jJ1TGqxGRqnMYk87Mp43wIgT1Adt5wVHqQlYUMWYgTAut5xHgznJ89ErL7q5L8DYmM78DGKq
 UHSzGlIEXzARxmxODgy/kLKXpzBcennYoXsqobD1sZ9QSE7nqUcEx+mT6t8u+ZvT9dY/9iFa0wD
 dwR2HHvpNddhnwoQgJDl2s398h31jXqThTQKeFXK6RgteLrq3HfnIrVrOKelTpH9l4ymvC8gESn
 rTINMU+T
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_08,2025-06-09_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 impostorscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2505280000 definitions=main-2506090149
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

v9
Fix compilation issue from a missing parenthesis in v8.
Fix unused variable from v8 (check)
Fix a crash when using transfer bigger then 1500 bytes
identified with http transfer instead of tftp. The device
merge multiple packets and the local buffer into the driver
must be at least 16kB

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

 drivers/net/Kconfig  |  10 +
 drivers/net/Makefile |   1 +
 drivers/net/w5500.c  | 619 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 630 insertions(+)
 create mode 100644 drivers/net/w5500.c

-- 
2.43.0

