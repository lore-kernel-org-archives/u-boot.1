Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31663D4A5F6
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 04:52:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8360A80325;
	Fri, 16 Jan 2026 05:52:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PiBJeSgp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7EFA80325; Fri, 16 Jan 2026 05:52:43 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazhn150100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d800::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45FA082BF2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 05:52:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wpe9ZO0jtfDwg0o1AKuiZA4ZPbCVuwC2bzV6YKFdlEtcNWU4mCGLe4mDKdYD/+Y/BE97UZYhDzmSuzY6fHVmAGG1J71UqQa7GpSVVU1ENQn95imwIp72JKJPzWtkukih/p6kBN0ERZXYeO4CPnEC8uSowRufzGhbNNqo/pNao6GEmDhMBGkFddeNYOK1XjMnDTXPVpSeGb8xaoa5gMrGXuNqsFW6s1/TDkEO5uiScOLPnbednLyLchiWYCqn4ilBl9xPALyW6JZN59OsaKpQd/fl1EJ0PeEMKGhY5/w71tyZv7eg+xYZoRH8nA5hLvTluGwJ3JRrxUPwRYv+PNDEVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bM4DiIAVzb6TEQBXdwCodoxDjMJQXA0piXzhtqAIpC0=;
 b=T9VBCvAn3gnf8Ms5tAS0pqRVqVh1cXsBKRQlG6U2+QdQiUUtl+Ln4NuK4bcApsClevHJVAV7iy1X/JTAN1S+w7UgVuSZys2jqd4YU+eVImLQRkrkS/4KZMMf9PYgR2wj16ZrlMP2yHNjzZNWQqeujR4hqK/aDKWYO1GgaA1SpK4aNX5gk01ZGxJJHWM32Ar3e6NDHQB5V9CqitCJlsxbDCvPVbCccpbiEiszw2CULTHibKXRgXtvhRPM2St2BV9RouG2vlPGWqJplG6LugIXr10TYvmC89dXrcjRxXEnLZZ3Cuzbg/uNYrNDtyLQ36cclj/kACemUFHuoSt3PLcsUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bM4DiIAVzb6TEQBXdwCodoxDjMJQXA0piXzhtqAIpC0=;
 b=PiBJeSgpH684MwzzOgc6UJ72LSFtXQ0iKKpPVCt5K3xUlSxm/RtaRS5/+lUKDIg4aACz0Cv0gdv8F5l+Fl86Smsz4pm9WTUY/w5Xu98K3lBZXiHPzni7zRf/4hPqLvaFUXPXr7jLYdz3XGJLw0QgoUveCwyh66LDW7IbhffSSyk=
Received: from CH2PR16CA0016.namprd16.prod.outlook.com (2603:10b6:610:50::26)
 by PH0PR10MB4584.namprd10.prod.outlook.com (2603:10b6:510:37::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 04:52:36 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::b1) by CH2PR16CA0016.outlook.office365.com
 (2603:10b6:610:50::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Fri,
 16 Jan 2026 04:52:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 04:52:34 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 22:52:34 -0600
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 22:52:34 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 15 Jan 2026 22:52:34 -0600
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60G4qW6m2575031;
 Thu, 15 Jan 2026 22:52:33 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 16 Jan 2026 10:22:32 +0530
Message-ID: <DFPQT2IBGF8N.2F3UU414XE4Y@ti.com>
CC: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>, "Beleswar
 Padhi" <b-padhi@ti.com>, <malysagreg@gmail.com>, <sughosh.ganu@linaro.org>,
 <philip.molloy@analog.com>, <marek.vasut+renesas@mailbox.org>,
 <james.hilliard1@gmail.com>, <afd@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <n-francis@ti.com>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 2/2] ARM: OMAP2+: Pad SPL binary to 8-byte alignment
 before DTB
From: Anshul Dalal <anshuld@ti.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Marek Vasut
 <marek.vasut@mailbox.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260112101102.1417970-1-b-padhi@ti.com>
 <20260112101102.1417970-3-b-padhi@ti.com>
 <DFMMUHPP8BW8.3M5VVTPEB9IZL@ti.com> <20260112164854.GQ3416603@bill-the-cat>
 <8eb4eeea-a755-4032-ab95-2b293f2d2289@mailbox.org>
 <20260112220536.GU3416603@bill-the-cat>
 <66ec9e5b-1488-4e35-9a56-91d4b70ff0fa@mailbox.org>
 <20260113150024.GX3416603@bill-the-cat>
 <bbbb72e7-a7f5-48b0-b3e2-fcc83d5b1658@mailbox.org>
 <20260114141735.GA3416603@bill-the-cat>
 <7f1f7601-23ec-4a36-8e2b-3b4b679da6aa@mailbox.org>
 <CAC_iWj++nNLDMzJECV__VBQkNPwURGsRpnD5HUUt40+dA3w9Ow@mail.gmail.com>
