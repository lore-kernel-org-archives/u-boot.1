Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE5FCCD183
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 07:16:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99D5C835C6;
	Thu, 16 Oct 2025 09:16:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Ua1iRF5n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A39DF8361E; Thu, 16 Oct 2025 09:16:53 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 675F9835FD
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 09:16:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vm8QriQYKodb1N31ioSeI7HmEmUDVcg4SCRbdoCRmX3paAcinnVPIbzyJfoxRilRjTC7jniCU3PVdup0D86IWVb4SUV9YEk4lxTDoSkwocTbmfMCBu9PvU9tgulMUGY7RPJqN/YAfl5mv2uVJDjeQmX9TgyEusI0KUybkXxvoHM9mgW0dXuQfVI1If8825/l7BlhuZRBKSG87coih+mo1BZ+PPXVOH86vn4E2EF+uYd0/nBaO9sqOoKahSeiPf8+fPAujxWtTXsKvuafCeBGfuBxki9F3bYNkd0JMOF6uQxyCsBbqeXVyRH4p/7N3PZD5jFf2yD3sStpmU9AWWK2pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAQp38UeRVzxhzVizHflaqBB1n77OWOZ0nBf9fTS9kQ=;
 b=HG4C7VLQlQcHbi4BFgod0SWiYUvfEdHbaeiW8UqraWFBPDWG+2M387IeVY6Kg+vffHGDV6oS0SCivcZUYjLXAugH4JUqvduAsz7eGGgiDQuMS0EOYBcNl/sBlD3bzZrt1TRL48pEObWL1eyUsivzffCG8tAO2xtCb+zWeI/Nk0QBwd4DoTILLgeEREPL6nIMkjaFMPIfS+JycAB/NOhgID0yc9l9d73t0e4RAgLw66Xzb9vhK/bDqW2uTnhM3CHi6TNE6TVulstaBQ0jnX1ar4DvRY1Xn1ovx3afsWS+FsgzjJDzgaLy4pItJg6TTauiBM2cuA8u0lJCL4fQKbFXtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAQp38UeRVzxhzVizHflaqBB1n77OWOZ0nBf9fTS9kQ=;
 b=Ua1iRF5n2lVbBnvU23E4M8JnNYKJDmnxvyWi+KKmFJQvcfOyBXx31ZCOEuxg5LiNFOmZzbYviq/PUQiTOESMUyXTH1D+4UkyMSagFDDL4V2qrqkRvcPDmylV2lAGqVsthHls+Vvwoulw5HLNrxMiInfbbWXb3Q8ri/eQR9/1/hJ5fAxsMF+f2Sc7qO6fgCkZqMF+TvqJlw7xDBU2gL91h9E+Bo73ukW2mTC8B0XELeKvOJ/qyKgxhdiXr4AzT9z0QZSkXhkLpA6oA/q+18faKIrOcxpQCTE1UsWJrHSEt2DKYIdOhXbz5DtemN4CPC4MtmiUF9EgSiKKeknt7Tx15A==
Received: from GV1P195MB1999.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:97::9) by
 DU2P195MB2467.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:49f::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.13; Thu, 16 Oct 2025 07:16:49 +0000
