Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C83606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=exI4n7d2;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=h1BZqYTY
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 23E624063A;
	Wed, 28 Oct 2026 14:46:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4lM8km4fAxDc; Wed, 28 Oct 2026 14:46:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1C74C405E7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198762;
	b=rafzakL5GZ+rH9CaX+nt31wL4GHhy2xAUxmbuE75s0C/OOAC/RudnKR0BcfmtPHs4ybT
	 RKiGHqwSUpQ+gKqnmY/aR/RnFnyPqdZ2udJs0N/H5fwgximqIl72b/LBeBsI6VWZZ8xjW
	 y3EZvlYpxOMTEXd6LTbGngebATNDrUaqqZ9Hp6J713FDsRTJ+iPE1qfPUIHQf1n+46gYh
	 Pd6UGiC44SjrR0tH2eUdZPAnK4WnjECQcbsk4lB+1zwut+hUkriLWBXGTh84grtvdC150
	 08NOg+6hlsFCi82dMqg7gbhtZE+Of118v76wmZky//qWX68qkhwIH4rAVqrFj7kOP0Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198762;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ZfeOrQCHiy9VtwIVY+Z+Nl3jTLbRGZzPcndtj9CPfk0=;
	b=Zfjm+Z8U8PGcmBNVIwIizaF3mHIYx4lI7eTcVGXqriC1zFQ/C/2cHGizUajULN6rTovk
	 JdiHOWnirkdl2No09kFIG9f5RR+i2aI3cgHawXR5bK48qXByE8srsfSNnH9EZ1l7x6OdF
	 JTvMVPmL24ypFmKrobDvZ44jXQDjl6O1ve+NDI6MmQ/vPh5aT4qIJoFWU7dshfoIROx5n
	 +qotXTIjMa3ri/Q6q/aVHKwwVQyU9FhXJJR0SXr2MnHD+MQTj6kAfgOHP07ItmGT03IUH
	 pKHH16gFd3r96qi17BhRSE8po8dmEGbMOGtnmXftzVROsxQxLRHeqsafAJkMY8LlYEQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198762;
	bh=ZfeOrQCHiy9VtwIVY+Z+Nl3jTLbRGZzPcndtj9CPfk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=exI4n7d2MRJbOaZcn7O8MuAOUdwfsAukXfZVaTie5T55e33Ldc167sChrBCK/wu2D
	 rTQtqBtq0K0waocAflOQTAe7/UG6yr2Fnz7BcV+S9A1BEnJ7R0pHH+X4g7Rh559oGi
	 SZAf8wH8halN/mQV9SQ8SQec/hZkP3l0/sXlehBiYIzrjShzLpDz0wi4q7WZtCv2/j
	 xVNaO6AOUxC7FMFkFbYWxBFhT8qC+/I46tlFSeYTWa833VGV4FbryQztT2WUx80/x7
	 6uYxJENzxScU2LcKBX6ARpYhsAqWD4ZlIGDCYNGPjZEr6b7W4Yj65Tr+9oYKaKJBql
	 +nrOxz1l/FVPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1C74C405E7;
	Wed, 28 Oct 2026 14:46:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 578F9529
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:09:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3D7B26060B
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:09:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w7aUgtkOaNV2 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:09:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D822B605EB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196595;
 b=s0FrwZRjJ0p1WwXHErb61HKZ1S73bWMay43bs2xk1qGAks3ddxEiQuil186eUENefJad
 2H8f2SBikv+hzr4dSA2STkJ/fgDKPNrOmKx/qr0S2LUCksHxufou5iZbxNf0K2//CRyhy
 T0KAD+K5nC1p8D5Tg4SHM1BAQJMR/mKj+55plezvHFYwgMdZD7MXjhn7Yzai3utIA5hUG
 88IY8Hdy/alMUat8UGGL0mrDy9+3zU/CUqqJvfm+GmNwwes21SBtCoXgohtWlZDrRd5pI
 1stHhBjt+0cnA4aj9YpflD3zDFHYYR0uFzPQVmGyNuch4oetiVTBSM4/wpUypYqsHOw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196595;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=ZfeOrQCHiy9VtwIVY+Z+Nl3jTLbRGZzPcndtj9CPfk0=;
 b=jp6C5d3H3PC/+SyMG7C39gq+nJKhDKXrkKbvfi3ir4pACTLyIJ9q8Lbz9DcU1ZI+5B9b
 fJQDQje4JQuzbtmRUz+QIMDPNSlp6VHlXQs5zTvHBSFsv+/VHrNtpXlBARPLJqeoGRHmN
 zrUyVkluz50W2yx0MR4mW8yKTtD0mRk0ANpu0zY3Hb8uruEqngcmd2solmD1OpFE/jg+m
 /ZwswIhS7xrtha9aKiQYdlQBH2Bmror8mS7FhpYgpv5f9f3pRzBgWcQZS9jOxrkFge9Xb
 RUV9mEBQc+0fj7nEYS1k3kv8f1v+wPIG3Wv+1DRRwqY3x6zJpRoLwuQat7l5pjVXF4A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=h1BZqYTY; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=h1BZqYTY
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D822B605EB
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:09:54 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c4021bc8ce6so11680766b.0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196592; x=1793801392;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZfeOrQCHiy9VtwIVY+Z+Nl3jTLbRGZzPcndtj9CPfk0=;
 b=h1BZqYTYWH8bXs8LSFmvXr8VMTynaRmRvUWttcL8MGGiauijrQ+EJmvt5WC5OdQta4
 UUR6faS6ucsvoJ3Zm9tXm7yeIiaLICPzHqRt3CbUXjv/V202poYbzTWEoK5oUPM5rLCf
 onHTbxuR6F9LxkFmXBdfuBS2MhJX3x5p2sRMMpZepMs+vehEgDw8GSHFgFJ2zkyzsyy+
 Kqod2ZGZyIqq5BnCwDr4EVS8GlnYgYpGvfaZZLFT54uFdVFfpiZmrhnKsHfQQS50dtJ5
 9XZe/KTOPf4hG8jWuVvjPkwTR8rT3XCa9Ugr5WyK66/msbPbltnJLQViH6kMOB07+hLP
 vpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196592; x=1793801392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZfeOrQCHiy9VtwIVY+Z+Nl3jTLbRGZzPcndtj9CPfk0=;
 b=K7rlDYETnC0VyRLJarrgUwU50Od3Lru8X6KEwuKkO8PFkrqTYnGGBSUtGrJhHIAYJn
 QV0pSTbIN8wDOAwjxsE0KLsEiTL0G5JaRtPstiysXW807giKI6S50eHuZnxVKDpzPbjM
 Fi8HRdRQ3YEf0EJo9VtydIddPlRbvJ8tqPPZfpShUd6GG2rEzswXXy/Jbtq3uaSMc4+G
 a4yw0qUgv6zX5zBOHh/VM+L3+M/iO/LXNa624uCmg5YK2QYnTvkSIlxXllxlg1HKBLVg
 UsDiwseul5ms5YI45udJ1/EI0hV+4H5cBIUwnLsx5NA0H0S7rScora26ToZcnwvDVlkr
 lrmg==
