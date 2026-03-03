Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E468EEC1427
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 10:41:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18E5C838BB;
	Tue,  3 Mar 2026 11:41:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="USkyUMgP";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="USkyUMgP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B39A83E7F; Tue,  3 Mar 2026 11:41:42 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D46B68063E
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 11:41:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=GlCzmBtE+DVGpuaDbBhnAFUhuxKKVUDUTf5X3R44cx62s2EnqB5z64EDMiJmWsYuLBMBZDoK875dEuBvUKuNlqGfoAJft05kmcW1h50khKKYUhx4OVFls6BZTETGmuskafdeFbeKjOmo4QPqZw8MeousaQLF4UmUlTDixvomd+ox6cz2wvXM0BnN/66tpGvti6EbwabVE/+AWjvGVyZVJW8X+71B83hOWRnANblFX/l2X2TIv7aeS1AzjNlF73Oa9K4p5F+nIC1IjAVZOETTjVRj/TFyiLsIk4qVrp0wc0982dojY2Ga55oi4BfgiqY9EMXGaPivSY7igQO/xnDOaw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMEtb9hQRfm7PNmUtcFah3tthwNa6mTltmZzDzzInoc=;
 b=c1RSZ4BNlgmh/J5nRPDA082bqmFr25IzceU8qyT05R5PxgteeVIgt4BjOGqgCM9KV7owiC9kBRkTvjBrBqx7bp6lgB1MHavOLJAkpXXfOlDIZLOtL3Q0A/51IQVzPR4nywi1m5bd6TiOo2hQAs9sAfqz3xSrlEo0JEzkEvVK9qVny1q4DEaSsTpbLpoOG0mNnHOJJkec3NCVMvrEDHhRAsbGaBrDZAMaH+WCXRYzht0A2Hn49V2gKO0nRRBdyhzCyOu235r9qQC4bjZxaqaCMH3qZffyWEo7rj8M/0Jvii/eakxQ45lKmQ/BvzqAnrTF/PeS/0wht0/dfwMlKLvqzw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=konsulko.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMEtb9hQRfm7PNmUtcFah3tthwNa6mTltmZzDzzInoc=;
 b=USkyUMgP54gMvF2bEE9x3cQQW/GLKaTsorg8rvgkXQVOJxI8g6dSvjub8B8bM6CPsTc10L753Hwg98dPhArXJg8zOXTKifEF9Vegzac67itw3vUwaAG9D7fz6oZlmX+/M09hvqYRs+rQoUdAHWPsbY6HjPNKD4try91VbOmmFbg=
