Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F39C0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 16:07:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE7CA82116;
	Thu, 30 Jan 2025 17:06:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=dronetag.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=dronetag.com header.i=@dronetag.com header.b="kNkXyEO3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D680980E90; Thu, 30 Jan 2025 16:44:16 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2070b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::70b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A278080B9B
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 16:44:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=dronetag.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tomas.peterka@dronetag.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=klpeZuObCy1UF5WuxY9sWPBDt5Oeip3C6Ir+Ly9Xm0KQHwVWfo0s266T0SfUqfBE7zcSyCPByJ9M1plU8nXRIoJYFGPgGeSx9GgaJPo1J71z1UvwoPF0X8eTFO8YKkmkMOw50tXsk+s10oUekmd4+orCPN+a8zCjNiEzoSjUgVfdl+Pww68xV8z+Y12zsq1JVij9OJ2LfwUT96EHGBIBQXBAgANiNRvjjM4LaqtBrE9SOI88eUM5nevdErHvPN9F9yniL20mPB2gqiKYdBrooXQ2DvO25ZL267yEDlrZarToKadS9wruC8AAxM/t7XFGS+PhzN8u+rtnfkhLhkXyvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDmv4SZCg6zfge00TrTVsZ1y9OPK3B1fI+bz2Oh0nYw=;
 b=q969ws+OzTEif18aJ/2iUtSOLgHrhpgVT5radxifh2aZuWs1s3Kiq2aw5BMP4zQEgvhQMGz78tcncVN6IGe6xRNX7r4+IZY3TMHPQTlpa/H8w5WHZE7cesdnejxDNIQ0FYQ+zRDnHb+geQKN+4uW4YS87Z1TnczU21Q9plb5okRMGL/UWPRnB2MCTFMeMxucEx15X0KdoU/WGnBgoawpmR4rf1n4Nx3YF/gBCGHcwG9RtCS4dQuJUuuGl9A27TGKZedRVtOSVunALx1OZT9CwcP55Uo4+I6pC+xtljxmqQul2TB/f+OluMDft2vDMc9hzEbeojGkentPG3oUQyoaTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dronetag.com; dmarc=pass action=none header.from=dronetag.com;
 dkim=pass header.d=dronetag.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dronetag.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDmv4SZCg6zfge00TrTVsZ1y9OPK3B1fI+bz2Oh0nYw=;
 b=kNkXyEO3lIR94aor9p3raGQdj8LjFe6sTPTXL3RZN5FUBEot3za5Hyn1HbX6Wigm9PfD1mluQmrQkFXrg/YLLzu2fIa+yryudub39S7v9K632ME6dHlhgldsK3/CrzDg2IkUU4+BNNzOLeMfyNtbJIkMoAuirNKh0lfdDrgv+hqXMyraquXezDefEuanWyaeSwABLMyGiUjEnZ3FMlaqafjBddJ3ATaJ4SLB2X3GxCfdgmoSanDw9dteT7DOQvxxSZB7iJmzfDRmaA0gGrTF9IOlQjZLUri1ujwDo7cXOfHfVR1S2f8zuG2hDfk4klH0YdYY4gpwJclVUeQu8AAKaw==
Received: from DB8P192MB0743.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:16e::22)
 by DB9P192MB1804.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:39b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Thu, 30 Jan
 2025 15:44:11 +0000
Received: from DB8P192MB0743.EURP192.PROD.OUTLOOK.COM
 ([fe80::6829:18a5:6e10:c601]) by DB8P192MB0743.EURP192.PROD.OUTLOOK.COM
 ([fe80::6829:18a5:6e10:c601%7]) with mapi id 15.20.8398.017; Thu, 30 Jan 2025
 15:44:11 +0000
From: =?Windows-1252?Q?Tom=E1=9A_Peterka?= <tomas.peterka@dronetag.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: =?Windows-1252?Q?Tom=E1=9A_Bene=9A?= <tomas@dronetag.com>
Subject: [PATCH] Add Kconfig option for altbootcmd when using
 CONFIG_BOOTCOUNT_LIMIT
Thread-Topic: [PATCH] Add Kconfig option for altbootcmd when using
 CONFIG_BOOTCOUNT_LIMIT
