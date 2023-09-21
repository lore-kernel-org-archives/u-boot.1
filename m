Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D81E7071E
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 11:27:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 069F386C24;
	Thu, 21 Sep 2023 13:25:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=withsecure.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=withsecure.com header.i=@withsecure.com header.b="O4GRfIJN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED23286053; Thu, 21 Sep 2023 10:29:59 +0200 (CEST)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on071c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1e::71c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AAE48646E
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 10:29:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=withsecure.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrej.rosano@withsecure.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvDcfn7f+TSCG7sbdE4z5uiDD1P91hx45yyoZslC4g8CbSw7G9g3uT67lXp23zSGxDQe9dwC/fVWd0r5sE26YhKw4y/n/vufTr2PrHec0VRLi365fmwUfUxeFV4oRcrFz25m9edhBLl1kxrsykzrDwKz2qwXOKLBHX67EiivVuWz/6CXWIbnh+z39rLf/sNrhhD6Bg8MVcok6E3pc7hPgJNKUHcOliOPpMWt3UG2ZbcOJSZJi1HKIq99LMAmF1wwbRE5qnI25sWDwCIj4NBTKiQxoQZcCzzQ5EfKuQL07saQTz1AN3ooi85Tv+wWIXse1gorc/SKzP3DgjcuUylAYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UX8VoBOtXZbIH8jBY+UD+3VHwCB65bdGLyB8559aOcg=;
 b=V05RplAnxidVkx4IpHDwop0p87pPDiNFHyPPxht3S+VZI5WvF0tcDmlQTXM2NOHFZ49u7B1zLm2xV+UrEqH5QVjuN6/CXPxVubqmIR8b+1RsU+sxTmMvBNJuMNBzatKsc4a3olwZquBHBhJWsBUE3Pp7ArDEgfBmBXM3kFDH3egT4qFFAapuBpjmPZZ5jeiEbpq1zZz0NwRvf7yQLsdcOGV4YwRLB8vMwHyEIi7pcw1p3sMGjiS3p5LutMry1rs4bK7GIudUhBY8BX5oMnCB0avmiQIUcAXNS2hj8YjH7vn9G8O45xwOKjsjFIF/RfsSXZ9Ug618f3d+vTs0zVgfMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=withsecure.com; dmarc=pass action=none
 header.from=withsecure.com; dkim=pass header.d=withsecure.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=withsecure.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UX8VoBOtXZbIH8jBY+UD+3VHwCB65bdGLyB8559aOcg=;
 b=O4GRfIJNNXYlyH8VwzYZxuNT+IKld0lKEmNRxN5PQUiArKpyvqNFCKQehawr8brqFdMx9+LrJ24me8mtwUms+k5PRvPHmVO0rZ3F5TtWVX1yJbjkRwRyW58R/87J8JlHt1TTAxBWsBy+jyDQt7zRAR0nIYOrZCpMVeLgwsAcqCD1o52/r/QXNxg9qN0lSLHmkvxHofXdkuUlmlHr39wPzvNelSKwGrpHNfQLhaoJIVzK3i//i2H9dsy/n9v4jVWFID2+nN+WH85bnDyukLU2zDEpomeAVWEaxuHGygZar/yCBDPkJk4UafjtcsgeLPfltJavxvT3AQdd7LoAsGPyKA==
Received: from AS2P195MB2251.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:59c::10)
 by GV1P195MB1689.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:51::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 08:29:56 +0000
Received: from AS2P195MB2251.EURP195.PROD.OUTLOOK.COM
 ([fe80::fe4d:97a7:b7f1:3cf2]) by AS2P195MB2251.EURP195.PROD.OUTLOOK.COM
 ([fe80::fe4d:97a7:b7f1:3cf2%7]) with mapi id 15.20.6768.029; Thu, 21 Sep 2023
 08:29:56 +0000
