Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D4CC48260
	for <u-boot@archiver.kernel.org>; Fri, 16 Feb 2024 16:03:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8452B87C68;
	Fri, 16 Feb 2024 17:03:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="QxKzwfFD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seco.com header.i=@seco.com header.b="chkrCeAR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB7ED87E28; Fri, 16 Feb 2024 17:03:19 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32A2F8765B
 for <u-boot@lists.denx.de>; Fri, 16 Feb 2024 17:03:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=JVV+tK+gzLLbSC8ITwWoOpIIj6OseSXlZFjZYY8ZjbOivqvf9ivFtVXXtgiZw3xGRTs2w8yRetbFnZ4bNixF4zGm3NTSMOxEOApD4a+DE8SuCxkWVNCaXmItMq+A/Pz/RW1kAIrOo4TxmRQ08FRzLFhhfcXC53KiefJ6MaaDaRzgY5RyvAg7Jc1RZiuvsc6QTiYxdV3n+bhI8hTynw4H3evdbTxbDFm24SkNnoUwOhF5wjxlb7LGloz1G8tCkKdVFruT7MWO5NWD//cQYw5kuol32/EQKZGcObu3ZcHdT+MrHvugrUiWSFgGYcWQGaf5DCJVhzQ2qu4/368vmBuVPA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxcdNgiWGyh0AikIuB36t/5hfOCqGhvd4hdbIMdYWu4=;
 b=Q3EKeb1v1vmnqSfa6l3n18QMoZfqKcHlUDFBodD9RBHvXIAYw3Tf90zdH2O8icyF/VctVmUzmrjNR0m0X5LuQYYRgnmWerz38rdHT6zeMAdRpHokrFh2e1cSsQpzXEMfR68HoOvqpzvegdT+jBaWsbEODS98xGvAsnhjylG67kAhJUNgqm61ptbbVBy6DoQgt134LNfcycFLGzippBE2boUy6Jkxfs91wHraJ/8pIEE7VHqz4AQklC6dwiMOz2gZU+qLVS5ezReVA14UKQBcdhJgOnyidiENJKogRwB+tW53mMgagEZdUn/GWneBi5GIlTdknhQly6BEez1nW6zXKQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.86) smtp.rcpttodomain=amd.com smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxcdNgiWGyh0AikIuB36t/5hfOCqGhvd4hdbIMdYWu4=;
 b=QxKzwfFDDX5diP39GaYQMlpeiHtqTIBwicwcllQlCpW1F9sPLBdvYVJzgFUifhWgjvEt1844lTi7WqcJjZ88mJJoW2HKYhAhKFgJ8fhfbZlksF+RuQVEWzkId7ZmR/7nGgjU2VandQBZs6WKZ4dJ+7779JYs1fzXKGDrjnY4u4Z7Y3HCYfh7o0MItrdWsD5JWaJFmLc4/iZvhN5oQi8SITC+29LAXvBgNlxcXtzbnqdxBJe6leszmbUKb3xBzVtkfhGbZa0tg0Pk6p6EO9s7elopwzaIPAndIKYJUrnGzHRP+/gzb2eSjvIM2rH4J6gY7mq+QTFRKuycpBBSZiiwwQ==
