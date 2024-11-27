Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBF2D6ACC5
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 12:33:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0FAE88E41;
	Wed, 27 Nov 2024 13:32:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3JHtB2w4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 062A2896CE; Wed, 27 Nov 2024 09:00:09 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::62d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21F83896FF
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 09:00:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xRDMCBMcapFeR8Z+7pJCr0fooPHhjKDeEYQgT/gm3hP2R2wY1e8K+Up2yZWd8oWUTGLc6XkgN544rtezTUlm0Yx+E56yUBM52cvd7uXmPPcKpTNengwDWBgu5v4fvRaNMmgM5OoA7Qv3yDDNY1Wcl2ZFxCbLPy6YiNPqsyHO1i+23BBzplQVICyykz7vsT/zWO7sHQFzDweAbZGI//cqdBnFrMxIBEXL0W5Ts1vsF39FDZIOCv/4JRb/Tbrus1Dn/ppZOzleZ4xOQQ5toTc7I2YMnh8DBBqoSRoYE2U9K/AcLBljvvVRHGFk3O3EwmlEe2CpKpoHFTJ2C30G82IW7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qm1jlP7S0FwVgk+8wxlmLZcSZbhdFUJruv5reLlUFJI=;
 b=sgc/rFqOr737db+IkmAf9wFd2lwM0a5+eXByfgLaJvdxj4QiPN2UIMzvOYfMNBiGePnEdGoAS9o0Nw/9O0j9A21q+EEVJbBRAa9nGFC176qGuKsItz5VtZy6yRt9egRrFt3dN+LUSr08G0/F9L9w/vJYblTdT9f5lMqkU/sVurTvtP/U048adN0SNQ+IspuKGQJ+FbBNJyawdagWU0dpiEMma2QrQDkZ2ZMtB+GsarGrLLJ4VO3ouxVchrbrkOB456dzpXT54UuZz5FzRjwYwDKyNUSCwRVrfLS51T2igP9GLv9WgTpxaUHNJOjNDOu2phhA+fMiCNf1EuDjdeqeIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qm1jlP7S0FwVgk+8wxlmLZcSZbhdFUJruv5reLlUFJI=;
 b=3JHtB2w42xrizFWucwf5rt8yS4Txxv6N5YMG6JHc2uS+pQyRcB7XSv+FcUAAzwWPdidD1Ig06+1gcd9qvQpWJF8EVX0YUAuZNPVPhCwNyI+gYfeUJWfkfLZvrUTYD6AJndXr7KsbI/u5+lXazOxlykzKkjI4rarw49hmn2PqywI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MN2PR12MB4485.namprd12.prod.outlook.com (2603:10b6:208:269::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Wed, 27 Nov
 2024 08:00:02 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8182.018; Wed, 27 Nov 2024
 08:00:02 +0000
Message-ID: <f28dfb34-7e73-46d6-9851-145d71d7f10d@amd.com>
Date: Wed, 27 Nov 2024 08:59:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] arm64: zynqmp: Convert platforms to use binman
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com, Simon Glass <sjg@chromium.org>,
 neal.frager@amd.com
Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>, Adam Ford <aford173@gmail.com>, 
 Bryan Brattlof <bb@ti.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Charlie Johnston <charlie.johnston@loftorbital.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>,
 Fabio Estevam <festevam@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>,
 Tony Dinh <mibodhi@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <cover.1730452668.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <cover.1730452668.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0167.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::13) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MN2PR12MB4485:EE_
