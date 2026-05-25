Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE7ECD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 12:31:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E673E846BD;
	Mon, 25 May 2026 14:31:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="mskR+BaP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48AF7844CF; Mon, 25 May 2026 07:41:46 +0200 (CEST)
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c405::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7829B8405A
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 07:41:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ryan_chen@aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V8ZWr+UlcQ+mxAMvuvFZ9SPksIRltf2nPNvWqpQP8VwxHYfuuwF2ycfQoCf7ytfyaC5t0nUVmlhmgSrbuPXBlOE8zoOV19y85kRI84JGOT6RC1Z/8Bwb8V7ZZoCK9f9BCyfhpRC0zdouRl4RV9R/9esn9h+rirDGJ2c7+7VQ8p/Zft62CLu5y6pVlNUfwvbFlD24GCKNBrOQ051nnTfcNQyX+biptrDAKMW9WQL97cYeUkX0fQaayAYQHsf4dHs7MphXDvd6BLNN3aZCXKZ07/1iu7AqywOMl+V79j49OJxSUqm4HHda3G7yYxnHHobKp+fB0GsIyX+Dd4+UY+WihQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WtVEBVO9eIIEHvVwPJuasbXO7GNTSbnZckkt7w5SSl8=;
 b=NN7EbMAIlo+XidIzlhoSUyRRTNSNSKDSbMDuiz86ZrbyM4VEl6ODMt3GkYnf11afwC2vgBz3Z2kbi4Inq4vJcLIWUJAuYt0zw3IC1Xc7DuuhuvfImsvLGK+IJ0kgUZG3/83wZznvevjq8dFjxRKDgLntxa1YjQk4igLSQfYz7+1reTKknkcPzGbSXmqWBAvaSZFXM3sgP7i5AiGiYHECIE24+5V1vZxnZUcwUFrq+3E41p1XtiGPeo0sO8FspfjfSPcUAn9oYFKSyQU+0ZpzzvxOJNxMfX6qeKMiGo3pcJX8HhU0VTxBYhn0vXyim1iYa+bdc+aV5+55OPU9MoEezA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtVEBVO9eIIEHvVwPJuasbXO7GNTSbnZckkt7w5SSl8=;
 b=mskR+BaPun0Wr+Vm82zwjiAap8/dwGk1fLbPFmUIGiE36Kl/DwKUdomLzgeQpmoO+JdjXn4w+rjBunOcaEFN5/JP8fUczgYzXX0Bsqbc8SJdiiFvAjrElIU52lBAmwDhjecej9aP4IYyXg5elaPztlaeuru3iIhgif2yPGfXZJP1Dol69h2UGULuzxNUMVLew0KWEr837OMVACx0NbsTyncA9PGCR97K5Uxe5/9Hoh9y+lmH7o7mghJ8JCXXZE4p75AT2hxKPcly3SWtuU69eKz382MN5/kNiLj+bgWWQowOnaGwCazGBh9R0m9VHvACdaqq5aCmsNQPK20vC/Dr0w==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by TYSPR06MB6714.apcprd06.prod.outlook.com (2603:1096:400:476::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 05:41:37 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::b696:e104:1f5e:7838]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::b696:e104:1f5e:7838%7]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 05:41:37 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Tom Rini <trini@konsulko.com>
CC: BMC-SW <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Lukasz Majewski
 <lukma@denx.de>, ChiaWei Wang <chiawei_wang@aspeedtech.com>, Sumit Garg
 <sumit.garg@kernel.org>, Anshul Dalal <anshuld@ti.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Tien Fong Chee <tien.fong.chee@altera.com>, Andre
 Przywara <andre.przywara@arm.com>, Frieder Schrempf
 <frieder.schrempf@kontron.de>, Peng Fan <peng.fan@nxp.com>, Ernest Van Hoecke
 <ernest.vanhoecke@toradex.com>, Brian Sune <briansune@gmail.com>, Johan
 Jonker <jbx6244@gmail.com>, Hai Pham <hai.pham.ud@renesas.com>, David Lechner
 <dlechner@baylibre.com>, Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Parth Pancholi <parth.pancholi@toradex.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Janne Grunau <j@jannau.net>, Paul Kocialkowski <contact@paulk.fr>, Patrice
 Chotard <patrice.chotard@foss.st.com>, Gabriel Fernandez
 <gabriel.fernandez@foss.st.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Finley Xiao <finley.xiao@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>
Subject: RE: [PATCH v2 0/5] arm: aspeed: add initial AST2700 SoC support
Thread-Topic: [PATCH v2 0/5] arm: aspeed: add initial AST2700 SoC support
Thread-Index: AQHc6DIhXrysq6KFM0ekKieUIMRmFbYaQ+iAgAP9Y4A=
Date: Mon, 25 May 2026 05:41:36 +0000
Message-ID: <TY2PPF5CB9A1BE64F089D4D2E81B0D20BBAF20A2@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260520-ast2700_clk-v2-0-c778b2908e5e@aspeedtech.com>
 <20260522164343.GT1858239@bill-the-cat>
