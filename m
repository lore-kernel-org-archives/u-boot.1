Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84523CCD1AB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 07:25:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F5E883956;
	Wed, 22 Oct 2025 09:21:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZEWRGRJ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEEF6832BC; Wed, 22 Oct 2025 09:16:27 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 154E782E34
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 09:16:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mCoAYv6CNUVQceOKV2VKQ69sKpQUIllDH+f4PSQWvVk9RX2qZOYIonRfavPlnVZRzr2tJ4tWdDEgAursQfjl6AIJVdO+QCOmifbr+2pZdF1vboB9QCwjByCXUQAeJ9uTsHB9N/8DUc/rJIVtemRrXNV4szT8iZpK/L/BmlGeBi2AMuY+G4obtNjDis0thuFG3zOl6/AQ3XLatD5AaudnilfjrlG48qNi693veEv4GiJBg6r5VKKQcSOlY6AMvBYmdUXbrj0+3zlv0MXPYbgQQ7IVvmw0LQn4WjqaGUtUK0Ea3r51B4yAwyHIc+Yyfkc+tzs2/6GekIplmqHqNRb2ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6TsBvbZhu9XJ76xVxVOQqbciJd5jMxEQbEZpP85mGw=;
 b=UutqE1bSxOjCZmvvznHcs8zEaVjSeyIKmPWPTE0XFYXAJTk3PMSRqZrv+tnDKV/Mn7VMqHO2z11qbEb7L1S1Dh0jtwZC7as9V72PEQvtQ7N7QlKpSNuRd2FSxvycR+AxMagm0lf+VM04Uit9huVQWow/A0DFykwwLt2LTFalkErQYEuhmrfBD2eSjUteSG/RKMFYKfXPYUtQT0yxrCRxUcVKVE6TLbYKziCuc3+FFm0ApBNvGahaEOhUyEEtCvEoIV8ur6FYRdsATotybalfIbA3JtQnyCb68APEWQJAR2b9619CtUY5FuT9HVh0fgOv9Lea7lK7We5jXIEVMPhClA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6TsBvbZhu9XJ76xVxVOQqbciJd5jMxEQbEZpP85mGw=;
 b=ZEWRGRJ3ELuaBhDBly6iMU0rnSAYwhoZao2TLF9DJU0I2ri/hNWT+n/4rOgxBK7ILtbHMAukCYm3FDqZHjtbeixJrnDkDl2AKbsxQH1s2h0qlVJFrxaWj3cugZ629f7Bj15FgM5as25S02zbiTvk0leIU2n9XivdJObTHAccQxGKPXkgyhIre+yixBrzOYGIirCY/shN6bHyPQJ/80TrsQh8gne01nKkfyWtmpno1+TDZz6onBpXqzTDRH/bZgEEq6pTKG6KpPXk7ZwyjQ5f/vhDA4bgKXdWTL9zFr5Oi6Gmh/8JYzht8TFCjuNnxMlQo+ylo1Yf3ZxzoJ7uaQhn4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA6PR04MB11807.eurprd04.prod.outlook.com (2603:10a6:102:522::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Wed, 22 Oct
 2025 07:16:24 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 07:16:24 +0000
Date: Wed, 22 Oct 2025 16:28:38 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Henrik Grimler <henrik@grimler.se>, Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH 6/6] power: pmic: s2mps11: add support for Samsung
 S2MPU05 PMIC
Message-ID: <20251022082838.GO30163@nxa18884-linux.ap.freescale.net>
References: <20251017-power-pmic-regulator-s2mpu05-v1-0-91cadc0f4156@disroot.org>
 <20251017-power-pmic-regulator-s2mpu05-v1-6-91cadc0f4156@disroot.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017-power-pmic-regulator-s2mpu05-v1-6-91cadc0f4156@disroot.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::20) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA6PR04MB11807:EE_
