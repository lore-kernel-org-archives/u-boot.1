Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05463C021B0
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 13:04:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9DB380F42;
	Wed, 19 Feb 2025 14:04:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="UkTXmmjE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F421809A4; Wed, 19 Feb 2025 08:18:12 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFDCF801DE
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 08:18:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w+j/btb9IFWoYhmhT1AsCPvX3FRmSfVBPwoLe9+kS9lkf5CeRQuKOFjBCxb12t9wRA1LwzI+EFdMGWYV04e0fQ5Rl3tpFiTTtHF6uHVLMHJQQEbLrRKNdJ4VVznAZrl5JxnKMEZvdE4mnjP4ZK3KV1ulekkCSZe1ScPisziRq8WQY7Y04a6b0ADhP3jOs3diTi8hn9tERVTkMkjleNYjNugh3hk3G5KVKGiRHt5n3+XohjXiUptwoXl79KWLA7bRCOmxNBvQyn9IS2ovJH4MM6tsz5XqQsnG4Xmat7hNkwahQxJL1dYvQ3y98rz/T0dZF/t1QxTyan/JgVDXN5RKig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/EExNhKicgqFY1E1SzrVDufXsvyKA7TVx7klnvi9NMY=;
 b=isP52L5JhEgN9V3ndiF3ALKYSgANhzZXFIxP9hSWNpesmH0eMbX90yAMrPE1TkWOKWCLfsB7qJH/0eB+wEhhQskPrK9zS+rMe2ZVyW/EFKMUT1O6fiIy47vq1XWbIVKPUUoS7ZRrmV9A0ekXnRJr6kFeRk2nHBcKbUt6jtvOLr0xWJl5b7PIJKjSEN1TXSh+rz8Vs1qW31VN8d6HGo4P5ayPYAvE+/TzfQQkXZaDOocUpA7wR6nE5EhWVr45qLFGaGBl+QPbRBW7pBCaZT2sqDTP/5JR8OHi/bzA+Y6r+6t1nucBktVoBzI5ovgOXWzqXLdQXKlsD8wUTfJ+WxwJZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EExNhKicgqFY1E1SzrVDufXsvyKA7TVx7klnvi9NMY=;
 b=UkTXmmjEAwA2ULjx72M8Rmf62RhzL2ouy1+N82SUrhMvyWKGX8pwbx2rcQDZb3IYi4Or84i2Fv/47LlakHhwZoTJ1llnHp7GeXRzMCTDNQf/ggyBoz1dUuycEEM3USGqkGH+P2HmtkJCaC+PP1UP02Es7HgZ1mVwVr2AZ+a3U7i4vAs9+idou1Xb8HH47gaqCnnRx7mBRxo5bAhFuLzvUjDGZLXnP2oCSJqpcKeewUgYBeRwtoh8A31AMNOlTbNErgPdeSUJZCLycE8Snup6Aph/2R+I9D8zEFD9tssLzD9m6SErk2fVKDJ/auVFHuu7mh/HRxfzySpYjP5ongj2wg==
Received: from SN6PR03MB3583.namprd03.prod.outlook.com (2603:10b6:805:47::26)
 by PH0PR03MB6679.namprd03.prod.outlook.com (2603:10b6:510:be::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 07:18:06 +0000
Received: from SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad]) by SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad%3]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 07:18:06 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "alif.zakuan.yuslaimi@intel.com" <alif.zakuan.yuslaimi@intel.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, "Ng, Boon Khai" <boon.khai.ng@altera.com>, "Hea,
 Kok Kiang" <kok.kiang.hea@altera.com>
Subject: RE: [PATCH v2 04/26] drivers: clk: agilex5: Replace status polling
 with wait_for_bit_le32()
Thread-Topic: [PATCH v2 04/26] drivers: clk: agilex5: Replace status polling
 with wait_for_bit_le32()
Thread-Index: AQHbgeASi9002P84zkG7bMbJTLAemrNOOQ8w
Date: Wed, 19 Feb 2025 07:18:06 +0000
Message-ID: <SN6PR03MB35836D0837053050D3FF5272A7C52@SN6PR03MB3583.namprd03.prod.outlook.com>
References: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
 <20250218083511.29249-5-alif.zakuan.yuslaimi@intel.com>
