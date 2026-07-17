Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E35C8C44507
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 10:13:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F172784DD0;
	Fri, 17 Jul 2026 12:13:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UXsoJWEW";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="m2OZ7Ai5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05F2B84DCA; Fri, 17 Jul 2026 12:13:08 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E56BB84DD0
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 12:13:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66H6amwG1759278
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 05:13:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=RuTP//D6jfZVaachnLvaSSOYeEwbv9mKmeVLyqEDE
 3w=; b=UXsoJWEWoVdgP//3yW0A8aGpjS8ZSI3KOU7eZy3HfBtdApSlS6i2BrmY9
 J3pCJKytApL9SanNR9ORc6raIKe03KVbvZFpiTeKgQ2MjvmeeiHVBp4VQG8qC9Bl
 2EbvNjsHFE80PDr/cKD4MXrOjPr8SAPg+zMrbNW9dKm7flZuzWI+XcqXFNBs+3ta
 HIG3Xf52XUnFbes67mZgAd8wgiZLRDw8u7d7MM5WHy4kF17eCVJl/X6q4XqQ12tD
 PpmHer7zOaXAST0J3wnES/sf7UI0lV11e9BtKTdtcAKGGtrgemQGg8VYFttt9/Ne
 j9r/UjOaNNFthT45C9g0jEUWKcMfg==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11010061.outbound.protection.outlook.com [52.101.201.61])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4ff1p6w8sq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 05:13:04 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sz2bYO7aNxdTU2DHTeg+PpN/HMHzpX/FrG2KzDmH6wEUblVY0IiDKXrOvuoO5RabiecEUEMMEqdWHPQkeWBDZP4okZzdy4k6H+SgIb4McP6WVuOtCTqlgpx7uEd/O1G0RjrKoM7/Z7kJUg1dXmmHYCH1FjL26ILJGPN/lAHeMcUe4ytLJKHa63a55vDbWNp4pOT2adBIRKUs+CQy4FThluApw9/h7kbOqlKRbR27XFzygVgogzQ/8WoWFoDYFia3OVQX+Pj3UaJp56sTQsKVjDvBweil0MjhzAu0hVOd/5clgdx+D+l/g2C9MPA5pYptamcJ3lBqESbKlBW3v68gAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuTP//D6jfZVaachnLvaSSOYeEwbv9mKmeVLyqEDE3w=;
 b=J9uL1H1q3RR4Px+/Pmco076C8s0uS0hic84F7BLFA8XT/8VDJKpfwTs+DVTTELCzkK2ByMInK8tHSGDdvwr0Z7pWVWX6BvX7EOJu7IrATXSNgcDhgeaBrQye7ONItIpHji2RaMrIzDL5fFD9iIWCdaaPQp77zSsVRgVYoirE3+6VCAjpJ6osfHT0Qeh9/mOmRbcDWGC0FgVq5eLADCP/cWbluV0DC3eLOf8w34RroTrSm5johoooOCnkUyNjaUsAesHVe8FlQ1/0QEmrzaqnobxn3aCUUfrGD0kt4W8UUcUKNHLdOrXhqI+fTT56Ld+v4Q1CAwbILdd2NYv1ROCHZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuTP//D6jfZVaachnLvaSSOYeEwbv9mKmeVLyqEDE3w=;
 b=m2OZ7Ai5tmFzXHHFdL6/s3s+EntI2SB6RyZpJZNbtsRFM8m0m2KMqpS6EkuW1ygw8TfSZ6fKbToODXnQBOtXw/vOKOyjVhYZk2CXhL98P2pGpXNU+1tqDGNlhJ32q4FKQPwmFnBG1lOI09GNI+2QuJwv2L36TAF5JnmcZEhsRtc=
