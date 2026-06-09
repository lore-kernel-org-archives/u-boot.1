Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C77CDCD8CAA
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 14:54:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D50484869;
	Tue,  9 Jun 2026 16:54:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fBLpCpFo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 949D88488A; Tue,  9 Jun 2026 16:54:11 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B84C084704
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 16:54:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xT7sjN6ikG4cDOtScPmX+f16ItoTIvZ2Kqybuom3QcvRpwav8QlibjrHZnY83faRFXjSienfhWlg19B/o9BC9hFS82L93wjJ+BkDuzTAsIn1QMqJzomfTtA7BdvcTXqijP4ROv+GHYTg9falFL0KralfQYyRFj5iM+TGzXB7OS02GDyqG5IDv7UcfFh54ZX9Y9QS8MNVd7yqj1Pv/d+TDaMdHzf2mUPBG4sR9M4Hn2R4p0xDCREqt5EbHFHlAfwTw2CJtj6sYUe3Qh1RfxXEbbV8HSXMel5cg2wxsKKHEOidn+cYR/eqCklsWtZC+liyAxQRRNbVfwNVCVkoguVuTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XL3cCXMv7IKGvcsJL7KIbr543Q1M/ekth5lNmUB722s=;
 b=IOB52zziTpTUC6/oQFvrf3Ib56dmO0iB6fIMmBs+KmWVw5H8qmuwSm+uNq9YOfo8tbqPcFNokWUKhMYPZ/YT69wxgtg057RuIpM1d7Ph7nKeFnsbhm0jkv+wv157rfA9dwOMCt44OMn/m0KQpc+6E5ArycayG5BmjcEO7Kn8ExDcw9KEvtwc2wo/f+L78VIaNUiZJiNkUPAX2glui51sFXAfJM/oNzyIwrnu8fp5k5bk7QEeBy/af3LQ4L4MOoqPJXZCeFrdkTEMmMjiZGcofl+33WkbQz5RUnnYINMOx/KmdQEFwNwMD+Vt9WX9vXPCLnk8IFm+ljOe4DER591Nng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XL3cCXMv7IKGvcsJL7KIbr543Q1M/ekth5lNmUB722s=;
 b=fBLpCpFoFueDwXCmIHDFcl1aHIkAUy8w+Yo42573KJG/Id5f2klyzOJBB9OqTIvk2AFx8rB8rL84XukEoy5QdQsdx2tWShPni3sExCQQKDPqUdyKvhDACM4y4RajuQlkr/z56BBrGoSCi34ffWPkeGYNz1ullbEUME/kGk/bGiG5G8Z5uEFEUJNxU5yIL60SfbT4kI7z4vKKk6fbWFbCZdRSNs1bqS+It+iBzr4PoQp3h8NQ8eH2gKE4cuMow1wG3iBcEOeOTcpa5GlY7T5mcqDjR+O6rPqY5kHdzVvut412Q2f2s0otrB6lm8JMCwuT2Ymr3h4vkHrbyrocYCaAwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AS4PR04MB9716.eurprd04.prod.outlook.com (2603:10a6:20b:4fa::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 14:54:07 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0092.010; Tue, 9 Jun 2026
 14:54:07 +0000
Date: Wed, 10 Jun 2026 00:11:15 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Ye Li <ye.li@nxp.com>
Cc: festevam@gmail.com, u-boot@lists.denx.de, peng.fan@nxp.com,
 uboot-imx@nxp.com, ye.li@oss.nxp.com
Subject: Re: [PATCH 1/4] imx9: scmi: Fix temperature range for Extended
 industrial parts
Message-ID: <aig7IzwaZhwFZmT0@nxa18884-linux>
References: <20260603055159.414338-1-ye.li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603055159.414338-1-ye.li@nxp.com>
X-ClientProxiedBy: MA5P287CA0195.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1aa::14) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|AS4PR04MB9716:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f56307a-074e-4db7-b9fa-08dec636f4d0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|376014|52116014|38350700014|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: y09vEot0QF+pqea2SNNM28Z/1Zkai1KwHrOvkZG157m5SQ9EN/8qtBsDbnAn+q14QgKdaswtGZit+ajXWrjSunkBJ99Fye7wyxYASQDENe8aalEjkqTvXVAwjlCYFioOHPN9J6VlED8Iw6HchEhAflGwumiO2FOoEH4ylKDbMYM5vDdHXHNep61eirlzby0XKZLRLVo3sNQ2kMShqLwMcejpQZT7yxC/86V12MyAJxvSYkKbj/6eyzOOLbSeSoPAA/koZLoQxjerPKbu/bXPwSCobH9laPLsCFokebANiwWDKln3Qz2Yc7j/eSJcyf2MdgvImiYA144I47NRAalzWupI5t6P0u0gT4Sk6TlezNx1HTmSzS0PaF0HJ9zUMnPs4siexWnFkAwvIHSabCPwH9qnsapKMt+l00HScyClVfxuH1UfaeDteASY/lKOhBgTrZFcPGMKTkitpeea/rpo5p8o83VvFAAq+mk2yS2nOrtWDhpnj4PrzAnI6km0YfdSQAyuNoSKdKCllG61AXTkf8LUR6sVezI//ccXxpM6AZHxKnbJzX84RPivLBNvAoenDCL0pnvA6h1s/otZFEf390BZl6rYky71QW9R7yioWV6IYj8bzkZqiiZ0EO9HzXyNymCm0dwAGiKOjjWaVLDqz26oho7Q80qbDlYkwplzC7iUz0TSX09uknGAKO+2Tj+C62aueKGkvE2oWv4g8jj4CrqO/u7xEpXP5xm9Z9UijwzH6j43mwQSHcmy9WSvOQs7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(52116014)(38350700014)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+1s0Dx3vF87LH/1a8SQ8y7cimZaH4EZJ48enU07YT5Jv2P/S2newURtI57F8?=
 =?us-ascii?Q?cJJu9b7z1K8nD2jRVUP733juupX847JukESGjMBMqJO8nvgIepCPkpHvaYdN?=
 =?us-ascii?Q?rNzxoUbcCqgWztunlicY3ipXPEZO+VWsO3RF1gtoyTHoMlPTfeGURZgASd85?=
 =?us-ascii?Q?kxfg/jUZTUVhbUPR/tfBBBPrgpEKN3+MlcBjzsyQ5HUPgtzFu255MIB2lhyr?=
 =?us-ascii?Q?tNmW92k4KH1tTT+iY74vTO3KntO+XTgeH2vvclKMDuKt2JDcapu2KKCmz/yN?=
 =?us-ascii?Q?dGxvaAkLqcHmymcLvBdHVhRqJnufuLFeWSvhkVg5yNTXRqJVEeUBjDqRnM7r?=
 =?us-ascii?Q?j8GnYaWLWBwucf7R1flYWUJ8bUNixBiu+wSZ+jN0SIOe3Tb3hKDnI8IkAY15?=
 =?us-ascii?Q?k/kmlso2WD2jNIi/0PMIBxNm8qr9YfekW3ozxkW0s+ptFHDNSXLruBk1+Y1w?=
 =?us-ascii?Q?n5OI9uP9Ws/v1HxF9YAXL3CDdO+arltaSPSbeW+/IzPwPxtKS3Qc0DkZmHYP?=
 =?us-ascii?Q?25OvgS9UFClwkicFqaUCZUIcP3Rf8dE5H9pRXenkc/wPT0J9TB2UtgMbNFpC?=
 =?us-ascii?Q?7l6NSTXDSs/jw0s9c3oh5XucGJ+X09RvWywz3hFVYCBo03vUST01DAFGNUIc?=
 =?us-ascii?Q?DYSM4S8ZB4ilpxIBwVENRBNAMhiEZFjsGeI60J5XEx2yj5EpAFvuQZfY9AE/?=
 =?us-ascii?Q?fhVtDS1qMixdH8E5jAHgajZ8CNWrWt3CKA2RvD8dDPVSCy2Vyg5QgpE/Ot8D?=
 =?us-ascii?Q?6iAyq7yLJ2WaBnQsu9dNNw36aupVkgNfHS5IVUbhi8AUTrIkFyiuWjwHAbPR?=
 =?us-ascii?Q?acLPTTfYT8AuFgnJFg/+Rww+4xtbdGWnw1VmQ8F9Z3JwGCd13BiCd0TybhYC?=
 =?us-ascii?Q?boF1Mv0IPQY9AmeY7qmOihsaqsvvT/bQI6B/Pj6yA1/IZVgHlimSSf+4lNQ4?=
 =?us-ascii?Q?3RM9Wvxl8Zjz04bqiONnlv85Px65J+4lavxBahqAemM2vmMuJsUpqR1jlFxv?=
 =?us-ascii?Q?T6SsCLrm3mJCtNFenUeRh9CMCgVVH7GpbPJmQc2mFzkCTXqoPs+yeN3Ol52P?=
 =?us-ascii?Q?oLW1xnAIblL3fw3OTBwn0HFDX4W+seuJvq/atwPHrse9q1MMdoZIKTEg6vme?=
 =?us-ascii?Q?SyHpAjTtsAJgoW029QYQ7MPmFeT2iMbaZugEUUiEW/7vc7ZyLBA+5NK3iEi5?=
 =?us-ascii?Q?IP/BFPaxNkiVmhHXePef45Sb7rmQXwAgHfeIIpVyIHlz/xCGHIWxc4Gfeoxs?=
 =?us-ascii?Q?7JYoQX2RaF2SKzs/LlPJKzCuZsNHsCNlKfbuzBPVj47MWvxXzjA64oP6nYnJ?=
 =?us-ascii?Q?AcRN0QhMLmr6D1XEcQDbe8MKs/HZxRuQSlT28PdKSdrcNkaNUNyd9jQGQnDE?=
 =?us-ascii?Q?ob0A6kpuVqhq4rTKKEgbl/tWOg9pE3SidVlF7zb30qkQxLbFNIcIPGrhd+d2?=
 =?us-ascii?Q?aw1Mxaz8gJb+MyGLHQb2Pmb4uOmF3CUBT0gup7nCK4jFkF1AgTqTefPpJhJZ?=
 =?us-ascii?Q?GqMnVRVw8ZP+TmaJ23GsCGWUwrNRJPEigb7n9wanUHCoHwM877MchOaf8F9B?=
 =?us-ascii?Q?Tn8YEXg9UkoVwyaNhhIS5mNq3SrxYDVNtYOb9N/pRvs5kz7RZIaNi/2MZMHJ?=
 =?us-ascii?Q?g4mIQAHRNkDQtsOjVo8BK34r4wd35UZ/VJWXpSTBpE2I8ROJwfbPS03dgg3d?=
 =?us-ascii?Q?8tQtK4G3jSjkbucc8Oj3fH/+9UROQwFDy1Qx+j85NiJHL8UDpagqk8I6FoPO?=
 =?us-ascii?Q?OuxEsppALA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f56307a-074e-4db7-b9fa-08dec636f4d0
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 14:54:07.2392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xIZTzR4kFwC/rJXDsEbgi4d4q6qNo+s84RNuOnF4R2e9n9us2sVxb+afiaEz102jdJrbiFl1mengNBsILQaF2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9716
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

On Wed, Jun 03, 2026 at 01:51:56PM +0800, Ye Li wrote:
>The value '01' in MARKET_SEGMENT fuse is Extended industrial on
>iMX95/952/94. Fix its temperature range to -40C to 125C
>
>01` - Ext. Industrial -40C to 125C
>
>Signed-off-by: Ye Li <ye.li@nxp.com>

Applied to fsl-qoirq/next.

Thanks,
Peng
