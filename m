Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B094D185F8
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 13:36:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3F77841F4;
	Thu,  8 Jan 2026 14:33:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="LwOgrr/x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE5CC83A26; Thu,  8 Jan 2026 10:53:11 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DDC6840CC
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 10:53:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lMFHFQHg2im9KAcGf54yJcToeZMU4GogPWdNIAvkuJdKUb1AsgOXtHzXHPX7IQGjGeIVP2HJ/PuTGZxAt+9RXZWaAj9esysTtdqRf/cQHWbMia2n2/u6l/ginCQJtDviMrhDJYbVl4GNYyAsl/d3Cpy2TyovP3nH+0RnaZMBAuS8jBFapiQZ36KBMah36b3djBSU/gQ7FVSG8tvO+jIOOIKN3+VAl7G/33bEtvzmlinfr7BolRqZYtGjyaNb2XShEdlCltpNAWWzWMOIh/LaRYQC5smLv7KkXsKNoG0tPDNkQhUS2SbaPQEACfbkoJlJZY4l8noKoTsN0sVMta2b6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5iAy0JRyYGkBpMBbgeJDMxftyKH3C4asYxVIX/ESTjI=;
 b=i1nNKe2OQ+NO6vDAeABuWU80ZFaei/n5/u2hPWCW77ma7y/o2oS81EsbLt1gqdoySlyuiZ1t3VabkQ6nVS0RC2o8l0/h1aG0MKq9Ozw4F0sAXTcB0kOF6mHlQFJuXAuB/95n58dA4mw1a21E1NWZvFOpgjl1dP6JMd1vlFeR2/r8Il7zKr7uEgrXGEYQvzr906ikofvVR9HGgY0VQqfUxRY3oW37ihNNVrBadjOaUojq234vDUHRFnE9FtnxwNx0LplXmbAN5+s0JkvxkiD4SfdI0O9eMjrDJpjWzdv7HBmXdrqausQUHDNN6Pt9InOEjc0I5UWN6pXiT5K44YcCfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5iAy0JRyYGkBpMBbgeJDMxftyKH3C4asYxVIX/ESTjI=;
 b=LwOgrr/x7KupJ0Xy6YDc3b7ullj784q75B24CndCb1H32vlIJaFfr8jOJzlwVD8AXZSYneTU5+BPz/L+x3ANT4vEcQiRMR2NzHzgYSNdsnyEieHMwq9HtbwvnMSKNAtPhucDQi7s7v10bIM+HtCPhBoVJpONDEM+NKhegY66VVaQFvkvqvdRDjZIyoHyc7SWpNnT3LfXJ9J/wnFk3fo/PnCzFxzyn1w6RgzUBteEf/TzQnF9yQelwrv6W3DqHi1md6sPW9m5RkaFLyor7qnTvR80wYEzMMmw3oVidgZOUUvHd+nzsJOyAOgZTEJRA0hu5q8Hj/oMbwH7uQY4gi8afw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by GV2PR04MB11681.eurprd04.prod.outlook.com (2603:10a6:150:2a7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 09:53:03 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:53:03 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 08 Jan 2026 19:06:51 +0800
Subject: [PATCH 06/13] imx93_qsb: Cleanup headers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-imx-update-v1-6-0d5921c575bb@nxp.com>
References: <20260108-imx-update-v1-0-0d5921c575bb@nxp.com>
In-Reply-To: <20260108-imx-update-v1-0-0d5921c575bb@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2P153CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::12) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|GV2PR04MB11681:EE_
X-MS-Office365-Filtering-Correlation-Id: 030d15ef-4e7c-486c-12eb-08de4e9bb725
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c3Q0RkRHM1pvRXlEM3ViNkdLZkVpVkk5OExBY1dqKy8xT2xCUU1JdnhleENW?=
 =?utf-8?B?eUtwcDhENFlIblNVMDU5QkNwM1ZRNHVSZlU3bGxQWEkxb3NabDE0eVhBWjB1?=
 =?utf-8?B?ck1UbE1VZjR6VUpQcUJQb2tkdEs4bXdQR0x0OWYzRVdBbldReE0zemRYUFpF?=
 =?utf-8?B?TldtVzJJZ0JOWkhTMG9CT2FNdmxsVDZLQmY1RTBMc3lZcEN5K1IzamxBWWsz?=
 =?utf-8?B?QnN3YkFhbkZ5SFhyelZ4cEZJdXJRMWhTcURKNFgzN2FkR1I5WjkySWs1Nmdw?=
 =?utf-8?B?SWhuUEtyZGVIZzBYR1lleVFmcFFjUkFLNEtBV0M4cldqUzI4cSt6SlV2b0xw?=
 =?utf-8?B?MmVTNS82YmhsZ0JXd3FRZUdhdzUzNUlNL1gxMWsrSWx6RkRseUFEaXZkeU9R?=
 =?utf-8?B?eVNJU2RFdjNDM0pqREZ4T2VOS2dCRTJlL0RvRkJqMlNmZTN6ektGdGlKMzFT?=
 =?utf-8?B?RWZtRUlKZlVrdGtnTHBydno2bWFOWklRSFU3Q1NneTFkOHNqY0R5bUFSNjlz?=
 =?utf-8?B?eXJCeklUL0w5OHl3THVHU3RGbXY0dU9GZ295RlVCTzV1Wm9NRVdoTjJoenAw?=
 =?utf-8?B?bE03YjlnZ05Qdm9ONnIyL3RkQWlmMGFscmF2bjRyaDRzN2pnUTZuVXVUbXVo?=
 =?utf-8?B?NnBWYXFEOWFDMFJjMWtRTmoyQU1oajlzbW9Vd0F1WHYvS25IcElPYVdhZUNl?=
 =?utf-8?B?UklJcXBwbnBRWnRIVzJjMnE2VEcxemRXTlhhZzduNTYxalM5OWZzalE2UnZC?=
 =?utf-8?B?MkxRNFYrbU1tdk04eFVCdkgzUlM3MXNlR1NtYnltTzNXZ2FtWThxUEdpZ2dY?=
 =?utf-8?B?dlZETXRQY0tudStpMXd5TC9DYStmSXpqeXpYV1cwNFUrWWNCVXFXZlRteWkx?=
 =?utf-8?B?QjFZN1lYUzJVNmY1YkVUaFgrUTN6TGx2QUtveUlMWTNBdnMreWwvdGVEeWRX?=
 =?utf-8?B?Y1NFaDZjSU5SN0kzSVliTTNrK2grS0ltbTZsUkRaZTFhZStabnR5UFhWMFE1?=
 =?utf-8?B?dWpLdlh5QXhMK2w2M0FVMDFqYzAwU0lKc295elNsNHlrdjd3amYwNnFqMkFh?=
 =?utf-8?B?eWZpZm5ReUxWcjZiYXQ5WEtKNUcyejlHVHlLV1hkNFAzc3VLUmRRMHdBamdj?=
 =?utf-8?B?aGpma01Nd1NBYUExUDA5S2R5c2Ztb3lLYUYzeThMTmpkbG1WVWpSNnNhOU5l?=
 =?utf-8?B?VVY2aktMTldCNDRjWUdtSjVPQW0xemFOUytqUmxpMHh1YmRXRkxCRUhLRnQ1?=
 =?utf-8?B?aUgxOE03NXd0alY4V2FsYXVJR0w4c3FuRkZaZXFsdXFRWmE1Z21ZaWhrV0Fp?=
 =?utf-8?B?MTlkZGdmeEl5U2pKLzFmYzM4enRPVVBORHUxTCs3ZVVMWVpzUWF4M0JQeDNi?=
 =?utf-8?B?Y0xMWEM5NC9oMEd1YU1nK0p4aFRMRHZ0NjdnelFacFJCMEtyNXVJdGRQWllK?=
 =?utf-8?B?NVREY1ZPYTVpckh5WDMzYWdSbUl4Ui9DU251aDNSM0U5eDg5NGZpL2RGL3Bh?=
 =?utf-8?B?YzFCMEExWnREOUppUHV3U1dWdGtKbUF5VmRiaVZnNWhhRjhjcDllNW9UNGdk?=
 =?utf-8?B?eFVCR2NFUW10MVVJWUNIUEpjSEUyYTR0WEpiWTByQTRYeVRyRk1VbUdrWXB4?=
 =?utf-8?B?T0VRR0xJcGY5OVQrWFJacVVuUytBcHU1ZWRmcGJoVUU1UzE2L1hzbXNxRWM1?=
 =?utf-8?B?MEFxUDFDeXZpTUJvWXN4YkdLM25ab0tBVHRWdW0yR0piNmlQZmZWNkkramxy?=
 =?utf-8?B?VGo3TmFaYlZmUldBNWduOTg4eTdSbXo4VnpkNnpRQzlMQjhjWXpIVjRLZGNY?=
 =?utf-8?B?UlJsNndVZTBCTW92OVBZdG5nN2owYUR4N2U2UEFFRFhCWk05aDlPb0Qvekpa?=
 =?utf-8?B?OVhNeXNvdGdFREFJZmZ4YmI2YXBNc0FKbkc2bitUZzRKSW1NUEJHd2c0U2dI?=
 =?utf-8?B?UWlHUGd1a1AvL1QxTzNVRUUyN1ZUbWJrdlZuNjMwdFlHejVVMml2NklVbWZh?=
 =?utf-8?B?WkJYSU5XN0F0U0JyVkJCOElQQ3pRKytaRk04eE1pTE9CWmJhK0xNbVp1djAv?=
 =?utf-8?Q?mRSnhp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmg5eGNBWHp0V1puY2xGNTlTRFFYdGs5aVVxWE12K0FyNkRKZEwwUCthaFZG?=
 =?utf-8?B?cWxrZ1VVQkZHMFBaaGFydU5nNmxqd2pLQnpaQmZybFY5TnJYWEhUSmUwTHZz?=
 =?utf-8?B?SUNRQmhKQzJJK3BKckRPTDFUcGY5NzJ4aTR5VEg1cTJEOUI0VVFjVE9rN2VF?=
 =?utf-8?B?R2QyVDM0bWF2R0xhaVJ0Y3ZWU204Z0NwcGh0dVUyaDJ4UDhBanZtYmxobWY1?=
 =?utf-8?B?cnF3WlAxMXRmelNkSUw2NGIwRHh0TTM5SWhSUURrQzRXeStua0N3V2ZXMzFw?=
 =?utf-8?B?Si9ZWXFrMzVrdFkzZHRZRDZrOXRoRndOOS9kMVBCVm5JeXMvS1N0ZHBBSmh0?=
 =?utf-8?B?Qi8wd0RUMWhya3VuNVIwaEEyTExlR2pJSkZVNkUyWlpvcEZaWE9pM1VMV0RS?=
 =?utf-8?B?TC8wUXNZdVJLdlV1ekkxZkxsbE1rMm9iWE42VmJRSTFHb2txaHY4YWxvMUpJ?=
 =?utf-8?B?b1ppU2VZRXcwS1Q3UngwME1KUFBwaTk3aXhmVlhXb1hMOVh6K2o5elFWTyt6?=
 =?utf-8?B?S2VodVNMMTg3ZXlzZnRHSERQMTBna3UyU3dYOVZvcjQ3cDNSWVZPWHU1QVhm?=
 =?utf-8?B?Zys5aVplWnRWRVp6aGRHT2hBdGFmenBWTHJoYVAyYW5WNW1UN3o2K0poU0F6?=
 =?utf-8?B?UnlHVGlpbTBJSkZIM082Q2haVW95c25xNEVWeFdjSFRoWHVkNUhUZUd2bUlh?=
 =?utf-8?B?emxhMnRmZ0xaYm5qV3F3OExIdXp0RFR3NDJPMzF5M0ZsSjZFNWtaVnFkS0R1?=
 =?utf-8?B?alg2a2oxNU5DYjZDclBlalVLUXd4Z2hjMmVWUGprNDVnY2ZxVTRqMWFLblpP?=
 =?utf-8?B?Q1lnOXRQVWdvQmZpNnNXNmh0cHFaazVIRHpPVDZBQ1lmZ0JHUWw3MW43empE?=
 =?utf-8?B?SndVL1pwRXFTekZmK1drbHd5ckdUT3dtNTdERkFGS01mTmkxNkJiWmp2REN5?=
 =?utf-8?B?R0k1TzZQTnpjTW1JQmUxc3RqUERJa2FMQ214VUtYdjZ1S2tjemhBYm1uNFlW?=
 =?utf-8?B?TU9LelBUb2N0K3I3dy83OVZZeHRJNzNTbnR6SS9IUU5zN2pJWllRL3RnRjZ3?=
 =?utf-8?B?eXBKL3hoM1VYaUFRZ2MwZ3NHaVovbkY0OVo1RmRyaG1pTU5OZVZNZFdyUXBC?=
 =?utf-8?B?bmVad0VLUmlSY3UvRE1XS0UyVGoxOVJRUm9EclAza0N3ZjBWdCtFakpsTUJz?=
 =?utf-8?B?TnRIb2hhM3Jra3hsVjBnckFvNDBZYW4yRmZEdlBOTXY3NllHNndlVzhXc2tU?=
 =?utf-8?B?czRwaEhEVGNZcm5xa2FWKzJuMUdCVU5LUUNVemRQRzNiTnpCYktpVENDWEs5?=
 =?utf-8?B?MlFPayt6SFhoaUN5c1RKRFhCVVdsLzRxVjE1M1hmNDRHVkdsSUVGRkkxZThZ?=
 =?utf-8?B?WWJaaEtIQ2VRY2YzZ1gxV1gvYlNkOUREV3dPcUdVMWFNY1U4U2hicE8vQU5M?=
 =?utf-8?B?TDlDVnUzS1YwaFpHT0llMllwb0tOT3h5ZHdPZUtXUDJwNEM2VXY2cHN6Z0Vt?=
 =?utf-8?B?QUc4aS9rQjVMZ09tbUhGV1orZjV1TXI4NTAyb0hJK3l5RlFEVStqb1hrQllh?=
 =?utf-8?B?KzVDWWZ3a3RqNmdNb0ZyMjhJdTl2SytkMU81OHp4OFI4T1ptOXQxM2ViYVFy?=
 =?utf-8?B?d04vWnJjbXE2dmx4RHM5NVdUc3pvWHBGOEtKTElOZTlxejU3T1hydCt3LzEx?=
 =?utf-8?B?cHBJNGV2dk1pNGhUcnlEQ2RmQWJLRVFsMllyYW05YmpjSzlsK1F2OTRMeGlV?=
 =?utf-8?B?RXFCZWNuV1I5S0tzRnJ6RHlHYkFwNmlRQ3orVDhUaFYyMGRkNGg5bkRKTmhv?=
 =?utf-8?B?WmlwbzV0VVh0eHpzdGloc2VkV2hPWjI5bmd3K20rK015NnJIZkpSakJzUGpx?=
 =?utf-8?B?Z2ZhZXZqb1BXWGo1UmRQYXVkQmJjNTZDTkRzWHpQUmQxY3JBTmFBS01sVkZB?=
 =?utf-8?B?bUgwUUMrR0l1Q2kzdm1CNlhpak5sZm1XWDV3YXNmTy9HUGkvOU1wL1BEVE42?=
 =?utf-8?B?WnFhUWZWM2Z5YWxqdWtKbGg3dGQvb3FnTkRnU3YyOURWODlkQzBSNlVJbmpj?=
 =?utf-8?B?eVcwVXcxRElQWCtXbFVVUnpVc3Y2ZFVOOTZEeVN4c3FKc1JCUGg2alVKYVdK?=
 =?utf-8?B?Ym1leDJDS0NuN3BMTE5NVmNVUzVoNjJKOGNLQTBUTVkrNGIzSWNUUUtRQjBU?=
 =?utf-8?B?Z3hwNEcyMXF5WDY4SDFGU2tWS0lyZXZEa2Y0cHl1NHQrVS80WE5tUWJjdTdP?=
 =?utf-8?B?OHBPS3plWEE1eEZKZDdEbkFyVXZaWno0UnUrRE1kTkM0SWEvMTVJNnUxRmtK?=
 =?utf-8?B?WExpOCttUVRxYzQ5SkpMMGVpU1cxNTZnb0wvSVNvZkFQU0EzQXRqZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 030d15ef-4e7c-486c-12eb-08de4e9bb725
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:53:03.3944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +GLZvp542FGZ2c6N4ehAX2CvpvpBdXp80ChjXA3/Ro1jJbD2Qmo14KFLQA+0yf8O9YjED7lBlIf7+GcOhGrSBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11681
X-Mailman-Approved-At: Thu, 08 Jan 2026 14:33:28 +0100
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

