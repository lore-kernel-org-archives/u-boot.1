Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E90CF6ABF
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 14:14:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 034AC841C2;
	Thu,  8 Jan 2026 15:14:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="HajWLloT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AEBF841B9; Thu,  8 Jan 2026 15:14:03 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 516EF83B72
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 15:13:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xba82wJUEu+SI0sd7UaHb8DTx9GvaRj6GuR5m6sZLxW+ZzF2+eSIziV/zDK6sD/IJwl1D/mqWMy/Og2IWhvPZ+KVzFL4lbtqj0C4qneC4DfKTthMz29bdkOf3xUrcgCoz8LrcEOAk4Tgjdvn61TkBsmkst34j8R8vGsolxCwAbN+VhCN5h62mkn7U3pIfiMKBDuguR+uZjEEqCR6XaHA5+anOipV66FNIyzRrxLJDW+YO52L4LnB5qnc1cwxDx+v9aLwHqFbk67tRNB0OYOK7kr/tNLfMSTHrRepVjBLxYZ91/8648hRLCN7Cd3m0ULmSpQVnCtnnYpDbEb5bNZcGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XK1PEZqlYl76g+OMNrt1CiK/GtIq152k+2s/3/+ANFI=;
 b=Llf5jlNnkcSBOie5v7sSX9+H76YM+FnF+4xWuU5FXNZjwfxu23HTHmNBlAvb/91UhJLFe5fk/IVdF7tx5jOvwC+3ewKbYAfaDs0gNy2O0OUpsSw+zJXT7WnX5/tz/vyfCygM8rJZbxIozkNCH669kYm5jBkNlvF+9kRm++jCUns9TKaDlX325BDsUibKAm96Ms2qWUHW0ekjAdZKnu6Yucj3dG35MKCduwbXGOW5IO28tjHMv1dMgMMAWbnPdpP9qpOMCBhI28pdXqChzAeKBRbSxXgo8uzG1Krhdq8SiTGrWadI45a9L0ie+ckRdJMoPsTDRKAbBXGJ0prrnTJErQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XK1PEZqlYl76g+OMNrt1CiK/GtIq152k+2s/3/+ANFI=;
 b=HajWLloTi2+lNh5wRZewyeNtxretBGaXHyviY0eP9jfxwNNvne8auN7SU7T8EzYmV4MzAGtnErLQ6kb9JTuugoSyuUm5PP1zP8fiG7ojK8zLRoKFGdz2w6U4/2alNV9Z/BSmHpdT4qA80UM7bEn7wrJq54aIzFOVDUVlAQJSY28TXW4fa5+B2vpN0jmtP88zSJO389OWPWs7X+Q5Xbzv3657cb0pTH1UAgiX6it6jN6gFknnY0s/zMfyppTpDy+NoSPfakitq0yHWKlccBzquZ71HX2P5zF34V0MAWmuRI2HWOxj880AX7xpW5eacWopS/ReBzaxo6peJ/wbzri0mA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by AM9PR03MB6836.eurprd03.prod.outlook.com (2603:10a6:20b:2d8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 14:13:53 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::2e7d:3185:676e:2466]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::2e7d:3185:676e:2466%2]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 14:13:53 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: u-boot@lists.denx.de
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, trini@konsulko.com,
 simon.glass@canonical.com
