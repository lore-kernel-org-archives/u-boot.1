Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C45E6C35FF3
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 07:16:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9B0F8197D;
	Fri, 21 Mar 2025 08:16:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Vv30bjAh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9491F805C8; Fri, 21 Mar 2025 08:16:09 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 289138197D
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 08:16:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=is44VyEoNpC04iGQB3MHOc2YWhjLPn7uFPX+A7AarF5ST3T6n7mggs4WCRHfrhoQ5mt1LbUpYnwM6bYBX8neJXWKubhmqn9DvfT5kczSwUKhQu5piy/sCT2BAuoinkIZQfmT5tqyXQV7x7DtQXJejLATmi62nGdOI9JloXEBzi/NIDZLDizuaT2MYd8IYkbT3YbpHu9ZNA3KaxiIpKIpHGWSLP+3QdXaTtXzKaggtODG05DT0NVTucx5FXxyMdi2L+Teqx3hnVj/cvngBDUMD+Z2RIZ3/AncdeA/VqXzyat8tDFFVXmu0nsmVD9Q8dQt4XTqDtv1CaA9Cg6uagkFDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PE5IUtRr996sh2nPmoqWTtXbNFCNfa1ck318DeFOhpU=;
 b=GL5P+OboQ01yw5lu/DU5W0+ghzxR2WqH28iGfLA0K5yGdIsx2iVkWwDVo48r8eeT5syOZQcjO3VhPoyJYcVV6b91qSXuMNmHjxfDZfeg6mxtAdzeOkGstpRMP9FP4O1NijbTS73YtJzoKSWDwP/bhE+PDFUoRNJi7xyb9NAeJJO7rYScG4oz1KDLpbP1oMJ7d/eI49b4qCsy7Q4R39Rzw2WMOJ3tN/Y2HHoKLhBBqc1KRFf/+Yu2hs/k3UWi/mxh3juMZFKkRy5XG50wjSgbCUV+cXu2fFSZ+5sMP527zp1xNSJ6fmuGj+ELDy7D4pI3FTC/nEUN112cC8vNcSrKhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PE5IUtRr996sh2nPmoqWTtXbNFCNfa1ck318DeFOhpU=;
 b=Vv30bjAhCbiagCiXzBvV8nuytNsl06KbrCdBoqhcePc2fMWblo+DmMHHRFwdAEtGrZ/0Kbv+To/lbNgiBPJ9HS0ifBWiP5PxFH15/mqvKGHgdhf4qtfZ4b4XZlEcdkQ519qWIaNI8ox/Odp/WAg1q+CxMePtqph5bdyhhABfBS3bJppLs6J2k+loa/MSZ/EQvsPMwBlsORAs2YqxVDf4QuqOkv0f94nr6d5sgF+Zv25q6lqig0gVumz+h10ZA0EV1cLewsjJsL7o6KAi7aJ9fMntY79gSOrFv3DHq3wg+kqPMoTuiip/eOSGostPLZPCiDgQI4l8H3NEVgspIMjxSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM0PR04MB6836.eurprd04.prod.outlook.com (2603:10a6:208:187::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.37; Fri, 21 Mar
 2025 07:16:01 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 07:16:01 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Fri, 21 Mar 2025 15:15:16 +0800
Subject: [PATCH v8 02/19] pinctrl: nxp: add a pin controller driver based
 on SCMI pin control protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-imx95-v1-2-f2c8ba815f89@oss.nxp.com>
References: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
In-Reply-To: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marex@denx.de>, 
 =?utf-8?q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Cc: u-boot@lists.denx.de, 
 Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::6) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM0PR04MB6836:EE_
