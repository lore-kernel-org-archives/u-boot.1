Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 285F9E7716A
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 11:03:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DF708005B;
	Sun, 15 Dec 2024 12:03:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=infinera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=infinera.com header.i=@infinera.com header.b="Osg2TGxF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1000880066; Sun, 15 Dec 2024 12:03:29 +0100 (CET)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::623])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 953A680050
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 12:03:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=infinera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Joakim.Tjernlund@infinera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tAW4uupwG5cUkd9HdyxyW47Vm2utOjSOtD2GyPibv2+wrVuWXXv0fHBkk7WDVlWPG2nQ5mq3p4f0FNHYlCm8lIaSJmRQUmn7U5Od7Uin7YslyfGobSDc4Td+wYUeoviGPxgvYeknOpiJfx7RyAmDYbXnC8pXiff2mST5MdU9NUff3PnolZr04Y7fZAUVhHweiTyJcsQjTbhOAKiqryHSOck1WwUJ0uXhrVozsdCzciclCf94ZU93VH5OT+cXokiTITho1XZ0x7CNpvYtobTNXZmlr5A1ciDBOQ5DpWU10DCAKRpo2JCO1oKZ2e8JL69f9B1idifuPMkSlovc8K/EfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tpj6ZTTa7kn+/DFzA5Phy+YxNFjNLug2mgOKsQ6+wcI=;
 b=JESPUmGn6E1QgY+OLH/024shFWgQkh5qRYrG/b8JLpvihPRTYvMQGU2SWAxcPUjWJ/OgNgUrMuW0CbNBART30wangtvDeTPyHXZIyHql0WYfJN+HHiIaMYV/eRXg7jMnBgFbfu38rLUWvyrN226mU05kB083oVSvTmsNC75CA36LUPFIlDV0PjAdNIo7WNGsAq0Zm7c6Y577IeFU4FPk++50ceOTz2a4d7f7WSo8F2yCgrHm6jSicxdCUVkQDIgDsJoGJuPgxbkYSulN8V0VtVRqxQo6WbSq//S7GPdHvwX+QrgxrA7lDH3xgqx2rWsQ4o7btv3t57Eft140JhOkFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tpj6ZTTa7kn+/DFzA5Phy+YxNFjNLug2mgOKsQ6+wcI=;
 b=Osg2TGxFWR2xMNq/wCSzAugMWfsxCHEQuSNTTT/bcUHF6ioMs5MRmwskLYEsgrp6HG02VBl78fRuzDZkxSbGeKsvlvkEodXokgwQ0nZC2fAVGnq2vJtH5gfQqpVg43URo4XIQIRCBawum0AGj3hTBmapTPrMPsvTTLP3b9U6L6LtP6bJvCwINxjoCVx7fhCkPBAcnSRa5mbRs5S4b3KGtekrdGzfjAxlNawpRWMmS9+pZQzP2IcRO1IU1fLTjSDuol4M7AOzS0wSnbRscSZAE+hqMTnC5AndDP6FpD/iXjZ0qb28cCdOQIBmi0DoDme/iK/+fC1JyMAVoNgAND8SMA==
Received: from BN7PR10MB2610.namprd10.prod.outlook.com (2603:10b6:406:c0::30)
 by PH0PR10MB7005.namprd10.prod.outlook.com (2603:10b6:510:281::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Sun, 15 Dec
 2024 11:03:20 +0000
Received: from BN7PR10MB2610.namprd10.prod.outlook.com
 ([fe80::c5b0:801a:5214:f38b]) by BN7PR10MB2610.namprd10.prod.outlook.com
 ([fe80::c5b0:801a:5214:f38b%7]) with mapi id 15.20.8251.015; Sun, 15 Dec 2024
 11:03:20 +0000
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: Peng Fan <peng.fan@oss.nxp.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] FSL DDR: Errata A009942 clears board cpo_sample
Thread-Topic: [PATCH] FSL DDR: Errata A009942 clears board cpo_sample
Thread-Index: AQHbCpxLdgRC+s4ecEm+e/6+iJaiHrLnFcIAgACWXFg=
Date: Sun, 15 Dec 2024 11:03:20 +0000
Message-ID: <BN7PR10MB26104D5570AEA687B3C615E2F43A2@BN7PR10MB2610.namprd10.prod.outlook.com>
References: <20240919140027.409614-1-joakim.tjernlund@infinera.com>
 <20241215020310.GA20741@localhost.localdomain>
