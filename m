Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1AB1C87FCF
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 02:36:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D63D83AEE;
	Tue,  5 Aug 2025 04:36:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JEM3CAS3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C1B383FE1; Tue,  5 Aug 2025 04:36:15 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73A9C83A81
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 04:36:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HwTZkff10KDSfVXmaJU+y6tOMhnRLNABk2fyUi3KTrA7gYgOs139GMbqSaXBahNtGgCat/DPuDVL+Bv8nhIREATIIv9Fs8W0YBdDp8kESLjKo25ny3S0aS8zpwYWoWCeoFPoAbewoS57LeU4fO8ED40AKioLsqRyQwOwtx1ltbm6JIcBZgeAuEeeCvWlky50Mq1VsvyYlQiAqozQvEKz9hir750cdGjXqryiVwIjk5Zb09aiIgEuS1JnsHs7xAWSAIyzKrV9fUTAYhC+h0XnbKtb58eNwXZDeqJNPyvlS7n6pnu2GZD7Y41DoYAS4x9O/3pkBOkk6k6EJZzCEL8rLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y6Irf/KqZB0SBcdRJTHh6on42pZATF37wCXIJIlBn7M=;
 b=yloiQdSZtpq3slAhbgf6+2rOxwqhA7rGBvFO4sbmgbQz21qVtCRVlL3YOwwMH2rjoVC8wWq/8zytlhomIwxjb5F698o4STPcfn0XYae3sZoEIf4sXZRicXVjl/i4+GP5oBethQU5PO5ifwbKFUEGvliRNDoLNQ182vhvrkv7VKh4x8Pv5l11OwSwQJ36oN2MnsAWWOgNQpczArN0KAYwprCb1ID43ShLUdy1bmnPC6KmMymNgzYwsvlLBU/bc3lmdGnBpBeVSKP42B62f7DsbyzUorXZXlXe9jZVZbra5lcy6YBbNkiNI1MwA20nex2Okrwyk3zcmaR1jnTB1AEMQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6Irf/KqZB0SBcdRJTHh6on42pZATF37wCXIJIlBn7M=;
 b=JEM3CAS3yYxq4fEYVYX9Vradj3vTaaxrXXTs8xygv5w882mv3rYXjx3qSt3YcDVSyiwhwva6P7A1bAckxy4uFb0upEWMyxIjW4DEGnvhheG6CFArBS+mPhQPiqA4oWk06MT6RVpI4AMLJGw1a2Zs1vsRCZPEkV9lnoCipFNkGxyJwUc+IauD77g0xTR4msYFXd+bRzjV9uJ0VjM/GG1Y38z0EDEmdnbotVw1z7un/qUTJnhQQo4KDIqlbphZkT6lfOABaUlfGkXCD9isR98ZrPU/Bmcwb0EEQ76L7q8G8J1gYwJfZucR7R4/gTnr6RTY5Ke1xqHkTj4AkY/r+TuZeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM8PR04MB7844.eurprd04.prod.outlook.com (2603:10a6:20b:236::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Tue, 5 Aug
 2025 02:36:11 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 02:36:11 +0000
Date: Tue, 5 Aug 2025 11:46:59 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 0/2] mmc: gen_atmel_mci: Fix some Smatch issues
Message-ID: <20250805034659.GB29103@nxa18884-linux.ap.freescale.net>
References: <20250729-gen_atmel_mci-v1-0-ea0fddf587a0@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729-gen_atmel_mci-v1-0-ea0fddf587a0@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM8PR04MB7844:EE_
X-MS-Office365-Filtering-Correlation-Id: 01915a96-ba28-42ef-5e68-08ddd3c8d6d6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|52116014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fYhPlYbom7PZxaS4lW7ZXHt7BzET2oYx2+VeXRnPTdZ2VrkebFe1LmdhvoSp?=
 =?us-ascii?Q?+vzxVlyRPR9E9C9Ye3/7pa04nwMJpyym/gaBBXImRuBo+9E/IL90f3mzEhpX?=
 =?us-ascii?Q?zZ4gMaJmUjzZv+EzY+gN5TPwA16uYwuCnfd/W56QD44eMF7mfLNMBi66zcO3?=
 =?us-ascii?Q?thlCYQlcT7ZeX8DxD7YOlWBMEt7TvIbBr7k42zK9+7xWwYK6LwJvy2uizuSZ?=
 =?us-ascii?Q?EW+R35kD+o5aTzY1CMolox6dMpl4YNyK127rX0MIYcXyeHNryS4oFRhw9cTA?=
 =?us-ascii?Q?k/dlFKQfae+wTDTDThusCv+J/C56863itULJpyiZAJpzlifYEniVGR3L94FT?=
 =?us-ascii?Q?p7AUMR68mZP9FZcDJyeSMyLgtgEtPaHEuHgDl4WfRk01eqnV4By978T/w0eI?=
 =?us-ascii?Q?QZgPc4hjpowzPs4w2Q6TuhdXx7rFwnc5zX0TcA7i5e/0JrLWPTNPFxj00/+R?=
 =?us-ascii?Q?aB2AssVqYVXuPMtprlaNquY+Mu6E8IOnoh88EDloqO/zJJaxNx8PSX/Yq7YZ?=
 =?us-ascii?Q?6A7aasT8Paj/FSVxl0XEKYDx0rODu3DxuODgMMJwp2RIjNtpHEzLteTHt335?=
 =?us-ascii?Q?EQlSIc8ZB0Gzb7zXucRyFaauN0QvQX4iYXpK2EeFExLU/QOqZh7la9nW0QMJ?=
 =?us-ascii?Q?e/tsohCwhznq5h3Tn3btDAw1tocQKEWQLGi/dDzN+UJrAtEu0ZeWL4rKkelH?=
 =?us-ascii?Q?aR/rdH6NkV3rsUv+u+XhH557PKzUYaXev9f5Bnpq2qWrr8jjCGOJpQFQt1uF?=
 =?us-ascii?Q?QNxT4Dq3bZek+Va/fvLapFv7m4VJju31goi9NhsiYjGcx7uJxUCENZLefTBp?=
 =?us-ascii?Q?xFLTbVoVoxXaePjUbKUsq7ihZzVw4F/wmwcpWHtwisP/c0Scpo6EmUKKUfBg?=
 =?us-ascii?Q?uymDz9Nw2a5Fq8oeOhozEV0UUaIGKj9TBpdObNn/oqElklKAhPvC6+2+7zEi?=
 =?us-ascii?Q?2GR8lserZsl3nycCFRy7c3Vx5/oX72A4It0y3hC6XvatfC+a2A9CG86ry2CU?=
 =?us-ascii?Q?t5PQV6lKD2eKtccScN9tEPxPkmSVG6WsG3X44v/Tf1c1+3AfxcvcRsrNj8i/?=
 =?us-ascii?Q?rtRZpdjgB6JdqrPr6ulDTFc81yPGCUT+SoDcmSdleOrhM4S/E4UauWj0x+AJ?=
 =?us-ascii?Q?LZmjNYgTfhImxYIimcTtBgn9xKh+qT3W24nj3oYufJ86edGMY9/4al50AhGi?=
 =?us-ascii?Q?7bs8Lhgg4Lwy6vadXrH47/IxirxFOrR1xGmjf66wQ3teP2uQ3Mv/MLVcL/DQ?=
 =?us-ascii?Q?01wivSssiAAiQPes8qpEgwaiNMJddf5fr3NZhtMVZHLGGXrrzXKmp4mIeB9x?=
 =?us-ascii?Q?78UnxzO6JO7HMpjJFQlfBoF5ItySToVJ3MGLd+4gS8+m5TYtOf+X/Mf8iCOA?=
 =?us-ascii?Q?Wo/MIhnyCfRaUnnXdHb7QBfWlFLM2BD/+RKYkfzM1pAcfg1rDgOJiYP3VmCt?=
 =?us-ascii?Q?+fRuyNZcuPzZrsc/rhp1Khr2vZL3VOv5tpBpFZCoFV6k0OKfPU1S4Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KgEI78431FWj8rwRmXIwgoZVb1r70qOv1MW1KLnb+rpq9OwHz2Clrw/5swh8?=
 =?us-ascii?Q?Dpozqaiz8qWgJUXYgLVGOgiZJHhR661OtqCYUsBANj1QyhuxQh3uTJU69iQc?=
 =?us-ascii?Q?8YCzktBgRKWWWKzv8YqmFfd9X2AmAGHF+9SXq72pTtLjJdNZm/HfENH1mES2?=
 =?us-ascii?Q?bdtmpRr7eck1CmlVHhDGgs7qBk4fJFL2rxRBBshL02NLKzLA46DJKSlmb8P9?=
 =?us-ascii?Q?1govAMUuPPR3IbZWXIWNA0U74rGaWKtyA5kP9UgVuhwFEfUQeq4BbPlVP3r6?=
 =?us-ascii?Q?8A6lk3Yo4WubsSZc8ONG6kG2HprPYrrlfnhhiF4oh1H+/nrHkDogTOhHLiKP?=
 =?us-ascii?Q?ZqYVqA28SGGUtf2WRr2ebHxPfYsqLms3M5AT2O4apb3qYg7flo9cucDrpYxH?=
 =?us-ascii?Q?d2A5bklGw6QziktlS6McCOPepqEX1qphORZqqv5PBAlEWxRtNWMuoPIc+MnJ?=
 =?us-ascii?Q?f6CnyPHu/wuisQVpvDdbcHWwen9vel/fo3Z/53BRbjQ62Cf4/7iMrdMsIJfN?=
 =?us-ascii?Q?ky02OSwfVEmgLjewCFId4YOAXz0DxYkhXrpZYJcFzbN8xESUQwJdrKbD2Mmh?=
 =?us-ascii?Q?kpvioWtP4JGp63jVd/llQmK6UthQblEsIX5/z/7vscLRLmrqOe4hySweFjnr?=
 =?us-ascii?Q?z5zNOcu4yExBKroYYC1Icix44cLzv7f3pJlPQ5iht+WRzAbNPod8cvtoge9C?=
 =?us-ascii?Q?s/xUalHSO/RTHlL5fJmrJSpEp6yF3GK0alNMG5blTtCvIhFE1x7NqyMS/Ym6?=
 =?us-ascii?Q?eEC7F1Hro6Jl6Ap/L6XaWfDVwUGMgnle7wmRfa2ezGK0/ribjpPKyTr+QjVP?=
 =?us-ascii?Q?+URfMLIl6aCRkllhQ1GMRMYlgLOFLaJHYakPVj4eQwmVeySCWTT7+O5n64Gw?=
 =?us-ascii?Q?qf45d45lIa/QF3oSn2gsNYEsYyz2y/v4JhibyRAriezs2fmm+GejJXumAVmb?=
 =?us-ascii?Q?7HK5YmVrQVwe1jtWS2YX5A0W1oQKaafq3R9/5P9QRmgYUUfws5LTNrfNAl9K?=
 =?us-ascii?Q?nZ44BI4LWWZPOAdNTizUk2AN3idBVsIlVXVfFOydd0uVMQEHNzWLU62FvAkN?=
 =?us-ascii?Q?89dG9FE0+8YhvKRiiC0Yfr5OkPiPT4k2waOl7odak5juG0HmXXDFe/NDSvjY?=
 =?us-ascii?Q?qNdw+dq/X/her3fztNOXI8PPa2v8XXtCs7hcg8UKeA5cvApEbLPKkPthQWNS?=
 =?us-ascii?Q?2CJHPL/AwMIcbLwYwTSEhTof5JtDByN1wYgolbW5uuRD+SYecO/XWuuxQ4ee?=
 =?us-ascii?Q?bO6ohzISiqYknMZZnaDc1BoRnq3FDjLyl/oXpXBCnV8aAzYmK6Sdl0vpxhqo?=
 =?us-ascii?Q?qLw7W8fqIvQD6rB20BtZ9N7r2K4omEjtP9u4TuB6dbOSLY9aRFweoHxDgrFu?=
 =?us-ascii?Q?mBn/LXMTusPDXJoP8prjL+4NP3GFVvAkl2i9fI4xawtu02suAB5aM9ER/+ao?=
 =?us-ascii?Q?5puIz/Lf/bUa9FPZ7GP12sfrsX8N8iCP50U1VobvaL/uPOJ9Zy7ZbtIf/V+Y?=
 =?us-ascii?Q?UjprwrTcghT/m+NVAsrbEQt5iJytDL5FLUje1KP4HCjjsTgg4ncNLgXPop3h?=
 =?us-ascii?Q?4cXPGgnYI+SeLCeAY6lHWjP/ttizw/5gEvjDt6WS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01915a96-ba28-42ef-5e68-08ddd3c8d6d6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 02:36:11.0937 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: umwheTAbrp+3/jKfUUyxiRwZEvNTEQSPu1w3YJoGRvgIUuJAWFMB7U6df6KlemMYb7JZf1wbniUbci807JojYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7844
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

On Tue, Jul 29, 2025 at 05:16:15PM +0100, Andrew Goodbody wrote:
>Smatch reported issues with duplicated checks that could be removed.
>Smatch also reported an issue where a variable was dereferenced without
>a NULL check despite being an optional parameter.
>
>Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>---

LGTM:
Reviewed-by: Peng Fan <peng.fan@nxp.com>
