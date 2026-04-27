Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F62AFF8864
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 08:09:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8336283693;
	Mon, 27 Apr 2026 10:09:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="mz0KZRpM";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="mz0KZRpM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EF55839D9; Mon, 27 Apr 2026 10:09:40 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0333C80433
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 10:09:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=g5wmeBPZiZTZtw1pv71eO41I5HgxvABZ17dmstHw2aTGF8d3bZEKiTEdAVqH+1otmR9OWebSJAod7rUdF5tzoYQPweLrbC94bo9VDWAymWhd8G9wcaEM0qDLGYoHW3uJGpsoK5zh0dLtUneJGwLPslYRIcWgCF6LRnq68MaCEzFw4+Va1kYZIsYdsovoqYDkRc8VZU51ErCM7b0qaWGsRRlkY2ei+1Zs8q7B6fKYEEhl8GDcpqQPjfod4ahUAQAQfPyo7reUCFvWqvVYoBJfpwmPXlvuGkbhnxdQeUSjQF5Q/2xFFMSS7eFujdQNbIhYVzWii5S7jdnq96qRfQuaGw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3U5Yu7zw3N+ibzIxMabNgwUD70TmbiboWdHO2PnRTd8=;
 b=Y2UjAk/fieb8UX1/nDPG7VzTSdKjvt8KHIymSV7LaVsPe4L7MgjlKmW95ZmrLE0yYOc4lK90X//GYOAjAZEOaOikdNSCrS4AzViZqd4pfhqPaCmYQH6ICK6cK4i+9GbqVW4tHAITvAFSnO/4B/I09BBq+as4UJ2k2pq8Vm55IJFXORTkSutoBoLC7r8fF6+Ab0gnoYbZ/XVZYQg2hhNVQ2n2UBxE5W3ly9lzw7jJkAZuml4uVTgJdyK3wLlTXftzbXEU76P/2OUe81GHAE5cYfpjQvlpukGmLmf04AAfYfYUEt8B0wM6t+mCcD0LQAtxvG0DABYU05JhVwtBGdwi/w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=saramena.us smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3U5Yu7zw3N+ibzIxMabNgwUD70TmbiboWdHO2PnRTd8=;
 b=mz0KZRpMcJ3spqXr1tJJ3bo4/YoQqZLvdLahmcDNDi5ZPfT/bzVQwjZ/JBkWksTK1BdFTjIE0CJSp6HFNmcFqBE0Xpok1pHXHKPxsdpyKs8+cFESTdSBxPoKcNS3GNn6/uDDPn6lvrnJOHCCnoB5I9iEN5nPwwfWD6TBADoHLFY=
