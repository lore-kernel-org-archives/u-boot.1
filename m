Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 382B910F994B
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 15:05:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B54308404A;
	Wed,  8 Apr 2026 17:05:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RfVQ3hIJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1ABFD840AB; Wed,  8 Apr 2026 17:05:40 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE6C583F98
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 17:05:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=McZkGRynXxHekPilWl3p/EzO9JyAKL+wPONUiaSEB+03Y1A2mxz1l1ZKn8bXvD3tSf2qFuFmgdr2SW7Iw3OvwKrE5X2b05ym2EiGdtpA0GuwFOHxlOv6Hl/zUmKzln6oncJngtDXc22qH13CYInlB8yW2wiKLJrOND2iHiDn7tI/VeKRFKMKBXiVBv0zhNr2l1+FQi+REWwwpyzSOv1Ua9z50c6hEyw+kijKPT9WzMq3qh3evn8fELQdMskGLTJ++taTLAynLfzkj+SnqPrWw6BEpqsms5tsx2lrwzXwUAEjVFhW7YLr0okaGYqHBItyEnishlzgZIvZ19N7mm95sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vih5WcZLAo2065+mdgJW/f+md0QqUTEaB4nGMgKcA00=;
 b=kNajyG/DF/6qpEoV6oM993AsLZqDUyLgp+PaOrmWUKCT3OVuEMweOilctX3EEiXupObl7n6xZvueayS+7EeAgLBxLZfMjI6MdFUAuBoFtBDpb+rYGPJjMDgQsirgNOJqg1eckv5e/UAhVU+kaTNv3kxzgaQu+IbGGjdvN1poBAC5N0exn+UHy8Ya8tOEc/dQwDxTGezV2qR0ORUt4TcdgvG1UOjZnQ4Ddur++sdQ8DsngxMTIEOzX+Ok3hgCYKgEYVtYiZJGM9vCsHA8mIuSVcU1GyhMpTjNbzyw+HXVMy566b6AUvrurQAw4eFUHvyB1JsCXST7F4S9INM308PP/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vih5WcZLAo2065+mdgJW/f+md0QqUTEaB4nGMgKcA00=;
 b=RfVQ3hIJgToj4EkGQlt4j6A46qT3k7/zjwBI5cFPQ9JlNEJKw7KUv+JomeN9lYXi30jRIcTl/Q0304sQ8xPAzkRea+Slmkv2AbPAHwBe4MUODUn8QZckBtTCribTqR+LBXXPpjkt+LOi9bJenvPJPK1/XRz3UHct0TCzgru4AFwXfdsHlzfUVOhrOB9WAZVlXn2uX7I1G8aeeB19MEC+14qkhGR8jPopQv8gVoeAmo6uI2Q8PL/OZ6mTeyZjnSK98UfKCfSEMGbAKDoxenFqz3vpAAx2G4N7+CGETWcd298ber8bPstc5cI/8p5xQnVvW+GRDdzzzxqG5RdQYqSEiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB10912.eurprd04.prod.outlook.com (2603:10a6:10:58a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 15:05:35 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.030; Wed, 8 Apr 2026
 15:05:34 +0000
Date: Thu, 9 Apr 2026 00:21:41 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: "?????? (MW Park)" <mw.park@telechips.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "peng.fan@nxp.com" <peng.fan@nxp.com>,
 "jh80.chung@samsung.com" <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: allow forward compatibility for EXT_CSD_REV
Message-ID: <adaAlRvDAKs8mRWB@nxa18884-linux.ap.freescale.net>
References: <SLXP216MB114822C04834C4F0A78869A6F056A@SLXP216MB1148.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SLXP216MB114822C04834C4F0A78869A6F056A@SLXP216MB1148.KORP216.PROD.OUTLOOK.COM>
X-ClientProxiedBy: SG2PR04CA0197.apcprd04.prod.outlook.com
 (2603:1096:4:14::35) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU4PR04MB10912:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f4a6761-fc88-47d1-7a2f-08de958048a6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|19092799006|1800799024|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: iT6HIPinpdP3XsTJmZEKOdiuQno1u3GhpTZMat45ukwHhmL0imKW8aA8bbHH9WWx2MwRDdLWlM/n3oFfgYsjbBKqfrU5cWTZbQ8vTDoVKhvkW+OHyT4PtUyZwJu35QtpHDEdvRN44Jqu1oxhj1AZ7xpZEIXnJtIc5clihGG1cX+poB1+JBN22sAkxy+pOicbkUZaB9Ja6ZAds/sZlo8FeoO5E6gjJqLCNRNn1I35xcKTbbT14/h+3BNrrIooMZW1q99cVTJzROZgqiClnJ7pcbNkrpEmarv4ScSnuE0tz7k9Ai8je6JNhOf74CQXmTJyITu6MSUp1pfmSViUXdYt0nW4+UATlNDTQBkxuoyaBzWHaPZRVKbY5clRb07QfO6oQIVY2IY5qALKux/ARtuCpeNg4Uuh8/OGKyuT0mreEon2jQkrS5woGzIuN6BUswQzlcRucsTDHmhFZ16vGf20PpZanBjk6Q5BiNNCOOxMd/FTkPUrwZ7BTyRGdH5cq9pY9yEuieTXiWW0RflhRXsXf7ku+mYOCuQFpByy7yBRvSUJHRqwAiZ+/FGfMh/QzljMIQrFZxrI1VoYwZt6N5ZU1ohyuvLqnnO8i+vHd7X/XnGXynP5DA949vq63fSuSW8mHcoHUqDPzEzse9HFoREuC/ix8hBwUUslifrwY3e2KPaCfZxs5vKGCFgl+tVpez9mkgYNFz/DmjFwQc3F7GumDWRSB8c5i6WUd4Mcw4j6pLabcVBVVUYs82mmSy8oV7AXODA0EHvpBCdHhr/Pol0RUi0v2ltwpgZnswFOqv+WEwY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(19092799006)(1800799024)(56012099003)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7kwhyY2FWfJeKPu8yZknvHHTSvbHV1Fp6N4t6PqXAQEwt35bO/Zjpdjx+51B?=
 =?us-ascii?Q?XJOoMfXjLzsFCC7V3hCRrVyeC3hHQ4DOuR6y2nlZNELWzjN/y0+j805WU4xK?=
 =?us-ascii?Q?95BzMlUqKj1rnsrpVoKP4vDxdrMvRIx6tU9M7P9sJS/ullx3FaafJ7oL4WKb?=
 =?us-ascii?Q?rHtJ54jRQfMOkvOB+hzHoYis0cc35WNoatQtggDBBTT7h9ZcsOdGl+cwitts?=
 =?us-ascii?Q?ClylltOURjR6REE5VoRymYFXh0gojMdu0N8Qi4ebWD1T+976pbwL0D9fYv90?=
 =?us-ascii?Q?tPQMgub9+qySmuxNlT8BE7evTPHo99/xfcVSiukHRq2g/VmqWOrQua7ZcTvr?=
 =?us-ascii?Q?3jvEnqKbW26mBSjbTeEuWzmH2hJR9JmrHG9oL+hDTzNB7yefZ8uSzocpfnKa?=
 =?us-ascii?Q?OLCQ1OFfa9eh/gObBCnal8Cq1A4JShe1ZFR+3be9A9x9zGjtqrSI9i9Ed2fa?=
 =?us-ascii?Q?c4pxGH8/jXx4BpqGS9CL3p6fNNgV3hG2kw1yKsod1tmv+NIxV2NnoLJmCxDW?=
 =?us-ascii?Q?JGhP9BEQ8/KcIpwCG6KH6ktwhF8PtNQGzx9E+5yLD7pYRne8GKvhGagT/GfK?=
 =?us-ascii?Q?SgHwH/E38p9BH7wuX/KDhsnsttGkGLB6L+Mjgzzmh9Rswj8UpoYvSxEav2bL?=
 =?us-ascii?Q?InNvf5fdcTbaPO7hl5r1+YWggVApKF0BCDeFKJnG1378HNSRz3XeeW29Zq7d?=
 =?us-ascii?Q?z038e6VqXdvUFNXpgyvz4SU6I8ygMwfsc+F4k+/y+CIAeV91J2DYurM6Gpg6?=
 =?us-ascii?Q?gsdd3/k8oziioC6aXtMLciSqsbaqeAnfyl87Y33NOQXSa0ZIkc9vUioaNq1/?=
 =?us-ascii?Q?GSAJ+0x7cZ17D4HUJjKmQy3e/7nUFOcDnhmOWXR4D/dQb4qI+bKDyEaKCkNf?=
 =?us-ascii?Q?OAe3FblmLMHVY+hELdlFtAu0kZwSbzmga95LVW8xTJ70MthMraOyMsH7gf7N?=
 =?us-ascii?Q?OcoYU0nRB4D1J7I66tw5VZednfnvsyIHqoTGK4AuvzUXooKLQpU884MLhdoo?=
 =?us-ascii?Q?sqYEs8Pj5NjK1s67cpkPbaVzxkHaRFWRPbzL3DPl2RrnfspKVdw7pT8bxXeG?=
 =?us-ascii?Q?Kc+54JZybdQOftxu4MOwt8LKAyzajVnP+xrrs6WlWe85ejBlxae/+e7EeSGQ?=
 =?us-ascii?Q?G682Qb1mhiyLYL0/i8W/U8higM0101bl6JOwtiWl2pTXo2mqHYekHlIIL6wq?=
 =?us-ascii?Q?te5krFHfwWync+onTyUuVzvITdTNVbhtY/8d1Gmmlc7rh3m3L1p1H9ciepOO?=
 =?us-ascii?Q?4W9dn+HNxSxSuQ/9a0GrapgFs9LDr9XGHTIrYBIdYHhMqIwrxN2OAikmswvU?=
 =?us-ascii?Q?3eZua2RJ8/FrO9Mp/r+H0MIT21XrYEWxsYYBC86w1dvLeX6/vd5kK4su0VQ+?=
 =?us-ascii?Q?c1eeXPPpf6HU+3ng6YTlMEMp+dqhWDMbs3Sn3ZWGbwmycLdzXSTLM6ipfOMi?=
 =?us-ascii?Q?3lbz6Aue9RcMnELvyjx0lMxhNbP8BO2GTWiyK3uVvsHvFVS9+rBIGUOczi6v?=
 =?us-ascii?Q?Y6TcFF4y6XA9SeGLh6neshd4noDJIzox2GdkuZvOEBCdKMS1n5/+eYZschum?=
 =?us-ascii?Q?NixOfsxq8NHZhNQcYghi4r1gabjHDaPtkfHv9w86hnA5qicA1MDjzstCRhPD?=
 =?us-ascii?Q?TUp1PYhrcLF2Jv0GVsgesoXpdVC7fpKx63GM6BOx44NX+3FeOTD+oR49MNui?=
 =?us-ascii?Q?XAgTncBBo3PZY1sMQ6zA8Og/hJzW4b1v/U6FigjUmjjowOCcosWJFQPGot2i?=
 =?us-ascii?Q?qH+PR5oO5Q=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4a6761-fc88-47d1-7a2f-08de958048a6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 15:05:34.2516 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u5Mpd4hXu2FPhqrohjZeL1jq+sf3b5tDiLzzYtSdeDpj0qIe8ozBRoyXvyHJQxDZi037a1H9Gi4psW6Pccc8fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10912
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

On Thu, Mar 26, 2026 at 05:55:32AM +0000, ?????? (MW Park) wrote:
>According to the JEDEC Standard, the EXT_CSD format is meant to be
>forward compatible. As long as CSD_STRUCTURE does not change, all
>values for EXT_CSD_REV are authorized.
>
>Currently, if an eMMC device with a newer EXT_CSD_REV (e.g., eMMC 5.1B
>with EXT_CSD_REV=9) is used, U-Boot fails to initialize it and returns
>-EINVAL because the revision is larger than the mmc_versions array size.
>
>Fix this by falling back to the latest supported version if the
>EXT_CSD_REV exceeds the known versions. This ensures forward
>compatibility with future eMMC specifications.
>
>Signed-off-by: MW Park <mw.park@telechips.com>

Would this patch works for you?
https://lore.kernel.org/u-boot/20260225211332.1896252-1-han.xu@nxp.com/

Regards,
Peng
