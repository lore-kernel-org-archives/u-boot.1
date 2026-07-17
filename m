Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B919C44516
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 10:12:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7936084DBE;
	Fri, 17 Jul 2026 12:12:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="N9qI6OC2";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tX2mMpg/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F1F984DBF; Fri, 17 Jul 2026 12:12:17 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30ED284DAA
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 12:12:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66H6alf31759256
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 05:12:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=dXom1tfdIAsk0vp0u3tazqUHcFPPdJOo1J5uJJgmk
 9E=; b=N9qI6OC2a6GY+lZpyf+ydwXEjH0/OfjpVQvb6eMXDLew1AvBVzCGXUJL4
 c/PKApvoxhxFBcAps1b4E0aYt+ETbVZnfEGB+Qc4HeyrYiFqtnK3gQkBqSUvCc14
 Eb6MCemE6r4+XNsp0fydJQIr29+MGM42JN3jtvkjGwMg0TiyQxcVKNjWnMjVOxdg
 BX58YfVagBP+AqrNJeRWnah6MZ6NmwBVKbbL4rVTsDa52MK4AGVd69bN8p4dg516
 6MJYslO2log5JmLyip86AUk09eETn2qfrecF2cik/2H52Npy5EitcV2FyzY+r6hh
 Hw93mh+g9/ootFUanz0Vow4T8f4cw==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11010054.outbound.protection.outlook.com
 [52.101.193.54])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4ff1p6w8p7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 05:12:13 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JIwnwqCZ9+EjRV0lPR6gSHJbDcMOQjaCdHN2dSfM/4kWZDitWpX3SNYpxDdWsCT1Uy7LO10WqoTtC4SE5dZLrbYB1XEnpieuz2j27gHKs9QwzM+d53WuWGW9GxA1w12wpwGgYorU3XmC27HhAcq+hlG1wmpAUmesJn/IpTTzc8Ew0qSlW1LOtZaQT2CSfY2hkbkV+bl1zwtVEs4c9pV+Cu89HSC76XeupVFe49DrCNRR1uiLY8WVh9cfy+PpLHjgvITQxnk43Y8Z1t4/CCsmbIBAVNDQVCHYRT7O6JGQOJYJ1IEdXmpGc9gM//irU/jskiM1HxVUWra9lq2kakfatw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXom1tfdIAsk0vp0u3tazqUHcFPPdJOo1J5uJJgmk9E=;
 b=bBM2hyrZxdSxJvLgZLNIeVwbixn3rIGooxDdG4K+rwQPk1XSZFmQVgNkWXjWU0XRiX13Qr4CndSr4O3teLvF8rEERywl/WV6ahbiIvRNAWr6B4FrROjgeUhZXmJVrjEtSYYwr6G3MO5x0P8KcYvipuvwxYeCo9F8/x5by+arGHK5Qmo/XY8ZwGiY4sqcX0TqTVa8xG1Hc8DBjQuPgy9JEIGI2ShNU7+M2gaxdrzZIQJCr9OytWKh72smyv66j9xTIbjZIpbkDeDLwTbl1hkfVmkBL+F+C3lCRHjbMQmHjmEtXPmvLar+GMMhD2Ch3AZKL1d0xg9TsgamN0uJSpSU0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXom1tfdIAsk0vp0u3tazqUHcFPPdJOo1J5uJJgmk9E=;
 b=tX2mMpg/kxtmaBfF4MEwNEiSYF/FmXogCGw+raBIWNU/S1Oz9JY9GSwpYSLK84QqrlprzBqStzK+d3BD8OMrXW3gqvXbIT/BVTBmuYajd57Z61+YrK09PmE0wGDTMUmbVFXElOV2/brIH2deYGMDyqGX4aEX5+8leCLOM9K8Ki0=
