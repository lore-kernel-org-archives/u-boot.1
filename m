Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615FA606A31C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iRCfWNSM;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PubZOBCo
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1218D810B4;
	Wed, 28 Oct 2026 14:48:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M6K69x-08Dq9; Wed, 28 Oct 2026 14:48:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8B4F3810FC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198830;
	b=qk8t4TIeMFuqjxxDKazuKUqdmMbahNVz2xzXB5dzA4iSHbPquzRqYO1FWtRvkKcv6sNp
	 qpvVp3+LrTqaiDQpsrD9dbIXF9Dh4VlvQDKOUvswEodQLIwTgLbLVU9oFnR7uHcNL/KoM
	 g+xIDvXWk6XI3NlrUl2OIvQjmPdCco9Y06EKF9CAXHKApZNR3ZcqmOSvzOyi0Z1yhgrQZ
	 5tyVTMZ+OzQW19E8QB3MqTtbQKXh3DySWBKTgMSWgrVrWLn5y0rJqrzp8nGV4jE0dw4kl
	 K3iE3CdqBQRIP15UMhw3jVEUgZRcxP0FhvhEdeYFG6f5/WMdHbOZCtaCRrNOCQJIAbw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198830;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=DVzKi6aMWqLuHZ3eJsv9V0Jj2utiO5NTM8DRjoAD4Ps=;
	b=qWmEZRRiPeGciXhFXymK8ENLGfs7uUAG0LY77f4ebkFY1D0bVyzjDhQ9bZkK1F3zBwjv
	 vB+2Up3vO7IHOT5pZiXEajmKeF5C0bHUxncW20fI9ociAv5WKEF/Hohlf1ySkidlVzgyd
	 AKMPpD1rK3adkPL9rTfdIiJs9QLkYXpjCzakNu7RZr10/j2oOzKCm9DEB8i6FWq62IPa9
	 UIC42ENHizdrpPLLmdFOgio3EPJGcDUgCuPc1f+GlxYN0M2BW0ZsSAMLAF3lWq5PFoveI
	 i+LKiC3vw3kTgaK7mTkF29dtq85qrpzd8htOtDfUAJqteUBHidN1mAtpbQBSTM1GHAQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198830;
	bh=DVzKi6aMWqLuHZ3eJsv9V0Jj2utiO5NTM8DRjoAD4Ps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iRCfWNSMoF+ze0znxt8Fwwyr3csdNa55dYuapl9q2A+pP1DRwvL2xxi0TLzIDBFLQ
	 ydLroY6wAxcB9Az1HMKw9YJ7tCSk+dLO+n5MaCRndPFQcAzCC3QXTQ03kmEmotdsg6
	 yiEe2Zam+l0ZApOesLYWlCsoz3c4vfLjOZ/fHK8EIf7P1jcC0J9m7anLRbtu3RiJU3
	 3K31tvxLyQRYD6bLzZ5FizvAex/dHi68+zMa5p2VDMck6dnTZ8D0NzWY4UcF75d2cW
	 3BTODh7hZjSLO6AuDp9qwEFB9e+lBtfppl3f1FVCXxrsDUl2rzTfJ73Ib8rm1Jx2rj
	 GVbDO+5PDe43w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8B4F3810FC;
	Wed, 28 Oct 2026 14:47:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 237C9972
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:13:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 158594008A
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:13:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BrbS4Z8WKzUo for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:13:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AA9444009E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::634"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196795;
 b=fDF4QWEC6KxhI0vrin0Jlno2G87E4cDgp1wr8h+AkUYNtEbSBFWFAcs+Hf3Rspn9G9yG
 o1XFZkKA27AKcyVv7Ax6C2WNAgu7gC25X3L7M90pPA2sDVkeiuItSEliwnAol6bcsWd9V
 2u+O40CNYMQIBOIIjeCquSF32Z/U0FLvmnXDgn8itSfR4vRBBdAwMNoQzLzDsIPHV1OQU
 x3PaBNkIlkUKp3nXPTrtFhpGim4Q/Hq9mDmzjWmjJy0kq3aEA87IspTU/+tzSpbfrpa2W
 jl23JfWhyQbMD4kVu767139M+xDyHHlSZi+rnSChlKn4/mWf9Qx6Beni9nQBQ6cGcGQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196795;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=DVzKi6aMWqLuHZ3eJsv9V0Jj2utiO5NTM8DRjoAD4Ps=;
 b=WglY/iAuBcHwGiFN4yMrwGC3pM+d/EpE++C5fckSmbyCn+WfsRuUgiIaGl+lkdkABg6H
 aSusdd4WWlZCGWt72BecIWoxFId6nswiNM3a0FNBbyCqBabB4Kq/jYj/qSPS5wS607iPu
 rToZeOjYm4P+SRxKCx5q4+6MIkp8k8doIdaIxehfod8eP+0VHv2fBZcA+rYfshXS8mSbm
 Bt7KdgOpwTlODGnffzr0OD4MtsFDHjcqtWkv2aUs6RiP801LCIoNNa7UnGGbEKm+PMHDI
 DVPLumcWbxpLY6aiOIktH5omclffQ075q5PdfOmTMkuGWrDqnlgGVJaPJDAnKBOB9Uw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=PubZOBCo; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::634"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=PubZOBCo
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AA9444009E
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:13:14 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c3fae9338f0so10596266b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196792; x=1793801592;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DVzKi6aMWqLuHZ3eJsv9V0Jj2utiO5NTM8DRjoAD4Ps=;
 b=PubZOBCogPgCs7La6z6Ar9EU65wZBxEM+lBtNOBSQPgF2ABK03fNU+5Gx3UO5BlGWK
 lvvKWCoRLtNb/ntdF5HsyqIhgpnlT+RixDVGwWMREvTrV87FOxV3RWwAeSIaDQ35/1Xa
 Xq4OiboJnGIT+AtqO3UTeg87dMHf3PeNYOG+5GKqVF6C7MIQrnl541IxdvKdf0hzP8ag
 Y5aHnAe8Ot4XiUE40sq49KkkKWHgnRUEy/WD4riWjgLu2Masfcc/idMACNpz7+Hegxf7
 VILqZ6bYxgi4F20zaywwFNuWO/WWZ3fUk0G68jcJyTOkCI2lt+tqAaheWH+kf6GYrwUa
 XL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196792; x=1793801592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DVzKi6aMWqLuHZ3eJsv9V0Jj2utiO5NTM8DRjoAD4Ps=;
 b=FF+fV/W8RM5OzRFm2asbRTchjh/19PoV+e7Tbpdo61ooOD/p4FP7Tt65cGO40VWt+7
 2FdDQ+xfXyWfNyJxscMu96J5iOdOfKoss9PJoEWSHMPykcz/4pSLHVDohiEBNt8GFbaI
 2kRGOILnSzeNIYufWVRokwavNn+uB0nYOdzMkk4SyNrz4rteKdBN+3+sa3O7titSIiKC
 FvA7j2Fc11tffU8ZyaQ33AtVSeRe2/Y+mDDmWGaoi8igOhEIKt4YS+qqXBOFwOiwXksi
 4i676z9etEAxSW+R0Q/Xt38ntEg3TJJfLmE672Q2oeIZKt0H4Qzqdk4Xton3CiW2weqP
 DpVA==
