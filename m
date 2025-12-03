Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F32CD12D56
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 12:22:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B22D583FA4;
	Wed,  3 Dec 2025 13:22:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="RNdD0heh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90AB383F91; Wed,  3 Dec 2025 13:22:32 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D485783F82
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 13:22:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o7AV6w3aqBqrrhnxK2qfF/NaLpngfP7mn2wzA6VMptUV0zhv0NLp7ID83Txk0w8Lcj14Zf40ZXYMFQYHlisNK30kfaoP9nUvcFbae82qSmrwOSoAEXJsasVxiGhkZMiD3ReoaAm0FpzzuHuYvxgdgv9WIGeAUSAtwFiYgHtIgQ+nYlX19dL6fvrBwG7MY00BH3WISnGarDnLX8I5ySB31bSTgldSgJJX/SpgL3xqttDkifzJtij5q5Db7O+zTkKh9WLq3LUAcg9WoVn21q6esyZ/z1e7ANkyxCq0fu9oB90VVRLgTV3Bt+6Vgc8IE4YaUi2tfDvX2WfwUuocdc2U8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A012OQd2xH4k6EReIXbTiLRXxEKFYeKqYnPyNbJ24Ks=;
 b=CYL7e3pYXn2Zv5Dm0dLuqsgThVCqipAbcloDKMP9SUHfzTvLgVYrP/wEQv2DBUTzEbdgN984KkLQKjtjDI5I0Q7AGa/KRnw1YiIGTk+PZ0yO1j8eGJZ0o68UsPy81yGPexCINr93C96xVz5ocZRhVXX4ZFjAhVsdwEhaCUrQjbUI/9QTpsIDPm7TAtZ1abXG1rDCtE7RwC1JFnJET+k18Gzxe0G2fqyKcVeRbCyKIGM1H8bKTJoEnhp6RnRVFw0tqm4e/lnHNng9EsUoSUzfcieE/Y5izH2HND8VpnjS2gPc1YYgkccH+Vh06WzZoPMptWRohATxtwFRqOTvB3Lp/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A012OQd2xH4k6EReIXbTiLRXxEKFYeKqYnPyNbJ24Ks=;
 b=RNdD0hehKDuqi2YwGPTVZXYNxWk2VH06cvP78QVR/19FmeWWVcm0vZe1MwTpjJkUkS6JqzGQN3Gq2o9jE7g1xzHeeSXOI8UeiO4ARsoTpWQuSY+9+kgZ27uNhJY6gQ9EEajXjLF/Oou9y4H+gDcSljnDnVrlflzZu8Jt7w8L3eWkh2gPvLz14r2Xm+BHPEjsKTV2JtQOlU8U91mOaWyGfIRIzX0qOY6SkdpHnC6XDfydAE+kRptJK3tS8WrEZtGJ+H3MF8nGssbNj/aGwRCrM3/QYIuouMdXwEB8glnr5bgPCYHfquxdMAIk6+NOVhuKwDEYR6La9ZPU5b+X3sUSCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SA5PR03MB8452.namprd03.prod.outlook.com (2603:10b6:806:474::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 12:22:26 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 12:22:26 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.denx.de
Cc: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, peng.fan@nxp.com,
 jh80.chung@samsung.com, trini@konsulko.com, marex@denx.de,
 tien.fong.chee@altera.com, balsundar.ponnusamy@altera.com
Subject: [PATCH v2 0/9] mmc: sdhci-cadence: Improvements and fixes for Cadence
 SDHCI driver
Date: Wed,  3 Dec 2025 04:21:30 -0800
Message-Id: <cover.1764760325.git.tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.19.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::12) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SA5PR03MB8452:EE_
X-MS-Office365-Filtering-Correlation-Id: 63e0cb4c-4826-40db-1055-08de32669ec1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N0tiYUdaRjNFL2kyVUlDQmJQY2dsY3hIN1BxcDBwYkN0K3hyaEIyYmpPZnJw?=
 =?utf-8?B?aFpoeGx6b2ZwckEvM1FXMUFpZjI3eUJZcUJHS2dUY2RMbk84SCtJNzJ0UXg5?=
 =?utf-8?B?UjVoZzUvMmhjMGR6cnc5ODhYR1F6d2JHaHhYdFJqUUlwZmRBdmhzaUVndFBC?=
 =?utf-8?B?U3QwSzg5WkQ3V0hTNnJQQTVTL3NSNVJqbGVrTGhtWlVFQzdOQWNleUFnL2dl?=
 =?utf-8?B?Unlyb0N6NlFNZTV6Vk5NK25XK0F2VUpsSU9vZHpPSXpvRUpsbEN6cTc4bVdL?=
 =?utf-8?B?ZU1IQ3V3MWNZWFByWGtSblMxTkhJZmRwa1BReG9CWVovWGgwVVRYQUlIaWE2?=
 =?utf-8?B?cE9QaFF4WUkwZS9yYkJuQnlRaEdDaXliVnRJTkdMZllhVzRZRUs0YXVFMkNO?=
 =?utf-8?B?bGJwRWVtVWNuNGw2anE5UWRXNXQ3ejhZTnZPaXlQcXhqQWx4MkJOb1cxdzVI?=
 =?utf-8?B?VDZmOWJjUm5XQ2hSVzdxRnFIcTlLS1VUVG1hTWp4NWdERXJxdFlUMTkvYTU4?=
 =?utf-8?B?QXNjNHdwekV4ZWdkTkV2Yy9jSmRCYllYd2cweHdVU1ZBZ2ovQlhiekZYZ1Qw?=
 =?utf-8?B?cCtzVldoM3BBVDdBNWZ2TDFrQ2drUnR0azNveUQ4cmkvOVd3elkxcmJlRlZs?=
 =?utf-8?B?ME9RQk85aHV3RzQ2QUl0YnJzbXNZdkpOd2g5TWt6eDVQU2ROR0hSMm41NE9D?=
 =?utf-8?B?eVpPYWtXN2x1eFc2RVJDNGJRdmFmTnJ6bmdUTGdIMVdGR1M0dlNRZUtQQWNJ?=
 =?utf-8?B?bjk4TWRLclgyNmJ0TXlDTWZiWXdrbWlQc2xsTWFKYzJaUnQzMm1ONDFVdHB4?=
 =?utf-8?B?QkFqSW5Rd0g4bFRtVjhiWGEvOEZFTStlcldicndNWHNOZmgzbHROT3MzQnk1?=
 =?utf-8?B?bDhwb2dvVTV1UVhmSDNOakFWYmtZQjVQejRDSlUyM29OSDMvbGkyeGZ1Uzl3?=
 =?utf-8?B?U0xEQ1NtQWtyVzBTU1htTExISURhNThPTU1KcXBTOTRuNnQyazBKcktXQmw2?=
 =?utf-8?B?U0FmZ2NXK2xSNGlTdGk2RXpYWVVOOWlRVGFLTjZJT21PaWxBNWxhZXNjYUZS?=
 =?utf-8?B?dDI3aGtSSUZpblVMS083cnRNbWlWdkh6ZkViYmxDdjhVeFdZSS9oU2xjNFl2?=
 =?utf-8?B?MGFqREx4VXk1NUlTTUVkUzlDVGZzR1dKUEpmK3VJVGNtV085VXp3UGFGd3Fj?=
 =?utf-8?B?cE1pY0FPV3lVUS81WTlkVS8vejFkZVVPa0FiVG5OMzVDZFFoWUtlQXZZUEhz?=
 =?utf-8?B?d1Y2MnpTbGV5bDZBcVlOS2VpMlg3Nm1oYUVOWTNEUERPVUtoTTE2VittM2pB?=
 =?utf-8?B?OUpoTldaWndydlRKV2xZUndmZnVkM1ZTTEw5ZmsxM3NPMmZCQ0poUzNrY0xH?=
 =?utf-8?B?cUUxWjRkcHRsM2N1QktmU1RRWkdFQUtTZ2VaTk5oSmRaVHJPd2xOdXN1WlhD?=
 =?utf-8?B?a21ITzJyUG0wOUQ3RzZHSWZFc2ZYZmExd0piSmJlTlVQYUUweHVqS3R0Kzhx?=
 =?utf-8?B?ZURrNCtPc0VaOThtaVhLS1I5cDFkekE1ck9ha3RvckNhQW1zNmdDd3pzam9m?=
 =?utf-8?B?THc5NXhNYUlLRXNwNTFLZlJ4UENUdFp3N2pvRlU2ZUVJdGhiL3l4QVJyR3A1?=
 =?utf-8?B?Q3RwVVZnS1kyczB2NVdrV1I1YTgrTlNnUmtoM0RrK0NBcHRSS3ZEQk52cm5h?=
 =?utf-8?B?NWZ2R1gvMGVWNURBY2pkdVlRS0toa0l3ZnZaL0J5bDNOMXZsRS9ENDhnUmtI?=
 =?utf-8?B?RXcwN0xiWUZTY2hVcGloTnhEZ20yYTJ2b2t5OGc1dU5vcGt1T0t3ZkFEZHl6?=
 =?utf-8?B?cGU3dkpxbVBvM0RCVS9KNVdRZnA0Z0NkTUZiWDkzM25yODZWL3JxN0JxcEs4?=
 =?utf-8?B?T2pWeCtCWnhaMVU4OTA1WGZiSWdxQXdkbktlMHhhWGRuWitlQ2tQNy9VTkh2?=
 =?utf-8?B?NU9DemJFY05yUy84K2tVNkd3RFBBeW9RM3lraWc3bmZZWnE0bnNsaVJTM1pQ?=
 =?utf-8?B?R280cU1BaXp3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0I4MzdzbEN6N1lheDU1RHlwSnFXQWI2dWRmd1hUcldDRlkwYi80K3hXQW5j?=
 =?utf-8?B?Ym5NbHpIY1JNRVFnWEtyV1pxR1FEZTltRVlQS0RtckpLbWhMeUpUS3lXS1M4?=
 =?utf-8?B?UWZVRVlGQUYxdGlVd2JKbFVGd0xtV2tKWE1KS3RrdklDM201a25DVGVGdHc4?=
 =?utf-8?B?YnJqUk5ENHk5SXNBZWZ5SHFPL040YlU2VjZjT2Y0b3dQOVdFUDk4UGFnNDRF?=
 =?utf-8?B?dmVIeDh6VFVZZW9Fa2tVUUF0WEtkdkpLMDNiTmpCSTE0U3RRT0E1UUhRUmlF?=
 =?utf-8?B?V0RNVjJnRHlnaHJ5dk1LUlRRU3crK2c2UEFlVU1WTXh4Y3g4YVlIenVLcjVC?=
 =?utf-8?B?Tll0cWZqVklmOVBGb3NsQ2xkRWdkWUI2aTllWDVXakpCdEJ6NHErdU1heU0x?=
 =?utf-8?B?S2RheGdIMllCNDlmR1RNUS9yY2VKY05yVDFsRDVOaTYvdnY2cC94NHNXMDFh?=
 =?utf-8?B?WFN0UGZHTGlxN2x3anFTZTFpVmt5bVo5ZmYxV2N4RGlTUkU4M24xYmJZSWVn?=
 =?utf-8?B?VllMczh4UWpwVW1wYzF4VUJoR0F5OFRzbzIzU2ozaFVISUV4VUFKZmJoZUxw?=
 =?utf-8?B?NUVseVNJZzNhcGp6UEh5dEZnbXY2cDlNRnV3dHV5MEF3SGliS3RXbURBUTlJ?=
 =?utf-8?B?MUIydGZUeG91dlVzWFJxSHBHR3RXTjJRL09qYTRRUU1PU2c4dUllcWwyTWpD?=
 =?utf-8?B?ZzVHOG5CY3UwY05OUW9YYzk0YmhYWWJncVhUdmswcWNDcWJHR3BPbXF4dUEx?=
 =?utf-8?B?M0s4Z0c0dHIwSE9iVk55d21jZXB1MGtmaThpNVJ1MFMrbG90M2E5bzhGSTUw?=
 =?utf-8?B?U0czc0ZjWUNOeXFqU1l1aEo5MnM1cThHcGIwamNmNzVsSC9NU05nMmJYUGhm?=
 =?utf-8?B?ZWJaUDlKa2xiM3lFdUl0Mkd0WEhqSE04aE4wVkFoTXRsQVJicHFnYTZsRitv?=
 =?utf-8?B?aGNkQWdKV0ZBOVdZUUJxb3NzbjJLNWtleEFRa1pGWWc3b2h0ZEJ3T0ZZUWNy?=
 =?utf-8?B?STRGVnBPaWRCYjNvbVNNYzl5OFZPNmNxUWdmM01ONEVkdzJvdVNRSkxBYzl6?=
 =?utf-8?B?TitxNW1UMmRjL1B2L3BlTmhQK29rS3JmUjNLOHZ1SnM0ME9XL0x2VXRuN0FX?=
 =?utf-8?B?VXZMemo0NHhlTHZRaHNNWWJGZVJBTC9JeThpMjFiV2hMUExUSlR3NHVqcjFB?=
 =?utf-8?B?Tko5cnJGUXFjU3RLRE82MjRSSGF2M1Z4b28xNklWN3kvZjkvQ2w2YXhza2h0?=
 =?utf-8?B?eVNhUUI1YVFLNXpaUFJ0TEIzSlNkelRTNHZ2Q3NsR3hvcEJSSXB3L2orcUFO?=
 =?utf-8?B?STNjVkN1QUphNFZVcXZ2TnlUMHIzSEZ1d3lpNHZKY2pkN1hqYUZ0S2EwZ3BQ?=
 =?utf-8?B?UFYwRzFjNTVhbE0zbi9Pd3dZdXJXaVZ3UmR1YjFtMXBwbndsSkQwYXhRbXVa?=
 =?utf-8?B?bDY0bCtCNG1BMk56bW4rVzRUVWZueGhDWVE1LzRHYnhwZWVrQzlhQXczcG5C?=
 =?utf-8?B?ampKVEtJUUpIWXg2alpXV0FsTU5DMktBV25jZ0RMdjVuZnZUSkZMYlIvblc0?=
 =?utf-8?B?dVl4K0RYcEdqVFdydXFHUVJrVXlJb1FUa2drcm5ic0ZWcmdzSjQwVG10djNW?=
 =?utf-8?B?RjFHQjFCelVxNG80cnNlRHJKUVlDTFdaRitBM09DTkFwTTNjQm5BTXpkbmRY?=
 =?utf-8?B?WldEK1NsRlVpdjJGdVBNTWdDWnhQa0xrM2tpS1FWTDdpOWpnb2RJb0FtZDhT?=
 =?utf-8?B?SnhoRVpvN05nSi8vVFZWN0J6Y3h6TlhXaERxdldjNUVUanVMdktkOXU2bjA4?=
 =?utf-8?B?WmtPa05nbkdpZFFCWmIvM3c4RGpBdlFlZ3FDTmZKMk5GSDFZVHh0QnlqM2gz?=
 =?utf-8?B?UC9EUDFra2FjbXg1cWZGUE9hcXNLQ0hQNXgyWitCcnMrT0xPTXBOK0dlbDR6?=
 =?utf-8?B?QzBJUGF3azdITnFqN3hmUUlTNHJESW1NamZtenlrVUgzdU9qTnNxaW5DUHMv?=
 =?utf-8?B?WFZOT0NET0hmaVBKZ0sxVDh3ZUxLSzZGUTFqanp1eGJkTVBONWJyOEc0QkUx?=
 =?utf-8?B?T2FQcTluZW5iL3Q1VXgraklnZ1FUOWpNQktmajg1UFlEMlhoNGNTUExSOFFV?=
 =?utf-8?B?dWNrOStDWUpGR3oxU1JrWDZ0blZxaG1xL0RnYnhBdU9ZNDl3Rkd0b3A3S096?=
 =?utf-8?B?Q1E9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63e0cb4c-4826-40db-1055-08de32669ec1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 12:22:26.6234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3yWn+pybCxhpKd2LFNInc/XUzPzKHPti62gQTgS11uiLngLz7zkiLtRE0Jd91enmmOztChm1C+GqQakwFmPRBFMesz0o7dzKfjXzJGp5xqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PR03MB8452
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

