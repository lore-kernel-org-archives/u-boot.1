Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B152D4662F
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 23:04:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A9E78367F;
	Fri, 16 Jan 2026 00:04:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cjXBH0xX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D55083623; Fri, 16 Jan 2026 00:04:13 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1821B80077
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 00:04:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7cfdf7e7d19so246116a34.2
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 15:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768518249; x=1769123049; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Av1AJjV0sJkOGZiW3769sQMomg19gSJIRYcL1wD8PZw=;
 b=cjXBH0xXM4XNHNkUxRPlMOyrN8O4kRgGM3K+9dZ0oQe7o/Udo+hs8MlUmH1u7aZSet
 9QM14j/dC+dMdjM+kQ39KkpSMKpgz7pftTT+KwIdYvQlPuZe+rvalslaQHae+cK04l4I
 AvBi0RJ39vltI1TehbsWOu/PVcjC38H1GYxb2l849xvV5DwLtw7KDwLZZLUlBcC4tOBL
 qRpm7mvzLUrvt/yXptzQXS1uaex59hb3maUTVoT0cLlpEFwlAX5CShIjBNQG06nkqy0X
 y1l/XTh3DYKcO/1ZaFGjG8QDywk2v0NrhBTA74spGiECEiX0b6o3PchQgh+jABFPhUQP
 CgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768518249; x=1769123049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Av1AJjV0sJkOGZiW3769sQMomg19gSJIRYcL1wD8PZw=;
 b=pKwIkja5jZ+Iffz6aqacfLnkmnnTr16gFCPzq/3vzus3EWv4QNleHhxSPQUR5XaMQ3
 WOnBWHHTiNYejdcyWChy4dP6Qbw6dLgUB1SBcZGQiPHO758ddl3qn+C9LKuBnGqvs7d+
 0kttSsnP/poUgncO9fq86qWEoBOFD+K6Ve9+MTWR3gISKwCHEgkrVP92vTiqagTKROx0
 ECFs49YpDjnAnyCsnOv16p2yKSNri5GtTeX/FGmftSfMazPOTvef1lZoROW4uBLaUxNa
 7FQwT83vHR72HNP4KhxIgx2Ry5sGLs1sxB3UJJs94M5jJbfFnFnL8ORZ/ZSkWFGrCUxR
 T+pA==
X-Gm-Message-State: AOJu0YzrXrnLkphMIN7lcgOdvZ3GQIWX/WT+Po/VcglMjcQuo2ONmhfn
 5M0MyLUjHCr2zB6zbhw/oSG5EIr14rXy5Ltg69GFvEzfKqk7JkHGY5MTqPoT1w==
X-Gm-Gg: AY/fxX6LimCgw+jh0dFGa6Wkl/4Z1n37/iib4wxlSiizf+37XeBu1lereulmzkbKUGn
 cCOVnNNj+3OWE2e3H0Bs43Elg9y8rJgwc0YJQFi+ZgPcqJLKLJNvlbkcVjNjlf9IJ6BoCTYKIsR
 KTeThF0yk54Oz42BrMrwZsMn9kGWZ6PMiR71aXSRzj1xoc6FC3i+pqDn+NQaASSPnKZeA4jYOn3
 QIZPNnDGkTc3J9oRrYJMqMDQHVypJEYK4T9XtUgIP3+jF2Q6jB/+d/uHH64KUjCMC4G7o2oOF8b
 uhsMGCvNX3QjZ6F6OAJknh+wjHZLv0KeGEZw1NSpM9G4jeZ+tT9nIo3IT4/QcKTAEDVL8x/vWJs
 L2IZobE4z+NbJVI8rQpybTAzF31WY9Q43VsQAxm7YWf31+N/JMMaZQI+cHA8QjVUqORGxPh5NF4
 PLyPh+YRxtUmA8cF+csHQ=
X-Received: by 2002:a05:6820:821:b0:65d:141d:9e0b with SMTP id
 006d021491bc7-6611897dc46mr372339eaf.41.1768518248336; 
 Thu, 15 Jan 2026 15:04:08 -0800 (PST)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-661187a0000sm394787eaf.14.2026.01.15.15.04.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 15:04:07 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: thinhn@synopsys.com, neil.armstrong@linaro.org, quic_varada@quicinc.com,
 felipe.balbi@linux.intel.com, mkorpershoek@kernel.org, lukma@denx.de,
 trini@konsulko.com, marex@denx.de, macromorgan@hotmail.com