In-Reply-To: <20241215020310.GA20741@localhost.localdomain>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=infinera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR10MB2610:EE_|PH0PR10MB7005:EE_
x-ms-office365-filtering-correlation-id: 15a938d1-8bc6-47af-3ff7-08dd1cf81614
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?N4iEHLvKUS5vBmwPrlWTeoXjmYHIwXMdiesZ5x3Ya67Z29/OV49p6055lI?=
 =?iso-8859-1?Q?YFbDtC0zcM/YbS6ErkEVRqA3wl5pZ+QnI0eUumigF1iYuleZJVAnV7UJzz?=
 =?iso-8859-1?Q?PJWe6ozRkqGRhNN/YSqPlYRdgFnW2su/0N2tIQN/431OiPGW6NhCG7b2zf?=
 =?iso-8859-1?Q?JXwxpe3EAstEvZq+U69EzYMvrlbpJTCSVoLSNeTckpyqEfC9TGXLtSXpD7?=
 =?iso-8859-1?Q?F5R1i5I182RZQZUodr4xwErtIvsHNi27lv+/7PmIjHmk22J1OCYKD37V4+?=
 =?iso-8859-1?Q?28EuJYHm7bp72bwTk0ANN8luqMMhK3v8dd+OU5hqt2B7VVvWt0AJeSIICQ?=
 =?iso-8859-1?Q?Lv+PmTnvUR+mi0yxZQeXi+eFo755KQTsFTmXmQgAbZK6X1c/J8LQ6rt/60?=
 =?iso-8859-1?Q?p1nIk9NiFBUm/O6HqfbCbRZVcH0Aa3PAOJnb1Hv4R+cBopF0TFZkWhAoim?=
 =?iso-8859-1?Q?+2aPMZrN6HGb4qusD3hp5tZ/HuGoYMt3b1lM8dHRSPYSWpb7mPjBrdcndP?=
 =?iso-8859-1?Q?pX8KNiaoAFG/jAwajUkfDxa1grX9YjIXIeffxr+MPAyjzuGiDjdUAmkIwJ?=
 =?iso-8859-1?Q?BmA8AE4vg86MDooRMh/4IE54IJnAdX77yQWryGlLF12Kc0iRmf1D7fC/aq?=
 =?iso-8859-1?Q?7E9I/ygXDqLa/bEoID4cYOSt+vSKSSLZXGNnGG7A+uImE46t2CeDEPLC9Y?=
 =?iso-8859-1?Q?pP6jLmVg3srCna2VWSrL84OOMzbctnWaOa2BMIy2SgEo4JiQNf8FKmJI2Q?=
 =?iso-8859-1?Q?Llpt/8+P4T0xJZlCbc6KlyppXNww17Pwoq56DAGQSraqDEInbLNKit+k9S?=
 =?iso-8859-1?Q?kEk1s7HH99w6DvL2w77rcXHd64a/KSz9GWP6UhEBj+3GtlLfaUyLWKAMi2?=
 =?iso-8859-1?Q?1hBTUt9exF2HKtxyWESTjsBksaqg8T6UGXWuEDx5e/LQlllP7OTQgAKIZP?=
 =?iso-8859-1?Q?fjW1e0aNl7mhnw2QjvLa8l05cvZY6FEX9MgOwmJbgW+XGR7m66A/WvKQJZ?=
 =?iso-8859-1?Q?X29L/MQDocAd0z9+v8vxqF9G1Kzf0JKRbHyEBgNRDoYOp7EwEQmRWhQTKE?=
 =?iso-8859-1?Q?To6aj8/+DJuLxrOvlTAIRUeF5biVoZ6OlONImIcIrkqiqRqHgut9F/G0Q/?=
 =?iso-8859-1?Q?3qo/gyOdzBM4v/GtDpABr2MxvKsoYi9EMqdLqZpoC2NcwBnChJKvEMJlFp?=
 =?iso-8859-1?Q?l7xZfZqmCsXuKMEXShBvTLQReDraXBcUPItDS8M7V0bPkf5wkfAClCHE57?=
 =?iso-8859-1?Q?eiaF0jNxjHpdU1ICMC6aS13mvG/MR3Hbr2CXSYJW51G/Tn6TlZoToKstHQ?=
 =?iso-8859-1?Q?YPizaypLPz/NasgLJxbt6vi5fTHlfjBe8u7mA0dZCj57kMRHpy0IEwSI1w?=
 =?iso-8859-1?Q?eR1qjAKJFp4heD1IdrtC/ZDpsk+0yZyhtZbqtBQ5rkkbTrJ5JkT1H+yW5x?=
 =?iso-8859-1?Q?68HtyNlgacW9vL/29FK9oSTahvqooO7f3TYOaEcYlrHX5M0H6oeBM/TZRL?=
 =?iso-8859-1?Q?aQSCWt0nl96kuZu/O1g1q3?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR10MB2610.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?EKAXNjRIXPAa4khvDAsQ7KRWmBxLWG3Ec8N4T7LYYxneawCFN7+QDAxeBO?=
 =?iso-8859-1?Q?IN8AdGHIuVXC2pbBv6pcl/fL8L3yjBndSgqECnuQCc/BiCiX6qPhTcdErU?=
 =?iso-8859-1?Q?PhxdIYgdpBJL/c5je5UkRCIpzue2lZhzGp7OuI5z7XqNkyMKnpjq6hgogr?=
 =?iso-8859-1?Q?0myW2MxJ9WGGAm8boflLySTuy4aDY/HGkJVa1Uaj1F+gWPWoD1UtDUBEmC?=
 =?iso-8859-1?Q?JsYt3hHnWyzUbaaFWZWv+XohC04e63Bx+vK449jijmAUZvkVota7hmrImk?=
 =?iso-8859-1?Q?sTucABi+nVOL5ni+CnB1//r/YS8jsvpdkG60E03n2bHXFhGPfjidy3eTra?=
 =?iso-8859-1?Q?W5wXpQYYeLibYg282B57YC0z6xdmZG8hMKfZFlL6ZoNU0Db8QOcXMG83sH?=
 =?iso-8859-1?Q?YOt7/hfvmDihkUdVDFyuPsZuLju5q/Ts62oBAyDmoiA0z0Gcb2R6xnVWFG?=
 =?iso-8859-1?Q?+VvR/Ns8epT6TcBDSa4CJjmRekd3JMf437Evv6xYLwlwzqMl8nyAYoxNgN?=
 =?iso-8859-1?Q?7FbAVi9OOuatWbSOG9HtsAD52PM5OzXSH4B0weRjrPfg3rOapkCAUZfjgf?=
 =?iso-8859-1?Q?xa5MgIfKDk22qOI7nXcvu3TpbFoFnMx38XVrxcaZEUTOk30rKUSr/GXuPn?=
 =?iso-8859-1?Q?LZwI+zOUiHzx/FkFaZPY4VAbn+lXK499dQVwnn3OVkEv7Arke7eNas0mzf?=
 =?iso-8859-1?Q?1N9CFnIiHSyRGNrhp3RhJ9WrF6sRH7RcZXI3Gv+Yumwh9IcurwpP8YYMlQ?=
 =?iso-8859-1?Q?/Kv1QIFTxE6CfPjEioe6OTEG0N+N5DsosVwa46FpR4NU/bssgvimbzszTv?=
 =?iso-8859-1?Q?12nxIirppb2jZttuBL/zk0sbrbjrfkcG8v8CufLfETrgAn2xQ8r28IUvww?=
 =?iso-8859-1?Q?y6IK5migtWqfWKGgaIyhDcm2HOp7Jianqhwdf9r5qw8QOmvwPqH8j+92PE?=
 =?iso-8859-1?Q?XjJx0YzFZqEtmNLnsaZYSNTLX2AN9/JiKCiweuoMSb0inRuwrQY7w4wkD4?=
 =?iso-8859-1?Q?whEpRosk+lXX2MPsWf7rp+J1Qktf4UQqaRyysCoJLBGjW0dVMXn2KH/nJU?=
 =?iso-8859-1?Q?T9Gn9/2mEme47Nhr13Tcbi/eXQ4vdXFrMPcz84Daf2UQv52kk1/DQBgKkW?=
 =?iso-8859-1?Q?yEcUkntKiQE+VHFfJ6/wTmHJqU1Y4yZ5pWF6Li4K9R76bDssR8d0hr2fYF?=
 =?iso-8859-1?Q?WT5ij6ne9/foz7B5gq8E0Sg6OHbl8r/VAtJ8F7cWhtrsj+3PXd1Z923/ci?=
 =?iso-8859-1?Q?PDU8WptJzkY9uCLBWu+K9Mtz28+fOwhARuRvAImU6UOYMI5PrPI51Iej73?=
 =?iso-8859-1?Q?f8e9byS53H3uiX9GhWjhMHrE6BZHuRy+Jk521a2DSyT/SJaAeVGb5ru3ZX?=
 =?iso-8859-1?Q?dKu745ioKngP1gTkM0HYMlkZ35JhGKAqJtSwEWSQm9VxM7lh8oKbQ4xo/X?=
 =?iso-8859-1?Q?wYuU+hQuj0+NtjfuC0BvGLt5hZBMQRmena2+IrMSUyhTn6wYqkDVrRvoyr?=
 =?iso-8859-1?Q?7PHYXKwMenYxuCxvuPrCxejyC6vgh8DcCEbZQBK/GjQlkWS5RiNWR8O0U8?=
 =?iso-8859-1?Q?Ppo5XT79Si210f5tq8eYz+kTA9jBXOuojssG3mtvAAp+Jt6qIcKMso1JBS?=
 =?iso-8859-1?Q?Bo4XLr27OBu6pTG4/kU8CxKEuTBX87POJG?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR10MB2610.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a938d1-8bc6-47af-3ff7-08dd1cf81614
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2024 11:03:20.3970 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ihfag9Il0fV43jso14DE3tZ8ZXa72RdtmYjPs2QFWWGx8Uj/6s2coi7lCOairOMcfV3DEQOlmal9FGEEVxeD/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7005
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

In compute_fsl_memctl_config_regs() you have:=0A=
=0A=
#ifdef CONFIG_SYS_FSL_ERRATUM_A009942=0A=
	if (popts->cpo_sample)=0A=
		ddr->debug[28] =3D (ddr->debug[28] & 0xffffff00) |=0A=
				  popts->cpo_sample;=0A=
#endif=0A=
This cpo_sample is lost later which my patch fixes.=0A=
=0A=
 Jocke=0A=
________________________________________=0A=
From: Peng Fan <peng.fan@oss.nxp.com>=0A=
Sent: 15 December 2024 03:03=0A=
To: Joakim Tjernlund=0A=
Cc: u-boot@lists.denx.de=0A=
Subject: Re: [PATCH] FSL DDR: Errata A009942 clears board cpo_sample=0A=
=0A=
Joakim,=0A=
=0A=
On Thu, Sep 19, 2024 at 04:00:16PM +0200, Joakim Tjernlund wrote:=0A=
>LSB in debug_28 register is cleared here so=0A=
>previous setting by errata A009942 is lost.=0A=
>Save and restore LSB in debug_28=0A=
>=0A=
>Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>=0A=
>---=0A=
> drivers/ddr/fsl/fsl_ddr_gen4.c | 4 ++++=0A=
> 1 file changed, 4 insertions(+)=0A=
>=0A=
>diff --git a/drivers/ddr/fsl/fsl_ddr_gen4.c b/drivers/ddr/fsl/fsl_ddr_gen4=
.c=0A=
>index 31c58d9a8e..1f8ff87a8b 100644=0A=
>--- a/drivers/ddr/fsl/fsl_ddr_gen4.c=0A=
>+++ b/drivers/ddr/fsl/fsl_ddr_gen4.c=0A=
>@@ -477,6 +477,8 @@ step2:=0A=
> #ifdef CONFIG_SYS_FSL_ERRATUM_A009942=0A=
>       ddr_freq =3D get_ddr_freq(ctrl_num) / 1000000;=0A=
>       val32 =3D ddr_in32(&ddr->debug[28]);=0A=
>+      temp32 =3D val32 & 0xff;=0A=
>+      debug("cpo_sample:%x\n", temp32);=0A=
>       val32 &=3D 0xff0fff00;=0A=
>       if (ddr_freq <=3D 1333)=0A=
>               val32 |=3D 0x0080006a;=0A=
>@@ -487,6 +489,8 @@ step2:=0A=
>       else if (ddr_freq <=3D 2133)=0A=
>               val32 |=3D 0x0060007b;=0A=
=0A=
The upper will set new value to lower 8bits.=0A=
But your code will make the 0x6a/0x7b be=0A=
restored.=0A=
=0A=
I not understand well on the rational, would=0A=
you please give more details?=0A=
=0A=
Thanks,=0A=
Peng=0A=
=0A=
>=0A=
>+      if (temp32)=0A=
>+              val32 =3D (val32 & ~0xff) | temp32;=0A=
>       ddr_out32(&ddr->debug[28], val32);=0A=
>       debug("Applied errata CONFIG_SYS_FSL_ERRATUM_A009942\n");=0A=
> #endif=0A=
>--=0A=
>2.43.2=0A=
>=0A=
>=0A=
