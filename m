Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C37C02194
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 13:18:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3989680BA5;
	Wed,  5 Feb 2025 14:15:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="Imx6aHGQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4571D807F1; Wed,  5 Feb 2025 11:15:56 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::630])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A00FF805E7
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 11:15:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Oleksii_Moisieiev@epam.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xlBqFwd5gcAla7kvNkwTB6LECsfnh7kBz32buMlNpuXKrUA9PO7+Ibqhf+il0ZYW6sqk6QUz6hK+tRAQfyxkS4zwM253zsY9U45jpUR16aMEXj1YAE/6N8ztf5xuio3o54Yc2aA1TwisFbcI9KV3lWD6yCiogTj2m+0p1HqvH5n9mgIJf7RDH8U4Pd1hqf4jgdwwDdmntCv8VZTAtjHHe8N/ltiErNLgAdxMsXs7F2AmgKbhzzG5F6FeZ8u0ZYlbIYLeTfwGMf7h5lAbYtwUnQN/O4ltTo7EV0jJXeIN+WAyAUzRnXLloNaPWIRL+T7AU6XYpbsqUhsA3O83wbvWiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ndRS0/yBQYeoamA+Kl2thDafqfQHLbmXlTNOaXPTF0=;
 b=SZmi85f3WMGuEj9nRxH2yuhLTBiFHg91rHTxMod4TsqugDchao9xuvJAaCOxLltTMFwzQYXywuXrUziTukFjZ/c0ICNVkMr49vjRYiRt5xDWb0nl6a2Sl8R3m16B2EMbSGX9Fa4rSKrYK7cfnTvW2lcdlFlCb0jV37/3MDAEVSJy/prCC0Fr6vRb+PQKrhniynJtEU/iDC3G+WZ54JzAZfiHc7reoh4OSSevy51shTkEjJ5knHpRHwPsiVprs9ZtVwikatOD8fQFCwdz1rnyJY/Qje8eDlPwwIsMRXfSc4DIxEzaASgwaUwf2Ej6Q8ogMArgg7KO68gVyeuJtkRvhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ndRS0/yBQYeoamA+Kl2thDafqfQHLbmXlTNOaXPTF0=;
 b=Imx6aHGQU/cBYW0eOkaEbS4g72OR+GZ2M+aYYvp/3/txrnL7WOZqZy+UXQoDGDsgvkxjkmkmUj7vvJyN4HwUz+iSuCGyseVypTnDnclBG/1u29DrggBy67aewCxFPcykPTxVqrtf4mEUeeiOfV6prVTBdfAvKbszpILkRirzFwjIB+QeGOY2qQ7q6M4VBbWPL72b/JtMVZ5rXVbcRI2yxBI1qqjcNEnaike8TABBjEsF3U1gtVlEGcl0KpcvNGZx0mTmWTbs5Wl36Zq8zzWBSBXCGRExurC5iqYop92HwKDZrVc8ZDm0DJccx84ZUYIeZCxUjMU5Ig04ESG23+Ky1A==
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com (2603:10a6:102:32e::21)
 by AS2PR03MB9879.eurprd03.prod.outlook.com (2603:10a6:20b:547::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 10:15:52 +0000
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc]) by PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc%6]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 10:15:52 +0000
From: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, Tom Rini
 <trini@konsulko.com>, Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Subject: [RFC PATCH v1 17/20] HACK: drivers: mfd: set bar configuration for
 RP1 driver
Thread-Topic: [RFC PATCH v1 17/20] HACK: drivers: mfd: set bar configuration
 for RP1 driver
