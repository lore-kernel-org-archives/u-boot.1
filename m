Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C068EC43458
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 09:52:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5CF8846F8;
	Sun,  5 Jul 2026 11:52:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="CK1Hjebg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15E7D846FD; Sun,  5 Jul 2026 11:52:28 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4DC3846A4
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 11:52:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lmcabbz5VaL1dMB0sNuZQojuOP5LB6Jmo3JX/A4TzloD+eLesHCxsd9SmDIheqGwQCkUuwAMGE6uKItZy1CqGmZninZy5STUw26Y5UhgQCbdUVh/6AlDRZTD3b8UekhlPfo+CGQQdqILiVwa+i3QQXzpYoIO3MQB6JGqqhICH++8Hx0BFRMqg9dnMQ7OUCK/aTarHXhUp/gW5pOYcKoZ2jdXglacGiO82OYAFuaClvOVDZWIfz6O3VuFTfv+HIiAB5Zps3Us5MaNlSfPUdZo2DHlNc0+JNLjQGG28/kQBSkDyNQWe7wub1keACjwf9xcPqaAEIN8UPPYuRRrdNP+jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZtgR1hIRJECBHaj+zeuIpBwC+XJ+r6/mq9DxQNXIuw=;
 b=VGwxdbbm2CfRuQeWinQZVNFoAsr2OyLDrYWHuYZdPKffSwzF7IVRHn6kZqZJ6aQGj5k70ArBpVpQ8pKJnD57Te7ih8EzgjqN9cZ2MHMRUagvvP/dLJG8sNSvPBP2w32unTxZSq+qTmbXlysDh4z3z+JfTrb9JiypcIW6u8iw6NjP9EsnDM66mxMWglcgPRicfTzKlXLETqp+INQ8YqCgef8aFWYe1j7XPzTxdmI/0v6wVV5YWgqygTZc8OID54xiEkjmbZy/iuHJqz4nxf/sCt9J3O3wAoxPEjx8VKyUjVA+SXxWgUFAVKO2XEWp54yaTIIW4DrIBp4pGLBoAp/mwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZtgR1hIRJECBHaj+zeuIpBwC+XJ+r6/mq9DxQNXIuw=;
 b=CK1HjebgD9/sO7HRaVXoRWOHMo9y7SnDAOhstLiq9vs5f6Yk2aXpQMbjWapPd89nAyaZvCzuKYDXUPiyrIquo+Nna8yD/Rg6Sys1CCCidSiRILwbBbJtjp8Dt9dmCyhbXDr5JbX5yPNZx4A2MYapBGj/ZfIxT/jiChi9ng6kRBZDEXYi/apSeIvg+m7+rHT23bbN3aXde6PzWqqNE42aV8Fx+2mwP2VVkIxSMLxwBdt98tB4TZcCiEAmgJl+NPKdWmYNTG+3zYBlbU2ByCLORJj+grJRPt77FP5Twu3GrWZ0IWaxhL7zGoarZe6Uk/dJOj4xijUaXgCGsElbafz40A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SA1PR03MB6324.namprd03.prod.outlook.com (2603:10b6:806:1b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Sun, 5 Jul
 2026 09:52:15 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0181.012; Sun, 5 Jul 2026
 09:52:15 +0000
Message-ID: <52987597-bb11-4193-a28e-223eeab093eb@altera.com>
Date: Sun, 5 Jul 2026 15:21:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/9] mmc: sdhci: enable CMD23 for multi-block transfers
To: Eric Chung <eric.chung@riscstar.com>, u-boot-spacemit@groups.io,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>, Han Xu <han.xu@nxp.com>,
 Yanir Levin <yanir.levin@tandemg.com>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>,
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Angelo Dureghello <angelo@kernel-space.org>, Johan Jonker
 <jbx6244@gmail.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Guodong Xu <guodong.xu@riscstar.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>
