Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D46C5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 07:11:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 196E482B7C;
	Mon, 26 May 2025 09:11:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Z+NevceO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C90AE82B2F; Mon, 26 May 2025 09:11:17 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::611])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD85C82B7C
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 09:11:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kaH9dl2gCdM6/JN1iu6n8PTU6yv3pIgF9KGKVaks4YllD8Cy9jDUSqUqZKsRTGefYQL3LyOtaOf8VCFjV4iIgEZ67BvErxo8PcSeUTHcYZxdpltvwJ5kCrGOIHfJwT8bln+3zkDvLVWEBJdCgbiPBRD5JJS7Cxy1bR6CwV99JPeq2/lrhX/yQVX99erAK2cCc2yHGRdSD/t5VtHG/f7lJcaxN6yXm1StpL7se3GC3jOrEZdfqgmsdyeNO2wLBTkJMvl6ZEcOQYQtt/2D1ML0NafApcWpLHu3De938lrjtB955rSPTZ8QvE1wfZo4szcQRD/IS2FbCfMeu+WF564/1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CJScCCKrCkQsGwxKZScOoj14i4ZkN7xIysbCadsu/0=;
 b=oZk5NRxe64hfWHSoPEEOLLm7bqq71cOwhYe0EM5vW5LInst0colww499DTDcMnpzWFiA2cwrg+QZZbk3WQ02anZaYGcEUxTxwuGAZKfL4AjQSPLT7FXzIuQhrrmjgtH1q5/mYkNGexAq9ra7QzOvIDcdK7rzZ+3Trw711IVt0x6R6lHGn510fC+H7JwBuwQbWyTkzTRO0aoJPMW+/Pnh1yKhPs2g0HssVg5NXjkxXE8KGNDWRDmxUTZjdgl5GQpFC4+umxCRZO+lLjlsKQGPswUv0fCfu3K7ahmbu0L0AlWmj0RcihWSCz0SMr+nBWDQpucZAxY0LJa9ZYd2nGs0UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CJScCCKrCkQsGwxKZScOoj14i4ZkN7xIysbCadsu/0=;
 b=Z+NevceO+xVC/l8iP+B6jwVgPe87bf13+TsE/bU4G1RmshYx03j3/AfvNgNvEaBkIRCm6/2XSXHBxRI2MuqW9Qj4UFwEPIRC0w13LOhvYxG3AoCcqP/6AQ/yV9UNmjEtCRXYS1jStNkUrxQ8fAGN//v+aNcSabr08Czoe/Gcjieo+UePPLp8cbJncpUScpWLUGuu4R964rD2n3gVfKfGpb1s+0qBDSw4y4x7SduhSi5jPn4u/qojQ1qloQsvLrLDROFDvgVpJ0StQIENZquiS9AKBzkDXfrzfg8zaN1fy67FC/FcveOoLzEda6D4hK3AOdeRNU0/9eFrkZiyXoNFjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB7570.eurprd04.prod.outlook.com (2603:10a6:20b:281::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Mon, 26 May
 2025 07:11:14 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 07:11:14 +0000
Date: Mon, 26 May 2025 16:21:00 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
Subject: Re: [PATCH 03/13] board: venice: move soc-specific dram config into
 soc-specific files
