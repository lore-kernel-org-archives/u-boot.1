Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA2DCA0EFC
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 16:22:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5109380B9B;
	Thu, 21 Aug 2025 18:22:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="qUEpfykl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70D8F80EE5; Thu, 21 Aug 2025 18:22:05 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 275F680422
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 18:22:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CyCnh5QMDziwtkA2/YnT+9lpi4XkzpjsahylmDyYY/bfZ4sB8KueObpinSfKaz+B7jwG2m99tmHtyn4g3IYfc1a4Yphe+sYjmU6ayX0E5d2QuvDsX77LzR9RfMeIup1IwcHP3wJSA9xwUurGNzvtUEDTskYrkZhxUwAj5UNpsMmfQGdBepw7bsSQZlzZhzgGlKMb4yepzoRyPmpIYQbO8sKwcjgL6kOm0V9gUh0t6+e00btxr+L1tDjGvz5tey7HooaoNzUiNy+RIIcKjthvF/trn8U1aero0rFUjHrJWQ9Q1/+wZ6xkH/PjbIYtzfqCEXrWoSspBaHZDIvEwt3yxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2TcZWefzSSRxpQWXBZ33U+dDUhWWZumT+tQ+r/H8J0=;
 b=T2QOpFZaNUrwIfZRzusSxA6Iao1nJpKHHPE04Qnkc2mFgOeZt3VMP7ZNa1mUPo9jP+ztKvXjc6q7ph4of4nwlOoq9sV5uJ4Xk/BwNT1ypnJre6t/1EOaQ7mMjsOrzf9y33aGMrbYWfubyTgaYlDhdaO/kBv3t1oF4QjRr4iQogc69TKqQO60ZafqCtkl7kTGe5ZdRxtPpNfzSmuaOpwhCeX4PJdCqem9efhwkFQVbaxclimtOFd4Ptm9lpzUL4Zi88wnX9Q6vPkejAc2a+FOegZPm+TCC+uKTBZyuzu2/T2kY/tFbXT75kPIWnT1u3O2DTp3bvTlSfZ11/43z979ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2TcZWefzSSRxpQWXBZ33U+dDUhWWZumT+tQ+r/H8J0=;
 b=qUEpfyklJxYDnz5JnPqct6hiWOHysT9kILP5DJrOWL0P554vbJNuO4DCfwKuRwlZIAk57FuCLvLNi2avv/ugDXj3WzD1QA8e37Ma7JohGz4v7TQFbxS3RN1BDsmGJ4sWG4Y86GjdcXcH4BV4v5lvgLYESVTJgK85UoS9VcvawqJBhIjRoZppljYh7GRwKEqkNHdEoYN7eMQiOgfOALhEGFy2NQKn/4esAgMeWelwk0XgUwNK1aI5sRZt+w44DmYRp0pmYpoUEbHq0LyHmzZsINoKmfQs1RR3h0jHlb4GAkcLQ8uMnu2zmAZjFM0OncJXxSqhriB5la1GibRilP/0wg==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by VI0PR10MB8556.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:233::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 16:21:59 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%5]) with mapi id 15.20.9052.012; Thu, 21 Aug 2025
 16:21:59 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "bb@ti.com" <bb@ti.com>, "trini@konsulko.com" <trini@konsulko.com>,
 "d.schultz@phytec.de" <d.schultz@phytec.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "kishon@ti.com" <kishon@ti.com>, "c-vankar@ti.com"
 <c-vankar@ti.com>, "s-vadapalli@ti.com" <s-vadapalli@ti.com>
