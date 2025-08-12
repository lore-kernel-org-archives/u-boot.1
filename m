Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F8C4C87FCB
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 09:47:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF7EB83303;
	Tue, 12 Aug 2025 11:47:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="LvALg5t8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 573558331B; Tue, 12 Aug 2025 11:47:07 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 553F1832C8
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 11:47:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bkY3yOQUdi+BEF050oVMfBmqOGRae+w4ILKXIelQ9xxhoB4zdU4sOvzXWGHp8szYiXIjWHqto1VHy+4ms6Dnr8etPCi8hZF0RgQzSTjVu8MDykGeQ7ENhmSlIwklY4yXm2Fx90mutVrW7/1gTd8V+awZ4J5EkeoZXqRO3JvXNsRGilZVzTfe9kJB+o/brxwUJSgOzoKWgtHRdvwBaaGMcNYArvXRWXHW/Fdt7DjoDcHbvcNppkg3j4Gme4YDYqWGODBm8CPZB0hSxjPfTxqfnQL0cDLccSHKSaiPakuQDkoeLgETbvMWstaQjiCUblJRyNJfNFaLJ+biJ9D2TMJ3EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iy6fL0uGchpg9Cd1fQdXkQcjmVy9pjEP5v8QouGSnuE=;
 b=SUEFbuq+phypio5e62bwvOaBjytp+8Kayp5yrJf6MPK7Fr7mZzGlcKxlCDDwq15SfO3w8rUS7UIfh0zHVs2vKbXrNNynER1ByHbbxfbt/YSVHcepEjIwOok8D9ymhZqn/5HiJROrWa7zRGtT5Q+ezvIYYsiE24CN6xoU8F1PobE/Uv23i68dZjRditR5U3URMXhaJ01TJFhgTBOpBX2VHZ1nmrM731SJuAQwd58vH/LDlS/QZn5RfeVXEiZr+kuzQwP8d5/hPQXo2dHFV+WJ7T8xwAHKPh/KbDjhiid+/s9C8rpq2y4IC0icvca/rlZK2IXgSINudYA4gBfH9hd86A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iy6fL0uGchpg9Cd1fQdXkQcjmVy9pjEP5v8QouGSnuE=;
 b=LvALg5t8W6BCWpUWOvxZPMi/j/8Cs8+I1JliDnkex+41El7aVlyZWCahz8xL+qeK/i2vzkzvfZSRVRJZumSLCTMn+2LfKS+SFzxMhorrT3ZsMB2nbIDX8K153LSRfn5n0Q8c0haTYcE17ZnGgj5TDEw6Ob7JYYX/zZE7mPeUYuA6j3ie+X4RVjdkEMFYDwLiv99AGfhVrxUXEDriChbBdReP2AXzmspfI1mTFhIpReK0taK4Ky3oAUJlOg5RkcWeFvwP5RVXxOz/bJwYIh6W1WXdhXii7Mr6HixBkYoWdaenmNqUyN6GojLgxdJYL33o+PQyYcq+GhsqXflMuu/hiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by VI0PR10MB8428.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:231::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 09:47:04 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9009.013; Tue, 12 Aug 2025
 09:47:04 +0000
Message-ID: <31cf633e-d31c-4011-b289-be4e3d797bc8@kontron.de>
Date: Tue, 12 Aug 2025 11:47:02 +0200
User-Agent: Mozilla Thunderbird
From: Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: Re: [PATCH v4 20/24] mtd: spinand: Add a ->configure_chip() hook
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
References: <11f6f79e-0622-42e2-901e-16335ad73409@kontron.de>
 <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
 <20250809010457.3125925-21-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, de-DE
