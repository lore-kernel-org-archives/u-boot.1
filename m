Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F725C49EA1
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 05:19:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40B1088AEE;
	Fri,  9 Aug 2024 07:19:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="P0vbi5SN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E61588669; Fri,  9 Aug 2024 07:19:46 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::607])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A84288AEE
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 07:19:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EAtKN25McpcktPEyqE/1Bma5S8n4FrVx5155dVIXlXsbqXANA2JMi/6O1HUQ3t4QsTFYfFPoJotf+rKVOLWOv73U0v8OJjLyo2wGxmNhJSqQwIhEAzHqrVP44lYw94+8SOeSUGtIa8aygtzv39QqGyRCP1LntuYNOZxBi0piyvrCDJ5y+3CDLHechJzTBXBEzNPMNUrxrXU12IO6I10em3E4m22hPaN2yWavkKRh2dNwo0IkMdhwTJulKQ6qlMTEr0KBrYeVyMwSeyjwWxTUIcfSPOFslFdsp9jm4oXpMYcHkAysiWOCPjimWjvLYmRbDCeQNjwJ7+yI11yZ9jKzYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EqrJr9LiWpn+TVpgqbNJTdq+3jWcvJUKc6XxAh1AQLU=;
 b=Z70bjC6xb9a8K+Ac0AJoQGO2TgQFQJxVgRL/p6l3ptLcI+l0dYlDbcf1d5y5HHss/cKn+DCBgEh8ziDQ/VE0i8b8yW4xrNai1ChseBax+Fu8u6T0GsJwF7Za/1juM9EvBMYn4XzvF2kOem+4fxvovg3JZFreNguHkG4VtDklBg0YH8JFctD5ssXbrD0M751IQwWKZ1tl//2ox23rBsRyAVsteraebFGeotJrGf5evqgLM6g1i/Z2wNf+OC4ztOw1GCnD0C+/CpjQXNirzrAZz9bwLhXGYfIIVsO1JYvWjgC1eGxBXawadwIc9IiEuhTYLeF/okxQn2njt/Pty/1tLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqrJr9LiWpn+TVpgqbNJTdq+3jWcvJUKc6XxAh1AQLU=;
 b=P0vbi5SNigJJfZhKf0Tc7Gxss5tjQGLLQsM1JbTdBCS5PtHM4T+lPPFrDVlBMKgxnR3Atj9ChHMqPfYmAe39+RUjK6/2aAQ7pAUZ35FtdqFRxJoHI3NlLUnZMUQ/zmcu9sZMrTxfFknPnbpZTauCWYD3I1V9vkQR4zmgJx4pnYrkqcRJSRq9QbnnqRGictnNc9Oy79XlAmIwOEdVGIIUUH0Md6EmilXqfG3YWC8JltqWXFWkNPSAofQ6aZMMMGAvqEVBXICOjE4VWbB97QlqigGxN4aE2HOIRv0GkY9bEFnxvqAZxsTIhyCxoNQSOn8SDeuKFJvbrU98l9w2+Mfs4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8593.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:440::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.11; Fri, 9 Aug
 2024 05:19:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7849.014; Fri, 9 Aug 2024
 05:19:42 +0000
