Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB643C5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 09:09:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45DF882CED;
	Mon, 26 May 2025 11:09:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ABCBEPOK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5946F82CF8; Mon, 26 May 2025 11:09:13 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::607])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CD4C82C57
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 11:09:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oa/u0L+aQ6ClJS7esZbWgBVrs+5lFNyJQMSNJegy6PDdx9Dx/6zx29kHmJQ+6DqCWmcGMnAh0/bg93zTjEH9S4/LYaPrl3DRW2kwExtSp4AMr31Y2U9NqvXRKtOoLHNRccJl1eOHmMV5NYCo/AfSYWacq2CDAQJsoQ9eR5pgmZvdROrph73pO2HKnnPSkZ5uDw8S22yCFBK3HyDClWQ1x4k39ul4tyWzCWmw2RDIRgQPI3SYbIm48W7hXs/DJ4pINicitCnBa0Mf/QxhY+XwuA9wjAOPF4JUfSAJ1zJzLsWQG9qA0ZijX7LCCJ7BCHtio6PmXXBZUPC47/MOK4QumQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycmoE7EbrZa21CVZXs9PSM3IsmTl48jdcO8XOA6r3eA=;
 b=MNEWqbcN3coCBwvSxlZ6JquVlc4XjBtxS97AiVuvFnMoRG1u1Xe2SRI0Ym8WXGLCWDaEggl8XocsRx4NkTDc/QFvanRFeAZySb4loDWVuuPNnL01Hb5tpFh/qNsSe0czqc460JGIXHmL2gkU9s70KvADMxDA6AbhM8R1D05mN6dGRi4MQ5K3n6VHbFePZPHRvAMs/VVUaHeCfx1MkUDpZV1+XPQKHAc6vhCiD9xKpjpzHRTszdU7S29vB9hYXDXu8MDqpAFc8cbrx/Xb2JOd+2ZxzqrwJjqayrSt7yMhlO9mXk49S7AKhkEyqim1zpPOn8jmbrZDhriuGownWYvUKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycmoE7EbrZa21CVZXs9PSM3IsmTl48jdcO8XOA6r3eA=;
 b=ABCBEPOK3ltQTY1AY/ZaRwz7uDEDYpeUhRUJiEdJy7PPDhztR/a9HIwiWuCevuoxDX8/waUXb3kKiN+LsPhnRBcQlbN8fsZRNxuIonBlyppKd0366mc/sxsqQuyalme1nl/5mppTiTTscyg+TXyJBJckCZ4Kh9QuDSWkt/piTlI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA1PR04MB10748.eurprd04.prod.outlook.com (2603:10a6:102:485::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Mon, 26 May
 2025 09:09:09 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8746.030; Mon, 26 May 2025
 09:09:09 +0000
Message-ID: <2ce9478f-d2ed-453b-8d75-c3d5b36efd32@cherry.de>
Date: Mon, 26 May 2025 11:09:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bootstd: Use -c flag with bootdev order
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julius Lehmann <lehmanju@devpi.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
References: <20250524054245.409399-1-sjg@chromium.org>
 <97e69b7e-0ecb-4d30-945c-d2c32438149f@cherry.de>
 <CAFLszTgKawD=zj3tC2fWJsCv0Hpjv9eNaLcO7XVjn6SA8iFi-g@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszTgKawD=zj3tC2fWJsCv0Hpjv9eNaLcO7XVjn6SA8iFi-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0013.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::19) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA1PR04MB10748:EE_
