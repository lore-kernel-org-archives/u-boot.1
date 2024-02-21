Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED35C48BF6
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 09:20:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6530087E47;
	Wed, 21 Feb 2024 10:20:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="W1qcaiMe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8FD487F67; Wed, 21 Feb 2024 10:20:18 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0136087D29
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 10:20:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZpGomFJa0lap423JtVx3Lo1G0ukn0U8O4x69zf64hPo225AGcfAWG0YqoGC7PP+Pjx6/lXdLqvT0qSSnFsJoTI38wVob4STqEeNznoRpAZ3drxwThgvfpURfwc4ZawdxX6fJwGQxBbHrALg0acmPDA67sVOZa3iVK1hDH9HPW1hQylD6XfD52tKCKx3tI9tisUCzFd3eBtL2n6/RQXmKZGZOzuygOMFGgli84LWqps3B2zDlOqW/J5mZoIODF7G4eVDLXQV6e6MA1S5Wv8CBm8gtQcvWFq6GB9SqqWtX/9HFc2C+a0E7Lekg4GXfet+ygxa93O5eER+zVCGrb3nqvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7O9WGwUG2JcGZjPCJdRV0cFRn9EtyJcoV8xA/7QLMxY=;
 b=U/tUz+ldWmMki7nnT7dFAOYSf0/fu82ee5Na+4elxBc7FzyeMxRtESfMDpbJ6Ijyf0TLjwnYgThotO0t9F+qFDayATxXsYpgQhRssme/JKBwC8xEXEBm9w0arn2TZDeZLV7xz8lUnhGMgUd4crSyq7opnRZJl70AYXq0ecfU6mP/HTIRxAzTIp+QddtWQgTBL+EIaaWYKAJspraeWyIthZsWYlBSLGZgo+cwn2cgh54Bo4PJsAzgGvDp01L6pAwCbiwh00nsalt1AUS5EAf5OYBrvOW6BYXcyqdev7zP9lK+rwFbQjphCThWBKFxQf14IxyORBXcTaKNII/TWZ984Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7O9WGwUG2JcGZjPCJdRV0cFRn9EtyJcoV8xA/7QLMxY=;
 b=W1qcaiMemwWzhy2/wsk6Kx5xrV9cPPa+ZVHpPUiBu60W2Ujjwo0StDEgsRI3hJupsxVsxfnfccLyI87hjbzQOrLS0KN1q5E9WnwoaJFL/ZHeMR45j+kIgr9NnYbS+HmdBB1GlMpawySJbaLKAVkBHtSf7R82w78TMP+kMG5wDIVatNNfH6aV8T8b7ozlnMoxzOPyuZqmikQUJ0khM0AoOA53FAgvNA6ZpUgGCtwm1/pyP0Ggg91K88mNWP3ix55JDAfxZBH9fJC+KmI/AefrVLlk8qrxZIXsTElyuXzErQHSzOgtrrViP7e08mtexU3hOU/9IIRaHUXwUoyNSg0+bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5357.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:28b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Wed, 21 Feb
 2024 09:20:00 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 09:20:00 +0000
Message-ID: <a49bf6ec-2484-4110-a9cc-7fce90621432@siemens.com>
Date: Wed, 21 Feb 2024 10:19:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 07/20] configs: am62x_evm_a53_defconfig: Switch to
 bootstd
Content-Language: en-US
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
 Nishanth Menon <nm@ti.com>, Neha Francis <n-francis@ti.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@google.com>,
 Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Andreas Dannenberg <dannenberg@ti.com>,
 Romain Naour <romain.naour@smile.fr>