Received: from DS7PR03CA0282.namprd03.prod.outlook.com (2603:10b6:5:3ad::17)
 by CH3PR10MB7959.namprd10.prod.outlook.com (2603:10b6:610:1c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Fri, 17 Jul
 2026 10:12:09 +0000
Received: from DS2PEPF000061C5.namprd02.prod.outlook.com
 (2603:10b6:5:3ad:cafe::6f) by DS7PR03CA0282.outlook.office365.com
 (2603:10b6:5:3ad::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 10:12:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS2PEPF000061C5.mail.protection.outlook.com (10.167.23.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 10:12:08 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 05:11:45 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 05:11:45 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 17 Jul 2026 05:11:45 -0500
Received: from [127.0.1.1]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66HABhDR3560642;
 Fri, 17 Jul 2026 05:11:44 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ram: k3-ddrss: fix ecc range checking bug
From: Neha Malcom Francis <n-francis@ti.com>
To: Bin Liu <b-liu@ti.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Udit Kumar
 <u-kumar1@ti.com>
In-Reply-To: <20260716145437.1686611-1-b-liu@ti.com>
References: <20260716145437.1686611-1-b-liu@ti.com>
Date: Fri, 17 Jul 2026 15:41:41 +0530
Message-ID: <178428310124.1177293.9487074360801126047.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784283103; l=214;
 i=n-francis@ti.com; s=20260428; h=from:subject:message-id;
 bh=N5W3itBOxImXEghglnvfrWRnbnLVVg6HYGshc2Yff00=;
 b=tvhm5HIs8IszeRdSbpbBiCS0ce7L7GJtzbrWpHs7z7YlgZv4HwFIPmFD9KiZ9sxuVyF3QlGcq
 5F+bHPLQW5+DFcMnXqBZeG463zBSER4u2R+62bFsrCWczcI4i05UGgQ
X-Developer-Key: i=n-francis@ti.com; a=ed25519;
 pk=Z4nV5FmpAM9e1Jk0HnCKOoVUtHW8cscgDRncr2IngXg=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C5:EE_|CH3PR10MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b526a18-1a39-4bf8-39c2-08dee3ebdc08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: dtpzFou+qCnKUjBnBCFYfnx7YaZGznXVB0PvmpIirhXh9dysf6tENelZ2hyX8Z1aVeXLKg82Gc3W2Fk4nehMMOhgaW+4ujwDH7gOJwlGDZvuGeJIxXjeuqFSqHep237xn8au3oePtQv7HtCbPVgBur7y5QdGhbhdM9zUBuGoU9kjc3mG9qQRa5vLOOoKRQJ3onUvt8Ra5ltl4xPKetzDfi+7H+jOC1VbxHfq09pZYgx6YM3uEQ1MgUZg2rwqoGbQ/FvVt1x2NgZEA2m5g0NYsburfCprkXrvaw9GWikVZp2bcAccqYegxj9thlK0bpv2bEXaM94lykO/IyfM1+7Q4pJqMKuYBvjxWHd5Ao1pTovzCF2jzUkoVG4kgU4F60eNcUjKGjWjhQtg9Wqz281b4R1yfavrHK6bnvgteO0QiftFJEydOZrwY3FcTCCOzsFyOKiW49unn6h6oa78XmJ+L8fvlinjLl+iRiTKtyficEqXWJIbqvuxm8yKNwROrbTfkLU+FD4DrlK2YMTAqRcUSeFUD/HSMcj+P6v+ois3nk+S0Bl6QLTnXbZAIn5DWKBnANWYP7lPYnc3dHTDuNMVrXiimzIKbscaVVWaX10p1sS1Lx7naoYNl9CT7atZ+tv1c1OWBfPGFdDu3L1Om7fHGZa54mYNnNDdahpGXuTzOVXzbcXQOtE+JaL3jVUvyavNWu+vPU8MLRLelyQFCI/bJA==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(18002099003)(22082099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jzsHbGQhEIo94lyQ4WCwLck1SYidMxo1x376HdBUlnITbEFsAdCiBC2v2NqwcPvL5MXg6WeIIy4l5+XfZYXf5Z0ETS0wUSg3n2iLiCqXPQPpiuBuc7PQ68Mk0CGJkbXDEsbrtC2IHyu/CARpO8zO76ynjdWrVE6VocOJCMO5xKAIEt0Azloei2jc2Pmf9j9gjM/iAlIApsymtUNN+tCzlEKbUzxj3xQGTcoEuNgD0wrty4xQiUp//uvq0g3Bp3Q/FR4VSthaW1H0OIwcUwnEuiGMRteXJHaXkTsdgrJ+QscGWAdISsV9WnO7yg2mpG+RkDeV12jaOvMefkR3rRYM6uNPGayhyhSaGh91Qej5FF52B/UYSq8HRNndmBpA7r6pckuPlrc5Cp4/LSfVCa2H0YBOyaKkE9T4G265/K3/vxU7iPmMnQnfgA298pQJsaiT
X-Exchange-RoutingPolicyChecked: AnGSiyDiHJyctAS1n0JVaSID7EHq7+fWXFuNIVubHpdc38aVsaYXxNFhnojEoymOEmoJjf5/2675kbjB0eCulaIGV7RhII5MKNrNkDmS5Uddn9pv7zxCApCJcHEgZRCazxxmu22nYq7A14nsWk8UWqRdpXqlALy+mnKMccnQ4eCpy1GzZnk1PZzGTpf9TTaZrrcZ7DnuA7auHYcTmTJaOey0iFzefbNfd5s3Mb49OxvNyYyMnb5YxuPVfSbbMqNR+LLVKq0ZsDcdd3lCxQmH47G2JN5i0J+f+5FjlCJzIebNaCgcf0ij3BZnC2ItJI7kox5f+0fZyGIz4T8zcxDEQA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 10:12:08.0513 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b526a18-1a39-4bf8-39c2-08dee3ebdc08
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7959
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEwMSBTYWx0ZWRfXyojzapy5T9Bv
 6sVhLNqcCoYU932m+I1Bxb66Npg/lw9PhHTyYBekv72Xkqfcs864HUIgHvSrhQ43I7nqOFw/yZv
 BOOBsMzEscdi4Wh/QU0sp4XetJpxj4rF5p1Cjlb7WvCokYsn9jp4mBqmeZWbs8lKPahznfaq8zW
 36/CeBTNct1/gc6eq6UO8FwgToY9HAw6dvMAzg2Y/9u0spm++2vAV722uiSH0L5f/J6Ll3Wt2vP
 SNRSNKzQ7ZoWIOFjFhdjaSJ8q8jJFpRTckIJ0rSK2hXLCYIyzKFdEEt7glrRF9UA8/YrYJQDhhZ
 paRguSeXas05MO9SiMX4d9v7Ld1uAsvglhoduYvF4kUcyYOZk4PHq7deGGEBKmLzSFEHxpUmn1R
 XN8cw6dQbbRbs2sA7p2/u5Os1L5HDEazlbopSFIq19uVerAlEIs3nXJrZp7e25rMrVGvhv7B5qj
 YMPiEzDvDGwJ/mcE+sQ==
X-Proofpoint-ORIG-GUID: k8LjtWq_UYjECV53aYxSgEmWWT9-77NO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEwMSBTYWx0ZWRfXy6ov41l6z3tu
 M3JezUKmLCSCxX2CaoJ1gwpAtFAQOrPIi94ubaapfz/rzhJWlXDmp23uVSiva12E3HDq+8Z9zoP
 eXxcznCkziBlsg8SMNVLLt6MYGbt4j4=
X-Authority-Analysis: v=2.4 cv=IOoyzAvG c=1 sm=1 tr=0 ts=6a59fffd cx=c_pps
 a=Wb2dZV0zRm8mlnqfvkE3cw==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=rb-g2KFEyk9azmY1Nd0A:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-GUID: k8LjtWq_UYjECV53aYxSgEmWWT9-77NO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170101
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

On Thu, 16 Jul 2026 09:54:37 -0500, Bin Liu <b-liu@ti.com> wrote:
> ram: k3-ddrss: fix ecc range checking bug

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Neha Malcom Francis <n-francis@ti.com>
