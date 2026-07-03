Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 266E8C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 13:00:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3485D84AAE;
	Fri,  3 Jul 2026 14:59:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="2S5kExyD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6504D84ABB; Fri,  3 Jul 2026 13:57:11 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA27B84A52
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 13:57:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qmiwgIBxb87+aGNtJ2N0fBsAF7YolH0B2r3GZzDNFNsWfeQnuK+6VzbnmxfBhpDGDKkyITGsfmU0bll8yxJ+z23GXLW7eWcws0SOhRygwGAvty1DhuQiiFFhktrnWLsnwUothQH1eLRu0FVTzAVgAEMwNbJYOYsPunOB/2ZuRrXBTuux7Onfyw6+ecsSi15ykZE8rI00rjAMan1oVnonTXUfbuylW7i9i5PRxgbUFHhpYaCz7UaZ7j7G46mIMy4AtwY3QTHplo+4ZirGBCX/1RVyooczUesUQpXIdHq1lmrDRUbdf02BYDgwLmXR3nbVwak8G4CTU5JXUY1E6a+uvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=untM57uYUc4ok92Ad7O0f6j+SstSCfeXVoQCODMkdMQ=;
 b=T28mFjvqvQUs7zhHgtGjM1qFaKzmJJoSpoApUOwriWwWraKODD4xy4GsD7toCQlpUlsepylQunNxaYuoFApTJ9WuPtRvwPkJqednQiDjE6+H41QFRYTi7dU0BCuDw1OWyvBMNrwCpbD1HQQIf2qdaP77/Cg5F2vyCRtumitgfe+W1g5wgE419mVz3Qym6IfbMFnTZu5fAfOHV39Dl3pfw1S6vmYvlozXJJ2dcXiC9lbwZoAfKkHdU2TGDBJofrXk8lFbrqPIa0mUdDHJfRJhJx5NbfcrB8ZN9HZbGA6RVEMCEf6kus9nAG70C9a8l25ZUw3gpf+FG8wzViLbk8rYSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=untM57uYUc4ok92Ad7O0f6j+SstSCfeXVoQCODMkdMQ=;
 b=2S5kExyDK92wwj94bFY0D7S2wWS0z53WLW1wb5pHSKb4SD4KWY1FZLPb5Ou5WqIKshDFS018Xkz8MIuyAQTvsusQemRd3seidjQg4e0dW5D3zxsK7pdsqzb28gOzKZZLGpa5PPJALtFega4xAkJzBp4uhbhMJm6CN/wHm5Foc+Jkx1fuFRIbGHxm1chUBEx2u+8VuFRvii2OcKhmGPcoM8WB0PI6UiUuLlAhizWk8yF9TbO51clJt54zJU+CXmP505+gTe2vnQAhJJCrAe766cuEz26s7g4aqmryz6WRIi1KUZrA0MKqAG61gzwIpZaPad1SygYdmR5Qc7jtg9tpng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PAWPR08MB9448.eurprd08.prod.outlook.com (2603:10a6:102:2f0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 11:57:04 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0159.018; Fri, 3 Jul 2026
 11:57:04 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Stefan Roese <stefan.roese@mailbox.org>, Simon Glass <sjg@chromium.org>,
 David Lechner <dlechner@baylibre.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Michal Simek <michal.simek@amd.com>,
 Sean Anderson <sean.anderson@linux.dev>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Crt Mori <cmo@melexis.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v15 09/24] bitfield: Add non-constant field_{prep,
 get}() helpers
