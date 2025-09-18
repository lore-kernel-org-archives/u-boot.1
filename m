Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E21D6CAC59A
	for <u-boot@archiver.kernel.org>; Thu, 18 Sep 2025 15:20:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 571A481E13;
	Thu, 18 Sep 2025 17:20:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="MInRrm2c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB45882C84; Thu, 18 Sep 2025 17:19:59 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E8DB80B9B
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 17:19:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=1356912f3f=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IFCtan013063;
 Thu, 18 Sep 2025 17:19:53 +0200
Received: from osppr02cu001.outbound.protection.outlook.com
 (mail-norwayeastazon11013053.outbound.protection.outlook.com [40.107.159.53])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 497fxhsbqy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 17:19:53 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G0mUMGvUpSwiguI872SU5TmOW4V0wyMZaRmWn3vDBluJMObdihResi6Zrc4Xd1aP6qTi/57o7x1EHD5Dx38YcVhL3XmD9oNYgF/Vpwrx4TXq99G1cP1YfX7pGPBEK6vp+vrM+62uEYujhkCAjGWicKG1qkEseVMH3uLJaCmIx/jZHuu9Bat9isApcD9rZx8ufglNoDnmb66BBCydBFqioi5LkNtqudKU18pUCRkOlq4T1Wr+IzgNAoYwyl71mTbcZARnUPphpAP+r+pazhDAunJcmL3zv10rKPyYfMFfKQN04nMiyLVcFfrcVkHj45zgZF4fvdJt3oust9qeKu4gtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6m54GtE65Y5FZent9c/ojr9t4XNawb/0Yp1JB2/T2g=;
 b=C1mgOTTkG8o4tLKXqnVqCyef9VlJXnmnNMvDC6RWelRFcGKxBDr0PqcLuNk1+5gBMWglHpWDoCKl6AYTbK1zLv4P/te4hcCAZATflevxEHYlwybalF+jyWyt4GP8nwE3yk66u7xFb5aW10UDsLWpGm/YqkxZtJM1brzgP8uuzcuCy6KEs/pNhLncvn29ijthJpHY4oQNJ2U1KrzIkLA4ZXHFGiPfC4vCakd+MJ7QgFC+IV6vuZ680d8+JSU2U0NJjcm9F9Eb+Pn/93F3iLRaBjPjR3E0FUDk5CyPllJbaENoRXyiUOdaEgustT5XXew69A2elJquM8LzDcNRCTHifQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.43) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6m54GtE65Y5FZent9c/ojr9t4XNawb/0Yp1JB2/T2g=;
 b=MInRrm2c46yJc5Xbp9tcZ0DikpeX93TrPQmzMqN8efSVmgokJMAZ6AolBnoRhLJethlbBL6CsKtkAIFCgr7RocQT2rR2RhZqPpeLqSJ7lUjIGFCzQpziZcDcenePCSR4SUnAQGxyMT590MsRSOe/HJEe8oeQ/ArmiKJLNrs70R36yKbUAnCVO4y3ruRZ0RE9Y9NctUuiCEfnJBg+4Q3V89sO1eHSbmuFDEYkvSYOg5t82mZQYWdvZIK6UbZ/M6hDECD5rwco43SWtzxVNmhaNoXr4kdTiKA/WPyutMSBmK2yhzQcgvNs+RbHnhfZX2fDNEkoN05WvGq0lTrJsNaSBg==
Received: from AS9PR05CA0106.eurprd05.prod.outlook.com (2603:10a6:20b:498::21)
 by DU0PR10MB9197.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:5dd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 15:19:48 +0000