Message-ID: <55c65001-bc56-4b48-9645-1e5f735fe06b@siemens.com>
Date: Fri, 9 Aug 2024 07:19:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3-generic: fix CONFIG_DM_REGULATOR-off case
To: Caleb Connolly <caleb.connolly@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
References: <6c201a24-422a-41f7-846c-1ad5b0ebc7e2@siemens.com>
 <f7ba8d78-e6d9-4f44-8d49-c7f805d60c5b@linaro.org>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <f7ba8d78-e6d9-4f44-8d49-c7f805d60c5b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8593:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f9928cf-e375-4955-557e-08dcb832df74
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjRDNmhiM1dwVi8ycFBGNHhGNGZJNTEvTGhKU1FTYlAwRkt4cGFkNXpqNGRq?=
 =?utf-8?B?RkY1SWlIbnZodFNqK3EycDZyUk1acUVoSCtjNjVkRmJVZlN0b3lJRkVINjVa?=
 =?utf-8?B?NW5UK242Q0VteWs0RXk1b094a3ZDSk5sSTRQL1gzSGwyV1lVcm1meDFxK2tC?=
 =?utf-8?B?WWd0VW9SVlJpRGs1d2VFUWJpZXN6TzlsOUozTzhETGYzZ1NERy94NEdmN29v?=
 =?utf-8?B?cnZSQW1WZkVrenNUSDlkUklVa3AzVm1HRnZtYVJSbjMrOElZRTlSc3pIRzdn?=
 =?utf-8?B?UmdNNnM2eC9TdTJ0U1dXVmJzMWM2MXNTYkwwK0ExZFBZZzNlbTdvQnZWQ2Vz?=
 =?utf-8?B?bU00UzluV010cGRyOWtrSnh2Y3NWcmpOWE1HT2QwRGNRUXdyS3hYaGFKaVh5?=
 =?utf-8?B?UFFiSDFYeHIxbFNYeWk4NkM3SDVEUFk3dTkvMnIzSzQ0T0lSaUtmRE93MVZ0?=
 =?utf-8?B?YzB2NnI3MERaSUtRUGg3OHBWZ296eU1ucHU3MW5qT0ZXQkVRRWlMbEpkVVpp?=
 =?utf-8?B?WHBVT2hCNmRHbWN5OGN1YWZZTzZ6Z2ZVZXhBUUxncUZEVTNCWE5GVGFxSFVY?=
 =?utf-8?B?VzN5UkxzUTJUQ2VsTDhxOTY5d3VMUk9sbWhzc1RCbXhLM08rOVlhamhLMlkw?=
 =?utf-8?B?MUpXV2JFMklCTmVsKzZvUDl1dFlHMmxpRlFVQkRDYWZpL201amdBaUhKM2VD?=
 =?utf-8?B?YVRuUERod2dUOXhPRUJ6OTZveG8vZmZjaUdnUW1xQTMyVkFZcWkrZDZSc3g3?=
 =?utf-8?B?eFV2a0ZMR3VFeTkvdG5LK2FHZGlkZTNsMXY1Y2NsaGpZSGx5Mk9FNzFKUmNs?=
 =?utf-8?B?SzM3NmQvU2daZ2I3Qm1LWnJzMnpHL2lvY2FTaEhoR3pBZ3RtdmpVVysxMkFZ?=
 =?utf-8?B?ajVla1hwcFFvMHJNaTV4NHY2THdHdDBJaE9Md2ROM1c4TWRQaHJMWmt0YUZM?=
 =?utf-8?B?NWhPcFdtL2wzTnBubTA2OWtaUFJCek9PTndqblVXc2FtWDR0bklGSU1zUzFm?=
 =?utf-8?B?TnFoYkV5Zk9iUHhvZ083Y2VrbUVQcy9VMngzREcyOTlVT2FyMG9MalJpSlBM?=
 =?utf-8?B?LzM2SXVhQ1QwTks4eTg1ck5kdlA3KzVsYmdzbWFjUEEzVE1MaUpGcW9Ydnh4?=
 =?utf-8?B?YUZ4aWw3d3duZENzN05ib0NwSnJDajZZNFJTTmtNMXhXVUJ5ZmJuNEN2Uldp?=
 =?utf-8?B?SzkwSlF6V3pub1ZqYW5jRXg3T2svQkJBWEExTE0yTmR2R0xITmJRWHllbitv?=
 =?utf-8?B?a05EVGtTejh0N1ZBOVRWZHdXT3pVNEpvdCttZWU2VHBvc05rZ2FMcW13Sk5t?=
 =?utf-8?B?NXlNQ1ZVamxKaUR6bTVOME1zZWJCeS90cU5DTGxOSlZpbVZZeGNFZS9WWkdp?=
 =?utf-8?B?YlZiQ1dTcUVrdThURHg2N0JYdTEzV240RlpTc0RFdWZLMUJvTVMxbGxCWDE1?=
 =?utf-8?B?NEs2U0JRaHpqOUxqZ2dHcEpESWYxaDlQMnhHUFJOL1pLQ2NraHo0alhnd2JZ?=
 =?utf-8?B?NFp0RmE1dGI1aW4rY3JEQ2l1NVp1T01EZ0dOVlcwS1F5aVc2eThsdjFWU3lZ?=
 =?utf-8?B?MjdxcFM0emtKdkhUT3NMaitQTEs0U1VOZjZMazVBZVNtYnpjdm9pOFdtYUxu?=
 =?utf-8?B?OXQ3ZzhzMmhza2t4UmJkRGVUTGZCaFQ2YkZzdC9SMUI0OFZab1JQdDNZbDVY?=
 =?utf-8?B?MHZyYkZhRDk1UDBzY2FZZzlLTHBNRmxNTTgvckRGNVY1N3JZaGJ3M3k4Qzk0?=
 =?utf-8?B?RHdENmJFS2FoL2Z4NGdOZ09TQmxLZFpHNTIvd2JCV2I5ZG1YZHFkK0xXQllr?=
 =?utf-8?B?anFlZGhyL21SQXMvbFI2QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3JYK2k2WDh0WkVLeVp5VjVCajdvaFRSMVdTS1RybHY1YU1nVTJ3WmV2N004?=
 =?utf-8?B?a1owUDNIdXdpcVkwNWVUS1krSW9NTFRGRFZBSGxJakdudHZ1U2VFbjNDeUFL?=
 =?utf-8?B?K3dVZDF5R0hrNTNtUXA5aEVQNG1sK3IyV0tjQ2FpczViOXRJOG5teFo5bjF1?=
 =?utf-8?B?OVV1SDhRU3NUT0RxbVZuTStNSmwvcURqQ0todWw0RmlSenloZ2RicUFRajBI?=
 =?utf-8?B?eVgyUlFRV0JqaUdwcWI2ZDJtd2JxWUdXQzVNRmZudzVtWVZkamNGYkxET0ow?=
 =?utf-8?B?RjdMU0lyaVdzUFF4WXVKbkE1ZjJuQ3dNQ05BN09ZMFNibDlNQ0xXd1QwRC9h?=
 =?utf-8?B?ZUtxVURXUk9XWURUT1BsU2NIYVpNZVVUVWl0VHl5bHZkQ0F6VWtrY2xZS3Ri?=
 =?utf-8?B?SW5tU01CV0hjTHRGK0xGeFQ0c3k3TXQxUWIwWEJxNEJDQlAwOTVqelVGblYy?=
 =?utf-8?B?cWo4SitjNThoM0hnalJ6WVdicHFXQVlEdmswOGxmK25vYWZkK2hDY3E0NTNs?=
 =?utf-8?B?Z25Ibk9hTG5lam5tTzQ3V0pkK3lhYnZTUEh1dnlOWXNHTVJyTXZ2MDc4M0FI?=
 =?utf-8?B?TXI1NmRkSERlTGMwNW02SDJ4eHhQdHcrbTlxQlVKNkVlM1RDcmg4SEVqa3d2?=
 =?utf-8?B?eGZnWXlFNG8yVGZrVVFtTmVDcnpMSms1Rm1POFdyRGtEYnJvUFlyUlZHSkJE?=
 =?utf-8?B?L1F2eS9uc0F4bnhnVkljVWxPN3hpTkM3R1pRMHZ1QjU2d1ZJcWMyUk5lbHNh?=
 =?utf-8?B?VTE4WThKczFZZGZUdG4yaGhhcEZaUUlubVZPSVhGcmFuMkZaWlc0eXpOOFN6?=
 =?utf-8?B?T3NYNnRrNnVzMk1Hc2YwL1o3YXlPeUVqQ1dBdlVBb0VTUGQ0SzQ1MHpkVnJN?=
 =?utf-8?B?bXJXZjBjNXU5aDVtSENVUWZiSFNqMk9CUnIyWStvTFpJemlxQm9pS3JBODFq?=
 =?utf-8?B?UU9VazExVDFJN0VaTzRuYk9GRUNLZ0NDeEUxa3JhVytCQTVvMllSWWh6dXZZ?=
 =?utf-8?B?b0xRSGVqa1BCR09SdlZ4VnFERER6c0VIaDBsczJvb0JhYW9RZDlGby9qY2Z3?=
 =?utf-8?B?K3I4YUVxK0g1Sy9COXc5MXFrSFF5S3F5WHJhMWFEQ0dKNEs1clJZSzRMeHJB?=
 =?utf-8?B?aGJIU3QyMGtaYWtaNGFCZ0lUSFlqcVUzZnM5dWJFZXo0NlVpV09uaWd2ckE4?=
 =?utf-8?B?QjJxajB2ZUV1dlB6Mk9iRElsTUtEOWdnZ043WUl1MUpzbEdwbndSMzlGcFpZ?=
 =?utf-8?B?YnVIUEFrTjZiUFVXOXpneFpIV0tRb1JDVGJqYmJrZFlCc05PQjhlVC9vVUpM?=
 =?utf-8?B?bGpRcng2RXI0VXhSbkx2eFRPajRHc3Y2M0t1c0pGVUhVWWE1VVkzczdFYkVv?=
 =?utf-8?B?QXV1eEJwTExJaXpyTjliWkp5T3ZkRUVPTlRBWnJyejh3Mks0aTFqbEtIVnhC?=
 =?utf-8?B?LzdMa0FmMXlKZWN3a056TG1TcnRmbGRHT29PYmpnMnhnMWRoMmZuc2RnazRz?=
 =?utf-8?B?UmJ4dS9zZkxGNWYvQVE0WEJta1hPR3pOZWFReEs5ajVEZWRPNlZBV3N6N3Mv?=
 =?utf-8?B?ZENwVzJOVFBaMEY4dXVsVEx2L1FDSENraVdzWXNXMnpqTHlpVXY5N2lGaW1B?=
 =?utf-8?B?L0ZLYm9zU3F4UHFwa0JjTHZKcXhyUEttdFE3anM1Z2VzQzRkNGlRUHFOQkMw?=
 =?utf-8?B?NU1EMzhSWFBFSGo1WU9DQUNyZW1JZncrU21jbmI4VkU1cEZKOWxDT2VDUW5L?=
 =?utf-8?B?aUtPS2NCMnY4V0Voc3FwVkVRK3p5cHBHNDNOSjdWUUdsd05LNUl2REtNV1RR?=
 =?utf-8?B?TDJzZXlwcHBRVFBTOWNBYU5DSXd0L1pEeWlrZ2wxNGM2KzRqazMxelFtcW54?=
 =?utf-8?B?UlY4dWw2THBKUDJvUS9WaURsM043TXBaVW81bTR1SUJXTzR4K3d5QmlId2dM?=
 =?utf-8?B?YmRoRzcwSERBSmdiZ3FnU05sWmpCNG5GUkh6OGtLZ3kzUVpSdURjT3lWWVBy?=
 =?utf-8?B?eUhnSDN5M2Z2bEpzbmdwSkc2b1J6dkU0Zk95OGFKdzdLOURyV1c5czJWV01O?=
 =?utf-8?B?M0ZaZ2dlZTZ4RnlHUzdFaVcwQVZZamdKR1NKK2VZU0c4WGJGRDlCNi9Sa0Q1?=
 =?utf-8?Q?DOmZwMkjvPlTRdBcr8QiRD+B6?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f9928cf-e375-4955-557e-08dcb832df74
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 05:19:41.8866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XSmIq936zCyRxGwqBhVm7hqEx7Olfl5MRVe3gT7svZnvIUmFs7vI6STeiOCCMG3UxWp+oUnc+lc/aBP1yDzICw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8593
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

