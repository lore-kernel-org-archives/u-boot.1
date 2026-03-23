Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B3CEC01D4
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 12:10:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 547AA84114;
	Mon, 23 Mar 2026 13:10:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="dmR/3hi9";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dmR/3hi9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D1BA8412F; Mon, 23 Mar 2026 13:10:06 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FE8C84099
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 13:10:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=pMsX0kEK6LgcOKZ8oeQg53+s75URWRP0qc3Z6RgQ85VhFD7Y7rnG/1xBoqwXSD+57kTowwPuylCQu1HxCXsGaK9lnVyMc6A3P/BZZbaD+5eZ7WghvX5NBq3YwEPLVtaDWWEbm2IARzcbXh3vDv79BnshI26lI2LBQz71OoD9laYJ32NgoXDDhgfFL/9tUKObnJqwa8N6bX2kCUqthOVHGfMAV2O5zL7RygSL26qN6rN741nShYO/UrnqjrzUpN4WZs/Xr2aCRXYvw0x4iDyCxvP9JlGLs/e/BHMykWco8HAi2soGucoZWPUzh1Gle0+HqZH2CCuygQnZW3Qvw4XawA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36SdHtmuCSvG8WmwLoskpQbZv8OMP2aBw++GYGUR40Y=;
 b=Rej9c0rZIjRBThINeR3zyc23Jt2DSM5HiCtYRDRrbpZekKj+Ae++hF2E185B7/iykcX7wyKnIg+d+DkB8Y6ch6nLGBKN5erkrt2SSe3r/eOsDFVysAJZytT99JLIFJ1VaJaB8PfZXoakzqdORmMBvNFATGr1jAE40cWJ5PGIuyP7iXrF3VKUVL2fPZHZGeVh48lIAWk2ddOHavMy4ZcdKuoP2cWrSgXZFMdhpSwzv8Y3nM0+3y7VWYIea1NY6fq6G88FUBBicTxuMzNtxLWV+tebskDMAqx0EH7hz/fUdN79Xxl7YuniCcbF0tpJPgBQNbGlxFHdfFJF/U7wp71y9w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=siemens.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36SdHtmuCSvG8WmwLoskpQbZv8OMP2aBw++GYGUR40Y=;
 b=dmR/3hi9V+1af6yloCWzGRBGEdnJ61WZWE3Q2/rqieDaaiH8dixTkmSsJWsPxlW7Rq6byl5EHP8p9/jpV0j5/1+PlRXHnq90XPamGhkz2uyaZp0refNe9Xg+XciErlbESJ+qxvboXUGwklnRvAsj6NiviGIv1C3UFGM3QSPLO7I=
