Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 024F4C43327
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 15:26:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DD21846A4;
	Thu,  2 Jul 2026 17:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="f5W50MSg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C720F849AC; Thu,  2 Jul 2026 17:26:09 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 881F4841F2
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 17:26:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=maAywIfwmKGbbxAipgj4c6/IgKGpW9EVDUucgaugWTzTefi40t8UXxXnMaFwSJqdO7cOWBV15x9bJ3+6KBQ1U8T1qHggSAZJOu/j1sLbmuwitFhZtJxLivTHu/tyjXrulir4BDRihsuPDwCN0r3G41kjtH14J6wxMVv7E/8+dRkcY2HFLY2SAEVPZ/ymVwa2RHcpYWWedb+hFv4oxFKrFFbctAQ1pawwxHV4VR7fEkucY0/oE9TqEHylHt41drdyrhRDAnhThYj0bwZQ2GIeIirb7imrvKZVuIPuinDje6+xz2bwvGDrDFxEVa62NOEGa50xctAT2V7XIOjnvxhUtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=riEb5iD/qwNqa5W6OMhbCf3LC1jcaw43yZYEjLTbofI=;
 b=aUT51fYzIJK5QOyd4VbeUu0raguBF7Pk+tiEG4caLKPyv+TYT/qYvUYA7t+9sOfrVFVnqYrZAr4o3SL1BwS9YLMF5ErPB3SbeHom9RmnBS4+ZcTU0OOHpeHq5l5G9nlXO61J/oy0I0Y2Kemd6ofPwno5Z18C2o3SZinmLlT1OviDl4PdkFJOt5izUPSr/OjIehR7DmE+J1jlCz3lukaXkKSk8btSAhDBzig8WZMASu1tx4jr9l0KsKHRa4jE4haVU6FLfqlm2idocYcRYetuHFt2BuUgfYuwGcrlH87APNNStWLeh52oZAiuVe13q6mfRxP9Htb+KqR3fW2UKxUARA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=mailbox.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=riEb5iD/qwNqa5W6OMhbCf3LC1jcaw43yZYEjLTbofI=;
 b=f5W50MSg0H+EfadYYzHkyJRsx9BDE7Wr05dR42rt59O/J//2QUunNQDZHh39pCQnmq+IGcbzM+BRSfxuRV523XB2wVKNLKguiXm32q61qkiL1GDpXvqi20XmkDimn+xMyOkwQn6LMipohgpJpoGYdMMcRke8Z5MVoRf7AbmlfKZiSTqIZXBOYIVHqUkEq7qqEMdu3N95jbM1zpgOFrZlNpuZ3Q2NM04GzUpJpO9HKQO6V5g077wxRRpDxQHZhy1GYAQl598eq+2dpUg18itJzITKRyMwf2HJpB5AJgmp2OnURd5j5CXE8LWMCpJwmdD+4ln2W4A+3v2j5TCNgQTBkg==
Received: from AM9P250CA0010.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:21c::15)
 by PRAPR10MB5251.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:291::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 15:26:03 +0000