Received: from GV1P195MB1999.EURP195.PROD.OUTLOOK.COM
 ([fe80::dcf3:ae69:3d27:d34d]) by GV1P195MB1999.EURP195.PROD.OUTLOOK.COM
 ([fe80::dcf3:ae69:3d27:d34d%6]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 07:16:49 +0000
From: Benjamin Hahn <B.Hahn@phytec.de>
To: Jerome Forissier <jerome.forissier@linaro.org>, U-Boot mailing list
 <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>, Tim
 Harvey <tharvey@gateworks.com>, Wolfgang Wallner
 <wolfgang.wallner@br-automation.com>
Subject: Re: [PATCH] net: make dhcp_run() common for NET and NET_LWIP
Thread-Topic: [PATCH] net: make dhcp_run() common for NET and NET_LWIP
Thread-Index: AQHcORibRB6L3JUc7Uyhno6UDTJJXLTEZ3oA
Date: Thu, 16 Oct 2025 07:16:48 +0000
Message-ID: <49148e4c-3f80-41e0-8f98-e72303605a76@phytec.de>
References: <20251009123034.2441110-1-jerome.forissier@linaro.org>
In-Reply-To: <20251009123034.2441110-1-jerome.forissier@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P195MB1999:EE_|DU2P195MB2467:EE_
x-ms-office365-filtering-correlation-id: 30c187f6-5d9f-48d2-561d-08de0c83f8f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?K09GZmdSdWNNQTlBYW9YYU5MTWM3Q2xWN0NTdkJQZzJRY25DVVo3bUdidGJ5?=
 =?utf-8?B?Q1UrdzJiOXV5NG5CL1lzSjE3L1ptNFVCSzlyc0NiVXpacHdDaXpEV3pKNmJX?=
 =?utf-8?B?cXk0ODRoNTBmdHdOcFVOeHRTdWdRRXE2MHduSWtmREIrYUhvS3VtSVdmSEty?=
 =?utf-8?B?WE9mcTdrZzF2cXBLT3ZPd3dJWTJldXpxaGNqOUZQVmR5K2tWYWZTWWdmK29M?=
 =?utf-8?B?Ry9wVlBCdXlhNUpCZUY4eGdzNU9KVllZK2RGRGNHb0FHdHdEb0lTOE80ZzJ2?=
 =?utf-8?B?SjlhSWRCRzhaZWF6RXN0bEFETytobmlTZ25DdGtRZUtLZXY5RDB2Y09EbG1L?=
 =?utf-8?B?a0wzV0ZsQ21QWjdHSXU0RVVsanVOSURMbG9IMlZoWGhVRXdNN0pocTljdjgw?=
 =?utf-8?B?Ynl5ZGVvWDQxNzBLKzBsZzdFOW9jenNCYm1hajM1bUNPSXo0RmE4ZE5ndWhn?=
 =?utf-8?B?ZFR4RFpFb3FxcTZRNURsV1Nrb3JEOEZVM3RoMkVNc3VvMGRSVmNydzlWSEZN?=
 =?utf-8?B?TzdGMncyd3M5L0lnS0l2ZjBjZ0FDMCtzdUs1QmJxd3RENjRFSm91WGVFR1d1?=
 =?utf-8?B?S3k2SmtUeVEydE1GS3B3akhkNFRrNmxybDJvdVRVTWV5eTMwa3dpVENQTUJQ?=
 =?utf-8?B?bW0yR3hlNFdNdU5aZ1pTcUp6VFBhUlBUUVM4Sy9qVDNCSzFRNmU0Ri9STzdO?=
 =?utf-8?B?MTZCemtLNmFGSVZUemNrMFU0V21uSHlRNTVjbVJhQ1hlamx5dWhSOXZXR0RW?=
 =?utf-8?B?Qm1vWm45Ky9xRm94QkgzRzNvMlpxcCt0M3ZjSGRBQlAzYnMvNjBiQ0krTHow?=
 =?utf-8?B?QmtyN3NiZDM5UDhFYUkrMm1jMHliSUJiQWxzN0FscHNieUpkeE8vMDJ2RTRE?=
 =?utf-8?B?MjcyeFJTc2VEVUhkeVZlVklnR0VqT0tZbkdhT0hBNk5PdGpWSGhlM0puVUg1?=
 =?utf-8?B?ZXVhNGJuOVcvZEo0VHd2Qk1DcHVLalFPMnRJZ05nZUQxUlpGWG9XTjJJUjdw?=
 =?utf-8?B?aDZ6T3FKU01wbkNRSE9xaEx1d3VSS1JyZmJMeU5IckFvVjErOUJJNXg3c0RT?=
 =?utf-8?B?VGlrVzRURlRPbVV1SVRtZm8rOTkremtSOFpjOEJWY3NpOVlzSDJmalpHb1la?=
 =?utf-8?B?K3pXdXd5YjltRGJrR25PUGtZSFBlWTkxQnM0MEc3S2dNbk1PcU9zNlFUVEJF?=
 =?utf-8?B?N1R0RE45SDFkb2F6aE04TTFGbTEwRURPTU5WSEZ4TUt6OGo5MVRwd1ZQTDVk?=
 =?utf-8?B?ZUxKSFpzUyszYkhDRnNJNkNBTGRycXhOZEgvNGFhU2RLZEdSWEROaG1iN1J5?=
 =?utf-8?B?M0tpSXFTWXVHc0l3a2tYMlkycUpodkJCS0hDL0hyWTBVNkFMc01hRlBrd2I1?=
 =?utf-8?B?cHROdUtFSjZaVHpqNXNjQXhwY1FXd0VZUDJMR2xlNmJBN2dQTDJQK21EcDJS?=
 =?utf-8?B?TVl2dTJBMGdhaCt1eXNJRkRUYVQ5cTN5am5BMzhYb2ZjN3NOYlhsT3Fvc3Uy?=
 =?utf-8?B?T0FJYzg0NFBNUVVqUVB2ZStYb1YwbWtXQ1E3N2tDMjlXOEN6UXhkQUJpQ0hV?=
 =?utf-8?B?cUN2eW0vdDRMajRLUlpDaU8vbzlBcEFzMTE1anl5WFBJMnIzMHIrK1ZDa3BF?=
 =?utf-8?B?MFhKd2oxSkpKNzFjTVJkZXJkWkxwOUtubExzWG1jaVdGeWpEb0pPT2FUZmh3?=
 =?utf-8?B?b28rRFgxc3JaM0pxb245YTQ5RWJqTkM0aE5meE9WanVoS3V1WE1JL0FOcmxx?=
 =?utf-8?B?OEQxeTVoZEFxbXRzblBKWjZheEM0dUU2VHZhY0RUZkhiZkRtU2IyQlJMa3Nx?=
 =?utf-8?B?R0JxeFl0eXNTQWxKeklVZ0N0c0VBS0s1YWRPa1NlUkZJRGxMSmhoUCtYOGFB?=
 =?utf-8?B?dlFWM3dOK2JhckxBclZhd0xpMUd2VHN1UGU3RStLMkFad3lzK1F0TnIza1Zv?=
 =?utf-8?B?Rms1U3JycFZ2SnloSGV3RER4Ui9KckNOVzJMTkZCRzQvM0tRUUlKb2FPQjZy?=
 =?utf-8?B?akQvSFcyZmJXbFVCRCtTcDNUenZoVlNxTlZvWDdndDkyNHQ1WE5XREc2WlF0?=
 =?utf-8?Q?oNqcyI?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1P195MB1999.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y01NQlcvbDFMZXRLUEIyL1JXMEMwQXlubzZMTldvL21IRGxNYTZ3RmVMN2ha?=
 =?utf-8?B?UWRHQkd2RGU0NDBiVmtVS3dSSmcrT0pzZE96dUFtdk5RaDJBcUhxSklhRCtp?=
 =?utf-8?B?Y2xYWVQxNGUxeU1ISnA4UFRxVjZ3c2pKUGVad0xTUkM2UkpsY1JsOW4rYWpm?=
 =?utf-8?B?NFlURUxWOXJkOWdnWC9zWW5nemVhZXVIajgyM1ZObGRWZ1ovaXdWUmVCZWUz?=
 =?utf-8?B?ZU1iVjNJZkpaZ25pMUZXVUZkZ3BsUUdhdHhkdUJ6Yk5sc2pKYUNpcm5wcThR?=
 =?utf-8?B?Rzk3T0lsUHp6UTJ2TVQzSTBZRUhjbHNGTVZKRW42a0VhM0FscGpZcHhFNWhQ?=
 =?utf-8?B?UWkyQ3o4MjhhSVhGcXIzekdkQXczSlVjaEovOGROUzhicVpOSWMrTGc1MFpr?=
 =?utf-8?B?RTYyblhURTdRWjZZeFBQMzlvV2s0TkJ3TUJ1cC8yMzB6NXd5VG1nUlA2RG9w?=
 =?utf-8?B?T2crSVc0eFQzaGpHWUE1bnUyelh4VnZwU0lnL0RiK0QvdE5rR0lkN3ZRUVpk?=
 =?utf-8?B?MWxWSVlvQVB0bFkwNkJmU1F1QndNQVRRcW85TE4yeGh4d3ovOHdiZ2VrbDVz?=
 =?utf-8?B?Y09ocHRhWUdFcUFYZ0NiU1JQSldLZ0xxbWJrKzZiTTNKSlpPZHFMNnFycnY5?=
 =?utf-8?B?cU5FajRZNmswU3VsbjRZUlhaRFl2VHNpSEE0aVVUdCtCYytTUEVCUk1RY0Jm?=
 =?utf-8?B?SVAwY21FSmRIUENtMkRBSEFIOGMrZ2dXSS9GMUNlclVXaHVyN0FOQTlVQU5N?=
 =?utf-8?B?UjloekxodUxkaW1pMVVVQ21WV0l6V1YzTTZqcVg1ZHJ3SE95MkkzMVJLOEVu?=
 =?utf-8?B?N1o3UXpwT3laNkFZWVk0YlRVYkJ3OUhmL05MUW43dzVBOS82K3I5cmxEWmlY?=
 =?utf-8?B?ZVZBTEpFcEZlS1lGRWlyU242emlEUUFlRWZKYjA5aEE3cmNqYTlDQkpOb1U1?=
 =?utf-8?B?eEUzUmdrMTA2US9LanU3dW93NWI1Z2Q2WXROcThKWkRxWmJRbXRSKzNzOWdZ?=
 =?utf-8?B?NDBuVnp0Yk83ZFhTQVluY01JaWtmaXJuK3BOVUNYMm4wNDRPT3MzMDgyUFVz?=
 =?utf-8?B?dDhNa2UydXN1VHZnVWcvR0hRVytHemk2dGMyckVKTEVMNmlZcUQ3cEx1SVUw?=
 =?utf-8?B?MTBuVmtQTGZRTkl2cTZiL2F3MDhPYUkxNlNMNGJYYkt3SkZsVXV0SlcxcVhX?=
 =?utf-8?B?MkJLdUs3L0Z1SlE4MTVVVlNjUGhwdVpJT3BacVZKOUtiUEJXQlozZFNIYmlJ?=
 =?utf-8?B?ekpLdFprZGNJcU9GM3VXbjNsMHpqRlU4aWNLOFNaQUVuRjNCTU9EeUFUUlFT?=
 =?utf-8?B?Ry92Y2xoa05lRnNwWnVqSzZ4SVZUUTVJZmY2Sy9ZK3JyZ1hJcU5hYVRnbW9n?=
 =?utf-8?B?bno2RS9zTU9xbThHNTV2cFdLZlJyb0hVanBPdVQrd1gvL1A5dDFsd0pBZkRX?=
 =?utf-8?B?RVNCYUNwMUQwMFZJbVQxdGxvMWNYQmdydnBaMW1sWFI5V0YyL3RQbGhPeDIz?=
 =?utf-8?B?S2VtN1kyR1UrWEtvZHFzVXJZUWQvT01oaHB6UU9UUnpQT0k2M3JjUnd2ay9H?=
 =?utf-8?B?d29iUHJMaXp5OVpJM0tUOEZZNytNRmxiMFZQSnE0UlA5OTZaTlZGZkVLZE9E?=
 =?utf-8?B?ZGJNeGp4SWhTeWxZUTNpMFgrcS9HOEhlQUZoeUVUcVVSNXRxSkZicHlldDRT?=
 =?utf-8?B?WnJzeTNOdFBtRVdIZ2MzZk9NbFY1K2V5MXVHZStBWHFyOWtUV0JBVFh4MXkx?=
 =?utf-8?B?WDFtTXJpMzZjemhabjc1cGlnMlJSdWVyMVVwR2NoMVg1dlM0eHBFTDRlZVZE?=
 =?utf-8?B?dVBJaDNnd0o1KzJoRVBJcnB6M2JNQTNtcWJuYktEWUwxaExsZDE1bFlWYlNQ?=
 =?utf-8?B?SDlVVG8vZVdzVDlCTUl2a2l0c2hINXNtVyswRklvOTNhNFY0VXVsOXZhUkJX?=
 =?utf-8?B?NGdnL2hsRWlKb01xT3c2cEtQZkN0M1Y4Yy94cXBCMmV1TDBXaUhTOUIyb3BS?=
 =?utf-8?B?d1JqNWhJWHdqS29EQjloS0RMS0MxVWxRUG5qZjFNUXZTWnFPR2tDRXZ0WFEz?=
 =?utf-8?B?T2o0Qi9GN0Erbk9BUG5KNEFaVENwZUlUL0lHNWwyZCs2OWViOEREaW1RNG5R?=
 =?utf-8?Q?NwGQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6460DADDF968334D91D51A6A82AB0A6B@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1P195MB1999.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c187f6-5d9f-48d2-561d-08de0c83f8f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 07:16:49.0055 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7lSirlkoOW+Rqhk/VzlY3C727LJx9Z+zkBOS+9QUGg7QmXgbSKnSeKaT5xt+OOYTzlq03TCnAlMW3W249JtDtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P195MB2467
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

T24gMDkuMTAuMjUgMTQ6MzAsIEplcm9tZSBGb3Jpc3NpZXIgd3JvdGU6DQo+IFRIZXJlIGFyZSBj
dXJyZW50bHkgdHdvIGltcGxlbWVudGF0aW9ucyBvZiBkaGNwX3J1bigpOiBvbmUgaW4gY21kL25l
dC5jDQo+IGZvciBORVQgYW5kIG9uZSBpbiBuZXQvbHdpcC9kaGNwLmMgZm9yIE5FVF9MV0lQLiBU
aGVyZSBpcyBubw0KPiBqdXN0aWZpY2F0aW9uIGZvciB0aGF0LiBUaGVyZWZvcmUsIG1vdmUgdGhl
IE5FVCB2ZXJzaW9uIGludG8NCj4gbmV0L25ldC1jb21tb24uYyB0byBiZSB1c2VkIGJ5IGJvdGgg
c3RhY2tzLCBhbmQgZHJvcCB0aGUgTkVUX0xXSVANCj4gdmVyc2lvbiB3aGljaCBieSB0aGUgd2F5
IGRvZXMgbm90IGxvb2sgdG90YWxseSBjb3JyZWN0Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBKZXJv
bWUgRm9yaXNzaWVyIDxqZXJvbWUuZm9yaXNzaWVyQGxpbmFyby5vcmc+DQo+IFN1Z2dlc3RlZC1i
eTogVG9tIFJpbmkgPHRyaW5pQGtvbnN1bGtvLmNvbT4NCkFja2VkLWJ5OiBCZW5qYW1pbiBIYWhu
IDxCLkhhaG5AcGh5dGVjLmRlPg0KPiAtLS0NCj4NCj4gICBjbWQvbmV0LmMgICAgICAgICAgICB8
IDM2ICsrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgIGluY2x1ZGUvbmV0
LWNvbW1vbi5oIHwgMTAgKysrKysrKysrKw0KPiAgIGluY2x1ZGUvbmV0LWx3aXAuaCAgIHwgIDEg
LQ0KPiAgIG5ldC9sd2lwL2RoY3AuYyAgICAgIHwgMjIgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
PiAgIG5ldC9uZXQtY29tbW9uLmMgICAgIHwgMzUgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysNCj4gICA1IGZpbGVzIGNoYW5nZWQsIDQ3IGluc2VydGlvbnMoKyksIDU3IGRlbGV0
aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvY21kL25ldC5jIGIvY21kL25ldC5jDQo+IGluZGV4
IDg4NjczNWVhMTRmNi4uMjQwOTk3NjQ0OTNlIDEwMDY0NA0KPiAtLS0gYS9jbWQvbmV0LmMNCj4g
KysrIGIvY21kL25ldC5jDQo+IEBAIC0xMzQsOCArMTM0LDggQEAgVV9CT09UX0NNRChkaGNwNiwJ
MywJMSwJZG9fZGhjcDYsDQo+ICAgI2VuZGlmDQo+ICAgDQo+ICAgI2lmIGRlZmluZWQoQ09ORklH
X0NNRF9ESENQKQ0KPiAtc3RhdGljIGludCBkb19kaGNwKHN0cnVjdCBjbWRfdGJsICpjbWR0cCwg
aW50IGZsYWcsIGludCBhcmdjLA0KPiAtCQkgICBjaGFyICpjb25zdCBhcmd2W10pDQo+ICtpbnQg
ZG9fZGhjcChzdHJ1Y3QgY21kX3RibCAqY21kdHAsIGludCBmbGFnLCBpbnQgYXJnYywNCj4gKwkg
ICAgY2hhciAqY29uc3QgYXJndltdKQ0KPiAgIHsNCj4gICAJcmV0dXJuIG5ldGJvb3RfY29tbW9u
KERIQ1AsIGNtZHRwLCBhcmdjLCBhcmd2KTsNCj4gICB9DQo+IEBAIC0xNDUsMzggKzE0NSw2IEBA
IFVfQk9PVF9DTUQoDQo+ICAgCSJib290IGltYWdlIHZpYSBuZXR3b3JrIHVzaW5nIERIQ1AvVEZU
UCBwcm90b2NvbCIsDQo+ICAgCSJbbG9hZEFkZHJlc3NdIFtbaG9zdElQYWRkcjpdYm9vdGZpbGVu
YW1lXSINCj4gICApOw0KPiAtDQo+IC1pbnQgZGhjcF9ydW4odWxvbmcgYWRkciwgY29uc3QgY2hh
ciAqZm5hbWUsIGJvb2wgYXV0b2xvYWQpDQo+IC17DQo+IC0JY2hhciAqZGhjcF9hcmd2W10gPSB7
ImRoY3AiLCBOVUxMLCAoY2hhciAqKWZuYW1lLCBOVUxMfTsNCj4gLQlzdHJ1Y3QgY21kX3RibCBj
bWR0cCA9IHt9OwkvKiBkdW1teSAqLw0KPiAtCWNoYXIgZmlsZV9hZGRyWzE3XTsNCj4gLQlpbnQg
b2xkX2F1dG9sb2FkOw0KPiAtCWludCByZXQsIHJlc3VsdDsNCj4gLQ0KPiAtCWxvZ19kZWJ1Zygi
YWRkcj0lbHgsIGZuYW1lPSVzLCBhdXRvbG9hZD0lZFxuIiwgYWRkciwgZm5hbWUsIGF1dG9sb2Fk
KTsNCj4gLQlvbGRfYXV0b2xvYWQgPSBlbnZfZ2V0X3llc25vKCJhdXRvbG9hZCIpOw0KPiAtCXJl
dCA9IGVudl9zZXQoImF1dG9sb2FkIiwgYXV0b2xvYWQgPyAieSIgOiAibiIpOw0KPiAtCWlmIChy
ZXQpDQo+IC0JCXJldHVybiBsb2dfbXNnX3JldCgiZW4xIiwgLUVJTlZBTCk7DQo+IC0NCj4gLQlp
ZiAoYXV0b2xvYWQpIHsNCj4gLQkJc3ByaW50ZihmaWxlX2FkZHIsICIlbHgiLCBhZGRyKTsNCj4g
LQkJZGhjcF9hcmd2WzFdID0gZmlsZV9hZGRyOw0KPiAtCX0NCj4gLQ0KPiAtCXJlc3VsdCA9IGRv
X2RoY3AoJmNtZHRwLCAwLCAhYXV0b2xvYWQgPyAxIDogZm5hbWUgPyAzIDogMiwgZGhjcF9hcmd2
KTsNCj4gLQ0KPiAtCXJldCA9IGVudl9zZXQoImF1dG9sb2FkIiwgb2xkX2F1dG9sb2FkID09IC0x
ID8gTlVMTCA6DQo+IC0JCSAgICAgIG9sZF9hdXRvbG9hZCA/ICJ5IiA6ICJuIik7DQo+IC0JaWYg
KHJldCkNCj4gLQkJcmV0dXJuIGxvZ19tc2dfcmV0KCJlbjIiLCAtRUlOVkFMKTsNCj4gLQ0KPiAt
CWlmIChyZXN1bHQpDQo+IC0JCXJldHVybiBsb2dfbXNnX3JldCgicmVzIiwgLUVOT0VOVCk7DQo+
IC0NCj4gLQlyZXR1cm4gMDsNCj4gLX0NCj4gICAjZW5kaWYNCj4gICANCj4gICAjaWYgZGVmaW5l
ZChDT05GSUdfQ01EX05GUykNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbmV0LWNvbW1vbi5oIGIv
aW5jbHVkZS9uZXQtY29tbW9uLmgNCj4gaW5kZXggMTExMmFmMzgxYTk4Li43OGQ5OGU1YmJhMDcg
MTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbmV0LWNvbW1vbi5oDQo+ICsrKyBiL2luY2x1ZGUvbmV0
LWNvbW1vbi5oDQo+IEBAIC00NzksNiArNDc5LDE2IEBAIGludCBuZXRfbG9vcChlbnVtIHByb3Rv
X3QgcHJvdG9jb2wpOw0KPiAgICAqLw0KPiAgIGludCBkaGNwX3J1bih1bG9uZyBhZGRyLCBjb25z
dCBjaGFyICpmbmFtZSwgYm9vbCBhdXRvbG9hZCk7DQo+ICAgDQo+ICsvKioNCj4gKyAqIGRvX2Ro
Y3AgLSBSdW4gdGhlIGRoY3AgY29tbWFuZA0KPiArICoNCj4gKyAqIEBjbWR0cDogVW51c2VkDQo+
ICsgKiBAZmxhZzogQ29tbWFuZCBmbGFncyAoQ01EX0ZMQUdfLi4uKQ0KPiArICogQGFyZ2M6IE51
bWJlciBvZiBhcmd1bWVudHMNCj4gKyAqIEBhcmd2OiBMaXN0IG9mIGFyZ3VtZW50cw0KPiArICog
UmV0dXJuOiByZXN1bHQgKHNlZSBlbnVtIGNvbW1hbmRfcmV0X3QpDQo+ICsgKi8NCj4gK2ludCBk
b19kaGNwKHN0cnVjdCBjbWRfdGJsICpjbWR0cCwgaW50IGZsYWcsIGludCBhcmdjLCBjaGFyICpj
b25zdCBhcmd2W10pOw0KPiAgIA0KPiAgIC8qKg0KPiAgICAqIGRvX3BpbmcgLSBSdW4gdGhlIHBp
bmcgY29tbWFuZA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9uZXQtbHdpcC5oIGIvaW5jbHVkZS9u
ZXQtbHdpcC5oDQo+IGluZGV4IGU4OGUyMTg2NjM1Yi4uYzkxMGRlZjU3MTllIDEwMDY0NA0KPiAt
LS0gYS9pbmNsdWRlL25ldC1sd2lwLmgNCj4gKysrIGIvaW5jbHVkZS9uZXQtbHdpcC5oDQo+IEBA
IC01MCw3ICs1MCw2IEBAIGludCBuZXRfbHdpcF9kbnNfcmVzb2x2ZShjaGFyICpuYW1lX29yX2lw
LCBpcF9hZGRyX3QgKmlwKTsNCj4gICAgKi8NCj4gICBib29sIHdnZXRfdmFsaWRhdGVfdXJpKGNo
YXIgKnVyaSk7DQo+ICAgDQo+IC1pbnQgZG9fZGhjcChzdHJ1Y3QgY21kX3RibCAqY21kdHAsIGlu
dCBmbGFnLCBpbnQgYXJnYywgY2hhciAqY29uc3QgYXJndltdKTsNCj4gICBpbnQgZG9fZG5zKHN0
cnVjdCBjbWRfdGJsICpjbWR0cCwgaW50IGZsYWcsIGludCBhcmdjLCBjaGFyICpjb25zdCBhcmd2
W10pOw0KPiAgIGludCBkb193Z2V0KHN0cnVjdCBjbWRfdGJsICpjbWR0cCwgaW50IGZsYWcsIGlu
dCBhcmdjLCBjaGFyICogY29uc3QgYXJndltdKTsNCj4gICANCj4gZGlmZiAtLWdpdCBhL25ldC9s
d2lwL2RoY3AuYyBiL25ldC9sd2lwL2RoY3AuYw0KPiBpbmRleCA1MzFiZjJjNjcwNTcuLmI3OTgw
MTRlYmNiOSAxMDA2NDQNCj4gLS0tIGEvbmV0L2x3aXAvZGhjcC5jDQo+ICsrKyBiL25ldC9sd2lw
L2RoY3AuYw0KPiBAQCAtMTUwLDI1ICsxNTAsMyBAQCBpbnQgZG9fZGhjcChzdHJ1Y3QgY21kX3Ri
bCAqY21kdHAsIGludCBmbGFnLCBpbnQgYXJnYywgY2hhciAqY29uc3QgYXJndltdKQ0KPiAgIA0K
PiAgIAlyZXR1cm4gQ01EX1JFVF9TVUNDRVNTOw0KPiAgIH0NCj4gLQ0KPiAtaW50IGRoY3BfcnVu
KHVsb25nIGFkZHIsIGNvbnN0IGNoYXIgKmZuYW1lLCBib29sIGF1dG9sb2FkKQ0KPiAtew0KPiAt
CWNoYXIgKmRoY3BfYXJndltdID0geyJkaGNwIiwgTlVMTCwgfTsNCj4gLSNpZmRlZiBDT05GSUdf
Q01EX1RGVFBCT09UDQo+IC0JY2hhciAqdGZ0cF9hcmd2W10gPSB7InRmdHBib290IiwgYm9vdF9m
aWxlX25hbWUsIE5VTEwsIH07DQo+IC0jZW5kaWYNCj4gLQlzdHJ1Y3QgY21kX3RibCBjbWR0cCA9
IHt9OwkvKiBkdW1teSAqLw0KPiAtDQo+IC0JaWYgKGF1dG9sb2FkKSB7DQo+IC0jaWZkZWYgQ09O
RklHX0NNRF9URlRQQk9PVA0KPiAtCQkvKiBBc3N1bWUgREhDUCB3YXMgYWxyZWFkeSBwZXJmb3Jt
ZWQgKi8NCj4gLQkJaWYgKGJvb3RfZmlsZV9uYW1lWzBdKQ0KPiAtCQkJcmV0dXJuIGRvX3RmdHBi
KCZjbWR0cCwgMCwgMiwgdGZ0cF9hcmd2KTsNCj4gLQkJcmV0dXJuIDA7DQo+IC0jZWxzZQ0KPiAt
CQlyZXR1cm4gLUVPUE5PVFNVUFA7DQo+IC0jZW5kaWYNCj4gLQl9DQo+IC0NCj4gLQlyZXR1cm4g
ZG9fZGhjcCgmY21kdHAsIDAsIDEsIGRoY3BfYXJndik7DQo+IC19DQo+IGRpZmYgLS1naXQgYS9u
ZXQvbmV0LWNvbW1vbi5jIGIvbmV0L25ldC1jb21tb24uYw0KPiBpbmRleCBiMDY0NTU3ZDUyNDEu
LjQ0MmIwNTk3NTU4MSAxMDA2NDQNCj4gLS0tIGEvbmV0L25ldC1jb21tb24uYw0KPiArKysgYi9u
ZXQvbmV0LWNvbW1vbi5jDQo+IEBAIC0xLDYgKzEsNyBAQA0KPiAgIC8vIFNQRFgtTGljZW5zZS1J
ZGVudGlmaWVyOiBHUEwtMi4wDQo+ICAgDQo+ICAgI2luY2x1ZGUgPGRtL3VjbGFzcy5oPg0KPiAr
I2luY2x1ZGUgPGVudi5oPg0KPiAgICNpbmNsdWRlIDxuZXQtY29tbW9uLmg+DQo+ICAgI2luY2x1
ZGUgPGxpbnV4L3RpbWUuaD4NCj4gICAjaW5jbHVkZSA8cnRjLmg+DQo+IEBAIC00OCwzICs0OSwz
NyBAQCB2b2lkIG5ldF9zbnRwX3NldF9ydGModTMyIHNlY29uZHMpDQo+ICAgCSAgICAgICB0bS50
bV95ZWFyLCB0bS50bV9tb24sIHRtLnRtX21kYXksDQo+ICAgCSAgICAgICB0bS50bV9ob3VyLCB0
bS50bV9taW4sIHRtLnRtX3NlYyk7DQo+ICAgfQ0KPiArDQo+ICsjaWYgZGVmaW5lZChDT05GSUdf
Q01EX0RIQ1ApDQo+ICtpbnQgZGhjcF9ydW4odWxvbmcgYWRkciwgY29uc3QgY2hhciAqZm5hbWUs
IGJvb2wgYXV0b2xvYWQpDQo+ICt7DQo+ICsJY2hhciAqZGhjcF9hcmd2W10gPSB7ImRoY3AiLCBO
VUxMLCAoY2hhciAqKWZuYW1lLCBOVUxMfTsNCj4gKwlzdHJ1Y3QgY21kX3RibCBjbWR0cCA9IHt9
OwkvKiBkdW1teSAqLw0KPiArCWNoYXIgZmlsZV9hZGRyWzE3XTsNCj4gKwlpbnQgb2xkX2F1dG9s
b2FkOw0KPiArCWludCByZXQsIHJlc3VsdDsNCj4gKw0KPiArCWxvZ19kZWJ1ZygiYWRkcj0lbHgs
IGZuYW1lPSVzLCBhdXRvbG9hZD0lZFxuIiwgYWRkciwgZm5hbWUsIGF1dG9sb2FkKTsNCj4gKwlv
bGRfYXV0b2xvYWQgPSBlbnZfZ2V0X3llc25vKCJhdXRvbG9hZCIpOw0KPiArCXJldCA9IGVudl9z
ZXQoImF1dG9sb2FkIiwgYXV0b2xvYWQgPyAieSIgOiAibiIpOw0KPiArCWlmIChyZXQpDQo+ICsJ
CXJldHVybiBsb2dfbXNnX3JldCgiZW4xIiwgLUVJTlZBTCk7DQo+ICsNCj4gKwlpZiAoYXV0b2xv
YWQpIHsNCj4gKwkJc3ByaW50ZihmaWxlX2FkZHIsICIlbHgiLCBhZGRyKTsNCj4gKwkJZGhjcF9h
cmd2WzFdID0gZmlsZV9hZGRyOw0KPiArCX0NCj4gKw0KPiArCXJlc3VsdCA9IGRvX2RoY3AoJmNt
ZHRwLCAwLCAhYXV0b2xvYWQgPyAxIDogZm5hbWUgPyAzIDogMiwgZGhjcF9hcmd2KTsNCj4gKw0K
PiArCXJldCA9IGVudl9zZXQoImF1dG9sb2FkIiwgb2xkX2F1dG9sb2FkID09IC0xID8gTlVMTCA6
DQo+ICsJCSAgICAgIG9sZF9hdXRvbG9hZCA/ICJ5IiA6ICJuIik7DQo+ICsJaWYgKHJldCkNCj4g
KwkJcmV0dXJuIGxvZ19tc2dfcmV0KCJlbjIiLCAtRUlOVkFMKTsNCj4gKw0KPiArCWlmIChyZXN1
bHQpDQo+ICsJCXJldHVybiBsb2dfbXNnX3JldCgicmVzIiwgLUVOT0VOVCk7DQo+ICsNCj4gKwly
ZXR1cm4gMDsNCj4gK30NCj4gKyNlbmRpZg0KDQoNCg==
