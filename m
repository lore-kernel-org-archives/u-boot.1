Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD653CAC5B8
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 07:09:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0755581D6A;
	Thu,  2 Oct 2025 09:09:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="VUE3p5Vy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D052828A2; Thu,  2 Oct 2025 09:09:06 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4769980107
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 09:09:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=M.Schwan@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Te2S3LAZSIBzZWVsNWZ+lNpj4MRpgIEcfYmtrZEMR4HFEtCsSsgRsVs173w+8LUILXi5VR0qCK+2W4yrKRwD34496erDmk7j69jG3dLu7tCaQgxoMLnMwW4lsiV1TOwFfcJdRNfDpHsDSSDwylF2b/jlF7SC32H3AFG+uIvskfxEfNGeXIi3wyDugfgYgEDqIfHXyZuFmhivVn9Fc6VJK8IvOw/HLsH+PjrwTOcROr46fVmuAms5gQzbBHIJoKtZ/VcIjFz4zP7d78wxHVT4o22gnFRsqrdaP+dVDXBR+QaX8nNuvdUCBQaAEqrAJ0+NV5NozlXlrE/pyMb5usII9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7ckBYh1PDTQhDitis1el3yAGvfJbGhIzm2joM/BTs0=;
 b=P2AZ9OM6QaoJHcU3hHOT1dd56kAN3iEOQxsvoixVoF/aDGCtef23FkhT3OVGL18IWZVeEBFNNhZY1TvILGqXDgK1XxETtaK9TCgFwBry0rjQBOxQqpRzW8Z2mQIsn7mFq2RtjIySnU5M+yIAjmoQhzxd0Oo+6pTW3xgj+DIoWSYoR7DJU8lcCSChh5GJPvkUbNzTdSUwqu4lBdENoI7qr9WDnErlU7MajP8HamnU4b0UfPZUocElfGTjCZLPsz3di1DmcES/lEdWo8FSgSnd0qwrP/FVmBMOe1zOu/v7Mllw/gevQ1espoNLNLAS2proqm23YkMPnwHDYWquwHU/hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7ckBYh1PDTQhDitis1el3yAGvfJbGhIzm2joM/BTs0=;
 b=VUE3p5Vyv4eBDqrs3wWlDXOauG7G6gJoM4aE1txUWIKQtwq7Hk39LQ+xWEoTxJTkIEXJ9olfHgKxz0giswybEj9rrXUCEKxBmz8Ym4mPNrBvlyZg6Mq6oV70Ey3KQJMMKXy7cyZ1V0BbXXMueeHmdGvm6nVA6dmoG2rt81kxokav2Sa6Pip9oyq6k8zyrzqfPdBrV1/x2pej6NIh/AKNbPeuIO5w936KefKxAnmkm+Xsv8EwBUxDhPXMdzaFYWEBLOiY/iTxtQJ+ToYknvRUffqHK8fyBKjHBC35HiE4JV81RYHRLCTseWdgehyF31yrgrU1FW98RLWH6gBf1KvG5Q==
Received: from VI2P195MB2489.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::12)
 by GV4P195MB3122.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:2bb::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Thu, 2 Oct
 2025 07:09:00 +0000
Received: from VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
 ([fe80::83ab:361:2a81:b582]) by VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
 ([fe80::83ab:361:2a81:b582%4]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 07:08:59 +0000
From: Martin Schwan <M.Schwan@phytec.de>
To: Andreas Pretzsch <apr@cn-eng.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 1/2] bootstd: rauc: no valid slot fallback: fix info msg
 to reflect real flow
Thread-Topic: [PATCH 1/2] bootstd: rauc: no valid slot fallback: fix info msg
 to reflect real flow
Thread-Index: AQHcMypVVI2lnOL7z0SK0pglHt2E2LSucIMA
Date: Thu, 2 Oct 2025 07:08:59 +0000
Message-ID: <0b068403ad0ee4fb54e058a81e18ca23e1813ce4.camel@phytec.de>
References: <20251001232259.3599563-1-apr@cn-eng.de>
 <20251001232259.3599563-2-apr@cn-eng.de>