Received: from DB8P191CA0002.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::12)
 by AS8PR08MB6694.eurprd08.prod.outlook.com (2603:10a6:20b:39e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 10:41:36 +0000
Received: from DU6PEPF00009529.eurprd02.prod.outlook.com
 (2603:10a6:10:130:cafe::b7) by DB8P191CA0002.outlook.office365.com
 (2603:10a6:10:130::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.19 via Frontend Transport; Tue,
 3 Mar 2026 10:41:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF00009529.mail.protection.outlook.com (10.167.8.10) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.16 via
 Frontend Transport; Tue, 3 Mar 2026 10:41:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DoODhaf3oLbsUZdSvbuHzNsrYpev02dfIIz+Aotqs6eKmADgKa6j8MZY2smvEevvYeSjCQwglNsfqXLzwnYlaWa1jrv5cFLJc4G7BljpkabDVoQVnXfkstULvOzig+p+1BmV7H14jttD5/IRaiuATs7DpGj7cXup7QOWXj8/3WLnkObTypGTkxwvTUlosR1naIlB8svFzBibtmetSpQd5KgOs5hqc/N8WMl2uUPfohivQOizFXvV7/j7G23WWE8P74nmj5amaa+U4prEpvLKGqJ5A5Pkqvj5yuWXOphKA0vmeq7vRJ+e+1q5Tyv3ZfUjBUs/LQSlX5FvQSMlebCH2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMEtb9hQRfm7PNmUtcFah3tthwNa6mTltmZzDzzInoc=;
 b=G/6ClU4DbFFx5gFQIVm429XLxt4/gSD9a/dYcKK12TimgtTtte6GVHWEzxbmVsx5rwbSrATaKnL7bQ7VVJ55RqKMdiPqhAPo/gpVObAI3CpOZvieMJH2TOUhc9QJAiTXqhfeRuxjajOpOH+Qt0ElmK+hpdSw1MaffgprljYxybAqTEJo7sP82Qd/GQDchixQ14x3wPRAxiMxIOulKU90Jas42ABIbT++ByNs+x0EBA5xxslDcxV418oS/ArpjiHHq8DvYqI+g3HjbAeVPjF+5n8Qc0jdJLEqG7Qid29FCAJSWODzuL+14SOXdwcqtq6E69p5ZPM/c03dHPQzgZGhZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMEtb9hQRfm7PNmUtcFah3tthwNa6mTltmZzDzzInoc=;
 b=USkyUMgP54gMvF2bEE9x3cQQW/GLKaTsorg8rvgkXQVOJxI8g6dSvjub8B8bM6CPsTc10L753Hwg98dPhArXJg8zOXTKifEF9Vegzac67itw3vUwaAG9D7fz6oZlmX+/M09hvqYRs+rQoUdAHWPsbY6HjPNKD4try91VbOmmFbg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by DU0PR08MB8373.eurprd08.prod.outlook.com
 (2603:10a6:10:40a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 10:40:33 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 10:40:33 +0000
Message-ID: <75ce7bf5-840b-47b5-b6d6-cd24d46bb951@arm.com>
Date: Tue, 3 Mar 2026 11:40:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Security Disclosure: Multiple buffer overflow vulnerabilities in
 NFS client
To: Tom Rini <trini@konsulko.com>, "Lee, Sin Liang" <slee3846@gatech.edu>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "Kim, Taesoo" <taesoo@gatech.edu>, "Zhang, Cen" <czhang887@gatech.edu>,
 "anshuld@ti.com" <anshuld@ti.com>, "bb@ti.com" <bb@ti.com>
References: <MW4PR07MB86367A3DBC308E10144FE6A6AA73A@MW4PR07MB8636.namprd07.prod.outlook.com>
 <20260227184202.GZ1593142@bill-the-cat>
 <MW4PR07MB86365FC9B8024035576E2C7DAA73A@MW4PR07MB8636.namprd07.prod.outlook.com>
 <20260227220730.GA1593142@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260227220730.GA1593142@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P265CA0056.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::23) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|DU0PR08MB8373:EE_|DU6PEPF00009529:EE_|AS8PR08MB6694:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fc795a0-f0fd-471b-7761-08de791171aa
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info-Original: 2OsZaNYudJ/HrtgyWsbshTjWHyPwN51Dfedck/etJayoqehlMZtfeledc1/UqVaUwtlRz/kGXv/thxwYnlhr6QfLAUMPrb3bnfaIo7/5wQ9A1A78gP22qUc4R6w9YAfoRjjdHrcDxCdJNPfjHLc1/6NtAOefnYLzIb25WdobI8UqAGq7UfoOAa0n1ZJgI50cPlPeQYBqCh7voP/FscmRXswgGOpuT9dkFDgRJfAd+M3z+V5RKsU+l4YuQYJUnCF6m4KffPJwlFTmlMgyupg0wSPwavKUXjYRMZ1wb1UFobQ21NCeKiufV8aANSEn61/niiHLRKV5oDYZpYS9To/RQdrkz1vwV44jI2njLfJFzOGuWfOneU8cT3I0w47DLJm1qIJk8eEaf0bJmKdZDkJgWvUIZbXBKQRutN10+8FVhXITJzbanIg4rrGF41HJNhCduiqgtKciPgzE1widI6OVIyX9dx64oDkGFf45SwzdqDNckAO98C24KzfhHSjb9rE3vcI75xjudCSDq/NAhmip2Nd8YQwu6vDGRPzfxH7Ti1CuFeW5KFnteDAGA3J9K8CRMtdtAvAOGm9Fug7LmPRfU2/tKJrxOHhjJTrJ/jUxy2Tic3usOEm4y+LPQdiM+/xTmcdMhGv/5AYhb/TqpIAtJSxFkPoOwz3PpJFAj2vUvUtgHytbPaaQX7Czq2Vq4LTa
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8373
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF00009529.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2d3d547d-dc89-488f-c3c7-08de79114c0f
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|1800799024|36860700013|376014|82310400026|14060799003;
X-Microsoft-Antispam-Message-Info: EJrHPvjqqQLu6j+sn0R2MMU4CeTj45zCpGj6fRap3Dz4uKnwMnl3nJy8EIZvXyaiU8AvwJyxY1zj2sjrJD1bA3lOLJ7m99lRZmkQays7psUyeV/pbs7+9E2ZapqB19nsZZcNjybtr2fiqblqxnDZAhwm/G3QXKLAY4IdjyJvePYBJJjTh6Ru5xFONdk6MNA6hpqqAKkDVv4MNeMSnugGvDF6L2u21pKdtJQmWST1URpVX2xQxP5hvZSnwiTpEbjlsFEMmXM0G4aXDlHnul2jjP8D9Fax6X1XLYhWB+l35J6pwg5DzAWVTiHcanyEVM/Ynajmuj53qcqwxsvTdyEPK/U/QpXphjzhLREnYOpfIjeXqeuCpZnao6q++hCwEnQt+ZaMXivwJkZArgb5fB9zzgGcRo0KLjK6yFtXm3LQuHs6h7oOyFdYaQUo4WgRiuyoPzck7uKuqjIm4YDEesM6w6r01pd9fm7R27bTFVtRZmIwaNK0wEbhqtsugyISL6dz5z0RNUvzRPNrMPLAALzdrD9c6yJcRogeRfZR1C4N1ro1nPpFR4a85Hdjvk1F9h24oqNYzDBbOOdwX7ukT/qB3RmGtVUKa0gGRKCbt4XN6iSS3qZ+mynQ2EDAGR3uiMjjaSUvOgCwmJJueszlV5Pc9I1RKCHs3k6U054qGGVbn0teWHkfpyUuFeAsAJsZfqk4M0V/BS72vO9WhVusU8bcHQHDJuzmpGN5YVQdTp3obCvamqvga1597ojGxs9wO84MViPghFUPGhquu6S893cceg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(1800799024)(36860700013)(376014)(82310400026)(14060799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1rsrA5hLhtahXcrDRg2p3qRX00NHD+CabsFGF4/JbO3nNvvG5nbR/jlae7wij/qUG8wYoGnM+tOdxP4doqX8Y+yOQlDjIwwpEb856scPEA5UB2CbbTyKDhqKIfaiqrJ2BY1FX0hyYrabfKUUHwcU1L0imJA/1xRODDCCNoz5RjhGgg2crrCofAmpsuKdRk9baB1032EdOK/RtIAMwztOO+6ZIrT4UfWQhV89jgMQ2qd+Ai2pJswC+ham8MhbAGyHFE15qC1Qcesqj7zCTZpvkPWnucDxRLWgMTbFeRu/AuEfei3BmEF94MclH88D/p6/5ZbvjzRgE96IPcIgwu54heGegNOFcy/QDzOq5+iJYVrJHNSk53jvDN8/Bu8P37BkWv6YacdZRsVhcp9RnICmB5G1nXaYPQA4icBYq+NrX9NHWR0hgAc42SdBwJ+jNYMA
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 10:41:36.0506 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc795a0-f0fd-471b-7761-08de791171aa
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009529.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6694
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



On 27/02/2026 23:07, Tom Rini wrote:
> On Fri, Feb 27, 2026 at 09:28:44PM +0000, Lee, Sin Liang wrote:
>
>> Thank you for the quick response. We will follow the  submission guideli=
nes for our fixes and attribution.
>> In the meantime, would you be able to confirm the reported vulnerabiliti=
es on your side? That would help us make sure we are aligned on impact and =
scope as we finalize the fixes.
>
> I'm adding our networking custodian to the thread, for when he has time
> to take a look.

Thanks Tom. Where can I find the report?

Thanks,
--
Jerome

>
>> Regards,
>> Sin Liang
>>
>>
>> ________________________________
>> From: Tom Rini
>> Sent: Friday, February 27, 2026 1:42 PM
>> To: Lee, Sin Liang
>> Cc: u-boot@lists.denx.de; Kim, Taesoo; Zhang, Cen; anshuld@ti.com; bb@ti=
.com
>> Subject: Re: Security Disclosure: Multiple buffer overflow vulnerabiliti=
es in NFS client
>>
>> On Fri, Feb 27, 2026 at 06:25:14PM +0000, Lee, Sin Liang wrote:
>>
>>> Dear U-Boot Maintainers,
>>>
>>> I'm Sin Liang Lee, a member of Team Atlanta<https://uk01.z.antigena.com=
/l/FkXD3Ugm3o395hSGihLLjAsEOr97ZZG9yHPkWSFCru6du~q0rO0A9lPeOIDFs~icGGG2caue=
tha9bTyQwPhsFDZCxgr_yTluQpnzuqlBqPPnhsEacg7k~eV3QgS3i-KPZYPgSLmwQm6FkD_rnc7=
9dT_wGaI2_RcoAV-FtVTtR5ZERydkTR2aruAxMSROlBu62FMJeds3 > from Georgia Instit=
ute of Technology, winners of DARPA's AI Cyber Challenge (AIxCC)<https://ai=
cyberchallenge.com/>. We're reaching out to submit a vulnerability report t=
hat we identified using our system, ATLANTIS, in your project. This effort =
is part of DARPA's initiative to apply competition technologies to real-wor=
ld open source projects.
>>>
>>> We have built an AI-enhanced CRS (Cyber Reasoning System) for automatic=
 vulnerability detection and repair. Using a combination of targeted fuzzin=
g (via OSS-Fuzz infrastructure) and AI-assisted static analysis, we identif=
ied four buffer overflow vulnerabilities in the U-Boot NFS client reply par=
sers (net/nfs-common.c). These affect the current upstream codebase and inc=
lude a signedness bypass of the mitigation introduced for CVE-2019-14193.
>>
>> Ah, so that explains the squashfs report last week. I am glad to see
>> that part of the challenge now is fixing and not just reporting the
>> issues. Please see
>> https://docs.u-boot.org/en/latest/develop/sending_patches.html for how
>> to correctly submit patches to the project. And while we do not
>> currently have formal guidelines around AI-assisted contributions,
>> please see:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/coding-assistants.rst
>> for how the Linux Kernel expects things to be attributed and note that
>> we also are requesting that the commit message be human and not
>> AI-written/assisted. Thanks!
>>
>> --
>> Tom
>

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