Subject: [PATCH v3 0/3] UEFI Capsule - PKCS11 Support
Date: Thu,  8 Jan 2026 15:13:41 +0100
Message-ID: <20260108141346.1663305-1-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0P221CA0031.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::13) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|AM9PR03MB6836:EE_
X-MS-Office365-Filtering-Correlation-Id: cddff0ef-ba53-4969-a000-08de4ec02784
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|366016|52116014|376014|7142099003|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SAIKKlI+0mRMr8xSEAVhEKxarc04N9bBB3Y/vPNglUka07xcNSA2+NFOIjGQ?=
 =?us-ascii?Q?Y843YtQ3PQ6RHBOIXkRGcA4a4rNH9gGEv0198do605fJ/yKm4GVM/rDxsUQ3?=
 =?us-ascii?Q?nwSgkTGNo6OSKsNwo73VVLDhC+2q/ecOKNjMvWOQ9w3DvArzIMm+F3i/JMuJ?=
 =?us-ascii?Q?RY4iDYnZ3jidpTgHelaGjH+1arVW5lq2+t95ilgGpOrRv3JR82NFPh0O6hyB?=
 =?us-ascii?Q?ntNPsLE1/0i+1zBBwtYa4lylKQqWNchX+LGqFSHti704QrobbGFKX3+AAlaq?=
 =?us-ascii?Q?mdDSqVLUNgYNbXaYAyHWdbyFNxi9zaKY9yYEwpU5sg5D40AJtV4fjY8e9h8r?=
 =?us-ascii?Q?fF3xnhnFWF71/rgjCrfhsC05EVGU5Iy2pDCcOWHk5SFXgcYizfg2JIuidf2h?=
 =?us-ascii?Q?MCZqg2Fu6c2r+6ckIeFQ497A0l7XJ10sklddaQCfTQ8tBgrqJvz948pDm1rt?=
 =?us-ascii?Q?iARS1+VprzAWQiXKcMr7dFMF9B2rx4fjGYmwn72GpHwionghmdK26CLHk5K8?=
 =?us-ascii?Q?XRlQa6IDtURs1Yw8ZUa8HcnbMq3knEW/c6FmKaqcdnCIaM3W1mO9vLCl1zA8?=
 =?us-ascii?Q?vN9WUDQoGHTZhl0eFzfHKmAQRTSTqJcUPZPFPp2ZOMVMlAfFFCOtOBx0iVH5?=
 =?us-ascii?Q?3ua62lFwoHoZkmZtJnGSsa5Jqo24DOKlr+SD+qo1XZjBP9T3ZML2bo2qXw45?=
 =?us-ascii?Q?qlbc7lbbOMmZgjnXjkd6/V/iVF1Hb7/BlM0HV0ejPbNAfRNigXcybo0YHq9z?=
 =?us-ascii?Q?q0zOpXAO8PaT77k3b1Mu3SC2M8XZ2toG8TjYMxDOaUn6Dm7fJliwe07rpUn5?=
 =?us-ascii?Q?0pCAtoipM2hRqs4bXKcD3EWyVRPnds6R/T3r1WvD7NwSWGNVblZSpy/RdRxo?=
 =?us-ascii?Q?4OA4WFfN6aN8alzkDZ8VnCj6oKxP2ZdXL8hfaQCI9o4zwKjcufX1b6l4qf+E?=
 =?us-ascii?Q?YCKdkxZg/W4AZVFiVXuOrSvSrUB73mE2TsEy/e2rV4PEQgUNLZuUKcdP5/vc?=
 =?us-ascii?Q?puAuSCM92obJM5WaJ5/E5Bj8K34hMISxanbOIajppM3p/Uimf3cMf/9F/Qta?=
 =?us-ascii?Q?sC/yUdJtmrvqgUPMLoJcBejFUf7y7pUpopLD1IqVv+W62QA+EbVo6ETgBo3L?=
 =?us-ascii?Q?vm1w166w4x4nL6XIjjkZE0ERj9RLGvSephkpu7nybEnKOUEWq/YLE271Rwht?=
 =?us-ascii?Q?7Em0HV+GDvcuMTFeqbiwPr4aAYaPIQkxJf4rw6/LsS+Wz7T/GL0DbOgF/nuU?=
 =?us-ascii?Q?jAd5aeQ65zvlYKKFphI/VNdOAaYqqx533q3N1kZWcd/WV2TMsJwUD3nFiK/1?=
 =?us-ascii?Q?gLvLTLw6vozmCZYwLtC78CmdCxqOOH1Eflx/loPHzvM0p9ajU+wPYNOX5ToT?=
 =?us-ascii?Q?90GfOLNDEa9ZqnISxxZtwsoXaiCwgbz8s1Qg1zKleBOzXFRvz2jXxqXOCRhu?=
 =?us-ascii?Q?v4blPEhIn1Kzvzmpwgm3zkZSbRPriZetGnijUeHt4/pPhz2zOgDH/NuPaGH4?=
 =?us-ascii?Q?RcJcR204yE0dnKOLSOlXE1D3sPBhgECs2KsZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(366016)(52116014)(376014)(7142099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PX0WjZe6QZEciYHILBvlH1aI+m995OYTwTDyNvYsf8iY1dYdMSBN+ttikxvy?=
 =?us-ascii?Q?UUk/b5Fr0FTNPdkCHN94IEAFoqwdqoSsMsMNQT+eMpVCxKMfUvQvxRN2eibr?=
 =?us-ascii?Q?N1NrqFcZr1Tq4Gy4oR1px7anTvwEqoYD5Rb9zBlK1K7dwW9jFXXjmwPnQrA+?=
 =?us-ascii?Q?AriE5p3awsNssUqe5EJr4Af+lNaOOjqKI3gKR3Umm3/hPlzt2WHiy0tGEU0M?=
 =?us-ascii?Q?3SJuHvVs0OtFeq1MqzMw9RTmLty1iV5NCHeh/SwM62xaR4SIxFZR8a7RVd7s?=
 =?us-ascii?Q?f8NwNyr7dO34dMtzaYPr4mV0KsC3VeycvtdKEmc2LrZLzEMXcjwncGMvfzw6?=
 =?us-ascii?Q?BdfNlubXhl1QQKQXLhWaWFUqNA35mF9Xn8jAM5xLSxpKjJUrUZtV0kiRUB3j?=
 =?us-ascii?Q?lh/9AhB2ab5XDFDQdYggKVBaiAaIzNejP+2CktB28IJ6xNXBq5ANP7s2mRti?=
 =?us-ascii?Q?I0+KiBTwnMaEVFZhl29hCdb3OdQh7l0iO8dSiEZUQ/T4yeYDhwd6IF0aIeGn?=
 =?us-ascii?Q?TeTKug7nir6T5iYAIkDewntHVg2TzE/mufRWjGlLwi5+asv2F7gh/bvhNFDl?=
 =?us-ascii?Q?olYR0gVvcvZjG0IjTmcV9Jq5lkL5RqYdrmRMykHRjhtXZvFDAs7lO9bvKifa?=
 =?us-ascii?Q?TJ3bFPgjqoxegjiADp5rgSZp8lhMlEC+h33X78hA/BVO6I1ppv8RE2boddJO?=
 =?us-ascii?Q?B+jap/K8i+FS1DqM8POpJW53alfQq6zVh6Qv5Qv+1GaHmajmkTcYuB1ezyM/?=
 =?us-ascii?Q?ff1/XGN1+Xr46NpvhuO/D8HSXetr1CaovxyggHqxYLw8hhVKZvym4e1C7x/j?=
 =?us-ascii?Q?9uHIz8Qcat2Li4ap3h0OMzhN6vM4JsWJarN3ViRbnfFfLXlO3CUsXkb5g35D?=
 =?us-ascii?Q?6WlIFeXnonixZdMUTKneYTy4rSUCLX0tEPeJkea6lTdXWxTLfL5ycwlyTLdS?=
 =?us-ascii?Q?Ls50K03rvs4QYfc6ZihUryfiSpnh8Tl5qrQ79f109LQ0lRsHKoB+G2pC/EmN?=
 =?us-ascii?Q?COmboYJW/m5X3C9R0/mbGQrvzLVddsYzO72mAG9FRVED1OkT61eAszNHm7AQ?=
 =?us-ascii?Q?vEK3Uxav6nxsrsY54e2MHJmrUfH1l/3UDgi5Qi4jqyWTjW+acG0rbNq+oMCw?=
 =?us-ascii?Q?FHN90FtC1EZXkFVTZ+yxU/YxMsfVHTrtKBGVg1fGZQC0t2MRohGB4KPwl5TU?=
 =?us-ascii?Q?0VVX+uULjddPjIo5H2VI3GnvV1IV718YodGhZpDKyU7Cytc+HxgaSddQap0K?=
 =?us-ascii?Q?Bqk2b1YBW0hgUHNcogwR9wzvhyY7Kh0IUIAc+Mc+vgP4a7c82UUSLxn9YbGR?=
 =?us-ascii?Q?oMojoSIpYHjLbDi7cx5YKxbymShFwmyR0wFhio+BGBNOHT1osjLduX4U9xQT?=
 =?us-ascii?Q?4orhyAueRWsd36dZsw+eu6M9cXzGd7UsDuOfStUR2w1E/Euz7EfBGobjTZuW?=
 =?us-ascii?Q?BNVhJ2sDOuww5ONHp+jbG14Snn1X/H6xQXJSVbudOKJRihWSl2VLXwlrh8ne?=
 =?us-ascii?Q?UvnYFxGG+/1/0h3O5tbBWptjKK4iMirqTeA15px6nqQRH1/0xYfQSg2ANhAj?=
 =?us-ascii?Q?9COsX6ReV02kw92sqo4m6OqwlZ4gFrLqH54Wqu2TjJZGN8XzAyIur8BU/F0x?=
 =?us-ascii?Q?0KnbJ/6ZvPQX5HsqHiJN7nqDKAriQYrItSH8jD1a9h4qB32dR+RQfMhtJkfF?=
 =?us-ascii?Q?v9PM8hnBuiah0PIVR52XNWKl9dCHnblYmIaPixAz++HTSwAQxFduKnj1jJfu?=
 =?us-ascii?Q?rAfzG2H50g=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cddff0ef-ba53-4969-a000-08de4ec02784
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:13:53.7789 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NxDfyAqwK6/KRmoF99TFGlgpb4GlcBkPNRxUP/TcfO1BaCxJb6wV3tG2K8OzIfqRqVomiqBhta+au6GGFSRkHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB6836
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

Add support for pkcs11 URI's when generating UEFI capsules and
accept URI's for certificate in dts capsule nodes.
Example:
export PKCS11_MODULE_PATH=<pkcs11 provider path>/libsofthsm2.so
tools/mkeficapsule --monotonic-count 1 \
 --private-key "pkcs11:token=EX;object=capsule;type=private;pin-source=pin.txt" \
 --certificate "pkcs11:token=EX;object=capsule;type=cert;pin-source=pin.txt" \
 --index 1 \
 --guid XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXX \
 "capsule-payload" \
 "capsule.cap
Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
---
Changes in v3:
* fix write file encoding, env setting and extra line in binman test
  after review
Changes in v2:
* allow mixed file/pkcs11 URI as key specification in mkeficapsule
* fix logic for accepting pkcs11 URI in binman device tree sections
* add binman test for UEFI capsule signature where private key comes
  from softHSM
---
Wojciech Dubowik (3):
  tools: mkeficapsule: Add support for pkcs11
  binman: Accept pkcs11 URI tokens for capsule updates
  test: binman: Add test for pkcs11 signed capsule

 tools/binman/etype/efi_capsule.py             |   8 +-
 tools/binman/ftest.py                         |  42 +++++++
 .../binman/test/351_capsule_signed_pkcs11.dts |  20 ++++
 tools/mkeficapsule.c                          | 110 +++++++++++++-----
 4 files changed, 152 insertions(+), 28 deletions(-)
 create mode 100644 tools/binman/test/351_capsule_signed_pkcs11.dts

-- 
2.47.3