X-MS-Office365-Filtering-Correlation-Id: 773d5e34-7e55-4fbd-6132-08de113ae8a8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|19092799006|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZD6oag5pSxPImr8NlGQ2g9vz9xLzPd8eCcc/kJQGmwVqgLUtRQvL9UbDwSvk?=
 =?us-ascii?Q?v84MwRYflcCg5w25xRtWilURD4aIa4wtcLydXIUeFebaxp+j4dH2c6U8Cu4k?=
 =?us-ascii?Q?4djB4zIej+JbuqD+3cgt3pQB0T/7ndiGrRbfnjig2ogjDkFB3D3yiYawljDh?=
 =?us-ascii?Q?RKppyYu3DT5O681bWHj05G9SnQVB5pRY6vQruYsNsVIEnTAXmZaakgkm1o4y?=
 =?us-ascii?Q?zAQUvImAqW0KBhN2eP75WZz9ODvnHA2VBGMwYsVNyZPxQZdP1E2yVFjKEXYP?=
 =?us-ascii?Q?yfGmkD79h0iLCym49ztCElFTf0Ekr5N13c/f3wZ7ygcyQf3uN+vgcGv/U0MD?=
 =?us-ascii?Q?c0OIjceRspR3vng6vBLArjl99caA4EfMOjYRdaekSu30rb0pPnviRBSvt/gi?=
 =?us-ascii?Q?Qf1oIgykpxUdbBeuCo9WCQNYcDzB0Clx/rSE85gxgtzzFklZjvmafj1bsOAY?=
 =?us-ascii?Q?NStrIaEuQwvhuG7gSOMgAd5xaVPSVQPvwy3WJNb+IcUo0oaYLSYxppi8mHMr?=
 =?us-ascii?Q?ku4QmKHfLuBViA+Vwyql82z3d2jDZpDdyyCBy+adXfgEkBB8BAS+lQzOzFss?=
 =?us-ascii?Q?Z+OCkSS0jkObQ6EeHb7OGvl9pZaoeKq4TvfllnrLtfxtRT8B9PWXrSy7zq+J?=
 =?us-ascii?Q?ciD+Y3kifQKJptLg7oEMa71vuytJIIBA6Nkm3P2me4VOTiYID2WqtrxFYL7a?=
 =?us-ascii?Q?LiuTUXZOYeVuRfjQrqNXvXwV1uUz1fsIDXGlNIVbbcFCPaiyKFmDSdajSRcn?=
 =?us-ascii?Q?dx1avKZyi5+7EUzflgyVDwcLamDiad+fVTVFyG2sdvdpwdLOiGxdTjyweyKL?=
 =?us-ascii?Q?w//S3ZD6obbHQm+tSUZjFeNEFKnj20kweFTGtzikum/eUf27NoYUTiJVZP2X?=
 =?us-ascii?Q?nV0mHuRc+Ng83MO5KaUWUEfgwbzHUIlnWpznbathbt6Gqaks7r+s9Ep8JOW6?=
 =?us-ascii?Q?Cn+j0+jJXiWrvW+mqMBkQBu7l6eyXVogd9ibb0iUBwlWQnoG8kXE6HGCOWBc?=
 =?us-ascii?Q?uljbLCpFd1Nh5Cb6kySpu4C9FhmW/nAPIKF3LTznqEZS3vg4kh8cf/h6mpZL?=
 =?us-ascii?Q?161yXz0Ag/+cc8FU6XGIU4/1AAF5WYP7JDGeRBaTyk09/n1HslcWA8ZDt4uf?=
 =?us-ascii?Q?Bo3tvWNUmlhg4uCq6v0bYT7ZtpL/IBq09K/PnGZYtuTGyaOa7Hxyjmcfdl3N?=
 =?us-ascii?Q?izpoo5AqwEbKcaGECyV5N5ht2cCi2aTBOP3f5bqjNDk1vQU00ynpGj9fCs0B?=
 =?us-ascii?Q?HnSdkqNA/mDjiGkE0/jn0cI4rKrDud1ve1aG8HsK8NMyGkdMyqvFRh3eqn4P?=
 =?us-ascii?Q?JdStODnctnEhHJGvioDF4iSuecPERsrA+c0LN3AjjilnbI3V+6qJ7MoLPij6?=
 =?us-ascii?Q?JPkNRnY8fFLdHcY5KTsjYgA/Xu7j4JxFTxqR9poljip0oPbayz5kjjOWtnib?=
 =?us-ascii?Q?HT4Ygp6J4oDkZ0qYy9gbrapbU9Dx/dqjFk8zzOFsnOgd5x9QELzxkWIeDFcy?=
 =?us-ascii?Q?GWAUhOKuRDpGAizpv62rU7gnmLI4iR3ACEkY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(19092799006)(376014)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FdRfWUSis3YlyhM3xqO99okLixdhAebWVjm7TTG8HwB4vn6ny/f2T300OKHc?=
 =?us-ascii?Q?Jv0ouUl1rLeoqlFgqFIu8n74uCwn/I095DEUH/Uxhph3O+sAbC/gvHuiJ2EX?=
 =?us-ascii?Q?iYmf3H+WvL/YNCsdCVWQuTKdnFO3Hwve/MlMxIqDLtXLa8nzmuk1PF8U3YPy?=
 =?us-ascii?Q?u4wdM8Ym3QBLldUk7eiSNKxBSqMovAQrCmr55fzO/VK2CjsMNCIjVJ4bnmnQ?=
 =?us-ascii?Q?R1zWTVKjE8sqB41QRtmQruNT6kS+5XGJsRXX2npfEj9he7DuCXqMspWz6nrI?=
 =?us-ascii?Q?IAAG2Gr5uMRppWMCRNydzBwpBXzkuFYKpDrOsLwEauHM/Jys1zx7qq+MCj5/?=
 =?us-ascii?Q?m0M7Aa7J47XlKTAuwwT0k11MHP55p2Qb06X652D78wpaIr7qMW7oMdd8BAtK?=
 =?us-ascii?Q?SYA9J+gIRr7AIryG5x+d0S7mBwbO50FBjOkUDLuI3CGi8o4EPvEMW0n0HFsT?=
 =?us-ascii?Q?JnhzX77/YnTKxoNaZoXOZOQ/ZlkdGMdr37oRstIFC05Kh41zD8/TwZvvF/E4?=
 =?us-ascii?Q?wCZOFbMUKYq1hkycQeoZj+2HX0ZyBdFb68sLVVMd7Qe3jBllvsPd+ePhDHB3?=
 =?us-ascii?Q?Oq92cnw0vs0uDBBpRzxlL6Lk9mV6NZ+bqOniZnjlkqWx72NYYqHNaeHv8aLP?=
 =?us-ascii?Q?5Dc7kmDh4QUaJrYtEDsGCjwEs9X1K9w2lhr2dhJZUZVlg7kvvCEF2iApKBrY?=
 =?us-ascii?Q?mx4UcmU6Ng4iqIT5TR2k54d8e9qjhUVn2+00tTNuYi9B+C4k4dkRpBEG6eR2?=
 =?us-ascii?Q?q+hZUyZ1f4J2FcKdXJv6YQDbq9FcgDkmnyMFx/Wokiy8PbYN/Xlbt1tw1Xzu?=
 =?us-ascii?Q?vrNNOz45+aznff6wjljflUCqAIJYgmQ35D7FryNPS1jq+RQHRb+6U6ectYSg?=
 =?us-ascii?Q?t++v2l+GpE9KBICRyS1UM7NaPHpuBAZCHORsk+aeuy6XV45Fa+HkGESESrci?=
 =?us-ascii?Q?Yof6NCZyNDNSNQ1pbq3BnYBqfmbKsYyaUXPpijQL2s0cb7ungQQRHGYAEEqQ?=
 =?us-ascii?Q?ZgvhAgwhAtib/yHcUlWI+ndrwn7s0HVnZHD2sFXm/wgN/exk2oFEIK8YFNbl?=
 =?us-ascii?Q?eIlXpa2R3ubNOaY80r13hqS9qJxyCCk86XLGI04b1W8Usc4ZD/E3FvcUWpJp?=
 =?us-ascii?Q?BVxKM6EbW6UHp+KCH4ul3Ggq05V3DNtqPEriGYFa0pZYouHa1vWqMyUd1FmC?=
 =?us-ascii?Q?YTonP2tUjHg0R3e0gwTQY/r1kOGofwc4pRK+MFUFanJNhgfV7ayzoDYBI9nb?=
 =?us-ascii?Q?faLNV34Nsb9A/69Eb+xwohA3QMHxuxdsa7IEel1jcV+GMyoyDuzXGUQ6DNmQ?=
 =?us-ascii?Q?NeP+TVxDMLr0JmwGFzP59WRn97kH9KfgsUJnulD6k3tvfPk1F/Hz80JXksUz?=
 =?us-ascii?Q?KZV01B1BWC98eWYW4b1jAUSnXq5Cf1ETCG1LmOjP8CWaPtjFRAZZqOOkD8WA?=
 =?us-ascii?Q?rcExXJR3+JvYbOnsUzQypeLHQJ9fBFrgqdAu1vpu67GeQ2ElsmZyE/9u52/l?=
 =?us-ascii?Q?AfW+IqXaE8HsV6/7GK70byY0psxXEAMSvxDu1YCItdZYcISjeKLhiDFloiBG?=
 =?us-ascii?Q?QEz7ngWAF/kKykRW4awopK79na8TK7E7I3fZX9pe?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 773d5e34-7e55-4fbd-6132-08de113ae8a8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:16:24.3776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jNKOlyD99tJiFlp5dZGsXJf0hI6krP6zatbjzifAeNDsLHQYlzR+jy7gPtZYArB8Z/uyv117etD1unCCQ5AoCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11807
X-Mailman-Approved-At: Wed, 22 Oct 2025 09:21:43 +0200
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

On Fri, Oct 17, 2025 at 08:58:21PM +0530, Kaustabh Chakraborty wrote:
>Samsung S2MPU05 PMIC is used in devices with the Exynos7870 SoC, it
>houses voltage regulators and an RTC module. Add support for this device
>variant in the driver, which also binds the corresponding voltage
>regulator driver.
>
>Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
