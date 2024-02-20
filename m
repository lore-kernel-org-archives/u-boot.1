Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A04FC48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 19:31:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACF6687FF7;
	Tue, 20 Feb 2024 20:31:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="jKXcsv/V";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seco.com header.i=@seco.com header.b="1N6vCp0T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E659487DA2; Tue, 20 Feb 2024 20:31:04 +0100 (CET)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0715.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::715])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9BBB87FF4
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 20:30:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=Q9VJLUNaaTXVWM9Ui82dnBhYhKMzCu697mmwBDX3f++3Cw82+k8jD4y3O0FU52gTeRIiGJjMefBp1CCJS/r2MfPNtjuKnvD6CDt7VxhJFaJduOkOz4fDI5Dd74itASPwJvfsWdUz1SMjOns4fRmL9Kbgayf9yf+ZUT2XetNXEgSVPC72fY1pLXWxEKUMyvymIWIR43SSxNwcs/LFVRy2ccuN4A4NxQOOW1U63eeYDfsQXiH3ykOJgsEIOM6IQJUjUQkwgUxj0eln3G0rqY957r8jWXgVCsIfiJP/wYgB25uQQ0JxBfbAenvoepLg5P4ssaYoX98HdMM4dvLG8DVl6A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFOdU8XRQaViwWQF2d1020zv0nKILkqd2LG57gwCK2I=;
 b=Cv5BWwFPuK3HonBbo7jb2mSnqMTyVtRQqurTxHlSqtp6+m4amvtuR85co6KDUkYlY6TV6YnKVG5IpXPnPC6hcfqeDUW8WrXzIddEh5eVI8zQDsOOt8V2B/cscRH9VF84cZ5hrHtuPRpcv3OhuoeCcG8tbifPPBio0L0PaAozlMqISnnshEw/PeOBUsVeWNMLIo5FQeOBzF7sUydlJtN+AWJh08HW3hCtCmETDAk5D37j3BdDzKZd/gkA8umLyhDqnqJ60qhHzNTgALaPm7jwHZODtL4W/kYJgfXAbmHfIcKZD8tKEeZTKC3pw4BuloaTn1vTIEyYd7lhYFkIcQEPOA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.84) smtp.rcpttodomain=amd.com smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFOdU8XRQaViwWQF2d1020zv0nKILkqd2LG57gwCK2I=;
 b=jKXcsv/V8wt+XvhBAYJmCqqUY4Pw4Jm6QGfC93NUXCB8WJNoYNjVaYuXZI7aldeFBDFY817eRhHgsn3jNOt5lYukb7YSKUbxDTz9tuHsn7UXmM5gt/Ed7om8hNaMhMW5JrgoRfz1uFvEHph2gaNWzrVR+sPykdfkMurwZElt3VhLdXTepV8Q4r9gCjXl1ndJDZf4X4UCi07yQj9506H6gA3NgZGa3C+JghnCtP3b33WTZdCZRGu/i0LMmECiGT2X4fKUh8lAZBWi+aLLlDXkylUE/VTGHq4Ljrtd2RcckwIkwfNbOH4XkGCINTbm01HLPRnK8LDaf+ylHs6QWnDEIA==