In-Reply-To: <CAC_iWj++nNLDMzJECV__VBQkNPwURGsRpnD5HUUt40+dA3w9Ow@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|PH0PR10MB4584:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ff94366-315c-42be-532a-08de54bb10b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|34020700016|36860700013|82310400026|12100799066;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eUkyUVFoNUN6Ly9NaTR5RkVYU0VCK3JOYVF0aktobStUZVQ2RHQ2a0xSd0JQ?=
 =?utf-8?B?UmJINFhGaU9kbmhJYXhDd202MWFUV0NCaU9VYm1PVEE3dmNBOVlZOHp6RWpq?=
 =?utf-8?B?TkhZbGc0TDJpZDRzS1IrQ1o5VWMwNlQ5VFdWeEkwenQxZFVVZXdhcmozcHJx?=
 =?utf-8?B?QVZ3b1EvbFgzTmZyWlhtdFJ6TFNwZVA1RFU4QUZweUNTTkJUaStKenZHcm80?=
 =?utf-8?B?MGF5T3RqVVpNSDhodUpHRCtBRjg5eDNwd01YVFlBMWtRVjRHemJsNDV0Ry9C?=
 =?utf-8?B?UUY0MzFPQWNKT0xZZi9wajJXc003TnY3U1RMTEJyNm5SQ0JJaU5tdXZBNU8r?=
 =?utf-8?B?WExtdzRpd0JTZ2dBNWJPbmpqR2Exdy9PQ01MckYvWWkzYU5UUzJXU3hVUmtQ?=
 =?utf-8?B?Nk5YYVhHd1BGWmdScW1BcE9sTUQvSlJBOVpHcUFNQUluWGdMK0h2N3E2Wmw1?=
 =?utf-8?B?ekZpZmxpSno5bnh5dTNRRm85Tks5QkR2RStUaUlTT1BoV2NxaktBbnZQcUVS?=
 =?utf-8?B?cmpUZHJUZEgwRVVTMVBvTWNWNWlCS2FsYytmV2lKVFpnRHZNUGhId0tLY3Yv?=
 =?utf-8?B?eUFNcERQWGpzOG1IRXl6bmZIdUpmMyszeVBKZWo1QXl0MDE4REUrMGQ3d1pW?=
 =?utf-8?B?cHJINkVxdTlmdUtKQ3c1OFV6RU1mV1FodkNiTTJiSXBuL1JBL05VY2JDVXN5?=
 =?utf-8?B?cnMvNGU0ME1NY0lxdGtVdmtBSUVLQk1BZVAyQ2V3eXJpanNLajJoVEw2NElo?=
 =?utf-8?B?aGtuRWxzT3FXaVBSRGlRWmd4VkE5MU95czQrQm9Uc0ZYVmtzVVllamM3cERs?=
 =?utf-8?B?TFc0SzFuYVM0WmFPdE93Y2JUbFU4QUdsRS82M0JTa2s3aDNIdFkzUVpFbGNH?=
 =?utf-8?B?TVRMWHFONEcyZkFCTC9MK1pmejZSRGRleHVScjQvY1cwOFZOa2xVNnNLQVNE?=
 =?utf-8?B?OWpTb0s4UFovRXAvdGcwdVV6R1M2bDNYN3FwUWxUUG82Q1BLdTNOaEJnZytu?=
 =?utf-8?B?Uk1XTDRIVTgvY08veDRTRWxEcmdHZnB2bEx2ZHZEVjkrQytIWDdlYUJPSkI2?=
 =?utf-8?B?ZzlyOGI1TkZFMklNRWVGVlhrZzFENGxUKzJjWjB2UHN2ZG11bHlNa0VQZ0Jx?=
 =?utf-8?B?cmx2MlQ2RTVVUEVGbElWeDVQai9zT1VxVW9oaXo1Nk9tUnU4VDRVZ3VvRGJn?=
 =?utf-8?B?SFhmUTZzU25JMnVCVmRWN2F6aVRyc3kvS1RsODZGWm1ncXh1dURjb0piaGhR?=
 =?utf-8?B?MWkzSE9vSEZLbEx3Mi9KdzNwTURqa3kwOHAzbC8rNUpIU2RIaGh2OG5VSGpY?=
 =?utf-8?B?dDY2WjV4RGlGcVI2L3BSSVNRRU9lcFJHWERMTUJWdWlJVzA3OW1FYnlSdFdJ?=
 =?utf-8?B?emFtbUdiV1NEbTlQS0g1YTdrVWlkbVc0Y0JVMmZ1ekdzbFd5ZEFQQ0NIYnk0?=
 =?utf-8?B?eVdzTVc1ZGJiTm9LMW94VS9hZTI2WWNZWWNXUXVoNVRnK2ZtRFhLa0FXV2N3?=
 =?utf-8?B?ZXJDL0VRbHg1dnVhRk9TeVFndzZ1SzBMRk5ka3ZTTm16V3NxTXpEbE1YSmJC?=
 =?utf-8?B?VFhQNi8rSUh1cWVWR1YzR2taUFhha0xtQ3BwZWVZZ0M0RWx4UU5GQUtGWVo4?=
 =?utf-8?B?RURsK0JHb1R0UWRXYkdUM2piMnF0YWVBVms2bzRBZEZoTFpFeHpiSHdsbnVr?=
 =?utf-8?B?VTNwTWF4Sy9FaE8xQXNMTXRWUmJBa1JKUFFubWNuMHQwbGNhaXY5MXZKUmd4?=
 =?utf-8?B?bXhTYjNjaVNSTkQ4N0x5bmVKTVFJZnVYeTBKU3REcmwzMjNTdmVqS1VUbHlU?=
 =?utf-8?B?QnVySkxyV0htTlR0NlZUYkpRU2x4YXFPbEZZNnBSRGlvQWNhQ2RJbndlS0hu?=
 =?utf-8?B?QXRpTDVTTDRobGd2b1lGUStoYWd0c21OYytlQThYeUZ2WStCVHA3MXdDbEI5?=
 =?utf-8?B?NnJOMzFpUVFpd285emliUG9CN20vM2pyT0VTZWVTZmlJdTRJZDFRN2JtL3F2?=
 =?utf-8?B?V1M4Q21pc0gvRGRCTjdpQVA0MmdFai96cjM0TmFBWk5kbEFnekdEc092NC9N?=
 =?utf-8?B?YVlSR2E2cVR3dVBDL014SmlBNkhhZjd5V2U2bHJEREsxcExHUnArQ3JwYkRv?=
 =?utf-8?B?RVNZdjdXUjArT1JLdlBMb1ErNi9IWUFMODI4cW1CVDhLaW80NnQ0UlhnTHV3?=
 =?utf-8?B?eFRXTDFFcjNHRkJvYk5xL1RUTkFEODhZUy9pTkN1LzN3eThjb0ZEYlBhYnhi?=
 =?utf-8?B?bWcrSUpFQnhKMW5oNDBvRm9tOEZ3PT0=?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(34020700016)(36860700013)(82310400026)(12100799066);
 DIR:OUT; SFP:1501; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 04:52:34.8159 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff94366-315c-42be-532a-08de54bb10b6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4584
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

