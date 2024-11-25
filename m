Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18ABD3B7D2
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 04:18:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6166288EF5;
	Mon, 25 Nov 2024 05:18:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nGQ9bxHM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F59489539; Mon, 25 Nov 2024 05:18:40 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::626])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96D4788DE6
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 05:18:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJA6jdQ+AUDLhN12pzk+w0rlRdkq52iCNUvdOuq0SIk7pki1WtXEbmuO2PlQCdq9Hp0SZKl/gYTfyeqsi0t1Wt09DiJIIRTJJ4qksVoiRqZViD8FYAuycorJRltZRZPryGpArJzLBq2/UcMauO8K7CQwTcgem6h8rDMgqTwcRaN2JQUUCUxpWbJOl8ouTMb4Bnis7OsJCgugDF0bWhk5d2AcMCbeQpS2BwMh6/TZhavBEcIcW0gRXkZBvZxd+4eeIqydaG/CxtQ0dEJPG5t9/FVY1xonYdAixH2ERRf2i1RxdV0NbwJ/NqvyTxf0QUgILeZ2tK3XsezeQxN2VWntlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSvh6TMLBiD6KnDBAxBnic1cBC35WU4Ai/uXxm+LXBM=;
 b=aAgS8Ra6TuOTbRQpXght0KIt3ixLAGfPpfr2Gmd8DJ0XAHdUJMtY2ooOupN3j7JMUf9byDc4W6HnbZsjsBdnYUYte9dWidQpUaQShnOvHcsoWnAAbLlXQovwwB7r8/s2jpkIQabQbC6jPmy5j2xv0aRDyThLo52IScNPPWGR2mVlOAu4R7cI35nyLJvu1K3z5yiUhs2nao/TSaXTvHzeNyM7YUedCMY5E8XT6n/JlCVBPmp4HtqeubwwNxhisj62Yxp1e5paWap0JgHHhuVlroBgK8YjyAZ7q4ZCzKbbNtDBt0W850wCOImT6PmTcbOoFrRNDMmUUCIx4SW16BN/xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSvh6TMLBiD6KnDBAxBnic1cBC35WU4Ai/uXxm+LXBM=;
 b=nGQ9bxHMbJ6zLQ8JuO5tTjXO07/Yz/85lryAz7QlH1LV34YGR4GZus8RQoYH/OnmMBCpQ5q80uHnOMO4FLEW49k+tgdOsMxo9JLPkdoleS/ii8h6aDTxPCB2p1jmwixZpfSXWVC1BUl48qx9lkh+Qmx2MV8GRvOoYNADLsxCTyM=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by SJ1PR12MB6193.namprd12.prod.outlook.com (2603:10b6:a03:459::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 04:18:34 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%4]) with mapi id 15.20.8182.018; Mon, 25 Nov 2024
 04:18:33 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: Dominik Wernberger <dominik.wernberger@gmx.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>, "Simek, Michal"
 <michal.simek@amd.com>, "tudor.ambarus@linaro.org" <tudor.ambarus@linaro.org>
Subject: RE: [PATCH] spi: Fix missed rename from SPI_ADVANCE to
 SPI_STACKED_PARALLEL
Thread-Topic: [PATCH] spi: Fix missed rename from SPI_ADVANCE to
 SPI_STACKED_PARALLEL
