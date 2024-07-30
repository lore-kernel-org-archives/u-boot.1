Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427F0C3DA61
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 02:05:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57A158890A;
	Tue, 30 Jul 2024 04:04:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="cNpyKl9S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DA7288908; Tue, 30 Jul 2024 04:04:56 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44B26888B9
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 04:04:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhiqiang.hou@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+ZX49xEjtLmyKdvrrLMGMvtb4SlcbJ4XQeKuUq6m8FvT2xtbZB98fiUTH+PbEvklR4sZpaskNvHKHsHP5/iu8Y9YrmSvpa4NSSqOcHLT0lgKcJ0MVwmENJR4NL9hO1qLryTYJAFiFDuQkjdtTeL0XGTkLdVJVuymMwu6iRAhi3Iz35GSse+JF1DxIBhLe5D5lfnkuZeZ1W+rjVkkDY13Rn7UiyaBHvtXdbvlYg5vYJLfhEJy2YNoQPm9dMeB0VsJOZWuZqu6YZFwOpOBUBV9imF98KjcUgmJgNnWI8dVwhViTCBtiJIvmy97Uca/CRiZCpO0YG07nWhpDi+dIUKRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yIpR3gyS7Q7PThqmImhXDimWp1LSGu6SHNic1BGw64=;
 b=SjQDyNYUfiFfoSqg628k8HjAl1RZr8JKlz0l6ZIg5xRUZlkuBi+ufWvrcWHk8euM6un1ajzfUmyBz8pt2OU3uK957+u8WWP47OamXl32VbeegXU/cqCQF1OurB82A/BtIK04Cl45lXTFTjxt+4E2DNF+V+JkeTuB3YHr2aXklT7tMAczPJ36C3X96FNAdmOhoqGz2Ad41JMI9cyIAZFrtcVRJPZszmKAcsa+wyVoa6XkGB+XViovH1Nuq1Gnu691B1VMh/ixKY0f6nkA46DvS4iixrcR4GlRangpI6Aqw4CbILFbgS8PytHXC9XsijQuc2HAHFESyetU10rXDA+W9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yIpR3gyS7Q7PThqmImhXDimWp1LSGu6SHNic1BGw64=;
 b=cNpyKl9SH/vfrU56CnupJ+eErBi/7MmByItt4bn9vdLk+uWK2wUn/FMTdf5uKQAclUuX3pEkKvSPoMBSaUXPLHdPIt+GnXsDj4FWwvD+5yu7bHeMuzDx1B8Cp9TvXXc9bSxSmBP4OLieQxurGJ6iJ52ZProOWirsMpgBJeD1XVnRo6/CEI3c47e+C7iZoOQqtVb5NUooSvoabVh6Q0cnb++oe0teLRSgXEQnFiNJgoYEL3ry9I3KsAzcY8vLtYXQabeqpNjEpdELNDP8s5eddBxGk0pfn7JF9EwNV0TKw//DoUcGOHxyHwyfEPThGiKL7f6Tb+pb8xexXsUaKDfGsg==
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com (2603:10a6:10:370::16)
 by PA4PR04MB7839.eurprd04.prod.outlook.com (2603:10a6:102:c9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 02:04:52 +0000
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::9903:6f05:ded5:924f]) by DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::9903:6f05:ded5:924f%4]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 02:04:52 +0000
From: "Z.Q. Hou" <zhiqiang.hou@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "trini@konsulko.com" <trini@konsulko.com>,
 "lukma@denx.de" <lukma@denx.de>, "seanga2@gmail.com" <seanga2@gmail.com>,
 Peng Fan <peng.fan@nxp.com>
