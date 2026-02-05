Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D23D9EC1EB0
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 13:05:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 209B98341A;
	Thu,  5 Feb 2026 14:05:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="TF1E2Lgf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADA618341A; Thu,  5 Feb 2026 10:50:44 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75C3A83A5A
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 10:50:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mCqvlEPNV8WRTAUvPtedqdr0Llwktsm0atJFzgZrgyq4CbWuQWLimXqMGcKgP0lUCjkEpSMxZxKTIXxhEdlwrExp9qyZjsJwnMC6E6IKeL1cAXMPn8B20OxVvPNvcYjYWyGU/ufrNx3IBRVcRsBQVMx8207dm1g4UhzC44wgUs87nsUJwVMZfouFRK5kLXhDJYow9Pz2lrwTw6BpyD0mtbebBlPXBgBnItDXda5hEu/dKNWrjxMl0HI8ps8knF+vIWuMdP6FRjcwhbRq3t8WuZEDwRROhTJKmUqaMaOnotPs1zoX2ESVGOyqFh/4fOTeEHu4QBHKnMpWblmVG833rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyMdXFw8c1XOHfo4uEOXQcZFor1OV/rKKahjyu9iSL8=;
 b=RKGyqDt1HDvvvIc+7zupCKlMbUh/wwwDHUSKRg7Sp9mFC1Kf1LYsa0SYkgQ6yxCRQWyo/nQ/FgB0o7GN3buChABoUVMpSWSdHSGFw88hYhwq62Q5YSjIFL9sQOkBT+0yX4ZCi3lwmbWF2ALXDdU083j6hUslB/SUsxH38QYaq27fhFOWJJt63uV941K1oAp3hKceQgDqePPj4HraYZI+e1397TUyxaYFxFtbFLw202KON5tGT12Tyv4COol4Uq29yfqYZlqX7Nk/bAkJ3wDU4Y2izRJ7poE3Q+mtpqRX3VTTp1M41tOP/h0165l6W1qDAhORwbgYecAg0a0kxzL/cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyMdXFw8c1XOHfo4uEOXQcZFor1OV/rKKahjyu9iSL8=;
 b=TF1E2Lgf8WHXgRKOsBT+jQFVJwIV20DwzmYKvWz3/tf2MjGGiV2D7hDzPauXgLWus4F6scLrOXS/VWBQ/MkdE2C2Ot52p+8jtr0vzpc2gmeIZKe9XWEwI8cUWeLwk919aOnoEve8uUStVid+hDNqYXFfMSsDtpBetEj2vWec0e8sJ+osSVXEtvi/6R+d9oPM4t6536gMVOwvHGcRQivYcPaL9eLedd9ePX5ywy0cB20NBjILf0qvtJ+xC1XeS58T7AIvJjQs/af4SmaIjLRXlWpx1jWxm27awDwhn2O5zNJWpc2BqmrwpVJ6XixtCqjqsQF6eunqGkn6iDk/8SAN0w==
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by MN2PR03MB5150.namprd03.prod.outlook.com (2603:10b6:208:1ae::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 09:50:38 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%4]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 09:50:38 +0000
From: "Lok, Chen Huei" <chen.huei.lok@altera.com>
To: Peng Fan <peng.fan@oss.nxp.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Michal Simek
 <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, Alexander Dahl
 <ada@thorsis.com>, "Rosdi, Danish Ahmad" <danish.ahmad.rosdi@altera.com>,
 "Chee, Tien Fong" <tien.fong.chee@altera.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Maniyam, Dinesh"
 <dinesh.maniyam@altera.com>, "Ng, Boon Khai" <boon.khai.ng@altera.com>, "Hea, 
 Kok Kiang" <kok.kiang.hea@altera.com>
Subject: RE: [PATCH v1] drivers: fpga: Enable SOC64 support, remove
 Agilex/Stratix10 checks for FPGA bridge
Thread-Topic: [PATCH v1] drivers: fpga: Enable SOC64 support, remove
 Agilex/Stratix10 checks for FPGA bridge
