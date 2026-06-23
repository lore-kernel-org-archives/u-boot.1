Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC1ECD4F26
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 09:25:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3024849C5;
	Tue, 23 Jun 2026 11:25:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="CBazSguZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF899849CE; Tue, 23 Jun 2026 11:25:33 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 511EE849BF
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 11:25:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FdVTKqNe10udEIZnIuogJofr5lBD4rB5oJ+S4ERaVtjUkQYDuEOsk+47463qbr7q4uuyG5pXeU+t6Pt7d0wN3xebkImfW5199rgRmF8Cz/ik4vTLHaavwDp7FdB3DiwP3lB4i791frMWH5e55NPp6wDWjf/s20daY2Co/Mu1sRKvXKeaDtjIVi3khvFEAwOcXPP3E5grSF7lbFhMHLwBAG2nIAp8TYXVMDNcmTzkZsAXjPgDGmE7cJbMe6KysVFiEcQYU+9dy24AojyBqLO89dii05onEw5RhWYdLqMbkvllxBi9SIbwh8tenLdAWjYIUNCL4JeNsHsjSu7fmyuvQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCDlellF1O1o+c33b4fR80n5Akbn2GQEeZ8IXx0ZCEM=;
 b=neUN3oeclryHdZRgcniXChzpxrPa2aEdURLpFviaTp9hlpzqDaVB7K4v8lqk4N0btTtNESnDb245GTFdIL1Uxi97z3stw+p6JeU+emnAR0Hj2p3R4rRgzCnijlRq9fGR5IdqU0sxJEdF1AhTDLkDu4oR92ShBc44GNdT5TpvNikhCiN12L4puVpK7opqkMDz9UfQmMBKBEcyMK877nccwOEQlzXBQdNUoTz/0vUxAXbQGa7lxnftgGI42hHqe+2Ap1bQPsiRmOhCMSYQbMBs66FrEPocjDALCwzwHj+fOe17ww94taYZOHofUxVBR6glXx160LP/UZwLDKDlD4gIvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCDlellF1O1o+c33b4fR80n5Akbn2GQEeZ8IXx0ZCEM=;
 b=CBazSguZNWaV5CVzCZ8RZ2ynCdXdAgw+rph3x1uvOGc4MVV2xNd0G1YQNhToD9m2okMdShG1GuXEs1Bc60QYpSf1NlnMCvXPUOj8g68ZusFcL+kByLcA9NkP5g1Oud2Hsg6E03nFubWCREZbdNnr8ya0EL6O14SHecNHMdpVQEI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DU4PR04MB11847.eurprd04.prod.outlook.com (2603:10a6:10:622::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 09:25:28 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 09:25:28 +0000
Message-ID: <c81e9331-b847-4716-a100-5aa5cd570c45@cherry.de>
Date: Tue, 23 Jun 2026 11:25:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rockchip: rk3568: make the WDT trigger a first global
 reset
To: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
References: <20260619220820.301787-1-andreas.zdziarstek@gmail.com>
 <20260619220820.301787-2-andreas.zdziarstek@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260619220820.301787-2-andreas.zdziarstek@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::28) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DU4PR04MB11847:EE_
