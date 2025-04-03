Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6DBC3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 10:56:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FF9181CF0;
	Thu,  3 Apr 2025 12:56:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tVrinFI0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BA6A81FDE; Thu,  3 Apr 2025 12:56:25 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FA2580194
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 12:56:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bD4C1TxGXAR8X6i03Re2yxdWeRCm0lYziUw0YVOT9/xPELSuyP/LH7ADOZUF5amupn/XI/lMkwfkTXILLejZJffK5WQKLaUIILEUc5Qs55DChP1MXPo1Fib0YrW5TYk4npnFZZ0HKPHM20D7F2GzuDW5XFTyvHbgj2iZ+FL7SxBSIQlekytDBxAl7Ak668ZFzpCWENzazBwcELzH2VCaeger+sOP62QcpduuibOrbBekS14rdbQeUoHnotIIdgMPGfuh17ULo337Qx44KIi1b2I4CmQ3MW6vP04NaGtNUypomkg3n04xWEhSPLw4ZEcUE365kEBuJmxKX+forsR3Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBc98OgyAJGFnac1NLyjnl7SAdKUfd0QI0EHU/coa9o=;
 b=c0eEohKSYJ9/F0gntTmsS7nASuosux0eGflg1PQaHkzM5+p4cJqEZRnYlT5a/yiAId91E+pOxaz3mSbvGZ7nLRRkoGxeFIyCfj38J25t7udk/qTaZEZEDt5ej3+S6d9S5srnKmV2qxoxYGv05Rjv6WgZTs9QV8U/Ijj7riVjsPSSeA80RU5a1QlTl4q1thOWz0ycKCo0SstFPN/xKQDbFnXWKBBlVvOLwb0uxtkRUeuT7Gs9nlx/MA8ZKFNY4+dGe6pL7/CuBJiGv8WDa2p/lCME0VDsKeNjd7F4x6FA4E0Ad7khAqxqmtMPsOaGLl5oFFZBypbwecNu2d1TaLCelw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBc98OgyAJGFnac1NLyjnl7SAdKUfd0QI0EHU/coa9o=;
 b=tVrinFI0cKUy513z9q9D8n+JsKCINXzaN42K3IES0E2Jbtwrbz99oZ6vk4xLAUw7nj1Mt2aqONY+KBA5zoVxwufDfphiwtDfGPs7yiyV8zcJOfsuvrkdHdTw3DQnUHVeLQMcC7gnkshyAGOaUr7J0qmw2PYNKWDhGZ4sfEfGhE2U+6GbOwV6bWM6Vkk2fB2JcWXIeaEd+i7lYFBaWhvF0gR7G4W4H4tRNWtWuno6R5NEiauels1QCBQupIuuxrlSUzO+YtC5kskIxmRQAfKkIfDbmqD6yP8LcixjQ7JxTsTHfGeiUdyJP3TwvcC1YzPPxU1lIBRD8+41zBGkoPBRew==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PAXPR04MB9304.eurprd04.prod.outlook.com (2603:10a6:102:2b6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.47; Thu, 3 Apr
 2025 10:56:20 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8534.043; Thu, 3 Apr 2025
 10:56:20 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Alice Guo <alice.guo@nxp.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Tom
 Rini <trini@konsulko.com>
Subject: =?gb2312?B?u9i4tDogW0VYVF0gW1BBVENIXSBwb3dlcjogcmVndWxhdG9yOiBzY21pOiBN?=
 =?gb2312?Q?ove_regulator_subnode_hack_to_scmi=5Fregulator?=
Thread-Topic: [EXT] [PATCH] power: regulator: scmi: Move regulator subnode
 hack to scmi_regulator
Thread-Index: AQHbmswHRR63eDdDBEe47H96cEgkmbOR1ibQ
Date: Thu, 3 Apr 2025 10:56:20 +0000
Message-ID: <PAXPR04MB96441F643A1FCC464C25CDA2E2AE2@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250322014444.174796-1-marex@denx.de>
In-Reply-To: <20250322014444.174796-1-marex@denx.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|PAXPR04MB9304:EE_
x-ms-office365-filtering-correlation-id: b33f6081-3070-407d-dd5b-08dd729e2ab6
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?gb2312?B?UXlUWTROR3Nab2N1cnR6OHlNMjJqTTNwNGgrSWFkbm1Ta1VPQzArTXlkdEdV?=
 =?gb2312?B?WWNtVE1mNU14T0h0dFUxWXVETUQybFUzUFVWcE1XcExmMDBjSXdIMGZaa2Nh?=
 =?gb2312?B?MTRFT1FMV3VhT2VCL1ZwVHF6TmZ0VUtsN1ZEMFNncGJXWkk2QzdXUytJbUZ2?=
 =?gb2312?B?SzEvREphc2p3Wmh1RFU0Nng4VklSN2EzZnovbGZBdklOZXdMcU5WVW5MUmN5?=
 =?gb2312?B?WTNvbjJSckpFRlRQRWZSU254VU5QQ0d6R0FZNGM1WGJZT2VVU0RaZkc4N0RO?=
 =?gb2312?B?NCtaekhZQzgrZkNHbko5cjVCWXNaWHowa1lmaWRBaENURWhUNTZDbDN6Z2p2?=
 =?gb2312?B?OGE0cmNzSVo2VkQ3TmZDbUtwZGk5aExudUVEdUpzK05Ec2FlQllLWk1yMGRH?=
 =?gb2312?B?Y3M5RnBJSXlBV0xYS1VMd0hHN0NMZGRCNElLczZmU0p2WWJsdFVSUUhxLzZo?=
 =?gb2312?B?R2JxQit1b0FZekxadWJRbkNIb0NjM0pmek95Rzd3T2EySTFBejVFck5Pckxm?=
 =?gb2312?B?WkxGVFBZWGtYR3VkQlBlZDdpbFZYVElHd2lrSzNHVGJJR3doUEpqWU5hQUdN?=
 =?gb2312?B?VkVZU1kyWEJ1aU14bkFIRnNqUFVwMXoxQ3pzWG12ZDBkbHYzbTBGMmFkd0kx?=
 =?gb2312?B?V2U3Z2xSczVYVU8xdjN4RzU2d3pBQUdadFpSWXBYc1hFY00xR3JSaVIxLzZ5?=
 =?gb2312?B?SGNxT0cra2xCVEFBeW95cHVsL3RIZnFzdFUyR2diakx4WDF3UjcxTnk3dDdh?=
 =?gb2312?B?ajg0ZEZCaEg4OUhhMHo0R093RmRLMEdrWmxubFZOQmREcDZnWTE2MWVxaWRF?=
 =?gb2312?B?NUY2MnRESjZyVHFpelp2SlkzMHRqb2tXSUVjRUlZVmpXeDdJaWtxeWYwRWNY?=
 =?gb2312?B?WE1hK2JteUlZYWo1dWViMlNmelFkYUVMRExjZWc3U1FVc2xoUnIwd2hlUi9k?=
 =?gb2312?B?dzBWOUtzOVVhbXNaUm14NlZPeCt1bXFqR0FGK1RndHhjMjJ6cnU1OTdwSnRs?=
 =?gb2312?B?K25JTEJTZzNPMnMzcDRtdTFrNk9GN0lnNDR1MHZERXF0dm9sNmo0cEVRMncw?=
 =?gb2312?B?SFNXK1VscWRKNElOSFlBYzVyQ21ub0lTSXE2S2dMWlBwZkZMZW5Qdjl4NlNW?=
 =?gb2312?B?alFzUkZVaDRobjkrWTRYdGRlb0MrdTBLbm9UK1lha3RnMk5vZG4xNDV6cGk1?=
 =?gb2312?B?ZGNWM1Z4aWlPdGNwTExWNXZrOWtjWlRPL0FqbnpaSERBREdNNHFCR25xdnRR?=
 =?gb2312?B?Y29GbGpKdlR3RUQ0UkpzYVd1UlNVTkdoV09xN2VTcUQ4YTFYQnkwcSs1bFFJ?=
 =?gb2312?B?aDY2SlhKKzFLdU1UMFMxZGE4akg1OHV4bUpiZ1FDRVExTzBsSW5TemVHNXl5?=
 =?gb2312?B?YlZhUlhNNS9IU084dUVma2t5T0RJejI4aGhZUnJVZGNJYUZ6Yng1Z1paUm5T?=
 =?gb2312?B?Y1d6U2lLT21OVHlmYUJWRStIa3Bqem50NWNuc2dlREZqMzVhR1BwdW5kNVh3?=
 =?gb2312?B?VUg2WkR3ZGo5NmgveGZWRU10TnczV2lidS9uU3E4emRYbVNYWXNZUzBBclAv?=
 =?gb2312?B?UHhXRUtHbXNjQ2pOK005KzFRSUhrdUlSTG5PV3RkQU5jTHVQMUdXcThFK1dr?=
 =?gb2312?B?TXhRSEt4c3lJQ3ludzF5UlJFNTZ4UTlPWWlsYXJJbkJCWVIzdERrNEtFRmwx?=
 =?gb2312?B?QjZwYTFYaGt2VzJ5dFcxU0RKR3F6a1I3YlNBMTB1TzBhZVlaSEd1bGV5UWMz?=
 =?gb2312?B?enBaN1dVVFBJejFBSmQrZnpIclVKa3ZpS0x5NGVudlhqVGN6OG5QTVVEaFI5?=
 =?gb2312?B?byt5bzM1bjFYZGVwUjdMNXh3Q0R5eUtUcUQwT2k2MVBDeWZTdC9SVytvYWM4?=
 =?gb2312?B?eTAzS0oxVmNibnRmR1VIclMrNDJWcXBkdk9nbjJyNlgyeU0xdktzWjcwSVA5?=
 =?gb2312?Q?mAe8pjbO0ikxARhoK/7hJT9zdmqvbBIe?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?TXMzSTdaSWlPck40R3hQV0o0RGY2Z3R5YjJ6L0pKSEdwayttb3dLVS90dW9H?=
 =?gb2312?B?bElNT3VNV25qK3ZRenZXNldkTHhCOWFEeTVoUVBwWFRVVGFHUFpDM1FlZlZq?=
 =?gb2312?B?ZldTV3BLcmhFOE43cGsrU2J0c09NR3EvWXliV3BWMU1FQUFZdDQzTHFqQ1hO?=
 =?gb2312?B?UWRoY0tBM3kwNkR5RjRIYmw2blE3RkNyWmZEM3RlOUNVeFJmeGFPbHZWeHpO?=
 =?gb2312?B?RTlJMU5TU1pQemFOS3oxS2xWNi9IeCsvOWF6RERHUHFHR1F5eEdTYXYzRTJY?=
 =?gb2312?B?UmNMb2xwTXNBejJ1ZkJhSmJPeE5laHZQRXp3WTg5RHpNL0ZLcVc2ZEZURGx0?=
 =?gb2312?B?NGZucW82RzZCVHlrWGl2cUpQRHJWc2lCVzhucEU4MHIyb1ZLZkgvR0NJUGxM?=
 =?gb2312?B?UkZyMGZlYUJ2ZDRYYzhWMldDeVloZGpvNWVxenpYcnVSYnlYSXIyREJxc2xH?=
 =?gb2312?B?Y01la1VMZGxqRHdHS3hlcm1rSElUU3dmeHVzOUg3dERzbWY0M2ZCNnpvQzhB?=
 =?gb2312?B?WHlNRlpWaXpFVUZ4QWxJYitleFhianlkN2s0MkdIRmF6TVBaWlpVaTlSU1Za?=
 =?gb2312?B?eWZKYVRGUGJ0NTFoUmFxekFSWkRFWmc5cE5BN2ZrUUI3OWtTU2doZzdybnN5?=
 =?gb2312?B?TUMzZm9mRVVyNW9tOVFvRUpzdFZ5bXNLV2lpdk9SS3pPdTdUWVp4TC9rZUNC?=
 =?gb2312?B?ajMwNzZVQ1NzN3BsRlp5VGNzM1d3Qm13OU5GQmlBcGZnMnlidkFSSzFSak11?=
 =?gb2312?B?OUhLbGtiL3hsWHVncXhQQmE0eWFhMEo2YW0yUVZDWjdIS2hkLy9EVVMxMGow?=
 =?gb2312?B?VjFYN0VXRzBWWFlqaFR6a3RGQmQ5T1RUNGlmZUtoSm9KRjBxY2w0QnRuUjM1?=
 =?gb2312?B?em91aXdxMmQxZWUrbkc2K3JUVXd0WTJZZTlpSzhZTFp6VjFZZEFYMHYyS2tZ?=
 =?gb2312?B?K0VSUkVvYmxSSEdtQ29oYUVyNkRkZ3Z5N2xNeTNxb2wrd2VudGZrMDB3UnRU?=
 =?gb2312?B?ZVZpclBLN0h6K2FNOE5udGxnQnFsWDkzRnpEaWJ1V1BtVC9veU5TUndHTkYv?=
 =?gb2312?B?SXJCdWhyTFB0SzJRTDhUeFh2bzlvMkh3V1l6WTdZdzdvYUZqY3hZT0NGRTZw?=
 =?gb2312?B?TGUvc1lHK1dGMVRGZGhQR0pxODZKRXNxcW9YSTdxY2hldWZ0dlFJT1M5RUxP?=
 =?gb2312?B?RlA2Si83MTJMaThDVXpFWUJuMTI4aTlsemNBOGsyZDRuSWI2S0xMN1k2aXFN?=
 =?gb2312?B?M1NSNXpuMEE5TTFyN25ja09MajBYZHFMWnVoZHhqQlpsdHAzV2h0dVczclZl?=
 =?gb2312?B?OXRFSUcxRURhc0xhMzdHT2RtWnByYkprcUNpSUhOZGI1d2M0VEFoMGt1RWhW?=
 =?gb2312?B?K0w2RWF1RGVSRHNzTWM5NkRyU3VjZHA5bHo2cTgweWMzOHlZTUJ3dnRTZnFV?=
 =?gb2312?B?eEtGQWtaWktxWG02aXBOdWJCU081ZDJtK2N3YzNjZDRjZ1crSWNQbEkwSkh5?=
 =?gb2312?B?SU5UVXo2NDczOHBuYnA4UExxdXVHMGxNMWtBamFEa2o2TS9VU0pVMGdWOEtk?=
 =?gb2312?B?VnZCU0ZMb0ZFN1Z1aHpITmJzSDAzZnVOQkxaYXNDOTR1TXEzSExQR0dxeE5X?=
 =?gb2312?B?UndNakk3NmJtbnVtODJHL01RZldDcVphbkkyYXdhdHRMbWZsL1hCcWt4OEdG?=
 =?gb2312?B?REg3TUxUNUJzQ1hkdjJSUzhEL2JoaGJjK2lrYzE2RmczNThXZmJ6dE12NURN?=
 =?gb2312?B?KzhRTkFFcE1CR0FZVlBBdFhJOUpST0NQVzhhUTJCSnZJMVhEUGx0MTdhNzZ3?=
 =?gb2312?B?T2NjN2xOLzJZc2t1Uzl4MUZhUlhXc3Z3TFFrNjhqZ0tLV1JtMURXa2hnUTVH?=
 =?gb2312?B?dXlncXdvZ3dSSXppcktiaGFSc1YwNEVsUC95NENndXhQUE9xcHQrSE1TTXJm?=
 =?gb2312?B?eEUzM1hYcWN4U0RwWS9CcTI1UjJ2RE9GKzMyUXNPMDhZY3hwYTFVSnpNR1NY?=
 =?gb2312?B?TjlQY0JUTHdzZFlwWUZmdCtrNnVBemU2eFB3bW54MGd6VzdKZXlJS3E2OXRI?=
 =?gb2312?B?S1BoQ3FFNjhUcXQveERTY3lVNTZUQ21ISFpwZEhBcER1ZnViRjZCdDF1RUZW?=
 =?gb2312?Q?aIb8=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b33f6081-3070-407d-dd5b-08dd729e2ab6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2025 10:56:20.3239 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RxiBEf2BHcF9et/I7jHcdWJEz5XaVnmiyNMLX9z90YLMG51lBWhKmAEEeCfweObcVSZRyxl8W3xP4rCvpLmJdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9304
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

PiAtLS0tLdPKvP7Urbz+LS0tLS0NCj4gt6K8/sjLOiBNYXJlayBWYXN1dCA8bWFyZXhAZGVueC5k
ZT4NCj4gt6LLzcqxvOQ6IDIwMjXE6jPUwjIyyNUgOTo0NQ0KPiDK1bz+yMs6IHUtYm9vdEBsaXN0
cy5kZW54LmRlDQo+ILOty806IE1hcmVrIFZhc3V0IDxtYXJleEBkZW54LmRlPjsgQWxpY2UgR3Vv
IDxhbGljZS5ndW9AbnhwLmNvbT47IElsaWFzDQo+IEFwYWxvZGltYXMgPGlsaWFzLmFwYWxvZGlt
YXNAbGluYXJvLm9yZz47IEphZWhvb24gQ2h1bmcNCj4gPGpoODAuY2h1bmdAc2Ftc3VuZy5jb20+
OyBUb20gUmluaSA8dHJpbmlAa29uc3Vsa28uY29tPg0KPiDW98ziOiBbRVhUXSBbUEFUQ0hdIHBv
d2VyOiByZWd1bGF0b3I6IHNjbWk6IE1vdmUgcmVndWxhdG9yIHN1Ym5vZGUgaGFjayB0bw0KPiBz
Y21pX3JlZ3VsYXRvcg0KPiANCj4gQ2F1dGlvbjogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4g
UGxlYXNlIHRha2UgY2FyZSB3aGVuIGNsaWNraW5nIGxpbmtzIG9yDQo+IG9wZW5pbmcgYXR0YWNo
bWVudHMuIFdoZW4gaW4gZG91YnQsIHJlcG9ydCB0aGUgbWVzc2FnZSB1c2luZyB0aGUgJ1JlcG9y
dCB0aGlzDQo+IGVtYWlsJyBidXR0b24NCj4gDQo+IA0KPiBUaGUgY3VycmVudCBjb2RlIGF0dGVt
cHRzIHRvIGJpbmQgc2NtaV92b2x0YWdlX2RvbWFpbiB0byByZWd1bGF0b3Igc3Vibm9kZQ0KPiBv
ZiB0aGUgU0NNSSBwcm90b2NvbCBub2RlLCBzbyBzY21pX3ZvbHRhZ2VfZG9tYWluIGNhbiB0aGVu
IGJpbmQgcmVndWxhdG9ycw0KPiBkaXJlY3RseSB0byBzdWJub2RlcyBvZiBpdHMgbm9kZS4gVGhp
cyBraW5kIG9mIGJlaGF2aW9yIHNob3VsZCBub3QgYmUgaW4gY29yZSBjb2RlLA0KPiBtb3ZlIGl0
IGludG8gc2NtaV92b2x0YWdlX2RvbWFpbiBkcml2ZXIgY29kZS4gTGV0IHRoZSBkcml2ZXIgZGVz
Y2VuZCBpbnRvDQo+IHJlZ3VsYXRvciBub2RlIGFuZCBiaW5kIHJlZ3VsYXRvcnMgdG8gaXRzIHN1
Ym5vZGVzLg0KPiANCj4gRml4ZXM6IDFmMjEzZWU0ZGJmMiAoImZpcm13YXJlOiBzY21pOiB2b2x0
YWdlIHJlZ3VsYXRvciIpDQo+IFNpZ25lZC1vZmYtYnk6IE1hcmVrIFZhc3V0IDxtYXJleEBkZW54
LmRlPg0KPiAtLS0NCj4gQ2M6IEFsaWNlIEd1byA8YWxpY2UuZ3VvQG54cC5jb20+DQo+IENjOiBJ
bGlhcyBBcGFsb2RpbWFzIDxpbGlhcy5hcGFsb2RpbWFzQGxpbmFyby5vcmc+DQo+IENjOiBKYWVo
b29uIENodW5nIDxqaDgwLmNodW5nQHNhbXN1bmcuY29tPg0KPiBDYzogVG9tIFJpbmkgPHRyaW5p
QGtvbnN1bGtvLmNvbT4NCj4gQ2M6IHUtYm9vdEBsaXN0cy5kZW54LmRlDQo+IC0tLQ0KPiAgZHJp
dmVycy9maXJtd2FyZS9zY21pL3NjbWlfYWdlbnQtdWNsYXNzLmMgfCA4ICstLS0tLS0tDQo+IGRy
aXZlcnMvcG93ZXIvcmVndWxhdG9yL3NjbWlfcmVndWxhdG9yLmMgIHwgNiArKysrKysNCj4gIDIg
ZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZmlybXdhcmUvc2NtaS9zY21pX2FnZW50LXVjbGFzcy5jDQo+IGIv
ZHJpdmVycy9maXJtd2FyZS9zY21pL3NjbWlfYWdlbnQtdWNsYXNzLmMNCj4gaW5kZXggOGM5MDdj
M2IwMzIuLmU2ZTQzYWU5MzZhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2Zpcm13YXJlL3NjbWkv
c2NtaV9hZ2VudC11Y2xhc3MuYw0KPiArKysgYi9kcml2ZXJzL2Zpcm13YXJlL3NjbWkvc2NtaV9h
Z2VudC11Y2xhc3MuYw0KPiBAQCAtNDI3LDE0ICs0MjcsOCBAQCBzdGF0aWMgaW50IHNjbWlfYmlu
ZF9wcm90b2NvbHMoc3RydWN0IHVkZXZpY2UgKmRldikNCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgYnJlYWs7DQo+ICAgICAgICAgICAgICAgICBjYXNlIFNDTUlfUFJPVE9DT0xfSURfVk9MVEFH
RV9ET01BSU46DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChJU19FTkFCTEVEKENPTkZJ
R19ETV9SRUdVTEFUT1JfU0NNSSkNCj4gJiYNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAg
IHNjbWlfcHJvdG9jb2xfaXNfc3VwcG9ydGVkKGRldiwgcHJvdG9jb2xfaWQpKQ0KPiB7DQo+IC0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbm9kZSA9IG9mbm9kZV9maW5kX3N1Ym5vZGUo
bm9kZSwNCj4gInJlZ3VsYXRvcnMiKTsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBpZiAoIW9mbm9kZV92YWxpZChub2RlKSkgew0KPiAtICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgZGV2X2VycihkZXYsICJubyByZWd1bGF0b3JzDQo+IG5vZGVcbiIpOw0K
PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTlhJTzsN
Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9DQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICBzY21pX3Byb3RvY29sX2lzX3N1cHBvcnRlZChkZXYsDQo+ICsgcHJvdG9jb2xf
aWQpKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRydiA9DQo+IERNX0RSSVZF
Ul9HRVQoc2NtaV92b2x0YWdlX2RvbWFpbik7DQo+IC0gICAgICAgICAgICAgICAgICAgICAgIH0N
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ICAgICAgICAgICAgICAgICBkZWZh
dWx0Og0KPiAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvcG93ZXIvcmVndWxhdG9yL3NjbWlfcmVndWxhdG9yLmMNCj4gYi9kcml2ZXJzL3Bvd2Vy
L3JlZ3VsYXRvci9zY21pX3JlZ3VsYXRvci5jDQo+IGluZGV4IDk5ZjY1MDZmMTYyLi4yNTUwYjI3
MjQ2ZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wb3dlci9yZWd1bGF0b3Ivc2NtaV9yZWd1bGF0
b3IuYw0KPiArKysgYi9kcml2ZXJzL3Bvd2VyL3JlZ3VsYXRvci9zY21pX3JlZ3VsYXRvci5jDQo+
IEBAIC0xNzgsNiArMTc4LDEyIEBAIHN0YXRpYyBpbnQgc2NtaV9yZWd1bGF0b3JfYmluZChzdHJ1
Y3QgdWRldmljZSAqZGV2KQ0KPiAgICAgICAgIG9mbm9kZSBub2RlOw0KPiAgICAgICAgIGludCBy
ZXQ7DQo+IA0KPiArICAgICAgIG5vZGUgPSBvZm5vZGVfZmluZF9zdWJub2RlKG5vZGUsICJyZWd1
bGF0b3JzIik7DQo+ICsgICAgICAgaWYgKCFvZm5vZGVfdmFsaWQobm9kZSkpIHsNCj4gKyAgICAg
ICAgICAgICAgIGRldl9lcnIoZGV2LCAibm8gcmVndWxhdG9ycyBub2RlXG4iKTsNCj4gKyAgICAg
ICAgICAgICAgIHJldHVybiAtRU5YSU87DQo+ICsgICAgICAgfQ0KPiArDQo+ICAgICAgICAgZHJ2
ID0gRE1fRFJJVkVSX0dFVChzY21pX3JlZ3VsYXRvcik7DQo+IA0KPiAgICAgICAgIG9mbm9kZV9m
b3JfZWFjaF9zdWJub2RlKG5vZGUsIGRldl9vZm5vZGUoZGV2KSkgew0KPiAtLQ0KPiAyLjQ3LjIN
Cg0KSGkgTWFyZWssDQoNCklzIHRoZXJlIGEgcHJvYmxlbSBpbiB5b3VyIHBhdGNoPyBTaG91bGQg
aXQgYmUgY2hhbmdlZCBsaWtlIHRoaXM6DQotLS0gYS9kcml2ZXJzL3Bvd2VyL3JlZ3VsYXRvci9z
Y21pX3JlZ3VsYXRvci5jDQorKysgYi9kcml2ZXJzL3Bvd2VyL3JlZ3VsYXRvci9zY21pX3JlZ3Vs
YXRvci5jDQpAQCAtMTc1LDEyICsxNzUsMTkgQEAgVV9CT09UX0RSSVZFUihzY21pX3JlZ3VsYXRv
cikgPSB7DQogc3RhdGljIGludCBzY21pX3JlZ3VsYXRvcl9iaW5kKHN0cnVjdCB1ZGV2aWNlICpk
ZXYpDQogew0KICAgICAgICBzdHJ1Y3QgZHJpdmVyICpkcnY7DQorICAgICAgIG9mbm9kZSByZWd1
bF9ub2RlOw0KICAgICAgICBvZm5vZGUgbm9kZTsNCiAgICAgICAgaW50IHJldDsNCg0KKyAgICAg
ICByZWd1bF9ub2RlID0gb2Zub2RlX2ZpbmRfc3Vibm9kZShkZXZfb2Zub2RlKGRldiksICJyZWd1
bGF0b3JzIik7DQorICAgICAgIGlmICghb2Zub2RlX3ZhbGlkKG5vZGUpKSB7DQorICAgICAgICAg
ICAgICAgZGV2X2VycihkZXYsICJubyByZWd1bGF0b3JzIG5vZGVcbiIpOw0KKyAgICAgICAgICAg
ICAgIHJldHVybiAtRU5YSU87DQorICAgICAgIH0NCisNCiAgICAgICAgZHJ2ID0gRE1fRFJJVkVS
X0dFVChzY21pX3JlZ3VsYXRvcik7DQoNCi0gICAgICAgb2Zub2RlX2Zvcl9lYWNoX3N1Ym5vZGUo
bm9kZSwgZGV2X29mbm9kZShkZXYpKSB7DQorICAgICAgIG9mbm9kZV9mb3JfZWFjaF9zdWJub2Rl
KG5vZGUsIHJlZ3VsX25vZGUpIHsNCiAgICAgICAgICAgICAgICByZXQgPSBkZXZpY2VfYmluZChk
ZXYsIGRydiwgb2Zub2RlX2dldF9uYW1lKG5vZGUpLA0KICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIE5VTEwsIG5vZGUsIE5VTEwpOw0KICAgICAgICAgICAgICAgIGlmIChyZXQpDQoN
CkJlc3QgUmVnYXJkcywNCkFsaWNlIEd1bw0KDQo=