References: <20260705-m4-v3-0-5a9bc7f25fc5@riscstar.com>
 <20260705-m4-v3-3-5a9bc7f25fc5@riscstar.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <20260705-m4-v3-3-5a9bc7f25fc5@riscstar.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0107.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d1::10) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SA1PR03MB6324:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aae2787-eefd-458c-1335-08deda7b1565
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|1800799024|366016|4143699003|56012099006|11063799006|6133799003|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: IV1QToDjGyiYIF78xm1EIDBONKlsIYm1ADxPvl+C58/Iao80pIc54hS1uxqwjZUyKfMLPlmTWj1jsW1CloKNevFgTQY5Avw78YHGijnZqUIu1GHpXA5h5oLASOFGpZ09NdHGSFfD4ClvyZS3LmJbEYwMDGeQG+ydeu1c1cYh1zeolfj8Pphx2vEElhoSR7VH3SxGgOYo6ij2Flm5rDJCaIHkhTC6CM4mBYKADTkWllONL64AVJzPAVOrQ1alQv0wVjd9fA1Xjmk/MfGDW4lXMCSLXqeQ1So0MdL6GWN7VvQoGJzTMh8DsvefsJzZIp1RKmm5VDE/C6/OgW4pdZl5c5v3lKS+clrOA/C0CmjDh6Tdsm3GbV/RWNk5kK9SiZucqQsqor0iIXsue3s6H9T9AeOsb40YmGXDwNCABtcq77ZVbRYHqcJqC/95an3Umhhq0jmVjOw3jmMQpSUWciym4NPM3e92+yluzej9GL3HthSe/6Keq6NMgf2qXEoX6z7/Beso2Rd7iBmYpdB24Jm87DSXT9JUcY/LPSg/eGlotvugKKkparNzyjKp9DO5zNveAz0+YNmuXCa9jZBKaSkJFYOtfQZHEEZT+WOQ4gODzk4LNPXQLgLsFnVcxHX2PvAsA5n4mZ956tdfXX3CANGe+PdrDd8IjIa6Prj3XlUYesY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(4143699003)(56012099006)(11063799006)(6133799003)(55112099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1phNUx0RXF1bExQbnhSWUw1bTVUWTZpREYxZjZ1Y1FmSlVqWlE1aWlUeDdH?=
 =?utf-8?B?bG9PSDdzYncrYk5ZcjI4QS9aQWQzbzNuSDJPVFdPQkhWWTg1YmZCcWovdzk0?=
 =?utf-8?B?R0wzelZ0TzRMb2plQVBvZjdqc2szSjJxdGhBb0pSYmVOSDhnMU5MVFltU1VZ?=
 =?utf-8?B?RVpUVGxaRlFjVnQvOCsvczc0N25vNGNFZEJIaGR3dzZqUnV2ZmVhU0I4RjRX?=
 =?utf-8?B?amN2VDVRajNoYk5LMldkR25kSElsU2xwNEFDS3BXZFJ2QnhVeVVlN0ZKTDcy?=
 =?utf-8?B?QjNEY2JxU2N0emlwM0djdzNHc2JrQThNZHYyTm1FYW9GMVJiQTdsZTIzT0wy?=
 =?utf-8?B?SG1WOTExY1FCaE1hcE5MTmtvQ01PMGpGdnV2QmVDQ0RleWdrazZyN1dxQjNa?=
 =?utf-8?B?Z010dFlQeGFCaDlnRG94V0JuODF4SjV0ZHR5NjY0NHZuY0xwKzJ0SE05eVJo?=
 =?utf-8?B?SGo0NnQ2QXpVT0p3REsvdmcybUo2U01xOUwzSExNNm1yRGw3aThjSWlEZERi?=
 =?utf-8?B?a0J5elVZTTlIV0gvbzlMc3V6bzl6UEI1bGExdDVJdTdWK3c5VmtnbmlReHRP?=
 =?utf-8?B?SkJCaXUwZHhTZ3dacHlMVGdpMFFobk9BR284RklhbW5DQXNkbGViRWRzc1Zl?=
 =?utf-8?B?TlVUckJJZXErdjFlZ015d3gzdTJjUEYzWExVOW5HNUM3WkZ4SlJ5OE9scVFK?=
 =?utf-8?B?dm54TzBZL083K1JPM3lyL0RYZDBxZFFGNkpKVFJuUFdVaHhpWlFCcTFyYm8v?=
 =?utf-8?B?OE1sWnBjS25RSzV4bFh0ZjVPRG5nenNUeGFCZkltNDd6Q1QwS3d3QWRLS3dO?=
 =?utf-8?B?OXZiVlBBTHkxeXlCS1hoVVFqRUtsQVdzUlNVT1ozZ2VkQnBmMW4xTDZkaGlI?=
 =?utf-8?B?TFV3enYxNVR6T0RrVHIwNTBnQm16MkY4bG5veUptcmM2TjBmU0dFS3htNnZm?=
 =?utf-8?B?VnBwMnMyVXQvKzZVTVcrc1RQelFUN0Exbm9CQkd0dG5PS3JhSlNUMWg5Z09J?=
 =?utf-8?B?YUtxUFVkOGtMS0FkQUVWZmZLd001V29idjJMNzZOdTRVTWlRUTFXRVJpZDNG?=
 =?utf-8?B?WVVVWlJBM1RUVzNRZklYYTM0WWY1ZWhYV2dnUnJMZlYwK3ZmNGtEQXFUQURt?=
 =?utf-8?B?NkFQSXNRMm5WOTV4aGVGN1dtc1Z0ZHZKWWVvS0FHZ2c0UEdGcDNvd2xDN3pL?=
 =?utf-8?B?ZlFaTmVBVnRzdFJtRCt3MkRBMHl3dlVkY0NmTG5EYm1xSWhINms5ZnBvMUlY?=
 =?utf-8?B?V0hMSklsWlFUWE1GL3hmcmt6NWxDWkpNRTVQWHlKT2FxVXRLRnBXcmNEWmJP?=
 =?utf-8?B?NkM1TjZCWXhzVjVaaVNiTnd5Z0xXald5eHdwVXJkbWhGcDNjSXo3Mjg3ZGZJ?=
 =?utf-8?B?RFAwR2tjQTVjNVFCQ2ZnbCtTbDVORXc2OUJCM3RkTUJ0MVlxVm9wbXFUaG9M?=
 =?utf-8?B?dHZnOFp4dlduc2JpdlM3T05rTVdRdmhHZCtiSlpIOGJGQWtpaXBCWnAxTlhr?=
 =?utf-8?B?Z3RXeVZabGd6dlovSlM4dTNqTnAzNFV0NG05V0dtOG1RaE15VDBXeEZyb3ZV?=
 =?utf-8?B?Q1hyNDhSTlBhM0FyalBTa0pSK2tVN0h2OVlhVm5Lb1hFL1RVTjY1YmRuUzZQ?=
 =?utf-8?B?SUUvRUQ5Z2NlZjdxTUlyWVIrSU9TdU9OOGhEdURWZnJlVXZRRFFUdFhPVW9C?=
 =?utf-8?B?eEZVT0gzNW9SVCtQMGEwQytrYklkMTh3c0IrWXBBK3lBZ2ZIZS9NMG1GbVRr?=
 =?utf-8?B?RE5QRHdQbnNId1BUR3ZibGh5Tzdpd25pRm4ydEtkWjQ1MytURmdNKzJrYjZJ?=
 =?utf-8?B?SWozWmQyRHJBMHBjM1JnZlFMRG5QNEp6UzEzTW1TbkljOU5RSmhaT2gzUjhM?=
 =?utf-8?B?NFhldkxXcDBmMFdOVy90Ny9mZHB5ZDRYWXZoV2RmcmRSTkR6UnR6L25zNHRt?=
 =?utf-8?B?TWEyN1c4VWY0VDBKY1RYL0lkSm5Db0p5ZHQvV0ExcDNmTUNRWnRGa1h4S3Nh?=
 =?utf-8?B?ZktpU0prYjRMcDErc2pPN3Q4K3dVV0V2NWtXTE9rVW9DZHdCbk91cThDeVU5?=
 =?utf-8?B?dUNhK0IyNDAwKzNJQVNBNEtLTHp0TGg5MGprWnU4aUxDLytQbVNEYWkycmhy?=
 =?utf-8?B?a1BUclo0VWdzbmQ5MEdoSWJyKzRVeFJ0SWZDL0x2ZnVYNkRxc2IrdCtxalFP?=
 =?utf-8?B?THRGbVRLazZIbmRCVGFURGNLZU4wajA4VDQrZ2FzQnNoRDVadE9zekdZdGty?=
 =?utf-8?B?TWNsMzFwOGFvYWw2MHFlM3VPcWc1WmR6T25haGVlMk0xTlQ3UnZZR1ZoMEMw?=
 =?utf-8?B?WDZvcTVHaXNGWFdxYTV3QkJ5R0RwVEEyRy9US01nUkt6NUdiTW1jaW1YckRx?=
 =?utf-8?Q?VF2VIO7CSxBbSDsw=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aae2787-eefd-458c-1335-08deda7b1565
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2026 09:52:14.5810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7kam3l2viSHPF6DpqAWgiOG5gOfDRz96ZZCU9B1DCEW7wkKR8c+jzwCdafIpyvNhkE8AdJmmJquPPQ+cTj6WmYf27ylO2fNygudU+QlShzw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6324
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


On 7/5/2026 11:37 AM, Eric Chung wrote:
> Enable the host controller's support for the CMD23 (SET_BLOCK_COUNT)
> command to manage multi-block read/write operations. This allows the
> MMC core to use CMD23 in preference to the legacy CMD18/CMD25 plus
> CMD12 sequence, reducing command overhead and improving I/O
> performance on multi-block transfers.
The commit message claims this enables "host controller" support, but the
changes are entirely in the MMC core (mmc.c) and header. No SDHCI host
driver sets MMC_CAP_CMD23 in this patch. mmc_write_blocks() in
mmc_write.c is not touched. CMD25 still always follows with CMD12.

>
> Signed-off-by: Eric Chung <eric.chung@riscstar.com>
>
> ---
> v3:
> - Avoid to use quirk to enable CMD23. Use capability instead.
> ---
>   drivers/mmc/mmc.c | 18 ++++++++++++++----
>   include/mmc.h     |  6 +++++-
>   2 files changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
> index f0e38efb262..bc8e9ee6d1c 100644
> --- a/drivers/mmc/mmc.c
> +++ b/drivers/mmc/mmc.c
> @@ -461,6 +461,14 @@ static int mmc_read_blocks(struct mmc *mmc, void *dst, lbaint_t start,
>   	struct mmc_cmd cmd;
>   	struct mmc_data data;
>   
> +	if (mmc->host_caps & MMC_CAP_CMD23) {
> +		cmd.cmdidx = MMC_CMD_SET_BLOCK_COUNT;
> +		cmd.cmdarg = blkcnt & 0x0000ffff;
> +		cmd.resp_type = MMC_RSP_R1;
> +		if (mmc_send_cmd(mmc, &cmd, NULL))
> +			return 0;
> +	}
> +

CMD23 is only meaningful before CMD18 (multi-block read). Sending it before
CMD17 (single block, blkcnt == 1) is undefined per the SD spec, which
states: "SET_BLOCK_COUNT - Specify block count for CMD18 and CMD25."

The guard must be:
if (blkcnt > 1 && (mmc->host_caps & MMC_CAP_CMD23)) {

>   	if (blkcnt > 1)
>   		cmd.cmdidx = MMC_CMD_READ_MULTIPLE_BLOCK;
>   	else
> @@ -481,7 +489,7 @@ static int mmc_read_blocks(struct mmc *mmc, void *dst, lbaint_t start,
>   	if (mmc_send_cmd(mmc, &cmd, &data))
>   		return 0;
>   
> -	if (blkcnt > 1) {
> +	if (blkcnt > 1 && !(mmc->host_caps & MMC_CAP_CMD23)) {
>   		if (mmc_send_stop_transmission(mmc, false)) {
>   #if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
>   			log_err("mmc fail to send stop cmd\n");
> @@ -1436,6 +1444,8 @@ static int sd_get_capabilities(struct mmc *mmc)
>   
>   	if (mmc->scr[0] & SD_DATA_4BIT)
>   		mmc->card_caps |= MMC_MODE_4BIT;
> +	if (!(mmc->scr[0] & SD_SCR_CMD23_SUPPORT))
> +		mmc->host_caps &= ~MMC_CAP_CMD23;

Clearing CMD23 capability when the card does not advertise support via
SCR[33] only for SD cards via sd_get_capabilities()but for eMMC the
MMC_CAP_CMD23 flag set by the host driver will remain unconditionally.
Similar handing should be done in mmc_get_capabilities().

>   
>   	/* Version 1.0 doesn't support switching */
>   	if (mmc->version == SD_VERSION_1_0)
> @@ -2963,9 +2973,9 @@ int mmc_get_op_cond(struct mmc *mmc, bool quiet)
>   		return err;
>   
>   #ifdef CONFIG_MMC_QUIRKS
> -	mmc->quirks = MMC_QUIRK_RETRY_SET_BLOCKLEN |
> -		      MMC_QUIRK_RETRY_SEND_CID |
> -		      MMC_QUIRK_RETRY_APP_CMD;
> +	mmc->quirks |= MMC_QUIRK_RETRY_SET_BLOCKLEN |
> +		       MMC_QUIRK_RETRY_SEND_CID |
> +		       MMC_QUIRK_RETRY_APP_CMD;

Unrelated to CMD23 support.
>   #endif
>   
>   	err = mmc_power_cycle(mmc);
> diff --git a/include/mmc.h b/include/mmc.h
> index 9509c9e9543..b663da71019 100644
> --- a/include/mmc.h
> +++ b/include/mmc.h
> @@ -67,6 +67,7 @@ struct bd_info;
>   #define MMC_CAP_NONREMOVABLE	BIT(14)
>   #define MMC_CAP_NEEDS_POLL	BIT(15)
>   #define MMC_CAP_CD_ACTIVE_HIGH  BIT(16)
> +#define MMC_CAP_CMD23		BIT(17)
>   
>   #define MMC_MODE_8BIT		BIT(30)
>   #define MMC_MODE_4BIT		BIT(29)
> @@ -141,6 +142,8 @@ static inline bool mmc_is_tuning_cmd(uint cmdidx)
>   #define SD_HIGHSPEED_BUSY	0x00020000
>   #define SD_HIGHSPEED_SUPPORTED	0x00020000
>   
> +#define SD_SCR_CMD23_SUPPORT	BIT(1)
> +
>   #define UHS_SDR12_BUS_SPEED	0
>   #define HIGH_SPEED_BUS_SPEED	1
>   #define UHS_SDR25_BUS_SPEED	1
> @@ -343,7 +346,8 @@ static inline bool mmc_is_tuning_cmd(uint cmdidx)
>   
>   #define MMC_QUIRK_RETRY_SEND_CID	BIT(0)
>   #define MMC_QUIRK_RETRY_SET_BLOCKLEN	BIT(1)
> -#define MMC_QUIRK_RETRY_APP_CMD	BIT(2)
> +#define MMC_QUIRK_RETRY_APP_CMD		BIT(2)
> +#define MMC_QUIRK_BLK_CMD23		BIT(3)

BLK_CMD23 quirk leftover from the previous patch

Regards,
Tanmay Kathpalia