Received: from AM6P193CA0088.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:88::29)
 by PAWPR03MB9246.eurprd03.prod.outlook.com (2603:10a6:102:342::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 16:03:11 +0000
Received: from AMS1EPF00000048.eurprd04.prod.outlook.com
 (2603:10a6:209:88:cafe::ad) by AM6P193CA0088.outlook.office365.com
 (2603:10a6:209:88::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Fri, 16 Feb 2024 16:03:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.86)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.86 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.86; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.86) by
 AMS1EPF00000048.mail.protection.outlook.com (10.167.16.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Fri, 16 Feb 2024 16:03:11 +0000
Received: from outmta (unknown [192.168.82.140])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 2002720080F8B; Fri, 16 Feb 2024 16:03:11 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (unknown
 [104.47.18.104])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 435E52008006E; 
 Fri, 16 Feb 2024 16:03:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PxJT7yC1tOj+Hq+sqlmWfbj2h3YZA3qRpBbKNGntZuEY9b65wrX8pftY1QPxZSPhNo/Uon3vvRQLZ5tAvW85WyzmYFuCod4kXjm/W+247x8Hp96ZV3c0utYcDmIzTNFq4/8jqAT9P+8ikxYkxFWsWEYnwpTnPpCB/GfM2pc/ORHFze+1RwTNb1Cb8j+7cZ/t0YTfdghrcrdwLU/fn5gdCXPBderyVU5MLkGH5fKHxh9Wf4NQie4hJokooWk9j2UAncdAJB5wvNu557vRrBOJXzHNp99a6B/ESawdANEs7CKch/IUoHEND8rItg8AB0ytjcLRtMd/YNZywKteiZPtNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3j4YUxtUDqfPRlEcTjVBhJ37giR58QZuea26yP764gQ=;
 b=COcW9CH4dUpOe3wMwQKFodbywkNW3kL28+o0orwQ9L8MC8JiFPkjW3xHICYl6BY1oVAtdrMVmxeQHRsjqVslgq4Scxyhp5YSZeRpfF8q+u/kmC/u3+L8GQsnUI4UYlApOq1qYYNRChQyadwbSTz7YV1o48CDB3OexVCnlcUW64hMWIWG5DqzHLQGKpofhN/sj4zs3aTKIjFXfXbveF92IJlBPtNeJdyaXsdHboZ12HOut1b+68KN6LMarL0xM2i5tDDCylGY+1NFm2xjZtHOX8o0/hvAlYf0+bHRq/ao4UbkW+kATfo1+HcJS1Tr4xrtJoL27rhFUPIF0p1V6KC6DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3j4YUxtUDqfPRlEcTjVBhJ37giR58QZuea26yP764gQ=;
 b=chkrCeARZj6l/HL8wL4vB53JCs5PXwtuANWUZ8o/UV0i18lkLlSWIqTTFgU0khw+3XwZdS8ClacY5cSfgU6KYBuAmbnBTV02pUsOR4ltVmmcR06PKUc33Y/XMDJxAnkTMPDfRsna70OOT7MhT3RCu060O7HnpNR05XirhsA11hgr/GaRPze85+Am8k7fnw9FWe3waUSQsCL0I80QqAWMyyw4xtRgv74MI80yCcRHhY5M5+n15z1dME95c+yWYkcsCLGKlcJYpwqowUXdsFaF2OY1dj634yDYrRR5i85mbaQv+LU9d860rHjLe8xUlkEoBg8i0qKkExrg73H2q2hXvA==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by PAXPR03MB8016.eurprd03.prod.outlook.com (2603:10a6:102:21f::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Fri, 16 Feb
 2024 16:03:07 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::18b0:3c00:30cb:711c]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::18b0:3c00:30cb:711c%6]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 16:03:07 +0000
Message-ID: <4a2e8e89-36e3-4e58-9f14-2151fc907081@seco.com>
Date: Fri, 16 Feb 2024 11:03:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Support semhosting boot method
Content-Language: en-US
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
References: <20240215171918.3729508-1-sean.anderson@seco.com>
 <3f6a5971-a024-4eb2-bdba-76071fbd9bb2@amd.com>
 <e9fd399c-34e2-4c54-a74e-d1a3b84fbcdb@seco.com>
 <326f67f9-a6de-42e3-a2fb-9d649520557a@amd.com>
 <0ab35778-ae8a-4eb2-a021-ee8e3a9815be@amd.com>
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <0ab35778-ae8a-4eb2-a021-ee8e3a9815be@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR19CA0006.namprd19.prod.outlook.com
 (2603:10b6:208:178::19) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|PAXPR03MB8016:EE_|AMS1EPF00000048:EE_|PAWPR03MB9246:EE_
