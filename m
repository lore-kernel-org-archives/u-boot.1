Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F90ECCD185
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 07:18:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41FC3838C7;
	Mon, 13 Oct 2025 09:18:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XqKTsSby";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0C3D8384E; Mon, 13 Oct 2025 08:59:43 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA1638381D
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 08:59:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gKgfFfFlAYAnqpK6YFXO2Fuz3TsfAWZ0m1yZoc44X3KIEB0vM+S3+SyQG4bU5s6aIRqDPYn2MQKp68v2dUrxDOv+7W2diaKB4yIB1JyQDbFk2hoDv6h8xDDsbMU3fhYZdbE8BFfmXoeV9VqUToJvdaDygoRuE4Bt2extLtHLrU3z1ZlRWibXT/Jzm5aEjZHci744FCpIHApD9ZW4zSpk1cxilMRyne1Mb8IQfgu5lAFSGBPbGHZc+KBQGqpLfZ20I5mXg6UPpLBw9Y9uhzyErLRciRvT8tZyQjXwXi3Za4n8/koUZBkiQvCHCPfnpdCu4NNQE42Az5DXryFnecAFbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2fHi31JAPlN12Io1Dbb7K6qhFfn87ZJCPTZM4+h5Ws=;
 b=pKFuJDqgwr79d/H+BXQWpdkQHDVOvLOWBJDZUek06itAflkcI5C2f4PjbAtON1Dck0BYF7LyPQw0CfzrPyd4DW8krT5MeCZ2UncoQj01T0qOywzdfT3Vb/r/+AEYdLY3mPWSxD8jLf03AbBAkrJer8LCV0+G6cBCHLmiZ3CiwMK6xEOOI+zbzjI/gsrOxgtT4Hk7KdNYb6GvjAtpJY0F6+2qbe1IGaLeMF1hIcsuk4M3SWCnq/Yx5bbdnBu6/wD0SHD6WkiMvUh56sF4kD0K/yqEMVVym/HFzENwS5QMoS2IsKrD8yX+nmORn9wUpV8FxE0fd1DiSrBmuLHFzkg41g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2fHi31JAPlN12Io1Dbb7K6qhFfn87ZJCPTZM4+h5Ws=;
 b=XqKTsSbyICTJHiyRmawBwCcqdrsIrFR0I8NOIF8EgM0XA4VhqgFC6eQIMCgwOsEOnYcqIasS77PDhAgqXp1Z1Jt3eh/MPPeW0Lmrnux5dUyWTx7j21YvBIOp81wrH6+63VbUX8ovsP/oNkULVvp/jGvCZjl/lHlxmijRGT63X8IBLCYx8lLn2elmhAFxHu6fx+Fr7Yo6txYiE+wUBRdX/ANPFvJIyYAmC/2n5AphSsGHisIR2sy1+WmOsjqbdt6K5a2LFae+XTE38zpw6y86ZSXcTE2Obq1vfWRQuZdLjdIkueABbgRYxp5NLQni2OV23014wm+6X4Scu6IPpIz5lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU0PR04MB9276.eurprd04.prod.outlook.com (2603:10a6:10:357::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 06:59:39 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 06:59:39 +0000
From: alice.guo@oss.nxp.com
Date: Mon, 13 Oct 2025 14:58:43 +0800
Subject: [PATCH v3 02/10] arm: arch-imx9: Add USB2.0 and USB3.0 base
 address definitions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-imx943usb-v1-2-293e79d4bc12@nxp.com>
References: <20251013-imx943usb-v1-0-293e79d4bc12@nxp.com>
In-Reply-To: <20251013-imx943usb-v1-0-293e79d4bc12@nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Alice Guo <alice.guo@nxp.com>, Stefano Babic <sbabic@nabladev.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Jindong Yue <jindong.yue@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Frank Li <Frank.Li@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>, 
 Minkyu Kang <mk7.kang@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Tim Harvey <tharvey@gateworks.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Roger Quadros <rogerq@kernel.org>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Hanyuan Zhao <hanyuan-z@qq.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU0PR04MB9276:EE_
X-MS-Office365-Filtering-Correlation-Id: 81e7a20c-ab00-464d-b0f2-08de0a2613de
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|7416014|19092799006|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dTQ1RTRHeXcvUi9JN3hRM3IxQi9PVGpDOE5XQnRnb2oxUlRXQkZLV2NUQmVJ?=
 =?utf-8?B?emRyTnhkRVUxRWd4d3BGZS8rVFl2Q3dJU0hYQ1VxL0pPNUQ0dm5IMVFiaFBr?=
 =?utf-8?B?VFpXNlZDS01zNDkwMEVSWVdTakhRK3Y1OFZDWXZpbFltRVRCT0YvTVBrUFNp?=
 =?utf-8?B?SjFSM21kbWtrMm00TWhjQnc2Y0ZRZTh5ajZ6Y1FRazZONENNTUVtSWV1dHVa?=
 =?utf-8?B?U0l2Z2ZsdzhBOU9JbFNyMDNQSWpPSFRSaERGZE94ajBKM0pub2JGNE13WWxp?=
 =?utf-8?B?aGt3RVJBeFZlcTkyOWt5enVLWC9aazBuSlNYai9STnNLODFwQUFUUEp2Y0pi?=
 =?utf-8?B?WnNnS1g5ajFLbmxnaXFpYTliTVVpbDdGaHdGczhXeEpVazVESUs1UFhZSXpt?=
 =?utf-8?B?eTBiTllWMDNmb2JaWHRVWmJ0SkFqQzNkUEtubmUrcWlDSEgvNFg0WlQ4bTF4?=
 =?utf-8?B?aWVldWlvVkUvMElsekFnWjRiWDN5ZVJUdk8xMWR6MERvaEpqRTdhZmVGUDUr?=
 =?utf-8?B?K2tVUktjcXBCckF1UDdyMlkrTUpJeUxldlYvVjVLa1hjVFdnUzhQRXVESmRG?=
 =?utf-8?B?bk9QMXlEQkJuRk1FbEw1NmNEaXNZbEtDckFsZlR5SDJ5ZmVYQURTQ0RrdjVr?=
 =?utf-8?B?TjJRNWREMkZtT1djKzNtVUt2bnI3RkpWczlXRlJONWxPcXhTMjhXbmlXeGwy?=
 =?utf-8?B?dEZ2MWVoOVN6c1BmR0x1TittemNzZnR5QlZnT2VYTm9OYkV5dktwOEFDUEtM?=
 =?utf-8?B?RjdOSzVZSmZFWktyVUg3ZEFJWlRQdnFqMEtUcEx4K3NPM24xbHU3eUVlaWdD?=
 =?utf-8?B?S3QzTFBiMXpuQndPWXJxU1BQK2U1dVY2YTNXUlZaQmVndWtBM2tmQUdFdTFK?=
 =?utf-8?B?NE1yeHMzS1RPa3NkdE9MR05YbW0xZU1rVHoxdk5pMWJMbVNHcWJTQ1dxYkFM?=
 =?utf-8?B?RFZ6NS9IYm1uN21XM2VNUzRSWE9kZnhTUlJMMytwQjl6OG9nR3RDbXJOanZo?=
 =?utf-8?B?WVQ4Yk45elpBRDdoWFFtN3FnblpyKzZLeVdFS0IwV05DZTZ0VWt1T2FaRVRy?=
 =?utf-8?B?TjlHcW5nNGpNd080MmFaQzFidzdtclZrMjNPQVFlejJ4ZWVrR2cyZ005Z2Vt?=
 =?utf-8?B?d0VXQ2FLT3lKcS9HSEJQSGxNRFZQM2hnZzJCdWc1WDFQYk5UQ2VONHNaQnJl?=
 =?utf-8?B?dlg0UXFkZkVMNGNORi9JNmphOFFIaCtHT0FkU1prSTJUcXpDOHZYbFc1OVRn?=
 =?utf-8?B?T2g1VGwvMnpuVzlXaGpnYkZmeTFtcVdDZDlrVUtRQkxFV2M5NDJMbDRrcXZy?=
 =?utf-8?B?ZWg5YkFRaHg1UmpvRHFWaThCTGpOaVBIQjNBcjNiMmNpb0xNS004VUZFaU5M?=
 =?utf-8?B?Yi9HZy9JM0RVZUZHOUtBM2hBODEyUTlyQk5sVGpTdnBYVVdZR3hiSmRGblhy?=
 =?utf-8?B?RFpKV2dnUzByS1VnVWY2cnJUNGVjV1dKcEcrVkRvRHFoeVUzcjd4Q2pob2JD?=
 =?utf-8?B?N29OQkRRRGhZTkJEekphaW9xS2xnTWR3d21IMXFrQlZGRmh6bE9hSWVoS3Vq?=
 =?utf-8?B?cHh3ckVJajBqb1FnZ3UyVmlXZElIOHU4ZFFEdmgrYlRjdkkxUUw5RDFObGYw?=
 =?utf-8?B?UFVEU3NLL01rc0hDZG9oamVHcGM2bG96d0F6alJqV0FZMTAvZS9Ed3ErOVdB?=
 =?utf-8?B?WllGYWlKZjJLakpVbU5NcDUxS0dicGxydlNIckRob2twNi9GZVVXK1lnek5H?=
 =?utf-8?B?WHZBdWo1Q0hGMHREa2dnZHExaXJka01kM0FOUjRoYWlNT0h3dVVSR2EybUJQ?=
 =?utf-8?B?b0VQdXVuL0Fmc0ZxcCthcjVJcndhUHVFcGU5VXBlTTZoNU5CNUx4eVdHZi82?=
 =?utf-8?B?RzZid2FNVm9Hb01wclNVS3FTYTFHTDdabWJyTURuNXBRcnN1eGQ4UjRhT3Bw?=
 =?utf-8?B?cFluY2RTQ3BVUnRNVGZNVkp2OG9hZmlIR21UUlJ3a1Y3QWtpTW0yL1NrYlBw?=
 =?utf-8?B?K1hvWWpkUDJWVEVRWmhhNDVQRGc0dGIwaXB3ZXJkVTN6VjU0dWhjQ2xGWTg5?=
 =?utf-8?Q?xUL7T/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(7416014)(19092799006)(376014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkxFaWFlSDZhekU3UTZsSXZlQ1IyeFpaODhNenVpQldzREVUTTdTcXhRSjk4?=
 =?utf-8?B?TmtMTWRic1hZcTRBMWtXdDRMN2o1TjE4WTl6YmN4WXhIR0RpVDkwWjRBN0lr?=
 =?utf-8?B?RnFvKzkxa1JCS1dOcDZFMEQ4enA5WmE5dGNFa09tUWUzajVxbisxS1Q4UWZQ?=
 =?utf-8?B?dEVjU2lVUnpWMHFJdWZPQmtIWUw2TmV5N1BqRWptMXlwU0pEZ0ZFM3NUck9M?=
 =?utf-8?B?TDNULzMrQTdDdnA1djVKU3h0QkFUcHluZTVyeFVjSTZ2VThpZFQ1eE5oKzIx?=
 =?utf-8?B?b3U1ZTFWUy9XdFh2MWdrc0tsVVoxdXlqSVBTaTltUUpvNUpKY2E4ZFR5REhl?=
 =?utf-8?B?cEYzVEYzV2diVWxJTGRwQkhhZ3pCb0FtVmxTR0RNTzhFREtGYTVDQW9DOUJk?=
 =?utf-8?B?U3ZzUDV2aFhRL1JjZEFlN2FyWFJoTzJxS3Yva1ZmRUExU2U5b2FXL2NmWkp4?=
 =?utf-8?B?WFkvZE9Ga2c3MVAydTZTa3o4Sy9Wekx1RUZLZi9pN0JVUkoydUp0dmYyMUhI?=
 =?utf-8?B?OWNDVDl2aDRQZzJFcklOM2dZQW8xTlA4VThNbVJBbEsybUg5ampaWHg3anZV?=
 =?utf-8?B?dXRKcTF2Um9xbzNoZVR5Q3ExenBzeGlrM1NPTUdVeHZmd2c2dmlKeUhQK0Jr?=
 =?utf-8?B?MmZFVHNSYWZ6dXFzSHVKM0JqelQ5WmZmS0NxbDNUMzhaYVkyQ3JZV1dtZUlN?=
 =?utf-8?B?WnZTRW02MzVLR01SdkZ5Z3VlM1dTZlFSN2hDTmhqYklwcVhoZE00WG80d2I4?=
 =?utf-8?B?WjZuNlFMZ2tRZTkwMlZxZS95cTJPdFgzaXN4SzRKeVdPQmdFRnNaUFNNVjBQ?=
 =?utf-8?B?WjR5cVRYeWQ5c3R3VXVhV2FJeklNdXl0c3gralNYWndVVkVDT2xxNzFDYzBv?=
 =?utf-8?B?bkZHa3pUNDdmVXV1c2R1c0tlR2hFczlHelNQVFczcFlvUFU3UTZmckhwQVBZ?=
 =?utf-8?B?QkR0VkI0RW40L25mNUJLb1NWcG5uRlpDZGpLeStqS2FuczVZakd0NTVsZlFj?=
 =?utf-8?B?bjBzc3kzMGdPM1VFNWQzV3RoU0tKdzIyVlcvdkp2Y3hjakxjYUtZZUw1aXJ3?=
 =?utf-8?B?a1gzK2VrT1RON2dtN0craGNqaTJUMEJEZUpMT0owWVE4c3htRk9NdysyR3d6?=
 =?utf-8?B?RWRwc1duYlZzcjI0bWxhc0ovRkkzMXdNVkcyTjluRXE2YU5LWTdzRi9IS0Z2?=
 =?utf-8?B?UlBqNzNnWXh3YmsvZ0w1UE5YcFIxeHlKWUVIU0NmSTZOV0doYTNzY285cnJZ?=
 =?utf-8?B?SmFnRTNJcGdWYmhVb0w2STJRTnVycVVpRUhaOFBCOE1LVUR6R00xWUlKR3V3?=
 =?utf-8?B?cEJhZENvRThiajRyVmNFYlVuMXJMdmdWSkk1R0xLbHhMa2R6WkZHTWxKd1NO?=
 =?utf-8?B?N0Vnd3ozNjlCUDJ2dHc2R1J2N1JkOG51Ry90dmNkMFg0cFp3WU51aXk0K211?=
 =?utf-8?B?UU5KQUp1Qi9NTmZ4SDREYm0wZ2FkdndVSVRrZU9RNUg5Q2dqYXViYXovY0FR?=
 =?utf-8?B?VU8zVTVvWXd5cUw4NUQrYXExc0xwYzExSzBYcmdnM1BzTXJwZ09lcnR5Rmk4?=
 =?utf-8?B?WXNXQ2l0UFdISlpPT0dqVDZvQ3ExRTZPenZWZFcwR3JCVjJOZlpBSmFRMmtZ?=
 =?utf-8?B?ckFmRGxFZlo2K1E1aXYxcFFneG1DRDNuS3UvVlFFaHcvdTZ0Z0pFOTgrYWVM?=
 =?utf-8?B?T0pqTlp0QUF4VXFvYUF0Uk0veWVpRXZ1djJza2dCMEkwelJJNUgrMFZhRFNq?=
 =?utf-8?B?amJkWiswamZncVdCYzNub1U0MzFCUzBnOFA5WmgweEZjODNEQ3p2OHVETkV1?=
 =?utf-8?B?ZTV3dFFDK1dsZFNtY0M4SlR5aGFBd2ZYajdVVER6TGl1N1JaK0gvdDc5N0lQ?=
 =?utf-8?B?YVduYlp1ZU5CMXBScUo2cXBNMmxOcmppejlDcEg5aTRLVzZjcVNwdlhxMlBr?=
 =?utf-8?B?RlJOQ1RtS0tKQTV0SW9XcVZWdjI0VG44SzVPQ29KaTdqYllsUXJUVCttR3Fh?=
 =?utf-8?B?bVd6N1RVVC81VUwxRDNMRG5ycmhUOG5FdWdlN1J5ZkNJeGMvOHo1M3NUYkpr?=
 =?utf-8?B?NXdwMHd4ZjdhaFIvWEYwaTA5M0hhKy9oMUZZZU1aSTBudnEwcUhuU2FvS3p2?=
 =?utf-8?Q?fPxU7dHeXG3rcArog7TPxVCBE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e7a20c-ab00-464d-b0f2-08de0a2613de
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 06:59:39.3558 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OiJs2AXdeEEFTdbqtGRJPJAc03+KxidFTAFQZHXvxNreml48sU08HglgcoWUF38iEvw4oovJAuTtyVkIcgP/zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9276
X-Mailman-Approved-At: Mon, 13 Oct 2025 09:18:15 +0200
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

Add USB1_BASE_ADDR and USB2_BASE_ADDR for i.MX9 platform, and define
USB_BASE_ADDR as an alias to USB2_BASE_ADDR.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/include/asm/arch-imx9/imx-regs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/include/asm/arch-imx9/imx-regs.h b/arch/arm/include/asm/arch-imx9/imx-regs.h
index e641ed299c0..2d084e5227a 100644
--- a/arch/arm/include/asm/arch-imx9/imx-regs.h
+++ b/arch/arm/include/asm/arch-imx9/imx-regs.h
@@ -39,6 +39,11 @@
 
 #define ANATOP_BASE_ADDR    0x44480000UL
 
+#define USB1_BASE_ADDR         0x4c100000
+#define USB2_BASE_ADDR         0x4c200000
+
+#define USB_BASE_ADDR          USB2_BASE_ADDR
+
 #define BLK_CTRL_WAKEUPMIX_BASE_ADDR 0x42420000
 #define BLK_CTRL_NS_ANOMIX_BASE_ADDR  0x44210000
 #define BLK_CTRL_S_ANOMIX_BASE_ADDR  0x444f0000

-- 
2.43.0

