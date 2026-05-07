Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F8D4CD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 09:32:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E741984AAE;
	Thu,  7 May 2026 11:29:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="X4ZjdK3C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0B7984A78; Thu,  7 May 2026 11:29:48 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E348784AA1
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 11:29:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-38e7b0903cdso4896751fa.3
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 02:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778146177; x=1778750977; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3h4s24RiWpBaFjphknwOfFcngsEkDTENKEHomejF7v4=;
 b=X4ZjdK3CV04CwT3PnOslnweZPMLG9Ufm7rH0VJefd7hMI5HYB4U8H23X2ovQ4cYtsZ
 QjKdCF0esZHXdX678TjygnfbZ5nvp3nwnlSwl/47cww8S62Wx/qjmUbmiB5lYc0gEAmE
 UwUFmvMG+gb3FjXpF2yymB5HD0I0wn7PQt8c4G1Zf7+sW8ImEkPhnNX0FkY6AXZd3U0F
 w7DWkrfKvmdHaFpT1dHjwnLct+rfzOSl9IvqrCXARZRujzzIs0JOvI20lL32X02txMeG
 s+uIIL/zUAD1zQ+MkVDniW80yxWIaKR9CnnLip3mEB5cElWc1tZQMcubYevbEbPKV3En
 hL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778146177; x=1778750977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3h4s24RiWpBaFjphknwOfFcngsEkDTENKEHomejF7v4=;
 b=Yb813eTKpKiT0mlb6XsD80zKL1H+RL10DC+xXmdE43rXtg0Sa8QYyApQOf4Q8RHbW9
 Ok2J/YYGYCgwVF0Us+jLErF6eHKXwRrCTVaDVXH8+rBEQ+4hNfsShxL9n7YVxteXmJ0I
 GHFVYdt199vvfX59vLRExdBeIQ6N7n3vORj9l06xK6eJJvaRD2KOvgzjx6nV+XO8Dd9a
 ymBUnKIDg2OEn9YT9b4T94pnaxuF0AhFQA/7k4K7Jf9NsBWzz1rJtH+5FhXdHNt2Qp3o
 iyvNfxqXyYAT596bcXL3YFw26Kerel0DluvwMicPUXlWNGP0js9m4UFv4BPwQZTyTOqM
 7oSg==
X-Gm-Message-State: AOJu0YwtvCfSDpOr0DLG5p/6Xx+Q89Tk6VHT3JmLlNl7eAxM/3bs+JT4
 BhrLCELx4qTvKSVrly9i6ov0lcXq+fB8QieNAPzUBNsnJsm1uYwf0QNDAvWKYfzUkDXHj2YGrH7
 mS3eVryFImA==
X-Gm-Gg: AeBDievvlM53pZqwR0AeJYVcfeTf8qPA/mcPp5IWs4Ua44aE7gON1bIivTlOi3KNa9+
 bVj5Bd4JzKwcHOaZ1UYilmQUAD6AoPx53BDIYgrnKaWwNgUEOSZrpNkZITG4LsJEgWtotmETC9x
 jTsrYLxGeeDwa6dVqNA3JvkU1Uzkfm75a1CJVy1XgKC9oR5YiBrIhBTT4FXn4+3q6k2OcD45CwR
 cz2L4EBRHQQLhzFF1rPjnVehklUN+WyVQezno2fpmqA5s/VEiH9M0E0z8O3du4HeFfs5UmTUUY7
 Pn6mX8vF97vBacedH+nhOBhKsP9acqthxdCWN6VUlTcuwu1rFUQk58SfkaXdSYuAPOQWQ/AiA4h
 kiOjKpbvWdxu/C7syi64vhLYOJqtsTnIZJqPAmtb9ajgxpEbLULRcXq9PXpKR+IBBRhLlAtrUBj
 v1rObo1zAnP1mN8yWxU9HYcvFwm/c1FAMK68fyMX9581k9stpZ5zIyweW4TjzsXMN5r0sMog9J7
 zWLRPzPL+hw29x6Bf7DDMVVZnifXB2yxfakCXmNGg==
X-Received: by 2002:a05:6512:1391:b0:5a8:6d98:df26 with SMTP id
 2adb3069b0e04-5a887adfcc3mr3012156e87.13.1778146177081; 
 Thu, 07 May 2026 02:29:37 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8914953d6sm696937e87.73.2026.05.07.02.29.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:29:36 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: u-boot@lists.denx.de,
	Marek Vasut <marex@denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Anshul Dalal <anshuld@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ion Agorria <ion@agorria.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Ryder Lee <ryder.lee@mediatek.com>,
 Simon Glass <sjg@chromium.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Zixun LI <admin@hifiphile.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [RFC PATCH v2 17/64] usb: dwc3: import from kernel v4.14
Date: Thu,  7 May 2026 11:27:24 +0200
Message-ID: <20260507092843.358908-18-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507092843.358908-1-jens.wiklander@linaro.org>
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
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

Sync Linux kernel dwc3 changes from v4.13 to v4.14.

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

List of commits: git log --oneline v4.13..v4.14
Commits imported:
b24413180f56 License cleanup: add SPDX GPL-2.0 license identifier to files with no license
c3cdce45f8d3 usb: dwc3: of-simple: Add compatible for Spreadtrum SC9860 platform
551684708356 usb: dwc3: ep0: fix DMA starvation by assigning req->trb on ep0
34a003674825 Merge tag 'usb-for-v4.14' of git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-next
e7059ef82a22 usb: dwc3: of-simple: remove include of clk-provider.h
feea468014f0 Merge 4.13-rc5 into usb-next
95aa932c93d2 usb/dwc3:constify dev_pm_ops
c14af973ed86 usb: dwc3: keystone: Add PM_RUNTIME Support to DWC3 Keystone USB driver
0ae99ecba792 usb: dwc3: omap: fix error return code in dwc3_omap_probe()
8bcd9889721f usb: dwc3: pci: constify dev_pm_ops
141769851cb7 Merge 4.13-rc2 into usb-next

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/usb/dwc3/ep0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 827e376bfa97..75e6cb044eb2 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -990,6 +990,8 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 					 DWC3_TRBCTL_CONTROL_DATA,
 					 true);
 
+		req->trb = &dwc->ep0_trb[dep->trb_enqueue - 1];
+
 		/* Now prepare one extra TRB to align transfer size */
 		dwc3_ep0_prepare_one_trb(dep, dwc->bounce_addr,
 					 maxpacket - rem,
@@ -1015,6 +1017,8 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 					 DWC3_TRBCTL_CONTROL_DATA,
 					 true);
 
+		req->trb = &dwc->ep0_trb[dep->trb_enqueue - 1];
+
 		/* Now prepare one extra TRB to align transfer size */
 		dwc3_ep0_prepare_one_trb(dep, dwc->bounce_addr,
 					 0, DWC3_TRBCTL_CONTROL_DATA,
@@ -1029,6 +1033,9 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 		dwc3_ep0_prepare_one_trb(dep, req->request.dma,
 				req->request.length, DWC3_TRBCTL_CONTROL_DATA,
 				false);
+
+		req->trb = &dwc->ep0_trb[dep->trb_enqueue];
+
 		ret = dwc3_ep0_start_trans(dep);
 	}
 
-- 
2.43.0