Thread-Index: AQHclkMHx6Zj4UEAJ0OswRGHnR48q7VztbYAgAAi9BA=
Date: Thu, 5 Feb 2026 09:50:38 +0000
Message-ID: <IA3PR03MB80213BDE29FCA2D62A0401DBC399A@IA3PR03MB8021.namprd03.prod.outlook.com>
References: <20260205015823.11401-1-chen.huei.lok@altera.com>
 <aYRGxjjMEMo4BCEU@shlinux89>
In-Reply-To: <aYRGxjjMEMo4BCEU@shlinux89>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR03MB8021:EE_|MN2PR03MB5150:EE_
x-ms-office365-filtering-correlation-id: 431548d3-75e2-46d1-fadd-08de649c045b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|10070799003|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ZugjFsND25qtuMLZQiZoLBDc5d+s9y7aRm6oY2PqmM8oc/bPSpj7gCwShVtD?=
 =?us-ascii?Q?8naMDEP/QypWBpfewxbBA99/6CqqJVlpF2oGNbZ1qxrtS4q+NrhiSllAu5Hu?=
 =?us-ascii?Q?pQ2k7/tn8DZYsyg6pKi4PFqfqvB6VYMI/DvcmyBcCjyClnsOZgFPGKbnaWvw?=
 =?us-ascii?Q?IdQ80M3JMs7MAnJ6jCaldxJcClZ2PLknVOuN53QD09hgCwjFXMo8xyrpIDs+?=
 =?us-ascii?Q?n/2r/JceB0dLa8u/A7jyNdwsLwsPOxk3NPZZJgmP11jczP8OwYeWLXNyiz2Y?=
 =?us-ascii?Q?7Uec8xSFPFCBiPHxwZEYPpeUJ7qe6z9xM+0W1W/GCkgc5TMjk3mxlm+zMy+6?=
 =?us-ascii?Q?MtjylHav1ucnkeINVbC4Lma9lvRES7+8h2C/mIgXXYOYdqJtf34QEojE92Tk?=
 =?us-ascii?Q?11wST5C6zSLABWuHq6oIsiUDrS9Ue4pp0Uwl8pCt2bORdQvgy3fMYJDpo3hq?=
 =?us-ascii?Q?qEIQyAB2FEpLTrWa5qu7dmjH3ADw69fomrIYLsGk8mpvAwbVfMLzsLmLSvZp?=
 =?us-ascii?Q?RIyETZPLlKfd2fXYMm34DY0MhuIQS2pV1xsnM5kzeeVxaiw4C0LXWPds/Yn+?=
 =?us-ascii?Q?0Mdu3EWmicIYzTXrFRCCP7Tv6ivbrlouZc3Vl2iT8bNOASVh+c+OZ48cKzsq?=
 =?us-ascii?Q?ztWJr4AxUbvR+zOtttCYzlypZOA1Gu9/YD8J5fn5MwPwYV4UQ9cvyuO0bLxm?=
 =?us-ascii?Q?WA1vyqr5WFPoh5KRAJV2aT0iCNB3bMgu5oFcUyC6nGuubwSugcMhytdfNI+h?=
 =?us-ascii?Q?5nDyiLdGrYe56M6eFuFgpnbbGfsCNQI1I32kLworvbbIo9A5Ra9imHulJE8j?=
 =?us-ascii?Q?UWZav80gvTdZ51ebJyuSYQA1dR3n6YS/fexVQ+OM3pZuxv/nVNqfIB0thecz?=
 =?us-ascii?Q?8FecKxWWwTQbZBe4soQJ8m+kxXayZmc2aW5VHm5teuCb0eIzEJxoP2nz9p5e?=
 =?us-ascii?Q?sELOYihH+PuoIg74jSeVyklJUrVkZgxJtRFwcGk9GN+VnbUS9fpjlFFhh/0G?=
 =?us-ascii?Q?WSWX2t7T+NWnorxdbVz1DsZryMgISJJlAi2IIK4mT9k3yvIXp949yR/aalJ5?=
 =?us-ascii?Q?wgAsDSs0QeK3J78qHKqG5FoCvn5bKxhc18bmu9ofztTSJsK9QrgHD06I+gSW?=
 =?us-ascii?Q?fnu2TIloyLOPdcatGAtlX6p6Ob4IbIXYWahHnCEdvl+MbNWPUAkSqZdKofnj?=
 =?us-ascii?Q?opl1K+W4eDDiLCrAdwiy7zyFprfAn7FSRmVp2yJKLQ0mh69vHljR+QH+Xamn?=
 =?us-ascii?Q?fVVv8GA7cHIxSnVlaJNk8js5NZII2AnbcFn2uIEky4/zwgV1AzuppHLLX5LX?=
 =?us-ascii?Q?OGcVYx0V5KrUY+oLLb6WNBM7kCT/LxjElfs1FKe0Gpjmgim7NNvtbBgdN0Ej?=
 =?us-ascii?Q?qD62Xrf46mYLbSe7dWnxl+YvU6c6inZembK+7QA6VNTT1ZYFTcCrCx1eLfdR?=
 =?us-ascii?Q?T8IDr2h1gTz8Gz0+laQg8vKdzYdoUdbfIEcz8Ou6vFr2Q6O2yj8N9LpibFBe?=
 =?us-ascii?Q?eisSZVdJwKYZw5184ollk6bbMYHKuxDgLpT+bAlCKJUH50ax+UDgWboR5Ist?=
 =?us-ascii?Q?8wcbbCU+xawNrstlMD849MVJ4iUzA6+4HIugpXn+yDl50O4nOHKe89w+coAe?=
 =?us-ascii?Q?EBvBf8O4Zl0ASR7vHYtirFM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sFxG8K11mogLipnWdWA76gG0XrlAKym5LLoLF4F3SpfAw4G6FFnEzCvVNcLb?=
 =?us-ascii?Q?G/umRQG+/Q89tytTXWdVcnlCi75YnRpvh4i2Vfn3mFlUCBLkubo+QAeedAl/?=
 =?us-ascii?Q?lXtXBcBw9qrpN7YpO78IJz4FYDLcbcmPWXrEC05qFyA0RudrUK3N0cSEjA9x?=
 =?us-ascii?Q?qH5KOaVPudARNrhOb4D8+CgkFB8etzsG+dAXQsFEuKO6A6zGwMWRhhcueLLR?=
 =?us-ascii?Q?qJpOOc96Y4+2dX5sr9mnoyD+tV0s/IFnWtvU2hvUZWxL2dHQCRbEAOQ8IVhd?=
 =?us-ascii?Q?23swGxeSvhDCr5y+YIO4uBg6btzxsJbR/JVV1ZiwdQJGMtWq61CSQX+cLsPT?=
 =?us-ascii?Q?CBkROxrxRPBN/aiBe7lMp2uMWwQ/U04TwM4RccxJW5II/xZPAnEavyKPBPNx?=
 =?us-ascii?Q?DkC0BFsjkNKc8WLZhTYM0Q1n/U40JaCp6d29ZTy9ySKzxmN7Ag1wIn9nUwGt?=
 =?us-ascii?Q?bAg0ESpvVyQiZBPr/HcWCCcOAs7lO7xDI9UjZ+lVJwH1LISZQBvO8xrWnL7z?=
 =?us-ascii?Q?FT4lGeR3MAfzVlqKOxCRtbp3SxVGm/oPhGvYyLYVlB/RrH4xtpsg6dXOwUaw?=
 =?us-ascii?Q?SQtaWYNTZLSB44axPHLWmKpo7Mhk/FM18eikjxrG5SN3ZERtKjfIdG5kTcIV?=
 =?us-ascii?Q?1+nX90NdTaiJURDiaJyDD++HJClW7HxIXIkAGN2NgKgU3xGRwL1s3yvk5zhJ?=
 =?us-ascii?Q?NoCITESEMZ2+lPiCYbm0cPk8aEL7PuY/AA9Qzf0LCivh/MV4/yg4G8kF2zpz?=
 =?us-ascii?Q?4RWVcRolNpV4hfQ8M9JJCOoh2a3eDidAcAJfprvIscenaz8Nm6QXMLZZrQC9?=
 =?us-ascii?Q?F182hsev6k0KdN/axJdQxQ5CQ0oLcScy5M2f10utdwJ058xLnvbtTpfZ7Tgh?=
 =?us-ascii?Q?pmtqLpOTYxFM44x/8KrgQr32dkoUlrlYFoawqgT8DNVAL6+SDEQtobN7bcPH?=
 =?us-ascii?Q?OgRSfzLBstL0yf35NW6w+FDRtqB1jWRMG84HJPX0WmHnjZRf9FQYqxAPakB9?=
 =?us-ascii?Q?1HYvE0awF8r++7cXhdP7pTnEzoeEMyID0O0Ss/oyPD4yU/hXd2a6L7Fz7wyc?=
 =?us-ascii?Q?z0uW9Jrlm/cEdal5SP9xvl2NN22Fy38DUS+ikozV4Oi5l502p6xcfM263AH1?=
 =?us-ascii?Q?HDGADns6T+xtICMcl2eO5hNSU196UUmm3Y9wGbCFftgN+7olG3AV0r0Kh9gj?=
 =?us-ascii?Q?cNktWbBl3QV5lY/u4Atif7egKA9gcuOT1+bj+DCZ+LqNXj9zJG1FI5NHGUGn?=
 =?us-ascii?Q?CZvxIWfYi+HJkEKydLdqjm9p3i7OnMwjj8JsY5CF05edYkVozgU8X162NKU6?=
 =?us-ascii?Q?a+P1duV+lXjk29hg+q/f9UMhpWMe29PmtykYsBH5f3oLTeyY6vj/uCiCM+0T?=
 =?us-ascii?Q?mIGG4MgSfHPJTOeVMzLs0VmSzO84JE7XwVo+7pN06fSP4daGzuFlapUPw98o?=
 =?us-ascii?Q?Joxd2lw8TWfbm8L9A56M92bLDw1NcK13YXeM9NlSLz/W5jGPnbW3WAgZixaB?=
 =?us-ascii?Q?kYScp00JACIQ+oP3xllvTHlLlrwAgWNrdzZh1rOSKlUUlqmcMF0Co7yccikj?=
 =?us-ascii?Q?0de2PZ6tZtMbxz2j14HkhIHyshmhEXYWUBxkPZHl6qp66IwHHeKrYkT6SRUB?=
 =?us-ascii?Q?V5b6D4Tx/cuSKLQer3WQqntH1TEbX1RTAkavWizLMO1t2k9pq/5Lh7TTz0Lt?=
 =?us-ascii?Q?6fACii9wgeFJFm5h1UL/CbmQ670MV8jNuYVeX++HDhrABUvgMmrei2KK7zTb?=
 =?us-ascii?Q?kJEr8hHubJ/4tJTenaUh4nPlJbPoKIU9xZhZSYbmKIQPqo2cJOZAPbevJE8w?=
