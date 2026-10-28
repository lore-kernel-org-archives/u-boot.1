Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1837606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JVDiyuaY;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=I/s/LXl9
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9D53D40709;
	Wed, 28 Oct 2026 14:46:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YcUONk77uPJU; Wed, 28 Oct 2026 14:46:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 35BC040737
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198790;
	b=nQsvtn2rjQWyiTV1TCEoYL1MQAqYiV9GR/TAtVwNy/uWIHm8GzJog7gK/b39l6MArE3g
	 VPqTR81zjlL2JUa3sdOFsVKtG/FFcmRVww4UU/YSnE7ixnUYzrJ+4IgklM51EnT7NTd+G
	 wSJHQpQKywaqYNziWC+NSqirEoVNn862rRnOvT+KI8YKOc4ujlWhEIFoWSNdCEqMdMP5C
	 3B0N1yS2JWSE8+qmg70Oqiwf1VFT2YN10QqPTcFw11Go9QzveOzZfLtFP9zeGxInwk7Yb
	 PXNqXLaFvNWLKe7PEuppI/jT1/C1ZIXsXDhvGiZHF9CI35rPfbegvvF+NUYNMKmitMA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198790;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=7BS/3+wGmNFkvUHiG7e6vYLUPTs1m1z5BEDcH77Agx4=;
	b=fZ3Lvb5abGFCd9aX3acGFewC1RUCQDrAPFV2MkcvD46/5I7aF72YgJGpoXuUVwTL4FCa
	 1DzSsjp27efCUpvtrOpsZcSZl22tz7eCmLKTGEv+cT8FIynZx64UKjaib4w1GcKFGUzFK
	 BO24DqTySXizdfbU6Mg64Dd9jB2hurN/ltjbZXuupl4clGLE0KTmzpaUIuOSWRazbNiFu
	 Qlj7qMYXObyhM1Zq/Tu2dfY3zu/NcojY87Vi8BpaYZZL2k2aavlp0/GzSXez+wK1sxVtH
	 KGgnRJxmKqvQLsr7LaI+Jnz6yqf24/56LN+YeLnWD+C8Ux33KnryE6UPmu15NqKjprA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198790;
	bh=7BS/3+wGmNFkvUHiG7e6vYLUPTs1m1z5BEDcH77Agx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JVDiyuaYOYrZjXXJsvWNH44ejo/YRce1ydWFP+gUrYTrpvwEkxpnVmLsarj/7arSz
	 gv4Ds6fuuMb8Mrm7sQnEyoZ8JtBnT9MtH/JAB/gj2sTEuwBrtrPFgiQr5N3yqMlXVE
	 U7iWskAoiXMAj0mMQ1MIKaRDMWVFD040z4oeTXlo0nk/XkDJ/qCawVUG0JQKg5oFNU
	 bimmmbFE1cfJhlx6XABusTcdFapjNShQ7Vl9Z/94QyYtniMbvxb/5N6VOQon4Vtq2p
	 9Rq31dYdBkD7LPOHmfDnAvgpDVOrwYh/j755fWtJEYXxQqLBRPJdkjPKdxpCipPSY1
	 9miqTGoxcV3Vw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 35BC040737;
	Wed, 28 Oct 2026 14:46:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CF6B0356
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:11:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CCF88400DC
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:11:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NUO18-ql3ygg for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:11:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org BE8FC400DB
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196667;
 b=YwleRT1SvER4HqC7E2nMZSVwTGOTs/c02D2LxIYxndw9GKrmrmStFYVNEEGmA9Xdbhaz
 ncKdXHS/13j9QesDRcB0CKNEqk6eHjMk3qJXcW4qZdxf/anvDkW7hkIiMn/t2tkh0jQpB
 vvAQj6TahFBMyvGT94+++vHXZDauRseRvfT0x8eq9iPrTLwjtMGUyDSMkO+G8aW/ajIVb
 GIbA6Pp82OYQGxbUH3cwwbFqPBmfhE0H1Jimu62Lln9jUtb4atT2DTEp/sKSuDQgejbl7
 BbdlbytVL1M1N6MW9milocLdhFvhxwRnQG1SHejBwamrRMAcQkUcPUCi2Gce9Qe/mKQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196667;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=7BS/3+wGmNFkvUHiG7e6vYLUPTs1m1z5BEDcH77Agx4=;
 b=dRkKJmn7n2GH9k7eyW7nMvfC2iQPL7kVMSZDeYVqtTT1CJ/vT9PUWHE6N8wYpWwF02uT
 /JVhInwBi+Z0Q2lfLisp0XEAtO2vNO8aF4KRaMY4k8JMwaHVOExxPQ/vKPpGMLPfYvCG4
 9GBn1QOy1XXwVRv+kCdi15MSdvzcf0sRNZ9Zm6cpVXuRlP8AXZYbQWVaUI85GCXn+1WQW
 jlp2DLYFtu6JcQ4KR/tyiVqe2kR5weNDjqZLqs12V1G1tk/tFdWvPKHYHdOlNkRidJ3SE
 1GcFEooR6L14M8YJBn1/hHTJ0qpYUfHBlG0imzjTMC51eT0M3qxhZNowIvODZVBJmvA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b="I/s/LXl9"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=I/s/LXl9
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BE8FC400DB
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:11:06 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c347be93d54so11344866b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196664; x=1793801464;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7BS/3+wGmNFkvUHiG7e6vYLUPTs1m1z5BEDcH77Agx4=;
 b=I/s/LXl93n4WNekdwJJ1JPgQ1ndUF3ld7fd+ijssoftseSOm3oCoM0HpkMCBAsYc/v
 if0g2flvvTJLSyUBKWImjB7j2jBEfnRVBxaeCVHDHVbvAbJgXHcJ8FwgEUzD6w+9++cn
 O91UWlcjg5XXqdtMe0uXZ8cWHROX9YjBmZHZh2E21tV9sgKX2srZnQGlFBCuWKc9zg+a
 UNuMe7jwF9zkWZWa60o4aOpkhjyXzHbwgf9BHkpKUWV4ANNJTzywvVigShfPv3SjmhH6
 YiexDTjfdcUbFjtzPK58qfTI9qLZjAbFmBcflRzsLK9rNqW1/0k4Ji3BQ9TB3/UqI0m3
 9twA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196664; x=1793801464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7BS/3+wGmNFkvUHiG7e6vYLUPTs1m1z5BEDcH77Agx4=;
 b=p47XqaI05SP2VTQhbov/l74FNJgic/RnyPc05sjVrIDa5UUD4LKEtJdg/0Ygd97Np4
 eUIbMv8JnSKguWIepv28Rsq+5ej6/domY1sliWqa6lgJLEboSlaB1yJxXNpNOCs4a9kO
 byixsLZwrLHuV0Ih94z9tPT/Upc8xh+1rKYK7atoCUCn0RDZqNIfSIrI/2kK3vrpm8wk
 9FH3B+jq3bDfIGbNqr1a9V7eP3nFmnFCyhjt1jMHhmHiL8bV9LSKfOf5ZMOsYjVq7ROK
 7WCDucmDMjFm6uulcWExIB6HezjrAXbpQE01CfODkOvGJcHLT7NzAV573GbgwBPl6rfl
 Zhjw==
