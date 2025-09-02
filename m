Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30DACA1007
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 04:43:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF4EC83965;
	Tue,  2 Sep 2025 06:43:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="RG+2pBFm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86DD083A1A; Tue,  2 Sep 2025 05:00:24 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::615])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64C3383443
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 05:00:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tR/GiYONEy3aNGRc3P7VnHjY4c6i6wB/OVHU5rUZK8BBA1mJuqzR8SOBmNc/q+2jOW6EL/90QjEKWEsZwheDLJye62rYvaMKbfzsQ4CGXQty5OZ3mNaAtVgV80c8Bu1JCk5T10wQoqmckuCpbj8IKSUAlu+D7nzyJ6G1Ryp7bbJWhcysGjT2oRmQ/MVroS/CHOAoYEEFGkICVoLum55OU+Jg+nnGEmH12pTu6eQuD0xrFIR+F6OzWrMTJUSrUUVIYsZvDD4lgucKmlx4yhbgPgfeE/zvZJudygc3CcXoOIrTzL/vzyyGVeKRwManhH76J6ZSLII2X8bHVwMf7QJ6JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RvQVkZF8Tfpzc1X86LZVYwh+A84pn9vBLGSuBqSB6GU=;
 b=MOszlC7qQuMgzrTmikjjpZ0TF9gt6XrvkaOxOYGlAB52lVt+rrT7gM6gj8hzK5t0HLJHs33yst/Xv2k6v7M1wStggvaCVpvrmTklAGyncohtaTqWWERDgqN66KYgXW2iuzBc1D8Vhy44GbMSYLl0jRlwe2rpxF8EhKHKIq9P+WN53QHNpQIMSURGu0h7MYbV8OQzkReWzKQaLsEKr+D7OEEGuC+MqSiOJ1blqAXDJBad0D0u9mFP0b+rHeCo6CbgD1uDddqRpxJV6whK/oKw6WcAijtrq/jO9bVt79h7j773FWu1z1MuXOLIltrLD7YZB9IBhtdTTfYnyRO5zzQoHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvQVkZF8Tfpzc1X86LZVYwh+A84pn9vBLGSuBqSB6GU=;
 b=RG+2pBFmEn9eApQGw9GS6TPPYrSrAK2IwDsfLwI3GXwMr1hPOU+uvow4xZhvvGzuWJJVqueKUyQ+hZBATvJZt8oTrSM/UnJoWf8/usb66m13/IzPdOHXmBeQWWoeejguykPWFgYM4nhUlg/8ccOzmajAvfqoj/1O2ctach+JyZtxlG/aA2BvjNaG9NB4V178PdqI2XwHdp6BgD4quqZLrCzht8iwtZS6iFXkZWIqzn1geKFYzkvIPjgPJz4+3P4TU/+gtvc+8itPvLJGgSyxXO4F2thNTfr6PwypNFj050jAJhCvx+P3z0OOxzl7srAm01RImjiGvTstANIiVzG6JQ==
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by DS7PR03MB8035.namprd03.prod.outlook.com (2603:10b6:8:251::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 03:00:19 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4%6]) with mapi id 15.20.9094.015; Tue, 2 Sep 2025
 03:00:19 +0000
From: "Ng, Boon Khai" <boon.khai.ng@altera.com>
To: Nikunj Kela <nikunj.kela@sima.ai>, "joe.hershberger@ni.com"
 <joe.hershberger@ni.com>, "rfried.dev@gmail.com" <rfried.dev@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH v3] net: xgmac: Augment mdio read/write with cl-45 format
 support
Thread-Topic: [PATCH v3] net: xgmac: Augment mdio read/write with cl-45 format
 support
