Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E13C79F8B
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 13:03:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D89DD83D6C;
	Mon,  5 Jan 2026 14:03:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qjLDjuMj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E086283A26; Mon,  5 Jan 2026 03:37:49 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08824839F1
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 03:37:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vPzytQkirAOBtKA8ljncUFusy22vwHlHz3CN1LEMHS8LJr51DtzD4LgQRPZulhBsMl9dBBcOV1BJk1xU4GL4+acNbMoZ3FqQmJV2n1YEK8PLKtOjRXbvU+Z5gaMP733Z5qfOFvcVgYl57jJwb4zTpCFWTldh2mRAb3IwGYdkLeMSFQXlhD8UMe4iKSkgCVfxKaGPJKNer6s3vKPJgdgwCwg1I1aMVO9ZA/5MOctsxQlfHDF/RpscFVeNj4cPytgx4Y8205ml4po2OGCxExFvFbzrTqCSkHx+m+UxXXOlubN21ifjb486Vff1Rh4EWpiYgcTXzBtco2qZaQa2zboTKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYbMprhNEiOwlLANjzPAfy8+KCzfZxwrhIy1ZAdv2ns=;
 b=pdWrVSq1qMvVeLW2bg8jPQr8FP0DlpF3DXqobBawtxmIxENdS6XFkA6lPA5ypRdBJY79Z+LeY7ZXEyB6TGbHKAVagCOd+E1goNUA0O3BwGcRniFHwOVk9Il0//6lacnFSyKZ8x1RYZSbFLmVyTRrtp3nI+vdk8hNqs37nTDncCUOE0ZCuIwqkk/Z+WfpM12OKzXMn9HnHUAkQGHSeZdVkvjTCbOCfN/egWbBDaS7gOO8RGDrApQ5ioaA2S2tl6kERyLY2/C9Uic4qWfgRbuwKL3DoF4SgBI28M4xKradoaa/G3A0ypoHH71BwI0iS3ZrjjEwdSQb3LFpvHF/L27bUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYbMprhNEiOwlLANjzPAfy8+KCzfZxwrhIy1ZAdv2ns=;
 b=qjLDjuMjYcBglYajdmOreSt2X8+IcaIvPr7psOPq38Gq26KZNEqdTvjiCCE3gYaoS65xrS1XoDpjaacRmRiloSTn+SeRqDLiM/QZQo3YTfp5lrWUwZjSuYtzg2S1RXp27cpK3cb/0CMJPqZbdAcjxoKnqrk3ofY8I2ZDkQZH+eK2yUkcpT2zIaMYOYggbXVmqPq9poeC/ClFJKpFdo4wc6u4zNHj+vQVj5tncps6DGd4iHinRVXWkZj3euhe42acOnjqp7KZfgnP6X90AyeYqSOB9zzQj9R/Coy3uxDovx0MY6NRA0KBGC+G7siy3Kvo/P1+zImdeO4fK5+kptepGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by OSMPR04MB11294.eurprd04.prod.outlook.com (2603:10a6:e10:93::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 02:37:45 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 02:37:45 +0000
Date: Mon, 5 Jan 2026 11:51:47 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Vinh Nguyen <vinh.nguyen.xz@renesas.com>, u-boot@lists.denx.de,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alice Guo <alice.guo@nxp.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>
Subject: Re: [PATCH v5 0/3] clk: scmi: various fixes
Message-ID: <aVs1U0T0HuirQNh1@nxa18884-linux.ap.freescale.net>
References: <20251218-sqqs-v5-0-9c7e2466b797@foss.st.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218-sqqs-v5-0-9c7e2466b797@foss.st.com>
X-ClientProxiedBy: SI2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:4:186::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|OSMPR04MB11294:EE_
X-MS-Office365-Filtering-Correlation-Id: 82e98464-5ade-4c80-76d7-08de4c03687d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|19092799006|366016|7416014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5QXgtwezs7sYulbFTeFnYhMPoQGsKgRcgCLsEvtFerscJi8oZIuBsRgOaGjg?=
 =?us-ascii?Q?8kc5qpoEq6jeHgCprGMosdCKrIvC4+vqJZTNCf53FZU4sd81HtQtKoES3/6D?=
 =?us-ascii?Q?z8H49fzGnb2PCW3DbyP2IluE83Y0B8uENeRf2ZsEYjkEPHnp5hdOnOFRstX4?=
 =?us-ascii?Q?uw80md2hlzOkb6u2vjtKHXthBpdRRQOfeA9uCoElMmm/0ucUn/R8lY9m0QVY?=
 =?us-ascii?Q?UQD+d4MMVn37fiOyJZQKhuKCETfhrWc20khiPN4VsS5KekmySjKthPcmwrSD?=
 =?us-ascii?Q?/Gxagq5/oFMU1uQFEMprs9LjsLLfnwPYUNVK/qoE+8zdhZz2B5JU1FUxvJ4t?=
 =?us-ascii?Q?zrnHfD3xVc0RJw++1CDFaiWrZjJrdCOLG1Ph7kbXZr0vqCPxlqv1p3apvsHW?=
 =?us-ascii?Q?KWuTUJeXo2vcVinnzaztdFnoQiig4mRI5HjKhrJFEJr4ExhzhJ/Vob4zwr99?=
 =?us-ascii?Q?mApkHCcQeBoLk9U1A0oOGaOpzsW3bA/vM+EZhTH2MhBjQ1gR52MQGw8XMD2Z?=
 =?us-ascii?Q?4LOXKABahkw57DTTPfafpP97T/ci9JgkxlDLof1KtBOszWF/RfA6qMrfctXi?=
 =?us-ascii?Q?rp9GUpMNj9LtiKCmcFAgZFwNFSw+dxY6lyero7aQD6oQZ+vNwpbYee21jbhy?=
 =?us-ascii?Q?8Wx1QlmuPBsNirkZtjpKdJigejNusj6WXpstHyBfA0VVYp6J/28MmjPjCqk6?=
 =?us-ascii?Q?3JST1fmqVk3LWLGPI0GFsnKzSNheh9DhH7atE/ulVdKMSGRTbVePvXVw6Exv?=
 =?us-ascii?Q?Mi/76VYyue/ytndVbFc1j/eLnxJDoTyc5r+lMcnAU75zu9Tsd23/oped4fvR?=
 =?us-ascii?Q?QSSPRowJNMWHbLIaushgS7MMUixWCIJvVYVxinHjBYwItk/I6gLJlyEn0CBM?=
 =?us-ascii?Q?K63ruzy4pQLn8sQ4FlLHQ5ubZJY49lyA/89nV0uv6ayPQZJCWIhfZiNt8EFJ?=
 =?us-ascii?Q?ZFaJZymVb7zy80fVGkxN60sMgfg5BFvA/xM65KDikllZ3cwq2bpm86YyavqR?=
 =?us-ascii?Q?r4dTeRYUFhV/ul9xRZssMejXRWf0SjcPwqN8bawyuPNh2T70OdZQyfcHGdiH?=
 =?us-ascii?Q?dsyPSeeAotGSVrSERJxHWIsPn/ovg/0oSv6rTtbycN7/wcktpMfVUzyQGCKR?=
 =?us-ascii?Q?GGFCDQDz5+E//SLiV4LBpXY6pdg4SyDQtKnTug8mqqPPLJMx+b8x5rNlQXtC?=
 =?us-ascii?Q?eAfAVazrHvSLReNbWPLFgbSRTtCVdfny/9GN+bdXKYByJIonHAt30Nm7MJGC?=
 =?us-ascii?Q?2FU4FSN3C6NIM0jidE653aErOfSuC/6haLvfziRK6H/t5DdWy+h5/YYqw2kU?=
 =?us-ascii?Q?jDCi97Gbe4ERLnFSYDjUliFBWw7Gvzz1MMc738o/H3kGMUoGMoV/3U/0W+G1?=
 =?us-ascii?Q?NTYc9GnvJ2cGXQuzpwOnpRSpZmegTYbO8sTl+dXTRsFEnWoLFG23W06tJEM4?=
 =?us-ascii?Q?lMGtDETLCPTJ43ZBoj7/X6x5/Ln1MM0NTOgGlhoSFMtR9BsqH7ZNq+wXGSeC?=
 =?us-ascii?Q?K79q7iib1Jqn8eKtLDDhBikRc2ld8y+A6URi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(19092799006)(366016)(7416014)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o1b+Tl7hgj4l3z+bEB+3eKQK3n6/kLONnuQa97oGwYJeGe08LvmeWA9yIoWp?=
 =?us-ascii?Q?IT/+h2esvh/jCnrUxXPnCOjCgLtacKz0ANpe6YEDYBI6YJQRx12YjE7MDJV/?=
 =?us-ascii?Q?yWqB2qmRYt79JWgBvNRaVrxR/OxN3N4cRfI3WvgkqM6DKER1W11ja5MVHZEn?=
 =?us-ascii?Q?VNmHDAqZfvMPenQQgr3WVupX+Dn7Id5FRLkBJt4o3tSapT5anF1cyYywzHKj?=
 =?us-ascii?Q?67HjEJMsupcew9IAINWD6/k2Hhva/fbVD2O8TX+kXX8FIrZ6lXnDKfNgoB+v?=
 =?us-ascii?Q?OAn4YUFrUSh4/9gVXOOUjqJn4Q6xg617Dt32CYDUMrE6NkzwBXR5uWH5mjlC?=
 =?us-ascii?Q?lsPKznds38X1prCtsJq1R/BL3XgB23RsIZ1xN5ezzOkNbhQSPvz7DLLlyMIP?=
 =?us-ascii?Q?vDs8oFtN3r3zLhe5ZHYoMYe9w+KleAQbeSclPqzQJ4O0CZqaN2LVr9hudUe5?=
 =?us-ascii?Q?0UaiQuWb1AoYhUxSd+y5QB2v066DOHjIdpp5JWxKQFKjHrBkSB2xMKHBu8ro?=
 =?us-ascii?Q?SNIeuBo4aC0bO1GnEB89IUfAbi6UrWftaxMEs5BnPDlX0uxIfvGHMudY2IGb?=
 =?us-ascii?Q?eWg58HkSAAB56noHHND6gu2YTe+2jMOO31tuI4hITsqfP/LNprK2E9d5JGfm?=
 =?us-ascii?Q?8GIqN1e6oJ5hWHoMaJZ5vy5wmDS9hBH25+hPwFpX7sWHp82UYBjnlfBXQmp6?=
 =?us-ascii?Q?/Lp86wQx71UCImmRs557WfJHHSTQ2GG9x9AstueHyz7eig7i6vjwmATSL+2l?=
 =?us-ascii?Q?waD2kzzG1HsPdDdFmxgiRUBVlC7Je3qiW0wSAaGUjxRZPNBGr5eywJc37E5U?=
 =?us-ascii?Q?0JwUGgHTutSdNkbjoW7I66lgyYAhHNQSam0V9O+t1GuuGl6rz7KKYnNsSyHe?=
 =?us-ascii?Q?QdGQYhXMKCcL8nub8pfxrCbMP+eZQV66u47DwNJb74hMSLCkqINS92XXPdq0?=
 =?us-ascii?Q?4Lggw9bOqb2icUTQJLSfyjxWfhI7nwQYtOcLmRcLXhZGNTLMYtFojQUhyIEH?=
 =?us-ascii?Q?cGdL+y0/8frBbH/vbTS61fMZlHInY/HFcDw//xdL1TMJewjVHCrZrc6WZcPx?=
 =?us-ascii?Q?lqStO9g3WwtbAgfzvF7ES7LN5gsNUyvko3kQOlB/p9RBrQBnOYZ2I6xCiEMm?=
 =?us-ascii?Q?FObWM4HluDFRL1iLtNaQVkEtfrSasBQSweQnoc2U586gABBOlwbC24eAN6Li?=
 =?us-ascii?Q?Ngg4kqwxfCXRJjOjdxoq76jMK490ksv6UzvOjqtQ61WAcI/fN/ZwcbkSvHdr?=
 =?us-ascii?Q?LwIuPAQepNVUo1djZolG1mQK+iIDcZQLnU0Mv78NcgZiE0jsfuDD71ElEh0l?=
 =?us-ascii?Q?jJhFIFEnQSATJVhyfq4TCouygSwsa3zQVyyZcF+TBKy6BtIxXXYBdNS9xxo/?=
 =?us-ascii?Q?/peiZLIA1v5Cta5Di6TG1Kn/iIxE8mTbRS7+i2HlPRpsGQ3DCA+Woj4Ks0zj?=
 =?us-ascii?Q?OO5AllIA4fDRWoxg0rRc0J6hEDWTPgRO4NVhYXf08DJ/yRuIWjc1TPV9sJzl?=
 =?us-ascii?Q?ZLvroJT29JlCjDoAZzWftWvO6SaiQz/1QZCh0HryaQpvrEZdzLMY9szIJI6q?=
 =?us-ascii?Q?0hZybNDA9D6rProdJIiqRBBocB+AExkE7RhhOyX5WgZr7duHUOT7FHnsmpiA?=
 =?us-ascii?Q?eUfJcMehuIGTxPh+zu6oeHFXm+46R2c/IwAsjP1aDb3kaLo6keVvJ9Rh/38C?=
 =?us-ascii?Q?EvaCWK1oRcZElxx+Ga2BfSE0g6hmyutNOqv+C9uSdFQJzgrUkuubYb6dJjKB?=
 =?us-ascii?Q?QL6LAhkmqg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e98464-5ade-4c80-76d7-08de4c03687d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 02:37:45.6450 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KFjyxWS0I8VWHNE2s9+DwhG0ZfXWeXFyqer3JJIuBRIE55IOLl9VgzDtaoNdP+Pc6DVYNXMbDVpPtjJeX1FW+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSMPR04MB11294
X-Mailman-Approved-At: Mon, 05 Jan 2026 14:03:25 +0100
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

On Thu, Dec 18, 2025 at 06:27:00PM +0100, Patrice Chotard wrote:
>- Fix typo scmi_clk_get_attibute.
>- Fix priv initialization in scmi_clk_gate() which leads to
>  clock_enable() error when CONFIG_CLK_CCF is not set.
>- Remove duplicated scmi_generic_protocol_version() call in 
>  scmi_clk_probe().
> 
>
>Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>

Applied!

Thanks,
Peng
