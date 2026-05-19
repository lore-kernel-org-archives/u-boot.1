Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4621CD5BA6
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 12:57:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CECF847F6;
	Tue, 19 May 2026 14:56:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="H3vwp4Dw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B6948469D; Tue, 19 May 2026 08:21:16 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50FE584119
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 08:21:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dWD5Dov5OkfeHgOThJjt2U1/SqTWXtaZ/DnRLbqsBTdgGk9CfOH5vmN2ufq6774wniSBx7srFS+gwzZRl4ndyZrUqEVA3JHF+BEybMmeH2dqkFKtseWXDOn4XydtosXC35rPj3SUIxgJX8RDydSE+aXSBLILqDhdvwZ6cMO+fTIDF+AoTEfOraS+g2TsTZSSj1JfZHPwjHWMeLI3xIlFac6xeHnvagQKoXF/hHtTF+uWf3vpsgYVsh2n8/bA1WWQ/BMnF8Jk3q0WJqqkR+wxw4dL4ExL4lQ3CLxW3cd+XMrz5VTuDHeO2+kFpP9upHUIhijK2oCjb12HFHFqdC3B4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTjFIvKdlOwC/WYwbUXMm9EwYRhzk8JHl0UUlWgvm7c=;
 b=hBcONd4MTcTPZDP8E5jj3iEJDKbVCTE+tX0eYjnv+E3Swrxggmi5XVAiL7diMHxILyVjoFs2SIETmsKUF29AQVkP7p2j1HnKc/zz1n0Hrs9rnDFcTvS3B/xDS8xkzhg+0ivaY6O//rIcUCVmKm7tN4yn2BQF+JMVQZxoYwvxi1yjXGoiJ2L+kdPhHE7ealTUeql7GEcxljk2+fCPAXmyVDPyQW1kskLEPUFYuafpJwO5MtQOrARdHyg4IuSQx4kClPq5dwnsDqp5vYLfKkARjpt5ky+3pJzu/CLcJ6LAYorLR/mgXiJeAwbjtirB2V4yK7VoE68Xd9BQAUXNOtlDCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTjFIvKdlOwC/WYwbUXMm9EwYRhzk8JHl0UUlWgvm7c=;
 b=H3vwp4Dwxmt18OtiTzZgL392zOLTyPk8ky2t9ZM2tkqWrXamFzEWQxN78RnxhnVy3kJbbrw29Q5jOfzgnAoSZxLLSk5aRJKu4oWkOlQk4hPPH1cxn1p7wytnQKxakWm4orLgB/8d3UU0MowkyHSomOcoG+OqTev2uH0RUwOx7YZj/jnwiY9KtkjeWVhVpTMZf8P+w0mq3GPoT5zzZMQDud+WrnaCdogcbqbRaTthTsUJiVxD/dd0CwA5OpGdu49eLfyDonts0KXWhfEmyjxtMqSDjRxtpNHkS/XGG5Fix5YLBOhpVkZjd2zqKR8t0ujmzKUnC6tcBWk3KaBzcD9VEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI0PR04MB10902.eurprd04.prod.outlook.com (2603:10a6:800:26c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Tue, 19 May
 2026 06:21:09 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 06:21:09 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 19 May 2026 14:22:08 +0800
Subject: [PATCH v4 8/8] imx: Remove hardcoded watchdog base address macros
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-wdtv4-v1-8-deef133b81cd@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI0PR04MB10902:EE_
X-MS-Office365-Filtering-Correlation-Id: fa88899f-dde3-4ff2-891d-08deb56ed0f5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|376014|52116014|7416014|18002099003|22082099003|56012099003|38350700014|11063799003;
X-Microsoft-Antispam-Message-Info: nIULcS1kiQXfdqwMlfph1gT3gphnNxJy4v5Xc70jwnfvPShtgSRqRA4uubhHneykShghkNSrdDytfeG/Jr2FYknsCeXxnFtnELV+FdQmNpQ7iJNqyureNwsg59/LarwaXfugVjEUSpfZr+AWU3mEXxtdfQy4MmZPE5wXohAKcpaLz5xi73tQHXsWB0jxM70z7bo888k+q4M/nwKGGyvg7UqNw6jAxNjLK5ImMfZBGAQ8goufUGJifkfHxWZCcy0pXwxVFFDsqwsFVJrlfjy2g7ik2OBYhDaIp88+449xgd9aWxi14Gza64ucTbwseMvcuBaxOPSte3ovPvbrjlADWKEHKM7JaB4iPIuJYwpJ0XmhZuPsnuqwMpaDKsoRXc9Wi6KI+ZwtO1nXcMexsXiZNcLjsv9KYXk++wBI/HWLzSxrWPWwazwGfmMYiH+txsI/8wR8Qk+ldD4D4LvkQBtqpQxM1zkJHeOm4Su1/SlYoifcRjk4ieo6MG031ECRR3svtBT3zLKDwbYORt8MJSUhilykoMlJvAi1uhR248G8k5L/NRWYkcQ5sqAlaz11ZHh+/DJQ4wCmklL75Azd9BJpo21gpUB3SgL4l/1jzZHU9Zyp/YqbhYWLR0eGGFFKqGK85yFxztzmkqpRgx7gPfyOwAHB9axa2tAuno0cu3xyVXg6W3PRzEFycibLLAgQdYW54cd325HsePf3VBhDygrSJXE8M5Te7BSgEfLQs5TbnEzcYEP1jfeMDq/gzltq4+0T
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(52116014)(7416014)(18002099003)(22082099003)(56012099003)(38350700014)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0tXamxGVXUvWlBYancvZDBVNFZYNDU1cnlVQ1R4SERxOW5oYmFZMzBzNTRJ?=
 =?utf-8?B?SVJQUHZRWno2dkNxNnl1NWIwTnoyelg0OVRzVU8xa1JoMkZtNEhSc3BLUUE4?=
 =?utf-8?B?cTMxQWZsemR0M1UraDlKYWV0VXU4NmN6SDF4S0xyS1AzVzRtVHplYVV1dmlw?=
 =?utf-8?B?YjlQSU00R2hXbzc4c1lsbGpOQm5TYVhabHRQbnVjNHo2T0JTU3hSTklQcWQ0?=
 =?utf-8?B?cEtiY05TM1RGV1ZjM25Wd1J5c3k4NkFIWTUwTHJScDRFaHlRbHN4cHdxOEFW?=
 =?utf-8?B?VXVzL0pCOWtJRW5ud1ZHV21iV1BGR3hGdnF6dzRSQnMwSEdvTGlJcXBnejE3?=
 =?utf-8?B?RHg4UkZ5VUYxY3U5TUxkQTJQaFlSUXZaOFE1bGNKUzVwWmV1b0hXVXFrUTNK?=
 =?utf-8?B?NXhZRHZRNHA3MzlNZ0lEdzJFekhBbEwzemtqWmxrVHpFZlhzeldZMTk4UHgy?=
 =?utf-8?B?VFV3cGd5eCt1K0UrZjBBRFRJcWcyVWpvTDliTG9BQVQxV3U0MTNkRDVybEdS?=
 =?utf-8?B?RVM5WGVwanYwRWt4YTJQeTRvcG5WRVozY0RMeWgvbnZwM1Y0YWdGcE81dlFM?=
 =?utf-8?B?M0FIbnExRGZyZkRCTVlxa3FlQWtSWTBId2RjY0pacVd2ZWlNZnNIR2dheXZh?=
 =?utf-8?B?NDFERkRuY0sveGh1R3lldUJobHpTTjBLRkJzbEtad0tmTDF6QUQxR2phMldy?=
 =?utf-8?B?bStUSUd6aDc0b2t6THpJdVR2c3A4dDltMmhFdEhNWUpINTBmQ0N0V3BYVDlT?=
 =?utf-8?B?R1JoT2hEZEJFODZGaTRWRHJRcGlJYnJBWS9aMktkY3pTb2thYUVmN2hxQ0xW?=
 =?utf-8?B?WnVyWGJFVFRvV3owRXdWRlhQWDkxenYwczk0ZE1OYVBobFBMeGU3ck0rSHA1?=
 =?utf-8?B?dUZHN0thOEU2dlRWK2V4RFhTQVhXQ3UxTmh1RU9QaFpwUHJkM0ZBRDlORFZH?=
 =?utf-8?B?NVgzN3hTUlhzSGZOenlzRDdlWmFPY2orakNocGNLUThRRWU2amhMcXlZcDhP?=
 =?utf-8?B?TldYWGtOYk9wM1QyZWl6SmNUOXE5L1FTTzNDOWFQUWNmaFAralg5YzhwZkNS?=
 =?utf-8?B?blVodzNsTFZNS1c1eEVoRUw4Z214bnZ2Y1VpZHQzWFpyRTFmS1pDRG1nUFU1?=
 =?utf-8?B?REQzTDNzakdGTTJHL0NxSS9QeEI3bG10WFRkTHQ3dXNFdU1UUmFyYmpMVjcr?=
 =?utf-8?B?ZlR2TVlFdXFLRFlZTnJSZElHM09LbFZhQ2poRFJlTXRYSk1WTE1yTk1Qekla?=
 =?utf-8?B?RFRpMCsxUCt6dDJzU0NNZUsvb2ZPZHU5RVlYSzB0MEZ0RlVlSVVLT0J1NnNS?=
 =?utf-8?B?QVlhcTVmclgzOE9kWm5Ebm9rWmxRZEZLckRkbXFqUEZ6bXZNczRsb3JhcW5P?=
 =?utf-8?B?UmdMdVBRVVloeE1IU09sMWJaRURpam5XNkFQaE5pRWV6Mk9BL3FpRmVQQVo1?=
 =?utf-8?B?S2c4WXJzYmRUdFdNWFpHREVHS2ltdFJqOGI5bERzdURHQlI3MEZiWEdhb1Y4?=
 =?utf-8?B?QUpTWXMrUlhIaFJjUmFaLy8yM3JVWVNVVTZhKzMvZHNUbDFnTVdaQXp6NjZX?=
 =?utf-8?B?YkhjaTQzUmZmRHQ1QndJU2FTNVQxRUduUUFHZWpiZ0JDclpwQUFndUxvenpO?=
 =?utf-8?B?dG5mSFgrdEtSSERaK24xcm4raGZhMDAzQlVlZ3BiTFNXRDN2NjBELzVDQStF?=
 =?utf-8?B?cWRyaUtxbHhiai9vNE5UaXVHZnlKYS9sU2lKUUFOUnZkTW16RUNiT0U4ODE0?=
 =?utf-8?B?WTJhVW85Mml4Wkd5SnhuOHNJVjY4dkttMnJoclJsVzR1YkRCa3VtSlVkSGhv?=
 =?utf-8?B?UXdsRml0c3NHRXFWUk9hQUdMdGNHUnN3MWlPM1JuOHEwOGU4bVN0WGxJMGJD?=
 =?utf-8?B?dCtxMnltZ2dPekdyRTNkM0t0cXUzMW1ldXdnYXNhM2VQeUliWGpIUXMyb05l?=
 =?utf-8?B?aUc0c0tiNFByYytBbmhvYjlJV3JkekZOMys0SFl6TVUzZWRyWjhUL2R4RExN?=
 =?utf-8?B?NVcrckVFUURzUUdkc0pmT0tIRjZRMkduTUVpcVhHQkpUenZUZTJZd0RRZ0VQ?=
 =?utf-8?B?RndOdENDbkd1WEJtcU5Ya2NMK25Ma2JjT00vOHdEdjdWVjltRGYxdnl3WVZG?=
 =?utf-8?B?b1dtTzhOeHdyWHdrNUhURFY3ei9XWkFNYkFsZGVuY1dKbmhQOUtkY2ZhaUIr?=
 =?utf-8?B?Q05hMVE1YVJyYU9zTk5tN01yMDM5MWxXdkVyVjZCWTNSRkFMM0JDbFYvTzFX?=
 =?utf-8?B?QkcvYXN5R1ZYT2l3Zmd2VkM1OWNqWlBROFpHNnFYNjFQaGhlZ0RvMWdWUE1t?=
 =?utf-8?B?SGpybU9UWUlpanB6d2RKMTB6Vk9ubDEyRER5N2FRMG5TdWdqL1dMZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa88899f-dde3-4ff2-891d-08deb56ed0f5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 06:21:09.1358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PxW/NbY4bCcI3DO5zQSnxTOdLqqVhvQ3PJ8UHcKMXQUnPak+bK9z4C8NXbWULFMO/kxJGbKXQxSDpIKXhPQmsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10902
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

The watchdog base addresses are now obtained from the devicetree via
ofnode_* functions. Remove the hardcoded macro definitions as they are
no longer needed.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/include/asm/arch-imx8ulp/imx-regs.h | 2 --
 arch/arm/include/asm/arch-imx9/imx-regs.h    | 9 ---------
 include/configs/imx8ulp_evk.h                | 2 --
 include/configs/imx91_evk.h                  | 2 --
 include/configs/imx91_frdm.h                 | 2 --
 include/configs/imx93_evk.h                  | 3 ---
 include/configs/imx93_frdm.h                 | 3 ---
 include/configs/imx93_qsb.h                  | 2 --
 include/configs/imx93_var_som.h              | 3 ---
 include/configs/imx94_evk.h                  | 3 ---
 include/configs/imx95_evk.h                  | 2 --
 include/configs/kontron-osm-s-mx93.h         | 2 --
 include/configs/mx7ulp_com.h                 | 3 ---
 include/configs/mx7ulp_evk.h                 | 3 ---
 include/configs/phycore_imx91_93.h           | 3 ---
 include/configs/toradex-smarc-imx95.h        | 2 --
 16 files changed, 46 deletions(-)

diff --git a/arch/arm/include/asm/arch-imx8ulp/imx-regs.h b/arch/arm/include/asm/arch-imx8ulp/imx-regs.h
index a038cc1df33..f9c5e21c14f 100644
--- a/arch/arm/include/asm/arch-imx8ulp/imx-regs.h
+++ b/arch/arm/include/asm/arch-imx8ulp/imx-regs.h
@@ -20,8 +20,6 @@
 
 #define SIM1_BASE_ADDR		0x29290000
 
-#define WDG3_RBASE		0x292a0000UL
-
 #define SIM_SEC_BASE_ADDR	0x2802B000
 
 #define CGC1_SOSCDIV_ADDR	0x292C0108
diff --git a/arch/arm/include/asm/arch-imx9/imx-regs.h b/arch/arm/include/asm/arch-imx9/imx-regs.h
index 2d084e5227a..fbf2e6a2b01 100644
--- a/arch/arm/include/asm/arch-imx9/imx-regs.h
+++ b/arch/arm/include/asm/arch-imx9/imx-regs.h
@@ -17,15 +17,6 @@
 
 #define ANATOP_BASE_ADDR    0x44480000UL
 
-#ifdef CONFIG_IMX94
-#define WDG3_BASE_ADDR      0x49220000UL
-#define WDG4_BASE_ADDR      0x49230000UL
-#else
-#define WDG3_BASE_ADDR      0x42490000UL
-#define WDG4_BASE_ADDR      0x424a0000UL
-#endif
-#define WDG5_BASE_ADDR      0x424b0000UL
-
 #define GPIO2_BASE_ADDR	    0x43810000UL
 #define GPIO3_BASE_ADDR	    0x43820000UL
 #define GPIO4_BASE_ADDR	    0x43840000UL
diff --git a/include/configs/imx8ulp_evk.h b/include/configs/imx8ulp_evk.h
index edfd6f70815..b4f80fb944b 100644
--- a/include/configs/imx8ulp_evk.h
+++ b/include/configs/imx8ulp_evk.h
@@ -30,6 +30,4 @@
 #define PHYS_SDRAM			0x80000000
 #define PHYS_SDRAM_SIZE			0x80000000 /* 2GB DDR */
 
-/* Using ULP WDOG for reset */
-#define WDOG_BASE_ADDR			WDG3_RBASE
 #endif
diff --git a/include/configs/imx91_evk.h b/include/configs/imx91_evk.h
index 9c5014fd0a5..13918e2b873 100644
--- a/include/configs/imx91_evk.h
+++ b/include/configs/imx91_evk.h
@@ -16,6 +16,4 @@
 #define PHYS_SDRAM		0x80000000
 #define PHYS_SDRAM_SIZE		0x80000000 /* 2GB DDR */
 
-#define WDOG_BASE_ADDR		WDG3_BASE_ADDR
-
 #endif
diff --git a/include/configs/imx91_frdm.h b/include/configs/imx91_frdm.h
index 6d051ed88a5..480b3fb477a 100644
--- a/include/configs/imx91_frdm.h
+++ b/include/configs/imx91_frdm.h
@@ -20,6 +20,4 @@
 #define PHYS_SDRAM		0x80000000
 #define PHYS_SDRAM_SIZE		SZ_2G /* 2GB DDR */
 
-#define WDOG_BASE_ADDR		WDG3_BASE_ADDR
-
 #endif
diff --git a/include/configs/imx93_evk.h b/include/configs/imx93_evk.h
index ffd72a38bcb..67774f54790 100644
--- a/include/configs/imx93_evk.h
+++ b/include/configs/imx93_evk.h
@@ -26,7 +26,4 @@
 #define PHYS_SDRAM                      0x80000000
 #define PHYS_SDRAM_SIZE			0x80000000 /* 2GB DDR */
 
-/* Using ULP WDOG for reset */
-#define WDOG_BASE_ADDR          WDG3_BASE_ADDR
-
 #endif
diff --git a/include/configs/imx93_frdm.h b/include/configs/imx93_frdm.h
index c98c10774cb..bcea360b399 100644
--- a/include/configs/imx93_frdm.h
+++ b/include/configs/imx93_frdm.h
@@ -20,7 +20,4 @@
 #define PHYS_SDRAM			0x80000000
 #define PHYS_SDRAM_SIZE			0x80000000 /* 2GB DDR */
 
-/* Using ULP WDOG for reset */
-#define WDOG_BASE_ADDR			WDG3_BASE_ADDR
-
 #endif
diff --git a/include/configs/imx93_qsb.h b/include/configs/imx93_qsb.h
index a7b94f7ab57..350f094c2a6 100644
--- a/include/configs/imx93_qsb.h
+++ b/include/configs/imx93_qsb.h
@@ -16,6 +16,4 @@
 #define PHYS_SDRAM		0x80000000
 #define PHYS_SDRAM_SIZE		0x80000000 /* 2GB DDR */
 
-#define WDOG_BASE_ADDR		WDG3_BASE_ADDR
-
 #endif
diff --git a/include/configs/imx93_var_som.h b/include/configs/imx93_var_som.h
index 9dc10aea407..6a425e6d1ea 100644
--- a/include/configs/imx93_var_som.h
+++ b/include/configs/imx93_var_som.h
@@ -38,7 +38,4 @@
 
 #define CFG_SYS_FSL_USDHC_NUM 2
 
-/* Using ULP WDOG for reset */
-#define WDOG_BASE_ADDR          WDG3_BASE_ADDR
-
 #endif
diff --git a/include/configs/imx94_evk.h b/include/configs/imx94_evk.h
index f93c3c4e4a8..2623c13db06 100644
--- a/include/configs/imx94_evk.h
+++ b/include/configs/imx94_evk.h
@@ -18,7 +18,4 @@
 #define PHYS_SDRAM_SIZE			     0x70000000UL /* 2GB  - 256MB DDR */
 #define PHYS_SDRAM_2_SIZE	             0x180000000 /* 8GB */
 
-/* Using ULP WDOG for reset */
-#define WDOG_BASE_ADDR          WDG3_BASE_ADDR
-
 #endif
diff --git a/include/configs/imx95_evk.h b/include/configs/imx95_evk.h
index 3d22740b3f4..1fdc9ce21ef 100644
--- a/include/configs/imx95_evk.h
+++ b/include/configs/imx95_evk.h
@@ -23,6 +23,4 @@
 #define PHYS_SDRAM_2_SIZE		0x380000000 /* 14GB (Totally 16GB) */
 #endif
 
-#define WDOG_BASE_ADDR			WDG3_BASE_ADDR
-
 #endif
diff --git a/include/configs/kontron-osm-s-mx93.h b/include/configs/kontron-osm-s-mx93.h
index ab2b42298c8..fed75e6fa12 100644
--- a/include/configs/kontron-osm-s-mx93.h
+++ b/include/configs/kontron-osm-s-mx93.h
@@ -25,6 +25,4 @@
 #define CFG_MXC_USB_FLAGS		0
 #endif
 
-#define WDOG_BASE_ADDR          WDG3_BASE_ADDR
-
 #endif /* __KONTRON_MX93_CONFIG_H */
diff --git a/include/configs/mx7ulp_com.h b/include/configs/mx7ulp_com.h
index d27e9d2eaa1..501c3059cc3 100644
--- a/include/configs/mx7ulp_com.h
+++ b/include/configs/mx7ulp_com.h
@@ -15,9 +15,6 @@
 #include "imx7ulp_spl.h"
 #endif
 
-/* Using ULP WDOG for reset */
-#define WDOG_BASE_ADDR			WDG1_RBASE
-
 #define CFG_SYS_HZ_CLOCK		1000000 /* Fixed at 1MHz from TSTMR */
 
 /* UART */
diff --git a/include/configs/mx7ulp_evk.h b/include/configs/mx7ulp_evk.h
index ace1eee70cf..21dbec837f0 100644
--- a/include/configs/mx7ulp_evk.h
+++ b/include/configs/mx7ulp_evk.h
@@ -11,9 +11,6 @@
 #include <linux/sizes.h>
 #include <asm/arch/imx-regs.h>
 
-/* Using ULP WDOG for reset */
-#define WDOG_BASE_ADDR			WDG1_RBASE
-
 #define CFG_SYS_HZ_CLOCK		1000000 /* Fixed at 1Mhz from TSTMR */
 
 /* UART */
diff --git a/include/configs/phycore_imx91_93.h b/include/configs/phycore_imx91_93.h
index 02fa1d9b274..d1bf086546f 100644
--- a/include/configs/phycore_imx91_93.h
+++ b/include/configs/phycore_imx91_93.h
@@ -22,7 +22,4 @@
 #define PHYS_SDRAM                   0x80000000
 #define PHYS_SDRAM_SIZE              0x80000000
 
-/* Using ULP WDOG for reset */
-#define WDOG_BASE_ADDR          WDG3_BASE_ADDR
-
 #endif /* __PHYCORE_IMX91_93_H */
diff --git a/include/configs/toradex-smarc-imx95.h b/include/configs/toradex-smarc-imx95.h
index e1aebd70af2..8a880b96503 100644
--- a/include/configs/toradex-smarc-imx95.h
+++ b/include/configs/toradex-smarc-imx95.h
@@ -19,6 +19,4 @@
 #define PHYS_SDRAM_SIZE		(SZ_2G - SZ_256M)
 #define PHYS_SDRAM_2_SIZE	SZ_6G
 
-#define WDOG_BASE_ADDR	WDG3_BASE_ADDR
-
 #endif

-- 
2.34.1

