Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83727CD37B6
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 09:58:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 233AD84663;
	Wed, 13 May 2026 11:58:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="q0sWxSNu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BFD984669; Wed, 13 May 2026 11:58:27 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40EE98464D
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 11:58:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UgmkrgvkCXQMMmV/DR8ZsBphcAtXV80D3rA2BYC/+tw7BlHxn7thA7G1sMmyczLuCUZUswvc3dhrEbBEiAYet8FCfIavlwNEn8x6I9o3Vs5Hf+PzDy7PVVO2/TcFNT2etHUPMpAfM0+vIqZRyHWrvNesafDzk700ovk1mqcXGBljOYpQ0ln8SXExm9b3nYUJpksbkQWqkc8HoI0mFiNSqCk3bU+VKdtkXU7MsKGucaFWfPsXHc28DdbN8CVmnAgAxWKSPoH0EUz6r/sZF8gK+CVsKJM42C2gTt6csmW7T2pZct4wT2n6pc7VFfe6UQbMeQPXvTN8Ob2yGPgg531m9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GxezXYjroQFi5vnNGV6YF9TRmTmudxKEODpFltZ2kI=;
 b=jzQ2cCVUZqXH6CGspnYhmOC4O04NeQrm+gw8KphOjA6z4IhEfc0L9GndsPdtVYPBBI90eDyi8y/UEiXjnK9DN7ELtqJPUDiKtYFwlmMoEn8gWVcMpbC25MxqpJndoUZHqCvkL3XQnwMCTRs063LID5xvb8+UIJ/BT/tzELLiML6N95OgPki8e3TQrr7DXhOjSrDjaIRL/bIOI9Z6Q2UF1WHTR6jMnHTfz/Vw7+RWi2vtKUrS23qPPi4TDJh9jSwsSjoPinKelLqP5rjjZ1hY75o2bJizEKA9wRgJyN129aZYPA6wisEydz4F0/kqnJ4zIyyqHyJm+5roI0H1Cg07Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GxezXYjroQFi5vnNGV6YF9TRmTmudxKEODpFltZ2kI=;
 b=q0sWxSNuhsNUkM6Sb13UfMjELuNxeHrMuYaN73wbXs685B0pIDrPQpCQ7IE7ECBSJCkKZievlBinY6uO9AYb38XNcI4tDDKs7qPWAN/Z66PhJq/JqSSSG9oFsA5nopioSkc9rGokIlqo4WvFVEP7/W80XbNdUgBeWvAtppFJvokTzOH+NqsNaDLhjXqORXzuqBMtqrfbcZ3s6G2GpYMxdhEGuZAVlNinX070PF+taki36SQ6pdlhXKMnO8Qny1y3Y8JrlV3UJegW5BMXnypPGY49SB6nwjq69qHM4mLZiElsOFqNsCtUtUmBwxWiHsmnGoQyuu5jEH0DI3uJAgXDvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA2PR04MB10085.eurprd04.prod.outlook.com (2603:10a6:102:3ff::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 09:58:22 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 09:58:22 +0000
Date: Wed, 13 May 2026 18:01:12 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 03/14] power: domain: imx8-legacy: Staticize and constify
 driver ops
Message-ID: <agRL6OSS0MbhEO3B@shlinux89>
References: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
 <20260508122247.512862-3-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508122247.512862-3-marek.vasut+renesas@mailbox.org>
