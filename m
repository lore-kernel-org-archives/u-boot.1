Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B81A7CA0FFF
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 15:06:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FB5788B55;
	Fri, 30 Aug 2024 17:06:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="RbV2Ie9p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E360E88B55; Fri, 30 Aug 2024 17:06:32 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::60a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5F6B88A5B
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 17:06:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Er6BvSWYerBCQKFWfHesVd8wFu1b9emC2xQUD9ZZgxVJ11z/AVhfVf72c2MIdi8a/y4geM9YmMBWbhdECdfc4SyY0uUU2nrAbTHq8WYWaXvGtmNOMJVAbDKCe24CR+o26UKQmKTZQHBGsxOdY/FGnGq8WwPx1zbVXw8eM/7ruuoJjP6H9WkgfMHpr/KriWcILILyRVJO371El2aZJuXoGbhEMv4RaHJ41YfERNxmdZI5HSz85oukmE5zAm53sF+SlRWwtG3kQXyO1fEigDNg3EcIQG3Qj66ATxms/Gi4HiDBl8N5rCTEaYkeQ51ZoBpkdb5gGoFBWk5z2RHMVEWaCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlnNrUEhz49nvYNlKU4hhNxwBldNy3YFOnDPl6rN0bg=;
 b=bWoGS5y9JuJmq90T5jbOpTrQ0cfuz2jznqQAY3cKxxbJGJ0b0ZUEYYb8dMFJfURpXYngf17D65s3x6NeL1E/9NPb++HR5/Ay5G5s2i8jZSG8RZ4YKIA1o7slj567GygLUu2Smv904itKYHSOaf+sPAMbbxCwZSrO32JzDnn2jwV43PdYy8Mq3ojiFEiBXk8X6bh1erXWoqK0AjhqIvfxIY2OPoD1h70PF7PvEu+2pjbmLSFcURW+7Ug47qzvYloKjLv/1+PLzvZSfP+irW3DqIhjYzg8seyDoP0Ikv7EuZhr9q1ED4fYx8WVlvBGk+sMUP1ykFCtKtkEzNipcM3Hbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlnNrUEhz49nvYNlKU4hhNxwBldNy3YFOnDPl6rN0bg=;
 b=RbV2Ie9pL9rWL1p8WFmrZFvO1Lzjqa8y0sExnujt54YjMCeJgIZRK3xldRflRiPd2lW7QNNqX13YAdKO1g1dsa98P2ChR0VZt0C8VE4C4/fS1w2eRae0QAFMzLAeXp6hCgsKEbC76+ekLvdwGTSwVUy9xhrH3cxDUpLP2xy0JR0zjZm9DYsZEwT9FqZL4Aylr670gCfMN1prMCaE5Ros2NFkAMMNnZm5p3aEQMpwqjz5wUJenRAtMPl2Lixr4/H5raBO14H+3gbakecd1UEkSzSgdpXxCZojtFcC5XAaGYjqNVRxGGnTb5lJZGJ1csDHv2KzTqjb1K5ynOckIU2B2w==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DBAPR10MB4044.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1ce::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 15:06:29 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%3]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 15:06:28 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "joao.goncalves@toradex.com" <joao.goncalves@toradex.com>,
 "sumit.garg@linaro.org" <sumit.garg@linaro.org>, "c-vankar@ti.com"
 <c-vankar@ti.com>, "francesco.dolcini@toradex.com"
 <francesco.dolcini@toradex.com>, "nm@ti.com" <nm@ti.com>, "dannenberg@ti.com"
 <dannenberg@ti.com>, "n-francis@ti.com" <n-francis@ti.com>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "trini@konsulko.com" <trini@konsulko.com>, "afd@ti.com" <afd@ti.com>,
 "seanga2@gmail.com" <seanga2@gmail.com>, "s-vadapalli@ti.com"
 <s-vadapalli@ti.com>, "michal.simek@amd.com" <michal.simek@amd.com>,
 "quentin.schulz@cherry.de" <quentin.schulz@cherry.de>, "d-gole@ti.com"
 <d-gole@ti.com>, "danishanwar@ti.com" <danishanwar@ti.com>, "devarsht@ti.com"
 <devarsht@ti.com>, "mkorpershoek@baylibre.com" <mkorpershoek@baylibre.com>,
 "w.egorov@phytec.de" <w.egorov@phytec.de>, "jonas@kwiboo.se"
 <jonas@kwiboo.se>, "kishon@ti.com" <kishon@ti.com>, "sjg@chromium.org"
 <sjg@chromium.org>, "matthias.schiffer@ew.tq-group.com"
 <matthias.schiffer@ew.tq-group.com>, "u-kumar1@ti.com" <u-kumar1@ti.com>,
 "vigneshr@ti.com" <vigneshr@ti.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v6 05/11] soc: ti: k3-navss-ringacc: Fix reconfiguration
 of qmode API
