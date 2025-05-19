Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDA1C3DA6D
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 08:19:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44E0681E72;
	Mon, 19 May 2025 10:19:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=br-automation.com header.i=@br-automation.com header.b="ftUPJx23";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39F6781F66; Mon, 19 May 2025 10:19:07 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::610])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1FE5803DF
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 10:19:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=wolfgang.wallner@br-automation.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2DxiaDBAg3bEzWBPJ9i2sQaNpHmhDG9MKgrJC6tzncd4WCcAzmzm30E8naBcKIqV7Tnkqtzct4YMMojUm02BYUejAapAKliqg0utnHPY0tZaMa5zQ4cgks/ey+XP6fzCtbYD4eF+otInyY/5SIF/EA257eR4Ali1kgEoH8h83t7C59fR4bEZ/mNHKlgcK9NZY6x0Un5soGRqMViKWKKOIgEUxKRI6lJ8uycMf7H0KnsbnYTLRTOpmpVFH6E9J++C8b1ZXF5NLO2BIOwwgM8JQld4+EWLUbb2xzr8LEb0DNKf+fR4kye8zMkbvxMvElSKzpqwlLsyod8FdPnhBhYYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sl4fMXl+nLvTGon1zSmS2fr56G8NNpoDwXQd+PJ8dXQ=;
 b=t6t1KUcbxQeK2G30VRfe+f/FoaT12qY3kbIffwXL51VHQBkBY/OXZvkMgnTfMToUbyoAngJTYW1lDMf+sLZ3bkTDp2huj2FI2w82TEoIezCyW8AubsZ+jM3d6SAPln4wd5b2JFSe44OwglDoozsTt9++xJmb51vUR5QC4PpixwtO3rR5FHH4ulGPx+ufutjP7RS/m6pWT8BUbTbdQuBA/m9u4fuMwHufYHO1pGTVNSb6hItVy7vx18FXHbsTUJ5I/unslpa2MRS3BueR8e6QgakTzeLW2VAyC7fB9eVsooU7F2gnTa3mrSp5gfsQzS1rMkfuvLs0E9w4a50d8e3Jsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=br-automation.com; dmarc=pass action=none
 header.from=br-automation.com; dkim=pass header.d=br-automation.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=br-automation.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sl4fMXl+nLvTGon1zSmS2fr56G8NNpoDwXQd+PJ8dXQ=;
 b=ftUPJx23QGrb7GTMrqRs/1D4NstZbKZJE+d26WozB+742EV3gTGCDvhN6uachyAeuwxKiE+UC+dZIcfuG+xZzjJ7CipuImpRdqsrRNf2X4ueXSjtliokGBhPVpcwHZ2Z8SEisDlvW2Zd61IFS47GVT+h8RKgFCk/9ER0xn/hkWn9fY8nAIAbjgbtgSnP9oUpPuwgd7X+nh1SkGfrDuge2FgUulHyjTXdq+SWAd9Q8vuvyqehumuYJ1Cj9KWWAFusmGD0dktvveX/IOJkWdwUOw/g2pJaml9gZr50A1n/I64ffRsGE4WYKkqa0UlnmIEY8me6ayGNJVX9diMor5ReBw==
