Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94ECBEDEBF9
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 22:30:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED7AC83E7F;
	Tue,  3 Mar 2026 23:30:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=novatechautomation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NOVATECHWEB.onmicrosoft.com header.i=@NOVATECHWEB.onmicrosoft.com header.b="IsF8pZDv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D35E483F2D; Tue,  3 Mar 2026 23:30:12 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11022081.outbound.protection.outlook.com [52.101.53.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95E32839DF
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 23:30:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=novatechautomation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=eric.schikschneit@novatechautomation.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ucqarWoYGh0orwULddX2m2X/9oU/STRjgkHChm4bY8kQHCIe2NzZEZZ/Eu7S1tkF3yTfDU7A0r7vIUTDelwvUh37OjlQpBN9aCyPghZmSaSZZugrfo2IuP+rP4rmdt/Mp/3TMBHus6y1ZAjkIRtpdYm1zRzxJunrlrvJoulyzKpVTcQVflh+DKIHBULM5uaVUEwOb++JQYTnbKZAIqwJ1I4B4d/vKb7w4ofX2J8tZ+9I9jcLrCkAcFihx82GT0k+yWnL6cdLxrBGLjXtfEdM7ksrURf1DL86L/PLlZ5RIUyQtpLeKkqZXf4YuaB8RUiKMcsd3hvSUl38IaHEvFk5RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XuSX0n5GEWJynYhbzXhzl6OuqUJiVGV5+w2F4kLEJwM=;
 b=xWdVjabjTFmHsFHNKUYs9+kcIGaU+nYcbhK2zc8RodHLhAsztjaRE6Yfq6w4c3ti1Iq8359di2I0c5EZsQqG/bJgMPH3Mn2faeFHDNJ9rHz2TbqmFHR/wUlRQYRWmDzqOniyEdrrV+logpMujwjMjUabF8Sa51i4tVoNf0wzJHjU8BEiaTvK3wpLQ6ObV8Ct5MGIYupDfsBKHq3yg6e97Y8WuxzDiNZ6aW6HuoIPgx0uC6cRwBlvz0u0CzxMn7i1Ez2wLKm0Bjg1tPdOvYUOj8E2EiXVooeExqg4OtyNE1y/HV0wkjcKKWbr0StDuQBtg1ODwE4HaURoDpsaxe61Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=novatechautomation.com; dmarc=pass action=none
 header.from=novatechautomation.com; dkim=pass
 header.d=novatechautomation.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NOVATECHWEB.onmicrosoft.com; s=selector2-NOVATECHWEB-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XuSX0n5GEWJynYhbzXhzl6OuqUJiVGV5+w2F4kLEJwM=;
 b=IsF8pZDvxuY7t7xanw+FVwvAWGwh/Aur/QfoVPiUP8J/+3tdzOCNAHdZre9S1YyaxANG5HQ3nT/lUGi6cgMS4OH0aZ97fV6AmY50tgtFx2Xyo78WdTxL/KDnJolDDFMvEQ4Rlv6MgpguC1uGhbfGNFcaR9OXBG17MQ+3dX6bB0o=
