Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E51CAC59A
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 14:25:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55ECF835D0;
	Wed, 17 Sep 2025 16:25:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Fn+xCT0p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95DF4835CB; Wed, 17 Sep 2025 16:25:41 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19A40835CB
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 16:25:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rB7XH3u+hGCI/LzjM5cDoVq3YojgUpWtd/jj+FX/QS4ZPdd19IHFN5P8Ms0NQvcOQBlVeV9LzD2ywPtSmfIBYKVSn5+uovhVI4cP5j5V+iRtlm0J05sCnyN8Ii5PXRRHa0B+WbUv8KGIzqZRiH4ZDnuNsHUi7YpnqCbZxLdOJaJ3otiGO6A/nQgBq1vKoU0KKih4StBhmj6DTPX37IYvh8ILbZQaMY55iDp+znQSKCYVjWWH7rhkURVQAqdf4Z/WzkEBUGDJf6JiHrjmnwVnXo22G5GmB99fhwANC1lUmn1Lt04ztzz580DTZs2p3nC2GO/J8dEdE1lxd92HbWFk+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bZbe7H/3rTwg245p7sRhH9uQzUFC3IyTFmnJNz4Oe1w=;
 b=H21ct586en4nHayK3G/X0HVSpgSv4IqoA7OXhBGEhFEryUl9pMTQMy0GSDV18D7OtCAi787GFSk6AKsODoPqUP1Tr75d/2rfKsXWiWm78KX5i+Fme+AffBNkpuhqmsl8+qoa6VKnCrcHWIDVpkd2NgttcxDe49FsD9xOGNXq4romjOg62iZ8uRXUM+sS3FnU0uXz03vreWoV9AAxFUKOCC5WWIGOaA+pKh+lN7XIsAVmUZEGLzswWLDfB+oLGhANx1tQo7cUiO3SOwOp8hdn2oAoK0WrsyZ0nnBG5HaQf/cbzYOe7vr4B1PLhBEAH2BhY4JQt54BNEmnypSnCxLYZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZbe7H/3rTwg245p7sRhH9uQzUFC3IyTFmnJNz4Oe1w=;
 b=Fn+xCT0pUN/PVHbG2g83WTR2IrAIoGYrKZpWbNkhgdWgRIKeAy8KUUlXnCn0YCeCUWqQ4SHkFO59bEB9FL4LGcdxO1QHbVMpKv5KSlMxQTF14qSa167xVQ7pXOsE5wVHPUR9JlnVyVlakPYt/VqTXwMoIRUsHXlN9mjEjwdm3iA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS5PR04MB9730.eurprd04.prod.outlook.com (2603:10a6:20b:677::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 14:25:37 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9137.010; Wed, 17 Sep 2025
 14:25:37 +0000
Message-ID: <a74df246-2e53-4c73-b545-58ca832f7d83@cherry.de>
Date: Wed, 17 Sep 2025 16:25:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "board: st: stm32mp1: Clean env_get_location()"
To: Kory Maincent <kory.maincent@bootlin.com>,
 uboot-stm32@st-md-mailman.stormreply.com, u-boot@lists.denx.de
Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>,
 thomas.petazzoni@bootlin.com, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20250917141736.59732-1-kory.maincent@bootlin.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250917141736.59732-1-kory.maincent@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::14) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS5PR04MB9730:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a4fccd9-a5a4-424a-71b1-08ddf5f611ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aFlNY0xpZzk3THpRaHJ4TlRlYWJQWnZQcXZSbDUyMXVGSmk5RnFTK3V5UFdR?=
 =?utf-8?B?VG00NTNaRC9QWWNQR2p2Z3o2Mk9QQ1dOKzVzSDk0OXh6SkxMWFcrVDJMNlVV?=
 =?utf-8?B?bmx2SDJLeEJreVhlQ1Q3ajF5clFvSlI5QjVTWFc0Snd1TklxcWJXZ00yblRr?=
 =?utf-8?B?SnFOajhuSS9UbnV1MisxMUZiWkZKU2hST1pkeHB3N0ZvTzVxOGdwNkxjZXpF?=
 =?utf-8?B?UnhwMnk1YUNkNzVaNEp5V1h4SjA3Mm1JU3pETW9ocFFyR1BVTm0rb3NLQUcr?=
 =?utf-8?B?SVRjYUt1MFZuaWpGZGxVRzJYN2RZd2UvVVNSeDJ2NVZ3ZEhtbWZOMms5WXhR?=
 =?utf-8?B?Ti84eVFUSmswWndJVE44UzhtelVrVU1PYWRadDErT3VVVHk5UzVaRmFOYW5C?=
 =?utf-8?B?NmJ6OTdFa1E4RExDMi9IYjRGSEZMV3RnOUxHMEt3ak1CdGlvTXV6Q1N5cW54?=
 =?utf-8?B?dFdEaVBBWkxjNXdkS0ZaNVpNb3J5cXBldkJ6cXY4dll1amU3VEtMbkp5YlNh?=
 =?utf-8?B?WVkvTE9CYjZhSmxlL0tBS0VObXczNmtMeWRHamxBMmRFbE5waEFwQW1DenBz?=
 =?utf-8?B?Y2labGYzQWVMTkp5c1FRT3l0RzJGb0loeENSVTBNVE9EZHJudjZaTDdLaCtV?=
 =?utf-8?B?ZWx6ekk5QkI4SmduR1VsdjR1V2VOdEVCaCsrbThUZWV5K3lvaXZhV0RiY2xB?=
 =?utf-8?B?TExoUklIbHJtYS8xdmhKSzYzUFc4S3RIb3hib1FDRng2cldwOXJpREUyR2FW?=
 =?utf-8?B?WWpRNTU0S21CTzRXdGJQZ0xUelc2cTcvOXhNOXFhUWpUdUcrODdjZmlJeHNz?=
 =?utf-8?B?ZmFiS0lvempmbzYvYnJCQ3pCSStkM2xaWVg1ZHlobldTU283dXZndW5wWDNC?=
 =?utf-8?B?WEQvUDN3R2JCcnhzSDIvU05EQUZQc2ZFeGcySTVCMzhGUmxENE8xR3NNNVk1?=
 =?utf-8?B?SE1CZlZjYndmYVR1d0RzdUdFMlZMY1NJdWZtdVAyRVQ1Mjd1eFdqblZTNUVj?=
 =?utf-8?B?RXE2NlJzclBPZ2lDTlliMVlyQXNEM3J1K3pmOWlZeWFCWVZxZUFRcnZPL3RL?=
 =?utf-8?B?ZHI4UHkvSG9CYW9rUnhUYVJSeDIzWllIL0NMMHZMaGw4cFU2QVBBaGk4UGlx?=
 =?utf-8?B?NmVKYzlZTjFRYXRKOUJ3aTRJdDlWTjVwM3ZUbm1pV1luVG5EcWxJcEIvUFBp?=
 =?utf-8?B?VXQrRVR0VVI2V3pZSStzTnpMY1Bqd3JMVXVMdVZQYVdMSm90WWRjY0NldVoy?=
 =?utf-8?B?UDBKNlJtTnk4SjhKNDdSOFIzc3hHTU1NR0JqakorTTZtSU5wNU05b1NSWnEr?=
 =?utf-8?B?cVQ2Q3IrRW45RjF4aHVYYldZOGd0QUE2ZmU5MjdMbXF0ZGx1cWhSdDJSWld6?=
 =?utf-8?B?MEphOGpqa245WGtmdTAzOTdlMDM4TldYMUVyajROSC9ZWEFmSWVYbkdrTXVz?=
 =?utf-8?B?T3RjbDN4NVoyWlRNNFhibnBaYVJLcmVqc1ZXL3UrVm4vTHpIWE54NjVzREhN?=
 =?utf-8?B?cUJyYklOZHQ3WTQwSis2d1JYSkhoM0d5TmVzWXBiYWgveHdGZENDd1lqWm5T?=
 =?utf-8?B?TzhXSy9MYStHeWd0enVMbkluaXlJVUppdFdzVXJYWXI4VjJPSEdzU1daYjA0?=
 =?utf-8?B?RFN0cG1RL0J0QW9QZ1lMcGo5eStsb0g2WW53WkNMYnJWTHZ5S04zTjhjRVhw?=
 =?utf-8?B?cXMzUzFIUVhGZVdhcFB0VFkwVTlPTHdoZVZKU0NHeEFyenFzcXFINHNpanpJ?=
 =?utf-8?B?U2FoUDVFQTRndnZtaGNGd1h4V1hTZElrekRzSmRyU0szK2xRQml2dWhXb3lU?=
 =?utf-8?Q?wprs9kVeCwMs3FTlUnWflgkb/VLxLObzmhMQk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0QvM1lPTS9VZ3JZU0lqRUpnWWs1dmZ2bEFsV21jQyt6eVh0TWtUWmpOZm1q?=
 =?utf-8?B?VzQ3blc3RXhWaDkvWVBRZ3RObkp1SHI3QzNIdEhSZG92VXBYUlBrTEljblVJ?=
 =?utf-8?B?L2FmY0h0dzRGV0txc0hCODhxZnl4cU1vd3h5ZUo1TW1rdDlpY0hsV3M2VTUx?=
 =?utf-8?B?SzNrL3FoTjB6NzYxVWxJQVluNXh2bHNBdm9Ub29BK2QvSUNuNGptdXl2bUc0?=
 =?utf-8?B?cElJeG5FRytzcDlxYWc5TnFlaC9SemYyZmVSKzF0eXRobnF1NXdlRXRFZlJr?=
 =?utf-8?B?U1pOQm5xVnJhdTBoQTd4S0NQZFhuQXd5V2UxVDFUUXZzRjhtWE95VFlwdEhj?=
 =?utf-8?B?R0I0dU1TY0VVckw2Zk1YbDVyYzllOHA0aEdhZXVwMEJjekhHSllNTmxBc0FY?=
 =?utf-8?B?SVBIRm1qNmxSSm95UUdmZkRmWEs0YlY5TVBtUWhOamlpSTlpNGRyaHJaclhT?=
 =?utf-8?B?UGsvRVZrUVp6Rk51L2hqallyQWRSaW1Ya0hBQWw5a0lVLzNaYmdGWW5YZEY2?=
 =?utf-8?B?OVYwZWVaeDlCTmZKYmNQNHlZdUJuRFFWbDRjZFBLZU43dXJPSHFXamV0N2hj?=
 =?utf-8?B?UlhkdG0xQ0dCZUN4ellxS2tweXVIdUp0RmVBalJYTGYvZXZ4QjBMUk52WUZ6?=
 =?utf-8?B?RDVPV25yMnI5UmlmTkRQMEkrWll5MnBBQnVNR0dkd1FJdHB1UVJLVG9lTi9z?=
 =?utf-8?B?UFVjOEVvZ1gwL0UvV0I1ejFSSWNnRmRwZnozZmhURlpncXZCSERST3VkODBn?=
 =?utf-8?B?cHZqblN3MWNFL3drWVM2RlVEK3NXeDV1Y0M1M1I0SXJsQTF6enhmd2c3RVpB?=
 =?utf-8?B?NnpkNVJpalRnbGJJeWRtemRUaEYyckRLd09Ub3NmYndjOGtzWDR1WHU5UUk0?=
 =?utf-8?B?WGM1WkdydXNiYjUrUzY2ZlEvb0RkajRKZWVGME5UVFdkMEJUVDR6Q3YvbzBT?=
 =?utf-8?B?cVUzdG8vdEZPdFJlcllkRlkvQXJWNitzQ1Y3OGtjcW9DQ1AzeXNlZGhkWVRR?=
 =?utf-8?B?SEM5MkJibWdkYVBEQ3lIOU5kUlBjVCtYcnh6TmZ3NXpzQ0VrT2U1MzI2a1JU?=
 =?utf-8?B?ZVV1VnpBQVQ3ek91cVlLcUlOSWx4djRzcC9kbFE3MXlVYyswVUNRNEZ1d3VE?=
 =?utf-8?B?ODM1K01SNzBJZVNGNllBS0JVa2ZxU2xqWmwxZldwV1JoRVNnT0lYWnRzc1lJ?=
 =?utf-8?B?KzVEODZUbGQ5aCtHaC9vODVrNStsSVVuK0lhZHFLVnU1V1ZWcXVNYnVTdGhk?=
 =?utf-8?B?V1Z2TUI1SzZCU0xXakRveGhhRi9KdVl3T0R6MnhxOW8vZE4xNmpjSXhkMjAv?=
 =?utf-8?B?YzBGcTNia3l1cncvV0VaZVg5dkJoTzZGbklKVXBNcTk1UFl2QjZES2ZJdHB0?=
 =?utf-8?B?c0pGTDBhdld4YldoSlM4elJNQUV4VmVVSUc3MXpCNmlnc2g4VmVpMGlWL003?=
 =?utf-8?B?STlhb2dkOHhwWjg5eWdlNGxYZ3pCVWI3MHAzcHp5a3NZRndpdUUrdWJuNjlD?=
 =?utf-8?B?b25hYi9rVnphd1o3cThrbldjYjhZcXNsNGMyMlZRSXVyWldlWDVkNE5zVW50?=
 =?utf-8?B?U3I0WXptR2p2M0IxMGppaGVMY3ZFTzZrUlhpVW1CSy9TMUdjZmNqaUNKU29n?=
 =?utf-8?B?aE5DWFkrc1YwRjVmNGZLb2RoUDVnM2x3aEpZa09Ld09aK3ZoL1piUUpnYUZ2?=
 =?utf-8?B?SVlsYVNGU09URTdxWWY4MzdoUSt6WWtzUGtHSUpZSlBwMVhNdTJ6d1V0YVFw?=
 =?utf-8?B?Vmtab2h1RURSOE5pZlU5TEZBc095RldtWWcrR1huenQ1OG5RbVlNb2tSNzNm?=
 =?utf-8?B?L1BYUGdHaHJZVDVNalNDRkpVVjV3UGhtc2djL2J6NXhSOEVkL2ZNeEc1bkh4?=
 =?utf-8?B?cHpCME9MK0N4NmFjVThFZklxYndJemhQQ2h4Nmc1N2Z5NTJBVUNCMjdIVngz?=
 =?utf-8?B?ZGExa3p1S1pVd1NkajdTUEVUb0Y0R3dNRmdQdS82WWw4SUxWVjZuMXl3TENQ?=
 =?utf-8?B?UlB4TzdVWnBqUzNqcGZhLytUcEQ3eVNvOEtGdVVDS09OZXJNUi93Yk1VdU9J?=
 =?utf-8?B?VHhYemRSZlExam13RkJpZ09RcTdNSUZneDM2dnRPdldjMHdIR215UkhKNUpR?=
 =?utf-8?B?aHVPM01UYkN3MkdJK0VXd2NEVzlXelJYa1dERWphdWVZdy9pSDA1MHBGdGl5?=
 =?utf-8?B?Smc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a4fccd9-a5a4-424a-71b1-08ddf5f611ba
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 14:25:37.0474 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JSpjlfMYhJJO6y8EYf9tNsKE8e/EHpyYSekLyLPx0xNSQez2VPC4b3mN4kBNv88hxF07eJMo0U46vM87NUkrvzqv+hmJT3CkBvTsPjmcZ9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9730
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

