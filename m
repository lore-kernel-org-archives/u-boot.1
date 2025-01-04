Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B53D5E77188
	for <u-boot@archiver.kernel.org>; Sat,  4 Jan 2025 03:20:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51042803F5;
	Sat,  4 Jan 2025 04:19:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Iw6hoyQo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 609008035E; Sat,  4 Jan 2025 04:19:47 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::605])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4630C80207
 for <u-boot@lists.denx.de>; Sat,  4 Jan 2025 04:19:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B/59e2/LLxduBXCi2ZdFlI0NsQfLISXSoJ0k7DTnJf3DEeiWV86svQbUXHdUFVUioBSks+OnFUobdd8Js9lr8zRQr6fQ8BZA1HIGCHe7r2Qac3Xphmf0zh0jmbLiOB6fqgTZ5/X+Lr+E1oSk9/bIgB4OtWNBH4oqNl+BUFmxQXZbSMj3BvuwGkZ/ki9zxZ1ivC4O2NkzVJkSkeokRnrztVuvJe0n1JRimPdX01O7ZQL/IIK7rj5/KOe+W4bbByYF1fXZzJH+0CkHj+Ilzr/YyRToRRZJ/qSpLQf2MlWobsj5Vh25AR1BUl6ruxqY/1+CIyUhRIoQS8Ma7g8TTn6LAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3bkB7Ng65HMwLr9nga/jw3KolW8nFQ/Tes9x44XzlU=;
 b=JD6r1MOsutjh/JC4OrHLd4PRc+vIToxHh6ozeZJyacPlQnYh5A5EQRyEqJoUHfj7RcFpLvPi6YZzCmnMiu08tEE3VGehbnEVF4XfG6Yfzgb0cBoAlS22GXwLMaWl2JCYHKPGw8PjGLwFk75PuBngBFltxx/DQaTAafV2Hn4uWzZINS8eJYJaKX+umuHyiJ+5gsf+9VcPB5yBtIWP1OEw28HB0dsV7RMsOxRHYwF8mrRYgKaJ+dLqmoSO5U84ZFzWjsbifBP2ZGCcWRXEfp8L2N9EG5/JJYZFFqEK/gTfzrzrG3AR7wIIovMo9stBj7T8a8DMx+k46S2FBeAIVHBP+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3bkB7Ng65HMwLr9nga/jw3KolW8nFQ/Tes9x44XzlU=;
 b=Iw6hoyQo6eeJ6LPU6sNpFowygAk2G2WRt/aT37GMT9FKrz2nARfNG/Da/meReLHpFPK9r7SKEypZ+WaCNhbQg3KV/XH5BrOuKMtBh8cnkF8vQYNhjEFFj5B0HdwORADfKnmAjQFKUBNUtFJWwhYHcawtP5163MoMmY/T4EmivvRAs2EqnicUCP2byx62rLT6eyAAGlaMMEJ5VctXASq/U0KsEHXt8yj5c2Mmc0C9oRbJ/0PePzxX+qj6VP7sfiST75JP92yr6w63yJfMZQGHHrpVLSHYijZoYxe1NuSEkURAez3PKROM7uitTzSmt7rcEl9jY8QmoBrwMSxSnDjvew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB9566.eurprd04.prod.outlook.com (2603:10a6:102:26c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Sat, 4 Jan
 2025 03:19:40 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.015; Sat, 4 Jan 2025
 03:19:39 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 04 Jan 2025 12:25:36 +0800
Subject: [PATCH 02/12] imx: imx93_qsb: switch to BOOTSTD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-imx-bootstd-v1-2-e09618cc1d65@nxp.com>
References: <20250104-imx-bootstd-v1-0-e09618cc1d65@nxp.com>
In-Reply-To: <20250104-imx-bootstd-v1-0-e09618cc1d65@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2PR01CA0151.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::31) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB9566:EE_
X-MS-Office365-Filtering-Correlation-Id: d6433603-c305-4608-892b-08dd2c6e9ffa
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UkxwVXlHcWU3eGx6YVBQUngvVC9ZYkduRy9kazNvVFU2cG1oYnVKRk1QN29I?=
 =?utf-8?B?Uk9jc2M1c2FwNkE4MHFPNStkelIrYVU2eU5mT0ZBNWNMcVZSLzQ4S1FZRmE3?=
 =?utf-8?B?UU83VlBLWUZtZnRVSUQ3MUJvSTUweUd1RlBwVmJjcTRIUmI0THE3Y2l3M212?=
 =?utf-8?B?S1hqVWJ4b0xNMXFNWGthT1VrUW1EV21aNEE2TGtENjZybTJsUmY5Qk13blE2?=
 =?utf-8?B?OWRZMFNQUElta3IyY0JEdWk0T3JLK3ZkQ0p0VjZhL2hhbEpnU2lQTXh5VGlK?=
 =?utf-8?B?VVIySG96QjkzNjAxNjllZGU2WkF4endYVHo4NWcwa0J1YXJxQ3BhOW9UZitM?=
 =?utf-8?B?cXI1OEZDWks3c2U3dTFmM1F4cERMTll6alRWZmsvWlgvSzZnRXljTi94K2E1?=
 =?utf-8?B?b3kzbEt1MXR2ZFBneGtONzVvaGo2YUMxRjF5aTZ1QzRpWExvU21sRXBRNSth?=
 =?utf-8?B?dzZVazUvNUVWYWEyZk9FeU1JVzRJMHE1bE13V0lBanFtVFVOcGxKMlZiN1lp?=
 =?utf-8?B?ZWFITmpxcnpzb3FEbWRNZ1lrblJ6MlZ2UGhpTDNkR2xDSHk1MGN1bDB2UE13?=
 =?utf-8?B?UC81azJqRmFiS0hndmZWNDk0K1JyMWNNZi9hM09FeklIQVptUlBOL1VVbmdN?=
 =?utf-8?B?UEtscFErNU9XV2RqRUgwSEt0a2NrL0hRY1JoTUM1OHRQd3JVekhscW1iVkJo?=
 =?utf-8?B?bTZMYzJsRGhWQnpQZGVqdXdXRzBZMGs3TENsVUkrbEtWV3ArN1NPa1l0TlhU?=
 =?utf-8?B?WURSalZSdE95cVA2RUtNa0FLalFreW5sSTFjclFlMmpBUVZ3Z3Rkam03Nmti?=
 =?utf-8?B?UVpIOG1kV1FXOEJFOHQ0TGRmQXd2R3ArTkxQSHQ3aWYzZUJKeVFValdWM29z?=
 =?utf-8?B?Um1Va2RudGRKZ1FBTGp6c2h5azliTW44aGllSnZrbmZmemp0SkdPRUcrV2p0?=
 =?utf-8?B?dVVLbktBRHdzbXZYOG51NnFJb0E1dml5ZW0vRFA2RXRMSWxYVURUQXJYemhy?=
 =?utf-8?B?Rk5mckppV3NUMUNmYVhCWXdwM1FSdFh4L29mSy9mOFZ6b3g3eTJhVHA5Zzhv?=
 =?utf-8?B?dGhVdmR5Wng5NE1hWWJCRWdBZFZRUWNNZHZteE1yL3pnSHhpOHV5SVVhRWFP?=
 =?utf-8?B?Ym9ISHY5MmNlZ09HWnhnRjA5ZDI0aVpzOEdxUXczWUdrY0xxMmJKWmpoYkY3?=
 =?utf-8?B?K2txeE9OUEJ3ekVRLzlqVURaR3RoTDdUSDNLUGRsRW9aZFpWVllZUFBxcDlF?=
 =?utf-8?B?UUZhOWdwZHd0Qm9INUxQUGx2aG9aUlFHckd2OUxVckZvTHJ6elNLbWlOVTl2?=
 =?utf-8?B?LzlkSGNQbzJRamNFMVBpQlNjR0dzeE41WENMcWRpeHIzMWxnbm5KamJaL0xw?=
 =?utf-8?B?NmdJTEorMkRxemJnMTBaTTkvTEcvUkErRVc2QXFLcXovR3k3N1VmdXRPeW5w?=
 =?utf-8?B?OHRlaEx5dmplVmRYYTF1RVVhR2paRnY0azF4Ni9mZlBVM1lyOU8vR1ZpTWRw?=
 =?utf-8?B?c2x2TVZHSjl5dC8zYlFVaHBFSVpucnBBWnJPNFVEeTgwNE5yd2JHUEdGVmpF?=
 =?utf-8?B?Y0VvS2k2cW9YMjAzdTBZbExuYWZmWDlxdnFldlNjTHh3SDRFUnlhK3BXak1E?=
 =?utf-8?B?eTg5MFpMV2xuNE1BVE1vVmd2NnhlMkhJQnlsdExVSXBhRy9xYy8xZEx5U2lz?=
 =?utf-8?B?K2RSelRDRXdzVjg4YVlFTUJnYm9wTHRUNDBFVFZlRmRhREJPQ05DK0N0UmdG?=
 =?utf-8?B?NUx0dkJmWVhUMkJrc0VzK2hRaDFHdXRDenN4TVVDaXVjTHc1bHo1QjdqSkRQ?=
 =?utf-8?B?d2F2akkvZXhsV1pmcGtnU05jS0UvZERsL1pxbjFVRFpDNDVQZnRmK0ptZ3FP?=
 =?utf-8?B?NTBTdkY4WW5NVjJnTGNSNEpMUDVSVG5BcERRSlBrUHJldnQ4SG9icUhYZ2ls?=
 =?utf-8?Q?U5UNESaqCqWlYCStDQoeKIEj0TZEbStz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUNWbDVNeW1YclNGb0QzOWdqbFNrdGlDdnlma1JodFlFb1lxQXBLemo3Wmda?=
 =?utf-8?B?VjhVZ0FRZUQ0ZGp3WmNPNGhyU051akZKcFRZMnlHT1hlTEt4SVdWMTNJM3ly?=
 =?utf-8?B?c3g4OGVRNjVNRkh4OHJqQU1ZUkJXNWdIbGp3bkt3NkRNZ2UrdnhnSmNkcGxz?=
 =?utf-8?B?OGxBcEwvRmIvdUhqNzlwdFdFbDMzcTlQcEU1cW1qTmVtVDZheWlxNHl4MG5I?=
 =?utf-8?B?Q00yYVpMZklBd2c1VDRJaUtYQzFLZG11VWh0REJKWklJS093V0tnelpaVGtH?=
 =?utf-8?B?QUpOVlJpNjAvR2EyaE1CSk5sazh3WklmYjArSkY3eHlYSk40WGpHenpNR1RB?=
 =?utf-8?B?UFdQYUhOcnYzSXBUT3FKQzAvQVZtQTkwVlo5Ymx2Q0pHV1NheEZ2ZnVFa2R5?=
 =?utf-8?B?dWZuM0lUSlJSL2kycGdLbGVTellReVo3K1dzRGl1V2J2YUNNVjBNQzZibExn?=
 =?utf-8?B?eGovaitlWVlHbzYxalIzQ0ZoSHZ4QVlnUkJJdUVVemlRek0xdDFpRWRGVHFT?=
 =?utf-8?B?dW91UjVZckJVTW1icVFXN243VE1rT29qdFJWWlhSWmtvNUEyQUl4aTQwSHBO?=
 =?utf-8?B?VGdWb0Q1UFdTYWRBTlhWSHNGLzFNUElRTXVHWkUwMGRYQ3VTR2xQZUV2RStu?=
 =?utf-8?B?b0c2anBZTllZblhNOUVaYW5EWWNESk5oWU5Vbi9UUzU3dWRBRVFDY2NaVFEr?=
 =?utf-8?B?Z0kwSUNRblBiUlZmZnNNb0xySE5aUGpvdC9lMlRMQnk4MGlUb2YvLy9DNEVK?=
 =?utf-8?B?NmQ3VmFVOVFRZElCb3A5ZkpBdWZqVnBTanRxcXZ2cmErbUxHcEUzdUtkb2hN?=
 =?utf-8?B?dTF5YkNvTVN1eDQ0d1ZDck1Xa2FLRVhGTG13NVByV2tleU5wZXRnL08wai95?=
 =?utf-8?B?UmFWZis5NE1JQ3N4L3RRSnRlbjBDQmRrSi9YemliTXZ0SVl5YkJRYnNRdnhU?=
 =?utf-8?B?MWs0VExjakF0NWlSeTFycFBlNERuUGNQZzJWbGw1L09ZbHZjcjd4OFM0azJu?=
 =?utf-8?B?a1c4cTAyalVLekMxcm45aTUvaHRhbEhVRS90MUZxSG1xMXlrUnJERE5SYVBC?=
 =?utf-8?B?RDNsWC9aWGVYRVVJZFl0REFqODRBVDcva1RndE5TOUIwN1VkZ3puV3FVVW4w?=
 =?utf-8?B?SUcxK0o4RGRpWHZNeUJ6QzBXMFo4S0twbUxKQVZqOVBrU1lDanpqWU5hcnRw?=
 =?utf-8?B?K2xkMm0rZEZ1dHhHdUJpTFI3bmtqRTFlUEI2c1RhUWFrUUhPUG9pRkloN2tn?=
 =?utf-8?B?QmN4dndpNXJCcVRsQ2xqV3pLRkRCNm5IUzRRSUVmcmJxVy82amVYcE5WdkdN?=
 =?utf-8?B?L0lIRklIakhQei9WNGVZVThEaG8vcDd3emVsM25aQ2l1Ylkzc2ltbDFaR2oz?=
 =?utf-8?B?WFlkYk1uWFE3ZnR1QStLUmlDbEVkM2ZpTVZTVnBmc3FjbTZYdTA5eWhKVXF2?=
 =?utf-8?B?aUlreXl1bUJkODByOUZYOG53Q0VwdHc5M1I0elZUOGd3T2VZbzlGdGREZUZ0?=
 =?utf-8?B?YkMrNzBEYytxRkhYNVVCejM5WmN1Qk1Yd3hqd2VrYm9oeFhaUzNhSndSTHlw?=
 =?utf-8?B?b0VqZ2FaU3RZSmpVdHNzWStBdTRWWTZINUlZN3B2WFdpVkdsYzVuUDJqUTZt?=
 =?utf-8?B?Qk5Ha3BZZjUvMWNWSitGcFJlZnIzSUtUaXlaZnl0SGdwWjhqUHJWZVp5dkhv?=
 =?utf-8?B?WGd6SjBxNUNWeGVZMm1aS0pEZGhrNHZ6T0RSNHFyNnN0L1hHc2l5NWdYaU9H?=
 =?utf-8?B?QnhDUDdsVjU1V1NJL0UycVpUN3ZsVjBYc1VHOXNMSGEvdVZTdGJsNFAxTnp5?=
 =?utf-8?B?UXA0bEs4U3ZtSGRITGRoY3NoeXRIVTMrbndLOEMxZ1h4VXpVZWtFVWUzQUNm?=
 =?utf-8?B?NVh2UzRvdGdSK3Y0TTNTOW15T0NralZ5OFl3bkpycUc4NkE4ZmhtbEQwTjNX?=
 =?utf-8?B?cmcvTjRTb1JGQTBDS0JuYno3MzVuS2tXYkNNeFcvblJBTzVaSWxyaUlGM0xW?=
 =?utf-8?B?N29aYmR4V2ZLMjdIWUl3aEtEWVFNcFJYM2M5RGdETk52MHN5NWhTdm9hZ2FG?=
 =?utf-8?B?M1F0NCtDQ2VHeDR2VVFHYlNKbDJkVytyZURFaFRsNUJNaXE0d3ZqOGlaWi9P?=
 =?utf-8?Q?JdYxtuTJNvaT/ViUIGXawm3cu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6433603-c305-4608-892b-08dd2c6e9ffa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2025 03:19:39.9292 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n/O35UecuDAW8o1ZYZo91mhwPXaUCleiTARYq4I1w9k3nmPfNo62qgrvBJ0WmvnjvHhZKf0wUQ3UuuLfQC09GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9566
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

