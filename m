Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DED7CA0EFF
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 07:35:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95DB1831B4;
	Wed, 27 Aug 2025 09:35:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="oETDhyQn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC318831BB; Wed, 27 Aug 2025 09:35:12 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE79983189
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 09:35:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UAjhkdHaoGuihHFos6SSM4ZxQ3IgrV30yI3MoKfC8ibAjRsLrDvuE+/c+KLBu1kv4eru30SkKZGt4qVRoQzFZzG3fdkQ93a4TgrTI6LHZDQO/e4PSauW4dML0WrTrFou8wLQBTo7YOBsYC4212IzcZPWBhSDU19u07MIo2gqOJdfBkCQTsWpE5LQYVCzEBLNh963TKUACJWgKFf0cY2t65w45RIk/B9jTubZQ683qeXcP96o9Hg1aLC9OjJLEp5+gnGY5nPnIAVuVSLVSI31Jsr6XQnV7ijsGRIWWtySPY59KU3GlOEqpEoKq/veQOAOtrT/Xe6R1RzkLjv6mPtOLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OcZxexjjiSeWIoxWiQzMyzrmiNgx1nxpes3DYttpXWo=;
 b=S7F6s3xAhCJrXdv7q4TAOSeKUk6xIitQQpXRefB4XKmqtIk1x1Qpjg9d01q6zEEqIKsWJVnZAaaTrz6ssy+KH079/NP2BBsWVtljz4TN3ZN7iWtvMO4KikkRsc11+PTJBZMwufOFNxX6EsvVqJpgbNRmwdDnxmk58EpklxLhB5XDC+0X8WTiqUioEc0WjWiGTc531E4M3w9SwDlUDGunp5+X8EgS4Scn5aGUtNSR0xE7XYv0kiTtWaZW8kkf75FyE2tDdb5l2fvM3DysiQXMMoTI4JgYhI+4a8Qz3upNoCY1u9Pkss00bi/dHqSLoLbNr+z5SL5/U8Cow3rAf8DHnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcZxexjjiSeWIoxWiQzMyzrmiNgx1nxpes3DYttpXWo=;
 b=oETDhyQn0zVkVN9gvEKD6r4B/b4bMW9RZJiGq8gqwVA4Xu0tT9ZQFbZbGk2gN4/OaJDHAZQSJWSRCFoh/n8WLNHFguU19VY/YgI6iRSyWT+CkcxGtVpd7S4RPaXA18RsWztZfwY6RL7OCANSuwXRPt955v4NpGvEfKv1CEnfK8fpZVoW1EtfdCATi3XuH82/+cy8iJeCYvenYAhxhdBIwwIFAMkkN4hFv4wfdv/bHGSQNgyi3cJUOmizm+NmaBIVTBbkMFICLSQ3LA/P1QPClC/rIovQlJ2fEkhAWe3tA/sdaBUHua1zg/IPV6LS0p5FRZ+eek7FOa13LmGHHa9uxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7687.eurprd04.prod.outlook.com (2603:10a6:20b:291::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Wed, 27 Aug
 2025 07:35:05 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 07:35:05 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 0/3] net: fm: Fix some Smatch reports
