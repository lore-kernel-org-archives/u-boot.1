Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3352C5DF87
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:13:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6030A409DE;
	Fri, 21 Aug 2026 13:13:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KT4Wn5JLOot9; Fri, 21 Aug 2026 13:13:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787317999;
	bh=ORfz1uD04LxdPEu+rbyxJQsTRgr5qkxZwyo7NsZIm0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ROUCkIi6NCBodkSotGO6U0IEWW4T/5GiU10K3stlRLYviSnzXGjFKF6LHELAz1UQT
	 m/RQ0DnrJNAjq9S8q3TM9/A2m5ZY7APP7ZIt/C7zAOXJyl4RIH6mLMhAuk0FLJN1MF
	 TXfl3Slz4GqbAoYkG6Vrxidia1yP3Kird5UWsjKnDiy1TvRnPr+v2YfcC3d2i5/UHb
	 x9eYS1ArOLIQoFLws2P67mRoxQ9/ej7iTt1HhfjsJeeS8qhC3IZLtGKywnnRwjmPQC
	 lcJUJnO9bhVsP50X+qk4AWyjcwFbRIoIHc13zJXyZzdhKPOM+XAaeMrVb/eBhfQCEl
	 QbUCsSmx1YS2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EA6D5409C3;
	Fri, 21 Aug 2026 13:13:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 505074B8
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:51:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 36D3D40947
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:51:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gf3sghFB9VJn for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:51:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=KdsYwjYD
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 438BA408BC
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:51:44 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6a18b91fb1fso166258a12.0
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 01:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787302302; x=1787907102;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ORfz1uD04LxdPEu+rbyxJQsTRgr5qkxZwyo7NsZIm0E=;
 b=KdsYwjYD34w0YziN31H6IuMHLToGFpLc8PJfQcUNcRvEDfJDju8jl7q5HOw3UmlNke
 dR6IUYGAEnaDgpHHxtE40HdzgAe+RfeARk2u+5Apyy/bSHMNK0xZmY/MWaZS5GuLFaWy
 ImQtQ7WnaMRz4BfjG6ADcNif/huQTfm9kun7S6c48pVMdOBdRj8RQb5NPrp4dZroVp6s
 RP7golJ6nVK06ku/MwQ/jnEm154uvymPPQvto2BplkZiw51ARB5D0f6OAalzzl1ldjC/
 S9iShq4FgB3l1y1+nvAiTOBmH0KK5V5ccRXfDjQMD4eRN58M66ut93DS1UwzBaEADuUI
 thQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787302302; x=1787907102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ORfz1uD04LxdPEu+rbyxJQsTRgr5qkxZwyo7NsZIm0E=;
 b=AEFJeL9V1YxexF7+2ObKl9/1COFlRgat89idIi1hvVZPOjUSJsnfi4yzBOvrBXP002
 16toZdVm+OcjUv6mQxt9MEqKORSv8aOH4znQBcnqymHLqmPiGqYhbwTPgg43k2qedE0b
 cncKi8SiAc72SAvNOYDn2jfWnlEih76JVm7nKZKgiLMtcF1hdqDhfZ7gZnuioUCLz67l
 AEC2eBkoVSCMkF8iuFnFK0YshtTXVpo84MuyMtfJcQXG6WzAgAnAq52OEWFfFLT/7nDE
 S9M67NHjMQeZ6j0VqWP/LVPiAY1iNDJyET6Wgt4tWpQmC8mf1f5AX3hnUlYnlzP4jiMC
 bhCA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rop1hhczMSLdvgiTEo/Z/ZLzCYvrYzKvAA9DW3/sTRKFow6TMIJKWnM6cZ9wuDyg2wWkQBsKNI=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nIryfqFkvQzeI8aCLnWPOtkrJ32lmDd9mCBMh+gQfRFRZfuzOw
 MfnTy3lJvIe8k7D3PlVe9vykceC8S5MKaKO+3zTFZ0jy9MYrhq/Vfn8GK3XHTNhFmz00SckfjSs
 UO+ez
X-Gm-Gg: AR+sD13BOm0wUz/Uvs790c3puH8IBeGbTCxjnfCpsEUrUQolDkFFP4+YM/5EEUrh0HT
 dNOROyJ/BBLgkmLpKjfVLpiecWRqnz0NRP16ykbVdZ1DU2ihGN5Os9mgKGGZW0+XxZjkci/OpmY
 zeuufCbB794jWXKc+ayewKHBGDvxlYC9hIu9e+Cl+ArCX9xdy64Osd2AWgE7+ubNmvEB+wT/Q5U
 asZHQeSYZaGKe9a74WHpumO3QJ0uISe1dWnijGP+mm3qUbQmujPns4rq1MDHkwmdEQkhsnBQJuW
 s6D8VmNEIqJ2Q3esPI01fq5n25YFi2mYj0vpxrZoD6bSfn0KCgo2dQgaXfg/P/vu5OLMDldwF7l
 vlzUAmnxnvGPS1C17ywN8VgbLdqxPZF9SI2+XHCGULAW0CLVAEHy3JTeaYW6yvXdyQVqMUcwook
 GhbtfegmPSTkr5RBAZUG4W2jozLvSd+LJbMYl+TPWO7/b3S2yAUbwdcfiyhCxw1iKJroEgGH+Z2
 yIaCEOxdCNN+WZwI9QCuMkS
X-Received: by 2002:a05:6402:44cb:b0:6a4:32c0:3e96 with SMTP id
 4fb4d7f45d1cf-6a432c0408fmr1477758a12.1.1787302302168; 
 Fri, 21 Aug 2026 01:51:42 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3ff1565fesm5666067a12.17.2026.08.21.01.51.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:51:41 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Lukasz Majewski <lukma@denx.de>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v6 36/87] usb: dwc3: import from kernel v5.11
Date: Fri, 21 Aug 2026 10:47:12 +0200
Message-ID: <20260821084829.2070426-37-anders.roxell@linaro.org>
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

