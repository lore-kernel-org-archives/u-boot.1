Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA0BC4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 09:16:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 531418771C;
	Thu,  2 Nov 2023 10:16:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NXBFGav7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E4B982BC1; Thu,  2 Nov 2023 10:16:14 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20DDF875A5
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 10:15:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NH+XJlr+Mh9nC6LspD57QlbdtQNqTmlKvBPcdlyQtNFTgu/dgxRhx11LlQgubnyh+lWxrqsFImdZ1NFEuTkNDJbjE3FY9JukFUR9DvtqAiJ5z0GRfL/x5OjUOpyjoI9ciUOUSSfPl+EAt2hmzGm1XcKko/LUfEqkB1rPWeYtdaF4TnSt2vmWACU6HvGeSAq6HouFoKwNKp+6BisBuhlNz3Ca+CuNWg95q+P897iJRMQPD+P9vQUsYxRfBmtyUCmr7HstSbNEb94eKV1Bqk3/zlxOHeNworYHw7a05y/t9hCjJWc/SXtCkIQB5h8yVzDbIBjek2xOa36Oo/eWPFL3oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYivvZUrc6pHYLudG4hsqZAqbosainDTjm45EkaPDb4=;
 b=SHfi1nRKImIQo56GEMOU77EzvK1oUU5umDxaKQtSeTRiC/X7F0L6m80YsvY39bGWWwsiqthyeF7vcjMi9Bk5rdg48HHCp9ojsmBi+nwWJcCPn57XhX23BWnTU1meAbKa0jN7XGrO4LUNSbAbaZc/76n7zaz1IptW5j0vMg4nuN9E6IK1pXzdyMM7mCnM8WBxBpzmyBSfGO/AIHe1He4lebqQ5oXZ1SGTE+CeCHl+yrLNOrPPMbvTTDZYLXuy6C7QluhD+CPDdwIZbqOR/qyRxydV5Y2v8rTf2ru9/dQXZJtOTbTzyx/4wYWVfl2bTrk2zf9YmkZKFAQ16ECHmqA8Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYivvZUrc6pHYLudG4hsqZAqbosainDTjm45EkaPDb4=;
 b=NXBFGav7y/x5s/BTJ/O6ocpZYnER5G7tpgnod9nrtf11xMUNJB5BzbsMFoZPGmEc+7WxLzPsc3y/ijSk7qCZuQewZFL2WxMlbeJebluMIw6n0Y1x2969Z0lNKwxQiOy4x9GQWOPxFjnjx0203yQlkNhnuD7ttIQS0bbJtVHedvo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by SN7PR12MB8001.namprd12.prod.outlook.com (2603:10b6:806:340::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Thu, 2 Nov
 2023 09:15:53 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::4993:59af:a31a:abff]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::4993:59af:a31a:abff%6]) with mapi id 15.20.6933.029; Thu, 2 Nov 2023
 09:15:53 +0000
Message-ID: <b13846bc-10ef-4d40-9444-7ab05a3c8645@amd.com>
Date: Thu, 2 Nov 2023 10:15:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: axi_emac: Use reg property for DMA registers
Content-Language: en-US
To: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20231102082303.354944-1-mchitale@ventanamicro.com>
 <20231102082303.354944-3-mchitale@ventanamicro.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231102082303.354944-3-mchitale@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0111.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::40) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|SN7PR12MB8001:EE_
