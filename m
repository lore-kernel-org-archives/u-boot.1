Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A222CC7115B
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 05:52:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63A8682D34;
	Mon, 23 Jun 2025 07:52:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PnsUwHP3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2039282D6F; Mon, 23 Jun 2025 07:52:26 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5D4082D17
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 07:52:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KDV3EkoZwXtxESp6CKQJbry9vOlKmIHrko4cVoex3i0AoZrxNZhtX6GWl8I5m/C03XagvAbEeH+BMzeuT7CNoCJGV/sFFPOJ/tVJRkrIvbl3CVk+neXNEAOFSPfnCW7p7pZfpZtsNDP7KBYjDYF5i46IgxS0ZP5SJep9r8hq7v9SK8QqZYwt69foEfJn2x5gSEzEdplbnILLGraV2lVEMo2j3lk8tMtMXQciOg0pFUh0WrfuA6Qyw6ueyuZMBoyt5OajLHW9jtRjYPL7lq+37iPGU28kwhW/BMMMCR39Pg6tfU5y5iMyn/8LuT/bUqNLSOXbIOYzfCrF9oEyPsjDMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5hmO+Tp7Ar8kh7MABUH8BIQQ5jtgKImnwuZnvqK4FmI=;
 b=cg8AJpJ4wuhFeBX2CryxzwAC24+d4LyMGccbb1wQQzy2kgalqGob71GPQOyg8DPgrXfzy+xGqV8zMGy/MMIyGwHndEeh8ZIyfVF2H9K8WLBc48darXqEVDNtpUKtS6mYd+7gkt/c1b5n72Yg0Fi3eu0Bdy7dnu0RYnh9qp0mC1paSE3aK7MC4EjbIlMoBjbs/0QdGT7XC24VTy8w9K/WfhaDJrwgo4ZsDxy4tMvuNJwWFZqCS34J1BFfpiALnhCL+KwECffSAB9dy4HQvdl/6QcDKGD4vcnwxauO9LLRwZh2Qq6WV3ab6yXthU4Xz1FMjCwOhS7yr4Ypzhz9rOZNug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hmO+Tp7Ar8kh7MABUH8BIQQ5jtgKImnwuZnvqK4FmI=;
 b=PnsUwHP3OOcodj2va7fdqZQSecw7/g50JM6vzbE+s3eVeXdUp7IeX7fAOFMmX0jbIWssdlHz39TUdTCd1/wX0MAyPoCOeZZvj73WGoQUMRuOAmI3gmGBEuVtqoM9ZDTeXymZBBMt3D849McBhkwrm8RquW8Gos5xC9AZ5+vlA9MawOKnMnbEFtXJSCmEvm+KyFegterH1xEH8mbXLFw8SWIWqN2sKPuk2+R0AYiSGKJxrgisaOnbZVGPEvdBAfFhgVpjXnWVEa3bvRWV+ELXHR1peuRavetKam0ls1BALK50QoCNU8DoFF2Z5073GrdLIIdWUdvhn4K5QNB9DINfuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB10671.eurprd04.prod.outlook.com (2603:10a6:10:582::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Mon, 23 Jun
 2025 05:52:22 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 05:52:22 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 23 Jun 2025 15:02:30 +0800
Subject: [PATCH v2 2/5] imx8mm: evk: Add support for capsule update
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-sr-v2-2-e97fc53f0f8d@nxp.com>
References: <20250623-sr-v2-0-e97fc53f0f8d@nxp.com>
In-Reply-To: <20250623-sr-v2-0-e97fc53f0f8d@nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2PR02CA0077.apcprd02.prod.outlook.com
 (2603:1096:4:90::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU4PR04MB10671:EE_
X-MS-Office365-Filtering-Correlation-Id: 284bf717-0dec-4956-8286-08ddb21a1f89
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZG1BcDF1MjMzMVdNa2hYaXZvT1pJT2lFZTYwTXYydFV5RHRWYjhCWEN1Ykx4?=
 =?utf-8?B?NVp0c0JDRHlWUTl2NWtRZm81SzYwdkptZWhER3VvWFFocWhkNnd4SmZzWElI?=
 =?utf-8?B?YUZiSWFQVmpOcUZZRGRhdzBMNTJ4Ti9sUVF2YlNxZmNtQUkxNW9pK3JoVHpL?=
 =?utf-8?B?SWlaN1k4Q0JLWHpDNmFJTkdTVXhmSkVBQ05aam5TenI2elNjdmYrWmN1MlJI?=
 =?utf-8?B?YTkyMEYwbG52SG9LQkh6SVFXZ1dVRFZFaCtYWkdzR0VzYkkwSjVSRjhlYjFq?=
 =?utf-8?B?QW5zSzgxajBmSkVnb0lGRThuZDhucDRRYm8rRXhScXFBZGhiSHQwMEQrNGF2?=
 =?utf-8?B?VUNFTW9QQXFUY05uNHVJOTRTUnBuZFVGamlUTk0yQmFodDFsSXFabURuWmo2?=
 =?utf-8?B?TUdFMnZDbTVSdDVqS0tsaGNON2FyWUduQUhYcS9yWXE1ZWdOeTE1ejQvQ0FB?=
 =?utf-8?B?MUVVVVJaK1VVZXZuQVhjL0g3dTZaelA1Z2d6dlIvQ3FzenFLdTJsUVUzbWlU?=
 =?utf-8?B?d2N6dnpvc2JYZDQvdGtSYk1WSGswSk5UTStmTUdBVnZBSlN1bDFwOEE3VG9u?=
 =?utf-8?B?YWVaOUhVcmJnTkVIS0J3R1Uyc1FZZjFDVVFxWTJJK0h6WjJOL0tLclRiOWZp?=
 =?utf-8?B?aXBJNHBqZU4xRjZCQ1R0TEd6VHpMT3hLUm95Uis0aVE1UTl1N3FldHFEbER4?=
 =?utf-8?B?WldERlhJaTJvankwOFdaUDlIaC92YTZZUGZ0OGtyNWhwK1FubXFHNnAyOWty?=
 =?utf-8?B?T1RuakJsYW53NUtuQUNsWlJ0VFQvUDFhcE9CNDNMQUMzeGpJRVlSekh0VjZK?=
 =?utf-8?B?b3pqMDc0ZGRWOWFrTkpOUmNQekZHaGVFNW93a1NYWEtzYlRqR3lOWnMwM1hW?=
 =?utf-8?B?UWNwbzl1aU02MkJDeWwyeGlRMVphWUZIOTRaWjZUQjJaVStPM1BvQW5YOWtE?=
 =?utf-8?B?K3ZSR2dFdFhUWVJCYm9LRXc1MkhsVHZObTFaMG1yYjBBajR2dTZTTWxNRUYv?=
 =?utf-8?B?ellSaks4OW9mcG95c3FvVGh3ckJaRU82clVhb05QVElSb1R0Ni9maU5nZFlv?=
 =?utf-8?B?SnpQa3lDUTl1R1pqZFJRMWJGL0NqRTRXMEpCZWo0RDd4OXIzRlloN2FTRmV0?=
 =?utf-8?B?Ri8rbzZuaElhRmJNKzhZMjY1dFp3WGJEb3VSdnl1aTZqMlFZK0lCTlJqeTUr?=
 =?utf-8?B?bmhMQld1TGhDWFQ4ZWU1RVRzQWs2Y1Z5V1FhNlQ4TGNTczRDRjNXTWhHR1Zh?=
 =?utf-8?B?cURUZWxQMkZobVhybzJlZmEwNnZtNTB6OVNUNDFpcUZXeHhibnp2bVpxMVRY?=
 =?utf-8?B?b0R6dk04L0hFQlpGMjFXOUZJWWhYSjFCd3hKcjhiUkNCd0ZPSVVlWWRjU3Vz?=
 =?utf-8?B?cjhEMnIzR2l2TG9CQ3FwdThrUGV6SFhhbTlWdytYZnRqZ0N6cVRuUUo2ZTdG?=
 =?utf-8?B?SnEyNW5NeFlIOVE1MmFxbVEvL3c0TCtqbW1ZTWg1dlBTR1NYMmpxTVM3TEtO?=
 =?utf-8?B?SjRsSEJMbU0rbUs3VE1WTXR6RVRJQmU4SFlwTmdrc2xwcmVWZ0YrYlQ4TjRX?=
 =?utf-8?B?MGdBeXJWbWhacDhtc0dtVGJoYjZ2TEtjdEpiLzIvaXlYVmJicEFZSWQ3QjVm?=
 =?utf-8?B?Z25MWHQ4WGZ4bFpYNjF3MjUvV3RjKytZamxzTE13UUlRQS95QXRXbzZIZkRM?=
 =?utf-8?B?Si9BekVlazZ5djlGbEtpZU44Q3U2bERtcXNwM1JBbGY4UGpHcHJGY25BdjVw?=
 =?utf-8?B?L0FSZVU3L1NOaEI3YzNhS2xmTW9mZnZFK293Y2pDeml6ZWtJa3ZmTEVOUzBv?=
 =?utf-8?B?Z1U2UVVjOU9HdEtkQXNmSnhvMjRVUDFGYnRLaHBVY0xJVGRiMFVKTnV4YjRv?=
 =?utf-8?B?b0VtcVl2TW85VzR2ckpZaVl6TzBKc21MUW01U2VWc1pmWHJWZ0ZPbVdDbnhZ?=
 =?utf-8?B?Q01JM3RzNWtqVHRHQ2FxbGd3enkzWGpEcFhuOE1TVEljbjVwaG5FRVZWRDNl?=
 =?utf-8?B?dmdRTU1uOHZ3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0NUK1A5QXBmbFRGdTljSHNhM2NoZ3kxRHh0QlZ6WTZMcnBHMXpuMVNKNW9B?=
 =?utf-8?B?VWNCWndYeHIrN2tpV05Lc3VvUlAzd0RGbXlFandoSVBPdUNUMWRsMDUwcXFN?=
 =?utf-8?B?VFB4QkdpQnJleEZnTUNxOHREVU1td2lTUkRmWElDT0twWUVQN2xnRG9nVCtZ?=
 =?utf-8?B?NmNtbG51aVpkaGU2SlRNYjZPd0IrZ2xCVjMwZlczLzVKUWFpeDBnNk9uVnNt?=
 =?utf-8?B?TnJUOE01bWJ6MGxadmN4L2JJNm5MeklYZDhNUDQ2QTVoc2lDcTA0V1lGUzQ5?=
 =?utf-8?B?NlFhVDA1Zm1EVmdrZUhDd05RUkpoalJRSGJiOWhlQVV5R2ozWWZxdUNiWmlw?=
 =?utf-8?B?ZXhmd21wWm52NitOM3IyK3BrZzF2RjJqUFA1MUdEVlFockFNMy9FVWV5ZWJz?=
 =?utf-8?B?WUlaN09rbzJWcFF5QkVtQXVpYlBRNlpzZitsOUpQamVjMjhPQ3o1LytiaThE?=
 =?utf-8?B?Um04dXd6ZDg3U1pQOUdFakFPSFVUUE1WYjRiRTRXSVhobWExMWlzeHRLRmt6?=
 =?utf-8?B?N2JFRURJNmdoeFpVeFJmTnFEKzQ5TFU4L09oT2FyTXJvQ0RhZUVlWTBQNWN4?=
 =?utf-8?B?SDJESENjeEdBM1h2REpzZE9Jd215cnYxSEtNcG1ENFNUSUk2eTBpSTZJdFBp?=
 =?utf-8?B?OHJGWWltZG1GajFIS0hQaGFaRUF5eEFBN3F4TnFyYzFwNzdmY3JRUHQ2L3hx?=
 =?utf-8?B?L05CeEZyckRvL1ZOZ2NGK2gxZjB2MFpBWGV6ckd0MXNJNElMVjdrU1NzMUxv?=
 =?utf-8?B?ZkJndW45NTFrMVB3UVlJQ3Z1WmVDQ3o2TW1vWlpFUmU5YTRxRjVrVGE5d1Bp?=
 =?utf-8?B?cWZIWElOaHdpZ0x1QVU1RzhoRm10aG9nZUJncGxJUVdHTXpTNDZTbTBVdkpH?=
 =?utf-8?B?SldBM3F1OWFjY0hFTEJ5Z1pGMlNuVUVGbTF4OXhZQnNucDR1YitvcVBlOWFk?=
 =?utf-8?B?UlNLUzNlN2ZpaW5LdmNOKzNhZ3B6MWpGZ0tHNnJSNkppbldSbjlBOXhOV1ox?=
 =?utf-8?B?aDNjaVVsSTMxWkFnSVl2dVV4MldoWkliS25idys4OUplUUd6OW1pV3ZXUWdS?=
 =?utf-8?B?QjM4UU9rUzR1UmdkMnlzL2FTYjk2RS9xSW5Fbk9vSDV6djgzbUpRVUpnai9V?=
 =?utf-8?B?bGtMbzJhTnQ5d2IvcVRhNTVvTEtIZCt4Vi96UEZ2M2diU21UR1hFbE5tYm9w?=
 =?utf-8?B?QWZQbkgrRm1FM1NYNGxnWXl5RDJhRm9XL1ZKb1Z5N3k5SHBTZkgzTng1QU14?=
 =?utf-8?B?clhXSC9rZmFSeUZ5d1ZWT1hnbGtZUjNCdGFPZExiWGpiWjdYYmxnN0k3clND?=
 =?utf-8?B?dExjVkpxR2tzdzZRZmV5WHFXSE5NZ2NuOUZhaXhGQUk3dzRRTC9JbURpemFO?=
 =?utf-8?B?bjJWQW1JaGcwOFEyNkRRRWNjR3czYWtqK1p1UmMrZUpNTHd6V1A0UUxkUkdr?=
 =?utf-8?B?Rkt6R1lxNXFyUU9kK2ZpTHRlUGpUN0VBUU5DSFV3bmdLZkthaHkrYVo5Vk5p?=
 =?utf-8?B?d0tYdlNFZjlSWTRHNThMV3YrYmtXSFhjUS9BU1dKclVGUk5KSnhtNXlkaE80?=
 =?utf-8?B?eWMxdTE3bTF1MjVQSVdDRG5yT0Nvd2cwWlFNeGhNa1E5RjVCdnpDKzdtS2tZ?=
 =?utf-8?B?cGVjVDJiWVRSVlRJRzBLNE9YaWZRZ0I1VW1DeEplYlVUcllSb2V5bUROLzdW?=
 =?utf-8?B?Y295eVhYbllUV0RsQkYxUkh3U3hvRGNzaWV0UCtxMzVXZjZMZWRHVEwwMnAz?=
 =?utf-8?B?bjVGbGdPa3IyS0dUQkJHYlg2ems3aFM2RmpJV2dHNHpFK1paM1d1TEpyY3pz?=
 =?utf-8?B?OFpscmVBbEhCaVlYU2dyNWtYTTlSbWVLTEhSbzlkVmg4azNxVFZCWHRmdHg3?=
 =?utf-8?B?bTlEZXRLdmdvSk80M0JtRjEwT1hyb0dCUFRiVk9FVUV3dnlpUnd1V1RSNmZJ?=
 =?utf-8?B?SDRnbGhyN1BCV1BwdmllV2FJdzBtamRVK0o1bFcwZWNodjZnODZtVWpnSkdF?=
 =?utf-8?B?ZUhXcnh2OGYrME14ZlR1RjU4d3RsSHZiNG5qa3l0dTBrTFFkc29mTGNFaHdz?=
 =?utf-8?B?R0prbTFUYlcyeUVWWkY5QWNZOHorTGRhTVNNdmhoMGpFamh4ekxha29zalAz?=
 =?utf-8?Q?LqmKvXxfO2eyVeTwlTKVzuF/6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 284bf717-0dec-4956-8286-08ddb21a1f89
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 05:52:22.5465 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZJHmsnFNKVsDDjBPpTaAoUC1V8tEK5Dtz2xfVNoIAfaD4I5pdgl7+KJjx51BURLfHIDZh05qbX6c3bj2uLnDkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10671
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

Capsule update is EFI based firmware update which is widely
used in various OS distributions. This feature is required
by ARM System-Ready compliance test. So
 - Define image array and GUID
 - Select configs for EFI Capsule update

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx8mm_evk/imx8mm_evk.c | 22 ++++++++++++++++++++++
 configs/imx8mm_evk_defconfig            | 19 +++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/board/freescale/imx8mm_evk/imx8mm_evk.c b/board/freescale/imx8mm_evk/imx8mm_evk.c
index d41db8d31d81b44b86a7aab5fa57d97d99e41a05..ecc20768cb5bc1e32c9c9f274eaa7f589c3ba6b1 100644
--- a/board/freescale/imx8mm_evk/imx8mm_evk.c
+++ b/board/freescale/imx8mm_evk/imx8mm_evk.c
@@ -3,6 +3,8 @@
  * Copyright 2018 NXP
  */
 
+#include <config.h>
+#include <efi_loader.h>
 #include <env.h>
 #include <init.h>
 #include <miiphy.h>
@@ -15,6 +17,26 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+#if CONFIG_IS_ENABLED(EFI_HAVE_CAPSULE_SUPPORT)
+#define IMX_BOOT_IMAGE_GUID \
+	EFI_GUID(0xead2005e, 0x7780, 0x400b, 0x93, 0x48, \
+		 0xa2, 0x82, 0xeb, 0x85, 0x8b, 0x6b)
+
+struct efi_fw_image fw_images[] = {
+	{
+		.image_type_id = IMX_BOOT_IMAGE_GUID,
+		.fw_name = u"IMX8MM-EVK-RAW",
+		.image_index = 1,
+	},
+};
+
+struct efi_capsule_update_info update_info = {
+	.dfu_string = "mmc 2=flash-bin raw 0x42 0x2000 mmcpart 1",
+	.num_images = ARRAY_SIZE(fw_images),
+	.images = fw_images,
+};
+#endif /* EFI_HAVE_CAPSULE_SUPPORT */
+
 #if IS_ENABLED(CONFIG_FEC_MXC)
 static int setup_fec(void)
 {
diff --git a/configs/imx8mm_evk_defconfig b/configs/imx8mm_evk_defconfig
index 5230f7327db6bb34b6ff84c0564816d0cc45f8fd..aba3772649cb278d4ae2654ffbf9de43198c3aac 100644
--- a/configs/imx8mm_evk_defconfig
+++ b/configs/imx8mm_evk_defconfig
@@ -21,6 +21,11 @@ CONFIG_SPL_BSS_START_ADDR=0x910000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 CONFIG_SYS_LOAD_ADDR=0x40480000
 CONFIG_SPL=y
+CONFIG_EFI_MM_COMM_TEE=y
+CONFIG_EFI_VAR_BUF_SIZE=139264
+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
+CONFIG_EFI_CAPSULE_ON_DISK=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
@@ -46,16 +51,25 @@ CONFIG_SYS_PROMPT="u-boot=> "
 CONFIG_CMD_CPU=y
 # CONFIG_CMD_EXPORTENV is not set
 # CONFIG_CMD_IMPORTENV is not set
+CONFIG_CMD_NVEDIT_EFI=y
 # CONFIG_CMD_CRC32 is not set
 CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
 CONFIG_CMD_FUSE=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_OPTEE_RPMB=y
+CONFIG_CMD_OPTEE=y
 CONFIG_CMD_USB_SDP=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_CACHE=y
+CONFIG_CMD_EFIDEBUG=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_GETTIME=y
+CONFIG_CMD_TIMER=y
 CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
@@ -70,8 +84,10 @@ CONFIG_SPL_CLK_COMPOSITE_CCF=y
 CONFIG_CLK_COMPOSITE_CCF=y
 CONFIG_SPL_CLK_IMX8MM=y
 CONFIG_CLK_IMX8MM=y
+CONFIG_DFU_MMC=y
 CONFIG_MXC_GPIO=y
 CONFIG_DM_I2C=y
+CONFIG_SUPPORT_EMMC_RPMB=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_IO_VOLTAGE=y
 CONFIG_MMC_UHS_SUPPORT=y
@@ -103,6 +119,8 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
+CONFIG_TEE=y
+CONFIG_OPTEE=y
 CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 CONFIG_SPL_USB_HOST=y
@@ -118,3 +136,4 @@ CONFIG_SDP_LOADADDR=0x40400000
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_SPL_USB_SDP_SUPPORT=y
 CONFIG_IMX_WATCHDOG=y
+CONFIG_SHA384=y

-- 
2.35.3

