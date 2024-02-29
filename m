Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E9ECC48BF6
	for <u-boot@archiver.kernel.org>; Thu, 29 Feb 2024 09:08:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08A0B87D02;
	Thu, 29 Feb 2024 10:08:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="pK42YSFZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C874D880B3; Thu, 29 Feb 2024 10:08:23 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DA4A87B7C
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 10:08:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIfNLYb5TpP4+5OoTfVMi2avPlykheG38c+zMPrXBe13PwpfqECg1gtW7hUBzh13TIRvi7wOR4mnLjfGk4yV4Vsx1d8cz56O5Jjgvl3uFn3jVzKnwr06z1hlBAVg93d/gHPNjUDlQ9hLp7VoO/KD0cAOP7EqQ+ANqUzgxjwUjpEhE+XzO1qYP+YRSMpANH4uV93bkl2HZyCgI7pF+cNWZTaDcBDN491OngjwJlU+P8S899JpeFkmtTTC/vg/T9bFUMnktklIkE8GHWRYhjc+APNHGB5+7RK2Oh7xYF6o+LOsMMgyDgk3uY5G9oCzYszFP+IqFhrxLWMpLm+x1+JIyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RI5+vzKEWNKJ7MNarRf2x98sj9OzKmcBr65AhNc2nAc=;
 b=ijDRgVn+PKi3o+DCMPVz/b2ASGD2RgGhOI2E/WEtdaTYm8xS4/n43gwCzsZxg0km17oi4njCogP8vAkVd6JDA6q3xjNZUGtFWH++VbZmJ/c/GfEvQpoMcvJ8OK/u3NGDmtaOQAh+aEeSJp92qF0Ya86lXFgLnN+QyShdlQiLW5kpSYXxTffAHA6vmdk803XiohfYX1q857mds3YNA0nLFbfCo+adPQ7+tPl12/Xr/ugvkp7i+G301v1pXK0lQ84qoCF/JozLAlDrbY7gHBSD0WRkvGdISDZkrWSiHxNQOy+xOusfuFJWa1QTYz9uoLbcLjfISay0H1KxNeds1Df/3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com; 
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RI5+vzKEWNKJ7MNarRf2x98sj9OzKmcBr65AhNc2nAc=;
 b=pK42YSFZ9IHdo2CwuAYCzUb2pzyNSMhDGc1YP4/ylgjRmjjq8hUPeoQnjbXp/uO/lIToOOcDzHEpGCwn8UinJnV0G45TBTY3S3c/zVmBCDA1h+SSF3SL4xCs111Fvi4dZ+JDc7KPMz+3MEaFttRvVXyqg2pCr7zTfg9QkLplS+o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by PR3PR10MB3866.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 09:08:19 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d045:edb:e12b:93ec]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d045:edb:e12b:93ec%6]) with mapi id 15.20.7316.037; Thu, 29 Feb 2024
 09:08:19 +0000
Message-ID: <e9ec540d-3cb6-4c25-8691-6e3d15989c95@kontron.de>
Date: Thu, 29 Feb 2024 10:08:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spinand: Add support for XTX XT26xxxDxxxxx
Content-Language: en-US, de-DE
To: Bruce Sun <bruce_suen@163.com>, Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de, dario.binacchi@amarulasolutions.com,
 michael@amarulasolutions.com, bruce.sun@xtxtech.com
