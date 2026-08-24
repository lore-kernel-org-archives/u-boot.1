Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA479C61CE3
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:44:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6B8B46075B;
	Mon, 24 Aug 2026 16:44:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xHDfmQaw5r6Q; Mon, 24 Aug 2026 16:44:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787589888;
	bh=ORfz1uD04LxdPEu+rbyxJQsTRgr5qkxZwyo7NsZIm0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=00llYcpW4PC38/vdBafX+9gy+H92xDvdfQsYJOoXNuH9UTmCwhY63oa8A9mheYfsk
	 ddgm1rNY0O1H0PwrYKKNbHVDd2Q33ZSdXCtaWRUxtQVAYzlIrfwghw5KAvKUjpbZXY
	 CrnR62jx9D8Q7l4YiHYB8xcIMKLY9cC4XDpbSg2LxikLdWWBsWorQO3AY9d8DmHVPm
	 ejMGRCIaCsiN1XXuuzp2O0Fopie20RuGqVuC9UBBHWNlvlvTFftWlQp3paeXqy+Rsi
	 1BA6RBBLdW3+dgZAssuZyJG2Hhrb+51TAGBXhoci5T4OtQpZSQBB8TufIXoyRe2mZR
	 aFHomeMcgujtA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DF83760751;
	Mon, 24 Aug 2026 16:44:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2A5A83AD
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:30:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 27FB94006F
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:30:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id giiRpfwAm-Iy for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:30:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=hO3wIdAo
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EAD5B40029
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:30:32 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c1f1f5631f8so34392066b.2
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787585430; x=1788190230;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ORfz1uD04LxdPEu+rbyxJQsTRgr5qkxZwyo7NsZIm0E=;
 b=hO3wIdAoq08LeQPBnTxGi5iz4slFA8f2VriFGReuCa3C4y0OkJzYsZvKUsu4vUadTc
 VHPf8/8C9a5qWN5epOk/ras56CtFa1kx6P10LNy1jamOy1HSklfUsKyI4eEX0u5LEyf7
 Z3qlqybsYTTbA2pV8lvfcF/psD3XRT/ZshIGMJ1hhnp6zGPuUXUKmtr7MS+9EyN3IDJG
 crv9c360LgY3Tj07hhoCFyCUOhDL6M/vWQEcTtMU3yH+YLDcP+P9DGv260PR0ihRT/zk
 KFa1N7o+s+Ld75AXRbLtxQrIEsRY5Zbi6ZWQx+NNxxtUDX18i/rVqXBdCkLoXfccg1zG
 H0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787585430; x=1788190230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ORfz1uD04LxdPEu+rbyxJQsTRgr5qkxZwyo7NsZIm0E=;
 b=JrlkprDxb6PeTCt/nuZpoINplXDUguzJKPG6/oRtW28P8OqrZVtDUtSBd0Mxsbh8Tx
 pEPW27+P0yd4ve9LjAj3Mh0i8KRsFOXTho5G7ihEO7nPj2fsi7FR2XSwpIOTyb9oz/5u
 rfoGQjnO8ZDJ/rF4EpoDKcjgYjM3/zGn6Cnx6qcKFLJ7nJD5qk7k62uhGWYPGit24F0/
 BnyqBLEoT415PqutcIfNYcC3pZV21kOdW51iiT03t9GFGFuOCrRXcQHFiCccCsDGymi6
 R4gJAfA/Mf+SXo/k+a2cFZ/lmsWILMsApH06NNFlHKrdHpv1FaVK+Y/J04VoyhFOHaG5
 kNkw==
X-Gm-Message-State: AFuF++nBqd9VfNGnw1S6w+HcCHz8P5AXskBRBBppeXzM1yEs8rCKiHSI
 HGAwbQpV9ABBsznqwCI69APQa0z82cbm1TAVBI3RbQ/wwPTGCoIvXJF51spQTw84hGdcvmbz7n+
 pFxXG
