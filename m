Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 182BDC54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 06:58:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA7A8880E5;
	Wed, 20 Mar 2024 07:58:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5oG3unws";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DEF2880D5; Wed, 20 Mar 2024 07:58:38 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7E6987E83
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 07:58:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Do5eiwBtu/5qSIGoSscHwJgrcBEeuTe+wHoSsOIBuOXjVgKyMMHzT23ksNkwj02WpaKkhNwVkHaYwyVdckdcDFN/EGfCxfmZwwHynGRaLcUOTvddCjCdcby/BZEikgVodE1hjCTx1cxLllVpGnEb0W1J7+bmGl1iv/vFmD5IIpMmvLWrLSaDI4ke5Wu+/qXP4Euu7cG+E/ruPWygdytmYLbFWPLKJwCGnvPPyz7wBT+AsfQf61RogIz2XFwKj8+5F385rQvtqrDx+lcSn1LSk+De+BqPMy5/cscoQligf1Nx4Kydjz8jcd3Uw0U+BbkwX79X8syRH8aOzgImUJrinw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqgXKV1FCbsUjTb154QLA++/Gg1kPi6omYub8WtsTkA=;
 b=P+jF9/jrsPVzqqENdSJGuhXVsFwtHC9HSW1vd4aJi15X0cFBbFbbNaovVW3mNRWUEWVrfIcktna/Okg+qbzexqd0DUX+P7iITmScuZL35QpuxjRy0PVVfaGhJ7oJe/dCio9v7pRVFAiRQ6TJeSIKenpEnRLZ9WEBzIfbKrXhgmXZuRh5XvGr4SS27+E172HhHpuvqLvUJDv2fEHr9B/nXqHaZhbw9YGA5ekC/cz2bE0XIwRrLf6YByOwgzJvF/7iqK+jN0ZAErIGuPBGq91GOkGC4sGf9/AIzns67HMLQLI42GJ9IIoluKpHZ2Ro3t778GMMXw6vgFfrGW0pUkRvqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqgXKV1FCbsUjTb154QLA++/Gg1kPi6omYub8WtsTkA=;
 b=5oG3unwsmTOjRX5VUDm/3rh0YK3f8eA15FnVX+lQ+gnwFszTghY0jEyr4cK/LwPKWyRykc0nnlS77Ug8PAnCOtpE1E2AWNT1HcAksY8lWzxuIpYx+k1C4eGIiPIQUWBwt2qNVf5E1RFThM1cLB/u5cjh+WXpGDrDW2+Db5JEI5A=
Received: from BL3PR12MB6450.namprd12.prod.outlook.com (2603:10b6:208:3b9::22)
 by CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Wed, 20 Mar
 2024 06:58:31 +0000
Received: from BL3PR12MB6450.namprd12.prod.outlook.com
 ([fe80::e214:81fd:a03f:84fc]) by BL3PR12MB6450.namprd12.prod.outlook.com
 ([fe80::e214:81fd:a03f:84fc%6]) with mapi id 15.20.7386.030; Wed, 20 Mar 2024
 06:58:31 +0000
From: "Bhumkar, Tejas Arvind" <tejas.arvind.bhumkar@amd.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>, "n-francis@ti.com"
 <n-francis@ti.com>, "Simek, Michal" <michal.simek@amd.com>, "Abbarapu,
 Venkatesh" <venkatesh.abbarapu@amd.com>, "git (AMD-Xilinx)" <git@amd.com>, T
 Karthik Reddy <t.karthik.reddy@xilinx.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>
Subject: RE: [PATCH 01/19] spi: cadence_qspi: Add support for DDR PHY mode
Thread-Topic: [PATCH 01/19] spi: cadence_qspi: Add support for DDR PHY mode
Thread-Index: AQHac9jTwBEwjSaVbEimT1PT5W452bE1YUmAgAraZmA=
Date: Wed, 20 Mar 2024 06:58:31 +0000
Message-ID: <BL3PR12MB645044BAA603DB8A13F8CC05D8332@BL3PR12MB6450.namprd12.prod.outlook.com>
References: <cover.1710098033.git.tejas.arvind.bhumkar@amd.com>
 <fc520c7b6ed4d84e28e2eb807f2e57b1847d3c93.1710098033.git.tejas.arvind.bhumkar@amd.com>
 <7f71d88b-2f9d-4ddf-8253-7f020bcbf376@moroto.mountain>
