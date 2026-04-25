Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC05FF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:24:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 522BD8429E;
	Sat, 25 Apr 2026 18:24:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="X7mgklKe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88E5E83FB0; Sat, 25 Apr 2026 18:24:14 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67AFB84312
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:24:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
Received: from PAXPR04MB8427.eurprd04.prod.outlook.com (2603:10a6:102:1cd::13)
 by DU4PR04MB10551.eurprd04.prod.outlook.com (2603:10a6:10:588::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.24; Sat, 25 Apr
 2026 12:21:37 +0000
Received: from AM8PR04MB7876.eurprd04.prod.outlook.com (2603:10a6:20b:240::22)
 by PAXPR04MB8427.eurprd04.prod.outlook.com (2603:10a6:102:1cd::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.23; Sat, 25 Apr
 2026 09:00:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cMVXacNpygPWbrIxpqeE5MmeTkLgX7rsj0qS07lMArpDKP6opWtYmv88k8Az9oMhssu9IPq3j4pyzQhzR//oHkyAbiAh8wd95kBg4CZuhJ8v/QvY6u2RBkZD1MobD+A//ivrMs7EEfLx0eKbMoy92aE2WvZw9sQAHjG/fkxtkxlrz6x3oV/Fd+1/oBVaa/LtPAvprCbqCaFRPZlyPYoKjbBEyJBivl7u+BaxeAc+c1Ws/sDmAf4tEgxi9xRHn3eml+T3X4DD1NEhm6jve9p2znjvPKU0Fc0xA7RXhNQRiAcIzR4lsLikbelycrt6TCd+3iMjLgVg49/+CBI8s0HZXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fh66esATi8GHCiIateM2jBsCGSvJ2KxQ/ejPCEt8hC4=;
 b=DeK7bZiKmYC+VAaOnZuGiZhf7IGW0rUphYxVPY99wHNh3EB2dLkAvXj9jdI4U4tQiMVauLeboAMsMZNDYIjROn6O7YMJAs8NzGoi8t1i/auqA0ryXBHlqK8Pe4u06Uuhvkjgct0GZsfk5NpS3ohv3PVp3JI10clTIpR13qY+r1QquQhkVru8WkVmtIFsoGZ0/TEo/8CnWjJTba+wNkkQ8vfKl2zS0LMXnNsmVhwL7mWQBHnxmgAKss6Rkb0hFpD2iJfxNN8OtG/7uEwmYZMS/Ij6/1CMPuUJDwFMcKiP9l+hFIQSkoFgYkM8N324sEcBy3+tVD32zjzEFKmlvFs99A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fh66esATi8GHCiIateM2jBsCGSvJ2KxQ/ejPCEt8hC4=;
 b=X7mgklKe+Ic2ZrUe1xWVQzy+FCvQ5lY9hgX57KfQrGq4rT6UmHlX5T282LNfPwFB2lJU0lwfH2wdYgG4nbDS5pCK+Vy4MFVjmBB0uE9nVriHWOt0g9w6QreQ2G6QOydSmSLb9r/yN8b5TjGL7CiMYy1o5apLXL+mm7ZFksNRSLoDfRlSU5jc7M/q/HYb8vEvvDJdRh5LbPGnKycf9SJyDDda4fAjRrATPvsavQJxV/9mj1JS+QKIwm4cn9zOZ0nbqweTcTkoHWQEY87LhnRUPAfGMyzOhXlxggg9E6Dk6q94UqEcwd3ihtmGlG7vEfDRD/vAOkBFW1QqDU8/0r65Kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM8PR04MB7876.eurprd04.prod.outlook.com (2603:10a6:20b:240::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.23; Fri, 24 Apr
 2026 23:20:46 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 23:20:46 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 25 Apr 2026 08:36:56 +0800
Subject: [PATCH 04/13] imx8mq: librem5: Switch to OF_UPSTREAM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260425-imx8m-of-upstream-v1-4-07527be92e5d@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM8PR04MB7876:EE_|PAXPR04MB8427:EE_|DU4PR04MB10551:EE_
X-MS-Office365-Filtering-Correlation-Id: 97f7e660-4e03-485b-4d88-08dea2581d36
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|19092799006|366016|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: 8vCaiTRmYqWqF+ku1/2DIvEQca12fYrv3rJHJiTQgPPA2GD2OOqHRD46hoht6GB0ZHj1qiO6IIXC1k+J39MAW953hRu/K/bVQYfBvi3/Tlohgnzer5K6TPannjk5LNVliXhpwUM7B5JBvwPz/50G5InLNIsCq69QMYQLDgt3G5M2ryshaPFb6/7qQGCu9q4HFA/Gi+CRvWrJCeBvCqjbFo3Nukm/e5XOdaukom6yEMWl6nkwkm5coph9Kc/cTcyFj+xRBNGwKbg6d26UG+B0DRUNkn83Ogxhy4rl6RgMWt5+GMx1JMussYUFodSJrwvXz8NZnXwr2wIalYnU+TuBXWIYWffilMz0QWaRiPjvZ30/13WWEDh3HRuAKn6kjjeDBk5tW+bshMdT/KwtBg7AokgGyY2Nv78OPYwoMT1oiOPKhvG+kQTYIRtr5kPMiOG+91VS/IDvUJ4vah0mbU9VaZzU4/4W7usdL7sQDfBkX48QD/aTZU9dn2ijDAViG06JkGE9G2ZD4rPyg46B0YnBNug1OY6fLB6q7G4zywygnswLfiv4/vPy27WUlowhkJ2ESYmsGVW1iX2kKraPn4R+xu7ITWoervDATol7rwYpetc5MqD0rTZbc7tUeI3LE/yEvcxBb2EZDVjgLJAqE3TsjeQJB6OJND1RwgRdbtH+4YzjI/n9JTlY09s3Q1P1RFMZUxo6xu2eFoLw2TQH482yaZSk/zX9QanpkHmaD9ytj4W38jixNQUoJ9cc1QSnshkh8/pc6fKoSa+CQsH2etxfHSu0YkQ4UOIErUz9hZoyX+M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(19092799006)(366016)(56012099003)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFJpTFl0eld6Rlpwb2lHd2k5bXhVZG5velR3NlFoZkRjaGZtTjlCQjlmazhD?=
 =?utf-8?B?OWxDMzU5Y3ozUWgvZHVTaFJsMUVQbHBDRW8wQmVqQUdFdTZubzIzWEEzcDU0?=
 =?utf-8?B?aW5lNXE1RzhTcWJpWDBGOGFBS0RMbWVwVVdJSkIwdG9RRFFLRTRXTEtRZEFa?=
 =?utf-8?B?ZEtuMUhQWEI1UFdGSjlQVDV4bVJCWlk3QmcyWXNabDFhYzNValgzSE9UUEpX?=
 =?utf-8?B?K3I1Z1pmMEJyUjY3anNQTytoajczTXVubkNIdGlwZnBjSmVHS0hmaUwzOFNm?=
 =?utf-8?B?MGx5NjhIcnVHYS9FVlIzdVJadXFrTmYxOEdwRXpBb0RlaDFHWVMwTFF5QVAx?=
 =?utf-8?B?R2FsaTVBcTNicjhpejgvQWpaeHJlQmZJYVl5UWh2aGhucEVRdWpsdjMxNm1V?=
 =?utf-8?B?cG5yU0lwSmtuNVdWYjU3dWtteFFhdjltRUhMdzBYZHhaNnJrOTRNSUUzdTBX?=
 =?utf-8?B?Z1AySlZUbHJXNllBMTdrR0xmY0tyZDVLWUpRNllVUGNQU2VLaWVmNXF4dzZv?=
 =?utf-8?B?LzF0WGJTeDBIMExsNlcxVStxdTMybzZ5RlZWdm1na1A0WEY4cGxhY281MHZY?=
 =?utf-8?B?SUNQVVRkMU9OaHdaTDJMbUJtdVQyVGFteXN1MTF4SkdkTlFNMzEwRFh1eks0?=
 =?utf-8?B?Z3VXRXZOM3FPQkVpZ1VTTEFqdENEWHhEaWhKRE1xQlFCeTgyRVNla3hJSzEw?=
 =?utf-8?B?c29KTllZNmYycWphZEkrYzIxbTZ0ZlQwOTJZNTJ3MEtTTC94S2lPQ1FqZ1I2?=
 =?utf-8?B?QlhhZEt6Wmx4WE5rZnI3TFBpUWRSNWtjaDAvenJOU2VHOFEzdjZtNWVpMWRC?=
 =?utf-8?B?NHRwMEdpQVpGd1krSFF3NWFEN2tDM2dkUnhueWRpOXFNcUQxcmJmS2lMcitE?=
 =?utf-8?B?NXZuMyt2d203Z21yUFR2RUs4ZmphdkhXdGxoVzk2VStVMXVrOHFtbG1GbGhE?=
 =?utf-8?B?N1FMMWw1dkFoYUlvb21KY25MMzRod0krRkEzNzZxODRvVDUrOHhjcVhNV2xX?=
 =?utf-8?B?V1cwMnU3R1dBTXM2OVJqK0p1L0RGRTNzSHJrbmYxWGVrZnorMWNFMEdKNUVt?=
 =?utf-8?B?U1dxekpmeGFwam4zTUtDSWlCaDVwRE4wYVpNUkJtYXpiSm9HOC96RHprNElN?=
 =?utf-8?B?bUZCbFlkTi9HeWp2SnBTQ0dxY3JSbWpkeFUxQTFxZk1DYkQ4Qnd5NEVJNEFH?=
 =?utf-8?B?d2ZhL1doTi9yWEJLYW42MWYweG9VV2lMeFllWWpIZGkxRUxQaGZjU29ld0R2?=
 =?utf-8?B?V25FTVQzSjFESGxjY2ZxeTBrN2RGUTVkRFF3ZVE1RHVFb1ZicHQ0eTBrZ1Zx?=
 =?utf-8?B?ODFtNzVZSVdKQ2JNd3FrQ2JPb24weFQ3cDBCRzBoaHJ6T3hPT0tNV2xGUEww?=
 =?utf-8?B?NkFlV0Q0WlJKQ0ZGOGlHQ25ObHRxb1RKdGE4dzZtSG9hQmV3TityWVhxVDlH?=
 =?utf-8?B?a0hjZXM5WlFCcFhMdW1CRXBlU0xya0xzbTdVYUVVSE81QnYxblFOK2cvVStX?=
 =?utf-8?B?RzlxRDhoUEl5eXVSZ2R6SDIwQ3hrRFFaZWtDQ201Nkd2am4xaE5hMC84ZVZy?=
 =?utf-8?B?aVRPb1BtZnRNOWc1QmVFUEFablBoZ1JMcENGS1UrUFI1ZVk4aHJQVDhWQWd1?=
 =?utf-8?B?eEZaM1E5ZEJHMEpZZWtRU0FKc2RXTTQyUDQwZUp0UVY0MHlGZWJ4Yko5ZGZI?=
 =?utf-8?B?cDI4RUtoVW0wUFo1VTViR0k1RGJ6bDZWUWswSTZHcmJlUGpqTDdlMjZjKzJQ?=
 =?utf-8?B?ZmgvbnhVZ0R4NEc0WDZMTTdZUjhxVVh6TWZvSnFuVzRMQ0lXdmIrQno3cmVs?=
 =?utf-8?B?bmJsQlJaREFKWTJRa0UzWW5Ea0J4YStBdFEvb3YraFVHbzZVWUlObE9hVzlX?=
 =?utf-8?B?aDliKy9PNFpmazI2Q1ozN1UzZk00aXRnUUxyeDVKcWVaamptZFgzNDNZeHIy?=
 =?utf-8?B?aFRON2pISTJwdy9ETW9CMThFWDQzelZ6RE9XSEtGVC90QkxVVmo3NGt3ZlFk?=
 =?utf-8?B?aTdMVFhFZGN5dGk1YVRLamE5U29weTl1eTRtKzFNSEN3R2djVm1ROVlUS2l3?=
 =?utf-8?B?Z0RGbnBQQXNOdjRRZG5NQ2twL25TRG9GcEltTzlkekM2bUpWUTlpTGU1UlI1?=
 =?utf-8?B?U0Y5NVJEYzRQVllmYlE4dTJLYmJIREU3UHhQZytYS1ZYU0s4VmJEL080WndK?=
 =?utf-8?B?NG9IVEtkQ0tUYlhLK0pqQ0gva09mTWt0dHE0TUR0YnhxbVZydjZsYjNYU2lF?=
 =?utf-8?B?WHF0T2puVldIc0N2c1o0N2ViTit1OE1wWjlNc1Uyd2dDczYrYVMvYThNSmRq?=
 =?utf-8?B?SkpOY0VnZW5MbEFwNm5TWjRCM0JDV2E5SHNHZDdPUlpXRTBQTGIydz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f7e660-4e03-485b-4d88-08dea2581d36
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 23:20:46.5168 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3iv4Mp4ZcG/fKq/sQUPIl5PzoEue6xfLziIBDc1lIOB0VI0E4L88yy54FalRG2xAEyw7Ym4YPKpvLK/TN3K8ZQ==
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

arch/arm/dts/imx8mq-librem5-r[4,3].dts is almost same as upstream Linux dts,
and arch/arm/dts/imx8mq-librem5.dtsi is out of sync with upstream linux
dts, but it should not break U-Boot after using OF_UPSTREAM. So switch to
OF_UPSTREAM by dropping the U-Boot copy of the dts, enabling OF_UPSTREAM and
updating CONFIG_DEFAULT_DEVICE_TREE.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/Makefile               |    3 +-
 arch/arm/dts/imx8mq-librem5-r3.dtsi |   45 --
 arch/arm/dts/imx8mq-librem5-r4.dts  |   27 -
 arch/arm/dts/imx8mq-librem5.dtsi    | 1382 -----------------------------------
 arch/arm/mach-imx/imx8m/Kconfig     |    1 +
 board/purism/librem5/MAINTAINERS    |    1 -
 configs/librem5_defconfig           |    2 +-
 7 files changed, 3 insertions(+), 1458 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 019928af9df..2cdcfa9f92e 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -889,8 +889,7 @@ dtb-$(CONFIG_ARCH_IMX8M) += \
 	imx8mp-dhcom-picoitx.dtb \
 	imx8mp-icore-mx8mp-edimm2.2.dtb \
 	imx8mp-msc-sm2s.dtb \
-	imx8mq-kontron-pitx-imx8m.dtb \
-	imx8mq-librem5-r4.dtb
+	imx8mq-kontron-pitx-imx8m.dtb
 
 dtb-$(CONFIG_ARCH_IMX9) += \
 	imx93-11x11-frdm.dtb \
diff --git a/arch/arm/dts/imx8mq-librem5-r3.dtsi b/arch/arm/dts/imx8mq-librem5-r3.dtsi
deleted file mode 100644
index e4f8b47cce4..00000000000
--- a/arch/arm/dts/imx8mq-librem5-r3.dtsi
+++ /dev/null
@@ -1,45 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-// Copyright (C) 2021 Purism SPC <kernel@puri.sm>
-
-/dts-v1/;
-
-/*
- * This file describes hardware that is shared among r3 ("Dogwood") and
- * later revisions of the Librem 5 so it has to be included in dts there.
- */
-
-#include "imx8mq-librem5.dtsi"
-
-/ {
-	model = "Purism Librem 5r3";
-	compatible = "purism,librem5r3", "purism,librem5", "fsl,imx8mq";
-};
-
-&accel_gyro {
-	mount-matrix =  "1",  "0",  "0",
-			"0",  "1",  "0",
-			"0",  "0", "-1";
-};
-
-&bq25895 {
-	ti,battery-regulation-voltage = <4200000>; /* uV */
-	ti,charge-current = <1500000>; /* uA */
-	ti,termination-current = <144000>;  /* uA */
-};
-
-&camera_front {
-	pinctrl-0 = <&pinctrl_csi1>, <&pinctrl_r3_camera_pwr>;
-	shutdown-gpios = <&gpio5 4 GPIO_ACTIVE_LOW>;
-};
-
-&iomuxc {
-	pinctrl_r3_camera_pwr: r3camerapwrgrp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_SPDIF_RX_GPIO5_IO4		0x83
-		>;
-	};
-};
-
-&proximity {
-	proximity-near-level = <25>;
-};
diff --git a/arch/arm/dts/imx8mq-librem5-r4.dts b/arch/arm/dts/imx8mq-librem5-r4.dts
deleted file mode 100644
index 1056b7981bd..00000000000
--- a/arch/arm/dts/imx8mq-librem5-r4.dts
+++ /dev/null
@@ -1,27 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-// Copyright (C) 2021 Purism SPC <kernel@puri.sm>
-
-/dts-v1/;
-
-#include "imx8mq-librem5-r3.dtsi"
-
-/ {
-	model = "Purism Librem 5r4";
-	compatible = "purism,librem5r4", "purism,librem5", "fsl,imx8mq";
-};
-
-&bat {
-	maxim,rsns-microohm = <1667>;
-};
-
-&led_backlight {
-	led-max-microamp = <25000>;
-};
-
-&lcd_panel {
-	compatible = "ys,ys57pss36bh5gq";
-};
-
-&proximity {
-	proximity-near-level = <10>;
-};
diff --git a/arch/arm/dts/imx8mq-librem5.dtsi b/arch/arm/dts/imx8mq-librem5.dtsi
deleted file mode 100644
index ae08556b2ef..00000000000
--- a/arch/arm/dts/imx8mq-librem5.dtsi
+++ /dev/null
@@ -1,1382 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2018-2020 Purism SPC
- */
-
-/dts-v1/;
-
-#include "dt-bindings/input/input.h"
-#include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/leds/common.h>
-#include "dt-bindings/pwm/pwm.h"
-#include "dt-bindings/usb/pd.h"
-#include "imx8mq.dtsi"
-
-/ {
-	model = "Purism Librem 5";
-	compatible = "purism,librem5", "fsl,imx8mq";
-	chassis-type = "handset";
-
-	backlight_dsi: backlight-dsi {
-		compatible = "led-backlight";
-		leds = <&led_backlight>;
-	};
-
-	pmic_osc: clock-pmic {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <32768>;
-		clock-output-names = "pmic_osc";
-	};
-
-	chosen {
-		stdout-path = &uart1;
-	};
-
-	gpio-keys {
-		compatible = "gpio-keys";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_keys>;
-
-		key-vol-down {
-			label = "VOL_DOWN";
-			gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_VOLUMEDOWN>;
-			debounce-interval = <50>;
-			wakeup-source;
-		};
-
-		key-vol-up {
-			label = "VOL_UP";
-			gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_VOLUMEUP>;
-			debounce-interval = <50>;
-			wakeup-source;
-		};
-	};
-
-	led-controller {
-		compatible = "pwm-leds";
-
-		led-0 {
-			function = LED_FUNCTION_STATUS;
-			color = <LED_COLOR_ID_BLUE>;
-			max-brightness = <248>;
-			pwms = <&pwm2 0 50000 0>;
-		};
-
-		led-1 {
-			function = LED_FUNCTION_STATUS;
-			color = <LED_COLOR_ID_GREEN>;
-			max-brightness = <248>;
-			pwms = <&pwm4 0 50000 0>;
-		};
-
-		led-2 {
-			function = LED_FUNCTION_STATUS;
-			color = <LED_COLOR_ID_RED>;
-			max-brightness = <248>;
-			pwms = <&pwm3 0 50000 0>;
-		};
-	};
-
-	reg_aud_1v8: regulator-audio-1v8 {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_audiopwr>;
-		regulator-name = "AUDIO_PWR_EN";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		gpio = <&gpio1 4 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	/*
-	 * the pinctrl for reg_csi_1v8 and reg_vcam_1v8 is added to the PMIC
-	 * since we can't have it twice in the 2 different regulator nodes.
-	 */
-	reg_csi_1v8: regulator-csi-1v8 {
-		compatible = "regulator-fixed";
-		regulator-name = "CAMERA_VDDIO_1V8";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		vin-supply = <&reg_vdd_3v3>;
-		gpio = <&gpio1 0 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	/* controlled by the CAMERA_POWER_KEY HKS */
-	reg_vcam_1v2: regulator-vcam-1v2 {
-		compatible = "regulator-fixed";
-		regulator-name = "CAMERA_VDDD_1V2";
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1200000>;
-		vin-supply = <&reg_vdd_1v8>;
-		enable-active-high;
-	};
-
-	reg_vcam_2v8: regulator-vcam-2v8 {
-		compatible = "regulator-fixed";
-		regulator-name = "CAMERA_VDDA_2V8";
-		regulator-min-microvolt = <2800000>;
-		regulator-max-microvolt = <2800000>;
-		vin-supply = <&reg_vdd_3v3>;
-		gpio = <&gpio1 0 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	reg_gnss: regulator-gnss {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_gnsspwr>;
-		regulator-name = "GNSS";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio3 12 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	reg_hub: regulator-hub {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_hub_pwr>;
-		regulator-name = "HUB";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio1 14 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	reg_lcd_1v8: regulator-lcd-1v8 {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_dsien>;
-		regulator-name = "LCD_1V8";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		vin-supply = <&reg_vdd_1v8>;
-		gpio = <&gpio1 5 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		/* Otherwise i2c3 is not functional */
-		regulator-always-on;
-	};
-
-	reg_lcd_3v4: regulator-lcd-3v4 {
-		compatible = "regulator-fixed";
-		regulator-name = "LCD_3V4";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_dsibiasen>;
-		vin-supply = <&reg_vsys_3v4>;
-		gpio = <&gpio1 20 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	reg_vdd_sen: regulator-vdd-sen {
-		compatible = "regulator-fixed";
-		regulator-name = "VDD_SEN";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	reg_vdd_1v8: regulator-vdd-1v8 {
-		compatible = "regulator-fixed";
-		regulator-name = "VDD_1V8";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		vin-supply = <&buck7_reg>;
-	};
-
-	reg_vdd_3v3: regulator-vdd-3v3 {
-		compatible = "regulator-fixed";
-		regulator-name = "VDD_3V3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	reg_vsys_3v4: regulator-vsys-3v4 {
-		compatible = "regulator-fixed";
-		regulator-name = "VSYS_3V4";
-		regulator-min-microvolt = <3400000>;
-		regulator-max-microvolt = <3400000>;
-		regulator-always-on;
-	};
-
-	reg_wifi_3v3: regulator-wifi-3v3 {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_wifi_pwr>;
-		regulator-name = "3V3_WIFI";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio3 10 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		vin-supply = <&reg_vdd_3v3>;
-	};
-
-	sound {
-		compatible = "simple-audio-card";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_hp>;
-		simple-audio-card,name = "Librem 5";
-		simple-audio-card,format = "i2s";
-		simple-audio-card,widgets =
-			"Headphone", "Headphones",
-			"Microphone", "Headset Mic",
-			"Microphone", "Digital Mic",
-			"Speaker", "Speaker";
-		simple-audio-card,routing =
-			"Headphones", "HPOUTL",
-			"Headphones", "HPOUTR",
-			"Speaker", "SPKOUTL",
-			"Speaker", "SPKOUTR",
-			"Headset Mic", "MICBIAS",
-			"IN3R", "Headset Mic",
-			"DMICDAT", "Digital Mic";
-		simple-audio-card,hp-det-gpio = <&gpio3 9 GPIO_ACTIVE_HIGH>;
-
-		simple-audio-card,cpu {
-			sound-dai = <&sai2>;
-		};
-
-		simple-audio-card,codec {
-			sound-dai = <&codec>;
-			clocks = <&clk IMX8MQ_CLK_SAI2_ROOT>;
-			frame-master;
-			bitclock-master;
-		};
-	};
-
-	sound-wwan {
-		compatible = "simple-audio-card";
-		simple-audio-card,name = "Modem";
-		simple-audio-card,format = "i2s";
-
-		simple-audio-card,cpu {
-			sound-dai = <&sai6>;
-			frame-inversion;
-		};
-
-		simple-audio-card,codec {
-			sound-dai = <&bm818_codec>;
-			frame-master;
-			bitclock-master;
-		};
-	};
-
-	usdhc2_pwrseq: pwrseq {
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_bt>, <&pinctrl_wifi_disable>;
-		compatible = "mmc-pwrseq-simple";
-		reset-gpios = <&gpio3 25 GPIO_ACTIVE_HIGH>,
-			      <&gpio4 29 GPIO_ACTIVE_HIGH>;
-	};
-
-	bm818_codec: sound-wwan-codec {
-		compatible = "broadmobi,bm818", "option,gtm601";
-		#sound-dai-cells = <0>;
-	};
-
-	vibrator {
-		compatible = "pwm-vibrator";
-		pwms = <&pwm1 0 1000000000 0>;
-		pwm-names = "enable";
-		vcc-supply = <&reg_vdd_3v3>;
-	};
-};
-
-&A53_0 {
-	cpu-supply = <&buck2_reg>;
-};
-
-&A53_1 {
-	cpu-supply = <&buck2_reg>;
-};
-
-&A53_2 {
-	cpu-supply = <&buck2_reg>;
-};
-
-&A53_3 {
-	cpu-supply = <&buck2_reg>;
-};
-
-&csi1 {
-	status = "okay";
-};
-
-&ddrc {
-	operating-points-v2 = <&ddrc_opp_table>;
-	status = "okay";
-
-	ddrc_opp_table: opp-table {
-		compatible = "operating-points-v2";
-
-		opp-25M {
-			opp-hz = /bits/ 64 <25000000>;
-		};
-
-		opp-100M {
-			opp-hz = /bits/ 64 <100000000>;
-		};
-
-		opp-800M {
-			opp-hz = /bits/ 64 <800000000>;
-		};
-	};
-};
-
-&dphy {
-	status = "okay";
-};
-
-&ecspi1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_ecspi1>;
-	cs-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-	status = "okay";
-
-	nor_flash: flash@0 {
-		compatible = "jedec,spi-nor";
-		reg = <0>;
-		spi-max-frequency = <1000000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		partition@0 {
-			label = "protected0";
-			reg = <0x0 0x30000>;
-			read-only;
-		};
-
-		partition@30000 {
-			label = "firmware";
-			reg = <0x30000 0x1d0000>;
-			read-only;
-		};
-	};
-};
-
-&gpio1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pmic_5v>;
-
-	pmic-5v-hog {
-		gpio-hog;
-		gpios = <1 GPIO_ACTIVE_HIGH>;
-		input;
-		lane-mapping = "pmic-5v";
-	};
-};
-
-&iomuxc {
-	pinctrl_audiopwr: audiopwrgrp {
-		fsl,pins = <
-			/* AUDIO_POWER_EN_3V3 */
-			MX8MQ_IOMUXC_GPIO1_IO04_GPIO1_IO4	0x83
-		>;
-	};
-
-	pinctrl_bl: blgrp {
-		fsl,pins = <
-			/* BACKLINGE_EN */
-			MX8MQ_IOMUXC_NAND_DQS_GPIO3_IO14	0x83
-		>;
-	};
-
-	pinctrl_bt: btgrp {
-		fsl,pins = <
-			/* BT_REG_ON */
-			MX8MQ_IOMUXC_SAI5_MCLK_GPIO3_IO25	0x83
-		>;
-	};
-
-	pinctrl_camera_pwr: camerapwrgrp {
-		fsl,pins = <
-			/* CAMERA_PWR_EN_3V3 */
-			MX8MQ_IOMUXC_GPIO1_IO00_GPIO1_IO0	0x83
-		>;
-	};
-
-	pinctrl_csi1: csi1grp {
-		fsl,pins = <
-			/* CSI1_NRST */
-			MX8MQ_IOMUXC_ENET_RXC_GPIO1_IO25	0x83
-		>;
-	};
-
-	pinctrl_charger_in: chargeringrp {
-		fsl,pins = <
-			/* CHRG_INT */
-			MX8MQ_IOMUXC_NAND_CE2_B_GPIO3_IO3	0x80
-		>;
-	};
-
-	pinctrl_dsibiasen: dsibiasengrp {
-		fsl,pins = <
-			/* DSI_BIAS_EN */
-			MX8MQ_IOMUXC_ENET_TD1_GPIO1_IO20	0x83
-		>;
-	};
-
-	pinctrl_dsien: dsiengrp {
-		fsl,pins = <
-			/* DSI_EN_3V3 */
-			MX8MQ_IOMUXC_GPIO1_IO05_GPIO1_IO5	0x83
-		>;
-	};
-
-	pinctrl_dsirst: dsirstgrp {
-		fsl,pins = <
-			/* DSI_RST */
-			MX8MQ_IOMUXC_ENET_RD3_GPIO1_IO29	0x83
-			/* DSI_TE */
-			MX8MQ_IOMUXC_ENET_RD2_GPIO1_IO28	0x83
-			/* TP_RST */
-			MX8MQ_IOMUXC_ENET_RX_CTL_GPIO1_IO24	0x83
-		>;
-	};
-
-	pinctrl_ecspi1: ecspigrp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_ECSPI1_MOSI_ECSPI1_MOSI	0x83
-			MX8MQ_IOMUXC_ECSPI1_MISO_ECSPI1_MISO	0x83
-			MX8MQ_IOMUXC_ECSPI1_SS0_GPIO5_IO9	0x19
-			MX8MQ_IOMUXC_ECSPI1_SCLK_ECSPI1_SCLK	0x83
-		>;
-	};
-
-	pinctrl_gauge: gaugegrp {
-		fsl,pins = <
-			/* BAT_LOW */
-			MX8MQ_IOMUXC_SAI5_RXC_GPIO3_IO20	0x80
-		>;
-	};
-
-	pinctrl_gnsspwr: gnsspwrgrp {
-		fsl,pins = <
-			/* GPS3V3_EN */
-			MX8MQ_IOMUXC_NAND_DATA06_GPIO3_IO12	0x83
-		>;
-	};
-
-	pinctrl_haptic: hapticgrp {
-		fsl,pins = <
-			/* MOTO */
-			MX8MQ_IOMUXC_SPDIF_EXT_CLK_PWM1_OUT	0x83
-		>;
-	};
-
-	pinctrl_hp: hpgrp {
-		fsl,pins = <
-			/* HEADPHONE_DET_1V8 */
-			MX8MQ_IOMUXC_NAND_DATA03_GPIO3_IO9	0x180
-		>;
-	};
-
-	pinctrl_hub_pwr: hubpwrgrp {
-		fsl,pins = <
-			/* HUB_PWR_3V3_EN */
-			MX8MQ_IOMUXC_GPIO1_IO14_GPIO1_IO14	0x83
-		>;
-	};
-
-	pinctrl_i2c1: i2c1grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_I2C1_SCL_I2C1_SCL		0x40000026
-			MX8MQ_IOMUXC_I2C1_SDA_I2C1_SDA		0x40000026
-		>;
-	};
-
-	pinctrl_i2c2: i2c2grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_I2C2_SCL_I2C2_SCL		0x40000026
-			MX8MQ_IOMUXC_I2C2_SDA_I2C2_SDA		0x40000026
-		>;
-	};
-
-	pinctrl_i2c3: i2c3grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_I2C3_SCL_I2C3_SCL		0x40000026
-			MX8MQ_IOMUXC_I2C3_SDA_I2C3_SDA		0x40000026
-		>;
-	};
-
-	pinctrl_i2c4: i2c4grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_I2C4_SCL_I2C4_SCL		0x40000026
-			MX8MQ_IOMUXC_I2C4_SDA_I2C4_SDA		0x40000026
-		>;
-	};
-
-	pinctrl_keys: keysgrp {
-		fsl,pins = <
-			/* VOL- */
-			MX8MQ_IOMUXC_ENET_MDIO_GPIO1_IO17	0x01C0
-			/* VOL+ */
-			MX8MQ_IOMUXC_ENET_MDC_GPIO1_IO16	0x01C0
-		>;
-	};
-
-	pinctrl_led_b: ledbgrp {
-		fsl,pins = <
-			/* LED_B */
-			MX8MQ_IOMUXC_GPIO1_IO13_PWM2_OUT	0x06
-		>;
-	};
-
-	pinctrl_led_g: ledggrp {
-		fsl,pins = <
-			/* LED_G */
-			MX8MQ_IOMUXC_SAI3_MCLK_PWM4_OUT		0x06
-		>;
-	};
-
-	pinctrl_led_r: ledrgrp {
-		fsl,pins = <
-			/* LED_R */
-			MX8MQ_IOMUXC_SPDIF_TX_PWM3_OUT		0x06
-		>;
-	};
-
-	pinctrl_mag: maggrp {
-		fsl,pins = <
-			/* INT_MAG */
-			MX8MQ_IOMUXC_SAI5_RXD1_GPIO3_IO22	0x80
-		>;
-	};
-
-	pinctrl_pmic: pmicgrp {
-		fsl,pins = <
-			/* PMIC_NINT */
-			MX8MQ_IOMUXC_GPIO1_IO07_GPIO1_IO7	0x80
-		>;
-	};
-
-	pinctrl_pmic_5v: pmic5vgrp {
-		fsl,pins = <
-			/* PMIC_5V */
-			MX8MQ_IOMUXC_GPIO1_IO01_GPIO1_IO1	0x80
-		>;
-	};
-
-	pinctrl_prox: proxgrp {
-		fsl,pins = <
-			/* INT_LIGHT */
-			MX8MQ_IOMUXC_NAND_DATA01_GPIO3_IO7	0x80
-		>;
-	};
-
-	pinctrl_rtc: rtcgrp {
-		fsl,pins = <
-			/* RTC_INT */
-			MX8MQ_IOMUXC_GPIO1_IO09_GPIO1_IO9	0x80
-		>;
-	};
-
-	pinctrl_sai2: sai2grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_SAI2_TXD0_SAI2_TX_DATA0	0xd6
-			MX8MQ_IOMUXC_SAI2_TXFS_SAI2_TX_SYNC	0xd6
-			MX8MQ_IOMUXC_SAI2_MCLK_SAI2_MCLK	0xd6
-			MX8MQ_IOMUXC_SAI2_RXD0_SAI2_RX_DATA0	0xd6
-			MX8MQ_IOMUXC_SAI2_TXC_SAI2_TX_BCLK	0xd6
-		>;
-	};
-
-	pinctrl_sai6: sai6grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_SAI1_RXD5_SAI6_RX_DATA0	0xd6
-			MX8MQ_IOMUXC_SAI1_RXD6_SAI6_RX_SYNC	0xd6
-			MX8MQ_IOMUXC_SAI1_TXD4_SAI6_RX_BCLK	0xd6
-			MX8MQ_IOMUXC_SAI1_TXD5_SAI6_TX_DATA0	0xd6
-		>;
-	};
-
-	pinctrl_tcpc: tcpcgrp {
-		fsl,pins = <
-			/* TCPC_INT */
-			MX8MQ_IOMUXC_GPIO1_IO10_GPIO1_IO10	0x01C0
-		>;
-	};
-
-	pinctrl_touch: touchgrp {
-		fsl,pins = <
-			/* TP_INT */
-			MX8MQ_IOMUXC_ENET_RD1_GPIO1_IO27	0x80
-		>;
-	};
-
-	pinctrl_typec: typecgrp {
-		fsl,pins = <
-			/* TYPEC_MUX_EN */
-			MX8MQ_IOMUXC_GPIO1_IO11_GPIO1_IO11	0x83
-		>;
-	};
-
-	pinctrl_uart1: uart1grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_UART1_RXD_UART1_DCE_RX	0x49
-			MX8MQ_IOMUXC_UART1_TXD_UART1_DCE_TX	0x49
-		>;
-	};
-
-	pinctrl_uart2: uart2grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_UART2_TXD_UART2_DCE_TX	0x49
-			MX8MQ_IOMUXC_UART2_RXD_UART2_DCE_RX	0x49
-		>;
-	};
-
-	pinctrl_uart3: uart3grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_UART3_RXD_UART3_DCE_RX	0x49
-			MX8MQ_IOMUXC_UART3_TXD_UART3_DCE_TX	0x49
-		>;
-	};
-
-	pinctrl_uart4: uart4grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_ECSPI2_SCLK_UART4_DCE_RX		0x49
-			MX8MQ_IOMUXC_ECSPI2_MOSI_UART4_DCE_TX		0x49
-			MX8MQ_IOMUXC_ECSPI2_MISO_UART4_DCE_CTS_B	0x49
-			MX8MQ_IOMUXC_ECSPI2_SS0_UART4_DCE_RTS_B		0x49
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
-	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
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
-			MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x8d
-			MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0xc1
-		>;
-	};
-
-	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
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
-			MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x9f
-			MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0xc1
-		>;
-	};
-
-	pinctrl_usdhc2: usdhc2grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_SD2_CD_B_GPIO2_IO12	0x80
-			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK		0x83
-			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD		0xc3
-			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0	0xc3
-			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1	0xc3
-			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2	0xc3
-			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3	0xc3
-			MX8MQ_IOMUXC_SD2_RESET_B_USDHC2_RESET_B 0xc1
-		>;
-	};
-
-	pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
-		fsl,pins = <
-			MX8MQ_IOMUXC_SD2_CD_B_GPIO2_IO12	0x80
-			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK		0x8d
-			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD		0xcd
-			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0	0xcd
-			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1	0xcd
-			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2	0xcd
-			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3	0xcd
-			MX8MQ_IOMUXC_SD2_RESET_B_USDHC2_RESET_B 0xc1
-		>;
-	};
-
-	pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
-		fsl,pins = <
-			MX8MQ_IOMUXC_SD2_CD_B_GPIO2_IO12	0x80
-			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK		0x9f
-			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD		0xcf
-			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0	0xcf
-			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1	0xcf
-			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2	0xcf
-			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3	0xcf
-			MX8MQ_IOMUXC_SD2_RESET_B_USDHC2_RESET_B 0xc1
-		>;
-	};
-
-	pinctrl_wifi_disable: wifidisablegrp {
-		fsl,pins = <
-			/* WIFI_REG_ON */
-			MX8MQ_IOMUXC_SAI3_RXC_GPIO4_IO29	0x83
-		>;
-	};
-
-	pinctrl_wifi_pwr: wifipwrgrp {
-		fsl,pins = <
-			/* WIFI3V3_EN */
-			MX8MQ_IOMUXC_NAND_DATA04_GPIO3_IO10	0x83
-		>;
-	};
-
-	pinctrl_wdog: wdoggrp {
-		fsl,pins = <
-			/* nWDOG */
-			MX8MQ_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B	0x1f
-		>;
-	};
-};
-
-&i2c1 {
-	clock-frequency = <387000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c1>;
-	status = "okay";
-
-	typec_pd: usb-pd@3f {
-		compatible = "ti,tps6598x";
-		reg = <0x3f>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_typec>, <&pinctrl_tcpc>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
-		interrupt-names = "irq";
-
-		connector {
-			compatible = "usb-c-connector";
-			label = "USB-C";
-			data-role = "dual";
-
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				port@0 {
-					reg = <0>;
-
-					usb_con_hs: endpoint {
-						remote-endpoint = <&typec_hs>;
-					};
-				};
-
-				port@1 {
-					reg = <1>;
-
-					usb_con_ss: endpoint {
-						remote-endpoint = <&typec_ss>;
-					};
-				};
-			};
-		};
-	};
-
-	pmic: pmic@4b {
-		compatible = "rohm,bd71837";
-		reg = <0x4b>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pmic>, <&pinctrl_camera_pwr>;
-		clocks = <&pmic_osc>;
-		clock-names = "osc";
-		clock-output-names = "pmic_clk";
-		interrupt-parent = <&gpio1>;
-		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
-		rohm,reset-snvs-powered;
-
-		regulators {
-			buck1_reg: BUCK1 {
-				regulator-name = "buck1";
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1300000>;
-				regulator-boot-on;
-				regulator-ramp-delay = <1250>;
-				rohm,dvs-run-voltage = <900000>;
-				rohm,dvs-idle-voltage = <850000>;
-				rohm,dvs-suspend-voltage = <800000>;
-				regulator-always-on;
-			};
-
-			buck2_reg: BUCK2 {
-				regulator-name = "buck2";
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1300000>;
-				regulator-boot-on;
-				regulator-ramp-delay = <1250>;
-				rohm,dvs-run-voltage = <1000000>;
-				rohm,dvs-idle-voltage = <900000>;
-				regulator-always-on;
-			};
-
-			buck3_reg: BUCK3 {
-				regulator-name = "buck3";
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1300000>;
-				regulator-boot-on;
-				rohm,dvs-run-voltage = <900000>;
-			};
-
-			buck4_reg: BUCK4 {
-				regulator-name = "buck4";
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1300000>;
-				rohm,dvs-run-voltage = <1000000>;
-			};
-
-			buck5_reg: BUCK5 {
-				regulator-name = "buck5";
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1350000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			buck6_reg: BUCK6 {
-				regulator-name = "buck6";
-				regulator-min-microvolt = <3000000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			buck7_reg: BUCK7 {
-				regulator-name = "buck7";
-				regulator-min-microvolt = <1605000>;
-				regulator-max-microvolt = <1995000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			buck8_reg: BUCK8 {
-				regulator-name = "buck8";
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1400000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo1_reg: LDO1 {
-				regulator-name = "ldo1";
-				regulator-min-microvolt = <3000000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				/* leave on for snvs power button */
-				regulator-always-on;
-			};
-
-			ldo2_reg: LDO2 {
-				regulator-name = "ldo2";
-				regulator-min-microvolt = <900000>;
-				regulator-max-microvolt = <900000>;
-				regulator-boot-on;
-				/* leave on for snvs power button */
-				regulator-always-on;
-			};
-
-			ldo3_reg: LDO3 {
-				regulator-name = "ldo3";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo4_reg: LDO4 {
-				regulator-name = "ldo4";
-				regulator-min-microvolt = <900000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo5_reg: LDO5 {
-				/* VDD_PHY_0V9 - MIPI and HDMI domains */
-				regulator-name = "ldo5";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			ldo6_reg: LDO6 {
-				/* VDD_PHY_0V9 - MIPI, HDMI and USB domains */
-				regulator-name = "ldo6";
-				regulator-min-microvolt = <900000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo7_reg: LDO7 {
-				/* VDD_PHY_3V3 - USB domain */
-				regulator-name = "ldo7";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-		};
-	};
-
-	rtc@68 {
-		compatible = "microcrystal,rv4162";
-		reg = <0x68>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_rtc>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
-	};
-};
-
-&i2c2 {
-	clock-frequency = <387000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c2>;
-	status = "okay";
-
-	magnetometer@1e	{
-		compatible = "st,lsm9ds1-magn";
-		reg = <0x1e>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_mag>;
-		interrupt-parent = <&gpio3>;
-		interrupts = <22 IRQ_TYPE_LEVEL_HIGH>;
-		vdd-supply = <&reg_vdd_sen>;
-		vddio-supply = <&reg_vdd_1v8>;
-	};
-
-	regulator@3e {
-		compatible = "tps65132";
-		reg = <0x3e>;
-
-		reg_lcd_avdd: outp {
-			regulator-name = "LCD_AVDD";
-			vin-supply = <&reg_lcd_3v4>;
-		};
-
-		reg_lcd_avee: outn {
-			regulator-name = "LCD_AVEE";
-			vin-supply = <&reg_lcd_3v4>;
-		};
-	};
-
-	proximity: prox@60 {
-		compatible = "vishay,vcnl4040";
-		reg = <0x60>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_prox>;
-		interrupt-parent = <&gpio3>;
-		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
-	};
-
-	accel_gyro: accel-gyro@6a	{
-		compatible = "st,lsm9ds1-imu";
-		reg = <0x6a>;
-		vdd-supply = <&reg_vdd_sen>;
-		vddio-supply = <&reg_vdd_1v8>;
-	};
-};
-
-&i2c3 {
-	clock-frequency = <387000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c3>;
-	status = "okay";
-
-	codec: audio-codec@1a {
-		compatible = "wlf,wm8962";
-		reg = <0x1a>;
-		clocks = <&clk IMX8MQ_CLK_SAI2_ROOT>;
-		assigned-clocks = <&clk IMX8MQ_CLK_SAI2>;
-		assigned-clock-parents = <&clk IMX8MQ_AUDIO_PLL1_OUT>;
-		assigned-clock-rates = <24576000>;
-		#sound-dai-cells = <0>;
-		mic-cfg = <0x200>;
-		DCVDD-supply = <&reg_aud_1v8>;
-		DBVDD-supply = <&reg_aud_1v8>;
-		AVDD-supply = <&reg_aud_1v8>;
-		CPVDD-supply = <&reg_aud_1v8>;
-		MICVDD-supply = <&reg_aud_1v8>;
-		PLLVDD-supply = <&reg_aud_1v8>;
-		SPKVDD1-supply = <&reg_vsys_3v4>;
-		SPKVDD2-supply = <&reg_vsys_3v4>;
-		gpio-cfg = <
-			0x0000 /* n/c */
-			0x0001 /* gpio2, 1: default */
-			0x0013 /* gpio3, 2: dmicclk */
-			0x0000 /* n/c, 3: default */
-			0x8014 /* gpio5, 4: dmic_dat */
-			0x0000 /* gpio6, 5: default */
-		>;
-	};
-
-	camera_front: camera@20 {
-		compatible = "hynix,hi846";
-		reg = <0x20>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_csi1>;
-		clocks = <&clk IMX8MQ_CLK_CLKO2>;
-		assigned-clocks = <&clk IMX8MQ_CLK_CLKO2>;
-		assigned-clock-rates = <25000000>;
-		reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
-		vdda-supply = <&reg_vcam_2v8>;
-		vddd-supply = <&reg_vcam_1v2>;
-		vddio-supply = <&reg_csi_1v8>;
-		rotation = <90>;
-		orientation = <0>;
-
-		port {
-			camera1_ep: endpoint {
-				data-lanes = <1 2>;
-				link-frequencies = /bits/ 64
-					<80000000 200000000 300000000>;
-				remote-endpoint = <&mipi1_sensor_ep>;
-			};
-		};
-	};
-
-	backlight@36 {
-		compatible = "ti,lm36922";
-		reg = <0x36>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_bl>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		enable-gpios = <&gpio3 14 GPIO_ACTIVE_HIGH>;
-		vled-supply = <&reg_vsys_3v4>;
-		ti,ovp-microvolt = <25000000>;
-
-		led_backlight: led@0 {
-			reg = <0>;
-			label = ":backlight";
-			linux,default-trigger = "backlight";
-			led-max-microamp = <20000>;
-		};
-	};
-
-	touchscreen@38 {
-		compatible = "edt,edt-ft5506";
-		reg = <0x38>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_touch>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
-		touchscreen-size-x = <720>;
-		touchscreen-size-y = <1440>;
-		vcc-supply = <&reg_lcd_1v8>;
-	};
-};
-
-&i2c4 {
-	clock-frequency = <387000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c4>;
-	status = "okay";
-
-	vcm@c {
-		compatible = "dongwoon,dw9714";
-		reg = <0x0c>;
-		vcc-supply = <&reg_csi_1v8>;
-	};
-
-	bat: fuel-gauge@36 {
-		compatible = "maxim,max17055";
-		reg = <0x36>;
-		interrupt-parent = <&gpio3>;
-		interrupts = <20 IRQ_TYPE_LEVEL_LOW>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_gauge>;
-		power-supplies = <&bq25895>;
-		maxim,over-heat-temp = <700>;
-		maxim,over-volt = <4500>;
-		maxim,rsns-microohm = <5000>;
-	};
-
-	bq25895: charger@6a {
-		compatible = "ti,bq25895", "ti,bq25890";
-		reg = <0x6a>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_charger_in>;
-		interrupt-parent = <&gpio3>;
-		interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
-		phys = <&usb3_phy0>;
-		ti,precharge-current = <130000>; /* uA */
-		ti,minimum-sys-voltage = <3700000>; /* uV */
-		ti,boost-voltage = <5000000>; /* uV */
-		ti,boost-max-current = <1500000>; /* uA */
-		ti,use-vinmin-threshold = <1>; /* enable VINDPM */
-		ti,vinmin-threshold = <3900000>; /* uV */
-		monitored-battery = <&bat>;
-		power-supplies = <&typec_pd>;
-	};
-};
-
-&lcdif {
-	status = "okay";
-};
-
-&mipi_csi1 {
-	status = "okay";
-
-	ports {
-		port@0 {
-			reg = <0>;
-
-			mipi1_sensor_ep: endpoint {
-				remote-endpoint = <&camera1_ep>;
-				data-lanes = <1 2>;
-			};
-		};
-	};
-};
-
-&mipi_dsi {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	status = "okay";
-
-	lcd_panel: panel@0 {
-		compatible = "mantix,mlaf057we51-x";
-		reg = <0>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_dsirst>;
-		avdd-supply = <&reg_lcd_avdd>;
-		avee-supply = <&reg_lcd_avee>;
-		vddi-supply = <&reg_lcd_1v8>;
-		backlight = <&backlight_dsi>;
-		reset-gpios = <&gpio1 29 GPIO_ACTIVE_LOW>;
-		mantix,tp-rstn-gpios = <&gpio1 24 GPIO_ACTIVE_LOW>;
-
-		port {
-			panel_in: endpoint {
-				remote-endpoint = <&mipi_dsi_out>;
-			};
-		};
-	};
-
-	ports {
-		port@1 {
-			reg = <1>;
-
-			mipi_dsi_out: endpoint {
-				remote-endpoint = <&panel_in>;
-			};
-		};
-	};
-};
-
-&pgc_gpu {
-	power-supply = <&buck3_reg>;
-};
-
-&pgc_mipi {
-	power-supply = <&ldo5_reg>;
-};
-
-&pgc_vpu {
-	power-supply = <&buck4_reg>;
-};
-
-&pwm1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_haptic>;
-	status = "okay";
-};
-
-&pwm2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_led_b>;
-	status = "okay";
-};
-
-&pwm3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_led_r>;
-	status = "okay";
-};
-
-&pwm4 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_led_g>;
-	status = "okay";
-};
-
-&sai2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_sai2>;
-	assigned-clocks = <&clk IMX8MQ_CLK_SAI2>;
-	assigned-clock-parents = <&clk IMX8MQ_AUDIO_PLL1_OUT>;
-	assigned-clock-rates = <24576000>;
-	status = "okay";
-};
-
-&sai6 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_sai6>;
-	assigned-clocks = <&clk IMX8MQ_CLK_SAI6>;
-	assigned-clock-parents = <&clk IMX8MQ_AUDIO_PLL1_OUT>;
-	assigned-clock-rates = <24576000>;
-	fsl,sai-synchronous-rx;
-	status = "okay";
-};
-
-&snvs_pwrkey {
-	status = "okay";
-};
-
-&snvs_rtc {
-	status = "disabled";
-};
-
-&uart1 { /* console */
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1>;
-	status = "okay";
-};
-
-&uart2 { /* TPS - GPS - DEBUG */
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
-	status = "okay";
-
-	gnss {
-		compatible = "globaltop,pa6h";
-		vcc-supply = <&reg_gnss>;
-		current-speed = <9600>;
-	};
-};
-
-&uart3 { /* SMC */
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart3>;
-	status = "okay";
-};
-
-&uart4 { /* BT */
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart4>;
-	uart-has-rtscts;
-	status = "okay";
-};
-
-&usb3_phy0 {
-	status = "okay";
-};
-
-&usb3_phy1 {
-	vbus-supply = <&reg_hub>;
-	status = "okay";
-};
-
-&usb_dwc3_0 {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	dr_mode = "otg";
-	snps,dis_u3_susphy_quirk;
-	usb-role-switch;
-	status = "okay";
-
-	port@0 {
-		reg = <0>;
-
-		typec_hs: endpoint {
-			remote-endpoint = <&usb_con_hs>;
-		};
-	};
-
-	port@1 {
-		reg = <1>;
-
-		typec_ss: endpoint {
-			remote-endpoint = <&usb_con_ss>;
-		};
-	};
-};
-
-&usb_dwc3_1 {
-	dr_mode = "host";
-	status = "okay";
-	#address-cells = <1>;
-	#size-cells = <0>;
-
-	/* Microchip USB2642 */
-	hub@1 {
-		compatible = "usb424,2640";
-		reg = <1>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		mass-storage@1 {
-			compatible = "usb424,4041";
-			reg = <1>;
-		};
-	};
-};
-
-&usdhc1 {
-	assigned-clocks = <&clk IMX8MQ_CLK_USDHC1>;
-	assigned-clock-rates = <400000000>;
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc1>;
-	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
-	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
-	bus-width = <8>;
-	vmmc-supply = <&reg_vdd_3v3>;
-	power-supply = <&reg_vdd_1v8>;
-	non-removable;
-	status = "okay";
-};
-
-&usdhc2 {
-	assigned-clocks = <&clk IMX8MQ_CLK_USDHC2>;
-	assigned-clock-rates = <200000000>;
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc2>;
-	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
-	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
-	bus-width = <4>;
-	vmmc-supply = <&reg_wifi_3v3>;
-	mmc-pwrseq = <&usdhc2_pwrseq>;
-	post-power-on-delay-ms = <1000>;
-	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
-	max-frequency = <50000000>;
-	disable-wp;
-	cap-sdio-irq;
-	keep-power-in-suspend;
-	wakeup-source;
-	status = "okay";
-};
-
-&wdog1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_wdog>;
-	fsl,ext-reset-output;
-	status = "okay";
-};
diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index 6b5903104a5..dd720b819db 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -429,6 +429,7 @@ config TARGET_LIBREM5
 	select IMX8MQ
 	select SUPPORT_SPL
 	select IMX8M_LPDDR4
+	imply OF_UPSTREAM
 
 endchoice
 
diff --git a/board/purism/librem5/MAINTAINERS b/board/purism/librem5/MAINTAINERS
index 09e7f20e33c..818e1850302 100644
--- a/board/purism/librem5/MAINTAINERS
+++ b/board/purism/librem5/MAINTAINERS
@@ -2,7 +2,6 @@ PURISM LIBREM5 PHONE
 M:	Angus Ainslie <angus@akkea.ca>
 R:	kernel@puri.sm
 S:	Supported
-F:	arch/arm/dts/imx8mq-librem5*
 F:	board/purism/librem5/
 F:	configs/librem5_defconfig
 F:	include/configs/librem5.h
diff --git a/configs/librem5_defconfig b/configs/librem5_defconfig
index d9d32bf5a50..d01041a67a2 100644
--- a/configs/librem5_defconfig
+++ b/configs/librem5_defconfig
@@ -11,7 +11,7 @@ CONFIG_SYS_I2C_MXC_I2C2=y
 CONFIG_SYS_I2C_MXC_I2C3=y
 CONFIG_SYS_I2C_MXC_I2C4=y
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx8mq-librem5-r4"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mq-librem5-r4"
 CONFIG_TARGET_LIBREM5=y
 CONFIG_DM_RESET=y
 CONFIG_SYS_MONITOR_LEN=524288

-- 
2.51.0

