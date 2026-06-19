Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC88CD98F2
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 23:18:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB7B2849DA;
	Sat, 20 Jun 2026 01:17:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Wl7M00/j";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nqkKgI0y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F38FC849BB; Sat, 20 Jun 2026 01:17:46 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5021E849BD
 for <u-boot@lists.denx.de>; Sat, 20 Jun 2026 01:17:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65JLY7AR095829;
 Fri, 19 Jun 2026 18:17:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=WMuVqjK8p5dHSWUPSmAVNfpn5zpyjePApT5b0VyMz
 MI=; b=Wl7M00/jgwMNyaD6iZi0rgckUmohqgOdoL3vnSFqeoPfEmyVSby7tX/X6
 oXZPfYqKnV19/UuASzi7Mx9ycWHyQw6naZS1sROI8jIpJod7K/CM4wDY4LwDpuWC
 +nd1nZOtmQBKgPywAiOwJPDLVAnFkzct3A6kaGwrxEVhMMmxS1PtycBL1vE9YVz2
 HWfKouyxonzS62qOHoCtgRl/2Mg0dtZs8to16WSZ2oJoEFoyGwkgLG+v4XnKZ/J8
 QCWvMhZFc4nCLIqhAGtUsed0DkP3NcpPvvUuGvRaoLYAP2Lwc3ASrdZrQKEFQW2y
 F8+t/oJDDkD3DMT44IZykinQXC3qw==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010043.outbound.protection.outlook.com [52.101.46.43])
 by m0380145.ppops.net (PPS) with ESMTPS id 4ew4s643k3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 19 Jun 2026 18:17:33 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fsLuwTItpoayO5W6H5ZriB4lddhVEp8gAy03sFaLlbMqF8MRmkRuehY+FlPv9TWVtyfaqdoL0oTiyYj/9uK+vcbu6drp20qP+TssmrZbgbwdrj8X5UTOTNw/As71zK2yipyRavQfN19Tg+cRJaMhAPf4GV8PJbRczo4+dyNqTc9Hvanb0G1pTsY/9oXg1Zeg25bsXmH/SEz1rH7dl0xIivf1mP5OyRxyreYgM57XUF0derk2RQULwkM5eFurFK/a6wEsHF0Vx3PzzppVCe77gKj5H/Ej9onbW/05YaRtgT7fOP9xB3z2Y0svKGKBPkCi4H4F5h/lhmoH3JliRf7pxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMuVqjK8p5dHSWUPSmAVNfpn5zpyjePApT5b0VyMzMI=;
 b=tSDDSfJLcRohk2w2IK38soRBnQZZ6NrHrv+ZkoBNj6s9rfM3fRSX6hYoC1LbRjH6ilb1tSeCu6NWGValUqb0ca8Yg8NJWFPE0zjV4U508nWDAoUXapyxXzFWj3LfRAeY2iWqcYvDeToz/7JSlBbRtr+ezIUrV3QZYCZD2t/nzQ1Dyx65U73MSh0WfOWD4Dq5Ni6uMYT74rvh0jzNE/4VhbdUfcFW359vuREc7C/p4RiHvO1e2cLYNXbUxJi3usVYEx94HJ6ou3TvrsGC/tGSPw50pEnFnsdnEU+9hIH6JunDTawGL/LCt3tlFenkGmvJnJN2xco3RmM3LjCccr1Rxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMuVqjK8p5dHSWUPSmAVNfpn5zpyjePApT5b0VyMzMI=;
 b=nqkKgI0ypJD5m2ZpkDMpgVaFt8ns1V0ofQSiVpjul3jP/fdMEs+QomS0q7tJd6btrJnJvW7+BRsuSjv3bjoVe9NLRMg44qa2HTOsJmYtDicZTh1K7CSC0+gECVOHrOtD99MQ5I2EfZUA8WkEVHlJ90vojss//Vb8M9o/YT9sAD4=
