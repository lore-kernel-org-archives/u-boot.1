Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A958DC021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 13:04:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06075800D7;
	Wed, 19 Feb 2025 14:04:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="aBurNpK/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A27480C8F; Wed, 19 Feb 2025 07:55:29 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84F83800D7
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 07:55:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yKHPPz4C1sinVngqu35ya/aGU7tOxwoEfBLD78sS967x/iO7UPmjmsC2B7+GoJi+MoIa5FL4nUzU27kC6nUnLKNHQBq7nY5njItfiKmt3nTO8J4aDfPXTtk4Li0UWbNhKOmzCrp+FDVodM77V+Pg4Xnps/1IsJRkB0dljQhCqOrBsSr0p64DddakPJq6n+TaFIRWJbChaOjdJVn8YJWrv4qThNNK9n3u9hmRGGOoZhiAUCHQWFC+eCNXp7KKTL6yuiqzfVPTQdS05kcWAhfkIccnsazMBW8i4RvACQLr3ys48KRinTzJdCFNon/Sj/7haLB55/eWzMAhxrjGcxVLHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hib6w+nWb21NV9Ws8LKDEQFUFpEQ79zuReHTIYVdmnk=;
 b=jGtc9rwPe1GFlG3CJ8A/2L9l2jZMyrDyQEaovuhcmzkyJJ2vP6R0JKEfRxs3BiS8s4atoP3Ac9Kc3BZ7N37K0CYlHTr44OCmErcYJSZ2SelFvwzka9icmXj0wZIfGMF3ptW1scDsI9T2kNL/YxaD8tgcZw+krwIwl6ou6E4ur8I+j0bMNHEb2DmgtKE54jNZAbeTgsL1GMNYRDdzzTMmjPG5KUv7vHLJH2y2dNHpmN28Zj6Bx6WM86hlLqiuebaVw9IqxmLWOCiSN4TFP1CLI2t0oGKptogIZSUzWyQhLQdDrQ+lJTOnG/9YSgWp29lwgxy8oXRSmrpKqIVbo1B2uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hib6w+nWb21NV9Ws8LKDEQFUFpEQ79zuReHTIYVdmnk=;
 b=aBurNpK/1xtcfUxIvx/vq4UzriMYUhThhemWipgmA7ijmvgI3VSqaJYgTvZ+LxTN5PnO1UmGcGZgPU454OTzR1AreTu+S2Y9R1O5QHwrzMn1EkGbec5W/nCL2+kljWC7aBvaOhOp7CIQMstxPDvaLn0CUFHteH8C44ionXX+h/Nh+QwJNUmuQ6Bsxo0nq/zvjvfAKeP/M2d2Vs/GgDXU0S9GNpQDVwIGq6Ixrv1ELYnjwvuex1HX6gRx+El79PqsiZPQCCiS8BapwwJC3IunQsKhv5ztz7bmTGAbAxI8Jx7Ra0WS7fS0v+fEAJ0Qb9z8uLsScvu6GB52RFyOUv/RFg==
Received: from SN6PR03MB3583.namprd03.prod.outlook.com (2603:10b6:805:47::26)
 by MW4PR03MB6377.namprd03.prod.outlook.com (2603:10b6:303:11c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 06:55:22 +0000
Received: from SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad]) by SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad%3]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 06:55:22 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "alif.zakuan.yuslaimi@intel.com" <alif.zakuan.yuslaimi@intel.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, "Ng, Boon Khai" <boon.khai.ng@altera.com>, "Hea,
 Kok Kiang" <kok.kiang.hea@altera.com>
Subject: RE: [PATCH v2 02/26] arm: socfpga: misc: Exclude Agilex5 from clock
 manager base address retrieval
Thread-Topic: [PATCH v2 02/26] arm: socfpga: misc: Exclude Agilex5 from clock
 manager base address retrieval
Thread-Index: AQHbgeAQ6F6/kotWPUq0VyOiaeE5v7NOMq6w
Date: Wed, 19 Feb 2025 06:55:22 +0000
Message-ID: <SN6PR03MB3583211E2A27DFFED41F253CA7C52@SN6PR03MB3583.namprd03.prod.outlook.com>
References: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
 <20250218083511.29249-3-alif.zakuan.yuslaimi@intel.com>