Subject: RE: [PATCHv2] clk: imx8m: register ARM A53 core clock
Thread-Topic: [PATCHv2] clk: imx8m: register ARM A53 core clock
Thread-Index: AQHa30Pexqt2O5+IbECip2K9bcxtxrIJCysAgAAa8iCAAFLTgIABUJEAgAJByoCAAS5AgIAAUI4Q
Date: Tue, 30 Jul 2024 02:04:52 +0000
Message-ID: <DB9PR04MB92365AF88D627709D91D2CBB84B02@DB9PR04MB9236.eurprd04.prod.outlook.com>
References: <20240726102954.14546-1-Zhiqiang.Hou@nxp.com>
 <0a40ee6f-1fa1-469b-ac9a-f7d8b6ca9f40@denx.de>
 <DB9PR04MB9236DE687B0FB9543836F55084B42@DB9PR04MB9236.eurprd04.prod.outlook.com>
 <2abff6ea-7669-4023-b71e-bb9605ffb214@denx.de>
 <CAOMZO5C+b0-9FSdugkeje70RozqnedPNQoHfPPcuvwuJ8MfRvw@mail.gmail.com>
 <DB9PR04MB9236C42A2E595ED1D10B575A84B72@DB9PR04MB9236.eurprd04.prod.outlook.com>
 <CAOMZO5AYyjLh_HE-wGori3GCuj83MdJ92B34L9EdwwBRDNFyRQ@mail.gmail.com>
In-Reply-To: <CAOMZO5AYyjLh_HE-wGori3GCuj83MdJ92B34L9EdwwBRDNFyRQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9236:EE_|PA4PR04MB7839:EE_
x-ms-office365-filtering-correlation-id: 62c91149-147f-480b-0556-08dcb03c002d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YzI1SGlRQlJUa202M1hRcDcwNmZzaGk4OTZJcG8zaHhKQXl6MmlkMzZNUFJz?=
 =?utf-8?B?TDZ0SHNuOUNXU01ZNnBWMnRsRHNscDVraEQ4bTZZMGtydDdpTG5uR2xIVGRQ?=
 =?utf-8?B?OHk4cE13MEpSejZxajI3dStWQ2VmWnYvOEs1Q2xlQkxKMWt2UllObzMrakp0?=
 =?utf-8?B?ZkpVdW01M1J5WlhFL3dHV1lFTmF3d1ZvQ1ViRE1MSkR3RkF1YUFxUnJGZXdy?=
 =?utf-8?B?RTZES0lZWDVkc3Z4STRLQ0YzSmsvdHgzY0pZS0FpNUIyNXVGOUkvVkg5Tm02?=
 =?utf-8?B?VjhnZ0ZLYWQ4VzNCVzBFL3EzZ1VyeFo2VW9WeEYyZ0VYcmNBT25lSVpMRVl0?=
 =?utf-8?B?WU1wMzVGZnJyT2dHK0E5cVA0czdVMDNvaWpiem4xSUd1QVNnaHRSUnlSempC?=
 =?utf-8?B?ZUdiYlVhL3NEa3RXR2VkQ3lxMGNFeXNlbFJGSk5kUi9QMi9OU0NuV3BtVlcz?=
 =?utf-8?B?amFlRHAydXRlZ1B2NWg2a3hMVVF0Y0ZhK2FFTDU2eDlnRmR4QW5GNXZsMllh?=
 =?utf-8?B?czJJTmNxd2ZUV3RNQWpHbmk3ZGF4aEVtdCszQzViaG1oRjEyNG9sQ0Q4NW5G?=
 =?utf-8?B?Z0h6dTBOMXB6WitHVVJJM0Z5clpnR2taVzlSMU5tYlZOV2ViRUpyZnh1eFpy?=
 =?utf-8?B?b3FPTVIyY0FVdm5OZ2xNOEs2dzhvYWNBU1d2LzRaaVowWk9NTXBxek5iemFN?=
 =?utf-8?B?NmpBcGFLWFRWclVoeWlYb1RoT0ZXUmNBczRsK0VpTy9xM1NmYktyYUsxdkFs?=
 =?utf-8?B?SVpxOUZKWVY0aTFSak8xYWRyblNCTmg4Z0RldTNDUHdQUFlrelVURnI1ZUZj?=
 =?utf-8?B?V214clJQOW4yczJ2M1pHaE4zdmlYeGhlL1hWakthdHdISTF3clRkTnlXLzV2?=
 =?utf-8?B?aWVBNWxJdU5VeTlEeTgrTmRwM3lxMTg3bHBXbVMyMXI0MGVZRjRka3pUcGE4?=
 =?utf-8?B?dWUxbU5oNEQ1Z1A0T1l6QlQycW5IVUlZUE5SUHhPakhsUFEvZkI1QTJJRTZx?=
 =?utf-8?B?OXZwa0V0ak5SYWs1VW1tT1RMMS9TbDdrcGx3eEUzdFNuS0hDaEVYWjc4Q2NR?=
 =?utf-8?B?a0tWWWw0SCsxcm5ZR2xqY0hxU3lDR21nYisrL2dXMEllaXZOeEVOOHFXd096?=
 =?utf-8?B?aDBiSUsvTnlzTkRoTzgwNyt5bWFlbHVOcGpiT3FJaFcvaWYvRW41Z0V4OEZ4?=
 =?utf-8?B?UGkvaGdtYlVqWkdibTJZYXp5OXRSMW1ZWUduNnU0MjRhNVkySzJLdTlaQ2Er?=
 =?utf-8?B?U25oeDZQZElQWk9RRnJRUGdHb1piSENQWDE1dDgyQXNObnoxUDFyNHkvWVIx?=
 =?utf-8?B?Nnh1UmZEQjhsdmliME5NK01JQUdoSG5XTGp3N2I2YnBud1J2SE9sZlExNFE0?=
 =?utf-8?B?cHNTSVAwV3RRbWhGMVBvWThyOE1Vd3p0clYvOS9zTkI4RFo5V3BOdS9vUXBM?=
 =?utf-8?B?NllHbHF5UEFDU1lqcUhIN0tTYUE4V2pSNU8zL3dJeWdoWU9INktuWE9Ya1VI?=
 =?utf-8?B?bFlSS1JxQmwxdXlpMTBpdGNQSEl0bkloVlFvd2xQeFMrMUxKYTJpVjlid3Fr?=
 =?utf-8?B?V05iejFFQStxZm94UDVpeGUzYUtQL1BobnhWVDFkNlVqMVYrMzBFRUhkbjln?=
 =?utf-8?B?ZFhDUVBHOG5zdHdoU1ZZUVo5ZVoySzRwYmxnb1pHYmpvT3duWVYzM0pndmUr?=
 =?utf-8?B?QlF5NmEzSXBwSEFYeDlSTUY2V3I5Q09GZkZVeUYrYkg5OU9MaDR2cDNmSTNo?=
 =?utf-8?B?SlZGRHJmRkVwR25sZEY0akI3cThCOU5wVUthcjNLSmp1cnVyd0dMWmp6Z01J?=
 =?utf-8?B?UXVBSWpvUzhVR1pRenNPQjNtb2FHWjUrQVdWVDlzWWFxZ01EeEFMZlltL0hl?=
 =?utf-8?B?MEd5UE92TnoweHpaNlkxOS91OEtrQVZzRmRiR1JHeE9MakE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB9236.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TzY3a0htZVk3UHNhaitvTmw4N0hXVzdPTjNOd2NOZHNYK0FuN0ZMMGN6MlNp?=
 =?utf-8?B?aDRWKzIyWXBKV0FFeWhCL1lVQVhZcTljTHgrQnc2WUJzOFFHdG1nNmJkNHEy?=
 =?utf-8?B?ZjBNbHpaQ1IxWFpJTlJsSmo4eWZGRHRPSVVScVI3dlZEZjZnUDJYSlJpdklB?=
 =?utf-8?B?UFFXSXZFaFlkdWFpRzJYWWVySlVTaG9DUVdWVW9RelQ0MkozVTVrVGRuaHhq?=
 =?utf-8?B?UGVTZmpiOCtQTldWT3lrbzZ1VDhrY2pjRCtoUlZlN3lKN2g0ZjNta3FpSThQ?=
 =?utf-8?B?YkF3MDNEbUdqYVV6SEhhdFYzbWRFQ1hCNFMvQklnR0NVNGZnVXVvQ2VvMDly?=
 =?utf-8?B?Q29JL3RTWlY2dkJOQ2hhU0JTbmZDbHRwcWhVaW12ZGVvZld3R1JIL1dSbFAx?=
 =?utf-8?B?UWY5Y2UwNDN6ZytRbk1rK0NOOG1OaCtjeDNFblpTc1NlNk5YU2xaSUdxblBU?=
 =?utf-8?B?aUZYN3ZPM1htWnY3N1FBeGxDWXRiQjhZOXI5Z01XVGZ2M0xKSDVoWEJKVCtN?=
 =?utf-8?B?dTVKQVFicDVVU2hrWERqNHR1djFjdS9Ub0dBTVdYak8wNmRjMmVjeUhueFo0?=
 =?utf-8?B?T00rZmNQZ3kwckp6cHI0RVlQOUxZbVJFWU9oVFBPWmJZV1JKd3FpWmRkQXhz?=
 =?utf-8?B?ZkFxQ29sRS9CL0hhQy9MZDYrUU5sTTAzUHNvQ2F0eXdnMmdLQy9TRmxGYm1L?=
 =?utf-8?B?b042WWZHNHpaVFBheFpYWWxnZHQ2ZzFjdWxYWFRMcVdmRWs0MFp2UWdvUEV3?=
 =?utf-8?B?ZGdwMktqQmtMalJmT2h2UmlnNmJkQ0lUZ2dDL3VsVGtaSDFCc1hTS0x2M0FX?=
 =?utf-8?B?aEd1U2tPSHh1cEw3T2dyK1pkVWNDTTlyclVQUUtZamQ1dS9sVnlRK01WUWtF?=
 =?utf-8?B?Wng3YTJiM3F6eG9HcXFETUdqd0FJa1k2eFMydXZHaEJDMjA3T3hqWXFoVC9y?=
 =?utf-8?B?SEhidlZYdmRCSHFjTmpZd1RKbXM0dFQ2TlNLdXhtZWlySXdmNXZQZUJZb3hH?=
 =?utf-8?B?WkZIbHhBVzZHWDlETzhqY05kSUFsRzJ2UXVhS1pNZ1pQVlRpT0FEdnFVYUNS?=
 =?utf-8?B?Z0F4ZllVeUU5aUlNb242VWpyRFAwZGpVS0pFUWdaamFtSE93VFdqVnU1MWdh?=
 =?utf-8?B?bC9TMDkvTVQ0OEV2alBYM2JQQjdxWkkzQUUvSGowNTJKN3hRQVV6MjlzcGxo?=
 =?utf-8?B?ME5lVmV0YVdvQ2FndzJhNU45QkhPVGdVMUlHWitzU09wTjB5dkxxckppSU15?=
 =?utf-8?B?SkNiUnBqTnNXelE4REh6bkJITFZNanV2RlhKb3c5bTNXNGNZc2ZkTWdjZzNT?=
 =?utf-8?B?eUxBUkNmSm1kRlo2UndrcEVJNFYyYnVURG9ycnBkMmtrcCthOUZ3cDhQcEdr?=
 =?utf-8?B?YXNkcThIUEwreVBBUyszckJxVHR4VGt3dkhvNHB5dDNINUtVWnd5bUNWek82?=
 =?utf-8?B?eUg2TWZzRmpNck5vS3pKUFZWdmFlTE5wdVNLN1U0aVM1SVRNWjYrc1h6UXBo?=
 =?utf-8?B?WFcxWDk0dE44ME9lT2RzSXBNcmt5aUhrRis2TkxZR1phZjczZXVVRHZhYklj?=
 =?utf-8?B?TEsxeFl0M2dlTE1UZU9LM0thN2MvVXh3NWQ5TGJzb2Ixc3JvRmM4M2VWd2Fh?=
 =?utf-8?B?b2RsQmhNQno2ZFBGMG9peDVuTmNDYlRtbUMvYjZ5SG1mMzROc3NaUzhzM0dB?=
 =?utf-8?B?Vm9JY1VucU5PNHdMaCtOVjA2MUgwVFdsOXFHQWh1aVlPVUJ4WFNiWGJWazZN?=
 =?utf-8?B?UEhRaWlQeEhTbm5TbytXMW1mbDFzUklZeTJuajI5Tlg5Z1BWS2s2SUhvNXFy?=
 =?utf-8?B?VExFODdjNThaeTQ2c2JxbHNzY25sSTUxMEx4NGx4K3JxVkNnVmx2YjVFczBP?=
 =?utf-8?B?Q2lQSEYwZlZQKzJmRkVlQ0R6dmVsRjg2OW1ZNEFFOHJjWWhTMTJlTlZHZjJC?=
 =?utf-8?B?K0VjM1o4WmRRa1hqUzFmZDdkS2Q0c1VpUjUrZC95OGRSQ25hRUdmZitBcG01?=
 =?utf-8?B?VlVtMVY1STQvaEVXdDE0UnBmRmlqZ1VKNzc1LzFZc29oMTVhbG9PUE9GMlpG?=
 =?utf-8?B?NFhZWWp1N1R3NmsxZUZad3JMYUdpQzdkR2hwQVE0RElIUnVPQm5nMFJaYS85?=
 =?utf-8?Q?KPO6D3twtq4eJIHK8AZFzwu9P?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9236.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c91149-147f-480b-0556-08dcb03c002d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2024 02:04:52.6990 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5DWU++b+Ihieg9DJRAlodSckq5XpUM1OSDaFPbGFlV6yv9n7IMDMgevbfl9jMdrkkDosZPg72FjNTkhldmQkMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7839
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
RXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBKdWx5IDMwLCAy
MDI0IDU6MTMgQU0NCj4gVG86IFouUS4gSG91IDx6aGlxaWFuZy5ob3VAbnhwLmNvbT4NCj4gQ2M6
IE1hcmVrIFZhc3V0IDxtYXJleEBkZW54LmRlPjsgdS1ib290QGxpc3RzLmRlbnguZGU7DQo+IHRy
aW5pQGtvbnN1bGtvLmNvbTsgbHVrbWFAZGVueC5kZTsgc2VhbmdhMkBnbWFpbC5jb207IFBlbmcg
RmFuDQo+IDxwZW5nLmZhbkBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIdjJdIGNsazog
aW14OG06IHJlZ2lzdGVyIEFSTSBBNTMgY29yZSBjbG9jaw0KPiANCj4gSGkgWmhpcWlhbmcsDQo+
IA0KPiBPbiBNb24sIEp1bCAyOSwgMjAyNCBhdCAxMjoxNeKAr0FNIFouUS4gSG91IDx6aGlxaWFu
Zy5ob3VAbnhwLmNvbT4gd3JvdGU6DQo+IA0KPiA+IEl0J3MgbmVlZGVkIGJ5IHRoZSBjbWQvY3B1
LmMgdG8gcHJpbnQgdGhlIENQVSBmcmVxdWVuY3kuIHdpbGwgYWRkIGluIG5leHQNCj4gdmVyc2lv
bi4gVGhhbmtzIQ0KPiANCj4gUGxlYXNlIG1ha2UgdGhpcyBwYXRjaCBwYXJ0IG9mIHRoZSBjbWQv
Y3B1LmMgc2VyaWVzIGFuZCBleHBsYWluIHRoZSByYXRpb25hbGUNCj4gaW4gdGhlIGNvbW1pdCBs
b2cuDQoNCk9LLCB3aWxsIG1vdmUgaXQgdG8gdGhhdCBzZXJpZXMuDQoNClRoYW5rcw0KWmhpcWlh
bmcNCg==