Received: from DB9PR06MB8512.eurprd06.prod.outlook.com (2603:10a6:10:36c::17)
 by AM0PR06MB6531.eurprd06.prod.outlook.com (2603:10a6:208:193::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Mon, 19 May
 2025 08:19:03 +0000
Received: from DB9PR06MB8512.eurprd06.prod.outlook.com
 ([fe80::5f8:554f:fee1:6cd5]) by DB9PR06MB8512.eurprd06.prod.outlook.com
 ([fe80::5f8:554f:fee1:6cd5%7]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 08:19:03 +0000
From: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
To: Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Huan 'Kitty' Wang <HuanWang@gehealthcare.com>, "Ying-Chun Liu (PaulLiu)"
 <paul.liu@linaro.org>, Angus Ainslie <angus@akkea.ca>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ian Ray <ian.ray@gehealthcare.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, Jerome
 Forissier <jerome.forissier@linaro.org>, Joe Hershberger
 <joe.hershberger@ni.com>, Le Jin <le.jin@siemens.com>, Martyn Welch
 <martyn.welch@collabora.com>, Niel Fourie <lusus@denx.de>, Ramon Fried
 <rfried.dev@gmail.com>, Rick Chen <rick@andestech.com>, Simon Glass
 <sjg@chromium.org>, Tim Harvey <tharvey@gateworks.com>, Bernhard
 Messerklinger <bernhard.messerklinger@br-automation.com>
Subject: Re: [PATCH v3 21/22] global: Avoid indirect inclusion of <env.h> from
 <net.h>
Thread-Topic: [PATCH v3 21/22] global: Avoid indirect inclusion of <env.h>
 from <net.h>
Thread-Index: AQHbxfMFQNSPTp4bBEuXxOaIbwRk2rPZn42G
Date: Mon, 19 May 2025 08:19:02 +0000
Message-ID: <DB9PR06MB851247972D1D3B9B522ECF9BCB9CA@DB9PR06MB8512.eurprd06.prod.outlook.com>
References: <20250514225002.15361-1-trini@konsulko.com>
 <20250515234154.1859366-1-trini@konsulko.com>
 <20250515234154.1859366-22-trini@konsulko.com>
In-Reply-To: <20250515234154.1859366-22-trini@konsulko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Enabled=True;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_SiteId=372ee9e0-9ce0-4033-a64a-c07073a91ecd;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_SetDate=2025-05-19T08:19:02.600Z;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Name=Internal;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_ContentBits=0;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=br-automation.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR06MB8512:EE_|AM0PR06MB6531:EE_
x-ms-office365-filtering-correlation-id: c23d65e1-4adf-408a-8588-08dd96add096
x-abb-o365-outbound: ABBOUTBOUND1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?G1xwJhPZc4GGBbDR8hQgQ/ZvO5SviKcVGVRdLsrDuiTK99W6BoX4ozO5IQ?=
 =?iso-8859-1?Q?eRXmGZKNNHQOQMmjJpRay+dCSj/BIj+/kDAJfdr/VPH1QBESPxIo6+AQhc?=
 =?iso-8859-1?Q?hAoCWzf5DDEw1HD1xUEBwBwK6hz/eeRabU98TWeR1nbrygbb7w0B7gWoTw?=
 =?iso-8859-1?Q?hQuMY3ky9qBJOPKHWH0vQrmLakouWwrxW6zQXAyUZKNtYrXtgRvwW0EhqB?=
 =?iso-8859-1?Q?dzabxVwm7K4MbI4h5O3JjtjGo3j5KzQH778zeduJ0iRXU2tSVfv6MyM0qP?=
 =?iso-8859-1?Q?v4yLNPOxsAflw0M7CiuyoORe6R9bc52boXZY0M//b412kWV+FUTEinlYUV?=
 =?iso-8859-1?Q?9I/eWmHQqlOeySVKG1m46etvX2tHqJCDaDEOMsDOlxpsAJPPT27+Wo4iRJ?=
 =?iso-8859-1?Q?WYlmr1izV4zYukgmwZRzh9Mpewbe7XUsU4FCPE+JuTPifzgAIrTQYyEJqZ?=
 =?iso-8859-1?Q?R42skDKAq6n0pk1mHnZMkNJbfaeMC7kLANbJiECkCEwl+gG6/d9gYwd4Xw?=
 =?iso-8859-1?Q?Da9jUgJwSLUSI/fdwY7p8qcnZ4dtw/Cmq5pN5Gq5UYkv5M5eRCqQ0eXwbN?=
 =?iso-8859-1?Q?Jwv6YPsDtXJi8oc/KlmZkSN5E+69IuZUzZVB2Pf+tfZ7MmzzsHZplNNwk+?=
 =?iso-8859-1?Q?iBAvrbJs8ilOWkBHKm9UoLHqNNAtfG7L4a2e/EzlqNsssPD+iqmWx4Z4Tt?=
 =?iso-8859-1?Q?BWiNT90Gl3CoSH785HhDIHe5Iql5M+NOdsDIxne/mKw47lRdI9jt5k/HOB?=
 =?iso-8859-1?Q?E8sNX43Vr42YimBCDL23xeBFEBix6rlOqy9ASA3wdTLIIJVMEsG01UN5tU?=
 =?iso-8859-1?Q?eFTULnOAF7fAcKezdAJaggqBv8k0DBFGGcBEtccOLt359xnB7XZdg+Dk3d?=
 =?iso-8859-1?Q?0Cjz3z9O2KZL4a0xe6Tsuw0KZtmnc899BsHJHFdZWg/Vbz1XmRoPwTFvzd?=
 =?iso-8859-1?Q?GkgYljhYiz8EgKX+eZylZ+YK95PGcDN7JuURL5puPWO1S0qS6coAalrBtT?=
 =?iso-8859-1?Q?3+CCSuJX6M6s3Wmf4KY8dY3p1+fqBvEGGrp1pkQ1VAWuzg4rHrW5yRQjcV?=
 =?iso-8859-1?Q?DEqJvWuGuR/Rdkh1T2gkuk32QlmoU5x0FTMCqIsijG5MezBv0zRfyocR7y?=
 =?iso-8859-1?Q?mHtMa7mz6Zi2pnt3RLZhsW111lD+Zehgu2Taz8GJl2/mpvYxMObJ4s78b1?=
 =?iso-8859-1?Q?tuVYuqEHY3ykeEKCI10LO0Z9BO4zF+g+I5Ep+GWQ5v/aZBfgsqLgR/OR4G?=
 =?iso-8859-1?Q?NWmthm3GFGI5vwFkMXq3+Vl6qMue9jS6ZdoAvtYbXSTUppy285pyN4QEtd?=
 =?iso-8859-1?Q?UG1oy61xE+tQQvhYoaNe0w8mpvkAtyNXlDUNt4aJ0ZCEP5zkdnSWPy7ast?=
 =?iso-8859-1?Q?1oM6OSnnrsk/gD72iiYJ2jxtQPGywAhY1AoER26DiH0CLeD9EsfVyTIX3v?=
 =?iso-8859-1?Q?MHYVdVJLP/NyRIkL8vK0EQWgAx0AQY/B1vEeWG85He8EPMmwmliUjUvM+R?=
 =?iso-8859-1?Q?JX+epdxpR43UjoIj2MjXDZHupZMbuSrj2itXVxASSPTw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR06MB8512.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LkpltcDTSp4e7BK+ncIbKe/3wtz5XkTlZR/KWtED/SMACkUTPdTsvgMIjf?=
 =?iso-8859-1?Q?jb5SXd38KXfXPkwxD4N08Mm0ApS7xRhBkHaP3nhyXMFL/jAq2JjzhZIM1F?=
 =?iso-8859-1?Q?IgsZcfgBDY4II5Z+14af6drt5YqFMVqUk5q4fFMjGjy32T77X5uX1CVYDM?=
 =?iso-8859-1?Q?AGd3QBwHMLGM3ns5w1HFY6Rz13de93Yu+mbMNxOWEcetLsOwgEwazPU7cf?=
 =?iso-8859-1?Q?gtWlXouqo5ZqFFT6a5UB8ciXdj0ftA5gQl7yd/kGasArbIs428kDGD3TON?=
 =?iso-8859-1?Q?BgqnqrpOgzNjVE4bL0ptj8lMnhedTiOQYnSCWPk/qzrhJcbNXTHn0AfDD0?=
 =?iso-8859-1?Q?8sGDy/UKZ2GON66kQDsWCgNIwNnhNnuhE1T39n2SqfwBfhXRgEqFvfGgE2?=
 =?iso-8859-1?Q?Hl6X9Q3VByHBJzV4im3Jcm3B8q2SX7L0zrzW7bCHjd4TE5v8RZLmZ9t8Dk?=
 =?iso-8859-1?Q?YnG/LI885ttI4LpB33axHfeHe/eioGzpIDyam5+PzTV1cBBzc8liso+6ZY?=
 =?iso-8859-1?Q?JvWPNw/4DvpeVJN7PDU7cOFfKY5+AGf3hX/TpmWqVGMKwCc74Vmoh6HRju?=
 =?iso-8859-1?Q?aR2S5OjqlWvLbWmkVM0snALESFZPosiB9ID4u0vGAPYBDkmDbWTVw7YSTJ?=
 =?iso-8859-1?Q?VzBvJDef1EEyWhcnYkq74ioYWbKoX7TvaqiYNT8bSA4UQzQzRWCPHWN8L4?=
 =?iso-8859-1?Q?mvg1f4rOeG0hZoC9uLVFWQgpntIFA25bfTGI7CS3hr2MAcTzRo8Uqy7cUf?=
 =?iso-8859-1?Q?npdTBsZMx6uoN8QBSmWVf5c+Vs3gVkXehcOtbwIhQVfNqDmau/eKYNXLs5?=
 =?iso-8859-1?Q?O8gHOW4G5ABCf3GU+/CEqtGPmzKNc7iqeNdWZidMt34l4blQgZqy5Y0mp0?=
 =?iso-8859-1?Q?tgRA53Efbr644aml8vdZQT5eXqwuoLbD8q/0BnLV64WjCZK4ovN6OHPfmd?=
 =?iso-8859-1?Q?QIdmQSJN+lc0a78sDNqKlOI5AkHB+LlWOPl89dFZv5rvLKcZu6FsRsNr3C?=
 =?iso-8859-1?Q?ErfrgB7s25ydZXt/BvsHjn3fOxg4kLIIZohc4kA/lSWM7rvcJGFUJTQR2q?=
 =?iso-8859-1?Q?fY56D588cx/8v84ZrLf/Cl2II03UNkh7fIgWiF9xywSAUsAjezrlsDtmY5?=
 =?iso-8859-1?Q?UZj3nlj7WCr94CYgblB3R1/0YnsGGkO99Rm52clFvb9N4PvWt6OWInYB/W?=
 =?iso-8859-1?Q?2jrjtvn+OnkKAnYJeWxkL80ak/2QeezFvUAuYLhgut5DcsCczE80aiK+cQ?=
 =?iso-8859-1?Q?i2czgAo5lKLFgPEKgSsyWLN2IsJR4KXaTuxLRGrOswQtuvtWSk/sTf/Jxi?=
 =?iso-8859-1?Q?4SKBu3tn7rvOVD0JDe3FKSp2vo3sCvDHsUmpaz7wtbk9c77dQLRpT2G2Kd?=
 =?iso-8859-1?Q?bSIn2UubmXd81q4+VVi/7geiDFUqkMg6epl8LkKsOfeYTOUNynGXpi2h36?=
 =?iso-8859-1?Q?IEqGJFndKbm+ZVPjYWNhs1j1HNEGladtui/Hxx72ccLto8QLIv4RpA9xAh?=
 =?iso-8859-1?Q?WBL6UFjpZWn+j2K2AMhHNhkuoRtHW2SuQcSJXtX0pvqh24ah3Xs6mp+pTa?=
 =?iso-8859-1?Q?bbsXkwr9mRZw9zVWI9krtuLeMTUbLdZ0AsEuJlTwABUlTGwoxtRat9b1kI?=
 =?iso-8859-1?Q?TDvUoczOGPFhCHzc+z9PbV88j1QOsab11ec3ggQ7vzlB5VUodEPH5IWA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: br-automation.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR06MB8512.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c23d65e1-4adf-408a-8588-08dd96add096
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2025 08:19:02.9287 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 372ee9e0-9ce0-4033-a64a-c07073a91ecd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PRmStcjiyuY64yDBt3XxtZsV08vzylA38YobYkL8Byg2jNsSAQR+9EKj3Okd3j8tJitMLn0Wf9wSaZTc2BeNu8p6ve/xsIJ4SBtMmUZRlCAocK+2OdADgwjxQQshoo5v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR06MB6531
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

> From:=A0Tom Rini <trini@konsulko.com>=0A=
> Sent:=A0Friday, May 16, 2025 1:31=0A=
> Subject:=A0[PATCH v3 21/22] global: Avoid indirect inclusion of <env.h> f=
rom <net.h>=0A=
>=0A=
> Now that env_get_ip() has been removed, the include file <net.h> does=0A=
> not need anything from <env.h>. Furthermore, include/env.h itself=0A=
> includes other headers which can lead to longer indirect inclusion=0A=
> paths. To prepare to remove <env.h> from <net.h> fix all of the=0A=
> remaining places which had relied on this indirect inclusion to instead=
=0A=
> include <env.h> directly.=0A=
>=0A=
> Signed-off-by: Tom Rini <trini@konsulko.com>=0A=
> ---=0A=
> Changes in v3:=0A=
> - New patch=0A=
>=0A=
> Cc: "Huan 'Kitty' Wang" <HuanWang@gehealthcare.com>=0A=
> Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>=0A=
> Cc: Angus Ainslie <angus@akkea.ca> (supporter:PURISM LIBREM5 PHONE)=0A=
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>=0A=
> Cc: Ian Ray <ian.ray@gehealthcare.com>=0A=
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>=0A=
> Cc: Jan Kiszka <jan.kiszka@siemens.com>=0A=
> Cc: Jerome Forissier <jerome.forissier@linaro.org>=0A=
> Cc: Joe Hershberger <joe.hershberger@ni.com>=0A=
> Cc: Le Jin <le.jin@siemens.com>=0A=
> Cc: Martyn Welch <martyn.welch@collabora.com>=0A=
> Cc: Niel Fourie <lusus@denx.de>=0A=
> Cc: Ramon Fried <rfried.dev@gmail.com>=0A=
> Cc: Rick Chen <rick@andestech.com>=0A=
> Cc: Simon Glass <sjg@chromium.org>=0A=
> Cc: Tim Harvey <tharvey@gateworks.com>=0A=
> Cc: Wolfgang Wallner <wolfgang.wallner@br-automation.com>=0A=
> ---=0A=
> =A0board/BuR/brppt2/board.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| 1 +=0A=
=0A=
For brppt2/board.c:=0A=
Reviewed-by: Wolfgang Wallner <wolfgang.wallner@br-automation.com>=0A=
=0A=
> =A0board/advantech/imx8mp_rsb3720a1/imx8mp_rsb3720a1.c | 1 +=0A=
> =A0board/andestech/ae350/ae350.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 | 1 +=0A=
> =A0board/data_modul/common/common.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| 1 +=0A=
> =A0board/gateworks/gw_ventana/gw_ventana.c =A0 =A0 =A0 =A0 =A0 =A0 | 1 +=
=0A=
> =A0board/ge/b1x5v2/b1x5v2.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| 1 +=0A=
> =A0board/keymile/kmcent2/kmcent2.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 | 1 +=0A=
> =A0board/purism/librem5/librem5.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| 1 +=0A=
> =A0board/siemens/iot2050/board.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 | 1 +=0A=
> =A0board/ti/j721e/evm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0| 1 +=0A=
> =A0boot/bootmeth_efi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 | 1 +=0A=
> =A0boot/bootmeth_pxe.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 | 1 +=0A=
> =A0cmd/pxe.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 | 1 +=0A=
> =A0drivers/net/pfe_eth/pfe_firmware.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| 1 +=0A=
> =A0lib/efi_loader/efi_bootmgr.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| 1 +=0A=
> =A0lib/efi_loader/efi_net.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| 1 +=0A=
> =A0net/lwip/dhcp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 | 1 +=0A=
> =A0net/lwip/dns.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0| 1 +=0A=
> =A0net/lwip/net-lwip.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 | 1 +=0A=
> =A0net/lwip/tftp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 | 1 +=0A=
> =A0net/lwip/wget.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 | 1 +=0A=
> =A0test/dm/dsa.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 | 1 +=0A=
> =A022 files changed, 22 insertions(+)=0A=
>=0A=
> diff --git a/board/BuR/brppt2/board.c b/board/BuR/brppt2/board.c=0A=
> index c0a163251b46..de206bdf1bc4 100644=0A=
> --- a/board/BuR/brppt2/board.c=0A=
> +++ b/board/BuR/brppt2/board.c=0A=
> @@ -7,6 +7,7 @@=0A=
> =A0 *=0A=
> =A0 */=0A=
> =A0#include <cpu_func.h>=0A=
> +#include <env.h>=0A=
> =A0#include <hang.h>=0A=
> =A0#include <init.h>=0A=
> =A0#include <spl.h>=0A=