In-Reply-To: <20251001232259.3599563-2-apr@cn-eng.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2489:EE_|GV4P195MB3122:EE_
x-ms-office365-filtering-correlation-id: 9016e685-5153-4310-8ed7-08de01828f25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?RUhFNm9CU3BJdi9ldHNMSHQ3bllaejZZdjU1L0VUdU92WkRFREI5V1cxMlg0?=
 =?utf-8?B?bkxyNHlhMTlGVHpWSjUzYnRxQUVKTm5RSDRXZXJxOUtUbVpQZkNuY1RQOWdQ?=
 =?utf-8?B?Uld3S2ZwUEU3NnZvZDA1bTZvNDlZVk45M3RmcHhsMmFOWVN4dmVRUnBZVERD?=
 =?utf-8?B?RmM0QURZOHhGWlg0cEJDeVBmWGwwczhyOWFMREZ5OU5HaEJGT3NjM2E5Z2Zr?=
 =?utf-8?B?c0RET1lhcjhpd0ZQRlpsM0hTM0lYM0FkSzZWUDIrSkhqTmpmYXM0TTZHaUNM?=
 =?utf-8?B?dWk1MU96R2NuUnhMUHZYYzF1ZXNCTHl6U0lGcy9pSTdYY2FPTXQzSXNhcHhs?=
 =?utf-8?B?UUpqM3ZNRk16emVlVVlxYW9uU3BCMVd1ci85bDFBUjBKTHMvcDdONWVCNmVJ?=
 =?utf-8?B?MndSZmpLYko3UXBrandUd1B1Q0dmbm04T09Hdld2aTlabTM4MWIrQUtNOEJR?=
 =?utf-8?B?NGRib0ZsYXNKSk8xdEpnRFluT2RUcUJBOWRXck4vQ3lTVytlUEMvOFdZYXQz?=
 =?utf-8?B?ZTZWczlnTk9MU2tyUXZHVUpndmpHY0lHcVVNRmJpMjdHUlhFZ0FFVDRrR0V2?=
 =?utf-8?B?blVSTDJwai8rNkJzR1FaWnQ2QjYxRHpHa3F2cEdxUDg0bmRnNDJEbzl0ZDA2?=
 =?utf-8?B?bXhBY0JreFJlSktQU3ExYUpKVjRUaWMydjd5OEpBVEVES3EzZW1lWWdUWkpB?=
 =?utf-8?B?YjhhTGlaNElqVE0zR3pQOEI2QnFPV0JlZHgzYkErL1ZSVzczaHI0ZnU1UHBY?=
 =?utf-8?B?dWw4dWhodHBxeFExVlJjNkxXam9PclF4Uk1HbXAwdHQ2NnlKU2hZREExSHdk?=
 =?utf-8?B?czc5aGl3RTVXYTZNalFJeWlBTFJmNnRpa1pOWDQrSHpQdFdGYlJyTmtxcUFm?=
 =?utf-8?B?S2pqTU4yc2hYUFhZWGp6UERsbmwrVUJ2aTVxaCtocHpiUVdDcmhqQjFHN0M4?=
 =?utf-8?B?SHhnN1hGdy9VZTlrVHdWWGRkajl4STNGUlUxcFlJS2F2Wk8yWDBzSUlaeUlR?=
 =?utf-8?B?cjlkNG94OXRXV3diU1pNRUtKL2d5eEI1K0JTNmJjblUzS0lFME9LRzUvSmt3?=
 =?utf-8?B?NUNCcFNEYUUzRllnaDEvamFIWXJRY0ZtQkJOcEhFRlFWMmwyMWV2R0hwdHlq?=
 =?utf-8?B?d05zVDdZNU1Da2diZnZ5YWx2WWxNY2JnYVZXV0pGQXlCMG5JOUJCaGtGMzN6?=
 =?utf-8?B?MjIrcEU4Ry8xb3QvN3ptQXBzUWUzWHFydEx5VVJYV1Y3dGUzQlcyUC80ZTlU?=
 =?utf-8?B?ME9ndlNvMDU1QXNtRFBEODRXbTRBYlpxRHo2QjRZMTI4Z29PWVZKREhZK0RC?=
 =?utf-8?B?MC95Smg4U2twOWt6c3FTaEV4SFZhZlNDZ3M3OXV4R1pZQVM4bjdEVmY1NEdo?=
 =?utf-8?B?WVA5YUJTL1p0d0RWMDBqWmNpTS9JZ3NGZDJxQXgzeUJSRlpKT3JIMG1qMEYy?=
 =?utf-8?B?ZEFGS2VkMzJnbGhGWlRUMUFCK2I1VUloV1E4cTBHaTFXYjRKemlDbmVnY3Vk?=
 =?utf-8?B?aWtkTjdSd0dRdkZZbDNIaVd2U2gwVjFNUzZGTXNLNFgzbHhzNE8vSzdJbnZ2?=
 =?utf-8?B?NDdidzcycHFVV0JseUoyVHpPUGYxandUcFAxOU9LSm8rME5TV2xaRHFoNkgx?=
 =?utf-8?B?MEJBZTdzQ1c2N3d4Q1FYZE03c0J2Nm8ybnZyZkNwV3ZqOVBRNWhEdzhiUWdw?=
 =?utf-8?B?L2hXNWMvWGlVMmNwVGJTQTRLNFYrQUpHMUdCYno5YTRuaUJ0SVNiT3FoNGwx?=
 =?utf-8?B?a045V2cycXlDRXhyVndsbU82anAvMkNRR0EzcnlIRGVEZXYzMkRzVXl3ZW02?=
 =?utf-8?B?QjZlZ3ZGbnFKTU1HZ3JMVXB2enUyMXo0TjNjOFRyWmdQb2dOb21qeGlBSjhy?=
 =?utf-8?B?R1gveEs4TDJ4U29RQ3ZSQjlRREdhbit3ZmRFRlh2YVZDTm94Z1poY3pFeXg0?=
 =?utf-8?B?V1R5KzlYaksrdC9sWVVZUmhEMDY1Ty9wMDNoclRNVjNsWEJtTXlmdzBab3pp?=
 =?utf-8?B?MDRPMGVZczdDbzV0VTJSMWFJMjlqanJxMWFMSmM3c0Z6UFQ0NlpZWFY1NVZ6?=
 =?utf-8?Q?lsUGwZ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2489.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2xIaWNFbHp1c0VFRlN5bDlkOU1peG5wMjd0U2tLNUs2VmV5VHIya3ZOVW5E?=
 =?utf-8?B?eHhudmFTQlJjM1VJREV4UURqeHBDM04wWERjSDFCR1lEZE9CN3ZFdllxeGE0?=
 =?utf-8?B?SXBQSEFYdlhoN1dTRzFTdzVmN1Z6Vm1pMEVwSmcwRzZZV1lTT0hTZmJGakIw?=
 =?utf-8?B?WDRpVW5DclZlaUhTZlZhYTBZNDdFTC9BM3IvblVpcC9Zb3BIeUh2Y29XV2My?=
 =?utf-8?B?YXRvRXRmRGF3YnJXK29tT0t6UU0yT3ZSMUdkbW9BMGpVbktGZDRsSitQcjZU?=
 =?utf-8?B?U0twa3VtdTlpZlM5NHVhYnJmRWN4VDhEUUkrcG9jLzRQN0J4dmdIeExtVXo0?=
 =?utf-8?B?RjhNcFlKdzNHRmRwNkFROXAzUXpBTTZJZ2FOVFNnakNEWStmVHJlZjJEMUQ0?=
 =?utf-8?B?bzhnSkl1Q1Z5TWd1NkR0b2g4SktkM0VBZlhIcktiNE5yTWFKek9laFRWOGZD?=
 =?utf-8?B?YjhsYittcEx4c2NEb1JtTysrT1F5T2FWSmpjMWNLcWpyQmRmeE9Wa1RqVnl5?=
 =?utf-8?B?T1dlZFFaVEZLRTZFb0dxVWtXU1ZtNEE1aHZzYXlQR2N0UmtIY3RJZ2UxYTFC?=
 =?utf-8?B?N09aOWtGVUtyOGIvRkcvK01SSHloZUlQMmozM0pkSWczY1FDbDdwc283UlVj?=
 =?utf-8?B?VU0zTmkxeVN6YWwwVmcwR2JvTUdpR1lhdjdnUXFRY2xMSTdMSGdpdUkrREdn?=
 =?utf-8?B?YWV4eDEvWkxDdzBpdEovRlg2bFZBaCtCdlg2SFFiUTVUNUFydEtpZzc3K2xu?=
 =?utf-8?B?MFZlaFFPSWg1MEZKR0NFNzFBTVJpUlZjdG8vdnZqZDUwbGNoeVQwd1IvUDNU?=
 =?utf-8?B?UHZ6MU1WcmgrWDVHVzBmYkRaYVdpM2R4UGxDY1NTTTlwdWZqdkZydXNSTVBn?=
 =?utf-8?B?ckVMNnFWK2JQRWxFd1lZdFBVNDkwMXEwcFhJMTdkOUR4eE1hQWZzSEhtTVZ4?=
 =?utf-8?B?U0tkRFlNMy9QeFAvYjdlWlU0bWFIRW92RDVxWUJFekpqSlNpSnpXK2lFUFpU?=
 =?utf-8?B?NTUycmQ1dE1rMXBxelh4cTREMVFaSVM2T0ZSSEc0RGFnUFZwdElqYlQrb01p?=
 =?utf-8?B?QjFjaGJIaFgrUTJiVXFSSzFGSGpHL05DSy9MY2pjNzZWZG5qM25aV3hsUnIx?=
 =?utf-8?B?ekRvUzB4V0dKa2YyaDI5OUlnYWhNTThPQXNpUjhJWGljbWJaZE9sWm1WR2ds?=
 =?utf-8?B?cGE1aEkzQ1g0S0U0QjArYWN3R2x1VmJhb1JzVzFlakEyM1JaNStTOTNWSVho?=
 =?utf-8?B?SXlndGJ5djRYTU4wS29JRm5VNFN4M2RLcnFPdjRvcVBEMmxLS3BYOXh5RWJB?=
 =?utf-8?B?SDhjMmdPVmJtMTVVQTF3c3R5bU9leldUTzl0QlBCbnBaOERpTEVSMkFHTlpl?=
 =?utf-8?B?ZFZWeDYrSGNBVjdoRW1mY3lpeXNRa01qdEFLWEFkbEFhRmVxSXZnMVVlenRh?=
 =?utf-8?B?Tk1iUjg4WmFBQlpra21XaVBjZ29XYUNDemNVblB5RVd1aW1wWGowT2VWRHQz?=
 =?utf-8?B?dmY5NEpnNEhtemtBM1dLdlRScm1nekF6a1lMVHo0Wk1LQnN1VUxybnp2RENt?=
 =?utf-8?B?aTNlUXpwRVQ3cUc0dzl6VDN3RFN3bkJQd0l5S1hDQlVJMFJsTWp1ekJESXNL?=
 =?utf-8?B?UHhibHIzdjZ2amMrVVVWSEM2cERQT05GckZtd3BrS245NEN2OUxvbDRHWW9w?=
 =?utf-8?B?eVJ5SmRhR05sRUtQYmZ3MDFYbzkzRllHalliVnJGbGxqMTA2d0VlaWlhbTFQ?=
 =?utf-8?B?SnhpZEhNQjg4ejZJZVF2YktnUG1MaDE4SjBGdG1xMkdraVE1QXZlWTBXR0dI?=
 =?utf-8?B?ZTd6QXFPN0IxSGVUVjZIQ3BGenArMlo5VFdEUm9FZThZMlJ0U0JNbS9IREY4?=
 =?utf-8?B?LzFWSVJabjlmVE5OT1ljVTV3cFd4MXUyU3JZVzdzL0graWZSQ0FsUGp4blB5?=
 =?utf-8?B?K1VGTmJva2szZlY4d0l5a0RZSkhMTkZnYXZhMjNKMms4MmxzaXQ1TUh6MjY5?=
 =?utf-8?B?d3BIQXRHc3FRNk1zTmlKYnVNQ0NCTVNkejlndDF5M0xJc09FTjRrYTB2S2dB?=
 =?utf-8?B?cW1oOEY5VWUxcSt0RlJuaU9RNXEyQkp4M3ZKMFEyNkdHeWdvdk4xL0FpOU45?=
 =?utf-8?Q?FYfvzVmQghWUlcYOeFitl1D4m?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D22D241FECCA54EB0F50092B72C65E1@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9016e685-5153-4310-8ed7-08de01828f25
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2025 07:08:59.1822 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6McjFWcJglYyB2tQyLGX81QxVuFy+ev3FRi5hVqkIEEcu2LwIrw+voaAu0WDbmCxmSCFXSo1ofHvV9rGZBfubw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4P195MB3122
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

