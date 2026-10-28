Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A50A606A31F
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LG8u7pw2;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=OGSHpqxk
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D4B31406E4;
	Wed, 28 Oct 2026 14:46:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sc3A4RqsgHc9; Wed, 28 Oct 2026 14:46:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7B89040665
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198784;
	b=aehJsZpkKeUxs/EqsiiCNAuC1IyurqlIppKBtX1+bI0C06FLQzkQfA/wOZfztMOE+6fq
	 rHJvptrPEv/4oZDPQtAdCNFraIRjtPsaY/0JjSMT//ga6DTk/y9H6NtspcXxMCfCz3wpS
	 kpixdhkmlSqA8NADz+Gdfprj9EN3anwDLyoYmdPPqDtfYN066BTmADwyTPhqewiGsQzgI
	 0tO3CzH2nF0BlPM61p7dKHh3xsKOEUW6FqlCPGURoKY8sRJqsrElrMaHRYVoP62sFq9D4
	 dO6dyod1QXYE6rLAe44qhdubQuY18ZOupFHTaYI2tCRTqTyaO8tYDauuCFm4R9HvSLA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198784;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=SfwzTpRUgqaXm3054yt0Fy7s+HERf4+OUkTE6HSbiFM=;
	b=hkEGFyY97gTl7iCW4UMtBD3QfCXQZdv7skfNy0fNYuoejiGMRCoU6o0B74SpKxEyT45L
	 +tpLF5RGceqA9CW1Mxc6zySJF+GYTp2UlfSkRoW0XixMVli3suQqqCZufOud1k+dfiEzQ
	 qHgXF7iH6xKDryXuB0UJdX1/ijA/fVsSvk4rAZZB1U+ZUlHYIZtkgVVgCrdwH9ZMkEDom
	 xZRoFq5IyJU+dsFEjmeedleoUC/b7AUXw+q9926hwj9vWCUEPcY+4Uwaq0WqdwnahTlNL
	 89E8o1DC6ZLKVWEgGhIVI5vptaPpuBA2KZhXNjl47dlOQHigC8GDSQXnQqA+ss+NQRw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198784;
	bh=SfwzTpRUgqaXm3054yt0Fy7s+HERf4+OUkTE6HSbiFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LG8u7pw2kWuFNpiIIsjsyJII3EBSfnLMzsy6AcO5zP82HiU5Sm4ytzUSJm8WINHJd
	 6t6GmtmyeXyZHngC0ZAEOonccqoLIZFD/oWrYlqpnmnsIJQRgJHJNxmMGhBPS1bvIk
	 W4ddpEk84577B3ykLbA1yeKUOwLjl4wAXWFWnDYTkFqEo2pL3nioJayYI/STsPv5Pf
	 ONVWvmwh60nGpuYpNT7iDUiYrlusaW/24X9EzsXb2SLdUf5h6cz2/h4I2v4cvm0Avv
	 n8hvX3fGkNHgV6WqKy6TvcqXp4ue62kvvkfIPvaW4KvzoXinjNcXAOm0px32qVhYHx
	 MGPvK134z62gQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7B89040665;
	Wed, 28 Oct 2026 14:46:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B1BE4356
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:11:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9768280BDF
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:11:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3Eu2s51RnFZR for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:11:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A263F80C26
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196663;
 b=sN5NGmYhYYi4tJ9xY2ZEfxIPLbsEU5wSlt6/dDsBLAw1xANIS5FYM1kfGoF1m7HNSChs
 dCTfdGlw2kSL4oojaGMh6P9GhiE51+4/XwQd2P+0qNOstU4rJcEPpGCJqybPcO7t7hOr/
 S4UnwitbeqJLEuUB2a+clxY9RtvqboRxrXEKMc5M9wAkYANDfFL8Gt/bmSFwuxlTOxPkF
 6IEuZEZVxwJ4PR/K8CTC9MHrC5wl0Ep9vw3VFipPPYDgG8Cnfrr3i5QTO6DEGdRRSlVLL
 HlvOa8tE1X1O6SosUie39cexP/sUw1zy8P0zGBDX99J3Laf1OzVGwyAOx0UehXOqaLg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196663;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=SfwzTpRUgqaXm3054yt0Fy7s+HERf4+OUkTE6HSbiFM=;
 b=n+XS4v56XxBRnA+306BAqZFaU8CF/G7q6OPVDLYiRwcYKFOOx02z5uLqnQyAkrCpviWv
 BUkV0Dfk5HHivSWnmsmOCy04E5c0UTcpqfczfHK+J8B7S4jTtgPw7XFYLJhVDgJ++cAA6
 kDL6OnHR9I8H1XJvS2NmylPPX+Qf3G+/D2PHHeIYTWgHDczEItA9fTTDd6GwrMS6tEIIY
 r6nVF/2ue5km3273aKDQlZAaukDGemqozUCkJi3nLoZJHmQFqFFyGdifLC8hCO07MpWVn
 6lFT0Znp6IUSxqFcIi/6oy40GrGIWEg+YJQXxJkERtSC98xmyqT/2HZqaJ6kZ87sPlQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=OGSHpqxk; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=OGSHpqxk
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A263F80C26
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:11:01 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c407213696aso10383066b.0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196660; x=1793801460;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SfwzTpRUgqaXm3054yt0Fy7s+HERf4+OUkTE6HSbiFM=;
 b=OGSHpqxkrY2AbkN8/D1Y1sGZVCkwqwLNtSXwRU6AjZI6LOUANdbqL43PeJIJkfhZuA
 51NWdmv1olUpu46MfuLVbejuzoW4MXcN8zT9GBeLqsBB8wmc3y2E8xZSOE3wjlycmZep
 HT+u32GT8nN/cxGkdofkKESz1+X5vEKq9rqk8vXD1dWbbXs+VF/SDp1a5nPjzuyZDEK6
 demXmBwev5hLgeOp2oUALQIl5pU0ftGI4dX5KvQm7wk4fKM5wt6wWIhXJXFEIOq36xNG
 RnpENYTx2Z60pvViDFVpDU45P4LCchiFHZA7NwVRHOsDtyH1VoeF4EiC4HjuCWn/+c+C
 8pMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196660; x=1793801460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SfwzTpRUgqaXm3054yt0Fy7s+HERf4+OUkTE6HSbiFM=;
 b=mh9mOhNVEyXwQoB3MybobCo/tSBPkur0mKS9kVs/ZCwlQpzmxt53luXAHP0DziGRFX
 S77nOsApDsWfSeVfzVlWNgIveZcf7c7F92ffmau4wQFBQU2JilM8B4eogxECzCYwRgVI
 z6sg483AfGB1CsptxCLqT53Ku/nQm5Flf2cj1kiMsnn97bmEBzm3BgNPFJ0dWJtmbKQC
 rqX8khQovCfWPSdPq52TPs3bRhkom668qBvTW62GEh/j4UUpId16btqoGmQC+EFo0ldo
 iaeCUAIOKa5rQ7uQsQNllyi/p64rl32zRUIL7fqbm6signMpeeaWSEgIsBaTS+NQtrX7
 gXCA==
X-Gm-Message-State: AFq9FYLwFMeETN75zNqUFzyeyHExPrRZfgtx+ercPsrk9uSEJ/xNh2RK
 sWuMTTxhXjF+vBX/ZTdY9QtHQTfd2/7Zs6lOiA1kQmHRTdW/1fiqpK5lcvpGdz/4RWTGyvf9095
 Pijla
X-Gm-Gg: AYBFou3LCrdE5Kb2Rv8PvesC/1H7fDIRNthI6Gr9DFSIkUXyFu5JEH2Gb+LlQVQlJMA
 09shdM6TjUERRy3lU8arS5KSd9V3HjU4LXYZe1RJcYAonLxk5CdXCQoLCTY/6k2gydC3S88VPFT
 nmMGZJpdAhThQ9BE4xfjp4s2iLwyC1ReOw44k5XOyYzCfzulk2BUz4Xu/+LXY6HQlU4n8I6EWRd
 zgphi8nLTPQQC1D6pub+OFNzFzKOB+lAncVESpOiA+HYFThZMQ6IQo14+UHP1Zyijmf3JQsFLyt
 +Y0kayNBz+ktgh++MM8zrmevePzcjWRyZlqBRtr2w4k4TctLFcntaaisGh5jZ1AhOp/n7DtPbdu
 qIyDSLVPN3HCC7Wf7Wc9QXv614VgXe7fbamq/MfsRwCm0bz0OBKi/qvJ0DqzpBocoK2MFguW8A2
 sFFfihmg8Bw5ZFLpCQ57/r0zmsgRT2pGCqxU2uiL4GB5ZVmkn2GoaVfzUWNmnpc2cQa4BUybS9h
 NBtqi451qhF4pm3dPW3UPSlSDOPcYJvbfJm4JZGjdDnOpydULkYGmyfFh7AHumC7lidmUelxWWL
 hldDZLj1gRdpan7MY6w0q/grflsfxe1QaFThOCd3M7XDfltlYhfMtbYcEXbXU3CyDgMtQbopr6P
 wtmC7cLcq7g==
X-Received: by 2002:a17:907:2485:b0:c32:8cbb:fac with SMTP id
 a640c23a62f3a-c49bdebefe6mr219386266b.3.1793196659598; 
 Wed, 28 Oct 2026 07:10:59 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd64f8c4sm617944566b.47.2026.10.28.07.10.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:10:59 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 16/63] usb: dwc3: import from kernel v4.12
Date: Wed, 28 Oct 2026 15:08:42 +0100
Message-ID: <20261028140930.3025368-17-anders.roxell@linaro.org>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jens Wiklander <jens.wiklander@linaro.org>

Sync Linux kernel dwc3 changes from v4.11 to v4.12.

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