In-Reply-To: <20250218083511.29249-5-alif.zakuan.yuslaimi@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB3583:EE_|PH0PR03MB6679:EE_
x-ms-office365-filtering-correlation-id: c5f9a667-2ff4-4a4f-5772-08dd50b58e90
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?hp0Px0PFUU9oJCPG/oCGPEP+dQfiHor8810d165eQT/7qgJETCVlLoY9VM3l?=
 =?us-ascii?Q?eEsibeF9rdDzfHnnQFabJ+VcsSHveKPBvBd2w9ST47d0VtmnfCoy183YDPWv?=
 =?us-ascii?Q?oK/vcxNbSkwBgXpVzoRHD3d44RuveZ+q0BE0aZTCCWRDsArTAm81O/xnpR0A?=
 =?us-ascii?Q?TiaZ7EoyUv5Fmc6MvcoctBw/PB0mERstKRJoDckCF+2FNLmJ4xznHZBUTE+W?=
 =?us-ascii?Q?VnLWM+UhiXvj8oNW+V2jkEZLUnVzP3f0W0oQtnqkvZPRvFhaK0mW8V9Z3tlk?=
 =?us-ascii?Q?teNFt3VFO9DtwElbf3uC0Fzvv/9SqlDWH4RkMPW58fkAcKo+cyhL1Wlm9dgv?=
 =?us-ascii?Q?ovs4MhRjmrc9/7h/gnjFslrWBdwygYzrnWWv00PgVlaZXnT+dOd8JTXZtrIX?=
 =?us-ascii?Q?vUSRORWA7Q9tmtyDsCbF1H1ToEgpOWWjrKU1eXpRq9MabYlTK/9k5RSHwzcG?=
 =?us-ascii?Q?IyfsHLtkzY2c9UA1xhy2qrnbRQy4dJnRtMyi8/aY9nv/8OsuloTpAYV+FWRB?=
 =?us-ascii?Q?vpfiUytE3cDxHSmfVtxih7jGtMd3EM/VASOa9SoyP28Q1kAyiprIzQdewLG3?=
 =?us-ascii?Q?3f0aPSYxtqxXdcM0xUOfuA+zyXO7+vOaroGp2OCZ+w8BcRwcLReSnAG/ESSU?=
 =?us-ascii?Q?8X6iKHDAFgOwOJOrRiuOB1oWhE5XxiVxhgejZcClorvNugYhfldNFeEFkAGN?=
 =?us-ascii?Q?7zfrXtWYBGZbgtR/u6HHJrqFjoKe7GVVJsyqcNx+xU/g5VME+Lt61Vfi99vx?=
 =?us-ascii?Q?GiDbbo7UvvlAY9f34tGtcE7/vTa/4xCYbJ7cB3jxQ3gvwB6flpxqCaMsdIC2?=
 =?us-ascii?Q?hF4AGT7IyJTaB+zyQjuan19+PKysDGp3ahplwFfjpyQSvRKgTZb3q7quEmOb?=
 =?us-ascii?Q?L7V9OAwg9P4+lWRHhEzFsU07yMh+7iyMiJwyshBAm4OlDGVLKBO47Q64Z0A0?=
 =?us-ascii?Q?oMUI7uruPQqLKrJuo/1eYq0mNLeohhP04sWMWNLQEr1z4XBY8ScnAN/bmtyU?=
 =?us-ascii?Q?0p5hdvvZll4YzK10upqqscSwzsWnoXoC9opWRlXf2l0EITnIMFRItcjUqezy?=
 =?us-ascii?Q?/pr/i5cYXFn1oh3L5irxpIstNer8iqborxamXFfZRhap5PfIL3Mbio62b511?=
 =?us-ascii?Q?k4W+N2rhUFIi8v4T1B5rLPpZ0+XKBhflc5X9rjDDM9Xnr1CVAYSZEmIvOh0v?=
 =?us-ascii?Q?NbNxUOV5Vu1yRzCTkFAFKNVL0I3DIq/TINLJdMmhuhObwzB7r/Ac7AkERpMZ?=
 =?us-ascii?Q?XGa6hXGjtCVaoiM1eH7Wa3po5cpw1JxF3fnWLycYzHPtOuZNgsdOlaFJH6MP?=
 =?us-ascii?Q?FgASXfLgVGmjaHcGjvpXSq30q1/txruTi9WenKP5bwBfrnvgxZb8b7MJIsPA?=
 =?us-ascii?Q?nby8y37RSlMDBWA8nUUKgD5BxmIWy8zK7/DcNgfB9CIYjJaP+mP2ofoZuRFc?=
 =?us-ascii?Q?LSzkLh+4s8ohc+4f70rKWPJjxwS8sEWY?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3583.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4Au087UrbMnx6AKqz1M4snxxWO9CrI17EP4JRetK0YYzYSGf8SHupuQhuDXi?=
 =?us-ascii?Q?OchFsn7ROaqFCpwsZeOEaFZcT91mEKxZ6HD4JMClFg1Eg2SZvaCAZ2ymz+E9?=
 =?us-ascii?Q?uvgeWoLAkile7dIBYTUzmipkJTsP/lGHI329TWx+jRejd9g9Y/XHtj7wS7H/?=
 =?us-ascii?Q?QbYyJuDZZtTFzorI2XzvbtRAZEWxiqV5VZKckw8O1a6qlT1TKyNgGNE8CeF2?=
 =?us-ascii?Q?Zq4TNCJCv3EEM1BJqEQb1H0sn0z7E77UolECOBXoVySWV4WKStaA1/78YiIh?=
 =?us-ascii?Q?uevcWGaonHIC4Yv3+tO992MetrA4Ju1R7qpBWqGFzysMHVeiIyr35lw/9K1b?=
 =?us-ascii?Q?agNY16T12TGnXGDYBGinbvOreQPguJVmN44QRPpDicCiGJpouBZWIZKsSKpA?=
 =?us-ascii?Q?O0VO/Q4zfksVtDNcZJ8hm0c55+s3b/YF87rZ+2AAKe6Mc+Qt3MQeurnFi1Y4?=
 =?us-ascii?Q?YIPyIQfaneCDirvRII/qH18j2tLSHW398gXiFRkcVYH08qJVx/FytY2pAvfH?=
 =?us-ascii?Q?jYCzf5/8uWbNJR262c3VRWjgmQMmDk+T6d8hc8j9wBxeh7rfd5XdyznKusdh?=
 =?us-ascii?Q?svFGPl8mvs56d2YQo1xiUzsd3Vflrp+bcB34Ih54Ef+tdG8KZ7ppGBRRmp6w?=
 =?us-ascii?Q?+XyPEdzL2NQUs1PpiHp7xvlsKk0bdfN/fXV7QSMFUSrTkzVZqFo/vARGC20o?=
 =?us-ascii?Q?FsO3u2MdwHrkKPOfGpZ6kwRO1Htd9kZI0cZKl3W3Kz9SK4uCVUSPS9CK5JVE?=
 =?us-ascii?Q?OfYsbKgK2/3y6CrN733bnPygdn0bZtSiTzZLkGNzrJhyD7oXuZGrbmN5VTzx?=
 =?us-ascii?Q?qZrjKOJgRiJgJJQ9Bw8KW3oDfM/q3UmsxpIRDGWo8QycyNzSb5w/pYzQ8hJI?=
 =?us-ascii?Q?TjZFTpOLyM/3EdwYU8DYMiHRGufLcwCZLk655p/I4EjMA8DhM3bwLDPu32ZT?=
 =?us-ascii?Q?+SiQx9YFnsNORDRCVPp5CEk+5TI/CqVPFzO8VktwPt5Bqouv/GDM/ugr/lBb?=
 =?us-ascii?Q?X74uIdAHgtyua4tERgLzhzsVsw0W0KhvqPliVgVTBnUn6pXmjgyBFK5CfyTI?=
 =?us-ascii?Q?pjsBGbdmu6y/zIzW+eoU2kZSKCJjLtW2U+r3h3dlNcBz9EBWGpHwHaSNiODD?=
 =?us-ascii?Q?C7BLwrDrGrctRAIIaymgaikFOx0/edjqaTWzqzP2/n8dsqgP36/wB7+pbiqY?=
 =?us-ascii?Q?vvVEmJkzohBu/DF5isK274XukWc6C5wiUwPljTqgQhQrtoDlo6RRhdUrH7ys?=
 =?us-ascii?Q?87MBm+NRqQdzpPYcUApMQRdp+hMm+7duKCnKRuKgs6DCBGwnrUG74mSFMgb0?=
 =?us-ascii?Q?H7KrALQGzsJpLTR0CfGo7xRwYKNViG0+R8XwyxPaPTQG7Ki261cIyWWC2zPm?=
 =?us-ascii?Q?y7aH0JzvNaES3dVDwINBEQ21lGMrFQS75Zo9mFskU90SWSfOLinAZF2ta15U?=
 =?us-ascii?Q?NuYnCDwuUF/91gzHa6AEnEDNgszezmpvSa33a89Q/v25qJLdjmrrDR+iUDkq?=
 =?us-ascii?Q?s6petMxvz1MbxqRnY/uTvLJDMckZCrihWzTW0nKtzTA3q1frCkRYaI/ei/zN?=
 =?us-ascii?Q?y79Hg6FvuzlOxdWfmIAKQ/hryyjFwXgok/SEIWnB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3583.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f9a667-2ff4-4a4f-5772-08dd50b58e90
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 07:18:06.7501 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oCijzUW8cqsHNqMw/c0d2PpO3qNaCHUufkFYz5ubRmMUbfZmx2h5fuBOANKAAO/LMSmFm+eBcuzyhlWrMfLjO2CeqRWRl7fiwxRs02vMwqg=
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
Subject: [PATCH v2 04/26] drivers: clk: agilex5: Replace status polling wit=
h wait_for_bit_le32()

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>

