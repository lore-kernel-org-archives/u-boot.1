Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F209D3B7EA
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 09:26:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB1BA83B32;
	Tue,  9 Dec 2025 10:26:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=list.ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=list.ti.com header.i=@list.ti.com header.b="bMTHRETe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60B848398D; Tue,  9 Dec 2025 02:40:16 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D75F836CE
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 02:40:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=list.ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=prc@list.ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pr9/CtYeo2jVvEMbMA1XXZhx7OZ6JUKxECeBqc8w81NNJl1UeTjZbLYms+0Ou8HceqxqiDyqSbxKNcFMq/wJOOBPzvJHU2F0SuxpyvGWW1w85JsvhQXqKWZKAqeAxVIX1uyliRBrYw9Op//qN3tNqdtN99PIxYT0n10RbO35khricjZID2P89bSyQBgrAmuhGQhYT3lPfg+xXppP7qJxo+hLCL/rJetK5wyGKnkpOqmWn9Ju3RH7VnKKE7Ydqv4NrZhXjPLiyfKht3J4yaCEQGRn3BxegYnsTogj1Vy7/eO8zaCkqgh1B9uSfJ1yxUNAv2L7f8K6JyiKjFRKk1ERfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9oFaN5CoLWtcYsnm3QDMvmyXRHdCdnNiLbJ/o3jle3k=;
 b=LtfJNrbBYlwIhJFpS9pN793GsyQAc/xhyI69JJdWScYZ+k+CfouvXSGTxcjbTGKkX3hLUlALRy48ZPef8DhyBC2bFdHOdD+tDCzrOf0yHqKQ+4kXL11tARkqhLfCD+YxO+53goXONtwe76AVZB3s1BlHNImSiwffXf452LwoX0DDpOz8gZNMPeaYZg+ciMK/nJUhs/MFoV93NUDNn61Ud99ipmf/FWEr7yUzF9zGlY03zgrxXrMIGUkebJIJgjsS4ipgFp93/if826Vjj/TfoLCI+3VhfnXrcljEvdoN9PIN87AARwYXq4T751L85WROr84CtNZx1HsWdlqDqAJjWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=list.ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=list.ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=list.ti.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oFaN5CoLWtcYsnm3QDMvmyXRHdCdnNiLbJ/o3jle3k=;
 b=bMTHRETeO1QkcuD0dMlrsHSwqfetHo0buZwJcr2oZ2hr9RsUYBR0UE8zPB4v19+ntWis0dpUcUYIw3TiAKyH0Ka6wccomikpVRZssqgS8KdRqmmFEjJHQD5Yc72Ax4VRR00Zj1kqBnpCKmPnJmSkPDA94P/rmUcPl8bY6t9RmwodvoZ7wufP3Xn9Qp0R5t3rYp8ZLtVCnZ9kykVd2ccdR2ZWonZirAYVuAAO8672ZDKvQ2VaR/WGagMkLvk+fhzvzaZW7oZOokfXyS+14ZVEN6r9WoEI3cBDNcTTUHRUl7+cW/RrdZRwya8iCLd46bTvcSqw8QdNnEmzvgCW39pJlQ==
