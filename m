Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC12DC48260
	for <u-boot@archiver.kernel.org>; Fri, 16 Feb 2024 16:09:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1140687E28;
	Fri, 16 Feb 2024 17:09:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="VD6Brs5K";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seco.com header.i=@seco.com header.b="OH6BRc4Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CD6587E50; Fri, 16 Feb 2024 17:09:50 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0727.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::727])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81E0387E0F
 for <u-boot@lists.denx.de>; Fri, 16 Feb 2024 17:09:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=T0vH4O8zdTY3cGMriSD/iZf9uLfzXSPkK0sjxN8kw26uxvXulbc3mU3Gjag/TB30z4OrkURYXg2rJlOsa6G+Vvld+TfQcez8gwkxFMb/0Z7V3UZRRQ2PQoXNl2uvfYTjb6Ee8TEx4VPE5/zBZgIw4kYBNQ/KOQiII0+db+yvOfw5EjPaBeLUGebKFr7ZJ66zP5MTkzKYG5GDXCLm02L8A471EJwlgmqZLKxH+rz/+W5B5BrV3uHCQnc4PLROS9cvPem+7gENkPtHL3fWnn4/2zn8TOftUVEFvt+R7dpAAp/MeFtfjItiT0f7XuVEiCjECjEvqNizwsYgzW9f4TVdow==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+8E4FzG8v5sBDys5NSBzOGk4IXrwzbtf8t14UfRfdI=;
 b=Xn8tVe4SQ4mJGv0eBm3rjUXXUa29zuuRiAUAU+LNUaXxUQXJaINSnbGr5XHqreclbBwArwmYtROdH8KU2WsCtwqvXhdlVj+c5NTqDk7rQhUMyUvL4K3l6HCjAApcuk24jFXnqqCDCo/F73umS8/0tzOxHu8pazKnEdtx/odedW84Y75Q/e4xFimsUCS3t7VRieQM1e6gPfdiEiI00WJR4db0V7jjd3hmvqFjeE/bWY54RnCxax18DHmSaY8gSIaRBwTpxHmXPehnQhLH4YE6jL0vW+LLpbWvpIJpMSNJdmFOE3WWLY/UyMPB48eexoTyXgZgjn+VbkCSziIZkh5DVw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.87) smtp.rcpttodomain=amd.com smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+8E4FzG8v5sBDys5NSBzOGk4IXrwzbtf8t14UfRfdI=;
 b=VD6Brs5KQ56qOsSTjh1dmERAROKfQPJZxz/xFgyXNa4ukH4IWopmRTakmcE6GXtywakwAY3hLlWxR0nYEt83h1sfu/BrG0NT3a12pImPbqJUM9y8cv18p1BEO+n3HoLdX0q3pwg60cBNsJG4cR7o3NM6Eky4bmOuJm5O7djQj6HSDmvuutclIxPWWIz6f9z1/hcYofQHgxrz9RNJQArMB/0xu3y8nv9eo1FMmTv8uz2NXldC1F3oh0h58yo7O+JLhB2dH85FBEeKB8KYLoWn0/jkhsn8arpZkb63Ek1nlr1Gv+fAmcPFcUwKhqoi9WXKgrAaV17P5f3F4JR6iHmbgg==