Received: from SJ0PR03CA0139.namprd03.prod.outlook.com (2603:10b6:a03:33c::24)
 by SJ2PR10MB7653.namprd10.prod.outlook.com (2603:10b6:a03:542::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Fri, 19 Jun
 2026 23:17:27 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::87) by SJ0PR03CA0139.outlook.office365.com
 (2603:10b6:a03:33c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.12 via Frontend Transport; Fri,
 19 Jun 2026 23:17:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 23:17:27 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 19 Jun
 2026 18:17:26 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 19 Jun
 2026 18:17:25 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 19 Jun 2026 18:17:25 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65JNHPGX3686026;
 Fri, 19 Jun 2026 18:17:25 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv2 4/5] k3-am62-pocketbeagle2: add support for 1GB variant
Date: Fri, 19 Jun 2026 18:17:18 -0500
Message-ID: <20260619231719.3823195-5-rs@ti.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619231719.3823195-1-rs@ti.com>
References: <20260619231719.3823195-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|SJ2PR10MB7653:EE_
X-MS-Office365-Filtering-Correlation-Id: f3ee54a2-8781-4ca2-80e1-08dece58edbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|921020|13003099007|22082099003|18002099003|3023799007|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: C5IrEBB7m3ka8Pg8u6SwvL8LJeOpLGnYY4RRmTZJCVaWvyqo0QW2xaK4dqyePwjSX8vpdXMNqM3KHL7YrsRFUeVoF8Oy+wVqt8Kc3/FNkI7oI+YTewUr/BJhA0cmyNrPRWN+35OAkdMAQ2w9nmY6J+M9XAn91R1xBu84AxZIv2cOmL+JAtQp7EyDfetzO1ysHC3Y0bulJEVBX9GLaCbSvPfUbMYABrYQ7Z/80DOhGkvTWgJVKKAFMzWujHAvvtNkcoqIQI5l+Mcr2MkNab20iSngm5BuR1sNcxhcxetklSRR/VMKf22jKayzxZqd0b9ua/+y/9pQBwq0U5OACpO6/gW7pB03F9zgljmyEI9KRuw7ZxJbTXOmDJygcWUXxC/YeYIs5pw5P8hUc5DTsapK0fa8qTqwtl3LW0lDhoVDINIOAFFzXiQdsesFfY/noSVjHzf+BljQPEect77LdzmMBA9SvXJDkYv7kjcJ9XJNw3XNzlFL3LKIh1OeyB/7Fv54RUx2ZncmFM8T66rBPcxMKhUqboxJD5/P3cVdNuwWQN5BaePaZNG8SmTWOr8H9LWeCyXJyIly+i8kglPxVXeRwyTEgjzxXdZTZrNTF+hBGk6dyx+oea/eBZrrzO06QHKpn3tz2ZL1NAc5cHVlWIk5PWH5WvRAPuUM58Qze96tZqGPDBAZeIk2Q8pGvLmg37Pl
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(921020)(13003099007)(22082099003)(18002099003)(3023799007)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PLx+DFa6KXaq3KDMLrEMvkdUP+cwYSVE+9AMNkd6gmV/izg9FLRceHzuGZWuAmsLGPyKTrHHRxjibTqvEMDregMmd0stMp1tusvRp5WyTEOJGAwwFHeHy+b6PbYyt88w17jCtW74w1viwHPDJfMsfH4CQJGFdoCzDs0L3uhPNLJocBLLJ9GCcpeFkorXhpKBjQ5yYp6PEzfoZJ98x1tdvmb9pHzaDt+f/rXSdmBQc1XcZj/QIMhg2xJKbvkdl8WU+dN7a1oI3NaxvAopeJKfOHypFG9leBH4lLnGu9jBQO0v+rFjRnlGauwFs+2sjePJrWDAc1SvVE1JbzFAyzu6c8hlNM7y5N6fettmT1+UdyHSwjdl0Us0M9bE5oM2M7MtzlM40/P8N9DcEAuk2irYHU1ZlhPprfMZZEiBy3kXqBRMsbyohvnFR7kn2nFktuZT
X-Exchange-RoutingPolicyChecked: sxRW+PFYvyWBwwvge+4UnvDsgZpda42cF70ollObH43aX0gTuuhb2DA/XYh7XBiSvRJTyTnaVK6CT1uzObMqgNI1vRSDdCAPTyuKRfyDNenOX47YDlPTmOFAe1Eis+WTwCSciZib55mslWIJKIwnCQ2Ol7mD/7RGrjTvd2CsPUHMX97XZ9hkXY+HYdTmIKhMqiu3FM7BDLdjU6Qu4FuzYe6ZZhHLkIe9V4MSNq9aILJleUA+6YkPHwCUKjpj0o4cHZcLaqKrkrbOV1E9fHJ2woJtd5wQwO9fJpc4mYZBcHRm3Vzv0SKIzWMdUpc+i0Xfd65QLZJmC3FnF/dQi9zHmA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 23:17:27.2834 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ee54a2-8781-4ca2-80e1-08dece58edbc
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7653
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyMyBTYWx0ZWRfX+nXImP7tzter
 8HA0JKyOrNLPz8wGlWg8FE/bs35LoIVq0NtVawOgA6PXKic/lt1munR3up+AlHftvURSlmpX9Kl
 tFuJ/97R6g+XxT4+0pWInqCQOubVRN4=
