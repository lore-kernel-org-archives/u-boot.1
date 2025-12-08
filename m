Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E068BD3B7DD
	for <u-boot@archiver.kernel.org>; Mon,  8 Dec 2025 07:25:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 101CC83AAE;
	Mon,  8 Dec 2025 08:25:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="WgipqghH";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="nyeOeVIB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EB7C83ABA; Mon,  8 Dec 2025 08:25:37 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12A4B839DD
 for <u-boot@lists.denx.de>; Mon,  8 Dec 2025 08:25:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: 116c1d1ad40711f0b33aeb1e7f16c2b6-20251208
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Content-Transfer-Encoding:Content-ID:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=NrlrnEt6vWXsPWf5KFR0EbKK5o/bVa4cZxY6SLatR6A=; 
 b=WgipqghHyF0Tc3uuGx0OxffEZJ2K2FTqobZ+nnDrqssY2Lxf89hK5C94tNGtb6TTq9MUaxzsbV3RdJW1bmAGlx5KvKYw+kXHVO8OlwQvXRy9WhyKHDrZJRoB25Vx/ua0zerbf+juG7MzkNkF7wyuM6gex6gDD56rpI84jiPF2qo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6, REQID:49b8abc5-6588-4111-9068-aa10a46fede7, IP:0,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:0
X-CID-META: VersionHash:a9d874c, CLOUDID:1c4bf1a9-6421-45b1-b8b8-e73e3dc9a90f,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
 C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 116c1d1ad40711f0b33aeb1e7f16c2b6-20251208
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw02.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 211545303; Mon, 08 Dec 2025 15:25:27 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 8 Dec 2025 15:25:26 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Mon, 8 Dec 2025 15:25:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RrruL+vpMIOjalG3d0Ki1jlfhIGnoaPWglmVSjiiAvoW0PxyCyX7FQJawB/wIa6EnGNyFmikSVsuj9AOniJTGU6dBJeGF6vLBB3gum2NeFhPXplqRFSwWhF+1rObPnQpoFZk0hIh+JkPYaeb0RB7coTh7TJZiTEU/ZVOrv2h2bhc37WH3QhbrBdJvEn6IdGa7etTS0vtEwXGVgU5P2cTBkdnwmQiSgnA/5VNj5JAwWIla8cgQNCWy4dBu4q+bplOak29+p8AZL8WIXo7AUX0T56QUUZ0/g427bV1lVbOjSaRHr4OIB4jNC9KVidpfLCEs1BQlEDwNSMbGIgvd1jMHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AyJwSBcaFnbCEYQ1Ai1zA82JCVs3ijYD1qbOI0yCZMQ=;
 b=ZkgqYJznhMcooBmOULIX7pQY2c4BsBlqHTcqwgO/sGr9nf1RJ71Epb8oWlWg9O+YkhGIT9qsdPZDuvbq5PzAbmJM+PnLc4bBAOylJfwL2Ob6VkLDFzsXvtN7FQqL93rglrl08xZG8/0L+MA85DqThytkOIDzvUUUs8JDudKm1BTP6dTB5vQ1yGZb1dV01H7aD/6n/6/lCJQ040dvrIBRMeAjYR40UPBAljyJFHOKGuLhnIZ+eatMruBVMNIgg96RFBn3ldGZMfbuhliwIlG/Ql1WzGn6H8HCsE8+U2ClAnFW5IoBv9QeBtG7ofD8WeyFNwFezrFRz1ors7UeLKl2oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AyJwSBcaFnbCEYQ1Ai1zA82JCVs3ijYD1qbOI0yCZMQ=;
 b=nyeOeVIBIeEXqN6Om/WMAxLWQW9p4itAS6U7rw0IR607tRfCMnFrQS42GGgmotMw4hVgJKgTaGlagQ5mrePM+QfsONjES84asEK8XxAuvvQmG9fSuNh8D0zP18MtQMJdWlUBKRA/hG8Nj47bAF2wor+wIMiqmxhTZqmuwAkvB6g=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by TYZPR03MB7394.apcprd03.prod.outlook.com (2603:1096:400:422::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 07:25:22 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2557:de4d:a3c7:41e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2557:de4d:a3c7:41e8%4]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 07:25:22 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Ryder Lee
 <Ryder.Lee@mediatek.com>, "trini@konsulko.com" <trini@konsulko.com>, "David
 Lechner" <dlechner@baylibre.com>,
 =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>
