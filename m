Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC954C369A8
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 12:42:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B7FB837C7;
	Wed,  9 Apr 2025 14:41:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0261D8353A; Wed,  9 Apr 2025 09:51:24 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on20701.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9E8582006
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 09:51:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IxpAibApj4yvcG0vKzN/RI/pl2ULHbvCw2MCLibVeKUIoO3rNlxiTB8Twv9nHloJeiUkPe72jZ5t8TqhCXaSSi+8bceLqLKlHOR0kPrw0/cSdwjBlWaCw+A6TtxeCT1sF9ty8KHbECMTO93SL4J6V0WorCu6en9OfU8SRC2Oz6j4fMrk0zYR1hym5cs0SgoZAZsB3WwIYm1ett469mF3es7Y0QhUW6vrOryK0gjHZ3m6KlJsBqt86Dv/+FChZNKc3r2iRb3lIrk+IU4KEkH7P7vlF2DSdpuu+ZyuwrdCCSeK+gi1kmqI8ZLUtkslF9vwsmtbXqvdpybnAA6Mquw8HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TF2nqPW83iy4GhaIctYciLD3s2WvYfoajoP7GPm3Cbc=;
 b=WIu1gW2TugTehWgndxp7DLc7HszpFO8N6pLzd9tO9seJfeoWT01IkPArZQ9CJqR+4Mc1X24BGVF2OfPHWxSeEIRE2SaWlKZ5RyQmtwxLAGUiGtTPm9R0z3hjFRBQA9s9thbtTW+kVhfIIUX5whBFgCgPI0qVvNxH2M0tz9iO2A4Qe686eTl+o6fSE1qHre0cZio+p50ImRWBUR0Gu+nZQQd5ZTalgkLJChA2Ufdme7Zlzeb8dHpTTg9ok/ReZBhzMb9skfZTJcZL7Iyi7NiJ/Sok2+pBPDh+r/td3NYMOl9k59WxnURcWygaKnXRpp841KHfYoMwwr6Bv7nxDfYMRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1243.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.49; Wed, 9 Apr
 2025 07:51:12 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.8583.047; Wed, 9 Apr 2025
 07:51:12 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
CC: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, E Shattow
 <e@freeshell.de>, Sumit Garg <sumit.garg@kernel.org>, H Bell
 <dmoo_dv@protonmail.com>, Matthias Brugger <mbrugger@suse.com>, Simon Glass
 <sjg@chromium.org>, Andreas Schwab <schwab@suse.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: RE: [PATCH v3 4/8] board: starfive: spl: support DeepComputing
 FML13V01
Thread-Topic: [PATCH v3 4/8] board: starfive: spl: support DeepComputing
 FML13V01
Thread-Index: AQHbqR+sn0dyhNO7jkqmQnRY0vu5TbOa9OAQ
Date: Wed, 9 Apr 2025 07:51:12 +0000
Message-ID: <ZQ2PR01MB1307AECF8F289BA9A94445A1E6B42@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20250409071836.26629-1-heinrich.schuchardt@canonical.com>
 <20250409071836.26629-5-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250409071836.26629-5-heinrich.schuchardt@canonical.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1243:EE_