Thread-Index: AQHcGJsqNCZCo+aUvEi012yWWlvwT7R/Odug
Date: Tue, 2 Sep 2025 03:00:19 +0000
Message-ID: <SA3PR03MB7187A45D6B0588067C348FDAB406A@SA3PR03MB7187.namprd03.prod.outlook.com>
References: <20250829041232.1160655-1-nikunj.kela@sima.ai>
In-Reply-To: <20250829041232.1160655-1-nikunj.kela@sima.ai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR03MB7187:EE_|DS7PR03MB8035:EE_
x-ms-office365-filtering-correlation-id: 0667e461-0fef-41ca-6047-08dde9ccd9fb
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?wdMrPjBl4qd9Rk2EcNKPZxqetaPy5Ep7gKZ9nytH4/2CpK7XWn6B2kkP8yFX?=
 =?us-ascii?Q?Fq+S3OAlgqfyV6YT749l/jB9RGYvODNCSbSKZAvubPaBmRXo0dpZzGeFwcsP?=
 =?us-ascii?Q?nEhR0lPXIZlXguXjlsZN+Ag1KXlT4Z/0B8PNmQvyAutFjNVaNvLQ8ZnEKsi5?=
 =?us-ascii?Q?aszSF/UN88M24swU/9Ti9Il5cFYC949IFJegauTAivrtUDSHCv5W4xFEvcyb?=
 =?us-ascii?Q?1b5p4jTF0wLobziN/9ySuoNxJcZM55Gjn8DnqERyKs6/UUgrW8u/OsdpaFql?=
 =?us-ascii?Q?EpJvLh/j7V3uDPUuEpCj+L41RJDIpb3Z6CpWSE+pAl5a0FFbOM80hXv5WNBR?=
 =?us-ascii?Q?1VFAN1kBaMF9Mmv7gbke5Kt2JPu3WEZ7rGTIED4zOpfl1ivqSMS+LMjUiOwG?=
 =?us-ascii?Q?wbLZMOh6WHYr/14Cg5sYQlYdkDJ2vk1OGu/QRIIZU172rN/l62Hcyl2XlUdC?=
 =?us-ascii?Q?/+BWWnyNCHarAo5c0QLO74jOPY4SD1+7UIR0FNDhpabg/fqA66n71gf3211z?=
 =?us-ascii?Q?Fo+epUdB1CK441S/+53HUaIznsEG0wvxNnvfoUnmGvz4t/IFT5vnHqtXht3P?=
 =?us-ascii?Q?oyW7fCSOxPjxLD5Ia0Y4kpU5MC9qUwdn0rh+lt3injfExGQjxTkq//BrbV3l?=
 =?us-ascii?Q?zksmIKZOsL6OndjZCNbSbT5ckC9W8DcHoBCjqXX06EVMCgmB8K4CRp6jIXlB?=
 =?us-ascii?Q?eBZ78PflJzrpZ85HiAt1z8woai7Hb7LF7hfuGj7bqznKUXzjs0zqZG8x9DAX?=
 =?us-ascii?Q?CIXYhxT+ilOEw1195VF4TTl/FKI1a62lDd2W5Kp2L7hdTt3rnf/0d6EvSJH3?=
 =?us-ascii?Q?oriwg46xostCmyl2ewTsyHP2VbpLyIZJRs74VioSWppXXYdrsTYMJ4zXuTMY?=
 =?us-ascii?Q?xDQi53IuqbpdSpNwgl2tlbTyprFuHzVCbrmkH18hI1NSyxifhyhkmr3ihz5Y?=
 =?us-ascii?Q?QOd06tPwSHwd+O3jyk5FGEAh/kFf6D4LlfjmGsG//ty+UQ+wVkgPzEts1Lzc?=
 =?us-ascii?Q?weio0fQD4IGl7+HY7GVXsQD5y13BZYLaPb9Xmwzlo2k3LplW8omPJ6VuRjeB?=
 =?us-ascii?Q?w/VvzrIWOn1PazTk0H9dP9u5PccUM4FWjhYjdmHwifr9mpRPrhxkv4k+g9XJ?=
 =?us-ascii?Q?BgD29N5p0dKqQQs2HZ6EPzz1qo5orOLNdlpBX3ll7Xqef5nGRgR/XGfoLXsR?=
 =?us-ascii?Q?slnieea3TbL0RThyr41CJu4SV7K3pExSQym6TH8vD/s5v77vid4LMNF4XiP5?=
 =?us-ascii?Q?+llTEs5HwkQIEuKoinJJXrHnrjCeCNgWNSi6bSKCKnmwNKQbsuJ2fGAXBxp8?=
 =?us-ascii?Q?WrrJVw0v/UIqgyElF3edtD77vYI2VX9z+kYR7X2HDAVjTafLyJFF8KWahFHC?=
 =?us-ascii?Q?gu9x2ajXVPP96CqUmXhY/ojwPyPQBunaNaL/SppdAr9aZMZuw3yJNZiChhwW?=
 =?us-ascii?Q?mnpDGsp4h75rewD1wwQeSkKoTU3u4WAOXopAson0lDYJFWc7uGeoZg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dz5bwLXHQjLtyG0jc79j/0lf9nNMlvdFWezTDrd8SNxYpQbeuDyyQtFwtVo9?=
 =?us-ascii?Q?OKNR8Av+1R8BH1FQvLezV6QU9ri0HldIAeWym7qxADlDUGRlSBT2eOi22115?=
 =?us-ascii?Q?ZyLN/UFARDye0/r6lUdfghwphEmI7pPBSCaDZhVYl853FIE0Mz6MnG1airjS?=
 =?us-ascii?Q?liwsejkKDBP5fUDUBumBydfVkSRgboFoEVlHswCAdfxFNy+Nse6VM92iUw9s?=
 =?us-ascii?Q?Cc8aahP3OC738s94xrxgPF9eG3i5Ue7FyrydEVMGRy2W6O2ySK5+i6EHrViZ?=
 =?us-ascii?Q?DaMiWkjODZQLvEzBGoIMliN/qSH7k2aZheTJPtm6eJhAp6PuCe6orhW0qTDa?=
 =?us-ascii?Q?DurcvtdY26zPyhTt1dSj0HTjSTByym3n6ehHaTP6+ay0rxVpAZ9dGtH19tgk?=
 =?us-ascii?Q?0qYxhvfLFNgoi/XXD6q+RNjxCcrVsefKgYQC5AJigtGKVXNMeSpXrxlRYK2t?=
 =?us-ascii?Q?ExGs0cY7jXnDYPCTMRSMmD+Ne02odexq2VsU7EzrdktwYmtJ8LFeKYcQ0tea?=
 =?us-ascii?Q?r5fz3q0Sn8ZQkyUbTpIbznhOLzHF1uO++SV7k54oQCaIjAUF84XeU2ndutpG?=
 =?us-ascii?Q?Z1dBKklpr/oAS1UDdNJRJjaSsuQjSmWeIzk9oc7z6WKeSLq5EFWHVdtmJXIY?=
 =?us-ascii?Q?REmMAMhZXIMi5yeQcZrW08bScxtO11HFKVt5xnjw6QNFagb0oZilti1TnGNw?=
 =?us-ascii?Q?s5fPDiHxTYwanDXPf9atlLskMFiq9123PQhy1a3I+QimMTmsag3dxAGHWXGo?=
 =?us-ascii?Q?m04OGAU11lsHTWE3vJakY0Bu1DImGcW0hZuYcVxYU2Jo2+xxMDgEQk178AwZ?=
 =?us-ascii?Q?sl8bmRNHhI+2++b5aAfqp9aK0GfgMkYj6jdHEIf6/LtVWqSvIok7i7tkwkuT?=
 =?us-ascii?Q?fTtcVckFJhPqWpBhBN3TXNsvFm35C0xvcaRPHe6CPI4bsWNzRCl3oo2Bv4g8?=
 =?us-ascii?Q?yGiXllyHomVtBJgNivHsh2x89O2IkLKxx6gj2IPYO3M6/za0bxSQhyAiwZq4?=
 =?us-ascii?Q?4QY80Aw064s5A7wFdWKJsWntll/dF3caFyELBIWMm+UduWOtU59UM3HDyiWe?=
 =?us-ascii?Q?P8VPk3Xol7KnS/DPj40LxShC9C70pguGOplH5XdCmwZ75UeIUusEycEwMAs1?=
 =?us-ascii?Q?BC11lMp+V0Q2VYcsEEg7/Tc06dKgoDXinyDYK5FcjRgRNaNW+ZKRQ+BXAZvF?=
 =?us-ascii?Q?f59e/LNRlr2+CDGXqIkg53ynTk0WG5M+MyCBbYdnu0JQ6H44Sv3oVhfcenPP?=
 =?us-ascii?Q?FD86sfIHm8HoMi9QxHvKUGdGyErBYl3mdRHEeyXr9O6JuLYjGvgSqCtokXbj?=
 =?us-ascii?Q?R6OWkEVBHG4hXmMg/UUT7Tly5xl9C1VgFVBE/16VbseWWKt3du1ucQRwYwc8?=
 =?us-ascii?Q?6Zqoyydy+RrbtNbxYDUN4ZvPTrt1YjidlIyh4eGPcS1SnZEVNJN8jJwUSYpO?=
 =?us-ascii?Q?UQ4BXAGXhTsVVpnZrSzqhoTRNFM9ZHm5sM7SxF2rvAls8XSirPIVq0mbuJ9l?=
 =?us-ascii?Q?z0Il6G4e+Nt0CQ9SZWcxqAmlPvH3TyFkYE9HPGy7ls3rOTfwzY1bWBCUmaG3?=
 =?us-ascii?Q?5zxVw9dZNnSNp+XvHo7b/Y+2sQGImxZPsstohudS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0667e461-0fef-41ca-6047-08dde9ccd9fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2025 03:00:19.5841 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Du+9fNS2aLI+1HRzBVqoK+S9jCr4/5peRpUNi12W0MFrBpr6mtH7OPRFGs30RzfjpMcGpX19kHXHBK8mDH0P/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB8035
X-Mailman-Approved-At: Tue, 02 Sep 2025 06:43:37 +0200
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

> Changes in v3:
> 	- replaced tab with space
>=20

Reviewed-by: Boon Khai Ng <boon.khai.ng@altera.com>
Tested-by: Boon Khai Ng <boon.khai.ng@altera.com>