X-MS-Office365-Filtering-Correlation-Id: eda1df4a-b706-474a-dd38-08ded1095cc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|18002099003|11063799006|4143699003|6133799003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: sfWMKUgBVqtuIqQW+fc1/BKm6bzLfKVXHeAfbJme9w1zPoYpbx+qNipbmHRzz+XL941MJCZFHFbrwYDdDFsjX8zi9qw6BfQKPlr09suE3jYm6y5hF+5TMd0pTYFqDwN1gyLBNbzwACxWdpEt8BtZgQETEmByu3mVLULewmiWS3nh9hKTKtDTsfIrMW71Ynp6tX+3I+WWW2kYzAeJdukGcLNlRHalftQOYCf11BmyN3cabdygwjbMH24swJ4aDO5SNUCQGVvo2i9/XnXLohCIms5SNQsY5xxnOfKY8BbI1CN13ZKFGM2uzIKLQWA8BGQNePxSl0/d6nRVes302mRbjtFgO29tonvnsGy+GvjIbFCsJGj2YA/wEymhFKfw3SiKuMnqwNL3DxqUDJMDZ0nnr3zwDpJgQoVH/h4yW0mgD/hb5jSF+2wnJwMLSNru7APcjmgo/o6/Ejt1AQajSUffufe382oJLz6HrwVny6bdM/v3RgHhPsEerZ8a7qoY84k56rLvyYX1+OJPOHjiNiYvd4dLOJoiZ7S1ynLDYvK/6/BOVRykF9Ccbz7PjpkHsvwwHdGT9XZUE3lqzFfmMVZuElW4toF/O9s6Ow2a4TTY0qM4KzePWTozs8DuItQ7UeSuEIoNz4AfN4NmlvEx1EKpT+My+CvbcY3JyZGk/1lWtUo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(11063799006)(4143699003)(6133799003)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUx2ZVEzS2dyajZXVUNDYVA3WCtWZmZLSHNlSU4xZnJXRUJnU3dzWHJqMDlE?=
 =?utf-8?B?UkUvUGd5aUVMNE9ZL0RNaUlKY0VNaGZsZWg4RkU5TEkvTkE5QU9VdGw2MG1O?=
 =?utf-8?B?a0k4TUxNQTZmZGRkLzF4OXdFV1ErSEhzakxJSmNzVS8yRitxUEwwODNFSi9H?=
 =?utf-8?B?ekd0Q09yNG91TWlwZjdvWlB3ZXhqaU81TE5mNlJua0RWWDdZeGlkMm9CREN5?=
 =?utf-8?B?eFFGZ09UQnordEpLTGgwWm5hdXFscG8xdjdudGNPV0lIWHZxaFNFbEhDczZZ?=
 =?utf-8?B?d2pVN1hjclBuVGhSeTdZTHBBWElLUVBCUnN5aHc1S1czTk5VYUZUZDd6dDBy?=
 =?utf-8?B?ckgvZnc3RjRwYXJ5ZWNyamEyZksxOGttZ1dFeVMydU5XVno3Zm43alpNczFK?=
 =?utf-8?B?MW8yL1FmMWd4am4wcGxlTVpIWCs4QXJwY0lvc2VxVTBENDhwR0M3WVdYY0dF?=
 =?utf-8?B?MjEzd00vVEpFZUZLTVJscDUzOWt4N2x1c1RvL2RsaW9tNjArdVZlWnNoN2cy?=
 =?utf-8?B?NTdWaWdBOTdWNlBQeisrVnVlbkx3bEZjV0VBc0RXZmZsR1pWNXBDL2Q2S3h6?=
 =?utf-8?B?WnJUSVNKOStoUFJjRVdOTFpKdzF4VDlud2VTNTNmQnU5cHhtNHlFQ3dlZEJC?=
 =?utf-8?B?VStmSitSZE4zb0poR25NYm5aaDZVKzZuN3pLTkFZNUlDb0tyMmVBTG5XZGND?=
 =?utf-8?B?Q1lpK05zUWlTb01yY21qNklneUZuR1BiRlhQU1hMOTVmY1l4MFk5eC9kMDVS?=
 =?utf-8?B?VFIwc3BTRG5vVzdPbjZUZzhmSEdCQ1lmbUdjZmtFekpQRnhjRHNUY2p0ZXRO?=
 =?utf-8?B?bUx6d0I2KzhzZDIvaitTVFJqQ2NBRFZuRWlVS2VFVk1Ucmp5aTR1NmU5S0Nr?=
 =?utf-8?B?S2l4SUJ3TFA0amNuYkRFVmxlR3poSGNmNFd5UnNCWEtNQ0F2Y2h3ZjU5SlNK?=
 =?utf-8?B?WnA1V0s5UnlsMzdHMGJVUVNvUjZMaDQ0MlZudjhaTW56SXF4TjZDRlBNTUFO?=
 =?utf-8?B?S1cxbjZCNjZGM1RVYW4xbm9oZE1yQ0p6eENsM1JscFJlclJIQXZ1RllNZitw?=
 =?utf-8?B?Q1ZkSlZWZm5sTEVzVFNCYWhNMFdHMjNjZzc3NmJyaFdadzRiWUo2RzRESWcz?=
 =?utf-8?B?WldHeVBKUERqV00wYXMyT1g5TGYxTVR2WjJnREd3S3BtanV0N2JIWmJvb1No?=
 =?utf-8?B?cWUyWktKWjVJYTZSS1BYTHlvbjJqNFdWbzZMMVVjRnRKSjN6dHJFeFZhamlG?=
 =?utf-8?B?aExEWWlqc3RyMEVXYU5KaXluNlQ5UFlZY2x6dDJ4VUFGejdqTVh5OUdHYS9M?=
 =?utf-8?B?a2pHVUU4Y0lKU2VONEUrWG40Skd4WnFJSU9mM2xyUVZSYWRZRlMzWktjcGhB?=
 =?utf-8?B?ZXNucjZNQ1MyQnhzazQ3bjQ2TG1kRENkR2JmMEYrN0RjbGUrci9LNDF4S0RT?=
 =?utf-8?B?dTc4Z2NteXViMUdTWEpqWkhhVzhrOWd1NVBTZm9rdlpTOElHN2R3dmlzemJz?=
 =?utf-8?B?a09IWFAxbUpieXgvWHErRTVIdytQQ1poalFtcmlwQnh1U1JRMG4wNTQyRCtv?=
 =?utf-8?B?ZHlEQi84VW8xaTZ1Mjk1WlAybG1PY3p5OWJXYTZyY1lqdHhudkVxYVc1QktW?=
 =?utf-8?B?UmYzaHRPMDRJczlCZ1UzV1lXbytsQjZUckkwT1hmUExJejJ3UURaaWJTWGo2?=
 =?utf-8?B?WG1iWGFOa3NFajNtdWZhb3FnNHI3NFRCcGhqSXpSTXVweDRURWM5WjRrTVpk?=
 =?utf-8?B?L2M4VVhST1Z5cTNQelRLM2RsaDFlNnRGTEpoenY3YzVaam9jZ1Q1OXFrc3lm?=
 =?utf-8?B?RUgzUkhQR3hLM0xMMXlQQzJsRldXMEtjcXlLdkZxNGs1MkF5THg3YXBmVUdu?=
 =?utf-8?B?OHhGbFJOYUJ4S2dhcXc4NU9ScTgvR3JUdmx4MlBta04zTUVmN3c5N1I1R2RP?=
 =?utf-8?B?aE1OcTFEbWpvTUQ4ang1b014Sys1blMzYit1dElEU2lXTkVvV2dzRjBvbW13?=
 =?utf-8?B?MEg4bVRkOFNnRm1jWHRUWG1odXdUeng5alZNL2toVUwwV1kxUzVkdHFLVHkx?=
 =?utf-8?B?SHFpTDdteVpKOE1KVC9EWTg2WEVkS0MxeUt6REZqdzgvTFNNNmgzVU9FZ1FD?=
 =?utf-8?B?Q2ZBZE9HSFc1QTY2WXVmWUErbEFUQVh2dldJUGZ3SUFOUFNCemNUS2xzSFpY?=
 =?utf-8?B?S2NCQmUwd1N5b2wwYnVSQllWZmE1U0FXb0R2cXM4TE43SGtKbUJLRFZ6T0No?=
 =?utf-8?B?di9CNUxqangxSTRXOW5VMk5WMEl6VUZNYUcwOVhMakV3ait6RWpPZWZiMFBM?=
 =?utf-8?B?SzV0SEswSVdxWTJWWmpmdHd1ZG0wTlpzRnkvMnVmaFk2QzhyYzV3QT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: eda1df4a-b706-474a-dd38-08ded1095cc8
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 09:25:27.9116 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 06/UdbGL9ly+vsFt472rnTmyNCUf8NStbFIBEGKTOdhUvw/YVgdVy+LQxofJ0oCZgsihi6uqD8aShpVCcwPepzWsC2XGzxY0BDFaSZzY0xs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11847
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

