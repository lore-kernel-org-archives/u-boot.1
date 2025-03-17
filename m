Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC0DC282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 04:35:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F7288197D;
	Mon, 17 Mar 2025 05:35:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="dwh3ry6r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CDD880F4C; Mon, 17 Mar 2025 04:52:32 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4DAF800C2
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 04:52:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wEuOkUJng1szNlLzO/Xeb97HS/Ogl8xy+bW1dzDPXLOfC/z2rtUu4PBeSNhvCFJIUpCAsQ1pSNFK7OBxJWPVsIfwNHRhi0Ek0RrQMRia+69eDia4kkcNWjgwHtKrssPyTtxUjJK4lSC2lVEJOlkDu0ZL28RR6vsIAbZCzWf3D+zdypEkm++30DHpTZkXaRllVhE+B0wD2r5MBNjo9ERG+wu0dg7/biL41R8E9XUW+cAb2lcfDteqg8PEGZcjI6AYiegJrvm/VTXCZAWjzybUf9huDdXBVtaedIGddDc+H1IDuh/XzMXLRUQaCDgoeWsdU80OC/8ysrLAPUINq4Aj4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wP7q/MWjlbnbj25X+AxL/ws0vK5EDZCuXbXQSKDFkjQ=;
 b=ol/XuJyCugYVrnSQ9W5JlO25YzMzRF3Nvl+PYsZgI4dE84DBDIEC1k2XRUioQzvMVOnZ4GRpvnNC+0Oco51nn+PJLyfe5enTDDRUXdHlB8tvuiGGS0MPNwNC2Flrx9M5BgnkX20rFU/fDYJDjFBHMzmLXKnaXi06wUmEcdkWkrhUfDjY8QaJcB7M6fa+WMwZZgTjRQL8diElAnmjmd5GK4ls8knwkVtPXZewcC/7rcxWJYzdaJodL4BfXVXKq4CsXHTs15ifD4zkSJ9apskBXh21b+04a/5JJwKSbbrGsvIuphxbXoB7PHgqJjXIEUhiQ2HjMhvmNoWR9WmDtJuo7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wP7q/MWjlbnbj25X+AxL/ws0vK5EDZCuXbXQSKDFkjQ=;
 b=dwh3ry6rG5s29ipZot+dqdlue8+3GgEI2wcU61U66sZirx0aHygwO/E7dutwAlS1B3OttcOB3cGAvKDrbX7SLFwY4H9Q3UiM2Dwl/YFz4BdK5nNmy1/gXGi8Km9xnInNwjTVzzSnPkZu78p9lSLoVB+y8493b0hruHdx6AeQQRxdM2UbCXOPMOilHX2TKWor/nglDhIp+jTMp6Rj26PjLAR+epwvhwjcT3uZJh3t4q9DqTpXkvSOMKg/qV4qvnASlzkMX6hFnBR3IvVB0jwCFwQkZhQBWA/fhXqeEtR+MiiAfV+oaLyMFm5XLFGBzzYCl6uFGiy4GPNtR5tJaFI3sw==
Received: from SN6PR03MB3583.namprd03.prod.outlook.com (2603:10b6:805:47::26)
 by CO1PR03MB5827.namprd03.prod.outlook.com (2603:10b6:303:9a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 03:52:20 +0000
Received: from SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad]) by SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad%3]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 03:52:20 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Michal Simek <michal.simek@amd.com>, Tom
 Rini <trini@konsulko.com>
Subject: RE: [PATCH 1/1] drivers: fpga: Add partial reconfiguration console
 commands
Thread-Topic: [PATCH 1/1] drivers: fpga: Add partial reconfiguration console
 commands
Thread-Index: AQHblNcBTuMxYo6e60+1pGGeQ1BADbN2tf+w
Date: Mon, 17 Mar 2025 03:52:20 +0000
Message-ID: <SN6PR03MB3583BA58BC9D647033F7B0E3A7DF2@SN6PR03MB3583.namprd03.prod.outlook.com>
References: <20250314114758.29078-1-nareshkumar.ravulapalli@altera.com>
 <20250314114758.29078-2-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250314114758.29078-2-nareshkumar.ravulapalli@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB3583:EE_|CO1PR03MB5827:EE_
