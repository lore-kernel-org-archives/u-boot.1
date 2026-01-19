Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7ABCCF2D2
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 09:31:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62EB68397D;
	Mon, 19 Jan 2026 10:30:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="KSWlYr7G";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KSWlYr7G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A56A483966; Mon, 19 Jan 2026 10:30:42 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47AB88389A
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 10:30:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=PGkdQG1m/43Po4uiXua8SCmnSN4aVaKWeYd9jlb60Wo43bTJdLctmT0mx1WgnwdHX9o6CWkse8EXIBQzHfN70qCFAXQOiQqpNbsFBYnQQOh9gqREKqTwfB8etml0HHGkWHbrjvJHRLq6RBA5fIM7hDCIyIAvtSLOlbJUj0GOSnVsY/EY6oLFRKmcCa7FrJ+lBOJJCzTcT/UT7avoEjuYs+Ss94GExU7pwQQeE4FK/uoBDAQUtZiI02uwHoqUCKon7HxCdUfdALB8hoRZtrUXGu/w4mSoHhNxXVmEGw1elpc/SqQRMWpmA5OWQt4wliJ0fz3yqbDIYB3SIYK9dgd4Sg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gi5l5qi/7ktfXpE+WSRs9ynKXLM6b29s16WWXLp/LyA=;
 b=nYOshHhzaAMry7XU0KYtF2kEGTv9Zml+NNgdqfw2AoGRIT+EpE6V/2N8ivyQQIusknJZpnw6qB/erpcQ6kZ+gJzznkzQoYvReR1VLJ1yQYDwdnNnYeFWaVBplpPZjK3XwxG1o+JPdNZ6znyFyQn0msjQ3tqNmeWuOT6iVNV5nyWRxp1zYwNi9W1Eid8nyPxUaUHQzaxbAdp8cqDTaBqQxRFwmkSHuGThSVEYPJOQadz17cp9dVhjeJm2r9teoRWiQnUIMHbZxEGtLMo4bF+YCavorx1KezCLQT0F6TeqPUFdFSrcwMirAZjyAR+gFR2HWC3BVvG7Xi5VrL0DvXn0Mw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=forissier.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gi5l5qi/7ktfXpE+WSRs9ynKXLM6b29s16WWXLp/LyA=;
 b=KSWlYr7GL6wQzkjuNlBYF3rBHioQMyUsD2IdcSrAX+N7AVrZLehQDSZtK2GGT4YtEH+U2dsXoisgd+qogGFO/E7XsDyuUNIvEXi7qJEq1z6dcGgAm/CGcfasa8de15DIujcqDvowTSmdHraMwhRV1AmTMAJtPkRFCTR4adchvSo=
