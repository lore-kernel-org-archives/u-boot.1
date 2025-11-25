Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5158CFD368
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 06:42:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03C5B83F2B;
	Tue, 25 Nov 2025 07:42:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="a/fyXtGE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A95B183F5B; Tue, 25 Nov 2025 07:42:46 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38D6A83EAE
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 07:42:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=enODpVJorUEayd+crgiyo/Q6rwAZwRHUyuJ5u7jrVSVUUv7B4vP+VLVfNnM/O9maZ66hCzGwEd1Pr4NSc6n0AlNv8OKi1uOGAORGxZ2/H5ZfeXQRxdi6uXS1dyPCOuLsk/RA+vWr4Dpa3dJ5nHribOuuFxnTceR/kDM3CadSy8mbk9CX7j1lETgirmv6IqgCNl3NDWoeXSAAU48b+/tQLifY24fmhgo8tSQ2MIk79wSDNS0nu9PSP8MCJ3z9Qg/ICXQ7lXuR9vDNxL8cFol1T0PCTQmQV1c7Go2dBKi2TDAy+xkX/MqGjIxOE9eTXWPjfhy3v+1NrqgKSlRvUo+wxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=giQ4Km4TLs1r+dVtX3m4rBqT+Ac0bVGrsfHuttctR/c=;
 b=b4fue7ZkIUX1bikP/fRYILhO1M18abEh+gqUBiOzq/UPyA4xuNe290KRqycbUn/VYM2bSc2NnBgo4zUaAt+X3B3kv2Hk3VEM5MCkYkHlyJmQ4weKLOPkTzSjzZPGWM7eVtKEN5jubs+gjvcy7Hlk/DS5f+DORsDOhZ9rRKHEwUdaoXyPa5J2KdWzlIPXVVH8NoAVFQeDfVomlEWApocOb0/zlESgNtjDnsiXxBCVR88JqCJ5DNF90sNeM2jbrLgHwvepKOGF/JKC6ROZMcpEauJaegpx5/5RPlC52UJTEAyE8ax+Usy+i0oBwT1hdqVu4bRYLtEh8MgpCCO6v9Erig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=giQ4Km4TLs1r+dVtX3m4rBqT+Ac0bVGrsfHuttctR/c=;
 b=a/fyXtGEVZCfk0f5yGO7bn89+sueahQSrOC/wslJKDDW915slJ2KmqToRNFDhg57wW+QV0hrujYTQLM46i4/FiKDTNsIVwGtskYAF1C8r+ONHCtT+COCFesXOsYGwpSQbJO2WN+9ryXjyxVZzsImocsPcWd9Oda3MMYzHSuYW1an6Pqfe4loLZbJZlElyrHcscKPfUnh2r4zpEhDPK0X/kIkFDPa8VXSO3BTPaOdXkvfoss16D+kWYyj6a44ljtSUs+qo56LcrkcLqmLH+IhxMn0HyhG1vgoVtw2qYRaHpa4z6usCRjCtQErBGwbHkUAk99Sv6UZmJmjhmYjpEuoWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8831.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 06:42:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 06:42:43 +0000
Message-ID: <c536c33d-8330-49b1-821d-3d218c49ae23@siemens.com>
Date: Tue, 25 Nov 2025 07:42:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arch: arm: mach-socfpga: Adjust a raw sectors for MMC
 loading of U-Boot from SPL
To: "Chee, Tien Fong" <tienfong.chee@altera.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>,
 Brian Sune <briansune@gmail.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
