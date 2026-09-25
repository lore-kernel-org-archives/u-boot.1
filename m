Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D0AC98321
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 13:49:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8779640A6B;
	Fri, 25 Sep 2026 13:49:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KPKCjOqY1Ltd; Fri, 25 Sep 2026 13:49:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CC71F40A3E
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790344142;
	b=NBSH+xSpmtQwXez8yRd1DUCdOSrjMeG44mzaZgNB0QBFyTu+rjFBOYfWin7oGbrvLQtV
	 BTOZMd9JFgQuBlpu2e2zucAumbZDFcUMwtoh0fC85xr3dIdNnBWcd24JeinDNLjxVDM1x
	 qP+ZisO4Fa1j7G3LnHvNYhI/mklpAKgSzOZyY/r+0S9kjkL6L6q15PM8w+e5aubkE+53I
	 z7nMf+aZ9/1kmwwm/CKAfbGrZLPAH4MrlyVyzV006dyUOIfZ6h0XGEE/tMsehyr92vwoH
	 nBCWg0bf/gER9hNxe5up6M3EkSoUmmBrnm+q2ctu95RGNFnSk42YnpNFSfoZaoTW2aw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790344142;
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
	bh=qYGOrNpSdMrwqmZXLuBBU/4ZbZP6wgmKtBw5xLUvy0c=;
	b=fKYYBE0gvoAoQxNYZyD6Eue1UjOSij8+kCc4lH9cKXSCZwpgAYXFKG+lbOM8hacEFxL0
	 fCOr8y1DPbikUWzw7AxcR9gMbrmVFhWmIlWSTxenB69H1HHeF9zbbia+qacHDRldl9yuV
	 OCj1U49jIbxgo+VHAzXTqQyWBBKx3bME2cqDmQyPNgzC/D8kpFA7Hs5kXNViu3hPLytPo
	 ZbR/t3Y9miC6Yqa40oOtZC/9Vw+RVyHafH2DIRmEDCOwe1oeoGhf2p9JeUmFlbSTgpDVs
	 wANV+tek96HjltUSepZE3ZIHHndOfE+eqRFiaOZupVgEGv2mm5eovd0Jm9ch5vfinKg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=ICym+0Gy;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790344141;
	bh=qYGOrNpSdMrwqmZXLuBBU/4ZbZP6wgmKtBw5xLUvy0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=urxldxsdSUdw+WMcEabeSBOQWYd7jX1/i9bY3nisfKBelR/JTy8SWqj0fI0ZWlhcN
	 EjMGWFTIkx8qZi9yeFmx7O65bn2S+C9LhoXWDbQpfRSJqMW6QeJGg1ERJEUrLM9Kfu
	 MXN7P4UhtId/LT8eEUui4H1V8qyPlY1qEKAqn4gOGHhxCY2Zxi0gi+ROfZUuXiEUyB
	 mxae5JQgKrNDN+m2SO8KnTMDKbfBHph3Lo/c+em4sj6OAPsO6NtgnGFXpXZde/Hg8A
	 uDOdxNImVXDjwRiJhjw42R5TqijqaQBQRmEOuM9HRtp9nJhVPe2mvniF0hW784YFKA
	 WmCM84V/X7ncA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CC71F40A3E;
	Fri, 25 Sep 2026 13:49:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D436C32F
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:49:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BD30340A4A
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:49:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NGZ7u-g1LMzT for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 13:48:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3F98E40A3D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790344139;
 b=HsKMJer032X+epjfMkFrnpcC4ddp3socAp/HPE83En40L3qvtKbK/gjenTsppqONTxO0
 HnQHUStoYl6FMB7cN05FVKFMZoWe9r0QD1qLs+2799E9riSmKuRHq9gdMZsyGV0sxMDxW
 EPxb7lnnpfyWARSwrLgJ2JLHsf7UlUPMQXZcTFwLfv9pYN/ddCZosOWKVBo5OjcdfAH8F
 YBm0Z/n0RgwW92o0lgMeU3i4RgjPjN2aavNlcxEB6+jtyd6cLNApcjlPm1dD45YMF/Izh
 UsD1Yq5CtSiTXkIb9PIC3rFRd6z9ppVlIhEYU3V5ri9yz/n/zEAudlc2knSyajdYSdw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790344139;
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
 bh=qYGOrNpSdMrwqmZXLuBBU/4ZbZP6wgmKtBw5xLUvy0c=;
 b=AU/dY7Vk0NgcgQ24HTRlHYm9gdRhR0rqZuSkxglcBa57FeCp5d9ek+SNAk6HR/KG+2pY
 QR6wtIFyEruGl3VHVMY7xzZcqY6WHDoXFYx1z4MpmsLZuz3kfPO2pLw2U+V+j9FOYnNq8
 J9IVKO3wKi1nO0zrCjTYZaaqSOtqf21DyMEYe+sTs2AZC4zAhwZ32BRPtTAHNy6l+emmA
 ZbA+xb2qVv4kDs0QSHh0kgNmPREzytJSqMR8hUYc9qYGGa2J6H9WMCsyACWG3x0yc11hM
 b5mnkFOgEk33u12sF1n9LzOLnB6x6I3DG24Vi6TIX8TJmgprqp+gfXM3lIjRdfhOqhA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=nxp.com; 
 dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=ICym+0Gy; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=vladimir.oltean@nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=ICym+0Gy
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3F98E40A3D
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:48:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2UrqSFIq7eHvX59SiotE+t+xThzdRXzsj0MSnBzfFJS/xLZsDrgK5WjJEn8jC9MbGYi2fJNE0GX+JHXyxHXxrsAgx2SUoVV0ni7avuSAl/W1/0gd9OdbX1n79bVFfK8t796wGXJn1sKjbFIrVwHXh24O9f70duUtjVuBGCPSSA7e1LJgZOCNPT/xHz7DgxTXMebaE6QocEiKPeoKWnR8y2K9wGVv3sK095DrlHPapbtvcxAtGtRsChTGw8Mzf4dnaPmNWf3VUOya83p47R6P0FC1eo7lYMvGDjf79LbnsbBd6E2BCwNwv9n0MUx4YLgbt534QaxCFOl0TDiQLURbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYGOrNpSdMrwqmZXLuBBU/4ZbZP6wgmKtBw5xLUvy0c=;
 b=CO+uqrsrdiBjHDTIBGhSWvxnj6/rKr+H9JYKr7j5rtBc2OpT9ptu8QWtXpZM2qXDNyKrOqjPieWnd1Z5H/XuOn20E48JZcaZdb1LV9Z+YhscMdXNZzbGD8PfMlFoTYwmKw2m6tI4cwQxh3ajOTzfMrJfhGF989aBH/Vau/EjVNch+WprvVNaAL/fJ4TaLr5OyNl6NBUfN++Trz+ANCkspzeCWIJRm+kumBsDgjzcl+6P5Nc+C0QQE5VPf1/Xf96uWURU1V89QqKJXwonpV/JcgKbatqJwIbox5pwEEV9EOJBL3CMPTXLhTxQyVnmqKOSSd8AnAHrN42scpCFGhX1hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYGOrNpSdMrwqmZXLuBBU/4ZbZP6wgmKtBw5xLUvy0c=;
 b=ICym+0Gy2HKnm1+gjFfPntc/I0oYQa9pJPnUvQJswCIXR36UV9eb8T682b3jW2vSq5Bdafg+DVTLYR74tcz5W6Vix/ZWcgrqpuPS/ZHqSxaQ15sHMVCBY3Z+5JN9Dv4a03euQmYDQea6yg7BP2M+ve/o4V1ML6McI+zJ/m5yJxd6zJn6zrZ1AjEfmMYXM72FlMEhBtlzmb8w2FwtYBiR+OCOTBKsrPiRKEoy/Fu/Onj4vH1nCfbJWufjhe7Zrqp8hdBSKQr74y+8SGulcGr7JdoCpPboAhZ8GyJmRK1KHGXLlUUeiYTxOtQ07f1q1L1IcaDSJ+G4ClxbFN8Fj/2+Ew==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by VI0PR04MB10829.eurprd04.prod.outlook.com (2603:10a6:800:26b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 13:48:50 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 13:48:50 +0000
Date: Fri, 25 Sep 2026 16:48:46 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.u-boot-project.org, Peng Fan <peng.fan@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Tom Rini <trini@konsulko.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: Re: [PATCH v2 1/5] lx2160: add lx2160_sd1 100g4x25g and
 lx2160_serdes status
Message-ID: <20260925134846.4tazuavdyax5zdze@skbuf>
References: <20260914170417.3052423-1-vjardin@free.fr>
 <20260914170417.3052423-2-vjardin@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914170417.3052423-2-vjardin@free.fr>
X-ClientProxiedBy: VI1P194CA0054.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::43) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|VI0PR04MB10829:EE_
X-MS-Office365-Filtering-Correlation-Id: 00ea7802-2011-4149-d330-08df1b0bba80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|376014|1800799024|366016|19092799006|10067099003|56012099006|6133799003|3023799007|11063799006|18002099003|22082099003|4143699003|41080700001|15866825006;
X-Microsoft-Antispam-Message-Info: aAB/ChV7FGzjnIMzCtZpE/dB75StqPgMFYI22vuI/4FKl03XpkAIHAq43HEtxZjt74pxZ5Z9j2+u3hqU6hvB3wto428jXF+iUpWlK+4R6UfDto3mbzZ22NO+axGVP9zJsQlqodP5GPm/W8XNqCOMPdqzeKbqv2hwwhy1dFvTjKDCtZMc5za0LyHKNVTS3QuEE6goRKAbKxVpnorcjP3FFmKz2Zp+ooUVhBbNTJH2Yhk2qJHNor9T2LqHphHyJq8X6PwSs8nMzi8t3+z3SF0bENgQSfHbKUiX1xPfXU4BlaXNz+S8JX9TdWOs1oomr2Jd/iVx3VeTyoqDqIz6PbfJhbquP09Jjh2nE4g5qixUuzRvsMw08avUOf5+V7JT1TJEU11Kujtqt7lbgDgM+zBTOI90UU/SIr4zDXc/jFdVFv8QPKBOaejJO/JSpbNirz1lxSSVK3r+whfRiE4pwWeIwlId+ViwNJ39ohOLJQePNEVLBydqkIoNggIrNMRxoTK0d+y6v9s6l7+m67IG4nSbokw90T71AmbNWk/h/gJHmmkR37SZXZusu2VwbwVF5tHQiUo5qun9y0W7WN/FIMRLED/AHM5mkEPWz1U/rvGMdKI1kN5DqQ2zahfaO6tBpJ+QXPB3CXguafl7uVeSbhVUCgqOo3fNDXdxaM0r0iFJMQx63m+CNGRv15FdwR4gcZIXQqNuVkFwUfc/7ZDGjLOF17Gj7VCVZ6EwtqVTSVaxSNTSk5fD4kwg8qMYuujglp86
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6900.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(376014)(1800799024)(366016)(19092799006)(10067099003)(56012099006)(6133799003)(3023799007)(11063799006)(18002099003)(22082099003)(4143699003)(41080700001)(15866825006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NGh/Opaq2Cu0ZlE7CHlLcnMSRwS8Lg/AloiJLLQgMAw9wtqp5lblyRFHTo+S?=
 =?us-ascii?Q?tIpHJBSSMssckR0bULzXdOHzX4on88RuckxOW9zJCtc5/Z3iQqhUnHyQN649?=
 =?us-ascii?Q?jBQKDKvuHngHsePM+eN5v4PIIIMNl+gV3rWUsinn5B73OfjA08tWhWRKKod0?=
 =?us-ascii?Q?mpKVnYLV6Jwz4afUrYZKTus6Tj9r+j4BZFqcSVGvcqXFPSZpQwDSID3Owm2P?=
 =?us-ascii?Q?wM5BRV14p9hIWpa9nAe8R94DvRLv5IggGuWd4DmLc/OBxXTaN1/tC/GAEgZb?=
 =?us-ascii?Q?QhO4uQmE+nv6Ny5jhsANXBO0TQl7RhpqSaExX7601G3rTn2jXiqL20Ctbcnv?=
 =?us-ascii?Q?QgKabdu5U1PzwSuY4DLtZyE1ZmQhe3N6mrMNdbk7MSPSjT82zPgvlrarHBrD?=
 =?us-ascii?Q?oVicaYhRGaewSAGetE21JliQLG4TD8A4cLv5vffRprQn1REnU2Yv4cxBRvB1?=
 =?us-ascii?Q?Mk/njVhfvePq5htjLg7Ny6gWcYsg09bCoQ2nkAiUbEPR0fWZ+cH1ltaUHkVp?=
 =?us-ascii?Q?1jxPRpkjMFoHZ09zRuonJg3z1iNCHTFgNdK7xqq/X4cGbMBx/ssoDBNFbukm?=
 =?us-ascii?Q?h6uvPfZvS+g4ivRMcRJW5pg23A+SxOwjvyuzXzKbf55O35h6P2qwnNOp+Cru?=
 =?us-ascii?Q?qw4sGr3cNwX526U/FGFeIYk2MuXO4thiO9Ax3PCWTf8h2l5SHbOFz6N5QA1S?=
 =?us-ascii?Q?Dj7Vr+ES1aN4n0rjKQm2CvrnN9thFiRJlMfFpGFpEsHUGqRYjls9qCYe175n?=
 =?us-ascii?Q?6ezrIZlMLFbLMwoEhWxOE4IT29ZtWod/1Xd+oOAWgPnIvTlrnMN83dh+86XB?=
 =?us-ascii?Q?S2AYuxEf5d40AEJ0rWzf0waHbgpa0GnQ+j2S/0qpMXgM7mIIDxKcughaekar?=
 =?us-ascii?Q?GSBayPmQyKxNLdVhcUqJQYPHFYY0d1kyia1WZXq+KjNNCJfn2NyEYRtSOe84?=
 =?us-ascii?Q?Lgioe6EOOIhnW4TcBhw0s8wqhE3yDX5GM9Rm2NMIhT/kz5y6EZdpvLdW37Rs?=
 =?us-ascii?Q?2moWwZQuRwbny2D0VVGv362gfPQMYNxuxyKGG99wwxNSvD6E9e0aMUER4aRr?=
 =?us-ascii?Q?40yZtguFKQhXc74KikBUbzqf8qzJ1GT/R+O/bU6agW78fzs81RVutS+CRgNQ?=
 =?us-ascii?Q?dYgG6b/D3pnCgfeg5OWqHShmiydOPwBMnzwI6EuoZPjhYHNgc6oxuil4as5d?=
 =?us-ascii?Q?2BWcO4AFvzB7igzHsdC5l2xs3QNYqSH7dUVa4lXH+pwkQDbGsfBbV2ekK7ia?=
 =?us-ascii?Q?6WpFOZ5EPt+Ye0jHAvgqF2oqhnk4dpx5bx+ELtG7JTHlznTeb2LWjNb4l91z?=
 =?us-ascii?Q?bk+B2aeg0alxTTmWKaDs20HdJL96m2giKt4u/hj7rydVjThngwq0Lx6J8r6s?=
 =?us-ascii?Q?d2E8JPBopWkrKtrh7ZEGGf9nxwJ/cEBVe7htUpACvXBKHa7v68EygR4cpd1R?=
 =?us-ascii?Q?CKZSqsa/4yAzutyp/uNVu9hCtbKO4IxA77VtIUstAeyesPl6wfVKqo7rkMe3?=
 =?us-ascii?Q?WllYw931bkbdP/5JVXF6YPX1b2l1w7OqhvTmQv/LLvHvg0DSWvHGL6PHI4zf?=
 =?us-ascii?Q?Vr8/p3AETi3jDtRfcb9iBjnzoxU5EQREzsZhjOY/8pPjhUKiAkbH1t60OqF+?=
 =?us-ascii?Q?QxvoDGM9D11001XoO/vHEznptVnQ6l/oc5se6li8sATajq8t1Kum7E0dKj1Z?=
 =?us-ascii?Q?RiCCLgqyLizI+Sy8mQJPWL7Af0xMW3vF8qNvSe4SYTtbgtky/nplFCOC/Fm8?=
 =?us-ascii?Q?9mgu12rAthzvVYIGfhtxL9C4Ev083ZnAqywdQAoQzfzkCtsm71XFxAvZFqB1?=
X-MS-Exchange-AntiSpam-MessageData-1: HRIyi0WnMzZcRQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ea7802-2011-4149-d330-08df1b0bba80
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 13:48:50.0224 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: neW3bHBmc/DwK3EMuRrABRG5eLE0njkeDS66dRpYr5wMIBGNN62wzJfpXl8DnuUOde7PXBNxcBbog1KGb7gGhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10829
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

On Mon, Sep 14, 2026 at 07:04:13PM +0200, Vincent Jardin wrote:
> It can be enforced using:
>   setenv hwconfig serdes1:100g4x25g && saveenv
> 
> then lx2160a_serdes_apply_hwconfig() reads it and it applies the split.
> hwconfig is the established Layerscape mean for this kind of per-board
> runtime choice.
> 
> Currently, only QDS boards have daughter boards for this feature.
> 
> It requires LX2160A CPU that has Lynx 28G Serdes.
> 
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> 
> ---
> diff --git a/board/nxp/lx2160a/eth_lx2160aqds.c b/board/nxp/lx2160a/eth_lx2160aqds.c
> index 4c16f565b69..b13606354e0 100644
> --- a/board/nxp/lx2160a/eth_lx2160aqds.c
> +++ b/board/nxp/lx2160a/eth_lx2160aqds.c
> @@ -9,11 +9,20 @@
>  #include <exports.h>
>  #include <fsl-mc/fsl_mc.h>
>  
> +#include "serdes_split.h"
> +
>  DECLARE_GLOBAL_DATA_PTR;
>  
>  #if defined(CONFIG_RESET_PHY_R)
>  void reset_phy(void)
>  {
> +	/*
> +	 * Before the MC boots: it latches the live protocol-converter
> +	 * configuration when it starts, so `hwconfig=serdes1:100g4x25g` has to
> +	 * be applied here and not later.
> +	 */
> +	lx2160a_serdes_apply_hwconfig();
> +
>  #if defined(CONFIG_FSL_MC_ENET)
>  	mc_env_boot();
>  #endif

Why specifically for QDS? QDS has the board_fit_config_name_match()
implementation which picks a device tree with mezzanine cards based on
RCWSR28. If the SerDes protocol has been modified by splitting/unsplitting,
all assumptions in that device tree selection process are wrong.
At least, I'm not sure how both mechanisms could coexist in a sane way.

Why not for the nbxv3 board only?
