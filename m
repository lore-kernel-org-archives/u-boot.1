Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 409F8C35FFF
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 12:25:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCC1F88DB3;
	Tue, 17 Sep 2024 14:25:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="f9EmjiXj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D7F288969; Tue, 17 Sep 2024 14:25:34 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::610])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42D0C88E2E
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 14:25:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HnboQb191IheZ7Y5ryqNA+XtLlrfPYMh5Ye6ua2TyVMEAa1J4hJe/06jgY6K4tnB48TXppSl5yssDGnTfYr56EhwAS3gYmfDVK5+ktg4fg2zsova1ZTsfZ7U5nAcN9hUz7Fk3vb4eQHm48qPggucdN0MPh63nMygr8DYK528w6Dv+jkwsUZKYGFEOAAAi6+3SqINPoHiYazboyyF7HC0EyBnq5kzOER/Q4PICN+BDh3JFHdx1b+3wbTzUyx9SuvXgVl1pmuWNS5v5v6PFQDCfJr7IW+tvc600/20dbkBeXh5MciCcMWPu8sL8VFNrKtI4ayV90eBm3qrIlUA6nEHvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8h654nU35k+hM+2Hs3IwtJd4PIXFP28vx92Lib3p0W8=;
 b=OEbbD9WbxRw+UiRWlFF363viN8RgP2xPPkTtiefGt+HVbr8m5RwpMuM8IamO/qbuJafGLruajzaVgFFEyNRk/eI6Ip9Byddc3BLTnJZzVvVLfG3/0axr8OX5+TOJwckvzhML+NlBqWyMLdvkkU18jQyH6I9TP2u0CBTOd1NYu8HH40LPOGGYD3Wde0p9oiCw/AQR1rp+RLV2I2fPNTdvi3czBdof8/m/BrZNOzKjjJCutSt9lzvBC6zGNrRz+Iub1ax2visboBi5dL3hQanGzGUPJuuu+5tKeEv5UaJVDlRzv/xKTu2JFJ2KQs3+PWriir/U9uSBWk2RELL3rLt7Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8h654nU35k+hM+2Hs3IwtJd4PIXFP28vx92Lib3p0W8=;
 b=f9EmjiXjLkIu9OjD4y+nr0pRmS3aLGu3HglOtQ/0Rh59UUCOXPe5X1nVibyN7nDkqMuscPXKnxwQa4YjqxXHCEzUjtAiLV/RQBmE99r1v6+6HI5Hs+493n7pOpxjZBcVfnMPs/Xul0iOgZ+17TnIdNnx6RRmOiva/o1rED1KidqJZ9mq/8khVpsJ70B+ebs/QlbKCyvyR5ucoNYeJPBb2pake1QSsbhM8wmNNhCIXIoXHAG3tNrz341UcSfLJmwHAR0OttAQi0IO7sAwmHlmysmTuy2FIyN9SmjL8TuOPQ0ceFguBq3KQ6fIt8KfuV1KxyJtLXpyJu6A/D1furFxNg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB8PR04MB7036.eurprd04.prod.outlook.com (2603:10a6:10:12f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Tue, 17 Sep
 2024 12:25:30 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 12:25:30 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Stefano Babic <sbabic@denx.de>, dl-uboot-imx <uboot-imx@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH 06/21] imx9: soc: Change second Ethernet MAC fuse layout
Thread-Topic: [PATCH 06/21] imx9: soc: Change second Ethernet MAC fuse layout
Thread-Index: AQHbCKmcr5x/mC0rA0m80ijHHGhjrbJb51EAgAAAfyA=
Date: Tue, 17 Sep 2024 12:25:30 +0000
Message-ID: <PAXPR04MB8459EDBDF3F565473821D8E388612@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240917-imx9-update-v1-0-4fe8effc937e@nxp.com>
 <20240917-imx9-update-v1-6-4fe8effc937e@nxp.com>
 <CAOMZO5AVyeTauRe7KKMxwa-1zueiam5u1D=3DsQ34=xryfx85A@mail.gmail.com>
