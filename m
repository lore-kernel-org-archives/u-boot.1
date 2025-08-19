Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE3BCA0EF5
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 10:42:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F85780FA1;
	Tue, 19 Aug 2025 12:42:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="Hvdtx4dU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4357581FEE; Tue, 19 Aug 2025 12:42:41 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0B79802C1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 12:42:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bA8bQ8F4PEq/EA5PsYSglF6VoLqh/z7FA7fmnzovKARAqBJyUcxlB75yT6soYQ9lTgfohe0pyz06ezXb5GyJoi2gbaQl/z3dO9LQZTOp/YGeJCsAKdxqkm1ev5R0fkf1qUweBLz88hWBi5aDXTIDBSByMsyAxU8CmRXwlsLwG9jVlbKcXBL2HyUQw0qI0zDzc6Yy/KsOKylPqwCIj/ApL1gbr9/kC9jEt1HMXegA1Sz9h5kJGV81/krV0uURAXVFXwsYgY5mFlpPlHVGWZ8Sy9jlhhTnC7+np9Nb2DmOMHv+tEWj2vvdkXSJ42MI8QaWlITpU47C9fKf9FSLab3b3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwWVFn6JK6J151jVU+OwAFCqWxf3yTnTegAaovQoNwI=;
 b=RHxcJigZEbnWYzGmGE1d3LWXA8ZCgRLN7PJj8bH6IOBnDwoRunUdmg+/wsIiiWtg9pckpHbbSHO62cprVsowfxmJfyYYHz02iq+PQoehSjYfZkoGXkRrJGxy3VhE7uN5yjT5w3wkv2W6+syJ0NOdX+VINZzMSkmtkVt36MHxrD9WGJiBu/ZJjcDwzHPqsxjZp3WFRl9oBRi/Q91KaUEuOqZJwsXfYOQvB6ND5ksHKI43Nm8sYDtuOTB4qS0WTUIxLbk1UmlwcyBH/6LVZsBEeZbVo/B9bOzBQQnGUOiHiKWyFTP5QYSJSRDmjJMAlsueCUtskfo8AOaB404J+iSong==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwWVFn6JK6J151jVU+OwAFCqWxf3yTnTegAaovQoNwI=;
 b=Hvdtx4dUEKTP7quu0LHLDdUylCOn6sFhXWBiJZjF8w4czDOrsqZbccz9xLjkXmpDFk7G7X1v7BUACQnlQfF//oTsT95R0LkfaMSyBLVnUiox30Z5J/PEY98jGgCtVlgEnf2+rRUyUMwar/LE/H9/QBMfqsirfOIlZN1U5NSoAJFX5pcltRppsopF9ZuwiIvKZAV/suPnXwmTV75Qh/ICmJf58blIG3RBFfJH5eFREsezBHtrfK2TnmJebYAGhRlz5mQHZ6GK0iYw9Q79fSlwNlSNnFZUOM8mQgePmy8vbmJtoLRYxrgSVne9KQt4bDVv83qHMh6Elfc2RDZVDCer4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by GVXPR10MB9406.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:2aa::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Tue, 19 Aug
 2025 10:42:35 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9031.018; Tue, 19 Aug 2025
 10:42:35 +0000
Message-ID: <d2f236a3-b3dc-4949-bd3b-4020a4ba108d@kontron.de>
Date: Tue, 19 Aug 2025 12:42:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 19/21] mtd: spinand: propagate spinand_wait() errors
 from spinand_write_page()
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Gabor Juhos <j4g8y7@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>
References: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-20-mikhail.kshevetskiy@iopsys.eu>
 <d4e3714d-d687-427d-8136-5388694603ec@kontron.de>
 <8b7bcbd2-4c66-4e2d-b169-c79eb7081f2b@iopsys.eu>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <8b7bcbd2-4c66-4e2d-b169-c79eb7081f2b@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::19) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|GVXPR10MB9406:EE_
