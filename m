Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63851CDD56B
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 02:59:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDA3E88FA3;
	Thu, 19 Sep 2024 04:58:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sG/n822D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8EBE88DB6; Thu, 19 Sep 2024 04:58:22 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::603])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C791788FC1
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 04:58:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VbXIwi/I+HHzH4Y4P9iAtH11msL5hzlADTDq2+p8RLuoQzfWvKTnFyfH0FC/yQnIW30sdjoYY9fye6srBbtM9xmLXPN299Edj3wTN/Xp7aJX7mFx+RgQSlZC7mJrYnn1sG4PK+fdbO0L+LiQUcfE1EH7Bjv8iWo8oZQyOvXi1OKeZtMssS8PbTnv6p9PxNB+aAK/mah9q6/kAqDg09WGnX/llD2X8EkxvJKGt4QJRbA4P8bYeQQ2EOMxbXiYtfPKC+bJZRMebln+Jg3ijNqhkUJ3a7cueOIrj2O5Djpfo/s+cA6EAdUcMELodsh1ZQzT4/FDQmL3jYg4yIH9iPPsJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8+Sy/DiUmnZrfVwpRGb4rxvt0t9arvtFB0nKmXFfIk=;
 b=wpIco+V9LhTgNeMjJncQ9FEOjZ0b4z0emooflMeboHD3aOFIMCODZaig2avreAJ8zlaq1ZC4/zVenLa+SOftfjtjkEWrdf/yCCVXSXiB5nSIEFl8OY2VVT1/PInmBkLdvAJCTCjBhOSW84nx/FhZe6LkhGaarHpf4GU2XCr6i0aeOOUOV21KdYFIF4OnwImFz+Ap6IA8xMc79/zUSunIRRl1L3y+HEMFeK3/e7QnTriXjn9uo1lDZ99cI6mjw7ajCzARqfQNmqTfuE1enM6OlNoLGmWVV/JIS7T9SccFnwkZvnq0gfdyiRTiObQkFb59mYIlZV6aXjY39Ln+/hQhGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8+Sy/DiUmnZrfVwpRGb4rxvt0t9arvtFB0nKmXFfIk=;
 b=sG/n822DNIT+qPbTmEA8UXxhw9tAaywD3iIm7TDe27bFgS2M11jxuytJwm0+tIvXwTdd0tKJF7pmJ2GJYqifueOl9duQOFXCov08XK2nB1FSlRA5NKPwWI+BLF82cddpUhkE+gM1x4UWa54v3sTFD5i8pY02Sq6HN2jCRrbtWagj/TkKJ81rEuVBuhGnW7kLvFTkfl32oglB5mqBLAWBZ9M0uwqYXJQSQgbKgvoL7DDxHCUOo5yysOFV0TtczlOeWMqH22iDaVGfg7rcJdAqCGC3TwlAW5FG/mxD2a8Zs82QydddfBh2Alr1Kg3p//XmMb2zeTJzN48xEjZ51RvfuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9986.eurprd04.prod.outlook.com (2603:10a6:102:380::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 02:58:18 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 02:58:18 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 19 Sep 2024 12:01:24 +0800
