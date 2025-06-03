Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D86DC5AD49
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 12:06:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEB1F82103;
	Tue,  3 Jun 2025 14:06:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="fnHwicIL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B145082116; Tue,  3 Jun 2025 14:06:27 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20716.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::716])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2ABA081FFC
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 14:06:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L4QPfRLq4INqkLhCkYonshwT0kXkHyCXg///9C9/x9pVHnTRPpZXRVQpbH9zJ9bK+cIhb7ykvsPhqpJHu88bIMNbMdSHr3xOgNMM7dShasPmucA8iiSAI3Q2sG1+FwhOZ98t63iGv4Ur0o2rHfibWSqTM5mVN1uXL9DrI6qh3L36nrr4AIzZbTuT6xdMYpC458Fj+I3bmb8IKAD6pDQfSa9IQE8er5KVuchu0I2AwCa7rjHDCaR5PUSyXhbosm80oKd9p67jn3hcIgFHPk+9x/WTjN9hxm+QTZiudWFP2U1Z7wmhz0qE4yT+GnQyrKw8fPOZw+toeFdzxT8kDcyC/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+06rv2DykzdWX7TaVZyUk25A/xB5l+HV3qsKECm3sQ=;
 b=kwIWfHhuGtaWfICwzdcNbDtfVx30lVQvVQbCiAyiIkFFAA0k1cfvZmGntZZAhXGBkFBZyV+WA2yu/sdM7paM9jFr8wfHmon9Tgo1iqKhilPz/IJDMsCTjHqI1dtbEvYCbkiANazOVmrUsKtFyHveJuBi928GcxHE60ZTcykwZsb+78pNnLeCM/UTdddZch0JoDFYWFeuMwDCUW7Ob9psvKQxRXIWdc0PmWyxB9KNgX59zFDjpQA+jE8U+PCx5H3A0dvsDw6SV7wmxFL2Ox72qvqC53pWnD017pWSNHfcTwrGoFrUv1N0k7XZxxE/3x75sufHgzis4KNrbkX/x9ObHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+06rv2DykzdWX7TaVZyUk25A/xB5l+HV3qsKECm3sQ=;
 b=fnHwicILd+G4rzUq1kg7+p6PIa42Ku/hFo6JDs/NGF03G3TAJ8YgNa6vmiZlUOUoqnzltpzFUqDm5rtfmjWilPRT/wSsLD/bvzOatLx0T/bjs7acMRkYyFAjPQWA2n1sj3tZBIQoLixy11zXJRLNEPv54kNK2mhD96ghRa0HfVNyN0QsDRprNSNtXJ5kdcXoX/Txe8cZ4190EZtAeQNg3+XNpq8MVAdWSJXFjMOZOYyBu0e1Hxf5wFZPGcm1ZW73/8p0Q0TLB0csKugIpRoT2gJYwBwqtdvtRvpYEsLa6A2nuXoQB/Db7p1bB/NrZHKTbPfk3QccT0DughOYMlTm/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by AS2P195MB2407.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:64d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Tue, 3 Jun
 2025 12:06:23 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%4]) with mapi id 15.20.8769.033; Tue, 3 Jun 2025
 12:06:22 +0000
Message-ID: <f931c96c-51b3-421c-bbaa-2414b9f2a2be@phytec.de>
Date: Tue, 3 Jun 2025 15:06:20 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] bootstd: Add implementation for bootmeth rauc
To: Martin Schwan <m.schwan@phytec.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
References: <20250602-wip-bootmeth-rauc-v2-0-9d2384131486@phytec.de>
 <20250602-wip-bootmeth-rauc-v2-1-9d2384131486@phytec.de>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20250602-wip-bootmeth-rauc-v2-1-9d2384131486@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0138.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::22) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|AS2P195MB2407:EE_