X-Gm-Gg: AR+sD10nlbCkpe3WC7byufUS7x772UEg7rbLzmlvJiJfOvBFn48oIZT35qfEwsZip/H
 txO5gQfBn0s8MuqMW9M7Dszkoc/QZY3CiUrRqSTEgiJTX+G3AMYFcOsc1W0Q5Yx09YyIIQPkR7L
 9B8LjH4pTs46Zm/opHNYWz+vAl3xbyHKOH1tJafl3A77TmEIYcAXCIu5Xlee2XveKFb2YoYj06u
 gFQVcaEJvRHGpM5QkUPkhg3U/xcvF+Tgj5QWrLslaDcaG6evgf9+YlRjqHNAA/pqQ5jGQ7NMF7H
 ebfhQXGyTU+2EHPi2cZCUsQyGdYnfP8IFzJ8mNolKa5oxLareDypWWeC1nwrRGMXh4PPCq/tU/Q
 fG9HgmIBPs6/17/9GmlApW+OXOxUJ2Y25EoiyWhHHdKYD3HHmgLp3sqFVV6aXaEBamNdOT4YUq+
 Zlzt1DCkwmElqzYZGKPAPml/D+oY0FgSySLUdDfucbI5bOx6h69Fjmb4TmqGUFLaARJBWhY8Ptn
 E4iUWmgV7DqKPpG/b/1zw==
X-Received: by 2002:a17:907:a089:b0:c15:de99:8060 with SMTP id
 a640c23a62f3a-c2469f96e84mr1543596166b.0.1787585430350; 
 Mon, 24 Aug 2026 08:30:30 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2496295632sm1479473666b.18.2026.08.24.08.30.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:30:29 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH v7 36/63] usb: dwc3: import from kernel v5.11
Date: Mon, 24 Aug 2026 17:27:07 +0200
Message-ID: <20260824152734.159794-37-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824152734.159794-1-anders.roxell@linaro.org>
References: <20260824152734.159794-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 24 Aug 2026 16:43:55 +0000
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

Sync Linux kernel dwc3 changes from v5.10 to v5.11.

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

List of commits: git log --oneline v5.10..v5.11
Commits imported:
0e5a3c8284a3 usb: dwc3: fix clock issue during resume in OTG mode
a5c7682aaaa1 usb: dwc3: gadget: Clear wait flag on dequeue
a1383b3537a7 usb: dwc3: gadget: Restart DWC3 gadget when enabling pullup
ce722da66d3e usb: dwc3: ulpi: Use VStsDone to detect PHY regs access completion

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c   |  2 +-
 drivers/usb/dwc3/core.h   |  1 +
 drivers/usb/dwc3/gadget.c | 16 +++++-----------
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 841daec70b6e..3101f0dcf6ae 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1758,7 +1758,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 		if (PMSG_IS_AUTO(msg))
 			break;
 
-		ret = dwc3_core_init(dwc);
+		ret = dwc3_core_init_for_resume(dwc);
 		if (ret)
 			return ret;
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 2f95f08ca511..1b241f937d8f 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -285,6 +285,7 @@
 
 /* Global USB2 PHY Vendor Control Register */
 #define DWC3_GUSB2PHYACC_NEWREGREQ	BIT(25)
+#define DWC3_GUSB2PHYACC_DONE		BIT(24)
 #define DWC3_GUSB2PHYACC_BUSY		BIT(23)
 #define DWC3_GUSB2PHYACC_WRITE		BIT(22)
 #define DWC3_GUSB2PHYACC_ADDR(n)	(n << 16)
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 78cb4db8a6e4..ee44321fee38 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1763,6 +1763,8 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 			list_for_each_entry_safe(r, t, &dep->started_list, list)
 				dwc3_gadget_move_cancelled_request(r);
 
+			dep->flags &= ~DWC3_EP_WAIT_TRANSFER_COMPLETE;
+
 			goto out;
 		}
 	}
@@ -2083,6 +2085,7 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
 
 static void dwc3_gadget_disable_irq(struct dwc3 *dwc);
 static void __dwc3_gadget_stop(struct dwc3 *dwc);
+static int __dwc3_gadget_start(struct dwc3 *dwc);
 
 static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 {
@@ -2145,6 +2148,8 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 			dwc->ev_buf->lpos = (dwc->ev_buf->lpos + count) %
 						dwc->ev_buf->length;
 		}
+	} else {
+		__dwc3_gadget_start(dwc);
 	}
 
 	ret = dwc3_gadget_run_stop(dwc, is_on, false);
@@ -2319,10 +2324,6 @@ static int dwc3_gadget_start(struct usb_gadget *g,
 	}
 
 	dwc->gadget_driver	= driver;
-
-	if (pm_runtime_active(dwc->dev))
-		__dwc3_gadget_start(dwc);
-
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return 0;
@@ -2348,13 +2349,6 @@ static int dwc3_gadget_stop(struct usb_gadget *g)
 	unsigned long		flags;
 
 	spin_lock_irqsave(&dwc->lock, flags);
-
-	if (pm_runtime_suspended(dwc->dev))
-		goto out;
-
-	__dwc3_gadget_stop(dwc);
-
-out:
 	dwc->gadget_driver	= NULL;
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
-- 
2.53.0

