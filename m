Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351D1E936F9
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 04:18:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07BA186CC5;
	Thu,  5 Oct 2023 06:18:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="LJmer0H6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E78E386D0E; Thu,  5 Oct 2023 06:18:14 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::613])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1E5F86B75
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 06:18:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YS2Z8Vy7YuPgZJr5XwQAB8PJH0cpvUb0yxJy6ZTCf4PDxIXODywpHQzKFg5zG7Je3yoi3PyjJH72/FdZTi5jNkDNBRktlGvrXttGIV9zJ0I32TBvIiQtOzd6E3hBo7HCN0DrVn6wJ8latfeFfwp87jTsB6vhPTXPjNfa41jhQzq3qs+ZAJUVg6eMFj8GStYgF1eM5klbIIpeWgbIvxUv7kKBDrip4oIhhEsOE3PMpqabWSTO55ywsCjo+QvOSlTmzFN4wndXE09emLTGBj1NMYgkqYeZWlcgNOmFD98UAp9WWP//4vmFCKIGBniRCGzYYjEqdOBywz5jr7DvVIvPgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtxpDIco4iq0wS4rL06Crd0VHeCUT0CN16+d3zTsXM4=;
 b=ODpCjQF80RE8AE7WVWLs9TMu0HTy2XKmGMXL8+DWtixVaLgRM1lK8Amn0i56djJuE1OFJ50kLSGzowElBBvWvyR7kMHgcvVKUjmdaeJQgIc+xM1Wf8Pctlf7PMSvcMGdJgc/6eq1AqTOG81JW/sB/zpxBGKwa8q4Yudg9LrH+CBELhhTARVlPTmD/eLPUmz5nJzVPOqnyIZbzdBa7XY4mfpnE+v/G8aQOOohn5tUFEmbB/1t1tAoRNti85RiCHuucQ+69xkmsy7RvmSS+r/UGAIPbLGTjT3Km7GUBmCeBdKk4Kwae3T/+MeWhTwH6NTwR7woKj5JLqT3Ir+Rj3EVLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtxpDIco4iq0wS4rL06Crd0VHeCUT0CN16+d3zTsXM4=;
 b=LJmer0H6kGGEdchESaDC4iwulSdBA8N5AL1xacfKoLucG7Vowba4CdSIU04K2HJK7Y5k+WzSv6jeLukNS88STfxPoBdHulv47bIpP/+eH8VppOV3ixDA5qENrtWrWFKadVwQatUFL5WSEis3/hm8TN/5fPAjK4RT+nukJK9UoZg1wgSs6DEOKd9+X0wB5hJJ4pq6gnF2nx4Yt2/tInp4evIVEzqX1bI99kRv9fqzODfejctHWKpT8ceiElRV1S8RDMaRZrl+YX2KXRlVPoL91IHHt84ALIXareW+ICHXoUQ+62chqKeyhodyP4K+ILHio1+eqI+WsJXDGf96x84zMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB4000.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Thu, 5 Oct
 2023 04:18:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 04:18:11 +0000
Message-ID: <2f55c3f5-7867-4db1-a0cb-7bc6f78ba044@siemens.com>
Date: Thu, 5 Oct 2023 06:18:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: k3-am625-beagleplay: Fix boot
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>
Cc: Roger Quadros <rogerq@kernel.org>, trini@konsulko.com, vigneshr@ti.com,
 m-chawdhry@ti.com, sjg@chromium.org, jonas@kwiboo.se, srk@ti.com,
 afd@ti.com, bb@ti.com, praneeth@ti.com, u-boot@lists.denx.de
References: <20230929134646.214781-1-rogerq@kernel.org>
 <c430c549-6c6d-4d32-a51b-e2bfa597bd4a@siemens.com>
 <20231004121546.uvvqcbewyt5s6kdx@extrude>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231004121546.uvvqcbewyt5s6kdx@extrude>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0160.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB4000:EE_