Received: from AS9PR06CA0228.eurprd06.prod.outlook.com (2603:10a6:20b:45e::20)
 by PR3PR03MB6668.eurprd03.prod.outlook.com (2603:10a6:102:5f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 19:30:56 +0000
Received: from AMS0EPF000001AB.eurprd05.prod.outlook.com
 (2603:10a6:20b:45e:cafe::bd) by AS9PR06CA0228.outlook.office365.com
 (2603:10a6:20b:45e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.41 via Frontend
 Transport; Tue, 20 Feb 2024 19:30:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.84)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.84 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.84; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.84) by
 AMS0EPF000001AB.mail.protection.outlook.com (10.167.16.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Tue, 20 Feb 2024 19:30:56 +0000
Received: from outmta (unknown [192.168.82.135])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 E5C1720080092; Tue, 20 Feb 2024 19:30:55 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (unknown
 [104.47.18.105])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 359222008006F; 
 Tue, 20 Feb 2024 19:30:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkitwyToY8jiqV1xoHwl+I0w2fhyucE/hFQZietg4BsBafWFufbGOpanYD/Zke+5z/NakfEN7yAhwFyaKlNTL20RVL32Dv2GchhXj9ZlRnQYSzUEfNgo8nieJnqS+2PidU2RfW3GbtYs/IXngZ0K1Yd852nf39vdcmita4JI0VAmkhXvQVGD8AO06UUaycwUQQswfSTn76PX1JFZ5UZ4Pv/qpSwq+oGVkpDqmmXYcp7VxCzt340PBBYnUXoG6diUFjtNCWG392P3QAX1BzTjoPY5tAMgBKk+NrotkYzgCyLSWmJMWANsvqBRjkhMFRqhx2k2ajQU2PoEHSmXjJ8laA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnYUstPhX2hZ8JF8Fzqy/mXqhtDkeOceamMTIN0tID8=;
 b=IRKxIR8pzPqtWAo1sgX6fnYnQELoBHU/g+na7mtOgrhaIaooj7ztDU80uKjFi+SQf+s+drLQZMTHcc6zhlmsVZo9xHX0edLIuGzkX25XqQ3ub9+DGrrcATc+B/noMIJT/zkvR5q+UxYhsPEWs7M9SM6IXmdWRyPRvSN1HdUur2NKt+44EPLAjKfSYiaOhx3EJz4aOFxk3W6+1lpzOR6xCLq9VcZBLYwoDPtGJM1rXdrrG9qSfyJPfGFeEVGKIeMPWRTwxq9QM2fNV39yHqymFqL4GX/91RN0+Sy7a4yCKjyE8XnOHC9BFV7r9PE2WBb/OOXmsp2aJCvf23CxqnQjDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnYUstPhX2hZ8JF8Fzqy/mXqhtDkeOceamMTIN0tID8=;
 b=1N6vCp0T5jqzkB36hKFA9N1FBz7Wm2WAJM/h9y3cLCmq9uu1RJy/qSP682rDbdqu2uSODfH8V6TutKePEdeUyZWyszXc3F8czOMC/YGyJqBMIA7FwkzMdOqUq9f3Dz9UjTL54oeUL9g1MVCpR2d1xoaz1ADxNWVJad0Taj4DSswbVGVVg3RwyfUlRLJ/HfzmwoTRcjGQNAd2PO6J9hEYbivWHn4QnXprBc6BNeWK7Sgt9y9zqJTEFUxbYTYI7P5ekrtYKiQ2Ys+EtrzF6ydGLLvIMn94mauiTu+nNuY9g/qRRnoTNwvBH2rQGA4ESUwQewFQ7Lx4/H7QX5hOdbtrgQ==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by DB9PR03MB7273.eurprd03.prod.outlook.com (2603:10a6:10:22f::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 19:30:49 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::9529:5f9c:1795:a94c]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::9529:5f9c:1795:a94c%7]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 19:30:49 +0000