CC: "upstream@lists.phytec.de" <upstream@lists.phytec.de>
Subject: Re: [PATCH] arm: mach-k3: am625: Unlock MMR registers again
Thread-Topic: [PATCH] arm: mach-k3: am625: Unlock MMR registers again
Thread-Index: AQHcDf4Tk1i6NjlF406dY4By04l0srRtU3IA
Date: Thu, 21 Aug 2025 16:21:59 +0000
Message-ID: <63e0078fbf5cb045b79a441dca0f2f71fd3962e5.camel@siemens.com>
References: <20250815160240.3575140-1-d.schultz@phytec.de>
In-Reply-To: <20250815160240.3575140-1-d.schultz@phytec.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.54.3 (3.54.3-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|VI0PR10MB8556:EE_
x-ms-office365-filtering-correlation-id: 40497514-56e9-4b91-1b0f-08dde0cedafa
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dXhrQ3NYaytpZzZ3MDlsMStYeWJPTGtLRUloVmVDQllrZDRZVVhrVjdaUThh?=
 =?utf-8?B?Ly9hRHh2azF6NGxNUHh4QTRsWDVISWJYcElNcFh1ZFFPVktEdjFLcEFwTmFw?=
 =?utf-8?B?eXZQUVZlSU9Vd1BNbTZjTTdLZitNejJ3aDRzRVlXWjZLR2VrS1RmMDRVdVdI?=
 =?utf-8?B?bzduMnVpeUZ5YmhuNjRHVk9VQk96bnJqc2t4SUJnL040NWRsMzVKRCtmcGNN?=
 =?utf-8?B?UG5zK25WcFM2YzE5NVYvYXVJanFjV1F5OVdCOU8vRzZPL1lNeldnSlNCTkto?=
 =?utf-8?B?TGZDa2cvSkJDejA3M2I4SHUwNU1Ob0ZPREJQNTRyZ3oydm96ek1VUXVwMFJ3?=
 =?utf-8?B?TWlURDR1TW93NUgwK09KaUNqR2o1SEdibnc0bzA4QVJ3TFVWeGJhMkwyM0Y3?=
 =?utf-8?B?WEsra2ZxT0MzUFVTL0tjZCtRTzZDVXRZaytuVDRGQmpKcnhFTzNsajdSaVpk?=
 =?utf-8?B?bEExeTFjZHl1Nk1zdC9pVEptR0Z5cmJ0Vis4Y0k1d0l1cm95elljSkh6ODhT?=
 =?utf-8?B?VlNUTGx6VXV2d0ZkeDV0by83ajUvMlBLanpmdTRwRkdiT3RjMmtaL1BINFM5?=
 =?utf-8?B?WGxxeVowY2M3V0hJZXVYakJ4L1BhajhtL2tzU1VBZ3UyakRmYXpvN3RCYmRh?=
 =?utf-8?B?eTQ4c0N5dWp2VFRmWkF4QWF1ZEs0WUszWFZ5QXdodnhteUx6L0dwZEU4VUZz?=
 =?utf-8?B?Y0RrUlhkVjA2V01VbFhkZDQ4YTFFVVgwaklFOFJRMHV5KzI3MHc5T251Q08y?=
 =?utf-8?B?WVA1MUpTaWZkM3E4UFc0S05vbkdpL2J3SU1GY3NtOU1yb3U3VEFpTXhEOEdE?=
 =?utf-8?B?b1l4TDVLNFNzQ1BPUDBxTFBLM3ZZVGJyUkl0Ymw4dWpVSjAxREtFZGJSTGE3?=
 =?utf-8?B?ZmJUS3pLMFZpSGdNcklhUGJReElWV05zTldTcUp4N29sc1JITFd0aHRXczl3?=
 =?utf-8?B?TnRZTk1rRTNIdURva2s3UnBTV0VGbVd5cE81eFRCakh3NE05MXAxY211d0No?=
 =?utf-8?B?K0NZQUdtaFVkdy9RckZwZVJSblprck1tdmpkbjBOUC85dWlpN2V6SWM4ZCt1?=
 =?utf-8?B?cjBua3p0ZXE1aUpCbWtCbmRvaEVIMlM0c1pVOGlKVCtXUGo0SHFyVjhXL1Bi?=
 =?utf-8?B?aWFtSi9xaFRrREQxQ1RucFF6SGVRM2l2RzJFUTdsbTkxR3U2Q3BNWmpDcU1Z?=
 =?utf-8?B?Y2tmenFlRXQxMncybHBBTHZxUE1HekxFWFVyblMzSkxUSGVQTHZZNjlnaktW?=
 =?utf-8?B?V0xGRUU1anJ2K1lFTjVwRXJHUVlCcXkrbEQreG1mVjJnQjlSbjhWZXY4UDNP?=
 =?utf-8?B?eG80bFFtckpWTjU0bGVkNlFqNWEwR0tLeFJ1QllxR2g1QzFoeWZIVTRYczFy?=
 =?utf-8?B?ay95MlA4eHNKcm9mTmM1cHBIOWhPNVJtMVV3MmlrOExvWExydmwxamtJakpR?=
 =?utf-8?B?ZkJVeW9XNmZKTFcwb3FjYXA0NkQrNlJKSUpSdXpiNlJPTGNNTWt1Ry9yWDB3?=
 =?utf-8?B?cS9raS81alZaeHZKUjhaQzR0eVpGNTZTL21EVVlkaFRzSE1BaHAvczgrTkY4?=
 =?utf-8?B?VFNpMUJiUEsvUXhHRkxqT3NCMzVObUcyMitFVVUzZk1hVEFGR3c2NHZ5WVox?=
 =?utf-8?B?eDFxQmhpU05sZGtSblFjTmFYMlVaODE4MmVWcEFNQjVLMVJWQXRkN2s2UzJV?=
 =?utf-8?B?UVF4VVZWYi9YTUhhYjloWDBzV1hUVENQeGMrdnpLRzRDcDhGa3ZkdGYxMVFJ?=
 =?utf-8?B?Y2VHeXRLUlRRUDZOcFNydGR6ZEF1cy9Fa1RhRWh1TGI4bkh2MnFkL3NYdjFp?=
 =?utf-8?B?TWsvS1EvU0FwVkdvSjh1R2VJQ1hXMExOcG43MWxlYk5XdGtKL2NXdFBUZVdO?=
 =?utf-8?B?ZFhJNXFJakd1OUdWMnV6UlYzd3kwcVFFTURXMm1QcHFOeUg0bDJTSS9hTUtO?=
 =?utf-8?Q?XMdBm+OnkME=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VE1FZWk0SWpVTEhFaHZqdDZmRmlLN1ZsaHhSWDNldkVpdXp6blplaTVXWXlv?=
 =?utf-8?B?M3ZqQzYrL1dmY2Rja0VBTVV4cXM2SXpYa3hoNmVCbkxlTWVQeU5yOHhlUjBP?=
 =?utf-8?B?TkdYN1dCbVBaQmpIZEJwQlZmZ09ONWRQaGoraFdhUXZmS2FQdkxjQjBmWFVV?=
 =?utf-8?B?ZWl2aGhDbHkxc2hudnQ1V1NaWDJxRUlsamg4VjNNTGJwQ09jWklpUmIwaG1M?=
 =?utf-8?B?ZnBqeTdLUGI0TTljbmJiWlkwb3FFOUd3TlNYclhqQWNiT2JmdlQrRGprMFRh?=
 =?utf-8?B?R0RxQjE1QXNDTTMxNVEyaWhnZW41QytEd28zZFkwYThVSDFIOHFYMXFmWWZp?=
 =?utf-8?B?V0RMMWp0dmdaQVFYWWw4Z2FiS1ZZNjIxVVlza3NMNWFvbGxySStUTEJucGFz?=
 =?utf-8?B?YStVUHIxYUxGS1kxaDVOQ2lYSVJNUWRUaEVIK0hzcGhPRDd3ZW8ydWtOWXFE?=
 =?utf-8?B?N3IrOUE0S2ozM0xobVlXd0hSRklVbUVYempaL3dTRVVMN3R0MExucEdUaFlo?=
 =?utf-8?B?ZUd5WnRNWnZ4ZWhJb3FRRGNBQ3JpRnFMNnlZZmYyeXhoVndiKzBRR0RVbnBp?=
 =?utf-8?B?amFHdHovYjZxRVFLbmxiWHRjMjh4cC9uS0l1dmE1dGk5WE1hWHQwYnlMV2NZ?=
 =?utf-8?B?Qk4xaEJGaTB6by9oQUp6d3c0aTRwVVpUcDRuYTV4QlZsK09rTzI3TGhhNjdB?=
 =?utf-8?B?azJaemd3ZnYzT0FQbXRRem5mU0puSDBXaCtoQTJYWHdkSGd5d1BIVXd6Zzg0?=
 =?utf-8?B?SmxuUkxyeFRBWmlzSERBWTNrUXI5aThSUG1aREc4dk1ndVRsWHduMkIvS1F0?=
 =?utf-8?B?dE04Z0pqSEVGOFkzQnFlMGlpWTNNWWxYRzZKbUJDSjV3V0cyTUIvMTdsYTlo?=
 =?utf-8?B?U1pOc0tkcWp0b01XOS92c0M2aVZnYVhkaTE3Z2dCSVZVYURPNkZZc25hU2Zt?=
 =?utf-8?B?dTNVZFhSVXk4SXhQUHFrL0lLd2V6eGxXR2NBVlFrUGVJS2RqNG5YS1lHRFFt?=
 =?utf-8?B?T2VYYURuVCtrQlBmRkk2RElvcWR0N1R1RHFOWUNwZElUb1Rhc0RPS2lRckV1?=
 =?utf-8?B?aU50Ky9abU5YeWhHSkxIcU1aZHNPbnJTK2NnTzZxRndqakdmMWo1MHFpbjVz?=
 =?utf-8?B?OHZxS0VaaVNiV1lYcFFzL3VETkU1REgySENaR1ZVSHpIN2pVSTQxZm5oNjAr?=
 =?utf-8?B?c3RXWmpnRkV4RnVWcHlseEJIYm9IcDlWd2N1ejNVSjkrM2tQNDdlU3NuMGVB?=
 =?utf-8?B?ZW83eVVrRFg1aFk5SlJVYUI4ZnJFVjErZEFLdkdWbXNrMjBHZ3ZwTHg3dStU?=
 =?utf-8?B?OEJZZmZ6SE0zYkNaSGowVS9ibHkycGNHaUhmaUVGZ0c5R05OQkFtSmZhaUV6?=
 =?utf-8?B?eFJsdFh2bUhzQ3pqZFZIWW81eWNvRStYV0J0M1BISUlseENjSzhCeDF5STd6?=
 =?utf-8?B?Nk5jbHE2VEdEQVJkVXowUm1CSkw4R2d0QjNFY05LR3NBTVN3b0JOOWIrampU?=
 =?utf-8?B?K2piRWY4cFcyNzRzRVl6R2U2V2ZzdEtDRlJVQ0R4Y3VadHhqN0xLUllCZENo?=
 =?utf-8?B?eUt6V3QvSlVBSjRHVjZ6WnA5dGZWSGZ1NGVNRUNyRUhULzd1aXgwNlZ2b2dO?=
 =?utf-8?B?MCtFb2VLZlRwUS9GZ3ZmMUJTaHM0NUI3K1ZjUGFkaFBHNW1VcHFyVGd4dGh4?=
 =?utf-8?B?bVN4c3VvK00zdExjMDdSd3ZNb29Dd1M4Sm4xWkdmN0NmWVBLVjhIazNqb2V4?=
 =?utf-8?B?YndycW9zZjM2a0ZhUUZPM2lCTnEyUGdOMGJvdTZiV1JxMW13MTlwVmJzNktO?=
 =?utf-8?B?eE5nSFBHN2hja1JveXRXN2NCdHVuREVNSDBoaWlGVEE1ZXVwdzdBNkdPVHVF?=
 =?utf-8?B?cDZLMkJIZlQvQjBoaUlNUS9pVXRsSnJkQW9XQXRzbWJnODdWbGQvZmp4elp0?=
 =?utf-8?B?eGR0Z2Y2M1U4NGtnalNUWlJTR2tJMXRUZGJFTGtGbW9sam4yVFdUeVowT1Nj?=
 =?utf-8?B?a3lFT1dEQU1tMHlxNWh5ZWloL3lYM0ZicVNVRlF4cWg5U1haamU5NEwzS3R4?=
 =?utf-8?B?WGk0OXpCQ0hHRHA4d1dQTXAzcDAybGJkNDZVKzIvcEZwZDhXWDdNSEtGUFQ2?=
 =?utf-8?B?VkJybVJ4UGs2bHFDblVLK240M3FRQzFWL3RzbXRxSXFYYkZla2pPWG9Sdmpz?=
 =?utf-8?Q?xzraA0gbvo01sTyJr/jhALU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <743CB877C2BC1644AA53356E12658A95@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 40497514-56e9-4b91-1b0f-08dde0cedafa
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 16:21:59.7984 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wXkJVOf43+kCMavfMSqq8K0NoAl8xdTkRSWkjz85OyZNPzcFI/r/8j4k57LMrE+HdAbL/1O7KrpZPNShO+apX7mm5Ct+YH6c6c8RVpLP1cM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8556
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

RGVhciBEYW5pZWwsIFRJIHRlYW0sDQoNCk9uIEZyaSwgMjAyNS0wOC0xNSBhdCAwOTowMiAtMDcw
MCwgRGFuaWVsIFNjaHVsdHogd3JvdGU6DQo+IFRoZSB3YXRjaGRvZyByZXF1aXJlcyB0byBoYXZl
IHRoZSBNQ1UgRVNNIGVycm9yIHNvdXJjZSBlbmFibGVkIHRvDQo+IHRyaWdnZXIgYSBzeXN0ZW0g
cmVib290LiBXaGVuIGJvb3RpbmcgSFMtU0UgKHNlY3VyaXR5IGVuZm9yY2VkKQ0KPiBkZXZpY2Vz
LCB0aGUgTU1SIHJlZ2lzdGVycyBhcmUgbG9ja2VkIGFnYWluIGFuZCBhbGwgd3JpdGUgY29tbWFu
ZHMNCj4gYXJlIHNpbXBseSBpZ25vcmVkLg0KPiANCj4gVW5sb2NrIHRoZSBNTVIgcmVnaXN0ZXJz
IGFnYWluIHRvIHN1Y2Nlc3NmdWxseSBlbmFibGUgdGhlIE1DVSBFU00NCj4gc291cmNlLg0KDQpJ
J20ganVzdCBjdXJpb3VzLCBjb3VsZCB5b3UgcGxlYXNlIGVsYWJvcmF0ZSBhIGJpdCwgd2hlcmUg
dGhlIHJlZ2lzdGVycw0KYXJlIGJlaW5nIGxvY2tlZCBhZ2FpbiBpZiB0aGV5IGFyZSBiZWluZyB1
bmxvY2tlZCBieSBjdHJsX21tcl91bmxvY2soKQ0KaW4gYm9hcmRfaW5pdF9mKCkgYmVmb3JlIGVu
YWJsZV9tY3VfZXNtX3Jlc2V0KCk/DQoNCklzIGl0IFRJRlMgZmlybXdhcmU/DQpXaGF0IGVsc2Ug
Y291bGQgYmUgYWZmZWN0ZWQ/DQpEbyB3ZSBleHBlY3QgdG8gbGVhdmUgR2VuZXJhbCBQdXJwb3Nl
IENvbnRyb2wgUmVnaXN0ZXJzIHVubG9ja2VkDQp3aGVuIHdlIHJldHVybiBmcm9tIGJvYXJkX2lu
aXRfZigpPw0KRG9lcyBpdCBtZWFuIHRoYXQgdGhlIHdob2xlIGN0cmxfbW1yX3VubG9jaygpIGhh
cyB0byBiZSByZS1kb25lDQphZnRlciBrM19zeXNmd19sb2FkZXIoKSBjYWxsPw0KDQo+IFNpZ25l
ZC1vZmYtYnk6IERhbmllbCBTY2h1bHR6IDxkLnNjaHVsdHpAcGh5dGVjLmRlPg0KPiAtLS0NCj4g
wqBhcmNoL2FybS9tYWNoLWszL2FtNjJ4L2FtNjI1X2luaXQuYyB8IDMgKysrDQo+IMKgMSBmaWxl
IGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21h
Y2gtazMvYW02MngvYW02MjVfaW5pdC5jIGIvYXJjaC9hcm0vbWFjaC1rMy9hbTYyeC9hbTYyNV9p
bml0LmMNCj4gaW5kZXggYTQyMjkxOWZhYjEuLjQ5OGJiZTQ1YjM4IDEwMDY0NA0KPiAtLS0gYS9h
cmNoL2FybS9tYWNoLWszL2FtNjJ4L2FtNjI1X2luaXQuYw0KPiArKysgYi9hcmNoL2FybS9tYWNo
LWszL2FtNjJ4L2FtNjI1X2luaXQuYw0KPiBAQCAtODQsNiArODQsOSBAQCBzdGF0aWMgdm9pZCBj
dHJsX21tcl91bmxvY2sodm9pZCkNCj4gwqANCj4gwqBzdGF0aWMgX19tYXliZV91bnVzZWQgdm9p
ZCBlbmFibGVfbWN1X2VzbV9yZXNldCh2b2lkKQ0KPiDCoHsNCj4gKwkvKiBDVFJMTU1SX01DVV9S
U1QgcmVnaXN0ZXJzIGFyZSBsb2NrZWQgYWdhaW4gb24gSFMtU0UgZGV2aWNlcyAqLw0KPiArCW1t
cl91bmxvY2soTUNVX0NUUkxfTU1SMF9CQVNFLCA2KTsNCj4gKw0KPiDCoAkvKiBTZXQgQ1RSTE1N
Ul9NQ1VfUlNUX0NUUkw6TUNVX0VTTV9FUlJPUl9SU1RfRU5fWsKgIHRvICcwJyAobG93IGFjdGl2
ZSkgKi8NCj4gwqAJdTMyIHN0YXQgPSByZWFkbChDVFJMTU1SX01DVV9SU1RfQ1RSTCk7DQo+IMKg
DQoNCi0tIA0KQWxleGFuZGVyIFN2ZXJkbGluDQpTaWVtZW5zIEFHDQp3d3cuc2llbWVucy5jb20N
Cg==
