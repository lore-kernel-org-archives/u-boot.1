Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD62EF8FE4
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 17:27:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F225983FD3;
	Thu,  5 Mar 2026 18:26:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=at.abb.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=at.abb.com header.i=@at.abb.com header.b="dCbHMXCz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 754D8839A8; Thu,  5 Mar 2026 16:57:30 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6725881E18
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 16:57:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=at.abb.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wolfgang.wallner@at.abb.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rrWyCg+qyxYCWls0VS5Pt4kMs4WmNgLoE6Ld42ZClOvaW4Nt1Fosxywpo6RY5a1jqoP0uSwPn5JhBQP4aGK4acFYS//WdbaEFSz7Nfpwcf87V/Sw2MysNZpxxa9zv63HGHW+W8Asat4gJ6BhiRD/mimpjAKbH+DBYTMHZvFNKCEs10LxRlofMfqsXrtia7S2rp3SR1/jn7Q1tDm5cWUTmWUvSMeS9LnKOO1aAW0RcO9ISRzd87BSHc3d3DyDqaTRz1VypCMPYtcuMG951+Jc7ks0glvb8OrTUe7otCXNG6MfFN5as/2c7rx55h46A6uyDaJZBCnkpJShoPncAuwsfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbNZYiVgHOJqRJsuwFpcBuTSJgE2UpPJHkKd8erTPTg=;
 b=rOvN1MWWHmS9ZfqI8Bgn6faC1TQYil0CIpJD43xky6Ta5AQoEslogzDSMDTSQYhBqaNTMdc2bryA6SQZV1GS+DNERQE5QuDoeOCo2ppAA1G/zqY6bs/bMFqV22A+rwkHFO8VC04Kgi4A/GMCQK2s9afPb1VuRRiL2wTLjzcPLdDP80Du1zzZbOznNCvSbhDnO+d3av+MBqiTlbrjcHDdCYo6GAcmHLeggNUWyQ97J3ZThwJKcytbfcdvBdBfSltLEg4UzqeWq6TB74Fx0cCcjEEbmwA6Q/SNGW/nlyAUFX8QT8ozFMHB9hdGUTu+yo4gUJ7EdP0cRbilUKkZ4CA0/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=at.abb.com; dmarc=pass action=none header.from=at.abb.com;
 dkim=pass header.d=at.abb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=at.abb.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbNZYiVgHOJqRJsuwFpcBuTSJgE2UpPJHkKd8erTPTg=;
 b=dCbHMXCzqCxriSn0dFa6bdsLD85ED7FSy9jqeDnCRBTWucmHgQn546YsRrMeMJQzF8Ib30XsDUwPhx0pCfQ8iUOCELz/8C6DX0iX6QQD3nKNj787W48EDA+r3PV2P0jUSFuoOyZ34z+0oHHVrpnZC2/P7haTYtNRD4BEqeQCv71BY3orLZIUznN9gnBfknl25cMwm4S9YD3Yhzhqgr4o+6jCa0A72evK4SaeXZYrRh+oXSmXQhlGiVinewF6ZFRRTBa8PTvBLyVLgQ+GOOQKxf5PPkj39fKeVj7/yeotp82V4wi5LkDgM87uqzJOibxXw/URd3v0OiiRInsUlPGU5Q==
Received: from DB9PR06MB8512.eurprd06.prod.outlook.com (2603:10a6:10:36c::17)
 by AM8PR06MB7491.eurprd06.prod.outlook.com (2603:10a6:20b:365::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 15:57:26 +0000
Received: from DB9PR06MB8512.eurprd06.prod.outlook.com
 ([fe80::c595:643c:30dd:131d]) by DB9PR06MB8512.eurprd06.prod.outlook.com
 ([fe80::c595:643c:30dd:131d%7]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 15:57:26 +0000
From: Wolfgang Wallner <wolfgang.wallner@at.abb.com>
To: Quentin Schulz <quentin.schulz@cherry.de>, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>
CC: Tom Rini <trini@konsulko.com>, Bernhard Messerklinger
 <bernhard.messerklinger@at.abb.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH 1/1] board/BuR/zynq: don't select non-existent
 SPL_BINMAN_FDT
Thread-Topic: [PATCH 1/1] board/BuR/zynq: don't select non-existent
 SPL_BINMAN_FDT
Thread-Index: AQHcpiEFiqnSIGFc1ECF9pWg1xnpe7WU8ViAgAFpgqCACckrqQ==
Date: Thu, 5 Mar 2026 15:57:26 +0000
Message-ID: <DB9PR06MB851219E4216DE482BDD1561CB37DA@DB9PR06MB8512.eurprd06.prod.outlook.com>
References: <20260225063559.47481-1-heinrich.schuchardt@canonical.com>
 <a1a57943-efcd-456d-a6c5-cf3d1d87b385@cherry.de>
 <DB9PR06MB8512053633B5A7EA47C3A040B373A@DB9PR06MB8512.eurprd06.prod.outlook.com>
In-Reply-To: <DB9PR06MB8512053633B5A7EA47C3A040B373A@DB9PR06MB8512.eurprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Enabled=True;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_SiteId=372ee9e0-9ce0-4033-a64a-c07073a91ecd;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_SetDate=2026-03-05T15:57:25.720Z;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Name=Internal;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_ContentBits=1;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Method=Standard; 
x-processedbytemplafy: true
templafy-owa-emailsignature-processed: true
templafy-owa-emailsignature-version: 1.1.0.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=at.abb.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR06MB8512:EE_|AM8PR06MB7491:EE_
x-ms-office365-filtering-correlation-id: b392f260-d827-403f-db80-08de7acfe5a2
x-abb-o365-outbound: ABBOUTBOUND1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: 6soun8FVjSAykkV0CRIrzsG8gmEE9ILrLSsiLM0IgsAamUS4g8gLogpVj4DlSWZSFptNKBkCAlkvKrjnzCfkEhXOaMsSEWLAI2aJH4F/oSQ1mZIYt1cxsZhwoUGSfNIGlA2KI7gBJ23gQpR3U7kdwOQ5Y5tDVQKMFQIsKsIe63DH2x2mKXU4jbyKIE7QW5oW1+Zu+9bkrb7tdv158CqKaujAXoeNeanSjcpcjrbfUaeDCEs4c3toUW4y0U2cKeVzNXXzQTm2KCT3drWRYq/2Cy5+xvRgBx/TCLvtyhKfY/Ha7BAihiDi1DebBrS3/0wrW18eaPBSyI14GHWlpY2Sxf8MtuiTw9FFUVODWpZ7HozSsx4IpDsuvWY7LfONesBfYub45RlS3cRlxG2kusIQL6gIzKPt9Pa9VtdsuNsLCNsuipgUHjCTHdONfaG5yHpYgdNqmT9XUACjpGUzcqMyEq0baEN1TOJlaUGSIpbQYQJS/SXpP1PZpEVMd0lceAo30jNkWWjgD7rI5YR1LNlbdkYENQajl6+wYm84VR0OQ5kgjLLHu/VUVhBf+SjDBsMy4iQFBSbkD0JXlcm2hKdzRXmG4Zaf8Tau1Vbc6MqkKuyqDuphahHUXo/Upyc+X6PK6Aa8N82D293YqjejocUykmO+XjrULY592bjo5e0AYJctsAXqKtjmma3kPwONylGRklw/BQuMx9mIjS4LZLc5uJfnk2rgSTVi4RAE8ayizvXlsBvtaG8KHIEjGV0DasKy05nx3LBkmrKggrEpM5UicpWF/THh1gWvwAgUiU72E0s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR06MB8512.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HOl3o5Qv4paLQ9rMuA5q7MEstTIvQ0/H4v89mjutu2qiqG7dWH4jO0+T9A?=
 =?iso-8859-1?Q?iHjoishSU21rxUK87aJ7jXJ6+mpsgHJgpSFQIilPcI1VZLKS1Qln2s3kIu?=
 =?iso-8859-1?Q?xMglUjBeAA5wgeVOZ3b3r6vzQewvLFfbpqpxu6M0V4QhdOz2Fg9rJ4Qnw6?=
 =?iso-8859-1?Q?QX3b7eNSYo8CFCWmKTpJk2pkktcJd9BRjpM8B5hOWu4+yvVgPaBeL538N1?=
 =?iso-8859-1?Q?0s/bkz3bQh7OwvCT/h7fPjGoIMzCCUbKdk8q3iN0wSRDGXDPLmLSdThgA3?=
 =?iso-8859-1?Q?wYoKTfPucqePrXFVaGdUhM1COabq2kSFzgdi3oaWFQiNc4ITkN4Zcyq29t?=
 =?iso-8859-1?Q?QCqMNV3dPAAbATYdcBhVt+rw0aWlHYlm4x40GoLesKLZoChpVrZ63CFqux?=
 =?iso-8859-1?Q?INDWk4uzOsNHY7GxjwMT7QLiUQIHjSsPsm/p49tRTkdEDCJtBfN6ZcrNhQ?=
 =?iso-8859-1?Q?IYe8actwZpAu9ygrF3gl8kxc/nzs45rT39bFGs6Jzdl290IGRRIEh6BMOj?=
 =?iso-8859-1?Q?yxVvqQFRrWgrRNDIPgDVbvf7806iMoVCxJLBoHakWZoBwLPWorLZHFCy8m?=
 =?iso-8859-1?Q?CAvDkkUpobwDXdbTeWqNwFjiWQhBG6zdyHSTP+vZ49WVopJqt1wX5OGaf+?=
 =?iso-8859-1?Q?fk64CGOyxMQeWVqA4cZEnfRtls4lgx+1Uq4rl0ovTJbyJ1RvHElIvvmPad?=
 =?iso-8859-1?Q?Jcx+JJLfHV0k63HELlBf2sbDsiaQ7w+QrTz5ow/kWgN0suQcbOpYo4WY74?=
 =?iso-8859-1?Q?ymWbOMMop1tI2WuQjqq3pUZHZze/j6gJtSV42jJCFTFWc9Vk5Y8sBLec8i?=
 =?iso-8859-1?Q?HXJ3w8QSSipCQDwf/rNSENAtZ7dGwC4vUvX9RBkWM9DRumQdF2dnyFVb0U?=
 =?iso-8859-1?Q?WbU1Er0qBmH3wD4XP7Nw0GKTPczYU9nWQowCWNEjZKcri9oBGSTVHydXTV?=
 =?iso-8859-1?Q?jqehjop/2pDO6XEQgK8e1+6bW17dDf+1bvZHTCCMd8DBRkSKxxkOV9GRcE?=
 =?iso-8859-1?Q?f+h5CfEbcv+zjDqxF/EZW2Qa8A4QtgqYP1O59X6ogxhjNIFU7S0QPZQ/cb?=
 =?iso-8859-1?Q?YAsrEQ7+io7LyUJbYTZ2XBV5OKIZ0ZvLBYsEW9fRj/p0XwgC2Ic/yWfPa6?=
 =?iso-8859-1?Q?ffqk8GCFqDr2Ts4xl3E77Bo/dVdKGpdDqZJcSVSKtqION0g3wmgiY1CJvZ?=
 =?iso-8859-1?Q?BcN7CaTayBhn6BreGy5eK9iW2VN0vUJ2GLwiZGXdDY1+1Fav1OwKYHgX8v?=
 =?iso-8859-1?Q?9nvunXhVhGg9887e0sJ2mFkXGZ3q6Znlv+dBSWbgVbIViSvhk/oGgtd+7P?=
 =?iso-8859-1?Q?2xXNPoy4A4LkSPPCbeal4vVROcTFv2fMahxzefISMyrr4Jw7dxpk0adh6e?=
 =?iso-8859-1?Q?6XnODryg0DgN48PSFjLV6kFUX7jK+CwoFvDpn+x52at+blItxB3vvj98gs?=
 =?iso-8859-1?Q?jVt3T+s47jZy9CI8zMXx1QuvgX9fApAzBZ/SAAcGNBFDYyfmJhwpj454oY?=
 =?iso-8859-1?Q?ZU4X6lLEURWl/w6C8OABGVpcyAUYgDnZKq4KLsR+95iNK18kFoaBNmolWm?=
 =?iso-8859-1?Q?iHnITFBIyqzupPa+05SsJIJPK6x9VE067i2VKwrL/9ml3uAS4oMMhr8ibz?=
 =?iso-8859-1?Q?v5xa68KNUyiBW9YifsYeU9YtuOtG3arxmn4UTzsDF9lHCJyfgTr3Km7jQq?=
 =?iso-8859-1?Q?ubTC4CQAJ7nesG+vhJXc8qQRHNHzoEdH7lKHyaUF54N5qlrzqf9rMIURyU?=
 =?iso-8859-1?Q?s/9yxq15ZBJs/4xFzxd8Lqdnl6NMRfqjzYoNm946UzaC0jeVw88rHUF6q0?=
 =?iso-8859-1?Q?+RfpgxwgBA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: at.abb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR06MB8512.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b392f260-d827-403f-db80-08de7acfe5a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 15:57:26.2458 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 372ee9e0-9ce0-4033-a64a-c07073a91ecd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1zwdsNrdYWcebUcfWFkIC3q6LTqA3u5YqSbUCPQcZdUsf+vBvKc4KJFpnUDlIUDalmxmC4KChQl6WXmAqplxyylu4ckF5OZI+zi1fzs4vEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR06MB7491
X-Mailman-Approved-At: Thu, 05 Mar 2026 18:26:47 +0100
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

Hi all,=0A=
=0A=
From:=A0U-Boot <u-boot-bounces@lists.denx.de> on behalf of Wolfgang Wallner=
 <wolfgang.wallner@at.abb.com>=0A=
> =A0=0A=
> [...]=0A=
>=0A=
> Just by reviewing the code I think that both the patch by Heinrich as wel=
l as the explanation by Quentin make sense and this define was not necessar=
y.=0A=
> But I'm currently working from home without access to the required boards=
 to test the patch.=0A=
> I will provide more detailed feedback next week.=0A=
=0A=
Looks good to me.=0A=
=0A=
Reviewed-by: Wolfgang Wallner <wolfgang.wallner@at.abb.com>=0A=
Tested-by: Wolfgang Wallner <wolfgang.wallner@at.abb.com>=0A=
=0A=
Tested on an X90CP154.=0A=
=0A=
Kind regards,=0A=
Wolfgang=