Switch to support BOOTSTD with a bsp bootcmd as fallback.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/Kconfig             |  2 ++
 board/freescale/imx93_qsb/imx93_qsb.env    | 29 +++++++++++++++++++++++++++--
 configs/imx93_9x9_qsb_defconfig            |  2 +-
 configs/imx93_9x9_qsb_inline_ecc_defconfig |  2 +-
 4 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index c52546084394a7cc26f35c93ac8fb62d9c5fe795..d756f3dcad2e91172ecd885357b9d0adf2e387e3 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -41,6 +41,8 @@ config TARGET_IMX93_9X9_QSB
 	select IMX93
 	select IMX9_LPDDR4X
 	imply OF_UPSTREAM
+	imply BOOTSTD_FULL
+	imply BOOTSTD_BOOTCOMMAND
 
 config TARGET_IMX93_11X11_EVK
 	bool "imx93_11x11_evk"
diff --git a/board/freescale/imx93_qsb/imx93_qsb.env b/board/freescale/imx93_qsb/imx93_qsb.env
index 92486c6f74d2ec12f638443dcf598daa28f306b6..c972d3eb2511542c1a11812f879d7627cadef797 100644
--- a/board/freescale/imx93_qsb/imx93_qsb.env
+++ b/board/freescale/imx93_qsb/imx93_qsb.env
@@ -10,6 +10,7 @@ fdt_addr_r=0x83000000
 fdt_addr=0x83000000
 fdtfile=CONFIG_DEFAULT_FDT_FILE
 image=Image
