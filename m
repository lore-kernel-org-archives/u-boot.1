Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D27CD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 12:56:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BA3B846FA;
	Tue, 19 May 2026 14:56:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="e9YIuycU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A79F8465A; Tue, 19 May 2026 08:20:08 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B641F84119
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 08:20:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NvRkIalaAwzj4WwG2vOHVKPHCB8TKv1jJ/5W4Eu/5rxb750sTvelk5BTO7fD8meuKt2fzpjLgKkMiCgWNjMgDkNyccKaE8C7N9yCbf6WmX9BTMwbKLWghoopj7IZu480RO0wUlkTm3sNdAhl/Pr7dFjTCt455urlCwHm9YJuvjvNqDRCr2mSkjK1IuE9l4iMyvF7nduXeQXoG/XvsIFNCGtzPC/Q+Nsw3rT78+QBKWrvjPubYTQ4O9krH3Zr6TkS7ujfXmiGK5Rlcyp6vhhUHrzyPERNh7+nWwKnZaqc0mrfQkHrxbY+qUG1kncB7f1FHbDTuLbspF2vSKez5Nm2Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgpUfk8JgdG9HQWxDmN3pSfuOjxdMC90uhpm1Opi7zA=;
 b=RM8S2hFLSWgGtuOVa17LmtWtclYuxl3zT6h5kP4g98hd6VgF7b0UNRM0OSLiFvymP2ZrigdcoXd12qmn7XJncRl7JWC98N09MCpgqXIG57RlBsTXa+FnTF+ouDwMg19fWe8/M3eyyk56F5/h5QzuBJ/tETh53KasgWHSvP3fSvWiWIdmbmy2QtBOOuA9fQbZ/rZRgDvDvM8vPSpATkBg8X/Ed3ojPfGzahEfUBY5QQHQYPeMq5RvJwX+reqbZXgo1QpA43TNNbvmrMjDzJ5jPT1do2EgZsfbUyeHrpTeqstmNOEsBmLKmwyT/Rv1rjr2qF3k3ZBQone/pGpXQoo9GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgpUfk8JgdG9HQWxDmN3pSfuOjxdMC90uhpm1Opi7zA=;
 b=e9YIuycU5TVK8C/t5z90u0YFFwiUozVRr/3WbaInSeeOHUY8+aITsiAGZuWU6umq2TZa1hnIS6QSnQF12OnsiVNnz55eICi47XyH//27nU1XS3iX+28m6KcPjMBDyDlSRYSlSMFq+kFRnBJGlB5hteYwBSPoL3QOT44L+VyubAbso1dC1PEfVtfBBnEacinCVwbV61PCbKp5fsqH42sOMljfzwjCmlq3/vtDJS4wa26xdKuGhBuV0vYFQ7kQbvSj0selF2b335A9BKszH7HEXzL5wK+BjdB8djfQlj6aFlKIWjc/svkG6rgVw1Nlva3cLRJPl5Bt+XGZT9fsOp2dUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS1PR04MB9453.eurprd04.prod.outlook.com (2603:10a6:20b:4da::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 06:19:56 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 06:19:56 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 19 May 2026 14:22:02 +0800
Subject: [PATCH v4 2/8] imx91: Switch to OF_UPSTREAM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-wdtv4-v1-2-deef133b81cd@nxp.com>
References: <20260519-wdtv4-v1-0-deef133b81cd@nxp.com>
In-Reply-To: <20260519-wdtv4-v1-0-deef133b81cd@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Christoph Stoidner <c.stoidner@phytec.de>, upstream@lists.phytec.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Joseph Guo <qijian.guo@nxp.com>, Francesco Valla <francesco@valla.it>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Ye Li <ye.li@nxp.com>, 
 Primoz Fiser <primoz.fiser@norik.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 Johan Jonker <jbx6244@gmail.com>, Hai Pham <hai.pham.ud@renesas.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, 
 Paresh Bhagat <p-bhagat@ti.com>, Janne Grunau <j@jannau.net>, 
 Paul Kocialkowski <contact@paulk.fr>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Mathieu Othacehe <m.othacehe@gmail.com>, Brian Sune <briansune@gmail.com>, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 Jacky Bai <ping.bai@nxp.com>, David Zang <davidzangcs@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Fedor Ross <fedor.ross@ifm.com>, Stefan Roese <stefan.roese@mailbox.org>, 
 Lukasz Majewski <lukma@denx.de>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Martin Schwan <m.schwan@phytec.de>, 
 Simona Toaca <simona.toaca@nxp.com>, Anshul Dalal <anshuld@ti.com>, 
 Franz Schnyder <franz.schnyder@toradex.com>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SG2P153CA0048.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::17)
 To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS1PR04MB9453:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a0e9a12-6f26-42dd-4431-08deb56ea56f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|366016|376014|7416014|52116014|22082099003|18002099003|56012099003|38350700014|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info: bCe+tfzV2UzREr9L/k2mOw8kBs/yGJpoTZLMnEvDtsvpZIftL3d65Aoc+V7gAYFB9ynKiOkxbbfrgw48ZZZW/vXy6FrSo7XMPUEky+eDY8clPKxZ4+cx+VJmlOnTT3KLNrV56y0zwsAEmCeMKAKq16JBFCPTHdAhRKNUy0o0akw/xyXV/bnXoBsLsNT2MPkYFQ2oCHSRQ5+CB+7AcHS5QgCJNs8VBwHv9FO8xGqTMxfvb0vCAjfV0L4RcdBuIsZg9XsdeRWRf2VeQZs0ctWTiWhDPyb5wXuk8gtys8x9LHU70EW1RIX5N3SZ6RnvP/eeZkefFIxZps1Kwg6h79sBo3JZe0V7GCLF1E+krRN7roz7Ck4RJ5Z6WFG+csq/xWT5IB3KJQK63V3MxwrE5/ykgrz0oKChUqauhHQRh8x/RSxxsHMp+Ndq05ged4xDXhalizJ9UHWLaFyvzifIT9IokoeiMbRQ+OAtdt+TpIgt4Tuhey5npDyZFjW1fNCzex8XrFXlSqDo0/xoXHvVGKlgi19a30AbTQE3XI//4UlMpWNR5AOIsSgU/cVScBqK0Tm5dg2eDEI9sj9PMaKy5e0QjTSmozTgOS5zsG5o30TgQvilfTMjempCdP+QRLgI7Al/SvqWvp/2TIGBHok9AjWcGrreraaq0Ios2MzTNgl6GdAhxRE+Awde39Kxow2p9kutoyhjJKKKjdGUJoxDPqtZ1Mzk5T0gK4kkU/HZUeXWOR8LV+ljzeUeZWmNqeORzYSQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(7416014)(52116014)(22082099003)(18002099003)(56012099003)(38350700014)(3023799003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXR4bkY2bTVLMkJwZlRQVG5NdzgxSnFhRGp2bHQyUWh5T3JJWGdmeENiRUtq?=
 =?utf-8?B?ZnJiL1lsKzl1OWZOZUpKMVNRZmtmazZLWnJaZ2tkbE9OVHplWTRaVHFoaWJW?=
 =?utf-8?B?dW5aZisrOWFocjYzYmwwdk5yYmtaUmhwOGIrNWtNeWpFd0lEL0thNjlTTWJJ?=
 =?utf-8?B?WnNXOHlvVDZ5ZjFORnZ1cy9OSFJhaWd6ZWlaOUhHSWlIc0tINFN2Z3NjZEt3?=
 =?utf-8?B?Qk9FdklrczdWYzJVanZoMVlJQlJIaHprZHlQOXRyemxoalB3SllvbnBEQ1Vp?=
 =?utf-8?B?d2RzcEI4dnVjMXdqa3FXa2lqTHVNZUZBR21URmxUMGlyVW1DRkNxM1BxM0Jv?=
 =?utf-8?B?Y05Cb1hqaDB4Sit6Q0xCeHVKaEpzVVY5WmdVZEE2ei9YQTU0cnBGMVU1R2Rn?=
 =?utf-8?B?NTJDK2g2Vm1tMHdTVUh5OTNiaEd0Z3ZBMFZzaFFIWHBOTHRVQktHcG9PTWZh?=
 =?utf-8?B?M2oyUWt0T0NCVTBTQ0VHYktvWFBvMDB4MlB2bDlGMUROR3lEaFdRS0hYTE1t?=
 =?utf-8?B?ZzA0TXkvNEcweHo5aGZ5U1BoY3U2RHUrOHpvUjcxM1MyOUNpWEJ5YWhTQUJW?=
 =?utf-8?B?Unc4enNRTTJhd2xIVkxHZnptcnpMQ290azROdGFBZGp2SnJWQjA3L3Uzd0ha?=
 =?utf-8?B?WXNLL2huejdyQmVRNjg2cUd6eEsyamdkQ2duTDVMQ3VYYm1WUU55a0dEcWRD?=
 =?utf-8?B?RDluZ1ZHbG9uZXo2U2c4R1lvV1BmL0ZJbXpnUHpkZWtMK2NHWWFYSWkxWm9G?=
 =?utf-8?B?ZlJPeXdmWGJ4eHE2UkQ5eGRTMVdUMjlxV2xxUkpvTWs3NzBBd0VxS0xXSUxh?=
 =?utf-8?B?OTV2VFl3TmJka0RHanJscldIR0JtMksxR2dOVFNUZ3lQR0ZOYkRrcU9KZXM5?=
 =?utf-8?B?N0dxaTVIWEw4N05vRy83c2hxcWRWZUpDQW1heUVxMW0yL2dLV0k1WVJ2UWc0?=
 =?utf-8?B?enRFcGgrZzJCWVVRK0NLQkVnL29mODNjcnlnSmV1cUxnVDhGTVBSZDRSNU5Y?=
 =?utf-8?B?WlZUWlJkUDlQRktndmZSdHhYTUt2bnF2bitVNnFZY1BJS3JjOGhFd2V2TTBV?=
 =?utf-8?B?bkJpTEh5N1Jyb29vNFRFdWdISFhVb1lBNmROZVVlR0gzejU3eUdzRUd6NGY3?=
 =?utf-8?B?ellxc256Mi9GcVcxRDBraVdUQWMvdHdaLzNwT1NaamROL2p4RlE5RkdMT0xn?=
 =?utf-8?B?UUI5WFQ0K3FwWlMvbHVQcXcwZUdBS3ZHakU5ZkowNVRFTHl6NXdYa0NZV2ls?=
 =?utf-8?B?MjhIR1BWWHFZZFkvT3lEZmtKVkFlcUNheVJaL1gyQVFBbU9xb3cyQy81ZDB3?=
 =?utf-8?B?UXlqY3FrbXF6c01McDl4TnF3OUE2Wk4vMENGVTkzeVNwUExpOGYyTVNmaFBR?=
 =?utf-8?B?bnhVUGIwbDRRWktTRGViSldEUS9GL3lGZ21Fai95WVlLazlDWkE4b1BEYkpL?=
 =?utf-8?B?dnpFWEdmU29RNDBFVHczZmZsK281OERuZ2lYWlZjMFhRWFZ0L2Nxb1BManRK?=
 =?utf-8?B?cnhJMU9VMkhoUm9XQThOU0RNN3JGLytzcktPY01qMnlJdE5tck82ekdrVXlO?=
 =?utf-8?B?WDVpWXdBNTNoU21uWkFnNlUrUVZraThEdVZ3Y3hLZm5HL1RrbkZtWGJGZkMv?=
 =?utf-8?B?ODlWZWNOcGFrRTFPL2tpb2pPQUtiVDhJeEFJcGFwbTd2WU5pWkFxaE80VVFV?=
 =?utf-8?B?QUx1NDdRU0xDelk4c2pmSmoyUDN3K3JkR0FsbDN1eGkweU5IVW5iL3llckVG?=
 =?utf-8?B?dUZSc0VybUI3U2t2TzZBZzZxaFZDUUJ4SHJHcTcwWWhveEJMS3h2TnRGWEtw?=
 =?utf-8?B?bEdGdEh3Y0QrdHVma3AxdjZuekM3cHBtOG9uUmJhTEtFRVFyMmVwSkJJZGNV?=
 =?utf-8?B?a2FJdzhuc0pMZFEyRUR3TGd3NG9YY3pVb0pOeExtZVhCaDJjL21idjN2VFlZ?=
 =?utf-8?B?bDNaMHgxQmVPb1hNak5EcHEvM0VaeVVDa2lrMlQ2a2JETWJTQjZ0UnBUTnFj?=
 =?utf-8?B?clNUTi9PMjgrcEI5OWlVaG1ObUpWVk1mSXNQc3djcUhsMldncTZ2a0ZEZDRU?=
 =?utf-8?B?S1BMczQ2SjNmY0VIa3kwSVNaM0s3eENpbXFndnFwUGdNMVBZYm8vVmtSRkNU?=
 =?utf-8?B?MThNZis1TU9UTm9CWk1LS0FLd2J6VXkrb3pjWCs0VGtHcU0yYzhhMTNSU21S?=
 =?utf-8?B?ZlczaGQ3NXNiVUt4VnREbXlJTkpSM2pZekQrK0xQNkhIRXNYYmlBU1IvT0Ry?=
 =?utf-8?B?bzBaL1hJaGdKd3hURDFqL0JoSlVGVGdtK1R4TStTdzlhVUY1YjljNnlEYVNl?=
 =?utf-8?B?UnlnVWZnRVBjbTBoQXlBTEpIdjUxMHhCbnpSM0MyOU82Q3JuUVU2dz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a0e9a12-6f26-42dd-4431-08deb56ea56f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 06:19:56.4787 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OPecQmSukH4j9cwKZvKKTacSJmHx+7t2H1VXK/GysopdIr1BLOqOUfi6mFml0dlv3zxo/fYGxMpkObnChKCHew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9453
X-Mailman-Approved-At: Tue, 19 May 2026 14:56:05 +0200
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

From: Alice Guo <alice.guo@nxp.com>

Migrate i.MX91 boards to use OF_UPSTREAM feature, which allows U-Boot
to directly use device trees from the Linux kernel upstream.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/imx91-11x11-evk.dts             | 875 ---------------------------
 arch/arm/dts/imx91-11x11-frdm.dts            | 773 -----------------------
 arch/arm/dts/imx91-pinfunc.h                 | 770 -----------------------
 arch/arm/dts/imx91.dtsi                      |  53 --
 arch/arm/mach-imx/imx9/Kconfig               |   2 +
 configs/imx91_11x11_evk_defconfig            |   2 +-
 configs/imx91_11x11_evk_inline_ecc_defconfig |   2 +-
 configs/imx91_11x11_frdm_defconfig           |   2 +-
 8 files changed, 5 insertions(+), 2474 deletions(-)