Thread-Index: AQHbcytyFZq1DXMpLUGSNQRnnNGSEQ==
Date: Thu, 30 Jan 2025 15:44:11 +0000
Message-ID: <DB8P192MB0743F697B33A404BBC96460383E92@DB8P192MB0743.EURP192.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dronetag.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8P192MB0743:EE_|DB9P192MB1804:EE_
x-ms-office365-filtering-correlation-id: 5e1db85c-c3f8-43f4-b62c-08dd4144f12b
x-ld-processed: 22487ee6-dcf2-428e-9245-e760401ebd0a,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?Windows-1252?Q?sk1P3FYoibRxhPW2EEuUHH2/aLA7clnlEst4Ov9d95MIZEHeRvIiL8sN?=
 =?Windows-1252?Q?Dhj4S03Rvt0n41qNo7unaCYxyy5jMmhFbIxzM5atYsY3yJ+WsSe53nm4?=
 =?Windows-1252?Q?com17PBJMlGSgfpAhcv/jBitBC2wPYd+rw4CbPW13emFbI6W1GEl9Tkn?=
 =?Windows-1252?Q?HqSN6tUBYuW8cJSMoBrH1wkx/vqqG+LHYy6Fvf10kQ5tKS2ZpAD1lS+A?=
 =?Windows-1252?Q?73KxtT6oh8nsnM8Wiq69A/rCbN26ERt+fKD1NSVrgOmNNQWMo6++/uOr?=
 =?Windows-1252?Q?JtLuzIlTAkyFOgluFOMS6v0bd5vrgIdAsP0Q/RlB1OiDlzTxARTyXZ1z?=
 =?Windows-1252?Q?xHEVIP3jqwEVPSm6K+nqb3aVrBw1llz6OflfhVT/m6btuVJ6Q8Y6DLTc?=
 =?Windows-1252?Q?CyLARv/iP9cghyuT9L7biHLoFJkl8BlCwuwlphd8I5qxOqyXccr6uXdv?=
 =?Windows-1252?Q?fnjYEbvo3/P4cXT5Hi9mvI2KXGEPj1UcXcSzdiBB/ES4RrdP7Vj1VScx?=
 =?Windows-1252?Q?z5QSfcSfcmcBzCwoyxs0SElj7ilFbS0kjivpjEJTw2+6Aas6W+jJfmZN?=
 =?Windows-1252?Q?fiXWhk6qZyZtCRShuJ25Q7ZhH8VFwWYD/mnQ//5yGtXRTAmAvQre7KmL?=
 =?Windows-1252?Q?XWNneg8BV+3GTZlW4Xgi56gnYQ08rbWBs0AdWjJ/QUseMrTwyhv1sQOM?=
 =?Windows-1252?Q?rhRcoDqPY6+gpyzDpU1FHR5hPGQH9dA9qpVwTd9owdvYw/Lum1YSThIR?=
 =?Windows-1252?Q?Fn7y/7+2B00finpkoe0uXxUU/1ltAB1Y6HrEVzuNQwooobm4gt/EuhAV?=
 =?Windows-1252?Q?z80+Cw3eso06j+c7do6w8PhvufeQkPwPV1j9FHrrWYBjctmXuOOO5Yjn?=
 =?Windows-1252?Q?5ObsoGou1PZJAsvKiligF66jRFMGDInKxl+s30qRNI4C9ZwWgAfrPGnA?=
 =?Windows-1252?Q?TfS0zW8r59OQUhlnJWAmVpRCDA2F3O9lgRAd4RHJnZhy7xGnDsBYUShn?=
 =?Windows-1252?Q?ZTeSH1S4vH8poo8XhQaSDeOIWLH2LzeNyhZ87j7chg2brC0rQ3lp/cv4?=
 =?Windows-1252?Q?+HEUAdY5r1r3rk94f4XYXuMitUgOd3W8oWJ4IzJG2zPaE7oFpa4HEjHZ?=
 =?Windows-1252?Q?PYiYJ35ShminRSTc3PwwhpY5JWlUetfyknXsL7uE7gPJeWrL3snnZhs+?=
 =?Windows-1252?Q?Ie1G6QnJsmh/7oKQM0LBPnkypgkwYVIr8W4yoFJrqz0trVMwFaA+7UdD?=
 =?Windows-1252?Q?hlduKR0vRRLuZc9AZYHMOX2Jk10kkL0t1MUCgMjbnIazkif2IVK3ZrMd?=
 =?Windows-1252?Q?jKAVYNF9TmtTw8x9cqKpXf9MhiUMPesRyPt7YL6zDf2qxuJu254xi00T?=
 =?Windows-1252?Q?0mY+oF7oP7tPExcrjTICbCPP0n4W57K1yrc3FfZFFU97302DqVYWN0Zn?=
 =?Windows-1252?Q?LEL/fJbUWQ6tmFombLiAVIRB6iUqg5gHsuM3t49/smDIVtnfBXugYBnY?=
 =?Windows-1252?Q?aS5gOGdwrmPRBhARKOnyknXl2dUWhmbIqSS9jYcr8boROLbrANrgJFX4?=
 =?Windows-1252?Q?UMAFqNHPxcFDcjYU?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8P192MB0743.EURP192.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?WrXkXUXuFMOVk5ght2J+X0agm0MLOguH5hhueWo9HsxSfifGrh/I+rPo?=
 =?Windows-1252?Q?MTrDUe0dMym6ND4It9s4EKWtp5VKIepoUZ/h3u903ghLNGJFDeAX39U/?=
 =?Windows-1252?Q?Lo3ItiZy8kUT11lji0g+t7G4PfGX/rttP4H81LptbHXnoLBn7GnoRH9c?=
 =?Windows-1252?Q?UdWHP8xXNUd5uri5YwEvtMBHTO6wiCiGrGIgVyPnXiEPloM0FVNEzRTt?=
 =?Windows-1252?Q?8fRhEplLUc1DLS7ji0icUkfBCgGd0k/CUkRXsN3lsGrZaJIeYfcTDUoB?=
 =?Windows-1252?Q?vXnf3AhFbjiRTSg9SxrCuCA5cKlSPCKE6mlvnnbolHaZgwUkmaoY1WxV?=
 =?Windows-1252?Q?fQrwCvyvs55N9IROe1/IB79FfvhvUx2RYKkWJYBpEggK4+aozAc0WL4y?=
 =?Windows-1252?Q?Jdly75BdGV17GhMQQPRIe32hhEtFV2Y4IcRSki4XHquFM9jffwt4DL/C?=
 =?Windows-1252?Q?Eic1tlUBo4JGX6zz7XSxpO4hj2Ey2kOeOOE8hhgdjAWY8M8EhZWEqhyK?=
 =?Windows-1252?Q?cj/XlaskBkxHpd3wf2MYU5tgGKlt0U47moFwIOfWIvzANBAn/8VBRmdq?=
 =?Windows-1252?Q?K3p6RCQ3gha1MU18GDZEXomVJx2VaFrPXqtHBQoF0vKTNE4B6SkVrjPu?=
 =?Windows-1252?Q?6YSqITX2w5hFXCuz6b2QxzOsVwN83AGh2SAKo+0CBQuby9sZUUPpnKlW?=
 =?Windows-1252?Q?fs6/k6R1bR3jYYTAmcHYU87a2u4+FV+8RI6VzTGdQJi+9qC8s5SjtWhd?=
 =?Windows-1252?Q?v9Sjpxif6hS6DvZhwEHbmY5ipv3z/cblsj7TQSDLAf9E20W2+Pz1kR21?=
 =?Windows-1252?Q?1y1HU3ajARsiFnCdAmRb3zoJPMpW5o47LlKYvd1olKiQiEfE5nRUVBri?=
 =?Windows-1252?Q?peOWHE8/dMs09HDCldyqODchnUG3wJ/Lz6WHJ2/h0AOVUQ0DiOwp31h9?=
 =?Windows-1252?Q?MEFKahlkQyuhQOMqNQg8g/Kc/nNBnHZbAs3G0noB9/WGSqwmV5xk2bmy?=
 =?Windows-1252?Q?qDDkzrsnFqTK3UAbtYrW+w/GACjHAeYpxVs1Ng0U8Wfxg0O9DamhANjw?=
 =?Windows-1252?Q?uhPyaB5GyG8Nnzz5dr0xKY43D4bbUnt4EFUS1pLXEhU0/aUg/AU00ZfK?=
 =?Windows-1252?Q?ArciaNe6Oqfl/mW/ZnLd2MzkLHYrhdjsJGATy+xWKYxe3Ty5crwSxSeD?=
 =?Windows-1252?Q?shwFIGrBikqapQU6burdbEQex7EynxEsnMqWjvZvGFZSVUd1v3dBAkob?=
 =?Windows-1252?Q?326GKd9ZTTlQ4kuv8nCfbTJaEY4tu6x+FaBUs2+i7Gq6wjXZBb8tqzB4?=
 =?Windows-1252?Q?ZpagZjKCYcGUGHdYsyi/k4TBxDE8YCNe+AU0t0IV+1SA5nI5OmW7psyZ?=
 =?Windows-1252?Q?RlgjO4QPVRk5+zH8Ghrl39ro6J97q09/AzW/OPuEtk8gAg9zbc7ic9sb?=
 =?Windows-1252?Q?PheGkoheOtZfR6s3qNGyrW8RSdQb3d7vCmGfUbrS+DJMXasaDlBXMk4R?=
 =?Windows-1252?Q?gI2MB6030/F19JcOoBmjDyTSyRjcGavNll/sevC/vU9dxmnTgBoezs/G?=
 =?Windows-1252?Q?q9QPekXGrTZkNwvXfcGFyYPF02NGT2s+E2w3Lq2r99vNsFQttb+FQDHn?=
 =?Windows-1252?Q?hQ5C9V6D0+avM99OF1VFFCIpm8IjXr1aewPkmT/w6zt7YzsbdbvBf1IC?=
 =?Windows-1252?Q?BoX+dtO7oFXew6YZI16115aYrKEal6FO?=