In-Reply-To: <7f71d88b-2f9d-4ddf-8253-7f020bcbf376@moroto.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=29225efd-eae9-459d-819d-b38cadda2c5e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-20T06:41:51Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6450:EE_|CH2PR12MB4181:EE_
x-ms-office365-filtering-correlation-id: f4d7451d-7853-4eb4-c193-08dc48ab2743
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BoD1OQ76lT0jtfUa+wsZX7b2rkMtNXNtPU/QmWkCXhyPpCDM8A5IWmMJAt2qP1ph8fzeg9W13m8YKFoTb2KYSrl012x0YtF3c70/mJfx20E60WfcskQDTDSU86fddke6qJXc3fl+Dq5No9rVEYn0f/C4WM48roIAMT+GwIS2YhIBPIXN42DN6xtUGaZ0xg0LT2XXuJclyCA+4OlPCO/ZQCGld6IsC6dhiy6b7m4YlLwIHWALMOOgg9SOG2Ysp2PjiXMYDdbHivigrjF+awLr3offv6xD062Q2sXy/ykwSFQ2MNugrobEi/T9FKGhpIi44cycCik0kUudJFzflarnCo7z39lPqcEodbMiKd4WH4gfHHHpE47w9hC07Mj0GW+MOBRjbEhmmj2qHGHOknnMsXYpkZzqbsaSAfCUDAsYHOsu4ZLfgHvlSBP7+5J9b2j+kMf9nS5spZwM1trgb4Y6zPTOhhqnhj3KiUY+GDBQw9DnhWTqFEDeEoSf1vB3VeX1b15x6PWwl28WQeIL4mVpzHKe1HNBZ6438ZYLFgsU3cx2OuKJO/L/IXI6066LaSs4iAFL9w6FRLVV+0X3CexiRZXThZJsD+SPQCu/R1MlS+8cocLQqO9CwWXqyemZwQvIZz/G9LQd/mc8aYsS9sRUoqOirC/SUgj6V+GR6zkj5nnomT2QYB4m4mTNeOa9BhJzMVxMOEk8sDH2MrQYUZQ9IA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6450.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qvyanrpiI0+2dCF0HMnxV2RSXMU2dJspZqlAqXM21PwMW7ePtwFmGZow+kh2?=
 =?us-ascii?Q?5ZFfFRMVYI01A0dOb27onBHKNZos6UW2UI93/P3i+MSlVM5U3bKln61HvT2q?=
 =?us-ascii?Q?lzuK38riIWraou+91ndjY9HL2eO8LfLP/fMUCaqE8+3V+cNC1rOrEm9Ce12W?=
 =?us-ascii?Q?8vbKY6V8DV1dj253/SlDwFEvsJURddQZbyrmdH8GgmmzZIZa0zoTk2cY2qab?=
 =?us-ascii?Q?MNXncXVfuifjpzzimjkE8JCL3nbcTfwsotYxKXQY1Cy2FkLAnvetDCDRbgwj?=
 =?us-ascii?Q?zgKpc3DGWy0lDsF4+BgSlGJ55ur0Bbe18XW8PvGd216n3FsY8Qh6NzV7tq7X?=
 =?us-ascii?Q?ZDl2ZIvyTVlPCrgwMWAknEHnSqGKb1UrfnL6sm2SZslacmbDbWaBYKr6dCZx?=
 =?us-ascii?Q?GVeclogeZpt7z4uTmo7PoC8Y34BG+T3ByDCckSxsj+lOnXz6mSKPf2I1kpFA?=
 =?us-ascii?Q?So2o6DTFct1ZcJ+Hp8RYBcxo4Vx46pTVpfUtkuffGp5qtuL9JN1EWTmDcH2c?=
 =?us-ascii?Q?+0p3DArdKQvP/OPFMpOeUcvMzHcCbHpqRQ1KXyiSqkiG/S5mDwdTNLJQZXfJ?=
 =?us-ascii?Q?ytyt5r/RjNgkUDdY2srVku/GwJPXQJBeOnqoAfQshenmniHpF9SMrl0pe/zT?=
 =?us-ascii?Q?bZCJHWygwSMHL9wlhUSnuQ4U9ulRbNeFlO7wqrOcCTUyYdvwIAfuT215omW1?=
 =?us-ascii?Q?O7Lj1NBFvbcixLGv2QlpJsKasyU3/2P/qvBZfszeyCnX5eH2Kan1RGQCKt10?=
 =?us-ascii?Q?283D+f4rgmAiN76AbI9D8kWNUlWfN9dBSW1dcFCfcXQ3e+rmGZdC8Sh+ftnB?=
 =?us-ascii?Q?cFmLu3uvaa0+czkSG44ldLyMEHVoLEycMhxj1ysh+3LuiySVkX0L2gsdXNTi?=
 =?us-ascii?Q?QhlylWQSubsl24EnGtMr5AOfMzA7wSxdOpjPavSyqr1RTgLokaeMf6t4YHuk?=
 =?us-ascii?Q?8TmPzfVmRcrO2F0qJX+DBUrD9COXdVIotc3/vgOIkFIaqgZpFa9j6Ahngpry?=
 =?us-ascii?Q?6pU4vNfVqwImUY02vNB26KxP4NdsrEcsw4OCtIawHdgXLoGwxx4yVXJrZxim?=
 =?us-ascii?Q?Dr8Co4gwkKhJAiCDZfX2ZamZUNRbpdpGj9DLWSrHk9PpmS0txlCplL5A6ziN?=
 =?us-ascii?Q?nzDiTmcTYLcC2UfwhUDfVrJyB+oAonYUWHVBAPER7HGfs+y6pRlNhhpmMCVe?=
 =?us-ascii?Q?5HQ1WLklsbYFIC/dDSFTMJRY8ctgliXW0cx8KPIP8l5Bhf+LFvAExyw0L0CA?=
 =?us-ascii?Q?ROQdwan/iH/UUxWdmFOeRq92xcrY31K8IRrsdUP4qe5kK2scMRjiKxdIG8Jz?=
 =?us-ascii?Q?ixPcoifWbzAF+Nm7vHhzVoxfSq+wlvJBJWTZwfHxXyICPCIEOQ5vY5fbU1dD?=
 =?us-ascii?Q?xwxFt8rMPPWoh+scaa/WRNHMg0J/uKwlE6I0DA4biz/7OWh73cIeG+XvhjkV?=
 =?us-ascii?Q?PKY0B/5MF8CUzwOYXVwicGHOoRhdZxPkeQbmrug6wIpfi71XxwHnTm1hyZLD?=
 =?us-ascii?Q?r5ahWIZP1arSDAykBif6bmpDsR2V4igiLemmyfW4pnUfMD1U/7pMKJnuuBUp?=
 =?us-ascii?Q?07WhFf6p3qvF3oGaAXA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6450.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d7451d-7853-4eb4-c193-08dc48ab2743
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 06:58:31.4512 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zKWeJjUh9MU9NriqJNdyWTEXrJlDqupHNWMYXcJD9F763cAzOt7djBsBD5LQ142eJdL/b7Ukp9SfF42j6Ilf4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4181
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

