Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB147606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 08:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rpXSa75/;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=oYRcadSB
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A91D281150;
	Wed,  4 Nov 2026 08:52:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yiw9q-k5wP0f; Wed,  4 Nov 2026 08:52:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EF6038113D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793782344;
	b=nm8MAwJhroPHL7LCrPbJUR0sbn1Y+pRjGqtg7wwQEoCvfkiqxGgbpPanS61XU740h0Rp
	 qAAZox4N5MafsC+rnbL1bpda3jGkK+6G5mxWBvWqzAlDAGWisJp3hgOn6G5L8p89DvwUo
	 bnA9dwxZyLSU8IRKRLmHZlvF9kz12cujtNaWmpOqdtJ00dl8spIGgtPZwubUaPWPYp0gj
	 c8KvGe1j8m/Gn6LiiWHxq/kgPe3nFEP9gi7zz3xitwLhPfkl3UoCdCczoNuuwYEJr6xod
	 wJ71p/Zg64mwkkJ4eug0KHHrT3DgjcprVRfuNEPfwp3fawcBBfal9QA/07nK7ZCSyjQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793782344;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=duY+irzQr0GrRe+0PcnaNJZtnIaEySK9RGY/GVdNZDg=;
	b=RYI/bvpfHVNqG00IuMQUmCf58INLrgNItrBwr0r25Z4TI/tGnAqpcZcBpzeINhIRsiqq
	 gn+I/d4GPGKKqCz28hayp088N3QyYSBA2nkyMy++38L7E8NuZ9WUv8bgRRq2+0psTJVkv
	 Sk7oJQj5InbxiDdwcwrzA8LQgK9j4383NJSw7GzJybPPErl3h0NyfPKfTNsL1GtZvT+wf
	 NmaBEQNiFt+zAmrhMgOLFawo7Qofc3zqvUqBqcZhYNErWMwomog+yrhdA5/Wlu0WO3bqa
	 g04WMK3YwMBjlaEyZsKi+YRM0H8fMxzqgxV3ZcwpgxmrqRmK0qRXU5H4sk7iqKopZfg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793782344;
	bh=duY+irzQr0GrRe+0PcnaNJZtnIaEySK9RGY/GVdNZDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rpXSa75/YcTf0ueAxBnUQsoj8AKjH8PWbcNupeTTowYC7rPDq8bVgbdJgSr2MV7Q3
	 SY2vzyp0k0CXXiPuPhZ039v05ne2qJzmArDZ0ElLM8NnflkZ1V3KDVL3NOAvvfdL4Z
	 SqYBbSMp5zOJ14tiyz2IhksPgMNp0NBBdCWuJ21CA0VyfKSxftWAZGqWcmJCVN3q6p
	 hIkcw3FKWNVSJw25y2/w2c7n/YzjzGnhAeccNk/0zxtKaC4Gh+4FxK0s2vbq4DTxGg
	 Ke845nm1c6u7Dc+TZ2FppgkFyARcClcLUhTEPnrZykIlt/vpItXG5++PMCFmK6bcNo
	 JnD/1nnfssx/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF6038113D;
	Wed,  4 Nov 2026 08:52:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 31D332B6
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:52:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2F5754078C
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:52:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BsSEit2DKHQe for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 08:52:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 57BF740726
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793782339;
 b=dKvSJY62p4Y/vjbH/p60KGglW3TW8M/RiZNgiX27lfITyx2SQWfpV2PPWWySJi/XGpis
 iMDuM3c2mRJuyicCZ4XCFw4ol+oDJifzXN96hsjcx4pCtrPAU/GJlu+W3Woeeu7cciXW5
 yk4h9KOtS7tMWuYnh4f9O6nncPHzJGSIFd2QixBFqKf+83Tj8W/xrP+UICu1J2XXttgSa
 kzowyCWzLgcH2G2aApb1k52TNei+Cqirrz4wAkGLXY51XjpUfNdMIDbz4BBzPJAXaLZQL
 dXIpgEQ5E3Lvyk2AJ833hLrQJf0onKBZRgtHhV76R97VGUDMbwOutVFL4V34g53QSdw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793782339;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=duY+irzQr0GrRe+0PcnaNJZtnIaEySK9RGY/GVdNZDg=;
 b=DVHUGZQrAXsaaxbbE6I7Bs8PkyrKIbRtvwbSKp7HaO6ZBHGw4UMAIpbAwmXjlj9pk/qW
 lQls6agHJ09h6gBiwzGwNYYmse7dIBN7nUcixHgSW30QoTXA4JdB37OMOUe/MOw0pGAwe
 MrzSu5vZCyZYHSiYiIMuXOuCYVWps9BQjlMd0DV7/ZtuWm7qvlRPkw5Z5CLFzoIGLwd8N
 rfxe8e2vEHjftuklqgb5u1MXVPN3pi7QH/w5HrKkVJ5iVOp+n+e/APK+jYac/KQKmG/HV
 JdiyRtjyWOU17JJk8l2AceUnWECswXXoOXQVcAF0dljJOEVDN/SMjMRys5BIJfDpXsg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=amarulasolutions.com;
 dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=oYRcadSB; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=oYRcadSB
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 57BF740726
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:52:19 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a2d6cf958bso1524425e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 00:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1793782337; x=1794387137;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=duY+irzQr0GrRe+0PcnaNJZtnIaEySK9RGY/GVdNZDg=;
 b=oYRcadSBRopIs7Hxqc3jP5Q3qD/AqY9yRuo+jaKFGvHZY0o31gvr+lDxL3frILRc+0
 Kkin++zJHyA618Z+C385uq9gc+q2xBb8ciTBn0z7hqyGAc0U/+c82Rtt7eGBszTLOLRT
 wfQsau804hQFSW996ldJVuqr/MWFR69K87sEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793782337; x=1794387137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=duY+irzQr0GrRe+0PcnaNJZtnIaEySK9RGY/GVdNZDg=;
 b=x5EDCCIBIOraDclzKzbKYSFZJrDvfveAxv40KBZ1PZpMN3Oubx4rbYHphLLcGIqK1p
 FImHrrUeXMAsjevTGO0vZv+vrR6ZLoEgbAsFWCH+zkFEZOJEF5vKvUvZPrzmNqS1SpJn
 xkGywQOp56gi/4mjljHMo8VFahweas0xhLwzJpHtIweDAbRpC0+bTOgRb+IpwHLMX8BR
 txG87Xn8bByc5zJ4DG0nYPUozp/teRhhds7r08uHiUQ+CvMOVxIvuYGI5n4t8mzsp82G
 ZGf/exEWyqSM1+FAHDV03aXHiuH0VOrW0a+Ba8b6u83SiCG+4nB1uMbIiqUWgTSEPQC4
 b4FA==