Hi Andreas,

On 6/20/26 12:08 AM, Andreas Zdziarstek wrote:
> [You don't often get email from andreas.zdziarstek@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Default is a second global reset which causes a system hang on a timeout
> in U-Boot.
> 
> Verified on the Hardkernel ODROID-M1S (RK3566): a watchdog timeout now
> cleanly reboots the board.
> 
> Signed-off-by: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
> ---
>   arch/arm/mach-rockchip/rk3568/rk3568.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/mach-rockchip/rk3568/rk3568.c b/arch/arm/mach-rockchip/rk3568/rk3568.c
> index 2b1eafee37c..77610a6a6ec 100644
> --- a/arch/arm/mach-rockchip/rk3568/rk3568.c
> +++ b/arch/arm/mach-rockchip/rk3568/rk3568.c
> @@ -37,6 +37,10 @@
>   #define CPU_GRF_BASE           0xfdc30000
>   #define GRF_CORE_PVTPLL_CON0   (0x10)
> 
> +#define CRU_BASE               0xfdd20000
> +#define CRU_GLB_RST_CON                (CRU_BASE + 0x0dc)
> +#define WDT_GLB_SRST_CTRL      BIT(1)
> +
>   /* PMU_GRF_GPIO0D_IOMUX_L */
>   enum {
>          GPIO0D1_SHIFT           = 4,
> @@ -146,6 +150,10 @@ int arch_cpu_init(void)
>          writel((PMU_PD_VO_DWN_ENA << 16),
>                 PMU_BASE_ADDR + PMU_PWR_GATE_SFTCON);
>   #endif
> +
> +       /* Make WDT trigger a first global reset */
> +       setbits_le32((void __iomem *)CRU_GLB_RST_CON, WDT_GLB_SRST_CTRL);
> +

You should be able to use:

#define CRU_BASE               0xfdd20000

int arch_cpu_init(void)
{
     static struct rk3568_cru * const cru = (void *)CRU_BASE;
[...]
     setbits_le32(&cru->glb_rst_con, WDT_GLB_SRST_CTRL);
}

and it would match how we did it for PX30. It's not a big deal if we 
keep's in this patch though.

I think we should probably enable the second global reset for TSADC as 
well, like we did on PX30. While we don't have a driver for it in 
U-Boot, we do in the Linux kernel and we don't configure the global 
reset level there I think? So a thermal shutdown would properly also 
reset the whole SoC (or as much as allowed by Rockchip :) ).

What do you think?

Cheers,
Quentin
