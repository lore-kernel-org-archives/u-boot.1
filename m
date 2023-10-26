Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 360CFC25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 04:23:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BAE287566;
	Thu, 26 Oct 2023 06:23:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=omron.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=omron.com header.i=@omron.com header.b="mv902hS1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 489D08749D; Thu, 26 Oct 2023 04:22:39 +0200 (CEST)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (mail-os0jpn01on2070f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:700c::70f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7CEE87483
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 04:22:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=omron.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=niek.nooijens@omron.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WggrS7BRYkloZT6Xjvh8HF39Pms+vJTsV+HqPUMaDhpQnyl1uCmk9U0LfJLTLLzgVrePuWg5KgNTdeJFdeoiAYbk1QomvtfTItWdvNO+YgKhCOPXK3meNbDCoHOV1jPiymd9uqYfv8Gx7of5hB1vKUAh14SFl/Txaao0pGxCxAafCQME7jP6yyKLEjbwdvmEGWN4Gnp4JQjIRTNYzVbI0rjyDA/fUDMi1Ptdutd/EgygkDQzRPnjdmqDiv4hice5iPRzhv9Z7zM15gnz9//1+MaFNTHq6N9vt4ExglBN45ijjPcaLioNs4fT8qpqjXpqPl21SLq4Pl5WvgDifAihCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yj2aiALInzf5y8Za5BcV8rLYcsrhhb07NDG2GfFzgRo=;
 b=UnGZ+kSjmvaKss8yVHGc1EjoYcLVzg/xzRUJ0xkAAPwEYfGc5lXFhK6ozjwSHIPg3DDgxEK9MTJdR+rbxD8fmKcL59Mgf8m0RSV1FvjfyCjbWHJ1hsI9R8MoBFs9XOALmEDnueW7IEATeDCVziEYsMXygo+50JKXoFjaVcZnAKVwCwrADxtna3L6fxE4CmUImAdRYEQm4mrgCa/sXAu4IK/N6GKU3twP8dpmXDzTbz39H+zlWCJlWVLhoGjcKQ5ITfZVpA6SdH9Kq7TP2kOfj1CdAGiVgeEBn5LlN13jFMtBKLPR2J9J0H8eYacSPI8nH8Biy4u2Ccfv4diCifQihg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=omron.com; dmarc=pass action=none header.from=omron.com;
 dkim=pass header.d=omron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=omron.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yj2aiALInzf5y8Za5BcV8rLYcsrhhb07NDG2GfFzgRo=;
 b=mv902hS1zeVkdnBKaKk95PK0cbTcKNB23AXbHDE4jb4ZMFurSNozSLOyRiPIRhJarK8IBNy918xjdIteQaw109arh44lM5kRrYP4/oeCmOp6NnAnPMJlpidyI+2xfMr23UCABxc0jgGjs1xt2ETScSEYvhY6TkB1WUolL7w205Q=
Received: from TYYP286MB1500.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:118::10)
 by TYWP286MB2418.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:16e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 02:22:28 +0000
Received: from TYYP286MB1500.JPNP286.PROD.OUTLOOK.COM
 ([fe80::40:1580:4dd1:e43c]) by TYYP286MB1500.JPNP286.PROD.OUTLOOK.COM
 ([fe80::40:1580:4dd1:e43c%5]) with mapi id 15.20.6933.019; Thu, 26 Oct 2023
 02:22:28 +0000
From: "niek.nooijens@omron.com" <niek.nooijens@omron.com>
To: Simon Glass <sjg@google.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: quick question about TPM
Thread-Topic: quick question about TPM
Thread-Index: AQHaBjKW0la4Dg61rkK1nPrJuPcPf7BZPF6AgACKwQCAAQ0xAIAAhQVf
Date: Thu, 26 Oct 2023 02:22:28 +0000
Message-ID: <TYYP286MB15006711E2339FD6BB432045F6DDA@TYYP286MB1500.JPNP286.PROD.OUTLOOK.COM>
References: <OS3P286MB14955A84C3B71A32C4BBA352F6DFA@OS3P286MB1495.JPNP286.PROD.OUTLOOK.COM>
 <CAPnjgZ1A8vyEUx2wiXqOCb8Kf9zP96wqy4kXanfKRR-uN6yOmg@mail.gmail.com>
 <OS3P286MB1495889DF57AD742064FDB56F6DEA@OS3P286MB1495.JPNP286.PROD.OUTLOOK.COM>
 <CAPnjgZ0Bb7zzVabU05hfg12tcrQbzT1iWQVdrui2GmsEZekZDA@mail.gmail.com>
