Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F31DB103A9A7
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 11:28:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86957840A9;
	Wed, 25 Mar 2026 12:28:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KqKQda0Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B74A840AB; Wed, 25 Mar 2026 12:28:07 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39E6B8409B
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 12:28:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pLNxt9w80rch6fRNp39/H9jHutnaJKa7Xb8X2kt2QxigE9WUDL9yoZCqpktuMcYXHdfpx+2CVX3yotCFVha/LzGcyO4T0MkVPKSeDexVnJRLRQTjsuThmbBEEMwiANR2eyckafDHB2NMU9Jlua1vVbdW0kQ8z/tVT0SpDBD6ei6lQ/C4GcAXppsZIqVgTa8mvf6T4gzpSXrX+7pgJ/yKHvwB9wfZm6WnymVcJh79bjwxhbpcjBPTjzESFwUL4N3zE+duLtPqF/YfZTvG52llHGMWoXegqE/+My3cPFRaOg8Kk0E3s5rHcbXL5JuleFPtRmjxpMg2XrOfN7ql1zbAIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z//3b3yid3EnfQU3hElyvgkx7peGi03n0UjA6toHLd8=;
 b=U6zPKQ3cwmnYq8V4YGaFbaTY4B2tajfCoasHTVswvhTIyK/tN/vtvLsuqUeX7kEpL9JHgmWQMP2iv/hSZN/1UKVHAyAN4LjiIyUkkLfkzb34ONyRjcSOpTNJ94v/qFGhH8iHsRtA3Rl/mi3FzaUDKKdJKGbXmp/ZTQHp9FYku5wh6zD+KPhSafoRBh0kp5m0775duhIf3a13s5rGP606soIVFXUnHxrkYvkvMgw9HC0wmKY6Bn+vYsNxkXrHfLuOWGBykJpcfXaE264fAi/yKqzvxHjkdIQLVnhOgayT2IMK46HHay+F6vAk6UmrDLO4lgE1uclaFtNk3dmioNZyxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z//3b3yid3EnfQU3hElyvgkx7peGi03n0UjA6toHLd8=;
 b=KqKQda0Z67gmIGQ9K9YOA2VbwkFoZ3rrazKxfWVFAfc8hnzWUlSFEV3Wnrb9EvLr5AkyGyJdG+AymBRKmYc4iBH0AqI3fZIWzTpXR3MYlR7CXByNwiPd8T6DZPPYlK7pScJqdkN6SKnLUoCSEnezzWy5fHt/twHMxNDDlGVah2GKGv/09xk1Koi8LIBj/tB2x/5c0ALJthd83ofWbUoAFh6Zj4aQSkbQF5vQ+nEOIcnQkwFBTvyuSx2rwcthXrlud6FI0/INDZXzMjcQpqWZoWbFaNOZ6oh+2dg9Plffa/AoL2pM9aqhlHLRfXImDWIftQrERroxM8ZIJsumzSj6vQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 11:28:02 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.030; Wed, 25 Mar 2026
 11:27:40 +0000
Date: Wed, 25 Mar 2026 19:30:13 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Steffen Doster <Steffen.Doster@tq-group.com>,
 Max Merchel <Max.Merchel@ew.tq-group.com>
Subject: Re: [PATCH v2 3/8] env: add env_set_runtime() helper
Message-ID: <acPHRQnBlR7s4z2h@shlinux89>
References: <20260325095801.47706-1-Alexander.Feilke@ew.tq-group.com>
 <20260325095801.47706-4-Alexander.Feilke@ew.tq-group.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325095801.47706-4-Alexander.Feilke@ew.tq-group.com>
