Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DED6C71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 19:57:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A987282C2F;
	Wed, 18 Jun 2025 21:57:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="BYqPYa2r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63DB582C55; Wed, 18 Jun 2025 21:57:16 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7575682BCD
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 21:57:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UnwObpFsv4oOX3kKI4mpE/pKcT8ZlP8zHN3rWbFDcBM227T8mc5K7mGIGcIo+soRY1oemdIEReiBtkCfaSan6z1TaWwgAVkxtPcuuduTRVaTS3AF0TcgXphHctYaJzhjwlV5bFUvfUzHTn2hbhWbET5CnhXzqlhhf0bnzHQ9sTJp8mCMPyAgM6HWLzrKPTqNQoUZgrZklEYKja8jdoBglDK3wBCu/d1nzEUKJhClMo6+aP9pYz4/OYgsEpeNrpT9fF9Z4wAafND9khpcEtKrk0xpt651lsNJDEhJWo0pSpsEFwMpJEjprhQjs56IB2Tc1qGwcDKZnMzQTKINRWIqeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8w5QuJv3TTMUb4ppIojI3gZVcTXpJ4Y/xzY+QOSuIk=;
 b=kt87jz7n77WAe0s9P/xKz2US9KFEWVGg8CBUt2L9TW/QBJefiEKFI71p8khHI9WPFyz7HqnCLjzI/xWfzqUa/xWHR2jel2T0QsoND4xRvghCeeAo/SMG1tsnJniF6JQMD5+W3k66vyH5UUVTmPy3BRGdWW8AwIwm6X2+LZYtmf4raQkybTaVrZHRUCKLnagoY3Be0IMNRqlaiRRjJRa2L3iL3HSk64FOfF5yfmZS+Ut2fUdlLuOiYf5A209c5G4rD5cih+vJx38fdPjDI943GTy9lcImravVOPqbpIDv490+zhCYmP3XFBDORvTi8QwlZCgeyrzCELrap/sTUkYB8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8w5QuJv3TTMUb4ppIojI3gZVcTXpJ4Y/xzY+QOSuIk=;
 b=BYqPYa2r44DTcCot9cX8yNGZ7h9XAamPwsM71Gehx2S4lMvJtaqklJ7Ftbju1EGJ29FgTuIyD2w1vBJ6Wu89qoBLFkFzxmYDj1TmbyS5WUMuYL8HYZNtVrP/MiOkjRVxQV3x5a2LvY67aPUnHMcwf8SrTIrf6a9Oyf0RfmyDyHk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PA1PR10MB9177.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:442::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 19:57:11 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 19:57:11 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Re: failsafe update of bootloader on am335x
