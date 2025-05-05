Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 091D6C3ABBC
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 17:59:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E934828C2;
	Mon,  5 May 2025 19:59:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hpe.com header.i=@hpe.com header.b="YO8UWJBi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37941828F8; Mon,  5 May 2025 19:59:28 +0200 (CEST)
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com
 [148.163.147.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE7ED828BC
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 19:59:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=verdun@hpe.com
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
 by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545HZBHS011598;
 Mon, 5 May 2025 17:59:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pps0720; bh=TKl7SIYEoE7i8ggEv1jV99hvy/4A+tiu5HUPf
 vOfcKY=; b=YO8UWJBip/Ivylh0FfQ003NcOvANfKn0pwbP3RZTrBzbJ8KYtsz5h
 RttXrXduJYVmxuD5FBrZNxlR4JNKHUHnTwSOFo0kAbxSTlWb8criaPPiUolBlix2
 7llajSRvts4NfIFs3u3HxxpLMo2HSaqMP622SAa7YZkleNJyqTFvJgjeTeXbZkAU
 ytw7YKm84eddOmrSg7MtB3BWg0knJldjRphWQXxXlfljYEVcr32L3SmIHmNOQxLc
 nV7leMpTTDToUSw361dg94m3CR+YHerytqiIbrPe/iJlLk/cBS8l9deETCdZ1RDr
 pPJtd+wukTNy8RdbbfQmd6epmjs2vKtaA==
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
 by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 46f1ut056q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 May 2025 17:59:23 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 01BE9805662;
 Mon,  5 May 2025 17:58:46 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
 by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id B74528081D6;
 Mon,  5 May 2025 17:58:45 +0000 (UTC)
From: verdun@hpe.com
To: verdun@hpe.com, jmverdun3@gmail.com, u-boot@lists.denx.de
Subject: [PATCH v3 0/1] *** Initial Wiznet W5500 support ***
Date: Mon,  5 May 2025 17:58:33 +0000
Message-ID: <20250505175834.26874-1-verdun@hpe.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 04qxTTzuo7gP_wkc5QiEbLMaGZ1weePM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDE3MCBTYWx0ZWRfX4e4stXoUnGDN
 IziYNPrGWpFV80l1O/1LgJc3y3aCEF2/XYRQZZwM4XGE8LSU2PIGCL0zmxfSE1UHba9GVDRDWWm
 YSwmtF2bvY1gQxct24sWw8KQ6LAcF/d3+HGceqrW7DuhDUPYazgk1h+5vFMjVV0xgcjerf9Qjar
 EmR2uAhChCzKnTo4gxsXTfUy6wy2Y1WvLddms+CAhrRmM/WsNg+V6PiPSascOX1xsZ1768rDjXp
 aadzl4wY8d/ZhcvQBj+ZXkIAPIpsPSsZpk1EHb2+/U4M7HBHl8wKMhTeTQRsqkionXx9jly9Fj5
 EzVcX5+StlzeK0+B8X8pjvYsip3+6YgrQrvSACs7yPtgXKhM8AweLcHGQqdn+XjwZjE8ge9CfxJ
 a6kMywPl
X-Proofpoint-ORIG-GUID: 04qxTTzuo7gP_wkc5QiEbLMaGZ1weePM
X-Authority-Analysis: v=2.4 cv=VNPdn8PX c=1 sm=1 tr=0 ts=6818fc7b cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=dt9VzEwgFbYA:10 a=MvuuwTCpAAAA:8 a=woyM-RCIj3Agx3tZ37gA:9 a=zZCYzV9kfG8A:10
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_08,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=883 adultscore=0
 mlxscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0
 malwarescore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505050170
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
 drivers/net/w5500.c  | 618 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 628 insertions(+)
 create mode 100644 drivers/net/w5500.c

-- 
2.43.0

