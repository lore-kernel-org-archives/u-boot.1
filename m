Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED9A0CE8D52
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 16:49:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ED43841E0;
	Fri, 14 Nov 2025 17:49:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="bKxW3wat";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB50183EDF; Fri, 14 Nov 2025 17:49:10 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 008E7841E0
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 17:49:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=3413684226=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AEGgd4r3043344; Fri, 14 Nov 2025 17:49:01 +0100
Received: from du2pr03cu002.outbound.protection.outlook.com
 (mail-northeuropeazon11011004.outbound.protection.outlook.com [52.101.65.4])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4adr7kktx9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 14 Nov 2025 17:49:00 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/vgvdZOd4AEChwA8i6Vz1rlKK/RQ/uUvoWRsIRAt39OUzZVFl404/+hX3125JbatJb1jbxeAMQ5Uw/zzPvFvrqGWfDMBeLZGH4Jh4GqqOZLW3+ZjGGDHgfB6nJeFdrEQyz6tPWd8963DHyy0z4XMG3JgjGcC8xV8My9eR3GINNDiCiGimvdL/CsYhoVMQ+cNsyRxG4VkeN6O/TgK9fB4OXOY+4uP8gncch7IiOY7GOjOuqwLram9hRBFVVPmIccObak1IOKA6dgilPMyEQGoo5TMgyubSs9wUSBsx5PZE94Vl1vGhcyePkLYwo3kqdpKlrSuOpsbLLm+cWSf1Clxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CnRi33FspXj5YG/5QLvBiUM/sVNYVbdLtVuJWfZfviw=;
 b=GnTCwNa5ix9t7KAmgmM4nsRgINxXfXAvFwITnWjiIZ2ZLcmR5LarIsQH/1p4v6/qEGugaS/8G3csrksS7xyrUv/nGvs/4CZkDW24xBrt3rCFsRlUfVDdMIQPXb5bm6uf2vvQAIyrAsmDOYxwsmDV4lPWUjGzqGJ5vrTOroUx01flYCe0kwjYIdVJM+PtWXgCUt0O396CH61Bcnbp6UsU4wmP0yCE7KHas9qYOXphnFFy1maTdfOMsKIBF7KtpQ7mvv+RDKei3JktiL1yZKRSRM1lGMIanpDt4Wpvr7Y7nFuPYvmGbhYTO7nUR4qc1oEa8NmMF5y864iN/X9gVXPktg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=konsulko.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnRi33FspXj5YG/5QLvBiUM/sVNYVbdLtVuJWfZfviw=;
 b=bKxW3wataQ9AcMBH9XAGTtWnjQIiPS894y7Pp0Ktw+54xS4AZbzhXSWsVk2bqoDnFfnwHvwF5hg8vRZ3mT06tp9rP3HOviyqrM71l+1Kj5tAuJw2VnNlKQSQVvObLnZBZXS60/dtzgU5FO/d+x/cK17r7QpIRegRjukfNW/qGdwZ4qvbtUUT+zM/T2IFMqNHTJMU/Tds+HZXwteIvPHcMMbNikbFSPhJwQg4/i7AbkVQow0/8bfTDuponu+F2zVQAODqIJo2yj8uYz1ZwAAdZsQG+nKb8IMoQDqmEgg3NC3mDrKNcfVHNs5PYMIsZP3ombiel6tOm4Eu6B0KjksGWg==
Received: from DB8P191CA0025.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::35)
 by DB8PR10MB3308.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 16:48:55 +0000
Received: from DU2PEPF00028D0F.eurprd03.prod.outlook.com
 (2603:10a6:10:130:cafe::d9) by DB8P191CA0025.outlook.office365.com
 (2603:10a6:10:130::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Fri,
 14 Nov 2025 16:48:50 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DU2PEPF00028D0F.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 16:48:54 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 14 Nov
 2025 17:49:06 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 14 Nov
 2025 17:48:53 +0100
Message-ID: <cca9c045-dcc0-46a3-8080-7530ecd76cc7@foss.st.com>
Date: Fri, 14 Nov 2025 17:48:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] video: stm32: STM32 driver support for LVDS
To: Yannick FERTRE <yannick.fertre@foss.st.com>, Raphael Gallais-Pou
 <raphael.gallais-pou@foss.st.com>,
 Tom Rini <trini@konsulko.com>, Kamil Lulko <kamil.lulko@gmail.com>,
 Dillon Min <dillon.minfei@gmail.com>, "Patrick
 Delaunay" <patrick.delaunay@foss.st.com>, Anatolij Gustschin
 <ag.dev.uboot@gmail.com>, Simon Glass <sjg@chromium.org>, Sumit Garg
 <sumit.garg@kernel.org>, Philippe Cornu <philippe.cornu@foss.st.com>
CC: <u-boot@lists.denx.de>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20250904-master-v3-0-b42847884974@foss.st.com>
 <20250904-master-v3-3-b42847884974@foss.st.com>
 <27557cfa-f511-4883-9042-fe1ccb2e6127@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <27557cfa-f511-4883-9042-fe1ccb2e6127@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0F:EE_|DB8PR10MB3308:EE_