x-ms-exchange-antispam-messagedata-1: 05s5CIDKyu+zWA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 431548d3-75e2-46d1-fadd-08de649c045b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 09:50:38.3740 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PK5Ix9pzzaX1MuCf+G87fEuXCLBVRIUeaG8Y8TPvjPaf4Nvv8tq+17Hjt7aPLDzpqd5UU0tF1uv+rnEm4FUFCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5150
X-Mailman-Approved-At: Thu, 05 Feb 2026 14:05:49 +0100
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

Hi Peng,

> On Thu, Feb 05, 2026 at 09:58:23AM +0800, Chen Huei Lok wrote:
> >From: drosdi <danish.ahmad.rosdi@altera.com>
> >
> >Replace the conditional compilation checks for Agilex and Stratix10
> >with a check for SOC64 in `drivers/fpga/altera.c`.
>=20
> Add an explaination on why this change.
>=20
> Regards
> Peng

Thanks for the comment.

The change replaces the Agilex/Stratix10 checks with a SOC64 check
because this code applies not only to Stratix10 and Agilex, but also
to Agilex7M and Agilex5, which are SOC64 devices. Consolidating the
check simplifies the code and ensures it covers all relevant SOC64
platforms.

I will reword the commit message and reflect it in v2.

Best regards,
Lok
