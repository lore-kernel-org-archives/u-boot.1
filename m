Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C0FEC021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 13:06:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D222380FD4;
	Wed, 19 Feb 2025 14:04:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Lwj3ICFu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA180801DE; Wed, 19 Feb 2025 08:23:31 +0100 (CET)
Received: from CY4PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52DD8800D7
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 08:23:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dcgIZHoCjAritRhOJAnEsEEGIN1s5Xb59XMubniUpv6Uq6zXmpNAEvFdWGS5IcU4D91IiQguso9LNUNqM0i511kD7meRuqBB1ssJDr50BUvdcAY98NWJTz72qJtYstsb3VXEGX3Vej3y+GFwn/kXM8mgRnguc75HnDb9DkcYzgloknnewivk1Eehu4Hfio7s/PJQ1KER3Urr7+sq8ftZfOZxH7YXFb85glyPMX7Cwm22pF84jZnQPQmQXb6R4PsvRJMHfvmz0+uO6UhnX4D6UdbFts6qHpXMHT0Yo/+9hhUoMG1n0iGLvkfT4D6umOFjQowy7nUs1g3CPd2epSCAHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4ygCmZSPn2aOTK/s7kbCQwAHSK9EOWUbNsK9DMsaQw=;
 b=WCUDxXOlyW7mDN9R9RN97m4IEgq2SQInLtJ55iCjR3RCfwMQmkwAUiA59bYPE0bwva6RDUs5O63G8ScIfD+wdvFG0HBvJXoiBHWhR/mm1L927gxqnT/4be0ZDNV8L5HACpzBz0qKMlBKzhDdj7Jx/HGMSF12FAnphv/CDv0nKb9ib143LFLfaX4PAT+BzEwjOgiNdkFjb11aCG6enOlU9Nc1dbt05vg7/DiugUSw/G6VXdeF/oGpXVdpIKeRSAlF0j3cfsDTxUP0+Xi/IiAHgsD+HWv1gw0l5MGc/VrtDspHhKNJY16dh844jro9lpSbwqJ+Z/Mw0TZ+ME6KkTuvLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4ygCmZSPn2aOTK/s7kbCQwAHSK9EOWUbNsK9DMsaQw=;
 b=Lwj3ICFuSvqOyo8RJyoaOA/QGveDEPbUL5JraKWYcwcvH99nB4AQS8kof+UTlwQWcoTO8dpPZ5rdtVI5pdPJjd91x0F9sHE5y697Afs/3lziYgD2r9QgOFJ3DBkh1iMuACQtkEYAW+2s2XKYYyhfW5wKtJKna9VudMs7Lsribc03QwG292VxaB03awVcfTkU21toAISwnGMkFegLv/a50Jv6uSyMhcPBbsmUgk/FCLzXkZowI2oUFwVsiZt2sSGot613ZrtFxU5oRPYhKEwLzG9P9XfDkEclgzo7lv50C1n1pczBv/PIunOhZCfZxZpscTIehNJb87V60tGEOKLNRg==
Received: from SN6PR03MB3583.namprd03.prod.outlook.com (2603:10b6:805:47::26)
 by PH0PR03MB6679.namprd03.prod.outlook.com (2603:10b6:510:be::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 07:23:26 +0000
Received: from SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad]) by SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad%3]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 07:23:26 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "alif.zakuan.yuslaimi@intel.com" <alif.zakuan.yuslaimi@intel.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, "Ng, Boon Khai" <boon.khai.ng@altera.com>, "Hea,
 Kok Kiang" <kok.kiang.hea@altera.com>
Subject: RE: [PATCH v2 15/26] arm: socfpga: agilex5: Update CPU info
Thread-Topic: [PATCH v2 15/26] arm: socfpga: agilex5: Update CPU info
Thread-Index: AQHbgeAkJuTlA2mfEkWdXVAWfVh0s7NOOo2g
Date: Wed, 19 Feb 2025 07:23:26 +0000
Message-ID: <SN6PR03MB35830650156B65F42CCA7CC4A7C52@SN6PR03MB3583.namprd03.prod.outlook.com>
References: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
 <20250218083511.29249-16-alif.zakuan.yuslaimi@intel.com>
