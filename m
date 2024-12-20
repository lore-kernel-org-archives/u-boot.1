Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64437E77184
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 02:56:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDD9B803DF;
	Fri, 20 Dec 2024 03:55:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PaB7tn+E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF37B803C8; Fri, 20 Dec 2024 03:55:47 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::62c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB0E88021D
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 03:55:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cpnQ8eJv1Gr419RlBXGzcpYWDjwAJ1qYIN+2yHtDK1w/DutP1BmbeItQmEc4lUSkUCJHejp8+1M2kmfMv0UEjhWWzM6UEv00xmrDzVTSMwhWqHDZnFuq7y8h6aSm1CiEtiixGchBut7f8g7EIEcQc954ZsXutkb5wRFUNJ1xdlXWkQHGBOLD+Xw9rJ7azwLxCIUyJoXEdAoBof+Puhweni52PWX2ESyPuB8T3HL0bmy9LBlYBaX1b4CMVjNzMxyUCzxshqlJG2uuCcEw+N8XvkPvrKXXQPfGxAZR4x5Tisxy8cbi0Qeptj7N5C+tGwF16RADPsDibdG2Ix2TbmY8dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PlpvLAxTAULUrPSb3ZWMZIvd7WBcU1v0bnMAS/KeaI=;
 b=RtFl7tELUpOdCx7TafJSdUkLKLbA4pljHW/3uuPs4Ql/irq+RXdQsAvnlyo7iQIeLHTLdyDQMXKt0tYsjjD4NDOdJ0ANZWAqIl6dYIl3lm393hat+eEUXdVlam76iq8GB3qlHwOWMuxWcM2Qkc1dbsdLluCKwfl3Lfk1e6myK0rY7++NOTcehSiOi6AEgbb4J7Po5blUAR2vtheQHdTwTbzTAWXHTnb9MF5wKSmdhpnXCw5KPw93g51l13VO1JFRXUlpgDukxyMrEaMlMfUkBDlq5nfojCEWhpqrXkD0EyZ9VwfIhLa83NQJ3CvuOHLnGWKPFmAp/wlV6BW/iiRfIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PlpvLAxTAULUrPSb3ZWMZIvd7WBcU1v0bnMAS/KeaI=;
 b=PaB7tn+E+g992bmdKvOLK1/slur7O6KrJNW3FcJQA7PwVCi4S2UPh19rq0Xx7elIG1vvcbszWXOLyfKz7ajMChM0a/9n0q6TYoIwqnt5n1weg9ZPxPHXNSWS0d6g8WokTbSqwjEwtbvQrDv8m00gth9VbsBPAHwuTSyl6HxHorhEv5eyeY9W4RVJRrM5sXUqFdzPvdEL0UmRqlVBXTbQntR6++4kMFXbMrrB/yPZ9htO2n5aTJYU9mTWia3gn0BmWNvfmHZVaToCtOAFapr8V5zQBFQnAGnOtoeHp8qIFWw0+tImQ7W5z8jJMv1TjYu0Q4lKXlUE0f0uPvYiqtepfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB10981.eurprd04.prod.outlook.com (2603:10a6:10:58d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 02:55:44 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8251.015; Fri, 20 Dec 2024
 02:55:44 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Fri, 20 Dec 2024 10:55:08 +0800
Subject: [PATCH v2 10/17] imx9: add i.MX95 Kconfig and Makefile
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-imx95-v1-10-ba81dfd8e369@oss.nxp.com>
References: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
In-Reply-To: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, marex@denx.de, Alice Guo <alice.guo@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734663311; l=1502;
 i=alice.guo@oss.nxp.com; s=20241220; h=from:subject:message-id;
 bh=A8qS/z0irg/nqhLvjupt+urYvtM8hKfTEAor8RbJNW8=;
 b=pMTnuqcAhfzubMef9rKYsgX7MB/GM0Ti/Tx9YXpEGQG03gGssiKWKsc3YdGuqVXmSzerZa5c6
 DihrwONy0m7B8KmOE27KgaK6WxjedEJ/njcJPXtS24gjrlcttzzVY0h
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=I4wA8H8Q53tsp7q3voqI5LHsTQDw4TELC8szgsg5azM=
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU4PR04MB10981:EE_
X-MS-Office365-Filtering-Correlation-Id: def0ab06-dd0b-46a3-f3c2-08dd20a1cc2d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RzIxTml4UlV6N3JFanZOZXh2WFQ3SmdxLy9aNmlWNTJXRkNUKzY5OGJLUjRx?=
 =?utf-8?B?TXVFZ2owbDRNeWR3a0RUZFdmNTBJUkJsN01HYXY0d24veHFEeUIzbS9ya01K?=
 =?utf-8?B?NGRQbFZzbUpGMStOZ0E0ZmhrOXRHeFBPc3hpZGNDUUdxeUp3QksvMDUrdGla?=
 =?utf-8?B?dE10Ujc4LzFaZC8xTC9mZ3BEYlhoV2tEc1d1MlBqZ1VGUmMvZWp5K0hhZUpB?=
 =?utf-8?B?L2VRUVl1VkRlVHdOUS9lajk4SU8zc21OeXpmMFk3alNWd3V0NnE1bjRGYTVs?=
 =?utf-8?B?b2RRajJ3eXk2TXZuWWVDNDNSWGFtcjUrOVJ0WENMWXJUNm1wSTd5QzI2aXpN?=
 =?utf-8?B?ejd1YTlhQWNLc3pIcjErc0pVTWFpRkVoSUFLUWpoRGVWaytEMGpZK0d1YTlI?=
 =?utf-8?B?QUE4ZUJkdlZpakdYUm9OaE85VU5QaGpIc1ArVGNDRVZLZ0wvbjA4YXRCcDBL?=
 =?utf-8?B?UVZxRVByNUdnMjFJNEc1QlVCNkNaT0lBaExkc2x2YWczMDhKSmNLa1ZEZW5j?=
 =?utf-8?B?aGh4S3lZM3ZnTU9WZXkzcE0rRlNmaVU4UzlsQzFReUIrS3VLcFRUMGRCU1N0?=
 =?utf-8?B?Tmhlb3Z1RE5GUU1pRmhDbTBoSXRXMStxalpCV1pzeEVNUlBBcEIydlNyMnQ1?=
 =?utf-8?B?Z21JMTM3Q29HVFNjeHdHUGJTek8rZTNkM3BpSzhackk5SVk1amNSSmlVRjlt?=
 =?utf-8?B?cjFSODFQU0tvVUZPR01rS1N3RXg1Wkc0dlVkTThwUTRxU01lc1NNa0l4SCtG?=
 =?utf-8?B?ZTdobmhBL29nOWJJaHpERmthcndKWjc1RVppNnE5b3hZOUxjZUY3S0JtMGIw?=
 =?utf-8?B?Z0VadWI5dk9panN1WEJOMVgxc0pHM2hKa1RZZnQxVEdzdE5hekIzbGEzcm9y?=
 =?utf-8?B?Z0xLYTVMY0YxZE9DRlh4bUlNUlp2WCtOL0VxT3k4RlFOd1pCM3FtUzRLaXFk?=
 =?utf-8?B?aXVmQ3owZlQ1Z2U4TzByV0hvbEcydDV2T2t5SFFjbWZhbUwyMGdIRFVCM0ZU?=
 =?utf-8?B?UkZySWNJaU1COEFSZk02QWVXRElpRGw4ZDJwQXZhNllDaDhZbDVmQmk4TXNP?=
 =?utf-8?B?QkpjOXV1dlNCRFlDUVIzZnZLd0xrcDNnb1FSaHR3SGgxdXVTYk5lUS94SDI3?=
 =?utf-8?B?WHAwMkY1ZDJ0Vjk4V1hpcHJNak5wRmdFN0tjMVQ0ZjczUnJVOVFseVNHQndH?=
 =?utf-8?B?M3ZrcUtYNW1iMVFNa3d0WVFFMFZuM3dPQnlXRG1kSzZuYWxnY1E4bkUvRkFa?=
 =?utf-8?B?VTVJVTRSOGpPZWJkQnp5OEo0SHpPbUF4dFJaaGFOK2xabXZvbDI4TEtoMGYz?=
 =?utf-8?B?WFBnVHVROTJUNG5KVkltdk1XYUFINUtWYy9rSUZpRHVHZitiaXpqSHJmTlYr?=
 =?utf-8?B?ZmJoZE5ER2Y1VkpNU2ttUndRR2J6RzRBaitoeW5KNDhDRzMyaExKaGM5Z0w2?=
 =?utf-8?B?Y0dpWlVWZ0NiUW5vekxVMHlEa0NCeEhiQWE1MkxhN1EzbXl5c24yZEJicW1S?=
 =?utf-8?B?Y3RvQk1MaUNWNC8wbHNwYlZpN2l2WmorYUZuY0JBRXMxdXpHWkZvVDNYS2dQ?=
 =?utf-8?B?bTBxSWh0elBKeGZROWJRWG0xclFNZGlDMTRrdEtkUWptb0NPeWhVWStOOVZM?=
 =?utf-8?B?Wk1RNFRQRVkyeWhEbHk4Q2JKT0FsQWpMZ1RCaTlSNVl4bmdNWFJCazlycnYx?=
 =?utf-8?B?TldIUC9yVDArbWNzMzEvdGZFSmJXblY5Umt5UXZpdG9RWkdUTUpSOWlBOTdy?=
 =?utf-8?B?bkEyQXk2c0R0YkVlV0tpSjhOWVQ1SVAxQUhWN1dHUVR0QnVQYWo2em5OTnNG?=
 =?utf-8?B?ak05aGR6OFJ3dlIxd21SK3pQNXpsMUNiditHQ0hsVXBISEIybXJTTERtVjNk?=
 =?utf-8?B?YTN3YWVJYmY3Q3ZlWHE2UXVMejdoTFVuTzlJSlh4cDhGNDhqQkRpcS83N3Rw?=
 =?utf-8?Q?ugacq/SuFaTjzgp/GBxSw03FS1/njsu+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjRWcWg5SVg1cTJjYjJxRHZKQTRDRWxvUEhWZkxXdGNVQkJMOUlCcUVZTmhp?=
 =?utf-8?B?QmgvdW1xZUxPVHIvL2hTNWNoWnp6KzNlZGpKSE0wQWphMXZVeGk1U2VCQlFM?=
 =?utf-8?B?T0VvVVpzUDlnTG5OcWxkT2RhNjdEVU8zSU9GWStFU0RZbDNmQnBDYnVYUkhP?=
 =?utf-8?B?UlRVSkkvZGt3dWhjTlJPTjRRc1VZWGFMY3QzYUl5QmxPM3l0MklTTzFLeHVD?=
 =?utf-8?B?M2RFRllnYitkYXFFQ2pWT3pIVkFXSkZ2d3lNak8rdlNQVEFndnVxOVMwZE9Y?=
 =?utf-8?B?dWhZMmpCUU9tbWo4Ym0wb2hhaU5rdldmT3hOZWZnWDZacUtUdmFFRXVkTERW?=
 =?utf-8?B?N1duMHVBbWJ2Njl2dUtWanpYbG1hNlFaMHpUZytZbnIwSWZTam8ydHhJR3ph?=
 =?utf-8?B?NlFtaFBJZE5yZUNSR1RqK1VLYWQyN3NGZFRoekt1ZWdlU2VPcTgzY01yRWJm?=
 =?utf-8?B?aWw5Vlh1eDFFV0cwZUplK3Jxa0l1bVEwcFNUdHBtaXhxL3VaQWlXNEtha0d3?=
 =?utf-8?B?NVM4TndMZlMrbUNCN1pMYkhiN3UvQU0xdEFQTGRkTlJFQnUzc1VpdzVVSEl0?=
 =?utf-8?B?T0tLdmhBTjJESkRLNXNpRUpUVVo4emhUS2hiWHMyYy9XL2hKaEg3V2JIM1lW?=
 =?utf-8?B?NGFUTDlnSkNEUVA0bVc4OTZEa1NSOEdVV0VjeE1yUFAyZU1OZE5lMEFlWFZ5?=
 =?utf-8?B?SzNiZUJ2MUtrM2RENHpIWDlzV1F1cURCd1d2TkpsNUtkUmtHVE5KR1B5MWY3?=
 =?utf-8?B?VXNIS3UwRFZLMkpwWjI0WTI1MWlUTUYzTnpnamNHTUwyQk9BRXNRTVlkbEx4?=
 =?utf-8?B?VGdEbG9pakZ4SVBKWU94RC9zdCt6emM5clUrZ1dJOUJ2WDhkZ0I3ckwyM1BX?=
 =?utf-8?B?WnhOVGFIVDdQN1N1ZXZ3d3dhUVVINkdFV09xQVhkWG5tMEg0Z2luMVpRS3J4?=
 =?utf-8?B?QlNvRWltVHg5czZsRUVhaDh3MmNIZ1dPSUNrMVNMRDg4VFd3UXM4QWxNQmZv?=
 =?utf-8?B?Ykk2MndSVlJsRGVMbW01VzJNVVExbFFZbmY2SDg2VW9ZMkIzMWFoTGNoWTlO?=
 =?utf-8?B?SElpN0p3QU5WKzBKaHMybmVxb0hFWEh6UmNBNjZpWGlDa2ZIK1BRRWQ3S0Ru?=
 =?utf-8?B?VFF4cDFXRFFXRVJzZXR6ZHp3Tnpncnd2MldUYjV4c2xTQlRVSmxhRG9PRFkr?=
 =?utf-8?B?MkR1TDFJYyt6eC85ZlFRRldqTzEveVhReGVEOEYxNGNudWl1K3N3Q1VQb1U0?=
 =?utf-8?B?ZlM2MHJhNFRveVBac3dHckJuVGUxYnhpVlM5VW82QXd3Q3BRWTRVQkJDbGxV?=
 =?utf-8?B?SU1iZGRzT3ZicUh5OWN0SEVZUFR4MVNLcXZGakkxL0JhYWhkZmFJMFVTVWtV?=
 =?utf-8?B?Y3EwdzJkYzAvRWVTM3plTDlwRDRjUTUzeEFremlXK1NiNXNxVjUzWGdJRWha?=
 =?utf-8?B?SU40eFc4dTZ4KzlOK2lhT05OVy9oQVd2OWw2T3NIK2hPUVJDZUlwQnMrOEYz?=
 =?utf-8?B?RDArQllqNys4RnJzVVBhV3NuUGNNMkM1TmlYYVRhb3hGYlJIZUhoRVhYK2Fu?=
 =?utf-8?B?SStLZjBKcGZKc0hvWlBTQzFIak5yejV5b1YyY0lIK0ZBYlVaUFBhUTFnRXc4?=
 =?utf-8?B?L3hlU3RJWDJGdklTM1JvNU4zZlRiaFBObXo0R1VIeGRoZnBkUkNwNTJON0ZF?=
 =?utf-8?B?VWtmbVZwTUFuN3ZpajhUaVdodmJ2OHEwMlFCV0o1ZEVydCtZSjdvNUkxYTl6?=
 =?utf-8?B?RTloYlVGMHlZVzVON2cwdWJNdFpkZjZneG82T3lGT0J5ZDdobjJ3aTVJaWN0?=
 =?utf-8?B?ZHhKSmhFdEpLSXZLS1pXc014T1FqUU0vWW8vcVprOTNQbHVlUHJXRUU3MjVs?=
 =?utf-8?B?YzFlUlpsVTB2SHo4SWdmZ0N4MDRoODk5eW95M2d1MjhPYTE0aEdPYUxxMDFL?=
 =?utf-8?B?VXZTay94WEQ5dmgwTm9jR3h2V2F4b3VnZUVyaFdjeG5mWjVISlRicVcyZ0hv?=
 =?utf-8?B?bldqdXJtQ2lIajQ5aDNaMWwrd2JuTHc1R2RsdGcrbzRSa2pwTktOYm1qMndy?=
 =?utf-8?B?SEFTVEVkMXA4QSt0bzBob3oyejBlSUJXRXJRSm0vUWIrcVp4ZXMyeFF5UTBj?=
 =?utf-8?Q?hXbTQ4nJJ96ErGvkQ0pGLFaI5?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: def0ab06-dd0b-46a3-f3c2-08dd20a1cc2d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 02:55:44.5113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QDDzjVU/JhCEh2HnA7JWbQrPVMrAcPrBv6FoSHMTqaX/TYFesnw9yYb2HJtTCxE3f/aEk5xijlKQysqvlE8FTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10981
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

From: Ye Li <ye.li@nxp.com>

This patch adds i.MX95 Kconfig and Makefile. i.MX95 uses SCMI.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/Kconfig  |  6 ++++++
 arch/arm/mach-imx/imx9/Makefile | 11 ++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 54c6b117fcff21be5c3800ebd1dc30f8ea12ac42..596e753f2897c11d7ca3bcc9211af786d005bfd9 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -21,6 +21,12 @@ config IMX91
 	select IMX9
 	select ARMV8_SPL_EXCEPTION_VECTORS
 
+config IMX95
+	bool
+	select IMX9
+	select ARMV8_SPL_EXCEPTION_VECTORS
+	select SCMI_FIRMWARE
+	select DM_MAILBOX
 
 config SYS_SOC
 	default "imx9"
diff --git a/arch/arm/mach-imx/imx9/Makefile b/arch/arm/mach-imx/imx9/Makefile
index 45a9105a75a558dada3c328ed0878050da2a41e1..8d43ea2b267e2608df2e8f140c91b626dd969842 100644
--- a/arch/arm/mach-imx/imx9/Makefile
+++ b/arch/arm/mach-imx/imx9/Makefile
@@ -1,10 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
-# Copyright 2022 NXP
+# Copyright 2024 NXP
 
 obj-y += lowlevel_init.o
+
+ifeq ($(CONFIG_SCMI_FIRMWARE),y)
+obj-y += scmi/
+else
 obj-y += soc.o clock.o clock_root.o trdc.o
+endif
 
-#ifndef CONFIG_XPL_BUILD
+ifneq ($(CONFIG_SPL_BUILD),y)
 obj-y += imx_bootaux.o
-#endif
+endif
\ No newline at end of file

-- 
2.34.1

