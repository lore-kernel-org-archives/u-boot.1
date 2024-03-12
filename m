Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A3E0C54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 15:09:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D24787F43;
	Tue, 12 Mar 2024 16:09:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0f3ga8qj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE09D87F80; Tue, 12 Mar 2024 16:09:28 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B31D5875B9
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 16:09:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xhv9IxEWzZCI8plp84ayeUFJQWBJAH7NKNn2hqPgutM8A901Ytvxtb1Sj6BO2AK2SA1BPAPORfRJRBV7YUyPx/WBUQo0Fnqciy0EMJXDJCFegpar9b5fgcn6QL+2lPNUef8mwLEHU8FShbSlulJlOXv/eff7qmj08mq7Pd1qcDLBV4YnTiK2a3Iz9uRP4YGK0HbOexcb2r0LOeb5aaearLdzTp3ozVkZHetfRCOa/68bc5dHopN6lfpBmzgud12+6bztcWFMcIpf3M8ngOvENqb67k80i+lpelDNQaK9sJJ1r7tS11cq+8n/mi5gGnkqD95XwqSmz8zMmsT8acV/Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2yLrJJf094yhynmeUHBQ21D1jaz5WKL+VhlUsBkCgU=;
 b=NEXFbTUnWAkQRCqWuukXSPlAhlrnagSxfjf2vAiec3jQMYxN9LJdU926NNeiekn+VaDgyP1jOKqISx2S3YUALU4etgDT0nzuC8dwZdNZ0a+VzmdCE6roMe1rlXeH56Vw89P49M4sWAc+upsNFKWPMi6rFOqhu39UXIk/+zYqvxHyaCFnz7/Bl8cdMfaesPLYIkwTgJ72MY8dS19f/DDzkJi+QT+PgXWKLIO9d0vCTGtt29nbwsjd0VN8XXM1rGasb9J8C1vo+pB6nip/no9ktN6iIjZrmyPvlPgcHB0S4HpqvWtoDfHjYupniZcps7gw5W/OTNBiR8B+pKh/MRffFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2yLrJJf094yhynmeUHBQ21D1jaz5WKL+VhlUsBkCgU=;
 b=0f3ga8qjJDAe7XIQ+vgpHga1rsdyTSXp2IaakUIzMPVEyKsMsHr4iBj0K2p1wFL9/7z+/bRhAKIq+xkdt2Ai9i+mMPv1Ou0QO8GfL6HY4z3MkZfsq6Y4mXhU9tGAHfwX/MEu9gf7XwwZYTQEiE9NaMYkQPLOabDKwieikyCRdT4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM4PR12MB7526.namprd12.prod.outlook.com (2603:10b6:8:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 15:09:23 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 15:09:23 +0000
Message-ID: <cd038878-c3f1-436a-8381-aeb9a070bd8d@amd.com>
Date: Tue, 12 Mar 2024 16:09:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: nand: arasan: Fix the crash caused by use after
 free
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 dan.carpenter@linaro.org, git@amd.com
References: <20240306033404.18537-1-venkatesh.abbarapu@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240306033404.18537-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0060.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::49) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM4PR12MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cee957d-effd-4d64-b386-08dc42a66689
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rsti+216KKlaAZ8zhdnvKvVxpS5L5jhcw7mKntMolDLEdlET1KqXIEWKE/AeaUBnxQZnBJELmosb4/NWOLy2/tWxyDEaw2uRsXqKO1rNCVGH0+ku0Xy6WVCmL9ZUSnRz8HnbdCNFRfiGBeEPABiV8cpkJrc1wrwtZJyHYkrOfqL4/FdN9j5iOvb9fROYT25+SLc/+POJKa0ifEhFqv3jNpU1OajzsgEEYnWbr4nGdUJ14IyaXo2ZDlhC4os8PBcT0yvKLyIa7qzIw4tp/BKVJs3Pr9K6LSCbeSorWmrlGG9HMvSo57cBiORL3kgQ6b63l0BT0+yWQhVF5qBzTb08zji+bK/4JRfMit995lEpa1QqL1+uqQZuSIS3TvFhAfxaP6UAekERsV0dFGUrjg5nwSkV0HAVfNfnVlMfHVUOahfItLpopB7W/EssuM2yXy4XcgYr59UlLV6XxLzsMsjem8oL1Mv2UZKIgA8rdFr2eEC2dUNzPuKRalnpZJ+Mx7Y0m1EyRXLtGM/mnIVvRwuHYzZqh+9i1XqO7EeFKsbSZwfze9jjnp1ibwLD+uFORr7NvPbtmRHp+pS+rBE9+e6lC8sagLN/ktayFg7aer2mirTPf5o3PKNBuqy0A0y2PGDaSGPCP9GeRXPbZf+6n8htQcxy/HW1Fmq6bhxBwrW9NyA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVl5VDcrdlNpdVJlaGhhMUNIT09UYjk3UEJ1ZjFudnhRMjNqYTk4UTVHb1l2?=
 =?utf-8?B?aHJOMlVQNWwxOVVyUXloVWtTV0pUc1dtTGRXSUR1VkxnODRDLzdIQ1FXM2di?=
 =?utf-8?B?SlFwcUpmLzNxWlBwRUNpdDB1MW5RSUQyN1JSRFRKNmR0RW83dEdhbGtWbjBv?=
 =?utf-8?B?cTRSV1huNUNBZXlkM0kwT1dmeVJUVFIzZ3dkM25mTXVFOVN2dmVXaUpKS1RW?=
 =?utf-8?B?KzhFbjBYc1BCVXlWSG5yQWI0cmduNnVZQXZpYW52NldnSW9OWGJSUk53OW1X?=
 =?utf-8?B?RWlHUGhVY0VkSTZtMjFnT0Zwei8rd1lQNkxRZXhpS1ZJcGZuTmtBSVRUOFoz?=
 =?utf-8?B?bi8rTjI2eUUrc2VWU2x1SlZFckx2TWFNMkdiaC9aaGxaN2V5OXpQNjJTWFFC?=
 =?utf-8?B?ZTdNM3FxeVhpaTRyME5lclZLN3djS0tNWXd6azFwN00zZ1czeHIxTGVJM01I?=
 =?utf-8?B?SHp4aFFYSHlJOXVSVS9GL0tPeU1DNW5zL25VRVJBUnJIRGZ4Vzhpc0Zxdmcx?=
 =?utf-8?B?M2hXdk9qQnUvbmFZWnZqTk9aS0syVGRaTnJvUUtjN1kxUlJSeGFlZktlOHJE?=
 =?utf-8?B?M3NNcytGQ0JUdktoRU1CbXZ2QVl6R2tIcnZscDMxNGtHMWk5aDMvK0FSVzhU?=
 =?utf-8?B?RDZqd3NOZ0ZFU0lSUVdTeHVPNWxJRzJtUUV3SlFZQWtIenF4d29TUjQ0ZDU5?=
 =?utf-8?B?L2wvb1Y1YnB0RFVocWpqZm5TLzB5emVrNnRpWXdSVVRWK1B5ZWV0RHVEaE5x?=
 =?utf-8?B?NEVtMFhnNWVkYWxwLzlvMFZWYVRJT2gzeUhXdGczdWdaZDQ0MjlPdTQ4aHQ5?=
 =?utf-8?B?VC9QZVREOGlORmdMRDhNaFpBSU5ubUR4Z1R0MEUxVWJGVVBkQWtjZytvUUFv?=
 =?utf-8?B?Ri9KY1VIRWZtcjd1bEk0RVZiWFRNd2srRXpJOUZxZ0hGL3ZlVDQ5RHMxOWN0?=
 =?utf-8?B?L2Jtd3NDbTQ4eFJjdk9mZlFxTEg2dHZmNGl2NWdnT1NsOVpiRFJXOEpwd094?=
 =?utf-8?B?OHBuYS9obWNrcWdqREZtYkxlcHlZT1lFQXJyMWxEV0NRSTJ6R29mNHJmN0Jw?=
 =?utf-8?B?N1QzY3BjS0cvcDBtaVE0UG00Z2w0dXBTemdnZnJKWUhGeE5kWG9qUXF2TWFJ?=
 =?utf-8?B?RTlUS2hHa2dGa094ODNjUzRDQnBhTjZubk9RandIZWdQK2RCQjkvSzg5cFdZ?=
 =?utf-8?B?NGo5VXlPTW03OEIxQ2JaS3dkemkvOVk1UVAwRFZHTlVOVEgxY0pENG1LeDRh?=
 =?utf-8?B?SjJTck9BeWRpZmVyV280b29xUzNOZUd6VXJEbVJxTXNyMFg4YU8rc3I2WlQw?=
 =?utf-8?B?UnBKNy9TSHJvaVBjbHhRSUQ5RFREWlFWRFA2TDEyZi9oM1hEOVZ2WXZvRHZY?=
 =?utf-8?B?M2FvL3ZLbVpBTnp4OWlHL3JjejNqY0t5WE83cWYrdHJ0RUlGajlwZ21iUXJW?=
 =?utf-8?B?cGRORGU3R0o4cnVlZjdLOEM0MnljSW5qWmpoNGhidzdrbFIzN1QwTndqRGFE?=
 =?utf-8?B?MDJPU1l6VE05YlE5SFo4YmEzY1JFWjZURGQzT1Q0czBodS9JVFVXQlRKQldQ?=
 =?utf-8?B?eDJ2VExBTlpzUGFkUUFsV25ycHB2Z1JtOW5ra3gyMzQ2YUZ3ZmZKSUcwa3pU?=
 =?utf-8?B?ZG5pRVd2UjR0SmxSN1RhNklBUjEreTM3L2FFT3dJMGY5MnFhNWVQZWpJbEJ2?=
 =?utf-8?B?dXJ3TkVMZ2lNNG1wZ0N6UG1NYzZuaGFLL3dqVzl3azAwZXZPR0lWNzBTUGJz?=
 =?utf-8?B?S1dVWUFGS2lFTUt0dGc5YWNSaDZnM0t2MmRoOEZNdUxoZjFlQU12TFhSQmgx?=
 =?utf-8?B?eDhiakJJd0QwMDh3MFdxNUt4bTNlTjkvOTYva0VONzRSelc4aXFwdTZ3SlBk?=
 =?utf-8?B?MWEyN2Y4cXU3V0V2Z0puazlpakFCRFk0T29NQ0ZrN3FZS01Pbzg1ZUFvajdZ?=
 =?utf-8?B?MVVpWEtGUFoyeWJuTzNJS1dRbUtoL0NkY2NwMDd2QnZxcmtqVEQwRHpHRnJt?=
 =?utf-8?B?UUhYRTZIRG05cnhmT0RqbGQyWUdmQUd3V1drbjg0SXRZQkg3aXBwciszUmlW?=
 =?utf-8?B?THVoUXk1akN2V2h2cUtKa1lTaXEzRW56cmx2SVBUcTgrSC9xRVlEdWJyaXBn?=
 =?utf-8?Q?jEok7eiH/uvXv7nueE0Gi+U0d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cee957d-effd-4d64-b386-08dc42a66689
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 15:09:23.4439 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6flZZuHjsmiHQl+MiX8AIIwKfSuDS6kfUQbt51BBqGrtNmoyc/YvsM0SMM+2K442
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7526
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



