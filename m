Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B4FC3ABC3
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 15:29:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C2978091A;
	Tue, 13 May 2025 17:29:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="cJo6P6kl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C56280AE0; Tue, 13 May 2025 17:29:00 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::628])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6668800C1
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 17:28:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sqoB6wjDAeoEiJWOxsszxdaAVsSThd5w+WNqH8LQkWEy68F22Tc9tpg2IN4r4fphwDd7mqxcwKJlAt/MAp7+MjreFiNP1AUAPvB7a7ktT2bTN1Bv2LAj0EgLeaiBN/aXvIptEVB6w/LiloROOXzsC7QY0QEy2NHmiWt4q4EDj1z7iTa0HQ8NJDr8+si9xRqc6z+MeZgTPwebjD/MBaxbHJxAQl8ot7tj19XrFa+4te49i1PXq9CpnpezUhhRBAL0D8IUpberfOVGJN/rF26N1xk6S373wsIq6c0sj9oaI/yxQ1W8nyRzt63yCgP0VwVDveV/RMa7qrh9GqnUuZvFwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/uxtv3/1ir6iat7So3GiRdwrv59tGMB2292FnMx5UAs=;
 b=Oze3DVT5aD7u+sNphg/9sIWG638H0NklvWgdOvXQXwz+aE/CZgtWfu7MIq/QzLq5S/f/0JXbXVIDvuYxRoT4lYPR+LZHpg9ga6HtBorIAWooSt7B+65pFOAaWSUVSBk5BO2SHBC+YatziWDAL9MmdwUvEbC7aO7rZMxo9V2K6pEfZp6xvFZ/GUvxkq0naSlTODV1Pb1ynfnFD4bB4QMhxI5L1q4gVryVxOkCJ+Kp30uR5lfiC3wn2mETcPOeUIz2jrkxgOqXYwkUAmu3OrquXFWmw8UC1hifYTJH0IMoyv+DowcOZ/z7oMvIERPIzpSXC7pE0dZHUg/X6nS7bJhw5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/uxtv3/1ir6iat7So3GiRdwrv59tGMB2292FnMx5UAs=;
 b=cJo6P6klizvnpUJfvUA9fsLcI1XGUxeCoIm6L5OB2ku66I9fOvK/RhXiBzCkj1UT1AOFCMFDy+fYJ1kqrqXGCNpAKVcQuy4n+lTo8qKe8aC63tNsJiQZvQ/OSXrnNxGg0g3IWjeegW4xriEKsCezgGd2QI9Q5L1dwfQ4BuW7JoU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM9PR04MB7603.eurprd04.prod.outlook.com (2603:10a6:20b:2d6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 15:28:55 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 15:28:55 +0000
Message-ID: <0cb64c56-8f11-4cff-b1a6-a1b6a4194c86@cherry.de>
Date: Tue, 13 May 2025 17:28:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tools: mkimage: validate image references in FIT
 configurations
To: Aristo Chen <jj251510319013@gmail.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, carlos.lopezr4096@gmail.com,
 aristo.chen@canonical.com
References: <20250505100852.9364-1-aristo.chen@canonical.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250505100852.9364-1-aristo.chen@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::14) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM9PR04MB7603:EE_
X-MS-Office365-Filtering-Correlation-Id: 709d4bf0-cbcd-401a-f814-08dd9232df8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0dBR0dQcDQzSE9ZdHhJZXRoYStVMy9McnpvVUFjcnJOSE5ISklyQ3BUeTAy?=
 =?utf-8?B?cnkwZGk0NXFRc1o1eS9BQ0dHU3Nncjc2cW1hcldrYjFON015cVhFVEcvZjFL?=
 =?utf-8?B?YjBmMi9wYkI0MGY2NkhFUXArRFpMM0dkWGdGNWhoeDhqc2lGRXkrK0gxaVQr?=
 =?utf-8?B?UGp0T3R6bEZOUm9YZHFpdWFuY2tyWUZzNXJkV3Z2U29vckNreWdMSGZVNHd4?=
 =?utf-8?B?MDRLMDVBYVo1S3BKQ25Fek1ONHpmKzJzOVQ3UmJtWEphMkRKVjVPMFY5VjU5?=
 =?utf-8?B?aWZkcVFHdmljZDMwOXlkM2Y5Y3U2YnZWY1QrbXB5TE9DNU1xcVFYQ241M2ds?=
 =?utf-8?B?aFhPem5XaWhkek9lNmUxRTQ4MUg0YlNYZ2NuUlNVN01hdDVjeUNGZ2FwUVFt?=
 =?utf-8?B?eGdGVjc1MkhDTG5tSFJnQ3ROMGxyUzI3aW41UnZRaFUzbGwwRXMxK1B0aVlo?=
 =?utf-8?B?Sk0xUk83N1pYU2Y4VTI4MGNHSzEzL3VsUGhPMlczRFZ5RUw5V1liMkdnTWpX?=
 =?utf-8?B?bEhEblZaQmlKWUJFTWpFWCtSZjlpOVoxTXJBQmFmazc3S1BKTHR1VmdJQjVp?=
 =?utf-8?B?VVZneGRyRllUcTFTZ1FSMVpWQTBRM1pjRDlEdU5xT1RjeCtUNGNsN3I2NXVW?=
 =?utf-8?B?djAwZ2hxZWNDbHZNdHBEWldGSEJrc2g1b2dXN2h4dTlNTG1rdjZaaUg5SXZX?=
 =?utf-8?B?ZmpFem9Db3RhRGpKMXJUZUV3RG5PZTlyRmFZaHljK3pxZkhyN1IrcW5WRkU4?=
 =?utf-8?B?UlpuTGJFK25nZ3lLYTcrTEVYU2NJUDlLWFBXM2UxeFR2bmEwYkZ4eEp0eHBI?=
 =?utf-8?B?KzR2djdWdTVoKzB1NFZvQllBaXRhU2tKTWkxalNaYmhuNDJ0UmxUWXpvbFVZ?=
 =?utf-8?B?MTU1eWphOFBqN2hkSjdvenpLcHhleHA0dlhmdmVvNC9YeUNKTEJwV2cybDk4?=
 =?utf-8?B?b1ZBK2Z5Yk9GaTBFMkIzdG9vY2dNM1JBYnJYeU4wc3Q5bFRia1EzL2ZvaXpI?=
 =?utf-8?B?d2VETkVMSW9NTWc4cDNUL3B0TlBZdHF6KzJrQ3MwR3p4d1B4WFRlazFHbVll?=
 =?utf-8?B?RnZSRGJRWUMrNFBrY0ZTQ0JiMmdJUGdPanpmSFZxcXFleW51QmpBSU1uUHlu?=
 =?utf-8?B?YnBVVFlpRGZQQ0dHK2Z1Uno0aWdBZDdjaDlEUFZyK3NtdEFqalY5Q3ltS283?=
 =?utf-8?B?ZjFhMlU3VlNrSGRlMlR4dEZ2SXVhMEZlUVJMLzVHekJKUnQ0Q3JkM05qRVUy?=
 =?utf-8?B?RlgwM3NUbXJtNUYxTWkycy82dnRzamRZZ1V3ZHl0b0tqV21IbS9ObS96c1dr?=
 =?utf-8?B?dE12aHd1Ym5iNEZLYUlia09lYXprZ2lMaGcyaC9LT1NVeVc0UzlwRlRrTTJt?=
 =?utf-8?B?WXJ3QkE5cXlrZWZZVEo5dDFNeUJmdW9oVTZSRGoxdTRnNlg1NGZ0UWkvTUtU?=
 =?utf-8?B?QXUzQ3Z5R0tXZGRCOGdka3ZXQnlrbUYxQ1ZPa3lhS3NtckRZT3AzQklSZ3d6?=
 =?utf-8?B?Q0RqNW4vS3lhZzh2N0pyRUVta3lkZDNTYjIxQzJKLzErUFNSS2pIZnd0L0VR?=
 =?utf-8?B?NnZISkNVcWdCQkdGVnJjRVAxdFVQcUxBa0Y3Y0N6djJJcW9tY2k3NlNlQXp5?=
 =?utf-8?B?SnhXSWd1RzRuZytSaDJXOXJaeXA2eEo0OFZEQ1hobCtXRmE5ekx6N2RIUnFh?=
 =?utf-8?B?V3dmWWVtSDNEVkFJNTcrWDNZNUlmdkFLZGNkdnRDUDQ1aXpPQitTNStFQ21h?=
 =?utf-8?B?YlBMNjlyZmlzdkFSNkdYNEJVQ0gyMzI3azEyYUhyTCtOb3JOU3pRbmFmWjZ0?=
 =?utf-8?Q?P36LWUwMSneRpzQJvI+8rSPlV4DYfc6oOCQZg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDBUY3VUYWFYQzlyc3BlNnJrbTlaUXZVS1Z2TTJLUTJnd1BLZGgydWNSTnpn?=
 =?utf-8?B?N3RzTjdFNUlRVTBsYmdYakdoR29NRHRJSmZ5MmNzTW81ZVNVYUt5OXNwQWZy?=
 =?utf-8?B?RHhVbkdLNlRXN0tUTEMwZ05iSlE1bDZDejJjZVJXR2tJMVJEOXBma1ZBQkRJ?=
 =?utf-8?B?Z0Q2M0hmLzZDYnBWL2N1WkIwYTVxRTF4a0tsekcrV0Z4QmtrdmlUT3pBRFUw?=
 =?utf-8?B?MWJoRFN6SXRJWnJCQk5kOEFIYUkza3hmeVlvM2U2dlJmNEFMY2ZPTjF4QUJo?=
 =?utf-8?B?NEN4ZkM5Y29LOEtwK1NVMVorbEpYSDVhaFF5QUd5UFNmaUhXMTBmbGFPaEpk?=
 =?utf-8?B?bjNpTGhaUExhOEdJNktOUlh6NGthUWNESWFQajNIUTNUMUVGUXVWQWJqN25F?=
 =?utf-8?B?TytnQ0JzcXkxaG83S2Y3bjA5K21ZMzFVTjduVEFOcEJvZHVGUHFmWVpxUFBs?=
 =?utf-8?B?TUdlVk85cENxS0JxTDRtc2hQZFBIYlQ3WDFod2xPdTB1TW9oVnZ4SEpsTnNW?=
 =?utf-8?B?RHBZRUNmUHRCNkk0dThWdnpvTEJ1R3QyLzJXT1FPOHErbWgwSWFUbE9tMGpM?=
 =?utf-8?B?SitxbTZxVjliWHNqV2t1UmRONGVCZnZ6SjI2Um5MOGU5L2VpTk5RUUJmM2ZG?=
 =?utf-8?B?NjhvaDNpQ3FUZWtpM0NSS1RvM3BzQU5VWllBOGx4bEdXbUxrdEV0NTlaT2Fr?=
 =?utf-8?B?cWtDV2pFSThKb01kY0lQN25BbE5jTmJuK09lSGVtV1ZWeVRSeC8vT2YxZGpZ?=
 =?utf-8?B?dFdCc2R3VlhBTEVTV1dIUENXKzl6b1NKMXBlaDR2MlBOZ2FMOWVHb2k4ak9k?=
 =?utf-8?B?WkxiR2JJZDZjNXpMUWk0QzlET2l2Z2RuUndGR2NPYmVMSUZZckdaQXNLTWRo?=
 =?utf-8?B?citRd0doOG1DNFF2L0g0SzBmRHFoWDZ4Vnd0RHNXTFE1WEV5RmVRb3ZyUzY0?=
 =?utf-8?B?dXhBak5yUnlhT2V4eUlKWlFNQmFVdWVvZmNnMlR0SW4xaWFFS3R0TTIzd1M2?=
 =?utf-8?B?aXJvN2xsRXduL0JORkRvUXNiOXNjWmdpRzcvUmJsTWVkbjI2QTI1VWN2cHFi?=
 =?utf-8?B?VW00YVZDVC81cG0xaTZIRzFJWFF5T2ZCeG9sVHZhRXE0TDlLOXdjWDhEYkt6?=
 =?utf-8?B?eWZIbWhkSXBaZGptenozNFdSdjgwYlJGUU1oTFl2alhkL29mcGhybm5oMWt3?=
 =?utf-8?B?VW83eFRxL3BsRnNLUjBOY0NDbDZTUmJEbTFOdUhwMVh4Q0RSdkJDVFc0ZHlN?=
 =?utf-8?B?cVBkVlBNM0pPK2RhY1EyM1hBTjVnODNjU3FxaG05c2ZFK2tveElpNzhjYi9p?=
 =?utf-8?B?ZVFvQTk3eUwvUzFXVC9UNVpNc2xBeGRBaUJpTk9RMTc4eG1lOWNrdTNKbFY1?=
 =?utf-8?B?dGpaTUdWMFBzNkl1bXFFdmtDbnRrdzFZQ0pHcFVxM1RMMGpIUUIzMFJUNUtD?=
 =?utf-8?B?R1AwMUxhZkFRNzBoRmFJakgzOW5DR1A5am1PNlpFVmwyQmp1Zk10WkJvQVBa?=
 =?utf-8?B?cDR0Q1F3MUFvQm8yWm9udFNHUmczdk1wOGRUR2YyQjlCeEFWaSt2WkVXZWpx?=
 =?utf-8?B?WHRRbVQ2bzJuT3c5OTVGeEVURkVyR0ZYakpaa1lJU0MwSWVlcGVKQXZwOUdX?=
 =?utf-8?B?OTBMSmhyWXN3QXI5WFVPTm9qQSs3NTc3a0hVSHNDRlFHS1o4ZGY1ZmVSOEQx?=
 =?utf-8?B?b3JGN3Q3alVDYW4wUyt3L29OUndqckx6RlNheVh1Njl1UGJVRGRxQUhmU2ht?=
 =?utf-8?B?Slc3SnRjQlZYVVNNREVoQ2k3R1QxRlFkYzQzZ282VXlzb2t4MlI1YzQxRXdz?=
 =?utf-8?B?WEF6K0U0WEliM0dFNWltZ3Vwbng1b21DNzdGRkV6YmZIT2R3T21yUmRQUE9H?=
 =?utf-8?B?QVoyc0hFdjd6WG9aL0o3bW5FV0xXVUV0SUdYdzljS0xOM1l1eEd1QWpVclAy?=
 =?utf-8?B?UTBqZURJaGRXd1J2ZVd4Rm5xVUJwLzNTVTNkQWxtcktEYlM1Sno3aWJXQUhy?=
 =?utf-8?B?NlViMzRPVEF2Y3IzYVZiMkZoamNIWUdkU0ZUdDdzV2h0MUZFQVlRalpYR0dH?=
 =?utf-8?B?MEU2bXhBRzNmM3ViWjQ5c1J5SmRKZGIrZUVHME5uVkRxeWZZNHVCS3Jyblda?=
 =?utf-8?B?akU5QkttdnU3czQ2ZDgxc3poNGJwRk9hNjg1NVBya1FpYWNpR0w4anFDZlV4?=
 =?utf-8?B?bGc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 709d4bf0-cbcd-401a-f814-08dd9232df8f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 15:28:55.4619 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YbO8Ou/aq+9epNUwI3p0SMzIlwUkR2SEQ+5hW3Ga1ZVhfnHt7Gnz3V7h7cH3WMm5GlGnbIMccmNP5aQhjeveW8fIt8pm118w6Ie74Qp5AYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7603
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