X-MS-Office365-Filtering-Correlation-Id: 18d46e89-2aaa-4ed1-ed3a-08dddf0d1bbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THdNaXVHNkxXWVZ6Yk9QYW9QMVJwaU5CUGJRWEFUTE9Jci9tVW1ibUpsRU5B?=
 =?utf-8?B?UitMcHEyWTR3bHhRQllCc04wRWtJcHBJUmoydlRDTmFuTDJZcElJRVZROGlK?=
 =?utf-8?B?Wk01bGQyQWJXOTBkeE9IYVNVbXM0WTBDWWduaWFLcmVER3paakgxMDRpb245?=
 =?utf-8?B?aFVJK0pRL09OcmE0ZURiZWVweVhQampxVGdyWEFLSTRYVmVTbGxORTlsUS9w?=
 =?utf-8?B?aGU0OXlCR05DN0p3R3hTQUQxd1R3b1pZdVJNSTZqeEZpT2RkaFpNL3JQczF6?=
 =?utf-8?B?dWp3cGpOUmg5ZXppay9JK2JqSFI2dTNBWENVR1BCR054V1U5TllSVUZCMVdW?=
 =?utf-8?B?ZkJTenpXMmw4SFo0eDNkaG9taVFXVXcvOGcvTUJzS3dUejBtTHVjd2Q5K09z?=
 =?utf-8?B?Y2drNUZiQXdleDl2NEFVdk5NcFMybFZvQjZja0wzcTBFcG5XVU5OODNSbGNh?=
 =?utf-8?B?K2FYU0ZKUHhrSksrby9zaGVlYkJ4WGs2eWkrL3ZDZTBUYm9oQ2d4ditQMERL?=
 =?utf-8?B?U0NyejhnaTFka0Fjc3RHWmlJMXlxQkk0YmJHZzRqMEYxKzdUZDRyL2Vxc0FZ?=
 =?utf-8?B?Z1ZUYXZqSmFYQncrUUJJV2M4SG5FdmZJQ25ScENVTjl6QVdyZWVXUGNQMXRY?=
 =?utf-8?B?Uk44TUtGQWtPVFBXbE9xa1E0MWtuWGtGd0tqQm04Z1JkU0oyTEVlazJUMmQ5?=
 =?utf-8?B?MDNhQ054b3dEU3hPV3dvbXpkdnllN1lJallvS01UWTJBZ096RHFiWlVxLzhY?=
 =?utf-8?B?andNbFZyMmw2RjRZREkrY09saGFRbSt4RW9ZNERQRWFUREJnWWRJOFVGNXV3?=
 =?utf-8?B?VkFFMit6bVdXM2twVjRWN3dScXdiWUVwZHFxV3IxZnN1K3M0V05YeVFHTmgx?=
 =?utf-8?B?SjJ4UWo0WnNvVkFCSzFTZGduc2pEa09Zb1p0aFk2Q2lsd2FSZGZnajlyZlVJ?=
 =?utf-8?B?Vm5HczJrQ2Q5T1pZQmpoY3haOXJUUGlqdUNNOFd5NlJRdWVjcU9nc01YMUVQ?=
 =?utf-8?B?c1Z2c3EvRmxMTkJDRDczT3AvcVIzSDA4YkdaVTBvZzc0TGdUR3g2RnI2TWtQ?=
 =?utf-8?B?WlU5SkJRSUZ6YXNzTVpZWUp3ZXhhbXl2ejkwOXY0c0lkajZqSDNrOGFqSVlk?=
 =?utf-8?B?WHdDcG1mM0NqckRPWWxuRGJmMTNCZXBZTXc2dzNmUWNvb0NGQkVieUxNQUpp?=
 =?utf-8?B?d0Y2UXVnbmhHekk2Ym9sc1YvMWJCM2pWTlVRZStRbEQzWFNzSGMrWTd0c2Ev?=
 =?utf-8?B?SjYySFJ5UGJzZXpmTWhvTlVPMmFBMmR1Ung0RktJSCtJNmJmTFNUUExhZ25H?=
 =?utf-8?B?QjlVNU1hSzE0d204TnBBUVhndXN4NjNQb3dGOXFYRXF5QVBIRko5c0tXNXR3?=
 =?utf-8?B?YVhKZnBFUlZkcW13V3hlS2VVbjg2OThaZzZWYkViSkxuS3ZXKzJlUDBtQzNw?=
 =?utf-8?B?RmZJSktja0ZDeUxMWkx0NEhQbkZuVXE2SDlGcC95Ni9DcGRtSGtQYXBselJY?=
 =?utf-8?B?R0hOVC9TMU1nRlk1Ym02UUhaZE1qS243d09ML0pNaDJQbld6K3pRcGhrYUxJ?=
 =?utf-8?B?RytYU0tRd3ZkQUFXN2JDQm5rcVA1M2RsWmZhSG1CRThYcitteWZiRlIwQ3dK?=
 =?utf-8?B?Rzc1eFVxWGJSYVNyUGk2YmtxVVhhV0hvRU1zSVBoTitYNk9RVU1CRDBzcnYy?=
 =?utf-8?B?dDBxNTBEWXBpZmJMWVdFZkJPYVV5L2lxejFXekc1TVU5Y2RpR1lvWldRT0tr?=
 =?utf-8?B?Y3FJTWYzOHBsdDh4RjQvbXhlVlFIeTZEem5UNWYydHpnb2pxWU1mK3VSdnJL?=
 =?utf-8?B?SzlrenRYdlRsalZKNWtzQW1kNjR0OUJYNkUzYjI3UEtwSnM3UklqdGs2YmhY?=
 =?utf-8?B?enhHNE90ZEtOai8rY25ZRWZxZVNDOXBhZlByb0pHWi9CYkxGMGovOEc3NTdW?=
 =?utf-8?B?blhmdjFFdWFnZnlOdGh0QWN2WTZLMktOWEgxMUhZNFZDWXZFWU5TWmFpQWhE?=
 =?utf-8?B?dWtrZktUMUV3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ymw5WEdLaEVzc1YxT3dBVitoZkhPQW82ci9DdnBxR0FyNGNwMDhzUkhGalNN?=
 =?utf-8?B?WDZnbDRQQmNZZXV0a2NGWGtqLzc0TDZoVFFyWkl4SW1OTlhyTXVtYmdDNXpM?=
 =?utf-8?B?RE5abjI4eDNYUnNVQ29CazlLUU5LNDFpcWdGZnBTYnd5Z3YxOVI4WU00b09H?=
 =?utf-8?B?VEJGRy9aQUgvcmU1bWxrMVNBSlYyZi85OXlRZGlVK0MwcldtUlhKem9jdnRD?=
 =?utf-8?B?RnpwRm5UaTVzcHM4M3dRdGxiZkYwbThlUU1La3pKOUhibWZVb20wUVdYS2Y3?=
 =?utf-8?B?cHlOdjllWXhRNHlWUmM3Uld1MDdYUVBpUjlmdnF1RkYrTnl0OXB0OXJMYXVJ?=
 =?utf-8?B?VHVQMmFUdlFxSHdpZE9ZUnNrZXdOU0NlWDlTRFdRa3ZnajF1OUJPYmxUMURq?=
 =?utf-8?B?U3gyazFHQ0tRMm1lQnVPM29oWVh5WUc5dUx6ZzQrbXg0b3BGUkZ4eGQ1K0Np?=
 =?utf-8?B?MUhEc2t6emFOMy9WNXp3Z0NXbzF6VzdmblZNeEJtRnRyRWRxamhoN09lNy9z?=
 =?utf-8?B?TENXQlVhcnNNZ2gwak50cTRMN1BVRURDd1VYQXlJUmRDUkFHMWRObytEVzhm?=
 =?utf-8?B?WFlSRlFEUVk4YVU1WTlPTWNuYXpGd09WRjJodXVpNmJna0l6SWNsM1NFeis0?=
 =?utf-8?B?ZS9ORUJtM1BaNXZwWDlpcDI4RENUN2hhUEk2Tms1N2h3TjJ3WjZPdjFQTGZ4?=
 =?utf-8?B?MVJXU3hzMDRPWURZNFlwcjM2eEp6WHRHZnFHTlVTNTl0UmFTS2ZlM01NU0F5?=
 =?utf-8?B?YVBDSFk2UTY0b3dvQU5HeHVsK2VsUmN4eXJFR1M0MVI5NDVxWXcvS2lnS1pH?=
 =?utf-8?B?V0Uzc0lMa0pOM1RDamRobE5zVHlRRFRtV1ZzTStGbnpwWjBxUjZ2NmRiWkg2?=
 =?utf-8?B?dWVRUVprbm93ZnJpOGJFWHRNNjUwZXJmdDBONHV5TXNRVlgxYVFEWCtLSmpC?=
 =?utf-8?B?R2t1MjB6TldNZE9hZUZaUFRRN3ZuUmJJOTBuZVdNYmNDcVBJa3J1cllJbWJ0?=
 =?utf-8?B?cXZGYjJCT2JRZVdCQ0JZMGJXaldHc0NMTm9ZdGpmQVBoTGFCbGRhTlo2YThE?=
 =?utf-8?B?WlY0RUdJVDlHM0V3aE1WY3NWWTZCdDBZbkptaThnenVZeG1JbkJkVndOOSsw?=
 =?utf-8?B?aXAxRlRrSDVFaGc4RDJ6ZWJWN2ZnTElvUTdJczJxT0ZtQTlhVnBheElVSjM1?=
 =?utf-8?B?bkpWTWxCVTNkWWxkTDZrUHplNUloaCsxZDhuVGwrYmF3VDJ6bXU2MGdTR2Rp?=
 =?utf-8?B?eW9XbjNQbkl2SlArVTZoL3paejFqSEtCWXFMZUVQRWhpdDlheDZuOG5vbkFn?=
 =?utf-8?B?U2FmUDRtZHlSTzhkQTNud09uMnlRN0xRTTkwMUQxU0dUbFdkRnRWenFYaEFo?=
 =?utf-8?B?bXp2RzhuRUFFUVAwRVhmanhQSWYzMEl3WXRpM2FBRUJJTVlNSU9HaHNzbmlX?=
 =?utf-8?B?cEtBUXN6Nkl0TUlsdGtWS3BuTkdVeWlNMU1ybFl4SjE5NUxVZWN1UmRLamhL?=
 =?utf-8?B?YlQyWHlxdTJhV0grMkl4WGZhakx5VXdpd0hjV0xabXB1TXNiMjVCYkZlMFBM?=
 =?utf-8?B?VStEalRGQ3l3Tzd0ZzRlb1FOOVFsdHFlcUVMNTMyRDNKR0JqeVpMVkF3cGJK?=
 =?utf-8?B?QlMwRjZsaURFSnZHNzVRanc0bHdIU0xSMi9PRjVQQXdOVGlhMkw5cDdrOXF0?=
 =?utf-8?B?QlJLcjVrc2k5QlhUa25zeElPbGZvcVU1dTB5SWlpSUI0aHZxQ3lGV0NIYnlQ?=
 =?utf-8?B?ZXFhdzFQdlpsRllZWnBiNWVlZVEzckJ2TjNkNjBpWXFvVHFueFdlZ2Y2b2hm?=
 =?utf-8?B?QXdBYThXSFh0YXdmRVN6ZUhURXByeWt5WkhYRXdPbi85YTNWYkJwYVpJVjJZ?=
 =?utf-8?B?ZmVkd3ErR01hTm43WUxOb3IxN0pQek5Lam5EdWVpSEhURjZTeDBLcmN4ZE9t?=
 =?utf-8?B?dGdQL3k4SUF1MGxqUnJETmExNTBURzFadmkwM09UY05uYUcybURTQU5jQnJR?=
 =?utf-8?B?YWcwRkRFZHBvdjVyWWJRZVUrdkV2bHlTOHBCbjJXdnJ0M0svS2dzTnBTdlNZ?=
 =?utf-8?B?dWhraVRiWmFSVkwzaUN4WVBLa0dpcEFvUkJobC9HLy90MVpreXFNcDQwN0Nx?=
 =?utf-8?B?ZGRsblBVcHBLWk5uTnh0VnlLbHgzbFRPL0VOYVZuMERKa3FZNlR6UW9xU1F1?=
 =?utf-8?B?NXc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d46e89-2aaa-4ed1-ed3a-08dddf0d1bbd
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 10:42:35.1633 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g9E4oGpWO+YoWYJPA4m7im5dWSciPJLn6cLgTrD09VvsJSwjVG2ZPumhtH60GMRRp7e4ImLFAShgBzXaPNx0+S+WLNKEp/WL0pm1YFLJzCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9406
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