In-Reply-To: <20250618142717.GE6521@bill-the-cat> (Tom Rini's message of "Wed, 
 18 Jun 2025 08:27:17 -0600")
References: <87a565z21c.fsf@prevas.dk> <20250618142717.GE6521@bill-the-cat>
Date: Wed, 18 Jun 2025 21:57:09 +0200
Message-ID: <871prgzuui.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0077.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::20) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PA1PR10MB9177:EE_
X-MS-Office365-Filtering-Correlation-Id: 1905b3e9-e8f8-4101-cdaf-08ddaea25037
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|7053199007|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nAahsTlXJC+LRfrJ29xKtW6NIvgs8C+0cefeXcUBSYQQEM+YIKuu9LaSEtpd?=
 =?us-ascii?Q?W620B7RoALd5MQMXmzbhiGT1UOX48qJxiY+lwlIm5cLAQrULF2jAJYLk4b/u?=
 =?us-ascii?Q?9VXGUusjp5d59RxOrx26A0G/PYNI99UMnj2MHixJMRj8Yrb4VCvcWgW4XlDH?=
 =?us-ascii?Q?BqQmHg4hHEveCIQs0cpMeQ8+H9n76P4Mqb4tY8m1jkPW9jCdWXEfYLFaaoXj?=
 =?us-ascii?Q?hMYB48qUbWowgIqGrzQIuG8z8Hzjl9CRpgfy+7aRis5MKp58v/qS0QdrwnY9?=
 =?us-ascii?Q?E35Ak2L5viVi9MQzmHuT4a0jiddvmj8I98wx7Ai1x3QjMccMziEf4C0CulOk?=
 =?us-ascii?Q?gmZ2K3HKs+fU3qFkIYrE3dBMQOU9ad5WjYJ9Ah0mHzfNxxp48lQLf5bpuKBm?=
 =?us-ascii?Q?NT5TsLoMFetd8y5M51zCt84OjU0fHBYYIwp/ILj4fMZD1PYdY3tjBeyxOXpn?=
 =?us-ascii?Q?N/CPTBKkDv90C8nZPqSk9l+QkKOCb9ABRMrf+NfaDxG2hsHwX6lAkWHN89bN?=
 =?us-ascii?Q?pdQguDU4qHCkaP+BqJDRg+0QyNafyF/hXMFwgZiopJmq6lGzcKO38LN7RobK?=
 =?us-ascii?Q?04968QD1QZu/uj/6OR3763OskgamYWdQvJVJlGn6culRgOyn+KTVVnwJA1af?=
 =?us-ascii?Q?YgL8sUIcWltt+yWfO9KihAegxmSOkghRxdOP+Oy/857i1ddwRTAjrG8Chh8V?=
 =?us-ascii?Q?rGpmq6An48WhoJyoEjTWxD/PTKLaadaOKxHahKrLLdrbqsrMQmMHby06UN49?=
 =?us-ascii?Q?mUqH7DzKWmsWZO0cpNmsAE+DuY1JHO+ZA7P53ylDI4vPZV0m41yjheM/2Rqq?=
 =?us-ascii?Q?nrTpEsRIXDLK8z2dBZxcNt/3lJLu/5yrgFLnlmF136Y1j8IIMLRDS1FmwGny?=
 =?us-ascii?Q?HE0qTEQbemB6aFSWIDDGWf4A1zGdHBNXgKEut65QiQJW0gJzg/N2N+dxKa2C?=
 =?us-ascii?Q?ZeeIqwoabFJwP+m4shDYjmKqyQi+cQNn55lm3weXKum000doSZzNwJ41R5PQ?=
 =?us-ascii?Q?lFbT3pZSyNIwuGppyjiZFaJqDwHbaYfqN25Klr4sjMC8Y/+Ple3sKsqimVGT?=
 =?us-ascii?Q?r7/o7kLJ8iNmgqTxs+A7IXkpHUI9xYNqcSL0faXZH1DkHXtvqEaMLWK9r6LU?=
 =?us-ascii?Q?fsXRqSgKyjXK4oNZB9+udblsYYw8Z/8a+LoeUURHoz/40n6LXANdc5FjVAji?=
 =?us-ascii?Q?2Evh1iWZxKb6njyH2ygFjRxj84muJR5wvyKAIKkinLd+TS+J47aQnvruKGcu?=
 =?us-ascii?Q?uunzdDqM3DjI8c6sLb3T1rRl4IhmHJxlffqfgYll3kik3SRTgnESEXZtNfMi?=
 =?us-ascii?Q?jFrnpNZq66UzXv19R13RPkRKC0IT7MlkUV4kTjNU5jhskCFj8hALcbNLA2yW?=
 =?us-ascii?Q?Ct0rCWfFiDvpHy4OOLmTPZA5pFd9Izue1BRpWwRkPE5yXAGxMqfvX9oy8imF?=
 =?us-ascii?Q?Ov+w5dZbmAI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ceqxtjVWpddqUv8SMj3QhQNLZ/EdvTtCf8YiIap7K4VzgmkFi+FsmDHIrnKn?=
 =?us-ascii?Q?tgMVlgul29gA0GdW7bM4zRDkm7wjoVW1gOO8T+zzqN8hpI+IKMCpFEl/z3Rl?=
 =?us-ascii?Q?9VWtr/IHgo3UXG5EQ2GP7hSQUQAcBj+vTiraGXPV/O1eYE8pLQvccnhPOZgZ?=
 =?us-ascii?Q?4wB8DforHcv4sfXqLwD+DmQxe6FbNsUI21drnPykJQqwVhzNDf/VDehvBNar?=
 =?us-ascii?Q?6ZgqfIFyzudOA0m8ym5IHxm116b0kLcXBned3K+qgC8Oo4DaaSQRtqfBSOrM?=
 =?us-ascii?Q?joAP62VFhHeCxf/nwtVeDUY9s4lE2w+/avSKp+oMDdv7T/02gGwPQoU7VsaG?=
 =?us-ascii?Q?5JINud6CparnG6kIRatEMRqTMLNYl5VZXiTAtcQUvzxuaVy9g5FWtoSvQlYU?=
 =?us-ascii?Q?13fxKCbP6tNvpRYt9qm6Gz4R2F3GDQaLjKLodzgQkxc9zi5FAm7GXyLpK+ZJ?=
 =?us-ascii?Q?UoUzJRtF1kUN8AcxIah2DgJESzfX+xZ8e94ulZ9TZL7MxaasOv7TllLgVZCC?=
 =?us-ascii?Q?9PSozJd3f4uktehhVlJykzk2Wa1T5Uw6/908cqigtmU82vSCX41DYOkyoLz/?=
 =?us-ascii?Q?C142cGgpU3qy/cKir657GWLkwRdnRkyTAbkperF85z6AgQ0d400ZyMtRsL2G?=
 =?us-ascii?Q?w0mk9gA9+MJSHOh6Q5eM1o1eTtQ/uTNo6DuAFdSviZWh7B046n1yuCIkWgnh?=
 =?us-ascii?Q?eQREUi9esP0x3SuutZE6/bfa2hJehOXNKmMVSUkaR1dsNyEfaqIVUInZ2ZHW?=
 =?us-ascii?Q?u40UwnNoOAcElKhVApRW6LWG11PRXlgf1Bq1StLxyedOdVyal68uZBi4tbFM?=
 =?us-ascii?Q?ZnfJFrBquWuiRkxQetgTYb826TuGmx7o0u6yQh4m94L3AeWQ96XqImrHoqNO?=
 =?us-ascii?Q?sSadx4BSwgyrCxom8qkcazZsIHtkL50gQ+c3iSFluPkKgDQpYnenVR/Y4lyv?=
 =?us-ascii?Q?Vdt3VIAZopw5fcHPRRWOpDPtmePKst8+31p9IJre/JNtFpzoFOnrQlluA7Ch?=
 =?us-ascii?Q?KNlKb7cl72TUP8HotJ92mbWlSZld38VPRbqXg2/yAYz6BiYRbyd8AhW7XlIO?=
 =?us-ascii?Q?xKuUg2dOybCFk3dLWi0EjXEWOzua1/TOyh2oJ5B3gwJx1BmjIRANUDfa11Kd?=
 =?us-ascii?Q?JjloSzn+Ue6uFIeVdo6KAhxJw7GJmfxAdWGcqHO0BNCqfJXv4urX5+BdzADz?=
 =?us-ascii?Q?LPIzsbuJHtsjTSAULPymeGR6uSvoImD05zzjGpdHcV6gNpDGBgN+iwFVUgXw?=
 =?us-ascii?Q?LYc/Zn2R3+FkGkx9UhImviw0laI+zV2WtE9DvcnLrTNS+yre0bZ8GQ6xuWrA?=
 =?us-ascii?Q?EsfVlRguU2wKKeenL7CEHvvUHkyb2GPojxm+wjS/eh0epmzCV40mjYZj5dQE?=
 =?us-ascii?Q?4htS9PvJgWMlBkFYmSGEHEl2vs7C8iG3qaKqsNzrmQhxmiD2iXX4Fqv/XJxT?=
 =?us-ascii?Q?Pemy3JAT4FQp0h0Rvzylhj7inRS/nFh8vSyMIeprurCKb64Qq2qrskBS7tTf?=
 =?us-ascii?Q?Ob+gs7DvmrGFmRGkHJvuy2FpuNIplAcsqopZPmVHvn1Vhy9RjXtqnzRV+Mmz?=
 =?us-ascii?Q?FMYTrdqMTKwgkqEvUzKcs6PQ6W0XvpDYt9KWQBf/dMVIRbxZhjFfyDEpyu/f?=
 =?us-ascii?Q?ow=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 1905b3e9-e8f8-4101-cdaf-08ddaea25037
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 19:57:11.1649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8y+R9FDMeFzrF4+Y0MMg0bKHCaCOxL7c/oqzWUC+0jvh9VR7AkTZ1UcMN8W/u8xy6OgPqgGg87AFCmek+IW5ZxFQNUEikM6GLuAxrT9ke10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9177
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

