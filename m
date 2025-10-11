Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A96BCCD184
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 18:08:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A57383AEA;
	Sat, 11 Oct 2025 20:07:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Ae2ByQg4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B286E83E11; Sat, 11 Oct 2025 11:14:08 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF0D883C2B
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 11:14:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lCBMcKkyCHiLZnKNOdwOARdg1Swzz2GkSzO/Fia6ScGgYvPU7+B7AfhE2CQ9pYyxqypxxRJdHspQSelxBLUK2AGGf99l2ZiUpvRUfZBTDVww3QxwtrAt/TmznByy0XK3/DJmHITP7BYBjnFyMYtJk102MDULP7pM7EWnPR/kr3d8JBuVc6OPwX1yCJvVNYIfPxQ720MqByho0chO1y+Tk7Fsr+M1luRNYIDNw3Wb+6ZvWUKbqpyOCuZhKSB38f9sDiIXhP9Tc8vLevRG0CUJbcxRBghrTBnreBM6XHqsRWko7lPfzDu7ccS3pBvlEUFYpJtJSX7RBjars2hZEXGdYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMKnJnsjLg+W3u8Ehu/GOT+mqsuVM7iGL4GIK9Mf09k=;
 b=J6IbaopotIBbNFvpduH2DnILGlQSDR4AJORDFD86FftUOzn2wuCdTKXTRUEz8a+4/cQBBQW630YHux7HDw1hAbl24VO+L5Bl0YkJ5TQ/YQYa/41AnfsU+RfNZ2JR7kJtov09IE5TVen9otr0MdXNFW0l0mKiViBw1Dykb8Mz8by0CnUWX8QRtpsOr60sSEEBJD53QBAiUndjsQ41VwQ9rPKaBTI7JnaX6giL07ermQerlKJumvVacRK+iB0d685mMHX1tKcAAkamVrd5j6z0LcjvosNvEYIUQoWnP9TmuTbBLWp9nD6i8FUy/FCHFEpxJdne042OgRqbkhqgBqNnYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMKnJnsjLg+W3u8Ehu/GOT+mqsuVM7iGL4GIK9Mf09k=;
 b=Ae2ByQg4WZU1sFpXagP3IAiyT+pO9/7sn9lpIizsmFDPswLzgi0x8W/1Xk5XaIU5H8SDby8FcKKicNL05tIKsRyWVTc7OIyjDQDuP+ksFDOZfVjvS3aCCprbbyxR6psEO7sK1Zj0BGqP/KFbiOuWtvHdQAYtWnOTzz3y2Jza5l7w9OOmBLXz/eWcqnEdQGvGNVMCD7QdkKN8zNDG5hSDtmglG7kQFFGWO453qE1c9eqMoi7NTFe7Rsc77UxFJa8y/AV+CTt2Vb9sfSisheTONg/wVtQTGdVE4yGBBC+94BcGL664/iRiEfcEmJTns+4G0FBfUZDSSVsrJQ+pk4FUGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DB8PR04MB7129.eurprd04.prod.outlook.com (2603:10a6:10:127::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Sat, 11 Oct
 2025 09:14:05 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9203.007; Sat, 11 Oct 2025
 09:14:05 +0000
From: alice.guo@oss.nxp.com
Date: Sat, 11 Oct 2025 17:12:52 +0800
Subject: [PATCH v2 04/10] Add serial# for SPL SDP download
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251011-imx943-v1-4-072b9ede2b4e@oss.nxp.com>
References: <20251011-imx943-v1-0-072b9ede2b4e@oss.nxp.com>
In-Reply-To: <20251011-imx943-v1-0-072b9ede2b4e@oss.nxp.com>
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
X-ClientProxiedBy: SI1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::11) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DB8PR04MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: bcb98ce9-881b-4f10-9a23-08de08a68687
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|7416014|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QzAwVTdiWVAzRTlXSU5UbUJtdjB3ZEUwSTlNYjRZYzdMWklnWnJXT0dhanhy?=
 =?utf-8?B?R0Z4cTBYS0lMenVZY1dvYVN1UkJKajRhOEtGd243MTNIeWh1bzB4UDhaZytE?=
 =?utf-8?B?VDlPNDdldXN2NVQxQnlkVXlXNlJCQzNGMk4rU3JmcGlrZzBMeG5la1RDak5W?=
 =?utf-8?B?VHB0VlpNbUhiaTk4RElmaG55aFpLNWZCdkJ0bnROTmpKR2RuMklWbEJpQmFI?=
 =?utf-8?B?MCtuL1NQb3REZE9uMEd1MVJlVnd4SldCOXlYdnI2L2pWanJpOHRWdTRsRm5B?=
 =?utf-8?B?L085K1hpd3FwUGptbGpXcytCbmpyQk1sUGpvUnIvRlVleDRhOHk1Q0Y2ZmY2?=
 =?utf-8?B?S3g2U2gxUFZEbkhyU2VuUTBoanZFUjR6YldJaCt2SEFYUEFENG55OC9tbVdJ?=
 =?utf-8?B?R3ZwZnF4RlpRNTVXa2ovY2E3SEEwSmRCZmMzejZ0elF0dFAvc3ExRlpadU01?=
 =?utf-8?B?U0N6NnZqRG5SWVo1SU82VkpieklqcTdjL2o3L3ZYdGNOUHdMeHhTZUpzU0JD?=
 =?utf-8?B?WENmbzdSdkxTVkVKVmF0UmVyb1FyZWNqZVQwMXZranhvc2JsTHkwcnF4V2Zn?=
 =?utf-8?B?dUFyTUNFV0dBKzVWc3pPMGR0N3BEUE41VklSaG5JU21XZEZIc2hTVVFpMHBs?=
 =?utf-8?B?dThNaW5Rb0tCQTczM2h0SmdxbTM2Y3c3TTdlZjZ3dk1WOFd1enJ4QjVBL0Jm?=
 =?utf-8?B?VVdyamdpTUovZ3MreE9KKzhjaDV4K3NvK3B3djQ3YnA1U3Z4SnFOMHZ2eFpa?=
 =?utf-8?B?K2xyMUNoUEcrNndTditSaUsyMTQ5K1lTdHVlN0t2MFJ1cTJhRjNpeG55Z1Ez?=
 =?utf-8?B?NzVCU1NnTlBKbVBoNGlnajNkVTRKMHlucDdpL0hLNTIzTTBZM09NeCtqVnJF?=
 =?utf-8?B?OGxXZ0xUYmFoSnZlbmxBZTA1SVlSaTNMaTZmUlJpb0lhUFQrS0QyNkR3eUpO?=
 =?utf-8?B?ejA5b1l3VTR6R3pHcFQwMVdqZGtIa0ZjOG8yWkJlcW1sY212SEZFb1BVTERu?=
 =?utf-8?B?SDZ1N0kzVnRKOVRjY2ZrZlp2TXcydWRxdnFjcXlLdG1LaytjVUEzVzNkeUw3?=
 =?utf-8?B?RXJLQXQ5YmNqT0x4M3Z2TmV5eHFsN3hmczNPTVN1d0FKTjlYS3RtRWdpOUxQ?=
 =?utf-8?B?bjNSdGZweDJWajdHYmtsUUtXUlRnVm9QN3BtT1NEdlRDR2dmbDZyWWEweTJm?=
 =?utf-8?B?bDRkM0YzSUJrcUlraTFGMzB6cXdXWXRkSURGdmFPdkdnclNFbFBnSVVLVGJ3?=
 =?utf-8?B?NnptNEM0Nk1obWtYZTgwM001bW1GQVFvd3FUU1VLZmZFWE51UlhibXAzT1Yw?=
 =?utf-8?B?U08rM3hRRXZnUWxadk1ZOVhhY2Iva1FtcHdPbk1lckJRMUllUTlPakVlQ3lX?=
 =?utf-8?B?RE1ybTE5VG15Y3k5VXdjeWNoQUhyUzBXZXBSMXBCWTUxdFVEclJmMWMrNSth?=
 =?utf-8?B?ZFNtQmRhMks1K3pxemdIRkNUU2VZWi9ZQWV4VFZTQktXZTZjcXRnYmpSdW9J?=
 =?utf-8?B?MHhBM0pja3REY0hDRHZKYzBvaDZLS1R6aW0yTHNXS2pGK1pQdTBzVkN6NnVS?=
 =?utf-8?B?c3JZUFVWWDVZUTBxV3ExRUg4VER3Z1MrVFJ3d3dsWmkrWG11Yk5hWGd6STZo?=
 =?utf-8?B?L05RR3hzS1J6VEtHQlI5WDBaRDduSzhiZ2pFRldVNGRjSjYxZ2hQWXh4VzNB?=
 =?utf-8?B?eThEY01jTFJOYjNzZjlxdktIREJKWXo4SU55VGFXVkVCOGcvb2JOWDlSOVFm?=
 =?utf-8?B?ZGtENzcvcW8zTmMvMTdhakVkQ1J2SVVUdDJFK0JpbVp1emVlN0lXN3M4Ylls?=
 =?utf-8?B?L0RGaUZSR1lsRzBJMHgrOVpvSWtYWXZDYWQ2OEZpd3hoNE84WW5XNExuYVQ4?=
 =?utf-8?B?Mi91OGxnZ1NWRmpHQWdnVjhUcGwzYmU3b0EveHpTOGtEU2x5a2VIUFBVSXFO?=
 =?utf-8?B?aU9PQTdkem01NEdveGVPQVYxVGNndzFrR29DcnVuMnhhZEJ3dTVuQVZnbGl0?=
 =?utf-8?B?YTA3cU13RCtab0lWU0JxTXlEZGIrNVRQNnAwYy9Yb09mTzVOTlhEbElWMENa?=
 =?utf-8?Q?hzPxCN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1RlMUkvUnZ4S2NRNysvL1VFT0tYbjNuQkI1Q3MrRURZTHRWSTFGeDdpL2tV?=
 =?utf-8?B?SGxnZ0Z2MjlIN0ZRekdXZWZaOXRKNjlnN1liZXV2aGowR285NEZ3SUdRcEFB?=
 =?utf-8?B?ckpIeU1zZkUxeEZLRFhNK3Erdms3M2pGUnJTWTR4RENycXhIQ1oyNlZLdkho?=
 =?utf-8?B?SDZzeHdlNHovYlFFNmJDYWFWQWlzUkM4NlJFNTZBNldyWVpiS01xL2NZYW5s?=
 =?utf-8?B?RVNKdk5DejFpa2RPeGhpL0NOcVoxVzNrNmdhU3dPdmc0T3FtU1dIOWx4TWYr?=
 =?utf-8?B?b0t5dExJT25MU296OWNoTXcwQVo2TG1ha1ltK0lQenBlK0Y2alRRZlRrMmhB?=
 =?utf-8?B?UlBYa0poTUduRWRrQU5Yb2RmZkxtRG80U2NGdy9Qc2ljSStVQVRoMm40NFN1?=
 =?utf-8?B?SkYraWxZbEZ3YjVPbjloWTJ1SGNIU0U0L0V2UTFiSHBMY0JXT29LMDgvTUVG?=
 =?utf-8?B?YVc2SmJFaFVrMkVzS1QzRVR6T0h2UkM1Ti9KNTV5bHdlK2kvMjFRNEhaZ2JJ?=
 =?utf-8?B?cXE0WFZIN1NkZkg0UXpyMzZ5bkxid3JSUXJMb2FlODMxSEcycHIrUE03Z0gx?=
 =?utf-8?B?Ym9Pa2c1TDkvRldSa2djUWhzSFdvRzhpYkhPeWE5VWxmNFN0MW10Nm5oVDJD?=
 =?utf-8?B?MGFiaWd4enFLdXpwdEFiUmhuVnZmcGNhWkJLMGhiNzhDZWR0cHQ3TlZ5QjBn?=
 =?utf-8?B?T00waCtLN2pRWURXYzRrNzdpS0FoMjJRQzZVclFXVno5Q3UxaTZZTmhVM2xG?=
 =?utf-8?B?ejlnM09ham5sT1BMbzJ4bUpvZjJRdWh6VHFDdDhxK0dNL044bkp4UGdNellD?=
 =?utf-8?B?Y0pKS29rQzhKNlk3QmNTb0VkZ1I3R01PazJFWUhtK3p3UjczcDlDT1orNk1a?=
 =?utf-8?B?ODNSbFk1QUpPZHRlcFVDNWJaZjZhaWdGOVdMZVF2R0txYzUvby8yR3MzQUgw?=
 =?utf-8?B?b21odHJFaFpOOUFrcGJBOFpUaVFRSWpLNnhCZGpGNkJhVVY0RTVMZStGRUc3?=
 =?utf-8?B?M2hlMFArYUJ2cUJZNTQyb0JPY0Q0Nmx5bzhuc1hlMTUvUFdyRk1RdVlUNU9s?=
 =?utf-8?B?WmpuUGFGT3pMWXIzbWU0UHJvUW40Qlgxc050ekt4d3MrRTFzYndrc3dXWkNY?=
 =?utf-8?B?OGVCVnErbnNYdCtERHYxc2ZteGUyODBIVlBCaHc5aGV0a2MvRUtvcXVqbCt3?=
 =?utf-8?B?ZXVRdE14QVR0aEJqeEpmYUg3dDA5UVhiZVRCNEgzZllETXpIbDZTL0VmSDU3?=
 =?utf-8?B?elhwdG5MUFJ4LzBDUkhDbGFHMll2NVpuaDJLaHlKWm9RTDdobUdhYUFjMUJJ?=
 =?utf-8?B?WXRDZjZjRlVVMExmRjVGc3l2VVA3YnRjRjYvVTkxN3dFUng1NWgxMndrZTgy?=
 =?utf-8?B?MFVnVFJTVThiSkI2cXluL1dteWtwOGVTdTViUURVaThIZUhDd0RFSkU2V0hj?=
 =?utf-8?B?ZjZGVTlCdC9hNWdLdFVqQU1vdTJ6WG5oNS9MeDk3YmFISXY4RVY1ODg4anVK?=
 =?utf-8?B?TGMwRVdSZERhYnpEd3VodG8rbE04dnlYblZKQys1dEErR0J1c0twcHYyOVY4?=
 =?utf-8?B?aldydDcxbFVKT2hVZzJQWUFTRllOU25vbDF5QTVkZ1hXWkl4dmJSdnlzOXFX?=
 =?utf-8?B?UVUyMHBVRWxnVTNQSEdtNkczazZqbDgvU1FVcnR4dWZSWDlTWHRMWjlodzcr?=
 =?utf-8?B?cjFqL0VJNVg4TFJ4THRvekJGTFlidC96S0drMGxRSWNzNVRkV3VIYm1CK0FD?=
 =?utf-8?B?TGxSa01CSC9TY25jWnJyUWZJcUxtTUJpeXlGVG5jTlNuUlNpWUd0N094NE91?=
 =?utf-8?B?OUVWSm5XV3k0OGJMM213TE9SeW9VVW0wOFRMRDZJMEF1QmFrRkdYREt5MzBJ?=
 =?utf-8?B?Ti9TYWJoR3o0S3FTSWlKdkxQLzdSWmJJM0JESHpZNTVvbmo5UzR5MXNrTzNL?=
 =?utf-8?B?d3o0K1FQeUo0MjVkSVk0b3Q2RE4xWGNQN29OR1IyTUdTUFNDZVNMdnF1U3FY?=
 =?utf-8?B?cWhLUkprSkpKcjAvVkNDdCtvdEVNeHFJMTU5UTVkVytFdVdhMXVXRm5FeERU?=
 =?utf-8?B?RldoVmZYWVlaVnZ2QVhPeXZLYlAwdnRzNHkreDdCRHVmS0ZMMGdzUjV4N29U?=
 =?utf-8?Q?Xt64HtAiFWTw2/iiWciUJ9LEr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb98ce9-881b-4f10-9a23-08de08a68687
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 09:14:04.9068 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 29SwzP13KHVwN3Z8pcLjULsVFRbFma3hWLc6VOIKDC00+ntwHCZ8U5PB+BrY0FdHri2+Z75o58MamkfBxJVmTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7129
X-Mailman-Approved-At: Sat, 11 Oct 2025 20:07:05 +0200
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