In-Reply-To: <CAPnjgZ0Bb7zzVabU05hfg12tcrQbzT1iWQVdrui2GmsEZekZDA@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=omron.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYP286MB1500:EE_|TYWP286MB2418:EE_
x-ms-office365-filtering-correlation-id: eb7b6091-5c2c-433b-867f-08dbd5ca6663
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gTpWHkUk6bDV9f3cxYq1LP2M3xFg1I00D6uVm02cr3bubSZxSW/tOHZd4VM/9EEHxzBy/K6m6JGw3FfZe2nRu6in4FLeRvyNB7KRaqBsMyHEwweXzkettezlcNxQg9Nsqb1C/iObhizFu5xo7r78efnPsAZAdbIL5krP8ZqxpqWZZV3IhE/1/BC1mw8CVvXV3YVeZRkZRrdrNYGjJ0kLdbecO31sbIPbG3FoOlTtcZTgjqjLWp5Gahb1XsVORZDew2zk/EcUkZtl9+L1iH5MageaU/2Ydt539Utua7QRv2eTytfXw828O5XyHgvGFTGjP2KMzOpim3WVXi3plTMEjXPkz14mEAbIZfUQMqtu/XWgnLGTR+U8fVjRrZ1yw6/rgAxQnw+PQDkFerxl7gTsIlA0r1aqQE4t5W2y7MjrATV06QBcktT2C232UOmgPHqQSFc531IYNIEhfLyXC9uX5Wj7Q/rtxpeQ8wJd7++NOGoa1hbpv4y4QUKQnLrLYvmFKyjTfMBwwN3kJ+t/ni0WRq7Osc0eRGu0SejWqvcsvTIkeeuYqAt0vB/RTt8zZJag5/zocAx42R8kp2UzbSLvxc89YgVDcVNSOgaoHOekPP8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYYP286MB1500.JPNP286.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(346002)(136003)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(38070700009)(19627405001)(55016003)(83380400001)(316002)(86362001)(41300700001)(122000001)(2906002)(21615005)(5660300002)(33656002)(52536014)(66556008)(71200400001)(66476007)(66946007)(76116006)(91956017)(38100700002)(166002)(3480700007)(478600001)(8676002)(4326008)(8936002)(64756008)(6506007)(7696005)(26005)(66446008)(6916009)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?MGdYV2wwRTlYUmVsViszTnpCQy8wTUJqYXhiLzIxUURJNHhQRFJUOGZu?=
 =?iso-2022-jp?B?THF0UDJDVVQzSXVuYzROUVVjY1pFa01UYWFkd0dPbzY5ZnJJbjBsWXBF?=
 =?iso-2022-jp?B?dVN1c3V4WVdxaEZuMVR4elVrZ0VDWll6Z0I2NmxXVHNzZ2ZOVnBvTERn?=
 =?iso-2022-jp?B?YVBCdUt2UkwrR3RvOXpjRC9KVnU5cktydTBPeGZ2M3g0N3ZodXU2NWRI?=
 =?iso-2022-jp?B?MjdGdHhHNGg0c0VqVXJ1UzZRN2VkdUpFM1pUWVA1Y2ZsbVV6UVFkdkVz?=
 =?iso-2022-jp?B?K1A3cHlGUURNU0NEU1NnTW94ak9NblIwS0NkR0pzTXEzMzcydW1FMSs5?=
 =?iso-2022-jp?B?OUxIRkpKbVc5amthS2FpMnk1dVozWlZVSGl3Tk5hUWtuaFVwcHA2ZWlK?=
 =?iso-2022-jp?B?eHNUb0Ftb25NVUlubEhkWWwrbFpyM3RIdDUzNlRMWkttd0JBbzZ6d2po?=
 =?iso-2022-jp?B?aHBmZkVzTll6ZU9SeGh0eXJDbjhLU2prcWNPRCtoMUFmcHoyUzc1MlA5?=
 =?iso-2022-jp?B?ZnF5ejZxdzM5OFVtMERINXhENEE4QkRCRXRsb3ZPWUNtMXUzVXhsemFK?=
 =?iso-2022-jp?B?V3YycDN1OUtYdVBVREUrbUd3Y1dKNFFrb2xKejZqejBISUtrSE5yT3dH?=
 =?iso-2022-jp?B?YkJzR1NWN01QNkxMM08yaXdSRmhDQ0Vvbkd4NTgxOE5EbnFyWnF2dlFS?=
 =?iso-2022-jp?B?MmoxRHVDeHJLNGNnb0FrSFA5UFZIWlhpWW5HcmNWaVB4Q0xjdmEwYVU4?=
 =?iso-2022-jp?B?WHVUdnRyVTdEVWlYL1k2ZUFZOHB4SUIrWWY4Zm5LcU1XSmpiQUxQeXly?=
 =?iso-2022-jp?B?MnRLUkNOUU1VNUtBTlYrVFB6YVhvSzdJTHNHT2VSa3JGeko4VjhQU3JF?=
 =?iso-2022-jp?B?ZlJnU0ZEYmEydWVuN0doZThWVkZQNE93bFJuODBQeEZsNkE4Y3YyS2tR?=
 =?iso-2022-jp?B?Q2ZyUEpXOUhoQkZoQ296VGNoaEltdUhGK09WNjNjQmp6TzVZdVg2NUxk?=
 =?iso-2022-jp?B?TU1JNjBIQWVkLzNVQ3B4bG5WTVNqZ0ZtNWFRR2dpcDVVbDdBancrUHN0?=
 =?iso-2022-jp?B?STZwbmNVSHY4RWQvbGc4Q29sUDRNcVk4QWUxSUxTd3kvdm5BaFo3TndD?=
 =?iso-2022-jp?B?ZEtuVFNPbTBwWTcwa3h0OGNqZGVoNVAwZDRUUWE3L1d5b1VlT2huT1k3?=
 =?iso-2022-jp?B?RTk3bmEwL3d2QldhSmdwam5LWkNqeUVsVFRkNmZSZ2x1M0txTFRCL1Fi?=
 =?iso-2022-jp?B?NlRZQzNMODJ1dXMrTGdGeVp2TXIySGk3cmI0d1BRTG1NbkQ4ZTI0S0lj?=
 =?iso-2022-jp?B?RVk0Ky95RGZKeUI3bWplK2o1cldFRVpXYmxNQmlaZmdhUGd5clpXc1py?=
 =?iso-2022-jp?B?WU5JdzYrWFlLVGdnV1lEMVpqS3V0SGV2QXdmM1g3K0I0WEV5Z1VQVXQ2?=
 =?iso-2022-jp?B?RTRUL3Eya3RVc0RscFFSNTVRdGd4SDQvaXJQeUptVk0rYVQ1MW1ocmxZ?=
 =?iso-2022-jp?B?VHlHaCtLQUh3b1pkK1AwNFN3YW80MXZxRmNGcEgyQThjWDhYU3I0L2Jp?=
 =?iso-2022-jp?B?Q0dIYmU0amtuNWZUWVhPa1YreHcvZHVpcDhJTXNIcGJNeU1EU05VOHph?=
 =?iso-2022-jp?B?WU5hYTlxcGdKcHkvMmhNUTBWZ2JuOWJXR0MyY2tSMUtrdDlIdGZsUndR?=
 =?iso-2022-jp?B?MWZ0SDdReXJHMW9SR0NoZzBhNnhnOHBqWjY3ZXpNYUJoWEw3NjZkci9o?=
 =?iso-2022-jp?B?ZlpwYTBzZDQ2bGpCcHBGQXpLZHd4TTlaQmwycE9XYnJtNE12MXpXNnJo?=
 =?iso-2022-jp?B?VjBKamdFSFVIakJ3UnI3RzdJNlE5eVJ1UjdRckJkdjNKYVpqWitWK0pl?=
 =?iso-2022-jp?B?WDZwZGNlRkJSWXhBZjVlWGl3L0thVEVXejNDZzdmNmVOT1NOd1RFK3c2?=
 =?iso-2022-jp?B?c21ZclVZZ1RlaXlidVkySFVZREtkUmNCQ1hiVUg5QnU1bXI0K2g4TnBp?=
 =?iso-2022-jp?B?OHJjRnFxaHF4YnRKWXRaMlNabk5NdERrT3lWM1MyajNrM2FRdmtQNHFO?=
 =?iso-2022-jp?B?R2pNY1FEU0JZK0J2dFZpRDFtTU9IOC9GYXBrSlplVEliM1ZFTUppVytU?=
 =?iso-2022-jp?B?NGl1U3dZc2c2ZGJVZUZPMU9TcE5PbmlMNk82ZHFpdXJnQmk0blVXTGhR?=
 =?iso-2022-jp?B?eHBFZEk1RWJSTGRaWmlWT01XTk9xOHRkVEpRc0Q2YTNXY3J2dk5yTmRC?=
 =?iso-2022-jp?B?dlcxOU5tQmp2cjUrMXNhS2toYVdpa3RiaEE4a0hyeU1RZkM3Ykx6bXE0?=
 =?iso-2022-jp?B?ZmllRw==?=