Hi Aristo,

On 5/5/25 12:08 PM, Aristo Chen wrote:
> When parsing a FIT image source (ITS), mkimage does not currently check
> whether the image names referenced in the /configurations section (e.g.
> "kernel", "fdt", "ramdisk", "loadables") actually exist in the /images
> node.
> 
> This patch introduces a validation step during FIT import that iterates
> over each configuration and verifies that all referenced image names are
> defined under /images. If a missing image is detected, an appropriate
> error is reported and mkimage exits with FDT_ERR_NOTFOUND.
> 

Wondering if

fdt = &fdt_1, &fdt_2;

for example would have saved us from this issue since this would be 
enforced by dtc requiring a label to exist. Ship has sailed already 
though :)

> This ensures that configuration integrity is validated at build time.
> 
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> ---
>   tools/fit_image.c | 48 +++++++++++++++++++++++++++++++++++++++++++++--
>   tools/mkimage.c   |  7 ++++++-
>   2 files changed, 52 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/fit_image.c b/tools/fit_image.c
> index caed8d5f901..02b9c9b5855 100644
> --- a/tools/fit_image.c
> +++ b/tools/fit_image.c
> @@ -627,6 +627,7 @@ static int fit_import_data(struct image_tool_params *params, const char *fname)
>   	struct stat sbuf;
>   	int ret;
>   	int images;
> +	int confs;
>   	int node;
>   
>   	fd = mmap_fdt(params->cmdname, fname, 0, &old_fdt, &sbuf, false, false);
> @@ -695,6 +696,49 @@ static int fit_import_data(struct image_tool_params *params, const char *fname)
>   		}
>   	}
>   
> +	confs = fdt_path_offset(fdt, FIT_CONFS_PATH);
> +
> +	for (node = fdt_first_subnode(fdt, confs);
> +	     node >= 0;
> +	     node = fdt_next_subnode(fdt, node)) {

This should be fdt_for_each_subnode instead?

> +		static const char * const props[] = { FIT_KERNEL_PROP,
> +						      FIT_RAMDISK_PROP,
> +						      FIT_FDT_PROP,
> +						      FIT_LOADABLE_PROP };
> +

Why only those?

https://fitspec.osfw.foundation/#optional-properties specifies "fpga", 
"script" as unit names. https://fitspec.osfw.foundation/#id6 specifies 
"firmware" as a unit name. So I'm assuming we should be checking those 
as well?

Reading the code, it's not entirely clear (to me) whether FIT_SETUP_PROP 
is about a unit name.

> +		for (int i = 0; i < ARRAY_SIZE(props); i++) {
> +			const char *list;
> +			int len = 0;
> +			int offset = 0;
> +
> +			list = fdt_getprop(fdt, node, props[i], &len);
> +			if (!list)
> +				continue;
> +
> +			// Some properties (like loadables) are stringlists

Aren't they all stringlists?

Simply get the stringlist length with fdt_stringlist_count() and then 
iterate over all fdt_stringlist_get() instead of handcrafting some iterator?

> +			while (offset < len) {
> +				const char *img_name = list + offset;
> +				char img_path[256];
> +
> +				offset += strlen(img_name) + 1;
> +				snprintf(img_path, sizeof(img_path), "%s/%s", FIT_IMAGES_PATH,
> +					 img_name);
> +
> +				int img = fdt_path_offset(fdt, img_path);

I believe you could save the snprintf by doing the following

- get the offset to the /images node with fdt_path_offset(fdt, 
FIT_IMAGES_PATH)
- use that offset with fdt_subnode_offset(fdt, images_offset, img_name)

You only need to access the /images node once, outside of all loops.

> +
> +				if (img < 0) {
> +					const char *conf_name = fdt_get_name(fdt, node, NULL);
> +
> +					fprintf(stderr,
> +						"Error: configuration '%s' references undefined image '%s'\n",
> +						conf_name, img_name);

Would be nice to tell in which property as well since we already have 
that info.

> +					ret = FDT_ERR_NOTFOUND;
> +					goto err_munmap;
> +				}
> +			}
> +		}
> +	}
> +
>   	munmap(old_fdt, sbuf.st_size);
>   
>   	/* Close the old fd so we can re-use it. */
> @@ -750,7 +794,7 @@ static int fit_handle_file(struct image_tool_params *params)
>   	char bakfile[MKIMAGE_MAX_TMPFILE_LEN + 4] = {0};
>   	char cmd[MKIMAGE_MAX_DTC_CMDLINE_LEN];
>   	size_t size_inc;
> -	int ret;
> +	int ret = EXIT_FAILURE;
>   
>   	/* Flattened Image Tree (FIT) format  handling */
>   	debug ("FIT format handling\n");
> @@ -854,7 +898,7 @@ static int fit_handle_file(struct image_tool_params *params)
>   err_system:
>   	unlink(tmpfile);
>   	unlink(bakfile);
> -	return -1;
> +	return ret;

This propagates more than simply the FDT_ERR_NOTFOUND added in this 
patch. Not sure this is entirely safe to do? Please check that all 
possible return codes of all functions whose return code is stored in 
ret are negative.

Maybe we should have this as a separate commit too, seems like we could 
benefit from it regardless of the first part of the patch being merged.

>   }
>   
>   /**
> diff --git a/tools/mkimage.c b/tools/mkimage.c
> index 2954626a283..361711c53b2 100644
> --- a/tools/mkimage.c
> +++ b/tools/mkimage.c
> @@ -519,8 +519,13 @@ int main(int argc, char **argv)
>   			 */
>   			retval = tparams->fflag_handle(&params);
>   
> -		if (retval != EXIT_SUCCESS)
> +		if (retval != EXIT_SUCCESS) {
> +			if (retval == FDT_ERR_NOTFOUND) {
> +				// Already printed error, exit cleanly
> +				exit(EXIT_FAILURE);

Considering we only have one U_BOOT_IMAGE_TYPE with a fflag_handle, I 
guess this is "fine", but this seems very enthusiastic :)

Cheers,
Quentin