x-ms-office365-filtering-correlation-id: 1387540d-1fc3-469b-71df-08dd65071e34
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?4ftVbBO1Z/HtRwWE83B3stNUjZSL2CopsGJEgIK6CPjOiFWzuD/5tPqMfZJX?=
 =?us-ascii?Q?VW+o+zElMkIqJNAMnE77T9Unlsm+1AkSGvVK9VHVNybiYumT1Ko6PcxD9fYe?=
 =?us-ascii?Q?YVKicQic/rQYQPWLTfEaQwOqF9IHw6FGNCzimr51SB6qhtUlD2vpchYtM8QD?=
 =?us-ascii?Q?lWdvk6xVseuYF+Ccbl9VHqvdPiP2YDouPQIUOOZByhVuKj/i+hi3ZY76nQap?=
 =?us-ascii?Q?pGRkBUs4+re64FN00+l5qGMayeoXlIkolFqKiza1bERzJWZ3eLSjZyg3qigq?=
 =?us-ascii?Q?VdGp/Xcyid7kzqaf06IyzxBAD90tC7rDPNjhRMIrBL5drbIREpFOqJkShiUp?=
 =?us-ascii?Q?E2aPsGuyM6pl/rDOpjgkpT0O9K1ysAFwof5zmGwL77DL3PzApQYSMuxPZTf+?=
 =?us-ascii?Q?xawpdlymuPXwNpXICs3B6Ic3hSFU0EIAzqOcHKdSi6p7XXh9B4wyBrsoZzR0?=
 =?us-ascii?Q?3hYi6XMUE9NTwnE1fdiqPNjcm/Ufcj2S2TaVLySu1klY/yEIH+Pm2BJ+APBH?=
 =?us-ascii?Q?iqXMaww6KQ/9aR81NMKSON9sHV2RdjnjT/wiPkf7/z3Qv/S+YB/2BIt7r2/0?=
 =?us-ascii?Q?dh7aKYLMqAAZGRmnRxwYWVKZYV2WvPhqoE2c3/YXWLZkDjflaFh+zqnaLgSU?=
 =?us-ascii?Q?GDRq/FP92+T64nEJq2ESZLZhks3khtRFd3cGN8TxIxc2MYST2nzZBxvH09eC?=
 =?us-ascii?Q?DQfv9MsMiXC3Bfg3JOF0LbgEa668kujodVWFcqWSyUjY4uph5cVTXpVSE/Mq?=
 =?us-ascii?Q?TT7yzedykqxoRFR/Njx5ah9Rmhpk7Akrt26+Y/I0wDiAKD+aR3y2u9l72xyz?=
 =?us-ascii?Q?Vpmweha1PUNMwgKbwVXOhHQeub++fv2a1fip+doqazFT4GvwJpToxZKl9ndx?=
 =?us-ascii?Q?mrgnuTyeKcZWk7detiSsjx/4t3yAFc06mOisdONsAnBzr71PlzRCGa9di195?=
 =?us-ascii?Q?BRPgEWLvY+ouOxVcPIJnUrPUFQVodegrM9+RPiLhW8itHJkJAkjdRQp0H3hQ?=
 =?us-ascii?Q?FTJrBxc45TF2S8Hh+hPenLuDheNvoOxwdIssgA0sZfsnVfnX6e3z4zNbYpou?=
 =?us-ascii?Q?gr/D4wV1u/kj5eCboPW+JpKk16lNaqEqpZcABujGNzU5HRrWeE3nsZcyRRsp?=
 =?us-ascii?Q?bJB7EiVEiz56utpoO6p0a7T9b3Iuj/iJhWYvSrYfCAVL1sBuIWh3gqIl8a/g?=
 =?us-ascii?Q?tW0xSAn2tKYS3MLxp8NJQXfhJNyydfLBLawNX674VjKmTfO2B1Q5RFEXn+zu?=
 =?us-ascii?Q?SGvO9vYTfdiAlydCrkAlvN9V/L2YEqpyOs8JVOeH2chtqimYGbqhFMq2gBzs?=
 =?us-ascii?Q?R8Ek/oHGGFhZp5cHbFEBndxhFKxReZb+/prZfx9XURQ0tccOo3B4vHnDPyAe?=
 =?us-ascii?Q?TDR5iANmQzvzoM2D3yEsXhEPWwSGs2aEaXec6Hdgj6/x3hroyvsvVqmcORQJ?=
 =?us-ascii?Q?+SZnVVKqOscbtrtM/ox9Yl6w1JPQYsKu?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3583.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NdnX3uYWm6ebzGZBFoGkVyf1rq4B7To2DDa6KqLmpi8dkwgwmwxz/arzaSq2?=
 =?us-ascii?Q?P6ihqxdEsD2C/PVM32ZgIVCB5afJT+qJbotEaYLZWS/Q4rALILCztLhtzFTX?=
 =?us-ascii?Q?rq01nj6Myo+viMdMCtBJCL8He0qEVTJp10zA9PbjoI+5ZSg+qRx++o9FzdBU?=
 =?us-ascii?Q?4p00N2FDRT+FVS1z7RDN8FtbAYkSu255e8DIXgFXjV4EvhTaMgRlbgTf385F?=
 =?us-ascii?Q?FLgbdqRg/zXOzNrgh7O92VOOXoK5kApZCb12LiI3trPkLQkjYAx/cOpXGuqO?=
 =?us-ascii?Q?a1m+o4ZhjykyBZSF7f831of/wXJyHKDXy0EbwdGU8PqMTPNGvxqVtoCZUhLt?=
 =?us-ascii?Q?vlkfWOTSDzH2LEH4zlGMifOq8WJmGacOSWXQ8CgOsnFzocZGNnB60pGp1hJ1?=
 =?us-ascii?Q?CtGdGS2+enI6d0gXMcuvot05SN7Oiwk6K8umuslZoAo2x3jPuZQS4lKEiirN?=
 =?us-ascii?Q?pA9Gof1WnebWTIB6ZHkiw0hZE4JIK0lhI4BrEiUfaR2upJ1JAWaYTojD6Skb?=
 =?us-ascii?Q?KfwkCOMCC9cyBKgzuT58sKpBjJ355Q1epWRBV4RIju4izFS2wBIvMB8EcIC0?=
 =?us-ascii?Q?bmknR+1B0g2RRVK9qRyTXJgUXr8oBn4mWqppJnTN/8ABuOic4NggX07LH0II?=
 =?us-ascii?Q?F6THQoDaESn+so2lmK7ow2Uud3fKFcrsyF67j4BGaEcnetylA0cbdTbQNfhc?=
 =?us-ascii?Q?4ulpAMeGn832P/N9l6Y9nkNdpSAeSPopVPNdLY5Yt/kFsof8OVRZ9P/JTe+m?=
 =?us-ascii?Q?/YJbLv2HRbeI9/WFSEA8unLOBo6ieHA17o2nu+gVtHUwr7IwdpO6ocHkpWWU?=
 =?us-ascii?Q?/BQDNEswHQTxk1ld6wqLqTp9l0NygPVg8mJvjYcgBTuFDbX6jOvZJcf4D/YU?=
 =?us-ascii?Q?MJ2LT6caGUCOGVMK9EwTdLlBBwsircXvp5l610Z1Aa3jLWOKfn7/sOqxgf+F?=
 =?us-ascii?Q?yH+rlUa2kIiVAj9cHRiGhjJdzuY9VMredLSvOiMJXVdrFHbFBBaNiSh2tbY/?=
 =?us-ascii?Q?Tkx0p923q+JQbUYL0dXE4J+LIhjRNuWsX+sNeQkQ+QP78u+Tfk5tFQLSXOLS?=
 =?us-ascii?Q?7bXcWVXN/20kGBIqu52ik8CaAb1LlBtPCVqgdEvJ1sk2Ivi5qb8Qd3HC5uui?=
 =?us-ascii?Q?kLAIJFQTeFKN2a3gFFVmz75DImnKt6TLfpJb5345I7ER/y0Mn555g9uOz8S/?=
 =?us-ascii?Q?Wfg5TlgGeCX6YlSpzUzgmXydm7ichz/+Hp4C7jJOk/Brdm5spY08RFmQUCSQ?=
 =?us-ascii?Q?AybboHf0b+0vtPy5rH9WW/nvzo0vRxA72xpVty+92DX28FoV9ETtmNGygTv0?=
 =?us-ascii?Q?+dhlrJ76Lxl9hrKZj+OlJQ18p4YCjCGqW70Nb9EaNZPP7NAUVKrClEn02xDf?=
 =?us-ascii?Q?AX63KIkS4W6H1hC0tTNTWqwgqsY9ExySoQjWpn2qQ6vVaWhDagERj7hcqoYR?=
 =?us-ascii?Q?nQeDnHFpBjwQTelEE4rURFO2rfao5WgYvWFkFIYD/pAlxnziVP11L4oWunpF?=
 =?us-ascii?Q?L6MSoyuNso8lI4hG3AxzO5ewnwxq2rvSF+Qqsdb8rS0rq/LnutLQNYr5/0jv?=
 =?us-ascii?Q?23f2cc2EjfKnBAq4ueu6ZjG4ocNhLBwPJ8OwWwSO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3583.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1387540d-1fc3-469b-71df-08dd65071e34
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 03:52:20.1818 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O25ZournBBHaIxQr6U6TWG4Y7O/3wM7navE0iLnHcmnWahsfdlo3diTXWWa31whOH/Jj7/KAHc4jc6rG2mNd1iGwtotCAG4eZf56/blqYQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5827
X-Mailman-Approved-At: Mon, 17 Mar 2025 05:35:00 +0100
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
> Sent: Friday, March 14, 2025 7:48 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Michal Simek <michal.simek@amd.com>;
> Tom Rini <trini@konsulko.com>; Ravulapalli, Naresh Kumar
> <naresh.kumar.ravulapalli@altera.com>
> Subject: [PATCH 1/1] drivers: fpga: Add partial reconfiguration console
> commands
>=20
> Partial Reconfiguration (pr) command is added to U-Boot console. The pr
> command will use the Freeze Controller which can freeze and unfreeze the
> specified partial reconfiguration region. The pr command supports multipl=
e
> regions for partial reconfiguration by specifying the region ID.
>=20
> Signed-off-by: Naresh Kumar Ravulapalli
> <nareshkumar.ravulapalli@altera.com>
> ---
>  drivers/fpga/Kconfig    |   9 ++
>  drivers/fpga/Makefile   |   1 +
>  drivers/fpga/intel_pr.c | 191
> ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 201 insertions(+)
>  create mode 100644 drivers/fpga/intel_pr.c
>=20
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig index
> 62cb77b098..bf34d11a9d 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -66,6 +66,15 @@ config FPGA_LATTICE
>  	  This is used for the lattice FPGAs. Please check the source code as
>  	  there is no documentation for this at present.
>=20
> +config FPGA_INTEL_PR