On 3/6/24 04:34, Venkatesh Yadav Abbarapu wrote:
> The below exception observed on QEMU, as it doesn't support
> NAND controller.
> 
> "Synchronous Abort" handler, esr 0x96000005, far 0x17acfc878
> elr: 000000000803ad40 lr : 000000000805f438 (reloc)
> elr: 000000007fcb4d40 lr : 000000007fcd9438
> x0 : 000000007bbfc880 x1 : 00000000ff100000
> x2 : 000000007fcf059c x3 : 000000007bbfc870
> x4 : 000000007fd9a388 x5 : 000000017acfc870
> x6 : 0000000000000000 x7 : 000000007bbfd0e0
> x8 : 0000000000003dd4 x9 : 000000007bbeec0c
> x10: 0000000000000001 x11: 0000000000003f8c
> x12: 000000007bbeecfc x13: 000000007bbeeeb0
> x14: 000000007bbeeeb0 x15: 000000007bbee474
> x16: 000000007fcef18c x17: 0000000000000000
> x18: 000000007bbf9d70 x19: 000000007bbfc888
> x20: 000000007bbfc870 x21: 000000007fd68ddb
> x22: 00000000ffffffed x23: 000000007bbfc878
> x24: 0000000000000000 x25: 0000000000000000
> x26: 0000000000000000 x27: 0000000000000000
> x28: 0000000000000000 x29: 000000007bbeed10
> 
> Code: 927ff8c1 924000c6 8b010065 f9400887 (f94004a2)
> Resetting CPU ...
> 
> The crash is caused by the use after free.
> Updating the correct return codes rather than hardcoding.
> Fixes: 3dd0f8cccd6d ("mtd: nand: Remove hardcoded base address of nand")
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
> Changes in v2:
> - Updated the commit description.
> ---
>   drivers/mtd/nand/raw/arasan_nfc.c | 27 ++++++++++++++-------------
>   1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/arasan_nfc.c b/drivers/mtd/nand/raw/arasan_nfc.c
> index 0b1b91f771..ffcd963b3d 100644
> --- a/drivers/mtd/nand/raw/arasan_nfc.c
> +++ b/drivers/mtd/nand/raw/arasan_nfc.c
> @@ -1232,7 +1232,7 @@ static int arasan_probe(struct udevice *dev)
>   	struct nand_config *nand = &info->config;
>   	struct mtd_info *mtd;
>   	ofnode child;
> -	int err = -1;
> +	int ret;
>   	const char *str;
>   
>   	info->reg = dev_read_addr_ptr(dev);
> @@ -1259,9 +1259,10 @@ static int arasan_probe(struct udevice *dev)
>   	writel(0x0, &info->reg->pgm_reg);
>   
>   	/* first scan to find the device and get the page size */
> -	if (nand_scan_ident(mtd, CONFIG_SYS_NAND_MAX_CHIPS, NULL)) {
> +	ret = nand_scan_ident(mtd, CONFIG_SYS_NAND_MAX_CHIPS, NULL);
> +	if (ret) {
>   		printf("%s: nand_scan_ident failed\n", __func__);
> -		goto fail;
> +		return ret;
>   	}
>   
>   	str = ofnode_read_string(nand_chip->flash_node, "nand-ecc-mode");
> @@ -1289,26 +1290,26 @@ static int arasan_probe(struct udevice *dev)
>   		nand_chip->ecc.bytes = 0;
>   		nand_chip->ecc.layout = &ondie_nand_oob_64;
>   	} else {
> -		if (arasan_nand_ecc_init(mtd)) {
> +		ret = arasan_nand_ecc_init(mtd);
> +		if (ret) {
>   			printf("%s: nand_ecc_init failed\n", __func__);
> -			goto fail;
> +			return ret;
>   		}
>   	}
>   
> -	if (nand_scan_tail(mtd)) {
> +	ret = nand_scan_tail(mtd);
> +	if (ret) {
>   		printf("%s: nand_scan_tail failed\n", __func__);
> -		goto fail;
> +		return ret;
>   	}
>   
> -	if (nand_register(0, mtd)) {
> +	ret = nand_register(0, mtd);
> +	if (ret) {
>   		printf("Nand Register Fail\n");
> -		goto fail;
> +		return ret;
>   	}
>   
> -	return 0;
> -fail:
> -	free(nand);
> -	return err;
> +	return ret;
>   }
>   
>   static const struct udevice_id arasan_nand_dt_ids[] = {

Applied.
M
