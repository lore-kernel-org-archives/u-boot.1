Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F540F9D0CB
	for <u-boot@archiver.kernel.org>; Tue, 14 Apr 2026 12:25:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 819DD841D6;
	Tue, 14 Apr 2026 14:25:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QxVojqxO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91334841D7; Tue, 14 Apr 2026 14:25:47 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 622DF841CD
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 14:25:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EoF+tzoRypzRtCa7Lx5oGtegHQC768z7B2V5BmHlFiA4WMtVcFrjSiP8YuzJefSgZZzVJSGLc5yYpeqgKu6mBbJJ/YqObTCZHck9+NFCNhRS48l+xeSx0dpXHXnju7yUrWY2bX9+LPw4omqzFmz8/pBUbiVzeMmyA7wOOsNkKRtkXYOPTJETHeJPhGBN9YSyEItdDxj2o/GZ8EzwshWu+8YO01Fk0E1QCtbe23d5tUTIh4yPMZZE4RS/LSdhuBZhQMU9/K1cLQKq7NwHW70tMb9jGRWg2YY/Ofvj8+Npf7AThQuds7YXyVna3bdH+gmmVviT/5+RR4kYfeSQqT+PMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22CgciMkwBxpLv3Zg2g9KXwfzdp6cAo6b0jXTv/sr24=;
 b=b7hQQEef1asqltg2g/F9i30WR13m0CFGpEHhmijhsM1JZZxj4gDiK/sVZ8vB4mMYnVP20R5ZB25woPDE6bkQTWGT0GYgqfNi/xh7m39FOs0rf02qFAm4bGYFLM//dmfmlZY+5HGOy8NGCkm5sO4Xjhu6H4R3MJFxeAPfVB1soi1PPMZa2nuZonTFYH+l5oFLd9FgWxExhrwqDaMzkLml2IaCj1jyA0Dmw87yNJomiX+wNSSVQBVwEYvSl+e9eP3tGzd54vNar1OZNtpHdKxzOsWYAb1zIusi8W7tqyI4mxJ6eTmO9G2SzhbHqGragf/mjEWfIUghcr3KOuCd+RssOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22CgciMkwBxpLv3Zg2g9KXwfzdp6cAo6b0jXTv/sr24=;
 b=QxVojqxOlA/9Vid6vQ3xnjC04GI8+eXRcpquz3EusL2h/r7/xqm0yaG0QoYIcMCO0yGvi34/Hga7ZrXvzOeJTL3sCVFc2o/iZe/ZdTXamYHFHIzrBCw5gqacWfPHsfgbCASAjTSUabA8afTaWquW6kzGM32Y5YS3GslLnXhZA3M=
