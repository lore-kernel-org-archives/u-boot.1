Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54556109E54B
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 04:56:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6612281E18;
	Thu, 26 Mar 2026 05:56:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="EQaJC96T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5649983A41; Thu, 26 Mar 2026 03:57:18 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2314E838BB
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 03:57:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J7a2cHGt/dE2IWp2mX7L6QTRtFY2Sa3tDcVUOPGq+6LcDJ6Z0tTNMD+rjTmvJysRbEqBj/AwR/cpeBZdlUPNmoqsvec9FVMRu6fVz8YB/rDSG2v+n7xeHmAIEuBEySvAkJ6JFIDS0C7vg5QNmbefH3nSd7Uy1/vNPnJcLIIzd8wIdzAHc2cOx4a1bNCjNc9ozTAIAwmWZ4rYiFSYZCdSNqJ3H6tHJsIhuOjXUWi08OWZmDAsI/zix39fsaR1UrPqS251J/HOeblgQoT8iX1ajGWR/O9jj9o8mFkpCEoumUBlcRC98HIh0mDmQNeU9eK9RlmBluSwbXCiRBQr3qnAtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FTl1af/x4LpVAlS7L7CcFRdskupqAfXq2VfjuMyVA0=;
 b=fU+Bc8O/pMH6EQQXMsQsFqD6HlV6wfw+Xx9NdOU9Gi+PYadGIMDCJRBXtf8+lglvxOmBWfO4fNNH2zfj+R/Bx+uax54/RPRyBgPnLMXKq4TB8vR8JbyE+/suFWcTW2IDDnUd5FhSUk+T9Bd5+vaNJe7/Tlxfg1AoDq0O/gVQjI0+z3+EvXTz1AJ3nfrx1ASY1Dox4v25KT0JGL0GwwsaW8aJNxhOUAOVDRo8mGJw7RoQof5rnrv0CPBtxjhvyq0pFVysBsysPZ0oW65iBY5KoHYPpFfvakhRWAZ9Z5xjE1VKWA9z6w4kIVgNIGO9jfFYGFaYJLy0UH4LfWy9CPczYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FTl1af/x4LpVAlS7L7CcFRdskupqAfXq2VfjuMyVA0=;
 b=EQaJC96TasL0pIqizuyg5vGDv5ngBqIiXrTvywVUz072absg4TAkXXf3okQgC/9SbQlbC52hm6fqaB1Cr76m/jMhJL4t27QH563leZj+hAsBwOv5Pa4BR0lm5biMEeN6rKhdQKWx02oOhinv4Gsn44PGcnBpa80EdiChPixJG4bSFLB0iphtuhzuP97Pg64G/poWb+PoxN5ipiwjGzP59zAEWGwyjvX40LvWNmx7hnd1mTix6ep3+c+nWjw/elFr0s9/0y7n2nUfDAbJ7ib5vamdwYzozoT6Iif6MUVdSAmKFa30DPG2O/g3dAJrs0Din+vnkR4l1LY4E/Rtn68e/w==
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by IA3PR03MB7763.namprd03.prod.outlook.com (2603:10b6:208:510::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 02:57:12 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 02:57:08 +0000
From: "MANIYAM, DINESH" <dinesh.maniyam@altera.com>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Marek Vasut
 <marex@denx.de>, Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, Dario
 Binacchi <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Richard Genoud <richard.genoud@bootlin.com>,
 James Hilliard <james.hilliard1@gmail.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>, "Chee, Tien Fong" <tien.fong.chee@altera.com>,
 "Hea, Kok Kiang" <kok.kiang.hea@altera.com>, "NG, BOON KHAI"
 <boon.khai.ng@altera.com>, "YUSLAIMI, ALIF ZAKUAN"
 <alif.zakuan.yuslaimi@altera.com>
Subject: Re: [PATCH 1/2] mtd: nand: raw: Kconfig: clean up SPL Cadence NAND
 dependencies
Thread-Topic: [PATCH 1/2] mtd: nand: raw: Kconfig: clean up SPL Cadence NAND
 dependencies
Thread-Index: AQHcq4aKJh8vW2pBCk6IILThfZsHE7WeclEAgCHM7b8=
Date: Thu, 26 Mar 2026 02:57:08 +0000
Message-ID: <PH7PR03MB6942D3E727EC89DE074BC0EFF756A@PH7PR03MB6942.namprd03.prod.outlook.com>
References: <20260304032441.31558-1-dinesh.maniyam@altera.com>
 <20260304032441.31558-2-dinesh.maniyam@altera.com>
 <20260304143920.GT1388590@bill-the-cat>
In-Reply-To: <20260304143920.GT1388590@bill-the-cat>
Accept-Language: en-MW, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR03MB6942:EE_|IA3PR03MB7763:EE_
x-ms-office365-filtering-correlation-id: 0e1adbde-d6aa-4cbc-eae9-08de8ae35eed
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|39142699007|31052699007|1800799024|366016|18002099003|8096899003|22082099003|56012099003|38070700021|55112099003;
x-microsoft-antispam-message-info: JpPXMrNcSeHDpnKbyY86UD9nSkb3KOhxIXgKmuvdbg0Elw/+beQmAsYB+umk39n7SJkqGmNbxs9jVGzNsncnM+/tuo9pzGWi6C9yGvpjSXV9Tc0LVtJy9M/yDOr9ukY3gydplWKcE+cffKEDLcqsm7rmYNZPzbgw1oZDxt9VY1YSzs/RamzdDrQJGSaQHj0XBtiPxmt2O6sGxAHBayTXtdFbqI4hx/U/SDYr770mlVcd8sbwQO96D+Sa2I4ON9RdISikZ6pzxFaZsfG0QrQKYDEefGbzV95iMefQD7nmXFLQb77L7lYuSgT0pMdDQbLDbm9UnDJKAn0vvd6Yd5llSOrTJr9NkvzFvXvSeyET6Tw5+Hbt02FbA+CEUhZ+T40TUgwrqMRpp+qgmeOMNsCRw6VI/6pg454eUp4uvZYMQ2r/yNlEEKhZImJW67HrO7jq7VwrCObLwsPBZxOfKuJHEqP6o9U5yQ87+7yNg3d2M1pYjbK9EO1seaTZQ3qebrmqcO30+ndjTWi9UHEwDx103iIoTGbF3SGY6uLq39wSCVsFymOTtHTtwPHu9NrO2dT/JG44P1gj/10CGvqUbJHjwTCxtpBmKsxLA+Tss9i4APdwGxwsfxsGNVNnjpXhXF7ApvCl56om6F+CdPHqucBsO3gKgJhWVoZ9VYwucw9/X3Dnw/kEBES0EE0sfLpXYqdVPV1K4e9hdAW/D37yMuy+eHEXtFJIEz8lJV1Q0iGOry1BVo5hkS2iUwMmsGJZn3iC9M+V9ksceuxkFWXnHXiEEWCcBuIXc236u2RtriT2IWA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(39142699007)(31052699007)(1800799024)(366016)(18002099003)(8096899003)(22082099003)(56012099003)(38070700021)(55112099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?QUnvGA9V34NIjy7ca24dMmAZuRmAj7EzlA//9ASK7rJkYusa/p3fh5b/?=
 =?Windows-1252?Q?Zwa2CIfIw0Ux0iLmtR5zDGeQgI5c3Ts5sJyAfuKs/F6wHnGZziMEUpRj?=
 =?Windows-1252?Q?6pFLGkerIBI7UOTXjKICLssHj1Jbpl3kVNB4Fg/NSEh5GbEeIOYsfYdr?=
 =?Windows-1252?Q?ZmsHGVge6ezCLmHH8NZlGP25K5os1GBGejK3yO0GMQEI5sbxc32CkTy1?=
 =?Windows-1252?Q?uGV8KXcMgvsD3XqkROLEdNyh4e2MmHp76xNLYmLUhFJIlwtY61cC4vSQ?=
 =?Windows-1252?Q?gRVX/RPK4WeFrILNM83wm0Q6iNKCjAGbbllilyUuQ2lHvzKhDhSO1fKw?=
 =?Windows-1252?Q?smODTaIPrtXVaf48nqqm+FofprdBYLAJSUbFKm2iZuCROBKBhBDHgG78?=
 =?Windows-1252?Q?qqG/4kWUr+4hg8PV9ceQ9Q3vDGLo6EcMiCxfJlRDTMeDvS/L3HTenTf6?=
 =?Windows-1252?Q?5WVMkMKQzHe66XaznY/TZhGXe+lQ/A18LUl0vTk9YIBRZcmtkOywrubW?=
 =?Windows-1252?Q?6yhhllkMEPIXo40GEAeRv/T4FgsUSIEW4Mk2/a6A2jJ4zzOFBA82I6BU?=
 =?Windows-1252?Q?ElBRCYGnfYaqSH6JkIo+ATJzPH893RMJxFBm/FBsTussrFkNIa1pJ2Md?=
 =?Windows-1252?Q?qR4MFYmZtI51EJ4Ys+r/VNwwwcw8isyPZFeXURKOYV2/Es57LT3IjgwQ?=
 =?Windows-1252?Q?ArDxzTJbiml5Lha44M/7AbEsjqqVhO2mfSlFfzS/yOE0f9wN5OZXFUi8?=
 =?Windows-1252?Q?LOcQArNfu8Lsq74PrUoW14Yp62IWMjBiW0xyZyG5PA+zpvRWJRAoUf8I?=
 =?Windows-1252?Q?cVaZ8KMG+N8Kdz7pCs6T3y+AV8adp8/akMiGltMyGLQ+1Gqw5S2nJo4J?=
 =?Windows-1252?Q?LPK+MIvLTOovWrAwZdKtF1N0hjUu+sXkZrrTAMgPIBVZtVTRVAilWBpz?=
 =?Windows-1252?Q?EZQ8hEabTJyWzT0sH2c+fHrFWqRwlE7jX3wTbbvJ34K/bU7JpN4P3Z8A?=
 =?Windows-1252?Q?OyNwsM8dvfQEqIXQ0vtfRlEFbcIrxz5D7CcSgWV9dKpGrst46jrjiF8A?=
 =?Windows-1252?Q?p4Od32PMaWjq/589pntOM19BGcjVFTKzu2YsfT6oYOxwSZvUXMlhNQs6?=
 =?Windows-1252?Q?L1HZDb3fOvtX6npH6zIUyZqZCzmy37ddGHPgCD41n/TZ31+NNztdr8mL?=
 =?Windows-1252?Q?gSa4IrJ5H1HzY1/MXbuM/eREO8POPFT7IumJem8kz7fySmhywtca33dl?=
 =?Windows-1252?Q?P4Op3z72YgzZvBsHbewDzEJjOT6xczIdix2kiuXvpXLUvuG+X1vt1mcL?=
 =?Windows-1252?Q?7q8SpYZuCdZcVyptQ6mmxL2lDW34yYvCHDvPaRNQ3GsKvi82YHCuB7iJ?=
 =?Windows-1252?Q?F4RFdOaNbkLqH10+hCoHSnx6EkHHiEQnyO0ow+ijjvveCvDi1PPd8BBl?=
 =?Windows-1252?Q?I2sFGNXH/dweniu13ueTEEyQdacsWcxpAR5p9TN0L3Os6elX3oz0q1B7?=
 =?Windows-1252?Q?itrWAxXxexREpMle54ytqzVTtEb9qEFcUPNwinXx+IIQVGpE7ocMSo/7?=
 =?Windows-1252?Q?cunwQ2LGQkFmREe9trL3XIbrF/OSS7poAWqa6Uyzq5XuEttsQeDUTVU0?=
 =?Windows-1252?Q?0DmFuxhSGaMP2k/VwGYntqKpYABnS4pJya2r/Nlx3KkAB78pSokdON7A?=
 =?Windows-1252?Q?XWdJV7fPkIOd9VqHq08YJFDis6dd7WZCDARUZFq/068GVQ26KNIIJP6K?=
 =?Windows-1252?Q?33MPUHByHI89qub8Bo7xdXLYflV3aDB40km0ct9JNdhGyeU/5NhEGtvK?=
 =?Windows-1252?Q?osIOSStHVdQiymibTNYEamFbmB6OiHcM82Y5dq2Wtc3YOCCb86nxVZas?=
 =?Windows-1252?Q?giDYbu0VugfS1w=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1adbde-d6aa-4cbc-eae9-08de8ae35eed
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 02:57:08.7730 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3SxVTHjp3qbfRA9yAorfkJd2NSLFqpg8gKBT7jRcUo88o4tUiv9Wq7ZWZbmUl0f2VS2pk8turaPSceiJfgK2sEcRiLNKkdhQPNZKqPkYlC4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR03MB7763
X-Mailman-Approved-At: Thu, 26 Mar 2026 05:56:26 +0100
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Michael,


________________________________
From: Tom Rini
Sent: Wednesday, March 4, 2026 10:39 PM
To: MANIYAM, DINESH
Cc: u-boot@lists.denx.de; Marek Vasut; Simon Goldschmidt; Dario Binacchi; M=
ichael Trimarchi; Richard Genoud; James Hilliard; Miquel Raynal; Chee, Tien=
 Fong; Hea, Kok Kiang; NG, BOON KHAI; YUSLAIMI, ALIF ZAKUAN
Subject: Re: [PATCH 1/2] mtd: nand: raw: Kconfig: clean up SPL Cadence NAND=
 dependencies

On Wed, Mar 04, 2026 at 11:24:40AM +0800, dinesh.maniyam@altera.com wrote:

> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>
> Fix and align Kconfig dependencies for Cadence NAND in SPL.
> Move SPL-specific selects to SPL_NAND_CADENCE and remove them from the
> non-SPL NAND_CADENCE option. This avoids incorrect symbol selection and
> keeps SPL Cadence NAND support self-contained.
>
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--
Tom

This patch has been reviewed by Tom Rini.
When you have a chance, could you please take a look?
If there are no further concerns, I=92d appreciate your consideration for m=
erging.
Thanks for your time.