MIME-Version: 1.0
X-OriginatorOrg: dronetag.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8P192MB0743.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1db85c-c3f8-43f4-b62c-08dd4144f12b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2025 15:44:11.6015 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 22487ee6-dcf2-428e-9245-e760401ebd0a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZSUhTZFtlPt79JVSepgWQseK2mKEBeMyg/Y7vwO+PlEm6cl5noL/lBW0GeBCjJARn91DY+8we9j7B1Fho894hQ7gdZDciikf+O4ZLaNNPWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P192MB1804
X-Mailman-Approved-At: Thu, 30 Jan 2025 17:06:58 +0100
Content-Type: text/plain; charset="Windows-1252"
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

Hello u-boot maintainers,

I would like to merge a simple patch for user-friendliness when configuring=
 u-boot with Yocto. The problem is missing option for altbootcmd when using=
 the feature CONFIG_BOOTCOUNT_LIMIT.  Simply adding the option CONFIG_BOOTC=
OUNT_ALTBOOTCMD into Kconfig shouldn't be a problem when there is already C=
ONFIG_BOOTCOMMAND? Users then can use CONFIG_BOOTCOUNT_ALTBOOTCMD instead o=
f misusing CFG_EXTRA_ENV_SETTINGS (and friends) that are usually used by co=
nfigs of specific boards.