On 08.08.24 16:27, Caleb Connolly wrote:
> Hi Jan,
> 
> On 08/08/2024 10:51, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> When DM_REGULATOR is disabled, all calls will return -ENOSYS. Account
>> for that so that targets like the IOT2050 will work again.
>>
>> Fixes: de451d5d5b6f ("usb: dwc3-generic: support external vbus
>> regulator")
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>   drivers/usb/dwc3/dwc3-generic.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-generic.c
>> b/drivers/usb/dwc3/dwc3-generic.c
>> index a9ba315463c..2ab41cbae45 100644
>> --- a/drivers/usb/dwc3/dwc3-generic.c
>> +++ b/drivers/usb/dwc3/dwc3-generic.c
>> @@ -246,12 +246,12 @@ static int dwc3_generic_host_probe(struct
>> udevice *dev)
>>           return rc;
>>         rc = device_get_supply_regulator(dev, "vbus-supply",
>> &priv->vbus_supply);
>> -    if (rc)
>> +    if (rc && rc != -ENOSYS)
>>           debug("%s: No vbus regulator found: %d\n", dev->name, rc);
>>   -    /* Only returns an error if regulator is valid and failed to
>> enable due to a driver issue */
>> +    /* Does not return an error if regulator is invalid - but does so
>> when DM_REGULATOR is disabled */
>>       rc = regulator_set_enable_if_allowed(priv->vbus_supply, true);
>> -    if (rc)
>> +    if (rc && rc != -ENOSYS)
> 
> regulator_set_enable_if_allowed() will return 0 if the call to
> regulator_set_enable() returns -ENOSYS
> 
> Maybe it would make sense to have the stub implementation of
> regulator_set_enable_if_allowed() return 0?
> 

Possible. Would that be the only case where a stub should not return
ENOSYS? All do so far.

> Somewhat confusing to check for -ENOSYS here imo, since it isn't really
> obvious when that would be the case.

But that would still leave is a with a misleading message, even if it is
just a debug output. The absence of a regulator is not per se a bug to
my understanding.

Jan

>>           return rc;
>>         hccr = (struct xhci_hccr *)priv->gen_priv.base;
> 

-- 
Siemens AG, Technology
Linux Expert Center