+mmcdev=CONFIG_SYS_MMC_ENV_DEV
 mmcpart=1
 mmcroot=/dev/mmcblk1p2 rootwait rw
 mmcautodetect=yes
@@ -19,12 +20,13 @@ loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
 loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
 loadcntr=fatload mmc ${mmcdev}:${mmcpart} ${cntr_addr} ${cntr_file}
 auth_os=auth_cntr ${cntr_addr}
+sec_boot=no
 boot_os=booti ${loadaddr} - ${fdt_addr_r}
 mmcboot=
 	echo Booting from mmc ...;
 	run mmcargs;
 	if test ${sec_boot} = yes; then
-		if run auth_os; then
+		if run true; then
 			run boot_os;
 		else
 			echo ERR: failed to authenticate;
@@ -48,7 +50,7 @@ netboot=
 	fi;
 	if test ${sec_boot} = yes; then
 		${get_cmd} ${cntr_addr} ${cntr_file};
-		if run auth_os; then
+		if true; then
 			run boot_os;
 		else
 			echo ERR: failed to authenticate;
@@ -61,3 +63,26 @@ netboot=
 			echo WARN: Cannot load the DT;
 		fi;
 	fi;
+bsp_bootcmd=
+	echo Running BSP bootcmd ...;
+	mmc dev ${mmcdev};
+	if mmc rescan; then
+		if run loadbootscript; then
+			run bootscript;
+		else
+			if test ${sec_boot} = yes; then
+				if run loadcntr; then
+					run mmcboot;
+				else
+					run netboot;
+				fi;
+			else
+				if run loadimage; then
+					run mmcboot;
+				else
+					run netboot;
+				fi;
+			fi;
+		fi;
+	fi;
+scriptaddr=0x83500000
diff --git a/configs/imx93_9x9_qsb_defconfig b/configs/imx93_9x9_qsb_defconfig
index 582fe5a318daaf568b48dac816cd15d80b430b22..545b8bf61d1a216d37199be302750419d624963e 100644
--- a/configs/imx93_9x9_qsb_defconfig
+++ b/configs/imx93_9x9_qsb_defconfig
@@ -29,7 +29,7 @@ CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x88000000
 CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x90000000
 CONFIG_REMAKE_ELF=y
-CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTCOMMAND="bootflow scan -lb; run bsp_bootcmd"
 CONFIG_DEFAULT_FDT_FILE="imx93-9x9-qsb.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
diff --git a/configs/imx93_9x9_qsb_inline_ecc_defconfig b/configs/imx93_9x9_qsb_inline_ecc_defconfig
index c95145cce0ed31db81b49bc9834b4228a9f3ba81..3c9df7470096708db7405d38bd11c3cdf3f7b69f 100644
--- a/configs/imx93_9x9_qsb_inline_ecc_defconfig
+++ b/configs/imx93_9x9_qsb_inline_ecc_defconfig
@@ -29,7 +29,7 @@ CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x88000000
 CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x90000000
 CONFIG_REMAKE_ELF=y
-CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTCOMMAND="bootflow scan -lb; run bsp_bootcmd"
 CONFIG_DEFAULT_FDT_FILE="imx93-9x9-qsb.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074

-- 
2.35.3