Change INTEL to ALTERA, please check other.

> +	bool "Enable Intel FPGA Partial Reconfiguration driver"
> +	depends on FPGA_ALTERA
> +	help
> +	  Say Y here to enable the Intel FPGA Partial Reconfiguration driver
> +
> +	  This provides basic functionality for partial reconfiguration which
> +	  include the freeze controller support.
> +
>  config FPGA_XILINX
>  	bool "Enable Xilinx FPGA drivers"
>  	select FPGA
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile index
> 610c168fc3..70a8f88836 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -25,4 +25,5 @@ obj-$(CONFIG_FPGA_STRATIX_V) +=3D stratixv.o
>  obj-$(CONFIG_FPGA_SOCFPGA) +=3D socfpga.o
>  obj-$(CONFIG_TARGET_SOCFPGA_GEN5) +=3D socfpga_gen5.o
>  obj-$(CONFIG_TARGET_SOCFPGA_ARRIA10) +=3D socfpga_arria10.o
> +obj-$(CONFIG_FPGA_INTEL_PR) +=3D intel_pr.o
>  endif
> diff --git a/drivers/fpga/intel_pr.c b/drivers/fpga/intel_pr.c new file m=
ode
> 100644 index 0000000000..ecca2c9eeb
> --- /dev/null
> +++ b/drivers/fpga/intel_pr.c
> @@ -0,0 +1,191 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 Intel Corporation  */
> +
> +#include <command.h>
> +#include <errno.h>
> +#include <wait_bit.h>
> +#include <asm/global_data.h>
> +#include <asm/io.h>
> +#include <linux/bitops.h>
> +#include <linux/libfdt.h>
> +#include <fdtdec.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +#define FREEZE_CSR_STATUS_OFFSET		0
> +#define FREEZE_CSR_CTRL_OFFSET			4
> +#define FREEZE_CSR_ILLEGAL_REQ_OFFSET		8
> +#define FREEZE_CSR_REG_VERSION			12
> +
> +#define FREEZE_TIMEOUT				20000
> +
> +#define FREEZE_CSR_STATUS_FREEZE_REQ_DONE	BIT(0)
> +#define FREEZE_CSR_STATUS_UNFREEZE_REQ_DONE	BIT(1)
> +
> +#define FREEZE_CSR_CTRL_FREEZE_REQ		BIT(0)
> +#define FREEZE_CSR_CTRL_RESET_REQ		BIT(1)
> +#define FREEZE_CSR_CTRL_UNFREEZE_REQ		BIT(2)
> +
> +static int intel_get_freeze_br_addr(fdt_addr_t *addr, unsigned int
> +region) {
> +	int offset;
> +	char freeze_br[12];
> +	struct fdt_resource r;
> +	int ret;
> +
> +	snprintf(freeze_br, sizeof(freeze_br), "freeze_br%d", region);
> +
> +	const char *alias =3D fdt_get_alias(gd->fdt_blob, freeze_br);
> +
> +	if (!alias)	{
> +		printf("alias %s not found in dts\n", freeze_br);
> +		return -ENODEV;
> +	}
> +
> +	offset =3D fdt_path_offset(gd->fdt_blob, alias);
> +	if (offset < 0) {
> +		printf("%s not found in dts\n", alias);
> +		return -ENODEV;
> +	}
> +
> +	ret =3D fdt_get_resource(gd->fdt_blob, offset, "reg", 0, &r);
> +	if (ret) {
> +		printf("%s has no 'reg' property!\n", freeze_br);
> +		return ret;
> +	}
> +
> +	*addr =3D r.start;
> +
> +	return ret;
> +}
> +
> +static int intel_freeze_br_req_ack(fdt_addr_t addr, u32 req_ack) {
> +	u32 status, illegal, ctrl;
> +	int ret =3D -ETIMEDOUT;
> +	unsigned long start =3D get_timer(0);
> +
> +	while (1) {
> +		illegal =3D readl(addr + FREEZE_CSR_ILLEGAL_REQ_OFFSET);
> +		if (illegal) {
> +			printf("illegal request 0x%08x detected in freeze
> bridge\n",
> +illegal);
> +
> +			writel(illegal, addr +
> FREEZE_CSR_ILLEGAL_REQ_OFFSET);
> +
> +			illegal =3D readl(addr +
> FREEZE_CSR_ILLEGAL_REQ_OFFSET);
> +			if (illegal)
> +				printf("illegal request 0x%08x detected in
> freeze bridge are not cleared\n",
> +				       illegal);
> +
> +			ret =3D -EINVAL;
> +			break;
> +		}
> +
> +		status =3D readl(addr + FREEZE_CSR_STATUS_OFFSET);
> +		status &=3D req_ack;
> +		if (status) {
> +			ctrl =3D readl(addr + FREEZE_CSR_CTRL_OFFSET);
> +			printf("%s request %x acknowledged %x %x\n",
> +			       __func__, req_ack, status, ctrl);
> +
> +			ret =3D 0;
> +			break;
> +		}
> +
> +		if (get_timer(start) > FREEZE_TIMEOUT)
> +			break;
> +
> +		udelay(1);
> +		schedule();
> +	}
> +
> +	return ret;
> +}
> +
> +static int intel_freeze_br_do_freeze(unsigned int region) {
> +	u32 status;
> +	int ret;
> +	fdt_addr_t addr;
> +
> +	ret =3D intel_get_freeze_br_addr(&addr, region);
> +	if (ret)
> +		return ret;
> +
> +	status =3D readl(addr + FREEZE_CSR_STATUS_OFFSET);
> +
> +	if (status & FREEZE_CSR_STATUS_FREEZE_REQ_DONE)
> +		return 0;
> +	else if (!(status & FREEZE_CSR_STATUS_UNFREEZE_REQ_DONE))
> +		return -EINVAL;
> +
> +	writel(FREEZE_CSR_CTRL_FREEZE_REQ, addr +
> FREEZE_CSR_CTRL_OFFSET);
> +
> +	ret =3D intel_freeze_br_req_ack(addr,
> FREEZE_CSR_STATUS_FREEZE_REQ_DONE);
> +	if (ret)
> +		writel(0, addr + FREEZE_CSR_CTRL_OFFSET);
> +	else
> +		writel(FREEZE_CSR_CTRL_RESET_REQ, addr +
> FREEZE_CSR_CTRL_OFFSET);
> +
> +	return ret;
> +}
> +
> +static int intel_freeze_br_do_unfreeze(unsigned int region) {
> +	u32 status;
> +	int ret;
> +	fdt_addr_t addr;
> +
> +	ret =3D intel_get_freeze_br_addr(&addr, region);
> +	if (ret)
> +		return ret;
> +
> +	writel(0, addr + FREEZE_CSR_CTRL_OFFSET);
> +
> +	status =3D readl(addr + FREEZE_CSR_STATUS_OFFSET);
> +
> +	if (status & FREEZE_CSR_STATUS_UNFREEZE_REQ_DONE)
> +		return 0;
> +	else if (!(status & FREEZE_CSR_STATUS_FREEZE_REQ_DONE))
> +		return -EINVAL;
> +
> +	writel(FREEZE_CSR_CTRL_UNFREEZE_REQ, addr +
> FREEZE_CSR_CTRL_OFFSET);
> +
> +	ret =3D intel_freeze_br_req_ack(addr,
> +FREEZE_CSR_STATUS_UNFREEZE_REQ_DONE);
> +
> +	writel(0, addr + FREEZE_CSR_CTRL_OFFSET);
> +
> +	return ret;
> +}
> +
> +static int do_pr(struct cmd_tbl *cmdtp, int flag, int argc, char *
> +const argv[]) {
> +	const char *cmd;
> +	char *region;
> +	unsigned int region_num =3D 0;
> +
> +	if (argc !=3D 2 && argc !=3D 3)
> +		return CMD_RET_USAGE;
> +
> +	cmd =3D argv[1];
> +	if (argc =3D=3D 3)
> +		region_num =3D simple_strtoul(argv[2], &region, 0);
> +
> +	if (strcmp(cmd, "start") =3D=3D 0)
> +		return intel_freeze_br_do_freeze(region_num);
> +	else if (strcmp(cmd, "end") =3D=3D 0)
> +		return intel_freeze_br_do_unfreeze(region_num);
> +
> +	return CMD_RET_USAGE;
> +}
> +
> +U_BOOT_CMD(
> +	pr, 3, 1, do_pr,
> +	"SoCFPGA partial reconfiguration (pr) control",
> +	"start [region ID]\n"
> +	"	- start the pr by freezing the region\n"
> +	"end [region ID]\n"
> +	"	- end the pr by unfreezing the PR region\n"
> +);
> --
> 2.35.3