X-Gm-Message-State: AFq9FYLtg2Ln5t+dA0RjbDPI0Q6a43MvFXZ0Flsdxu3aVro3oNPftwLk
 at+gZFUTqG/1UT6QIPgJBwjqWoipywg7b8oZhaLGYZgTsyjzzpwFxOKh0pY4LsD7QDsS5YPg9Nu
 6MVf/
X-Gm-Gg: AYBFou2JgA2a8uO1zgIZushGMrX6nMBFAKL3iZgLfHureTvu2ybGC+Sqj3oHfEGx97W
 awkAj9b5urfAjQJ64oOHqqSjKB/qSLGZJBlVbK5I2lcb8k6TFbTD21523uMYCW4ligeF+IsbT6t
 mBO+eLs7Xi+982+AK/BZxeTpr+i81tO0xmL0zdecJE2A7a4rlKJOpU6/45Wy0xCWWRVy00GaeHW
 HbBOI6dl7SuBpnmJ9ap5oMEK5eJ3EBM+BAJdy0hyUz85fyC3snXYQv/uiZXW313hHkO+/kZj+HN
 tJM1+7p0IQ+bSviTFdtD7L51htgw7jrxWwKyDhV2w2cj05GNw0eyx3zbVs4jmQyGxJRHfMqminV
 +JKKEHa58JLaLiZs7cM3ZweifiI2x29VhXj7zXca8f/MghP3jRY6GZQlGNsSDdXzI1PrVT5zHIn
 1shhkoFmD+Gc8YJfr81Ev7I3WyZ8vCntqszqDU8HkxrysKYNA/w8r1tizvTQNbiMAfhKLvHcAd2
 RBB7c3r03bD59N9Ui9MAz91ey2WHRptc2/+zByAFb7E01gfGKYH6etopztQq6+vGzbeVeDyzeq+
 TIRJGbHkp8A3Y3w0IW1ZSK+mBUjGFuzb/I7952mSJXqv5lyp7SPVhkPIenUsgci5YtpmPcBV/jB
 oBIvn94V3aA==
