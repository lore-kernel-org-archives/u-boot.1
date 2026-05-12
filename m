Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0FDCD37AC
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 04:40:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5072D8341A;
	Tue, 12 May 2026 06:40:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="m46UkN6e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41D138464D; Tue, 12 May 2026 05:08:06 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E80A083CD3
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 05:07:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QXX2hGu7KgFcMzKb0Ks8bjkOLzYQ4fpq42/EfuaLnNzirmtMHSNFcPajtV8N9O+Jq3egeyxRrpGUZK97BSwvoQ8/tDty4toW8dP4qRlbl+/kp/YrkQPVWkKrc6EGfpkaOd+pD305/GOQb2XQyL+omL9obrKCWFQ6RiShG3P6tVA/vOMocK0a31lRugoG94jBZofx4C8EqVXtMFip1geCSmijlbOT6UlWE4evkuqilILhppN23Sap6PAqfyAmXRlpAtGpLMW6H0vYupGooynLV0ReIuGSCeuvVmu4Id94Le6yIl5QZ2hoCC1VdbhdS1mbC1u3LxXzV90IORzM+rkquw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WqejgcuyEQN/Yg/Ntee1U3AuEjxGvUckN+QoqfXrws=;
 b=ZEmOW2nMBSRZmG9+n3tCoTwNid9gB90pBVuQGUBxQE5IaHDeF6h5fY/JxJskv9J7nbDSpdYeL4uAi2lbqbiIr7P4KUnm9+nMUVhcLlfy7Bp0jymiDJLW44l51Wl/6Z5nesG1Fzt/D82fUO1l4tYdCbkFdAQxl+/dTxySGGyXNTO1x1U5tknuGaQveU8GoOAIUM5LipU0rHfmP9T0ML+dVQf4LlwPUHcEkv+hNMM73RoODplFe5l4FY0vKlI1OyjzJ4J+6AJAFXQtjJftuW2aRwmkN/QMDYc0N9PxVZyj6ncItdwFYos/RR0u3imkocWBwVhFj+f+NLqDr5l0e5HZEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WqejgcuyEQN/Yg/Ntee1U3AuEjxGvUckN+QoqfXrws=;
 b=m46UkN6e++mkdOEMuiHnnTV4jAW/PexVasVb0Oe41iSL1sDwJTN4WTCJnCdUDZBt8tR9qroAZsbZZqfG4UONgAeOTMbRveO0Y37XJNb4/u1g9sAmHoy9e2kHG9xTgJMWxZdCHcLgBYAdaQTxR2CYBfL8onmeFHDK2OHMWmxclnXNVCifUsmuv38F5gg6x2mM91hWSJ2g3E+ivhaCeBdo5ExJ6naTsczfxXZ5lWLli1rJmxFSBBHDoAXovBkma+9wvx+EMuZNg3iWAxz0y8WMHtZEcVZi68QriNLxZE5rzUm/LO6ZPT1zk8FdsLUO9jiuEDZbdZw2gGIhyqY40XtV1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by FRWPR04MB11271.eurprd04.prod.outlook.com (2603:10a6:d10:19c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 03:07:51 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 03:07:51 +0000
From: alice.guo@oss.nxp.com
Subject: [PATCH v3 0/9] imx: Switch watchdog addressing from macros to
 devicetree
Date: Tue, 12 May 2026 11:10:07 +0800
Message-Id: <20260512-wdt-v1-0-0b9e1993557b@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA+aAmoC/yWMyw5AQBAEf0X6bBNWEH5FHIwdjAOy65WIf7c4V
 qe6Lji2wg5lcMHyLk7myUMcBmiHZupZifEMHeksSmOtDrMqQ0RJnnJhqIE3F8udnF+lwp6g/je
 30cjt+t5x3w/b9Bt4awAAAA==
X-Change-ID: 20260512-wdt-dbbb375e9dba
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Christoph Stoidner <c.stoidner@phytec.de>, upstream@lists.phytec.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Joseph Guo <qijian.guo@nxp.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Francesco Valla <francesco@valla.it>, Ye Li <ye.li@nxp.com>, 
 Primoz Fiser <primoz.fiser@norik.com>, Jacky Bai <ping.bai@nxp.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Andre Przywara <andre.przywara@arm.com>, Brian Sune <briansune@gmail.com>, 
 Johan Jonker <jbx6244@gmail.com>, Hai Pham <hai.pham.ud@renesas.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, Ion Agorria <ion@agorria.com>, 
 Paul Kocialkowski <contact@paulk.fr>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Mathieu Othacehe <m.othacehe@gmail.com>, David Zang <davidzangcs@gmail.com>, 
 Simon Glass <sjg@chromium.org>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 =?utf-8?q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Martin Schwan <m.schwan@phytec.de>, 
 Tim Harvey <tharvey@gateworks.com>, Simona Toaca <simona.toaca@nxp.com>, 
 Franz Schnyder <franz.schnyder@toradex.com>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI1PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::13) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|FRWPR04MB11271:EE_