X-MS-Office365-Filtering-Correlation-Id: 03929ff3-4683-4d24-0d50-08dbdb845056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p7Es9IgB1nB3oKcV0gy3axQik0Xod5ayaOpGTr+57jyE1Spbobr5Fk7O68iJakrKSzmWNHDPuB0cazS9Re2Pal5/W34JmGzFsBcyEf3q4utjKZmOjhNLxLjvpIjJvPNsTMn4O0S/9zRoSxlSX/UXEFNuo7md4CMsI2hGYD3Q92S5DrH0N1nQ3tR0cDLPlk+QOEZXvNQW4cixaRZyNp4IIaa+Ajj28cehOn5NEGhbnXo/bkULMBnLsCfYFgL0VOyUWd1d1sf6W3jISQwSU67+CCQAuQHexF/y8j2Ez2yhRf+T1DoX1h9sSgkPC0ynrAmTh1QI7zkV96JhxqGWvCRruThj+Z4sVFpeBF8qpeuwuFESFZ2F27jKAaGvPk7KZUvaa7oUJyHk+CqBLwFJfNFtQCL7ueoFL705bM3q41K6r8sY1aAm5Pk5GWGjyF60hVIm4rtxCUj8tFXiidQVPHaNIS8gsD4H7DC32jES7/XoBXWNXBaeeqxgnMdlnO5IW6CVAcNyty4MlmreCBmL6qXF2SNK95jVPxKqGygjIPX3qVQLnBFguZ4ETzJAfOfA1Qusy9qbwkvK7wPpPGSsxzndRejtl+JFqJ5vxJM4vdnsIC6AUj2PRZjsg/vWQfuupy2pIeCNAShoYEh0geou2YTMFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(230922051799003)(451199024)(1800799009)(186009)(2616005)(86362001)(26005)(31696002)(5660300002)(8676002)(4326008)(8936002)(110136005)(66946007)(83380400001)(31686004)(66556008)(66476007)(44832011)(54906003)(53546011)(508600001)(38100700002)(36756003)(6486002)(2906002)(6512007)(6666004)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEpCR3JjVEJ3NGdsSk8rRU4xMU16MUlzS01IUjVTbVhVUjBJZ0VWNkdNQTE2?=
 =?utf-8?B?UHpHUDNqUm1JNU5iWGtGSEttcDFwNVM2azM0WmljR3NQVExWUTNwS3ZmYTRM?=
 =?utf-8?B?NmN5RWNCQURkTXhJcHdHSUNRNldLL0cwUCtLNW5hOFR2SUlZS2dpMjdzQVla?=
 =?utf-8?B?c255UVA4Z2swOU1rUGNqcWlGeVZGcDVuUTRUdEdFR3FYaUdjeThjSzZNSmZj?=
 =?utf-8?B?b1EwY1dZVEhQTmFpVmoxaHpUeGFpVFhEMmRvdEdZbUk4bFQ5dCsvQVBhNUU1?=
 =?utf-8?B?b2hpTjdFUE55dk9qU3JoUnE0TGVhQjVKVGJ5c0lBdDVleXRzNFpHQzFsQklz?=
 =?utf-8?B?ZU9JL2VUNndVYzFIbmtmVWxveS9hUVJWa2hoQmNsR3Z0bHJlMlY3dTgwTjRT?=
 =?utf-8?B?bU80ek5aRUpLZkpTcForTFJWQzhuUEpWQ0JQYWh2MXZRcTRpV2orbjFTR2wr?=
 =?utf-8?B?aTJJNHhmM0k1WE9TRGZWT0JTZUNxcksxNGt2Vmx6WEI2WWJmbVRuWnhnM2tC?=
 =?utf-8?B?ZnZqSjdnaUFWTnpPcVVaWURaQ0N1L012VDNtdFh4Z1dpbUdZbmZaTmsrUzRs?=
 =?utf-8?B?c0lZemplVmhyWU9HdXJZeUwyZnkzUUh1Y2UwMzYwbWl5K2x0clZLdW45TjM3?=
 =?utf-8?B?SDU5TW01RDFHcXIyNmpSNTMrRlZZNkgzZURMVFZHMGt0UndwaGk0dkQzdWpV?=
 =?utf-8?B?OTlhUnBodCtURmpuRExxQm4zY0FhTDB5YlUvK2Q0LzBtbDhkRFZjUFlRZEdS?=
 =?utf-8?B?NFRQdC9MdTVGbjlkK3JHUGlUQnhweGZyajMxeUp2S084Vkg3S3hWUHpUdlpO?=
 =?utf-8?B?dVJFbitZK1Eyd1dVSTdqcGVuTmFHTEVwd0daYTJ2VFVUbnFEQmNJY1Y4bEhC?=
 =?utf-8?B?d29HVVpRcXdzUmxFd2swczdOZjFwaFFoMmE0dmRPUWFuTDBINU1UUGVQSVpQ?=
 =?utf-8?B?Q2RWM3pMT1N2TlQvaFY1NmQxSUU0TWR4bEQrTDVUdGJWQmJlZmNUZDU1Q3Vk?=
 =?utf-8?B?UjdSY01GZFZuKzJjelBONUZ1NlNpRDJHaVZsL1Z4OXhGZ2d5ZlgxUE9abFA3?=
 =?utf-8?B?dGVpMVN6MDgyNXJoWTF6Y0JDRVdnTUpxQ3YzS1dEcmJ0eUcvSkhGcVhBYjZn?=
 =?utf-8?B?TTF6WDJ6M25mMTlTVHRtNk55MndPSXNCN3hQejNjaU5QTjR5cngvcENGV21F?=
 =?utf-8?B?dXdxSllhTDhJQ2tzUzM1TWNJamZxdkpnVFR2eExwbWdJdjFXSTZ0QmJRZ1lF?=
 =?utf-8?B?UDJXdlRIWE45NUlmMXc4YWFhSGsrZUY0TUtwK0pibkFydG82cDBNbEdmR3BG?=
 =?utf-8?B?eGZxb2ttTkxhSmQ1R0V3ZjVFN3htRVpMSFZ3K2VwTm1EMjZ6a0dvdDdpT1dR?=
 =?utf-8?B?NEpVSmNZazFUeFdNbEpSTHc5bHdtOW5YWnF5Sk1mSmE2L1NkbFFPOE9Vakl4?=
 =?utf-8?B?VWhmN212MXp3MWh4bFhLdndLM28wQ0t3TDdlaVNUTEhtb00xY293Z1gvdlNi?=
 =?utf-8?B?OWlSTkpWZFA1R090eFFqY1kwWmNxUmxrbTIydjlObkpzckd5SGZCdWFXb1Zv?=
 =?utf-8?B?YlQvaFJNamRxMGNWQ3ZINU1oUnc4VklySVpQUkJNRDZpbDlSN3ltM3VPMVc2?=
 =?utf-8?B?SlhwNnZhclFHUFhJNFVCaEhvTS9tQmUrUnNLcW8xYm1BUU5uRERPcklYZHpn?=
 =?utf-8?B?dzJxUTNxT3RmTm9GczBmc1AyZ0pkQjBsM0l5dHRnd0ZPN0pzd0d4RVRwa3Fh?=
 =?utf-8?B?MVFrZkdkelFNeDhvcVpmajM5VzVvd1Q1cUpZOTRFOE1iYXNwd1NZUWZFd2Fi?=
 =?utf-8?B?LzUrbnhKanFFdUJSdHhhUncwalNZbXRjUTIxNjR3TzlHVkVudmJVWmQ4Q1Iz?=
 =?utf-8?B?V1duVXNnengrdmtKOUxFbUFIaXZOcm5SeWw2b0Y5L3pURlkrWXo3c3VROWxJ?=
 =?utf-8?B?UVJNY0pvb1cya0h0T3pzc1dqVmlYaUIzV2wvV1Yyd01RNlI5ZkJ3cDRHdzZv?=
 =?utf-8?B?dEJMUzg2UFdWVVU5Z2R1eG5jN3lGNWVUY2Jac3dmUFBBMFJXV2pGN1lvRmRB?=
 =?utf-8?B?TFlOdjR1MmZlMS9QY1gwNEdVQkoycmY2ODErZlovYU12eXY5eHZRZ3BlQ3dY?=
 =?utf-8?Q?kimWYZfa5K+R4kDxVKd3JPwuo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03929ff3-4683-4d24-0d50-08dbdb845056
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 09:15:53.5650 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GmpjElkmS8l+85V7YWX95SMJopZ+l5Uwz0ZbKV//JPn78NR+kcdZ4wS/Z8SCjx+x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8001
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