List of commits: git log --oneline v4.11..v4.12
Commits imported:
d325a1de49d6 usb: dwc3: gadget: Prevent losing events in event cache
f1d6826cae30 usb: dwc3: gadget: Fix ISO transfer performance
9840354ff429 usb: dwc3: Add dual-role support
41ce1456e1db usb: dwc3: core: make dwc3_set_mode() work properly
6b3261a27428 usb: dwc3: core: add current_dr_role member
d6e5a549cc4d usb: dwc3: simplify ZLP handling
4199c5f8bccd usb: dwc3: ep0: improve handling of unaligned OUT requests
d686a5ff6a2d usb: dwc3: ep0: pass dep as argument to internal functions
7d5e650a5fdb usb: dwc3: ep0: use immediate SETUP on TRB
b5c7ed5cca82 usb: dwc3: expose dwc3_trb_type_string()
ff3f0789b3dc usb: dwc3: use BIT() macro where possible
af771d731b8e usb: dwc3: gadget: Fix starting microframe for ISOC
f3bcfc7e68f0 usb: dwc3: remove dwc3_gadget_init_hw_endpoints
47d3946ea220 usb: dwc3: refactor gadget endpoint count calculation
8261bd4e91e2 usb: dwc3: make macros safe to expression arguments
1966b8657d05 usb: dwc3: make sure UX_EXIT_PX is cleared

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c   | 109 +++++++++++-----
 drivers/usb/dwc3/core.h   | 261 ++++++++++++++++++++------------------
 drivers/usb/dwc3/debug.h  |  28 ++++
 drivers/usb/dwc3/ep0.c    | 151 ++++++++++------------
 drivers/usb/dwc3/gadget.c | 218 +++++++++++--------------------
 drivers/usb/dwc3/gadget.h |  20 +--
 6 files changed, 392 insertions(+), 395 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 369bab16a824..455d89a1cd6d 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -100,7 +100,10 @@ static int dwc3_get_dr_mode(struct dwc3 *dwc)
 	return 0;
 }
 
-void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
+static void dwc3_event_buffers_cleanup(struct dwc3 *dwc);
+static int dwc3_event_buffers_setup(struct dwc3 *dwc);
+
+static void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
 {
 	u32 reg;
 
@@ -110,6 +113,69 @@ void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
 	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
 }
 
