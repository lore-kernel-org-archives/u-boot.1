Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F3ACC47258
	for <u-boot@archiver.kernel.org>; Sun, 28 Jan 2024 05:19:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84C25880E1;
	Sun, 28 Jan 2024 06:19:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zf+REt21";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0AF2880EC; Sun, 28 Jan 2024 06:19:38 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55F0B8784B
 for <u-boot@lists.denx.de>; Sun, 28 Jan 2024 06:19:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=de3XSH3xKTtDHM86X2aXXP9PyK8MuZj+6GuE7orhwBjDKcU5vuUSEbdtQKE9dwkkt9XFaY4OkgKbR2tC/djEFx5te1h519Kp75H3Cp3bh0ZdnoJPnOYsqPxpdnEggfDtP1aWA+9WjkffLWDgyUUkuyZ+6hgGUjuZuUXOD7DBT0+cOjb4rGiBP1nsSw1bmE3DWrix/Z8ZG9vEcTlEL/eonP3bBoFSyGSPBuJrpd0TFzZLl/XpLolroJRokcSJQ7YsdPyYPVCV6boDxieO7YogW9dy+Zv0YIUvnDSTdPkNUUW1odxbQw7AEBTYS5jM6L93K0iGjX4pw6CXlT9vLiEj/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kKbMF5uRFFTTcfur9P2V2W1Z/LmFTEZ7fu2zi6hlaA=;
 b=Yt5upnWjMYqMzeewxx3IukmpfqxQky4Swu7s53FG3Dzx5ZbFtxWsFZ6UJRSd0+l+5v659MA1JtPrIfGiABMAqclDgB9hzpnOVxRCB2BdILLTR5Arz8MiSx4lD1dQqk7EKA25E7tC69PKVfJsrypVDkG8eFC2vdoQjs3ZuDHmWQ4ODCLjsO/4+9QAQ648aENKtSsZSnpH6+rQgpAd2t7PLpRhzuzGZ+oaQ+1ePi5zLhwltKG5TfI4P1RfgISNuLbSTP/Ig6s0QrCyibeK+F1VauolA9UdvWTcvlAzYMnl2XEW3QXyvTGe1eQYQx5+vbmg//+9NZjGlcc9c9rq21Qb0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kKbMF5uRFFTTcfur9P2V2W1Z/LmFTEZ7fu2zi6hlaA=;
 b=zf+REt21/EHZehZ4Iep5qQJk8Ta8RxqYcioNMp8bcUfP3wVSOuP2muHvq2RBEgZLYc0w9nmYwriCiYEXhohdRiFYmHMWaqcazp3jvl0uc99kSKVYMfgtlqiwiSNF2d3c+7yHxz3lhCg2Ia+dwDkPnVSczZXPPuLoxU5nicoi01w=
