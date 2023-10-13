Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45680CDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 04:54:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1C1786D33;
	Fri, 13 Oct 2023 06:54:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Nrsi3IY0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A503F869F5; Fri, 13 Oct 2023 06:54:30 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE07D86D3F
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 06:54:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOH6D3CJcayOwLPkh762f6v5NdLXv/0X7lhrHBeyfxhwO6ji89vkcHhi8HuOOSOZ2OduGNwuUCKlGewCa9RpDv2qH7vjUFVg9WK83rbdMGZEWFet0ePzOVbvcZHKZtrmQY9PkcEjSnCNEasjP+ALgMz5JUOBMcmZsZUhODTpiXkYhpmDDl4MUNfZLcoAUPaV9pb+tEOJP5lVBEAMYUTuDIyDJFXtlMlWZ+9M2UsyidaicuDY9/0rHLAujvcGbvTLb4qgvEJLUVWq1BDQx2yFoxTeZT4uC/VsDA8TNGIOWmEHJ5R6/r9fdFRcFZE0dTLOVbh1ggccDsmbpsOCK6qCZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zjr8FkGLaoRmdLkcKHYR6lIT4+Jzut06ZfDYGfOzEqU=;
 b=JjfGFG18me/+8wefW46LitlgtX6a5mdQVNrP4pLL9OsaXkEQlv+6aYnREvvk4QgfXWC5qDkTgJa6JLK4hstMxTNVdgVLYStuj8LzFsDzQlIi25lFAUaZ1E9c5AsKlz7QrYAem2nXlGvob/prA0loTmSBGB5ugi/tZ8BrWUc9fbN6aRTM98K5rddoq7wCLKLMRILAcKj1mpajc/zJYHIJb4HpMt+fKVooqIgv+tSA+vxQNr5Ds3UUsOs47cCsKp57BljsxooaKXkmO/KSOEs4vSnn7PEI7/ylwu5ST62eOpC1hQb9xcJWFk4G7W68cUP/mJOOgXtRVfHR5sAksdT81A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zjr8FkGLaoRmdLkcKHYR6lIT4+Jzut06ZfDYGfOzEqU=;
 b=Nrsi3IY01HOhloPDBBPtwu5eKhAPcMwkiFYKLRPRVkOc1WrvV4znzzIttJJSygXHWF7jgvIQmvKq0eOm7avVxv33ftld8dbe1Z3AeiWRf7rPAAtcBTKP0O2xdonVHPbXSUQ+DV22t8QHhPkv6QrDYlqgiss+kalhl8QXoHLSZVo=
Received: from BL0PR0102CA0062.prod.exchangelabs.com (2603:10b6:208:25::39) by
 SN7PR12MB6814.namprd12.prod.outlook.com (2603:10b6:806:266::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.45; Fri, 13 Oct 2023 04:54:11 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:25:cafe::73) by BL0PR0102CA0062.outlook.office365.com
 (2603:10b6:208:25::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.27 via Frontend
 Transport; Fri, 13 Oct 2023 04:54:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 04:54:10 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 23:54:10 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 23:54:09 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Thu, 12 Oct 2023 23:54:08 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <git@xilinx.com>
Subject: [PATCH v2] usb: xhci: Workaround to fix the USB halted endpoint issues
Date: Fri, 13 Oct 2023 10:23:56 +0530
Message-ID: <20231013045356.25789-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|SN7PR12MB6814:EE_
X-MS-Office365-Filtering-Correlation-Id: d2c0da66-7194-458f-d535-08dbcba8708e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fGljmQzbXNBc31J2WoCp92nOfK3JdDuARR94FLtcDs0g4hzWJZyBdAyOYlY6cLPt1KYcEhUgjDrz5sSH27yyJZ+xPb0idgjgnoYJMrA9D3JJi8t1CVErPJBl0+DtXkP0O62oPWT7N+O1zjTKGE+Q4RerZjjh7HTemofJ9W0rgLtn6+FrKStgbCKQJP+ytbsKMVK/Xw+cf+o/PA0BTilc5TjyImkhZ9mMK2b8Lj1+vCpDBvRqDIjo5tF17qU9jonyNyhJOi330bHQ4S7bjmOzKRDuIFY5QbTF/VOwDkXzjawoXIsVyS2BkI1H0fpepvhIWgGt5npBvPuSj5oS+eV+yMH6J59QDkqK3RwHEGP118lx6pFAv5A7Ry5pQy7AZqLVqVxWo9ILs+hcrRzC4S40kA9QaQhhXEdbTDd/ou7PIxVLmDNuW36EP+UhqLBTRjacm03sKkKJ0mPWQyj44SoNKhltZYL/ykhjKdDFaPss/C0RWKUtxSBUTLbx4n/WaeXw1KmPBG+Ns337ry0mOvAC9G5bVIp1GI+DkiRJMUZoy1yt+cI00EcNt+Ypgu7sF3S3tB5Plrz0N/DoEU5SEZOX7LX/GoZoeII670gAint68nH0tT5rG1QqQ9KE8qZaZ+XEkr1J5ybvx7kf+JJDe7mcnXnRr4CUpm/6OFTxOB664A5o8KOCmrGlkL3aya1HcUF5tpuXz32H3i/3cfTaTdWivI31Mu115ogj0KgK8zXHJoUMYJWWIoz89ofD2JgC2XXR
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(186009)(451199024)(82310400011)(64100799003)(1800799009)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(26005)(426003)(336012)(2616005)(82740400003)(81166007)(1076003)(356005)(107886003)(41300700001)(5660300002)(8676002)(8936002)(4326008)(30864003)(86362001)(2906002)(54906003)(316002)(6916009)(70586007)(36756003)(966005)(70206006)(6666004)(478600001)(47076005)(36860700001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 04:54:10.5941 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2c0da66-7194-458f-d535-08dbcba8708e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6814
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
Changes in v2:
 -Fixed the compilation warning.
---
 drivers/usb/host/xhci-mem.c  | 17 -----------------
 drivers/usb/host/xhci-ring.c | 32 ++++++++------------------------
 drivers/usb/host/xhci.c      |  6 ------
 include/usb/xhci.h           |  2 +-
 4 files changed, 9 insertions(+), 48 deletions(-)

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
index c8260cbdf9..5e9273c5a6 100644
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
@@ -493,7 +498,7 @@ union xhci_trb *xhci_wait_for_event(struct xhci_ctrl *ctrl, trb_type expected)
 		return NULL;
 
 	printf("XHCI timeout on event type %d... cannot recover.\n", expected);
-	BUG();
+	return NULL;
 }
 
 /*
@@ -512,16 +517,12 @@ static void reset_ep(struct usb_device *udev, int ep_index)
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
 
@@ -545,25 +546,15 @@ static void abort_td(struct usb_device *udev, int ep_index)
 
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
 
@@ -781,8 +772,6 @@ again:
 	}
 
 	field = le32_to_cpu(event->trans_event.flags);
-	BUG_ON(TRB_TO_SLOT_ID(field) != slot_id);
-	BUG_ON(TRB_TO_EP_INDEX(field) != ep_index);
 
 	record_transfer_result(udev, event, available_length);
 	xhci_acknowledge_event(ctrl);
@@ -970,9 +959,6 @@ int xhci_ctrl_tx(struct usb_device *udev, unsigned long pipe,
 		goto abort;
 	field = le32_to_cpu(event->trans_event.flags);
 
-	BUG_ON(TRB_TO_SLOT_ID(field) != slot_id);
-	BUG_ON(TRB_TO_EP_INDEX(field) != ep_index);
-
 	record_transfer_result(udev, event, length);
 	xhci_acknowledge_event(ctrl);
 	if (udev->status == USB_ST_STALLED) {
@@ -992,8 +978,6 @@ int xhci_ctrl_tx(struct usb_device *udev, unsigned long pipe,
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

