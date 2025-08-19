Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF19ECA0EED
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 10:34:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E945980FA1;
	Tue, 19 Aug 2025 12:34:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="uJGTL+g+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1300A80FA1; Tue, 19 Aug 2025 12:34:51 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0DD7802C1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 12:34:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mx/I4gaybx/qrv3/lvOtYAWErtahbkbAN63sVZTCa7LeRRequ3DP8wPLHfaO01ORlEvPaPznKmlpoNWa42cj0h1XeWA2piO90qrm1qBVbzM5wnct+h1C0wDKrj/3XbOEVraHl7S0GToWmDKNVq/IkSKEwQFVtDrQa93nkqbssAqxYIFaT8Rcwh5qFZJ1et0G5BVrz+4Bug/O6q0JKOtHWC7ttFm7Vi4KeZPz3CTLp0AjetIfAwgLQ0uKT+/dKaQboir7bsyubMG3FtBY7CsZHcUKDis6LQhw4QnlzQk2L8ZudqOwr0Rhgsl9DFqnlX1+Zeg0xtLIlpYbe1LifKRNXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=176d2dwNv/mCktXu4jWYdGWHWYTWO1rkPpx4w8MHDBE=;
 b=iqe1nOGod3Ex2Viqk+WbSkwM2fOzBmLtw5Y+ac09vyhQSUs2ycwXqptQJIRkIGPqKF7OYiFc8AXumIaS3sYRhB7uURapZuhc2O2hJznT0bh2z1NXODPd0kskxc9yBvu7LBqXuoRtilo8bRR4swewWfYNYumqnKQCB7TqSdrxXEGBD+8ZN6VvLSUWCGXOT9MymKC4ZsFsWVFf87zIK2AI3SYQmd2NJ06TOU5cLtghImXFh6mMkOEOWAyLhGKyrbKjRAE0iWZM4KNHnthCSWn46doai3s1lbIY9b/k3y4+E7erCKRtgLS4RlgUTuCUN+OfBWKBTSbjEf3BRSM4oJI9Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=176d2dwNv/mCktXu4jWYdGWHWYTWO1rkPpx4w8MHDBE=;
 b=uJGTL+g+o+NT7VSD7SFBIdxpC66HEjBsui3oT+iwxK4MjngG3GGdCA3pKYBD3MhIcSe1Q5QEO7n0sUX1SfCIi+b1WKYb3rFaC7HvyasyuqtXGthjEktLsz3FXtRskvdNNlrkWfblPeFILHrGTyEvnonMdxGqEJuV5fNAfaSUVRDIFExayqyH0oGc0uapSEruiCID/HtZqPFEoDCqlSnzXQrr/8VSIKuaN0a0k0hY31C4c/Ht5v3Pq6MYviXD24xF1yrnAudnqjETjlpl8zl2n9U51EKp+gmfxJH7pOTBig7AasCdJW3ebinkYJhiUkspN5/J3JdyTqm9meCjp+YXFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI1PR08MB10073.eurprd08.prod.outlook.com (2603:10a6:800:1bc::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 10:34:44 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Tue, 19 Aug 2025
 10:34:44 +0000
Message-ID: <8b7bcbd2-4c66-4e2d-b169-c79eb7081f2b@iopsys.eu>
Date: Tue, 19 Aug 2025 13:34:41 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 19/21] mtd: spinand: propagate spinand_wait() errors
 from spinand_write_page()
To: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Gabor Juhos <j4g8y7@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>
References: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-20-mikhail.kshevetskiy@iopsys.eu>
 <d4e3714d-d687-427d-8136-5388694603ec@kontron.de>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <d4e3714d-d687-427d-8136-5388694603ec@kontron.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HE1PR0102CA0022.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::35) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI1PR08MB10073:EE_