Message-ID: <20250526082100.GM19264@nxa18884-linux>
References: <20250523172018.4164647-1-tharvey@gateworks.com>
 <20250523172018.4164647-3-tharvey@gateworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523172018.4164647-3-tharvey@gateworks.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:196::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: 6730450c-33c1-4578-ef5a-08dd9c24803f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|7053199007|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W5mRrXfVFqrWhH+ANu/Rup/ZasiDCw0XM3HFqCFUCGIMx9QiZhum+RrSTAVU?=
 =?us-ascii?Q?x+cTpJuiH8xIzAzj8a6Dl60FtCBMUujv4W3/TjpMrQDUhPOQw3xEOfPChXkA?=
 =?us-ascii?Q?HJhxZFwufXRhjDVlxsc4iHyHado2tNRejRxyBsqZLVEKqGu5rwhs3w72T0uE?=
 =?us-ascii?Q?7plp5L8SFdMwn6eh6p2+fS81b38LLRlvbdFU4jRKijjLA7HqhJvLr1zppgFF?=
 =?us-ascii?Q?OEgKM8wFh01BZ6wLaQnymeweluMUW8quoMtQkokXvn9gtCAwZA/ctaZimIDE?=
 =?us-ascii?Q?9ZdnnG5q5mODUJWnzsBJLvjl2AfSGypplmgKgSqtMYwjegMxyEPk2dKslN/Q?=
 =?us-ascii?Q?fpUjHWklEQVlu6mToE3F523Z3S7I8aySUZdZXNIFAsQsb/M4+b4tgVAW0rlE?=
 =?us-ascii?Q?8ZQzjI6JNAhvroewNhBbMinjVbAUeOgKu+VFVPk87Xn5j8ctuVOaZKuyJM6Q?=
 =?us-ascii?Q?ckPEquVITAjI0neZix5nWfKLtuIsiYAHz+1Sjh4Y9cbtsWdVLLzIhtyB05rp?=
 =?us-ascii?Q?j3vGCswXHYuaDzSTX0GEyLle9U6kKHJHkmtTqa8ERo1FudwH6h35WvCzO427?=
 =?us-ascii?Q?IsuVCrj+1dusvmf6Wih+cUZocqRY15a4pHscBUH53KaYn8reFPBH1WTCAoJJ?=
 =?us-ascii?Q?tkqmGT0F0Cp/trId/DZVlnnzH0gzi6GbQvrQd5EVpO5eOLBWKJGwZYGn9mlW?=
 =?us-ascii?Q?bkMe0bDCGeVsixmN1x+wEAhC6VsBrEce9MmwnybpjHIdbCUcYDNbfL/E0/Ny?=
 =?us-ascii?Q?6X4ASoX8qTrMDwI9clGakeEj7nSQVVVgN83w2xIJuu3W28vGdj/GrZvPxZ7d?=
 =?us-ascii?Q?x/DRnfWe8GZNTMUC6A5VSofoHBSK/GzQ2JuZjJJb4d7xNjsOm8w4/ZsSt1Xp?=
 =?us-ascii?Q?ua4DihAvy3qhcr/KVvO9XLwKB+HuQYDoiDad8MVTtN6j9x69+iI+pgD6z0gr?=
 =?us-ascii?Q?js1Z0g7vePwr3ETtWjiBbsPv06Hpj9TBPAmzbxnC+Ickw7aZ7DKHpdneQ7w7?=
 =?us-ascii?Q?sRNfF7XPS5djD9I4G88XQMpax5TH9xHQOmymA+IB3IC2D3hPl2yK53ngufos?=
 =?us-ascii?Q?KgW/oeWZYlth6BNneivTRHDyd/Og8YIluZBJlP2Q9gWddTRI6cNskf4WBbeH?=
 =?us-ascii?Q?7w3sQRVrHWI2J3O+D503Izt6x1wsNfHdhnSrVh5Pr8sBKVeyJ/ttAer2aIVX?=
 =?us-ascii?Q?4a3EICQqdjiL/ZlzvyikkaShKQkLKfSSK8hLTzp6OqlH7Vq4mLemzxfJTcJO?=
 =?us-ascii?Q?eGXpOJk9Mw9Ud8evO6AcRfJdiFynLrcKTF22i+OoSWhABUHUCEtPCYAL4E4i?=
 =?us-ascii?Q?eab3k9aSe1LXl4M1QmnmBVoActkqs3B4tH0wvvBcU0K5R9vcGRh6dOBZnbJ+?=
 =?us-ascii?Q?WJcdZ5P0M8C66JSwKaotFlFcdsu3IXcZsHJdhqwOXsYR0NblO4A8Qq3xdGN/?=
 =?us-ascii?Q?L6Ew2NgdkfZoUARyI1lKUIX7eaKI6BwXzd41I95oNr/VE5nNE4VUrA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pYm4XgZbV2V/WTRgzwSAywBZ9Y3D7dZYPQdwOYmUjMHpMfg7o91V5Viv2ok1?=
 =?us-ascii?Q?8QnpCAcgrgs6tQlTWNfPrxIuCg7jJiM1vnfgsBu2Yfe2DBLKSAhx9Thxnyui?=
 =?us-ascii?Q?e9xFyeOpt9tiFxnnig1LY4KDOBu4ZdC90PSUzK+WRakxlKsX5+enriwijTS1?=
 =?us-ascii?Q?Px3qwwHuFxaGSzIa0bSA2l+yD8XDz3JoSTFW7BL0m2H9FYc3OG4kcytxeWrN?=
 =?us-ascii?Q?/9dPYtuFPYnnlCXVWQCvZJ0eTKIziX088T0B+uDp5IqkeVnCENzAhUisrMuM?=
 =?us-ascii?Q?K30IBSsnkGAPBg+CLGoejozFV4upjnzXswiWhfMdncgsolHLKHcOSTmdhXMK?=
 =?us-ascii?Q?1MA4/k/u3l+545iAYvuDme/OVS72+ch1LHMi80hLk3Ei45wJ8AkFcsrZUwRh?=
 =?us-ascii?Q?1YkSu9aV3O/Y7j8BpBnweUSi7x6/oO2sAPZXFxtF/7CKwwoZZzQ7WmTtIhqw?=
 =?us-ascii?Q?39OI55E9oQ8ChTSWl1by/Mn1uKUBAsW8w7LMekWNgNAuv8wJ4gkpPhmf5Sfj?=
 =?us-ascii?Q?LI1rUUxY0mGh6dM+8fMuPWTqc/VrQ76JrUy/ggw92ESrSxyQA71BxcPpMdb0?=
 =?us-ascii?Q?J7ftYtFIarJBue+2F6LQdkJ8aKuz8IbqqIG76oHlEcPQq/XuYeFCVGg0QA06?=
 =?us-ascii?Q?N4k5TCaZOqRmvVC9vo18ZAFM+JavV8W2z5ViiHvbNa9/5FnsT+Rmyj7OmTQN?=
 =?us-ascii?Q?ZMnV0w2IVeaQMSdNS+a5mCjZiw4jCxYgKtz76fsJ26H0+VjbHLO0eQDSXhSY?=
 =?us-ascii?Q?LAhUUuboObtTELVVqcLxfXPXJcUHrkw5Qj8DmpnH4LmGu/3gkdO7QjSTxAfH?=
 =?us-ascii?Q?vckNh8QQWZDGW238V1n+tboTC3QADr/0F1Q9H0P79x2KAB2Kce7tp9dc3aiR?=
 =?us-ascii?Q?9/qCcCVPuwgEfrLfN+M5JlCZxWoNyTqsaDwynDH7XpAy+YikpZ8FyqKalyAO?=
 =?us-ascii?Q?zR6ggsjmSh4C8VwXlT1PDbphN5c25xSCJjA9hHiRCov+BynveEZS+Hu/Kf+h?=
 =?us-ascii?Q?IihqaYkV2q7Aph17XGWwNiPWtmeJbCLd5gXTmC3BXK6LUylhGUGFkowIopbi?=
 =?us-ascii?Q?nafqTQPs9XjqPl8z+4AZrUcbj0c3kLGMe2K8lomrWRe2qasYquVXueNAnU79?=
 =?us-ascii?Q?LdU1hhGElVqouxOOJskTbepxDw0KbV2QLNGm2FcPSi24YG3k86MG9AHx0zfs?=
 =?us-ascii?Q?qPHD4h7jUFz4eaLVmXMnFiXdlJxUR4PUp//0+X1svCbPC6V8IKHad47i24yu?=
 =?us-ascii?Q?lv2EoFLuHh6UdeaGBgZeEHLDoIPzHl3rMQvgziKZbw1Cs5KFzga0aEZfUi4k?=
 =?us-ascii?Q?I1og31PcEDMWbai0od73AjN/a5ycydwpkNcx10yYYTEhbUh2T8u8BJTmncWs?=
 =?us-ascii?Q?OaWrtgGgegrGSrpXYQJDIidOhgehKlAt6cqJLWzC28WIJtd0LqryHOFEeTLA?=
 =?us-ascii?Q?MqjOMFvF1TWYxSnT3gGUSVt/OFfD2HbN5OiBwtzrZuAdvsbbvz/NHB0IgAy2?=
 =?us-ascii?Q?cRTaXpdm884ARVy9HBpzARznRmw9CFsKoys/ieyikfw4tyADkpA7lJ7Zxscu?=
 =?us-ascii?Q?3D5+XwKdBjaMPkCsK7PjR9YyJ02GX0TacbF5FHjb?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6730450c-33c1-4578-ef5a-08dd9c24803f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 07:11:14.2258 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L0Lgbg4fHIAUYiRVIFxXJFTmMGGNjyoSUZU2bWX3xV7E1Ej6TsndsGa7M8wH2a7ZsL97yABpRbwqWb43rh2G/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7570
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

On Fri, May 23, 2025 at 10:20:08AM -0700, Tim Harvey wrote:
>Move the determination of the dram timings into the soc-specific files.
>
>Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
