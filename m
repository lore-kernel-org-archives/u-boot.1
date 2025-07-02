Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68EAFC7EE30
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 08:52:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8D1781FEE;
	Wed,  2 Jul 2025 10:52:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G+yoTBLU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91A708206E; Wed,  2 Jul 2025 10:52:13 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::612])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8142881E13
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 10:52:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FpjgF0O1zG15FUstZnJnWBf+dRiN1uoJ5sxbNK44i+q0a2cFqi3Z1RUhp0CfnRZTMurcm9bliAIiYlnofuv7bO1NVCL8FjNPPlrhrWrYTt8leBOUjGhqlLKjHJ3Q95nqC4hL9XD81RoWaXXpR+Y3mG9FJa0svO1JIAZhlEp/z4DbCmECdTTqAcQiL1WhFD77bu1Gi4rKYM771DBLprrY1QGkRn2lQ4yEoK9kvMsg8gUD9htK4TnGGzzPAepn3pDKaF5H82b1cdymfSRIsGdv0e7GMYttTmDhbYizH7larvmU7lRm6jN2XOYu+FFQyxTPeoW8m4K3Zox4LkNAsychng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5Q2W+As5oof5jjB8RJ+YXVaacZn7qdBFFEzY2f4oOI=;
 b=w3q23O+qCujst9Sdeg2QViSpOhZvMUL6eId84Gx3hydck6Yy+OvCPmr4PIpN/6VDYDmKlKjUp8B4Ktbn23b4VW7a1ZLspr0CdQGygQsK+1QO3flLt08JrTT1E3TpYmwBixb9eX/riHJrzP8DfbdghN7iRUetPXXzTYPdHxsjMYmqOMF+OchcPLIp46V2mcpwqgDwxWkhNxONV/GQs7e94Er4w/2yY7saqFdWdKN5h4u9j03XK7PBRaJMwCbh21YzhQ2ni8zp5KaqOOYRcYBjgakZIDCVqtH4EPUTGHYPOVFkKDCui01b77obDCR6HeFLMX6NDRGBfNsgpqwOBB+uWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5Q2W+As5oof5jjB8RJ+YXVaacZn7qdBFFEzY2f4oOI=;
 b=G+yoTBLU+2TKZf9tu6J9AaVZXaK8bk8bh8wh8PCpvO5Wg/pUyJWSNLbAlrhQkDhfjVX3pPD6ydDq2W3G2Lbo2MIETRAlUvnaXOsPRnmvH2WzGUifZ58WNYsWFd0wo1l6a2Xr55opx6sYD2Ii0eoC144/+gPQn2ucsvZakAEXUSE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CY5PR12MB6228.namprd12.prod.outlook.com (2603:10b6:930:20::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Wed, 2 Jul
 2025 08:52:07 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 08:52:06 +0000
Message-ID: <6e88abac-88fd-4b65-abff-bb36c2e7203c@amd.com>
Date: Wed, 2 Jul 2025 10:51:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] Improve user feedback in case of FPGA bitstream
 load failure
