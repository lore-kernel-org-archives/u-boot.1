Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 290B7C3ABCB
	for <u-boot@archiver.kernel.org>; Sun, 11 May 2025 18:02:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11F5D8091A;
	Sun, 11 May 2025 20:02:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hpe.com header.i=@hpe.com header.b="VhL4M0sz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4A958091A; Sun, 11 May 2025 20:02:26 +0200 (CEST)
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com
 [148.163.147.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA553805D7
 for <u-boot@lists.denx.de>; Sun, 11 May 2025 20:02:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=verdun@hpe.com
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
 by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54B4q7ss010835;
 Sun, 11 May 2025 18:02:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pps0720; bh=LCoYKDnZWV//LkUFvhnrqP+Fyx9XoSYRFNGnk
 RkuO20=; b=VhL4M0szSMbrBtKF6TlsxPK87+ZE2mPGB5IaOKvxHdMDr6oa+D2zx
 NH9BgxIJjoD7Nehbi9MtKOXP5Dq36ZtgLcgWSMyLjUDhe5wQmZxmWIpcRpJ5K5Ni
 EvUjoLOyJZH/p0bwF9IuH3HqqcF3hIniBJnBM8Jc+7RDyAI7OAA3KrDiRr9EoRVU
 6BGLoe8ZY400LLz6+i0pWGTiorxAukTyUvhifzbrlB674F0L7PO0H07CHGT46NBc
 AWK8d9vNFzX+IkDG9hhnhDwJNbhEbxvqLnW6HGfEiwzoBuVVvlV4oXBdRxYL8COM
 vWkAgeMcZCk15R2JQqDXLKgMziIozrbQg==
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
 by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 46hy6s03ev-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 11 May 2025 18:02:20 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 6BE16800465;
 Sun, 11 May 2025 18:02:20 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.39])
 by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 0FEF5806B51;
 Sun, 11 May 2025 18:02:18 +0000 (UTC)
From: verdun@hpe.com
To: verdun@hpe.com, jmverdun3@gmail.com, u-boot@lists.denx.de
Subject: [PATCH v4 0/1] *** Initial Wiznet W5500 support ***
Date: Sun, 11 May 2025 18:02:06 +0000
Message-ID: <20250511180207.42945-1-verdun@hpe.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=crybk04i c=1 sm=1 tr=0 ts=6820e62c cx=c_pps
 a=A+SOMQ4XYIH4HgQ50p3F5Q==:117 a=A+SOMQ4XYIH4HgQ50p3F5Q==:17
 a=dt9VzEwgFbYA:10 a=MvuuwTCpAAAA:8 a=fNw7daCO4Lq70f1z-GEA:9
X-Proofpoint-ORIG-GUID: WTUiTRJnYQfObj9ARFVJMTRFMzI_4E-X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTExMDE4OCBTYWx0ZWRfXwWXd9s7hbR1X
 UZYLW5bdI9tLqRVOJd+Iibfj2T9SIRdAVQLeztsz9k1xCeCyeGQLHE4/vhFtobKyJw7LEXRkV7S
 C1zGVF43APrZq9R+OI+z2+UMARrdL/75tbwMzVX7mwbkkDNCiS2gj6284fCWzdWi7GB5QZ+Y+AG
 UminOejzWsdutpeEI81DZ2kpqT/CaxoNPh7yNogB1wV7/g1i0acE+5R0OrRB6Bo3xJG+0v2FIVL
 Qv6GGv4ycVrC14T+Tir5Hl4uUxeII+uWfKs/sfDFNdyduwYjdf+lW4sCVgm/hOJb1a7pnuoH181
 Fsu7ygW1wfoL7HsCcfqyrq5CHxnCVRJ7R3GmMt7nCb/iqaAhKpYxUx8Y8MZYxVV+YCHHjGy5jr3
 dppyO/VR
X-Proofpoint-GUID: WTUiTRJnYQfObj9ARFVJMTRFMzI_4E-X
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-11_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505110188
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
 drivers/net/w5500.c  | 584 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 594 insertions(+)
 create mode 100644 drivers/net/w5500.c

-- 
2.43.0

