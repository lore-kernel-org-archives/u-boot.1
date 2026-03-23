Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC3C0D58B00
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 15:58:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 268448408D;
	Mon, 23 Mar 2026 16:58:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="iwBk+fLX";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="iwBk+fLX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 265C78410D; Mon, 23 Mar 2026 16:58:32 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BF1B8406D
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 16:58:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=uiZPF3Ne3Ocl3+6HHet9HVmf9UF7jMzqYYodTumVboscepL8jDDOWAz6bsOoY7egbbq+zdeba0g1OIpPHzDHxcpEBV/3hPHyRAMnWLj8cMEPcko8SmuLSEvCh93HuIX6KVMaRM0gCuzx5d84ayJDp/kDdAmBNIoBeLeRDVF84zr457mpQE2WbpWauphc+m5dZFaZNBf/1fyQ/AvvC+AWdfTdvCZRYKJARhSWFC46G6l2emkTQ/9uehOeJZiLYCZj9i7t/k/cCZm8HteyUdcUiyecwsywLo1ucizhG6XgjmqUG5c7h1X/Rwaid9mDT6Ni99LGJNQEpD3N4AGS/Gc6sw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvGu6ZMbs3a/iBFp8Mq7IcI2xAUVpYAX2RT/+NAHQbo=;
 b=dwAigXyOlNTtHUnk0ySE+MGaGTIp+bRzqL8q9xmu2VfXze7XtH0DoNOeefI4PgkpAtysUe+xnCUplXFINqnVudjIhNZH9w14jj5MKkhkEwK95wypuvPnjGDxtKvphh3wNHBvwZu9fotr5xj0CvoolcQ0f+XWHoQwGA2yzMozxRrBBuonG+SAPVLeckx2t9+Rg1cjZzZA13YO7AmEIWNVoaMufu/fReFzDlTqwV5Cbjm1aCpWwkpZc/s8oiRFUsDrb8HmA3vwSjGKvI/863Lu1RtgKX4Ig7mr23VADbmhEpXEIzIL9u+tWQew95pCNj8WAPq+shGyMf+/ua7Y+hovZQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvGu6ZMbs3a/iBFp8Mq7IcI2xAUVpYAX2RT/+NAHQbo=;
 b=iwBk+fLXE+YmspALy5S+ntg8sWjEDRwTtMgJdyVRFlGj+9NulGzQhbfQ6SfQJI6S0VT4ahUqxjl5j21ZwA7t7d/xVEMWZiuwRAjdLHsN+7dRmpGW3p/TEK710xik9DAmTtT/kT1KoiC9gocUFWhjgtmQwRImK2n5opZg7AUcDG8=