X-Gm-Message-State: AFq9FYJtF1kWaVaFleLV8ujQ2zEMWyCsAx+hzWDrSwS7LnSRGMrc2H5U
 2HbTosFe7IzvO2ufY602hTGA8pIDdVOzBYsiqk2ECPMVS5szk6vdYnYqyA7nHgoqqsK1whjTtbB
 opF/a
X-Gm-Gg: AYBFou1ZCsIIHh2xRIJJk7RjiDdfndi+vSPpJNVFfASugC2BGODv0yHEI7njpzR+58L
 I9uPnYQWzGzkDcbgcxupqAFWbTH4lHzAJzcmYUPr9ZELb5GmRApB/pML860RxOTcFsWQnO/lrfU
 +PT6CNyZBynwH41RmYDo8H6S5o7/3y7L+YP5tY5n+ubmOlnVdvafoPzGZsgpAMIzGRxcBbdS0zA
 t5TptIAnyOwTpd6epTR0P5Ury922N6a/+T8JXbN5oMa8cQMDQavEhy1vRgKwfK9cr0hWxpHNEHV
 0HvlwSqSXL7+D+MSEsciTHL00Xi6bmsPLA3dVF9iWRea5oHemZ6v5NkCMddB2uiJe6Ca+BoFc3/
 L9i/ksSLmkkro27a5J5lkli3wMO5DCk3TLOBEAnYO536M14BMdVfRUr8GnPPfo0OBFOZHtniIeW
 ovkTITf+od2cGGKoqADX9+r8SLXT24USQ6eoqIw8lZSLOAJk63mnr9HW0uT2Yz8kegFM72/pbDK
 +h39G/DMYCb9RjpnDIrliewewbuWkWuOJ0aP1UbE6iFmvNJraelnmKRKcBT7yGp5MOw/JENr4KV
 K3PJduxbtEYpUmOWBcF0198iF2FjbtZNEsOH/Ai0gittV/6YFMYNYqnntmeQXitML5OfGwnQfPn
 SbYuD9hpLdw==
X-Received: by 2002:a17:906:c006:b0:c2e:3698:dbba with SMTP id
 a640c23a62f3a-c49bdf3daf6mr226742566b.4.1793196663692; 
 Wed, 28 Oct 2026 07:11:03 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd64f8c4sm617944566b.47.2026.10.28.07.11.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:11:02 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 19/63] usb: dwc3: import from kernel v4.15
Date: Wed, 28 Oct 2026 15:08:45 +0100
Message-ID: <20261028140930.3025368-20-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v4.14 to v4.15.

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

List of commits: git log --oneline v4.14..v4.15
Commits imported:
ec5bb87e4e2a usb: dwc3: gadget: Fix PCM1 for ISOC EP with ep->mult less than 3
8722e095f5a4 usb: dwc3: gadget: Wait longer for controller to end command processing
b5ea47570b5e USB: dwc3: Remove redundant license text
5fd54ace4721 USB: add SPDX identifiers to all remaining files in drivers/usb/
644cbbc3ab4d usb: dwc3: core: Notify current USB mode to USB3 PHY as well
8eed00b237a2 usb: dwc3: pci: Runtime resume child device from wq
689bf72c6e0d usb: dwc3: Don't reinitialize core during host bus-suspend/resume
86763723eee8 usb: dwc3: ep0: Clean up unused variables
7fdca766499b usb: dwc3: gadget: simplify __dwc3_gadget_kick_transfer() prototype
502a37b98a7b usb: dwc3: gadget: cache frame number in struct dwc3_ep
64e010802997 usb: dwc3: gadget: simplify __dwc3_gadget_ep_queue()
ccb94ebf9e65 usb: dwc3: gadget: check for lack of TRBs a bit earlier

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c   | 74 +++++++++++++++-----------------------
 drivers/usb/dwc3/core.h   | 12 ++-----
 drivers/usb/dwc3/debug.h  | 10 +-----
 drivers/usb/dwc3/ep0.c    | 30 +---------------
 drivers/usb/dwc3/gadget.c | 76 ++++++++++++---------------------------
 drivers/usb/dwc3/gadget.h | 10 +-----
 drivers/usb/dwc3/io.h     | 10 +-----
 7 files changed, 59 insertions(+), 163 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 03474d3575ab..07832509584f 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /**
  * core.c - DesignWare USB3 DRD Controller Core file
  *
@@ -5,18 +6,6 @@
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2  of
- * the License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <linux/version.h>
@@ -156,9 +145,8 @@ static void __dwc3_set_mode(struct work_struct *work)
 		} else {
 			if (dwc->usb2_phy)
 				otg_set_vbus(dwc->usb2_phy->otg, true);
-			if (dwc->usb2_generic_phy)
-				phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
-
+			phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
+			phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
 		}
 		break;
 	case DWC3_GCTL_PRTCAP_DEVICE:
@@ -166,8 +154,8 @@ static void __dwc3_set_mode(struct work_struct *work)
 
 		if (dwc->usb2_phy)
 			otg_set_vbus(dwc->usb2_phy->otg, false);
-		if (dwc->usb2_generic_phy)
-			phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_DEVICE);
+		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_DEVICE);
+		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_DEVICE);
 
 		ret = dwc3_gadget_init(dwc);
 		if (ret)
@@ -927,12 +915,13 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 
 	switch (dwc->dr_mode) {
 	case USB_DR_MODE_PERIPHERAL:
+		dwc->current_dr_role = DWC3_GCTL_PRTCAP_DEVICE;
 		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
 
 		if (dwc->usb2_phy)
 			otg_set_vbus(dwc->usb2_phy->otg, false);
-		if (dwc->usb2_generic_phy)
-			phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_DEVICE);
+		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_DEVICE);
+		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_DEVICE);
 
 		ret = dwc3_gadget_init(dwc);
 		if (ret) {
@@ -942,12 +931,13 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 		}
 		break;
 	case USB_DR_MODE_HOST:
+		dwc->current_dr_role = DWC3_GCTL_PRTCAP_HOST;
 		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
 
 		if (dwc->usb2_phy)
 			otg_set_vbus(dwc->usb2_phy->otg, true);
-		if (dwc->usb2_generic_phy)
-			phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
+		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
+		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
 
 		ret = dwc3_host_init(dwc);
 		if (ret) {
@@ -1293,21 +1283,19 @@ static int dwc3_suspend_common(struct dwc3 *dwc)
 {
 	unsigned long	flags;
 
-	switch (dwc->dr_mode) {
-	case USB_DR_MODE_PERIPHERAL:
-	case USB_DR_MODE_OTG:
+	switch (dwc->current_dr_role) {
+	case DWC3_GCTL_PRTCAP_DEVICE:
 		spin_lock_irqsave(&dwc->lock, flags);
 		dwc3_gadget_suspend(dwc);
 		spin_unlock_irqrestore(&dwc->lock, flags);
+		dwc3_core_exit(dwc);
 		break;
-	case USB_DR_MODE_HOST:
+	case DWC3_GCTL_PRTCAP_HOST:
 	default:
 		/* do nothing */
 		break;
 	}
 
-	dwc3_core_exit(dwc);
-
 	return 0;
 }
 
@@ -1316,18 +1304,17 @@ static int dwc3_resume_common(struct dwc3 *dwc)
 	unsigned long	flags;
 	int		ret;
 
-	ret = dwc3_core_init(dwc);
-	if (ret)
-		return ret;
+	switch (dwc->current_dr_role) {
+	case DWC3_GCTL_PRTCAP_DEVICE:
+		ret = dwc3_core_init(dwc);
+		if (ret)
+			return ret;
 
-	switch (dwc->dr_mode) {
-	case USB_DR_MODE_PERIPHERAL:
-	case USB_DR_MODE_OTG:
 		spin_lock_irqsave(&dwc->lock, flags);
 		dwc3_gadget_resume(dwc);
 		spin_unlock_irqrestore(&dwc->lock, flags);
-		/* FALLTHROUGH */
-	case USB_DR_MODE_HOST:
+		break;
+	case DWC3_GCTL_PRTCAP_HOST:
 	default:
 		/* do nothing */
 		break;
@@ -1338,7 +1325,7 @@ static int dwc3_resume_common(struct dwc3 *dwc)
 
 static int dwc3_runtime_checks(struct dwc3 *dwc)
 {
-	switch (dwc->dr_mode) {
+	switch (dwc->current_dr_role) {
 	case USB_DR_MODE_PERIPHERAL:
 	case USB_DR_MODE_OTG:
 		if (dwc->connected)
@@ -1381,19 +1368,17 @@ static int dwc3_runtime_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	switch (dwc->dr_mode) {
-	case USB_DR_MODE_PERIPHERAL:
-	case USB_DR_MODE_OTG:
+	switch (dwc->current_dr_role) {
+	case DWC3_GCTL_PRTCAP_DEVICE:
 		dwc3_gadget_process_pending_events(dwc);
 		break;
-	case USB_DR_MODE_HOST:
+	case DWC3_GCTL_PRTCAP_HOST:
 	default:
 		/* do nothing */
 		break;
 	}
 
 	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put(dev);
 
 	return 0;
 }
@@ -1402,13 +1387,12 @@ static int dwc3_runtime_idle(struct device *dev)
 {
 	struct dwc3     *dwc = dev_get_drvdata(dev);
 
-	switch (dwc->dr_mode) {
-	case USB_DR_MODE_PERIPHERAL:
-	case USB_DR_MODE_OTG:
+	switch (dwc->current_dr_role) {
+	case DWC3_GCTL_PRTCAP_DEVICE:
 		if (dwc3_runtime_checks(dwc))
 			return -EBUSY;
 		break;
-	case USB_DR_MODE_HOST:
+	case DWC3_GCTL_PRTCAP_HOST:
 	default:
 		/* do nothing */
 		break;
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index ea910acb4bb0..4a4a4c98508c 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * core.h - DesignWare USB3 DRD Core Header
  *
@@ -5,15 +6,6 @@
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2  of
- * the License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #ifndef __DRIVERS_USB_DWC3_CORE_H
@@ -529,6 +521,7 @@ struct dwc3_event_buffer {
  * @number: endpoint number (1 - 15)
  * @type: set to bmAttributes & USB_ENDPOINT_XFERTYPE_MASK
  * @resource_index: Resource transfer index
+ * @frame_number: set to the frame number we want this transfer to start (ISOC)
  * @interval: the interval on which the ISOC transfer is started
  * @allocated_requests: number of requests allocated
  * @queued_requests: number of requests queued for transfer
@@ -581,6 +574,7 @@ struct dwc3_ep {
 	u8			resource_index;
 	u32			allocated_requests;
 	u32			queued_requests;
+	u32			frame_number;
 	u32			interval;
 
 	char			name[20];
diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
index 5e9c070ec874..368f8e59219a 100644
--- a/drivers/usb/dwc3/debug.h
+++ b/drivers/usb/dwc3/debug.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /**
  * debug.h - DesignWare USB3 DRD Controller Debug Header
  *
@@ -5,15 +6,6 @@
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2  of
- * the License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #ifndef __DWC3_DEBUG_H
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 75e6cb044eb2..fd3e7ad2eb0e 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * ep0.c - DesignWare USB3 DRD Controller Endpoint 0 Handling
  *
@@ -5,15 +6,6 @@
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2  of
- * the License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/kernel.h>
@@ -487,14 +479,10 @@ static int dwc3_ep0_handle_device(struct dwc3 *dwc,
 static int dwc3_ep0_handle_intf(struct dwc3 *dwc,
 		struct usb_ctrlrequest *ctrl, int set)
 {
-	enum usb_device_state	state;
 	u32			wValue;
-	u32			wIndex;
 	int			ret = 0;
 
 	wValue = le16_to_cpu(ctrl->wValue);
-	wIndex = le16_to_cpu(ctrl->wIndex);
-	state = dwc->gadget.state;
 
 	switch (wValue) {
 	case USB_INTRF_FUNC_SUSPEND:
@@ -517,14 +505,10 @@ static int dwc3_ep0_handle_endpoint(struct dwc3 *dwc,
 		struct usb_ctrlrequest *ctrl, int set)
 {
 	struct dwc3_ep		*dep;
-	enum usb_device_state	state;
 	u32			wValue;
-	u32			wIndex;
 	int			ret;
 
 	wValue = le16_to_cpu(ctrl->wValue);
-	wIndex = le16_to_cpu(ctrl->wIndex);
-	state = dwc->gadget.state;
 
 	switch (wValue) {
 	case USB_ENDPOINT_HALT:
@@ -551,10 +535,8 @@ static int dwc3_ep0_handle_feature(struct dwc3 *dwc,
 {
 	u32			recip;
 	int			ret;
-	enum usb_device_state	state;
 
 	recip = ctrl->bRequestType & USB_RECIP_MASK;
-	state = dwc->gadget.state;
 
 	switch (recip) {
 	case USB_RECIP_DEVICE:
@@ -712,12 +694,10 @@ static int dwc3_ep0_set_sel(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 	struct dwc3_ep	*dep;
 	enum usb_device_state state = dwc->gadget.state;
 	u16		wLength;
-	u16		wValue;
 
 	if (state == USB_STATE_DEFAULT)
 		return -EINVAL;
 
-	wValue = le16_to_cpu(ctrl->wValue);
 	wLength = le16_to_cpu(ctrl->wLength);
 
 	if (wLength != 6) {
@@ -842,9 +822,6 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 	struct usb_request	*ur;
 	struct dwc3_trb		*trb;
 	struct dwc3_ep		*ep0;
-	unsigned		maxp;
-	unsigned		remaining_ur_length;
-	void			*buf;
 	u32			transferred = 0;
 	u32			status;
 	u32			length;
@@ -871,11 +848,8 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 	}
 
 	ur = &r->request;
-	buf = ur->buf;
-	remaining_ur_length = ur->length;
 
 	length = trb->size & DWC3_TRB_SIZE_MASK;
-	maxp = ep0->endpoint.maxpacket;
 	transferred = ur->length - length;
 	ur->actual += transferred;
 
@@ -1001,7 +975,6 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 	} else if (IS_ALIGNED(req->request.length, dep->endpoint.maxpacket) &&
 		   req->request.length && req->request.zero) {
 		u32	maxpacket;
-		u32	rem;
 
 		ret = usb_gadget_map_request_by_dev(dwc->sysdev,
 				&req->request, dep->number);
@@ -1009,7 +982,6 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 			return;
 
 		maxpacket = dep->endpoint.maxpacket;
-		rem = req->request.length % maxpacket;
 
 		/* prepare normal TRB */
 		dwc3_ep0_prepare_one_trb(dep, req->request.dma,
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index f064f1549333..639dd1b163a0 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * gadget.c - DesignWare USB3 DRD Controller Gadget Framework Link
  *
@@ -5,15 +6,6 @@
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2  of
- * the License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/kernel.h>
@@ -267,7 +259,7 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned cmd,
 {
 	const struct usb_endpoint_descriptor *desc = dep->endpoint.desc;
 	struct dwc3		*dwc = dep->dwc;
-	u32			timeout = 500;
+	u32			timeout = 1000;
 	u32			reg;
 
 	int			cmd_status = 0;
@@ -920,7 +912,7 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 			 */
 			if (speed == USB_SPEED_HIGH) {
 				struct usb_ep *ep = &dep->endpoint;
-				unsigned int mult = ep->mult - 1;
+				unsigned int mult = 2;
 				unsigned int maxp = usb_endpoint_maxp(ep->desc);
 
 				if (length <= (2 * maxp))
@@ -1151,9 +1143,6 @@ static void dwc3_prepare_trbs(struct dwc3_ep *dep)
 
 	BUILD_BUG_ON_NOT_POWER_OF_2(DWC3_TRB_NUM);
 
-	if (!dwc3_calc_trbs_left(dep))
-		return;
-
 	/*
 	 * We can get in a situation where there's a request in the started list
 	 * but there weren't enough TRBs to fully kick it in the first time
@@ -1194,7 +1183,7 @@ static void dwc3_prepare_trbs(struct dwc3_ep *dep)
 	}
 }
 
-static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep, u16 cmd_param)
+static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep)
 {
 	struct dwc3_gadget_ep_cmd_params params;
 	struct dwc3_request		*req;
@@ -1202,6 +1191,9 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep, u16 cmd_param)
 	int				ret;
 	u32				cmd;
 
+	if (!dwc3_calc_trbs_left(dep))
+		return 0;
+
 	starting = !(dep->flags & DWC3_EP_BUSY);
 
 	dwc3_prepare_trbs(dep);
@@ -1216,8 +1208,10 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep, u16 cmd_param)
 	if (starting) {
 		params.param0 = upper_32_bits(req->trb_dma);
 		params.param1 = lower_32_bits(req->trb_dma);
-		cmd = DWC3_DEPCMD_STARTTRANSFER |
-			DWC3_DEPCMD_PARAM(cmd_param);
+		cmd = DWC3_DEPCMD_STARTTRANSFER;
+
+		if (usb_endpoint_xfer_isoc(dep->endpoint.desc))
+			cmd |= DWC3_DEPCMD_PARAM(dep->frame_number);
 	} else {
 		cmd = DWC3_DEPCMD_UPDATETRANSFER |
 			DWC3_DEPCMD_PARAM(dep->resource_index);
@@ -1258,8 +1252,6 @@ static int __dwc3_gadget_get_frame(struct dwc3 *dwc)
 static void __dwc3_gadget_start_isoc(struct dwc3 *dwc,
 		struct dwc3_ep *dep, u32 cur_uf)
 {
-	u32 uf;
-
 	if (list_empty(&dep->pending_list)) {
 		dev_info(dwc->dev, "%s: ran out of requests\n",
 				dep->name);
@@ -1271,9 +1263,8 @@ static void __dwc3_gadget_start_isoc(struct dwc3 *dwc,
 	 * Schedule the first trb for one interval in the future or at
 	 * least 4 microframes.
 	 */
-	uf = cur_uf + max_t(u32, 4, dep->interval);
-
-	__dwc3_gadget_kick_transfer(dep, uf);
+	dep->frame_number = cur_uf + max_t(u32, 4, dep->interval);
+	__dwc3_gadget_kick_transfer(dep);
 }
 
 static void dwc3_gadget_start_isoc(struct dwc3 *dwc,
@@ -1290,7 +1281,6 @@ static void dwc3_gadget_start_isoc(struct dwc3 *dwc,
 static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 {
 	struct dwc3		*dwc = dep->dwc;
-	int			ret = 0;
 
 	if (!dep->endpoint.desc) {
 		dev_err(dwc->dev, "%s: can't queue to disabled endpoint\n",
@@ -1337,24 +1327,14 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 		}
 
 		if ((dep->flags & DWC3_EP_BUSY) &&
-		    !(dep->flags & DWC3_EP_MISSED_ISOC)) {
-			WARN_ON_ONCE(!dep->resource_index);
-			ret = __dwc3_gadget_kick_transfer(dep,
-							  dep->resource_index);
-		}
-
-		goto out;
-	}
+		    !(dep->flags & DWC3_EP_MISSED_ISOC))
+			goto out;
 
-	if (!dwc3_calc_trbs_left(dep))
 		return 0;
+	}
 
-	ret = __dwc3_gadget_kick_transfer(dep, 0);
 out:
-	if (ret == -EBUSY)
-		ret = 0;
-
-	return ret;
+	return __dwc3_gadget_kick_transfer(dep);
 }
 
 static int dwc3_gadget_ep_queue(struct usb_ep *ep, struct usb_request *request,
@@ -2347,7 +2327,7 @@ static int dwc3_cleanup_done_reqs(struct dwc3 *dwc, struct dwc3_ep *dep,
 		req->request.actual = length - req->remaining;
 
 		if ((req->request.actual < length) && req->num_pending_sgs)
-			return __dwc3_gadget_kick_transfer(dep, 0);
+			return __dwc3_gadget_kick_transfer(dep);
 
 		dwc3_gadget_giveback(dep, req, status);
 
@@ -2440,13 +2420,8 @@ static void dwc3_endpoint_transfer_complete(struct dwc3 *dwc,
 	if (!dep->endpoint.desc)
 		return;
 
-	if (!usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
-		int ret;
-
-		ret = __dwc3_gadget_kick_transfer(dep, 0);
-		if (!ret || ret == -EBUSY)
-			return;
-	}
+	if (!usb_endpoint_xfer_isoc(dep->endpoint.desc))
+		__dwc3_gadget_kick_transfer(dep);
 }
 
 static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
@@ -2487,15 +2462,10 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 		dwc3_endpoint_transfer_complete(dwc, dep, event);
 		break;
 	case DWC3_DEPEVT_XFERNOTREADY:
-		if (usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
+		if (usb_endpoint_xfer_isoc(dep->endpoint.desc))
 			dwc3_gadget_start_isoc(dwc, dep, event);
-		} else {
-			int ret;
-
-			ret = __dwc3_gadget_kick_transfer(dep, 0);
-			if (!ret || ret == -EBUSY)
-				return;
-		}
+		else
+			__dwc3_gadget_kick_transfer(dep);
 
 		break;
 	case DWC3_DEPEVT_STREAMEVT:
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index 4a3227543255..578aa856f986 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * gadget.h - DesignWare USB3 DRD Gadget Header
  *
@@ -5,15 +6,6 @@
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2  of
- * the License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #ifndef __DRIVERS_USB_DWC3_GADGET_H
diff --git a/drivers/usb/dwc3/io.h b/drivers/usb/dwc3/io.h
index c69b06696824..70acdf94a0bf 100644
--- a/drivers/usb/dwc3/io.h
+++ b/drivers/usb/dwc3/io.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /**
  * io.h - DesignWare USB3 DRD IO Header
  *
@@ -5,15 +6,6 @@
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2  of
- * the License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #ifndef __DRIVERS_USB_DWC3_IO_H
-- 
2.53.0

