Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D789D29C4F
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 18:03:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D1C98313B;
	Mon, 19 Jan 2026 19:03:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Zw7Rzv68";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8A768389A; Mon, 19 Jan 2026 19:03:22 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3D468003E
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 19:03:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CVd2dObbDDLVm67kn14KpQXI6uPCCyBK3WoeK+rxZKBNVabAQea8Mj/uatTQG48trGVlD68n673EPIlaRcHS5ZU0wZJbddWRa23MBKFvhLnJUVGOLBPKZIRDOZ7VVONPUOv7XuXvaVA+SLmdd+ZbM4s/gXYavQkawqMr19E1A0yP0esdreZojuJr01Ctfh9sNj3QphFQ/tvNtk+iFyo9LMLfTS7afooUuhYf4gPdIMW+NELhdy0bLviD/n0FpC13t9VNAngp6wZnWVqvP5RxmSVavFnXARKZyAQUT1BLByrAylb1EUgsvGTEBIPxnpDViRbAcLAGyKIX/+gGX3gSBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLnQJOle+PJNUBO+g971A2GsxanQQaNNyFAi711O0uI=;
 b=vEwMD59HAJRXzvVMEMZFbrl67xalL46ajiyHlMO+fnTRyHc/8pQJlDa8gkP21i3eF3DbBIxo27SMkeLhq8PRDUNSmdh+4ikb34u43uApvyytwxJxEVKEIbA9kN0SKAQPz7y0aG/vvrtktNQ9UCp7nRrA2hPAOqA14d1UD3nVndjQ7PZRs6u9kS9BYAG6k5+M6MebJmg7YuHZ+AJQZLT5bL05Bc9m27maAEhK6qgJDmb0ouVQiOzdyMtW7+yjDHYXq7ToyWax1y8qJrdDBjlWofYD8v7zcRzFnS06Oc5QirPnJ+M+gQ1iqIarMJqDOcEcXTZnp9isxDrVf9kTA14iqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLnQJOle+PJNUBO+g971A2GsxanQQaNNyFAi711O0uI=;
 b=Zw7Rzv68Jx0T07oe1Dk/yfU+vip//hsAZ46U6O9lkXMSjqWBKX2LIw7emzquN0GDWN4iwSWU5VqM/PlViyQ4P62i6LIMjCurUMaHjweK/Enxt4ObP3VEVHfLD2Eb784sQbi4DomVgWVT4K4LwLKaUYFEt6DesyKHa3b9jD17+Sk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PR3PR04MB7323.eurprd04.prod.outlook.com (2603:10a6:102:88::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Mon, 19 Jan
 2026 18:03:16 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 18:03:15 +0000
