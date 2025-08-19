Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD27CA0EEB
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 03:50:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A1E68006D;
	Tue, 19 Aug 2025 05:50:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="kX6GTuvJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67B3E802C1; Tue, 19 Aug 2025 05:49:59 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::626])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29ED180050
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 05:49:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y5dBJDeaKt3/xkRdea9XMscFbY3zec86wVAysRER6p5qzwfRvWGMhzvSua+IpZPGoE8dSG++BAUw23m8N5C4If8qLo3uscqwIcQc7jZueL1XUDlVZ5pFalUSePJEAJE/e49aLgHOKlW+fIuXgWmTh1QkKv7i6V0YRRIVGyoy5LCX39AY6xIVgSxxUBW+UVu0ffBgEWOwhDzqtpSMEhTF7ZlupNrUqvPqU2WAeGBdfQnPxUM9L0VqUtxDmYyIad3eWeF5c4hth+VdMHnMmdimbS37WKGiutWRu49F4Wl1Ex4k1c4GleNmYqxDYBwiMKul4qBOtQ0ArDcd8MN6GsVE7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uo26GOCy9xpgA6f96MbfIjqYIidBQtKYmv8HPBkdAFw=;
 b=SAe6cpJ4dk0PfzqQFaRt+9awKIhZYG6vnBE7mmktgkSMF83/4aNaBkJ+WtA6g/qDSdJBTR7VceMTos95l057Z9e/XIzq34XEbuxf9R2oZVoln0Pnp8JBMBF2wkyFnLcejnjGbAOFvCJNFYbRtXieCvc5KALxYxtXRq+BONBaDEfy9aMU3h+uj9F/mtTIB/RudJLs+rMZ8xW9ReK2lIYruRCXLUZHFDSkpDMVXrPhQCFgKhb/LGQI5T7nHO3QSSGaK/LyspbFYVXxVPoSi2J4uAy4oU3PUbzs7MWyQ2rqaawVr4pJWKJ6ZtiZnpFiDdAIa7CQ0iBOnPg6tLfuKgYDYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uo26GOCy9xpgA6f96MbfIjqYIidBQtKYmv8HPBkdAFw=;
 b=kX6GTuvJ/XtDK8XMvZelWUAf4QWhw7zvcvdz/SldilMxY/pOIc34nt3IogUdZ+HyFRiRak0acVz8Q9BsM6/2tV7H0jQGLqIQqOqwvF9rHRSNscaKvnVWPAtwgTBHo1DIWWQ+4pNG/9jZENJq934vn3FAnG89REzAiPcbjsrT1WX5wRhScmcagp00SQMBNhbVMiy5cDCpbT1OLOiQpKmK7GLesktKKnZ5dzt+3c/Ppf8r6eee92F+RUPKuGEhQiB7PtMJiw4TooS3oBg7LP4j4Bkn+nVhZe+xcKaaynmRaDcktn1LV75nNbDwrH5AouYXM35ylKLBWY0kgILNAx5A3Q==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by DS7PR03MB5416.namprd03.prod.outlook.com (2603:10b6:5:2c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Tue, 19 Aug
 2025 03:49:50 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 03:49:50 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH] drivers: ddr: altera: Check IOSSM mailbox compatibility