Many thanks for considering this,
Tomas


From 9f5d1863e99c3a33893381cc924f25797b4b6f8a Wed Jan 29 19:06:55 2025 -060=
0
From: Tomas Peterka <tomas.peterka@dronetag.com>
Date: Tue, 30 Jan 2025 09:00:00 +0100
Subject: [PATCH] Add altbootcmd to Kconfig
Upstream-Status: Pending
---
diff --git a/drivers/bootcount/Kconfig b/drivers/bootcount/Kconfig
index 0080d2a165..982ddc9826 100644
--- a/drivers/bootcount/Kconfig
+++ b/drivers/bootcount/Kconfig
@@ -183,6 +183,12 @@ config BOOTCOUNT_BOOTLIMIT
counter being cleared.
If set to 0, do not set a boot limit in the environment.

+config BOOTCOUNT_ALTBOOTCMD
+ string "Alternative boot command when BOOTLIMIT is reached"
+ default "env set bootfile altboot.scr; bootflow scan -lb"
+ help
+ Set the alternative boot command once BOOTLIMIT is reached
+
config SYS_BOOTCOUNT_SINGLEWORD
bool "Use single word to pack boot count and magic value"
depends on BOOTCOUNT_GENERIC
diff --git a/include/env_default.h b/include/env_default.h
index aa3dd40f3f..59bb0f6a6a 100644
--- a/include/env_default.h
+++ b/include/env_default.h
@@ -115,6 +115,9 @@ const char default_environment[] =3D {
#if defined(CONFIG_BOOTCOUNT_BOOTLIMIT) && (CONFIG_BOOTCOUNT_BOOTLIMIT > 0)
"bootlimit=3D" __stringify(CONFIG_BOOTCOUNT_BOOTLIMIT)"\0"
#endif
+#ifdef CONFIG_BOOTCOUNT_ALTBOOTCMD
+ "altbootcmd=3D" CONFIG_BOOTCOUNT_ALTBOOTCMD "\0"
+#endif
#ifdef CONFIG_MTDIDS_DEFAULT
"mtdids=3D" CONFIG_MTDIDS_DEFAULT "\0"
#endif


