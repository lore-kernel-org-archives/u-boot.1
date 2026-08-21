Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13374C5DF87
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:16:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D2EAE60E3D;
	Fri, 21 Aug 2026 13:16:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vz3tKg4X4q8K; Fri, 21 Aug 2026 13:16:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787318030;
	bh=BMWPxhJU07SszhgENdrVD2oVr1+bL4jhDtZONMpI6XE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sHB4N8nSYFc7IXBw9m0xePGoU2AsCGNDH8o5tt1US+Jxdo0fjUDpaq6G0IJB4agkD
	 PItnW07FXJCESjvQc2cO7vxd/OfcqQTY9PfxxGMh1jSMZ50BUiR1LX1FlryEsR4X+1
	 RaEUdRlAw9Z9gVfU/Yh7hMzNvHh//ZhheGZUtb69RnnUl2OtVxa6R1vbN/xKKCi1VA
	 5hR2+Rnjf4dcCu31Pl4/Z2tq1ieHXIDFWFCexf0fh/sbAKtcBqlzBl+tGqduhS2+0x
	 A1ILe9NfRogg3cOoRxc03ADbo36LHlH+TaK8H5RoOZjL0005Lkc/MuCpblCH85PBwY
	 BYD3aq9tZFHPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E23F660E45;
	Fri, 21 Aug 2026 13:13:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C6DD5476
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ACCA960662
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gyQVMNAQDLNT for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:52:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=xweqo3FJ
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4B10060661
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:00 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c082647cd0dso6436566b.0
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 01:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787302318; x=1787907118;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BMWPxhJU07SszhgENdrVD2oVr1+bL4jhDtZONMpI6XE=;
 b=xweqo3FJQ2MelMOyOGzVM4ga0sWiq7OnNAKZ0hROJIjE1yKxNY3rkAk/foDLHdmS1r
 BhE31kBMcsjKWvwCCp8eKtKSha5iKWRPL78Tu+fQn1RkSzmwJfnyMoX5VndRGi14jaiB
 8UoAXfwZyO1JNQ7Zq7gUu0Khu5zJeDX6qVqszqmcKKw0wuDfBe5HhnbusBveFF5pzruV
 4ofoQoLBu4cGRBJH5wjHjSCsv1uK4yy21f9SREOtET0PXyEsFnFTP+RKsMkxhuYjQv8g
 7nB0e8ccSaSSX27/6H0bgxmus0oxdbU4Z88WtyO/ug4xV7eKDlvSwNCBby6WgPXUGezJ
 +3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787302318; x=1787907118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BMWPxhJU07SszhgENdrVD2oVr1+bL4jhDtZONMpI6XE=;
 b=XxeuGBfEz6lP2ftH6oR9pwFhdoBz0B8wXaF6409QIpgQ24BOyKtEBTgAORar2MS5Ej
 3oxt0RdUwO0aERpimor9N2D5DCPNZn3JQ1bCPrdHznG5Q0jVnzovl3DCji/HsDQS3Ks+
 StnA4FxEfTKD/4OBYhMD4s70vEXGvbd706YlkdVQaVbogWogjSe5SK4/XO9XyrxotG84
 GwJ7Kwn4QuUF409JSsQFkDjHcIEcx2d7ZUpG25fgDfWdJKNArmE0bPlDPUqiRMy8FX+X
 J13o7h79GUUoJp8jZpzjwKfD2l31sRB0oLspFwLhQHUrVrMvUTFMg0Fn89xf7KWrGRiS
 cpaw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrurcBtCrmOz/3wMhvCRnqVKv/mXdKXukvaJF6E0RjVXzvTEKtObRGng6hjAXK3Qo9sR1gkC9Q=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mwqEu8zlGsv2FCvzR4h0PLpMVIAdi5i4cCjVNsDG+tyjYJYWSs
 2KZ4oT+bLSHfHhdvB+hRIalprEQqzmcuKIGoS9E9pFApyYSLwP/9Dm5k2rIBuj632fY=
X-Gm-Gg: AR+sD11S1fdHxkgOj3PEWUshVWUm1w8PIFkE4asvTLRuGd9yN/hi2uWW7ogCUcqflHg
 RA21OPVAj2looR5m6kS8fdqGgRrpQSLKkWWRJZuLdgH9mUTANzAunFlw2arHt8ZU7aP0rW7L1/i
 5gOB0KV2nGGjcQ1k0dfkVaVSScD5u4HIeMoyDSTM1UTUOgGYb/lptDGMyBTqdfi8TQJnguMMTd0
 leq0Q9GqRZoxMZuPUELRQgI4Z51gVp2RSJjsANGmveHGjrFhAP7rSgTCWkhdcGiJT/XQScpR8Vl
 fow+IOMQTdY0K+Rtt4Hx5+KcNaf9mK+SlVOeRFthQo4xCEBTwf2P4HsmIRihTAeBYGdqPsnryxu
 QDl/bcvCfBop4+D8PzPc4XA+uNA4yioZT8xPkx3Gd94N6a+mAOJudSFRklv2ckAeyBucPlf+o9O
 xsBpwF209G6W4cSgnNOlyo3Uhvz8M/sZVmtwsUgKkpEKlyQeNXr5NIY5Bpm5EblAVS1fRoM5OXu
 52Flkr7F/wMUC/2M8PYipLP
X-Received: by 2002:a17:907:97c1:b0:c21:764c:9417 with SMTP id
 a640c23a62f3a-c246a2eb944mr264187166b.1.1787302318149; 
 Fri, 21 Aug 2026 01:51:58 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24591df2acsm359863266b.44.2026.08.21.01.51.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:51:57 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Lukasz Majewski <lukma@denx.de>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v6 48/87] usb: dwc3: import from kernel v6.3
Date: Fri, 21 Aug 2026 10:47:24 +0200
Message-ID: <20260821084829.2070426-49-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821084829.2070426-1-anders.roxell@linaro.org>
References: <20260821084829.2070426-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 21 Aug 2026 13:11:40 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Jens Wiklander <jens.wiklander@linaro.org>

Sync Linux kernel dwc3 changes from v6.2 to v6.3.

The following files are preserved across the import:
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
d8a2bb4eb758 usb: dwc3: gadget: Add 1ms delay after end transfer command without IOC
02c1820345e7 usb: dwc3: Fix a typo in field name
be308d68785b USB: dwc3: fix memory leak with using debugfs_lookup()

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
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

