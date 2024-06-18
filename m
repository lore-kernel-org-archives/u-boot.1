Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0468DC27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 12:20:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F2C0881D6;
	Tue, 18 Jun 2024 14:20:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="aDFzEnE0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41F80866F6; Tue, 18 Jun 2024 14:20:16 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::61a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3C5F882ED
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 14:20:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=treding@nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sw48gYWNZ0nL8XA+gSSSY0JKnVLcVLYszW6ZZ1xAn3eaEk7ESe94fFotPevOlkeDVohW3Q4TDHqup/8rsyadp7Sms1z2G0OLBY+AWcQdR0wO6vfYMbuFBp4HnMF0G7gTj+QAzdOGpJpWlUbqFCVoRsbIQVMyTlk6TFBrO/e6gRkRz2mMUqhWdKOndIvqZGDMwLy0zcaLE/mExOhZhb2WdmGmP+Cdraz5qUqUl3HpmGkicedFuGbxH21C7pR3nC2x2A8ZTqvTe5/aGs8JnBX6DGLbQxKezwitibTfBmBO18JiNY84JRKfC/WpPifzalmGqWaQArjioD7qIYr/yZQRXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ghNmIpiU4ifbsiDZmhjizJ7Xggl/Ej2LRmk2sDNgJ8=;
 b=Vv50OFCpC4pSPy3lGJS/5ydsQCkJG49W37gkN1l+rwokBdDHrHdpDHUOOdPBvGf75KXXytcL9+9mQkWAdfCrIOE2Jd8wZSSGJgzbj4Y2NflDJHqVsJEDId3gZYI+GBirfiPO119ZhK3yybG3oikw6Gq0J6ADcqnUcxRUobUGt5QXD/ce4q8GMhoBJXHFpq1mvLfRX/rleEyqzJkPjPt5FO3UXagCfWT7y85xvNkzwLa1rzJz3QlLF5pZwJqSqSY9Zqbpf7ijBUlGJYn1LaXNtmD0lXz5j3eeghgOfVKeETlzurcBfIy+ylbSrxdXjlc4YMILN3GSvEck9IMaGWx/RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ghNmIpiU4ifbsiDZmhjizJ7Xggl/Ej2LRmk2sDNgJ8=;
 b=aDFzEnE0qWPIAgqp9HDWQo+hZJEiD6P23JIyuLNTSxdqHThZqQYHO6kF5/PHEq86T1rTsfeUQyABM2isTp+sYCckXgSRmM+4Ulj4wz1SSAk1RT0BzBsWw8XNhfBMTIS/pkgLWdsOIQXFE8W2McTQdSgBijR6Vv8d17y6ruKIMPOKztd2i96uENXqMmjmNx0HJqJU5XHA3zN2Dr659P+BsmuowiLZb8fZKOtE1z+3uvlyVo0twlOadgwXXtL0R5CXOdqtr3ydV4jZOXweh5Lzi69Ht3HL9d2xh9E5IL+Yi5z5LbURGGZTsgFF6kLRhj7/lLHptKn6b46xtsp2ZMEz7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) by
 DM6PR12MB4090.namprd12.prod.outlook.com (2603:10b6:5:217::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.18; Tue, 18 Jun 2024 12:20:09 +0000
Received: from DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::fcc2:409f:fdbb:186c]) by DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::fcc2:409f:fdbb:186c%4]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 12:20:09 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 18 Jun 2024 14:20:06 +0200
Message-Id: <D234ZF0HQNNS.1Z4YABS34LUPY@nvidia.com>
From: "Thierry Reding" <treding@nvidia.com>
To: "Svyatoslav Ryhel" <clamor95@gmail.com>, "Tom Rini"
 <trini@konsulko.com>, "Anatolij Gustschin" <agust@denx.de>
Cc: <u-boot@lists.denx.de>
Subject: Re: [PATCH v1 1/1] video: tegra20: dc: use nvidia,head property to
 identify DC controller
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240618115721.41374-1-clamor95@gmail.com>
 <20240618115721.41374-2-clamor95@gmail.com>