X-ClientProxiedBy: MA5P287CA0010.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:176::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS4PR04MB9692:EE_
X-MS-Office365-Filtering-Correlation-Id: a2d22a38-1855-4668-4e1f-08de8a618692
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|7416014|366016|19092799006|18002099003|56012099003|22082099003|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: mOZWNFDyK1XGub+prw5iB26dTG9Zko0Pjsyy/IRZ9TX6+Myf+z7T1C3ejJwH6oybXUEa6SJej56lbGP7ZuhSLvw0CzPFE0Y/BUiISdiuZnGH0s318fHy119JfFo1t8FLl45yWK5sZQDkHkExqYp8qLiPWeVNJBdfvutuMevKSR0zgzBlBpILMcc2dO3m5rD8EO5yzitJaHlQg+9HxPUXPr9hf9gQ7jS6DZmPsXdr9a2tKgUfcJbJxbMA8U6cUtqKrBJkZZ7DgWSn+p9wKfDCBQR/FI8LTUZW4T29zv6mKi/AMp0zK2eG4oBMk+vqaos4v4vhZkM9Isr03F6vxAepsNuXy4PRsJhhP7viSVemLDoW+GCJ9Emqg8dOEoRBwjjw/uaYPS9zi9SmJtJalO87bU3kndYjucdfyE3Aaq3eGfxxXJ1l09/Q8a+uHGTd0iRPnhzrjut5krhDx+y/G62mc+hg608Js7FbWZr4fWVdPHTacjqv7K7eYBEFOikS7QfmTTHR5gAWOISWB+aE53nKyqK1hZMl2b81O/3lNVlgosrTxYe5eO9DSYqEo5R4PEldaPefk17oG4t/T6LB19080AiBav68J+XXWJTwjC/s1Qe9xecQ3e0VLCPFMkObg2t6VqDyh6Q7z2yn1Aj0MVbodvMdjQwjWh+HL+rPx7dKc+cvhCIDIqrQvOmJX/EjV3vHH1aVIm/pUwq6lFZsYXhcN7kutVDa9anHHwZGDSYwj9uVy3lqHBNDMh0UP7odQx3LDgpCafuGjdnsqYTWtJM2xNxCawfbzE/Bla4u6aiXx4Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(7416014)(366016)(19092799006)(18002099003)(56012099003)(22082099003)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?85uT3Psa9uGDOoTfGdaKecK+SRtVj65ypWBhntNG+kXcoIZSnzYsPndtb36Y?=
 =?us-ascii?Q?nMGWqYa/iiRm3SN50jrr+ai3nbfxlks/pWrgi9A2KwupDaBoEH82eonVp22Z?=
 =?us-ascii?Q?j54Qs76svdVbXg+XhWPPgC8ViZ/JMQaTdyoKWuaSpl9/6k3L6/M6agnyEeaV?=
 =?us-ascii?Q?PvD8sKnKBrngWMo3ZDHvMXVLC3LwCcQHCzmaP+HZ+E9v3Z81v7bFkPPnJAPp?=
 =?us-ascii?Q?4ZAPx/uIT+zKS8VuX1oo8retdadnS9W/Rwal2l1ezMUq/Xl1yya5zlTl+Kmm?=
 =?us-ascii?Q?yE2nJbXN5s6WUctvyoijRJ/zL44w8RCyWp8txloLhaC3BFbYiMIvDi1waIo7?=
 =?us-ascii?Q?+nWqWuoLD/5b7os8Iga5PgBp9EwEt+LoqKdyTLDKgy7kfusKqm2evSq3nio5?=
 =?us-ascii?Q?OG0U/zknOYAkyGJ0dOhS60rEb+e6YygbvqhWV4YIFWmLJLvskd54JVcja2tz?=
 =?us-ascii?Q?41+bNNulzd9Vps/PShB6+wciqJPvjyTPFJWZvpjmLWpaGhYfxtXa2ftSbAZb?=
 =?us-ascii?Q?biOmcnGBLbyvyoStMLCNIA8rLfdixutSvbJUZIn/9rbytNzvr6cvx/lOthv2?=
 =?us-ascii?Q?g71DbZBSCJC0ijB+SuKmG1HLFOiBqz4fAURwHmafw97F+PM9xAxAuicqM9UL?=
 =?us-ascii?Q?H3+2EHb4vnqYIDtr/0p2Akkx6rkDNOdfBL1SGKLgbJcvUrDosp+WduqlasZ4?=
 =?us-ascii?Q?nF7V2WAVGJIWYwtyTnt3+RQYYK151Ba+bpVU4jB7i6GaAZRK1+pJdT3lQwF8?=
 =?us-ascii?Q?kwqsScsRYmLHf1OcX7KVjLAKnfu9uSs62BDlRP/IkGWhVjnVD+d5tHYHT5z0?=
 =?us-ascii?Q?m+aOA4CJVmNO+OQC04RnOhkUEM2V/Mp+Szb4CTtC6ocfVypTnwwLBZRnaI7V?=
 =?us-ascii?Q?WyJW1/DRXlsQWrEYUoqSCUOsarGvJMbmSUnx4aJm3snbfd3jgEAqZ7HXlast?=
 =?us-ascii?Q?kC10axRLYbBnLkXmZENoKZ9AZx4ukpCoRkEFcaoAojpB1VzlU1xPuqQFBiZR?=
 =?us-ascii?Q?fzADfFAvOUtj+N2AtWLPst29hR4kagIMGCAcoW44jpvBWj7RrdSbbtVgpEAa?=
 =?us-ascii?Q?q8ZqvnWR2tgHZ3eEL0u+gy2HKlPxos1ceyzI0vSaWICOIMb8F/3UEOfh0DBO?=
 =?us-ascii?Q?uGMVnuKJUsjWUCrSwquXVNne2yyecBCeDWjxjKqNMsxCdFajZN2CArIRehi3?=
 =?us-ascii?Q?1CJ4nZkt1yN6rfya0yVggEsNsTTM2pxVs6zYqARcfiMMcz7Nh+PUz6o/+QLl?=
 =?us-ascii?Q?Y7msknNUjCXVsGmCIaK+l/HugkkIYAGhvxEAF8uH2srTdKDrSHsFE+9MXnsh?=
 =?us-ascii?Q?kZBnfYC6sO5poM0C8kWzrQFS0LjUlYiZgzZk6OXC+g4gxTfT02lhsJW/k1VQ?=
 =?us-ascii?Q?G6EkMad7tl1Ei8aJmKyhVeHPw9Bti32exE3qj52M1L1TSs3QNNumZpovf0lp?=
 =?us-ascii?Q?1HnLRHIcTR192M3Wo/sftp3QoeZp2vYh+LisRTucPjQW0/OCVUqXLBfZ6rZk?=
 =?us-ascii?Q?7tSG3aS5sKgQs0rnqthNRLUjgwuA+l/fzBxoCIOFgT0n9NbSv11F2Wxd8exS?=
 =?us-ascii?Q?DOGPBWhFRsvKeBoHVqRsBwbDimJshtvlGkiLvd5Z/YYuPaxzIh1AckPAx827?=
 =?us-ascii?Q?prAOxkbH4mJYLQ0vPLU7zT6scpEKdXvFA+Z8YCR2tVgWe2si7JUa9Z20ws9U?=
 =?us-ascii?Q?agpfnSNE24tt2Pjg5EcTTxBesCQUGhKDIsnpn2u/wLjbSEvH9yJe2yF5kfJI?=
 =?us-ascii?Q?1Z6SNK1zUw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d22a38-1855-4668-4e1f-08de8a618692
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 11:27:40.8623 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cSC0KSqb6UelPGcK/25VGkNwZ2n65rTzkhwvGZMB2Utkg+am50ugogNPdJD8hpnAEIeDVR0MyLajJ6EI2n9zIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9692
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

On Wed, Mar 25, 2026 at 10:57:56AM +0100, Alexander Feilke wrote:
>From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
>
>env_set_runtime() is equivalent to env_set(), but does nothing when
>CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG is unset.
>
>Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
>Signed-off-by: Steffen Doster <Steffen.Doster@tq-group.com>
>Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
>Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