In-Reply-To: <CAOMZO5AVyeTauRe7KKMxwa-1zueiam5u1D=3DsQ34=xryfx85A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DB8PR04MB7036:EE_
x-ms-office365-filtering-correlation-id: acb77e05-dfcf-416b-a7f2-08dcd713d1d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aE5wTngrNjZHUklUcGNFVzlNVlJUdzVUS1RZNGE2Sk1lWnFnU2pBUlUycU1N?=
 =?utf-8?B?MEJ6eXZWYVJDTGpIZms1bEtMek1KZ1R0Tm5VeitwV1ZkMWVSTnZmUWxub3FP?=
 =?utf-8?B?MVNvaHJYSkpTeUJpTENWVnBSSzgxVml5MSsrZzJGRURiOHZXZzdwTnk3KzdU?=
 =?utf-8?B?TDA5ZmdvakhIUmcrVlZlYWVEd3M0Ti9HUVBLRTZVaXllc1QxWml1dDB1NWFj?=
 =?utf-8?B?ZEFkeUpRRkl6T0dBZlJxV1REOUpDb0ExZXkrdkt3QnNsWTdaekVWc0VkZTBG?=
 =?utf-8?B?aWs4cWZxWStVQzlPSTJDTDNEKzZBU1JLeFB3YXdiZUo5VVIxMDd4TjBudERy?=
 =?utf-8?B?WmpyeEJQVG5WSllEWjVDWjJnZnhDN0YzSVNBWTZLUitxVUx6Mm9aVjc2T3ht?=
 =?utf-8?B?SnhrU2VhUEY1czhSZ1U2aFdabE93aEhVNmJTTnozR0gwUUdoMlkyeWg5TU5Q?=
 =?utf-8?B?QS9lSCtqaTBLbFF2TW5PTjJpSE9Bb2o5QmlaR3hjdFJ2aENhWVhKYnhJalJm?=
 =?utf-8?B?c3BjWU52bHJ3RWFjN0lmaWcrN1hnTVdveGVqUFRKMkN3RVpTSmdvMUhILzFp?=
 =?utf-8?B?ZnJ1ejBCK2JxV01HbERLazQvVUVlS3BVdXp5aG9kd25pL0h5T2ZPWkFmQVFz?=
 =?utf-8?B?VU1MSGJjRStSb3YvRENJMlNEUkkzWlBabG5GbzlrbjRZMGdSQUhlNkhnSWtD?=
 =?utf-8?B?R0FERXo0cWdWZ0RLMFUzSFJqUmVwaTZtaVdSYTU4WGNlRjMrNk01MVFSNy9j?=
 =?utf-8?B?WE4yQ2lXeDcrRXVBVkduZjJVdlIrdnIraVZLd1VWRUorcE5LNGU0TU15Sm9a?=
 =?utf-8?B?M2hDOFhmQW4vSEtkM25nRTVEWGthT05PVWNscnA1WUV6QWdVWnJyTHpIcHBN?=
 =?utf-8?B?QkhpeTJxWlpoUU9paDZPSXZLWUhmUDBobzdYdUxWU3JQaVZRRmMrVnluTjR4?=
 =?utf-8?B?U3l2VmdhQ2k1bmN6RnNEa3F0a3V2TVhVV0w0cjBQSklsbjBqQnZKeWl1c0E1?=
 =?utf-8?B?bkdpQnlHQ2xvYXFjZEpjMFQ2MitPTG5OS1JtSm5hak9Ra1VVVlhFMGY0blcy?=
 =?utf-8?B?LzhBdXA2Y0hPa3IrdFFlcHUvUFA4ZGhScTR2UHRTNXB2LzlGMmE4RmFQRDVv?=
 =?utf-8?B?a2xPeHRRQU5zc05vRE1MaktTVUt1L1VtcEFlNjdSMTZ2UVlCMmlpc3BRUFVh?=
 =?utf-8?B?K1FZY2llS1VnQURHcURiWEo5S1g3bXhmdEVkOGgvbVk1TFpOVThRVTkxMHlD?=
 =?utf-8?B?MC9LNjhYVlJNazVCUGtRQ0xKYzNDOTcxOVJUbWEveHFqYzVuT1NMZlBSNzg5?=
 =?utf-8?B?QjA0RWhvZXRaa3RLUHFYV1Y2ZG1keEkrVUZXeE5FWUJ3SjhIZ0JRMUxDOEhO?=
 =?utf-8?B?UFM3SGxqY05wV1ZCMFlOakplTEhBY0NFYVpiUE43RHB2cUlETDB3eGNhWCtE?=
 =?utf-8?B?UjBqeUUzdHpxeklncTlEMnJWR0VpbnBUc0lzODFNMG5GdkZPMGJ2aWE4dVJp?=
 =?utf-8?B?WWhhdFlleFc3M0dUcXZTYmo3TWUvUFJoMTVKeFdWU2czVGFkWXFRbTV4cUda?=
 =?utf-8?B?SEZsQWV1ekZZVGhGeXJreUxHSkUvYmtDaU5NdTgySTE0Q2JzMmQvRHM3Rzlt?=
 =?utf-8?B?TERxdkQrYzlFT2dyWWpkQVBIbWV4aE9xd2UwVittVmlzd3dzSkFMbEdSd1Ez?=
 =?utf-8?B?QnQ3UGtQVHpWb25qcTFycTg4Zk5BREw2eFVURUJsNGw3VXdIQ1h1U2VWMGM4?=
 =?utf-8?B?YVkwUDhqWHF4SnZEcUdMMU5Yc2kwT3F5enJsUjhSVzQ3dGpNb1o3cGhCT1B0?=
 =?utf-8?B?U2JDOXdEWTZZbFk4V3I0Sk82TG9zYzJSL0pudFBvcWY3UU9oSE8ybFFsUWo1?=
 =?utf-8?B?UUkvWThvVHJZM1RURTBYQXEwQ3Yza2xvYzR2eUlLWiszS1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFREbDVFTGFXOHFYTlJPd2JTcnBKeWpJRGpJWkJHMlFvb3hLcE53T0R4eWRR?=
 =?utf-8?B?Q3M4aHZFdTY4aFlPZnlBaStYcXJDcmlDVVFlQ2U1KzRkNjYrZy9QeVFEaDMy?=
 =?utf-8?B?Y3dRRWdhWWdtK1lkQXZibnN4WHdvT0tTdDVEaVdVZkFVSGhFZWhtZmplR0N4?=
 =?utf-8?B?dTZ2aUJvcEpRZlNFeVdWWU5yNlMvRXhjOGg1KzFVSlZsaGVLK0tpRlFCNDJM?=
 =?utf-8?B?TENYdUVoN3FwdTBGU01qMjZMRURtWUx0UnBJTEJMbm5HVHlveEs1TDVHc1Ur?=
 =?utf-8?B?SWtFaUNlODNFNUZ6RVhKZjRhaFVZQmdwaEpTczBWcG1mL1hUTUhNeDJtU0pm?=
 =?utf-8?B?eXJNcmFOTTk0UFVETndYR05XOW5ZVkRWbGxnMkJPRlJoc2I4MFgra01DMGJF?=
 =?utf-8?B?ZXZoNk5xYVkxM094T3MyeGhlYXhHSDZWNTRuT3dxMDgraWZKNW1DRWhxdnV5?=
 =?utf-8?B?N0p6UDg1VUtTdFVqRWVOWTE2eTgvWWoveUkyNVhvdksvSlNnT2ZTNEk3cVdU?=
 =?utf-8?B?dUZhWjdIUk11cUxYWHFVaEVPV0gxaVpPeXBlam5CZUwyMUIrNlNONTBGMTEw?=
 =?utf-8?B?M1NveWdJY2tIaHpwTEk5STZkMmxSL3k1OE5YWkp3TlpWSGltSGxvR0s1MGtN?=
 =?utf-8?B?MHNtUTZ1UkVEKytvdWhxL3JjNjFad2JkK3V0L1VIeEc4VS9FWTBGZXFaQ3hk?=
 =?utf-8?B?WWtoUkRaSHh1VUJXU2V0VWRHSVd4STZCVWJ6VTJoQTIrLzMrWDZQSkVLUHlL?=
 =?utf-8?B?WG0wQmh3VlYwL01CVVFtSzFacTFTTGRmZmJQWlQ1T3BSTVpubW85dGhxaWF2?=
 =?utf-8?B?WjQ0R21ubXBVWmRLelFtTDNJenAxOFJ5bGloejNVS3hEWmhLbmFzVkNwdVNC?=
 =?utf-8?B?WkxpeHl5MjZiWjlQZzZaQ1VJK29PdTNwOTZrSCt1a1R1WFAweEo0U2N0OFRT?=
 =?utf-8?B?a1FUREZ1L09mK01laFVYTEJSQlZjcVlkL0ZxOStFT3dyMDBvMW55MWo1ZHRi?=
 =?utf-8?B?VDdRb2lwVFhHRlZCZk90WVVNNXoyeXpCaGpYQmFxaE03ZkpxMUVSRndqaEpi?=
 =?utf-8?B?ck0wWUpQYnVxdkZteE96bkRCMDZqYldhditVc3RiRXRMTmhnNStJbllyNmsr?=
 =?utf-8?B?T0ViTGl4SmZKSkh0cU9SUzc1WmlEL2EyazNTdmRGVkM4amhaOEtaRzFNd09u?=
 =?utf-8?B?NGNhRkxUSTdBSFkzM1VyOSs5WFBva0FMVnRTMmhpVEJaTjZ0cWZFbTRZMEpu?=
 =?utf-8?B?dHc1N2RQMDN4d1E5cDNTY3FvQi8rZjhyQzhkQjVlaEdMZ2hNK2R0OEk2NXc3?=
 =?utf-8?B?M3c0czdPYW8vYUJtUjFrODdQMjAzNEZTOGVMWkFGKzlxOXBVZGFKbk1jSzAw?=
 =?utf-8?B?MUVUOGpKY0NvcEdZeVB0TGV0SDBTR292ZVFkYThKV0NEN2E4SnlpbXduZU9m?=
 =?utf-8?B?TmRMU3NIakE4bEpqdG5uUkpzTzNlS0MzNkszSTFHaHJ0U0wxbHJYbkw2ZEN1?=
 =?utf-8?B?UU0zSUlSUmdOa09kT2N3dU9qNFR6YlZmdEFJbHZ0KzdzaGFMZmRRMlU1TXRV?=
 =?utf-8?B?OXlnZWt1QUNKNnVNQ0VydkhvTWF0OUhWU05SczVSUjQwQ0treVJlbGRoY1ZT?=
 =?utf-8?B?SlNRWU1pblAvU2wwMi9DMXJSQ1Q2VUdSMUhsem5nUzdHZnFQODJ3UERGZVFi?=
 =?utf-8?B?NkIrT3lyMkMzM3lhWFY1dGNucVhJb0xMQ2VoTURucVlSSzdJZFplMG5uWXJa?=
 =?utf-8?B?eFdIbmF0cmxZS2RZeno0VDYvNVBTakYzMENyWmE4eTJuazM3L3U1NWtSMDRV?=
 =?utf-8?B?V0FNNVpDeWxXUUxNSU94QWFnZjdtbDd0ZUpma095MktjcW03SWNEWlJtMmV6?=
 =?utf-8?B?OXp1bTBjUFlCNEJMeGk1ZVdNcThTTXpONWpyTC9JSjVEa2V2QW90Q01ja3Fj?=
 =?utf-8?B?Zldsd3EzM3ZMSDVMSTEvM3d0QSsxSURGMWlvRXJ5ZFVUUW5TN3NCTktoMUJM?=
 =?utf-8?B?TkhFOWJhenBGdS9oTnNwWmx5REg2N3lodklPUE8rcGpWQTIyandweVN3K2Nt?=
 =?utf-8?B?N1dza3krZE5sUFdHV1pBSnkwb0RiMjlMMTlxa2praWtTWEtmK2RGRXFOdDhr?=
 =?utf-8?Q?lzkU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acb77e05-dfcf-416b-a7f2-08dcd713d1d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2024 12:25:30.4151 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vbC2Gru9Nakvoyy5iUkKvAGbAmOyp8T0SQTzdsNO3HdUFcbSa0/gZtkF2Qn9JVydWWOfZQwUYupm4NnvlOCc1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7036
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIDA2LzIxXSBpbXg5OiBzb2M6IENoYW5nZSBzZWNvbmQgRXRo
ZXJuZXQgTUFDDQo+IGZ1c2UgbGF5b3V0DQo+IA0KPiBPbiBNb24sIFNlcCAxNiwgMjAyNCBhdCAx
MTozMOKAr1BNIFBlbmcgRmFuIChPU1MpDQo+IDxwZW5nLmZhbkBvc3MubnhwLmNvbT4gd3JvdGU6
DQo+IA0KPiA+ICt2b2lkIGJ1aWxkX2luZm8odm9pZCkNCj4gPiArew0KPiA+ICsgICAgICAgdTMy
IGZ3X3ZlcnNpb24sIHNoYTEsIHJlcywgc3RhdHVzOw0KPiA+ICsgICAgICAgaW50IHJldDsNCj4g
PiArDQo+ID4gKyAgICAgICBwcmludGYoIlxuQnVpbGRJbmZvOlxuIik7DQo+ID4gKw0KPiA+ICsg
ICAgICAgcmV0ID0gZWxlX2dldF9md19zdGF0dXMoJnN0YXR1cywgJnJlcyk7DQo+ID4gKyAgICAg
ICBpZiAocmV0KSB7DQo+ID4gKyAgICAgICAgICAgICAgIHByaW50ZigiICAtIEVMRSBmaXJtd2Fy
ZSBzdGF0dXMgZmFpbGVkICVkLCAweCV4XG4iLCByZXQsIHJlcyk7DQo+ID4gKyAgICAgICB9IGVs
c2UgaWYgKChzdGF0dXMgJiAweGZmKSA9PSAxKSB7DQo+ID4gKyAgICAgICAgICAgICAgIHJldCA9
IGVsZV9nZXRfZndfdmVyc2lvbigmZndfdmVyc2lvbiwgJnNoYTEsICZyZXMpOw0KPiA+ICsgICAg
ICAgICAgICAgICBpZiAocmV0KSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcHJpbnRm
KCIgIC0gRUxFIGZpcm13YXJlIHZlcnNpb24gZmFpbGVkICVkLCAweCV4XG4iLCByZXQsDQo+IHJl
cyk7DQo+ID4gKyAgICAgICAgICAgICAgIH0gZWxzZSB7DQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgcHJpbnRmKCIgIC0gRUxFIGZpcm13YXJlIHZlcnNpb24gJXUuJXUuJXUtJXgiLA0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoZndfdmVyc2lvbiAmICgweDAwZmYwMDAw
KSkgPj4gMTYsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIChmd192ZXJzaW9u
ICYgKDB4MDAwMGZmZjApKSA+PiA0LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAoZndfdmVyc2lvbiAmICgweDAwMDAwMDBmKSksIHNoYTEpOw0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICgoZndfdmVyc2lvbiAmICgweDgwMDAwMDAwKSkgPj4gMzEpID09IDEgPyBwdXRz
KCItDQo+IGRpcnR5XG4iKSA6IHB1dHMoIlxuIik7DQo+ID4gKyAgICAgICAgICAgICAgIH0NCj4g
PiArICAgICAgIH0gZWxzZSB7DQo+ID4gKyAgICAgICAgICAgICAgIHByaW50ZigiICAtIEVMRSBm
aXJtd2FyZSBub3QgaW5jbHVkZWRcbiIpOw0KPiA+ICsgICAgICAgfQ0KPiA+ICsgICAgICAgcHV0
cygiXG4iKTsNCj4gDQo+IFRoaXMgYnVpbGRfaW5mbygpIGlzIHVucmVsYXRlZCB0byBjaGFuZ2lu
ZyB0aGUgc2Vjb25kIE1BQyBhZGRyZXNzDQo+IGxheW91dC4NCj4gDQo+IEl0IHNob3VsZCBiZSBh
IHNlcGFyYXRlIHBhdGNoLg0KDQpBaC4gVGhpcyBpcyBhIG1pc3Rha2VuIHdoZW4gSSBkbyBnaXQg
cmViYXNlIHRvIHJlc29sdmUgZXJyb3JzLg0KDQpJIHdpbGwgZml4Lg0KDQpUaGFua3MsDQpQZW5n
Lg0K
