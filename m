Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC95CCF9E3
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 08:00:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B178E83AB4;
	Tue, 11 Nov 2025 09:00:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="MKNJX/gT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1722983B27; Tue, 11 Nov 2025 09:00:39 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26B8C83A79
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 09:00:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/QmGqjO4EZ4DR40Ez7nz7zrfRlG91TI+0FxDk+iudOoFIn3aYh+doil3P3BZ3DVX+DR/IDWMbiDJYR0kPrVyVvgTSZOmZZKXNssvZa3bwnQU1wEMtyGRiE49VraiKYfSOGed4EeQA2BXNGADo1X0xZIGarpbmvMtfwA68cc7wqUkSaluDLJUIBThWndENAVFGkhN3Y6ulPqjLz42Ghuunsllng1rN9qoWw2i2b/nmcUyyOnHo/qs39fUnJPTDwNjTgn/CXanpy88T1e10ytDRBeqy+MobpbakE58gqNWSO057ILdo+Iq4BAMOLWzlAHWRDhBaGErQr2e4lVnyzyGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9oQ2neCVwftavwJ1+bLgHj1Iyx16XFZwNv8tmNSSYU=;
 b=KKDc4076lEnJeNZkBPJgPUDbT9FVWwsn56HUizqFRKmChozapM4zZA73+ghTSYztesL0qvGDnv1pc/GRxXGeNwCkElLx3MG5/q2Q34RygamMIKey+G7XoxDe/qSIrgK5rl9yLgb1zpdN2rWs+TJAqFiH96fF9TQVuePTfnkmIjFdAFl2kzy0kfTr1iCgLBzYySIp0uSOBrKftr/UYZ50oAgocCUsFhbZf1+06k+D65oBQM578MBwqz9tS0JPY98Pllpx9gmNsSY/YXLGpcD3q/EL+i2VaeFzHhAVp9h0WoTJzht4jizvmM0KyWGN7iLV/Z/Yw7T0HIFhlN1Ia+TCTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9oQ2neCVwftavwJ1+bLgHj1Iyx16XFZwNv8tmNSSYU=;
 b=MKNJX/gTOzegRdXxUpOgbdSLO2ziDQAlH51AoIM5PPpNKev3fijBdF9hAwWAXf8vozLOJOLZg8GAAPmVt2qKit5cildJw+I0lL6C42oFcg1bAbeJWeWciN/6urOubeU3Gdpe7HS/icpgM2gJ+MKWm4wzSJrea+hgrBXFnn4f7Rk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AS8PR10MB7042.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5a9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 08:00:34 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.9275.013; Tue, 11 Nov 2025
 08:00:34 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Anshul Dalal <anshuld@ti.com>
Cc: <u-boot@lists.denx.de>,  Quentin Schulz <quentin.schulz@cherry.de>,  Tom
 Rini <trini@konsulko.com>
Subject: Re: [PATCH v3 2/2] cmd/part.c: implement "part name" subcommand
In-Reply-To: <DE5M6LMZV9EI.NS7NVSZR63W9@ti.com> (Anshul Dalal's message of
 "Tue, 11 Nov 2025 10:55:49 +0530")
References: <20251110205411.4075351-1-ravi@prevas.dk>
 <20251110205411.4075351-3-ravi@prevas.dk>
 <DE5M6LMZV9EI.NS7NVSZR63W9@ti.com>