In-Reply-To: <20260522164343.GT1858239@bill-the-cat>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|TYSPR06MB6714:EE_
x-ms-office365-filtering-correlation-id: e6f73613-4cb3-4b64-a2f0-08deba2049ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|18002099003|56012099003|22082099003|38070700021|4143699003;
x-microsoft-antispam-message-info: 2CDGF1MYd8w++o7iD0lgG1B91er99JaT+SjvPgTg8uTkp7L7SdpPvZ4Gp92oNvePVNdbO2pSvUtOzphCaZAp2kIps0CDw0isZn2g8uuOfC6Pe6gRkGUCsC6GSbpxH+mlNohknH1JG2azMsL6TU6hlx69+dX6rdDhoCuTq8F6wlMrbKkCKzbCrvDjBx5Qfn5Y6n8d7QiLOJ0z4U9wOuAEq0BaB/DiMRcLLd4rO7/7rnIeTgPWG4Ft+Cqg1VqzlD3BXxI4PSG3GdayCd6n3WhhYvIEwD7FScSeaviRyyB6PzK+ZlmlmdeyrQ1nllDdMxoRpelTXl54GCQ/33Ztxc8K6nkdAQq9Jp0fZQD3o/RCi2DuLDX1c5RrDP0cmQuIzZs0K2CxKXkKcyMFKENZJpL7htD2iGDCD9mXKegP0qjF2pJrMK4ZoNAajjMrnQtFUAaweh2q19XGjkRwBCcRxuN/4126/1Od8FyHCBhe1WMQSw3A1n9etLOQXr6QdjcUhglcHHPlagf7Dc29Na9e+t2QVHP6vqmQih6iyaQnxb9h20A8c8EXxZL2GLAbYZF7UW5gZwXbubYXVTDksy4k0DNesYp6g8ISdL72AhpEtpWDzYZFZEYlCD5pAxoF6lwEWJ1IV8+UEfMxVAa7OTOF0rzNz445Om6EY/NiEEF9jL/H8rfj44iC6T2yMyWVRR+UEawzIQ+zwfoOJp29LeqnVveHi5fpCkEhk2i810IvrLn+VFGlw/m9n5ZAOnRGnkzY1s/A
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(56012099003)(22082099003)(38070700021)(4143699003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DL/bYkcmqCSnxMCayfS0yi0yN2iadoj7KXragJK0hOAocEPoWwSsldn+zwQ5?=
 =?us-ascii?Q?7uxg/zxMsM4uk1nn/PWnxq5ZthPGsOTmwFbpDzbfO3CLD4vIetzPDY64MqRV?=
 =?us-ascii?Q?25gGoW4xT7MQZUIL0WAYiJUgHeOCLGpwVdEyK783k4FzcpzZ/WMJG/1kOcvZ?=
 =?us-ascii?Q?PVC/IWpCiencoGJN3D7ZKdh3byLjVcv2M1SsRc9YuGPGnsWFx8K8bJCo0lFP?=
 =?us-ascii?Q?6lHMzStxGBJ5aQ62KEsa13AUzp6hDWiE6/+cjrXC/sFnHGUz+cEqrPlk/4+m?=
 =?us-ascii?Q?QnzmYwR4o1lHoeLI6ZX/4gxNR9fZggfrJ0WFRL71RTeL4klMgFQ03S4YtiRU?=
 =?us-ascii?Q?hN2q790wTUvj8B230IA7mWb9pcrDfe0ExYxfaXgU+HSVcEBUXqK/A4nkfi4S?=
 =?us-ascii?Q?2AcKAGQeMfJmFjEWEzERDsoj4FG+f3f1iVF22SPUgRNZNeJRXtwqzO5DeKRv?=
 =?us-ascii?Q?1YCXZFFOGfSWJrl+rsZGSUhX7qB+99MCKWIDgrRjZyaaraB7S2W6m7j90aP1?=
 =?us-ascii?Q?6kLuqlcWM9N7sWPU0jSqMnhCkBzSFECwMlpvaO1tHSkGbYwxyyC3C1X7jwgJ?=
 =?us-ascii?Q?GBcwQeTnsIa+2Pojq2dlPkun8BzNIGmm5EkivVQTzjUf78qxTRx0vkiBJQDv?=
 =?us-ascii?Q?kEX9tbTcZbrf8PjklLBB0i5cLSG+pMy24C5HaEUDiXBMbFSV9XxJFGLaBaoY?=
 =?us-ascii?Q?eDx4jcexlvmasyeoUEsfpDRV5sYcSgrH2ZJR9tqCDcv2lSCSdydQCmUpJ1Gt?=
 =?us-ascii?Q?TKxtBWfYQgpRS15MbsRDFqQcxyaHBTUA4lWE3EgltBHYS1ua0KPyOTOk4ouc?=
 =?us-ascii?Q?Plt9p2agnpXqWCw4zFyjXnBSERqSMcvJPbfPCykVALdZP4yyuAAXun7RybS+?=
 =?us-ascii?Q?jrmxxKyHZKnpGhkB8kG4RR9g0ZfZcQ9/iFz6H0YoU1Ufe40pzN5NQ3SrLX3s?=
 =?us-ascii?Q?MZOwn2tgGfYm4QQ6RBEADFc78U6WZ98zf8Inypk4PlenhZMC6W//CElQKHbC?=
 =?us-ascii?Q?koyeGG2/roibLkQPakGIT4dnhP77ktJDhHhBbZisYIr09vnErPcl9g89R4aS?=
 =?us-ascii?Q?t5QaOFsRCmnNygUEkYaEpkKRCeAstGHgohaU4mi0HIqnfgikIvIscGBfMsgk?=
 =?us-ascii?Q?Du5FnqDhS8R6dt3DuuXnY042f3tMovUS8gE2KcMcENxHZPgH2WJTVEpcs2Vn?=
 =?us-ascii?Q?40r8CNvj1tOJB/lOjsdJFNhCCXB43oTPXUQo0JrSd3rwKJ688O0I3YpNlgWE?=
 =?us-ascii?Q?DoUVv/uclCt78qoNckfEIaHt2h/jxe4i+B20WxCpDF/vPbIcvjISIuBckC3E?=
 =?us-ascii?Q?VaP+qgsgxHsNptGFmJ4buV1zh5+51EUO8UcJVB8Dq2EJv9qdVlU3i8pypzch?=
 =?us-ascii?Q?MlMiCDTEoidkSYbcZtdLeuPQpO37OmwfhWs/eZKtY2WsqJmoS8rgQHmKL3oU?=
 =?us-ascii?Q?ZUErRnuW+EUH2NdCUScc/UAWJcaYBll/fJkIhAFTSbvXZki9vv/m9/tIJ47m?=
 =?us-ascii?Q?ZqTCc1lWAKL5o8f/4Oh8gsiPrWzUJBBiryVskF8twyWf5kEa0Oo+A26PjLtR?=
 =?us-ascii?Q?8TAEfmrxwIr9ElxkkZMtqon8MFtRjxqZIDlRvfRiM1qfkGzkjRTzDV1YY2bm?=
 =?us-ascii?Q?1ituiQXIeAVN8iCJt+hY+Ow+Bw8nDU3vM4jv2ZHVOCzCiudpeOn4aoiLS6Em?=
 =?us-ascii?Q?yEAW1oEjEKejaZs6x82b1jb617iMvg/tll01XLqqFkCoDbZ6JrA9uvd5ofcv?=
 =?us-ascii?Q?PXFD80FmEw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OSIBHGRtmFU4mI61twkqISS4ZlILkqieYve3Bek9i5St2gInoeG4wmHfzDQUM6rPX6O37YPY+8EiwDDm2KmADRctIXNDCCVukKIpQIOLK4frg0anFJt03IgZdGvdcrZSfirB1D5iMhMCQzeuL9O45tbuxFhZkFcqM9Q1lfKSsDMSRf0VNmD5BiO/rWNulAfMR7Rw0s91EaDsf4Bj+f0sgJs//QbU/kExdhVcRrPLpJ0G2iD3gVFngT0l+9lyDg8QIQFbWwbWblNaJl2ilD1KcpVcI6STK63DqSoZ4vQnk+4kQ34Qxgl2e9W5yw2+2b57KHbXNlnyFb0tKRbTmwtnIA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f73613-4cb3-4b64-a2f0-08deba2049ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 05:41:37.0798 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: USk973GUl5A4ciyVysEcIJyKvRlZdgaOI7NVqXgl1UVm/wLeEP/h2U5hi8CDjd36i1Xq97gIUrXKYwI8JcKIwb8vBsE2e+oPcIR1rCIAPUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6714
X-Mailman-Approved-At: Mon, 25 May 2026 14:31:01 +0200
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

> Subject: Re: [PATCH v2 0/5] arm: aspeed: add initial AST2700 SoC support
>=20
> On Wed, May 20, 2026 at 04:24:47PM +0800, Ryan Chen wrote:
>=20
> > AST2700 is the 8th generation of Integrated Remote Management
> > Processor introduced by ASPEED Technology Inc. It is a Board
> > Management Controller (BMC) SoC family with a dual-die architecture:
> > SoC0 ("CPU" die with four ARM Cortex-A35 application cores) and
> > SoC1 ("IO" die with peripherals) each SoC have its own SCU PLLs, clock
> > dividers and reset domains.
> >
> > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> > ---
> > Changes in v2:
> >   * v1 only have clk driver, v2 apply full AST2700 platform and
> >     reset, clk, ram driver.
> >   * Move scu_ast2700.h from the clk patch into the mach-aspeed
> >     patch so the SoC header is provided alongside the SoC code
> >     that consumes it.
> >   * Link to v1:
> > https://lore.kernel.org/r/20260508-ast2700_clk-v1-1-2797a626a238@aspee
> > dtech.com
>=20
> Somewhere in this series, a MAINTAINERS entry should be updated with:
> N: ast2700
> As well, thanks!
>=20
> --
Hello Tom,
Thanks.
Will added N: ast2700 to the ARM ASPEED MAINTAINERS.

Will send v3 shortly.