From: Andrej Rosano <andrej.rosano@withsecure.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Stefano Babic <sbabic@denx.de>
Subject: [PATCH] usbarmory: Add DM_I2C and DM_SERIAL support
Thread-Topic: [PATCH] usbarmory: Add DM_I2C and DM_SERIAL support
Thread-Index: AQHZ7GXN5pzDq8KsZUqF24Z5Wsv8iw==
Date: Thu, 21 Sep 2023 08:29:56 +0000
Message-ID: <20230921082955.28951-1-andrej.rosano@withsecure.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.42.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=withsecure.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS2P195MB2251:EE_|GV1P195MB1689:EE_
x-ms-office365-filtering-correlation-id: 476b5692-0a15-4d98-3314-08dbba7cefc7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: loZSHrBn2q/Equic1ZYWu6Fed40km0NYmALZvl7q5vImwOo++0X8ZuaEe9mVpj12gg9ROGDrdRnSyhy7EEg+0lyQ11QXvmsWLPhGRznpa6MtVRRWUB70W7kaXCkcHGeyKdCfGNP9OTKPEmkY0yXVh4P6pQ/q1SGBEdhOVOSCX2UVmgQJp2XdQwKpREI+KpfbUBYdErdmC918xh40PuZgYV7NygpolMMnS0lYmVhc5OSii39Ogz4ifkKezrDlfkZzi93MhfPPnBkN3Ha0z+OQefaFCrf4UP3IWDaznCVQAfXLSIh70z2ghfdwfpcV6RkSmW1By2C8qNAFaHVP5YjV21/DOow8B4fioKocnY8T27sw9YkXJyK7ihPS7jQOVv9HolWGWxlvSNEaGBH8nGmb2HO6yF92wFiDsQXn/7UzWz3zdQJOM+mV4hXU8NLnsUsIjAHjb2SoTNf10T7q/5Zt1FJrLJd2Xlx0L+SRCwJu3KirzYLMXOCK7+BcjXuuQlQn5OhuhWI5Xne8DfUmrnHgOunTVRh6V6m5S1yAMTf0vWpVCnRXtoZlGBvs4hS72kjAYnBEX2JHYCxnCMCLkbeTG8vmrtUdmSeFHR1pMOXCXRChKZSzvHRHaVl2zuXL3t4Q
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2P195MB2251.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(346002)(136003)(376002)(39850400004)(186009)(451199024)(1800799009)(5660300002)(316002)(6916009)(66556008)(66476007)(66946007)(64756008)(66446008)(91956017)(44832011)(41300700001)(76116006)(8676002)(8936002)(4326008)(83380400001)(4744005)(122000001)(71200400001)(478600001)(6506007)(6486002)(6512007)(2906002)(38100700002)(38070700005)(1076003)(26005)(2616005)(86362001)(36756003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xvanPSgzQYIxcKL/4pUWugohcYEQaJUYJCn9928jG5BNzMIth0h8N/iFgO?=
 =?iso-8859-1?Q?UZJXmVOm649Mdyy0ymMys4yOPF9xPT10fPVMiLkPfkn0ig/aEEwldJPQUb?=
 =?iso-8859-1?Q?ZM+02LHqD4F6DRzg2ktr/Fd8d7bdauj+zK+oJO0PckfI9Keryr4QOLSzgL?=
 =?iso-8859-1?Q?4+dTe/TvCM5q9kYKsK85ZiWD6miIcPlr7oa4X0jjy+Wr0kpVSGRulT/xjg?=
 =?iso-8859-1?Q?8C7b1QYhLMhi5DB9SZRxf+QEYkDP2uAjo3GTeF2CtDfIuWKvhkPTJOsi3k?=
 =?iso-8859-1?Q?z5Y9hcYpdVAzEU2U0K9oTBLv2FaDndhWaP8Efr+aVCPiOVujhXD/7+2GLa?=
 =?iso-8859-1?Q?6u4ty1hnbHMZsV1ldccaaaQKTWjd99j5/V8I58lDB1NgJPV6vylNmF5py3?=
 =?iso-8859-1?Q?YJ6nvLNNaRv7DdRERyKiTipRwJhBXuL7uk0wGdjdMCKtHE6EDl8ImM9RSR?=
 =?iso-8859-1?Q?TxpyUie94PlVBRCVRgUT4I9/hZXmLa+Rd+cdIWOiMLgsSHtKBDVf8LpRUR?=
 =?iso-8859-1?Q?f3PE0Srv0A4M5oHcu3lWCb+ASoVtOlJaYK6uOPJy0YZfTLaiAeHnf4jL0N?=
 =?iso-8859-1?Q?QPedayVs4Y8LnKpznS70AsqIOZ21HGgpeZQG8yIRWR98GchxQiI4VFuIiU?=
 =?iso-8859-1?Q?6IiSR+dSNYfPRqk2JR9hwNhqfsXgRhrNRb4biJRLj7E0hC0XnCKBkBRqOj?=
 =?iso-8859-1?Q?nBgVLOSSChF8kzHqlRwT5gN0mx/C3b7VFnsK8IuB5IseOyaIrd9ZkqyEGM?=
 =?iso-8859-1?Q?b9pGeQlzVIh8bHt9yh67FIAyyiDGrqz+6khMyXu/b7Gz6Sxg3Q+0U0LVDM?=
 =?iso-8859-1?Q?hiZFTJXJSr2UdxTFBLwj4bdkxy0YtLe3t/SS1p2yq20NXKhK1qSF5EQxwc?=
 =?iso-8859-1?Q?1d2fdaarX3k1d6Xf2kUi6+eTtEMjUy93Fm9S4WEsAh3Lvfrx6mISgoMApv?=
 =?iso-8859-1?Q?nOSwiomVVP8LHe3IH652QHGykB5mFYKnyX4ar/oAcHwVwFJTlV1Oef55kY?=
 =?iso-8859-1?Q?QajZwvq0z993fYbFh9Z1vs0jYAFJQC+rFqMEXjomu0GfSSU5Bbm5vevrBV?=
 =?iso-8859-1?Q?1HjozpHO3M5c+aNHWDGP56JxEfQo2XVppnzkKgJM2lMQLa6fXZxyeGze1c?=
 =?iso-8859-1?Q?PmY03AW2dLfmAU3q4xlDXgCkbeUBoX4u8Mc3E5nhiF1Xj5Su6dSZLo0mXz?=
 =?iso-8859-1?Q?Yyq29Q5Z3dItXmvsktzsWurJc4PjDsVjtWgbIPQH1aQ1yc8knZHtD9ZYar?=
 =?iso-8859-1?Q?URUzyvrbi0OSIzoR6Lpv8oWdK7Le0ZbcqALBjPerouwvCYBs3roU1m12R6?=
 =?iso-8859-1?Q?v8M4OxYxqtelS83d751u0T+yAlp8tYfrGssVucTkgaRKx9j5N3D8p9D9Io?=
 =?iso-8859-1?Q?9P49Q0iqfzGjXe/hBSFSsmEpN9WYokKQuVce1tkQcM+wtx+nFG6yHQWv0f?=
 =?iso-8859-1?Q?eqwZrIGPKlWqYbrd+lyu8d0pHwK8aalQ/uQqyDF08p9Q7xuf3aKFWRAmrb?=
 =?iso-8859-1?Q?9YNdflVnhAZKpbNLLn3AQG+ryHq4GvBWmmrxRfFLikeWRYwDex3fK9En+K?=
 =?iso-8859-1?Q?znAR2dCTmsbFF9I+Wpq06ccar40e/YEuJKYOTHUpoGR4my/SRcCaLIQDrA?=
 =?iso-8859-1?Q?F4oU+/yz09dpDFMJ2J7hCCnzrDFtzLCn0d2rDgtFXubRizMa4CMltHgg8D?=
 =?iso-8859-1?Q?c5pDOLoRK9E2l/E2e9U=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: withsecure.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS2P195MB2251.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 476b5692-0a15-4d98-3314-08dbba7cefc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 08:29:56.3964 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe5446e9-e058-47eb-bdce-b2cf1972c668
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cI9UHGNWVnrSE4jF92+Zs1H/vEYiAdMxlgVhYidb57oiza6I8CFj6X73c9cU8A3OmJtuLFKtMV2KuRB1qDCZ1gRoOVcG2NDmsSpR9ORCq/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P195MB1689
X-Mailman-Approved-At: Thu, 21 Sep 2023 13:25:12 +0200
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

From: Andrej Rosano <andrej.rosano@withsecure.com>

Use DM_I2C and DM_SERIAL as it is now mandatory.

Signed-off-by: Andrej Rosano <andrej.rosano@withsecure.com>
---
 configs/usbarmory_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/usbarmory_defconfig b/configs/usbarmory_defconfig
index 66c969f95e..277f055aef 100644
--- a/configs/usbarmory_defconfig
+++ b/configs/usbarmory_defconfig
@@ -29,7 +29,7 @@ CONFIG_ENV_IS_IN_MMC=3Dy
 CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
 CONFIG_USE_HOSTNAME=3Dy
 CONFIG_HOSTNAME=3D"usbarmory"
-CONFIG_SYS_I2C_LEGACY=3Dy
+CONFIG_DM_I2C=3Dy
 CONFIG_SYS_I2C_MXC=3Dy
 CONFIG_FSL_IIM=3Dy
 CONFIG_FSL_ESDHC_IMX=3Dy
@@ -39,6 +39,7 @@ CONFIG_PINCTRL_IMX5=3Dy
 CONFIG_DM_REGULATOR=3Dy
 CONFIG_DM_REGULATOR_FIXED=3Dy
 CONFIG_DM_REGULATOR_GPIO=3Dy
+CONFIG_DM_SERIAL=3Dy
 CONFIG_MXC_UART=3Dy
 CONFIG_USB=3Dy
 CONFIG_USB_EHCI_MX5=3Dy
--=20
2.42.0
