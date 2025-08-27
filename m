Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF3ECA0EFF
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 07:35:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F18B98319C;
	Wed, 27 Aug 2025 09:35:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wAxwzrEw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E890383189; Wed, 27 Aug 2025 09:35:13 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 018288319C
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 09:35:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5BcBSbRih146D0koQiKVBSmxaD+SHUQqRJOiX8tfD4EXxMwrryNpNzAwHuWPRGeETYkeoJqqFXI/L+NQq0Oc++unWU33cOACFdmTRZ6zle1Ltv6/K4SPyPL9KRfw+E3eN8or8lOZkIu5npi7nz82K24BlRhF7HZysx+m87YPQiXvEazYsIVehDAApRL+eGQZ9SaCeJ2lZlLlAvmmtRmQMO+Bp0elQGLJuC6hw3E0lWinx6BBCPl3BRw2kASQsntF+M3yCDjK8X/YrL1Df5vb7KVwUQs5tLHX4gZTcsILLkru6sqbLrWhSePs1clnwtKfVBt28wIkUlBgVDWUrw/4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38Hbxl9SjJkpjx69ml1dZIw3cHr7+BUcl0E8oohp5ng=;
 b=yYJ1ARhT23lJ0LrcK55a++81ZA5ishgF1hhd1bKPEXaaGdSWRkllcp5fFwBgEwpJMJxiuRxq13OBA47TPx+uPLUPBbY8TK1gpGYGe11/xZeDknMBCVZWRxGYEMOhKKumJMBry2H9QeA/VHE8UhslkvZDe8TnJiWhBvp0rkKpFALXUCdOD7NWFsE6NYb56EDmi8GtzMYRLq3Ipk98CD40oL58OyNGCrH79Ti7a6s+83IgMMA1pzjEu1m/CNxTfw+15pXVN3W7OzZL8nut0LMGDJ/Cao6GFi+ckSq49O9nzYNb+O+5zsAlmgsmK1JA3QV5kW3euoBLUp7klaMjwztwDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38Hbxl9SjJkpjx69ml1dZIw3cHr7+BUcl0E8oohp5ng=;
 b=wAxwzrEwvu6gaQtKlpqaEKCxkaPEjfTO8hLYedadfVlJsT2uxVgWeiFTUrk6EoRhD/xfkbh0Rsi/ykU/IBj2g+BBy82V8G7V3XCrhmbaij26PHago+EI7wZ2o6yjCXRV2ZFIzs8/3r8GJS4QHGSaLUNsTuvEwnleO4gG+wdoNvZCskwbBW9bM8YP+c8u9bABGtOsNG1pVEITKyMmaqPH4xdIu7JgZfnSOYrrdZXNiB4O97tssGBrFHSiOIivZ+RxtDuaeiYYBADGIQ1Pqw0rxVdDviMKJMv/k/laeOb0Ma6aWKixLxZVVnT4x010OYCSGd9u6RDcf/lY7tqrBE2TQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7687.eurprd04.prod.outlook.com (2603:10a6:20b:291::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Wed, 27 Aug
 2025 07:35:08 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 07:35:08 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 0/5] net: fsl: Fix some Smatch reports
