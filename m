Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E937BC54E60
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 11:12:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5787187F17;
	Tue, 12 Mar 2024 12:12:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1DC5878A1; Tue, 12 Mar 2024 07:09:36 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on2070f.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::70f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AD468753A
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 07:09:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hg6caoJlEcXvtwK8/+W/DKNieUuyue+x5l1yRoFuYFP5mdE7XFwUx9tXMS6C+DGlUygODzBrLX5IB6bs+SmCxKNDssozx8x6597OVEAmQL4t3BnlyIWduo3PQuWxHDgOMrx3QKSKSm2Qgm0CPflefmF4KNXxoaZaFQC1jEAWatwOrK5sGX6q1Heuz6aB7gho4/npTSduYxw0odaZhPOebWYvg8xFWgGaF+0qEq2COJTPbirvmwn9aziTNrqOuTYUeojrMo93ZuVfvI3e6czq/X3YbPfYw7GEMjIIsxmLC+aedcK71nTjalQrAiVyZFV5XW3r3Gz7ip0wko7X701cVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbToe8cx0ettf//sS22lrQm1NHc+3ed2EjKIp2AaQOI=;
 b=CpWWKD6JoIxqyMcA49wHPgoOihCO9y1bcCdkcUpDv1sdbcRjpZhvwRxoSjIsVNeUsgqSlZ31xUY+CcFuJOWhaeqf0Q/hPXX20X5wUlbGKFuIvLfZqOPI1tZioV2of2wr0VTpx5u4K2OWSOhZUrs2xT1hSNlm10lbOIdkyUetU9GBcLlDyBaaa+mQdYrd6kBUiEGlJcWD742kWP8T54rZC/x5MN8mIKBHFg4JtqDItmkApz9UETzgq1w8GoK1qdM0Uxqi47e7aR5/S7F29Rsk36DPgYdf0YIgyszuUu0OCmIziKYxds6R5i1+yzm1itcJC5mKO0gJ/MsWFgFwBdNPkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1225.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.45; Tue, 12 Mar
 2024 06:09:28 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::5de:15b9:3114:4f45]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::5de:15b9:3114:4f45%5]) with mapi id 15.20.7339.045; Tue, 12 Mar 2024
 06:09:27 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Bo Gan <ganboing@gmail.com>, "rick@andestech.com" <rick@andestech.com>,
 "ycliang@andestech.com" <ycliang@andestech.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "yanhong.wang@starfivetech.com"
 <yanhong.wang@starfivetech.com>, Minda Chen <minda.chen@starfivetech.com>,
 "duwe@suse.de" <duwe@suse.de>, "namcao@linutronix.de" <namcao@linutronix.de>, 
 Xingyu Wu <xingyu.wu@starfivetech.com>, Mason Huo
 <mason.huo@starfivetech.com>, "chanho61.park@samsung.com"
 <chanho61.park@samsung.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH] riscv: dts: jh7110: Enable PLL node in SPL