Message-ID: <05c38e6d-e9bd-4bf2-a1a1-93ddc5c818c4@seco.com>
Date: Tue, 20 Feb 2024 14:30:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Support semhosting boot method
Content-Language: en-US
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
References: <20240215171918.3729508-1-sean.anderson@seco.com>
 <3f6a5971-a024-4eb2-bdba-76071fbd9bb2@amd.com>
 <e9fd399c-34e2-4c54-a74e-d1a3b84fbcdb@seco.com>
 <326f67f9-a6de-42e3-a2fb-9d649520557a@amd.com>
 <0ab35778-ae8a-4eb2-a021-ee8e3a9815be@amd.com>
 <4a2e8e89-36e3-4e58-9f14-2151fc907081@seco.com>
 <8561797f-3b77-44af-849b-faa555e244bf@seco.com>
 <5816ffd1-4105-49b9-8026-026a4195fa00@amd.com>
 <84443f0d-817c-42d8-a70f-f656e6ce79b9@seco.com>
 <769ad987-fdef-4edf-adf8-96f8acee63e3@amd.com>
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <769ad987-fdef-4edf-adf8-96f8acee63e3@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1PR13CA0293.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::28) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|DB9PR03MB7273:EE_|AMS0EPF000001AB:EE_|PR3PR03MB6668:EE_
X-MS-Office365-Filtering-Correlation-Id: ded711b2-57e2-4ff4-88e3-08dc324a7595
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: yE8LsWdI5ef+UxYXsZQh59hzJ3x99FcyY7VojN+5+m9WR60pknjLNypw6mBFXIBY1P8OHnsUDmLj4gm0KSdXU3ZFud7Pq/grM4W13lhUtjF17rxm1+NRJ2+wVhjxMtevhd2Bw65DdG4iJgmc30Vyro1AnrG/rIr08DF3Tr/RgQ7ZEuQp48Pa1gHcKzrWFJv+3YcT/7BdjEJZNCAOD7A/lpm67phdK4Bi3re3YrSY6Ak/RU2Gwvw7uCqtDlX7BhUBPtZ2LVVEKluajjq4hqt1UHiHQVuv+KzxcgY12gM96InHrkMcnUs4kstOWePJ2QLHnVwfkU74M1V4inf9DPE+DhwCrj+xgmXnGNp7PZlwSMqxmHKEorg4pjgbyrVBnFo9JcHI/7cmroJqJaBN8zvvRLDZzQVgj/zmHuwQHw24Ozk2UiiK4bx3kWE1N8S/06kqaj6XmfRzIYUPksoPGlUHcjIIeyjGJjcu2isneqkmaQz5OFZ/fAU6JJ5N5vwsK9zkjdq1AlW3HTNya2BK6L9vR2PuOidPurHbThbyM5CJ95/dXkZqX1iCVC7sgWpDFImGRZ+X7rVqnBfFBDX5OuyOusW5z2+uMc9oUaMT8a79kks=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB9PR03MB8847.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230031)(230273577357003)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7273
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF000001AB.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 36b461cb-d088-4271-11b3-08dc324a7174
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iMqVWV21jJyXGimKuo2rDLAInxFske/WxlsXr+JRAfc6OJPcs2Bnq+9rbg9paLYrhM471A9zzCUuw2oSjmZ6KXVLdoHDqsDqGWayWTmdyGQI4YaAMEnMFQCZNvJczWMQcIIp4jHWhqAl3ex+cNAeeRnxgfmsjQZxcjWFs9bXMy0loZ9zqgSghxCQm5Kib6FN1LaBjIlHnsX9cXjR/II6JXOpxasXTOIoEUMf1pO2RKjOhiqO3b2wYsIHXQmkpDVmrfofuQHN1Fq0WLdPg+ww5ufpOs62A1VR58yLy2gPtpYQYNVXdC1kj0em9e01jlNgB8+hzpz/kEmwRDKlbea8+jU25E5cdv4qwsbQcskln9adJJSAOiTsPYUOhKgbRJo7icRPCRj6bnDQ3a+pzsWfVP6HLo1QUdsm97SBFwVpIc3bZsKjoLa33+AUfSrX9THWAEwuL8DfXls/gJmBqwYZvcoYrMc8EapwbgMAOL+Cqm45YCvrWWTyI1/7rOdlOuBW7Ma+pZCdgpelsE8bEAc5nLIpmdBc7IL9pzy3B8b6cFSv++kFBCPrBWoKEC+tiUJiIjvpHDTq/9pwFDuSjxfA9yXwIAzXV9gVvgLzBlJ5rglZ5M+CIg6WtbqBh1yQ2sTO+Oln8G4JYzdv4Ncgphca5A==
X-Forefront-Antispam-Report: CIP:20.160.56.84; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230031)(230273577357003)(36860700004)(46966006)(40470700004); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 19:30:56.1001 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ded711b2-57e2-4ff4-88e3-08dc324a7595
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.84];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001AB.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR03MB6668
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

On 2/20/24 14:18, Michal Simek wrote:
>
>
> On 2/20/24 19:43, Sean Anderson wrote:
>> On 2/20/24 13:24, Michal Simek wrote:
>>>
>>>
>>> On 2/16/24 17:09, Sean Anderson wrote:
>>>> On 2/16/24 11:03, Sean Anderson wrote:
>>>>> On 2/16/24 10:06, Michal Simek wrote:
>>>>>>
>>>>>>
>>>>>> On 2/16/24 14:48, Michal Simek wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 2/15/24 20:31, Sean Anderson wrote:
>>>>>>>> On 2/15/24 14:08, Michal Simek wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 2/15/24 18:19, Sean Anderson wrote:
>>>>>>>>>> Currently, when we boot from JTAG we try to boot U-Boot from RAM=
.
>>>>>>>>>> However, this is a bit tricky to time, since the debugger has to=
 wait
