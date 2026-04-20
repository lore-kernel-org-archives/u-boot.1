Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA067F5581D
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 11:27:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47B26842F2;
	Mon, 20 Apr 2026 13:27:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="LCE20LPC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C43B842F4; Mon, 20 Apr 2026 13:27:11 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 755CD842EF
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 13:27:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XJrSe55mAbfCrj86I8m6Zyk9oB/UqDKpZ8Qk65M6xXyzAXYoml5xXzyoHDirLktXu9pt4dR77d84YthtBulL/cGXlXr+pJMqvHfJ6AiKkGjh0ieoQVVTXss46twUJYEeFhbceon7z5Go6WCwKq3mK2j8KG97TihRdhfrO+nRw6QX6dzPjkIjR13q0HKFVIjTbpgbdIv5x2kIcM5ZvuRgHoLZfvX8XoA/Cq+J1ncVGSW9EWggUxt9HL3d1Vg0Ik3domskK9lB6aeFdg8yphf9BXNsllYGQLa0frAYawzy4DdL+eOwvoQ40mZwHEVqPHl75yk9WqB4mUoOlvwryR0TqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N0npzQcTwDtysxh3dvo8jVoKqk3d6qMhgW0vN9+JCxM=;
 b=G4WnaPV2ZEvxdciU3TCq7xAv3QHxNfPB/olmbtdojVMYqh57xf6TML+rRXLI+ljd1Jci5OVcT9WpnGzteCz87+ts4ac24gw2r/OtEvwyQCp6UOO2j99GbzFr0EGKKgjq+tyGs5NKVdfO6wXLNycQWAhAHY6t/5RLNBqUKpkZBdNaNrs/2+osMvB7Rw9lHO8+OOWCOe83CnNcx+x7sAK9+s+PcU/sPIrWyv/EKdUQrzZ0FeQpxpOcb3TwyOW850Qglt+wHD0j+btcRUKw0p+TIiD5nQHll0uDhShUqvWwOmVk7F7YBSVbbJEFiR1U0O0zwfnC+qxqfvGYTfsZiwvFSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0npzQcTwDtysxh3dvo8jVoKqk3d6qMhgW0vN9+JCxM=;
 b=LCE20LPCt3r/nf1mk9JRjnLo6jKhfqa4TCZfxu7hF53D5wTDCFaDJrGNsEnJMpCZyt1gjV2s/q/ilJBXQZyAKewgzS4wXalv6gs+SSgtntOP+A/JDNJimhX+miJP10DHZkQGhIdMCV7DKi+ExWkPgDYeEpjzSLUCmQ/oaWIGboesUHL9H0y7VyKYcH3jPWf8QuFPHJwOJrdZtftUSC2Bqcfon/YcFrK3J2QzKgs4cD/9J8v+/dibURpWLRxKTDqrCd9HsTK3/HuxYPBbU+FUokcSR0vDEQg9gnsfgXib5wpD6dw+AK5utR11Lsv75J6UHvY0ry+kjuCPG+NgHb7h/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by DU4PR04MB10909.eurprd04.prod.outlook.com (2603:10a6:10:587::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 11:27:07 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::21f6:947a:1f40:18af]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::21f6:947a:1f40:18af%6]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 11:27:07 +0000
Date: Mon, 20 Apr 2026 20:43:40 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Mathew McBride <matt@traverse.com.au>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 3/5] board: ten64: remove USB hub references from
 internal FDT when needed
Message-ID: <aeYffNCWI4zNqwTh@nxa18884-linux.ap.freescale.net>
References: <20260409-ten64-add-usb5744-v1-0-2094496f72c8@traverse.com.au>
 <20260409-ten64-add-usb5744-v1-3-2094496f72c8@traverse.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409-ten64-add-usb5744-v1-3-2094496f72c8@traverse.com.au>
