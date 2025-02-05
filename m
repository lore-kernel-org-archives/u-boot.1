Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD7F5C02198
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 16:51:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C62E80104;
	Wed,  5 Feb 2025 17:51:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Wd1YjnHy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35F87801BE; Wed,  5 Feb 2025 17:51:50 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::622])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37A328003E
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 17:51:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KmYAyYDaNNBxxfJHfOv4kaTKhdm+lZ36rxHA3xmSjT9hmCVEM569MwgaHU5k4bbdJmsSV1fHLWs0EZJPfQM7gMIWhSpKU6Sf3ARkaYnBBHL3cBLc5knxuymd5x+4xs0+IyrCAvAET7FK5TnbyyNsODTbRiKO6VxV1ZMQfFqcgi2ZzI4s9JkmxPZ3sRYSIBpHj2PSHfeJ+Ujch3ncZ56AakWD4yokOpe7jQ31fjOj+G1a3/gxfJ7hD/VApr+328YyGthb5Qw09EwKbyItd103MAiUj6ceef/zJXe415jhiE01FBud/puHjtkPelTNix4vmcLm6ow3Poke0B0zVwXFtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmTOaNLzwvZfkUytQzm55AqRM+zpdtIn9clXy7tGqgE=;
 b=GuvbGfEbXt6ZW3fkHHzAz0mee033MsA93ByumN/O8JWOPseP1OZMYFOFWnH2TKVmjdSNpOmKf1MPPEvoerPH9b3BxQ2JMe6s3b+qb2Zra9aLP+EsM5y7VjZaQJtp6kHEoIYr6KSDeOh2WCNzm2J+PfOfmwP9ZFY/HBbXTObh9nicMkZGz2jlf+Ib1i+z+6vuP1qFw+tvA+qc1Xpa9+pHpifpqf4+zjH9/SzjFyVVrUOBJyXdMYCE23oRCt6WwWOlN8Ps/rZPN828PUHhANCBlcPwFwOyGs2QTdSa81i0R4cTlvLq5AOGMlexQvn8T1BYTzkiHQ1wZRS/ahPnvqV+HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmTOaNLzwvZfkUytQzm55AqRM+zpdtIn9clXy7tGqgE=;
 b=Wd1YjnHywKG94vH8IdPnQ13BW7Ti09kNU6t4BSm6APn+F4wie/d2wNqL6tiAlvgIJtrEHQBAsUlYi9iJMHPYETACPlVVHQ6ryLmvVMq3kScJejenGMVsYCY2L5C0KK7RpLVid3URajQ9RchRq62Y192xYA14zyVBoEEKxyms+uE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU4PR04MB10670.eurprd04.prod.outlook.com (2603:10a6:10:58d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 16:51:47 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 16:51:47 +0000
Message-ID: <35d4ce24-ffc8-4500-97d7-d1da8791e435@cherry.de>
Date: Wed, 5 Feb 2025 17:51:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] rockchip: mkimage: Add option for image load address
 and flag
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250129223641.1888833-1-jonas@kwiboo.se>
 <20250129223641.1888833-7-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250129223641.1888833-7-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0042.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::31) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU4PR04MB10670:EE_
