Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553E0C25B5C
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 04:16:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A406E88739;
	Tue,  7 May 2024 06:16:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jeM7pK7z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B70688738; Tue,  7 May 2024 06:16:27 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD99187E62
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 06:16:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KuPrLLGMsRUq0Qj/WfpLlR88ozuWaHLXVBXQPvFipWHMR5c74l/fBCLlVTkxvTtqKBtoJRIXO47Ox+U8i/PbkAWQYq6OYYFPXspXnvwwunKCiG/iYL5jQlIazmsy0WwjZ8CZ47F7eayEidSYhsrRcRvPSBJD6KJzDH6xnzaSq+5iHW/kU6ThecqzHGQ7EG+8iY9TjEkDd+80pFDnpAAu+hIZ+eO+vdgJPoMxZK9VIRqGdqeyzIexIBJ0o/vdd9EnX/VNfcahIJIrG40Wq5DylgU4j81ST3H5qa6/3JHJyTWz2srwg0w+9MjNnipnIZ5NXF+n1Cd+kIIahZOIXoUgsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRweuZ3DWi1Ho+m/WzYdKF+I7TGM8qpLewFUJTrEA7Y=;
 b=cUPGjVO6bhcddbVzJCtAf3zI/b4b0nlG4ztXkav28khkCa2O9FDTjJ6KHHtGksjg+xyitMmm+tQcr5JDCRw2wlENIJ82fQuOjG4gPRcsPNtJQPvhjzAOQRhEKHceOrTm4ouEqthX4CF/FXsMg1qHaRjWmpyoKJc6mnzDrxezZLdOpVYSH0MCDt6LUPIgbtskgn/BsNsA5iRm2IM0j++cU5di2sKpxk3r2SaOXh/jiM2fdODp9QsGnCQM2aOggsuPyN+SwctaDFHtgSZKFjLZ0rp/h85izxi+F+68XK62EEqM/1BKEtJU3aaIFsbnRs3ZVrcAxIM48KR6kE4sNU/KOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRweuZ3DWi1Ho+m/WzYdKF+I7TGM8qpLewFUJTrEA7Y=;
 b=jeM7pK7ztwOMwtGzPSwDZdY3K7eEJnEVA2WpIefe248Dd12AdiKeqXAq7ah6hwiy+mcc4Gs0Ak8bkYdHm6lX0JKEOSfE3kyy+fUlLumLwvuKJOc+ofCPmW1Mdfxpby5oLWh+BpqUmNMSNNJSCh4rXgXg2Am/m2RQwJjaKCbaMZU=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by IA1PR12MB6258.namprd12.prod.outlook.com (2603:10b6:208:3e6::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 04:16:22 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 04:16:22 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "peng.fan@nxp.com" <peng.fan@nxp.com>, "jh80.chung@samsung.com"
 <jh80.chung@samsung.com>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH] mmc: Change the frequency to MMC_HS_52 when selecting
 hs400
Thread-Topic: [PATCH] mmc: Change the frequency to MMC_HS_52 when selecting
 hs400