X-MS-Office365-Filtering-Correlation-Id: 21a235f7-9742-46e7-6ccc-08deafd3a702
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|7416014|366016|19092799006|18002099003|56012099003|11063799003|38350700014;
X-Microsoft-Antispam-Message-Info: CKfkfucGnrGKzNr6VDupuqhUlHVSBIiyjnAvhUYbLo6E+CvKBxvwJZ2Y6Hnru1MdM3siCWT7IXQQ+YBxpYJFMK/PohnUdv1P11cxhwEXBjSHBH0fpHrncdyQceU6neQtNXy9tvBVXGNOVMdwquTNCHgnvYhc/bqTCqzMHbNfWfP/2M65pP3+wxpT85sDofmwtLD3jXbFF1rvUK2zyeDOSeEsE0CE8lgqCwMBpDfVAXwNN1jyiD2MB004ICTGOubIbjUtgrM/iRvQjFASJp9moTKTugco9pbjzZNHLqOLOOvutor7nwdK+QyQzGItyV74sbYwrK56CjPemEI/70bi7ulqZS+/DHLY67tMz5Pd26hW0NzubJcsD2akOmMY9GFdQVd/ibYTBb3CQLL2s2+OYeliQsyJL22jE4/e8O20S4UyfR/d8YSY73NjBjk3XDcWDuQ7DaxsHCVrLflwxeC1Asw/KEbQhr97Vq0uKJ0qoRFGqKtYz+BPWoYiXGTNnNZpLpDrG/3FMyrwika/uZETWBccGNbPmlOKV5f0eB4qF80uJJVh3kQQEfyvTHGACsmzhSkcJrD63L4bS/xvebFAEdOGso2tdPjQD73nDNwh/JpzxcBltCJzE1+cuDHq8VncG8T9EOUZ+b94vglWxV8yN6ejH7FNUWQpkuQtdvZGZ3fa25OVbnSl4YGKuNhGqUyWVX4oqu2j+qNqvS/kKa2VrQBY3s/GQ/IrE+3QOtcJwFHhbOb+XHKmfLWS6QJ7HL/5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(7416014)(366016)(19092799006)(18002099003)(56012099003)(11063799003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjRKS0RDMVB3L0JaTkhxYXA4UlNkdlJmUDJkQy92RTBZV1ZrbElTeXR2Kzd1?=
 =?utf-8?B?bjA2Rm9RUlNYSHNhaXJQSG5YUHBTdzUwV0RyOXQ5aUZ4VjUrU1prOERhUmVs?=
 =?utf-8?B?SW02dVpFV1A4T1loSGt6dE5ReEx0VWF5dG1OcHQ1clRvSTlxT2RmRFRjMHZ4?=
 =?utf-8?B?VXgveVF0WHBwQmJjYkFnWE1qa09YNlFyclhJM2RPQWdtdmQ5bEI4WnBwNjBQ?=
 =?utf-8?B?QWk3ZHUxYTkwRmhXcENBTVEwamJ0eXhLTlh2anNBSnl4OXJHRExSeGt1eTBX?=
 =?utf-8?B?ak5YZTNDdFNxWndweGlYM1ozdVYwZm0reHg2K0ViaWlhM1A3VHFRQTZ1dDZQ?=
 =?utf-8?B?dzJISlZGQ21CeUtPRW4rOTVraUZqQUIwaDYrWGxwK3Q5UTBFZlFXSkEvbGJy?=
 =?utf-8?B?ZkZlajh4YW1tUXd1SHlPbUpQcDh1QnhsSThWd2ZFZWI2MVkxMUJZUkRwOWpW?=
 =?utf-8?B?ay95d0Rxdi8vRnI4ckxSMWdSTmZrcmZuaHVpTUw3eEhHMUkxYXkraSszMVNG?=
 =?utf-8?B?UzFMRHA2MWdZZEZXYnBPR0JmN3NLak1ZOEc3eHhOUk5vRDZoNnpkL1B1ZzRV?=
 =?utf-8?B?a0oxMmNYN3Q5aG56SWJSVCtXczBzVDFVZzhudVNzaVZLNEVRZTl0RjBWNXQ2?=
 =?utf-8?B?d3JzVW5GZHVLb0Q3TW9seU5QZThrK3NUSDF4OXZYdFYwckVDQzNtYW1oSjBE?=
 =?utf-8?B?dU5paUtUdUFwanE5bVgyWU9PNVFlRTkvTHl3bGg4b1FEWThxcWkrYlFVdWh1?=
 =?utf-8?B?aDN2WG1YNUo1MjdkUVlhYXhkZ1V3TzdVVEIzZzJOQ1Z4b2Vlcml2dkQ4RUw1?=
 =?utf-8?B?R1hIYjVnU1lSWkNVakI1eEZZN05NQWR6MlhqRlBoUWY1V0IyYmpReit5UUR4?=
 =?utf-8?B?bXJwR1FpNk5OeDduTy8xdHF3bEJNZnhXRnZTelB4WmdmUEFQckt3ZW1BSXlS?=
 =?utf-8?B?cFYzV2V4WEk2dVpMZTUrS3BoQUt5YUM4N09WWHJDVWMyNkl6RXh5TmhFMlJO?=
 =?utf-8?B?a2lENlpKRm94MGZsTktyTUVKOWdOLzdvYmYwOS90UVU2YlpONTNzWm1oTmVQ?=
 =?utf-8?B?K2QvcHU3K0c5UlB6RzdteU1YZ2Z2QlR6Vm9vRWZ6aGNSa3NDUFl5eTIya1NV?=
 =?utf-8?B?WGxySGdrVUZXbTkzeWNwTzVnVGtIMTluSVNPcU9VMTQyU2NJSXowUHFrMEJR?=
 =?utf-8?B?YU9adXV5Z0RmYmp1UCtQa3AxcC9wOWFSOEQ3ZXdaZUg3a0xJNEpJWnN5R09i?=
 =?utf-8?B?d2tjVE5RdTNBODdxRFovSi9pdU1iOTdiZytNMnVHaTR5Q0UyaXVjT2pHSGNZ?=
 =?utf-8?B?b3g5S3FnV0NzRlk2dlJrZGdhU3EralBVdm90T0hyQjF0UXF3WHRoNmJ2TmN5?=
 =?utf-8?B?T21udllBRTFVVlJxcmVscWltcktsR3hWa253UzRUL3dCK3NKVUxzMWpqOHZ0?=
 =?utf-8?B?c1ZRTjBIekJVZ2J5MXQwR0N0dFIxcnVDbjBXdFU0S2NvSEo1QWNJdDNWOFdk?=
 =?utf-8?B?emdKOFZxdVkzVHl2YTlMOCtBSkJRRmV0Q3JBOGVXT1lrc05UbUlPYlptcmlO?=
 =?utf-8?B?SWFkQ3Y1R0FKWjZBb0VPSEo0VTNvTEV3bUY5T0FLNnh6UTh1RW5sclVCM0pw?=
 =?utf-8?B?cHZDSWJzK1dPMHdtWHRJV2xmYTJmMjRJaDhkWUFCd3FRTTdSOTU4OEN6QU5D?=
 =?utf-8?B?MUVaTVN0YWRGUnV5cVduN3QzRkViL2Rwa2VnK0dvanFWUEpWMmN4NmFBOFRL?=
 =?utf-8?B?MW9yaU5SRmtSTkhmZXR6YW9nc3hWZ2N5NkFHbGJkQk56MXdxbjlKRzFwNzV0?=
 =?utf-8?B?d1BiaEhwY09LVi95YklWb1JGYnBOWnkzU1BJclIvMWhwcFRQQWdHeXR5ZUUx?=
 =?utf-8?B?cndQTFhDemNMVW05UTd4aTd6Q0tSalJvb3Vub09tdzZPM09DZFVQbUVpZUQw?=
 =?utf-8?B?M2orVUh0ZjJBRmQ2RFMvbkUzQkNkZEJma1k2dElBcDlHL3hsYUlwMEhBMWIy?=
 =?utf-8?B?V3dMQWpmdW9KeTFCNTR5NHNIcTB5amxkckZUQ1RVcExSVnBqQjFvZXdNdDBR?=
 =?utf-8?B?cVIxV01vTVlYNVRLL2xPK3c0dFpaVGVVcytFcytKVVFaczB5R2g1bmc4RW9F?=
 =?utf-8?B?SC9JSnh1YkRCbFFIN2ViRUgzazVkM3RkaE41VnRKZXdldGVCOG5YTkx1b05F?=
 =?utf-8?B?ZDYyQVZqNU9KNDd0V0k3NG9KMWdFcSthMUMwN1hXeTc4SDAvQVdSTnhtWlJG?=
 =?utf-8?B?NTRGbzQ4d1VuMmhHc3B3TWdueEZnQUVBSXYxTUh5OFBwYVoremxLRlZ3QlA1?=
 =?utf-8?B?Rkk4TG9WdnkveVpBcEFpVW1jZkF2M0J4VnVoSjFUSUpuK3l6V09aUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a235f7-9742-46e7-6ccc-08deafd3a702
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 03:07:51.0016 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X2s0aQE90m7pnNv6FNg9/fQack2QxXyaTWDhHQ38MtaDJTU1be94WMRvglRU4dW6sR8mFFGhtPjn1O/e/vYz1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11271
X-Mailman-Approved-At: Tue, 12 May 2026 06:40:14 +0200
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

CI: https://github.com/u-boot/u-boot/pull/967/checks

The watchdog DT changes have already been posted to the upstream Linux
kernel, addressing the concern about avoiding unnecessary growth of
u-boot.dtsi. Linux DT changes are available at:
https://lore.kernel.org/all/20260512024850.904551-1-alice.guo@oss.nxp.com/T/#u

Changes for v2:
- Iterate all watchdog nodes in device tree instead of wdog alias
- Delete non-DM implementation of the ULP watchdog driver

Changes for v3:
- Convert imx7ulp, imx91, imx93-frdm and imx93_var_som to CONFIG_OF_UPSTREAM

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (9):
      imx7ulp: Switch to OF_UPSTREAM
      imx91: Switch to OF_UPSTREAM
      imx93-frdm: Switch to OF_UPSTREAM
      imx93_var_som: Switch to OF_UPSTREAM
      imx: soc: Get watchdog base addresses from device tree
      arm: dts: imx: Update watchdog nodes for dynamic base address lookup
      watchdog: ulp_wdog: Use driver model for reset_cpu()
      arm: dts: imx: Enable watchdog driver model support
      imx: Remove hardcoded watchdog base address macros

 arch/arm/dts/Makefile                            |   4 -
 arch/arm/dts/imx7ulp-com-u-boot.dtsi             |   2 +
 arch/arm/dts/imx7ulp-com.dts                     |  79 --
 arch/arm/dts/imx7ulp-evk-u-boot.dtsi             |   6 +
 arch/arm/dts/imx7ulp-evk.dts                     | 133 ----
 arch/arm/dts/imx7ulp-u-boot.dtsi                 |  17 +
 arch/arm/dts/imx7ulp.dtsi                        | 461 ------------
 arch/arm/dts/imx8ulp-evk-u-boot.dtsi             |   4 -
 arch/arm/dts/imx8ulp-u-boot.dtsi                 |   4 +
 arch/arm/dts/imx91-11x11-evk.dts                 | 875 ----------------------
 arch/arm/dts/imx91-11x11-frdm.dts                | 773 -------------------
 arch/arm/dts/imx91-pinfunc.h                     | 770 -------------------
 arch/arm/dts/imx91-u-boot.dtsi                   |  12 +
 arch/arm/dts/imx91.dtsi                          |  53 --
 arch/arm/dts/imx93-11x11-frdm.dts                | 603 ---------------
 arch/arm/dts/imx93-u-boot.dtsi                   |  12 +
 arch/arm/dts/imx93-var-som-symphony.dts          | 323 --------
 arch/arm/dts/imx93-var-som.dtsi                  | 111 ---
 arch/arm/dts/imx93.dtsi                          | 906 -----------------------
 arch/arm/dts/imx943-evk-u-boot.dtsi              |   4 -
 arch/arm/dts/imx943-u-boot.dtsi                  |  19 +
 arch/arm/dts/imx95-15x15-evk-u-boot.dtsi         |   4 -
 arch/arm/dts/imx95-19x19-evk-u-boot.dtsi         |   4 -
 arch/arm/dts/imx95-toradex-smarc-dev-u-boot.dtsi |   4 -
 arch/arm/dts/imx95-u-boot.dtsi                   |  14 +
 arch/arm/dts/imx95-verdin-wifi-dev-u-boot.dtsi   |   4 -
 arch/arm/dts/imx952-u-boot.dtsi                  |  14 +
 arch/arm/include/asm/arch-imx8ulp/imx-regs.h     |   2 -
 arch/arm/include/asm/arch-imx9/imx-regs.h        |   9 -
 arch/arm/mach-imx/imx8ulp/soc.c                  |  14 +-
 arch/arm/mach-imx/imx9/Kconfig                   |   4 +
 arch/arm/mach-imx/imx9/scmi/soc.c                |  15 +-
 arch/arm/mach-imx/imx9/soc.c                     |  16 +-
 arch/arm/mach-imx/mx7ulp/Kconfig                 |   2 +
 arch/arm/mach-imx/mx7ulp/soc.c                   |  24 +-
 configs/imx8ulp_evk_defconfig                    |   1 +
 configs/imx91_11x11_evk_defconfig                |   2 +-
 configs/imx91_11x11_evk_inline_ecc_defconfig     |   2 +-
 configs/imx91_11x11_frdm_defconfig               |   2 +-
 configs/imx93-phycore_defconfig                  |   1 +
 configs/imx93_frdm_defconfig                     |   2 +-
 configs/imx93_var_som_defconfig                  |   2 +-
 configs/imx943_evk_defconfig                     |   1 +
 configs/imx95_15x15_evk_defconfig                |   1 +
 configs/imx95_evk.config                         |   1 +
 configs/mx7ulp_com_defconfig                     |   3 +-
 configs/mx7ulp_evk_defconfig                     |   2 +-
 configs/mx7ulp_evk_plugin_defconfig              |   2 +-
 configs/toradex-smarc-imx95_defconfig            |   1 +
 configs/verdin-imx95_defconfig                   |   1 +
 drivers/watchdog/ulp_wdog.c                      |  79 +-
 include/configs/imx8ulp_evk.h                    |   2 -
 include/configs/imx91_evk.h                      |   2 -
 include/configs/imx91_frdm.h                     |   2 -
 include/configs/imx93_evk.h                      |   3 -
 include/configs/imx93_frdm.h                     |   3 -
 include/configs/imx93_qsb.h                      |   2 -
 include/configs/imx93_var_som.h                  |   3 -
 include/configs/imx94_evk.h                      |   3 -
 include/configs/imx95_evk.h                      |   2 -
 include/configs/kontron-osm-s-mx93.h             |   2 -
 include/configs/mx7ulp_com.h                     |   3 -
 include/configs/mx7ulp_evk.h                     |   3 -
 include/configs/phycore_imx91_93.h               |   3 -
 include/configs/toradex-smarc-imx95.h            |   2 -
 65 files changed, 206 insertions(+), 5233 deletions(-)
---
base-commit: 5732bd0f457b4c671e46574d64d4acb099c0f0a5
change-id: 20260512-wdt-dbbb375e9dba

Best regards,
--  
Alice Guo <alice.guo@nxp.com>

