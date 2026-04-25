Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1721FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:20:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E07B842A2;
	Sat, 25 Apr 2026 18:20:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="LHpiPE0M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B72078428C; Sat, 25 Apr 2026 18:20:49 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32AA584308
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:20:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
Received: from PA1PR04MB10578.eurprd04.prod.outlook.com
 (2603:10a6:102:491::10) by GV1PR04MB10079.eurprd04.prod.outlook.com
 (2603:10a6:150:1ab::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.24; Sat, 25 Apr
 2026 15:41:35 +0000
Received: from AM9PR04MB7554.eurprd04.prod.outlook.com (2603:10a6:20b:2da::23)
 by PA1PR04MB10578.eurprd04.prod.outlook.com (2603:10a6:102:491::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.23; Sat, 25 Apr
 2026 10:18:12 +0000
Received: from AM8PR04MB7876.eurprd04.prod.outlook.com (2603:10a6:20b:240::22)
 by AM9PR04MB7554.eurprd04.prod.outlook.com (2603:10a6:20b:2da::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.23; Sat, 25 Apr
 2026 09:00:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YYS6PuUREmZI0p1e3jkXa9DCK9pTGS2gAhrv5jpBji36BVdUE7GnGVZHOob9FVpFSdQQJ1AVLj2qgxrsm62PQFjkUGMnqj5NTnQmAYmdpf+91nueQqAc8Xrt2r8P1OIInUAsXXJ9T2sp6u8fwwkzE5SiTy6HDrx3DBsSDMZFkXdVQRMhfJX2nM9bL6zy40ek7pdXbRW5B2LI5cpULdIsKZ8HuOppLdXmoG8kPJMo+B54nnWsU0kjODfcBwLfbZxobluR2dq17et3XAPR70him7zR0BJ9qZzCEQvO95Zq/pheNGl7Ozutt6fAWtyAx2h/n+cRTFdTOQZDFDGgUlYaYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umCpYjONxywwp2BbMved/TTS4QKxSCeqNin8QZ/Elkc=;
 b=xJEeFz0W71WIFN/fcVXAP4B+gEeeoJdJZ6sfEVjgkwk+xnh/4e74cqQ3Ezpvn0waJD14sa+rVDSB4FR4XRzBlmcJHnxNjQhgRw9+LqTSv0iRGeWoDIgE7chNLHXUKKZ2UJDaaCvr2bjp/4E3v2NqIR/kqS9gYIp7clhYUqj6Zty38b+zYSLBP3T507XhqhqdEgKQOxgl/BUHdM//GnwasLlaOEmrDPlmiEHAdZdTmC5MzUm2w8vo6Rezw1Csrnf2/hPuDqCEj0j/jFAoUrY4fB5b3lIFE5oqjhs00Qun957jXdC5gEsjI8Nmr2+ftYBaPAJEZskHe/J1qrnN4J02jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umCpYjONxywwp2BbMved/TTS4QKxSCeqNin8QZ/Elkc=;
 b=LHpiPE0M1H0BBzENwB2XGiUTJITHn/TewFHMKUwy5NNOfyegcCOBUDb76Av2sKlA2InRGTtvXIjQVSnsqXKBrXes5bzuPBlFVU+GNbqBUodDMPv8JgSKfEayK99/49MoTNEvweSwRIMvz+XCGpRBJ+cmgtNbWN6PTU00coDy6uI+ku8wgFIeVk7qSq2GUgl5iLC9yJYK5spD39tZOPaEjKbvhwvOejQ8r38TphhpdhnB/qM7k2YN6RpyKzNjAN08epnGvKMZojc4tyM/o9nqlvlmqXz/qMenySj+rzUWAgbKtdHlSUrtI93ym5ix1F4UaoruUra3MYWQ77oeC3gwsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM8PR04MB7876.eurprd04.prod.outlook.com (2603:10a6:20b:240::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.23; Fri, 24 Apr
 2026 23:20:27 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 23:20:27 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 25 Apr 2026 08:36:53 +0800
Subject: [PATCH 01/13] imx8mq: reform2: Switch to OF_UPSTREAM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260425-imx8m-of-upstream-v1-1-07527be92e5d@nxp.com>
References: <20260425-imx8m-of-upstream-v1-0-07527be92e5d@nxp.com>
In-Reply-To: <20260425-imx8m-of-upstream-v1-0-07527be92e5d@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 kernel@puri.sm, u-boot@dh-electronics.com
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, "Lukas F. Hartmann" <lukas@mntre.com>, 
 Patrick Wildt <patrick@blueri.se>, Ye Li <ye.li@nxp.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Benjamin Hahn <B.Hahn@phytec.de>, Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marco Franchi <marcofrk@gmail.com>, Alifer Moraes <alifer.wsdm@gmail.com>, 
 Angus Ainslie <angus@akkea.ca>, Heiko Thiery <heiko.thiery@gmail.com>, 
 Olaf Mandel <o.mandel@menlosystems.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Matteo Lisi <matteo.lisi@engicam.com>, 
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::6) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM8PR04MB7876:EE_|AM9PR04MB7554:EE_|PA1PR04MB10578:EE_|GV1PR04MB10079:EE_
X-MS-Office365-Filtering-Correlation-Id: b7a386b4-0d6f-4310-9489-08dea2581192
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|19092799006|366016|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: 57f471wGrFbd4bvGE9IrQO+aB0kJZgGe9trxpiP4fxO9jZ4UMmRWtt+o8j0ypoFOceNDzjYM4jtKpt7qY/wbSS4ZCPRcqqtVYEWoetK0Vi1bc0Jea/5kznZlUNuhqSFmbDjlw/mv2Akt7ZdE1GULa7GExaSAP1zXsCFgdXW7pB0bvDeG80t8XRLpyKm/xraR7tzdYnkr2sL0zw5zYL0JoC8KeVbejNYkR3eQNf+veHcyo9uurxUYrVKHBuFkd47CryZbkzT/Gz6w3RGGKyOMIgPUqCcyePn4uq9EiAc5eccsDOEAJXOJVnLO/NhTn1n3AV+HPeaUbEyXf4+LTbLrsFzWpV0yT5BUXss1Hvt5oNfgQTq2WdnhEsK4BlmDZvAT0HJc/xxFyhWqBaxuW8yM/d98rMWibgY0KgAyLet5CIF+ThJbgKt9LvhfkBvicPPLHmA73pJNUFD9WfFfmj+OlmDJrLewr6Y0wnn+7FCskptmZefLH93PkYTNeD6OTqGoMkEoivnk6XE2OvT/+IcVOM+4i+jkr5jBQ72A6cP51nEoc1hrBBtHOIqsfXkHzVS5G7oK/8s5jOhcyNR3zwMGDL5BHs4VtX4TXx5M1otXe8mbSe2EZ8zPoR68mAGrcCff0jmfTjjPu6sGEP90EUgdt+RWsTBy0nj18N198a9Il0K14/O5D6YXoXjRXANRVPoIDmaxgSszxkITapG/70EbmcELTgQdMgG5ZZ4pw0xu2HjqPn4eMB5Bh3ca1pjmCRjpZF3nC4EtHB6/GIUmmXngN8NxyN3HVr/TrRYBaX3D1TI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(19092799006)(366016)(56012099003)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWVZNDkvWURMRy9pK0VlcTNrRk9lYXpPSXZnSjhLR1pkeURrZUVnZHo5NlpM?=
 =?utf-8?B?cCtRclpUWnQweWUvREF3c2ZSTk5leWpIT0VJNU54T0lndjVyZ1liRi9wYVJk?=
 =?utf-8?B?N2lKYjZIZVgrRU05SlA5VjBQekI2dmdRNElYY3J5dWF3L0RvZTZ1NVlGRXNQ?=
 =?utf-8?B?Z1dHNHJWcTY2MEdWWlo1TzBpcW1lQUdFZC9WdVhpWFFEd3RXU2d2WHRaT0Vl?=
 =?utf-8?B?eTFnZmUzbFdlNVRNbWY5QXF3Ymd0a2g0M1k4dURQdXIyUURZazFsNElxTklC?=
 =?utf-8?B?cE83SGFJNEMrODFsd2tHYXZLWi9QWGpDTjBwTTVyTUthUEtyeVRORVkvcFdq?=
 =?utf-8?B?VWdQeHJrWlhzQWRHV0I1elN3WGdBN1A2T2FqNVVDZ3U3aWFkMGVaakw2RUlx?=
 =?utf-8?B?dUJkSE5zRnUvZUVGVFlWZWZXdklqY0hidDhaTjNOT1FTaDNMZjliMnp0Sllq?=
 =?utf-8?B?TWNoYXFMT2ZTZUd1dXlaVnJPOGkweEhGQ0tIMDkyekF1T3hqdFVzN2sybDJE?=
 =?utf-8?B?NWtPaFRYV3Z6Q2NnZThJSUJJNFlJNnJzcEhFQXAzWGlLTE00Z21UcXNjMGRU?=
 =?utf-8?B?NklWdERVeWZXN2xPZzJsYnVsaCtkYWJkL1FUdmNFamR2TFc2NjVEUllDYmI2?=
 =?utf-8?B?WnMrRlAyWTNvUkdNc041OXNDTllLTi9kdUxjYTZVVFA0ZTZJcXE0ZXlORTF4?=
 =?utf-8?B?bDJ5eDhKNnMzZEZzZFJIRndzWitDSUNQc2hRZ2VsckNqTmdBRHp0Y2VnaGpG?=
 =?utf-8?B?TGFHL1dTQmJwSGt2eE5EeERQQldhVlJ2c0d5eWQxd2V2ZStrdWxhSUNhQkkr?=
 =?utf-8?B?QVR6aldZUWxNdWtkWi9KNitHdElTVmlGd3ZpSGNZMnJaTkt0Z0ozck9jRDNp?=
 =?utf-8?B?UHBTU3RGUS83NWM3Mk90N243YjkzcVBoMHV0LzhWa1BGc1ptMnM2TWhYekdy?=
 =?utf-8?B?MG5yT0RRa2t2U2J4SHJtNVRWV3Yzck9rVEFKdWtBY3IzQ0VHZ2JsWkNFbFVM?=
 =?utf-8?B?elVhekFtZDkxRjV1RG9nYUxZZ01RVFhmbkhLSkNCV3pvdkdNM256ZDlKRUVM?=
 =?utf-8?B?RS9FdUxNMkVJSFZmNUNhcU9WdFJhUy9qWS9wamxlVDV6bmRrc2F5eXJ0V1Jx?=
 =?utf-8?B?YTVjZmVWTFZ4RElrMkJuN0R5bXNEYzN2T3BQbkVGbm1QVjdXcmNrSmVaNEJy?=
 =?utf-8?B?NTVCSlZlRVBibFk3MmorTTlBdS90Z1FXckpsSVErOWlQS0lxZHBTYnJ2YmFq?=
 =?utf-8?B?WkNWWVBTdHRNSEdBek1IOGxIWG1QWUd6bUtWUC8ranFYVlB6Q3NleGJEbFlE?=
 =?utf-8?B?WG54VFlYMStMVlNna054YlhtQnZYRWJGY0d1bUV6K0VodTVDQXlvdUsrQUdO?=
 =?utf-8?B?WEFRTExzdHcrQUsyUDQwVENtT2J1MVpPRExpcFM1TGk0a0RzejVnaVlFSW5V?=
 =?utf-8?B?ckt3MzdTclVBbjkrelJuVXZHeVI2VHowaDhtVExPd1JXblZtb0FLek9pUlFj?=
 =?utf-8?B?T1NDb0ovbVg0T01tdWhRQkhxN1hJM2h1ek95UHNyRXpYMURidisxTHJucUxK?=
 =?utf-8?B?K05hSEtEWnQwVmlic05wTmZJM3JmclBISVVvbTV1RVVlTkw3VmR2S1hpWGNJ?=
 =?utf-8?B?RldIbEtmM2NEZGRJK0VyU2l6Mm92VHBqeTNpZVA4TGk4dUErSkhCeml0VTQ3?=
 =?utf-8?B?V1Y0TzExODNNNFlwWVduSDR0Ukp3Mi9TRGw5NlhvZnMzeTZiUjhpODRNbXhF?=
 =?utf-8?B?L2NGUi9Rckc3a25OalZBcHorb0lQd2x3UVU5ditLWnkrYVVTVENXLzNXL25G?=
 =?utf-8?B?VEhyTmhJOVoyMjl4SzAvQ3BMRmJqY1UyOHYwZWlYcGVGZEY4MG92YjFFNkc4?=
 =?utf-8?B?ZnQ5T2F2c1FVVVpyc3BwL3FOWGZJSmNqTGJkdG81WldKcU5PY0h1a3JqaU9L?=
 =?utf-8?B?Z1Q5Vkdaa2NKcmpvU1Y5UkJua0IvSFcrdGZZMTRCOUVBY0VQSDBXSlFJdkRY?=
 =?utf-8?B?bkJmZ0xUZ3BJQWlIUHd6TE1aVnpIUWg3YWsyOXlyQUxhd1VnU1dxRGV3MVFR?=
 =?utf-8?B?UTJuSFl1Qnc5TWdDMk5QZ0dGaFg0SHRUb1ROQUdmVnpGMzdKTU8renpQTmJm?=
 =?utf-8?B?MnMzVDhOSWgyWWlFRmFIS0J1M3VPNGxBNmd1cDZzbmUzZmoxbDhIOTZTcUNC?=
 =?utf-8?B?NkhxTjNPQk92NmwwSERYQVVGOTYzYTJlam9JNlZUNWlYdHpPenlpSDFzWi9a?=
 =?utf-8?B?czRZVGxhYXpoTW9WWk11MmpPTkZqQllmZ3hPeVliUkQ2NG1MdHo0bEgydWJi?=
 =?utf-8?B?QVNtelhGbzFOR1BJd2ZvVWhBRXVBRlBmTkYwVnVzUFN0akYzVkJ5QT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a386b4-0d6f-4310-9489-08dea2581192
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 23:20:27.0312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zil2vd7SssKB7Tbwjn3jwEfLnvbZut1QpcsP8twDbd2s6qDVQuOgM5idPi0pW69hHuNK8NJKR0+vgykcZiOZRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7876
X-OriginatorOrg: oss.nxp.com
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

arch/arm/dts/imx8mq-mnt-reform2.dts are almost same as upstream Linux
imx8mq-mnt-reform2.dts, so switch to OF_USPTREAM for this board, with
only updating imx8mq-mnt-reform2-u-boot.dtsi to keep "simple-panel"
compatible string for display panel.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/Makefile                       |   1 -
 arch/arm/dts/imx8mq-mnt-reform2-u-boot.dtsi |   4 +
 arch/arm/dts/imx8mq-mnt-reform2.dts         | 354 ----------------------------
 arch/arm/dts/imx8mq-nitrogen-som.dtsi       | 278 ----------------------
 arch/arm/mach-imx/imx8m/Kconfig             |   1 +
 configs/imx8mq_reform2_defconfig            |   2 +-
 6 files changed, 6 insertions(+), 634 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index bff341d6118..68ca3b0ad02 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -879,7 +879,6 @@ dtb-$(CONFIG_ARCH_IMX8M) += \
 	imx8mm-mx8menlo.dtb \
 	imx8mm-phg.dtb \
 	imx8mq-cm.dtb \
-	imx8mq-mnt-reform2.dtb \
 	imx8mq-phanbell.dtb \
 	imx8mp-data-modul-edm-sbc.dtb \
 	imx8mp-dhcom-som-overlay-rev100.dtbo \
diff --git a/arch/arm/dts/imx8mq-mnt-reform2-u-boot.dtsi b/arch/arm/dts/imx8mq-mnt-reform2-u-boot.dtsi
index 46a4dfe4e8a..71ce1b5b3ca 100644
--- a/arch/arm/dts/imx8mq-mnt-reform2-u-boot.dtsi
+++ b/arch/arm/dts/imx8mq-mnt-reform2-u-boot.dtsi
@@ -9,3 +9,7 @@
 &uart1 { /* console */
 	bootph-pre-ram;
 };
+
+&{/panel} {
+	compatible = "innolux,n125hce-gn1", "simple-panel";
+};
diff --git a/arch/arm/dts/imx8mq-mnt-reform2.dts b/arch/arm/dts/imx8mq-mnt-reform2.dts
deleted file mode 100644
index 055031bba8c..00000000000
--- a/arch/arm/dts/imx8mq-mnt-reform2.dts
+++ /dev/null
@@ -1,354 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-
-/*
- * Copyright 2019-2021 MNT Research GmbH
- * Copyright 2021 Lucas Stach <dev@lynxeye.de>
- */
-
-/dts-v1/;
-
-#include "imx8mq-nitrogen-som.dtsi"
-
-/ {
-	model = "MNT Reform 2";
-	compatible = "mntre,reform2", "boundary,imx8mq-nitrogen8m-som", "fsl,imx8mq";
-	chassis-type = "laptop";
-
-	backlight: backlight {
-		compatible = "pwm-backlight";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_backlight>;
-		pwms = <&pwm2 0 10000 0>;
-		power-supply = <&reg_main_usb>;
-		enable-gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
-		brightness-levels = <0 32 64 128 160 200 255>;
-		default-brightness-level = <6>;
-	};
-
-	panel {
-		compatible = "innolux,n125hce-gn1", "simple-panel";
-		power-supply = <&reg_main_3v3>;
-		backlight = <&backlight>;
-		no-hpd;
-
-		port {
-			panel_in: endpoint {
-				remote-endpoint = <&edp_bridge_out>;
-			};
-		};
-	};
-
-	pcie1_refclk: clock-pcie1-refclk {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <100000000>;
-	};
-
-	reg_main_5v: regulator-main-5v {
-		compatible = "regulator-fixed";
-		regulator-name = "5V";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-	};
-
-	reg_main_3v3: regulator-main-3v3 {
-		compatible = "regulator-fixed";
-		regulator-name = "3V3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	reg_main_usb: regulator-main-usb {
-		compatible = "regulator-fixed";
-		regulator-name = "USB_PWR";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		vin-supply = <&reg_main_5v>;
-	};
-
-	reg_main_1v8: regulator-main-1v8 {
-		compatible = "regulator-fixed";
-		regulator-name = "1V8";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		vin-supply = <&reg_main_3v3>;
-	};
-
-	reg_main_1v2: regulator-main-1v2 {
-		compatible = "regulator-fixed";
-		regulator-name = "1V2";
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1200000>;
-		vin-supply = <&reg_main_5v>;
-	};
-
-	sound {
-		compatible = "fsl,imx-audio-wm8960";
-		audio-cpu = <&sai2>;
-		audio-codec = <&wm8960>;
-		audio-routing =
-			"Headphone Jack", "HP_L",
-			"Headphone Jack", "HP_R",
-			"Ext Spk", "SPK_LP",
-			"Ext Spk", "SPK_LN",
-			"Ext Spk", "SPK_RP",
-			"Ext Spk", "SPK_RN",
-			"LINPUT1", "Mic Jack",
-			"Mic Jack", "MICB",
-			"LINPUT2", "Line In Jack",
-			"RINPUT2", "Line In Jack";
-		model = "wm8960-audio";
-	};
-};
-
-&dphy {
-	assigned-clocks = <&clk IMX8MQ_CLK_DSI_PHY_REF>;
-	assigned-clock-parents = <&clk IMX8MQ_SYS1_PLL_800M>;
-	assigned-clock-rates = <25000000>;
-	status = "okay";
-};
-
-&fec1 {
-	status = "okay";
-};
-
-&i2c3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c3>;
-	status = "okay";
-
-	wm8960: codec@1a {
-		compatible = "wlf,wm8960";
-		reg = <0x1a>;
-		clocks = <&clk IMX8MQ_CLK_SAI2_ROOT>;
-		clock-names = "mclk";
-		#sound-dai-cells = <0>;
-	};
-
-	rtc@68 {
-		compatible = "nxp,pcf8523";
-		reg = <0x68>;
-	};
-};
-
-&i2c4 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c4>;
-	clock-frequency = <400000>;
-	status = "okay";
-
-	edp_bridge: bridge@2c {
-		compatible = "ti,sn65dsi86";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_edp_bridge>;
-		reg = <0x2c>;
-		enable-gpios = <&gpio3 20 GPIO_ACTIVE_HIGH>;
-		vccio-supply = <&reg_main_1v8>;
-		vpll-supply = <&reg_main_1v8>;
-		vcca-supply = <&reg_main_1v2>;
-		vcc-supply = <&reg_main_1v2>;
-
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port@0 {
-				reg = <0>;
-
-				edp_bridge_in: endpoint {
-					remote-endpoint = <&mipi_dsi_out>;
-				};
-			};
-
-			port@1 {
-				reg = <1>;
-
-				edp_bridge_out: endpoint {
-					remote-endpoint = <&panel_in>;
-				};
-			};
-		};
-	};
-};
-
-&lcdif {
-	assigned-clocks = <&clk IMX8MQ_CLK_LCDIF_PIXEL>;
-	assigned-clock-parents = <&clk IMX8MQ_SYS1_PLL_800M>;
-	/delete-property/assigned-clock-rates;
-	status = "okay";
-};
-
-&mipi_dsi {
-	status = "okay";
-
-	ports {
-		port@1 {
-			reg = <1>;
-
-			mipi_dsi_out: endpoint {
-				remote-endpoint = <&edp_bridge_in>;
-			};
-		};
-	};
-};
-
-&pcie1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pcie1>;
-	reset-gpio = <&gpio3 23 GPIO_ACTIVE_LOW>;
-	clocks = <&clk IMX8MQ_CLK_PCIE2_ROOT>,
-		 <&clk IMX8MQ_CLK_PCIE2_AUX>,
-		 <&clk IMX8MQ_CLK_PCIE2_PHY>,
-		 <&pcie1_refclk>;
-	clock-names = "pcie", "pcie_aux", "pcie_phy", "pcie_bus";
-	status = "okay";
-};
-
-&pwm2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pwm2>;
-	status = "okay";
-};
-
-&reg_1p8v {
-	vin-supply = <&reg_main_5v>;
-};
-
-&reg_snvs {
-	vin-supply = <&reg_main_5v>;
-};
-
-&reg_arm_dram {
-	vin-supply = <&reg_main_5v>;
-};
-
-&reg_dram_1p1v {
-	vin-supply = <&reg_main_5v>;
-};
-
-&reg_soc_gpu_vpu {
-	vin-supply = <&reg_main_5v>;
-};
-
-&sai2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_sai2>;
-	assigned-clocks = <&clk IMX8MQ_CLK_SAI2>;
-	assigned-clock-parents = <&clk IMX8MQ_CLK_25M>;
-	assigned-clock-rates = <25000000>;
-	fsl,sai-mclk-direction-output;
-	fsl,sai-asynchronous;
-	status = "okay";
-};
-
-&snvs_rtc {
-	status = "disabled";
-};
-
-&uart2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
-	status = "okay";
-};
-
-&usb3_phy0 {
-	vbus-supply = <&reg_main_usb>;
-	status = "okay";
-};
-
-&usb3_phy1 {
-	vbus-supply = <&reg_main_usb>;
-	status = "okay";
-};
-
-&usb_dwc3_0 {
-	dr_mode = "host";
-	status = "okay";
-};
-
-&usb_dwc3_1 {
-	dr_mode = "host";
-	status = "okay";
-};
-
-&usdhc2 {
-	assigned-clocks = <&clk IMX8MQ_CLK_USDHC2>;
-	assigned-clock-rates = <200000000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc2>;
-	vqmmc-supply = <&reg_main_3v3>;
-	vmmc-supply = <&reg_main_3v3>;
-	bus-width = <4>;
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl_backlight: backlightgrp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_GPIO1_IO10_GPIO1_IO10		0x3
-		>;
-	};
-
-	pinctrl_edp_bridge: edpbridgegrp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_SAI5_RXC_GPIO3_IO20		0x1
-		>;
-	};
-
-	pinctrl_i2c3: i2c3grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_I2C3_SCL_I2C3_SCL			0x40000022
-			MX8MQ_IOMUXC_I2C3_SDA_I2C3_SDA			0x40000022
-		>;
-	};
-
-	pinctrl_i2c4: i2c4grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_I2C4_SCL_I2C4_SCL			0x40000022
-			MX8MQ_IOMUXC_I2C4_SDA_I2C4_SDA			0x40000022
-		>;
-	};
-
-	pinctrl_pcie1: pcie1grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_SAI5_RXD2_GPIO3_IO23		0x16
-		>;
-	};
-
-	pinctrl_pwm2: pwm2grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_SPDIF_RX_PWM2_OUT			0x3
-		>;
-	};
-
-	pinctrl_sai2: sai2grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_SAI2_RXD0_SAI2_RX_DATA0		0xd6
-			MX8MQ_IOMUXC_SAI2_RXFS_SAI2_RX_SYNC		0xd6
-			MX8MQ_IOMUXC_SAI2_TXC_SAI2_TX_BCLK		0xd6
-			MX8MQ_IOMUXC_SAI2_TXFS_SAI2_TX_SYNC		0xd6
-			MX8MQ_IOMUXC_SAI2_RXC_SAI2_RX_BCLK		0xd6
-			MX8MQ_IOMUXC_SAI2_MCLK_SAI2_MCLK		0xd6
-			MX8MQ_IOMUXC_SAI2_TXD0_SAI2_TX_DATA0		0xd6
-		>;
-	};
-
-	pinctrl_uart2: uart2grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_UART2_RXD_UART2_DCE_RX		0x45
-			MX8MQ_IOMUXC_UART2_TXD_UART2_DCE_TX		0x45
-		>;
-	};
-
-	pinctrl_usdhc2: usdhc2grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_SD2_CD_B_USDHC2_CD_B		0x0
-			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x83
-			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc3
-			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc3
-			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc3
-			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc3
-			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc3
-		>;
-	};
-};
diff --git a/arch/arm/dts/imx8mq-nitrogen-som.dtsi b/arch/arm/dts/imx8mq-nitrogen-som.dtsi
deleted file mode 100644
index 395f77b5aca..00000000000
--- a/arch/arm/dts/imx8mq-nitrogen-som.dtsi
+++ /dev/null
@@ -1,278 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2018 Boundary Devices
- * Copyright 2021 Lucas Stach <dev@lynxeye.de>
- */
-
-#include "imx8mq.dtsi"
-
-/ {
-	model = "Boundary Devices i.MX8MQ Nitrogen8M";
-	compatible = "boundary,imx8mq-nitrogen8m-som", "fsl,imx8mq";
-
-	chosen {
-		stdout-path = &uart1;
-	};
-
-	reg_1p8v: regulator-fixed-1v8 {
-		compatible = "regulator-fixed";
-		regulator-name = "1P8V";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	reg_snvs: regulator-fixed-snvs {
-		compatible = "regulator-fixed";
-		regulator-name = "VDD_SNVS";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-};
-
-&{/opp-table/opp-800000000} {
-	opp-microvolt = <1000000>;
-};
-
-&{/opp-table/opp-1000000000} {
-	opp-microvolt = <1000000>;
-};
-
-&A53_0 {
-	cpu-supply = <&reg_arm_dram>;
-};
-
-&A53_1 {
-	cpu-supply = <&reg_arm_dram>;
-};
-
-&A53_2 {
-	cpu-supply = <&reg_arm_dram>;
-};
-
-&A53_3 {
-	cpu-supply = <&reg_arm_dram>;
-};
-
-&fec1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_fec1>;
-	phy-mode = "rgmii-id";
-	phy-handle = <&ethphy0>;
-	fsl,magic-packet;
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ethphy0: ethernet-phy@4 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <4>;
-			interrupt-parent = <&gpio1>;
-			interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
-			reset-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
-			reset-assert-us = <10000>;
-			reset-deassert-us = <300>;
-		};
-	};
-};
-
-&i2c1 {
-	clock-frequency = <400000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c1>;
-	status = "okay";
-
-	i2c-mux@70 {
-		compatible = "nxp,pca9546";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_i2c1_pca9546>;
-		reg = <0x70>;
-		reset-gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		i2c1a: i2c@0 {
-			reg = <0>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			reg_arm_dram: regulator@60 {
-				compatible = "fcs,fan53555";
-				reg = <0x60>;
-				regulator-name = "VDD_ARM_DRAM_1V";
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <1000000>;
-				regulator-always-on;
-			};
-		};
-
-		i2c1b: i2c@1 {
-			reg = <1>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			reg_dram_1p1v: regulator@60 {
-				compatible = "fcs,fan53555";
-				reg = <0x60>;
-				regulator-name = "NVCC_DRAM_1P1V";
-				regulator-min-microvolt = <1100000>;
-				regulator-max-microvolt = <1100000>;
-				regulator-always-on;
-			};
-		};
-
-		i2c1c: i2c@2 {
-			reg = <2>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			reg_soc_gpu_vpu: regulator@60 {
-				compatible = "fcs,fan53555";
-				reg = <0x60>;
-				regulator-name = "VDD_SOC_GPU_VPU";
-				regulator-min-microvolt = <900000>;
-				regulator-max-microvolt = <900000>;
-				regulator-always-on;
-			};
-		};
-
-		i2c1d: i2c@3 {
-			reg = <3>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-	};
-};
-
-&pgc_gpu {
-	power-supply = <&reg_soc_gpu_vpu>;
-};
-
-&pgc_vpu {
-	power-supply = <&reg_soc_gpu_vpu>;
-};
-
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1>;
-	status = "okay";
-};
-
-&usdhc1 {
-	assigned-clocks = <&clk IMX8MQ_CLK_USDHC1>;
-	assigned-clock-rates = <400000000>;
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc1>;
-	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
-	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
-	vqmmc-supply = <&reg_1p8v>;
-	vmmc-supply = <&reg_snvs>;
-	bus-width = <8>;
-	non-removable;
-	no-mmc-hs400;
-	no-sdio;
-	no-sd;
-	status = "okay";
-};
-
-&wdog1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_wdog>;
-	fsl,ext-reset-output;
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl_fec1: fec1grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_ENET_MDC_ENET1_MDC			0x3
-			MX8MQ_IOMUXC_ENET_MDIO_ENET1_MDIO		0x23
-			MX8MQ_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
-			MX8MQ_IOMUXC_ENET_TXC_ENET1_RGMII_TXC		0x1f
-			MX8MQ_IOMUXC_ENET_TD0_ENET1_RGMII_TD0		0x1f
-			MX8MQ_IOMUXC_ENET_TD1_ENET1_RGMII_TD1		0x1f
-			MX8MQ_IOMUXC_ENET_TD2_ENET1_RGMII_TD2		0x1f
-			MX8MQ_IOMUXC_ENET_TD3_ENET1_RGMII_TD3		0x1f
-			MX8MQ_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
-			MX8MQ_IOMUXC_ENET_RXC_ENET1_RGMII_RXC		0xd1
-			MX8MQ_IOMUXC_ENET_RD0_ENET1_RGMII_RD0		0x91
-			MX8MQ_IOMUXC_ENET_RD1_ENET1_RGMII_RD1		0x91
-			MX8MQ_IOMUXC_ENET_RD2_ENET1_RGMII_RD2		0x91
-			MX8MQ_IOMUXC_ENET_RD3_ENET1_RGMII_RD3		0xd1
-			MX8MQ_IOMUXC_GPIO1_IO09_GPIO1_IO9		0x1
-			MX8MQ_IOMUXC_GPIO1_IO11_GPIO1_IO11		0x41
-		>;
-	};
-
-	pinctrl_i2c1: i2c1grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_I2C1_SCL_I2C1_SCL			0x40000022
-			MX8MQ_IOMUXC_I2C1_SDA_I2C1_SDA			0x40000022
-		>;
-	};
-
-	pinctrl_i2c1_pca9546: i2c1-pca9546grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_GPIO1_IO08_GPIO1_IO8		0x49
-		>;
-	};
-
-	pinctrl_uart1: uart1grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_UART1_RXD_UART1_DCE_RX		0x45
-			MX8MQ_IOMUXC_UART1_TXD_UART1_DCE_TX		0x45
-		>;
-	};
-
-	pinctrl_usdhc1: usdhc1grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x83
-			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xc3
-			MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xc3
-			MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xc3
-			MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xc3
-			MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xc3
-			MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xc3
-			MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xc3
-			MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xc3
-			MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xc3
-			MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0xc1
-		>;
-	};
-
-	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x8d
-			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xcd
-			MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xcd
-			MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xcd
-			MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xcd
-			MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xcd
-			MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xcd
-			MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xcd
-			MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xcd
-			MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xcd
-		>;
-	};
-
-	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x9f
-			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xdf
-			MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xdf
-			MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xdf
-			MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xdf
-			MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xdf
-			MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xdf
-			MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xdf
-			MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xdf
-			MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xdf
-		>;
-	};
-
-	pinctrl_wdog: wdoggrp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B		0xc6
-		>;
-	};
-};
diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index 8b0d48b07b3..40b5de47cfb 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -84,6 +84,7 @@ config TARGET_IMX8MQ_REFORM2
 	bool "imx8mq_reform2"
 	select IMX8MQ
 	select IMX8M_LPDDR4
+	imply OF_UPSTREAM
 
 config TARGET_IMX8MM_DATA_MODUL_EDM_SBC
 	bool "Data Modul eDM SBC i.MX8M Mini"
diff --git a/configs/imx8mq_reform2_defconfig b/configs/imx8mq_reform2_defconfig
index efa1b1ac1d5..fec20ed81d8 100644
--- a/configs/imx8mq_reform2_defconfig
+++ b/configs/imx8mq_reform2_defconfig
@@ -11,7 +11,7 @@ CONFIG_SYS_I2C_MXC_I2C1=y
 CONFIG_SYS_I2C_MXC_I2C2=y
 CONFIG_SYS_I2C_MXC_I2C3=y
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx8mq-mnt-reform2"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mq-mnt-reform2"
 CONFIG_TARGET_IMX8MQ_REFORM2=y
 CONFIG_DM_RESET=y
 CONFIG_SYS_MONITOR_LEN=524288

-- 
2.51.0