Date: Wed, 27 Aug 2025 16:46:04 +0800
Message-Id: <175628406772.4168.11495017243758417300.b4-ty@nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250804-net_fm_eth-v1-0-994a4652fe17@linaro.org>
References: <20250804-net_fm_eth-v1-0-994a4652fe17@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::8) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB7687:EE_
X-MS-Office365-Filtering-Correlation-Id: ba89739a-cdc6-4ca4-4766-08dde53c3d8e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dzBWcWVjSU5XTGRxenRxMnp1T3N0UlNBWDVVVUVnS2RoaEhWU2RKcGFUNE00?=
 =?utf-8?B?c0pBTFIvRmRPcGZrR1JldWZwc2NtYWZoOEhZaTRSWHI5My96dTdiRDRZR1hn?=
 =?utf-8?B?RnZGRDV5d0pzM1ZZUTJNU3htd1VRdy9GQzllbktTVXNHL0VFMHc0ZGgrQmxs?=
 =?utf-8?B?REhlYXRDYi9DTkFYUmVMTVVHWEgvUk9CNWViZ2ZNR3VQK2tRdlU1OGRLb2pG?=
 =?utf-8?B?bmhDaUMzRTBoYi9pWGlPcW9FQWh2VXNjNlRDdDdFNkYydmxoR2JxWFJZV0Q1?=
 =?utf-8?B?OERjbEFHVldtMHJDY1Z5cE1zNEc4SXFpc05rQTV2dU9VczJ6RGpSN1Vhc1lr?=
 =?utf-8?B?SEJrazFuVnI2QmlKRElhSDdQcjhCNDZtZkNpQkxBS0I4bXZXRVFNcVJMenA4?=
 =?utf-8?B?aFRQYmdzVzUzREorbDM2UnhoRkk2aTJVNjRyVXRid1RIZDNHeFQ1S3AxcGs2?=
 =?utf-8?B?em5YQnhZZmZBVEREZEx2WWttWXUwVW9ndkVmaCtJK3lOcFc2cGNBb1ZDZ1pn?=
 =?utf-8?B?bEVtemVwSzArdlNhV3BFRENndGlzVnJnRXlqajhzVmc5U3dwNU9HU2lkVm85?=
 =?utf-8?B?NVdEZCtmSFhXOU5Fd3VSV0tQUzROakhiRmphaU90QWJVVmIyOXVzVEhMOXRa?=
 =?utf-8?B?YUJCK2pkVlNvY21Wak9VVkVnTkxTQktyYmViOW1CbVJrM0pwM2xGWVpiUW9r?=
 =?utf-8?B?QTd3YXU3dE55eTJ5b05WdDJHUjhHS1pveElaeHlaUnFpVGFXTi81SXVTQTlx?=
 =?utf-8?B?SHJjdGZ3QXpUNEl1eXRZTkdWSThSYmtjRmpGSTF0K08rSk9iVERVWW9RemFB?=
 =?utf-8?B?bWxtZDJlMXpQN1g1dERwMkt1RlVRODBKNmd0b0xZV1RsMHpEYU5CRmdUMWhB?=
 =?utf-8?B?QktCMlNZdGZMdzQ2bWV4dXlBSjhuZDMyNVNvK0piTUZmL1dYUUtsNHgyaEx6?=
 =?utf-8?B?MkpyL1dHNnA2b3MxSlNjdGhQRUd0SHYvSTNtVTZjTWczQkcyZnNvTm9SV2hP?=
 =?utf-8?B?SGRrYUs5UVpRSEtpMVpJSmVQZWdGZHduTW1qRGpaekRMVlIrZXdrR1pISUhn?=
 =?utf-8?B?Rk1oUFlnZUpRSkZJVzUybXpJREpoNm5IRGlMK2hnRXJQOFY5N0Z1RlNDSWg4?=
 =?utf-8?B?cDJ3L3MwYzh3c3dzdW1Rdnl5WWIxT0pEamErei93b1dCOU11U1NwNHFEVHZs?=
 =?utf-8?B?K1BIb3VLMkE1MEIyTUIwTnZiY3dHQTJFWHpDNXJEYkMrOTI5a2RzaXgzbGNh?=
 =?utf-8?B?RlBTWHZhUWhpc3o0elpJak9kRy9FSm9qSWpqOFY1NlJSQ2VhNklBd2VwR3dD?=
 =?utf-8?B?Wm04ZjBHanA4aTcyNGRsa0lvWVNtczNEclZPUlZzQ28yUVJtUmIxMTVXQTFL?=
 =?utf-8?B?cGh4ZHpxLzFhUWhISkNUNE1mbmNWZWhtMmV5NG1oblp4NHJ4djMwSTZDZHJO?=
 =?utf-8?B?RFo0aVJVaHZxREx0YXB2NWx6Q3RLbEphYXBBd0RjMU9sbUtyOG8rKzBxOVZE?=
 =?utf-8?B?blRZWEhHUU1Xb0VQVW4zeG1PM1NWWG81MHN3S0tTSWdoRnhOalpsM05SbDIz?=
 =?utf-8?B?WFVsT1JjLzlpUTdWQmZPeUs4N04zTWVaZjdDL2FzaDIrQ2xZSVVRck5TcjhP?=
 =?utf-8?B?blFKNzRGT252V2Jwem4rbVBBRWtvbnB2ZGFKbXZtK0tHMnV4OW5nNWt1L2Q3?=
 =?utf-8?B?SGQvVXVDY3ZKOENXNmVhazQyZlczVm1iUnBjYmdWN1J6USswRXh3RjJLL0Jt?=
 =?utf-8?B?d3FDc2hkaUp1c0lBMnZIMVFzd0lxRk9PY254VnJ1am1DWmtFOHZlYXREUkQ2?=
 =?utf-8?B?cFJOZ0lSLzZVbUZ5ckdOSFVxNFoyRmltaC9BMUsvVUx0SWFsaVl5czdLQmt0?=
 =?utf-8?B?UzNzY0p5SW9rYkplZGVrRFBvSWRzNEJZbEY2UHVqWVlPZXROb3h2NmNnZWYv?=
 =?utf-8?B?Tlg5MUhXczJpdnVrdkhNbG5MQ1N6WlRyWGl0NnEreHRIak5pZ2RKTHZIdGdV?=
 =?utf-8?B?VkhWSTdmRE1BPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEo3d2Jwa1plS0E2RXNDTVFqTURrOU9UL1JIek51YjBPemwrWnJORlJPUGNs?=
 =?utf-8?B?R1ZCN1ZONFFULzlaQ2hFazRQeG5pTWdjcUU2Z3prNGUrY3dsMEVabVZqRzcz?=
 =?utf-8?B?S0dqb0Z1RSt3WHBDNFczYW5FcGZDV0NZZWxRd0JlSjNJWXBFcklwRXVRaDJw?=
 =?utf-8?B?dnExN3htRGE2Zy9MS1pYL3dpUzJrODZ2b3gzdityUU5JV2kzb0RBR21DRlF0?=
 =?utf-8?B?akJuT2JXSVg1aExTMVVxRnBaaGRmeU1Sb1ZkQjhud3pycG5xOUw4eHJUUkVW?=
 =?utf-8?B?KzRhc2xzWkdtMTdxUDBTZlN6U28yQ1dMbFJVTytVL1ZUTklqdHphNTNIYk43?=
 =?utf-8?B?RGNSazJDRUo3N0FKZFRQbGV5eHdTU0ZOTGlNcElPR3dFUlZkOW4zcDJUb2hq?=
 =?utf-8?B?NWJFbk5CQTJNYTA2UXAya1RkZW5TcTRHNk1zK1JCSFNzbU1iVk5EaHJya201?=
 =?utf-8?B?aS9qM0c0MjJobTBvbWs4MXB2SUJOSlUwZDhPZnpoMTV6U1ZCaFA1cEwxWGtY?=
 =?utf-8?B?OW9DRTYybkVubytrMi9XRTNsTjNjOC9sNTQ2SmpwQVozeW9JVWw0bThuQ3lJ?=
 =?utf-8?B?WTRLeENzNTA4c0xmQTU0ekNhYnNwaXBrUVNGRnBpNW1Eb1NBYjhlMVhoOVRV?=
 =?utf-8?B?RXVDTVlQM0hkdGk2aEVKSHFFb0JUNlBIMEpkSk9OZXJhbVhiR3AyNDh5Zis0?=
 =?utf-8?B?dlJyYlV1dGswbUNSbG5CSldTcm83ZVpWdkNadjJCUjJTV3UzNVFyVHBnUDk4?=
 =?utf-8?B?eE8xSzd6UGFobGd4OTEwZDhTeUx3dHZ3Sy82c3hXaitUbHREaHhIWmM1ek16?=
 =?utf-8?B?UzJ3b1EzRklaQjd2dnlHU01XNnVSM1NJekdWNEFQUjBJUEVHbVViQmpDMHRD?=
 =?utf-8?B?L1MzcVV5cExxclRtTFo3VUUxYlNISTF6RlVQY3lTa2xaSTVJeVA4bGVrcXNw?=
 =?utf-8?B?cGR6b2xsU3VGbWk3SEJiL0FXV2loVmIxTmJBWjhjM3BaamQ3RFBDUFNEWVZK?=
 =?utf-8?B?S0k2eitrWE5ONWhqeWtTK2VoYXRraXBRalkySWw0ZDYvU1VHRFZqcW5sZVFC?=
 =?utf-8?B?alFtT2dsK2M3N3RwWWRBZ29yenRrVVl3UGNBRTFHTHg3UnRxdlQ0UDNZcE05?=
 =?utf-8?B?bzVHTnhobFJBOVJrTGJpdmVzQW80MVFCMzBlNWZpc2JucG5XbCtrMHE0VWhJ?=
 =?utf-8?B?TjhlUTNCSUpGOVd3ZVFCRHFoQllFcWRFa0o3eXplb3ZScFNsV2NDYmdSTzF5?=
 =?utf-8?B?djNjejhQbFJobTFIMHZUYW14dTF4d2g2MFI1SFdHS1ptYXc2Sy9aQVducjcr?=
 =?utf-8?B?NkUvZmliaGgwMlhmUGNudVA2dGdVZzhtUzRLRkNLSlo2cURrdnp1VDczTmpT?=
 =?utf-8?B?TFU4aHE3cE1NeldyRGF6VFdGVGRDdm1weWNobXRia1pSZ05YdnJxMHFyQUdu?=
 =?utf-8?B?b2tJMkF5NEZPL0pSUk5aaThScjhOQkZKTlI0VlZOMC9KdkxLQlF3RzV6a2tK?=
 =?utf-8?B?U3hUb1RHQmkvZm1vUnlOR0d3N2UvU2grZUNGbi92bnJpelZqcWptREluc05X?=
 =?utf-8?B?cjRMcXM2cFpDUDA0MHJBQ1F0RExRaWlLeXdldkgraVJWYUlJNEhyZ0pIeEZM?=
 =?utf-8?B?RkJMdCsyRkU2bi83K0dNTnpwQUZjTHQyMFc5cEZ0QkZUNnFBcG5qYlFpT05G?=
 =?utf-8?B?ZGlkZHVEU2pMMjBHNEs4bU01bW1DK3ZuY3VDNG1tekh3MlQ3Nm96aEZOUXYx?=
 =?utf-8?B?V3RrMytUYy90ZmxZaVZ4cmltMzR1M3p3ZENFaFMzMVJFNHNqK2RZa3dDNWZw?=
 =?utf-8?B?enVxeW9ZVEVsMjBTWHR5RVZtUi9xTC9ybGdCOHN5SVhqRSt5ZjAwWkZJUkRC?=
 =?utf-8?B?QXdEZXMzZGFGTWxQNERzb0hHZ2hJN2QvR29PeDdyQXdkcHdEbnVtbEovQ09i?=
 =?utf-8?B?dDdqVzkxVGZ2Q3dMM1YzbFV2eTlCRTZTMGJoc1RjaTdrUmdiczFMQm5qa09N?=
 =?utf-8?B?ZnhxTFlkT3hoL0V0VU83QVcwb1ZGdHE2UldENlBEVURCU1ZaTUJMYzhUWm5j?=
 =?utf-8?B?NjdNcDNoYk9FZWFSVjBDZFJ4ZGw2MlhZYkF6UVlnTjlSMjc2U3l3WUppK3Jz?=
 =?utf-8?Q?jew5VNLkVTB1DZbVzSrTL78Fm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba89739a-cdc6-4ca4-4766-08dde53c3d8e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 07:35:05.6191 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eAeF3TZhEDhH9mbMVhOjp5xvnjIQPDWDW1crgqZ70LGlUbkfaMigmgLu4ViRDdYVL6uUrhzVja9mKlN0/4+0IQ==
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


On Mon, 04 Aug 2025 17:03:56 +0100, Andrew Goodbody wrote:
> Smatch reports some issues with incorrect tests for timeout and
> dereferencing before a NULL check. Fix them.
> 
> 

Applied, thanks!

[1/3] net: fm: Correct test for timeout
      commit: 5b95f666fbd8f9c9c43726c7ced229762e4a35e0
[2/3] net: fm: NULL check dev before dereference
      commit: 270798a4209aeb23fce72ebf10e62630f474e431
[3/3] net: fm: Correct test for timeout
      commit: 5b95f666fbd8f9c9c43726c7ced229762e4a35e0

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