>>>>>>>>>> for SPL to initialize RAM before it can load U-Boot. This can re=
sult in
>>>>>>>>>> long waits, since occasionally initializing RAM (and other thing=
s in
>>>>>>>>>> psu_init) takes a long time to complete and the debugger must wa=
it for
>>>>>>>>>> this worst case.
>>>>>>>>>>
>>>>>>>>>> Support semihosting if it is enabled, as it lets U-Boot tell the
>>>>>>>>>> debugger when we are ready for the image. This means we don't ha=
ve to
>>>>>>>>>> wait any more than necessary. We don't change the default config=
 to
>>>>>>>>>> ensure we don't break compatibility with existing debuggers that=
 don't
>>>>>>>>>> expect us to hit semihosting breakpoints.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>>>>>>>>>> ---
>>>>>>>>>>
>>>>>>>>>>      arch/arm/mach-zynqmp/spl.c | 10 ++++++++--
>>>>>>>>>>      1 file changed, 8 insertions(+), 2 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/arch/arm/mach-zynqmp/spl.c b/arch/arm/mach-zynqmp/s=
pl.c
>>>>>>>>>> index a0f35f36faa..5af735aa5ce 100644
>>>>>>>>>> --- a/arch/arm/mach-zynqmp/spl.c
>>>>>>>>>> +++ b/arch/arm/mach-zynqmp/spl.c
>>>>>>>>>> @@ -9,6 +9,7 @@
>>>>>>>>>>      #include <image.h>
>>>>>>>>>>      #include <init.h>
>>>>>>>>>>      #include <log.h>
>>>>>>>>>> +#include <semihosting.h>
>>>>>>>>>>      #include <spl.h>
>>>>>>>>>>      #include <linux/delay.h>
>>>>>>>>>>
>>>>>>>>>> @@ -66,6 +67,11 @@ void spl_board_init(void)
>>>>>>>>>>      }
>>>>>>>>>>      #endif
>>>>>>>>>>
>>>>>>>>>> +static u32 jtag_boot_device(void)
>>>>>>>>>> +{
>>>>>>>>>> +       return semihosting_enabled() ? BOOT_DEVICE_SMH : BOOT_DE=
VICE_RAM;
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>>      void board_boot_order(u32 *spl_boot_list)
>>>>>>>>>>      {
>>>>>>>>>>             spl_boot_list[0] =3D spl_boot_device();
>>>>>>>>>> @@ -75,7 +81,7 @@ void board_boot_order(u32 *spl_boot_list)
>>>>>>>>>>             if (spl_boot_list[0] =3D=3D BOOT_DEVICE_MMC2)
>>>>>>>>>>                     spl_boot_list[1] =3D BOOT_DEVICE_MMC1;
>>>>>>>>>>
>>>>>>>>>> -       spl_boot_list[2] =3D BOOT_DEVICE_RAM;
>>>>>>>>>> +       spl_boot_list[2] =3D jtag_boot_device();
>>>>>>>>>>      }
>>>>>>>>>>
>>>>>>>>>>      u32 spl_boot_device(void)
>>>>>>>>>> @@ -97,7 +103,7 @@ u32 spl_boot_device(void)
>>>>>>>>>>
>>>>>>>>>>             switch (bootmode) {
>>>>>>>>>>             case JTAG_MODE:
>>>>>>>>>> -               return BOOT_DEVICE_RAM;
>>>>>>>>>> +               return jtag_boot_device();
>>>>>>>>>>      #ifdef CONFIG_SPL_MMC
>>>>>>>>>>             case SD_MODE1:
>>>>>>>>>>             case SD1_LSHFT_MODE: /* not working on silicon v1 */
>>>>>>>>>
>>>>>>>>> Good timing. Can you please tell me how to test this? What's the =
setup?
>>>>>>>>> Which debugger are you using?
>>>>>>>>
>>>>>>>> I am using OpenOCD with the patches at https://cas5-0-urlprotect.t=
rendmicro.com:443/wis/clicktime/v1/query?url=3Dhttps%3a%2f%2freview.openocd=
.org%2fc%2fopenocd%2f%2b%2f8133&umid=3D6e1be473-0b3f-4bc4-a4f0-403592e74baf=
&auth=3Dd807158c60b7d2502abde8a2fc01f40662980862-afc15b07b0f91c910f83218595=
8363d84f990a08
>>>>>>>>
>>>>>>>
>>>>>>> I am trying it on the top of the latest git but getting issue with =
event block and no idea how to fix it.
>>>>>>>
>>>>>>> # sudo openocd -f /usr/local/share/openocd/scripts/interface/ftdi/d=
igilent_jtag_hs3.cfg -f /usr/local/share/openocd/scripts/target/xilinx_zynq=
mp.cfg
>>>>>>> Open On-Chip Debugger 0.12.0+dev-01509-g6d288937cb2d (2024-02-16-12=
:22)
>>>>>>> Licensed under GNU GPL v2
>>>>>>> For bug reports, read
>>>>>>>        https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v=
1/query?url=3Dhttp%3a%2f%2fopenocd.org%2fdoc%2fdoxygen%2fbugs.html&umid=3D6=
e1be473-0b3f-4bc4-a4f0-403592e74baf&auth=3Dd807158c60b7d2502abde8a2fc01f406=
62980862-f501ab9aa5516ff666e387e53598fd624398f1bc
>>>>>>> Info : auto-selecting first available session transport "jtag". To =
override use 'transport select <transport>'.
>>>>>>> wrong # args: should be "-event <event-name> <event-body>"
>>>>>>>
>>>>>>>
>>>>>>> Do you know how to fix it?
>>>>>>
>>>>>>
>>>>>> I actually bisect it and found that it is caused by
>>>>>> jtag: rewrite jim_jtag_configure() as COMMAND_HANDLER
>>>>>> ea2e26f7d521f5755b4bfda7bf12d99650277421
>>>>>
>>>>> Interesting. I have been testing with 0.12.
>>>>>
>>>>>> # sudo openocd -f /usr/local/share/openocd/scripts/interface/ftdi/di=
gilent_jtag_smt2_nc.cfg -f /usr/local/share/openocd/scripts/target/xilinx_z=
ynqmp.cfg
>>>>>
>>>>> FWIW after installing the udev rules I do not need sudo
>>>>>
>>>>>> Open On-Chip Debugger 0.12.0+dev-01512-g214206ebb972 (2024-02-16-15:=
38)
>>>>>> Licensed under GNU GPL v2
>>>>>> For bug reports, read
>>>>>>       https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/=
query?url=3Dhttp%3a%2f%2fopenocd.org%2fdoc%2fdoxygen%2fbugs.html&umid=3D6e1=
be473-0b3f-4bc4-a4f0-403592e74baf&auth=3Dd807158c60b7d2502abde8a2fc01f40662=
980862-f501ab9aa5516ff666e387e53598fd624398f1bc
>>>>>> none separate
>>>>>> Info : auto-selecting first available session transport "jtag". To o=
verride use 'transport select <transport>'.
>>>>>> Info : Hardware thread awareness created
>>>>>> boot_apu
>>>>>> Info : Listening on port 6666 for tcl connections
>>>>>> Info : Listening on port 4444 for telnet connections
>>>>>> Warn : An adapter speed is not selected in the init scripts. OpenOCD=
 will try to run the adapter at very low speed (100 kHz).
>>>>>> Warn : To remove this warnings and achieve reasonable communication =
speed with the target, set "adapter speed" or "jtag_rclk" in the init scrip=
ts.
>>>>>> Info : clock speed 100 kHz
>>>>>> Info : TAP uscale.tap does not have valid IDCODE (idcode=3D0x48e7012=
6)
>>>>>> Info : JTAG tap: uscale.ps tap/device found: 0x24738093 (mfg: 0x049 =
(Xilinx), part: 0x4738, ver: 0x2)
>>>>>> Info : JTAG tap: uscale.tap tap/device found: 0x5ba00477 (mfg: 0x23b=
 (ARM Ltd), part: 0xba00, ver: 0x5)
>>>>>> Info : JTAG tap: uscale.ps tap/device found: 0x24738093 (mfg: 0x049 =
(Xilinx), part: 0x4738, ver: 0x2)
>>>>>> Error: JTAG-DP STICKY ERROR
>>>>>> Error: [uscale.a53.0] Examination failed
>>>>>> Warn : target uscale.a53.0 examination failed
>>>>>> Info : [uscale.axi] Examination succeed
>>>>>> Info : starting gdb server for uscale.a53.0 on 3333
>>>>>> Info : Listening on port 3333 for gdb connections
>>>>>> Info : gdb port disabled
>>>>>>
>>>>>> but with zcu102 I am still not able to connect because error above.
>>>>>> The same behavior with recording SOM IDs I see on kv260 (via hs3 cab=
le).
>>>>>> It looks like that not everything is working for zynqmp.
>>>>>
>>>>> Is this with the boot mode set to JTAG? If so, you will not be able t=
o
>>>>> examine any of the CPUs until you have released them from reset. So y=
ou
>>>>> should be able to run
>>>>>
>>>>>           targets uscale.axi
>>>>>           boot_pmu /path/to/pmu-firmware.bin
>>>>>           boot_apu /path/to/u-boot-spl.bin
>>>>>
>>>>> to boot a CPU. If you want to silence the above error, you can add
>>>>>
>>>>>           uscale.a53.0 configure -defer-examine
>>>>>
>>>>> to your config. So the full command would be
>>>>>
>>>>> $ openocd -f interface/ftdi/digilent_jtag_smt2_nc.cfg \
>>>>>           -f target/xilinx_zynqmp.cfg \
>>>>>           -c 'uscale.a53.o configure -defer-examine' \
>>>>>           -c init -c 'targets uscale.axi' \
>>>>>           -c 'boot_pmu /path/to/pmu-firmware.bin' \
>>>>>           -c 'boot_apu /path/to/boot.bin'
>>>>>
>>>>> Let me know if that works for you.
>>>>
>>>> Oh, and I forgot to mention, but if you are testing semihosting then y=
ou will need to add
>>>>
>>>> -c 'uscale.a53.0 arm semihosting enable'
>>>>
>>>> to the end of that. I also find setting the semihosting base directory=
 with
>>>>
>>>> -c 'uscale.a53.0 arm semihosting_basedir $IMAGEDIR'
>>>>
>>>> to be helpful.
>>>>
>>>> As you can imagine this is a long command line, so I have a config whi=
ch looks like
>>>>
>>>> source [find interface/ftdi/digilent_jtag_smt2_nc.cfg]
>>>> adapter speed 25000
>>>> source [find target/xilinx_zynqmp.cfg]
>>>> uscale.a53.0 configure -defer-examine
>>>>
>>>> proc boot {imagedir machine} {
>>>>           targets uscale.axi
>>>>           boot_pmu "${imagedir}/pmu-firmware-${machine}.bin"
>>>>           boot_apu "${imagedir}/u-boot-spl.bin"
>>>>           uscale.a53.0 arm semihosting enable
>>>>           uscale.a53.0 arm semihosting_basedir $imagedir
>>>> }
>>>>
>>>> which I invoke like
>>>>
>>>> $ openocd -f my_config.cfg -c init -c 'boot /path/to/images my-machine=
'
>>>
>>>
>>> ok. 0.12.0 version is working better. I am able to load firmware to APU=
 but I was not able to load pmufw. It was saying timeout like this.
>>>
>>>> boot_pmu /mnt/disk/som/pmu_obj.bin
>>> /usr/local/bin/../share/openocd/scripts/target/xilinx_zynqmp.cfg:173: E=
rror: Timed out waiting for PMU firmware
>>> in procedure 'boot_pmu'
>>> in procedure 'resume_pmu' called at file "/usr/local/bin/../share/openo=
cd/scripts/target/xilinx_zynqmp.cfg", line 232
>>> at file "/usr/local/bin/../share/openocd/scripts/target/xilinx_zynqmp.c=
fg", line 173
>>>>
>>>
>>> Then I looked at pmu and use below snipset which I use on xsdb to make =
it visible for debugger and also small waiting time.
>>>
>>>
>>> @@ -141,6 +146,13 @@ add_help_text halt_pmu "Halt the PMU in preparatio=
n for loading new firmware.\
>>>          This should be matched with a call to resume_pmu."
>>>   proc halt_pmu {} {
>>>          set axi $::_CHIPNAME.axi
>>> +
>>> +       puts "Enable PMU target"
>>> +       set val [$axi read_memory 0xFFCA0038 32 1]
>>> +       $axi write_memory 0xFFCA0038 32 [expr {$val | 0x1C0}]
>>
>> These should already be set. See table 39-3 in UG1085. Although I seem
>> to have a combination of 39-2 and 39-3:
>>
>>      > targets uscale.axi
>>      > # BOOT_MODE_USER BOOT_MODE_POR
>>      > mdw 0xff5e0200 2
>>      0xff5e0200: 00000000 00000000
>>      > # jtag_chain_cfg jtag_chain_status jtag_sec jtag_dap_cfg
>>      > mdw 0xffca0030 4
>>      0xffca0030: 00000000 00000003 0000003f 000000ff
>>
>> Do you see these values in the JTAG boot mode?
>
> That 0x1c bit are
> "Setting these bits disables the security gate for the PMU MDM and allows=
 the PS TAP to connect to the PMU. All bits must be set to 1 for the securi=
ty gate to be released. (POR reset only)"
>
> This is enabled to see PMU microblaze MDM. But I expect microblaze is not=
 supported by OpenOCD but this makes it work for me.

Yes, I know why you set these bits. But they should all be set already
(see e.g. my output above). So I am curious if they are not set for you.
If you have different values for the above registers, then there is
likely something different about your setup which could also cause your
below error.

>>
>>> +       sleep 5
>>
>> Part of my goal here is to remove "magic" sleeps like this so the boot
>> process goes faster.
>
> I get it. 5s is likely too much and didn't try to minimalize.
>
>>
>>> +       puts "PMU target should be enabled">         set val [$axi read=
_memory $::IPI_PMU_0_IER 32 1]
>>>          $axi write_memory $::IPI_PMU_0_IER 32 [expr {$val | $::IPI_PMU=
_0}]
>>>
>>> With that I am able to test your patch but it is kind of slow.
>>> Max freq I am able to use on zcu102 is 2MHz which is far from 15MHz use=
d by xsdb.
>>
>> I have been using the maximum 25 MHz speed without issue.
>
> Can you provide more details about board you use?
> I can switch to different cable or different board but based on
> your config you are also using digilent smt2 NC module (without USB on it=
)
> that's why it is quite scary that I am not able to run it at higher freq.

It's a custom design based on [1]. The carrier has a smt2 module on it
which is connected to the ZynqMP via the card edge connector.

Regarding the clock speed, the datasheet for the smt2 [2] module says
the maximum speed is 30 MHz, but I use 25 MHz since DS925 says that is
the maximum speed for the ZynqMP (table 40). Maybe you are using a lower
VCCINT?

> I will try different board or different cables.
> Do you know if standard xilinx cables are supported?
> This one
> https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=
=3Dhttps%3a%2f%2fwww.xilinx.com%2fproducts%2fboards%2dand%2dkits%2fhw%2dusb=
%2dii%2dg.html&umid=3D720e2c50-55de-40c4-ac09-1623b19dfef2&auth=3Dd807158c6=
0b7d2502abde8a2fc01f40662980862-1c4afab79eea13f4f1554e802b0609bcea3cc2f7
> or black version?

I have not tried those cables (nor do I have them on hand). I have used
the smt2 as well as the hs3 dongle. I also have a J-LINK, but I do not
have an adapter cable made.

--Sean

[1] https://edge.seco.com/usa/som-smarc-zu.html
[2] https://digilent.com/reference/_media/programmers/jtag-smt2-nc/jtag-smt=
2-nc_rm.pdf

[Embedded World 2024, SECO SpA]<https://www.messe-ticket.de/Nuernberg/embed=
dedworld2024/Register/ew24517689>
