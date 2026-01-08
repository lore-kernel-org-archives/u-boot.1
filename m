Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E87D185F8
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 13:35:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8290841C2;
	Thu,  8 Jan 2026 14:33:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HY7Q0trT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C9BD83B8A; Thu,  8 Jan 2026 10:52:54 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E15283A26
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 10:52:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PhZidfg+S0l3irIh5Yb/QV7Ckwsvt0WPI/LZE00wBVNFDwWn9l7VEgUpaltUORlgL1csDnSb+BRC4lPRm2b6WPy7lgs1XljVTZapDzQ8kE8QLP/ZkLz1JNlge+Urj9C37XOpGsL3jJhhQL8p9dSVgfVwT//rk/y6URGqfQFe+1JJZtC8lh52uOked4bqrDktu0I6lfaQ8ZLc87SbOs4Q1Hhgojgn1s63fDlaBZi6Q83T9hXYoTdFUhHfjSTdQ757Ab0be99ToOwHN5ME3HIA8x1dqtSEWpqlF3xCNXzqfGwLBLjrN30ATkFlWMAtuPWmbhMqAz3uwV7kSCZCT85Dgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hkA8Lyez3jTGQtrJxAZajCPS21V+QtyGobcwMSdPiM=;
 b=JYKJ1uprhBNuVkRxDOg4avRBNYrBAzt0jUopo1q3zQ5rwDbrAU8ZgzEBxWyN2nuEDIxZO4t87asKuIAqoOzboL4XsOXaH3Ed4glIshlhdsqzri7TXlngbsJpyPpLEIbD0gmwwXpGPBRKo4rBWCL1gc/XqOnDxYLVPf27tWH+NNtxc51oViKuBmh5iEKWtt6CP6T4U7t1sh5smCZRscrIl5Ctxti40i1UibnPd2tv4MPQggE/pVsKd19Z5srG8ZEFktUGdimlVo16jFu5E8pWaOVTCkPsxs6EAyZjrKGdA5ElTHoPpT1oIgVGaXogRgBojgmUxKPCNkjW6sFKblRHfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hkA8Lyez3jTGQtrJxAZajCPS21V+QtyGobcwMSdPiM=;
 b=HY7Q0trTJIHkvIkYi9sKaHqU9zsTRx9mzNCDadoXLTnXwUS1xSZamxtzAyNuu0bHfbEE26Re15RYFo88agn4D4pX7i0RSuNmo11Tw50syYQQ9FIamwi2dfOwRV6f5G1e5V9AF1txvxAygcnKmEe7VWTS0jUEy9EqYb5120Uj71mqbicDG0h7CfdmPDXhHDmmC1NCH+p3WTIKAUds41865Z/BwkgDE34HEitu/uADgGZyctew9tVArAXBtvQF/1y0S6MY+tV0KJHkS0uF3xmzDeMtmmSW9YrSTEfL/6BmRR85340Hn0VSlpga5veAbaF40qFC6Erlhr985P3KSMAyog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by GV2PR04MB11681.eurprd04.prod.outlook.com (2603:10a6:150:2a7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 09:52:49 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:52:49 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 08 Jan 2026 19:06:47 +0800
Subject: [PATCH 02/13] imx93_evk: Drop setup_fec
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-imx-update-v1-2-0d5921c575bb@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5c77ec97-269a-4334-4981-08de4e9baef4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K0cwT2llNUFQZEpsalg5RFc3RUVjcmN1UWNzTGh2NnkxeUVQQzBPdGsySjBl?=
 =?utf-8?B?d0M3dEJjRzhEM3BWc0hubVhDdUVuVHFCSFVvN1UxSk5ZZCtqZTFjWTVDK2Q2?=
 =?utf-8?B?b0p5d1J1ZE9NL0dNRlRydG9QVldUVXRMZ3hWSU9xNGlybFVEZk5nVlZmakFG?=
 =?utf-8?B?ZGF6TTV4dXFRMFdrdkRwM0V6YStKWjJaeGlUcUd6b28ybzBXNjlMSlRpUHh1?=
 =?utf-8?B?WlEwYUNiYW1pbnZHek5aOEhvR0p4WXlrV1BZRmttVjMzTkVoYVduMEwvYVVR?=
 =?utf-8?B?UEZiNnlsRkc3WUpXbnF5YkI2bHo0WS9xR1VUR1daaGlpa1BrMW5ycFhBUjdv?=
 =?utf-8?B?K1piUnpTVENhSndIKzl2ZVlMeGN0VDVkV1hsRGFUU0RHWjZiL1loMGpBODZq?=
 =?utf-8?B?dHpFdHN1ZFd2eW11Z1BtTFVLVHdpMGhpT2tHU0tOVXp6UHNSTE9RK3JycFAw?=
 =?utf-8?B?aE8vTk1ubFloQ1oram1kOGlsektncHV6SnlvRGUyU0twWm1NNnVTVm9xemNv?=
 =?utf-8?B?bG9jMmNCeTd2VHozN0dIQnE4cDhWazFFTENyMitsTUpMNEMwQ0NiRFAwSWI5?=
 =?utf-8?B?MjZ3VGUzWXpkdUpYYzMrYzVjZnpqZVhGcjRRLzk4Qm9mZ1AzWlBkNXlJaDB5?=
 =?utf-8?B?aExDckxKRzRNaEVxRzBjZXhyVjQ4RTByMVBjaGl1TysrTWV0NnV4ZHdYdDVL?=
 =?utf-8?B?V0VudVpRa01DSVVSNkxTWmw1Vmx4Z0daSUtrOENiVzNhdVlmM0FwZ1M0SjEz?=
 =?utf-8?B?WW5NdXBtTitLVVlCQ25qWjFPMkF2RitWWDNnRld3WDhNQ3FPOWl1QXJ5WCtj?=
 =?utf-8?B?dVhWSWxyMEF6eEc0eUdESW9KNnZ0VldqWEtSTU85aW8zNDFibGx3REFtZFBE?=
 =?utf-8?B?TXFzam9iUjJLUjlhU3JDM2hzUGpMZXc5cWdGR1dmb2phZHNqbDdPVzNKYW5n?=
 =?utf-8?B?bDRTalB0YUNRT1piSUd3QTl2Z0x4aFdRQlJxMEluR2JiOEFaS3NWL1U5b2l2?=
 =?utf-8?B?ZStjNmRGQnVzTU1xNFBVNVdrbytKcnJ1ZUIwbUsrUVNoUFNrNHcyVTBQZVJ1?=
 =?utf-8?B?R3JmRDhRV1VwclpRVVF2WWhrZEhvbTFRTHU4dUxjTWZ0Mm1YckVqeTFPVGJV?=
 =?utf-8?B?TUxXUE9KcDVNME5mNHZZRUwzUjdRa21ZTmdZS3ZlSHE0UjVTS0FzbUFBN2Jn?=
 =?utf-8?B?UFdvZkZkQVptZDRScGIycjJzUzd3M3RBeDI5UlEyRnNlbjk2cFdwTGs1M29T?=
 =?utf-8?B?UUl4QTJuZCtoQU5SVTBIeVAwenBxN2dwVWRKRDNjYTZ5M3R5emo1dmM1N3NV?=
 =?utf-8?B?M3VmQy9qdVlxR3pHL0dEOTlKbGdYeDRjSEVQZzNOaElDZlNxUXN0blowbWN4?=
 =?utf-8?B?SkM5ZmlUZDY1aXpQQWw5eStVM012M2hUNmpXdWxocFpuVW5kZ2YyMVpOOUs3?=
 =?utf-8?B?NUxtVU9kclZZVzZDREdhS1gvQ0cwMm9PcWwzcnl3MTZjY0wyV3lsWkVlNXdh?=
 =?utf-8?B?K092N1h4SGphTTVTdVdrRGkvb2tWV2VFcWFnNEx1dUgxRm1ZWUxMd2c4Y0Fu?=
 =?utf-8?B?NkdiVzlxaWZ2Y3NzMmNPVjZ0WjlYQ2p0Q2ZWdE9VL2xIWVBSV3E4Ly9qRHJ5?=
 =?utf-8?B?aWZITkZHN002MWhQTytOelBBbm5qZnpjT3l1UlZ5NkFaa1hCYU16YmNGa0V6?=
 =?utf-8?B?UXN0LzNZYklUeTMrMWRZOVM5bm4vNlRnVm9oZXJKUUFnZlVwR05sWjJRQ3NV?=
 =?utf-8?B?MTFhZitPd0xXMjRRVVRxZUVocXJJUnNVNXphc3YwdnZacHhHUWRtd0t5d2RS?=
 =?utf-8?B?Vm1FTXRDVzExcmdpaWdhN2tSbDl1Wkl1c3A0Mk1VUU9QR0J5OXJWckF1OHV3?=
 =?utf-8?B?QWs1ZXRsRTFzNHhTMVp4VStJcDI0elQwdUhBVTcvSUgzTTJZZ2JYcTVrbXJ6?=
 =?utf-8?B?Y0UxaUppd1loR2ZxWnJOYm5zOFRRbmJKcHBXai93WEE1cmx4amZjV2QySDM1?=
 =?utf-8?B?eDAxakN4a0pxOXNuWUxIT3ZBU1ExTklmK3QrZXltQkJSK2EzcVNOSWR1cFhT?=
 =?utf-8?Q?6xOxKX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFhKSXZWY2tVS093R3o5TklYM0lLUmFIcXlWNEVSSlUwM0VRcVlBL1ZWRFdr?=
 =?utf-8?B?TXZSdWswUlQ2QlorWkRuQWNqdU5pcWt1RldBbUgwVFVvNnA1WnFzeVJsNFVG?=
 =?utf-8?B?U2xpZ2ZnK3MyQ2xyZk9SSnZTYnVhOWVnWUs1cjdvTFcveUhOd3BRSnVMNHgv?=
 =?utf-8?B?VDBIZzNyVTNoUzRmRE9EOWVMcnZVdldLYWcxWkRZRzlaVzJMY1UyUDl6N0hv?=
 =?utf-8?B?Y3hZdGtsRDNtS2RzanBmYWxBa1JIbk9reXIveGtJRnRvbjlNZGVUaG1vMHkx?=
 =?utf-8?B?WEZRWGp2aFpJaUdzR2Q1V0NYN3U4NUJ5cXVzTWM5NjRtbm1hN2JFNkt6dmJ1?=
 =?utf-8?B?a29rdEhYUDk1b2N5UjkvamxFZ0tORUQ1aEsvTVgxREFITldrQnVZMlBLOEVk?=
 =?utf-8?B?U3I1SlZLRDVlU1dMMkJmQzh6TEhWeVJ5bU93aHZJM3VzZHA1OW5MTUc4Tzdp?=
 =?utf-8?B?TnpTanU2ZWFrdzd3REM0cExubmZXMlczSnJnN0ZoK3RiRWpzQlpsZEtLcGN3?=
 =?utf-8?B?OUh2WW4rWUE5Vi92bllyOXRiN05EaFhrdHNyUlJ2THR6TG5HRWV1eHB2T3Fv?=
 =?utf-8?B?aTdmblZKazhhazhnemEwcTVyNjZqRDEzZ3ZNTW9vUitoTFJMUk5kUWUycDN3?=
 =?utf-8?B?dGFFRUVMcTEvQytKOW9hVUprNm54UlBRaVJLUmFWb0c1MHZHNlZkWnRESmEr?=
 =?utf-8?B?dnNNNEV0aVRib2JJbTQ3dlZWYTI4c2NMUngwTGQyQ1NtWndmd29tZVl2dWU1?=
 =?utf-8?B?UTJjdWk5VjdPVlVtSlRZd0I1NC96QVJqU1RtOEc4cGVKMVFYR2lYTHRmcC95?=
 =?utf-8?B?M2lDZmxHNXpwb3hWeE9kWUMrbDM5b3c4NjAveEQ4cFY0eC9CYVR0SmxUa1Zy?=
 =?utf-8?B?WHVqM1Uya1BTUjErODBvUk9hSkdqVEtORE8wRVI3Y0FnOFBwV3g1bHJMbDFh?=
 =?utf-8?B?RWlRZ2JDN1hVeWZPWHBOOENWRGVDKzRiK2xGYkhnODZKRDVkY1JHOWF6Z3c0?=
 =?utf-8?B?MUdnSHVLWHJ4bUxST0tCWjVsdXpBNWpncGh3VkZpZFdwRXJ4bk9hOTJiQ28v?=
 =?utf-8?B?clNiZk41NC9maUdOdk54SnY1MCtZWkQ3TjJJNTAxRTY5UXA0a0crL2t3dkg5?=
 =?utf-8?B?aFU2QWdiYVpXYUovYkxDKzk1NzFLUjdFSmdHclU1OGJQcWV0bE5USi9RTlph?=
 =?utf-8?B?U3EyejI5Z3BxSjFkbDZiZXUwb2RNdXo1aEVDaHF2T3hsaWNWYWpYOVFvRXRo?=
 =?utf-8?B?TXdOSEYxRDc1b0FQb2xBMVZ6aVdwM0RzZWVoL3VXbVM1a1FBUWtOZnlJaDl1?=
 =?utf-8?B?VTYraHl5RjZlWms0ZDdCdmltbzhLV1hsWXQwbWNPRFlVNVd4M3hLVVVEenJV?=
 =?utf-8?B?RFo3OVhuWUltM1htckhkamFybWNsTHZyYWE4ZUZYVzlHbGV2WDgweERiU1FN?=
 =?utf-8?B?YWhqU21yaVMyclF0aG4xUUNjRjRJL1VkU3V3ajhHdjVoZXRuck1kQWxBdmVQ?=
 =?utf-8?B?MGQ3bmpCVytPYWlwRHozaGd3SFBrNEJzdUttQ3RSUmtUeXZVWHVwKzV0ZzNF?=
 =?utf-8?B?S0EzcmIrQlExTm1laGxFbVJKRHRwUE1ZWnYzK2tHQWVIRGs2VWNLU2dxUjY5?=
 =?utf-8?B?cDdCVmY0Y2Z0Q1NWZDcvK1VIUk1HeXZ5bEJ3TU9VRk4xcHRQdllPQVZMbTN3?=
 =?utf-8?B?U2dUN2FKUEFUekxaM1VudThKZWQwams3WnFtQkt3aGlmOHhqSjNDL2IvZnJj?=
 =?utf-8?B?RnZNT3doMmx2eGE5S0paSEZkTG9vR0JFNk8wbE5kZHJmVjZuazRMZCs2ZVlZ?=
 =?utf-8?B?WHFvNFpHVllXNjhxaTFMRHBsVU5UOGJhOWRNR0VjUFZXSzIra2gxVUZ5aXNN?=
 =?utf-8?B?ZlZtZjIyeTZjbEhpQWdPNkhIdzVuOVhUb3grWlY0cWJTZ01oUkpGdnJjSGt6?=
 =?utf-8?B?cjJuaXJMcFJSVkxlVHkxQUJzNGVRdDArdHNNTzZhaXE2R0krN0Rja1QwQ1hU?=
 =?utf-8?B?RFlPQTNuVk96VVV0dG5Yek9keGhUSEV5Q1Q1WUhFR3c4eDBvTE5sT1kzV1pE?=
 =?utf-8?B?bUFtaWdnQkR2emw1VExlNk00aHQ1OVMyVVhMZFlleGl5SkRWZ3V1UHRMbi9M?=
 =?utf-8?B?V0phUGVzZnl0S1lYVG9sSUk3Y2NCRnhxNWhNSE94NEtZZXpSL2IxNWROWSs4?=
 =?utf-8?B?R2M0M2Y2ZTRGTUZqbzZhcTR5VGxrK2Fzc1ltVms2cTRFTU5mSm1FY2ZmNXpY?=
 =?utf-8?B?aUlSL0U0bnZIK1RKZFRsK3BqcGtVOGhwUFh3cWpvVlJ4RkN3TXBZdmUxRHRx?=
 =?utf-8?B?QmhsblluY0E2a2drWUh2TFpMZENRRUZwcXlIVzdEbks4VFNpeGd3UT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c77ec97-269a-4334-4981-08de4e9baef4
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:52:49.7398 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0yQLBYNOlgKRFmz0iIHhJmvxBiWXPKP3LGqBl3z8NMq2p+BfyJHhUHZFq9f4Wv9sKjlMW47LQ1jg7DlvRsyYoQ==
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

The clock settings could be handled by "assigned-clock-rates" through
DM clock driver, so drop setup_fec().

board_init() is a dummy function now, so clean it up.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx93_evk/imx93_evk.c | 15 ---------------
 configs/imx93_11x11_evk_defconfig     |  1 +
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/board/freescale/imx93_evk/imx93_evk.c b/board/freescale/imx93_evk/imx93_evk.c
index 371b35bf1a6..64400b584d1 100644
--- a/board/freescale/imx93_evk/imx93_evk.c
+++ b/board/freescale/imx93_evk/imx93_evk.c
@@ -9,9 +9,7 @@
 #include <miiphy.h>
 #include <netdev.h>
 #include <asm/global_data.h>
-#include <asm/arch-imx9/ccm_regs.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/arch/clock.h>
 #include <dm/device.h>
 #include <dm/uclass.h>
 
@@ -37,11 +35,6 @@ struct efi_capsule_update_info update_info = {
 };
 #endif /* EFI_HAVE_CAPSULE_SUPPORT */
 
-static int setup_fec(void)
-{
-	return set_clk_enet(ENET_125MHZ);
-}
-
 int board_phy_config(struct phy_device *phydev)
 {
 	if (phydev->drv->config)
@@ -50,14 +43,6 @@ int board_phy_config(struct phy_device *phydev)
 	return 0;
 }
 
-int board_init(void)
-{
-	if (IS_ENABLED(CONFIG_FEC_MXC))
-		setup_fec();
-
-	return 0;
-}
-
 int board_late_init(void)
 {
 #if CONFIG_IS_ENABLED(ENV_IS_IN_MMC) || CONFIG_IS_ENABLED(ENV_IS_NOWHERE)
diff --git a/configs/imx93_11x11_evk_defconfig b/configs/imx93_11x11_evk_defconfig
index a53e5fc1de1..39a7962d7ca 100644
--- a/configs/imx93_11x11_evk_defconfig
+++ b/configs/imx93_11x11_evk_defconfig
@@ -36,6 +36,7 @@ CONFIG_BOOTCOMMAND="bootflow scan -lb; run bsp_bootcmd"
 CONFIG_DEFAULT_FDT_FILE="imx93-11x11-evk.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
+# CONFIG_BOARD_INIT is not set
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_MAX_SIZE=0x26000
 CONFIG_SPL_BOARD_INIT=y

-- 
2.51.0