In-Reply-To: <20250218083511.29249-3-alif.zakuan.yuslaimi@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB3583:EE_|MW4PR03MB6377:EE_
x-ms-office365-filtering-correlation-id: c9f310f1-77f8-445e-891e-08dd50b26177
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|13003099007|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?fz/Mntk5wRsKvTLfpeGJeYRPIrSP9az8z9XlZGWkgIqTEOyPTisXj4tBb7Ue?=
 =?us-ascii?Q?MXBHaL4+agCL22jECKrc2Zodh6UPyeIWt+Ei1msSe1kPydz4WPOmXvSawX/h?=
 =?us-ascii?Q?qmPmES5bmYyqK6Ih7YZybJ6ONDdWARly2zsA+BDq8ctCb1LnxGAUJ8ybSN9f?=
 =?us-ascii?Q?upgUch7j0LYblVCKYXYgaL6JVhj1VHLiCWuS75P/RVErlSWEHnJN14rofwuU?=
 =?us-ascii?Q?u5/GlDoSVptUsSCtmIOftkD9nd1W+UOm2TpgvXQtSylNdTtl/+CneqA3YoFN?=
 =?us-ascii?Q?RMI78zokN8YWMqbhicmQCIiSpddVz88W+MyzOTN7F3J/YMOtICY3W3ETwJMi?=
 =?us-ascii?Q?Hksh8rlp5IkIwWc1FSYnmDXPPP8Rnj0GAUlHzm5+ohQo3l/xEy0nu/xr9NnW?=
 =?us-ascii?Q?9DGn+EEoEK6AgsWplDN0DNJuqq8lRhjUSLb+O7PvlXnEX1P0ylGZTSyJZHjQ?=
 =?us-ascii?Q?Uw+da8rXD81A6Z3JR6ZZ6N1LTS7LN4aCEvZ4uAoRODbTWdu7XPU4CBLJu73A?=
 =?us-ascii?Q?Z1798LA/78ua6J0+jXHDov0eUm73YiWxJHx3fO5wNm4r/uGzqWtzFR+zX3Kj?=
 =?us-ascii?Q?31odLUxCMw6iucWS4avD97pvdHQ8p3tHScuFg59jUuYCK7JE5yaeH0AgBqQx?=
 =?us-ascii?Q?Jrp9+JckJgvdO+Bt2WIk21sFBizZ8qicDU2PXFz5x7187KL+64QrhsYc6kO6?=
 =?us-ascii?Q?M8N+NTdqP/onhVEkNtWhhGZJ2V8H6bg03wGPQTjyfg417+ziVzQJUUlFNw2y?=
 =?us-ascii?Q?9x8MbPZdFvaMFQGfdBe1Y/boxLpLGU0lX4HDNTV75w1YFHhJMaK+C8V5lPSj?=
 =?us-ascii?Q?OF4ee+JFw3WjjbK/EU/rOxWTuUmgEInlxmGx3sa7T3fTkdhmddKoG2LlwL5I?=
 =?us-ascii?Q?5u2fQmeUEEWFbZgcKQb/Hd/thY8ealNHOfdGsPiqYXX1r/uPXdoxub/FPpuR?=
 =?us-ascii?Q?xWn9zNwt09dcRZAK5Kk7Tf2Xcw/6CjvLXwu9n9rZ/54r4C6wCTBCjl/89C53?=
 =?us-ascii?Q?Jf4udHfc0j25xIW9+SY3yx84zTukeoKqgW0pqGxniQBJeBlTXVC8EH7GBwh1?=
 =?us-ascii?Q?I1uxaSHLoNrzLwLA1Bw3iymDplLcjdyLoIOmcDwYGyzTv3PkdxV4dUQjzetL?=
 =?us-ascii?Q?f6ug++z0N6ihjfGI3s7lpXIrLZ00PKz6isJxLw3pO6DSidiGq2UahuvorjZH?=
 =?us-ascii?Q?zwcSd1XGbDTjy00Fc8b2U7rEoBL6Gf/hoav33jDLMinY5bsbG6jYvrCFM5jm?=
 =?us-ascii?Q?3GUaHqKpK1jH8+4FTb15AH39AZEKw2M5FNWfC/ZgHFtmqZU9daGAyBOZtkul?=
 =?us-ascii?Q?JueKS5+heeVgH1q00RaUxDzB8VeRqW5xpm0B71k4ePLMRWz46IB8e1OoeXg9?=
 =?us-ascii?Q?A27vRhL8lHmu8gidpuU94A0lZhp9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3583.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(13003099007)(38070700018)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HXLmyiNOYkrPd9MLTFnc3mCPeBX+dLZ0nvIxRRGERAWrzoX1xu3u9HeAIjNX?=
 =?us-ascii?Q?5lTT/in6F8TNlSjSm6D4DSt7TbNKXnHUUHG05/s64TJBpGkFwnL3SHQtRzB+?=
 =?us-ascii?Q?pzhcexwaejZxJtHrmQe+nly+v5odRmCpUbzLsyWxr6OKjI4V8jlItpSlsaag?=
 =?us-ascii?Q?PjdFYvWGUxFn9YrTWJAP9IM0Ti5U8jf2qp3kSMpUND7mm/CYj9bow5TQqSRt?=
 =?us-ascii?Q?3yeAK9dkpMQGcSk/Oje2Y/c7OrNlYegnhV1P/00H9CDDsXB07z6dRLQs6wT/?=
 =?us-ascii?Q?RH8AZ8Srb2caQu82kqmTloExYfAJuwjYpe/R3Q7D44SDXsHeOFEwHW08UNXl?=
 =?us-ascii?Q?/ukymkeaCU8f3CEmQ/x6LmoAU+KXp6fAfDSDLPRTgeTvvQMxdpl+LhdCslTz?=
 =?us-ascii?Q?TZ901VwyTd6LCUdc2KDmt2is1KnocESSPpqZKDsNWJrOWmNjfHFc0sv7RR7K?=
 =?us-ascii?Q?xV0KakLy6a0DNhyaRwYRyv7SmUneM5HF7xTAJSjca5rWmuAU6RIIIlh+U2L+?=
 =?us-ascii?Q?FhUAciUMQqmL0U4DgCwqro47aEb+oRMr/1QEXNPlKffPAT46kPqfpA1DU8Tl?=
 =?us-ascii?Q?GO9Oy9ie8TzmRupZsPaTIzUU0LsgXldR7rRkQV4RV400KlBqXBdlMuHP9XV3?=
 =?us-ascii?Q?9Ni5pGZVjYPvr3k0hIoTS8j+FwOe6Awh5XnNAFfmhmmSD7dm0MXxTaLNzgNC?=
 =?us-ascii?Q?ulhBJMgpNLTK1olM3tqaon2tfil7pV4VaPiZny5GRma5KYDuJNHjJD8BxAwm?=
 =?us-ascii?Q?JMEdegVAdTaI/kGNRy5BDk5Vt95OJoUBSRMtS8lEXRCgS8GNm4dXwjs0TGFs?=
 =?us-ascii?Q?+K8bq68cJ8YGQJ4lcBKk7JssrMOo0gT+EYLS9OSGkEdwMQdpHMC4zG4psheq?=
 =?us-ascii?Q?NxpqyLzJUzegm+3gwOTcqHIDxxjbXfOGlMYgCoduGO05OPkx5i5HvaFKD/ji?=
 =?us-ascii?Q?jclkrpfPVkIIRMEzzfcgDlVneCJJIg1Tqg/Y0hNyWjzOHk5TwWJMpNvJbqEP?=
 =?us-ascii?Q?GZhJeyiA40/qEm2FS9oCGkYSf1PxasU05b7Th1cDkLGa1iiZ1a03srzojoc8?=
 =?us-ascii?Q?T/9R+spRJ6R9933mrTWmzN49In8DMIP36fW3o/hf2KTy250sJ4RXsAIaHo5U?=
 =?us-ascii?Q?EbBOEcNGPjP0zmzM9ZCTYjftoiZSj+CMMNGR+MKCiGvNdPcEt3XL1X2vnpxV?=
 =?us-ascii?Q?ZtlJUVmw/rpGp9fvNhTwfTvKA7gSb7lG7ib+K0W3SuPJfbDQrBqde0fK5JQK?=
 =?us-ascii?Q?sjyGzIVbFB5Wpu7MY0jpWKrYq17yiaJHCgjwFr3olOqoP9tVQTNERPCNVbPx?=
 =?us-ascii?Q?gh1GJryRBUZwN9q9p0Cmf54WOmLXBAd3K4IwNTMXFOqX7xj16D900h2r3BNO?=
 =?us-ascii?Q?VbSCqz6wu9lUlQWjJZ/vyBYKQ7BfSGS1KpT3HzS01EIJtBTuPBsdL2EG7PSn?=
 =?us-ascii?Q?meTxa/kVo9N2m7i+5cPQharOUAdImNvAJUpH1DwStoOAikFzLVwtnskmvARp?=
 =?us-ascii?Q?EqaYyBRjW7sU/R82J2vQUezmQRGMk2a/uBDwPinkkqOIzwHzSa/LtQtmeqgJ?=
 =?us-ascii?Q?TyCqyLiBCKXIU8oBc4FPpaoO8QI4HyNBFR7iy5td?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3583.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f310f1-77f8-445e-891e-08dd50b26177
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 06:55:22.5880 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qiLI8V8zCtnMmsA6/JQfA0xlhO9BtDaSCKjZ29FQK3o/o5YJvkrJkAjDrGSPWlJTbisMEM0vmKkn9lRN/JNzPw1OqqqyFl6YXcU3MHgwbCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6377
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
Subject: [PATCH v2 02/26] arm: socfpga: misc: Exclude Agilex5 from clock ma=
nager base address retrieval

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>

