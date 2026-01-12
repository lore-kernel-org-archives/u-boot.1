Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E58D26D9B
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 10:10:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B8EB800B6;
	Mon, 12 Jan 2026 11:10:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="tzVAkC6H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFDAA83CBD; Mon, 12 Jan 2026 11:10:28 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B1B383869
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 11:10:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F5n+3N4LVmeS+8mPK7OcdnD6xYEYf4+t+bxVyZCplJ+W5s1swtOkOw2cEjEaIISyBYX0InWzIZII1smZTbVHOahWM2JF34hwfcDosZR/PlPLYKlsHVJZnW8Pbm/LDYuVZJeDRfKrkwz98LiDG4rupTtTggkmmG9bPKEezXkZHA9VTTv+EwrtGa9HB36EMtJ4YH5CHmXrHFmNWPmDuln0e6Vvs56IZWbLRCM5H8qCeB/ZvtU4kp81L45ww0j67kkqVjaY4cJk+ll2ULmw1PqIkZ7WMMeHrIH/ap4UgVw2b7mxOrZC6U8arFr8ZYrlCDo88fS2eW28+yCoNPmfIQh0Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RqQZdCztSiuxYEBLcM7QYLlS1ezdY01tQ2f2afkuUoY=;
 b=gk/Xk5E22cnuLmg0+aNXL+JltMm7A1PfjUVZtiv5+pFhB75LUr9S3U9/6+FPLkU0Ksj06VxUI9HVMDvXc9vZE1hS8M7alU7uK7G/ojwyYZOzUkM7GzhToVs/SGmqUYbcoVxGMj1sTeOUlm84d51f7vjeXEx86Hsz5Ar5OxRbIxHjC9Nsv7MGMqmoMg1VFPB2w3Z+4iO8Gfy5Qj8J/LdBVjmbfIXuMeU9F6JxO/bKLnyOR+jGXXPHCRWnNU1/Jp02JlVZhWC2yuJVjJwkOYyU5opbSIDPILGZ/Pgu0P4VqFUZHQRFClDQjpwLp9XM+ls8Xqe0lHOTj+Zrt4jhcCxLNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqQZdCztSiuxYEBLcM7QYLlS1ezdY01tQ2f2afkuUoY=;
 b=tzVAkC6HU4ZzSdhr6Z7xIG1VJ9iZusCJf1NUGwp0dtn60Xk/1Z4YzF3XcmB3Dxevcwt3i1CCQabzyY3rpHn/4U0IJ/wnpYmEFY3ONY3HqfJmCiG2iwQow20XZcT2xf2lxnK1tRUPp9YoxfktsG/5YS7rKSR+Qe56v2ogWzfTu42R7J3MIyWRFzZYhQEsZUMl+g0Yg2CGtTeAC9zXJGrGkn4umxoqjO1Ek3Y8suPOUlADMtmI6ytpnfvCKufA6bBiSy9RG6+OPrNJJDQI0YTIGYGjfyrB3kkcHu/e32h8GGUBepx0Svld1x555IG3H9Jrdqfxp6ovmlfGgu+iin5D7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by CH7PR03MB7908.namprd03.prod.outlook.com (2603:10b6:610:249::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 10:10:21 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 10:10:21 +0000
Message-ID: <447341e8-7b69-459b-8b67-f9d2ecbbeca6@altera.com>
Date: Mon, 12 Jan 2026 15:40:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mmc: sdhci-cadence6: Fix the license to GPL-2.0+
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>,
 Leo <ycliang@andestech.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, oliver Fendt
 <ofendt@googlemail.com>, Kuan Lim Lee <kuanlim.lee@starfivetech.com>,
 Wei Liang Lim <weiliang.lim@starfivetech.com>
Cc: u-boot@lists.denx.de
References: <20260112023948.46008-1-hal.feng@starfivetech.com>
 <ee56e793-1f37-490d-9ca4-c62cfc2524b1@cherry.de>
Content-Language: en-US
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
In-Reply-To: <ee56e793-1f37-490d-9ca4-c62cfc2524b1@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0179.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a9::9) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|CH7PR03MB7908:EE_
X-MS-Office365-Filtering-Correlation-Id: 10544313-9a35-4c10-f0a1-08de51c2cb89
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MmlyaEJRMXdXRVQrVFBqSnBKZFYybjhsMUhkd1ZEYzQzNEZ5U0hRSGl0YUhN?=
 =?utf-8?B?bndmVVhOeURFbit4RXJLQjFsOTA0YnhZc2dSMlpJWnJ4WGFnYlVDNENsb2R6?=
 =?utf-8?B?Ri9wb0l2Nm9SSjIxL3FoWGNIcS9IZVFwbVJNWjhvcXFrSTdrUjRwQ0hoQjJx?=
 =?utf-8?B?bDY4ZVdxUTJDOU1JeFZFZy9XZTY5L3VhQTRCdDE2UTVmb3NlQ3BNdjN4NTJ5?=
 =?utf-8?B?ckhjV094bU9EOWlRRkRmTGh6UWc0SG9QNURabEVWRDRPQ0trZUkvL1NYWlp1?=
 =?utf-8?B?Y25semNaQ0dlOHBNYlVTZjc1cS8wZFhONitBeU5oWHN3bDV2SjdCZnpyTERP?=
 =?utf-8?B?TlRVajQ5ZFV3SXZPNmxmNHpLVVUzYmI4UEtFbzd6VmpPQkFBNS9IUkljemZi?=
 =?utf-8?B?YU1zLytncXd2VFB5S1NocmxVQzNkWXBWUlE4RlF4WXhJUjBjNzVJNXdrNDl3?=
 =?utf-8?B?Z3lLK2hzSUZhQ1QrOU42Y2FiS1lwSmV6Y0IzaG90TU45Z3hYakRRei9SVWc5?=
 =?utf-8?B?Q0txS0xHZTF0d1luaExENGc3SHQ4cGR6NHFrZHhNeFhpcUlJZzBLcXB5RTVY?=
 =?utf-8?B?SVU1azE0dkk3aEI2VnI1QXFhWUNRaG00a05HOS9Uc0tPQ0dER3piNEYzQ281?=
 =?utf-8?B?OENwWHNVOFRwQlNaZEE0dFdxck9DMzEwZldINFptTTQweWd6MVZRK2ZhRzdB?=
 =?utf-8?B?MDFJMmpvYXd4dTY5Y3ppT0xkTkNlemxCV0pidGlacXlUNlRWVE15Q3crNURT?=
 =?utf-8?B?anhDeDZibHlNRm9kTURKZm05b2xJS1NYc1hRU1doVVFLeVlKRmpSMDYwL1dh?=
 =?utf-8?B?TEl3Sm9YZ3RIZFJNOUJ5ZnNvN2lhQmVmNmZLelRxNzYvWWFuVi9mMmpTbzYx?=
 =?utf-8?B?M1E1Zm5ha1QzQW1OdG1rSjl1NXhGVUV3aHJSN0xUZzh6Y2JaSDd2NmhLbVFU?=
 =?utf-8?B?Vkdnc3NVblcvTkJCclVzZm04SXhmRDRJZXNySllDVDdMSThZejg2eUk2OEg3?=
 =?utf-8?B?SExJdU15cmVkeFVNMnpQSFdCVitqQklGV1JXTjhNVzFUdkUzaTVvTnR1c3B3?=
 =?utf-8?B?b00vSmpyeTNmL29WRk5yV3llN2tPYmlnRSt0Wk9aeTZoRFBDdWhnc0JoQXUw?=
 =?utf-8?B?TkNUSlo5K1M2aHkxZGNmaDhOTFAzQUJDWXgycUhrdXhWRTBaMEJkUWVuQnhv?=
 =?utf-8?B?R0w4cEUzMlBORkVQMlZQUktzc0JiNFJzeXFFSzBITERRalh0ZjR6cFI4SU9m?=
 =?utf-8?B?dDR5OEpxd1pzWjBpdE8zZlJsU3FVSWFzVXRYa3RVL0c2MzBCMmc1aVphQi9v?=
 =?utf-8?B?eDZOTUtlZ2xKQnpmb2ROVFhuM3o3NFNGRmMyV1BMemRDUnFaN3VPSGpYZnc5?=
 =?utf-8?B?ckljWktWcjIzRzE3WXh4Q0JYb2w0Qjk0dTBxZWh6NTlGNkpJbjFsMzEyMUw1?=
 =?utf-8?B?bkY3cU5ocktNYzRvcXNKckVOUkRvdi9QTFhibi9qR0Y5dE1lZU9pS3E4UGhD?=
 =?utf-8?B?SllybzZPTkVBQnpuZzFRUndWWXVTbGNxaDE4QmtoRWlsU3cvRjJJRTVXVER5?=
 =?utf-8?B?dlVPSGx1aC9kLzNRUG53TWNkczBqOUdCTzdKcjMrY205cnhnZitzT3FvNGdj?=
 =?utf-8?B?ZzIyeERkMkhrWUtFSHpnTkZ3TzhIMjN5MUhEVDI0U0d3OU1VZTlleE5aRDhn?=
 =?utf-8?B?WUlJbG1haVpDbHowRGs3Uy9sL0xwY1RMR2xzNHJxZjNPM3QxRkkxOFVaUUxv?=
 =?utf-8?B?Y21sbnlpYkRvRlZaY1Q1YXR5bFdzQUhLV1JpMy90SHZRR0RzQzJjM2FJK2N2?=
 =?utf-8?B?eHJ0ZUQ0M2xEZFF1YU5ZSkg0VjZoWFc0NlhXbUpaM0M5SnNPMU95SXJUSzJx?=
 =?utf-8?B?NnlZekRtRllZeVozT0plWE10cS9vRnU0eEJqMjV0d0xYRjhCV1hubzgvU01O?=
 =?utf-8?Q?wqsF0ct3V/vfYCrXpKmgpPZkwkEi3+l5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aiswZXA0UUpBcjVQY2NYY3NlTldjT1ZoOHlNeU9SMFkwMFl4d016cmZrcXdi?=
 =?utf-8?B?ZklFNWlzcFR6ZDF3MmRsUmxEM1R3LzJZek5rWFAxM2wxS2Z6QkRzTGhoT3V6?=
 =?utf-8?B?bmU4WXVtUHpvTjRsYXp5d2N6Z0oyWE5VdWRxM1FvMkljTGwySklRY3NaV0Q3?=
 =?utf-8?B?OUh5eUtmMmJkYWVNVTQ2VGxhVHJyTkVZa1dweFpiU1dxRm0yNlZjbkRhZFds?=
 =?utf-8?B?Z1BLb0k3eFJFMXQ5UUE3MjdkQW9oMXZzdFFSNFB3M2tSRXo3enJhS0NSVkU0?=
 =?utf-8?B?MU9yRmVDK1hmKzdvc005WXNQSDVRWDJnME1FZUhPcVR5UGpsN1Izd05Wbi9l?=
 =?utf-8?B?WnZpemN2ZEVsOExWUGd5dlpqck1nOStNektoNmtaZ0NBd2J5U1BodEpiMVVv?=
 =?utf-8?B?VGJtcFFld1VGZHgwKzg3dXNGWVFRT2JJWEt2N0pxWjE4ZU15bEJycDFBNmFF?=
 =?utf-8?B?bS8zbzlWQU0yaVZzUnR3S2NuN2c4ZE9EdThuYlZjd3R6WVVSQjIwWWxYZHhP?=
 =?utf-8?B?Wit2MmNFcnU3RW1xcDhmcnhqUUczOSthdDF5MTlraUpJK3pvcitQeEM5a3RM?=
 =?utf-8?B?VGNpQUhybDhVcTNpRnZMaWIxbGRXTlZYTUZlMVNIWGE5R1Vnc3kzNXdYZ1hO?=
 =?utf-8?B?RWNDU1AyczRYYk9NeHBkUkVRUXV2L0pxZnpSMEhzNlovVExPb3ZZdW1lU0ZC?=
 =?utf-8?B?Q3lrZGkyaHBWVzlJSU5VTnBXUlpDOFJZWUcyRzU2dVd3VDA4VVUvay9ZREEr?=
 =?utf-8?B?MU9GZVhDRUp6aHB3R1ROQlJ6VHV3NlN2Mmp5bWVCdU5mN25HdmlMWDVsdndF?=
 =?utf-8?B?Sm9sdjBNUk5KSlBuR29mRDIrQnZjTENRaEp0RlJvbFB1VVc0ZjV0cnpYb05C?=
 =?utf-8?B?TWM5YWpHUDE2V2Nqd0dKNzF2YnIyRXpsSm1ySEcrcENxNW4vVG9wZis5Ymsx?=
 =?utf-8?B?bXF4Z1pETDhwcFFnV0U3UVJDY2hKblBld2hFU2cyQnZxSDNiRjk3K1RsSCth?=
 =?utf-8?B?dGdOUzBnQXlzUEZnRi90TGFLV2hHMGVEZU15eW5Obk95QU5RSGwxc2tKY3c2?=
 =?utf-8?B?MTQ4T3BNT3EyaThLUUV2cktGZEVMdXZ6S25QQXB4YXV6MVpJckIzdFprcmgz?=
 =?utf-8?B?WGlFUGh2NjU0VTJiYWNra1FlVCt4Q3dkeHFSRmxmendoMVUzeGlOeVdHK05R?=
 =?utf-8?B?OHNVc2pJWko1NUk3eWt0aC9sNUJaMjMvRE5DS0tTaWo1RlMxMEhoM2loYllZ?=
 =?utf-8?B?Q1JteS94aWxoanVVZk45aVkxV2thUm91Y25nV09QMGpYRG1zTzhkWG9vZC9m?=
 =?utf-8?B?Sy81SkxWbi8zTTJzdkJFZE42V0xLVDZSOGxQV1MyZHFkZTRkejN4bVhVOERU?=
 =?utf-8?B?TC93R0dVTUNmWTBKRmRGcGZZcms0S1Q1bWJwejVNWFRDYXlpQWUvVXJweGJr?=
 =?utf-8?B?MUsyMUJBbHhPRi84Vmlsb3lSdHlreGFkd0h5bmdMNzBTSUVjV3Zjb2Q1UWlz?=
 =?utf-8?B?WkloZVF6K09RMk1GV245bWwyZi9ITVU2QlhBT2tTRTEreGplOWFCVmNlRUVW?=
 =?utf-8?B?L1ZCaExQdmRGNkwvRG1oK0trcS8ybmVNTjRvRlJTZDBhLytvd1BLUVJwSFpq?=
 =?utf-8?B?Wm9ySCtUVVptZC9lL3JPaUs3TjJtUGNiVndHZ0dVOGt0dDFySEdDUXVLMDh2?=
 =?utf-8?B?Y01NU0huc1Z3RHhqVzNXclI3aHhOUzcxaUxpRjd3YkdIdU1TOGVHa1I5QzIz?=
 =?utf-8?B?YnI1OVJHZ1NybDAvM1M5Z2VKcUVrRitTZllaV0gzQUVUWjExczQ0cTlYK2pP?=
 =?utf-8?B?YjVnOHhYWlkrSnYxMmFXSjNVY0FzckdOc1c0Si8rYVJPZlVsdnB5OGlNcGMy?=
 =?utf-8?B?YU44VU50V2RmVHkrajhIeW00RXpqNStCSzVOeUp3TElRekJrU3VQNDhFMS9T?=
 =?utf-8?B?MXU4WWdNL0JVL09FcUMwbHdrOXlKaGF0VDZkVTIwZG5lSitTNFhkWExNdElH?=
 =?utf-8?B?dFZoSlRrT3FLYy9nY0kzQXQ0UUh2alNLcU43Y1RwZTc0RkVySmRhUW5DZThq?=
 =?utf-8?B?b2JidTdwNnZlaWV4THB1Q2hlQjI5VllwSVZjRUZiVTZnSUhUa2w2MmJ3ZTFM?=
 =?utf-8?B?NkNHZktZYml5VVNzamF0bWViWk5nYk5Gb2haQXdFeWxjYlNiNVVKQTU4T2F6?=
 =?utf-8?B?UjBnSjVIQm1XRFgwVHBsWGJHaXVNZ0g3MDFOZmpvZnVXRkJIVzVWY201Q3JY?=
 =?utf-8?B?MXVwcWlNQXkrbGlnbGVjNlBvdjdnKzlCUG0wSEdmSlFNRlpwYTEvOThLU1g1?=
 =?utf-8?B?dVFTNStNRmJzMDdnREs4WUU2WllZNkJOK1ZsaTduOXh3MmttT29aNGhqbFJs?=
 =?utf-8?Q?CxX4cu0ZLDUyiTA4=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10544313-9a35-4c10-f0a1-08de51c2cb89
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 10:10:21.6763 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WTAVOVy7AtZxOuLDgOUkKYv9/vgh8I5sPFNW9/8X7RNfhRfE24XWeYptNkTWxf27uoAgP4sFymZlO3zT9AUw6KUND8PIpdWXE2JHmjX3qkA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR03MB7908
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