X-ClientProxiedBy: MA0PR01CA0102.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::18) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PA2PR04MB10085:EE_
X-MS-Office365-Filtering-Correlation-Id: 66c0a74e-799f-4038-1232-08deb0d62b36
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|52116014|376014|38350700014|56012099003|11063799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: jMozJwbUzwITCSSRT7vqM9aBPRj0Na/4RaaVsTvBMBsxpnjIJhpuQ9lFXMAjjGbgtBLmlmpeFia5BKfse5T09ygje9kcpTN1+/md909VQc/67b97u1h7IxsH2K5P1aiLW1v97evCd99FqfGWPyJGwQ5Scc0GYH6QmppXx9rKCADhAB7e3LsU/Rx5d7CfoOuWY1rL1YrgcSPTohCkhdrcjH9kqhuCEK1t9tpojj17ERtrByhVVA/jLfZjp7EEI7e1vE3zYXlJuJg3pj1tUW3ND2lnlb+vpxm4ks0FqAwRjXo6Hg5euH/XMf2anwfy3ZMPs5U9Y5GPU3rM1Km5g/q0Q7JNHyuuinHK4vWl/Gz0a/5VkNcItlznp6hmSOls9mxqe3p9h8BlBuBpOAvA/e1WOoaEftQkYflsfATcXPa3M2Qy+EYpgs3FBSBBq3zaD3Sh/gXjm0Pu7m8OrSseLhNWN66fSHofnougHbdBVJoADN7v+kH5XVFkGC4aSX3D4Iic10/8M+aEMF/et2uJFX1OR69XiMX6AjciOZXeZ9AG0Tt3ZZE/bYhrztA1TU6QP0NzKSv3bJFijeHwTzkmdSeZUiu75uwB0CVJJInAxDxcDWHq45mUlXa/VVYC9MhpyxB7tEIoIGjKZx3sACnd5/QJTK/LcdKxsGBzA4dkqNWeOvhCpK1laA5FkRgrZzJ7E0Tl7VCKbC64HJKUeMd2THNzSsofULI8m5cyykYFSCauPv48Q8xYxMnSe5hHjUlg0bv4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(38350700014)(56012099003)(11063799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NvUDPxaop45Wlr7XnVlzvaCLdPJWY2ESJYxPYOrqtb6SSh6EXpAJN8qUtZKr?=
 =?us-ascii?Q?BesCNEefFzg6dSLCR5Rx3cqVmn01UVBOHV2V/vORDAMNFjHMhbJ/nXNiqoRZ?=
 =?us-ascii?Q?WfcNQuTOTQbGNiuVk3LR73HvFlcGUwEsc16n5B0a5KaTqAJf7Ass4a8YItKC?=
 =?us-ascii?Q?gF3eCabkmeGZF/lMh7EBqrOjqfien+/nqNUzjuyHv/fJILuE+lYLVikHDEJu?=
 =?us-ascii?Q?ynYq4yBHymZeYZZPNqsXxVdzskCtYHH+8j02qCQg45HS3nRedk6L0imXvbrN?=
 =?us-ascii?Q?Ruj/FIOOua5LmZw9FlDUs4Mb1HTjcAR1Y20Pfxgi9crefDrkuvB0z1jO73DK?=
 =?us-ascii?Q?lazG3d+qExbfXbWjRbKKsOvhoNK2+PyADOfXiw8kByHZqblTnYqtGyldas24?=
 =?us-ascii?Q?KWiEykmx7mKjuGrIpDxMW5fjSRBqekmDhgtQAzj/HtPET2Ye3ApERGq5I1IO?=
 =?us-ascii?Q?n7kXJnhYcrRwyIrd4gIoPY9O4V5p0GZzmaoRN/ChClpOxg+BsANvZzHCQa78?=
 =?us-ascii?Q?/tD5OI5G6G3EskkP6FBD1JaKW6d9q+gwzSBuNKFZkCi9x1ISqD2kdlu/AQVi?=
 =?us-ascii?Q?2tCZY1HFC2yn3HIiGSE7a3lMPNj5bM2BKAWF06M20S033Dt1FUv0YbYQd/Be?=
 =?us-ascii?Q?5KHaJLSVyVPbkfiqpUoG+ghjmvxWn5gS9N28trQItMa2FYa0wnnuoJL8du6P?=
 =?us-ascii?Q?1ng7QZKkYJ0PxzOKd/ikZrsbniTGhSG4GCuXVFBe6gSS0w/VvdOv0QqClNVB?=
 =?us-ascii?Q?4JwRdN3D50yGxThLi+kYRXrnMNrnrm9WLWDHuzQM4QgSAWHnz27Y2LwRZMAD?=
 =?us-ascii?Q?WP4t3qwgU70qGWGiXc631qtWynl9UsNxOaR/5HZNaLwc7vSz4P8lHFqZnGtx?=
 =?us-ascii?Q?ELHn+7xJc62FRXRgbhiXW8YmpXyaXBFc6AZJNqRfCQ0P4AZlt59XdhfcRfGq?=
 =?us-ascii?Q?CTku6f/8taBkahG0N0Lk8FA0ect5VAvGH9RCoF/m4hjOV2qRp7JylxVRJ39s?=
 =?us-ascii?Q?WTPKphNP4qnfU/Ll4AMJYw+e+B1OWq9pqwey5P3Xe+8AlFfEnOaryplzlWQ8?=
 =?us-ascii?Q?Dizpcrx/pbltZ2mVTGTs6VrDEra/REttVCrgrjmCKjG75CH3Wnn/XbiGHCHQ?=
 =?us-ascii?Q?z4h2mBlBU3/qbn+FVYdFChXucL0KVso4Cl3c1TPhvJfM710d4i6+dSao5gKX?=
 =?us-ascii?Q?RJMf6wwdIpkvJ9hBMvbsINgprNUr6XXfeAsctfhwdkd1uQS8QYOtaCy04WbK?=
 =?us-ascii?Q?d5fScgcu7RT1cDsIlDexRSuGMV8kuD8PMroMmQonIvwTBx0zLnxT2la1U/x+?=
 =?us-ascii?Q?dBZ5cYhcR5ptTU5febopZoJREDXjql4Wiw+/Rs6QURU0MTl1esh0UyLDSxjM?=
 =?us-ascii?Q?vlgiFhkLU1D6msSGIgJ11nBD91t28Sk+nqWQeVTqe4LcWmANYmg6iqwET8iI?=
 =?us-ascii?Q?RK/EGpmKu83vMABZ6We4twMPwY0lvQur+SluhRkYFPWeGRFm5ML+fsfPVXlN?=
 =?us-ascii?Q?OIMhRc+8SkPmNrFs5zTVNSxjvQk6njfLNIyqXwf2C8EY2spgHgYXQH3Lb0wJ?=
 =?us-ascii?Q?TfGxVSLEfRs+2emF4whdChqMVbETVGLbb5oz8bEhct7SeLFSmiZYQ4zOOSZQ?=
 =?us-ascii?Q?Ls4ZJnBa+iHfqaLZioJq1QsDrjfl1JUuNy3U4qUio81MZQOop7tdNHMKkbNB?=
 =?us-ascii?Q?ts3fXudDRC1wPb5MMp18Lhk+ibPghHRYIr9/CBhPdeeWyAEzkyWgQu0yV4af?=
 =?us-ascii?Q?ZJHuga5TKg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c0a74e-799f-4038-1232-08deb0d62b36
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 09:58:22.8692 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xikAN5Sq8SOjhqOc4W24MLrplxVXT4RBc7wNy3a2E9HcLieYm2PHdOnIXS+hrbG6KizEn6t5p5QminQ0f37/8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10085
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

On Fri, May 08, 2026 at 02:22:03PM +0200, Marek Vasut wrote:
>Set the ops structure as static const. The structure is not accessible
>from outside of this driver and is not going to be modified at runtime.
>
>Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