Date: Fri,  3 Jul 2026 14:56:12 +0300
Message-ID: <20260703115627.2317120-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703115627.2317120-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260703115627.2317120-1-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0194.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::18) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PAWPR08MB9448:EE_
X-MS-Office365-Filtering-Correlation-Id: b7c02de6-632f-4057-3d98-08ded8fa32f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|52116014|366016|1800799024|921020|38350700014|18002099003|22082099003|9063799003|56012099006|3023799007|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: RBOb/3EYmP8WlAtWqz9DMaeuLwkpirEofTi3G+Et4q8yQFxIgIR4BtztClD3+nqHzYt5e5CjN5i2FvMNI3YTdwS2O6yDqpaiWotdo9CLHn2GYuAAqUnC/nz/WtKn+38WI4zhTDsHtMJ1MtWSdBYfFRxBEHftQ8sfCJWbGsFHgExYsaDwM2/Uuqg0o1vMRAd3UJ/KyupNImtOE8xny4wApsKRUv0ijTupV9U19K1cs7IZlt5xANxBGtv/iWuvSUGLO14bJOda01qpgcA2yyiSvurpNKuXKGm/P2J6wUvCxKeFRFX/RZ6qGIwVTEbWHkKTIfBveXzsgS91yDD8ye6UIE5Ou/vD3cnSmwbOohkmreETvfxrisBJiwqZxsQn2VbzooBYlEsXkti0xgDizCklZvbh7V+gbRawLYo7ah7eaBz2Ga7APyswI/vyjBD9wMk+Cfmo2fE3FYhJHe2iggBICfMrNZRRQATk1RXIBPt+AabVXzswCX7423KTj4qHK9sKoXEcDmolPO3PoycyoQZDIHqyxdWiAlyZ08zorD7l5xEjlhPbDKJwZxd/JgHOrM4Hp5CwKttkirm7o1s6qBQuY1bK+VSkpH9seeIiFNNIj3dUQ6tEP7u36Y98qEyeIXSVhweDzU0dhOlPRi6e+jBb9o9pn2N8ykWKBh7dz1PfDLbmyXSEFPfz9J4RQbwYgVDO4//9RN8bWNICEZRApD9ox0yJ7iKslHkmOfcES0GrxkSevCBssFQMeEQI0EwDyigT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(52116014)(366016)(1800799024)(921020)(38350700014)(18002099003)(22082099003)(9063799003)(56012099006)(3023799007)(11063799006)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDBlVVA5UGd0a2sySkdGTlByTlRVNW1kSEtTMWozZmRsZitvMlhnTEFjRml4?=
 =?utf-8?B?NWMyc3EwcnkweXc1WUpCczBCaFFIRGtuYlJRTWdSNU5rUlFISWdacmFpOGhK?=
 =?utf-8?B?VHFNd2hkV0dGVFROenk4MnJBdU1iTnBsa1BBQmIxMktPZ25RcysvYnlZNXZY?=
 =?utf-8?B?UmRHQVRhd2VFM1pRTDZUMCtmeU9wY1FSdU5FRTRXWGJBL0R0MTBiTGp3NFUx?=
 =?utf-8?B?K1diNDBjcWxhTTd0dFNqWHBEQWtkOU5Cd2x5aU94dXpldGd2UERaRERJenN0?=
 =?utf-8?B?YmNPb2NabFQ1SThMRzMwb3F3Z0hhUERhaUtNa1JtYzJsZjRaT0xNZzhCbnJu?=
 =?utf-8?B?ZDZnWGEvWERNdmRLUW1LRFJYM1RZSXd6dm11ZVB2RVplYktxWFVWaG94ZVF0?=
 =?utf-8?B?NHN5dzZEWFo2MHhRcWxhczFLMTVRZHBaOVU5Sm43MXJaTWxIVmRaditXWGkr?=
 =?utf-8?B?Qk5SemlGQTd5UFhRTHZ3WVc2dXp6Q1pvRW5pZHJwdVRQSVg0Z2xDS085Z2Mz?=
 =?utf-8?B?WXFDTFBrVmYzUytYbXZzVUV1VFFlWGFVL0dreFVSclh4QUZSOHYxck90L1F5?=
 =?utf-8?B?OXZyNWdRL2R5aXQzNTAwNmhSeWVEbWJyT2tvYkt3Qmp3aFp2Wjl1SnpiM0Rt?=
 =?utf-8?B?TEtLblBKUDgza2hIQlVUYVBMcmZUem1GSmsva3ZZeTBhM21ZOXpZc3RoeDVM?=
 =?utf-8?B?K3MrdEppbklYeEpPMjlnaHpib2xuM2ZLVXFJZTZRTS9vcXp5Mm1SVXF2K0Rs?=
 =?utf-8?B?Mit4RTRoWU5UMWhiVWd4Z0NqSlpzejdmTzhyVzdMakFvbTZBQ0xwd1FOWDhN?=
 =?utf-8?B?cXJNbmhMb0ttamFyWG05OXlIOXpyblJHeDJBY1VKZzRDRjNJL1RvbDVrbk8v?=
 =?utf-8?B?ZkhjblIvY29LMHgyS1NNQ20zVnd1N3BrN01DR0xyakMvTFh6MzBDaW9INm9N?=
 =?utf-8?B?SERnNlp2RWo2b2dXeWRpdkZvWlRSSlFoVGZNTCtNeUJmUXVtZkxjZHh3Q2M1?=
 =?utf-8?B?b3NTcWZqdlhvZlZvdmVISXV6REozMjV6OWNwRndwL2ZQZ05lMTRMY3M0Z0kx?=
 =?utf-8?B?TUpGQVJYRVJ3NDNFWUZzSHo1SS95RmlkZHZDckhwT1JiT3ZSUEhhYWl3QVUx?=
 =?utf-8?B?NzY2aDh5N2lMTE1Qc0hCRTd4YmFjbWVhNEs5bXc5SnR1VHVlL2RTa3Fub0FV?=
 =?utf-8?B?UnBlaEYweDFvWXBna0hOSnQ1T1FjZW9SUUxmeTZRcTRJbktDWnBsNkgvcHN3?=
 =?utf-8?B?R3BoRVNzKytDOTNWQStjdTBFWE9uOGpwMUNub1Zxa2p2NVNtdEFLYXVEMzYy?=
 =?utf-8?B?TWh6ZjEvYkdQOXNDemN2SnBKZFY4REczakl2SkhBZ1RwcFZKdnFIdjVQd0Z5?=
 =?utf-8?B?eEdMamk5SE1NV1RNRzFaZmxLUDA0cWtxWTBDZWg0SE9kYnFzRU1kZzkwa29B?=
 =?utf-8?B?TVhySktpS2lLUE5rdnc0OGNNZmxwMXpoRTRaZDJjOVVvNlN5ZDJsTnZFQm5R?=
 =?utf-8?B?b0tlVEw2NEtsTXQ4azY5QVBuZExKaXd6QitQbHYranRlcjRYTmZ0czJRdzJn?=
 =?utf-8?B?cFZwUWJjR2Z6ZksyeklCMzh4QmdMNCtlQzJweWNkUEpObTdEMUQrTGZ5eWJk?=
 =?utf-8?B?SERidlI3VHFib2xQam91Q1Y5RnVTT0ZmSFFSS3dPY3dhaHIxaWFTQXNHY0NG?=
 =?utf-8?B?T3cwRDFtTCtiR0hHKzU4OVU5b1pKQzRqYVoxazFSWmlWM1NaNDVaUU93YVk1?=
 =?utf-8?B?VmhjcUM2ek85N3lzNFVZenNiWGlYYzRiOWV5azFPSUl2QWt4aUZaZGxJdXpX?=
 =?utf-8?B?QzZxVFFsaUp2dlplSTJTYjRXUUJWaGx4dUFqdU0rZ1lnQU05Zks3SkdZSVFG?=
 =?utf-8?B?bXVzSnJRTWsxbEN6dStkTVoxdjNDRTZzelF5QlZ5cU8ybWZ1UlVXMk5ZYXc4?=
 =?utf-8?B?UVpQcHJDWmRYamdUQ2lPUmM1Yll1RGhZKzNDdHVIMkMwUEZVVVdmaDkwdDJs?=
 =?utf-8?B?UzlSTUpIWE9Yd3Y5YXRnajZZa2IwSUo5Z0c2eS8yT2RlVU0wQlpkYnA2ZGlu?=
 =?utf-8?B?YTJCay9XWnhBcDdtbXNjS0xhNEJlbE1CQ3psSG9EREZJNWNJR3gxb1d0MWkv?=
 =?utf-8?B?ditBYlE5U1NKSVcrbVZLQjJ6a3J4ZUpHQ3diYWFGVFc3WWxlQ2lFVWpRUXBp?=
 =?utf-8?B?eEZRWjI5N2xlY09wbHpRNlVDcU9Xbm14c3lhc2pIalQvUXlEcTBzTkg3L0Uw?=
 =?utf-8?B?b21VZXkvdEJoS01lTGFzTlNWeWp3SHBleGx5VUZpTElyUElSZmtobmlwRFkw?=
 =?utf-8?B?amk5SUM0T3RMKzZZdmFmNS8vNE4yN3h3TmM1LzBDS3NIWWpKc1NXbzZFdE5F?=
 =?utf-8?Q?/AmLtU+i1yhQQP/U=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c02de6-632f-4057-3d98-08ded8fa32f0
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 11:57:04.2726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9p+QeJXdbuI5zXcinCR9UJ1ckDgcKnK1n4Ncz6B78J2NSN8GpoNAkQ9ZCVKxA3PPys5mRoiWzxvnQ9QA9DkPpV9hdFeJ4fk3OHB9SgDd2ng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9448
X-Mailman-Approved-At: Fri, 03 Jul 2026 14:59:42 +0200
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