X-MS-Office365-Filtering-Correlation-Id: 78ab440a-455e-4aed-fc82-08dda2970e7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1Jaakc3aWhKR3ZBYkdmVmlBbG14MWYvSFJFck9hd3VDWkYxUzlVd1NsVU1Y?=
 =?utf-8?B?WjlraVhTK0tBQUxZcDg5UktMaDhhSEtnMWNINjVKM3J6cXYyRFZvWXM0WGdN?=
 =?utf-8?B?TkZKamZJSjl4WXF4Q2FzdGdZS3hDa2tPSmh5ZGcvU3VHbVNDQ0p5UGx0MHdh?=
 =?utf-8?B?U2pBeklNYzMrYi93OXlOa1ZxbmxvcjQrZVRsRDJQSS80VWxwdXhoNFpwY3Q1?=
 =?utf-8?B?bCtmc0VDeDVmcGpIZElSYTNuQlZVVWF1ZXd2Tm9pV1M1d0F6MXdqQmJzZUlG?=
 =?utf-8?B?TFUwWWgrRHNJY1RDMkZQdlEzWWFKMTZuQ294ZE05eThab2JyOGd5cmdLY1Qw?=
 =?utf-8?B?L3UvUmdLRmRTVDYvUkdTRVF0K3dDazlmd05QNlRKZnkzc1dmMW82RmlhcE9Y?=
 =?utf-8?B?NzY1Y1NQbUNVZ2FPa0JjVm1JMTE4K01ZMk0ycTh4cjFGYWt3SmE5MFRKOUpn?=
 =?utf-8?B?NXgzdk5XMEg2VzREWkdBekpyZHRZYXhqWUNadTNrOE1ZQ1VuWnBSRlFXYVFh?=
 =?utf-8?B?RnBxemw1VXAvSFNkTlpTVDh1MzAvcHVDNkt0L2R3dEc0U2Z0dDNaNDExUHpY?=
 =?utf-8?B?TGUrVXROVzZpRnJlejN3cldTd2RsWmJ0ZmJucGErVUxsSVBVaXVrWUlzVFp3?=
 =?utf-8?B?ZW95b0I5MjFWN2ZES0xlSmlTb1hUU2t4eWFRbS9QSlpPR3hkdkw1ZVh4eDhz?=
 =?utf-8?B?azhKM0FIczBUaUo1anIrK2s2R0ZjaXVRcEdsSnhMOFkxVDd3emYwWFY2dk50?=
 =?utf-8?B?S3BFNElJdEdkYmIwUjY5R0U5RUNiMFB5bHd6ZXdRVXUrbTVVOXdOSlVFeS9o?=
 =?utf-8?B?U2p2M3orSDJJWHVOdnNGT2E3d0VmMklGVndaM3EvS3k0VHg1Tk5qeU9xQ3Nv?=
 =?utf-8?B?WkJ2YjBORFE5V0hUMGZqNml4RTRFeHRmTTBTbW04akY1TXUrVEF4dTBZWnRP?=
 =?utf-8?B?bWtodkRjRWFQNnJySHU2RzhIbDBHckw4MEY3TnROcGxjWUpaSUFDWnp5ajVn?=
 =?utf-8?B?WGdTY2h4NktKeTBScVFBL21jWGNsbG1TZlVXYkpwZktNZVNsVHFwYlBPbVVz?=
 =?utf-8?B?K1R1NzhLSzAyaGdPT0xpMjJnZTBOdGs2Y1FiR0RZVlpjbHlFTmJaRHhIOTBv?=
 =?utf-8?B?ZXhrVWQ3a05vTkJjS1ZyTHl5NU9HVnZqUUhkNFV3UzU4c1ljSjJPOFg1anlp?=
 =?utf-8?B?SUFqMWtNYklvb21SRlliazlsZlB1Wi9VbXRsZ0ZERE1oZkJkWGxVbEVqT0RX?=
 =?utf-8?B?WS9Xdlk1SFU1YWNuZ1JqeFNTUEtVZnh4UDdSalIxZkpaZHJiMmh5OGl6emZv?=
 =?utf-8?B?SVlTcWREdXpjRGF6b2c3ZFFEUmozWGVROFdMVHJnTHJZeHo0dktFU3BLaG1R?=
 =?utf-8?B?Ti93RCtqeUtJV0k5S3g3TXlDYUhneE1EZldSUGRSK2cxVEtmcXdqcmRUOENC?=
 =?utf-8?B?MkYvRTcxMEQzclE5Mkk5UlQ1cjd5SXdJK0tScTNydzBucVZ5aUhEZTNTaEcx?=
 =?utf-8?B?RGVGUnVDM1JhNW9NVUpWT1h0a1RVbU44US9zRVQ3TCs3K0dEMVREazBJT0RZ?=
 =?utf-8?B?TXJURElVMjFFbG92Mk5sKytCWlBTb2VnVVp0VjM4UHgzdlU3bTNtR3UwcmJP?=
 =?utf-8?B?T3hhaTRtR0RGODdaeXg4TDFkdEdKVDc2VU9XSVMzeDdIYnVxM1VJUzZpTnpr?=
 =?utf-8?B?WUpnOFdXUmpKbHFYK1BDYkJQeitueTJkNWg0ZUhEUzZRNnRxYTA4SVhCK2Nx?=
 =?utf-8?B?NDhJNUlYc0Q4Mzl0aVZwUFQ3VTZIT2dKRVFKZmQzL2tLVlRsdlMvdTk1cmRF?=
 =?utf-8?B?Y29FSDNoM01YdHA2QXA2U3RldDNseUZzUWJzVUc2bEc5bCszMWxBUWRPTFpK?=
 =?utf-8?B?eFcyUVhBOUZGYmIranBoQVlVV0dKVkhQUWozdU9lR0RTUzZmVFJQTTVsRVlF?=
 =?utf-8?Q?p2rg6FzMXJY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkQyZGhLckpodWFDVGg5YzRQc3c0eWVzTEVkWERzZm12aTFVY21wUmFxUHJ1?=
 =?utf-8?B?Z2VJd3Rha1VSSWJpajROQ29QUGQra0liZmNhVkw3S0t0U2dRTXN5VXp1eEFt?=
 =?utf-8?B?bUluNkJmVDF1S0ZTK2xuUFQyZERiQlpMYVpENnh0TzZCTDdINXJEbG9CUlJQ?=
 =?utf-8?B?TEZsZG5INXpVeVI4dmU0dEIzWjNGRVBIeEU3eHJ6VGF6WU1neWtNZzVCaUxH?=
 =?utf-8?B?cVhVN01vbHVNOE0wWDdrNWxURVhEblpBZ2RmRjF1c2h1a1IrNEkxT3FjRUNq?=
 =?utf-8?B?ZUNtaGVFSlFSSG4wRUJMSjlCRzFOSjNSVDc5djlsVmNFZ1EyWVdvU1ZNQldl?=
 =?utf-8?B?R3JkYmtZWVlzVGd2L1kvb1BySnpDQmlDU2ZuWUdhTjlmLzdJa0ZTUmVNWkJY?=
 =?utf-8?B?YkVCcmZINWw3NGRXbTRHWGJGeGVMNHR6YmFMQjZSbGtzKzZkemJtdTd2UEd5?=
 =?utf-8?B?N3JQYUlUdHpDMHVjcDgrSkZMUFpBZW9yYUIxc2tWek9mVGJrZ2dtRGM0dHlB?=
 =?utf-8?B?MHVITW1IUlJpNzRuNWc1aGtOd1BHWUNhWk4wa1Vvd2JlalluVk1lUGM5U3N0?=
 =?utf-8?B?dTArazI3RUQ2RjRJQTZsaVdRT2lheWxYeEZiSSsvVUZBRDFXSURsQk5iWU55?=
 =?utf-8?B?dEFldkYyRlpISksvTzVXYVVEZ3hBakpFNG5LSlcwSEZPRkVHQVJ2bTczdXVJ?=
 =?utf-8?B?eFJRKzVBeGZibjNDQlNuTHRMWGtFeEZiQjBzSzhrbFZTRHpydjUxVWZKcUV3?=
 =?utf-8?B?L3lqbjIxRGhlV29YUHhtdVVQMVZxdzFDS2VsNFNGbk0xMjJTQ3ZhQTgwSm5W?=
 =?utf-8?B?cXhxSHp2eE55WmxsaHdQVS9Td1hrQS9hWk16NEtFckJzMWhuekExbHVydHBU?=
 =?utf-8?B?RFBtdDdrVlJtK1Q5UWREY3RaSTBMVXJGMGdkbHFyckh2ZXhYdURsVklpS2Ja?=
 =?utf-8?B?S2xaeS9sS3htQnlTTEFWYTR3K3phellxbWx0ZjIvQVVFN1ZhWjFKOTdNaC9L?=
 =?utf-8?B?RXl4WERybExPdzg5QllrNTJBWWdVS1orazU3SjAvMXZiaEZzY1p2WFp5clhr?=
 =?utf-8?B?QVhBRDEwalVIdEIwYUU5b3d2dE9iWTJjUXBWM1gwZTAyVzZTaDV0VnJXaVF6?=
 =?utf-8?B?RElONW1JVVFhT3pIbW0zUnh4VWNRVTArV2gxcHhNNmZtQlhOeWxiZ0IzNE0w?=
 =?utf-8?B?ZzBxWllGZUhiSnByajFRcGlwa1o1NG5ocU9kY01zMURUSGV6clVRR3AzN3ZY?=
 =?utf-8?B?KzZBc2dFZU1PWE9SYzJuR2FrRk44S0xpSXJtOXNVR1IvMm0vbUt2eElmQW04?=
 =?utf-8?B?b24rUjdDMzM5aGw0ZXRpVUlNREhxclhBK29meVNpcmVzdzJrK3k3YWlzT01R?=
 =?utf-8?B?T25GWVM1eVhJQ3A2YUg5N2FjcFp4TFZXbzZTQ2J3emZ6c1g2eXl1NVVCQ2Y3?=
 =?utf-8?B?clhZaDlIRGVlZ3NoaTBPV2pVdGY3RVFtSDJBeEZyaVZpNTViSDlMQTUxeDNL?=
 =?utf-8?B?ZEtBWEFma2VXcTUwMFlweXVnRVk0cDI4WEN4Q2x4ZWdhNkI4NXlGL211WXNh?=
 =?utf-8?B?aGxmN1NKRmJtNlVmQlhQU1kvRVRLYjdYNDM4M0xLTFJnVlRpQ1o3ZTV5cHl3?=
 =?utf-8?B?ZUlKbGgyNXNYVUhmL1Y0a3pCeDdVNUJMZDUvZzFLcGJzY3VSSDZXZWYzM2oz?=
 =?utf-8?B?VXlwdC9BeFNQS1AwaSt4K0hySjk5M3BwZnBxTVN0UFNZbHM1UWQzZThkSDM1?=
 =?utf-8?B?bHNmcWZlby9wOHZiWGFEWUllNk9CeWk2V0h4a0FyY3phOTV4c0U5aWNpVjRK?=
 =?utf-8?B?Q0NlR01KTE1vQXBnbCtobHNralZTU0VINjNIaStYcFZtM2RabnR1NXhaci9O?=
 =?utf-8?B?V1dKK211T1ZjcUhQUWFISkw0VkcxR0RCZmsvT2FKbGF4T255a1NKbmJhYm55?=
 =?utf-8?B?Y3JKc0lzZEpHczlHYXY2TUFxSUtYVlRSZG1ZWGNvNnphbHgrRHgyejNUMVRM?=
 =?utf-8?B?Qm54RXBLcUE1Q1VIck1FOTRvRVhFb3BMRmNDNnVWZ1AxNFRubUs2VlVGVXda?=
 =?utf-8?B?MDZJb1pjSERkaWZ6S255TVpBUFZDUTd0WU5JeFhxNkpyUkNmMklUa2xtOFd4?=
 =?utf-8?Q?ulBeAtmzh9CejNxPcaoVS/V0D?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ab440a-455e-4aed-fc82-08dda2970e7f
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 12:06:22.5442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bwRzaVmC2ZIDKNSNhmw4KRlRERim6ukzgl6GwF3Rje9ESoY0S7SMkKHhbD8GaJUU5+YRg/2uwPYLzG/lijPfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P195MB2407
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