On Wed, Jun 18 2025, Tom Rini <trini@konsulko.com> wrote:

> On Wed, Jun 18, 2025 at 02:07:11PM +0200, Rasmus Villemoes wrote:
>> Hi,
>> 
>> I'm looking at the am335x cpu, and have a few questions that I hope the
>> community can answer:
>> 
>> (1) It seems that the ROM code does not support booting from eMMC boot
>> partitions; I can't find anything about it in the reference manual, and
>> this ancient thread suggests that it indeed not supported:
>> 
>>   https://u-boot.denx.narkive.com/S8U7Z3Wr/dra7xx-booting-from-emmc-raw-boot-partition
>
> Correct, the ROM does not know about the eMMC boot partitions.
>
>> (2) The cpu does support looking at a sequence of offsets (0, 128K,
>> 256K, 384K) for a proper header/image, and will read MLO from the first
>> such offset. So it is possible to do a safe update of MLO.
>
> With caveats, yes. A valid header is all that matters and if the
> contents fail it doesn't fall back to another location.
>

True, but that's not really any different from using eMMC boot
partitions. You are safe against power failure causing a subsequent boot
from seeing a partial/broken bootloader, but there's no fallback if the
current active slot is broken. Only in this case one has to somewhat
careful with how one does an update (such as postponing writing the
first sector containing the magic header until everything else is
written).

