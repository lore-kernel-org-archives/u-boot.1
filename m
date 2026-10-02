Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBCC5CA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 14:07:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1837960BC0;
	Fri,  2 Oct 2026 14:07:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tlLy-CziYn3X; Fri,  2 Oct 2026 14:07:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5636B60894
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790950044;
	b=IE36uJYedto2cicYLd62dEoo7WPJkyIIONQOqOYWm07U+4nQbdTiLE/53TUeUI/9gToL
	 5Xpq/LwGdixxSWf3Ms3634YtG3WNka2wX+LKDgZMkzOqXVwMN1LwGQ90M/Rs/oXqqnKah
	 QaeaaDNFitpbO0pMHCwVOni69xsiJUNrwGiCpapmZDbBqabiW8Z+fypE0kHP1gAQ5JRnQ
	 CgGCVEJholaTburHXRBb3YDdC/XLenkRTe1OMUtqbuUg/A+cpmH3jijV5HK7Mi3p8Emn0
	 hm0xJiDzAkvxHjs+cvHIC383UVaMPTZ1U13lXmBmpAG+YMEGbCPnthut5LPFHuX74/A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790950044;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Or33QtsSguQi8VbnmU1MuNBvf3I5ymInvebdQk3BTtY=;
	b=AMlrptjmbRshaqnBiIC1sFospVaDa7Jv158IJpGTPu5uKkKLyXgov2P6RhwUpGgYvFcO
	 opmRGYGiCuxnyu1CMC4XO3LB57//a4sKTFXmKfqk5WeF9RIfNaNraLdMcBTw3o3LKvAI4
	 7E+6unjXGsxAz4iMXlvCmtn19hgT2+d6bWoJMe8dyPo+g+ulQxq7f/pkmuWJOU5W10TrK
	 +mraBOIo6A4O5FbRKdntaLAdcSOYzRx4ulNcu0O471K/xPS9ymQGavemqmDcwkTucAXHx
	 3OhJDM6sTueZzp99dzQErxWpnqWbt7xhQ1e9pDBTVgFkRmwgvZSClgQHhkiZ0FvbmRw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=hDKJeVPb;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790950044;
	bh=Or33QtsSguQi8VbnmU1MuNBvf3I5ymInvebdQk3BTtY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zMu9zEe/ZGmApqya2bZrg2pzxMN5LA4cjMQ55NPhQ7phT8j+6pYSj4rL6tPIBMbyD
	 mI6QFA+7TBl4qQIZI+O/WbW6noT+S4TUJh25OASrU32gzihgnnHjninWronRjzV6oS
	 KF4QOivTYCJM8MF9x+PuvIjMckBXmSeh88nZSP11j0vBIC+kS22Ws69zAybd526ICT
	 K+n213cxSXUHRnv85e+ObIXC0Br6fAKQZVoXXZ93ZzQrDe+PCJWZXXaVLMWy2rMFSn
	 5UlQg5X0j5A23us9+OXZluIp5Rj0HUIbbsc00UH7t0YW+6iK+LfW6k+TmlrZNCJ6ZU
	 xmDqTqQ4LF0aw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5636B60894;
	Fri,  2 Oct 2026 14:07:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C1FB4282
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:07:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A80DB60894
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:07:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qzetCoxach6D for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 14:07:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CF81360600
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790950043;
 b=ne//e6F7l79Orn/LtZJ7KjDcFzltim/R1Pp+d6/1x5AtanzMAJ0VQ+NDavMfk48k67Mw
 jRGS2jDvXVoyJ2urmz9A9SkT/e4+n0BxFeRe+44t/PQMPo6XI67Q+/FxDVmgjh6REe59l
 t23OBWh/MQ8ADvbwDhlhMgOR6Mk/AkqoCFb/Doi5BEsa6X+OrmJPP6b5i4beHtngXu29Q
 8fI6HvSwdvbVrXA2hHRh5XaEBnDecTXqjiE9nSgV223okF9rBpYogGJlQ/ZjzIfwJo2oF
 VYi+A6Gu5/U3qubiWCwVvDqUzN9xYFA/BG2Y6f/rWsu2PbvNyf26M/UJbHM5kYGqDeA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790950043;
 h=Received-SPF:DKIM-Signature:Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:Content-Type:Content-Disposition:
 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:
 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=Or33QtsSguQi8VbnmU1MuNBvf3I5ymInvebdQk3BTtY=;
 b=AukWZ5+a5nOdNYQlWk+ql8A7q+XDkRh8VBBDnJpaTV3XuvDy5q+a/E/NqnwJGWhaIJRP
 vKRKuaBjn00y79730IZozTeaTHzHJx5WsEEMlTP7FVQV4OosRjOJCT7XS6ZA8Xj8gZMdV
 IfF55kh6k0Q40aKSmUDCNntmxZSqlYGw/kOUI9ALJ9FNtyyxlqt9q8DhoWiO3mxynKycF
 1fwCI02ByIlWMAMRAXWltzzELV2InyPSz9KQv1iqmhXnaSz2FzPo+/f3KjMSUfWjJJSQ3
 p5zk8LXRJI2bUeCUu8W/JXLtlc9VwbhdC2/ini8ub+poSx2B1YF2UCFTOCMKLgHIGFA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=nxp.com; 
 dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=hDKJeVPb; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=vladimir.oltean@nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=hDKJeVPb
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CF81360600
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:07:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uw2nBGC72OQ2eqPy1CzNITkqUWqvhC4aJH2xAFTSXnselikWHsRhBLbRQp37w9Jed0qS+o4SbbVHyQihvFMJcTYmW8SCeTFuW8fDcWTVvjOS0dPAsauojE2oKieIDeqeZcueyfRcGVfV/b8PoBjr9CikhUGX2dSB3QpNUiPkYrSU7hPg1iuOQWyWygT5EjgY514IuXyzvf+VCLeNTWnsGS60+27eBEdrrR/4gY1eS+diRiZRWdIHveL4X39YTemsjnhj7s1heiwGOcITW7eQMmZnwRplrptW9rDVw5zdXAdfREVGA8nvGvshUxgRNP8E6Z7uka5t6Qus3gL6Xl2y1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Or33QtsSguQi8VbnmU1MuNBvf3I5ymInvebdQk3BTtY=;
 b=xl5ZgHc1xuDZlztCt7wqI12Sam0KXfish1TxXqZ/MFo4fVLNaCH9wzwlgB1TMbJsnNrr/m0DRcnALoclAc8Ef0ukRcVxmbseyJcJO4AcQH8tS+QzO4jGKtmpUelTb1/x9BbFgRpc8bgIYXKKfqVFFhpFLG8CRmbOCmuAlhC9E/GLDiNFvGdniPbLEbxCz+Qsd4ih2NiM/uAZWPJ4XpU4EhthiqGBX24OBV5LTHpPtBNul2sRc1kr9U+VBo+cVvbuCYpGp1kqEVLyCNLk0+4MZKSWccAqHDAXF53CQSR9I9BvVtMW9AIuDd60xgskfO0AFGtPCnjAIBUmy6lPgHh3jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Or33QtsSguQi8VbnmU1MuNBvf3I5ymInvebdQk3BTtY=;
 b=hDKJeVPb/HifP4FhYH6oHyo34BWiNjM+aRX3TIP201a+JnBjby0AVl4WQEeqMF5h7dFHWbKnZZYVgejpc8qCK9dPGI+qEW+uxDfN5Yyb82vbHMI+Xlh8HvlUuFUYgBljM9uZ5twTT9fsPrCaMVoN0PcNSQQgFAJGjs5Qa6+FwMdKyEUllGztDaTML7jxVO9UajIlUCHguAvoAZdsAfZJtcLDa01hyzOL8rsEGe4lpKN1Nsb4pwhiKJnO7GAyDkzKuSYbpAejtBqWEnQVTCDp+zGTXSKRDcXciDpB4hKRb3lyFV8/pMAa1YASvn3GaHDh3CQA9RY5AJBXGPKQBPdWrw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by VI0PR04MB11045.eurprd04.prod.outlook.com (2603:10a6:800:25f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 14:07:13 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 14:07:13 +0000
Date: Fri, 2 Oct 2026 17:07:09 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.u-boot-project.org, Priyanka Jain <priyanka.jain@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: Re: [PATCH v6 08/13] board: lx2160a: serdes: add serdes1:2x40g
Message-ID: <20261002140709.7g5ftz5xr3iooio5@skbuf>
References: <20261001204731.1774613-1-vjardin@free.fr>
 <20261001204731.1774613-1-vjardin@free.fr>
 <20261001204731.1774613-9-vjardin@free.fr>
 <20261001204731.1774613-9-vjardin@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001204731.1774613-9-vjardin@free.fr>
 <20261001204731.1774613-9-vjardin@free.fr>
X-ClientProxiedBy: WA2P291CA0016.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::12) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|VI0PR04MB11045:EE_
X-MS-Office365-Filtering-Correlation-Id: 6db5f052-1da0-4ffa-f99f-08df208e74e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|1800799024|10070799003|376014|366016|18002099003|22082099003|10067099003|3023799007|4143699003|56012099006|11063799006|41080700001|15866825006;
X-Microsoft-Antispam-Message-Info: 3BcuJdiYRhPTIbSzy3l8DkUaLMTP6+oykaP2F95UMkg+j29NxC2rryuz100zdp0PFMduN2fiKE4mwqpF1zHcduYlxmCJWOF71N35T2g2K6VegQeVgzIbnDxOnW6GSaHfui5Lu1PWRA5JX9B51JtL9wmmrLVgTlrdmMQ/T4DISlQac583pjxhyx65W4gI6lsPjo3MdxyPleuBd1qtmp56Rg1Q0M0oKB9h/+CMjHxb4H1hGL45X/Gaa9WfowK8a94E193XmNQ+i1nsdjMCAXZN9nIq6l1tOqIRv9n83insmlFER49NlIg3T/1v27n+TmRzqMtLBTeVOVpoDq74PoeIfnLpMuUcYdS8QNCzVYGexUuoUmnuglniXJRDo+uSIQPb0xMomn3Lqw5v+h+fWUk0TtPUx99a3TlpRZ0tt+M99qpAwNaEbFqj+rVMT/VGkPiFID+dY5BjEG472HAdO//sIkwpGrlYJckkVYdWW28c7S2RJPDX0PW8MGC8RoOrCtSRsSlk+uIY3IUH5QR51ZufI0Gwl3Tr4V/Avyjv8EvIPSsi6tzAHhi3Y95ICEvt2eWEUyouZnJa7FJAnImH0hybMfAaSLyOTM4rGAmFmxzVVWfKCCJqbVBbpLh92Mz7ynxyt9+S7JuI4xZw7CbbHm0PvPAUDFkHS2KNaK7Y5WIii5RQgqCfK/Lx0A/T2rypO0b6kP7Ht5lmA4f9w9+oe6Cra7JBDISI3A1pFBi+B4MSzf9c42ytUUslRcZaagGDQsvn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6900.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(1800799024)(10070799003)(376014)(366016)(18002099003)(22082099003)(10067099003)(3023799007)(4143699003)(56012099006)(11063799006)(41080700001)(15866825006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a1/6XU5lYOeFTBgfFRJNMK9fZmEOOh2NSJL+1sfhf6ygvLUo3jkAyUP/P9VC?=
 =?us-ascii?Q?nl2CF8DV6hmCdHIXKGicL2PsDCdOaVLzpIR1v4cVWdv2kMgwv5l3xlmmwbYv?=
 =?us-ascii?Q?sLSPzE58Xn4XuuDqwe10cogcKPOp7JM3swMmNH9+L81wcbe+27Ox8Xg5Qw/y?=
 =?us-ascii?Q?dnPe9Jjaekig0yFvTDtgAwmmQlZXk2yWY4d4hOI/lezgXSRo+YNEnsmP1eai?=
 =?us-ascii?Q?1YFGrlaA3f40LT1ZR4g4AP9JO3dWe8zmV1iT22aUDYxRTNISXVx8NdobJkou?=
 =?us-ascii?Q?4ptgEw6XsCQYOUpdqtz7kQck6jEFY54DOKW5Lfdvd3wKaHUdp7niAF12XE2R?=
 =?us-ascii?Q?fVWudfV5RgeWAfnEieS/k+9dw4uLtNHTVCyKFZZu+gd8bbT9PLTqJWlk+HOa?=
 =?us-ascii?Q?UguR7PpdLxJ3UWKdi5BuWXXFNmdQiNtaHsA6gMM0rpy7OmKMaS9mm2S950U8?=
 =?us-ascii?Q?6B6TglWvZuONPeJTfMEigYlXOIrfrWH0dTrcT1Q48CQBTKUIs4cUf30oYHST?=
 =?us-ascii?Q?xgUZZ8MMPAUMErSOpv+lROlxgF22S2yGIuAreouMxtECj7indfhqIW7bwjeU?=
 =?us-ascii?Q?46Xcx5FEeQxBroM/WCGpJRObVF/1c32lNcC+a2Q2b5AHpa9oe2T9DK8bXmJs?=
 =?us-ascii?Q?w+3NcytKlaU8DAiRWa0grOYJG0fcLref7WfEltETQXIFPnxSqeWr+xNVwDrm?=
 =?us-ascii?Q?K6qcs5uQWPVFrHR7bi+SzalSNkKWH4xxON2BuNF2SeRXGr2CqwWsHSaGKWFG?=
 =?us-ascii?Q?w5pMZZfMfFW6dTBQ9SPNCErRHzik5hflTffKga2ji6+AaOE15/LR5QutZZdh?=
 =?us-ascii?Q?IK9IivzZBWyZ9+Zl4Hzaj6CQIQ28lpgPgRhgMPwwesyjfXXJpOUg+DYzCBhq?=
 =?us-ascii?Q?LmDIVTqnZCXIhHb1+MQ1KmC+Tl4YYo0Q467CDQgFUEX49HSeU0m2E8zbTYOb?=
 =?us-ascii?Q?5/Y60kzHg/z2imBqhRGIQ/9qW1MNOSUhyDkMbCEU+EhU3unhS5cf8MPILzWY?=
 =?us-ascii?Q?5iXw/jjwxTK3oVpKv2qA62IorFUugO3bFAiZ4FPu7mGlUOoPEZlep6hqg3e4?=
 =?us-ascii?Q?UFW3rg7SiAh3RdS86w7d3RYpOb36pTB48QyfmVFOo0wFZck75MJZ/UI6GGyy?=
 =?us-ascii?Q?fGxzqlSCAYKeMXVPSjuzLJf+ZaPFsOC9gZjL7SRzAQ1kCbeLgwyDVAmDFYew?=
 =?us-ascii?Q?Jnd3Cort9QFh1BKvGVIIB9KcpZiywlq2TPpuaPJXpINoGCDHAUUBiEg7CXsN?=
 =?us-ascii?Q?ZSXzA/cJEx7TnoZ3Zs43CV7Uoy1NIAmqpUozdVyv6Ma5dk/fH36CBIVcswwg?=
 =?us-ascii?Q?f6ZsWMlOfDwESYZm56t5mCytfeSgXuI/hkuC0zDH3hwt3z5ix5gtXKubKDHx?=
 =?us-ascii?Q?NJKk+z45cbhzrATf4bQ6PFaVhkCmWyVl83JBrPAuxl91OMH4lI8Cu9nBuppq?=
 =?us-ascii?Q?vJhpNVfSev9KIUWbwXtB8wBryMPH/Zagj9Pb2PqxgrujQ66ImqQmDYt8KBzs?=
 =?us-ascii?Q?WlOk07xdcqAc/PNHr4dYOFh2sJWHrarQizytDEebCUv/YR+ZTkptHesXvIeR?=
 =?us-ascii?Q?boRauwNk6R0xO39oGoXHnQFoAKnNdsgEQpG9umvFsDtF2qMtrjiGiKhKJPQu?=
 =?us-ascii?Q?DqJ4FB78iuRnS0gIufQpintfU8h3t3PIezG0iVtU/jTy/9+2pfkdlGk3EkIN?=
 =?us-ascii?Q?NANrvBQZv1ZpMaHwTo88rWvdqxYCivjiTUcZdhbiRjAaBcAphkIZLYbnL9Ei?=
 =?us-ascii?Q?q9VNpFifgosvZHmEXMUbFOCqS5is7sGvnevIuFf6RPr7LbVANg7ckYSlUBlx?=
X-MS-Exchange-AntiSpam-MessageData-1: dia0c/XMv/bVRg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db5f052-1da0-4ffa-f99f-08df208e74e8
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 14:07:13.1142 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H7/UkNnJ9wnrCrI0XNfUGYU273YgP1C+naVXQ2DDcRMcgpSquf/wI2CLWwFj+kDkf8d0AgM6Ysqr8pArVbTSHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11045
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Thu, Oct 01, 2026 at 10:47:25PM +0200, Vincent Jardin wrote:
> Add a SD1 mode that makes the two 100GE ports of protocol 13
> two 40GE (XLAUI-4) ports, dpmac.2 on LNA-LND and dpmac.1 on LNE-LNH,
> as protocol 20 would have built them.
> 
> Sequence:
>   - bring PLLS up and wait for its lock
>   - halt PLLF, which puts all eight lanes in reset
>   - make them 2x 4-lane ports on PLLS with their master lanes kept
>   - switch PCCE from E100G to E40G
>   - reset PLLS which restarts every lane
> 
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> 
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
