Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFDE7CAC597
	for <u-boot@archiver.kernel.org>; Sat, 20 Sep 2025 05:10:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B34598331F;
	Sat, 20 Sep 2025 07:10:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="V1DxkB71";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDBA9832AD; Fri, 19 Sep 2025 17:46:08 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89B8E83285
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 17:46:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tjHiUmKNlFaEFairedATb29FhWPCkTF/GMOyEAjGe4VZeXKog3FZxKRQpI3CNeHHtLP+joxsN1Sbi9v5Pg1Oj9wYkFFiCwdxsde5RdN3YOnzHukfxRfUrd/dgv/G35i7ZidMCdrYisKDWGDjGpOsyVo3kf47CSMk867obpzrSMcCaFwL9ztFUvUFTnGF2tp6jnuopBjRkCc+9PgDpkpJIOyQbnXB4NZ5RAOdjjGAv9cTEM6dVKrRZYMIZo0V0eZ0Oag4YV9NEAqdkKnwnDbhXUQlhK5MDwfKRczPdPUOCRNfmPiAVA+TIizs8oQbRQevQoIflIWwmHFqfWSlnUG7wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+4mHB2z5TKBhLCly0njFsWpF/wCrOc8cWd3ftLjDv8=;
 b=Y5mU7tvZbo2ZGRp6dijKlKjm/3/dRhDG1lx1V5mgVbklaHPVGGYBfA7S5hL0WXkMA1HpX+Okg3ffDmHj/YoxVk01ghAvxR1vCPX1ndtFnGDZF1sX+zJlfyS5TfZb0++qVjuZ8fOQfUTUHRvdhMfr349EAMdK2W5t9aZmRx4sgPeBdkqGjYUj5BWE6Y4485HNx1UakCQ1pn8nzURvk/9kNE+ZJhGJCUbxLGa90NTvnn9Sw9+gyzV6Lim/P14/gXau6qy7smdbd+Bdm9Mv/AUfqeYLHRS1kI0reLrCfj6gGJDqevD5wkvZwaPzVl4vvyVraXC82Uvt5Tn9GId+5JZrZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+4mHB2z5TKBhLCly0njFsWpF/wCrOc8cWd3ftLjDv8=;
 b=V1DxkB71JKUgSHjeDO5goP0Td5exEjXXDmojKxtCXTMq3aHmrRGyFLkmH9Vo5RPdz95VtkvWgbyNRAVUOhYMSm5uS8CpPcILsCEcmpOsOMOyaIvnyhLdkiGCl4W4xZZCRvtoLh0/MQzm6TaaWRkZBFn8z0OrJvYc2PDe90bUaiNgt29e9fkynCMYDdn0rE5wKx7R/A30sLxA27+EyqQ+DqnZpC6dtZp4krOwfzQ2gYqrZlZhKYjUFBi1uxOhyIciNAGedCi8uAbeSCOFSkPqaSyNtgvI9G8sjyq4vGwEocfvi/Z0cLJNbMMUM9rhFH0YcLSWhihKAEBJhuMLMdc5Wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by VI0PR04MB11072.eurprd04.prod.outlook.com (2603:10a6:800:259::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 15:46:01 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 15:46:00 +0000
Message-ID: <220c3246-781a-4349-8d16-6eb1dfdc79e0@oss.nxp.com>
Date: Fri, 19 Sep 2025 23:46:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: sf: align erase and write on erase block boundary
To: Marek Vasut <marek.vasut@mailbox.org>, Ye Li <ye.li@nxp.com>,
 u-boot@lists.denx.de, jagan@amarulasolutions.com
Cc: peng.fan@nxp.com, uboot-imx@nxp.com, alice.guo@nxp.com
References: <20250919070156.1497268-1-ye.li@nxp.com>
 <0528b2bd-09ef-45d4-9003-f8c1baab372b@mailbox.org>
Content-Language: en-US
From: Ye Li <ye.li@oss.nxp.com>
In-Reply-To: <0528b2bd-09ef-45d4-9003-f8c1baab372b@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0179.apcprd04.prod.outlook.com
 (2603:1096:4:14::17) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|VI0PR04MB11072:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aeb2bad-5c19-434a-7e17-08ddf793a1f5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|42112799006|366016|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZlExNXZFcEpMUzhJeE41OGJrdmpiUjlEN21mc1dJcFFFanYyTm1OMFBDWHdC?=
 =?utf-8?B?TWxabTEyM0NtTGtMTE8zenR0Ri9RMm1TV290elRWeWJxblB6MEgwS2ZzWWUy?=
 =?utf-8?B?LzRudzFBV1lNcTdWRkJjenBBVkM5WmFRaGxMdVVNV2pPS05OT3RqMFRBSVhU?=
 =?utf-8?B?ZWFpUjEwNll1T1N4V3QzOVRselFFcjFDdlpQcjRzcFVuNjJJZWhMR1lsTVkr?=
 =?utf-8?B?TFRXNDE1cFowWEJMVU1oOXIwMmQ4TW1SZzh5dkJlU0UwZE1lT3J2NzQyRFhk?=
 =?utf-8?B?REpaYURsNFVzc2VvZXdRZlNZTWxqR2VqbFNwci91Y0xMTDlreE8yRGZhVkRV?=
 =?utf-8?B?U2tLeWJxVG9HWFhMTzhQM2NtZ3piTTUvNmNPaTdoMGFKa2M5QVJyVUMwL3ly?=
 =?utf-8?B?WGJyUFB1SnozaE05aDhBcURrbzZxMVJleWxyZUlPRUN6MzgyU3NEQlRyVGk4?=
 =?utf-8?B?U3puTFA2YjNMeFVsby93TnFXbEUwSzF1eGJ1Q1owaDBLaFY3OVNtNVo1L2FR?=
 =?utf-8?B?Q1p6eThHUnBhQmVwamdTaFF1VTY5MmUycnd4bFd4T21yQU9tcDMzay9BcFFu?=
 =?utf-8?B?M09UYnhRMUppS09DeHVFZmI5K0h2RE91bGt1aHZIV2VCVHNzTVE5R3l6L3lJ?=
 =?utf-8?B?SU42OUF2WWpiY0pEWUx3RGpsNkM0aU9VSjBvenZqT3Y5TnVNK3RLTXphelRV?=
 =?utf-8?B?SjdLK1RMUUdJWGxzQlU0K2RUT1p5VUNuTHFJa3FtQXZLN0RqU1hyUTNDZmVx?=
 =?utf-8?B?dXFEYitEbjlLL21xRnQ3QWRJM1pETVg1by9MVWtmNDVaVGNqYVh0ZG5RbUJO?=
 =?utf-8?B?MDh6enRHT1IzWDVrMjIwWWs3TjNnanZJbEoxdVk2VzRkUXF4V08xYzlzYTRi?=
 =?utf-8?B?azdPSlVZK09rZW9pWHdpTExXQWIxS3puYWpwaWN6QUpWZlpWam10MlYvRkpq?=
 =?utf-8?B?alB0bFZPTjVRRGlDZlIxWDdKYzdKSTdPUXFVdkFSSGRhUE9ET3VPSkhmQlVU?=
 =?utf-8?B?MGFNYmhnb2ZkSm9YaW9lOFh3dmw1bElvbkwxeldJQ3dsRHJPZnE4KzZpckkr?=
 =?utf-8?B?Z2ZZbmtERmpOTEpwUkFUdlI0bWFZaEFiTFJWZUFlano5czJldkZqNzF4NWtq?=
 =?utf-8?B?YjJ1UzRWVk5RQ252ejVOdzdxc2JiNFpQaHFZQTc1ZGJ6VDBmMzVLZlRZQnNO?=
 =?utf-8?B?UHFEck1HOEtKam9wWTdHSzRQY3g5M3MxdzNwZ3VJdG1HZVNCVXR3SGZZbXFj?=
 =?utf-8?B?QUh2L25QVDVHcEJ6S3MyckZuWFRLQkdtN2NaeHNXR1RJQW1nZUtldmpzcVh1?=
 =?utf-8?B?THVoamRTaUZ4NG1rMy93L09KT1lxUStHMVdTK2pPSldaSFlPb25IVjUydWJu?=
 =?utf-8?B?TGp1S0tjQTZvTWNBZXM0VEsvdXFzQ3BNOXRMT3dYb0tGcWV3OTF1cmVnTjla?=
 =?utf-8?B?bmRHVHMwTm1TeU8xSkJnbkRRa1Vlc2Y1UklMSXllVGlQRHNJdm9RS1pYQ2w3?=
 =?utf-8?B?TjJzaHNCSzdtVGlSMmEzNVEzM2ZtV3U0QjV0TDJLMUtCSlhLVVlVcEFqNHRB?=
 =?utf-8?B?Q2tiQVB3enlqWWZLa0R1NUZoa2JsUTJHRkRndm16b1drYVV3c2ZjbWp3dHY5?=
 =?utf-8?B?blhHaFFIUXVTdWF6RnUyNmFSWTNkbWpDTTcwVmJUd3Jacit4bDlHcHhlYjRZ?=
 =?utf-8?B?QTZKbDRrK242bWpHY0xLdTRCRVkrNFhLWG5RS3NsVFRpZlVCMWFHcEUrRlJs?=
 =?utf-8?B?Yjg3Rm5sK2NFWmJ5Qyt0M1VSOXRESTVOQ1Zlb1BwWXQxV3BBeXFVRkVQWFpW?=
 =?utf-8?B?ZTdveGorektNSTNuMFNvWnNLSmNxS3FtWGRhcjNuZWtCZGRMSTUxMHU4TCtQ?=
 =?utf-8?B?SlVoOXg3N1JIV2VKV0pXeHBLU04wMkV3MCtXbGpkM2pEcHBncWJ6a2FoNUdX?=
 =?utf-8?Q?lONwoKb9StY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(42112799006)(366016)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0xxUUxzdndEYUZ2ang1RFRxU0tZVzdWTEZUa0QwY05KTFFqczhWVHdOMHJn?=
 =?utf-8?B?SGpCQ2Vyb2RpVlNQTWlWdWJVdlgzVW0rS1BNZjB0R0dwWUlhd2NHbjh3TFlB?=
 =?utf-8?B?eWJjT1M1bGJVL3FOTkY4SnVmWkpnYmU3L0JYMCtQOFhlM1U0YjhNd1VKMi8r?=
 =?utf-8?B?Q3RzN0I5cG1wbUd4djVoYVYzYVZPRUI4VGJoY25USUMyc3VkQytvaWtUWnNi?=
 =?utf-8?B?NVl2Z1UyTE1SVWttQ2NRM3BidGV0RUh5SHRReUQ2WllmOFUvbW1JUkpCYUxy?=
 =?utf-8?B?bGpqWFoyMnRmYWpuY0M2WEs5dDJ3MURaV0dJeWZYTDFFNGR3Szg3YTJaZENj?=
 =?utf-8?B?aXJRdHhzSjBuK3I2M2ErR01jS3hSOUhPODY5MHpLVUJTbU5ZQlJuaFhvVkUz?=
 =?utf-8?B?R2FVQ0ZyWjVNMGhYVUVVSUs2K0ExN0VEVzlYZi9zSHhWM0Y2RXRSejNCMUMw?=
 =?utf-8?B?eld6T0hYVXFJM0QrQWJ3TDBudktrQVYzTGFlOU5GMThSWHlHSzl3SEYzaU42?=
 =?utf-8?B?VE0vd1BGOWFFWkpKcG0vT2FnUTNJU1Q0U1l5ZEY3S0xmSFc0YU1wR3FpVzQv?=
 =?utf-8?B?bXBjbHI2czFqVlg3eXVTMFZiUHhxSTBRay9BenhHRFQzR3EveDFST21OVGNX?=
 =?utf-8?B?d0V0alorNzA2SHZCVHhCS3V5TmxPaXRPQkdEUHJ5VnJDME1pT013WkdYWDNa?=
 =?utf-8?B?RitmK0VGQ01oQU8xaU9rT0o5OExBbEk1MkYxblc4blRSclNJMnA0Qkl6ZURG?=
 =?utf-8?B?RkkrcE8wSW53WjhIQTBhNUphR3hqdWsxeEdLcXhPNEJXZk5Da2pKU1VjYllJ?=
 =?utf-8?B?U3hpZnF4VDNQRVVOellmODZxYXFXaXAvVGlSbGI5Q3dCZzdNcnRnWVBqRTlR?=
 =?utf-8?B?YzE5OVFSNnl3WlMwcjRWbXQrWXUvS28wUERScUs5TTRmVVFqcXJUZFNhMW93?=
 =?utf-8?B?S2lCNlVycVRkZDRsclBmYVdIN3o3OXloR0tSU0s0d044Nk14cWh6MURSS29Y?=
 =?utf-8?B?Y05TRi9VblM3UzZ3S05MdEphRVNlWWExL05BQ2VHNkdTTEV2eWNzR0JPckRr?=
 =?utf-8?B?QXRUaWRpOVlFRUdWYkkwb3JqZWV5VlpxeG1waXNKeEVZYXRzUzQreEJmUStr?=
 =?utf-8?B?aVNXTTRRNXcwK3VBanA2ZVJvM0tuakFQOGNVd1BtL0RRaEsxa0NvdHE1byt6?=
 =?utf-8?B?NjNFTk1ZdTBWMkcrbGFtRDJYakdqSUN2T2pBeElWTkNKa3NmcmxISytzdmg5?=
 =?utf-8?B?UWtUeWdkZXFsUUZ2V2swY0NmQnNqU2hnZ3dpMFNXandDMmFxVm5oQmZ6anJj?=
 =?utf-8?B?RlJ0UlJwT3lFbG9LR3BUSytlVmNGTkhlNk4xYVM1YmtjZUN3RnBsaUsyWjRi?=
 =?utf-8?B?aG51ZGxpejNhUEkrUkNJMW1VOGsveC84RTZoa2swRy9mQ1JLdGdwY0UyNkNv?=
 =?utf-8?B?cVZteFM5WTNrRHFlTUtiKzVHMUplOFZaOWlxZVFNQVlsUnNuelJxN3NlTmIx?=
 =?utf-8?B?amxQWnljenFmUyszcGM3bm1RV0EzUldzR0RuQVVXR0R2N1ZOais3SlgzWGl5?=
 =?utf-8?B?NzJuNjhmcldTQjlVcVRYcXRlMUoyUGF6TlR1OHVhdFdPSDhIUlpQRXJFWWg5?=
 =?utf-8?B?QzFPd1BFYWZIOCtKSWRLMElwcVd4cEpHdHBEMzJzcUFIZXBMeTV3VVJaSHZ4?=
 =?utf-8?B?cUZneFh0cVhsQUdjZk9YdzdlVDdHREkwcUlhUVgxSnBKRnZXbmNUbEUvQ3hp?=
 =?utf-8?B?WnRWOVJMNGFEdzFkSEs4bWd0ejdWQmUyTEVkMVBRTmJCYm5qM1R0U2ZNK01G?=
 =?utf-8?B?MGp6UndpeGR5RjZuMjl6VkpDeXRqSkdMdTJEUDRKM2grbkJWejlRbnBjYWtL?=
 =?utf-8?B?RlpkVVhqVTRYYmcyVHZybFMvQzlyaWlqeDZxVjBvWG5hb0syZDRaUW44blVp?=
 =?utf-8?B?RURaNHQrbmdOV2IvSjRzU1BLc3loR3FMTFBCaUQ3ejdoMzFhMEhwSDg1OWFy?=
 =?utf-8?B?QkVET2JQWWxaczJkU2J2d1RRbmVXSmpyTFhnSmxGdVdJREVTMUx2UWpxMncr?=
 =?utf-8?B?T0hXeE9qdGdLVEt2SFU1bHNwMjZQV012bFpQdlQvR0xNd0RieWUwVTBxM0NW?=
 =?utf-8?Q?JqpV/ADauBrL7F+j0cpnVVnzD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aeb2bad-5c19-434a-7e17-08ddf793a1f5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 15:46:00.8884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t+r0FPzaAnsiaiQkeDjqHieAUneFE8QpKSExkj0fdk1V/SCP1Hr/OFoeZZJiov3B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11072
X-Mailman-Approved-At: Sat, 20 Sep 2025 07:10:46 +0200
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



在 2025/9/19 20:20, Marek Vasut 写道:
> On 9/19/25 9:01 AM, Ye Li wrote:
>> From: Viorel Suman <viorel.suman@nxp.com>
>>
>> Align erase and write on erase block boundary in line
>> with how read was aligned in commit 622b5d35613.
> What is the issue that is being fixed here ?
> 
Previous commit 622b5d35613 tried to fix issue that offset is not sector 
size aligned. But it only use the aligned offset read_offset for flash 
read, not use it for erase and write. So still unaligned offset send to 
spi_flash_erase and spi_flash_write.> What is the reproducer ?
> 
If the address is neither page or sector aligned, we meet issue with 
flash update

Best regards,
Ye Li> Details please .



