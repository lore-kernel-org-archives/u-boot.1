Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B82DC3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 12:25:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA28B88B22;
	Fri, 19 Jul 2024 14:25:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="cphry7IH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37B8E88B8B; Fri, 19 Jul 2024 14:25:51 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F18928850A
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 14:25:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=udifpLR862wz1T6e/fiqx3TlMNdoxaL8cXR49xqfW+eSgBRy4OAtvmbOQ1b0IjIk6/5yYGTa6GqJU3os3GSBoIcQgzdrY0I7R/8hLBZfyq3BNlnN0m3LJjbvw+ecJ1TZdQIu6RS9VVQb9mZmXWoQ7aWlbTJEq6gqemQ4RCLLDN/2asvQlbMIo7ThfvHm2Cwm4u7mS8KDD6KM+Zrxc/T42JxYcauUWP2toEB1fTaoK6zzgF2y1eJ6GJnrMCZP6a1WReUvcnLZl4WAGGHt10uXY+4ppq2ZBX7evLlIok+r33ZoJosFQvOHhHJ2MtPlm5iEjvzsNCtMYJMGVMKG2ybkzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44jPM8aTP8JskxBOQKMrXAw4U/B/hZdbM1sDTT/5vGc=;
 b=F8G/mugQUlmznSgIulKABKNlk8PQQjBidF6Et3D+IrwQphlWA5Q38VKI81dLbRTJSLjB4RZ1nLvVu8B2GZAZhYuExC+FOiRMrZqsOcYbxFQdZ50ltYp+e2NHrih0gwqCewdOForuzePTBICXeZqhhYCyH0dbZJd+AtFPAbK9CJkpWRQLhXXpl3frGLFhnhC8UY5NlrN8D7fL57wLpy4CCd2oQMMaVuMBeNoFk1HpGpCnGhz6PUyt1acrFHvKXDBvEJNLjy7UCb+kJNryJUUzRcSHCl7gxEz0jfWq00xPkN+wGaacyh2a2tOLIYFBz+NUz1KX4RfRH4GNKfVGJjz8tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44jPM8aTP8JskxBOQKMrXAw4U/B/hZdbM1sDTT/5vGc=;
 b=cphry7IHVPHlDSZnTSWlV7Bkauv7cHW0CYvzS/+gDig9itVbe7wdQl6TAPeGEhRUyiZppwZPprxmgPTJMxd5NEqMKEdz3s7ZJqgaCkUXnsN8COPvXDSdr4Gt5LS5ooQ5D5AbujzTNVE2IUkvr7bWmry+ztmwSbyxQnVRdEMYG00=
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10559.eurprd04.prod.outlook.com (2603:10a6:150:20b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Fri, 19 Jul
 2024 12:25:43 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7762.020; Fri, 19 Jul 2024
 12:25:43 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: dl-uboot-imx <uboot-imx@nxp.com>, "m.othacehe@gmail.com"
 <m.othacehe@gmail.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH] imx93-u-boot: Describe the CPU clocks in the devicetree