CC: Julien Masson <jmasson@baylibre.com>, "peng.fan@nxp.com"
 <peng.fan@nxp.com>, "semen.protsenko@linaro.org"
 <semen.protsenko@linaro.org>, "seanga2@gmail.com" <seanga2@gmail.com>,
 "lukma@denx.de" <lukma@denx.de>, "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>
Subject: Re: [PATCH] arm: dts: mediatek: switch mt8365 to OF_UPSTREAM
Thread-Topic: [PATCH] arm: dts: mediatek: switch mt8365 to OF_UPSTREAM
Thread-Index: AQHcXjRa9T3F2dZmkkSZPFazDnk52bUXazaA
Date: Mon, 8 Dec 2025 07:25:22 +0000
Message-ID: <3209ece5ad4bdb8ebb8601d747233c415dd23c9a.camel@mediatek.com>
References: <20251125-arm-dts-mediatek-switch-mt8365-to-of_upstream-v1-1-707eee6dfdbc@baylibre.com>
In-Reply-To: <20251125-arm-dts-mediatek-switch-mt8365-to-of_upstream-v1-1-707eee6dfdbc@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|TYZPR03MB7394:EE_
x-ms-office365-filtering-correlation-id: 00bf9817-b5df-4155-6058-08de362af2a3
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?LzdRWm5kUTkwbW9IWjY3SHpHKzZsWlFhOXB5dDBHQ0VvM0k1OENnTDRRd29z?=
 =?utf-8?B?SWZQSG82dyt4UXU3dXZQcy9iNG1oMEJyOStsSWZIQmdwZnVBdFpMcldOQ0lO?=
 =?utf-8?B?Uk5XcUljYTdvTko0TTdWQW9NZSt4NTJkL1NTamFJZmdEcU9MMyswbTNCVUd3?=
 =?utf-8?B?Tlg1L20vcmRObDFuL0IyNzFqS2RVN1VVblZ3R2sybWdTQm1iTkRZRWdOVmZr?=
 =?utf-8?B?NDNKeko0TWU0L2piRGp1NXFaRmEwM090YzBlN1MrQTJiY2RreldjVGVtUHdB?=
 =?utf-8?B?dEpsUFN0VEFmVmlweGU3SzkrVkFVcVR0d0lZQWV3OHNQRTBWZHVJYW1VWmN0?=
 =?utf-8?B?OVZPVXIzZTl5dHhtOStnN0lnUFBYS1VOd0loQzU4bDJvV0o0RlQzUmI2TitL?=
 =?utf-8?B?dXlMTnZlYWk3eThKbkd1bWFxdVVXY3gwdlhkcnAvS1NDNHZuSUhrd3NveEN3?=
 =?utf-8?B?SlRCZmtRMlRXNElOd2dldjRGTkR4cm81YTVTM0gxSGQza0FSY0x2UzhoVVQ0?=
 =?utf-8?B?N2dUZUZYTjh1MnBubUJXbnVCbmxGckI0cDV0M2czT0pEMlRTK0pTK0hibTBx?=
 =?utf-8?B?NFQ1aEpVb1Q1SFdUSFk4YWJMOWw5cm11N1RkdHN4RE9aMUpVNmZMNGI4dWRS?=
 =?utf-8?B?bU9EU1RQYVB4c1F3bEdRQVd3RVZkRWhZTm9nSGdueWNMNUd4UFppUmdxSGVj?=
 =?utf-8?B?aWhuNFI4TnlMbmJjSEdQU2hUYmFkVDFacjk0NkoyLzllclRIeVl1cHZndnB2?=
 =?utf-8?B?eW5yT250em5BbXI1R0t2emNjVFdodWVqUXk5eTNiT2JYWXBNdzVaRzhLa3lI?=
 =?utf-8?B?bmpTSGJuMDdDTGZsTlpEbHZsZXk2VEs3ZHp3eTdHRzU4VUlFdUNUSFJ5cFFx?=
 =?utf-8?B?M0E1WXJrVHZ3TkljUWdRTzhDK0ZQOUZqNi9QakNsbFhzeTZjTFhGTXRiM3NS?=
 =?utf-8?B?dVJ3RlUya1dUcWM0aTB3aG05Z2lGNlpKOHlZUVVCN1RpQXVLNlNmNFduRmVJ?=
 =?utf-8?B?b08rbHB2S1hMQ0JDQ1paNEtDeXpabWRDbFR4ckZvdWx2blZMblZFaE8ydnNy?=
 =?utf-8?B?a2Fma1ZxN29XWm84M0FNZCtCTXNsbmhUbzRKTzFPZlJUemJZL1N2OGR6QUdN?=
 =?utf-8?B?QlZjT3ZEWm44NXVTWU5NQ0ZpUlhGTU4vMzhYcVk4RmhCdkloaE54OUJjTFdW?=
 =?utf-8?B?R0MzeXZXNERtWHlob1FEM2RkQzFQNGJRWUZ3ZDhSdHpiNnJ6UURCdUFVQldJ?=
 =?utf-8?B?S3hZTERieUhqMVpKbkNpZjlXck1RMDZBOTliOEQ2eEdQTkVxMC9xc3AxVjRL?=
 =?utf-8?B?d2hQTTlVd3duRDhXWVZvd01pQnA5aENsQTRxWFI4K1U1Umx4SVFaMjJzbVRr?=
 =?utf-8?B?dzB1SktaVVd3c2ZoVlVXYlB0MjNwMy96emFaOFN2dld2SllScEdLZE12dXZX?=
 =?utf-8?B?a2RZU2VITDlpd2Fta2tsQUxGSzR1cTBMRVBNbXBTMzJZOG5zTitYNlRvT1Bq?=
 =?utf-8?B?QUttUVlKM0czRitlZlQ3TURRUkVSeFN1OEszNEpsSzRRT09NeERNSkU4Z0FR?=
 =?utf-8?B?REs2d2U1VlZQY0ZySzRhTFAyai9tU2hVL1V4c25qbjd4RGc4bG04VnpIeEM5?=
 =?utf-8?B?UUxxYkllUEkySkxjSUR2dVEzTlpmNmFkc1RBQ1U0WXFLMk1jSmRHd1N2NzdK?=
 =?utf-8?B?VDlxR1hEN0F0ZWVZcW9pNDNyejI3QzlEZnk3azlFbWhMT3hvUzIwNFJsQ1lx?=
 =?utf-8?B?bnVEMy8zcmRidS9Xd0wrMTZWdndVOWxQMXdGcUxSR2t5cW1nckMxdFRaWHd3?=
 =?utf-8?B?Ti92LzJNMzdxMXNjQ1hyQ2J4TktZMHBjdUZ2WnRlMmFHU1RQbldwUXdCU050?=
 =?utf-8?B?M1M5bTVrbWtTN3R2VlBtZXo5S2dCc2xpTEJ0MVphOXk1am55aDRBeFM4R0VH?=
 =?utf-8?B?SUxqRDV6SzZkSlA2UzQ4MlNKelBxd09hSmt6NEw3SlFWWndyeTVITEJnY00z?=
 =?utf-8?B?Vnl0VWFoMmYrajVlOG9lRElHcEkxMmthTEtFaVNsUkJvTVdwZ09KMVd6eDZq?=
 =?utf-8?Q?IsqJnX?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGZMMjBjTVVMWG53Qkkxc2RpK2ZZNkV3bEpzTmVRYmlWL29zc1dmNVo1M3hW?=
 =?utf-8?B?L2I2R0pKTkR5SlhRbEw1WkFyT2FhM2VqTGk5dmJmRjhUbDFudVYreHZKdHgv?=
 =?utf-8?B?RTluY0RCODR1S0lDUFVmV2xHTExNU0s0TGVvZy82RjdiWEQ1V2hnUEZkZFFp?=
 =?utf-8?B?M1V3UlFuQjRlMFZDRnNnY0wrWEVMVGFqbEJhUDRxQjFDNXVnQjBOSC9RWnZ3?=
 =?utf-8?B?VUNKUlVhM0dMcHBzTXoxemlEcVhmb0wzaUwwNmpHdHBSb0tJK1krbmFMdjJR?=
 =?utf-8?B?MWw1ZUxqZFhIUm1oeDkzV1ppZC9vcjlkdlo2MXFONDJvRWhya1VNT3kxb3cw?=
 =?utf-8?B?ZzZ2ak1tbmNjZjczZWowV3VvbDFnUWcwQjBtYm5lb09la3ZwYVBEbk9acWRy?=
 =?utf-8?B?MmYzR09pN0hCQWF6c2k1QXhNSFVxSkZ1TzJyckhtRUwwdGtEOG8yT0FWWHY0?=
 =?utf-8?B?bGpobVNuMWk5RjlIY3F2SzhkNHNodWY5QU0yVDhrTURITTFqZk9DTXZsSEgx?=
 =?utf-8?B?UWFNZHJGQ0pUZ3Q3emF3MVk4TCtNM0RpTnF6dDhjc3JKVjVaZUt3OFdDTXZF?=
 =?utf-8?B?cEMwdFI1blBxZDNFZ1hSOWZwWGdzMnVjMTk0Q3g4SlRFbE1iZU51dmhKdnlm?=
 =?utf-8?B?QWtJcTlnd3JIRFVENUJwZUdOYmN0S1hDZVYrTUpGYytTd1FORTFnbURQdmVp?=
 =?utf-8?B?UDF4ZXhNYWNoTFMreU83OHFyS0F2Njh1QllTMXFaNTY1aXVldU9FVFZZMkRZ?=
 =?utf-8?B?bFdPeTRGL0U1Y1oxS0tiZjVWcnBJMzdRZ2xFWDhoWTZOOVhrRWVsaTFyaExt?=
 =?utf-8?B?R09CcVNhQWJCd0VNbnl1S2x0Rm9RWGRyeGNrMS84ZmZmOERpMG5UdTJ1b0JZ?=
 =?utf-8?B?VWlENWxjV1JCUjJWYzBQNlJ0K0hFR20zdmk5SFZNNWh1aFVTSDVUSTN1Sk5l?=
 =?utf-8?B?TzdzeENIZ3J3UzJJZ2FNMjI1Sml0aStDbENZY3VqcWlvNHQxaEg3emRKUkVL?=
 =?utf-8?B?eXhBQVVQMEtGNXVkdmRZZSt2aW5MNThIT21FTTBjWUorTXZUMkdHSC9mNmxF?=
 =?utf-8?B?aVVKOWNLK1NXMklMbGYyQ0huVXFFeEZZS2FIVUxnbVpRNlNRaGFKOGxlNlRh?=
 =?utf-8?B?SUdkekg0MEhVYXhLb1lGa0FMdFRkM3BjYi9iNzh6d3JvcXFPd1g4TzIvbktj?=
 =?utf-8?B?NUhwNjhXeWVvR094YXppYXpxaUlya3VRR2FURkFpM2NqVGp3YktKR1hTNmdO?=
 =?utf-8?B?SFUraUxBbWxNVzRtWHNwT2RmS2FwbU4rbFlqcmVRcVZrRGh0Y0F5TE5BbG1D?=
 =?utf-8?B?YXRkUmJGQTZXRkt3Z0tXakRnTzA4UEp1Z2JCQXpEQVY2WWpJUDNyLzVzTS9X?=
 =?utf-8?B?TWFFL01hSG5MUFVwTzRhRnQvRGYraXVVb3RTYkgxRXFoRTB1cHd1Q0ZBWlFa?=
 =?utf-8?B?UHZINjc1bUlhSjdQZS9uYjNXSmlJbmNlY2sxVERDbC9xYk14REgxbXlkR2ZC?=
 =?utf-8?B?R25ob3RkODdqdE9ZN2lJdHRhRkdsaE1SUzJSQWs2OFNPQjhlMHluV0JYcllN?=
 =?utf-8?B?Y05uMStqUVVhWTVhQnpQQ0pxaHh1aXRwN2diNmZoS0RWd1JQSVNxbTV4ZWNC?=
 =?utf-8?B?cTN1dHZUSEFGaXJiUC9rcTl1RkNiMlBpTXhvUiszcDVpVEJvTG9zeUVnTTNw?=
 =?utf-8?B?eElmQU9XbTNyNVZ1aktrb3FacGU2SW92by9MSG5MNUpFL09mR3NmNTMrWEty?=
 =?utf-8?B?MzZCai90d2pFVTMxSUNmRS95R3JBK3FkM1VGaWQzb3JERjRIUFFxZFVWV0pK?=
 =?utf-8?B?MmV5TjJ2QmJVZENQenc0L2Q0aWpQTHBmS05qR3diZkQyc0R1enBhRGMyUGww?=
 =?utf-8?B?aHc0Wkp0aFBaZHpLTXpacTBHZHdnVHg4V1dOZk5obE5sdS80UmVtVm9PeXVO?=
 =?utf-8?B?ZWN5YUh2S3ptdnRPWTg0ZnZwQVFqNVpXMURwQnJWUmQ0KzRTQ3VPZWhuK2Z5?=
 =?utf-8?B?b25xTThlMVVUS3ltMGNPM3c0ME0rRmNQTncrNDV0UGJNVGhVZ3RFcEhERlBa?=
 =?utf-8?B?b0l5REtqMGNCU0FFZ2RkZjF6blNZZUlYd0tuWU04WHJqT2Z6NFNKY3hvVTNW?=
 =?utf-8?B?L2JhWUU5WUJVK3VCNm9GQWdBcS9pTURCOVZDRU1PN25GY1haUTJzOGYwRVZo?=
 =?utf-8?B?cWc9PQ==?=