Thread-Index: AQHalT94JBudbfSZvEC+wXbrfMltXLGLQAag
Date: Tue, 7 May 2024 04:16:21 +0000
Message-ID: <SA1PR12MB8697A5B31B35116E6DF70B2B98E42@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20240423053057.15863-1-venkatesh.abbarapu@amd.com>
In-Reply-To: <20240423053057.15863-1-venkatesh.abbarapu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|IA1PR12MB6258:EE_
x-ms-office365-filtering-correlation-id: f591de35-493b-4b14-5472-08dc6e4c73e0
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?oOTe4MYZ+Hr20z8NGp9g/paTRHOZS0TaPjZprvhzyEg9Q415Qk4bwDzARbJn?=
 =?us-ascii?Q?ETgUaoh3ALTx8Yn+TbpIWgyPjW204miz8f00o3z84kt9mrCMQt1xyyqmBdLx?=
 =?us-ascii?Q?tzxjHAghd8uP+asqFjnNcF0MdFFDC5+VQqP4WyqXanQTgy9WuMlAcEinuRZ/?=
 =?us-ascii?Q?dmQambG9RX89fYOm9gU5vgNqeCc7lXi4DqSIbX+RXjotdoStCueMzI9LlEcV?=
 =?us-ascii?Q?UXevpo8CM9YZMpM1e+vvgunCVpd9N8MfHcvCZqPP8V0QHX4N/kZTawCNDf96?=
 =?us-ascii?Q?stopvVz+xsvtqBg4bx9q7Fu1Ob0pRUrPxqYOi9PByweqQ5DyjtQKEyOmFXAn?=
 =?us-ascii?Q?uOmmbeu1vfFwU02XwvKM+pp3VyDQw3XefqwBhTYVdThIyirEr712RrCRusXM?=
 =?us-ascii?Q?Z8bR+tl4Bq28r0xiI71ZtYemfUj+sNdgSgme5rI0NiX9kKQ9+Vlnkb43TkK1?=
 =?us-ascii?Q?v3dWfxlYi4QVedFUjN2/rTiBsRpkqe6VPh/azgewMijX+0aaH4L4QJBgjCmJ?=
 =?us-ascii?Q?n+5goW4qRBjeJsiF4eNx+5W0PReeXO+TKiVscBOA75lViIeBEmsYWpq5/vC8?=
 =?us-ascii?Q?jrV40SNUfSNaWpoUqQqMAWR0hDiHlRDF8YJIVWeOayDufy9Yb6maPPyOh7Pa?=
 =?us-ascii?Q?V38mxk8e0APwyP7wIAVkNh/Md7OHXQo4BtHOnROGZgw3sSRVfn20u7+5N31n?=
 =?us-ascii?Q?U/oZJM0wSPgu93/iVOVlQrIfP/Ww0Z1jwlnP3HE9mfwGWzT93wPuxj2zpGY1?=
 =?us-ascii?Q?gnzwp5wxn5ypN0lZsZobJkKFf3nQrMgjKcry/BVFFjKNuS1nsQeAegJTTyHC?=
 =?us-ascii?Q?HNZkS1MQSF5C8IWLb2zQAZkeSL2pcbk5zwa0KqGTdZxY0eFwWxvf5xiHOP90?=
 =?us-ascii?Q?uSVRlwT575JUF8eWl8FrB3Uy6F1NpX/BbV+zmSwnhv3m++7qtIHSd/CM+j1Y?=
 =?us-ascii?Q?r7VxcMpNPumMLDJ4NYtbsfZI4oaFFU6tBSCOe3rssXG7tY+ijBmkCoMovVF4?=
 =?us-ascii?Q?yYbcrAoZefTXvn9fW7FVrRd0izSQ1Xdm0uj82AceWp9LDh6GxJg+937b2Jcs?=
 =?us-ascii?Q?x4R6RKGBMg0+wjhWeVAogi3x+EdW4mI/oKfv6waQkapXt1g35KRqBDFOmQEC?=
 =?us-ascii?Q?ameblxOWDs9wTbuy+7Kd1mmW8P4FcVGZcftc/FW4JFvhwMoNCv2qw8Dr9eHD?=
 =?us-ascii?Q?VVKkPnRanDG2Ma/Rud5XLQsq+FkMO9y7Q3eIMCm3RcWj5Q+cXNIpxLkLs2bJ?=
 =?us-ascii?Q?kJCF5Jw+u4v179+RIfrTRe5f78/o/5TA/sjDMjKZNHvY/CA9pvb+wKK3lLl9?=
 =?us-ascii?Q?g+ngH1pX5neEKTPN284TkwtFQFaD4TqtKr9zvbM3TZmIXw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dr2xzVI4wAD7809hQwhjhjx3WC3K5QCZPaS3mRYO4NfNVWPX1toHHNB34lIm?=
 =?us-ascii?Q?p17dYIv9fzYkA6b4YWou+Fs424xutglXX3HiK5D2/3BmpFp+hbWkpKhpCq/Z?=
 =?us-ascii?Q?ig6/LKdybeNPfQuo4N0FnQIoVbWDSTXp729xNBbyzofSNAYSpX+oVYfiWuP2?=
 =?us-ascii?Q?mjRHXCeYrZv3OH0uXAreEe8fucoIZY6Ae5YeT/jJLHNSrYXJl8PWvDhr6O0S?=
 =?us-ascii?Q?sNYeSlfdyStdgaRFWTJu6jxm0jItIvi0YL7K4xJbtSh2nlZXqBzVKZtRK6hB?=
 =?us-ascii?Q?cDNMC9j+l2jO6khXiLgKVmoBIjre1idG5OtxSITe9wW/pU0A6jZ5a/bU14vC?=
 =?us-ascii?Q?fW0db+hlR/ooefewAlp8wwTA1A8fPvywQLee1FMXsw8fUvlcJ4dY/CxXZepv?=
 =?us-ascii?Q?vgSALik3vesReMbUHhxwvXK1obanAHbVWOldGxS5m4cLFbjj+6piLmk/Xf7N?=
 =?us-ascii?Q?WNDyVSPDYIa/3oUdvbniZ7ANwhpPOK+6HOoOT8wWojDbJXgL/xvYQI/ldgF5?=
 =?us-ascii?Q?Pb/+Q9QX7DTCbfkOYTnW19uqgURHSkM3VRNnD7BvWDdrJI9xMcW85s1DEUG+?=
 =?us-ascii?Q?6y8Oazz7JsFDKVt5RL/0h0O8wqGahCdn6dls7W27keyZ/0Ji1NbD1I32rF0Z?=
 =?us-ascii?Q?nCR5r4EqwgXzvKtiSrOROo3YMSjqEV7f4QMYC8HEEo1Lx+3WMDZ2ePj9PZ2L?=
 =?us-ascii?Q?4cgveTzUfPcgQQ4YEpcE5kK6XkxusJ3NVlLq2NFieR2qKNd0haz//RdJQssQ?=
 =?us-ascii?Q?Y7eiQT7Y+qKbS+v6OtDjv9yZ/demGb+Zze5VT2UTLPr+Y2UjLFaEQsnkUp7r?=
 =?us-ascii?Q?97bRYTy63nucrXhC7eYP3sYw1E+H36zi8MEDDToaHgYXbxrKo16zYuaZBgzt?=
 =?us-ascii?Q?j5czaj6WE2UT3cZol6/t9XWJKwndPfRzQeYyD3GpQoXES/4jqlk5I0RoulJB?=
 =?us-ascii?Q?JmiiHjlZKxitA+79b/tWsdzkRAeoy/eq60Lbl+35AnD13LOtSPdpAWIysMo7?=
 =?us-ascii?Q?jWOdUOu28mX0n2/qdgKdD+XNB5VaBkFqa+0pGolloOPunm8zJwoyou6LeP0e?=
 =?us-ascii?Q?1Q5u2Ly0AuwELlAA9WVdPBmv7AKfmKVl9DOe8BL3FTg9YZXSgxrv9UchjlLP?=
 =?us-ascii?Q?6Kj0eqv8ScQ74C77vmwzbu8IRZ9UY8UH3JVNozV/JZGa7bUKOYj+enCOoxhh?=
 =?us-ascii?Q?K2xTWyCwlgaPg6NpqmTfP4Lkif5za8sSU7EHcIo7y/qRHsgohlPOByeGQYi1?=
 =?us-ascii?Q?sliDPaiZSWl1FejuLCwmk3XHda0I/S+FCFq+shEcJrhv/aHz2a/yp7q93kzZ?=
 =?us-ascii?Q?dKUQObUpTSJ+Oaxn2SKc4BcwkRH8BNzs0CLfs2NLEJ/ShiMlp+3uVvRaNvrq?=
 =?us-ascii?Q?vrCYRi7wQjBnfdHXC6q6+rmdr6fBztuq6+LyMSPf95F201AXgfXp0F57VEU+?=
 =?us-ascii?Q?WaEune9A5nesjFgr8IxPWxIEYeg00908xvrFUzmQcSJMXAksoVg1+yKmipwT?=
 =?us-ascii?Q?bvwfh1KBG1ila4TeMVxd9k4pgOkDafQim/kOoRyL2mXOvEACyRf+mcgwiG1Z?=
 =?us-ascii?Q?Yz0CEe6EMQwGcPGLHfs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f591de35-493b-4b14-5472-08dc6e4c73e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2024 04:16:21.9985 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NfPSQALCFzEcqzRoRYX0eAJ3kElKD6jVFcpqkaoYxpt6TTz6XQU0RLqOYWOikszUPwo+eN3na8IuHhx/mRq7PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6258
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