Received: from SJ0PR13CA0187.namprd13.prod.outlook.com (2603:10b6:a03:2c3::12)
 by CY8PR10MB6610.namprd10.prod.outlook.com (2603:10b6:930:56::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 10:13:00 +0000
Received: from BY1PEPF0001AE1B.namprd04.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::58) by SJ0PR13CA0187.outlook.office365.com
 (2603:10b6:a03:2c3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.5 via Frontend Transport; Fri, 17
 Jul 2026 10:13:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BY1PEPF0001AE1B.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 10:12:59 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 05:12:48 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 05:12:48 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 17 Jul 2026 05:12:48 -0500
Received: from [127.0.1.1]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66HACkqH2961096;
 Fri, 17 Jul 2026 05:12:47 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] Kconfig: ram: select FDT_64BIT for K3_INLINE_ECC
From: Neha Malcom Francis <n-francis@ti.com>
To: Bin Liu <b-liu@ti.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Udit Kumar
 <u-kumar1@ti.com>
In-Reply-To: <20260716143751.1680929-1-b-liu@ti.com>
References: <20260716143751.1680929-1-b-liu@ti.com>
Date: Fri, 17 Jul 2026 15:42:44 +0530
Message-ID: <178428316470.1178520.14961886076954920120.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784283166; l=221;
 i=n-francis@ti.com; s=20260428; h=from:subject:message-id;
 bh=O1hfOrqtW/XPuY9HPLiBLixLv1GRU+o1orOTzoDpjLU=;
 b=vSu1OxijUwp8OcNNnKF8DI78nX6LCHXCTPbZkPHm8zfTLBFMXxPDKpCgwpBKJqQB5nGmvNlL5
 4Tod64l5tGfD9Ps05Pw8F5RUI8I8SQwNgPSOAN0cKvx4OGNOIS/zPF3
X-Developer-Key: i=n-francis@ti.com; a=ed25519;
 pk=Z4nV5FmpAM9e1Jk0HnCKOoVUtHW8cscgDRncr2IngXg=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1B:EE_|CY8PR10MB6610:EE_
X-MS-Office365-Filtering-Correlation-Id: 1091a733-2c54-4db0-d2f1-08dee3ebfab8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|22082099003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 5jCifYFEbm39Vgi3272rp/MF8Vu/FbaBRa30RoRPa3s1pVK2fgu2lAVQIMcdus4Za6rKD9anFqVzq2tlrWjauHzg2Sz9/m4IOftXKF0ZQU14WnpqYW9O5eb/10wezKkvgB5dEv9ymKlxz3GNdro42DTuX91Px5bbiNU5UFejmXd94BUw+oZtbQFG4dkMESDjkUVRHjAjtLJn1lvK5I/Ra02nIw1fZRcT5Ty6bgSQjA7zU2yW471q4I3OUVB8Nd8Uz8ePQCY4lEN9uBi/HGnMJvDLk1oqQ1CR+17bmjM4myrNEZ6k3bJcKXzIj/VSS7wI3XhgC6j+E0oaKWGDXBQXVjwOwzcrAIEZrZvSL4SFOqx34ePyyu71cEn9yNQ3Qm6FpKru1IllVd0UCpZL0YqKga1hdwyGB1qmAjJysAmS6yF6o9amDUq+0Q8siExuLk2QtdTzOc2Uc/WtNQX8H1E1GB5PBGenA8NsHLdmiGGMiGpBDmpQkZKnSH/E3z3+F8N7V0rC1bdHmva7jR0sZm5C8XlhQ1faf8Msi9VGFnCJKOBUHAbbiMu0XJuj4gLLAj2zUeD/8d6Qq65YmJR90wvtmFJ5TcLt3BctlUQU5WwkTNd/fcQYJsUcf9phH3DiFnfFInrR+gceuBLzqw9sFeQTXfAWU3MdeUsXVCa3lO66kc3dzn0aosJjp1PaRuc0NZn+5JYAAymVhSNBowhiBdKDPQ==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(22082099003)(18002099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FI/Ykf76D4oS0Au4DOheyPTsKg3wBOgdcX5r0mmj9rZd7XFcLma+zG3qdrlGTd1EXqI5lDbi89Fw7BHQHlFr+jtKzJARKXv/vjBfEuzz7lQqBSndUv1+frbT5ouEdgQTElBxR3lcS6UA1MpUWbLb87KfkmtHs4gJH1lRdeXHtqLDH49van+PPb5G7ak2VIKYjQBrOp2yA6bXn+QPklnirBB8wO1hdiqcoJ3Wn6NyudFoF017lSMMZuG2svSH4PFJB5kHuG0kI8IiSD9z/2L7rW1q7HS4GlzJ1c2gu2WGKqIfr0Hgvu4CoBuGTv/qp/qsU59fJD1zxOqMeVgzRLeAdWO/th3Yls4gxeK3OH5Fq4PoIFgusKuS2x3xpJDbHrnk3AQxakj7b78osgXJwH6Fx11T8qlZ2Dqj9lDgvqsHrM1Wi0JBDZOTbHwSN0GbhOFW
X-Exchange-RoutingPolicyChecked: S65QE90r8oJDlOqg4a9wTHaup9gMLG8fe2Hg1RC9sMcrYX+QG90kpt252XwKbsWFBcOGfwe20V50x0AHENuTrWkN+qIzdMPGVXzwkv70vYN0VZsd0587v9nk0kL65Q6kzN7ICakIo3AkaQoac3ejzRD3lPGtfyb/pOxGKzdSGQmNNlyF+0owXBqq7L1B/p1VVQbLp/AfEuSVNGc42IokKqxe+XHLc8hYLwcCY0lHgP/KSLRmrHuI1Z4tUSu7VhZ4+Igp4nso/0/DCOuUe7fywEygz29IMFuyZVY2E3IA+B6ELjVyavdiRwctv7Hv1/zTcIMaNUDAkhHRJhJ4wNjY6Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 10:12:59.5070 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1091a733-2c54-4db0-d2f1-08dee3ebfab8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6610
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEwMSBTYWx0ZWRfX56GVZ61nTOs3
 KI93kVU8g4SfQyR+sR7TXAj4OtP/eUVJ9c4n4bsEBxuI96XzueLHIYQq5t7XwUwgTRiE/ejD0E+
 MB8iD25SVxFZyn1CPSQ3lEsz88S9+wUDyZpw3GGDgfW6UPX1ckLs1zXVVCq/SdOGzSBm7D6RvFH
 /EI/I7Av/7BpEPnm9+Xv/M1GUffRQSGKjEIP07DBxnKHMzz3UE9WjFF1E5ehMctEOAdQi0pf9gZ
 vWG/UAzRZ0ZzaCn8We9sIiQab4pUqr2DcnyJORelE6difRx4WS+ztGOxsedGpNZsovzDQipHabf
 hvMdw6pgBLbZ+wp+cjv8mNqv2VErVcuCVJYoKoyvD+fD7WEAMs87lCi1vldZHrjq0WbGf3aB+sZ
 /EmzyGjCwMZV+iV5lY5f7eWzvFXfJw/9h+QKmEIzt257e19xMcP2c4NDhnV5aafB/aSpx8j7nFT
 XqU0IbsofpboqL75Ebw==
X-Proofpoint-ORIG-GUID: Ryryakyk-ITP1_Id-zCMlHQ-O9WM6aVz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEwMSBTYWx0ZWRfXw6i/iPl8wSiI
 OU2gi7RGtd7lk881I0b+MqAX7u4Zm9m0k+tww3p4t4rAheAPtyr7xl1WtbtJJntnClgmZjSaDnV
 jKDqg0JifM0KnUqaqUFuNYeVvVmLYaY=
X-Authority-Analysis: v=2.4 cv=IOoyzAvG c=1 sm=1 tr=0 ts=6a5a0030 cx=c_pps
 a=0p5N1A/s2xr2YPsuh+j7dg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=8uylvXiifV-I1BT2xEMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Ryryakyk-ITP1_Id-zCMlHQ-O9WM6aVz
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

On Thu, 16 Jul 2026 09:37:51 -0500, Bin Liu <b-liu@ti.com> wrote:
> Kconfig: ram: select FDT_64BIT for K3_INLINE_ECC

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Neha Malcom Francis <n-francis@ti.com>
