Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED7CFF8861
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 09:48:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20EDC83C14;
	Mon, 27 Apr 2026 11:48:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="HW5oM8c/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 755F184119; Mon, 27 Apr 2026 11:48:53 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A356839D9
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 11:48:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p2qJ3Q5u+w99V94zl48494mt7JnZroIg8voLH3eg+CKAKwJREqiLa7/wxOnXhphdzCuS/zcu7KYEGzQ4u9REimiNaA93DpDMS+5Nek+sDBWV6z4EZ/FkljIbJENCb5NfNx6gZyS4BH5oz/eYgGtjGtKc+4EWfLR9XZ6VVxop8D+Jpsipw9V1DPyUc8Fm0s2vIHQoyJ/NISeQ6rqBfznv8tVKC/TwqnpEcDEhbtjJG3hBXxakT8eRIYCUaxIrxmNTFhAAOJz8XUSoYJ/MLWCj8jrNPG36sqnccOZjxZ+NfMBdsS1DKNZvFxze3IO5GOFlyv2XagpMtXCs4x0RyDoXhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5hTCAaA3vDrM5PrRxr3+jXldCn0p+An6rNmAqtU0T0=;
 b=sXDF5s+XgG/6HfVuo9Jsce3zzuKX6V/LBp4o/VCb+Xf2zgODJLbWDwAtFg8W6IrJ+0Mo4XgvqjNLP6/I9lgdDwEzFnK0eyxX570kcY8gopx4Mnxo4h/4Hd0hv79pLjkGFXynXhlfTcW3VyiWA2kRX70Ls4epxbfvgEXpbKmCzxePEv0P5IPfCzl6PqAia8DxcJyHXRR8v+ZL3/cw9LItZAgo2hfbgCc8qqp+IdIL2AEpOFBTQoqDa0ObS5Cfrxb40KT5DDP6C6BmjNuOvWlc3N67hqPUinl7dpjsnzWkN7OHj1sZFzimI0gNdgd/EzT6tGKTCADZFFrtqWmTPULy/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5hTCAaA3vDrM5PrRxr3+jXldCn0p+An6rNmAqtU0T0=;
 b=HW5oM8c/nJYsI8UKF5a8qKiouAHoTYCA5pB2cO/1h/h0h1PaqlzUVprSopTqu4MLUF+YR6GPLz49+jRLGa3J+n6uw8f9bjLLSnxzTK+2CAytfFxZs2p2OOOGEJB7UEfyjgBXEVkABAoGXVrVFX9euG9GlGRaHlCPou+DiXvKH4k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by AM9PR04MB7633.eurprd04.prod.outlook.com (2603:10a6:20b:2d9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 09:48:43 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.20.9846.016; Mon, 27 Apr 2026
 09:48:43 +0000
Message-ID: <491f7007-0574-4fa5-897c-59002c7dcaf6@cherry.de>
Date: Mon, 27 Apr 2026 11:48:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] binman: bintool: add extra_env parameter to run_cmd
To: Sergio Prado <sergio.prado@e-labworks.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com,
 ilias.apalodimas@linaro.org, marek.vasut+renesas@mailbox.org,
 sughosh.ganu@arm.com, wolfgang.wallner@at.abb.com, bb@ti.com,
 y.moog@phytec.de, xypron.glpk@gmx.de, jerome.forissier@arm.com, afd@ti.com,
 Wojciech.Dubowik@mt.com
References: <20260423154536.768603-1-sergio.prado@e-labworks.com>
 <20260423154536.768603-2-sergio.prado@e-labworks.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260423154536.768603-2-sergio.prado@e-labworks.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIYP296CA0006.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:29d::11) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|AM9PR04MB7633:EE_
