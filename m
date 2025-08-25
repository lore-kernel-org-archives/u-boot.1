Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D135CA0EFA
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 08:41:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50FA2828A2;
	Mon, 25 Aug 2025 10:41:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="J0cQjGrp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65D0582E37; Mon, 25 Aug 2025 10:41:01 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C3B081E13
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 10:40:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qwnynvwfwkXJhSQpt5ittdMD84blvzTj9JV+sCSc02PH7MJnlwt43cnn3Fb37L2Og4B7Ry4ddbrlx6IPoQjkZKh12LNjNUz3q6UUQpenw+ETgT/6K6FpU9+L2o+j7WQDDOv7kxjF3XP25hItWsev7OW/ttwiql0xwR2XnmbQz4bWr6gFSwNF9A7S3m7aL/D46Hnd7Z79DdScvfCgAXSvmiF6/9gu/Xt0kQv7cNur/45a/WPKqtIuZC7uCu8CJyuJWRGY+gCSRTUEe49+oz4bxgu7NR6iUdk4//IiBlXgyeXy8YRv2MA95jzjZt2wGnpj+AU2BjFEs3qJzmQyCwZQEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZpq6xSHplBm/f2DsjmZjXA41gn+c2S7V0tYxSC31lc=;
 b=A8ntbyYf8TcV70xnZi8FMNt2bLKEyPUHgfUjylmUJBSA8WrTeiXN4iCdwArQpSRk1F23kH6yCr3CyqdkUys3jxL1zcUVoepIDJ6eIeKFwus/WaoUJHugiE8oCP7QxGbyIevlhoxyVnq2I+WqdeFcKo/NY0cmFGBbLFAuAWT1smm+IgioTsF3BfQCJO61kXrR5Wg7qP13jbY/s+0luUyF908wYYgNdVVo4Y2ReK83Bi+IHSHrciYikc4RpfWE2no6Vxd7Tm5PTV4QEFfwJEI2jeUwxFT7N+fxqphabsqrREqTN/wE/AmVDUPTS25ngMoVxFxGzny/KQcuO1/bDjRyFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZpq6xSHplBm/f2DsjmZjXA41gn+c2S7V0tYxSC31lc=;
 b=J0cQjGrpL268ZLBcV9ru8nc+YEJB9i/I6QoWCdPceyEbGpzYtafnTniT74TKHx9MWdjbkn8N1ouBkHRgfBOdUE8RY4+AvZzdAtPE8/PA4txc51+TK2YD1TrfQDALOwuqr7ZB+o0zlkGHrsjEZuN2syEg4g62xjMqsb6yk7RfsnMJ5mUfFjW1SSaizNRO88DzimBGPfo4tzGbGUWAnPSuiFd3hIrrf7MiNOLWSZzJd6F0UuOuXAFOsv5ciS5cOp+rwFbRQ+ESp6qCtx6wj6jDbRXtEPZf8C/SJp0TFXwO11cqHaTjOoq2hCDZ05m1IPojidnnAs27ferKubHPYMr0Tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AS2PR10MB6426.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:545::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 08:40:57 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9031.018; Mon, 25 Aug 2025
 08:40:57 +0000
Message-ID: <42ae44e8-b368-44a9-a828-578c77d4d15c@kontron.de>
Date: Mon, 25 Aug 2025 10:40:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Use correct LDO5 control registers for PCA9450
To: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: Joy Zou <joy.zou@nxp.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Ye Li <ye.li@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Fabio Estevam <festevam@denx.de>, Frieder Schrempf <frieder@fris.de>,
 u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, u-boot@dh-electronics.com