Subject: [PATCH V2 3/4] usb: dwc3: gadget: Don't send unintended link state
 change
Date: Thu, 15 Jan 2026 17:01:34 -0600
Message-ID: <20260115230135.183158-4-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115230135.183158-1-macroalpha82@gmail.com>
References: <20260115230135.183158-1-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

DCTL.ULSTCHNGREQ is a write-only field. When doing a read-modify-write
to DCTL, the driver must make sure that there's no unintended link state
change request from whatever is read from DCTL.ULSTCHNGREQ. Set link
state change to no-action when the driver writes to DCTL.

Note that this patch was submitted upstream in Linux in 2020 [1],
and I've confirmed I need it in U-Boot to enable gadget mode.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/patch/drivers/usb/dwc3?id=5b738211fb59e114727381d07c647a77c0010996

Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/usb/dwc3/gadget.c | 16 +++++++---------
 drivers/usb/dwc3/gadget.h | 14 ++++++++++++++
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index d2ae892d554..24ae0c232f6 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -62,7 +62,7 @@ int dwc3_gadget_set_test_mode(struct dwc3 *dwc, int mode)
 		return -EINVAL;
 	}
 
-	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+	dwc3_gadget_dctl_write_safe(dwc, reg);
 
 	return 0;
 }
@@ -1422,7 +1422,7 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
 		dwc->pullups_connected = false;
 	}
 
-	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+	dwc3_gadget_dctl_write_safe(dwc, reg);
 
 	do {
 		udelay(2000);
@@ -2137,10 +2137,8 @@ static void dwc3_gadget_disconnect_interrupt(struct dwc3 *dwc)
 
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	reg &= ~DWC3_DCTL_INITU1ENA;
-	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
-
 	reg &= ~DWC3_DCTL_INITU2ENA;
-	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+	dwc3_gadget_dctl_write_safe(dwc, reg);
 
 	dwc3_disconnect_gadget(dwc);
 	dwc->start_config_issued = false;
@@ -2189,7 +2187,7 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
 
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	reg &= ~DWC3_DCTL_TSTCTRL_MASK;
-	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+	dwc3_gadget_dctl_write_safe(dwc, reg);
 	dwc->test_mode = false;
 
 	dwc3_stop_active_transfers(dwc);
@@ -2305,11 +2303,11 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 		if (dwc->has_lpm_erratum && dwc->revision >= DWC3_REVISION_240A)
 			reg |= DWC3_DCTL_LPM_ERRATA(dwc->lpm_nyet_threshold);
 
-		dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+		dwc3_gadget_dctl_write_safe(dwc, reg);
 	} else {
 		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 		reg &= ~DWC3_DCTL_HIRD_THRES_MASK;
-		dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+		dwc3_gadget_dctl_write_safe(dwc, reg);
 	}
 
 	dep = dwc->eps[0];
@@ -2417,7 +2415,7 @@ static void dwc3_gadget_linksts_change_interrupt(struct dwc3 *dwc,
 
 				reg &= ~u1u2;
 
-				dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+				dwc3_gadget_dctl_write_safe(dwc, reg);
 				break;
 			default:
 				/* do nothing */
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index f28a9755dcb..e4f5a096956 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -104,4 +104,18 @@ static inline u32 dwc3_gadget_ep_get_transfer_index(struct dwc3 *dwc, u8 number)
 	return DWC3_DEPCMD_GET_RSC_IDX(res_id);
 }
 
+/**
+ * dwc3_gadget_dctl_write_safe - write to DCTL safe from link state change
+ * @dwc: pointer to our context structure
+ * @value: value to write to DCTL
+ *
+ * Use this function when doing read-modify-write to DCTL. It will not
+ * send link state change request.
+ */
+static inline void dwc3_gadget_dctl_write_safe(struct dwc3 *dwc, u32 value)
+{
+	value &= ~DWC3_DCTL_ULSTCHNGREQ_MASK;
+	dwc3_writel(dwc->regs, DWC3_DCTL, value);
+}
+
 #endif /* __DRIVERS_USB_DWC3_GADGET_H */
-- 
2.43.0