X-MS-Office365-Filtering-Correlation-Id: 84e147ed-fa35-4a83-d7c5-08dd9c34f959
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Uk1mbFhDSUVBU3V4emdLYU15Nll0R0xzV0RDSW5LdTVIRXJkR3ZsQlpCUEJW?=
 =?utf-8?B?ZE83ODRsVlc3NXlTRUswU3puQ281VmRzZkllalU4SGV1d2h3MjVpTzBBWlNW?=
 =?utf-8?B?NEVSaS90bGkwaXJEMUxGWG9lTysvVSt1UWdJQlFua2NPNG1DUWZwSkY2NGtH?=
 =?utf-8?B?SzZHUDBFYldXRnFMYjAyMjNLK09XM3JBYjZ5aVYwR05zV2I0ZEtxYkZGRDhV?=
 =?utf-8?B?bUo0Y1YrSGJXWjZtd2VtbG9JVWI0L2VXZXY1N1c4SHoyNmRQK2FzZFN5Y0dO?=
 =?utf-8?B?NHJXdkZrdXZDWWMyZXR2cko2YXMrSTBjNjdudkVDR0dYVm9HNzBveVhGZzhs?=
 =?utf-8?B?R0RUeStSaU1weFAxZXYvallnYVJVVG82RVp5bFcvaVVqN3ZOYTJKYWw5Q0xG?=
 =?utf-8?B?RlhJTUpkUFRHQVpzaUg5NW9IbUdZN0VjTzlSZW5idjFVeG9aWXBxUDN5Q05w?=
 =?utf-8?B?dGdJUm90aGVSRzJaVUM3TWx4UlpFMEVFWUNzb2g3SGJmem9TUXhMcjdsNnQv?=
 =?utf-8?B?ZnQ2bUVsY2k3UFE4dC8rdXVDRW9nb1d0KzJiQkFIVXdXTWsveFFURmdOR09I?=
 =?utf-8?B?Tlc1a3l2b2NGb3czTlF1Ykc0WFRkQnhkN1BNb2lNSXNXYUJGR2doQmZZN3ZO?=
 =?utf-8?B?TjlPeWo1bVF6RVZOVDJZWlpDeEd4VGY0WUdsbVNPUVZDVDRrTHhOcG1yL3lH?=
 =?utf-8?B?aGNoZWcvUG03WnMzc2dsbndxTnR0b3l1SzFZak1BZWNHRDZGbk9DUXhnNkth?=
 =?utf-8?B?Nks4TmlHVWxhcmtOZHIxaTRoMFdaeG9tYkJ1T2loRTIyMDlEMnZ6bG5LRWNE?=
 =?utf-8?B?WC9sY1VnTkpMNEJvV081SjQ1UjRPT1BhQm45d2ZjUjRKU3k4KzQzOXhncU5w?=
 =?utf-8?B?ZXR1UVBweUk2bXhwYVUreXhLZTdUZHdoS2dnbEpEOWxsdHdla05NQXRoWnF2?=
 =?utf-8?B?UnZ3REMwR2xhUXJIV3VyWXd5SmxTajg4U2dLbHVPYWxhd05FaTBaQTlpNmJi?=
 =?utf-8?B?dU5sWDJkVStGN0ZuQi9lSjBYUFVmeDJGWlhFSzhLenI0ZnV5YzJCRjNROGYz?=
 =?utf-8?B?NWhuZlYxRnhrbmptQldnM3lYVDNQLzRIc2NpQmlpTjBJdHNlazk4QytycTEv?=
 =?utf-8?B?QURoeWJIWE9KcDZWQWU5UE1ZSFZoT3QrK05wQUVGUjFPTGd2YXNncGo0S0xF?=
 =?utf-8?B?MWZOZFJ5RjA1Q2xwNXd0M003NkwrNWZLa3p3WEhlbUNEeDBPZ3dMeGNhTXNl?=
 =?utf-8?B?TmRwWldUZ3NKZmc3R2VTSTU0RUJlVk1PclRHRkkwTG1RZzNTcGhFeER4ZWdj?=
 =?utf-8?B?bzRBQTVUK3hFLzN4TGVJUjE1bUdScjVWYjhsNFV1eEFwR2pNMjhOSUVQUnF4?=
 =?utf-8?B?V2FGR3Y0OXRoZDF3d1BONDFabzVDVG5LTnRmUHB6VnlFbUJrWkVNSkMrOWV1?=
 =?utf-8?B?WWZWZVhYcjZtd0NjR3BDSDJRNmFRSERiZ1BNM2xlaDQ2UlA1ZnVMYnpzYVZU?=
 =?utf-8?B?UnlRNGp2ZStCSjRmM2FKQU9GS1ZMMXFYeW1rOG9EOWhqbkQrc2RXNnFqa2Fz?=
 =?utf-8?B?eEd2M245Vi9mQ3FqR0NxSkhwTGV0WlBVcmJLVmVrazFxSTdJZDh1RWZoRmV3?=
 =?utf-8?B?NmxZdzB6bmhwblFjRUhNRy9HSHRXUEh0bDU2SktIVXFCOVVaeDczUWpCTkha?=
 =?utf-8?B?WVd5NUE2a1ZWa0Z6OUUyY21qOUw2ZVRITHNIYTBkNTh1di9hSFhQVnlzaFh4?=
 =?utf-8?B?dDVCWHI4cnNGRERJTnFJa09XS01lZlQxRUpxcUg4UDRjUDVNTnFpcUQ5MXRV?=
 =?utf-8?B?ZEtES2tmbVdxcnBQenZIVnVFUUlIUGNUN2RhYUlTTjAwUVZ4MUtpbGlDOERC?=
 =?utf-8?B?eUp5TG9kdmxUZTFwNXRTYVZsWW9HTDhyQ0JicHBIcGdWQXBjQ0JHSkNoVUds?=
 =?utf-8?Q?2HC4oDZC220=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUtqS1RHQnJ1U3puNWhocG5vR0xvZ2JGeE9tdlpEK3VTaUtKbTJGdU1JbDAr?=
 =?utf-8?B?bThjc3QrZXZZdi9SbGpXRDB5OHorQlNjMytqNlJ4YktoM093TDd1Yk5vb2k0?=
 =?utf-8?B?Y05QeExpRGRoS1Y4U1lPUTFTZnV0SENLVVJ1czJ5bmhlVXI1by82N3gwRHRX?=
 =?utf-8?B?MFdhSjFVbzgva3FjUFF6UFBSY3B1Mk5Id1BHYUhNOFRyeWdsWGZwZWcxNnBC?=
 =?utf-8?B?Tzh1MlZoSFN1RjZCUkJCdWRmOEthT3lyazZHNXlHaTNZSHQxYlROaFZPSzBO?=
 =?utf-8?B?ZG5Ib3gxMXJqOG53VU9KN0xkVUZ5S3JOSndJY0RiSnJLWVMrdTZmYVZ1aXI2?=
 =?utf-8?B?aUVaVWJhRkMvbWpOaGpZNUx3RTdDUGUyM0xEY21IdjA1cEprSFZGc2R1ZnpM?=
 =?utf-8?B?bmpKc08vVXVUM3R6MzVPZDJCQk9SZGsxQUhWK3JCNlRXNWRwaWFzd2dWbW9m?=
 =?utf-8?B?S1prd3c3TGl1WTVXUXVmMDlSVGtNZnBTYjFJdUVwcXVsaDhiR1pVdHRVYytM?=
 =?utf-8?B?MWhFOXlCVWRBY3c3Z0FJcVpvOXdxQ1hLSGZmRUJheC9wRitERURSMjdXSWZr?=
 =?utf-8?B?VllGWWZuMmtqOTNaUEsxN3FLa3plRzFQTVhlUTRTOXU2c0VPa0w0aWRJOUNi?=
 =?utf-8?B?a2JCTFRlcTlBTG1nZ0k0VE5xamhoTDhCUmdLNUtNWXphOVdRRWIwaDZNNVdz?=
 =?utf-8?B?a1VkRTl3SVFYUmlXMlBiSVB6QU5OWU5TaG04MjQ0V3E4U2hISjdLekhnSEoz?=
 =?utf-8?B?YkxMYkVJamxLT21pRnpqNmxOTWxIZ04vOFFzckxjRmF3SG9xQ1NnTkcyaU5q?=
 =?utf-8?B?K3RDR1kzRVc0NVdzZlU3aUhrL0VGbHRTT3dxY09RQXNBUU5qWFZwUFFWeEJv?=
 =?utf-8?B?QVlSMU5BTUZWcWVIbElZWTYyWUNORG9qYUZ0WTVudWVZdEk4VG9HSy95TWVR?=
 =?utf-8?B?UG1wYWl3YTBqZ3lqWVVITlloM1ZmQm4wSExGWUFpOXN6VTBxWlY1dzQyWHdF?=
 =?utf-8?B?ejNjT1hyZHZtRTZSZ0FUVURSTkVwKy9TQ2JaTVFWUjhFRkxWTys1UGZwY3Vz?=
 =?utf-8?B?TVpxemREaVEwRktQbzhHMVdKSlp5OGNaYWNMcE1RRk1pYlZsUHN5SEV5aG9U?=
 =?utf-8?B?SVZZdWFHVHg0em91TzQxY0xjZTB1MFQyeHRqVytCK2tENXpDc2FMdDc2REw2?=
 =?utf-8?B?c25jZ3ludmtJcWYrQ1Jvbm05ejRxa1dzdGtpYmNFSHNHZWZFa3dBQkRWZGxI?=
 =?utf-8?B?VndlUzB4SEhKWE82bTFYcEorQnZiZmZPby8xaUVQWThPN0lldXB1emh0U1hm?=
 =?utf-8?B?MnVjQlBUaDZ5akFWcmlHYmFEN0t2elZ0N0drbklkRGUvZHBtQnprN1E5Rk5D?=
 =?utf-8?B?NDZ3NjlHdzlLbjJWeVJoSnJ5WnpuV3FsYWdsUE5SdnU2TFhhOVhyQ3ZHVjZj?=
 =?utf-8?B?Nml2Zmh1blJnYWRGbGxhaEh5OS9ldVFPYnBIK2JMcEVFNjBSZGZzWGVzVEVO?=
 =?utf-8?B?Mm5jTTArU3ExbG9EK1l6UUl0ajdtcENQeEVuYjdDcEFPNVN6K2NDYk9NcDE1?=
 =?utf-8?B?b1NzMis2RnA0RTFsdEUyQzdIYUt1T28rUkVsOWRQcWVrSUl0MUNvUHhMTUhj?=
 =?utf-8?B?dzBnb2JEUUQ1bjBHcHJnbTdQUVlyYjRiV3pObEtpS2t5aWRxeU1uckw3R3VI?=
 =?utf-8?B?eFRaRmExS0J2U21aaVhFOWtlZnY0QTFwZUNwbEtHQ1F1ZXNSQzJwK1l0bjFJ?=
 =?utf-8?B?U2I3RElXVDdITzFRem5WNHpTRnNHbXcvRnNYU0k2YXV3WjRqZUV0emhzMUdK?=
 =?utf-8?B?U1NwQTRQTGRoNSs4eWJtck1zWHYvcDNScDA5R2pCV2lTOHdvTnNRVTNuVVVl?=
 =?utf-8?B?N3UxSGVLSVBxUGx1Wkp6eXNUL1lsOGUyaXZSUTJyM0hvdmtDMTJyNnBPMUt1?=
 =?utf-8?B?YTd4RkJWbkNTWFFaNm40Qlo0MTVoNjlBVzd5Rk5lU0E2V2pUd3hKSUJpc3Vi?=
 =?utf-8?B?cnZnQjErSy80WHJwSlBBM3lHUU5zTDJQR3k0RGR2VHRsT3pxN0NnVnB1Y1dR?=
 =?utf-8?B?RGp2akRYM1hsYkVtWCtMQk5Mam13UFBQSmVweE5vUzR1SlBKb2Q0R1MzeWZu?=
 =?utf-8?B?VnNWUlgyVmFUV1JHTDJQUDVhbnZYUTA3bzFpbkZaQUowYm04RHhBaXBnc29m?=
 =?utf-8?B?NWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e147ed-fa35-4a83-d7c5-08dd9c34f959
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 09:09:09.4077 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qretVHjM2oojFLxl/t7sC5V/2/DcRSd+CczyTVIGEuub0b7Gpf6BMWeyOwXNyPFhHHtHCPSUbWagAg3d1s2/K0jJ139K9Gx5MMQQ8Jlgjrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10748
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