Received: from BL3PR12MB6450.namprd12.prod.outlook.com (2603:10b6:208:3b9::22)
 by DM6PR12MB4122.namprd12.prod.outlook.com (2603:10b6:5:214::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.31; Sun, 28 Jan
 2024 05:19:26 +0000
Received: from BL3PR12MB6450.namprd12.prod.outlook.com
 ([fe80::39dd:303b:6776:9ebd]) by BL3PR12MB6450.namprd12.prod.outlook.com
 ([fe80::39dd:303b:6776:9ebd%6]) with mapi id 15.20.7228.029; Sun, 28 Jan 2024
 05:19:26 +0000
From: "Bhumkar, Tejas Arvind" <tejas.arvind.bhumkar@amd.com>
To: "Bhumkar, Tejas Arvind" <tejas.arvind.bhumkar@amd.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
 "sjg@chromium.org" <sjg@chromium.org>, "d-gole@ti.com" <d-gole@ti.com>,
 "a-nandan@ti.com" <a-nandan@ti.com>, "Simek, Michal" <michal.simek@amd.com>,
 "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>, "git@xilinx.com"
 <git@xilinx.com>
Subject: RE: [PATCH RFC] spi: cadence_qspi: Address the comparison failure for
 0-8
Thread-Topic: [PATCH RFC] spi: cadence_qspi: Address the comparison failure
 for 0-8
Thread-Index: AQHaTSQiTnVxSJ/wUUqWc/J5Tz7UKLDuuDUA
Date: Sun, 28 Jan 2024 05:19:26 +0000
Message-ID: <BL3PR12MB6450C213AFE0605391A3643FD87F2@BL3PR12MB6450.namprd12.prod.outlook.com>
References: <20240122111345.2383833-1-tejas.arvind.bhumkar@amd.com>
In-Reply-To: <20240122111345.2383833-1-tejas.arvind.bhumkar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=fec25ff2-ee18-4afc-bd14-30d0522a30a6;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-28T05:17:11Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6450:EE_|DM6PR12MB4122:EE_
x-ms-office365-filtering-correlation-id: e61b4a86-1c14-489a-e3cd-08dc1fc0b23b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2r2w1rm7vg4DkAherPXQwTgqOO7uR0IOMPdv2pi0wVbUPqDoFo2sGY1BcHkGXkDZS1Zu13kbZdy3OmW4UhT9Yx4FR5rVNtueJGA3+sueUl02U1gLRg6HrZi4zTE0f9ytPdO2Q2t3QJBoPGGCLAI2AjYS/cFsnJOlLqqZyILAw8Ximjmy/fvTKaqNL2N3PctNAe5X9gKsseXnhN7rnACr/in/p7DL0sRKUX+OYqhxYc1RqMZm3Dob5MWV5gduoHh/F9YrUtgoqLx2OmmugWR95umwAIcRuPmSNUOXUbbZbQTPVQR/x4FDVP/ZGg0Wfry2av70hlQ8pUHyh7rcoL7rS4dFQdOVjzFV3WGKv3z/y3IIX8MSwgWDYBNupcvGkZfd4isHB2u4OLjrwfZS7XD9SdqepE6g2ALgPP7SpCrsN2oKdI89U1ydyY5osqjDK5pup/ZHpg8hYHvznPnVXTAoI/yTkss00c6PF31ekDylbxQF7dr4rUyylGbwYQa0LmAW2VFDVLJ/Nw/SpSA1T/yWu97WYdtbF86yolC7JPuxlo9veoA4EXl0a1sPbKk43Yp0qX6pRdX3RoBe+6X9qlPIaY/lXgIuhhVkpFshJxC6rbR2bXaYLpiHUEY0uQ4Dvark1KwLP44nnlpM2sbvQ/d19f/6fhqP59wjhO8duJfz0Ag=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6450.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(396003)(366004)(136003)(376002)(230922051799003)(230173577357003)(230273577357003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(9686003)(26005)(38100700002)(122000001)(52536014)(5660300002)(4326008)(8676002)(8936002)(2906002)(478600001)(6506007)(7696005)(53546011)(71200400001)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(316002)(110136005)(41300700001)(38070700009)(86362001)(33656002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sEQnPiNeg4rRY9ru3RhElz0Xqh93ftUbF2MG0WvooCR075/0dhZaLs0moAGv?=
 =?us-ascii?Q?B6d/T0+Z4NYAB3RQBP/QU+8u0J3WEITaDRkEGR4CcKUDzsZITxDGJ0kIFMe7?=
 =?us-ascii?Q?FSvGt+F7QWSVRE9IUz3GMtBdEk/rSrirNJE0l4R8073vdY9z2XlQZVc6eCIU?=
 =?us-ascii?Q?NVP6czyjlNMpYj9mSxJKEY4Cl7edOoXYflhTNhpvn9e29rJAHer5iIi30NZm?=
 =?us-ascii?Q?iqfOFTWrcrhrEOTux6z9aNid3oWKJ3KTGBbVaXqZrlZtT0YM8oFHtkm4i3hY?=
 =?us-ascii?Q?YpBbA2S9hbwLXhuUHxuf+oetQND+1s10/L1njElnf4fLDKDw40mh4zJBUdPE?=
 =?us-ascii?Q?wxhFWwfY1KIGoXOrXJ72ThxCCeLdOm3k63Kh+C55v9yyDMSN8psIDtL01IGj?=
 =?us-ascii?Q?7NvT8N2g/rv2wsF5Jml5/J6bPNOfqJ92ykP1wpIH7KlxEeJKI3TU87hI6X6t?=
 =?us-ascii?Q?kby9dS7lEwtF9nxH1lzvUrxpK6Vs+TDBe5dH6n8tDVfXRiiyojfeY+BiJDKs?=
 =?us-ascii?Q?FBstwLfmPEJR89B74Y6U8359Oi3rSVYSG+M0wnX/rKBjOX15K9QzfmsSo95G?=
 =?us-ascii?Q?eZuxz7cOQJDGAVQyG2BfuTuoaWe7Le3EIYr+kEQmXFYXp8wpWvt/sqdFcXSB?=
 =?us-ascii?Q?nDOUnEDp11s2lpySfsB7fnao31cShgBBwjYWQyqU7mrTy3H35L+HLfd65v3y?=
 =?us-ascii?Q?Vvny9+7SW3LIR8ZlpbK6dhD+HN1z0LBYhAy+VgoReWmi05tEvR+3K9YasoE8?=
 =?us-ascii?Q?i6nsT0rECrOlW9IWpSkmO2PgoxBK7KP09mPq7duTFBbfuF34Y6Y5ElB1O5iq?=
 =?us-ascii?Q?+RV36lTqbgHrAC6ejnL4hdO5FLYFMM15n/bnBIFt/vBHvv68he25ELlsqz/6?=
 =?us-ascii?Q?2A6babxcQlJG5So/cvOwGtXdbjFoXmC6azjWn5By+62AuhWaNRBHtdOHOrAm?=
 =?us-ascii?Q?z3YvMPwMAM14rylb1ihB3pIkleT9B2K9e1IACgnAYacoKERWQTWYjSSEy689?=
 =?us-ascii?Q?j2+axvwh/mrppOTAeKqcmDLZlVh0hmcMr7/LiIiQ2AYi5u4Q55LcMKBhnPkU?=
 =?us-ascii?Q?N/ptIi6oKjZTzGQamdkPw3j5OUHfcMJjistP+cyO0keNddkTyo5W+ceQcbWs?=
 =?us-ascii?Q?vzJqqmszhsfqSjccrE4AJplEdvauKFnrESqei/lFcEox7Z2OrR0beGv8LTFy?=
 =?us-ascii?Q?w8q9XANLkjI3rXK+Wl9x6B0HhLhu+xQN87AqgsPzvtvoIW5LydvhmqLurYm3?=
 =?us-ascii?Q?V48JqmREn913PyT8F069tJgHEpWfhY/LKfyA+rbM/L2PHfQFtrL5+8ADENfF?=
 =?us-ascii?Q?7YzgjFV/FBpHSyQaSBw8wdG7JGC+Gu+S1Hbp4/lpuLl1+uutNnb9kzzVDw9Q?=
 =?us-ascii?Q?edqLXK/+IPIlNU1epV9/PlE/xHC27+v2fvBS+PrQeRKj8SM6wPGtYRGFJ76g?=
 =?us-ascii?Q?uIfSkNptQL7l0thZCplbt/VSq6BWBtrhZH5s99mhNMwPA3MYFdV1xBJzknBt?=
 =?us-ascii?Q?8JsyYwAA1xiY87dS01GkWCZHkoNVAu4d/BkFjtaCpYXnw8MQ3YP6vlaz/DId?=
 =?us-ascii?Q?PSk/8c0sgtLkBqWSyZA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6450.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e61b4a86-1c14-489a-e3cd-08dc1fc0b23b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2024 05:19:26.3996 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VSE3lvN1sIQlVNk7da0T4brzW1ymhgA4siFTQJNdcKuTDZS/l3F2DXRpMVKOkV23wT2XIwh7Tq9Wb8XScW0xBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4122
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

Please ignore this patch, as I've submitted another one to address this pro=
blem.

Thank You,
Tejas
> -----Original Message-----
> From: U-Boot <u-boot-bounces@lists.denx.de> On Behalf Of Tejas Bhumkar
> Sent: Monday, January 22, 2024 4:44 PM
> To: u-boot@lists.denx.de
> Cc: jagan@amarulasolutions.com; sjg@chromium.org; d-gole@ti.com; a-
> nandan@ti.com; Simek, Michal <michal.simek@amd.com>; Abbarapu, Venkatesh
> <venkatesh.abbarapu@amd.com>; git@xilinx.com
> Subject: [PATCH RFC] spi: cadence_qspi: Address the comparison failure fo=
r 0-8
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> In the current implementation, the test for data ranging from 0 to 8 byte=
s is
> encountering failures. This has been confirmed through testing with both =
ISSI
> (IS25WX256) and Micron (MT35XU02G) Flash in SDR mode exclusively.
>
> Upon analysis, it was observed that utilizing the "SPI_NOR_OCTAL_READ"
> flag and attempting to read less than 8 bytes in STIG mode results in a f=
ailure to
> read, leading to a failure in the compare test.
>
> Upon reviewing the Micron OSPI flash data sheet, it was noted that for pr=
otocol
> 1-1-8, 8 dummy clock cycles are required. While the current implementatio=
n
> achieves this, it still results in a compare test failure.
>
> Therefore, the code has been revised to include DMA read for operations
> involving less than 8 bytes as well.
>
> Fixes: 53f4ef0 ("spi: cadence_qspi: use STIG mode for small reads")
>
> Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
> ---
>  drivers/spi/cadence_qspi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c inde=
x
> dfc74c882d..a6477dbfcf 100644
> --- a/drivers/spi/cadence_qspi.c
> +++ b/drivers/spi/cadence_qspi.c
> @@ -313,7 +313,7 @@ static int cadence_spi_mem_exec_op(struct spi_slave
> *spi,
>                  * which is unsupported on some flash devices during regi=
ster
>                  * reads, prefer STIG mode for such small reads.
>                  */
> -               if (op->data.nbytes <=3D CQSPI_STIG_DATA_LEN_MAX)
> +               if (!op->addr.nbytes)
>                         mode =3D CQSPI_STIG_READ;
>                 else
>                         mode =3D CQSPI_READ;
> --
> 2.27.0

