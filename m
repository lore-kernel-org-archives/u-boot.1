Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E667BC369C9
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 11:27:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 758AA82A31;
	Fri, 18 Apr 2025 13:27:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="nUFVx9oe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F10182C15; Fri, 18 Apr 2025 13:27:50 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::601])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E93F810EA
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 13:27:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZ+MYdtHkuWI5+yv6FiM/GkwFMbLfN6unNqGEnm3UZoujX3WubrdsKsqIsTLivddV678TcahagG0BuU3k7Nxv8rOvZ4V+PoAbNKdGuI9Is1A3I0KRCsREZiI3vGAuUo7qlYgdK4kzAGH485GPneCMGGqGfWAM83b+G+sL2A0L3NzSY1sIfRxVk66kW9CfVEV+WM+0JoOg/Vkr8mzLj/IOCBF/sz6je60zIxVP4U3Fu/ZEA2/O2UzhAppTro96oex+6HMmKQokiSLjZoe6As1jbNUJww1xkv3ES+jD1pno+JUgiJwKEj9+JnTTGsWQSnbfzEykUt5K7ApraTuAuulSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trTLPWrUirevvsKaCjG0JOOqxBqLj425gcZcj+Kx3dw=;
 b=MdAZOXwZ37FuOuwbFzcY0D8o6F3aIW1oexJ4FXfXLZCTLBgdAI3ZnTlWbqFZgSxBcO+t8BCobyS0WqhaWXDhf17W0OlMeI1lEFuhhSpU6rfCFtImBSkduc6M+PGOTHYf+DeoSvaUUKwFnN+eIzBKCxI+qxVJiNMTwVjsYLVSPAeRd9tqPIdSzLHaH8puJJ4cVO4M7eu2QEVeU2V7wuWjqwX9yDDGcDsfs1zsAQzOB0m73Yij2wwox6Bz+PCJc4Et4kquBJTRc3Wb4DPPl06NZ8UwevtMaIoSVSS+bg3vpuh6Wi5LBfddTeqdfkKVpkGX6e+3nKm3HJ9ydVadRlPAnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trTLPWrUirevvsKaCjG0JOOqxBqLj425gcZcj+Kx3dw=;
 b=nUFVx9oew83i2ziVl/If5G7Si6kkfT5PiXcAPlF9Hlhm6bIHOizkF5t/jUXOoxgbgChVeHNOwCEQsDC/8cmnU1/dcmgln6rDWiWeQfWnL8cV5kVAC0+QXeK/cOW7pe/hV1kIHv3FybINE9f0GxsUcVK/92uHfUlJynNB8HI/KOk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by VI0PR04MB10542.eurprd04.prod.outlook.com (2603:10a6:800:265::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 18 Apr
 2025 11:27:46 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%6]) with mapi id 15.20.8632.030; Fri, 18 Apr 2025
 11:27:46 +0000
Message-ID: <d8f9a58a-10cd-4366-bd6f-85f4effc747c@cherry.de>
Date: Fri, 18 Apr 2025 13:27:44 +0200
User-Agent: Mozilla Thunderbird
From: Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v2 1/3] buildman: allow specifying configuration fragments
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>, u-boot@lists.denx.de
References: <20250416224032.144791-1-heinrich.schuchardt@canonical.com>
 <20250416224032.144791-2-heinrich.schuchardt@canonical.com>