VGhhbmtzIGZvciB0aGUgZml4ZXMhCgpSZXZpZXdlZC1ieTogTWFydGluIFNjaHdhbiA8bS5zY2h3
YW5AcGh5dGVjLmRlPgoKT24gVGh1LCAyMDI1LTEwLTAyIGF0IDAxOjIyICswMjAwLCBBbmRyZWFz
IFByZXR6c2NoIHdyb3RlOgo+IElmIHRoZXJlIGlzIG5vIG1vcmUgYWN0aXZlIHNsb3QgZm91bmQg
aW4gZmluZF9hY3RpdmVfc2xvdCgpLCBsaWtlCj4gd2hlbgo+IGFsbCBzbG90cyBpbiBCT09UX09S
REVSIGhhdmUgYSBjb3VudCBvZiAwLCB0aGUgY291bnRlcnMgYXJlIHJlc2V0IHRvCj4gdGhlaXIK
PiBkZWZhdWx0IHZhbHVlIENPTkZJR19CT09UTUVUSF9SQVVDX0RFRkFVTFRfVFJJRVMuIFRoZSBC
T09UX09SREVSIGlzCj4gX25vdF8KPiBjaGFuZ2VkLCB3aGljaCBpcyBsb2dpY2FsbHkgY29ycmVj
dCAoZXNwZWNpYWxseSBmb3IgdGhlIGNhc2Ugd2hlbgo+IHRoZXJlIGlzCj4gb25seSBvbmUgKGFj
dGl2ZSkgc2xvdCBzZXQsIGUuZy4gQk9PVF9PUkRFUiBvbmx5IGNvbnRhaW5zICdCJywKPiBwcm9i
YWJseSBkdWUKPiB0byBSQVVDIG9wdGlvbiBwcmV2ZW50LWxhdGUtZmFsbGJhY2sgYmVpbmcgc2V0
KS4gUmVzZXR0aW5nIHRoZQo+IGNvdW50ZXJzIG9mCj4gaW5hY3RpdmUgc2xvdHMgYWxzbyBkb2Vz
IG5vdCBoYXJtIGhlcmUsIGFuZCBpcyBmaW5lIGFzIGEgZ2VuZXJpYwo+IHNvbHV0aW9uLgo+IAo+
IEJ1dCB0aGUgbG9nX2luZm8gc3RhdGVtZW50IGluIHRoaXMgc2NlbmFyaW8KPiDCoCBJTkZPOiBS
ZXNldHRpbmcgYm9vdCBvcmRlciBhbmQgYWxsIHNsb3QgdHJpZXMKPiBpcyBpbmNvcnJlY3QuIENo
YW5nZSB0aGlzIHRvCj4gwqAgSU5GTzogUmVzZXR0aW5nIGFsbCBzbG90IHRyaWVzIHRvIDMKPiB3
aXRoIHRoZSAzIGJlaW5nIGluc2VydGVkIGJ5IENPTkZJR19CT09UTUVUSF9SQVVDX0RFRkFVTFRf
VFJJRVMuCj4gCj4gU2lnbmVkLW9mZi1ieTogQW5kcmVhcyBQcmV0enNjaCA8YXByQGNuLWVuZy5k
ZT4KPiAtLS0KPiDCoGJvb3QvYm9vdG1ldGhfcmF1Yy5jIHwgMyArKy0KPiDCoDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEvYm9v
dC9ib290bWV0aF9yYXVjLmMgYi9ib290L2Jvb3RtZXRoX3JhdWMuYwo+IGluZGV4IDgxYTczMDQ2
ZTgzLi5mNWQ1YTk3MWU4NyAxMDA2NDQKPiAtLS0gYS9ib290L2Jvb3RtZXRoX3JhdWMuYwo+ICsr
KyBiL2Jvb3QvYm9vdG1ldGhfcmF1Yy5jCj4gQEAgLTE4LDYgKzE4LDcgQEAKPiDCoCNpbmNsdWRl
IDxtYWxsb2MuaD4KPiDCoCNpbmNsdWRlIDxtYXBtZW0uaD4KPiDCoCNpbmNsdWRlIDxzdHJpbmcu
aD4KPiArI2luY2x1ZGUgPGxpbnV4L3N0cmluZ2lmeS5oPgo+IMKgI2luY2x1ZGUgPGFzbS9jYWNo
ZS5oPgo+IMKgCj4gwqAvKiBMZW5ndGggb2YgZW52IHZhciAiQk9PVF8qX0xFRlQiICovCj4gQEAg
LTMwNCw3ICszMDUsNyBAQCBzdGF0aWMgaW50IGZpbmRfYWN0aXZlX3Nsb3QoY2hhciAqKnNsb3Rf
bmFtZSwKPiB1bG9uZyAqc2xvdF90cmllcykKPiDCoAlpZiAoIXNsb3RfZm91bmQpIHsKPiDCoAkJ
aWYKPiAoSVNfRU5BQkxFRChDT05GSUdfQk9PVE1FVEhfUkFVQ19SRVNFVF9BTExfWkVST19UUklF
UykpIHsKPiDCoAkJCWxvZ193YXJuaW5nKCJXQVJOSU5HOiBObyB2YWxpZCBzbG90Cj4gZm91bmRc
biIpOwo+IC0JCQlsb2dfaW5mbygiSU5GTzogUmVzZXR0aW5nIGJvb3Qgb3JkZXIgYW5kIGFsbAo+
IHNsb3QgdHJpZXNcbiIpOwo+ICsJCQlsb2dfaW5mbygiSU5GTzogUmVzZXR0aW5nIGFsbCBzbG90
IHRyaWVzIHRvCj4gIiBfX3N0cmluZ2lmeShDT05GSUdfQk9PVE1FVEhfUkFVQ19ERUZBVUxUX1RS
SUVTKSAiXG4iKTsKPiDCoAkJCWJvb3Rfb3JkZXJfbGlzdCA9Cj4gc3RyX3RvX2xpc3QoQ09ORklH
X0JPT1RNRVRIX1JBVUNfQk9PVF9PUkRFUik7Cj4gwqAJCQlmb3IgKGkgPSAwOyBib290X29yZGVy
X2xpc3RbaV07IGkrKykgewo+IMKgCQkJCXNwcmludGYoYm9vdF9sZWZ0LCAiQk9PVF8lc19MRUZU
IiwKPiBib290X29yZGVyX2xpc3RbaV0pOwo=
