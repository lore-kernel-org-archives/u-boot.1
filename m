Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF76C3DA61
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 01:18:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1F0A889D7;
	Thu, 25 Jul 2024 03:18:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="U/rEZFYs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06F4A889BB; Thu, 25 Jul 2024 03:18:12 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::604])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1C6688800
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 03:18:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhiqiang.hou@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JwY2jIv20Mf6nbCQKzpvyAYZgPwvs4X++kxZ+vqbOSLTMhoy6zEbI1KT4Uw6bopRyl2Xpf0cCLgTtuAKpaRh/0KsygufYV3gh3bDEaoLF/JZdA8fXx+fBrMIz7vBoy8oE8T/PvpixS9WOwjpE1sromOWcHpTzuDuLufDuJFczbEXD0sMNHYQmY6p8BSksxa8Fom7jqEbzTL72kRBcJ7nACCGs2hwPj4LoFP6vmeEi73WAhoGAo25ClX3rn2ru86lshPzck7ZN2izM8QysjhaBTqcNrAySIqa4B0BTImBA+BMNrtd1xD+gIaaiAxrDhzEQOTU///7rNlrVshiOuexhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMEhfUJlUBwgUEEk72rgjEm6EcsVdauM9qE/7hWZV+s=;
 b=uc3tFoNneWzbzT/5lYgoIQZRMwYXF/+LAuHOzfATLKo5ilnth2lvZLhRLQJnrrp8zRXLbGI6YU/8Dw78fAZODFd8dbf06EHUgukDHnP6ERfyzF/vUOO9pz4IFW17pZS4gnWUpp3eeu9tKGoWmD19l8r7CcyvwajrIC8S+8EQSaAaAvJG/71ZJhXFQxXrb7FhP1bXUoo25G6g019zy4OwIifoliVlrXtOaKgmDjCsX4QpOLRuPykzh5ccRfvF2DgRQ32pHcFNHO327CO2ysovHydm/9H3f46v00CvwE97mE5oCN6K9ErYIPxDxq/NSZN/bncyInm7b2l4l7zevanfEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMEhfUJlUBwgUEEk72rgjEm6EcsVdauM9qE/7hWZV+s=;
 b=U/rEZFYsHPfJrgdoMguddB4rhEPBvNa3YHHTZJc/DIQeWktfUNweWSKNMdWdRkryYBIwoRWGXHIwpYnlvhwog+sYoKXLl8k5iL4no/MV9SSoEdnXLRPEeVvGSC6AFVizwvkTa1Zy5Tl8w8m+M4Qfp8pN/lWHZscy3AtGu6kY4wa1TGd0p5fOT0k7c9rIEhB99QSr4h0lVbZZr/6DkqIVCuyI8MTADX/EqObTpVeeqiq8I1IrFujR+E4OPLZWVWoclwWilnezyZkrRbg6c/DyPB0QJXUgArpAvCzE1++N1eYOXYiIdE8hAKEopvloucAgy5iI8sSsdz94UT6hdud5jw==
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com (2603:10a6:10:370::16)
 by DB8PR04MB6986.eurprd04.prod.outlook.com (2603:10a6:10:116::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 01:18:08 +0000
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::9903:6f05:ded5:924f]) by DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::9903:6f05:ded5:924f%4]) with mapi id 15.20.7784.017; Thu, 25 Jul 2024
 01:18:07 +0000
From: "Z.Q. Hou" <zhiqiang.hou@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "trini@konsulko.com"
 <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, "sjg@chromium.org"
 <sjg@chromium.org>
Subject: RE: [PATCHv1 3/5] cmd: cpu: add release subcommand
Thread-Topic: [PATCHv1 3/5] cmd: cpu: add release subcommand
Thread-Index: AQHa3Q6skebeC/7OrEGxYubJjn9uTrIEZTuAgACmUECAAA62gIABi+2g
Date: Thu, 25 Jul 2024 01:18:07 +0000
Message-ID: <DB9PR04MB92365077FE5E57B37FA5651C84AB2@DB9PR04MB9236.eurprd04.prod.outlook.com>
References: <20240723150400.16650-1-Zhiqiang.Hou@nxp.com>
 <20240723150400.16650-4-Zhiqiang.Hou@nxp.com>
 <CAOMZO5BUguY8vbw9gUux=jfZ312q5pAr3FA0YKq_wAQiCvfEfw@mail.gmail.com>
 <DB9PR04MB9236608870B7A84AAB4E486084AA2@DB9PR04MB9236.eurprd04.prod.outlook.com>
 <CAOMZO5CNfAQzqaVPy0WDiNZ2VLzQiAKUd-d+Jii8ZrewUyiA_A@mail.gmail.com>
