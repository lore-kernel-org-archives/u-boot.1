Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE883C3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 13:50:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 892C088BA8;
	Fri, 19 Jul 2024 15:50:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="GuwWKPlU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7479388BBA; Fri, 19 Jul 2024 15:50:50 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40C3D88BA8
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 15:50:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhiqiang.hou@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nuK2e34gK6cRzvs11CqnHxTpdGwDhc8NiUw6ab2Zeve0rqfurLrUbwST6Dc3UxkuNXVidowvfgfARKDHycJ2PZcOuIW3z1+HhzRPGLH5/cxJxp4bAqJ0aOfyfuZfIlJWIO5fyWrAd3B1YGkm8uUoukohNQyu7oQkf62OWjE/ht99edlmqo3YOqXFH2xKSV8HpJzWePEt6709HxPOJmKVoLLT/TI7HBY9iEHbgbZ4yridI8me4DBUA/wlixYr7KYCBIdCmbOoCOrZuTLTpTw4giyC/YNARhq9P5BhAa+VnO267u128kD3i/F4TenmHq+P3uuxJBW/R86N/QlN6fNUjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+v9dEtvHTppHKMEVzBEmxZyCiCiX+s1jBu779b5ck0=;
 b=CAQjJH/i5Ts37Duw5Wj+OZr+v+MlShkZqy+WyC6Wi82Fh2tfAhVqheQbl8k7Fc2kY24xwt6rILm7bQwKJfbJphj4IYW27DGFCutE3N7ObRePmWA+PlICyFk+NCUsZRwiNKZCqx/HZbZH+Y+T/lqMPlLosuPTAKU7lpvoLnnhLhsri3MqolzJjMuWmZoiqHMwT2yqPZnUmMZHz6d7VuPFSaOMvGw5Nxg1d9HRA+IyOpvXTlVsVo3Umo9fwJRlTtNjz6+YXqHmyoNBwmf+4yMeNblIIz8APIYtApgq8kgXwKh45qkCfZ5D88x5HGbdJNQ0Tn4MMnHR6Gk5xKRzOuGGag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+v9dEtvHTppHKMEVzBEmxZyCiCiX+s1jBu779b5ck0=;
 b=GuwWKPlUVVvSXHn2LHq6+kgxzKCNOsgo9toQ+t+IO9cc0uysENZKk9F6txQS3OImV/gFa27WScL5DYZE479imSTlJ2EKdAXcHmsl/4xoVShpQxpD6y8NhGif8E7Xxi1gL4aOTR7diaJtcW0nc6iqJasYVF4MPM0PW+BizOj03PE=
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com (2603:10a6:10:370::16)
 by AM9PR04MB8732.eurprd04.prod.outlook.com (2603:10a6:20b:43f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Fri, 19 Jul
 2024 13:50:46 +0000
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::9903:6f05:ded5:924f]) by DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::9903:6f05:ded5:924f%4]) with mapi id 15.20.7784.017; Fri, 19 Jul 2024
 13:50:46 +0000
From: "Z.Q. Hou" <zhiqiang.hou@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "sbabic@denx.de"
 <sbabic@denx.de>, dl-uboot-imx <uboot-imx@nxp.com>, "trini@konsulko.com"
 <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Yi Zhao <yi.zhao@nxp.com>, 
 Jiafei Pan <jiafei.pan@nxp.com>
Subject: RE: [PATCHv1 1/2] mp: imx8m: add cpu command support
Thread-Topic: [PATCHv1 1/2] mp: imx8m: add cpu command support
Thread-Index: AQHa2cCer9YJzGqEdEC88/KnBi/y2LH962SAgAAhFCA=
Date: Fri, 19 Jul 2024 13:50:46 +0000
Message-ID: <DB9PR04MB923670C9D250CCA833DA659A84AD2@DB9PR04MB9236.eurprd04.prod.outlook.com>
References: <20240719100758.1917-1-Zhiqiang.Hou@nxp.com>
 <20240719100758.1917-2-Zhiqiang.Hou@nxp.com>
 <CAOMZO5BoEqV_h5RdLKZitt+GDwAMyV7T6jH3P=t_TnovYMEd2g@mail.gmail.com>
In-Reply-To: <CAOMZO5BoEqV_h5RdLKZitt+GDwAMyV7T6jH3P=t_TnovYMEd2g@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9236:EE_|AM9PR04MB8732:EE_
x-ms-office365-filtering-correlation-id: 63b54fe1-00c7-4b6f-46a4-08dca7f9ca8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SDI5Z3k4N25uc2VVMlF5UkxhT3I1MThua2lmeG5KV3Nwemo3cm5sREJIWTVS?=
 =?utf-8?B?ZU1xbGVqVndwYXJKUXErc2kyNi9GMjMrNEowekVLZ2xZUEhxQUMwc3RuTVQx?=
 =?utf-8?B?c2FQNGRGa3JzNmtWVzE5c09RRVJ3YnpNV2lnOW45cmVEQ0w4REpFdlhEZUpq?=
 =?utf-8?B?QWFRaXlLT0VOOG1hLy9veHg1cHFWRFBveG51L1YwNXIvbmZKVHkxNmhQUEY0?=
 =?utf-8?B?M3lUQ1lGOFZLcXFhT0d4Ui9zVnZiLzVmaTA3Q3ZSSmRyMnlYLzRXT3dMaTJa?=
 =?utf-8?B?OHpHUjgxeVJpQ1ZlSG5ZYmxTVWdWVExGV1FPRlUwSUQwd2c1Yzh0Skp0Y0Zs?=
 =?utf-8?B?T2Y3Ym1pV0t2SGtXMllNc3NhM21OVlZha0ZHNXZKRjV0WThTMms0SXpoQUFp?=
 =?utf-8?B?d0NBRjRwc2RLNitIdGYrb2VJT3NsSW5sUjZWOVY1UUJZYjUwYWNQSFNISlo0?=
 =?utf-8?B?VmdwM09ySXd6T0dQSHEva0ZPcVJHcCtDc3Y3dG1lNzgvYUlqUnlYRVRGZXhS?=
 =?utf-8?B?Z283QW9BL0hYL3ZBSjkvNU1nMXlrd2YxcDJmUFgycTdKQTJBVUg4dGlUV2o1?=
 =?utf-8?B?M0Q5bTc0ZTFrc1h0UkZnd2dINmo1QndKN2s1Z0tDb1h0WkkyR0JzMWJNS0xB?=
 =?utf-8?B?THljaFdtSm0wemJiSXBHeXN0ZnQrZG9Ca0RFbGViMG4va2xJcHZPUzJxbVVB?=
 =?utf-8?B?N1VrRi9icjd0aEoxenBEK0FIRlNYOXE4T0tRdnB5blkyaDRIMWJxcGphN1I5?=
 =?utf-8?B?MVJOc2tBVDNDc3lTNmdtOXJnSjFjZkJMS0xiRzc0OHk2dUlpMHVMc20zVlZT?=
 =?utf-8?B?UWJ4MUloSGhOTk9nUVNKS1VvbS8yK2k2YS9DL25XalB2ZWJ1VXd1ODVIM2pl?=
 =?utf-8?B?Z0ZiUkFucFJzL3pjRFJFQXdjVDYrbVhjd29iUnVIVWhLQkZmNS9rRTRTbUYr?=
 =?utf-8?B?cXN5RlhyUzlQU2JYRUxFRVkxK3NBUmFHQ2ZhV1lxY0dOQnVXYWlyT2lFNExQ?=
 =?utf-8?B?MUQ1UGdxYjY0aGRkamZEc0x2WmRBQi9YL2kvUk1oTnFlY1lQczVpVkFnVVgv?=
 =?utf-8?B?MEpPZWVrb2ZFeHhnUjhUcUJRRkZyVlRJeGFSQTNqR2NRdE1TSkVCT28wYzN5?=
 =?utf-8?B?ek5YSDgzaXdwQzVQYzFPaEZnWXdiWk1sd09aUms1TExGY2FWdnFmQ2dDL2F4?=
 =?utf-8?B?eHgyQ25XazJHL05nbnpzNmJUeGk1QzBSRU1HcFZSbUoxVjA0U1pLQWk5dUFh?=
 =?utf-8?B?cGFWOG9TbERUcUdTWE1vdGIzSEVrOUdvNUFpeE5ZZFo2bzNnSFd1a2xlU0sy?=
 =?utf-8?B?WE84RkpwYy9vZGQ5aEtidEIyVVpDUUF0anBGUDNLQ0x6R1FzTlU4S3hyTVRy?=
 =?utf-8?B?QlVNY1liRE9KdWZNV2k3cm4veU9wTjEreThsZ3BPV2NVQStDdUNjS2w0RXhW?=
 =?utf-8?B?RlVyQ1ErN25ienZmcGkzS2xRUTRPcVZsanpuMm1rc20yak5XcGZhdFZaUGpS?=
 =?utf-8?B?UENBUi9pcFQ4OG5YVDY5WUt2L3lTZ1hXTGFVWFY0SzVMMERBaGNQT2NKZXRL?=
 =?utf-8?B?RE9qWGh5V1RvZ3UzdGFvOHZYQnFuSFF5Mi9rUi9pd0tDSEZ0YkJORUtkWktp?=
 =?utf-8?B?cUp6YkRHdjZ3V0FuV2lDYzQ1VktTRm9lU0JlS0tndG1FdS9pMVpKdy9wWjFZ?=
 =?utf-8?B?ZlZHV1hmckw3NkYwZ0lYS1pTelQwbEhRUmlLVEpTVm96eTZraWFzMFp0NmNo?=
 =?utf-8?B?aDZRd0haMUJtempEYWhwSHdTVWNGSnlMZTZ2eDZkcWplWGJRODdBeEMyTStO?=
 =?utf-8?B?eUpLTUV4bVpoMk5rTXZEcDFUOHRDVTViV0x6YlF1aEQ3V1Qrc0pzbDhVcUdv?=
 =?utf-8?B?MnJxS0JyUDZOclpNN2oyU0R5UmRRQUtDL1l6WVNKRTBNV1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB9236.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VExmbzJlUENKb21RMm01SWhyaHF3TUtNNldnWTVFNjlVNzBRV3JMaEZlTVRO?=
 =?utf-8?B?bDZkSUVjQlVpcUwzSXJKRVhxMDBOYlVYeHJ3SjBZZ3BCSFNjWWVPa2JnOEZn?=
 =?utf-8?B?dm5MVnJqRlVSQzdjaSt1SWpwSEZFeFJoOVArZndoTVIvdkkwbXFzM2Vad0xK?=
 =?utf-8?B?QlFzTUpHc0RtZ0xCNG9MTFRHUWFSbTFvV3REeldvYUhid0R4c2lQQ1N5YU1Y?=
 =?utf-8?B?ZGtaVjU5ZHM1dDc1dGlFUVdlQ3FaTlhNeHpOa3Q5QUtuSzNaMEo0dUU0Wnli?=
 =?utf-8?B?azdlUEJFNUVUZUM5ckJKL1pXbkZzRFBoN3pyL2xMM0M1akpXSW9ITU85eVV1?=
 =?utf-8?B?dmxlMEtmSDBiVWJRaW15SnAxZlBscTJFOUpsRGhFNnQramc4SG93Z0gwY3p1?=
 =?utf-8?B?Z1djdlhSRXA5ZktNdkVmQlEwb3B1aVd1UFNxRDNZTXk2ZDJFeS9MVmNSdzlM?=
 =?utf-8?B?MThwUWd5SnV0eXVlQkc4VEw3aWhZNE9leGpRc2xkTkN1WkxiOFZaVXVkMW1w?=
 =?utf-8?B?aWdSZndJOXhhMGVEMUVHdmdTMnNTMFU0M1A4cG9zVjh6UllFa0lJUjNMKzcv?=
 =?utf-8?B?UUN2L0tqR1c5Y2xvU3kyM0tWTkdQUG9SaUdpMWtZbUhaZzZvdUZrZVk2TEhD?=
 =?utf-8?B?MHFiNnZSVEtzRFdxOS9QajJzT1U1bVd4SWtEMC8wdXBiT1dIR3c2aTJtSHhN?=
 =?utf-8?B?ZkR3dE5TSkhMelAreU9TczNZUGRKamJrZWV6Wlh0NTE3WlBTOWVOL09sRjdk?=
 =?utf-8?B?V01td2VsMENndm1RNXh3cmltQ1JTWkxrcVZiY0hBNWc4ay9LYXpzcUZxT2Zm?=
 =?utf-8?B?Sk1UclJBUXJ2MUMreWZ5US9JNk9IODVyWGVHZGtQSzltK1V4QUFWZ042Y2dY?=
 =?utf-8?B?S1JJdkhPOGhxMXdxSW1RNS9UR29uemRmVC9VZFRNS21jRTJKdkV2QWlxVG4r?=
 =?utf-8?B?VE0wRVYxSDdxcllDaW1TaWk1b1NpT0FIY3g4aE1ZRXVJc1VIWm1Kc0dpNVhF?=
 =?utf-8?B?NnhieUF4Mk5lUlJYUzkwbkJSVjhlMWRpRkp5VkFyK3JEeFFsMG9RWUZTTkwy?=
 =?utf-8?B?UkdMRVJUdVFDNkYxcXR3RWtrdzdCVzhKMGNWbWtqQzd5bFVGUFltNVRVc0ZT?=
 =?utf-8?B?bGhiZGtmb0RuYnA5Q2VpZi9FWVN4dUY0NXl6ak9ZdmllYmt4V1Bla0RFWlFp?=
 =?utf-8?B?QlZrSlQrNU9BZnAyUWNscnBWVTE5aWJoNmIycEFiWWc1dm51N3ZrVHE3aThm?=
 =?utf-8?B?VkxwYTB2a3BuaUdEL1M5c1VCUFMxWWtlWXFaVWRMNE1rT005SStoVTRxdmxZ?=
 =?utf-8?B?SThmYXArcnh6SHlzQ2ZnR0thT3MrekVHQnRaekZubzdEL3FNVCsxbGN1NG1i?=
 =?utf-8?B?d0VmcTN2SlRvRjl5LzZtaVdOK1dRMHh2eTdUbjcrREJaMlc5WVdhTUVSOGZL?=
 =?utf-8?B?Sy9EdkRWSVNkdjh6TUFmeHdDY2lhRDEwYTA0aUs0QSs0SVZnQmxEOVhoVlV5?=
 =?utf-8?B?azB2dUwzb041VzRoOWZISDFVUzVXVnhUQm5VWm9wTDdPNHlycWpXMUxFTG9C?=
 =?utf-8?B?cjRwSGU1cEhNcTlYV3Y4OE10bGl1Mm5kMElCNEVOcldpa2VxMzB0RlRReU9V?=
 =?utf-8?B?WVY3MUdQb1FMUHhjaU50cXdkcWFJc0NkanFLc1NpYzhDTitQaVNaL2VvN3FU?=
 =?utf-8?B?d0g2RUJTR01pTXo2SUZubVBwakZNbWZXRTRTWnEvZFpFSEJ5dlFueXVuZDJB?=
 =?utf-8?B?L0k1T0FtREhMRmRkSmVhNDk2UTF0S2o5NU9QT0tScm9uYUtINWxrUitKVGM0?=
 =?utf-8?B?b1BHZkhNdkNzWFNPaXVYaFd1MWdhU0NZQ3VJOEdOcGFtSnYvWUhwNGJQTCtk?=
 =?utf-8?B?WlhjOVk1N2dVOTJCNXFWbGFMTE9NOUdCNWsxK0pVM2hWenhNYXdSYVgrdCt5?=
 =?utf-8?B?TFVGYVgwRjdIN29DWlRqN2YrVGlldk5pVmxlR1dHbmlCQmNEeFZaTWRheXVn?=
 =?utf-8?B?NVp0dWdWOXh3TStGcXR3eE1CYUhyYVQ4S1ZvWEZiN3dZUkprRHcrL3dLV1Yr?=
 =?utf-8?B?UG4vTDh5Rm1hZU5saDgyT2FkZCtLMlZvaWZvVXBZZkJFVkF1T0NueHdYeEJ1?=
 =?utf-8?Q?VfPN1B6es33UqeLUAgWdQWWa9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9236.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b54fe1-00c7-4b6f-46a4-08dca7f9ca8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2024 13:50:46.5966 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uyS/fM2bRMZiyQozzpgn2Q4v4kA1YrcVvb598Hoe5kiWUKgUpaSqQyrS4ap3Q1ikvGdv2WYa0+nPWezgd96hdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8732
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

SGkgRmFiaW8sDQoNClRoYW5rcyBhIGxvdCBmb3IgeW91ciBjb21tZW50cyENCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFp
bC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgSnVseSAxOSwgMjAyNCA3OjMzIFBNDQo+IFRvOiBaLlEu
IEhvdSA8emhpcWlhbmcuaG91QG54cC5jb20+DQo+IENjOiB1LWJvb3RAbGlzdHMuZGVueC5kZTsg
c2JhYmljQGRlbnguZGU7IGRsLXVib290LWlteA0KPiA8dWJvb3QtaW14QG54cC5jb20+OyB0cmlu
aUBrb25zdWxrby5jb207IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPjsNCj4gWWkgWmhhbyA8
eWkuemhhb0BueHAuY29tPjsgSmlhZmVpIFBhbiA8amlhZmVpLnBhbkBueHAuY29tPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIdjEgMS8yXSBtcDogaW14OG06IGFkZCBjcHUgY29tbWFuZCBzdXBwb3J0
DQo+IA0KPiBPbiBGcmksIEp1bCAxOSwgMjAyNCBhdCA2OjQ34oCvQU0gWmhpcWlhbmcgSG91IDxa
aGlxaWFuZy5Ib3VAbnhwLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBIb3UgWmhpcWlhbmcg
PFpoaXFpYW5nLkhvdUBueHAuY29tPg0KPiA+DQo+ID4gSW1wbGVtZW50IHRoZSBjcHUgY29tbWFu
ZCB0byBraWNrIGNwdSBjb3JlIHRvIHJ1biBiYXJlbWF0ZWwgb3IgUlRPUw0KPiA+IGFwcGxpY2F0
aW9ucy4NCj4gDQo+IHMvYmFyZW1hdGVsL2JhcmVtZXRhbA0KDQpXaWxsIGZpeC4NCg0KPiANCj4g
UGxlYXNlIGFkZCBkb2N1bWVudGF0aW9uIGV4cGxhaW5pbmcgaG93IHRvIHJ1biB0aGlzIGNvbW1h
bmQsIGhvdyBpdCB3YXMNCj4gdGVzdGVkLCBldGMuDQoNClRoaXMgcGF0Y2ggaXMgdG8gYWRkIHRo
ZSBuZWVkZWQgZnVuY3Rpb25zIHRvIGVuYWJsZSBjbWQvbXAuYywgd2hpY2ggaXMgd2VsbCBrbm93
biwgc28gSSBkb24ndCB0aGluayBpdCdzIG5lY2Vzc2FyeSB0byBhZGQgYW4gZXhhbXBsZSB0byB0
aGUgY29tbWl0IGxvZy4NCg0KPiANCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvYXJjaC9h
cm0vbWFjaC1pbXgvaW14OG0vbXAuYw0KPiANCj4gV2hhdCBkb2VzIG1wIG1lYW4/DQoNClNob3J0
IG9mICdtdWx0aXByb2Nlc3NvcicsIHRoZSBzYW1lIG1lYW4gYXMgY21kL21wLmMuDQoNClRoYW5r
cywNClpoaXFpYW5nDQo=
