Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 733EEC02198
	for <u-boot@archiver.kernel.org>; Fri, 14 Feb 2025 13:11:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31C4580EBB;
	Fri, 14 Feb 2025 14:11:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5278580A55; Fri, 14 Feb 2025 10:48:52 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on20723.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::723])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51567801CF
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 10:48:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqySzC9+O2QdFHfN3jww8swhOKtv02BlUATafwjZqYFKiKQPG+e88LSEXafqap6NTNZmcLcGwlYNXTgO5Axy0EfzlhBoIYuhmY54F9q8nYifEV19soeb2neRFtkb17ERJSr7ZIgAJcSeaFGFhZKvSO+dY1JBoYjJYWCCAfEhG3XPiaxpDPmNyxKrul/mpApPZ4SQWK9OpwaZ7OvMTf8s0gFC/I7pypJLNHl5gnrrvwKzAgKlPKgTFFfyGd5ML3fG04PENL/iSWkSmXx/aflBDn0g3nW9fVodhMQAfdbpHaEqJNKpf0zRBkDztVY0korERFPVRNYzeEaz9aMONLC/lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqbNVV4U7YgcvCn3hfhtdTTxjHkmAB+zdFbN1TeURuc=;
 b=VO3U+/XiMG97dOfb7jT3IVeuE/5Os/zwRVxlGdbRwgP05xlyUF5KBzr1kYvCvGLn2yuiuc7UfzZO4DY4VdNevKgviwtxdEhosxcdBima/GwZjufRQc3PgDTht1BEa9pwHOgcamy14qsjJJ01gKbbtDD13x1keWAvLCa53Oh5n7uA0iF8fg9gd0UstyGZwuaqz7k0wCT3q014Dj3ta9LR1HVaj+KQc+eBaI9SiiPhsltPtB+xA1YzhPhroCqpKCGv1zVQPXUnRmzdhiT6jSGCMl9PhUjXgzPSzNyrbvMV2ydT2eOJBUUNgW6ODt5GAQxSwlC0xtZ9nR4FeuZKefZV3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1273.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:10::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.14; Fri, 14 Feb
 2025 09:48:44 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%3]) with mapi id 15.20.8398.013; Fri, 14 Feb 2025
 09:48:44 +0000
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
Subject: RE: [PATCH 4/6] board: starfive: DeepComputing FML13V01 fdt selection
Thread-Topic: [PATCH 4/6] board: starfive: DeepComputing FML13V01 fdt selection
Thread-Index: AQHbeYTb70UTUgwV5EyGaOxlndR3trNGl/gw
Date: Fri, 14 Feb 2025 09:48:44 +0000
Message-ID: <ZQ2PR01MB13070FE4892A09162A2C7D59E6FEA@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20250207172116.117749-1-heinrich.schuchardt@canonical.com>
 <20250207172116.117749-5-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250207172116.117749-5-heinrich.schuchardt@canonical.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1273:EE_