X-Gm-Message-State: AFq9FYJMfWUveQGRB/ak+r64CzwAUKfa72l5VwFZ+1oLdQ/1nTC3B3z4
 vBNoEmZw+yXPwze9YDI+b+IJOQzvGaPfFiVA3hk38JkN65p6Yx9CkjsniX76QJF3/NMqf35sLxE
 3yjki
X-Gm-Gg: AYBFou3GPYCVEI2pNhG2yLcJfdnehjLTWKJ6TN549vel+5CE4FnCDmrMwyuW4/ySLmf
 SdrLjw8SKAoBKuM4qClzLhoNL2V6W6UGPJeroA3X6D4q626nnN8v6V3PnXUxOQ16l2O57Id8yk6
 isgt6QjM82krOuc9nvGUQXCUkQ+n/ukgnxZEm69A0tUReBDIUg3meQ5eVNQH4Sdv4lMt4jpiAFs
 JQPlULf09eFkGUUXkDOrDw+q4PglogDK17GllbkolbcgDVEBD0HHb5n7ytair9UjJRi9RL9Voy2
 jAt+ox/8pS67710nlfGxO/lt95qXvCqk6OBL8+dIQPwpqbb+RWa2qNiUw0/pTtT34ls0YAQiaOj
 +3iWrQJ7cPQ1D0Qg3eURagAxlD1WpLC1mAcHVmH2iszgurw9p+VkWS1MnJK+KnYeGe4s0E5Zh/n
 5k6CryZULvGRatD0WZ8M7DCcv3eNiEH4kwMlEG2q+lpz6F+SlDjsdXsunSwNuGINk6yR4FTaigt
 M9+wL+qTBSW5Mo3uhHOAmmhcCa+HRV5Pjl/xQ18uPxbP21zO7zuRA4kHd9HSBcYgo/ApHiLfPTF
 I72gvhvjhKwjjpNa8bduyjEOBQKTzsCa3gC82g2mUSl6flMocaSg8bvEirxyshNVJWME7u6lpqu
 IplAMLJWp0Az74nUr7wj7fsrFa58iiXw=
