Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60195C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 11:47:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA9DB8715C;
	Wed, 13 Dec 2023 12:47:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="IrWyG6ys";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57F898726C; Wed, 13 Dec 2023 12:47:46 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::617])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82CBF87103
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:47:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=treding@nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAcgGjW6jnV44dpZbNpLTwpmsW61bwQ2lmwLpb0Zbd5OWcf1jyaY8xxSgOQiWxpwxBUgwpJLAnoL7vXBJ9rbMPOEBtQos2QtHXJULbL7qO4GVUFbMZzcLCIu6YT/zfhHVcXYTYNKt90krH9YsvfHfUWFybhvBF47dovMDFA8PX/CdliPiuqD9YLxWZVFNAAX1nKE7EaEjlo68w/g6xJ7XLEacVjvXI7/jtjUsViXg40D/U90Bs/bgEfDuIgT8CRTQEotgv8Mh1TiGEwOFgWWvn1vaLXmIhdpe/nyW30i4eWb1AZbvNd6Rz77LW9PQRLtyaxmLFKGO4JA9VtGknaaxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJfOoLmc2lPFa4wkjZHZZ8In2dmBGKoepCJRUtGjLyo=;
 b=T6FOEcLdxXjobQseZQmMDn3vu49hQ8az3bJVrCf2aK+wGgqVeEF6btBYx91GHmAUSzz5cN8wFLTXkD9yfmNmC2fQbgDenOCZszaEmqcv+mG5jTZ/TTnG+VB5bxqJ70RtIZzZZljMuljXWKvv1Qp/0ia5x1G/fAb7WXzRaDFjDybGHzZZxcf667xfQPyMXL+HFD+W3bPy2+73Bhm2j00Wx7WGKNAjmCgabujpqVgWSM4nuaDjGvJbYDR+5HWVUaPHaFmwbMrqO0jGl+WSFxsYHVg+H1oMzz8H1S3S8N4azVlmFmbMp6oNRtSPZb2SiKcKTmS1dsZ6ssStFhDtL737jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJfOoLmc2lPFa4wkjZHZZ8In2dmBGKoepCJRUtGjLyo=;
 b=IrWyG6ysYO+29D7rH7PqBoqbYTtG38vSQx1A5Nq8EcgJnnLUibJi8RbSmpM2GKI9pxiVPSfw5neYDSe3l8+3AYcQ7WpW7eq7gPnZW/2BKXvs25IVA8knXcma0e9WIvc/q39+57WPfIO+6O3sO/YknzBNBTquq+TMPFbFur/KvITMOWjTMTXaJbJXBFuewlRVc3iGiesUH62gjfIh0cpiscPN48J5T7PUdwHj6v5viHP4+DOge0qjYT5vDYzkvUrmJIrEgsi8R+3tX1QVGX7OMJYZu10YbUKdGMgqrxrrf4f7SGYAGmUpOd2j9pWK4n+b+AAs+1XjTTWzleoiVz0cbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) by
 SJ0PR12MB5633.namprd12.prod.outlook.com (2603:10b6:a03:428::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.26; Wed, 13 Dec 2023 11:47:39 +0000
Received: from DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::929c:d330:53e2:c5d]) by DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::929c:d330:53e2:c5d%7]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 11:47:39 +0000
Date: Wed, 13 Dec 2023 12:47:34 +0100
From: Thierry Reding <treding@nvidia.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Ramin Khonsari <raminterex@yahoo.com>,
 Jianlong Huang <jianlong.huang@starfivetech.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Emil Renner Berthing <kernel@esmil.dk>,
 Kuan Lim Lee <kuanlim.lee@linux.starfivetech.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/8] Convert Tegra pinctrl to DM
Message-ID: <ZXmZ1p-xhLqyGG1j@orome.fritz.box>
References: <20231204082054.4943-1-clamor95@gmail.com>
 <ZW2pYqo6hjGqKo_-@orome.fritz.box>
 <CAPVz0n1XDNvD8G06i_qEdr3SNXwWtFfkyURp6uZbr86rbH2jQA@mail.gmail.com>
 <20231209141406.GF2513409@bill-the-cat>
 <0BD82463-7C19-4425-BEAE-D90811541FC8@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="z1ZSXMn08u2VDWTg"