References: <20231226075812.3803-1-bruce_suen@163.com>
 <CAMty3ZDRSsR-RNapU5npfdG7CixSV3NocJ4Q0oNwv9V21THRjQ@mail.gmail.com>
 <286a15d2-b2e5-4291-8e54-516f7242812e@163.com>
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <286a15d2-b2e5-4291-8e54-516f7242812e@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0040.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::8) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|PR3PR10MB3866:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fa06838-5a75-4dea-a464-08dc3905f8e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7tF5jrr2oVhCDuNKYDIOrwkIw9ydYR5BF9JKzlLjxJG6l7nKI4jOhC293WTvtTkce+P+OuWDUpJOybzQsuEFX/t0jugWYXxcol7zhaKBOkfh7okwFaDMkMRwbk6D1K7rfOcDzZeD8B2PQEHWMnzoy8dk2tnsynBNK7nIAj2+tENKYFhYWSjagHb8pLHWmo3GgN4cmlOsH4rMRuvuhBKsrD4SUK+f1MCwbqZjJQ68cwznI3rzUk5FIGxmzoGuwGlFe0Mao9klv8GUHgL5iuJ4svHbM6C2lT5cJuii7/d2h0Z/rCQY/tZkDHo4hcKBORAmsj3usTl9w3xTx3fz9G0D2I91uPjMljQBH3iV1VQeOi5p0bXls3LGeElvgdePouTGLo1mWnxAYxcET5PtDJVyUmEcTzA/R45y24FVBYRFoLAG5iqPyqCtG4oWryU5qATZ/WccUogoZCPyNScTJhFOg78NnWp7EjftY6jv/DLDd6sj+IKLWmcHIoDUeSZuy7ClZpza1zkngNVTEpSdIXoF6yocbQ9onnMs1lQscdrCMse0u5kJqZoxsio9+hvUXHSJM72G2cul0/Ciq97B34CuLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVphNE8wdVJNWmZRQUIrU2JadmZJMEU0RXlKVGdiU1dGMHpGemJpTU9Nc2Zp?=
 =?utf-8?B?WVc1KzhaQXpjeENmVzgzN0JHb0ltYjJjb2syczdHcVZROCszWmRiT2J3UnpW?=
 =?utf-8?B?Y1R2RDdZTWpadXpZZXo0L3dwaGFURTlrVWNYVjBIMTExblJqV2toZWFxNk43?=
 =?utf-8?B?OFAvdzEzazdZUmxHY2pjQk01VVpTa3lwZ1kwaHJGQlpZbUd2bE9nK0Y5TFJ6?=
 =?utf-8?B?dlR2NXdPSE9iQmw1b1VUa2pVQ3kwN1RCTjBDQ2dkMmxYSmFDcTBTdU5zdWE3?=
 =?utf-8?B?cUZEaFdXZjVmc0F5aDNHTGNybWlFWVR3MEpuL1dTRjFtaWlOa1NRZkhQZy93?=
 =?utf-8?B?SjlpMjRMeFhHT0F1K2IvMGxMOTBKM1ROV3NHbmFmMTh1b1VmSldhcWwwZkhV?=
 =?utf-8?B?OEt1V2ZqcTU3QmlMQlhDNmNoc0J5aG42Z0pGRENRR3Z5RWNKRXpEV0NLeHR2?=
 =?utf-8?B?Q3J6WmdvaU9BU2NxNGpLaDFzYnNIOUpVa3QxazVBZDFzVWoxeTRnaDltbHg4?=
 =?utf-8?B?T3dVbUVzWnZkUWEyZCtqY1lzcEdvTG1qWWtJRmtiL3hBT2N6enhCbHAvblht?=
 =?utf-8?B?eWR1UFpWcWVJWVBzWDJtcHlnYkN1bmJWbG9FV3ZCa3dMYk1aNXhOY29hR0ZH?=
 =?utf-8?B?WS9zcTJONHpnTnNybXJtbFUycTZadmhBMXJCQVd0SStENmZ1aUZjbHFjNE1F?=
 =?utf-8?B?bXNqZjFnd2Q2N29pS20yZGgvemxhSXdSQXZJRmNOVzVDOUlSOFJRUXp4NWtP?=
 =?utf-8?B?eE9FM2U4NFQvYVNmaXdHR2I0TFFzL0E4WXBFSklpUzRYaEl4dk50ZTB1WE9U?=
 =?utf-8?B?SEUrcmZUTG0zcGlCb3JlUmlPZHpLRkg5RldhNkw3SlBoeVRUTXFqa1VQbmlG?=
 =?utf-8?B?N2tTV3JkRk0vZzJtYm0zcGdEQWxlbU1PK0ZlZklodnB5VnhQWFVUWjFKOUk2?=
 =?utf-8?B?amNjdFl4WlVOTENzVUVSZGZlaDFwVERocGVoVFB2azJpei9HekpER3VOdUtB?=
 =?utf-8?B?SG5IQXNCWmo2c2NDZ0FuT0V1V0lXUnBtZ2ZBcHE5Ym9ZZTMxRkdMa1JjQTRI?=
 =?utf-8?B?dlJKUDRlVEdETjhPVTJ0d29aTDc2KzBXMm1RR3g3L2VTYldaWUtVbHhHdWNq?=
 =?utf-8?B?M3Zjc2NBeEQydVp4UW90bjNsZzl5TXNybmZMNUNpWjA2VTM0eERVWTVDRDBX?=
 =?utf-8?B?WDlra1pMQTZFTms2SWpuRDVzS2Fyc0V2eHRsN3pFU2Z6UHB1RjVhSm1qbS9Z?=
 =?utf-8?B?aXJ2TGE5cmdoTkh1YnpndmtoNmluM21vUVJ3TkhSdEZENTNmVS9RYVdLLzZ0?=
 =?utf-8?B?M2JVZ2tmV2xyY3k1eEZENVlVTGFHeVlpQXJWWUw0ZjdUU1AxQk9vdzBicEFO?=
 =?utf-8?B?ZGZVZWZiTkxERUwxYWlBczB2emxKS1FjUndaT20zU2sycmFseUdiZGRWT3FI?=
 =?utf-8?B?b1ZXTCtJdU5qVHZtM1V4N0kyTjVBQXR4Mzl0ODJDak5QLzVUQWx6M2NpdzNp?=
 =?utf-8?B?UGcrUEFHNU10V2QzUU80Z21FNnpKVGVlRTNSbXI2cHNRK1d2bUlFSmk0aFFP?=
 =?utf-8?B?VkhNZW0vV2RjZEd1TXJUUjZWekd2aWJQYVpGUmNoWHZzQkt4WnBoR2UxbFBF?=
 =?utf-8?B?ZjhFdVgxaERGV3plTUVCa3ZOYno2UFpmYzMxUmdqcHpvdCtLWnk4bmZSS2Yv?=
 =?utf-8?B?c0VkYSsvcWtXWVllc2ZLbVBSdWM5YUU1MEFHZWs0QkhGVHgxeGVUUmcxd3NY?=
 =?utf-8?B?WVpJemw0T2FCbTZ0NzBOMU1HTE9zWXRJSGRsOGg2WnM1NDM5K3NaVGhpaW5p?=
 =?utf-8?B?NTNXVmNGYzRrcTNLS0JSZURpYzlFeWNtRzdsL3RyOVVZOUhxalppdTJ0VGwv?=
 =?utf-8?B?YWt3alYxa1l4UTlFRUJCM3ZqVER4WWNVRE82eVhTUkgyb3NaTDVLVXdnMTBR?=
 =?utf-8?B?RWkzQy9sWlh5ODR4ZjNrRmQ4b0ZZOXJaUkVVYytTTGRUWEFaUFA0M3pFMFlT?=
 =?utf-8?B?NzlYbVJMOGtDQ1JDRmdZRm9tTXk1Y1NOblhmdHVKT2dsbGR5WUhuZnJ1clQz?=
 =?utf-8?B?YnBSUVNidWNqQjZHeUdvM3ZoQVFvMkhkUlFiUjhNSHBvNWNZd0dCQW13WFZ1?=
 =?utf-8?B?M2pHT0V3dWEzcEUyYTlDeEhTdUlYdktXNmc3RVREb0ZpdStqRnBGM3JiZi9x?=
 =?utf-8?B?MkE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fa06838-5a75-4dea-a464-08dc3905f8e8
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 09:08:19.4348 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0YkuDaE1GiGxGTh496rz9hn21tgdZurxUeqpLVuiqWrK/SBOFt+ZK5YV07waePVfW6n3RKee7H1jwRB79/6XZMxPFQvVhHKdcmcRrMRHX+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3866
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

