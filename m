Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40816CA1012
	for <u-boot@archiver.kernel.org>; Thu,  4 Sep 2025 07:05:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE976836AC;
	Thu,  4 Sep 2025 09:05:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="bq1/37vZ";
	dkim=pass (1024-bit key; unprotected) header.d=stmicroelectronics.onmicrosoft.com header.i=@stmicroelectronics.onmicrosoft.com header.b="gxFTI6fo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93A4B836EE; Thu,  4 Sep 2025 09:05:21 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7571283678
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 09:05:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=13429524db=yannick.fertre@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5846Yuwf004214;
 Thu, 4 Sep 2025 09:05:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 iSNiXmPCvQROIXiacFFmvW9APn7IxXBaQSCg8Cemozg=; b=bq1/37vZjrLvUwDX
 4FWojZjq37L3s5eyUunWqJq+8xebsUNOdlh8ROqM1rYjsz6v8fDRg+4vAa7Y8+0w
 gkLk9dGmMFIyh1N2ZtW89Rd0OTpA+0PdTlIiURqMhD33pfNlfmSzQBytJn4SlhzB
 mbRGr0t83rObv2JlgMDLH+EIx0JMu5GXfuHLWw1XKnWPDaUyF54pGYi0g6XNnW65
 13xDFQB5o82BoH/lynSu58KNaJ0en61Id1tx3ad+lscjZV8SqcQ2XOW7f83DWthb
 Xiam409Tf3fJ8uuP4MpVglCrxUDYHGVVvHiJAF2oLqBozEwlkW+hXhdwPzhJT0Y2
 z3JSmQ==
Received: from pa4pr04cu001.outbound.protection.outlook.com
 (mail-francecentralazon11013063.outbound.protection.outlook.com
 [40.107.162.63])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48upqkn1b5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 04 Sep 2025 09:05:02 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AokSV13Aj+lQBed/4N3rQLIeE9QIDGQajZZefZiT1dExpY5YGYH/NpjoMA1obxDqYm2H+gV9S/ynEe+pfL7x8B6X8h78j+Kyyf3MFL/KW6Lwvrnf0roxOIK5Gt2ekc78GObTVTlB6d7moDZCd14N+qyF1KfldIH2hs+qpewhxzaj+9OcR/flwzuvEAD+PYbWdTwrm7Pc09+cUpOUAwcWzyHq9Ot5VHGJLNrzHUN1TjZ3HR3GpdB4CROatJPUwniKcIXy0yo5cUXcMdREUXThT0tHiQLW62sgsoIfb6u+P0quVRIfuDAB0llO8DtZsCTnlP7MiI245YPaNqVcvMmFZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSNiXmPCvQROIXiacFFmvW9APn7IxXBaQSCg8Cemozg=;
 b=ogvdbpFKTk7Cc7sbuRVrTtNc3onWLcLJslvgczEfT6hRzzDEo91YehNQ3PDMYYanqpEkmu+5SDDnyVPD7/h5Sbxr5G5foPGNNm9tDonNwSZ9QSARs49vKiexNdImd09ph+iv0ODbYEl+MAPXEWOh7IrGO6XUarLOli17qi5kWN72wLbaQgxnolipZIV/67fm1M9iEmUad+VhgkbFpqbKc225Z/ndFTeEuWhQqQbatwKXHWNoGa/4eobxxP+yq5ZZ6Ly9/tjzkzmiICip5O9Rgw3eDf5ZiC5jg16Opq2zBQmi1rwHOzh27WDxKUmUHBfhUFjSIXPRMwEDYwJ8FIqdXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.43) smtp.rcpttodomain=konsulko.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stmicroelectronics.onmicrosoft.com;
 s=selector2-stmicroelectronics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSNiXmPCvQROIXiacFFmvW9APn7IxXBaQSCg8Cemozg=;
 b=gxFTI6fo90uN7nMFLxiOSYn7oRH8/TtrnwDBs/oFvDJguHPUc4MkZ/90fTlVeNiJNGtF3XvZbL2E5UDbHfg/lIPRSkbwmUKvIjxCq+Cbyt/qq2G95xWNmHQ4Jr6JCoGJnBqmTCh3XPH0NJ18HKp8IVaFgbhro4Y+J26UqGzcR6M=
Received: from DB8PR09CA0009.eurprd09.prod.outlook.com (2603:10a6:10:a0::22)
 by AS2PR10MB7901.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:64e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 07:04:57 +0000
Received: from DU2PEPF0001E9C5.eurprd03.prod.outlook.com
 (2603:10a6:10:a0:cafe::e) by DB8PR09CA0009.outlook.office365.com
 (2603:10a6:10:a0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Thu,
 4 Sep 2025 07:04:57 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.43)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.43 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.43; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.43) by
 DU2PEPF0001E9C5.mail.protection.outlook.com (10.167.8.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 07:04:57 +0000
Received: from SHFDAG1NODE3.st.com (10.75.129.71) by smtpO365.st.com
 (10.250.44.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 4 Sep
 2025 09:02:39 +0200
Received: from [10.48.87.178] (10.48.87.178) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 4 Sep
 2025 09:04:56 +0200
Message-ID: <1840e425-246b-4d4a-8ab1-5ba21acd57e1@foss.st.com>
Date: Thu, 4 Sep 2025 09:04:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] video: stm32: ltdc: properly search the first
 available panel
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, Tom Rini
 <trini@konsulko.com>, Kamil Lulko <kamil.lulko@gmail.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Dillon Min <dillon.minfei@gmail.com>,
 "Patrick Delaunay" <patrick.delaunay@foss.st.com>, Anatolij Gustschin
 <ag.dev.uboot@gmail.com>, Simon Glass <sjg@chromium.org>, Sumit Garg
 <sumit.garg@kernel.org>, Philippe Cornu <philippe.cornu@foss.st.com>
CC: <u-boot@lists.denx.de>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20250903-master-v2-0-5cdf73bff42c@foss.st.com>
 <20250903-master-v2-5-5cdf73bff42c@foss.st.com>
Content-Language: en-US
From: Yannick FERTRE <yannick.fertre@foss.st.com>
In-Reply-To: <20250903-master-v2-5-5cdf73bff42c@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.178]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C5:EE_|AS2PR10MB7901:EE_
X-MS-Office365-Filtering-Correlation-Id: 84c9c75c-9396-4b27-5c77-08ddeb815b92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VGQzbEM0YWVuUnNVSlF3WVV2N0I0aVRzSlB6aDBjemx2MTdEK0ZWajQvUGFD?=
 =?utf-8?B?Z2lzdDlPL1F2aWxHc3Y4bG9NeDdhVGF2RjBnNTBCbzZEY3hEb3VGTnBraVg5?=
 =?utf-8?B?eUdtbkRCcTUrc1hjaTBOTTZweFg4Z2poTEl5VFAzNCs0d2ZCUUhDL3I5ZFBi?=
 =?utf-8?B?Z25DRVV0Q3FsM05RUkxVbDdFaE9oQmwzczRxeER1a2VZQVUxeEVySXhWcEV3?=
 =?utf-8?B?SE9QaFdTUHZaYXRrTGVKc3Rlck1YYmM0SlJEOEQxelhBaG4wR0lnK0ZySXNG?=
 =?utf-8?B?WTh1WlVTRWtzWWZDRG9VSjFiOEhEbStZWXk0eUVVOU9oRGRBbEIrYnlKN05H?=
 =?utf-8?B?TVgyOWN0andPYmdDK3hvVjBCSjMwQXNyT3dpWjF6NjREM3ZaWDVJZTFycDZH?=
 =?utf-8?B?TnJEV0swdjh6WTUzRDlZdVRDU1ExUjhzbEcrd3NQNTNUMVV0N2FoakhCQSsy?=
 =?utf-8?B?RkIyVnhWQlA1d0NyKzJvN2wvWU5ZZjRIbkU4SnBCRmJRQWFUeEVHSEViekxn?=
 =?utf-8?B?cUdPc2lIcVBWSnQ0OStLT0JhWlNxMWZkcUxZcUVLSWpVZmVRQ0l3cWlRMUlu?=
 =?utf-8?B?cTY3ckRzS2txZTllb3FGVUhDbllJaytpYlZOdzJDb0xwaXZJRGxmT1RnUjhX?=
 =?utf-8?B?NVk2aGJXWnhNTlJJdkVVT21pVnU4bmdSMWZKRmMwc0VjVjFrZmtiZGdOTEo2?=
 =?utf-8?B?bjdFT1cyS214VUFycmFaMHd3N0lsa21XbWVENGtqOVBENVE2cEFtR0ZTZzJF?=
 =?utf-8?B?Y1JPMUQzbFh2bGw1WVNibGtQTzdoVEFYQkxmQThMTXQzdXMzdDEwbFlqeWZI?=
 =?utf-8?B?L08zTlQvS216VlJOVW90MDRsdno0T2ZVVkVLVXR3ZGFvOEtTMUZWeWpPb1FF?=
 =?utf-8?B?VEhVMFBPYmJnY3N0UjFvOWVkYzdxYjNRaEpBeXZiRjBoVnROWEdEVysySnBT?=
 =?utf-8?B?aHhsMzJFRlJmWFpuWEJxSmJaTFBDS2tDK3JXdVpjT3NmTjd5MFVHRG9RVlA0?=
 =?utf-8?B?b0RQRzQ1TXZBVDNnZkJiWW1ZeGo5c2JTaWo0dVl2UEs0cVdlVWs5SkpUWm10?=
 =?utf-8?B?VXM3WUdENENyaU53TkFGY0JXK0xWaEh0bCtLSTg1TDBXTml6ZG9OZVA2VE5y?=
 =?utf-8?B?NXEydDY2NWIxdVNCS1drMURkakhvcW5SQ0Y1TDc4RU5oL1ZML2lSVkRtT0o0?=
 =?utf-8?B?aythOGY2WXdjN3lqMjlYeVZDQ0ljV1ZjYU1GL21JK2JGQXNSYkxuVHZmYlcz?=
 =?utf-8?B?L2t5clpGTWFDQXBMaXd1QkpxbHRuckR2MmI2YnRVMlFwNXZyekQwME1kZEpa?=
 =?utf-8?B?U2JCZlVkSExweFRKQTVITWhuRkYyV0Y1S01rVUplVFVhaldabmprR3NoNyth?=
 =?utf-8?B?ZDdSYkRlaG0wTVdicWxCby95aDRuVVA1WkxGTmJOY25tZi83YVdEbmUrbUFl?=
 =?utf-8?B?eVUxbG1UT3UrV2x0OVZJVlFUL3RjekZJTldIb1Z0Z1BzcGdST1RoaWp2bktz?=
 =?utf-8?B?a0lvMnJOOGlTZ3U5akxVZjB0UXB3TlRHRENUZnVIQU5sSndxbnpFQjlTL3Rk?=
 =?utf-8?B?SHFRSVo4ZTEvbUdES0NRa29JOWg3SlBhaHJEVGxlZWVTUHZEb2c5T3M2dTBO?=
 =?utf-8?B?WlQ2K1JjRkIvYWF5eWt6Z05GZEdKblFOdGJJMkpzaEVpKzByZGhjVUwzdzRL?=
 =?utf-8?B?Tk9pMHBHaXlDODJEcGFtM2VERXBpeis3cEptMGhqRXFUSW9NRlZoVkt3R3Vv?=
 =?utf-8?B?aFRjK0x5dmJSOVRxWjJ1TmtIbStZMll3aUN2M0NiNHlKQm5PeTNBZXpqU0JZ?=
 =?utf-8?B?Szd2ZFZXSVFodFdLdzk0VURkSHF1WEJaYUtLUnJmWGlJVnFzTmVkYzVZSllp?=
 =?utf-8?B?dVB2c0poK1YwSW5weHdUZUorWE1FT1hwdjZkTjlxMTA5S2pWRmoveE1pSmdt?=
 =?utf-8?B?dWhjT0ZIbjk2eTljUXFzdUdIUDFBcGZYVGx2SzVBZUl3dXRXK1RWNmhYOFBo?=
 =?utf-8?B?RmJlb2dUUlNFRWdNdm82THVLQVdZR1RoTXZxRXNoNS81WlRBL0ZZRnJDSkRu?=
 =?utf-8?B?RlFkY1RFSUFVaTg3ajAzSkt4dmZRTUhFVGJFQT09?=
