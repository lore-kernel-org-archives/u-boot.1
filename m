Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03F0C61DBD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 13:52:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0798260736;
	Wed, 26 Aug 2026 13:52:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X_fGmISHjJrU; Wed, 26 Aug 2026 13:52:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787752361;
	bh=JzphiwOnl/9Xt+ZyQOpKKxjz4dZ1K0WL5nDTw8xd8zc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BHkmkP0ehYeRkWwkmvfqQ28OaYNjVGtufxIWYL/zOQqd42A/txnBVGqLogNHTRr4V
	 MIdoG1HSHUFKRaKVOFMz6s0/Lxf64RjtalPNfBfBvK+UEq6lyjAvPyn4dhfJRTx27Y
	 ziVF3omlyDo/RRnxzk0LQeqssNnahXN5EPcB50GHOk6OdOGJd0iMoAn7dN6gi6fXz+
	 r01yBg/SXXL8oSVcq2gdS+qxqfF71CDm0TuDwjEoeUBrNo2+aUmP2525HaEnvEPn5o
	 mLP+ihld5T2Z3bgP9G2Peg9r5KLLgIDbcyCF4oKFgKX2Z3uD+CzWrl8KF+WzdcbSJq
	 4mqNiGYGE8YnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9DE7B605E1;
	Wed, 26 Aug 2026 13:52:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5317F323
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:52:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 507788096D
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:52:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FZxk73xrB8zL for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 13:52:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=ludwig.nussel@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=iEei5sSN
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 012948096A
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:52:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WR1Qwog/yRpWhZZZZSG4DjC89r7w1qrxnHQLP7u5YreRcs2p73cFZzY8Iphjr+8q7Z8NO4Tp9RzYYNI4J2YeeBX4D7d5AGKBub7j5QAg9xyb4kiJpbrlm9O4ucw6RRLknv686AA9bfzuGfeYT6YSr6UUtvA7okNMov6GeagVBqhYWyYOV2Dj95zN7/a8GltVLbO21J0phViHCzTEXW5QKU8LLjbJEVcrHmkBSfb1Y1IBXt+NBoLd73oWVyYkoA8E2+xGHDJWqg0TVMkSqWEdxUFKqtO9X4DI4tSzOAN+kXi3hQQks0JRHNVDY4PRbwnhzLbasCewJYApiqvwYS3gXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JzphiwOnl/9Xt+ZyQOpKKxjz4dZ1K0WL5nDTw8xd8zc=;
 b=sp/YGfcxR+BpQpzMSLFfb4BMpdk5yz4x5tR4T1epnB3dv0RQ50F20Vcs/Gp4x1ZQE/P52S3481ReQSAQj8wcAi951bkv9bvj2AgrHm+NvRlfwTxw4bzUrdH/yG5rpHbJBDLxVS4wjdY2WF+ofsOoPJ1cHfEsx/W4yCVgHQJEBaoodFtOlEYHm8thkoi8r/jjF4FZlGCsO6x7e1XAu4LrmXXcnBp+qhDXyaaPtXJE1sQboh3dbq3smxa9q5uzP5HqgzwOg/cDGe1GouQk2C48AMwGhQE7zCdH3C0t8YG4GWshrUOCRuFL/f2oRZoLHYNB/3/SXYxTksxZ1b7YWjHqvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzphiwOnl/9Xt+ZyQOpKKxjz4dZ1K0WL5nDTw8xd8zc=;
 b=iEei5sSN3znVovOTSDu2aahsl3T/5QwE75L4jLuATbcV/i0sKW5AAYipoNp+c/Vg8bgCfaaeXPN2AZ2JhTSfm557CvilaqStVCSXQawC4nyaWR9MBcK3u05PUj5rKJDk67DKhJPsuGhAt8ZqorWtA+eY1O+YY03ekrM0i8NNEvgBPUGHyidw0l8Rh4At82xEqd7KqnneLxxrpXaYl7+GzOyJYVrvFaF1vs3DgNy7vyjctVOpdDGJC+H7IuKfQ8waK26+NVxyRY9T+tS/i+b9L4jchzOpGd4yUXSaqwm4glr0PTV4fvZwDziWHrnGvMdsB7K+sRCvPemhzKczo7CISQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2cc::12)
 by AS4PR10MB5522.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4cc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 13:52:32 +0000
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1]) by DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1%6]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 13:52:32 +0000
Message-ID: <0ddc21e0-7511-4f54-b32a-8a0163ccff79@siemens.com>
Date: Wed, 26 Aug 2026 15:52:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/8] image-fit-sig: Optionally require signatures
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
References: <20260813061009.26344-1-ludwig.nussel@siemens.com>
 <20260813080943.v8.4.6d1d5d14140677a76a7cd7bb99a9088d8c8f480c@changeid>
 <66a3267d-1980-4b86-be3a-791707373554@kwiboo.se>