X-Received: by 2002:a17:906:584:b0:c41:8e21:4d62 with SMTP id
 a640c23a62f3a-c49bdd71afdmr212887766b.1.1793196592170; 
 Wed, 28 Oct 2026 07:09:52 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd790afasm607807266b.68.2026.10.28.07.09.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:09:51 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 05/63] usb: dwc3: import from kernel v4.1
Date: Wed, 28 Oct 2026 15:08:31 +0100
Message-ID: <20261028140930.3025368-6-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v4.0 to v4.1.

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

List of commits: git log --oneline v4.0..v4.1
Commits imported:
459e210c4fd0 usb: dwc3: gadget: Fix incorrect DEPCMD and DGCMD status macros
eac68e8f979b usb: dwc3: make LPM configurable in DT
8f2c9544aba6 usb: dwc3: gadget: drop unnecessary loop when cleaning up TRBs
3da1f6ee3563 usb: dwc3: core: only reset res->start in case of error

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c          | 59 ++++++++++++++++++++------------
 drivers/usb/dwc3/core.h          |  6 ++--
 drivers/usb/dwc3/gadget.c        | 37 +++++++++-----------
 drivers/usb/dwc3/platform_data.h |  1 +
 4 files changed, 58 insertions(+), 45 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 9f0e209b8f6c..2bbab3d86fff 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -774,17 +774,13 @@ static int dwc3_probe(struct platform_device *pdev)
 	 * since it will be requested by the xhci-plat driver.
 	 */
 	regs = devm_ioremap_resource(dev, res);
-	if (IS_ERR(regs))
-		return PTR_ERR(regs);
+	if (IS_ERR(regs)) {
+		ret = PTR_ERR(regs);
+		goto err0;
+	}
 
 	dwc->regs	= regs;
 	dwc->regs_size	= resource_size(res);
-	/*
-	 * restore res->start back to its original value so that,
-	 * in case the probe is deferred, we don't end up getting error in
-	 * request the memory region the next time probe is called.
-	 */
-	res->start -= DWC3_GLOBALS_REGS_START;
 
 	/* default to highest possible threshold */
 	lpm_nyet_threshold = 0xff;
@@ -808,6 +804,8 @@ static int dwc3_probe(struct platform_device *pdev)
 				"snps,is-utmi-l1-suspend");
 		of_property_read_u8(node, "snps,hird-threshold",
 				&hird_threshold);
+		dwc->usb3_lpm_capable = of_property_read_bool(node,
+				"snps,usb3_lpm_capable");
 
 		dwc->needs_fifo_resize = of_property_read_bool(node,
 				"tx-fifo-resize");
@@ -848,6 +846,7 @@ static int dwc3_probe(struct platform_device *pdev)
 			hird_threshold = pdata->hird_threshold;
 
 		dwc->needs_fifo_resize = pdata->tx_fifo_resize;
+		dwc->usb3_lpm_capable = pdata->usb3_lpm_capable;
 		dwc->dr_mode = pdata->dr_mode;
 
 		dwc->disable_scramble_quirk = pdata->disable_scramble_quirk;