Thread-Topic: [PATCH] drivers: ddr: altera: Check IOSSM mailbox compatibility
Thread-Index: AQHcCEgDb0l3F9YBjEqHCFNOVw+EKbRpaACQ
Date: Tue, 19 Aug 2025 03:49:49 +0000
Message-ID: <LV8PR03MB81371EB9C014099699A870BBA730A@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250808093659.23144-1-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250808093659.23144-1-nareshkumar.ravulapalli@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|DS7PR03MB5416:EE_
x-ms-office365-filtering-correlation-id: 3fdd531f-6ea8-4317-389a-08ddded372bd
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?COamku9/DDqD/U1B5R2DQq+bBX/eM6UNX6Y0HhKcX6oh2In5VO0idsLCvK2w?=
 =?us-ascii?Q?xdHeGGCYze44jMmXad1Iu3ep46RE369GfjtB6lytyvgHZZ5vwtO5rV08lEsh?=
 =?us-ascii?Q?f2yxThZ4PeCCz305OxGE4X1yesQveHJPAmX7+ifOuxBDjNlkjlSZOf97XJPq?=
 =?us-ascii?Q?6gvllQ4ijMCRiihW5vLlVI1ifAlje2Y8/+hnxspEafZSRkUuw4SkvEuTWJln?=
 =?us-ascii?Q?ZydQ9w9thpxgV8MZnrfXt9NeTzm3KwFCbJnb3c+YEAF+ixzwzSge4ALtbOcY?=
 =?us-ascii?Q?NArcrgRSbe4SF+q8T+OOl7T2gJOoxBwMRXt3TuL5m/I9xKl4QowRN38wVPtA?=
 =?us-ascii?Q?p2eWW2AgXyF+9o8l1vuAaGTU8RUmVsq9lxv+9XWmHQIIGInXTe6qO2sAo/2C?=
 =?us-ascii?Q?sC5MlW4E5cWjK2y/NjQEvzb3l/fMZig2vJVkAAwsH/yBU6R8LIhK8bSvUv7H?=
 =?us-ascii?Q?SCZkZJnursmfPY3Lm5EY3/jxvaQMsPCHDB5lXair+fbvj8Yc5RENbwlElCeA?=
 =?us-ascii?Q?xq1FSUmGshw395wAAiqY8vy+b9zxb+s1UUBGAazteMvy0MHg33sD2MwSQVnD?=
 =?us-ascii?Q?/Ngh9Sce6/B9I2B7ckfeSzpxeCXcsNgoRejmo/KIlxavsE9lazI/7zSEPKIF?=
 =?us-ascii?Q?Zlw/MNGO+fTtJmJA+vt9G9eRvWRGEvUlEnZpZNCGqcOhbizmkw2iS0q9Z/ac?=
 =?us-ascii?Q?GzRiEHcIy5GJrJIyep9K5hvmSwNwahoq1VUVe2I+HvDVuZABDz7gIN5SB/JK?=
 =?us-ascii?Q?TizhC2ySURqjxD7hAhGirr3K7/R3+cvQOK27B5Uu7kBOdEXyTuTvzDd+Nfod?=
 =?us-ascii?Q?rzStzQUzjkg1EqZS+bv5vdY1ZV9yoLsL0Lx0LzyXMNLmVCsYyDtgHj0sw8Y3?=
 =?us-ascii?Q?wGdadCF418zctCq3iZS9R0yVz2OJogXDzLbUxsexuvMInreqLy+6vI8GGQXr?=
 =?us-ascii?Q?F2dcrTGTP8n0VpC/9dtuhA7Knxr3FDt59R9+YbDa8AwTQALJBePh5bY2b78j?=
 =?us-ascii?Q?n+bB5RoEU0k4CFgex3YaieO48xHl6cZ+Eb2NYrI44zMYiT8tBGiZh1i4SW7C?=
 =?us-ascii?Q?yD9k9hqwaz/oBGsG9WaUb4XN2JVDkEABqvwuUAhS1gSh6b8q+ltFz4UdDGqm?=
 =?us-ascii?Q?VcDBYxLbIAkA4af8q/H1AQMmJneumI5p86ho3HOJ/PexKs7NRkjZnEYPNACh?=
 =?us-ascii?Q?KqbUSqBNEQAN401keNfs5gr42sNF2qqfwB940AoH6xuyILGPmPNAHfHrm+37?=
 =?us-ascii?Q?vTbl779J8khRMvD82RYp4UyQaH+I+MOKONJRQ7dz5cL3+RhzyoQZxUeWoksO?=
 =?us-ascii?Q?VnGxnnDtonBVf3hIFfMxW8fgE6ps39HzBNnL6XTva50aq82eCV4aQHWiHsjS?=
 =?us-ascii?Q?tcdCcctbjmttAK7NobpWPQMpLLr04RKMD4RWs9SCycmHsAtyxGKf3MC3Q2/i?=
 =?us-ascii?Q?znJk3QXbFMbr5OPp2hVRABmc+5Lz8Se73qaV2olyqXje5qtT4NM6uX+NiMDp?=
 =?us-ascii?Q?1LBBfAGqSOcWI+Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fmuF7IvxuMadJz6b+5HczTGHZQGRlao2ty0OhP9T1BIJRfAshK59QO4gr3Ns?=
 =?us-ascii?Q?UZnkgvDhy+QqqKF9Oaq7ZME22WDihkTPEysSfiput8Sp5nPLSKlb27KwxyGD?=
 =?us-ascii?Q?uUNrUn0P5obw1MmoBw1lEyNZkZruns30MOpxPWNmjBQysZoeCoW/XZucx1VN?=
 =?us-ascii?Q?iPUAtwyHyp8lPj1Jf3oFmVgoK7rxZ2fgJqzzQIgqK2KszswEmane66SWpKCa?=
 =?us-ascii?Q?hAGa3ItGV8PkqsR0dLVk9KHNwun1eO2urA+fqKoaOfPW8c5ittbyDnKLDW4k?=
 =?us-ascii?Q?J7bIaimhmjzX7K7/tlg6cL1km/Ms22XyU59J/Dnqw9H8JBcMafaSiGx6K1sK?=
 =?us-ascii?Q?YuhQIgI0Jrx8+W4girAWZDzA3N06IgOp9IgQAkbnYZXcGQcuEfQCaPKkMOR7?=
 =?us-ascii?Q?QSsU6W1gY9M88WgsdMO+cmWEfgQG1BD2CbtwVMSd90S6gIXTy/TFN3B/HMjO?=
 =?us-ascii?Q?A6GBQOhQt1NmNjhh9KsW4MEP9s26l41UBv7qvk7l8kRKmNn6sG713KZPeYKX?=
 =?us-ascii?Q?yz53NHmwLZ5DGlPi8DQL5bkKcRpiGVJNctqThDoDixfFjFWA4/7xsGXOxaVe?=
 =?us-ascii?Q?n2q90l/9lDmb7Excl9ucAbA/TMCbnkjMFjsNIO6rtb2qvZRguBn8zdMx86/Y?=
 =?us-ascii?Q?SlsRmXAVVdtfH/AJIITf8diWcBrwh9cjlDcOjgJUid2Ab2P8HgC5wbiEIk9I?=
 =?us-ascii?Q?gcERTLUjcyH8ymEeqIWgKYnSC1J3gXQ1dBqyuGLnyuG7BSdKE0IE6P5PSCzg?=
 =?us-ascii?Q?od4axORam9MLT5z6v4QsgdL1NE3YMnfL6QWRjkZqCHaUjl0YRVfhGTdbvmsU?=
 =?us-ascii?Q?4RXIRudZv1+WEmCxPS6Z9Lt4hkoXtSokd6/rITAi8Iw1yjTTdrauY9J/7cJ0?=
 =?us-ascii?Q?hLFfqox4jukdwnrbpQEH5cTBVDHSIpljjWfQ+BBnYUWx+QELpLFboZ6G8RG2?=
 =?us-ascii?Q?zk1R76yghchcK3nMzwEMJWlBbz9uiVKZtL6oLZYVvsfHd/w6wwhFGN/y1yYZ?=
 =?us-ascii?Q?PbxQGWF5t4aDfL0FgZy5tGnkqn/HslwU1aGubbasArACwYmNRvrw0MxNB0Sa?=
 =?us-ascii?Q?OmK00SUENRa2RB+Cwe8cFMzVBUetJ+VG+BRNlRJld+FcDzz3bQxy1ULp5bYM?=
 =?us-ascii?Q?xxujw7pclTRZ3hi+AFS/Fl5mWfWnT0KvDM14laccZbbTrhiio4gaRqlEsfSX?=
 =?us-ascii?Q?Pyw4QjKq434clsYz/8dEdVywJcJrr59Ucjj1Cb/yyfxKfdnszrvYI4JGxwgw?=
 =?us-ascii?Q?++j8N3AAeOjqaBeAByo4OIqy+nnHSABMhoKHQksVdRTsUNqp1OJuTkw6E2bn?=
 =?us-ascii?Q?X31ymStmCnY/HwKP8dbijwReH1ypbj4A49zfq7svfZArZ1eNskuKwqFSkdg6?=
 =?us-ascii?Q?VDt2DWg+sha+RftAPKmDGeo60HBO/4sfkvWJ09I3rMbe3ZmYQiTQ2ztHIpu4?=
 =?us-ascii?Q?AQSgGs6DbG5D6qbfMmOkHYPp2+YGxFa1o8ppAMMvyi/67K+zPgm3Lop7Xd3r?=
 =?us-ascii?Q?Lh4owIYtUin36XyczWhSRFviEmSh9gXnJP1loNdsBjV7e6wNGwj/krWi6fn0?=
 =?us-ascii?Q?0++soJsoELonKDQRw0cF8srcZvdZr76jwgPPBV4W?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fdd531f-6ea8-4317-389a-08ddded372bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 03:49:50.0801 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kSAFq5N1ELAIpJT+KEAK90A+VSV/U05mPY6F3XTAlpwTBUCVY/c1Sxn/hrkm+LBZD2J/24roXOv0unlgsm4T1QumMBVcjvvJsEa61CX8I7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5416
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