Received: from DUZPR01CA0042.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::9) by DB9PR08MB6330.eurprd08.prod.outlook.com
 (2603:10a6:10:263::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 12:09:57 +0000
Received: from DB1PEPF000509E6.eurprd03.prod.outlook.com
 (2603:10a6:10:468:cafe::4c) by DUZPR01CA0042.outlook.office365.com
 (2603:10a6:10:468::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 12:09:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509E6.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19
 via Frontend Transport; Mon, 23 Mar 2026 12:09:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cGnZuQBeu67YoRVBNWMgGzTCwypAyv5srXYSn2vw3DNN3tpr1yzFuFr8n7T6WTP2lgJi8Y8n7+2unEsEd2kM+DLIlaJ3817C0R5lN8PrwwofemWhVk5fwQrnUxNWf8CmnJzaJPxiuSUMb0U78WRTg8ddJ7XaWgj0cTAAZ7FjVrSaE2iDJ3tzWKRo2gESXNc3slaIgt8RvlFQgT2sHLlEzkbdU+x8AVAyB0wo1O/BHFIhB+jgROxO6k42CqxBE5vCk5x2hU+sh4D40uyn2JlLySVxLtgqNwpDUeOfbPQEIjqeslwfMDXRAjCO2Gqr2T0kxVxSt38dg9KdfJjrkzpANw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36SdHtmuCSvG8WmwLoskpQbZv8OMP2aBw++GYGUR40Y=;
 b=f3tn7QNrO4bjgDS/9lceafmfV7S1VNAfHGK6rzTssTPEO/lslSF7qgsFlZUjXLJ91ThyTm8qKMC8C+9wLygtchAStQw8Os0NIZM/xCdTpFhsbFBXRBMydZy0br5z/ThokHmsCj9x+/Y/Eq+AAdE9i1xY4KAhADKSNqkO6NM/VRdnvZkQD9z5lv1zHVwryIqwApLdWT3Mm7w7RlOlsonw2romcqscIePNrZUSrpiKdL4POnor+2sXTPjDiaM53bFaQ5l9VC5FGL+owqQOnxG+mPyLLOBhO7TIDwe2Sev9UPerrgWCf9XMOePiJGMVkOqKqzvahSayegJeIr1OE/pYoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36SdHtmuCSvG8WmwLoskpQbZv8OMP2aBw++GYGUR40Y=;
 b=dmR/3hi9V+1af6yloCWzGRBGEdnJ61WZWE3Q2/rqieDaaiH8dixTkmSsJWsPxlW7Rq6byl5EHP8p9/jpV0j5/1+PlRXHnq90XPamGhkz2uyaZp0refNe9Xg+XciErlbESJ+qxvboXUGwklnRvAsj6NiviGIv1C3UFGM3QSPLO7I=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AM9PR08MB6129.eurprd08.prod.outlook.com
 (2603:10a6:20b:284::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 12:08:54 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 12:08:54 +0000
Message-ID: <be0a3106-69ca-43f3-86de-0fd018e96e22@arm.com>
Date: Mon, 23 Mar 2026 13:08:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: tftp: fix malformed option string parsing
To: "Sverdlin, Alexander (SI B PRO TI EAC CCP)"
 <alexander.sverdlin@siemens.com>, "y.moog@phytec.de" <y.moog@phytec.de>,
 "alvin@pqrs.dk" <alvin@pqrs.dk>, "trini@konsulko.com" <trini@konsulko.com>,
 "l.anderweit@phytec.de" <l.anderweit@phytec.de>,
 "quentin.schulz@cherry.de" <quentin.schulz@cherry.de>,
 "charles.cc.zhang@gmail.com" <charles.cc.zhang@gmail.com>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, nd@arm.com
References: <20260323110516.84423-1-charles.cc.zhang@gmail.com>
 <63086c74fc1885ded988325e3a3e474310919493.camel@siemens.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <63086c74fc1885ded988325e3a3e474310919493.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0139.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::18) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AM9PR08MB6129:EE_|DB1PEPF000509E6:EE_|DB9PR08MB6330:EE_
X-MS-Office365-Filtering-Correlation-Id: c322eabf-0bbd-442b-e5af-08de88d51932
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info-Original: NuyMP4QpdtEV8ZBQvflwLzKvsL7Vgb2zbYauF4O8lqcju4H18fPME84JL7VxsYBbs0g7lipHTIWU/kNSQvrCZkpaRVIbiX08LfFuED1ICfCbLriT6r8n/kONE2viA9juGJajXkkdF6GS+Q9fGkPw8jWoDWpcbircoyjze67BVKSi8fPkUVxhIC5J98fwtTgrEQUi3fpDIqVTbgXkvzNOnPDYbCfRtxjQgx1iCmNgVdZzSj2l7rMSn6V8N+WOZfza8tz+mg0UnpsZC2AmQWoDACfbr4bpOrSTPbScVy7kOMK/xKIAXT7oWc/oTTKBRtUVOFSAulT1aOj9EBQ97YFheFds8VhbNavXVXjSpGSN6hYzgQuKzalBeqKZyvqE6WflXYazV2NWzeEMWPM5N/wGGAE22ojh0qs7uHJp7KPDjwQ9gXNDfwOZ8Qvm2Ghmmbiw8jz8xYsOdedNq9B7QdQ7G1tny8bbWFsrjZY9Pcr/D8cJESy4KovtM51czvO2g/nZQyWf3udnAZ4XcyIcTYb5+WkSEakUTJBzrX5rfbdF1bV1MArDb2MTmPSTBwSv5Qv9yu8nuvcE6PkqEBHf8MqatFuLFrAoY8C8BCpx/VUJRI3nULpNJVR3FStwirONaVsVi76Afmra7x4T1sOrZDl1tRRHoVDeJcl8a7QNsg7X6oG+3SbmiQ+ZyKHJYmmf5ASsVgeMru/ly3Ihk27/jY2BUf7vXmvkStOC9S29fLdbLtI=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: Fx2PDQQR3fR+iYN4wb/HZGdGCx20FcDFTkHLm1D7RNUcKDTfiFj9DDJukPZMIssyf0JBig//ax/LYj2STqJfGO+pgam/g2BgXQekpVy2Pc3PGuX8pFWMJilSDmLFQa7Ea0fSYxHgOC2oLYHg2O0TjsQYVwl+MpVMC3+WnGUooQpICv7SohadBYPyNA6jhkNcGohOswCJ3X/T2PnnRUSYP86KoLHIjl0cTOn+eU8YMJTxKsot2/F21wqHV9AEltmWBmjmb7CykLzsEpe3Ky4RvbcStsgwto9z8ea2or4PcW5+TeYoxB65fvFutqzgJXvpDVdMZ6vTqxfPqSkXWyFriA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6129
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509E6.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: a5480066-a877-4767-edef-08de88d4f3f9
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|14060799003|35042699022|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Lh3t56x46Lhv3ELBBqVqDum8XH1v6pql5JcascJ3nizwzznJh0hp/rmFPyWD34hziMejdNtKAFDekxpZ+2WgsEShG5QhiqXmZgPRPgRoy45y4o4XHquSDd/f8VPP2uY799FpgJicU+Xd+/0NZh/iyrq6ey1Vxks2TDOP0zTzbkdQjQtB498GXJYHiw9nISxbWwvFcJz1JUvjCeURHoyeimPnu8Fmldf4WfiAhiRhc+5+Iz0N6BkrASKGxIjNWlK5QFfQJa3jLwPOuBTmF6SkD9jUzpRLlXDODc2ZX6WoBy0vh/F4i5NfMQedNJyh8ksokywI8Q99ZAatxkTbACoNkMCBoVRTEzeifDLQBn/MLrk/XjaOPpK2UaVYi7rSCkGABclaWNeuH6Qse11WwjnwNI3IB2DR6isOgDlr9K3rtJllomtWiCEjbJRABTPd+XOU1vgvxXc/O/3d+ZS1BJLAVj1C58l9jC7PJ+Vjde8RUEBN41uemdkOfYfKDDfR/2M7Uvwm/BKg938TOVTbDy5zKYaoniHwJ5hLWXzds7Dj/gErPaLthP0PWwHIkjEdBucfLuTHI2lQt5efKWDCqZ2jH/kg+skepwXR+hjNuudstFhvB9UlahpGAEyLmuV/VvMpj69+BQo0dUW/dAHUbj5FcJ/YQ3wAS9OY2cQlS4wHk8TTGghpbLSk/oYS5ml8PbR+IoDQKlrSAIzGtIcrlirY7MSma+X+nByoW0DvRl2IovGCouL0+7atzF9vwwee+a/PvPrAW25aRYK+/JfPXevfPQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(14060799003)(35042699022)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ugP5FNu7tuQSOB5HFZrXl0GnsbaYyUzFFNkofghSTQpIUh04MtG+hGstLaHPLnTJcByDilz1Jn1+LioWJFnBGaKUULbE/dfQAYy2vXUMnYpxcWUbzQaxp+vXqjsuVMA6nL797q+xLvkxIEf9t9oRmkRfno7ZIIJrKmP8L4xTBjEFdjho/nT6bSSgDGIy6u7lgurs4T1Rd4MvKoOMIqsXs/6VcUFQS0mvhd+F8S2LuGwGxtbY7F6f8gKhlOg6l+6MsDDrOiVGoxUhh50RfXrF9QNv+om85zrEGVjUfsOEjWYljyaIdSy2LOqnG+8smoFYbrdR+jkSG3Vvh1l0JOLHN81ZOaqJCySNQIvIs2TA0MtAae06JTbFmH/WXXqYvfECKpX6JekiRPJKIokzMkB+UiJ+IIUZdxi+FVr0ySERw8LbPgfxWq3jpvaN+1cweBRW
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 12:09:56.4385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c322eabf-0bbd-442b-e5af-08de88d51932
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E6.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6330
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



On 23/03/2026 12:58, Sverdlin, Alexander (SI B PRO TI EAC CCP) wrote:
> Hi Chencheng,
> 
> On Mon, 2026-03-23 at 12:05 +0100, Chencheng Zhang wrote:
>> When formatting the TFTP options (tsize, blksize, windowsize), the
>> code previously used sprintf() with embedded null bytes (%c). Because
>> sprintf() returns the length excluding the terminating null byte,
>> subsequent sprintf() calls overwrote the required null separators.
> 
> I'm not convinced, the analysis explains the observed effect,
> 
>> This caused the options to be concatenated into a single malformed
>> string (e.g., "tsize0blksize1468") which breaks strict TFTP servers
>                      ^^
> ... as missing 0 byte between 'e' and '0' is not even at the end...
> 
>> like atftpd, causing them to reply with empty packets or drop the
>> connection.
>>
>> Fix this by explicitly using strcpy() for the option names and manually
>> advancing the pointer to ensure the null bytes are preserved.
>>
>> Signed-off-by: Chencheng Zhang <charles.cc.zhang@gmail.com>
>> ---
>>  net/tftp.c | 33 +++++++++++++++++++++------------
>>  1 file changed, 21 insertions(+), 12 deletions(-)
>>
>> diff --git a/net/tftp.c b/net/tftp.c
>> index 5f2e0a2bc06..5a8094791ab 100644
>> --- a/net/tftp.c
>> +++ b/net/tftp.c
>> @@ -355,20 +355,29 @@ static void tftp_send(void)
>>  		debug("send option \"timeout %s\"\n", (char *)pkt);
>>  		pkt += strlen((char *)pkt) + 1;
>>  #ifdef CONFIG_TFTP_TSIZE
>> -		pkt += sprintf((char *)pkt, "tsize%c%u%c",
>                                                  ^^^
> ... of this format string.

+1, and NACK. The original code is perfectly fine assuming a compliant
snprintf() implementation.

> 
> Are you using USE_TINY_PRINTF or not?
> Do you test with commit 1bc125becaa5 ("tiny-printf: emit \0 as %c")?


Nice hint :)

Thanks,
-- 
Jerome

>> -				0, net_boot_file_size, 0);
>> +		/* Write "tsize" + \0 */
>> +		strcpy((char *)pkt, "tsize");
>> +		pkt += 6; /* 5 chars + 1 null */
>> +
>> +		/* Write the value + \0 */
>> +		pkt += sprintf((char *)pkt, "%u", net_boot_file_size) + 1;
>>  #endif
>> -		/* try for more effic. blk size */
>> -		pkt += sprintf((char *)pkt, "blksize%c%d%c",
>> -				0, tftp_block_size_option, 0);
>>  
>> -		/* try for more effic. window size.
>> -		 * Implemented only for tftp get.
>> -		 * Don't bother sending if it's 1
>> -		 */
>> -		if (tftp_state == STATE_SEND_RRQ && tftp_window_size_option > 1)
>> -			pkt += sprintf((char *)pkt, "windowsize%c%d%c",
>> -					0, tftp_window_size_option, 0);
>> +		/* Write "blksize" + \0 */
>> +		strcpy((char *)pkt, "blksize");
>> +		pkt += 8; /* 7 chars + 1 null */
>> +
>> +		/* Write the value + \0 */
>> +		pkt += sprintf((char *)pkt, "%d", tftp_block_size_option) + 1;
>> +
>> +		if (tftp_state == STATE_SEND_RRQ && tftp_window_size_option > 1) {
>> +			/* Write "windowsize" + \0 */
>> +			strcpy((char *)pkt, "windowsize");
>> +			pkt += 11; /* 10 chars + 1 null */
>> +
>> +			/* Write the value + \0 */
>> +			pkt += sprintf((char *)pkt, "%d", tftp_window_size_option) + 1;
>> +		}
>>  		len = pkt - xp;
>>  		break;
>>  
> 

