Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6606FC02198
	for <u-boot@archiver.kernel.org>; Fri, 14 Feb 2025 13:11:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7715F80C83;
	Fri, 14 Feb 2025 14:11:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEEA380A55; Fri, 14 Feb 2025 10:41:07 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on20725.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::725])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B971C801CF
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 10:41:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUSgYDhRpX4uxx3tNvZ6HpIyTYnooJ9T8EoYwPTMV2Pn0bHxqZuV9cwYr6DxbVxmyQkPqUyyeaZIjJStMp8fgnRkR7vQRboHZrTyfaDJh7qZ8kKlfnmJyEnmn5gtHVufHlBRalD2rqZiubTa8NADdUxb3uHDj03vDBOeDiKL/CXR34qy2voXY9w6lrFX0BY4948R3+r0/fmbDW2ClqXNHffh78xtciMZY6OeX6UsFNKy8YdGyvi8xytcp872vtMTKPheg1HglPokpKNREuy5sN6qDD34VtfXo/KrfQjYZK07rDBvisfKMZFsySVi4FWoCRrv0G6T8wbybFkx0sK42Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+ZTsud92/CTo8XaSQIWr0iUksYboonNeNqrFO1ykEU=;
 b=FQsCDXv+opk6k3rX5qz8FCePZFWfSpRsNS1LfzDeZqLYC47lQW1ypVMPWaUgt2eKAf0q4mwJaqwWs2GuUFBl1OdwMvYvZ1s8OwrXeakDKmj9TJzc9AMpdYIrhnCZF+gF60YLRwldLB0pfZW8gLggg0E3R0Xp+Neh8yg2aTFs4617u93TFHZUyw2joXf02LU2EKC6NjQTeSoSYp3fKJBwnJ6Y/B+qeltwp7/RdQZq9ghnT4OXFOxibtQfssC5Z5r0HqyGD0RIHKrPj4lWyOdEYTWYBe/5b7popt+FA6NE9MpHkRIDLXMAAeDn1ZG6oU+1KwoeXjtiA2q04we30cDFHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1306.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.14; Fri, 14 Feb
 2025 09:40:57 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%3]) with mapi id 15.20.8398.013; Fri, 14 Feb 2025
 09:40:57 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Minda Chen
 <minda.chen@starfivetech.com>
CC: Sandie Cao <sandie.cao@deepcomputing.io>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, E Shattow <e@freeshell.de>, "E . Shattow"
 <lucent@gmail.com>, Sumit Garg <sumit.garg@linaro.org>, "Leon M .
 Busch-George" <leon@georgemail.eu>, H Bell <dmoo_dv@protonmail.com>, Lukas
 Funke <lukas.funke@weidmueller.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Matthias Brugger <mbrugger@suse.com>, Simon
 Glass <sjg@chromium.org>, Andreas Schwab <schwab@suse.de>, Nam Cao
 <namcao@linutronix.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH 1/6] configs: add jh7110-deepcomputing-fml13v01 to VF2
 defconfig
Thread-Topic: [PATCH 1/6] configs: add jh7110-deepcomputing-fml13v01 to VF2
 defconfig
Thread-Index: AQHbeYUN28QcINb1C064QxT4bOV2f7NGlLeQ
Date: Fri, 14 Feb 2025 09:40:57 +0000
Message-ID: <ZQ2PR01MB13079449B52324FFC4B401F8E6FEA@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20250207172116.117749-1-heinrich.schuchardt@canonical.com>
 <20250207172116.117749-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250207172116.117749-2-heinrich.schuchardt@canonical.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1306:EE_