The existing FIELD_{GET,PREP}() macros are limited to compile-time
constants.  However, it is very common to prepare or extract bitfield
elements where the bitfield mask is not a compile-time constant.

To avoid this limitation, the AT91 clock driver and several other
drivers already have their own non-const field_{prep,get}() macros.
Make them available for general use by adding them to
<linux/bitfield.h>, and improve them slightly:
  1. Avoid evaluating macro parameters more than once,
  2. Replace "ffs() - 1" by "__ffs()",
  3. Support 64-bit use on 32-bit architectures,
  4. Wire field_{get,prep}() to FIELD_{GET,PREP}() when mask is
     actually constant.

This is deliberately not merged into the existing FIELD_{GET,PREP}()
macros, as people expressed the desire to keep stricter variants for
increased safety, or for performance critical paths.

Yury: use __mask within new macros.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Crt Mori <cmo@melexis.com>
Acked-by: Nuno Sá <nuno.sa@analog.com>
Acked-by: Richard Genoud <richard.genoud@bootlin.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
[Linux commit: c1c6ab80b25c8db1e2ef5ae3ac8075d2c242ae13]
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 include/linux/bitfield.h | 59 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index ef81901bc41..18cf57aeb2c 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -16,6 +16,7 @@
  * FIELD_{GET,PREP} macros take as first parameter shifted mask
  * from which they extract the base mask and shift amount.
  * Mask must be a compilation time constant.
