Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0903CE7D0D
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 11:21:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6314189179;
	Tue,  1 Oct 2024 13:21:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="FgfUQnC/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED3BC89198; Tue,  1 Oct 2024 13:21:00 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9B7D89152
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 13:20:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q6bRoZMLil3KxUgGlrbiDme8yAtfUWiABM+Zg2LJ8qLD+OzjSSZb1y6Q73nc3cIjxOO49awUm7iWv0EgLtufEjkgvCJL4HU6mojOdDHX7to6AIHlnkWQMh/iesURScXvHvCYU1G6fAXC4NTEdzBGb10ZkIbZUb+bSAnrTPykEI32NSRJtXV6/ZAUe3VSiC9yRJobxRvMbAxv+zsF9278sFabrAsqVvvs0vBDxpmo0J5CQcsPRzvcKKt8r/bCKIgWCvjlOObV7wvD59hTLJ3sxse24bOPbIizuQHKY6ZpbK9Bcz1pLweeENTT4VQYoYE8PMFLDhVJQXkWFakXoTXqcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TirNdoP6ydvU9/LtiwXSn4tonosZGHrzw0p/CCm7deU=;
 b=nVy1sZ781Jba5sZcywdODZWv+49Ssu7i4jhz38CmzCOh3fur5iE/G+D3qqAqozI5UeM8dNtFQDZRBJlRUB5lyt1mFsgvhSlE4YT294QPxgux0XfySqs3r+c5TMGokRZzWbZpgWCwVRuL2CBvPKK5plmyf2LIxsVBods+24v+dG+U3Fc2jA54CePdGmo0uGQukD1+fCFtgm+kn2sDAKAT481rA99NXD6wOcVXvV+xzDby4SPxuc5H1Y/2Zvy8vn/0OG1sm8sMf82amD48vsk9rzdBcWaDUu68EqD87iMuJbcnUMP0JzSwMlNI07VkHyp1p5xMnjUlgu7RqZq7god42w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TirNdoP6ydvU9/LtiwXSn4tonosZGHrzw0p/CCm7deU=;
 b=FgfUQnC/s7OR4VGGZB+xvnyYVTyZAIoDSEYiQgdSpZ980nDVByRGK3ljnyjMZtdd36/jNEoAogSpFB72A7OtOa/gvR6zjEKpjtIGxbl/2a/ZX66L/aVBgmVxQa4lVnarg8en3apYkCq2KI9oLCkTt/o6T9j61uAW23Q/UpgzR178bMaNhMMDS+fJ2SumimeJTP6zIeZt98NlQOTsZC93+svg6rRW10aL6tCGynplglxM1nyhGeFJ5v3W/3Za11pyhLOf1xagDjAdzVIG3RmneOFo6RMVx2i6v4BuB+UxkkPcAUzof9P8dAXVfru/H1IXild3kWHiC3WfYw59nBXZyw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM7PR04MB7158.eurprd04.prod.outlook.com (2603:10a6:20b:120::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 11:20:49 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Tue, 1 Oct 2024
 11:20:49 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: "sbabic@denx.de" <sbabic@denx.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini
 <trini@konsulko.com>, dl-uboot-imx <uboot-imx@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: RE: [PATCH 1/5] mmc: fsl_esdhc_imx: Enable AHB/IPG clk
Thread-Topic: [PATCH 1/5] mmc: fsl_esdhc_imx: Enable AHB/IPG clk
Thread-Index: AQHbEvwyMe4OQS8N8Eae/WVzRzKoW7JwLpSAgAGSzIA=
Date: Tue, 1 Oct 2024 11:20:49 +0000
Message-ID: <PAXPR04MB8459DD7A606439C37EE3085888772@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240930065041.5554-1-peng.fan@oss.nxp.com>
 <CAOMZO5DDL_AkGr1_TZHLwowvypmMnuD1b7DGGjoNdECPL9WHyA@mail.gmail.com>
In-Reply-To: <CAOMZO5DDL_AkGr1_TZHLwowvypmMnuD1b7DGGjoNdECPL9WHyA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM7PR04MB7158:EE_
x-ms-office365-filtering-correlation-id: 286da13a-fc44-43b1-b795-08dce20b1a24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cVoxSENSS3IvUlRKM09OYk9ROWsveWttQkQ2RWhZNmxFanJyWmpHaXpIRlFB?=
 =?utf-8?B?aEdGMmorVi9NZnd4clBWN1FkMG1oNE9hVHZ3NjMzZjlTZUVmRUdGQURqRG9Y?=
 =?utf-8?B?RUNyVW01UXEvMlEwdEl5TDExZHNmRnBGRWJjTmZQWXpGTCthczdyWS9IdzNl?=
 =?utf-8?B?WUxuNThEZ3JyK1dUMURZN0RpK3BKV2JIUkRwUEtSL1dLQUYyYjJwSkRDVUFO?=
 =?utf-8?B?K2dsL0tBTnlHeDd1aGRUYjZON3N0eDV6ZzJaTXZGWWxuLzliM3FpWTNpTVFp?=
 =?utf-8?B?NHlmbGh6c1J3WW5Xd2FPUjFyUEhnNFBnRFA3SXA2cFBoVmkyZWhxaXpPY2pL?=
 =?utf-8?B?T1BON1BoTnZNbmZ4TVU5WUNLb2w5L1F4azZWNlh5NlVpb0RMems0TzUrYzRv?=
 =?utf-8?B?UDZITklNSXZvZ1I4NjZjMzF1cWlLNExnSzF0OFNHOFB1SDRMVGtKMGM4Z3A2?=
 =?utf-8?B?ZEZGbThic2Q2RU9BNVVLMUE3VXo1UkVYeE01aVVINTllY3ZlbC9hOVJpejFS?=
 =?utf-8?B?U2hTNjYxMENNcklkMGIySU9ESE5ubTZDTTUwUVo2K0RValFNRHQrNnp4Mkli?=
 =?utf-8?B?VHJGejZHbHN4TGxjRytTelZ1ajJXNUpCNzdicjR1eEI1Unk3Y1lVbnRhYnht?=
 =?utf-8?B?QjdKc1dVTFl0M1lzZGJBcjgyZVhseTdmSWRQdG5VR1RMRVRwUXJWcVdwZGxh?=
 =?utf-8?B?bUhMdzM5bngzTDZZQVhOYUNwWFdiMHoySE11emZ6TkEzaHY2L2ptOVFRV2Zu?=
 =?utf-8?B?ZU1ta1F6OE9LRi9EZnZZQVFqcFM3bGVzRWZOU1pRbDhFb0Urd3VlNWdYSU4z?=
 =?utf-8?B?U01hbWRWVlpPcHdVRzloaWkvR0pXY0lmUDhmQitqS2YyVDBxUFMwTmc4QTFB?=
 =?utf-8?B?RnhTYmRlcGZnaUtRNzg5NDJGNHdZVlNXVkQrQ1pSVTdVcUNwWDkyd1RQa0Nr?=
 =?utf-8?B?N2R5Tzc5QjUybTFibEp0VkJtSzEzaTFwalVQNWVVMk1WL2VLeVdCRjZBbjVT?=
 =?utf-8?B?Q01QMGRUc3duZ0NBWURRUzlUdnF5N0VPUWx0WE1CODBzdzVDZzZPUUd5cUpH?=
 =?utf-8?B?MkVBblFsbGQvQTFjUDZqL3RQaW9sRTlRSUtUMlhoS0lxdlo4bjJubWJ6MkdF?=
 =?utf-8?B?NFdla0JWLzJPaVBsNHYvYmJOMkVaWjJpemVNTkRNSlRrUUd1aE1tN3hReGN3?=
 =?utf-8?B?RkVDMEJlYmkramwzcm9rSkFFL1pLQzU1MzlGcnlYK3lVZ2Jpa0l4d1kyNytK?=
 =?utf-8?B?bUNVRDBjS1gvakVOOXdzaVE4T1hoQmVESE13dHk3T2tOOFJLa0lsYnFOL2JR?=
 =?utf-8?B?eTJJUURGYnVKcWVDdkRBK2FOK2JUYlZxTnErRGRERmlPdGpQZnJTZTdtUllD?=
 =?utf-8?B?NXA5MTdnVTBOQ0JBc2RqVGJtSGZDTmpid2dBY0RjQk9QcWxrOGFySllPaWY1?=
 =?utf-8?B?L203VXpnWFd4WVNqTnlOOFJoZzlWb2t2M05oS1JGeVh1cUM4eUpTTnlFV0hJ?=
 =?utf-8?B?YVVqamlhMEVrMmFZQW1HM0x3bXFvMis3NDVFeVJvK2JudGlUdDdaa2hyK1RX?=
 =?utf-8?B?bGx5UjNqZDVwMnBnL3hPZ3hNOXMyTFRWS0VwNWFyNjVHVmRMMlVxOXNMTFpH?=
 =?utf-8?B?WmUwNXRwS0daUlEzM29MRDFSUjA1c2ZydzJCRVd2RnNSZTlFd3JYaERqVHRk?=
 =?utf-8?B?U1dNME1nc3E1YWFKRVpGcXBmeXNJK1JHd0hxNnlRaGpjNUplNE5PaXZHV3BU?=
 =?utf-8?B?M3NzQ29UWGluUHJNeUFzNEFpMVdZOVkxME1Ed29pV241aGFJY0ROd2RPcnBM?=
 =?utf-8?B?TGgyaWJWMVRNdDdBbmxWM0hlMHNQMGFvR3NaTlRYeDU4OS9WOHpidHQ0NFJG?=
 =?utf-8?B?amcyNE1MSGFuSURTaisyVE5hZUJMTVAvRHFscTkyNkMvZnc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1JwODV4NHg4M3NOZEhMdUdQL1ZVaTFRakhydmN1citVRmQ0SGNFNUtXK2R0?=
 =?utf-8?B?VDNtdlVybDJzV011c1RLUkZSd3VKTGlUekdpQXV6MitkSkhBdjdYMU15QjZr?=
 =?utf-8?B?aWlKUEhpckdmQ2t3WUZXUlBvZ3pFSVR4ei9udnJ3VWdSTzZCZTRGc3hrTndo?=
 =?utf-8?B?aGR6eFVnbnNCMEtQV2F5czUxckV0TkEzWG1wcENEc254RHhMS09VK3o0RjBK?=
 =?utf-8?B?UnBDaElLQVREQ25VU3YwZi85bGNRdEtlQnVFVEpUNTJOdGhMNkd3dUtPMk83?=
 =?utf-8?B?OUgyMFhhRGZmb1I5bjN6R29lTGczOERxcTZmV2Y3Zk1lMko2RC9NZHA3SHI1?=
 =?utf-8?B?QUJEWG13OXhXYlM5L1hsSGp0Y1d3cm5nT2VzektiK0hxL0lrQm9yZmswVzE2?=
 =?utf-8?B?TXVrRmZ3dlpjUzd3NWE3eTN6czFENURqOWw0cDRrZjRORFlJc3Njei8xVXF2?=
 =?utf-8?B?Y2JRemsyaTBsdklKQk9pTXA4RjlIeGJ5R0ZCRzU5M1NRdmg5THptMFNTc2Fy?=
 =?utf-8?B?REY2VjZ6ZTlSL3Z6eCtOR2VITVBVaTNIZzNtK1BhbGRYUnBnQXlnSFZrcGt3?=
 =?utf-8?B?T3RWOTJlVHRqWUtPcm9ybGQ4U2o0bzVNUjNmWmVQK3h5aFBYQW0xRE9NZWV3?=
 =?utf-8?B?amZhQzg5OXBkNFcvaGIxMThSQ2ZTWmdqN01oUmtGMmZCT2FYNFFxNHE2dFJF?=
 =?utf-8?B?NFl4Yzd5ZDRCU2ZZcXkzSlhCaDQ1elFPdmo0elNkYzZMZ3dyYXRBei9EcDYr?=
 =?utf-8?B?UkpwbTVrcjFBSzZHOXg2SjZYQkJQc2ljeWxUZklqVXE4dmc1cm94RjIxTDhq?=
 =?utf-8?B?OEZEQXdTemZOVTRPVUlzUjJaSTBIOGlZL0VLbmh3bmdPWHNtSm1hVzlnMTZI?=
 =?utf-8?B?ODJUYllLOWtyRHFEaWpyWjVNbmIrdURLKzlDUWUzc1JQTDU0STF0cVJjVnJw?=
 =?utf-8?B?VVlzeFJkSTZEendWTkxPQXJtSDFzREw0OHZoVHF4U1JkVE5vVVN1OGVBbnl4?=
 =?utf-8?B?cVNoU3VJeHMwdTdmVFFhdXVuWHdWOFErQ2VqanJZaFVaeTYzZDVTNFZ1NDlH?=
 =?utf-8?B?cmtlMHVzMjY2RmF1anE5a2srb3pPaXIrbk4zQVlaT1NBY3NKSm5BL2phbWlQ?=
 =?utf-8?B?Mkk3RldMd2ZtRnFMRmNEVnU1YWVEQkdKWDlkREg4amYrRHRvWU9QUmpQS01Y?=
 =?utf-8?B?SGF3UXprZkl4OEV5cFdmWWtjOXhzYjRMejFMUEV4RHVEblRld0VhM3htMzNX?=
 =?utf-8?B?UFgwbkJ1ZkY1N0N6ME5SR24zcDZMVW9NYmowekNxK0N3b3hwMXJLaW5DOW13?=
 =?utf-8?B?YW5kd3Z6MWZuZFJTYlRzV1gzRWtrUEh2cFEvWjc3ZFFrMExEblBiV0xlWUp0?=
 =?utf-8?B?VGpSZlpCNnNWSG1RSklpRGJ1U1RoaHJYK1ZKUDRyV2lTM2ZQQXlNNGo2a1g0?=
 =?utf-8?B?czRSZTV5T2o3d1lIMm1FRG15dWp5RlJvSW9EL2hSSG04TlNYcHpROVJsclA1?=
 =?utf-8?B?N0drOXJWcE9DNEt3V3J2eE1kQU14ckJzZzFBemxjSERIYzRZYitmNktPaEo4?=
 =?utf-8?B?Ti9iNlUxdzRJQU42UTJxaU83V1FhRll3cWNTclNoVGpKUFFyMm5Jb3ZrOC8y?=
 =?utf-8?B?QVRsNVVVT0ZSanNESDVrOERpNWp0WmRqbFRqRUNaZmtKTGc3VnErZ2J3eWVt?=
 =?utf-8?B?YlVkQXFObytFVTdxeStKalh6U1BheDRoZmJVbHltKzVNY3FzbkNROHFkdkIw?=
 =?utf-8?B?SE1MbzVoUnQ5WU1SQWhoR21ISmVOTU5jRDNUa2VHdVdIU1M5R1dySkRKVHZH?=
 =?utf-8?B?eVh5akZTdjNTUTdhMyt1Y1J4d0NjeSs2Ui9qMlY1QXNsNnBod3o1R3VTOC9I?=
 =?utf-8?B?Ty90cm03WDRUU3Y3NVVma0E0VUpHR0FwVzRraEJsUEpvbk40YkxsZ1djWjFF?=
 =?utf-8?B?UkVYajJOMkZwVGZoNklYajVuRlhwZk15ZitsSFdQYXBjYXlVUjNDYUJmbXl6?=
 =?utf-8?B?azlXMXRnTDNCZTYydE1UeEFvelBvZVcwV1l1UDM3cyszTE5wV2dGV21keUY5?=
 =?utf-8?B?VVROcG1wLytlRzVod0NPY0dzbjVLb2ZtRG1rVmIyZi8yNmVieEtEUmNJVDIy?=
 =?utf-8?Q?CKhM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 286da13a-fc44-43b1-b795-08dce20b1a24
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 11:20:49.0818 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /4KFrwFKnCbPPznT0seDazDgdLtXEq2Z4FCGcfPCT0WZg109iGg2uzrMw3Q0E0XssVOl0A8rrp8vrhg1+51GIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7158
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvNV0gbW1jOiBmc2xfZXNkaGNfaW14OiBFbmFibGUgQUhC
L0lQRyBjbGsNCj4gDQo+IEhpIFBlbmcsDQo+IA0KPiBPbiBNb24sIFNlcCAzMCwgMjAyNCBhdCAy
OjQ34oCvQU0gUGVuZyBGYW4gKE9TUykNCj4gPHBlbmcuZmFuQG9zcy5ueHAuY29tPiB3cm90ZToN
Cj4gPg0KPiA+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+DQo+ID4gT25s
eSBlbmFibGUgUEVSIGNsayBpcyBub3QgZW5vdWdoLCBhbHNvIG5lZWQgdG8gZW5hYmxlIEFIQi9J
UEcgY2xrLg0KPiANCj4gQ3VycmVudGx5LCB0aGUgZHJpdmVyIGlzIHdvcmtpbmcgYW5kIG5vdyBl
eHRyYSBjbG9ja3MgbmVlZCB0byBiZSB0dXJuZWQNCj4gb24uDQo+IA0KPiBQbGVhc2UgcHJvdmlk
ZSBtb3JlIGRldGFpbHMgaGVyZSBhcyB0byB3aHkgdGhpcyBpcyBhIHByb2JsZW0gbm93IGFuZCBp
dA0KPiB3YXNuJ3QgYmVmb3JlLg0KDQpXaXRoIHBhcnRpdGlvbiByZXNldCBzdXBwb3J0ZWQsIHdo
ZW4gU1BMIHJlcnVuIGFmdGVyIHBhcnRpdGlvbiByZXNldCwNCnRoZSBtbWMgY2xrIG1heSBhbHJl
YWR5IGJlIGRpc2FibGVkIGluIGxpbnV4IG1tYyBydW50aW1lIHN1c3BlbmQuDQpTbyBuZWVkIHRv
IGVuYWJsZSBhbGwgdGhlIGNsa3MgZm9yIG1tYyBpbiBTUEwvVS1ib290Lg0KDQo+IA0KPiA+ICAj
aWYgQ09ORklHX0lTX0VOQUJMRUQoQ0xLKQ0KPiA+ICAgICAgICAgLyogQXNzaWduZWQgY2xvY2sg
YWxyZWFkeSBzZXQgY2xvY2sgKi8NCj4gPiArICAgICAgIHJldCA9IGNsa19nZXRfYnlfbmFtZShk
ZXYsICJpcGciLCAmcHJpdi0+aXBnX2Nsayk7DQo+ID4gKyAgICAgICBpZiAoIXJldCkgew0KPiA+
ICsgICAgICAgICAgICAgICByZXQgPSBjbGtfZW5hYmxlKCZwcml2LT5pcGdfY2xrKTsNCj4gPiAr
ICAgICAgICAgICAgICAgaWYgKHJldCkgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHBy
aW50ZigiRmFpbGVkIHRvIGVuYWJsZSBpcGdfY2xrXG4iKTsNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ICsgICAgICAgICAgICAgICB9DQo+ID4gKyAgICAgICB9
DQo+ID4gKw0KPiA+ICsgICAgICAgcmV0ID0gY2xrX2dldF9ieV9uYW1lKGRldiwgImFoYiIsICZw
cml2LT5haGJfY2xrKTsNCj4gPiArICAgICAgIGlmICghcmV0KSB7DQo+ID4gKyAgICAgICAgICAg
ICAgIHJldCA9IGNsa19lbmFibGUoJnByaXYtPmFoYl9jbGspOw0KPiA+ICsgICAgICAgICAgICAg
ICBpZiAocmV0KSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcHJpbnRmKCJGYWlsZWQg
dG8gZW5hYmxlIGFoYl9jbGtcbiIpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVy
biByZXQ7DQo+IA0KPiBJbiB0aGUgY2FzZSBvZiBmYWlsdXJlLCB0aGUgcHJldmlvdXNseSBlbmFi
bGVkIGNsb2NrIG11c3QgYmUgZGlzYWJsZWQuDQo+IA0KPiBXb3VsZCBpdCBiZSBiZXR0ZXIgdG8g
dXNlIGNsa19lbmFibGVfYnVsaygpIGhlcmUgaW5zdGVhZD8NCg0KSSB3aWxsIGdpdmUgYSBsb29r
IGF0IHRoaXMuDQoNClRoYW5rcywNClBlbmcuDQo=
