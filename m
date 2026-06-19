Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 181D8CD98F2
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 23:17:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A4C384873;
	Sat, 20 Jun 2026 01:17:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="W7PTSVjF";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rS6pZ6Wt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5180B849C5; Sat, 20 Jun 2026 01:17:44 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47E2F84874
 for <u-boot@lists.denx.de>; Sat, 20 Jun 2026 01:17:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65JLXwo33073581;
 Fri, 19 Jun 2026 18:17:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=iVo2NQB+vN1l9
 ImDgYQ8BiwgBGBOT2qpKmy3XTavwW0=; b=W7PTSVjFI4LJkZoB2k0BwPx5oHADj
 MjWaHxSl2RGJrgwaYrq7+xIxbqDGE8gZu9YSmH+A9xIAA7P4ToOmdLArEU/Jt4ic
 G569At5hC4txhCC703d9dhMcs+LzHAP4Av+XjOIQBNge6/gU2+8tGJWUtu25bKLP
 4SzSCT7bntp5cSM55HojqGNiqlVKAkP9Y2aBATWR+/EKCqGJGdZ5W42W84gyFfCd
 +uP9LtJDKeBrcBcyUgTVdAR/hPADZzM/B4QwQNvAuoBBjIWmHMP5RsLeWHbX3dJm
 lEbSlk2iiHF7JtVqxlVeTt2/FU//GA9xR/n7TQvD1MwBE4XMgaBh755gw==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012044.outbound.protection.outlook.com
 [40.93.195.44])
 by m0384305.ppops.net (PPS) with ESMTPS id 4ew5x93re1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 19 Jun 2026 18:17:30 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q38IHBzyKgV3q4aow8BfkvNKCtSKWmwdN2gRtAvHKmFfhUZKSxK/cM4u8GAal6IyCtpWxzz5XX2u9fKqajoxQPLFzzFSSaLFbBIVZ1yYwzRoU8hKNVj79VfcNVxkmhKQe0M7z1LT/7g6SjL5aL5Lxzq362VCl3+hO5IhTCGA6ISWtUQOrYxQG5YRAtUHQ+RgvV4+z1zQh/Hft810nsf+VW+TMot9T23Ykghd+4SDsXkM94C7XrEuaLcIGJO3oySXs3PRVQmdVsVx5zy+MUMdzLbA3zlRHp6HtkQsv5+1i3XZjRuL9ik0gWyiSeROV5wlW6OXpmLvUAyNkJgOEis7vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVo2NQB+vN1l9ImDgYQ8BiwgBGBOT2qpKmy3XTavwW0=;
 b=gp2FotSyG8chXdYnFzqbqZs+3iWus2Wy/ho0WhAHhWTOwcDu+729OH6QNu5NEhtMroJTlCNfcIo5sZClZw8MM/e57ADcO1ZaFeV4+e9KR+Vv7Uu2CWC/hq3cfneJJW9Bkc3Tz1BybxGLRMRV2sQmpcEImzvwK4ifYX2I9AJ9wax7qP6lciOAk+dkM5uP7jBWPmP50EY+RZ9YlbkAO0/XatP9SbysPUBS9KDhgJgkJAwWWhr3A1wGR9XcB0vMc0QYKt3BgQ5pgsqZhsFsYm2S9+v81NzSvJJM1fduIOjj4YX9XvT/TxwhJB1oj+L+USrNL/X4DbLkbqnLyyRbKDgZDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVo2NQB+vN1l9ImDgYQ8BiwgBGBOT2qpKmy3XTavwW0=;
 b=rS6pZ6WtZch1DfG+XoK71vNnlgboHQJmA6UO249ROEd/vci2Sfb4pjWRy7Prle2KE3l3fBLZMKoM9YTdNgerIr6PZjyuTplYlID0T7hrj3wPeUxTj1HBEKI0p7FMaTOabEZnXkLsRqlu9fPThGx6QegQsfzhct4n6hz8V6/Ow2Q=