Content-Language: en-US
From: Ludwig Nussel <ludwig.nussel@siemens.com>
In-Reply-To: <66a3267d-1980-4b86-be3a-791707373554@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0224.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::8) To DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2cc::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB5019:EE_|AS4PR10MB5522:EE_
X-MS-Office365-Filtering-Correlation-Id: ac3af291-f208-45ea-9664-08df03794658
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|23010399003|1800799024|10067099003|56012099006|11063799006|4143699003|6133799003|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 6EHGs9l2rw1DbqC+V5zhVNqzZMfsjGFjr5PkAJ5ugv1ya8/Mk3TCo5K2UTaxIkUHGY1U7IVYzFXSzmx6pqSkZQI97f8ltGHyfwDbyQbv1cvvbmjNLuFTUZ1YBb1I6twkPK8mCj/NFOMAWF//Mh9b/Rt5PA00EEvxYS6VNIdtaA8W773+0qc9xMQ52cWzoIOaqqEyaNLshNQPoo9JsZS/1pRHyK6RBqOZDtMLwHClM/mtxs+cjwR7uiAonsdCvhq0he/V8KcimTgKTv+IKPocSiqPUxnZ775nsbOOh9DknxO2UWHpwSt0kwuAo/qRzxALnjPT3QqFq+yLzbz9gvwlWm+uKc2JLY6FJSLn+Kd24s/ghMcn782Lu+UtNMuvYsJqGwzo+EfdJnGspAGNeMVz0AuEOf34fq7h2tWx6vusWT+eSvPX09os8jfm7COZMOZQyrcCAT8c2ynuPj7Taddrfy043kF3bFaCjM3dmPQOBVPeETNs9WsExCyTfoS0ChRq/Yt0nOAsl2qJ5vFj9NoEA27giKWcb/bGMs0vYde2TD4b4VefDg6YHWFmZLVJqLEJJ3eDzb2KpS4Wcs1rsL8TVNP6MN1iCpBs9kDigODJwDY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003)(55112099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWdCRC8rNXQ5YzUrNHBkandpOFAxMTltYjRod25XQUo2M2txNGtMWU9vZ1pJ?=
 =?utf-8?B?dkFDYWV6NEtGY0t6a3JWdFhjWjZ2ZWp5Tm8zOVVWYUFXeWZwS1RoRXJpYkNq?=
 =?utf-8?B?S3dRYkVZSTkrTnBDSnNCUFAzczNZRW1tMUMveXVWSGNQdytSZStNa0ZyK3hT?=
 =?utf-8?B?RnVMa3d2YzVpdlhvNC8wMHlSRzR1Z0pvdVZSQlh3RTlZcHZtdlBxMGI2Q2to?=
 =?utf-8?B?Z2dDdWZaYnNmNkFNL01yRjV3N3h1L0ZkOHdkdGR0VXl5ZXJ6S3cvSzAwcE5I?=
 =?utf-8?B?ZmxLZnU3WGVVRXJiUW9YTXFXRVFrVGQ2U21ZdmlDNkhMODMzUnQwSTFzSTFi?=
 =?utf-8?B?OUd6WG1TRFd5N3JzWkd5eHljUmhJNEV3bkNXV1IwZXI5eXNvN2g5L2drRDgx?=
 =?utf-8?B?Tll1aFR4L2lab3BwZjQwZVlLNUtZenVteWJONkhidGRBZnFTbEVLelBmZmZR?=
 =?utf-8?B?b2tobU8yZWJPTlgrWUR5OWRsZld1d3dXRVRXM21pNVAxY0RXaTFiK3JEbnFY?=
 =?utf-8?B?L3hWRHZ4WHpnQmNKOVJYam8wbGlFNkxpMDF1R3h3QllDU2p6RnNWYVd3enhh?=
 =?utf-8?B?WmxZdHE4MnY5bXNjRFdCeGcxeFJFRlVtV0VOWWI2RjFVNS8xalF4cWgzVStE?=
 =?utf-8?B?K1BTWVpyWVVzOWh3UFpGYWZtaXoyZWJsYjFWUEhIYUlDeXhpaGkxT2xNbitw?=
 =?utf-8?B?TEtMM2FhakJsMUEvYlZjaUtWK2g1VXp0SW45ZWl3ZDdjMzVySEs3MG8xODla?=
 =?utf-8?B?MGxhN2lEaVN4WExTejZNdVM0M0Q3d054UjdTTDFaaFJVNmZtRy9FeFAvWjIz?=
 =?utf-8?B?OU1mWnk2eXdCczZjTUkzYWpOV3VkTWtIb09GU3E5aEcxdU05NTNiQS80RWcx?=
 =?utf-8?B?SzVpQTRPWTRIczBnSjBpNUNXMWJBUEs2UGdFdmYrS0tvcGRTMkVHYTZXMFBN?=
 =?utf-8?B?OGpTRmtldW5nNWxGNzZtZnhPdU1ad3hPandva2V3cWFkOGV2ZXU1YXVzVUcz?=
 =?utf-8?B?WjZzZDgyTUpsTkd0V1VldUN0Z3BVQmVQN0ladzZaTGRPMk0ySmVuN1JvUFcz?=
 =?utf-8?B?a3hUQ2tndXdTZytjSk9LZ1JQWmNNcFFWRmd5aXVUZWJGN2JraHZXMW1NMTBI?=
 =?utf-8?B?K1RrYlRKemluc2MrNkNZamNWM0F1bTlLS2tlenpkSGYvQkU2R20waUExYjR3?=
 =?utf-8?B?MGRXMGxLUnVBU0ZIQ004MjJwWDJTMVN0VUlsL1YvazZwL2V2cCtLaTA0aFVp?=
 =?utf-8?B?eXEwd1JWVmFFMkxMbjhjUlNEU2l6R1d6SUhjSWpVcjk1VFBSQUJCNzNVMExv?=
 =?utf-8?B?VkppRloySWgxRDFSWGMyQ25ZMHR5ZXhNVWVLYkNYUjZLSGFCdmw4UVd2Zko0?=
 =?utf-8?B?WlRzeHNXOUh0SUVBZHMydUF4dFdRSlEzVXkvbTlXazMrNzk2WEsvbjJyN1pL?=
 =?utf-8?B?T0tjRmRTbDBsUmxkeVdCVFFwTHdjdVd1cmJNaytFNHZBUDRDcHdzbTZ4bGRL?=
 =?utf-8?B?MGJoTEVtTmpHNmg1THp6bm1xNjRRQ3doRzFpb0pHbUYwby9ZZkdKRklsV3NZ?=
 =?utf-8?B?dDN4eUdIQ1lTTUIwekM0Uk5lS2NnaTdtZkZEVDhrUEpXUXg5RW9WWEhSMHZx?=
 =?utf-8?B?OTBaUG9XZ2s2NnJKa0s0enY1Yzl2UklCNk10Z3dtMGhzY2I0VEZnOXpWSDFy?=
 =?utf-8?B?SElWaGIyeElBR09uWURxUGRhN0dPbklibHlyQlVuQVhuRHdXNHYzdHdDa3Ja?=
 =?utf-8?B?TmF5SHhSeDl4U3BvY3p2VlRkZGIwaGR5cFAxL3JpRjJoNFFsTnB5U1doVXQ1?=
 =?utf-8?B?KzF6dytOUnBlbFEzQnNkMU1hWXdHZisyTnNoaWlzRnJRRUhOSmVoWHo1eDVo?=
 =?utf-8?B?MHgrblBnYmxScWxSZjBXTGlMZTR1TldmZmc0aUlEQXhYTXRBNUIvd2YxbE1x?=
 =?utf-8?B?MFpSaTErczhVU0E0WDIvRGx4d3BtdG01dyt2UTFWWDNsQTYrbHMrL2EzMmw2?=
 =?utf-8?B?TWlqaGorMnNyNkJFSFU1cmsyZmd4ZDJhcWJmM2h5RldkMnVaUDRpQk5xVCsr?=
 =?utf-8?B?cndxSHdkSkxLL2lMRlFlYUxMcHdwZnFnUi8zdm52TE5oRFNhTmZaRzh2NkI5?=
 =?utf-8?B?YWMwZnM3a1lWcUd0dkJKNEVjOTNFeXk2OFh2QlZwT1hNN1g0ZmRuRFpiV1JE?=
 =?utf-8?B?WE1MWmpCQzg2eEdWNzc4QXIyWEo0T09yOGtMMUhWa1lDNWpyK09kVEVaeHlK?=
 =?utf-8?B?MDNBd3drdTlBd0VPS25FeVhocXZRU1NzVFY2R2hLV3k3YVdFd2EzcmlEeFJm?=
 =?utf-8?B?VStBcHZmQmZoMVJ6enRxeitGV0hRa2paUjhUcSs2QStwNXlGbWd5bFduMC9Q?=
 =?utf-8?Q?1dYuXPxBDMn4o99w=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3af291-f208-45ea-9664-08df03794658
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 13:52:31.9501 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3rhtq/0wp4wTA/wVZY9Q0cc2cy789nFnqoFBF6PQorCQ9cUwWTegdu4u4iimQfeolLYSr+AbOK3BePrT9OO4xCjA+budQcVN4mrOUxShQ44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5522
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