Message-ID: <d35d3c89-1b8c-478b-bbbd-7a29f7e10dbf@cherry.de>
Date: Mon, 19 Jan 2026 19:02:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] doc: develop: process: Explain when/how Custodians
 may edit patches
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, E Shattow <e@freeshell.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20260116182335.4081828-1-trini@konsulko.com>
 <20260116182335.4081828-4-trini@konsulko.com>
 <f3bf1986-187c-405d-aafe-9e59ab14b3fc@cherry.de>
 <20260119164728.GC3416603@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260119164728.GC3416603@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0218.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::14) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PR3PR04MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: 225d24a3-a94d-41a4-ea5a-08de578504d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|10070799003|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cmtIbDR3Rm0rUGIvWG9QTmw1dVFKYmplQU9wZkdtalR0VGtna3E4aUdBZTJT?=
 =?utf-8?B?ZVJldmpFREZwSmZWaWJuWFh3TkFLbUUwTUpyTVpkbjQ0Y3pPaHFaMEwvNVds?=
 =?utf-8?B?a3ZRZW1wWDdUL05keUZCTTc2aVRZZHVsOXUyS3k4KzZEcWFzTEJoOUN1Q1Vt?=
 =?utf-8?B?UTdFMms1aXo3em1UT0VHdFJpYUYvLzR1bkRUZnJheWdOc1JrV2lUcUdwb2FC?=
 =?utf-8?B?SjNWQ2VtZFNnSGI2TUVTeFRpeXFEUWZLQjRuQkJydnFTN3U1amkrb0xBR013?=
 =?utf-8?B?N1BmWWkrd0hZeGs0Sm1LVnhjekRtM0lyUzlGN1hUSnUwaXE0SjR6KzA1Ulpm?=
 =?utf-8?B?NFl0cHpnOEVzb094bExwdGFtSEE1OGtMT2tTb3VZL05wSGhYQnBhbHRxajFt?=
 =?utf-8?B?UmdUNUZ1KzhzY3J0OWRHKzRmMjhtM1MrTEh1OUVpWGhsYU5iU08rSEo1eXZI?=
 =?utf-8?B?RWRKVHF0dGtxUFZQSjZVclBYVUJtdjlyTVZJbGRTTVljWTNML3paaVlyNEkv?=
 =?utf-8?B?L1Z1U3BUa1gvRFdGSmRaODJuQ1ZqbWRyckFCa091RDVROVBwVGM3L2FsMjlz?=
 =?utf-8?B?bGp0eWpkZjUwWnZmQ1UwOStOV2RIVHl2OUFrc3Axd1IvUk9vcm9lNTIzazNF?=
 =?utf-8?B?cG45eVUwQ2F3SUVJVXV4N3ovNFZlemNtZTZHWlBDMnJRa0o3THlVeE5FaFE5?=
 =?utf-8?B?TlhWMEp4NWNvVUxvbnFLM2RIVEFhSkJwOWFycVRuVnE0VU9zYzdESGg3bDNC?=
 =?utf-8?B?MFlNK2dyV0hwVVplR3JhUEtzMUVKWFNZK281R0ZGZnZkTERwc0RoK0dpeFFR?=
 =?utf-8?B?NVZZRUhvbER4c25XS1F2YlFoTmRmNEg5elFxWEF5U3dCWEJFVlFsK2gxTEp4?=
 =?utf-8?B?SGtDWEtOaU1xbUhEaVpBTDQyNUpaSXJqOFBGZEpqaVFLTkE4STBRWTZoeHo0?=
 =?utf-8?B?ZFlRY0FhRVFVcC9ub2RJM3JXWlZMbW53VnIrVHA0L2pKQnZVVEpHQnU2cGdI?=
 =?utf-8?B?RzRsUzVScmh0Wm1vbzNvNktPSnJieGF5a3VXMmNYUkcwcE9yOTZ4cGYwNUxh?=
 =?utf-8?B?b1hDRjlRaGlKQVlBUitLSmQ1bkhVWjFOejk1UjdNSzhiTERaTEVuUFFIRENh?=
 =?utf-8?B?aGkvSnZYM202dlIvLzIwS2kvakEycVJnbCtja1dYTFcrT3JTMkFHeVA1eHFy?=
 =?utf-8?B?NUhCSWFaOVJ1cS96TjB3eTZMTkpTbkhFdU5ZcFgwUXRaOU9GUHJrd0IydzFR?=
 =?utf-8?B?RlFSQlpnUkhLQXFvWTJQQUxOYlp5TlcrSEVCU1hVTXZ0aG9ISCtiaUIrbVF2?=
 =?utf-8?B?bE1OUkg2cG44UDJQK0tFcE1yVU5UcFQxVGxtUGJEMFdyOXhzRkROSVRJaVhr?=
 =?utf-8?B?SmtzTm5WVnVIWWJaN2xHTnB4akhHc0JoU1Qvc0FTcnk0R0szSzQyNlp1L0d6?=
 =?utf-8?B?eVBtbjMwZ3ZZTWxZVU1BQ3BFbkp4UmVQUVFKbllpYW9qTUFleFduTitqVzlM?=
 =?utf-8?B?Vi9Hd21MN0VFYkVGQi82aUw5Q0s1aEpVWDRPd3Y0UHJNYTNFVEg4cWFWMk1S?=
 =?utf-8?B?QWNzWnd5cFMxTVptNXpCbUFHVmtPcDJMNmJvRlJrSVFZaEJFSjZabjJiZTRJ?=
 =?utf-8?B?dEVraml1Vk9SNmFBWUtVQmFvN1VjanVVY2NNSnNLS0tUT0xBSC9HQmRCblYz?=
 =?utf-8?B?SFkxdFd1MFRzNERROWZKTUpMcjlqWW8wanpaeSs1M1dJOVFGRmFuQVdld2o5?=
 =?utf-8?B?UWlaVm5nS2p3bjdrVkV3Y3VFSGprRGp4VzV2OG56aThSMzJOU2NxZ1FTSkx1?=
 =?utf-8?B?dnpTQmlmeHRpY2czYml3ODd1WDRFTUtHMWcwQ09wcm9NdlJNWTdDQ2N2eXFK?=
 =?utf-8?B?QUZtZm5BVDdvaDVxKzVzQTNudUhIeitXNUpENmk1NzhySERuVGw1VURtSFg1?=
 =?utf-8?B?b0JhVXJ0TW5YZ29IQXNhUmRjMGNYV01QVWc2RWhyRXIxM2NUWWdFbXBBWkx5?=
 =?utf-8?B?VEJUaXBFNDNSSEEyVTdCSGhEY3hnNll6NkR5RHpPZWJId3ZOYWI4enFwd2Y4?=
 =?utf-8?B?dGZJN2tXWUtpSzZ2SWhEWng1T1Y4eDJnU3h0ankxME0zbWtDVXBtYTFwK0ov?=
 =?utf-8?Q?XUes=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uis1TGpmbWxYV3BzZlhXd1N0YWs3UERIQlgrZDRsTHFoLzErZVZjQnZlSjB1?=
 =?utf-8?B?VllyUlZCT21lRVFYMHhIdHdudUx6STdFQklKOU9xY2tabDJ5ckc3ckV5UUJl?=
 =?utf-8?B?S1hvZWxIOFEvUHJxaUlLTkFMaDJ6MmxrVEpHUnB2TE5ZTHIwMnIyb25nYkN4?=
 =?utf-8?B?ZDIrL284cUtUSytub3FFRjZXZ3hNbnBPSTRHVjV1NXRYeks5S2Q3ZzB4SkNV?=
 =?utf-8?B?N2dnN3BML1VucENCQ2V3bUl1aW5CSmd5WUJYUVBjQXQ4VG5JRndLTkJDREl5?=
 =?utf-8?B?TjJZUXhWSUxOUGpnVjRRL1BnWEw1U25nWHV1WlZ0T1d2NjM4N25VZU9BRnJk?=
 =?utf-8?B?NmN1bU9GUElJakdySG1aanQwUk4zMkhyR1ZEdlhMamsveGxNaHU4SEJHeGlI?=
 =?utf-8?B?VDliLzVMUHNEZk9Cc1NnVDFRVVNSZzZ2Skw4VXFuRzR3Z3oxSW0wODVKMHZ3?=
 =?utf-8?B?cmNPMTI1SDRiRmVsbzFKNThlc21SV2ZEcWpKOEY1R2hGK1ZGQ0pRZWNjYjh4?=
 =?utf-8?B?bHZLVjlNUFUzRUY5aXZwbnMrOWk4YVF0bXNQQUNSeXEzZWlOL1F0a3JidEc3?=
 =?utf-8?B?V0tPWFpTMktDcTNESjRJMmtyWnRFZEx6cE9zSmRWY01Db3FSejRCYXBKMExi?=
 =?utf-8?B?UUhXZzdHWkVabnJNaEEvVTNxcjFsQlpEcHBXUVhZdnhteThxWFA5QTRRVGFp?=
 =?utf-8?B?UFZHREhHcUJ3NzBvZUJTS2ZmR3YwZCs1bUtjWmJjRDVEakQ5aExDM3lYTi9Q?=
 =?utf-8?B?SUoyYkM1SXM1QllOdkJUbFp3UGVNaDJ1dEpmMVJMRXQ0ZklleVN5cDZ0Y2ZT?=
 =?utf-8?B?THovdzFKWVdSMVpTQ3pNREFjd1ZwbXhHK1JKaGpaSU0vVzAvRlovS3REdkhG?=
 =?utf-8?B?ZWl2aGZvdy9UeCtNOGtUY2YxaGtUVVJDRzBpSE9pVW90RjV2U0dsRGc5aFNt?=
 =?utf-8?B?TkhuYU5sOUhmczdNVkROS20wclZMV2FxazhPTmFzU0FKbTRSUjZZdkYyUzh4?=
 =?utf-8?B?OWhlT1R2Szl6citrK3ViUDhidERvN0ZVQWJFSmRJV1dqaExUdWpOT0NjQ0xH?=
 =?utf-8?B?Z01Qd0FWaUVkWXZjWndSZzgyNERabFFKZUdnTytibzdLL1oyaU45MDV1Y0M2?=
 =?utf-8?B?T0doZk5VUHJpdEdkRmJlS3o4VXkxWG1jZVo3N25tV0k3bW81WVErbUlpWUZC?=
 =?utf-8?B?cTVpNWJBYXBaak1Xd1RFUlFZMUJNbXR3RnMxV2Y1cU1xT0JNOFhTME53RUxy?=
 =?utf-8?B?TjJndUR6K3ZMcjE0Q2dtRTdmZTlWV3ZwSXp4cCtteGcyYlZ2WGJ5UEx2SnVE?=
 =?utf-8?B?aGpxRklyb3FWNENKTEJsZDl6UDVydENYZkpObXcvTjFmQjJ3VlV4L3hFOXFI?=
 =?utf-8?B?SEVTSktNTVFKciswR3UxckZyUDVHaDFvczVRaFpDK281SnVxWk85WXcweEJ1?=
 =?utf-8?B?c2E0YnJyQmRtWFhXUnpDOTc5Qk81UzZUT2pzeUtWNE11WkZHOWdDbC9iSFVV?=
 =?utf-8?B?QkRMWHNwUW1WZVJVTk51TEh1amRJcDhja1JyRXk4UnRzYWo0eHNWZzU4OTI5?=
 =?utf-8?B?RkU4VEp2Tk1xSUVXb3gxd2JrL0VhQW5VNnhYbWZVODBHTDBJaTVQWUFTMnc4?=
 =?utf-8?B?azdvdUdHWDR4K1JBY3VNdW5JNnFZSWJ1UGF0UWF4VllrQVRpenVzL1l1Ykpx?=
 =?utf-8?B?ZjZab1VaWGtnYlNBUjlHNE9RZGt2dzJ0NldRNmZ0YXlBMmlDTW1XSG9EVkx6?=
 =?utf-8?B?SVVKZGh3ZUMzRVFlQWJydlhXWnZMbTN3VjBLcjY4UUtudElKc3ZyOFlTRmVi?=
 =?utf-8?B?VFBoZDF2N1ZDSnB0SStYNzRQZ0NQWlhsQlVlV05oSlVkUEtOL3RFbW1GQkc1?=
 =?utf-8?B?L1JLeVRaTFRhaFNlZERkMk5JSnVpK3Y4bm9LTFJDcWtnQzkzVkJlWHBmU0pO?=
 =?utf-8?B?eFk0M1NzUGQ2d2hpbG9CWU00UXQ3K2lYbWhwQUZ1UXBmanBRM21LUGZTT2ZJ?=
 =?utf-8?B?VEJzU3h0VFRqekEwUjVQTSsrWDlMRC92MmMraHR1Ny83a3FTWWl6aWs5cWx4?=
 =?utf-8?B?TVBHSWZGRUVKWHFxTlVqbzFSRW5Nd0ljbjBNUXJtVkY4Snl2b1JRNTFuMERQ?=
 =?utf-8?B?c0VIajM1blFKTlV3eTVjNEZyUUZ0ODduVU9tc0JrWS9aRUNWN3BDbHV4WnFx?=
 =?utf-8?B?Wnl2RVRJOThMZGlBeHFQaTNwcUY3eVE0ZlhBU1hWSjZMZXVsa1JQUmhZRzdK?=
 =?utf-8?B?bkkvTmw2ckprdEU5TTVjMUloeDFXc2IwbFVyWXlIbldYSGdqc1pQZlVaYjht?=
 =?utf-8?B?Q2lQMHdxT0duTjVMSE95NXQvZDRvOENwVWpBZXhxeWpTcDY1NE1ISzNCNjla?=
 =?utf-8?Q?Z+T6eYyLgfjWiq3Z++bHVvuh0/beyRdHvmJ5Y?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 225d24a3-a94d-41a4-ea5a-08de578504d7
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 18:03:15.7877 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CKjieONinGsPddpaDS9WGgnc0SW8cGy7Fx1KsaeYMCd52UQ3Z9kPUtd5Tm19GMY5TraeIWsmXkM7dyRfH2lqC8Z94g1SgVPQsC1m+eM6bYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7323
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