To: vtpieter@gmail.com, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Pieter Van Trappen <pieter.van.trappen@cern.ch>
References: <20250626093519.115655-1-vtpieter@gmail.com>
 <20250626093519.115655-2-vtpieter@gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250626093519.115655-2-vtpieter@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P190CA0013.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::26) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CY5PR12MB6228:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f8844ec-b70e-4ba5-80d6-08ddb945b93d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c3JyeWN3Y1l1Tzc1YWNSQWxwbWRWUlZPWFArN1JUaVVGdUxOK1NKSDIwdjdi?=
 =?utf-8?B?aythdkpRS3czd0VQcGFGWFZLUW9GWXJwVkhpWEVEMjN2YWFxd3Zwc3YwYWJm?=
 =?utf-8?B?cEJYSXRYNk5mMm9VcFM3dWRuRzQ1anlnU3BnLzRmV252dHk2eWVaOWMrMGNk?=
 =?utf-8?B?dHVKWG1SbVhBUmZGQXNud1dRSDZMVlFNMXUvYjV0TWZDVklUdXN0VW15RWtD?=
 =?utf-8?B?WlNBUFNaaWxNWnFiVmY0TWRmWEZvZGFWWXhhcDVpcWkzODYwOGYxSC9VNTZY?=
 =?utf-8?B?eTRyQVlOMXZaUDJvTCtHQUdPYSsyZE1lbFVvclBzeFk2RGJlQUdWSG93Kzkw?=
 =?utf-8?B?UXp4TmVZR3NTTjI5NVp2SkVRS004dUF6N3lTa3pMQmkzVEZNY3dyRGxRMzVO?=
 =?utf-8?B?eEw3M2xGYXRncEdweHBBQXRoRTlIZnV4N0o3OFZKcGIyKzQxSnM4WFJ4RHBz?=
 =?utf-8?B?bUFKRDM3VmRZREJNaC8vNXF6WTkrYTVGMTcwVmJDWXFWQXh4M3p1MEUwNDlh?=
 =?utf-8?B?eXdCbkZ5ZFF2cTFPVkxqOGRpNDZ3dzJ0SGl0M2QzUzkxQThKS2RsY1ZmZ3FY?=
 =?utf-8?B?Q0xjRUxGa1YxTmJpMU0rVU1PVE9kRlJNdVVEM2RCMXl6YzdXK3d3OWNMaVE0?=
 =?utf-8?B?K1pFMVlRTlJzYzduY2RWa3k1NWhzdlNLSFd4QnVnM3FNQVRvR3ZPamxIam53?=
 =?utf-8?B?Z2VpcWpKQklDZWN3WmdRUXNkR0UxbDBROW0zVlF0aUpnQjE4MWdQTDh4ZG1k?=
 =?utf-8?B?Z2dGek5Ca21lRG00ZHNrWndvVzFwSlFMR3VrTUt1Vk9QOHpwKzIyM2lkUStV?=
 =?utf-8?B?MGFrUjdpbGRIZGdxYjBYaHhvczZwalpEbFE5MjBldzF0WG5KVXB3alBqZnFD?=
 =?utf-8?B?OE1qTlVvMXRjS3EySzNmR0oxVmZlUDROU0NLeUIvZ2s3YUFSYmt5OFh5SFRG?=
 =?utf-8?B?OFd2Qkp2aGdBYSsrN3RRWnR6bDVTa1pvOEp5Tk4yeVUveHh1MTVpQTVIcytq?=
 =?utf-8?B?S3AwdGFVT21McXdFNFI1eEdkS25JUmVycVJoTGUrRG5tM284dUE5M0RWNmM2?=
 =?utf-8?B?L3BYZmZRUHZaVGpSb0pnM3VOV1R5S2xZSmFVSHVrcGRKSFdQcW96LzU5QU5l?=
 =?utf-8?B?MU5EQ3lvK0w3SDlhdGpodm50TW1oeGM1THlNVFB1YllsYlU2bnUwQUw5UmxD?=
 =?utf-8?B?bFBmQmdQYURiUklwVnVhalkzN2o2ZVpDNWdvVXJOSHB1b0syc2toNTVNWUJO?=
 =?utf-8?B?L0d4SDBzNWR2bWM1TkZrbXRseWZJMTlhZkF6NWZVV1BjNkNoWUJDN0k5RTFm?=
 =?utf-8?B?TlNYQi9VWCs2Z1k3TGU5Q2pYRm54V2dvUXY1eVpPMWxvUnRIM1ZNTER4SDI2?=
 =?utf-8?B?bmk2b09NTXpUbEFiUGNLcmxjaFhOajRlZGZ4cElOWjRMWStXRm42d0ROZmJk?=
 =?utf-8?B?ZlppcTVzKzlCV05SUy9DNytkNVp3WlVsMElEa2FGbWZva0M0b1NETjdPdmFp?=
 =?utf-8?B?Sk9EeUkvSGdRRnI1SWpPbUhnK1ZUR2tDUmM4U3JwM05VcmFraC8vbkZRVjYz?=
 =?utf-8?B?N3RLODMvVXhsVnpHSld1ZzhvN0ExOGY1MmpTTitXNWpsUzlSU05pQjltMHBh?=
 =?utf-8?B?MC9CbEZLdFpsYTFOMUlOR1UvMnFQZS9DQ1puQmU0UDl5bnRFaFlZeHRoV2Va?=
 =?utf-8?B?UFVLTGpSSDRDK0Q3L3pCWEo2Mk9oRi8wcWt0QVZ6QnY1c25WMVFOK2JMdGUz?=
 =?utf-8?B?alptMmEyUVl5cjlheEEySXkvN0V3K2E1dXhQckpoQUdLdkdKR3BVdkxqSE0v?=
 =?utf-8?B?K0RtMzRidzh2R1U2dlp2TUpqbW1saXU2WEZUeWNpcXMzWVZ5cENvZnVFNDlm?=
 =?utf-8?B?YnhwL1pYaUNXaDdDOU1qQk5uQUpHSmFyR0w1aXNidDJkaEJTeDZBdzBvYS95?=
 =?utf-8?Q?hZTndYDks1s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWtodVptNWRhdEwyakdoVGlnbkEwakFxQ1FWNmlJSlRtZm95anNOOXFXb2h1?=
 =?utf-8?B?YnRtSDNVcXRhbGk1OWxqbXRRaUtWK0p3R05jNER1a05Eb21Pd2JpZ3JpOFpI?=
 =?utf-8?B?Zm5QcUU0ejFhdkZrK1Q0OFI0L3JtZnZGYWtta0ZlcFF3R0p5Qmc3a0RJWURG?=
 =?utf-8?B?dXUrak1pSGx6VVBsWU0wRVIxR3F6YXJPdHFOSnBadmY3aXd2QUJEOW9NZExI?=
 =?utf-8?B?QmFCOWI3OUNtOUV0U3N4c3lHcnNSNmJTVkNVQzE4WXoyeC9Jc0pjeU9zejdi?=
 =?utf-8?B?VFlocTl6L2hjN3c2aEM4Y0U2MzVsYW9uMjcyd082cGNZY1F6aXdBekFCVDYy?=
 =?utf-8?B?L2lTWXZ3bWhpbFJZOGZWMXhlME1wUEpUY29YRStYazJkeTV2amt0VHlUNThJ?=
 =?utf-8?B?c0lVU1VZamxNZ2hGQ2VJTFdkaldPSkhEQ0x5T2h5MWVrVTNqMVhTODlBeUJp?=
 =?utf-8?B?RzJQeGx0dGkxRzQzUUlpNXVmVzJXc1E3OWhyaG1PYjJxbU9GendmenZoWFpu?=
 =?utf-8?B?bFNwSzNTTThUaUl5Y3pTMG9Kd1loZUU3alIyVWE3b3QwekZkV1k3eHdvZmRN?=
 =?utf-8?B?dDQ1VHkwMmdITWRCcjZ0UXNIS2w1Y0R6dGw3OEd4ZVVEeHZGUGJlTDYwekgz?=
 =?utf-8?B?d0tqRHlydXk5OUlGN1BTTDc5eHZoNE1NbzF0a3RpRFNnSElxY05xMFJVN0Vz?=
 =?utf-8?B?ZEd1a0JzTjBCVjFwZW9BZWpwU2FWc3E5aHdEQUZ4Z2J2T00wKzNSR3FuT2M4?=
 =?utf-8?B?NW83TnNvWGlob2FjVjlycTBwNW5uSTZzZXVXZ1hXRWRBZjUzVXg5dkdpQTJ0?=
 =?utf-8?B?UEZwWWo2VlVRelFlY2c1Q1lRMUJCT2lBL3IzMFE5WThaRkJiUUYrSWVXNWhC?=
 =?utf-8?B?QlhtbE5hMjZvaEkvb0dVcjJGejJaMS9aNnNnamNNMGN4Ymh3a2xMM1RvTXJW?=
 =?utf-8?B?NjdFaFNoLzZMTENiSS91ZENXMldrMFRaS0pMR04yR25mV2lZU2YwUGFxaFlx?=
 =?utf-8?B?RDZSelBjdFE2MFAyZ01pUjZuQjJVZTU4MVhGQ0FTb2psbk8rNnRTVFkrMDdS?=
 =?utf-8?B?UWthWEFlR2gvNkZST3NHQjN2c0JsM2l0SGlpYk9tbitJR0hKcTlJMGsxc0xn?=
 =?utf-8?B?aFhIYUpWL3RBc3g5aVJHblpuVzlxZVNoVjFUanV1Mm9ReklaRWdVV0c5ak1J?=
 =?utf-8?B?Y3UzZmR6WnkyMi8yWFQ5MDAzVXordnNnd2crN0xlZWNSeWNPOTZiSGJqeDFn?=
 =?utf-8?B?ZC81RW43Q1I4MDNXTFJuMC8ySVBpdGFlb1JZMjQxaFFOYTdLUUt1VCtNRU0y?=
 =?utf-8?B?MUlrbkFqWHNoUWxhR3dZNkpWV0UrYmNkaE1ZTTI0MENTQVNTc1lWVmVkcGpl?=
 =?utf-8?B?ZEJ4YkJKdUhmZEZsbmdwcmhPSXpEazNQQWw4MGtYMUNza0ZxWktma1ZYUzdG?=
 =?utf-8?B?RWkxWXhzVzBRWTc5NG9RYmNTQklnRGgzZzV1NU0zQkorZnEra0oxNWVmR3gv?=
 =?utf-8?B?bjJicXZhWWVrQ0xQakxSZ2tKcWRzcjFERHpUU2doY3NQNEdNN0JDcHBmMUdC?=
 =?utf-8?B?a3VQQ0lqeUlXVkJPYi9ZL0RPeHhPWmRySWNtd2FuV1FmYko3cHVBRUlENExn?=
 =?utf-8?B?U3luaGxNbjMzM1BVT2VqVENGS2E1Rk13cmdxT2c2M1VuVEZXSFNXT3FEUUpm?=
 =?utf-8?B?amZuQVBEK0NUdkR6NTdFcUZvQjhyOCtKVXdSNkdPYUxVR3ZFaWF1aUp6aGFN?=
 =?utf-8?B?blE0aFdzdHFIWVh4ZG5EZ1FyMXphQjgzdHdoaTJzcHpMMDkzKzBjbUFkOEI2?=
 =?utf-8?B?dHhlWjJzbW9TSkxpaitCMjVLRW5pTnNhT0hTMVhRSC9qR2VUZXVPVkRYRkQ3?=
 =?utf-8?B?VTZhcEs5ODRqWk16V3MyUlZKS01QeW9ZVzVNYzdMYTM4UDV0UVJQM3pJZFR3?=
 =?utf-8?B?ZTJTdFlHMzIvUEhhR0IxVkhPWkx4SGpiMzB2NHNsdzhxUkVNRkRDQjZKa2t4?=
 =?utf-8?B?dzFNVXFmQXJ3RldTM2Zrdi9HWGdrdXJlbndXZENyd2pjZ0NmUklrK2kxaHkz?=
 =?utf-8?B?eXlJdnZVQVYwK0FCQ3JoRFV4OGNVQXExK293WWJBWDBZeDhGZlU1VDJ1V3Jw?=
 =?utf-8?Q?zsyYrnqzMBJH1PHM3YvqvoG9t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f8844ec-b70e-4ba5-80d6-08ddb945b93d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 08:52:06.9238 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yBogQB8kZi8cyFWwdfg7t0Cw3dfdoRCxqwpNCww7ILXNRzhY5aghP3nnyARB9PGa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6228
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