X-MS-Office365-Filtering-Correlation-Id: 9be319d4-e61c-4f83-5ba4-08dd0eb97f2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QVI4aXpVbFNVMm1RTUthemVqNUlBNlM4S2dMOXFKSDI5MTNxV2V2S2dnZExp?=
 =?utf-8?B?SWhFZ09LTTR4b1dIVk9nSEsyK2FEUjFROHQ3Q3pmVjRwbjErMVZKekRSQ0da?=
 =?utf-8?B?MnNiNHViOVhvRUFNSHh1YXN3ODNQV1cvL3dPK3VJN0VEZHlVSGF4cE9zWG5s?=
 =?utf-8?B?MlNteW0wUzJtQ0JhWjhiZmx3Z1BuSzkzYXVKSUtqMFBQektzWTRpVEJhZFpr?=
 =?utf-8?B?d1NrT0xJZ2kvQzRXd2tOTVBBU1F0T1doQVhDN204WldoWTIwbXF5RDFJT2tS?=
 =?utf-8?B?akJQTk1seEIwRnF2ZnJ5aGhZTGFFeThJdUJCcG1wVytPUFNFRW9MQ1Q3K2l0?=
 =?utf-8?B?YllHYlgxbUZ6SXFOR1kwWTl0OFMvdUc0TXRaZkoyZzVLdno1eENWRVpia0RB?=
 =?utf-8?B?YW1SR1R0WmR6eDV0NnlJSENqYUFzQlRUSEpjWXpCckRYdWJ2c3VLVGFJbnVW?=
 =?utf-8?B?Z2M1YTVHai9qeVNLYkFVUnZENmFtaWtWczV3c3ZPNXcwM21uM24wWjJsOUJh?=
 =?utf-8?B?ckE3MTBMTDhqSVFyM3ZsTmVDK2t3b0kyQlZlVjBwSlpjM0c4L2VZeXdYeS9F?=
 =?utf-8?B?V2l1YmVLVmh3Ukc2ZEdjU1krczJoZ21JMzROeGUvRXJvMER0THZUb1NFVGFu?=
 =?utf-8?B?RGh4S0xFaDUzZWp2d293QTI4UTVqdkFkWklqT3N1T1BsWEpYVjdIZHdvVjAz?=
 =?utf-8?B?eXR1VDRZeGlWSTdnUk1iS2Q4L29vQnhSWUZhUWV0MWl5MUt3U3R0cS9NN0lr?=
 =?utf-8?B?WWxVOHVzNzBIcjNTQUNuZGpKQ25lejhHeUpFRWR6dFEzc1dSVzFueWU1d29B?=
 =?utf-8?B?WTFzdDYwLzhmMHp2b2t1TG5lRVVsUFo1NVJVLzllVHVpbTB1SXkxTUNUZVlG?=
 =?utf-8?B?L0thWHcxRDh5Q1NsaHhrcVhwV3dwOWYvVm1oSXFUQTVXcGI1S3hSZDVFNyta?=
 =?utf-8?B?clFEaGxZeExCUjIrQks4bTBkZ0tMcFJlVzZvRG5sbmE3OEwrZG9zUnhsejJI?=
 =?utf-8?B?QW5YdGx0K3c4MVNoRkJRaUVpSUJack43NVhQZTBWK293VFdrMlhLVjFkWU9J?=
 =?utf-8?B?THpKaTg5RWpnVWI3TEJrQ1lUbFJvcXdWaEN5KzlOMGtodzlLYmNlWnZPQVhV?=
 =?utf-8?B?dVd6RUtHeWFraGN0Zmc3QWYxV1VkbHlnTFNFYThiTEdwdmVKeUlLeTRvT3ZG?=
 =?utf-8?B?ZUszQ1lZeUxQaEFtMFBqQ3FxM0w0RWlFNkhSWU1YNzVmR0t1bldaK2xhUlIy?=
 =?utf-8?B?V0VqQ2I1SmF6MEgwUnRJb2dXSk1WSHR2T3ZndURpQjNrazNGd2hMQ0ZKV01F?=
 =?utf-8?B?YkcrcG5ldVB6VE9PS2liaWRKd2luOHpsZWFnRWZqZ1lpdUpMa1N3WVlmS1hD?=
 =?utf-8?B?UmZJTWxhNTNXbmJoYUxwclA1ZEtGcllsSmNLUFArZGgwNGtSSWhDalZZWVJN?=
 =?utf-8?B?aXpudlZadzFDaG1ZK3UvVDF3V2R4UGhKanpsczBsc2VlV09TMUh4M29xbTZG?=
 =?utf-8?B?NmRkSjVXOHppOEltWlBkSEpJWTVTZW1Jb3hYUGR6d3dxcXQyd1haWnV1MUhL?=
 =?utf-8?B?ZlkwUkNYVy92bVVmVGVmaEtKUTNvUW5FOGtEWFMxeVMwN08ySXNWUFhsVWM5?=
 =?utf-8?B?aC9jL08yZlVOd1BsYW5WOFJDZkZVbHN5NHFWdWpUWHUvK29xTVpsVnY0aTM3?=
 =?utf-8?B?Z25uNnhSRWxpSUFSeUtWYjl2SjhRRi8wVFpIR3VtVlJEcGg5eDlucjNGRk1Q?=
 =?utf-8?Q?YIF2+o55rJOcFZJwKmxhZpQ/e14TaLhFzT2xLaz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVhpcTdnQ29tb1UyNVFZeUhOWml3d0UvMDdTSHZIL2gzMm13Rzhna0FqaC9X?=
 =?utf-8?B?YzN1MEhZUGQ0d3VhQjRCRGdPZzZGRE0vZHlLVnJJc01hc0VRRzA5YVpMTTEv?=
 =?utf-8?B?RVF1NjdLU0VJaTRCRzFyTXVXT0RPRGxBWlFxK0hrV0RaRmdHUjM1UzJSMGFB?=
 =?utf-8?B?QjN0TmExcDFjRGdib0NjRnZNeEVDelNBMEZyRWRKaUJHYlpHc2NPUW10SXZz?=
 =?utf-8?B?ZTJqOGF1a0w3Sk5FcWp5eGo3Y21Yb0V0b05mSFI0dGdVNGovUUVvQUpzRFpG?=
 =?utf-8?B?Szc5YUhVUi8yWElVeDI2NTlzR1hncXlpZDRyOFBBU0swbms3NmtYY3RSNG9U?=
 =?utf-8?B?Z2FzZFV2T1g2Qm9DRVVPU2JVWUp0cUxKMzdCRFJUZ21BVEhVR082bXhiTHBr?=
 =?utf-8?B?SnpLSkluVnZ5MERqV1k4bW5lTVJ3ejVMbEFmTXVxK0ZMY1MzV1RsdlBCNzFW?=
 =?utf-8?B?a2dJWHM4YURlNVJLOGNpU25JdDVGclFyeTQ1RDBxRzg0MGNROGZBRWQwSnVQ?=
 =?utf-8?B?Sk1LM1pMN3N6eFNsYjRDZnh2dHoyRUNidy9HT1FVMzdiSHhlSEFIL2lLT2tX?=
 =?utf-8?B?bVdTQ3F1Z1NKOVFrUk43RFkrelByTUlySnFuZEFlWGtYa3Y3a1dDT3JMSWkz?=
 =?utf-8?B?VlR2Q2FaUVFudXJwcWo4RldZaE82Sy9vTVpyaDRodFNXQXNrMFNlRW1uc1p0?=
 =?utf-8?B?clU1c0NJRTNKck4zbWN3NThUcXN1QVg3T0RkZW1WNWJ2S0V3bEV3aDZkbnV3?=
 =?utf-8?B?ZGQrbHh5Z3FlWldXdVAvUEdaamp3WHZtVGRDTUg3VjY5MW9tV2I5R3NENmVT?=
 =?utf-8?B?SmtsbGR4bVllSjQ3cXR0bmhsRFQvNld5N2VLTXZqSmhydVducTBya052OHow?=
 =?utf-8?B?SUFocUNPZ2RzVGN2bkpSWFpaL29IRmoxK29IU2cvb0JWR3JQcGt3d0kxMjY4?=
 =?utf-8?B?Q3NlQkJsV0hzbmk0aGtDaldHUkFwZGdrTmF5eCtobGtqNmlQbndwT0IwS1lo?=
 =?utf-8?B?NTU1YVFJQytkdDhDc2lwalpua0hUZ0lSMW9yQ2tDK08veDNEN2NqdkFKSytz?=
 =?utf-8?B?NkNwTlQ5TC9RbWl6cXRsRWtrSG1qSjkzdFh5M3JKbURCeTBmMEhtaXNlYXRI?=
 =?utf-8?B?djA2Y1h0M0pkekhxNVdsNTdHSU9vb3lhZ2xhWmZxVHR0b0djUkdrQ29qa0Iw?=
 =?utf-8?B?ZWhkSWp5WkhJWmo3YmNaZG9YMzJDYloxRC9ZVFdBa0hiUUZscFlpZnBmR24y?=
 =?utf-8?B?eUNhSENHQVZZUUVESnJCM2hacXlMVXBheGVWU2JNaUZsWjlDcU12SVNHcjB0?=
 =?utf-8?B?OGQxZDU5aU5CamdRRmFOV3FJQ2x6cEs0VEV3T3pxRjBoNGlJRnNSOGo1eC9Y?=
 =?utf-8?B?TDczV284K1FVSm9NNVZFWFVMMitaZUwxYWU3YklheVY4OVJRbkJ3TW00Qldq?=
 =?utf-8?B?Y1JFbkxKOHRWZlJrTVljUXovaFA4ajNxUkFRd0xjQ1ErODIzaU0xeTYxOEUr?=
 =?utf-8?B?TGtubEtyUThrSFl3RzBscXhOY2V1eUdua2p6NE5XdDdiQ01xdGZiZWZzVHM0?=
 =?utf-8?B?TVZlaEVQOE1OZ3Y4SEN1ZTlBblpvNGdYNU9Cc01NcTY4VkNoUDZhR09CSGIy?=
 =?utf-8?B?c2s4UHNhS3gwbkNhMjFYZDEzcWxSZWQwZG8vbnZEeXlmZm9GYUR6Yks2YXIx?=
 =?utf-8?B?YXJibURicW5Oc2tBdU9DVHN3TkJKdnZKWnJCLzVXdkthMkcxT3prNFNNWSsv?=
 =?utf-8?B?eUtnUU9wdGluTlRFRmtzNlZOSWlWNkRvUUpjbFpZdURXRjlNRlA4YThpNTdv?=
 =?utf-8?B?RGYrNmdIWG96eFlHa0FHQ3pneVZvVDhNRWlleFFidWIvc1BFaFFQSEtnaEJQ?=
 =?utf-8?B?SDg2cWdIdzc3b1BwWThZc0c3aDlxQ051VkRkZVJCaTFFVDVicFJrVmRZY3k2?=
 =?utf-8?B?dTBSRUlDOTA2aWtLd1h2WWcxVHl6WHp4SVg4OWU4MVFZekpXa2VUb0xlaVV1?=
 =?utf-8?B?VU8xVk5OVUxaUWtzUWs2V1FvR2tmZDNLRUZLWTg4RCt3U3p0bHlyWnk4Wjds?=
 =?utf-8?B?RnhxaEVwQVozelBzVDRlVTdLTDRuQld0SUFhN1hTdXBhcXhqT2VXOTNTQWVI?=
 =?utf-8?Q?7FezWxwxL814jK3C6wOuCl0Hj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be319d4-e61c-4f83-5ba4-08dd0eb97f2f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 08:00:02.4633 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZP4WaouLb82gABBba8//tXRFtIL5NBiv16TtVhDGStfUep6TQZYHj/b69Un2F8xm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4485