x-ms-office365-filtering-correlation-id: 15bcf8aa-56c3-4dd0-da6d-08dd773b4c1c
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|41320700013|7416014|1800799024|38070700018; 
x-microsoft-antispam-message-info: Vq0ki3Uuki0818rvT/Nz29PYkqa02kS3l17Wt/1gKZvtyWoGXBgyA6wSlURKwVhRsEMDW9sPoKrwvCtCSUbcQ+iztmvpse9BiSoOoyQLBqFKO/98mfe1u68qkab039huUZaDQc1mkPdbcNJHiNFymOvXsCk4y4SEh+VhwaXrv9YU0rpGbEDMQ8vZjWSAPUvXX7nNv8lPwgovtT4v/25YZrvahhI394pla4ec+/6wXeWv5HdRVyS19flj+l6b8J3pmiyNseh6u+e45jpkWVuqG2g+D3DNBRia7f0pDC81weBpuzqyotcwWTGZo+BTeLHSEWzYxfWdPlhJxU01v27Z7egGlyscp86DV7tjwS3J4jiKTdQUjHlgGIX9/2qqvHoezmbLVo1Az6EFBVPn2Q+QDUl6A+6R8QzPnGL/COtis7m/uQAGSKav4PcpleFEyflC86X0FQGQAXNm4aCQHZaYsEpQgNYvi7aqj08saIG73wJRK4lixw+lEZy7zvLIEpv1OGt+p/bG67VpRRmaCgTAnxwqZz3ODQkkL+lVEwsEL7f9oW+jR7MsHiWr2ylmuMbyUeF+U5m8BV5hRaW0vxqu9s9f+W/HOqVoKbBwh21JsG0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(41320700013)(7416014)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PMzy9xG23/62UjamQHZ56RpZfYYBE4+6Q53mQgfYK57NsInlDaV6ue6+Gd63?=
 =?us-ascii?Q?SC90k3sk7mdbf1AVvy4oXAxTA6nMXvrT0WRSi1jS3vQadWoK98hL1n6h27WO?=
 =?us-ascii?Q?BDQt5kUqCGk99SBOaXhn3CVdwziPwx1f4o+mUhOrgRUSsigC4aeWyQ3t4rrL?=
 =?us-ascii?Q?zp2S55CXcmFGlipRXBv8mHshdu8swuV5Ju6Jdkuys6cehboESb+aQAL6wlqA?=
 =?us-ascii?Q?UkrxBvDZr8sKo3DQ3fm9YELer93Pzez9m9nBhaT34dpTFb32ujbxt3VhL+Xe?=
 =?us-ascii?Q?9C9FtgUICSGPl7PRVfnx+EVgKVGgwb9gnv60k9AlWCVobsAtYy3kq7Bo+Ho3?=
 =?us-ascii?Q?tUcCUXVzu32Ugr04OIxbtNdLf2lJmCu31xFlR/W3X6UBdH86dFnlSqFN4Bo8?=
 =?us-ascii?Q?mqj4GqDDM6bqgMhKgv7NzXb88cDW6iDD1fc7HZGsYF/AQMFjPx00huJNKPBP?=
 =?us-ascii?Q?cJnQQgOH5nDy94AHjpgKwqHWi4Qnfsp/iHYmGtQ1poaC7NkghAsEBOrh02gp?=
 =?us-ascii?Q?f8llJSGxcKYVErUS6pFuLrgbm0ALf60RlkZuEh4VOIvEXOfeJGutZf5ZLIrV?=
 =?us-ascii?Q?oo+vpANeA9RKMjTUQ9uN+AhWgdOE/xrH039GDrKircBptngR9PeBzFSUBQCE?=
 =?us-ascii?Q?/GxDuTq+TY2DGA69g4mtM/ery8L/NDIkB6AKe6wLY9upNWykop9fbBAkJhSB?=
 =?us-ascii?Q?/XjJkFhBCG8SxjS7IffrW15OO/01urytyUdDky3QuksB/Lz7uckrOQ7oFuYO?=
 =?us-ascii?Q?OqXEVlHHGC1hB2MFTFsNJzvT+YEFHggKIHULKP4ObA8awKLbBqUWJTORoOTK?=
 =?us-ascii?Q?fuAMkMpx1ikVj9gvj9SPC5wl2FZ2Rg3L+c+AL8HPBO7LFaiA7gRET9R5FfpG?=
 =?us-ascii?Q?Owl6a7reczbdQFCKFjUhJneIeIxAO8Cm8xaphEs9209iOalJklWmeauRnuO4?=
 =?us-ascii?Q?UYzV+Ai/NsULopwWphWrCdqFEP79kEkxPAVww5Wgi+VgOuef8FXuumVYLT9O?=
 =?us-ascii?Q?GSfnwG76FsOBlovumRP+E9RCM7zDDIO6HOt3hpga5IDuGv/uVhcjbAnmZhG3?=
 =?us-ascii?Q?p0g2k1t9KJQvJqo7lk/rk2X5+tMWl8wX/E4m7ChjUOOakG5vU0q5wNS/3CcS?=
 =?us-ascii?Q?lXEVWq9FIdRVkb80yYVBgRihaMDStCIJyvwVahzNwBtp5nsxsHS2vwHFMQ8+?=
 =?us-ascii?Q?7L3A0sGTyGKwAgD2h58f1IIO4EmNi5xGl/8W9KlNWjJyQlzTz8pQ4h6bOFGj?=
 =?us-ascii?Q?0RLZaTAVa6QLM86QkP+MUVymyn99cTwDL+NQKeWfYE4iPenrDk3bujcwL33O?=
 =?us-ascii?Q?EZutnVDU/Yc3awIwN+phThLWNPGpi+Kww1Z4otCo9UL2+oSrrEWQEtD8nQZL?=
 =?us-ascii?Q?cAdk4rnsDV2IljoxmEG6zlYQBjnFSwC9HE5m39QcelNCVxLk5Cy/NEKXRSG5?=
 =?us-ascii?Q?colq0+I2OhiCYVAOs0/9QixFKyfTpaUYAo76mEXnXbxWNw54mFJ3ynb8Saos?=
 =?us-ascii?Q?QS0p8VtOBEX8i02l7ogcnPgGgrwdlF++uJOog0BL9TuPiaOyXr3C3yxfNfZJ?=
 =?us-ascii?Q?CZYebIVQiJ6znVqoD26LpQD4Iw184PrBG3tJ5VceVI8wyDZ284hKMcVf52NN?=
 =?us-ascii?Q?EA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 15bcf8aa-56c3-4dd0-da6d-08dd773b4c1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2025 07:51:12.0147 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vp5b70cKXgs8cW5T4bysK+jQEpYu4G0szvrnfsnHS5y1iNLNOIUUhfBJecfFuNgXr1FoOyg5UJAdyif6N7T3jJLdYSTjwhUXw6wi5Ya9k6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1243
X-Mailman-Approved-At: Wed, 09 Apr 2025 14:41:40 +0200
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

> On 09.04.25 15:19, Heinrich Schuchardt wrote:
>=20
> On the DeepComputing Framework motherboard (FML13V01) choose the
> matching FIT configuration.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v3:
> 	no change
> v2:
> 	rebased
> ---
>  board/starfive/visionfive2/spl.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive=
2/spl.c
> index 3e4d3e21988..9a3081ef06f 100644
> --- a/board/starfive/visionfive2/spl.c
> +++ b/board/starfive/visionfive2/spl.c
> @@ -125,7 +125,10 @@ int board_fit_config_name_match(const char
> *name)
>  	if (strncmp(name, "starfive/", 9))
>  		return -EINVAL;
>  	name +=3D 9;
> -	if (!strncmp(product_id, "VF7110", 6)) {
> +	if (!strncmp(product_id, "FML13V01", 8) &&
> +	    !strcmp(name, "jh7110-deepcomputing-fml13v01")) {
> +		return 0;
> +	} else if (!strncmp(product_id, "VF7110", 6)) {
>  		version =3D get_pcb_revision_from_eeprom();
>  		if ((version =3D=3D 'b' || version =3D=3D 'B') &&
>  		    !strcmp(name, "jh7110-starfive-visionfive-2-v1.3b"))

Reviewed-by: Hal Feng <hal.feng@starfivetech.com>

Best regards,
Hal
