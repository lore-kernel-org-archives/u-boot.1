Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77740FD9E26
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 01:25:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F3DF83BB1;
	Fri, 27 Feb 2026 02:25:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="v+bAA2+e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0546B83D1A; Fri, 27 Feb 2026 02:25:33 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A935E83AA9
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 02:25:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IzDmAKdsc3g8sgzmD2svd4rIQwQFPSNfIDwAZQToke7Bl9cpa3Ux7gqlRczhsD0g3VG6PTo/nqZT0ynC8MWBy9GYq5fpMIZZ2k2QnvWFPvvMLslIYS89T5ZyoeFuWozEOwFIG1wVKRjRPGjikjLe//dRLM/x9+G9JopIJecFIaFoC+a0G0UeGZ0IiL760u6UZL2IUhaMW3zciOo7FydThsJtdX7afgym9gdNEWrlzh5nvgYAEetiNwa3crj47dzm+kXSsvssc1qsiJ1bTkwbxq4dBzOeb6YsABg6ogr6/xP/zlwyHO0hAntj8H9aVcEgDM7J+btxHdydY2O1I0FnRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O62JFJIjn2x8K+xMlnQ6tJXnL8Y/05dLXcClYyxiTkU=;
 b=I7ObGBB8hNH8/8ribO6S8iI09SC4iHjXqr7nHMeS+BtEf4qN7JYl/UI3dXLeLg3dyNalqGVUnebcrG00aHweZKbR9o3v/Ol72x8ViDvJThTy3hfj246Sm1IOo+ikPBcHuggVtxAn3YyM55y9MTrunN2mYVF4iJORZSo8If7qlX27CzYAU/HuN7J11yU+fUatBkW0/ldtKzgHThXTE4K7WHq5e5IPp/KEuG6HdWDEHYsG+Dyxvp9vG90LWbwrYxlBUgxwJPdyTf1V2DLsvl6qGSP3JGZrTRKGec5qP8ptw4xjwfSy3EGMWxljbI29ZWCNQHxcg1ByVGfTMIZZJSfaVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O62JFJIjn2x8K+xMlnQ6tJXnL8Y/05dLXcClYyxiTkU=;
 b=v+bAA2+emfYLr6urQ8GXrfR4Z52aN1aQn9LqCEbpIjjNXAzJ94A2RAAvfDxHKVOhPrQZEi0aJZh9iqO6vImE0Rj2snyetGgqYjpC5ilwnMjTBiUfPK3O7UDOy/UL7UWRAnGqbyMZlRXBEyBSoyqZs4WseUV9suRcLmKNsNnz0ijp9SzRbJquDzaBMhpXJDmDG92kKabeFxLSLQxv5aB7yNIYgksJJa4wpI0lXRmv4cRbx+HZaBxvjIhaMb5FBkVkydrqpiAXcJ8v8wihctwlUyzbWE2kE1Pxymj3xVk1zYfa5zqFoeSVEit2IMb1dLxdXz+JxQm23GaLg+aksV8WMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB11727.eurprd04.prod.outlook.com (2603:10a6:10:623::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Fri, 27 Feb
 2026 01:25:28 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9632.017; Fri, 27 Feb 2026
 01:25:22 +0000
Date: Fri, 27 Feb 2026 09:27:17 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull fsl-qoriq-next-2026-02-25
Message-ID: <aaDy9Y25SDH+qGtX@shlinux89>
References: <aZ_BtG4flBy7oN-N@nxa18884-linux.ap.freescale.net>
 <20260226162224.GH1593142@bill-the-cat>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226162224.GH1593142@bill-the-cat>
X-ClientProxiedBy: SG2PR03CA0099.apcprd03.prod.outlook.com
 (2603:1096:4:7c::27) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU4PR04MB11727:EE_
X-MS-Office365-Filtering-Correlation-Id: c5ca29c4-6148-46a0-fa7b-08de759f13cb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|376014|366016|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: 6i5MvM8ZIZBupq1bsj4/R0y0CAGC3FN0wgKXFyEZ1Y4CpgJnGCyUooKbjxvXm7/yNiQciIpPsjDTjuZ9rrkqHykMTlVLpZWbWdPbdu0nU1Om4ucwpQ7dUI+RsCVdPpZ+zlf6SO6gERA4Dj3SOoQ4bhkLOQ+GTKm7JZbFIj5KH1i0nvP7Ss9vSQ4mujwagqkCP0G/4ecHX2/SSAQGmMowGWLVR0wqCoYTfyeTg7vABiuXs4WSanUyuirsMepGTbNLNtZUTtA0xgy+SA6OAiPPAvIAUiZm7IrIZt1viNkXP3pwdtVN2wmK5I9RBYv/LfSv8/MDpS1TQ0nUMeoXBR6ZJG3erefIIezzWWD4QLOQke1aJRxixPBgnEVMGMfSY6PLsGLWmWjo3orTiWlHHqYOVoQvZJNbOR2Bn1dGKLMYtpRytU62DsPQ5DZnDmqIUQHlxYLRuUqaXOJJRSoXe7y1PO3BZkD/wCbapQtM0OI5r793WGMFzb/4uqVTpEElN1b4BWYnbQIQ5eXM9vIR7LxJSKQjltJy+VDQyxTWwSCL+yn4ZqKZjY4CUTa39op7ca9AA4A7EOZ3hJn0qiPBuDSgI8RqcgRw/Esq0B9PUCCnJfbICxMzzOA89FCApFgBQX0lfTDaaui4hDkHPj4hv3qMAp+ABDuGWK6mqHESPDd5j9Clk5qSvxe7XTOd9R6vEzMpRC/3e+8gGtgXs1DmWNSzLv3S8Xjuiqjlxa7JY9FYsKNfXDd11Kk72FVhliGSqsra
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x6e5AMiMN61rbixvmyL0y7GI33bZPxqpIF07XjrBA8fgsmr0ZtUwdAM1JJg1?=
 =?us-ascii?Q?Gf+j1zutJZ49PqIWXFIzXdkTGoohG9UIfjhpEGeVg6TGk23Kt2T8+1qYjk2Z?=
 =?us-ascii?Q?PoVnb3eAC86qbMPLUDOYGa8CvlhATbZ4ltxsR/uHyDc8djNsFcuMTwIUux+l?=
 =?us-ascii?Q?vwNJV+5VFN3tEDG+uJvwM++/RlgEV5MLRDPfC5jI1VgBKOsdvd6adrDDnhRX?=
 =?us-ascii?Q?mYXNDt6Tu4QsceOEPJ6n3m3zku2ZiK2B6WPC7Vjol9gfSDtPNPMs+m3y4fLG?=
 =?us-ascii?Q?h3rcZ+7mAgucTrqQDEMbyikjkhTmHopNMb/amO2GW/YYhczwH+KvYKRVAM0g?=
 =?us-ascii?Q?gKOFdrICuovKruTx3m4oSuNpKqS0YkCnd8VCdVpWHeHika4ZWlFXFcYm0vXB?=
 =?us-ascii?Q?NKm/Yw+Vk0Xu1qXOmW2pvTFcqolY5EJNgpTYusKsl4MC0cVb4Ndc8AyDTEQE?=
 =?us-ascii?Q?yDW63dzXykXZbegtn4HJ5CGdWWDbjxYRN3xFkeymd6zkt22WFbNgRdrcABNJ?=
 =?us-ascii?Q?jdV7T+8QbbUV7AgWNf2h2i9m1/cgjn26hNw8Y6VS55m9xau+vujpQwv0OQ/f?=
 =?us-ascii?Q?ZPqwz5zcBnFgbUNVzVMIToOHOrmR8w5pwIwe5Tdoy31HOe0c6zUm813zYoTc?=
 =?us-ascii?Q?zZmigQou1TS12w5B5Q5qkL0pHPvgZ85YGeeT4d+wPwQ7eaMQO+jB0QvxhJxS?=
 =?us-ascii?Q?KDDaA/c34XwXbmQrf7j4NQJiimMPorD8WMsTzn50nWNpgqXdembA+yJMRgBb?=
 =?us-ascii?Q?5XtOUagrKdRpgnBjdicdbj692R0jjb+1zvtVXykeuni3Bchi9Wjsk5mpSy6P?=
 =?us-ascii?Q?b+0YBMIPYjcEMiucROG+wj5Ysj32kcFMzQ7T2kdIwSZGm4lWAZmMZzXDd/Eb?=
 =?us-ascii?Q?5e28rU9HVQBldYF6k1DKBJh82335MZtO513VsKFg8FCQzRZcZFz2reOzSvl+?=
 =?us-ascii?Q?fCXoqfNd+v23Ke/HL2wgyaskCrx5aqRl8q9BX5wSf54+e9/hPhfHJFSs81mY?=
 =?us-ascii?Q?ijuMsu6Xy4p55r4+wdbCoeMSq59pwGjdbQ8ffhwQSGyWGGIMtA0NDQfDWl8d?=
 =?us-ascii?Q?dGv7muAheEsn7YY5OtHhnEYAlWIytRrkmAmhJviDNx9mS8QhQ/BGTzQtKXHl?=
 =?us-ascii?Q?/1rqW3Re/FmlQhYz3ui184gr1/aGXQ0vBxj+a4C04lNy10JbQhve+8MzMjoW?=
 =?us-ascii?Q?YJzCc6+zLiEwFDZ331nytZrdnhSk2dbxaB1EVwVMuNJt8d0Z7fyWDCnY6G8u?=
 =?us-ascii?Q?2rmmY68Ovhz9lPVNfMkqa7MLghtVu+pk9J2D/GgEHBI/CMScvKauqnrHH+qP?=
 =?us-ascii?Q?Zz0sZSrqInnI0sbMRNIw0ys0qExy6z2bXAfqe6K1Ifh4m01/PMVobFC9ck7R?=
 =?us-ascii?Q?nFpXpkwvfpkQwSjb4a3rhjY2oAEmjnmvb0dk/8xOXhRoXaPL6w7/OqNtZbXS?=
 =?us-ascii?Q?la3zAgwMaApO0b04E+t91VW/rCxRlGkUnSuzqeUwfKM36RImFZyRfclwNGMd?=
 =?us-ascii?Q?Tqd6utNE+f8tC/9BBqCKOFD0Agz/DYRU+Jz5EAznYS7Ehpp22F8CyPCV66eT?=
 =?us-ascii?Q?EzDQu0AJlTrTV2um3ps+bsQJno/DtKLJVgEMX2G7d5EgxIPSqhugzeQ9lzVM?=
 =?us-ascii?Q?OL4RAC0Ib8y0TYKCAwP8YP+h/+IQ03PcWw0WXA2uCnxVQHFuFmGvhM8Y0HhL?=
 =?us-ascii?Q?ZoV414aa74PhxM1EzehpFLlfZqjU88nqsxmJ2RI/JQFgpZ9T1hWbUbnA5m9t?=
 =?us-ascii?Q?PEiBB6wfAg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ca29c4-6148-46a0-fa7b-08de759f13cb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 01:25:22.8070 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XHeG5ii+tGvYNxi3ycqIMSzK2h/2iCD4O6Fn/zZH/uD3SVOyGvLUJ+DzqdTtwaCTRx2B4tMFr1o6yBUw9zjmZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11727
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

On Thu, Feb 26, 2026 at 10:22:24AM -0600, Tom Rini wrote:
>On Thu, Feb 26, 2026 at 11:44:52AM +0800, Peng Fan wrote:
>
>> Hi Tom,
>> 
>> Please pull fsl-qoriq-next-2026-02-25
>> 
>> --------------------------------------------
>> For SCMI, Power Domain and IOMMU,
>> validate device tree node before continuing,
>> to avoid boot failure.
>> --------------------------------------------
>> 
>> CI: https://github.com/u-boot/u-boot/pull/874
>
>I rebased this, carefully, to master because we need these fixes for the
>April release. Thanks!

Appreciate your help!

--
Peng

>
>-- 
>Tom


