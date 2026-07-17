Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6209DC44516
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 10:43:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACB4884DDE;
	Fri, 17 Jul 2026 12:43:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="d/I9Zl/B";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FUoPa6s+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4194484E03; Fri, 17 Jul 2026 12:43:20 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EF6284DF4
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 12:43:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HAQvxX2239566; Fri, 17 Jul 2026 05:43:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=fLIacTKpgL5Oka3rwnC4L++alO9kv5RKDxoC5lQTk
 UI=; b=d/I9Zl/BXj9F34eDUr5o2xp4Q/YGx1s64wCF7SfRK+KfCLPhl7siFBfsM
 8yK6gebosEIEYHYMM7R2zorGc3XuArh7I7iwLRn3fPmpMoctAuN5Nl0MI0NDfRxx
 5pLmb2ttXKmvskgYr1a6go3K713lSe3DoKgNEu5eZ0R5S1jPaQikdfMWeNaJDafI
 DNOE1SCqiImm8fR6g56l3oyymWhcm8EJ5GN+f1FKMrB7/0j2N1uvO6MzujpWvVJN
 Sb/c/BMumm2/u0Zx+ZuQmTMCqdYWUSJMTBVKA0C8m7mpSlRfm4dOWqjcy23npcvf
 yqrr6YS+xR7jLqFbC4rxrjMCSy+tA==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012017.outbound.protection.outlook.com
 [40.93.195.17])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4ff2ccw0u7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 17 Jul 2026 05:43:13 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qX+LKU23jiUVqwatfjrdzMwFJ7xtBUyzJajKz57L9WV07NCrCwDVp3nzGRZ/UdWdJDNUxzALwfs3kXXcaKqpltpQz1YEgb9PtTttPqoDQctQBLW1wZZzvyhFz+B2RpYOW+l0rpnh/S0ipFZ1Wjwm2VfHylBbIxcpIz1+AM3ZshBRqCxO1Rae60YAsb99hmFhzK6S0icjSLn0kfkDd4qmbB2vGMskw0Iz9K8UVSJ95gs9Z012gXl7jl/4uFNnDhDP290pWNBRYjeLehrJTdahMQE7ZSxVkYPe8kkhbZB3X04v25OMaqrHgo/EbNh6dMZnv0cIHaonmmDho+ksgqPC6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLIacTKpgL5Oka3rwnC4L++alO9kv5RKDxoC5lQTkUI=;
 b=wepclYmG4Jp2cwHOrvF/3Z+yxumYfRtzgRLwnRnDTMyzr9V9xd9v8a7AfeRe5jw+lVQjmMVA+GY9uCppaT9Fe/nmx5FtcQjm5pknVS7Ppr5X3uSwM3fejhwFUz0VQksx1Wa4G8RYZgFgZ4MuF8wABOO47JeTlWQdB5iQl/fkymeNNwzxXVxLGMhj4BmKvmmW4uEZqMnmw0KMD5SJv6vEtwvmhRbpCW/Lo9mWxe41ybiFzHAL0hppVrWuj8CIhWr3k5OjETX+BFJdAnxXcTsZp7yIqltP7D6gxrzdCQkwmKqlRfjYX1gLwL1peaKSOyrehm+rDYheMPaSMEKTtDypYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=toradex.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLIacTKpgL5Oka3rwnC4L++alO9kv5RKDxoC5lQTkUI=;
 b=FUoPa6s+BFcHE9cxZCJD9VDvrRwBWhh7+2l6GhAo/0xZuRCZqyczTsH/wyCC1cbgQ7vC5gjbAtNNLw6o+1iCGYq0/f1WxvRwXcQEQTcsXckSJKtvHJrH82hHi7zjNyFjpk2zNYf/gj4DGM0hFgT3g2tjaEj4uNwBGpXHytStS9c=
Received: from LV3P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::23)
 by MW5PR10MB5825.namprd10.prod.outlook.com (2603:10b6:303:19a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.23; Fri, 17 Jul
 2026 10:43:07 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:234:cafe::75) by LV3P220CA0022.outlook.office365.com
 (2603:10b6:408:234::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 10:43:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 10:43:05 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 05:43:01 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 05:43:01 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 17 Jul 2026 05:43:01 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66HAh0rj3016965;
 Fri, 17 Jul 2026 05:43:01 -0500
From: Anshul Dalal <anshuld@ti.com>
Date: Fri, 17 Jul 2026 16:12:53 +0530
Subject: [PATCH 2/2] arm: dts: k3-am625: add template for tispl.bin
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260717-k3_binman_refactor-v1-2-4089220b4fd4@ti.com>
References: <20260717-k3_binman_refactor-v1-0-4089220b4fd4@ti.com>
In-Reply-To: <20260717-k3_binman_refactor-v1-0-4089220b4fd4@ti.com>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Nishanth Menon <nm@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, Wadim Egorov <w.egorov@phytec.de>, "Francesco
 Dolcini" <francesco.dolcini@toradex.com>, Aristo Chen
 <aristo.chen@canonical.com>, Suhaas Joshi <s-joshi@ti.com>, Bryan Brattlof
 <bb@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Ernest Van Hoecke
 <ernest.vanhoecke@toradex.com>, Sparsh Kumar <sparsh-kumar@ti.com>, "Anshul
 Dalal" <anshuld@ti.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784284977; l=29023;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=3qzCyS8HUX83+TOiyPydxdI9xX+XkuXqZc5xAjcmp/0=;
 b=enVgf+6CmYyticCjdcpEeCDjoYWXTyI2YEdRyTlQ4IEIjyNPDvM8bgBSLJwtoXWjmgn7Clyez
 klwUZCu+by7Bl7+u4R5JbAVSj+OQKX3xIAcF3S+LXQrS4Q11hTTKFNN
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|MW5PR10MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: 918c82f5-8979-4110-62a2-08dee3f02f06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|6133799003|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: ktUXBTyeVmPY7tSoEFMlzOTvHm21IRdMEQhhTxq+A1n/Kr1eA6fm8HjmeXzf29hlsPWuOe+0yR30cfMF1v9WzJZ4f5FUuvFucmJDEjm6WwnDPdQil/SJL54o4Q1oKaz2AQEtaTgxp1cyek/YCyoOsN+4v2s/CEIsogKaEYLsTPuN8wI7u4ib4it+wycumy8sEUa0Au6U1ajXrigv7sLS4GyHrYgMU/KKMML5HbaZfYMxP/zvXBpIAGqC570HYcceJlvAWIcecZrKb1qOfsADiTAiq4UEACpTXJEpojxLbHGCp/W9PNGCa1UvSzCu0mIgufxujlwSkbGyRxjepsCD5G4u3AEeVL+T78FvaIaaiPZDEIUzQg0dLh82N2EddlCsS6YjhyXGrPwIE+6hH54j4Fo2Yb4ANWj7s+HOxbovu1g2aIO14SEvLxozb/j5qzk5AKinhNvJaU4Vo9R/UZtbwm8mNhEut16Bu5oMj1W9X3wJxTz1J1c7B/h5Ld0QXH2sXV0RpcPZM4hkuJDzkscBi85DV/4rOJqPGmlX1HXn9pYA6qP77HQsbWVujGSdIao6jvxoGThBxg3H4MaujnM+MdKngAzEiq+WA41QfuKeLLV9veEVxx5n0ID2Vc94H8XOJ1PRRMbgUkPnU7nUgWdxb1WcZyfI8jtai0ii7MpYppJp66eOqf2f0T3vsswDtI4xW6yJB2p/jewYwcdUT1i2Ew==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(6133799003)(56012099006)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MQRJi/s3XNNOb2sGirEwWvLlK3fH/nA3vz9J5tkIgVsXx1Ri5lJng+GTHQRuja7Ou8+LReT3GJwNFjAP2pJ77DDLidFDPGQcB43b0+p2llzo+evpKPbbcnkNr++aSXvaJvLBX1kXm89RraP5EbB9b/BsP09C6/ApUuaX1Oa5TBeZuhllkrrBURTO1Rcwj0dLO/55U+S0d1YyAUouj9J0a+OsR3XSV5H227276ncKV5uzBPjkMJR7qlKFqoUz3ukOStwN2kTkS2kkd04115C3qvGHe4OhtqFxR4wczFbo+2EZe+xjyhKJFnEDkJynbZwyfnOjLdzSPV89e4hBzPlLS/wMJGPiu9ohgJ1UGpTSn8ZuL/xhwL9zvsHVZ6nMB15jF6nSUzwYqaPgaCI2cNi5Meb7kDu6LMOfQ+Mba+dOc0m6uWXPfQJFi3cg5jGggliK
X-Exchange-RoutingPolicyChecked: CPThERq3AOcqg1/C4YCMNm56sozscoVx3LaqZE7o2d1oIT/ghdwR+h9xwyk/jrN4wk7um2gP3vlY1ksrnShOH9+EXfp0nAcAoUVkfcy9kS8ZuDXxu3C3o+27G/76OtzXcC+qQZ3olMCnMl1GeoBorL4nxji49M1KEDSgeLJkM88cMCp2IvSpaS89LK++4To5boZFB7lgyY5dhxRa6N5oIdKFWddTDa6FrFQhE/etCwf2sbqVFFS9HjcI1sO5sIkXGKMqzzf97kbJ5XxJ+16ydV0mh+kYDLdfpm4xZZ6OqpB7zhS/BkTuX1iA/vDfnSEHDBBdH76G7SGh2SW9Ccqkdg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 10:43:05.2585 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 918c82f5-8979-4110-62a2-08dee3f02f06
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5825
X-Authority-Analysis: v=2.4 cv=NtvhtcdJ c=1 sm=1 tr=0 ts=6a5a0741 cx=c_pps
 a=mbkJAKHg+hX/fqCzz7NXWQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=lx77uqg2WqRXEC48TswA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 2Gk0SYCyoUNZYd70BSu3dPh1-K-lfgpK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEwNyBTYWx0ZWRfX2cVvVGrbfsXY
 bK6IdzM8pPDcWlA4GTdUt2jjWO6K8hdXQhB2bcpZEHqSaM8Ad8qFsr0SSGWnufnx09ERy/bnRrH
 E/II0p1tASVdt99l2apc4LsBGdIvcr2EzOt+oAh1TCi/cZMfLPbdm4rSWJhZw82FWVhPDSGSq++
 r70lo9RDyBfciYirY0aLj4wHXBUwvofJDuu1lWhzxeM/DA1kdRdqQmHiv9Vl7fmA4ndTUDtsYNn
 G+BAPjrZV4f6o7iT+G+Wel68gTSJVkjMdP0TYf3xk1eO9MBsdfPkVLV730mUC7/VI3fvk+Wb39r
 RTxU7SVKT75Q5ck6Y5FEztQnlpoxnAo5oMcbLbOGdySLv1oC/4IPABTnw5nkXD6dtl2ZMSCplLr
 E2QF6urNO8+IoJrLYo2Qy0qFMvMnD3ZEUkwyQ7pn8O4ifkVrfqKfOUxseMujXIXB0XzKh4+v2bn
 EKwxYNtMfOlMmWQYB9Q==
X-Proofpoint-GUID: 2Gk0SYCyoUNZYd70BSu3dPh1-K-lfgpK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEwNyBTYWx0ZWRfX1A5XTyTVFAhx
 Fwq70c1u8YRLYONu9fF8CwMHaxAxxek/8mLZuYq42pzL7ubwodCBjAgUkdJRy+Lloj89JUNz5pX
 pp/ur323rDwOj2OizM4WB0KNcDCkVeU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1011 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170107
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

This patch addresses the duplication of the binman nodes responsible for
generating tispl.bin and tispl.bin_unsigned for TI's AM625 SoC based
boards.

The common nodes are factored out into a template in the SoC level
k3-am625-binman.dtsi that each board in-turn includes.

No functional change is intended from the patch asides from the addition
of tifsstub-hs and tifsstub-fs nodes in beagleplay's tispl.bin which
should have no consequence asides from growing the binary size by few
kilo bytes.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi      |  92 +------
 arch/arm/dts/k3-am625-binman.dtsi                 | 240 +++++++++++++++++
 arch/arm/dts/k3-am625-phycore-som-binman.dtsi     | 241 +----------------
 arch/arm/dts/k3-am625-sk-binman.dtsi              | 313 +++-------------------
 arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi | 185 +------------
 5 files changed, 282 insertions(+), 789 deletions(-)

diff --git a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
index 78d69499314e..d06cbd899c2a 100644
--- a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
@@ -63,99 +63,11 @@
 #define AM625_BEAGLEPLAY_DTB "dts/upstream/src/arm64/ti/k3-am625-beagleplay.dtb"
 
 &binman {
-	tifsstub-gp {
-		filename = "tifsstub.bin_gp";
-		ti-secure-rom {
-			content = <&tifsstub_gp>;
-			core = "secure";
-			load = <0x60000>;
-			sw-rev = <CONFIG_K3_X509_SWRV>;
-			keyfile = "ti-degenerate-key.pem";
-			tifsstub;
-		};
-		tifsstub_gp: tifsstub-gp.bin {
-			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-gp.bin";
-			type = "blob-ext";
-			optional;
-		};
-	};
-
 	ti-spl_unsigned {
-		filename = "tispl.bin_unsigned";
+		insert-template = <&ti_spl_unsigned_am625_template>;
 		symlink = "tispl.bin";
-		pad-byte = <0xff>;
-
 		fit {
-			description = "Configuration to load ATF and SPL";
-			#address-cells = <1>;
-
 			images {
-
-				atf {
-					description = "ARM Trusted Firmware";
-					type = "firmware";
-					arch = "arm64";
-					compression = "none";
-					os = "arm-trusted-firmware";
-					load = <CONFIG_K3_ATF_LOAD_ADDR>;
-					entry = <CONFIG_K3_ATF_LOAD_ADDR>;
-					atf-bl31 {
-						filename = "bl31.bin";
-					};
-				};
-
-				tee {
-					description = "OP-TEE";
-					type = "tee";
-					arch = "arm64";
-					compression = "none";
-					os = "tee";
-					load = <CONFIG_K3_OPTEE_LOAD_ADDR>;
-					entry = <CONFIG_K3_OPTEE_LOAD_ADDR>;
-					tee-os {
-						filename = "tee-raw.bin";
-					};
-				};
-
-				tifsstub-gp {
-					description = "tifsstub";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-gp";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
-					blob-ext {
-						filename = "tifsstub.bin_gp";
-					};
-				};
-
-				dm {
-					description = "DM binary";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "DM";
-					load = <0x89000000>;
-					entry = <0x89000000>;
-					ti-dm {
-						filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-					};
-				};
-
-				spl {
-					description = "SPL (64-bit)";
-					type = "standalone";
-					os = "U-Boot";
-					arch = "arm64";
-					compression = "none";
-					load = <CONFIG_SPL_TEXT_BASE>;
-					entry = <CONFIG_SPL_TEXT_BASE>;
-					blob {
-						filename = "spl/u-boot-spl-nodtb.bin";
-					};
-				};
-
 				fdt-0 {
 					description = "k3-am625-beagleplay";
 					type = "flat_dt";
@@ -166,10 +78,8 @@
 					};
 				};
 			};
-
 			configurations {
 				default = "conf-0";
-
 				conf-0 {
 					description = "k3-am625-beagleplay";
 					firmware = "atf";
diff --git a/arch/arm/dts/k3-am625-binman.dtsi b/arch/arm/dts/k3-am625-binman.dtsi
index bb0af78d220a..80ee941593cc 100644
--- a/arch/arm/dts/k3-am625-binman.dtsi
+++ b/arch/arm/dts/k3-am625-binman.dtsi
@@ -121,3 +121,243 @@
 		};
 	};
 };
+
+#ifdef CONFIG_ARM64
+
+&binman {
+	tifsstub-hs {
+		filename = "tifsstub.bin_hs";
+		ti-secure-rom {
+			content = <&tifsstub_hs_cert>;
+			core = "secure";
+			load = <0x40000>;
+			sw-rev = <CONFIG_K3_X509_SWRV>;
+			keyfile = "custMpk.pem";
+			countersign;
+			tifsstub;
+		};
+		tifsstub_hs_cert: tifsstub-hs-cert.bin {
+			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-cert.bin";
+			type = "blob-ext";
+			optional;
+		};
+		tifsstub_hs_enc: tifsstub-hs-enc.bin {
+			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-enc.bin";
+			type = "blob-ext";
+			optional;
+		};
+	};
+
+	tifsstub-fs {
+		filename = "tifsstub.bin_fs";
+		tifsstub_fs_cert: tifsstub-fs-cert.bin {
+			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-cert.bin";
+			type = "blob-ext";
+			optional;
+		};
+		tifsstub_fs_enc: tifsstub-fs-enc.bin {
+			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-enc.bin";
+			type = "blob-ext";
+			optional;
+		};
+	};
+
+	tifsstub-gp {
+		filename = "tifsstub.bin_gp";
+		ti-secure-rom {
+			content = <&tifsstub_gp>;
+			core = "secure";
+			load = <0x60000>;
+			sw-rev = <CONFIG_K3_X509_SWRV>;
+			keyfile = "ti-degenerate-key.pem";
+			tifsstub;
+		};
+		tifsstub_gp: tifsstub-gp.bin {
+			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-gp.bin";
+			type = "blob-ext";
+			optional;
+		};
+	};
+
+	ti_falcon_am625_template: template-ti-falcon {
+		insert-template = <&ti_falcon_template>;
+		fit {
+			images {
+				tifsstub-hs {
+					description = "TIFSSTUB";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "tifsstub-hs";
+					load = <0x9dc00000>;
+					entry = <0x9dc00000>;
+					blob-ext {
+						filename = "tifsstub.bin_hs";
+					};
+				};
+				tifsstub-fs {
+					description = "TIFSSTUB";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "tifsstub-fs";
+					load = <0x9dc00000>;
+					entry = <0x9dc00000>;
+					blob-ext {
+						filename = "tifsstub.bin_fs";
+					};
+				};
+				tifsstub-gp {
+					description = "TIFSSTUB";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "tifsstub-gp";
+					load = <0x9dc00000>;
+					entry = <0x9dc00000>;
+					blob-ext {
+						filename = "tifsstub.bin_gp";
+					};
+				};
+				dm {
+					ti-secure {
+						content = <&dm_falcon>;
+						keyfile = "custMpk.pem";
+					};
+					dm_falcon: ti-dm {
+						filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+					};
+				};
+			};
+		};
+	};
+
+	ti_spl_am625_template: template-ti-spl {
+		insert-template = <&ti_spl_template>;
+		fit {
+			images {
+				atf {
+					ti-secure {
+						auth-in-place = <0xa02>;
+						firewall-1-0 {
+							insert-template = <&firewall_bg_3>;
+							id = <1>;
+							region = <0>;
+						};
+						firewall-1-1 {
+							insert-template = <&firewall_armv8_atf_fg>;
+							id = <1>;
+							region = <1>;
+						};
+					};
+				};
+				tee {
+					ti-secure {
+						auth-in-place = <0xa02>;
+						firewall-1-2 {
+							insert-template = <&firewall_armv8_optee_fg>;
+							id = <1>;
+							region = <2>;
+						};
+					};
+				};
+				tifsstub-hs {
+					description = "TIFSSTUB";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "tifsstub-hs";
+					load = <0x9dc00000>;
+					entry = <0x9dc00000>;
+					blob-ext {
+						filename = "tifsstub.bin_hs";
+					};
+				};
+				tifsstub-fs {
+					description = "TIFSSTUB";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "tifsstub-fs";
+					load = <0x9dc00000>;
+					entry = <0x9dc00000>;
+					blob-ext {
+						filename = "tifsstub.bin_fs";
+					};
+				};
+				tifsstub-gp {
+					description = "TIFSSTUB";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "tifsstub-gp";
+					load = <0x9dc00000>;
+					entry = <0x9dc00000>;
+					blob-ext {
+						filename = "tifsstub.bin_gp";
+					};
+				};
+				dm {
+					ti-secure {
+						content = <&dm>;
+						keyfile = "custMpk.pem";
+					};
+					dm: ti-dm {
+						filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+					};
+				};
+			};
+		};
+	};
+
+	ti_spl_unsigned_am625_template: template-ti-spl_unsigned {
+		insert-template = <&ti_spl_unsigned_template>;
+		fit {
+			images {
+				tifsstub-hs {
+					description = "tifsstub";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "tifsstub-hs";
+					load = <0x9dc00000>;
+					entry = <0x9dc00000>;
+					blob-ext {
+						filename = "tifsstub.bin_hs";
+					};
+				};
+				tifsstub-fs {
+					description = "tifsstub";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "tifsstub-fs";
+					load = <0x9dc00000>;
+					entry = <0x9dc00000>;
+					blob-ext {
+						filename = "tifsstub.bin_fs";
+					};
+				};
+				tifsstub-gp {
+					description = "tifsstub";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "tifsstub-gp";
+					load = <0x9dc00000>;
+					entry = <0x9dc00000>;
+					blob-ext {
+						filename = "tifsstub.bin_gp";
+					};
+				};
+				dm {
+					ti-dm {
+						filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+					};
+				};
+			};
+		};
+	};
+};
+
+#endif
diff --git a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
index d09bdf29a95d..12f8acffc4a4 100644
--- a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
@@ -50,146 +50,10 @@
 #define AM625_PHYBOARD_LYRA_DTB "u-boot.dtb"
 
 &binman {
-	tifsstub-hs {
-		filename = "tifsstub.bin_hs";
-		ti-secure-rom {
-			content = <&tifsstub_hs_cert>;
-			core = "secure";
-			load = <0x40000>;
-			sw-rev = <CONFIG_K3_X509_SWRV>;
-			keyfile = "custMpk.pem";
-			countersign;
-			tifsstub;
-		};
-		tifsstub_hs_cert: tifsstub-hs-cert.bin {
-			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-cert.bin";
-			type = "blob-ext";
-			optional;
-		};
-		tifsstub_hs_enc: tifsstub-hs-enc.bin {
-			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-enc.bin";
-			type = "blob-ext";
-			optional;
-		};
-	};
-
-	tifsstub-fs {
-		filename = "tifsstub.bin_fs";
-		tifsstub_fs_cert: tifsstub-fs-cert.bin {
-			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-cert.bin";
-			type = "blob-ext";
-			optional;
-		};
-		tifsstub_fs_enc: tifsstub-fs-enc.bin {
-			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-enc.bin";
-			type = "blob-ext";
-			optional;
-		};
-
-	};
-
-	tifsstub-gp {
-		filename = "tifsstub.bin_gp";
-		ti-secure-rom {
-			content = <&tifsstub_gp>;
-			core = "secure";
-			load = <0x60000>;
-			sw-rev = <CONFIG_K3_X509_SWRV>;
-			keyfile = "ti-degenerate-key.pem";
-			tifsstub;
-		};
-		tifsstub_gp: tifsstub-gp.bin {
-			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-gp.bin";
-			type = "blob-ext";
-			optional;
-		};
-	};
-
-
 	ti-spl {
-		insert-template = <&ti_spl_template>;
-
+		insert-template = <&ti_spl_am625_template>;
 		fit {
-
 			images {
-				atf {
-					ti-secure {
-						auth-in-place = <0xa02>;
-
-						firewall-1-0 {
-							insert-template = <&firewall_bg_3>;
-							id = <1>;
-							region = <0>;
-						};
-
-						firewall-1-1 {
-							insert-template = <&firewall_armv8_atf_fg>;
-							id = <1>;
-							region = <1>;
-						};
-					};
-				};
-
-				tee {
-					ti-secure {
-						auth-in-place = <0xa02>;
-
-						firewall-1-2 {
-							insert-template = <&firewall_armv8_optee_fg>;
-							id = <1>;
-							region = <2>;
-						};
-					};
-				};
-
-				tifsstub-hs {
-					description = "TIFSSTUB";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-hs";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
-					blob-ext {
-						filename = "tifsstub.bin_hs";
-					};
-				};
-
-				tifsstub-fs {
-					description = "TIFSSTUB";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-fs";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
-					blob-ext {
-						filename = "tifsstub.bin_fs";
-					};
-				};
-
-				tifsstub-gp {
-					description = "TIFSSTUB";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-gp";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
-					blob-ext {
-						filename = "tifsstub.bin_gp";
-					};
-				};
-				dm {
-					ti-secure {
-						content = <&dm>;
-						keyfile = "custMpk.pem";
-					};
-					dm: ti-dm {
-						filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-					};
-				};
-
 				fdt-0 {
 					description = "k3-am625-phyboard-lyra-rdk";
 					type = "flat_dt";
@@ -338,111 +202,10 @@
 };
 
 &binman {
-	tifsstub-hs {
-		filename = "tifsstub.bin_hs";
-		ti-secure-rom {
-			content = <&tifsstub_hs_cert>;
-			core = "secure";
-			load = <0x40000>;
-			sw-rev = <CONFIG_K3_X509_SWRV>;
-			keyfile = "custMpk.pem";
-			countersign;
-			tifsstub;
-		};
-		tifsstub_hs_cert: tifsstub-hs-cert.bin {
-			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-cert.bin";
-			type = "blob-ext";
-			optional;
-		};
-		tifsstub_hs_enc: tifsstub-hs-enc.bin {
-			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-enc.bin";
-			type = "blob-ext";
-			optional;
-		};
-	};
-
-	tifsstub-fs {
-		filename = "tifsstub.bin_fs";
-		tifsstub_fs_cert: tifsstub-fs-cert.bin {
-			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-cert.bin";
-			type = "blob-ext";
-			optional;
-		};
-		tifsstub_fs_enc: tifsstub-fs-enc.bin {
-			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-enc.bin";
-			type = "blob-ext";
-			optional;
-		};
-
-	};
-
-	tifsstub-gp {
-		filename = "tifsstub.bin_gp";
-		ti-secure-rom {
-			content = <&tifsstub_gp>;
-			core = "secure";
-			load = <0x60000>;
-			sw-rev = <CONFIG_K3_X509_SWRV>;
-			keyfile = "ti-degenerate-key.pem";
-			tifsstub;
-		};
-		tifsstub_gp: tifsstub-gp.bin {
-			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-gp.bin";
-			type = "blob-ext";
-			optional;
-		};
-	};
-
 	ti-spl_unsigned {
-		insert-template = <&ti_spl_unsigned_template>;
-
+		insert-template = <&ti_spl_unsigned_am625_template>;
 		fit {
 			images {
-				tifsstub-hs {
-					description = "TIFSSTUB";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-hs";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
-					blob-ext {
-						filename = "tifsstub.bin_hs";
-					};
-				};
-
-				tifsstub-fs {
-					description = "TIFSSTUB";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-fs";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
-					blob-ext {
-						filename = "tifsstub.bin_fs";
-					};
-				};
-
-				tifsstub-gp {
-					description = "TIFSSTUB";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-gp";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
-					blob-ext {
-						filename = "tifsstub.bin_gp";
-					};
-				};
-
-				dm {
-					ti-dm {
-						filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-					};
-				};
-
 				fdt-0 {
 					description = "k3-am625-phyboard-lyra-rdk";
 					type = "flat_dt";
diff --git a/arch/arm/dts/k3-am625-sk-binman.dtsi b/arch/arm/dts/k3-am625-sk-binman.dtsi
index 9ac0c36f8645..08edf7f32519 100644
--- a/arch/arm/dts/k3-am625-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am625-sk-binman.dtsi
@@ -46,113 +46,9 @@
 #define AM625_SK_DTB "u-boot.dtb"
 
 &binman {
-	tifsstub-hs {
-		filename = "tifsstub.bin_hs";
-		ti-secure-rom {
-			content = <&tifsstub_hs_cert>;
-			core = "secure";
-			load = <0x40000>;
-			sw-rev = <CONFIG_K3_X509_SWRV>;
-			keyfile = "custMpk.pem";
-			countersign;
-			tifsstub;
-		};
-		tifsstub_hs_cert: tifsstub-hs-cert.bin {
-			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-cert.bin";
-			type = "blob-ext";
-			optional;
-		};
-		tifsstub_hs_enc: tifsstub-hs-enc.bin {
-			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-enc.bin";
-			type = "blob-ext";
-			optional;
-		};
-	};
-
-	tifsstub-fs {
-		filename = "tifsstub.bin_fs";
-		tifsstub_fs_cert: tifsstub-fs-cert.bin {
-			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-cert.bin";
-			type = "blob-ext";
-			optional;
-		};
-		tifsstub_fs_enc: tifsstub-fs-enc.bin {
-			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-enc.bin";
-			type = "blob-ext";
-			optional;
-		};
-
-	};
-
-	tifsstub-gp {
-		filename = "tifsstub.bin_gp";
-		ti-secure-rom {
-			content = <&tifsstub_gp>;
-			core = "secure";
-			load = <0x60000>;
-			sw-rev = <CONFIG_K3_X509_SWRV>;
-			keyfile = "ti-degenerate-key.pem";
-			tifsstub;
-		};
-		tifsstub_gp: tifsstub-gp.bin {
-			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-gp.bin";
-			type = "blob-ext";
-			optional;
-		};
-	};
-
 	ti-falcon {
-		insert-template = <&ti_falcon_template>;
-
+		insert-template = <&ti_falcon_am625_template>;
 		fit {
-			images {
-				tifsstub-hs {
-					description = "TIFSSTUB";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-hs";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
-					blob-ext {
-						filename = "tifsstub.bin_hs";
-					};
-				};
-				tifsstub-fs {
-					description = "TIFSSTUB";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-fs";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
-					blob-ext {
-						filename = "tifsstub.bin_fs";
-					};
-				};
-				tifsstub-gp {
-					description = "TIFSSTUB";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-gp";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
-					blob-ext {
-						filename = "tifsstub.bin_gp";
-					};
-				};
-				dm {
-					ti-secure {
-						content = <&dm_falcon>;
-						keyfile = "custMpk.pem";
-					};
-					dm_falcon: ti-dm {
-						filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-					};
-				};
-			};
-
 			configurations {
 				default = "conf-hs-fs";
 				conf-hs-fs {
@@ -175,109 +71,63 @@
 	};
 
 	ti-spl {
-		insert-template = <&ti_spl_template>;
-
+		insert-template = <&ti_spl_am625_template>;
 		fit {
 			images {
-				atf {
-					ti-secure {
-						auth-in-place = <0xa02>;
-
-						firewall-1-0 {
-							insert-template = <&firewall_bg_3>;
-							id = <1>;
-							region = <0>;
-						};
-
-						firewall-1-1 {
-							insert-template = <&firewall_armv8_atf_fg>;
-							id = <1>;
-							region = <1>;
-						};
-					};
-				};
-
-				tee {
+				fdt-0 {
+					description = "k3-am625-sk";
+					type = "flat_dt";
+					arch = "arm";
+					compression = "none";
 					ti-secure {
-						auth-in-place = <0xa02>;
-
-						firewall-1-2 {
-							insert-template = <&firewall_armv8_optee_fg>;
-							id = <1>;
-							region = <2>;
-						};
+						content = <&spl_am625_sk_dtb>;
+						keyfile = "custMpk.pem";
 					};
-				};
-
-				tifsstub-hs {
-					description = "TIFSSTUB";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-hs";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
-					blob-ext {
-						filename = "tifsstub.bin_hs";
+					spl_am625_sk_dtb: blob-ext {
+						filename = SPL_AM625_SK_DTB;
 					};
 				};
-
-				tifsstub-fs {
-					description = "TIFSSTUB";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-fs";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
-					blob-ext {
-						filename = "tifsstub.bin_fs";
-					};
+			};
+			configurations {
+				default = "conf-hs-fs";
+				conf-hs-fs {
+					description = "k3-am625-sk-hs-fs";
+					firmware = "atf";
+					loadables = "tee", "tifsstub-fs", "dm", "spl";
+					fdt = "fdt-0";
 				};
-
-				tifsstub-gp {
-					description = "TIFSSTUB";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-gp";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
-					blob-ext {
-						filename = "tifsstub.bin_gp";
-					};
+				conf-hs-se {
+					description = "k3-am625-sk-hs-se";
+					firmware = "atf";
+					loadables = "tee", "tifsstub-hs", "dm", "spl";
+					fdt = "fdt-0";
 				};
-
-				dm {
-					ti-secure {
-						content = <&dm>;
-						keyfile = "custMpk.pem";
-					};
-					dm: ti-dm {
-						filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-					};
+				conf-gp {
+					description = "k3-am625-sk-gp";
+					firmware = "atf";
+					loadables = "tee", "tifsstub-gp", "dm", "spl";
+					fdt = "fdt-0";
 				};
+			};
+		};
+	};
 
+	ti-spl_unsigned {
+		insert-template = <&ti_spl_unsigned_am625_template>;
+		fit {
+			images {
 				fdt-0 {
 					description = "k3-am625-sk";
 					type = "flat_dt";
 					arch = "arm";
 					compression = "none";
-					ti-secure {
-						content = <&spl_am625_sk_dtb>;
-						keyfile = "custMpk.pem";
-					};
-					spl_am625_sk_dtb: blob-ext {
+					spl_am625_sk_dtb_unsigned: blob {
 						filename = SPL_AM625_SK_DTB;
 					};
-
 				};
-
 			};
-
 			configurations {
 				default = "conf-hs-fs";
-
 				conf-hs-fs {
 					description = "k3-am625-sk-hs-fs";
 					firmware = "atf";
@@ -344,95 +194,6 @@
 	};
 };
 
-&binman {
-	ti-spl_unsigned {
-		insert-template = <&ti_spl_unsigned_template>;
-
-		fit {
-			images {
-
-				tifsstub-hs {
-					description = "tifsstub";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-hs";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
-					blob-ext {
-						filename = "tifsstub.bin_hs";
-					};
-				};
-
-				tifsstub-fs {
-					description = "tifsstub";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-fs";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
-					blob-ext {
-						filename = "tifsstub.bin_fs";
-					};
-				};
-
-				tifsstub-gp {
-					description = "tifsstub";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-gp";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
-					blob-ext {
-						filename = "tifsstub.bin_gp";
-					};
-				};
-
-				dm {
-					ti-dm {
-						filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-					};
-				};
-
-				fdt-0 {
-					description = "k3-am625-sk";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					spl_am625_sk_dtb_unsigned: blob {
-						filename = SPL_AM625_SK_DTB;
-					};
-				};
-			};
-
-			configurations {
-				default = "conf-hs-fs";
-
-				conf-hs-fs {
-					description = "k3-am625-sk-hs-fs";
-					firmware = "atf";
-					loadables = "tee", "tifsstub-fs", "dm", "spl";
-					fdt = "fdt-0";
-				};
-				conf-hs-se {
-					description = "k3-am625-sk-hs-se";
-					firmware = "atf";
-					loadables = "tee", "tifsstub-hs", "dm", "spl";
-					fdt = "fdt-0";
-				};
-				conf-gp {
-					description = "k3-am625-sk-gp";
-					firmware = "atf";
-					loadables = "tee", "tifsstub-gp", "dm", "spl";
-					fdt = "fdt-0";
-				};
-			};
-		};
-	};
-};
-
 &binman {
 	u-boot_unsigned {
 		insert-template = <&u_boot_unsigned_template>;
diff --git a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
index c57780d876d6..527b04936fcb 100644
--- a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
+++ b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
@@ -35,146 +35,10 @@
 #define VERDIN_AM62_DTB "u-boot.dtb"
 
 &binman {
-	tifsstub-hs {
-		filename = "tifsstub.bin_hs";
-		ti-secure-rom {
-			content = <&tifsstub_hs_cert>;
-			core = "secure";
-			load = <0x40000>;
-			sw-rev = <CONFIG_K3_X509_SWRV>;
-			keyfile = "custMpk.pem";
-			countersign;
-			tifsstub;
-		};
-		tifsstub_hs_cert: tifsstub-hs-cert.bin {
-			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-cert.bin";
-			type = "blob-ext";
-			optional;
-		};
-		tifsstub_hs_enc: tifsstub-hs-enc.bin {
-			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-enc.bin";
-			type = "blob-ext";
-			optional;
-		};
-	};
-
-	tifsstub-fs {
-		filename = "tifsstub.bin_fs";
-		tifsstub_fs_cert: tifsstub-fs-cert.bin {
-			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-cert.bin";
-			type = "blob-ext";
-			optional;
-		};
-		tifsstub_fs_enc: tifsstub-fs-enc.bin {
-			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-enc.bin";
-			type = "blob-ext";
-			optional;
-		};
-
-	};
-
-	tifsstub-gp {
-		filename = "tifsstub.bin_gp";
-		ti-secure-rom {
-			content = <&tifsstub_gp>;
-			core = "secure";
-			load = <0x60000>;
-			sw-rev = <CONFIG_K3_X509_SWRV>;
-			keyfile = "ti-degenerate-key.pem";
-			tifsstub;
-		};
-		tifsstub_gp: tifsstub-gp.bin {
-			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-gp.bin";
-			type = "blob-ext";
-			optional;
-		};
-	};
-
 	ti-spl {
-		insert-template = <&ti_spl_template>;
-
+		insert-template = <&ti_spl_am625_template>;
 		fit {
-
 			images {
-				atf {
-					ti-secure {
-						auth-in-place = <0xa02>;
-
-						firewall-1-0 {
-							insert-template = <&firewall_bg_3>;
-							id = <1>;
-							region = <0>;
-						};
-
-						firewall-1-1 {
-							insert-template = <&firewall_armv8_atf_fg>;
-							id = <1>;
-							region = <1>;
-						};
-					};
-				};
-
-				tee {
-					ti-secure {
-						auth-in-place = <0xa02>;
-
-						firewall-1-2 {
-							insert-template = <&firewall_armv8_optee_fg>;
-							id = <1>;
-							region = <2>;
-						};
-					};
-				};
-
-				tifsstub-hs {
-					description = "TIFSSTUB";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-hs";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
-					blob-ext {
-						filename = "tifsstub.bin_hs";
-					};
-				};
-
-				tifsstub-fs {
-					description = "TIFSSTUB";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-fs";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
-					blob-ext {
-						filename = "tifsstub.bin_fs";
-					};
-				};
-
-				tifsstub-gp {
-					description = "TIFSSTUB";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-gp";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
-					blob-ext {
-						filename = "tifsstub.bin_gp";
-					};
-				};
-
-				dm {
-					ti-secure {
-						content = <&dm>;
-						keyfile = "custMpk.pem";
-					};
-					dm: ti-dm {
-						filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-					};
-				};
-
 				fdt-0 {
 					description = "k3-am625-verdin-wifi-dev";
 					type = "flat_dt";
@@ -260,55 +124,10 @@
 
 &binman {
 	ti-spl_unsigned {
-		insert-template = <&ti_spl_unsigned_template>;
+		insert-template = <&ti_spl_unsigned_am625_template>;
 
 		fit {
 			images {
-				tifsstub-hs {
-					description = "tifsstub";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-hs";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
-					blob-ext {
-						filename = "tifsstub.bin_hs";
-					};
-				};
-
-				tifsstub-fs {
-					description = "tifsstub";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-fs";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
-					blob-ext {
-						filename = "tifsstub.bin_fs";
-					};
-				};
-
-				tifsstub-gp {
-					description = "tifsstub";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-gp";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
-					blob-ext {
-						filename = "tifsstub.bin_gp";
-					};
-				};
-
-				dm {
-					ti-dm {
-						filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-					};
-				};
-
 				fdt-0 {
 					description = "k3-am625-verdin-wifi-dev";
 					type = "flat_dt";

-- 
2.55.0

