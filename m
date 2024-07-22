Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6032C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 04:53:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C9BF88005;
	Mon, 22 Jul 2024 06:53:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="W7TEP9Uy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 112CD88189; Mon, 22 Jul 2024 06:53:46 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF00188137
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 06:53:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhiqiang.hou@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rHz+/IMxmjMjcE2toF0PwnPpeJwijDBX4N2JbduAaROejwmMmLYY/ji1G1D6/waZZp2E/l+QU0WeDzxD7iEM7qnJhhPtAT0mtU0SGlKdYB8nvFiBgkgPJRimbhdB3f0gL3i+UGKe4F8ukqSKyuymg3NUI0Paqr/S/+75DUbbbaLiJ4qni3K/XAcTPn8S5MkH45kd8quvKKxv45PiWbio5NgPX0w6tvb7n7Tzh9j7YdZ4SOMnfjJx3PzBup/a0yTF3P2c4iPZZrRdmtZ6hd5VZUxAMKUT8ol1+h98WnykB17CqHZps8mj6lCR/dsrqinC5u+/ItouiIXVlMLJzz0ovA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+ZK8iYLVq2gPLjDcAHhG/KB87OviFV95WH/BuEzVLc=;
 b=dxO5SmQ6OYevbYB51f7lv16pYVnwWXeYM+xlSIPJvVCK029+Ne/E0XLDmW0ZywGCGTv7W1lWxh3O60RnPz0QjfKZPvSe3I+LSI002UmvHRDYKiOp/vTJZwqr+/GqMvPgk/j/P3TyFAzgh8/bsxIdV/3DoQdCC5MBrGph1p/Y0g1U4f62J0z0bOZNG+2phkreIq3vyOAf2eFvhwgyG7jzp3EWKh3IDT1+xLJqfa3+OA6Ml0wOyIFM8fwpB/9MNlVbBU9Iw4j7ifiExzrZw37QmALlovgNXhj1Mq/SJG8oNgNKFWlgteifa//TKR/2v+Hr2l/9MChr1m9c5NmCyA2KfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+ZK8iYLVq2gPLjDcAHhG/KB87OviFV95WH/BuEzVLc=;
 b=W7TEP9UyCB1RgPcA5eqXipTK9dR5r190A5igwNDn+3h5PtMXRkWFdWbjE7MgNonRF/Ovvhs7eiabsRwSg9Z48iv0sZOc61+wj/A3Alus3Y4rTI3vOMF59SNzwB3TDFlvRgVCV3NXXehvXYP2VOOupBun+KEemjQ/soEafc/ZnN0=
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com (2603:10a6:10:370::16)
 by PAXPR04MB8974.eurprd04.prod.outlook.com (2603:10a6:102:20d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Mon, 22 Jul
 2024 04:53:41 +0000
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::9903:6f05:ded5:924f]) by DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::9903:6f05:ded5:924f%4]) with mapi id 15.20.7784.017; Mon, 22 Jul 2024
 04:53:41 +0000
From: "Z.Q. Hou" <zhiqiang.hou@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "sbabic@denx.de"
 <sbabic@denx.de>, dl-uboot-imx <uboot-imx@nxp.com>, "trini@konsulko.com"
 <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Yi Zhao <yi.zhao@nxp.com>, 
 Jiafei Pan <jiafei.pan@nxp.com>
Subject: RE: [PATCHv1 1/2] mp: imx8m: add cpu command support
Thread-Topic: [PATCHv1 1/2] mp: imx8m: add cpu command support
Thread-Index: AQHa2cCer9YJzGqEdEC88/KnBi/y2LH962SAgAAhFCCAAA0qgIAEF/8g
Date: Mon, 22 Jul 2024 04:53:41 +0000
Message-ID: <DB9PR04MB9236F8E705D5D2951E15CC3A84A82@DB9PR04MB9236.eurprd04.prod.outlook.com>
References: <20240719100758.1917-1-Zhiqiang.Hou@nxp.com>
 <20240719100758.1917-2-Zhiqiang.Hou@nxp.com>
 <CAOMZO5BoEqV_h5RdLKZitt+GDwAMyV7T6jH3P=t_TnovYMEd2g@mail.gmail.com>
 <DB9PR04MB923670C9D250CCA833DA659A84AD2@DB9PR04MB9236.eurprd04.prod.outlook.com>
 <CAOMZO5DSq+VFCBbFLOvgmtHN_4DFsxvdKSLFP0oaF2sSAEOoOw@mail.gmail.com>