Hi Tom,

On 1/19/26 5:47 PM, Tom Rini wrote:
> On Mon, Jan 19, 2026 at 01:27:52PM +0100, Quentin Schulz wrote:
>> Hi Tom,
>>
>> On 1/16/26 7:16 PM, Tom Rini wrote:
>>> As seen with commit d503633a3676 ("Revert "doc: board: starfive: update
>>> jh7110 common description""), it has not always been clear what is and
>>> isn't allowed by custodians, and what the expectations are. To prevent
>>> further unintentional conflicts, document the limited cases where
>>> custodians are allowed to modify patches directly, and how to do that.
>>>
>>> Signed-off-by: Tom Rini <trini@konsulko.com>
>>> ---
>>> Changes in v2:
>>> - New patch.
>>> ---
>>>    doc/develop/process.rst | 6 ++++++
>>>    1 file changed, 6 insertions(+)
>>>
>>> diff --git a/doc/develop/process.rst b/doc/develop/process.rst
>>> index 6f5bdd3db957..775a855fd7a0 100644
>>> --- a/doc/develop/process.rst
>>> +++ b/doc/develop/process.rst
>>> @@ -144,6 +144,12 @@ feedback to the submitter of a patch about what is going on:
>>>        feels it has been too long since posting their patch and not
>>>        received any feedback, it is OK to follow-up and ask.
>>> +    * A custodian may make spelling corrections, spacing fixes and other
>>> +      obviously correct trivial changes. They must also in turn amend
>>
>> I guess people will have a different interpretation as to *what* is an
>> "obviously correct trivial change", based on the U-Boot git history, are
> 
> Yes, but this is intentional, honestly. In my other follow-up to E
> Shattow I mentioned there is other general process stuff we need as a
> project. Custodians are trusted members of the project and should have
> some leeway.
> 