X-Mailman-Approved-At: Wed, 27 Nov 2024 13:32:59 +0100
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



On 11/1/24 10:17, Michal Simek wrote:
> Hi,
> 
> I have put togethere couple of patches to convert platforms to use binman.
> The first patch has been sent separately. The third (SOM description) has
> been also sent out for ilustration as RFC.
> The last one is just cherry-pick the patch which has been reverted because
> our platform wasn't converted to binman yet.
> 
> v1 of external description
> https://lore.kernel.org/r/fbed0251437b61a2f7a85596d7403b5b9c8237c1.1728306322.git.michal.simek@amd.com
> 
> RFC for SOM:
> https://lore.kernel.org/r/de1b8dbabd5ab7f20d7aac217ec4f5074d39f1da.1728462767.git.michal.simek@amd.com
> 
> Thanks,
> Michal
> 
> Changes in v2:
> - Change subject, align commit message
> - binman - rename variable
> - Use relative path
> - Use separate variable in makefile to also handle empty string and default
>    to u-boot.dtb
> - new patch
> - new patch
> - Align fit,fdt-list-val to have shorter lines
> - Add reference to defconfig
> - Rename zynqmp-som-binman.dts to zynqmp-binman-som.dts
> - Use conf instead of config
> - Change image name from image.bin to qspi.bin
> - Remove RFC
> - Change default addresses for BL31/BL32
> - new patch
> - new patch
> - Rebase on the top of my series which do conversion to binman
> - Taken from git with all tags
> 
> Marek Vasut (1):
>    Makefile: Drop SPL_FIT_GENERATOR support
> 
> Michal Simek (6):
>    binman: Add option for pointing to separate description
>    common: binman: Calling initr_binman() when BINMAN_FDT
>    arm64: zynqmp: Describe empty binman node
>    arm64: zynqmp: Add binman description for SOM
>    arm64: zynqmp: Generate u-boot.itb and QSPI image via binman
>    arm64: zynqmp: Remove mkimage fit script
> 
>   Makefile                                      |  29 +--
>   arch/arm/Kconfig                              |   1 +
>   arch/arm/dts/Makefile                         |   3 +
>   arch/arm/dts/zynqmp-binman-mini.dts           |  10 +
>   arch/arm/dts/zynqmp-binman-som.dts            | 225 ++++++++++++++++
>   arch/arm/dts/zynqmp-binman.dts                | 111 ++++++++
>   arch/arm/dts/zynqmp-u-boot.dtsi               |  11 +
>   arch/arm/mach-zynqmp/Kconfig                  |  14 +
>   arch/arm/mach-zynqmp/mkimage_fit_atf.sh       | 240 ------------------
>   boot/Kconfig                                  |  15 --
>   common/board_r.c                              |   7 +-
>   configs/xilinx_zynqmp_kria_defconfig          |   3 +
>   configs/xilinx_zynqmp_mini_defconfig          |   2 +
>   configs/xilinx_zynqmp_mini_emmc0_defconfig    |   3 +
>   configs/xilinx_zynqmp_mini_emmc1_defconfig    |   3 +
>   configs/xilinx_zynqmp_mini_nand_defconfig     |   2 +
>   .../xilinx_zynqmp_mini_nand_single_defconfig  |   2 +
>   configs/xilinx_zynqmp_mini_qspi_defconfig     |   3 +
>   configs/xilinx_zynqmp_virt_defconfig          |   3 +
>   doc/usage/fit/howto.rst                       |   4 -
>   lib/Kconfig                                   |   9 +
>   21 files changed, 418 insertions(+), 282 deletions(-)
>   create mode 100644 arch/arm/dts/zynqmp-binman-mini.dts
>   create mode 100644 arch/arm/dts/zynqmp-binman-som.dts
>   create mode 100644 arch/arm/dts/zynqmp-binman.dts
>   create mode 100644 arch/arm/dts/zynqmp-u-boot.dtsi
>   delete mode 100755 arch/arm/mach-zynqmp/mkimage_fit_atf.sh
> 

Applied and queue to next.

Thanks,
Michal