Content-Language: en-US
In-Reply-To: <20250416224032.144791-2-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::19) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|VI0PR04MB10542:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d568201-52b0-4ae8-a93b-08dd7e6c0b14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cm1lWlF2TFRJYU9wZWJaZE5TdWxxenp4eTA4R1h0T0lIN29QQ2FzNnhtT1FC?=
 =?utf-8?B?YVlhdUFmZXRwTlE4bDhqNWM2QnpZY3d0TG5kQUpKbnBaTnM0QUFMcFhpUXRl?=
 =?utf-8?B?V1pYcC9jMVRORkRsQkZYblpqMDZqVTY5TmN2THVFcVRNMmJ1Zlh3TU9hWkYv?=
 =?utf-8?B?TEhHem8zRFl3RXNucm96NG92bUw0cFVUell6b0hITFdvazg5UmhGRyt0VlM5?=
 =?utf-8?B?dzhsNjI1S2l4cys4eXpCL2dPU28yZlFyQWdOTnNReTlxMlJzbDI5bE84N0ZS?=
 =?utf-8?B?NmZhTk1BSk1TUTZITkZ0eDFxdG9ENEFnSFhweFhMTHh2VnlGTFlxSzVTMUx0?=
 =?utf-8?B?eXAyNS9MN2RvVUhseGdiRnJXaFl2aTVwTVJCSG5ueGd5ZnY4NDBGd2l5RFho?=
 =?utf-8?B?ek1vTWN3bW0zWjZVSG5IaUpJa0liZXp2a0VrUHdlSTA0ZWhGS0F2UkdMS1M5?=
 =?utf-8?B?OW9rWENqQW9uNFR3dlk2Q2Z2UUdiRWE3enJmcUxEZU95LzJ3TlhUWFdxaTNx?=
 =?utf-8?B?KzJubjUrYW4yeFVxS3FtT2ROWTRlZHpJcVZxbys1emtUbnhWaEZBS0NrV29K?=
 =?utf-8?B?UndCNkgwOHNOQVBMOXdZaUxHMEN2RStDRU9mMG9qQUdkMlRPN3lpZjdCWDJw?=
 =?utf-8?B?UFNZbjNYOTZDZDkzVWZJeHFSbnpEOVpjMHlvVHBnSDNjd0w4eGlVdTNnTWJx?=
 =?utf-8?B?VFhBWU9vZlllQzdsMUJMZ3gvTmYxWk9XaGNodWFlMTRqQXFnbFgzTXYzRHVu?=
 =?utf-8?B?UkZjbytac3lTVHRqVk9reWNVV0dOWjAyY1ZUSVZiemVjbmxhYkVaK0dXeEdH?=
 =?utf-8?B?b281eDdTWFkrRzJja0kxNVZmSW1IbnhJQkdGTGltUmpYcDh2R0ZOWnBkN3ZV?=
 =?utf-8?B?YklPK1B3Q29MeExRMk5lY3VjOUZpL0J3YzNQMFNRWkZnaFltdDVRYmNFZXJo?=
 =?utf-8?B?eGtBUVIvT0hUU0pBUXZGUHlwKzhtVnU5NTkzbThxVnN2cVNqeUZBRWNlTy9R?=
 =?utf-8?B?cmVhODNzZXRqNnFOMjBWNU5KeDBkUWlMZzJTTmlYU2hvbytBZFJQTE04Unpv?=
 =?utf-8?B?OW9DSktSRDZ2SzNtVWY2NlhQWXVzWWxJWTc0RlhsUjNkM1pBakU5WndydHli?=
 =?utf-8?B?UzNRa1BFYXhKaE1wNWJtTW5ZTXZvLzUrK2dXRUdTeUFFTmMxYjdqeit1K1RO?=
 =?utf-8?B?Y2xsQnNqRmorNG1nTml2Q3YvWThZdThIbzJLK3UwbTlsOEEwUEZlMFpJNmVJ?=
 =?utf-8?B?RWdTQ25mZWFVb3pCN29mcjc5Z0NkZkdoa1k4S2xmdEFwQ0xYWjBWVnY3RmxQ?=
 =?utf-8?B?RlBtYzdqQzhyWUwzb2JNcE9UendQNHFYTGRTZmtKa3I5L2JadE0zTjBoR1RH?=
 =?utf-8?B?K0NlTWhEMHd6T205YkE5Mi82YUQ3K0MrSTV2b3pjNnU2S3FVdmdnb3IzSjZQ?=
 =?utf-8?B?M29LUnJHQ2JwTlhId1g5Wk51Z3ZkL1kzV2hvNGFBWjFEN2haUnY0OU9WNHgr?=
 =?utf-8?B?eDVWRVZXbGRCRS9PNnJGUjVTUWVaVXN3d2JuWU90cHIzUllMdXIrL2JTS2d5?=
 =?utf-8?B?UnNPTDhCRXhJR3k5R2NqZ3dSLys1dm8yRElRbTJKSld0aWdwak1GdXp0WHdV?=
 =?utf-8?B?UDNLR2ZSM2JjQTFmTWcwcXJHK3Z6UThnUHpLdmFTa2gyN2hmd0lmT2NjRjc0?=
 =?utf-8?B?L2F5bkhwdm5XV1hMZXpHQWRRdE1RcGw2bVJDamJIdnZlSjB0dVNNNDdiRVZR?=
 =?utf-8?B?NzI3UXdjWnVIaUNON2NyOGVKbCtMYWR5ajc4ZEI4M3ZIcE1xd1FWenpFVlZY?=
 =?utf-8?B?Q0Jyd09SRmZRZDlSMTNyYmxJY3FiZk5MYUdubld3ZytOVG91TC9oenFUdFdS?=
 =?utf-8?B?ODRxdHY3SjV0YzhJa3BNM1VBbjNvVXRDYWxRYmoxNkhIQ0FHeGhKWk1CcXVB?=
 =?utf-8?Q?DtLQgEi53ow=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjFtRWpZbzNOb0UrSTJKaUlNU2pKalc4dFY5K09RZmVvb2ZpdjEwbHR0WWhG?=
 =?utf-8?B?NU1IeWNEamwwNzh1enU3QnNubFZpRlkxaXloUTQ3VWtDNmxBQm0zWUljREVO?=
 =?utf-8?B?V1k5VzYzTUNGcFJURTIyeXFXODJiSHhndFNwalBhY2JjUjBFV1hWcXVWSXQx?=
 =?utf-8?B?b0oxckU1NFlhSmpjeWNhQTU0WGphc2ZJY3Z3VW9Ra2Urc0tpVi9jVVdkbWYw?=
 =?utf-8?B?UWR4Y2VRYWhWS1NmeUxsbE1obmNUbXcwQnZVc0dMSGNQcU1QemwyYTF0QUhj?=
 =?utf-8?B?aWkzazBVNVh5WERDbC8vaGt4bFZZM1I5eG9Cd1ZIZG5FZG9SRHQzYzhSRVZj?=
 =?utf-8?B?SjdCMTEwSUJoVDlLSWJQcDdud1pmcWlvOUpIclNPSEtIeU94T1hMd0hxYVY0?=
 =?utf-8?B?NUE4a2JQWGRHTFdhMlJaNVpTeFI3K01qK1hSa2RxQmQzMlVPWTlPOW9acUky?=
 =?utf-8?B?NXBPT3QzRGtpV3ppYTB1SDU0bVFuN0FvZVNpY3RGVFBOSyt6QjV5WERZVnVq?=
 =?utf-8?B?YTNNbk5GMlNrdmZpdFpKUXF1MXZjNDl2cWo4VFZMNGpLdEpNWVk3cVFIN0Ex?=
 =?utf-8?B?by8rZnpnWHBBWSs1aVhSbDhEUVJvcjBTaVJuMEVxQm5qZWYxaysxN1diaXJw?=
 =?utf-8?B?eWRVSGI2anUyVk1MOHpaSHpDR0lkeEwvY0I3ZWtkOTBXS0NPeWlvd3RlZzNa?=
 =?utf-8?B?ZnpqdGw2anFtdHNWMCtsdU5KU29jREpnWnhUdG1ZVUp5M2d5RzQwSFlNNTR4?=
 =?utf-8?B?SHZnYzhGL3NyMFA4MUM5cGw0L1YvelM2S1hmNzVRcVd4dDNkNG9jUzRUVHl2?=
 =?utf-8?B?d1pLYnpGU2Y3MFh0enJjNER3eFF3blY0ZTNnSHozcndnVWJUa1RsUGhuRDFI?=
 =?utf-8?B?OWUvZjlLdjB5TDBHKzIxVjR0bXYyS1pjcGl1ZHZlcVFxajZ4NlVKaksyMDYv?=
 =?utf-8?B?YjFGbFVTRUdUb2VOS1pSY2YzbUE2cXA1dmZIdjJ5NWJQTmVoWE0ycnlkYkll?=
 =?utf-8?B?bVB6bC9KL043VG9obm9iVzJjWlNVSWVIQjhJT3BSamY0d3A3VTRGT296Y0tO?=
 =?utf-8?B?bXJyZ2RBUEhLSzlOSG5VMjk5Q1kxekJQRHd3UjhzWWlKWVZrZDQ3VnFwNGdo?=
 =?utf-8?B?REJvZk9zeHRhd08zdVlhYzhWMmduRThHNUQwd2JhTXJrcysvOVNRUFhDS0o2?=
 =?utf-8?B?VUl6MUdHanByUzBPQ1FTVUJPbzlVQi81amdyOTdmZUFkKzBGSExZM091MHJL?=
 =?utf-8?B?Rkh1N0gvNG90K2ZQVk1kdmVSN3FlNkNPaERQRVpOTkJQbThEVXdDVlF2Qkhu?=
 =?utf-8?B?ekdsbGpZb2o4SUJqSW1nRWdjemdEK3hFUTV6T3ExbnNIK2x6MTdrbFpscWdv?=
 =?utf-8?B?K0V2RStybmRKK0dUZHRHVlNGcTlvdHE3QlUxczdCSUZwUkZjK0l4MUxPLy9r?=
 =?utf-8?B?T3FYQk5lalFhSytoOXh3bk1aVk44aGU3LzFnaDBnb25FcFdiQnRGeTltb2tq?=
 =?utf-8?B?T2EwK2trMVJETzVWR0JxcE82alJpMWd0b3NTY29XSnFCdGdUck1paVpjVXdX?=
 =?utf-8?B?ZDlEbThhaDJ4NlF0N1NOTEhiV1BleTU3TE0wMGEwTml1bEErTEhjMGw1dFJE?=
 =?utf-8?B?THhxdUlLY1N3djNIdVdPTnJLWStpTHJWOWZMSnFTMDB3WFZ5TFBoTnZWSGFU?=
 =?utf-8?B?OWNrVEd3K291RThzT004L3A3eHZXSzA0ZWU4clg3UnNYWUg4U2x4aHh6YlJY?=
 =?utf-8?B?MVVtU0cwbDhYVWd1aXZKQVlqNTZoYVptMkhMRlN1YzF0UUNwY1NVTVJaQ216?=
 =?utf-8?B?U1VuSXpGK0lwM05JNjJZV1lxcmwzdEtaZ0VUQkZSYlNTdDIvanhyVElsczcx?=
 =?utf-8?B?OCttcFc1b1BzeGt4SE9oamtRcXBlcjZvd0NzZ3B2empZZ2l2NmN0SEpOU3BI?=
 =?utf-8?B?UGM1WWFoY3F6bDB1NkxjSElGZ0FHL0EzN0IyOVR5QWlUalFCemdWb2V1OHRq?=
 =?utf-8?B?Z3hMRVNIMmlKcy84TnUyaXUrZklOSjFjNHBnaW1QbjhSNXUrREUxYWJyZmJX?=
 =?utf-8?B?L2hPTERaVW51aHRjZFdMeVBGYjFZayswMXV3c2tKRm1henQvZjFOUk5NaTM5?=
 =?utf-8?B?dHplTnF4VTNsMGRycXh0dW1IU1V1MUI5N2RxRitzVUZ4YytVZit3bzRuVkRl?=
 =?utf-8?B?UHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d568201-52b0-4ae8-a93b-08dd7e6c0b14
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 11:27:46.5585 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T5PQxEJfrWDgEfiCT+PXrt5c8P1S4TDDnjny+Cnj3wX3irblLWrG8T4hRdthScb4OU1gD4kEcB6DfbsKEAO/3yhvckvG6Z24NGNAJ/to4Ro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10542
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