In-Reply-To: <20250218083511.29249-16-alif.zakuan.yuslaimi@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB3583:EE_|PH0PR03MB6679:EE_
x-ms-office365-filtering-correlation-id: ef33a663-f138-443f-6e0a-08dd50b64d53
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?0Sq7adTbVqkOhXFmZL2GtsmuqKNlW76CBFvfrAZe71Af965bBd9A3aXzwMnv?=
 =?us-ascii?Q?iEnzk413l/ht8NCIvK4Q16q7t4m2Tbp05izq1kAxtg+BLPJpA/wj0MEWc7Cb?=
 =?us-ascii?Q?ZwiLV2X3PmHMxiPgIvxBZf/xrfroWPF6ma9FC5RszpW7Q2UyToWcgKMkqcLT?=
 =?us-ascii?Q?3TZ7KRIaYDM5B1tWWpxF4UTFUxzdKVegPq12K7hDzBjyX3Gsglgp/A3Wvx4d?=
 =?us-ascii?Q?eOa3cNtGr7uIUS/FjtGJpR7kLNfFvAohKTTISRl30eI8OOb2ejMA/U22jGvX?=
 =?us-ascii?Q?j8pRkLwqlyG1BlDtQ9249ROcNkrXMWIs2CZWLYJFdFAVTFa0bzmRehSOw+Sk?=
 =?us-ascii?Q?oU2rdOjyTVtnhybNsP9SEPKt8Ed2g1nMmDb8aSovUe6OFkaNecD8H3/YyrZh?=
 =?us-ascii?Q?FHlVNddbuUNFx+7rEGY9ntbOHcw4JADfNK0ksYuG7V/eg0BTdrzrUeRS4R4q?=
 =?us-ascii?Q?o/mAkvTpYGH84m0QIUJKWwD0sj0P53S/8NUlyJuCVoizTesu08rYzkepJkF7?=
 =?us-ascii?Q?czHzcTscHNBB/xnPbqypbZN8KelgFeo2jPpEyJhkp3r3yIB/V7wUW459R2gK?=
 =?us-ascii?Q?BVrPLJU+luujKGFGTEymm4CCwAyqv5ZeQp+VXG+/LRt36f9HcNk5MDsZhPOk?=
 =?us-ascii?Q?uPdxwJC7ccwolbeZhHgz2orS86PLDBsGotQcf4VtGFGNh+XxVzTKx0lLyxGc?=
 =?us-ascii?Q?IvHY1ZDpW5l3mFR3Ld7hWfwIfq1oTbfNDG0AoVBYlwT3uVm9GUk8fvK682pH?=
 =?us-ascii?Q?TSMXAgpxb0U8Z4Qs2LvAMbadT/3kALpd1fin4Dldex0YGpIQSDRzThCKh3H5?=
 =?us-ascii?Q?BoW6f9w2yyQft0HGDkdgPQNtb2Z1gtA+kU8gckp0fpB5JfzFM5yvjt5YJSxz?=
 =?us-ascii?Q?JmlsiXsd1hutYTbQNiJWsmPljMLgmg2XL20eYSQeNYx7jj68MHJ/Fe7dj4jF?=
 =?us-ascii?Q?C5zBPzy/GFDQUdfl29s824lNsSx7aYuy9yd3f84AL9JMuTYwfH3mMUPd8e9t?=
 =?us-ascii?Q?764ApByivuMMUZu/xsznSnV+sL864p8OfaHlju0QjdydZqRGxBh115AyKE63?=
 =?us-ascii?Q?U05+Zyny18tu0NDNkjNz8pTBxXa5wpGNfF/8HleQ3Zuubxw2Bmbj0kOs5KBO?=
 =?us-ascii?Q?Yb9zdDNjl2dCXaaaaV5+jJBVgfydzhQdREeFjP0Tak/y2bnO5h+apziascDC?=
 =?us-ascii?Q?ITz+sABo8i69rV4BdRQkO13GG6BeHq//US0WRNbt6qRxBQGjtjZlWBWL0Xo3?=
 =?us-ascii?Q?ZjLNEPVjW6c+nl+q5V/4jb6lprcWSv0vbgbUSwJIUeilRRVOeu1pmixKvtRQ?=
 =?us-ascii?Q?ooPohC2g+fFV3uSWlHJcICe6ytbkxkyF5fP3IaGDNHtCY8ndtv+5fUpo/pUJ?=
 =?us-ascii?Q?S7I7OIUQvHp3jMFtYZP72G8BOpxO?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3583.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vCeI/d1xWQMXL71+04Uyp8uD8L6IeKNRG6xpwGTPAIk+krPNcjaLmlfJSkBB?=
 =?us-ascii?Q?p3yMTibA3oMIhKsL0N2mRvZNXsEAoX3vNRGncioX1qNuV44tGctIHx5u+HUz?=
 =?us-ascii?Q?bjpppZPZRN9ypGzm1Bq2mHQ6d83jsTJ+Nd8p4frKEACK/5LvoMonowS+slUV?=
 =?us-ascii?Q?+7aNbGAD2oe9wtrVc3kon128CGiH988Zn25IrZ5Deidy0Xjvi3obkDnoDBvm?=
 =?us-ascii?Q?zN7lbUInktxpvG8r5IoBp2rjvGb/b9RWPCMCFBWahfX+ZcMO23iToNkDOtLh?=
 =?us-ascii?Q?dmkkuZr4jpl3QOaV24yLpetmAvwCnAQPTb6Ghd93YmLsU2Uapwlo6kIWh6CC?=
 =?us-ascii?Q?6RjnMZMrlh6tlrfE3MXT2Wz72XjCtsxziVZKV7++dq8p2Hjl3XO8kWRLH16o?=
 =?us-ascii?Q?5SCbxhYIkF58WH5wxZ9V/ltyHpQ6skC1F6HP0PC6WnlTBIhuK5P8dgPYQubO?=
 =?us-ascii?Q?AEsYrnnUFYCvkFAv9d6B+fSJCwsQnrayX3NWqt19leGwOcan+kuK1RagGj+i?=
 =?us-ascii?Q?VRoyrte4L7Zwr+aO3cJIZkQPMlXBvgxAxFeh6B5smz3U2SDKndjtH1f/UcW7?=
 =?us-ascii?Q?/tsL76+NrVWI5nuFTxkZgLwzj1hGvxZg4RShhAFfG/7FK+gLljbfk86PYy+5?=
 =?us-ascii?Q?Hk20COO6UrQeGaBMZKknqdv+o+ABhHkChtc7eU7thdilNfWBekzUSlRWgtmp?=
 =?us-ascii?Q?b12UlXuPH4odAWmL3JjudB1D5sf7o1rVYCdns/rc64jZsDcC6Sy0pIo0aJtC?=
 =?us-ascii?Q?LmgxiC6SROoIwOE1yQw71OVJv0LZOXyyZCabtxkVaNjH7LniiHcPujJSL55l?=
 =?us-ascii?Q?q0YEoey9dFBuTeOoYCHsiDw8AvhumQlwQ4fbzDfi1KzrA6N7ibyxZzf7cNPd?=
 =?us-ascii?Q?Mbedoi6CjXLs/UNxloPm1LgDkUaIFxvi/UpldKQgIPQDicJijoChKM9+1Gai?=
 =?us-ascii?Q?1+eFtK7MYtMXUsJf7iTeQGeU5lrgYLMNRF0BkP9gMNemh0rr8EIkuWLRL4LE?=
 =?us-ascii?Q?HlOGX9CxYggJGI2gVbtenpUdGFBLardw17NkFEzcymaIm3/Zwm7N3AVahkX9?=
 =?us-ascii?Q?aR+FfqfmOHB+l98lYQU5O4Fugg3JgY2f1yRk1ZIClSxp0ocjmBy2jllyopsh?=
 =?us-ascii?Q?Djm77QpbthW6EfGQ01XPzgwt6ZT2WOflRP3bYzkL/Giy2rlw/XLAV0vjf692?=
 =?us-ascii?Q?06/Vrd3Dq1Vtbs+ILWkbIdd/ls8H1iz0w0zbktkZftV5NPmccCw6PbnMrj8D?=
 =?us-ascii?Q?R9jn2Vq+ZHfc8F6/Hj1Ftvb2IhOeI451gWL7SG/KhzSiKFYQnoS07Xw9ybr6?=
 =?us-ascii?Q?RloXk3HRw9EhNbmc0v0Sq/vRxJFKFiWsAf4dWijt5o/iLeiiWG5DvHFCfoDN?=
 =?us-ascii?Q?jTxwcYyTtqSlBpSg04KaLvPKuQ/zeE9QpC/JrIIBYNtlZFaVg6oxcIrod/z/?=
 =?us-ascii?Q?Sx1jWFBSJloDydyK7j0lXOaH1n4qjlfaKC+QbtRaDH1XUv3S6FbjSWhpcETU?=
 =?us-ascii?Q?tkZL9VulmWmnwjhldyK49ZMDvM0CG/uM86bQVQ7iuf69tW7V2AQy71CzF4Vv?=
 =?us-ascii?Q?8L1kkaZgJbx4br+dVW7M8/F0CF0HcxpY40mGksZP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3583.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef33a663-f138-443f-6e0a-08dd50b64d53
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 07:23:26.7812 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ujI0ZEoDFdoWuKbyF7XAxlE/Jp4IdpXlsZ5L4mASw2G4oCJjCw3/hi3cjD9A6YtL0qg5sEr9TXlPq0ZqKoZhy5f8pV0AFG39Mt6M8kAnrwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6679
X-Mailman-Approved-At: Wed, 19 Feb 2025 14:04:13 +0100
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