Hi Köry,

On 9/17/25 4:17 PM, Kory Maincent wrote:
> This reverts commit d37641c61ba212241c38e3fd22f0335fc0bebc96.
> 
> Restore support for environment storage in EXT4 filesystem on eMMC boot.
> The previous cleanup incorrectly removed this fallback option which is
> needed for boards that store their environment in an EXT4 partition.
> 
> This configuration is OS-specific rather than board-dependent and should
> remain as it is configurable via menuconfig. Even if it is not described
> in ST defconfigs people may have enabled it in their defconfig.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> Debugging this issue raises another issue that need investigation.
> If env_get_location return ENVL_IS_NOWHERE but CONFIG_ENV_IS_NOWHERE is
> not set, U-boot stall without any log. There might be an ENV check issue
> here.

I believe this may be related to what I hit almost three years ago, see 
commit log in 
https://source.denx.de/u-boot/u-boot/-/commit/b1f1b4a5a528eeefea283ccca2ee9777cb10c840

"""
since arch_env_get_location() is called
by env_init() which is part of the pre-relocation process, a valid,
non-ENVL_UNKNOWN, value shall be returned otherwise the relocation fails
with the following message:
initcall sequence 00000000002866c0 failed at call 0000000000256b34 (err=-19)

This valid, non-ENVL_UNKNOWN, value is ENVL_NOWHERE which requires to
always select CONFIG_ENV_IS_NOWHERE otherwise this work-around does not
work.
"""

Hope this helps.

I haven't dug deeper than that though.

Cheers,
Quentin