Received: from CH2PR03CA0013.namprd03.prod.outlook.com (2603:10b6:610:59::23)
 by LV3PR10MB7796.namprd10.prod.outlook.com (2603:10b6:408:1ae::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 23:17:27 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::67) by CH2PR03CA0013.outlook.office365.com
 (2603:10b6:610:59::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Fri,
 19 Jun 2026 23:17:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 23:17:26 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 19 Jun
 2026 18:17:25 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 19 Jun
 2026 18:17:25 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 19 Jun 2026 18:17:25 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65JNHPGT3686026;
 Fri, 19 Jun 2026 18:17:25 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv2 0/5] k3-am62-pocketbeagle2: add board and variant support
Date: Fri, 19 Jun 2026 18:17:14 -0500
Message-ID: <20260619231719.3823195-1-rs@ti.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|LV3PR10MB7796:EE_
X-MS-Office365-Filtering-Correlation-Id: a127cba3-0f7a-4da5-48d9-08dece58ed84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|18002099003|6133799003|13003099007|56012099006|921020;
X-Microsoft-Antispam-Message-Info: hnu8qCGh4PhKc5GQeQppB3aQR45r/Wxsv73zFIKN4PNzS0aI/+Nyt24M4j9NBqOit2Wad+/A/+9QPsvAJuzEpqXLXglcyaRltuJ3GqbfY6rIr8dy0kMa3fFYu1sl76Q6Dop3xhOJri7gx+ADRMeoDohha1Dl4L3CP3OCPD7EezXkR5/lckGaywgzvFsYNyilmX3g2lvzTH11OmKogShgk8TiHTTeHmzAszC1Sj0bgIVZl9qhTUGveqP87iye8Dohqr0ZaT7UaFeAxynhXyHfYJpkaZ1sSHGX3zubgGKb4G91IkDqU1Y5YMqgoBAWRahKz2nLmKVfGrjUogIyKCGsRUkWuXham7BT6ANvteZvhxpMrMi2nVAElclaOCJIJvPdtk4VxPmLU0d2mNHaZ+kV9r8RtKGrgy53XGqLvbrcMraS9oYrxUBC2beWvrjcWUt2Jtgk1Fw6Yu/8lM/+AGOdhKSN2CliRjyQOpLxkydqR9zsJjtKvgvA3zSHSADuWiiQM4otyAShxK8ZyOnahUUHEqbFsTBF25LnLvfMfNzJW3EAehi6/DurzCbVxsr7QO0CMjp3/UBEAYgtLDzQSkFCcvJubu9A59+eEUGp3lFPAY+i2qz+PKD+eM6kmDmUhCHkAzBIcxXW21aw+z9oGtM/99cgyWP31adGTcq0M8MXh1EwOOVjSV34JUSI/mnleffwjr+X7yPh5PeYh03W8TDUHOAui4nWWC12vqp8Aij4i/hOsAt9S0wMlEOGKGWsp+o9
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(18002099003)(6133799003)(13003099007)(56012099006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rhZ6ukJbieKiZFj09b9hS8dX4CpsoXJHBZQCY6DRLDj/+jduOYB25MMAzIPGCxtdmJm11+Eq1BegNHpbdSuzuQ8a70NRV5BHH+Yl87JKtUvFX/s7aBpu+V7Rs4b4dNHznWDqT1AQsyfMV+KDZf7UjLm0lCQTPK+8tpq2PFDNZdszgxEhP75Rzyx5WKkrJEWG0dU01jqdOFtqWJmxR6DJHgcrKC9ji3Jt6Yo+qDzqRkG7r1ZfOrOWYEDXE3FJTjLEhy3VY1kUHhMGazE7PBcz35/HTNuZ97pcCA2QQEetxOd7YY+VHEyF5RDVAuLUkhk901NFOFyCq7yzYYg1fzNqEVLiH0pJCWzQ2onI/P60VB31Vqp7dyot1ccmbt2fIiiwAaAPSAlpYs8ijmChzJ+GM+ZxkC3Oo1HYAqBKpH96VcUpXiVt5XnlUAOFFvaaGdqh
X-Exchange-RoutingPolicyChecked: WOjCK+4VQOioSbcApe1wqN/GcfDPJWy+Uw0D8U+t0FgEDukxx9HsVghMLdpfATtGFJLOXVjvYTeIP/PoyYWdKIlvR5o+V+ZXVwtuf+3lq4Ko7BhLprAG8WhzIoFcV+XWJx0U+Em1rJ13/eBdXQp0fiUsUojz6lTUN/49Ymi7Yy43w/O2kHbWTo+tcvcS57yzflyU0Qi1v2xFzJD5HrgUmJ4fQaVqf4QmRPYU3D6BnVAkfGAOOXncyaCLDv7B7TF1BWIuWjrhNo9La7bXLLV8K+Eh6g1OSJrSju3i4krfd+nCJGyxKSkBb6CG2GIpeBYjXX9En0SVcHaOHbPV+QKnCA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 23:17:26.9440 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a127cba3-0f7a-4da5-48d9-08dece58ed84
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7796
X-Proofpoint-ORIG-GUID: DVhQ75vTUN1vYQUY-V8a3SQKDXhvPieK
X-Authority-Analysis: v=2.4 cv=B+eJFutM c=1 sm=1 tr=0 ts=6a35ce0a cx=c_pps
 a=QCcpiOQK2QUg/MYG9+G9Tg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=NEAV23lmAAAA:8 a=sozttTNsAAAA:8 a=fGhLjsSNAAAA:8
 a=FvgNnJ6L-cHGxMVQW6QA:9 a=LYKFdyShAPKLkGq8p7WX:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyMyBTYWx0ZWRfXxCg51c3sAKA7
 O27iLLpQaTGMB/k9HATvv1u/GnUNqsbbE1j2yt2/2e7/3tICAdaCYAqvhHe4zMHur1XHl9mNIrn
 iMur0ojqrSbiVu1IiJ+n6XiJe+yCy3w=
X-Proofpoint-GUID: DVhQ75vTUN1vYQUY-V8a3SQKDXhvPieK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyMyBTYWx0ZWRfX9G9RsNlYicmK
 pcsP6xUtgn0XEZdJO3QjjYcmMy/DK8xCUJp6tK1Lqd/RDswhhAly7EWwJ00iFl/m+eInZVQlvU3
 ulPRcp3fGFKQafl72dWp3xsEYiweyi3GLRvFqg4pzJjU2STrPis9T5adXcYuw1ejMjlmJ3sFsvG
 GNsU/0v6KRy2iPDvFzprY8pjCJ+dNaEb8ejb22hogZrbfoFJMLXwEfWbhvlwW7ibUU2zyH2jezU
 OvcWGtlaYfV5d77bdEXjZGoWuhURcx6W6KqaYLtEyswWo/Djc4U7E1VUEGQEQ90rUq3PKQCudHe
 644npw1zYU3N7SSxjlx74gONAvnUjtOB9+PIeQB3Vklbg0jhK+PNmP9pDQzUXyRdBQNjaZ/VP2X
 /0EZ901gSpwEQiERm74sJnLfMkKjnFEgZHriCnqV50WJFupjEyrvLnrcMtvXIhcNW0fLAiLdQpB
 LmcCHLJjE8fsY+8jBKg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1011 adultscore=0
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

Add initial board support for the PocketBeagle 2 from BeagleBoard.org. This is
based on the current official series from Robert Nelson [1] and work from Bryan
Brattlof [2] with some light modifications to protect against certain
configurations changes.

This borrows a lot from Phytec's current DDR fixup logic, as that seems to be
the most complete implementation of a dynamic DDR correction for K3 in tree
currently. Thanks Wadim Egorov and Dominik Haller for setting that up.

Now that the various memory issues have been resolved we can clearly see at
runtime that there's an issue with the current device. One of our reservations
overlaps with the u-boot stack. To get around this we'll need to change the
relocation address to something we know will not collide.

[1] https://github.com/beagleboard/u-boot/tree/v2026.01-am62-pocketbeagle2
[2] https://github.com/bryanbrattlof/beagleboot/tree/b4/pb2i

Bryan Brattlof (1):
  arm: mach-k3: am62: add &main_uart6 to clock and pwr tree

Randolph Sapp (4):
  board_f: add a board_setup_dest_addr function
  k3-am62-pocketbeagle2: add initial board support
  k3-am62-pocketbeagle2: add support for 1GB variant
  k3-am62-pocketbeagle2: add support for efi capsules

 arch/arm/dts/Makefile                         |   1 +
 ...> k3-am62-pocketbeagle2-ddr4-1600MTs.dtsi} |  92 ++---
 .../arm/dts/k3-am62-pocketbeagle2-u-boot.dtsi | 336 ++++++++++++++++++
 arch/arm/dts/k3-am62-r5-pocketbeagle2.dts     |  35 ++
 arch/arm/mach-k3/am62x/Kconfig                |   1 +
 arch/arm/mach-k3/r5/am62x/clk-data.c          |  19 +-
 arch/arm/mach-k3/r5/am62x/dev-data.c          |   5 +-
 board/beagle/pocketbeagle2/Kconfig            |  86 +++++
 board/beagle/pocketbeagle2/MAINTAINERS        |  10 +
 board/beagle/pocketbeagle2/Makefile           |  11 +
 .../board-cfg.yaml                            |   0
 .../{beagleplay => pocketbeagle2}/pm-cfg.yaml |   0
 board/beagle/pocketbeagle2/pocketbeagle2.c    | 183 ++++++++++
 .../pocketbeagle2/pocketbeagle2.env}          |  23 +-
 .../beagle/pocketbeagle2/pocketbeagle2_ddr.h  |  50 +++
 .../pocketbeagle2}/rm-cfg.yaml                |   4 +-
 .../sec-cfg.yaml                              |   0
 common/board_f.c                              |   9 +
 ...onfig => am62_pocketbeagle2_a53_defconfig} |  25 +-
 ...config => am62_pocketbeagle2_r5_defconfig} |  16 +-
 doc/board/beagle/am62_pocketbeagle2.rst       | 279 +++++++++++++++
 doc/board/beagle/index.rst                    |   1 +
 include/configs/pocketbeagle2.h               |  39 ++
 23 files changed, 1142 insertions(+), 83 deletions(-)
 copy arch/arm/dts/{k3-am62x-sk-ddr4-1600MTs.dtsi => k3-am62-pocketbeagle2-ddr4-1600MTs.dtsi} (97%)
 create mode 100644 arch/arm/dts/k3-am62-pocketbeagle2-u-boot.dtsi
 create mode 100644 arch/arm/dts/k3-am62-r5-pocketbeagle2.dts
 create mode 100644 board/beagle/pocketbeagle2/Kconfig
 create mode 100644 board/beagle/pocketbeagle2/MAINTAINERS
 create mode 100644 board/beagle/pocketbeagle2/Makefile
 copy board/beagle/{beagleplay => pocketbeagle2}/board-cfg.yaml (100%)
 copy board/beagle/{beagleplay => pocketbeagle2}/pm-cfg.yaml (100%)
 create mode 100644 board/beagle/pocketbeagle2/pocketbeagle2.c
 copy board/{ti/am62x/am6254atl.env => beagle/pocketbeagle2/pocketbeagle2.env} (56%)
 create mode 100644 board/beagle/pocketbeagle2/pocketbeagle2_ddr.h
 copy board/{phytec/phycore_am62x => beagle/pocketbeagle2}/rm-cfg.yaml (99%)
 copy board/beagle/{beagleplay => pocketbeagle2}/sec-cfg.yaml (100%)
 copy configs/{am62x_beagleplay_a53_defconfig => am62_pocketbeagle2_a53_defconfig} (88%)
 copy configs/{am62x_beagleplay_r5_defconfig => am62_pocketbeagle2_r5_defconfig} (86%)
 create mode 100644 doc/board/beagle/am62_pocketbeagle2.rst
 create mode 100644 include/configs/pocketbeagle2.h

-- 
2.54.0