Hi Heinrich,

On 4/17/25 12:40 AM, Heinrich Schuchardt wrote:
> Currently we are no able to build with configuration fragments in our CI.
> With this patch buildman gets a new argument --fragments for passing a
> comma separated list of configuration fragments to add to the board
> defconfigs, e.g.
> 
>      tools/buildman/buildman \
>      -o build \
>      -k qemu-riscv64_smode \
>      --fragments acpi.config
> 

What about using:

--fragment acpi.config --fragment fragment2.config

?

...

[...]
> @@ -412,6 +413,8 @@ class BuilderThread(threading.Thread):
>           args, cwd, src_dir = self._build_args(brd, out_dir, out_rel_dir,
>                                                 work_dir, commit_upto)
>           config_args = [f'{brd.target}_defconfig']
> +        if fragments != None:
> +            config_args.extend(fragments.split(','))
>           config_out = io.StringIO()
>   
>           _remove_old_outputs(out_dir)
[...]
> diff --git a/tools/buildman/cmdline.py b/tools/buildman/cmdline.py
> index 7573e5bdfe8..38ea7f9f335 100644
> --- a/tools/buildman/cmdline.py
> +++ b/tools/buildman/cmdline.py
> @@ -62,6 +62,8 @@ def add_upto_m(parser):
>             help="Fetch a toolchain for architecture FETCH_ARCH ('list' to list)."
>                 ' You can also fetch several toolchains separate by comma, or'
>                 " 'all' to download all")
> +    parser.add_argument('--fragments', type=str,
> +          help="Comma separated list of configuration fragments to be applied")

... and here have an action="append" instead, which will create a Python 
list already, which seems to be what you want to use anyway considering 
you later split this by comma? This would also allow to have config 
fragments with comma in their filename (which is maybe valid?).

Cheers,
Quentin