Thread-Index: AQHbd7bsjbYZO/pyn0CLV0NURhGPrw==
Date: Wed, 5 Feb 2025 10:15:47 +0000
Message-ID: <e51ca0d2216802d2da21163a41ff72ae08e1772a.1738749764.git.oleksii_moisieiev@epam.com>
References: <cover.1738749764.git.oleksii_moisieiev@epam.com>
In-Reply-To: <cover.1738749764.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epam.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAVPR03MB8946:EE_|AS2PR03MB9879:EE_
x-ms-office365-filtering-correlation-id: c1a1d5ca-37ae-49de-df25-08dd45ce11c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?kGhRyF05ReizGubXdD3WSXfvqebvBBnnExRwYtw9+gXKnC2/WwgOA7/X4Q?=
 =?iso-8859-1?Q?moHyTN16AZkMqqzmWwt2JmrRpAxuDZ7s24bwuoG9m3gW+2Exk7eXWE0UBF?=
 =?iso-8859-1?Q?9slcKg4oU/2VdWEvbXCsihhhKg+7fjDEk1wcl59BNPvAEgFnAQroxElsyS?=
 =?iso-8859-1?Q?YusXi2e5XzSQ1nH7v0xELCSpz1vGcIZGlr45b6p4GPXvBFLLQVI0EzZvWi?=
 =?iso-8859-1?Q?GTANlkrGqR0FTELBHsOtbHc+0qZ03+PFnksK78jfW8V1H1ZFNlxgv/e2/+?=
 =?iso-8859-1?Q?cuPE+v2hwoWXjl5tzbV7Fqmov0BJ8iVC6/gFyfZgFEpf/zq5vkokrBsoTO?=
 =?iso-8859-1?Q?Tfmw+WCYYwaC5P/8RYVNBHuZbyT4Hmt4+XH7xCsl1fZBZCK53jVJ34IM/K?=
 =?iso-8859-1?Q?ardUk/Vul+ewcYHPuIxJ/vn24V3sP7ku2dXYESgCz8Bf3J90ZK9fJVEGMt?=
 =?iso-8859-1?Q?QY048Y3/ymw2TSX5YoSvA5HqASa/u+wb+PeVARf78Wg6cwypSvV/xQdDqm?=
 =?iso-8859-1?Q?K4jvg9Ws+iyy4NBAb4Yz4piIV5Qh//LWX+EZxJ0rHd3/WTkx//8ZMOOVnj?=
 =?iso-8859-1?Q?YE28B+hwGhtEIfgmlMDfIffJC5coetv2p6gwAIk+zFJaAwQ8DMLOtzQsyc?=
 =?iso-8859-1?Q?m2jYuwvVaeaOmUypVbzAfE5mIZsLG1HMnrZJGKA7sdfNWcr9A7UVT2VV5G?=
 =?iso-8859-1?Q?5wUM66RmP/d8BlEqsDqgEgQLBruQBTDouD697AucnVcp3AJfx1C9ZQT1gP?=
 =?iso-8859-1?Q?kD0FhOaNlCWIa4zCFAxlelKPmMxU5uJ3du2MZzITOuyn37eg0YOvYHYBJF?=
 =?iso-8859-1?Q?xZQw/ZfgDcEyLw1V+li3t1HsaCle/yVniw4uR9a/wU1CzoH4y5wIRPRe85?=
 =?iso-8859-1?Q?RLs5kR7GL8Dl92O0LBgmMp5y07aAKDviNH1mu22XJaIFqVmpe7rWCUxTIv?=
 =?iso-8859-1?Q?CXMQf9cJC+t3U+K39lMl1je0ESpvysN2AXxB+NIUvjCyjcYJti27+SDAuQ?=
 =?iso-8859-1?Q?jiJFsz8hOs6VRnAGZpUavli2twLFZ5Px7hOGbrElnWxb+5ggNDztzh8V9U?=
 =?iso-8859-1?Q?Au/QpulZVNsQEvKCgq3KVzyPBtgCMVQf3e5cfuaaFx3jYklhPTUYxbHGao?=
 =?iso-8859-1?Q?8wY3cQaL1wmVm5YKITFyqyNxBw+DuZZhA64uGh03rLW6UZXkCfsPgMVmjG?=
 =?iso-8859-1?Q?xAzm80e7LnjV9buZ11+ljM1HzlQ82NrZF2mlRE9vctqaMpz/5Yi3RfkOMY?=
 =?iso-8859-1?Q?kOZRc8dHIYGa+Hf8KFqCfvxBojE7MteaZb/fQ4xj3MPidGkqEVFCYaUH4p?=
 =?iso-8859-1?Q?VZ3OQqbPhxdqzo476JRpOlhc8uBSmdu61Q9nUYruHOzSaq3RObosCZ6JaG?=
 =?iso-8859-1?Q?sUVBtYcJBILXKsjV0TTKZxOoaKkgp1whHZOkWPYYcvOlGooCps/itigCzj?=
 =?iso-8859-1?Q?TsZHMxHkvIxEXLEwP5PhavmQmK168lrTc9wTH3ZDipHffnJ5pkefx1gdoP?=
 =?iso-8859-1?Q?8Br7YJdDjZfKZ7KCDXlMNg?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAVPR03MB8946.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UPu/5t5BnoIVtOWzKwGPa7NkmdyTL1k8o6B70G7imcCZG7pemd5PkiJcBR?=
 =?iso-8859-1?Q?h1GbEQDxSlObVhoJcjbd+8Jq3lIiazPr6qg9os5hbB2j1jDL3aqBannNwa?=
 =?iso-8859-1?Q?jYPHCMhLvAjS7FG3aCLlzTw1HW5Fml0W6wph9ozCAJR5Olf7g2ary7SUZc?=
 =?iso-8859-1?Q?0+a8AF1eVarZNrSXI8+wQ91bg/vbWTqh4aSoPLHA92BMLnfWCg4Hmf2dEL?=
 =?iso-8859-1?Q?gxxTaXV1LQdYJJaa/dPTTVjLOpRc1TEGXRnc22HaF5LSoG7OoVr12EaDfc?=
 =?iso-8859-1?Q?LXYZMxqp2vE+VnoCLeqmCZCZ4fkdSMCrL9+Hv5NJ88niVAhDh15LxHfEKI?=
 =?iso-8859-1?Q?UCda4CGI9YnUEJic5vaSt5PVMY83SNk5RYyybn34oRwALoJ3aVGmrz4hye?=
 =?iso-8859-1?Q?KnpO19ed7B7rwj62CwxPnEqtLUVMndNB70o3mduGdhJwTiEghTnK6nzyaD?=
 =?iso-8859-1?Q?nbFmYZOwbq55RwyV6HfyzblxvjW3GlQ2XeApWxrlR8y+U+nwazEGi6gWqL?=
 =?iso-8859-1?Q?zSqTEglYBQL9rQcDlI0M/3QvV8VGmNfnfPW3GUThe+R7qOLevgH2VvvfA4?=
 =?iso-8859-1?Q?dhdl75BnHn2qh1EbcALadIM6j5dxQAaFjl2iJ1bwGz0LuXqmPO4KACUsHn?=
 =?iso-8859-1?Q?YZMRLWWDpYb8WaDcLAYzwlCeMhn+k+qFkL/lkHeeEhTKYH9f2c7tgexfFd?=
 =?iso-8859-1?Q?5ErVOwWXidqXXKZtJjqeZmguLaujPbdxWayiTfNXRXMVoLpVFT4t6qGwDS?=
 =?iso-8859-1?Q?Ns1cGZxjsXGxbhaGQ38Lvi8tJR9FrlrFmWp8tbii40GIdNzfq+8G21X2UB?=
 =?iso-8859-1?Q?C7Ch1GFcOBb/9zIju2ksc2XkYEJMVvSMJdpkG8UTElKuS/cXBIXE1J+6ln?=
 =?iso-8859-1?Q?1XZT+QIFFdbAJnR6x6xBlO+ikUyJtTAQw91boQ3ezd2d3OB71tjC8hUIG7?=
 =?iso-8859-1?Q?FHXBtCtfptPfSENZ2cklEjLAmuTNeBe4FhbqnIyT/drJzDfHU5iS+l1LLj?=
 =?iso-8859-1?Q?/cXT3wA2G9fnkGHIwAvG3njVGV9ka7HjQOog5EDWhAssDOjXJRWbifl8M0?=
 =?iso-8859-1?Q?M4RI2bYODr1LLJBs9dzwIyTKNGjgZDa6VslYaeQmteRUk6TXEUlS3IQse4?=
 =?iso-8859-1?Q?9Q0j8RWliqxL87yjUHlbdNmT5fA0+t2u136VDL1x6NH+5U9LXxr43E3oTC?=
 =?iso-8859-1?Q?fz4vtfgv8A5CQsKqG7EqVR+Nuj95TiZmhJSrxUpDnm6kXmO7LLSkzhUa8P?=
 =?iso-8859-1?Q?A5p0NdxdOcSewqt9hKxeQWjKT2f4+e0NGFzGTDzGqnOhU/Yd0StmYjVeYD?=
 =?iso-8859-1?Q?ORYnPD/qBVGxcb+YuKRKkX0P0+OP5eD1QGkziDtayCFMQdAJr5BWjCQfFf?=
 =?iso-8859-1?Q?0XJMjwG4SRo9NCiK4kP2W+70Es9nE69SZnQZhY3wCf1Y0/mE4CKeZFB4zb?=
 =?iso-8859-1?Q?zF+027CF35d6O9yS/2oDfpxOpV8XfKEqO0pxMtFHzX7DdXF3mwbysdxcmT?=
 =?iso-8859-1?Q?Or3wrAOj2qHfENj34CjnErsagIAWgw7gkUSc7yiI+XWE97YnN39LJg7hkp?=
 =?iso-8859-1?Q?dy2Kk4DSHBLKP7DWbc9vhtBGnrWs47I6aU+QxraUEs15i6nl9UPbxMjc22?=
 =?iso-8859-1?Q?KAbEFYI3UgdyjD/Kp4hSVvQjCFvgFpLddLTUqDO/xv+RdUYt/UqSyXJw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVPR03MB8946.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a1d5ca-37ae-49de-df25-08dd45ce11c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 10:15:47.7771 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: My8FfqYAXqcjlX0ayA8EamRCg5AsqM0wNdUf+rDN1vNuOFFq5RkSGvu4LpI1HWt6UVZhngP41VxNaxVRFU36bUxT+1qWJTsEk+Ao3E6lW40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9879