+ * field_{get,prep} are variants that take a non-const mask.
  *
  * Example:
  *
@@ -223,4 +224,62 @@ __MAKE_OP(64)
 #undef __MAKE_OP
 #undef ____MAKE_OP
 
+#define __field_prep(mask, val)						\
+	({								\
+		__auto_type __mask = (mask);				\
+		typeof(__mask) __val = (val);				\
+		unsigned int __shift = BITS_PER_TYPE(__mask) <= 32 ?	\
+				       __ffs(__mask) : __ffs64(__mask);	\
+		(__val << __shift) & __mask;				\
+	})
+
+#define __field_get(mask, reg)						\
+	({								\
+		__auto_type __mask = (mask);				\
+		typeof(__mask) __reg =  (reg);				\
+		unsigned int __shift = BITS_PER_TYPE(__mask) <= 32 ?	\
+				       __ffs(__mask) : __ffs64(__mask);	\
+		(__reg & __mask) >> __shift;				\
+	})
+
+/**
+ * field_prep() - prepare a bitfield element
+ * @mask: shifted mask defining the field's length and position, must be
+ *        non-zero
+ * @val:  value to put in the field
+ *
+ * Return: field value masked and shifted to its final destination
+ *
+ * field_prep() masks and shifts up the value.  The result should be
+ * combined with other fields of the bitfield using logical OR.
+ * Unlike FIELD_PREP(), @mask is not limited to a compile-time constant.
+ * Typical usage patterns are a value stored in a table, or calculated by
+ * shifting a constant by a variable number of bits.
+ * If you want to ensure that @mask is a compile-time constant, please use
+ * FIELD_PREP() directly instead.
+ */
+#define field_prep(mask, val)						\
+	(__builtin_constant_p(mask) ? __FIELD_PREP(mask, val, "field_prep: ") \
+				    : __field_prep(mask, val))
+
+/**
+ * field_get() - extract a bitfield element
+ * @mask: shifted mask defining the field's length and position, must be
+ *        non-zero
+ * @reg:  value of entire bitfield
+ *
+ * Return: extracted field value
+ *
+ * field_get() extracts the field specified by @mask from the
+ * bitfield passed in as @reg by masking and shifting it down.
+ * Unlike FIELD_GET(), @mask is not limited to a compile-time constant.
+ * Typical usage patterns are a value stored in a table, or calculated by
+ * shifting a constant by a variable number of bits.
+ * If you want to ensure that @mask is a compile-time constant, please use
+ * FIELD_GET() directly instead.
+ */
+#define field_get(mask, reg)						\
+	(__builtin_constant_p(mask) ? __FIELD_GET(mask, reg, "field_get: ") \
+				    : __field_get(mask, reg))
+
 #endif
-- 
2.53.0

