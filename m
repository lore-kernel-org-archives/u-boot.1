Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81658C83013
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 07:30:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF0F781FEE;
	Wed,  2 Jul 2025 09:30:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nkAit+FQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06A9882103; Wed,  2 Jul 2025 09:30:41 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::62a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF1E781E13
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 09:30:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VYS/PNKgQ/8a4U6YuKEgQWVanOvxrbKmz0iv8o5BLfO4XGo4oftmzOsrIg1PGMECw97Oyjw35+DFfZge56HLlW6aoidL91wajHQZ0jmcFvYBkRLQVIMJjEwmXDFLkF8Rt8L+IWLAB9RJUqdXLCmZt3jAtZN5rKu2Hw3DqdqhZen1QAuF9Bin4NWg/M6GrXF4jSUDGVzyuuF9EQp8JEgsoDYQaog7MUK5orPpAGUZWMydr7O7t/5mRyDq10qCUtGmD1uTE7eqtfi4N+ZeFM3W1hFucATJcotEDo79trEbmMyx05+pWOR0jtWNjqAhpm+F9Zt5M3hMRNsfgaNBXQc6qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pb41X+z+pDG1VRVEWuRgureDIEop0L4jrzwE9JzHyZ0=;
 b=YHZqeHlcAYNQH7xCLzNKM6o/wCY1LwKxP4Xcd8YWC+/Dou+DdSO6nYpaEevQjMwJGuqJUb4y052zbYp2JxKja6t6vrCya9dEuufBSQf6iirLuz6AVmsX260Ay/ulYvcgtwRd8YG/o8NrDRpVMr02pkOC8/7XrgHFWjiob30Kggfy+1fqlfhTKpGPuNIDFVvik8obEnI/QuAoxM3n93K5pgGF3WR8fQ5sHVveTOMl0XmIE8zFNiquSj6wCWwpSxPS0fA65COBJH5PYXOZgruAF5elRCC9kOy6ZRtX4VD0E+Z02MRi9YmcNuJv9xAfl1O7yGvJ9w3lEswnc8riYk/x2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pb41X+z+pDG1VRVEWuRgureDIEop0L4jrzwE9JzHyZ0=;
 b=nkAit+FQuUzsRGJR5ACp9zm0lqkufo9RevH1LhqzSt5KFkwoavl8rHrBdwAutVs9sUXHZgcZnCkgVMJ2vFYUlclGmxVyzMnjOz8x8CKx6gJjpDSpWRBMF1ysPUzZ3l2tDtEcs7ajiS+90NClhWTQ/i41DEUEtPo2GD6YqQT2lBk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA0PR12MB4368.namprd12.prod.outlook.com (2603:10b6:806:9f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 07:30:35 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 07:30:35 +0000
Message-ID: <79595d34-3692-4cec-a28d-ec7df38ef6f6@amd.com>
Date: Wed, 2 Jul 2025 09:30:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: zynq_sdhci: Reset the host controller
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, git@amd.com
References: <20250626062440.295301-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250626062440.295301-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0224.eurprd07.prod.outlook.com
 (2603:10a6:802:58::27) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA0PR12MB4368:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c192b52-35e8-4157-da9f-08ddb93a5555
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RTVVdks4V2F4TFd3MW1wM0tOWTQza1FVOFVaWGp6YlVLWXp2NVpYa29UT29j?=
 =?utf-8?B?Y05jb0ZLc0ZTWGxlNmRFaDNsSmxPWE5ibTRJREtTZG5vU3lJRFYzcVVaanhl?=
 =?utf-8?B?RjJMMTFLendqN0VEbGhVTC85dXphOXZGZ0dDVFNEbVVETi9PK2oxOWhTODBz?=
 =?utf-8?B?S05Eck4ybzZKMGM2RTlTVkppM3ZvMjA0L25IdFpCaXg1bk1yMnVtQjhtak1B?=
 =?utf-8?B?dVZpQ1B3OVlyWS9xREprbHBnb1p1dzVKSHVzbU1uSE42UHE1TzZ6S0plOUJa?=
 =?utf-8?B?T0o5dDgvTUlMTnl3L0JYOXQ0V2xpUGZzbHh4Smc2MnZQL2lXMkpOd0ZnY3Zj?=
 =?utf-8?B?RnBmNXVsZzlVUko3V3Q2eTAvUGdlRmg3WG80bmtRZXhkcktYd2EyTXdiRGdj?=
 =?utf-8?B?NXhoUXdlTUpQc3lFZzlyTFpiQXo0dlZEMmZvc2g4U3VOTlNSaFhyWGtHZitB?=
 =?utf-8?B?aVppcHVVWERya0VqaEhMNVlhVUNXTERpdFMrczcyY3YwRnpwTGtOUVh2QWFk?=
 =?utf-8?B?K2pyVWZhTUZGRWpwNm9vRkFYR0NaeHhLNEFQQzZCQU1PUEpBRVg5cmJPQXZh?=
 =?utf-8?B?VDY3bHZxZDZoNHZnNmw1SFVnT0l6QnZGQWd4TUFISmhGNWZkckF4elNsL3hF?=
 =?utf-8?B?dmZrTTRhYVU3S09JVkIvb0dzRFJSdDgzd1NGSDM5SFloS0wwVVVEYkZ4S25F?=
 =?utf-8?B?cHd5NjcyS0lwaU9BMmJoWEFTTm5SL2xtd2hWSWpJbFJRaUpXRVI2ekVMNkVv?=
 =?utf-8?B?NGcva3pHMTBRNVRYbTY3cCtmVlkwL1A2VTJXK1lQd3plTGpQK1FhZDVvQ1BO?=
 =?utf-8?B?N2F6UTQzT0krUko2MGozaUF1KzcyS0pxb1hqTlJBTisxM3IyTUgrVjJZdjkz?=
 =?utf-8?B?SHpmVk9KUnl5bmNmVk8vN3lnM1RJUlBiRE1qRXZrbUxEc0txelRoVHFxQ0Ir?=
 =?utf-8?B?NEc5RWR1aTQ2MDdIenBGREl5dHRGMmxXVnM1aUxlaWFYK2x2N0w4eVVtZmN2?=
 =?utf-8?B?eVdWNDd4elZ3TnpNbnd1eitkcHZjb3BPcmp6Z0pPOExtckx0a09JaE55cEpF?=
 =?utf-8?B?T0RPRWdqRFVHNjNSaE1maDc4bnlWdzdvWW9CY2pXVmZ1RUJXOWk2SUFiZXg0?=
 =?utf-8?B?T1RsTVdxMzR1cWxKQ2hQb0VkOG5tUGt6SFB6Z0NyVDE5NlFFdDQ2bXFxR2Fj?=
 =?utf-8?B?YTF6eVN4Mmdkcm5yRU9QOWlnRk5QL21sSjkyZkY5RDd6Y0FybFNIQS84OFpn?=
 =?utf-8?B?cnlRaWpoM3UyM0JrWnRBTkVTQ0JKNFFaRyt6WUgrandkaG9iS25NUklxQ2g0?=
 =?utf-8?B?OUdxYk1UOTU1MmlIeHNheTdrdVR3VExWZVQ1VHkvaW1UaWx6MEZkeitLVnlu?=
 =?utf-8?B?bHdYaEJoZVNoUWo4V3lMb2NXL21LN3ZlZzJQcEhGVmk1UkwrL2xEMmZiK3c3?=
 =?utf-8?B?SEZ2SWptWkphKzNqV0JLTEFzeWQ2QWlqL2FYaXd0MVhENHBvMFFaKzV2dmRQ?=
 =?utf-8?B?SmR0dkhDbEo3cDFHZVJkSnlzdkNpY2czUE5aTHFicjI3WWFNeGNOdW1ranhU?=
 =?utf-8?B?T0JNZ1lGajdPZkJ6dk5wM1BpTGlPbERtL3ZGOWRNVVZUeloxTHVCM29GM25z?=
 =?utf-8?B?dW9TU0FoUStsbnZOVHE2aEE3Y0FxU2lEVTk1Z2JLZkdqWUNTVGNwdXBUZEhJ?=
 =?utf-8?B?citIeGxJclBWaEFna2hPWEdFR3Y4QjF2eFc2OG9BUTM0UGJzcTA2MzI0Zjkx?=
 =?utf-8?B?bEd6UjBoNkF2R0VKQS8wNDBFQllJai9oUEtSVUxmUGQ2NHRycWVrZ0Y2S1RP?=
 =?utf-8?B?ZXdNZUptcWVCUlhhZWQ1eWdVZTRxcGNaZkd0WCtoZkdMVGViMFZWNktGR1Vn?=
 =?utf-8?B?NER0dEhrUTNjZk82ckNPeGY3K1BFdURjUlhCSHNoa3VJUUdUTlQrQkM4MlFT?=
 =?utf-8?Q?EMvhbQ7VdZc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWU1SjI3MjNSeUVqdDMvZEVKcmx4R3VSMmtGN0IyQjFoRC9jMFNleHUrRVpP?=
 =?utf-8?B?S1JjMnVybVNvTXNPYUZ1U0RReWJtdU8yZ1I4UmtqaENIcWdIZ0M0TGNNMm9q?=
 =?utf-8?B?ajlJWkRCdUJYM0VIVHB3WHpKdTdmbUZmREJpSDBGVUlDeGlyMVQ4NHVlNFFK?=
 =?utf-8?B?bUxRT1lTT3JVUnRWdHBQVk5RMENmOXovSXpBUmZyVTJDUVhYaHhZUm05bFl4?=
 =?utf-8?B?UkJ5TnZOMXp2N041ZW9BWUd4Q1FBQ0VqVkFRWFM2Vi9vbEJRNzUyWXVmWmxi?=
 =?utf-8?B?NHlSdHdKankzMm9ONm5naDFjWGJFWnhlUVhjYi9reTZOdXIwdTRwSGMvRGVq?=
 =?utf-8?B?dXEyNHJkNFZldnI1RHF2RWRSTnRPRGpRYkw4elFEdnJ3Q0hRWlQweWRTRGhP?=
 =?utf-8?B?MTBRTTIyTmV0d2ZLM0NLUHJTcWw5ZGt6MHV3cUpkcjBlb2NrQ0JqYlFrNVBG?=
 =?utf-8?B?YkdRSXVRZjZKSHFzV2wzb3owSUxUU3N1SnhHcTJDN0V5VkRVQWg0ZmNmSmJv?=
 =?utf-8?B?eUVHYkJGekxyYXF3RjAvdmJLOWJyMjBtN2kvaHdKT2ZBaUYvUVhJd2NrNHlZ?=
 =?utf-8?B?S0tEeTVnaU9hYi9KZ3pEeEtja25wczlqRnBnS0xrbmh0aWI0NGJxajlEWlhK?=
 =?utf-8?B?NXpVWGhiQVB2V1BBd1FYckIwVkNPMXRhNkJJQnNiNDdUY3RZaklRVzVuZ0Fn?=
 =?utf-8?B?dXd6R1ZEbjZoTDFNalhndkliS25ady9kdWNOajZsK0hJdDBQYTF0RmREVFcv?=
 =?utf-8?B?TDJLTEtiL3RsaW84MENPWnpjWXhZQTluZnBlenBhV0hYU2J2bWtjUUs1MFRU?=
 =?utf-8?B?dHM5cGV6ck14OU93Qk9QV1BaNmp6MnY4c29Bb1l4WE5hQ3h2MUhVeWxZR3hV?=
 =?utf-8?B?dnpIaEo3aVgrMW0rVWZYWWcvaFd5aVVKY1Fpenp0d2hOM2lHWVpjalMvdXdz?=
 =?utf-8?B?bFpuUWtGVnBPK21FZmdKNVRiaml1WDJZT3owTzU3MTE3dDRvNGlWYjJMazBN?=
 =?utf-8?B?Ukk3alJia1VTTnYxZ1VhNkRYbHFZc3I5TlNpMFpNbE9NZXlLL2MzKzk5U2RL?=
 =?utf-8?B?akE5TFI2T3ZsQ0hGSTZrZmgzNVVjWldmVXVuQjI5UCtSaFZvQml2b1QzLzM3?=
 =?utf-8?B?TFdiR2hGOUYreUNTbUxzNnBZd0x3VytEV01OMG9KK2tlMm9jeFpSL3pxaTg2?=
 =?utf-8?B?NitlNGp3WEl4K08wZXBMeldJSnJIK1lkd3pjZ1JBV3BHSksvalJ2Y0UyQTVz?=
 =?utf-8?B?cjZEMVhmdkVNSVgvRG9kZEs3Wko2QSt4Q05UK0lEb3hLUERCcmhlRmJYOEk3?=
 =?utf-8?B?MTQxN3dNQS81K0J3R0ZYNUJkVklOR1N4N3VvODNTcThPM2hPc1o3M2k1TnM2?=
 =?utf-8?B?eE5hMW80U0V2Z2MzR1VWbUhXK2tNS0hXTkx2ekY5WmpSMzJnUGY0Uy9KYWFY?=
 =?utf-8?B?OGdlbERTb3hJQmd3V3BXS1pqbHJ4L2VUeHRwVlUvZlBBdEhCSHpsa1RVN2Yr?=
 =?utf-8?B?OHNyK1Y1eExnaERtaDBna3F3THhwQmFGUld1aWR2NnVtc25TRUxPVVd3M29D?=
 =?utf-8?B?aVVlbis1eUdNZmQ2a2N4M09mTjd4YUwreUw4WTdUMnMveU9kZWpTVk9UeWw3?=
 =?utf-8?B?WlZOaXBlcTVINlk3V0I1Vit2M1FBd3ltR2dic1E4V0Z2T0JFSXF3ZFFwbWlO?=
 =?utf-8?B?bkwzVWlyUmR4VC9jbHIzTm80ZWFDUDlxNk1VMGFMRmlQenBvT2hjUG9uYWov?=
 =?utf-8?B?L2hxQmFtYXJKd29FeW8yZks1TFQwcDV5bW1XeVNBMnVYaTFmRy9hUFdrZ0Nx?=
 =?utf-8?B?eUtZUnQ4OWFSTmh6eUNDTkRyRW9TUmRUWFlObXE5VnQ0Z1E2RFVXMHpqS2Zz?=
 =?utf-8?B?OFByeFAxUDBUOHZNWWJNbCtQb2QzcDhIQ3VJZ0doTVJnOGlKV29lWWR2bUc3?=
 =?utf-8?B?SjE0YVVvdEpNd3hQMGx2NCtSOVpKaWtrZGZXT3c3aGJLSHJEWmg2MktYQ3NF?=
 =?utf-8?B?K2hick1zbCt0eCtxZkhIVXQxd21ITExiZDhPSWROVmpNMktJYjFMMVpBc3Jo?=
 =?utf-8?B?NHQrait6OFVXcit1VHBxWnRza0xPVjEwbEdWZmwya1pPTERhTWJnV3l3QXdJ?=
 =?utf-8?Q?iQZMH7QUjBnsjwa+8PnKmsvhg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c192b52-35e8-4157-da9f-08ddb93a5555
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 07:30:35.0212 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r9TYWd+Xje4vcn6mPKeCvT5sgpA5ek/3PTNieY9FyyQDrM6dG+/+ot9+wOYIFgpJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4368
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



On 6/26/25 08:24, Venkatesh Yadav Abbarapu wrote:
> Reset the host controller at the early stage of probe so that the
> configuration will be done properly for reboot cases.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
> Changes in v2:
> - Reset is optional, so don't return if reset property is not found from
> the device tree.
> ---
>   drivers/mmc/zynq_sdhci.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/mmc/zynq_sdhci.c b/drivers/mmc/zynq_sdhci.c
> index 0e2bdab4e7e..4d1f92931a3 100644
> --- a/drivers/mmc/zynq_sdhci.c
> +++ b/drivers/mmc/zynq_sdhci.c
> @@ -1127,6 +1127,28 @@ static int arasan_sdhci_probe(struct udevice *dev)
>   	if (arasan_sdhci_is_compatible(dev, SDHCI_COMPATIBLE_VERSAL_NET_EMMC))
>   		priv->internal_phy_reg = true;
>   
> +	ret = reset_get_bulk(dev, &priv->resets);
> +	if (ret == -ENOTSUPP || ret == -ENOENT) {
> +		dev_warn(dev, "Reset not found\n");
> +	} else if (ret) {
> +		dev_err(dev, "Reset failed\n");
> +		return ret;
> +	}
> +
> +	if (!ret) {
> +		ret = reset_assert_bulk(&priv->resets);
> +		if (ret) {
> +			dev_err(dev, "Reset assert failed\n");
> +			return ret;
> +		}
> +
> +		ret = reset_deassert_bulk(&priv->resets);
> +		if (ret) {
> +			dev_err(dev, "Reset release failed\n");
> +			return ret;
> +		}
> +	}
> +
>   	ret = clk_get_by_index(dev, 0, &clk);
>   	if (ret < 0) {
>   		dev_err(dev, "failed to get clock\n");

Applied.
M