References: <20230825180305.69515-1-nm@ti.com>
 <20230825180305.69515-8-nm@ti.com>
 <87f154591fee4979570e78cbc8c73eb0a56469eb.camel@gmail.com>
 <e6222770-cbcd-45e2-94fe-eb55fb0a2f94@siemens.com>
 <5679ced7e927e1eb858a47d25abbd4025b4b67b7.camel@gmail.com>
 <dba0d25f-121d-4146-a78b-ac3beeeb1531@siemens.com>
 <20240221091028.GA6328@francesco-nb>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240221091028.GA6328@francesco-nb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0016.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::26)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5357:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e0f2290-86f6-46fd-8010-08dc32be4740
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LhdAsxRqJUEVG6S1VYH6I2JHKi2qNJFPT9xr5zuWeW1VuJFnkrct6f3l4XuicBqw/PbgHhY1/7zKAKldbzaOcAeKiqIjrOMAMjVa4AdhHTMo5N5cZvaIAeMdoOMRHm+jOw4tvWLe7dSRcohT4oFOxdVEWv1X0vkBHBSdbqRYaQnOLpmHH1NkxpjeAig2fT4yUZlvfGWKI8ftY1e4gIVFF2jALujQN4SGVlQ7PoaiHRKNzxaA7qZtp0Dwe4q5kAFInf0PICt5FFNCGcdVOhutnHOXpuloYhs+RYDa//7wK0OiL28cTg0zstEkeNNe0Xk3MDAO/soHWAaG/ooEdpp0CbyUlVEceTgf6X08+akCNsSqSDrDaqGeM1LUkEISpr+807NGx010oSAtPERaoG07sxZaPWF7/rJDB4nxXUIX94JZdBwWLYjDzETOhXujqcPiIO4pkDEmz8QluI4LIWjCRtfj+/zClRWD+22RPSDTe89PSrPfeLNctO2CWBGWYiAI8plJc5vvpOUkEbPwv5W1LiPuR0DbgMMMPjcPjAfTUk0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTRIaWpiQkdRM3dMUVViMTFqb1hET01ZRVVyM0JmdWtUSnVvNUlIM1JLdHN1?=
 =?utf-8?B?L0lCZlJaVnFycXVaOUY5R0VETlhFSm1aODlGNFhvZDQ4SXNCWlppbmgzQVJx?=
 =?utf-8?B?ZWJwb01JQVJ4WUM1b0J3bHFnbWZNc1U3c1VZNnhmU0xmN0I5RzF2NUhIb3Jz?=
 =?utf-8?B?VFV6OVBidDI3WnovSXowMWVHQVRlSG9UN01iY1ZPUXVBVEFYcStRVGZyaVJo?=
 =?utf-8?B?akdteVJReEkwVjd3aW1aaUVKUEQyeWx6QUFqdTR3VTZFUU14bDVhTW1FTmw3?=
 =?utf-8?B?Z3hGSEd4OVQzQ2lxT2E1bEtOWEVhckhUUmt2dnMzK2pXdi8xZzZnY25XUEpp?=
 =?utf-8?B?cXlQd0ZLMDJLQUpCNDY2aVBLTCtzcENlejJvcFB4V1hpMmJwVmZPZi9oL0JO?=
 =?utf-8?B?OUMvYk40cTNBM2lyM3B4cnZrYkV5RU1kRzR1TFBwVzVJSlVmaEtyTTB0cXRz?=
 =?utf-8?B?K1BDY3c1aDZMcU1iUnFia21JRWFNL2dQVHlXM01yaWUzbVRxejlDNzhBMXR4?=
 =?utf-8?B?K0lEc1lsci9LeEtuVEZ1Mkg5d2VhR0ZiUWZoc0x0c0V4dmRsdU9VdXNkbmVK?=
 =?utf-8?B?TXMxRTdiSmIraGI0Tkl3ZVUxZHBYdUhESG84UlNEank4YmlMK0JrcXBIMzI3?=
 =?utf-8?B?Nk4vMXlCWXpRK3duTTlqTU16YjVCZGgwcitRMkh6cmtaUDRpeXdmcGhQN0JG?=
 =?utf-8?B?Tk4xbStjV1dOWkN3aDZnSG9VbHFrLzVZZ3ZpY0c5aml0WDcxcmVlQVpnQmtj?=
 =?utf-8?B?SlFadlVIZ2FTZkY1Tm5DNEdzT2pGa1Q2b012ckR1OFZHQVltN25SN3NLaHF4?=
 =?utf-8?B?aWJuWjZWMHdVa282MXNtZUZFQzBJclFySFF3S3hMUFpWdmgwL3VIdDV1WlJ1?=
 =?utf-8?B?VE9nd3NJc1ZqWWR0dVlhNFdXOUNUSUVsRVI1NWtRUXB3NFJYMGZyclFlYVgr?=
 =?utf-8?B?TForL2ZlRzBBVjh4NXZHRi83UWVsZ2g5ano5dkpsWlR3MEJhYkRwNEFZa0pV?=
 =?utf-8?B?MXNEMHcvSGR1NFM1VmVxZTZ2MDBIYVNDS1RILzRNakVqYnkyeVlWV1E3QlJO?=
 =?utf-8?B?cjR5cStqd3dFeExsSFh2aGRjTmV0SDBrNkVyUjNwN3pGSm54OW5td0paMVhn?=
 =?utf-8?B?eFRkRVZqTUs2TDVxOFl4VjBzZ1kvVXFqOGIvK3VpWnF5M3l2Sy9HT0x0R1dW?=
 =?utf-8?B?T3FFblZHamFUeWEyL05HM0c2UEVPVnFTSmowN1VsdnUrZVppT2hUVFhUUmd2?=
 =?utf-8?B?VWN0QU1vVzhsYXRDaXBTUzFub1Q0aC8zTmxkMTQ0N1k5SjdHVkJ0RjlBZm92?=
 =?utf-8?B?UTRnWGhiU3IyU1JNVlU3UmNRdGdzN1VjVzNFYklhcHEvanBlQ0VMbEhsRktT?=
 =?utf-8?B?d251Z1Nya21MMFpFUFdBMDVVUFl5L3RuTVRVNjkwdlNpK1RGb3NQWGV5NE02?=
 =?utf-8?B?SURLYzd1NWlnLzFZYVZzWjNjNENFdFJiZks2ZU41RVVOaUxxcWx4R1ljVUVl?=
 =?utf-8?B?R1dPb3hPeDhUTExqRjJtL0tyYnZtQ3QrUVpSMjdETlRVKzg1NHR2Z3ExN3A2?=
 =?utf-8?B?aVE2d0hQNWQzMkthdFZ3NXN6S014N3RBTGhQS3hlSTR5WEhPVFlweU52TDBx?=
 =?utf-8?B?K3NlTFViaW44R3VPbWt2Y01lcy9iMm05Q3RnSExzZjlhTDBSVTFWRTNJSERF?=
 =?utf-8?B?RWR5V0dDcXVocmpLZzhJUzBvN0ZsL1BFUlhka3Y0SmVlNXUvbE9zRnR1ODZE?=
 =?utf-8?B?UkwvUUZaUmZ2bGxYNmxDMEJjMWg0MWxGOEZSWGpJcm0wVnhST01ocjZSbHk0?=
 =?utf-8?B?U01PdEI0WnhmcGxZemlmRnI4YVRCM1R4d0tsUG5mYXlueDd3cDF0ZzhyNDhh?=
 =?utf-8?B?d0F0bG5Jd1RQZ3YrU3I5a0J1NHVwRWh3d1p6NjZ6MFhGUk9jbTM0YlAzeE1v?=
 =?utf-8?B?aEJPS2RuMFVQV1d3NWliSi9SSFdwU0Q4VzVISC9FeFJocENUSnRrc21QM0RD?=
 =?utf-8?B?bGl3NnpHRVJOeWs5NWFFT25TdHJQazhEY2ozS1oyQnE0NnhTYmpJOGpZNEJB?=
 =?utf-8?B?ZzRIclRoVXFiUVFFdUFvNWdQckU5SHRSWDFnR3JDQU1IcmZRYlR6MkFnb25I?=
 =?utf-8?B?VWl5cnhmYnBMUlpFNHliV3JOMjhVUVJMVkJFRkU5aGM4K2w1TDhHT2RxUWFH?=
 =?utf-8?B?Snc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e0f2290-86f6-46fd-8010-08dc32be4740
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 09:20:00.1355 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EC9ivr01tcJm+7e1ECxNZePxsMgc41o57S96RBwWrU3JfyBS6xJImD2oINa09g/jHkS/CsVaIUZM2t31+Pd5/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5357
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

On 21.02.24 10:10, Francesco Dolcini wrote:
> Hello Jan,
> 
> On Mon, Feb 19, 2024 at 07:37:55PM +0100, Jan Kiszka wrote:
>> My personal observation is that continuous integration testings with
>> all-upstream components is not really a common thing. I saw that with
>> multiple active SoCs from various vendors.
> 
> With some limitation we have this running in Toradex since a couple of
> years, we do integrate latest mainline kernel/u-boot and OE master
> layers and run all that through our Lava test suite on real hardware.
> 
> It has challenges, even getting the build to succeed is not obvious and
> requires continuous care, but we do spot regression on RC releases and
> we actively report and/or contribute fixes for it.
> 
> Unfortunately the test results are still not published on some website
> and are only internal, but we are working on making this available.
> 
> Looking forward to have more players doing it, starting from the SoC
> vendors!

This is great to hear an highly welcome!

One challenge of this is definitely to get the information to the right
people, ideally without requiring too much manual effort (as that is
often the most limited resource) while not overloading the target
audience with too many false or inaccurate reports.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