diff --git a/arch/arm/dts/imx91-11x11-evk.dts b/arch/arm/dts/imx91-11x11-evk.dts
deleted file mode 100644
index ca9070a4c76..00000000000
--- a/arch/arm/dts/imx91-11x11-evk.dts
+++ /dev/null
@@ -1,875 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2024 NXP
- */
-
-/dts-v1/;
-
-#include <dt-bindings/usb/pd.h>
-#include "imx91.dtsi"
-
-/ {
-	compatible = "fsl,imx91-11x11-evk", "fsl,imx91";
-	model = "NXP i.MX91 11X11 EVK board";
-
-	aliases {
-		ethernet0 = &fec;
-		ethernet1 = &eqos;
-		rtc0 = &bbnsm_rtc;
-	};
-
-	chosen {
-		stdout-path = &lpuart1;
-	};
-
-	reg_vref_1v8: regulator-adc-vref {
-		compatible = "regulator-fixed";
-		regulator-max-microvolt = <1800000>;
-		regulator-min-microvolt = <1800000>;
-		regulator-name = "vref_1v8";
-	};
-
-	reg_audio_pwr: regulator-audio-pwr {
-		compatible = "regulator-fixed";
-		regulator-always-on;
-		regulator-max-microvolt = <3300000>;
-		regulator-min-microvolt = <3300000>;
-		regulator-name = "audio-pwr";
-		gpio = <&adp5585 1 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	reg_usdhc2_vmmc: regulator-usdhc2 {
-		compatible = "regulator-fixed";
-		off-on-delay-us = <12000>;
-		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
-		pinctrl-names = "default";
-		regulator-max-microvolt = <3300000>;
-		regulator-min-microvolt = <3300000>;
-		regulator-name = "VSD_3V3";
-		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	reg_usdhc3_vmmc: regulator-usdhc3 {
-		compatible = "regulator-fixed";
-		regulator-max-microvolt = <3300000>;
-		regulator-min-microvolt = <3300000>;
-		regulator-name = "WLAN_EN";
-		gpio = <&pcal6524 20 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		/*
-		 * IW612 wifi chip needs more delay than other wifi chips to complete
-		 * the host interface initialization after power up, otherwise the
-		 * internal state of IW612 may be unstable, resulting in the failure of
-		 * the SDIO3.0 switch voltage.
-		 */
-		startup-delay-us = <20000>;
-	};
-
-	reg_vdd_12v: regulator-vdd-12v {
-		compatible = "regulator-fixed";
-		regulator-max-microvolt = <12000000>;
-		regulator-min-microvolt = <12000000>;
-		regulator-name = "reg_vdd_12v";
-		gpio = <&pcal6524 14 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	reg_vrpi_3v3: regulator-vrpi-3v3 {
-		compatible = "regulator-fixed";
-		regulator-max-microvolt = <3300000>;
-		regulator-min-microvolt = <3300000>;
-		regulator-name = "VRPI_3V3";
-		vin-supply = <&buck4>;
-		gpio = <&pcal6524 2 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	reg_vrpi_5v: regulator-vrpi-5v {
-		compatible = "regulator-fixed";
-		regulator-max-microvolt = <5000000>;
-		regulator-min-microvolt = <5000000>;
-		regulator-name = "VRPI_5V";
-		gpio = <&pcal6524 8 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	reserved-memory {
-		ranges;
-		#address-cells = <2>;
-		#size-cells = <2>;
-
-		linux,cma {
-			compatible = "shared-dma-pool";
-			alloc-ranges = <0 0x80000000 0 0x40000000>;
-			reusable;
-			size = <0 0x10000000>;
-			linux,cma-default;
-		};
-	};
-};
-
-&adc1 {
-	vref-supply = <&reg_vref_1v8>;
-	status = "okay";
-};
-
-&eqos {
-	phy-handle = <&ethphy1>;
-	phy-mode = "rgmii-id";
-	pinctrl-0 = <&pinctrl_eqos>;
-	pinctrl-1 = <&pinctrl_eqos_sleep>;
-	pinctrl-names = "default", "sleep";
-	status = "okay";
-
-	mdio {
-		compatible = "snps,dwmac-mdio";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clock-frequency = <5000000>;
-
-		ethphy1: ethernet-phy@1 {
-			reg = <1>;
-			eee-broken-1000t;
-		};
-	};
-};
-
-&fec {
-	phy-handle = <&ethphy2>;
-	phy-mode = "rgmii-id";
-	pinctrl-0 = <&pinctrl_fec>;
-	pinctrl-1 = <&pinctrl_fec_sleep>;
-	pinctrl-names = "default", "sleep";
-	fsl,magic-packet;
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clock-frequency = <5000000>;
-
-		ethphy2: ethernet-phy@2 {
-			reg = <2>;
-			eee-broken-1000t;
-		};
-	};
-};
-
-/*
- * When add, delete or change any target device setting in &lpi2c1,
- * please synchronize the changes to the &i3c1 bus in imx91-11x11-evk-i3c.dts.
- */
-&lpi2c1 {
-	clock-frequency = <400000>;
-	pinctrl-0 = <&pinctrl_lpi2c1>;
-	pinctrl-names = "default";
-	status = "okay";
-
-	codec: wm8962@1a {
-		compatible = "wlf,wm8962";
-		reg = <0x1a>;
-		clocks = <&clk IMX93_CLK_SAI3_GATE>;
-		AVDD-supply = <&reg_audio_pwr>;
-		CPVDD-supply = <&reg_audio_pwr>;
-		DBVDD-supply = <&reg_audio_pwr>;
-		DCVDD-supply = <&reg_audio_pwr>;
-		MICVDD-supply = <&reg_audio_pwr>;
-		PLLVDD-supply = <&reg_audio_pwr>;
-		SPKVDD1-supply = <&reg_audio_pwr>;
-		SPKVDD2-supply = <&reg_audio_pwr>;
-		gpio-cfg = <
-			0x0000 /* 0:Default */
-			0x0000 /* 1:Default */
-			0x0000 /* 2:FN_DMICCLK */
-			0x0000 /* 3:Default */
-			0x0000 /* 4:FN_DMICCDAT */
-			0x0000 /* 5:Default */
-		>;
-	};
-
-	lsm6dsm@6a {
-		compatible = "st,lsm6dso";
-		reg = <0x6a>;
-	};
-};
-
-&lpi2c2 {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	clock-frequency = <400000>;
-	pinctrl-0 = <&pinctrl_lpi2c2>;
-	pinctrl-names = "default";
-	status = "okay";
-
-	pcal6524: gpio@22 {
-		compatible = "nxp,pcal6524";
-		reg = <0x22>;
-		#interrupt-cells = <2>;
-		interrupt-controller;
-		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
-		#gpio-cells = <2>;
-		gpio-controller;
-		interrupt-parent = <&gpio3>;
-		pinctrl-0 = <&pinctrl_pcal6524>;
-		pinctrl-names = "default";
-	};
-
-	pmic@25 {
-		compatible = "nxp,pca9451a";
-		reg = <0x25>;
-		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
-		interrupt-parent = <&pcal6524>;
-
-		regulators {
-
-			buck1: BUCK1 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-max-microvolt = <2237500>;
-				regulator-min-microvolt = <650000>;
-				regulator-name = "BUCK1";
-				regulator-ramp-delay = <3125>;
-			};
-
-			buck2: BUCK2 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-max-microvolt = <2187500>;
-				regulator-min-microvolt = <600000>;
-				regulator-name = "BUCK2";
-				regulator-ramp-delay = <3125>;
-			};
-
-			buck4: BUCK4 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-max-microvolt = <3400000>;
-				regulator-min-microvolt = <600000>;
-				regulator-name = "BUCK4";
-			};
-
-			buck5: BUCK5 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-max-microvolt = <3400000>;
-				regulator-min-microvolt = <600000>;
-				regulator-name = "BUCK5";
-			};
-
-			buck6: BUCK6 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-max-microvolt = <3400000>;
-				regulator-min-microvolt = <600000>;
-				regulator-name = "BUCK6";
-			};
-
-			ldo1: LDO1 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-max-microvolt = <3300000>;
-				regulator-min-microvolt = <1600000>;
-				regulator-name = "LDO1";
-			};
-
-			ldo4: LDO4 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-max-microvolt = <3300000>;
-				regulator-min-microvolt = <800000>;
-				regulator-name = "LDO4";
-			};
-
-			ldo5: LDO5 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-max-microvolt = <3300000>;
-				regulator-min-microvolt = <1800000>;
-				regulator-name = "LDO5";
-			};
-		};
-	};
-
-	adp5585: io-expander@34 {
-		compatible = "adi,adp5585-00", "adi,adp5585";
-		reg = <0x34>;
-		#gpio-cells = <2>;
-		gpio-controller;
-		#pwm-cells = <3>;
-		gpio-reserved-ranges = <5 1>;
-
-		exp-sel-hog {
-			gpio-hog;
-			gpios = <4 GPIO_ACTIVE_HIGH>;
-			output-low;
-		};
-	};
-};
-
-&lpi2c3 {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	clock-frequency = <400000>;
-	pinctrl-0 = <&pinctrl_lpi2c3>;
-	pinctrl-names = "default";
-	status = "okay";
-
-	ptn5110: tcpc@50 {
-		compatible = "nxp,ptn5110", "tcpci";
-		reg = <0x50>;
-		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
-		interrupt-parent = <&gpio3>;
-		status = "okay";
-
-		typec1_con: connector {
-			compatible = "usb-c-connector";
-			data-role = "dual";
-			label = "USB-C";
-			op-sink-microwatt = <15000000>;
-			power-role = "dual";
-			self-powered;
-			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
-				     PDO_VAR(5000, 20000, 3000)>;
-			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
-			try-power-role = "sink";
-
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				port@0 {
-					reg = <0>;
-
-					typec1_dr_sw: endpoint {
-						remote-endpoint = <&usb1_drd_sw>;
-					};
-				};
-			};
-		};
-	};
-
-	ptn5110_2: tcpc@51 {
-		compatible = "nxp,ptn5110", "tcpci";
-		reg = <0x51>;
-		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
-		interrupt-parent = <&gpio3>;
-		status = "okay";
-
-		typec2_con: connector {
-			compatible = "usb-c-connector";
-			data-role = "dual";
-			label = "USB-C";
-			op-sink-microwatt = <15000000>;
-			power-role = "dual";
-			self-powered;
-			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
-				     PDO_VAR(5000, 20000, 3000)>;
-			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
-			try-power-role = "sink";
-
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				port@0 {
-					reg = <0>;
-
-					typec2_dr_sw: endpoint {
-						remote-endpoint = <&usb2_drd_sw>;
-					};
-				};
-			};
-		};
-	};
-
-	pcf2131: rtc@53 {
-		compatible = "nxp,pcf2131";
-		reg = <0x53>;
-		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
-		interrupt-parent = <&pcal6524>;
-		status = "okay";
-	};
-};
-
-&lpuart1 {
-	pinctrl-0 = <&pinctrl_uart1>;
-	pinctrl-names = "default";
-	status = "okay";
-};
-
-&lpuart5 {
-	pinctrl-0 = <&pinctrl_uart5>;
-	pinctrl-names = "default";
-	status = "okay";
-};
-
-&usbotg1 {
-	adp-disable;
-	disable-over-current;
-	dr_mode = "otg";
-	hnp-disable;
-	srp-disable;
-	usb-role-switch;
-	samsung,picophy-dc-vol-level-adjust = <7>;
-	samsung,picophy-pre-emp-curr-control = <3>;
-	status = "okay";
-
-	port {
-		usb1_drd_sw: endpoint {
-			remote-endpoint = <&typec1_dr_sw>;
-		};
-	};
-};
-
-&usbotg2 {
-	adp-disable;
-	disable-over-current;
-	dr_mode = "otg";
-	hnp-disable;
-	srp-disable;
-	usb-role-switch;
-	samsung,picophy-dc-vol-level-adjust = <7>;
-	samsung,picophy-pre-emp-curr-control = <3>;
-	status = "okay";
-
-	port {
-		usb2_drd_sw: endpoint {
-			remote-endpoint = <&typec2_dr_sw>;
-		};
-	};
-};
-
-&usdhc1 {
-	bus-width = <8>;
-	non-removable;
-	pinctrl-0 = <&pinctrl_usdhc1>;
-	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
-	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	status = "okay";
-};
-
-&usdhc2 {
-	bus-width = <4>;
-	cd-gpios = <&gpio3 00 GPIO_ACTIVE_LOW>;
-	no-mmc;
-	no-sdio;
-	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-3 = <&pinctrl_usdhc2_sleep>, <&pinctrl_usdhc2_gpio_sleep>;
-	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
-	vmmc-supply = <&reg_usdhc2_vmmc>;
-	status = "okay";
-};
-
-&wdog3 {
-	fsl,ext-reset-output;
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl_eqos: eqosgrp {
-		fsl,pins = <
-			MX91_PAD_ENET1_MDC__ENET1_MDC			0x57e
-			MX91_PAD_ENET1_MDIO__ENET_QOS_MDIO			0x57e
-			MX91_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0			0x57e
-			MX91_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1			0x57e
-			MX91_PAD_ENET1_RD2__ENET_QOS_RGMII_RD2			0x57e
-			MX91_PAD_ENET1_RD3__ENET_QOS_RGMII_RD3			0x57e
-			MX91_PAD_ENET1_RXC__ENET_QOS_RGMII_RXC	0x5fe
-			MX91_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL		0x57e
-			MX91_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0			0x57e
-			MX91_PAD_ENET1_TD1__ENET1_RGMII_TD1			0x57e
-			MX91_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2			0x57e
-			MX91_PAD_ENET1_TD3__ENET_QOS_RGMII_TD3			0x57e
-			MX91_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x5fe
-			MX91_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL		0x57e
-		>;
-	};
-
-	pinctrl_eqos_sleep: eqossleepgrp {
-		fsl,pins = <
-			MX91_PAD_ENET1_MDC__GPIO4_IO0				0x31e
-			MX91_PAD_ENET1_MDIO__GPIO4_IO1				0x31e
-			MX91_PAD_ENET1_RD0__GPIO4_IO10                          0x31e
-			MX91_PAD_ENET1_RD1__GPIO4_IO11				0x31e
-			MX91_PAD_ENET1_RD2__GPIO4_IO12				0x31e
-			MX91_PAD_ENET1_RD3__GPIO4_IO13				0x31e
-			MX91_PAD_ENET1_RXC__GPIO4_IO9                          0x31e
-			MX91_PAD_ENET1_RX_CTL__GPIO4_IO8			0x31e
-			MX91_PAD_ENET1_TD0__GPIO4_IO5                          0x31e
-			MX91_PAD_ENET1_TD1__GPIO4_IO4                          0x31e
-			MX91_PAD_ENET1_TD2__GPIO4_IO3				0x31e
-			MX91_PAD_ENET1_TD3__GPIO4_IO2				0x31e
-			MX91_PAD_ENET1_TXC__GPIO4_IO7                          0x31e
-			MX91_PAD_ENET1_TX_CTL__GPIO4_IO6                       0x31e
-		>;
-	};
-
-	pinctrl_fec: fecgrp {
-		fsl,pins = <
-			MX91_PAD_ENET2_MDC__ENET2_MDC			0x57e
-			MX91_PAD_ENET2_MDIO__ENET2_MDIO			0x57e
-			MX91_PAD_ENET2_RD0__ENET2_RGMII_RD0		0x57e
-			MX91_PAD_ENET2_RD1__ENET2_RGMII_RD1		0x57e
-			MX91_PAD_ENET2_RD2__ENET2_RGMII_RD2		0x57e
-			MX91_PAD_ENET2_RD3__ENET2_RGMII_RD3		0x57e
-			MX91_PAD_ENET2_RXC__ENET2_RGMII_RXC		0x5fe
-			MX91_PAD_ENET2_RX_CTL__ENET2_RGMII_RX_CTL	0x57e
-			MX91_PAD_ENET2_TD0__ENET2_RGMII_TD0		0x57e
-			MX91_PAD_ENET2_TD1__ENET2_RGMII_TD1		0x57e
-			MX91_PAD_ENET2_TD2__ENET2_RGMII_TD2		0x57e
-			MX91_PAD_ENET2_TD3__ENET2_RGMII_TD3		0x57e
-			MX91_PAD_ENET2_TXC__ENET2_RGMII_TXC		0x5fe
-			MX91_PAD_ENET2_TX_CTL__ENET2_RGMII_TX_CTL	0x57e
-		>;
-	};
-
-	pinctrl_fec_sleep: fecsleepgrp {
-		fsl,pins = <
-			MX91_PAD_ENET2_MDC__GPIO4_IO14			0x51e
-			MX91_PAD_ENET2_MDIO__GPIO4_IO15			0x51e
-			MX91_PAD_ENET2_RD0__GPIO4_IO24			0x51e
-			MX91_PAD_ENET2_RD1__GPIO4_IO25			0x51e
-			MX91_PAD_ENET2_RD2__GPIO4_IO26			0x51e
-			MX91_PAD_ENET2_RD3__GPIO4_IO27			0x51e
-			MX91_PAD_ENET2_RXC__GPIO4_IO23			0x51e
-			MX91_PAD_ENET2_RX_CTL__GPIO4_IO22		0x51e
-			MX91_PAD_ENET2_TD0__GPIO4_IO19			0x51e
-			MX91_PAD_ENET2_TD1__GPIO4_IO18			0x51e
-			MX91_PAD_ENET2_TD2__GPIO4_IO17			0x51e
-			MX91_PAD_ENET2_TD3__GPIO4_IO16			0x51e
-			MX91_PAD_ENET2_TXC__GPIO4_IO21			0x51e
-			MX91_PAD_ENET2_TX_CTL__GPIO4_IO20		0x51e
-		>;
-	};
-
-	pinctrl_flexcan2: flexcan2grp {
-		fsl,pins = <
-			MX91_PAD_GPIO_IO25__CAN2_TX	0x139e
-			MX91_PAD_GPIO_IO27__CAN2_RX	0x139e
-		>;
-	};
-
-	pinctrl_flexcan2_sleep: flexcan2sleepgrp {
-		fsl,pins = <
-			MX91_PAD_GPIO_IO25__GPIO2_IO25  0x31e
-			MX91_PAD_GPIO_IO27__GPIO2_IO27	0x31e
-		>;
-	};
-
-	pinctrl_lcdif_gpio: lcdifgpiogrp {
-		fsl,pins = <
-			MX91_PAD_GPIO_IO00__GPIO2_IO0			0x51e
-			MX91_PAD_GPIO_IO01__GPIO2_IO1			0x51e
-			MX91_PAD_GPIO_IO02__GPIO2_IO2			0x51e
-			MX91_PAD_GPIO_IO03__GPIO2_IO3			0x51e
-		>;
-	};
-
-	pinctrl_lcdif: lcdifgrp {
-		fsl,pins = <
-			MX91_PAD_GPIO_IO00__MEDIAMIX_DISP_CLK		0x31e
-			MX91_PAD_GPIO_IO01__MEDIAMIX_DISP_DE		0x31e
-			MX91_PAD_GPIO_IO02__MEDIAMIX_DISP_VSYNC		0x31e
-			MX91_PAD_GPIO_IO03__MEDIAMIX_DISP_HSYNC		0x31e
-			MX91_PAD_GPIO_IO04__MEDIAMIX_DISP_DATA0		0x31e
-			MX91_PAD_GPIO_IO05__MEDIAMIX_DISP_DATA1		0x31e
-			MX91_PAD_GPIO_IO06__MEDIAMIX_DISP_DATA2		0x31e
-			MX91_PAD_GPIO_IO07__MEDIAMIX_DISP_DATA3		0x31e
-			MX91_PAD_GPIO_IO08__MEDIAMIX_DISP_DATA4		0x31e
-			MX91_PAD_GPIO_IO09__MEDIAMIX_DISP_DATA5		0x31e
-			MX91_PAD_GPIO_IO10__MEDIAMIX_DISP_DATA6		0x31e
-			MX91_PAD_GPIO_IO11__MEDIAMIX_DISP_DATA7		0x31e
-			MX91_PAD_GPIO_IO12__MEDIAMIX_DISP_DATA8		0x31e
-			MX91_PAD_GPIO_IO13__MEDIAMIX_DISP_DATA9		0x31e
-			MX91_PAD_GPIO_IO14__MEDIAMIX_DISP_DATA10	0x31e
-			MX91_PAD_GPIO_IO15__MEDIAMIX_DISP_DATA11	0x31e
-			MX91_PAD_GPIO_IO16__MEDIAMIX_DISP_DATA12	0x31e
-			MX91_PAD_GPIO_IO17__MEDIAMIX_DISP_DATA13	0x31e
-			MX91_PAD_GPIO_IO18__MEDIAMIX_DISP_DATA14	0x31e
-			MX91_PAD_GPIO_IO19__MEDIAMIX_DISP_DATA15	0x31e
-			MX91_PAD_GPIO_IO20__MEDIAMIX_DISP_DATA16	0x31e
-			MX91_PAD_GPIO_IO21__MEDIAMIX_DISP_DATA17	0x31e
-			MX91_PAD_GPIO_IO27__GPIO2_IO27			0x31e
-		>;
-	};
-
-	pinctrl_lpi2c1: lpi2c1grp {
-		fsl,pins = <
-			MX91_PAD_I2C1_SCL__LPI2C1_SCL			0x40000b9e
-			MX91_PAD_I2C1_SDA__LPI2C1_SDA			0x40000b9e
-		>;
-	};
-
-	pinctrl_lpi2c2: lpi2c2grp {
-		fsl,pins = <
-			MX91_PAD_I2C2_SCL__LPI2C2_SCL			0x40000b9e
-			MX91_PAD_I2C2_SDA__LPI2C2_SDA			0x40000b9e
-		>;
-	};
-
-	pinctrl_lpi2c3: lpi2c3grp {
-		fsl,pins = <
-			MX91_PAD_GPIO_IO28__LPI2C3_SDA			0x40000b9e
-			MX91_PAD_GPIO_IO29__LPI2C3_SCL			0x40000b9e
-		>;
-	};
-
-	pinctrl_pcal6524: pcal6524grp {
-		fsl,pins = <
-			MX91_PAD_CCM_CLKO2__GPIO3_IO27			0x31e
-		>;
-	};
-
-	pinctrl_pdm: pdmgrp {
-		fsl,pins = <
-			MX91_PAD_PDM_CLK__PDM_CLK			0x31e
-			MX91_PAD_PDM_BIT_STREAM0__PDM_BIT_STREAM0	0x31e
-			MX91_PAD_PDM_BIT_STREAM1__PDM_BIT_STREAM1	0x31e
-		>;
-	};
-
-	pinctrl_pdm_sleep: pdmsleepgrp {
-		fsl,pins = <
-			MX91_PAD_PDM_CLK__GPIO1_IO8			0x31e
-			MX91_PAD_PDM_BIT_STREAM0__GPIO1_IO9		0x31e
-			MX91_PAD_PDM_BIT_STREAM1__GPIO1_IO10		0x31e
-		>;
-	};
-
-	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
-		fsl,pins = <
-			MX91_PAD_SD2_RESET_B__GPIO3_IO7	0x31e
-		>;
-	};
-
-	pinctrl_sai1: sai1grp {
-		fsl,pins = <
-			MX91_PAD_SAI1_TXC__SAI1_TX_BCLK			0x31e
-			MX91_PAD_SAI1_TXFS__SAI1_TX_SYNC		0x31e
-			MX91_PAD_SAI1_TXD0__SAI1_TX_DATA0		0x31e
-			MX91_PAD_SAI1_RXD0__SAI1_RX_DATA0		0x31e
-		>;
-	};
-
-	pinctrl_sai1_sleep: sai1sleepgrp {
-		fsl,pins = <
-			MX91_PAD_SAI1_TXC__GPIO1_IO12                   0x51e
-			MX91_PAD_SAI1_TXFS__GPIO1_IO11			0x51e
-			MX91_PAD_SAI1_TXD0__GPIO1_IO13			0x51e
-			MX91_PAD_SAI1_RXD0__GPIO1_IO14			0x51e
-		>;
-	};
-
-	pinctrl_sai3: sai3grp {
-		fsl,pins = <
-			MX91_PAD_GPIO_IO26__SAI3_TX_SYNC		0x31e
-			MX91_PAD_GPIO_IO16__SAI3_TX_BCLK		0x31e
-			MX91_PAD_GPIO_IO17__SAI3_MCLK			0x31e
-			MX91_PAD_GPIO_IO19__SAI3_TX_DATA0		0x31e
-			MX91_PAD_GPIO_IO20__SAI3_RX_DATA0		0x31e
-		>;
-	};
-
-	pinctrl_sai3_sleep: sai3sleepgrp {
-		fsl,pins = <
-			MX91_PAD_GPIO_IO26__GPIO2_IO26			0x51e
-			MX91_PAD_GPIO_IO16__GPIO2_IO16			0x51e
-			MX91_PAD_GPIO_IO17__GPIO2_IO17			0x51e
-			MX91_PAD_GPIO_IO19__GPIO2_IO19			0x51e
-			MX91_PAD_GPIO_IO20__GPIO2_IO20			0x51e
-		>;
-	};
-
-	pinctrl_spdif: spdifgrp {
-		fsl,pins = <
-			MX91_PAD_GPIO_IO22__SPDIF_IN		0x31e
-			MX91_PAD_GPIO_IO23__SPDIF_OUT		0x31e
-		>;
-	};
-
-	pinctrl_spdif_sleep: spdifsleepgrp {
-		fsl,pins = <
-			MX91_PAD_GPIO_IO22__GPIO2_IO22		0x31e
-			MX91_PAD_GPIO_IO23__GPIO2_IO23		0x31e
-		>;
-	};
-
-	pinctrl_uart1: uart1grp {
-		fsl,pins = <
-			MX91_PAD_UART1_RXD__LPUART1_RX			0x31e
-			MX91_PAD_UART1_TXD__LPUART1_TX			0x31e
-		>;
-	};
-
-	pinctrl_uart5: uart5grp {
-		fsl,pins = <
-			MX91_PAD_DAP_TDO_TRACESWO__LPUART5_TX	0x31e
-			MX91_PAD_DAP_TDI__LPUART5_RX		0x31e
-			MX91_PAD_DAP_TMS_SWDIO__LPUART5_RTS_B	0x31e
-			MX91_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B	0x31e
-		>;
-	};
-
-	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
-		fsl,pins = <
-			MX91_PAD_SD1_CLK__USDHC1_CLK		0x158e
-			MX91_PAD_SD1_CMD__USDHC1_CMD		0x138e
-			MX91_PAD_SD1_DATA0__USDHC1_DATA0	0x138e
-			MX91_PAD_SD1_DATA1__USDHC1_DATA1	0x138e
-			MX91_PAD_SD1_DATA2__USDHC1_DATA2	0x138e
-			MX91_PAD_SD1_DATA3__USDHC1_DATA3	0x138e
-			MX91_PAD_SD1_DATA4__USDHC1_DATA4	0x138e
-			MX91_PAD_SD1_DATA5__USDHC1_DATA5	0x138e
-			MX91_PAD_SD1_DATA6__USDHC1_DATA6	0x138e
-			MX91_PAD_SD1_DATA7__USDHC1_DATA7	0x138e
-			MX91_PAD_SD1_STROBE__USDHC1_STROBE	0x158e
-		>;
-	};
-
-	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
-		fsl,pins = <
-			MX91_PAD_SD1_CLK__USDHC1_CLK		0x15fe
-			MX91_PAD_SD1_CMD__USDHC1_CMD		0x13fe
-			MX91_PAD_SD1_DATA0__USDHC1_DATA0	0x13fe
-			MX91_PAD_SD1_DATA1__USDHC1_DATA1	0x13fe
-			MX91_PAD_SD1_DATA2__USDHC1_DATA2	0x13fe
-			MX91_PAD_SD1_DATA3__USDHC1_DATA3	0x13fe
-			MX91_PAD_SD1_DATA4__USDHC1_DATA4	0x13fe
-			MX91_PAD_SD1_DATA5__USDHC1_DATA5	0x13fe
-			MX91_PAD_SD1_DATA6__USDHC1_DATA6	0x13fe
-			MX91_PAD_SD1_DATA7__USDHC1_DATA7	0x13fe
-			MX91_PAD_SD1_STROBE__USDHC1_STROBE	0x15fe
-		>;
-	};
-
-	pinctrl_usdhc1: usdhc1grp {
-		fsl,pins = <
-			MX91_PAD_SD1_CLK__USDHC1_CLK		0x1582
-			MX91_PAD_SD1_CMD__USDHC1_CMD		0x1382
-			MX91_PAD_SD1_DATA0__USDHC1_DATA0	0x1382
-			MX91_PAD_SD1_DATA1__USDHC1_DATA1	0x1382
-			MX91_PAD_SD1_DATA2__USDHC1_DATA2	0x1382
-			MX91_PAD_SD1_DATA3__USDHC1_DATA3	0x1382
-			MX91_PAD_SD1_DATA4__USDHC1_DATA4	0x1382
-			MX91_PAD_SD1_DATA5__USDHC1_DATA5	0x1382
-			MX91_PAD_SD1_DATA6__USDHC1_DATA6	0x1382
-			MX91_PAD_SD1_DATA7__USDHC1_DATA7	0x1382
-			MX91_PAD_SD1_STROBE__USDHC1_STROBE	0x1582
-		>;
-	};
-
-	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
-		fsl,pins = <
-			MX91_PAD_SD2_CLK__USDHC2_CLK		0x158e
-			MX91_PAD_SD2_CMD__USDHC2_CMD		0x138e
-			MX91_PAD_SD2_DATA0__USDHC2_DATA0	0x138e
-			MX91_PAD_SD2_DATA1__USDHC2_DATA1	0x138e
-			MX91_PAD_SD2_DATA2__USDHC2_DATA2	0x138e
-			MX91_PAD_SD2_DATA3__USDHC2_DATA3	0x138e
-			MX91_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
-		>;
-	};
-
-	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
-		fsl,pins = <
-			MX91_PAD_SD2_CLK__USDHC2_CLK		0x15fe
-			MX91_PAD_SD2_CMD__USDHC2_CMD		0x13fe
-			MX91_PAD_SD2_DATA0__USDHC2_DATA0	0x13fe
-			MX91_PAD_SD2_DATA1__USDHC2_DATA1	0x13fe
-			MX91_PAD_SD2_DATA2__USDHC2_DATA2	0x13fe
-			MX91_PAD_SD2_DATA3__USDHC2_DATA3	0x13fe
-			MX91_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
-		>;
-	};
-
-	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
-		fsl,pins = <
-			MX91_PAD_SD2_CD_B__GPIO3_IO0		0x31e
-		>;
-	};
-
-	pinctrl_usdhc2_gpio_sleep: usdhc2gpiosleepgrp {
-		fsl,pins = <
-			MX91_PAD_SD2_CD_B__GPIO3_IO0		0x51e
-		>;
-	};
-
-	pinctrl_usdhc2: usdhc2grp {
-		fsl,pins = <
-			MX91_PAD_SD2_CLK__USDHC2_CLK		0x1582
-			MX91_PAD_SD2_CMD__USDHC2_CMD		0x1382
-			MX91_PAD_SD2_DATA0__USDHC2_DATA0	0x1382
-			MX91_PAD_SD2_DATA1__USDHC2_DATA1	0x1382
-			MX91_PAD_SD2_DATA2__USDHC2_DATA2	0x1382
-			MX91_PAD_SD2_DATA3__USDHC2_DATA3	0x1382
-			MX91_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
-		>;
-	};
-
-	pinctrl_usdhc2_sleep: usdhc2sleepgrp {
-		fsl,pins = <
-			MX91_PAD_SD2_CLK__GPIO3_IO1            0x51e
-			MX91_PAD_SD2_CMD__GPIO3_IO2		0x51e
-			MX91_PAD_SD2_DATA0__GPIO3_IO3		0x51e
-			MX91_PAD_SD2_DATA1__GPIO3_IO4		0x51e
-			MX91_PAD_SD2_DATA2__GPIO3_IO5		0x51e
-			MX91_PAD_SD2_DATA3__GPIO3_IO6		0x51e
-			MX91_PAD_SD2_VSELECT__GPIO3_IO19	0x51e
-		>;
-	};
-
-	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
-		fsl,pins = <
-			MX91_PAD_SD3_CLK__USDHC3_CLK		0x158e
-			MX91_PAD_SD3_CMD__USDHC3_CMD		0x138e
-			MX91_PAD_SD3_DATA0__USDHC3_DATA0	0x138e
-			MX91_PAD_SD3_DATA1__USDHC3_DATA1	0x138e
-			MX91_PAD_SD3_DATA2__USDHC3_DATA2	0x138e
-			MX91_PAD_SD3_DATA3__USDHC3_DATA3	0x138e
-		>;
-	};
-
-	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
-		fsl,pins = <
-			MX91_PAD_SD3_CLK__USDHC3_CLK		0x15fe
-			MX91_PAD_SD3_CMD__USDHC3_CMD		0x13fe
-			MX91_PAD_SD3_DATA0__USDHC3_DATA0	0x13fe
-			MX91_PAD_SD3_DATA1__USDHC3_DATA1	0x13fe
-			MX91_PAD_SD3_DATA2__USDHC3_DATA2	0x13fe
-			MX91_PAD_SD3_DATA3__USDHC3_DATA3	0x13fe
-		>;
-	};
-
-	pinctrl_usdhc3: usdhc3grp {
-		fsl,pins = <
-			MX91_PAD_SD3_CLK__USDHC3_CLK		0x1582
-			MX91_PAD_SD3_CMD__USDHC3_CMD		0x1382
-			MX91_PAD_SD3_DATA0__USDHC3_DATA0	0x1382
-			MX91_PAD_SD3_DATA1__USDHC3_DATA1	0x1382
-			MX91_PAD_SD3_DATA2__USDHC3_DATA2	0x1382
-			MX91_PAD_SD3_DATA3__USDHC3_DATA3	0x1382
-		>;
-	};
-
-	pinctrl_usdhc3_sleep: usdhc3sleepgrp {
-		fsl,pins = <
-			MX91_PAD_SD3_CLK__GPIO3_IO20		0x31e
-			MX91_PAD_SD3_CMD__GPIO3_IO21		0x31e
-			MX91_PAD_SD3_DATA0__GPIO3_IO22		0x31e
-			MX91_PAD_SD3_DATA1__GPIO3_IO23		0x31e
-			MX91_PAD_SD3_DATA2__GPIO3_IO24		0x31e
-			MX91_PAD_SD3_DATA3__GPIO3_IO25		0x31e
-		>;
-	};
-
-	pinctrl_usdhc3_wlan: usdhc3wlangrp {
-		fsl,pins = <
-			MX91_PAD_CCM_CLKO1__GPIO3_IO26		0x31e
-		>;
-	};
-};
diff --git a/arch/arm/dts/imx91-11x11-frdm.dts b/arch/arm/dts/imx91-11x11-frdm.dts
deleted file mode 100644
index fc9d6729c58..00000000000
--- a/arch/arm/dts/imx91-11x11-frdm.dts
+++ /dev/null
@@ -1,773 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2025 NXP
- */
-
-/dts-v1/;
-
-#include <dt-bindings/usb/pd.h>
-#include "imx91.dtsi"
-
-/ {
-	compatible = "fsl,imx91-11x11-frdm", "fsl,imx91";
-	model = "NXP i.MX91 11X11 FRDM Board";
-
-	aliases {
-		ethernet0 = &fec;
-		ethernet1 = &eqos;
-		rtc0 = &pcf2131;
-	};
-
-	chosen {
-		stdout-path = &lpuart1;
-	};
-
-	reg_vref_1v8: regulator-adc-vref {
-		compatible = "regulator-fixed";
-		regulator-max-microvolt = <1800000>;
-		regulator-min-microvolt = <1800000>;
-		regulator-name = "vref_1v8";
-	};
-
-	reg_usdhc2_vmmc: regulator-usdhc2 {
-		compatible = "regulator-fixed";
-		off-on-delay-us = <12000>;
-		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
-		pinctrl-names = "default";
-		regulator-max-microvolt = <3300000>;
-		regulator-min-microvolt = <3300000>;
-		regulator-name = "VSD_3V3";
-		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		bootph-pre-ram;
-		bootph-some-ram;
-	};
-
-	reg_vdd_12v: regulator-vdd-12v {
-		compatible = "regulator-fixed";
-		regulator-max-microvolt = <12000000>;
-		regulator-min-microvolt = <12000000>;
-		regulator-name = "reg_vdd_12v";
-		gpio = <&pcal6524 14 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	reg_vexp_3v3: regulator-vexp-3v3 {
-		compatible = "regulator-fixed";
-		regulator-max-microvolt = <3300000>;
-		regulator-min-microvolt = <3300000>;
-		regulator-name = "VEXP_3V3";
-		vin-supply = <&buck4>;
-		gpio = <&pcal6524 2 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	reg_vexp_5v: regulator-vexp-5v {
-		compatible = "regulator-fixed";
-		regulator-max-microvolt = <5000000>;
-		regulator-min-microvolt = <5000000>;
-		regulator-name = "VEXP_5V";
-		gpio = <&pcal6524 8 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	reserved-memory {
-		ranges;
-		#address-cells = <2>;
-		#size-cells = <2>;
-
-		linux,cma {
-			compatible = "shared-dma-pool";
-			alloc-ranges = <0 0x80000000 0 0x40000000>;
-			reusable;
-			size = <0 0x10000000>;
-			linux,cma-default;
-		};
-	};
-
-	soc@0 {
-		bootph-all;
-		bootph-pre-ram;
-	};
-};
-
-&adc1 {
-	vref-supply = <&reg_vref_1v8>;
-	status = "okay";
-};
-
-&aips1 {
-	bootph-pre-ram;
-	bootph-all;
-};
-
-&aips2 {
-	bootph-pre-ram;
-	bootph-some-ram;
-};
-
-&aips3 {
-	bootph-pre-ram;
-	bootph-some-ram;
-};
-
-&clk {
-	bootph-all;
-	bootph-pre-ram;
-};
-
-&clk_ext1 {
-	bootph-all;
-	bootph-pre-ram;
-};
-
-&eqos {
-	phy-handle = <&ethphy1>;
-	phy-mode = "rgmii-id";
-	pinctrl-0 = <&pinctrl_eqos>;
-	pinctrl-1 = <&pinctrl_eqos_sleep>;
-	pinctrl-names = "default", "sleep";
-	status = "okay";
-
-	mdio {
-		compatible = "snps,dwmac-mdio";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clock-frequency = <5000000>;
-
-		ethphy1: ethernet-phy@1 {
-			reg = <1>;
-			eee-broken-1000t;
-			reset-gpios = <&pcal6524 15 GPIO_ACTIVE_LOW>;
-			reset-assert-us = <15000>;
-			reset-deassert-us = <100000>;
-		};
-	};
-};
-
-&fec {
-	phy-handle = <&ethphy2>;
-	phy-mode = "rgmii-id";
-	pinctrl-0 = <&pinctrl_fec>;
-	pinctrl-1 = <&pinctrl_fec_sleep>;
-	pinctrl-names = "default", "sleep";
-	fsl,magic-packet;
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clock-frequency = <5000000>;
-
-		ethphy2: ethernet-phy@2 {
-			reg = <2>;
-			eee-broken-1000t;
-			reset-gpios = <&pcal6524 16 GPIO_ACTIVE_LOW>;
-			reset-assert-us = <15000>;
-			reset-deassert-us = <100000>;
-		};
-	};
-};
-
-&gpio1 {
-	bootph-pre-ram;
-	bootph-some-ram;
-};
-
-&gpio2 {
-	bootph-pre-ram;
-	bootph-some-ram;
-};
-
-&gpio3 {
-	bootph-pre-ram;
-	bootph-some-ram;
-};
-
-&gpio4 {
-	bootph-pre-ram;
-	bootph-some-ram;
-};
-
-&lpi2c1 {
-	bootph-pre-ram;
-	bootph-some-ram;
-};
-
-&lpi2c2 {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	clock-frequency = <400000>;
-	pinctrl-0 = <&pinctrl_lpi2c2>;
-	pinctrl-names = "default";
-	status = "okay";
-	bootph-pre-ram;
-	bootph-some-ram;
-
-	pcal6524: gpio@22 {
-		compatible = "nxp,pcal6524";
-		reg = <0x22>;
-		#interrupt-cells = <2>;
-		interrupt-controller;
-		interrupt-parent = <&gpio3>;
-		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
-		#gpio-cells = <2>;
-		gpio-controller;
-		pinctrl-0 = <&pinctrl_pcal6524>;
-		pinctrl-names = "default";
-	};
-
-	pmic@25 {
-		compatible = "nxp,pca9451a";
-		reg = <0x25>;
-		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
-		interrupt-parent = <&pcal6524>;
-		bootph-pre-ram;
-		bootph-some-ram;
-
-		regulators {
-			bootph-pre-ram;
-			bootph-some-ram;
-
-			buck1: BUCK1 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-max-microvolt = <2237500>;
-				regulator-min-microvolt = <650000>;
-				regulator-name = "BUCK1";
-				regulator-ramp-delay = <3125>;
-			};
-
-			buck2: BUCK2 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-max-microvolt = <2187500>;
-				regulator-min-microvolt = <600000>;
-				regulator-name = "BUCK2";
-				regulator-ramp-delay = <3125>;
-			};
-
-			buck4: BUCK4 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-max-microvolt = <3400000>;
-				regulator-min-microvolt = <600000>;
-				regulator-name = "BUCK4";
-			};
-
-			buck5: BUCK5 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-max-microvolt = <3400000>;
-				regulator-min-microvolt = <600000>;
-				regulator-name = "BUCK5";
-			};
-
-			buck6: BUCK6 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-max-microvolt = <3400000>;
-				regulator-min-microvolt = <600000>;
-				regulator-name = "BUCK6";
-			};
-
-			ldo1: LDO1 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-max-microvolt = <3300000>;
-				regulator-min-microvolt = <1600000>;
-				regulator-name = "LDO1";
-			};
-
-			ldo4: LDO4 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-max-microvolt = <3300000>;
-				regulator-min-microvolt = <800000>;
-				regulator-name = "LDO4";
-			};
-
-			ldo5: LDO5 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-max-microvolt = <3300000>;
-				regulator-min-microvolt = <1800000>;
-				regulator-name = "LDO5";
-			};
-		};
-	};
-
-	eeprom: at24c256@50 {
-		compatible = "atmel,24c256";
-		reg = <0x50>;
-		pagesize = <64>;
-	};
-};
-
-&lpi2c3 {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	clock-frequency = <400000>;
-	pinctrl-0 = <&pinctrl_lpi2c3>;
-	pinctrl-names = "default";
-	status = "okay";
-	bootph-pre-ram;
-	bootph-some-ram;
-
-	ptn5110: tcpc@50 {
-		compatible = "nxp,ptn5110", "tcpci";
-		reg = <0x50>;
-		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
-		interrupt-parent = <&gpio3>;
-		status = "okay";
-
-		typec1_con: connector {
-			compatible = "usb-c-connector";
-			data-role = "dual";
-			label = "USB-C";
-			op-sink-microwatt = <15000000>;
-			power-role = "dual";
-			self-powered;
-			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
-				     PDO_VAR(5000, 20000, 3000)>;
-			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
-			try-power-role = "sink";
-
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				port@0 {
-					reg = <0>;
-
-					typec1_dr_sw: endpoint {
-						remote-endpoint = <&usb1_drd_sw>;
-					};
-				};
-			};
-		};
-	};
-
-	pcf2131: rtc@53 {
-		compatible = "nxp,pcf2131";
-		reg = <0x53>;
-		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
-		interrupt-parent = <&pcal6524>;
-		status = "okay";
-	};
-};
-
-&lpuart1 {
-	pinctrl-0 = <&pinctrl_uart1>;
-	pinctrl-names = "default";
-	status = "okay";
-	bootph-pre-ram;
-	bootph-some-ram;
-};
-
-&lpuart5 {
-	pinctrl-0 = <&pinctrl_uart5>;
-	pinctrl-names = "default";
-	status = "okay";
-};
-
-&osc_32k {
-	bootph-all;
-	bootph-pre-ram;
-};
-
-&osc_24m {
-	bootph-all;
-	bootph-pre-ram;
-};
-
-&usbotg1 {
-	adp-disable;
-	disable-over-current;
-	dr_mode = "otg";
-	hnp-disable;
-	srp-disable;
-	usb-role-switch;
-	samsung,picophy-dc-vol-level-adjust = <7>;
-	samsung,picophy-pre-emp-curr-control = <3>;
-	status = "okay";
-
-	port {
-		usb1_drd_sw: endpoint {
-			remote-endpoint = <&typec1_dr_sw>;
-		};
-	};
-};
-
-&usbotg2 {
-	disable-over-current;
-	dr_mode = "host";
-	samsung,picophy-dc-vol-level-adjust = <7>;
-	samsung,picophy-pre-emp-curr-control = <3>;
-	status = "okay";
-};
-
-&usdhc1 {
-	bus-width = <8>;
-	non-removable;
-	pinctrl-0 = <&pinctrl_usdhc1>;
-	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
-	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	status = "okay";
-	bootph-pre-ram;
-	bootph-some-ram;
-};
-
-&usdhc2 {
-	bus-width = <4>;
-	cd-gpios = <&gpio3 00 GPIO_ACTIVE_LOW>;
-	no-mmc;
-	no-sdio;
-	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-3 = <&pinctrl_usdhc2_sleep>, <&pinctrl_usdhc2_gpio_sleep>;
-	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
-	vmmc-supply = <&reg_usdhc2_vmmc>;
-	status = "okay";
-};
-
-&wdog3 {
-	fsl,ext-reset-output;
-	status = "okay";
-};
-
-&iomuxc {
-	bootph-pre-ram;
-	bootph-some-ram;
-
-	pinctrl_eqos: eqosgrp {
-		fsl,pins = <
-			MX91_PAD_ENET1_MDC__ENET1_MDC				0x57e
-			MX91_PAD_ENET1_MDIO__ENET_QOS_MDIO			0x57e
-			MX91_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0			0x57e
-			MX91_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1			0x57e
-			MX91_PAD_ENET1_RD2__ENET_QOS_RGMII_RD2			0x57e
-			MX91_PAD_ENET1_RD3__ENET_QOS_RGMII_RD3			0x57e
-			MX91_PAD_ENET1_RXC__ENET_QOS_RGMII_RXC	0x5fe
-			MX91_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL		0x57e
-			MX91_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0			0x57e
-			MX91_PAD_ENET1_TD1__ENET1_RGMII_TD1			0x57e
-			MX91_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2			0x57e
-			MX91_PAD_ENET1_TD3__ENET_QOS_RGMII_TD3			0x57e
-			MX91_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x5fe
-			MX91_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL		0x57e
-		>;
-	};
-
-	pinctrl_eqos_sleep: eqossleepgrp {
-		fsl,pins = <
-			MX91_PAD_ENET1_MDC__GPIO4_IO0				0x31e
-			MX91_PAD_ENET1_MDIO__GPIO4_IO1				0x31e
-			MX91_PAD_ENET1_RD0__GPIO4_IO10				0x31e
-			MX91_PAD_ENET1_RD1__GPIO4_IO11				0x31e
-			MX91_PAD_ENET1_RD2__GPIO4_IO12				0x31e
-			MX91_PAD_ENET1_RD3__GPIO4_IO13				0x31e
-			MX91_PAD_ENET1_RXC__GPIO4_IO9				0x31e
-			MX91_PAD_ENET1_RX_CTL__GPIO4_IO8			0x31e
-			MX91_PAD_ENET1_TD0__GPIO4_IO5				0x31e
-			MX91_PAD_ENET1_TD1__GPIO4_IO4				0x31e
-			MX91_PAD_ENET1_TD2__GPIO4_IO3				0x31e
-			MX91_PAD_ENET1_TD3__GPIO4_IO2				0x31e
-			MX91_PAD_ENET1_TXC__GPIO4_IO7				0x31e
-			MX91_PAD_ENET1_TX_CTL__GPIO4_IO6			0x31e
-		>;
-	};
-
-	pinctrl_fec: fecgrp {
-		fsl,pins = <
-			MX91_PAD_ENET2_MDC__ENET2_MDC			0x57e
-			MX91_PAD_ENET2_MDIO__ENET2_MDIO			0x57e
-			MX91_PAD_ENET2_RD0__ENET2_RGMII_RD0		0x57e
-			MX91_PAD_ENET2_RD1__ENET2_RGMII_RD1		0x57e
-			MX91_PAD_ENET2_RD2__ENET2_RGMII_RD2		0x57e
-			MX91_PAD_ENET2_RD3__ENET2_RGMII_RD3		0x57e
-			MX91_PAD_ENET2_RXC__ENET2_RGMII_RXC		0x5fe
-			MX91_PAD_ENET2_RX_CTL__ENET2_RGMII_RX_CTL	0x57e
-			MX91_PAD_ENET2_TD0__ENET2_RGMII_TD0		0x57e
-			MX91_PAD_ENET2_TD1__ENET2_RGMII_TD1		0x57e
-			MX91_PAD_ENET2_TD2__ENET2_RGMII_TD2		0x57e
-			MX91_PAD_ENET2_TD3__ENET2_RGMII_TD3		0x57e
-			MX91_PAD_ENET2_TXC__ENET2_RGMII_TXC		0x5fe
-			MX91_PAD_ENET2_TX_CTL__ENET2_RGMII_TX_CTL	0x57e
-		>;
-	};
-
-	pinctrl_fec_sleep: fecsleepgrp {
-		fsl,pins = <
-			MX91_PAD_ENET2_MDC__GPIO4_IO14			0x51e
-			MX91_PAD_ENET2_MDIO__GPIO4_IO15			0x51e
-			MX91_PAD_ENET2_RD0__GPIO4_IO24			0x51e
-			MX91_PAD_ENET2_RD1__GPIO4_IO25			0x51e
-			MX91_PAD_ENET2_RD2__GPIO4_IO26			0x51e
-			MX91_PAD_ENET2_RD3__GPIO4_IO27			0x51e
-			MX91_PAD_ENET2_RXC__GPIO4_IO23			0x51e
-			MX91_PAD_ENET2_RX_CTL__GPIO4_IO22		0x51e
-			MX91_PAD_ENET2_TD0__GPIO4_IO19			0x51e
-			MX91_PAD_ENET2_TD1__GPIO4_IO18			0x51e
-			MX91_PAD_ENET2_TD2__GPIO4_IO17			0x51e
-			MX91_PAD_ENET2_TD3__GPIO4_IO16			0x51e
-			MX91_PAD_ENET2_TXC__GPIO4_IO21			0x51e
-			MX91_PAD_ENET2_TX_CTL__GPIO4_IO20		0x51e
-		>;
-	};
-
-	pinctrl_lcdif_gpio: lcdifgpiogrp {
-		fsl,pins = <
-			MX91_PAD_GPIO_IO00__GPIO2_IO0			0x51e
-			MX91_PAD_GPIO_IO01__GPIO2_IO1			0x51e
-			MX91_PAD_GPIO_IO02__GPIO2_IO2			0x51e
-			MX91_PAD_GPIO_IO03__GPIO2_IO3			0x51e
-		>;
-	};
-
-	pinctrl_lcdif: lcdifgrp {
-		fsl,pins = <
-			MX91_PAD_GPIO_IO00__MEDIAMIX_DISP_CLK		0x31e
-			MX91_PAD_GPIO_IO01__MEDIAMIX_DISP_DE		0x31e
-			MX91_PAD_GPIO_IO02__MEDIAMIX_DISP_VSYNC		0x31e
-			MX91_PAD_GPIO_IO03__MEDIAMIX_DISP_HSYNC		0x31e
-			MX91_PAD_GPIO_IO04__MEDIAMIX_DISP_DATA0		0x31e
-			MX91_PAD_GPIO_IO05__MEDIAMIX_DISP_DATA1		0x31e
-			MX91_PAD_GPIO_IO06__MEDIAMIX_DISP_DATA2		0x31e
-			MX91_PAD_GPIO_IO07__MEDIAMIX_DISP_DATA3		0x31e
-			MX91_PAD_GPIO_IO08__MEDIAMIX_DISP_DATA4		0x31e
-			MX91_PAD_GPIO_IO09__MEDIAMIX_DISP_DATA5		0x31e
-			MX91_PAD_GPIO_IO10__MEDIAMIX_DISP_DATA6		0x31e
-			MX91_PAD_GPIO_IO11__MEDIAMIX_DISP_DATA7		0x31e
-			MX91_PAD_GPIO_IO12__MEDIAMIX_DISP_DATA8		0x31e
-			MX91_PAD_GPIO_IO13__MEDIAMIX_DISP_DATA9		0x31e
-			MX91_PAD_GPIO_IO14__MEDIAMIX_DISP_DATA10	0x31e
-			MX91_PAD_GPIO_IO15__MEDIAMIX_DISP_DATA11	0x31e
-			MX91_PAD_GPIO_IO16__MEDIAMIX_DISP_DATA12	0x31e
-			MX91_PAD_GPIO_IO17__MEDIAMIX_DISP_DATA13	0x31e
-			MX91_PAD_GPIO_IO18__MEDIAMIX_DISP_DATA14	0x31e
-			MX91_PAD_GPIO_IO19__MEDIAMIX_DISP_DATA15	0x31e
-			MX91_PAD_GPIO_IO20__MEDIAMIX_DISP_DATA16	0x31e
-			MX91_PAD_GPIO_IO21__MEDIAMIX_DISP_DATA17	0x31e
-			MX91_PAD_GPIO_IO27__GPIO2_IO27			0x31e
-		>;
-	};
-
-	pinctrl_lpi2c1: lpi2c1grp {
-		fsl,pins = <
-			MX91_PAD_I2C1_SCL__LPI2C1_SCL			0x40000b9e
-			MX91_PAD_I2C1_SDA__LPI2C1_SDA			0x40000b9e
-		>;
-		bootph-pre-ram;
-		bootph-some-ram;
-	};
-
-	pinctrl_lpi2c2: lpi2c2grp {
-		fsl,pins = <
-			MX91_PAD_I2C2_SCL__LPI2C2_SCL			0x40000b9e
-			MX91_PAD_I2C2_SDA__LPI2C2_SDA			0x40000b9e
-		>;
-		bootph-pre-ram;
-		bootph-some-ram;
-	};
-
-	pinctrl_lpi2c3: lpi2c3grp {
-		fsl,pins = <
-			MX91_PAD_GPIO_IO28__LPI2C3_SDA			0x40000b9e
-			MX91_PAD_GPIO_IO29__LPI2C3_SCL			0x40000b9e
-		>;
-		bootph-pre-ram;
-		bootph-some-ram;
-	};
-
-	pinctrl_pcal6524: pcal6524grp {
-		fsl,pins = <
-			MX91_PAD_CCM_CLKO2__GPIO3_IO27			0x31e
-		>;
-	};
-
-	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
-		fsl,pins = <
-			MX91_PAD_SD2_RESET_B__GPIO3_IO7	0x31e
-		>;
-		bootph-pre-ram;
-	};
-
-	pinctrl_uart1: uart1grp {
-		fsl,pins = <
-			MX91_PAD_UART1_RXD__LPUART1_RX			0x31e
-			MX91_PAD_UART1_TXD__LPUART1_TX			0x31e
-		>;
-		bootph-pre-ram;
-		bootph-some-ram;
-	};
-
-	pinctrl_uart5: uart5grp {
-		fsl,pins = <
-			MX91_PAD_DAP_TDO_TRACESWO__LPUART5_TX	0x31e
-			MX91_PAD_DAP_TDI__LPUART5_RX		0x31e
-			MX91_PAD_DAP_TMS_SWDIO__LPUART5_RTS_B	0x31e
-			MX91_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B	0x31e
-		>;
-	};
-
-	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
-		fsl,pins = <
-			MX91_PAD_SD1_CLK__USDHC1_CLK		0x158e
-			MX91_PAD_SD1_CMD__USDHC1_CMD		0x138e
-			MX91_PAD_SD1_DATA0__USDHC1_DATA0	0x138e
-			MX91_PAD_SD1_DATA1__USDHC1_DATA1	0x138e
-			MX91_PAD_SD1_DATA2__USDHC1_DATA2	0x138e
-			MX91_PAD_SD1_DATA3__USDHC1_DATA3	0x138e
-			MX91_PAD_SD1_DATA4__USDHC1_DATA4	0x138e
-			MX91_PAD_SD1_DATA5__USDHC1_DATA5	0x138e
-			MX91_PAD_SD1_DATA6__USDHC1_DATA6	0x138e
-			MX91_PAD_SD1_DATA7__USDHC1_DATA7	0x138e
-			MX91_PAD_SD1_STROBE__USDHC1_STROBE	0x158e
-		>;
-	};
-
-	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
-		fsl,pins = <
-			MX91_PAD_SD1_CLK__USDHC1_CLK		0x15fe
-			MX91_PAD_SD1_CMD__USDHC1_CMD		0x13fe
-			MX91_PAD_SD1_DATA0__USDHC1_DATA0	0x13fe
-			MX91_PAD_SD1_DATA1__USDHC1_DATA1	0x13fe
-			MX91_PAD_SD1_DATA2__USDHC1_DATA2	0x13fe
-			MX91_PAD_SD1_DATA3__USDHC1_DATA3	0x13fe
-			MX91_PAD_SD1_DATA4__USDHC1_DATA4	0x13fe
-			MX91_PAD_SD1_DATA5__USDHC1_DATA5	0x13fe
-			MX91_PAD_SD1_DATA6__USDHC1_DATA6	0x13fe
-			MX91_PAD_SD1_DATA7__USDHC1_DATA7	0x13fe
-			MX91_PAD_SD1_STROBE__USDHC1_STROBE	0x15fe
-		>;
-	};
-
-	pinctrl_usdhc1: usdhc1grp {
-		fsl,pins = <
-			MX91_PAD_SD1_CLK__USDHC1_CLK		0x1582
-			MX91_PAD_SD1_CMD__USDHC1_CMD		0x1382
-			MX91_PAD_SD1_DATA0__USDHC1_DATA0	0x1382
-			MX91_PAD_SD1_DATA1__USDHC1_DATA1	0x1382
-			MX91_PAD_SD1_DATA2__USDHC1_DATA2	0x1382
-			MX91_PAD_SD1_DATA3__USDHC1_DATA3	0x1382
-			MX91_PAD_SD1_DATA4__USDHC1_DATA4	0x1382
-			MX91_PAD_SD1_DATA5__USDHC1_DATA5	0x1382
-			MX91_PAD_SD1_DATA6__USDHC1_DATA6	0x1382
-			MX91_PAD_SD1_DATA7__USDHC1_DATA7	0x1382
-			MX91_PAD_SD1_STROBE__USDHC1_STROBE	0x1582
-		>;
-		bootph-pre-ram;
-		bootph-some-ram;
-	};
-
-	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
-		fsl,pins = <
-			MX91_PAD_SD2_CLK__USDHC2_CLK		0x158e
-			MX91_PAD_SD2_CMD__USDHC2_CMD		0x138e
-			MX91_PAD_SD2_DATA0__USDHC2_DATA0	0x138e
-			MX91_PAD_SD2_DATA1__USDHC2_DATA1	0x138e
-			MX91_PAD_SD2_DATA2__USDHC2_DATA2	0x138e
-			MX91_PAD_SD2_DATA3__USDHC2_DATA3	0x138e
-			MX91_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
-		>;
-	};
-
-	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
-		fsl,pins = <
-			MX91_PAD_SD2_CLK__USDHC2_CLK		0x15fe
-			MX91_PAD_SD2_CMD__USDHC2_CMD		0x13fe
-			MX91_PAD_SD2_DATA0__USDHC2_DATA0	0x13fe
-			MX91_PAD_SD2_DATA1__USDHC2_DATA1	0x13fe
-			MX91_PAD_SD2_DATA2__USDHC2_DATA2	0x13fe
-			MX91_PAD_SD2_DATA3__USDHC2_DATA3	0x13fe
-			MX91_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
-		>;
-	};
-
-	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
-		fsl,pins = <
-			MX91_PAD_SD2_CD_B__GPIO3_IO0		0x31e
-		>;
-		bootph-pre-ram;
-		bootph-some-ram;
-	};
-
-	pinctrl_usdhc2_gpio_sleep: usdhc2gpiosleepgrp {
-		fsl,pins = <
-			MX91_PAD_SD2_CD_B__GPIO3_IO0		0x51e
-		>;
-	};
-
-	pinctrl_usdhc2: usdhc2grp {
-		fsl,pins = <
-			MX91_PAD_SD2_CLK__USDHC2_CLK		0x1582
-			MX91_PAD_SD2_CMD__USDHC2_CMD		0x1382
-			MX91_PAD_SD2_DATA0__USDHC2_DATA0	0x1382
-			MX91_PAD_SD2_DATA1__USDHC2_DATA1	0x1382
-			MX91_PAD_SD2_DATA2__USDHC2_DATA2	0x1382
-			MX91_PAD_SD2_DATA3__USDHC2_DATA3	0x1382
-			MX91_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
-		>;
-		bootph-pre-ram;
-		bootph-some-ram;
-	};
-
-	pinctrl_usdhc2_sleep: usdhc2sleepgrp {
-		fsl,pins = <
-			MX91_PAD_SD2_CLK__GPIO3_IO1		0x51e
-			MX91_PAD_SD2_CMD__GPIO3_IO2		0x51e
-			MX91_PAD_SD2_DATA0__GPIO3_IO3		0x51e
-			MX91_PAD_SD2_DATA1__GPIO3_IO4		0x51e
-			MX91_PAD_SD2_DATA2__GPIO3_IO5		0x51e
-			MX91_PAD_SD2_DATA3__GPIO3_IO6		0x51e
-			MX91_PAD_SD2_VSELECT__GPIO3_IO19	0x51e
-		>;
-	};
-
-	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
-		fsl,pins = <
-			MX91_PAD_SD3_CLK__USDHC3_CLK		0x158e
-			MX91_PAD_SD3_CMD__USDHC3_CMD		0x138e
-			MX91_PAD_SD3_DATA0__USDHC3_DATA0	0x138e
-			MX91_PAD_SD3_DATA1__USDHC3_DATA1	0x138e
-			MX91_PAD_SD3_DATA2__USDHC3_DATA2	0x138e
-			MX91_PAD_SD3_DATA3__USDHC3_DATA3	0x138e
-		>;
-	};
-
-	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
-		fsl,pins = <
-			MX91_PAD_SD3_CLK__USDHC3_CLK		0x15fe
-			MX91_PAD_SD3_CMD__USDHC3_CMD		0x13fe
-			MX91_PAD_SD3_DATA0__USDHC3_DATA0	0x13fe
-			MX91_PAD_SD3_DATA1__USDHC3_DATA1	0x13fe
-			MX91_PAD_SD3_DATA2__USDHC3_DATA2	0x13fe
-			MX91_PAD_SD3_DATA3__USDHC3_DATA3	0x13fe
-		>;
-	};
-
-	pinctrl_usdhc3: usdhc3grp {
-		fsl,pins = <
-			MX91_PAD_SD3_CLK__USDHC3_CLK		0x1582
-			MX91_PAD_SD3_CMD__USDHC3_CMD		0x1382
-			MX91_PAD_SD3_DATA0__USDHC3_DATA0	0x1382
-			MX91_PAD_SD3_DATA1__USDHC3_DATA1	0x1382
-			MX91_PAD_SD3_DATA2__USDHC3_DATA2	0x1382
-			MX91_PAD_SD3_DATA3__USDHC3_DATA3	0x1382
-		>;
-	};
-
-	pinctrl_usdhc3_sleep: usdhc3sleepgrp {
-		fsl,pins = <
-			MX91_PAD_SD3_CLK__GPIO3_IO20		0x31e
-			MX91_PAD_SD3_CMD__GPIO3_IO21		0x31e
-			MX91_PAD_SD3_DATA0__GPIO3_IO22		0x31e
-			MX91_PAD_SD3_DATA1__GPIO3_IO23		0x31e
-			MX91_PAD_SD3_DATA2__GPIO3_IO24		0x31e
-			MX91_PAD_SD3_DATA3__GPIO3_IO25		0x31e
-		>;
-	};
-};
diff --git a/arch/arm/dts/imx91-pinfunc.h b/arch/arm/dts/imx91-pinfunc.h
deleted file mode 100644
index 5677928ab7c..00000000000
--- a/arch/arm/dts/imx91-pinfunc.h
+++ /dev/null
@@ -1,770 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
-/*
- * Copyright 2024 NXP
- */
-
-#ifndef __DTS_IMX91_PINFUNC_H
-#define __DTS_IMX91_PINFUNC_H
-
-/*
- * The pin function ID is a tuple of
- * <mux_reg conf_reg input_reg mux_mode input_val>
- */
-#define MX91_PAD_DAP_TDI__JTAG_MUX_TDI                                           0x0000 0x01b0 0x03d8 0x00 0x00
-#define MX91_PAD_DAP_TDI__MQS2_LEFT                                              0x0000 0x01b0 0x0000 0x01 0x00
-#define MX91_PAD_DAP_TDI__CAN2_TX                                                0x0000 0x01b0 0x0000 0x03 0x00
-#define MX91_PAD_DAP_TDI__FLEXIO2_FLEXIO30                                       0x0000 0x01b0 0x0000 0x04 0x00
-#define MX91_PAD_DAP_TDI__GPIO3_IO28                                             0x0000 0x01b0 0x0000 0x05 0x00
-#define MX91_PAD_DAP_TDI__LPUART5_RX                                             0x0000 0x01b0 0x0488 0x06 0x00
-
-#define MX91_PAD_DAP_TMS_SWDIO__JTAG_MUX_TMS                                     0x0004 0x01b4 0x03dc 0x00 0x00
-#define MX91_PAD_DAP_TMS_SWDIO__FLEXIO2_FLEXIO31                                 0x0004 0x01b4 0x0000 0x04 0x00
-#define MX91_PAD_DAP_TMS_SWDIO__GPIO3_IO29                                       0x0004 0x01b4 0x0000 0x05 0x00
-#define MX91_PAD_DAP_TMS_SWDIO__LPUART5_RTS_B                                    0x0004 0x01b4 0x0000 0x06 0x00
-
-#define MX91_PAD_DAP_TCLK_SWCLK__JTAG_MUX_TCK                                    0x0008 0x01b8 0x03d4 0x00 0x00
-#define MX91_PAD_DAP_TCLK_SWCLK__FLEXIO1_FLEXIO30                                0x0008 0x01b8 0x0000 0x04 0x00
-#define MX91_PAD_DAP_TCLK_SWCLK__GPIO3_IO30                                      0x0008 0x01b8 0x0000 0x05 0x00
-#define MX91_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B                                   0x0008 0x01b8 0x0484 0x06 0x00
-
-#define MX91_PAD_DAP_TDO_TRACESWO__JTAG_MUX_TDO                                  0x000c 0x01bc 0x0000 0x00 0x00
-#define MX91_PAD_DAP_TDO_TRACESWO__MQS2_RIGHT                                    0x000c 0x01bc 0x0000 0x01 0x00
-#define MX91_PAD_DAP_TDO_TRACESWO__CAN2_RX                                       0x000c 0x01bc 0x0364 0x03 0x00
-#define MX91_PAD_DAP_TDO_TRACESWO__FLEXIO1_FLEXIO31                              0x000c 0x01bc 0x0000 0x04 0x00
-#define MX91_PAD_DAP_TDO_TRACESWO__GPIO3_IO31                                    0x000c 0x01bc 0x0000 0x05 0x00
-#define MX91_PAD_DAP_TDO_TRACESWO__LPUART5_TX                                    0x000c 0x01bc 0x048c 0x06 0x00
-
-#define MX91_PAD_GPIO_IO00__GPIO2_IO0                                            0x0010 0x01c0 0x0000 0x00 0x00
-#define MX91_PAD_GPIO_IO00__LPI2C3_SDA                                           0x0010 0x01c0 0x03f4 0x01 0x00
-#define MX91_PAD_GPIO_IO00__MEDIAMIX_CAM_CLK                                     0x0010 0x01c0 0x04bc 0x02 0x00
-#define MX91_PAD_GPIO_IO00__MEDIAMIX_DISP_CLK                                    0x0010 0x01c0 0x0000 0x03 0x00
-#define MX91_PAD_GPIO_IO00__LPSPI6_PCS0                                          0x0010 0x01c0 0x0000 0x04 0x00
-#define MX91_PAD_GPIO_IO00__LPUART5_TX                                           0x0010 0x01c0 0x048c 0x05 0x01
-#define MX91_PAD_GPIO_IO00__LPI2C5_SDA                                           0x0010 0x01c0 0x0404 0x06 0x00
-#define MX91_PAD_GPIO_IO00__FLEXIO1_FLEXIO0                                      0x0010 0x01c0 0x036c 0x07 0x00
-
-#define MX91_PAD_GPIO_IO01__GPIO2_IO1                                            0x0014 0x01c4 0x0000 0x00 0x00
-#define MX91_PAD_GPIO_IO01__LPI2C3_SCL                                           0x0014 0x01c4 0x03f0 0x01 0x00
-#define MX91_PAD_GPIO_IO01__MEDIAMIX_CAM_DATA0                                   0x0014 0x01c4 0x0490 0x02 0x00
-#define MX91_PAD_GPIO_IO01__MEDIAMIX_DISP_DE                                     0x0014 0x01c4 0x0000 0x03 0x00
-#define MX91_PAD_GPIO_IO01__LPSPI6_SIN                                           0x0014 0x01c4 0x0000 0x04 0x00
-#define MX91_PAD_GPIO_IO01__LPUART5_RX                                           0x0014 0x01c4 0x0488 0x05 0x01
-#define MX91_PAD_GPIO_IO01__LPI2C5_SCL                                           0x0014 0x01c4 0x0400 0x06 0x00
-#define MX91_PAD_GPIO_IO01__FLEXIO1_FLEXIO1                                      0x0014 0x01c4 0x0370 0x07 0x00
-
-#define MX91_PAD_GPIO_IO02__GPIO2_IO2                                            0x0018 0x01c8 0x0000 0x00 0x00
-#define MX91_PAD_GPIO_IO02__LPI2C4_SDA                                           0x0018 0x01c8 0x03fc 0x01 0x00
-#define MX91_PAD_GPIO_IO02__MEDIAMIX_CAM_VSYNC                                   0x0018 0x01c8 0x04c0 0x02 0x00
-#define MX91_PAD_GPIO_IO02__MEDIAMIX_DISP_VSYNC                                  0x0018 0x01c8 0x0000 0x03 0x00
-#define MX91_PAD_GPIO_IO02__LPSPI6_SOUT                                          0x0018 0x01c8 0x0000 0x04 0x00
-#define MX91_PAD_GPIO_IO02__LPUART5_CTS_B                                        0x0018 0x01c8 0x0484 0x05 0x01
-#define MX91_PAD_GPIO_IO02__LPI2C6_SDA                                           0x0018 0x01c8 0x040c 0x06 0x00
-#define MX91_PAD_GPIO_IO02__FLEXIO1_FLEXIO2                                      0x0018 0x01c8 0x0374 0x07 0x00
-
-#define MX91_PAD_GPIO_IO03__GPIO2_IO3                                            0x001c 0x01cc 0x0000 0x00 0x00
-#define MX91_PAD_GPIO_IO03__LPI2C4_SCL                                           0x001c 0x01cc 0x03f8 0x01 0x00
-#define MX91_PAD_GPIO_IO03__MEDIAMIX_CAM_HSYNC                                   0x001c 0x01cc 0x04b8 0x02 0x00
-#define MX91_PAD_GPIO_IO03__MEDIAMIX_DISP_HSYNC                                  0x001c 0x01cc 0x0000 0x03 0x00
-#define MX91_PAD_GPIO_IO03__LPSPI6_SCK                                           0x001c 0x01cc 0x0000 0x04 0x00
-#define MX91_PAD_GPIO_IO03__LPUART5_RTS_B                                        0x001c 0x01cc 0x0000 0x05 0x00
-#define MX91_PAD_GPIO_IO03__LPI2C6_SCL                                           0x001c 0x01cc 0x0408 0x06 0x00
-#define MX91_PAD_GPIO_IO03__FLEXIO1_FLEXIO3                                      0x001c 0x01cc 0x0378 0x07 0x00
-
-#define MX91_PAD_GPIO_IO04__GPIO2_IO4                                            0x0020 0x01d0 0x0000 0x00 0x00
-#define MX91_PAD_GPIO_IO04__TPM3_CH0                                             0x0020 0x01d0 0x0000 0x01 0x00
-#define MX91_PAD_GPIO_IO04__PDM_CLK                                              0x0020 0x01d0 0x0000 0x02 0x00
-#define MX91_PAD_GPIO_IO04__MEDIAMIX_DISP_DATA0                                  0x0020 0x01d0 0x0000 0x03 0x00
-#define MX91_PAD_GPIO_IO04__LPSPI7_PCS0                                          0x0020 0x01d0 0x0000 0x04 0x00
-#define MX91_PAD_GPIO_IO04__LPUART6_TX                                           0x0020 0x01d0 0x0000 0x05 0x00
-#define MX91_PAD_GPIO_IO04__LPI2C6_SDA                                           0x0020 0x01d0 0x040c 0x06 0x01
-#define MX91_PAD_GPIO_IO04__FLEXIO1_FLEXIO4                                      0x0020 0x01d0 0x037c 0x07 0x00
-
-#define MX91_PAD_GPIO_IO05__GPIO2_IO5                                            0x0024 0x01d4 0x0000 0x00 0x00
-#define MX91_PAD_GPIO_IO05__TPM4_CH0                                             0x0024 0x01d4 0x0000 0x01 0x00
-#define MX91_PAD_GPIO_IO05__PDM_BIT_STREAM0                                      0x0024 0x01d4 0x04c4 0x02 0x00
-#define MX91_PAD_GPIO_IO05__MEDIAMIX_DISP_DATA1                                  0x0024 0x01d4 0x0000 0x03 0x00
-#define MX91_PAD_GPIO_IO05__LPSPI7_SIN                                           0x0024 0x01d4 0x0000 0x04 0x00
-#define MX91_PAD_GPIO_IO05__LPUART6_RX                                           0x0024 0x01d4 0x0000 0x05 0x00
-#define MX91_PAD_GPIO_IO05__LPI2C6_SCL                                           0x0024 0x01d4 0x0408 0x06 0x01
-#define MX91_PAD_GPIO_IO05__FLEXIO1_FLEXIO5                                      0x0024 0x01d4 0x0380 0x07 0x00
-
-#define MX91_PAD_GPIO_IO06__GPIO2_IO6                                            0x0028 0x01d8 0x0000 0x00 0x00
-#define MX91_PAD_GPIO_IO06__TPM5_CH0                                             0x0028 0x01d8 0x0000 0x01 0x00
-#define MX91_PAD_GPIO_IO06__PDM_BIT_STREAM1                                      0x0028 0x01d8 0x04c8 0x02 0x00
-#define MX91_PAD_GPIO_IO06__MEDIAMIX_DISP_DATA2                                  0x0028 0x01d8 0x0000 0x03 0x00
-#define MX91_PAD_GPIO_IO06__LPSPI7_SOUT                                          0x0028 0x01d8 0x0000 0x04 0x00
-#define MX91_PAD_GPIO_IO06__LPUART6_CTS_B                                        0x0028 0x01d8 0x0000 0x05 0x00
-#define MX91_PAD_GPIO_IO06__LPI2C7_SDA                                           0x0028 0x01d8 0x0414 0x06 0x00
-#define MX91_PAD_GPIO_IO06__FLEXIO1_FLEXIO6                                      0x0028 0x01d8 0x0384 0x07 0x00
-
-#define MX91_PAD_GPIO_IO07__GPIO2_IO7                                            0x002c 0x01dc 0x0000 0x00 0x00
-#define MX91_PAD_GPIO_IO07__LPSPI3_PCS1                                          0x002c 0x01dc 0x0000 0x01 0x00
-#define MX91_PAD_GPIO_IO07__MEDIAMIX_CAM_DATA1                                   0x002c 0x01dc 0x0494 0x02 0x00
-#define MX91_PAD_GPIO_IO07__MEDIAMIX_DISP_DATA3                                  0x002c 0x01dc 0x0000 0x03 0x00
-#define MX91_PAD_GPIO_IO07__LPSPI7_SCK                                           0x002c 0x01dc 0x0000 0x04 0x00
-#define MX91_PAD_GPIO_IO07__LPUART6_RTS_B                                        0x002c 0x01dc 0x0000 0x05 0x00
-#define MX91_PAD_GPIO_IO07__LPI2C7_SCL                                           0x002c 0x01dc 0x0410 0x06 0x00
-#define MX91_PAD_GPIO_IO07__FLEXIO1_FLEXIO7                                      0x002c 0x01dc 0x0388 0x07 0x00
-
-#define MX91_PAD_GPIO_IO08__GPIO2_IO8                                            0x0030 0x01e0 0x0000 0x00 0x00
-#define MX91_PAD_GPIO_IO08__LPSPI3_PCS0                                          0x0030 0x01e0 0x0000 0x01 0x00
-#define MX91_PAD_GPIO_IO08__MEDIAMIX_CAM_DATA2                                   0x0030 0x01e0 0x0498 0x02 0x00
-#define MX91_PAD_GPIO_IO08__MEDIAMIX_DISP_DATA4                                  0x0030 0x01e0 0x0000 0x03 0x00
-#define MX91_PAD_GPIO_IO08__TPM6_CH0                                             0x0030 0x01e0 0x0000 0x04 0x00
-#define MX91_PAD_GPIO_IO08__LPUART7_TX                                           0x0030 0x01e0 0x0000 0x05 0x00
-#define MX91_PAD_GPIO_IO08__LPI2C7_SDA                                           0x0030 0x01e0 0x0414 0x06 0x01
-#define MX91_PAD_GPIO_IO08__FLEXIO1_FLEXIO8                                      0x0030 0x01e0 0x038c 0x07 0x00
-
-#define MX91_PAD_GPIO_IO09__GPIO2_IO9                                            0x0034 0x01e4 0x0000 0x00 0x00
-#define MX91_PAD_GPIO_IO09__LPSPI3_SIN                                           0x0034 0x01e4 0x0000 0x01 0x00
-#define MX91_PAD_GPIO_IO09__MEDIAMIX_CAM_DATA3                                   0x0034 0x01e4 0x049c 0x02 0x00
-#define MX91_PAD_GPIO_IO09__MEDIAMIX_DISP_DATA5                                  0x0034 0x01e4 0x0000 0x03 0x00
-#define MX91_PAD_GPIO_IO09__TPM3_EXTCLK                                          0x0034 0x01e4 0x0000 0x04 0x00
-#define MX91_PAD_GPIO_IO09__LPUART7_RX                                           0x0034 0x01e4 0x0000 0x05 0x00
-#define MX91_PAD_GPIO_IO09__LPI2C7_SCL                                           0x0034 0x01e4 0x0410 0x06 0x01
-#define MX91_PAD_GPIO_IO09__FLEXIO1_FLEXIO9                                      0x0034 0x01e4 0x0390 0x07 0x00
-
-#define MX91_PAD_GPIO_IO10__GPIO2_IO10                                           0x0038 0x01e8 0x0000 0x00 0x00
-#define MX91_PAD_GPIO_IO10__LPSPI3_SOUT                                          0x0038 0x01e8 0x0000 0x01 0x00
-#define MX91_PAD_GPIO_IO10__MEDIAMIX_CAM_DATA4                                   0x0038 0x01e8 0x04a0 0x02 0x00
-#define MX91_PAD_GPIO_IO10__MEDIAMIX_DISP_DATA6                                  0x0038 0x01e8 0x0000 0x03 0x00
-#define MX91_PAD_GPIO_IO10__TPM4_EXTCLK                                          0x0038 0x01e8 0x0000 0x04 0x00
-#define MX91_PAD_GPIO_IO10__LPUART7_CTS_B                                        0x0038 0x01e8 0x0000 0x05 0x00
-#define MX91_PAD_GPIO_IO10__LPI2C8_SDA                                           0x0038 0x01e8 0x041c 0x06 0x00
-#define MX91_PAD_GPIO_IO10__FLEXIO1_FLEXIO10                                     0x0038 0x01e8 0x0394 0x07 0x00
-
-#define MX91_PAD_GPIO_IO11__GPIO2_IO11                                           0x003c 0x01ec 0x0000 0x00 0x00
-#define MX91_PAD_GPIO_IO11__LPSPI3_SCK                                           0x003c 0x01ec 0x0000 0x01 0x00
-#define MX91_PAD_GPIO_IO11__MEDIAMIX_CAM_DATA5                                   0x003c 0x01ec 0x04a4 0x02 0x00
-#define MX91_PAD_GPIO_IO11__MEDIAMIX_DISP_DATA7                                  0x003c 0x01ec 0x0000 0x03 0x00
-#define MX91_PAD_GPIO_IO11__TPM5_EXTCLK                                          0x003c 0x01ec 0x0000 0x04 0x00
-#define MX91_PAD_GPIO_IO11__LPUART7_RTS_B                                        0x003c 0x01ec 0x0000 0x05 0x00
-#define MX91_PAD_GPIO_IO11__LPI2C8_SCL                                           0x003c 0x01ec 0x0418 0x06 0x00
-#define MX91_PAD_GPIO_IO11__FLEXIO1_FLEXIO11                                     0x003c 0x01ec 0x0398 0x07 0x00
-
-#define MX91_PAD_GPIO_IO12__GPIO2_IO12                                           0x0040 0x01f0 0x0000 0x00 0x00
-#define MX91_PAD_GPIO_IO12__TPM3_CH2                                             0x0040 0x01f0 0x0000 0x01 0x00
-#define MX91_PAD_GPIO_IO12__PDM_BIT_STREAM2                                      0x0040 0x01f0 0x04cc 0x02 0x00
-#define MX91_PAD_GPIO_IO12__MEDIAMIX_DISP_DATA8                                  0x0040 0x01f0 0x0000 0x03 0x00
-#define MX91_PAD_GPIO_IO12__LPSPI8_PCS0                                          0x0040 0x01f0 0x0000 0x04 0x00
-#define MX91_PAD_GPIO_IO12__LPUART8_TX                                           0x0040 0x01f0 0x0000 0x05 0x00
-#define MX91_PAD_GPIO_IO12__LPI2C8_SDA                                           0x0040 0x01f0 0x041c 0x06 0x01
-#define MX91_PAD_GPIO_IO12__SAI3_RX_SYNC                                         0x0040 0x01f0 0x04dc 0x07 0x00
-
-#define MX91_PAD_GPIO_IO13__GPIO2_IO13                                           0x0044 0x01f4 0x0000 0x00 0x00
-#define MX91_PAD_GPIO_IO13__TPM4_CH2                                             0x0044 0x01f4 0x0000 0x01 0x00
-#define MX91_PAD_GPIO_IO13__PDM_BIT_STREAM3                                      0x0044 0x01f4 0x04d0 0x02 0x00
-#define MX91_PAD_GPIO_IO13__MEDIAMIX_DISP_DATA9                                  0x0044 0x01f4 0x0000 0x03 0x00
-#define MX91_PAD_GPIO_IO13__LPSPI8_SIN                                           0x0044 0x01f4 0x0000 0x04 0x00
-#define MX91_PAD_GPIO_IO13__LPUART8_RX                                           0x0044 0x01f4 0x0000 0x05 0x00
-#define MX91_PAD_GPIO_IO13__LPI2C8_SCL                                           0x0044 0x01f4 0x0418 0x06 0x01
-#define MX91_PAD_GPIO_IO13__FLEXIO1_FLEXIO13                                     0x0044 0x01f4 0x039c 0x07 0x00
-
-#define MX91_PAD_GPIO_IO14__GPIO2_IO14                                           0x0048 0x01f8 0x0000 0x00 0x00
-#define MX91_PAD_GPIO_IO14__LPUART3_TX                                           0x0048 0x01f8 0x0474 0x01 0x00
-#define MX91_PAD_GPIO_IO14__MEDIAMIX_CAM_DATA6                                   0x0048 0x01f8 0x04a8 0x02 0x00
-#define MX91_PAD_GPIO_IO14__MEDIAMIX_DISP_DATA10                                 0x0048 0x01f8 0x0000 0x03 0x00
-#define MX91_PAD_GPIO_IO14__LPSPI8_SOUT                                          0x0048 0x01f8 0x0000 0x04 0x00
-#define MX91_PAD_GPIO_IO14__LPUART8_CTS_B                                        0x0048 0x01f8 0x0000 0x05 0x00
-#define MX91_PAD_GPIO_IO14__LPUART4_TX                                           0x0048 0x01f8 0x0480 0x06 0x00
-#define MX91_PAD_GPIO_IO14__FLEXIO1_FLEXIO14                                     0x0048 0x01f8 0x03a0 0x07 0x00
-
-#define MX91_PAD_GPIO_IO15__GPIO2_IO15                                           0x004c 0x01fc 0x0000 0x00 0x00
-#define MX91_PAD_GPIO_IO15__LPUART3_RX                                           0x004c 0x01fc 0x0470 0x01 0x00
-#define MX91_PAD_GPIO_IO15__MEDIAMIX_CAM_DATA7                                   0x004c 0x01fc 0x04ac 0x02 0x00
-#define MX91_PAD_GPIO_IO15__MEDIAMIX_DISP_DATA11                                 0x004c 0x01fc 0x0000 0x03 0x00
-#define MX91_PAD_GPIO_IO15__LPSPI8_SCK                                           0x004c 0x01fc 0x0000 0x04 0x00
-#define MX91_PAD_GPIO_IO15__LPUART8_RTS_B                                        0x004c 0x01fc 0x0000 0x05 0x00
-#define MX91_PAD_GPIO_IO15__LPUART4_RX                                           0x004c 0x01fc 0x047c 0x06 0x00
-#define MX91_PAD_GPIO_IO15__FLEXIO1_FLEXIO15                                     0x004c 0x01fc 0x03a4 0x07 0x00
-
-#define MX91_PAD_GPIO_IO16__GPIO2_IO16                                           0x0050 0x0200 0x0000 0x00 0x00
-#define MX91_PAD_GPIO_IO16__SAI3_TX_BCLK                                         0x0050 0x0200 0x0000 0x01 0x00
-#define MX91_PAD_GPIO_IO16__PDM_BIT_STREAM2                                      0x0050 0x0200 0x04cc 0x02 0x01
-#define MX91_PAD_GPIO_IO16__MEDIAMIX_DISP_DATA12                                 0x0050 0x0200 0x0000 0x03 0x00
-#define MX91_PAD_GPIO_IO16__LPUART3_CTS_B                                        0x0050 0x0200 0x046c 0x04 0x00
-#define MX91_PAD_GPIO_IO16__LPSPI4_PCS2                                          0x0050 0x0200 0x0000 0x05 0x00
-#define MX91_PAD_GPIO_IO16__LPUART4_CTS_B                                        0x0050 0x0200 0x0478 0x06 0x00
-#define MX91_PAD_GPIO_IO16__FLEXIO1_FLEXIO16                                     0x0050 0x0200 0x03a8 0x07 0x00
-
-#define MX91_PAD_GPIO_IO17__GPIO2_IO17                                           0x0054 0x0204 0x0000 0x00 0x00
-#define MX91_PAD_GPIO_IO17__SAI3_MCLK                                            0x0054 0x0204 0x0000 0x01 0x00
-#define MX91_PAD_GPIO_IO17__MEDIAMIX_CAM_DATA8                                   0x0054 0x0204 0x04b0 0x02 0x00
-#define MX91_PAD_GPIO_IO17__MEDIAMIX_DISP_DATA13                                 0x0054 0x0204 0x0000 0x03 0x00
-#define MX91_PAD_GPIO_IO17__LPUART3_RTS_B                                        0x0054 0x0204 0x0000 0x04 0x00
-#define MX91_PAD_GPIO_IO17__LPSPI4_PCS1                                          0x0054 0x0204 0x0000 0x05 0x00
-#define MX91_PAD_GPIO_IO17__LPUART4_RTS_B                                        0x0054 0x0204 0x0000 0x06 0x00
-#define MX91_PAD_GPIO_IO17__FLEXIO1_FLEXIO17                                     0x0054 0x0204 0x03ac 0x07 0x00
-
-#define MX91_PAD_GPIO_IO18__GPIO2_IO18                                           0x0058 0x0208 0x0000 0x00 0x00
-#define MX91_PAD_GPIO_IO18__SAI3_RX_BCLK                                         0x0058 0x0208 0x04d8 0x01 0x00
-#define MX91_PAD_GPIO_IO18__MEDIAMIX_CAM_DATA9                                   0x0058 0x0208 0x04b4 0x02 0x00
-#define MX91_PAD_GPIO_IO18__MEDIAMIX_DISP_DATA14                                 0x0058 0x0208 0x0000 0x03 0x00
-#define MX91_PAD_GPIO_IO18__LPSPI5_PCS0                                          0x0058 0x0208 0x0000 0x04 0x00
-#define MX91_PAD_GPIO_IO18__LPSPI4_PCS0                                          0x0058 0x0208 0x0000 0x05 0x00
-#define MX91_PAD_GPIO_IO18__TPM5_CH2                                             0x0058 0x0208 0x0000 0x06 0x00
-#define MX91_PAD_GPIO_IO18__FLEXIO1_FLEXIO18                                     0x0058 0x0208 0x03b0 0x07 0x00
-
-#define MX91_PAD_GPIO_IO19__GPIO2_IO19                                           0x005c 0x020c 0x0000 0x00 0x00
-#define MX91_PAD_GPIO_IO19__SAI3_RX_SYNC                                         0x005c 0x020c 0x04dc 0x01 0x01
-#define MX91_PAD_GPIO_IO19__PDM_BIT_STREAM3                                      0x005c 0x020c 0x04d0 0x02 0x01
-#define MX91_PAD_GPIO_IO19__MEDIAMIX_DISP_DATA15                                 0x005c 0x020c 0x0000 0x03 0x00
-#define MX91_PAD_GPIO_IO19__LPSPI5_SIN                                           0x005c 0x020c 0x0000 0x04 0x00
-#define MX91_PAD_GPIO_IO19__LPSPI4_SIN                                           0x005c 0x020c 0x0000 0x05 0x00
-#define MX91_PAD_GPIO_IO19__TPM6_CH2                                             0x005c 0x020c 0x0000 0x06 0x00
-#define MX91_PAD_GPIO_IO19__SAI3_TX_DATA0                                        0x005c 0x020c 0x0000 0x07 0x00
-
-#define MX91_PAD_GPIO_IO20__GPIO2_IO20                                           0x0060 0x0210 0x0000 0x00 0x00
-#define MX91_PAD_GPIO_IO20__SAI3_RX_DATA0                                        0x0060 0x0210 0x0000 0x01 0x00
-#define MX91_PAD_GPIO_IO20__PDM_BIT_STREAM0                                      0x0060 0x0210 0x04c4 0x02 0x01
-#define MX91_PAD_GPIO_IO20__MEDIAMIX_DISP_DATA16                                 0x0060 0x0210 0x0000 0x03 0x00
-#define MX91_PAD_GPIO_IO20__LPSPI5_SOUT                                          0x0060 0x0210 0x0000 0x04 0x00
-#define MX91_PAD_GPIO_IO20__LPSPI4_SOUT                                          0x0060 0x0210 0x0000 0x05 0x00
-#define MX91_PAD_GPIO_IO20__TPM3_CH1                                             0x0060 0x0210 0x0000 0x06 0x00
-#define MX91_PAD_GPIO_IO20__FLEXIO1_FLEXIO20                                     0x0060 0x0210 0x03b4 0x07 0x00
-
-#define MX91_PAD_GPIO_IO21__GPIO2_IO21                                           0x0064 0x0214 0x0000 0x00 0x00
-#define MX91_PAD_GPIO_IO21__SAI3_TX_DATA0                                        0x0064 0x0214 0x0000 0x01 0x00
-#define MX91_PAD_GPIO_IO21__PDM_CLK                                              0x0064 0x0214 0x0000 0x02 0x00
-#define MX91_PAD_GPIO_IO21__MEDIAMIX_DISP_DATA17                                 0x0064 0x0214 0x0000 0x03 0x00
-#define MX91_PAD_GPIO_IO21__LPSPI5_SCK                                           0x0064 0x0214 0x0000 0x04 0x00
-#define MX91_PAD_GPIO_IO21__LPSPI4_SCK                                           0x0064 0x0214 0x0000 0x05 0x00
-#define MX91_PAD_GPIO_IO21__TPM4_CH1                                             0x0064 0x0214 0x0000 0x06 0x00
-#define MX91_PAD_GPIO_IO21__SAI3_RX_BCLK                                         0x0064 0x0214 0x04d8 0x07 0x01
-
-#define MX91_PAD_GPIO_IO22__GPIO2_IO22                                           0x0068 0x0218 0x0000 0x00 0x00
-#define MX91_PAD_GPIO_IO22__USDHC3_CLK                                           0x0068 0x0218 0x04e8 0x01 0x00
-#define MX91_PAD_GPIO_IO22__SPDIF_IN                                             0x0068 0x0218 0x04e4 0x02 0x00
-#define MX91_PAD_GPIO_IO22__MEDIAMIX_DISP_DATA18                                 0x0068 0x0218 0x0000 0x03 0x00
-#define MX91_PAD_GPIO_IO22__TPM5_CH1                                             0x0068 0x0218 0x0000 0x04 0x00
-#define MX91_PAD_GPIO_IO22__TPM6_EXTCLK                                          0x0068 0x0218 0x0000 0x05 0x00
-#define MX91_PAD_GPIO_IO22__LPI2C5_SDA                                           0x0068 0x0218 0x0404 0x06 0x01
-#define MX91_PAD_GPIO_IO22__FLEXIO1_FLEXIO22                                     0x0068 0x0218 0x03b8 0x07 0x00
-
-#define MX91_PAD_GPIO_IO23__GPIO2_IO23                                           0x006c 0x021c 0x0000 0x00 0x00
-#define MX91_PAD_GPIO_IO23__USDHC3_CMD                                           0x006c 0x021c 0x04ec 0x01 0x00
-#define MX91_PAD_GPIO_IO23__SPDIF_OUT                                            0x006c 0x021c 0x0000 0x02 0x00
-#define MX91_PAD_GPIO_IO23__MEDIAMIX_DISP_DATA19                                 0x006c 0x021c 0x0000 0x03 0x00
-#define MX91_PAD_GPIO_IO23__TPM6_CH1                                             0x006c 0x021c 0x0000 0x04 0x00
-#define MX91_PAD_GPIO_IO23__LPI2C5_SCL                                           0x006c 0x021c 0x0400 0x06 0x01
-#define MX91_PAD_GPIO_IO23__FLEXIO1_FLEXIO23                                     0x006c 0x021c 0x03bc 0x07 0x00
-
-#define MX91_PAD_GPIO_IO24__GPIO2_IO24                                           0x0070 0x0220 0x0000 0x00 0x00
-#define MX91_PAD_GPIO_IO24__USDHC3_DATA0                                         0x0070 0x0220 0x04f0 0x01 0x00
-#define MX91_PAD_GPIO_IO24__MEDIAMIX_DISP_DATA20                                 0x0070 0x0220 0x0000 0x03 0x00
-#define MX91_PAD_GPIO_IO24__TPM3_CH3                                             0x0070 0x0220 0x0000 0x04 0x00
-#define MX91_PAD_GPIO_IO24__JTAG_MUX_TDO                                         0x0070 0x0220 0x0000 0x05 0x00
-#define MX91_PAD_GPIO_IO24__LPSPI6_PCS1                                          0x0070 0x0220 0x0000 0x06 0x00
-#define MX91_PAD_GPIO_IO24__FLEXIO1_FLEXIO24                                     0x0070 0x0220 0x03c0 0x07 0x00
-
-#define MX91_PAD_GPIO_IO25__GPIO2_IO25                                           0x0074 0x0224 0x0000 0x00 0x00
-#define MX91_PAD_GPIO_IO25__USDHC3_DATA1                                         0x0074 0x0224 0x04f4 0x01 0x00
-#define MX91_PAD_GPIO_IO25__CAN2_TX                                              0x0074 0x0224 0x0000 0x02 0x00
-#define MX91_PAD_GPIO_IO25__MEDIAMIX_DISP_DATA21                                 0x0074 0x0224 0x0000 0x03 0x00
-#define MX91_PAD_GPIO_IO25__TPM4_CH3                                             0x0074 0x0224 0x0000 0x04 0x00
-#define MX91_PAD_GPIO_IO25__JTAG_MUX_TCK                                         0x0074 0x0224 0x03d4 0x05 0x01
-#define MX91_PAD_GPIO_IO25__LPSPI7_PCS1                                          0x0074 0x0224 0x0000 0x06 0x00
-#define MX91_PAD_GPIO_IO25__FLEXIO1_FLEXIO25                                     0x0074 0x0224 0x03c4 0x07 0x00
-
-#define MX91_PAD_GPIO_IO26__GPIO2_IO26                                           0x0078 0x0228 0x0000 0x00 0x00
-#define MX91_PAD_GPIO_IO26__USDHC3_DATA2                                         0x0078 0x0228 0x04f8 0x01 0x00
-#define MX91_PAD_GPIO_IO26__PDM_BIT_STREAM1                                      0x0078 0x0228 0x04c8 0x02 0x01
-#define MX91_PAD_GPIO_IO26__MEDIAMIX_DISP_DATA22                                 0x0078 0x0228 0x0000 0x03 0x00
-#define MX91_PAD_GPIO_IO26__TPM5_CH3                                             0x0078 0x0228 0x0000 0x04 0x00
-#define MX91_PAD_GPIO_IO26__JTAG_MUX_TDI                                         0x0078 0x0228 0x03d8 0x05 0x01
-#define MX91_PAD_GPIO_IO26__LPSPI8_PCS1                                          0x0078 0x0228 0x0000 0x06 0x00
-#define MX91_PAD_GPIO_IO26__SAI3_TX_SYNC                                         0x0078 0x0228 0x04e0 0x07 0x00
-
-#define MX91_PAD_GPIO_IO27__GPIO2_IO27                                           0x007c 0x022c 0x0000 0x00 0x00
-#define MX91_PAD_GPIO_IO27__USDHC3_DATA3                                         0x007c 0x022c 0x04fc 0x01 0x00
-#define MX91_PAD_GPIO_IO27__CAN2_RX                                              0x007c 0x022c 0x0364 0x02 0x01
-#define MX91_PAD_GPIO_IO27__MEDIAMIX_DISP_DATA23                                 0x007c 0x022c 0x0000 0x03 0x00
-#define MX91_PAD_GPIO_IO27__TPM6_CH3                                             0x007c 0x022c 0x0000 0x04 0x00
-#define MX91_PAD_GPIO_IO27__JTAG_MUX_TMS                                         0x007c 0x022c 0x03dc 0x05 0x01
-#define MX91_PAD_GPIO_IO27__LPSPI5_PCS1                                          0x007c 0x022c 0x0000 0x06 0x00
-#define MX91_PAD_GPIO_IO27__FLEXIO1_FLEXIO27                                     0x007c 0x022c 0x03c8 0x07 0x00
-
-#define MX91_PAD_GPIO_IO28__GPIO2_IO28                                           0x0080 0x0230 0x0000 0x00 0x00
-#define MX91_PAD_GPIO_IO28__LPI2C3_SDA                                           0x0080 0x0230 0x03f4 0x01 0x01
-#define MX91_PAD_GPIO_IO28__CAN1_TX                                              0x0080 0x0230 0x0000 0x02 0x00
-#define MX91_PAD_GPIO_IO28__FLEXIO1_FLEXIO28                                     0x0080 0x0230 0x0000 0x07 0x00
-
-#define MX91_PAD_GPIO_IO29__GPIO2_IO29                                           0x0084 0x0234 0x0000 0x00 0x00
-#define MX91_PAD_GPIO_IO29__LPI2C3_SCL                                           0x0084 0x0234 0x03f0 0x01 0x01
-#define MX91_PAD_GPIO_IO29__CAN1_RX                                              0x0084 0x0234 0x0360 0x02 0x00
-#define MX91_PAD_GPIO_IO29__FLEXIO1_FLEXIO29                                     0x0084 0x0234 0x0000 0x07 0x00
-
-#define MX91_PAD_CCM_CLKO1__CCMSRCGPCMIX_CLKO1                                   0x0088 0x0238 0x0000 0x00 0x00
-#define MX91_PAD_CCM_CLKO1__FLEXIO1_FLEXIO26                                     0x0088 0x0238 0x0000 0x04 0x00
-#define MX91_PAD_CCM_CLKO1__GPIO3_IO26                                           0x0088 0x0238 0x0000 0x05 0x00
-
-#define MX91_PAD_CCM_CLKO2__GPIO3_IO27                                           0x008c 0x023c 0x0000 0x05 0x00
-#define MX91_PAD_CCM_CLKO2__CCMSRCGPCMIX_CLKO2                                   0x008c 0x023c 0x0000 0x00 0x00
-#define MX91_PAD_CCM_CLKO2__FLEXIO1_FLEXIO27                                     0x008c 0x023c 0x03c8 0x04 0x01
-
-#define MX91_PAD_CCM_CLKO3__CCMSRCGPCMIX_CLKO3                                   0x0090 0x0240 0x0000 0x00 0x00
-#define MX91_PAD_CCM_CLKO3__FLEXIO2_FLEXIO28                                     0x0090 0x0240 0x0000 0x04 0x00
-#define MX91_PAD_CCM_CLKO3__GPIO4_IO28                                           0x0090 0x0240 0x0000 0x05 0x00
-
-#define MX91_PAD_CCM_CLKO4__CCMSRCGPCMIX_CLKO4                                   0x0094 0x0244 0x0000 0x00 0x00
-#define MX91_PAD_CCM_CLKO4__FLEXIO2_FLEXIO29                                     0x0094 0x0244 0x0000 0x04 0x00
-#define MX91_PAD_CCM_CLKO4__GPIO4_IO29                                           0x0094 0x0244 0x0000 0x05 0x00
-
-#define MX91_PAD_ENET1_MDC__ENET1_MDC                                            0x0098 0x0248 0x0000 0x00 0x00
-#define MX91_PAD_ENET1_MDC__LPUART3_DCB_B                                        0x0098 0x0248 0x0000 0x01 0x00
-#define MX91_PAD_ENET1_MDC__I3C2_SCL                                             0x0098 0x0248 0x03cc 0x02 0x00
-#define MX91_PAD_ENET1_MDC__HSIOMIX_OTG_ID1                                      0x0098 0x0248 0x0000 0x03 0x00
-#define MX91_PAD_ENET1_MDC__FLEXIO2_FLEXIO0                                      0x0098 0x0248 0x0000 0x04 0x00
-#define MX91_PAD_ENET1_MDC__GPIO4_IO0                                            0x0098 0x0248 0x0000 0x05 0x00
-#define MX91_PAD_ENET1_MDC__LPI2C1_SCL                                           0x0098 0x0248 0x03e0 0x06 0x00
-
-#define MX91_PAD_ENET1_MDIO__ENET_QOS_MDIO                                       0x009c 0x024c 0x0000 0x00 0x00
-#define MX91_PAD_ENET1_MDIO__LPUART3_RIN_B                                       0x009c 0x024c 0x0000 0x01 0x00
-#define MX91_PAD_ENET1_MDIO__I3C2_SDA                                            0x009c 0x024c 0x03d0 0x02 0x00
-#define MX91_PAD_ENET1_MDIO__HSIOMIX_OTG_PWR1                                    0x009c 0x024c 0x0000 0x03 0x00
-#define MX91_PAD_ENET1_MDIO__FLEXIO2_FLEXIO1                                     0x009c 0x024c 0x0000 0x04 0x00
-#define MX91_PAD_ENET1_MDIO__GPIO4_IO1                                           0x009c 0x024c 0x0000 0x05 0x00
-#define MX91_PAD_ENET1_MDIO__LPI2C1_SDA                                          0x009c 0x024c 0x03e4 0x06 0x00
-
-#define MX91_PAD_ENET1_TD3__ENET_QOS_RGMII_TD3                                   0x00a0 0x0250 0x0000 0x00 0x00
-#define MX91_PAD_ENET1_TD3__CAN2_TX                                              0x00a0 0x0250 0x0000 0x02 0x00
-#define MX91_PAD_ENET1_TD3__HSIOMIX_OTG_ID2                                      0x00a0 0x0250 0x0000 0x03 0x00
-#define MX91_PAD_ENET1_TD3__FLEXIO2_FLEXIO2                                      0x00a0 0x0250 0x0000 0x04 0x00
-#define MX91_PAD_ENET1_TD3__GPIO4_IO2                                            0x00a0 0x0250 0x0000 0x05 0x00
-#define MX91_PAD_ENET1_TD3__LPI2C2_SCL                                           0x00a0 0x0250 0x03e8 0x06 0x00
-
-#define MX91_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2                                   0x00a4 0x0254 0x0000 0x00 0x00
-#define MX91_PAD_ENET1_TD2__ENET_QOS_CLOCK_GENERATE_CLK                          0x00a4 0x0254 0x0000 0x01 0x00
-#define MX91_PAD_ENET1_TD2__CAN2_RX                                              0x00a4 0x0254 0x0364 0x02 0x02
-#define MX91_PAD_ENET1_TD2__HSIOMIX_OTG_OC2                                      0x00a4 0x0254 0x0000 0x03 0x00
-#define MX91_PAD_ENET1_TD2__FLEXIO2_FLEXIO3                                      0x00a4 0x0254 0x0000 0x04 0x00
-#define MX91_PAD_ENET1_TD2__GPIO4_IO3                                            0x00a4 0x0254 0x0000 0x05 0x00
-#define MX91_PAD_ENET1_TD2__LPI2C2_SDA                                           0x00a4 0x0254 0x03ec 0x06 0x00
-
-#define MX91_PAD_ENET1_TD1__ENET1_RGMII_TD1                                      0x00a8 0x0258 0x0000 0x00 0x00
-#define MX91_PAD_ENET1_TD1__LPUART3_RTS_B                                        0x00a8 0x0258 0x0000 0x01 0x00
-#define MX91_PAD_ENET1_TD1__I3C2_PUR                                             0x00a8 0x0258 0x0000 0x02 0x00
-#define MX91_PAD_ENET1_TD1__HSIOMIX_OTG_OC1                                      0x00a8 0x0258 0x0000 0x03 0x00
-#define MX91_PAD_ENET1_TD1__FLEXIO2_FLEXIO4                                      0x00a8 0x0258 0x0000 0x04 0x00
-#define MX91_PAD_ENET1_TD1__GPIO4_IO4                                            0x00a8 0x0258 0x0000 0x05 0x00
-#define MX91_PAD_ENET1_TD1__I3C2_PUR_B                                           0x00a8 0x0258 0x0000 0x06 0x00
-
-#define MX91_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0                                   0x00ac 0x025c 0x0000 0x00 0x00
-#define MX91_PAD_ENET1_TD0__LPUART3_TX                                           0x00ac 0x025c 0x0474 0x01 0x01
-#define MX91_PAD_ENET1_TD0__FLEXIO2_FLEXIO5                                      0x00ac 0x025c 0x0000 0x04 0x00
-#define MX91_PAD_ENET1_TD0__GPIO4_IO5                                            0x00ac 0x025c 0x0000 0x05 0x00
-
-#define MX91_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL                             0x00b0 0x0260 0x0000 0x00 0x00
-#define MX91_PAD_ENET1_TX_CTL__LPUART3_DTR_B                                     0x00b0 0x0260 0x0000 0x01 0x00
-#define MX91_PAD_ENET1_TX_CTL__FLEXIO2_FLEXIO6                                   0x00b0 0x0260 0x0000 0x04 0x00
-#define MX91_PAD_ENET1_TX_CTL__GPIO4_IO6                                         0x00b0 0x0260 0x0000 0x05 0x00
-#define MX91_PAD_ENET1_TX_CTL__LPSPI2_SCK                                        0x00b0 0x0260 0x043c 0x02 0x00
-
-#define MX91_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK                   0x00b4 0x0264 0x0000 0x00 0x00
-#define MX91_PAD_ENET1_TXC__ENET_QOS_TX_ER                                       0x00b4 0x0264 0x0000 0x01 0x00
-#define MX91_PAD_ENET1_TXC__FLEXIO2_FLEXIO7                                      0x00b4 0x0264 0x0000 0x04 0x00
-#define MX91_PAD_ENET1_TXC__GPIO4_IO7                                            0x00b4 0x0264 0x0000 0x05 0x00
-#define MX91_PAD_ENET1_TXC__LPSPI2_SIN                                           0x00b4 0x0264 0x0440 0x02 0x00
-
-#define MX91_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL                             0x00b8 0x0268 0x0000 0x00 0x00
-#define MX91_PAD_ENET1_RX_CTL__LPUART3_DSR_B                                     0x00b8 0x0268 0x0000 0x01 0x00
-#define MX91_PAD_ENET1_RX_CTL__HSIOMIX_OTG_PWR2                                  0x00b8 0x0268 0x0000 0x03 0x00
-#define MX91_PAD_ENET1_RX_CTL__FLEXIO2_FLEXIO8                                   0x00b8 0x0268 0x0000 0x04 0x00
-#define MX91_PAD_ENET1_RX_CTL__GPIO4_IO8                                         0x00b8 0x0268 0x0000 0x05 0x00
-#define MX91_PAD_ENET1_RX_CTL__LPSPI2_PCS0                                       0x00b8 0x0268 0x0434 0x02 0x00
-
-#define MX91_PAD_ENET1_RXC__ENET_QOS_RGMII_RXC                                   0x00bc 0x026c 0x0000 0x00 0x00
-#define MX91_PAD_ENET1_RXC__ENET_QOS_RX_ER                                       0x00bc 0x026c 0x0000 0x01 0x00
-#define MX91_PAD_ENET1_RXC__FLEXIO2_FLEXIO9                                      0x00bc 0x026c 0x0000 0x04 0x00
-#define MX91_PAD_ENET1_RXC__GPIO4_IO9                                            0x00bc 0x026c 0x0000 0x05 0x00
-#define MX91_PAD_ENET1_RXC__LPSPI2_SOUT                                          0x00bc 0x026c 0x0444 0x02 0x00
-
-#define MX91_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0                                   0x00c0 0x0270 0x0000 0x00 0x00
-#define MX91_PAD_ENET1_RD0__LPUART3_RX                                           0x00c0 0x0270 0x0470 0x01 0x01
-#define MX91_PAD_ENET1_RD0__FLEXIO2_FLEXIO10                                     0x00c0 0x0270 0x0000 0x04 0x00
-#define MX91_PAD_ENET1_RD0__GPIO4_IO10                                           0x00c0 0x0270 0x0000 0x05 0x00
-
-#define MX91_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1                                   0x00c4 0x0274 0x0000 0x00 0x00
-#define MX91_PAD_ENET1_RD1__LPUART3_CTS_B                                        0x00c4 0x0274 0x046c 0x01 0x01
-#define MX91_PAD_ENET1_RD1__LPTMR2_ALT1                                          0x00c4 0x0274 0x0448 0x03 0x00
-#define MX91_PAD_ENET1_RD1__FLEXIO2_FLEXIO11                                     0x00c4 0x0274 0x0000 0x04 0x00
-#define MX91_PAD_ENET1_RD1__GPIO4_IO11                                           0x00c4 0x0274 0x0000 0x05 0x00
-
-#define MX91_PAD_ENET1_RD2__ENET_QOS_RGMII_RD2                                   0x00c8 0x0278 0x0000 0x00 0x00
-#define MX91_PAD_ENET1_RD2__LPTMR2_ALT2                                          0x00c8 0x0278 0x044c 0x03 0x00
-#define MX91_PAD_ENET1_RD2__FLEXIO2_FLEXIO12                                     0x00c8 0x0278 0x0000 0x04 0x00
-#define MX91_PAD_ENET1_RD2__GPIO4_IO12                                           0x00c8 0x0278 0x0000 0x05 0x00
-
-#define MX91_PAD_ENET1_RD3__ENET_QOS_RGMII_RD3                                   0x00cc 0x027c 0x0000 0x00 0x00
-#define MX91_PAD_ENET1_RD3__FLEXSPI1_TESTER_TRIGGER                              0x00cc 0x027c 0x0000 0x02 0x00
-#define MX91_PAD_ENET1_RD3__LPTMR2_ALT3                                          0x00cc 0x027c 0x0450 0x03 0x00
-#define MX91_PAD_ENET1_RD3__FLEXIO2_FLEXIO13                                     0x00cc 0x027c 0x0000 0x04 0x00
-#define MX91_PAD_ENET1_RD3__GPIO4_IO13                                           0x00cc 0x027c 0x0000 0x05 0x00
-
-#define MX91_PAD_ENET2_MDC__ENET2_MDC                                            0x00d0 0x0280 0x0000 0x00 0x00
-#define MX91_PAD_ENET2_MDC__LPUART4_DCB_B                                        0x00d0 0x0280 0x0000 0x01 0x00
-#define MX91_PAD_ENET2_MDC__SAI2_RX_SYNC                                         0x00d0 0x0280 0x0000 0x02 0x00
-#define MX91_PAD_ENET2_MDC__FLEXIO2_FLEXIO14                                     0x00d0 0x0280 0x0000 0x04 0x00
-#define MX91_PAD_ENET2_MDC__GPIO4_IO14                                           0x00d0 0x0280 0x0000 0x05 0x00
-#define MX91_PAD_ENET2_MDC__MEDIAMIX_CAM_CLK                                     0x00d0 0x0280 0x04bc 0x06 0x01
-
-#define MX91_PAD_ENET2_MDIO__ENET2_MDIO                                          0x00d4 0x0284 0x0000 0x00 0x00
-#define MX91_PAD_ENET2_MDIO__LPUART4_RIN_B                                       0x00d4 0x0284 0x0000 0x01 0x00
-#define MX91_PAD_ENET2_MDIO__SAI2_RX_BCLK                                        0x00d4 0x0284 0x0000 0x02 0x00
-#define MX91_PAD_ENET2_MDIO__FLEXIO2_FLEXIO15                                    0x00d4 0x0284 0x0000 0x04 0x00
-#define MX91_PAD_ENET2_MDIO__GPIO4_IO15                                          0x00d4 0x0284 0x0000 0x05 0x00
-#define MX91_PAD_ENET2_MDIO__MEDIAMIX_CAM_DATA0                                  0x00d4 0x0284 0x0490 0x06 0x01
-
-#define MX91_PAD_ENET2_TD3__SAI2_RX_DATA0                                        0x00d8 0x0288 0x0000 0x02 0x00
-#define MX91_PAD_ENET2_TD3__FLEXIO2_FLEXIO16                                     0x00d8 0x0288 0x0000 0x04 0x00
-#define MX91_PAD_ENET2_TD3__GPIO4_IO16                                           0x00d8 0x0288 0x0000 0x05 0x00
-#define MX91_PAD_ENET2_TD3__MEDIAMIX_CAM_VSYNC                                   0x00d8 0x0288 0x04c0 0x06 0x01
-#define MX91_PAD_ENET2_TD3__ENET2_RGMII_TD3                                      0x00d8 0x0288 0x0000 0x00 0x00
-
-#define MX91_PAD_ENET2_TD2__ENET2_RGMII_TD2                                      0x00dc 0x028c 0x0000 0x00 0x00
-#define MX91_PAD_ENET2_TD2__ENET2_TX_CLK2                                        0x00dc 0x028c 0x0000 0x01 0x00
-#define MX91_PAD_ENET2_TD2__FLEXIO2_FLEXIO17                                     0x00dc 0x028c 0x0000 0x04 0x00
-#define MX91_PAD_ENET2_TD2__GPIO4_IO17                                           0x00dc 0x028c 0x0000 0x05 0x00
-#define MX91_PAD_ENET2_TD2__MEDIAMIX_CAM_HSYNC                                   0x00dc 0x028c 0x04b8 0x06 0x01
-
-#define MX91_PAD_ENET2_TD1__ENET2_RGMII_TD1                                      0x00e0 0x0290 0x0000 0x00 0x00
-#define MX91_PAD_ENET2_TD1__LPUART4_RTS_B                                        0x00e0 0x0290 0x0000 0x01 0x00
-#define MX91_PAD_ENET2_TD1__FLEXIO2_FLEXIO18                                     0x00e0 0x0290 0x0000 0x04 0x00
-#define MX91_PAD_ENET2_TD1__GPIO4_IO18                                           0x00e0 0x0290 0x0000 0x05 0x00
-#define MX91_PAD_ENET2_TD1__MEDIAMIX_CAM_DATA1                                   0x00e0 0x0290 0x0494 0x06 0x01
-
-#define MX91_PAD_ENET2_TD0__ENET2_RGMII_TD0                                      0x00e4 0x0294 0x0000 0x00 0x00
-#define MX91_PAD_ENET2_TD0__LPUART4_TX                                           0x00e4 0x0294 0x0480 0x01 0x01
-#define MX91_PAD_ENET2_TD0__FLEXIO2_FLEXIO19                                     0x00e4 0x0294 0x0000 0x04 0x00
-#define MX91_PAD_ENET2_TD0__GPIO4_IO19                                           0x00e4 0x0294 0x0000 0x05 0x00
-#define MX91_PAD_ENET2_TD0__MEDIAMIX_CAM_DATA2                                   0x00e4 0x0294 0x0498 0x06 0x01
-
-#define MX91_PAD_ENET2_TX_CTL__ENET2_RGMII_TX_CTL                                0x00e8 0x0298 0x0000 0x00 0x00
-#define MX91_PAD_ENET2_TX_CTL__LPUART4_DTR_B                                     0x00e8 0x0298 0x0000 0x01 0x00
-#define MX91_PAD_ENET2_TX_CTL__SAI2_TX_SYNC                                      0x00e8 0x0298 0x0000 0x02 0x00
-#define MX91_PAD_ENET2_TX_CTL__FLEXIO2_FLEXIO20                                  0x00e8 0x0298 0x0000 0x04 0x00
-#define MX91_PAD_ENET2_TX_CTL__GPIO4_IO20                                        0x00e8 0x0298 0x0000 0x05 0x00
-#define MX91_PAD_ENET2_TX_CTL__MEDIAMIX_CAM_DATA3                                0x00e8 0x0298 0x049c 0x06 0x01
-
-#define MX91_PAD_ENET2_TXC__ENET2_RGMII_TXC                                      0x00ec 0x029c 0x0000 0x00 0x00
-#define MX91_PAD_ENET2_TXC__ENET2_TX_ER                                          0x00ec 0x029c 0x0000 0x01 0x00
-#define MX91_PAD_ENET2_TXC__SAI2_TX_BCLK                                         0x00ec 0x029c 0x0000 0x02 0x00
-#define MX91_PAD_ENET2_TXC__FLEXIO2_FLEXIO21                                     0x00ec 0x029c 0x0000 0x04 0x00
-#define MX91_PAD_ENET2_TXC__GPIO4_IO21                                           0x00ec 0x029c 0x0000 0x05 0x00
-#define MX91_PAD_ENET2_TXC__MEDIAMIX_CAM_DATA4                                   0x00ec 0x029c 0x04a0 0x06 0x01
-
-#define MX91_PAD_ENET2_RX_CTL__ENET2_RGMII_RX_CTL                                0x00f0 0x02a0 0x0000 0x00 0x00
-#define MX91_PAD_ENET2_RX_CTL__LPUART4_DSR_B                                     0x00f0 0x02a0 0x0000 0x01 0x00
-#define MX91_PAD_ENET2_RX_CTL__SAI2_TX_DATA0                                     0x00f0 0x02a0 0x0000 0x02 0x00
-#define MX91_PAD_ENET2_RX_CTL__FLEXIO2_FLEXIO22                                  0x00f0 0x02a0 0x0000 0x04 0x00
-#define MX91_PAD_ENET2_RX_CTL__GPIO4_IO22                                        0x00f0 0x02a0 0x0000 0x05 0x00
-#define MX91_PAD_ENET2_RX_CTL__MEDIAMIX_CAM_DATA5                                0x00f0 0x02a0 0x04a4 0x06 0x01
-
-#define MX91_PAD_ENET2_RXC__ENET2_RGMII_RXC                                      0x00f4 0x02a4 0x0000 0x00 0x00
-#define MX91_PAD_ENET2_RXC__ENET2_RX_ER                                          0x00f4 0x02a4 0x0000 0x01 0x00
-#define MX91_PAD_ENET2_RXC__FLEXIO2_FLEXIO23                                     0x00f4 0x02a4 0x0000 0x04 0x00
-#define MX91_PAD_ENET2_RXC__GPIO4_IO23                                           0x00f4 0x02a4 0x0000 0x05 0x00
-#define MX91_PAD_ENET2_RXC__MEDIAMIX_CAM_DATA6                                   0x00f4 0x02a4 0x04a8 0x06 0x01
-
-#define MX91_PAD_ENET2_RD0__ENET2_RGMII_RD0                                      0x00f8 0x02a8 0x0000 0x00 0x00
-#define MX91_PAD_ENET2_RD0__LPUART4_RX                                           0x00f8 0x02a8 0x047c 0x01 0x01
-#define MX91_PAD_ENET2_RD0__FLEXIO2_FLEXIO24                                     0x00f8 0x02a8 0x0000 0x04 0x00
-#define MX91_PAD_ENET2_RD0__GPIO4_IO24                                           0x00f8 0x02a8 0x0000 0x05 0x00
-#define MX91_PAD_ENET2_RD0__MEDIAMIX_CAM_DATA7                                   0x00f8 0x02a8 0x04ac 0x06 0x01
-
-#define MX91_PAD_ENET2_RD1__ENET2_RGMII_RD1                                      0x00fc 0x02ac 0x0000 0x00 0x00
-#define MX91_PAD_ENET2_RD1__SPDIF_IN                                             0x00fc 0x02ac 0x04e4 0x01 0x01
-#define MX91_PAD_ENET2_RD1__FLEXIO2_FLEXIO25                                     0x00fc 0x02ac 0x0000 0x04 0x00
-#define MX91_PAD_ENET2_RD1__GPIO4_IO25                                           0x00fc 0x02ac 0x0000 0x05 0x00
-#define MX91_PAD_ENET2_RD1__MEDIAMIX_CAM_DATA8                                   0x00fc 0x02ac 0x04b0 0x06 0x01
-
-#define MX91_PAD_ENET2_RD2__ENET2_RGMII_RD2                                      0x0100 0x02b0 0x0000 0x00 0x00
-#define MX91_PAD_ENET2_RD2__LPUART4_CTS_B                                        0x0100 0x02b0 0x0478 0x01 0x01
-#define MX91_PAD_ENET2_RD2__SAI2_MCLK                                            0x0100 0x02b0 0x0000 0x02 0x00
-#define MX91_PAD_ENET2_RD2__MQS2_RIGHT                                           0x0100 0x02b0 0x0000 0x03 0x00
-#define MX91_PAD_ENET2_RD2__FLEXIO2_FLEXIO26                                     0x0100 0x02b0 0x0000 0x04 0x00
-#define MX91_PAD_ENET2_RD2__GPIO4_IO26                                           0x0100 0x02b0 0x0000 0x05 0x00
-#define MX91_PAD_ENET2_RD2__MEDIAMIX_CAM_DATA9                                   0x0100 0x02b0 0x04b4 0x06 0x01
-
-#define MX91_PAD_ENET2_RD3__ENET2_RGMII_RD3                                      0x0104 0x02b4 0x0000 0x00 0x00
-#define MX91_PAD_ENET2_RD3__SPDIF_OUT                                            0x0104 0x02b4 0x0000 0x01 0x00
-#define MX91_PAD_ENET2_RD3__SPDIF_IN                                             0x0104 0x02b4 0x04e4 0x02 0x02
-#define MX91_PAD_ENET2_RD3__MQS2_LEFT                                            0x0104 0x02b4 0x0000 0x03 0x00
-#define MX91_PAD_ENET2_RD3__FLEXIO2_FLEXIO27                                     0x0104 0x02b4 0x0000 0x04 0x00
-#define MX91_PAD_ENET2_RD3__GPIO4_IO27                                           0x0104 0x02b4 0x0000 0x05 0x00
-
-#define MX91_PAD_SD1_CLK__FLEXIO1_FLEXIO8                                        0x0108 0x02b8 0x038c 0x04 0x01
-#define MX91_PAD_SD1_CLK__GPIO3_IO8                                              0x0108 0x02b8 0x0000 0x05 0x00
-#define MX91_PAD_SD1_CLK__USDHC1_CLK                                             0x0108 0x02b8 0x0000 0x00 0x00
-#define MX91_PAD_SD1_CLK__LPSPI2_SCK                                             0x0108 0x02b8 0x043c 0x03 0x01
-
-#define MX91_PAD_SD1_CMD__USDHC1_CMD                                             0x010c 0x02bc 0x0000 0x00 0x00
-#define MX91_PAD_SD1_CMD__FLEXIO1_FLEXIO9                                        0x010c 0x02bc 0x0390 0x04 0x01
-#define MX91_PAD_SD1_CMD__GPIO3_IO9                                              0x010c 0x02bc 0x0000 0x05 0x00
-#define MX91_PAD_SD1_CMD__LPSPI2_SIN                                             0x010c 0x02bc 0x0440 0x03 0x01
-
-#define MX91_PAD_SD1_DATA0__USDHC1_DATA0                                         0x0110 0x02c0 0x0000 0x00 0x00
-#define MX91_PAD_SD1_DATA0__FLEXIO1_FLEXIO10                                     0x0110 0x02c0 0x0394 0x04 0x01
-#define MX91_PAD_SD1_DATA0__GPIO3_IO10                                           0x0110 0x02c0 0x0000 0x05 0x00
-#define MX91_PAD_SD1_DATA0__LPSPI2_PCS0                                          0x0110 0x02c0 0x0434 0x03 0x01
-
-#define MX91_PAD_SD1_DATA1__USDHC1_DATA1                                         0x0114 0x02c4 0x0000 0x00 0x00
-#define MX91_PAD_SD1_DATA1__FLEXIO1_FLEXIO11                                     0x0114 0x02c4 0x0398 0x04 0x01
-#define MX91_PAD_SD1_DATA1__GPIO3_IO11                                           0x0114 0x02c4 0x0000 0x05 0x00
-#define MX91_PAD_SD1_DATA1__CCMSRCGPCMIX_INT_BOOT                                0x0114 0x02c4 0x0000 0x06 0x00
-#define MX91_PAD_SD1_DATA1__LPSPI2_SOUT                                          0x0114 0x02c4 0x0444 0x03 0x01
-
-#define MX91_PAD_SD1_DATA2__USDHC1_DATA2                                         0x0118 0x02c8 0x0000 0x00 0x00
-#define MX91_PAD_SD1_DATA2__FLEXIO1_FLEXIO12                                     0x0118 0x02c8 0x0000 0x04 0x00
-#define MX91_PAD_SD1_DATA2__GPIO3_IO12                                           0x0118 0x02c8 0x0000 0x05 0x00
-#define MX91_PAD_SD1_DATA2__CCMSRCGPCMIX_PMIC_READY                              0x0118 0x02c8 0x0000 0x06 0x00
-#define MX91_PAD_SD1_DATA2__LPSPI2_PCS1                                          0x0118 0x02c8 0x0438 0x03 0x00
-
-#define MX91_PAD_SD1_DATA3__USDHC1_DATA3                                         0x011c 0x02cc 0x0000 0x00 0x00
-#define MX91_PAD_SD1_DATA3__FLEXSPI1_A_SS1_B                                     0x011c 0x02cc 0x0000 0x01 0x00
-#define MX91_PAD_SD1_DATA3__FLEXIO1_FLEXIO13                                     0x011c 0x02cc 0x039c 0x04 0x01
-#define MX91_PAD_SD1_DATA3__GPIO3_IO13                                           0x011c 0x02cc 0x0000 0x05 0x00
-#define MX91_PAD_SD1_DATA3__LPSPI1_PCS1                                          0x011c 0x02cc 0x0424 0x03 0x00
-
-#define MX91_PAD_SD1_DATA4__USDHC1_DATA4                                         0x0120 0x02d0 0x0000 0x00 0x00
-#define MX91_PAD_SD1_DATA4__FLEXSPI1_A_DATA4                                     0x0120 0x02d0 0x0000 0x01 0x00
-#define MX91_PAD_SD1_DATA4__FLEXIO1_FLEXIO14                                     0x0120 0x02d0 0x03a0 0x04 0x01
-#define MX91_PAD_SD1_DATA4__GPIO3_IO14                                           0x0120 0x02d0 0x0000 0x05 0x00
-#define MX91_PAD_SD1_DATA4__LPSPI1_PCS0                                          0x0120 0x02d0 0x0420 0x03 0x00
-
-#define MX91_PAD_SD1_DATA5__USDHC1_DATA5                                         0x0124 0x02d4 0x0000 0x00 0x00
-#define MX91_PAD_SD1_DATA5__FLEXSPI1_A_DATA5                                     0x0124 0x02d4 0x0000 0x01 0x00
-#define MX91_PAD_SD1_DATA5__USDHC1_RESET_B                                       0x0124 0x02d4 0x0000 0x02 0x00
-#define MX91_PAD_SD1_DATA5__FLEXIO1_FLEXIO15                                     0x0124 0x02d4 0x03a4 0x04 0x01
-#define MX91_PAD_SD1_DATA5__GPIO3_IO15                                           0x0124 0x02d4 0x0000 0x05 0x00
-#define MX91_PAD_SD1_DATA5__LPSPI1_SIN                                           0x0124 0x02d4 0x042c 0x03 0x00
-
-#define MX91_PAD_SD1_DATA6__USDHC1_DATA6                                         0x0128 0x02d8 0x0000 0x00 0x00
-#define MX91_PAD_SD1_DATA6__FLEXSPI1_A_DATA6                                     0x0128 0x02d8 0x0000 0x01 0x00
-#define MX91_PAD_SD1_DATA6__USDHC1_CD_B                                          0x0128 0x02d8 0x0000 0x02 0x00
-#define MX91_PAD_SD1_DATA6__FLEXIO1_FLEXIO16                                     0x0128 0x02d8 0x03a8 0x04 0x01
-#define MX91_PAD_SD1_DATA6__GPIO3_IO16                                           0x0128 0x02d8 0x0000 0x05 0x00
-#define MX91_PAD_SD1_DATA6__LPSPI1_SCK                                           0x0128 0x02d8 0x0428 0x03 0x00
-
-#define MX91_PAD_SD1_DATA7__USDHC1_DATA7                                         0x012c 0x02dc 0x0000 0x00 0x00
-#define MX91_PAD_SD1_DATA7__FLEXSPI1_A_DATA7                                     0x012c 0x02dc 0x0000 0x01 0x00
-#define MX91_PAD_SD1_DATA7__USDHC1_WP                                            0x012c 0x02dc 0x0000 0x02 0x00
-#define MX91_PAD_SD1_DATA7__FLEXIO1_FLEXIO17                                     0x012c 0x02dc 0x03ac 0x04 0x01
-#define MX91_PAD_SD1_DATA7__GPIO3_IO17                                           0x012c 0x02dc 0x0000 0x05 0x00
-#define MX91_PAD_SD1_DATA7__LPSPI1_SOUT                                          0x012c 0x02dc 0x0430 0x03 0x00
-
-#define MX91_PAD_SD1_STROBE__USDHC1_STROBE                                       0x0130 0x02e0 0x0000 0x00 0x00
-#define MX91_PAD_SD1_STROBE__FLEXSPI1_A_DQS                                      0x0130 0x02e0 0x0000 0x01 0x00
-#define MX91_PAD_SD1_STROBE__FLEXIO1_FLEXIO18                                    0x0130 0x02e0 0x03b0 0x04 0x01
-#define MX91_PAD_SD1_STROBE__GPIO3_IO18                                          0x0130 0x02e0 0x0000 0x05 0x00
-
-#define MX91_PAD_SD2_VSELECT__USDHC2_VSELECT                                     0x0134 0x02e4 0x0000 0x00 0x00
-#define MX91_PAD_SD2_VSELECT__USDHC2_WP                                          0x0134 0x02e4 0x0000 0x01 0x00
-#define MX91_PAD_SD2_VSELECT__LPTMR2_ALT3                                        0x0134 0x02e4 0x0450 0x02 0x01
-#define MX91_PAD_SD2_VSELECT__FLEXIO1_FLEXIO19                                   0x0134 0x02e4 0x0000 0x04 0x00
-#define MX91_PAD_SD2_VSELECT__GPIO3_IO19                                         0x0134 0x02e4 0x0000 0x05 0x00
-#define MX91_PAD_SD2_VSELECT__CCMSRCGPCMIX_EXT_CLK1                              0x0134 0x02e4 0x0368 0x06 0x00
-
-#define MX91_PAD_SD3_CLK__USDHC3_CLK                                             0x0138 0x02e8 0x04e8 0x00 0x01
-#define MX91_PAD_SD3_CLK__FLEXSPI1_A_SCLK                                        0x0138 0x02e8 0x0000 0x01 0x00
-#define MX91_PAD_SD3_CLK__LPUART1_CTS_B                                          0x0138 0x02e8 0x0454 0x02 0x00
-#define MX91_PAD_SD3_CLK__FLEXIO1_FLEXIO20                                       0x0138 0x02e8 0x03b4 0x04 0x01
-#define MX91_PAD_SD3_CLK__GPIO3_IO20                                             0x0138 0x02e8 0x0000 0x05 0x00
-
-#define MX91_PAD_SD3_CMD__USDHC3_CMD                                             0x013c 0x02ec 0x04ec 0x00 0x01
-#define MX91_PAD_SD3_CMD__FLEXSPI1_A_SS0_B                                       0x013c 0x02ec 0x0000 0x01 0x00
-#define MX91_PAD_SD3_CMD__LPUART1_RTS_B                                          0x013c 0x02ec 0x0000 0x02 0x00
-#define MX91_PAD_SD3_CMD__FLEXIO1_FLEXIO21                                       0x013c 0x02ec 0x0000 0x04 0x00
-#define MX91_PAD_SD3_CMD__GPIO3_IO21                                             0x013c 0x02ec 0x0000 0x05 0x00
-
-#define MX91_PAD_SD3_DATA0__USDHC3_DATA0                                         0x0140 0x02f0 0x04f0 0x00 0x01
-#define MX91_PAD_SD3_DATA0__FLEXSPI1_A_DATA0                                     0x0140 0x02f0 0x0000 0x01 0x00
-#define MX91_PAD_SD3_DATA0__LPUART2_CTS_B                                        0x0140 0x02f0 0x0460 0x02 0x00
-#define MX91_PAD_SD3_DATA0__FLEXIO1_FLEXIO22                                     0x0140 0x02f0 0x03b8 0x04 0x01
-#define MX91_PAD_SD3_DATA0__GPIO3_IO22                                           0x0140 0x02f0 0x0000 0x05 0x00
-
-#define MX91_PAD_SD3_DATA1__USDHC3_DATA1                                         0x0144 0x02f4 0x04f4 0x00 0x01
-#define MX91_PAD_SD3_DATA1__FLEXSPI1_A_DATA1                                     0x0144 0x02f4 0x0000 0x01 0x00
-#define MX91_PAD_SD3_DATA1__LPUART2_RTS_B                                        0x0144 0x02f4 0x0000 0x02 0x00
-#define MX91_PAD_SD3_DATA1__FLEXIO1_FLEXIO23                                     0x0144 0x02f4 0x03bc 0x04 0x01
-#define MX91_PAD_SD3_DATA1__GPIO3_IO23                                           0x0144 0x02f4 0x0000 0x05 0x00
-
-#define MX91_PAD_SD3_DATA2__USDHC3_DATA2                                         0x0148 0x02f8 0x04f8 0x00 0x01
-#define MX91_PAD_SD3_DATA2__LPI2C4_SDA                                           0x0148 0x02f8 0x03fc 0x02 0x01
-#define MX91_PAD_SD3_DATA2__FLEXSPI1_A_DATA2                                     0x0148 0x02f8 0x0000 0x01 0x00
-#define MX91_PAD_SD3_DATA2__FLEXIO1_FLEXIO24                                     0x0148 0x02f8 0x03c0 0x04 0x01
-#define MX91_PAD_SD3_DATA2__GPIO3_IO24                                           0x0148 0x02f8 0x0000 0x05 0x00
-
-#define MX91_PAD_SD3_DATA3__USDHC3_DATA3                                         0x014c 0x02fc 0x04fc 0x00 0x01
-#define MX91_PAD_SD3_DATA3__FLEXSPI1_A_DATA3                                     0x014c 0x02fc 0x0000 0x01 0x00
-#define MX91_PAD_SD3_DATA3__LPI2C4_SCL                                           0x014c 0x02fc 0x03f8 0x02 0x01
-#define MX91_PAD_SD3_DATA3__FLEXIO1_FLEXIO25                                     0x014c 0x02fc 0x03c4 0x04 0x01
-#define MX91_PAD_SD3_DATA3__GPIO3_IO25                                           0x014c 0x02fc 0x0000 0x05 0x00
-
-#define MX91_PAD_SD2_CD_B__USDHC2_CD_B                                           0x0150 0x0300 0x0000 0x00 0x00
-#define MX91_PAD_SD2_CD_B__ENET_QOS_1588_EVENT0_IN                               0x0150 0x0300 0x0000 0x01 0x00
-#define MX91_PAD_SD2_CD_B__I3C2_SCL                                              0x0150 0x0300 0x03cc 0x02 0x01
-#define MX91_PAD_SD2_CD_B__FLEXIO1_FLEXIO0                                       0x0150 0x0300 0x036c 0x04 0x01
-#define MX91_PAD_SD2_CD_B__GPIO3_IO0                                             0x0150 0x0300 0x0000 0x05 0x00
-#define MX91_PAD_SD2_CD_B__LPI2C1_SCL                                            0x0150 0x0300 0x03e0 0x03 0x01
-
-#define MX91_PAD_SD2_CLK__USDHC2_CLK                                             0x0154 0x0304 0x0000 0x00 0x00
-#define MX91_PAD_SD2_CLK__ENET_QOS_1588_EVENT0_OUT                               0x0154 0x0304 0x0000 0x01 0x00
-#define MX91_PAD_SD2_CLK__I2C1_SDA                                               0x0154 0x0304 0x0000 0x03 0x00
-#define MX91_PAD_SD2_CLK__I3C2_SDA                                               0x0154 0x0304 0x03d0 0x02 0x01
-#define MX91_PAD_SD2_CLK__FLEXIO1_FLEXIO1                                        0x0154 0x0304 0x0370 0x04 0x01
-#define MX91_PAD_SD2_CLK__GPIO3_IO1                                              0x0154 0x0304 0x0000 0x05 0x00
-#define MX91_PAD_SD2_CLK__CCMSRCGPCMIX_OBSERVE0                                  0x0154 0x0304 0x0000 0x06 0x00
-#define MX91_PAD_SD2_CLK__LPI2C1_SDA                                             0x0154 0x0304 0x03e4 0x03 0x01
-
-#define MX91_PAD_SD2_CMD__USDHC2_CMD                                             0x0158 0x0308 0x0000 0x00 0x00
-#define MX91_PAD_SD2_CMD__ENET2_1588_EVENT0_IN                                   0x0158 0x0308 0x0000 0x01 0x00
-#define MX91_PAD_SD2_CMD__I3C2_PUR                                               0x0158 0x0308 0x0000 0x02 0x00
-#define MX91_PAD_SD2_CMD__I3C2_PUR_B                                             0x0158 0x0308 0x0000 0x03 0x00
-#define MX91_PAD_SD2_CMD__FLEXIO1_FLEXIO2                                        0x0158 0x0308 0x0374 0x04 0x01
-#define MX91_PAD_SD2_CMD__GPIO3_IO2                                              0x0158 0x0308 0x0000 0x05 0x00
-#define MX91_PAD_SD2_CMD__CCMSRCGPCMIX_OBSERVE1                                  0x0158 0x0308 0x0000 0x06 0x00
-
-#define MX91_PAD_SD2_DATA0__USDHC2_DATA0                                         0x015c 0x030c 0x0000 0x00 0x00
-#define MX91_PAD_SD2_DATA0__ENET2_1588_EVENT0_OUT                                0x015c 0x030c 0x0000 0x01 0x00
-#define MX91_PAD_SD2_DATA0__CAN2_TX                                              0x015c 0x030c 0x0000 0x02 0x00
-#define MX91_PAD_SD2_DATA0__FLEXIO1_FLEXIO3                                      0x015c 0x030c 0x0378 0x04 0x01
-#define MX91_PAD_SD2_DATA0__GPIO3_IO3                                            0x015c 0x030c 0x0000 0x05 0x00
-#define MX91_PAD_SD2_DATA0__LPUART1_TX                                           0x015c 0x030c 0x045c 0x03 0x00
-#define MX91_PAD_SD2_DATA0__CCMSRCGPCMIX_OBSERVE2                                0x015c 0x030c 0x0000 0x06 0x00
-
-#define MX91_PAD_SD2_DATA1__USDHC2_DATA1                                         0x0160 0x0310 0x0000 0x00 0x00
-#define MX91_PAD_SD2_DATA1__ENET2_1588_EVENT1_IN                                 0x0160 0x0310 0x0000 0x01 0x00
-#define MX91_PAD_SD2_DATA1__CAN2_RX                                              0x0160 0x0310 0x0364 0x02 0x03
-#define MX91_PAD_SD2_DATA1__FLEXIO1_FLEXIO4                                      0x0160 0x0310 0x037c 0x04 0x01
-#define MX91_PAD_SD2_DATA1__GPIO3_IO4                                            0x0160 0x0310 0x0000 0x05 0x00
-#define MX91_PAD_SD2_DATA1__LPUART1_RX                                           0x0160 0x0310 0x0458 0x03 0x00
-#define MX91_PAD_SD2_DATA1__CCMSRCGPCMIX_WAIT                                    0x0160 0x0310 0x0000 0x06 0x00
-
-#define MX91_PAD_SD2_DATA2__USDHC2_DATA2                                         0x0164 0x0314 0x0000 0x00 0x00
-#define MX91_PAD_SD2_DATA2__ENET2_1588_EVENT1_OUT                                0x0164 0x0314 0x0000 0x01 0x00
-#define MX91_PAD_SD2_DATA2__MQS2_RIGHT                                           0x0164 0x0314 0x0000 0x02 0x00
-#define MX91_PAD_SD2_DATA2__FLEXIO1_FLEXIO5                                      0x0164 0x0314 0x0380 0x04 0x01
-#define MX91_PAD_SD2_DATA2__GPIO3_IO5                                            0x0164 0x0314 0x0000 0x05 0x00
-#define MX91_PAD_SD2_DATA2__LPUART2_TX                                           0x0164 0x0314 0x0468 0x03 0x00
-#define MX91_PAD_SD2_DATA2__CCMSRCGPCMIX_STOP                                    0x0164 0x0314 0x0000 0x06 0x00
-
-#define MX91_PAD_SD2_DATA3__USDHC2_DATA3                                         0x0168 0x0318 0x0000 0x00 0x00
-#define MX91_PAD_SD2_DATA3__LPTMR2_ALT1                                          0x0168 0x0318 0x0448 0x01 0x01
-#define MX91_PAD_SD2_DATA3__MQS2_LEFT                                            0x0168 0x0318 0x0000 0x02 0x00
-#define MX91_PAD_SD2_DATA3__FLEXIO1_FLEXIO6                                      0x0168 0x0318 0x0384 0x04 0x01
-#define MX91_PAD_SD2_DATA3__GPIO3_IO6                                            0x0168 0x0318 0x0000 0x05 0x00
-#define MX91_PAD_SD2_DATA3__LPUART2_RX                                           0x0168 0x0318 0x0464 0x03 0x00
-#define MX91_PAD_SD2_DATA3__CCMSRCGPCMIX_EARLY_RESET                             0x0168 0x0318 0x0000 0x06 0x00
-
-#define MX91_PAD_SD2_RESET_B__USDHC2_RESET_B                                     0x016c 0x031c 0x0000 0x00 0x00
-#define MX91_PAD_SD2_RESET_B__LPTMR2_ALT2                                        0x016c 0x031c 0x044c 0x01 0x01
-#define MX91_PAD_SD2_RESET_B__FLEXIO1_FLEXIO7                                    0x016c 0x031c 0x0388 0x04 0x01
-#define MX91_PAD_SD2_RESET_B__GPIO3_IO7                                          0x016c 0x031c 0x0000 0x05 0x00
-#define MX91_PAD_SD2_RESET_B__CCMSRCGPCMIX_SYSTEM_RESET                          0x016c 0x031c 0x0000 0x06 0x00
-
-#define MX91_PAD_I2C1_SCL__LPI2C1_SCL                                            0x0170 0x0320 0x03e0 0x00 0x02
-#define MX91_PAD_I2C1_SCL__I3C1_SCL                                              0x0170 0x0320 0x0000 0x01 0x00
-#define MX91_PAD_I2C1_SCL__LPUART1_DCB_B                                         0x0170 0x0320 0x0000 0x02 0x00
-#define MX91_PAD_I2C1_SCL__TPM2_CH0                                              0x0170 0x0320 0x0000 0x03 0x00
-#define MX91_PAD_I2C1_SCL__GPIO1_IO0                                             0x0170 0x0320 0x0000 0x05 0x00
-
-#define MX91_PAD_I2C1_SDA__LPI2C1_SDA                                            0x0174 0x0324 0x03e4 0x00 0x02
-#define MX91_PAD_I2C1_SDA__I3C1_SDA                                              0x0174 0x0324 0x0000 0x01 0x00
-#define MX91_PAD_I2C1_SDA__LPUART1_RIN_B                                         0x0174 0x0324 0x0000 0x02 0x00
-#define MX91_PAD_I2C1_SDA__TPM2_CH1                                              0x0174 0x0324 0x0000 0x03 0x00
-#define MX91_PAD_I2C1_SDA__GPIO1_IO1                                             0x0174 0x0324 0x0000 0x05 0x00
-
-#define MX91_PAD_I2C2_SCL__LPI2C2_SCL                                            0x0178 0x0328 0x03e8 0x00 0x01
-#define MX91_PAD_I2C2_SCL__I3C1_PUR                                              0x0178 0x0328 0x0000 0x01 0x00
-#define MX91_PAD_I2C2_SCL__LPUART2_DCB_B                                         0x0178 0x0328 0x0000 0x02 0x00
-#define MX91_PAD_I2C2_SCL__TPM2_CH2                                              0x0178 0x0328 0x0000 0x03 0x00
-#define MX91_PAD_I2C2_SCL__SAI1_RX_SYNC                                          0x0178 0x0328 0x0000 0x04 0x00
-#define MX91_PAD_I2C2_SCL__GPIO1_IO2                                             0x0178 0x0328 0x0000 0x05 0x00
-#define MX91_PAD_I2C2_SCL__I3C1_PUR_B                                            0x0178 0x0328 0x0000 0x06 0x00
-
-#define MX91_PAD_I2C2_SDA__LPI2C2_SDA                                            0x017c 0x032c 0x03ec 0x00 0x01
-#define MX91_PAD_I2C2_SDA__LPUART2_RIN_B                                         0x017c 0x032c 0x0000 0x02 0x00
-#define MX91_PAD_I2C2_SDA__TPM2_CH3                                              0x017c 0x032c 0x0000 0x03 0x00
-#define MX91_PAD_I2C2_SDA__SAI1_RX_BCLK                                          0x017c 0x032c 0x0000 0x04 0x00
-#define MX91_PAD_I2C2_SDA__GPIO1_IO3                                             0x017c 0x032c 0x0000 0x05 0x00
-
-#define MX91_PAD_UART1_RXD__LPUART1_RX                                           0x0180 0x0330 0x0458 0x00 0x01
-#define MX91_PAD_UART1_RXD__ELE_UART_RX                                          0x0180 0x0330 0x0000 0x01 0x00
-#define MX91_PAD_UART1_RXD__LPSPI2_SIN                                           0x0180 0x0330 0x0440 0x02 0x02
-#define MX91_PAD_UART1_RXD__TPM1_CH0                                             0x0180 0x0330 0x0000 0x03 0x00
-#define MX91_PAD_UART1_RXD__GPIO1_IO4                                            0x0180 0x0330 0x0000 0x05 0x00
-
-#define MX91_PAD_UART1_TXD__LPUART1_TX                                           0x0184 0x0334 0x045c 0x00 0x01
-#define MX91_PAD_UART1_TXD__ELE_UART_TX                                          0x0184 0x0334 0x0000 0x01 0x00
-#define MX91_PAD_UART1_TXD__LPSPI2_PCS0                                          0x0184 0x0334 0x0434 0x02 0x02
-#define MX91_PAD_UART1_TXD__TPM1_CH1                                             0x0184 0x0334 0x0000 0x03 0x00
-#define MX91_PAD_UART1_TXD__GPIO1_IO5                                            0x0184 0x0334 0x0000 0x05 0x00
-
-#define MX91_PAD_UART2_RXD__LPUART2_RX                                           0x0188 0x0338 0x0464 0x00 0x01
-#define MX91_PAD_UART2_RXD__LPUART1_CTS_B                                        0x0188 0x0338 0x0454 0x01 0x01
-#define MX91_PAD_UART2_RXD__LPSPI2_SOUT                                          0x0188 0x0338 0x0444 0x02 0x02
-#define MX91_PAD_UART2_RXD__TPM1_CH2                                             0x0188 0x0338 0x0000 0x03 0x00
-#define MX91_PAD_UART2_RXD__SAI1_MCLK                                            0x0188 0x0338 0x04d4 0x04 0x00
-#define MX91_PAD_UART2_RXD__GPIO1_IO6                                            0x0188 0x0338 0x0000 0x05 0x00
-
-#define MX91_PAD_UART2_TXD__LPUART2_TX                                           0x018c 0x033c 0x0468 0x00 0x01
-#define MX91_PAD_UART2_TXD__LPUART1_RTS_B                                        0x018c 0x033c 0x0000 0x01 0x00
-#define MX91_PAD_UART2_TXD__LPSPI2_SCK                                           0x018c 0x033c 0x043c 0x02 0x02
-#define MX91_PAD_UART2_TXD__TPM1_CH3                                             0x018c 0x033c 0x0000 0x03 0x00
-#define MX91_PAD_UART2_TXD__GPIO1_IO7                                            0x018c 0x033c 0x0000 0x05 0x00
-#define MX91_PAD_UART2_TXD__SAI3_TX_SYNC                                         0x018c 0x033c 0x04e0 0x07 0x02
-
-#define MX91_PAD_PDM_CLK__PDM_CLK                                                0x0190 0x0340 0x0000 0x00 0x00
-#define MX91_PAD_PDM_CLK__MQS1_LEFT                                              0x0190 0x0340 0x0000 0x01 0x00
-#define MX91_PAD_PDM_CLK__LPTMR1_ALT1                                            0x0190 0x0340 0x0000 0x04 0x00
-#define MX91_PAD_PDM_CLK__GPIO1_IO8                                              0x0190 0x0340 0x0000 0x05 0x00
-#define MX91_PAD_PDM_CLK__CAN1_TX                                                0x0190 0x0340 0x0000 0x06 0x00
-
-#define MX91_PAD_PDM_BIT_STREAM0__PDM_BIT_STREAM0                                0x0194 0x0344 0x04c4 0x00 0x02
-#define MX91_PAD_PDM_BIT_STREAM0__MQS1_RIGHT                                     0x0194 0x0344 0x0000 0x01 0x00
-#define MX91_PAD_PDM_BIT_STREAM0__LPSPI1_PCS1                                    0x0194 0x0344 0x0424 0x02 0x01
-#define MX91_PAD_PDM_BIT_STREAM0__TPM1_EXTCLK                                    0x0194 0x0344 0x0000 0x03 0x00
-#define MX91_PAD_PDM_BIT_STREAM0__LPTMR1_ALT2                                    0x0194 0x0344 0x0000 0x04 0x00
-#define MX91_PAD_PDM_BIT_STREAM0__GPIO1_IO9                                      0x0194 0x0344 0x0000 0x05 0x00
-#define MX91_PAD_PDM_BIT_STREAM0__CAN1_RX                                        0x0194 0x0344 0x0360 0x06 0x01
-
-#define MX91_PAD_PDM_BIT_STREAM1__PDM_BIT_STREAM1                                0x0198 0x0348 0x04c8 0x00 0x02
-#define MX91_PAD_PDM_BIT_STREAM1__LPSPI2_PCS1                                    0x0198 0x0348 0x0438 0x02 0x01
-#define MX91_PAD_PDM_BIT_STREAM1__TPM2_EXTCLK                                    0x0198 0x0348 0x0000 0x03 0x00
-#define MX91_PAD_PDM_BIT_STREAM1__LPTMR1_ALT3                                    0x0198 0x0348 0x0000 0x04 0x00
-#define MX91_PAD_PDM_BIT_STREAM1__GPIO1_IO10                                     0x0198 0x0348 0x0000 0x05 0x00
-#define MX91_PAD_PDM_BIT_STREAM1__CCMSRCGPCMIX_EXT_CLK1                          0x0198 0x0348 0x0368 0x06 0x01
-
-#define MX91_PAD_SAI1_TXFS__SAI1_TX_SYNC                                         0x019c 0x034c 0x0000 0x00 0x00
-#define MX91_PAD_SAI1_TXFS__SAI1_TX_DATA1                                        0x019c 0x034c 0x0000 0x01 0x00
-#define MX91_PAD_SAI1_TXFS__LPSPI1_PCS0                                          0x019c 0x034c 0x0420 0x02 0x01
-#define MX91_PAD_SAI1_TXFS__LPUART2_DTR_B                                        0x019c 0x034c 0x0000 0x03 0x00
-#define MX91_PAD_SAI1_TXFS__MQS1_LEFT                                            0x019c 0x034c 0x0000 0x04 0x00
-#define MX91_PAD_SAI1_TXFS__GPIO1_IO11                                           0x019c 0x034c 0x0000 0x05 0x00
-
-#define MX91_PAD_SAI1_TXC__SAI1_TX_BCLK                                          0x01a0 0x0350 0x0000 0x00 0x00
-#define MX91_PAD_SAI1_TXC__LPUART2_CTS_B                                         0x01a0 0x0350 0x0460 0x01 0x01
-#define MX91_PAD_SAI1_TXC__LPSPI1_SIN                                            0x01a0 0x0350 0x042c 0x02 0x01
-#define MX91_PAD_SAI1_TXC__LPUART1_DSR_B                                         0x01a0 0x0350 0x0000 0x03 0x00
-#define MX91_PAD_SAI1_TXC__CAN1_RX                                               0x01a0 0x0350 0x0360 0x04 0x02
-#define MX91_PAD_SAI1_TXC__GPIO1_IO12                                            0x01a0 0x0350 0x0000 0x05 0x00
-
-#define MX91_PAD_SAI1_TXD0__SAI1_TX_DATA0                                        0x01a4 0x0354 0x0000 0x00 0x00
-#define MX91_PAD_SAI1_TXD0__LPUART2_RTS_B                                        0x01a4 0x0354 0x0000 0x01 0x00
-#define MX91_PAD_SAI1_TXD0__LPSPI1_SCK                                           0x01a4 0x0354 0x0428 0x02 0x01
-#define MX91_PAD_SAI1_TXD0__LPUART1_DTR_B                                        0x01a4 0x0354 0x0000 0x03 0x00
-#define MX91_PAD_SAI1_TXD0__CAN1_TX                                              0x01a4 0x0354 0x0000 0x04 0x00
-#define MX91_PAD_SAI1_TXD0__GPIO1_IO13                                           0x01a4 0x0354 0x0000 0x05 0x00
-#define MX91_PAD_SAI1_TXD0__SAI1_MCLK                                            0x01a4 0x0354 0x04d4 0x06 0x01
-
-#define MX91_PAD_SAI1_RXD0__SAI1_RX_DATA0                                        0x01a8 0x0358 0x0000 0x00 0x00
-#define MX91_PAD_SAI1_RXD0__SAI1_MCLK                                            0x01a8 0x0358 0x04d4 0x01 0x02
-#define MX91_PAD_SAI1_RXD0__LPSPI1_SOUT                                          0x01a8 0x0358 0x0430 0x02 0x01
-#define MX91_PAD_SAI1_RXD0__LPUART2_DSR_B                                        0x01a8 0x0358 0x0000 0x03 0x00
-#define MX91_PAD_SAI1_RXD0__MQS1_RIGHT                                           0x01a8 0x0358 0x0000 0x04 0x00
-#define MX91_PAD_SAI1_RXD0__GPIO1_IO14                                           0x01a8 0x0358 0x0000 0x05 0x00
-
-#define MX91_PAD_WDOG_ANY__WDOG1_WDOG_ANY                                        0x01ac 0x035c 0x0000 0x00 0x00
-#define MX91_PAD_WDOG_ANY__GPIO1_IO15                                            0x01ac 0x035c 0x0000 0x05 0x00
-#endif /* __DTS_IMX91_PINFUNC_H */
diff --git a/arch/arm/dts/imx91.dtsi b/arch/arm/dts/imx91.dtsi
deleted file mode 100644
index 9963f0bb5ce..00000000000
--- a/arch/arm/dts/imx91.dtsi
+++ /dev/null
@@ -1,53 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2024 NXP
- */
-
-#include "imx91-pinfunc.h"
-#include "imx93.dtsi"
-
-/delete-node/ &A55_1;
-/delete-node/ &mlmix;
-/delete-node/ &mu1;
-/delete-node/ &mu2;
-
-&clk {
-	compatible = "fsl,imx91-ccm";
-};
-
-&eqos {
-	clocks = <&clk IMX91_CLK_ENET1_QOS_TSN_GATE>,
-			<&clk IMX91_CLK_ENET1_QOS_TSN_GATE>,
-			<&clk IMX91_CLK_ENET_TIMER>,
-			<&clk IMX91_CLK_ENET1_QOS_TSN>,
-			<&clk IMX91_CLK_ENET1_QOS_TSN_GATE>;
-	assigned-clocks = <&clk IMX91_CLK_ENET_TIMER>,
-				<&clk IMX91_CLK_ENET1_QOS_TSN>;
-	assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
-					<&clk IMX93_CLK_SYS_PLL_PFD0_DIV2>;
-};
-
-&fec {
-	clocks = <&clk IMX91_CLK_ENET2_REGULAR_GATE>,
-			<&clk IMX91_CLK_ENET2_REGULAR_GATE>,
-			<&clk IMX91_CLK_ENET_TIMER>,
-			<&clk IMX91_CLK_ENET2_REGULAR>,
-			<&clk IMX93_CLK_DUMMY>;
-	assigned-clocks = <&clk IMX91_CLK_ENET_TIMER>,
-				<&clk IMX91_CLK_ENET2_REGULAR>;
-	assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
-					<&clk IMX93_CLK_SYS_PLL_PFD0_DIV2>;
-	assigned-clock-rates = <100000000>, <250000000>;
-};
-
-&iomuxc {
-	compatible = "fsl,imx91-iomuxc";
-};
-
-&tmu {
-	status = "disabled";
-};
-
-&{/thermal-zones/cpu-thermal/cooling-maps/map0} {
-	cooling-device = <&A55_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-};
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index f072e6a9e3d..94958fc3c46 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -68,6 +68,7 @@ config TARGET_IMX91_11X11_EVK
 	select IMX91
 	imply BOOTSTD_FULL
 	imply BOOTSTD_BOOTCOMMAND