Am 19.08.25 um 12:34 schrieb Mikhail Kshevetskiy:
> 
> On 19.08.2025 10:26, Frieder Schrempf wrote:
>> Am 18.08.25 um 12:06 schrieb Mikhail Kshevetskiy:
>>> From: Gabor Juhos <j4g8y7@gmail.com>
>>>
>>> Since commit 3d1f08b032dc ("mtd: spinand: Use the external ECC engine
>>> logic") the spinand_write_page() function ignores the errors returned
>>> by spinand_wait(). Change the code to propagate those up to the stack
>>> as it was done before the offending change.
>>>
>>> This is a port of linux commit
>>> 091d9e35b85b ("mtd: spinand: propagate spinand_wait() errors from spinand_write_page()")
>>>
>>> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
>>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu> # U-Boot port
>> This seems to be a fix for a change that was introduced in patch 10 of
>> this series. We should avoid introducing regressions and fixing them in
>> a later patch to preserve bisectability.
> 
> Hm, this a bit contradict with removing fixes for continuous mode. In
> linux, continuous mode makes some flashes (mostly macronix) almost
> unusable on some platforms.

Sorry, I don't understand how this is related to the continuous mode
fixes. I'm just asking to squash patch 19 of this series into patch 10
so the changes of patch 19 are included in patch 10 in order to make
this a single consistent change.

> 
> There are 2 possible bug scenarios
> 1) "continuous mode" flash and spi controller without dirmap support,
> but with restriction on transfer length in adjust_op_size()
> 2) "continuous mode" flash and spi controller with dirmap support for a
> single flash page
> 
> In the first case all reading above restriction in  adjust_op_size()
> will lead to EIO error
> In the second case all reading above flash page size will lead to EIO
> error or spinand driver fooling (because spi driver returns wrong number
> of bytes was read).
> 
> The second case looks as less critical, because u-boot up to this patch
> series have no spinand dirmap support, so no one need to support dirmap
> in the corresponding spi controllers.
> 
>>
>> Can you please fold this change into patch 10?
>>
>>> ---
>>>  drivers/mtd/nand/spi/core.c | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
>>> index daf6efb87d8..3e21a06dd0f 100644
>>> --- a/drivers/mtd/nand/spi/core.c
>>> +++ b/drivers/mtd/nand/spi/core.c
>>> @@ -691,7 +691,10 @@ int spinand_write_page(struct spinand_device *spinand,
>>>  			   SPINAND_WRITE_INITIAL_DELAY_US,
>>>  			   SPINAND_WRITE_POLL_DELAY_US,
>>>  			   &status);
>>> -	if (!ret && (status & STATUS_PROG_FAILED))
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	if (status & STATUS_PROG_FAILED)
>>>  		return -EIO;
>>>  
>>>  	return spinand_ondie_ecc_finish_io_req(nand, (struct nand_page_io_req *)req);