X-MS-Office365-Filtering-Correlation-Id: ae98fcc8-2d55-480e-f91e-08de239db2c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MTRZemhSTVIyQWdxN1BtSjRKWHE5UDA0Yk5US2JhaFZkVFluL2Exb3VhOHVt?=
 =?utf-8?B?TU1rYkc4K1NaQkN1aGlZTkszTWdMS3FwbHdTMHpUYzVHQjI4S01BWU1ETGNj?=
 =?utf-8?B?aG50ODl1M2lULzliOFNoQ2ltaVl2ejc2Z3RXWm5pUUFCTUFZQUZQTkFVSkhI?=
 =?utf-8?B?cXNvSnRlTXZRQnNBZGc1V3EzelhzYUdCc1BUdjdCcXlrc0gyN2RyWDI2bWlZ?=
 =?utf-8?B?TTViQWFSeUR4Q0w2Wm5lc1Jpa0QrWS9EOGtqMGpYNXNhV0N0VTVoamhVbjdY?=
 =?utf-8?B?UmYwckZXeXR0ZTdVR21qZGZMNEJJbE1YYmIyelZRUFg5U0VwYW03M3o1SXB2?=
 =?utf-8?B?MklYbWRuUnltUmV2QmJnWFNGYzJZRVNSakF6dHMzN1YvQmg4ZVgvWjM4dG9L?=
 =?utf-8?B?M2lmOTlxQmhoZ1pBa2VtSENEbzM5MGtHZFkxMVEza0lYYXBhVVFDTmNGNnpU?=
 =?utf-8?B?N0JNUWdieEVlSXFrZzJvSTM0b3lUOVoxNnQxMkxQMFp5MXJVTDZWdmlJdGVD?=
 =?utf-8?B?UG1FT2pISTJYVXZad21oME9ZNnBod0cwbElsaVcvQjFlL3ltbHpaU2srVXFp?=
 =?utf-8?B?UUNod3I3emRheExLRW9obU1vUmQ4SmhvYlc4RXpadXpVYS9xM3ZPUTZDcGZ0?=
 =?utf-8?B?akJJNU0yT1k0VjJ6YU9kM2xQR1N6RERqWWc0ZFRSNHArY3JJK1pLdmNoVGJQ?=
 =?utf-8?B?UENqSndZdGR6aTRaNDdmaGtHWVJ5a2JRR2tpNkRTaE5ickdPRDJYZG1RN1VE?=
 =?utf-8?B?WEZ2c3ZSa3o3dXBKRTRYQzN3bmd5c2dkRmFabUVWSXB6b0NiZHRkVDdFUHNB?=
 =?utf-8?B?ZEdHbUgwQ3MvVHVoaUpNU0lzKy9Ha0MyYVdrdWVkMzkyUVNYb2E2VCt6TG1R?=
 =?utf-8?B?dUVFTDBEQXBuTHZSUUhkRnJFSHo2TmhNT1oxZmpBSGMwV0dSaU5MUFRkbnE2?=
 =?utf-8?B?cjVQRWVvQ3lKdU5xMC9FUFVCUk5UdHY2T09Ddys4cEk3cjIzcXZLby9JbWFx?=
 =?utf-8?B?ck04NWQyamh3RGY4WlJDSGhNTlhNSElVeVFpWHRIYjhPeWE3SmhsOHIxMERy?=
 =?utf-8?B?bFAyVmZWSjY4NXVvZmtZTzM1UHhaWE1FTUJIK0wvVkdMQnJlcml4RXNYNWUx?=
 =?utf-8?B?V0NUSkZRbE40N3hFZStWeDIwc1cxOVRKSlM2YVN2a3lpWU1WQllVTEZWUzJZ?=
 =?utf-8?B?TkIwY3FmUzRoN1RQdHdTSzRxRWcyRkJucVVKcFZwUnd6Qi8wQnlvVGM1YS9j?=
 =?utf-8?B?RmNrbzNFY1BnMHNaU1hVTDk4RU9WbWRYVTI0NldhK1ArUkl5V3BzVXAreVVt?=
 =?utf-8?B?SDdhTzdTL0pROU9YRC9Vdm92YlpYRHJmRlhod2I3azJ1SmFuaFhPYVhpc2h3?=
 =?utf-8?B?YUNrZTJ5d25pTnlvZXlKSVAzWFlMZHBKaE9PSkxnb2xVcWV2bDJXTWRySzFU?=
 =?utf-8?B?L09GeG9VcUdwakJITzJpbm9OTWlzbG1mMFpLc25QTFlBMFphSGNDbUh1Ymdj?=
 =?utf-8?B?SlRCTVgxZm9mNkorbk5NQzRQSWtmREYyNWRuNW91RytMb3lKZmM3WldhWktJ?=
 =?utf-8?B?K0VhZVlTTUJPdVdyK2E4QUliNHFENmxxaWUxR1ZnbkhRYTdnUER4MGVqWEVE?=
 =?utf-8?B?N2tzOHkybGZWa1BvelpQMGo0enFSRis2TmxCQXJGZGhoWUdBUFZNR2RZZDVM?=
 =?utf-8?B?MWpSSzh3bWsvYnRxV2srN2Q5bER1TGduaEd5V2htZXVXQ0M3SlJia2x4Q2lQ?=
 =?utf-8?B?clRibVJUNFNiUE81bFNldU1yUWxROE9ibC9GUUFqT0tVaEliZXdsVjYvVlE5?=
 =?utf-8?B?T3EzdVFjbmRLM3Z5ajErZXI0aVRBQUJRSDJYVUN4emVuYmhkY0UyUGUzTDVO?=
 =?utf-8?B?eHRwSEVaSGdTd2JlK3FFRXRlQ1NUWnlFeVRDb3EvaVY3WlU2eTc3eDFIQ2pl?=
 =?utf-8?B?cDBSRzcrZkxFTXdVQmVXcW12MGY3SDcza1RzbHVFTkJvYjBYQXZUcy9OdUtO?=
 =?utf-8?B?YldCL0R4YlRNbTNHbUdETTFHZi9OWXdYSGE2WS9wMlU3bElmSjdESzc0bDN1?=
 =?utf-8?B?N0tPZWpqcjBFbk9JclBaaFRVZHZ5M1JPS0JUQkdYWXNSQjNzb3pmSHJOTzJz?=
 =?utf-8?Q?i/sKZb8J2Sdow6IAb03Ggo1Ix?=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(921020); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 16:48:54.8516 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae98fcc8-2d55-480e-f91e-08de239db2c9
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D0F.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3308
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDEzNSBTYWx0ZWRfX+NBz+cZV+O2B
 4CDdwG4bNCqcVb+Qb1xcQmlNSmGL6+ffFufWan0z5ynvU+6ZWOGwo0bweMfi3vL9GlFDdFTImBQ
 umCQMJEXUxb6SBKSBp/QwCdDZAAzejVncXyb5EbDNXHpaveEAZP6f6/a4fgFpKqvtM/cg8Q/36Z
 ivIZ1wurIzEdCVBXyyRA6ua5tfQNcfk/wADakIHjyhX8WvVRKmD31yUnz8zA2uXzyRDMjheeFXx
 ziYWOvo84CuKwnEonYM67jYR9/haRSZZw2iFWmquQCqnu6ZUanxjhPuDGTpUXEGPcHII5+eoluK
 UqDBh5TK42QredC4WuMHXlYXIYdT/VIseq25pvfNsJc0kDFJeC7aeNXtCBIoQJh6o4VDiLZ5tE9
 K0HAthRRPsHM9y4GZ2qMqZh+eaOuIQ==
X-Authority-Analysis: v=2.4 cv=Xsf3+FF9 c=1 sm=1 tr=0 ts=69175d7d cx=c_pps
 a=kUaKQbrk1EUcZEUbdnmukQ==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=S_TiGCs-rbm_YQGjGaIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: gEa22Q5xghQ1U6IgctNPCk2t5WjJQQa8
X-Proofpoint-GUID: gEa22Q5xghQ1U6IgctNPCk2t5WjJQQa8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_05,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511140135
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