x-ms-office365-filtering-correlation-id: 51aee325-636f-4808-9ebf-08dd4cdbaecb
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|41320700013|7416014|366016|38070700018; 
x-microsoft-antispam-message-info: 5iCAFglsrxixlfP9sKqANS0etZtH4DYkOtKwwbfatZ+OhO1adPnqW2vojw8uFZIdYhawscKp2OzF1L/ClT9q+7veDY7cDKbWrWXoq7cBXJ1tPN+FZ0U6ZuxcCeHahplnt/Tb7VpO2TrGztChdYejApZ3daLozdPnN/mzGlNSb62sOxdRtBu+flWBEqSOK6d0gWf8ncl5SUjLMxl1dJ8Qx3TZvzSXwpAUEF2fLXi9GoTdl1Zwa231Dm9BLZHSvi7B4XoaXNm9PnaD9VFJMWnmOWsHbDJbl4HfLIxahvKb55cw4VqG0DJ1EnkmNBfKSQu9uc3rc+MCpFm1jxtFaHzGM5Ka7jVcWiNqn3esaryMZicACtx88o6h74Y5axqPOLqtv+xLK1cwb0OiF13Em3TCUV0XvJy5iYME71HI/VCbGJv2YErFS0Cs93DX+vTrnZrkJO4VYUNywLC0mcc3jHn7opzGiqiulF+dIm2jG9uBivXwpCqm2qUA8+ngOYpWjziLRQC6kvGMH1nW6oqfiiwiT+iLCJjiLUgSoQxrnCaLKtNfiamnM5GFUnoMSLhwd32werfYVaEFkPq9NL+YTvbmow==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(41320700013)(7416014)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cEVBmKENulhrk9djXUW6mfh5kko5yr3v2hB++evC7DmUsNkwTqXrJq7nEawa?=
 =?us-ascii?Q?60Q2KX8Gai3W3R/92GaWv+kwXQq0c/JTUM82g9mJxA4EsZEzrBLLQfi55FMl?=
 =?us-ascii?Q?/VCW68nRNOwt9T6rfZaXP6XnJ97Wi+VHCVRPyVzfriNduVVR4ppz5iCB4X+p?=
 =?us-ascii?Q?ofSbc6r7HnPXG7YEdGdtEsvWXcYK1OOuBfRUYsy45/i/T+muofp5/an000ND?=
 =?us-ascii?Q?x6+xidqZfSa3MIrmL6Nrdy2bB5JaBiaMoJsrfNsbZQk60Ha/9IrAqHqmw/PI?=
 =?us-ascii?Q?w0uFJIgqEcvHaVo+FKKH5WLnmi6LYH2RbDklp1F88EMKu8HRoE3TutVZn0B8?=
 =?us-ascii?Q?e1rd/4cpQ9fq7Hsg2l2V6YQT+v8TV+rbR1F9Z3ZsIjbiNW/hNaGwLVbjsMty?=
 =?us-ascii?Q?IiLUcWfoGsNnmUsgj2q9tYNI3cXWx9fPc1IcewMS6Yz+5U6ffZChxe639lzp?=
 =?us-ascii?Q?Q7mi158DYVhJhwMe+woIkFtgGXcaCiUpuynLYk5cBntOHznCdFaOkh0FEVte?=
 =?us-ascii?Q?Lv9VaqIGwPsqjQ5GKXNQPXkF4gl9nKUimdWkQSFpXlTqBrunvJ/ivebbyogZ?=
 =?us-ascii?Q?KVJoQL6Oiv8UjNxPlYlPKzCzlI1KgfHUuqKC4O9pzZPSRb2ggQbKjgybQC+U?=
 =?us-ascii?Q?aoOVvsud4zlQmZg8TOWjxGkVzCRgswJ0aIpuHS8YScugwwpP7aU0j4ADO5Qe?=
 =?us-ascii?Q?tAipXBTdMkAhgGaXZT53fcW3VdGw/qk9OxNKdVFUZk1o2ZkyjSnvC/GTCDPt?=
 =?us-ascii?Q?et6oeG9O9RJW0pz5KX3oeHEBOHEOcmmKuBMU3MmdRWNEZq1Rfu2BYJbJMBLV?=
 =?us-ascii?Q?6RzUILVgkErj0zOAk4mrk2dfnVtN9H8WU4KVRjx0ECnzvKJxnKtoyCy17xB1?=
 =?us-ascii?Q?hHYSCBSY449pF8wzr2u9D1hk/2K5BwYtfzSTXCddB8x/5RJwx6ZbBHgWjgcc?=
 =?us-ascii?Q?o4Q/AJautSA8QWoj5vlX9LNg9JSvIO5kDUtNW6q4s5i27zCz2TwIsKIGuWql?=
 =?us-ascii?Q?DKpoDlnRtkkNf8kqvfcZ5MzwZVjHaiLOW+k6R2PGllhe09xGp0e4ViqU9Za9?=
 =?us-ascii?Q?FBmRTKAuz0V+zZEab/+R5H1qURDKiNjYMMYK0DhcY6XXLVHeBt28XNSmw7Jh?=
 =?us-ascii?Q?A5v8CxoSS5+D7DyUz8ACDnvQceUNvygSH7BvmvUGb6p5RaCde8BhWEHo8rOv?=
 =?us-ascii?Q?+r3SwoCQK3/QJlgqPF6D12keHIwl+m4kVVou/07GkGr40IVM/oyGsksfCllR?=
 =?us-ascii?Q?LNJ+S+nst0uY/p9DbMGbZZPKbrSF/jRDkp/ccSZBXs5yBJwACho7VmpnG6P2?=
 =?us-ascii?Q?AxyfRqp6gaovyMazg0XozizxsoIQdZuHs1rPjzNgK1YLOU8ym0SWf0fFtRL6?=
 =?us-ascii?Q?NsbkLe7njq6185zjl/jzhbA77yKC4fybjVmD3ihfMwmT4W+I4JfrZU7F4Lcm?=
 =?us-ascii?Q?Celu73NbXsEL2VnaK6lWtCFxi01ssnnnL23gICe3kJpP9TCsidL78J7HvH1j?=
 =?us-ascii?Q?MakDSwZpRys0U8DfkCYfX4uzRXnr/sqMrXn0KT/SEF7vwQhAxMRJtbySuO4+?=
 =?us-ascii?Q?0i1yN6YR65vIcrX97hxGBj2QcilAEOlAuwbsI/Z5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 51aee325-636f-4808-9ebf-08dd4cdbaecb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 09:40:57.0389 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1riMVBFljr+up0ehcThS7t5KC51aSqcaqiHN78EGfjLr3O+4IhPK4Jpuq45zESG4ebpEv7j3bKV6cQbc7FW+6cCUBbGOdDjJMaArDT7vojI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1306