Drop unused headers and sort them.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx93_qsb/imx93_qsb.c |  2 --
 board/freescale/imx93_qsb/spl.c       | 29 ++++++-----------------------
 2 files changed, 6 insertions(+), 25 deletions(-)

diff --git a/board/freescale/imx93_qsb/imx93_qsb.c b/board/freescale/imx93_qsb/imx93_qsb.c
index 503a8667245..9de91758aa7 100644
--- a/board/freescale/imx93_qsb/imx93_qsb.c
+++ b/board/freescale/imx93_qsb/imx93_qsb.c
@@ -5,8 +5,6 @@
 
 #include <env.h>
 #include <init.h>
-#include <miiphy.h>
-#include <netdev.h>
 #include <asm/arch/sys_proto.h>
 
 int board_late_init(void)
diff --git a/board/freescale/imx93_qsb/spl.c b/board/freescale/imx93_qsb/spl.c
index 6d1ab60eda0..7d0f225c9b5 100644
--- a/board/freescale/imx93_qsb/spl.c
+++ b/board/freescale/imx93_qsb/spl.c
@@ -3,36 +3,19 @@
  * Copyright 2024 NXP
  */
 
-#include <command.h>
-#include <cpu_func.h>
-#include <hang.h>
-#include <image.h>
 #include <init.h>