X-Forwarded-Encrypted: i=1;
 AKwUvByZ3G5RTDsbcQwSbWf9sz0plYVBPc9lLJ6+kRsu4XH2vRZKeIpIj+uaYafXYVBwLD/jA0Yz620=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/Uz5bMQMr6BBgcKCnHJoGQXnVxWHrjALfYjOL9Y8/OfINYS1lC
 66yGmfFrlwgZXlVmQlgEef0wXNPBZsuQd/ru9vhNtJgq07tKpvOMKXem18jknYdFv28=
X-Gm-Gg: AYBFou3m2F8enRbv4+CPlwPlWv4bB9NJbLqe1K8e6HOj9kaCv/36Srq0Pf0webIgiJR
 zC27rLHAe7Y95DIEQ1ddtB/4wZKJepPsF6mLl+NaQ/ZNV+2TfCVyg/dOHybDDihdjfx+XNBoISK
 PMCmmu+JgKQDoClALIl2L5GhNXXi09Hz3GEtq/FbsEQx3a8ODsdo5Nr9gLs74ydWppa4YkC4fxS
 Wy3vpeAKf/JBnNrkhANgEcd/ylSMoQZd8zr0kBNQBaYoxydFh8zvaZv6vcsATlAgzo0paB4DAW1
 hySMRvFcGdY+O3NE3JpPXp3SdHgg9GFJ5UfqE+m+6kfcUObQzh0UrOVCq1uXmFFm3jwDwT7bxEv
 +uFVT3mbJBqTAF5dQjQpeffYhBRaiONohtgHFsU9BHA+jEI1fKjx/wlriRqgLER9w0tXBCDf7PC
 U0bdZYcysNeleg93HEhdGipShU8VfS0aC4Xmzee/rSvNNt3X7cqNAASWm9rtwjtnk7siaOQVGFl
 /byeyJz16c4MGsCGvtH8U0QfJZeDVIxdqiAGZ2p2wfqO/M9XsPS0AuZJ3fFruvgPDzKZzNUeLtj
 lxZpGiC1hwUeKmlJiAy5coIcrZ6fzhRx8zFYZ7ailT2veqESl2QkstYAmHB/y4MOhE/WNQoO4KY
 bV2UPQhgjgyGm64W1eY4olciDWGg=