Thread-Topic: [PATCH v6 05/11] soc: ti: k3-navss-ringacc: Fix reconfiguration
 of qmode API
Thread-Index: AQHa96JYztj0wi53vU+DU/iomUgBsbI/60SAgAAB1QA=
Date: Fri, 30 Aug 2024 15:06:28 +0000
Message-ID: <d9a9dc7c95ea7c97a507643205f83de9fc357c4e.camel@siemens.com>
References: <20240826102515.2774296-1-c-vankar@ti.com>
 <20240826102515.2774296-6-c-vankar@ti.com>
 <debe9b01-9c43-46e3-9d8b-7ac812c5f2d3@ti.com>
In-Reply-To: <debe9b01-9c43-46e3-9d8b-7ac812c5f2d3@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DBAPR10MB4044:EE_
x-ms-office365-filtering-correlation-id: f4d06f49-b593-41cf-94f2-08dcc9055345
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700018|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?KzhyWUVrQXRwOUsxd3hCQW00N0wvSTBTNjlUUkFVSy83c2RJVW5qSWluS00w?=
 =?utf-8?B?UmtKV2FYN0NxVmhWSFRsMHJGVEFRODZpTktUMHlWZllsS2FjeldWamRRT1hu?=
 =?utf-8?B?L1MzeGl1STRnMVFHbkhwRVViMXlDVnhVNGh1YjY3cndqZDRBMXBHTkFHV2xH?=
 =?utf-8?B?UEt4blkxRkhkckpvWXNJTlNiQUVHUGlqMW0vb0kzczVyTzJOUGpyQjBUbDVZ?=
 =?utf-8?B?cTIyM2NZOWNiOFRqb1MvM3dyU2FDR3lFYjFDQWVFUmk0bjJLRTVTemx1cW5E?=
 =?utf-8?B?TWRKVFdUQ1dKS2xKU2VQRWhQRzF2azFrY0FDMUY0bkQxTnJDSzdoR2k2OUVM?=
 =?utf-8?B?MlZIbENuM0puZUlqcHEyT0RSM3dpSERxS0wxSFJOK1FTTUtzNEk0RHdXMXB6?=
 =?utf-8?B?MkZGSzdyRms3UkRYdEFYdUdaUkh2Z3l6WDV6Y3psNEx1akVrd1QyRnplZFFP?=
 =?utf-8?B?M1JRNytKdkVzdXRRcVpOWDVSY0tIRGx1aE1YQUxPMi9MVVFTNTRVeEpQcGtS?=
 =?utf-8?B?c2JEMXZNeWVqZXZaYUhVSkw1TXJPME9Va20yUVJXeU56UU5ic3hMRnF0UUZ0?=
 =?utf-8?B?SlI2VmM2cVJuaDl0dUYwMkxtRGNxSWNDdDl6MFlmNDFvK2NDVldjL3pvU2lx?=
 =?utf-8?B?c2wwanNHTGluV0swT1pzS0wycjQzaVNFL3VGVkxGcjJpU0k5R2w0WVovMFVW?=
 =?utf-8?B?M2o3aFFpR09nN1kyM1FiODBJS3Q2Q1pvRVpIRXkrWHBsODNCakpjcUkzMTVJ?=
 =?utf-8?B?UG03bm9DenBHcWMyWm1OLytQNk52djJpTzJ3Q3YyMWtMSExwR3JvMURDODFr?=
 =?utf-8?B?WFMvYVZzU1dBaDVYU2hjVFUwZHpwbHF5OU5HSXpySGxhSkZzZmNGYmw5dkFL?=
 =?utf-8?B?WnhvNGlZZENLVmY5Z0ZZNVYyVXpod0l3d29CdjFjSExwcnRMTE5nYVltaXNh?=
 =?utf-8?B?MEtra1QyanRPTXBGdmlySXNndlFsM09kTy9oTGtSNTFFN2NHVkczcERXNGRG?=
 =?utf-8?B?b2ZtZ0x4L1ZJQ0RneEVScWJLZGk1ckkwQzN2ZGMzWTNad1VLaTdyb3ZGa0pZ?=
 =?utf-8?B?THhXT1QwV0FaampuWUdzVnZvME53TllESDhQN3ovVVZEdkZlK3ZWejdNbzYx?=
 =?utf-8?B?STVoN1NOUVhRUEc0WFkxMXN0bCtBaXY4Q25hZ3RIcVNnay9YQWl1MUNMN0ps?=
 =?utf-8?B?TnliOXRpNDVZaVgveDZ6aTVkbjVGMm5lZ0pwQVd3Y3l0Q1M3dDR1N1NFV3Na?=
 =?utf-8?B?UUlTR3JzYTBQWjR2c0k3b0pVSVlDbjVxY05jSW5yTm9WUE9RWVFiTndpTzkw?=
 =?utf-8?B?WUg1S2lYSEY4eFZDa2E2VUczL0JNQ1gzeXN4V25ybCtjczE0cVJtYlpzTnFy?=
 =?utf-8?B?dnMzOFN6MUFSVXlwTjdBb05xQnVFdlVTZFFEQUhGS05aV1ZzRS9Wb0JhTXJj?=
 =?utf-8?B?WmpFejNjcEJVZVdwaHhiTEpZajFKV1FxektFZWhxVnJ5UnowRUNDU3YzOUY1?=
 =?utf-8?B?blJVSEdFUjBYeHhuNjV2K2MvUmp2YjlJZ1pvVlg5QjhOUHFDWHV6QytnMVRZ?=
 =?utf-8?B?bjNGUnFhaGc5WVg1aXpVVWJKbU9peGY2dDVzRTJmYU9xTjNXeG02R0MxZlFv?=
 =?utf-8?B?eElwbWlTb3hFODVTNERyRHpWMVNiZzN3U2NHWUJzSVlPdjU5VFlzRUQzb3VL?=
 =?utf-8?B?TFQ1TUhiSEN6Wk1JU1p6WTR1cSs3ZmZoN3c2UDZPSjlETWxSbzNuRGRRS29p?=
 =?utf-8?B?YjNHSWtSUHpLclNzaFhrUlNmcTJjbWRQTFRINnpHb3ZJaE5DOWlwbURmMmVQ?=
 =?utf-8?B?UHY0K0VrczlXN3liUWNFZzRoWVJFYkRCVmhCWTVtR09hVGZRMzliVDRwa2tQ?=
 =?utf-8?Q?ysRm1hTQtY78y?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2xGWUNjdzNyRkgzYmRTbnZuanBod2VYR0h6MC9GbEcwajQxVTNOWHZ4c3h4?=
 =?utf-8?B?M1psdXF6ZXVaSnVuV2Y0dElCckZLdlZDRFk2UllnUE5Lc2tqaytqeUpzdFBt?=
 =?utf-8?B?OG4xNDNieDVzcC8yMzJtbUdDb0liRm4zSW9xVlNKamVzUU9BSmJoNWlDbkVN?=
 =?utf-8?B?bkNaUXBsNlpDN3ZpWUZkSmM2VWlBdjZaV1NRbUdqdnkxd0s0MWFRbFcyZDVx?=
 =?utf-8?B?T1haRGZPM2JTT3NodjZyK2dKUjFpZFh5NXJFcDc1QXYyNUFxcFRnUm14bGF0?=
 =?utf-8?B?OU1ldS9rVHAyM0JjUTZ4MW9MZFlLYmlza2U5U3BlclhQMTliTThaalN6YldF?=
 =?utf-8?B?Z0JWd09acjVZTkMxWFZlVm5JYmtIRVBiTTk4YzE4c2l3em16R1FiMExFSUhY?=
 =?utf-8?B?RzhnL1Nra0t5SjNwL2FLeG91NUFTZEUxS0ROUXVscDFvbjBhRW54NkpRUWlX?=
 =?utf-8?B?SUY0bm9SNGZwRE1ZaWJ0eE1XS1VsQytxV0RPQ3Rpbjd5Um5CL3Q5a0J2WWgz?=
 =?utf-8?B?c2RoYnVFR3k1Z0V3eE5YYmFEQmxmak42aklJZ3BoUUFYVUJzVEpQc2xLaFJF?=
 =?utf-8?B?WWJNMFo5L0dEOERwZlhaUHQxS0tWNm5IMzh2TkttZG5RWHJpMVNxU1Q1Y0lt?=
 =?utf-8?B?eHo1akJKblE2Rkt1cTJieFMzbWpKZU5jZWVpUzZRODl6Umw4QVkxVGozZmxu?=
 =?utf-8?B?OEc1dlprZ0o2WE9GYUxzNWV6b2dsSkdNK3F6bUxmRExQeGJzQi9KYURJaVNw?=
 =?utf-8?B?alZHYk91MlFEOFRYUFlXME05MThPb0pQeDNyWjllNE9YVk1GRzZsZHBVZmty?=
 =?utf-8?B?UG5rTGRXT2wzWWY1N1ZSRDQ1QklHRXdxT1JFNUd5UE9WQTRCTzJab0hiczJV?=
 =?utf-8?B?a0lQa3hMSUdmNjBaS0dZRW1VbkFoMUhIbXlVUVc5d1libHBRMXpEMFFFQzB1?=
 =?utf-8?B?OU9pSFF5V2g0bVVyUnVhckJ2ZXlKZmxlK2c0OU5wKy9kU3VqbDN6cnNnSzFo?=
 =?utf-8?B?WjlWWldxMlRZUXFqV3JkYjNzSks4REoxaHE5N0hBdVVFVEtTUWM3L21ET2lO?=
 =?utf-8?B?aytrWng0a1BYM25wQksvamU4Q2w4YjUwNjRzaUJ0ajN5dTR1aUtVayswRjQ4?=
 =?utf-8?B?WFRoaVkxL3JRenJGb3E4dWtsbEZSdFY5VnFJdFpMek53dDlXQk9QMlZiNFBy?=
 =?utf-8?B?eEEySmVyLzBzYndQZDhjdGRnNkRjTTZqclFyazIwb0dzZEMzbmZDTDNzQ1pC?=
 =?utf-8?B?RHlBeXBLWDgya3JvaDMzVDgzS054d2F3Y001NzVoNmlYZy9hY3IrUGRtdDll?=
 =?utf-8?B?bnR3cFdXYndvbVZLdmNHQmpiemdhM3liK1dTVHhmaE0yN3ZuWk5EYUJZU0F6?=
 =?utf-8?B?cXB6WEZSSWNlQU4xUHpPeHJMWDdiVUFKQnc0a3dGaFk1UlphaFBTR0I2cEVz?=
 =?utf-8?B?NjBxKzRmRFE2eU5LNXh4a1JjWUR4REl5NFI5UVQzZlRqL1d0SithWFM0ZlVq?=
 =?utf-8?B?STZKbUQ2MzdFd0FMQXlCTWdwNUFPaTBTLzBVWG91K0pkSjdodjliRVlNdWJF?=
 =?utf-8?B?NDF3TjBybW91eUVWY2lid0FrdlEvMVdCUjlaVjVycG1UclZtWjRvT3F1SnpV?=
 =?utf-8?B?Vy9mVHdRdFp4bWU5YXZ3eEZhZnI4bU5BQ0VlczZJb2JLZjFkQ0duQUJhcm9R?=
 =?utf-8?B?L0U3WmZHVmRzcUF3TVo3Q3h4TmpzQW9EZ2x3K3UyRm1vbVYyQnB4YXZkSXpn?=
 =?utf-8?B?dnVxVUdqdWtYRGlkcFo2UE9IWnlyTmpNT2Zndjh3b0c5TmFaSC9SNFJFdEFj?=
 =?utf-8?B?d01aTlZ5enJRWlZ3NTVrdWdMYlNjZjUwTWhwbTMxQ1kvK1NUU0RJK0lsOHRS?=
 =?utf-8?B?cnlwMWN1V0J6azE2eCtFWlpmVDJJYUNQQUZIeEhLdmhlRjJEK2lpa3ZoTzZT?=
 =?utf-8?B?VVNQeUJjZWxyY1JRbGxKZHYyV2NBRUhGN0ljMUt6M0F3OHBtd28rYUV6VEYw?=
 =?utf-8?B?UTYzT2xPSFR3UmIvNFowRk9lUEx3TitUMmtRR1dMbG9HQUxoTy9LQ0paY09p?=
 =?utf-8?B?SzB3cGZkMzBVUmlOSWhkSDBVOHBkRk1paHdIYkJFWlVUSTgvMUpxckRVY1h2?=
 =?utf-8?B?U0w5dlNhaUZzT2lrRVZuUzZ3TjFBNzl4MGZxUy9wOCtRTHZIM2VsRFdqUDVl?=
 =?utf-8?Q?FUhWFC8elzu5IoaWrtXD5uQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A0B59999CC45F419FACD043B9D0EEAC@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d06f49-b593-41cf-94f2-08dcc9055345
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2024 15:06:28.8750 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E5nbDx0As2TXAiQqjedkcRRup9O9jRMzSYAli3YG0swd2hZdyfVN6Qr+fu7QBb5HdUXZs/BrWOIiJDtMAQg9IlupXGn355lKf9fZbd+hozM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4044
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