>> However, it seems that MLO will always load U-Boot proper from some
>> fixed offset (or partition), independent of which offset MLO was loaded
>> from. So in order to implement an update mechanism for the whole
>> bootloader which is safe against power failures, one would need to teach
>> the SPL phase to pick an offset depending on the offset SPL itself was
>> loaded from. But that in turn requires that the ROM code exposes that
>> information. 
>> 
>> Does it?
>> 
>> Poking around the reference manual, it seems there are some "tracing
>> vectors" (0x4030ce40 ..), of which word 2, bits 12-15 are "memory boot
>> trial 0-3". So perhaps those bits can be used to figure out which offset
>> the ROM code eventually ended up using? But is there some more
>> direct/documented approach?
>> 
>> [Alternatively, one would have to build two distinct copies
>> of U-Boot merely differing in their value of
>> CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR, but that's not a very
>> attractive option].
>
> Something, perhaps ad-hoc, would need to be done to support a redundant
> load of which U-Boot to use, perhaps also leveraging the bootcount
> support?

I don't know about bootcount, but poking around a little, it seems to be
easy to provide a spl_mmc_get_uboot_raw_sector() (or a board_ or arch_
one) implementing logic to translate those trace vector bits into an
appropriate offset, with the definition of that function being guarded
by some new config option that should also gate four hex options for
setting those offsets.

I'll have to play around with our bbb to see if those trace vector bits
can actually be relied upon.

Rasmus
