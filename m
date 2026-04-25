Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D41FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:44:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C252D842CE;
	Sat, 25 Apr 2026 18:44:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qBedsfs9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7FFE842D7; Sat, 25 Apr 2026 18:44:12 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AB8F841F2
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:44:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
Received: from DB9PR04MB8251.eurprd04.prod.outlook.com (2603:10a6:10:24f::13)
 by PA1PR04MB10674.eurprd04.prod.outlook.com (2603:10a6:102:483::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.23; Sat, 25 Apr
 2026 12:37:40 +0000
Received: from DU0PR04MB9370.eurprd04.prod.outlook.com (2603:10a6:10:359::20)
 by DB9PR04MB8251.eurprd04.prod.outlook.com (2603:10a6:10:24f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.23; Sat, 25 Apr
 2026 11:58:00 +0000
Received: from AM8PR04MB7876.eurprd04.prod.outlook.com (2603:10a6:20b:240::22)
 by DU0PR04MB9370.eurprd04.prod.outlook.com (2603:10a6:10:359::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Sat, 25 Apr
 2026 09:00:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h3CIxqorI2vffDZKHaaRCIhCto6husWCCs+/zQpZXQQIkdrbMosSamatK/9stdMe4J3rJA92lfYOazUbzSpJif9Kr4iUrB5u0D8uXa+XTRGz1FPRBc5TjbXZWlS+vCjMdGYCsa5frC4hyLVeUaK2omQvA4Z8LtEyEMGmA+fF0FGQYkNfElaPM3Nam4jdKb4Jn4Q9HKBJx/VEUlrSrDWu7ytnrz1CxMna+YhonMNbfhSNWIetbzvXSgNBnzx3xQYsu3p8r5hldbmb09ASL57FJw82ztOneF0WbufmD2kromFKW5J2v0SmGsxk1mXW8OPg8A8R6RmNrCx6Eh7e3XJhsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2982YCJQfDsU/ncc53POW65eama2Klt5l9Tg7UPHjKc=;
 b=L9TirsD1bAJOI2gqRiBqlvy1WyGYoF+W/AaTeVMe5OTooNKz/dWXqoFRYyf6CmxDJfGC61IiYlrhWNNhEPkq4rUOJO4HVm4wDteRmR8yJ2IljKgB+qdLxaLG4qxxTb9IaTvmFI9JAXSLOdwG1yZoss2RYsYvCQK89fJZHWLKpl7uoMn+Wf+QZKrYwHgLyPqL3DFvW3V40Judk/pFV1rZPBN8xWq6F9cdUc1g4mLPb/7lAWO8pzBOMljKAhsOeFE6yVjjyelIdSBVI0m8Oh5iy5dQb9MglzL4IzmJ2JJj9nTfSIBmR7xlwVYcc3LlLlWCWybhIA7F1HbqZwftEGd60w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2982YCJQfDsU/ncc53POW65eama2Klt5l9Tg7UPHjKc=;
 b=qBedsfs9uutboBAvZCiEQrmc6LJu0ys+LWZCW3ZI8HtpN7z02w/cfuE0ecWJeO/pWaMwIitbEM0Cis8X30Jtc2FwtiqiBQdi7e/hW5ffYebLp/mJwlS6L6zmtV48Tmi0M5wkcDYb6yKTm51GGu8rIhWtWAiJHnA/MdxpU5QN4ymXJ8vPwYLlyfqVLOSFx9Orhe5LIAwrJg7bdq0L6onkh3S0tvZLS2zg0UeddZwCQyLc3xCKjoNrZxXT/biLkQIyKhfv92W09aOx+7XiFlx1tbBmYLe4QM9QbNQHurutjMTUxHGJevnSAOK8q1hgkvGGFgnFX7aGbCtOvEI5Obd4hQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM8PR04MB7876.eurprd04.prod.outlook.com (2603:10a6:20b:240::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.23; Fri, 24 Apr
 2026 23:20:33 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 23:20:33 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 25 Apr 2026 08:36:54 +0800
Subject: [PATCH 02/13] imx8mq: phanbell: Switch OF_UPSTREAM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260425-imx8m-of-upstream-v1-2-07527be92e5d@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM8PR04MB7876:EE_|DU0PR04MB9370:EE_|DB9PR04MB8251:EE_|PA1PR04MB10674:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ffe0570-0072-4c69-b0f0-08dea258155d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|19092799006|366016|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: 46bQEg+TdT3JucQs18oSkraRXFMXrRiKGqUwL8/G4niH1eOLia6e5S7/8jG2m+hwN+GRvO4EWX90QCBXf5pbY5d+5CWmHoL/z5S0pgwbgO78KZ4vE8ME24NO1KNSr6ChIuT2lNpaSB/14oGc93ZuGs4vFw4kgaO5IrtbR78GzTbV00LeqMzR672ARknZvL/Z403P6DgdgHm6wRHVr/aJpVXgFvaD35bFWYsFxqekgiqDDlm5/QtFDYkMHrpMu1tOyl2C4ac9fBnVGbd1N2iTR3M3TY7lxeSG81jSad9zD2LfGTotbVwjpI5SfG7LmoSuL0WcBoA9QN181zoS1KAbom1EaQObq8IKxOiund3Evj5De7r13Dq2xV1ongAlJD0wtsQoNYANDwYPZk6cW9R2uW/F9Uy1ZCpDEiNjqx673qe4CCDLF/gx2lLYGwroW46Ve7wVPKwS64OyV3NP+BrNFKV4nzwLrWFLFDd/YSl5+7qHB+2jzEX649u/rGyu4UCgiewQq4THnDhUQwwnC6ikY3qoJOhI+LkSLXj2aBuB/3izAVjhuvIzE4zL8LLIE1fGLhN6eBn3Jaj1/ziufzb/jg5WpBQ2CQSos8tJ8p1LaZArq1aHbaXEBhv3/j8o6Gj8wQuxfEkGX/g6fKT7WGsXGievyHDhBp7yWycVHPXPhiBRDkdXHiYw04hbCFSvlSjkglsII2i/F9CCQCo8ooHZ9qPzknvfs9joKUzTLAHxXjGhv84ZIARWMNX61nPn9PjTjTC0mxrbQklwmUBuG3O3ofLrIRLScts8/G44IWiAEKQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(19092799006)(366016)(56012099003)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzI3RXB1MUpvTXBDQmdZOU42eTZPMEpoZDQ0NWtYS2YrM1dTTDEzaXhiL1Yy?=
 =?utf-8?B?RkFYc1NhblBNSjdYcUhZUGZ1YzVtdXdlY1FzWlRHTDM3UzVzM1hzN0hSSDdv?=
 =?utf-8?B?ZG8ycU5JQ2NCSEhUbTJzbnQrTGttQXQ3ckJIays4TlREOEtacWkxMXUzYlFz?=
 =?utf-8?B?SjBtOVQ1R3JKc01pSU03eXcvdFcybWdIRi9oa2tzOEpQS0RDNHJNMkhtM1Rl?=
 =?utf-8?B?RkFVSWZNVnVzOWt2cWgyNFQ3STRUZlpJVEgyb0RVeENtMDFPR2JvZ3NaRjNa?=
 =?utf-8?B?WUx3THV0T2pSM1FJWjlzblNScFkwQ0E3MmJDeEl3UnNiTHJtSllIc1hpdEYw?=
 =?utf-8?B?cXdzdDdvcktlZEZlMXVTa3BBUXMya2tHeXpOYi9xZDdwSlZYT0ljQmlaWklL?=
 =?utf-8?B?SXJsSStRWks2N1dsZ1FJWjZUNlVtdTFGdWI4ei96MFlmc1BWZlhCZ1ZJU3FI?=
 =?utf-8?B?ZjdTemJrbkhaZTU5cjR6WWFtYWJDNlZxYmN3d2sxamlncnVjbGFhdWZqWW9Z?=
 =?utf-8?B?UFJNQmU5aHBDOUpNSkxvbW9UL1dHRXlFam1Xd2dLbGJKd2ZOOTRSR2VSYjRL?=
 =?utf-8?B?UTF6V0FsRXVic2VMaVJvK1NMclU1RWtJcllSZHVMRWZEeEN6UGtqd2N4OW9C?=
 =?utf-8?B?VlNseWNQMWdMcEtjTVdYdSsxWVdsb05Bc0VubGNYU0xIVHRrcUU2bjl4VG1G?=
 =?utf-8?B?VExub2c3ZEV5K1ZXNzBJbm8ybzVPWHJsK2tZcG1LSFNJU09FNG1JQUZ6QlRn?=
 =?utf-8?B?enNjUFNxZ2NqdVYyV3kzbEJkUitDVzQyMExla0VLVE5UVVRuY2hxZW9YYXhO?=
 =?utf-8?B?bVFSamxvYVpuQjhvYzV3TGhTRU1BdkMxbjc1RFZTZXNXLzNUNWY2TElGOXdj?=
 =?utf-8?B?RkRJV051bThWczVsNnZZbGlHQld0cXJyeXlhbzBPU2ljc0tnRDladFdIVWRC?=
 =?utf-8?B?VFd3bTExa0hHby81ancwc3hMK3YvVDBGOGE1MFBWY3JKcXJWM1JQTmZGTk5J?=
 =?utf-8?B?a1FFR1NRRUZFb3UyVEx3WGd4MG05aGpsZ25BeDNmYjBoYWU0QlBOcU1SdTAv?=
 =?utf-8?B?TlRvQ1lsazdZZHdqcCtMSjcrcjZlU28zMXZoWG4wVjYycHdSQks4Y0d3OCtN?=
 =?utf-8?B?V0dkSUJSdnVaZE4xczgrYXNmZUZoSlVYVXplZ3Z3a2RNY0lpWjM5MDNOcVhq?=
 =?utf-8?B?RlNwb3ZDN2hkUkNyc0YzUm5YTEMzajl5cThBaEVJcEVkWEdhb0VQVTcvbFJv?=
 =?utf-8?B?dktualR4NERaMHRZUWZNWVJydkpCd2lPd3hMMExSeHk1SkswaVVPZVNQS0Jr?=
 =?utf-8?B?MUhlc2ZtZzdWYVZKL2tuUjROS3A4RVZyN1lWNjlNZG9vU2swRTZTTjVsUTVj?=
 =?utf-8?B?OHFtcDBidGR1U2NBVUtabUZpMmJHZi9XZWRFQ3BoODVzZ21waWhqcnhNWmRp?=
 =?utf-8?B?aERkRXFHZ1JITDVkRUFJOGdHeWpJMmNaWDlsVnZ3c25Ja1JHL29acWpvYkR2?=
 =?utf-8?B?ejJ6VStxMDZuNVAxZCs1NVNiTFEwbDU0OW9tUGNyZTlzUWpnSWVCbHpOR3JU?=
 =?utf-8?B?dnc4c1hvVzBmZXhTMmFad1pQa0F2aXpQSVJZNUE2dTRvN1ovUThjeEVaSE03?=
 =?utf-8?B?ek01M1RMeEhweGM4cllIVS9tWk9nLzI4RUZ5clh5MjdzN0kwejVTY3VETnhN?=
 =?utf-8?B?MisveEU1MTBnT0NabGpzdGl4THB0UExkNGJsVmNTS2tOK01iK1dONUc3aTV0?=
 =?utf-8?B?enlGbHpuVnB4b1ZoeEdQVnJBSU5aMTUzSGZrWTRvWVJBdHQ5bmY1WW5DZWw0?=
 =?utf-8?B?Rzc1SEdQVTVKWXJISjlRSk9aQ0U4ZnhSQTJXRXFCUVhRS3cwaThCQytick9B?=
 =?utf-8?B?WHVtL3VYZW5tV1RRRU1TNUsreWlKcTdaVVl5dTQvZ2VvWUJLMVJ5N0lmc3pi?=
 =?utf-8?B?Mm00WjJFbUY2V3piOW9YTDVld1FkNW1qTTJrODcxVjNhS0tJWXlQWWk1U1gw?=
 =?utf-8?B?SGJwck85SWZvTjZkRnNqenRtU3A4R3VmeEpYVkJIdDM2dFhwdWhJUHVJMy83?=
 =?utf-8?B?Mlg3S2EzN1NqeXJFdUxDNWdBWStnZVU0Rjh1R2JhSWMzeW8zYnRnWWFYZ2pv?=
 =?utf-8?B?Qk1oR2VDMUxDL0pYUzBDOFA3M21CRXBJMmJkYXcvMnBRejB4djVNTHhVQzl6?=
 =?utf-8?B?c0w0QnRWZ1UzME90Y1lHU3NMby9RTmhGS3QzVTAyOEE1U3g1QUNWK0M3dXEy?=
 =?utf-8?B?QTVUREdOVld1TzZCZVg4cDdUT2pWRDRzYzhnWXZ2RXFGcDRFTGx3eGxFL3NZ?=
 =?utf-8?B?cGtGMmJXTW9iZmJOWjZ3TWtFUTlpS3dNekhoRkpVOTc5MUhyUDBZdz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ffe0570-0072-4c69-b0f0-08dea258155d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 23:20:33.3860 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJ3rhgHzla3a2yWVbtnK0H2uugua6liZrb6oKhCjQW69fkMON1sQ/VqvOPvcoHp6UxEpviIEoBm1YzEtGT/MQQ==
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

arch/arm/dts/imx8mq-phanbell.dts is almost same as upstream Linux dts,
so switch to OF_UPSTREAM by dropping the U-Boot copy of the dts,
enabling OF_UPSTREAM and updating CONFIG_DEFAULT_DEVICE_TREE.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/Makefile             |   1 -
 arch/arm/dts/imx8mq-phanbell.dts  | 481 --------------------------------------
 arch/arm/mach-imx/imx8m/Kconfig   |   1 +
 configs/imx8mq_phanbell_defconfig |   2 +-
 4 files changed, 2 insertions(+), 483 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 68ca3b0ad02..4564544bc00 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -879,7 +879,6 @@ dtb-$(CONFIG_ARCH_IMX8M) += \
 	imx8mm-mx8menlo.dtb \
 	imx8mm-phg.dtb \
 	imx8mq-cm.dtb \
-	imx8mq-phanbell.dtb \
 	imx8mp-data-modul-edm-sbc.dtb \
 	imx8mp-dhcom-som-overlay-rev100.dtbo \
 	imx8mp-dhcom-som-overlay-eth1xfast.dtbo \
diff --git a/arch/arm/dts/imx8mq-phanbell.dts b/arch/arm/dts/imx8mq-phanbell.dts
deleted file mode 100644
index a3b9d615a3b..00000000000
--- a/arch/arm/dts/imx8mq-phanbell.dts
+++ /dev/null
@@ -1,481 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
-/*
- * Copyright 2017-2019 NXP
- */
-
-/dts-v1/;
-
-#include "imx8mq.dtsi"
-#include <dt-bindings/interrupt-controller/irq.h>
-
-/ {
-	model = "Google i.MX8MQ Phanbell";
-	compatible = "google,imx8mq-phanbell", "fsl,imx8mq";
-
-	chosen {
-		stdout-path = &uart1;
-	};
-
-	memory@40000000 {
-		device_type = "memory";
-		reg = <0x00000000 0x40000000 0 0x40000000>;
-	};
-
-	pmic_osc: clock-pmic {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <32768>;
-		clock-output-names = "pmic_osc";
-	};
-
-	reg_usdhc2_vmmc: regulator-usdhc2-vmmc {
-		compatible = "regulator-fixed";
-		regulator-name = "VSD_3V3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	fan: gpio-fan {
-		compatible = "gpio-fan";
-		gpio-fan,speed-map = <0 0 8600 1>;
-		gpios = <&gpio3 5 GPIO_ACTIVE_HIGH>;
-		#cooling-cells = <2>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_gpio_fan>;
-		status = "okay";
-	};
-};
-
-&A53_0 {
-	cpu-supply = <&buck2>;
-};
-
-&A53_1 {
-	cpu-supply = <&buck2>;
-};
-
-&A53_2 {
-	cpu-supply = <&buck2>;
-};
-
-&A53_3 {
-	cpu-supply = <&buck2>;
-};
-
-&cpu_thermal {
-	trips {
-		cpu_alert0: trip0 {
-			temperature = <75000>;
-			hysteresis = <2000>;
-			type = "passive";
-		};
-
-		cpu_alert1: trip1 {
-			temperature = <80000>;
-			hysteresis = <2000>;
-			type = "passive";
-		};
-
-		cpu_crit0: trip3 {
-			temperature = <90000>;
-			hysteresis = <2000>;
-			type = "critical";
-		};
-
-		fan_toggle0: trip4 {
-			temperature = <65000>;
-			hysteresis = <10000>;
-			type = "active";
-		};
-	};
-
-	cooling-maps {
-		map0 {
-			trip = <&cpu_alert0>;
-			cooling-device =
-			<&A53_0 0 1>; /* Exclude highest OPP */
-		};
-
-		map1 {
-			trip = <&cpu_alert1>;
-			cooling-device =
-			<&A53_0 0 2>; /* Exclude two highest OPPs */
-		};
-
-		map4 {
-			trip = <&fan_toggle0>;
-			cooling-device = <&fan 0 1>;
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
-	pmic: pmic@4b {
-		compatible = "rohm,bd71837";
-		reg = <0x4b>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pmic>;
-		#clock-cells = <0>;
-		clocks = <&pmic_osc>;
-		clock-output-names = "pmic_clk";
-		interrupt-parent = <&gpio1>;
-		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
-
-		regulators {
-			buck1: BUCK1 {
-				regulator-name = "buck1";
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1300000>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <1250>;
-				rohm,dvs-run-voltage = <900000>;
-				rohm,dvs-idle-voltage = <900000>;
-				rohm,dvs-suspend-voltage = <800000>;
-			};
-
-			buck2: BUCK2 {
-				regulator-name = "buck2";
-				regulator-min-microvolt = <850000>;
-				regulator-max-microvolt = <1000000>;
-				regulator-boot-on;
-				regulator-always-on;
-				rohm,dvs-run-voltage = <1000000>;
-				rohm,dvs-idle-voltage = <900000>;
-			};
-
-			buck3: BUCK3 {
-				regulator-name = "buck3";
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1300000>;
-				regulator-boot-on;
-				rohm,dvs-run-voltage = <900000>;
-			};
-
-			buck4: BUCK4 {
-				regulator-name = "buck4";
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1300000>;
-				regulator-boot-on;
-				regulator-always-on;
-				rohm,dvs-run-voltage = <900000>;
-			};
-
-			buck5: BUCK5 {
-				regulator-name = "buck5";
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1350000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			buck6: BUCK6 {
-				regulator-name = "buck6";
-				regulator-min-microvolt = <3000000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			buck7: BUCK7 {
-				regulator-name = "buck7";
-				regulator-min-microvolt = <1605000>;
-				regulator-max-microvolt = <1995000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			buck8: BUCK8 {
-				regulator-name = "buck8";
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1400000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo1: LDO1 {
-				regulator-name = "ldo1";
-				regulator-min-microvolt = <3000000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo2: LDO2 {
-				regulator-name = "ldo2";
-				regulator-min-microvolt = <900000>;
-				regulator-max-microvolt = <900000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo3: LDO3 {
-				regulator-name = "ldo3";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo4: LDO4 {
-				regulator-name = "ldo4";
-				regulator-min-microvolt = <900000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo5: LDO5 {
-				regulator-name = "ldo5";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo6: LDO6 {
-				regulator-name = "ldo6";
-				regulator-min-microvolt = <900000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo7: LDO7 {
-				regulator-name = "ldo7";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-		};
-	};
-};
-
-&fec1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_fec1>;
-	phy-mode = "rgmii-id";
-	phy-handle = <&ethphy0>;
-	fsl,magic-packet;
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		ethphy0: ethernet-phy@0 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <0>;
-			reset-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
-			reset-assert-us = <10000>;
-			reset-deassert-us = <50000>;
-		};
-	};
-};
-
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1>;
-	status = "okay";
-};
-
-&usdhc1 {
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc1>;
-	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
-	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
-	bus-width = <8>;
-	non-removable;
-	status = "okay";
-};
-
-&usdhc2 {
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
-	bus-width = <4>;
-	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
-	vmmc-supply = <&reg_usdhc2_vmmc>;
-	status = "okay";
-};
-
-&usb3_phy0 {
-	status = "okay";
-};
-
-&usb_dwc3_0 {
-	dr_mode = "otg";
-	status = "okay";
-};
-
-&usb3_phy1 {
-	status = "okay";
-};
-
-&usb_dwc3_1 {
-	dr_mode = "host";
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
-			MX8MQ_IOMUXC_ENET_TD3_ENET1_RGMII_TD3		0x1f
-			MX8MQ_IOMUXC_ENET_TD2_ENET1_RGMII_TD2		0x1f
-			MX8MQ_IOMUXC_ENET_TD1_ENET1_RGMII_TD1		0x1f
-			MX8MQ_IOMUXC_ENET_TD0_ENET1_RGMII_TD0		0x1f
-			MX8MQ_IOMUXC_ENET_RD3_ENET1_RGMII_RD3		0x91
-			MX8MQ_IOMUXC_ENET_RD2_ENET1_RGMII_RD2		0x91
-			MX8MQ_IOMUXC_ENET_RD1_ENET1_RGMII_RD1		0x91
-			MX8MQ_IOMUXC_ENET_RD0_ENET1_RGMII_RD0		0x91
-			MX8MQ_IOMUXC_ENET_TXC_ENET1_RGMII_TXC		0x1f
-			MX8MQ_IOMUXC_ENET_RXC_ENET1_RGMII_RXC		0x91
-			MX8MQ_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
-			MX8MQ_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
-			MX8MQ_IOMUXC_GPIO1_IO09_GPIO1_IO9		0x19
-		>;
-	};
-
-	pinctrl_gpio_fan: gpiofangrp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_NAND_CLE_GPIO3_IO5			0x16
-		>;
-	};
-
-	pinctrl_i2c1: i2c1grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_I2C1_SCL_I2C1_SCL			0x4000007f
-			MX8MQ_IOMUXC_I2C1_SDA_I2C1_SDA			0x4000007f
-		>;
-	};
-
-	pinctrl_pmic: pmicirqgrp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_GPIO1_IO03_GPIO1_IO3	0x41
-		>;
-	};
-
-	pinctrl_uart1: uart1grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_UART1_RXD_UART1_DCE_RX		0x49
-			MX8MQ_IOMUXC_UART1_TXD_UART1_DCE_TX		0x49
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
-			MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x83
-			MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0xc1
-		>;
-	};
-
-	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x85
-			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xc5
-			MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xc5
-			MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xc5
-			MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xc5
-			MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xc5
-			MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xc5
-			MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xc5
-			MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xc5
-			MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xc5
-			MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x85
-			MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0xc1
-		>;
-	};
-
-	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x87
-			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xc7
-			MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xc7
-			MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xc7
-			MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xc7
-			MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xc7
-			MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xc7
-			MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xc7
-			MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xc7
-			MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xc7
-			MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x87
-			MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0xc1
-		>;
-	};
-
-	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_SD2_CD_B_GPIO2_IO12	0x41
-			MX8MQ_IOMUXC_SD2_RESET_B_GPIO2_IO19	0x41
-		>;
-	};
-
-	pinctrl_usdhc2: usdhc2grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x83
-			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc3
-			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc3
-			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc3
-			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc3
-			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc3
-			MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
-		>;
-	};
-
-	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x85
-			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc5
-			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc5
-			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc5
-			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc5
-			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc5
-			MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
-		>;
-	};
-
-	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x87
-			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc7
-			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc7
-			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc7
-			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc7
-			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc7
-			MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
-		>;
-	};
-
-	pinctrl_wdog: wdoggrp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B 0xc6
-		>;
-	};
-};
diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index 40b5de47cfb..ef1146cd7f6 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -79,6 +79,7 @@ config TARGET_IMX8MQ_PHANBELL
 	bool "imx8mq_phanbell"
 	select IMX8MQ
 	select IMX8M_LPDDR4
+	imply OF_UPSTREAM
 
 config TARGET_IMX8MQ_REFORM2
 	bool "imx8mq_reform2"
diff --git a/configs/imx8mq_phanbell_defconfig b/configs/imx8mq_phanbell_defconfig
index 07354a78629..8c68e4fcebd 100644
--- a/configs/imx8mq_phanbell_defconfig
+++ b/configs/imx8mq_phanbell_defconfig
@@ -8,7 +8,7 @@ CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_ENV_SIZE=0x1000
 CONFIG_ENV_OFFSET=0x400000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx8mq-phanbell"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mq-phanbell"
 CONFIG_TARGET_IMX8MQ_PHANBELL=y
 CONFIG_DM_RESET=y
 CONFIG_SYS_MONITOR_LEN=524288

-- 
2.51.0