Thread-Topic: [PATCH] imx93-u-boot: Describe the CPU clocks in the devicetree
Thread-Index: AQHa2TM//LpgARdN1USXPdOQOkpgIbH9+wBQ
Date: Fri, 19 Jul 2024 12:25:43 +0000
Message-ID: <PAXPR04MB8459D5776F7661B689B99B5588AD2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240718165454.904763-1-festevam@gmail.com>
In-Reply-To: <20240718165454.904763-1-festevam@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|GV1PR04MB10559:EE_
x-ms-office365-filtering-correlation-id: b1dbfddc-56ff-4d75-dbbf-08dca7ede911
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?OQU14qA5HpZG/wHCfMoJXhdfyl3HM9Fxt4EDANXifXlP1cilokJ5U4IyjBE1?=
 =?us-ascii?Q?2oYe6UjcPRWMGcHp3nB4B1fGl8WtuzyY3Hz3Thy/lOCUXCCku96T3O87dRrY?=
 =?us-ascii?Q?sgMk68XNiO0pdqtkj/aUi+cEh2rT+ZqG954k5vBZnv8lbkVbrodnR6seK398?=
 =?us-ascii?Q?qAQFHFugD3wuPccQf6NnKIEoV4oFNjVHS+x75eqShheS6QAWHcISgMQhJCuV?=
 =?us-ascii?Q?TKroTS9TSwp6zgOHAE2MqhSbZUJyTcMPmHvHG459V/95xDSDyNHogheyg7Rj?=
 =?us-ascii?Q?0BiDhLLspI63nzyV5HrPRD7sQ7R+Sa6LmbxZEs0vX6v//E5xfHtYIh/ZA/WX?=
 =?us-ascii?Q?Z57yQogCxlr+W57l4zRKzz98ChcEgcKPh+u8OCOhEAE/PE104ai/zjBxMVsC?=
 =?us-ascii?Q?ynqKLECSuwaFIu4vspbAXhKzd/clp0v8qaCh8V3/ykdyoiEfEDSxVN9lknjH?=
 =?us-ascii?Q?LWfCXjzHyd3o5i/dkxyQH3UVFhE7kq75aTePEtKTaBXle+BGSRCIwd6uUqKO?=
 =?us-ascii?Q?WGkM0TMefrls+p5ifsivhhdcISopEVAIXGfcjXG4aTDUgzBcN3vCJNDztm+T?=
 =?us-ascii?Q?P1MIiFMS5+mtyIJzhoz9MQkq/uH8habeNs0HNJFJGIJv/AQMvuIXLAmiA476?=
 =?us-ascii?Q?VUCx/DcB4f3m/iuNa12YuHZOefWsS9KL6P12k8rAPNAvdSi+roIFDy9hECw6?=
 =?us-ascii?Q?p6g/P3/dr/I9nzPxEUD/ZCwRt1dxT1DGXKMXDK1y09WL/mNLvQrYrmXkW6yn?=
 =?us-ascii?Q?KK9o4LVrsy14jLHogNPqp/fqwoP9fZD8pXzEIYMNviFLN0T6N5QA5R4rF4xw?=
 =?us-ascii?Q?sQw0sALhm5U336L3AHvJJA68SVw/0zjNrAZP8J3BG7t6mLAQfYouiaWZG1ak?=
 =?us-ascii?Q?vrz4RdhTUs+ZU+ZOTMo8O98DIZG8iVq956H1ydvzItgmEOQ0INUGp3DOUYwo?=
 =?us-ascii?Q?7r/QfBrLKCRm9nur8p6lyGxgQS+2MEaO2uB+0rou1nyKpxpUwcrkLkUTERGe?=
 =?us-ascii?Q?mwjzJbcS508yKqY9uZju7LvlBZbhMeCI/uhvoLYWR3QWQ5kMHBtwF7Y5ad5k?=
 =?us-ascii?Q?gimXS955AVBX/7CLtt087OmArSYzCR3Eo+DuGvWraELndMO0/aIo0ASdXo4T?=
 =?us-ascii?Q?tfhkQkwrHkldD6QESK6l8qM+L+DS8Use916GLEjG1M8goia813eOqQcJ9d61?=
 =?us-ascii?Q?Zj7DpjYJKwJQyGtusRfl/oV1IuFXN9SHXLEewqyt+AXzWKHbCWl5TAhCn4SJ?=
 =?us-ascii?Q?u5p8FObMek0CSsdrUzepAXkZ6a4ZG9yhI7jS4L89LJT8cOfoUD9DVU5Y4JKV?=
 =?us-ascii?Q?Lq4rCrj8X/yAIetCgHif9p+Rq4kdqJ7VpdSpNRyLiAvIn7FLjQ360f3sE6vB?=
 =?us-ascii?Q?ukkKtX9CuAShE6SGXSf7QZhrfBD0MBchtTn5xyg+fwoJVkQTmA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SGphZDoA1DOOiWUTWPhFOMMaMTPphlPssnUv3zdVJ+KsjMzYKMKVJ2ApS7kP?=
 =?us-ascii?Q?eo2S8y8WYrwcHnA3af6WUD3f+0EUkvSVku3AXo0FOOiFZY1X9OMvDVVsoyLa?=
 =?us-ascii?Q?Bcnf2Sl+D695T1cUIQvADP8Dy4Ppw+q+PYy1LUOHFuz19j4tzoQAdl4GQDHS?=
 =?us-ascii?Q?5xC520hPiznnsFllB/ucE9Ovnlwe9VP5Maa7+iylwwWceJDyXWd272Rjywxr?=
 =?us-ascii?Q?5HSPp9IifIbCpJkf9DcWEmEIaS32K+jJ6E4w+tYFsa0wxN6NBcwMbkYHVrZ+?=
 =?us-ascii?Q?IsXAWWlM0IoYkO6CWjIj4SMFxjTmbbtgpk6hwXJoV+kkMvdvv57OD1qxejHh?=
 =?us-ascii?Q?mSwhyku4WSgafOD4JkEnZd9G89bpbO3GR08TqE0fSCbprExj0YpgDgDkdkyp?=
 =?us-ascii?Q?aFr122MLruefk5GdjAMGa/YKZMfrNJiUJj+i+TI0lexBIdHeZ5sKkafJoImi?=
 =?us-ascii?Q?JA2F80Hk3fIPjx89FtxNXplYtrukbEGRhtGqtfoKZrpSt+fkWAFbRyjsSyTq?=
 =?us-ascii?Q?BIccGaepijAcuAIR5Hhlsc3Lqs/BppL4wPOO5cCw8MwxeNr5HLrGw2L4Re/X?=
 =?us-ascii?Q?vfBsp6HghCA9MQpqaOcrxG6kdCqMrQdFNK0zeQa+mM6CrFOOSHoxlyX+HBwY?=
 =?us-ascii?Q?lbj+KOHCG113AOUajW6EzBzxgWVzU1mELuRhlGw8tdu+Qhorz5+cCJ2o6KEO?=
 =?us-ascii?Q?x+5o2jTwYgh9zf2+ngYqfUGdqpGwSnm/4IOy7HxT422UirKbG5cNyTsHjYMg?=
 =?us-ascii?Q?wZYOCD0KfdVC2qKrKWfnexfA2FiCWIQG4ssn1p0XMst+40dyp0ax2mDzlSJT?=
 =?us-ascii?Q?YhqU4aI5OAe6jimypfoNkpZs90oQ/KAbDQ/8+GhQxQvbrhSkPqp5rts752J2?=
 =?us-ascii?Q?x90w7BLMK+RuvOn/ugq6nlHxmSAJnPOk1d59mSSoatWBkbmfe0eZmhHogUdL?=
 =?us-ascii?Q?wz07s3Uim/JO3VUPMJdUmGq7g64cSvG9UHhHqTV5956VSIm5LpCOrrAQEnl/?=
 =?us-ascii?Q?FmLw+iUc7v/OWbMQW3t1HxWqLMo4uYNBWklt9ogEhEltdm4H+2mjia6RhNqP?=
 =?us-ascii?Q?s3gNFDKX58gwZ+2CLbnWo/Ql89OVv3FrykmUwU+636zPSpz8PgvokxsPiCYd?=
 =?us-ascii?Q?MdRtvuCu0WHRd5ik6SABIIM1H7kRFGd+X2FYyt9isnRjFJZtuaaxdBT8F9tE?=
 =?us-ascii?Q?vlRE8Ss4oRVhn/yeLy5gyGU+Du44ZLN2Y8arwGnyiugs1eyOeAn07677cg93?=
 =?us-ascii?Q?5Y8ZtKUi9ma61SrNwlVKLSAy548ilfPtPAPamZHrERKkizsRd8PWKqOVJzxe?=
 =?us-ascii?Q?2UQ0mGUqbOYe1rNY7E8gxLV+JKkAnFVxBKTAsxfjNv7aJR7+KEc2sR3AcfEO?=
 =?us-ascii?Q?wYMbFHV+/LiVfhr/CuQpjDJo0E5MLtbca62VAAdVmwNO4wL6DUx4bBLZtNZs?=
 =?us-ascii?Q?XhAvTQ20V/JvMV8I9PddXgLrFgOawwP4ZIw0Iwh64C+3WFg35EgiEWAr1gPi?=
 =?us-ascii?Q?+M6gzTZ1jFXmxuCXjkQZ98/6L5aQ/tZJWTQJl+movx00Ut/3yLXw26qN4TAr?=
 =?us-ascii?Q?AgfRpaPpq+5jsrZu4T8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1dbfddc-56ff-4d75-dbbf-08dca7ede911
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2024 12:25:43.8992 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sCH5zSWKa5vAa52zY1twAiTPDZeJczVhBHBo11B/DgREuTtPUckeVXqI6h47pu4zaGUHJoanJg1N2/c3vKPMOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10559
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

> Subject: [PATCH] imx93-u-boot: Describe the CPU clocks in the
> devicetree
>=20
> Currently, there is an error when the i.MX93 CPU frequency is
> read:
>=20
> Could not read CPU frequency: -2
> CPU:   NXP i.MX93(52) Rev1.1 A55 at 0 MHz
>=20
> Fix it by describing the A55 clock nodes in the devicetree, like done on
> other i.MX SoCs.
>=20
> With this change, the CPU frequency error is gone and it can be
> correctly
> retrieved:
>=20
> CPU:   NXP i.MX93(52) Rev1.1 A55 at 1700 MHz
> CPU:   Industrial temperature grade  (-40C to 105C) at 35C
>=20
> As the upstream imx93.dtsi does not describe the CPU clocks, keep the
> clock node in imx93-u-boot.dtsi for now.
>=20
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
