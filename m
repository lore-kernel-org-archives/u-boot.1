Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F1EC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 15:49:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4003284A67;
	Tue,  7 Jul 2026 17:49:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="QAr6zwTP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 198A984A6B; Tue,  7 Jul 2026 17:49:13 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA10B84A5B
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:49:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z7M3O1hD2t0E92nobXhvcjdxVpBrjd/XWh5HrJwv7WHe/G84TYp/gYXaLW8fU9CW+CNhW8/oSKGJJnnFumAvslvKq8xsOQDlYY1ihfHEj1Vio/58z0QhmMaaHciAbh2t8ltdTf+Ee5ol1qFwH6XTXzKhQSM/inDl43F/VMKvsD0Y7izYsPp5XYppD6IxYXTZG3bRe5ki62e36Oz0Ob98gOI72LHEphvwsyQsEB09IE5gw/f/vPVIuV+pSeUgV9klrOKGFG2i7VLdRo2Can6yurhPPssH5tSz82uNdfxBqJYWYtO7hjdAth479Y+FXP3bUSdP70hZGNRNPIYawdD+Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1uLyugfOPNVHuQblpLDn7SIDeqXDmv9b2HlyWsrJwC4=;
 b=lK3g0R+w/uozV3b4E4E4th/cnUHUoSMgqMTEpO5kcS2R4S3LXzBtdw+bWaHuGv3hKQKZ83bTMMhQm1YHBtuFPdzya7MCDqakYNfRL3aJkMknx3GFag3+pHpZj+lLx9Ywwhl0ncza8t9rEnYcjPTOHQ16Ch3yg7romrsK1r8ScQ2NwAOCT3+gTkfbHZWJna5Zb+mEPAf1BTjDo3vmZrLwcyeBwTIOvnXs1FOMo9fIo32GE6zFFPv6knvIZIe67k6ln2eIlXvwvX6a5dytpO3i0jLt5KWEnCIzoKzq9as5Hj0dCP58CslH5eDBYFVLmmJZ/iaVmhNZ3na7P8vQQ2DiQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=rasmusvillemoes.dk smtp.mailfrom=foss.st.com; 
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1uLyugfOPNVHuQblpLDn7SIDeqXDmv9b2HlyWsrJwC4=;
 b=QAr6zwTPTu96lSwjahvbrzzEElHnWgbqc5oBnxUqwAlCcqb+9/Jvd0UTcv9RSEkm/D8BD0lipGOCrJqiJWC+OgxeGH5XVdJZEpN5VVCGROK2m335/UFVPx8Qmif5CFTGC6PGCJkPyPOBXPwYDWNDVYRsk9HmBvkWuH/L9V2UcHg/lLtxm/Flos8cTI2Hcjfs8EorrkGbhjie9tlTPw95DD6JkHqlyY/U/XmU1Ty3hJhMle/3vzRvz/+1Yle+M6yfMncEdIQZnUcecfZH09BjG0ZBW14RSBUdTkyHNNfGAMql4lkFkrZZTFKs8Rkom+rWYrm9SrAfDBUAycwKTD6rTQ==
Received: from DUZPR01CA0111.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::12) by AS1PR10MB5238.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:4a4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Tue, 7 Jul
 2026 15:49:01 +0000