Received: from SJ0PR05CA0170.namprd05.prod.outlook.com (2603:10b6:a03:339::25)
 by SN7PR10MB7046.namprd10.prod.outlook.com (2603:10b6:806:346::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 01:40:11 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:a03:339:cafe::40) by SJ0PR05CA0170.outlook.office365.com
 (2603:10b6:a03:339::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Tue, 9
 Dec 2025 01:40:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=list.ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=list.ti.com;
Received-SPF: Pass (protection.outlook.com: domain of list.ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 01:40:10 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Dec
 2025 19:40:09 -0600
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Dec
 2025 19:40:09 -0600
Received: from fllvem-mr08.itg.ti.com (10.64.41.88) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 8 Dec 2025 19:40:09 -0600
Received: from fllvdckhpci031.itg.ti.com (fllvdckhpci031.itg.ti.com
 [10.64.72.41])
 by fllvem-mr08.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B91e94b072841;
 Mon, 8 Dec 2025 19:40:09 -0600
Received: by fllvdckhpci031.itg.ti.com (Postfix, from userid 60899)
 id 14F2613F517; Mon,  8 Dec 2025 19:40:09 -0600 (CST)
From: PRC Automation <prc@list.ti.com>
To: Bryan Brattlof <bb@ti.com>
CC: Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri <praneeth@ti.com>, "TI
 Linux Patch Review" <linux-patch-review@list.ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH tiU2025.01] PENDING: configs: am62lx_evm: add GPT GUID
Date: Mon, 8 Dec 2025 19:40:09 -0600
Message-ID: <20251209014009.2082656-1-prc@list.ti.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251208-gpt-support-v1-1-0cde970713c3@ti.com>
References: <20251208-gpt-support-v1-1-0cde970713c3@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|SN7PR10MB7046:EE_
X-MS-Office365-Filtering-Correlation-Id: 679bb1d6-9924-46d3-d8f7-08de36c3e424
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|61400799027|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VCzbbVeOqEwTDOWDc78g0XaSiOfLHs+yr+B7C6R8Cu6z0e+mYv2RCRC0XiCl?=
 =?us-ascii?Q?imK+UN09/jwQjXe4b1StbwsUHrcuNyKRtPEeREHfpxmZ7MZw2lVJ2XTtzFM3?=
 =?us-ascii?Q?7DlCgXS9Md1eEnpsXstX/DB8wKWBAR4tMsHy9JOIj4A9oPB4wX06N3463h7K?=
 =?us-ascii?Q?rZFPPOuegaWWKWPu/3gZRLlAUO2fJdXjjP/T1MOh08QI8/4SagMcci4uqiQY?=
 =?us-ascii?Q?3AxtCG8wR+cztC4Sbqk+rNW1S7SkcEULD50vkjf0VwpUN3KSvnS21P4CGGL2?=
 =?us-ascii?Q?1lXipeZsQK/uBlHI3Ow24NJig1UktNdeWasJ18Nyun6zSL3E3mnLqEd4li0V?=
 =?us-ascii?Q?t/auo1NPCxECnTGbbVC5iQw/Ck5TlKLhfJfB5rtOjY/XAZXulcDYWx9Ni1h8?=
 =?us-ascii?Q?CP0qlzJrxsNFPs6jdao8CkOR0Yd4naL+BkQZvEkxc5Ir9wSdhorFn0lLK06e?=
 =?us-ascii?Q?tjIuZhy6P82EStDSQ9yF/kLK+Ybbh1Naeed+dIDhavS/7e/8SsvBb2qPdDPo?=
 =?us-ascii?Q?ZHZCEjZwH33PQo4gRdpbUC2A3hhpDNFCTjlYSsdu8XaJu1noVKstRutC9X0X?=
 =?us-ascii?Q?djcQ4ugeF1TYSsXCXSYQUFYKReiv+YIhtwZVbOeI2z+IeX1v+3MJ4tKI2mgX?=
 =?us-ascii?Q?M38kiExvlzxIThkbwNk2UTh0Lm5DKP7UC0NOumdFhEaPpvIIFjo6B/p65ZtU?=
 =?us-ascii?Q?lmlgaJgHcTWEKoJKClu7pb+XDBUd6h8bJEOf1qvd2Xf7KXFr+GT90eVyLW0O?=
 =?us-ascii?Q?2mtGXgQTYzdbYGOfVfK9t5Nl1WcoWlDH2cLYCoJDULx+9LVq0cA6JNaQw1Fp?=
 =?us-ascii?Q?MUz+hc921OLhiKvX4ilNPl5RfZEBbfszUbUfAQ2f8PEWC6e12NmVUfbT8tKs?=
 =?us-ascii?Q?9PY9LtusP0OtGIOiMcMegmaW5O4X2FwYTcgTv+0i+PoL3J9otvz4Cpuir6yD?=
 =?us-ascii?Q?Tj+9oKvFPdTToETfE5aRuuLK1kY7sC+KN57bUKEp3xFqCkqVbRSfLVeT0S3K?=
 =?us-ascii?Q?p/wahf05U1icQY5z4CJpwLyjNW4jBzSiq36sWnW9eOY2mMr3g4BL8bymKpGr?=
 =?us-ascii?Q?mNUemaW5Xsl2uSkZ3DFIVN6g0gb9fRP0utHnU2aKjtfJi2suYV9t6YkfIQjd?=
 =?us-ascii?Q?qWSKmjwhM3g8hleLQ219WJX/71isuP8sFRUolMlz3+/xJwCffMHBKdDY066n?=
 =?us-ascii?Q?YXPCZ9uMEXUzeTcrNP0ZpZxloSLxw9l5kjDyQqXnbskl61l30j1Cs7GnwID4?=
 =?us-ascii?Q?XgVbT9yaV0dU3nrLngdBgbaPxOXDkLPakqRm8gREgQTkn5XX2qm/Ke6AV+bh?=
 =?us-ascii?Q?1PEI+JVpAe5b8JeQ1zyQ4Fg24jB309IcWuwp6sciLkMsW/CvmBX1Um3cHzif?=
 =?us-ascii?Q?pIxH+dTChJoR13YPdOCRQ5niV1tIAfLm/H8aVtQwWZ7imW+9UrpDPM3aJLY4?=
 =?us-ascii?Q?r7em82EojeOnrgidAXoZ08yFz4S84iqgPgvaZ8G2KYwRZ63p5HYYUMyGQqoi?=
 =?us-ascii?Q?NfSzm2ilUaKmcLvQNp5meIc9KciPMolsHE3nQWbxxLchNf/ARoed9mDh17fT?=
 =?us-ascii?Q?qYd65E4R8JWcOA0iFjk=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(61400799027)(36860700013)(82310400026)(376014);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: list.ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 01:40:10.6705 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 679bb1d6-9924-46d3-d8f7-08de36c3e424
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7046
X-Mailman-Approved-At: Tue, 09 Dec 2025 10:26:50 +0100
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

ti-u-boot / 25.01 / 20251208-gpt-support-v1-1-0cde970713c3

PRC Results: PASS

=========================================================
  apply-patch: PASS
=========================================================
Summary:
- Patch Series: [PATCH tiU2025.01] PENDING: configs: am62lx_evm: add GPT GUID partition types
- Submitter: From: Bryan Brattlof <bb@ti.com>
- Date: Date: Mon, 8 Dec 2025 07:20:42 -0600
- Num Patches: 1
- Mailing List (public inbox) Commit SHA: 5fffa48d97296a00776278b61066fb9236c433a9

Applied to:
- Repository: lcpd-prc-ti-u-boot
- Base Branch: ti-u-boot-2025.01-next
- Commit Author: Yogesh Hegde <y-hegde@ti.com>
- Commit Subject: PENDING: configs: am62lx_evm_defconfig: Remove CONFIG_SYS_BOOTM_LEN
- Commit SHA: 7493977a537fe3f8a45814c6284b942f7f09e035

Patches
----------------------------------------
All patches applied



=========================================================
  build-and-boot: PASS
=========================================================
Results: http://lcpdresults.itg.ti.com/build/results/prc.ti-u-boot-25.01-20251208-gpt-support-v1-1-0cde970713c3-202512081326

Builds
----------------------------------------
All builds passed

Boot Tests
----------------------------------------
All boot tests passed