Thread-Topic: [PATCH] riscv: dts: jh7110: Enable PLL node in SPL
Thread-Index: AQHab3Jv5h+1fi3TLUmBHGRGod8x7rEzp7jw
Date: Tue, 12 Mar 2024 06:09:27 +0000
Message-ID: <ZQ2PR01MB13079F11D2A7B2A20968F4FDE62BA@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <1709694011-683-1-git-send-email-ganboing@gmail.com>
In-Reply-To: <1709694011-683-1-git-send-email-ganboing@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1225:EE_
x-ms-office365-filtering-correlation-id: 92fd093f-c3ec-43ef-8c28-08dc425af967
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q08yyJZdR83FXuudMSS9Re6CSeLUJ3IbUuK+OcnyZikMdZ0pQbG7B28/m8Q2Hp1OTso4lq27XS1JCRo4U5hoXqQXTpxkFWs7Ztu7AoQkUDfTMaVM2kbUdzjj8zamCLeJKla7Y6dU9b5SiNTV299BuXNikIvG2vU5OH08FL9Wf34W6kAa0XKgbB7n+1H7bMlhgGFy9FIKRcQ0M39EbTyOqJm7VGXGBUQ5EVcw0wN1EHF5q2s5fL90dNkbOzpIqwsc4bhfd4wgLc0XXeldXB0dFqbhPI8wGPpX+r151d18vcloMu6263WKRPaIU7W9yhrp0yKExy8Uz++E6nBATO0RFnbtHfixjjvtMnE9jlFzNPbT2oNr8nQSpcvhmDx8VM361skFhDewAKi/zjmBZze6BXQ4PHwu/EF8Ec+CwIOlk+3/KDaRUOrkEhP7j4vxeMSrPVeTC8YHKl+r1dzndbRgBWLx2herMq5dKezylVqEZMTFlhHdVN82Ezd95PseHJNJAvi39u+aCQB/flL8DmcLIilRfK8HFVkOSKrJrqDoSAB14g997yM+P8AbjOcVMJfhnWVvyokHs82sIhNyGddYASxV3Ptqc/NqDIfGjbgusqqTmDxAqK1IgyKp9XjUFSiMrTzkiQQhbzZJUTH8/Br1Lg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE; SFS:(13230031)(1800799015)(41320700004)(921011)(38070700009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j0+DIlX9F72opFTZZcwtf9Ih18kBgaLpTTjxeNlzW2dYUXwawZHObNF6tQW/?=
 =?us-ascii?Q?BWmWa3AqIZ1WhO+b09wP3K8X45FIAJBAarJdIfs4tPepr5bvglaGMLw8lHtX?=
 =?us-ascii?Q?JrSsgr2Z2as8ArjYnIOyfAP/RxMu2yfJsS+RVKRyltNRGpR9n6ZGZbpp/Gso?=
 =?us-ascii?Q?k3GS97J2fEOvj5/yPZZfsaYbR6fI4m/LXIK4k8+wF+vAxeB/LuRvDvRh5YIr?=
 =?us-ascii?Q?77laoFcgAOSI1Yt3lhT3ytIIO+PEjsdgpE5pKsDY5b2g3oYg4MDkE323yzZr?=
 =?us-ascii?Q?Ii1yCiijpehg3y1bWpWNGpoQjAbdi+RVPh5NatokOaKKkD5rkOtjH8r++VsJ?=
 =?us-ascii?Q?0pk8xCW7sR7zYW/eyjueVa44G++hfwnlDLeuezoRpECyrxoQzjtpdFvxTBY8?=
 =?us-ascii?Q?Nzp9xnPUtSI9+3ijyrLTnH5PiAn0SoECPJ1oc99zhuxdwJThVKf9azWA4lXI?=
 =?us-ascii?Q?dnI+lYVahOlFuUqZEoT9q6HhqBLeMV5eidrPezilYWQDlH6ALMk1hCkiCcQR?=
 =?us-ascii?Q?cR4iYjC+n/QVLpZpFqD6zRY57/ex07gAn7Du5f+nRA4a84mxjSVumwqYwluv?=
 =?us-ascii?Q?lxD4QPwLWW23VzZKBwij77DqNZK3Hl/MVq9dwpPaxuUOpDJvgVN1+YlBYZCm?=
 =?us-ascii?Q?I3KxhEQH5ErH4NuC1Qz3mLlGWqZ1GDj+fUKj26nCg1oM/pODL8cvqAwOiwu4?=
 =?us-ascii?Q?uUwrwJUwOgIQoDKjbT/UY+WnOAk3H4EiZc1Ism90pl00eKU5yRnEk4fM5n56?=
 =?us-ascii?Q?gnApPolQ5X05BE4iADKX9vA3abK2ZEOi+x7s2w8ehJ6pDq1TKRZRL0SrtGji?=
 =?us-ascii?Q?XcCw/+tbR9DdMvPBRFpxORFiRvJMX80X28Baww2IzZfvlnDYLns6s75I5CoD?=
 =?us-ascii?Q?Bcf2L0pkrsTda2Um3SgTute3TGpIkppvSIj3bhnt9gM2C5WV7bdZoA4s7fmy?=
 =?us-ascii?Q?VapNQ/UKW9xMx7W3RvP1mxRbSJiF1/YHVd1P7aNVTe8EAU3ElmmOaLGys/23?=
 =?us-ascii?Q?dXjUvnVYxttGPZkg4MLZW6giSKIYEy5KB3LnRdOstspKFP55exaChuaaTYnr?=
 =?us-ascii?Q?4F4aXmZ4tsRJxQZ8McXibc5LIp4PJe98o9j/f5Z9Q7UJU9hq2DpnWY95y//Z?=
 =?us-ascii?Q?bhSOPHMtGBiLd2uWNpoytXlqoxdD0vzjkDNWWxnfYMfGXd3Iw6tDCQii5IM7?=
 =?us-ascii?Q?ZbW2IA1/pE+BltVE29XOMx+FqQL5WykYSRcJBhStwYVdTuZVvQiVIxSiatbg?=
 =?us-ascii?Q?XzeqTA4ENNql7K2ynae5ZpUfvDw0QRTeLigIiYtrcW1u5WH2A8QFsplulqzE?=
 =?us-ascii?Q?l4P4DoqiUs3TuORHm1KcNxbwGGHRXWcAFdx4G20jCeIVZTP/CTbA1hcRPZDj?=
 =?us-ascii?Q?FvWXSPhWWIlq+Hd3xQjYtpixq0WyYRUNGZ6rHAA7SQi81iNMIWCFFbJ0N3ZN?=
 =?us-ascii?Q?pl1p4i+QLcnCjBtsNVi0XzHJFKdCCFAkOJA6mfxeDkBVkzoHvehUVqzZfq8Q?=
 =?us-ascii?Q?EuCmLd7zLT64HLesZhjeY8qGQj3NqLaPmLeobSZEacBLU8aDqbBvkol+v9OD?=
 =?us-ascii?Q?DjgnW27mGTzBxpWUclDUtpGZn5aVpNc3eB1/rbco?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 92fd093f-c3ec-43ef-8c28-08dc425af967
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 06:09:27.8478 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: abNpV3hMFmk/jt/6EF6j9w7TSc1CfY6ouJj4jMq7d+NwOQko2h2FVp4nFp0jDGxSHh9ENUvXnQY9l2LoOlyx0acAdWI98w45tHYJnDE6PgU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1225
X-Mailman-Approved-At: Tue, 12 Mar 2024 12:12:09 +0100
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

> On 06.03.24 11:00, Bo Gan wrote:
>=20
> Previously PLL node was missing from SPL dts. This caused BUS_ROOT to sta=
y on
> OSC clock (24Mhz). As a result, all peripherals have to run at a much low=
er
> frequency, and loading from sdcard/emmc is slow.
> Thus, enabling PLL node in dts to fix this.
>=20
> Signed-off-by: Bo Gan <ganboing@gmail.com>

Reviewed-by: Hal Feng <hal.feng@starfivetech.com>