X-Forefront-Antispam-Report: CIP:164.130.1.43; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(921020); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 07:04:57.4819 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c9c75c-9396-4b27-5c77-08ddeb815b92
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.43];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF0001E9C5.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7901
X-Authority-Analysis: v=2.4 cv=XYCJzJ55 c=1 sm=1 tr=0 ts=68b93a1e cx=c_pps
 a=/QKJ0YTy9Ntnlhio84ImkA==:117 a=peP7VJn1Wk7OJvVWh4ABVQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=P2A4Zi-lJHsA:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=FUbXzq8tPBIA:10 a=8b9GpE9nAAAA:8
 a=941mOKHnnHugEBzshyIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-ORIG-GUID: oGpklpP9foZSPRnAbxrXFsSY7LwqBwww
X-Proofpoint-GUID: oGpklpP9foZSPRnAbxrXFsSY7LwqBwww
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMiBTYWx0ZWRfX0ZDJcx7ZEl9r
 tDbUYy8Ge8uBOCDGqGBK1GmZD995WVLBSENnBln9J2Qt3JhxOaCS9Xrd6/VXOGggLENF/k3TzOY
 YtQiTV5X4Wx2tfbepJjn0i2a156fB5PN7X/DKMdjTZikxeG4G8SOWA6xBymCUJ+a8k6xaCL6Tr7
 lKGbfuWsm6jWEcWLM7UxYItSglSsSE80dC0BgBs3WRe0rXuwfZ/j9zh0ikjK2tX5yXSZVWY9HbX
 0SgftE9LI/ypAx1ACVf0ae+bOOzsp7g1quiM1EjPf6YQ4RIgs6ZEomzTEqXVIbghC+VflXGq4Uc
 X3/zXmUhiw/V6HRMcWBnP+dNRfkF7AE+JNBKqZfaTeK16WtPg6z4gcgBeyJxmJoSKuDGbcKouxK
 h7e+8C8C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 phishscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 clxscore=1011
 impostorscore=0 adultscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300002
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

