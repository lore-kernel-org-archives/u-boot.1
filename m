Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14816C28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 04:34:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FC13801BE;
	Wed, 12 Mar 2025 05:34:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="SlkyHmgD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83C3880756; Wed, 12 Mar 2025 05:34:05 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::62c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EA2780107
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 05:34:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oLnp0Ec4hzITNFQKc/qvMtxMOAId1I4onB3shM0VQF85z2Hm3iu1xnJIH/NvlxV3cIG2GZWTnyAlRWXuPzOgPq4JlP35IKTfhfwcNP2FZuaNhyH06hlaLocy93wUk1wJJQdwo3AjxnX1dQDJDR9AYKl2096Kp1BLDRooqQB1zIcMbWbUUKkObKL7t3TPga4djxRHzhayQJ2/mM2LNY/tilN/xAHiKlorV9Czy6hXHm0HABYJm45vJIoy8AI/HQYP9k9TMVi5RoxeY40aMraR4/qPqh+OYSYvXyNfEpxFU/AbTFJsScBEdypwD9UpCAo6hotMcJP3N62C8xc/6F8uag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8woErKCMz0FIdY+DKs94/9hG+bVeM7ipyhZy0DL+pU=;
 b=Nh522SkFQyNdwI418EEQu2ZsN16MpU1ueAIMLhTkeJaHk/0/3QNzD14w4yzp38NByQb5Lm2X7G7ee6ggZt22j4KavxyRosL47920NbLSusMk7NYEsUp/0r/zq5BqgDf2ly9oRSdQYgpsLCg6i8WnAhbZ4qagj/0L0yICJiLC8O44QLcGUlOb44uGkBijW1/kPoG/PbQi8PfoKC63sTdAlUVPKZbY/B0ogLwXwernNJn2v3r0cCivVifYsaonH+RLjdnII4bavwRAki46loqHluQBtZTiCMmLEB13cAWt4PAPiiKCnoI6efu5RIbmBKdNgxfxghB16QLElZRQdf+xoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8woErKCMz0FIdY+DKs94/9hG+bVeM7ipyhZy0DL+pU=;
 b=SlkyHmgDvd60je1cDjE40NRAO4tFTlDSYIAxawWsIOGbx6vidk4RRq2aUY6sLPERQ7Bu0wYP9A/vWnM9QBAQ6pX7FiVmOZPOPRwGV/aXpKRKp9W7HgAuhSAFSoE5S31PPl7+JAYD1JyWmI6359EdRjC6VV5kbBzyKYzYlVOfRLcD+ZQDdRuvjB4GHjoq1VMnj42hM32cLi3jd9/Tq1emVUTZgWtHS6FpVV4nMbF9ouQ0oul30C1+QxOU+ZYs7mll3TY/fPyy70bJbu3+Cziv1kvhWJjXepm/G+teEYHq68tInkYnp9NmxRyghjudjSqvxChJ/ICekDOop5G+aJ0v7A==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8285.eurprd04.prod.outlook.com (2603:10a6:102:1ca::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 04:33:59 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 04:33:59 +0000
From: Peng Fan <peng.fan@nxp.com>
To: =?utf-8?B?VmluY2VudCBTdGVobMOp?= <vincent.stehle@arm.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: dl-uboot-imx <uboot-imx@nxp.com>, Stefano Babic <sbabic@denx.de>, Fabio
 Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>
Subject: RE: [PATCH] imx8m: soc: cope with existing optee node
Thread-Topic: [PATCH] imx8m: soc: cope with existing optee node
Thread-Index: AQHbkbkPO3fdAErKrEyuSCQxmDrzsLNu7F0Q
Date: Wed, 12 Mar 2025 04:33:59 +0000
Message-ID: <PAXPR04MB8459EE950FB12D95BD79809B88D02@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250310123621.389594-1-vincent.stehle@arm.com>
In-Reply-To: <20250310123621.389594-1-vincent.stehle@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PAXPR04MB8285:EE_
x-ms-office365-filtering-correlation-id: 1db145ff-f3dd-4719-a86e-08dd611f1bc1
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bk94WFJVZVE2aCtLdVFyZ3ZwMEtUY3VpYjd3Q0NBbGxpZmxVZHM1UWlwN3pW?=
 =?utf-8?B?Q3c4ZmdyQktrb2RFWjQ5dW5TNGJEdGRKcUZGUVczeFVLVW81dGdQSHh5SU1K?=
 =?utf-8?B?a0x5dHYySlZVTEE3dkJvVkYycWptM0RvU2lQY1BSQXUzOHExbDBqY0s5UjdQ?=
 =?utf-8?B?MzR2aHZYTHVXTnYzdWs2N00rZDBEa0NaNUM1T2ZqcFJxVXpQYUcyY3NVWnN1?=
 =?utf-8?B?RFoyVnB4bGpWSFp3WGlHWHRVY1EycXQybVpTUS8rVTZibUFnT3A1MHQvQWg2?=
 =?utf-8?B?ZVFpemVuQW1KOWlVaDhWL2VMTW9WQ0tXSTZOMXlOZUdQY2t0RTRBTDNFZ2s1?=
 =?utf-8?B?NTdrM01rM2xQMk1wN1UrZjhWb256TFcxdmFyVTZEMFM0TWk1cDdMUWJabUMy?=
 =?utf-8?B?ZW9lT2ttSGxJSTlvdGYrYmRrZXQxSnFqekUwb2lLRmxuQVJUNWlYS3lxMk9M?=
 =?utf-8?B?RHRpZTZMYlNPbzRORHp6aHhJZUozMnRDSGhDMEVMcXhQQnlxd244L3lPRXM2?=
 =?utf-8?B?c2JIUUJLTzFtdk0vdk0ydDk2a1ZrdmM2QnpUSWk4dzROZDlZUkxMTHNNVnBr?=
 =?utf-8?B?OUI3ZkZienBpZmhGOThneVptcWd2MUNjSzd0LzF5bW0rWXRzSlJpSFczbXgy?=
 =?utf-8?B?OVpVRkphNlhpdVczK1JmVjVjQzhsM0d5MGc2YkNCRmNhOHF3VC9hSGVINHo0?=
 =?utf-8?B?NXRSYURtcUNYWGhiejdHVWg5WFhWRE5BTzMwM2NOTENOaUU4YWtJMlFUVVpY?=
 =?utf-8?B?MDlFYmovbHVLTzY1U3hwZXhsN1MwWVFoZjIvVXJ4amlCZ3pRSnNGMVphbHA1?=
 =?utf-8?B?Ri9lTTczK2lpcU5OeS9CUjBxci9UdXJVcVZqc1BudVhKN1Q0bzlaY2pnSkJG?=
 =?utf-8?B?THp4Y0hBZTR6S1Azd0hLUzk4T0hpZlBEUTFIemR4Vi92RHF0TnhVNzkxNjZG?=
 =?utf-8?B?N2VvNXUzQVJpZnNTOGtyWGd0U25wWUkzRWsvcGtLcUVyZy9yZXlHUElBaGxE?=
 =?utf-8?B?bmpCTENLVStURU83bTF3SjhXK0p2UWhOTjJhSlQzb255TEptdUFnb242L3Mx?=
 =?utf-8?B?NjVDeU0wR1VsVTVxaG03YWtadDJXc2Q5V2tDSWhudXRpOUZUK0NTaHY1dVRu?=
 =?utf-8?B?WGxMbnpSdnlHbTFoa2V5TENQWEZ6VXN4U3hQamFKbkNmOXRiNExSeUFBVHVi?=
 =?utf-8?B?a1lIbHdUZUM4TzRVNEsxQ3NGcTc5cHhhUlNBMmdDc3liSFBWU0h3Y3c1L3Vj?=
 =?utf-8?B?ZzRBTGJJc1c3cVExYzRCaGZoUWZBcEs3MHNpZjJOSzBtczIxNGxZZGFuS1Bk?=
 =?utf-8?B?OE5hbXdsVEdsamo2NXFjNHFuSS8yY3FqemVlWkR2ZVVYZVF3OHBISE4zK3Fz?=
 =?utf-8?B?dzR4S3k1VVVmNWt5anZGS3lJVW9HbnJzOHRNQ0wwdGdacTE1cW5zRXNLZmdx?=
 =?utf-8?B?NFgzNjFSd1FFNEo2MTgrTGNJVzl5dkdBNklHV2pqek1LSnpGWFNPdGY3bURU?=
 =?utf-8?B?UitUeTRPMm1VODNYU09WeC8vYmpweWgyUExJK0I1Y0YzQkM4cFJ4KzMvQU9n?=
 =?utf-8?B?NmF4Tm5HSlhmSlRwNzFjL2JZbjZ3VHFGUGJEbmFac3ZndnF1aVhaMmtCT28w?=
 =?utf-8?B?Q0ZoclowbTVNdDIvZ05RdkdDeldFNFZ0YWhKdTErb3NpNlJkc1V2ZG5OVDFs?=
 =?utf-8?B?VE5VNHRwenJYSnZodVZlWnNtL2lrTzVQVUV2WStZTEJpYU4rQXJRV0dRRzcw?=
 =?utf-8?B?bFZmdDFseWVzKytXSitaVGhsMXlXRWR5MkpTU1h3LzdhN041OWorVmwvK00r?=
 =?utf-8?B?VE9DZG5ySndBNkZGbm1aRVJmSmo1MllJdmNMbnpnUThBMnlOQ3Ryb3BIeGRV?=
 =?utf-8?B?YVlxZnY3aTk1aFBEbzFFcVFjL1FEdG5aMjNOcW92bnVMVzBYYVVFZ0RHSnZC?=
 =?utf-8?Q?4imTb6CyOeS1kEnJagK3Ys2WpVcHPcU7?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFZCVlZPV2YzcjhoeTloV0VvYk5oOTVlaXRscTNtSUw0eEE0TkpTOUZmN1Vl?=
 =?utf-8?B?UUZjbTlhckEwdTllZU9ndUQ5ZmlleTg3d0llc29EUm0rSUNqSDMrdjVDdFJ3?=
 =?utf-8?B?NFNHc1BoOVRneG44U2Zhb0dHcFZyNEl2ejNmajFXWlRTVmtqbmxNazJlUkNB?=
 =?utf-8?B?TGU0OE8vbld3Ymo1M21kWHN0Sm56ZUtlcE5kY3NiRWlMWEU2ZG5GSGYra0Vt?=
 =?utf-8?B?eWlMMFQwcldBMnlubko5ZEdhVnlzMFcyWCtMb2d4Y0xVVWdQRFEyOUZaZ0pQ?=
 =?utf-8?B?bGVZVFFackw2YVJtL2wwbWlta2VzZVJ2cnMvUFZvMys5RjhlMnRsTmFSNzV2?=
 =?utf-8?B?QWFrRUhiYnRvcXduNmtPK1ZiRDErVWhtODc3SC8rVjd2K3ViUkdacE52emFw?=
 =?utf-8?B?b1JKR0dtOUFXTEVLODgvTjRFaFd5UkVhRXdOZzlybHRUdTR2Z3hSbm5oRTZV?=
 =?utf-8?B?cXhIWkI4czRac1Qxam8yWjdTY1poNDV2MUwwcjIxUUVIZEZMQTNVOXlvNVlZ?=
 =?utf-8?B?eWJNZGh2VWZDK2V2Sk8zV1hEeGxCd3E5WlQ3ODIwQ3dlc21qaUs1VVhkcGdP?=
 =?utf-8?B?WFJKSzlIeitGWGRyckF2dWcyQmxLbnBmZW1hZ0d4NU5FQnc3TmdVZTFnU2c0?=
 =?utf-8?B?S1lzenNDTG1JTUFOL1pWR2xZYnhIRnlzanhmWjR1Z1ZHK0xteGMrNmZONnp6?=
 =?utf-8?B?QnlMUE9yMjM3anhPZEo4ckYwVHppSEJQNUVaTWRFdUdEMzg3ZGk1Tm1wZWNu?=
 =?utf-8?B?R3VYZTl6eEhBdkpSaS9HZGlHRGNKVlVZczZiMWJ1UHE0dE5IUDZ6U1N6Yi9n?=
 =?utf-8?B?aXpyOUNBWWJoVEJvMk9yc282d3pGWlE5T2VOOGNOYUZ0VDRqVnptdmtKMGlK?=
 =?utf-8?B?MEpKUTRGbWt4eWgvcWszU2RpUUlNQmNNNGdaaS9tMzllYUlQcTRBanB3YUx3?=
 =?utf-8?B?eUo1NFFRWSszd2N3UW91T3U0MWpkMWVhcHphcjdHK1BteW1jV1d5bjFZOVZt?=
 =?utf-8?B?YzU5UXUyRXREMHorM0JQa0RZMEdoNnJtTThNdVVGNkdoaEVDSkhIRnVsTEVt?=
 =?utf-8?B?Z2pEMStNdHp2Y2g0QkxvaVhIb0RrV3hicmF4eUVTTXZCamFDa01ENDFBV1Qx?=
 =?utf-8?B?TTBtY3RobkRmbUxreWdOYzhkVVlDcm8xUTQ5MEVhSHc2MjQzOUhUMWkvZmdp?=
 =?utf-8?B?bUZrRWJjV3RNTysyRk9JbERiYXlvM3VWbmNoZnA0cmJ5dTNlRThjK3ZpRDUx?=
 =?utf-8?B?R1FHd1hkdXZsUWVheTlWdkFjTm5aT1Zud3NPZkYrQVRHcTZLQURWZzRrYjAx?=
 =?utf-8?B?VUtxakx4ajB2cWIzeWZqVWFUcnR5a1dmMmFXK3ZOZUQzUjZEbloyTmR6Y0Nj?=
 =?utf-8?B?dVcyZjRwMWo3YW5kRVR6bEZEekY5djJTSnJWSlNwakZzU283THJVOEsyV1F1?=
 =?utf-8?B?ZDNySk9LRGZRbEs4bHhNWFdQV2pvYmdCYVhsazhtWjlrRTd0Z1V2VXkxaTJB?=
 =?utf-8?B?RFlPK1k5SUo1eUNDZDFZanU4TThCdzgwcTRVU21tZFRRRFExY0xhNDFxajJh?=
 =?utf-8?B?aHZlZTVCZXdsaHlXbVkzb2E1endnU21PZ1Z6S2tmTktQV2lGYWlqQXpLRkJj?=
 =?utf-8?B?WkI4VFpUcFptN1dRNU53QkVTcE1kZVhmUE5OZEdJS3M4VHpRcGw4czg4cWhP?=
 =?utf-8?B?MGFkajh0bFZPRGZIQXlVNytTSldNRUlUbGFxbDdWUDFrNVRLcGF4d1dGby9V?=
 =?utf-8?B?VjVUT0VWajJVMDI0eGNwaTZHdTMrV24yV2F1VCtBeVFZRVgzYms4L2U4ZEMy?=
 =?utf-8?B?NThqalhvNEsrcGRMc285OWhDMElDN3dxSVdHS1ZITlpIQUFtU2RhaFZmOHh3?=
 =?utf-8?B?VlE1TmJOMlVETzVJeFo0alI4RXplekFNNjZyMHU4SHB5d0FOMEtzb0dJRjVU?=
 =?utf-8?B?SU4xVFJxZVVHTndvZXNJZnh3ZjRxVVVBOHVWLy91SVpSNWpMWjFoekppT0g0?=
 =?utf-8?B?K3U0MmtMZy9VZUFKYXBOZFBoNVUrWnJTbXV6cGlrd3d6T1MrV3F3WlMxUVNk?=
 =?utf-8?B?RVJrSjIvZkNXL0x2SGltdHZWY0xuQUZXUzlQQjVHSXBFb2VXMTBvUDFCck9H?=
 =?utf-8?Q?QMzM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db145ff-f3dd-4719-a86e-08dd611f1bc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 04:33:59.4006 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BJHMaJTYXzQJgwQ9cqEIwmW4j7KALQbguwqyjxAqfsNl0S4wFs2eoUWRbzqDYuUWN0FHXZ8xoMIgmDIhQq2R1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8285
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

PiBTdWJqZWN0OiBbUEFUQ0hdIGlteDhtOiBzb2M6IGNvcGUgd2l0aCBleGlzdGluZyBvcHRlZSBu
b2RlDQo+IA0KPiBPbiBpLk1YOE0gU29DcywgdGhlIC9maXJtd2FyZS9vcHRlZSBEZXZpY2V0cmVl
IG5vZGUgaXMgY3JlYXRlZCBqdXN0DQo+IGJlZm9yZSBib290aW5nIHRoZSBPUyB3aGVuIE9QLVRF
RSBpcyBmb3VuZCBydW5uaW5nLiBJZiB0aGUgbm9kZQ0KPiBhbHJlYWR5IGV4aXN0cywgdGhpcyBy
ZXN1bHRzIGluIGFuIGVycm9yLCB3aGljaCBwcmV2ZW50cyB0aGUgT1MgdG8gYm9vdDoNCj4gDQo+
ICAgQ291bGQgbm90IGNyZWF0ZSBvcHRlZSBub2RlLg0KPiAgIEVSUk9SOiBzeXN0ZW0tc3BlY2lm
aWMgZmR0IGZpeHVwIGZhaWxlZDogRkRUX0VSUl9FWElTVFMNCj4gICAgLSBtdXN0IFJFU0VUIHRo
ZSBib2FyZCB0byByZWNvdmVyLg0KPiANCj4gICBmYWlsZWQgdG8gcHJvY2VzcyBkZXZpY2UgdHJl
ZQ0KPiANCj4gT24gdGhlIGkuTVg4TSBzeXN0ZW1zIHdoZXJlIENPTkZJR19PRl9TWVNURU1fU0VU
VVAgaXMgZGVmaW5lZCwNCj4gdGhlDQo+IGZ0X2FkZF9vcHRlZV9ub2RlKCkgZnVuY3Rpb24gaXMg
Y2FsbGVkIGJlZm9yZSBib290aW5nIHRoZSBPUy4gSXQgd2lsbA0KPiBjcmVhdGUgdGhlIE9QLVRF
RSBEZXZpY2V0cmVlIG5vZGUgYW5kIHBvcHVsYXRlIGl0IHdpdGggcmVzZXJ2ZWQNCj4gbWVtb3J5
IGluZm9ybWF0aW9ucyBnYXRoZXJlZCBhdCBydW50aW1lLg0KPiANCj4gT24gb24gbW9zdCBpLk1Y
OE0gc3lzdGVtcyB0aGUgRGV2aWNldHJlZSBpcyBidWlsdCB3aXRoIGFuIG9wdGVlIG5vZGUNCj4g
aWYgQ09ORklHX09QVEVFIGlzIGRlZmluZWQuIFRoaXMgbm9kZSBpcyBpbmRlZWQgbmVjZXNzYXJ5
IGZvcg0KPiBjb21tYW5kcyBhbmQgZHJpdmVycyBjb21tdW5pY2F0aW5nIHdpdGggT1AtVEVFLCBl
dmVuIGJlZm9yZQ0KPiBhdHRlbXB0aW5nIE9TIGJvb3QuDQo+IA0KPiBUaGUgYWZvcmVtZW50aW9u
ZWQgaXNzdWUgY2FuIGhhcHBlbiBvbiB0aGUgQ29tcHVsYWIgSU9ULUdBVEUtDQo+IGlNWDgsIHdo
aWNoIGlzIHRoZSBvbmx5IGluLXRyZWUgaS5NWDhNIHN5c3RlbSB3aGVyZSBib3RoDQo+IENPTkZJ
R19PUFRFRSBhbmQgQ09ORklHX09GX1NZU1RFTV9TRVRVUCBhcmUgZGVmaW5lZCAoc2VlIHRoZQ0K
PiBpbXg4bW0tY2wtaW90LWdhdGUqIGRlZmNvbmZpZ3MpLg0KPiANCj4gRGVhbCB3aXRoIGFuIGV4
aXN0aW5nIG9wdGVlIG5vZGUgZ3JhY2VmdWxseSBhdCBydW50aW1lIHRvIGZpeCB0aGlzIGlzc3Vl
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVmluY2VudCBTdGVobMOpIDx2aW5jZW50LnN0ZWhsZUBh
cm0uY29tPg0KPiBDYzogU3RlZmFubyBCYWJpYyA8c2JhYmljQGRlbnguZGU+DQo+IENjOiBGYWJp
byBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+DQo+IENjOiBUb20gUmluaSA8dHJpbmlAa29u
c3Vsa28uY29tPg0KPiBDYzogVGltIEhhcnZleSA8dGhhcnZleUBnYXRld29ya3MuY29tPg0KDQpS
ZXZpZXdlZC1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo=