Ack.

>> there some commits that used the [] + SoB form that are fine or shouldn't
>> have be made such that we can elaborate a bit more?
> 
> Yes, we've made changes before that perhaps really shouldn't have been,
> or at least are questionable and should have had more discussion.
> 

I was just suggesting to provide real-life examples in the docs so 
people have some idea on how to format the commit log for example. I am 
neither intending nor expecting to review all commits ever made to check 
if some changes were made without approval from/feedback to the contributor.

>> I think providing an example would be nice, e.g. the patch as on the mailing
>> list and after being merged with changes (obviously one you think followed
>> the rules here). This will make the section longer for sure but it'll be a
>> visual cue that this is important.
>>
>> I would suggest to require the custodian to notify as answer to the original
>> patch if any change was made when merging the patch, even if the changes
>> match the allowed list of changes listed above. What do you think?
> 
> I worry that we're making too many changes in the wrong direction, based

It's always a fine balance to find. I guess this could be less "needed" 
if we encourage custodians to use b4 ty to send thank you notes when 
merging. Then one can simply go and check the commit themselves (or like 
you alluded in the v1, have tooling that can check that).

It's always easy to suggest processes when you won't have to follow them 
yourself, so I'm mostly asking questions or suggesting things.

> on the problem that did occur. Which was a real problem. But it was also
> something that obviously fell outside of the "trivially correct" rule
> above, as it was adding new content.
> 

Ack.

> Maybe, since the kind of spacing and spelling fixes I perform are the
> kind checkpatch complains about, and submitters are already supposed to
> use checkpatch, I should reword it to something like:
> 
> A custodian may make corrections to patches that checkpatch.pl
> (reference) notes, or may request the author re-submit after fixing
> them, at their discretion.
> 

This does help but only for code parts. We don't really have anything 
for the docs for example, or Kconfig, where typos or formatting errors 
can creep in. But I assume you intended to keep the whitespace/typo as 
general rules and just add the checkpatch requirement for everything 
that falls out of those rules?

We can always improve this over time, better have something explained 
now and refined later if custodians have questions or feedback to provide.

Cheers,
Quentin