X-MS-Office365-Filtering-Correlation-Id: 5484a43d-1c3f-45f0-26ee-08dd460560cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZSs2L1FHTVhJRnB3K0c4VHhad1pHUlpwaGZBOEFOelU3aDRkOEFKU1UyQmwz?=
 =?utf-8?B?OEpzcUw3aExtWURpMWNYUFpoclhMNklaaDlvcXIyTUpZUlFQNlF2a3o1Vnpi?=
 =?utf-8?B?aU9ZU2FXTTNmdWFsWWhkZEhZNVRSOGtmcStqNnVMRTVFVk0wVk1XSXN2eHRh?=
 =?utf-8?B?SVpzVWV0OHppL2FQK0xVSnRPZUVndjBzYVlJSXptYlN5SDZWVVlFRU1GaEdz?=
 =?utf-8?B?NHVPL1I1bkJhYmc4cHdoSkV0ZVg4WTJUYmlRWWk3YWZUNkZFMGs2Q0ZkQjdY?=
 =?utf-8?B?blV5b2hYRklGZytLa2R0MXdKenh0VmJGeVFMbkNIcUtWZGNoQ1ZkcUZuZEc0?=
 =?utf-8?B?U3BSZ05lVCt0MG1RUTNrcDNXUExQT2hkSy9OQittL1lDcjVESmpRSDdGVW1R?=
 =?utf-8?B?Nm1ncTVtVUxtRGV4czhrdDZoT0RRR3dibCtBZ3BtMnU3dzR2aHVDTVVyaTJ6?=
 =?utf-8?B?VEtFL1lVVURtZlp1eFNLTmRLS091ZmdJZXIrYXJha1pDekx2ajlQekU3TG84?=
 =?utf-8?B?RlZnZnlXdnlhVFdCa2pxcCtpSER1SW1OUDNBMmdCNHAxYjh3RERXZXVVVFZR?=
 =?utf-8?B?Y3BkckZ6TnF5MUEwb1B4R2FHa2NlWWRuRHhyMWZWVThMMDdaZjg2QWRLNjBJ?=
 =?utf-8?B?RU51K3pDRkZnSStZVHdTUHBqTWhqT2Fod1dKbHRtTG8rZU1QYVJxMGhRV283?=
 =?utf-8?B?N0VYQkZCTVg3SzJUcU1zSFBjS3NkTWRaMFRDd1J4aFlsSnM4MFdOS2ROWlQz?=
 =?utf-8?B?Y3hHZHU5d3BGL3k4NGFCd2tmN211TlFoWno2aFRXeHF6ZzJIMUdsTjY0eWR1?=
 =?utf-8?B?QW1nTndzS1pObVFBSG4vMkFKZGhlRHY3MFJnc0Zjc1hGTXhabjFvdm5sQ1Js?=
 =?utf-8?B?OWtQVUVrOURjVkNFS2l3dlNCRVlhcEpGb1Qwci9XZTVKcGtkYmJBWGlrNW5H?=
 =?utf-8?B?TllNdjJUQWs5VWJud0hvM2k0UEVGQXNJMXJmaVhxY3FKMmNPKzlXT2J0YmxM?=
 =?utf-8?B?b243RnFlRXk5T01wVmFQTm4vRHVkNTkyV1oybHdueUNSc3ZKbTBWUi9vcjlp?=
 =?utf-8?B?OHlQL0h1Ti82a2ZnWFM1elpaMU9CYWNmQ1BjT2N4Qnd0Lzkzamptd05YaC9X?=
 =?utf-8?B?a1NIM3ZRQ0tPNjJwZUl6UkpWa1JQb3UrRk5nQlFZdDJLSCtKOUJwSWJtTUF2?=
 =?utf-8?B?TFBIWEFYS2N5OEt2TzdXT3hsYUxsSWdna3NqbWhMTEVNd0Y4SjdLcDlHeEFi?=
 =?utf-8?B?RDlQbU4wQXd3VUk5eTB0WWM3UVZoM3l2VFBydmszc3ZUeFZQb2NCaStpR2dE?=
 =?utf-8?B?c2RycW1SRVoxdUtrUlZ5bldQKzdZbUdFaktEQmdHMGZRc3RPRG9Dbm9jSkRN?=
 =?utf-8?B?Ym9WVHlxY3AyVzVHN1ZQRXFWVzBld0p3Z1FNbThicWxmT1NKZGxWcDk3MXMr?=
 =?utf-8?B?Tk5GamVLd3RTNXlzNkhvRVFaaitOQ0JEMEtMNVlVa21xVEw4aTZjdFFvcmZC?=
 =?utf-8?B?VHR3cE1MWEJZUFUxbk5nYUlOQ2hTMTg3MXZXVnBKZzlDWVBNUm9FbndVYnNl?=
 =?utf-8?B?UmE3ZnZPRnA4LzZodFVVODlJY0JBYzZJOXpld2NVRWlzaEVyQ1VVZVNLaWMx?=
 =?utf-8?B?TEl0T2lDNS9kcU0rbFdSRHJzemdDTjYwdXdQYXFzVzJ6V1F3bFFkMVlsQVA1?=
 =?utf-8?B?ajhzRklwckNoUVdhWUNGY2JLQTV6MUN3OERuMkpJU1Z2VTNKTTE2UWR3b3Nz?=
 =?utf-8?B?QktLTUNUaXFINGVqeERkb2FlQjczVjJnTkZvNHQrUkxDRVNuY1dSd3ArODhJ?=
 =?utf-8?B?bnpqTDRnVEw4aFora3BpZVpzWHBqemJUUW5lWUdyamlYdGdleTZFMVNPNmh5?=
 =?utf-8?Q?XGkofDlBsYNpe?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(10070799003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDhVdHBQa2U5VVE5NElZc3NDNXhDVEZ4amdrdTM5ZGoxY1oyU3Fjb1Z1WEs1?=
 =?utf-8?B?SWhKby9XM0NqNkpLVEd6RVc1MnNUZy9pTlJqRGhqbk9tUThqdUg1U1hnSXdO?=
 =?utf-8?B?RHloQW5TcWZQcUJoUnBsZHFHQWl0OWU3NklkMVpvUC8rVHkyU3I2MzlHQW5z?=
 =?utf-8?B?eHFvejRIdGhVUUVvV04ySzFtZmVUTHpHZFhaRS9SUkV0SzRFS2hLbUNVeEho?=
 =?utf-8?B?UC9zeGYwbkd5QmRHZWllTnUrZ09ZWkpQU3RMSDM3U3pPZWhQalZteTVCYTlv?=
 =?utf-8?B?Z0tOWmxRVjNhRDF5ZVhaZVo2djlpYjlnMmp3RDZxZXAvNkY5Zm1sanlhYTlX?=
 =?utf-8?B?STZnR0lsN0hDRFdqU2NISmR1SWVUWDBxR1Ezdzl5eGhlQkxqdVkwWFRYK3RQ?=
 =?utf-8?B?SHJuOXRWS1VDRWRBSDZ5c0lwMVNUVzI3N1h1TFluZmExcHNMZ1Vucno0M081?=
 =?utf-8?B?N011OElBTGZRRTN0MHc0WXdkQUROR2lqSEFzRHRkZzN0RDJhbE83MXVrWEkx?=
 =?utf-8?B?YkxScVlDOEtKWEdyNGRsL1R4ZkRMVWIrQ2lnWkxkYjZ3Q1RDazVXSnBueFBW?=
 =?utf-8?B?NGJNV0NndDFPczBMbUUrOXhPdzNVL0I1clhwcDdvZnN0elVNRFNvRi9XQS8y?=
 =?utf-8?B?Mk05NVE2TXBHNXBLU3JoU3hvZUFLS3ZHUDJlK0xBVmxrVHNmMWNGaXVzVEVh?=
 =?utf-8?B?SjBic2hLR21XUW9yV09RcWIvQUdwRWdMNnpKL242QU51Y1QyK002UGJKcmVw?=
 =?utf-8?B?ZTdsdUY5NEtnM0RMSHFFZHI4dEwwVWNSWm9ZRTkxY3lvOWpMYVZhcUxOTm1E?=
 =?utf-8?B?VzZyV0dleUlvcnhuRUJ5OTNjbXpvMGJRT1FlbUFic3IyM0dSOVprdm1jTW9p?=
 =?utf-8?B?cnR2SWFtWEVCaVlINTA4YW94UGVJK1IxUWVjWmhaTnl3UHRTaWpHZzBMbkpV?=
 =?utf-8?B?Q2UrVXBVREhkWmhiNitMNUQzU3BRak9JQnJMSXB2akx5by9tbEV1U0pvVGdh?=
 =?utf-8?B?Skwxc1VOZ2lyclFHTlJJbjFCSDdsQnlFYVl2Yll4RmFsSklUVUZLK1FDYlcz?=
 =?utf-8?B?bjFWUytrK09KRlJTcE8vU1liVTVnbFhPQ0lmUDRGTHdLZVpRa3N2TU54SFg2?=
 =?utf-8?B?dXU5QVprMlJ1VVN4eEhVVDVtcmhtMUo4MElvdU5XVzdTc0NXeklyMXlpem5i?=
 =?utf-8?B?dmRhNHE1bnp4SVBXK0JvS1IvQXJBclRPM3Uwc3RyK0hDaW44WTY0MUhUT2lS?=
 =?utf-8?B?SDBqK2RQMjJBcFlWRUlCYmVxVHZzYTRpblFhditRNHY0UG5yM2JUUVhWQlhX?=
 =?utf-8?B?YU5yQzZNVEJBSUQveUdDaTZ4K1JGUSthQlQ1KzN5MmZsSEVKV2d4WFRMWW9o?=
 =?utf-8?B?QmwrMGF0NTFUUXJndktUUDBRMm5jcnhTT1pUaWx1UUdKUFpYR0RvdzlUMjdy?=
 =?utf-8?B?M0NaQ1VJTDU3c0VRSHIzRjh5cElUOU5KNDA2MkRVMUJqU3MycmFGREQzdVlN?=
 =?utf-8?B?NVpHY21DQk9iMFdJZ0VVMmNYSWhZM3B2a3hMSzNMV0IyaGFZQm8zS0NRWU9H?=
 =?utf-8?B?VjFmcG5XQmpWQk0ySEd2bFlGRTh3Z210R2Z6N1lELzhYUHoyemRjMWMzZDVZ?=
 =?utf-8?B?RkZQTXIxZHgvMEJyTm01NnpZb2NPc1FadlNxd0czdHFhaFdLZHhPaUpmRXNq?=
 =?utf-8?B?eHg0VTZWYUtPdzZVWXZKd3JHdW1pNXh1MDA5aVVKL0dEcWwzQXZkV2dHOFBL?=
 =?utf-8?B?dW9VcE1wYzduQXFCd29IY2F5a002UU5vOFNpSUk5eUNUMDI2NXhyaVdFa1Y5?=
 =?utf-8?B?amMvd3hOb1ZMRk41NUFjZlFuN0ludDBRYnVjcVBzUkF3K0I1TVVnSmROV0Q5?=
 =?utf-8?B?bkF6dTlRbkxRTHZkanEveG9vYkhKdVNiZGhnTUZPRi81WW45dHFkSXF1UEhs?=
 =?utf-8?B?OXhVTmdUSFVVTTdTUlgyY1l3NjFTSHVDeUpHMFgyQXVwUU8zSlFrc2ZvNk5y?=
 =?utf-8?B?eUpKVXZVeE81QzFtQ1dodWxwNFltbHMvaHRSWExxTFBrZ3ZmUlpFb2VadE14?=
 =?utf-8?B?a2s2dVF0Q0lXVmxreUxjSEFJZ05XaGNJNzNBV1NreTZKMHN2L1pQWTgrS3Qr?=
 =?utf-8?B?VEJqb2FrV1c5UDJPaXZNTlpIb2NZY0RqOXdYcGtSZTFOYW5veTlsTUFVbHFh?=
 =?utf-8?Q?WueamP8coN/WzNgpUzUWbSw=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5484a43d-1c3f-45f0-26ee-08dd460560cc
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 16:51:47.0659 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ewdffuXlDlriX1p7C/eoJwDjd41ULBQEQfHzYyO/jyMQnE6Oil/OLzLhiXCWjrZwFw5v6nsz465zXdes0Ga7uSq23LOvtmwTnGEANhFsUE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10670
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

Hi Jonas,

On 1/29/25 11:36 PM, Jonas Karlman wrote:
> The v2 image format supports defining a load address and flag for each
> embedded image.
> 
> Add initial support for writing the image load address and flag to the
> v2 image format header.
> 
> This may later be used for RK3576 to embed a minimal initial image that
> if required to fix booting from SD-card due to a BootROM issue.
> 

Would have been better with RK3576 support so we can see how it will be 
used. Especially, the flag member is very obscure. If we do nothing with 
it and document it as "no use", should we really add code for it?

The change itself seems fine though.

Cheers,
Quentin