Received: from AS9PR06CA0297.eurprd06.prod.outlook.com (2603:10a6:20b:45a::35)
 by AS8PR08MB8900.eurprd08.prod.outlook.com (2603:10a6:20b:5b5::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 09:30:30 +0000
Received: from AM3PEPF0000A78F.eurprd04.prod.outlook.com
 (2603:10a6:20b:45a:cafe::90) by AS9PR06CA0297.outlook.office365.com
 (2603:10a6:20b:45a::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 09:30:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF0000A78F.mail.protection.outlook.com (10.167.16.118) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Mon, 19 Jan 2026 09:30:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQwZ4rnFrho/jDCNUJcHnNdNLEx08WhERJpOA9y8vMb/+MyspFdW+J74sSQx4FJugrY3y90FKkKOs7hVlVELmQQDfsrPgH/K+P0BG+FlqI6aZZBsvA1WZbtwbEj4ndC1rFNII9fo4/ES+0GumxBfEtsEHtRP4bWIyoVS6TiHA//MfOyQmGq2yJYWy8O84/qqCnU14vuVfh5XH2a2mbkdQJEbeeuAymtf2UoqK3D2pQScFZhU9eVQNUBjRSmQLs5a/+ZV7vyU+lAXD32Z6oCJ4gfdsZRKtD6hmKVGTFFwnLyzD7PeuBD1BBnnn+WW0QaHEkVbadpUgTtCweSRa4ZQIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gi5l5qi/7ktfXpE+WSRs9ynKXLM6b29s16WWXLp/LyA=;
 b=f+aPvadJwbCY/m3FjpNijALL0LJ3rwiVgFLTj6U56XLWAed+b17EWYHn5VV4MEK8vhX3qShNB6IwXpewiFKcpHHIvhRRsVmO9LAY8MeSu5YNGnc8kQLeLsXQqZ+k3mgLD4uQ2Ss+MpSnRt1qHZD5LGUSB6OWDsANOJAAMm/JiutPxNjo19fk6/J84uuUjk92L7gkQcyFMZnK7Rbfy9G+bP/Edc6YGgp8w29byb01O+wCFEIeGHoql7KFpZw3sAeZcmN+AjN0u53OjAiAtZBkW4eQLe2QoG0gkvAGiGl/RI3EqhnPn4NfzYPkLBCYyZLTwYlUkJ1NIKCq6Rq09P3qgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gi5l5qi/7ktfXpE+WSRs9ynKXLM6b29s16WWXLp/LyA=;
 b=KSWlYr7GL6wQzkjuNlBYF3rBHioQMyUsD2IdcSrAX+N7AVrZLehQDSZtK2GGT4YtEH+U2dsXoisgd+qogGFO/E7XsDyuUNIvEXi7qJEq1z6dcGgAm/CGcfasa8de15DIujcqDvowTSmdHraMwhRV1AmTMAJtPkRFCTR4adchvSo=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AS8PR08MB6038.eurprd08.prod.outlook.com
 (2603:10a6:20b:23f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 09:17:42 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%5]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 09:17:42 +0000
Message-ID: <84fd00aa-a744-4a41-8387-facb4efee208@arm.com>
Date: Mon, 19 Jan 2026 10:17:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] net: lwip: nfs: Prefer nfsserverip over serverip when
 set
To: Jonas Karlman <jonas@kwiboo.se>, Jerome Forissier <jerome@forissier.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, nd@arm.com
References: <20260117002452.1026310-1-jonas@kwiboo.se>
 <20260117002452.1026310-7-jonas@kwiboo.se>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260117002452.1026310-7-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0202.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::8) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AS8PR08MB6038:EE_|AM3PEPF0000A78F:EE_|AS8PR08MB8900:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fd06bf7-8f20-46a8-c14d-08de573d631f
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?Qlk1ZnFyZGM0Ym15MUlsTEdwTWZUWmUvY1c5Nit3UzdzMWVwc3VVbEdRcERC?=
 =?utf-8?B?S2dMaDhZYXZ6alhOZUx2T05ua09IVGlIV3JYa2NtVVRHcHphWnZhNk0vL3F1?=
 =?utf-8?B?b1I3Mjh6alhDVktkdVpCV3FweCtRdkFOb2pRU2F1ZnM3RGpad3ExbEFkVzFW?=
 =?utf-8?B?SzBxQWRqY0pPTDZQUjhGOGFKNi8vczl0Mm9BTWJtUUJqZ2VRZHVibDdGa0RL?=
 =?utf-8?B?WXpuT1pPR1pYdyt5UjBpQytTUlJFcU55QTgyYTVob2h1R29WWnpuS0lhQ2Ew?=
 =?utf-8?B?cjRPT2JnMCt4VlI2Si9uZTV3ZkNoN29nTnR3VDdSVHcrdXQ2SjNmbnpiUWFV?=
 =?utf-8?B?MzR4WEtjMHB2ZDBOcmxiQlJHWGxJQTZnUjRtWlRsaXhMWUs1c2I1U1crMXl6?=
 =?utf-8?B?Y2lNa2xpMkJMcUZwVUo1dVZCdTNmek9Pb2tKUzBYalhMOVBBOWFwNlB6b1Ex?=
 =?utf-8?B?YVI5WnRkcGtYL3NtRUxSOC9pK2JSOEc3Z1BrNjBLQlZaenhrdTFOOHRoZGVM?=
 =?utf-8?B?L3JNVnZZUSttM0F2a1YvQThRN0pzV2d4UDdCTlcrWkJucmlBVmFuRXdUcW5I?=
 =?utf-8?B?ai9yVndIand5K2d6L2hSUE9XOXRpU2EyclptQll4eWt2V0FrcmlwVHV0amZD?=
 =?utf-8?B?WWdMM29oVFlVWUtXeTdlbFhxa2VlOG00cUwwdk8vTFRQVXg1T05UcjBKTzF0?=
 =?utf-8?B?ZWFLTUZpam5oTkhGUk5JdVc4VzBpZlpPRmJQWnZ0TmxTNXRHWTdrbXFTUjZK?=
 =?utf-8?B?Si9mTTlaUzI2cjhMK01nSkpCOHk1emtPQ3F0em9tam05R2FHamE4UWlnUzJR?=
 =?utf-8?B?WEcrd2YwOVQxWGtXTGZBVkVTQ1VjL0N4NHdsMUNmRk82aCtlbUpxRWhqeldF?=
 =?utf-8?B?Tmd4Q3NWZXIxS0xaT3I0OEdGc2E3U1Ntc2pYbTFreHJXczZJNnlyanBXVEhi?=
 =?utf-8?B?d051K2twaVNDR1NXWk00TzZLM21OT2tSRDlKeXd0aWY2TmczOFNMNm5qQUdn?=
 =?utf-8?B?Y1Vub2YxMWdUVGtrQzlZTHB2ZWtGN21HZ2tzT1BGSW40TWVQZ2JKYmdzWjJW?=
 =?utf-8?B?MUlxSXJMRXJtMERGTWsycnF4ekVhekJqNG1Zb2hFeGhRQzJvY2JwUHh5elJP?=
 =?utf-8?B?NE9vS2gyNXlvSjJLT2NxVjlGTWV2eDE5RVBQN05BbnE4L1JKSmJnRFJIZTVG?=
 =?utf-8?B?RVlnSnFUeUtta3F6T3RUOVh3RXVIbGxyZmNSTTJUS3R4dk0wZ3czemFubmhS?=
 =?utf-8?B?UUc1Z3FYZGk5eGJVbUw4UEp5cGJDQnNGVFVzQWdXdGd5UThZdk1kYTd0RE5V?=
 =?utf-8?B?a0RLZHJqMkNrSlVoYS95bm1CdWdPNWlicHNBMzQzV3I4MkVGUkxKV001OVBE?=
 =?utf-8?B?aWZPdGlLQTdGZklRWjVFNGw0ajRaNW43dEdJT3NrTVh2NnBQWFhtWlJ2dzFr?=
 =?utf-8?B?NkVlUndCVTBCaUZJc0VMNlU2NlRtMUd6SlBZcGI2N091U3dhS3Azc09lR1dr?=
 =?utf-8?B?MXFEY0lNQVVta2RCczRTbkRIY1ZEbHRYNG9wR2RUdzFFNFg2aGF2d0ZZaTVZ?=
 =?utf-8?B?YTFKOCtRZWNJa0xkZmpMaE5hZHFpOFBDYXI5QlNYMjdKV0t6REtqcm8xZW1o?=
 =?utf-8?B?RVlyeERNT05EUDc5Sy9NbThOOXZIMkVwOFplSzBOUEx3QlFGQ0dOYWl5eWRY?=
 =?utf-8?B?NWp2eG4rYjRmOU1pVzFkWFBrbmtxTFUxTWRqNmxxa0I2OG5FVUU5a2FId0ky?=
 =?utf-8?B?K3ArbHFCQTh0czg1bjh3S0R6SjFNczQzamtZdWNYTlJ1UFduQ2RTSnM5dmgz?=
 =?utf-8?B?QTNkYmE2dEtiNGJONEM4VDZaNzMycHhvSm5SalJvSko2MFlxbFMwT2dMNUMr?=
 =?utf-8?B?aGxYWU9Bb0pZVnQ2Y2FlanpBZ3l4aHVDUldTbEFiUG5yUkdDaG9vcFJ4ZEJh?=
 =?utf-8?B?S0IzR1Q0ZEhOQ29lUE9GWXlkOUVNeCszcVoxSTlKNXArUHpaamdHajVDdVVE?=
 =?utf-8?B?a3IwcEdTbUZjQ3RETU9rbkVKbitxWWRyVjdhWk9kV1FHZXQwUTFsUFh6d0lk?=
 =?utf-8?B?NHdKMTRScWZYU1REL04xa0Z5QVBvMGNBeWQrQmhKczZxTXA3QVk3Z1NNKzBB?=
 =?utf-8?Q?9lUI=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6038
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF0000A78F.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: d7462279-5df3-4023-3690-08de573b99c7
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|14060799003|36860700013|35042699022|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cXJ2SnowbXFoTW02VmFqdFcxZmNFKyt4eUhXOGh1VFBBTDZaZlRJV21Yc0sy?=
 =?utf-8?B?UEhCWkxUek9PY3dzNzhqZFR4SVhreE9ZSnB3cnBKYkVURHRxb2UveE11MndR?=
 =?utf-8?B?aVVlNmRveDhUSWl1YmhTc3lmVFNaSFRaemhBSUpKcStYdE9tZE82L0pFcTVi?=
 =?utf-8?B?S2ZWVE9UYVpEUHVIYTg2VUd1WlJsd2NEMUtBZUVnSFIvNUUyQUpRdmVnZ3dK?=
 =?utf-8?B?YTVXc2MwdWtIUW5aZnVxN3NVZkx6YSt4bWFoY014Mmp3U3Ura3kxYm9DTVJ0?=
 =?utf-8?B?RU5qaGJEc01DTFZkSFhwN1VySlFTeUFja0o3bGtOVFB4d3JXZmFMalAyU29y?=
 =?utf-8?B?bEVjb3VJUjBtM0FLc3dwNThzL1dZUWRiNkUxR3lQMTg1YWFNc0ZGREloM1Nr?=
 =?utf-8?B?cDN5RHhMTy8wVDAzV0tYaURYLzhxbkthSExzckFqOEh4dVN6eWM1UlRDVnBi?=
 =?utf-8?B?TnNWT0J1MUR5NHEzTDI1eERPT2FFMlplN0ZySjBxbnJPa2pCOWJiSFlVekFa?=
 =?utf-8?B?QWFtbjlXY1NJbnJYV0NDb1pOTUdhWUVjLytYcWhxOUd2VS9LVzJXcE5SbFdV?=
 =?utf-8?B?ZUlXck56Tzl0WkdJczlVYzE2b3FJQ0RGMzd2VVhTdXNpOEVvU0d5aDRLelZt?=
 =?utf-8?B?QnpzZUtZVTNBQk1EUDV6c2NERzZsTndlNm9LN3NZelU1a0tSRlRXYmdKRVZi?=
 =?utf-8?B?azRMUnVrU3czVlg4cHFVZkpiNmpJeFpoSkJZUW5BWmhWTTRQcFFGVUxTcjJi?=
 =?utf-8?B?b2JVNUhKSE1WQTRyTjR5U042ZnE2djZZUm1Ea2IyOU9pSU5sUDRNNG1IL3ZH?=
 =?utf-8?B?cXdaSC9YU2daOTd5ZjUzTkhKMVBOaTRBV0hLd1VJM3JGa3dmUlg4bERZRWRP?=
 =?utf-8?B?V2dJamJoMGJzbXhpMWJMWVNwak5XTnVDN3g2MVE5a0QxelJ0eVd0aXlmb2dR?=
 =?utf-8?B?M3gvenpEOGRKY2pzdHdaREFVeHBqbFFLbHdjM1lmeVZWZm5rQ0ZmWTNvb0tG?=
 =?utf-8?B?aVAyR096Znk1Yk1vdkRvT1VoM25NOFUrUHA0SGExTzBacVFhdnJqaXlqZVVR?=
 =?utf-8?B?elczUWhnanNsc1QxejZLcWJ6Zm9QSGRzV3diUDBvUHYzUERiS2laUWdrZ212?=
 =?utf-8?B?VVNMR0IvT0VmVXY5Z2RSNmNtWER0YnBPaTB4N3ZkVTN5ZlZSRnVydGtiMW5y?=
 =?utf-8?B?NnlJOERGOXZ1TjU3T0c0OHE5RU96Y2lscnpCZStVaG9HMjZtWlRmMjdiWlBt?=
 =?utf-8?B?NzFseHBMNGJtWGhWSnJqNDU2UndxVVkxL014Y2ZLdHQ4UVFHSGRQV2dMd0NR?=
 =?utf-8?B?ZmZkckVHbTk2Wlp2QWhzaGErVEhkczl2VVcybVVwVzl3WHBWNGZVK0ZvdDgz?=
 =?utf-8?B?TGhXZU9LcUVWcFVFQzFZU040TVpualFieTNwcCs0UG5CY0o5bnc3ZHdyVzBN?=
 =?utf-8?B?WWdLMGsyY3B1Z1pwSHFaa3JHM09TblV6VXMyVUZvNXJJMWplKzdMVThkYXc2?=
 =?utf-8?B?bm1yYmVJNWdkUWdaam5HV1MzWVJycEZPRUJDamgvUnBTYWhNV3FvQndXY0x1?=
 =?utf-8?B?Zng4UnRnSERCdWxxUmVCem1YbWFRT3BWeXBTSEtUM3JvYVNrSEh0SkhzaFhI?=
 =?utf-8?B?blBCQUhLTGlXUENPTkFpK1Q2dW02SE1LRzhnQ1gxOXFmTGQ0UGdKVEIrMEVa?=
 =?utf-8?B?VHZMT0tkVlJBWUVnQUpQWFNmd1ZPYXFOMThUbjVuOG1NZ2xvcGJha3lFTGx2?=
 =?utf-8?B?aE5DbVpMa1lraDlpMEdTS0drYmVpUExsK21RUmcvd29Db0FhOTRpN25jVys0?=
 =?utf-8?B?YitHQXZvNDEvWkFEdVQzYmM3OWtrR0l3RlU0SGgxZ2xYeTBJdUtMamdGSnZB?=
 =?utf-8?B?VzJkQkcxd2ZrU1Y5ZnZScm9XNlBYODBpbWtEVjV3bzJkTys4TEtTRkJIbTB5?=
 =?utf-8?B?b2tQYnBQbUt3WUVDV2VUK0JRbnMwZ3ZqbWdFb1Bhc09EQVdiczBTdDI2K09W?=
 =?utf-8?B?c2VBWHFBUjA0TnBldGZaZU1xVkd6NW9kdTQxQXplLzNKOE0vRzNveXI5V2VT?=
 =?utf-8?B?SEc0T0o5T0tXczdva0dHZU9aM1I5UTlSYXpSblVjbW1iZVppdW5DVVk0VkpK?=
 =?utf-8?B?MU1xbWRkaGpoL0NMRjdZZFZodGVyYnRkK0RUKzVjc01tcytLbWE5ZHBUZWVX?=
 =?utf-8?B?Ry9Ldkc3a0VKZFlzbmRoRVE0eXdlOHZoZ05GdTZLeG1OZWV2NHBCdmFwdGZo?=
 =?utf-8?B?MWxPRFBYT3JGcURWT0h4bnZUM0FnPT0=?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(14060799003)(36860700013)(35042699022)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 09:30:29.9819 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd06bf7-8f20-46a8-c14d-08de573d631f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A78F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8900
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

On 17/01/2026 01:24, Jonas Karlman wrote:
> Prefer use of a 'nfsserverip' env var before falling back to 'serverip'
> when using the nfs command. Similar to how the 'tftpserverip' env var
> is preferred over 'serverip' by the tftp command.
> 
> This also updates the error message to closer match the error message
> used by the lwIP tftp command when a server ip is not set.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  net/lwip/nfs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/lwip/nfs.c b/net/lwip/nfs.c
> index 1812bbda68e5..c3b819a091ec 100644
> --- a/net/lwip/nfs.c
> +++ b/net/lwip/nfs.c
> @@ -247,10 +247,12 @@ int do_nfs(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  		}
>  	}
>  
> +	if (!server_ip)
> +		server_ip = env_get("nfsserverip");
>  	if (!server_ip)
>  		server_ip = env_get("serverip");
>  	if (!server_ip) {
> -		log_err("*** ERROR: 'serverip' not set\n");
> +		log_err("error: nfsserverip/serverip not set\n");
>  		ret = CMD_RET_FAILURE;
>  		goto out;
>  	}

Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>

Thanks,
-- 
Jerome