Content-ID: <CF1148CD3DCEC14BAB364B311FFFEA7E@apcprd03.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00bf9817-b5df-4155-6058-08de362af2a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2025 07:25:22.0167 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UW9Dto0z4CVNOAgiiiIZ4xB1VEH5Y9f2v98Obie7oR/wQEvag4p3VYgAOmtoMZyU3b/DMPAxFdzt8bU8PNEOFiekdE3IwyFSDfaubLfDld4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7394
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

T24gVHVlLCAyMDI1LTExLTI1IGF0IDExOjM1IC0wNjAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOg0K
PiANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUg
Y29udGVudC4NCj4gDQo+IA0KPiBDaGFuZ2UgbXQ4MzY1X2V2a19kZWZjb25maWcgdG8gdXNlIENP
TkZJR19PRl9VUFNUUkVBTT15IGFuZCBkZWxldGUNCj4gdGhlDQo+IFUtQm9vdCBjb3B5IG9mIHRo
ZSBkZXZpY2V0cmVlIHNvdXJjZSBmaWxlcyBmb3IgbXQ4MzY1Lg0KPiANCj4gVGhlIHVwc3RyZWFt
IGRldmljZXRyZWUgaXMgaWRlbnRpY2FsIHRvIHRoZSBVLUJvb3Qgb25lIGJlaW5nIHJlbW92ZWQN
Cj4gKG90aGVyIHRoYW4gaGF2aW5nIG1vcmUgbm9kZXMgZm9yIGRldmljZXMgbm90IHVzZWQgYnkg
VS1Cb290IGFuZA0KPiB1cHN0cmVhbSBmaXhlZCBhIGNvbXBhdGlibGUgc3RyaW5nIGluICZzY3Bz
eXMsIGFsc28gbm90IGFmZmVjdGluZw0KPiBVLUJvb3QpLg0KPiANCj4gVGhlcmUgd2FzIG9uZSBt
aW5vciBnbGl0Y2ggd2l0aCB1cHN0cmVhbSBtaXNzaW5nIGEgZmV3IHRvcGNrZ2VuIG1hY3JvDQo+
IGRlZmluaXRpb25zLCBzbyB0aG9zZSBhcmUgYWRkZWQgdG8gdGhlIGNsb2NrIGRyaXZlciBkaXJl
Y3RseSBhcyBhDQo+IHdvcmthcm91bmQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBMZWNo
bmVyIDxkbGVjaG5lckBiYXlsaWJyZS5jb20+DQo+IC0tLQ0KPiDCoGFyY2gvYXJtL2R0cy9tdDgz
NjUtZXZrLmR0c8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA0MTgg
LS0tLS0tLS0tLS0tDQo+IMKgYXJjaC9hcm0vZHRzL210ODM2NS5kdHNpwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDg0MCAtLS0tLS0tLS0tLS0tLQ0KPiAt
LS0tLS0tLS0tDQo+IMKgYm9hcmQvbWVkaWF0ZWsvbXQ4MzY1X2V2ay9NQUlOVEFJTkVSU8KgwqDC
oMKgwqDCoMKgwqDCoMKgIHzCoMKgIDEgLQ0KPiDCoGNvbmZpZ3MvbXQ4MzY1X2V2a19kZWZjb25m
aWfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAzICstDQo+IMKg
ZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODM2NS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB8wqDCoCA0ICsNCj4gwqBpbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL21lZGlhdGVrLG10
ODM2NS1jbGsuaCB8IDM3NSAtLS0tLS0tLS0tLQ0KPiDCoDYgZmlsZXMgY2hhbmdlZCwgNiBpbnNl
cnRpb25zKCspLCAxNjM1IGRlbGV0aW9ucygtKQ0KPiANCg0KW3NuaXAuLl0NCg0KUmV2aWV3ZWQt
Ynk6IE1hY3BhdWwgTGluIDxtYWNwYXVsLmxpbkBtZWRpYXRlay5jb20+DQoNClRoYW5rcw0KTWFj
cGF1bCBMaW4NCg0K