X-Received: by 2002:a17:907:180b:b0:c25:2ded:ad36 with SMTP id
 a640c23a62f3a-c49bda65ea2mr309529066b.0.1793196792097; 
 Wed, 28 Oct 2026 07:13:12 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd350c61sm612006966b.11.2026.10.28.07.13.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:13:11 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 41/63] usb: dwc3: import from kernel v5.16
Date: Wed, 28 Oct 2026 15:09:07 +0100
Message-ID: <20261028140930.3025368-42-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028140930.3025368-1-anders.roxell@linaro.org>
References: <20261028140930.3025368-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 14:45:46 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jens Wiklander <jens.wiklander@linaro.org>

Sync Linux kernel dwc3 changes from v5.15 to v5.16.

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

List of commits: git log --oneline v5.15..v5.16
Commits imported:
47ce45906ca9 usb: dwc3: leave default DMA for PCI devices
26288448120b usb: dwc3: gadget: Fix null pointer exception
63c4c320ccf7 usb: dwc3: gadget: Check for L1/L2/U3 for Start Transfer
d74dc3e9f58c usb: dwc3: gadget: Ignore NoStream after End Transfer
250fdabec6ff usb: dwc3: core: Revise GHWPARAMS9 offset
d1a4683747fe usb: dwc3: Align DWC3_EP_* flag macros
876a75cb520f usb: dwc3: gadget: Skip resizing EP's TX FIFO if already resized
b851f7c7b8fd usb: dwc3: gadget: Change to dev_dbg() when queuing to inactive gadget/ep
8217f07a5023 usb: dwc3: gadget: Avoid starting DWC3 gadget during UDC unbind
7bee31883889 usb: dwc3: reference clock period configuration

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c   | 37 ++++++++++++++++++++++++---
 drivers/usb/dwc3/core.h   | 27 +++++++++++++-------
 drivers/usb/dwc3/gadget.c | 53 ++++++++++++++++++++++++++++-----------
 3 files changed, 90 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 0104a80b185e..f4c09951b517 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -26,6 +26,7 @@
 #include <linux/acpi.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/reset.h>
+#include <linux/bitfield.h>
 
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
@@ -335,6 +336,29 @@ static void dwc3_frame_length_adjustment(struct dwc3 *dwc)
 	}
 }
 