This v2 series updates the Cadence SDHCI driver and related MMC code to
improve timing mode handling, device tree integration, SD/eMMC tuning,
and alignment with newer SDHCI specification versions.

Changes in v2:

- Updated patch 1 (reset control support): avoid calling
  reset_deassert_bulk() when reset_get_bulk() failed — only deassert
  resets on successful reset_get_bulk().

- Added a new patch in mmc-uclass to explicitly default cfg->f_max to 0
  when the "max-frequency" property is not present. This ensures that
  sdhci_setup_cfg() correctly falls back to the controller’s capability
  registers for the maximum clock rate.

- Adjusted patch ordering so the mmc-uclass behavior is defined before
  the Cadence driver uses it.

- All other patches are carried forward unchanged from v1.

Thanks to Peng Fan for the review and suggestions.

Link to v1:
https://lore.kernel.org/u-boot/20251110173737.24545-1-tanmay.kathpalia@altera.com/

Summary of changes:

- Add reset control support
  Ensures proper controller reset during probe for reliable initialization.

- Add max-frequency handling in mmc-uclass
  Defaults cfg->f_max to 0 when the property is absent so host drivers
  correctly fall back to controller capabilities.

- Respect max-frequency from device tree in Cadence SDHCI
  Uses the max-frequency property when present, and falls back to the
  controller's maximum base clock from the capabilities register when not.