Received: from CWXP123CA0001.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:73::13)
 by AS2PR08MB10207.eurprd08.prod.outlook.com (2603:10a6:20b:647::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 08:09:25 +0000
Received: from AM3PEPF0000A78F.eurprd04.prod.outlook.com
 (2603:10a6:401:73:cafe::2c) by CWXP123CA0001.outlook.office365.com
 (2603:10a6:401:73::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 08:09:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF0000A78F.mail.protection.outlook.com (10.167.16.118) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Mon, 27 Apr 2026 08:09:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=brZZ433aqLDeNaqBhQc7sh7JbT948vAIO3j2sPgO0LkiNM2ojvqRngrype61MvYC0WrBse1zH/MwgCCSesVmHW8bHCixQOb6JL2xiHKeda+MmQSlpKJFCcQaLWequte5xPDstn6HHf9OYF8UaD71Ynmk8jh/Uu9Lgjj52HLJqEjzFMm3KlV+hMPtezzquvafVhKd5eNsTkZlrFiSw7KHzhvIvtrI5oLfy/pqTaagTbrUfH9CoDCN4BmpUvMQW9FDZbFaGJn2/CMKBvoGfPM5NeuZ2jpcBMUa1Qb1GD/Dn96NNYOKUkhLerjGv6kvhGhWYRjiGUS2p3gGpnurnIcPYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3U5Yu7zw3N+ibzIxMabNgwUD70TmbiboWdHO2PnRTd8=;
 b=bNiTwHoXZExB3EWiWbDCXq8t30JOcU9zn8xnylVGbh0fMb8ZrpEaS/4Sni56oWNNdnvIQsU1WFT1b+FP8LfzmwPvTimAywcuyCmHK2mTUoMbLaMLp7zIrviZNpPLMdUB/N6Crn4E9WzoY3aFPvCIS7Kq3g8Qjj3JdTKIEDa9xhyaLZNf87w9ICdEHqKYrcCdwLWcIBGkZpJpqHMKSxBdBhOPonhYyK8ji8J0sLIEfi8KndNuM1JSzXM/gykaX1S2wy0yk5phHa8GEY+B71EFJRvylJGsEOjxiLQGH53mo1GYkJv8u7CGwJa8MKPDmOJcNJswyQOWQnQETSZfvPQA2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3U5Yu7zw3N+ibzIxMabNgwUD70TmbiboWdHO2PnRTd8=;
 b=mz0KZRpMcJ3spqXr1tJJ3bo4/YoQqZLvdLahmcDNDi5ZPfT/bzVQwjZ/JBkWksTK1BdFTjIE0CJSp6HFNmcFqBE0Xpok1pHXHKPxsdpyKs8+cFESTdSBxPoKcNS3GNn6/uDDPn6lvrnJOHCCnoB5I9iEN5nPwwfWD6TBADoHLFY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AM8PR08MB6468.eurprd08.prod.outlook.com
 (2603:10a6:20b:360::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 08:08:22 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 08:08:21 +0000
Message-ID: <0e52c8f8-774f-4df1-9543-f4dd6680fa90@arm.com>
Date: Mon, 27 Apr 2026 10:08:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: nfs: fix buffer overflow in nfs_readlink_reply()
To: Murtaza <murtaza@saramena.us>
Cc: u-boot@lists.denx.de, trini@konsulko.com, andrew.goodbody@linaro.org,
 nd@arm.com, Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
References: <20260407213231.19133-1-murtaza@saramena.us>
 <CAOqbjtvN_s1xjXgr1eGKq=VVtJAamSTiC=1aw5O_xTfaKEw8RA@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <CAOqbjtvN_s1xjXgr1eGKq=VVtJAamSTiC=1aw5O_xTfaKEw8RA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0102.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:348::7) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AM8PR08MB6468:EE_|AM3PEPF0000A78F:EE_|AS2PR08MB10207:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c3f0b50-1c8c-438c-f853-08dea4344bb3
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info-Original: aCNRAx+XdKtwPut8Pwl9EQI5S9ugSYZ4dJ1vyc5iuQuGbx2FIAOa3VfVNxXg9DgI2bNwuS1D1dckX5Xc/Q+7Tbhb1M6fs7nXGfNsklUd3VZfQzK2FNlBVIVpdSDMgKNF21cO2omoAYO6Um6i2WZgFBpn6QbhmGCDx32w8aF5wihGj3y9eiDUHb/kFO/yEULFwBLTuXgNEBoc7LySgy5Lkvh9BhrgaSON/yl/6rNr+p7a00+QFcJBpjB4BUDWTuE7LyoXz7uCnUgVkTirV947Z4GxCNhLRzrYDKqUtyMxR1ZA9IM/PHlzPjQwKiE99K5LTF0fAUhF3ESTzUtpbgvNyAvfuw5h+54em90aBxhAo0FE77DuYil2vNbG87N51Umn6H7O3wGZbEH7SNfB4GR4BdVl6kVGjsVtZGETpmA/d2GTfwcIz0XzW5GgVKkxau4abK+E4TX+QMUqlmo/UYeTWs1SOb8NKOAaLbheRPpXxVhqHB9yRM4TZKlMTpKill4TrAmGYzrfwDwjoaM5x+5cToskWjthV9b9xQticCa/KM6ZjsUZaWI2wcwL2ljS7JiX9cqQyfYeFTWjOLpj32gAP668yYrgOLm6dkjMsrWn7JqNB11cH63Bl9ucalK2GiotmLsxT9MWpZGKFcJ+j0LsoFEF8fFhndX0dTxSvTfVGsbWmPaBNJfavGRCdW4qgaQV+DMy8DqXjVTabhSNv/gLSZa8cZTanZXR/jN+ser31Rn/kFVLO4rPXwhEvaZSQWVg
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: r2u2rBUMdIJdwqjeh3IJ9dWOMM8K4a4ZrocCt5zT+zH0Uruwx8LPZhvUbidBYzQTFB0nr0NnM4B8zfV2p4msNu2cty/OMYPf4DwFNWxUcq7XADBomKRnZRbyZh2E2KEmUGsL6NwWkihETlTxNkhjyFcojEVvHmPpkRfPvDNciVXZ3XaBIAeMQ1wQ2SVcAehxSrD+qIYTexZlLjigKH/jkiJ94MTYGoqG1mljXkAiXyYhEE5desxfX7oLJr83wUPcahUo3lwdFFkBLSZdh9kH765zs/0itUaut1dXedFTluYwEs0B4v62HIeszY8zn2ajsZ8uWHfjEvir7wOIZmD25g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6468
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF0000A78F.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2afd8a20-9097-4905-5199-08dea43425c8
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|14060799003|35042699022|376014|36860700016|13003099007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: o9yXh6xFCk9g7qfK9gwpeCP5bmw0cmob8VhFQ42d9Ase4u3zE7AMVvgRqxcjuQevmjqDcZpLWV/RRN6NKAbyAveSR7PmOXLAUyrop8p5r0qGE5nZgwVaX0bnD0Mm7SfNgBtfWLrRu5W5kJls1yxfo3F37gew/uZkBS0IYQF/rrCQwwCH1irKScfhl+Nuet5blVcqOwir/vmXEoL3sIMYJc+QDD6mim3uGS4NFOlpros26y7j7jqtRWJWTjpwfbPjGBIV8x3M/Nn3uApDIgYtRVQl8e05ylUwSI8edymUA1C3QYsiHZ/UBylun7/S1g3nM7qoIFC6Hg1Kxs3jzdSYKwH5as94GgLghqf94xNuyt3ZVYgU4T0nwfXXsg/b89LWvuxxwTMKFQ3F2vF+vGziOuZpoLfWS5e4q5Gn4ftNHfm6NcSH+ahKy7632mldrqxKz+NsPHaB62x5Ut5mqb9FMvPbbNdKjjhE5qVAfYqyuIUeWfVjIzgseHVywwEecy472JJhslVLNhYeWppCIagDL9Atp8LXMm0+5nm0vaDkZK5haLpfYrYEwP30oUiAKOtClF66vmTeFN3ELN5sHtLHG/DG2thvnU5jZFTvKOqVTR3KqzARlCNhYAWFLxTkEWjl3hi31ZyhFSG2BOO/B0M7moZFQIg1FCyGRIsn93LkZgUBP3kfMfoac/1bM5cSZP3mOk++eeMqwkYhhhD+QxJ3IMRINb3L5DKPGGDTI8e6x7Uc4ZxAiCMA1QI5S+kIMgpEoWrRTbtdOdFLj7S/S0WRVg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(14060799003)(35042699022)(376014)(36860700016)(13003099007)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3izOgF+QmzcMhIgy7ptvGyNk+UwJUxVQraGGrTY8YUgc89Kh1K49xGWTz7ScWUrQUaKcK7eb4EufeqBdGIQLva9qCOMZIx6pTgRl7i+dBhaZen05Ya9qhWhVtgmDXXCkutlokvKdBObo77P32Kp4oUAqmE5x4vSb1jAUWyVg29665WelbgJqmOw70Cz+5U1WAKkk8LDsMamKCzzlYxRBuFPtpI+Wzr7hAXAbmfCLhqy7XPy6SL+aqroJtXupnSMYMlFLgYNmhRq0q4kZCknj5uYsFlER83Vfukjh223VtZkHZxukBJZmg7cNDDGwd8opdLDjrYqhHkzCZI3DUimDt/PdyRSImpPfPgblPBpJp5QHp+yXBaAOLTGqHWR7w+XcuEz+0iiSsTfTQZCv3bgoX+dw0AwNfS7HLcDbppRdZ38lJRRnIyf3QUl6OC4xC21G
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 08:09:24.7585 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c3f0b50-1c8c-438c-f853-08dea4344bb3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A78F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10207
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

Hi Murtaza,

On 26/04/2026 05:51, Murtaza wrote:
> Hi
> 
> Any updates here?
> 
> Thanks!
> 
> On Tue, Apr 7, 2026 at 2:32 PM Murtaza Munaim <murtaza@saramena.us <mailto:murtaza@saramena.us>> wrote:
> 
>     nfs_readlink_reply() copies the symlink target from an NFS READLINK
>     response into the global nfs_path_buff[2048] using a length (rlen)
>     obtained from the RPC reply. The existing bounds check validates that
>     rlen fits within the RPC packet, but does not check that the result
>     fits in the destination buffer.
> 
>     When processing relative symlinks, the target is appended to the
>     existing path. By chaining two symlink resolutions, a malicious NFS
>     server can cause the combined path to exceed 2048 bytes, overflowing
>     nfs_path_buff and corrupting adjacent global variables (nfs_path,
>     nfs_filename, nfs_download_state, file handles). This can be
>     exploited to achieve remote code execution during NFS boot.
> 
>     Add bounds checks against sizeof(nfs_path_buff) before both the
>     relative (append) and absolute (replace) memcpy operations.
> 
>     Signed-off-by: Murtaza Munaim <murtaza@saramena.us <mailto:murtaza@saramena.us>>
>     ---
>      net/nfs-common.c | 12 +++++++++++-
>      1 file changed, 11 insertions(+), 1 deletion(-)

This looks like a duplicate of https://patchwork.ozlabs.org/project/uboot/patch/20260409164440.323405-1-sebasjosue84@gmail.com/
(with a different return code and with error messages).

Thanks,
-- 
Jerome

>     diff --git a/net/nfs-common.c b/net/nfs-common.c
>     index 4fbde67a760..30f549f9e1b 100644
>     --- a/net/nfs-common.c
>     +++ b/net/nfs-common.c
>     @@ -671,14 +671,24 @@ static int nfs_readlink_reply(uchar *pkt, unsigned int len)
> 
>             if (*((char *)&rpc_pkt.u.reply.data[2 + nfsv3_data_offset]) != '/') {
>                     int pathlen;
>     +               int new_len;
> 
>                     strcat(nfs_path, "/");
>                     pathlen = strlen(nfs_path);
>     +               new_len = pathlen + rlen;
>     +               if (new_len >= sizeof(nfs_path_buff)) {
>     +                       printf("NFS: symlink too long (%d bytes)\n", new_len);
>     +                       return -NFS_RPC_ERR;
>     +               }
>                     memcpy(nfs_path + pathlen,
>                            (uchar *)&rpc_pkt.u.reply.data[2 + nfsv3_data_offset],
>                            rlen);
>     -               nfs_path[pathlen + rlen] = 0;
>     +               nfs_path[new_len] = 0;
>             } else {
>     +               if (rlen >= sizeof(nfs_path_buff)) {
>     +                       printf("NFS: symlink too long (%d bytes)\n", rlen);
>     +                       return -NFS_RPC_ERR;
>     +               }
>                     memcpy(nfs_path,
>                            (uchar *)&rpc_pkt.u.reply.data[2 + nfsv3_data_offset],
>                            rlen);
>     -- 
>     2.50.1 (Apple Git-155)
> 