X-Received: by 2002:a05:600c:3b8f:b0:4a6:42cc:bf66 with SMTP id
 5b1f17b1804b1-4ac16acfdd5mr368013945e9.11.1793782337061; 
 Wed, 04 Nov 2026 00:52:17 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.. ([109.54.139.206])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b413312a4fsm20555915e9.1.2026.11.04.00.52.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 00:52:16 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, u-boot@lists.u-boot-project.org
Subject: [PATCH 27/33] video: simple_panel: add Ampire AM-1280800W8TZQW-T00H
 panel
Date: Wed,  4 Nov 2026 09:50:00 +0100
Message-ID: <20261104085036.4012238-28-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
References: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add timing data for the Ampire AM-1280800W8TZQW-T00H 10.1" LVDS panel
from Linux to the simple-panel driver.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/video/simple_panel.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/video/simple_panel.c b/drivers/video/simple_panel.c
index 1cf587f973be..e674419fd912 100644
--- a/drivers/video/simple_panel.c
+++ b/drivers/video/simple_panel.c
@@ -208,6 +208,23 @@ static const struct panel_ops simple_panel_ops = {
 	.get_modes		= simple_panel_get_modes,
 };
 
+static const struct drm_display_mode ampire_am_1280800w8tzqw_t00h_mode = {
+	.clock = 72400,
+	.hdisplay = 1280,
+	.hsync_start = 1280 + 40,
+	.hsync_end = 1280 + 40 + 80,
+	.htotal = 1280 + 40 + 80 + 40,
+	.vdisplay = 800,
+	.vsync_start = 800 + 10,
+	.vsync_end = 800 + 10 + 18,
+	.vtotal = 800 + 10 + 18 + 10,
+};
+
+static const struct simple_panel_drv_data ampire_am_1280800w8tzqw_t00h_data = {
+	.modes = &ampire_am_1280800w8tzqw_t00h_mode,
+	.num_modes = 1,
+};
+
 static const struct mipi_dsi_panel_plat panasonic_vvx10f004b00 = {
 	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
 		      MIPI_DSI_CLOCK_NON_CONTINUOUS,
@@ -240,6 +257,8 @@ static const struct simple_panel_drv_data tfc_s9700rtwv43tr_01b_data = {
 static const struct udevice_id simple_panel_ids[] = {
 	{ .compatible = "simple-panel" },
 	{ .compatible = "panel-lvds" },
+	{ .compatible = "ampire,am-1280800w8tzqw-t00h",
+	  .data = (ulong)&ampire_am_1280800w8tzqw_t00h_data },
 	{ .compatible = "auo,b133xtn01" },
 	{ .compatible = "auo,b116xw03" },
 	{ .compatible = "auo,b133htn01" },
-- 
2.43.0

