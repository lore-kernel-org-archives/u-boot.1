Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DD9CA0EF5
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 05:13:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D27B180FA1;
	Wed, 20 Aug 2025 07:13:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="WXOPj8CB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DB6C8211F; Wed, 20 Aug 2025 07:13:45 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 544D4809A5
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 07:13:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZyCrxIk4TcqYicZSAFfkDzVplzIT/zQZ03Y9BAvx6pqhQHzfng3SdarG06l8b4QHRUH69jDu3S3dB3AuK2mcGORnx3YhvG0d2NIbF8vDXEaHHDaet0Ha2knNJ+Gbjb8H/C26j9hNlpZ3V5UDX2pIAVmD0x6mCxAkLxpUIBc7IS/gxzncSDVMan1LkEaYopnj91YnVVQi1PQiMboHMpEdCVwmOSuTOy0YGgNVET9HUwr2RpPuf4yaheg1sqytdKBzddMRCIn0+cba5mvgBHs4A8Qdg+t4GUL3xrflLzPBxZTgU9PXjn9toBNlnslkfzedRS0MQJhdI/jbki1UkWdvnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msQZdQNeqC38IPK9a9DmpAAbSe3n7mA8l5ZF9scgV/8=;
 b=o468k7rNofCFFs9tNz75WbWl8OvUtqcWw775991EGEqnFeL6TreSj90y4N4fdFIeLzpm/rx/MtfWPNTdJr/jMhjg1IXxN/9v0VWgVHLJngDB3gt0dl2WcoU7tBqJsIS2sSV7+Hk+1gSGPPOMcZSckUJ6QDnHzz79M0fz/hjE5ftx3hsvZ0i3V7qEcJtwzhoBgIArcAXFHLBUYNtxfBkzWKB++nOBWHEua7z3h2fUTlVcNPTz54vJSiCoNA3uks+dml5xtebZbjm1kah3QAZX3FigpMSZLB35Fvw5sZDcnvm7SjnMXQO4IcOm5SBHZARWRkbaoWzmXixrIirC1hOQAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msQZdQNeqC38IPK9a9DmpAAbSe3n7mA8l5ZF9scgV/8=;
 b=WXOPj8CB7m4QvF3v4lYAKNSd9zWy+fEPQc+L8kTKtK6k5V79OPHovYszk+Q+8/sA9Cda9wCiDQLPAs6IkJeAxDKaMg35vFY2rF5qBOkakWHddVZKWf7BHnJM3hhL4jJGSKx3lyv0dCHNU79eXMo5CIxIJQd9WFTvJCF/lAp9CWc4yWDq1p5afm45lXQIuSTTsdgOx7MgfFummNuupLkGceYusQtf5VWWPrne1HRBC/D9LE5HzZ6zWQUNZ5COakqFND971tu6jMBvI7F3/xgEQoJJxRs1hTFVj2vBUXCxzSfsL681uWn20kXePgZECrpUFir7TQdZbmpSXkSIT7newQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6412.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:408::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 05:13:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9031.024; Wed, 20 Aug 2025
 05:13:41 +0000
Message-ID: <3988e819-beeb-4269-b798-8f25da437e26@siemens.com>
Date: Wed, 20 Aug 2025 07:13:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi: Select also CMD_DHCP from EFI_HTTP_BOOT
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List
 <u-boot@lists.denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
References: <fffc4713-4f89-4a04-acc6-8b295e453226@siemens.com>
 <b89b50af-e37a-4d7f-b08b-918a1a6839fb@gmx.de>
 <b8dc3f05-8e1b-4c14-b71f-a59f3e8333c5@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <b8dc3f05-8e1b-4c14-b71f-a59f3e8333c5@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6412:EE_
