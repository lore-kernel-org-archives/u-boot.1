Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61643CD11C2
	for <u-boot@archiver.kernel.org>; Sun,  7 Apr 2024 11:48:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9659787EE6;
	Sun,  7 Apr 2024 13:48:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="dPIz1uKX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F5F587EDC; Sun,  7 Apr 2024 13:48:32 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCB2487EE6
 for <u-boot@lists.denx.de>; Sun,  7 Apr 2024 13:48:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZzLGlY6ROv+2pKTBPOzHAHxRGSHUUylyS47vAHohITJfJTvhgIhnXtfDfR6RRvPbBRO20Z1/tfC3kldaGFXRyA+eCEOVxXQIHKKiqBUZMwf/yNW1mtvxqU/cC7BtSvjrtJTfG06tQMsj2sL+oza1jGfkT9TKIP6KYIhxnNMXQsilWgISBPX+IyhnexTcJfE/TwkdeW7JNFVztZ6cYwS8U2HvzPK5t/xgsE+Cf3DMhdNub8A/lQS4i+n/HOQvxPgDALsYJM8iwQiqKww4utnJW9gJbdeD0/G35ep+LVWXrutbNHbES4EXsV6uie0l9xjhVm6Y6az4HHK2px4pGIxMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CslWNctOkdpwCWefaw5yBcSoe9AIGrOfkmVNZIljar0=;
 b=euqoLbu2aYn4L1ZYgYwQokijbzCiDXjjbHePDiPyfEhzOQuQXufteBdMyUuW5+7TwKvfblyeNmMbZ8+F7NtMGKUdbciEZvyBQ4us2SBn2mB5ijSHn+dcZdLJBUcUtKsHJVBfyFFxxBjlKmQPsS+41wBwIPdpfwoLVqKP34gahaq4T7oCXuTwVFYWpZvTaNzOwFzNH/Dlz2m4eGXBvaftHfe9TnOOBsn3fYSFotSOUzLT0MGK7gq18CYIJgA17Qzj0zi5KclE7Lo7EeN08r5koV7HcwdRMU99m0gsaKgUOpWkVVokD+hu5JWYQ35wP55gHPeGioKk1DkaCHN73WLZkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CslWNctOkdpwCWefaw5yBcSoe9AIGrOfkmVNZIljar0=;
 b=dPIz1uKXOWnALGMVWqGXj5JybLJAQ0daReEi84/+6pBS697jUkjYhLsOPLv8ke3HmMhFeBnA7Ch5wUoUmsGU3BnjVanOP0AeUmFSA/vupF+7AZEfvjhLS55p0SRr8Py1eG9gPPMJ0ti9vm5ErfOJrsg7NXD0DtRY24WEpEnstdQ=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB9195.eurprd04.prod.outlook.com (2603:10a6:10:2fa::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 7 Apr
 2024 11:48:27 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Sun, 7 Apr 2024
 11:48:27 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Mathieu Othacehe <othacehe@gnu.org>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 =?iso-8859-1?Q?S=E9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: RE: [PATCH v4 0/5] imx93: Conver to OF_UPSTREAM
Thread-Topic: [PATCH v4 0/5] imx93: Conver to OF_UPSTREAM
Thread-Index: AQHagMVDT80nSMU610ixQHv1ZnD59bFcqpGQgAAA/W6AAAB88IAAFPxA
Date: Sun, 7 Apr 2024 11:48:27 +0000
Message-ID: <DU0PR04MB9417FF25E777EBE3489E009188012@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240328-imx93-of-v2-v4-0-338d15a65c36@nxp.com>
 <DU0PR04MB94174FB9E94F1F74DA64F53688012@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <87v84ta2jj.fsf@gnu.org>
 <DU0PR04MB9417E2AA315B1536D1A1D6EB88012@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB9417E2AA315B1536D1A1D6EB88012@DU0PR04MB9417.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DU2PR04MB9195:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MMfVVufOtttcBAa/DsDZzKuyEwcvTHldnjRFz4LcSh5FUDAeFbgeXPpEAf5TJNmoQk/n/1vfcA0FSKnAc1jMB6rbL6cgKACFaQVKU34qA5XxhxMQ0fiSDJUKR2aHquS8l/spoo/09Y+ZLzx6UqAUHs/iRk18xwkEO4B8oIfHID/+R6GAY0rWlGkydOqtH1MUz737i46lY/3aCF+11GB8KdRzkldrzrTO5ejrfIH/rIxeAfThYgrdtndN2kNaXVJYX1cJHBoc5U5Y3wjwyNZ+Jrcdb4sgicY2acQYFfzpUk0CUp4RihBB82XMuR2nix/DobLmDAzyjIw/JynwlTztWnjAas7r5Icw8dV10vovTx2baxNbKfESX5elXgN4R9/xdePI3WQNSk7ViKO6eJlj228+qe7K+9t9Bg142r4qjBWtgJ7hydfKI8LVCwSkdj5DmnTkBz+3qeTDNdckK403ZptJzSQAs5r5bXyEBnWDXcDFNhRHKpqZGysUBjYI8cPw9RQsyqhBgk9DRom2fwdkpWhGXpyNB72jdJqL0jR6+UfGMKHo4Wfofibp/Qe8w61faH/mdtc4qHXsUqPmtHufOMlXHdjtOu3L9tc3IbkikM4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nNoQEJokAcDRZg5xU++t2B5ZMTlmyJyerR2wiie+5N0ewzRFI1jqrfpLrS?=
 =?iso-8859-1?Q?n34EhV5gqlcUq0M22nTEigsJEzG7PZuSo/zgSZbGM1APVAgPPF7wmEvuYc?=
 =?iso-8859-1?Q?hhZrmBao0N8o0KYuSfNuZq5yIhlbb1Tn2bL/j/nn45QZ9kVyGFKUW9hUFN?=
 =?iso-8859-1?Q?iWMt586t+mnKWIFKmYxU2hkj5MaZcfKxj58/HCAa2JwEJuD7H0samC3D4O?=
 =?iso-8859-1?Q?HOGwFK9MNrFlDTWdey9lffg9kA5qpV3KHbSA4EzvCXZqLCgzxQtE3Q83NO?=
 =?iso-8859-1?Q?ikgIA9fvttxnKE7fWf1YTa8K2UmoFiHf8KLm/JXrF08dlqjaCqgXl3cFsA?=
 =?iso-8859-1?Q?0gwvw57MKAhv1WPwr8vrR3sQkE1xAPNwdEgREqXKDiXLWPIM/cnaxxg/e2?=
 =?iso-8859-1?Q?+fGq7+1HEO7WeVRQUR5y/EIed9ykNh5nGoW/GxFPq3dyfWZziSLZPJ7FAH?=
 =?iso-8859-1?Q?8pAcYqkNHiyumnsKQSc+fFeGdYogJNdzPZrZLBbxBkZIedoi0cI53uTK7d?=
 =?iso-8859-1?Q?0b2nAeNvMfzJUI1COgSg52JuvCZaUgmnJHStc3f4sviWKYmMhVE/QgL2Vi?=
 =?iso-8859-1?Q?HB++h2JjWWYBcwSzgUQnoEpxuTVup2BxFTexQtf9a1acn8WCCTnP0Pdp8v?=
 =?iso-8859-1?Q?ior0m8J61ys//OnxutIS1H2kGou4/ebujmW0by2OPmxnliXpQlYtHC0TKl?=
 =?iso-8859-1?Q?nUwUhJUiDTbbMwW37TA8OF0If4NaXWNIH9I+//QH7u6PZ3CYsRuiut/myn?=
 =?iso-8859-1?Q?AUTicfl1vqII4OOcoc+qHqg36mwyxzgFFMe9ovgT1kfOFunaV/wjrfunqh?=
 =?iso-8859-1?Q?4Fv6E0bRImN9FaCbxZ9d7He5k0EzoJDjGFjfCfe1dZcCn0qnpAworLcWRf?=
 =?iso-8859-1?Q?XbiYXlcffxMMl3N6BuhZZperkH/oyBvmXUo1T0HK3c/pHG6+nBsSkw63Vd?=
 =?iso-8859-1?Q?G0a/DbCl05xX4eGodem/7pZXQErJ52PS/pvpettZRQPm0q817JzyKxwXxt?=
 =?iso-8859-1?Q?f6x1+dcEjwx8UtNtwbskOJ1ipwCYYsYpj6UNiKIeEp/WDT1jebwciNpYUH?=
 =?iso-8859-1?Q?DZRaHdr+MQJRN77/Xa01WWbZD0634XsaDLoNTq/hch6dwHwfqcF7CHnmis?=
 =?iso-8859-1?Q?XzNq2NAfVkBwXF8HwSfdFl2GoyqOPM+0HoPGoAc2v5T9TTcKlN/5baWMI4?=
 =?iso-8859-1?Q?ZqKT0IX7GabFcyYNZv9xc1LhudBtkN4Ly9BFE4E0Q6FMG3aKtboaTs6tT5?=
 =?iso-8859-1?Q?GZzRUT/a6o3IVAhpkA5k3WtIuGQfAB9J1bVh1e86egUtH9NTUDp+FBEzXe?=
 =?iso-8859-1?Q?DV+5Jb8Pb/Vupp4UQ/JIpQ5XYZRoBK8mB4VAAyWFFWphdHqhLoX17Vz1eb?=
 =?iso-8859-1?Q?gUa4woGXvfvEfZ/ZNAC6LRQa030e/NWeKm7AMQ8PxkZgErE152ZrVvnbwZ?=
 =?iso-8859-1?Q?GbWViVYuWnCIOT576aSXdtbNE3H4uz4OrJj3CW8ygdhfQAxBmdwe70tG+z?=
 =?iso-8859-1?Q?fi96q46H9pqw7xn2AyKncEGUEXNrCXxkjOH6iia/pEzqbXXa3l22BQ9v/W?=
 =?iso-8859-1?Q?fpsDtl/0+XQtCYwQDnSIKYaHgUA+AqhjmsVy0bRDgBRNuAq84B993TbjYs?=
 =?iso-8859-1?Q?5P7x0v3K/yPNs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac498716-17ba-4dfd-c6cc-08dc56f8a391
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2024 11:48:27.5771 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DlFZWdGol9X6q2xygvU4XL+jw8AatHVucjIv4rw59CQ8gf4JhQDWhjPUE7LLGfxu/OrIzWGqMiJJbOogBOcobA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9195
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

Hi Mathieu,

> Subject: RE: [PATCH v4 0/5] imx93: Conver to OF_UPSTREAM
>=20
> Hi Mathieu,
> > Subject: Re: [PATCH v4 0/5] imx93: Conver to OF_UPSTREAM
> >
> >
> > > Any comments?
> >
> > Yes, see:
>=20
> Sorry, I missed your comment.

Could you please help try this on top of this patchset?
Seems this is the only point I could think of, that would impact uart.

diff --git a/drivers/serial/serial_lpuart.c b/drivers/serial/serial_lpuart.=
c
index 653ff99e67b..891352293f9 100644
--- a/drivers/serial/serial_lpuart.c
+++ b/drivers/serial/serial_lpuart.c
@@ -486,19 +486,22 @@ static int lpuart_serial_pending(struct udevice *dev,=
 bool input)
 static int lpuart_serial_probe(struct udevice *dev)
 {
 #if CONFIG_IS_ENABLED(CLK)
+       struct lpuart_serial_plat *plat =3D dev_get_plat(dev);
        struct clk per_clk;
        struct clk ipg_clk;
        int ret;
=20
-       ret =3D clk_get_by_name(dev, "per", &per_clk);
-       if (!ret) {
-               ret =3D clk_enable(&per_clk);
-               if (ret) {
-                       dev_err(dev, "Failed to enable per clk: %d\n", ret)=
;
-                       return ret;
+       if (plat->devtype !=3D DEV_MX7ULP) {
+               ret =3D clk_get_by_name(dev, "per", &per_clk);
+               if (!ret) {
+                       ret =3D clk_enable(&per_clk);
+                       if (ret) {
+                               dev_err(dev, "Failed to enable per clk: %d\=
n", ret);
+                               return ret;
+                       }
+               } else {
+                       debug("%s: Failed to get per clk: %d\n", __func__, =
ret);
                }
-       } else {
-               debug("%s: Failed to get per clk: %d\n", __func__, ret);
        }
=20
        ret =3D clk_get_by_name(dev, "ipg", &ipg_clk);

Thanks,
Peng.
>=20
> From my test just now, log below. For your uart not work proper, I think =
it is
> the uart clk not setup
>=20
> U-Boot SPL 2024.04-rc5-00388-g351988e2dce (Apr 07 2024 - 19:29:56
> +0800)
> SOC: 0xa1009300
> LC: 0x2040010
> M33 prepare ok
> Normal Boot
> Trying to boot from BOOTROM
> Boot Stage: Primary boot
> image offset 0x8000, pagesize 0x200, ivt offset 0x0 Load image from 0x498=
00
> by ROM_API
> NOTICE:  BL31: v2.8(release):lf-6.6.3-1.0.0-10-gf12d90141
> NOTICE:  BL31: Built : 09:34:44, Mar 27 2024
>=20
>=20
> U-Boot 2024.04-rc5-00388-g351988e2dce (Apr 07 2024 - 19:29:56 +0800)
>=20
> Reset Status: POR
>=20
> Could not read CPU frequency: -2
> CPU:   NXP i.MX93(52) Rev1.1 A55 at 0 MHz
> CPU:   Industrial temperature grade  (-40C to 105C) at 26C
>=20
> Model: NXP i.MX93 11X11 EVK board
> DRAM:  2 GiB
> Core:  188 devices, 24 uclasses, devicetree: separate
> WDT:   Started watchdog@42490000 with servicing every 1000ms (40s
> timeout)
> MMC:   FSL_SDHC: 0, FSL_SDHC: 1
> Loading Environment from MMC... *** Warning - bad CRC, using default
> environment
>=20
> In:    serial@44380000
> Out:   serial@44380000
> Err:   serial@44380000
> switch to partitions #0, OK
> mmc1 is current device
> Net:
> Warning: ethernet@428a0000 (eth1) using random MAC address -
> 6a:c2:96:d2:68:a6
> eth0: ethernet@42890000 [PRIME], eth1: ethernet@428a0000 Hit any key
> to stop autoboot:  0
>=20
> I see you have:
> &lpuart1 {
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&pinctrl_uart1>;
>         clocks =3D <&clk IMX93_CLK_LPUART1_GATE>, <&clk
> IMX93_CLK_LPUART1_GATE>;
>         clock-names =3D "ipg", "per";
>         status =3D "okay";
> };
>=20
> Could you please help give a look on your uart settings which not work wi=
th:
> https://lore.kernel.org/all/20240328-imx93-of-v2-v4-2-
> 338d15a65c36@nxp.com/
>=20
> Thanks,
> Peng.
>=20
> > https://lists.d/
> > enx.de%2Fpipermail%2Fu-boot%2F2024-
> >
> March%2F549531.html&data=3D05%7C02%7Cpeng.fan%40nxp.com%7C46ad4
> > 24ef2cb4c09f8b908dc56edad0a%7C686ea1d3bc2b4c6fa92cd99c5c301635%
> >
> 7C0%7C0%7C638480826025692986%7CUnknown%7CTWFpbGZsb3d8eyJWI
> >
> joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C
> >
> 0%7C%7C%7C&sdata=3D9oXIZF8Ihp1OfaDx3C%2Bcq9nstWJVhN8u3U7xQAhX2
> > 2o%3D&reserved=3D0
> >
> > Thanks,
> >
> > Mathieu

