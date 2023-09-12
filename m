Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD278CA0ECA
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 11:24:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AAC086E66;
	Tue, 12 Sep 2023 13:24:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iJXhmOq8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBEFC86CDA; Tue, 12 Sep 2023 06:00:21 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::61d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69AEA86E15
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 06:00:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJiOyTakkQ5Rw4L8RW1Ytfy+d0deS61racaEv8irK7RjO7m6oIyw0NHhgdXQ9lYxEac8LYooHHqHq9RYzAL0FxmUhDM7QLQSvadjFo5xwGk65AiYdXT+Ka0sJ1vHMMRc9g4XTMx/8COmwECecCklDd0CE2mYz0A7vMe0RsJ/BqEXGNH2WOnQ4NvNEPfFeHjeWIqZXFEbI6WGynSp9Hxs2w0WHc5oiJVvAKoWfrh1XOIzbYA7e3muk9Y2FTRvQZWad+WgiLYmoeB9+ebiGcjk1oa5vStuMWOjvm4IWfEofdGCqcKOzgn413EPjSk36la3d0XJVq/2o2civx7DyVpi0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8eswTLFGjB3n5Kpx4HvE+XCEI9roG6murzjOzOsOCS8=;
 b=Bb0DAR4ZLOuUpFOw+rj3vdjEZTebL+5FGEqHGu/C/XFQf9zM5RP7kOd2E4AW64MRlnoSpMMbxXtQYDAi0Xq6vnJS94HwrNqGFydfOOAVt0G14AyK+ZfIVGV7HPcgG+Tnf6VnbJkRWhWKKBdBNUpbGvZfwtRvIhiVcR00hgQJQPwkPxr276CjQ9pHYhl+8ICJA4ahNAcv4mWIQmFwahoDvesRFDJLBZmSgCaNr4j7682vStCNhzAmgkWtHqtVwOpah5GpkHsX4dvEblqhEwAnFLtODPHR5z6xeecNu3rUGSs1IHlivtgDA3l3kmm3gewdHiEmKCQGt7HbxK7JX3agJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eswTLFGjB3n5Kpx4HvE+XCEI9roG6murzjOzOsOCS8=;
 b=iJXhmOq8+Q3tSKjrw3Cx0VRIMnSn1Crhm6bAE5AiOZJ+UiPkQMylyIooMojw/y7GVp8FdJDnwAbaXMDT4die6Wrm4mBj24frX1jOLYoCmHoEx7NuXAUnZi8mEzd8bcodxmGce+8EIWjL0gnJinJ3d9mZcpPkHOTTbs2NbCLP+2o=
Received: from SJ0PR13CA0031.namprd13.prod.outlook.com (2603:10b6:a03:2c2::6)
 by LV2PR12MB5989.namprd12.prod.outlook.com (2603:10b6:408:171::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 04:00:08 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::6) by SJ0PR13CA0031.outlook.office365.com
 (2603:10b6:a03:2c2::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.17 via Frontend
 Transport; Tue, 12 Sep 2023 04:00:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.17 via Frontend Transport; Tue, 12 Sep 2023 04:00:07 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 23:00:02 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 20:59:57 -0700
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Mon, 11 Sep 2023 22:59:56 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <git@xilinx.com>
Subject: [PATCH] usb: xhci: Workaround to fix the USB halted endpoint issues
Date: Tue, 12 Sep 2023 09:29:49 +0530
Message-ID: <20230912035949.30625-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|LV2PR12MB5989:EE_
X-MS-Office365-Filtering-Correlation-Id: 094669dd-7fe0-4390-a09a-08dbb344c0c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QSfBG1TCqNYnnnePL91F3xas20rE2IEhRoJ/L8v7juDoGfmnvB9i2dnNwcjvLB2OIB3gFEXGaW1HodvVFuc0hlE9oJlfFedLVVtGC3JZA5X4OqrkwybvZ0x8DVZYguEdM5DtIn0+Uv0e79WeHoqZp8EFJbbQ2cbuL3SNYJn3xKRPXa7VA1r3yOuqNML0b/fe3S0xyRGc5sc2zBFv6cUugr3LVwLUFYqU49E6/dw9E0qlsCe1mAKAm90V/sWg9AyZ8/w7lHi3kBgfZYw2oH6zGMFrEVyasCgemYiPc2ntyDvw5vLVGC6IhEkcQK9bp+ZS9cdBQfTfIe+SPLbZ19rg2fGsdtetH3+5wDul84IfcvOePnxOscg8GLVB2TCPRLXy/7zmsEclPz93faXskWjzkSfwSp24LkwODnHJVvioGnvs3fdetoIgIutIIGJ8Ze7Wu+xUC8SSFlfUziDhEkEe/8oetQYUhrgk3W83ClsoL6lhnRY1OaHIYAFcsVzhGREI+FUJJePvGKV/BniHT56gkM7BON7G2DmUqnqzUWLxS/DLds0Uclml7eM/3g9L4hJxDr+VCHI38aEM5S7j54SAAVLFdCI7JqN2Gh+ml/ysf21Bq1tqKDCE7pJ6jeVVwv3QZ7EDo361euAJdn7Xvmo8FziNQoABCmolpmAnJi2zEx4cWWsZrLDc4VwX2DrimxITpOoH70f0rnNgFPhrpKSrXorWOgcZp/X/toJ+9MhVXyp5JoKdyYstuBosH9e7kDjF
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(82310400011)(186009)(451199024)(1800799009)(36840700001)(46966006)(40470700004)(356005)(41300700001)(6666004)(478600001)(966005)(83380400001)(1076003)(336012)(2616005)(426003)(30864003)(2906002)(6916009)(5660300002)(54906003)(70586007)(316002)(70206006)(8936002)(26005)(107886003)(8676002)(4326008)(40460700003)(36756003)(86362001)(40480700001)(47076005)(82740400003)(36860700001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 04:00:07.4885 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 094669dd-7fe0-4390-a09a-08dbb344c0c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5989
X-Mailman-Approved-At: Tue, 12 Sep 2023 13:24:28 +0200
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

The xhci host controller driver trying to queue the URB's and it is
getting halted at the endpoint, thereby hitting the BUG_ON's.
Mostly these kind of random issues are seen on faulty boards.
Removing these BUG_ON's from the U-Boot xhci code, as in Linux kernel
xhci code BUG_ON/BUG's are removed entirely.
Please also note, that BUG_ON() is not recommended any more in the Linux
kernel.
Similar issue has been observed on TI AM437x board and they created a patch
in Linux kernel as below
https://patches.linaro.org/project/linux-usb/patch/1390250711-25840-1-git-send-email-balbi@ti.com/

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/usb/host/xhci-mem.c  | 17 -----------------
 drivers/usb/host/xhci-ring.c | 31 +++++++------------------------
 drivers/usb/host/xhci.c      |  6 ------
 include/usb/xhci.h           |  2 +-
 4 files changed, 8 insertions(+), 48 deletions(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 72b7530626..0efb4bd7ba 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -36,8 +36,6 @@
  */
 void xhci_flush_cache(uintptr_t addr, u32 len)
 {
-	BUG_ON((void *)addr == NULL || len == 0);
-
 	flush_dcache_range(addr & ~(CACHELINE_SIZE - 1),
 				ALIGN(addr + len, CACHELINE_SIZE));
 }
@@ -51,8 +49,6 @@ void xhci_flush_cache(uintptr_t addr, u32 len)
  */
 void xhci_inval_cache(uintptr_t addr, u32 len)
 {
-	BUG_ON((void *)addr == NULL || len == 0);
-
 	invalidate_dcache_range(addr & ~(CACHELINE_SIZE - 1),
 				ALIGN(addr + len, CACHELINE_SIZE));
 }
@@ -84,8 +80,6 @@ static void xhci_ring_free(struct xhci_ctrl *ctrl, struct xhci_ring *ring)
 	struct xhci_segment *seg;
 	struct xhci_segment *first_seg;
 
-	BUG_ON(!ring);
-
 	first_seg = ring->first_seg;
 	seg = first_seg->next;
 	while (seg != first_seg) {
@@ -210,7 +204,6 @@ static void *xhci_malloc(unsigned int size)
 	size_t cacheline_size = max(XHCI_ALIGNMENT, CACHELINE_SIZE);
 
 	ptr = memalign(cacheline_size, ALIGN(size, cacheline_size));
-	BUG_ON(!ptr);
 	memset(ptr, '\0', size);
 
 	xhci_flush_cache((uintptr_t)ptr, size);
@@ -291,7 +284,6 @@ static struct xhci_segment *xhci_segment_alloc(struct xhci_ctrl *ctrl)
 	struct xhci_segment *seg;
 
 	seg = malloc(sizeof(struct xhci_segment));
-	BUG_ON(!seg);
 
 	seg->trbs = xhci_malloc(SEGMENT_SIZE);
 	seg->dma = xhci_dma_map(ctrl, seg->trbs, SEGMENT_SIZE);
@@ -323,13 +315,11 @@ struct xhci_ring *xhci_ring_alloc(struct xhci_ctrl *ctrl, unsigned int num_segs,
 	struct xhci_segment *prev;
 
 	ring = malloc(sizeof(struct xhci_ring));
-	BUG_ON(!ring);
 
 	if (num_segs == 0)
 		return ring;
 
 	ring->first_seg = xhci_segment_alloc(ctrl);
-	BUG_ON(!ring->first_seg);
 
 	num_segs--;
 
@@ -338,7 +328,6 @@ struct xhci_ring *xhci_ring_alloc(struct xhci_ctrl *ctrl, unsigned int num_segs,
 		struct xhci_segment *next;
 
 		next = xhci_segment_alloc(ctrl);
-		BUG_ON(!next);
 
 		xhci_link_segments(ctrl, prev, next, link_trbs);
 
@@ -399,7 +388,6 @@ static int xhci_scratchpad_alloc(struct xhci_ctrl *ctrl)
 			break;
 		page_size = page_size >> 1;
 	}
-	BUG_ON(i == 16);
 
 	ctrl->page_size = 1 << (i + 12);
 	buf = memalign(ctrl->page_size, num_sp * ctrl->page_size);
@@ -444,9 +432,7 @@ static struct xhci_container_ctx
 	struct xhci_container_ctx *ctx;
 
 	ctx = malloc(sizeof(struct xhci_container_ctx));
-	BUG_ON(!ctx);
 
-	BUG_ON((type != XHCI_CTX_TYPE_DEVICE) && (type != XHCI_CTX_TYPE_INPUT));
 	ctx->type = type;
 	ctx->size = (MAX_EP_CTX_NUM + 1) *
 			CTX_SIZE(xhci_readl(&ctrl->hccr->cr_hccparams));
@@ -638,7 +624,6 @@ int xhci_mem_init(struct xhci_ctrl *ctrl, struct xhci_hccr *hccr,
 struct xhci_input_control_ctx
 		*xhci_get_input_control_ctx(struct xhci_container_ctx *ctx)
 {
-	BUG_ON(ctx->type != XHCI_CTX_TYPE_INPUT);
 	return (struct xhci_input_control_ctx *)ctx->bytes;
 }
 
@@ -760,8 +745,6 @@ void xhci_setup_addressable_virt_dev(struct xhci_ctrl *ctrl,
 
 	virt_dev = ctrl->devs[slot_id];
 
-	BUG_ON(!virt_dev);
-
 	/* Extract the EP0 and Slot Ctrl */
 	ep0_ctx = xhci_get_ep_ctx(ctrl, virt_dev->in_ctx, 0);
 	slot_ctx = xhci_get_slot_ctx(ctrl, virt_dev->in_ctx);
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index c8260cbdf9..1bde0b9793 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -244,6 +244,7 @@ static int prepare_ring(struct xhci_ctrl *ctrl, struct xhci_ring *ep_ring,
 		return -EINVAL;
 	case EP_STATE_HALTED:
 		puts("WARN halted endpoint, queueing URB anyway.\n");
+		return -EPIPE;
 	case EP_STATE_STOPPED:
 	case EP_STATE_RUNNING:
 		debug("EP STATE RUNNING.\n");
@@ -287,12 +288,15 @@ static int prepare_ring(struct xhci_ctrl *ctrl, struct xhci_ring *ep_ring,
  * @param cmd		Command type to enqueue
  * Return: none
  */
-void xhci_queue_command(struct xhci_ctrl *ctrl, dma_addr_t addr, u32 slot_id,
+int xhci_queue_command(struct xhci_ctrl *ctrl, dma_addr_t addr, u32 slot_id,
 			u32 ep_index, trb_type cmd)
 {
 	u32 fields[4];
+	int ret;
 
-	BUG_ON(prepare_ring(ctrl, ctrl->cmd_ring, EP_STATE_RUNNING));
+	ret = prepare_ring(ctrl, ctrl->cmd_ring, EP_STATE_RUNNING);
+	if (ret < 0)
+		return ret;
 
 	fields[0] = lower_32_bits(addr);
 	fields[1] = upper_32_bits(addr);
@@ -311,6 +315,7 @@ void xhci_queue_command(struct xhci_ctrl *ctrl, dma_addr_t addr, u32 slot_id,
 
 	/* Ring the command ring doorbell */
 	xhci_writel(&ctrl->dba->doorbell[0], DB_VALUE_HOST);
+	return 0;
 }
 
 /*
@@ -493,7 +498,6 @@ union xhci_trb *xhci_wait_for_event(struct xhci_ctrl *ctrl, trb_type expected)
 		return NULL;
 
 	printf("XHCI timeout on event type %d... cannot recover.\n", expected);
-	BUG();
 }
 
 /*
@@ -512,16 +516,12 @@ static void reset_ep(struct usb_device *udev, int ep_index)
 	xhci_queue_command(ctrl, 0, udev->slot_id, ep_index, TRB_RESET_EP);
 	event = xhci_wait_for_event(ctrl, TRB_COMPLETION);
 	field = le32_to_cpu(event->trans_event.flags);
-	BUG_ON(TRB_TO_SLOT_ID(field) != udev->slot_id);
 	xhci_acknowledge_event(ctrl);
 
 	addr = xhci_trb_virt_to_dma(ring->enq_seg,
 		(void *)((uintptr_t)ring->enqueue | ring->cycle_state));
 	xhci_queue_command(ctrl, addr, udev->slot_id, ep_index, TRB_SET_DEQ);
 	event = xhci_wait_for_event(ctrl, TRB_COMPLETION);
-	BUG_ON(TRB_TO_SLOT_ID(le32_to_cpu(event->event_cmd.flags))
-		!= udev->slot_id || GET_COMP_CODE(le32_to_cpu(
-		event->event_cmd.status)) != COMP_SUCCESS);
 	xhci_acknowledge_event(ctrl);
 }
 
@@ -545,25 +545,15 @@ static void abort_td(struct usb_device *udev, int ep_index)
 
 	event = xhci_wait_for_event(ctrl, TRB_TRANSFER);
 	field = le32_to_cpu(event->trans_event.flags);
-	BUG_ON(TRB_TO_SLOT_ID(field) != udev->slot_id);
-	BUG_ON(TRB_TO_EP_INDEX(field) != ep_index);
-	BUG_ON(GET_COMP_CODE(le32_to_cpu(event->trans_event.transfer_len
-		!= COMP_STOP)));
 	xhci_acknowledge_event(ctrl);
 
 	event = xhci_wait_for_event(ctrl, TRB_COMPLETION);
-	BUG_ON(TRB_TO_SLOT_ID(le32_to_cpu(event->event_cmd.flags))
-		!= udev->slot_id || GET_COMP_CODE(le32_to_cpu(
-		event->event_cmd.status)) != COMP_SUCCESS);
 	xhci_acknowledge_event(ctrl);
 
 	addr = xhci_trb_virt_to_dma(ring->enq_seg,
 		(void *)((uintptr_t)ring->enqueue | ring->cycle_state));
 	xhci_queue_command(ctrl, addr, udev->slot_id, ep_index, TRB_SET_DEQ);
 	event = xhci_wait_for_event(ctrl, TRB_COMPLETION);
-	BUG_ON(TRB_TO_SLOT_ID(le32_to_cpu(event->event_cmd.flags))
-		!= udev->slot_id || GET_COMP_CODE(le32_to_cpu(
-		event->event_cmd.status)) != COMP_SUCCESS);
 	xhci_acknowledge_event(ctrl);
 }
 
@@ -781,8 +771,6 @@ again:
 	}
 
 	field = le32_to_cpu(event->trans_event.flags);
-	BUG_ON(TRB_TO_SLOT_ID(field) != slot_id);
-	BUG_ON(TRB_TO_EP_INDEX(field) != ep_index);
 
 	record_transfer_result(udev, event, available_length);
 	xhci_acknowledge_event(ctrl);
@@ -970,9 +958,6 @@ int xhci_ctrl_tx(struct usb_device *udev, unsigned long pipe,
 		goto abort;
 	field = le32_to_cpu(event->trans_event.flags);
 
-	BUG_ON(TRB_TO_SLOT_ID(field) != slot_id);
-	BUG_ON(TRB_TO_EP_INDEX(field) != ep_index);
-
 	record_transfer_result(udev, event, length);
 	xhci_acknowledge_event(ctrl);
 	if (udev->status == USB_ST_STALLED) {
@@ -992,8 +977,6 @@ int xhci_ctrl_tx(struct usb_device *udev, unsigned long pipe,
 		event = xhci_wait_for_event(ctrl, TRB_TRANSFER);
 		if (!event)
 			goto abort;
-		BUG_ON(TRB_TO_SLOT_ID(field) != slot_id);
-		BUG_ON(TRB_TO_EP_INDEX(field) != ep_index);
 		xhci_acknowledge_event(ctrl);
 	}
 
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 5cacf0769e..13b226a3f5 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -451,8 +451,6 @@ static int xhci_configure_endpoints(struct usb_device *udev, bool ctx_change)
 	xhci_queue_command(ctrl, in_ctx->dma, udev->slot_id, 0,
 			   ctx_change ? TRB_EVAL_CONTEXT : TRB_CONFIG_EP);
 	event = xhci_wait_for_event(ctrl, TRB_COMPLETION);
-	BUG_ON(TRB_TO_SLOT_ID(le32_to_cpu(event->event_cmd.flags))
-		!= udev->slot_id);
 
 	switch (GET_COMP_CODE(le32_to_cpu(event->event_cmd.status))) {
 	case COMP_SUCCESS:
@@ -647,7 +645,6 @@ static int xhci_address_device(struct usb_device *udev, int root_portnr)
 	xhci_queue_command(ctrl, virt_dev->in_ctx->dma,
 			   slot_id, 0, TRB_ADDR_DEV);
 	event = xhci_wait_for_event(ctrl, TRB_COMPLETION);
-	BUG_ON(TRB_TO_SLOT_ID(le32_to_cpu(event->event_cmd.flags)) != slot_id);
 
 	switch (GET_COMP_CODE(le32_to_cpu(event->event_cmd.status))) {
 	case COMP_CTX_STATE:
@@ -722,8 +719,6 @@ static int _xhci_alloc_device(struct usb_device *udev)
 
 	xhci_queue_command(ctrl, 0, 0, 0, TRB_ENABLE_SLOT);
 	event = xhci_wait_for_event(ctrl, TRB_COMPLETION);
-	BUG_ON(GET_COMP_CODE(le32_to_cpu(event->event_cmd.status))
-		!= COMP_SUCCESS);
 
 	udev->slot_id = TRB_TO_SLOT_ID(le32_to_cpu(event->event_cmd.flags));
 
@@ -1325,7 +1320,6 @@ static int xhci_update_hub_device(struct udevice *dev, struct usb_device *udev)
 		return 0;
 
 	virt_dev = ctrl->devs[slot_id];
-	BUG_ON(!virt_dev);
 
 	out_ctx = virt_dev->out_ctx;
 	in_ctx = virt_dev->in_ctx;
diff --git a/include/usb/xhci.h b/include/usb/xhci.h
index 4a4ac10229..3046b9e411 100644
--- a/include/usb/xhci.h
+++ b/include/usb/xhci.h
@@ -1253,7 +1253,7 @@ void xhci_slot_copy(struct xhci_ctrl *ctrl,
 		    struct xhci_container_ctx *out_ctx);
 void xhci_setup_addressable_virt_dev(struct xhci_ctrl *ctrl,
 				     struct usb_device *udev, int hop_portnr);
-void xhci_queue_command(struct xhci_ctrl *ctrl, dma_addr_t addr,
+int xhci_queue_command(struct xhci_ctrl *ctrl, dma_addr_t addr,
 			u32 slot_id, u32 ep_index, trb_type cmd);
 void xhci_acknowledge_event(struct xhci_ctrl *ctrl);
 union xhci_trb *xhci_wait_for_event(struct xhci_ctrl *ctrl, trb_type expected);
-- 
2.17.1