> -----Original Message-----
> From: Ravulapalli, Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Sent: Friday, August 8, 2025 5:37 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Tom Rini <trini@konsulko.com>; Ravulapalli,
> Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Subject: [PATCH] drivers: ddr: altera: Check IOSSM mailbox compatibility
>=20
> Compatibility check of IOSSM mailbox with U-Boot is performed by verifyin=
g
> the mailbox specification version. If check fails, appropriate error mess=
age is
> displayed.
>=20
> Signed-off-by: Naresh Kumar Ravulapalli
> <nareshkumar.ravulapalli@altera.com>
> ---
>  drivers/ddr/altera/iossm_mailbox.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/drivers/ddr/altera/iossm_mailbox.c
> b/drivers/ddr/altera/iossm_mailbox.c
> index 21f94959a04..2a2f86a650e 100644
> --- a/drivers/ddr/altera/iossm_mailbox.c
> +++ b/drivers/ddr/altera/iossm_mailbox.c
> @@ -38,6 +38,8 @@
>  #define IOSSM_STATUS_CMD_RESPONSE_ERROR(n)
> 	FIELD_GET(IOSSM_STATUS_CMD_RESPONSE_ERROR_MASK, n)
>  #define IOSSM_STATUS_GENERAL_ERROR_MASK		GENMASK(4,
> 1)
>  #define IOSSM_STATUS_GENERAL_ERROR(n)
> 	FIELD_GET(IOSSM_STATUS_GENERAL_ERROR_MASK, n)
> +#define IOSSM_MAILBOX_SPEC_VERSION_MASK		GENMASK(2,
> 0)
> +#define IOSSM_MAILBOX_SPEC_VERSION(n)
> 	FIELD_GET(IOSSM_MAILBOX_SPEC_VERSION_MASK, n)
>=20
>  /* Offset of Mailbox Read-only Registers  */
>  #define IOSSM_MAILBOX_HEADER_OFFSET			0x0
> @@ -383,6 +385,23 @@ err:
>  	return ret;
>  }
>=20
> +static bool is_mailbox_spec_compatible(struct io96b_info *io96b_ctrl) {
> +	u32 mailbox_header;
> +	u8 mailbox_spec_ver;
> +
> +	mailbox_header =3D readl(io96b_ctrl->io96b[0].io96b_csr_addr +
> +				IOSSM_MAILBOX_HEADER_OFFSET);
> +	mailbox_spec_ver =3D
> IOSSM_MAILBOX_SPEC_VERSION(mailbox_header);
> +	printf("%s: IOSSM mailbox version: %d\n", __func__,
> mailbox_spec_ver);
> +
> +	/* for now there are two mailbox spec versions, 0 and 1; only version
> 1 is compatible */
> +	if (!mailbox_spec_ver)
> +		return false;
> +
> +	return true;
> +}
> +
>  /*
>   * Initial function to be called to set memory interface IP type and ins=
tance ID
>   * IP type and instance ID need to be determined before sending mailbox
> command @@ -392,6 +411,11 @@ void io96b_mb_init(struct io96b_info
> *io96b_ctrl)
>  	int i, j;
>  	u32 mem_intf_info_0, mem_intf_info_1;
>=20
> +	if (!is_mailbox_spec_compatible(io96b_ctrl)) {
> +		printf("DDR: Failed to get compatible mailbox version\n");
> +		hang();
> +	}
> +
>  	debug("%s: num_instance %d\n", __func__, io96b_ctrl-
> >num_instance);
>=20
>  	for (i =3D 0; i < io96b_ctrl->num_instance; i++) {
> --
> 2.35.3

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