References: <20250811131213.211124-1-frieder@fris.de>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20250811131213.211124-1-frieder@fris.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::9) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AS2PR10MB6426:EE_
X-MS-Office365-Filtering-Correlation-Id: 943db760-fa15-4b12-8ac6-08dde3b31caf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OFlidURka2RrcjloMEhibjlZQU44U0NMcjlvdUhPT0RpcFI4NVhLTXl1RTg4?=
 =?utf-8?B?QmpVbzFQZC9MMnhWL0RzeHpINmtsVDRLUHZGa00zVlJ1Y0tqeUxBaGNNQVht?=
 =?utf-8?B?S2wzM2E2VThVbkNFek1na0RMZ1BQK20ya1dYWGh1MVdiTkdCdmJEWmRQZ0JM?=
 =?utf-8?B?Q2o2NE5wZE44Z3NFSmxLak5XUFRzWGVpOHVIbC83aUtidkc4NXFZUklKSWh0?=
 =?utf-8?B?Q3p1NkpNUGwxQTRldk5yWS9kaFhuZDN6clI0TC9uUG9hdklkbC80ZUhjKzZs?=
 =?utf-8?B?alY2WHBCTzkyZ0VwQWdDWlpQM1VVN3ltTmZ4cE8xekVJeTJXUjZFTkRPY21B?=
 =?utf-8?B?V2FzOE1sa045N2Y5S1JXRjRreHdHSHpSQzNRL01meGJUNVMxSTB5Wk1kSVJn?=
 =?utf-8?B?ZG8zdjZud3g3OWRHSE9XY3UzcHRvQkFkUlE1UXZFektldU03ZXZ2dkhRNWxO?=
 =?utf-8?B?NkFiM1lPZmFDZE83QlNIbjBYOXExUjRlbkJjNmpZcC9aTGpQVk05aWdGbHNx?=
 =?utf-8?B?UXpoRm5raldudkJybmtydUdQNEdUQURRK0gveUFLVE5vSkJmN2toOGR3K1Ft?=
 =?utf-8?B?aGUzTGpUSktXd1lydHdZdUVDS0kxdVVXWU5Va1RmMzdYWm1xRUJpd0h0V01C?=
 =?utf-8?B?MkRYcnFwRlB4TERXU3FRU0UzcnRteDBSMFlRaGFBbklzZFlJOXFzaHMrcHVG?=
 =?utf-8?B?YlFJemNiQWR2U09ONkVWMXJRaEJCcHBnbDFjQ1lBb3pXSkc0MlJUSnk4Y3FU?=
 =?utf-8?B?WEpsWHRXbXRXLyt3T09zWVo3bndNVStoRXFUQ1FtNExHMTExR01pVGtFZklH?=
 =?utf-8?B?K1I2WW5BUGthcm1XTkF4cDI2YUdHNlJJdjFyQlhlM1BWS2ZqM09yYVFXMGZz?=
 =?utf-8?B?NW1ab1B1RWFWUmxqUXBPRVIwREVGYmFHSDJJKzJXcUVEbjZ5SXVYNlJUTlAy?=
 =?utf-8?B?bGQ4QWZDU05mVEtlVldlcjJVeW4reXRXS3F3aUg1WXNVdDNPUkZaM1hUUE9P?=
 =?utf-8?B?NTdHVjEvbDNWeldVc3V0SWNIZUs2Q2ZEYmN3WGFRa0dzWGlwdXFHOEpFMm9t?=
 =?utf-8?B?MHpaanUxNnBIRGdWREVaSDdPc1pDcytWdDMvNW1BN0V6RytkdjRGWjJZM05C?=
 =?utf-8?B?OVVvUzc1anNwaDd6L0dtZzVjU0dSZXpzU3lFSXNLTlRBWHVjV3BlZFg1MkM1?=
 =?utf-8?B?VnZDZmpYTVo3elJHZmtQNVBBam4xYWQ2ZWtnN1NLSjVGN2cxS2Z0Yk1FYTNV?=
 =?utf-8?B?WW9KQ1k0YU5NQTRadUFkVWxMRWdLcktvSXpOQUVFdEdNWmdLQXNIUTA5MVpC?=
 =?utf-8?B?Mlk3cnJ6SG8wanppVDNoaW51aXFPOTlJM1NhUDFrTnZRRHBZbHVBZE5jYzV5?=
 =?utf-8?B?RksxRHRDWnpxMHhadXJvblpTTk1uY0kxTEhDT2plWDFvc0JWZDVqY1E2bkNN?=
 =?utf-8?B?bGhKNk5wdDAyTWFuc3FSRG1KVFhLSktoR3V1R0d4NmdVYWJ3SHVxdElmRFFM?=
 =?utf-8?B?aEZLK0lVbmdBTHV6SmxCbFJRLzh1dGRKaENpbEU3RVgrblFtR2k0Rm1DUU5P?=
 =?utf-8?B?WGNjRlMzMlRzSitYQjd5cWNTdW52N3BvVmUvb1pqazZ6VzBSU29McmRkR2tv?=
 =?utf-8?B?Nlk0R2JlaVlaRlVFTzVrR2lsRWFHTnY4ZkE2eXBuTXhVNWFkUkQyb0hDc1Ro?=
 =?utf-8?B?MXNlbVRad0FBdFBVRUZDbkFORzA0Z2hTM2I1dS9xOXU4eTZUTnA5bGd1N3NM?=
 =?utf-8?B?ZGNFYmNpWGZjUUdLM0RpbVFQdThtdnlzWk9zR2lIR2xYVEpaR1o0Qmswemk3?=
 =?utf-8?B?WXR5QmtLMnNDdE9Ld1NwcU1WQ2ZHM2ZaMGw5MlRETVIzbklDckpDOVdnSXox?=
 =?utf-8?B?ZTNJMDVHRmVDUEtHM0NlV3ZMN0FSZ1ZjSk51TFVFZURWTEhzVUVqdzNzMHdZ?=
 =?utf-8?Q?35ZRYo0LHFE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWlZaVpLOWM0c2xtcjhDZFVGOHk0RlFvQmtoUjk5NU5Ja25mdjFZc3Q2SFIx?=
 =?utf-8?B?aEZ0bXkyVE1KeldOMjhZQk5MbEk5V2gzWjhCS2t3cWgyYnJQaDRlRHVsVWpp?=
 =?utf-8?B?SGpKRHlqNW95NzhQTnZlODc0Y1RuanJPR3UvSTh3ZkdOR3FsRUdUZkM5TUlH?=
 =?utf-8?B?ZTkrNXBJc0pKa2dnUHB1cDFaakk1ZWhCNUlJN1BRK2xZN2YreURZamFxZ1F0?=
 =?utf-8?B?cnZlNTRqRmFzV3NSN2VkTGZEUFoyWFRnaVpGM3FkQWk0Yy9kaGJUckVPQVRE?=
 =?utf-8?B?YjdiN1FJdUtNdkhjeHRScUJqMEpEeW05eStHdGxKYTQxb1J4QlZ6ZUh0UGJz?=
 =?utf-8?B?QnFYTktEMFJCTGo5RmFSbXhGbFVwdFFnTmovTWZhaGtkZG91L25kMng5cnlR?=
 =?utf-8?B?Q09SZDlKSUdLTHRrWlUybnV6WmJvU1lyOFlRbDBXS2N1c2I0ODFsNVZobGI0?=
 =?utf-8?B?TWNxd0MzdHRENHZXU0ZmWFVUSXh0b1NZdXJOY2RTTGZoZ1dpMDdNSW85TlE2?=
 =?utf-8?B?eVNJTzNkQUhYSWlvZ1dTZnpGQVZITmxBS2UyMzdSUW51b0RoNFIraThTV1Jt?=
 =?utf-8?B?QURFU1lSUHNwSnpkL1UwRmpKQ3FGd1JKa0R2ZFRCZ1plTkRDZlB3cXNUZFMy?=
 =?utf-8?B?SkJ5amN1RHhlQ1NrV3NtOGV3bGhVTythMVZLZXB0azE2ck9lZjRKSGZCOHJh?=
 =?utf-8?B?Z3NmOU02RTR1YjJSTG1kbXRYZFFVcVVjVW1RRy90a2hIQnNXQ0cwM0FzRyt4?=
 =?utf-8?B?S1p5ZXVmMGRITVZmcE1GcE0xY3gwQ2J3TTJiOU5XeVRPb3pBcVpMMXZwaEJ3?=
 =?utf-8?B?cmwyVHZjMzdPc2ZxellYTEVzSTNKalZlQlVXZXF3c3NiWHB4c1BsNzNXR2Rh?=
 =?utf-8?B?MGkrVUp0U2UxL1NOdE9XOFVaRitkbGF0ZDRKYVNZcTFkZzc5aDY2OUk5bTZs?=
 =?utf-8?B?dkNoNVVPZTRneTNOQWJpQXdwalVaeHNyL2x2TC9kK3NORW1RYUVxdmV5Ulpl?=
 =?utf-8?B?QmlzRkRaR2xjdXJKMUVaV1ZjNHA4K2lzTjdGNGF1bHZPS2ZvVlBDdzZ2eGho?=
 =?utf-8?B?MkY2djBqWFhLUEZSZGl0M2ROWHBuN0t1eVM4QU5FT29uRGdZTzBsRXRpTkV2?=
 =?utf-8?B?RElaVU1FOUY2UTY1UjIwKzlaRWdpSWplTldRcVhQU3E0bHl6V0xrdG9jL1Ux?=
 =?utf-8?B?TEhIYTZMVXdKYlorMUlVNTQ5Yk1rY2U3VTBsQkRzeWhHc0VLNlZzV3FBemp6?=
 =?utf-8?B?dUN5ZHZwcFRFZ1ZhUWxGQW1aZkxqcG1SM2VMNm9OZTU1cmVrTDRPTUp3VEdw?=
 =?utf-8?B?Mm5mTy8vdmlNdUxqdmtZTmNjQ01ZZjQvK3Brc1FqOUxodlJ6cWlFcFVkQXF6?=
 =?utf-8?B?REFkVWl0WXZhbmhLaVJYQmhFalJJL2cxbUtZK1h2aGlhSktaTFFYRXFmOGtW?=
 =?utf-8?B?UlhjTFBRSmZBYjJLNHhFYTZOYjFvT3VJYzV5QTlVcmc2cXpKT0NDQVFxeE83?=
 =?utf-8?B?LzhUNldKVXMwTkxzU1NUYUg1R0ZoRkZVYlppdkdwWWd3VmhSR2F3WlJYbXNn?=
 =?utf-8?B?ZTF4MWMrMVNjckhzY1BjZENQUjFDdGE5cW90Ti9MT1dRU1dBSWo5REdvY0xY?=
 =?utf-8?B?aFYzZ1NzQUt0WWZMZmlQVkpLcWh0eHk4ZXR6cGI2YkZ5d3ZXeVVWSWZpNkZF?=
 =?utf-8?B?akRIc0N2c3lwY0M5QXJSN2pNK1lNS3UvSWlPYjV0aitVdXJiRXZMTU5XY2ZP?=
 =?utf-8?B?QVZVK210bDVPTE8yRDdHbFJkTlR5K2p0Yy9hQy9ZeGNpTzFMNnhMcUtVUXRN?=
 =?utf-8?B?Wm5tM2J4SHFsOGVBTEIwbERYTUJOK3JLblVleUFKSE9RTHFIcGZ0ejJPUk9v?=
 =?utf-8?B?VWg1YVk2SDh0SUJYL21RanFxSXZHVDBKdFhlZkR1dmxQR3J5aEFJUG1ocDhR?=
 =?utf-8?B?MnR3bTk2NmRFWEZ3K0Z6YlJ4YjlDVFdVZ1ZjMmhjYVRxQk51VjYrN0xUYkR2?=
 =?utf-8?B?aXdKM203UytkYVhVdmQ2U3ZQcEV2UHZpdmdGU3BLVnFyaCs0WTlYZjhxZVBJ?=
 =?utf-8?B?UUQ4Ylg0eDQzbDRRTU5SZ05ZcExVVTFyYmplSmpMak1Bc0xhOG9jeERsMjJz?=
 =?utf-8?B?blIvQ3psWWVOdDltYW42bUk5T091cjNKZU1rUklQV0l2TVc5LzRUQTBZYmxs?=
 =?utf-8?B?eFE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 943db760-fa15-4b12-8ac6-08dde3b31caf
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 08:40:57.7617 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5omW/kFAEAy4pthysNwzYzxqY3JoJOIWiJFqOPZW5sq5xL+DuNA+rDH78LOSnnvb9QCTADLVUqjSKvJ5Xm/3Vcf2hZ0NHRH2ESMMTMS04ys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6426
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