X-MS-Office365-Filtering-Correlation-Id: c261ada4-4853-467c-7ea8-08dea4422ae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: pToXvfKBklXJeV2LJD7OiQTyvDKm2bBbL3UJglDhWnJDPk0+qiMGYQnPo6S8V0F7I9qAFo89kytJFMRbvyIzWEBb2w5eRbmMQUPdxxMzPyRTJz/1S8G3ByOEzCvFzMcCMg4Sna9kAHqGJIP2DEWPloASobNgqu+JaoKCokIab+J+zSm7Y/YrduTtr3+xHZcXhWdzUVbW1eXBme68DzmoJoCwymqzkYPH736pOdv/TjVFpCS+vNQ8ZYcJz3SRkxziRA7wI7QTPB5hUTk4cfJfPkvaDdXL88jYQZ6Z0ecCFVLUhq288A7RpvnVc9sNTczK6cnJctupPvQ0IaMaAxQ26mKsMkXQer4YfD4KtaPLOmI5AIZpX1V8WAsC0vVAEIkifJU2rZlbBn90HXs6YKY2zVluF0pxTpC4PTrsfImOYt2yqwAYMdi6hxQcUHIDI0cOjTUoyDstrIdawnW0fIEwMqWM1aJiKGJtYcTnNCKB2zQoLCcjkqwnTVVIgSe861NKoZ4HEGFrrCugZx60jG5/rqm+o6DBISXIEIeQuo7gGjUjvk/JK5kJ3Bwt+0xE+vPnLGqofJ6kF1jF4BOIijeFt4rqNVfmPuQl15VG57+zl2auopLEG12OsoCjHbNTsiXTOsHqCpBHeGfvdABXszgLRaZmFF770tKp/ii1CgbxRjWTGnIowljsEEmkrdsQpsDRA0pVuXVMNmShsS0m37Z8mCcHdmEHuXg1OAQqV3ijOlA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGxHajNDNmVkYklvS295TS94WEgzOWNhemR3aTdRMmg5c2FpTG83dGNra2xr?=
 =?utf-8?B?Tm9Lc2RRZDI1ZHM4ZTRsNW5OMFBuaXB0UjdOWVJmSzFpVnNiTitybXllSHFR?=
 =?utf-8?B?VUJIc1IzaHhOWDhGUjJLVjBGNlErQXFPeHhzVThIQkFLQlE3OThYZFJpTTNJ?=
 =?utf-8?B?RUVpZVE2c1lxTlFCMHVFUURBTjU1QnN6bHkwN0xEcml6R0VkcUpuSVJSU2VW?=
 =?utf-8?B?aGEyUnFmRjBueVNDQnRpVVNaSzl4cXNEUFlGS2hKV1FxeG5xelBSTmNReU1D?=
 =?utf-8?B?OElMVWoreVNpQmRHZTM4bzRYZ0pGemxFdk1XNDR6elBjMUVTN240YkVycXFF?=
 =?utf-8?B?SGFlWGFzOWNmWFY5cVJEZjJHd2JOcG9VZmdhSkprZ1FmMkpaTVZsaGc4RFcw?=
 =?utf-8?B?NnVuYTZiRG16SllmSWlTT05vdGJvdnhXYkpPQTR3MWFHUEVXN1FDUUNKeGZJ?=
 =?utf-8?B?clhQeUh5Q21ESGY0SG5Cdm9DWWc0b0orcGpyMSttQjBONHBYNXZud1ZCRVRq?=
 =?utf-8?B?WFlhdWhyTXd4a0tydHVNM29OWnpHSkV4Q05EYzNuaTl6MERXUlNyZTY3MkRl?=
 =?utf-8?B?Z3Q3SENaaVpkNEEwNDJ3eWFrTmxWQ3Fuc1E0cUZQVFhtMjRTMWZvdjFQUjAv?=
 =?utf-8?B?WWQrSW5YY3o2U0R1YkpLOE9NR2F5bXNxc1R3R1k5VkdJTXF1bkp3c1BQZEJO?=
 =?utf-8?B?UXJsVmdSMU8zWUJIMnpMWk1TYVZXeDNLUmxzUHhSc0ZaWDJ6Snpoa0E4MWMv?=
 =?utf-8?B?bVZwUXpDVDFhRGJabVBvaStjeG9qbFlyUysyRmw5b3ZNYXhtaS9lODl3VG53?=
 =?utf-8?B?S0ZkRU55L0NJTmJTKzJtelVIR21IcndDQlkzK3ZzRnNaNG12blZ0aDRWTVBr?=
 =?utf-8?B?azNJMDg1a2MzWHYwMHZzSjVGajhJVCs5WHIyQTVXR3R4Nmdtd2l5YmRadjBP?=
 =?utf-8?B?WnRpK3hEQXQvVW9ibVFZQVBNSHZYdHZ3NU1tOHdUNDFTRytRNVROUnBTYTlI?=
 =?utf-8?B?MzBINVpRVXh1RWUzMGtYc0puYWc0RWdkZlUvQnhXSmRMOE82QUVydm94VEZy?=
 =?utf-8?B?MWVSbEwyZG1VdG52UUVZNjhpSXdlcC8ybUJ4U2JUc3J4bjA5d1hzeEtETkdz?=
 =?utf-8?B?cDQ1VWM0ZTlQbEg1VnhkUDAwbU9selZoSVNrVjE2d2tvR2lsaGlSUTlHV1lL?=
 =?utf-8?B?a3NlS1FhcXpQeHpPTXk2aDIwQ1UwYnU3emFuV1VyQ2pIWkRndmp3NUhBd1hs?=
 =?utf-8?B?ZFV6aGZGQ2x6c0hvWXNKZ2psTU96Rmp4V0trb29rMXdBRmg0Y0xFekkzU3A2?=
 =?utf-8?B?NGNVM1VjVCsxQUlNUlBBd0ZBM2xhTjlFWkhmTXMzc1J3UURBMXVuU2FIVU9v?=
 =?utf-8?B?SGNXR2RoWTAxNTdINzVBWTI0UEE1MzFQOVRRV2ZyRUptNEVXckZKT21mWWV0?=
 =?utf-8?B?OW1nMVBSNHdHbk1kYTJBRlN5VnBlbzB3eTgwVjFQMmxFb0x3cDYrTUJsbkxt?=
 =?utf-8?B?bFQ4MlJEKzFQRFl6OHBQSkp5OFl5elNFbXd1TTZ3M3ZsaUtob2NYNEVOWVRE?=
 =?utf-8?B?SDRwaTYwTGlQWG9qMWU0UTlnSlFSVmZ0Z2VLUlRoVkpHTDJBaS9aSzhPdXRv?=
 =?utf-8?B?cWFuVTBDQWRXZTgwczRCb1JaR2c2T2I0R3ZrZVlrWC9nQzVsTElyWnNadnpC?=
 =?utf-8?B?Y3R2UWw3czRxOGlwd0dXbE9KNWVuYjhIcXEvSmZmUEpsbmhROHBxYWtjczJI?=
 =?utf-8?B?c2dPZkY5MGZLYmo4TDBnSWNEVFBjay9aWTRNRVBoNHRDNnExYU9KSTRiUFZk?=
 =?utf-8?B?a2wzNWN0d3RKS2xtNCs3RS8wS3R3SmlvMi80elFERm1CQTRZT1NZdEFLaXZS?=
 =?utf-8?B?Wm9FWkZYYzVDN2g1VWkveDVYZ2gxam13QzFQbjdpMkMxUkYyYjVzcXZlanBv?=
 =?utf-8?B?UXFnMWUrek1GM0ZOTTNFb0UzbFl0KzJ2VjRvNEhqVEgreSttWlVLRDV1bGQ0?=
 =?utf-8?B?dzJ1Rkt4L2dBeHN0QW5vK0xXRHI3UU1jWDg4bFFUbFgyRmlnTkhvZ2IxU1Iv?=
 =?utf-8?B?NGZ5SDM4eUNWVmcrc05jSE5hdHhvZXFaODdLbHVZY3RqNXB0Mnh0QXhqSWlz?=
 =?utf-8?B?QkZYcmpkY3dNTm5RL3ZCUDN5aUNEQXlzd1B0R0lKZ05zdEtLVUpiNTZzK0lx?=
 =?utf-8?B?ZnJnOXNmT0kyNU5KQXIxdjNFeFVQdXZqM2xtVmF6UUd6UEdTU1pxV2JGWFRO?=
 =?utf-8?B?WlViSkRtek1xZmczUkUrQWtkaGtCYUVmWFRFdmdQcU56Q2RWZ0dhYXJ2dzZV?=
 =?utf-8?B?MmNCUGU3aGsxN2ZNQlZvWitiNnRJTG1kWmZsejdTcnowbzdkaTE1V0FIdGVU?=
 =?utf-8?Q?qbPauoO+9I6xDi2OsLoAkKagIs7WsHZicPmnZ?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c261ada4-4853-467c-7ea8-08dea4422ae0
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 09:48:42.9527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qa2yi0W8Sk/Y6f1onZ/v7zqfnP/DsDGWbvsElyGnOQ+5+VdUIFanwfPl8dtYESKPVZr8318f0ioSqueGbe5Xf6xh31GqKH7lV4+HBQWcSDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7633
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