Hi Simon,

On 5/26/25 10:35 AM, Simon Glass wrote:
> Hi Quentin,
> 
> On Mon, 26 May 2025 at 08:48, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Simon,
>>
>> On 5/24/25 7:42 AM, Simon Glass wrote:
>>> Update this command to use a -c flag rather than a special 'clear'
>>> argument.
>>>
>>
>> I don't see the commit which adds the clear command to either master or
>> next branch, so maybe just fix that in the original commit before
>> sending a pull request instead of via fixups?
> 
> Tom rejected that series (or 'changes requested' to be specific). I
> added it to my tree in merge-request 68:
> 
> d93f42d6e3d bootstd: Provide a command to select the bootdev order
> 

If changes are required to merge the merge request and considering that 
you are the owner of both the patch being fixed up and the merge 
request, maybe sending a vN+1 instead of fixups would make sense? 
Especially if you haven't sent the "applied" mails like you say below?

I would rather avoid reviewing patches on top of commits that may never 
make it to the main tree.

>>
>> Did I miss something instead maybe?
> 
> I didn't send out my 'applied' emails for this series, so it was
> silently applied to my tree, so far as the mailing list was concerned.
> Tom wants me to operate my tree silently so I don't always send the
> emails...
> 

I don't want to pour fuel on the fire but this whole ordeal between you 
and Tom needs to be sorted out, I'm essentially not even looking at any 
of your patches anymore even when I'm in Cc/To. From an outsider PoV, 
the situation is confusing and frustrating. Please do not take this as 
an invitation to include me in the "fights". Nobody likes to see 
arguments lasting months even if they are not part of it. "Fights" may 
sometimes be necessary and healthy for a project but this has become 
anxiety-provoking to me, hence my reluctance to look at any thread you 
both are part of. I also want to be able to again trust that the few 
reviews I occasionally make on the mailing list are useful because they 
are for patches that have a chance of being merged and based on code 
that was merged or soon to be merged (in a maintainer tree with high 
chances of being merged in a subsequent merge request to the main tree).

Quentin