Do you have any comments for this patch?

Thanks
Venkatesh

> -----Original Message-----
> From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> Sent: Tuesday, April 23, 2024 11:01 AM
> To: u-boot@lists.denx.de
> Cc: peng.fan@nxp.com; jh80.chung@samsung.com; git (AMD-Xilinx)
> <git@amd.com>
> Subject: [PATCH] mmc: Change the frequency to MMC_HS_52 when selecting
> hs400
>=20
> Per JESD84-B51 P47, host need to change frequency to <=3D52MHz after sett=
ing
> HS_TIMING to 0x1, and host need to set the 8-bit DDR buswidth. Currently
> setting the frequency to 26MHz and trying to switch 8-bit DDR buswidth
> resulting timeouts.
>=20
> mmc dev 1 0
> Select HS400 failed -110
> switch to partitions #0, OK
> mmc1(part 0) is current device
>=20
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>  drivers/mmc/mmc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c index
> 7b068c71ff..a2ed99aefe 100644
> --- a/drivers/mmc/mmc.c
> +++ b/drivers/mmc/mmc.c
> @@ -962,8 +962,8 @@ static int mmc_set_card_speed(struct mmc *mmc,
> enum bus_mode mode,
>  	 * Extended CSD. Reconfigure the controller to run at HS mode.
>  	 */
>  	if (hsdowngrade) {
> -		mmc_select_mode(mmc, MMC_HS);
> -		mmc_set_clock(mmc, mmc_mode2freq(mmc, MMC_HS),
> false);
> +		mmc_select_mode(mmc, MMC_HS_52);
> +		mmc_set_clock(mmc, mmc_mode2freq(mmc, MMC_HS_52),
> false);
>  	}
>  #endif
>=20
> @@ -2043,7 +2043,7 @@ static int mmc_select_hs400(struct mmc *mmc)
>  	}
>=20
>  	/* Set back to HS */
> -	mmc_set_card_speed(mmc, MMC_HS, true);
> +	mmc_set_card_speed(mmc, MMC_HS_52, true);
>=20
>  	err =3D mmc_hs400_prepare_ddr(mmc);
>  	if (err)
> --
> 2.17.1

