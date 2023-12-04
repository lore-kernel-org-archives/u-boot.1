Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF92FC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 10:26:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F11E870D4;
	Mon,  4 Dec 2023 11:26:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="sYKi39FW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBDC78718E; Mon,  4 Dec 2023 11:26:53 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::615])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E60686F1F
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 11:26:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=treding@nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AK2S1Mg5bPNHTaVF+B+ox0iM+1bg5nhTLrnVtBIdfXuDmTuov7xaibtpKv4+HvQTDe3RUdjTQRZtlchDchJfbN2Nhfbqdfl6dVxxOHD/UJolebSwijYxTc1qGD0FxX/TSKDiubeggyDoNo6zJp4lxJ6HmWQJrxDi/2qEwNbj/enjYKYRb4533roUtQAaVMt3hjP2AuUHxG3HYykcQZXSdJkp/XQFVqL8pylJtbymToJs0oAIJDHbqPLY/MVt+rpdPeRO6Kbv7gpRB7Dq8sc98eFfTvoLAvDeQ3BlS9m5pTonUCM6HjcoTmjBGLyvIH+h11loZXaq/oXsM1ZcErQPsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xXfI57zPaDiDlHWbFFDUXw5PmvD6ZUSE3DP2YHz0xs=;
 b=CoowmNaLu8u53xIa4f9lOrDAI6lKxNpfSPFhlgq+SMA+9PDFC2IaP9Rh7NJILsSmSZf1jsly2gZGqNhbmNHLCqs7L2fdj4BcZ4EBPUXwNQAArMlBCJ6ZaJXrRcS+llcTmHP3YT1F4M0sjcwAb3i/zNuXY21wUh8vePNclNe723qYlq3QE2i+6Z3yv7GsqnVW3HENjklj2/qMpUh1+YGAdlUoqUpltWbpBvRoMVz770TD6J+Crnr9Etsf2XwlKT0GMS8U7dE+t2V4TkoX9u8ljHLDns8gFhD+jcuAUbpQ32X1gee6XN8nzdBTgk0skSQd4ge9piA3vN0if2iTbfoZgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xXfI57zPaDiDlHWbFFDUXw5PmvD6ZUSE3DP2YHz0xs=;
 b=sYKi39FWHLpPF5lWdF9tPd9NgXpAO5k33guHxGR9M/BCo6jfWRNHMqFZ9ox8pnQ98R0Ba/eUYeQIvLlOb8MoUV0O1Yu6kCtyBThTv429myQEzRHV1Ee5P/I2yR+ZQZRWNCD2CcW9fclIvmhhCimfYnMYQrs1X59UgusXCFZiy2qBD/E8Ugm14CsKOILzhOm30//Z19oEs17MTBj3RcHYUq3GHcSbRpNJbQRIjVgA8Z9bWz3KWiaPQsqSgfQyj/CGQKQmdt+88gNGRmS8GDSAQZgBLbIZrT9zq08cRzGevabjC/N36YIcp47J6NN0gl8w3RoPCPZqk5Ez6wI20b/j6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) by
 MN2PR12MB4093.namprd12.prod.outlook.com (2603:10b6:208:198::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 10:26:48 +0000
Received: from DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::929c:d330:53e2:c5d]) by DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::929c:d330:53e2:c5d%7]) with mapi id 15.20.7046.034; Mon, 4 Dec 2023
 10:26:47 +0000
Date: Mon, 4 Dec 2023 11:26:42 +0100
From: Thierry Reding <treding@nvidia.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Ramin Khonsari <raminterex@yahoo.com>,
 Jianlong Huang <jianlong.huang@starfivetech.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Emil Renner Berthing <kernel@esmil.dk>,
 Kuan Lim Lee <kuanlim.lee@linux.starfivetech.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/8] Convert Tegra pinctrl to DM