X-MS-Office365-Filtering-Correlation-Id: a6e97c80-f0d4-4d69-ce26-08dbc55a15ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3c2kCutkMmUjvMIldLlCQiM0Emmdalbct0Mke/Wq78lNWkfulbEATQhEOjS+9GdJWXrGsh/I1Hv2b9XnE6U4VwjPQnPaWjkJBnZ5hfKg8DKzq2bstVeDkbLaSWk0DCA22FBQo7LiOC9Myh5GJrd/1FkmTxpmS9pDU72KxGJVwM0AipeHm06nvqz7IK3NIIJvyHGNXtdLvsddbZ+5/Xw1dtUk/4W60HZhVRnYhzNUhQzU5Un4RqU3pQrVsRdIKJvdOwTNyQj06+xKA1TmTjLcjEEOGi/oWho9Uh6QCMZiZ1vVUBZP1hp8o1GKQ4CXyJdmOKLhCKDWsuy25bFUSVWgoqQ4zrQm1fZ7PGFw68Le4lqPLuzw6SF70PCaZZSmBrxf7/2SjJgWv2yaVGI7CnH3VmubEAuUktnIHj90FnWJ2o8YrwGV+AvT5dGK4z+VlMr2qpMWskBBInoqCPWemz12AZwy4qGSqENuRaEtN4kMivHF2ktVmjD33ravRT8u29rUWr+3nXiukIKMrNEZjt/Pgn/BjH5rWH01PjAnbPVif/wmrhLAtc6yglqGNXt9x3WhTRczV+cvYJNxlD+I1M+gATbKmgj4US28Wy+D+d2pC6lzQDjyR7JgyXJgS/MwjVZ0LGal81ArCTNgFHbPfPjEYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(396003)(376002)(366004)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(53546011)(6666004)(6512007)(6506007)(966005)(6486002)(478600001)(26005)(8676002)(44832011)(5660300002)(7416002)(316002)(2906002)(6916009)(41300700001)(66556008)(66476007)(66946007)(4326008)(8936002)(36756003)(38100700002)(82960400001)(86362001)(31696002)(2616005)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alBSN2tyYUcxbTY1b0pPcHg3UnptQzFEUXcyQmZCN2VrNGZJMUlyRWRWSmM4?=
 =?utf-8?B?QU15YUs1UVlmT1Y2WlUySngxbGVEOXNyRGpiVnBGQ0VOQ0RKallrdFgwdVE2?=
 =?utf-8?B?NHZOOEdkQ1ptUXJObk5JbnVLbnFGa3hBaGZuMXk3ZVNIUUdKWHNlUnBxWkJq?=
 =?utf-8?B?YmRnaG5rZHRKMm1OWU9tcEFLSTdVV2VsbE9qZWdaTldOdVRuVzZObFlzNmkw?=
 =?utf-8?B?TzVWNmRuSEFjUGI5YmxjeEJmK3lONVpZMElOUU5VSnRBdlM1NnEySWVlRW5i?=
 =?utf-8?B?b0NUQzRpWlkrUHJKc1RLRGszMXYvaW9nd3VpdW9EV1hJa2E0enpmQ1U2NFI2?=
 =?utf-8?B?RDNEK2FjSmtYWEYvR3hwYXk0aHFhVHJ2NDRkd1E5V21iSFRVUkI0cm0yTUdn?=
 =?utf-8?B?OG1ZWjN3UXg2NkRqOVJwN0c0UFU2UU5SVUZSV00vZ2NDU1ZiSGNhTU0rb0ta?=
 =?utf-8?B?VG9Jd3FNT1BvV3RJcWZzL2N3bHBIQklnanNBZWh3eVlza0hsNlgvQ2Y0MHNq?=
 =?utf-8?B?SisySFJKK0h6aU4yVFBRZmVaa1V5YUxnWFBUaGRrSG04YkJXYzVsM09BdnNy?=
 =?utf-8?B?SWFUVEdZVHlJYW1WMWtQQWZWR1hlSnN1VkR4eUlZTWxSU0hERkVVRFVWUDZM?=
 =?utf-8?B?dmhINU5saVpWRmFtMHRENUNHNll3SzFOY0txZk11bnB1eHUxdE90ekNWTGVX?=
 =?utf-8?B?TUI4T3BIWG54ZVhCQ1BQZ2dCdUY1S3FuN3htdHFMdEZPMGJYTnVvNkFCcWp5?=
 =?utf-8?B?MUZYY3pmVXRXRndoZWdXUVRCTHdIWWlUOElHTVdFSkNuMzk2VDJPQzFydDhi?=
 =?utf-8?B?dTVQWkVmREd5MDFMU0VYYzhOQlpmSFk5U09Wenh2M05uRmJsa014bG5oQ1Zr?=
 =?utf-8?B?VVdBWlQ0UW5WMlI3YkFCbXY0bStzaG1hazM0dVowTWNNTXkrdnlsdGJaQ0pK?=
 =?utf-8?B?RlMwMzdudzZpcE1TL2hiVzViNGRDcmdtdy9HUmZEcjczQThSeUFteEJBVGlT?=
 =?utf-8?B?aTFNTGhKUG1tVU45ekl5cm1FcXdzSXk5TXVLTkdoQ3E4dktuTTlEQ0VGYXI1?=
 =?utf-8?B?SzM2VDNMblg5cHg0SUFpSW93RnpvTDFWZkpTTjduUmZjaWVQL1JXTk5oU0xy?=
 =?utf-8?B?N3BHczdCQ2NHWVRCVEJ6NE5YcGxCUnBoZ0tKSWVUYUhpK2VSMStLWXpZTUM5?=
 =?utf-8?B?R1RoODAvNjFvVWhpRWxwMk96bUt4cGNBcEpzS0xXbWhPcjVWaHdDUWxiT3Fm?=
 =?utf-8?B?NFBYUjYrWW5YL1pnVE9SQWhRMHBNVHVGaWRKUVB4V1p4OXNVTmdUdnZsZlcx?=
 =?utf-8?B?eVNWaWEvdmFNWjFZUjNEUU5BWFdGcVVWUWY4dHA0cmVaQkpDdkphSmpqYi8x?=
 =?utf-8?B?T0dpOU5WQ3IwdU43elIrUFFQalJLOGduYW9mYXdrbTgyZzhFTy9rVFB4YTh5?=
 =?utf-8?B?bUVtczBaOE9nazhhR04rNEEyejBaRitRYStlcGE3ZVg5ZEVmY3hxTWROVWVq?=
 =?utf-8?B?Y3ZLekJQa3FTL1dBUE1lakpFL2thWnVDaHo2aVRDSEk2WXoxaW5oeGN1NFVJ?=
 =?utf-8?B?OFpGVjhyRW9OY3d1WmxXUk9iRlZCaDdscEVhUHFycUJod05mY3djWmJTcks4?=
 =?utf-8?B?MFJoUmxNTTZhMTVFbXZqTEdxZFpnb21rZnBMOTFWcEFWVTVITkpZcjJ3TTVR?=
 =?utf-8?B?b3Y3VmM4aGdVazRwZmw0eWtud0NYR0xBZUhwbDRWaHQ3RkZUbXZUelpnV0tI?=
 =?utf-8?B?N2F6Q29scGNEZXZ3djNUMnhRbjkwTWVCeDRheUUwdDBDNU9zc1JOdmJHV3l1?=
 =?utf-8?B?VGlOdEJ6RGxyc2YvSU83MU51c3diVnMrN3hsTmRtTDhUUjc0aWhORi9rNWtv?=
 =?utf-8?B?SHhBUGFzVmFWUlJhWDU2WHd5MzRkUnFqaVlncWtsUnF4SWgvR21sTGtsOGVN?=
 =?utf-8?B?VGxKek9mWnM0U3FkajFDSXpiVXZCRGJnK1doMDNCQmhMVnJBYk5paSt4QmYw?=
 =?utf-8?B?UVJ3SkFLcUp2UXViT3RPdnUybFROTzM2TGMxNFArcER4dk5Cdm9KY3FEU3BL?=
 =?utf-8?B?TUlqY3VUT0dtZGFWNzZuWmNDMzd0K3JlWEY1Myt4NlRZak1qeXpreG9mSWdh?=
 =?utf-8?B?K0czYks3d1FvaGZTaVg1b2ZTMEI4RGVKS0J3NVoxQ1dHckJEVk0rWVBKdCtW?=
 =?utf-8?B?ckE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e97c80-f0d4-4d69-ce26-08dbc55a15ed
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 04:18:11.2326 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ImmTyzVCR360Vd3D55bnpkbuwJEsJQTxgpC9dPX9N/YIS0h0gFwRoIOWs0xsraot+VEmn8Dt1dc4Zd4NKKO5yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4000
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

On 04.10.23 14:15, Nishanth Menon wrote:
> On 22:26-20231003, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Since commit [1] A53 u-boot proper is broken. This is because nodes
>> marked as 'bootph-pre-ram' are not available at u-boot proper before
>> relocation.
>>
>> To fix this we mark all nodes as 'bootph-all'.
>>
>> [1] 9e644284ab812 ("dm: core: Report bootph-pre-ram/sram node as pre-reloc after relocation")
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>
>> This may overshoot, but at least the board boots again. Could it be that 
>> [1] broke even more boards?
> 
> Jan: https://lore.kernel.org/all/b1c62a7d-a90e-4212-8972-9b622e147975@kernel.org/
> 
> I got boot without r5-beagleplay.dts modified. and it is in line with
> the changes in linux-next commit 944adefc7f88 ("arm64: dts: ti:
> k3-am625-beagleplay: Add boot phase tags marking")
> 

Yeah, no problem, missed that.

Meanwhile, I can fix our IOT2050 because I was unfortunatenly right:
more havoc in sight. Did anyone tried to look at the fallouts
systematically already? Is it only affecting the TI family?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