On 8/22/26 00:48, Jonas Karlman wrote:
> Hi Ludwig,
> 
> On 8/13/2026 8:09 AM, Ludwig Nussel via U-Boot wrote:
>> If U-Boot is built with signature verification but no keys are
>> included in the device tree, the boot would still continue.
>> Introduce FIT_SIGNATURE_REQUIRED to avoid a fail-open setup.
>> Defaults to off so existing setups are not affected; boards wanting
>> fail-closed behaviour must enable it explicitly.
>>
>> Consistently use log_err for errors in fit_config_verify_required_keys()
>> while at it
[...]
>>
>>   	/* Work out what we need to verify */
>>   	key_node = fdt_subnode_offset(key_blob, 0, FIT_SIG_NODENAME);
>>   	if (key_node < 0) {
>> -		debug("%s: No signature node found: %s\n", __func__,
>> -		      fdt_strerror(key_node));
>> +		log_err("No signature node found: %s\n", fdt_strerror(key_node));
> 
> This change is causing a verbose error messages on Rockchip where the
> FIT_SIGNATURE feature it used to check image integrity during boot. The
> config nodes is not expected to contain any signature, only hash(es) of
> images.

Is the message a problem? The intention was to at least leave some clue 
about the potential fail-open behavior.
Looks like you are also not using signed configurations with is even 
more suspicious:
https://docs.u-boot.org/en/latest/usage/fit/signature.html#signed-configurations

cu
Ludwig

-- 
Ludwig Nussel
Siemens AG
www.siemens.com