+/**
+ * dwc3_ref_clk_period - Reference clock period configuration
+ *		Default reference clock period depends on hardware
+ *		configuration. For systems with reference clock that differs
+ *		from the default, this will set clock period in DWC3_GUCTL
+ *		register.
+ * @dwc: Pointer to our controller context structure
+ * @ref_clk_per: reference clock period in ns
+ */
+static void dwc3_ref_clk_period(struct dwc3 *dwc)
+{
+	u32 reg;
+
+	if (dwc->ref_clk_per == 0)
+		return;
+
+	reg = dwc3_readl(dwc->regs, DWC3_GUCTL);
+	reg &= ~DWC3_GUCTL_REFCLKPER_MASK;
+	reg |=  FIELD_PREP(DWC3_GUCTL_REFCLKPER_MASK, dwc->ref_clk_per);
+	dwc3_writel(dwc->regs, DWC3_GUCTL, reg);
+}
+
+
 /**
  * dwc3_free_one_event_buffer - Frees one event buffer
  * @dwc: Pointer to our controller context structure
@@ -1007,6 +1031,9 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	/* Adjust Frame Length */
 	dwc3_frame_length_adjustment(dwc);
 
+	/* Adjust Reference Clock Period */
+	dwc3_ref_clk_period(dwc);
+
 	dwc3_set_incr_burst_type(dwc);
 
 	usb_phy_set_suspend(dwc->usb2_phy, 0);
@@ -1389,6 +1416,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 				    &dwc->hsphy_interface);
 	device_property_read_u32(dev, "snps,quirk-frame-length-adjustment",
 				 &dwc->fladj);
+	device_property_read_u32(dev, "snps,ref-clock-period-ns",
+				 &dwc->ref_clk_per);
 
 	dwc->dis_metastability_quirk = device_property_read_bool(dev,
 				"snps,dis_metastability_quirk");
@@ -1565,9 +1594,11 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	dwc3_get_properties(dwc);
 
-	ret = dma_set_mask_and_coherent(dwc->sysdev, DMA_BIT_MASK(64));
-	if (ret)
-		return ret;
+	if (!dwc->sysdev_is_parent) {
+		ret = dma_set_mask_and_coherent(dwc->sysdev, DMA_BIT_MASK(64));
+		if (ret)
+			return ret;
+	}
 
 	dwc->reset = devm_reset_control_array_get_optional_shared(dev);
 	if (IS_ERR(dwc->reset))
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 5612bfdf37da..5c491d0a19d7 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -143,7 +143,7 @@
 #define DWC3_GHWPARAMS8		0xc600
 #define DWC3_GUCTL3		0xc60c
 #define DWC3_GFLADJ		0xc630
-#define DWC3_GHWPARAMS9		0xc680
+#define DWC3_GHWPARAMS9		0xc6e0
 
 /* Device Registers */
 #define DWC3_DCFG		0xc700
@@ -387,6 +387,10 @@
 #define DWC3_GFLADJ_30MHZ_SDBND_SEL		BIT(7)
 #define DWC3_GFLADJ_30MHZ_MASK			0x3f
 
+/* Global User Control Register*/
+#define DWC3_GUCTL_REFCLKPER_MASK		0xffc00000
+#define DWC3_GUCTL_REFCLKPER_SEL		22
+
 /* Global User Control Register 2 */
 #define DWC3_GUCTL2_RST_ACTBITLATER		BIT(14)
 
