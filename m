Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0600BCA101F
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 02:02:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FB4D831C2;
	Thu, 11 Sep 2025 04:02:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="goXciSN3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAABB8319C; Thu, 11 Sep 2025 04:02:57 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7468E8319C
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 04:02:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SRt07Dcg55Mcopbx/qQTWrUijl85sNmFTybC3Ypw7GCnHxaekFrUpTyWcoRypfKJDHEpiyMZfPO7KB1Yje8qvn2PljPn5dGjp3ggvsuVNcfr/1GW6z+n3Se/xfC2cXDW8w1B61t1IJ3UT0UZo9cP1Vld8bBmQc8QepyoU8BNQej/ofnQGO+co3O4p28d0ZlLk5oGSubg54mXwGQp0e9nLKcTwn+e3FRZbPYHodjOy2zd4Zg735lA3XVDhQ5ootnTmolZrKYKAe6VWxhZalGmnA2R6fcsO7m3nrTpIooH9JIh3sQcNSZXAGC22ISWrnUhIJcsy2GrkD/aJRKSmuJhmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0Aji73WY1ubJUhp/qMRcK+sPqJyXYBOGjJOCQNAZ1E=;
 b=anvY2Wq/NeiEydwsSZ47JXKxFyMD6CwVA/D0Lo2bLhUS1XkpMQO59teiZza7rJeIAuw+WjQOX91SWy8HG1PTvG/FzsWevdQBr7Ol/YjNkeh+8vjQuGtRHFbVzf9GA0yeGSscZyEkwLSJvZE9xwOV9+Ap0b18tl75Ga5r4bRbqhvZeFOvy1AoZMhPmeRp37/LltXGiHMUqtclXiy1QbB24K49/DZjhl5KDSeqvkNVOzhHRgiWpamzOCWeeJ6y3zKFnjr/XBAOKa2R5xRf0vv9FM967omJY/6oKEjADbB8aOEGHu5DvGNZGNdzRF3KxrJak7tuAOOtrF1mf8nT90KElQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0Aji73WY1ubJUhp/qMRcK+sPqJyXYBOGjJOCQNAZ1E=;
 b=goXciSN3D4AZ6C7cFDwvWiVloeZ4jAXXYLakMN7ogZ/tTTTqVOyMurGpVhbpfDgGd6c7SDMkAboW2I2Urscui1jecr61NKEuaACMaMSNwFfnLjQZdkQxnXuEASFBiDwpqvR2s5F6VrfoA4y+/l5I71o1oh9W9j6tTo7QBRLfrE2KQCT9+9kR6ML0xRgc1MnOv6Jcw7EkwQjznhI+/w3eq8KLyKwsRQzuT7Ek+oPtNEOPmf2JqiIWF4XEjNRO/fjSqOyHcOs8V/hjaTQmhZ9fIK/3xibMWWFAj9cjs54SmXM/pU2JULmbSjZMdbKlOdclfhkpYMutfshmX2gOwrE4kQ==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SA6PR03MB7997.namprd03.prod.outlook.com (2603:10b6:806:42b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.16; Thu, 11 Sep
 2025 02:02:51 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9115.010; Thu, 11 Sep 2025
 02:02:51 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>
Subject: RE: [PATCH v2 3/3] mmc: socfpga_dw_mmc: Enable/disable SDMMC clock
 via API
Thread-Topic: [PATCH v2 3/3] mmc: socfpga_dw_mmc: Enable/disable SDMMC clock
 via API
Thread-Index: AQHcIS9GGkukjaiix0qu7FSI1ZyTL7SNPe2g
Date: Thu, 11 Sep 2025 02:02:51 +0000
Message-ID: <LV8PR03MB8137BAB8967A58D5CCF3718FA709A@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250909021116.12599-1-alif.zakuan.yuslaimi@altera.com>
 <20250909021116.12599-4-alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <20250909021116.12599-4-alif.zakuan.yuslaimi@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|SA6PR03MB7997:EE_
x-ms-office365-filtering-correlation-id: 48935ab4-3591-4494-556d-08ddf0d7509f
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?I3JOAk6TXsaa90VszdVZ5xFMcIvHzzP8pGivu0eZWhezsNEIE7sCa81kMB2d?=
 =?us-ascii?Q?y240VewIN8wrD78WkiJfzyx/8j8fIiUwnZFOuDJQqp20kcE/TZ+tKH841H7N?=
 =?us-ascii?Q?EtckJzzyShWowa2PC9Tzps2ubBZXNh2JENy+zzDyqxsI8Unkv1me8sNxT8xe?=
 =?us-ascii?Q?ckt24eMMojT8JsaJjtSGTR0Z8ttFnJNd3RCUuEzDE8tNRtloBTOq+6ZuMzVI?=
 =?us-ascii?Q?UT70wpiREYFJqSC+5l4Pzc5ZZkoPv6AzqznS9j+wyN5ElCcFMTugai4zsy2B?=
 =?us-ascii?Q?wTZnZhZqdA4YzW4MYVi+5c7e/7ChxYfG3Mb+QkOyjLli1Ti5Roq2cWKW+yaJ?=
 =?us-ascii?Q?uo7kHX8TO9H+PuH7L4pnnW7Or07hd8ego4tqy7PtiskaoaVF4faEzdt7V97D?=
 =?us-ascii?Q?I7Cm0FPcXXwFPMHO1b9/I4j5X5jZV/pSu88Y6O2l76UV2KdB6pE1gdtXF2b8?=
 =?us-ascii?Q?Q5MjRTSB8+qetffeT501yMqKpOHKI1QmaD7iCUt6bJ75LBCPRjebGlyypNh2?=
 =?us-ascii?Q?KlcHH0RFqmzC4HXeabg/VD+CbtNijcXJ2pWdoMhfrPkEQbZh4FDheFrXAQAO?=
 =?us-ascii?Q?Z3S7af1qraPNZ+6ahsg4Ejps5eP0Vu1rRrU+B0dDxKhG9Boj1Hd0QZgfGxY2?=
 =?us-ascii?Q?WL/wSIxswxb4rYZXXYg2/akaOTyyEAzHteCytPiE/xziLQhxnGkTWtXQQBtX?=
 =?us-ascii?Q?YqJCtc0dunJ5V2uGBdWRNbUVnwODKBX0NMGWtcvK24+gqUmr/22NejWrUL+9?=
 =?us-ascii?Q?Vdi0mEVSZPSnEGeDB4gOniuL88n16S5iZE6kM/R8K9L82gNJXvD1K8oDsg5J?=
 =?us-ascii?Q?l7IwAp1zlz6sEXmBoEQHzOyM0kVmOi1KpvFfuiNc1t9wQ/53wcGN2Mm2TrWu?=
 =?us-ascii?Q?peVLnutCrErea93DrZQssyNY+Akup9Wpb+ZSxs+8fsCUyKkfRAJqrmWbVLAt?=
 =?us-ascii?Q?WBePEVj+IgLdssSf8TBUXmFEku8h4aqVsjLQfQgbeVf/IILfhbV+6oxSMaAA?=
 =?us-ascii?Q?iVvhJ9cFojm+QO2aOSCRk1LlV/StZgA9A5QMLpDdhBroHyPLOAqKFmlDwFs7?=
 =?us-ascii?Q?slYE/5FDSv7xyLorTg76q9AH27Dkg4yZqHcylo7pZkjJ95YKh9lCluRvgs+d?=
 =?us-ascii?Q?E/LHuj+UFaaLGPpN5w79JYL+P9zZ1GuiMW1AhOsM1TYB8UjKqvytnrLEXicH?=
 =?us-ascii?Q?5xs/y7n0sjXxPQB4QWEttO5whgk2vxP+ISgJTl0cxoYktDyKiw21TNBWuN1E?=
 =?us-ascii?Q?JsAnludM05gUqMM76B49xQv7Z0ma2tGY3DbZDJdDpcBsZrvdKT+cG1YIitQQ?=
 =?us-ascii?Q?i79xdKOa8oXwx10Bw5W4s/bokjvUl3TtPiYnD7az4y2BBC2PMuCgWj7b/e1+?=
 =?us-ascii?Q?3f5IOUQQfiQ3RPQYK38GdW5uzYyOofKBChrz/JavwS3s0SCwkInpBANEqEZA?=
 =?us-ascii?Q?MhhzRoFCCX0V8rqwhelUIhSqPG2qTBizW/O2O+zlriyH+L4dU9b2zzBIrbwo?=
 =?us-ascii?Q?KeKWmjnkgS4QSmU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WcPgRnQhGLiycc4mC+KVUeaNF96ZwUXn6bWgzi+gwOBdJlSqxfj7eviruA1f?=
 =?us-ascii?Q?7oYg1vHt/oWZpBlT3LY7AwKI5LFYu+lIAmBz4EuGicsZCCtDKr/uVbW9Z0ls?=
 =?us-ascii?Q?UICh7hjvSanf9BJu9uAO/wHrFqPBJdbSVreRB6qdNQydQ5tKpHhEk6p3130/?=
 =?us-ascii?Q?W07AwYhTee9BQmtTZWfcCV299iC007c6lUpr8Dqd1hI0Gmko/BqagWBk15t7?=
 =?us-ascii?Q?VNJr/6PjsR34MwEdfhmmpyI2gRGAzms2YWFRR3ABgA7/fO816maElnZSmb5z?=
 =?us-ascii?Q?scgryCWQLAhTGgBNsiMVz6EGl/KflrNgulsQfgdGoFGG8mDfX2a879bJ+9jp?=
 =?us-ascii?Q?xJJUhIwdCIe7uUqqBqJioikmCY/dvMw/l/zRZ0Co/piaIidyp6J1ZAqCbNu8?=
 =?us-ascii?Q?6q7GFiT1U0KIYYZYTpjBiErYtN4vSs0pjVARmyrE47KdH5L8Dt+budhupb9B?=
 =?us-ascii?Q?QtNrkysxakkD/EdmBv5RjBD2Uabg6v2rK94H4a5xKkyB7mm6VWLrpOIjyofr?=
 =?us-ascii?Q?V23L+IsQpejzmj7xBTeZ+Oxv4Dqb1A2hWucoBEIifEfSAtWgN6FIxHohucU7?=
 =?us-ascii?Q?1arCZQ6+MdBL3HkLH7xe7tHRvw4keTRmrQm1lSCHl20ICqLzO2wn5hrBjq/3?=
 =?us-ascii?Q?+O/al6p5zvNMYwHxaL5Eivac7R3pwhfFV9bjzmrIXlcL18e4nRC8LryVCsMb?=
 =?us-ascii?Q?YhOeDvWatFcaXw80zsk/dV53UNdo4UfzpHpAEPd6/kprIQSvaNjWdatI9Uvu?=
 =?us-ascii?Q?IYrFBEEDXLBTPJOBbsk9EGco/T10LA7SnvkCQs8BvXAX7sRj98BONawDW4c2?=
 =?us-ascii?Q?xCLm1+DpEudZ+03lJbhp78DCqlkamzN2vREWfXzYv8LJ5w5wp+Nv8UizyVOO?=
 =?us-ascii?Q?56ojyI5S/UQWb2STfaGKwDy7Vb9pgQSRjkduJ74H8xn3SeHx40/u6nFFaKau?=
 =?us-ascii?Q?Hjg3NYS/DBF0BjiOT6HW88BMp8Yv829XnCZkXK43/CF2tep7PDhWHH/6aStN?=
 =?us-ascii?Q?LK4VtxSZAC+20d32W+TWOTQ2fUH1AYV19/vsiHfN10yjtvrUGS58embFFDpM?=
 =?us-ascii?Q?bvsOQ3yEjKsf9Q3NTG7M8qvbbfMfsmHYnB5kYKaF4Hb3c21Mqyxif+8QBDIl?=
 =?us-ascii?Q?0HENT2rlnWIUfD/msFBiM6bl/QGfywIia8EMx9+trv29qKPc1MvqiIpP7pYs?=
 =?us-ascii?Q?cVf03DMGfORN0hA6cfuTzbhtzWgIBWwTqR8Yd0Lo9PswTCUW961EmLjypPVP?=
 =?us-ascii?Q?5AcMPXrW1v6ZXqcbFZmmoYvgH6oviEr2fU22xqttQk2Wb7X4q8aE5BRYRdqe?=
 =?us-ascii?Q?ZB/p4neT3rhKt4GkEq0SWNr9PtVhdxsQjcBF2qwtnuAaFipXQ/K/srPPjNns?=
 =?us-ascii?Q?X80B4dMEKpBha7hrnVXIq/0YhEQuhqG4Mr/ibY5N3NpUbRDYwKK9eVImlHg8?=
 =?us-ascii?Q?rgDzLh3MNiy7y/ONN+C/Mr+NMo3qdRArXoey2y6H9l6Sw1v0D76MfSzCHR3J?=
 =?us-ascii?Q?X9DlXt0qz8vAyKoleWnya6BZ65XLIc2d2MpokKs6hT7u3h3Jyrv739AsptkM?=
 =?us-ascii?Q?7UcHEIKGWjmuq1j1pklYPw/i0UdmddWoOp44PGUs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48935ab4-3591-4494-556d-08ddf0d7509f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2025 02:02:51.7601 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LIivf9qy5L7U+Uz84FIM4w42yh59b95yBuudDrPdgRi776rJGCFLeS437kV2ofGk9RYexVaONnxWZKmn83lR9Sj5mzXg+hFTacT964TZ2Xo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7997
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
> From: Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>
> Sent: Tuesday, September 9, 2025 10:11 AM
> To: u-boot@lists.denx.de
> Cc: Tom Rini <trini@konsulko.com>; Lukasz Majewski <lukma@denx.de>;
> Sean Anderson <seanga2@gmail.com>; Peng Fan <peng.fan@nxp.com>;
> Jaehoon Chung <jh80.chung@samsung.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Simon Glass <sjg@chromium.org>; Marek
> Vasut <marek.vasut+renesas@mailbox.org>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@altera.com>
> Subject: [PATCH v2 3/3] mmc: socfpga_dw_mmc: Enable/disable SDMMC
> clock via API
>=20
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>=20
> Update the driver to enable or disable the SDMMC clock via clock driver
> model API instead of doing it in the driver itself.
>=20
> This allows for scalability of the driver for various SoCFPGA devices.
>=20
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>  drivers/mmc/socfpga_dw_mmc.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/mmc/socfpga_dw_mmc.c
> b/drivers/mmc/socfpga_dw_mmc.c index 3b86bc9b18c..db4e0129c2e
> 100644
> --- a/drivers/mmc/socfpga_dw_mmc.c
> +++ b/drivers/mmc/socfpga_dw_mmc.c
> @@ -29,7 +29,9 @@ struct socfpga_dwmci_plat {
>=20
>  /* socfpga implmentation specific driver private data */  struct
> dwmci_socfpga_priv_data {
> +	struct udevice *dev;
>  	struct dwmci_host	host;
> +	struct clk mmc_clk_ciu;
>  	unsigned int		drvsel;
>  	unsigned int		smplsel;
>  };
> @@ -51,28 +53,23 @@ static void socfpga_dwmci_reset(struct udevice *dev)
> static int socfpga_dwmci_clksel(struct dwmci_host *host)  {
>  	struct dwmci_socfpga_priv_data *priv =3D host->priv;
> +	int ret;
> +
>  	u32 sdmmc_mask =3D ((priv->smplsel & 0x7) <<
> SYSMGR_SDMMC_SMPLSEL_SHIFT) |
>  			 ((priv->drvsel & 0x7) <<
> SYSMGR_SDMMC_DRVSEL_SHIFT);
>=20
> -	/* Get clock manager base address */
> -	struct udevice *clkmgr_dev;
> -	int ret =3D uclass_get_device_by_name(UCLASS_CLK, "clock-
> controller@ffd10000", &clkmgr_dev);
> -
> +	ret =3D clk_get_by_name(priv->dev, "ciu", &priv->mmc_clk_ciu);
>  	if (ret) {
> -		printf("Failed to get clkmgr device: %d\n", ret);
> +		debug("%s: Failed to get SDMMC clock from dts\n",
> __func__);
>  		return ret;
>  	}
>=20
> -	fdt_addr_t clkmgr_base =3D dev_read_addr(clkmgr_dev);
> -
> -	if (clkmgr_base =3D=3D FDT_ADDR_T_NONE) {
> -		printf("Failed to read base address from clkmgr DT node\n");
> -		return -EINVAL;
> -	}
> -
>  	/* Disable SDMMC clock. */
> -	clrbits_le32(clkmgr_base + CLKMGR_PERPLL_EN,
> -		     CLKMGR_PERPLLGRP_EN_SDMMCCLK_MASK);
> +	ret =3D clk_disable(&priv->mmc_clk_ciu);
> +	if (ret) {
> +		printf("%s: Failed to disable SDMMC clock\n", __func__);
> +		return ret;
> +	}
>=20
>  	debug("%s: drvsel %d smplsel %d\n", __func__,
>  	      priv->drvsel, priv->smplsel);
> @@ -92,8 +89,11 @@ static int socfpga_dwmci_clksel(struct dwmci_host
> *host)  #endif
>=20
>  	/* Enable SDMMC clock */
> -	setbits_le32(clkmgr_base + CLKMGR_PERPLL_EN,
> -		     CLKMGR_PERPLLGRP_EN_SDMMCCLK_MASK);
> +	ret =3D clk_enable(&priv->mmc_clk_ciu);
> +	if (ret) {
> +		printf("%s: Failed to enable SDMMC clock\n", __func__);
> +		return ret;
> +	}
>=20
>  	return 0;
>  }
> @@ -169,6 +169,7 @@ static int socfpga_dwmmc_probe(struct udevice *dev)
>  	struct mmc_uclass_priv *upriv =3D dev_get_uclass_priv(dev);
>  	struct dwmci_socfpga_priv_data *priv =3D dev_get_priv(dev);
>  	struct dwmci_host *host =3D &priv->host;
> +	priv->dev =3D dev;
>  	int ret;
>=20
>  	ret =3D socfpga_dwmmc_get_clk_rate(dev);
> --
> 2.35.3

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong
