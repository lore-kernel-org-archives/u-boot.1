Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E453EC5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 19:47:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5093182E66;
	Mon, 26 May 2025 21:47:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hpe.com header.i=@hpe.com header.b="JGaCxKk+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CBE482E67; Mon, 26 May 2025 21:47:44 +0200 (CEST)
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com
 [148.163.143.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DBF482E25
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 21:47:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=verdun@hpe.com
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
 by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QJ9fXe017126;
 Mon, 26 May 2025 19:47:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pps0720; bh=iA8TqDgz5/zmmMbbWsREWPSEfoPFW7cOtLcHV
 pBGLKI=; b=JGaCxKk+503ZujHTqFpIjICMr2EQb61g9sMzNICRfNeQK5eugwBe9
 qAFz9c0aC2j8OeslMa5Xo7KNEQEHYf5+P4hqGxL8dUv0iKL59lP3MXnIwLgOuw+T
 059laBH8hcJrbGYXJZnaV8/yq50kErSyqdS8I6TGZbnmp+uhrW0q9Jfa4PzNfZWi
 p4lv4HIdeJ4qdn6lcYQBVEVW2SPUSem2djU739jD4c9cxoRudzXHZL2Pef2IxOZB
 mwmXCf7h3DaR9Q7B2Ng4xhlDo2+kdioIZFpnODlXhCn9bthsiLPrvzENqLb0vu3I
 8qvv1VL2JcYvWjSrUDUOpvR5JbXxPCj0Q==
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
 by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 46vvdsgu5a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 May 2025 19:47:39 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by p1lg14881.it.hpe.com (Postfix) with ESMTPS id CE912805EB2;
 Mon, 26 May 2025 19:47:38 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.39])
 by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 40BBE801AD5;
 Mon, 26 May 2025 19:47:38 +0000 (UTC)
From: verdun@hpe.com
To: verdun@hpe.com, jmverdun3@gmail.com, u-boot@lists.denx.de
Subject: [PATCH v7 0/1] *** Initial Wiznet W5500 support ***
Date: Mon, 26 May 2025 19:47:33 +0000
Message-ID: <20250526194734.4195-1-verdun@hpe.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BfnY0qt2 c=1 sm=1 tr=0 ts=6834c55b cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=dt9VzEwgFbYA:10 a=MvuuwTCpAAAA:8 a=_lroCgBNtfBhefZ1LIIA:9
X-Proofpoint-GUID: BpA3-sF_i99mrGOrg49rrVw1P6fGsVju
X-Proofpoint-ORIG-GUID: BpA3-sF_i99mrGOrg49rrVw1P6fGsVju
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDE2OSBTYWx0ZWRfXzUafpQUFHv8R
 gCt6KeOnx5p5Dt83erG7kU8ByssZ56CsAcZuXOHTNQmzPR6K5Luug2BViH6nC9aJj46X7eGTQst
 TCIcPwkUgz8KpYWDthgw+rqM8cM69pQRt8BKDdr/SP7e482DS8GFgVAZCONTwyRXIeD5n8lvHlr
 O2Q0xIuDOOdliJ328qZTGnq5hc59eZ/K+wc/CcS0fJ791Xx1SA7lx0LoXGG+ZsXUjAuNB08m+9A
 ALd56h3VSKftN/SU12ireXFtFvpZRDAiX9sCX1RVVKUnZXCwm4XFX1BUPbqfnvkmjHAAjprT3ge
 IVVZBs3tJbwo4ELYJ/UTRXJxpEGsuqfR1LdBXaPoq2KOcMaC0qJd+bDNod5ivaq7uFCpuYXFLLc
 Ru6Uz7Di
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-26_10,2025-05-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0
 mlxscore=0 priorityscore=1501 clxscore=1015 phishscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505260169
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

v7
Fix bug exposed by using LWIP TCP/IP as primary network backend. Both
networking stack are now usable

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