On Thu Jan 15, 2026 at 1:30 PM IST, Ilias Apalodimas wrote:
> Hi Marek,
>
>
> On Thu, 15 Jan 2026 at 02:02, Marek Vasut <marek.vasut@mailbox.org> wrote=
:
>>
>> On 1/14/26 3:17 PM, Tom Rini wrote:
>>
>> Hello Tom,
>>
>> >>> OK. And why can't we make that check at $sym rounded up, and ensure =
our
>> >>> build targets pad? Going back to the commit message here, it's easy =
to
>> >>> tell the linker to place $sym at the right spot, but it's hard to ma=
ke
>> >>> sure the output is padded. So having typed all that, maybe we need t=
o
>> >>> do:
>> >>> d) Update linker scripts to ALIGN(8) the above symbols and have the =
make
>> >>> targets use dd to ensure padding prior to concatenation
>> >>> ?
>> >> d) looks like what we should do, yes
>> >
>> > Poking at this harder, I'm not actually sure we need to use dd at all,
>> > but we do need to fix our linker scripts, and then going back to when
>> > Ilias reworked and cleaned up a bunch of them, get the changes reviewe=
d
>> > by the toolchain experts he got ahold of :)
>>
>> I wonder if LD can always guarantee trailing alignment of the binary. If
>> it can, then yes, dd would only be obscuring alignment problems and
>> trailing DT look up failures which are hard to debug. It would be nice
>> to drop the dd part, but I am not sure if we are able to do it reliably.
>
> LD won't pad align anything that doesn't have code afterwards. IOW
> inserting an . =3D ALIGN(8); just before the .end symbol won't guarantee
> alignement unless there's a section/code following.
> What you can do is add an ALIGN(8) inside the last section. That will
> guarantee that the last symbol is aligned. There's also the SUBALIGN
> command which messes around with the input section alignment -- that
> normally is automatically calculated, but Tom tested it yesterday
> without success.
>
> I'll have a closer look to the linker script in case I can come up
> with something more elegant. Which defconfig should I use to reproduce
> the issue?

We have reproduced the issue on multiple K3 SoCs, to start with you can
make use of the am62px_evm_r5_defconfig with arm-none-eabi toolchain
from ARM[1] with version 13.3.rel1.

[1]: https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads

>
> Cheers
> /Ilias