In-Reply-To: <CAOMZO5DSq+VFCBbFLOvgmtHN_4DFsxvdKSLFP0oaF2sSAEOoOw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9236:EE_|PAXPR04MB8974:EE_
x-ms-office365-filtering-correlation-id: dc7cf869-8c1b-4483-dbbe-08dcaa0a4255
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ckVLVjRQQWFMdG5ycjNZeFU0Z1hxeFljaGVKTjlYcm5JQ3o3bVlLQzNYSmxX?=
 =?utf-8?B?WFVveTAxdnpXNlBWKzZwb3VYZ054eFZSVkZLem5na3ZCT014b2RycjZmOVlP?=
 =?utf-8?B?VXZnTDcxSWdBcGExVE5WeXIvdm1SdVV2WFdYNjBwUGdicGZFTVRwY1J4SEMr?=
 =?utf-8?B?QXljZHpGRmY4b28vUWZHd0sxcVJXSHRiMTFaYm95d3pBVDhFZ251bVBXNUJO?=
 =?utf-8?B?YURRSFg1TkJQTTdqTHFNS3BBMDVOVEJwZ3lIUXZvaldoWjVDdERMZnpkOUxq?=
 =?utf-8?B?RXNGallGTmJ4T2lhRUgvSUVSZ1JZQTIyb2p3aEdWdHBTZkp6MEFTR0JUdkVk?=
 =?utf-8?B?Y3Z1WEppV3Y1TWdtL3FLS2ZUd1RVV3N3MkwzRkl1bjZ0WGZrYmlobThnSy96?=
 =?utf-8?B?Y2dVS21OMzF6Q1YvQ01RSUtXUE54aXdxNDRZQUFuYy9hOTB3em5scmdXZ25n?=
 =?utf-8?B?TldPWkx3dDdKbXNnd2JrRGhOWFE1TWpxbkg3eFh2Y1VKUkdnTDA5ckMxQ21Z?=
 =?utf-8?B?TmhZdC80TG9mYUYzUlUzcC93UkFhL0FpTnhsS3ZNS29SalFOSWFaVDJseWta?=
 =?utf-8?B?aXBqcS9kdytSSW1MZCt5aHk0Z0xxMzNXeWszd0Qxd3dlZ1RvSk1EcFFhbmpC?=
 =?utf-8?B?dk9URjk1UXA4WkFjbHA2cE5HaWx2KzVyb1ZYaVdKYTl3NlhKWnRjekRZQzZO?=
 =?utf-8?B?bVBxY0k1OWd4bW56L1pZMVZYeUxqdjQwUkVDMWVYaWxGeDRRU2ZuWUVmREJO?=
 =?utf-8?B?Nk83d2FwQXFBSDlZZzVUUnpEYkFsQnAzTEhhdXFJUWR5amJTbUJEdWQ0K0xz?=
 =?utf-8?B?QzdNRDhCV2VDRVQ2RTllbktkMlVNdENBZENCeWZlTzI5Z0JYYWZlSXpmY2hH?=
 =?utf-8?B?L2dYWlRxQWxnVU84anpxWmY5eFlYUHpDNnJwTlI0Z1NyOXk4RWhoMkU1ZmlT?=
 =?utf-8?B?Snk4ZjFqTGJuZ3FVVGZ5bUtXa2cyUHpwb2tYb0dDbmNqaXkySUhTVlR1ZU0z?=
 =?utf-8?B?Y05Ra0tEc1F6UXBhQktRa3FCMXRSYkJLdFpVQTNJak0zL0pmYzIvanllUHJZ?=
 =?utf-8?B?ZWVKU1d3OWYrVUVpMUNSdWtLNklwSVVSc0ltekNRT3g5ZXpGOWt2R2RIckxE?=
 =?utf-8?B?TVN2MUw3bUFwVHQ3OGhPSEtHZkdYNkI0M3Q3dG5nemNWK2R6SlZUaExoNVJL?=
 =?utf-8?B?a2tSMkVFTG52dVJodEZWTUVYYnVrdTQ2a1FSRjNyUzkxTzVVWFNsNForTjlG?=
 =?utf-8?B?OFU3MlJiUHFyV0E5Z2oydEhtMkV0c2h2T2hxNFhwK2UzSnJXekxiYXdxZGph?=
 =?utf-8?B?WUNLaTdhWDBHdEVEcFNOanZPVnpyUzdaU1M1REprdlFQME9IcFBjbkFGVnVk?=
 =?utf-8?B?NFZONDQ2UHB6NDVTQ2Mzb3NtYkgzOUhZSWxOc3ZESUk2TDM0U2U5V2h4YUFj?=
 =?utf-8?B?d0RwdXNRTUYzUm9HMnZSTy9vajhockZPRVN2b2Z1VTlEcnlyT2lnM2NYN2Iw?=
 =?utf-8?B?VE1GcGdZZ3Jwem8rR01nem1WTDZybForK1ppRHFzREQ5by9kVi80MHhJNnFN?=
 =?utf-8?B?MGNOMlZVLzIwbktjRzlrWUJzVXdPdlFhMjJBb1JrK1c5NjdTbUYxVEFJajh6?=
 =?utf-8?B?OU9YWU04QmRSU1lpVTJIVkt3WllBRGJRck05dU1DZHJDdzJGQlB6a1lZOGJZ?=
 =?utf-8?B?eFdLR3VyRjhOUjZGRFFPWWlOQjl3VzlSNGdjTDhmemdlenJtaTM4RFVML3FY?=
 =?utf-8?B?SGxNVTNHVTN5N2R0VXhhQVdkT0FQZnNlcHhvaHZ3c3RSbDBxSXY1N1JSTE1K?=
 =?utf-8?B?YVU3cFphWWJpeVRYRTJVOGI1ajJ6VTNvay9MaEJWd1grZ0dDeGpZRGZ1Y2Ju?=
 =?utf-8?B?OXRDYXk2U013d0hCNkxJUG5tb0dNbVI3ZVk4cmlZNU9sWHc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB9236.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXk4cDNDS0hpWk1uUlRuU0JXZGoxdW5nVHRseng4MWJlMVRpaHJZWXBRMC9i?=
 =?utf-8?B?NFJzVlltMG1SVkNPTXRSL3oySDF1Vk1JYk1wSWxaOHB6QUoyWm93UjM0Rzla?=
 =?utf-8?B?MHE4OXkwNnpVcnR6cmU4T0VVaTh1UEVLRndlZVNZckc3UkxSYnJWR29WVmg5?=
 =?utf-8?B?dUR4cE5ON0VUQjBKbTZqOHBtQ25UQjBCYUp2cGZ4MHNSRHloTk80WGVjUGRN?=
 =?utf-8?B?aEw4R1M1S28yRWpoeWVDL1hnRWJyeDc2NTJ6NHFWMjloZE15cVZMaGdITlRP?=
 =?utf-8?B?VElxTEFFWkdJNmhxR21Jdm9nUGRGdGo0dnJXbmZYU0RsVUtwa0swZTQvMHYy?=
 =?utf-8?B?ZzhUaktnd3B1VzZhMUNHSlE1ek5aZEpTMFVpVmhLVFJzUlNnZFJWSGVFZ1Mz?=
 =?utf-8?B?MmJZbnNEc1QyNWgyYXc2ZzVvUEE4VVloaTU1Wjg5RkxmNkNMZEliZ1A5Yzcz?=
 =?utf-8?B?bWIwTi9xZjVJSFQ5L0RybUVKOE1SWWNIYXE1Vld5Vis2ZzZTdWl0L2F2L2p3?=
 =?utf-8?B?TThlQnMrK21yWFpDZFFMSzBVRUR5bTlrdmNNMklGWis0ZWxGQVJ4Y25McG8y?=
 =?utf-8?B?SFR6MlpwaXFWLyt6TlVvYlhaOFpvN1d2dVBwdVhOVFlUM0NWMXI3Z2xjajQr?=
 =?utf-8?B?Yk5pOWI5Z2Q4SGQ5ZnM1a2RPQ1lxYTBnVVFQV2xTQWVNNGt5dk9ERVU4cjM3?=
 =?utf-8?B?Zm40bHU5L0lSYXFXS2todEpuRVJYVW9mZUZZY3pkaVh2VGtqQUM3eElzR2tR?=
 =?utf-8?B?ZGlodkY4Z0JkQ3QrS2J1UlR3TzEvL0JrSXg0cVhMUEFkVUxtZkt6NDN6RE1J?=
 =?utf-8?B?MW44cVhZSEUwbG56VDNKbUcwS3VKalFYL3UrZ2F0TGFCM2lBeHhWK0xjN3lD?=
 =?utf-8?B?c0NJYjF1L3lWaG5vMmpwUnY1K3I3WTYxeEV3aXh5cEFmNHl3MjQyK0dKckt6?=
 =?utf-8?B?VXZYRWJVL1JCYWN0Q2R5bG9uUkZsaVFDNGdoVUp3UWFYSUV0VmMvU083Sjl0?=
 =?utf-8?B?VDNJam5QVVA0M0E3Z2R6aGk1Mk1TUTB1alNUWExSVmp1Y1NhalYwUjVyemtS?=
 =?utf-8?B?V3FIa24xOFJEZ3l0RG5PTmpSYXJDRU9WT0M3QVk3NUd5TjUvSk5ScGRQZ2py?=
 =?utf-8?B?SWJqZnczR20rem5ybTJNUTBHNEdhQkl4aTlPbGFEeHQ0aVlGN0FtNjh2cW1S?=
 =?utf-8?B?amNMb29ZbVBQWTlnM0QwQXMyTjdsZmNhUzNPc241RVlKL1ovelp1T3U3YmdC?=
 =?utf-8?B?eExCamtqWlpLS1dZTEJwNXlIMHlsdUVjcFpHTjhQM09IengxOUVRbGNtZllE?=
 =?utf-8?B?M3ZGNk01bjFFQXlWUkJZQlNKY0tVdWRrKzhUdEd2V21DVXNQN3lmMUpFRmxB?=
 =?utf-8?B?RHpxSklqakdmYzMrOW9OTVFDZWU2ZElhUGc1QmlLRFlrMXpFWnFwVHYzaHNr?=
 =?utf-8?B?aGNWUmNiMTZsbzdobmlDa0hIZXRvam5qUEk1NWNHNkdycklHMlJTL2gwMHM3?=
 =?utf-8?B?TVhIdVFlTFZPSHg1MkR6ZjRMQWlPVU9uKy9wUTJaK3hkTUZuWjdnUm1YbmJj?=
 =?utf-8?B?cDh1S3cyS3VqdVBJTmEzNHRoUjhuM3p3WnJ4Wnl2TkZsWjJ4VUxaY1lwUDlD?=
 =?utf-8?B?V3hRcjdyc3lVem52eUpGMGFza2ozSHZjbGN3b2xLYVd4NHdrUUkzdEhZUmFj?=
 =?utf-8?B?N2tvK3pVMStWNmJEY0cwZG5od09qWTdDcHY4TDhKa293Wk9yd0c2dW5QT29C?=
 =?utf-8?B?TWFHNXd1NHZMTjNGQ1BHd2Y4Y1VnSEJNenBPaWVwRUZ2SmFycnl2dWhNazBs?=
 =?utf-8?B?R0dobUlQNTY4S2dZRCs1UnlOV3B2OEExYkduM2VnN2o1V1BoMzNJOXZuMG9E?=
 =?utf-8?B?bTVpQ0Zadmh3UWtiM3ZrR2d0UmpSbUdNTDVCcTlZZ0pVLzZ6aHhDUi90QU9x?=
 =?utf-8?B?RFV1Yzk2KzJhM085U3ZSeHBiaTR0UTlMT2l1bnAwK1grYTJjR3hZMFN2eGFz?=
 =?utf-8?B?M0NIWEJqZkhqaE9aMDF2WFdIUWFNMWNrWlpmekJsbElDbTd0SFB4Y0pMSyt5?=
 =?utf-8?B?Tjd6SVFWb0RTR0I1ZDRFVzYwbUh0QnBRK0hYVUxQQ1h1bUE4VVducHNQbjZY?=
 =?utf-8?Q?SR5JwS+raSTuKnXjEG/1T5rsE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9236.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc7cf869-8c1b-4483-dbbe-08dcaa0a4255
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2024 04:53:41.8550 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kERDB7hyzW80xynhee6MFy8GGC/X7L8T/8yPuNQq+1pE7Tza7vE7Nk5Fn9P+dTiUh5tHyIRIizicU+7s4vHFtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8974
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