+static void __dwc3_set_mode(struct work_struct *work)
+{
+	struct dwc3 *dwc = work_to_dwc(work);
+	unsigned long flags;
+	int ret;
+
+	if (!dwc->desired_dr_role)
+		return;
+
+	if (dwc->desired_dr_role == dwc->current_dr_role)
+		return;
+
+	if (dwc->dr_mode != USB_DR_MODE_OTG)
+		return;
+
+	switch (dwc->current_dr_role) {
+	case DWC3_GCTL_PRTCAP_HOST:
+		dwc3_host_exit(dwc);
+		break;
+	case DWC3_GCTL_PRTCAP_DEVICE:
+		dwc3_gadget_exit(dwc);
+		dwc3_event_buffers_cleanup(dwc);
+		break;
+	default:
+		break;
+	}
+
+	spin_lock_irqsave(&dwc->lock, flags);
+
+	dwc3_set_prtcap(dwc, dwc->desired_dr_role);
+
+	dwc->current_dr_role = dwc->desired_dr_role;
+
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
+	switch (dwc->desired_dr_role) {
+	case DWC3_GCTL_PRTCAP_HOST:
+		ret = dwc3_host_init(dwc);
+		if (ret)
+			dev_err(dwc->dev, "failed to initialize host\n");
+		break;
+	case DWC3_GCTL_PRTCAP_DEVICE:
+		dwc3_event_buffers_setup(dwc);
+		ret = dwc3_gadget_init(dwc);
+		if (ret)
+			dev_err(dwc->dev, "failed to initialize peripheral\n");
+		break;
+	default:
+		break;
+	}
+}
+
+void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	dwc->desired_dr_role = mode;
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
+	queue_work(system_power_efficient_wq, &dwc->drd_work);
+}
+
 u32 dwc3_core_fifo_space(struct dwc3_ep *dep, u8 type)
 {
 	struct dwc3		*dwc = dep->dwc;
@@ -397,8 +463,7 @@ static void dwc3_core_num_eps(struct dwc3 *dwc)
 {
 	struct dwc3_hwparams	*parms = &dwc->hwparams;
 
-	dwc->num_in_eps = DWC3_NUM_IN_EPS(parms);
-	dwc->num_out_eps = DWC3_NUM_EPS(parms) - dwc->num_in_eps;
+	dwc->num_eps = DWC3_NUM_EPS(parms);
 }
 
 static void dwc3_cache_hwparams(struct dwc3 *dwc)
@@ -431,6 +496,12 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 
 	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
 
+	/*
+	 * Make sure UX_EXIT_PX is cleared as that causes issues with some
+	 * PHYs. Also, this bit is not supposed to be used in normal operation.
+	 */
+	reg &= ~DWC3_GUSB3PIPECTL_UX_EXIT_PX;
+
 	/*
 	 * Above 1.94a, it is recommended to set DWC3_GUSB3PIPECTL_SUSPHY
 	 * to '0' during coreConsultant configuration. So default value
@@ -714,21 +785,6 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		goto err4;
 	}
 
-	switch (dwc->dr_mode) {
-	case USB_DR_MODE_PERIPHERAL:
-		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
-		break;
-	case USB_DR_MODE_HOST:
-		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_HOST);
-		break;
-	case USB_DR_MODE_OTG:
-		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
-		break;
-	default:
-		dev_warn(dwc->dev, "Unsupported mode %d\n", dwc->dr_mode);
-		break;
-	}
-
 	/*
 	 * ENDXFER polling is available on version 3.10a and later of
 	 * the DWC_usb3 controller. It is NOT available in the
@@ -846,6 +902,7 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 
 	switch (dwc->dr_mode) {
 	case USB_DR_MODE_PERIPHERAL:
+		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
 		ret = dwc3_gadget_init(dwc);
 		if (ret) {
 			if (ret != -EPROBE_DEFER)
@@ -854,6 +911,7 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 		}
 		break;
 	case USB_DR_MODE_HOST:
+		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
 		ret = dwc3_host_init(dwc);
 		if (ret) {
 			if (ret != -EPROBE_DEFER)
@@ -862,17 +920,11 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 		}
 		break;
 	case USB_DR_MODE_OTG:
-		ret = dwc3_host_init(dwc);
-		if (ret) {
-			if (ret != -EPROBE_DEFER)
-				dev_err(dev, "failed to initialize host\n");
-			return ret;
-		}
-
-		ret = dwc3_gadget_init(dwc);
+		INIT_WORK(&dwc->drd_work, __dwc3_set_mode);
+		ret = dwc3_drd_init(dwc);
 		if (ret) {
 			if (ret != -EPROBE_DEFER)
-				dev_err(dev, "failed to initialize gadget\n");
+				dev_err(dev, "failed to initialize dual-role\n");
 			return ret;
 		}
 		break;
@@ -894,8 +946,7 @@ static void dwc3_core_exit_mode(struct dwc3 *dwc)
 		dwc3_host_exit(dwc);
 		break;
 	case USB_DR_MODE_OTG:
-		dwc3_host_exit(dwc);
-		dwc3_gadget_exit(dwc);
+		dwc3_drd_exit(dwc);
 		break;
 	default:
 		/* do nothing */
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 2b9e4ca3c932..981c77f5628e 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -23,10 +23,12 @@
 #include <linux/spinlock.h>
 #include <linux/ioport.h>
 #include <linux/list.h>
+#include <linux/bitops.h>
 #include <linux/dma-mapping.h>
 #include <linux/mm.h>
 #include <linux/debugfs.h>
 #include <linux/wait.h>
+#include <linux/workqueue.h>
 
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
@@ -39,9 +41,8 @@
 
 /* Global constants */
 #define DWC3_PULL_UP_TIMEOUT	500	/* ms */
-#define DWC3_ZLP_BUF_SIZE	1024	/* size of a superspeed bulk */
 #define DWC3_BOUNCE_SIZE	1024	/* size of a superspeed bulk */
-#define DWC3_EP0_BOUNCE_SIZE	512
+#define DWC3_EP0_SETUP_SIZE	512
 #define DWC3_ENDPOINTS_NUM	32
 #define DWC3_XHCI_RESOURCES_NUM	2
 
@@ -66,7 +67,7 @@
 #define DWC3_DEVICE_EVENT_OVERFLOW		11
 
 #define DWC3_GEVNTCOUNT_MASK	0xfffc
-#define DWC3_GEVNTCOUNT_EHB	(1 << 31)
+#define DWC3_GEVNTCOUNT_EHB	BIT(31)
 #define DWC3_GSNPSID_MASK	0xffff0000
 #define DWC3_GSNPSREV_MASK	0xffff
 
@@ -116,20 +117,20 @@
 #define DWC3_VER_NUMBER		0xc1a0
 #define DWC3_VER_TYPE		0xc1a4
 
-#define DWC3_GUSB2PHYCFG(n)	(0xc200 + (n * 0x04))
-#define DWC3_GUSB2I2CCTL(n)	(0xc240 + (n * 0x04))
+#define DWC3_GUSB2PHYCFG(n)	(0xc200 + ((n) * 0x04))
+#define DWC3_GUSB2I2CCTL(n)	(0xc240 + ((n) * 0x04))
 
-#define DWC3_GUSB2PHYACC(n)	(0xc280 + (n * 0x04))
+#define DWC3_GUSB2PHYACC(n)	(0xc280 + ((n) * 0x04))
 
-#define DWC3_GUSB3PIPECTL(n)	(0xc2c0 + (n * 0x04))
+#define DWC3_GUSB3PIPECTL(n)	(0xc2c0 + ((n) * 0x04))
 
-#define DWC3_GTXFIFOSIZ(n)	(0xc300 + (n * 0x04))
-#define DWC3_GRXFIFOSIZ(n)	(0xc380 + (n * 0x04))
+#define DWC3_GTXFIFOSIZ(n)	(0xc300 + ((n) * 0x04))
+#define DWC3_GRXFIFOSIZ(n)	(0xc380 + ((n) * 0x04))
 
-#define DWC3_GEVNTADRLO(n)	(0xc400 + (n * 0x10))
-#define DWC3_GEVNTADRHI(n)	(0xc404 + (n * 0x10))
-#define DWC3_GEVNTSIZ(n)	(0xc408 + (n * 0x10))
-#define DWC3_GEVNTCOUNT(n)	(0xc40c + (n * 0x10))
+#define DWC3_GEVNTADRLO(n)	(0xc400 + ((n) * 0x10))
+#define DWC3_GEVNTADRHI(n)	(0xc404 + ((n) * 0x10))
+#define DWC3_GEVNTSIZ(n)	(0xc408 + ((n) * 0x10))
+#define DWC3_GEVNTCOUNT(n)	(0xc40c + ((n) * 0x10))
 
 #define DWC3_GHWPARAMS8		0xc600
 #define DWC3_GFLADJ		0xc630
@@ -143,13 +144,13 @@
 #define DWC3_DGCMD		0xc714
 #define DWC3_DALEPENA		0xc720
 
-#define DWC3_DEP_BASE(n)	(0xc800 + (n * 0x10))
+#define DWC3_DEP_BASE(n)	(0xc800 + ((n) * 0x10))
 #define DWC3_DEPCMDPAR2		0x00
 #define DWC3_DEPCMDPAR1		0x04
 #define DWC3_DEPCMDPAR0		0x08
 #define DWC3_DEPCMD		0x0c
 
-#define DWC3_DEV_IMOD(n)	(0xca00 + (n * 0x4))
+#define DWC3_DEV_IMOD(n)	(0xca00 + ((n) * 0x4))
 
 /* OTG Registers */
 #define DWC3_OCFG		0xcc00
@@ -176,11 +177,11 @@
 /* Global RX Threshold Configuration Register */
 #define DWC3_GRXTHRCFG_MAXRXBURSTSIZE(n) (((n) & 0x1f) << 19)
 #define DWC3_GRXTHRCFG_RXPKTCNT(n) (((n) & 0xf) << 24)
-#define DWC3_GRXTHRCFG_PKTCNTSEL (1 << 29)
+#define DWC3_GRXTHRCFG_PKTCNTSEL BIT(29)
 
 /* Global Configuration Register */
 #define DWC3_GCTL_PWRDNSCALE(n)	((n) << 19)
-#define DWC3_GCTL_U2RSTECN	(1 << 16)
+#define DWC3_GCTL_U2RSTECN	BIT(16)
 #define DWC3_GCTL_RAMCLKSEL(x)	(((x) & DWC3_GCTL_CLK_MASK) << 6)
 #define DWC3_GCTL_CLK_BUS	(0)
 #define DWC3_GCTL_CLK_PIPE	(1)
@@ -193,24 +194,24 @@
 #define DWC3_GCTL_PRTCAP_DEVICE	2
 #define DWC3_GCTL_PRTCAP_OTG	3
 
-#define DWC3_GCTL_CORESOFTRESET		(1 << 11)
-#define DWC3_GCTL_SOFITPSYNC		(1 << 10)
+#define DWC3_GCTL_CORESOFTRESET		BIT(11)
+#define DWC3_GCTL_SOFITPSYNC		BIT(10)
 #define DWC3_GCTL_SCALEDOWN(n)		((n) << 4)
 #define DWC3_GCTL_SCALEDOWN_MASK	DWC3_GCTL_SCALEDOWN(3)
-#define DWC3_GCTL_DISSCRAMBLE		(1 << 3)
-#define DWC3_GCTL_U2EXIT_LFPS		(1 << 2)
-#define DWC3_GCTL_GBLHIBERNATIONEN	(1 << 1)
-#define DWC3_GCTL_DSBLCLKGTNG		(1 << 0)
+#define DWC3_GCTL_DISSCRAMBLE		BIT(3)
+#define DWC3_GCTL_U2EXIT_LFPS		BIT(2)
+#define DWC3_GCTL_GBLHIBERNATIONEN	BIT(1)
+#define DWC3_GCTL_DSBLCLKGTNG		BIT(0)
 
 /* Global User Control 1 Register */
-#define DWC3_GUCTL1_DEV_L1_EXIT_BY_HW	(1 << 24)
+#define DWC3_GUCTL1_DEV_L1_EXIT_BY_HW	BIT(24)
 
 /* Global USB2 PHY Configuration Register */
-#define DWC3_GUSB2PHYCFG_PHYSOFTRST	(1 << 31)
-#define DWC3_GUSB2PHYCFG_U2_FREECLK_EXISTS	(1 << 30)
-#define DWC3_GUSB2PHYCFG_SUSPHY		(1 << 6)
-#define DWC3_GUSB2PHYCFG_ULPI_UTMI	(1 << 4)
-#define DWC3_GUSB2PHYCFG_ENBLSLPM	(1 << 8)
+#define DWC3_GUSB2PHYCFG_PHYSOFTRST	BIT(31)
+#define DWC3_GUSB2PHYCFG_U2_FREECLK_EXISTS	BIT(30)
+#define DWC3_GUSB2PHYCFG_SUSPHY		BIT(6)
+#define DWC3_GUSB2PHYCFG_ULPI_UTMI	BIT(4)
+#define DWC3_GUSB2PHYCFG_ENBLSLPM	BIT(8)
 #define DWC3_GUSB2PHYCFG_PHYIF(n)	(n << 3)
 #define DWC3_GUSB2PHYCFG_PHYIF_MASK	DWC3_GUSB2PHYCFG_PHYIF(1)
 #define DWC3_GUSB2PHYCFG_USBTRDTIM(n)	(n << 10)
@@ -221,25 +222,26 @@
 #define UTMI_PHYIF_8_BIT		0
 
 /* Global USB2 PHY Vendor Control Register */
-#define DWC3_GUSB2PHYACC_NEWREGREQ	(1 << 25)
-#define DWC3_GUSB2PHYACC_BUSY		(1 << 23)
-#define DWC3_GUSB2PHYACC_WRITE		(1 << 22)
+#define DWC3_GUSB2PHYACC_NEWREGREQ	BIT(25)
+#define DWC3_GUSB2PHYACC_BUSY		BIT(23)
+#define DWC3_GUSB2PHYACC_WRITE		BIT(22)
 #define DWC3_GUSB2PHYACC_ADDR(n)	(n << 16)
 #define DWC3_GUSB2PHYACC_EXTEND_ADDR(n)	(n << 8)
 #define DWC3_GUSB2PHYACC_DATA(n)	(n & 0xff)
 
 /* Global USB3 PIPE Control Register */
-#define DWC3_GUSB3PIPECTL_PHYSOFTRST	(1 << 31)
-#define DWC3_GUSB3PIPECTL_U2SSINP3OK	(1 << 29)
-#define DWC3_GUSB3PIPECTL_DISRXDETINP3	(1 << 28)
-#define DWC3_GUSB3PIPECTL_REQP1P2P3	(1 << 24)
+#define DWC3_GUSB3PIPECTL_PHYSOFTRST	BIT(31)
+#define DWC3_GUSB3PIPECTL_U2SSINP3OK	BIT(29)
+#define DWC3_GUSB3PIPECTL_DISRXDETINP3	BIT(28)
+#define DWC3_GUSB3PIPECTL_UX_EXIT_PX	BIT(27)
+#define DWC3_GUSB3PIPECTL_REQP1P2P3	BIT(24)
 #define DWC3_GUSB3PIPECTL_DEP1P2P3(n)	((n) << 19)
 #define DWC3_GUSB3PIPECTL_DEP1P2P3_MASK	DWC3_GUSB3PIPECTL_DEP1P2P3(7)
 #define DWC3_GUSB3PIPECTL_DEP1P2P3_EN	DWC3_GUSB3PIPECTL_DEP1P2P3(1)
-#define DWC3_GUSB3PIPECTL_DEPOCHANGE	(1 << 18)
-#define DWC3_GUSB3PIPECTL_SUSPHY	(1 << 17)
-#define DWC3_GUSB3PIPECTL_LFPSFILT	(1 << 9)
-#define DWC3_GUSB3PIPECTL_RX_DETOPOLL	(1 << 8)
+#define DWC3_GUSB3PIPECTL_DEPOCHANGE	BIT(18)
+#define DWC3_GUSB3PIPECTL_SUSPHY	BIT(17)
+#define DWC3_GUSB3PIPECTL_LFPSFILT	BIT(9)
+#define DWC3_GUSB3PIPECTL_RX_DETOPOLL	BIT(8)
 #define DWC3_GUSB3PIPECTL_TX_DEEPH_MASK	DWC3_GUSB3PIPECTL_TX_DEEPH(3)
 #define DWC3_GUSB3PIPECTL_TX_DEEPH(n)	((n) << 1)
 
@@ -248,7 +250,7 @@
 #define DWC3_GTXFIFOSIZ_TXFSTADDR(n)	((n) & 0xffff0000)
 
 /* Global Event Size Registers */
-#define DWC3_GEVNTSIZ_INTMASK		(1 << 31)
+#define DWC3_GEVNTSIZ_INTMASK		BIT(31)
 #define DWC3_GEVNTSIZ_SIZE(n)		((n) & 0xffff)
 
 /* Global HWPARAMS0 Register */
@@ -289,18 +291,18 @@
 #define DWC3_MAX_HIBER_SCRATCHBUFS		15
 
 /* Global HWPARAMS6 Register */
-#define DWC3_GHWPARAMS6_EN_FPGA			(1 << 7)
+#define DWC3_GHWPARAMS6_EN_FPGA			BIT(7)
 
 /* Global HWPARAMS7 Register */
 #define DWC3_GHWPARAMS7_RAM1_DEPTH(n)	((n) & 0xffff)
 #define DWC3_GHWPARAMS7_RAM2_DEPTH(n)	(((n) >> 16) & 0xffff)
 
 /* Global Frame Length Adjustment Register */
-#define DWC3_GFLADJ_30MHZ_SDBND_SEL		(1 << 7)
+#define DWC3_GFLADJ_30MHZ_SDBND_SEL		BIT(7)
 #define DWC3_GFLADJ_30MHZ_MASK			0x3f
 
 /* Global User Control Register 2 */
-#define DWC3_GUCTL2_RST_ACTBITLATER		(1 << 14)
+#define DWC3_GUCTL2_RST_ACTBITLATER		BIT(14)
 
 /* Device Configuration Register */
 #define DWC3_DCFG_DEVADDR(addr)	((addr) << 3)
@@ -310,23 +312,23 @@
 #define DWC3_DCFG_SUPERSPEED_PLUS (5 << 0)  /* DWC_usb31 only */
 #define DWC3_DCFG_SUPERSPEED	(4 << 0)
 #define DWC3_DCFG_HIGHSPEED	(0 << 0)
-#define DWC3_DCFG_FULLSPEED	(1 << 0)
+#define DWC3_DCFG_FULLSPEED	BIT(0)
 #define DWC3_DCFG_LOWSPEED	(2 << 0)
 
 #define DWC3_DCFG_NUMP_SHIFT	17
 #define DWC3_DCFG_NUMP(n)	(((n) >> DWC3_DCFG_NUMP_SHIFT) & 0x1f)
 #define DWC3_DCFG_NUMP_MASK	(0x1f << DWC3_DCFG_NUMP_SHIFT)
-#define DWC3_DCFG_LPM_CAP	(1 << 22)
+#define DWC3_DCFG_LPM_CAP	BIT(22)
 
 /* Device Control Register */
-#define DWC3_DCTL_RUN_STOP	(1 << 31)
-#define DWC3_DCTL_CSFTRST	(1 << 30)
-#define DWC3_DCTL_LSFTRST	(1 << 29)
+#define DWC3_DCTL_RUN_STOP	BIT(31)
+#define DWC3_DCTL_CSFTRST	BIT(30)
+#define DWC3_DCTL_LSFTRST	BIT(29)
 
 #define DWC3_DCTL_HIRD_THRES_MASK	(0x1f << 24)
 #define DWC3_DCTL_HIRD_THRES(n)	((n) << 24)
 
-#define DWC3_DCTL_APPL1RES	(1 << 23)
+#define DWC3_DCTL_APPL1RES	BIT(23)
 
 /* These apply for core versions 1.87a and earlier */
 #define DWC3_DCTL_TRGTULST_MASK		(0x0f << 17)
@@ -341,15 +343,15 @@
 #define DWC3_DCTL_LPM_ERRATA_MASK	DWC3_DCTL_LPM_ERRATA(0xf)
 #define DWC3_DCTL_LPM_ERRATA(n)		((n) << 20)
 
-#define DWC3_DCTL_KEEP_CONNECT		(1 << 19)
-#define DWC3_DCTL_L1_HIBER_EN		(1 << 18)
-#define DWC3_DCTL_CRS			(1 << 17)
-#define DWC3_DCTL_CSS			(1 << 16)
+#define DWC3_DCTL_KEEP_CONNECT		BIT(19)
+#define DWC3_DCTL_L1_HIBER_EN		BIT(18)
+#define DWC3_DCTL_CRS			BIT(17)
+#define DWC3_DCTL_CSS			BIT(16)
 
-#define DWC3_DCTL_INITU2ENA		(1 << 12)
-#define DWC3_DCTL_ACCEPTU2ENA		(1 << 11)
-#define DWC3_DCTL_INITU1ENA		(1 << 10)
-#define DWC3_DCTL_ACCEPTU1ENA		(1 << 9)
+#define DWC3_DCTL_INITU2ENA		BIT(12)
+#define DWC3_DCTL_ACCEPTU2ENA		BIT(11)
+#define DWC3_DCTL_INITU1ENA		BIT(10)
+#define DWC3_DCTL_ACCEPTU1ENA		BIT(9)
 #define DWC3_DCTL_TSTCTRL_MASK		(0xf << 1)
 
 #define DWC3_DCTL_ULSTCHNGREQ_MASK	(0x0f << 5)
@@ -364,36 +366,36 @@
 #define DWC3_DCTL_ULSTCHNG_LOOPBACK	(DWC3_DCTL_ULSTCHNGREQ(11))
 
 /* Device Event Enable Register */
-#define DWC3_DEVTEN_VNDRDEVTSTRCVEDEN	(1 << 12)
-#define DWC3_DEVTEN_EVNTOVERFLOWEN	(1 << 11)
-#define DWC3_DEVTEN_CMDCMPLTEN		(1 << 10)
-#define DWC3_DEVTEN_ERRTICERREN		(1 << 9)
-#define DWC3_DEVTEN_SOFEN		(1 << 7)
-#define DWC3_DEVTEN_EOPFEN		(1 << 6)
-#define DWC3_DEVTEN_HIBERNATIONREQEVTEN	(1 << 5)
-#define DWC3_DEVTEN_WKUPEVTEN		(1 << 4)
-#define DWC3_DEVTEN_ULSTCNGEN		(1 << 3)
-#define DWC3_DEVTEN_CONNECTDONEEN	(1 << 2)
-#define DWC3_DEVTEN_USBRSTEN		(1 << 1)
-#define DWC3_DEVTEN_DISCONNEVTEN	(1 << 0)
+#define DWC3_DEVTEN_VNDRDEVTSTRCVEDEN	BIT(12)
+#define DWC3_DEVTEN_EVNTOVERFLOWEN	BIT(11)
+#define DWC3_DEVTEN_CMDCMPLTEN		BIT(10)
+#define DWC3_DEVTEN_ERRTICERREN		BIT(9)
+#define DWC3_DEVTEN_SOFEN		BIT(7)
+#define DWC3_DEVTEN_EOPFEN		BIT(6)
+#define DWC3_DEVTEN_HIBERNATIONREQEVTEN	BIT(5)
+#define DWC3_DEVTEN_WKUPEVTEN		BIT(4)
+#define DWC3_DEVTEN_ULSTCNGEN		BIT(3)
+#define DWC3_DEVTEN_CONNECTDONEEN	BIT(2)
+#define DWC3_DEVTEN_USBRSTEN		BIT(1)
+#define DWC3_DEVTEN_DISCONNEVTEN	BIT(0)
 
 /* Device Status Register */
-#define DWC3_DSTS_DCNRD			(1 << 29)
+#define DWC3_DSTS_DCNRD			BIT(29)
 
 /* This applies for core versions 1.87a and earlier */
-#define DWC3_DSTS_PWRUPREQ		(1 << 24)
+#define DWC3_DSTS_PWRUPREQ		BIT(24)
 
 /* These apply for core versions 1.94a and later */
-#define DWC3_DSTS_RSS			(1 << 25)
-#define DWC3_DSTS_SSS			(1 << 24)
+#define DWC3_DSTS_RSS			BIT(25)
+#define DWC3_DSTS_SSS			BIT(24)
 
-#define DWC3_DSTS_COREIDLE		(1 << 23)
-#define DWC3_DSTS_DEVCTRLHLT		(1 << 22)
+#define DWC3_DSTS_COREIDLE		BIT(23)
+#define DWC3_DSTS_DEVCTRLHLT		BIT(22)
 
 #define DWC3_DSTS_USBLNKST_MASK		(0x0f << 18)
 #define DWC3_DSTS_USBLNKST(n)		(((n) & DWC3_DSTS_USBLNKST_MASK) >> 18)
 
-#define DWC3_DSTS_RXFIFOEMPTY		(1 << 17)
+#define DWC3_DSTS_RXFIFOEMPTY		BIT(17)
 
 #define DWC3_DSTS_SOFFN_MASK		(0x3fff << 3)
 #define DWC3_DSTS_SOFFN(n)		(((n) & DWC3_DSTS_SOFFN_MASK) >> 3)
@@ -403,7 +405,7 @@
 #define DWC3_DSTS_SUPERSPEED_PLUS	(5 << 0) /* DWC_usb31 only */
 #define DWC3_DSTS_SUPERSPEED		(4 << 0)
 #define DWC3_DSTS_HIGHSPEED		(0 << 0)
-#define DWC3_DSTS_FULLSPEED		(1 << 0)
+#define DWC3_DSTS_FULLSPEED		BIT(0)
 #define DWC3_DSTS_LOWSPEED		(2 << 0)
 
 /* Device Generic Command Register */
@@ -421,26 +423,26 @@
 #define DWC3_DGCMD_RUN_SOC_BUS_LOOPBACK	0x10
 
 #define DWC3_DGCMD_STATUS(n)		(((n) >> 12) & 0x0F)
-#define DWC3_DGCMD_CMDACT		(1 << 10)
-#define DWC3_DGCMD_CMDIOC		(1 << 8)
+#define DWC3_DGCMD_CMDACT		BIT(10)
+#define DWC3_DGCMD_CMDIOC		BIT(8)
 
 /* Device Generic Command Parameter Register */
-#define DWC3_DGCMDPAR_FORCE_LINKPM_ACCEPT	(1 << 0)
+#define DWC3_DGCMDPAR_FORCE_LINKPM_ACCEPT	BIT(0)
 #define DWC3_DGCMDPAR_FIFO_NUM(n)		((n) << 0)
 #define DWC3_DGCMDPAR_RX_FIFO			(0 << 5)
-#define DWC3_DGCMDPAR_TX_FIFO			(1 << 5)
+#define DWC3_DGCMDPAR_TX_FIFO			BIT(5)
 #define DWC3_DGCMDPAR_LOOPBACK_DIS		(0 << 0)
-#define DWC3_DGCMDPAR_LOOPBACK_ENA		(1 << 0)
+#define DWC3_DGCMDPAR_LOOPBACK_ENA		BIT(0)
 
 /* Device Endpoint Command Register */
 #define DWC3_DEPCMD_PARAM_SHIFT		16
 #define DWC3_DEPCMD_PARAM(x)		((x) << DWC3_DEPCMD_PARAM_SHIFT)
 #define DWC3_DEPCMD_GET_RSC_IDX(x)	(((x) >> DWC3_DEPCMD_PARAM_SHIFT) & 0x7f)
 #define DWC3_DEPCMD_STATUS(x)		(((x) >> 12) & 0x0F)
-#define DWC3_DEPCMD_HIPRI_FORCERM	(1 << 11)
-#define DWC3_DEPCMD_CLEARPENDIN		(1 << 11)
-#define DWC3_DEPCMD_CMDACT		(1 << 10)
-#define DWC3_DEPCMD_CMDIOC		(1 << 8)
+#define DWC3_DEPCMD_HIPRI_FORCERM	BIT(11)
+#define DWC3_DEPCMD_CLEARPENDIN		BIT(11)
+#define DWC3_DEPCMD_CMDACT		BIT(10)
+#define DWC3_DEPCMD_CMDIOC		BIT(8)
 
 #define DWC3_DEPCMD_DEPSTARTCFG		(0x09 << 0)
 #define DWC3_DEPCMD_ENDTRANSFER		(0x08 << 0)
@@ -458,7 +460,7 @@
 #define DWC3_DEPCMD_CMD(x)		((x) & 0xf)
 
 /* The EP number goes 0..31 so ep0 is always out and ep1 is always in */
-#define DWC3_DALEPENA_EP(n)		(1 << n)
+#define DWC3_DALEPENA_EP(n)		BIT(n)
 
 #define DWC3_DEPCMD_TYPE_CONTROL	0
 #define DWC3_DEPCMD_TYPE_ISOC		1
@@ -500,8 +502,8 @@ struct dwc3_event_buffer {
 	struct dwc3		*dwc;
 };
 
-#define DWC3_EP_FLAG_STALLED	(1 << 0)
-#define DWC3_EP_FLAG_WEDGED	(1 << 1)
+#define DWC3_EP_FLAG_STALLED	BIT(0)
+#define DWC3_EP_FLAG_WEDGED	BIT(1)
 
 #define DWC3_EP_DIRECTION_TX	true
 #define DWC3_EP_DIRECTION_RX	false
@@ -550,17 +552,17 @@ struct dwc3_ep {
 
 	u32			saved_state;
 	unsigned		flags;
-#define DWC3_EP_ENABLED		(1 << 0)
-#define DWC3_EP_STALL		(1 << 1)
-#define DWC3_EP_WEDGE		(1 << 2)
-#define DWC3_EP_BUSY		(1 << 4)
-#define DWC3_EP_PENDING_REQUEST	(1 << 5)
-#define DWC3_EP_MISSED_ISOC	(1 << 6)
-#define DWC3_EP_END_TRANSFER_PENDING	(1 << 7)
-#define DWC3_EP_TRANSFER_STARTED (1 << 8)
+#define DWC3_EP_ENABLED		BIT(0)
+#define DWC3_EP_STALL		BIT(1)
+#define DWC3_EP_WEDGE		BIT(2)
+#define DWC3_EP_BUSY		BIT(4)
+#define DWC3_EP_PENDING_REQUEST	BIT(5)
+#define DWC3_EP_MISSED_ISOC	BIT(6)
+#define DWC3_EP_END_TRANSFER_PENDING	BIT(7)
+#define DWC3_EP_TRANSFER_STARTED BIT(8)
 
 	/* This last one is specific to EP0 */
-#define DWC3_EP0_DIR_IN		(1 << 31)
+#define DWC3_EP0_DIR_IN		BIT(31)
 
 	/*
 	 * IMPORTANT: we *know* we have 256 TRBs in our @trb_pool, so we will
@@ -638,13 +640,13 @@ enum dwc3_link_state {
 #define DWC3_TRB_STS_XFER_IN_PROG	4
 
 /* TRB Control */
-#define DWC3_TRB_CTRL_HWO		(1 << 0)
-#define DWC3_TRB_CTRL_LST		(1 << 1)
-#define DWC3_TRB_CTRL_CHN		(1 << 2)
-#define DWC3_TRB_CTRL_CSP		(1 << 3)
+#define DWC3_TRB_CTRL_HWO		BIT(0)
+#define DWC3_TRB_CTRL_LST		BIT(1)
+#define DWC3_TRB_CTRL_CHN		BIT(2)
+#define DWC3_TRB_CTRL_CSP		BIT(3)
 #define DWC3_TRB_CTRL_TRBCTL(n)		(((n) & 0x3f) << 4)
-#define DWC3_TRB_CTRL_ISP_IMI		(1 << 10)
-#define DWC3_TRB_CTRL_IOC		(1 << 11)
+#define DWC3_TRB_CTRL_ISP_IMI		BIT(10)
+#define DWC3_TRB_CTRL_IOC		BIT(11)
 #define DWC3_TRB_CTRL_SID_SOFN(n)	(((n) & 0xffff) << 14)
 
 #define DWC3_TRBCTL_TYPE(n)		((n) & (0x3f << 4))
@@ -746,6 +748,7 @@ struct dwc3_request {
 	unsigned		direction:1;
 	unsigned		mapped:1;
 	unsigned		started:1;
+	unsigned		zero:1;
 };
 
 /*
@@ -758,15 +761,11 @@ struct dwc3_scratchpad_array {
 
 /**
  * struct dwc3 - representation of our controller
- * @ctrl_req: usb control request which is used for ep0
+ * @drd_work - workqueue used for role swapping
  * @ep0_trb: trb which is used for the ctrl_req
- * @ep0_bounce: bounce buffer for ep0
- * @zlp_buf: used when request->zero is set
  * @setup_buf: used while precessing STD USB requests
- * @ctrl_req_addr: dma address of ctrl_req
  * @ep0_trb: dma address of ep0_trb
  * @ep0_usb_req: dummy req used while handling STD USB requests
- * @ep0_bounce_addr: dma address of ep0_bounce
  * @scratch_addr: dma address of scratchbuf
  * @ep0_in_setup: one control transfer is completed and enter setup phase
  * @lock: for synchronizing
@@ -784,6 +783,10 @@ struct dwc3_scratchpad_array {
  * @maximum_speed: maximum speed requested (mainly for testing purposes)
  * @revision: revision register contents
  * @dr_mode: requested mode of operation
+ * @current_dr_role: current role of operation when in dual-role mode
+ * @desired_dr_role: desired role of operation when in dual-role mode
+ * @edev: extcon handle
+ * @edev_nb: extcon notifier
  * @hsphy_mode: UTMI phy mode, one of following:
  *		- USBPHY_INTERFACE_MODE_UTMI
  *		- USBPHY_INTERFACE_MODE_UTMIW
@@ -799,8 +802,7 @@ struct dwc3_scratchpad_array {
  * @u2pel: parameter from Set SEL request.
  * @u1sel: parameter from Set SEL request.
  * @u1pel: parameter from Set SEL request.
- * @num_out_eps: number of out endpoints
- * @num_in_eps: number of in endpoints
+ * @num_eps: number of endpoints
  * @ep0_next_event: hold the next expected event
  * @ep0state: state of endpoint zero
  * @link_state: link state
@@ -858,17 +860,13 @@ struct dwc3_scratchpad_array {
  *                 increments or 0 to disable.
  */
 struct dwc3 {
-	struct usb_ctrlrequest	*ctrl_req;
+	struct work_struct	drd_work;
 	struct dwc3_trb		*ep0_trb;
 	void			*bounce;
-	void			*ep0_bounce;
-	void			*zlp_buf;
 	void			*scratchbuf;
 	u8			*setup_buf;
-	dma_addr_t		ctrl_req_addr;
 	dma_addr_t		ep0_trb_addr;
 	dma_addr_t		bounce_addr;
-	dma_addr_t		ep0_bounce_addr;
 	dma_addr_t		scratch_addr;
 	struct dwc3_request	ep0_usb_req;
 	struct completion	ep0_in_setup;
@@ -900,6 +898,10 @@ struct dwc3 {
 	size_t			regs_size;
 
 	enum usb_dr_mode	dr_mode;
+	u32			current_dr_role;
+	u32			desired_dr_role;
+	struct extcon_dev	*edev;
+	struct notifier_block	edev_nb;
 	enum usb_phy_interface	hsphy_mode;
 
 	u32			fladj;
@@ -960,8 +962,7 @@ struct dwc3 {
 
 	u8			speed;
 
-	u8			num_out_eps;
-	u8			num_in_eps;
+	u8			num_eps;
 
 	struct dwc3_hwparams	hwparams;
 	struct dentry		*root;
@@ -1010,7 +1011,7 @@ struct dwc3 {
 	u16			imod_interval;
 };
 
-/* -------------------------------------------------------------------------- */
+#define work_to_dwc(w)		(container_of((w), struct dwc3, drd_work))
 
 /* -------------------------------------------------------------------------- */
 
@@ -1054,13 +1055,13 @@ struct dwc3_event_depevt {
 	u32	status:4;
 
 /* Within XferNotReady */
-#define DEPEVT_STATUS_TRANSFER_ACTIVE	(1 << 3)
+#define DEPEVT_STATUS_TRANSFER_ACTIVE	BIT(3)
 
 /* Within XferComplete */
-#define DEPEVT_STATUS_BUSERR	(1 << 0)
-#define DEPEVT_STATUS_SHORT	(1 << 1)
-#define DEPEVT_STATUS_IOC	(1 << 2)
-#define DEPEVT_STATUS_LST	(1 << 3)
+#define DEPEVT_STATUS_BUSERR	BIT(0)
+#define DEPEVT_STATUS_SHORT	BIT(1)
+#define DEPEVT_STATUS_IOC	BIT(2)
+#define DEPEVT_STATUS_LST	BIT(3)
 
 /* Stream event only */
 #define DEPEVT_STREAMEVT_FOUND		1
@@ -1221,6 +1222,16 @@ static inline int dwc3_send_gadget_generic_command(struct dwc3 *dwc,
 { return 0; }
 #endif
 
+#if IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE)
+int dwc3_drd_init(struct dwc3 *dwc);
+void dwc3_drd_exit(struct dwc3 *dwc);
+#else
+static inline int dwc3_drd_init(struct dwc3 *dwc)
+{ return 0; }
+static inline void dwc3_drd_exit(struct dwc3 *dwc)
+{ }
+#endif
+
 /* power management interface */
 #if !IS_ENABLED(CONFIG_USB_DWC3_HOST)
 int dwc3_gadget_suspend(struct dwc3 *dwc);
diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
index eeed4ffd8131..cb2d8d3f7f3d 100644
--- a/drivers/usb/dwc3/debug.h
+++ b/drivers/usb/dwc3/debug.h
@@ -124,6 +124,34 @@ dwc3_gadget_link_string(enum dwc3_link_state link_state)
 	}
 }
 
+/**
+ * dwc3_trb_type_string - returns TRB type as a string
+ * @type: the type of the TRB
+ */
+static inline const char *dwc3_trb_type_string(unsigned int type)
+{
+	switch (type) {
+	case DWC3_TRBCTL_NORMAL:
+		return "normal";
+	case DWC3_TRBCTL_CONTROL_SETUP:
+		return "setup";
+	case DWC3_TRBCTL_CONTROL_STATUS2:
+		return "status2";
+	case DWC3_TRBCTL_CONTROL_STATUS3:
+		return "status3";
+	case DWC3_TRBCTL_CONTROL_DATA:
+		return "data";
+	case DWC3_TRBCTL_ISOCHRONOUS_FIRST:
+		return "isoc-first";
+	case DWC3_TRBCTL_ISOCHRONOUS:
+		return "isoc";
+	case DWC3_TRBCTL_LINK_TRB:
+		return "link";
+	default:
+		return "UNKNOWN";
+	}
+}
+
 static inline const char *dwc3_ep0_state_string(enum dwc3_ep0_state state)
 {
 	switch (state) {
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index e689cede9b0e..a78c78e7a8c3 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -39,14 +39,13 @@ static void __dwc3_ep0_do_control_status(struct dwc3 *dwc, struct dwc3_ep *dep);
 static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 		struct dwc3_ep *dep, struct dwc3_request *req);
 
-static void dwc3_ep0_prepare_one_trb(struct dwc3 *dwc, u8 epnum,
+static void dwc3_ep0_prepare_one_trb(struct dwc3_ep *dep,
 		dma_addr_t buf_dma, u32 len, u32 type, bool chain)
 {
 	struct dwc3_trb			*trb;
-	struct dwc3_ep			*dep;
-
-	dep = dwc->eps[epnum];
+	struct dwc3			*dwc;
 
+	dwc = dep->dwc;
 	trb = &dwc->ep0_trb[dep->trb_enqueue];
 
 	if (chain)
@@ -69,16 +68,17 @@ static void dwc3_ep0_prepare_one_trb(struct dwc3 *dwc, u8 epnum,
 	trace_dwc3_prepare_trb(dep, trb);
 }
 
-static int dwc3_ep0_start_trans(struct dwc3 *dwc, u8 epnum)
+static int dwc3_ep0_start_trans(struct dwc3_ep *dep)
 {
 	struct dwc3_gadget_ep_cmd_params params;
-	struct dwc3_ep			*dep;
+	struct dwc3			*dwc;
 	int				ret;
 
-	dep = dwc->eps[epnum];
 	if (dep->flags & DWC3_EP_BUSY)
 		return 0;
 
+	dwc = dep->dwc;
+
 	memset(&params, 0, sizeof(params));
 	params.param0 = upper_32_bits(dwc->ep0_trb_addr);
 	params.param1 = lower_32_bits(dwc->ep0_trb_addr);
@@ -279,13 +279,15 @@ int dwc3_gadget_ep0_set_halt(struct usb_ep *ep, int value)
 
 void dwc3_ep0_out_start(struct dwc3 *dwc)
 {
+	struct dwc3_ep			*dep;
 	int				ret;
 
 	complete(&dwc->ep0_in_setup);
 
-	dwc3_ep0_prepare_one_trb(dwc, 0, dwc->ctrl_req_addr, 8,
+	dep = dwc->eps[0];
+	dwc3_ep0_prepare_one_trb(dep, dwc->ep0_trb_addr, 8,
 			DWC3_TRBCTL_CONTROL_SETUP, false);
-	ret = dwc3_ep0_start_trans(dwc, 0);
+	ret = dwc3_ep0_start_trans(dep);
 	WARN_ON(ret < 0);
 }
 
@@ -794,7 +796,7 @@ static int dwc3_ep0_std_request(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 static void dwc3_ep0_inspect_setup(struct dwc3 *dwc,
 		const struct dwc3_event_depevt *event)
 {
-	struct usb_ctrlrequest *ctrl = dwc->ctrl_req;
+	struct usb_ctrlrequest *ctrl = (void *) dwc->ep0_trb;
 	int ret = -EINVAL;
 	u32 len;
 
@@ -834,7 +836,6 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 	struct usb_request	*ur;
 	struct dwc3_trb		*trb;
 	struct dwc3_ep		*ep0;
-	unsigned		transfer_size = 0;
 	unsigned		maxp;
 	unsigned		remaining_ur_length;
 	void			*buf;
@@ -847,9 +848,7 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 	ep0 = dwc->eps[0];
 
 	dwc->ep0_next_event = DWC3_EP0_NRDY_STATUS;
-
 	trb = dwc->ep0_trb;
-
 	trace_dwc3_complete_trb(ep0, trb);
 
 	r = next_request(&ep0->pending_list);
@@ -870,58 +869,23 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 	remaining_ur_length = ur->length;
 
 	length = trb->size & DWC3_TRB_SIZE_MASK;
-
 	maxp = ep0->endpoint.maxpacket;
-
-	if (dwc->ep0_bounced) {
-		/*
-		 * Handle the first TRB before handling the bounce buffer if
-		 * the request length is greater than the bounce buffer size
-		 */
-		if (ur->length > DWC3_EP0_BOUNCE_SIZE) {
-			transfer_size = ALIGN(ur->length - maxp, maxp);
-			transferred = transfer_size - length;
-			buf = (u8 *)buf + transferred;
-			ur->actual += transferred;
-			remaining_ur_length -= transferred;
-
-			trb++;
-			length = trb->size & DWC3_TRB_SIZE_MASK;
-
-			ep0->trb_enqueue = 0;
-		}
-
-		transfer_size = roundup((ur->length - transfer_size),
-					maxp);
-
-		transferred = min_t(u32, remaining_ur_length,
-				    transfer_size - length);
-		memcpy(buf, dwc->ep0_bounce, transferred);
-	} else {
-		transferred = ur->length - length;
-	}
-
+	transferred = ur->length - length;
 	ur->actual += transferred;
 
-	if ((epnum & 1) && ur->actual < ur->length) {
-		/* for some reason we did not get everything out */
+	if ((IS_ALIGNED(ur->length, ep0->endpoint.maxpacket) &&
+	     ur->length && ur->zero) || dwc->ep0_bounced) {
+		trb++;
+		trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
+		trace_dwc3_complete_trb(ep0, trb);
+		ep0->trb_enqueue = 0;
+		dwc->ep0_bounced = false;
+	}
 
+	if ((epnum & 1) && ur->actual < ur->length)
 		dwc3_ep0_stall_and_restart(dwc);
-	} else {
+	else
 		dwc3_gadget_giveback(ep0, r, 0);
-
-		if (IS_ALIGNED(ur->length, ep0->endpoint.maxpacket) &&
-				ur->length && ur->zero) {
-			int ret;
-
-			dwc->ep0_next_event = DWC3_EP0_COMPLETE;
-
-			dwc3_ep0_prepare_one_trb(dwc, epnum, dwc->ctrl_req_addr,
-					0, DWC3_TRBCTL_CONTROL_DATA, false);
-			ret = dwc3_ep0_start_trans(dwc, epnum);
-			WARN_ON(ret < 0);
-		}
-	}
 }
 
 static void dwc3_ep0_complete_status(struct dwc3 *dwc,
@@ -997,14 +961,13 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 	req->direction = !!dep->number;
 
 	if (req->request.length == 0) {
-		dwc3_ep0_prepare_one_trb(dwc, dep->number,
-				dwc->ctrl_req_addr, 0,
+		dwc3_ep0_prepare_one_trb(dep, dwc->ep0_trb_addr, 0,
 				DWC3_TRBCTL_CONTROL_DATA, false);
-		ret = dwc3_ep0_start_trans(dwc, dep->number);
+		ret = dwc3_ep0_start_trans(dep);
 	} else if (!IS_ALIGNED(req->request.length, dep->endpoint.maxpacket)
 			&& (dep->number == 0)) {
-		u32	transfer_size = 0;
 		u32	maxpacket;
+		u32	rem;
 
 		ret = usb_gadget_map_request_by_dev(dwc->sysdev,
 				&req->request, dep->number);
@@ -1012,36 +975,55 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 			return;
 
 		maxpacket = dep->endpoint.maxpacket;
+		rem = req->request.length % maxpacket;
+		dwc->ep0_bounced = true;
 
-		if (req->request.length > DWC3_EP0_BOUNCE_SIZE) {
-			transfer_size = ALIGN(req->request.length - maxpacket,
-					      maxpacket);
-			dwc3_ep0_prepare_one_trb(dwc, dep->number,
-						   req->request.dma,
-						   transfer_size,
-						   DWC3_TRBCTL_CONTROL_DATA,
-						   true);
-		}
-
-		transfer_size = roundup((req->request.length - transfer_size),
-					maxpacket);
+		/* prepare normal TRB */
+		dwc3_ep0_prepare_one_trb(dep, req->request.dma,
+					 req->request.length,
+					 DWC3_TRBCTL_CONTROL_DATA,
+					 true);
+
+		/* Now prepare one extra TRB to align transfer size */
+		dwc3_ep0_prepare_one_trb(dep, dwc->bounce_addr,
+					 maxpacket - rem,
+					 DWC3_TRBCTL_CONTROL_DATA,
+					 false);
+		ret = dwc3_ep0_start_trans(dep);
+	} else if (IS_ALIGNED(req->request.length, dep->endpoint.maxpacket) &&
+		   req->request.length && req->request.zero) {
+		u32	maxpacket;
+		u32	rem;
 
-		dwc->ep0_bounced = true;
+		ret = usb_gadget_map_request_by_dev(dwc->sysdev,
+				&req->request, dep->number);
+		if (ret)
+			return;
 
-		dwc3_ep0_prepare_one_trb(dwc, dep->number,
-				dwc->ep0_bounce_addr, transfer_size,
-				DWC3_TRBCTL_CONTROL_DATA, false);
-		ret = dwc3_ep0_start_trans(dwc, dep->number);
+		maxpacket = dep->endpoint.maxpacket;
+		rem = req->request.length % maxpacket;
+
+		/* prepare normal TRB */
+		dwc3_ep0_prepare_one_trb(dep, req->request.dma,
+					 req->request.length,
+					 DWC3_TRBCTL_CONTROL_DATA,
+					 true);
+
+		/* Now prepare one extra TRB to align transfer size */
+		dwc3_ep0_prepare_one_trb(dep, dwc->bounce_addr,
+					 0, DWC3_TRBCTL_CONTROL_DATA,
+					 false);
+		ret = dwc3_ep0_start_trans(dep);
 	} else {
 		ret = usb_gadget_map_request_by_dev(dwc->sysdev,
 				&req->request, dep->number);
 		if (ret)
 			return;
 
-		dwc3_ep0_prepare_one_trb(dwc, dep->number, req->request.dma,
+		dwc3_ep0_prepare_one_trb(dep, req->request.dma,
 				req->request.length, DWC3_TRBCTL_CONTROL_DATA,
 				false);
-		ret = dwc3_ep0_start_trans(dwc, dep->number);
+		ret = dwc3_ep0_start_trans(dep);
 	}
 
 	WARN_ON(ret < 0);
@@ -1055,9 +1037,8 @@ static int dwc3_ep0_start_control_status(struct dwc3_ep *dep)
 	type = dwc->three_stage_setup ? DWC3_TRBCTL_CONTROL_STATUS3
 		: DWC3_TRBCTL_CONTROL_STATUS2;
 
-	dwc3_ep0_prepare_one_trb(dwc, dep->number,
-			dwc->ctrl_req_addr, 0, type, false);
-	return dwc3_ep0_start_trans(dwc, dep->number);
+	dwc3_ep0_prepare_one_trb(dep, dwc->ep0_trb_addr, 0, type, false);
+	return dwc3_ep0_start_trans(dep);
 }
 
 static void __dwc3_ep0_do_control_status(struct dwc3 *dwc, struct dwc3_ep *dep)
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 79e7a3480d51..aea9a5b948b4 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -171,7 +171,6 @@ void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
 		int status)
 {
 	struct dwc3			*dwc = dep->dwc;
-	unsigned int			unmap_after_complete = false;
 
 	req->started = false;
 	list_del(&req->list);
@@ -181,19 +180,8 @@ void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
 	if (req->request.status == -EINPROGRESS)
 		req->request.status = status;
 
-	/*
-	 * NOTICE we don't want to unmap before calling ->complete() if we're
-	 * dealing with a bounced ep0 request. If we unmap it here, we would end
-	 * up overwritting the contents of req->buf and this could confuse the
-	 * gadget driver.
-	 */
-	if (dwc->ep0_bounced && dep->number <= 1) {
-		dwc->ep0_bounced = false;
-		unmap_after_complete = true;
-	} else {
-		usb_gadget_unmap_request_by_dev(dwc->sysdev,
-				&req->request, req->direction);
-	}
+	usb_gadget_unmap_request_by_dev(dwc->sysdev,
+					&req->request, req->direction);
 
 	trace_dwc3_gadget_giveback(req);
 
@@ -201,10 +189,6 @@ void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
 	usb_gadget_giveback_request(&dep->endpoint, &req->request);
 	spin_lock(&dwc->lock);
 
-	if (unmap_after_complete)
-		usb_gadget_unmap_request_by_dev(dwc->sysdev,
-				&req->request, req->direction);
-
 	if (dep->number > 1)
 		pm_runtime_put(dwc->dev);
 }
@@ -1060,6 +1044,22 @@ static void dwc3_prepare_one_trb_linear(struct dwc3_ep *dep,
 				false, 0, req->request.stream_id,
 				req->request.short_not_ok,
 				req->request.no_interrupt);
+	} else if (req->request.zero && req->request.length &&
+		   (IS_ALIGNED(req->request.length,dep->endpoint.maxpacket))) {
+		struct dwc3	*dwc = dep->dwc;
+		struct dwc3_trb	*trb;
+
+		req->zero = true;
+
+		/* prepare normal TRB */
+		dwc3_prepare_one_trb(dep, req, true, 0);
+
+		/* Now prepare one extra TRB to handle ZLP */
+		trb = &dep->trb_pool[dep->trb_enqueue];
+		__dwc3_prepare_one_trb(dep, trb, dwc->bounce_addr, 0,
+				false, 0, req->request.stream_id,
+				req->request.short_not_ok,
+				req->request.no_interrupt);
 	} else {
 		dwc3_prepare_one_trb(dep, req, false, 0);
 	}
@@ -1184,8 +1184,11 @@ static void __dwc3_gadget_start_isoc(struct dwc3 *dwc,
 		return;
 	}
 
-	/* 4 micro frames in the future */
-	uf = cur_uf + dep->interval * 4;
+	/*
+	 * Schedule the first trb for one interval in the future or at
+	 * least 4 microframes.
+	 */
+	uf = cur_uf + max_t(u32, 4, dep->interval);
 
 	__dwc3_gadget_kick_transfer(dep, uf);
 }
@@ -1258,45 +1261,30 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 				__dwc3_gadget_start_isoc(dwc, dep, cur_uf);
 				dep->flags &= ~DWC3_EP_PENDING_REQUEST;
 			}
+			return 0;
 		}
-		return 0;
+
+		if ((dep->flags & DWC3_EP_BUSY) &&
+		    !(dep->flags & DWC3_EP_MISSED_ISOC)) {
+			WARN_ON_ONCE(!dep->resource_index);
+			ret = __dwc3_gadget_kick_transfer(dep,
+							  dep->resource_index);
+		}
+
+		goto out;
 	}
 
 	if (!dwc3_calc_trbs_left(dep))
 		return 0;
 
 	ret = __dwc3_gadget_kick_transfer(dep, 0);
+out:
 	if (ret == -EBUSY)
 		ret = 0;
 
 	return ret;
 }
 
-static void __dwc3_gadget_ep_zlp_complete(struct usb_ep *ep,
-		struct usb_request *request)
-{
-	dwc3_gadget_ep_free_request(ep, request);
-}
-
-static int __dwc3_gadget_ep_queue_zlp(struct dwc3 *dwc, struct dwc3_ep *dep)
-{
-	struct dwc3_request		*req;
-	struct usb_request		*request;
-	struct usb_ep			*ep = &dep->endpoint;
-
-	request = dwc3_gadget_ep_alloc_request(ep, GFP_ATOMIC);
-	if (!request)
-		return -ENOMEM;
-
-	request->length = 0;
-	request->buf = dwc->zlp_buf;
-	request->complete = __dwc3_gadget_ep_zlp_complete;
-
-	req = to_dwc3_request(request);
-
-	return __dwc3_gadget_ep_queue(dep, req);
-}
-
 static int dwc3_gadget_ep_queue(struct usb_ep *ep, struct usb_request *request,
 	gfp_t gfp_flags)
 {
@@ -1310,17 +1298,6 @@ static int dwc3_gadget_ep_queue(struct usb_ep *ep, struct usb_request *request,
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	ret = __dwc3_gadget_ep_queue(dep, req);
-
-	/*
-	 * Okay, here's the thing, if gadget driver has requested for a ZLP by
-	 * setting request->zero, instead of doing magic, we will just queue an
-	 * extra usb_request ourselves so that it gets handled the same way as
-	 * any other request.
-	 */
-	if (ret == 0 && request->zero && request->length &&
-	    (request->length % ep->maxpacket == 0))
-		ret = __dwc3_gadget_ep_queue_zlp(dwc, dep);
-
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return ret;
@@ -1400,7 +1377,7 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 					dwc3_ep_inc_deq(dep);
 				}
 
-				if (r->unaligned) {
+				if (r->unaligned || r->zero) {
 					trb = r->trb + r->num_pending_sgs + 1;
 					trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
 					dwc3_ep_inc_deq(dep);
@@ -1411,7 +1388,7 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 				trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
 				dwc3_ep_inc_deq(dep);
 
-				if (r->unaligned) {
+				if (r->unaligned || r->zero) {
 					trb = r->trb + 1;
 					trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
 					dwc3_ep_inc_deq(dep);
@@ -2006,14 +1983,15 @@ static const struct usb_gadget_ops dwc3_gadget_ops = {
 
 /* -------------------------------------------------------------------------- */
 
-static int dwc3_gadget_init_hw_endpoints(struct dwc3 *dwc,
-		u8 num, u32 direction)
+static int dwc3_gadget_init_endpoints(struct dwc3 *dwc, u8 num)
 {
 	struct dwc3_ep			*dep;
-	u8				i;
+	u8				epnum;
+
+	INIT_LIST_HEAD(&dwc->gadget.ep_list);
 
-	for (i = 0; i < num; i++) {
-		u8 epnum = (i << 1) | (direction ? 1 : 0);
+	for (epnum = 0; epnum < num; epnum++) {
+		bool			direction = epnum & 1;
 
 		dep = kzalloc(sizeof(*dep), GFP_KERNEL);
 		if (!dep)
@@ -2021,12 +1999,12 @@ static int dwc3_gadget_init_hw_endpoints(struct dwc3 *dwc,
 
 		dep->dwc = dwc;
 		dep->number = epnum;
-		dep->direction = !!direction;
+		dep->direction = direction;
 		dep->regs = dwc->regs + DWC3_DEP_BASE(epnum);
 		dwc->eps[epnum] = dep;
 
 		snprintf(dep->name, sizeof(dep->name), "ep%d%s", epnum >> 1,
-				(epnum & 1) ? "in" : "out");
+				direction ? "in" : "out");
 
 		dep->endpoint.name = dep->name;
 
@@ -2053,7 +2031,7 @@ static int dwc3_gadget_init_hw_endpoints(struct dwc3 *dwc,
 			/* MDWIDTH is represented in bits, we need it in bytes */
 			mdwidth /= 8;
 
-			size = dwc3_readl(dwc->regs, DWC3_GTXFIFOSIZ(i));
+			size = dwc3_readl(dwc->regs, DWC3_GTXFIFOSIZ(epnum >> 1));
 			size = DWC3_GTXFIFOSIZ_TXFDEF(size);
 
 			/* FIFO Depth is in MDWDITH bytes. Multiply */
@@ -2103,7 +2081,7 @@ static int dwc3_gadget_init_hw_endpoints(struct dwc3 *dwc,
 			dep->endpoint.caps.type_int = true;
 		}
 
-		dep->endpoint.caps.dir_in = !!direction;
+		dep->endpoint.caps.dir_in = direction;
 		dep->endpoint.caps.dir_out = !direction;
 
 		INIT_LIST_HEAD(&dep->pending_list);
@@ -2113,27 +2091,6 @@ static int dwc3_gadget_init_hw_endpoints(struct dwc3 *dwc,
 	return 0;
 }
 
-static int dwc3_gadget_init_endpoints(struct dwc3 *dwc)
-{
-	int				ret;
-
-	INIT_LIST_HEAD(&dwc->gadget.ep_list);
-
-	ret = dwc3_gadget_init_hw_endpoints(dwc, dwc->num_out_eps, 0);
-	if (ret < 0) {
-		dev_err(dwc->dev, "failed to initialize OUT endpoints\n");
-		return ret;
-	}
-
-	ret = dwc3_gadget_init_hw_endpoints(dwc, dwc->num_in_eps, 1);
-	if (ret < 0) {
-		dev_err(dwc->dev, "failed to initialize IN endpoints\n");
-		return ret;
-	}
-
-	return 0;
-}
-
 static void dwc3_gadget_free_endpoints(struct dwc3 *dwc)
 {
 	struct dwc3_ep			*dep;
@@ -2197,7 +2154,7 @@ static int __dwc3_cleanup_done_trbs(struct dwc3 *dwc, struct dwc3_ep *dep,
 	 * with one TRB pending in the ring. We need to manually clear HWO bit
 	 * from that TRB.
 	 */
-	if (req->unaligned && (trb->ctrl & DWC3_TRB_CTRL_HWO)) {
+	if ((req->zero || req->unaligned) && (trb->ctrl & DWC3_TRB_CTRL_HWO)) {
 		trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
 		return 1;
 	}
@@ -2291,11 +2248,12 @@ static int dwc3_cleanup_done_reqs(struct dwc3 *dwc, struct dwc3_ep *dep,
 					event, status, chain);
 		}
 
-		if (req->unaligned) {
+		if (req->unaligned || req->zero) {
 			trb = &dep->trb_pool[dep->trb_dequeue];
 			ret = __dwc3_cleanup_done_trbs(dwc, dep, req, trb,
 					event, status, false);
 			req->unaligned = false;
+			req->zero = false;
 		}
 
 		req->request.actual = length - req->remaining;
@@ -3078,6 +3036,15 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
 		return IRQ_HANDLED;
 	}
 
+	/*
+	 * With PCIe legacy interrupt, test shows that top-half irq handler can
+	 * be called again after HW interrupt deassertion. Check if bottom-half
+	 * irq event handler completes before caching new event to prevent
+	 * losing events.
+	 */
+	if (evt->flags & DWC3_EVENT_PENDING)
+		return IRQ_HANDLED;
+
 	count = dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
 	count &= DWC3_GEVNTCOUNT_MASK;
 	if (!count)
@@ -3161,49 +3128,26 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 
 	dwc->irq_gadget = irq;
 
-	dwc->ctrl_req = dma_alloc_coherent(dwc->sysdev, sizeof(*dwc->ctrl_req),
-			&dwc->ctrl_req_addr, GFP_KERNEL);
-	if (!dwc->ctrl_req) {
-		dev_err(dwc->dev, "failed to allocate ctrl request\n");
-		ret = -ENOMEM;
-		goto err0;
-	}
-
 	dwc->ep0_trb = dma_alloc_coherent(dwc->sysdev,
 					  sizeof(*dwc->ep0_trb) * 2,
 					  &dwc->ep0_trb_addr, GFP_KERNEL);
 	if (!dwc->ep0_trb) {
 		dev_err(dwc->dev, "failed to allocate ep0 trb\n");
 		ret = -ENOMEM;
-		goto err1;
+		goto err0;
 	}
 
-	dwc->setup_buf = kzalloc(DWC3_EP0_BOUNCE_SIZE, GFP_KERNEL);
+	dwc->setup_buf = kzalloc(DWC3_EP0_SETUP_SIZE, GFP_KERNEL);
 	if (!dwc->setup_buf) {
 		ret = -ENOMEM;
-		goto err2;
-	}
-
-	dwc->ep0_bounce = dma_alloc_coherent(dwc->sysdev,
-			DWC3_EP0_BOUNCE_SIZE, &dwc->ep0_bounce_addr,
-			GFP_KERNEL);
-	if (!dwc->ep0_bounce) {
-		dev_err(dwc->dev, "failed to allocate ep0 bounce buffer\n");
-		ret = -ENOMEM;
-		goto err3;
-	}
-
-	dwc->zlp_buf = kzalloc(DWC3_ZLP_BUF_SIZE, GFP_KERNEL);
-	if (!dwc->zlp_buf) {
-		ret = -ENOMEM;
-		goto err4;
+		goto err1;
 	}
 
 	dwc->bounce = dma_alloc_coherent(dwc->sysdev, DWC3_BOUNCE_SIZE,
 			&dwc->bounce_addr, GFP_KERNEL);
 	if (!dwc->bounce) {
 		ret = -ENOMEM;
-		goto err5;
+		goto err2;
 	}
 
 	init_completion(&dwc->ep0_in_setup);
@@ -3241,39 +3185,31 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 	 * sure we're starting from a well known location.
 	 */
 
-	ret = dwc3_gadget_init_endpoints(dwc);
+	ret = dwc3_gadget_init_endpoints(dwc, dwc->num_eps);
 	if (ret)
-		goto err6;
+		goto err3;
 
 	ret = usb_add_gadget_udc(dwc->dev, &dwc->gadget);
 	if (ret) {
 		dev_err(dwc->dev, "failed to register udc\n");
-		goto err6;
+		goto err4;
 	}
 
 	return 0;
-err6:
-	dma_free_coherent(dwc->sysdev, DWC3_BOUNCE_SIZE, dwc->bounce,
-			dwc->bounce_addr);
-
-err5:
-	kfree(dwc->zlp_buf);
 
 err4:
 	dwc3_gadget_free_endpoints(dwc);
-	dma_free_coherent(dwc->sysdev, DWC3_EP0_BOUNCE_SIZE,
-			dwc->ep0_bounce, dwc->ep0_bounce_addr);
 
 err3:
-	kfree(dwc->setup_buf);
+	dma_free_coherent(dwc->sysdev, DWC3_BOUNCE_SIZE, dwc->bounce,
+			dwc->bounce_addr);
 
 err2:
-	dma_free_coherent(dwc->sysdev, sizeof(*dwc->ep0_trb) * 2,
-			dwc->ep0_trb, dwc->ep0_trb_addr);
+	kfree(dwc->setup_buf);
 
 err1:
-	dma_free_coherent(dwc->sysdev, sizeof(*dwc->ctrl_req),
-			dwc->ctrl_req, dwc->ctrl_req_addr);
+	dma_free_coherent(dwc->sysdev, sizeof(*dwc->ep0_trb) * 2,
+			dwc->ep0_trb, dwc->ep0_trb_addr);
 
 err0:
 	return ret;
@@ -3284,22 +3220,12 @@ err0:
 void dwc3_gadget_exit(struct dwc3 *dwc)
 {
 	usb_del_gadget_udc(&dwc->gadget);
-
 	dwc3_gadget_free_endpoints(dwc);
-
 	dma_free_coherent(dwc->sysdev, DWC3_BOUNCE_SIZE, dwc->bounce,
-			dwc->bounce_addr);
-	dma_free_coherent(dwc->sysdev, DWC3_EP0_BOUNCE_SIZE,
-			dwc->ep0_bounce, dwc->ep0_bounce_addr);
-
+			  dwc->bounce_addr);
 	kfree(dwc->setup_buf);
-	kfree(dwc->zlp_buf);
-
 	dma_free_coherent(dwc->sysdev, sizeof(*dwc->ep0_trb) * 2,
-			dwc->ep0_trb, dwc->ep0_trb_addr);
-
-	dma_free_coherent(dwc->sysdev, sizeof(*dwc->ctrl_req),
-			dwc->ctrl_req, dwc->ctrl_req_addr);
+			  dwc->ep0_trb, dwc->ep0_trb_addr);
 }
 
 int dwc3_gadget_suspend(struct dwc3 *dwc)
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index 265e223ab645..e4602d0e515b 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -29,16 +29,16 @@ struct dwc3;
 
 /* DEPCFG parameter 1 */
 #define DWC3_DEPCFG_INT_NUM(n)		(((n) & 0x1f) << 0)
-#define DWC3_DEPCFG_XFER_COMPLETE_EN	(1 << 8)
-#define DWC3_DEPCFG_XFER_IN_PROGRESS_EN	(1 << 9)
-#define DWC3_DEPCFG_XFER_NOT_READY_EN	(1 << 10)
-#define DWC3_DEPCFG_FIFO_ERROR_EN	(1 << 11)
-#define DWC3_DEPCFG_STREAM_EVENT_EN	(1 << 13)
+#define DWC3_DEPCFG_XFER_COMPLETE_EN	BIT(8)
+#define DWC3_DEPCFG_XFER_IN_PROGRESS_EN	BIT(9)
+#define DWC3_DEPCFG_XFER_NOT_READY_EN	BIT(10)
+#define DWC3_DEPCFG_FIFO_ERROR_EN	BIT(11)
+#define DWC3_DEPCFG_STREAM_EVENT_EN	BIT(12)
 #define DWC3_DEPCFG_BINTERVAL_M1(n)	(((n) & 0xff) << 16)
-#define DWC3_DEPCFG_STREAM_CAPABLE	(1 << 24)
+#define DWC3_DEPCFG_STREAM_CAPABLE	BIT(24)
 #define DWC3_DEPCFG_EP_NUMBER(n)	(((n) & 0x1f) << 25)
-#define DWC3_DEPCFG_BULK_BASED		(1 << 30)
-#define DWC3_DEPCFG_FIFO_BASED		(1 << 31)
+#define DWC3_DEPCFG_BULK_BASED		BIT(30)
+#define DWC3_DEPCFG_FIFO_BASED		BIT(31)
 
 /* DEPCFG parameter 0 */
 #define DWC3_DEPCFG_EP_TYPE(n)		(((n) & 0x3) << 1)
@@ -47,10 +47,10 @@ struct dwc3;
 #define DWC3_DEPCFG_BURST_SIZE(n)	(((n) & 0xf) << 22)
 #define DWC3_DEPCFG_DATA_SEQ_NUM(n)	((n) << 26)
 /* This applies for core versions earlier than 1.94a */
-#define DWC3_DEPCFG_IGN_SEQ_NUM		(1 << 31)
+#define DWC3_DEPCFG_IGN_SEQ_NUM		BIT(31)
 /* These apply for core versions 1.94a and later */
 #define DWC3_DEPCFG_ACTION_INIT		(0 << 30)
-#define DWC3_DEPCFG_ACTION_RESTORE	(1 << 30)
+#define DWC3_DEPCFG_ACTION_RESTORE	BIT(30)
 #define DWC3_DEPCFG_ACTION_MODIFY	(2 << 30)
 
 /* DEPXFERCFG parameter 0 */
-- 
2.53.0