@@ -711,21 +715,22 @@ struct dwc3_ep {
 
 	u32			saved_state;
 	unsigned int		flags;
-#define DWC3_EP_ENABLED		BIT(0)
-#define DWC3_EP_STALL		BIT(1)
-#define DWC3_EP_WEDGE		BIT(2)
-#define DWC3_EP_TRANSFER_STARTED BIT(3)
-#define DWC3_EP_END_TRANSFER_PENDING BIT(4)
-#define DWC3_EP_PENDING_REQUEST	BIT(5)
-#define DWC3_EP_DELAY_START	BIT(6)
+#define DWC3_EP_ENABLED			BIT(0)
+#define DWC3_EP_STALL			BIT(1)
+#define DWC3_EP_WEDGE			BIT(2)
+#define DWC3_EP_TRANSFER_STARTED	BIT(3)
+#define DWC3_EP_END_TRANSFER_PENDING	BIT(4)
+#define DWC3_EP_PENDING_REQUEST		BIT(5)
+#define DWC3_EP_DELAY_START		BIT(6)
 #define DWC3_EP_WAIT_TRANSFER_COMPLETE	BIT(7)
 #define DWC3_EP_IGNORE_NEXT_NOSTREAM	BIT(8)
 #define DWC3_EP_FORCE_RESTART_STREAM	BIT(9)
 #define DWC3_EP_FIRST_STREAM_PRIMED	BIT(10)
 #define DWC3_EP_PENDING_CLEAR_STALL	BIT(11)
+#define DWC3_EP_TXFIFO_RESIZED		BIT(12)
 
 	/* This last one is specific to EP0 */
-#define DWC3_EP0_DIR_IN		BIT(31)
+#define DWC3_EP0_DIR_IN			BIT(31)
 
 	/*
 	 * IMPORTANT: we *know* we have 256 TRBs in our @trb_pool, so we will
@@ -970,6 +975,7 @@ struct dwc3_scratchpad_array {
  * @regs: base address for our registers
  * @regs_size: address space size
  * @fladj: frame length adjustment
+ * @ref_clk_per: reference clock period configuration
  * @irq_gadget: peripheral controller's IRQ number
  * @otg_irq: IRQ number for OTG IRQs
  * @current_otg_role: current role of operation while using the OTG block
@@ -1027,6 +1033,7 @@ struct dwc3_scratchpad_array {
  * @tx_fifo_resize_max_num: max number of fifos allocated during txfifo resize
  * @hsphy_interface: "utmi" or "ulpi"
  * @connected: true when we're connected to a host, false otherwise
+ * @softconnect: true when gadget connect is called, false when disconnect runs
  * @delayed_status: true when gadget driver asks for delayed status
  * @ep0_bounced: true when we used bounce buffer
  * @ep0_expect_in: true when we expect a DATA IN transfer
@@ -1149,6 +1156,7 @@ struct dwc3 {
 	struct power_supply	*usb_psy;
 
 	u32			fladj;
+	u32			ref_clk_per;
 	u32			irq_gadget;
 	u32			otg_irq;
 	u32			current_otg_role;
@@ -1246,6 +1254,7 @@ struct dwc3 {
 	const char		*hsphy_interface;
 
 	unsigned		connected:1;
+	unsigned		softconnect:1;
 	unsigned		delayed_status:1;
 	unsigned		ep0_bounced:1;
 	unsigned		ep0_expect_in:1;
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 4519d06c9ca2..7e3db00e9759 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -310,13 +310,24 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 	if (DWC3_DEPCMD_CMD(cmd) == DWC3_DEPCMD_STARTTRANSFER) {
 		int link_state;
 
+		/*
+		 * Initiate remote wakeup if the link state is in U3 when
+		 * operating in SS/SSP or L1/L2 when operating in HS/FS. If the
+		 * link state is in U1/U2, no remote wakeup is needed. The Start
+		 * Transfer command will initiate the link recovery.
+		 */
 		link_state = dwc3_gadget_get_link_state(dwc);
-		if (link_state == DWC3_LINK_STATE_U1 ||
-		    link_state == DWC3_LINK_STATE_U2 ||
-		    link_state == DWC3_LINK_STATE_U3) {
+		switch (link_state) {
+		case DWC3_LINK_STATE_U2:
+			if (dwc->gadget->speed >= USB_SPEED_SUPER)
+				break;
+
+			fallthrough;
+		case DWC3_LINK_STATE_U3:
 			ret = __dwc3_gadget_wakeup(dwc);
 			dev_WARN_ONCE(dwc->dev, ret, "wakeup failed --> %d\n",
 					ret);
+			break;
 		}
 	}
 
@@ -702,6 +713,7 @@ void dwc3_gadget_clear_tx_fifos(struct dwc3 *dwc)
 				   DWC31_GTXFIFOSIZ_TXFRAMNUM;
 
 		dwc3_writel(dwc->regs, DWC3_GTXFIFOSIZ(num >> 1), size);
+		dep->flags &= ~DWC3_EP_TXFIFO_RESIZED;
 	}
 	dwc->num_ep_resized = 0;
 }
@@ -747,6 +759,10 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
 	if (!usb_endpoint_dir_in(dep->endpoint.desc) || dep->number <= 1)
 		return 0;
 
+	/* bail if already resized */
+	if (dep->flags & DWC3_EP_TXFIFO_RESIZED)
+		return 0;
+
 	ram1_depth = DWC3_RAM1_DEPTH(dwc->hwparams.hwparams7);
 
 	if ((dep->endpoint.maxburst > 1 &&
@@ -807,6 +823,7 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
 	}
 
 	dwc3_writel(dwc->regs, DWC3_GTXFIFOSIZ(dep->number >> 1), fifo_size);
+	dep->flags |= DWC3_EP_TXFIFO_RESIZED;
 	dwc->num_ep_resized++;
 
 	return 0;
@@ -995,7 +1012,7 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
 
 	dep->stream_capable = false;
 	dep->type = 0;
-	dep->flags = 0;
+	dep->flags &= DWC3_EP_TXFIFO_RESIZED;
 
 	return 0;
 }
@@ -1813,7 +1830,7 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 	struct dwc3		*dwc = dep->dwc;
 
 	if (!dep->endpoint.desc || !dwc->pullups_connected || !dwc->connected) {
-		dev_err(dwc->dev, "%s: can't queue to disabled endpoint\n",
+		dev_dbg(dwc->dev, "%s: can't queue to disabled endpoint\n",
 				dep->name);
 		return -ESHUTDOWN;
 	}
@@ -2418,7 +2435,7 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 	int			ret;
 
 	is_on = !!is_on;
-
+	dwc->softconnect = is_on;
 	/*
 	 * Per databook, when we want to stop the gadget, if a control transfer
 	 * is still in process, complete it and get the core into setup phase.
@@ -3246,6 +3263,9 @@ static bool dwc3_gadget_endpoint_trbs_complete(struct dwc3_ep *dep,
 	struct dwc3		*dwc = dep->dwc;
 	bool			no_started_trb = true;
 
+	if (!dep->endpoint.desc)
+		return no_started_trb;
+
 	dwc3_gadget_ep_cleanup_completed_requests(dep, event, status);
 
 	if (dep->flags & DWC3_EP_END_TRANSFER_PENDING)
@@ -3293,6 +3313,9 @@ static void dwc3_gadget_endpoint_transfer_in_progress(struct dwc3_ep *dep,
 {
 	int status = 0;
 
+	if (!dep->endpoint.desc)
+		return;
+
 	if (usb_endpoint_xfer_isoc(dep->endpoint.desc))
 		dwc3_gadget_endpoint_frame_from_event(dep, event);
 
@@ -3346,6 +3369,14 @@ static void dwc3_gadget_endpoint_command_complete(struct dwc3_ep *dep,
 	if (cmd != DWC3_DEPCMD_ENDTRANSFER)
 		return;
 
+	/*
+	 * The END_TRANSFER command will cause the controller to generate a
+	 * NoStream Event, and it's not due to the host DP NoStream rejection.
+	 * Ignore the next NoStream event.
+	 */
+	if (dep->stream_capable)
+		dep->flags |= DWC3_EP_IGNORE_NEXT_NOSTREAM;
+
 	dep->flags &= ~DWC3_EP_END_TRANSFER_PENDING;
 	dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
 	dwc3_gadget_ep_cleanup_cancelled_requests(dep);
@@ -3568,14 +3599,6 @@ static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
 	WARN_ON_ONCE(ret);
 	dep->resource_index = 0;
 
-	/*
-	 * The END_TRANSFER command will cause the controller to generate a
-	 * NoStream Event, and it's not due to the host DP NoStream rejection.
-	 * Ignore the next NoStream event.
-	 */
-	if (dep->stream_capable)
-		dep->flags |= DWC3_EP_IGNORE_NEXT_NOSTREAM;
-
 	if (!interrupt)
 		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
 	else
@@ -4352,7 +4375,7 @@ int dwc3_gadget_resume(struct dwc3 *dwc)
 {
 	int			ret;
 
-	if (!dwc->gadget_driver)
+	if (!dwc->gadget_driver || !dwc->softconnect)
 		return 0;
 
 	ret = __dwc3_gadget_start(dwc);
-- 
2.53.0