In-Reply-To: <20250809010457.3125925-21-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::20) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|VI0PR10MB8428:EE_
X-MS-Office365-Filtering-Correlation-Id: d1670671-2567-4899-0bc2-08ddd985314f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?STZOR1d4dURkSTh3TVFzbGJxVi9TNXhvUEc5aUh5a1QrOHcxWk5Oek45ZmVs?=
 =?utf-8?B?RDFadU1VeFZTcHdmOE1FUTFCZ0RHM3cxRmlyR0x3TGliUnNHTEdWaVVnSkQ3?=
 =?utf-8?B?dndYZ0ZyalBwcml5Z2ZiRWpxZkx5eTgvL25heksxWUFjZ0M0TDlTRExaMERI?=
 =?utf-8?B?RW8xaG42dkVFUWpNeS9xMkhnbnJ4V28wTCtnVjN6UnoxeFQyclhuUk1VZlF1?=
 =?utf-8?B?RDZQTmc0Y0F3cklNc3hiZW8rT0hiQXM0QkVNNWd4dkFiVHVVSHNtekhOL3NL?=
 =?utf-8?B?TU1XTytYaDlmUkJNVzgxSHBxQnNjdkI2S1g3ei9WR0NNK0dxRHBoN2RNdUE4?=
 =?utf-8?B?ZDRHY3U0K01HazZYS0x6amI1allhVlh2TG9mcUl5SzBicVNGUEc4RFBLZXZw?=
 =?utf-8?B?ZTNnYy9yNVNQUlJhZXFtQytyUmQ0TDNjTmtYN3VqM2FocGZiWWZyaXoxTzl6?=
 =?utf-8?B?K1gwZFAwSmpLTnZlSm9MbVRDbThXcnRwVVdMVG5XRUFqMm9mTDFyMFZwZktU?=
 =?utf-8?B?cDJ6YlhTa0dUNmxmb1dTRVlKL3NiZWphOFhVdXBYTW1oTVNFRnp3TWxkeHdJ?=
 =?utf-8?B?M0tPQlZFbldrWExKa05iVUlxMmVpalZld3ExZWc1RzJIdE93aXJMRDdERGFk?=
 =?utf-8?B?QUpiQzFES3pQa2ZhbkZIZUdMNjh1YXR6dmt3TzJxZmFXQm1JQWhmUTZ3Rk9u?=
 =?utf-8?B?V3Ivb1FZOTUyR2ZzTlUrVGFONzNhelN1NzJTZU1IYXN3Q1FGb2RMaks0eEJF?=
 =?utf-8?B?TFIzKzBBTXBWcFVPR1o4cmJ0d0VSUDcrK1RuYXVicTNheUh5cHJObzZJb3ZY?=
 =?utf-8?B?YnZBd1k2RGF4MTJJRXpScjZqQXdFVnBsbW5nQTkzR1Z0ODNNeVlFY3JEYWU3?=
 =?utf-8?B?MUJNYWFnY1Z2UDVZVW9kNldjeENaLy9pM2VCT0kzUnZpc1ZJNnp0VDFPNCtj?=
 =?utf-8?B?ZkExVDliME9mYU05V2RaREZGQmcyM04yeUhqaGNReEVoR3hsQ212RlFmeFpX?=
 =?utf-8?B?RW0rU2FqbWJ3S3pFSXJjczk1Y0c2bW5FY25QamJLZnFvMm5iNW83TllkMlh5?=
 =?utf-8?B?UCtCbUFNZ1B2YUQvdUlhZmo1SytwdGpjMGFOQjR3MWltVFd2ek1jL2ZYY1dw?=
 =?utf-8?B?V2xuakluTENjMTBKM0JGWGdiMlRTTkplcnQ3cSt3Z25CcU9relRtOGIyN04x?=
 =?utf-8?B?eE1GMVd4SFBpYXhvK2FXZGtYSmwzRkhjNHNMbU8vaWF6OEFFc012V3pqaGtR?=
 =?utf-8?B?WEo5cXFreFpuUkgzMzAyZDZtVk9NM1RWWHVRMVBHaDFsU2VpdWt4ejFDQlZi?=
 =?utf-8?B?em9HaGJNT1d2M3BrRDkrRWZwY0ZJZnJRN0pqYTBTYS9RNWNhVWFtclEzVFJO?=
 =?utf-8?B?anBZRmZMQjNTa2RJV3lCSzBxNVcrQ2Q1UEN6VVg0SGNxSFF4aW53S2UzZjdu?=
 =?utf-8?B?OVhFSnVtVFBxakVmVEdETHphNUwwUlNoUXRGQlo2SHRNYmhpb2d4QU0wa0ha?=
 =?utf-8?B?eGpvalJaRGZxNit5NUd3WEhjamdHK3FFL0o0VkU2Ynp1cWZHYXMxeEV5TExa?=
 =?utf-8?B?V0Y1eVozT3BXOHoxaFZmZllkdUt2M2J3TmMvUHYwWlErdVpjanYzLy9VNWNz?=
 =?utf-8?B?dXNnRFRxcUttZStueFBRVmFWb0NveGIxb0FMK2ZjY3pxQ3kyTHJUSm56aGV1?=
 =?utf-8?B?b29iMzczK3d6ZURmWnc4b0c3eFRBSW9JYmRROTFTc045THBmN0NXZ09hVVU5?=
 =?utf-8?B?ZlBVU013ZlFKT2d4bVpvMFhZcmtGanZ3VkgxYnJuOERmNXF0ZGwzbWRlUVZj?=
 =?utf-8?B?YW9DVDJDbUd1SlhSWEg5ZEVPVEM2WTU0MEd5ZHRqM2piM25vYm9RUjhUMTJ0?=
 =?utf-8?B?TmRHT0VFYjdXS084Y1FES2lWc0k0SGlqYUZLVTBZSUhvbVZ4a2tuaUsyZTFa?=
 =?utf-8?B?aXBxaTIwTlEyU2svZVZzak5tNTRNVjI4QzhyMW9CeGIyTUlacTdPYVJ4V3pQ?=
 =?utf-8?B?elh2QXczMDRBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020); DIR:OUT; SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGdKeDBuR1I3OXUxRVgzcit5N2NzY1I2MDd0WURlcTJ5L1NiU0hXNStzOUta?=
 =?utf-8?B?SkFRejdmcXJtU3pGR3I5a2RGVG0zYlh6eURFMmw4MXV4VkIrMHZWWXdKdUJ0?=
 =?utf-8?B?UFJoWHNBNEhVd1czbEZJa1lXandMMk5xamtHVWVnb3ZyRlZaSjJNR2ErS2FF?=
 =?utf-8?B?UXZscEJUaTg3eUJLWDRUYTRtd244NnZqSFgzeFQxVVFsQUlYTmloRGxNZi9o?=
 =?utf-8?B?Q0hNYmdtdmZ0UUpOTTJJdDBiSUZncVJwRnZCbjJsbGI5VXp3ZW04eHJzb3pt?=
 =?utf-8?B?Zm96YWtwV0dMWU0rV1pja0UwN1FsOVJaK2JRYk0rK3lOREFBN0szeWN4czU4?=
 =?utf-8?B?YjB2R3hZUWR6dkpmUVhvUzlqUjZBNHlWT2lUbEpzckRUbFdjeFhTcHFRRTVz?=
 =?utf-8?B?SjhRa1hiR2dZMmFlRzEvdkh6VFpBNklxd0hPQjBvZXVOUVRsQVFYaGdJSWE1?=
 =?utf-8?B?cDBaYTlOTHJheCs5Ry9IY2FRNXdBZWFtMllZS2Evc2tGaGEwVzZBenFpcHpJ?=
 =?utf-8?B?QTRGdGZJa2NWQ3h0K1JYMDNZZjhHeDNUMWMxUFlEeFc2QzlCTmZjZVlrOUJo?=
 =?utf-8?B?VjUzVENmWUwzUmlveEt3THUrVmlJbWQvczZGSGloQmZzNnFaVE5CU0QyMHZj?=
 =?utf-8?B?STZtdFJOaHJ4NXFDVXlQYkZETGdwcVFrTlg4ZEZhV2xSbHRqaGtVSjU0QXdi?=
 =?utf-8?B?UWMyZkNDTC9oWng3Rmx5Y082cXpwV29CcVJtNDRTa1Fnb0d6Q2dETG8rM3dB?=
 =?utf-8?B?bmRoTG1aMlJEWGNUakk0QXd4QitIb1l5d3RDYmpoNUNMWlZxRGZFMjYwekw4?=
 =?utf-8?B?ZEliNWhwQitoS29kNlhzcGoyWm9xNCtOQUlLd2dHL1M2QVFWUDhlSnVaelpl?=
 =?utf-8?B?QWRFVkQzM1pnRGhoU21xVEtuejhJODB0SzFIQXRNZUtnamNZdFY2azNueFNR?=
 =?utf-8?B?dnd4WnFtdGwxYzYwTmVOM2huSEZGMGV5QW5YN2I3bXhHZ3R5N0xLbGpKbDli?=
 =?utf-8?B?VE1hR1hFOXA4a2NocHpOd3RLaE5ndzZYVVV4d3duMzJOcUNGOU9xMkx6bHFl?=
 =?utf-8?B?VUVqclhvUyt1RGhuMnEzRTU3MC90T3dlQ0x2WUNxWFNsWTg5OC9RWmY0MnRR?=
 =?utf-8?B?YVFjdi9KZkI2b1djZDluZXNZdlpMcUltUTRlTXZoaTJlejh4KzNMRjQwajVs?=
 =?utf-8?B?Vkw3RWpoUWVmK3FmZGJSbEw0Z094V0R0WXlXT2lqdGlnT2tFVWFvdnRzeEky?=
 =?utf-8?B?VlBNejBST1Q1QzNzQVBOdlAyZDBHcFhlcDRBRXdrVmpWaFhXVXhBTW9wNk5M?=
 =?utf-8?B?YzRvVmRZNDZQQUZmOHdLem83YzduU1M1NEFwaWJFTnpZWGM0RVdlQVNJa2Qr?=
 =?utf-8?B?dnZlWEF5L1JXZStxVHNIeDZiZEtieFNqZDNxMG1RUTdVTjhNZ2dNUUxmWkRG?=
 =?utf-8?B?VGZoQ2kwUHo5SDNIYm5ick9CL3I2M0NidjVudGhLSElnNUwrdUpIeFpxeDhP?=
 =?utf-8?B?dkRBR1JhTldDZS9qZUl1ZWNaNG40Q2tOejZwU0xpUXFQWVVHMUFJTGdvTVp4?=
 =?utf-8?B?dCtpS2xiQk1TbFZKSGs2WEQrVUZNc2tsd280R1hyNGpuSnRaQURnZVJNN2Z0?=
 =?utf-8?B?SzVXU3NaZVJCR2hPQWhlMEJMcG1kcXQ0Vm9KZWFqUXRtYzl5d3RKNUI0UGhn?=
 =?utf-8?B?T2N4YlNpQXZSQmg1MmxqTGxsRmNLWnhPanVDVUc4b2ZlYlc2Q2pkb3orS3dn?=
 =?utf-8?B?ZHRtK1Q3d1V6cEpFUVhYeitseGxsTjJNWllMckp3V0JIY3FaSGdWV296WEdh?=
 =?utf-8?B?VXpRemMwOFNkaTdtWDRFd3pYaVNoZnFyT2J6TEp4UmNtY0NTbGREZHU1Q2xa?=
 =?utf-8?B?RlJvamxhRUxRZTdJZzFodEVVOExjck5zS2RuQU5BSjVWRzdjeEtOeWVQdE5i?=
 =?utf-8?B?QWYvNm94QVU1TlVFRkZHT3lrU004eXpRSjF5c3VUUHZlSzB2ZFJVdC9pT3pI?=
 =?utf-8?B?M25UVkNLWVlUei9XK0FqbVZQYnlobUppR0M5OU5yZlVpRXRPZWhpUzBhcVFw?=
 =?utf-8?B?NlE3T0tRaUpJRHI5UFVINU9GdWJseXZOWHhoU2NJNUczaW1TRFd2NGtqQnJW?=
 =?utf-8?B?Y3dBeVdOMEJnWEJnNCtOS0F0eWJRSFNrRWVYTFRzR0g0SmF3SEw4Y2hJb041?=
 =?utf-8?B?ekE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d1670671-2567-4899-0bc2-08ddd985314f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 09:47:03.9684 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ifEKpu0nSAX89E7ln4vrZ0YpDhBCPq0mP2l2ZLyGwTIiymUpScRW5Jl3HcJVtEGLdenKzxJvj+rCFCvFTeVUS6vFg71M5OskgKIcSW77NH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8428
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