X-Mailman-Approved-At: Wed, 05 Feb 2025 14:15:26 +0100
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

Set bar address in the correct order. RP1 driver in Linux Kernel rely on
the pci BAR configuration which initializes BARs based on BAR size.
This results the Linux set BARs in the same order on each boot.
U-boot does initialization without any sorting so the configuration
may be different from the Linux kernel.
Here BAR address configuration is set to match the Linux Kernel order
to avoid fails on address translation.
This should be changed after upstreaming RP1 driver to the Linux kernel
mainline.

Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Reviewed-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
---

 drivers/mfd/rp1.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mfd/rp1.c b/drivers/mfd/rp1.c
index 265ed668f5..64008007be 100644
--- a/drivers/mfd/rp1.c
+++ b/drivers/mfd/rp1.c
@@ -63,6 +63,20 @@ static int rp1_probe(struct udevice *dev)
 	/* Turn on bus-mastering */
 	dm_pci_clrset_config16(dev, PCI_COMMAND, 0, PCI_COMMAND_MASTER | PCI_COMM=
AND_MEMORY);
=20
+	/*
+	 * HACK: Set bar address in the correct order. RP1 driver in Linux Kernel=
 rely on
+	 * the pci BAR configuration which initializes BARs based on BAR size.
+	 * This results the Linux set BARs in the same order on each boot.
+	 * U-boot does initialization without any sorting so the configuration
+	 * may be different from the Linux kernel.
+	 * Here BAR address configuration is set to match the Linux Kernel order
+	 * to avoid fails on address translation.
+	 * This should be changed after upstreaming RP1 driver to the Linux kerne=
l
+	 * mainline.
+	 */
+	dm_pci_write_config32(dev, PCI_BASE_ADDRESS_1, 0);
+	dm_pci_write_config32(dev, PCI_BASE_ADDRESS_0, 0x40000);
+
 	ret =3D rp1_get_bar_region(dev, &rp1->bar_start);
 	if (ret)
 		return ret;
--=20
2.34.1