On 30.01.24 04:11, Bruce Sun wrote:
> 	
> Sie erhalten nicht oft eine E-Mail von bruce_suen@163.com. Erfahren Sie,
> warum dies wichtig ist <https://aka.ms/LearnAboutSenderIdentification>
> 	
> 
> 
> On 1/29/2024 8:00 PM, Jagan Teki wrote:
>> On Tue, Dec 26, 2023 at 1:28 PM Bruce Suen <bruce_suen@163.com> wrote:
>>> Add Support XTX Technology XT26G01DXXXXX, XT26G11DXXXXX, XT26Q01DXXXXX,
>>> XT26G02DXXXXX, XT26G12DXXXXX, XT26Q02DXXXXX, XT26G04DXXXXX, and
>>> XT26Q04DXXXXX SPI NAND.
>>>
>>> These are 3V/1.8V 1G/2G/4Gbit serial SLC NAND flash device with on-die
>>> ECC(8bit strength per 512bytes).
>>>
>>> Datasheet Links:
>>> - http://www.xtxtech.com/download/?AId=458
>>> - http://www.xtxtech.com/download/?AId=495
>>>
>>> Signed-off-by: Bruce Suen <bruce_suen@163.com>
>>> ---
>> This won't apply on my spi tree, maybe some out-of-master changes are stopping.
>
> can you give me your spi tree? I use
> "https://source.denx.de/u-boot/custodians/u-boot-nand-flash.git“ before.

Using u-boot-nand-flash seems correct as this is what MAINTAINERS lists
as tree for SPI NAND.

Jagan, I think this is expected to be handled by Dario and Michael and
not by the SPI maintainer.