Am 09.08.25 um 03:04 schrieb Mikhail Kshevetskiy:
> From: Miquel Raynal <miquel.raynal@bootlin.com>
> 
> There is already a manufacturer hook, which is manufacturer specific but
> not chip specific. We no longer have access to the actual NAND identity
> at this stage so let's add a per-chip configuration hook to align the
> chip configuration (if any) with the core's setting.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Please add your SoB tag here.

> ---
>  drivers/mtd/nand/spi/core.c | 16 ++++++++++++++--
>  include/linux/mtd/spinand.h |  7 +++++++
>  2 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 3e21a06dd0f..25e7a38a874 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -1251,8 +1251,19 @@ static int spinand_id_detect(struct spinand_device *spinand)
>  
>  static int spinand_manufacturer_init(struct spinand_device *spinand)
>  {
> -	if (spinand->manufacturer->ops->init)
> -		return spinand->manufacturer->ops->init(spinand);
> +	int ret;
> +
> +	if (spinand->manufacturer->ops->init) {
> +		ret = spinand->manufacturer->ops->init(spinand);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (spinand->configure_chip) {
> +		ret = spinand->configure_chip(spinand);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	return 0;
>  }
> @@ -1363,6 +1374,7 @@ int spinand_match_and_init(struct spinand_device *spinand,
>  		spinand->flags = table[i].flags;
>  		spinand->id.len = 1 + table[i].devid.len;
>  		spinand->select_target = table[i].select_target;
> +		spinand->configure_chip = table[i].configure_chip;
>  		spinand->set_cont_read = table[i].set_cont_read;
>  		spinand->fact_otp = &table[i].fact_otp;
>  		spinand->user_otp = &table[i].user_otp;
> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> index adfb5f3ffbc..94f324741e0 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -398,6 +398,7 @@ struct spinand_user_otp {
>   * @op_variants.update_cache: variants of the update-cache operation
>   * @select_target: function used to select a target/die. Required only for
>   *		   multi-die chips
> + * @configure_chip: Align the chip configuration with the core settings
>   * @set_cont_read: enable/disable continuous cached reads
>   * @fact_otp: SPI NAND factory OTP info.
>   * @user_otp: SPI NAND user OTP info.
> @@ -421,6 +422,7 @@ struct spinand_info {
>  	} op_variants;
>  	int (*select_target)(struct spinand_device *spinand,
>  			     unsigned int target);
> +	int (*configure_chip)(struct spinand_device *spinand);
>  	int (*set_cont_read)(struct spinand_device *spinand,
>  			     bool enable);
>  	struct spinand_fact_otp fact_otp;
> @@ -453,6 +455,9 @@ struct spinand_info {
>  #define SPINAND_SELECT_TARGET(__func)					\
>  	.select_target = __func,
>  
> +#define SPINAND_CONFIGURE_CHIP(__configure_chip)			\
> +	.configure_chip = __configure_chip
> +
>  #define SPINAND_CONT_READ(__set_cont_read)				\
>  	.set_cont_read = __set_cont_read,
>  
> @@ -521,6 +526,7 @@ struct spinand_dirmap {
>   *		passed in spi_mem_op be DMA-able, so we can't based the bufs on
>   *		the stack
>   * @manufacturer: SPI NAND manufacturer information
> + * @configure_chip: Align the chip configuration with the core settings
>   * @cont_read_possible: Field filled by the core once the whole system
>   *		configuration is known to tell whether continuous reads are
>   *		suitable to use or not in general with this chip/configuration.
> @@ -569,6 +575,7 @@ struct spinand_device {
>  
>  	u8 last_wait_status;
>  
> +	int (*configure_chip)(struct spinand_device *spinand);
>  	bool cont_read_possible;
>  	int (*set_cont_read)(struct spinand_device *spinand,
>  			     bool enable);

