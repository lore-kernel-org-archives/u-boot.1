Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B935CD4F24
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 09:54:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFAF8838BB;
	Wed, 13 May 2026 11:54:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fjPy2Yjs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 023FE83E36; Wed, 13 May 2026 11:54:54 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2825D8341A
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 11:54:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ipTNY+sUEppDS4L1NA03GDI0zbXRSH9NH4PkBucUMpdFNCV8bvCSwCzImBfKzob5TCcZ7Y50Qc6DAktVtb5ZiqMsCktrVpy0JtT2vGpuJtFP7iecaFz9hGqRcnmRLiY1S2qc7q0dHAgq/nHfWJPHZMB0P8I9bF7iT/ocWC5pIQqObqMDGmRWxHOy2r8HkenLIiqG8OuNpxnPCDgJ6VpbV3eNs+yZ+bymd5jn19wdaxNNnfWiqGGY8rDmdHgekC5AnIgSNqWAiBC9Ycg2IgmeVpX2V3wtvzEtea1JzfD8nuB4fNFXa2wDCK8uL5Btp0DVtJXXVVUiqzFMwuzNDmjUNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zDedNwQnQEe/R5USs2JMdSkkKUQ9V6UyojfY3w7AiI=;
 b=vkzJch9y8g+AidPmtMkYb986zaAt696xUfH+69QUYOANbnx98nvkVseLRAzNaH/69a3ZbPYNPNVqL1ueJ1ds+AxP9l8RY44oxrpKVwbjLkF8LNZeNd9iQRlOGT6L0Fph5TyLvhDdPhk/RQeXZSfuGgb2yLOY6B7f/oXiK2VfcDqmwM4T7eJqfbU7kFvKUvddi75cvN7pDdhsMs25WYXQU/FeHkVuPNLBQ4iEZ+rEtC2bJ/FLRJc14OvRQyfG75jZaESVQmQQZPLu5wS+KooolOeo942RJk3MjdyNAkdGei9crqsNl6IvPWpR3fOuO7nVZHjCRLHVrc0slFPNegKWSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zDedNwQnQEe/R5USs2JMdSkkKUQ9V6UyojfY3w7AiI=;
 b=fjPy2Yjsbup+9Ddn+y7TVYejxugkLag8Jip1H9mFks98i5vKzc/5oLOg4vtnRnSC+D8Bzv/0Wt3z4OCcR6EJ/Pvhf6XP8KliK2ikTbyZHvnq8jiuBCCx9hdyzFec5gu76LDtF65Kpe+cRydWEMmqsQ4qMzZiHp+vqEEh7+xjYJ+EjmSNNY/jzggejRS7KgWdFcgtcF2KSIBHNUXDKba3YRpKPByzgbZMTbEAbELWY5ShP+GpAbUTSQUsqHyyziFJ0z6npFd+xP9KdJDVFwf8T7YW4KYe+Mvei8glUy5Smv1gqNTIrc8xpuV5UBOK84lW0+/NRFcHW3ImoYL5uW9E0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AMBPR04MB11788.eurprd04.prod.outlook.com (2603:10a6:20b:6f7::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 09:54:49 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 09:54:49 +0000
Date: Wed, 13 May 2026 17:57:33 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tanmay Kathpalia <tanmay.kathpalia@gmail.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] mmc: sdhci: Start status timeout after command issue
Message-ID: <agRLDbHj6jTXsJ9t@shlinux89>
References: <20260509175932.263105-1-tanmay.kathpalia@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260509175932.263105-1-tanmay.kathpalia@gmail.com>
X-ClientProxiedBy: MA5PR01CA0206.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b0::10) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|AMBPR04MB11788:EE_
X-MS-Office365-Filtering-Correlation-Id: 46646a04-67dd-45c0-32b0-08deb0d5abac
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|1800799024|52116014|366016|38350700014|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info: Q/KxKcK1XNy5hwiick7aigM7319INJJI2/tK9ousnTRNOT5+ScWTRpRkVqeHJ+z3XUymi3Ol3l2NwdniBWDNQ/EO6Uc3Y2bJL+lAQ0nAzAet4MB0p14p4YqZ+CT/vJVnUQocaSf1VRkEMcS9yoh9zj06nzmzVmQU5JLP4kXLhe5u089cn05EKwxRnn4os40HzPJf4rvWcvLoCVQWrMs16XafHcKT+f4G+4tR3pxOQXv7d5KDtBBQo8wBXNp6zZhsZHv4WSV2A5DIbQkb+FcZBt1Z+oEqSGruM4lXGKV0fGY13nWc+lmGsmjckoNvSjwneNysL0gaiB3Xo8wr+D1peOUDZmHBKAIgCsJkPhzgpYIfk7cTZSHBgBcFoUDHQeuPZ3A3sj98j1H5M0/o15x1Dio/iVzIXyHF0SGeU3cxMOvC1SgdKGGzZPC3y0vSKtzv+KrjYAM1GSKiew7rr56N3gTtX3ozNIR2qYXClqbFFE39YgMJOF6IcezfvRhtcpJ026pdUGN8ENLDx6Py36/If0uk8XKdEpmNU2ElfWJZ4LBEV/i8d9p2M63jz6pmf8ZJBQgodblB21SxWCTsKljijA+70as3Z8Lo2QlGHbnclDBbn72+hKpHyRGXtDVMdrS3Chji3HdGL2j/W3x2Z9VPg9XMgx2UwrieImv0TzeOwklyvBas0C4I0KWWTD0K4Kxjfha2+S68zwva9vu+5N+rLohukrQSMzetZpBqgdo7qayPUzKvZo8dV0DIA/xswXz0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(1800799024)(52116014)(366016)(38350700014)(56012099003)(22082099003)(18002099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M8iZFanHZYwA5bE2KA+09KoHwzAYylzp3EZCIz9B778BcXe3HjigLMDUo3K5?=
 =?us-ascii?Q?syoRsm5zE4a/DZ+ugpo857yPhAVrX8zXvhqqMNcxu5YBhJxJEHMEmeJQ+3ZI?=
 =?us-ascii?Q?VOayQak5RybdFZsd7hAZf37mGpN3V9cmoHcXhB3ISIQ1KyKEzm1J7xbCKq5B?=
 =?us-ascii?Q?9DOaXvkfblnc5Zv4QPt3UEhNJZTVa+eZY6at1JPjxQ7D5jqQSeRrhPawoTIh?=
 =?us-ascii?Q?Pyc1Q6LOdy3NnYR+XEIOvhtKXvl+7xe6eBPv8QBhJaWuJKRsc8qVquNmCtBQ?=
 =?us-ascii?Q?gSk/c85n9ASPa4bRzQVPEvrc1BLxpF9NbU/CxKDUCpfs9ItHXeqHMqFTHA+O?=
 =?us-ascii?Q?50H76FTzVMk98Gn8EkHElai9+b19Ee9N/HHPQyyDttJYPAtwLSwelQ2ID8bu?=
 =?us-ascii?Q?cxo873dIH7fXOf+wOD+MpyRvFbSzuhnyWOb4wMVLorefswaNdb61NkWCKsEh?=
 =?us-ascii?Q?5DzMtp8m73IqAx/iwb892ubfExdOj8faqatsQZ/T02UH3L5c1jl0+4V1ofd2?=
 =?us-ascii?Q?TDLrRd9anR52DKyxpMKr64HVl/U5bJ3w4zCtfHqFuC4JQpxe7LBO2o4i4s15?=
 =?us-ascii?Q?Mj2dCruzHoJvUpRkG3X5DU/fY2HTWHq9A1Ck8heV5ibM2hyAdsrzPm1KOcQi?=
 =?us-ascii?Q?0oikQgbYwYVRhKLzDb6qtUia+H0IDwCRyzjIvUKg0I9+URw+5qvCttVHGAyR?=
 =?us-ascii?Q?kqtZ6kk11oYCeiWdXlVWyoEoQbWybG+JptQxXqGK9sQbSinxt2oMv1pw+fDs?=
 =?us-ascii?Q?OtYiWnuR+H9cuNpwT/HvXdrfJdrmBLex2/2FmNk8OJeCuPtL2BqT6zapNjm7?=
 =?us-ascii?Q?3+F8+DfYBBZraUmBcnm9bWHhImNlqiR8VtweCNIdneDH5QYVnhyRfMT7jVNN?=
 =?us-ascii?Q?ycp3rVStlFiCWNvTrefrfLNJQi9FXB9zL9GG1TkRm2SSsdX594Jcx2Pd/lDR?=
 =?us-ascii?Q?ssivQvlzVROe5LcQDDdP3M0g926/x5YHNo+Xb7nzjm9ZnTNm++kVAiC74NPG?=
 =?us-ascii?Q?4wo0O1W0SiMwpJ+wqX3P5w7Vt/V3c+16gT3SMhBPTvBPYhG/qVkDXODVqXcc?=
 =?us-ascii?Q?/mEDsb7t/GVOqTtix97NqERSgiig0oiioVCjz3TKv3sxS3lcEz69BQdSxLM3?=
 =?us-ascii?Q?LOWdd5p2lnrIzELtgYKS/v8lUmHYpmYYlVG5kr28wbroSzOhmvfM3CkhIxJf?=
 =?us-ascii?Q?JHY+J5xOZYGPCMZoyHUFYETgAML/vASCPXWW+jaE/xCWCfwZ6rWAY3OPTtSK?=
 =?us-ascii?Q?Jq9T6rkCDPPCWGA3p8R2B+MfU7pERERoyJ1x0ghmAa9Hw8EReRrWYduy/988?=
 =?us-ascii?Q?wx87E2i6qj7dsS6BeCGvWtZfONL/LYBryI5v7358fW0Y0tu9mu7mGKvKvmqm?=
 =?us-ascii?Q?JTOTqlB0lprQpy+UOduwKUIRy7qrQ1aa8wEI2M4XRxh5xAKt2ht9+MOC6kUC?=
 =?us-ascii?Q?15KczwxtKASK6X1/llPhkS8N6uP9Jw+wd7E9t6YmbNtJD9yfxZTTaW068F7z?=
 =?us-ascii?Q?o8Fj/voKyc2EUYNta/iFfDTO3G55n2pz/4xzl8x4Kt+lcjXojQGuzPqKCxIi?=
 =?us-ascii?Q?M2/rda9EHMsBMudj5ie3ogjIGQICEx+JANFIy5OE6GuJ8omzrRqEr1WP57T9?=
 =?us-ascii?Q?IX5ZkezVrLm+RhxteKQJVQ9rVcJ0RpP39y9wbd1b3qfNwWw/7XCGfGJOv1mq?=
 =?us-ascii?Q?L8xUS2amoFHYTR/hxtRK8eBaV5vKDyim4chrVtxGcddKRS9WpgOjETnu1jKH?=
 =?us-ascii?Q?zI9nsM/1oA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46646a04-67dd-45c0-32b0-08deb0d5abac
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 09:54:48.9850 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXgTVFAVetVFSVwNmD4R++T+JfnSlmpNWnQUJb3KZ8FUuanOZmJbgixXWHumpIDmidw+KVUzBnwuAfMjrslZJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB11788
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

On Sat, May 09, 2026 at 11:29:32PM +0530, Tanmay Kathpalia wrote:
>The status polling timeout in sdhci_send_command() should measure the
>time spent waiting for the command interrupt after the command has been
>issued.
>
>Do not initialize the timer at function entry, since the command inhibit
>wait and setup path can consume time before SDHCI_COMMAND is written.
>Start the timer immediately after issuing the command instead.
>
>Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@gmail.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