X-MS-Office365-Filtering-Correlation-Id: b4fd456b-00b7-44e9-f0eb-08dddfa85403
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SGp0YXdsSFRmSHFucWxwZ0JpT1Z5aWlOSFpaQnpwZW45MFQ5cXpGZ3J1OTRm?=
 =?utf-8?B?Nk1EaWlPdGtqdG5wRGI3T0Z1ZnRvWGZaSjdrM2grMU5KenVGRGR6Q3VKTEVk?=
 =?utf-8?B?a2dyVnlWODBveUZ6YStVQnZxOWluWUhETkswYnArZ3hZWm1GRkluejZLZHRo?=
 =?utf-8?B?SWVXUHlDb055QU5KdGx6dG1qako1OWpzeDRacVFLeXdDUUZFR3c4cGpGdzZt?=
 =?utf-8?B?VGgrZmVXblVNcTdPSmIxeWJlMUxwQjd4TGRSUjVySmxzR3hCTVYyY0ljVUNI?=
 =?utf-8?B?YWpNWTFOb254aTkyRFFad0tDVzNHNzlWR1lpU2w0UDMwa1RZTEFsUURDZTNs?=
 =?utf-8?B?am9SVDlmbExPT3VnRjBsMUpobG5YZURZUW1MYWY4N2Q0TGJmT2IzVXZhNWVt?=
 =?utf-8?B?Nm9PUi9TNmcxTjh1MEJudFJUaDJWQU5zaFFtZ21uMUluSXFWOXRTcnYzRDJW?=
 =?utf-8?B?TUt5ejUzeTNnQWhDdGZTamRpTENSUVJtc1ZHek9La1I3bFg5d24zNlpJeFNX?=
 =?utf-8?B?N2V1SGZSVnFuZXYxbk41a2p3SVNWTGdxN3dzWkhJc05hTUpaZ1RNMDRHMjdV?=
 =?utf-8?B?MVdKY1BBdFZzakt1RXZkS3N4Qkd5eS9BTDF6cWJVOHNBK0VhOFpYdUJtc0gz?=
 =?utf-8?B?SmpaLzZJY2pwa2trdkxWUDlLUmRTOXFmOHBFdXQxajZZWEJkUDJrVXRGcHR2?=
 =?utf-8?B?RTJ0ZDdvb3JBazMyQldXOWErcitDb3pJanVRR1hsRVZnNnA1bndoamd2aUpR?=
 =?utf-8?B?cEtqL1FHb2c0MGVIWVBncUIvYUpjeHlMTStjVmE5OWNwdXhET0lEY1g4Q0RN?=
 =?utf-8?B?eExraVhQN3BXdmh5ejlGY0pKVHR6VHU2a21vdkZyb0QraThKZGxwNzFLTjZr?=
 =?utf-8?B?dG5YYWxKKzVjOGMwYnB3bmlPYi9ZN21Sdk5BZjZTdU1tbFVvWXR0V2h3d0I5?=
 =?utf-8?B?QjE0dkpLd1c5b2tOM0hkQlRkK3hQbjg5T1dwVUxHWkswczAyanVsZUM3U05r?=
 =?utf-8?B?VzA2bkxVOGZra0VQUkFFV0dZL1R4Z00yL0t1UDQxVnNQWkZVaGZGL2E4Vnow?=
 =?utf-8?B?b3hUMnByZk1qNFpGcHZrNlZXUmtraG5vOUR6dkRNMVNmTnJTYzlkaEt5cEVZ?=
 =?utf-8?B?U1V6bkF5NHVXZHk3bXR2Y28zZ2dwdFBPbk9XcjVHT2E1K0JCSnd3Y0kwWlNM?=
 =?utf-8?B?R1JrYjNNZXBreHVjdEZURG5kZWZFa1BjTXpVdTdYTHE5c1ZNWHF0cDJleGlo?=
 =?utf-8?B?TW44VndTbUJEdFY5VEsxOEFMSysvelgvOXdkcXpGQndlSmljeGZZSndkZnZC?=
 =?utf-8?B?NGxQWHZkRTRFSVlxZXNYTWZPSjFDeXl5RzhhSEVLOW9xOVE2QWF0QTdTOFkr?=
 =?utf-8?B?YWJxbWR1c2xrSEZGQ0VkYkdpNjBkODlPNUxnUDBVNVNkRXhPN0xSVXJZZmZU?=
 =?utf-8?B?QXpqZVp5b3crSUdPK0lLUmRXRDVyKzdRbFV5MU0rWGpSUENjVWpOeER6NWUv?=
 =?utf-8?B?V0FSZjhzRXRXTUM4UGNVTkU4ZGhST05wREphZ0o3OUNpdktnL2F6S08rL2g5?=
 =?utf-8?B?ZEppRXZJcjlaVnk4T3Uzc0J5UjN2NVc4dFJMdEx4K1BWVHJzNEFacnJvQS9F?=
 =?utf-8?B?dE9vR0Q0ejlDaFZBR3Y5M3lyODlQR0JyYXpiejdCR2h0NGd2ekFqcW9ud1RS?=
 =?utf-8?B?dXBzSmd5QldJb2t6MDBSQkxrSjQ4RlBGMnc2V2I2NFgxcWs0WFhPUXVUY25o?=
 =?utf-8?B?clhPb0REUkhXSXhEdUw5RTR3OVNIbml5dk5ZdTZOTUhnc3lBUldOMWI4Uzhq?=
 =?utf-8?B?YmRuKzNoODIyL2JoU1FMK1VkLzNkQjljbU5DbURac2tLWnMyY0pBemo4ajNR?=
 =?utf-8?B?S2JTVWsralVDMk9CYWdIZ3pQY05YMXh6bkhGQlk5alRLTW95QWdSN0ljblpD?=
 =?utf-8?Q?xHSxUkluq4A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzB1OHVUZGNwNGZvNCtqQi9qb0ZrTnRhcDI4dHFoOTR5VHlUK1p2Z3F2SUtJ?=
 =?utf-8?B?ek1CQkdHd1JFV3EyaDdJcUtzZ0RTL2s3WklpYzRrUlRNcjhPR0Q4WnhuY3Nn?=
 =?utf-8?B?MnJmQ0ZzVjdBbXJTTkR6QmhmUEZYRmcxR3hJc0NPUnVQN2xEZUN4NXY4YTlY?=
 =?utf-8?B?d08vNmQxdW5DQzFNL2FDd3ZoNVZ5VEpCSVdROEhMYzhRSHBObTd1ckN1YnVZ?=
 =?utf-8?B?WVI0ajlab3VObUNlV1VsdjlqVnRtSWxieWxVUFRXalFUKzhOcDdRa2MzbDZO?=
 =?utf-8?B?bTc4UTFTTFQwcktJTmF3ODNWQlRlaUVQcVQwd21ORlJkRG1IT0dybWNLZDFP?=
 =?utf-8?B?MkxkZk9VRU41VjRxK2RsUERmNm8vTlJQcEk2Vm1FNTc3b1hBOEFxSFB2ZzV3?=
 =?utf-8?B?VG9JQ0djc05IRE5ZZFZEdU5VcFV5RFlLRTA2eHhtMU9QdkZoY01xRDlISSty?=
 =?utf-8?B?eWtUcWFVUmpoMWVXMnhheWQ3TkdZM1hWL0pCc2NRRVRzdDBKam5NS0xZVndV?=
 =?utf-8?B?QmI2SmVkblNWOWZqMkVlVkRORWhUaG0rRkFESGxBSmhtSnZSR3U1NGJCb2V6?=
 =?utf-8?B?YnRuYi9vbjZOVjF3RXdtdkxaVUdkTGVxcGwzWHdWQnFjUlQ4bTdpdDdaWFR3?=
 =?utf-8?B?a24yaXVrb2JVclN5YlQ4TXV0eEo4bDdVY2FGYWthYmFYR082NFhPZ1ZMZVhk?=
 =?utf-8?B?MW9OOWlJdXFESkF6T2x3SXQ0UXJXeUJDTVhSQ1RyRWJxVC9MTXNWR3RXNVRv?=
 =?utf-8?B?QVJUdm9WRjFBOEt1SFBKdzV0aGFVa3h5NVdkZVVoYUFrQmtrdTFEV0NhU3py?=
 =?utf-8?B?aUs3SzhIU3l3Q0M0RW81Ymcrd1NIcGdWVmpZY2VUQWlxaUZRYTJtWm8vSlZR?=
 =?utf-8?B?cktUTjBYK0NqQTVibnVkblBxTkRHVTl0bU41OWI3d2FVMEtHbWZvcnZZb1Uz?=
 =?utf-8?B?UC9XMzFpQ3AyeDVSWGpjOHZiV3hhRzBaWXVFMEE2ZHBOeXR4OHAwUDNCZkZs?=
 =?utf-8?B?eS83dHB3R3pRNnhmWEJ2aENDcGNqd0wzc3JabU9ySjZDMG9iQkhaZ2dSRWt0?=
 =?utf-8?B?Q2tSMTUxNFpOSWZKUTBRMU5qSzB6Vi9pYUpSZEJld1l3ZTdua3V6SWRGRDI1?=
 =?utf-8?B?MjZ3RmJoSXJUUGVLWmovRlY1UlBQMlIyS3pKdHhOT0tVTUhTTG9LUlJqQXNM?=
 =?utf-8?B?Z2RjUDJHUk50TExrYUppVmY4L0R2cUZzRnExTnk5TEtRODYrUmJBMmVQdDRV?=
 =?utf-8?B?V21KMHBlY09QczNkYjJLblJkVDZJN2dJa09KZFZlVVZKbU1tMzJqQzdvOHV1?=
 =?utf-8?B?MHhWYlF0YUZVM3A3M1E3L0c3R04zTmxkRkxPaFBqZFkzMmpic0FuOG4vLzE0?=
 =?utf-8?B?WkZQQVJGUWx0UkVjQjFOVjdpU3RZRk9yNjk2Sk5QcWJUcFhTbTdHUTRlZng1?=
 =?utf-8?B?aTR5c29MUjJlTi8vNCtLVkpCMGdwV3p6akNMT3FSMTJiWWYyUDI3Wk50aFFi?=
 =?utf-8?B?eUx4NGM1Snp0dkRmMzJFcDNzOVA1cEQwa25UdzBuemlFYXFzZ1hiUGN1Mm9H?=
 =?utf-8?B?SnFRL01jSXR0YlU0OHM0MFBQT3AwcHI2eW85czRJNEE3R0J1N2FIbEtFM3VF?=
 =?utf-8?B?UkJGZSs1OVZpaG5mMVowUjYzNXl0cXhpOGh2QnN3Ly9VMytZYW5jaVQ0Znps?=
 =?utf-8?B?eGtkTG8wczdYYjhteEJHWVBicVRVODd3Vy9Qdzk4aFpUMjhXOFJsWkM3czUw?=
 =?utf-8?B?aFpobklZdCtQNHpCK0YrN01rMkIwdVZLbnhyaVJFemlpNFNsSXpFYlRKeU04?=
 =?utf-8?B?V25pNndEN2lnaE1BZmVGUTFFbWZYRmNRNEJwR29UeDNvN2V1c1V0bmlrRTJF?=
 =?utf-8?B?Vm9MU1V0UVVZZDN0eWVWdWwyUS9YeHdFMU55cFliMEhrd29Ea2NIVlBxbzdP?=
 =?utf-8?B?bjEyTldUS2hnQkZ3REtKeExoa0RBQ05wZHc2K2pDNUs3YlFqRmtNUUtYNmxZ?=
 =?utf-8?B?WGo5cStycVAreklNRVpvQXh0TERhTUxHWTVBR1I4T0lmZHMxeDJnd0xwcU1z?=
 =?utf-8?B?QXhhRmFiYVlyQk1xN21RcHJ2RHRINC94ZGhOY0tGSSs0eTdqektYcGdmZUtu?=
 =?utf-8?B?WnZUR2Q1bFVlbmhPSG1GWTV5akZYZXdyVS9zNGxpTGdEeGJEMHY4S3dMRmVt?=
 =?utf-8?B?OFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4fd456b-00b7-44e9-f0eb-08dddfa85403
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 05:13:41.4382 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DcuimqjZBHpm9aRXwivvHuYlvoauYBV1zGQfkNPFGxw5QJEXVJtmSCOvx0OUFfbe/za6ralI4gWU0h/GQUiJUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6412
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