-----Original Message-----
From: alif.zakuan.yuslaimi@intel.com <alif.zakuan.yuslaimi@intel.com>=20
Sent: Tuesday, February 18, 2025 4:35 PM
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt <simon.k.r.goldschmidt@g=
mail.com>; Chee, Tien Fong <tien.fong.chee@altera.com>; Yuslaimi, Alif Zaku=
an <alif.zakuan.yuslaimi@altera.com>; Meng, Tingting <tingting.meng@altera.=
com>; Ng, Boon Khai <boon.khai.ng@altera.com>; Hea, Kok Kiang <kok.kiang.he=
a@altera.com>; Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>
Subject: [PATCH v2 15/26] arm: socfpga: agilex5: Update CPU info

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>

Update the print info per Agilex5

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

---

v1->v2
- Simplify printout logic writing
---
 arch/arm/mach-socfpga/misc_soc64.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-socfpga/misc_soc64.c b/arch/arm/mach-socfpga/mis=
c_soc64.c
index a6cc78454da..573a8f79cae 100644
--- a/arch/arm/mach-socfpga/misc_soc64.c
+++ b/arch/arm/mach-socfpga/misc_soc64.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2016-2018 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  *
  */
=20
@@ -45,7 +46,8 @@ static Altera_desc altera_fpga[] =3D {  #if defined(CONFI=
G_DISPLAY_CPUINFO)  int print_cpuinfo(void)  {
-	puts("CPU:   Intel FPGA SoCFPGA Platform (ARMv8 64bit Cortex-A53)\n");
+	printf("CPU: Intel FPGA SoCFPGA Platform (ARMv8 64bit Cortex-%s)\n",
+	       IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5) ? "A55/A76" : "A53");
=20
 	return 0;
 }
--
2.25.1

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong
