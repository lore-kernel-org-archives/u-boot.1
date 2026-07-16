Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBABFC44511
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 16:17:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37BAA84E44;
	Thu, 16 Jul 2026 18:09:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IjBeta7q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3688284C3F; Thu, 16 Jul 2026 15:44:21 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EF7384CEB
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 15:44:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anders.roxell@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-698bf274b3fso1003323a12.0
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 06:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784209458; x=1784814258; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3Tizilu1twmrTeCJUDq4hQ3Y3LDdejFF7sN8BlFAOPY=;
 b=IjBeta7q34FndwZWRoXitHUxg7BPH64kuBYs2hZUMTzdpqtbsi+lzFUOu17f7GJ1c+
 mT02L8TNnTIyd2ur6Xgkpj4jfva2Z6WkEIgFIRTA5wQWk5s8+YtnPkWv1ezzaN4Il7VL
 AoUBbOkmIkUMQvxfcJnLIEZWCnLTTjMYULXWY6kRzEQjJSX3ThjKh1Fwtiez6na37/pt
 pkvEKJECA859rmzpTPE5eyaYIL2GPt5dGNxuvbzDxkh7lFJ495/h8hvINPvz5RMOjsK9
 exJiXHfgAog6nGRKJEcMdWKAA1YQxv1KzOLJPANSNskwSAScfVsX4D9CwWeFp7aIVh+c
 iDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784209458; x=1784814258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3Tizilu1twmrTeCJUDq4hQ3Y3LDdejFF7sN8BlFAOPY=;
 b=omZKteY8QJyhqyueT9A6xqV2Tf2V2cgoiP1Kw413kxGVmo4BCzcJwhiOWz3DkIzXk+
 5wnIOnlSgWb3l9HZsExoMWlJMZ4ef4kjdarMXxgBwhxw3YahmLiwbwRy2AGTDl6jskxN
 ntMwa50iFJi5EqFhLIkmsFjJg1zbDv5a+tbYTt5XmEyyKyHlXtR+U+oI08Auigl+AbXn
 qcjNOZKng6pN/Yz+MncN9T7oE0KbSCK2E8oRikHILCdNCRerSl0qrHVzR/3Nm3TWpCqP
 3Z7fnxm7vStqEi5kNMjj5W+TW5pcZKjduavCrYz2sXssv77niSarf795xrxHFofcMWAN
 90QQ==
X-Gm-Message-State: AOJu0YzHq2r/t2jXUkjZGdz2PqN9Tizufuv9AOgvuInD2ANyCjJdBzaX
 xcddON90ct2zarQNx+rKQcWdAgWloryCbaYi2ucKKFAW8VZZgIV3p+/JL82PjOr50JmT+K6K60Z
 ZPKuQ
X-Gm-Gg: AfdE7cm66+V3h4sBDwNpMMQb+6MtTapeJCwJqksfOeO3ar5/UhTT1zTC+J73fhqSWta
 lKg6d1jGDmjqE4u2biv0L4Z6LFo94jbdR5ExWXxCoIhZ53PWOckaRR+Mz5waSRyMi5D2pV7jaOE
 kP4sei3ZGCTf/QPzhmq3WRrv6fulqLmzNvkNlqVtTIpCqzkhye/8vDmYRjt1nuLUt51cBLQnzRB
 suPeiYT0mivW6BU4A0zE/OVuJJM7rlfq9ad20b2vDwFqdHjSndd/UA5sKQQ7sIcEIlK9jY0NNz6
 LP77Ho5nkHLF47lHFI7yAvjLU5rButQHdguauNmDUdAwMhdbm7QBGvAfw2RMLAghktp7MkDgfHi
 6Bv8J3dgXYlW8gJR/6jmmFf1oaFGXh3tMzHNKFla0dC0WnjaPCaaF5fzwqB8mX5aKJHKGlyDLDO
 ms7BzZwm3WAQ1iAUa4eGLzgDo2iMewONoahIP/VA==
X-Received: by 2002:a05:6402:5190:b0:68e:4c0:f59a with SMTP id
 4fb4d7f45d1cf-69c5ef8767bmr6977487a12.2.1784209458426; 
 Thu, 16 Jul 2026 06:44:18 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69d4eedbf7dsm3914447a12.24.2026.07.16.06.44.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 06:44:17 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v5 47/75] usb: dwc3: import from kernel v6.3
Date: Thu, 16 Jul 2026 15:42:17 +0200
Message-ID: <20260716134305.614278-48-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716134305.614278-1-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 16 Jul 2026 18:09:05 +0200
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

From: Jens Wiklander <jens.wiklander@linaro.org>

Sync Linux kernel dwc3 changes from v6.2 to v6.3.

The following files are preserved accross the import:
Makefile Kconfig dwc3-meson-g12a.c dwc3-meson-gxl.c dwc3-omap.c
dwc3-uniphier.c dwc3-generic.h dwc3-generic.c dwc3-generic-sti.c
dwc3-layerscape.c ti_usb_phy.c

Skipping unused files:
debugfs.c drd.c dwc3-exynos.c dwc3-haps.c dwc3-imx8mp.c dwc3-keystone.c
dwc3-octeon.c dwc3-of-simple.c dwc3-pci.c dwc3-qcom.c dwc3-qcom-legacy.c
dwc3-rtk.c dwc3-st.c dwc3-xilinx.c host.c trace.c trace.h ulpi.c