X-Proofpoint-ORIG-GUID: UlRU2G1udTGCJhDBdHPmWg04N68JkXMx
X-Proofpoint-GUID: UlRU2G1udTGCJhDBdHPmWg04N68JkXMx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyMyBTYWx0ZWRfXx+2dTxsLt0MG
 pk1wI2Wxzg8t/54TTtHOPK5VFTtLMfbdLaUIxkI6i6PUwi3VviiclBgq/wzB+vjAqNsQSQcWmXX
 /nj4/CtnCvn7yDqS8oTMAdi+Y0DfSYPFvCtm5bVBJBiJUsY/QqX9kwsRnnH9Guw7yxMs4gxtd+I
 pCa3cU4awPp9yZZICkr7T8vjEkq4rK+YbAZm2c3rZceiey33/fyMo/K4TiK9xsBAwiYZdkStnyt
 L+ci1CzX4ihnv9JVjIZeWUvhVc/BHdv2l5L6Z5wcvYHsCcKEMN1Q5H8+iJko53IzlsvvdAUE9uX
 ugdh/GOI/l1AczxgGaIL+oCkfc6n7N1JRxRJlDOxydWBOmv710ih1C0ZF38Sc+YQyTe2xbALNog
 Kh+iMdUd3Tvov1nbIihRfLs62FeiWpGP/PjQU4A290oCIooNMlOF48tq6y49Ct3dsqG4F7pGd/s
 xwT1mZZMLs8W52j3dfA==
X-Authority-Analysis: v=2.4 cv=P6QKQCAu c=1 sm=1 tr=0 ts=6a35ce0e cx=c_pps
 a=BNrqkoHBqsJX0pt4tOnUqg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=lLZmtIKjAAAA:8 a=NEAV23lmAAAA:8 a=fGhLjsSNAAAA:8
 a=sozttTNsAAAA:8 a=mb9bpXRMdmiVFoUIA2EA:9 a=q5Nj8NTjyn2D8kUwajRn:22
 a=LYKFdyShAPKLkGq8p7WX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190223
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

From: Randolph Sapp <rs@ti.com>

Take Phytec's current DDR fixup functions and utilize them to
dynamically adjust for variants in the pocketbeagle2. There are
currently 3 skews, two of which are both 512MB with the same memory
configuration, and one which is 1GB using the same CWL and CL settings
but a modified density [1].