Received: from SJ2PR07MB9711.namprd07.prod.outlook.com (2603:10b6:a03:4fa::13)
 by SA6PR07MB10717.namprd07.prod.outlook.com (2603:10b6:806:424::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 22:29:55 +0000
Received: from SJ2PR07MB9711.namprd07.prod.outlook.com
 ([fe80::12bb:dffa:2e93:aad1]) by SJ2PR07MB9711.namprd07.prod.outlook.com
 ([fe80::12bb:dffa:2e93:aad1%6]) with mapi id 15.20.9632.010; Tue, 3 Mar 2026
 22:29:55 +0000
From: Eric Schikschneit <eric.schikschneit@novatechautomation.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
CC: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Fix x86 baytrail boot flow, UPD/VPD Updates
Thread-Topic: Fix x86 baytrail boot flow, UPD/VPD Updates
Thread-Index: AQHcq1tWoQp7KrDHkEGVSJPn96oLZQ==
Date: Tue, 3 Mar 2026 22:29:55 +0000
Message-ID: <SJ2PR07MB97117FB8BBBD7DC1F5CE5A21817FA@SJ2PR07MB9711.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=novatechautomation.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR07MB9711:EE_|SA6PR07MB10717:EE_
x-ms-office365-filtering-correlation-id: 6eee583c-1d1d-415c-8212-08de79746508
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: nfEIcAK5BemuJr8Du2ecetA14Lx7LJGhcBXo5gCjhEoRRpW/zWIUuWvzbRq+R5Mmgp+pc+5NnDCwgvPStbVshj8lpiIIUB7goddDbsCpTH7p7wBjSbx7YGKF3nVYpkxfxNxC0dVZy+pvL8FhDox4pl0sSFymX86XxwRPAaptjouHkdmDxN+cDawPRyLNnv94phU/VJVLy3LqYZQbVJeuUZY1qoHkR94E/WzPl2lkZKl+RVozVuUkvqrA6FExShnmGKYM7bi1hcSOKRhr2LMNOyaHj9eALg3VqamA5mIslvqTiEcl5r2qGaC5TQYGlvaxzJ5Ty0hPcoNjdX1GLmOTGeF+p5Ba6lC2COdEH+4fuimVrGVlLhX+1TbtTcNTnLZih5lxqLBNhCesfW3IitOgIGj/N9sD/9FlvvxsLdANtQcYkhpvY/5ccwJ1txNsa+WUZzmadppHW+z2teW0uUvXP1wvxpAi0QIMt/jJ3yiDVqebGDqgYwuQepJs7GunpQyksI1Yjk+jOIeFZ21ttLqozjOAbqObc5yzT1I3FQYXxLBilkbPa+WqpcU4PpyVdwglTqKzi51bTz2P775r5tAG7HO/2a779Ei2V4LR8yva8F4DCK1SyksC6H5qBkZvSCqpyVupYGLYz7X3NQ50ochFSQ2BtIzqwsXvJ8NQDdJh42FJEO9XMh/zpiXrXLV6xeOzIVazkVQ6Xsr/BX9YpmE/Qbg7t0qwSLnbI2ZYsw7vRO1mwbVUineTei9u0UXITZE/l1M0Az7LcRaEwuodlt6TC85WAiEML4XHBCUfHJY5rss=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR07MB9711.namprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?s6NJsLm60KbxlCVVHfDczlJaC6g+LrO2sDOyHOVZJN0aqZbnN5Ts5tQNiL?=
 =?iso-8859-1?Q?GjugBkpLV8Aujgyc0a7JrMdBuWIRFe6Xpl6VG2sW691EldMOr5q2DTPTYv?=
 =?iso-8859-1?Q?QRBstdYBCp/ayAPzc7R/oXKhvVijb4Qzjc2wMBRXf3tTqy/uU7rj2s9KnK?=
 =?iso-8859-1?Q?z0VuO6Ed1872Ag8Yh/Mx4WyLKiTBUjwtzE/k5/zkc8nLLqVdQ27DEOUifB?=
 =?iso-8859-1?Q?viobtBt7wZtpt8Hmj5kSTGe9Tf8DC24dNoXLyUtufcRxYqdxeTVHYaRM2R?=
 =?iso-8859-1?Q?0FmoLA1Uz8JQ0Tw32vLL+mxHKcSm0aPu+8dnj7YwDdjdr7dKQo0I4wjKmp?=
 =?iso-8859-1?Q?k/uIEKOH0pBTzCCKTRFZDBZrjJA4W8w6oyfHP/BTZw93NC63J6o1xuhttN?=
 =?iso-8859-1?Q?QfY1mBqCQYQcgK8jHdAYzeTPbJlnn9eEhcRV36egL1jh7wCiPGE4k16jOk?=
 =?iso-8859-1?Q?d80SpdEMfChtOJq4t3i7bD77LQT+Y5CREJ06/ibMQzjZ4qlcmw2423C+0O?=
 =?iso-8859-1?Q?ispJ5Lklwf5UUjuSu0eSMxp+poM+BFF23NsN1CqOqy2TBt9GUbX2EYL0KV?=
 =?iso-8859-1?Q?AaJ61fAtH37E6jrCLJ3RZeFI+FAAb0vnlhTGZQ7IddEFPfVbtkGkD1136A?=
 =?iso-8859-1?Q?wM+14cySGUb9rZNUmVN2PxQzycaG41xxwuf1gO3UVWd5WL13i1Ut8N+9K2?=
 =?iso-8859-1?Q?TsJk4UZ7bvu41YwWWf/7MlR2bxbSwiIRF5tIwWAmROEtm0wtbcfF6Mcqf/?=
 =?iso-8859-1?Q?zO3BvMWCr+Vc2z2MkJzeXZou4Jr2PlGCghwegtdBzJWwLRSMENlSvyt5Nz?=
 =?iso-8859-1?Q?AowV3lKrVrrl75er1G0OKwQyyjNto7S1eonivE1zJ5cHaQJHWvgrmlcPb+?=
 =?iso-8859-1?Q?GNRHBFHUIKLZYacTX7tI8Bn7AAOeMSUW9cAzdCmsFnXf9poa9EucaKQD3l?=
 =?iso-8859-1?Q?D5F6qEBBuCSmYZ3Z1LKwOvSZjbSVS45lrv1/NrPMVMZiJctgP1R9LH21XQ?=
 =?iso-8859-1?Q?wuUmVtXbXloSrxvtQkG5FtjXKGQQs7GQrfqVBNh+VgM1O00tSkm6Vmdm08?=
 =?iso-8859-1?Q?vCPBpA4oyAqgFCOu+8/HqYRpQBnPn3t4IrLT/RWP5bOjRTmW5znvKpPfeu?=
 =?iso-8859-1?Q?NBhaYBPbgCKDUUJEhPkM1sndcbdzYJa4/ohqXItWqyyBriOvxhbWmW2s1w?=
 =?iso-8859-1?Q?m3CrGkPOBCmd/aUqflegKSkMT+Oi1vSOi6iC7Vo7HGbIx3EQouWjkCYMWn?=
 =?iso-8859-1?Q?mYvZj6gVlSda0AY5nH3mCFNt2PaG2AaM7CmMLNkt76f30UX8fIXl+5dd1m?=
 =?iso-8859-1?Q?sS8cKZTkL9HsC3brneBoebckZ6T+VCYrMIpOF1Wg6mnCztN7zeMX2tVMS6?=
 =?iso-8859-1?Q?epzOtxizyZv+Jtn46dugSMIFFwDDA0lMdsDhYlSF9CwU1csK6R0/MqyD+M?=
 =?iso-8859-1?Q?SD+wGNE2o4cvpQGhyRSByetDOvICE7zyHxvFTyVr9n8WUGdmBAEJPzHIVJ?=
 =?iso-8859-1?Q?33NwZ8Jcj5UCn3wTgLLE/ynB/Iwpe+zp05B/GqqAajravUspAUJDlggGlx?=
 =?iso-8859-1?Q?PhnajIJ30XUW4HOXohLOZuXU3upLoK6DsFz5Bbl+4wmLQQZitL+JSyWBuw?=
 =?iso-8859-1?Q?HhzK6xb2eONLIkEU60pWrUuDfN7q3B75sl9gI2S7vLbtQzxigzCqAwE7qe?=
 =?iso-8859-1?Q?ZaC2m6O2zDgkCPzlAo2cgav7R9FcmSmbpn8/HlqXlZisntxghQqH+RNjE8?=
 =?iso-8859-1?Q?/VtJec647eWUrgJpVoSmtfHx7e5A48VsOy7znzZz7flfvM/rSVJGcPuEsU?=
 =?iso-8859-1?Q?bn0AFc069y7TXO46uG7kP1oZuo76aaVa4CiwHzvJcDNFPD2EvCE9?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: novatechautomation.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR07MB9711.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eee583c-1d1d-415c-8212-08de79746508
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 22:29:55.1247 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eb0f6598-d3e5-4ff3-a8b8-fe893d304059
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0DmQVmoN+hk4fZGqJJh2nuTUZhij7IZs62ifh+J9OTejozHq/L8PRDXgXMO4R5/rDGp+9YunR7Zlb1JcgAxRG42U7D54WMVz9R/zvA7OXCH4sYzjXQYxGk+6QMQw+Sncmpv8WkURqZw9if/1o7C2/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR07MB10717
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

After much research into this.. I tried building the config: =0A=
som-db5800-som-6867_defconfig =0A=
=0A=
which uses the baytrail E3845 from the master branch, commit ID: 8d24789abe=
d0822fbe41a2f9d72cf19650159dc6=0A=
=0A=
with GCC version: 11.5.0=0A=
on Ubuntu: 24.04.4=0A=
=0A=
When built from that environment u-boot gets past the stage that I was trou=
bleshooting.=0A=
This has been confirmed on both the Advantech SOM-DB5800 as well as our cus=
tom hardware. In light of this discovery, please disregard my previous two =
patch submissions:=0A=
"Fix x86 baytrail boot flow."=0A=
"Fix x86 baytrail boot flow, UPD/VPD Updates"=0A=
=0A=
Eric Schikschneit=0A=
Senior Embedded Linux Engineer III=A0 =