X-MS-Office365-Filtering-Correlation-Id: dbc1b930-01f2-46ea-a614-08dd68483c51
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MXJ3U2Nnamk3QmUvWVZZdzc1Z3hRT3JkTWphQmZEQTBOMllCcEJ0WGdKYzFH?=
 =?utf-8?B?RXI4aE5vazlHbGhuYW1ldmFja0c2UWVVbzhxS1lIVDdBYnB3ZExUanAvOUhX?=
 =?utf-8?B?cTVvTGVzSEFRYUZ2VFRkT2xYV25raEFaRHRaRDErMTBXTmRBMzE2LzhCZ2xL?=
 =?utf-8?B?bnJabnNxV3owUVFYOGkrd0JuSWgzcEtxVzNqbnVodnFaVUZEOVJZdTlnWFcv?=
 =?utf-8?B?ZGt6bmdVbDlGRFZmb1MxS0tZSVpET0lQc0JUZkFWNDZDSkY5TldwNU9qclhL?=
 =?utf-8?B?WU1vQUVuS0dzZEY2TmRvZmYzSnF6VXFtZGRZcXp6ZjBPd2FWSnNyVXhPS2pn?=
 =?utf-8?B?bm9UeVQvSkZ1MzFyOFJHWXhYaEU4R1Ewd251dGtZUkRiSHduUE5hazNUQ1JK?=
 =?utf-8?B?bFlUV3RTNGkrdDFlTjRFYjlKZHIxbURtNUJBZnlrQk11bVVJbzN2bTQ5cTAx?=
 =?utf-8?B?eWsvc0lzN2xOcFhvNU80enFwMkIySnZGTTNKSHlreWJTNmJRQW1IVUVCZStu?=
 =?utf-8?B?Yk0rcWlrQ3pabUV3VERpYVg1ckJNZ3JsY2pJMjV5Yy9yTnk0MXlROTNaSEZa?=
 =?utf-8?B?UUNPZlNVZ04wZURtWVJxQWViaVVwcEZaeDg5VVZldDA0YVZiWlhqWlJ3blhK?=
 =?utf-8?B?aHhsYkJzTldTM0JETXcrSkgzNVJTRWNxcWJoKzIvYkRFUGJNV0tXTlh2Mm1W?=
 =?utf-8?B?WEJ3aVFzVmZBbXRnOVBuTHl6UWN5RzhOQjVTamZUS3BiR3hGUTM1WCtXeE1i?=
 =?utf-8?B?M0dTSjhOQlJ0VHNQY01kMWZFdkJvK2dQcHBjcGs1UTZmcHBDTXJoYS91Sm5n?=
 =?utf-8?B?OFVZRVpXM3pNY0hEdDBQbFBZRllyZVRtLzJOUm1kN2dlQzYrc1A5SFlGVU9X?=
 =?utf-8?B?Y0IxMzZtZ05JQUZwZTJ0djI0SEVYT1hHWWpuMFRMaFpxRnhCaUkrTEFWQTFG?=
 =?utf-8?B?NjV2YjZBUi92VmtNdXp1VTVMWUtXaDl4VzRVbWM4c1V3MGU1Z21hRkpLRGxs?=
 =?utf-8?B?cWhPQlJ0S0FENVVSY043R1pWSmpZMEtOeXBkeTcwR05PektRODZ5MlNPU2Ro?=
 =?utf-8?B?M3Fwc25ua2F6UjVmaDB6a2l2T2F6YkJNUkJzRzAxazhiRGM5VkJKWmVpSzlr?=
 =?utf-8?B?ZWladVJYZC9qWWs2OUtuMlFzWjE2eTRlV3g5cEsxT2QwNWFCTWtTN0lYK2V3?=
 =?utf-8?B?OWNpRDBFRnV2YWxQMnBuMmZ1RUtlVERJemJua0hDYW1EQ3FPV2hPNUpmcVkw?=
 =?utf-8?B?dFE4TnhZMGthNzhxOUVrSm1JbzNOVGVkT290Wm5nMWVMZWZ3L3Rac2YvVXJX?=
 =?utf-8?B?WGFFWHRCS3AvVmNHSU1PbUpySTlZODlGTlhCSjd2ZVN0OVkvQ1dvRUJsOHpU?=
 =?utf-8?B?KzE4bkRQSUs0bDNrZ24xUHI5YXpDcEcrWnpVTzArdDB4S0d3SENtcXVvZGFG?=
 =?utf-8?B?R1dzK0h1ck5DSWh4d3F3SWdPQU9lVmpuRGcxdnRKYVNOaXJqODZLQk1BQzEw?=
 =?utf-8?B?R2ZmTEROait2ejdKa2x6OFhLNXd1UVcxVVNXWHBVOWdjdWNoV3NHUXRCQUpU?=
 =?utf-8?B?a2MvUVpEMjlQUWJvRmYvNDEyQnAzemR4SGpXRlhDWFRkV2NQQjBUQW9ieFpC?=
 =?utf-8?B?VG8rQ04ybkFyKzZCWjQ4bUFqVlVXY3h1QzlKRDZ0Q2RleGo5bjFpai9jUmg3?=
 =?utf-8?B?MXB0SU5QR01hTzh4VTZZbm1mOWFLUDNSTlhNbFBRMkQwVDRad0dQYStZTjRy?=
 =?utf-8?B?c282NjZnU3RHa2tBY0VudmJVNURIWGlxMFBkZTIwdUU4VjlqbExjMGtvVjBI?=
 =?utf-8?B?a2pOSVh6amFod1hiTmVmUkxkdXVnYmhmYm5EdDJod2lpN2dlWW9qRkpNRDdv?=
 =?utf-8?B?SjczVGtqT3I2VFU0YlhjZGNQQnNoVUk5YmRpUkdud1d6L0pZMnRyZ20xZjMw?=
 =?utf-8?B?QXAyVWxXVW0rNWFLUFhGYUlEbkJjSkNBZTllODhNZVdhZEJReDVTQ2pOQm9O?=
 =?utf-8?B?blR3MGVyRTFBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHdxTmNEYlR6dGFwN3lWeStoVkdJTzFranFtTGtlVFJoVVFVNTFISzFSV0xN?=
 =?utf-8?B?QzZTL3NBc0NFZjc2Y2lUQ05HK3pzZi9lV282UHdOTURhRWM2OFgzeXZqSDhE?=
 =?utf-8?B?S2JSemNWVnZKS0NnRkhVbGRsRytvMEhLQ3M1NS9zTFRScmVmNTBJdEJXbFBL?=
 =?utf-8?B?eDcrSVlVcUxJNTJPYWw3dnZHcVQ1ZmdaM0orVjdjSGcvdGV3VmRsenBwK3Uv?=
 =?utf-8?B?OWtLRGdwWjErL1N0RWhTZE5wcU5UUHBtdkNIRHZmdjJrdGNUNDRyQU9EVWVy?=
 =?utf-8?B?WFA3TjJsa05Va21SeUV5dWE4N2hYS2JSS1dmVXZBeW5vbVFWdENrZFpoWW1B?=
 =?utf-8?B?a2hzWWplbWcxS1JteDlJQWlPR0wwZ2tLblY4ZHZyczZhUExrT0l3akFQWWNm?=
 =?utf-8?B?MXJnb0E3QmJCL1Z2Mm5kZWprK3VwcGd1aENQdVRMNlNRNFZ1WjJsUHpxVzJV?=
 =?utf-8?B?bFo2OXgzQ1hqQjZXcWJERHovOE1PRmJKdTNETUJjdmZ5Si9XVzZJVjFDYi9I?=
 =?utf-8?B?WU5YY00rMGVkd2FUV0Z6UmJzR24zOXdyelI0a1lsSm13R0lNd1RMUkc0Wmpp?=
 =?utf-8?B?dHFrWHA5Slhldk1WeGpjMHJZaC9udWhvRHRKV29JcXQzWkhQTzRaclhTZVJD?=
 =?utf-8?B?UHVzSDJ1dHdMRFFTVGE0TTBJV0RXSFcxWVJyV1VQTm1zaXJIcU5pcmpoT3M3?=
 =?utf-8?B?Z2haZ1dmK2dSa3NLUVBlblFxL1lOeCtsTnpUdEtOWW5PWG5PUnQ1Mkhha05J?=
 =?utf-8?B?L0N3ZUwxY09lYkNBMW1qYk5FVGJySlhDOUpPYUM4ZEVtOUtOZ3FNMkptQXhn?=
 =?utf-8?B?MjVZZE9Fa1VJM1pZN3JMTjV6ajhCMVpRc1hTYmVkNzB2Yzc0ejRDNXhBWHZm?=
 =?utf-8?B?THZLamtuNTZVeHRFTUtBQkplY3F6bW9CNFcyZzNZREZYbHB3bERvVHArN3NB?=
 =?utf-8?B?cFJDVFZiTUZFMzNhY3Y0TEErSGsyZk54UE5HUi9uVlpsTDNmZjhmcmFnaFgz?=
 =?utf-8?B?QmZXdkdYeFFjajVOR2Y1MSsxRWY0MFFwNzM4SnR0ZVZDSXJqbmlUK0Y2Vyt6?=
 =?utf-8?B?dm5tbEp5aXdENzdkQUJUeTFpVDh1ZHpSeWFYMDE0d2xSL2huMyt3TjBqbXRZ?=
 =?utf-8?B?bEZybVpxTWcvLzVqMllQYld2UkFMMHFWeXhEck5ZUkpVWkZHeTNOZVBGdEJa?=
 =?utf-8?B?a3VBWjdmekZ1a0VIRjBDakM2U3M2UFdueWFQRFdURDd1Z3hZM3pGeDd0SU1X?=
 =?utf-8?B?TWxVL0VpZjh2Z0pidDBYeVBydi9zN0M2WDhLNVI2YTJFS0w4NjEvdHJwWktP?=
 =?utf-8?B?VUJtTiswZCswdFZpbDB2Sm9FYy9pbm5YNThuL2dvS2RRR0xVQklMYVlmekNR?=
 =?utf-8?B?TDlGZ2RJTkVoS0tZZjlCSmljdUJWNWM0RTZZODN6aUZwOUMwU2FjTVpCbUVj?=
 =?utf-8?B?Nnh0OXVHT2d2S1YxR0llZG9jcnRRZm1rZ3J1ckNzaXpPc0s4bkJwelBVcVYz?=
 =?utf-8?B?dDN5em03UXJpT3pXUjg1TXArZktWenRETTFBV3o4Rmh4S3ZYK3B6c1YrUTBB?=
 =?utf-8?B?a3NTTW9YY3diSlNGQmZMczFtUlc4TzRrRk5NWWttbkpEWnFFam85VWxZeVh0?=
 =?utf-8?B?Qmt5VnZFZlRtRmdmWnV0c3E1cjBtWmhWUDBYdDdkZndoNFlUczhTME1BUHRD?=
 =?utf-8?B?MUR3SDYzd2o4L3p0NU91UUFHRThTUlhmd2hYQVRLb25VV3JoMTlOYmwremJm?=
 =?utf-8?B?WFdRQVNmaUVoNjFrejBjSWEvNXRJUlNoWElGaFp1UDRoRWo4TXhxd3dWVUtF?=
 =?utf-8?B?SUVWTWpsWHQ4MWY3N3dkdXA2czgva2QyUTVtZmM0ZElHbEVzK3FLa1NVMXBT?=
 =?utf-8?B?Q1hTaHpyb0hQQlZTcjRzaUh3d2R0ZHNDV3R0Q3VpYS9YM0JBY2VFdElubFRE?=
 =?utf-8?B?d1lldklCQ0pTbHhmdnB2ekFxRmw3bm04eXU2RmQ0bW9RZkZRZkcraFNnTHJ3?=
 =?utf-8?B?T3p5amwrS2t1NGNNSXUrbml1eDRUKzNMSFZaUlV0dTJrQmgxZVIvWFlWVmZC?=
 =?utf-8?B?d2hEcnZnUXlxT0RtWDRySW9VNVA2K2JUNXF2bmgxTWtCL2RKVFJoU1o2SGZj?=
 =?utf-8?Q?Kqwlz1S/oL94Y+vid0wC6MrTr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbc1b930-01f2-46ea-a614-08dd68483c51
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 07:16:01.6474 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UaQIQ6b032ecCKvj/w7Qoa6E+vXgEPisaxfsU9Mqgh0omCb++spwDuPx6XQd54g4fTAhDT7vLix99BWetppMhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6836
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