Subject: [PATCH v3 06/21] imx9: soc: Change second Ethernet MAC fuse layout
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-imx9-update-v3-6-80f9786cd1f0@nxp.com>
References: <20240919-imx9-update-v3-0-80f9786cd1f0@nxp.com>
In-Reply-To: <20240919-imx9-update-v3-0-80f9786cd1f0@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9986:EE_
X-MS-Office365-Filtering-Correlation-Id: fb925b17-5689-4840-2f1b-08dcd856e9fa
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R2Fjc08rTGY0dHBkNVUrenZ1c1pVL1JTMkV3QUkrZ25xMUg4ZXNGN0F2WUVn?=
 =?utf-8?B?VTdYT3J0UXREWGhvNWFjRHg2SVVVaWxKMklnVy84WkhHWjAwMjI4ZXNPcXJu?=
 =?utf-8?B?WXFzS3hWR0ZjeTVVY0Ixc1RLaW1wQ2Z6TXNoYmtOazJDOTZ3SjlzMWp2RVMr?=
 =?utf-8?B?NU5xcDJRU0l2cjdlbVl6RXRPY1RUMktyMHpuZkJuNFhMTmExdmZCNzNFaHJY?=
 =?utf-8?B?dW16dFYwUmtwbitrVHpMeEh5c0d4MSs1N1VFTlRVTkx2WFVzaUhEOHQ3Nmdw?=
 =?utf-8?B?V2ZHRG8yQXcrVU5oM1pwMkViZDlqWlVZbWFNSDNzWU5SM3NCQ2FjL2JhWWt3?=
 =?utf-8?B?VytWUTZkRVFYam5oQzNHN0VCVS9ZWnlNNWtCbmpOdGUxN0hQL2QydmR3eDRv?=
 =?utf-8?B?NGZ0Ymt2eDlwZ09peU5RV1UwdTdiMUFGK0VVeU5iY0dQVkZPUzhpNkJxWCt5?=
 =?utf-8?B?OFdoWXRtaDZscjJGRVdUQkNrL25vc0swU1Y0WGhuNWRlSWRUaEJ3bzhwTzVD?=
 =?utf-8?B?THFXUHBOTVRIckgyT0thZm5kaWxlczdlVjgrVXNBUHRmcS9QcWFZbnF3M1Bm?=
 =?utf-8?B?ZmFVY05PalhkMFhZdURuTXF1M3pSWjdxYVJtdi9ySVRSdGVnemFHeUZ1bnBt?=
 =?utf-8?B?NkExRE1vNkN2VUJpRDNCQmVqV2grS2xzaGk4ZDFYd2YzZEtJMjlpbjl1TGVy?=
 =?utf-8?B?NFVpMGJ2OVowNGFnZ2VRbzZCK0JyUnp2K3Q0NlZZU01vdGFBdTRXSXV3Nkdw?=
 =?utf-8?B?MlB6bzIyOE1OZThtVU9remRvaVJZcjRFWWg5V0kxVmlvTlhJYVg0QzZ6Y0FO?=
 =?utf-8?B?VysrQytCVFBVOTRjZ0NXOXpBWU1HVXJGNjNRdzRWbjRFS3BtTEx4Qm5HcURq?=
 =?utf-8?B?OXJOb3dRalBDQzlOSDdrYW1oL1BvK3k0aUNEWlN0WGtCU0RNMk5pcUhick5T?=
 =?utf-8?B?TkFYZ2NHdWlKemxJcG8vQUdCalUyTXlOMm11Z0RMRE16eUdDbnE5QjRuTjNQ?=
 =?utf-8?B?NzNmWktYdW1BMlVhRW9wKzJpWEJMeWxTbndFZmVybE44enJsTkFRQmtxeXpU?=
 =?utf-8?B?RlI1WGpkaEZEa2VGeHNtT2ZueGRpY00wYS9xVndUN2RmSkhHejVBeFVEcHJM?=
 =?utf-8?B?aXJRVkVXaDllWDBuNXZaeXY4WDFqSjVHWFNqWHFYUitQV1JaRDBPQWdNOWVE?=
 =?utf-8?B?UTF0dlNuK0EwSnFINmczRHRtUWR2WTdoNDZRM25WeXhuamVkZFVwTWVVNTR3?=
 =?utf-8?B?Z0R4NDJzUUZaYW9vSEh6V1VVYkZ6S1VKRnYwL2g5UFFRUDVhVTczS1BlWDR6?=
 =?utf-8?B?ZDBSYUw4N2NZTlNJT0lVQlIrZ3V2MjduMGxxMXZZeHcvTU1sZEFWeE5hREV4?=
 =?utf-8?B?SlZYWFptTU5FY2pEUE9BMEsrWmJwejljZHgwUTFFYk45ZG5xcEdPUnRNcG8r?=
 =?utf-8?B?Z2xCb012U1RzWUhsSTJlQzhuZVBpekIwbUVmS2N1bm9STS9hcTlXdktpbmZu?=
 =?utf-8?B?MFVSRkRucE5CYVZCdkFMY0RvUTF3ZEhiZC9SYkR3TjVNTWp6ZEsvT2lqWU9x?=
 =?utf-8?B?RklEaEl4M3lYMHdWa3U1RjNrQ2lkSktLMURCM2tDNjJLWnlkNkNDeFlBUDVN?=
 =?utf-8?B?ZXVxV1dkczNQQ3loTG5xZG5FdWxlUElVdW9RVWJiSGZaVHoyQjVRZ2l4bGZw?=
 =?utf-8?B?Q0RoV1R0aFE5WDNhUmpjeTQ4RUsvRDBndmwxRTFMaSttZExUc3dWRVBVRERT?=
 =?utf-8?B?cGlSU3VWZ0dwMEhBUzQ3R2ptbUMzQTV5VmtjNDdXTUxHS2owYURKbmpWRkZs?=
 =?utf-8?B?RTFHZW9SZDk4bldtbnkzeWRJdm1qTllNSStjbkJTbWpkdUxaOE44eVZLc3hO?=
 =?utf-8?B?V0hkdDZVMjZ5VUw2bWJ2RzU1YXNqSERsRDRWaDhuVTA0RGc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REkreEtOMjh1a0lYSUNIVno1UUJ4b1BhODFZNXRnY09sM25ZWVJUTTNpV0s0?=
 =?utf-8?B?Zm5PVDNxbEREVlc5RElEYmdmOThPdEFrMHFXUitoQkFnWGVRMmk4ZkErRzQ0?=
 =?utf-8?B?OGc0Rm8zRDRJMHArbUJRL3drNXF0ZTFoTHhveUliU1RMYWsvc0pXUjVPU2lx?=
 =?utf-8?B?ZUhnVU5qSHN2S3FrUnhsMGNJNnJOUXJqcEIzUDExdzB0b2g5RkNTQXNDUGNt?=
 =?utf-8?B?MGJGa3NqMXhqOUJLWHN6dGNTV0V6NzlQd0lReXc5bHlyK0FlRVJzTFgyamFP?=
 =?utf-8?B?bS9TQzFYWG9IajZmRjdrVlJVUmwwOHRkZkhET1Q3SU02SkRHenNjUTBJdWlC?=
 =?utf-8?B?TXg0VVA3bjgrVDBpUTU5Z2VFUHlxZVBxcWFLVVl1c3p2SjlScFlqQndYaURu?=
 =?utf-8?B?amptQWRXczI2RVJqTDhYaTZzaXhVSDRKMG5wbjV0N2VGTVVZa1BMQ1NrcXJB?=
 =?utf-8?B?UExUWEkwNVhLbmRxUHduU01mb0kxZ2QwTEpsdnpMb2pqTGM1UlhjbUtJcWgx?=
 =?utf-8?B?UC9RbXo4UXJheEV5SklWVW5OS2RIMHpob1pYVXBWckRxZGNmNzQyYkVHWERD?=
 =?utf-8?B?T2E5UkJ2NDNvbG5PWVVFR3VnUDBCVGdwR0tBUU1IVHlqdDFyQk9tUE5tWksr?=
 =?utf-8?B?UnRmV1BzTWxPS1UyclBFWVQvNXFnbWdyZXpNVmR5RmZMKy9tTHJRRG5Ob3Zy?=
 =?utf-8?B?ZzZwQk5ZN2c4RVI3WW1pNFFnUmJlekU4T1N4ejNFOVBnc0FKNWphNlFNUXJC?=
 =?utf-8?B?M0NubHBtd2RTbW5WVjFaZHp3ZzRtM3FqcjVvUEFRU1VScnQ3VVBYL01kU1dm?=
 =?utf-8?B?bXZFU29uTTZ3U0lnUjZLVUVGYWo3ejNOZjhjdUlNNVhTUEkzeHZMaG5IVCs4?=
 =?utf-8?B?eWhSRnI1OGhBd1czKy96eG9NVVZvUDZsenJaaGNhT1cvYlBaRGFzcTZIVnpw?=
 =?utf-8?B?UXhUMGtMOVVyV2V4RlhyWVdIZ2xNdTA4YWMrWjg3S2F5Y0NGaVg4VmRKOUcv?=
 =?utf-8?B?MW9SWUREcXQvVXlsNzhRS2V4VXdZTGJBTFVGSkZvR01hNlFvR1d0QXRFVnlz?=
 =?utf-8?B?akZhSkZqV3pmbDZ6ZkJsVExMMUhlWm5PNDUvbXB3cy83eWRjOFp1M3J1WjJC?=
 =?utf-8?B?SEthUFJTNjZ4eW11cnpJZmRkMnJLWVp2UkZHUGd1Wm9xRTRac1FNeEFEelF3?=
 =?utf-8?B?K3lMN2dwYTQrNStpSExhVFg2VkxyeHhNc3d6b3p1RXhFQWh5YzRJMVRYVVFN?=
 =?utf-8?B?dTVSb1RlVU96RmQ5RE5oV0V1Q2tlZ25vYzQxMFpWYkFLSjZLSHhyWkFDVU4y?=
 =?utf-8?B?OXZZcFRmUDJ3eWVJd2V2VE9aVENnT2NwWkZNYXNocnZJRXl1OHFVN2dad3FV?=
 =?utf-8?B?bm5kTzY5N0RLdkttNkgwUHYyMVJVYXBqV1psU0tCOEJPNzVKTEdmdExvY0ow?=
 =?utf-8?B?VVZMRmduTk1qYXFtSW85MDQ1MDhmSWkyY1pldlMzaldEMXk3U1M0VGhiTmUr?=
 =?utf-8?B?SUJPL1U2YVRlbVcvYjFvdUFEeVhCYzVIZGw3UlpqbGx3UU96TTdCUjFnUkUy?=
 =?utf-8?B?N0VRNEpEWG5VTysyS2w3Z1JURzl5dERZYmx1cEFmbDNCaVFzcGJhQ3cwT2Q1?=
 =?utf-8?B?c2tMdDFueGF4UUczelpUY0svMFUxbzMvQlkrbTNwNTNHYW5pK3hFNmFRTk1I?=
 =?utf-8?B?UFZ4QnFNMU1KeTJOaVpRNDVMNWhPUmR1bUZobWZyUUtRTUI4dkR6bjBwZTBR?=
 =?utf-8?B?Ykw5V0dQSHlWbmZSRG5iQldxQ1JqQmtpZ3FvT2dCVUpjWGtrZE15NU9KQTZL?=
 =?utf-8?B?cVF5OXlqNzhDZzVkNG5CZXBoSVVQVm9Vb3NWRldZWG9NeDVyMEtOU0diek9R?=
 =?utf-8?B?d0JpV0EzNnRrTnNwTFRMd1QxVEFUY29rVXlyeUVDT2VWNXA2OEE1R2tldUtq?=
 =?utf-8?B?bjRvYWE0Y3VZeUVXZFZLZmRTc1p2a29ITDJ3Sk5TMWpNMXc2c2pxUnFaNUE5?=
 =?utf-8?B?ekpQd0dCa3Jrc3psUzluWHVub3Bub0xKVXE0UWN3S1hIalhpTEM0dXBZM1dB?=
 =?utf-8?B?ejQ5dVgycThvRGphRkwrRkhoWFYrVEhQa1E3a3kwQ2tPdzYvOE1vN3NUanNK?=
 =?utf-8?Q?0z64Hz3a0g5wQyN5KgIDSP+ZB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb925b17-5689-4840-2f1b-08dcd856e9fa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 02:58:18.6260 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sLN9L9Ju0Dm84UTJWWdReHDCzYi5b15YRxNlNES4vHCrj9MXUymQaeeyASSpU0bpNU4Hml9P6zd+WGHa5+LUjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9986
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