X-MS-Office365-Filtering-Correlation-Id: 60e5bb73-fea5-410c-242d-08dddf0c0327
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OFB1VXlMVE1mdnZyVGQ2UExuUytVMnVJZE5EbUVhM1VYL0NHOHdna014cTZZ?=
 =?utf-8?B?UitvcklGbzlDK0d6RW1Jb0ZvSTMrcHk4eEpxc0x1T2hFcEZJVHVmQUpuYkJx?=
 =?utf-8?B?bktKNWFZeVREYWNWL1U1TzRvNWZ5VUNwVUpqUGE2QkNYdVNYRmY1d3ZuYXda?=
 =?utf-8?B?cWVqWnpGRHE2aW5yNGVTdm1FY2NZZEM3bFU4dFpqcXBETjV2bTh6Z09Lb2Vx?=
 =?utf-8?B?R1ZVSE5NZnFXeFBDUkNWRStrS3JESnBXTHlwRDlaV1pEMTZDZFY5SDg1bGZB?=
 =?utf-8?B?TlVOZWVPQy9UZHkxUURsbU1ZRER5Q2ZSQ3I2MjR6OVFTQS9URS9qalYwSUVu?=
 =?utf-8?B?WXpyS2JTVGdNeVhVK2tXaTVhckxNSUhzUjFMMnJtdXFOMWphQWc2UU5UVys4?=
 =?utf-8?B?a3JUTGhBYXg0cEUxVmNyWXllZ0lndUtGQWlEbmJMczQ0VW93dEFYK2FKdTFn?=
 =?utf-8?B?UFM1ZDl1czVmR2dxc25LYWluSHRLL1BIblJPNW9TbjZ6OUdvRzQ2b21CVEpT?=
 =?utf-8?B?YkRBYWY0RGJBb0lWY3NMcHBZeHNyb0RENDJ1ZDdZR0VpUnp3WjN6alFNQUdF?=
 =?utf-8?B?cUhMSGpWOXVacUdjRldSN3BqMU9YUVowb2hlOEFHRnNlVk5hbHJvWWpYVWNp?=
 =?utf-8?B?czIrTGVkT0xnSXBPTGNnZ0o0bVA2S0MxOEhRYXVpVTZxWUszakpLa2gyTTBX?=
 =?utf-8?B?ckF2ZzQ1U3FiaTFTRWZsazl4Q1NJZXQvcjBZTHZ4Y253ai9KODEvNFJGUW5a?=
 =?utf-8?B?eWlMQUxYcVh6NkE3cFozM1dpY09jSFhoRlJlZlZLd29nZTlJQXhuZHpZZDd1?=
 =?utf-8?B?aWRIalRRR1BjMEhmVm90Y1lLd1hRUWZnQkRiQTBMSElDeTRFZTRQTndadlgr?=
 =?utf-8?B?OFBRTlBjc3hxcEl6T1RiOXVGeXZWR1BBQ0pOb1BMamJsbGl1MkpKMkg5Zmp6?=
 =?utf-8?B?OFl0bkpIdndmUlJVaElzdU8xdDlJaEhSc3JnZGdwRFAzWnN0dmFZcjE5S05y?=
 =?utf-8?B?MDRpUEplWjB0TlI3NHd2R3A5SlNHRUJLcTU5ODJKWjNCbmdtUlhPSFZsNStM?=
 =?utf-8?B?cDV2VzNOaVI4R2w5N2k5aHF0OEU5VTg3TTg1STAyYXBDMnpaMm1NUUJYN0p4?=
 =?utf-8?B?eUxqUlF2NnRuRFIvNkdvcitNNVZKTGhXaG1GY0d1ZFFkN2hJOWRHajJDRTdk?=
 =?utf-8?B?MUFTV0NGcTNNNjhPRGlXcURseEFVWVFoelBmSy9RSGFOZ3N2RllVMkcyd0lC?=
 =?utf-8?B?bGQ3T2hmTE5qL2IrS3o2TVNGZXpqNDh5eDFHTTZ4bEhacjk5MXpmaEVKTGhS?=
 =?utf-8?B?TEIyckQvcjVHajBNcWNDTE5kRTk2d3V6a3lYenJJbi83MFhsUEtabzZ0SVcz?=
 =?utf-8?B?SDN6cFhJN3VWOTQvdlMxZVVWN05wL1JVNXNVU0hIU2RiVzkrK1UzMElMS3VQ?=
 =?utf-8?B?dG5ZOTdORWdPL2RzY2J2UWxBTUVVUWZZSHl5WGczM2ExdXp2NUw2YWUxaHB5?=
 =?utf-8?B?L1MwSEpZSUM4MVYvU3dRdFVhVzFMOXR3NlF0TFlrcmE4UEhjYTdkQTRlQUQ4?=
 =?utf-8?B?Si9oS3BUNmIvQ0t5aExOU25jdWRwOGJmZTU0RXR2dHZQU1ZCaHU3NURaN253?=
 =?utf-8?B?R2ZJZlZiZ3ZoWXdsaWpMK3ByUTdVREtMeWdFTHlRb3ZyQm5WNy83K09QMitX?=
 =?utf-8?B?OHQreEdNWVlYNC9IZ3oxanVTeGpldGowSXRRSDJrL1ZMNWV4Sms3YWdWckgr?=
 =?utf-8?B?aXJDdWNLTmxhYzVmSFBSU2t3OEl1bjh3T1Z3Qk5VUVR5SFEvS24rayt5cDk1?=
 =?utf-8?B?V2lCYVllZm1Vam5QWFJhcmV1aTZoOG4rOHF4T01XVm5MVXJDWXFyTFdpTDR2?=
 =?utf-8?B?L0ZlWkR2clQyOEtWMmV2KzZOaiszTXlSMXRVU0M1T3dnclpMNXRGcWxFckht?=
 =?utf-8?B?elZMd1RuUW40WUFxaVkwSW80L3FBUlJlUHA4UENYTlpVLytZRlgrT2hxVzgy?=
 =?utf-8?B?YnNoU0ZhNWl3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020); DIR:OUT; SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVN1cDQrL0pGMFMyK0loeVNoenY3YThpWGVEb3dNNnlhYXhTMStEWkV1bW81?=
 =?utf-8?B?WUsvUUxlaFZwd244cWRIeEJ6N1kvbHVhaVFsdjE3VlZyQWRURWVaNjk1VWNK?=
 =?utf-8?B?WnNUVHpvU1I2YkVEaTgyb213VnVMeUdUc3hvaXFKY2pISHp3bW5XZUhaRlJI?=
 =?utf-8?B?RkJwT3Y2NytuYW1zR1JkSG5KVU1mdXlKOW42VE1uMEpob3MxYUxFTnB4Y1NT?=
 =?utf-8?B?ak5HQjNON2NEVmM4bnhqU0pJMm01cGtPdWRVZXBrS3lxZm1RaXllRVdaY2pG?=
 =?utf-8?B?VkVJUlNmaXRub0RZOHFuVUhYbXZ4ZmlYcGFLenFWYTJjNkhtWUlsNElEckxQ?=
 =?utf-8?B?SDJ6Mk0wVU9tYU85a1FOYjFPT0hmSi84VXgyMGs3c014Tm11c3YxekpsWENh?=
 =?utf-8?B?VENMN3EyTlNqSHVvaVNRUmFTalhoTnRiNWxGWFg4ZXF1ZXFleHpSNm9iN1Zp?=
 =?utf-8?B?MDNPUjRvK0tHOEJSU3BBZ2E5UmhvU0l6dll2ZkdTbS9SUHBwbnlaTHU3c1Nu?=
 =?utf-8?B?dm1IS09iRWg5ZzY4YURDQ0Y0U0VUbmFqNDZMSUVETUhuTHR2Q21xVXc1R213?=
 =?utf-8?B?Wkl1eWptRVFaWkZJUzBibTF3cURrNUpEV1NhckEvNWVSRUE5UForVHpLM2VP?=
 =?utf-8?B?YkJMUnhMdUNZTEE1cGdoNXIvTFBNbDZxNHBjNzd1RStqREJ0T1MxUkExU0VI?=
 =?utf-8?B?VURwamtqU0JDRktCMkF0R3hNYTlPNC9ZRGdYMzkvWmhzRGpRMzYvREhlOUQ3?=
 =?utf-8?B?T3ROdEpheHlWY0svanNMWkdxTk9BNXluT1VPVjd2YUFSTmtJTWZGNm9sa3cw?=
 =?utf-8?B?dDBibDRRODlMM3lZY29nMC9RZktpazBGRkpqdm1ObWw0MTdqOE5nT09NM09C?=
 =?utf-8?B?NFhCQk55ZnBOMEcrV3VybDMxSkJsVFFBU0g4KzYxaHJNeXVyd2xxVy9OWEMv?=
 =?utf-8?B?MVhPN0l5SWE1ZFA1dDJaT0FVZjd2Nkw5TnF1ejE1RDVIcWZPTURSckF6Umtp?=
 =?utf-8?B?cU5WcDNHWFQxdmNRMW5aU0YrYkFMcEhjOW93ZS9jcVA3YkF3ZGFPWlkvRW1j?=
 =?utf-8?B?YjZqQVAxbUVmSFJzMXhkLzFrZkV1S0FCQm8yUmFIVFZTalJySDBCTFJVOWw0?=
 =?utf-8?B?QlpDQm53aEpSbWNNYXpOZlRycExIb2o2SjhZZENldzMzMHhSTitabW5OMUJS?=
 =?utf-8?B?L29oUXU2TWxtcE1TMTNOOTI5cmFNUUdSYzdFSjlkQ2RJRk1lZitFRzl2dmtC?=
 =?utf-8?B?VytIY2F4eFFkVDNRSU9hR3QxaHJkMlZQSDFqdE5jQVV1elFKRzgyYmFLejRv?=
 =?utf-8?B?M3JXem1iMDVxOVU1QlllZmFHZkhSSHZDVVBQMUxLSFFZTzNMTUs1ZXpwV2hJ?=
 =?utf-8?B?aWVJZkNMM2xqbDBGejNRN2NrOVpUM2VMZ1VXKzhuOHgvTUVVVTJkdDFEVjlZ?=
 =?utf-8?B?dnFoU2FJZVVKd2lSTUVtZ1RTZys4dlhjN29HVVBMbXZjQW1tNE5iZEZrbXJS?=
 =?utf-8?B?WUZTZno0MnFkamtCTEhCNWY1d2hnb2pFUll0cFVQK2gyQ3lobWIzNEkxMGQv?=
 =?utf-8?B?ZkEwWElyb0VSWU1qNld3a2ZITmkvOEQ3dDZSZTkwU1hTWDlZT0hERzM1YkRI?=
 =?utf-8?B?TDNmSDY2cnM1bC9OaFlURWZjOE9sT2VWeWtlSDJCRTlaaTU4RisxQm5OUy8r?=
 =?utf-8?B?OEJhZ1ZzYUV2SVUwZzk0V0Z3UmFlMEdmczJwME1uekw2SGhVeHMvTGFkSlNT?=
 =?utf-8?B?eU5sb1BaNnhzRGdvVjE5UnF3S3N6dmIwc0lhVzF2bUJSRVdLalczZnRnYUdv?=
 =?utf-8?B?WVBORStkSDNpZlVabGVBRkIvdExlREJHNjhDZUJaaWpnRWF2OSswWTh6R0Fi?=
 =?utf-8?B?T0JyWXVlWGtxaXRKbG9HTndRNWJhb2NvUDlOSkVkeW9vSjhuTVBMcHBuU1dS?=
 =?utf-8?B?VXIxb2szTHJ0TldJeU1RSS9OSFg1ZTVqS0NNZXNpTmVISk9xQ1RCeTExMkF4?=
 =?utf-8?B?b3dEaVRKUkg5RmNmMFBrM1J4SnZJZUFVaGc2cDhldW9oYm1IT0tBc3RxL1hW?=
 =?utf-8?B?SlJmc2hEUTcxODZiRHRITnJtS2lCN0kxZVg2eXdZak1KTXlRV0lVUkYrcWFY?=
 =?utf-8?B?cDNrMkE3akthVEduWkVhWFU5cmw4N1FRckZRRWM4d3ZlcUpEemJhc0VqN1pK?=
 =?utf-8?B?eHc9PQ==?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e5bb73-fea5-410c-242d-08dddf0c0327
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 10:34:44.4210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fctxyzloKySW3pXhEAMUtIvtiL/DMCQPZY9D+AD9YTKUYZis03HhCHQ95z4cS+p9hr1BOm90Z5iyxbu9lI9xcYHj8kRiten+rH9gw1DKqUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10073
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