X-ClientProxiedBy: MA5P287CA0040.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:175::13) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|DU4PR04MB10909:EE_
X-MS-Office365-Filtering-Correlation-Id: efe4dfb7-9a3d-48f7-249a-08de9ecfc163
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|19092799006|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: SfFlnGG0ze0Bk0SFElE7tBwtPlXSPNCJyxsiyJeFX4tt/zaI6l/lSEEF8YGXeDB/vV38fMOYJsJLJVdGGQNjBLVqpzQzlFi9Ovoivs3QrGegt7xiu/LHiAzrcTMTVUH4956NZyxlC7aNNYTZmEPvihheBF4/DEmkh3rqlVSIsMlV/XBy9/sy7wk66Loy8eqA/TF1map0dqvSAbUeM+zKZrFSsB9EnSR0JeuJkFDoFqjbUCQmkB4eEsR7zKZutpa+mKWbTKFYaignfNVYmEGRunNyLm/Q0xR77ktoeF0HNyO1tniLzQjvmc+qUGSqZWQdtjTg2pUj096aOHxuI9Foaw+9YVIcMQStoOd7rjvd4sfQCJ9Wg2l3bM80pQzUfuLkQGX5M7Ed4vIlQY89HA2aSNpLiyPJwG8K7pgDsvDX6WaZ3Be0GDmSo8Gtp9xTK1/D8Chnauu9qTR7FaMXpMTMEDUPlFIEkRckvfCKo1hDip4SWdVIwv8dF8WI3xLIdQz5q3q232Kb7UZX/dKjVjtV7cDColG2LvP6Buf6fEPoPg63Cl3lojKpaFhjefEZSNqVCixOBL769nr+SgYoZYgsZFFSn/u5aZBWjzW1R8D9E5MLvWBxC/+98TAUswLyoDsMzhkiCKIwtS5g/MjJ7xo5fensCaW+l2uv17i3UMWisOOgx2qvUOjrLxq1/DV5U/AgEi5fqKlZtHz8dzOaXtGxKnVYiPdKygmqtK1pXsuN/CDqeL3axpd0If6kbshrEdfbMorDxNJxnyabYYmuuuNF+5cLqDgDCp9LizfT2Un3dLY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(19092799006)(38350700014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tsPuIRXTmd2vjjFqiqbgUIbI9iT+xwqpYqqwz19hCo3741q9Mch2mvjvKPJD?=
 =?us-ascii?Q?P4P+ZS9HML6v/LTw2m0n6GiW4Lo8LhRXiD4hFvQhdn70Ub67PogpjrqamU+M?=
 =?us-ascii?Q?/TCf3w7k8Ri0uevFvaSK5029L6jbU8yiyvaN82mCkd0CJThyBSswk6btR0kN?=
 =?us-ascii?Q?67aZjrdrAhI7sbF4fNHTl1jZlkfJmEXqAo4Q4VuCqpc6GCixo6TkoDrHn3ny?=
 =?us-ascii?Q?hxeGrD0TZ5oOUMryZPPEhMIWqqlfwTOVTblPtEuYCqcndnDExi4wn6CRAxDz?=
 =?us-ascii?Q?6xaekwn99aSdqHjgJt8zU4Y1o1mZNxF0eIhahShi6jLwhU1+mPsonGTmfbOz?=
 =?us-ascii?Q?T28oXfugcddk/qrNye4sKjzuYWdhCbFSpH+jAV/fv9gQ/rhBFdLdjiUl2nlR?=
 =?us-ascii?Q?uqDfNsQC7JkCdQ2QbftQQUfKytEm83uXrbd/Oijhh58FlsMadC+5VpcLyBsX?=
 =?us-ascii?Q?+H4AlMJZfKQckPVmDpRGTF3nrRz/11KQGudsA7hrzQJZcU5fa+c7nLU3bkBK?=
 =?us-ascii?Q?gAeTUNqlsiRXj1jkE/PDdhtF4TgibEY3SIHi2sh2rzLgtaKXAHoeWOh8QcRw?=
 =?us-ascii?Q?e3XelTOFWwE3Nm+9w1SCMf1LkIM4AlSbj0XGlbxRUIMQ26ZTpONn0z3KRmF7?=
 =?us-ascii?Q?t0/D/40KSco3YwKEeG7LBYwZXZDekL90/gvssp3g0cAEbaRYDpdSzGvPQhDg?=
 =?us-ascii?Q?3OEw6dOZQev0WXPaLNE/5SA/z6PndBUS0ai+jLZg/lkWXtDEsnM2b0S3Z2Jx?=
 =?us-ascii?Q?+rX14Dm1Kv8yVgNb/CASeuYoh+YOSced/VfT8HUfm+1LSbn8WosA9irk0RYE?=
 =?us-ascii?Q?KtoYSk7qYsByRTSLhUH4JBL8ngGSeV/cY+44x4fsBU1jry+N1RGioNAXFvqH?=
 =?us-ascii?Q?qyKt5VIsLyA1VKVcnxk7r48MI9Q6ULdG8FmdazyejV/CJz2d8VTzWwD2pVt9?=
 =?us-ascii?Q?WlHH99E+ZTaPnLFgXHfOQPvVrcWHys4+j1mM6IfpI0xLVdKkRiTFYW3kM5Ja?=
 =?us-ascii?Q?rLOzhYJq1uO1NLKv8ORLaLcoM5oGs06xY33vDqeDodTg1NI+tBcsHxXoGWCP?=
 =?us-ascii?Q?60suANSNiWXQtiVkz0ovInbkawGZqQ7vaMaUCSqsHFtutA/dR3SW4yxM2qRv?=
 =?us-ascii?Q?5x9Kf16ufLKbaqPqEOgmYqoWER41CB4uPWbrTFfKM1vP/P/jPEMs6XaudkBb?=
 =?us-ascii?Q?9vlQHDtL1BHBwykFw3+pPG19zX4zImoGMnjFaBQD+grIv2IDUvmsLeh/tozW?=
 =?us-ascii?Q?R+GBRaonTi21MITRlTIy0Vht9iPxOE/u07VaunC5gdzCE0MGfTvz627Bgj4l?=
 =?us-ascii?Q?OTTXCdikbXVsvz8xRgtnOozd/oXIABSNu/RAXvfYKLnViLH3vEsnvDn2C+rT?=
 =?us-ascii?Q?tZRL4YX5RXkcxAc5IT1OWZNPyysOtT9yqhpUMjuKXQkUblvNDUD4knDxwaOe?=
 =?us-ascii?Q?vOSa+tFC+k8BYJJo/kae2xK+rJPupuoKgdw9HsPf4i53HPa140IfdTcmMQtm?=
 =?us-ascii?Q?dFAi3qUKxrhnd+uiwTwLftwO8qrRcQ730mDLo5BzVfGof1DX6hWQ7OQS8sF3?=
 =?us-ascii?Q?Gs7o5sU0RVJMIm2YRlKkxJJla23gGJPRC7fHQ4i93lWkRds3SOO6Fkz1yc/r?=
 =?us-ascii?Q?yLrUirDDB9Pasgs/wEbcs2b7aVp6Va9leQzsMnMEI58rfli/vdRbommyzef+?=
 =?us-ascii?Q?SMmpiFUZCO7bYEiJQ7L6K9CraFwext6mQEsz5qaVjYRrSbItqB9wFk/xd8S1?=
 =?us-ascii?Q?wUefUbiGxw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efe4dfb7-9a3d-48f7-249a-08de9ecfc163
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 11:27:07.5332 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yBAwU2W4nrEdJu7sOJFja8fTHgGTu6KdKgD2DDPq+b6cQOvrk7voMEFnIl8XJ8OT965qpTTyhS6Gn45eEyWLYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10909
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

On Thu, Apr 09, 2026 at 10:06:33AM +1000, Mathew McBride wrote:
>More recent revisions of the Ten64 board do not have a USB Hub
>(USB5744). The references to the USB5744 need to be removed in U-Boot's
>internal FDT to avoid the USB5744 setup being invoked on these boards.
>
>Signed-off-by: Mathew McBride <matt@traverse.com.au>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