X-MS-Office365-Filtering-Correlation-Id: 8840503b-16fe-4b69-1434-08dc2f08c649
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: sdYIOzNwwTDAXbvQjDrWSlkKV9ExtDSH+tLKHLodXAehoWtVYD6gApFrTOVYrsMCERsrkRAL+QiIPA8SkvmxHCn0QFCRWKXQXYsAZpS7ztwSko0+Mz3o5tLt9FsfjpN7RfYjzJtY9Zl/GYwPO7Jtt8Cxq2s5zcIcQ59kZCkUiHxOznKzKhcuM1kmbNV495BmDU9QekSCwz5rXPi9G4y2uKv12wTPIpcqD7K+q4Zb3vyDbJLmQ8sBaDRCf3BrVfOzbjSgMjMNB2JCKZVZA9BMtAvWsKJyrZ2KYz0YDB6EZPPx2VplIbABrHXYbbUfEdzLdQ/fBblxOrLlU8HP+FQqoAJmcRuAwIQL6s4IRuYWgihfAXmykS+LOBHZoiuJslzYUcl63up/x8CV4PnHszn8N2d9rd8/049oMj0z9OSrTzmKJChtbG6nnmxYoKUKNNG90Fxc9nt5o8fyxAfdpBoopTGXvmZzuFLVQfBkIcZDMpohnPnPqw0/YFhUmz3YMwSlkR7Z1iqYGpSFs8T57RSe5C9u3+Tm4h2jGEvBAUczTmbT54ozTptUJyak7Izr8YpI9+Sbi6p4bfnjDesb/MZUsOYESD/oEkwnMk5Dtz6BBZI=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB9PR03MB8847.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(39850400004)(136003)(376002)(396003)(230922051799003)(230273577357003)(1800799012)(64100799003)(186009)(451199024)(5660300002)(44832011)(316002)(41300700001)(2906002)(26005)(83380400001)(86362001)(2616005)(36756003)(38100700002)(31696002)(8936002)(38350700005)(8676002)(66946007)(66556008)(478600001)(66476007)(6506007)(31686004)(53546011)(966005)(6512007)(6486002)(52116002)(6666004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB8016
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS1EPF00000048.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: af7b88bb-c31e-4eaf-13bb-08dc2f08c3b2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JlsQSZYlP3i1QbuaRY5Y9ypz1RRohJXX8NsJbJ4t2IobMXXGwU3GoNz4mZDfCL3OSHePUUG7BDC0A9Vibs856Zg6/U/CeJCpz4ec2eypVPLLgVKwkIqCcRaOjZebS7CHv3GcjJ5OsZE/NsCOluUwleq8SHLIHbgnY9hPKk5UI4AaItPz+ROTBxkJ4C2ZqwH725jVNBPV4Bx30ylpCgOsznMb+QIwk9OyAJWZozsHJledOlkM/ZdUbHXiegc5QeuO7pdkHUw6DIGj985G9Hq1nipZrkWj6+aszEj25Rlm6hAdIgRdH/MHG1dfkBwWfCyKHPBOkaagOdWI5bFBX2EgvL5JUSpK/J2gxk+osn9UV9FfjqQkUiNFO4pptEqy/o8JL8OYajtqOx/oRykJlBHJCvt4psAaAGGb2Gg4XPyFj5KusoMRp2udJO5mhJJWrKPeD4o+MI5gPtJdlm3Y+VUMdP7G8ArUFfvbXH9ixM1clXOMMtkrATKOYDHdy0p28FsvGberD7LEeTlmJ0Qi6EZCLrtnWdWqOGei56Zd9cn2xc4b6vGB3zIfYQJwp1XWqPLT0YVfUXBwPmI6OidWiGAXmRoRJXbJttsZtZuT9wOuQowrHU11MDZQihXbie/8tKYln03XJqN1SIS9xJk+9ZDX+g==
X-Forefront-Antispam-Report: CIP:20.160.56.86; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230031)(396003)(376002)(346002)(39850400004)(136003)(230922051799003)(230273577357003)(186009)(451199024)(64100799003)(82310400011)(1800799012)(36860700004)(40470700004)(46966006)(2906002)(44832011)(5660300002)(26005)(8676002)(82740400003)(36756003)(41300700001)(478600001)(2616005)(356005)(7596003)(7636003)(83380400001)(53546011)(336012)(31696002)(86362001)(70586007)(70206006)(8936002)(966005)(6512007)(6486002)(6506007)(316002)(6666004)(31686004);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 16:03:11.2220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8840503b-16fe-4b69-1434-08dc2f08c649
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.86];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000048.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB9246
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