On 20.08.25 07:04, Jan Kiszka wrote:
> On 19.08.25 16:45, Heinrich Schuchardt wrote:
>> On 19.08.25 16:33, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> This is needed because distro_efi_read_bootflow_net will then need
>>> dhcp_run which is not already enabled by CMD_NET.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>   lib/efi_loader/Kconfig | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>>> index c2aa88f59fb..a4055e1cb43 100644
>>> --- a/lib/efi_loader/Kconfig
>>> +++ b/lib/efi_loader/Kconfig
>>> @@ -564,6 +564,7 @@ config EFI_HTTP_BOOT
>>>       bool "EFI HTTP Boot support"
>>>       depends on NET || NET_LWIP
>>>       select CMD_NET
>>> +    select CMD_DHCP
>>
>> It would be preferable to get rid of all CMD_* symbols here. They are
>> just the result of missing separation of CLI and library.
>>
>> DHCP is not needed to boot via HTTP. You can manually set up a network
>> interface.
> 
> As I wrote, we need it in order to even compile U-Boot.
> 
> Should we rather wrap some bits with #if defined(CONFIG_CMD_DHCP)? Then
> tell me, which ones.
> 
>>
>> Please, change your patch to use "implies".
> 
> That would allow to disable CMD_DHCP again, resulting in a
> non-compilable configuration.
> 
> Jan
> 

If we should agree on "select", though, this might be more accurate:

diff --git a/boot/Kconfig b/boot/Kconfig
index 54ef7052c5c..2813a39b102 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -605,7 +605,8 @@ config BOOTMETH_EXTLINUX_PXE
 config BOOTMETH_EFILOADER
 	bool "Bootdev support for EFI boot"
 	depends on EFI_BINARY_EXEC
-	imply CMD_TFTPBOOT if CMD_NET
+	select CMD_TFTPBOOT if CMD_NET
+	select CMD_DHCP if CMD_NET
 	default y
 	help
 	  Enables support for EFI boot using bootdevs. This makes the


Turned out that CMD_TFTPBOOT has a similar hard dependency and was only
using imply so far. If you turn it off, the build is broken as well.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