References: <cover.1763140421.git.jan.kiszka@siemens.com>
 <c1dc5e70f6bbde1f2b7dfd027a90f09bb4c1e939.1763140421.git.jan.kiszka@siemens.com>
 <e39163e2-cf21-4a73-8170-8066d93db049@altera.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <e39163e2-cf21-4a73-8170-8066d93db049@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0230.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: 0386b68f-8423-4317-b93a-08de2bedd5d6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TCthMGcrZXVnNHNITjJwakFsYm5LRmUwMmtKOFFML0FIVWtrM2tGQzRTZnBK?=
 =?utf-8?B?VjN2M2FtT3ROTXorZzR0dFRPM0hEeFBEVkc2eGZ0cE5tNEVuRkJjcHRCd21v?=
 =?utf-8?B?OW1KSG1yMmVpRGJJb2xRR1h6Y2UxcWhxT3Y5elYzaEhibUl1dDhzeFpPUmM2?=
 =?utf-8?B?VWlrekZVM2NFTUQ5RHlVelBtc0lRVmFiNTRFdmo2QVBlU1BJMTY5NVpxVzJX?=
 =?utf-8?B?cGFPek9ZejJ6Tmhtb1RQemFyUzgrY284N1RzdnNPbHlMa25ZcXRqZWU3UFc3?=
 =?utf-8?B?WTFSY1hRcWpJeXQ5T3lMR1I0TjVSL0xZNU44aFBGOWs5SG5Cc3ZmVjJFY1hQ?=
 =?utf-8?B?bjRqYjUxOXdWNnNHRStPMkxNYVBRdEZHaE5LK3FyaGljK01sK3RFTFFQaFNL?=
 =?utf-8?B?SUg0eW5aYTNTTHp2eTVMY21GUWFWV2JJYU4vaTk3Y3ZxaEFsR2lPZ2FWTzhW?=
 =?utf-8?B?cDc3VHNlaldwRzFoMDNEQ2NjREQ3ODJjK09aeXpZUFhnVXpMRVNKQlR6WmJZ?=
 =?utf-8?B?OGgrdGxhalZHbEd4STZNSW52OThYMktLelRNK1RjcDdrTUdCQmx2UVNveTVr?=
 =?utf-8?B?a3RvczRUNlNYUkhHaWF4c0IxUnFoMTZYMTd2aWlyd1JKc1BEelYwakx5aUsx?=
 =?utf-8?B?VTY2aitnSnFwOEdpd21zV29nN1RMV09xdityVFVtUUJ0bGR5clZDY1ZRWDZO?=
 =?utf-8?B?UVZ4TUNXZW9GdG9kUHJVaSszQWhycmRqeVFPZGRsQjhQb3piYXRsNEF0YXd1?=
 =?utf-8?B?WkdBOUpTMVZ6anF0b2xGczd4MkRJRnpMMzBneiszWHQ1VWlESnJBVmpBYUJz?=
 =?utf-8?B?WVFuK0RoZmdYOVh3aTRjaUVPS3N3MnJidnR3WU9MalFhWFI1S0UvYkFaYWFv?=
 =?utf-8?B?Tnc5RzUzU0NGVjVKNndFVU9UaFBEazgzVHMyc0F0YVdoR0hVZUhNZTE0WTBh?=
 =?utf-8?B?KzAwY0pGTWZBS1luQ1JZaXBFbEZyenp1eUhURTB3T1JqSlZuV24xcFdWU0pG?=
 =?utf-8?B?bU5RYWdoOFVnT3Zid0EvY3FmQ29EdWxKdUJwNEx4ZWF4WkllN2djZVlWblhG?=
 =?utf-8?B?YnJhdFhSNVJxOVlvaHBOMlVqbzVyZm1xdCszQWpqdHkvbm4xT0diYVZiNWZs?=
 =?utf-8?B?YW5PbG5HUkNaTVV5U1RuV1RwVmRGcXArV0NRTXdCVWw0RHNzL0RBWDhsajVk?=
 =?utf-8?B?KzBzeHpTclhWWkhnZ2Z6VS9LeitkZGtQV1JmOFRMR1lpMTBkOW9WZnZvQ2oy?=
 =?utf-8?B?WDlybVlhQm94VGxiWUU1SzZIK3FyS0ZlSG5ndi9uR2RhZ3o3Z2VWQy9id0NZ?=
 =?utf-8?B?NzFlYXpMb1VLT3g0OUEyOHhrd1RiTlJvR0J6c21POWRiZUpSejlEQzNodmdU?=
 =?utf-8?B?YUtLdktwR3lDK0pBTXNidmNwUzRmcHNWNFZINEN6aUNkRW55SlVxdE1Pb2tr?=
 =?utf-8?B?M2ZoOStveUg1cDRGUk1xKzJNdG8zQ2N1Tk80bDBnMXdTc1lmZXpKRnNHb2gy?=
 =?utf-8?B?U0NGNGVGUnBrQlBaU0lueGlGaHlRQUxZSEI0RmhwS0FqYzh0U2xZN3VCcUFw?=
 =?utf-8?B?alBra01NMHZJYUtWRnhBMEZOVVJyR0k5RnhXb0RPb3ZxUHp3YXJaZEw3d01L?=
 =?utf-8?B?WkMwcXI3aXJNQ1poUVp0M05zMU9jb0xXSWtXTVhiUTQwLzNBYURQa0xrbWZ6?=
 =?utf-8?B?VGZWcklsTFg5UWZKeVBwYUhoRnN3bnFkN0Z5dk5OVmRzS0NHK2tDeTRZUjVt?=
 =?utf-8?B?OFBZWWg5UjRXSHJlZnJRYnptNld2aVZFWm9yRjNQSVFSbW1lZFBETzIwaDc4?=
 =?utf-8?B?STRHTHVyenlsQ1owN3lRcS9QalJyb09RNi9ONkFRZzZnak92R3BwTDNNRUFa?=
 =?utf-8?B?SUwxOUdVbmpLUVpZbSsvZXg5UWNyeVRhcDIrM2xKSEd4clE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3lCV1VQSFpmdC9vZ0NzQ0E0ZXI5QytxYUdBdi9GZkc1QThuK0h6dTFGT0I1?=
 =?utf-8?B?RTZvNDJtUVJWZjdRZlVjMFpCdzJQRFhKN2Z4SnRmYWxrS2Nmb1VxQ2xvK3Q0?=
 =?utf-8?B?a1I3NmFKU1dSOUUwaG5zNnp2cEM2Qy9sUGUxZk9jcHBuY09URUVvdUN3elBa?=
 =?utf-8?B?ekFHMk1XMTdkSVd2NGg2OE5kbzlEaTlyNEZpVFpOK1Izb09PQXRoSVJ3V2o0?=
 =?utf-8?B?amJTQngxaTNmNC9jdnAzTDgyQmdtTDJlSmFhSFdwcHNUcldZMnU2eGN4N0Vz?=
 =?utf-8?B?QklUL0tXSHM3dkVWTE1vYkoxRThWcnJFRzN2S2s3WUlNY1FoNlArR1p5TEFT?=
 =?utf-8?B?bW5HckMyR0V5RitnTWhyaVNZTnBYM2VUcTFHWnN0WVR5T3MwQ1ovSXdqZkFa?=
 =?utf-8?B?ckI2MFJPTHBxSlJpVFduN1NQU0RzN3RZTytRQkJnSlg2TXFZeHM2N3AwSW9m?=
 =?utf-8?B?ZlpMSUI3Mys1elZ1VzJtQkU2ODJLM0JWcFF3YUZqbFgrWjdCWHJmQlp0NUNn?=
 =?utf-8?B?TVlNbWt5cEIvWXEzVytKenZGVFI5RFdNR1ppSG9UaGtxTnh4bEdSeWhVVjdO?=
 =?utf-8?B?RktwSlk4S01EcFVEYTE3ZUYwU0ptSGc3UGtJUkhXSFFScGYvMXMvRlJPSzlV?=
 =?utf-8?B?bmg4TmpxMldyUkI0VXJvTGJtVEpnYnlhRVQ1djJ4VkZJd0hGbU1DK1pwU1dh?=
 =?utf-8?B?VlNuZ2Q4ZVV3VE8wZjFxUDBKWHphRERET1VYRzY3c3VPQm02MUIrdHR6cXZE?=
 =?utf-8?B?cWt5ZVdsdzVqQ29pdS9TV25XV25lck8ydTYvNXY0dDNva1JZaWFOZGdrbnJp?=
 =?utf-8?B?c3BwcjdqekZnVnIvQ3o2anFydXVpMDJHWDVBNXh1d0ZMbCtva0lwNVUzTWF3?=
 =?utf-8?B?bmRRdFpUejlxTVUrRGp5MUExQy84aDdqOWh6SENkRVN0ZHQrUURab094dUtN?=
 =?utf-8?B?U0l4VHdDVUUrQ3RCbTVjMzJPMDl1ZWtqQTAzZlJRaWk3bHpJNXQzSGVDVW5Z?=
 =?utf-8?B?WVNtZFlFRGZ4T0NLUXVDMTl6RkVMeENTbVlWVkxaeUZ6U0ZwbngydGhkbDRC?=
 =?utf-8?B?bGQzVWhnZ0s0V0FqbEpTaTJRTWdxTlAzOGpvYnpxc2tpRFkrUmxFSGNmTHpO?=
 =?utf-8?B?cUkvcGY5SVI2YVcrczJUNlZQWFhadGxmdU5WV21DT04wajZ2aGJwMVIwcDBk?=
 =?utf-8?B?RjB0aGxlaEhOTDlvNEVCN2Y2MkFpY2FYOUk5eDJvQzJtYmNNQjFjaFhuVE9r?=
 =?utf-8?B?ekh4KzZGSXd2a3lFbHNDUDc2R2JVVmtmRndBMHA5WUJrbzlWMURxbEZNTExr?=
 =?utf-8?B?SURyM29yWFBXdE84MktEVHBKYzFOZDFmeWxiL0ErQXUwMGExVm0rRXFjeS9J?=
 =?utf-8?B?TThsdXUvRnRVQUZFM1c0cHpIK3lzS3BOVzdrQWdReHU0R0pLTHFEQTJxRGNi?=
 =?utf-8?B?bW9weFM2T05saVF0Um5aaGxLaTVhSnJEV2ZBNG5ZOXhGN2xSTUkzMXRSUC9a?=
 =?utf-8?B?OXA1RE9KeFlLa05EWXkwc3MwbVN5cSt5SXl5eGFMZVh6MGFSakwrRW84R09L?=
 =?utf-8?B?MDFaWkpNQjhUNWFWVXk4L1NJQlBVaE5JZy81ZXFldHNObmJXZ25oMVRuSHNv?=
 =?utf-8?B?M3o2S2hzTFpCVzdsb2EySUk3UHlDeE1tZ2VFOHR1WVhUWnNSVVdYNmRFeU9o?=
 =?utf-8?B?VkpPaXFxS1ZKRks4ekpuQ09Qd08zQzNYUW5EOW9Eb2VJUkFCRk1Gd1F3WHdJ?=
 =?utf-8?B?MTU0SE9oOFFpVDNPd0E2NFNVQTl4WW1NSGZSTGQ1bVVVTEs1am5iL3RBMVB2?=
 =?utf-8?B?SDRONFgvUVFrYW9mSWNXK3AxT01XWG8xcTcrWmNHeWcvWVdvNkFiTndNbEpM?=
 =?utf-8?B?NTRpZHQ1eFE2eVQ1d29kKzVjaUpVM09rMlBKTlh6Q3JXYkpDamJwbVJvQU1j?=
 =?utf-8?B?dVUxMGV3T2M1SzRHMStFb0JVQ3NELzhQZUFMbGwwRVhBMDRiMWdHRUF4TnFy?=
 =?utf-8?B?VnV4ZzJTSXRKTTgxRWt1QlFONFRRWForMHJMMzBodm1kR3JLR3RkUHZnbVZG?=
 =?utf-8?B?UUlWTlgybHVEMnMzaVBrNlAwWGtubm1XTTRDQnYyeGlkQXpyU1paK2hGZmgv?=
 =?utf-8?B?Zmg1c251RXV1SGxQSTdEYTQ0Nk1LUTM0b2wzRnZvRGZGMFg0WXhzbW5IODBH?=
 =?utf-8?B?eHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0386b68f-8423-4317-b93a-08de2bedd5d6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 06:42:42.9604 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a9Q4krHJwrknXpMGY39/tYOVKXAwVgVAqHv1i/TaZc4GgIH6Ak++AVUsWsyOVi+xcx4w26o83QdCTvVbQsWdJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8831
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