On 10/30/25 08:42, Yannick FERTRE wrote:
> Hi Raphael,
> 
> Thanks for the patch.
> 
> Acked-by: Yannick Fertre<yannick.fertre@foss.st.com>
> 
> Le 04/09/2025 à 14:53, Raphael Gallais-Pou a écrit :
>> The LVDS Display Interface Transmitter handles the LVDS protocol:
>> it maps the pixels received from the upstream Pixel-DMA (LTDC)
>> onto the LVDS PHY.
>>
>> The LVDS controller driver supports the following high-level features:
>>          • FDP-Link-I and OpenLDI (v0.95) protocols
>>          • Single-Link or Dual-Link operation
>>          • Single-Display or Double-Display (with the same content
>>            duplicated on both)
>>          • Flexible Bit-Mapping, including JEIDA and VESA
>>          • RGB888 or RGB666 output
>>          • Synchronous design, with one input pixel per clock cycle
>>          • No resolution limitation.
>>
>> Acked-by: Yannick Fertre <yannick.fertre@foss.st.com>
>> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
>> ---
>>   MAINTAINERS                      |   1 +
>>   doc/board/st/st-dt.rst           |   1 +
>>   drivers/video/stm32/Kconfig      |   9 +
>>   drivers/video/stm32/Makefile     |   1 +
>>   drivers/video/stm32/stm32_lvds.c | 693 +++++++++++++++++++++++++++++++++++++++
>>   5 files changed, 705 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 3fb163aa1db1dba249e60b40ab3e785db4fde5d3..604ba4ca04c1079b14cd8f4c1fff4c12da0e278d 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -728,6 +728,7 @@ F:    drivers/serial/serial_stm32.*
>>   F:    drivers/spi/stm32_qspi.c
>>   F:    drivers/spi/stm32_spi.c
>>   F:    drivers/video/stm32/stm32_ltdc.c
>> +F:    drivers/video/stm32/stm32_lvds.c
>>   F:    drivers/watchdog/stm32mp_wdt.c
>>   F:    include/dt-bindings/clock/stm32fx-clock.h
>>   F:    include/dt-bindings/clock/stm32mp*
>> diff --git a/doc/board/st/st-dt.rst b/doc/board/st/st-dt.rst
>> index 2a285c81807ee26924948d8c2497f11dfe45b6e6..28cada97e72da711408a1aaaa928ad3faa51162e 100644
>> --- a/doc/board/st/st-dt.rst
>> +++ b/doc/board/st/st-dt.rst
>> @@ -25,6 +25,7 @@ kernel binding directory = Documentation/devicetree/bindings/
>>   * display
>>       - display/st,stm32-dsi.yaml
>>       - display/st,stm32-ltdc.yaml
>> +        - display/st,stm32mp25-lvds.yaml
>>   * gpio
>>       - pinctrl/st,stm32-pinctrl.yaml
>>   * hwlock
>> diff --git a/drivers/video/stm32/Kconfig b/drivers/video/stm32/Kconfig
>> index c354c402c288b4c004bd2b5cc74a4d00beef2773..4cb8a841caf51aaba5115b9fcddb967f73a3d9b4 100644
>> --- a/drivers/video/stm32/Kconfig
>> +++ b/drivers/video/stm32/Kconfig
>> @@ -23,6 +23,15 @@ config VIDEO_STM32_DSI
>>         This option enables support DSI internal bridge which can be used on
>>         devices which have DSI devices connected.
>>   +config VIDEO_STM32_LVDS
>> +    bool "Enable STM32 LVDS video support"
>> +    depends on VIDEO_STM32
>> +    select VIDEO_BRIDGE
>> +    select VIDEO_DW_MIPI_DSI
>> +    help
>> +      This enables Low Voltage Differential Signaling (LVDS) display
>> +      support.
>> +
>>   config VIDEO_STM32_MAX_XRES
>>       int "Maximum horizontal resolution (for memory allocation purposes)"
>>       depends on VIDEO_STM32
>> diff --git a/drivers/video/stm32/Makefile b/drivers/video/stm32/Makefile
>> index f8b42d1a4d126a31aa11ce820e829b133ca3bb2d..059d9000c1d7762d06bff36d5408143a34848227 100644
>> --- a/drivers/video/stm32/Makefile
>> +++ b/drivers/video/stm32/Makefile
>> @@ -7,3 +7,4 @@
>>     obj-${CONFIG_VIDEO_STM32} = stm32_ltdc.o
>>   obj-${CONFIG_VIDEO_STM32_DSI} += stm32_dsi.o
>> +obj-${CONFIG_VIDEO_STM32_LVDS} += stm32_lvds.o
>> diff --git a/drivers/video/stm32/stm32_lvds.c b/drivers/video/stm32/stm32_lvds.c
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..bf1393c9e8724ed099aeed63344ebdc0004507b6
>> --- /dev/null
>> +++ b/drivers/video/stm32/stm32_lvds.c
>> @@ -0,0 +1,693 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
>> +/*
>> + * Copyright (C) 2025 STMicroelectronics - All Rights Reserved
>> + * Author(s): Raphaël Gallais-Pou <raphael.gallais-pou@foss.st.com> for STMicroelectronics.
>> + *
>> + * This Low Voltage Differential Signal controller driver is based on the Linux Kernel driver from
>> + * drivers/gpu/drm/stm/ltdc.c
>> + */
>> +
>> +#define LOG_CATEGORY UCLASS_VIDEO_BRIDGE
>> +
>> +#include <clk.h>
>> +#include <dm.h>
>> +#include <log.h>
>> +#include <media_bus_format.h>
>> +#include <panel.h>
>> +#include <reset.h>
>> +#include <video.h>
>> +#include <video_bridge.h>
>> +#include <asm/io.h>
>> +#include <dm/device_compat.h>
>> +#include <dm/ofnode.h>
>> +#include <linux/iopoll.h>
>> +
>> +/* LVDS Host registers */
>> +#define LVDS_CR        0x0000  /* configuration register */
>> +#define LVDS_DMLCR0    0x0004  /* data mapping lsb configuration register 0    */
>> +#define LVDS_DMMCR0    0x0008  /* data mapping msb configuration register 0    */
>> +#define LVDS_DMLCR1    0x000C  /* data mapping lsb configuration register 1    */
>> +#define LVDS_DMMCR1    0x0010  /* data mapping msb configuration register 1    */
>> +#define LVDS_DMLCR2    0x0014  /* data mapping lsb configuration register 2    */
>> +#define LVDS_DMMCR2    0x0018  /* data mapping msb configuration register 2    */
>> +#define LVDS_DMLCR3    0x001C  /* data mapping lsb configuration register 3    */
>> +#define LVDS_DMMCR3    0x0020  /* data mapping msb configuration register 3    */
>> +#define LVDS_DMLCR4    0x0024  /* data mapping lsb configuration register 4    */
>> +#define LVDS_DMMCR4    0x0028  /* data mapping msb configuration register 4    */
>> +#define LVDS_DMLCR(id)    (LVDS_DMLCR0 + 8U * (id))
>> +#define LVDS_DMMCR(id)    (LVDS_DMMCR0 + 8U * (id))
>> +#define LVDS_CDL1CR    0x002C  /* channel distrib link 1 configuration register    */
>> +#define LVDS_CDL2CR    0x0030  /* channel distrib link 2 configuration register    */
>> +
>> +#define CDL1CR_DEFAULT    0x4321
>> +#define CDL2CR_DEFAULT    0x59876
>> +
>> +/* LVDS Host registers */
>> +#define LVDS_PHY_MASTER    0x0
>> +#define LVDS_PHY_SLAVE    0x100
>> +
>> +/* phy parameter can only be one of those two above */
>> +#define LVDS_PXGCR(phy)        ((phy) + 0x1000)   /* Global Control Register    */
>> +#define LVDS_PXCMCR1(phy)    ((phy) + 0x100C)   /* Current Mode Control Register 1 */
>> +#define LVDS_PXCMCR2(phy)    ((phy) + 0x1010)  /* Current Mode Control Register 2 */
>> +#define LVDS_PXSCR(phy)        ((phy) + 0x1020)  /* Serial Control Register    */
>> +#define LVDS_PXBCR1(phy)    ((phy) + 0x102C)  /* Bias Control Register 1    */
>> +#define LVDS_PXBCR2(phy)    ((phy) + 0x1030)  /* Bias Control Register 2    */
>> +#define LVDS_PXBCR3(phy)    ((phy) + 0x1034)  /* Bias Control Register 3    */
>> +#define LVDS_PXMPLCR(phy)    ((phy) + 0x1064)  /* Monitor PLL Lock Control Register */
>> +#define LVDS_PXDCR(phy)        ((phy) + 0x1084)  /* Debug Control Register    */
>> +#define LVDS_PXSSR1(phy)    ((phy) + 0x1088)  /* Spare Status Register 1    */
>> +#define LVDS_PXCFGCR(phy)    ((phy) + 0x10A0)  /* Configuration Control Register */
>> +#define LVDS_PXPLLCR1(phy)    ((phy) + 0x10C0)  /* PLL_MODE 1 Control Register    */
>> +#define LVDS_PXPLLCR2(phy)    ((phy) + 0x10C4)  /* PLL_MODE 2 Control Register    */
>> +#define LVDS_PXPLLSR(phy)    ((phy) + 0x10C8)  /* PLL Status Register    */
>> +#define LVDS_PXPLLSDCR1(phy)    ((phy) + 0x10CC)  /* PLL_SD_1 Control Register    */
>> +#define LVDS_PXPLLSDCR2(phy)    ((phy) + 0x10D0)  /* PLL_SD_2 Control Register    */
>> +#define LVDS_PXPLLTWGCR1(phy)    ((phy) + 0x10D4)  /* PLL_TWG_1 Control Register    */
>> +#define LVDS_PXPLLTWGCR2(phy)    ((phy) + 0x10D8)  /* PLL_TWG_2 Control Register    */
>> +#define LVDS_PXPLLCPCR(phy)    ((phy) + 0x10E0)  /* PLL_CP Control Register    */
>> +#define LVDS_PXPLLTESTCR(phy)    ((phy) + 0x10E8)  /* PLL_TEST Control Register    */
>> +
>> +/* LVDS Wrapper registers */
>> +#define LVDS_WCLKCR    0x11B0  /* Wrapper clock control register */
>> +#define LVDS_HWCFGR    0x1FF0  /* HW configuration register    */
>> +#define LVDS_VERR    0x1FF4  /* Version register    */
>> +#define LVDS_IPIDR    0x1FF8  /* Identification register    */
>> +#define LVDS_SIDR    0x1FFC  /* Size Identification register    */
>> +
>> +#define CR_LVDSEN    BIT(0)  /* LVDS PHY Enable */
>> +#define CR_HSPOL    BIT(1)  /* HS Polarity (horizontal sync) */
>> +#define CR_VSPOL    BIT(2)  /* VS Polarity (vertical sync) */
>> +#define CR_DEPOL    BIT(3)  /* DE Polarity (data enable) */
>> +#define CR_CI        BIT(4)  /* Control Internal (software controlled bit) */
>> +#define CR_LKMOD    BIT(5)  /* Link Mode, for both Links */
>> +#define CR_LKPHA    BIT(6)  /* Link Phase, for both Links */
>> +#define CR_LK1POL    GENMASK(20, 16)  /* Link-1 output Polarity */
>> +#define CR_LK2POL    GENMASK(25, 21)  /* Link-2 output Polarity */
>> +
>> +#define DMMCRX_MAP0    GENMASK(4, 0)
>> +#define DMMCRX_MAP1    GENMASK(9, 5)
>> +#define DMMCRX_MAP2    GENMASK(14, 10)
>> +#define DMMCRX_MAP3    GENMASK(19, 15)
>> +#define DMLCRX_MAP4    GENMASK(4, 0)
>> +#define DMLCRX_MAP5    GENMASK(9, 5)
>> +#define DMLCRX_MAP6    GENMASK(14, 10)
>> +
>> +#define CDLCRX_DISTR0    GENMASK(3, 0)
>> +#define CDLCRX_DISTR1    GENMASK(7, 4)
>> +#define CDLCRX_DISTR2    GENMASK(11, 8)
>> +#define CDLCRX_DISTR3    GENMASK(15, 12)
>> +#define CDLCRX_DISTR4    GENMASK(19, 16)
>> +
>> +#define FREF_INDEX    0
>> +#define NDIV_INDEX    1
>> +#define FPFD_INDEX    2
>> +#define MDIV_INDEX    3
>> +#define FVCO_INDEX    4
>> +#define BDIV_INDEX    5
>> +#define FBIT_INDEX    6
>> +#define FLS_INDEX    7
>> +#define FDP_INDEX    8
>> +
>> +#define PXGCR_BIT_CLK_OUT    BIT(0)
>> +#define PXGCR_LS_CLK_OUT    BIT(4)
>> +#define PXGCR_DP_CLK_OUT    BIT(8)
>> +#define PXGCR_RSTZ        BIT(24)
>> +#define PXGCR_DIV_RSTN        BIT(25)
>> +
>> +#define PXCMCR1_CM_EN_DL    (BIT(28) | BIT(20) | BIT(12) | BIT(4))
>> +#define PXCMCR2_CM_EN_DL4    BIT(4)
>> +#define PXSCR_SER_DATA_OK    BIT(16)
>> +#define PXBCR1_EN_BIAS_DL    (BIT(16) | BIT(12) | BIT(8) | BIT(4) | BIT(0))
>> +#define PXBCR2_BIAS_EN        BIT(28)
>> +#define PXBCR3_VM_EN_DL        (BIT(16) | BIT(12) | BIT(8) | BIT(4) | BIT(0))
>> +#define PXDCR_POWER_OK        BIT(12)
>> +#define PXCFGCR_EN_DIG_DL    GENMASK(4, 0)
>> +
>> +#define PXPLLCR1_PLL_EN        BIT(0)
>> +#define PxPLLCR1_SD_EN        BIT(1)
>> +#define PXPLLCR1_TWG_EN        BIT(2)
>> +#define PXPLLCR1_PLL_DIVIDERS_EN    BIT(8)
>> +#define PXPLLCR2_NDIV        GENMASK(25, 16)
>> +#define PXPLLCR2_BDIV        GENMASK(9, 0)
>> +#define PXPLLSR_PLL_LOCK    BIT(0)
>> +#define PXPLLSDCR1_MDIV        GENMASK(9, 0)
>> +#define PXPLLCPCR_CPCTRL_DEFAULT    0x1
>> +#define PXPLLTESTCR_PLL_TEST_CLK_EN    BIT(0)
>> +#define PXPLLTESTCR_PLL_TDIV_EN        BIT(8)
>> +#define PXPLLTESTCR_TDIV    GENMASK(25, 16)
>> +#define PXPLLTESTCR_TDIV_VALUE    70
>> +
>> +#define WCLKCR_SLV_CLKPIX_SEL    BIT(0)
>> +#define WCLKCR_SRCSEL        BIT(8)
>> +
>> +/* Sleep & timeout for pll lock/unlock */
>> +#define SLEEP_US    1000
>> +#define TIMEOUT_US    20000000
>> +
>> +#define PHY_SLV_OFS    0x100
>> +
>> +/* PLL parameters */
>> +#define NDIV_MIN    2
>> +#define NDIV_MAX    6
>> +#define BDIV_MIN    2
>> +#define BDIV_MAX    6
>> +#define MDIV_MIN    1
>> +#define MDIV_MAX    1023
>> +
>> +struct stm32_lvds_plat {
>> +    void __iomem *base;
>> +    struct udevice *panel;
>> +    struct reset_ctl rst;
>> +    struct clk pclk;
>> +    struct clk refclk;
>> +};
>> +
>> +struct stm32_lvds_priv {
>> +    struct display_timing timings;
>> +    u32 refclk_rate;
>> +    int dual_link;
>> +    int bus_format;
>> +};
>> +
>> +/*
>> + * enum lvds_pixels_order - Pixel order of an LVDS connection
>> + * @LVDS_DUAL_LINK_EVEN_ODD_PIXELS: Even pixels are expected to be generated
>> + *    from the first port, odd pixels from the second port
>> + * @LVDS_DUAL_LINK_ODD_EVEN_PIXELS: Odd pixels are expected to be generated
>> + *    from the first port, even pixels from the second port
>> + */
>> +enum lvds_pixels_order {
>> +    LVDS_DUAL_LINK_EVEN_ODD_PIXELS = BIT(0),
>> +    LVDS_DUAL_LINK_ODD_EVEN_PIXELS = BIT(1),
>> +};
>> +
>> +enum lvds_pixel {
>> +    PIX_R_0        = 0x00,
>> +    PIX_R_1        = 0x01,
>> +    PIX_R_2        = 0x02,
>> +    PIX_R_3        = 0x03,
>> +    PIX_R_4        = 0x04,
>> +    PIX_R_5        = 0x05,
>> +    PIX_R_6        = 0x06,
>> +    PIX_R_7        = 0x07,
>> +    PIX_G_0        = 0x08,
>> +    PIX_G_1        = 0x09,
>> +    PIX_G_2        = 0x0A,
>> +    PIX_G_3        = 0x0B,
>> +    PIX_G_4        = 0x0C,
>> +    PIX_G_5        = 0x0D,
>> +    PIX_G_6        = 0x0E,
>> +    PIX_G_7        = 0x0F,
>> +    PIX_B_0        = 0x10,
>> +    PIX_B_1        = 0x11,
>> +    PIX_B_2        = 0x12,
>> +    PIX_B_3        = 0x13,
>> +    PIX_B_4        = 0x14,
>> +    PIX_B_5        = 0x15,
>> +    PIX_B_6        = 0x16,
>> +    PIX_B_7        = 0x17,
>> +    PIX_H_S        = 0x18,
>> +    PIX_V_S        = 0x19,
>> +    PIX_D_E        = 0x1A,
>> +    PIX_C_E        = 0x1B,
>> +    PIX_C_I        = 0x1C,
>> +    PIX_TOG        = 0x1D,
>> +    PIX_ONE        = 0x1E,
>> +    PIX_ZER        = 0x1F,
>> +};
>> +
>> +/*
>> + * Expected JEIDA-RGB888 data to be sent in LSB format
>> + *        bit6 ............................bit0
>> + */
>> +const enum lvds_pixel lvds_bitmap_jeida_rgb888[5][7] = {
>> +    { PIX_ONE, PIX_ONE, PIX_ZER, PIX_ZER, PIX_ZER, PIX_ONE, PIX_ONE },
>> +    { PIX_G_2, PIX_R_7, PIX_R_6, PIX_R_5, PIX_R_4, PIX_R_3, PIX_R_2 },
>> +    { PIX_B_3, PIX_B_2, PIX_G_7, PIX_G_6, PIX_G_5, PIX_G_4, PIX_G_3 },
>> +    { PIX_D_E, PIX_V_S, PIX_H_S, PIX_B_7, PIX_B_6, PIX_B_5, PIX_B_4 },
>> +    { PIX_C_E, PIX_B_1, PIX_B_0, PIX_G_1, PIX_G_0, PIX_R_1, PIX_R_0 }
>> +};
>> +
>> +/*
>> + * Expected VESA-RGB888 data to be sent in LSB format
>> + *        bit6 ............................bit0
>> + */
>> +const enum lvds_pixel lvds_bitmap_vesa_rgb888[5][7] = {
>> +    { PIX_ONE, PIX_ONE, PIX_ZER, PIX_ZER, PIX_ZER, PIX_ONE, PIX_ONE },
>> +    { PIX_G_0, PIX_R_5, PIX_R_4, PIX_R_3, PIX_R_2, PIX_R_1, PIX_R_0 },
>> +    { PIX_B_1, PIX_B_0, PIX_G_5, PIX_G_4, PIX_G_3, PIX_G_2, PIX_G_1 },
>> +    { PIX_D_E, PIX_V_S, PIX_H_S, PIX_B_5, PIX_B_4, PIX_B_3, PIX_B_2 },
>> +    { PIX_C_E, PIX_B_7, PIX_B_6, PIX_G_7, PIX_G_6, PIX_R_7, PIX_R_6 }
>> +};
>> +
>> +static inline void lvds_writel(void __iomem *base, u32 reg, u32 val)
>> +{
>> +    writel(val, base + reg);
>> +}
>> +
>> +static inline u32 lvds_readl(void __iomem *base, u32 reg)
>> +{
>> +    return readl(base + reg);
>> +}
>> +
>> +static inline void lvds_set(void __iomem *base, u32 reg, u32 mask)
>> +{
>> +    lvds_writel(base, reg, lvds_readl(base, reg) | mask);
>> +}
>> +
>> +static inline void lvds_clear(void __iomem *base, u32 reg, u32 mask)
>> +{
>> +    lvds_writel(base, reg, lvds_readl(base, reg) & ~mask);
>> +}
>> +
>> +static u32 pll_get_clkout_khz(u32 clkin_khz, u32 bdiv, u32 mdiv, u32 ndiv)
>> +{
>> +    int divisor = ndiv * bdiv;
>> +
>> +    /* Prevents from division by 0 */
>> +    if (!divisor)
>> +        return 0;
>> +
>> +    return clkin_khz * mdiv / divisor;
>> +}
>> +
>> +static int lvds_pll_get_params(u32 clkin_khz, u32 clkout_khz,
>> +                   u32 *bdiv, u32 *mdiv, u32 *ndiv)
>> +{
>> +    u32 i, o, n;
>> +    u32 delta, best_delta; /* all in khz */
>> +
>> +    /* Early checks preventing division by 0 & odd results */
>> +    if (clkin_khz == 0 || clkout_khz == 0)
>> +        return -EINVAL;
>> +
>> +    best_delta = 1000000; /* big started value (1000000khz) */
>> +
>> +    for (i = NDIV_MIN; i <= NDIV_MAX; i++) {
>> +        for (o = BDIV_MIN; o <= BDIV_MAX; o++) {
>> +            n = DIV_ROUND_CLOSEST(i * o * clkout_khz, clkin_khz);
>> +            /* Check ndiv according to vco range */
>> +            if (n < MDIV_MIN || n > MDIV_MAX)
>> +                continue;
>> +            /* Check if new delta is better & saves parameters */
>> +            delta = abs(pll_get_clkout_khz(clkin_khz, i, n, o) - clkout_khz);
>> +            if (delta < best_delta) {
>> +                *ndiv = i;
>> +                *mdiv = n;
>> +                *bdiv = o;
>> +                best_delta = delta;
>> +            }
>> +            /* fast return in case of "perfect result" */
>> +            if (!delta)
>> +                return 0;
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int stm32_lvds_pll_enable(struct udevice *dev,
>> +                 int phy)
>> +{
>> +    struct stm32_lvds_plat *plat = dev_get_plat(dev);
>> +    struct stm32_lvds_priv *priv = dev_get_priv(dev);
>> +    struct display_timing timings = priv->timings;
>> +    u32 pll_in_khz, bdiv = 0, mdiv = 0, ndiv = 0;
>> +    int ret, val, multiplier;
>> +
>> +    /* Release PHY from reset */
>> +    lvds_set(plat->base, LVDS_PXGCR(phy), PXGCR_DIV_RSTN | PXGCR_RSTZ);
>> +
>> +    /* lvds_pll_config */
>> +    /* Set PLL Slv & Mst configs and timings */
>> +    pll_in_khz = priv->refclk_rate / 1000;
>> +
>> +    if (priv->dual_link)
>> +        multiplier = 2;
>> +    else
>> +        multiplier = 1;
>> +
>> +    ret = lvds_pll_get_params(pll_in_khz, timings.pixelclock.typ * 7 / 1000 / multiplier,
>> +                  &bdiv, &mdiv, &ndiv);
>> +    if (ret)
>> +        return ret;
>> +
>> +    /* Set PLL parameters */
>> +    lvds_writel(plat->base, LVDS_PXPLLCR2(phy), (ndiv << 16) | bdiv);
>> +    lvds_writel(plat->base, LVDS_PXPLLSDCR1(phy), mdiv);
>> +    lvds_writel(plat->base, LVDS_PXPLLTESTCR(phy), PXPLLTESTCR_TDIV_VALUE << 16);
>> +
>> +    /* Disable TWG and SD: for now, PLL just need to be in integer mode */
>> +    lvds_clear(plat->base, LVDS_PXPLLCR1(phy), PXPLLCR1_TWG_EN | PxPLLCR1_SD_EN);
>> +
>> +    /* Power up bias and PLL dividers */
>> +    lvds_set(plat->base, LVDS_PXDCR(phy), PXDCR_POWER_OK);
>> +
>> +    lvds_set(plat->base, LVDS_PXCMCR1(phy), PXCMCR1_CM_EN_DL);
>> +    lvds_set(plat->base, LVDS_PXCMCR2(phy), PXCMCR2_CM_EN_DL4);
>> +
>> +    lvds_set(plat->base, LVDS_PXPLLCPCR(phy), PXPLLCPCR_CPCTRL_DEFAULT);
>> +    lvds_set(plat->base, LVDS_PXBCR3(phy), PXBCR3_VM_EN_DL);
>> +    lvds_set(plat->base, LVDS_PXBCR1(phy), PXBCR1_EN_BIAS_DL);
>> +    lvds_set(plat->base, LVDS_PXCFGCR(phy), PXCFGCR_EN_DIG_DL);
>> +
>> +    /* lvds_pll_enable */
>> +    /* PLL lock timing control for the monitor unmask after startup (pll_en) */
>> +    /* Adjust the value so that the masking window is opened at start-up */
>> +    /* MST_MON_PLL_LOCK_UNMASK_TUNE */
>> +    lvds_writel(plat->base, LVDS_PXMPLCR(phy), (0x200 - 0x160) << 16);
>> +
>> +    lvds_writel(plat->base, LVDS_PXBCR2(phy), PXBCR2_BIAS_EN);
>> +
>> +    lvds_set(plat->base, LVDS_PXGCR(phy),
>> +         PXGCR_DP_CLK_OUT | PXGCR_LS_CLK_OUT | PXGCR_BIT_CLK_OUT);
>> +
>> +    lvds_set(plat->base, LVDS_PXPLLTESTCR(phy), PXPLLTESTCR_PLL_TDIV_EN);
>> +    lvds_set(plat->base, LVDS_PXPLLCR1(phy), PXPLLCR1_PLL_DIVIDERS_EN);
>> +    lvds_set(plat->base, LVDS_PXSCR(phy), PXSCR_SER_DATA_OK);
>> +
>> +    /* Enable the LVDS PLL & wait for its lock */
>> +    lvds_set(plat->base, LVDS_PXPLLCR1(phy), PXPLLCR1_PLL_EN);
>> +    ret = readl_poll_sleep_timeout(plat->base + LVDS_PXPLLSR(phy),
>> +                       val, val & PXPLLSR_PLL_LOCK, SLEEP_US, TIMEOUT_US);
>> +    if (ret)
>> +        return ret;
>> +
>> +    /* Select MST PHY clock as pixel clock for the LDITX instead of FREF */
>> +    /* WCLKCR_SLV_CLKPIX_SEL is for dual link */
>> +    lvds_writel(plat->base, LVDS_WCLKCR, WCLKCR_SLV_CLKPIX_SEL);
>> +
>> +    lvds_set(plat->base, LVDS_PXPLLTESTCR(phy), PXPLLTESTCR_PLL_TEST_CLK_EN);
>> +
>> +    return 0;
>> +}
>> +
>> +static int stm32_lvds_enable(struct udevice *dev)
>> +{
>> +    struct stm32_lvds_plat *plat = dev_get_plat(dev);
>> +    struct stm32_lvds_priv *priv = dev_get_priv(dev);
>> +    struct display_timing timings = priv->timings;
>> +    u32 lvds_cdl1cr = 0;
>> +    u32 lvds_cdl2cr = 0;
>> +    u32 lvds_dmlcr = 0;
>> +    u32 lvds_dmmcr = 0;
>> +    u32 lvds_cr = 0;
>> +    int i;
>> +
>> +    lvds_clear(plat->base, LVDS_CDL1CR, CDLCRX_DISTR0 | CDLCRX_DISTR1 | CDLCRX_DISTR2
>> +                    | CDLCRX_DISTR3 | CDLCRX_DISTR4);
>> +    lvds_clear(plat->base, LVDS_CDL2CR, CDLCRX_DISTR0 | CDLCRX_DISTR1 | CDLCRX_DISTR2
>> +                    | CDLCRX_DISTR3 | CDLCRX_DISTR4);
>> +
>> +    /* Set channel distribution */
>> +    lvds_cr &= ~CR_LKMOD;
>> +    lvds_cdl1cr = CDL1CR_DEFAULT;
>> +
>> +    if (priv->dual_link) {
>> +        lvds_cr |= CR_LKMOD;
>> +        lvds_cdl2cr = CDL2CR_DEFAULT;
>> +    }
>> +
>> +    /* Set signal polarity */
>> +    if (timings.flags & DISPLAY_FLAGS_DE_LOW)
>> +        lvds_cr |= CR_DEPOL;
>> +
>> +    if (timings.flags & DISPLAY_FLAGS_HSYNC_LOW)
>> +        lvds_cr |= CR_HSPOL;
>> +
>> +    if (timings.flags & DISPLAY_FLAGS_VSYNC_LOW)
>> +        lvds_cr |= CR_VSPOL;
>> +
>> +    /* Set link phase */
>> +    switch (priv->dual_link) {
>> +    case LVDS_DUAL_LINK_EVEN_ODD_PIXELS: /* LKPHA = 0 */
>> +        lvds_cr &= ~CR_LKPHA;
>> +        break;
>> +    case LVDS_DUAL_LINK_ODD_EVEN_PIXELS: /* LKPHA = 1 */
>> +        lvds_cr |= CR_LKPHA;
>> +        break;
>> +    default:
>> +        dev_dbg(dev, "No phase precised, setting default\n");
>> +        lvds_cr &= ~CR_LKPHA;
>> +        break;
>> +    }
>> +
>> +    /* Set Data Mapping */
>> +    switch (priv->bus_format) {
>> +    case MEDIA_BUS_FMT_RGB888_1X7X4_SPWG: /* VESA-RGB888 */
>> +        for (i = 0; i < 5; i++) {
>> +            lvds_dmlcr = ((lvds_bitmap_vesa_rgb888[i][0])
>> +                      + (lvds_bitmap_vesa_rgb888[i][1] << 5)
>> +                      + (lvds_bitmap_vesa_rgb888[i][2] << 10)
>> +                      + (lvds_bitmap_vesa_rgb888[i][3] << 15));
>> +            lvds_dmmcr = ((lvds_bitmap_vesa_rgb888[i][4])
>> +                      + (lvds_bitmap_vesa_rgb888[i][5] << 5)
>> +                      + (lvds_bitmap_vesa_rgb888[i][6] << 10));
>> +
>> +            /* Write registers at the end of computations */
>> +            lvds_writel(plat->base, LVDS_DMLCR(i), lvds_dmlcr);
>> +            lvds_writel(plat->base, LVDS_DMMCR(i), lvds_dmmcr);
>> +        }
>> +        break;
>> +    case MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA: /* JEIDA-RGB888 */
>> +        for (i = 0; i < 5; i++) {
>> +            lvds_dmlcr = ((lvds_bitmap_jeida_rgb888[i][0])
>> +                      + (lvds_bitmap_jeida_rgb888[i][1] << 5)
>> +                      + (lvds_bitmap_jeida_rgb888[i][2] << 10)
>> +                      + (lvds_bitmap_jeida_rgb888[i][3] << 15));
>> +            lvds_dmmcr = ((lvds_bitmap_jeida_rgb888[i][4])
>> +                      + (lvds_bitmap_jeida_rgb888[i][5] << 5)
>> +                      + (lvds_bitmap_jeida_rgb888[i][6] << 10));
>> +
>> +            /* Write registers at the end of computations */
>> +            lvds_writel(plat->base, LVDS_DMLCR(i), lvds_dmlcr);
>> +            lvds_writel(plat->base, LVDS_DMMCR(i), lvds_dmmcr);
>> +        }
>> +        break;
>> +    default:
>> +        dev_dbg(dev, "Unsupported LVDS bus format 0x%04x\n", priv->bus_format);
>> +    }
>> +
>> +    /* Turn the output on */
>> +    lvds_cr |= CR_LVDSEN;
>> +
>> +    /* Commit config to registers */
>> +    lvds_set(plat->base, LVDS_CR, lvds_cr);
>> +    lvds_writel(plat->base, LVDS_CDL1CR, lvds_cdl1cr);
>> +    lvds_writel(plat->base, LVDS_CDL2CR, lvds_cdl2cr);
>> +
>> +    return 0;
>> +}
>> +
>> +static int stm32_lvds_attach(struct udevice *dev)
>> +{
>> +    struct stm32_lvds_plat *plat = dev_get_plat(dev);
>> +    struct stm32_lvds_priv *priv = dev_get_priv(dev);
>> +    int ret;
>> +
>> +    ret = panel_get_display_timing(plat->panel, &priv->timings);
>> +    if (ret) {
>> +        ret = ofnode_decode_display_timing(dev_ofnode(plat->panel),
>> +                           0, &priv->timings);
>> +        if (ret) {
>> +            dev_err(dev, "decode display timing error %d\n", ret);
>> +            return ret;
>> +        }
>> +    }
>> +
>> +    ret = stm32_lvds_enable(dev);
>> +
>> +    return ret;
>> +}
>> +
>> +static int stm32_lvds_set_backlight(struct udevice *dev, int percent)
>> +{
>> +    struct stm32_lvds_plat *plat = dev_get_plat(dev);
>> +    int ret;
>> +
>> +    ret = panel_enable_backlight(plat->panel);
>> +    if (ret) {
>> +        dev_err(dev, "panel %s enable backlight error %d\n",
>> +            plat->panel->name, ret);
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +static int lvds_handle_pixel_order(struct stm32_lvds_plat *plat)
>> +{
>> +    ofnode parent, panel_port0, panel_port1;
>> +    bool even_pixels, odd_pixels;
>> +    int port0, port1;
>> +
>> +    /*
>> +     * In case we are operating in single link,
>> +     * there is only one port linked to the LVDS.
>> +     * Check whether we are in this case and exit if yes.
>> +     */
>> +    parent = ofnode_find_subnode(dev_ofnode(plat->panel), "ports");
>> +    if (!ofnode_valid(parent))
>> +        return 0;
>> +
>> +    panel_port0 = ofnode_first_subnode(parent);
>> +    if (!ofnode_valid(panel_port0))
>> +        return -EPIPE;
>> +
>> +    even_pixels = ofnode_read_bool(panel_port0, "dual-lvds-even-pixels");
>> +    odd_pixels = ofnode_read_bool(panel_port0, "dual-lvds-odd-pixels");
>> +    if (even_pixels && odd_pixels)
>> +        return -EINVAL;
>> +
>> +    port0 = even_pixels ? LVDS_DUAL_LINK_EVEN_ODD_PIXELS :
>> +        LVDS_DUAL_LINK_ODD_EVEN_PIXELS;
>> +
>> +    panel_port1 = ofnode_next_subnode(panel_port0);
>> +    if (!ofnode_valid(panel_port1))
>> +        return -EPIPE;
>> +
>> +    even_pixels = ofnode_read_bool(panel_port1, "dual-lvds-even-pixels");
>> +    odd_pixels = ofnode_read_bool(panel_port1, "dual-lvds-odd-pixels");
>> +    if (even_pixels && odd_pixels)
>> +        return -EINVAL;
>> +
>> +    port1 = even_pixels ? LVDS_DUAL_LINK_EVEN_ODD_PIXELS :
>> +        LVDS_DUAL_LINK_ODD_EVEN_PIXELS;
>> +
>> +    /*
>> +     * A valid dual-LVDS bus is found when one port is marked with
>> +     * "dual-lvds-even-pixels", and the other port is marked with
>> +     * "dual-lvds-odd-pixels", bail out if the markers are not right.
>> +     */
>> +    if (port0 + port1 != LVDS_DUAL_LINK_EVEN_ODD_PIXELS + LVDS_DUAL_LINK_ODD_EVEN_PIXELS)
>> +        return -EINVAL;
>> +
>> +    return port0;
>> +}
>> +
>> +static int stm32_lvds_of_to_plat(struct udevice *dev)
>> +{
>> +    struct stm32_lvds_plat *plat = dev_get_plat(dev);
>> +    struct stm32_lvds_priv *priv = dev_get_priv(dev);
>> +    const char *data_mapping;
>> +    int ret;
>> +
>> +    plat->base = dev_read_addr_ptr(dev);
>> +    if ((fdt_addr_t)plat->base == FDT_ADDR_T_NONE) {
>> +        dev_err(dev, "Unable to read LVDS base address\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    ret = clk_get_by_name(dev, "pclk", &plat->pclk);
>> +    if (ret) {
>> +        dev_err(dev, "Unable to get peripheral clock: %d\n", ret);
>> +        return ret;
>> +    }
>> +
>> +    ret = clk_get_by_name(dev, "ref", &plat->refclk);
>> +    if (ret) {
>> +        dev_err(dev, "Unable to get reference clock: %d\n", ret);
>> +        return ret;
>> +    }
>> +
>> +    ret = reset_get_by_index(dev, 0, &plat->rst);
>> +    if (ret) {
>> +        dev_err(dev, "Failed to get LVDS reset: %d\n", ret);
>> +        return ret;
>> +    }
>> +
>> +    ret = uclass_get_device_by_driver(UCLASS_PANEL,
>> +                      DM_DRIVER_GET(simple_panel), &plat->panel);
>> +    if (ret) {
>> +        dev_err(dev, "panel device error %d\n", ret);
>> +        return ret;
>> +    }
>> +
>> +    ret = panel_get_display_timing(plat->panel, &priv->timings);
>> +    if (ret) {
>> +        ret = ofnode_decode_display_timing(dev_ofnode(plat->panel),
>> +                           0, &priv->timings);
>> +        if (ret) {
>> +            dev_err(dev, "decode display timing error %d\n", ret);
>> +            return ret;
>> +        }
>> +    }
>> +
>> +    data_mapping = ofnode_read_string(dev_ofnode(plat->panel), "data-mapping");
>> +    if (!strcmp(data_mapping, "vesa-24"))
>> +        priv->bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG;
>> +    else if (!strcmp(data_mapping, "jeida-24"))
>> +        priv->bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA;
>> +    else
>> +        priv->bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG;
>> +
>> +    return 0;
>> +}
>> +
>> +static int stm32_lvds_probe(struct udevice *dev)
>> +{
>> +    struct stm32_lvds_plat *plat = dev_get_plat(dev);
>> +    struct stm32_lvds_priv *priv = dev_get_priv(dev);
>> +    int ret;
>> +
>> +    ret = clk_enable(&plat->pclk);
>> +    if (ret) {
>> +        dev_err(dev, "Failed to enable peripheral clock: %d\n", ret);
>> +        return ret;
>> +    }
>> +
>> +    ret = clk_enable(&plat->refclk);
>> +    if (ret) {
>> +        dev_err(dev, "Failed to enable reference clock: %d\n", ret);
>> +        goto err_clk;
>> +    }
>> +
>> +    priv->refclk_rate = (unsigned int)clk_get_rate(&plat->refclk);
>> +
>> +    reset_deassert(&plat->rst);
>> +
>> +    /* Handle dual link config */
>> +    priv->dual_link = lvds_handle_pixel_order(plat);
>> +    if (priv->dual_link < 0)
>> +        goto err_rst;
>> +
>> +    if (priv->dual_link > 0) {
>> +        ret = stm32_lvds_pll_enable(dev, LVDS_PHY_SLAVE);
>> +        if (ret)
>> +            goto err_rst;
>> +    }
>> +
>> +    ret = stm32_lvds_pll_enable(dev, LVDS_PHY_MASTER);
>> +    if (ret)
>> +        goto err_rst;
>> +
>> +    return 0;
>> +
>> +err_rst:
>> +    clk_disable(&plat->refclk);
>> +err_clk:
>> +    clk_disable(&plat->pclk);
>> +
>> +    return ret;
>> +}
>> +
>> +static const struct video_bridge_ops stm32_lvds_ops = {
>> +    .attach = stm32_lvds_attach,
>> +    .set_backlight = stm32_lvds_set_backlight,
>> +};
>> +
>> +static const struct udevice_id stm32_lvds_ids[] = {
>> +    {.compatible = "st,stm32mp25-lvds"},
>> +    {}
>> +};
>> +
>> +U_BOOT_DRIVER(stm32_lvds) = {
>> +    .name        = "stm32-display-lvds",
>> +    .id        = UCLASS_VIDEO_BRIDGE,
>> +    .of_match    = stm32_lvds_ids,
>> +    .ops        = &stm32_lvds_ops,
>> +    .of_to_plat    = stm32_lvds_of_to_plat,
>> +    .probe        = stm32_lvds_probe,
>> +    .plat_auto    = sizeof(struct stm32_lvds_plat),
>> +    .priv_auto    = sizeof(struct stm32_lvds_priv),
>> +};
>>
Applied to u-boot-stm32/master

Thanks
Patrice