The second Ethernet MAC (eQOS) fuse layout is changed since i.MX93 A1
following other i.MX platforms, for example i.MX8MP.

Order for A0:
MAC1_ADDR[15:0]
MAC1_ADDR[31:16]
MAC1_ADDR[47:32]
MAC2_ADDR[47:32]
MAC2_ADDR[15:0]
MAC2_ADDR[31:16]

Order since A1:
MAC1_ADDR[15:0]
MAC1_ADDR[31:16]
MAC1_ADDR[47:32]
MAC2_ADDR[15:0]
MAC2_ADDR[31:16]
MAC2_ADDR[47:32]

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/soc.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index 5699623027e..9494c739969 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -504,12 +504,21 @@ void imx_get_mac_from_fuse(int dev_id, unsigned char *mac)
 		if (ret)
 			goto err;
 
-		mac[0] = val[1] >> 24;
-		mac[1] = val[1] >> 16;
-		mac[2] = val[0] >> 24;
-		mac[3] = val[0] >> 16;
-		mac[4] = val[0] >> 8;
-		mac[5] = val[0];
+		if (is_imx93() && is_soc_rev(CHIP_REV_1_0)) {
+			mac[0] = val[1] >> 24;
+			mac[1] = val[1] >> 16;
+			mac[2] = val[0] >> 24;
+			mac[3] = val[0] >> 16;
+			mac[4] = val[0] >> 8;
+			mac[5] = val[0];
+		} else {
+			mac[0] = val[0] >> 24;
+			mac[1] = val[0] >> 16;
+			mac[2] = val[0] >> 8;
+			mac[3] = val[0];
+			mac[4] = val[1] >> 24;
+			mac[5] = val[1] >> 16;
+		}
 	}
 
 	debug("%s: MAC%d: %02x.%02x.%02x.%02x.%02x.%02x\n",

-- 
2.35.3

