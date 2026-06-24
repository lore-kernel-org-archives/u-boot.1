Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB47BCDE001
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 15:35:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 588FE847C8;
	Wed, 24 Jun 2026 17:35:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="R27vRxQ2";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pbHH9+24";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1A1E848DC; Wed, 24 Jun 2026 17:35:31 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47C5980398
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 17:35:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OF4dgo764896; Wed, 24 Jun 2026 10:35:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=6WyqaPXdWXijbQaKiKqZJO/+rRGTkE7d6zn30Y18G
 LY=; b=R27vRxQ2H3G2vQc1+lORLccstrLOLYMl28LhhU7QHIAzDCCWJU2cGDGbv
 yudN5pFDo9Vs+Mze/5rNyan+EM+arsoW8EWrBfTzWVRGmTTmZwUyUj9mJ8k/9AdR
 GBlfZuN8iODHjO9gBnnbMV1HyiFOPGz4XOjNiG2RFWOH1N9/i6PgfUZuLjPLFHlC
 modQM22MAMdlH49OdoK3RKwohS8noYD4bxRsMFpGdfuOZ14DYb9NMPUB9WrpjZ64
 imt+LJaKxbXM1i5NxiS9t8Tb5HgBkGstWqKwvI6QV+IlPWIw56W+GGj/DY0Vh5UW
 ssrBU9oL3MkW/TChcy0VBMjlvN9tg==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11011053.outbound.protection.outlook.com [52.101.62.53])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f0aspak7d-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 10:35:25 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s2p8T4p2GXSyi7mQq6kFn3CdYEVnpj5r6CEOUdFSIKiXsa/z5bI61sOe6g6aKvcdgBL4AXbk839qrdCW/INLhEvE2n9ZfWdxVHyX7PurwSnMarg9tSC07qwx58bvJdt+h0jZ4v3GbGxXGf7DZfSEP80ALbEKZLr2kUsHqpJi90Ny6KXPi8eYvsOxLfGaxCOmP6ZXsGCXyz6kZ+6I1/Ftk/LgkGufuKn9gbYop5vd5bUdbM6xRXbWjP7fC3Blnc5hJBl1crKWLLCqoj2xKfIyQC0kEnJyIkN3XrbRbLr0TjMAs9Xhoixnx3qDAm35fB+8en/NRy1sK6Bi/QpkL4YXxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WyqaPXdWXijbQaKiKqZJO/+rRGTkE7d6zn30Y18GLY=;
 b=fUMoZklFlAL0f4Zd7xyzA1d9HI47K1qJclICuD7SVmTuMm3KszpuiN/U/u6B1kbHvBRuI7QmZGJkPeAtJC+ayXAeGMlsm1eBbUB1FHfUrAtHLL1+lO6Ud8LVG1jp+bnCYsqlYQQzUSQ1xD7LyTBj7Doe6rz1YeNJKbnnOCZ0lAQ9Espdwtke+RlCGM7FM2Pj50zDgk07xc1UtC9o2WtrlB5R+t6rsM2OMSY9uOxB2WjIZQMxonN3Rp2p3fqRHqAQLnPSeHGGGXKswZ9O3WyOFtsfcaFcQaN6Ph31srKKhURVgV+ACxUJnjcqrazyEjwgMKOCUrZgzpweMyqGlLIb4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WyqaPXdWXijbQaKiKqZJO/+rRGTkE7d6zn30Y18GLY=;
 b=pbHH9+24magpdf3BCrwy5QgEwLy3D9v2ZnvSrFLqFzmxHLaJbBLAfuY2UXNGWUlYyuKi018EYmMbDSYwqrrti0CPOO8mRq0cjvHJejO8l0j1mN1YJC0RfQKMDEpo5PQylC++HbH2AIuWCQE6jJR8ZX+GONFChKzaoaxN4WVIf3U=