On 19.08.2025 10:26, Frieder Schrempf wrote:
> Am 18.08.25 um 12:06 schrieb Mikhail Kshevetskiy:
>> From: Gabor Juhos <j4g8y7@gmail.com>
>>
>> Since commit 3d1f08b032dc ("mtd: spinand: Use the external ECC engine
>> logic") the spinand_write_page() function ignores the errors returned
>> by spinand_wait(). Change the code to propagate those up to the stack
>> as it was done before the offending change.
>>
>> This is a port of linux commit
>> 091d9e35b85b ("mtd: spinand: propagate spinand_wait() errors from spinand_write_page()")
>>
>> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu> # U-Boot port
> This seems to be a fix for a change that was introduced in patch 10 of
> this series. We should avoid introducing regressions and fixing them in
> a later patch to preserve bisectability.

Hm, this a bit contradict with removing fixes for continuous mode. In
linux, continuous mode makes some flashes (mostly macronix) almost
unusable on some platforms.

There are 2 possible bug scenarios
1) "continuous mode" flash and spi controller without dirmap support,
but with restriction on transfer length in adjust_op_size()
2) "continuous mode" flash and spi controller with dirmap support for a
single flash page

In the first case all reading above restriction in  adjust_op_size()
will lead to EIO error
In the second case all reading above flash page size will lead to EIO
error or spinand driver fooling (because spi driver returns wrong number
of bytes was read).

The second case looks as less critical, because u-boot up to this patch
series have no spinand dirmap support, so no one need to support dirmap
in the corresponding spi controllers.

>
> Can you please fold this change into patch 10?
>
>> ---
>>  drivers/mtd/nand/spi/core.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
>> index daf6efb87d8..3e21a06dd0f 100644
>> --- a/drivers/mtd/nand/spi/core.c
>> +++ b/drivers/mtd/nand/spi/core.c
>> @@ -691,7 +691,10 @@ int spinand_write_page(struct spinand_device *spinand,
>>  			   SPINAND_WRITE_INITIAL_DELAY_US,
>>  			   SPINAND_WRITE_POLL_DELAY_US,
>>  			   &status);
>> -	if (!ret && (status & STATUS_PROG_FAILED))
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (status & STATUS_PROG_FAILED)
>>  		return -EIO;
>>  
>>  	return spinand_ondie_ecc_finish_io_req(nand, (struct nand_page_io_req *)req);