Message-ID: <ZW2pYqo6hjGqKo_-@orome.fritz.box>
References: <20231204082054.4943-1-clamor95@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Hh63upjq2xRxcFOf"
Content-Disposition: inline
In-Reply-To: <20231204082054.4943-1-clamor95@gmail.com>
X-NVConfidentiality: public
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: FR0P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::9) To DM8PR12MB5413.namprd12.prod.outlook.com
 (2603:10b6:8:3b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5413:EE_|MN2PR12MB4093:EE_
X-MS-Office365-Filtering-Correlation-Id: 9733149a-09af-4e1d-0fe8-08dbf4b38562
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uUwQiY9cA82UtrHZI5GPqg/1R7EKzLUeIh6wN8bxgB7qSVik6TtAocEDOYkk7k6JxVw/lXBa5NhJlIQqa3waubWBpRbNBuL0SIVr7GXRH9kowX9OMxt8SiZIOhlYNEJB471TlwLzWML44bEwnQGwXLJHjDX+nqFs5lchs6J5ToqLgQoB5BRqiVyl3uek1DrJbGYBJVaavE1dEsAOExSVv04sxZpBV67mx4xuxqDvEA6SQS80z+ih1mRxb1mOGJ3Ht0LfFCj4+WboskHStazD3SZzvmyqJggvVQKMsst8s4HpEW4aIw0GFRY040Oh0W6gaIqlDmH/QqUrpar+r6m90siPYUF8pXdq6C9rFX0Q4bxAzzVAYXwz31IIoXUL2Xoj0cJg3WKgjR4gg175T4B6HML14mqsB/uJy6SDPJCr1nSI05E0f3VoWxI8gkR42KAivpNgYIkPaOIDdypYvRwacoeBw5zM9pknbIcPjIPULmeAj7jc0oGPSWS7Q7o48GekbSaIrCigoRpT+pmIArZIXViLDOXV2c7pimLPoOW2d3cVaJDV4PTTnIqVetZ3w6Pn+yZ9HCCtbRP7g+rYLeWGrykNhZgIe9+FhTiEJZyu7+aUvHKBZHdRAgiWfFtDGjJE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(366004)(136003)(39860400002)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(478600001)(6486002)(21480400003)(83380400001)(44144004)(6666004)(6506007)(9686003)(6512007)(316002)(6916009)(66476007)(54906003)(66946007)(66556008)(38100700002)(5660300002)(86362001)(4326008)(2906002)(8936002)(8676002)(41300700001)(2700100001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GJ5Rjl07lJvQ2QcPpbS38Do5VFy/J7D8xAzooyMbjoxxVWLhI0vkDbZBKBFW?=
 =?us-ascii?Q?yH4UjEa0yLp05+nh4L31qzIzamMeH8GqwF+ihvSW32SvZaLmcky6y+wP8qdd?=
 =?us-ascii?Q?mtxQaffYY1npd36VWmlqo3Xc9HrKnL1dpb/twN+0/7dhm3wd5AYQmXQXrkvs?=
 =?us-ascii?Q?o+2hLc29SbfRd+AHdbFyBid1nSsYilIVlpmndE2F2a//1ciYw9bg3KGEc5bm?=
 =?us-ascii?Q?BnRpyNjqguyLCW3KOqDwy24Sf1SGqwb8DBDi5v93iooiaJqihCz4lY1Lk1ws?=
 =?us-ascii?Q?hmtToDVwA8Mg7NAfY1WAQ84gBbK7DzeFB1bDdsQOA2rqNHwyq4Ls7Ev3gk4C?=
 =?us-ascii?Q?A6FQlBkoglpASBlOEMvDMEilTIVp8SwG7hgCcAH7NYpxQjcZccGr9rsEJnjU?=
 =?us-ascii?Q?LPnzHHsXii7jnwWoPdw7qAz/6W++Byahmknx3vIDzk+TQ7qr9+0lWtScbo94?=
 =?us-ascii?Q?7dhwAsqAdooF7/I1hSRETbgilhO4Kuo2/FaxwreM6M+ITotbCNOYTGzH1SQK?=
 =?us-ascii?Q?2+iNBltYPDEEMZ8ee6JRirW7FzUlQbOqhKleyiIiXiFXbCXSlUdToA2xXhee?=
 =?us-ascii?Q?Yw+/BsJJdJ3DaNDnNrE+LdGY81ftuG26Ke5C2rqdYOvm9+O2noNv03hZAltO?=
 =?us-ascii?Q?pV4PTlUAQVkqRaLPskhAYYfZsCVJO+D+oCAjKlGbRwDRSwRgLb6V1wWObGU8?=
 =?us-ascii?Q?LVnZW9vLvtJkKsDFSMrmINrFOCFS0khpXoN34513MYs17rtyALSjKIzLPYTl?=
 =?us-ascii?Q?0V/sIAdkYDKpBZYqSSlROT7k5fEWsA8tj2+eyxLAvKbXL+J+b9qSO4JgOsZc?=
 =?us-ascii?Q?bNDywN/Dmo9SNu8aNqXK118yz5obrDMlmVnQ3WkmPYyHqq01GXn34lxVvum4?=
 =?us-ascii?Q?XiIxcUIXwo1tNKQl5F+Cncaavt6fBrlRCMbeNUZZUsOWB94931zBQxwJgXqM?=
 =?us-ascii?Q?+OuJhUgKnK5NvwpZhDBMVPpI+6FATWsIXIgPj2n1BWhRDKxJAfg9VZThePG2?=
 =?us-ascii?Q?D+On78G+EDoevJVccdcYA4JGl6mfXmf4+1MGv2yPz9jRgAyzq40Vk9nMjN8F?=
 =?us-ascii?Q?d0z+Y58rgJxYxOmHGmiv9m6skhY/hbfTOWZ5A0xptko+fT//BRxUrbu36Hr5?=
 =?us-ascii?Q?MLGToglxic8PgfNxJr0UqseAObHpamR3K7sKexzJkdKn+F/RY6oXFRcBkWX7?=
 =?us-ascii?Q?BE0BwBayzRfb/6pgkhjraYjKGaiVal3c7zGvCAVoTfchP2da2BVQhi0Fhr/b?=
 =?us-ascii?Q?ivm1hOwYgI+63dgjb2bQQXlLleHTdKw7uVL3XP8guYxpIoOhhIfIjnEFdyQo?=
 =?us-ascii?Q?v+1iiWWNReP51lOjwztlEQHKk8COmPbOLYF1juXcy0NJqZewHePGQnVo1yOa?=
 =?us-ascii?Q?tL7VrpJtYGDN9HX2RE/lYa4J/W6dqRKBpGNKqhvaf6xTwqCUjMRrztjpyhl9?=
 =?us-ascii?Q?K8t02z99ohVJnxGfql+brj3X8LUnBNogdj4MhfE7i1S5cMNcw6LLMICWnhkV?=
 =?us-ascii?Q?AhjjF3AhKpUZaWxE8HGlYLqO/SPHUUEpMJ30OIBVpUy3iNbnM0IZj/UJWacr?=
 =?us-ascii?Q?gBji+IN6Fod9y5n8k4ufHHHkG6sjsriGgxxhmEWJi0cDmiE7964qyh2b+QNL?=
 =?us-ascii?Q?SzKdIVzGBnBeBgIVGPW92uD7z+NSRawx6Unh6ZjA3x/Z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9733149a-09af-4e1d-0fe8-08dbf4b38562
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 10:26:47.8797 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: inYsFPM3ytvWgiNReYJURAmtu/ZQx4oD8auSRRGPbrl2n7ECRwHu7KOdHQgAkC0bh8YCLnHEvUxFWg2aDggTVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4093
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

--Hh63upjq2xRxcFOf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 04, 2023 at 10:20:46AM +0200, Svyatoslav Ryhel wrote:
> Create a DM supported wrapper arround existing Tegra pinmux logic.
> This implementation is backwards compatible with all existing board
> setups and early stages of setup. All new boards must be device tree
> based. Linux dts pinmux nodes are fully compatible with this driver.
>=20
> As an example I have converted recently merged T30 boards to this
> layout (I have those devices and was able to test them properly) and
> Paz00 T20 board which was tested as well by owner.
>=20
> Svyatoslav Ryhel (8):
>   ARM: mach-tegra: rearrange SPL configs
>   drivers: pinctrl: create Tegra DM pinctrl driver
>   drivers: pinctrl: tegra: incorporate existing code
>   board: asus: grouper: switch to DM pinmux
>   board: lg: x3-t30: switch to DM pinmux
>   board: asus: transformer: switch to DM pinmux
>   board: htc: endeavoru: switch to DM pinmux
>   board: compal: paz00: clean up the board
>=20
>  arch/arm/dts/tegra20-paz00.dts                |    4 +-
>  arch/arm/dts/tegra30-asus-grouper-common.dtsi |  712 ++++++++++
>  .../dts/tegra30-asus-nexus7-grouper-E1565.dts |  113 ++
>  .../dts/tegra30-asus-nexus7-grouper-PM269.dts |  113 ++
>  .../dts/tegra30-asus-nexus7-tilapia-E1565.dts |  149 +++
>  arch/arm/dts/tegra30-asus-p1801-t.dts         |  982 ++++++++++++++
>  arch/arm/dts/tegra30-asus-tf201.dts           |   45 +
>  arch/arm/dts/tegra30-asus-tf300t.dts          |   45 +
>  arch/arm/dts/tegra30-asus-tf300tg.dts         |  128 ++
>  arch/arm/dts/tegra30-asus-tf300tl.dts         |  163 +++
>  arch/arm/dts/tegra30-asus-tf600t.dts          |  889 +++++++++++++
>  arch/arm/dts/tegra30-asus-tf700t.dts          |   53 +
>  arch/arm/dts/tegra30-asus-transformer.dtsi    |  984 ++++++++++++++
>  arch/arm/dts/tegra30-htc-endeavoru.dts        | 1147 +++++++++++++++++
>  arch/arm/dts/tegra30-lg-p880.dts              |   90 ++
>  arch/arm/dts/tegra30-lg-p895.dts              |   93 ++
>  arch/arm/dts/tegra30-lg-x3.dtsi               |  845 ++++++++++++
>  arch/arm/include/asm/arch-tegra114/pinmux.h   |  303 +++++
>  arch/arm/include/asm/arch-tegra124/pinmux.h   |  327 +++++
>  arch/arm/include/asm/arch-tegra20/pinmux.h    |  291 +++++
>  arch/arm/include/asm/arch-tegra210/pinmux.h   |  394 ++++++
>  arch/arm/include/asm/arch-tegra30/pinmux.h    |  381 ++++++
>  arch/arm/mach-tegra/Kconfig                   |   16 +-
>  arch/arm/mach-tegra/Makefile                  |    1 -
>  arch/arm/mach-tegra/board.c                   |    6 +-
>  arch/arm/mach-tegra/board2.c                  |    2 +-
>  arch/arm/mach-tegra/tegra114/Makefile         |    2 +-
>  arch/arm/mach-tegra/tegra124/Makefile         |    2 -
>  arch/arm/mach-tegra/tegra20/Makefile          |    2 +-
>  arch/arm/mach-tegra/tegra210/Makefile         |    1 -
>  arch/arm/mach-tegra/tegra30/Makefile          |    2 +-
>  board/asus/grouper/grouper.c                  |   18 -
>  board/asus/grouper/pinmux-config-grouper.h    |  362 ------
>  .../pinmux-config-transformer.h               |  365 ------
>  board/asus/transformer-t30/transformer-t30.c  |   23 -
>  board/compal/paz00/Makefile                   |    8 -
>  board/compal/paz00/paz00.c                    |   53 -
>  board/htc/endeavoru/endeavoru.c               |   14 -
>  board/htc/endeavoru/pinmux-config-endeavoru.h |  362 ------
>  board/lg/x3-t30/Kconfig                       |   12 -
>  board/lg/x3-t30/configs/p880.config           |    1 -
>  board/lg/x3-t30/configs/p895.config           |    1 -
>  board/lg/x3-t30/pinmux-config-x3.h            |  449 -------
>  board/lg/x3-t30/x3-t30.c                      |   23 -
>  configs/paz00_defconfig                       |    3 +
>  drivers/pinctrl/Kconfig                       |    1 +
>  drivers/pinctrl/Makefile                      |    1 +
>  drivers/pinctrl/tegra/Kconfig                 |   18 +
>  drivers/pinctrl/tegra/Makefile                |   16 +
>  .../pinctrl/tegra/funcmux-tegra114.c          |    0
>  .../pinctrl/tegra/funcmux-tegra124.c          |    0
>  .../pinctrl/tegra/funcmux-tegra20.c           |    0
>  .../pinctrl/tegra/funcmux-tegra210.c          |    0
>  .../pinctrl/tegra/funcmux-tegra30.c           |    0
>  drivers/pinctrl/tegra/pinctrl-tegra.c         |  248 ++++
>  drivers/pinctrl/tegra/pinctrl-tegra20.c       |  177 +++
>  .../pinctrl/tegra}/pinmux-common.c            |    0
>  .../pinctrl/tegra/pinmux-tegra114.c           |    0
>  .../pinctrl/tegra/pinmux-tegra124.c           |    0
>  .../pinctrl/tegra/pinmux-tegra20.c            |    0
>  drivers/pinctrl/tegra/pinmux-tegra210.c       |  190 +++
>  .../pinctrl/tegra/pinmux-tegra30.c            |    0
>  include/configs/x3-t30.h                      |   13 +-
>  63 files changed, 8920 insertions(+), 1723 deletions(-)

So we're adding 7000 extra lines here just to get the same level of
functionality? Do we really want this?

For things like the kernel this makes a bit more sense because we can
have generic kernel images for a wide variety of boards, and
additionally we can have dynamic reconfiguration of the pinmux at
runtime. We have neither of those in U-Boot, so do we really need to
move all this into DT and add this extra overhead?

Thierry

--Hh63upjq2xRxcFOf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmVtqWIACgkQ3SOs138+
s6EJxA/+N7aISdyOCQ52a4ZVzgXISKjd34TonO8kaiWcN16zs0OV9bgi9EvC6fUL
jZOH0qO9cIoF71m6rgzM8yZi5zcZtav9FwBC49WBmKXNE3cVYvEQjsaMg1HfaECl
ngzsyAHgatp6+0TcbO8klKVPjwDcH2r2HeOoboXCyZxOhM23/hnsw6qyb47seIm6
PW95MbOTGNUNEVJYQ0wpotE3jg2xvHB/aobeASFu14iTBXzznrUFDvuhWCcKkuIO
Yk3YaWlwt9+ciPBHrVGv3CeYlgIX68aYQwrUQ3cvvRZp7OYkB4+uN/zFTVS5cy9v
piN/0g0xNV+y7X3D1UjojRP2IPv378HVJToI9t5i8lfEYoyvt2jUeT3X2YgMXbbT
7LF4VnyR6b+1olbrfMnl7VHS91BKHMMHHahYndQTeulqKwpbU+QdaCwWw/DF05Pw
btCSafhcmhxOjGUGk6JiN0U28sW/PnsuTngQT4QdtDkFa1lvUWi9VqKhZU1hlkpp
fTJsW3GYd9nm9wC1t1C67Co7caoaLY9Wz4rGckC0A1z5FArPs32OY2gUdcV17ZCn
8uaA0W7lOZtHGtr3zrMaG6mjOohdj27QkmNq26fDXqAGCHORlH08HdGN2NiRq5FZ
bKKO7ZAqhi14U8RS+d/Nh1dCH/f7rhC6nuSXdxMbx7AcL7kW6V0=
=SQbK
-----END PGP SIGNATURE-----

--Hh63upjq2xRxcFOf--
