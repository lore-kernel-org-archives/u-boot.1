Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D84CED116E2
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 14:14:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33E76845B5;
	Fri, 28 Nov 2025 15:13:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tLrgv+Sn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF9C583B8C; Fri, 28 Nov 2025 04:36:44 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 188BF83BA1
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 04:36:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZPweBY9QvZIjnX8ifutzAtT6W7hVHJltgwOuc5L2JDJn69EqDfong0N7Ta/qIfMHRsS+pm/nnjY5Tg8EExwl8KKRMae9E1QN9S2F5i/lY/PcKJHGpzYf5B23ZjY9ZGFpnfeUIaw1jf6vt5TuAotnTnaT2G0ooVWnKlmhTBRqz664Tw+5dj47tXOXQwwjQm8Nakjpya2Hg+8yTUe/wIHd7RQhJhlgW5trjIKVfRBHiwWRhBO1NRNgIbc53HzwR+IoQg1BEHO+pk+dYE32xLifgw1P8KCWR9bRd1qil4MDzkxToGVxJEZqzQBpPiQw+++CDoE0VlTN3qd8mPoYkBPsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZV3M/ZwAw7XCOKIqK4ML27i5OyqNzZC8Wwkf9SMYUk=;
 b=WWGTnOX/jKkhEm2nyR38Q4OWXf+0JDdtLo/sspBQ8/XHcvZAHy9rA7umhnUbdubZ2Pei3L/fXiw0jALN/OLAzXxK/Ad5QE0k46A6WMEuzW1OjheNG4NL+RAMXh8Xg8qouvRz95MPJniwGx9Rz6U2lbWkB6e4HBi/0r5lajHa9+LMRb8M/ozlZWBe+lox6G0g45SThY1Zseet/oIcpq9ByMyFZC6GWVCuqAK7uLyCumHfveP6VkA0Sep4APeMYNCb597qQ7sMalPTUYhkqpqzmHq0rXAxA/uNJ3XKsdazbahnlu3VMAk23M0NI6aguTGyxNqIhxOf019GZyQBvumlCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZV3M/ZwAw7XCOKIqK4ML27i5OyqNzZC8Wwkf9SMYUk=;
 b=tLrgv+SnUjvAqjY6d9OS6OuvW0t9ZBONn3sMpkz9T6ogG8mJ6aja9Cn9Wb1jUQHLO4Mx5x2HDM8n6QR9hvBwjfmF00odRixxKaVaThhE0hMzzTgs8FnwekMDZ20wX+JFLIvfPUvfTAbvymUydPbVjQGSAdJMwrH8PO7dff7ED6GtkyzJf7Wj0kRQ1GXVRlzzoAo2owyMT5irluZD+VAjnMTkFRpr2/amH5uRHcxU0xGxduLaMvjiQYlY4jkeZ9wNY7SA0evgLv5D8P5sme/Wzer8zFCyZMzrPX1cjm5uVfaNi7OKzl4eoESnCiCXa7Zt2fK1mX1FWnQke4rj3Gh41Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by DB9PR04MB11474.eurprd04.prod.outlook.com (2603:10a6:10:5de::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.16; Fri, 28 Nov
 2025 03:36:41 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 03:36:41 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Peng Fan <peng.fan@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>
Subject: Re: [PATCH] ls1043a: Stop disabling device tree relocation
Date: Fri, 28 Nov 2025 12:49:36 +0800
Message-ID: <176430530393.3808119.12034217424480466077.b4-ty@nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251119145530.843331-1-trini@konsulko.com>
References: <20251119145530.843331-1-trini@konsulko.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:3:17::36) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|DB9PR04MB11474:EE_
X-MS-Office365-Filtering-Correlation-Id: b106106b-0df6-4ef0-8d01-08de2e2f5845
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RVRyZ2NMZzlmTkFESCtvOHY4QW1hMnVKQ3QzRGdDMUdXUzdsanptRHBIaytS?=
 =?utf-8?B?WG42azZBWUFBVm9LcjRxMDBNTHhoK1FmY1FVZFR4TURPT09RaURQMThnNE1Q?=
 =?utf-8?B?YU52eXBnNFBtaHUwQVV5bWxWTUI4VFIxOHQrSDJEWGRldU95OVBiSEYyNUor?=
 =?utf-8?B?S2JRZzZyZ0ZvS1duSUhQMTNucVFSc2wvK29ZVE9sRkwraEMvemFobDhtZkVm?=
 =?utf-8?B?UlZQY0JJUlgza05zazJUL1J1Qzl4OWgvdG1heDYxUnlOVzgwN0FUUmdkVVBk?=
 =?utf-8?B?MGxBNmdNcFptRko1aUZCYUltU0lZWUVTSDNnNm9uR1pVYVFtS1dOUXJyVnMz?=
 =?utf-8?B?OHA3OWlQWlJrZ1ROcUxMOUNlRDBVVjJPSjdib2Q4ZGxiaXI0akZwaVdxK0k2?=
 =?utf-8?B?UTZMYm5PenJucHZVL3ZjSm1zT3gxK3BuQTVxWGx6ZXdqelc2NWVHNnpIdlhv?=
 =?utf-8?B?UUdsUG95UzBZOHlLSGxUT0RDeXI5dVVScmE3bDVxSUY4dDhNN1lrMlFHTmdB?=
 =?utf-8?B?aHB2R21nc1lQbHU4RnhrSG8zVEljRjdDZmZsUGhNTm9uMERsNVMyUThPQVFW?=
 =?utf-8?B?Z1RZb3FDWkV1SFJIa25NNFNmV243U2JncFQ4aGdxQUZucHY5TkFUTzcvUVBM?=
 =?utf-8?B?VkhwNDFwVm5tSXpOU3dHNjlHNVhBcXQrSHFlZlE0cXlYbmd6N050Sno5U3N4?=
 =?utf-8?B?cWV6Y3N5OStEOEVMVXJERkpnVnBLQTdzZTNqVFlLbW52eUZWcm85b3RBejgw?=
 =?utf-8?B?Qmg5OGlXazlTaU9HU25odmtHclhaQUF3S05PbnpWSWk5WkVFN0NvaVZJeHBY?=
 =?utf-8?B?aEVvUTJkbmxPN2cyQlF3OVg4NGVxK05oQlJpZE5CLzN6RXpyRGMyTzgwaFlo?=
 =?utf-8?B?OG92WW9LZ2t3UjgyMEdIeldudkZiM3hVT3F5VHVhQnBRbkpDQXNqQVRkN0Ro?=
 =?utf-8?B?Tyt4VGJZa3Zwam1ibU03ZTM3aFVqRVdUYURNbWVDODJsT3lsaHVYYndoanp5?=
 =?utf-8?B?TDB3eERMMm1IMkpaZmNlVnp2SVZWTHJGQ2Q1RVJQQlA3OXhKd3B2QnNTOE12?=
 =?utf-8?B?OCtCdG16NFAvSUZVOGQ1Q2hRVkxPL3JSYTNQKzRuOXZ5dSs4V2VvZ21odUFj?=
 =?utf-8?B?SS9wQVpMRTgxOThOOFhpTXRnaVROMWd4OEpoanpNL3pldkpkRXZ3Y2dtVjJI?=
 =?utf-8?B?eElxYTBBWlBiL2xXaWRYcVFvNjNWeVRxYjdZdEpwcDdvd1RHRk5SWWJKZS9Z?=
 =?utf-8?B?TEpVcTd1Z0tkUXZXWEc2TUFrQnJmV3Y1ckVOL3FqWHgwejFhb0J1TlFsVHBN?=
 =?utf-8?B?anIwZ3MvL1hzOHhOaTdRc2dYYXhUdjNRanpGejBaSkh4eEpVMkJ3ZGNJc3ll?=
 =?utf-8?B?Q1hKWFl0OTFWVGo1NWU2a2pEWFduU29EbXNqUkN4QU9OcDIzN1ZocnZ3cHBw?=
 =?utf-8?B?Y3VwQlVlNi94eDAwSjZ3bmdUMktWOGRSaXUrakw0d0FqaVJsS3YyOCt4TUJl?=
 =?utf-8?B?d3FqejFWeUIrWFNqTGNIVExyZm9aenhEb09lY1RmVlZyVy94bFBoSFU3cWRX?=
 =?utf-8?B?REhmemxyY1Z6bjNtYURoYnBEbnpVT2dlczlWWFc3dGNMb2puNlM0NXZzcUwv?=
 =?utf-8?B?b0lLWGdyNldsb1pxSU53ZXI5dTlLQ2ErVW9MbFBxYmhVWGNKZUdTOFdvMXhB?=
 =?utf-8?B?bnhLb2dEd2p5QUwzeDFaKzRqTGJ2VWZhdTBFdVIwelBTTXdqYmJOYkNGRzkr?=
 =?utf-8?B?YUlFalMxMDNBK254bS9JYzlJMlhDaDNLTVFnVkpta0h0cXkxM2VlVnhUd21B?=
 =?utf-8?B?SW1ZbHppS2VQck0xdGJtL2U3d0ZRdG1qaGprVEVtWXVjczA3QStYL2FmTHRG?=
 =?utf-8?B?S3c3UXVWamFJbzdUaWhQV0JKOEhBQ3VWVGZiYW43c0ZkV0VtWWcrNjRmLzBB?=
 =?utf-8?B?QlJDVFdNa0Jza1NXWC9ETzQwcWFzUURCcWpOeGdOYUpvZjFuV0xaWGRGcDZH?=
 =?utf-8?B?UDFyWkduSWxEdDRxK3VkMkFZSFRQUklZOGYrcUdCNW1DNFN1dVdsNlVDWHU0?=
 =?utf-8?Q?id3Ntf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(52116014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjlCZTV0OHZhTHdWTDFobzV1N2VLclFKbXBTcFFYOFREZm5IalM4OUxMTXh2?=
 =?utf-8?B?SHduRWhsUjZmZDV0Q1FjNTM0N0x1TlRlWWNUSDNVdGFHb1RGK2JqVWxKdnIw?=
 =?utf-8?B?VmNJdVNRSEJOajhjVVdSMnA3MVRCdXdYTTZrUlA3ZFh6a1J4TWRaZktCTkVq?=
 =?utf-8?B?c1lJT2Fvb1V4VGo2QzFxWjlWMzdDVFFyYjRVOEM1bjlFeXI5a3lLNGUwRnFx?=
 =?utf-8?B?ZjYwR2pkZHJaT0xEUUZBa0MxcVBnS1NpdXFuUFAzTVJrdnNMaGo1RDdQVUwr?=
 =?utf-8?B?ek1IR3J1QXlnUzBIVHpiM2VBeDd1a1VHWXE2dkFTeWNvSXRlQzlETndUUzZW?=
 =?utf-8?B?U1l6RWJuek5wMy8vUExMeXhkM3VvMWIzRGQ1L3pFdHN5emZEa0xESEc0cWpW?=
 =?utf-8?B?YXRHUUxZdlFQbmNXOFE3eVNqOGJKVUZpZmNOZUZVSnd6ZW9zcEFHSm1MSHVv?=
 =?utf-8?B?TEhkUGQyWG1YNXdTWng1SmVjWlgrSTdqSjJSd0pVc2pnZHZ5cTkydVNmbStx?=
 =?utf-8?B?UUZCMEp1THN0cngxNUxXemN5aUNUWnhBN2VJZ0xzcTlaZFFDVzc1bmYyN0x4?=
 =?utf-8?B?NFd6OGdEWi85V3paZjhRcCs5dmRrZzQxOUdyd25jMVhocjdUREtOaUs3MnJs?=
 =?utf-8?B?Q0FZcERTend5Q01PYWF6UFhEQUlxa0JiSGQyZ1FyY0Y5cmIyUGFnRWhzNVl1?=
 =?utf-8?B?UytUd2xJUWlMSDgrTlRrUUJROXIxMTRRd0hMNjhoNm5yYTB6ckxpV2M0ZUlx?=
 =?utf-8?B?aDZ4WVc1M0Z6R2RkTE9tMFU3VHYxV2RVc1pGYVNVamVNeEc2OTFkOUpSYlpL?=
 =?utf-8?B?RDdqOWFJMU5DWHlvMlhJblZqOHl5c1ZDaUFUWTN2cFZpaDFDdEJ0d3JQdG1o?=
 =?utf-8?B?d1BhRTI4aUdEUTU3SlljTEl5emJ4YW55ZEdMVUx6WXdVakRkMVNYK01qQmQ1?=
 =?utf-8?B?RXRocmhJYTh1OERtbnhSakplK2V3SGJ2Z0FRNE1BNFo5dEZMVWlmYWtyRnEr?=
 =?utf-8?B?RlhzMFN4QTkvbDZ2bTZPOU05OUtsaVFoUHhlaXRRS0xRQ1pRZW1NVDJUMSs4?=
 =?utf-8?B?VGhRalBTWUJuaW9kSkQ4VzAxWU1XaWtSZEJXRmtuV055bEttZ21VbVRKYnBC?=
 =?utf-8?B?Z1llUnJnYi9Tc1k0N0ZqN2RzSTFTakpCVWVBMlVCMWJsN1c4eE1CYURDOXBD?=
 =?utf-8?B?bGFFL1dMa2dQVFVxYU1mOW94QklOYnZkYnBJRjJZc2tYMWZEWGtJOXlsOUZm?=
 =?utf-8?B?cHovQkoyb1ZKVERQUFlITEl2cHRhKzFMcjJyMHNwV1kzV083YmNOdTA5TmlZ?=
 =?utf-8?B?Y2Vjc3N1SlpjUnFvckVibFN5ODBzYStoUkdacVo0NWNGOHpNUkJNUm5uK2Yv?=
 =?utf-8?B?U3VxdUxwS1JFNjBkRGhCK1pBZ3dXNFdpd09LTUlXVytiU0pvZjQ4cmFmaUlp?=
 =?utf-8?B?WjEwNEI0TGxUdDZoVmdRaDNKYkg1Y2ZZN2Z2dmQ1ajZyTzBmTWtqVlVhdjJM?=
 =?utf-8?B?cEdjOU9VcGNtc1UyYkZQVE0vUnlZL1VoNlpOWHhxeHI1UTFyL2Z3TUw4V3NN?=
 =?utf-8?B?b1had3JHeHBySW43U3N4Q09JWmlaS3IrSHFwSk5TSXkzREM0MERCdXNVYUpN?=
 =?utf-8?B?NG5Ld0YyWWVrdVlCM2JvU3lQS1A2UkdWM2hjQzFqYjg1T01nYTRqUVhMWk42?=
 =?utf-8?B?UWZLL1Fxc3FsNFdUU3hxMUZkM2ZnUUNGSFBxbk9DWnp3K1FZcEJEeGcrV2Yz?=
 =?utf-8?B?NXUzanJNN096YW9PTytGZmR5SHRtZ1lIMUVaTjN5Qkt5bGxSUy9tVWoveWJm?=
 =?utf-8?B?VStBako4SVpnUjFjUmh1ZnZuVTBMMTNlWVI5cUlEUTBGN1ZsVC9hRElQQ1A1?=
 =?utf-8?B?K01nMWVTeFZBbDU0ZHZUUHZCSXVVWnByZHk0UnRtd1RtZExZcnBBL3JWa1hK?=
 =?utf-8?B?NW1PWlBiVW9JNlNIWGxsWE9GWS84YUoxOVRxUmwzTUVzU3Z3R3E5M0p1aFdj?=
 =?utf-8?B?Q2trbkYyL1piMmJNRzlqUXBqeTJqRlorUWlkNlJZU2pSMVlEcjRudnYrUFJT?=
 =?utf-8?B?RThBSnp6elZUa2ZrRHpUWnpjV09xY1cwb1NRNGxtV0Y1cFIxUWJRTWR6MHZV?=
 =?utf-8?Q?2+DP48JYbKIGN+UDa5C+GvFEn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b106106b-0df6-4ef0-8d01-08de2e2f5845
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 03:36:41.7066 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cIaIQNsa8queBWu7IFKMqGldGhs/9Wi/aDaeHZ4y+C6j5dhwIvv9B2l+kfn1tt0GgplYqCn1kBJwLrb5yftRnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11474
X-Mailman-Approved-At: Fri, 28 Nov 2025 15:13:26 +0100
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

From: Peng Fan <peng.fan@nxp.com>


On Wed, 19 Nov 2025 08:55:30 -0600, Tom Rini wrote:
> Remove setting of fdt_high to ~0, which disables device tree relocation,
> from the default environment. Doing so prevents U-Boot from correcting
> problems such as having an unaligned device tree and leads to various
> failure modes in the OS.
> 
> 

Applied to fsl-qoriq/next, thanks!

[1/1] ls1043a: Stop disabling device tree relocation
      commit: 13cd238a26c2d5c839bb07d382a4a55d8d887bda

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
