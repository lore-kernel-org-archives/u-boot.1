Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A576C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 13:35:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76477879B2;
	Fri, 12 Jan 2024 14:35:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="IhISkfi5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AECBA879FB; Fri, 12 Jan 2024 14:35:18 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8595E879AB
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 14:35:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josua@solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnNaGLvhN7LzpJ/bfeAnm1+0ziK3JXMS295fyQpslmeAn7WojbaxFxH4UAbnhsveyHBLXJT34fYm5aHI8qO5fH0G0aGzC7wT9E+V4Ka1fdHjhnIRWu0Zmk8sS15jGnjUeY08S9K9aJgpy2pFTFr+8WxxcsK0O8WH4T1y6eNAAWnH4Wl6usQ6hpOMnhHqgl1K7oIeTp5BsqxyUAd0NC/juT+Lc9S7GFmkExq9ZP9mGyoOct0IjW4mx1fcpHqErkNa2LoRRUVQtAj2o27NhQPJh8yuBA9dqOfEHk4+7E9ox7sO51JdUQc28LtqXTRwSHsRVjOC7KWlUb3Ai8/g+EQYrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FMuHZ79Oow+fLKO3ee7j8/nyFZxf6mM7A4GAQA9Qy0=;
 b=VmESxpX2dDPi2laSPnnoYHlopL6t2iZa/YlkR9JYbp+W2wqTJ/Mp7uuDNnjRoA9ui6DpfQb938rEvfZ3aB4iopFCfoicqPJ2hwu/qSm5jXlUEBalNWI0X+J5H4qBrHWAFv2q9OT/jfD6oZ+4irXxd9tqQsC2cb1NpHsoiNFLhetbhu0ibuWmMgit0i2+TnjGhnYbcmnQNvA4GxKem9kQBcu9spckxyvN/oLS3NYDbVoTw905Fxi+yEF0fsNbwxiOzFK57OhTV2BgiBH2+JUs+BPHIzQldk+nduafli2DsRdUhG7ci6kakCNb+WlKmRslrtWzcWvDwII2JozirYIieQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FMuHZ79Oow+fLKO3ee7j8/nyFZxf6mM7A4GAQA9Qy0=;
 b=IhISkfi5aVUp6Qjyy1cXl8OUA0xqhqLgF3FocxauZfgsVl/kE6Nmgvg5BgXErNtqDSkoKDlOEM6Cyhdfgihfid6wc/4Faqsie6JDAuYqW2alOrzXK5lcEfRXmGz5zmSE2LAAiMeNAxwy/+3Gu1rEZ/nQaFyilDyj2PCDX8FC9uY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by AS8PR04MB9110.eurprd04.prod.outlook.com (2603:10a6:20b:449::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Fri, 12 Jan
 2024 13:35:14 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d%7]) with mapi id 15.20.7181.020; Fri, 12 Jan 2024
 13:35:14 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH v2 0/2] board: solidrun: clearfog gtr: add serdes configuration