Received: from DB1PEPF000509E3.eurprd03.prod.outlook.com
 (2603:10a6:10:4bb:cafe::33) by DUZPR01CA0111.outlook.office365.com
 (2603:10a6:10:4bb::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Tue, 7
 Jul 2026 15:49:00 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB1PEPF000509E3.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 15:49:00 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 7 Jul
 2026 17:53:20 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 7 Jul
 2026 17:48:59 +0200
Message-ID: <16a11587-840a-434e-aed1-17e1b1ea0a33@foss.st.com>
Date: Tue, 7 Jul 2026 17:48:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cyclic: parse cyclic list only if next cyclic
 timestamp is reached
To: Rasmus Villemoes <rv@rasmusvillemoes.dk>
CC: Marek Vasut <marek.vasut@mailbox.org>, <u-boot@lists.denx.de>, "Stefan
 Roese" <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>
References: <20260702-optimize_cyclic_run-v1-0-92c5a7011f54@foss.st.com>
 <20260702-optimize_cyclic_run-v1-2-92c5a7011f54@foss.st.com>
 <b9c4b762-6abd-4025-bde5-ab911fd5f683@mailbox.org>
 <0d9f5186-8342-4a11-adf3-2ffc2e5267f6@foss.st.com>
 <5ce8de52-2fec-4d08-a9e6-cfc69edbaa0a@mailbox.org>
 <13f510d9-6b08-499f-a6c0-f76484488899@foss.st.com>
 <ec6ed9f4-b302-4336-af02-1645aff668d1@mailbox.org>
 <tdaxlZF2d_Uu_E3EBGWqa6RvibE8eLsMtvc4ekpUPHvJSli9Tah-PpLHs7xG5VSIlo75XUDaauwgSb3kep-Dyw==@protonmail.internalid>
 <62451a3d-6fe2-49fd-a724-197774305286@foss.st.com>
 <871pdfw57m.fsf@rasmusvillemoes.dk>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <871pdfw57m.fsf@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E3:EE_|AS1PR10MB5238:EE_
X-MS-Office365-Filtering-Correlation-Id: 75d4a5cf-6020-4245-72dd-08dedc3f43a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|56012099006|11063799006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: hSd7dDQNxcL+RKFxeasdu+BYO9qgJmcceCBlmDDROB7vnwkk0Nht/f94OyoKDmEEuqMbePd/9Wavf/s8JPkpdIVUvzinR2gPG4GLnY70JQDaRdLRU/8q8Sfpq3uL+IaKiK0ma+hbGKkEYxoem4PDjaBEOz2HEvrShrbxOag2l+pReJ7BZX3LRjwCNWoY9ZkLI7xZfw2lqE9Ehd7OnTx1dHZD42nALjIQKqD6sUYO4lKhtgUGbnJjmKvP79AJtE/ySQlgBkzmZtkPJnGcMpJwmDB512YlwX7Q8Tq07hMg1aVNoJbkCvm0TteT/exPBerwOx9JJiDGyFQpQaznmTzmyiBW+n/k7UA/4QHScJ0vrGR06gMcQK7EmhAOtFGdzDBWK8EPnfWJVr727TKR2y3onIO2JqhlEYbQFTYuTriUVqc6tcvmSnlBexN3pd1prc6DA1B6zJx5byyLP5h41w9fNqJjU8Pkboa12wSxbs2ADt5yhUf9SNnrrINeqO8ogEy0EwT1AsnEh/w7usJimFjNKRv++G37y+Bq/Sy9B1PgJEEpC1h58RbCP6ea8MulpnlsnGRgeKoKPlflLsrfCcu7DJfIYkveFNl5EKbhf1d4XCaFLNPoW7Xf/SrkkthW9SbgLOHVpaY03p6Bfeb/5X4sfhf68WeU7XNHrZeSi3v18SKZKfsP7o4K+7JfoItb/DbIx93833L6O/+pjF15fb42Hw==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(56012099006)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CFM+i+0Ci1M2ZyiidAG7hAg04OdhaLRRMFhJ8NpCEdC1qMYMdSuVelw4zkXkzIpKDIWWc6EWhn22QlJc1vhWK9wl5vIz+1wYjXYxuffEXCCBFYfHNXni7mHgtZzmk/iG0YETUGX+TJaFUCt31WU2KNwzV8gwLE8l/g6Qjao2Udcz6Vya3bSWTZ2idoHj9PBJNI8M22ffpw5soCpW/mFDyABupUXFB09dmCBnLXuuAI9rcoDgFL7TP48FU6250+Pp4TC+6jrL0YbyToELPS7cJ+AxidCxAaUTN8bic+iI+OMvDxbG4yrXqCCjqdEbRI05zwtv6QBO+yW3LecMJBEcD04EAxuOGoglPsHPBbk0SyM+0sIH1mhEvgBDFJmzMjC1BffWMHZAC0pM9foqCFRW5CzxcRQPJnzAIiVJDrk2hAZgJo6Pe0gyt5XgNpbOt1bB
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 15:49:00.7961 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d4a5cf-6020-4245-72dd-08dedc3f43a4
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E3.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5238
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



On 7/7/26 10:53, Rasmus Villemoes wrote:
> On Tue, Jul 07 2026, "Patrice CHOTARD" <patrice.chotard@foss.st.com> wrote:
> 
>> On 7/6/26 18:00, Marek Vasut wrote:
>>> On 7/6/26 5:16 PM, Patrice CHOTARD wrote:
>>>
>>> Hello Patrice,
>>>
>>>>>> I did a test, it doesn't bring any noticeable improvements, but nevertheless i will submit a v3 with this update.
>>>>>
>>>>> Does the list iteration exit when it finds the first entry that is not going to be executed at this time ? If it does not, then there will be no improvement. But for this to work, the list would have to be surely fully ordered in incrementing timestamp order, is it ?
>>>>
>>>> No, the list iteration parse all entries.
>>>>
>>>> I see your point, on original implementation, entries are not sort by incrementing timestamp order.
>>>> I did some implementation test, by sorting cyclic entries in cyclic_list when :
>>>>    _ registering a new cyclic callback, put it directly in the right position in cyclic_list.
>>>>    _ in cyclic_run(), after running a cyclic, compute its next call and insrt it in the right position in cyclic_list.
>>>>
>>>> There is no noticeable gain.
>>>
>>> Did you also break from the iteration when you reached the first entry with future timestamp ? That might actually help.
>>>
>>
>> In cyclic_run(), as now entries was sorted by increasing timestamp, only the first cyclic in cyclic_list is parsed,
>> we don't need to parse all cyclic_list element.
>>
> 
> The point is kind of moot as v3 seems to work just as well, but I do
> want to point out that no, ensuring that the first expiring timer is at the front
> does not _sort_ the list, and breaking once we hit the first non-expired
> timer would be wrong. It would of course work for a list with at most
> two elements, but not in general.

Rasmus

I was talking about an implementation that i didn't submit to the mailing list. 
In this implementation (just for trial) i ensure that new cyclic entry is inserted
in the right position in the cylic_list in order to have all entries sorted by increasing
timestamp.

Doing that i obtain around the same gain that your patch proposal, but yours is more simple.

Patrice

> 
> Rasmus

