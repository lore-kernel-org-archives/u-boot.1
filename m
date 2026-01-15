Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CAD6D46627
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 22:30:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50BA38398C;
	Thu, 15 Jan 2026 23:28:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tXAAgpGX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DD2480077; Thu, 15 Jan 2026 23:28:49 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D1AE82BF2
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 23:28:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7cfcb46ffc9so1408012a34.0
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 14:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768516126; x=1769120926; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oOWCCwjaVGxWr1ZFNsxCfFMmbUvikeWRZv+Ju+HMOm0=;
 b=tXAAgpGXbOAC5hVWB+oXO0F0jmOfc7f4kHilR6nWLUzyupQ2/FHX15DOknYlBR6DkY
 S5ZUvHovrjFGpjYLESlwz0kBXqEC+ivgOT2tmglEiT987T0FQWCTY21yey8u4Q37cdH9
 moGnQyD3yprs5I7ym7DTnkixs58z0QERGSdag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768516126; x=1769120926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oOWCCwjaVGxWr1ZFNsxCfFMmbUvikeWRZv+Ju+HMOm0=;
 b=VSXiY/W2WC7rB+NcoCwle6vVe0ACzNP0VbLrWUJhm/7VC33ArELIzSwhXkyPQktbxE
 i68EIqeM8FUGNDnbXmFd4DsA+amcnWtl9Hb+lguG9nKyakMdGZm9WcKuz7DsFsNFB3Xq
 huVgDo5fb1kUJsBkruEiYjFuHAOt76QNMHQtpxKLa+9HTzUiso30AoariECzUmTeUY2l
 vkOzD19/LoCc3IIjZWlPJvBdWmCZtq1nxCqDEwnu9ddvYnAm/AE5AcuQjA7q783gWI2V
 pQ7roY6vrlbhJKklXQS5awYdPyBhtneH5+x2tpfvvRblRT82SAmSTgNN7CZHdmMVnr1L
 DQ7w==
X-Gm-Message-State: AOJu0Yw1zPj+gAUefAJgSABelv52ZLhQtzXsT7tdv0CbJWOv8sHAr+Xm
 81mC2fAZxtv5n9VKFWKH0x1mnfQJy/baoWXgBvP5HxepB5+XvbQSA3yOBDdDfn/ca9yU7gUSmPo
 eXOFyqB0=
X-Gm-Gg: AY/fxX7uTq71/NBknU9F5ngPalu0Ga9S4nYOJyyD/om0gb2jgG4/eJxkL+fyLM0nBgO
 Vo/+iEkqyQOw1ZaKHIeVpX8R62TFRHJILlXjmtITq6f5j79h+nddz+gPOZrRucLbrJ2DI8kM6iq
 XoCqS6JbPW7rTagCFMf1F7GKkjl/z3gUUDN62kVm+1/3DSgiKLj70dwg8YlWhjqhmaWdlyyKaoN
 8Vs3a95lUpD0TOk9lIe+uh0APYPFzz2Ze3NjLb9uc6Bk077QDR17XwysOjZI4EgDPrnapE9y2TS
 aZkV8l1idt4WBWqXHRYyAOfzOA7UV0I0w0WCJWRjw3kYh8wpQqB8Sgu83ND3vJZTvauEd2B2Ltl
 DP77yT0PgvzSod0g/sgYy+FfbdeE5XqkHmYjvJ1map4MrN3+GRgoP3cyQ8J3flejNQFNMl823qL
 beH3dZYsI8dUHHJZmZo1qtZuKFXnLfm78RMN7YVdSEfteqjkic8Gx535/+8u5nnzlV7H0bTz0nj
 AyuCn8jY1z9u78etchYCP13yA73GV1pylJOfQdPu+qYwVmc2O+R
X-Received: by 2002:a05:6830:913:b0:7ce:519d:1089 with SMTP id
 46e09a7af769-7cfdede19e4mr573292a34.9.1768516123699; 
 Thu, 15 Jan 2026 14:28:43 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf2b5aaesm544074a34.31.2026.01.15.14.28.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 14:28:43 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Beleswar Padhi <b-padhi@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 09/10] sandbox: Update linker scripts to ensure appended
 device tree is aligned
Date: Thu, 15 Jan 2026 16:19:39 -0600
Message-ID: <20260115222828.3931345-10-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115222828.3931345-1-trini@konsulko.com>
References: <20260115222828.3931345-1-trini@konsulko.com>
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

With commit 0535e46d55d7 ("scripts/dtc: Update to upstream version
v1.7.2-35-g52f07dcca47c") it is now a fatal error to U-Boot if our
device tree is not 8-byte aligned. In commit f613a6e15ef7 ("ARM: OMAP2+:
Pad SPL binary to 8-byte alignment before DTB") Beleswar Padhi explains
that we must have ALIGN(x) statements inside of a section to ensure that
padding is included and not simply that the linker address counter is
incremented. To that end, this patch:
- Aligns the final section before _image_binary_end (for xPL phases) by
  8-bytes by adding '. = ALIGN(8);' to the final section before the
  symbol.
- Ensure that we do have alignment by adding an ASSERT so that when not
  aligned we fail to link (and explain why).

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
---
 arch/sandbox/cpu/u-boot-spl.lds | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/sandbox/cpu/u-boot-spl.lds b/arch/sandbox/cpu/u-boot-spl.lds
index a81d66a6f2e8..bd5a164b8c95 100644
--- a/arch/sandbox/cpu/u-boot-spl.lds
+++ b/arch/sandbox/cpu/u-boot-spl.lds
@@ -25,9 +25,13 @@ SECTIONS
 		*(_u_boot_sandbox_getopt_start)
 		KEEP(*(_u_boot_sandbox_getopt))
 		*(_u_boot_sandbox_getopt_end)
+		. = ALIGN(8);
 	}
 
 	_image_binary_end = .;
 }
 
 INSERT AFTER .data;
+
+ASSERT(_image_binary_end % 8 == 0, \
+       "_image_binary_end must be 8-byte aligned for device tree");
-- 
2.43.0

