Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E91CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 14:47:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15F7385DE0;
	Thu, 12 Oct 2023 16:46:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vvQgsVIB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98DB984003; Thu, 12 Oct 2023 16:46:41 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::610])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4102F86DCE
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 16:46:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ea1wfcN0VswAkrVjs0xD+GZ+iDGiBN5/hxPG4Xca2pITpMWfzDJ8ppl3pTdUB/2TGBw+PJ3bmE5mwp4xXUsl1fl6rKyLHF02nRErtO+bZsqhwUhzUbGJzUG2zeJqCs8ByL3j1LlOe+eFkUZLGERy7PlI0ekkRRWlh4HBwSAN2lIh2Kuzf/omESUnFQvpPnCvZ0Ml4KSb4vPPZHwe5Y+Qvv35oOaIcDNGiiAyOCleVXCfgFgEp0O6z3eLx1ztaMGJq1tvvezY40vzJcksjtHKM3cdKE7fsUiJlf+mvfiRIEw4Rdv35628Rlyyas3YmH3hDNlfTIiL2ERQOsmFyovJ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rlR/16yGc/NIqfMLxJTDVQXrV/Ryc4bOVcJvOH4EFOk=;
 b=gaJ07ZNaPC7nzxk5vMgXYsTDzJTSavLYVjtBq3X07DtuQBpBS2CNdlL45IacyAaENrTUHvfVE6EyHPlwXINp7tp3AzJCdXJDD5eRmFPFmtT2jeiBzzxxVbiDxnO8m3EMefFEYGaxXcLu7+MJcdHtk0ilqrwesAEr9DS9W66MeTu/RJMPGTTq/j/o5oslE1eiA4t3Mp6HCL7YJpKgfwtnnoNgcGhUMbJvP/XtQgoOYTZXtD0n1EJMH/R417i678GDntn1N5NPTFF12Cqe0JhVLbA6orEBHEfclBV968+TNYaXtlloXnU5gW81mYw4nweJElRzFzo5Ib3h+F/k4m2m7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlR/16yGc/NIqfMLxJTDVQXrV/Ryc4bOVcJvOH4EFOk=;
 b=vvQgsVIBoFc9l2vxGzxkxQvorTL293rEpRkFaXCVLUTc7qxVLdHboR8tlC6pYt3t4Lrz75aTqJMiWwWMBcTuwwIPHsgrVNPF9Ctdquja2LQKaneMC2VeMFFR7zoTLNSkvtDJabiS2kCGbi4xWz3/MtxcE1fdVVR1tXKFuXkUBsE=
Received: from DM6PR02CA0157.namprd02.prod.outlook.com (2603:10b6:5:332::24)
 by CY5PR12MB6621.namprd12.prod.outlook.com (2603:10b6:930:43::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 14:46:27 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:5:332:cafe::99) by DM6PR02CA0157.outlook.office365.com
 (2603:10b6:5:332::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.28 via Frontend
 Transport; Thu, 12 Oct 2023 14:46:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 14:46:26 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 09:46:24 -0500
Message-ID: <2d499c70-85be-42fe-8bb6-6fe066de6a05@amd.com>
Date: Thu, 12 Oct 2023 16:46:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: xhci: Workaround to fix the USB halted endpoint
 issues
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 <u-boot@lists.denx.de>
CC: <marex@denx.de>, <git@xilinx.com>
References: <20230912035949.30625-1-venkatesh.abbarapu@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20230912035949.30625-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|CY5PR12MB6621:EE_
X-MS-Office365-Filtering-Correlation-Id: e9b6f9e7-3031-4480-75b6-08dbcb32035b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uek64T1CNQ9gp2Tj57v5EbXNrP9KdFxFZj/IpvYdIxAT2MLINHQdpYQbJQn4A3SFHaUu7nL0h0Rf+hBK15NLqZ1RT1eV73SW7RWbrCTv19AvEvufmZotu1bmNlPPQwkCMqtSwgl+AQCe0mCaoxd0nVMadXgcNBG4N3jVXThrhN9h9D6JkUAJ4uPMCTMCuYhDrfDMyhd47ZqGRGRHwPN7+Ug9m2XCVgoHumjVBrYK/VInx4vWgImRUrpYTx2O895eMJDSckiMXwNL6yP8zjBdggYx8KoF7rrUIAYlqnsO3mgD8DQDD8mvGENufWe62SUPr70BiWQAXB2SUO1hGO7eOZY+Mpyzy2DOcSQ1qfWbSldGxGcxpSvmRboOq+JjmK/WSgH5yZ6QwxQ366nQRXhST1ghruvgyCOx7CYlGYOBErkxG+45V88gYc0eoXnQ8bP/eJN+VXBeE6vnPssZ/RYWmedwh0iRro69R+YdQVWJT1RhVbMSY8uW9X/OrXz0QAoaq6Z3eir/3sXzyU5iO//0eWAxLq9itiBoEU/J+YzB5hFpJl/sDHSwgdbfg1w6h5MEyAssBeBfiy2Z5tAotJDeZudr7xtZye/zgt7vpCdpV6YBQ7hROOq3/Cbhk36I2Zr0vBT/MSK8vScWCwVP+AeiWSCgFAqU6efonn7365+JYe2Z4/AQK2sGPTt2N7gUTfSeVfx4jYj5isoiDd/J3LMMa7LhYylsGESDxUp5vqf5DjB+1iDn+yfqY0v3Cfwh1rWGO9xcjH/oL5lXafTZgqmGFkSym4JKWX28xVLJJAHsr0I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(186009)(1800799009)(82310400011)(451199024)(64100799003)(36840700001)(46966006)(40470700004)(966005)(31696002)(2906002)(40460700003)(478600001)(41300700001)(8676002)(4326008)(8936002)(5660300002)(40480700001)(44832011)(70586007)(54906003)(70206006)(16576012)(110136005)(316002)(36756003)(83380400001)(47076005)(26005)(16526019)(82740400003)(336012)(426003)(31686004)(36860700001)(81166007)(2616005)(86362001)(356005)(53546011)(107886003)(36900700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 14:46:26.7092 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b6f9e7-3031-4480-75b6-08dbcb32035b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6621
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



On 9/12/23 05:59, Venkatesh Yadav Abbarapu wrote:
> The xhci host controller driver trying to queue the URB's and it is
> getting halted at the endpoint, thereby hitting the BUG_ON's.
> Mostly these kind of random issues are seen on faulty boards.
> Removing these BUG_ON's from the U-Boot xhci code, as in Linux kernel
> xhci code BUG_ON/BUG's are removed entirely.
> Please also note, that BUG_ON() is not recommended any more in the Linux
> kernel.
> Similar issue has been observed on TI AM437x board and they created a patch
> in Linux kernel as below
> https://patches.linaro.org/project/linux-usb/patch/1390250711-25840-1-git-send-email-balbi@ti.com/
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   drivers/usb/host/xhci-mem.c  | 17 -----------------
>   drivers/usb/host/xhci-ring.c | 31 +++++++------------------------
>   drivers/usb/host/xhci.c      |  6 ------
>   include/usb/xhci.h           |  2 +-
>   4 files changed, 8 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
> index 72b7530626..0efb4bd7ba 100644
> --- a/drivers/usb/host/xhci-mem.c
> +++ b/drivers/usb/host/xhci-mem.c
> @@ -36,8 +36,6 @@
>    */
>   void xhci_flush_cache(uintptr_t addr, u32 len)
>   {
> -	BUG_ON((void *)addr == NULL || len == 0);
> -
>   	flush_dcache_range(addr & ~(CACHELINE_SIZE - 1),
>   				ALIGN(addr + len, CACHELINE_SIZE));
>   }
> @@ -51,8 +49,6 @@ void xhci_flush_cache(uintptr_t addr, u32 len)
>    */
>   void xhci_inval_cache(uintptr_t addr, u32 len)
>   {
> -	BUG_ON((void *)addr == NULL || len == 0);
> -
>   	invalidate_dcache_range(addr & ~(CACHELINE_SIZE - 1),
>   				ALIGN(addr + len, CACHELINE_SIZE));
>   }
> @@ -84,8 +80,6 @@ static void xhci_ring_free(struct xhci_ctrl *ctrl, struct xhci_ring *ring)
>   	struct xhci_segment *seg;
>   	struct xhci_segment *first_seg;
>   
> -	BUG_ON(!ring);
> -
>   	first_seg = ring->first_seg;
>   	seg = first_seg->next;
>   	while (seg != first_seg) {
> @@ -210,7 +204,6 @@ static void *xhci_malloc(unsigned int size)
>   	size_t cacheline_size = max(XHCI_ALIGNMENT, CACHELINE_SIZE);
>   
>   	ptr = memalign(cacheline_size, ALIGN(size, cacheline_size));
> -	BUG_ON(!ptr);
>   	memset(ptr, '\0', size);
>   
>   	xhci_flush_cache((uintptr_t)ptr, size);
> @@ -291,7 +284,6 @@ static struct xhci_segment *xhci_segment_alloc(struct xhci_ctrl *ctrl)
>   	struct xhci_segment *seg;
>   
>   	seg = malloc(sizeof(struct xhci_segment));
> -	BUG_ON(!seg);
>   
>   	seg->trbs = xhci_malloc(SEGMENT_SIZE);
>   	seg->dma = xhci_dma_map(ctrl, seg->trbs, SEGMENT_SIZE);
> @@ -323,13 +315,11 @@ struct xhci_ring *xhci_ring_alloc(struct xhci_ctrl *ctrl, unsigned int num_segs,
>   	struct xhci_segment *prev;
>   
>   	ring = malloc(sizeof(struct xhci_ring));
> -	BUG_ON(!ring);
>   
>   	if (num_segs == 0)
>   		return ring;
>   
>   	ring->first_seg = xhci_segment_alloc(ctrl);
> -	BUG_ON(!ring->first_seg);
>   
>   	num_segs--;
>   
> @@ -338,7 +328,6 @@ struct xhci_ring *xhci_ring_alloc(struct xhci_ctrl *ctrl, unsigned int num_segs,
>   		struct xhci_segment *next;
>   
>   		next = xhci_segment_alloc(ctrl);
> -		BUG_ON(!next);
>   
>   		xhci_link_segments(ctrl, prev, next, link_trbs);
>   
> @@ -399,7 +388,6 @@ static int xhci_scratchpad_alloc(struct xhci_ctrl *ctrl)
>   			break;
>   		page_size = page_size >> 1;
>   	}
> -	BUG_ON(i == 16);
>   
>   	ctrl->page_size = 1 << (i + 12);
>   	buf = memalign(ctrl->page_size, num_sp * ctrl->page_size);
> @@ -444,9 +432,7 @@ static struct xhci_container_ctx
>   	struct xhci_container_ctx *ctx;
>   
>   	ctx = malloc(sizeof(struct xhci_container_ctx));
> -	BUG_ON(!ctx);
>   
> -	BUG_ON((type != XHCI_CTX_TYPE_DEVICE) && (type != XHCI_CTX_TYPE_INPUT));
>   	ctx->type = type;
>   	ctx->size = (MAX_EP_CTX_NUM + 1) *
>   			CTX_SIZE(xhci_readl(&ctrl->hccr->cr_hccparams));
> @@ -638,7 +624,6 @@ int xhci_mem_init(struct xhci_ctrl *ctrl, struct xhci_hccr *hccr,
>   struct xhci_input_control_ctx
>   		*xhci_get_input_control_ctx(struct xhci_container_ctx *ctx)
>   {
> -	BUG_ON(ctx->type != XHCI_CTX_TYPE_INPUT);
>   	return (struct xhci_input_control_ctx *)ctx->bytes;
>   }
>   
> @@ -760,8 +745,6 @@ void xhci_setup_addressable_virt_dev(struct xhci_ctrl *ctrl,
>   
>   	virt_dev = ctrl->devs[slot_id];
>   
> -	BUG_ON(!virt_dev);
> -
>   	/* Extract the EP0 and Slot Ctrl */
>   	ep0_ctx = xhci_get_ep_ctx(ctrl, virt_dev->in_ctx, 0);
>   	slot_ctx = xhci_get_slot_ctx(ctrl, virt_dev->in_ctx);
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index c8260cbdf9..1bde0b9793 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -244,6 +244,7 @@ static int prepare_ring(struct xhci_ctrl *ctrl, struct xhci_ring *ep_ring,
>   		return -EINVAL;
>   	case EP_STATE_HALTED:
>   		puts("WARN halted endpoint, queueing URB anyway.\n");
> +		return -EPIPE;
>   	case EP_STATE_STOPPED:
>   	case EP_STATE_RUNNING:
>   		debug("EP STATE RUNNING.\n");
> @@ -287,12 +288,15 @@ static int prepare_ring(struct xhci_ctrl *ctrl, struct xhci_ring *ep_ring,
>    * @param cmd		Command type to enqueue
>    * Return: none
>    */
> -void xhci_queue_command(struct xhci_ctrl *ctrl, dma_addr_t addr, u32 slot_id,
> +int xhci_queue_command(struct xhci_ctrl *ctrl, dma_addr_t addr, u32 slot_id,
>   			u32 ep_index, trb_type cmd)
>   {
>   	u32 fields[4];
> +	int ret;
>   
> -	BUG_ON(prepare_ring(ctrl, ctrl->cmd_ring, EP_STATE_RUNNING));
> +	ret = prepare_ring(ctrl, ctrl->cmd_ring, EP_STATE_RUNNING);
> +	if (ret < 0)
> +		return ret;
>   
>   	fields[0] = lower_32_bits(addr);
>   	fields[1] = upper_32_bits(addr);
> @@ -311,6 +315,7 @@ void xhci_queue_command(struct xhci_ctrl *ctrl, dma_addr_t addr, u32 slot_id,
>   
>   	/* Ring the command ring doorbell */
>   	xhci_writel(&ctrl->dba->doorbell[0], DB_VALUE_HOST);
> +	return 0;
>   }
>   
>   /*
> @@ -493,7 +498,6 @@ union xhci_trb *xhci_wait_for_event(struct xhci_ctrl *ctrl, trb_type expected)
>   		return NULL;
>   
>   	printf("XHCI timeout on event type %d... cannot recover.\n", expected);
> -	BUG();

There is compilation warning coming from this.

w+../drivers/usb/host/xhci-ring.c: In function ‘xhci_wait_for_event’:
w+../drivers/usb/host/xhci-ring.c:501:1: warning: control reaches end of 
non-void function [-Wreturn-type]

you should fix it.


diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 1bde0b9793c4..087ef63f86a4 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -498,6 +498,8 @@ union xhci_trb *xhci_wait_for_event(struct xhci_ctrl *ctrl, 
trb_type expected)
                 return NULL;

         printf("XHCI timeout on event type %d... cannot recover.\n", expected);
+
+       return NULL;
  }

Thanks,
Michal

  /*