Received: from AM4PEPF00027A68.eurprd04.prod.outlook.com
 (2603:10a6:20b:498:cafe::58) by AS9PR05CA0106.outlook.office365.com
 (2603:10a6:20b:498::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 15:19:48 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.43)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.43 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.43; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.43) by
 AM4PEPF00027A68.mail.protection.outlook.com (10.167.16.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 15:19:48 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 18 Sep
 2025 17:17:22 +0200
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 18 Sep
 2025 17:19:46 +0200
Message-ID: <8583ab5d-e475-4583-9f2d-241a3d7cc146@foss.st.com>
Date: Thu, 18 Sep 2025 17:19:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ARM: stm32mp: replace RIFSC check access APIs
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>, Gabriel Fernandez
 <gabriel.fernandez@foss.st.com>, Lukasz Majewski <lukma@denx.de>, "Sean
 Anderson" <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Valentin Caron <valentin.caron@foss.st.com>
References: <20250808140358.53164-1-patrice.chotard@foss.st.com>
 <20250808140358.53164-3-patrice.chotard@foss.st.com>
 <c5463f88-f9d6-4e0e-8269-4103be858bbe@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <c5463f88-f9d6-4e0e-8269-4103be858bbe@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A68:EE_|DU0PR10MB9197:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e720782-f966-4f1e-11a4-08ddf6c6ce57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UmY2N1JhS2pidk0vTmV2K2FGUWR2aFNnaXNwMTJpMHJTckIyYmxqTzdIRVVR?=
 =?utf-8?B?K1BXOGRsZjNDem40MmlhWk9qMnltaTFjWkNyVXhURVdPdWNsZG5WTndFU2t5?=
 =?utf-8?B?STJsZnBBbEs5SlVlbEUwSkp6alllRTFXU3FFSFVodVFsYVJvK0VYL1dHRmcw?=
 =?utf-8?B?OTduSHZLYUplbTNPaVAyYi9oUDA0U1Y2aklkSjdYSVpaNWdOODBLZG5VVUF5?=
 =?utf-8?B?NW5uK0c3S0F4blFYL3pDWXZYQmxSSmRvMnU4eE5xS0ZSL0l4QjFqWUdOdmZH?=
 =?utf-8?B?TTFUanowRGpWRDgzYmozTk1UUnNlN1ZiNk5meTJXdk1KRXAvdjVOcDNxS29E?=
 =?utf-8?B?ZTUvazNCRFh3Y3pFTDRnRStxVmJML3JBZE9uVGFKeFlhUzFtajFac05uK3lv?=
 =?utf-8?B?cGtIblJhZndxTGprQWcwNnNSR2NUL1NzMnJ3VFhZVkxMNFlFQ29MNS9kU2JM?=
 =?utf-8?B?YnVpWCtHVHdzUmE3cWVZTmVRTmtLSi93VVZuZmZ5Q1lsUUhtSThJeGRBTjEx?=
 =?utf-8?B?Q2RxK29EWWdhckQxK2RoK25GNGR6WVh0b3MrbzBDSXdiOVQ1VEh0Mzh4Z1Y0?=
 =?utf-8?B?d0JZNWE2TDREeU1EU0xDWFVlUEdnR21YQTRzRVRJY1lIcjIyeTdDb1MyOWxD?=
 =?utf-8?B?OEhmclova2k0enNreldtYWN0VDNUQWZjVnFMeEhpQmhzMldmWWRXQnY3VlFj?=
 =?utf-8?B?bWVydHh4ekNUUWFxN0ZEYk8yRU5FaTVBMEw4WHVqcEUxcTl0L1JGSzB6Q0J1?=
 =?utf-8?B?OTlFOENUNEtHUlVaVjZsR0NWK1EzRTNBbVJVUStMTnpvNXdtZk1UNFZXekk3?=
 =?utf-8?B?TTAxV0lyYWdHem4zVHhTYkx3NXNNa0lXWWkxTVBmUWhWbFVGMUZyeUdLRUVl?=
 =?utf-8?B?bklwV1JjeFp6YlF3T21xMVIyVlRlZFZHalBBNjJkQVlXeE9LUkdMOHIyb2pz?=
 =?utf-8?B?Z09vUjBvZ3R3QTczeUFKR3NSWlp2WHVoNW1Balc3MEQrclh1azcwcHRoN1lz?=
 =?utf-8?B?S29FVk94L0pXc3g0dDc2aGJITlRRV2x0K2xUcE5rQS9pSVFhcTIvbzJUSnZq?=
 =?utf-8?B?MXFpMExpNnlLUFpWWXFnU0pOdXdCMzViaXNLcWh3elgwN3QwdlJkVDdQKzNP?=
 =?utf-8?B?TlcwN3R5MXpKYllnQVpCR2tYSThmRzhZY0tPQUxrWG9qQUJkVVBuSEZudjdz?=
 =?utf-8?B?K3lxRHh3U0pHSnZpWklPZHh0bGcyWkxBemtnN3MyeWlBcmxTVXZobWFBWTli?=
 =?utf-8?B?NjV3T1VDME1pREhnTVo4VTlhRUpHbE1DR3ZVc1hObVk1cWJBbWtvWG5oMHly?=
 =?utf-8?B?akVOOW9mM1h1cU1uZVRwMzB4YlE1S3kzWkhndmY5NjNFdVR2Y2VKSldOd2ty?=
 =?utf-8?B?eEZGZzRmSHN5bHkyR0RqemhUUE1TZWk2UWZ0VjlrRVZFczl3S0VzUUtQMGFD?=
 =?utf-8?B?Y3V3TzdkWG9ZM1VnVTMwMkx3Mzc5ZnFtMmxCRXFuRnorNjZubFZSSGUwN05H?=
 =?utf-8?B?bEQyZHdEV25IbWVoaFJ4RkQ4bWdIUHhQbXh5QktDWndHK2VWbDRWV1FkWVE5?=
 =?utf-8?B?QVVsN3IzY0lBZTNaZWlrN2V5V3hhYnpOUVZ5Vy9QYXdtRDNSVE1QeXhta0pG?=
 =?utf-8?B?S3FzZ3lUZHBrNXFFaXF0Z0VobDJjYi9tRFB3Uk1ucWQ4L2Vrd2xzYXMzR0pM?=
 =?utf-8?B?alNOTW5QS0toLzBwbm1hUUEzZDY1K0xDZUpxellvTXR6L0k5U0FtZEphcThV?=
 =?utf-8?B?akVoTXNrN0ZaeTFqRjNVNmRTRnFib0hIakQvbzJsditLejBSQmhKd2ZVMURJ?=
 =?utf-8?B?VE9UVThXK2pLQWNOZ2RnNkIrblIyRkxDcnJ2RFMwcEJ1RlNTVHFYdVEyWmxS?=
 =?utf-8?B?Qm9oc2MyckgyYVByelJ4RE9od3h3Z2Y0YUwxWG8vZm8xSWtqdm10TEFReFQr?=
 =?utf-8?B?Q1RVdEY2VndxWGtWS1pmL2dQYy9vcGlhdHQ5Q3NqNXJrRjlkZGZjK2xmTk1k?=
 =?utf-8?B?YXZ6N2RRTDQ5YUFVdlk2dHZFT1VEYVl3NVNRZTJZSiswQUkrREhDbTB0aVlV?=
 =?utf-8?Q?CkdCG0?=
X-Forefront-Antispam-Report: CIP:164.130.1.43; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 15:19:48.1348 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e720782-f966-4f1e-11a4-08ddf6c6ce57
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.43];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A68.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB9197
X-Authority-Analysis: v=2.4 cv=K9MiHzWI c=1 sm=1 tr=0 ts=68cc2319 cx=c_pps
 a=Jxp8n3EFNm5LyZPFAI9SQw==:117 a=peP7VJn1Wk7OJvVWh4ABVQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=SAHXIHsbQyQA:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10 a=8b9GpE9nAAAA:8
 a=_5l3EBtgrz4pxzfvpMMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX4DHwyuf8+U6g
 ucUr2QGtWABB/Swu4OyAD7YMIuvmxtdxch8RMUG9il9MRjgjnGWzwhb6oKJ5KChq/MnC0Onfwp3
 4z7/6f5uPSVR4MKZuvygIfuaXcpRAnebvLDduUoxb6ffQgZZGE9CeJS7OVQ7PfPTdHR8KLeRmNY
 IfY15L7/HqaE1YSYvCRwC3DdGQXoAi36Lwt+ov7Mvji70gcWmwLfBLm7sFhE3Qpv0k/gU9EysPj
 kmXVYMMPAzrYv4UFvocLUoFQNOu7/1XdxHKa9h8Sr8OE0ARRZr/VnAuDcFKGnf4Xv76Z3fWXvPa
 TzwOgaJyqnsD1nlH8yQae87XPQhKgHMJvESk93R7sycIa1P2I9Fj1fNV+EPw+kTlvM2McViWgoW
 3y1gE1+n
X-Proofpoint-ORIG-GUID: ESutgED7DMe2EHvtXJIkoIonnmdXRHct
X-Proofpoint-GUID: ESutgED7DMe2EHvtXJIkoIonnmdXRHct
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 clxscore=1011 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202
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



On 9/10/25 17:55, Patrick DELAUNAY wrote:
> Hi,
> 
> On 8/8/25 16:03, Patrice Chotard wrote:
>> From: Gatien Chevallier <gatien.chevallier@foss.st.com>
>>
>> Replace RIFSC check access APIs by grant/release access ones that handle
>> the RIF semaphores.
>>
>> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
> 
> 
> minor on comit message: unnecessary line between signed-off
> 

Will be fixed when applying patch.



> 
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   arch/arm/mach-stm32mp/include/mach/rif.h |  48 +++++++--
>>   arch/arm/mach-stm32mp/stm32mp2/rifsc.c   | 127 +++++++++++++----------
>>   drivers/clk/stm32/clk-stm32mp25.c        |   2 +-
>>   3 files changed, 116 insertions(+), 61 deletions(-)
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> 
> Thanks
> Patrick
> 
> 
> 

Applied to u-boot-stm32/next

Thanks
Patrice