Date: Fri, 12 Jan 2024 14:35:09 +0100
Message-Id: <20240112-clearfog-gtr-serdes-v2-0-4c24b751d838@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA1AoWUC/32NQQ6CMBBFr0Jm7ZhSoYIr72FYlHaASZCSKRIN4
 e5WDuDy/eS9v0EkYYpwyzYQWjlymBLoUwZusFNPyD4xaKULlSuDbiQrXeixXwST7CliZWt97Yr
 atN5CMmehjt9H9dEkHjguQT7HyZr/1v+9NUeFxrjWXUrlysrfYxjZo7ymswtPaPZ9/wLPQUX3u
 gAAAA==
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR4P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::12) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|AS8PR04MB9110:EE_
X-MS-Office365-Filtering-Correlation-Id: a15d2d23-8496-4162-9709-08dc13734edb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xMVQg5uxihjxxDlCbbjVf+Xwxu/lguA5+LLM2mfAI9pBR9DMXY32FDMjuqfO2wQLoaKvPbfimKW7J6mv4AJdv9UbPvlyLn8dRwSsb66EQQhkifEoUQGmKkf7KPYa3HpAFO5F/WPub+lkNTqIcFZVbJYUUJRFL/afPCkk1SDspwcfMSvob7Tos5oCHUZQ+Z1s0uZ68nWqC+ynl2bCH+MbIZMJ84Sl/A7nSE+J662PNw0tKKOqwUoL+uiRS1LiCDQe5JzEs8Vqkf355I4GbD9cmxrYA8aE0gs+YZPytfTZ7IpoOa07+SeLxt7YL9QmylBoszBAj1WfivgPELnVvvAadb8K2ipoLben5sn2o5JeLm75rsV/HRu7dHx44Ip2W6uQcUkJMrHfFkFmKR3X1pEDkm15srsYqeRdy/x0T/1dxmQF3GIhNxWN1yqUvzrWJNvYUgh9BCx1cRgwAQ7jp3MCbDaTu8d5OM5iSW7hB9sH3L5uV1accp6esQjCqhRd1oVjzCQELoS+w0ZCiVo7WlkoiI6Oknog1xsRT6VXXY34tukth4uGpR0s0Is0qcT9CbyjQSBxYXlZrG0B5csQeUZujYb74cQ6hR23CO18N8j7KuPMc9qFcefALwrOKD1mNchNxnW2gQnsRjb+DfEAgiK0xA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8963.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39840400004)(136003)(376002)(346002)(366004)(230922051799003)(230173577357003)(230273577357003)(64100799003)(186009)(1800799012)(451199024)(6916009)(2906002)(4744005)(5660300002)(8936002)(8676002)(316002)(66476007)(6666004)(41300700001)(66946007)(4326008)(66556008)(38350700005)(966005)(478600001)(86362001)(38100700002)(6486002)(107886003)(26005)(6512007)(2616005)(83380400001)(36756003)(52116002)(6506007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkUvQmd2aDZQd29ma2N4SnRjL3JXVXFjKzgxcWNwd2lPS0dNZkx4V3FjNlVD?=
 =?utf-8?B?ZE1Vb3VzdE45NjhOSnErR2FLckFxYnVvRjB4NnZ4M0ZIMWJOajdBdG5uVE9h?=
 =?utf-8?B?ZFRyeUtlWWQ5R1R3dDFhaHdxYkNLTTBpQ0o1ZVB1RS93dm1lRTZWYXpaWGZB?=
 =?utf-8?B?Qk5NcmtiZ0R4dHhzQmRnNnVXY0ZzR2hNdFA0eG5GNHNUK0J5M25OM1JqU3Vn?=
 =?utf-8?B?QXIweTBtQUpwV0ZVT3kya24xUmM1cUh4K0dPcnBiT21tdmdVRnJ0RWdNVi9y?=
 =?utf-8?B?dFBIaTNkZk5jR1VGN3A1T05nZjRHcjA1TmpRcVpkWGhVTXhSYTVaNHhUVk5C?=
 =?utf-8?B?YlV0Z2JvNkxCcjh1RVV0dnhlM1ZyNG9rSEV4OGptdWNjWjRhakd4MXZWZ2dT?=
 =?utf-8?B?QWpuV1g2MFVFRXlROFlZZ2FvOHJhNG9OZU9rTGNGZHVNcHBkNU95cGpqS0Yr?=
 =?utf-8?B?cDVVZktHRmtOdTJzTFdjK214UitIOWNKaDVlRHFFd1diQTBFSnZCKzBhU293?=
 =?utf-8?B?YTVpWmllMG1STTYvQlYyWGVwUUdJVmo4Ny9FYmRVeEkvUEdtcnBwb044Q0h2?=
 =?utf-8?B?UTdQZEFtVXdNSCtVMkxiQmJFdWJvbndlWU5rYyswVHRqaUhESTdUUHBPd01I?=
 =?utf-8?B?SWxnbFBXQVdlTWNOVklCbVBSWkN2dWdpY0ZUTFVMV3p6UkdqMGg3U0crVUgz?=
 =?utf-8?B?MmRyRkdhejRMdys0MHgwaUVDclJYWkJoemJ4MXpwVVNOVE9rSHBBcjR2T29X?=
 =?utf-8?B?cUlHWHkwNGpJNmExUHFkZzFDTWRkTlBhcmYzeitvTnl4UVlmL2FYT2ZFbWVX?=
 =?utf-8?B?RytMejAxUXdMREFER05TaEJMNGJtRzlTR2wvUEU2ZW0zTmk2Nmh3R1BqVWha?=
 =?utf-8?B?UVI0Yi96ekNlbG0zZENjYTQyWnd5QzBsWW9PSE5UeHNnVEg2bUhJRlExSHNz?=
 =?utf-8?B?QkFkUlRpKzBhQmJqL2E0MFNyQSsvQ0t5bm1maWpyaU1VcjNzZWZPMlpTcTVi?=
 =?utf-8?B?N2tIZStyZTRCVkFvREJjT3NFR1RXa0hNeUhBMStxZHVHRFg1NU9DTERFcXdV?=
 =?utf-8?B?RUFadWJ2K2ptenNPbWY2NUQzOVMweTlsa1JWMkdUNzBwMHplVHR2RGNEU0RS?=
 =?utf-8?B?aC9qMC9ZOUIzVFhnTm1ZWVBBdmVnYjVJNHVteDJzU05XTDJKNUZJM1JKSEw3?=
 =?utf-8?B?TkVydW5XQ3BhWlhpUU5PcU5nNXRlblJuRGk2ZDNUQk45Mk9SMG1Zbjlnelgz?=
 =?utf-8?B?Tkh6cXcvVzRpOE9XUVZkeWFsOHpyUFF3UmxHQWh3UENCelFEWG1ST1J0NG1G?=
 =?utf-8?B?eEM5eFBvaGFHRWNMRU1yMjFDYTdrb0ExRVRFdnY5Vk5ZR1dxQU5Ib3M3MVpm?=
 =?utf-8?B?dzltSks0QUljOGFoWG02dDh6VTZveHVSTGMzM3BmdklJWjhWUUdCZ2JiOVYy?=
 =?utf-8?B?dkZZd3ZZdGNIdnA4alQxYVB4R2pJemlmV3dQSDdta0RNdzA4ait5bFR1dWZl?=
 =?utf-8?B?ZEx6emNDQWhBdTVCaHBLbHBkMEVBSFNWbXRYZGFGcFdwdEtRSGxwMmZFYnUr?=
 =?utf-8?B?U1VVL1c4VWxNd2JvTlRrMGZuM3lvQ0FPREd0ci9PTXkySTVMRzFhc0VtQ2tT?=
 =?utf-8?B?TW9vQWlwZDNjbHFqc0I1NzdONW44Z1JjR0ltL0swS3E1TkIyZHorMHpyYkdK?=
 =?utf-8?B?MWN4SzBnWHFuYnZvdHJRVU56TllOKzAxQjIybEJkSWcvbnFQRTVyVTZIRisr?=
 =?utf-8?B?NEVPOVB0eVlXZUwyVjNBSEdSYUZ3dzRJSDVpRG1zK1YzcHMrdWU3bTRsbFJ3?=
 =?utf-8?B?UGFnSTg1OVBoTDBPTGJkdjg3alBVL0N3RVlJWHpFYldsSUpzUXFGNkc2NmZl?=
 =?utf-8?B?ZEVzWm9Rc3NaYzA4UU9rZzZEYjQzSU5TUGNlNmVoS3d2N29tdURMZzRCU0Uz?=
 =?utf-8?B?VXR3cEpSN08yNHlVbG8zRTk5RG5yZnhPcFI0bmxBT1NlSUMzYlZ6NmZUbkZ3?=
 =?utf-8?B?S2k1UHZVVCtPVitCeWh2cmM5Y002UzFvQnIrdmZValYzUFk4aXgxVXBTOEow?=
 =?utf-8?B?V0o1REZGNU1BSmNwd0s1NlRUVmQzZ1NBd3phL0k2TVpxUHdsL3ZTZHVkcUNl?=
 =?utf-8?Q?EDcnl+o8KNOl9KoerqAXOR1Ed?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a15d2d23-8496-4162-9709-08dc13734edb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 13:35:14.7335 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FiqghQwgnmq8QRqW4NT7VfUf5i9gB719hTSeHqlObipbFK+1+yD4RNZK7L4Oli9I5QHH2K1LGp5qBSvTpB0WAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9110
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

Add missing configuration options for clearog gtr serdes:

1. select between sata and pci-e for serdes 0
2. configure serdes 2 for 2.5Gbps link with managed switch

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Changes in v2:
- change choice default logic to remove kconfig warning
- Link to v1: https://lore.kernel.org/r/20240106-clearfog-gtr-serdes-v1-0-66cbc350c58d@solid-run.com

---
Josua Mayer (2):
      arm: mvebu: clearfog gtr: add config option to select serdes0 interface
      board: solidrun: clearfog: fix serdes 1 / eth2 speed for clearfog gtr

 board/solidrun/clearfog/Kconfig    | 19 +++++++++++++++++++
 board/solidrun/clearfog/clearfog.c | 19 ++++++++++++++++---
 2 files changed, 35 insertions(+), 3 deletions(-)
---
base-commit: 2ee7a8ec6f1711abe9619fd8765edc16742be9de
change-id: 20240106-clearfog-gtr-serdes-8a927f496bda

Sincerely,
-- 
Josua Mayer <josua@solid-run.com>

