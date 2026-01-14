Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83FB9D39003
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 18:01:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B602383655;
	Wed, 14 Jan 2026 19:01:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="D7tp6R//";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="D7tp6R//";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AAB382C7F; Wed, 14 Jan 2026 16:21:03 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8970E80325
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 16:20:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=S1Efzbwf6CeOlK55D9OHibYgxzTNDytVj4vEIEMMQ11q30mXLuf0c9Mf18wPecDtX6gWvB0ARr3qoDQLhu1UZTrfNCwuicYuCxY5xupmvZyHTe7pkfUnzSvH+aHHwGfmOifdh0ihfRP2v6es8P/6chxBWOOtpXFM0sXbzNS5uOb0VcoIDzUQn7gyzQNG/aWbIM47i03KSDlI6Nvqa4MNSOJW/aK5WWiC7kZW1xmx64MjDJHp2CLpRDvJT+mDWUqn8Qb5KEMGyL2v6QWIr2yvgAWG3jwl/elQdMdj4v3scikEy3TRM/Xc9eT8QS2PE+AXvR0IE3lTMORiIZPcbchVZQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ua3qRUGw54MsUs7SKsyoeUUmr2K8MptFstVagdX+9zE=;
 b=hXKgU7yU91/QSewlX6mE3+fhXxZchSPOzMkhJ8a0Z7PHly3QUTeVTm0GrRjEKCLLIJFzqoIDM3lu1qVokbhiVDt2ZbVVQuSXUzjlbkHNjMuP7W0eOUypBPv411s5yiPY869kShg5NvRJYWEa+elAHrQLJ64bx0tDnrINibyQv3JBWbEe/bg9VPrUFLN3peOj6b7QV/8x2LYNEm11VHqxEhOuQzEFQx1i2RddnLgZ/Zz9gx9uTwx9gcow+r/XCCX0C6CIBp5av/YSI8IHmg7SHA1fwz1ButGPKxbAZ4AZWZYY6bcezg4iwaRMEDaO6YnzKd+nYlE2D2RraMkxSf7bNQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ua3qRUGw54MsUs7SKsyoeUUmr2K8MptFstVagdX+9zE=;
 b=D7tp6R//BbDXvcgSF5P30Ny4cKmveZTKRmX/fWal6sMf+VFS9EHFsEMXhulKRE99Wwvo2SzgcSE1RTuEokkYX4vCDE5S/bC4EVNf548GOj5CZoAjFzx6fpAjt5ulkxu4WIIOqoL6qLK3lAm5vMly/5hDKrKsWab4qn/oKpI70VY=
