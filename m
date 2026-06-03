Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2796CD6E4A
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 07:56:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 526DC848A2;
	Wed,  3 Jun 2026 09:56:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=mobileye.com header.i=@mobileye.com header.b="U20ZCz+O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD0818486B; Wed,  3 Jun 2026 09:15:59 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BCF38341A
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 09:15:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mobileye.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Raz.BenYehuda@mobileye.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VnU/b7daEQiTOYoedzn44LLp2T4eRxRd2vwIZ5vZ3c41lsqqSjUC+GMpQN6qVO/Mx0luCpx2W188FwTBku3Av9Dn1ENVbe4AORTQAdSJLWNZloucZdTCaIfzCOt9t+wV1N5z/+FC5HG3Y/9tmJOJNyt/6G52Od2yZMUcgGYt3+8sckNj/7f5zT0HrxBmGLOOlNM//5xhzuS7KS48lEshe37W+ia8rvCwmSPayvYxs/0LWKl6Ne9WrkidAHA2RK+bRAVf5y5/qnp39mpf74t4gqtXHpvJ4ZeklLd26+r3U8NrfiMLvle0ZovpGn7TAPZI0YcayJGguriXcPNeD4YDmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gD5RwSy8Ly0B+63HVljZ+Yevy9/l8REI88ZcgEJEj3Q=;
 b=vB9jrxiFhWAQwJZgudMru1CqpFWEIBcfuNeKy70bjbJxHce0dFV2oM/NFhvFsNk7cUgq1/14Q12jWctCJ9V6YLQJ2yjP1ophhaYANcuuKDKdLh7/JiXR8lX/7xjFK7DJ5K/XltinpLaCBGALhQ6RkSfDJzIVdUtI47OD1gCS3qd4vpEU8z7OzaLdiYhfxYu8Q0ou50ZyduPRJ+dtMjzZ2idoSNWd17bXs0H33JzkTqBlwjsei+QExmrRZFt0cOlzXOnqC9aEuzlcYNtTJiWGcq7QVb58kLM8WE+kT5m7JO6QYExErf4CDu6KJkJjYnuv4h55AI+h9wFTmeBEX2pG+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mobileye.com; dmarc=pass action=none header.from=mobileye.com;
 dkim=pass header.d=mobileye.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mobileye.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gD5RwSy8Ly0B+63HVljZ+Yevy9/l8REI88ZcgEJEj3Q=;
 b=U20ZCz+Oz2nE+IpcERuiJjSGSLQtTdn1pMTZdfew0ahiP/X5VgzDtuh1ya3yfm/ncPe4EDmNvlisH/hhlMFoD9zX0Vaiqag0jkHgGWZxAA1z9UPemUAlMKfAgibKmZisAs3QFo+ZwBfmzaAr7MIIT5Y4Ctoe2RD8lGM6ariGZWU=
Received: from DB9PR09MB5987.eurprd09.prod.outlook.com (2603:10a6:10:3dd::7)
 by DB8PR09MB3723.eurprd09.prod.outlook.com (2603:10a6:10:119::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 07:15:54 +0000
Received: from DB9PR09MB5987.eurprd09.prod.outlook.com
 ([fe80::a9b5:33f7:52a:21f2]) by DB9PR09MB5987.eurprd09.prod.outlook.com
 ([fe80::a9b5:33f7:52a:21f2%5]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 07:15:53 +0000
From: Raz Ben Yehuda <Raz.BenYehuda@mobileye.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH 3/5] ufs: Extend the ufs user interface
Thread-Topic: [PATCH 3/5] ufs: Extend the ufs user interface
Thread-Index: AQHc8bl5vEKpEbCJxUaZ7kOawXiPlLYpuS6AgAKwqJ0=
Date: Wed, 3 Jun 2026 07:15:53 +0000
Message-ID: <DB9PR09MB5987C525DDB3B576E317F80683132@DB9PR09MB5987.eurprd09.prod.outlook.com>
References: <20260601112606.2278753-1-raz.benyehuda@mobileye.com>
 <20260601112606.2278753-3-raz.benyehuda@mobileye.com>
 <349a932a-ca58-489d-bffa-4c06ce43a95d@linaro.org>
In-Reply-To: <349a932a-ca58-489d-bffa-4c06ce43a95d@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mobileye.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR09MB5987:EE_|DB8PR09MB3723:EE_
x-ms-office365-filtering-correlation-id: d65e184e-5037-4a89-b04d-08dec13ff2f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099006|11063799006|4143699003|6133799003|18002099003|22082099003|3023799007|8096899003|38070700021;
x-microsoft-antispam-message-info: fvnHwXLv9nDUUrBvKJ3qZnWwd/75LhSPeJZFbtmL+YIKI6x7+xKntwrXSVBUN7VOgPwvLt00ZXRFzvYSkydWdyjUF+HBaqoaEbsGBG3qCiClinFArnrji9JL5A4+whkt/3GG/DvHlKIuWRngCprYNetVbITFbeuXagCnUar2RCcnS9J5u4f1iAa0VVIg7SPo2m2hcrTUnnNp+qzoDSpozOhaarMZBk4we0PhgbPjZN9zRcdwyEA67vLhH9rpfC393XeHM1VR/OqcoZVus4fbYJH3vA2J9gBWEI86Eb2TMmpPNCcwbAZgtzR9D17QkfB+X2X0uJFZ42M17IvL0o4uZ5YAKetHt65dHfAKDQ2W7lLtpdFjLhWlnIV2OU0G+gzIQ9Fo2zPpU/5KY1yAkF+ItU0xw6lvEq76jJEICPc671/+HdzPisUjtcfGRqgSxnj2lsvgpSQUspu4dJuUhrCpEstoK5/IzBQun9LumhE9BXu3bL4DHHSDehD1pK6gMDFTyScdKlATWquynZQp8nbsWKbf683kpocP0ySwGj37LnBohbKznMzRv/TrbMNuA/8hJOzjUs56XnNw//Waw4HRpq4A4HwDt7IxtVKdIWWhVVKoxD7KeARLPwDU19x2DObnAcHt7VTRCnBVbiTFo+i5wzsNGUXwjo/ib1XM2+wG3gHyCuNJcbLZq+0mUfwpibSwtkViIG0kE2J/ex4GNX3/ERI+7Yh9+xea29/l9KDzkawO8Ij8LrV21kG2TDmwWWQ9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR09MB5987.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003)(3023799007)(8096899003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fWDTW0wWB9O1hk8p4rZx4EGA+WulJyrA15Ltb04ubJ6Cl5zAEj2Mr4kjzT?=
 =?iso-8859-1?Q?YC3TWoCsRLvXkmCXoXeyHZgyAFfNOQF7b8LpIK1BoxU/H+T6bPTdFCYUGz?=
 =?iso-8859-1?Q?jxPiJYSJ/K9SKKY7txw9Q6HjdvwoZOGbXWXq//U++L680bAg2sN9LfWIe2?=
 =?iso-8859-1?Q?grBQ38ARUHXWLKhMG02/fZ8sfZE00sU4GC4LCtlt+r2lNpNto1TDPAD/27?=
 =?iso-8859-1?Q?FHLh4Dp42TVd4DzlrriPncZpmcigdxPFDydFdPiBFi6X5kPMo/xHUoI49W?=
 =?iso-8859-1?Q?JBmICb5Vaxx4i7G461EwyJys2FZlU50rRURZwcqXCjqbPcZe65fIJdMAzY?=
 =?iso-8859-1?Q?P0YoO4SAEJE8wAWjOlTJ2NPrHmq7zkGbT/76VadRlAK27qxuBw45hdMCN4?=
 =?iso-8859-1?Q?XPjysgaZQxL3sG/OYPvwWfYdShogA6RWcxur5Sv1pR7zHNq3P6v5oIw2e+?=
 =?iso-8859-1?Q?Y32v031yz/2YVH3NPI66G1dXvg8otpvfoEim7ohc/1OobwF6DE8u8/noYv?=
 =?iso-8859-1?Q?nyb/Rdsr9A6eKqWJX6/knTfGLw88GBDtalZUKKL2KvY3hAyAaNa76rZxBm?=
 =?iso-8859-1?Q?vPN/wMuh/a8dRAgtW4Rj3650LLyH9I8bm4AopzPS8Dqv3sZaZHXesAhHBo?=
 =?iso-8859-1?Q?ezcqdPKzr1I0klvaUcTjVcY+Km9JPOZecKX9wBEpeT1/99d2DfkL+mht2X?=
 =?iso-8859-1?Q?cdgeU6JsIeX0PrX9Rhm/Hs3XIQO8HtRIcFOhCTXrUdNIXxk4Qu2SbuL3bW?=
 =?iso-8859-1?Q?hPXukTBug26ftN/IeUm1yBv/+ZvgAdNkOm151Qh206WtdbPQj73U87e9ey?=
 =?iso-8859-1?Q?V7mB6wc2LE5T328YPYxWOOwyoVXdTycXzF+Xx7gZF3p/8MD3fx98RLeAm4?=
 =?iso-8859-1?Q?KhY+cIgc4HUdrTMvEeXit83LD5J3M8qw7+7jN0fxgliozBpVpkYvgJYgjn?=
 =?iso-8859-1?Q?r71AK+1QdlcZ7yx+vDjxfmMlTgkRe9Y9epZbvq6bkLJoE4KY9Mr8+xrMz6?=
 =?iso-8859-1?Q?05ZeXHoqndvDA+zZnzifNWSOTSJB9OReZMGNd/MJ4Ar8efc2ihW4+UPO/f?=
 =?iso-8859-1?Q?Y/K9XURTUs4Hflo1kEPC2wbJk7lf9zniaxn6YA1Uy++YQXb6bIpBKSEH+k?=
 =?iso-8859-1?Q?yGuB4v03jVctA+t01nGSEm1o5kNxxokz9CLNS70senVAMoAfo42zGL3Vsa?=
 =?iso-8859-1?Q?M4sSx27bH8M6Kh9PE0Mty0l1mCixG1HT6yXxQ6AO3+duWhuyjcTE/AfvXs?=
 =?iso-8859-1?Q?V5ULERrR4sbdJqVT/OaqsQfF1xTL/BkXEkzHL+ncZHYg1hCBOdk4xos211?=
 =?iso-8859-1?Q?7IjvhygTzO8IfUwq0HYBl7iIbVQVxuT5ZNMeOiIb01DH+Pa3odNkqb6bRp?=
 =?iso-8859-1?Q?niYpU9/JQabsKmPUnbD+o97kzldlezO/2ELAd17uczP4Nuji7nLREcxF8R?=
 =?iso-8859-1?Q?B2DQ4MzDUBOxvMPIqy18EOQbniDMgECzSi2zALgX0uIZFKuaR7LJuvBZWV?=
 =?iso-8859-1?Q?kUEd+9C36auXM+o/B0nNhHMJoqy49Gun9kQGt3briSzQP20OJaRztBYLNt?=
 =?iso-8859-1?Q?TbjkiNudYC6vqZlk3q29ru4ViWzRxLl/xhSPlSYszfnla6ODD6uDnMDJRW?=
 =?iso-8859-1?Q?vlV4tiSIQEyF1Dw2CDoWDGe/7AH9/PLpgCUP0WPBN98jrRm/av9H1ALdLJ?=
 =?iso-8859-1?Q?XbVeLng8uoG5RgUscm6J3/sJYOb26p7GRbkjYHB7jD3wOFxpdvhK5cGykL?=
 =?iso-8859-1?Q?R65e3UygLwEIo00JmR5GolICIsqbiwaWwj6aOFv52zhLnO?=
MIME-Version: 1.0
X-OriginatorOrg: mobileye.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR09MB5987.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d65e184e-5037-4a89-b04d-08dec13ff2f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 07:15:53.6138 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4f85ba13-6953-46a6-9c5b-7599fd80e9aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ocBnmiEpy5l1PA+Fs3wMrmmphqaxyFx5nk/1uJKDSxI964Pu38yW9iuoVKHdcdpB2pbNGGIIiwi09IrF0/Fnfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB3723
X-Mailman-Approved-At: Wed, 03 Jun 2026 09:56:52 +0200
Content-Type: text/plain; charset="iso-8859-1"
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


Hey Neil
Please see inline answers.

________________________________
From: Neil Armstrong <neil.armstrong@linaro.org>
Sent: Monday, June 1, 2026 4:55 PM
To: Raz Ben Yehuda <Raz.BenYehuda@mobileye.com>; u-boot@lists.denx.de <u-bo=
ot@lists.denx.de>
Subject: Re: [PATCH 3/5] ufs: Extend the ufs user interface

EXTERNAL EMAIL: Do not click any links or open any attachments unless you t=
rust the sender and know the content is safe.

On 6/1/26 13:26, Raz Ben Yehuda wrote:
> Provide a user interface and help to ufs tool.
>        query [lun] [idn]:
>                (0h) Device desc
>                (7h) Geometry desc
>                (8h) Power desc
>                (2h) Unit desc
>                (1h) Config desc
>
>          set_lun [LUN] [parm]
>                  lu_enable
>                  boot_lun_id
>                  lu_write_protect
>                  memory_type
>                  data_reliability
>                  num_allocunits
>                  logical_block_size
>                  provisioning_type
>                  context_capabilities
>                  lu_num_write_booster_buffer_allocunits
>
>        set_dev_desc [parm] [value]
>                descriptor_idn, device, device_class
>                device_sub_class, number_lu, boot_enable
>                descr_access_en, init_power_mode, high_priority_lun
>                secure_removal_type, initactive_icc_level
>                queue_depth, write_booster_buffer_preserve_user_space_en
>                write_booster_buffer_type, spec_version, manufacturer_id
>                periodic_rtc_update, device_version, psa_max_data_size
>                extended_ufs_features_support,
>                num_shared_write_booster_buffer_allocunits
>                write_booster_buffer_preserve_user_space_en
>
>        set_cfg_desc [parm] [value]
>                length, descriptor_idn, conf_desc_continue
>                boot_enable, descr_access_en, initpower_mode
>                high_priority_lun, secure_removal_type, init_active_icc_le=
vel
>                periodic_rtc_update, reserved_HPB, rpmb_region_enable
>                rpmb_region1_size, rpmb_region2_size, rpmb_region3_size
>                write_booster_buffer_preserve_user_space_en
>                write_booster_buffer_type
>                num_shared_write_booster_buffer_allocunits
>
>        flag [flag name]
>                deviceinit, permanent_wpe, pwr_on_wpe, bkops_en, life_span=
_mode
>                purge_enable, fphy_resource_removal, busy_rtc
>                permanently_disable_fw_update, write_booster_en
>                wb_buf_flush_en, wb_buf_flush_h8
>
> Examples:
>
> To create lun 4 please:
>        use ufs set_lun 4 num_allocunits xxx to set size
>        ufs commit
>        scsi scan
>
> To change some value in the configuration descriptor
>        ufs set_cfg_desc num_shared_write_booster_buffer_allocunits 100000
>        ufs set_cfg_desc write_booster_buffer_type 1
>        ufs commit
>
> Signed-off-by: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
> ---
>   cmd/ufs.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 86 insertions(+), 8 deletions(-)
>
> diff --git a/cmd/ufs.c b/cmd/ufs.c
> index 790dab50f18..bb0e2fd3a67 100644
> --- a/cmd/ufs.c
> +++ b/cmd/ufs.c
> @@ -8,31 +8,109 @@
>   #include <command.h>
>   #include <ufs.h>
>   #include <vsprintf.h>
> -#include <linux/string.h>

Why ?
string,h not needed.
>
>   static int do_ufs(struct cmd_tbl *cmdtp, int flag, int argc, char *cons=
t argv[])
>   {
> -     int dev, ret;
> +     int dev;
>
>        if (argc >=3D 2) {
>                if (!strcmp(argv[1], "init")) {
>                        if (argc =3D=3D 3) {
>                                dev =3D dectoul(argv[2], NULL);
> -                             ret =3D ufs_probe_dev(dev);
> -                             if (ret)
> +                             if (!ufs_probe_dev(dev))
>                                        return CMD_RET_FAILURE;

Why ?
Raz: Correct. thx.

>                        } else {
>                                ufs_probe();
>                        }
> -
>                        return CMD_RET_SUCCESS;
>                }
> -     }
> +#if IS_ENABLED(CONFIG_UFS_TOOL)
> +             if (!strcmp(argv[1], "query")) {
> +                     int lun =3D -1;
> +                     int idn =3D -1;
> +
> +                     if (argc <=3D 3) {
> +                             printf("usage: lun idn");
> +                             return CMD_RET_FAILURE;
> +                     }
> +
> +                     lun  =3D dectoul(argv[2], NULL);
> +                     idn  =3D dectoul(argv[3], NULL);
> +
> +                     return ufs_tool_query(lun, idn);
> +             }
> +
> +             if (!strcmp(argv[1], "set_lun")) {
> +                     int lun;
> +                     u32 val;
> +
> +                     if (argc <=3D 4) {
> +                             ufs_tool_help();
> +                             return CMD_RET_FAILURE;
> +                     }
> +                     lun  =3D dectoul(argv[2], NULL);
> +                     val  =3D dectoul(argv[4], NULL);
> +                     return ufs_tool_set_lun(lun, argv[3], val);
> +             }
> +             if (!strcmp(argv[1], "set_dev_desc")) {
> +                     const char *name;
> +                     u32 val;
>
> -     return CMD_RET_USAGE;
> +                     if (argc <=3D 3) {
> +                             ufs_tool_help();
> +                             return CMD_RET_FAILURE;
> +                     }
> +                     name =3D argv[2];
> +                     val  =3D dectoul(argv[3], NULL);
> +                     return ufs_tool_set_device_desc(name, val);
> +             }
> +             if (!strcmp(argv[1], "set_cfg_desc")) {
> +                     const char *name;
> +                     u32 val;
> +
> +                     if (argc <=3D 3) {
> +                             ufs_tool_help();
> +                             return CMD_RET_FAILURE;
> +                     }
> +                     name =3D argv[2];
> +                     val  =3D dectoul(argv[3], NULL);
> +                     return ufs_tool_set_config_desc(name, val);
> +             }
> +
> +             if (!strcmp(argv[1], "flag")) {
> +                     if (argc =3D=3D 2) {
> +                             printf("usage: flag [flag name]");
> +                             ufs_tool_help();
> +                             return CMD_RET_FAILURE;
> +                     }
> +                     return ufs_tool_query_flag(argv[2]);
> +             }
> +
> +             if (!strcmp(argv[1], "commit"))
> +                     return ufs_tool_commit();
> +
> +             if (!strcmp(argv[1], "clearall"))
> +                     return ufs_tool_clearall();
> +             if (!strcmp(argv[1], "luns")) {
> +                     ufs_tool_print_luns();

Make the UFS device selectable everywhere, and return the ufs_tool_print_lu=
ns error
Raz: Why ? these commands do not require any device.

> +                     return 0;
> +             }
> +     }
> +     ufs_tool_help();
> +#endif
> +     return CMD_RET_FAILURE;
>   }
>
> -U_BOOT_CMD(ufs, 3, 1, do_ufs,
> +U_BOOT_CMD(ufs, 5, 1, do_ufs,
>           "UFS sub-system",
>           "init [dev] - init UFS subsystem\n"
> +#if IS_ENABLED(CONFIG_UFS_TOOL)
> +        "query [LUN] [IDN]\n"
> +        "set_lun [LUN] [parm name] [value]\n"
> +        "set_cfg_des   [parm name] [value]\n"
> +        "set_dev_desc  [parm name] [value]\n"
> +        "luns - prints luns\n"
> +        "flag [flag name] Query Flags\n"
> +        "commit - writes luns configuration\n"
> +#endif
>   );