Based off of Bryan Brattlof's patch [2].

[1] https://mm.digikey.com/Volume0/opasdata/d220001/medias/docus/5411/8G%20Bits%20DDR4%20SDRAM.pdf
[2] https://github.com/bryanbrattlof/beagleboot/commit/fb2f022e27427e990d7a33fd001ffb571e13cfc3

Signed-off-by: Randolph Sapp <rs@ti.com>
---
 board/beagle/pocketbeagle2/Kconfig            |  26 +++++
 board/beagle/pocketbeagle2/Makefile           |   2 +
 board/beagle/pocketbeagle2/pocketbeagle2.c    | 103 +++++++++++++++++-
 .../beagle/pocketbeagle2/pocketbeagle2_ddr.h  |  50 +++++++++
 configs/am62_pocketbeagle2_r5_defconfig       |   5 +-
 5 files changed, 184 insertions(+), 2 deletions(-)
 create mode 100644 board/beagle/pocketbeagle2/pocketbeagle2_ddr.h

diff --git a/board/beagle/pocketbeagle2/Kconfig b/board/beagle/pocketbeagle2/Kconfig
index e957b8e8377e..a361fcebfc1d 100644
--- a/board/beagle/pocketbeagle2/Kconfig
+++ b/board/beagle/pocketbeagle2/Kconfig
@@ -12,6 +12,7 @@ config TARGET_AM62X_A53_POCKETBEAGLE2
 	select ARM64
 	select BINMAN
 	select OF_SYSTEM_SETUP
+	imply TI_I2C_BOARD_DETECT
 
 config TARGET_AM62X_R5_POCKETBEAGLE2
 	bool "BeagleBoard.org AM62X PocketBeagle 2 running on R5"
@@ -23,6 +24,7 @@ config TARGET_AM62X_R5_POCKETBEAGLE2
 	select K3_DDRSS
 	select BINMAN
 	imply SYS_K3_SPL_ATF
+	imply TI_I2C_BOARD_DETECT
 
 endchoice
 
@@ -58,3 +60,27 @@ config SPL_LDSCRIPT
 source "board/ti/common/Kconfig"
 
 endif
+
+config POCKETBEAGLE2_AM62X_RAM_SIZE_FIX
+	bool "Set the PocketBeagle 2 RAM size instead of detecting it"
+	default false
+	help
+	  RAM size is automatically detected through the device revision stored
+	  in EEPROM. This overrides the detection logic with a fixed value.
+
+choice
+	prompt "PocketBeagle 2 RAM size"
+	depends on POCKETBEAGLE2_AM62X_RAM_SIZE_FIX
+	default POCKETBEAGLE2_AM62X_RAM_SIZE_512MB
+
+config POCKETBEAGLE2_AM62X_RAM_SIZE_512MB
+	bool "512MB RAM"
+	help
+	  Set RAM size fix to 512MB for the PocketBeagle 2.
+
+config POCKETBEAGLE2_AM62X_RAM_SIZE_1GB
+	bool "1GB RAM"
+	help
+	  Set RAM size fix to 1GB for the PocketBeagle 2.
+
+endchoice
diff --git a/board/beagle/pocketbeagle2/Makefile b/board/beagle/pocketbeagle2/Makefile
index 3d42c160716e..dd529fe6d75e 100644
--- a/board/beagle/pocketbeagle2/Makefile
+++ b/board/beagle/pocketbeagle2/Makefile
@@ -7,3 +7,5 @@
 #
 
 obj-y += pocketbeagle2.o
+obj-${CONFIG_K3_DDRSS} += ../../phytec/common/k3/k3_ddrss_patch.o
+obj-${CONFIG_TI_I2C_BOARD_DETECT} += ../../ti/common/board_detect.o
diff --git a/board/beagle/pocketbeagle2/pocketbeagle2.c b/board/beagle/pocketbeagle2/pocketbeagle2.c
index 1b124a3d8c38..ea8d21310752 100644
--- a/board/beagle/pocketbeagle2/pocketbeagle2.c
+++ b/board/beagle/pocketbeagle2/pocketbeagle2.c
@@ -15,8 +15,41 @@
 #include <spl.h>
 #include <asm/arch/k3-ddr.h>
 
+#include "../../ti/common/board_detect.h"
+#include "pocketbeagle2_ddr.h"
+
 DECLARE_GLOBAL_DATA_PTR;
 
+static int pocketbeagle2_get_ddr_size(void)
+{
+	// check config overrides first
+	if (IS_ENABLED(CONFIG_POCKETBEAGLE2_AM62X_RAM_SIZE_FIX)) {
+		if (IS_ENABLED(CONFIG_POCKETBEAGLE2_AM62X_RAM_SIZE_512MB))
+			return EEPROM_RAM_SIZE_512MB;
+		if (IS_ENABLED(CONFIG_POCKETBEAGLE2_AM62X_RAM_SIZE_1GB))
+			return EEPROM_RAM_SIZE_1GB;
+	}
+
+#if IS_ENABLED(CONFIG_TI_I2C_BOARD_DETECT)
+	// dynamically detect the config if we can
+	if (!do_board_detect_am6()) {
+		struct ti_am6_eeprom *ep = TI_AM6_EEPROM_DATA;
+
+		if (strlen(ep->name) > 11 && ep->name[0] == 'P') {
+			/*
+			 * POCKETBEAGL2A00 (am6232 512MB)
+			 * POCKETBEAGL2A10 (am625 512MB)
+			 * POCKETBEAGL2A1I (am625 1GB)
+			 */
+			if (!strncmp(&ep->name[11], "2A1I", 4))
+				return EEPROM_RAM_SIZE_1GB;
+		}
+	}
+#endif
+
+	return EEPROM_RAM_SIZE_512MB;
+}
+
 int dram_init(void)
 {
 	return fdtdec_setup_mem_size_base();
@@ -36,10 +69,78 @@ int board_setup_dest_addr(void)
 	return 0;
 }
 
