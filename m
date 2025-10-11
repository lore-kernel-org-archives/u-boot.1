Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710CACCD184
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 18:07:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B99783A8C;
	Sat, 11 Oct 2025 20:07:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="boF3JEw1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00F2C83CF7; Sat, 11 Oct 2025 11:08:33 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D2CC83C2B
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 11:08:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GmdpB0OBKiE2DSSAc56L5+2kTAUB6hGGgItuYvNtTy9+ij+3pZl9u73z47RS3EoabGOYoEOhUgynaahrDGdaHhVwtn0wpQcDWPnjNugfnzZmNt3o0j3pQ14WA5nUFbbQxkvAgd1tAaZnqJqahZbylirYx0dfDKLZRy5Zr6poIeGojv687Vx5+LTSgJgM+zUwNQ+YkKtqWBxTIvevFNFyAHRvdEz/bJBEBcRRC2mxUwj37TajP2f8BxaH3kL3SWc4COM/hgb8ko3jsXZAFBPjmUq8ModtzTGrYXuFgCla4xp8sD8jK3vWI9nHoWFTpYuh36FD9OteUHfmJyal4+BYwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJbPYy8lnKBHXY4B/aNu6tRZLnXiV6Q7vW0Y26TSNQM=;
 b=soX8qnmtynSoLcadX8ii3eNHLmrro9GA8toafH3GEKTWnBDr9gv3yW8BWhmEy3q/jDfeZLJCTaK/Cb8i+VBCw94nB1Tp0DdkugN7a6a9l+3M1soUW7hsl1NA9Vnz5JgWaETr7ko+E0LFxBnviCv6yIj2STht60isOWMSsDc6/3uLjaWETYtxZ8FQ+5Dr5Uv9BVS3GDl3KuAAJW2Bht2a+Z53Oa2nohsvFac2G4552xEuy4ForNL2hMCUq9XBeUvxdtDd/ieLSte/tTHoj7yzN4P6TUTFz2ql44diBDQ0oOQ8Apjy32VucXfu48q6hnia1qfm/7+SnY/c+xzDeLr6Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJbPYy8lnKBHXY4B/aNu6tRZLnXiV6Q7vW0Y26TSNQM=;
 b=boF3JEw1g9Lyl7p2o9Vdav1jBWvmWxFNL9az8XO+RKtWH5R3z3PP7kikkLNXp9lfJjVlVPGFIxTOwFRQPHjxsB/StSjsdKUcw/IsgG5C4/oOYwtQ29rDWxl2q2grYjZWy0Wg/Dky+K4/mR9dmuBPPF2xb0vwO5Fdsrnl2uuUF4gQEYyY02KxwiV/WMnMrGNanJsD40ld3bz8FCh1HA4uLb87hNXayVq9RB/ScewsGmGBQWejXC8yquuvX6jfPF2jn5/ujAjiSkslnBSBMkoVY0GciVoC+0eMbMpCc94zaEJQOwFhGj0MGlBCaUB3LB6FrKaqWV9Qmoy40AZXDrdNFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU6PR04MB11160.eurprd04.prod.outlook.com (2603:10a6:10:5c3::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Sat, 11 Oct
 2025 09:08:29 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9203.007; Sat, 11 Oct 2025
 09:08:29 +0000
From: Alice Guo <alice.guo@nxp.com>
Date: Sat, 11 Oct 2025 17:07:48 +0800
Subject: [PATCH v2 01/10] usb: ehci-mx6: Extend support to i.MX91, i.MX93,
 i.MX94, and i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251011-imx943-v1-1-313444548ab3@oss.nxp.com>
References: <20251011-imx943-v1-0-313444548ab3@oss.nxp.com>
In-Reply-To: <20251011-imx943-v1-0-313444548ab3@oss.nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 marek.vasut@mailbox.org
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alice Guo <alice.guo@nxp.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>, Jindong Yue <jindong.yue@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Minkyu Kang <mk7.kang@samsung.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Roger Quadros <rogerq@kernel.org>, Tim Harvey <tharvey@gateworks.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Hanyuan Zhao <hanyuan-z@qq.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::8) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU6PR04MB11160:EE_
X-MS-Office365-Filtering-Correlation-Id: 3897a520-0b84-4d60-96ed-08de08a5be72
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VmpKeEZrU1NLd3hpZ256TVQ5QjZkYkplcDl1SDJOL1M2VnJUa2dsc3ZUeWhq?=
 =?utf-8?B?S3VpVkdtaitQdCswb1lMY0ZISUhrQ1VZUk1GL3ZvUkU3QnNTT3pFaC8yNExC?=
 =?utf-8?B?RTNhbEluTW1vb09TaGhkSUJxNXZZcDJ3YzBraFMrQ2xwRGFFOWlDZ0V4VndN?=
 =?utf-8?B?RENEN2x6S2NrdUJjSno3QXVGRGYydThqdnYrMklxVVNISmlYT0hwc2VnVEJ6?=
 =?utf-8?B?V0ozM0hHeUhaZEtDUUJmVmZmdWcybWwvZnE2dGRqTE1JcVREa3A4UlZBOFVH?=
 =?utf-8?B?RkVEd0kydHh5ejJqNDh3aUZrcDl6bzB2RVljeDhiNUJrc0dWek80dGxoWjY3?=
 =?utf-8?B?ZXB1RVhaK1hjcEcrOXAwdWFpVG0vckFaZ21lZ29NNlZMellucWJaYm9wZWNh?=
 =?utf-8?B?elJCcXhkL3JCcVVyNEo5T0xLQVdNN3U5R1pYL3VUQjArY2NIdWdXdW9aZWJP?=
 =?utf-8?B?em45WFkzYlBweE5jdzEwVHRtbFRmL08ybHBGL2lUNnFFZFBVRGhFeXZweTht?=
 =?utf-8?B?ak1QUytZNHI1RGR5c0UyK2pYcWlpOXJtUDNsamRUcytBTEYwbFFxQWJ0OGdV?=
 =?utf-8?B?c0JhdDJxK2RsRWQyTEdPNU9Nd3RIOVAwaTRZZkVjOVdZbFNhK0FITEtacXhq?=
 =?utf-8?B?ZkhUSUxaL0theVhsZ3VlandNS3NMcUJlUE5EZ0JkTFcwVkIrMFZ4SFZCQUkx?=
 =?utf-8?B?QVJqbTNJeHRpVFczVi9teC9UbGlFU3VCNHI3S2tyckh6bGRBWGZEY3p1bHh1?=
 =?utf-8?B?Q0htL1dic1E4OUpYczhjVVNlKzNFeXEvZE5tWFZGaDA3dHczQk9tK0VrU0p6?=
 =?utf-8?B?SEt1Q1NwZjh2MEpRUHhVMG9KVEp2K0VSVFpLQnZUbTFYakhxS2ZlQjNUWCtn?=
 =?utf-8?B?cFVZbENGVXpKQ1c4Z0lDMFJKczg1RjZHU3lyRmhQSFRCNGVVL2ZOSkhYLzUv?=
 =?utf-8?B?Y3lJazVWNndEQis2Nmo4VS9OaWhoRkVtYXJQa3V3SEJnOGIzc2h1R3NYSnRY?=
 =?utf-8?B?R09uZGxlZ0NKNTJrcWRYdjBLSmlIaVFueURvMkVGRTd3c0hBSDA2NVFLeVho?=
 =?utf-8?B?a1lkWFM0MHUxcVExTUg2NVJqRThqSmdxOUpNTUlncWRobHZKL0wzQ3k3M0xO?=
 =?utf-8?B?cHlGL0VYbUV3SDlnckp0aTliOWcxQUQyRUdrYnVLY1RFYW5wazd5R0tPMUpP?=
 =?utf-8?B?bVVHMCtDaFkvUTl2U1ExQ1NvbWttUmN1T0l4dlpOeFU2Mzc5ak5Ycm4zeDVH?=
 =?utf-8?B?V2hoaEU5SnN2Nm9OeTdzc3VVN3g2Z1A3WUVkMGMzSUZlUkdLaExVRUkzazZv?=
 =?utf-8?B?UEZZb3hqOFRHQ2ZIdEJkMkJYRGpIa2lSd2M5d01IVkhURjU3NkVHS2tzWFQv?=
 =?utf-8?B?M3M0ZTNwdlNtbjZaTjRkOGdjMk9NZGhvZnp6aG9ha0E0aGFYN3JYZVBsZXlY?=
 =?utf-8?B?aWUvdDdnOEZBeTJkTDJiTnNqMHhjUkUxLzNsMiszTkI3QTVtYjRQa3Noay9k?=
 =?utf-8?B?NEkvdXZ0U3dqb2kvdldXdkpZQ2E0MEVrdk4vYzhtOXU1SGcvWVhwaWlZMEVG?=
 =?utf-8?B?TGdicy9FaXAwSkxWQjhDc0pqWkR6Q2MvbVZjNE1CeFp6bFBVWUdBOENNOTB0?=
 =?utf-8?B?Y3pHTWFvRnc2TzhWTTF5aERhNUpscUVmRm1zNXNscWl2SU1oMVdhWi9ZN3hS?=
 =?utf-8?B?MzM5VEdBS3FySC9hOXllczhXSkdlc1hIU3l6T0hpV1I2cTE0VWlHTEp3YmMw?=
 =?utf-8?B?SFNSd0JMZGU2M2h5aXk1bmVZRnFBZTB5RWRDRGZxWGJQeWt3Z2NWUzFOeXJT?=
 =?utf-8?B?ZEhqTGxmREFWb2lwdU02UzJ6VzRRM3RXZ0JjWmo1NWN1dm91MDlkeXN6NTBM?=
 =?utf-8?B?M1JBM0ZuWjNabThaTnJqRVNMaHI5a3k2K0dYNWw0M3NrKytBSkcwZk9SWWwr?=
 =?utf-8?B?b3I0ZVBnK3B6aHJSa1FRSDQvZmFSNlArcnFnRW9RSkVJa1V5VGJsNWtkRVVQ?=
 =?utf-8?B?TjE5M0lkQ2RBb3BBZGpKQ1dmSWRGWTY2V3JQVnpRRHJ6Q1V3Y09RRkt1UjB2?=
 =?utf-8?Q?GV/Htx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(52116014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SitUR0EzOVp4RTJGV3hEVlhrWWdiOG4vd2RJV3lQajFKVTM4NitmYVg1VWQx?=
 =?utf-8?B?RDZpZ3FvR0NmZ01jYkhBSXZEN0M3RzlQbmFranlXcit5MVBrZW9PeW9CMlcv?=
 =?utf-8?B?N0xBdVFBUHNUUlpENU9GbWpDMjIyR3M2c1VOY3VEZnNJTWxwVUZMWllxRmlT?=
 =?utf-8?B?T1hNaXZIYmxGTDhPb3IyUGlYaHNjbG5NK3JzY0I4ZHNHaFh4Yk44MFRUajBy?=
 =?utf-8?B?WWZoNWlCdUVTTG5PRklablJDMFkwcTNXZ1c4T2FoTUhsaFFPbm1oZUg0WDVN?=
 =?utf-8?B?ZUx6T2xkV1pjYy9uSHcxRWRNb3Y4SGN1aU5GZ3BPMDM4ZEdUby9qWHhydXBk?=
 =?utf-8?B?dWtKa2Z1aFEwN1ZDZm5hUnFvZU1LM2JxNm5TVlRvMVFjbnBHK0phdFVtbDIv?=
 =?utf-8?B?QkNNUVdBMm14OHJDK2FHbGxoc0ZSRDBaTWw0VkIzaTFtYURmMkE1cXpQT0Ro?=
 =?utf-8?B?eHVKcFYyZDRxSDRpK084YXNyZThTa0ZwRWRPOXpVY3dKcG93MTYybGhnMnlI?=
 =?utf-8?B?ZkxwRzk5aXM1TzFyOCt4Q1ZNSFdlSXQwbmpBTEJwVnFsbjY2bktHU3lIR2t4?=
 =?utf-8?B?SS9WSGtpQXo4Ulp3YVA3NXorTDhZVkViUkpML1A1SG44aHloYnBmZkxUS3ov?=
 =?utf-8?B?eWFSQVdxM2VSb2RTZ1puNVJLdDFCcHgxd2JzZndnd3N3QlBqb2VUQURHK0dZ?=
 =?utf-8?B?RllWaWljUmZBUGlNUmRVUnZNZCt2TUhocnpQckFBcUNyM1NyeWdldWNCdWEy?=
 =?utf-8?B?WFhTbEEwWTd5SEx2TVk5eUMwR1dHRDhha1llTlB0TkFzcVdrZVNuOUdWZ1FI?=
 =?utf-8?B?VEVIbG9xVGQwcVF5Z1Q4UmZzSkltR3d6OVZkT3JwYkhlRnJCQmZkRXJkYzZ6?=
 =?utf-8?B?S2laZU1VZGdZazZlb1o2SXF0cDYva3ozcERzWThDejhqYVBIYTljdWZibmdu?=
 =?utf-8?B?dEhLOElHLzVYN3FIakcrOVZZUkhUOURvcEZQa2Q5NzRhaTNsVVNYakhvQ1VN?=
 =?utf-8?B?c1h0Vk1ZY0xVTlh5RDNWNWp1WUM1b1dJNURKZHBtbHhYM1p1YXpsMXcybW52?=
 =?utf-8?B?QmI5eFVBSDJjSWh5SVQyM0JHeFhJYWRkMS84Z0pPb2l0UmZlM3VXUmtzQTgy?=
 =?utf-8?B?M3NBSWZxY2dBbU0xV3drNFRjc0VvR3MyNjd1SytSZUt4QU5EVnQ5TDFDOTIy?=
 =?utf-8?B?MElPZW4rMldSYjQ0NFpkY3FNcFAvWk9LU21YeGZlOEpicjAxbllXbnl5T3VU?=
 =?utf-8?B?OEpvdUJYd2RRVkhzZm1lTFlvdjc2WjR2YnBpbFdMQzBTNnR6OWxveWw0THNP?=
 =?utf-8?B?YitoeXF1YjNnTzlYaDZObzVEMEVMSWRSeVZMWkx5KzZFZ0dJN2JVMEhHdFpv?=
 =?utf-8?B?RjhDbWoxcHNFTlBvUnl6L2JjRlNPT0VBaUtZZTFuN1dqdFlKMktPQU5Pa2Z6?=
 =?utf-8?B?eEU1MVZqOGQ0eXRqb1lORStsOVVVMlVNdUVPM0oxMHZsMGoyN1lNaVl2T2dT?=
 =?utf-8?B?WDhEMUpob3BodXdicWpSYldBWjdRRjdObHovTnBRc3FqcThkSUszbkdkRElP?=
 =?utf-8?B?WlpmTHFBRjBBOURQM2tpSzd2QkZ5UlhocXBpRGJJRlNhbHlWSGZMWEp2bCsy?=
 =?utf-8?B?UnlWLzBPYXRkZUNXaDhBQUhJUDhTbktmWll1S0tRQ1k2cWJobjVTN05jOVBH?=
 =?utf-8?B?SUFKZ2ViWmYrSjVPT0I0Q1JYb3hpMkRaamtBRU1uMmh1bENwaFIxbXZCVHRi?=
 =?utf-8?B?WTNjcE9lNSsrRWhNZXA3WmZRZFJMQXdleUpaZjkwVG5Yd29pK1JDSWNqbFFh?=
 =?utf-8?B?VDhTRUJaejc2VWxNZDFJWkNtOVdHVTQ5S05FYkNtYi9sdjRzaVArcm5NUU9X?=
 =?utf-8?B?ZG5CdXNwOEVQY25qL01WdnU4WVd2VUVEbWpxSlFReFZFTmZpOEN0d2VnNlZR?=
 =?utf-8?B?elBXN1gyYVM4TnBtbGRWdVZld3V0WlQyZVJFaW5HSktlZlRFR0hQcGZzVVg5?=
 =?utf-8?B?Sko5Z1NWVjlka3l0RzUxdVJ2cEkzbXRPSmllb09mbEhJcy92bGVhelJJZndQ?=
 =?utf-8?B?T1M4NlFxc0JFKzZMdHlxbk9pK0xLTXlCYVBPMHArYWUyai91ZE1uVUhGMDVL?=
 =?utf-8?Q?lnRZzcpDWglgYJhu5j78pPSLy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3897a520-0b84-4d60-96ed-08de08a5be72
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 09:08:29.4425 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 44EGFXeXYO3cBJzV5ZQjTGq03l+tWVo5/GWk6PuVTnF2sC5vtoWQtWnHm51QDDlPBPUFLH/GjlhDr3VXEb+JEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11160
X-Mailman-Approved-At: Sat, 11 Oct 2025 20:06:59 +0200
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

Since the EHCI USB driver is shared across i.MX91, i.MX93, i.MX94, and
i.MX95, the condition check is updated to use IMX9.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
---
 drivers/usb/host/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 2cf687fc4f3..427b62e934b 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -210,10 +210,10 @@ config USB_EHCI_MX6
 
 config USB_EHCI_MX7
 	bool "Support for i.MX7/i.MX8M/i.MX9 on-chip EHCI USB controller"
-	depends on ARCH_MX7 || IMX8M || IMX93 || IMX95
+	depends on ARCH_MX7 || IMX8M || IMX9
 	select EHCI_HCD_INIT_AFTER_RESET if ARCH_MX7
-	select PHY if IMX8M || IMX93 || IMX95
-	select NOP_PHY if IMX8M || IMX93 || IMX95
+	select PHY if IMX8M || IMX9
+	select NOP_PHY if IMX8M || IMX9
 	default y
 	---help---
 	  Enables support for the on-chip EHCI controller on i.MX7/i.MX8M/i.MX9 SoCs.

-- 
2.43.0

