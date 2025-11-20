Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD1BCFA447
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 21:04:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C5BC84118;
	Thu, 20 Nov 2025 22:04:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="vZWVcHip";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1C618410B; Thu, 20 Nov 2025 21:36:47 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2520984127
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 21:36:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrian.freihofer@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DaylCZiiR+rqUaUI0nMN97rOX5QNqkjsjBWM8GO8a6f/nrZqNTme0Kd6yyf2mn5hahpFlgMTRcAF5AUxlFjuIVAKmTBvAxyN/znGhe9/VPS5DtEG7qLy2fHZg5uLwIM4PzCRnoD+jZfGnFu4QvewmkJFPM4nyd2/ENBCcBqwZyzrV5/vyrMBft8VMfZfGu5kSG7MdNTTbujRocBDtQd6zN9eZTeKGdzSblc4jBz4/q542v59jKnseqxqAqlbnqxvEABmNsrhEPb1YnPUqd2AAz3uw/FXQYVfTm0d623uqRnvArlmjqgbBFlNKR8yLTANUvF0QMmH1SSKNUCueSyswg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2cm8jE6eOXxjYFUZ7hc7JKgz2yTRhVU4oJfXUT8m8s=;
 b=Wuw5IQx6EzGlVLulcN0QssvOjhvr8FjtBwMi05VMw7BGIN5q8MM2qwVtxSh18BOBgep2N4FgDpZQoClylV2/UPj7K38tPH9BHJ1AL1/656ilffe5ZnTEMvvKjgj8aTQOieA9jdiF9BJLGprsWz5ejGcrOILk6XNaXCkXt1uZUTfxOpfsk0xAAfX0B5KZEfmqcaxfZIQEjYr9u8sLrVJqCXV7tm6uXuJVwtb9Frc1Ddh3RbOucgKdd47wii8XJviuTbwVMb3tnHqRVOhaUbA4agudEeY9VSU0nb85Yf5TDNFTjpyk3qpu2rvn/0JVVYJeOlIEO2PgDliOLKSIHXBhKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2cm8jE6eOXxjYFUZ7hc7JKgz2yTRhVU4oJfXUT8m8s=;
 b=vZWVcHip7+cnDNqMpvfq/bqqMEJiceIwCDmO3MMbabDQZhppHHMf9l+AzvgfxMmxvKL9Cc/gGLqI3ebjVfoCMmp9LcTVQi5iIPSJEmCS3LGzyjKkQ5T8YaH73NHC0E+bpA1LPA/O8W24u+qK/U8n4Jofy3iQrXo8t1JzAW8W5eX0FswfzaTqic4nl+w5fQWJMdUu7BlN/iXGEAmsva652GloPXRkt6/pHSea86stbWX6lQDeyBmMDuIh6OwNgYXnr8WoHgpFNorp2jucJEW7Spa78LIgX2ZA2HmLSouExDnxscW2ZsLdqu8TNIxeArSU17BqCvxmLplaDw+9G64iTg==
Received: from AS1PR10MB5724.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47f::8)
 by PAVPR10MB7538.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2f5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 20:36:40 +0000
Received: from AS1PR10MB5724.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::50:b275:11f4:adef]) by AS1PR10MB5724.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::50:b275:11f4:adef%4]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 20:36:40 +0000
From: "Freihofer, Adrian" <adrian.freihofer@siemens.com>
To: Heiko Schocher <hs@nabladev.com>, Quentin Schulz <foss+uboot@0leil.net>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Jerome
 Forissier <jerome.forissier@linaro.org>, Jesse Taube
 <mr.bossman075@gmail.com>, Raymond Mao <raymondmaoca@gmail.com>, Patrice
 Chotard <patrice.chotard@foss.st.com>, Yegor Yefremov
 <yegorslists@googlemail.com>, Eugen Hristev <eugen.hristev@linaro.org>, Marek
 Vasut <marek.vasut+renesas@mailbox.org>, Casey Connolly
 <casey.connolly@linaro.org>, Neha Malcom Francis <n-francis@ti.com>, Fabio
 Estevam <festevam@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH 3/4] corvus: migrate red LED to the modern API