Date: Wed, 27 Aug 2025 16:46:05 +0800
Message-Id: <175628406772.4168.13527044828734794146.b4-ty@nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250804-fsl_enetc-v1-0-0708a826f9fb@linaro.org>
References: <20250804-fsl_enetc-v1-0-0708a826f9fb@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::8) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB7687:EE_
X-MS-Office365-Filtering-Correlation-Id: 5661a9fc-076e-43fa-dde0-08dde53c3f92
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZVNyU21lUjNHcmxLbjllek1sYk1oMklGWkxsTkRYTFF4OUpGUTBYN2NiUGpl?=
 =?utf-8?B?bzB1UXU4ZTZ3Sk9iZXNNYjBuS3orK0MxZmwxSUhoUWZocTl0K2ZFSHpTVnd5?=
 =?utf-8?B?cDFNWXUrZkwwSll0dmIwTlRwb0lkZEg4bnJ3bWJqazhKK3lYRFBxcGdPOU9p?=
 =?utf-8?B?U0djWHlaeDNBeHNxMWRta0dVd3hQVUhaSmlldi90NWM3bWloTk9mUEtVTm51?=
 =?utf-8?B?OXE4cXR1RGl6Z0l3N3djeW9udnJhaHRwUW5mM1NXblR4UUg0NnIzRHVMbGQy?=
 =?utf-8?B?UW92RDBMQW92M1E2ajBGcFJtRVJWZ1krZm1rdk1HZ3hoS1FRTWplVDdZdlpR?=
 =?utf-8?B?NWZPZmR0T3JyRG9rMUlpNjhGNWVBbGFWYkYvUk8wTFlGakpOenFoZnNPak16?=
 =?utf-8?B?Zk5KY0NKampidVpYdVRWeTVYcG9VVVVNQndQcE5zNS94bXVZMWgwM3FLeWkw?=
 =?utf-8?B?ajh1alZjUjJIL2VkYlA2RFJsQzFMT1lwVVJyak42bS9kc0lwdzZIUzVsb0ti?=
 =?utf-8?B?RFk0VlhUK1o1TXErTmZrMUlGSnM3THRNZDhvMFRWV2ZuRXNsREVERU9EOTQ1?=
 =?utf-8?B?N3RMZGdSRXZpc2lrUXBPRW1vNlcxMmFGOXlUbFl3R0tJeGo3WFVzNEpqbXpP?=
 =?utf-8?B?SDlBME1xTU42bXNiZlViTnNOczkvWHA0TXdibFNmaEJCTEVla09jUzc2UDlL?=
 =?utf-8?B?dXRBZGp4MkJsdWJCR3JEZHF1dzFFdmxJTUVQU3lEd1lUK2hwMHNmZUlnQWw5?=
 =?utf-8?B?SGNGTFBvT3J5NHMrREZmUmcrblk5ZWtxYWFTak5GTUNxR1FIN3NxYWlwS1A1?=
 =?utf-8?B?Uy9TYWpFaHF4dThSMEhtL3VzVnpxTEUwZDV3OFdIYmNmTS9KRmFsbko3bk5i?=
 =?utf-8?B?WDV6cHNjUFB4aDBrSnFSbjBxeithV0hJeHViK2Y0aUJZYjg2YitBNFhmazlT?=
 =?utf-8?B?MEtQelRHclJyODFZekhZbnNMQ3pVWXlHclR6aTd1aWJ4aExkVHNyV0N6RlhT?=
 =?utf-8?B?TWJvWFlEWTJzcmRmLzA0YmQ0QlRVYzBjTElmM1VEOXlReUNvdEVIOFA3Y1o0?=
 =?utf-8?B?cFk2azlxRnZMU1orVk4rWVQxNnVuQy9aZnl4bUNNY1RkMm9qOWNSN1NjbGJF?=
 =?utf-8?B?VEg3WDlvZUNoaFRSOGJPMDM2T0dBU2RFWWp6ZzRHalFGZEd2REdkNmZoRzNh?=
 =?utf-8?B?ZUtlNi9WMTlhMWwxQmdhbjdiMzloWU9EbndEZUh0NzdDaGJBTHVOSHVmL08w?=
 =?utf-8?B?MzlMY2NOYllYbEc5Wk1hVEV5bUxlKzZQdDBlL3BxR2pFZDlRT1dyeXpaWkVx?=
 =?utf-8?B?QUh5M2trRDlQS2dzUnFsY3pweW9CVEVvTzRFaFBIYVNNSzZ1Nmw5eUU0MnlH?=
 =?utf-8?B?dEFxR3VkTmVRUWVsUE9YUGF6NmNaMWhOSXE1MlIyOGpJbmlycHNuOVl0d01u?=
 =?utf-8?B?UnREaVpPVDlRY2ZEMDhoNmRTUWo3UEVTNTBHRkgzVXdsVE9BTUpGajZKN3Va?=
 =?utf-8?B?R0pzMUpJckZLOWdLalIvQjdhUi9MNzN1Q1pYVklGcW9EMnU1RGdVTEFVK0Yr?=
 =?utf-8?B?VVBGbkNXZVVxZ2RjU1l4SmdGciszajFxS3J4cFd2Q01oL3pwUzZ0UDh5N055?=
 =?utf-8?B?cFJobWxQQUlYYUlJMTNjUmhIUDdpYVkzT0Y4UmlNWS8rT0ZDbng0Z1RaQkp0?=
 =?utf-8?B?bUovSlVaN21FNFRwZFZxc1lhQ2lYbHNjek0xd3JJL0pQczhrN3p0dFBKZUtO?=
 =?utf-8?B?bjkrSkRJTktMbW5YandxRGdOZkVXcHQxejhJRHU5cERNQnlpalVVdFozOG1r?=
 =?utf-8?B?NzlrS1M5ZHhUK2hsSnF0Tm1WdXRIeDQvcW1TNWxiTTBGMktWTHY2TS9aSHhI?=
 =?utf-8?B?a2dsMUpIMTdwa3dXcG1HaCs4OHQ2VWVjb3A4U1FBN0Mwd3RaUmRSRXM5VWFJ?=
 =?utf-8?B?NXNFRUVJZE1xVGxFaW4rRUU0YmpXSWRqNGMrZWhTdkNkbFhsS0xLMzQ0SE1S?=
 =?utf-8?B?OCt0Y1ZIY0R3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXE0SHlqcFplZXhydUV3TGdPMkErSzBpWnlqUTdCQ2t1UGU4UzdZRHoyRGdK?=
 =?utf-8?B?cTFOUGkzM01DakordkgxSjJOcE5yN0pRSWhMMlNiLzBMaTFqK1FBdTNtd3Ir?=
 =?utf-8?B?S3FkbzFYNGVaTDZLRmIySkNYUEhQSklFZll5emxNMEs3TmNSaGdvaGozeEpG?=
 =?utf-8?B?TVRwTENPL1dMY3lJakZEcGlpcUFOMkNwNHZvMTRuMjgyUnNKMmdmRWJFbWV6?=
 =?utf-8?B?c2x1d0JTM2xodHdZU1A0K28zWTBtVndqMmVUZHJEUzhSNkFBbVJJWVNqQURu?=
 =?utf-8?B?dUxrU3RXdVVoQi9GMDM2cis2c3h2eC9sRjAxUzZGOSt5QWFmYmdiNHdlQ3Bm?=
 =?utf-8?B?amkyeFlHV0VqejFra2pSRkZqa2pIbEZuQlJ3Ry9Ha0Jlc21qMlJNVFA1Rm9m?=
 =?utf-8?B?ODdEZjAvbVFNODZudk9jWW1jbnNVTWowL0VTc0JMYkFXalJhKytKWnR1Nnhp?=
 =?utf-8?B?UG1FYzVoUXFRNnhVQkx5bFlpb1IyNzRTdXBzbktuaGVrZmFhZTQvMkhtZits?=
 =?utf-8?B?NHpMSDhPVFlXdFI5Q3FEajd3T2NvdlJ4STJFanp4MnlHZDVhVzAvNmJpWmJO?=
 =?utf-8?B?QWZHVFhYcUUySUlPRENFOGxKNzc0bytYS0xiUythM2lGcDdMN3IwK1M5L1M2?=
 =?utf-8?B?eUpuZjBrK0hyUnBRWVpPQXErQXhTWU9oemcxSXF2ZnNkRWxOREwzc3YwQTdP?=
 =?utf-8?B?VFM4MkNGZTd4K3hQOEtEVHViU2tmWS84RVZpYmFXYjFqTjRwWTBzRWl5aUh2?=
 =?utf-8?B?STE5TmR2QlFpbmZJTFg0Rm5Pb2pwbThrajZ2UlljQjIyWjF6akpQZVcwdFJG?=
 =?utf-8?B?cFl2VFgrcjR6NDFxM0xja3QrUXZ0eDJFV1BoelhBL0xMV0xBOFJhV1FRZG5X?=
 =?utf-8?B?QWxHT00xS1pwVkl1WW5USCs5TSt3bERZM2lCUXg5TzZyMFgyU3hvS3cvOC9L?=
 =?utf-8?B?YW9WaUMvQTlSUFVRNFNMZjRjR0tNNHZUbWhRS0I3V1l5K2xEOXpPZDNnQXpo?=
 =?utf-8?B?clFqYU1rcVZqbnVjZVdBK2VEVjFHSkJrQ3RHbGNCT3BmYUZWOGZEaUkvbXU1?=
 =?utf-8?B?Z1VMblJGREt5V2tuRDlzUS94ZXBrQVlXOFhsSzZuMVFjM1FGMmNYcDN1eFdK?=
 =?utf-8?B?QUNiS0EvY0VVQng4eXhoNGtDdDl1dy9qSEQvaURNWkJmWDNEQnM0N3BOOXhQ?=
 =?utf-8?B?bldyNmFnNFRNb1ZENVNqVmF3bDNtbFFuaFQwSEc2Q0J0bmdtak83Si9kUzVy?=
 =?utf-8?B?RXBUTTVZVWNXaEpNWnlNQ3ZuUys3SUUxNG1VV01WYTRWSlVuMlNiNXp2U3NP?=
 =?utf-8?B?TitNeDV3Ny9EdzNvRXdzT3pQOHRrYUh3Um1YbzlmRlY3c0Z1NmZ1Z1dCRlQ4?=
 =?utf-8?B?aTlKY1FjT09MZVZlRzA2UUNNeStVZXVXMlpXcUp4ZTVzM1RGS3pQL3BWck4y?=
 =?utf-8?B?QmpKVXVYQjdIMm5HNzRBSkdZNzI0UjRZd29qdUQveUIrVDdxMDVxUHRIR21B?=
 =?utf-8?B?UGV1ZnJtanF4bmljU0NWUmpUeloxQnl2YXR3eUtaRFlhcU8wOUpjRG9EdkJM?=
 =?utf-8?B?QVk4aVJPSzBwbmZ6N2orVU00ajQxWXI0ZkhwNWMxZkVpTUhleFp5TDNHR2E1?=
 =?utf-8?B?ZkpVQkR6MXFyV0NFVzRWenhnUDhmaEFSdFlFQnh5Skp4Q2dKclRCaDY2VnZi?=
 =?utf-8?B?U1VGL1BMWE5IclE5SkM4TnhYYkprVVVFVWJYcW02MDJWb1pWRmJUdzkxU1l5?=
 =?utf-8?B?UktQUDNUaWFqOGZTY0d0MDNKcjM0eXVCSkh5eEVLeWxidHdrVEoxRDRXUWNo?=
 =?utf-8?B?clk5bnlTWW9XUXFmWkxqYmtwQkUxNC8xZDcrMmJORFgyTXdPOU5LU0duMXhr?=
 =?utf-8?B?MzZGakVMQU9KL3ZnaGVrOEppUXdYTDAwemZlQ0FuVlhITGpyS2V3MCt4bEZr?=
 =?utf-8?B?c3plcGdQenVKaTZheHQ3VS85bkMrMXNmRG9QdnRYSURvTDAyeldraEZjZldk?=
 =?utf-8?B?dS9GVnUyRU5BaXRnaHhFZXVWM2JiYUZMekVqRitOZXk3MS9tbEswSENBU2Z5?=
 =?utf-8?B?M1lyN3lBS0FERGxBRWltU2k3V3NtQUdUbVdWaVBtd1huWVRSR0VVU0I1Z2Jn?=
 =?utf-8?Q?euJ5+80POzKP7nvAtDukBZ4E/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5661a9fc-076e-43fa-dde0-08dde53c3f92
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 07:35:08.7469 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zqOpUCd2nYyMs4g6b655yaOv1kAskIWHMIa8PXCtSB9gECc5le3eKFNzqhSwpP1agfjXbxDqzkA2xyFk5paOfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7687
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

From: Peng Fan <peng.fan@nxp.com>


On Mon, 04 Aug 2025 17:56:54 +0100, Andrew Goodbody wrote:
> Smatch reported some issues with this driver. Firstly a copy/paste error
> resulting in the wrong return value being attempted to be used. Secondly
> some variables being dereferenced before being NULL checked. Lastly
> another case of the wrong variable being returned on the error path.
> 
> 

Applied, thanks!

[1/5] net: fsl_enetc: Fix copy/paste error
      commit: f4c2a12611d3ffdbd624ededf0fce192f26dddaf
[2/5] net: fsl-mc: NULL check dflt_dpio before dereference
      commit: 756580d090e5dcb3c45d1f0147cc596ae4efd961
[3/5] net: fsl-mc: NULL check dflt_dpbp before dereference
      commit: 9ca756cee7e8f9d6ecc0a69fa785caabd61f3f6a
[4/5] net: fsl-mc: NULL check dflt_dpni before dereference
      commit: 010a4c5c553763430b3e9628ae2c82de3d5f45dd
[5/5] net: fsl-mc: Incorrect variable used in error path
      commit: 05b11146363039a00bff09c77be077ebdaf1f5d0

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
