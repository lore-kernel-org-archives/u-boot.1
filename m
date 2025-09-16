Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D9B0CAC599
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 01:47:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B93381E13;
	Tue, 16 Sep 2025 03:47:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="e7ah+Ig2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60C4E82C84; Tue, 16 Sep 2025 03:47:49 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 610F480B9B
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 03:47:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3BWmfGCWjOIKXTgGvq559NuXaHajQk1zW9J2xU9FJk8UMtd8GOBD1aSUsCfr60kMCSAiF13+QN4zq2Wk8pGNDwgFi5vpr6mGGbusVfbG7DJnpmxamE9X15DShUnwQoVUddD/2fSMNSaTH7wDuXjndBQTHr4mxPUHDJh90XdltWiQ4IawgonE81Vl0016Ig28NE5NycB4LfAJMhBQE5vILOQ8e3cxfGupZ1p6j9V3iU9Z/vtZfZPQc6IOZAaSGI07VkRBc3xPEwdw7LKSQ+IBMNb2lJnRzkcsKpkYOUz1RGN9u9GY3DFxVccokOCUnUAhJ9a/J8c3u/d+n1Ny1L6zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ki2a1CsthCUooa/g/QTRygRNLm+O1EdhBrH7/jOaqnY=;
 b=qm4ZcO+STFYaRSU4Q9+r0WK9TU19BPW0p1PSO7L6dzKZHl+8Q9d5ohtwutyRX3Vmm+TwCOtEqPk6Q6ZlMWJf6LnnYdq92dsmxftp+Soh5x2yq1Os1/TW6ZSrKrXS7fuxkV47PyLJ7BI4OrJZVK0i75+MNNSJOhch1FFIg8UByZvnHs1ttvEUGqzEP3MJUYltJBb96mJI+M8n8GsUiui9IORgdzeKHGyxf8jCoflUWJrymVwBcOMHxpsTaS/f+D871dISVa7YTzDmh8fX013HmsdY9Hb7gXZfILC6h1K75b3O2EAiXFqrEQeLs/5BLIsYyOEqVVdGoMR0pD+OdDqFLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ki2a1CsthCUooa/g/QTRygRNLm+O1EdhBrH7/jOaqnY=;
 b=e7ah+Ig2HQxMXLxuxJWQhbjIDbwk65KGAd+N8AHUehyyvxCu/kRkYDqKT8Kvs3fGWUJ5uKS4echx+386uOHoSFgovGH36y5Bin8Gejw1cx4nUlZvNHyEqjnLOkAIHmlNe9FpFUUTMgSD1J69CJv7TFepePbQXI9e7bBtOLwjqNpCSNctZUf7SZDfLKwFYPlPfdqsC/7fYdqC1Hnnbjfm0LieTRBB665psj31xW6u/pfhLXvflb4Qf49D4j/jfxmMeAP7Zg+Xe+HnhwhQ8mDxVbDigDQMxhKxePgqb4Qmr+cHCH1wj6ED1AjXPc4vrtXotU6F9kX8xx93L/CPK0+ryw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10173.eurprd04.prod.outlook.com (2603:10a6:800:245::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Tue, 16 Sep
 2025 01:47:45 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9137.010; Tue, 16 Sep 2025
 01:47:45 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Tom Rini <trini@konsulko.com>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, Fabio Estevam <festevam@gmail.com>
CC: Jaehoon Chung <jh80.chung@samsung.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: RE: [PATCH] power: pfuze100: Ensure loop index is incremented
Thread-Topic: [PATCH] power: pfuze100: Ensure loop index is incremented
Thread-Index: AQHcJmaLPTcXWdp5Mk+caKsgTTOX2bSVCrZA
Date: Tue, 16 Sep 2025 01:47:45 +0000
Message-ID: <PAXPR04MB8459795961A285AB9AD20FE18814A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250703-pfuze100_fix-v1-1-5f838e29d122@linaro.org>
 <20250831153513.GA2800031@bill-the-cat>
 <20250913155154.GF124814@bill-the-cat>
 <cf91c8fe-a264-4db3-990b-b866a42d17a1@linaro.org>
 <20250915173109.GL124814@bill-the-cat>
In-Reply-To: <20250915173109.GL124814@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VI0PR04MB10173:EE_
x-ms-office365-filtering-correlation-id: 43d04d9b-8439-4ae2-57c4-08ddf4c3089e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ITx5jAj00eoG881LJ4IjIy4uX10X1KWpcRb6bRxPjgu26u87bG6nqlDtFRvK?=
 =?us-ascii?Q?ZegUQP17t+2BD1lCTLbrHZ4XLfbWlOoIRRuV3N3tPyO6HbavWHpTZglqNeWy?=
 =?us-ascii?Q?M/pucW6kQmbwVDM9YRW52Ii0Qh8YhAL/S3BjIxcZi8UU+rysowKn3VIj+BGZ?=
 =?us-ascii?Q?cZkkGQmLOv418l5CBPFsZYD4+KZDM3msF70uz8LjACDztDff+b2G03HMB9qz?=
 =?us-ascii?Q?ztjq55o28OHuxY8ZHf3Q2PWau9sIdz8pxSKEqU0m0ltoHemz2PKCD7NBIeEn?=
 =?us-ascii?Q?TAv7/oKn+k8CYwiNMMXTMPHkc0Zwpma4o82CYRrQpKBUwlSetxf4IqbDi1SB?=
 =?us-ascii?Q?2wepoDWJFmt76nXmAik0441lJ1wFMpEqDssDVnqRYA7Pft8f4Bn2m7u/VQe+?=
 =?us-ascii?Q?Z/zYaFdTtjYa9IdzVM2jXf8we6eJRf6Po7p/wgFSXFHJtgCSa5eesjLGe9cZ?=
 =?us-ascii?Q?s0vmH/DWwMe6UT5wPtzgBpjuocIrsF2r3YopZfc9GSy+NgHqe40bCLQ30JAc?=
 =?us-ascii?Q?QkXVwVfwxzR3wCxFXfU+R/Kcbdv8Lm/SAW986oOMs/UsFklM8tboj5Am5Avz?=
 =?us-ascii?Q?82V9QSO98/jUNGD2RycPLEvjWz9SlIxGfItrt+JbqbbGXEBDVbs9KvrJwFfC?=
 =?us-ascii?Q?kpUEaYM/dglqLZHIdYeCMlMSOwTO5C6fbiAxKWjtke2UDcCwkshKrdRpg6r2?=
 =?us-ascii?Q?q/LuLP320I60OqBY9mj7Xv7qBFIFcp/0SBYYfXqPlAqNHGzWst567iSfLeFR?=
 =?us-ascii?Q?DBoYMF+4KQOIxl43S32S/XW32V6NXpPC5mbolmWb3JfHNSx9yftF3ECEuzWI?=
 =?us-ascii?Q?ywhiF8dWDGRoUGogLBqmOnCREsW6Wn7Mgh+6Wi34UpgiQuq1lvs+iH2En25o?=
 =?us-ascii?Q?yYLJ+jbOFt0QKVO8CwpT0k3VZc3b3E1vMd3ySNlFrYyA5DOjDMeuTiN+wkQ+?=
 =?us-ascii?Q?+k7Kq1SC2cidYYtkEJ5ZZyNKgmjASFBRHGFPKnLoPeIF5UNxJTuS32Mr8+UR?=
 =?us-ascii?Q?H2/0k3z8SyMrnO1vuJfH4i89jYKCmezGHXmigLAanM25OYYxTT2oZsFqf1Oc?=
 =?us-ascii?Q?zXUjUymluH79YKwv2lx4dyiKxL9JarGhrJUb8AUsSZUHRF1wswylp94mMitE?=
 =?us-ascii?Q?OPkPiUNWYTlNtj58pCYA+2qsQaOdqMIXWE6pswmFO7FVhNzXrsWqEk1UKiRk?=
 =?us-ascii?Q?T6FRvJUjW4IzCU5FdDiZUXMUQl1N0SNehE7KzFMO3Tsz0NIPsNwh796ov48V?=
 =?us-ascii?Q?sN2AWLlzzE+qcjAyMdJHNOhVdphcXIjlY8xK8jazIqdFdYHgXnHp0I+64z7z?=
 =?us-ascii?Q?LlXiGnvE79AkBV/u7nyyGFSD71KAV83ugOPOsiNtrGW8bqY3FtNeU/qfLaun?=
 =?us-ascii?Q?eyQ8JzmN77xH1oikFYjBbkHiWTqOdyq0Z48CQk3v/5To8LpYjJk4pmbccQIp?=
 =?us-ascii?Q?twkWLvhMXm34p88KBReWekFsJPB3MuBXp7kTmfzHcx1gnSJzJJbb4w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Eup52mE41hjoCq3URMYT8nm7Gv0wyFRVkKEb8lE+heRsMD6fL7LnyfJ/WMJE?=
 =?us-ascii?Q?1tBI5E80WDNxn8xAodoIZpsHIYJuTSUV8IHRRgkdLLWueAIQVkD1HzAtd5tC?=
 =?us-ascii?Q?SK8JZTiUu69YFrKyuo2vdqs+sLZVd/kNIvaRshX/XUxgKMv3VTDtCCTUh8Xl?=
 =?us-ascii?Q?GGdw/+ey5RHB6QHM0EIBhGxt0scSfOBzlhLDxN9i433Ir1EwcPmhkNzh/v57?=
 =?us-ascii?Q?zO6urKvCqwxDlfNs6bC3ZDCDuvzCwHS7MPwHRZqpAoDzPygyL/zMjbyx9g6Q?=
 =?us-ascii?Q?KYl5rb/e3kOKUrUpz6UgMKuaGJEYhhJbPHkwieqD3saLCMDKws+YvbUZX6PC?=
 =?us-ascii?Q?w3Rw6mDK/c1Zg/+MwoIJkwSlqmpPsIDOauj520dzdb7sLvnqseeBE8M8NKF3?=
 =?us-ascii?Q?OYb0F7mNuGzJ++oIwCm9axvTfKhtg4MKn/B+f4sCewk5+dlpu5ODCmgd1/uh?=
 =?us-ascii?Q?0JvcJHpz9sjFz1A7+dBjQLg7Bl/PMdiudESrP9ui1AmW0+VTMoVfN1pQlNuc?=
 =?us-ascii?Q?nWLKjkOaBD9tDAmGH2JHR/7PIo6d1s8cfXyN2ypeBKBzQDS+9/5cISKKUa3e?=
 =?us-ascii?Q?SxVdY+zuGmqU4RulYVycrYE5U3FhRV66oHIrQiVWkvrKyfS0Jj88WB+g+rnf?=
 =?us-ascii?Q?K4DQG1dOz3GW57YUiXmigFQZA1wcMYQrgWbv9Q8Rebsz+N08U/a//73eInky?=
 =?us-ascii?Q?f05C1RdTv9ldHCG62UwJC9JW+HA0Ur0u1iS4WfT7FdGCQ7p649FcFirRGDc1?=
 =?us-ascii?Q?mj1hpOyNG1CbXHZnZkehhBYspnAtAlenydBfrpfuDhk73Ak5powtm2uW4atf?=
 =?us-ascii?Q?GWBJxVnHIH/zRnNXB2rc2LHJ71hf8/Ii/Cvcj2rMdQkzoxeJjeMYhJePqt9w?=
 =?us-ascii?Q?bbT4awS4DuUgxoZNtbCHd1/H9AeM4ydm+qsNSQOp8Z5NvZVOjBhVT4wXHvBS?=
 =?us-ascii?Q?SKX5Y3Raia5Y6T1Mr1ElSJcczLlQgnKQ2PPfqz0s/9Y9Qt2I58gpVmGfhTY+?=
 =?us-ascii?Q?U9srbC5s12Pa6rTstsq3VDDtVDUDXmRLztEBOymr7h44WnEVQ43m9KiZ1CEw?=
 =?us-ascii?Q?lYKVXGe2HZLD4l4rhDb63uR2NEaBCr7LOWVn68x1F02Aoye6oMyALs4x6tlB?=
 =?us-ascii?Q?LAL1HAfy+lnsrtCzCUFy91Y/O6YpCt6GCIpX+r/6sg+M/FJLDfKhK6nFIz2d?=
 =?us-ascii?Q?sGnH5G4eFV3DiDQqqJP5XzT7r24DiKjXfSjTmEhRm77S7ENB+TKUM6yIAG1d?=
 =?us-ascii?Q?6ymxOZCx+uFGcSuZKEN3/KbffYkjn3E53uIyorN4rcyPwsMaR+eFpn0u9wW0?=
 =?us-ascii?Q?JV4ov+lin6mDCnA9wPZRU+evzIBzJPHk94PP+v8gzIEBtPiZVNt16Ts0vufe?=
 =?us-ascii?Q?UPgVJl5+u8O5fzZXeMNJbGXrYd34hAIfnby1jDPqa7fhNEzzyjiUfNEOnU4g?=
 =?us-ascii?Q?EZquOf+wPvzT6j2hlH9/4LpO51fPCUYKQluFz0o7wRuPgzX50KAGYe+at2bt?=
 =?us-ascii?Q?cMpqUQA03OS3u3Ir1It+U+FOT87sap7uA7w/j1qadx8uDWURIQYGYzZe6AvD?=
 =?us-ascii?Q?RamM3CfaxGLgnLSXIcg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43d04d9b-8439-4ae2-57c4-08ddf4c3089e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2025 01:47:45.6684 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q4s3MYk0UH55O0evuatYnNK2PNKSd7WxwUaX6ZAEYBkF8Em/CnmB4AY5SFYSVfB2gPMoiJpZknkCCPWeY7F5/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10173
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

> Subject: Re: [PATCH] power: pfuze100: Ensure loop index is
> incremented
>=20
> Sorry for being unclear. The original patch isn't right I think, the size
> change leads me to believe that we're changing the loop behavior.
> Looking harder at the code in question, it seems like it's an odd way to
> iterate over every element in the array ('i' isn't used, we just incremen=
t
> desc and quite possibly don't handle failure to find a match correctly?).
> I think the best path is reworking the code a bit, but no, I don't have
> the time to. If you don't have time to, perhaps Fabio or Peng can?

I just post a patch, please see whether it is good for you.

Thanks,
Peng.

>=20
> --
> Tom