@@ -878,7 +877,7 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	ret = dwc3_core_get_phy(dwc);
 	if (ret)
-		return ret;
+		goto err0;
 
 	spin_lock_init(&dwc->lock);
 	platform_set_drvdata(pdev, dwc);
@@ -899,7 +898,7 @@ static int dwc3_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(dwc->dev, "failed to allocate event buffers\n");
 		ret = -ENOMEM;
-		goto err0;
+		goto err1;
 	}
 
 	if (IS_ENABLED(CONFIG_USB_DWC3_HOST))
@@ -913,65 +912,81 @@ static int dwc3_probe(struct platform_device *pdev)
 	ret = dwc3_core_init(dwc);
 	if (ret) {
 		dev_err(dev, "failed to initialize core\n");
-		goto err0;
+		goto err1;
 	}
 
 	usb_phy_set_suspend(dwc->usb2_phy, 0);
 	usb_phy_set_suspend(dwc->usb3_phy, 0);
 	ret = phy_power_on(dwc->usb2_generic_phy);
 	if (ret < 0)
-		goto err1;
+		goto err2;
 
 	ret = phy_power_on(dwc->usb3_generic_phy);
 	if (ret < 0)
-		goto err_usb2phy_power;
+		goto err3;
 
 	ret = dwc3_event_buffers_setup(dwc);
 	if (ret) {
 		dev_err(dwc->dev, "failed to setup event buffers\n");
-		goto err_usb3phy_power;
+		goto err4;
 	}
 
 	ret = dwc3_core_init_mode(dwc);
 	if (ret)
-		goto err2;
+		goto err5;
 
 	ret = dwc3_debugfs_init(dwc);
 	if (ret) {
 		dev_err(dev, "failed to initialize debugfs\n");
-		goto err3;
+		goto err6;
 	}
 
 	pm_runtime_allow(dev);
 
 	return 0;
 
-err3:
+err6:
 	dwc3_core_exit_mode(dwc);
 
-err2:
+err5:
 	dwc3_event_buffers_cleanup(dwc);
 
-err_usb3phy_power:
+err4:
 	phy_power_off(dwc->usb3_generic_phy);
 
-err_usb2phy_power:
+err3:
 	phy_power_off(dwc->usb2_generic_phy);
 
-err1:
+err2:
 	usb_phy_set_suspend(dwc->usb2_phy, 1);
 	usb_phy_set_suspend(dwc->usb3_phy, 1);
 	dwc3_core_exit(dwc);
 
-err0:
+err1:
 	dwc3_free_event_buffers(dwc);
 