Received: from AS9PR06CA0004.eurprd06.prod.outlook.com (2603:10a6:20b:462::20)
 by PAXPR08MB7646.eurprd08.prod.outlook.com (2603:10a6:102:241::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 15:20:56 +0000
Received: from AMS1EPF00000040.eurprd04.prod.outlook.com
 (2603:10a6:20b:462:cafe::79) by AS9PR06CA0004.outlook.office365.com
 (2603:10a6:20b:462::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Wed,
 14 Jan 2026 15:20:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF00000040.mail.protection.outlook.com (10.167.16.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1
 via Frontend Transport; Wed, 14 Jan 2026 15:20:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ABIFxHzblrUuV9SLBd02SbnBxRlAMvIko5xYRiZ4p8e6dCANxf/FrCTSeXZAFxf2nP3Jgbt8ruUsP+TGJytxwUvlKxefku+0nLWoZZK0/nyt+WQhgzTH5QmlJqo85I+Eu/ZH0O8JV5r7VyICT5+H5/UOp9BxvXD+M3uAF4GTEMYzON5TOXpnG3nMhNS+MUDxUFlqlr0myRRgA9W/nYQcaF/Wr/BUgT+HpPNkREhfr2UXyQ56jUEao7GsOMVvlsQIdPymjSFX+SooNJyfPSxV6lwpSZBg60baJuM6BeeVGHcPQFmhQFuhTApfjHoLzLMDEy1Y0NgOnRPb2oS7mV49OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ua3qRUGw54MsUs7SKsyoeUUmr2K8MptFstVagdX+9zE=;
 b=KOIX9WV0xDTAplXO5CP8zrwdrblwLZqWkkHNNNrTpsUtnuatD/nMOrBboC+p1MXCGPobuMotTy0qb6Jo1irL8ggTKpkV7uk1bvH4qOi8ehguRG0P2arw9b/ONo5zgmQ3JtEhEU+txclH56Jwy4PydUVspaFVWs9B4UD1+tItzgeHg88oh78XA/01EKD5hr44alTftHGUBQYBSiTgAjKrpbRnOyLo/ZrrIICVITRCOcRbpBIbVPsG6UwtBpiyKzRNkjzKOyXHfYmTgNeUG3AxhTtvqjFMclnvfLPPc6R5hRTVpgZK8p5NO9+G3gnSW+aROev0656DgG5h7vE30clv3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ua3qRUGw54MsUs7SKsyoeUUmr2K8MptFstVagdX+9zE=;
 b=D7tp6R//BbDXvcgSF5P30Ny4cKmveZTKRmX/fWal6sMf+VFS9EHFsEMXhulKRE99Wwvo2SzgcSE1RTuEokkYX4vCDE5S/bC4EVNf548GOj5CZoAjFzx6fpAjt5ulkxu4WIIOqoL6qLK3lAm5vMly/5hDKrKsWab4qn/oKpI70VY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AM8PR08MB6449.eurprd08.prod.outlook.com
 (2603:10a6:20b:364::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 15:19:49 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%5]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 15:19:49 +0000
Message-ID: <c3e65d1c-0f49-4bff-bc50-a6cb52640f55@arm.com>
Date: Wed, 14 Jan 2026 16:18:35 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: [PATCH] MAINTAINERS: update my email address
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0398.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::7) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AM8PR08MB6449:EE_|AMS1EPF00000040:EE_|PAXPR08MB7646:EE_
X-MS-Office365-Filtering-Correlation-Id: cb5ddbfb-d6f0-4cd8-7057-08de538083eb
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|13003099007; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?a25qVHpiTnpoelZXTzhyRmF2QnZUaldpMmRpbXlWS2hHdEc5WG9kTTllVGNN?=
 =?utf-8?B?Z0ZnTlM1ZlZrc2lITzVoM2hkNWR4RXlTR0FwYUQyLzA5aHRZVkRjMXRWemNj?=
 =?utf-8?B?bmNYU2h0TDZzeUczMzhyYTBtMW40RnB1RzJoUTdNWVAvZUV0STNNa004VUgr?=
 =?utf-8?B?N1ZVelF4S3JraXFzaU03cHNkajlCT09aQzhUZFNveXRUdkFnWnQwMzRNc2xW?=
 =?utf-8?B?dTMwWUE4Nkp4bWVMQW9VaFNGdm56VjlJT2d4NU9tWjZyVURQdURLcWt4VjRO?=
 =?utf-8?B?djVMV0wrMFZtQ3UvcGdFSFRvTHBRSWx5L0tPUTc5SEgwYkw2MWN3SXpxV1RJ?=
 =?utf-8?B?Ync5QW53MnV2STUxaTk4c2l5bU5KdVgvOG5wN0N3UjAxNXpXODhiR0htbDdL?=
 =?utf-8?B?ZTNhSHZpU1c0OVF1bGRqbjZTOTl3MWJDOW5OMHRlQUo3UWdhZU1WTDJaczlt?=
 =?utf-8?B?N1dXcExMZGIwdXd0aktDTmR6eUpJR0VGUGJmSjB2VVk3N0VCdVNieGs3aFNQ?=
 =?utf-8?B?VnY5MUlFbmsxYUNQOFM2NjR5OHh3Wi9kTjhscE5VUG00N0ZHZThvenRwYkVN?=
 =?utf-8?B?UkVaNCtlRm03bkhaNy9SYVRhT2Y4N3AyNXcwVHE3aWdkMHlkbklTcCt5RkYy?=
 =?utf-8?B?RDM2bFAxSUFXUDQ3S2xMMXBLVFkrYVNTb0pqdnBQeDVybFU1OXY5RWJiUEov?=
 =?utf-8?B?b0VWTUY1djlIejRyMmdrVDYwaG0raGRzQUQ0SGxvS0hZaUNoKzQ1TmY3eENu?=
 =?utf-8?B?VGZpbTVwTklhZG1vSnlqb2F5a2o0U2h0QWUyUEF0RVRjVWFySXRUa013elFP?=
 =?utf-8?B?dXZyQVA3dHhFSUJmUHBpZGVKTXpjV3ROMWxRc1hRQVZDcXBhUm8xRlQwWlZF?=
 =?utf-8?B?ZVFhTGllOXpQeWNBMnRrMDNhNHI3eU5lMGlEb1hYbGNsYlVCZk5oVkFKd05D?=
 =?utf-8?B?ODdqNVE4dGpNblhmUWJDRXFBVzZJWS90VC9YTjQ4OFdRQjllV3pNYi9zNy9B?=
 =?utf-8?B?cXkzdGU0czVIQ1FNc20vUm02V0VFN2R6QmJ1MVNHUFVXZDMxWHByQVR0ODlJ?=
 =?utf-8?B?SnBxZWNwZWJWUzM4aGhTTndDMnNDb0ppeEl4andnTndvd2NyZXViNTVVaTB1?=
 =?utf-8?B?TG1nenBMa1pEaVE3MzYzUEZiUGoxZktpeWF2Y3FJTFJXZ3lLTXZFZ0UzcFkx?=
 =?utf-8?B?UytRaFEyOTBzZTY5T0JQSEJYNXBUY3R3L2k5UzA5L0xCcCt2Z2EwM1NaTkVL?=
 =?utf-8?B?RVJuVTk5ZC9tMmQ5NEUrcHpWWnBwUjY4Z2FDM1ZVNmxkZUR5YllZNU4vYzE0?=
 =?utf-8?B?cldVYVkxeTdRUDdrc0tSbWY2NFJibXFPdXEvTzZmdWNPT0U3b1E2STVXNlk0?=
 =?utf-8?B?bnZTRnBHVit0RjNsWlpaWEJGaVJSUlhJNHFNM3pnOVRkRVpKbGhrVXZsdmEw?=
 =?utf-8?B?NWw3WVNGQ0VXZVBZNzZkbU44bG5DR2lrVnlmcVh4ZUk5b0FYTHpleU9CUnlm?=
 =?utf-8?B?Qm9aeXhtWkRTTkptd0VzS29pS0d2MEhwSnlFdW1McjdUdmVPTXVKMGlSZEhu?=
 =?utf-8?B?YUcvMjU5eU5PZWpodWN6Nkx4ZU94dnh2ZU0rcXFqNkl3TnU2K3YxUWxRcDF1?=
 =?utf-8?B?ek55QS92SVpmT0ZVdCtrclpoVU9kSlhDalBORE5oWmR1RTVVM2dXYWN0Nkg1?=
 =?utf-8?B?a0ZRU1ZDclZiVjFyQ0RpZWliUTNrVkJwL3BadnM5TWlMVVpOZmpYemZZSVFQ?=
 =?utf-8?B?SVorS01MLzMvalF0UDhoUDBFVzV6d2pEUHJxQ1Vpb09NOGNxQVBpRjZpTWpp?=
 =?utf-8?B?NXNwcTJIR0Yvd2k4TTVsTzVpV0tNU1ZBcThuN3RKN1FwZFc2bUIxSVZXVGYz?=
 =?utf-8?B?WGM4Q0JvTWxMcHlHWXFaSkxTdFh3ZWFFQUZjMTlnYjJUUGZYV3R6TXIxU1Jn?=
 =?utf-8?B?aXVpYTk4dHNPbFpCZ21FQWVKUmk2dHRiTERmZzhNcGI0WnlNczY2bTNrSU9W?=
 =?utf-8?B?QlRQRmErOUdTYkl6OHNJczRCd0pDaDFVMHc3OHBxMFBtTlpndlZ3aXRoUWJQ?=
 =?utf-8?Q?bhvk28?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6449
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS1EPF00000040.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 69f5dc4f-db4e-49de-7248-08de53805c02
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|14060799003|1800799024|36860700013|35042699022|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NU1tSnNlemxXYzRmaW5ZWXVPdDVuYnVXRzRTdVBuVkFiTXhSTFZZZFIxMklU?=
 =?utf-8?B?TjJNZjlNMmlnQUNORWpLWnNIUmR6aVNLay9iKzIxQnRMbWNKK2JQZWREYXV6?=
 =?utf-8?B?U1R2dFpkZzBWSVhldEF6RUtncDhjbEU3Q3pPbnlKTXY1clBHeWtFSHkwcUlF?=
 =?utf-8?B?dGZOWEhydDlsVjAxVUxsbzJsNEgyNmNwdll6QnlhNDB0VGpxTE8rdlhpV245?=
 =?utf-8?B?MERzaDdHUGkrelp4MjVMbGJUL2V2bThEaUJITHJhNGl2WXBpb1hHd0dmOGdm?=
 =?utf-8?B?cGhxYllTVWFpcEJ5a0htN0lIamVJTG1MOWZZZUovbGIra21LY0tqSkVKRnRN?=
 =?utf-8?B?TGxuM1hwaytBR25JWHV6M0p0V2gzcjNPSW1VV1IxRnkrZ3ozcU5PZzFWbUVp?=
 =?utf-8?B?RHlJZGJsZnY1aDNwK1Y4bjJ0aWkwZE1nQkt2Z1NmQWlqajNaR0prbHozclBZ?=
 =?utf-8?B?aVkwT0hGTk9hTGpUSkRLWTlYYkxaUVE4cDFKV1dwRVljVWREOGdwN2JnaDRq?=
 =?utf-8?B?d3lPc1ViVU1FR3llelQ5aVRSdFp2Q2ZPUU1VamxlKy9ZVENuUjFCQ2FwcnYw?=
 =?utf-8?B?L3lMWHdxVkIxS2RHdmFxTjNEaFVKTldlNDJpTWhhSGU1NDlqOXZLVmY2WnAr?=
 =?utf-8?B?NXF2T1h6TnQ1U1hRU2JhOE1pbmRxQkZjcnRMcllQMHhSR3k3K2tTY2JTMlB5?=
 =?utf-8?B?dE9GOCtNdDBKVDJ1WlRLZ0NycHBBbVpNalJIMEtiQnFEYk5FcHJQZ3NuckVm?=
 =?utf-8?B?MkFNRy9UdEc0V2Eya0tyN09YakY1MFVHR0J4dC83K0xYQWJtZTdBYzNjS3VJ?=
 =?utf-8?B?aFFsUTNqcTFHZDA0cmpXcXF6UnM5dnc0RjE3dHdScVNIdzRTOEdISFYrUTd4?=
 =?utf-8?B?SW1yU3lkT3ByYW5MNmtMRDg3bXBJb0VGRER2UkZvd3JhN3NuUXdOT2ZPQ3c0?=
 =?utf-8?B?V3J0d2hrcHMvTWowZnpRV3BoRWxDVDd4ZjhJN3hFbVdFT0pWTXpiaTFNNzFX?=
 =?utf-8?B?OWtzT1JZdlptQTVwckpmWG8vNm9ZWUhLWGJJRmlSbWppMzBkTHRvQVo4bHpw?=
 =?utf-8?B?RUxIT0pVeVhZZmZZdFVKdnhTbU02aGN3L2NSMmlPYW5kVVB0azkvU1crUy85?=
 =?utf-8?B?dlJNQjF4ZmJmQWNDSi9rZWg4UlZyVTU2V242UUhzbDhieTQrTklqRmNFZ09I?=
 =?utf-8?B?M05GTGV3NjJxbEUxY25WOHM0L3BzYlBLZzZHY1FsL0NIQW9rZlVUYlhDT3Fy?=
 =?utf-8?B?Q1RtN1luWEs2VmFmdDVieEUwWldPYVNKQUFDOW53YmhFYVBjQnVJNVpxWFNp?=
 =?utf-8?B?VkJ3bTVpMEthbCtFNk1Cemw1WFY5OVczVnh6VS9xUC9IYysvVE1wRytld3lH?=
 =?utf-8?B?YStoUS9lSlZGVWY0YWZTUGtLRUMxYlhCVHpmbjRMT0tqU3lHVjZLSzJNYjRq?=
 =?utf-8?B?a2dCT1JWSVo0VnFwREFZRnRLL0pRUjdiSnFKWEVLdm9YVUZtZEhGcDBuc2V3?=
 =?utf-8?B?TXQ4b3ZINlUvaGx4aUtCemllN1VOeW93WEpFUVlrV0NEWVVBT0ZxVlZiTDhY?=
 =?utf-8?B?Ym1RYU1YUEV1dHZlMTFoZWFpVDhoSlJoVW9LZUo5dHpwN2RkVTRmQzZtYjV3?=
 =?utf-8?B?aS9yMWpDVWtva0Y0ZFBudUJVQnExU0VEc25wL3pZK1I1eTY5bnI1NXMwZ0V3?=
 =?utf-8?B?Y080c09yTXJMTFRxcGFiYS9pMUovMXkyVGpPK2QwV0N6WFljdW9uZEZ4b215?=
 =?utf-8?B?eVExb0pPS1B3cVBkMkxmWTNwZ0hEeHZmT0JWUE1LL1F5dnpxTXVhdmlWSnBF?=
 =?utf-8?B?d1FlZTJQaXJrbDMvL0s4N2F0UEFiY3BDSUI0UnpUTE03UFM5ZFpwZFNadHJS?=
 =?utf-8?B?MWE3R2szVWk0ZUhTcUlFSW5hNlgrcDZLbU5GRi9HdDhwZ0cyY2RUMHZhcW10?=
 =?utf-8?B?RnpidUpuWXhtWCtKcGRuQ04wMERsM05lbGI4YlpaNE5aOHVpb0ZWOHVLK3cx?=
 =?utf-8?B?VUQ4QlIySDkwaEpEaTVYUHNvZ1E2ZFRiakJ6bklTcVNJSmVMc2NWWm1vejYx?=
 =?utf-8?B?by9oaldIbmdjTFNBVi9UdW03RTVTeXdQZTF1dkJ2VmJCSk1adzZ2UjJ0ZGNF?=
 =?utf-8?B?VEY5ZVUyeWFxbCtXOGVQMEFLMVRmWmRTczFPZnhsN0dlZzdLV09uME1waDlY?=
 =?utf-8?B?K3c9PQ==?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(14060799003)(1800799024)(36860700013)(35042699022)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 15:20:56.6930 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5ddbfb-d6f0-4cd8-7057-08de538083eb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000040.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7646
X-Mailman-Approved-At: Wed, 14 Jan 2026 19:01:40 +0100
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

I will be using my Arm email address for all contributions. Update
MAINTAINERS and .mailmap accordingly.

Signed-off-by: Jerome Forissier <jerome.forissier@arm.com>
---
 .mailmap    | 2 +-
 MAINTAINERS | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/.mailmap b/.mailmap
index 2fe12e76d0c8..0592350c37d1 100644
--- a/.mailmap
+++ b/.mailmap
@@ -69,7 +69,7 @@ Jagan Teki <jagannadha.sutradharudu-teki@xilinx.com>
 Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de> <jakob.unterwurzache=
r@theobroma-systems.com>
 Jay Buddhabhatti <jay.buddhabhatti@amd.com> <jay.buddhabhatti@xilinx.com>
 Jernej Skrabec <jernej.skrabec@gmail.com> <jernej.skrabec@siol.net>
-Jerome Forissier <jerome@forissier.org> <jerome.forissier@linaro.org>
+Jerome Forissier <jerome.forissier@arm.com> <jerome@forissier.org> <jerome=
.forissier@linaro.org>
 John Linn <john.linn@amd.com> <john.linn@xilinx.com>
 Jyotheeswar Reddy Mutthareddyvari <jyotheeswar.reddy.mutthareddyvari@amd.c=
om> <jyothee@xilinx.com>
 Jyotheeswar Reddy Mutthareddyvari <jyotheeswar.reddy.mutthareddyvari@amd.c=
om> <jyotheeswar.reddy.mutthareddyvari@xilinx.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 02310ec2c0bf..b09bde4bc3c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1444,7 +1444,7 @@ N:        mmc
 NETWORK
 M:     Joe Hershberger <joe.hershberger@ni.com>
 M:     Ramon Fried <rfried.dev@gmail.com>
-M:     Jerome Forissier <jerome@forissier.org>
+M:     Jerome Forissier <jerome@arm.com>
 S:     Maintained
 T:     git https://source.denx.de/u-boot/custodians/u-boot-net.git
 F:     drivers/net/
@@ -1452,7 +1452,7 @@ F:        include/net.h
 F:     net/

 NETWORK (LWIP)
-M:     Jerome Forissier <jerome@forissier.org>
+M:     Jerome Forissier <jerome@arm.com>
 S:     Maintained
 T:     git https://source.denx.de/u-boot/custodians/u-boot-net.git
 F:     cmd/lwip/
@@ -1904,7 +1904,7 @@ F:        drivers/usb/host/xhci*
 F:     include/usb/xhci.h

 UTHREAD
-M:     Jerome Forissier <jerome@forissier.org>
+M:     Jerome Forissier <jerome@arm.com>
 S:     Maintained
 F:     cmd/spawn.c
 F:     include/uthread.h
--
2.48.1

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
