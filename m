Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 493B1CCFA05
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 04:41:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A877383CD2;
	Fri,  7 Nov 2025 05:40:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Nok33xv8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3989C83C60; Fri,  7 Nov 2025 03:17:09 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B14183C40
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 03:17:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0abqQPYIApeeR3mUHRiLFD22Eu+KKC/8Sy1MuQ3kOXW0Fc7JuswtjAcM2S57kl+b56+PKJdrKlcb8Cj3DclMDwwpP5UDB88gKOjv23zjfAS4YXy1W0OC03U82lwNNZH+qDxKw1R7SmBYgpBdUnj4QWz81IVx+9QGluH05jlXKCdK4mEcfCXMZuu2+9iF52w5rfrhgQk5k/nMh46tQyG++a1Nr/0+R+3NTAa2uNEUBzyPf64LcLOduIoe3q54zfwRZoEAhCHMwWpSSJ1q6PvX5LJJnL9q6XlnW+YyXs3EwJ4SHp4azCokpYRwVCiDTsAn8kP1sRlYSNYwnLVRgXUIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6ARkM3m7bXMgCNdCWjTwto+TgEd+E1VzOpEjpVsH2k=;
 b=AyrjSJWAwbtywheqxi+GQNZQYc0gTIEmCib55saB30+Bn69v8ZdwTA1Jrzy61EadfnX6HnT5zIMOJ/PDfebPINGFJBUL5bCOTMyB/Jgpy5N+8f9hKF8ZtliFWdP6sOL3sJwfvt0RgjlqfTXzGRj/E2+ApUF2e6KLj0yg8ovSb9W62bQSdvrRh4C+HWctquaQKggn1b799DFFKPqK2KVC3QCTL0UyPa/wu2wymuH3FL9kqDT7F9+tlLvSYk/gPsN29UXvPYw6w3PJJvstx30zWnfU4GfV07IUC6fA8XbgYb1XErGDYK6KLmVU3lobHDg9/MyyHCshcgSkd2iUBmvqAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6ARkM3m7bXMgCNdCWjTwto+TgEd+E1VzOpEjpVsH2k=;
 b=Nok33xv8V/9QYag/9opRZR17Wl79RcxnR+mIFmmkjTkNrCc4E7/WHq6CTLGh96wBJ0cDiajVJsRhXQr0Du1+nPlRb9JRudDbnnqt5NNsOzY2eat/k8YO+oXYZiH/bYXjk4XcXNH/MvaSYJIFUxQJK5ge/6E8Hk/Rncf7OMPr4Uzb5IOQIo7i86e1uXnG8qtkpzhrXgHz5oG11HY1QzGdPCLHUMDEQiLklZjrz6/0xod7xJjNRl50WK86KQmykldY16MtfajT7i6JYo3a0VONA5SAExcOA/nWRIir8mvp4WY/nJ66rfamVmjzSdnQiC14omrFhCUHNTkVZSGtRebGIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB11018.eurprd04.prod.outlook.com (2603:10a6:150:224::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 02:17:03 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 02:17:03 +0000
Date: Fri, 7 Nov 2025 11:29:36 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>
Subject: Re: [PATCH 1/4] clk: scmi: Bulk allocate all sub-driver instance data
Message-ID: <aQ1noJ_VxwmA_MHY@nxa18884-linux>
References: <20251028034225.260469-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028034225.260469-1-marek.vasut+renesas@mailbox.org>
X-ClientProxiedBy: SI2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::8)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB11018:EE_
X-MS-Office365-Filtering-Correlation-Id: fb101952-d08b-4ffd-db2a-08de1da3bd6a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MKQzMwKYdvsR+ivFnRhV2xeYGtpkFpTasl/FCrVbgweTz3ZgqchVwkTHhlCv?=
 =?us-ascii?Q?poFyRQCEetZbm02WKyPu85Y8wLwRRVQ1Z3eWOtxPEcLxsalkU/KhOm6Krwf4?=
 =?us-ascii?Q?y1ZP0sZxvqqcaZeoWtkxsleOtH5RG98EI+DXsWsLfYsBK4v6AEiIf+Y3xsV6?=
 =?us-ascii?Q?VVVWrPuNImb3rWbDNh9g5JuRC8oIeAKMNXMzWqygpSGGXYNnkqSLC7OPq/QB?=
 =?us-ascii?Q?Ed5jV0tYP634cwUhv0F7AcYF4LEO+8RC6kburTVQZwT0jB6MDp1+raOT1w70?=
 =?us-ascii?Q?XP8MjKp2ST/4OESzVa31Cw/iY1ysJ/X2F+F4VkPOgJdnnHl9O21Moq2IcXPt?=
 =?us-ascii?Q?44cLiGo0FFmcBdNXfBaBpd60v+8jdFUTuG5IFbQEJ7IYZgUre/E7GskimZNi?=
 =?us-ascii?Q?wMvfHPhbuY1FL2LCI6N6tiSwmMHYFbxFuihEVBoWvZDB0Nhf9/DlEtMV69do?=
 =?us-ascii?Q?B981ifsj3nY9PRdmkcraaK7RYC1Hf0H7TtdFzN4IlYsgLqpwHzOtswAcnwkB?=
 =?us-ascii?Q?5p8TVJa0ihvtUMNwKwzyDNT0hf+/ezSsp4nWxkD1aLFxyN9R+rM0B3y2FxM4?=
 =?us-ascii?Q?h7Egm2qxLPon6AbkLE2FCQxt+VFpYoM19yEg5DCzI+K7I+BH5gq+9/wgjFoQ?=
 =?us-ascii?Q?BszbaVnTRxTIB0v0qVJCy80EIzCfxJ1Zre77pJFC17vJviv3FcCd6IcVyNA2?=
 =?us-ascii?Q?A4SAhiXnqUA9ABdXrdLK/Y8nQu2aQnHbU7VH4ZhPMqG1ipNeOi/6gpNo1KJQ?=
 =?us-ascii?Q?uBEBxUr/tB+ahspR2rsHA9Y7cL85U/RHlMjFtvwPWFkD5AchNjVvwmlZoT5k?=
 =?us-ascii?Q?+7asF3cJFNZRAXzmfgISxZRmBY6Dxrt5FjJD5wHZCYzabieqOZaRshbYvihv?=
 =?us-ascii?Q?kWuwqZyS58WE6nwLmcrdFUa9PqNJJvTACJqDZ/hkw3SD/rEvHRYGKd0rRoCS?=
 =?us-ascii?Q?csqcrzLFoIDnj+uhF6QtJNk2fx4VI/wkAa21r1tCVFrX4UmikrkJFf/352/7?=
 =?us-ascii?Q?TZAtqairsuKMOXdyewJjqWbVt0j7dnh2tBkd2kUuhX5752XAHLsPKaBe6n9Z?=
 =?us-ascii?Q?0QSVTktmWR4Vdh+VEPUb5q4Iq08wAZBzp+ypPrKSsmFMQmW1i4AAlVU843d+?=
 =?us-ascii?Q?E6fWtU9WcYK2w/uXi/vyGo6KPqAECYY9/uUXZbzi3sf2rddlDGZ9cLzpwB3X?=
 =?us-ascii?Q?gfC/nietiERLGEdlYyeJLbgrt3hOum7aDE5YWy1Br1DP5peC/fWRaD2G9B0s?=
 =?us-ascii?Q?y3pY3Xa+hn0TVIyJLKYpEh1RVy40/Bt5wlPJKRc5PLC9AfKB4bLAqQ46Sin+?=
 =?us-ascii?Q?agrFmKrdXmUuoiuft5l2U4SR0dLtKFRG9gcAeV+iXGCY8znp+tX8f/8k7Lk3?=
 =?us-ascii?Q?AjTIEooCjaGIVoCGZhosX9iL9JotITq9oW+Oo3wl1fLUyUPYTsQf/HyONgsa?=
 =?us-ascii?Q?ggwGZPQPqWCD3q6evINFY0a+4ADEJsNh8epgS7sMyTvsXFANq1wW5PIRMhjB?=
 =?us-ascii?Q?DQd2vrbJRHlsgjymL+/DmOT2EIpOcH2dILtd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TBMLJ9d3H8SDu5Y63TXcC9A8BPrhMPRcvCZieJKBoz+8bUTdM9IskL0UByHD?=
 =?us-ascii?Q?DMfeMQnB6LAX0Qr38edU9NoCodEi8NxSYjr2WUudDjyem1q1nSxZSzNXkDjX?=
 =?us-ascii?Q?mIKPkmIBzkMs5YnHH/uo8eCmTlv4mcon8hOjocDUq8MsctHnyAm2TaZk0m1j?=
 =?us-ascii?Q?vOjXfadAvRqEV/zPWk7MkXIo7fqPftJgFSesQvv+U0d71pa0smztsNpT0Wg2?=
 =?us-ascii?Q?wBE1N0pWGib3w9fXP8oXO5QHthvGi+37eL1+tXAFowuQoFrJU+RVGIB2RStH?=
 =?us-ascii?Q?o/p/fwbvbVprWb0bX3dCfFli6TokMnPUQz1wyEzWKAM4CTvRGOdEDF3wGZFj?=
 =?us-ascii?Q?6hQY2K9z4GCsXDXDqTTqzndntlND/ZWHoNm1lTshZ/GB75ElESaBUKn76ZLe?=
 =?us-ascii?Q?kR/2jMdDxvWVAd/+2yfpCRncrOg5ICkhNdxn1kYVauH/bExGGrjvz2CeE+lx?=
 =?us-ascii?Q?yFaGkaTwbW44PX67wDEUJRVIkxJDYqa8xgb03kLq88Iz3KxDhbvW1EYEaicA?=
 =?us-ascii?Q?8CP5wljEqZI57UHEDw4Yokkg3p6klxgE8g5vIPcrV4dxIUkzm7E8jBaXWGEK?=
 =?us-ascii?Q?D5mw5mBgwjFbV3v6QF6i8ZKXA1vt5m1Dwy6lD9voJ/DFSAcncyLfW1lq8OCv?=
 =?us-ascii?Q?o2g9fAx/E1IcwkTSLs4yZ6m0yklVHCyy20UZmS6sq5T3nOicvHx0jz0BQYwC?=
 =?us-ascii?Q?4g6RfuB/KCZRZ80wCqcd0c0AmcX26WUW4By6EWKZ3vvxQhjW+HNtKiWX1/KE?=
 =?us-ascii?Q?O9QSH6biGzrR/p8jnshiHgkg4mkq3Jozhp55lM3t/uNar8xPW5XC9X+G1EpW?=
 =?us-ascii?Q?NS6poYbAyUNUIWb+kb166vTTsBQ14I8KqCUNSCj5s0EzovOTMGHAxCekfrNz?=
 =?us-ascii?Q?HFEdLNzNMFtAhRBcItol7cYev1jSr78wFmfN8BbtHgTyXtTqEUZ2vbRTgYeW?=
 =?us-ascii?Q?bPd4m6ZBSRP3lVGvGjW5r6oQebHTbxkIM+XIuC85B7vDPliinifQN3yulVlM?=
 =?us-ascii?Q?rK8fiPoEijpu6BTC0a0l8SJXzF3BcQLlR/6/Ks+EgotIYV02m+Rkc5GleH47?=
 =?us-ascii?Q?MjSt9OwkZoZyCPbFMIGfHSCt75UR2c/DyYGjUJY3H7sYw98+9f/zRHfkB4D6?=
 =?us-ascii?Q?qJUwBHNgbzkrH17lu5Va0VAfvGpbgfluKaLGhP2s5+aOgETmXZtfCOBmjwT0?=
 =?us-ascii?Q?dYkgn/ncv8jFhUR1zMFNC0KO00YFXiiP3WxYpszRIQE71ysfUOEniBU/glBv?=
 =?us-ascii?Q?xdqBbFgeayEAo+j7c272KRZNKIP4ZPekjjG3eGnLK8WEaDWJ8EqhRETsg+3J?=
 =?us-ascii?Q?QBQgO1hcW4K+HA2c3gNnGBgTjj8EqUAlR3QqZgL+5+rN7mrtBy0+Snuiv1s8?=
 =?us-ascii?Q?qU9/RiDG9BJsUv6GjmutvvpxMWo/GJq8q6YWO/jIMq2p1Sg3QQ4lKZkNaAeq?=
 =?us-ascii?Q?X8YoJ6/eKw+M1rLGHV7MySAMoLisdwDVBnwYPXhugDxlcDU+QccyMbWUOJI1?=
 =?us-ascii?Q?rgMYXQ5yxrsc64RzTxh5tYFlCHpIgHLsgkyDNh92ABmxX0czS5JE1d//s8sT?=
 =?us-ascii?Q?2ttP1o/qAws7oup0G2i8odGH3VOthiHf2O+HgJmN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb101952-d08b-4ffd-db2a-08de1da3bd6a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 02:17:03.0554 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IrhGxkIr01uJc+equtLfrD/8U49izcOM7D0YDlPguc8Xb2sIZzMWS1/+9vw2MadSdZD+8Jtwnuke0lNIIS2XHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11018
X-Mailman-Approved-At: Fri, 07 Nov 2025 05:40:31 +0100
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

Hi Marek,

On Tue, Oct 28, 2025 at 04:41:03AM +0100, Marek Vasut wrote:
>Allocate all sub-driver instance data at once. The amount of data that
>have to be allocated is known up front, so is the size of the data, so
>there is no need to call malloc() in a loop, mallocate all data at once.
>

There is conflict when applying this patchset, would you please
rebase with fsl-qoirq/next?

Thanks,
Peng