Hi Martin,

Am 02.06.25 um 14:31 schrieb Martin Schwan:
> Add a bootmeth driver which supports booting A/B system with RAUC as
> their update client.
> 
> Signed-off-by: Martin Schwan <m.schwan@phytec.de>
> ---
>   boot/Kconfig         |  51 ++++++
>   boot/Makefile        |   1 +
>   boot/bootmeth_rauc.c | 432 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 484 insertions(+)
> 
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 30eb5b328d7ad8a73a2e84812dd7853b66039164..a610cf9faf99cd5480f94dcac89c3401cca394ae 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -855,6 +855,57 @@ config EXPO
>   	  The expo can be presented in graphics form using a vidconsole, or in
>   	  text form on a serial console.
>   
> +config BOOTMETH_RAUC
> +	bool "Bootdev support for RAUC A/B systems"
> +	default y if BOOTSTD_FULL
> +	depends on CMDLINE
> +	select BOOTMETH_GLOBAL
> +	select HUSH_PARSER
> +	help
> +	  Enables support for booting RAUC A/B systems from MMC devices. This
> +	  makes the bootdevs look for a 'boot.scr.uimg' or 'boot.scr' in the
> +	  respective boot partitions, describing how to boot the distro.
> +
> +if BOOTMETH_RAUC
> +
> +config BOOTMETH_RAUC_BOOT_ORDER
> +	string "RAUC boot order"
> +	default "A B"
> +	help
> +	  Sets the default boot order. This must be list of space-separated
> +	  strings naming the individual boot slots. Each entry in this string
> +	  should correspond to an existing slot on the target's flash device.
> +
> +config BOOTMETH_RAUC_PARTITIONS
> +	string "RAUC boot and root partitions indexes"
> +	default "1,2 3,4"
> +	help
> +	  Sets the partition indexes of boot and root slots. This must be a list
> +	  of comma-separated pair values, which in turn are separated by spaces.
> +	  The first value in pair is for the boot partition and second for the
> +	  root partition.
> +
> +config BOOTMETH_RAUC_DEFAULT_TRIES
> +	int "RAUC slot default tries"
> +	default 3
> +	help
> +	  Sets how many times a slot should be tried booting, before considering
> +	  it to be bad.
> +
> +config BOOTMETH_RAUC_RESET_ALL_ZERO_TRIES
> +	bool "Reset slot tries when all RAUC slots have zero tries left"
> +	default y
> +	help
> +	  When all slots have zero tries left or no valid slot was found, reset
> +	  to the default boot order set by BOOTMETH_RAUC_BOOT_ORDER and set the
> +	  slot tries to their default value specified by
> +	  BOOTMETH_RAUC_DEFAULT_TRIES.
> +
> +	  This prevents a system from remaining in an unbootable state, after
> +	  all slot tries were decremented to zero.
> +
> +endif # BOOTMETH_RAUC
> +
>   config BOOTMETH_SANDBOX
>   	def_bool y
>   	depends on SANDBOX
> diff --git a/boot/Makefile b/boot/Makefile
> index 71dafaefa76bca7896741dd896829575bd9e8f10..46f27e71856c598a866424cb93ee01444ea6a19a 100644
> --- a/boot/Makefile
> +++ b/boot/Makefile
> @@ -32,6 +32,7 @@ obj-$(CONFIG_$(PHASE_)BOOTMETH_EXTLINUX_PXE) += bootmeth_pxe.o
>   obj-$(CONFIG_$(PHASE_)BOOTMETH_EFILOADER) += bootmeth_efi.o
>   obj-$(CONFIG_$(PHASE_)BOOTMETH_CROS) += bootm.o bootm_os.o bootmeth_cros.o
>   obj-$(CONFIG_$(PHASE_)BOOTMETH_QFW) += bootmeth_qfw.o
> +obj-$(CONFIG_$(PHASE_)BOOTMETH_RAUC) += bootmeth_rauc.o
>   obj-$(CONFIG_$(PHASE_)BOOTMETH_SANDBOX) += bootmeth_sandbox.o
>   obj-$(CONFIG_$(PHASE_)BOOTMETH_SCRIPT) += bootmeth_script.o
>   obj-$(CONFIG_$(PHASE_)CEDIT) += cedit.o
> diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..4d48d643c0a727d5ebd5f3514c173f0dd824b7cd
> --- /dev/null
> +++ b/boot/bootmeth_rauc.c
> @@ -0,0 +1,432 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Bootmethod for distro boot with RAUC
> + *
> + * Copyright 2025 PHYTEC Messtechnik GmbH
> + * Written by Martin Schwan <m.schwan@phytec.de>
> + */
> +
> +#define LOG_CATEGORY UCLASS_BOOTSTD
> +
> +#include <blk.h>
> +#include <bootflow.h>
> +#include <bootmeth.h>
> +#include <bootstd.h>
> +#include <dm.h>
> +#include <env.h>
> +#include <fs.h>
> +#include <malloc.h>
> +#include <mapmem.h>
> +#include <string.h>
> +#include <asm/cache.h>
> +
> +/* Length of env var "BOOT_*_LEFT" */
> +#define BOOT_LEFT_LEN	(5 + 32 + 5)
> +
> +static const char * const script_names[] = { "boot.scr", "boot.scr.uimg", NULL };
> +
> +/**
> + * struct distro_rauc_slot - Slot information
> + *
> + * A slot describes the unit of a bootable system consisting of one or multiple
> + * partitions. This usually includes a root filesystem, kernel and potentially other
> + * files, like device trees and boot scripts for that particular distribution.
> + *
> + * @name	The slot name
> + * @boot_part	The boot partition number on disk
> + * @root_part	The root partition number on disk
> + */
> +struct distro_rauc_slot {
> +	char *name;
> +	int boot_part;
> +	int root_part;
> +};
> +
> +/**
> + * struct distro_rauc_priv - Private data
> + *
> + * @slots	All slots of the device in default order
> + * @boot_order	String of the current boot order containing the active slot names
> + */
> +struct distro_rauc_priv {
> +	struct distro_rauc_slot **slots;
> +};
> +
> +static struct distro_rauc_slot *get_slot(struct distro_rauc_priv *priv,
> +					 const char *slot_name)
> +{
> +	int i;
> +
> +	for (i = 0; priv->slots[i]->name; i++) {
> +		if (!strcmp(priv->slots[i]->name, slot_name))
> +			return priv->slots[i];
> +	}
> +
> +	return NULL;
> +}
> +
> +static int distro_rauc_check(struct udevice *dev, struct bootflow_iter *iter)
> +{
> +	/*
> +	 * This distro only works on whole MMC devices, as multiple partitions
> +	 * are needed for an A/B system.
> +	 */
> +	if (bootflow_iter_check_mmc(iter))
> +		return log_msg_ret("mmc", -EOPNOTSUPP);
> +	if (iter->part)
> +		return log_msg_ret("part", -EOPNOTSUPP);
> +
> +	return 0;
> +}
> +
> +static int distro_rauc_scan_boot_part(struct bootflow *bflow)
> +{
> +	struct blk_desc *desc;
> +	struct distro_rauc_priv *priv;
> +	char *boot_order;
> +	const char **boot_order_list;
> +	bool exists;
> +	int ret;
> +	int i;
> +	int j;
> +
> +	desc = dev_get_uclass_plat(bflow->blk);
> +
> +	priv = bflow->bootmeth_priv;
> +	if (!priv || !priv->slots)
> +		return log_msg_ret("priv", -EINVAL);
> +
> +	boot_order = env_get("BOOT_ORDER");
> +	boot_order_list = str_to_list(boot_order);
> +	for (i = 0; boot_order_list[i]; i++) {
> +		exists = false;
> +		for (j = 0; script_names[j]; j++) {
> +			const struct distro_rauc_slot *slot;
> +
> +			slot = get_slot(priv, boot_order_list[i]);
> +			if (!slot)
> +				return log_msg_ret("env", -ENOENT);
> +			ret = fs_set_blk_dev_with_part(desc, slot->boot_part);
> +			if (ret)
> +				return log_msg_ret("blk", ret);
> +			exists |= fs_exists(script_names[j]);
> +		}
> +		if (!exists)
> +			return log_msg_ret("fs", -ENOENT);
> +	}
> +	str_free_list(boot_order_list);
> +
> +	return 0;
> +}
> +
> +static int distro_rauc_read_bootflow(struct udevice *dev, struct bootflow *bflow)
> +{
> +	struct distro_rauc_priv *priv;
> +	int ret;
> +	char *slot;
> +	int i;
> +	char *partitions;
> +	char *boot_order;
> +	const char *default_boot_order;
> +	const char **default_boot_order_list;
> +	char *boot_order_copy;
> +	char boot_left[BOOT_LEFT_LEN];
> +	char *parts;
> +
> +	/* Get RAUC variables or set their default values */
> +	boot_order = env_get("BOOT_ORDER");
> +	if (!boot_order) {
> +		log_debug("BOOT_ORDER did not exist yet, setting default value\n");
> +		if (env_set("BOOT_ORDER", CONFIG_BOOTMETH_RAUC_BOOT_ORDER))
> +			return log_msg_ret("env", -EPERM);
> +		boot_order = CONFIG_BOOTMETH_RAUC_BOOT_ORDER;
> +	}
> +	default_boot_order = CONFIG_BOOTMETH_RAUC_BOOT_ORDER;
> +	default_boot_order_list = str_to_list(default_boot_order);
> +	for (i = 0; default_boot_order_list[i]; i++) {
> +		sprintf(boot_left, "BOOT_%s_LEFT", default_boot_order_list[i]);
> +		if (!env_get(boot_left)) {
> +			log_debug("%s did not exist yet, setting default value\n",
> +				  boot_left);
> +			if (!env_set_ulong(boot_left, CONFIG_BOOTMETH_RAUC_DEFAULT_TRIES))

I noticed failures when I was testing. It should be inverted, 
env_set_ulong() returns 0 if OK, 1 on error.

Regards,
Wadim

> +				return log_msg_ret("env", -EPERM);
> +		}
> +	}
> +	str_free_list(default_boot_order_list);
> +
> +	priv = calloc(1, sizeof(struct distro_rauc_priv));
> +	if (!priv)
> +		return log_msg_ret("buf", -ENOMEM);
> +	priv->slots = calloc(1, sizeof(struct distro_rauc_slot));
> +
> +	/* Copy default boot_order, so we can leave the original unmodified */
> +	boot_order_copy = strdup(default_boot_order);
> +	partitions = strdup(CONFIG_BOOTMETH_RAUC_PARTITIONS);
> +
> +	for (i = 1;
> +	     (parts = strsep(&partitions, " ")) &&
> +	     (slot = strsep(&boot_order_copy, " "));
> +	     i++) {
> +		struct distro_rauc_slot *s;
> +
> +		s = calloc(1, sizeof(struct distro_rauc_slot));
> +		s->name = strdup(slot);
> +		s->boot_part = simple_strtoul(strsep(&parts, ","), NULL, 10);
> +		s->root_part = simple_strtoul(strsep(&parts, ","), NULL, 10);
> +		priv->slots = realloc(priv->slots, (i + 1) *
> +				      sizeof(struct distro_rauc_slot));
> +		priv->slots[i - 1] = s;
> +		priv->slots[i]->name = NULL;
> +	}
> +
> +	bflow->bootmeth_priv = priv;
> +
> +	ret = distro_rauc_scan_boot_part(bflow);
> +	if (ret < 0) {
> +		for (i = 0; priv->slots[i]->name; i++) {
> +			free(priv->slots[i]->name);
> +			free(priv->slots[i]);
> +		}
> +		free(priv);
> +		free(boot_order_copy);
> +		bflow->bootmeth_priv = NULL;
> +		return ret;
> +	}
> +
> +	bflow->state = BOOTFLOWST_READY;
> +
> +	return 0;
> +}
> +
> +static int distro_rauc_read_file(struct udevice *dev, struct bootflow *bflow,
> +				 const char *file_path, ulong addr,
> +				 enum bootflow_img_t type, ulong *sizep)
> +{
> +	/*
> +	 * Reading individual files is not supported since we only operate on
> +	 * whole MMC devices (because we require multiple partitions).
> +	 */
> +	return log_msg_ret("Unsupported", -ENOSYS);
> +}
> +
> +static int distro_rauc_load_boot_script(struct bootflow *bflow,
> +					const struct distro_rauc_slot *slot)
> +{
> +	struct blk_desc *desc;
> +	struct distro_rauc_priv *priv;
> +	struct udevice *bootstd;
> +	const char *const *prefixes;
> +	int ret;
> +	int i;
> +	int j;
> +
> +	ret = uclass_first_device_err(UCLASS_BOOTSTD, &bootstd);
> +	if (ret)
> +		return log_msg_ret("std", ret);
> +	prefixes = bootstd_get_prefixes(bootstd);
> +
> +	desc = dev_get_uclass_plat(bflow->blk);
> +	priv = bflow->bootmeth_priv;
> +	if (!priv || !priv->slots)
> +		return log_msg_ret("priv", -EINVAL);
> +
> +	bflow->part = slot->boot_part;
> +	if (!bflow->part)
> +		return log_msg_ret("part", -ENOENT);
> +
> +	ret = bootmeth_setup_fs(bflow, desc);
> +	if (ret)
> +		return log_msg_ret("set", ret);
> +
> +	for (i = 0; prefixes[i] && bflow->state != BOOTFLOWST_FILE; i++) {
> +		for (j = 0; script_names[j] && bflow->state != BOOTFLOWST_FILE; j++) {
> +			if (!bootmeth_try_file(bflow, desc, prefixes[i], script_names[j])) {
> +				log_debug("Found file '%s%s' in %s.part_%x\n",
> +					  prefixes[i], script_names[j],
> +					  bflow->dev->name, bflow->part);
> +				bflow->subdir = strdup(prefixes[i]);
> +			}
> +		}
> +	}
> +	if (bflow->state != BOOTFLOWST_FILE)
> +		return log_msg_ret("file", -ENOENT);
> +
> +	ret = bootmeth_alloc_file(bflow, 0x10000, ARCH_DMA_MINALIGN,
> +				  (enum bootflow_img_t)IH_TYPE_SCRIPT);
> +	if (ret)
> +		return log_msg_ret("read", ret);
> +
> +	return 0;
> +}
> +
> +static int find_active_slot(char **slot_name, ulong *slot_tries)
> +{
> +	ulong tries;
> +	char boot_left[BOOT_LEFT_LEN];
> +	char *boot_order;
> +	const char **boot_order_list;
> +	bool slot_found = false;
> +	int ret;
> +	int i;
> +
> +	boot_order = env_get("BOOT_ORDER");
> +	if (!boot_order)
> +		return log_msg_ret("env", -ENOENT);
> +	boot_order_list = str_to_list(boot_order);
> +	for (i = 0; boot_order_list[i] && !slot_found; i++) {
> +		sprintf(boot_left, "BOOT_%s_LEFT", boot_order_list[i]);
> +		tries = env_get_ulong(boot_left, 10, ULONG_MAX);
> +		if (tries == ULONG_MAX)
> +			return log_msg_ret("env", -ENOENT);
> +
> +		if (tries) {
> +			ret = env_set_ulong(boot_left, tries - 1);
> +			if (ret)
> +				return log_msg_ret("env", ret);
> +			*slot_name = strdup(boot_order_list[i]);
> +			*slot_tries = tries;
> +			slot_found = true;
> +		}
> +	}
> +	str_free_list(boot_order_list);
> +
> +	if (!slot_found) {
> +		if (IS_ENABLED(CONFIG_BOOTMETH_RAUC_RESET_ALL_ZERO_TRIES)) {
> +			log_warning("WARNING: No valid slot found\n");
> +			log_info("INFO: Resetting boot order and all slot tries\n");
> +			boot_order_list = str_to_list(CONFIG_BOOTMETH_RAUC_BOOT_ORDER);
> +			for (i = 0; boot_order_list[i]; i++) {
> +				sprintf(boot_left, "BOOT_%s_LEFT", boot_order_list[i]);
> +				ret = env_set_ulong(boot_left, CONFIG_BOOTMETH_RAUC_DEFAULT_TRIES);
> +				if (ret)
> +					return log_msg_ret("env", ret);
> +			}
> +			str_free_list(boot_order_list);
> +			ret = env_save();
> +			if (ret)
> +				return log_msg_ret("env", ret);
> +			do_reset(NULL, 0, 0, NULL);
> +		}
> +		log_err("ERROR: No valid slot found\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int distro_rauc_boot(struct udevice *dev, struct bootflow *bflow)
> +{
> +	struct blk_desc *desc;
> +	struct distro_rauc_priv *priv;
> +	const struct distro_rauc_slot *slot;
> +	char *boot_order;
> +	const char **boot_order_list;
> +	char *active_slot;
> +	ulong active_slot_tries;
> +	char raucargs[64];
> +	char boot_left[BOOT_LEFT_LEN];
> +	ulong addr;
> +	int ret = 0;
> +	int i;
> +
> +	desc = dev_get_uclass_plat(bflow->blk);
> +	if (desc->uclass_id != UCLASS_MMC)
> +		return log_msg_ret("blk", -EINVAL);
> +	priv = bflow->bootmeth_priv;
> +
> +	/* Device info variables */
> +	ret = env_set("devtype", blk_get_devtype(bflow->blk));
> +	if (ret)
> +		return log_msg_ret("env", ret);
> +
> +	ret = env_set_hex("devnum", desc->devnum);
> +	if (ret)
> +		return log_msg_ret("env", ret);
> +
> +	/* Find active, valid slot */
> +	ret = find_active_slot(&active_slot, &active_slot_tries);
> +	if (ret)
> +		return log_msg_ret("env", ret);
> +
> +	/* Kernel command line arguments */
> +	sprintf(raucargs, "rauc.slot=%s", active_slot);
> +	ret = env_set("raucargs", raucargs);
> +	if (ret)
> +		return log_msg_ret("env", ret);
> +
> +	/* Active slot info */
> +	slot = get_slot(priv, active_slot);
> +	if (!slot)
> +		return log_msg_ret("env", -ENOENT);
> +	ret = env_set_hex("distro_bootpart", slot->boot_part);
> +	if (ret)
> +		return log_msg_ret("env", ret);
> +	ret = env_set_hex("distro_rootpart", slot->root_part);
> +	if (ret)
> +		return log_msg_ret("env", ret);
> +	ret = env_save();
> +	if (ret)
> +		return log_msg_ret("env", ret);
> +
> +	/* Load distro boot script */
> +	ret = distro_rauc_load_boot_script(bflow, slot);
> +	if (ret)
> +		return log_msg_ret("load", ret);
> +
> +	log_info("INFO: Booting slot %s, %lu of %d tries left\n",
> +		 active_slot, active_slot_tries, CONFIG_BOOTMETH_RAUC_DEFAULT_TRIES);
> +
> +	log_debug("devtype: %s\n", env_get("devtype"));
> +	log_debug("devnum: %s\n", env_get("devnum"));
> +	log_debug("distro_bootpart: %s\n", env_get("distro_bootpart"));
> +	log_debug("distro_rootpart: %s\n", env_get("distro_rootpart"));
> +	log_debug("raucargs: %s\n", env_get("raucargs"));
> +	boot_order = env_get("BOOT_ORDER");
> +	if (!boot_order)
> +		return log_msg_ret("env", -EPERM);
> +	log_debug("BOOT_ORDER: %s\n", boot_order);
> +	boot_order_list = str_to_list(boot_order);
> +	for (i = 0; boot_order_list[i]; i++) {
> +		sprintf(boot_left, "BOOT_%s_LEFT", boot_order_list[i]);
> +		log_debug("%s: %s\n", boot_left, env_get(boot_left));
> +	}
> +	str_free_list(boot_order_list);
> +
> +	/* Run distro boot script */
> +	addr = map_to_sysmem(bflow->buf);
> +	ret = cmd_source_script(addr, NULL, NULL);
> +	if (ret)
> +		return log_msg_ret("boot", ret);
> +
> +	return 0;
> +}
> +
> +static int distro_rauc_bootmeth_bind(struct udevice *dev)
> +{
> +	struct bootmeth_uc_plat *plat = dev_get_uclass_plat(dev);
> +
> +	plat->desc = "RAUC distro boot from MMC";
> +	plat->flags = BOOTMETHF_GLOBAL;
> +
> +	return 0;
> +}
> +
> +static struct bootmeth_ops distro_rauc_bootmeth_ops = {
> +	.check		= distro_rauc_check,
> +	.read_bootflow	= distro_rauc_read_bootflow,
> +	.read_file	= distro_rauc_read_file,
> +	.boot		= distro_rauc_boot,
> +};
> +
> +static const struct udevice_id distro_rauc_bootmeth_ids[] = {
> +	{ .compatible = "u-boot,distro-rauc" },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(bootmeth_rauc) = {
> +	.name		= "bootmeth_rauc",
> +	.id		= UCLASS_BOOTMETH,
> +	.of_match	= distro_rauc_bootmeth_ids,
> +	.ops		= &distro_rauc_bootmeth_ops,
> +	.bind		= distro_rauc_bootmeth_bind,
> +};
> 

