Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85863FF885A
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 02:18:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 159FE846BD;
	Wed, 29 Apr 2026 04:18:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="I4DOda+Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A34C846BE; Wed, 29 Apr 2026 04:18:18 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41A76846AF
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 04:18:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Flyi4MbqjAYA828GRdDd3V+u2fhE7o+LFmxjXgpv6XDPoEeW4gkM8jVO0gxzBzNVER/pdqUcX3JA3S6yScxXModpfy74uRbjV/cShct3i3fquCu445Gus9moFCoe3BkVn6cA0IxseWZZwHlMo/Ynr6yvdv7Gar+mTbJmum4pMFo2NWnF093wBn8ULi9VGmUSnp4U/O7zOTe1O0sri9bt3zssBoqmfVm8g5KcvFLxo2pY+cfegukS+KvAyFkEcbkwclUQujwOP68Y7TfyK8hlAJ3Oahrrtx8ayPXe2iOLZehioz4j6TvxtduJDOfSjMg6e2CeiBKmmOFVQx7QojjfdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3ZCZfBDrJjqYQ8UOV8ZklFMCd01QZ5hRP7NByW3SII=;
 b=N5AzMa112aSZRwCVixtjqYd3xGWBcNTxCmBKgTZBmH9DFen9XwA/4UjNnv0Tp1lgSC/sHtoI3vWPQzHUHpCJPm1omi9Q+k0eo8GXwsdb5c8v1qdXM+VWSFD3NGHgjfWp9+oe9Gh+l8SXTJ3VmMZE/tDt2GAGnW5JvVWF+KOVo8jruw3CmdJqAE+0LFN/qi1VAr1QXI9S+VC2/kLadvmMFiUvzUUa58Z3V1RRaIs4y9bG15GP3NTnI4xknPRmlHihI9qVnmjOBPYBMNkZMFoi+6x78Cfr0Jo2JoFjCx/BKugE61vgZ4iLLdLYoD0PzZNk44r9RpShe6Gz4ZBFGrPCOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3ZCZfBDrJjqYQ8UOV8ZklFMCd01QZ5hRP7NByW3SII=;
 b=I4DOda+YmeOb3pgTzJZfteB4UuswJKQAuh8Hv3v1FvSQnlK78rMaFktJTAnYJBQve45Ua+5tWUCQ06whG9Gd1A4fXAOmmYM3kxFFG/ju6MQYQmwlEed9Z5rP3fAm65MIJh9ebME6yb3ldVun8YNHoQb/McEg7EhMRn9NCUz/jNLut74fNBI8X0ugTuXjefsuKgWLlyHLR/gbylAjxzdO6SsA0YpW/M6USnriqSYYdpSt4XFopGPa8FEM7RxMzizFhTEFEiDH31pr6+TuvWAbHyXwWK+Cit5+Cc0taCkyscMd89LO0Vnoww0iCBdf4ur5v22oqu4obqE8jtbanpCNWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU6PR04MB11158.eurprd04.prod.outlook.com (2603:10a6:10:5c1::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Wed, 29 Apr
 2026 02:18:13 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%4]) with mapi id 15.20.9846.025; Wed, 29 Apr 2026
 02:18:13 +0000
Date: Wed, 29 Apr 2026 10:20:51 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Brian Ruley <brian.ruley@gehealthcare.com>
Cc: festevam@gmail.com, Stefano Babic <sbabic@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@nabladev.com>,
 Huan 'Kitty' Wang <HuanWang@gehealthcare.com>,
 Ian Ray <ian.ray@gehealthcare.com>,
 Martyn Welch <martyn.welch@collabora.com>, lukma@denx.de,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 3/7] imx6: clock: allow different clock sources for ldb
Message-ID: <afFrA4Dst5lvEVc2@shlinux89>
References: <20260428085117.402523-1-brian.ruley@gehealthcare.com>
 <20260428085117.402523-3-brian.ruley@gehealthcare.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428085117.402523-3-brian.ruley@gehealthcare.com>