This patch provides a pinctrl driver based on SCMI pin control protocol.
Currently, only the PINCTRL_CONFIG_SET command is implemented.

Signed-off-by: Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 drivers/pinctrl/nxp/Kconfig            |  13 +++
 drivers/pinctrl/nxp/Makefile           |   1 +
 drivers/pinctrl/nxp/pinctrl-imx-scmi.c | 152 +++++++++++++++++++++++++++++++++
 include/scmi_protocols.h               |  36 ++++++++
 4 files changed, 202 insertions(+)

diff --git a/drivers/pinctrl/nxp/Kconfig b/drivers/pinctrl/nxp/Kconfig
index d13c5f2a6d5..84d9a3641ff 100644
--- a/drivers/pinctrl/nxp/Kconfig
+++ b/drivers/pinctrl/nxp/Kconfig
@@ -139,6 +139,19 @@ config PINCTRL_IMXRT
 	  only parses the 'fsl,pins' property and configure related
 	  registers.
 
+config PINCTRL_IMX_SCMI
+	bool "IMX pinctrl SCMI driver"
+	depends on ARCH_IMX9 && PINCTRL_FULL
+	select PINCTRL_IMX
+	help
+	  This provides a simple pinctrl driver for i.MX SoC which supports
+	  SCMI. This feature depends on device tree configuration. This driver
+	  is different from the linux one, this is a simple implementation,
+	  only parses the 'fsl,pins' property and configure related
+	  registers.
+
+	  Say Y here to enable the imx pinctrl SCMI driver
+
 config PINCTRL_VYBRID
 	bool "Vybrid (vf610) pinctrl driver"
 	depends on ARCH_VF610 && PINCTRL_FULL