Thread-Index: AQHbPfFkwHIzRQ7iDkimBlSjk0YtW7LHZfzw
Date: Mon, 25 Nov 2024 04:18:33 +0000
Message-ID: <SA1PR12MB8697351438998AE9C0626CB4982E2@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20241123214708.44405-1-dominik.wernberger@gmx.de>
In-Reply-To: <20241123214708.44405-1-dominik.wernberger@gmx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|SJ1PR12MB6193:EE_
x-ms-office365-filtering-correlation-id: 82e9394b-ba6d-4c25-72e8-08dd0d0839c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?s7drB1fIlg9V7pVVI3uMpG0WKrrswIbuzVGQ0OJ80zKJHfXAdp3hAElJcEJ7?=
 =?us-ascii?Q?e7AMDrMTSErnHcBXZZQHuWDWYJ4Cmqam9LjU28cgPgDpApT1+dgy8C4OJlU1?=
 =?us-ascii?Q?1/B0iCeNo4m89JjAwQndv64Y//YHdnvZsYFORvGPHar9eI0xt+kkk8+UIcEW?=
 =?us-ascii?Q?VgIvSNx30XeEiXZVmeddS69tvE1oOYauauTPmW0MjF9S+3v7pBLNtl4zNX03?=
 =?us-ascii?Q?XMCSA9RLspyT/t5tInClbVaNxuhlvdE6d17T/r8/YbhvwhR4eYdktTOhRqZg?=
 =?us-ascii?Q?AGCb35w9Iw7/ZmoJ8VEM5bxc/SmQJlHzdAI5cxBKmkwhOOIPzdLXzo7wZkUv?=
 =?us-ascii?Q?vmOWadc4wAAz7jSibjdQlkVsNxNK8r9SzWo7MAYRM+ThqHCvnKycGRJxYvPx?=
 =?us-ascii?Q?kaTivLrY1swKGIYceKcd6AHRUr6N7GhnBrS6TltQLpzi8XcvJoMHsT4XbiQO?=
 =?us-ascii?Q?CQpye25PGWURk6zyVX4Ohw1lZKQGslGTd/MjqX1giDj3bVYFVEPtR/y88TsH?=
 =?us-ascii?Q?dpUXp+ttFapt4zJzN+veCWy9kWxW1E6Re44dz0GP3lBBYJcbGWwqjomSJICe?=
 =?us-ascii?Q?/u1X/wS3vML8xl7WEpadsdxHdnACL7XvQZ5meiT6SxKzq9fwVJOh0n/Togj6?=
 =?us-ascii?Q?CHUVPwbblbNETiJgrBRLWtaNUAvSabyk/LgNf3mPuB6dwRROpgSTbNzl9ZIP?=
 =?us-ascii?Q?yYKXCw7hP8KEgQi4dAhbETyQkEKgfyG3sfjOMZnuYnPLq5H8uCoLv1H2PQCW?=
 =?us-ascii?Q?w6qefZoEVwEujnD9Cvhado+MG6EUxkEZwAgklOk67F5PRlB/L5Il05dE/b4V?=
 =?us-ascii?Q?HLNYBmXutzAVweab7kd/DYVCl3xECrz3bT9l0j2Wi63xv94/oFSrMsujs8rl?=
 =?us-ascii?Q?7VniZMDy9+MePHR0LGBL8htEh2sHcmoJomEqr+9yX4Qv1YybSJkqECpZy2eh?=
 =?us-ascii?Q?vpq9iv+6u6i8i9Wyz6DMv1Nx3pXmmr6oFC7OV09sWiroeGV1yqGwbqtV1R41?=
 =?us-ascii?Q?ELUBjfQxjrVCmelsgSQo0QQ95qjOiUFZmAGJucIhUvdf7wVQtp1qplS1gI4K?=
 =?us-ascii?Q?78Um+l5tk5NsY7+zkNI0qMUayL67RHzH/fSssgqjPyOCtSwhOPpejVCV5o5u?=
 =?us-ascii?Q?O3ge3Oo/Ick4pvJr2xhh3tUk2eS5/7iuLZoqEGuHR6SmgNwhG3NRttbHntyw?=
 =?us-ascii?Q?pvjFCFX63ueANAS+rdJF87J+hbgaTRo9nYuMCp1rkISO3PtM5RqhtfVhZ8rW?=
 =?us-ascii?Q?0Bch5GA0V152Q1ApscYFlGJxCeSx5kw5zjLfIFIPJ6ISpNkgt6dHTJp33Weq?=
 =?us-ascii?Q?DyVfcjpae8prD/TRcdr/0Cu21yocm/k04FJluiu7uzBncn3J/pA54bQy2mAg?=
 =?us-ascii?Q?+t/V5k++oyQXSoEOOOXBh8jGoRY6/iOUvQMy+c+LaZYt34HA7g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?62LfresQnKe6LdWL8at71oxqmSLo9Oa+lGaWmzmmhFLgOD7LcNVQuyvbxlzk?=
 =?us-ascii?Q?dmRaShJ+KJLSrOOvZZkyEQEJGeSRbL+iWypHhEiL4VHdgO7hcSI9WmS1BzCz?=
 =?us-ascii?Q?SK0LUm11vpEo4yJhuTASkLMUMG+Z5Jj1NybRTra8Xxn6h9CaB7a6HtQ0qIfw?=
 =?us-ascii?Q?0B/BSkZ2JPe9Er5uxm/IcmJ+nk9WplQCxaz3zGyteKuOCHPDa6R7ejOwvn7E?=
 =?us-ascii?Q?MEQxqjZNS2tPvHx414+JACIwIXwAqxZFk2IZVnpc/bHLPqZvevLBDxGillHO?=
 =?us-ascii?Q?LyniZW6TSRj95kEfmt95puII5FXiSsPB2ixxQl0Twbxk5KEpXhu1/DAwm3qe?=
 =?us-ascii?Q?WJIHpqGtNWEvlyGhRKDFbFWQdDp5AbB4Z4vUDhzzeJFJ7WvDJw/OMw8YY+yt?=
 =?us-ascii?Q?dIEaj9cMC40a2dRFHbb/pcsp98bsnS3Gewk0nhSTOxyjNbPiXiVMXdavPfkK?=
 =?us-ascii?Q?xOm5zCCHY9omCYedys/EIBstC4Sm4TxY6mlnnQAKeOPMN/FLgJ+hFJ3vHIWo?=
 =?us-ascii?Q?L7RbWFortI3VfnRIC1yZas1SEIQZ7Q+pgCluxtQ9GkVkpLeTyEFgmS7J+n4T?=
 =?us-ascii?Q?W70SEUqRwIYvRJk3cwxPeuUq2V3VNvvmplrswmvMbGkJSbqfZs74erGulRpY?=
 =?us-ascii?Q?IiETHi6MRJOQ1MSwGvF3L0LWJXs8cZJLg8cWFGn38dPds/yhm1l1j56L9NA4?=
 =?us-ascii?Q?eQdQgejIILbYmUyBkNDBoTEmVFDYvfQjGnx4cbl/XfAT3fhO4KjUsBeIQaUd?=
 =?us-ascii?Q?v6ktQTWcqyBAaRQTjrpV/3cimWOqeG+TL1Jf1UCXeoJyKmSWWpKEMtlwnazy?=
 =?us-ascii?Q?qlk4dpOp4D5FkWceiA1slvzmrM06haDx1mw8Twy5F6+yX1QvjNAe8pg9dbTK?=
 =?us-ascii?Q?ipfWfGfGYJ+6Yyf5RTLYcKdx801C+LI8KY/GTuUnfyIq00nfZZl6Jji8aoi9?=
 =?us-ascii?Q?1M04JAkjA0f7y6NsDJAxYI4eEL9YcgVSXl3bE1KLtj+JWLd/OQW77GiIdXjc?=
 =?us-ascii?Q?sljHIW+i/kRb7ANiIT9k+3Er88F9qMfpDnvuDbN4X8wXE/UsPw25TQFKxmtp?=
 =?us-ascii?Q?C+qMyCl5nP3GF1Y1dOO/CsQ4TcxeJ7kZ4zu5Yq//bC+fNZcoddzJFk3edcaB?=
 =?us-ascii?Q?Y+i89K4m+e4QjP23NAlsFo7WMaIdYp06138TfKDBt5fCqKSwsyQGn6dnQBZN?=
 =?us-ascii?Q?gdmcPN6VMKQgxZgVXSAa5WsKCZnoTesJiO7CCMuzfiRza8M6TNeVsAk7pYOa?=
 =?us-ascii?Q?HrHyIeHa+wmOQ+m4W55j6abL0P3iDl12mcCkV1hh2l6a6A5vKiaIXVV8M/AU?=
 =?us-ascii?Q?Ditbkj58EbdD7xjqr5Wu09u9iyDszN/B5km2w5nwtmZMZ8JbPh3bTv4YvF02?=
 =?us-ascii?Q?xq3i4osS8rYZuDr5hJDXKH0+ln6Npw170/aNswKCE4qNMGeox8tzoVKeyMFC?=
 =?us-ascii?Q?x6AZxoYCWxuESXishmW2q1eTtqFNer69uJzs0eXjpwkqDUoyL1il8D9pU7lM?=
 =?us-ascii?Q?tXEGGrZFsb/m7XuI+sL2n80Ksyu+GyJC/Y0lDzPzhl1WVLtiMlYo9n+ftmWn?=
 =?us-ascii?Q?3qjdz4nrQj5vAAqdp84=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e9394b-ba6d-4c25-72e8-08dd0d0839c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2024 04:18:33.6085 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bMIRB/EluRz8zhboIOt7QrK3jaTrvDkpi0rwt+0A6moN6l7fAP4ks9EyWOPQCeOS3zZ1XjVdZCxhITFmD9DBEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6193
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
> From: Dominik Wernberger <dominik.wernberger@gmx.de>
> Sent: Sunday, November 24, 2024 3:17 AM
> To: u-boot@lists.denx.de
> Cc: marek.vasut+renesas@mailbox.org; jagan@amarulasolutions.com; Simek,
> Michal <michal.simek@amd.com>; tudor.ambarus@linaro.org; Abbarapu, Venkat=
esh
> <venkatesh.abbarapu@amd.com>; Dominik Wernberger
> <dominik.wernberger@gmx.de>
> Subject: [PATCH] spi: Fix missed rename from SPI_ADVANCE to
> SPI_STACKED_PARALLEL
>=20
> See https://lore.kernel.org/u-boot/20241026201741.171073-8-
> marek.vasut+renesas@mailbox.org/
>=20
> Signed-off-by: Dominik Wernberger <dominik.wernberger@gmx.de>
> ---
>  drivers/spi/spi-uclass.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/spi/spi-uclass.c b/drivers/spi/spi-uclass.c index
> 36b7d383aa..d604975374 100644
> --- a/drivers/spi/spi-uclass.c
> +++ b/drivers/spi/spi-uclass.c
> @@ -446,7 +446,7 @@ int _spi_get_bus_and_cs(int busnum, int cs, int speed=
, int
> mode,
>  	slave =3D dev_get_parent_priv(dev);
>  	bus_data =3D dev_get_uclass_priv(bus);
>=20
> -#if CONFIG_IS_ENABLED(SPI_ADVANCE)
> +#if CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)
>  	if ((dev_read_bool(dev, "parallel-memories")) && !slave->multi_cs_cap) =
{
>  		dev_err(dev, "controller doesn't support multi CS\n");
>  		return -EINVAL;
> @@ -515,7 +515,7 @@ int spi_slave_of_to_plat(struct udevice *dev, struct
> dm_spi_slave_plat *plat)
>  	int mode =3D 0;
>  	int value;
>=20
> -#if CONFIG_IS_ENABLED(SPI_ADVANCE)
> +#if CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)
>  	int ret;
>=20
>  	ret =3D dev_read_u32_array(dev, "reg", plat->cs, SPI_CS_CNT_MAX);
> --
> 2.34.1

Reviewed-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>

Thanks
Venkatesh