From: Frank Li <Frank.Li@nxp.com>

After update this, uuu(>1.6) can use below command to filter out devices
when multi boards connected.

uuu -ms <serial#> ...
[sudo] uuu -lsusb can list known devices with serial# informaiton.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/mach-imx/spl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-imx/spl.c b/arch/arm/mach-imx/spl.c
index 518d9cb1262..d4ede46b751 100644
--- a/arch/arm/mach-imx/spl.c
+++ b/arch/arm/mach-imx/spl.c
@@ -21,6 +21,8 @@
 #include <g_dnl.h>
 #include <linux/libfdt.h>
 #include <memalign.h>
+#include <asm/setup.h>
+#include <asm/bootm.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -184,6 +186,14 @@ u32 spl_boot_device(void)
 #ifdef CONFIG_SPL_USB_GADGET
 int g_dnl_bind_fixup(struct usb_device_descriptor *dev, const char *name)
 {
+#ifdef CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG
+	struct tag_serialnr serialnr;
+	char serial_string[0x21] = {0};
+
+	get_board_serial(&serialnr);
+	snprintf(serial_string, sizeof(serial_string), "%08x%08x", serialnr.high, serialnr.low);
+	g_dnl_set_serialnumber(serial_string);
+#endif
 	put_unaligned(CONFIG_USB_GADGET_PRODUCT_NUM + 0xfff, &dev->idProduct);
 
 	return 0;

-- 
2.43.0