On 25.11.25 06:02, Chee, Tien Fong wrote:
> Hi Jan,
> 
> On 15/11/2025 1:13 am, Jan Kiszka wrote:
>> [CAUTION: This email is from outside your organization. Unless you
>> trust the sender, do not click on links or open attachments as it may
>> be a fraudulent email attempting to steal your information and/or
>> compromise your computer.]
>>
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> If U-Boot is located on MMC, SPL and U-Boot proper are glued together.
>> More precisely, SPL is stored 4 times. Take this and its padding into
>> account and adjust sector number via board_spl_mmc_get_uboot_raw_sector.
>> This allows loading from a partition, without the need to hard-code the
>> offset via SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>   arch/arm/mach-socfpga/board.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/arm/mach-socfpga/board.c b/arch/arm/mach-socfpga/
>> board.c
>> index 28554b7a109..d756f7381fb 100644
>> --- a/arch/arm/mach-socfpga/board.c
>> +++ b/arch/arm/mach-socfpga/board.c
>> @@ -14,6 +14,7 @@
>>   #include <hang.h>
>>   #include <handoff.h>
>>   #include <image.h>
>> +#include <spl.h>
>>   #include <usb.h>
>>   #include <usb/dwc2_udc.h>
>>   #include <asm/global_data.h>
>> @@ -209,3 +210,11 @@ void lmb_arch_add_memory(void)
>>          }
>>   }
>>   #endif
>> +
>> +#ifdef CONFIG_SPL
> 
> 
> The guard should be CONFIG_XPL_BUILD instead of CONFIG_SPL to correctly
> control SPL-specific behavior
> 
> 
>> +unsigned long board_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
>> +                                                unsigned long raw_sect)
>> +{
>> +       return (CONFIG_SPL_PAD_TO * 4) / 512 + raw_sect;
>> +}
>> +#endif
> 
> 
> Global impact:
> Applying board_spl_mmc_get_uboot_raw_sector() to all SoCFPGA boards
> could be risky. Older platforms such as Arria 10 and SoC63 devices use
> different layouts, and soon U-Boot proper will be moved into FAT32
> partitions for cyclone V.
> 
> Offset calculation:
> (CONFIG_SPL_PAD_TO * 4) / 512 + raw_sect assumes a specific SPL layout.
> It may conflict with the default 0x200 sector (https://github.com/u-
> boot/u-boot/blob/c5e6d2ab7eba68cbfb600cdc131c0c375ced2ec9/common/spl/
> Kconfig#L592 which eventually assigned to raw_sect above) used for
> SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR on some boards, so this calculation is
> not universal.
> 
> Suggestion: Consider gating this behind a board-specific Kconfig option,
> or limit the change to boards that actually require this offset. This
> will avoid potential regressions while supporting existing platforms.
> 

I dislike more magics here. This is surely not board specific, it's
rather partition specific (raw vs. fat part) as you pointed out above.
Probably the romloader version plays a role as well in supporting one or
both, thus the chip generation. Let's encode that into Kconfig, rather
than magics.

Are there more modes to tell apart?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