diff --git a/drivers/pinctrl/nxp/Makefile b/drivers/pinctrl/nxp/Makefile
index 44e37c631e5..7d861ae52c1 100644
--- a/drivers/pinctrl/nxp/Makefile
+++ b/drivers/pinctrl/nxp/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_PINCTRL_IMX93)		+= pinctrl-imx93.o
 obj-$(CONFIG_PINCTRL_MXS)		+= pinctrl-mxs.o
 obj-$(CONFIG_PINCTRL_VYBRID)		+= pinctrl-vf610.o
 obj-$(CONFIG_PINCTRL_IMXRT)		+= pinctrl-imxrt.o
+obj-$(CONFIG_PINCTRL_IMX_SCMI)		+= pinctrl-imx-scmi.o
diff --git a/drivers/pinctrl/nxp/pinctrl-imx-scmi.c b/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
new file mode 100644
index 00000000000..0ed971369a3
--- /dev/null
+++ b/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include <asm/io.h>
+#include <asm/mach-imx/sys_proto.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/pinctrl.h>
+#include <scmi_agent.h>
+#include <scmi_protocols.h>
+
+#include "pinctrl-imx.h"
+
+#define DAISY_OFFSET_IMX93	0x360
+#define DAISY_OFFSET_IMX95	0x408
+
+/* SCMI pin control types */
+#define PINCTRL_TYPE_MUX        192
+#define PINCTRL_TYPE_CONFIG     193
+#define PINCTRL_TYPE_DAISY_ID   194
+#define PINCTRL_TYPE_DAISY_CFG  195
+#define PINCTRL_NUM_CFGS_SHIFT  2
+
+struct imx_scmi_pinctrl_priv {
+	u16		daisy_offset;
+};
+
+static int imx_pinconf_scmi_set(struct udevice *dev, u32 mux_ofs, u32 mux, u32 config_val,
+				u32 input_ofs, u32 input_val)
+{
+	struct imx_scmi_pinctrl_priv *priv = dev_get_priv(dev);
+	int ret, num_cfgs = 0;
+	struct scmi_msg msg;
+
+	/* Call SCMI API to set the pin mux and configuration. */
+	struct scmi_pinctrl_config_set_out out;
+	struct scmi_pinctrl_config_set_in in = {
+		.identifier = mux_ofs / 4,
+		.function_id = 0xFFFFFFFF,
+		.attributes = 0,
+	};
+
+	if (mux_ofs) {
+		in.configs[num_cfgs].type = PINCTRL_TYPE_MUX;
+		in.configs[num_cfgs].val = mux;
+		num_cfgs++;
+	}
+
+	if (config_val) {
+		in.configs[num_cfgs].type = PINCTRL_TYPE_CONFIG;
+		in.configs[num_cfgs].val = config_val;
+		num_cfgs++;
+	}
+
+	if (input_ofs) {
+		in.configs[num_cfgs].type = PINCTRL_TYPE_DAISY_ID;
+		in.configs[num_cfgs].val = (input_ofs -  priv->daisy_offset) / 4;
+		num_cfgs++;
+		in.configs[num_cfgs].type = PINCTRL_TYPE_DAISY_CFG;
+		in.configs[num_cfgs].val = input_val;
+		num_cfgs++;
+	}
+
+	/* Update the number of configs sent in this call. */
+	in.attributes = num_cfgs << PINCTRL_NUM_CFGS_SHIFT;
+
+	msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_PINCTRL,
+			  SCMI_MSG_PINCTRL_CONFIG_SET, in, out);
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret || out.status) {
+		dev_err(dev, "Failed to set PAD = %d, daisy = %d, scmi_err = %d, ret = %d\n",
+			mux_ofs / 4, input_ofs / 4, out.status, ret);
+	}
+
+	return ret;
+}
+
+static int imx_pinctrl_set_state_scmi(struct udevice *dev, struct udevice *config)
+{
+	int mux_ofs, mux, config_val, input_reg, input_val;
+	u32 *pin_data;
+	int i, j = 0;
+	int npins;
+	int ret;
+
+	ret = imx_pinctrl_set_state_common(dev, config, FSL_PIN_SIZE,
+					   &pin_data, &npins);
+	if (ret)
+		return ret;
+
+	/*
+	 * Refer to linux documentation for details:
+	 * Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt
+	 */
+	for (i = 0; i < npins; i++) {
+		mux_ofs = pin_data[j++];
+		/* Skip config_reg */
+		j++;
+		input_reg = pin_data[j++];
+
+		mux = pin_data[j++];
+		input_val = pin_data[j++];
+		config_val = pin_data[j++];
+
+		if (config_val & IMX_PAD_SION)
+			mux |= IOMUXC_CONFIG_SION;
+
+		config_val &= ~IMX_PAD_SION;
+
+		ret = imx_pinconf_scmi_set(dev, mux_ofs, mux, config_val, input_reg, input_val);
+		if (ret && ret != -EPERM) {
+			dev_err(dev, "Set pin %d, mux %d, val %d, error\n",
+				mux_ofs, mux, config_val);
+		}
+	}
+
+	return ret;
+}
+
+static const struct pinctrl_ops imx_scmi_pinctrl_ops = {
+	.set_state = imx_pinctrl_set_state_scmi,
+};
+
+static int imx_scmi_pinctrl_probe(struct udevice *dev)
+{
+	struct imx_scmi_pinctrl_priv *priv = dev_get_priv(dev);
+
+	priv->daisy_offset = is_imx93() ? DAISY_OFFSET_IMX93 : DAISY_OFFSET_IMX95;
+
+	return devm_scmi_of_get_channel(dev);
+}
+
+static int imx_scmi_pinctrl_bind(struct udevice *dev)
+{
+	if (IS_ENABLED(CONFIG_IMX95))
+		return 0;
+
+	return -ENODEV;
+}
+
+U_BOOT_DRIVER(scmi_pinctrl_imx) = {
+	.name = "scmi_pinctrl_imx",
+	.id = UCLASS_PINCTRL,
+	.bind = imx_scmi_pinctrl_bind,
+	.probe = imx_scmi_pinctrl_probe,
+	.priv_auto = sizeof(struct imx_scmi_pinctrl_priv),
+	.ops = &imx_scmi_pinctrl_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 7abb2a6f36b..279ebbad440 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -24,6 +24,7 @@ enum scmi_std_protocol {
 	SCMI_PROTOCOL_ID_SENSOR = 0x15,
 	SCMI_PROTOCOL_ID_RESET_DOMAIN = 0x16,
 	SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN = 0x17,
+	SCMI_PROTOCOL_ID_PINCTRL = 0x19,
 };
 
 enum scmi_status_code {
@@ -1005,4 +1006,39 @@ struct scmi_voltd_level_get_out {
 	s32 voltage_level;
 };
 
+/* SCMI Pinctrl Protocol */
+enum scmi_pinctrl_message_id {
+	SCMI_MSG_PINCTRL_CONFIG_SET = 0x6
+};
+
+struct scmi_pin_config {
+	u32 type;
+	u32 val;
+};
+
+/**
+ * struct scmi_pad_config_set_in - Message payload for PAD_CONFIG_SET command
+ * @identifier:		Identifier for the pin or group.
+ * @function_id:	Identifier for the function selected to be enabled
+ * 			for the selected pin or group. This field is set to
+ * 			0xFFFFFFFF if no function should be enabled by the
+ * 			pin or group.
+ * @attributes:		Bits[31:11] Reserved, must be zero.
+ * 			Bit[10] Function valid.
+ * 			Bits[9:2] Number of configurations to set.
+ * 			Bits[1:0] Selector: Whether the identifier field
+ * 				  refers to a pin or a group.
+ * @configs:	Array of configurations.
+ */
+struct scmi_pinctrl_config_set_in {
+	u32 identifier;
+	u32 function_id;
+	u32 attributes;
+	struct scmi_pin_config configs[4];
+};
+
+struct scmi_pinctrl_config_set_out {
+	s32 status;
+};
+
 #endif /* _SCMI_PROTOCOLS_H */

-- 
2.43.0

