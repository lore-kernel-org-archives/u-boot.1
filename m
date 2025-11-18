Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 596E4CEBF92
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 08:30:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4BFA83CDF;
	Tue, 18 Nov 2025 09:30:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZatjaJLk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7561A83C61; Tue, 18 Nov 2025 04:56:37 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F3268334F
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 04:56:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VoUttSiZrPsgc6zZrjcMokpJW4jOVoyyHUJdr/VJWoouLkYQN8PPSqEEbFjeVLtUcl4cI/cQ6gCEzBsDz/7YtzrbXAuoBJhCaYRYpivMvliZYVDda8IRNcagM5f4+hRPxpdZwTorhlkN2VooJ3E1HXt1qSYRmKwaozfixl3CB7y5p3ISZtV/CuCg6oOEnYwvAivBfVIDW9pJslgApxjRfeqDKD0FT4IwRKkL9uUzR2Wsr7vZJxd3umasMN+W3MJ0jNcTaUDhsuMVObPowQ3NTYWOXA695FmSPT7zqs/tptinzil5Z+oBe/OTiRYUeUup+YrPoOsiGrWGbmoxb1q0jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chfOEEXoKEAAB/r1kcwxc0OPDpHW9suGrYZAsCUaqXg=;
 b=r1x8+XxJ9OHpPNrGsCxo0L1vU78ApIb3tIGIwh6oSfAuz9X0JIFZZ7QpfNyou7B2i0EuS6gQ1sVZVcuW0bvfbDm3WOhkQ1PXmvA2Eu8OTMvUkrXx3IiPYpReshbwxUdrjRmfjnSmw6eE0/Bb+kBhDI5/ZAa8SAHFwVSARKO9uh6EPcXnchhTPHzHqccD0o7WN0zEW6k9q0zJgkCP1VodBlt8mwZILIsleT5m//vh9ocAcPOc7c2Vs2Jwm7a1tdB7j9L71iwyye5Wki3RIGxkXHe6eh8kyrWNZp9FHOzCpSL2s/PmDAUMPHpluGs/3+hW5QRifYFK5OmdlvBHhd0ncw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chfOEEXoKEAAB/r1kcwxc0OPDpHW9suGrYZAsCUaqXg=;
 b=ZatjaJLkdtrLNswR+KKaRzQtLUlfvvwz27R7kn/3e7P36ifzH1ZQVmqItB86EZeE6OyzVcEZrGiAAxegYsDv8We9aPgvhw9wHg5ZAi4XTXKw0lDYZ0CeQ6YlyJgqT7IczQ/hQn/blygA8+Hr6gxZMiF7QQ/mSdyyqxidipQiDzEYIR3TGeDyy7bkH5ITTqfwhHo813smwZeYGesFfrggBmtpx03OuICxFAhnRGllTyZpSXzTWqodf0sY3+U3mjyZe8te/WYRoxsGQ8ayQ7m060onxdZ/sU0gwJw2JU9vnmhc70jBql+wSUGZ7NgHmpi8ujqmxX3dOwkkeoflybx+ZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU0PR04MB9324.eurprd04.prod.outlook.com (2603:10a6:10:357::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 03:56:32 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9320.013; Tue, 18 Nov 2025
 03:56:32 +0000
Date: Tue, 18 Nov 2025 13:09:24 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, jh80.chung@samsung.com,
 trini@konsulko.com, marex@denx.de, tien.fong.chee@altera.com,
 balsundar.ponnusamy@altera.com
Subject: Re: [PATCH 1/8] mmc: sdhci-cadence: Add reset control support
Message-ID: <aRv_hIwxZshKJQI1@nxa18884-linux>
References: <20251110173737.24545-1-tanmay.kathpalia@altera.com>
 <20251110173737.24545-2-tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110173737.24545-2-tanmay.kathpalia@altera.com>
X-ClientProxiedBy: SI2PR01CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU0PR04MB9324:EE_
X-MS-Office365-Filtering-Correlation-Id: 14949796-264e-4924-4b5e-08de265675dc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0xD98lkANY9SB45IB97OVUTEuk6ifPsVWZ/eu8bO+of0A5PTOC/DWomAPyyI?=
 =?us-ascii?Q?k1P5Fc66N11+3Z4DVB64gnWLMOYtKqBdpMbQQp++k4aeXelR8KdQiGsub6zy?=
 =?us-ascii?Q?wSxE0ir025PEPgflPpu33pNmlm9HaaKlrfZBzwEa5XE13ufOZjGPQmHshzFm?=
 =?us-ascii?Q?71H9BxxeqZw9Ru1muqIPgCJdclnxQvevfSqHmUO34zLNzd2AFMbEEqMJemOQ?=
 =?us-ascii?Q?uqkIfY79QJAoF58nB4gkjLj/Y1r66lPg5Lc1Trz782rGTRq2TS+4LCEVaLTp?=
 =?us-ascii?Q?JRPPIZylPGeA12jYyR1xpZO+hpi4TPHMoV194u8xg2SlhT2KtHlPSEUSBeKs?=
 =?us-ascii?Q?zuVsx8TEBBSoHysgHwBjpibgcAaei3ntqDWOLdsbs0ZRdaMO9l+J+qmMAoBP?=
 =?us-ascii?Q?d2HaWw8uFVTqNp+Fj6CBIh+fEf2YFrv/J+n3qc+0aBQ9osi70aBXpTL7x850?=
 =?us-ascii?Q?FMNYKKxKqwLm1WsGojFQ0Soxfn/z0WpiyREcEYs5GWzjCitn+yc3RHqKz9ck?=
 =?us-ascii?Q?7i4nuMLNvLzVcl0Qsw3LOKINcTSa9oMBLChKX6xA4jK4lZKQBDsUUZMoit+C?=
 =?us-ascii?Q?kQyjknlgp4pI1NgR7D/ZPQPJWKqP4N3Ki/f6VhAWBY6kGglCGZXW/TALnJO3?=
 =?us-ascii?Q?W4mQ9RwVBvjb6z0MF0YZ3WpQcioFPALNhmWGDEC4KjDHZLYPAuyy23UVQsnQ?=
 =?us-ascii?Q?rJR/upRAhTfJPs+aiYNxFrkp7UeRES4DYpd8D+QMs20dd7/sHh8boyB1QUs2?=
 =?us-ascii?Q?x/Nnq6AuNb2gou2U2HFL5FPnJD5R9Tp+2WmBqilC8A9krbxS2ku2FOj1sGqv?=
 =?us-ascii?Q?3st0+n0wz8eyqEPKDe4AzD1aXn6xY2SNGvbZe4ioXmQ6hcPLqkAyj2FsculH?=
 =?us-ascii?Q?kdI67XDFuSl2Itt2cuwMvQex9GXILU+q4hZ2dwCpqnGj+jpVq4gbyIBIO2AG?=
 =?us-ascii?Q?YhoBmHwIiwFeyt6RRgmvfhcrA0/nNECahZcQZqsO33QsbLJh91GBbEvgkOHq?=
 =?us-ascii?Q?me5txI3O7mp+Li9VyIzlWDxYZMMlZHBhZ7+i+JFl1QANi1xMHCGXfo+IgLAN?=
 =?us-ascii?Q?o2bXH757RU7af+Ru0WajpPcSTEyZjYVfTm3S32RAiX3nScqK5lTpFs5l09PI?=
 =?us-ascii?Q?WMKx15NoGsC0JBvcP6iQjZxnGJSH1r6LtE1IJCpzJ0aVCuphP+Uvioei+zCa?=
 =?us-ascii?Q?ozCROMuo5BD6E/PGA4yjVf1iVyaKqXTm8ic5/fBPUXMVwSxbwutrNPPMPyBP?=
 =?us-ascii?Q?cySZjHVcQ2GtVegGCxtbc2rlHWBMf0wcVJcULbLrQicCYCbECg/2Qp2bDQqJ?=
 =?us-ascii?Q?ClCh+BSPq+wrBKEs3q6994twvcKr9/k6miBqAE0QghoHqRCuQkxddH/Q05DV?=
 =?us-ascii?Q?9CHOndiAfCBafmwdzOayaucKzx3BBjycFOIKOGQtae70/Nlv5D8fgnVZfMeD?=
 =?us-ascii?Q?qx5uFIBvIiDuurUm4/90LOvVa3Pr8pA5VBR5UcAt6KRnUXWtE8KsSeOoqLaU?=
 =?us-ascii?Q?3+XVUCwhYT3mMb5xfWMw2saGbHhWREqO1uwe?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(19092799006)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hpbe9BjSbL4JAxN22h3/Jm2yKLzYcVRi/Xs99z2GA1eVpfBdom34syVpFnZR?=
 =?us-ascii?Q?u4pRwb8Nqc7HCDrKKtM1hSIfRQS6Fis3qcf8T7BxPT2oD0OmjQVXUR+g6Xuf?=
 =?us-ascii?Q?f8Si5iabNiu9Xzl2mPpmupSWOQT9ICuE4OcfE1HJ5sTY2fAM9qVYHywLRrFh?=
 =?us-ascii?Q?4iiPpVcXJk11Axmkagiejs1x+GEWgcL0Tml5LvtlOZ9ILCYQQ1TB0He3DnXr?=
 =?us-ascii?Q?LNfET4MB72sQFlWny01irOMTWYrD1TmbHdxDWri1wEsewcxMXXmTUVEh0/6z?=
 =?us-ascii?Q?hZhEbslyZozZu3gGda22v0FrFskM+VMFFmyMMNDwptLxsSZeNZr8exrUINvW?=
 =?us-ascii?Q?lbA3qNep0ZwRkMphGd+i8xlaNKFw8V4LoEvicEzw5iruN1TIcI5XsQUfqueG?=
 =?us-ascii?Q?lPfyFahUpXLIhMJ7qSOlRSSM1FEXAormJJugW+Yh1tMvZ6rzp0y6H35lQRXj?=
 =?us-ascii?Q?dsCBgCnv7BS7wwa/oDCT1x08O2sw0Gikoc8Krb+wa0qU2sPvKXpbuPmj65uO?=
 =?us-ascii?Q?ak7Sih3UjlANbsYs2Kwt5noDcPXUvmqBQH9FZZkSt26WBJHkZADAnokCuw0X?=
 =?us-ascii?Q?wxJxShcSb2qybNqG9oqC+JF5cMC3fRYzTbdm5GSgslNKk9PQ7JqJLf4x5Msx?=
 =?us-ascii?Q?wWsPahPDUCjbV4P2x31WXrvkGjHlZMO7KS1EyvVfjXk9ToJW3aFcZGvxvN6b?=
 =?us-ascii?Q?EC6TrMXVUdXX+1Kk0uhPeRcgQ/PJxQRXD4Pt0dFSMn6OBp3xfaIrWugBw5Pa?=
 =?us-ascii?Q?LJct+Y8oFPk2RWPUBxk5NPLaBl0Z7nZFK7cMnl88LA9WD3wQ3ZUXSDaQLgFP?=
 =?us-ascii?Q?eBbuwZ3Gaafd24xS0OkLqEwx/C1i/JF2zIa+7V4yEQCg1mywiAb66cwGwfLz?=
 =?us-ascii?Q?niff8R9YDLpoGnhiNgv9NLdtEUkso40zwF3BZxSagD32kcP995OWh47pz9zP?=
 =?us-ascii?Q?h/cIWoMQ7jsb1zV73lEvrXHDBWugtIkRgGWpZCqo9QHw972jKF81FDL4Yjwk?=
 =?us-ascii?Q?VK64/1nefrym7C4nfcrcNvsVICVJbFYsckM5ntuwAkaqOoVxCQBoZdidgQRy?=
 =?us-ascii?Q?2ZawW3mrzSphWlYUNGHhlDvaAe2py3t3dsR4mWeppJGblTlWsPMP4H8nziGF?=
 =?us-ascii?Q?CeK//Rsnue7IDiyloxhFSEsCA0zv7LAApum/K2Fm2aRoRqJVJw0Gk99HwrKo?=
 =?us-ascii?Q?+0Sd6zSGnxIMQx5BJ8e41V4eGNADVVhhUxu8vtYGkKlnWR8Ehb+R++1jna0n?=
 =?us-ascii?Q?e3vJkN36L+oS1zDWUwShE6AeqcvincKmryGkyU2KjVD3Ej4G0crA5w7w4dOx?=
 =?us-ascii?Q?BvVoCjEYHr23g+l3dKKfVCQhvKO8us1j/lOJoW3NKJYrKRWnTomhd/dUeYOY?=
 =?us-ascii?Q?GTlTVopHiBw1ZObAz4eRGT5UGbMMBtvsuNKBRnTaS/vrCxuvArIFmuax0wcf?=
 =?us-ascii?Q?DErc80wltiwHx/stOEN7l1PX8IMQUbox4DRniaypXutLccl0ouZbgFpXHdpC?=
 =?us-ascii?Q?mUlmvz3RZNlU/X/YdXx1iISOKdOofuufi+zBzXazMOc3bnMMQXD82IuLDclc?=
 =?us-ascii?Q?Un+9W0wt2qPtLAePN5vvYn1YXxUxPUbLMf+QuVk3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14949796-264e-4924-4b5e-08de265675dc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 03:56:32.6236 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9vhb8ZjI1qEYiHeCeuM5OnN00lffMEd/3KSHUuwUR/rCz7llXdWedwJG9NQPB73IXsh5cMqT8q9LxPndVj9+Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9324
X-Mailman-Approved-At: Tue, 18 Nov 2025 09:30:32 +0100
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

On Mon, Nov 10, 2025 at 09:37:30AM -0800, Tanmay Kathpalia wrote:
>Add reset control functionality to the SDHCI Cadence driver to properly
>handle hardware reset sequences during probe. This ensures the controller
>is in a known state before initialization.
>
>Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>Reviewed-by: Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>
>---
> drivers/mmc/sdhci-cadence.c | 8 ++++++++
> 1 file changed, 8 insertions(+)
>
....
> 
>@@ -225,6 +227,12 @@ static int sdhci_cdns_probe(struct udevice *dev)
> 	if (!plat->hrs_addr)
> 		return -ENOMEM;
> 
>+	ret = reset_get_bulk(dev, &reset_bulk);

Should this be optional? Some in tree platforms may not have
the reset supported.

Regards
Peng