X-ClientProxiedBy: MA5PR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a8::16) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU6PR04MB11158:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dc6061f-f868-4118-bd07-08dea595910b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|366016|7416014|52116014|376014|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: pkCdBsa51isw55ymZq5l4O6wbMH8J1a+BDAGto6oBlQZbk7RUosbGERmAcQUb43iO9dkpjdVfJ6C4E6xijiuUEzSH7bVM5dRZcdEyzN9beITYE0YYkyO61P8IMA95XGqsR9W5MugX7Yj/mP5cC/3B0LKfen2fVp7G+GEliGTkzavVyY9I+aYx0W/5oYrkxPE0TD/3J8Ztzt1K85ap6oGZkuGdqyoP2ti7rQ/0LMaAxnK/BEU3d8H/KwVDLAZdBYWgaoB8yNzgNxnfYHQzNpSr5TTMdDxwqFr85kuZAtA3KJP5XqZTZSzhXUT1yC7Z2bdwopqNKkr8+7dvIQneaCnvy9YpInGbK0ujWzBhrz94uZyQ64TzyexIYgZDmt/fz5XqJdFJknlyck6BBYFWRo+Q0WsGJbimk6eaVjPd2UY82NuPC1YQkkh9CgvJ8RcAx+9y136VlLK6LTjZg+SK/KOk3VBmcjRFyBp7S6BFVvt42+Kau4k6TPtAFtQUcVyIIbPE4SRfVTEpgfoQWgy1uZgl4uG4B5qSh9re32oIbQCT9HDnZou0rK7yQeJbrSlF9Ss/g0Sq9M1lj1Wl0hl0SKcInnu4e7OR4fOERbseb1XpixHbQDqTEAuqqFIKTitAL13SET/V7hyqEw7qXTF5q4367habmC+G2r2v/nIOytNzRC+xL3jNSwrQZbYmcwSOCpdPO0mKvyEHBeRpQLGY7nDTjLt0OAsgnFOs2c+gveQLu0ErnJyBQEk6WR9yRpT38D1OS2E3TMoDDf5t0blbZxAWfLTPJFqiIHVjzn4oqE6up8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?azhGBrr3IZrzcy5af4C9eB3UjtToAnbe76UQFtHD3Jj+PKCCo0zDfCdMXd5R?=
 =?us-ascii?Q?xsSWQOCkRC2Klkk1qmWgY4RH2U6JQttiGK8Qivg9HYwdza3pIhbOGdFok58U?=
 =?us-ascii?Q?zDRneIWDnXsHl28rbNSt2khzvwsn/fyseq64MXd0TcMy7f2vPubrZqHAJ+Jk?=
 =?us-ascii?Q?jqwhUYGG3UhZerHXYFakiyJBSwql/hozLOCqM43VLyi5QsVMvtNgV2iPrWja?=
 =?us-ascii?Q?ISgx/V+jR//BIyIXv7JTCoU0vYCP+X8tk7Sd+8X0PBxO95dja7Y6wNAbRD/b?=
 =?us-ascii?Q?U8C2y737p3uIz3+E542SczzgNtkByswcJBShVQXMB1qCqsS6Sy8dthe3tEum?=
 =?us-ascii?Q?UsVZLj7vjqpBULYJrIlLACysE4vrHXpjSDe3aM6G3l2ciuUkPjczYrKhvgYY?=
 =?us-ascii?Q?TGSfoJ9VPJ2AXeKILUCwhcFk0x12UFpZjNwhI1IuLJI/EGzfCKy1fGooTBzT?=
 =?us-ascii?Q?86O3AmHWAwZgo0uPshrpTnJDziZU1qzU+3kkNHlZf4LOJBr4WVu5SMPsNiox?=
 =?us-ascii?Q?0DXUBz5tmnNBmitn2yoBNWcwSIiGeEd5VfiFnw5izJHSc6aacLBzfRi9HOBN?=
 =?us-ascii?Q?5DM0p5tXu7/4sY8jJ9ziLwUqhw1fK4FHcs0WxQQpk3xqS2zlDeQI7ckhDW7D?=
 =?us-ascii?Q?b9B0NIDOnYZvcIMpHL2LYz0eWxR0Rf96NBMUo4xxJYWKj6apfQ3ddx3LDcaa?=
 =?us-ascii?Q?3UWtf2R6Gjx9e+9mzG1uU64/VZjUqfcs5+gJkMlw6CcV9GJdteOfzf9SaBz5?=
 =?us-ascii?Q?tL3gH2lBOjWn45MWOSZ/oDh8bLyKNvMC0k94ZnMFDK4iAKsB4OgOEQdU3EeN?=
 =?us-ascii?Q?C9La7w672rVn0FRlQoUYyFeQ1t5mmtQf1QBv7BQhYaQdyy5+7snH97O+xLOI?=
 =?us-ascii?Q?MAE31hVjoo0GmrXOt4NhEs1Rr0/ztN4eKo1neIleYCYTFhNpk1Fuc41CQx25?=
 =?us-ascii?Q?I+c4S7FRx/GsmOfcVKkBIEwiMdOX1DBndMmyDU8hwcF28bmc/Yc4STw18hAi?=
 =?us-ascii?Q?h6Q+TvJ3+dIw8SGz1Iqa905HmReweyZIX16tVt2vpMdObwnem1s5bHRLo66i?=
 =?us-ascii?Q?QkET9NUKIotReKp2f7Ac5+I16Uk6cK034p090f1EmEFl2TpyGR9kkkRBbGIu?=
 =?us-ascii?Q?rp7EZDwry1eTSeEKTAv56wyObt9CabtFJGeFLXbl5yYrP99XmSa0uHuYF1xD?=
 =?us-ascii?Q?NJ3LH84CMSLLUWEFoSt1adOu/2oFzcCzv9InNxUlicLiFh7B0H2yaoRpp+su?=
 =?us-ascii?Q?X+b1cxrXyyzitF6svq/dZiWV38TRpkWij+E1VlMvrYSA7CW3at9eHcTTo0kd?=
 =?us-ascii?Q?ehGCusKxp/y4Y4fK2fjRVrn9+fPivRE/K8E4Mnm41lIvYOHPzBax15zo/yx6?=
 =?us-ascii?Q?ARwVM6jb0pYfQe8Hy+XcRkEFQ7FaEMDB9d4O3R5T1Xl1NP18/8s2/GHU1EsB?=
 =?us-ascii?Q?hOOg4/mGIoOpOfT/LUaEvpXz7St+6vREZOWh+KK2VhCPQgqpaFp3U47QzZjc?=
 =?us-ascii?Q?QUN3KS12WzFWd4knpJlWDe4SC4D7MFAyC6DvxnxDRpNqlZqS5aXhqiK7bkW7?=
 =?us-ascii?Q?FzG/2vNDqS+W3v48iJAmPOGP+vQWB7xHFx1AQBNlZyLmASTZ8zmsh8LOIg0m?=
 =?us-ascii?Q?+JkahUy7ze3kdHjLZYb37zeEWtIrZX7nNBXAdeUkLGjg3XsFsEZanU20FE3i?=
 =?us-ascii?Q?ZFseLYMKfPCGS9Pa2W3hkxpJmDvqMQsCNKWXB+qlH7tsIjaxq+MRGRSfnB+7?=
 =?us-ascii?Q?O6+tO+vkpA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc6061f-f868-4118-bd07-08dea595910b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 02:18:13.7133 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ze0An1y2v3MVmeHMVDJTu2uktGo7Cv6d3xVW5+W1CWVdY/vs7HzKXTceP27D5ghts9B1oroX5FIODS1WzHEdKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11158
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

On Tue, Apr 28, 2026 at 11:51:08AM +0300, Brian Ruley wrote:
>The LDB clock sources don't have to be the same, so allow DI1 clock to
>be configured separately.
>
>Unlikely to be significant, but the reason will become apparent in the
>following commit.
>
>Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>

I not see other patches in this thread. Have they been sent out to list?

Regards
Peng