[AMD Official Use Only - General]

Hi Dan,

> -----Original Message-----
> From: Dan Carpenter <dan.carpenter@linaro.org>
> Sent: Wednesday, March 13, 2024 2:28 PM
> To: Bhumkar, Tejas Arvind <tejas.arvind.bhumkar@amd.com>
> Cc: u-boot@lists.denx.de; jagan@amarulasolutions.com; n-francis@ti.com;
> Simek, Michal <michal.simek@amd.com>; Abbarapu, Venkatesh
> <venkatesh.abbarapu@amd.com>; git (AMD-Xilinx) <git@amd.com>; T
> Karthik Reddy <t.karthik.reddy@xilinx.com>; Ashok Reddy Soma
> <ashok.reddy.soma@amd.com>
> Subject: Re: [PATCH 01/19] spi: cadence_qspi: Add support for DDR PHY mod=
e
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> > diff --git a/drivers/mtd/spi/spi-nor-core.c
> > b/drivers/mtd/spi/spi-nor-core.c index faf02c7778..5895b5de09 100644
> > --- a/drivers/mtd/spi/spi-nor-core.c
> > +++ b/drivers/mtd/spi/spi-nor-core.c
> > @@ -1511,8 +1511,10 @@ static const struct flash_info
> *spi_nor_read_id(struct spi_nor *nor)
> >       info =3D spi_nor_ids;
> >       for (; info->name; info++) {
> >               if (info->id_len) {
> > -                     if (!memcmp(info->id, id, info->id_len))
> > +                     if ((!memcmp(info->id, id, info->id_len)) &&
> > +                         memcpy(nor->spi->device_id, id,
> > + SPI_NOR_MAX_ID_LEN)) {
>
> Please, don't put a memcpy() into a condition.  It looks like a memcmp() =
to the
> eye.
>
> >                               return info;
> > +                     }
>
>                 if (!memcmp(info->id, id, info->id_len)) {
>                         memcpy(nor->spi->device_id, id, SPI_NOR_MAX_ID_LE=
N);
>                         return info;
>                 }
>
> >               }
> >       }
> >
>
> [ snip ]
[Tejas ] : Thanks for the review, I will update this in v2
>
> >  static int cadence_spi_mem_exec_op(struct spi_slave *spi,
> >                                  const struct spi_mem_op *op)  { @@
> > -353,6 +649,9 @@ static int cadence_spi_mem_exec_op(struct spi_slave
> *spi,
> >               break;
> >       }
> >
> > +     if (op->cmd.dtr)
> > +             err =3D cadence_spi_setup_ddrmode(spi, op);
> > +
> >       return err;
>
>
> I think there should be another if (err) return err after the end of the =
switch
> statement.
[Tejas ] : I will update this too in v2.
>
> >  }
> >
>
> regards,
> dan carpenter