Agilex5 retrieves its clock manager address via probing its own clock drive=
r model during SPL initialization.

Therefore, excluding Agilex5 from calling generic clock driver in misc driv=
er.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

---

v1->v2
- probe from DT for Agilex5 clock manager base address
---
 arch/arm/mach-socfpga/misc.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-socfpga/misc.c b/arch/arm/mach-socfpga/misc.c in=
dex 9d464307665..fbe3af845d8 100644
--- a/arch/arm/mach-socfpga/misc.c
+++ b/arch/arm/mach-socfpga/misc.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- *  Copyright (C) 2012-2017 Altera Corporation <www.altera.com>
+ *  Copyright (C) 2012-2025 Altera Corporation <www.altera.com>
  */
=20
 #include <config.h>
@@ -248,15 +248,16 @@ void socfpga_get_managers_addr(void)
 	if (ret)
 		hang();
=20
-#ifdef CONFIG_TARGET_SOCFPGA_AGILEX
-	ret =3D socfpga_get_base_addr("intel,agilex-clkmgr",
-				    &socfpga_clkmgr_base);
-#elif IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X)
-	ret =3D socfpga_get_base_addr("intel,n5x-clkmgr",
-				    &socfpga_clkmgr_base);
-#else
-	ret =3D socfpga_get_base_addr("altr,clk-mgr", &socfpga_clkmgr_base);
-#endif
+	if (IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX))
+		ret =3D socfpga_get_base_addr("intel,agilex-clkmgr",
+					    &socfpga_clkmgr_base);
+	else if (IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X))
+		ret =3D socfpga_get_base_addr("intel,n5x-clkmgr",
+					    &socfpga_clkmgr_base);
+	else if (!IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5))
+		ret =3D socfpga_get_base_addr("altr,clk-mgr",
+					    &socfpga_clkmgr_base);
+
 	if (ret)
 		hang();
 }
--
2.25.1

Reviewed-by: Tien Fong Chee <tien.fong.chee@intel.com>

Best regards,
Tien Fong