In-Reply-To: <CAOMZO5CNfAQzqaVPy0WDiNZ2VLzQiAKUd-d+Jii8ZrewUyiA_A@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9236:EE_|DB8PR04MB6986:EE_
x-ms-office365-filtering-correlation-id: b6ecd8f9-1ac5-4f9a-eb37-08dcac47a449
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cWgrVjhzZEVSZTdFeHNtUGNvMHYrcVFPaGtpYURYOG92eE12aXF4RE1VdVVn?=
 =?utf-8?B?ME1JTGxpaEI0NWhzdHJQUW0zZmVNTk9maWFrNktvUkR4NU5DSGJKOUlnS004?=
 =?utf-8?B?WFYrdlJsMGltUlV2R2M0bTNBOW0wMkpGcWJqZVdNK2RkbVRxcit1NExlanRr?=
 =?utf-8?B?SHVwWTR5b2QwY2Q0akhYSmVWa3NKRUJPcmNZYWtOd0xGUUI4TXZzSGp3ZFp6?=
 =?utf-8?B?anVFUkVNU1RlcGkwZzB3eURReFJxUW9kRVFHZGE5Ry9qVUJuNnU0YzAvUFlu?=
 =?utf-8?B?WUYwOHBBN01zL0t6MGYvaUFBR1lEbW1NZ0ovNHlGSlpNaS8zakRPN1hyVEEw?=
 =?utf-8?B?ZmxFY1JHK2ZzUThmb0tRU1FSRGZEYTByaEhjOENJNjd0SzZVdmNSUXhrTUFW?=
 =?utf-8?B?VE9FZ0ZkUTJoS2tIcTJDb1B2SUJlQUxRZ1d3TTlPSnplZzMzMVRUWmF6TEs5?=
 =?utf-8?B?MjcvU0xXRlNwaFIra3dLMnhNUHdhTFpOY0RjYnRmalMvOHd2MG85UEdteDNi?=
 =?utf-8?B?a0J1RDBQS3FPYnU4TXBMVzFPWlU3OVVDSWlMUEF5ZGpEV1labTlwYUlHQUVO?=
 =?utf-8?B?dGk0c2ZkNG8wMXdTaU03M1pBbTRxUnRTT2l3bWQrb2NKTGdwY0krV0dER1I5?=
 =?utf-8?B?enEwTGtRTEhyOWNRZW9nNW5ic1BqdVFweGRBTUIxbGt1TXhqa0NuZ3lrdkdu?=
 =?utf-8?B?dUVlVUN5cjdHajNXRWFORTlSNC9IdjBZOTBMY2pCN29rc1lRMUZnRFB1WHd1?=
 =?utf-8?B?NXlaTmRxM2VMOHZUVW52VDIvTkUxVUE1VkVnRVMvQ1VSeFFsZDVlV0RHR1li?=
 =?utf-8?B?cDNDTXVKeFhKRCtid3pvZWdEbXE4Y2llcUlVTThQT3YvSm1malRLZlY5d1BO?=
 =?utf-8?B?b0ZDMC84b3QyUjMxL0pmQVJubkJBRHdFdnRabWJsNXNHaW81TlJydFNOTFJR?=
 =?utf-8?B?ck16STVyOFU2dC9uOGpNMEFrWWtSTW1kTXNiQnV2eEsyejlCd2NZNDlqRGJR?=
 =?utf-8?B?NkZZb2hKUUJkNmJpeWt1UjViSTVGNU1MUktsUjkzR3hCK3J3Ny9kNzY0bzlT?=
 =?utf-8?B?TFgrbDlJak1kaC9HQ1YxVUtXcmw3QThwNjFhQVlQQjB6VUZVUXBzK0sxS3Jq?=
 =?utf-8?B?OXN1RXFyTU5jUkxnYUluOTVrQ3dvZUVkUkk1alRpeUpnMll0WnltMHAyYkkz?=
 =?utf-8?B?ekhidFJ2OVpVVjVoTnp4Yll4cG9xRjBRN3dEQ3Z1d0dzaUE0YWoyNURRNGVs?=
 =?utf-8?B?RHF1WHJIMXE4TkE5cllpUXk5ejY0S05TbHVvYnN2RWUyRnBDcUNPWGo0dmFj?=
 =?utf-8?B?L2phMFZ5VFdEWS9OV21CTHlXNndFQUxwMGcwYy9EcnBlRmxTSERpNGpBZ0hY?=
 =?utf-8?B?c1FQR0pwdTd3aVA0d1BpQkxnTmxIOHlhU2FGaUY0REREaDVUUjhNSXN3TFcv?=
 =?utf-8?B?TjRNbm9HV3FNS2g4czZlMzAydzY4M3JHeU4xYzJTaFBiT2sxcW1tQ2g4YVVF?=
 =?utf-8?B?Mm5YU0FGZUV0SkpWcWJyK2J0WDFXaHZBL3R1Z1NSaWcwQm9RR1hQN245WFdW?=
 =?utf-8?B?NVFFaUgwRlpUZnFjZzJ0MnZXbm4ramN1cG1RY3QzZ3NISFJzQkp2QVBCNEx2?=
 =?utf-8?B?clIwcUUwVlhUaEpSOHRZWkZPUUpxTE4vbkZMVWVQSk1DSWRBUVE3RmlmWjVL?=
 =?utf-8?B?TU1NWmxLZGNpSlZEeFJUbmZSeXhFaE1RMDcvYmtIeDdaUXlBZEJ5SDcxekc4?=
 =?utf-8?B?TFRNSEhHenZMYmJoYzVXeCtSeFVySm1nZFEwUll0eFE3NkIvZXFuVERPUUxO?=
 =?utf-8?B?U0pSQVY2QVBKL253V3U2RG5iRytNelZhcmhsVG9wQmZvak1UN1EwNDJLN0NF?=
 =?utf-8?B?UHFyK3lzQyt5QWVBemc3ZTVmZVlySXdtQ0h0bnh5Njh3TEE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB9236.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmU5R2J2OExRZ2IyYkJIYkhleHRnZlkwY2o3dllvaWtyNHgzb3lpM2FGTktM?=
 =?utf-8?B?U1Q5SGsrR2JhNS9RUVNwWnNJYk55dC9lYWdRMUpXQW5TTG1PZjZXa1NzL1Ix?=
 =?utf-8?B?N05ESk12MzNvanlMeUcwNEhOV0VxS2xJNk1EYzdEL2d6ZVFZaWRyMFFsYnVl?=
 =?utf-8?B?ZVJLSTZ6dVhiS2JKNW9Ja2JpWkpFUWF3UXJnQmtEbUJmcVhXUzJpeCttbWhH?=
 =?utf-8?B?K3dlWS9FSDYrN25BaVo2T2JMVlNYcXdjdXdIejkxSW0rbkR4Q2RVQ2hRZ0Yv?=
 =?utf-8?B?cUErTEdmc2psb2ptRWR2MU5nclhEYVB1bWpWNk1qWFJldHBoZGVQdW11OXFR?=
 =?utf-8?B?eXVobVhqd1dQbGx0Q2EwOENoNXhVZmdFOWlUTGdYUHFyY1pJN05GRzN3anBY?=
 =?utf-8?B?ZlBjTTZkN1lmRlByeVJaRmgza3VMVXVNQ2czdTIveVBjcXEzNUoyUC9FRmNQ?=
 =?utf-8?B?YWFTVDRVSlRRckl0RUJvcG83Z1VINk9LcDNVK3BDL0pDZ0g0bjB1OUJlL2xT?=
 =?utf-8?B?U1RiNnIxQjJNNmpvUXpGOGpXRFFraUdXRGt1Z0s1WHBkTnZCYmVBK2JqVWlG?=
 =?utf-8?B?VnV0S0c5Z0k2YWVjVnRFZHNaMjdWckZtYmhreGhqN0tkU2toYTR3T1VaYkJJ?=
 =?utf-8?B?ZkxrNVd5QkVqNjFrRnQzVlNNOFExLzc0R3VBYi95bHlZMUhkK1BvWmJDcmxN?=
 =?utf-8?B?ZGVheFNDaVdNMGpKUGRMZzhIMlpHUzh5QXdWdzNqc3dOQnJ6V1c3UnByRSta?=
 =?utf-8?B?K1dwc2FmVXl5MWRkdWtITHFOU25lUXBMVVcvUjRpMWl6eVZ0VWtMMnlYUmZC?=
 =?utf-8?B?YnJBekRpa0p2Uk1DWE04bm80ak9FazlidWRJWnEzM1RZMU9ySlZPeEZkZzJi?=
 =?utf-8?B?UVdFZUhzcmcwM3hOWmdaeFljbEw1cjFaR3VaNk9UZnFyZ28wTGs1Mkt2ZDhk?=
 =?utf-8?B?d25MZDlXZUhodFdCWmsxcDlGU2locTVhYUphVEpCQXV6WmVFUnVycVRFcnhJ?=
 =?utf-8?B?bEkzdUdtQlcwbTEwMzJDbFdGdmdZdHQwc1ZvUndCN0hjbmR3ZFhMRDlIa0Rs?=
 =?utf-8?B?ZFB1aTlEYWx1SW5GeHQ2aGg2STlEZG1xSHdFblNMN21pcWdJL2VBbFQyMUV6?=
 =?utf-8?B?U1NGeHRWb2RtNGFEVXU0TFk5Z1hvd0I2b0ptQ210NjNwNzVOc2hlTHV2a0xr?=
 =?utf-8?B?SkN6b0ZONG1KTWlhcTZBb2NoWHRMMk92SlVzSGgzajFzVVlzbUFVMEJJSDVL?=
 =?utf-8?B?TUQ2ekxZQVI5QU5EZ0N3TnlEU2IvQ09JOWEzSFkvcmw3UEdmWlBqY3NSTnZQ?=
 =?utf-8?B?OG1HdHVZTU1mVXlNVjlwK1Jqd001VEY3S0lETWFnbVZLMm1MY3A2RGxHVnFL?=
 =?utf-8?B?WldSUlhacEhNcDJlU28rV2UrS094anl6dUR5eWZlQ2c4N0tFaS9oMEw4RE1G?=
 =?utf-8?B?eDdyT3NNVmpEejNzYmdpMElxTFo1eHhPdGc3c055MUhqZ1BndFZuZVFpZ21X?=
 =?utf-8?B?T3lQNXhyKzJ6Wkc1VUJYUDBROFM1Q2VIVzdmU1NpRzEzZkdGclV5bzhPNi9u?=
 =?utf-8?B?QllqR25mVDFiU2NvNlcvajZCTzlTNFZ5TmVyWXpnV1JVV1B4enhDeU8yK3Zw?=
 =?utf-8?B?Tkoza2lFTlk1OTB1cXd6NktkcWtlMWVYdVJ5VmViTXdHOU1xUEtRSWpOVXpN?=
 =?utf-8?B?VVJiK1FURE40YjNBRExyaEZ5MzZUVnl1NUVBMXY1YjhucW5QSXJUbXJvaXcy?=
 =?utf-8?B?SzFSOWNUQ2FmWnVRTk1VT08xMEpKVkovYTlOZ0Z6Rm9LdkpNWkZ2WTlTMDBu?=
 =?utf-8?B?eUhoZnUxSVlJZGxmNWZEL0lYNnFJZ0RQYU1uMUlUVVlmY3RvSkMwVU16SEg4?=
 =?utf-8?B?NDlrbjQzZEYwTHFWUUlPTXpzeEpaRGtNdW9LaFprY2JkQ2tvOUpEWTBnUm85?=
 =?utf-8?B?dlRFTGRMWWRMckJhMVlZNGhFZ28vS0FkNll3dXU4dGp3UWZsTVlVT2w5bDJM?=
 =?utf-8?B?N1VVU29vb0VVNDJaVVlKK0srbEVwMGhkbUZwQjZpeGdGK3lKc1JEM0gxODlH?=
 =?utf-8?B?OUV0YWxtWTh1ZUd2VElXSjRFMUwvbFo1cnYyZXQ2alhybFV5NUQ3bVRyZzR3?=
 =?utf-8?Q?8eRhvtBaNdgv9HDJtw0Ju9LmA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9236.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ecd8f9-1ac5-4f9a-eb37-08dcac47a449
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2024 01:18:07.8710 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sN0fwzQalOyu7nElwu/sI4GH6BcTxXYbZVRTc/nIMZt+RwaltFBFF2bNiUSI1htKWjRwU2GoDUjnLBj4gzxvzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6986
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
RXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEp1bHkgMjQs
IDIwMjQgOTozOCBBTQ0KPiBUbzogWi5RLiBIb3UgPHpoaXFpYW5nLmhvdUBueHAuY29tPg0KPiBD
YzogdS1ib290QGxpc3RzLmRlbnguZGU7IHRyaW5pQGtvbnN1bGtvLmNvbTsgUGVuZyBGYW4NCj4g
PHBlbmcuZmFuQG54cC5jb20+OyBzamdAY2hyb21pdW0ub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0h2MSAzLzVdIGNtZDogY3B1OiBhZGQgcmVsZWFzZSBzdWJjb21tYW5kDQo+IA0KPiBIaSBaaGlx
aWFuZywNCj4gDQo+IE9uIFR1ZSwgSnVsIDIzLCAyMDI0IGF0IDEwOjAy4oCvUE0gWi5RLiBIb3Ug
PHpoaXFpYW5nLmhvdUBueHAuY29tPiB3cm90ZToNCj4gDQo+ID4gVGhlIGkuTVg4TSBQbHVzIG5h
bWUgaXNuJ3QgYWRkZWQgdG8gdGhlIGlteDhfY3B1LmMsIHdpbGwgYWRkIHRoZSBpLk1YOE0NCj4g
c2VyaWVzIG5hbWVzLg0KPiANCj4gT2ssIHRoYW5rcy4gUGxlYXNlIGFsc28gZml4IHRoZSBDUFUg
ZnJlcXVlbmN5Lg0KDQpZZXMsIHRoZSBDUFUgZnJlcXVlbmN5IGlzIG5vdCBjb3JyZWN0LCB3aWxs
IGhhdmUgYSBsb29rLiBUaGFua3MhDQoNCi0gWmhpcWlhbmcNCg==