Hi Sergio,

On 4/23/26 5:45 PM, Sergio Prado wrote:
> [You don't often get email from sergio.prado@e-labworks.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Add an optional extra_env dict parameter to run_cmd() and
> run_cmd_result(). When provided, the key/value pairs are merged into
> the subprocess environment for that invocation only, leaving the parent
> process environment unchanged.
> 
> This might be needed by bintools that must inject environment variables
> into specific tool calls without polluting the global environment.
> 

Yeah, I'm not convinced this is useful.

We would need to propagate this new variable to whatever calls those 
methods as well. And it quickly balloons.

Just mock the environment with

with unittest.mock.patch.dict('os.environ', {'MYVAR': 'myval'}): like in 
testFitSignPKCS11Object for example?

I'm also very skeptical of the need for binman to *set* environment 
variables to setup openssl.

Look at what's been done for testFitSignPKCS11Object, we externally 
configure openssl and softhsm so that binman doesn't have to know about 
it. This avoids having to play smart and adding a bunch of new 
variables. Is it possible to implement something like that for the x509 
certificates? For FIT, we do use fit,engine, 
fit,engine-keydir/key-name-hint with mkimage to (possibly) use pkcs11, 
custom openssl engines, etc..

Also, I don't think we should decide for the user whether they are 
forced to use a provider or an engine based on the presence of the 
provider? just let them configure openssl to use the one they want 
externally?

Cheers,
Quentin