SGkgRmFiaW8sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmFiaW8g
RXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPg0KPiBTZW50OiBGcmlkYXksIEp1bHkgMTksIDIw
MjQgMTA6MTkgUE0NCj4gVG86IFouUS4gSG91IDx6aGlxaWFuZy5ob3VAbnhwLmNvbT4NCj4gQ2M6
IHUtYm9vdEBsaXN0cy5kZW54LmRlOyBzYmFiaWNAZGVueC5kZTsgZGwtdWJvb3QtaW14DQo+IDx1
Ym9vdC1pbXhAbnhwLmNvbT47IHRyaW5pQGtvbnN1bGtvLmNvbTsgUGVuZyBGYW4gPHBlbmcuZmFu
QG54cC5jb20+Ow0KPiBZaSBaaGFvIDx5aS56aGFvQG54cC5jb20+OyBKaWFmZWkgUGFuIDxqaWFm
ZWkucGFuQG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0h2MSAxLzJdIG1wOiBpbXg4bTog
YWRkIGNwdSBjb21tYW5kIHN1cHBvcnQNCj4gDQo+IEhpIFpoaXFpYW5nLA0KPiANCj4gT24gRnJp
LCBKdWwgMTksIDIwMjQgYXQgMTE6MDHigK9BTSBaLlEuIEhvdSA8emhpcWlhbmcuaG91QG54cC5j
b20+IHdyb3RlOg0KPiANCj4gPiBUaGlzIHBhdGNoIGlzIHRvIGFkZCB0aGUgbmVlZGVkIGZ1bmN0
aW9ucyB0byBlbmFibGUgY21kL21wLmMsIHdoaWNoIGlzIHdlbGwNCj4ga25vd24sIHNvIEkgZG9u
J3QgdGhpbmsgaXQncyBuZWNlc3NhcnkgdG8gYWRkIGFuIGV4YW1wbGUgdG8gdGhlIGNvbW1pdCBs
b2cuDQo+IA0KPiBJIGhhdmUgbmV2ZXIgdXNlZCBjbWQvbXAuYy4gSSBzZWUgc2V2ZXJhbCBvdGhl
ciBMYXllcnNjYXBlIGJvYXJkcyB1c2UgaXQuDQo+IA0KPiBIb3cgZGlkIHlvdSB0ZXN0IHRoaXMg
c2VyaWVzPw0KPiANCj4gUGxlYXNlIHNoYXJlIG1vcmUgaW5mb3JtYXRpb24gYWJvdXQgaXQgaW4g
dGhlIGNvbW1pdCBsb2csIHN1Y2ggYXMgdGhlDQo+IGNvbW1hbmQgbGluZSB5b3UgdGVzdGVkLCB3
aGljaCBPUyB3YXMgdXNlZCwgZXRjLg0KPiANCj4gVGhpcyBpcyBpbXBvcnRhbnQgaW5mb3JtYXRp
b24gaW4gdGhlIGNvbW1pdCBsb2cgYXMgeW91IGludHJvZHVjZSBhIG5ldw0KPiBmZWF0dXJlLg0K
PiANCg0KUGVyIFNpbW9uJ3MgY29tbWVudHMsIHRoZSBjbWQvbXAuYyBpcyBkZXByZWNhdGVkIGFu
ZCBJJ2xsIG1vdmUgdG8gYWRkIGEgJ3JlbGVhc2UnIHN1YmNvbW1hbmQgdG8gdGhlIG5ldyAnY3B1
JyBjb21tYW5kIGluIGNtZC9jcHUuYyBhbmQgd2lsbCBhZGQgYSBleGFtcGxlIGluIGNoYW5nZSBs
b2cuDQoNClRoYW5rcywNClpoaXFpYW5nDQoNCj4gDQo+IA0KPiA+DQo+ID4gPg0KPiA+ID4gPiAt
LS0gL2Rldi9udWxsDQo+ID4gPiA+ICsrKyBiL2FyY2gvYXJtL21hY2gtaW14L2lteDhtL21wLmMN
Cj4gPiA+DQo+ID4gPiBXaGF0IGRvZXMgbXAgbWVhbj8NCj4gPg0KPiA+IFNob3J0IG9mICdtdWx0
aXByb2Nlc3NvcicsIHRoZSBzYW1lIG1lYW4gYXMgY21kL21wLmMuDQo+ID4NCj4gPiBUaGFua3Ms
DQo+ID4gWmhpcWlhbmcNCg==