-#include <log.h>
+#include <power/pmic.h>
+#include <power/pca9450.h>
 #include <spl.h>
 #include <asm/global_data.h>
-#include <asm/io.h>
-#include <asm/arch/imx93_pins.h>
-#include <asm/arch/mu.h>
-#include <asm/arch/clock.h>
-#include <asm/arch/sys_proto.h>
-#include <asm/mach-imx/boot_mode.h>
-#include <asm/mach-imx/mxc_i2c.h>
-#include <asm/arch-mx7ulp/gpio.h>
-#include <asm/mach-imx/ele_api.h>
-#include <asm/mach-imx/syscounter.h>
 #include <asm/sections.h>
-#include <dm/uclass.h>
-#include <dm/device.h>
-#include <dm/uclass-internal.h>
-#include <dm/device-internal.h>
-#include <linux/delay.h>
 #include <asm/arch/clock.h>
-#include <asm/arch/ccm_regs.h>
 #include <asm/arch/ddr.h>
-#include <power/pmic.h>
-#include <power/pca9450.h>
+#include <asm/arch/mu.h>
+#include <asm/arch/sys_proto.h>
 #include <asm/arch/trdc.h>
+#include <asm/mach-imx/boot_mode.h>
+#include <asm/mach-imx/ele_api.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 

-- 
2.51.0