- Correct timing mode and PHY/control configuration
  Refactors timing mode selection for SD and eMMC cards, implements new
  mode mapping, and updates PHY/control settings for UHS and legacy modes.

- Add SDHCI_SPEC_400, _410, and _420 defines
  Introduces new specification macros for SDHCI v4.0+ compatibility.

- Use hardware version field for controller detection
  Switches from compatible string checks to hardware version detection for
  controller capabilities.

- Enable software tuning for SD and eMMC
  Extends tuning logic to support both SD and eMMC devices, improving
  reliability.

- Fix device tree property naming conventions
  Updates DT property names for compliance and corrects minor typos.

- Add DLL master control and improve tuning reliability
  Adds support for PHY DLL master control and enhances tuning robustness.

Regards,
Tanmay Kathpalia
tanmay.kathpalia@altera.com

Tanmay Kathpalia (9):
  mmc: sdhci-cadence: Add reset control support
  mmc: mmc-uclass: Use max-frequency from device tree with default
    handling
  mmc: sdhci-cadence: Use max-frequency property from device tree
  mmc: sdhci-cadence: Set controller and PHY speed modes for SD and eMMC
    cards
  mmc: sdhci: Add SDHCI_SPEC_400, _410, and _420 version defines
  mmc: sdhci-cadence: Use hardware version field for Cadence SDHCI
    controller
  mmc: sdhci-cadence: Enable software tuning for both SD and eMMC
    interfaces
  mmc: sdhci-cadence6: socfpga: Fix DT property naming convention
  mmc: sdhci-cadence6: Add DLL master control and improve tuning
    reliability

 drivers/mmc/mmc-uclass.c     |  9 +++-
 drivers/mmc/sdhci-cadence.c  | 98 +++++++++++++++++++++++++-----------
 drivers/mmc/sdhci-cadence6.c | 82 +++++++++++++++++++++++-------
 include/sdhci.h              |  3 ++
 4 files changed, 142 insertions(+), 50 deletions(-)

-- 
2.43.7