Received: from DB8P191CA0024.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::34)
 by DBAPR08MB5752.eurprd08.prod.outlook.com (2603:10a6:10:1ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.20; Mon, 23 Mar
 2026 15:58:22 +0000
Received: from DU2PEPF00028CFC.eurprd03.prod.outlook.com
 (2603:10a6:10:130:cafe::f1) by DB8P191CA0024.outlook.office365.com
 (2603:10a6:10:130::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.26 via Frontend Transport; Mon,
 23 Mar 2026 15:58:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028CFC.mail.protection.outlook.com (10.167.242.180) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19
 via Frontend Transport; Mon, 23 Mar 2026 15:58:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pxrFD42JsAGWT7pDF3ezm+BrQz3d1Ej3+/Br1LmPvaryhUQoKsoBVkUNNYjOR05gCoHMNZ6G982I+SDVzaXLqI19BdGQaI65FfOFx6v3XOdOAaC07dCa41Rk175wLUKan//4nT4MRTqfRQsRUg/zOHmdi+N18jxGaDqTVJ3b52GkgYwP3cpKDp/mQxM4yH66OxjlGUWOpXgcdyBBIVJitxNYTJRgxsLRiOR5StHG8Wq51xWxGI/Y9qVBQx6ovkPDk948JYWwOI7ma56VJOitw8tYRdCVZ19ep8ZHruh8ZJI8R3OdgV8+HX4Xsc3vxz+HQjzD6cb73xbzVsjJYkWJmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvGu6ZMbs3a/iBFp8Mq7IcI2xAUVpYAX2RT/+NAHQbo=;
 b=KGqsSjWMrnJoprUbfCvifl+95CC1KHY4/4/8a5hAnkGqLEQwCaZek3LdI7xqb6kxcTZugLn4AzJX57LZjcIwDctFVMKLWYXw1wd8TLiuhmFtgIxuvSsfZHAOzN5r2mTp3eoW0PJxPSsw0TDNAxaJvVc6LPLNhtOo7IIhkNDWKpfV9jfjWz82Mo8/BPvr7tK8/gznxlN42u28sFvmC5jVsyEWJgtLvNMO/9S1wep94AaKMFLS06sfuDP2V3+XmEjFFA/EN/IAMhajxDqDeksYUI8b+36t1KWWGWpyth5k2qxdM4Xxi4dbyA2/M9d5JQVfh/M8dn3kJxsfcBI3UEOqkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvGu6ZMbs3a/iBFp8Mq7IcI2xAUVpYAX2RT/+NAHQbo=;
 b=iwBk+fLXE+YmspALy5S+ntg8sWjEDRwTtMgJdyVRFlGj+9NulGzQhbfQ6SfQJI6S0VT4ahUqxjl5j21ZwA7t7d/xVEMWZiuwRAjdLHsN+7dRmpGW3p/TEK710xik9DAmTtT/kT1KoiC9gocUFWhjgtmQwRImK2n5opZg7AUcDG8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by GVXPR08MB7896.eurprd08.prod.outlook.com
 (2603:10a6:150:16::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 15:57:14 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 15:57:14 +0000
Message-ID: <882ee8d3-f777-40e6-9c0d-2af1b664b5e4@arm.com>
Date: Mon, 23 Mar 2026 16:57:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: tftp: fix malformed option string parsing
To: Chencheng Zhang <charles.cc.zhang@gmail.com>
Cc: "Sverdlin, Alexander (SI B PRO TI EAC CCP)"
 <alexander.sverdlin@siemens.com>, "y.moog@phytec.de" <y.moog@phytec.de>,
 "alvin@pqrs.dk" <alvin@pqrs.dk>, "trini@konsulko.com" <trini@konsulko.com>,
 "l.anderweit@phytec.de" <l.anderweit@phytec.de>,
 "quentin.schulz@cherry.de" <quentin.schulz@cherry.de>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, nd@arm.com
References: <20260323110516.84423-1-charles.cc.zhang@gmail.com>
 <63086c74fc1885ded988325e3a3e474310919493.camel@siemens.com>
 <be0a3106-69ca-43f3-86de-0fd018e96e22@arm.com>
 <CAB08KXL5hBrbXS91SrJy22Ca7ZTPzb7D+3V0stVNvNibOoT=nQ@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <CAB08KXL5hBrbXS91SrJy22Ca7ZTPzb7D+3V0stVNvNibOoT=nQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0035.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19f::22) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|GVXPR08MB7896:EE_|DU2PEPF00028CFC:EE_|DBAPR08MB5752:EE_
X-MS-Office365-Filtering-Correlation-Id: 1504e4ac-4594-4249-7010-08de88f50270
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original: fmny/VUbUHIPRGng+kSzRsQtuqis51PeUclAjCT5iErjd137IoIJYdUUaRmBERVFmWsTbYMHXPkQx1zwJdHynrfC3r1iz9fEbHpvcmrMVT/+wXidUBDGD9RLzK7b1WMhES6Pa/SDNzfHNqZ2F2Y/bCb/ocFccP1IDkWPSoqOHm2p+MkJjYgXEiKIYVLQh1FQigIjFcMsL265iXgmJUb1WUWSYxBqFA/I3cBGU4dd65q4ipRHQ3C9/orvwimbhAxYkk7fhxzpSKj/CeSk4SxW3oWLfAXhIphax0Y/vDvIteKtAOJVFQ3Vp6FukCYYKU9sLZi/F25VSUx5qgup8SIHdYF/FDsnWKvRs9GYPRYuntGVeyQi6Hw3+x1CzSxbYGmx4ZPQT8mJMWTTRjmffDAVZLgIjrddHUNzbcYnrUd8U0Pr58rAYSat97HqSAqJhVwItlo3xiw516Yd3/oZo3cKedcEoBhvWM2zPxLOe3cejaCECu+go9bkWXowE51RlU3cMozU7SxyXBiH6PLKm+QTtQHtFhbh1a2TK+nG4Pd4cn0O4eimscWtPMnixx7W8mnE6BpJBkz+g82p0Z8bxsulNbAw7JUE8w6+PZjqYjSQAc5PRX6euT8hifeBocqkswIDXX7uU9XQjoEp30kz0AN6bFKK17oz8l3KCroGAj3OkZGlkAv7t1QshKkECK0BfkdWpASQ9ruvAQVAJ67gXQvWhv4QrQ2PX6YGI/9hi9M8mPA=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: QnXo02yJa9v8zwAz5Puk8eBpWiPr2pC6Tl3F553W93Uv5ZQ9yfqPL5s92k52IuAZGa1jQ32cCCdMddhU11yLp2EocAuiMhdtnH/Z1ovBu33iL3USXlZ8voimW/Bo+lA41KfbPBqPA6yUvmAwyfjqorYPmYwg6nyU6iKjv7IBmiFK2JSqncuj/JEcyZSxnXitl3mVpu2HGPUTrDraCA8l0Efm9b0GTIx/FiMAXYkUidLbIiDAxJim1fwMShCOGwROhBo06ENFx+PWPI8csXyT/PKzgphquFnW6pgSVDmxp9diMDzz7+ybbxR/9gMIDRjsT0xSCAFYjucM1SYR32NCmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7896
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028CFC.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 90c480e6-61f5-4146-1de9-08de88f4d9f6
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|14060799003|36860700016|35042699022|7053199007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: tM1NQZ9n9PzRDhg9PzA7XRvYealz3hbB9ZUFnATiA516Tz3BYisv3bZFJYZwRIIyZs0uEufEyLHiIal5KmLmjalsT6KfwbEshBKVenSvxQ5ulIrgD23isJbJ1ovK6gWvmhkLr2VHCxuq+pC8WFPvGaK47GJSpiRxUGYWO6G552dzzetHcW9f1qug7MMYorg5UbQVLHr5EWQ61V6li6/QWggHXJhs5+NYgtb7NuIoRnUXI8FlbjDI/iLphxmrE5D4HBjV/p3yjmX0Iap9Ek/0Sc77BFLDbBzqqc6xoAGSDC7EYzc/n0YdKJT6uI3JPA/ArxxwyXcgHO6I6+O8t2yivH/UqMM9UAJanW+1ZZjsLtKSkYm+RaOW/7GPrf9S2svUhEI2tdwZXWMKdIlNz+LAQbCwWoAvoB1B8thqdvk97ZbcDlKMyn2LJ9QwWkcH8tRBQWEvoMKLjzcqO24kyxOMDR+UXhOGnKtaIaIFMzqXczxJIEAZbS2bls0JwBFsERJxQNPsTnumsFfg980NcyJf9+UA747HHu8oDRzn/pvco/bas9574T+cAlcTfxgfMO/8MFV/87H4HaJGdyLZrnsD/S75XSAzz74Jl0Bt2f/deklls+JoxnUWXlVWuKWc6Aj7T+I+DQC5WNLQfuzffsE+SpiRIoO6H2zBd1ZsSAYFiASJ/OclO83AyEUo1MmURXxEvfK/O5Lu+iEPF7vOpreiMWxJl8VzJfd90lQoPNXcfJsVp//AfdDHHJ2nKSNpc7xxTe5qFO6TXMNAPKxkRGwIgQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(14060799003)(36860700016)(35042699022)(7053199007)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8GLObYIsriFEJF2mI+N4YB1wsuMQIWN9ArAS06O/lIXt3ibhk3ASkDK7WHdDmsZA9f0RGq9/0D1oewhSJrqnubVoBfpNjvFLU6En7wBgR7xbbZS67B+mwzBETVHKqrir9FCjrGkVssc4NOHmXAZRj1ABCw7qo4nRPSfQhSZGie207yyF5ZF5ZPmHla77b8zEG7bhg77eGV6CqSUpwEhee6/hlDGA5TIXEo+ef0DmxOE6kibJGUnyPAjfkLjo23AIMwPYolm9tGIdHdD0WtgxRR7m6jheBoiWpZqIBcrfala7c4vdv//l8bzj+6e1KdfzRgGzcoXor1hr1yXZ3JVzzTvPxNyBF/LmZ54cGgvYPrEQuILWTRi7D+dGMumrL94DZwW6gsjyUTDDIAudLvjsSwaRvSkBlzip+2KHnJGwd4TnKh7sITRgaqqlNJWtG63N
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 15:58:22.1392 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1504e4ac-4594-4249-7010-08de88f50270
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028CFC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5752
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



On 23/03/2026 14:51, Chencheng Zhang wrote:
> Hi Sverdin and Jerome,
> 
>> Do you test with commit 1bc125becaa5 ("tiny-printf: emit \0 as %c")?
> Thanks for pointing that out!
> I have checked my baseline which is TI u-boot v2025-01. Clearly 1bc125becaa5 is not included. I patched my baseline with 1bc125becaa5 and it works.
> 
> You can reject my patch.

OK. Thanks for contributing nevertheless.

-- 
Jerome

> BR/Chencheng
> 
> On Mon, 23 Mar 2026 at 13:10, Jerome Forissier <jerome.forissier@arm.com <mailto:jerome.forissier@arm.com>> wrote:
> 
> 
> 
>     On 23/03/2026 12:58, Sverdlin, Alexander (SI B PRO TI EAC CCP) wrote:
>     > Hi Chencheng,
>     >
>     > On Mon, 2026-03-23 at 12:05 +0100, Chencheng Zhang wrote:
>     >> When formatting the TFTP options (tsize, blksize, windowsize), the
>     >> code previously used sprintf() with embedded null bytes (%c). Because
>     >> sprintf() returns the length excluding the terminating null byte,
>     >> subsequent sprintf() calls overwrote the required null separators.
>     >
>     > I'm not convinced, the analysis explains the observed effect,
>     >
>     >> This caused the options to be concatenated into a single malformed
>     >> string (e.g., "tsize0blksize1468") which breaks strict TFTP servers
>     >                      ^^
>     > ... as missing 0 byte between 'e' and '0' is not even at the end...
>     >
>     >> like atftpd, causing them to reply with empty packets or drop the
>     >> connection.
>     >>
>     >> Fix this by explicitly using strcpy() for the option names and manually
>     >> advancing the pointer to ensure the null bytes are preserved.
>     >>
>     >> Signed-off-by: Chencheng Zhang <charles.cc.zhang@gmail.com <mailto:charles.cc.zhang@gmail.com>>
>     >> ---
>     >>  net/tftp.c | 33 +++++++++++++++++++++------------
>     >>  1 file changed, 21 insertions(+), 12 deletions(-)
>     >>
>     >> diff --git a/net/tftp.c b/net/tftp.c
>     >> index 5f2e0a2bc06..5a8094791ab 100644
>     >> --- a/net/tftp.c
>     >> +++ b/net/tftp.c
>     >> @@ -355,20 +355,29 @@ static void tftp_send(void)
>     >>              debug("send option \"timeout %s\"\n", (char *)pkt);
>     >>              pkt += strlen((char *)pkt) + 1;
>     >>  #ifdef CONFIG_TFTP_TSIZE
>     >> -            pkt += sprintf((char *)pkt, "tsize%c%u%c",
>     >                                                  ^^^
>     > ... of this format string.
> 
>     +1, and NACK. The original code is perfectly fine assuming a compliant
>     snprintf() implementation.
> 
>     >
>     > Are you using USE_TINY_PRINTF or not?
>     > Do you test with commit 1bc125becaa5 ("tiny-printf: emit \0 as %c")?
> 
> 
>     Nice hint :)
> 
>     Thanks,
>     -- 
>     Jerome
> 
>     >> -                            0, net_boot_file_size, 0);
>     >> +            /* Write "tsize" + \0 */
>     >> +            strcpy((char *)pkt, "tsize");
>     >> +            pkt += 6; /* 5 chars + 1 null */
>     >> +
>     >> +            /* Write the value + \0 */
>     >> +            pkt += sprintf((char *)pkt, "%u", net_boot_file_size) + 1;
>     >>  #endif
>     >> -            /* try for more effic. blk size */
>     >> -            pkt += sprintf((char *)pkt, "blksize%c%d%c",
>     >> -                            0, tftp_block_size_option, 0);
>     >> 
>     >> -            /* try for more effic. window size.
>     >> -             * Implemented only for tftp get.
>     >> -             * Don't bother sending if it's 1
>     >> -             */
>     >> -            if (tftp_state == STATE_SEND_RRQ && tftp_window_size_option > 1)
>     >> -                    pkt += sprintf((char *)pkt, "windowsize%c%d%c",
>     >> -                                    0, tftp_window_size_option, 0);
>     >> +            /* Write "blksize" + \0 */
>     >> +            strcpy((char *)pkt, "blksize");
>     >> +            pkt += 8; /* 7 chars + 1 null */
>     >> +
>     >> +            /* Write the value + \0 */
>     >> +            pkt += sprintf((char *)pkt, "%d", tftp_block_size_option) + 1;
>     >> +
>     >> +            if (tftp_state == STATE_SEND_RRQ && tftp_window_size_option > 1) {
>     >> +                    /* Write "windowsize" + \0 */
>     >> +                    strcpy((char *)pkt, "windowsize");
>     >> +                    pkt += 11; /* 10 chars + 1 null */
>     >> +
>     >> +                    /* Write the value + \0 */
>     >> +                    pkt += sprintf((char *)pkt, "%d", tftp_window_size_option) + 1;
>     >> +            }
>     >>              len = pkt - xp;
>     >>              break;
>     >> 
>     >
> 