MIME-Version: 1.0
X-OriginatorOrg: omron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYP286MB1500.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: eb7b6091-5c2c-433b-867f-08dbd5ca6663
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 02:22:28.0661 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ecff5a9-4bef-4a7b-96ec-a96579b4ac37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nVLNcTTtm+FJvsop1z2NaTlpl3p5ddVPd1Fwo9WlVuKNpBlW/hDBx+ox0h+LSe33q6d8wisWYbQeD8pdEVLbrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2418
X-Mailman-Approved-At: Thu, 26 Oct 2023 06:23:24 +0200
Content-Type: text/plain; charset="iso-2022-jp"
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

Hi Simon

Yes that fixes it! Thanks!
Maybe an Idea to add a dedicated TPM page to the docs with information like=
 this?
(https://u-boot.readthedocs.io/en/latest/index.html) Cause I wouldn't have =
thought I needed an option tugged away under Library routines.

Anyhow Thanks!
Niek



________________________________
=1B$B:9=3DP?M=1B(B: Simon Glass <sjg@google.com>
=1B$BAw?.F|;~=1B(B: 2023=1B$BG/=1B(B10=1B$B7n=1B(B26=1B$BF|=1B(B 03:23
=1B$B08@h=1B(B: Niek Nooijens / OC-IAB PBD-C DEVEL 1-1 <niek.nooijens@omron=
.com>
CC: u-boot@lists.denx.de <u-boot@lists.denx.de>
=1B$B7oL>=1B(B: Re: quick question about TPM

Hi Niek,

On Tue, 24 Oct 2023 at 19:26, niek.nooijens@omron.com
<niek.nooijens@omron.com> wrote:
>
> Hi Simon
>
> Driver model is enabled, so it's pretty weird it doesn't show up.
> CONFIG_DM=3Dy
> CONFIG_SPL_DM=3Dy
> CONFIG_DM_WARN=3Dy
>
> The TPM menu is there, yet somehow empty.
> This is just after "make socfpga_cyclone5_defconfig" and "make menuconfig=
"

Do you enable CONFIG_TPM here?:

Library routines -> Security support -> Trusted Platform Module (TPM) Suppo=
rt

then the drivers appear for me (under device drivers)

> if I use "make snow_defconfig" the menu is usable like normal, so somethi=
ng is disabling it, yet when grep-ping for TPM in socfpga there are no resu=
lts.
> Adding it to .config manually also doesn't seem to work. so I'm a bit con=
fused about what's going on. Anyhow thanks for the help!

You can edit the defconfig to add CONFIG_TPM and whatever driver you need.

Regards,
Simon


>
> Niek
> ________________________________
> =1B$B:9=3DP?M=1B(B: Simon Glass <sjg@google.com>
> =1B$BAw?.F|;~=1B(B: 2023=1B$BG/=1B(B10=1B$B7n=1B(B25=1B$BF|=1B(B 03:03
> =1B$B08@h=1B(B: Niek Nooijens / OC-IAB PBD-C DEVEL 1-1 <niek.nooijens@omr=
on.com>
> CC: u-boot@lists.denx.de <u-boot@lists.denx.de>
> =1B$B7oL>=1B(B: Re: quick question about TPM
>
> Hi Niek,
>
> On Tue, 24 Oct 2023 at 04:51, niek.nooijens@omron.com
> <niek.nooijens@omron.com> wrote:
> >
> > Hi
> >
> > Just a quick question. I'm developing a platform using the socfpga_cycl=
one5_defconfig
> > everything is working, linux boots, but we decided to add a TPM to it's=
 SPI bus.
> > For some reason the TPM support menu in the menuconfig is disabled and =
I can't seem to find out why, or which file disables it. can you point me i=
n the right direction?
>
> The only thing 'config TPM' depends on is DM (driver model). Is that
> somehow disabled? Once you enable that, it should appear.
>
> Regards,
> Simon