X-Mailman-Approved-At: Fri, 14 Feb 2025 14:11:32 +0100
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

> On 08.02.25 01:21, Heinrich Schuchardt wrote:
> The DeepComputing Framework motherboard is a JH7110 device support by
> the upstream kernel. Add its device-tree to the list of device-trees to b=
e
> included into the starfive_visionfive_defconfig.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  configs/starfive_visionfive2_defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/configs/starfive_visionfive2_defconfig
> b/configs/starfive_visionfive2_defconfig
> index c3f2142ae1b..821aea9c236 100644
> --- a/configs/starfive_visionfive2_defconfig
> +++ b/configs/starfive_visionfive2_defconfig
> @@ -78,7 +78,7 @@ CONFIG_CMD_WDT=3Dy
>  CONFIG_CMD_TFTPPUT=3Dy
>  CONFIG_CMD_BOOTSTAGE=3Dy
>  CONFIG_OF_BOARD=3Dy
> -CONFIG_OF_LIST=3D"starfive/jh7110-milkv-mars starfive/jh7110-pine64-
> star64 starfive/jh7110-starfive-visionfive-2-v1.2a starfive/jh7110-starfi=
ve-
> visionfive-2-v1.3b"
> +CONFIG_OF_LIST=3D"starfive/jh7110-deepcomputing-fml13v01
> starfive/jh7110-milkv-mars starfive/jh7110-pine64-star64 starfive/jh7110-
> starfive-visionfive-2-v1.2a starfive/jh7110-starfive-visionfive-2-v1.3b"
>  CONFIG_MULTI_DTB_FIT=3Dy
>  CONFIG_ENV_OVERWRITE=3Dy
>  CONFIG_ENV_IS_IN_SPI_FLASH=3Dy

Reviewed-by: Hal Feng <hal.feng@starfivetech.com>

Best regards,
Hal