Date: Tue, 11 Nov 2025 09:00:33 +0100
Message-ID: <87cy5pc82m.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0029.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::17) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AS8PR10MB7042:EE_
X-MS-Office365-Filtering-Correlation-Id: 26cd12ed-58e4-485b-b9dc-08de20f864a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WXK/9izyG2vezjcMwx5bfj+KkulFHW37msvtt0dqTLdIcLuv1nHu7NG/ed1X?=
 =?us-ascii?Q?P6jSVkMHF/GYzp8bXmEBcVJhJXMxB7vXwctkFANcGd2cO/xwyFCpl/aprw9d?=
 =?us-ascii?Q?/nJ+nqDsy0DHQ3f+6L2Xp+VNBLrcf78rpC/QeodfR6pnWW7JfWzSWst1ZV1/?=
 =?us-ascii?Q?LBGVNbdS7FNN4lEbYaE0xGF1oAlanrdOsWpRZVofeFqMTgrhlNpIwKoH8PYp?=
 =?us-ascii?Q?ltPNoerWsT0QR1rc8qiErgakXnq32QN4Kt25nvwPq2Lajh2ZpmV6l4CtaV6Y?=
 =?us-ascii?Q?4dDvYOB8ryBFeJD4SuLomprkqcqhCoV7g5uIeFPNc9ma/eWHpede41Vx1A48?=
 =?us-ascii?Q?0W4G6GFHIQwCZOpn6EAPqW9JpLUE1DyAbUDCdBLZFNNmzwLdeSCVnSyDUntq?=
 =?us-ascii?Q?4LyGVYzrKkH+bforOAU+AUGWegYkVjmXjM95NNP2qcvE70D26FN1s8jom98z?=
 =?us-ascii?Q?mTsXcotdenYUqQ0bf6oLNNtzyG1FHlCAIdPV/dtsWHWuxqyszOmH4nv32WC2?=
 =?us-ascii?Q?qOFfTnuPzpiyNLfLLaUgFHscDtRiNoOcODzCM9rE+9sMHmmNsXOHrHr/o/rk?=
 =?us-ascii?Q?QmtLtCvJ9Ke9r6UjtHMlv9lP2q8E7jjah0ylWp2imCyIHS7kzbudQtRlbQYu?=
 =?us-ascii?Q?ijS6DFphOcTjzhdTiVholGcE/Y0AJ1LLkXSFw5IcuZZMbM2X8B4U8P+iyHiX?=
 =?us-ascii?Q?DvRCTCyCDqnyVV0cVwcQiMB/YRLONKhvS8fLfLu6+1RzMPQD63Xlxd+Rpyk6?=
 =?us-ascii?Q?hBypZP97cioU/pTZmKtkJSYTURVfG6d9dBdj4wdwndvAlCfopThDQxPqPhre?=
 =?us-ascii?Q?IgtEPErgRYkK8j+SmWboxI8iC3intXL8AuV1vbXD1gni+ALrbwwwb0bKD3rz?=
 =?us-ascii?Q?AekF/EDGmU8+Bjh4GnrhAJwAzP4XU/cU7TFaf8IaGWPYVTlUYzq8w30fofF3?=
 =?us-ascii?Q?oITPE0bIrkRA7YjPsliZElWh60EDggLgAwGEU2XyXHycIRe55iPvbB7LS+tk?=
 =?us-ascii?Q?r0jqwpluxY+BAaQQAkU6kPVa2oFOC9/ZTzXVshOvTID+nWPGXs9AC7QNlY7Y?=
 =?us-ascii?Q?Q/hqs4rCeMyswNAFHJfqTRQCeeU3hLJCvjg9kifnaTvRfpWuz3N1Kp4T3c4c?=
 =?us-ascii?Q?3efnL1x0mhv3qqTUhTCeDVP7sBs1QSNBUQvOKg9MOBp4RkZyfMHBKUyLVOuL?=
 =?us-ascii?Q?7V0cDVxajxloV2JV+pvUWLc/GNtJRByrRQnmJ1MEgrL/wUzV/Pr1yEYQkyAx?=
 =?us-ascii?Q?ICQO2XN/Ek6yTCrhKhFBwC4saZDdFRWsEPGn7mGceZ3P0gJAMpIjS4sbp2j9?=
 =?us-ascii?Q?vEu9GY1f/MLgzLTyqHluOwtllmUY+/5aKeOn688ZZLknjOMLJ11H9OMANx1m?=
 =?us-ascii?Q?/ZAu47EdZuJe77azw2Jp7fm+dZFlNMCnMN8hpLEbRqR00s0RhK0ROuOMBO4n?=
 =?us-ascii?Q?dqO36taushZUNUbT/8rfCja5sXU5lCnF2ne/3LFVI5tB1VEFFUCXj6+XbCWo?=
 =?us-ascii?Q?DRLE/8KYwj+2l02/1BocnVhjcuKckxdLvaxn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U7jhtwqc6u7Yt7BYGM+ibL/KulVG9dmjQ1HNqzQVke1WYi5Faqs0rybIpYIe?=
 =?us-ascii?Q?9wIdXsHbsc9SRTbwH8XfZsqWNrf4m+3FeI3fNklxQ4pVbQxtFUwTCPW0QvuL?=
 =?us-ascii?Q?wVEMB3pFuklaednA1qQ8S63uRRAsOo6gQ5kuyMgV2663/X/zyRtN/LDnheoW?=
 =?us-ascii?Q?BvNkTMu4N3/LDsTEGdxwFDXHidRytW04CYWV5TWuW5PGSwlVNi88Tt7PZ5wV?=
 =?us-ascii?Q?aZcJWBS0bnIr+HO/7URIO0jX/cnY79nS8y60tMbCDXFjRDkYa6KbQ6lbN0hn?=
 =?us-ascii?Q?a0Z+IreAg8JcZ9UXwgLI3RYwy7DcbGQvSGCkJ528Qgg3zdJVykbURulNiaqD?=
 =?us-ascii?Q?sbYPxI1QslvtGAkzxx7tF7CW4uqLDdey0izAyZwJjFKJq0Ph2XnVA3z43JpM?=
 =?us-ascii?Q?BV/A11YWyKJzTwB5j3krv21RvIxXRMdzlpqAMqimaI3q6dHzSXvZ36S1+Elh?=
 =?us-ascii?Q?ngKuETVcHUNGG0Be63tyHUq14UPgW0u8F0QMZoYRD0+32pXjdvOOJs66r5Yy?=
 =?us-ascii?Q?Y1sT+TAMzPwlnKydcWBXPe5N5UzysCULEoNM7VYc+geyVmwbqfofNYobXpsb?=
 =?us-ascii?Q?M9iI+PYvro6smz7I1o9esOI1lxjEmmSOsXGJkPHQC/2xdLgoPEP92+Kscou3?=
 =?us-ascii?Q?kgKJGDBgZNqm50wbZKujna0X+EmUeIFitZa4OY2+rXmW9l4Kqpw85rTIm7/J?=
 =?us-ascii?Q?0/K9UN1U+x+LKt13fCcA6rV3T00hkPvf9tpSmSmrFM2C8+cQeMY0b0WhpvZD?=
 =?us-ascii?Q?Lcq1QJqIT7puZvHHFarTfmr6Gl3BzMTdUeMHlC/xuEzkvVe4NRoTW5ODx9g6?=
 =?us-ascii?Q?f6NxnIL7ImeNMBP7fE3X0MxotAKZfkcwmgN3fGjxMOS31ogu9GyAMtywP74v?=
 =?us-ascii?Q?5zaz8vkjZiBJDzhQw05z3TZSRR6CUxb3XnRkME//P1nS59L/0WqqwsgTuLtb?=
 =?us-ascii?Q?5OkR5kV+3L1Bus6DNtWndl7XatRKPHeqex+pouREex3zK4QErsjFkHlaJKig?=
 =?us-ascii?Q?TmtyFI9WBeydLOD9qBYqFJl9QkZrFaJrTKXjaNy3L/ZFpb/F7orPr930u8cG?=
 =?us-ascii?Q?38+w3S/SE0WD8AlvnYYGN4yXcrIi0OfjCFsZXxvHPZa/8ePtcM0Sf24olNhz?=
 =?us-ascii?Q?WEsW2FwbEmw+vXfkJJvIi8FN/YH8le1k5JzgIYI4FxcsU8cExaNQYDWmDCeL?=
 =?us-ascii?Q?HqagD9m6BF12fTuzX/Beby8EChKrp4a9blATrjceY8EtCVRgC7k2n/obKeVF?=
 =?us-ascii?Q?ej8fVxpi5tGdXsuhkcaKde7fuLC5s4DOd97P3j5hPEwa2eGid4A1L+IEKZ1z?=
 =?us-ascii?Q?fFRv7rl5j7h3JrGXaps1D3Ke+ScaAzBhK3NO7AxOK7S83tE+jFSzcJUYS9LJ?=
 =?us-ascii?Q?uBFo4qKN3JblHafDaUlijcs83Rz1l1B6v/DAx2d6RZQeLyCj5y84wF8OQgpJ?=
 =?us-ascii?Q?St/7dy01T8wwBwfIQKO1Pau8UtkGia+bSqa+l1VAs8IzXnuJZt9sXphsbU1G?=
 =?us-ascii?Q?o99tmR2lmlHtzsMcR6ExZ2tZbmhBEkD+Wihv2xgwrAyd4HAnRqaT1Jmihm84?=
 =?us-ascii?Q?hVK67hX2XFt8uk2pVP7jMpIf0CZPY/bSb360xuipmiY+jOqx1W7VnVb/Z1R1?=
 =?us-ascii?Q?cw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 26cd12ed-58e4-485b-b9dc-08de20f864a1
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 08:00:34.7363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DNQtHX1SN9zj71vrIvYHkeCiMFgnUbh7hPlqxPM1Nun4/0hUi2xvz7ZwWTuo+xZl9TjEDl2QRam6DuUDbD6eaZheDJuMDiSaSxo9hHo4i2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7042
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