On 6/26/25 11:35, vtpieter@gmail.com wrote:
> From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> 
> In cmd/fpga.c, change some `debug` calls to `log_err` for important
> user feedback and use CMD_RET_FAILURE in favor of CMD_RET_USAGE due to
> its long output which hides the actual, useful return message. Change
> the remaining `debug` calls to `log_debug`. Remove all 'fpga:' and
> __func__ strings as `log_*` has this covered.
> 
> For `do_fpga_loads`, move up the `do_fpga_check_params` call for more
> consistent command output; use a constant instead of multiple '5' use.
> 
> In drivers/fpga/zynq*.c, change 'up to' to 'above' which corrects this
> confusing/wrong statement.
> 
> Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> ---
>   cmd/fpga.c              | 99 +++++++++++++++++++++--------------------
>   drivers/fpga/zynqmppl.c |  4 +-
>   drivers/fpga/zynqpl.c   |  4 +-
>   3 files changed, 54 insertions(+), 53 deletions(-)
> 
> diff --git a/cmd/fpga.c b/cmd/fpga.c
> index 9dc7b63db5d..9cc51f04698 100644
> --- a/cmd/fpga.c
> +++ b/cmd/fpga.c
> @@ -28,7 +28,7 @@ static long do_fpga_get_device(char *arg)
>   	if (dev == FPGA_INVALID_DEVICE && arg)
>   		dev = simple_strtol(arg, NULL, 16);
>   
> -	debug("%s: device = %ld\n", __func__, dev);
> +	log_debug("device = %ld\n", dev);
>   
>   	return dev;
>   }
> @@ -40,26 +40,26 @@ static int do_fpga_check_params(long *dev, long *fpga_data, size_t *data_size,
>   	size_t local_data_size;
>   	long local_fpga_data;
>   
> -	debug("%s %d, %d\n", __func__, argc, cmdtp->maxargs);
> +	log_debug("%d, %d\n", argc, cmdtp->maxargs);
>   
>   	if (argc != cmdtp->maxargs) {
> -		debug("fpga: incorrect parameters passed\n");
> -		return CMD_RET_USAGE;
> +		log_err("Incorrect number of parameters passed\n");
> +		return CMD_RET_FAILURE;
>   	}
>   
>   	*dev = do_fpga_get_device(argv[0]);
>   
>   	local_fpga_data = simple_strtol(argv[1], NULL, 16);
>   	if (!local_fpga_data) {
> -		debug("fpga: zero fpga_data address\n");
> -		return CMD_RET_USAGE;
> +		log_err("Zero fpga_data address\n");
> +		return CMD_RET_FAILURE;
>   	}
>   	*fpga_data = local_fpga_data;
>   
>   	local_data_size = hextoul(argv[2], NULL);
>   	if (!local_data_size) {
> -		debug("fpga: zero size\n");
> -		return CMD_RET_USAGE;
> +		log_err("Zero size\n");
> +		return CMD_RET_FAILURE;
>   	}
>   	*data_size = local_data_size;
>   
> @@ -70,51 +70,52 @@ static int do_fpga_check_params(long *dev, long *fpga_data, size_t *data_size,
>   static int do_fpga_loads(struct cmd_tbl *cmdtp, int flag, int argc,
>   			 char *const argv[])
>   {
> +	struct fpga_secure_info fpga_sec_info;
> +	const int pos_userkey = 5;
>   	size_t data_size = 0;
>   	long fpga_data, dev;
>   	int ret;
> -	struct fpga_secure_info fpga_sec_info;
>   
>   	memset(&fpga_sec_info, 0, sizeof(fpga_sec_info));
>   
> -	if (argc < 5) {
> -		debug("fpga: incorrect parameters passed\n");
> -		return CMD_RET_USAGE;
> +	if (argc < pos_userkey) {
> +		log_err("Too few parameters passed\n");
> +		return CMD_RET_FAILURE;
>   	}
>   
> -	if (argc == 6)
> +	if (argc == pos_userkey + 1)
>   		fpga_sec_info.userkey_addr = (u8 *)(uintptr_t)
> -					      simple_strtoull(argv[5],
> +					      simple_strtoull(argv[pos_userkey],
>   							      NULL, 16);
>   	else
>   		/*
>   		 * If 6th parameter is not passed then do_fpga_check_params
>   		 * will get 5 instead of expected 6 which means that function
> -		 * return CMD_RET_USAGE. Increase number of params +1 to pass
> +		 * return CMD_RET_FAILURE. Increase number of params +1 to pass
>   		 * this.
>   		 */
>   		argc++;
>   
> +	ret = do_fpga_check_params(&dev, &fpga_data, &data_size,
> +				   cmdtp, argc, argv);
> +	if (ret)
> +		return ret;
> +
>   	fpga_sec_info.encflag = (u8)hextoul(argv[4], NULL);
>   	fpga_sec_info.authflag = (u8)hextoul(argv[3], NULL);
>   
>   	if (fpga_sec_info.authflag >= FPGA_NO_ENC_OR_NO_AUTH &&
>   	    fpga_sec_info.encflag >= FPGA_NO_ENC_OR_NO_AUTH) {
> -		debug("fpga: Use <fpga load> for NonSecure bitstream\n");
> -		return CMD_RET_USAGE;
> +		log_err("Use <fpga load> for NonSecure bitstream\n");
> +		return CMD_RET_FAILURE;
>   	}
>   
>   	if (fpga_sec_info.encflag == FPGA_ENC_USR_KEY &&
>   	    !fpga_sec_info.userkey_addr) {
> -		debug("fpga: User key not provided\n");
> -		return CMD_RET_USAGE;
> +		log_err("User key not provided\n");
> +		return CMD_RET_FAILURE;
>   	}
>   
> -	ret = do_fpga_check_params(&dev, &fpga_data, &data_size,
> -				   cmdtp, argc, argv);
> -	if (ret)
> -		return ret;
> -
>   	return fpga_loads(dev, (void *)fpga_data, data_size, &fpga_sec_info);
>   }
>   #endif
> @@ -245,23 +246,23 @@ static int do_fpga_loadmk(struct cmd_tbl *cmdtp, int flag, int argc,
>   	ulong dev = do_fpga_get_device(argv[0]);
>   	char *datastr = env_get("fpgadata");
>   
> -	debug("fpga: argc %x, dev %lx, datastr %s\n", argc, dev, datastr);
> +	log_debug("argc %x, dev %lx, datastr %s\n", argc, dev, datastr);
>   
>   	if (dev == FPGA_INVALID_DEVICE) {
> -		debug("fpga: Invalid fpga device\n");
> -		return CMD_RET_USAGE;
> +		log_err("Invalid fpga device\n");
> +		return CMD_RET_FAILURE;
>   	}
>   
>   	if (argc == 0 && !datastr) {
> -		debug("fpga: No datastr passed\n");
> -		return CMD_RET_USAGE;
> +		log_err("No datastr passed\n");
> +		return CMD_RET_FAILURE;
>   	}
>   
>   	if (argc == 2) {
>   		datastr = argv[1];
> -		debug("fpga: Full command with two args\n");
> +		log_debug("Full command with two args\n");
>   	} else if (argc == 1 && !datastr) {
> -		debug("fpga: Dev is setup - fpgadata passed\n");
> +		log_debug("Dev is setup - fpgadata passed\n");
>   		datastr = argv[0];
>   	}
>   
> @@ -269,20 +270,20 @@ static int do_fpga_loadmk(struct cmd_tbl *cmdtp, int flag, int argc,
>   	if (fit_parse_subimage(datastr, (ulong)fpga_data,
>   			       &fit_addr, &fit_uname)) {
>   		fpga_data = (void *)fit_addr;
> -		debug("*  fpga: subimage '%s' from FIT image ",
> -		      fit_uname);
> -		debug("at 0x%08lx\n", fit_addr);
> +		log_debug("*  fpga: subimage '%s' from FIT image ",
> +			  fit_uname);
> +		log_debug("at 0x%08lx\n", fit_addr);
>   	} else
>   #endif
>   	{
>   		fpga_data = (void *)hextoul(datastr, NULL);
> -		debug("*  fpga: cmdline image address = 0x%08lx\n",
> -		      (ulong)fpga_data);
> +		log_debug("*  fpga: cmdline image address = 0x%08lx\n",
> +			  (ulong)fpga_data);
>   	}
> -	debug("%s: fpga_data = 0x%lx\n", __func__, (ulong)fpga_data);
> +	log_debug("fpga_data = 0x%lx\n", (ulong)fpga_data);
>   	if (!fpga_data) {
> -		puts("Zero fpga_data address\n");
> -		return CMD_RET_USAGE;
> +		log_err("Zero fpga_data address\n");
> +		return CMD_RET_FAILURE;
>   	}
>   
>   	switch (genimg_get_format(fpga_data)) {
> @@ -303,13 +304,13 @@ static int do_fpga_loadmk(struct cmd_tbl *cmdtp, int flag, int argc,
>   
>   			if (gunzip((void *)data, ~0UL, (void *)image_buf,
>   				   &image_size) != 0) {
> -				puts("GUNZIP: error\n");
> +				log_err("Gunzip error\n");
>   				return CMD_RET_FAILURE;
>   			}
>   			data_size = image_size;
>   #else
> -			puts("Gunzip image is not supported\n");
> -			return 1;
> +			log_err("Gunzip image is not supported\n");
> +			return CMD_RET_FAILURE;
>   #endif
>   		} else {
>   			data = (ulong)image_get_data(hdr);
> @@ -327,12 +328,12 @@ static int do_fpga_loadmk(struct cmd_tbl *cmdtp, int flag, int argc,
>   		const void *fit_data;
>   
>   		if (!fit_uname) {
> -			puts("No FIT subimage unit name\n");
> +			log_err("No FIT subimage unit name\n");
>   			return CMD_RET_FAILURE;
>   		}
>   
>   		if (fit_check_format(fit_hdr, IMAGE_SIZE_INVAL)) {
> -			puts("Bad FIT image format\n");
> +			log_err("Bad FIT image format\n");
>   			return CMD_RET_FAILURE;
>   		}
>   
> @@ -348,7 +349,7 @@ static int do_fpga_loadmk(struct cmd_tbl *cmdtp, int flag, int argc,
>   	}
>   #endif
>   	default:
> -		puts("** Unknown image type\n");
> +		log_err("Unknown image type\n");
>   		return CMD_RET_FAILURE;
>   	}
>   }
> @@ -390,16 +391,16 @@ static int do_fpga_wrapper(struct cmd_tbl *cmdtp, int flag, int argc,
>   	fpga_cmd = find_cmd_tbl(argv[1], fpga_commands,
>   				ARRAY_SIZE(fpga_commands));
>   	if (!fpga_cmd) {
> -		debug("fpga: non existing command\n");
> -		return CMD_RET_USAGE;
> +		log_err("Non existing command\n");
> +		return CMD_RET_FAILURE;
>   	}
>   
>   	argc -= 2;
>   	argv += 2;
>   
>   	if (argc > fpga_cmd->maxargs) {
> -		debug("fpga: more parameters passed\n");
> -		return CMD_RET_USAGE;
> +		log_err("Too many parameters passed\n");
> +		return CMD_RET_FAILURE;
>   	}
>   
>   	ret = fpga_cmd->cmd(fpga_cmd, flag, argc, argv);
> diff --git a/drivers/fpga/zynqmppl.c b/drivers/fpga/zynqmppl.c
> index 2b62bbbe3cf..1199b249e36 100644
> --- a/drivers/fpga/zynqmppl.c
> +++ b/drivers/fpga/zynqmppl.c
> @@ -191,8 +191,8 @@ static int zynqmp_validate_bitstream(xilinx_desc *desc, const void *buf,
>   	}
>   
>   	if ((ulong)buf < SZ_1M) {
> -		printf("%s: Bitstream has to be placed up to 1MB (%px)\n",
> -		       __func__, buf);
> +		log_err("Bitstream has to be placed above 1MB (%px)\n",
> +			buf);
>   		return FPGA_FAIL;
>   	}
>   
> diff --git a/drivers/fpga/zynqpl.c b/drivers/fpga/zynqpl.c
> index 3e86d854a01..a8ca015a8a6 100644
> --- a/drivers/fpga/zynqpl.c
> +++ b/drivers/fpga/zynqpl.c
> @@ -360,8 +360,8 @@ static int zynq_validate_bitstream(xilinx_desc *desc, const void *buf,
>   	}
>   
>   	if ((u32)buf < SZ_1M) {
> -		printf("%s: Bitstream has to be placed up to 1MB (%x)\n",
> -		       __func__, (u32)buf);
> +		log_err("Bitstream has to be placed above 1MB (%px)\n",
> +			(u32)buf);
>   		return FPGA_FAIL;
>   	}
>   

I would be the best if you can create also cover letter.
But let me reply to this patch but issue is likely related to others. I am also 
not in CC on 3/4.

Anyway CI is failing with
$ tools/buildman/buildman -o ${UBOOT_TRAVIS_BUILD_DIR} -w -E -W -e --board 
${TEST_PY_BD} ${OVERRIDE}
Building current source for 1 boards (1 thread, 64 jobs per thread)
    sandbox:  +   sandbox
+drivers/fpga/fpga.c:23:13: error: ‘fpga_no_sup’ defined but not used 
[-Werror=unused-function]
+   23 | static void fpga_no_sup(char *fn, char *msg)
+      |             ^~~~~~~~~~~
+cc1: all warnings being treated as errors
+make[3]: *** [scripts/Makefile.build:249: drivers/fpga/fpga.o] Error 1
+make[2]: *** [scripts/Makefile.build:388: drivers/fpga] Error 2
+make[1]: *** [Makefile:1930: drivers] Error 2

which should be fixed.

Second thing is that all of your subjects are missing prefixes.
That's why please use fpga: or cmd: fpga: there to see subsystems you are 
targetting.

Thakns,
Michal