Content-Disposition: inline
In-Reply-To: <0BD82463-7C19-4425-BEAE-D90811541FC8@gmail.com>
X-NVConfidentiality: public
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: LO4P123CA0226.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::15) To DM8PR12MB5413.namprd12.prod.outlook.com
 (2603:10b6:8:3b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5413:EE_|SJ0PR12MB5633:EE_
X-MS-Office365-Filtering-Correlation-Id: fc5349c3-336f-4380-ebf2-08dbfbd14ecd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9x5g4D0OLTRny/WueJBK8jM7u33xduGXhmD88srpoG5zbFiGLxPb8nY7K+IcTR+Wv0xeEKtYjxxdH19lLlxCS0mUdPFv5+0A9JNW3t2Ln4gwSUiSyOwLsv8N+bTPOGyyoycQjs9MaXqdCpvI0ONDJriju5AtVtZit0g2nLbxSI8rEJftsi50JjTnKphBJ9AbgN14trx2C4lCeLGX90aLstPz0dfIRGN6zQS0AA5uz0pPQ5hEnlAHRbneiITja6DNIvW+lYF/N+l+E3YwVkd9whu17EZAGs7TEx0OMlIf3gBcIwcXmbFSAG4NfhLYpnR3RMsKUjc9DesrnavVpAXcJWwHBGm2SHH+b3OfqrQKMDpvzQjU1h1WVdmohbQzm8/sOD/gzpYLtsq0IPpMiyD7YWOLGsmKgBYZ9VqyklmAqYU/OKQwKs8L+Z5HhJhvHUnN6e0gVfvY95B97834O38So21pG9uaOqTx3Zcj/eoL7CfWIJqMuXlpMak4zv4kSU6/02Hkyf1W0Bep6K5dB96IHoHccnkP1ESdogGko/yAiDgyCtGdlbANARNQOK3oU7wxM12IJvkPou8qF0QUxAMSzThZMEZ//ZeTtK01QulUT1o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(366004)(346002)(376002)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(66946007)(66556008)(54906003)(66476007)(6916009)(86362001)(38100700002)(83380400001)(21480400003)(9686003)(6512007)(33964004)(44144004)(6506007)(4326008)(6486002)(966005)(2906002)(316002)(6666004)(478600001)(5660300002)(7416002)(8936002)(41300700001)(8676002)(2700100001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVZGcUVwZ0FlVkM0cE1rUUdGL3gyK3Yvdm9KTWxCMWRnRGZKUzZqQmczUzZy?=
 =?utf-8?B?c2JFNHo4TVlFN2dwZE8yeDZscFRDelMxeUhyWnBuaEc4NHE5R3o3V0JYYmc2?=
 =?utf-8?B?WkdmNGJ1UnFLL3l6OVYxZTJzckQxY2lsMjVzV09NUVkrT2pTZ3YwVGkrYXBo?=
 =?utf-8?B?c3RxRVQ4SENJaTFNYlhFNzhYbmxXdk9SWXFKZjE0QVhCMFVPUnhoRkNlUER3?=
 =?utf-8?B?MVc5WXFjbkdtR2VWNzlvUVdGY3J0dkM5bGxaeEhyZEZiUGp0aUVHOW1kQTUy?=
 =?utf-8?B?WHhuRTFBQWJWdUlPczgwYTJrRnBzWThXVzJURnBuNkphK3Y5VXpuOVYwY2RD?=
 =?utf-8?B?QXZxWkVObmRPeDRTaHdBcUp6ZUU2MnJnU2xsbktTM1lTaFlUNUZXdmM1Q1lX?=
 =?utf-8?B?amVMcmRlanlVdmRnWk00Sk9oN1JGb1NkYWpteWw0cXZtNUxlcmZqV3ZlSHdp?=
 =?utf-8?B?bklNN1JjSXQwdjZ6RkV1cko4N2EzUnB1Tll5UmJDbG1IaUxocXNYRmp2Rk14?=
 =?utf-8?B?NXg4aUprTlI1WTZETzlGSm9ubkdZKzQxM2p4TlFoUnk4b2gwYUJjek9DY1hD?=
 =?utf-8?B?ZHo5eFVCdHhZT0psc0ZaOUZEOE5vMnlZdXp2b0YvbmNhWWVTek1pbmI4QUJO?=
 =?utf-8?B?NmpSNmVQT04yaXpidDFtSTZmYkNvbE5rck5WMVBvbmQwZzdQc2ZhUnAzQi8z?=
 =?utf-8?B?OERwUUZJTXI2UllWa2hTOVdieEhkT3IvMmdIK3pNRy8rckY4c3YrSVI1K2F2?=
 =?utf-8?B?d3lDdysvYXA4VFg2aGRxNmJscm1Yc21ieVhwaHQwS0IvZTZMM3d3OVBrMlcw?=
 =?utf-8?B?eUh6Z3pCWlJxWTVjeXBFeUdsdjV2Uk9qVEdhWWxPY2taU2ExREtDMkR3N2k4?=
 =?utf-8?B?ckNsMGtOY2RmMStYSGFBT2RtWXROdmc4ZUozT0NuS3FPNHllVVZvRHhEcUsx?=
 =?utf-8?B?V3FjWE9yM1hOcTd0c1FFSCtWTTUwUDMwblh1QzJha2pvbmJqUXJiNm5PYjNr?=
 =?utf-8?B?aDByYWFMMFdPVEFPSEkyb3ozV1Q1anBYQVp1eU5WYjJXbVU0VVI4RGhxWHdx?=
 =?utf-8?B?NEZFTzRJQlVxeWhkT3BlaVlPL0Uvd2oxUFVWTSt1VFdiSm5Xd1lIbUFSeFNY?=
 =?utf-8?B?dzdsY1F2c1h3V0o0RkRzVDZ3UWR1R00yR2FBc2FFQzY3dDZPVkw4eXZremw5?=
 =?utf-8?B?U3ZlVld5WHBZNHU0ekFiTml1YW5DRHd1WVF6bzIvcVN1VmJXVXNkdGRyWDFP?=
 =?utf-8?B?MW9oY1BKVk16R2NKSDJlOXV4dGdwRlNzd0tjb080WllFZ1M5VkVrWFlpMXlV?=
 =?utf-8?B?YkdaSzc1alMzL2FyWTJwazNld2JSVzdVV1B0R2ZpZWltc1lndFpnMWZ6RFc1?=
 =?utf-8?B?R2JCNTJSM2h4cmRBckVRc1BzcGJNUlFkU21OTnBWdWJBbkluelF3V3g1UEMw?=
 =?utf-8?B?NlNTWXFEME94cEpPTFRmai82OGFxNngzcldCOGZzeWtnOUVuTURFY25KNjJo?=
 =?utf-8?B?UkYySGNPU0JhdEpGY0dRVjhxUkVxbzU0TTdwdWhVZ1o1Q0hTNS9pSmloWk1i?=
 =?utf-8?B?MmtUVnl3WTRpeGxaOVBkSFVRQlBYaDlaR0JMaUg0c2o0eXJ1K0JQRllwVUJZ?=
 =?utf-8?B?MlJDaEJNa01kR25YdmxGd1VFdENKeUF4WXpQTUtPNm8zMWRIT0EzL2JpdVdN?=
 =?utf-8?B?ZmR1aEVCc0NUdVhXWVZXdHgzdEtvS0Frdm1ob2NLdklPZ1gyNnNOYVFoQnZ3?=
 =?utf-8?B?UzdycWRGSWdzeHNoOVVaQVdiRVlhWmZuNHA4ZngwN3ltWU9qRG5laDlvSnBs?=
 =?utf-8?B?NGNhOE9hbE9CZkhFNEhmSlhHaUxQbVJzZEgrZ1JiclBJWldjSEwzKytNa1VE?=
 =?utf-8?B?ajFTZUQwL1pUc1Bvb0V0OCtUaWFPSUowbmozekV1RDdaWS9qOEU0cUdXSEc5?=
 =?utf-8?B?WWhxZmdPSlZkMGpHakhWMzFDUllvRkxld3RpdmFoMGgyeGhSbDJPcVpGZXZo?=
 =?utf-8?B?anpoR3d2MnN6bmpaZkRKTE51dGpiRWZpcERKTXZPWHBENzFxeUxYSmw4YUNC?=
 =?utf-8?B?S1RtUlRtc1NwY3Y0cWNmajc3M2JVQnVMN2JMVUlCem5CTE5tZWs0VHltTGxQ?=
 =?utf-8?B?QVBicDBuNWNZMTJPVUUzdXJlb0RNS2pycldwNlltZ2puM1d2bHczQ3VoYjNu?=
 =?utf-8?Q?yqNavh92rzRyQLaF+Y+HXAx8GRp2ZxhPk5zVB9GEoEeZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc5349c3-336f-4380-ebf2-08dbfbd14ecd
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 11:47:39.3018 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YnFWYhN0Fl5GN4Dh0rSbPU6p5v3zuPmmgDDdDejMuZQ3ZRSgAcdjh5oRDS2ApwIRdVSiEg760eTfCH9rCvJy5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5633
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

--z1ZSXMn08u2VDWTg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 11:46:58AM +0200, Svyatoslav Ryhel wrote:
>=20
>=20
> 9 =D0=B3=D1=80=D1=83=D0=B4=D0=BD=D1=8F 2023 =D1=80. 16:14:06 GMT+02:00, T=
om Rini <trini@konsulko.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=B2(-=
=D0=BB=D0=B0):
> >On Mon, Dec 04, 2023 at 04:45:38PM +0200, Svyatoslav Ryhel wrote:
> >> =D0=BF=D0=BD, 4 =D0=B3=D1=80=D1=83=D0=B4. 2023=E2=80=AF=D1=80. =D0=BE =
12:26 Thierry Reding <treding@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >> >
> >> > On Mon, Dec 04, 2023 at 10:20:46AM +0200, Svyatoslav Ryhel wrote:
> >> > > Create a DM supported wrapper arround existing Tegra pinmux logic.
> >> > > This implementation is backwards compatible with all existing board
> >> > > setups and early stages of setup. All new boards must be device tr=
ee
> >> > > based. Linux dts pinmux nodes are fully compatible with this drive=
r.
> >> > >
> >> > > As an example I have converted recently merged T30 boards to this
> >> > > layout (I have those devices and was able to test them properly) a=
nd
> >> > > Paz00 T20 board which was tested as well by owner.
> >> > >
> >> > > Svyatoslav Ryhel (8):
> >> > >   ARM: mach-tegra: rearrange SPL configs
> >> > >   drivers: pinctrl: create Tegra DM pinctrl driver
> >> > >   drivers: pinctrl: tegra: incorporate existing code
> >> > >   board: asus: grouper: switch to DM pinmux
> >> > >   board: lg: x3-t30: switch to DM pinmux
> >> > >   board: asus: transformer: switch to DM pinmux
> >> > >   board: htc: endeavoru: switch to DM pinmux
> >> > >   board: compal: paz00: clean up the board
> >> > >
> >> > >  arch/arm/dts/tegra20-paz00.dts                |    4 +-
> >> > >  arch/arm/dts/tegra30-asus-grouper-common.dtsi |  712 ++++++++++
> >> > >  .../dts/tegra30-asus-nexus7-grouper-E1565.dts |  113 ++
> >> > >  .../dts/tegra30-asus-nexus7-grouper-PM269.dts |  113 ++
> >> > >  .../dts/tegra30-asus-nexus7-tilapia-E1565.dts |  149 +++
> >> > >  arch/arm/dts/tegra30-asus-p1801-t.dts         |  982 ++++++++++++=
++
> >> > >  arch/arm/dts/tegra30-asus-tf201.dts           |   45 +
> >> > >  arch/arm/dts/tegra30-asus-tf300t.dts          |   45 +
> >> > >  arch/arm/dts/tegra30-asus-tf300tg.dts         |  128 ++
> >> > >  arch/arm/dts/tegra30-asus-tf300tl.dts         |  163 +++
> >> > >  arch/arm/dts/tegra30-asus-tf600t.dts          |  889 +++++++++++++
> >> > >  arch/arm/dts/tegra30-asus-tf700t.dts          |   53 +
> >> > >  arch/arm/dts/tegra30-asus-transformer.dtsi    |  984 ++++++++++++=
++
> >> > >  arch/arm/dts/tegra30-htc-endeavoru.dts        | 1147 ++++++++++++=
+++++
> >> > >  arch/arm/dts/tegra30-lg-p880.dts              |   90 ++
> >> > >  arch/arm/dts/tegra30-lg-p895.dts              |   93 ++
> >> > >  arch/arm/dts/tegra30-lg-x3.dtsi               |  845 ++++++++++++
> >> > >  arch/arm/include/asm/arch-tegra114/pinmux.h   |  303 +++++
> >> > >  arch/arm/include/asm/arch-tegra124/pinmux.h   |  327 +++++
> >> > >  arch/arm/include/asm/arch-tegra20/pinmux.h    |  291 +++++
> >> > >  arch/arm/include/asm/arch-tegra210/pinmux.h   |  394 ++++++
> >> > >  arch/arm/include/asm/arch-tegra30/pinmux.h    |  381 ++++++
> >> > >  arch/arm/mach-tegra/Kconfig                   |   16 +-
> >> > >  arch/arm/mach-tegra/Makefile                  |    1 -
> >> > >  arch/arm/mach-tegra/board.c                   |    6 +-
> >> > >  arch/arm/mach-tegra/board2.c                  |    2 +-
> >> > >  arch/arm/mach-tegra/tegra114/Makefile         |    2 +-
> >> > >  arch/arm/mach-tegra/tegra124/Makefile         |    2 -
> >> > >  arch/arm/mach-tegra/tegra20/Makefile          |    2 +-
> >> > >  arch/arm/mach-tegra/tegra210/Makefile         |    1 -
> >> > >  arch/arm/mach-tegra/tegra30/Makefile          |    2 +-
> >> > >  board/asus/grouper/grouper.c                  |   18 -
> >> > >  board/asus/grouper/pinmux-config-grouper.h    |  362 ------
> >> > >  .../pinmux-config-transformer.h               |  365 ------
> >> > >  board/asus/transformer-t30/transformer-t30.c  |   23 -
> >> > >  board/compal/paz00/Makefile                   |    8 -
> >> > >  board/compal/paz00/paz00.c                    |   53 -
> >> > >  board/htc/endeavoru/endeavoru.c               |   14 -
> >> > >  board/htc/endeavoru/pinmux-config-endeavoru.h |  362 ------
> >> > >  board/lg/x3-t30/Kconfig                       |   12 -
> >> > >  board/lg/x3-t30/configs/p880.config           |    1 -
> >> > >  board/lg/x3-t30/configs/p895.config           |    1 -
> >> > >  board/lg/x3-t30/pinmux-config-x3.h            |  449 -------
> >> > >  board/lg/x3-t30/x3-t30.c                      |   23 -
> >> > >  configs/paz00_defconfig                       |    3 +
> >> > >  drivers/pinctrl/Kconfig                       |    1 +
> >> > >  drivers/pinctrl/Makefile                      |    1 +
> >> > >  drivers/pinctrl/tegra/Kconfig                 |   18 +
> >> > >  drivers/pinctrl/tegra/Makefile                |   16 +
> >> > >  .../pinctrl/tegra/funcmux-tegra114.c          |    0
> >> > >  .../pinctrl/tegra/funcmux-tegra124.c          |    0
> >> > >  .../pinctrl/tegra/funcmux-tegra20.c           |    0
> >> > >  .../pinctrl/tegra/funcmux-tegra210.c          |    0
> >> > >  .../pinctrl/tegra/funcmux-tegra30.c           |    0
> >> > >  drivers/pinctrl/tegra/pinctrl-tegra.c         |  248 ++++
> >> > >  drivers/pinctrl/tegra/pinctrl-tegra20.c       |  177 +++
> >> > >  .../pinctrl/tegra}/pinmux-common.c            |    0
> >> > >  .../pinctrl/tegra/pinmux-tegra114.c           |    0
> >> > >  .../pinctrl/tegra/pinmux-tegra124.c           |    0
> >> > >  .../pinctrl/tegra/pinmux-tegra20.c            |    0
> >> > >  drivers/pinctrl/tegra/pinmux-tegra210.c       |  190 +++
> >> > >  .../pinctrl/tegra/pinmux-tegra30.c            |    0
> >> > >  include/configs/x3-t30.h                      |   13 +-
> >> > >  63 files changed, 8920 insertions(+), 1723 deletions(-)
> >> >
> >> > So we're adding 7000 extra lines here just to get the same level of
> >> > functionality? Do we really want this?
> >>=20
> >> Tom, as a project maintainer, may you answer? Does U-Boot really want
> >> this? And ensure there will never ever be a forced pinmux DM
> >> migration.
> >>=20
> >> >
> >> > For things like the kernel this makes a bit more sense because we can
> >> > have generic kernel images for a wide variety of boards, and
> >> > additionally we can have dynamic reconfiguration of the pinmux at
> >> > runtime. We have neither of those in U-Boot, so do we really need to
> >> > move all this into DT and add this extra overhead?
> >>=20
> >> There would not be so much overhead if Linux kernel used numbers for
> >> pin definitions, not strings.
> >
> >Well, yes, this is the right direction. One of the goals is to be able
> >to use the linux device trees as-is and be able to pass that along to
> >the OS to use. And so we move a little away from the absolute thinnest
> >case that we used to be and a bit more towards a generic case just like
> >Linux did. In some cases, one can just change the device tree passed to
> >U-Boot and re-use the same binary. And if Tegra platforms moved in that
> >direction that's nice too.
> >
>=20
> These patches do not discard the existing header system of pinmux
> setup, it is still supported and is not touched whatsoever. These
> patches add DM overlay so that boards which can afford inflated device
> tree and care about size less could move to linux style device tree
> pinmux definition. Well I know how hard it is to rewrite pinmux over
> and over for different projects.