Received: from CH0PR04CA0118.namprd04.prod.outlook.com (2603:10b6:610:75::33)
 by DM3PPFB0C5EC304.namprd10.prod.outlook.com (2603:10b6:f:fc00::c43)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.15; Wed, 24 Jun
 2026 15:35:16 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::5d) by CH0PR04CA0118.outlook.office365.com
 (2603:10b6:610:75::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.14 via Frontend Transport; Wed,
 24 Jun 2026 15:35:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 15:35:16 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 24 Jun
 2026 10:35:13 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 24 Jun
 2026 10:35:13 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 24 Jun 2026 10:35:13 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65OFZDUA1309692;
 Wed, 24 Jun 2026 10:35:13 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Wed, 24 Jun 2026 10:35:07 -0500
Subject: [PATCH 1/2] arm: mach-omap2: am33xx: ddr: ensure proper reset->cke
 delay
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260624-335-ddr-cke-delay-v1-1-21d65d40a83f@ti.com>
References: <20260624-335-ddr-cke-delay-v1-0-21d65d40a83f@ti.com>
In-Reply-To: <20260624-335-ddr-cke-delay-v1-0-21d65d40a83f@ti.com>
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=1447; i=bb@ti.com;
 h=from:subject:message-id; bh=imoDvv8OfxVpEJc+f8VN3Rs+cuHd31bc+yOPSFeqpxo=;
 b=owNCWmg5MUFZJlNZZ6Kp0AAAav////59d7162pq7PsRfv/f77fV77v3frvdb+L//99L59W+wA
 RmYHamg0BoANANAHqAADTQAABoDRo000AaAAAAAA0aDQNAbU0D1NNHppPGlEAyDEADTIGmmgANG
 EBpppo0MgANAA00ZMRkNMmTINNPUBoaMQGgaGQZGg0HoZIepo00BpkGQDRmoAyGQNNAGgaaaBia
 A2poDQA0AZGTQ00DQADEyA0aBpkZAEGOF11KJDvXeAQBdr8Ob6Mtz0IQvSP9G4uMjMyGgwG7EQ4
 ykhIMZs+Yj+QF0OPhFkPF6CXA7wI9U89SZIf5KjHY15V9kEHAgTO9Tx9hU1eSqnNq1psgBjggrm
 Wv5vSk0b6yPRY66xcgPAZC4HJVmztv4rUO6Mi/VmWLfzVv6YjeTVZukRq3AOFPItyPqMNQFgml7
 HRhMFGXLq5bbbatIpVfHCxyt/ZKAAFTtYh41s3me/SLuYa6UUbSbTmxFdzH+RztO/xPNiGVfqeQ
 FQlbGbxfoYsxkvXknTnnoUw76LLQJ6VEUBJhUfQpVEqly9C3AKWsNU+RPLEtvyCJMx/+6/GU7hT
 VR86ZEdXi1OkiaXRgEVOINs275HyFwEU/x+fRYc0sSLqu8nTIzqER3+8yG5hp1Boa9HHRj8IAlv
 iYAaASTIgBBFof8XckU4UJBnoqnQA==
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|DM3PPFB0C5EC304:EE_
X-MS-Office365-Filtering-Correlation-Id: 40755a01-8121-4807-a1e1-08ded20630f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5Y4wBD4vVSTN8ezzuGyH5AOD1yHmuzmbBmSjV6zfSig17rh1vwcQZOLXnf1V6MOsqKs+yOKafBmYpilNVYVQL6+qexceaXQzfSaXneUJisZyYQvXe0O85lBrlu7AqRk/C4kwSjkAyCrfxlFXxAithoVAAS+A5YE1UefUhhBw6fzpgZE8AFc/vVG2OQzpTgSJIC/7yvBkxZzRBrNRsY24V52DjKI/llmfqn2RZuz9Z5WZobqtRAokP/4ihE0hJp4e9MxopNHhK3FKkqlROnzAbKxWB3yN06IRzGUZCythwZAJWX0DIMEgZZmazSbdDNGBrP7vx54c/dvFj7ZebxDkr3oXr9IUIC3ngZOZoggL0Rr5tNYwiJkQ5M7WHKt5s89ILSzzRWGHNuQ2ZrllGHNmn/jdsiQmCPoJDZnBof/sTl1rYvCrAvRfu0bnra9lGNjILNoldqEs/cxjPVWz2DI6ZrCHrCn2NyqV0cfeKnLvjZ09DrVUXAm87eR8g2EqtcsroUruaYhGGulLD+oYglFAeWO+JUTQ82/I0Yu3zzAagJNdDQHPpdzQfxWmhYycclIb7UZRh4QFkrzTM4wkDlDfk2pzmqdXPRLJBfdi098hH1xzWDjkTZvEW3UO1W1xbepg8ib9hcJ7m2yr265VM77qZRIdecui2PDS4uqxAh7vjShbrOye7K5OW03S7xxX2w3kDgPuijemSZ/qgnBssbc1IQ==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(6133799003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Pl/zSTGPMjg0rqet6Izfs6VbB1ny0Kjz55P5fqc6CA+neCs0/yoh58vsbH40r6aCGQXwGGFhu40VjqXfgeR95+fBR5N6KlTVJX/dXzSbI2zCZh5o3hDQHmp6DyyiF0rbbnql811IuKeuermrEBsOApce8B4YAy3YHd4b9YlmRfMh72/rr765JxNye0QpgtCmO1uMRN3U6nOjJX85cjEieoPYPqRdP6ei0Eg4sHOQeqIQpgcnTEidBFjcvDq2cLfIu4X6JUP/SnE6pbV7ljQvv0RX1rQEOC9ECZ6llWIKZNK1IgnXUREzHgKUPSabH2kV4Y3JiIc1LvehsX1aBqpmNPZleZiGBeB1qBOOnRgd0ZXSXg2qYORVbLhz2UpyhosVP0KfKCT26EHbQMSlvwBvWuAZGr8VJ+9yP/DDukuwc1j2QORwdKZ3SHnMKvEuw/UL
X-Exchange-RoutingPolicyChecked: G0agslc+lqYoY+GopNmHqLVBATStsEKUNivSKH6RvpD1X283PJe1K/ik2LkJKnEzyOmT4WfrtSX+3LSL+G34OvC0h8z58ygp0pBdwfjPxFNxgksgYlEFbgj52rr+h0q4vjZ6foAnDPmNOD8HH1UmPitPYjEPhLmzZthPhcayTbbGEvcSPLXFhiG6SPQR5pPK3QCXI5HAck7yRcw5i+NB+o1dnjcVuC8/5m8cwcAqEIWVtWO/pDONe9CTm30h3yZMUqsZohL9VpJ//YWW0Y4fbkAVT6p7fdpulhpDxCInHYUck1cKFSN9MiNNeM6AiIvbClBsPERd0RW/1uTzwL3+nw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 15:35:16.5307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40755a01-8121-4807-a1e1-08ded20630f5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFB0C5EC304
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDEzMSBTYWx0ZWRfX/slX79bpeeGV
 FnpdJqqQhQSXiP4c/tLxuhD2Q79zg0zm2yJPouYmyNpEDEgynxIG/rwYjCKlCwQe5YgDvdFvr7a
 5RJ4x0AzLudddHF4Ep07/dlcT3xWIqnYj/QPpaM4/bdNOdqx1enCwRYuTAucTmrmRIQijSxu6an
 VkS+Ltmu6l4YwtFUQ/FTxBzv5Ai2BZKNJQ2h6Md6/UTSb3ZYYTZQMnrmp6r9k1RfCR5z0TFx2V7
 XJ3FQjC6iilBKA0+O6eqxt8G/CMrskL+/oWsDy/NnbM13otimZ6ECSWH8B2mpOXrkR7xxQ1mDk5
 iq6VYpVXuiTS5k2IhgPEd+6gt+heMSs2da6yVWML6+Y1f3m3+WG/QSsM/hfpUQjmKbnDfckrBvT
 jiwJqIuT3znW61DTncAfehKNWdyh9A==
X-Proofpoint-ORIG-GUID: bair9kCFyocCX4pqgVrHmXI6ibRUAve3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDEzMSBTYWx0ZWRfX65T7ZJOJhgIW
 n4qf00tKtqLNSMnkZlZyfMiUMXKEe2Rj1e4r9mRdhZnz6qxZRICSA0lz0/uChR6MCdA3+mqHGtZ
 IOMOLzRjdUCd/2pKE7FYVYDiDU+RuIw=
X-Authority-Analysis: v=2.4 cv=RMCD2Yi+ c=1 sm=1 tr=0 ts=6a3bf93d cx=c_pps
 a=9V9/KAGQR/RGwytZTnC4xw==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8
 a=ALYaFfoIWcYFZvHOGv4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: bair9kCFyocCX4pqgVrHmXI6ibRUAve3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240131
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

With the Beaglebone Black the delay on DDR_RESET to DDR_CKE is currently
~135us and not the >500us required by JEDEC spec.

The issue here is the REF_CTRL register performs two purposes. It is the
counter for CKE to RESET delay before the DDR controller is initialized
and used to configure the refresh rate after initialization of the
controller.

So to avoid inadvertently configuring the CKE to DDR delay, ensure we
initialize the controller before we configure the refresh rate.

Fixes: 69b918b65d11 ("am33xx,ddr3: fix ddr3 sdram configuration")
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/mach-omap2/am33xx/ddr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/am33xx/ddr.c b/arch/arm/mach-omap2/am33xx/ddr.c
index 41eec005cb1b..a40813a99d81 100644
--- a/arch/arm/mach-omap2/am33xx/ddr.c
+++ b/arch/arm/mach-omap2/am33xx/ddr.c
@@ -185,10 +185,10 @@ void config_sdram(const struct emif_regs *regs, int nr)
 	if (regs->zq_config) {
 		writel(regs->zq_config, &emif_reg[nr]->emif_zq_config);
 		writel(regs->sdram_config, &cstat->secure_emif_sdram_config);
-		writel(regs->sdram_config, &emif_reg[nr]->emif_sdram_config);
 
 		/* Trigger initialization */
 		writel(0x00003100, &emif_reg[nr]->emif_sdram_ref_ctrl);
+		writel(regs->sdram_config, &emif_reg[nr]->emif_sdram_config);
 		/* Wait 1ms because of L3 timeout error */
 		udelay(1000);
 

-- 
2.54.0