On 2/16/24 10:06, Michal Simek wrote:
>
>
> On 2/16/24 14:48, Michal Simek wrote:
>>
>>
>> On 2/15/24 20:31, Sean Anderson wrote:
>>> On 2/15/24 14:08, Michal Simek wrote:
>>>>
>>>>
>>>> On 2/15/24 18:19, Sean Anderson wrote:
>>>>> Currently, when we boot from JTAG we try to boot U-Boot from RAM.
>>>>> However, this is a bit tricky to time, since the debugger has to wait
>>>>> for SPL to initialize RAM before it can load U-Boot. This can result =
in
>>>>> long waits, since occasionally initializing RAM (and other things in
>>>>> psu_init) takes a long time to complete and the debugger must wait fo=
r
>>>>> this worst case.
>>>>>
>>>>> Support semihosting if it is enabled, as it lets U-Boot tell the
>>>>> debugger when we are ready for the image. This means we don't have to
>>>>> wait any more than necessary. We don't change the default config to
>>>>> ensure we don't break compatibility with existing debuggers that don'=
t
>>>>> expect us to hit semihosting breakpoints.
>>>>>
>>>>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>>>>> ---
>>>>>
>>>>>    arch/arm/mach-zynqmp/spl.c | 10 ++++++++--
>>>>>    1 file changed, 8 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm/mach-zynqmp/spl.c b/arch/arm/mach-zynqmp/spl.c
>>>>> index a0f35f36faa..5af735aa5ce 100644
>>>>> --- a/arch/arm/mach-zynqmp/spl.c
>>>>> +++ b/arch/arm/mach-zynqmp/spl.c
>>>>> @@ -9,6 +9,7 @@
>>>>>    #include <image.h>
>>>>>    #include <init.h>
>>>>>    #include <log.h>
>>>>> +#include <semihosting.h>
>>>>>    #include <spl.h>
>>>>>    #include <linux/delay.h>
>>>>>
>>>>> @@ -66,6 +67,11 @@ void spl_board_init(void)
>>>>>    }
>>>>>    #endif
>>>>>
>>>>> +static u32 jtag_boot_device(void)
>>>>> +{
>>>>> +       return semihosting_enabled() ? BOOT_DEVICE_SMH : BOOT_DEVICE_=
RAM;
>>>>> +}
>>>>> +
>>>>>    void board_boot_order(u32 *spl_boot_list)
>>>>>    {
>>>>>           spl_boot_list[0] =3D spl_boot_device();
>>>>> @@ -75,7 +81,7 @@ void board_boot_order(u32 *spl_boot_list)
>>>>>           if (spl_boot_list[0] =3D=3D BOOT_DEVICE_MMC2)
>>>>>                   spl_boot_list[1] =3D BOOT_DEVICE_MMC1;
>>>>>
>>>>> -       spl_boot_list[2] =3D BOOT_DEVICE_RAM;
>>>>> +       spl_boot_list[2] =3D jtag_boot_device();
>>>>>    }
>>>>>
>>>>>    u32 spl_boot_device(void)
>>>>> @@ -97,7 +103,7 @@ u32 spl_boot_device(void)
>>>>>
>>>>>           switch (bootmode) {
>>>>>           case JTAG_MODE:
>>>>> -               return BOOT_DEVICE_RAM;
>>>>> +               return jtag_boot_device();
>>>>>    #ifdef CONFIG_SPL_MMC
>>>>>           case SD_MODE1:
>>>>>           case SD1_LSHFT_MODE: /* not working on silicon v1 */
>>>>
>>>> Good timing. Can you please tell me how to test this? What's the setup=
?
>>>> Which debugger are you using?
>>>
>>> I am using OpenOCD with the patches at https://cas5-0-urlprotect.trendm=
icro.com:443/wis/clicktime/v1/query?url=3Dhttps%3a%2f%2freview.openocd.org%=
2fc%2fopenocd%2f%2b%2f8133&umid=3D6e1be473-0b3f-4bc4-a4f0-403592e74baf&auth=
=3Dd807158c60b7d2502abde8a2fc01f40662980862-afc15b07b0f91c910f832185958363d=
84f990a08
>>>
>>
>> I am trying it on the top of the latest git but getting issue with event=
 block and no idea how to fix it.
>>
>> # sudo openocd -f /usr/local/share/openocd/scripts/interface/ftdi/digile=
nt_jtag_hs3.cfg -f /usr/local/share/openocd/scripts/target/xilinx_zynqmp.cf=
g
>> Open On-Chip Debugger 0.12.0+dev-01509-g6d288937cb2d (2024-02-16-12:22)
>> Licensed under GNU GPL v2
>> For bug reports, read
>>      https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query=
?url=3Dhttp%3a%2f%2fopenocd.org%2fdoc%2fdoxygen%2fbugs.html&umid=3D6e1be473=
-0b3f-4bc4-a4f0-403592e74baf&auth=3Dd807158c60b7d2502abde8a2fc01f4066298086=
2-f501ab9aa5516ff666e387e53598fd624398f1bc
>> Info : auto-selecting first available session transport "jtag". To overr=
ide use 'transport select <transport>'.
>> wrong # args: should be "-event <event-name> <event-body>"
>>
>>
>> Do you know how to fix it?
>
>
> I actually bisect it and found that it is caused by
> jtag: rewrite jim_jtag_configure() as COMMAND_HANDLER
> ea2e26f7d521f5755b4bfda7bf12d99650277421

Interesting. I have been testing with 0.12.

> # sudo openocd -f /usr/local/share/openocd/scripts/interface/ftdi/digilen=
t_jtag_smt2_nc.cfg -f /usr/local/share/openocd/scripts/target/xilinx_zynqmp=
.cfg

FWIW after installing the udev rules I do not need sudo

> Open On-Chip Debugger 0.12.0+dev-01512-g214206ebb972 (2024-02-16-15:38)
> Licensed under GNU GPL v2
> For bug reports, read
>     https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?u=
rl=3Dhttp%3a%2f%2fopenocd.org%2fdoc%2fdoxygen%2fbugs.html&umid=3D6e1be473-0=
b3f-4bc4-a4f0-403592e74baf&auth=3Dd807158c60b7d2502abde8a2fc01f40662980862-=
f501ab9aa5516ff666e387e53598fd624398f1bc
> none separate
> Info : auto-selecting first available session transport "jtag". To overri=
de use 'transport select <transport>'.
> Info : Hardware thread awareness created
> boot_apu
> Info : Listening on port 6666 for tcl connections
> Info : Listening on port 4444 for telnet connections
> Warn : An adapter speed is not selected in the init scripts. OpenOCD will=
 try to run the adapter at very low speed (100 kHz).
> Warn : To remove this warnings and achieve reasonable communication speed=
 with the target, set "adapter speed" or "jtag_rclk" in the init scripts.
> Info : clock speed 100 kHz
> Info : TAP uscale.tap does not have valid IDCODE (idcode=3D0x48e70126)
> Info : JTAG tap: uscale.ps tap/device found: 0x24738093 (mfg: 0x049 (Xili=
nx), part: 0x4738, ver: 0x2)
> Info : JTAG tap: uscale.tap tap/device found: 0x5ba00477 (mfg: 0x23b (ARM=
 Ltd), part: 0xba00, ver: 0x5)
> Info : JTAG tap: uscale.ps tap/device found: 0x24738093 (mfg: 0x049 (Xili=
nx), part: 0x4738, ver: 0x2)
> Error: JTAG-DP STICKY ERROR
> Error: [uscale.a53.0] Examination failed
> Warn : target uscale.a53.0 examination failed
> Info : [uscale.axi] Examination succeed
> Info : starting gdb server for uscale.a53.0 on 3333
> Info : Listening on port 3333 for gdb connections
> Info : gdb port disabled
>
> but with zcu102 I am still not able to connect because error above.
> The same behavior with recording SOM IDs I see on kv260 (via hs3 cable).
> It looks like that not everything is working for zynqmp.

Is this with the boot mode set to JTAG? If so, you will not be able to
examine any of the CPUs until you have released them from reset. So you
should be able to run

        targets uscale.axi
        boot_pmu /path/to/pmu-firmware.bin
        boot_apu /path/to/u-boot-spl.bin

to boot a CPU. If you want to silence the above error, you can add

        uscale.a53.0 configure -defer-examine

to your config. So the full command would be

$ openocd -f interface/ftdi/digilent_jtag_smt2_nc.cfg \
        -f target/xilinx_zynqmp.cfg \
        -c 'uscale.a53.o configure -defer-examine' \
        -c init -c 'targets uscale.axi' \
        -c 'boot_pmu /path/to/pmu-firmware.bin' \
        -c 'boot_apu /path/to/boot.bin'

Let me know if that works for you.

--Sean

[Embedded World 2024, SECO SpA]<https://www.messe-ticket.de/Nuernberg/embed=
dedworld2024/Register/ew24517689>