x-ms-office365-filtering-correlation-id: 2dae1127-ef79-4873-10f4-08dd4cdcc5a4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|41320700013|1800799024|7416014|38070700018; 
x-microsoft-antispam-message-info: xXCR2h69eTEdGmXuMcHN0YvrlUaBxw/b5oxEQy/JE8xTnzBoVirlKicyOnflv1hMjIZNWyhZW1d6C5cfRm5TSh2VAvxixjgf/FpPwVs4EJWo6RMKAkTPBasIGLmHR7RJ3G2mOOfZ0m+oZR0owocQsckY6ENuNIwwgMNsP559K/MIp/g95BkthvId7oZtfCORY0Wgj7VJ8Q3zHJ5r2znXzSoz+uuEW4iw+6/GeYer2WE7KNr5lyB3Wyrq+iXEhV5cfeWoJG1EKAmDzNvAZVMQk7Odw5BFx1xyqXKsgkNyfMdC8q9piaoVRlhG/lQW67kpNfq2EUm9UcJ6pqxyl59xK52vWAk4TOiIUkdX+TncHfVbXe8Gfk7WHiT+71FUo50znlAnf3LzCUSFG+mDGC3BqwrdAPNnDnu6H9yCNj8n0jIQosoijyqaABRYFecyUdUZOv5SUZINW6cNOGR77tzWZVXt0G7ibLUXcorpy3jfdBGnsQq3VuC00P3IInBamOY3nux4dSMX1VX/BOSp3LRCu/mdb99QuAstEhz3BjRBdHb2fpWvHPbJBWDvV3fslpbfzqz7OICHNpjBHG+VXAAQ9KcMMvMtyXxbqwtYKCj6j0s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(41320700013)(1800799024)(7416014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q9GP9GIpJZgWRvFZ0ZXdMjDTP1IL4kg3iT8TBTgU0TwfIETQXbJ9XnOkAC04?=
 =?us-ascii?Q?hwPriAlWmtl3yLKqqaBUFvmVq1qNSJmdxuzPnObEkWqUDoReOXBOpSGiRniE?=
 =?us-ascii?Q?tLaadcF82u9n1MfxvCwI6rQKyWl/MmeGVJhIO5GRzm/RehVQRIZWcL0gwGiX?=
 =?us-ascii?Q?FwF+Dgbdf+AkgqvfNrlV3rme2xAt7MAJi9flpgTC0tcBiVXJm97ukiYzOH00?=
 =?us-ascii?Q?y9cacsFvprWnt5lELSlhHt/HftwuEGucvFWYRyYo2SL4A502dO35vLj3DjxS?=
 =?us-ascii?Q?NOzu5WzOb/VVrdpu7GygnerWYBcEljZ6hKY1eQlvhk9gjK3kCwLIOHgivFOQ?=
 =?us-ascii?Q?B84CM8x5kTO507iOoB/miEtgUGCYc9OaCyEV29N4y5tVUP4/wU9MOuWBLlFb?=
 =?us-ascii?Q?A1Sh07FZyXhGr+bobXmKfFguNfP9z20DN/l/5XxixUXhUIStpYshys7DY2od?=
 =?us-ascii?Q?34WXMAEEp4gasc8pcvYqTC5BVdNVKICJUPaoqv8y9irg3qXjCnWTJSi+3LFl?=
 =?us-ascii?Q?Xxty539w+jhcpSDkiDR7dpvqzP5ODJDrqRhvGdKHqwBHSItjixS4cF+k8pOS?=
 =?us-ascii?Q?bx32NqDspRi6XyvC2Tv9PRhqo+POLffV/0N++mBwcndcAPfuOqlFuBULavoe?=
 =?us-ascii?Q?p2eA7IjVs1bAAi/3YFl0U0h0qs94MTR3Cv7Eri1275g8pa2tTvbUot2Jouoz?=
 =?us-ascii?Q?hgdqRlFXv/lYXizjginVJt+wkfu9RdJwyBkBmsxpOh/A4C5rW0kE+ltnwr4/?=
 =?us-ascii?Q?b54PA3FbeDOcE8L/TCN2rCRV2xJ6/JNHG76LULVCVNCJK4pcu9nS7liGs3pk?=
 =?us-ascii?Q?iaZy1X1ViNv/Vg9QZYXl1mAZQpdgdNGsaq5FO+s1C65Z3pAT17Erp6fTCiL8?=
 =?us-ascii?Q?axqffz9iGY6e7u3dU9xbmphghc3gD5K2DkVBeBa7FyNSe+PQQfSDe/KPRs3j?=
 =?us-ascii?Q?wLbEvVHFkdMaJHZD9R4Z9uaxldZA2o2t+wbU80LFtUQ2vY7IZ3B7Rstfv3HD?=
 =?us-ascii?Q?/FMBXJMevM+2Sla7Ykzqugi7JtHeaS8HHuPnAwPH7ntdc3wm7rRleZhH2V5+?=
 =?us-ascii?Q?Mv5rrQQfkTgubshnEmgcUl9tyikXoIPk8neP8t3QmTydMfHChm1inTtXvhOO?=
 =?us-ascii?Q?NoWsMGkLnwh3J/ULAkLRBD5jlLDbCykICaECTLVvaeR3hssItQs9hON7Sx9k?=
 =?us-ascii?Q?wHkLAIAbdRv2o3LuFBw4PoSBnkX+lQO2oEWsPzVJD0oA2XO+iolTdG8lR2de?=
 =?us-ascii?Q?YJ5YzyXewQ5m+SjbrSf+dwRnZaOMTsyy9IcuLruFhDVKrJJjcB50y9B9HP+w?=
 =?us-ascii?Q?445thAj5S5QzBpSmb+s8X3OZ/6impldvBfC39X+p6JIZdlODOHxZqaxJwmwk?=
 =?us-ascii?Q?aM/fqURbzdtK2cK1Urr5g3N51DOQdyZ0I/jkfKV/p73H9EPnalW4/N9T6j/1?=
 =?us-ascii?Q?VZz2VT2D8ehYiNZrLQ2P8AuASHd+p1EdBpuP4dDGoJvg762HiripfriQFUMe?=
 =?us-ascii?Q?asnKyBeKPODQYCAQm5Z6ZWSzY7BqDrZribAN3efGJmxDKJDxXoAuD9qLCn4W?=
 =?us-ascii?Q?bdrWpqGbX/suggHzeMr/W1mJstaYCTcYIeX/xqXC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dae1127-ef79-4873-10f4-08dd4cdcc5a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 09:48:44.8590 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rVB087mFc5r7eIRuz9hvJp7Fa+CIGX2haNCHtd/MAla6TWTj6sg4Ki7GTwr56tbt+qcMTmBScxdTxGLThI6DU11YwvIHtIbAAyXO7btDdI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1273
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
> We support all JH7110 boards with starfive_visionfive2_defconfig.
> The relevant device-tree is selected at runtime based on EEPROM data.
>=20
> Support setting $fdtfile to the file name of the DeepComputing Framework
> motherboard (FML13V01) device-tree.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  board/starfive/visionfive2/starfive_visionfive2.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/board/starfive/visionfive2/starfive_visionfive2.c
> b/board/starfive/visionfive2/starfive_visionfive2.c
> index 3940d45b13f..55daf730c81 100644
> --- a/board/starfive/visionfive2/starfive_visionfive2.c
> +++ b/board/starfive/visionfive2/starfive_visionfive2.c
> @@ -17,6 +17,8 @@
>  DECLARE_GLOBAL_DATA_PTR;
>  #define JH7110_L2_PREFETCHER_BASE_ADDR		0x2030000
>  #define JH7110_L2_PREFETCHER_HART_OFFSET	0x2000
> +#define FDTFILE_FML13V01 \
> +	"starfive/jh7110-deepcomputing-fml13v01.dtb"
>  #define FDTFILE_MILK_V_MARS \
>  	"starfive/jh7110-milkv-mars.dtb"
>  #define FDTFILE_MILK_V_MARS_CM \
> @@ -67,7 +69,9 @@ static void set_fdtfile(void)
>  		log_err("Can't read EEPROM\n");
>  		return;
>  	}
> -	if (!strncmp(product_id, "MARC", 4)) {
> +	if (!strncmp(product_id, "FML13V01", 8)) {
> +		fdtfile =3D FDTFILE_FML13V01;
> +	} else if (!strncmp(product_id, "MARC", 4)) {
>  		if (get_mmc_size_from_eeprom())
>  			fdtfile =3D FDTFILE_MILK_V_MARS_CM;
>  		else

Reviewed-by: Hal Feng <hal.feng@starfivetech.com>

Best regards,
Hal