On 11/2/23 09:23, Mayuresh Chitale wrote:
> As per the xlnx,axi-ethernet-1.00.a DT documentation in linux, the AXI
> DMA registers can be obtained via the reg property or via a separate
> node for the axistream DMA controller. Currently only the latter is
> supported, so add support to fetch the DMA controller registers from the
> "reg" property.
> 
> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> ---
>   drivers/net/xilinx_axi_emac.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/xilinx_axi_emac.c b/drivers/net/xilinx_axi_emac.c
> index 54f2232768..ef151ee51b 100644
> --- a/drivers/net/xilinx_axi_emac.c
> +++ b/drivers/net/xilinx_axi_emac.c
> @@ -903,12 +903,11 @@ static int axi_emac_of_to_plat(struct udevice *dev)
>   
>   	ret = dev_read_phandle_with_args(dev, "axistream-connected", NULL, 0, 0,
>   					 &axistream_node);
> -	if (ret) {
> -		printf("%s: axistream is not found\n", __func__);
> -		return -EINVAL;
> -	}
> +	if (!ret)
> +		plat->dmatx = (struct axidma_reg *)ofnode_get_addr(axistream_node.node);
> +	else
> +		plat->dmatx = (struct axidma_reg *)dev_read_addr_index(dev, 1);
>   
> -	plat->dmatx = (struct axidma_reg *)ofnode_get_addr(axistream_node.node);
>   	if (!plat->dmatx) {
>   		printf("%s: axi_dma register space not found\n", __func__);
>   		return -EINVAL;

This looks good to me. Can you please send it separately?
It is really independent of change from other patches.

Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