Hi Jaehoon,

Am 11.08.25 um 15:11 schrieb Frieder Schrempf:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> This is a port for the following series in Linux, which is already
> available in mainline:
> 
> https://patchwork.kernel.org/project/linux-arm-kernel/cover/20241218152842.97483-1-frieder@fris.de/
> 
> This aligns the PMIC driver with current Linux and allows to use
> upstream devicetrees in U-Boot.
> 
> Frieder Schrempf (6):
>   Revert "pmic: pca9450: Add optional SD_VSEL GPIO for LDO5"
>   pmic: pca9450: Fix enable register for LDO5
>   pmic: pca9450: Fix control register for LDO5
>   pmic: pca9450: Handle hardware with fixed SD_VSEL for LDO5
>   arm: dts: imx8mp-data-modul-edm-sbc: Remove deprecated sd-vsel-gpios
>   arm: dts: imx8mp-dhcom-som: Remove deprecated sd-vsel-gpios
> 
>  arch/arm/dts/imx8mp-data-modul-edm-sbc.dts |  1 -
>  arch/arm/dts/imx8mp-dhcom-som.dtsi         |  1 -
>  drivers/power/pmic/pca9450.c               | 22 -------------
>  drivers/power/regulator/pca9450.c          | 37 ++++++++++++++++++++--
>  4 files changed, 34 insertions(+), 27 deletions(-)
> 

I saw that there are several patches on the mailing list for
/drivers/power that have received no reply from a maintainer for several
weeks (see [1]). I just wanted to make sure that you are aware of this
and kindly ask to have a look.

Thanks
Frieder

[1]
https://patchwork.ozlabs.org/project/uboot/list/?series=&submitter=&state=1&q=&archive=both&delegate=12423
