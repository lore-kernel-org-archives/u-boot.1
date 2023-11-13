Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC33C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 09:11:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62B8B86FB6;
	Mon, 13 Nov 2023 10:11:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G3GO/Wr7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 921628701B; Mon, 13 Nov 2023 10:11:03 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::610])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5937A86FB6
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 10:11:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkbv8AZvPx5RhkQqpFkBS1j2fmIwldQ/Osxi2+E9XkNdYqZmszqOAQG9kQBR1Xp4CESrQrsE1/Rsm/zEpYRMmeC5dSCKYQfur/ae1bYUlrIiGZXhKF0vkR6JScqhZAoaN4iTaMKBNlJMrDH84bLs2akBXOBANIEzAtem8Vx469Q4zqJr0RFzVnBoq7pjTp9Xw32Zw/GEdTQTUPgJxOdnhMrxCGaHuuPvQzJ1A/8dIRmoEIebwOyLkTw5WJR1S3tRpw/s2+N7LzhQz6oK1JbUgEgyCStF/h5qsn2CYfuZnkm+Z1mBIQoZwQPrFcSC2SBDQpJu59zGk3TYSxYtOS+REw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZ5m0NM3v6UKEjYe7thHv/6wGNt5XY1AaQDmVU5w5nM=;
 b=Gj1IdwJIEDDA+r37Bm2hDZlS6oF0aejgggUIji7ANO0yvjFDAyVp+ssC2lowP9LyxjUpPkTdsdZsyQPoSZuBRVSgzEqpJHCbAgZvdnmh6IYWPY5XO61hxHUD3gwyXqWtd0ynq3mHrxmpXUGttKa/czqpcQfgtB/O462Oy8z01cdrGiBrKoSs1cEYakS6BHFYQEtjMKfPGK3dbuYmfXAWUjT8iquDqnqVGj/hUCVAqDbVqkUdG3rpSo6EGNpoux5atvkQbrGBZ5QJhd28jlCsdNUsYFnc8TvMyYB09gG99QChK/xc+LBeQaQ5e5Hz1DxWgW5pJNZ6esgRBvU/9pHOvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZ5m0NM3v6UKEjYe7thHv/6wGNt5XY1AaQDmVU5w5nM=;
 b=G3GO/Wr7mtgmObp7xigFZOofaGnzLBe77751W94mD+WES/QVsyhq9/lT5YO2DAQQMfQPdth6zkO3UKKBXtq2aIZYQ7I2mEVS9MvtkQvXSholfhByBIoWe5B8w8krvZUlkWgwHRUFWk3X8HV18B7h0IeQXhNer2kpk0LpU9W0tm0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by SJ2PR12MB8955.namprd12.prod.outlook.com (2603:10b6:a03:542::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 09:10:57 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%4]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 09:10:57 +0000
Message-ID: <44fc3e3d-a2b6-4e71-8c95-d50ca7c45bcc@amd.com>
Date: Mon, 13 Nov 2023 10:10:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: axi_emac: Use reg property for DMA registers
Content-Language: en-US
To: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20231111173604.93103-1-mchitale@ventanamicro.com>
 <20231111173604.93103-2-mchitale@ventanamicro.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231111173604.93103-2-mchitale@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0059.eurprd04.prod.outlook.com
 (2603:10a6:802:2::30) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|SJ2PR12MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: abf0e5ee-39e3-4516-a861-08dbe4287231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RqaU+Wp60lD/PMf0NOFPpnvfRqfoMn6s0UcJg9UxednZ6eTxeXkt9Sl++5fjrNph0jp25pNhRc8ghK8cKhJyR+QXlZZFfr/PPAKTE4WA52cyzeQstT+qPPHdcGMWFuRntUi9J1fZ8q51lWWwwlfbn/og/XIKfxbOHgqH6POVT6LnPfNnRXWquC/x4tEEo/hSQL6uMpqwS4D0HY6RKvYf4h1DfziIV+e1IP86f538UC08BmP7ZyN5rPVI3pK++TyfO06znkatDWbTdRU9ASZnpDyWxJ6+b5BxY55w7vqBlkvvOOI0BjSR1xBsfPiGNFsnGojEuWhVNd9kMMKoC7Lvqq7cbDzCOJqvUbjdHfOgQxRlZ6JdabbqvA898YEJG4WQeDvihrQssqnCUmA4Fnfg07+Qpfiayin2EnHnU2LCdrrsOpATAsC2QoO7Z6Sce8R1Hacr6FfE4X2k2PbAMpjtw35vh7RW//4lXFrzFZknVfVYrMk91XgifK420wHiwpzS1r8EJqJuIrmjKUAXghnSjSDv74jC4foteHBJysHO3g/H8r9xyqWPrjUjOt2zKWe7H1+utUO0jP0NHEyElqTAGLXEbPfrL1r+mYl5RrWYL/5y8UYSUavXhsz0loOH4pKi5ETOPX3UbSN8c6SsCyummQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(2906002)(44832011)(2616005)(5660300002)(86362001)(31696002)(41300700001)(26005)(110136005)(54906003)(66556008)(66946007)(66476007)(6512007)(316002)(83380400001)(38100700002)(31686004)(478600001)(6486002)(36756003)(53546011)(6506007)(6666004)(8676002)(4326008)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzFmajh2eW5tNWEvQ0lLRkR3QmI4ZEQxUnJTdTlhTHdJNG9RMFRtRGF2cDVw?=
 =?utf-8?B?aGpJWHYxNGRTNUlWZHVEUE4wdHBNdVBMWnRJK0pmZVpxb2tVa0xGUWpzUC9u?=
 =?utf-8?B?ZXNRbU03WjFhd0E1TnZmT29VeVBYK0ZSVGp4cDBhbmZUVkQrQmtGU2M0SENO?=
 =?utf-8?B?a0ZRTUJkcU5zWk1nK3AvS1o4bnpSMk5ubU0zS3hYblhOMXpMRVZpellDbFlX?=
 =?utf-8?B?Y1FjNnFObjVsakNKODI4YkVPTHlRWXJDVis1UzQyM3Q5QzNqYkdWUWJ2KzRr?=
 =?utf-8?B?ajN6YzZ1WmVaS0tjMEs2akVyUDhZenVQRng4RHJOZmNQVEc2ZVpsN05ZY0lm?=
 =?utf-8?B?WkMxMGEwNUZSUVhyZWM4ZmNtNFpBQjVLRkI5R1JURGhLUWFxa2VPU2JaeEw1?=
 =?utf-8?B?anZKN2N6QUVCTUVSV3hkZmJrWnJIdkdGRGxuVEQycG5ZaS9tb3l1NE15UEh5?=
 =?utf-8?B?aEkxclB3Y3RnNE95dG0xK29VWXUydDRndUdjd3I5RmJwbFM0R2tiMW1taDIr?=
 =?utf-8?B?aW9QeWJ5RzBCY2JhMzVKbjdXU0lNM2ZqT0N6N0FaZHkxZzdiajBBNDhva05M?=
 =?utf-8?B?alQ5SkUxNmZ4SC8xTk8rV1JUTXlLT1RoQVdNd3lIdWNmRnVqN0tzMjEvRG9i?=
 =?utf-8?B?b050blVDK0FJY3o4THBsWDJwZlVSdU1xajdhQngwVHJ5K29XL3ZDVmJmSk03?=
 =?utf-8?B?bkdEMXp3L0VaRTlYSkR1VkJ2dEVNem9BUDdpR3pNcHVmOXo3YXQxbk1sbEhW?=
 =?utf-8?B?ajc2VDVpY0VSZzdrWVR6YmZPdnk5Mm9KNHFVL3BWZC82VlFmYU5aZkZyekE0?=
 =?utf-8?B?aEpEM0l2MDNWTDZmSDlTRk9LYTFNbXNabWNWdy9rdXI5ZXlXd1VmaFpiWnVq?=
 =?utf-8?B?RzNMbVpXRW45dFF3RXhMbU9zbkhWT3p0REVlUk1sQWh3UmRmMm1GSEd4N2Y1?=
 =?utf-8?B?SUt0ekQ1Y2sybGwyZ1MzWC81NG56a0dxMGdSMVI1RU8wM0dSSHFReDJDUXd0?=
 =?utf-8?B?OFRCbnVrdHpsd2NCTk1jdVdJeklUVXFSTloxdHdKTjgvREJ6N2Q4Q04zREs4?=
 =?utf-8?B?YWszTlh2YnBJMGJMcXFPcFVXNlZXWDV4ZFRtQmNpWlJUSks0RVBMY1RPWWlO?=
 =?utf-8?B?QXl5VDNUMThxUlVyaWttcDlQTUs5bEdFV1VjMllYa1d5V2wvMis0a2FMSWxU?=
 =?utf-8?B?c3RGOVQ4emN4bytWVHVLK0VSek92VTFjUXA5ZXEycnFtUCtxTFlyWTV5Tndz?=
 =?utf-8?B?QmpyaFB2OXQ3bWo0eVNITE1EWE0rM09WcGZHd0ZOSTdkek96cy9rLzBoOWts?=
 =?utf-8?B?OUF0amRUY21zT1Vhb0IyMERkTUVrOHN5cldna3FRbkpLWUlLT0wxMDF0eWJC?=
 =?utf-8?B?TytDNlRMbHJNZ3BYaStBYzFLbFRzSFJQVWxEazlMZ2lwM09XSkFZazB6azgw?=
 =?utf-8?B?eDdtN1Zld1Aza1FnbkhrQVl2Z080N3NjKzZmajdZQkJNelF2UWVxZHduZ1hw?=
 =?utf-8?B?a1dtUEdJRDR3cGdyeWdoVDh5cnRvam9TVWxQK21YSFNpQTVYQUU1SXhoM2Zn?=
 =?utf-8?B?VUFGaHFSbXJKTHdSUXdSYWthYlVuMGVBanRwanhGYzdLVk9NWGJiQnR3NmtY?=
 =?utf-8?B?SUlWNndyWU4xNEdLTTN4dGZoa3Bjd2pTUlVUVEdiMlR4RVFHS2U1TURHcWpv?=
 =?utf-8?B?YTQrVWJXczI5MERpc2kwRmFYWWs4b3R4Ukg4cS83TDdBamU4SE1na3llalIr?=
 =?utf-8?B?bVBmb0NBY3FHY3hZTFdjK01XbC9idFgzclZyamJaaXRvbFBZOEFoTEVxajZQ?=
 =?utf-8?B?VE1BalozQzUxL1hVMVVRK0RzcXhFL3VHRnY4cnEzREtxYmo4NGladlVDaCtC?=
 =?utf-8?B?Zm9LUEdWV1B4cjF5ZHhxS3gzZ3Z3TUJUTFhMdGV3S0s1WlFZU0ZjRXlacm9j?=
 =?utf-8?B?ck9TOHhXb1hZTkd2dngwaGQxUGgzbDVxQ3dpNE1JKzJDTnJZb0VQTkxMOTZK?=
 =?utf-8?B?QmNOTlFFV3lPSEdpb1Z5anFSSG93MzRGN1lkVkE2TEoxMUh4cXluN0F6cTJJ?=
 =?utf-8?B?R0NiQyt6TVRQU05BZWJRZEF2bjdvQ3hsamtxdCtIbzRFRTNHeGlWR2tQQmhC?=
 =?utf-8?Q?wfx9HRO9i9YFTDU9ha475C7wG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abf0e5ee-39e3-4516-a861-08dbe4287231
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 09:10:57.1416 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vG8tEgIbF5j4cBxJ0Bq2p9mY6Gcw3Ntonet/+q2sID9nNV1tvzfj+xl45389XEel
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8955
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



On 11/11/23 18:36, Mayuresh Chitale wrote:
> As per the xlnx,axi-ethernet-1.00.a DT documentation in linux, the AXI
> DMA registers can be obtained via the reg property or via a separate
> node for the axistream DMA controller. Currently only the latter is
> supported, so add support to fetch the DMA controller registers from the
> "reg" property.
> 
> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> Reviewed-by: Michal Simek <michal.simek@amd.com>
> ---
> Changes in v2:
> ====
> Add Reviewed-by Tag.
> 
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


This is the part of pcie series but it has nothing to do with it. Can you please 
send it separately?

M