Received: from AM3PEPF00009BA1.eurprd04.prod.outlook.com
 (2603:10a6:20b:21c:cafe::49) by AM9P250CA0010.outlook.office365.com
 (2603:10a6:20b:21c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Thu, 2
 Jul 2026 15:26:03 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM3PEPF00009BA1.mail.protection.outlook.com (10.167.16.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 2 Jul 2026 15:26:03 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Thu, 2 Jul
 2026 17:30:49 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Thu, 2 Jul
 2026 17:26:03 +0200
Message-ID: <b1625c53-4780-4b67-94f1-9f0d61c0ab8b@foss.st.com>
Date: Thu, 2 Jul 2026 17:26:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: gadget: f_mass_storage: Move schedule() in
 sleep_thread()
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
To: Marek Vasut <marek.vasut@mailbox.org>, <u-boot@lists.denx.de>
CC: Lukasz Majewski <lukma@denx.de>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Tom Rini <trini@konsulko.com>, Simon Glass
 <sjg@chromium.org>
References: <20260625-move_schedule-v2-1-2e4abf0c5425@foss.st.com>
 <750d6e53-d48b-4791-8544-6d5edf7a895d@mailbox.org>
 <d239690c-4503-4c60-90ce-478394aed4c0@foss.st.com>
 <2051a113-6091-4ece-bf1d-affb2797374a@mailbox.org>
 <4db136c5-aa08-4506-99ac-bbfe0c7963d8@foss.st.com>
 <1d7dec66-5da1-4555-8514-ef89de5491e0@mailbox.org>
 <26a24fc7-98f3-4126-b565-aab28f722463@foss.st.com>
Content-Language: en-US
In-Reply-To: <26a24fc7-98f3-4126-b565-aab28f722463@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA1:EE_|PRAPR10MB5251:EE_
X-MS-Office365-Filtering-Correlation-Id: 29478e64-ebb7-4002-8b48-08ded84e3ad0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|13003099007|5023799004|18002099003|4143699003|22082099003|11063799006|56012099006|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info: 6ijc88dZ7YJDJebEEW6RDLSfxHjXRxDn4AxOLqLCo9EuTFjSjBGIFLpKlGmUQ/mYL/hstY06Qb//4Evs5z5MUYlhp4ZxjP50iqiD2kAKE20HDOFDexEl6V3duX1ALNkjYouMstNzAtUvAP8guN53oVtH8fmMGy6e1rUtOOBZPhjPgzGlDVLy2sOe6XJgPwyebKlya6Qvt8ZMushw10eVkpEXIUJUnh1uVFtLIaQFGz/6fgKojBTl+xtxzGTLtXpI5FXyqa97F0KoShkliP5hOysET2nyd29rjgdsJz33fkHW+30l3/ZzDXYNPo16hb8lXy5j7k0nMN/2978iEbt361uDFRAEp5hGYkKrsQw1ZQeQs9+m80H7P2x9U4tkhJCoCzLc3In0uF0iZNn+XS2vDgShNG86d96OjtwNXbZddTBL6czOV85VxItb1Z+HKFHtKakhiFexOle1i9oes25nDHnV/yuPNgX+jLWZxt7m8REJ0ORvYZcKyy2EvyND47JtZ0C0fAJw0VNQOv+dTBz6OQB3Is2uoyEiz0bohY28CmkGVli4Ot8K7qlsHr9aLWzhxMHzMxrzJSAFAmFwTHH+CCP2U08Tj/P6EL4VYutBPXB8LtufuORiroNNWGvwJIqBL/d/COGoeKjpDemg53eUNzJ3xLTR7pCX3dc4rvx3VgSi8/A/FQm9nwNMbhd5lHHtINqizbGg1ztTEsrjKDCnzQ==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(13003099007)(5023799004)(18002099003)(4143699003)(22082099003)(11063799006)(56012099006)(3023799007)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qfMx+PSRZnCFljb410roMiC1hrz2FKa39p67a5XqVvnBcjs0UxcKbwYvBLJ6j0sn9CRmt9LpgmyvUGucqb9YKX+pRVDMcx1mUN1M28DfeqptAInPSoYyE7gB6qZUeFlrUqe7rg/FQRxLmiYz2phhvc6g0bQ4knfp3i1SGZxgy7C/fHDk3K/aF6OiQk97BcSUyud3kjgkUTUDokkhMeuBMjDiQG5T63hKbAABzNZr6tJAR2ruPF2JunJps6mqbUdkTz2t+zgv+Nt6aVc+FPnKBISaM0B0LaqTAlDubDnIGl9zeUah61kBH0sOoCON8koplRsMidZFVw1J0dJV0mKkLP3tOaCxw/Ac7IQWx1tdlqkyLzjl1xcxQRBME6EDQHo/gN6VPPqNN/6uB6PbrFGkckSGg8qGkDSO3neubLoRADKAABqa7IsOFmyi4W1qMumS
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 15:26:03.8084 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29478e64-ebb7-4002-8b48-08ded84e3ad0
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009BA1.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5251
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



On 7/2/26 16:32, Patrice CHOTARD wrote:
> 
> 
> On 7/1/26 09:24, Marek Vasut wrote:
>> On 7/1/26 8:27 AM, Patrice CHOTARD wrote:
>>
>> Hello Patrice,
>>
>>>> What takes 700ms in sleep_thread() , surely not schedule() ?
>>>
>>> Hi Marek
>>>
>>> On STM32MP157C-dk2, each schedule() execution takes between 2 and 4us depending of the cyclics function to execute.
>>
>> That is about 1100 instructions on 650 MHz CA7 which is way too much , I think that is the problem we need to solve first.
>>
>> Look ta common/cyclic.c schedule() , I think it is the list iteration in cyclic_run() that takes forever. And I think the fix is simple, let the list iteration surely run through once on the first run of cyclic_run(), and while it is running, for each entry, figure out when the entry should be run NEXT, and note the NEXT run timestamp down. At the end of cyclic_run(), figure out when the nearest NEXT timestamp is (you can do that as part of the list iteration of course), and store that information in some global variable. Finally, add at the beginning of cyclic_run() a test whether this timestamp was reached. If not, do nothing, because you already know that nothing has to be executed yet, and you will avoid the expensive list traversal this way.
>>
>> That should make the execution time of cyclic_run() negligible for the majority case.
>>
>> What do you think ?
> 
> 
> Hi Marek 
> 
> Agree with your analysis, i will send a fix to exit from cyclic_run() in case the next cyclic timestamp is not reached.
> But, in parallel, to gain more reactivity, schedule() can also be moved at the same level of ctrcl() as this patch is proposing.
> 
> Thanks
> Patrice
> 


For information, the cyclic_run() update series is available here : https://patchwork.ozlabs.org/project/uboot/list/?series=511795

Thanks
Patrice
