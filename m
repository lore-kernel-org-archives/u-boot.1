Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC39C44536
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 23:52:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4D3A83AC5;
	Thu, 22 Jan 2026 00:51:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="i+LfKFDC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 890AD8313B; Thu, 22 Jan 2026 00:51:42 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A407F83B7E
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 00:51:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lg0EkZExqgQWH+kh2/LCct5Oo0f8A4mzUGT6+gMNVxvaK9B9YtaDSgMF1Jd1xT4UpgVfD7/rijtOHQbe1lGN1nQztVSJXLTM/M0bvnYRsx8Voz8Xi8iiD8RW0myPCOjFBA5xYOYqPM3g0ocwgehGMsj9mMT6d8tc7tAtDnLGFlrY3hemjRUmjxu6RzRcWLcS6g0Q4/GI465xOdVTKzKlYgs9ju4vdbiDXjUPxNfTILmmyQxeSAXvFg+hTmZ+QK5uZY5LU5ILDbqCKG5Eg6KUgBSisv3ldQ7vUEgW/l3sV31t1/OX9YX9dnSkb5CgDF8LopSyLhGL55i+Eqh75C/6yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0QdSaK//IKWm1Q+XCwKynkV+/6wEGqtgwZVwkS97EE=;
 b=w8MZgYpKrxSDKByfX9oquzR2aqgjNpCQzZVRgqIXX1u31slDHs0oyd+mOk6AlEsO1IQmmw4v6xBGIFgQzGSR7kbt+EqG+gqzfXp2dLz8t00lhqa3DQ8Ko1Oqj+5rNKL96Cn+XEOZmDLy3H0V2zlgLRRirvXjLM0GcR3NseWYlKV+MTqTsu7gOHqWKdEvYRla+9aZbJIbjz0RapuCg4gJ4vA+VYNVzpqYJjHX7aiWS2Ej7GGkAUrxqOeuD9xvjcW4J7hqVmE2112nfllFWUfiI9k/6zZ37A82RUssccudZk4ll5Xf7j4EOj9xO8Y7hmw4X0EUHW+fc96V1pNoNv7vEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0QdSaK//IKWm1Q+XCwKynkV+/6wEGqtgwZVwkS97EE=;
 b=i+LfKFDCUgBx6QjK8kvYMBnKx/6dNkiqdJbyrOCEtNnUfwkEEEGPA0HjQ769wbeY0Ckw0lBUrnaXP/jOivLHJHRPrVuMVCAPM0yKEETvVd/6ckeYaJihR+xIYpUx/4HFkA4RunGaucSK+pyxBF9heBcvyL7CssZa5lg6mZlGn592BVwypfqpA9v+cJX9jXqBZ4GNVz4euuATZbBM0QVxTcD8h6Blf2smooSS2Fp56ZXiNAmTvrFjE5pACP7fbts9P6Lib2Gs1m2+72msB2mbu/xl5/I5W1HNgxman94FinmTwckpL56MyCtkLpo6+6c0r3REIO2CpWGYIvFOxNJmOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB7090.eurprd04.prod.outlook.com (2603:10a6:208:19e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 23:51:39 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9542.009; Wed, 21 Jan 2026
 23:51:39 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 22 Jan 2026 09:05:48 +0800
Subject: [PATCH 05/12] imx8mn_evk: spl: Drop DECLARE_GLOBAL_DATA_PTR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-imx-clean-v1-v1-5-a52a94b7e173@nxp.com>
References: <20260122-imx-clean-v1-v1-0-a52a94b7e173@nxp.com>
In-Reply-To: <20260122-imx-clean-v1-v1-0-a52a94b7e173@nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:195::17) To PAWSPRMB0023.eurprd04.prod.outlook.com
 (2603:10a6:102:37e::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM0PR04MB7090:EE_
X-MS-Office365-Filtering-Correlation-Id: 74aac9e8-685d-474c-3005-08de594803ec
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVpTK1F2Yy9RNG9PNTM1VjdqNVBDbWRaWDY3QmxSOTRES3doSkdUSDJGQXpG?=
 =?utf-8?B?ZG1UL0RpSlcxM0Mwc24wMzI3SFZWT0lTVUVTZU1jYTB3R21OV2hLdnZRVGpt?=
 =?utf-8?B?a0VTU21nNjhsL1o3MjFKWmRQeEF4V2tmZVdxNHlpOTBnd3VsaGFIVXZPZGYw?=
 =?utf-8?B?a0lQYzdkbjdZZ2x4cllXeEpBMTNJdTVZUTJkR2pza2txckttb2ZXQWc1TTJy?=
 =?utf-8?B?KzlCNWFFNmgrWlZrb01xazRpVFo5S0ZwRGhRd0FjN1NDNjJZRTEwUkEwdFp2?=
 =?utf-8?B?OW5yWnNBUG9TNzZoM0pEWDkzWGRIZnNORFU1dkkvbDIwT0p0Sm5tSzdyUnps?=
 =?utf-8?B?YXNzYVQzcmNmL1ZqS1N5MENBNlQzaG1YdlIvVCswUDNPcm03ODhyM2EwOE1N?=
 =?utf-8?B?UjNEcmpjZDZBcU5sV0lTRjAvQTFhWnZtN2UxZEpLdW5lQS9naW5nNkpnT05R?=
 =?utf-8?B?ejJzckZnRUUzdXVTRHpGUThUN3VIdkF3cjNHZ28ycVA1cENCSTVqVEhKTFE4?=
 =?utf-8?B?WHg0RnhSVFowdml6YjVrWWRHR1J6ZFNUZFFKalJHYzNOYUxnWXFEMjRuampN?=
 =?utf-8?B?T1oxeXByTTlsbHBqV2pBdmRLMHNMNnR3eHBTbEd4bmczSk9Dbnp5c2dRNHBV?=
 =?utf-8?B?ZVFyNlFSQ0E1RHUxQXhjUkpNVVpGbWI0VVFKODZMeU9TRUJiOU9jbWdNWmpR?=
 =?utf-8?B?U01EaDNZcUpyUjVRZFJVbnJpRGJ0NER6dXZXeG1ZNDhNMkM4T21NZ1hxQUt3?=
 =?utf-8?B?ZS9XUExIcUtWWWtvNzBmUmpMM1Y1NEY0S25YOVltVy9GRHBON3UxOVk2Y0NF?=
 =?utf-8?B?NGwxUmpQRExLaUZBWHltdXJNRWJ1YlRFRm1uRG1FdnNVOWRBbHlTTFZQOUo4?=
 =?utf-8?B?UjVVcit3bzBOSnBYNEQxS2xmQW83SVprMG9JZ2dnK2RCQTIwaC9ENGJnbDhy?=
 =?utf-8?B?Y3VOSFcxS1dxYm9aT202TkZ2US9BT2tzWkk1eS9QN1lwZ2Z4Q29DbXpjcDRu?=
 =?utf-8?B?M2JzVDdiVmtzWUw5dHdBMk9oSENtV2tjREd6blhBWEUrejVEakh3Q1p4NWVC?=
 =?utf-8?B?Wkp4Z1JjbGRRZE11SG1hMGpoK0JWOW11RmR0aUkxRlFXU05qV0FycW95bTdI?=
 =?utf-8?B?WEY2T1VSWnRkanNoejVhdE83THdSMThtK1l3dnJyRWVDeGFxbmI3Nm5ZcU9T?=
 =?utf-8?B?NFZqam9aZWFKWXkyZXYxd0NyUDdicktmeGR2Q3RhY1F3RUxORkJCWG90WHd3?=
 =?utf-8?B?S3NLQTMyS3FTdmhPdi9FaVFJeFNJS0RVczBPblpUbUp3Szl1VnM0RUg1MmNZ?=
 =?utf-8?B?Rno2VXI3MkJLa3dwZUpvZXc4VUx3ay9WWE9rSkMxT2xhdGxsa25tRnB5bFc0?=
 =?utf-8?B?c2lNdG03N1FDOGZkRlVyaWU4ZzJKUGhTVXV1cWJQaXV6c21ncU1TdFZZN21Z?=
 =?utf-8?B?cURFeThyeTIwUlQ0OUdpRFd3T0FTTWdUd3pKcTl6WDlEVFlaK1FjYW1Jamxk?=
 =?utf-8?B?QkRMWHNsOHMrMmh2NTJkUjJGZVVISXM1NmkwYzA0Y24rbkcwSGtCSDBQais4?=
 =?utf-8?B?N0twcjR6SW5pcWZBa3oyQW5nN3RRMlk5MmxIRHhvZnlxQlZpbzZtenJLUVgx?=
 =?utf-8?B?Y0JjN0R0OUFOc3RpUnd4M1NWVzdhSG5Ra3J4ajA2Z0RiankreFh4TDR2NlJa?=
 =?utf-8?B?L2V4QUNwVkhPRTNnUmJkUXYvUjJ3UFdTS3g5aUZFV0JGSXJRWTNwOTFaODRV?=
 =?utf-8?B?QlFvN2pZNmwvd0tzOWk1R0MxbDJWMTBBaVJtTERXRmNINVY0WXppWkZqV0Jw?=
 =?utf-8?B?bkR0cEFPQmZIWktIRGtQYXZiYUczN2VhUVYrMHhiSGROZWdzclZSZFBkUVNP?=
 =?utf-8?B?WEEyZXJTcjZjZFhSUXJxRk8rM1B2QVEvSSs3bnZzbkxUVjRPdUgyVi9tRjk4?=
 =?utf-8?B?dnZaV0Rzby9pb2xMQ243YnVlUzZEeXRrZTBiMGZKN3d5d2pPbjlHdDNVaHF0?=
 =?utf-8?B?R2RMWHBFNnVIcTc0R3liNXZWd3VPQVVxaFVMZFZxUTBwRmN3UjZyNElPN1lu?=
 =?utf-8?B?WXhtWFJkNHpMU05VNWswVWk5NER1b0wyNnR1alRpVklkNkMvYnh3VHYrNEFZ?=
 =?utf-8?B?Ulh0MHd3VSt1UTJsYmpIdDdHczR3RHNWdUNVb01MMjV4eEZLbG8xeHUyQVd5?=
 =?utf-8?Q?eOGBIlCJHUMg2aQdgfEtet4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(52116014)(376014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlFEbEs3RjVxUzd6eDF0RjFNNkxlTmpwS0VTdnArdEQ5VEI1QWplK2dHYkpE?=
 =?utf-8?B?TEU2UlU2UWRwRTZZTm5BTE1TNC9XWmkrNU1EUHlTSFgyM0VtdTdPd3lPaHc1?=
 =?utf-8?B?WExvWWdaVHk4OFNjcWdZd1dnNTJjNWJEV3F6SGo2Q0Z4Wk5TcTNYSlB3L0dx?=
 =?utf-8?B?Qkp0U24vT1g5YndVU3ozMEt6eXhvZHZLd016VnJXZEd2Y1NCb3BvYk9GOFJQ?=
 =?utf-8?B?WEdmalNsYnQvdlkyRVpNdlZGaGZFWVRTaWZZYzVFUFk0L3RRVCtRWDFaeGYr?=
 =?utf-8?B?K1VuVkpNZXFpMkpuVEpwN0NHV1hodTVPdm5ZWVprR1hTYzBWSGhCV2x2SHhp?=
 =?utf-8?B?S0I0T2NqYUxabHVLa2ZaNlMydnpLK2RyL2ZETXdlZDhScUg3WjRlY3gwVDk5?=
 =?utf-8?B?Y2tJUHNMREQ2MWlaK3pHOG9UV3Uxdk9TWG90Zk1DdldZd295R2g4cTF3dGRO?=
 =?utf-8?B?a3ZXSVY0cGNjQTJBN0tES2Z2MkN5dlFrNjZzYXFpeTY1OVFmd2IxaWFhZHo2?=
 =?utf-8?B?ZjlkWUU1N0Y4NWluS1FQc3lIOE5YaGk3L2RnbStzdlhHWjViNENoc2dQYzZF?=
 =?utf-8?B?RmZBdTVWeW4zTlVEekphN3R0YUJRMVJCcnpGOWsxRzJDWkxjUThIc080WmVo?=
 =?utf-8?B?U2hvTGhFNFdLTUdtYVExVEhrRmdzZDVQa3Flams0UWVIclJXYmdQS3JWMG95?=
 =?utf-8?B?VjUyd1FCOHRoK3BiOTNmUEdkMnBzVFFXbHU2N3lyT1Qxc2hvcno2WTdZdC9N?=
 =?utf-8?B?VkIzeVFvWFppZUZxSXpnemQ0b3Yza1ZpZDhITnM5QlRHbW1TTitXM0JjTEZz?=
 =?utf-8?B?MkZsSmVHcjZSa29yMHVlb1RjZTU3eXZYazlNdDg3VWwxSnhkMk9ob0xCQnU0?=
 =?utf-8?B?UTNER1ZVR3NVL1JxUVBhUlRuaUhjSnNuNmZvR2hZdk0xazIwdldaM1YrdEhP?=
 =?utf-8?B?Vk1HWnVsem8vMmFFNVlIb1VOMldCeHUyVWFMd2RWMXMvVXI2UTFVam5aV3NO?=
 =?utf-8?B?VlVmcDN0NFJUdFltTXNVNXpkRmIzempqSmg3VUpRMzk4VFhSQkdockd6TjY0?=
 =?utf-8?B?Y3hNS29mNGJoWVFZUGxtS0k4MCtLcGJseHlHbEZPT0piQm4xcC9IVk5IZVo4?=
 =?utf-8?B?L29KQjhic2V1RCtQbjFJcWZRRXNpNktpMElTclQzWmltQVRSYXdJSlFnc01S?=
 =?utf-8?B?WXRGMVRlanE2d2ZuazZpTTZ1MFQ4dzJXVVlXQXRMbjZEaW5TZDNHRkZScVBp?=
 =?utf-8?B?YlhsK0dCWFZ0SjZTNTZGamZFUytvam94RnMxd2puZWZaMUhWK3lpS0ZhUmhV?=
 =?utf-8?B?MFRla3hxQWROeG1Fcy9yK0lzejQ4Ukd4NmpGREIrM1M4V3lXanhRdDhOWGRH?=
 =?utf-8?B?UVlNajJCbE40YlJyS2p4aTB3VHRmTXFaQnlDS3NpektlMUhjemdrQW9qd0Y0?=
 =?utf-8?B?aFhTRU1WajA0TnM2U0s0WWVJNkZsQW03K1hhNDQ1TDlvdEhqdy9iaUZVVWNu?=
 =?utf-8?B?M1FYL2FRL1BrU2MxZlZ1L1lrZFFvclg2dEovQzBTSjZMblFmQWk1Mjg3UVVZ?=
 =?utf-8?B?b0FJbUEyRUFZOStZdW9qeHFWbm1zcGhyOVExQU5CZTZMZjZpOVFjK0RhdHRu?=
 =?utf-8?B?aTZkcGJLRVRuaFFzZTZQU0gyOXRuTDA1bTFHNXR0czZGL2FKeDRnNDVJMUdk?=
 =?utf-8?B?cFhoZWJmM3pZb1hDVzQrenR5THRsRzluREx4SzJYZnVvdjBuQTVmZzVDUmRl?=
 =?utf-8?B?ZXlzYnRlNlNqMjRLUmpab0o3dWVzSFBsTEtvL2s4NTdCYjVEUW5Qa29DbkNv?=
 =?utf-8?B?aXpPRlp0dkxwT2J3a3hLL25veS91V0cvbHA4NnA0TVpyQm9zMDk0bklONDRI?=
 =?utf-8?B?ZHAzZFBDT1lXd2llS0pxR0VodEJwV1ZtYVJtbE1yLzRVN0RzN2x4MUtweTlm?=
 =?utf-8?B?RC85djYyTWRwYWsyVm9FdFd6d01Vei90MXN0VVNsYTg5QnFtY21Jd3M4QlJo?=
 =?utf-8?B?Sy8zRzlTdk5GYkVIYnVCeWZudnQwRnZpSFB1bURkOU9TT1p0L3RFMVdlSlov?=
 =?utf-8?B?RHk1eFB6N0VHL0pIcW9DOTBZdk1YSDU0UkhPc2xOVjZDd2xnTWVabTluak95?=
 =?utf-8?B?WVNCL2dlT28wUHlIa2JrVVR6eksvUHJmQm1ORFBFdXRIMWFHK0JETnNsMDE3?=
 =?utf-8?B?WnRJeitEazBwaVNPYXV2OEhDNEdCUjllRXZLWDZyK3N2MThHcnBwdzc5TUls?=
 =?utf-8?B?eVF1M0l1KzZaSFpURzBrNnkvZE0rc1QzWERSSTZ2U0p1WHJJTzZWUmlmcjNj?=
 =?utf-8?B?ZXNBUGJkdFdFblIvbU1ROVV3dVgxbUVZcHJyZ1JQcFFnV0duV2kwdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74aac9e8-685d-474c-3005-08de594803ec
X-MS-Exchange-CrossTenant-AuthSource: PAWSPRMB0023.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 23:51:39.0117 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dc5rF65xPTAWyLqAUEK1xWTK5fNnTSdDraP+Mm0wMn3m1SuOKIQiefmu0Su2ZeeaeFNnDttsyP0PERCI5/oXTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7090
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

There is no user of "gd", so drop DECLARE_GLOBAL_DATA_PTR.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx8mn_evk/spl.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/board/freescale/imx8mn_evk/spl.c b/board/freescale/imx8mn_evk/spl.c
index f96f5c45789..6554d445a59 100644
--- a/board/freescale/imx8mn_evk/spl.c
+++ b/board/freescale/imx8mn_evk/spl.c
@@ -11,7 +11,6 @@
 #include <init.h>
 #include <log.h>
 #include <spl.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/mach-imx/iomux-v3.h>
 #include <asm/arch/clock.h>
@@ -32,8 +31,6 @@
 #include <fsl_esdhc_imx.h>
 #include <mmc.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 int spl_board_boot_device(enum boot_device boot_dev_spl)
 {
 	return BOOT_DEVICE_BOOTROM;

-- 
2.51.0