+// logic after this block assumes that there is only 1 DRAM bank currently
+#if CONFIG_NR_DRAM_BANKS != 1
+#error Unsupported number of DRAM banks!
+#endif
+
 int dram_init_banksize(void)
 {
-	return fdtdec_setup_memory_banksize();
+	eeprom_ram_size ram_size;
+
+	memset(gd->bd->bi_dram, 0, sizeof(gd->bd->bi_dram[0]));
+
+	ram_size = pocketbeagle2_get_ddr_size();
+	switch (ram_size) {
+	case EEPROM_RAM_SIZE_1GB:
+		gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+		gd->bd->bi_dram[0].size = SZ_1G;
+		gd->ram_size = SZ_1G;
+		break;
+	case EEPROM_RAM_SIZE_512MB:
+		fallthrough;
+	default:
+		gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+		gd->bd->bi_dram[0].size = SZ_512M;
+		gd->ram_size = SZ_512M;
+		break;
+	}
+
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_K3_DDRSS)
+static int update_ddrss_timings(void)
+{
+	int ret = 0;
+	eeprom_ram_size ram_size;
+	struct ddrss *ddr_patch = NULL;
+	void *fdt = (void *)gd->fdt_blob;
+
+	ram_size = pocketbeagle2_get_ddr_size();
+	ddr_patch = &pocketbeagle2_ddrss_data[ram_size];
+
+	if (!ddr_patch)
+		return ret;
+
+	ret = fdt_apply_ddrss_timings_patch(fdt, ddr_patch);
+	if (ret) {
+		printf("Failed to apply ddrs timings patch: %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+int do_board_detect(void)
+{
+	void *fdt = (void *)gd->fdt_blob;
+	u64 start[] = { gd->bd->bi_dram[0].start };
+	u64 size[] = { gd->bd->bi_dram[0].size };
+	int ret;
+
+	dram_init();
+	dram_init_banksize();
+
+	ret = fdt_fixup_memory_banks(fdt, start, size, 1);
+	if (ret) {
+		printf("Failed to fixup memory banks: %d\n", ret);
+		return ret;
+	}
+
+	return update_ddrss_timings();
 }
+#endif /* CONFIG_K3_DDRSS */
 
 #if IS_ENABLED(CONFIG_BOARD_LATE_INIT)
 int board_late_init(void)
diff --git a/board/beagle/pocketbeagle2/pocketbeagle2_ddr.h b/board/beagle/pocketbeagle2/pocketbeagle2_ddr.h
new file mode 100644
index 000000000000..c144dbafe059
--- /dev/null
+++ b/board/beagle/pocketbeagle2/pocketbeagle2_ddr.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * DDR override logic for AM625 PocketBeagle 2
+ * https://www.beagleboard.org/boards/pocketbeagle-2
+ *
+ * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#ifndef __POCKETBEAGLE2_DDR_H
+#define __POCKETBEAGLE2_DDR_H
+
+#include "../../phytec/common/k3/k3_ddrss_patch.h"
+
+typedef enum {
+	EEPROM_RAM_SIZE_512MB = 0,
+	EEPROM_RAM_SIZE_1GB = 1
+} eeprom_ram_size;
+
+struct ddr_reg ddr_1gb_ctl_regs[] = {
+	{ 317, 0x00000101 },
+	{ 318, 0x1FFF0000 },
+};
+
+struct ddr_reg ddr_1gb_pi_regs[] = {
+	{ 77, 0x04010100 },
+};
+
+struct ddrss pocketbeagle2_ddrss_data[] = {
+	// default configuration
+	[EEPROM_RAM_SIZE_512MB] = {
+		.ctl_regs = NULL,
+		.ctl_regs_num = 0,
+		.pi_regs = NULL,
+		.pi_regs_num = 0,
+		.phy_regs = NULL,
+		.phy_regs_num = 0,
+	},
+
+	// industrial configuration
+	[EEPROM_RAM_SIZE_1GB] = {
+		.ctl_regs = &ddr_1gb_ctl_regs[0],
+		.ctl_regs_num = ARRAY_SIZE(ddr_1gb_ctl_regs),
+		.pi_regs = &ddr_1gb_pi_regs[0],
+		.pi_regs_num = ARRAY_SIZE(ddr_1gb_pi_regs),
+		.phy_regs = NULL,
+		.phy_regs_num = 0,
+	},
+};
+
+#endif /* __POCKETBEAGLE2_DDR_H */
diff --git a/configs/am62_pocketbeagle2_r5_defconfig b/configs/am62_pocketbeagle2_r5_defconfig
index 90e577e8ce16..82919d559d5e 100644
--- a/configs/am62_pocketbeagle2_r5_defconfig
+++ b/configs/am62_pocketbeagle2_r5_defconfig
@@ -14,7 +14,7 @@ CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="k3-am62-r5-pocketbeagle2"
 CONFIG_DM_RESET=y
-CONFIG_SPL_SYS_MALLOC_F_LEN=0x7000
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x8000
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
@@ -41,6 +41,7 @@ CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_EARLY_BSS=y
 CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x400
+CONFIG_SPL_I2C=y
 CONFIG_SPL_DM_MAILBOX=y
 CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_POWER_DOMAIN=y
@@ -72,6 +73,8 @@ CONFIG_SPL_CLK_K3_PLL=y
 CONFIG_SPL_CLK_K3=y
 CONFIG_TI_SCI_PROTOCOL=y
 CONFIG_DA8XX_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_OMAP24XX=y
 CONFIG_DM_MAILBOX=y
 CONFIG_K3_SEC_PROXY=y
 CONFIG_SPL_MISC=y
-- 
2.54.0