SGkhDQoNCk9uIEZyaSwgMjAyNC0wOC0zMCBhdCAyMDoyOSArMDUzMCwgVmlnbmVzaCBSYWdoYXZl
bmRyYSB3cm90ZToNCj4gT24gMjYvMDgvMjQgMTU6NTUsIENoaW50YW4gVmFua2FyIHdyb3RlOg0K
PiA+IEZ1bmN0aW9uICJrM19yaW5nYWNjX3JpbmdfcmVjb25maWdfcW1vZGVfcmF3KCkiIHNob3Vs
ZCByZXNldCBxbW9kZSB0bw0KPiA+IHJlcXVlc3RlZCB2YWx1ZSBhbmQgc2hvdWxkIG5vdCB1cGRh
dGUgb3RoZXIgZmllbGRzIGluIHJpbmcgY29uZmlndXJhdGlvbg0KPiA+IHJlZ2lzdGVyLg0KPiA+
IA0KPiA+IFNpZ25lZC1vZmYtYnk6IENoaW50YW4gVmFua2FyIDxjLXZhbmthckB0aS5jb20+DQo+
ID4gLS0tDQo+ID4gDQo+IA0KPiBUaGFua3MgZm9yIGZpeCB0aGlzIHVwOg0KPiANCj4gDQo+IFJl
dmlld2VkLWJ5OiBWaWduZXNoIFJhZ2hhdmVuZHJhIDx2aWduZXNockB0aS5jb20+DQo+IA0KDQpS
ZXZpZXdlZC1ieTogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5Ac2llbWVu
cy5jb20+DQoNCj4gPiBUaGlzIHBhdGNoIGlzIG5ld2VseSBhZGRlZCBpbiB0aGlzIHNlcmllcy4N
Cj4gPiANCj4gPiDCoCBkcml2ZXJzL3NvYy90aS9rMy1uYXZzcy1yaW5nYWNjLXUtYm9vdC5jIHwg
MiArLQ0KPiA+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy90aS9rMy1uYXZzcy1yaW5nYWNj
LXUtYm9vdC5jIGIvZHJpdmVycy9zb2MvdGkvazMtbmF2c3MtcmluZ2FjYy11LWJvb3QuYw0KPiA+
IGluZGV4IDI3OTlmMjE0Yzc3Li44MjI3ZDhiYzNlMyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L3NvYy90aS9rMy1uYXZzcy1yaW5nYWNjLXUtYm9vdC5jDQo+ID4gKysrIGIvZHJpdmVycy9zb2Mv
dGkvazMtbmF2c3MtcmluZ2FjYy11LWJvb3QuYw0KPiA+IEBAIC00Miw3ICs0Miw3IEBAIHN0YXRp
YyB2b2lkIGszX3JpbmdhY2NfcmluZ19yZWNvbmZpZ19xbW9kZV9yYXcoc3RydWN0IGszX25hdl9y
aW5nICpyaW5nLCBlbnVtIGszDQo+ID4gwqDCoAl1MzIgdmFsOw0KPiA+IMKgIA0KPiA+IMKgwqAJ
dmFsID0gcmVhZGwoJnJpbmctPmNmZy0+c2l6ZSk7DQo+ID4gLQl2YWwgJj0gS05BVl9SSU5HQUND
X0NGR19SSU5HX1NJWkVfUU1PREVfTUFTSzsNCj4gPiArCXZhbCAmPSB+S05BVl9SSU5HQUNDX0NG
R19SSU5HX1NJWkVfUU1PREVfTUFTSzsNCj4gPiDCoMKgCXZhbCB8PSBtb2RlIDw8IEtOQVZfUklO
R0FDQ19DRkdfUklOR19TSVpFX1FNT0RFX1NISUZUOw0KPiA+IMKgwqAJd3JpdGVsKHZhbCwgJnJp
bmctPmNmZy0+c2l6ZSk7DQo+ID4gwqAgfQ0KDQotLSANCkFsZXhhbmRlciBTdmVyZGxpbg0KU2ll
bWVucyBBRw0Kd3d3LnNpZW1lbnMuY29tDQo=