On Tue, Nov 11 2025, Anshul Dalal <anshuld@ti.com> wrote:

>>  static int do_part_set(int argc, char *const argv[])
>>  {
>>  	const char *devname, *partstr, *typestr;
>> @@ -273,6 +282,8 @@ static int do_part(struct cmd_tbl *cmdtp, int flag, int argc,
>>  		return do_part_size(argc - 2, argv + 2);
>>  	else if (!strcmp(argv[1], "number"))
>>  		return do_part_number(argc - 2, argv + 2);
>> +	else if (!strcmp(argv[1], "name"))
>> +		return do_part_name(argc - 2, argv + 2);
>>  	else if (!strcmp(argv[1], "types"))
>>  		return do_part_types(argc - 2, argv + 2);
>>  	else if (!strcmp(argv[1], "set"))
>> @@ -305,6 +316,9 @@ U_BOOT_CMD(
>>  	"part number <interface> <dev> <part> <varname>\n"
>>  	"    - set environment variable to the partition number using the partition name\n"
>>  	"      part must be specified as partition name\n"
>> +	"part name <interface> <dev> <part> <varname>\n"
>
> Nit: Shouldn't this be part name <interface> <dev> <part> [varname]
> instead?
>

Yes, probably, I did notice that, but I preferred being consistent with
the existing cases which also do not indicate varname as optional.

Rasmus