In-Reply-To: <20240618115721.41374-2-clamor95@gmail.com>
X-ClientProxiedBy: LO4P265CA0050.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::16) To DM8PR12MB5413.namprd12.prod.outlook.com
 (2603:10b6:8:3b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5413:EE_|DM6PR12MB4090:EE_
X-MS-Office365-Filtering-Correlation-Id: 43d7769c-379a-42ee-4496-08dc8f90fec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YXRtb3kyeHRjN1dBZlUyY3N3ODNUQkpaaUxVUGtHYUltZjFNdjBGTDBUTU5r?=
 =?utf-8?B?NXZ1MEc1aUkrV2dNMXZMdkFUUEVab09PcllxS3JwUGVrcUpaMU1qT0VMZEk1?=
 =?utf-8?B?dUl4d0RiaGRJUTVaTTNuRVlZNWJVQ283NXE2ZGk3dVNMZk91bEtQRnpSTXJN?=
 =?utf-8?B?M1EzaWVNYzNHRlN5NGN4eDhHYkNxb2lGLzZWUUpOZ3dGS1NSa0lxOGlvaDhO?=
 =?utf-8?B?d1F4cVFoQXBOc3JCdHVMTnkrakV6d2U5MUliZFlsMDMvODh1RjBWZHJNajFz?=
 =?utf-8?B?RGxIU0QrcC9xb3pIRzA1UVFvZUFVU1Y3b0R0RXNTR29mZ0tlNHhwS1gzSlVo?=
 =?utf-8?B?RWtxcC92dHNuSlJmVTFzSDA0eGFaWFlHTjhGWnhEaG5SRDFYWjQrU09ldlNI?=
 =?utf-8?B?d3RORWZYbldSd3VrUWs1aVRvVkZJdUcrZGs5ejg4eUdHeFdvU1I1M1VqbzZa?=
 =?utf-8?B?alEzVkpia1NLUDEvN2tkakpBZXhhcnhVaUU2MGp3YllENmtPZmZBaEhKZHdk?=
 =?utf-8?B?cnRTT005VG9ma1ZVdVdMdGluMHFtbDI1ejJQbEhYREllbkg3R3hXZG1Zd3NZ?=
 =?utf-8?B?MVFOZjE4RXM4R0Vyc203UWo3eGNITG43S2hUVHpwMzhDS0RSVWZCSkJiakRh?=
 =?utf-8?B?a2NFOEh5S1diSXoyZi9CSDV6b2c2d3pqVSszem5MY3ptbVg1T1ZTYkpTcnRB?=
 =?utf-8?B?NVk5SURRUnducmtybWMvam1iQ0FCakZ4aFBiSm1qbHU4b0Y0NTIzb2JrcXpQ?=
 =?utf-8?B?c2NaNGdER2JTeTE5VWx0bDhpTjh5YmRnQ0k2aHoyTkIzdFRVN2RweHZnRW5u?=
 =?utf-8?B?WWt5YXN4NUQ0QXlqZG1kaEJGUzRtamJjT3NTYktISVhqR3RLWThtdnpQVmND?=
 =?utf-8?B?UTVwZmd5OXpHdlNicmdsb3JnTlBRQUNDNVlxVVBlQkN5TWpKdk9tbjVrLy85?=
 =?utf-8?B?dEVFWTZnZVE4TUZMM1dEVmpIQkU5eFVaNEF0elVBMW9NemU2NmVsYUUydmNa?=
 =?utf-8?B?SmJzMVpteU9FWXJBbXNINDUzdm1MNmRBNWNsMWNDdG83c1NGRGdLT3dOZWtP?=
 =?utf-8?B?dUJhWUp4dGtLUVA1VFAzL3RIT1pDdmJQM0g2RnQ0MmNPTkMxdHdTWlZiWFpz?=
 =?utf-8?B?ZGtNKytiNUJnN1lHQVl2SkEvUElJTlpNSitQMHNvUWdTdXdVOWVLRnJXaWR2?=
 =?utf-8?B?UlUyM3djNFlEVlRmemE2SlRJYUdpTmJWUXJ3aFR3WTBiNjdaUjJ1aFN2bWdD?=
 =?utf-8?B?dnBxZXZZa0FnSXJ0bStBWGdlYjNnRG5oOUdHeWVtM0pUcXJoeUFkeXFRMDFS?=
 =?utf-8?B?VVpTUzhzckZCSStWeTFIdGQ1YjhKKzNUSEVRQ01DTHNrZGRWdHU3aEJvcXBI?=
 =?utf-8?B?UWtUMDMzcnlsamNxTndLQ3F0RVEzZ2NRdmgzc2FUVWZJaVlOK2pPclg4T0pk?=
 =?utf-8?B?bGd5WkNJSXRhYXZKSTBNaGp5N1BhOVBSd3Q4d29GR2p0eUhYRXd0NnhvZzJM?=
 =?utf-8?B?Z0prR3NRcEU5YWd3anRKYTFjeFBzY0c0UEErTmxuZFBNRW00NXI1N1hjdmdV?=
 =?utf-8?B?Q0JvaXpycFZZb1RadkUyVTU2Sjh5VWRIbUdZY0RQb1p3eTJYMlpYN2VVcy94?=
 =?utf-8?B?aFBPc1RMemM1cGpVYkY2Zm9BWFNBbnFmTklxak5jL09zZG1rdnR4ZUNBazlo?=
 =?utf-8?B?RitFZGZZeVVGSG02eVNXdXdNMm1vb0lGM0c0T2YxK2l0cEFlb0YrRnFYcU5H?=
 =?utf-8?Q?AO7tv6FCVlh46YrK7JS61s2nJ348P5DxXn3x2in?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2JsNFNRMktkOUltM254Ulc4U3FDWFpCdlJTWlUwbnkyYXNNSUpRUDR2dzYz?=
 =?utf-8?B?NmthU0tHMWU0cDJwbkloa2RWcS9sNVlvOU95dzFuMGVxTm1IM0J6YkZjQk13?=
 =?utf-8?B?dmZPOGdrVmdiSXpBZ3kxSmVWREQyampBOFpmK1RrOWZSWVBVV0MzcUdwR0Qy?=
 =?utf-8?B?SFdhNFpmRWlUK09NTEZXK0tQL3JJOWxyRlpDcjBLNC80eW5uSVJ2QUhWeXd6?=
 =?utf-8?B?NTdQL3E5dmNJRlVxN09EOEpKMHBWaUFiTndyTDdxUjZOOEQybzNEendweW5l?=
 =?utf-8?B?NTJ5M1FlWnNEWlJpK2Z4bVkxR3VDK2JmNHNDNmdkYk5TeUV5ZDBoRVVTZGRU?=
 =?utf-8?B?VEVDRzdnY0FUMU11TnJmeGNoZlJocEhqVWpJVnFjeGN5UzVtdUxZbGpnRGIz?=
 =?utf-8?B?U3BwdVphQ01CSC9KcE9naWxSLzB0VXNpang5RUVJd2h1dGZETyt1TEI3OWdM?=
 =?utf-8?B?OWZ4QjlSYzdIQmd1VTg0cFZySTVjaHNYSGVUSllRMmNuT3J2N1B3Vmorc1NC?=
 =?utf-8?B?TGEyMFpnSStWTW9MVU1wazZPSG80MHBNUFAyTE5pdmpxOUhmR3JNMlg1SXlo?=
 =?utf-8?B?bEx4WmtYTFlvM0Y2dHBPQVVLdUdRQW9NK2dqZG5QUUdGaWo2TlI4RDdrRzdp?=
 =?utf-8?B?Nzh0YXpndXRYVTNUZE54R0lmUjlBTjFaTWgxUExRaFQ2ZFRvVlRZSmpWVGhQ?=
 =?utf-8?B?RGNEZmk0RkVMaEhhT0N3UFh5aHpDcjhKRlZhYU81Nld2bmFIN3E4Y2dkVmxP?=
 =?utf-8?B?RTZYbnB6bllkNmJiL08ya2hJMGZtM1JsRllGSEdBRmFoYUhlYXZTUkRYd09Y?=
 =?utf-8?B?a24wNE11Y3F5S08xa1NHVG9GWVZKNkVYQXB6bFM3M3ZXdDhFVkZrR1dGem4x?=
 =?utf-8?B?a01mdWltcnYzVnBValF1QlYzMERyNERaenQzTEloVDVCdVltc0x4cFV5MEky?=
 =?utf-8?B?UWZ5M2FtdGF0MmdnMHJNV2tOT2dtZ2ZBSjlCbC8rZXRsMGxac1dJR2l1Y1M4?=
 =?utf-8?B?eGNWYmo2NnVudDMvU2FaNUUxeWkxbXFDYkVVZmV2cFA3aVYzS1g1emZyL3Ft?=
 =?utf-8?B?UTJUeTZtTkc4QWdPemFVNk02ZE9oeTJacFZXVUpQcTdGeGtVdEU1aFA3cGRx?=
 =?utf-8?B?eERsWk9VbWpaMTZrL1p6aE1NaGpQUURSUmoxNmhnQXdLUnozd01Mem9Odncx?=
 =?utf-8?B?Z2t6M0UySWtTQ3VUdWtiR2FyeDh6RUlIQ0l2TXpxZy9DbFJ3Nmx0TXhNME9I?=
 =?utf-8?B?Qzd0SEt6VFVHYXBVSFdzSVl2akRaSHNxeUVwbDhEYkloNVdaY1dNeUZUQitz?=
 =?utf-8?B?bDFKalJFelFrdlhQUlptekgyaFJJVkk1TXdteEhsYitwcWlWaVMvVUlJcWJL?=
 =?utf-8?B?OERJK2lPTkVIbmVkU3ExQ0pBQWdGVjRCbStvOXhwdDBGL0EvcjhmMDdlYk5S?=
 =?utf-8?B?WTBXUGZqcm9zTXpnTkZ0THFDSmZsVVJIVDh5TkxFWmx3T1J3U3JQaXVJTVZH?=
 =?utf-8?B?czFGamZYTktmR0JpRUsySHJxYktUaWdNVlVsZE5kYm1BelNZaGE4eXd5d0Rl?=
 =?utf-8?B?NXV6L2JCOXQ0VnZaenBCQ3UreC9YNU9vZ1RSclozdkxSZTFHNUVqU3ZzTGQ0?=
 =?utf-8?B?ejY2VHViQkFtSzlwVU5UeFR4cEZTWnBNTUxFQU9zYnZHejhXSVN6YXFJZE5R?=
 =?utf-8?B?dTRjV2VYWHp5VVVOWFo0QUZMNEVTTzZLbnBBK0xvbUJZZDJ5U2pQdjZkMTd4?=
 =?utf-8?B?WTR4U253ZFdJRmRobHdUZnlraEpMU0J3WEd6aXFqYmlGeXJ4Y1paTmJ2NEk2?=
 =?utf-8?B?dllPWkdLVEtQSDMyLytQamFLTVdXbkRzY1FzUlN2RjBIVHBPOWZIY210RlRI?=
 =?utf-8?B?WW83R2ZUWEFrQ3grNEZ3bWpSZElNWVVrbHRCUXlQM2Jqd2dqekJlNG5RTlNx?=
 =?utf-8?B?a1lRc3JIZHVNYWxNMVl4UkhnZDUyZFJsRmJ5dU9jN3NtVGt3TTlNWjZVVG9m?=
 =?utf-8?B?SHkxMFNJNnN3YUF1ZnBxOG1vSk9sQ2JPdTVrWGRyaEk3ZWNlbDJicVMzVHll?=
 =?utf-8?B?azA4UUZ6eVJGcWRXRW9ieXVqMjFnVzJ3ZCtDR1BiU2RsUlBDYXo3Mkdnd2Nk?=
 =?utf-8?B?aDFSQVVFRVZFT2ZnOGIxZlBhY1lYU01FaGJLRWI4VWY4RU4xemxCODBveHg5?=
 =?utf-8?Q?dl17NnwUSSPjAGMioCblgggJ7aD3L9ncuXqweN8KGi3i?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43d7769c-379a-42ee-4496-08dc8f90fec9
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 12:20:09.3786 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wzy5+fwGdOhYp9kKuErHa7vlhC3VMT7X11Xb9aabxdpSRaCQVHcJqU3ReGrOaK7UOHt9MWuo7wiaLkKcC/c9aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4090
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

On Tue Jun 18, 2024 at 1:57 PM CEST, Svyatoslav Ryhel wrote:
> Use existing nvidia,head device tree property to get DC controller id.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/video/tegra20/tegra-dc.c | 6 ++----
>  drivers/video/tegra20/tegra-dc.h | 4 +---
>  2 files changed, 3 insertions(+), 7 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>
