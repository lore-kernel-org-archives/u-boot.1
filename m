Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 934CED41C14
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 10:11:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE6F383DFA;
	Thu, 11 Dec 2025 11:05:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tOAKIwec";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CDF483655; Thu, 11 Dec 2025 10:11:23 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 244A7835B3
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 10:11:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bSO20kiRJy5yAfMzBGZbd148Ef9LBDIESC6HcFhK3Tbr4GGrHj0VUGrNT8ISmOQ6lBYVm1rJ9Os+cHJMj3YheOufi3dWSiQhHH6lh9rtld+mldak6+Fv+e3doyRWA+emrtkqy+zHwhrJDCin3zpNlbz5yOXJfRjP3sdcPdkv9t7exk3qTTVUeVf5kEAK5dqwVzVYjUTs0ZQr5JHI1vLPP5U2ucSr2Ak3pS+/IU4KPSZ07UrcMntRpUGY45AeKaBQrvI4fCAr7Wwq5nAb/1FRlMj46D4nUzq8u1/DACU9APt9WWvCTeaCGw/oNI2gEneU5UZJPpkhQBoZRyXP+5E2PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DpiL7zdjCA5JAXM5GBDFVXraiNX4IpzV7vlx7yB5z4=;
 b=LdbYDeGRp2yLa+oS6DyIdSPJzLckynQmnHnxD1Waj+OpjUHPJ4b/mvWgUNJ+mO/cPX3xdOKqR0vDQUf+VT6wD8m+zieLVRNqhJXgfDcIZoEcQV06BMkvqRMG8+y+pCEiMly9csQ/7KqfKqDkGjh7KQKrGu/NqZr4WmdbT4qHilSfwySI7x+xyasrNvinWWFjFahBUqCochWBGEopfinKLMGZRQzO6u4RbbqOmSyWh0leMGoBz5eFwJtgKT0M/505x+GfK7B7gLY8OvqVsUFPDXvZ8GYVXjjusons9pZsK/LpeD1kblV2V59+fM5zt4YYvEkNoonhH2B3ZPTnh/fyYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DpiL7zdjCA5JAXM5GBDFVXraiNX4IpzV7vlx7yB5z4=;
 b=tOAKIwec8MXqio27T/udr/foFywXy/iNPJkh15q71n87sd5jAjsX+ySaSV3OXQq8wkbyb/BLpquGzJgALQauRZSIMTUUne+OQ1dZDkNhKD6XXNld/Z+ZAqWi4giXSEsbdGYDrNEBJwNxsAKP8I8BnOjbfqRPpzzmV6O6vbzYXMoVmOCu13JUdGFUqo+uOGMY8FuOpeAHLMEH0RKY2Wdpq1dhyCEoF7b0aYACg+xYn62NZysdXxaEhecg+a+8eSE/vgFk99CZUVRZ0D5GeHn1gG69wxdzIMswtKA6lyj1pWXpObyCk+/8vS2skP7MJeBNBl+6JwTduV9beKej7Cq1dQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10903.eurprd04.prod.outlook.com (2603:10a6:800:265::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 09:11:18 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9388.003; Thu, 11 Dec 2025
 09:11:18 +0000
Date: Thu, 11 Dec 2025 18:24:50 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, jh80.chung@samsung.com,
 trini@konsulko.com, marex@denx.de, tien.fong.chee@altera.com,
 balsundar.ponnusamy@altera.com
Subject: Re: [PATCH v2 7/9] mmc: sdhci-cadence: Enable software tuning for
 both SD and eMMC interfaces
Message-ID: <aTqb8s8hxClk6I0J@nxa18884-linux.ap.freescale.net>
References: <cover.1764760325.git.tanmay.kathpalia@altera.com>
 <d1af5400543f402da1c36e7ab786e7c1f1cdb21b.1764760325.git.tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1af5400543f402da1c36e7ab786e7c1f1cdb21b.1764760325.git.tanmay.kathpalia@altera.com>
X-ClientProxiedBy: SI2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::9)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI0PR04MB10903:EE_
X-MS-Office365-Filtering-Correlation-Id: d6fa4137-bff5-49e4-3711-08de38953eb2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LdRPz1jW3TIN8bl+4Ky13A+50rNyOQZFPsrVK1jbIYK9S/G4Tj1aMLIvuHEm?=
 =?us-ascii?Q?bdtoRDx43XdtSnB7B+2MY+HuOzqbMJgXoTzcKqU18/NFAQKI2fwjOWA6/jsl?=
 =?us-ascii?Q?ZfD2PL9pNtXn5MaxBR5or0wlo8DToUtNJkTQzAAggsW7d1NRlNRR2+VP1abt?=
 =?us-ascii?Q?VXvktYKbePhIzsZCgVbx+WacymBQlUD1BPXTZMrFdKtWmpt6vqGQ0uLXicNd?=
 =?us-ascii?Q?FvrQiAzZOGOUtG9yu7PKW5Z1bYmgeYQOKCiG22tyFu4gH299NevvZ0tR5z1a?=
 =?us-ascii?Q?DXUYlMVs5HHMHBioxp6oqNSW4UNLnALhPHPk0bO0nyr7Is8m+j2cnHRvykDG?=
 =?us-ascii?Q?sr+KwPXw/ul+r75HZXOq2hjGhPCxZWLZWePnsdwIVakiRCKVTSyiFc3wGpau?=
 =?us-ascii?Q?lGwbnFVxSPh71tEck3rE3DkY2TOhNmRAKBB65gXk5J7Iv5jGVt8D/na1Ws5G?=
 =?us-ascii?Q?hC0giCTL2qLsS4lRlblSfx9oioNHDa3jJ7neFY3WIXtqKSlaaj5ymc3qTJzR?=
 =?us-ascii?Q?l41KRiUNDCJ1J+pHzfUTQsYYLEav9Kud+Rkp7tGHKEd3irbvO2E7fM+nlWkg?=
 =?us-ascii?Q?H8VpRO3BG24jfMbaeI3C3H07/rCuo648qPzKWQYcL2hR3Ntxz2bRdr8JjxBu?=
 =?us-ascii?Q?CXFPgNQSKN8mUB/iVXXOSzxdAK0YE4rl5t7m0fnTN8ca77wELbe3hQfNNBiv?=
 =?us-ascii?Q?aFe58n8AKFQZXRJ15N0DtHBq90WA0w9VAE9VCiZP9YkKNYPdRuqdHCDynuAF?=
 =?us-ascii?Q?zQLBXjwBg4Dnnpq7n1iEhUq6ZaeSJC2jdKyIxJblzhNQyU9H1jpmDT1Vq/5o?=
 =?us-ascii?Q?baiQCuL+XXzWXsG6ftAoDfr1YLUoZrMXO7xk763EvVhZyigS57BuhJKFqA1j?=
 =?us-ascii?Q?Vor16lY9MaXps3NNQGTffaoNH0fatsnoD1svzmu6FZdRPWvuCemnmWNu6ZOI?=
 =?us-ascii?Q?FI223Lti0UH7QUrRWbhA56fgj03qirB6TtEZpZFnmpXuVHNO3n7ppt6ApiCt?=
 =?us-ascii?Q?qK2uJ3Nk58rAFqT7o3Dam3iItJMpqtMKm6gOCSKST+1/CwbQNItNw3H6BADq?=
 =?us-ascii?Q?IuA9wVt+RupZkU9eJJy05qf6C0GBImjqIQ8pwKdCrdvA28I8Sm4nJ2nb8y0R?=
 =?us-ascii?Q?M/P9tWMKf5GKf4c2xO+POdbm1VD63dfVY7gNQ8io0uzdhXzpK5ZWWApLNcIS?=
 =?us-ascii?Q?vhlj7aQpq/dAw5dZZke34sxy6RaZgsgu4FYT0DSU48ZpdnkP4DIbnPLjEw1H?=
 =?us-ascii?Q?GyfvrExjmeQD730pjyEnQQCAEPiZVarENH9JQb4lNp8GDAA1iV0QHHxKHvDU?=
 =?us-ascii?Q?yHGmfTWMbvdWjld5eA1mH4Z2N+j4L3UgmOFqv/w0FGbOs79J2pLRdqpK8l80?=
 =?us-ascii?Q?xlfc5KPCtL9KXWbU8hzPkySwm2ealNGfnqiAQCuhRHbicyqOxtQsecT8kjfm?=
 =?us-ascii?Q?iyeu5hR8TQukM76lTPWoBSFk/TSImZzCmOgwpYfZEV7J3iN/OiMQJkd6FU3c?=
 =?us-ascii?Q?CWQdNd6ZMB3sSR3mUoYXaZaD3aUiViTYje62?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(19092799006)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mwOc5PxhaSqEjf2BAKPLkUWIiogIvlMyVn5i52bBVYRFYBJaxxju4zFMrTHY?=
 =?us-ascii?Q?8YFIlwBwvVOmAm5tDmaoQSIEppI/PcyEElc2PEdlgdIeIEwvhPjtKeYGXXD1?=
 =?us-ascii?Q?HNngQJPHM0c+z6uUMeLEEhgBvrukaJ+S4+fUNPuNT6lCAhdwbvn7n8cH8cKc?=
 =?us-ascii?Q?72R2WQGRd7TKzR659eArz0j90aO0P6DOPMvqHW3dYOGzAK6gyJR01uhcEv5n?=
 =?us-ascii?Q?H9RHJxSk3hRp0wP5yA9DGHTikNv1FGS333WQOMi10ZBD0kxOa5prUgc2BS1o?=
 =?us-ascii?Q?tU7ZGVbgSG+lK1178j1nbSKm9N9pIVLKaPsSuNOD6OJ/5faEPSWUuAbHNHWD?=
 =?us-ascii?Q?SgIsH87nPY2Nd9jVNj1Ao2UCFfC+1yEwROT0oohs66MS83BemxHYb6sROYEl?=
 =?us-ascii?Q?D0oYs60/b9oOEYwBJJGCR5K7+6UrXTKQ85WNByI7z98lBiU3m5TksCEQ4evc?=
 =?us-ascii?Q?FH4TxrCwqOxr/6VDn4qUTB+ygUhJRTo/vEdRjShXwrUXjQBYS5dTSkT2IFy3?=
 =?us-ascii?Q?QYfXcuApYYos8P7xDetoziuzzaZEzjSTRyhXEPeea/owywaRBcVVqFlo8qPz?=
 =?us-ascii?Q?5CXZIDEogVqIynhnHaK7IkkIYPzy5cNH//hx9arZRxYskvheCBXMpD5xaFIF?=
 =?us-ascii?Q?Raw+QxLDtd39MKsGmecQQkQM3DZvZOB6bz1+mEeuQwozhjSabfl0RJ4tZx6a?=
 =?us-ascii?Q?XKS+9AbVZX4V+1tu1fY2C1DvDR9F0TQcHWXe7iug45bmL/Zlx6U6cNzqHhTP?=
 =?us-ascii?Q?F3JE9z1R850MYto0P6JCw1UlvokHSGYiiWOhXyZP92R/BKzEWoPOtvJ+38Ax?=
 =?us-ascii?Q?oTd3yHZG+7W1GkgWAgoxYmeNWaK4rDblRL6OY8o3qSnN1cDA1ko2dHIn0JF3?=
 =?us-ascii?Q?HaDrnZAr8+IsH09N6fs7tckIk0B+qEu9AdoXsmR5T5jXOXLWGASNpPfc63E2?=
 =?us-ascii?Q?Vt+v9ewHdQSzsBJ49+kKkP7sRHZZgTrQF8VrirnqebnuBqaemsyeBR1EU3p7?=
 =?us-ascii?Q?51Ek5LMd5gfQAtUCAmtrB3gS/3qWgdTDFlJ+iH6IL0P9Eva8dXAEhNlkQhwB?=
 =?us-ascii?Q?vbXxLMISSaMLz7sF9hyoICDpLjk6+rwHuHVd0x7Wdry1tbOTCFzqsIp8prnJ?=
 =?us-ascii?Q?oGj56fCQjQkopy2rs3Rp9NFDHX6TKA1AE+0ynQk/FR3e8mk/sziNa29s5Dwq?=
 =?us-ascii?Q?TSSgXakZ5y3cVHMHGUqENf7GGSKK35wgTnyWBDQD0n83rKOpNKe2dqm0wG8/?=
 =?us-ascii?Q?6mBk6awgO6huTIvJzu2tO4DZElCp8CjOkeM7BWz3qLc7YoxUCmGgeCePg3DJ?=
 =?us-ascii?Q?yQWD+H322GeeydZ/ORuWaoGtDEi/i/pGxOpadVTo0+rm7jvAJH+abQGhzo2C?=
 =?us-ascii?Q?xbFHSvBmZPM+xraU5qqAjBmnMVOsluVk5wnv5P56nXZJ3Z/08kJ6RvHbHlYX?=
 =?us-ascii?Q?kP2M9HRXgjL16zhlVdclmayQn3FitG9z36pegdriKapnY9wwONIIQDyrHZh7?=
 =?us-ascii?Q?BsbBOgoIyKimI/BLl4SZuOF8z51ocfkZmevyXmgyLKlpqD3XqYUQ18R2UEDg?=
 =?us-ascii?Q?lZLWc7ZkLJkOOLoILYEzYkgRhQPKZkTJBc03WD5c?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6fa4137-bff5-49e4-3711-08de38953eb2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 09:11:18.7751 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kkKHz0nu5jXqpzAgLuetcRqS7copkqPJ62E9nntUKLS7OktOROBBFMoVkjMZysNMrYHsZHsp1Aw5oPTAJI1brA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10903
X-Mailman-Approved-At: Thu, 11 Dec 2025 11:05:15 +0100
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

On Wed, Dec 03, 2025 at 04:21:37AM -0800, Tanmay Kathpalia wrote:
>Remove interface type restrictions in sdhci_cdns_execute_tuning() to
>enable software tuning for both SD and eMMC devices. The previous
>assumption that SD timing should be handled by SDHCI core is incorrect
>based on the actual function assignment logic.
>
>The execute_tuning function is assigned based on MMC_SUPPORTS_TUNING
>config, which is enabled by both MMC_UHS_SUPPORT and MMC_HS200_SUPPORT.
>
>Changes:
>Remove IS_MMC() check that restricted tuning to eMMC only
>Remove opcode validation limited to MMC_CMD_SEND_TUNING_BLOCK_HS200
>
>Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>Reviewed-by: Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