Replace cm_wait_for_fsm() function with wait_for_bit_le32() function which =
supports accurate timeout.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
---
 drivers/clk/altera/clk-agilex5.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/altera/clk-agilex5.c b/drivers/clk/altera/clk-agil=
ex5.c
index dfc25ac6787..a284b562486 100644
--- a/drivers/clk/altera/clk-agilex5.c
+++ b/drivers/clk/altera/clk-agilex5.c
@@ -41,21 +41,30 @@ struct socfpga_clk_plat {
  */
 static void clk_write_bypass_mainpll(struct socfpga_clk_plat *plat, u32 va=
l)  {
+	uintptr_t base_addr =3D (uintptr_t)plat->regs;
+
 	CM_REG_WRITEL(plat, val, CLKMGR_MAINPLL_BYPASS);
-	cm_wait_for_fsm();
+	wait_for_bit_le32((const void *)(base_addr + CLKMGR_STAT), CLKMGR_STAT_BU=
SY,
+			  false, 20000, false);
 }
=20
 static void clk_write_bypass_perpll(struct socfpga_clk_plat *plat, u32 val=
)  {
+	uintptr_t base_addr =3D (uintptr_t)plat->regs;
+
 	CM_REG_WRITEL(plat, val, CLKMGR_PERPLL_BYPASS);
-	cm_wait_for_fsm();
+	wait_for_bit_le32((const void *)(base_addr + CLKMGR_STAT), CLKMGR_STAT_BU=
SY,
+			  false, 20000, false);
 }
=20
 /* function to write the ctrl register which requires a poll of the busy b=
it */  static void clk_write_ctrl(struct socfpga_clk_plat *plat, u32 val)  =
{
+	uintptr_t base_addr =3D (uintptr_t)plat->regs;
+
 	CM_REG_WRITEL(plat, val, CLKMGR_CTRL);
-	cm_wait_for_fsm();
+	wait_for_bit_le32((const void *)(base_addr + CLKMGR_STAT), CLKMGR_STAT_BU=
SY,
+			  false, 20000, false);
 }
=20
 static const struct {
@@ -243,6 +252,7 @@ static void clk_basic_init(struct udevice *dev,  {
 	struct socfpga_clk_plat *plat =3D dev_get_plat(dev);
 	u32 vcocalib;
+	uintptr_t base_addr =3D (uintptr_t)plat->regs;
=20
 	if (!cfg)
 		return;
@@ -254,7 +264,8 @@ static void clk_basic_init(struct udevice *dev,
 		CM_REG_SETBITS(plat, CLKMGR_PERPLL_PLLGLOB,
 			       CLKMGR_PLLGLOB_PD_MASK | CLKMGR_PLLGLOB_RST_MASK);
=20
-		cm_wait_for_lock(CLKMGR_STAT_ALLPLL_LOCKED_MASK);
+		wait_for_bit_le32((const void *)(base_addr + CLKMGR_STAT),
+				  CLKMGR_STAT_ALLPLL_LOCKED_MASK, true, 20000, false);
=20
 		/* Put both PLLs in bypass */
 		clk_write_bypass_mainpll(plat, CLKMGR_BYPASS_MAINPLL_ALL); @@ -375,7 +38=
6,8 @@ static void clk_basic_init(struct udevice *dev,
 				CLKMGR_PLLCX_EN_SET_MSK,
 				CLKMGR_PERPLL_PLLC3);
=20
-		cm_wait_for_lock(CLKMGR_STAT_ALLPLL_LOCKED_MASK);
+		wait_for_bit_le32((const void *)(base_addr + CLKMGR_STAT),
+				  CLKMGR_STAT_ALLPLL_LOCKED_MASK, true, 20000, false);
=20
 		CM_REG_WRITEL(plat, CLKMGR_LOSTLOCK_SET_MASK, CLKMGR_MAINPLL_LOSTLOCK);
 		CM_REG_WRITEL(plat, CLKMGR_LOSTLOCK_SET_MASK, CLKMGR_PERPLL_LOSTLOCK);
--
2.25.1

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong
