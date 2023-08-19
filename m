Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C61EE49A3
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 14:26:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99E2487079;
	Sat, 19 Aug 2023 16:24:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1692455087;
	bh=Il0DxzxTe4o1/D+Y3D4zaNQpNLvjz5x4Aa0TRPi2YA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D9ASL3DjOSsloY6XDnVNxBKQsDBw5KNRMREPL4kidugSYHLdWWHNZjCDK7kUrdqGE
	 YaZDpTAwLIS0Bpoey9kh1W5692QjHy5Ltw/zASVrvPbJOMgEp/ifiEuc22fMPmm4a0
	 ceonFdcF35SFyZuQN7IIbB30C1b80uDb4hqNz8ofqznoeAOBCoigUaaIVA7eekQEMW
	 dCU8WiwNMU90qdPwtFJGgyEiM/n40uGzCfMbKQ2i5oJF/Cw3VQPLhB4/p+eF4jLEhv
	 ++AxBF0O3TH6RPNKpoIKJbw6c0B247yQap3nKkCcU8lI6hTfwaQMuAxDV+0ePFLpJG
	 WCNFjPiJBgGDQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 5FA1987061;
 Sat, 19 Aug 2023 16:24:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1692455084;
 bh=Il0DxzxTe4o1/D+Y3D4zaNQpNLvjz5x4Aa0TRPi2YA4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=vbeIgFwRMopnw1WxzzU/yLq1vx6v2C3PAO2RW1dTpOi5q7Rb57bv1cXKdgpAryhw6
 wXc/K58Qfu5EewX2VgAWELkJz7MQ2AqgfgDLjx3Ue95eNAViepPfijzOkQ7IfuXDmv
 gm2Ltmaj57fLHThnUoxvCORetLR1TetQYUPRIe8YqRlHeUojqwfvg60pD//VHFHKSR
 CuQ4ounaw/YA8M35WVozUZms2SI6NDxMP5OinlY0acjBjlxyysUxxuTfexU88yHU0n
 GhYP6B6WwXuLmfAk5fm5rZm5pw8P0NtS8z6a7WWBsWhRZMkPCYw0MWahbKdPsIBkcJ
 +IZXnxWXLgDDQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Angus Ainslie <angus@akkea.ca>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nishanth Menon <nm@ti.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, kernel@puri.sm
Subject: [PATCH 13/17] thordown: Use plain udevice for UDC controller
 interaction
Date: Sat, 19 Aug 2023 16:24:03 +0200
Message-Id: <20230819142407.49632-13-marex@denx.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230819142407.49632-1-marex@denx.de>
References: <20230819142407.49632-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Convert to plain udevice interaction with UDC controller
device, avoid the use of UDC uclass dev_array .

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Angus Ainslie <angus@akkea.ca>
Cc: Dmitrii Merkurev <dimorinny@google.com>
Cc: Eddie Cai <eddie.cai.linux@gmail.com>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefan Roese <sr@denx.de>
Cc: kernel@puri.sm
---
 cmd/thordown.c              |  9 +++--
 drivers/usb/gadget/f_thor.c | 74 +++++++++++++++++++------------------
 include/thor.h              |  4 +-
 3 files changed, 45 insertions(+), 42 deletions(-)

diff --git a/cmd/thordown.c b/cmd/thordown.c
index 0d8dcee5314..fcfd38f523c 100644
--- a/cmd/thordown.c
+++ b/cmd/thordown.c
@@ -17,6 +17,7 @@ int do_thor_down(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	char *interface, *devstring;
 	int controller_index;
+	struct udevice *udc;
 	int ret;
 
 	if (argc < 4)
@@ -32,7 +33,7 @@ int do_thor_down(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		goto done;
 
 	controller_index = simple_strtoul(argv[1], NULL, 0);
-	ret = usb_gadget_initialize(controller_index);
+	ret = udc_device_get_by_index(controller_index, &udc);
 	if (ret) {
 		pr_err("USB init failed: %d\n", ret);
 		ret = CMD_RET_FAILURE;
@@ -46,7 +47,7 @@ int do_thor_down(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		goto exit;
 	}
 
-	ret = thor_init();
+	ret = thor_init(udc);
 	if (ret) {
 		pr_err("THOR DOWNLOAD failed: %d\n", ret);
 		ret = CMD_RET_FAILURE;
@@ -54,7 +55,7 @@ int do_thor_down(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	}
 
 	do {
-		ret = thor_handle();
+		ret = thor_handle(udc);
 		if (ret == THOR_DFU_REINIT_NEEDED) {
 			dfu_free_entities();
 			ret = dfu_init_env_entities(interface, devstring);
@@ -67,7 +68,7 @@ int do_thor_down(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	} while (ret == 0);
 exit:
 	g_dnl_unregister();
-	usb_gadget_release(controller_index);
+	udc_device_put(udc);
 done:
 	dfu_free_entities();
 
diff --git a/drivers/usb/gadget/f_thor.c b/drivers/usb/gadget/f_thor.c
index 47ef55b2fd3..3caa4c36387 100644
--- a/drivers/usb/gadget/f_thor.c
+++ b/drivers/usb/gadget/f_thor.c
@@ -15,9 +15,10 @@
  */
 
 #include <command.h>
-#include <errno.h>
 #include <common.h>
 #include <console.h>
+#include <dm.h>
+#include <errno.h>
 #include <init.h>
 #include <log.h>
 #include <malloc.h>
@@ -34,9 +35,9 @@
 
 #include "f_thor.h"
 
-static void thor_tx_data(unsigned char *data, int len);
+static void thor_tx_data(struct udevice *udc, unsigned char *data, int len);
 static void thor_set_dma(void *addr, int len);
-static int thor_rx_data(void);
+static int thor_rx_data(struct udevice *udc);
 
 static struct f_thor *thor_func;
 static inline struct f_thor *func_to_thor(struct usb_function *f)
@@ -56,15 +57,15 @@ DEFINE_CACHE_ALIGN_BUFFER(char, f_name, F_NAME_BUF_SIZE + 1);
 static unsigned long long int thor_file_size;
 static int alt_setting_num;
 
-static void send_rsp(const struct rsp_box *rsp)
+static void send_rsp(struct udevice *udc, const struct rsp_box *rsp)
 {
 	memcpy(thor_tx_data_buf, rsp, sizeof(struct rsp_box));
-	thor_tx_data(thor_tx_data_buf, sizeof(struct rsp_box));
+	thor_tx_data(udc, thor_tx_data_buf, sizeof(struct rsp_box));
 
 	debug("-RSP: %d, %d\n", rsp->rsp, rsp->rsp_data);
 }
 
-static void send_data_rsp(s32 ack, s32 count)
+static void send_data_rsp(struct udevice *udc, s32 ack, s32 count)
 {
 	ALLOC_CACHE_ALIGN_BUFFER(struct data_rsp_box, rsp,
 				 sizeof(struct data_rsp_box));
@@ -73,12 +74,12 @@ static void send_data_rsp(s32 ack, s32 count)
 	rsp->count = count;
 
 	memcpy(thor_tx_data_buf, rsp, sizeof(struct data_rsp_box));
-	thor_tx_data(thor_tx_data_buf, sizeof(struct data_rsp_box));
+	thor_tx_data(udc, thor_tx_data_buf, sizeof(struct data_rsp_box));
 
 	debug("-DATA RSP: %d, %d\n", ack, count);
 }
 
-static int process_rqt_info(const struct rqt_box *rqt)
+static int process_rqt_info(struct udevice *udc, const struct rqt_box *rqt)
 {
 	ALLOC_CACHE_ALIGN_BUFFER(struct rsp_box, rsp, sizeof(struct rsp_box));
 	memset(rsp, 0, sizeof(struct rsp_box));
@@ -111,11 +112,11 @@ static int process_rqt_info(const struct rqt_box *rqt)
 		return -EINVAL;
 	}
 
-	send_rsp(rsp);
+	send_rsp(udc, rsp);
 	return true;
 }
 
-static int process_rqt_cmd(const struct rqt_box *rqt)
+static int process_rqt_cmd(struct udevice *udc, const struct rqt_box *rqt)
 {
 	ALLOC_CACHE_ALIGN_BUFFER(struct rsp_box, rsp, sizeof(struct rsp_box));
 	memset(rsp, 0, sizeof(struct rsp_box));
@@ -126,7 +127,7 @@ static int process_rqt_cmd(const struct rqt_box *rqt)
 	switch (rqt->rqt_data) {
 	case RQT_CMD_REBOOT:
 		debug("TARGET RESET\n");
-		send_rsp(rsp);
+		send_rsp(udc, rsp);
 		g_dnl_unregister();
 		dfu_free_entities();
 #ifdef CONFIG_THOR_RESET_OFF
@@ -136,7 +137,7 @@ static int process_rqt_cmd(const struct rqt_box *rqt)
 		break;
 	case RQT_CMD_POWEROFF:
 	case RQT_CMD_EFSCLEAR:
-		send_rsp(rsp);
+		send_rsp(udc, rsp);
 	default:
 		printf("Command not supported -> cmd: %d\n", rqt->rqt_data);
 		return -EINVAL;
@@ -145,7 +146,8 @@ static int process_rqt_cmd(const struct rqt_box *rqt)
 	return true;
 }
 
-static long long int download_head(unsigned long long total,
+static long long int download_head(struct udevice *udc,
+				   unsigned long long total,
 				   unsigned int packet_size,
 				   long long int *left,
 				   int *cnt)
@@ -166,7 +168,7 @@ static long long int download_head(unsigned long long total,
 	while (total - rcv_cnt >= packet_size) {
 		thor_set_dma(buf, packet_size);
 		buf += packet_size;
-		ret_rcv = thor_rx_data();
+		ret_rcv = thor_rx_data(udc);
 		if (ret_rcv < 0)
 			return ret_rcv;
 		rcv_cnt += ret_rcv;
@@ -184,7 +186,7 @@ static long long int download_head(unsigned long long total,
 			}
 			buf = transfer_buffer;
 		}
-		send_data_rsp(0, ++usb_pkt_cnt);
+		send_data_rsp(udc, 0, ++usb_pkt_cnt);
 	}
 
 	/* Calculate the amount of data to arrive from PC (in bytes) */
@@ -200,11 +202,11 @@ static long long int download_head(unsigned long long total,
 
 	if (left_to_rcv) {
 		thor_set_dma(buf, packet_size);
-		ret_rcv = thor_rx_data();
+		ret_rcv = thor_rx_data(udc);
 		if (ret_rcv < 0)
 			return ret_rcv;
 		rcv_cnt += ret_rcv;
-		send_data_rsp(0, ++usb_pkt_cnt);
+		send_data_rsp(udc, 0, ++usb_pkt_cnt);
 	}
 
 	debug("%s: %llu total: %llu cnt: %d\n", __func__, rcv_cnt, total, *cnt);
@@ -254,7 +256,7 @@ static int download_tail(long long int left, int cnt)
 	return ret;
 }
 
-static long long int process_rqt_download(const struct rqt_box *rqt)
+static long long int process_rqt_download(struct udevice *udc, const struct rqt_box *rqt)
 {
 	ALLOC_CACHE_ALIGN_BUFFER(struct rsp_box, rsp, sizeof(struct rsp_box));
 	static long long int left, ret_head;
@@ -301,8 +303,8 @@ static long long int process_rqt_download(const struct rqt_box *rqt)
 		}
 		break;
 	case RQT_DL_FILE_START:
-		send_rsp(rsp);
-		ret_head = download_head(thor_file_size, THOR_PACKET_SIZE,
+		send_rsp(udc, rsp);
+		ret_head = download_head(udc, thor_file_size, THOR_PACKET_SIZE,
 					 &left, &cnt);
 		if (ret_head < 0) {
 			left = 0;
@@ -324,11 +326,11 @@ static long long int process_rqt_download(const struct rqt_box *rqt)
 		ret = -ENOTSUPP;
 	}
 
-	send_rsp(rsp);
+	send_rsp(udc, rsp);
 	return ret;
 }
 
-static int process_data(void)
+static int process_data(struct udevice *udc)
 {
 	ALLOC_CACHE_ALIGN_BUFFER(struct rqt_box, rqt, sizeof(struct rqt_box));
 	int ret = -EINVAL;
@@ -339,13 +341,13 @@ static int process_data(void)
 
 	switch (rqt->rqt) {
 	case RQT_INFO:
-		ret = process_rqt_info(rqt);
+		ret = process_rqt_info(udc, rqt);
 		break;
 	case RQT_CMD:
-		ret = process_rqt_cmd(rqt);
+		ret = process_rqt_cmd(udc, rqt);
 		break;
 	case RQT_DL:
-		ret = (int) process_rqt_download(rqt);
+		ret = (int) process_rqt_download(udc, rqt);
 		break;
 	case RQT_UL:
 		puts("RQT: UPLOAD not supported!\n");
@@ -536,7 +538,7 @@ static struct usb_request *alloc_ep_req(struct usb_ep *ep, unsigned length)
 	return req;
 }
 
-static int thor_rx_data(void)
+static int thor_rx_data(struct udevice *udc)
 {
 	struct thor_dev *dev = thor_func->dev;
 	int data_to_rx, tmp, status;
@@ -557,7 +559,7 @@ static int thor_rx_data(void)
 		}
 
 		while (!dev->rxdata) {
-			usb_gadget_handle_interrupts(0);
+			dm_usb_gadget_handle_interrupts(udc);
 			if (ctrlc())
 				return -1;
 		}
@@ -568,7 +570,7 @@ static int thor_rx_data(void)
 	return tmp;
 }
 
-static void thor_tx_data(unsigned char *data, int len)
+static void thor_tx_data(struct udevice *udc, unsigned char *data, int len)
 {
 	struct thor_dev *dev = thor_func->dev;
 	unsigned char *ptr = dev->in_req->buf;
@@ -591,7 +593,7 @@ static void thor_tx_data(unsigned char *data, int len)
 
 	/* Wait until tx interrupt received */
 	while (!dev->txdata)
-		usb_gadget_handle_interrupts(0);
+		dm_usb_gadget_handle_interrupts(udc);
 
 	dev->txdata = 0;
 }
@@ -685,18 +687,18 @@ static void thor_set_dma(void *addr, int len)
 	dev->out_req->length = len;
 }
 
-int thor_init(void)
+int thor_init(struct udevice *udc)
 {
 	struct thor_dev *dev = thor_func->dev;
 
 	/* Wait for a device enumeration and configuration settings */
 	debug("THOR enumeration/configuration setting....\n");
 	while (!dev->configuration_done)
-		usb_gadget_handle_interrupts(0);
+		dm_usb_gadget_handle_interrupts(udc);
 
 	thor_set_dma(thor_rx_data_buf, strlen("THOR"));
 	/* detect the download request from Host PC */
-	if (thor_rx_data() < 0) {
+	if (thor_rx_data(udc) < 0) {
 		printf("%s: Data not received!\n", __func__);
 		return -1;
 	}
@@ -706,7 +708,7 @@ int thor_init(void)
 		udelay(30 * 1000); /* 30 ms */
 
 		strcpy((char *)thor_tx_data_buf, "ROHT");
-		thor_tx_data(thor_tx_data_buf, strlen("ROHT"));
+		thor_tx_data(udc, thor_tx_data_buf, strlen("ROHT"));
 	} else {
 		puts("Wrong reply information\n");
 		return -1;
@@ -715,17 +717,17 @@ int thor_init(void)
 	return 0;
 }
 
-int thor_handle(void)
+int thor_handle(struct udevice *udc)
 {
 	int ret;
 
 	/* receive the data from Host PC */
 	while (1) {
 		thor_set_dma(thor_rx_data_buf, sizeof(struct rqt_box));
-		ret = thor_rx_data();
+		ret = thor_rx_data(udc);
 
 		if (ret > 0) {
-			ret = process_data();
+			ret = process_data(udc);
 #ifdef CONFIG_THOR_RESET_OFF
 			if (ret == RESET_DONE)
 				break;
diff --git a/include/thor.h b/include/thor.h
index ee67ab0a270..3cb56b654ae 100644
--- a/include/thor.h
+++ b/include/thor.h
@@ -14,7 +14,7 @@
 
 #define THOR_DFU_REINIT_NEEDED	0xFFFFFFFE
 
-int thor_handle(void);
-int thor_init(void);
+int thor_handle(struct udevice *udc);
+int thor_init(struct udevice *udc);
 int thor_add(struct usb_configuration *c);
 #endif /* __THOR_H_ */
-- 
2.40.1