Received: from AM6P193CA0065.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:8e::42)
 by DU2PR03MB7878.eurprd03.prod.outlook.com (2603:10a6:10:2d5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 16:09:37 +0000
Received: from AMS1EPF00000047.eurprd04.prod.outlook.com
 (2603:10a6:209:8e:cafe::ec) by AM6P193CA0065.outlook.office365.com
 (2603:10a6:209:8e::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Fri, 16 Feb 2024 16:09:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.87)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.87 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.87; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.87) by
 AMS1EPF00000047.mail.protection.outlook.com (10.167.16.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Fri, 16 Feb 2024 16:09:37 +0000
Received: from outmta (unknown [192.168.82.140])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 5F75B2009538A; Fri, 16 Feb 2024 16:09:37 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (unknown
 [104.47.51.169])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 6EB282008006E; 
 Fri, 16 Feb 2024 16:09:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YW/kOPNfsgVEOZWlZhjke2/zYicRU6gsYaanrVSn8LerSktRqocl2xM4JV1bdbs6oVG7JGDwPzMBojQL1X96HDjwb+LP8kEm8MXF4+8Sd20M/LZxHf1IXoaTW3pbqR3UnmtzCbVM7uitFtAd/ArH7zSFgv3CW6Gds3ydD8JwnDkFsQuMZSb+JF/eAqhv8A7OLQ6pb3e9zrzWACQdnEbKr93Ky/uIidD97GXhdRBEXikLBe370tp/FIg4uusDjesMKiLkUv6RAsRPsDF/84RH5Ksuz2fTiPXeQGTaAC9DXsMs0sG+wwxAV+jrOyYfZbuz3dtjDJoH7L0vWxStQmkCCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6/g6Qf47MQ0F2E6GiZUtIVQiRkC2HoFaH8Hx9J1Zug=;
 b=FBAU4BY8tyyBkgrGsutTmlTZk9QlUoHZRzbIt1m+uE9S6sUHjEG1uME0aETscsZ0GVAMRSuRlo8qc6uv2AvvM6qFCY8s2cp/LMqF8jRk+4PHNGwR0BEecf7pFIsF8L5NGHOILt9ol08tMYDKnElUPjBkJ3H/lbpdtE08zNXqyo9GcI8lOucECGbLXRpHhAIvgx3flWwDSVs3aOpO8aciTUenWn95K0QOQD0/xDX8CFCc8U06Il5tjZRtj9bvI8ciMK1QokPI0AsXkth0JGFoYV60uAsdvqFoeY7mBPflpkslIGnvYYwhRR1RIeTRZuT5vY0lVKdo0jE+Q/H/pJhSgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6/g6Qf47MQ0F2E6GiZUtIVQiRkC2HoFaH8Hx9J1Zug=;
 b=OH6BRc4Y6o3bpHRFUNF6U8ihYwSRAP7ySAsStniJENd2iI9RTxNcT5aFilhzqbhyGxoDpGFbBPipTtZZclnn9O4PAodui0hO8sK0pKToel/0NQljsrFLJ560sDEHjBd8TE4AsSisJt2ztE27pLIWeHQyvuRNUR4jsG5Nv1otP+Fw8gEBDAbLvs6EvOTlvFsqFi5IXjB3MKvl0sN4Ns7gWJ/qtmNxyj8Gg+EcMd7mvaE6bmp/kP5GyC59vmeS8cSdQvvgLI7K2C3aB+XVh/PeNcF09WpG3SQ5S6AmKKCFpfSMELw81zFUeZtIO96/RzXOlu+8gnIT7CHUlA7j0cn2dg==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by PAVPR03MB9846.eurprd03.prod.outlook.com (2603:10a6:102:31a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Fri, 16 Feb
 2024 16:09:32 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::18b0:3c00:30cb:711c]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::18b0:3c00:30cb:711c%6]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 16:09:32 +0000
Message-ID: <8561797f-3b77-44af-849b-faa555e244bf@seco.com>
Date: Fri, 16 Feb 2024 11:09:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Support semhosting boot method
Content-Language: en-US
From: Sean Anderson <sean.anderson@seco.com>
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
References: <20240215171918.3729508-1-sean.anderson@seco.com>
 <3f6a5971-a024-4eb2-bdba-76071fbd9bb2@amd.com>
 <e9fd399c-34e2-4c54-a74e-d1a3b84fbcdb@seco.com>
 <326f67f9-a6de-42e3-a2fb-9d649520557a@amd.com>
 <0ab35778-ae8a-4eb2-a021-ee8e3a9815be@amd.com>
 <4a2e8e89-36e3-4e58-9f14-2151fc907081@seco.com>