Note that this is a raw import and doesn't build.
A fixup commit at the end of the series fixes that.

List of commits: git log --oneline v6.2..v6.3
Commits imported:
ec799c8a92e0 usb: dwc3: pci: add support for the Intel Meteor Lake-S
d8a2bb4eb758 usb: dwc3: gadget: Add 1ms delay after end transfer command without IOC
02c1820345e7 usb: dwc3: Fix a typo in field name
e3eafcf0fabe usb: dwc3: xilinx: Remove unused of_gpio,h
8e5248c3a877 usb: dwc3: pci: add support for the Intel Meteor Lake-M
be308d68785b USB: dwc3: fix memory leak with using debugfs_lookup()

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/dwc3/core.h   |  4 +++-
 drivers/usb/dwc3/debug.h  |  3 +++
 drivers/usb/dwc3/gadget.c | 18 ++++++++++++------
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 8f9959ba9fd4..4743e918dcaf 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1098,7 +1098,7 @@ struct dwc3_scratchpad_array {
  *			change quirk.
  * @dis_tx_ipgap_linecheck_quirk: set if we disable u2mac linestate
  *			check during HS transmit.
- * @resume-hs-terminations: Set if we enable quirk for fixing improper crc
+ * @resume_hs_terminations: Set if we enable quirk for fixing improper crc
  *			generation after resume from suspend.
  * @parkmode_disable_ss_quirk: set if we need to disable all SuperSpeed
  *			instances in park mode.
@@ -1117,6 +1117,7 @@ struct dwc3_scratchpad_array {
  *		     address.
  * @num_ep_resized: carries the current number endpoints which have had its tx
  *		    fifo resized.
+ * @debug_root: root debugfs directory for this device to put its files in.
  */
 struct dwc3 {
 	struct work_struct	drd_work;
@@ -1332,6 +1333,7 @@ struct dwc3 {
 	int			max_cfg_eps;
 	int			last_fifo_depth;
 	int			num_ep_resized;
+	struct dentry		*debug_root;
 };
 
 #define INCRX_BURST_MODE 0
diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
index 48b44b88dc25..8bb2c9e3b9ac 100644
--- a/drivers/usb/dwc3/debug.h
+++ b/drivers/usb/dwc3/debug.h
@@ -414,11 +414,14 @@ static inline const char *dwc3_gadget_generic_cmd_status_string(int status)
 
 #ifdef CONFIG_DEBUG_FS
 extern void dwc3_debugfs_create_endpoint_dir(struct dwc3_ep *dep);
+extern void dwc3_debugfs_remove_endpoint_dir(struct dwc3_ep *dep);
 extern void dwc3_debugfs_init(struct dwc3 *d);
 extern void dwc3_debugfs_exit(struct dwc3 *d);
 #else
 static inline void dwc3_debugfs_create_endpoint_dir(struct dwc3_ep *dep)
 {  }
+static inline void dwc3_debugfs_remove_endpoint_dir(struct dwc3_ep *dep)
+{  }
 static inline void dwc3_debugfs_init(struct dwc3 *d)
 {  }
 static inline void dwc3_debugfs_exit(struct dwc3 *d)
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 89dcfac01235..cf5b4f49c3ed 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1699,6 +1699,7 @@ static int __dwc3_gadget_get_frame(struct dwc3 *dwc)
  */
 static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool interrupt)
 {
+	struct dwc3 *dwc = dep->dwc;
 	struct dwc3_gadget_ep_cmd_params params;
 	u32 cmd;
 	int ret;
@@ -1722,10 +1723,13 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool int
 	WARN_ON_ONCE(ret);
 	dep->resource_index = 0;
 
-	if (!interrupt)
+	if (!interrupt) {
+		if (!DWC3_IP_IS(DWC3) || DWC3_VER_IS_PRIOR(DWC3, 310A))
+			mdelay(1);
 		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
-	else if (!ret)
+	} else if (!ret) {
 		dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
+	}
 
 	dep->flags &= ~DWC3_EP_DELAY_STOP;
 	return ret;
@@ -3194,9 +3198,7 @@ static void dwc3_gadget_free_endpoints(struct dwc3 *dwc)
 			list_del(&dep->endpoint.ep_list);
 		}
 
-		debugfs_remove_recursive(debugfs_lookup(dep->name,
-				debugfs_lookup(dev_name(dep->dwc->dev),
-					       usb_debug_root)));
+		dwc3_debugfs_remove_endpoint_dir(dep);
 		kfree(dep);
 	}
 }
@@ -3776,7 +3778,11 @@ void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
 	 * enabled, the EndTransfer command will have completed upon
 	 * returning from this function.
 	 *
-	 * This mode is NOT available on the DWC_usb31 IP.
+	 * This mode is NOT available on the DWC_usb31 IP.  In this
+	 * case, if the IOC bit is not set, then delay by 1ms
+	 * after issuing the EndTransfer command.  This allows for the
+	 * controller to handle the command completely before DWC3
+	 * remove requests attempts to unmap USB request buffers.
 	 */
 
 	__dwc3_stop_active_transfer(dep, force, interrupt);
-- 
2.53.0