+	imply OF_UPSTREAM
 
 config TARGET_IMX91_11X11_FRDM
 	bool "imx91_11x11_frdm"
@@ -76,6 +77,7 @@ config TARGET_IMX91_11X11_FRDM
 	select IMX9_LPDDR4X
 	imply BOOTSTD_FULL
 	imply BOOTSTD_BOOTCOMMAND
+	imply OF_UPSTREAM
 
 config TARGET_IMX93_9X9_QSB
 	bool "imx93_qsb"
diff --git a/configs/imx91_11x11_evk_defconfig b/configs/imx91_11x11_evk_defconfig
index 2381e5fdc50..5022b1473e4 100644
--- a/configs/imx91_11x11_evk_defconfig
+++ b/configs/imx91_11x11_evk_defconfig
@@ -11,7 +11,7 @@ CONFIG_ENV_SIZE=0x4000
 CONFIG_ENV_OFFSET=0x700000
 CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/imximage.cfg"
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx91-11x11-evk"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx91-11x11-evk"
 CONFIG_TARGET_IMX91_11X11_EVK=y
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_MONITOR_LEN=524288
diff --git a/configs/imx91_11x11_evk_inline_ecc_defconfig b/configs/imx91_11x11_evk_inline_ecc_defconfig
index eabe93ea027..e97cac84965 100644
--- a/configs/imx91_11x11_evk_inline_ecc_defconfig
+++ b/configs/imx91_11x11_evk_inline_ecc_defconfig
@@ -11,7 +11,7 @@ CONFIG_ENV_SIZE=0x4000
 CONFIG_ENV_OFFSET=0x700000
 CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/imximage.cfg"
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx91-11x11-evk"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx91-11x11-evk"
 CONFIG_TARGET_IMX91_11X11_EVK=y
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_MONITOR_LEN=524288
diff --git a/configs/imx91_11x11_frdm_defconfig b/configs/imx91_11x11_frdm_defconfig
index da3e95fb9d0..4d6aff088cb 100644
--- a/configs/imx91_11x11_frdm_defconfig
+++ b/configs/imx91_11x11_frdm_defconfig
@@ -10,7 +10,7 @@ CONFIG_ENV_SIZE=0x4000
 CONFIG_ENV_OFFSET=0x700000
 CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/imximage.cfg"
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx91-11x11-frdm"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx91-11x11-frdm"
 CONFIG_TARGET_IMX91_11X11_FRDM=y
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_MONITOR_LEN=524288

-- 
2.34.1