In-Reply-To: <4a2e8e89-36e3-4e58-9f14-2151fc907081@seco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ2PR07CA0001.namprd07.prod.outlook.com
 (2603:10b6:a03:505::11) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|PAVPR03MB9846:EE_|AMS1EPF00000047:EE_|DU2PR03MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: 91897b02-8611-4210-b8e5-08dc2f09ac83
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: J5JrZqZMsiUFY5F87PzXlfpssnxEi9g+IB/WWehC0HVlFDbPdkLl4nycmbr8H7GwnYdycLz/lu5QuLb64WEpWGmYJsy20vR2WKaxfEDtFMs5l1G9ma9nolCCWQV6CWJH1+9r6UjS+9b7hy7cYGlNHAMNo0gtX+b66VtN1GgvkPWz5qyaRvtl7r8F8sWZq9RCf9beQjO1u06qrN60LSiYyI5K1h/AuQvkoUN9lu4+7AKO5f9ZhpD1oJq41Jc3JXIJc1Ir4NUGciCJr9gSenIcPO+BjeQh8efvbksk8LiyeTRdxfMv8qblaUlAdj/4CDkJznQ7Yl0LjVCKKEMAkORYyTWEuogOW7tLOnd0hbFarLWXpqi2aLtsbyVvLko2Bg+X5nWbg91l2SUO6kSsc4zTbt9Ga4yMKrehqiwTn5v9J5ZZ911n+LguMLcbTxmtG6F7Cfrub4hZyNCgJAUDwxWdrr9kEdk67xEjbaC5wXdUUz6WId1dJPqo3s3BP1CiBBAQIEYdAK/HUNpHkCuot4N/RY4nAb59jKYH2jdLJvGUFgyqYVYTW5ZnafE0dD8v+siCaT+oim+FXfrx2pdWlP65kPaoBW7k9LLUBtbe2PHhi58=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB9PR03MB8847.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(396003)(346002)(376002)(366004)(136003)(230922051799003)(230273577357003)(64100799003)(1800799012)(186009)(451199024)(31686004)(6486002)(41300700001)(966005)(478600001)(52116002)(2906002)(44832011)(66556008)(5660300002)(8936002)(8676002)(26005)(66946007)(66476007)(83380400001)(38350700005)(6506007)(53546011)(316002)(6512007)(6666004)(2616005)(31696002)(86362001)(36756003)(38100700002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR03MB9846
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS1EPF00000047.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1adc3ebd-10f1-49d2-3a6a-08dc2f09a96e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gHlsix9S07UJEqpX0eD4nwqUEYWxQny34oISBIf62952ZSaQPkSNBoiKIVHwgdqwnOYRigf6bm2aTbYfO2xRByzpH5CggxndqKe3DzIGxAIbe7YF8V8LRQKuX7HA7nf9Y2r55UlpDcdPMVAZqjbu5SC4bXn5hjTBLpfYRKqNUNQvRNKKVR9QOBywZgRreNqyijOMaPTDJ+s2606oRHZufSXv43soWvygTOjC2Zk0rarapEAGhstw+4Dtjlyc7/30MfsIQqSaI6PWfKN1qoB8HgO7Cg374yxX1AUCwkwuctMZ9MWwnpJiA9i9tHRCAfqa2cMSAIyyh1i5JEXxZ76bTbQXKhbrkBzC0sR/Sln6UaLvFDQd3tkpjRYoOwsNpJ2AsMSz7PdKgLOy3HsOAF8jterDSQoX2w9Jo/THD65bIsoLfOkvNEw3MeiknDzw/0zkzY29rBW7R57BcuDmTEs6Rzm/3YxZnRnKYFUgFRgvODJzgyzKdwIMa2gihcpBjdkLs3vtcAdd3eKLfNtAmvBO6d8Jkn4doG3tuEW62B9AUlIv/zIiKAbg6gggzbwCuMxlMYAitBKaYacQUcQOVYcn2jCMvC7njis7fM7ECWeoAaKDAI/ThGEOXoDKnkO8VgZUV6/KMP/pkm02m+8fjPbC8A==
X-Forefront-Antispam-Report: CIP:20.160.56.87; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230031)(396003)(376002)(136003)(346002)(39850400004)(230922051799003)(230273577357003)(451199024)(1800799012)(36860700004)(64100799003)(82310400011)(186009)(46966006)(82740400003)(966005)(356005)(31696002)(7596003)(36756003)(86362001)(7636003)(53546011)(316002)(478600001)(41300700001)(6666004)(6506007)(6512007)(336012)(83380400001)(26005)(2616005)(6486002)(44832011)(8676002)(70206006)(8936002)(2906002)(31686004)(70586007)(5660300002);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 16:09:37.4823 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91897b02-8611-4210-b8e5-08dc2f09ac83
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.87];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000047.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR03MB7878
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

On 2/16/24 11:03, Sean Anderson wrote:
> On 2/16/24 10:06, Michal Simek wrote:
>>
>>
>> On 2/16/24 14:48, Michal Simek wrote:
>>>
>>>
>>> On 2/15/24 20:31, Sean Anderson wrote:
>>>> On 2/15/24 14:08, Michal Simek wrote:
>>>>>
>>>>>
>>>>> On 2/15/24 18:19, Sean Anderson wrote:
>>>>>> Currently, when we boot from JTAG we try to boot U-Boot from RAM.
>>>>>> However, this is a bit tricky to time, since the debugger has to wai=
t
>>>>>> for SPL to initialize RAM before it can load U-Boot. This can result=
 in
>>>>>> long waits, since occasionally initializing RAM (and other things in
>>>>>> psu_init) takes a long time to complete and the debugger must wait f=
or
>>>>>> this worst case.
>>>>>>
>>>>>> Support semihosting if it is enabled, as it lets U-Boot tell the
>>>>>> debugger when we are ready for the image. This means we don't have t=
o
>>>>>> wait any more than necessary. We don't change the default config to
>>>>>> ensure we don't break compatibility with existing debuggers that don=
't
>>>>>> expect us to hit semihosting breakpoints.
>>>>>>
>>>>>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>>>>>> ---
>>>>>>
>>>>>>    arch/arm/mach-zynqmp/spl.c | 10 ++++++++--
>>>>>>    1 file changed, 8 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/arm/mach-zynqmp/spl.c b/arch/arm/mach-zynqmp/spl.c
>>>>>> index a0f35f36faa..5af735aa5ce 100644
>>>>>> --- a/arch/arm/mach-zynqmp/spl.c
>>>>>> +++ b/arch/arm/mach-zynqmp/spl.c
>>>>>> @@ -9,6 +9,7 @@
>>>>>>    #include <image.h>
>>>>>>    #include <init.h>
>>>>>>    #include <log.h>
>>>>>> +#include <semihosting.h>
>>>>>>    #include <spl.h>
>>>>>>    #include <linux/delay.h>
>>>>>>
>>>>>> @@ -66,6 +67,11 @@ void spl_board_init(void)
>>>>>>    }
>>>>>>    #endif
>>>>>>
>>>>>> +static u32 jtag_boot_device(void)
>>>>>> +{
>>>>>> +       return semihosting_enabled() ? BOOT_DEVICE_SMH : BOOT_DEVICE=
_RAM;
>>>>>> +}
>>>>>> +
>>>>>>    void board_boot_order(u32 *spl_boot_list)
>>>>>>    {
>>>>>>           spl_boot_list[0] =3D spl_boot_device();
>>>>>> @@ -75,7 +81,7 @@ void board_boot_order(u32 *spl_boot_list)
>>>>>>           if (spl_boot_list[0] =3D=3D BOOT_DEVICE_MMC2)
>>>>>>                   spl_boot_list[1] =3D BOOT_DEVICE_MMC1;
>>>>>>
>>>>>> -       spl_boot_list[2] =3D BOOT_DEVICE_RAM;
>>>>>> +       spl_boot_list[2] =3D jtag_boot_device();
>>>>>>    }
>>>>>>
>>>>>>    u32 spl_boot_device(void)
>>>>>> @@ -97,7 +103,7 @@ u32 spl_boot_device(void)
>>>>>>
>>>>>>           switch (bootmode) {
>>>>>>           case JTAG_MODE:
>>>>>> -               return BOOT_DEVICE_RAM;
>>>>>> +               return jtag_boot_device();
>>>>>>    #ifdef CONFIG_SPL_MMC
>>>>>>           case SD_MODE1:
>>>>>>           case SD1_LSHFT_MODE: /* not working on silicon v1 */
>>>>>
>>>>> Good timing. Can you please tell me how to test this? What's the setu=
p?
>>>>> Which debugger are you using?
>>>>
>>>> I am using OpenOCD with the patches at https://cas5-0-urlprotect.trend=
micro.com:443/wis/clicktime/v1/query?url=3Dhttps%3a%2f%2freview.openocd.org=
%2fc%2fopenocd%2f%2b%2f8133&umid=3D6e1be473-0b3f-4bc4-a4f0-403592e74baf&aut=
h=3Dd807158c60b7d2502abde8a2fc01f40662980862-afc15b07b0f91c910f832185958363=
d84f990a08
>>>>
>>>
>>> I am trying it on the top of the latest git but getting issue with even=
t block and no idea how to fix it.
>>>
>>> # sudo openocd -f /usr/local/share/openocd/scripts/interface/ftdi/digil=
ent_jtag_hs3.cfg -f /usr/local/share/openocd/scripts/target/xilinx_zynqmp.c=
fg
>>> Open On-Chip Debugger 0.12.0+dev-01509-g6d288937cb2d (2024-02-16-12:22)
>>> Licensed under GNU GPL v2
>>> For bug reports, read
>>>      https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/quer=
y?url=3Dhttp%3a%2f%2fopenocd.org%2fdoc%2fdoxygen%2fbugs.html&umid=3D6e1be47=
3-0b3f-4bc4-a4f0-403592e74baf&auth=3Dd807158c60b7d2502abde8a2fc01f406629808=
62-f501ab9aa5516ff666e387e53598fd624398f1bc
>>> Info : auto-selecting first available session transport "jtag". To over=
ride use 'transport select <transport>'.
>>> wrong # args: should be "-event <event-name> <event-body>"
>>>
>>>
>>> Do you know how to fix it?
>>
>>
>> I actually bisect it and found that it is caused by
>> jtag: rewrite jim_jtag_configure() as COMMAND_HANDLER
>> ea2e26f7d521f5755b4bfda7bf12d99650277421
>
> Interesting. I have been testing with 0.12.
>
>> # sudo openocd -f /usr/local/share/openocd/scripts/interface/ftdi/digile=
nt_jtag_smt2_nc.cfg -f /usr/local/share/openocd/scripts/target/xilinx_zynqm=
p.cfg
>
> FWIW after installing the udev rules I do not need sudo
>
>> Open On-Chip Debugger 0.12.0+dev-01512-g214206ebb972 (2024-02-16-15:38)
>> Licensed under GNU GPL v2
>> For bug reports, read
>>     https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?=
url=3Dhttp%3a%2f%2fopenocd.org%2fdoc%2fdoxygen%2fbugs.html&umid=3D6e1be473-=
0b3f-4bc4-a4f0-403592e74baf&auth=3Dd807158c60b7d2502abde8a2fc01f40662980862=
-f501ab9aa5516ff666e387e53598fd624398f1bc
>> none separate
>> Info : auto-selecting first available session transport "jtag". To overr=
ide use 'transport select <transport>'.
>> Info : Hardware thread awareness created
>> boot_apu
>> Info : Listening on port 6666 for tcl connections
>> Info : Listening on port 4444 for telnet connections
>> Warn : An adapter speed is not selected in the init scripts. OpenOCD wil=
l try to run the adapter at very low speed (100 kHz).
>> Warn : To remove this warnings and achieve reasonable communication spee=
d with the target, set "adapter speed" or "jtag_rclk" in the init scripts.
>> Info : clock speed 100 kHz
>> Info : TAP uscale.tap does not have valid IDCODE (idcode=3D0x48e70126)
>> Info : JTAG tap: uscale.ps tap/device found: 0x24738093 (mfg: 0x049 (Xil=
inx), part: 0x4738, ver: 0x2)
>> Info : JTAG tap: uscale.tap tap/device found: 0x5ba00477 (mfg: 0x23b (AR=
M Ltd), part: 0xba00, ver: 0x5)
>> Info : JTAG tap: uscale.ps tap/device found: 0x24738093 (mfg: 0x049 (Xil=
inx), part: 0x4738, ver: 0x2)
>> Error: JTAG-DP STICKY ERROR
>> Error: [uscale.a53.0] Examination failed
>> Warn : target uscale.a53.0 examination failed
>> Info : [uscale.axi] Examination succeed
>> Info : starting gdb server for uscale.a53.0 on 3333
>> Info : Listening on port 3333 for gdb connections
>> Info : gdb port disabled
>>
>> but with zcu102 I am still not able to connect because error above.
>> The same behavior with recording SOM IDs I see on kv260 (via hs3 cable).
>> It looks like that not everything is working for zynqmp.
>
> Is this with the boot mode set to JTAG? If so, you will not be able to
> examine any of the CPUs until you have released them from reset. So you
> should be able to run
>
>         targets uscale.axi
>         boot_pmu /path/to/pmu-firmware.bin
>         boot_apu /path/to/u-boot-spl.bin
>
> to boot a CPU. If you want to silence the above error, you can add
>
>         uscale.a53.0 configure -defer-examine
>
> to your config. So the full command would be
>
> $ openocd -f interface/ftdi/digilent_jtag_smt2_nc.cfg \
>         -f target/xilinx_zynqmp.cfg \
>         -c 'uscale.a53.o configure -defer-examine' \
>         -c init -c 'targets uscale.axi' \
>         -c 'boot_pmu /path/to/pmu-firmware.bin' \
>         -c 'boot_apu /path/to/boot.bin'
>
> Let me know if that works for you.

Oh, and I forgot to mention, but if you are testing semihosting then you wi=
ll need to add

-c 'uscale.a53.0 arm semihosting enable'

to the end of that. I also find setting the semihosting base directory with

-c 'uscale.a53.0 arm semihosting_basedir $IMAGEDIR'

to be helpful.

As you can imagine this is a long command line, so I have a config which lo=
oks like

source [find interface/ftdi/digilent_jtag_smt2_nc.cfg]
adapter speed 25000
source [find target/xilinx_zynqmp.cfg]
uscale.a53.0 configure -defer-examine

proc boot {imagedir machine} {
        targets uscale.axi
        boot_pmu "${imagedir}/pmu-firmware-${machine}.bin"
        boot_apu "${imagedir}/u-boot-spl.bin"
        uscale.a53.0 arm semihosting enable
        uscale.a53.0 arm semihosting_basedir $imagedir
}

which I invoke like

$ openocd -f my_config.cfg -c init -c 'boot /path/to/images my-machine'

--Sean

[Embedded World 2024, SECO SpA]<https://www.messe-ticket.de/Nuernberg/embed=
dedworld2024/Register/ew24517689>
