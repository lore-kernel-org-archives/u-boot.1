Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43876C83F1A
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 20:07:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEE40833F1;
	Tue, 22 Jul 2025 22:07:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=os.amperecomputing.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Purkmhkz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 269F4833F8; Tue, 22 Jul 2025 22:07:30 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20704.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::704])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3D788331F
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 22:07:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=os.amperecomputing.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rebecca@os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ICrpjC7l7xAICKEf4g93YW4dMtiNtzKAKRy3LmK1K4GngaCX3VTtCqI2htJcF7ZwU/6l7Yl2StGoOQX0WEMgF/Dzy9NIxgOZrbolyl/e3QZvrgklHBRwX0rn+jwbyVjL8SSZYYbPkeAsv7u5ixVGxfwunDLwXAZfYMxChqxOXD7O+A2XsEHXDwHDFgYX/qMGC+MqbTyaHik03be9+itC40YXdnA7IpTGzc6ChmYzuLEz77nP0psHhGFk+JQRBhj4Ausb03779pTJQfhE89m9fTpe6ngwDq7ocjXg9P+D1twaOULO9FIZBI6ePO2nZLRwaKYeyzhtrlyVpLieL3M2Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvWuajsXtmwgBcO1lYhIsvOasQPp/eraJNag9TDvqcM=;
 b=IMOTUzUwCZY535hu68YivJ8+sQj8WJ1eQdOAL53dCzkjvRPhj4tOViWuV5YcIQORIqb316nXJDvQyDo/PETIfOeynUHRTTBzcxrIMCl/lAuY8gYEdqIIB00WCgZ7wn5Re//a2RYD/44IJo420wMDV+Sih9kWPwKELpfi1haj56GtpeC1efknuG5fTfSyVwL2ClO634hnD3625uaN8crVuJkhsO0Q1GkSzSDErh0BBd7o2cxFBNpPgukEcFjvHN4h2nCigWVOiP/DGgGWkBD5bhS1tO51wk5OV9YpEr7YQQfJCaWp4BptdYIYXB6rMAoBtGw+T9hgOqc8M2Tvo6lNQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvWuajsXtmwgBcO1lYhIsvOasQPp/eraJNag9TDvqcM=;
 b=Purkmhkz8JS9P9Fg2waVXRF91DF3hQkKSH53JXgW7QauW+5xGDpLjC2IgJ27z6oxqBH2Lxv/2unRO9aIckGbgpwkQh+KhXVVa41uPwk3vhHeGmAK1/2je7f5dbB4huO4kvdYV4cKf3Fo8Jnw4Y0CE6zrzJuyNk2QG7IXJ9j7Aes=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from LV3PR01MB8464.prod.exchangelabs.com (2603:10b6:408:1a3::7) by
 CH0PR01MB6954.prod.exchangelabs.com (2603:10b6:610:107::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.30; Tue, 22 Jul 2025 20:07:23 +0000
Received: from LV3PR01MB8464.prod.exchangelabs.com
 ([fe80::74dd:8ddd:b9c2:8d2d]) by LV3PR01MB8464.prod.exchangelabs.com
 ([fe80::74dd:8ddd:b9c2:8d2d%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 20:07:23 +0000
Message-ID: <64fedfd5-85df-4b6c-82bd-81085ea213cb@os.amperecomputing.com>
Date: Tue, 22 Jul 2025 14:07:17 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm: dts: ast2600.dtsi: Fix typo of uart11 reg address
To: Tom Rini <trini@konsulko.com>, Billy Tsai <billy_tsai@aspeedtech.com>
Cc: u-boot@lists.denx.de
References: <20250717161527.2664-1-rebecca@os.amperecomputing.com>
Content-Language: en-US
From: Rebecca Cran <rebecca@os.amperecomputing.com>
In-Reply-To: <20250717161527.2664-1-rebecca@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::23) To LV3PR01MB8464.prod.exchangelabs.com
 (2603:10b6:408:1a3::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR01MB8464:EE_|CH0PR01MB6954:EE_
X-MS-Office365-Filtering-Correlation-Id: 60ef031f-098b-43e8-0677-08ddc95b5eda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkFaR0lJRzR0cFRuVXdWbnJKU0VWZW5naitFeUpTL092MG0xbitSOWo3cFNP?=
 =?utf-8?B?QzVYUEFIbk5XSjhkSk9aSWJaQ0M4aUk0UFhJQk91MjkwQWYrdGFGaWtXaHNp?=
 =?utf-8?B?VTBOVDNHY0hrelF4UWs5SUlpZTRkSGFZZkVrdTBSdW1zMGtFTXR5MXNpb1No?=
 =?utf-8?B?RGtzUkpLNjFnVEg5TUJXb2MvZ0N0eTNhZEkvM0pDcGtheDVmcFNITHRncGVY?=
 =?utf-8?B?eE9CM2pXR0hiNVhJbW5Zck9DUDh2T0J2cTQzcjNBR0c1dVZELzJ3aTN4dW9O?=
 =?utf-8?B?WlRETHJaN1YyUnV5V2VocE92NHVKZmF2ZjdRS2hSamsyaDRnS3liMnZ2RW84?=
 =?utf-8?B?WmtkN3pIS3VlM2ZKdzBGd2daUHpEVWdXV2p4cVFIY3ZwMC84OE5ZYndEVThh?=
 =?utf-8?B?U3NjMXZWZWhQVFJhNWdpSE1xbUpxelZlQXlZUk5MWU5hZUZGd24vV2o0QVIy?=
 =?utf-8?B?VlM2L1R0MGdnQmxlVzJKcDJwb2lDejBmbVB5YlVUTlZBTVJXbDlqVHlRR1pP?=
 =?utf-8?B?M0tTUkNTN0V1aS9VajZuREIwM2QzUmhNQ1hadXV4ZWd4enRObVNKRllHQnlr?=
 =?utf-8?B?bXU1S2ZPUlZXQmNSR1RVQlZkUEdEZGZqSlp3eW4vWDFzVGFyTlM2ZllIQVpN?=
 =?utf-8?B?RHBmQ2ViYmF3d1BheTVGMWkzZy9FL2dXN25QOHQ0b2YzRjRFWHMwZjRGWjQ3?=
 =?utf-8?B?bzdoZDRuQjZ4WndMQi83N0NxbUhZSzZ6cFNOeTAvaGtiN0ZnNFVNb2JUT2NK?=
 =?utf-8?B?UnJBeGlOSTdrUnZWSmJ6aTMzYzNmWjVZUVgvYiszTDZyaXdLQkZLbXZvOTdB?=
 =?utf-8?B?MnhYWit5SmNkR2ttQ2I4QXUwUStueFJ5ckZ3Ylp2d1RvcDlya3V4ZTM0Q3pk?=
 =?utf-8?B?YnAxa3dZeGVhYVlZeGo3WU5DekpzeGZwUE1VK2tBalo4cGpqWVVUakxVQ2N1?=
 =?utf-8?B?c1ROT1VwV2ZZbzlIcXNLcGt0OU1wRnByKy9JaFFZelJjYURxZFpGM2xQMmdk?=
 =?utf-8?B?b2ZLVzFWOHJiSjVSL0NrMThKSVdVMGRGWVlITW1SL3k1WTFadmdQc0o1NGpT?=
 =?utf-8?B?Ny90VXVyYWtQZnduMkQ4MGhreTdUQXVnbHpxWldpaDJRUFNsMDBDTkZSUjRT?=
 =?utf-8?B?NitFSTZudGVieHhCUHNWWXNZSURydzdlRmRiSWRDNnl1U2J3R29RMDVBeFVC?=
 =?utf-8?B?WmE2eTBLaEhqZGlBRjNVWFpUbTBIZk1pVUYxQnE4anZXQXVSNE1TY2ZqdFNs?=
 =?utf-8?B?VFhKcmZySEtUZThaamQ1VklmZmpjbDROSDN6b2VDMWtITk8wU3BtTEk5L0RT?=
 =?utf-8?B?MGNtOHZjTEp2UFRjWlFzUXN1bm9uVUFRMWRlZFBLbmN4YW9wVUNzSExZNFZO?=
 =?utf-8?B?cy9Wb0EzYVhNM1BGbVdRSlc2YkUyK2RmZ2VnbjVnRWowbWRWRjFhWjQySWRL?=
 =?utf-8?B?WUdoRFB3U1VvYmcvUndLODRwRllBcnVLd0s1S3RqR09idGM2cW1wUjBIdE1L?=
 =?utf-8?B?bWs3YU5oZW56a2RTaE1nZGVNWTF0NkpDZXRxM1J5dzlIYTlGSG1kWU9zK1Vi?=
 =?utf-8?B?TXk4OG5YWmI5UEdkQ1l4ZWIyK0tacHcxVFc5VW10ancvV1k5M25xcFhocWFV?=
 =?utf-8?B?aEVWVXkvZkU5akdIU3RvWlB1RmFwaS9tOHBGZ2VKZFNRSnZ0RXIrbnJOU0Vn?=
 =?utf-8?B?OVFwdlYrNXV1Qk9OYkJmWUdFZ2M1eExJQ2NQa1Y5b3MwQ0xpM0o4Tk1rUXVh?=
 =?utf-8?B?RHFZYjJNYy9BdnByeGlzckN0WTYyZzdMV0ZwQnB3bVNsS3IxY3Y0NTdLMXQz?=
 =?utf-8?B?U0pwMlpEL0l1d3QzRmJGc1d5T3g5cnpVb0d1QkQwM0RMcTdYS0JzNmpHbjlZ?=
 =?utf-8?B?Nzh0V20yQk9SSDhIbnlnWWJuMnJVczE0M0QxMkcwT09GdDlMZjBad2JTRHVZ?=
 =?utf-8?Q?bLC5F8UyGns=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR01MB8464.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEJ6a2NxQVlWNHQxREZuWkVRMnpiU0Z6MkRuWWFTZ2RyanBVbnkxV2k3Y2pE?=
 =?utf-8?B?ZmlzOG1pY1htVElJSnRjWjAxZ1FkZmlSWmxqSnVHWmZPWG1kdHlsUDRMQ0c1?=
 =?utf-8?B?YlFxSmdWRE9qaDZKQm1naFlXQStzaUJLeG1LL1FOcTBrWVFPZ1FHNWd3cG9L?=
 =?utf-8?B?M2VrZ2ZTRktpRjFJQTM3eDZLdGVPNDhFYTg4dmdKaFZic0FkZ2pUamZUS1lu?=
 =?utf-8?B?R0FMOWFERjdlVFZPYWtSckp0QW9VaEd0cDlLNENGMzZhOEJnQjN6YUgwQ29k?=
 =?utf-8?B?bmo1RWZPZ3YxTTVMZFZsT3d6K05zQ05NdmttclRjQk1HdVlua0hmSU1mZUFO?=
 =?utf-8?B?eGxQQWQrcHY1Y1NST3U3WGZkamJWWld6bnNGUXdFaGUyWHhCWXJ5aGovLzdi?=
 =?utf-8?B?N3FEZWZFTlNtMzZXYW5ZU3Fla2prK3dTOEtDQmFkQWJqOUluTE9mS0xUd2NC?=
 =?utf-8?B?bUFNR0FlN1NiWEhDb0krdnF2S3B3V3hYVVVXbkwrY1lHOE1iS1MxZmVRckZW?=
 =?utf-8?B?OUlPUk9adXFpbEJHUU9sMERtZldmV1hQUXQ4ejFKUHFyRS9wNWNuR05ueEFQ?=
 =?utf-8?B?V1M0Z3M4eElYRHNkUWZWVkYyOCtiK21qeVFwbDlnanN1QXAyaGEyRlBhUHJn?=
 =?utf-8?B?bVk1TDYrVms3NXVQRXc0ejBjVHNrbTBpbWFCZkplN090WVl0RGxXNndtNWtn?=
 =?utf-8?B?SU1TV2pSRHhvUURpTVVXSVh6U3o1WW9YWVhuMU1xVW00aU9vd01GdzJ0cEhy?=
 =?utf-8?B?Z21KMVlRTjdRS09IZ1BkM05mcVJDZFhXOVp1dDIrSFV0T2d4QTV6T3MyRDRt?=
 =?utf-8?B?SVpTVXJYdk1Sc0xNaU5ibUZCbDNpZEI3N3kvZi9rMmk1OVdLMmRjVkk4dUlu?=
 =?utf-8?B?SVFmdlNhN1phbStkeS91d2JnNW53U2t6QlRTay84bFVXeGhtMmpTQXdGbFQz?=
 =?utf-8?B?S1dUNWxaOElQMVV0OXlGejJ3YVBVcDNFbTRLdXkzbzlTQzVtb081Y2lXSnd1?=
 =?utf-8?B?QThBQS9KQys3ek14ZUNPQVZXQTFSV1lxdlEvYUxFRDlmWW50OWV4b0JObGVO?=
 =?utf-8?B?VjNJYUEzeVZLZkx5VG9CcTFMa2NyeTB1M1hXUVg2NWQ0NWVPWHh4amJRdFFz?=
 =?utf-8?B?QncvMXpJdWZzZEJvSW5ZOTk3Zk5iSjczNytJT2lPY0NaM1FMTWdicE1IUkcr?=
 =?utf-8?B?VlBlYjZaK2MxcnpEclN2SUNkWjV5TXpnRk5hcTh4VVRMbWdaMzlQNVVYU2Vt?=
 =?utf-8?B?Zy9wcEpVYzREZVQrOXpmT2EvOHd2bFU0NE5iYVFONlFlaHFnYUVDYVVkT3RB?=
 =?utf-8?B?QmxtaUJYNFFWWmZGcmVFaW5QVCtLTzl2bU85ZjNqQVVzQjZKWlVibEp6ZUZX?=
 =?utf-8?B?bGR0S0x5WmduUG14bnFETlpPckJuWEpWMm5KSm5aeStLaktwQU9mdHhSaDd5?=
 =?utf-8?B?N0d4bnZvc3VOemJnUkRNcE95a2hNRnU5akJZM1UxUnBHMlVkL2Evbll1YVk4?=
 =?utf-8?B?bWdDb2g3SUtGYVRKeWtpUkN1M3p6R2l3U2VvM3Z6ZGd0VnZpZGJTeTZhTXN1?=
 =?utf-8?B?ckIxbkJub1ZTc2VGSEhNWnE0dGZGTzJQWjFZTk9uNWU4ZGhaUTFUVFVQVkpv?=
 =?utf-8?B?VzdVY2lEclF2em1MeW1ab2pTSmp1TXFJOXFKaUlZV2V3U1ZlTmNsUFduOG96?=
 =?utf-8?B?ZjhiODVqa2labHJZSjhETzRHaVRvQVJ4Qk1wa2lQQ2xhWXJhbk1VWWRFVzkx?=
 =?utf-8?B?OFlSVldEWmdKQU55MDBBa2lWWTA1Ulk0TWRMc3JNVEx5U0tDNmNPU1dPUitR?=
 =?utf-8?B?emFCdGhzVWNDSmNKVVFkT0tyT1hXbW9BTk90VlJBQmdBeisxNTArRm9hdnY4?=
 =?utf-8?B?bFBqc05EdEFGM2FydFR1aTMwOWJ5S01rTDZ1eFdZL3MxT2hwVEFiMTQzR0th?=
 =?utf-8?B?MVVINWtGUWdGV2JVSTYxQzN0MzJZR21YNFp3QmtxMUN0RjNjck8yNmErWUxx?=
 =?utf-8?B?VFZzV3Z0dGNJNWxJYytOYWZaWjF0aEpEOWwzT2tEZWZlWldXNkFXK1hKTDZt?=
 =?utf-8?B?WXE3eldUUWFTbWVIek9iYVd4alBCREN3dTRWdTFZL1Y4eDhvVUpJSE4xS2dI?=
 =?utf-8?B?MEhTOUpZb3ZzcnZROTZ4UUpsdXNqMVVnMTI1dHNpbkFMY1Vxcm9JVlZEOE1v?=
 =?utf-8?Q?foxT54lnmT+3JJiotT3OMCc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ef031f-098b-43e8-0677-08ddc95b5eda
X-MS-Exchange-CrossTenant-AuthSource: LV3PR01MB8464.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 20:07:22.9856 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qcsfC6X/ft2ospJfdLrfciI92Dtan4VDsPx0yYRbbv0PBPoOOwPKf4u2HXXLqX6kT9cy8zb8dASTQNvBcXl2ZzzULYA5CSMaNivy46zZFMNwIVncUJbnTAVNohwYbDzN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB6954
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

Ping to make sure people saw this patch since it's been a few days.


-- 
Rebecca Cran


On 7/17/2025 10:15 AM, Rebecca Cran wrote:
> The uart11 reg address was a copy of the value for uart10.
> Update it to the correct value.
>
> Signed-off-by: Rebecca Cran <rebecca@os.amperecomputing.com>
> ---
>   arch/arm/dts/ast2600.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/dts/ast2600.dtsi b/arch/arm/dts/ast2600.dtsi
> index cb8ce8b6b6f..a048951fa18 100644
> --- a/arch/arm/dts/ast2600.dtsi
> +++ b/arch/arm/dts/ast2600.dtsi
> @@ -794,7 +794,7 @@
>   
>   			uart11: serial@1e790500 {
>   				compatible = "ns16550a";
> -				reg = <0x1e790400 0x20>;
> +				reg = <0x1e790500 0x20>;
>   				reg-shift = <2>;
>   				interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
>   				clocks = <&scu ASPEED_CLK_GATE_UART11CLK>;
