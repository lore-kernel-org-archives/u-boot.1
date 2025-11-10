Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F33CCFA1A
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 02:19:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DED1083990;
	Mon, 10 Nov 2025 03:19:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UJgmQzgl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 003108399B; Mon, 10 Nov 2025 03:19:30 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02C1A8398D
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 03:19:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jA56HmmDbrGH+sv8mdeUJOoCk3YtuWmNDSZdsEb/1HBv9fT0Q9ow+8m8Fd/3r2mPkAa/jjF/216TH6zu+uKehwcnsiMtCTFeLXQl/GWcpWDv5H02JtLViBdsOaU3rmoppfSxpISyTRptD1tlIGjAVj8T1j0JXtYbNgb+1wWZU+X4r/vs6gIN+BoxpwEYmgAEKDfqC8cw8eWZggzn8c2lUx1jM95QnTM0uw8+7kuQiG13D1t3tlIsXDzEU2UDhCQ6Ie/5Q2kzXKeQ5LrNT6HwO5vm2oC6HzjNHWexKQqRI8EYuBqhn8/DOWKkmcF+XgNy4TLPJzhblk0tiWJtlEkCPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+XBvQ0eQuxf4Zx5urwvXp1qbpkVnV+Nf8zIcUz8gVI=;
 b=n+c8G2L0xq5iQyTjyrJ16NbY7enu8AvB2qEYyJGKXqPuzNXIqnSWmD98WZ4Jzd2i5oRhb8Ucvu4Dvj7TbNBMQI7Hy6cSNIzNZ+0SLpbiaICaNDztMohxvsxDNjo/PPCCzu10Ks2wO8sBBad1W2UI1LGFnbx+BQzQSUdhg3XdkfC951ehbUPBaxSWKvUUpTe/xYgAkb3uDbx6yNjfgA0TFMzYnNRDnz0ENXGZBzC1FaqDvQPlDxeRRjenB6MCoahjb0TX5TTP/aSv4xgNvzMd5S26c+wMsocvbRrE+Nhg/kNvtT7EKMtLUaJviwQAFbbvcRGF7U37JgqOPeLKvFsRpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+XBvQ0eQuxf4Zx5urwvXp1qbpkVnV+Nf8zIcUz8gVI=;
 b=UJgmQzglLmnJ8FQ7fQgH1G8ytNowXbmYmSdMS1Izo0ScxbDL7A093Eur+ae1eAo/BBQ0Sp1AOjenRki12LRbzmMg9y1UHKfIqxthRWWE7bfeVjqR1A8E2ZqLTpIksrRzdDWdyE5Y9ImtkBk1e0LM7/9fSCsxMQWu+0EhFddpEFXRMZpWZC/3A1qWtpp0/YUj92esfyl4SNCVLpH+2pMwixTdYGvcAShUI5s0ueyoUihV7I1hYi/z2nsLm5Po0EgsOgIJtJrT9P0T9s2+vfap2bFoc2b4/TH/3uC68Qqx4LGzlOsSBj2M0Ust0Qlc/b/VL5ZS1XpmTB4Vso1joNlBqw==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV4PR04MB11943.eurprd04.prod.outlook.com (2603:10a6:150:2e6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 02:19:25 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 02:19:24 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marek.vasut@mailbox.org>, "Alice Guo (OSS)"
 <alice.guo@oss.nxp.com>, dl-uboot-imx <uboot-imx@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Alice Guo
 <alice.guo@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIGJvYXJkOiBueHA6IFJlbmFtZSBib2FyZCBkaXJl?=
 =?utf-8?Q?ctory_from_board/freescale_to_board/nxp?=
Thread-Topic: [PATCH] board: nxp: Rename board directory from board/freescale
 to board/nxp
Thread-Index: AQHcUehutKDsjPPn90SajRU1ReEJ3g==
Date: Mon, 10 Nov 2025 02:19:24 +0000
Message-ID: <PAXPR04MB9644BBF3EE6675452285279BE2CEA@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20251108-nxp-v1-1-6169a1692ff4@nxp.com>
 <20ca3866-29e9-42c6-9224-a33c15034b9e@mailbox.org>
In-Reply-To: <20ca3866-29e9-42c6-9224-a33c15034b9e@mailbox.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|GV4PR04MB11943:EE_
x-ms-office365-filtering-correlation-id: 9238efd7-2049-4682-9a28-08de1fff914d
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|19092799006|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?Ukhib2FXeG5SV0FvRnNsd01IUTlwY1Eyd2E4dE5CcFV0YnB3cUNtc2JuMEFp?=
 =?utf-8?B?UmJCSTQzdXh4bGRKMm8xalNFa2FXRVl4RVd5bTR1MjltZ1Z1VkZjdE5VZnpr?=
 =?utf-8?B?a1QvSXNrMGI4cXQ2dy9vZjZPQW5IQzVzbzhNRHkvY0FLRTczSHFlaFI0Unhu?=
 =?utf-8?B?RzJIMGlUSUsvdWpoQVkyMjFOMzJkenhCTTNIWHJOUTR2U09HZ3BuVEdWTXBh?=
 =?utf-8?B?VlpzUkZtTVN3em0rbTR3MENMbFhyRnI1VUFIM1QycHQzL1ZwSTgwSFViTThr?=
 =?utf-8?B?Q1RSczdDWm80QzRadFBLMWRKT29MQjFtend0M3BpUSs3M2RlLzNQMW1QSnd0?=
 =?utf-8?B?bHljYUxKT0xoUGYvb2x2bTZKbzNxWW1HWVVXT0FKNHFpaFIvYkY2bGNKTWRG?=
 =?utf-8?B?UWRkTDNYRGZNa1BubzBDcHBmbmJuc1c4Sld0aTJnOFVGaHdRMElVMXFiWXRH?=
 =?utf-8?B?R3V5eVIwdzFiR25sQ3liSjR1UFg5dGw1OUxKdU1KM1VPWVRmNjRKTDlhMm03?=
 =?utf-8?B?REwwTjRoTkpKSWJBeHNQTTlON3VKUno5ME8zOE1JTFRXM0t4SVVLZHRrV0hi?=
 =?utf-8?B?b3BCaWg1QWhKUFhHSVdjeGhKbU01Tkg1UCtDczl2L1NGMXJzV1BGQlp0NFdK?=
 =?utf-8?B?SVA2aG9KbExDRlFWZFgrdjh0MzVDMjFWdm9YZjVIOWN2UVFXSnJLK0djS0tw?=
 =?utf-8?B?RTg5UE12NnNpMDM3R3owRUt2K0YrUmFLWWJBQk1lcWxPdy9Qd3RHdE84K05O?=
 =?utf-8?B?UFFIUzZ3cURoeU5BSjR1YVh2alJKTlBuNHg1bzNjMTFGc0VtdmxYVmdkUm1G?=
 =?utf-8?B?VDU4R0djZ25TM3dQU0pzQ29rL2JTLzZIdnhjbUtMTysxZnAzVFE3ZXVjbDBM?=
 =?utf-8?B?UW85Z1N0NDZXZ2NCa0FMT0VCNVdjeUU3clRhR0Q2amR1NEw0MnJFeUhuYjRJ?=
 =?utf-8?B?T3J4VzhManE3eHlYd0o3QWNSNjdLL0diR2FMclFPYThTRUd6TWVldWtiZDRs?=
 =?utf-8?B?am51MVhQM2ErQkozblV5K2xwN2FJT2dXN3ZUdmFmZHM5QTFmalRGUEIrM3hG?=
 =?utf-8?B?bWx0NEdhTFZEeFhDMDNldHlFZ0srMW56OXRkOUoydEFBb2R0TUo4YUk1YnJU?=
 =?utf-8?B?bXNTcnBiaVZCb1lXN1psOGQyM2RlbWpUalN2WWt4R0gzeFlIazYzN1BBekly?=
 =?utf-8?B?SUVpRW42OW9sazFRK2ZiTXVEdFFMRlFxREtuMHl3RlZiQ3FoOUgwY0hsRjVz?=
 =?utf-8?B?aGFYQjM0R2EzcVlhM2xSTEJBSGtZUTE0SlE3UHJob3BiMS9UY1BuSVNSWUxz?=
 =?utf-8?B?TmdqbExUM05lT2JnWU85T1dyYmxEMEx4b3pVYWkrZEtuSTZBWXVxZDVEWG92?=
 =?utf-8?B?NVR0OVJQYXgwRGpUUko0SG9YU0FORlp5QkYwUUJXZitnWk45U1F5Y3FQbEcw?=
 =?utf-8?B?OWlCeC9JSjdNMVhla1hMa0M3K1dHanNpc3I3aXUvazl5ZEtLZGNKbGliTmVI?=
 =?utf-8?B?VzJXdGxsWGxsNTdQRDJITHJjSjFpbS91V3g1MGpUbHhVVzVYSURqZDJ0TGd0?=
 =?utf-8?B?UnRqdmRjbktDTnJ6NVJibUtOQTBnUHowNTMxaHJZZ1VGNVY1MlNyTnpDc3BE?=
 =?utf-8?B?ZlVVU0FYRitFRTZNUnlXanRZaHVXbmdPY1JMS0p0Y0ZIZmI5UjVyM0pYelJz?=
 =?utf-8?B?VGk0c3VSRUg4b3FacWdrbkZjQm9Ialo0aW1nVjd6VkFtNExUWkw0MTcrdmVH?=
 =?utf-8?B?QTZvTHZtRGp0N3BSS3pLV1VqYUl4WmZuT1pXN2kzWlJxTzZMdVF0QzNQY3Ew?=
 =?utf-8?B?Vzh4Zk5DcWpKQUhTM1BrUUtlSEhUTTNBUW5ZVG5TditySjdUNlh0NmgvemYx?=
 =?utf-8?B?dUtnZ2V2SDhJWlR5V3ZCV0hwRnFucS9hcUJlc3hXMm5JNzFmSk8wTXZMYkNF?=
 =?utf-8?B?NGxjUXRzWmF6UzJManZ4Q0g1S05yYkpYRGQ5TnZudDN1VWNieFBDbUM2L1FF?=
 =?utf-8?B?d3BPQWZBcE1RTHF4d0M4OHpTeCtVVmM5azBZTUE2NXJrdFJZRVdWMnVSdCtr?=
 =?utf-8?Q?bC+sEQ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vjk4eHZaOHEzWXF3QVgwTHVOQTJPTFdvRVhEWFhOVHhIZ1NTM0htamVCSk5Q?=
 =?utf-8?B?S0tIZHBVZHREYUJHU2MvSVhkWjhBMkFzS1dBTlBuYUhjb2hwdjFtcGtFd2Rn?=
 =?utf-8?B?ZXM3ZFZqNFBoMWs1cGVuWVZ4MEVwSng2SWZhbGtIN2hzekIrSU1qd3VNc3Vx?=
 =?utf-8?B?T2p1anhMd1RxazFidkczeng2bHBDZDVRNCtyaEk3WE16MDZEazRZK2VKdndH?=
 =?utf-8?B?YitKeEk1d3JzODNncVJ3VEpsWjZqNVZicWdRL0d6N05LaGpGRVhJbUFKLzh0?=
 =?utf-8?B?SVM3dmZWRzBMdUtsR1RDNWY3MU5kNjJzQ1RpZE1zNDg2QW5wOStFOE5OVWRH?=
 =?utf-8?B?UXhjbEhRbjgvckp3UGJLeVNyYXFZc1RTcFJ0cStyVVU2K0xrbHFoR2dxSzhB?=
 =?utf-8?B?M0ROZWI5YkVyVWpCR2hlaVNYR3RZSnlTRnMyWkYwZU00dENQdG1NVitCOFA4?=
 =?utf-8?B?RzIvTmlLL3o5MmhUanphMUR1TWt4S2lVTGttbDVreDNmbDVSeFJXWmZ2SDBR?=
 =?utf-8?B?UVcrTVZIM2V4M2F6RnZtU3doWTFLZVRGM0F4Uk13ZHp0OXpuNlRXYlJTQnhs?=
 =?utf-8?B?NFh3WEY0UnNGbzBCL3VMVVh4N05pT29jNW01SWJ2NU1SaGN5ZkRabFRhNTBU?=
 =?utf-8?B?VVMzNGxwNjUrVmt4MjNGVWdlT20zYjNmS2xpV2RuaEI1UkpMUXdiYWFSdjJW?=
 =?utf-8?B?Vk0vUU1EMkgrdjhHMVpsWnczTDVNYVk0Sm15Z3orYnpwOUlTMUZMTTBseCtT?=
 =?utf-8?B?bVUrREgyUVp6QXN1MW1va1JHVmI5MjhVVVNyaS9NWjVnVnpvM29QbmplT00y?=
 =?utf-8?B?UXgrQ09xN0ZWSlV4amF4N1RDTUtKZXl6MW4rbWVwS3J5czQwbU14VWtlUGRl?=
 =?utf-8?B?cVFHajFXN0FMS1JXVGQvckFNQlZBOXR0MnFHVWtDOStrUjd5eGtVV2VZWWZF?=
 =?utf-8?B?V3BSUmhTOUF3ZkR3MGZ4Z2UyYjlrMDBiSEZQWlpvVUhncEJLZU5URlV5VWNh?=
 =?utf-8?B?cmc4eHRUOU9qUGVWL2JHdjBIdE9DQStPcmdkQTN2RDEraHBtODF1M05vM0ho?=
 =?utf-8?B?ZlhoWnYrNnpIV0F3QkViTnlab3pMd0FyaHNncDYzdUEvUUJ5ZjU4enp3bXFj?=
 =?utf-8?B?ajNjTjlkbFBVK1pudWRtMUZRVk5yTnV5YlRvT213WW56dGxwc2tHYU5obnZv?=
 =?utf-8?B?OW84aENaNlVmWFBPU2h5TnNDUDlxQVpEYWN0a2Z5SU04cUo5MHJoTjdTbXMw?=
 =?utf-8?B?dEpuVVk5d0lrZlZtRmtkcW95Z0NtbjFtU1ZqVHVEblBqYXNRdUJXOU1Gekxp?=
 =?utf-8?B?TUxLMmthdWdhYzBVYXRmYUVQR0EreU1XZG9idHl3NDcraHJMeDQyTmdZNWJj?=
 =?utf-8?B?dERnb0xTZDhkKy9oSzNXdkZBTlJFVy80VE8wOFd3U0ROYlhCTTRTUmx3TFJ4?=
 =?utf-8?B?UGtyWnBlczZ5S3FZK2VuYkpscjdaWEZNM3hsQ1JZaFYwVXdOWXR2ck16VDRI?=
 =?utf-8?B?dHRwbTcydGxEN20yZ05VV3A1L1dBalpLUjV0ZUhrYXZ3KzV2ZlExM2VSeCtm?=
 =?utf-8?B?M1VQWDd1YmVyYzNhbEpjaVA5cVJmVWdBVDl1ZWlFcVp6VVdaczMwRmcyYXl5?=
 =?utf-8?B?N2J3WEZjK08waVJjVllvZGd1VGlNdXNhU000SUVTdG9TZEFtcHRWNk5kTDMr?=
 =?utf-8?B?ME9Hek4zY1RPaENpVDA5VDc2ZXI0VVFWT3RCU2ZLS3F3UTV4clIvQ3UrbFBu?=
 =?utf-8?B?cENOU1ZrT2FZMCtYVEpUcndNSDZWRG1yS3BJcjM4a1dqczhKS3hYK1JEQTNO?=
 =?utf-8?B?WEhVN0I5NkcyUkRoVlFlcFJBTDh3Tk5qM21vOU5acWZRT01pTFg0QVAvQjV2?=
 =?utf-8?B?ZTY5bUFGYXlGaS95VUZJdzEwMXgzSm9qUXJhUHNjQmJ2Wk5STzFwdkVWSXRT?=
 =?utf-8?B?Y2YwNE5reDAvRjNxYW9iRlZSaXhlVVUrL2srOVZlQjBXbGcrY3FyWktWSDBh?=
 =?utf-8?B?QjF4d0k0VSsrVi9uMUttRmRBSmRiUFZGMm9la01SV2lWU2Y5TWZoMFJ2b0hH?=
 =?utf-8?B?NEdYYnV5ZnN0QktWWlpSUyt6VUNpTi91elpiemV6SmhzRUV6RzRDaEx0WUhh?=
 =?utf-8?Q?tnno=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9238efd7-2049-4682-9a28-08de1fff914d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2025 02:19:24.7556 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qs95K/BBM8yoMt9g/RV4EDwndVCnEDO8UmwRh2c/pLc6bJPn3A+17DANvPFHdVwPlJeMupmwDKk6Qq0i7EqkVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11943
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogTWFyZWsgVmFzdXQgPG1hcmVr
LnZhc3V0QG1haWxib3gub3JnPg0KPiDlj5HpgIHml7bpl7Q6IDIwMjXlubQxMeaciDjml6UgOTow
OQ0KPiDmlLbku7bkuro6IEFsaWNlIEd1byAoT1NTKSA8YWxpY2UuZ3VvQG9zcy5ueHAuY29tPjsg
ZGwtdWJvb3QtaW14DQo+IDx1Ym9vdC1pbXhAbnhwLmNvbT47IHUtYm9vdEBsaXN0cy5kZW54LmRl
DQo+IOaKhOmAgTogVG9tIFJpbmkgPHRyaW5pQGtvbnN1bGtvLmNvbT47IFBlbmcgRmFuIDxwZW5n
LmZhbkBueHAuY29tPjsgQWxpY2UNCj4gR3VvIDxhbGljZS5ndW9AbnhwLmNvbT4NCj4g5Li76aKY
OiBSZTogW1BBVENIXSBib2FyZDogbnhwOiBSZW5hbWUgYm9hcmQgZGlyZWN0b3J5IGZyb20gYm9h
cmQvZnJlZXNjYWxlIHRvDQo+IGJvYXJkL254cA0KPiANCj4gT24gMTEvOC8yNSAxOjU5IEFNLCBh
bGljZS5ndW9Ab3NzLm54cC5jb20gd3JvdGU6DQo+IA0KPiBIZWxsbyBBbGljZSwNCj4gDQo+ID4g
VGhpcyBwYXRjaCByZW5hbWVzIHRoZSBib2FyZCBkaXJlY3RvcnkgZnJvbSBib2FyZC9mcmVlc2Nh
bGUgdG8NCj4gPiBib2FyZC9ueHAgYmVjYXVzZSBOWFAgbm93IHByb3ZpZGVzIEJvYXJkIFN1cHBv
cnQgUGFja2FnZXMgKEJTUHMpIGFuZA0KPiA+IHRvb2xzIGZvciB0aGUgZm9ybWVyIEZyZWVzY2Fs
ZSBpLk1YIGFuZCBvdGhlciBpLk1YIHByb2R1Y3RzLg0KPiA+DQo+ID4gQWxsIHJlbGV2YW50IHJl
ZmVyZW5jZXMgaGF2ZSBiZWVuIHVwZGF0ZWQgYWNjb3JkaW5nbHkuIFRoaXMgY2hhbmdlDQo+ID4g
ZG9lcyBub3QgYWZmZWN0IGZ1bmN0aW9uYWxpdHkuDQo+IA0KPiBJJ2Qgc3VnZ2VzdCBzZW5kaW5n
IGFuIHVwZGF0ZWQgVjIgb2YgdGhpcyBJTU1FRElBVEVMWSBhZnRlciB2MjAyNi4wMSBpcyBvdXQs
IHNvDQo+IGl0IGNhbiBiZSBhcHBsaWVkIGJlZm9yZSBhbnkgb3RoZXIgY2hhbmdlcy4NCj4gDQo+
IC0tDQo+IEJlc3QgcmVnYXJkcywNCj4gTWFyZWsgVmFzdXQNCg0KR290IGl0LiBJIHdpbGwgc2Vu
ZCB0aGUgdXBkYXRlZCB2MiBhZnRlciB2MjAyNi4wMSBpcyBvdXQuDQoNCkJlc3QgcmVnYXJkcywN
CkFsaWNlIEd1bw0K