Received: from BL0PR1501CA0015.namprd15.prod.outlook.com
 (2603:10b6:207:17::28) by SJ5PPFA7DBF91DC.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::7c1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Tue, 14 Apr
 2026 12:25:39 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:207:17:cafe::3c) by BL0PR1501CA0015.outlook.office365.com
 (2603:10b6:207:17::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Tue,
 14 Apr 2026 12:25:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 12:25:37 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Apr
 2026 07:25:35 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Apr
 2026 07:25:35 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 14 Apr 2026 07:25:35 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63ECPYe03999771;
 Tue, 14 Apr 2026 07:25:34 -0500
Message-ID: <86387a11-6f9b-4535-962c-150b004f4d20@ti.com>
Date: Tue, 14 Apr 2026 07:25:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: ti: cape_detect: Add overlay name lookup table for
 extension boards
To: Kory Maincent <kory.maincent@bootlin.com>, <u-boot@lists.denx.de>
CC: Bajjuri Praneeth <praneeth@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, Jason Kridner <jkridner@beagleboard.org>,
 <thomas.petazzoni@bootlin.com>, Tom Rini <trini@konsulko.com>, Marian Cingel
 <cingel.marian@gmail.com>
References: <20260414082007.662549-1-kory.maincent@bootlin.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20260414082007.662549-1-kory.maincent@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|SJ5PPFA7DBF91DC:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a7e2c37-c486-4565-db2b-08de9a20ef16
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: sq4MPG6dua+uAMg5uDcjjoYEmvP4iQqseQGqh0xshxbHHH7z/EwFYB4kW/Xk9XHvUCxLROuiWEAlVdjd+2ctOyoCMN+biUXQ8KuREQH079UOEAA9ePqG4GUjWiP/KGq/cETHSQNaptqOYkifAqdHw7CLAlmeYf7NyoWgyimRJbVcp8/7enownpC7VSECeDupu51JnNqS4n521HAdo9JK1jg7P5xSlUY+U68KAPE+4BjWvrzF1RDk6avw3SwfFwAK6vJ+WquG+tfJqXR9YqbZHLhxELYdXUfHpg6BthNNRKirEZwYH89D//u5jNwGLjQ0PyAtqUF5DEfTWTL0zyN5wo0TUGRwqV2MEW7oUKSlpyM3ZeRJiEGM6zZsMSj28+1JyBo7UqwCShUZaX2U+HqZMA+fSJD3opVM/nyloVl+g49L1rVYTmvNTUuARJWKNTXTA9Uo1Ywl3GPeKxpT/nRtzPsnkuMndzqUveHlDWXdbts7q1f07jei6CAyyrpz5L3AmaBzRVaiaSO/y3t+ugbto0m7jrQKE1LQRNl0N4Fx1O5d/97fjeGDomo6Q982W0841LLalzDl6J+BcutZSDNofO+m8StLSVk9rotff5ZW1pWbzmxLqPslUyusWCxhJE/4Y2iEsEncnA+yrRi8au2QshEbRWk9jm7lAzI5lpLxRbQjlVkLhfpRLbZQNbVsdx5JsvN7ZMOzqtYwiabKSyVTEb97fzQT7a6KNgPLUd+s7v8UDE4NSdM3ueLI72TRRoJlI3G5zhq9muAX5y1KIf8eyw==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MAjpk8hZ4HfNYe5MxvGC/rVSpQ3uSGb5KpidnjIgCkY6p+isNgOR0/Yj2qDdMi1rBeCGf1h2/ugjszLj0hxlSckT5Jjyw85sQnhp7HUYW/3B7dqXpyoKzDS3Dcyz3723RTFhrDeP2yiy0Rk2Njz8SIsoX9Ygfq9CGIWK3094T9+UKCqmG8knPyZN4b7XP71VxIDuyLmTFFiNdRWHYRGfa7NXSsGHZlDy1tTQSwnmEGQj8ZC2Cm+NSHKDE68UuhEZb3wJ85DIRr5CqBLA/dQQHyWAjeliqipeF35/cYTAZM/O1vwC/UZXatNKe8llvryjOh/PIPGuCOBXyLJEwOX44nITZggo8NQ27wjhPRJnzIaWZw2p4gew1sXQZ/5/YVhQUdRZyXhIT7Y1W3U7jg7zp1qxs2blptJgIV+IbGSya5/NQyoNXTkytdlik0TjBaCE
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 12:25:37.2955 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a7e2c37-c486-4565-db2b-08de9a20ef16
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFA7DBF91DC
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

On 4/14/26 3:20 AM, Kory Maincent wrote:
> From: "Kory Maincent (TI)" <kory.maincent@bootlin.com>
> 
> Some extension boards have EEPROM part numbers that do not directly match
> their devicetree overlay filenames. Introduce a static name_mapping table
> and a set_cape_overlay() helper that translates the part number and version
> strings read from the EEPROM into the correct overlay filename.
> 
> When no entry matches, fall back to the existing behavior of constructing
> the overlay name as "<part_number>-<version>.dtbo" directly from the
> EEPROM content.
> 
> Add an initial entry mapping BB-GREEN-HDMI revision 00A0 to
> am335x-bone-hdmi-00a0.dtbo.
> 
> Signed-off-by: Kory Maincent (TI) <kory.maincent@bootlin.com>
> ---
>   board/ti/common/cape_detect.c | 42 +++++++++++++++++++++++++++++++++--
>   1 file changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/board/ti/common/cape_detect.c b/board/ti/common/cape_detect.c
> index 88fa6ae81f0..c9555779c0c 100644
> --- a/board/ti/common/cape_detect.c
> +++ b/board/ti/common/cape_detect.c
> @@ -13,6 +13,44 @@
>   
>   #include "cape_detect.h"
>   
> +struct name_mapping {
> +	char part_number[17];
> +	char version[5];
> +	char overlay[64];
> +};
> +
> +static struct name_mapping extension_mapping[] = {
> +	{
> +		"BB-GREEN-HDMI",
> +		"00A0",
> +		"am335x-bone-hdmi-00a0.dtbo",
> +	},
> +	{ /* sentinel */ }
> +};
> +
> +void set_cape_overlay(char *overlay, char *part_number, char *version)
> +{
> +	struct name_mapping *mapping;
> +
> +	for (mapping = extension_mapping; mapping->part_number[0] != 0;
> +	     mapping++) {

Does ARRAY_SIZE() make this any cleaner than a null-terminated array? Or
do you plan to generalize this in some way more?

Either way, the concept looks good to me.

Andrew

> +		if (strncmp(mapping->part_number, part_number,
> +			    sizeof(mapping->part_number)))
> +			continue;
> +
> +		if (strncmp(mapping->version, version,
> +			    sizeof(mapping->version)))
> +			continue;
> +
> +		strlcpy(overlay, mapping->overlay, sizeof(mapping->overlay));
> +		return;
> +	}
> +
> +	/* Use default name extracted from the EEPROM */
> +	snprintf(overlay, sizeof(mapping->overlay), "%s-%s.dtbo",
> +		 part_number, version);
> +}
> +
>   static void sanitize_field(char *text, size_t size)
>   {
>   	char *c = NULL;
> @@ -82,8 +120,8 @@ static int ti_extension_board_scan(struct udevice *dev,
>   
>   		printf("BeagleBone Cape: %s (0x%x)\n", eeprom_header.board_name, addr);
>   
> -		snprintf(cape.overlay, sizeof(cape.overlay), "%s-%s.dtbo",
> -			 process_cape_part_number, process_cape_version);
> +		set_cape_overlay(cape.overlay, process_cape_part_number,
> +				 process_cape_version);
>   		strlcpy(cape.name, eeprom_header.board_name,
>   			sizeof(eeprom_header.board_name));
>   		strlcpy(cape.version, process_cape_version,

