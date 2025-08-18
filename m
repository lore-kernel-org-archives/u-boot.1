Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E22CCA0EE4
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 15:43:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13A7F801BE;
	Mon, 18 Aug 2025 17:43:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=keysight.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=keysight.com header.i=@keysight.com header.b="qRRcNemn";
	dkim=pass (1024-bit key; unprotected) header.d=keysight.com header.i=@keysight.com header.b="by7X8Iph";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70B34801DD; Mon, 18 Aug 2025 17:43:20 +0200 (CEST)
Received: from mx0b-003cac01.pphosted.com (mx0b-003cac01.pphosted.com
 [205.220.173.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A29180107
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 17:43:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=keysight.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=john.ripple@keysight.com
Received: from pps.filterd (m0187217.ppops.net [127.0.0.1])
 by mx0b-003cac01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IDLRYN028825;
 Mon, 18 Aug 2025 08:43:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keysight.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppfeb2020; bh=
 bQLbiagjKIPdMzp7d9ULHWkhnFfvdGy3Rips6BEBhWI=; b=qRRcNemnfd6rD2Jk
 B2mbFf6VY/sbAN0HVv2BJV9iwO//ZpMLxMNdyUmDrFvEjEs7uZWeUKq4HTtzuglm
 NoH+w2Y5L41pawIUQcDTMUsnbRuaZdZezGo8asg95+X0r3dXqYxzE2IjFtvt/qEy
 SM4PvXRG+XLnqVqQlf0cQBCWDTXOpNDtGlqDndbK7WbVIoO1HbgsBOB9VPW8jHXc
 fi4THMtiLi0qx4f0cY5ZYrthN8wzCrFhRj9LRa/vuzCZW/z7eWESAHiz2efGWu2m
 BNeDx2hbmVFv0GycOC22Kg0H9oxLkhWAL3Tt2s2gMMfiiZvF60mZi3aEShZwfCvp
 YgFBdg==
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
 by mx0b-003cac01.pphosted.com (PPS) with ESMTPS id 48jsdekvp7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 Aug 2025 08:43:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9EazKH8o6fwb/Cdl/8py7ew8sfHDaH+lMdXXv9Gd48D5MvV3h4c76RThz1q7hX4RfPG9LOwvdqDGUWgI2g2LL/ThFdTq0nxSzrzSlz3GCDSTWKaBDoCnm4gw8XjYpQwBsGtwPw4Tc+PjL7cZdGi0BimG8QHOESX+dHumwUwlKEhH+ov1jEMP+NNBfwtro5hizHoINJqfBRwu4RdQEF328/OMqx0BRatrSAbEBg0QoIbhB8SO5t+XeAz9OAQ2pcuczZa5txOSs4tfftuaZ43c+9pCgDL/W7MLXJmQ5zVnV3+0Ae+4B+9+p7lmjCzSBMqIfUyOcX5eitlIL/+CCQhuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQLbiagjKIPdMzp7d9ULHWkhnFfvdGy3Rips6BEBhWI=;
 b=KPQIsvnz4PGYWuzklU1CUcy3cADml00yGHIiaGXgQpdje6kdeg8SgSoHpEU69mzI/xSgRFycJVD9zb4vAuU8CKOMqmWZWWSDf/itBjwT2EacOsUXnEGROQUey2Wn29lIiacpslcd7XnHnf+MTT+4nTW9huP03VpO/BA3xTYAhVLIKvXJIdbZLWU66fnL5PGo4ZGn/McK5uxEjmUyOBtARzV3/u91Pde90vcTnMYa5KGigvfjZRPOHyCv2S3x5gxLdMMXPglbZ4vpTy5RGkAViMnMF354w+qbHjn+7WSg0AEiR5BQPHn6Hjey47uYBHcBjakFd1EYtt5TIXaoOE3+kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=keysight.com; dmarc=pass action=none header.from=keysight.com;
 dkim=pass header.d=keysight.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keysight.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQLbiagjKIPdMzp7d9ULHWkhnFfvdGy3Rips6BEBhWI=;
 b=by7X8Iphnx7S/Xr1xeJ+qh1naILJ47mnEEMhKKzguKgvZ29aZNpVPaXXG+QioQiHdh8sChWu0BzFuqiiCyxVXM9NDEIQZ+hc1VkJYm2IOznLEccyFHCg2ovoOpvCt4ve6oFBecpGcDfSl2coV1jIDPwF6F8cm0d2X5r6pwjHRt4=
Received: from PH7PR17MB6130.namprd17.prod.outlook.com (2603:10b6:510:1f5::17)
 by MW4PR17MB5729.namprd17.prod.outlook.com (2603:10b6:303:12d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Mon, 18 Aug
 2025 15:43:07 +0000
Received: from PH7PR17MB6130.namprd17.prod.outlook.com
 ([fe80::54bb:3a4f:5f80:a51e]) by PH7PR17MB6130.namprd17.prod.outlook.com
 ([fe80::54bb:3a4f:5f80:a51e%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 15:43:06 +0000
From: John Ripple <john.ripple@keysight.com>
To: Peng Fan <peng.fan@oss.nxp.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "alexander.sverdlin@siemens.com" <alexander.sverdlin@siemens.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "hs@denx.de" <hs@denx.de>,
 "uboot-imx@nxp.com" <uboot-imx@nxp.com>, "peng.fan@nxp.com"
 <peng.fan@nxp.com>, "sr@denx.de" <sr@denx.de>, "sbabic@nabladev.com"
 <sbabic@nabladev.com>, "trini@konsulko.com" <trini@konsulko.com>
Subject: [PATCH v2] imx8: Add ahab_commit command
Thread-Topic: [PATCH v2] imx8: Add ahab_commit command
Thread-Index: AQHcEFbKaTLhu4MGD0qUcruz+WTkNw==
Date: Mon, 18 Aug 2025 15:43:06 +0000
Message-ID: <PH7PR17MB6130C51E350D1BF8AD9332EE9C31A@PH7PR17MB6130.namprd17.prod.outlook.com>
References: <PH7PR17MB613046F296E7C25AFA85DB7D9C54A@PH7PR17MB6130.namprd17.prod.outlook.com>
 <20250715034758.GA632@nxa18884-linux>
 <PH7PR17MB6130D968EB14FCDEAF46BB8A9C34A@PH7PR17MB6130.namprd17.prod.outlook.com>
 <20250818043344.GB13772@nxa18884-linux.ap.freescale.net>
In-Reply-To: <20250818043344.GB13772@nxa18884-linux.ap.freescale.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR17MB6130:EE_|MW4PR17MB5729:EE_
x-ms-office365-filtering-correlation-id: 02dfc087-bca8-4536-8f4f-08ddde6ded36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|376014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?cZh8dVTctbj2Zjac4GwwUK1E3UbhPi8KOKw0W6wIIdYJFryNPPPkVXNkAA?=
 =?iso-8859-1?Q?hB9JZbf5XmzicHVNWUSH3Vd9jX1DjeSZW/XYepKXeIC6Vm+ZL5x7AQaW5u?=
 =?iso-8859-1?Q?1rJhrb/XPBb1yNOy1k/no2ACOKvgo+I5TKrl1xjp1/NQ1El43DE0bz/mZl?=
 =?iso-8859-1?Q?vn/ityLJmqWa/Y0jHTuFzWnHcYjGnhBZsCY2NeSj2gk30XwaWPeL9ogdib?=
 =?iso-8859-1?Q?9GjScCYzgGCGLrOjTLmxWctLXIk8yusNuLbeqhbUjlhyeyhc8BTbjd5OvN?=
 =?iso-8859-1?Q?A800xamHXNoeW+QmHPAUYeYVQ87plGFtHc7sjJtHagB2Lgf/OVcLcISaLK?=
 =?iso-8859-1?Q?3op3Vu0Intam+ZKazSpxcwToVPecFd21iJJ6vl4hBjatYhZYpjCWTvyMm3?=
 =?iso-8859-1?Q?iI3r1fZ5yrSLXf2nxjxOZ+pKFwz1Ny+Cx+GnpG15rIWNcGzQOHQDuhFwsF?=
 =?iso-8859-1?Q?QSOvBWSS0KCGlzn9XRWq9k5KCBrpqw5F1k7nzB8NxNSx3x7SyGFYYIGi5V?=
 =?iso-8859-1?Q?BvoQqCuG9GrdynyeOYhlU109C5VKlIWgrh/PM4beLQL9/DiCi2JO2is6/l?=
 =?iso-8859-1?Q?wcmJgUG7Ry74JEXd/WVefW5ySq+NSss/hFLwODmFgSgY9BtVImeXT0Wz24?=
 =?iso-8859-1?Q?kn3q7hK3W1c99txoLRR9zqCG1/KpetMg/9x8QwGAVZHilnF+Ht39LODoPd?=
 =?iso-8859-1?Q?BoZZQC0ydfOE99Zw5vQRlYaEcAvHOBCfcTXZ49KsCLDWEXL5s9zyCKHdSK?=
 =?iso-8859-1?Q?OPwAWZKjn/XhBjuWo75BhTznBHiPzsRum1SCMqDIWes272KK56MpTy4kNf?=
 =?iso-8859-1?Q?upla44L7IXGH1cUV9pUidvj0p6iW32YG6poPfXIMMuT+PBhZukFmgNu7VB?=
 =?iso-8859-1?Q?ywXMdsrCeXkjl5ZzNsPsZijEf6WDwbpRiOtG/B8QamEDiU8xHnoJfSCqmp?=
 =?iso-8859-1?Q?y+JHsoyQtIT6BdPt2U9I1t/ti9bIG10LgawTLgdJiZBViSkwzUqBBFWhDH?=
 =?iso-8859-1?Q?A93IZijO3cIL/LXvz8nOUmwQHkrCAjmfLalRSX2r1JMpVI8UjVj/ARukRH?=
 =?iso-8859-1?Q?u0NY6qKEU7lDSG0pTJiDHGIxX+shHfN/IFmTrgdAC37sr7jms4bCViM3mc?=
 =?iso-8859-1?Q?4XF/JbbRezamKLfhCtUugFvWo89Y5Nh0kzO2v7IwAitQen0Nfahky/F2gF?=
 =?iso-8859-1?Q?LI2C/pTp7XTW5CrlqrtLHDR7/UNfSYNxLsTS/9jFnZrW4tT+/Zod8uZIT1?=
 =?iso-8859-1?Q?VK0j7bY+BalVGuOm5mLCI8pqOjOYBT9m9jeyTXf54Fhil8bnw+Eqaf1Tfz?=
 =?iso-8859-1?Q?rBIPMXxu0UxMvVkQBi2nOK5csrLeUwYXc+0hTV6VKgRctAgtTuJ0ZH1ea9?=
 =?iso-8859-1?Q?jjCsM9TKALYRN8Zig0fGgFE8CBHNiFGvDr7c4dMQReSsTgT+j2NdaK4d3C?=
 =?iso-8859-1?Q?MN5Rtzwtvv3YZX/LyyWCrMreM9UO+243K+u8RnRDbunKOzr90dynaznTy4?=
 =?iso-8859-1?Q?1ZyumtPi6HR0X77IcDNO5Cw20KHH5ei5X/4QiT15gYCisSQxo+60gXDMjL?=
 =?iso-8859-1?Q?wauxn0U=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR17MB6130.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?brT5o8D01Xys8se7hNc0bv9/RRJKMDhL4kn1vm/AVA9K0BuFht0w7VpTCf?=
 =?iso-8859-1?Q?Xai9usRCO7y4x+wwjQ3++kJfONNOlRBb/M+OhxMBmYo/fCDayH7Ok3UEP8?=
 =?iso-8859-1?Q?RSajtcFt8xiBaYW3BNWqRmgr5GuRIAyskQ+4As39S0HQW5quakoIGKgQ3y?=
 =?iso-8859-1?Q?z5yIZ2kPa0Fn2swprUgcQ1BueZWRS4mMT3JtuthHVtuewlkLOCU/lAT0e0?=
 =?iso-8859-1?Q?u/G0RuquhhJ919JzP02vsu5Pdd144b0u1hB6vG6hZn/rqjqlCMaZt+OiCu?=
 =?iso-8859-1?Q?k4H+LHWACb4tl/g6zVFWP5CiQn7wVFeVvhJ/ab48ZP3S791l3Nwn6hzZ21?=
 =?iso-8859-1?Q?0qg/Qgou71/WR58MBJFDzj4O1yTRILQj1rQpAIs20q4ssTXMjzqXkmGWH1?=
 =?iso-8859-1?Q?AI3ZWuJ7xL9/vLuU3tmBYbcvtMTAjYrbT+h0yCdybaEWx5rU6y9j8Zcpkb?=
 =?iso-8859-1?Q?4+EALAIXvoYmLpOePLpA0kdEMaF6c1T+2U7IrpocnMuONmG/0HvjA3vD/h?=
 =?iso-8859-1?Q?IhGhWqYzZmx6ww3eY6si1rhSmrtLVRvLRxOsZKDaAUpZLSLHiGYma08fQS?=
 =?iso-8859-1?Q?lvb3mGXOPPtaMnV7xZ4r+bge5yYRwsvx2CzorS9Vs1YUTbHfDZiai9/HA2?=
 =?iso-8859-1?Q?8e3fuzazOB4gf8AHogknjXki3fDNjAUsSwZF7lYJsC7Hv9VO0Jxfx/ck/R?=
 =?iso-8859-1?Q?1j3882nQsMCfh/6WZrdj1wrsBqJ3tLh8VEbc+ZzwUwDcY6w6PoR/YyE1Ik?=
 =?iso-8859-1?Q?j8X54R75UimKhuPi/T14k9kFQATLgK1fm1A7rGAmcioGPulNL5TbktyYl4?=
 =?iso-8859-1?Q?Ah++dcr35XWskSst2xEwKPSvXqs5QxVBOyhSWfhI8fFeCxJneiluKiIVPd?=
 =?iso-8859-1?Q?c6W86ThOjRs8LdLi2n+8IHs3qTsQQDav5xw2MhdQqytdC2GYoNbOBoupAf?=
 =?iso-8859-1?Q?mnReXzLyGVtJetojp72Z+GvAEarCseVfMVdhb2vKqJjxB7sIODEeVVmgX3?=
 =?iso-8859-1?Q?I7ffgMCNmAtPsXrJ8mKRLSvVEivJh25eI5juHLbPu7KFwWEtqRmgBltt3P?=
 =?iso-8859-1?Q?6Z2JH1C995I0bGomKhTXM34x3/Y71xvAis8ZCwgW6UuKi4g7ir6w7F7+cz?=
 =?iso-8859-1?Q?xtF7S1mbc/Q8SZd4mLTqSj+Uef6AF5gEPiyIgE6/tWW2AlW+YFYv8VoFEK?=
 =?iso-8859-1?Q?IIoHzL8k/JejozDmwD9R/FXAFyny8In/EokTjBEfobqilDXy0xmXx1hxvQ?=
 =?iso-8859-1?Q?sBOmU+hMlgBC4pqos6+293vESFKQcqgGhBvx1iAyP2oh72lTlTOxaCaB74?=
 =?iso-8859-1?Q?5iAd7VKC2Ys/3nSIxwXA1f7HUg7xIs8PgJAbAJWhTV2tGO55nZmquK9R/t?=
 =?iso-8859-1?Q?blhC1+0qZpp1gyz+37yBss7kX7AbYG+PsIr72SDXXYhBWSLXGV8IBfttOJ?=
 =?iso-8859-1?Q?qocE/LoQmdCr06qAWTcAfDiC6Tf2Ig7Q4clHiqc8ilydxT07G4jaMKLRx4?=
 =?iso-8859-1?Q?pxLvj76kjixKHm/sPk6yZjJbQXHgpDyTbThDBalahX9b4lhiPsWPPJSA51?=
 =?iso-8859-1?Q?S35tY7MHVPkbGdQgG4A6FeixhxvrFcVXXF//UOyGFq1UbJIx6IxEnBRW+b?=
 =?iso-8859-1?Q?0oVhfApB0/eGYOnGvkkWMZwub+EZuqoajF?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: C7VdraB3+FWHUbXp+U2t1RMu380o7+Ah6asp2qAmoqLm2A40uQvLjE4nq9FVrZ1Ww9884FldWI1n2+qCWKW94mlaaatsSX2sucgDro2t+gB23eDZqA3ehr8q++N2awivVQ3flOmW83GhSmJ2zXashGEjb/C9UIYAz2O2wMhrDie3y6BU8pK2GdIZV8dDDHYEjYMyu68YjRgL/xrSlEubpvj4X2aZhOlwYxoUyr6Ascx/V6IIVoRX+6GQqr122K6e/v7lzqVUt2WlC1WMxe6Plwa4ZFthyEh8M2cqnC6YpiZrTUnewG59Hmy4FgVRG67MYK9bBsw7Y/Dg2BliFvfH/ErKY8pRuACm/cqL56B03Gdq+HOu6HNyZ1bKGNs4usacLOgBh1xpd7/0ECps3l007W/rPnspfdJtxYRqyWZ74W22oWj2BdguJXnGkGRf9A6eL9Zg5TkI1+zEC2ZGLpULURRxBHiLNuXyq3BVuD42Nl5iqCOF8Fp1VLM+GWNo5Iu7V/2aChKx57IOgeCb/xa/IYochYN9/dLfgezXuMwfzu6MO7Ou8dbH9t4+CJkOAo5WKbNIkRBoxfRL9BcEX0ulf7eX6awUdiknmBj4LlisBJ87/tDiFMjB/oRvnVVaVv98
X-OriginatorOrg: keysight.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR17MB6130.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02dfc087-bca8-4536-8f4f-08ddde6ded36
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2025 15:43:06.8583 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 63545f27-3232-4d74-a44d-cdd457063402
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uygyHvwfsOZX9c8rGtKc0zAzPtpkHH9MZh4M51lH5pYu7l9l/bzrMdyQimXBidMvGLAj6y0Ec1Dd/nD8RPszZl2m0njMG5/vHWDTSp7tdLs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR17MB5729
X-Proofpoint-ORIG-GUID: -jH72eczAge2YUHd4KIYtzMn961Y8XFB
X-Proofpoint-GUID: -jH72eczAge2YUHd4KIYtzMn961Y8XFB
X-Authority-Analysis: v=2.4 cv=Atvu3P9P c=1 sm=1 tr=0 ts=68a34a0e cx=c_pps
 a=9Z/P+5NbejjrJAhA1Wx8OQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=2OwXVqhp2XgA:10 a=vu2TTH8h0NUA:10 a=F6MVbVVLAAAA:8 a=P4HF81ESsl_D9sKPfAwA:9
 a=wPNLvfGTeEIA:10 a=6mxfPxaA-CAxv1z-Kq-J:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDE0NyBTYWx0ZWRfXzgtpu5pDtZjb
 7GIeCTfVFvNxseomBRIUl0rspDmDg6YkF4IRd0p42kIm3bmU1W5W5vAdxMZNzywXskW/IY7BMjQ
 dWZ2BysXwh5NgFkptZwyHVUaVJfpwL29KrQQv3m5U9HjoSLRnVfBB012G6gti+d9SxIQN8P3w61
 Nt1mn/XWnJ/Sxt5LVcEbdeNGbFztjh4OP37kfLm9RZ4KLR3hfPJGzlDfoSSPtJWdvS5TKFoL64G
 QgDnJFRUnLGuFJz4rS1eAfHRDZGm6HyKxnQwzOXzWgRqVR3AvA5bVbnAxNJ0NdnfvvfBIb/TDZ1
 m6wJhJpm5JFpsXyRjQtLIi0PAf0B7cu+4mbWMCGSdQT5O4B6ZUfES9i2cWWmQQKIcMld2cjlk8Y
 0nHzICL5plCrujXG3iFaEw6Tz8LDpkl1j5rsZGCIL/oHwkBODP4THwpeKsLhqaw5rnn2JBA+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 mlxlogscore=911 phishscore=0
 adultscore=0 clxscore=1015 spamscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508180147
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

>>The ahab_commit command allows the user to commit into the SECO fuses=0A=
>>that control the SRK key revocation information. This is used to Revoke=
=0A=
>>compromised SRK keys.=0A=
>>=0A=
>>To use ahab_commit, the boot container must be built with an SRK=0A=
>>revocation bit mask that is not 0x0. For the SPSDK provided by NXP, this=
=0A=
>>means setting the 'srk_revoke_mask' option in the config file used to=0A=
>>sign the boot container. The 'ahab_commit 0x10' can then be used to commi=
t=0A=
>>the SRK revocation information into the SECO fuses.=0A=
>>=0A=
>>Signed-off-by: John Ripple <john.ripple@keysight.com>=0A=
>>---=0A=
>>Changes in v2:=0A=
>>- Changed patch name to have imx8.=0A=
>=0A=
>Please address all comments in V1.=0A=
>=0A=
>Thanks,=0A=
>Peng=0A=
=0A=
Sorry if this isn't the correct format, I haven't used the U-Boot mailing l=
ist before. Does this patch heading look good or should I change this to a =
v3 with a new thread?=0A=
=0A=
Thanks,=0A=
John=