Hi Quentin, Hal

Thank you for including me in the discussion.

On 1/12/2026 3:11 PM, Quentin Schulz wrote:
> Hi Hal,
> 
> On 1/12/26 3:39 AM, Hal Feng wrote:
>> The license of the file is not valid. Fix it to GPL-2.0+.
>>
> 
> This matches the license used in the header file added in the same 
> commit (see Fixes trailer).
> 
>> Fixes: fe11aa0b8ca3 ("mmc: sdhci-cadence: Add support for Cadence 
>> sdmmc v6")
>> Reported-by: Quentin Schulz <quentin.schulz@cherry.de>
>> Reported-by: oliver Fendt <ofendt@googlemail.com>
>> Closes: https://lore.kernel.org/all/ 
>> CAFoF8fC4foffYJgYm9CkViET83gDu05noVRxLxgs+KWXN_-LBQ@mail.gmail.com/
>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>> ---
>>   drivers/mmc/sdhci-cadence6.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/sdhci-cadence6.c b/drivers/mmc/sdhci-cadence6.c
>> index 91a245aa490..ca1086e2359 100644
>> --- a/drivers/mmc/sdhci-cadence6.c
>> +++ b/drivers/mmc/sdhci-cadence6.c
>> @@ -1,4 +1,4 @@
>> -// SPDX-License-Identifier: GPL-2.0-or-platform_driver
>> +// SPDX-License-Identifier: GPL-2.0+
> 
> Would have preferred the canonical version (GPL-2.0-or-later) but that's 
> good enough here.
> 
> IANAL, so I don't know if we need approval from all contributors to the 
> file. Fortunately, there's only been one outside of the two starfivetech 
> contributors (whose mails bounce), so adding this contributor (Tanmay 
> Kathpalia) in Cc so they can just provide their Acked-by/Reviewed-by so 
> we don't have to find out.
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Thanks!
> Quentin


Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

Regards,
Tanmay