Thread-Topic: [PATCH 3/4] corvus: migrate red LED to the modern API
Thread-Index: AQHcWf8Hlc6NRhBOFUWQB5QE+hzAsLT8BiKd
Date: Thu, 20 Nov 2025 20:36:40 +0000
Message-ID: <AS1PR10MB5724D74719D27B60647552D28ED4A@AS1PR10MB5724.EURPRD10.PROD.OUTLOOK.COM>
References: <20251119-corvus-led-red-green-v1-0-ce86b8d59dfc@cherry.de>
 <20251119-corvus-led-red-green-v1-3-ce86b8d59dfc@cherry.de>
 <fe01abb5-5a9e-1e3f-411a-824d223f074f@nabladev.com>
In-Reply-To: <fe01abb5-5a9e-1e3f-411a-824d223f074f@nabladev.com>
Accept-Language: en-US, de-CH
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=True;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-11-20T20:36:40.270Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=C1 -
 Restricted; MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=1;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR10MB5724:EE_|PAVPR10MB7538:EE_
x-ms-office365-filtering-correlation-id: 4dbc33e0-1ed8-4cd5-404d-08de287482be
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|10070799003|376014|31052699007|39142699007|366016|1800799024|8096899003|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?kCQEpg40z01lCxwxQd0PBKniK1vf4JROuViHR9gVIlrzB3QJG3yu7L2eQD?=
 =?iso-8859-1?Q?Ihh6WSmvgsYK5RuxLDYfIn2rD1xnAs/pnjpQMc7jhdvumf0Zg5ViDeUR91?=
 =?iso-8859-1?Q?hAGbNgEEvw0et52/QZWIxGtMUuMmbcnFJ03iYNu2ZegpZaHx1bvw3Hpr83?=
 =?iso-8859-1?Q?jeKQEA0UfMxhF0tOt7lihZ0fMNywgGQX9h9qiTM6ZPEdvuNmrk5st0OP0y?=
 =?iso-8859-1?Q?2eVDfKGrFHBJLv8FpDyuuKGQTCEL6OYpds7MJTuUm6jA/+Gjy3B1iOuJQo?=
 =?iso-8859-1?Q?xvQwrTvmdN7lg5787JLI0ZZC2bJu6U4naquwnaQs/NFHAjuADe8T9PoyOA?=
 =?iso-8859-1?Q?VRT89tLyorRAMVK7xZ+bEEramNBss0DNmrvphQvQjIDDz5MUeS/j4jT12c?=
 =?iso-8859-1?Q?wdrOsY68a27tGgmUMzonuB9dFjpzoMWKvPdRVTvzoIR8NYnajzKcaD1U/8?=
 =?iso-8859-1?Q?VJdvkWTSoz93OgQCC/xf20vLTXCPue5G9STnCiJLjgUWuXWFfz6BERASZp?=
 =?iso-8859-1?Q?sY/b4KTHfFlrz/9ZO4SO8RQH9MQ/uo+3Pwu9O67NiGvevHpmutjhA8+Jaw?=
 =?iso-8859-1?Q?TOSLhO5v3recKPcWW3Hk06EOBFMcpHzmvpt3QTVG5jCEwxmnzc8hhfdTjg?=
 =?iso-8859-1?Q?jTnW4Pig7pc8N+1/P61ILQKG8Qoi96+WwCXBGEmGxaYeZyRYiEVhiLHXf7?=
 =?iso-8859-1?Q?HYdUNGqBUhHxquCMvnRrsBXCjzkIJA0Numi66GkWqpED8zW4fHW19GwJ6J?=
 =?iso-8859-1?Q?MIz51jcSH11CGdmu49rCtbgDw+BLRmiBTOghhFKwUpH8SIdN7XoNzWM6tE?=
 =?iso-8859-1?Q?hniR3DVIeoaX8g9CcK7WZF+eBGsmkuslQVoHoCA6IsRVALhQA9iRYa56pF?=
 =?iso-8859-1?Q?vkY/2FYIQyqwubHqBT86yho3bUJfBUfE3D4X1ytzTQs6QY0/EKXWSflMtY?=
 =?iso-8859-1?Q?BvkgdX+/CyDQDZtf4LCcmm46+ZBLIPl+ztXY3OxHRw+Dcr3G8UNgDEjT5b?=
 =?iso-8859-1?Q?uQN2bYif9eZgbPMeyYvwejoFuap/I+W/mp1U/4oFMzfgk2hNuocGQ46ILW?=
 =?iso-8859-1?Q?zSbzdTlMcY5rdzE5qyyRk2iLj3S4/YKlj31Sfofj7yUdvPldJQykWPZxyQ?=
 =?iso-8859-1?Q?tL5jFpccF1hsqBNUZy1yPWb8TKQCMimOBMUYaNo6L8A+QVxtkcw4RGEyOv?=
 =?iso-8859-1?Q?C31Rp2SVAEFfou4d9/lPJ0869rw73PcNTOLgB3hFfl/fLtilheCJV93++U?=
 =?iso-8859-1?Q?jWcj3lm6/7TWjUHCa5AV594rl5YFaI7x7OjINIOETM/DKFD3PQzNYD8cNl?=
 =?iso-8859-1?Q?aeah5Z/JbOO//KDlDhkM6WfPI2M6zIO+N3qgLt0Nw55GvzlcDEZUoNDI1V?=
 =?iso-8859-1?Q?QqytFZSrg4bq+Y8kkJNT22jAdrwtFmuS2dBKMUtayeWiEfPADzEZtumMW1?=
 =?iso-8859-1?Q?93/ZTw1cdl7Uw2P5GcaCFl81ZcvlTvQ8uSTwYfC+ZQPmPkEkEJ5nGoNrpE?=
 =?iso-8859-1?Q?0oOv0koIhs5L/kPNYmGI1mNOMeE7B2fl2a67TQvP8CwSNata87Jw6qi0cd?=
 =?iso-8859-1?Q?rmEmQS7VDILTxoXfZvtUWV7ZEVSB?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR10MB5724.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(10070799003)(376014)(31052699007)(39142699007)(366016)(1800799024)(8096899003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PAVeH4wpc9sgskAz5ps6zfj0akW04AGlTANQmgRTrbeWlcwBtFyWJhctB6?=
 =?iso-8859-1?Q?svIBbHWNwdGGQgULtxR1vliNvJIEHXyMubn2uBlMGZgnvrWl2S6awRhOWg?=
 =?iso-8859-1?Q?0fV2u+A6AQRHN6SzgJD66dTKmdxLiWctsL/SKtjb0sSdhcZQYUokkQckl1?=
 =?iso-8859-1?Q?iMX2ox0lMWFFn+nvRyrfINnOB54WZkaOtITy/4fNIIB6MN9LHxQFTaHgAZ?=
 =?iso-8859-1?Q?omEZzyyduyPm5IVRMpo6FDZVCEch+Tv10RdUoHH2O92cuwfR8Mdul9nEh1?=
 =?iso-8859-1?Q?KO04XU6jpqpxV04mEC8a3cS0RuxfQT5plNKVA98fTxr2pg+yu8nq5DL9nt?=
 =?iso-8859-1?Q?t3xhWSSRZeLJ/dpVXV5RXYb+XX56DahfWF3nLKnW7Vw3T4WgHr+CdOANhk?=
 =?iso-8859-1?Q?ElIUhd0MvmBRuCJE8EIMcXEr6rDbBQ8JKXVZVcvMk1J8NQioiRM6pAcEo0?=
 =?iso-8859-1?Q?BO146BJI3R/YXNx2k4ff47BB0izJxIVxziKm3DeHw7XRR3IDIyGEtUmW4R?=
 =?iso-8859-1?Q?rJs+Fiqfa5eaiv9opR5WUZ6sb1v6rPKdvO1rYR4rM3PW0h3oO8azXFNFmH?=
 =?iso-8859-1?Q?wkFvXFlt5LMrYdnxYo3phJM4baAvrW1XSmgZ05lZV0hms0EhFOLxNVnPMg?=
 =?iso-8859-1?Q?POuzl3vVtzj5tcpzGvqF9po+ZQ4EuaW4UjcaahnlrPjnLxyPKZamIqgbQV?=
 =?iso-8859-1?Q?BuGLHZQY0D/dWxDcpcixzNSrlffh4WAb9gCHixhCF4eUBe3JB0CiY50Cbh?=
 =?iso-8859-1?Q?sSk9TGkaZTxv7/ssx39NFHm1TLPcXBD9dMegwAagjYkQJJs0jMwjidMZm4?=
 =?iso-8859-1?Q?FG3IYL3LdMxjwgcYVJemL941KugnQdBEWA2+xve3HZa/5Ui78+Aqoz+4Fw?=
 =?iso-8859-1?Q?vCC2U6oO2Aqz4Q2tQvU9dCRBORu4WjFGGZa4tyddFDqNeuXEPJBRWW2Mvi?=
 =?iso-8859-1?Q?TZGrUiTzSN3gExkrlSo84GFj8vU6MSDjbhgDyyBOwaH/jd7Y9I8DQATwbq?=
 =?iso-8859-1?Q?z871LUQOJhG2i04+4j9r+48vGl7CuqijXeEGY+b1i9hnUvGhduvQ9oXda7?=
 =?iso-8859-1?Q?giUkgq6FEggeQRKZtNAyugZF569eflMZ/XpdYfKb2guS+zLbRjSAzM2a3+?=
 =?iso-8859-1?Q?IIz6MCnsaR0TY33XuzTCpbV7U1qHDlDEVoY6KAhp0wVQ9HDQokBt/i7DUl?=
 =?iso-8859-1?Q?0JYTeAM7ZgNSLakOvRoL/CUdDEolK4BT65nfKyYkVKcpmIJLfjdmTVf191?=
 =?iso-8859-1?Q?aVh6KM91EljBqCH4V2JX9CSJzXrEVwIuzabXNxedaPfNFuvGNSZmbPcVkr?=
 =?iso-8859-1?Q?yDUHt1GmfV/h/J0SU8POUUeiXgJTRN+XL5wmFS5zVSwoCOUd267RpQPbBu?=
 =?iso-8859-1?Q?QAGNbA4Yb97tuywWv1TJS/kWDLlyYhxa5Ll09IciOTrfVLqUQ3azzSIE4x?=
 =?iso-8859-1?Q?4hJJk0Ld75z7C/CtEtSLqsLFH1i5zCFP+D4rJvyxHDJX8NmKcE/andCxXh?=
 =?iso-8859-1?Q?eXXVPZEDtMVZpMoen/4pnCfygm5hQLhiXZ1onx3xKUeGuqUKUC5fGPG7sN?=
 =?iso-8859-1?Q?cLeK4JW+ix3X3bIqtPpJYuJqmh9kS5DK7WBFixlpZBnfS4qZXsmWOm44+f?=
 =?iso-8859-1?Q?Ou9e+UpmtJOW/X525CBNsBhe9wxJhDHm2JW7Z9abSthPD+L/yG4Ei5xfn8?=
 =?iso-8859-1?Q?/+uGsOsuL0E5aBYcIgsRBXsHG7KtPy9aQRE7tA8l?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR10MB5724.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dbc33e0-1ed8-4cd5-404d-08de287482be
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2025 20:36:40.7030 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aTbPlu7OhpkmWuO2MeZcyBNOjQWJDP43W1ZnYwmt8JDjwR59GsVe+79wlvzMZHSxjNNFc9nwRsMu5uRuDaru7l51pyV7MvuvT7nF0KD5rAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7538
X-Mailman-Approved-At: Thu, 20 Nov 2025 22:04:13 +0100
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Quentin

Thanks for the cleanup. Just go for it.

Regards,
Adrian