+err0:
+	/*
+	 * restore res->start back to its original value so that, in case the
+	 * probe is deferred, we don't end up getting error in request the
+	 * memory region the next time probe is called.
+	 */
+	res->start -= DWC3_GLOBALS_REGS_START;
+
 	return ret;
 }
 
 static int dwc3_remove(struct platform_device *pdev)
 {
 	struct dwc3	*dwc = platform_get_drvdata(pdev);
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	/*
+	 * restore res->start back to its original value so that, in case the
+	 * probe is deferred, we don't end up getting error in request the
+	 * memory region the next time probe is called.
+	 */
+	res->start -= DWC3_GLOBALS_REGS_START;
 
 	dwc3_debugfs_exit(dwc);
 	dwc3_core_exit_mode(dwc);
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index d201910b892f..c0eafa6fd403 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -339,7 +339,7 @@
 #define DWC3_DGCMD_SET_ENDPOINT_NRDY	0x0c
 #define DWC3_DGCMD_RUN_SOC_BUS_LOOPBACK	0x10
 
-#define DWC3_DGCMD_STATUS(n)		(((n) >> 15) & 1)
+#define DWC3_DGCMD_STATUS(n)		(((n) >> 12) & 0x0F)
 #define DWC3_DGCMD_CMDACT		(1 << 10)
 #define DWC3_DGCMD_CMDIOC		(1 << 8)
 
@@ -355,7 +355,7 @@
 #define DWC3_DEPCMD_PARAM_SHIFT		16
 #define DWC3_DEPCMD_PARAM(x)		((x) << DWC3_DEPCMD_PARAM_SHIFT)
 #define DWC3_DEPCMD_GET_RSC_IDX(x)	(((x) >> DWC3_DEPCMD_PARAM_SHIFT) & 0x7f)
-#define DWC3_DEPCMD_STATUS(x)		(((x) >> 15) & 1)
+#define DWC3_DEPCMD_STATUS(x)		(((x) >> 12) & 0x0F)
 #define DWC3_DEPCMD_HIPRI_FORCERM	(1 << 11)
 #define DWC3_DEPCMD_CMDACT		(1 << 10)
 #define DWC3_DEPCMD_CMDIOC		(1 << 8)
@@ -689,6 +689,7 @@ struct dwc3_scratchpad_array {
  * @setup_packet_pending: true when there's a Setup Packet in FIFO. Workaround
  * @start_config_issued: true when StartConfig command has been issued
  * @three_stage_setup: set if we perform a three phase setup
+ * @usb3_lpm_capable: set if hadrware supports Link Power Management
  * @disable_scramble_quirk: set if we enable the disable scramble quirk
  * @u2exit_lfps_quirk: set if we enable u2exit lfps quirk
  * @u2ss_inp3_quirk: set if we enable P3 OK for U2/SS Inactive quirk
@@ -812,6 +813,7 @@ struct dwc3 {
 	unsigned		setup_packet_pending:1;
 	unsigned		start_config_issued:1;
 	unsigned		three_stage_setup:1;
+	unsigned		usb3_lpm_capable:1;
 
 	unsigned		disable_scramble_quirk:1;
 	unsigned		u2exit_lfps_quirk:1;
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index a03a485205c7..8946c32047e9 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1855,32 +1855,27 @@ static int dwc3_cleanup_done_reqs(struct dwc3 *dwc, struct dwc3_ep *dep,
 	unsigned int		i;
 	int			ret;
 
+	req = next_request(&dep->req_queued);
+	if (!req) {
+		WARN_ON_ONCE(1);
+		return 1;
+	}
+	i = 0;
 	do {
-		req = next_request(&dep->req_queued);
-		if (!req) {
-			WARN_ON_ONCE(1);
-			return 1;
-		}
-		i = 0;
-		do {
-			slot = req->start_slot + i;
-			if ((slot == DWC3_TRB_NUM - 1) &&
+		slot = req->start_slot + i;
+		if ((slot == DWC3_TRB_NUM - 1) &&
 				usb_endpoint_xfer_isoc(dep->endpoint.desc))
-				slot++;
-			slot %= DWC3_TRB_NUM;
-			trb = &dep->trb_pool[slot];
-
-			ret = __dwc3_cleanup_done_trbs(dwc, dep, req, trb,
-					event, status);
-			if (ret)
-				break;
-		}while (++i < req->request.num_mapped_sgs);
-
-		dwc3_gadget_giveback(dep, req, status);
+			slot++;
+		slot %= DWC3_TRB_NUM;
+		trb = &dep->trb_pool[slot];
 
+		ret = __dwc3_cleanup_done_trbs(dwc, dep, req, trb,
+				event, status);
 		if (ret)
 			break;
-	} while (1);
+	} while (++i < req->request.num_mapped_sgs);
+
+	dwc3_gadget_giveback(dep, req, status);
 
 	if (usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
 			list_empty(&dep->req_queued)) {
diff --git a/drivers/usb/dwc3/platform_data.h b/drivers/usb/dwc3/platform_data.h
index a3a3b6d5668c..a2bd464be828 100644
--- a/drivers/usb/dwc3/platform_data.h
+++ b/drivers/usb/dwc3/platform_data.h
@@ -24,6 +24,7 @@ struct dwc3_platform_data {
 	enum usb_device_speed maximum_speed;
 	enum usb_dr_mode dr_mode;
 	bool tx_fifo_resize;
+	bool usb3_lpm_capable;
 
 	unsigned is_utmi_l1_suspend:1;
 	u8 hird_threshold;
-- 
2.53.0