There's actually a set of scripts here[0] that were meant to make this
easier, but for whatever reason people don't want to use them. This was
archived a few years back because there hadn't been any contributions in
a very long time and it didn't look like they would ever need to be
updated. But we could revive that project if it's deemed useful.

Thierry

[0]: https://github.com/NVIDIA/tegra-pinmux-scripts

--z1ZSXMn08u2VDWTg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmV5mdYACgkQ3SOs138+
s6F0UhAAqLsSb1ECri6dZtmi3AT9nvLiFAAEvOrMtA8PnK0P+X0ZnZY9Q5v+r9xW
WBFRy2ht22CpTYSyQa2XwKo9JbvMHTCAVqt2m/+Y28uz6oiMnLOF1drlRyMffYnT
s0c4QNkAU55Fu0Ru3qw4Es7sBC+ZONPF6cBl43Id91GWjeHrMKiNaDp8iJn6LQeo
xGIQC/1SN6Nu598HL5aA2FgdTaNuP2cFnvPcU53qcmwf7H7erlOAuwStL4L/h2YK
WVn+irsHYcP87nmFEXNXaowME7XI/tGepTemhUHKLKSqn4OqD/fv/V2nk6dW2AQO
dEqkoX+z9dpAD3MDQHIUCTp3S1puNFafTlVcI+M4HrDuU2QbbWWcf5Niw6ateK/t
bc+xY6jV2duSCLAtopAT7+iqCKEzExi1uTg32JynFYfyeqnFtcuWxu3mhdZ4TBU7
KwNTdOtUU+yLV7mT3GXYHORax92Dt3fAryDcqDlvQ4YnwdMYE4cOCsEcCMgHaZDD
DhknxaO2SnQQPOa9NDPGzMNmpKigmjxB4SzS29jWcn3wXevJgCHHPCT4qVUo9Izg
n6OtqxD/eCd2a7J9nTSy+bLbbPmSin4awb5z/iNoktj/Ho5nHzs+82Vk2SIQuyMG
0TgJvhH74FfGobJWiDf3/HrY8zlYDoFCjzWLLbEy/9zF3EtmWUY=
=CTqU
-----END PGP SIGNATURE-----

--z1ZSXMn08u2VDWTg--