Hi Raphael,

Thanks for the patch.

Acked-by: Yannick Fertre<yannick.fertre@foss.st.com>

Le 03/09/2025 à 14:25, Raphael Gallais-Pou a écrit :
> Initially there was only one DSI bridge with one panel attached to this
> device. This explained the call to uclass_first_device_err(UCLASS_PANEL,
> ...) which worked fine at the time.
>
> Now that multiple bridges and panels, with different technologies, can
> be plugged onto the board this way to get the panel device is outdated.
>
> The lookup is done is two steps. First we circle through the
> UCLASS_VIDEO_BRIDGE, and once we get one, we search through its
> endpoints until we get a UCLASS_PANEL device available.
>
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> ---
>   drivers/video/stm32/stm32_ltdc.c | 136 +++++++++++++++++++++++++++++++++++----
>   1 file changed, 125 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/video/stm32/stm32_ltdc.c b/drivers/video/stm32/stm32_ltdc.c
> index efe9a00996eca0301d2a2b82074ba9690a967a73..834bfb625d2d34a44bd8edff1c92af6dec344c20 100644
> --- a/drivers/video/stm32/stm32_ltdc.c
> +++ b/drivers/video/stm32/stm32_ltdc.c
> @@ -17,6 +17,7 @@
>   #include <video_bridge.h>
>   #include <asm/io.h>
>   #include <dm/device-internal.h>
> +#include <dm/uclass-internal.h>
>   #include <dm/device_compat.h>
>   #include <linux/bitops.h>
>   #include <linux/printk.h>
> @@ -495,6 +496,101 @@ static void stm32_ltdc_set_layer1(struct stm32_ltdc_priv *priv, ulong fb_addr)
>   	setbits_le32(priv->regs + LTDC_L1CR, LXCR_LEN);
>   }
>   
> +static int stm32_ltdc_get_remote_device(struct udevice *dev, ofnode ep_node,
> +					enum uclass_id id, struct udevice **remote_dev)
> +{
> +	u32 remote_phandle;
> +	ofnode remote;
> +	int ret = 0;
> +
> +	ret = ofnode_read_u32(ep_node, "remote-endpoint", &remote_phandle);
> +	if (ret) {
> +		dev_err(dev, "%s(%s): Could not find remote-endpoint property\n",
> +			__func__, dev_read_name(dev));
> +		return ret;
> +	}
> +
> +	remote = ofnode_get_by_phandle(remote_phandle);
> +	if (!ofnode_valid(remote))
> +		return -EINVAL;
> +
> +	while (ofnode_valid(remote)) {
> +		remote = ofnode_get_parent(remote);
> +		if (!ofnode_valid(remote)) {
> +			dev_dbg(dev, "%s(%s): no uclass_id %d for remote-endpoint\n",
> +				__func__, dev_read_name(dev), id);
> +			continue;
> +		}
> +
> +		ret = uclass_find_device_by_ofnode(id, remote, remote_dev);
> +		if (*remote_dev && !ret) {
> +			ret = uclass_get_device_by_ofnode(id, remote, remote_dev);
> +			if (ret)
> +				dev_dbg(dev, "%s(%s): failed to get remote device %s\n",
> +					__func__, dev_read_name(dev), dev_read_name(*remote_dev));
> +			break;
> +		}
> +	};
> +
> +	return ret;
> +}
> +
> +static int stm32_ltdc_get_panel(struct udevice *dev, struct udevice **panel)
> +{
> +	ofnode ep_node, node, ports;
> +	int ret = 0;
> +
> +	if (!dev)
> +		return -EINVAL;
> +
> +	ports = ofnode_find_subnode(dev_ofnode(dev), "ports");
> +	if (!ofnode_valid(ports)) {
> +		dev_err(dev, "Remote bridge subnode\n");
> +		return ret;
> +	}
> +
> +	for (node = ofnode_first_subnode(ports);
> +	     ofnode_valid(node);
> +	     node = dev_read_next_subnode(node)) {
> +		ep_node = ofnode_first_subnode(node);
> +		if (!ofnode_valid(ep_node))
> +			continue;
> +
> +		ret = stm32_ltdc_get_remote_device(dev, ep_node, UCLASS_PANEL, panel);
> +	}
> +
> +	/* Sanity check, we can get out of the loop without having a clean ofnode */
> +	if (!(*panel))
> +		ret = -EINVAL;
> +	else
> +		if (!ofnode_valid(dev_ofnode(*panel)))
> +			ret = -EINVAL;
> +
> +	return ret;
> +}
> +
> +static int stm32_ltdc_display_init(struct udevice *dev, ofnode *ep_node,
> +				   struct udevice **panel, struct udevice **bridge)
> +{
> +	int ret;
> +
> +	if (*panel)
> +		return -EINVAL;
> +
> +	if (IS_ENABLED(CONFIG_VIDEO_BRIDGE)) {
> +		ret = stm32_ltdc_get_remote_device(dev, *ep_node, UCLASS_VIDEO_BRIDGE, bridge);
> +		if (ret)
> +			return ret;
> +
> +		ret = stm32_ltdc_get_panel(*bridge, panel);
> +	} else {
> +		/* no bridge, search a panel from display controller node */
> +		ret = stm32_ltdc_get_remote_device(dev, *ep_node, UCLASS_PANEL, panel);
> +	}
> +
> +	return ret;
> +}
> +
>   #if IS_ENABLED(CONFIG_TARGET_STM32F469_DISCOVERY)
>   static int stm32_ltdc_alloc_fb(struct udevice *dev)
>   {
> @@ -532,6 +628,7 @@ static int stm32_ltdc_probe(struct udevice *dev)
>   	struct display_timing timings;
>   	struct clk pclk, bclk;
>   	struct reset_ctl rst;
> +	ofnode node, port;
>   	ulong rate;
>   	int ret;
>   
> @@ -568,7 +665,7 @@ static int stm32_ltdc_probe(struct udevice *dev)
>   	}
>   
>   	priv->hw_version = readl(priv->regs + LTDC_IDR);
> -	debug("%s: LTDC hardware 0x%x\n", __func__, priv->hw_version);
> +	dev_dbg(dev, "%s: LTDC hardware 0x%x\n", __func__, priv->hw_version);
>   
>   	switch (priv->hw_version) {
>   	case HWVER_10200:
> @@ -589,13 +686,35 @@ static int stm32_ltdc_probe(struct udevice *dev)
>   		return -ENODEV;
>   	}
>   
> -	ret = uclass_first_device_err(UCLASS_PANEL, &panel);
> -	if (ret) {
> -		if (ret != -ENODEV)
> -			dev_err(dev, "panel device error %d\n", ret);
> -		return ret;
> +	/*
> +	 * Try all the ports until one working.
> +	 *
> +	 * This is done in two times. First is checks for the
> +	 * UCLASS_VIDEO_BRIDGE available, and then for this bridge
> +	 * it scans for a UCLASS_PANEL.
> +	 */
> +
> +	port = dev_read_subnode(dev, "port");
> +	if (!ofnode_valid(port)) {
> +		dev_err(dev, "%s(%s): 'port' subnode not found\n",
> +			__func__, dev_read_name(dev));
> +		return -EINVAL;
>   	}
>   
> +	for (node = ofnode_first_subnode(port);
> +	     ofnode_valid(node);
> +	     node = dev_read_next_subnode(node)) {
> +		ret = stm32_ltdc_display_init(dev, &node, &panel, &bridge);
> +		if (ret)
> +			dev_dbg(dev, "Device failed ret=%d\n", ret);
> +		else
> +			break;
> +	}
> +
> +	/* Sanity check */
> +	if (ret)
> +		return ret;
> +
>   	ret = panel_get_display_timing(panel, &timings);
>   	if (ret) {
>   		ret = ofnode_decode_display_timing(dev_ofnode(panel),
> @@ -624,11 +743,6 @@ static int stm32_ltdc_probe(struct udevice *dev)
>   	reset_deassert(&rst);
>   
>   	if (IS_ENABLED(CONFIG_VIDEO_BRIDGE)) {
> -		ret = uclass_get_device(UCLASS_VIDEO_BRIDGE, 0, &bridge);
> -		if (ret)
> -			dev_dbg(dev,
> -				"No video bridge, or no backlight on bridge\n");
> -
>   		if (bridge) {
>   			ret = video_bridge_attach(bridge);
>   			if (ret) {
>
