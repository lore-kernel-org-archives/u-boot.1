Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6948B606A31C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ysY2VCGe;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=yGwrPmHm
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E7E880FB3;
	Wed, 28 Oct 2026 14:46:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h7P7gHbKYwSg; Wed, 28 Oct 2026 14:46:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F1BD680F38
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198766;
	b=UO8BB9ri4/cgO1pEJ1Yg5rW2xLtH1QOZHmiV2BqtXBauA4Dzh4Vu7OF9dfvuAzHbaXsl
	 iylAjjR8yp4Lhi0CTrPDWbLm9EvFQJaJ+H0koeW5QwUG5//0veTKc53vbxSDHhAJdqUeu
	 XnjCSr7tGv/8GDFb5BiaYMMos9SAx4AcPiAApDkotlGhO7VykOVa9KUoDADMc+IZAubg7
	 yHyWqnEpV4vrbKzdJd2N4yrzKZEI/MWk/YRo14ubNBwl9pT4SO3i4lBvOFvQp0EG7xBJS
	 IJEgQdB0O6+E6mPckxGJFjv9pzjd1xctZbnF9t9HdheKmTqxsQ2PN9oET9Ax2wenxpw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198766;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Bh+B/TmbyVAU3hRTvK0yiCDIWusj8xwi9ldHyrw+DXA=;
	b=eFAlV0lj1CTF9E2AHfmjJpSrB+WMewajfXHg7SgLsX/K8X6jKXTRNsVzQMDN5oTrG7a5
	 oXgNftTQ220bv2XeTnsuuJIO7TRHMORR8Wq3xAZ5iZjzrFOJzvEjmnZMsF4n1GKAH+Xe/
	 btV4d9ta3KQFcLYWTIoW6MtJFuwnw4+sNHaS/G2GgoWj4XmvusyhwaxtkdjJpgboPf2V0
	 OXjgRZZaSBmNZCOQAcmL5l7tlEWfOdN6UwvocgWTdBG+hBMnDqC7yO+Te9T014PIMm+Gr
	 3a7sLgeVd6SRr3fR0CctyqKacMoWhIjV/P1fA/fm2cAV6BH2wE3duy0p/RgSXBPMxbA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198766;
	bh=Bh+B/TmbyVAU3hRTvK0yiCDIWusj8xwi9ldHyrw+DXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ysY2VCGegvLhj3jRdZj3TtrJzCvk0d6Zp1y8Fz/La3VfPxscq8fpDeTIl4Km0o7Si
	 cbHcv5n8PEzljs2sMvT5uYgqDxLLDHwlN9xVfFQF2y2ib4Sq3CBYwOV1hHdMgPlMer
	 NESeXqkG9XsyqbiqWIRWqh6Mhh0nsrxw03nyIq1a2q6owUQdrsh0niU2NEi9NsPdIR
	 OinSKLGGebPtWjuxD92nrBkoC10ZlpL7ky9Ahgvpzj40aMCaurgGgylEcGNvJrZT5a
	 hpbJMqawEV97xBUUrXbhOxxKXfTU8Qu0oM4nCfaVnm7f0r1RxrUQk05iTIg1UH5LWn
	 zYzSv1AP5a+iw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F1BD680F38;
	Wed, 28 Oct 2026 14:46:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 39E0A4D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:09:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2003E6060A
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:09:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NqV8cuzEKtk2 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:09:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BC180605F1
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196596;
 b=fxrFBG3/MUb/9ckgz7WmFGf8OwRvMsBOgKR2NnjDSpvo42ccoEEAHwocdJ+DEucjRUn0
 e5ANKSHc9WeuB/Tp0b82nxGe07yvOfQjM5GUQZvbkK1jcxtB5yLSQXeSVmIDIJK81xPXx
 n40Lbzhp9/cCewvudjFEBU1qAh+Q5dHWMzIUdNRCAbrGVYrMzsah/USK+dbs8vHkr0RAG
 qL8vjBTg0jzW63cB8eun2ong8LB77p6zsoStHH+CYNqJi8G9KrejX6pIDEX7raLeAZG11
 fk0r6DcrlqzYJ1/dbuMbM88CDTZcxwPb/+nXo/HKLUhtHAXZaIWi+RTnKnnc+jfGmAw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196596;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=Bh+B/TmbyVAU3hRTvK0yiCDIWusj8xwi9ldHyrw+DXA=;
 b=JWqFC7Ys9qCanfizDRI6mwTGedGVt2dmbGVmuJj9PsO4bkbHJiteMorrWsZiwqavDMvo
 Zg/fRm0HCZzqX+UxM3XxLKJc+C2GoN5Wuy3dog3TMtFI4F6JOl7rhwi4TmWn+QTbrMHOi
 GpRAXeSlrHqvO/XB3FkmtvD/AxRr1M+5JLePq0wriggAsIxK8b3nRZQv6dOtjyT7I835n
 nrz8HDYe4xCxuZxFKGfEXJAX1hjAQyIXbBQ4pljNCB273JEPSsa1gpuwDyEVkI4XY2Kwp
 vJ1uIfkdEX9snhQSnnkfAG1LbbqvOgVN9IbPpbm3jk72aoMRsPK4TXSCvT49qIOxR2g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=yGwrPmHm; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=yGwrPmHm
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BC180605F1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:09:55 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c41d20c016fso10141766b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196593; x=1793801393;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Bh+B/TmbyVAU3hRTvK0yiCDIWusj8xwi9ldHyrw+DXA=;
 b=yGwrPmHmtH/ZuT0FnN5Rcyui489o64ryn05Grw/UfnpXTR400VuNHoEAgc2ZNhw3WZ
 I3ZfIVFXXdoSJNSYmQhVkI1bIuOm3Mn6o0qe2Ww010oA2jnTv9H7Ee6sNVRYVkq4/Rov
 35BUTC7wM5NVlXbfnS9/K1FKYEcZAFokaxBJn/n566VX7YegHunEAjNROPc77XTRFymx
 CMkO+99qvoapkC7J0vl47xJJZptq88fK8oO3XbZPrE9yLdpPcwWd1s7mvUCvQTvnCqbo
 d0Peyk/zCu1ZNIFwfprQ/ZQXmgaThd2cdZfhpcGmeYxmU+WF2OpfPsk0olkyxp/BXnhV
 rOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196593; x=1793801393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Bh+B/TmbyVAU3hRTvK0yiCDIWusj8xwi9ldHyrw+DXA=;
 b=fnAh0KqnUStvRdiNpGPPR282/Cd6S+iYhmAYVx1jI4X5Z61irxwOpTr2rzbXmiS6IO
 L7yeIRHzjbX3gRdIzYj8w6mtDOOjX8lC5Gkpo07aUuIQIKG+TIpECqv1wUBiw3BIUjMk
 A8b2JpyJeqD78IVkGgP4quWvOYGBqF86io77Md6TL5LZoWJEoXHEoHvWqmO+NgJLAmkO
 f7ZUICBM/uPsxNNznCoCUAs523m89qMW98jfzFKC7Oxf9VRx1Xs1mk3k4NEdRpi6UlaO
 Kt6r5juAcZMXiDSBhoCZ/GJ+vBcj9WNSAwraSokP4Amu4hA8r+XFl/o1aY9VbyEfri/1
 jPKw==
X-Gm-Message-State: AFq9FYKAYUvGt18USYvK/76zIbgmmJ73+CFTB/lDPe9PBE36nx2+adYE
 ELFBp6lmE+QAId8YShXXXXnwDtuTSHG1YKhau8+RKtsAfoAka7iRyVyIEYpwOxZ692Cx4T2V2RP
 1M87f
X-Gm-Gg: AYBFou1Vv6FeoGwxGpYq82o6eXUn83ZrxymTAqLqxl7ZGmUrduCCMy6uXxYH4Vk2kJg
 8atZ2uRM8hpAllDQwaZiXqbxpDDeJOZK3URHHIBz6Gbz5xVotsgb7kUYQAjYDo6Bq29SOxJaQh7
 Ht7FwEV1CFIT+Qrpwl4Nls3zeDKQGr+4FZFvXultLePe0o6bqMRIBzYZKyghzh7otkkIhDfkiJ1
 ZJFTxZmB0hL67k9dvItKkHhuXb7Ez0usw2J60Lr7d2hzT8VUJC0sYsq0aPKcBxPAOFn5YB5gR0U
 tb20lh6H3TFkgfZaLxTFtpn4PjUu3KnN0uITFCT6YTMziv/l50pCOGKtGnrL42+n9y0Oysny/fb
 oCNt2PLxXfIbqPRmfhdPC1rBi64NsEsVqMpdTdEL8d6Sz5h0d9qmeFLf83q56tFLudEijiMZVem
 qde5WS3367owdYMgnJ8S4YYERnN5hpB6NuDzliyOGLiU8R7GrqQBzRPQfEwnp5+uOgu41a6M38a
 P4YKhKXKGQ2TzYeRTfdrd7CxKo5v+gb1CQwpoqlSxs+5xQnzce30MpPKXda1fOnXZUQWeE1UpMc
 oZ3iU/xrW997S//MHuRJwuSgL7VsYQi+N81Kus36Mszrnx/WQ6I2a271ujavv59Rhhy4mkwYPkB
 gL27oy6CMwQ==
X-Received: by 2002:a17:907:9543:b0:c2e:8801:9139 with SMTP id
 a640c23a62f3a-c49bdd5a5a5mr215114966b.1.1793196593043; 
 Wed, 28 Oct 2026 07:09:53 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd790afasm607807266b.68.2026.10.28.07.09.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:09:52 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 06/63] usb: dwc3: import from kernel v4.2
Date: Wed, 28 Oct 2026 15:08:32 +0100
Message-ID: <20261028140930.3025368-7-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v4.1 to v4.2.

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

List of commits: git log --oneline v4.1..v4.2
Commits imported:
aebda6187181 usb: dwc3: Reset the transfer resource index on SET_INTERFACE
43cacb03aabe usb: dwc3: core: avoid NULL pointer dereference
e18b7975c885 usb: dwc3: gadget: don't clear EP_BUSY too early
76e838c9f776 usb: dwc3: gadget: return error if command sent to DEPCMD register fails
891b1dc02295 usb: dwc3: gadget: return error if command sent to DGCMD register fails
88bc9d194ff6 usb: dwc3: add ULPI interface support
3e10a2ce98d1 usb: dwc3: add hsphy_interface property
45bb7de213d8 usb: dwc3: setup phys earlier
c5cc74e8c12b usb: dwc3: soft reset to it's own function
2917e7181589 usb: dwc3: cache hwparams earlier
6c89cce0476f usb: dwc3: store driver data earlier
f699b94789a6 usb: dwc3: ULPI or UTMI+ select
b5699eeee68f usb: dwc3: USB2 PHY register access bits

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c          | 110 ++++++++++++++++++++++++-------
 drivers/usb/dwc3/core.h          |  26 ++++++++
 drivers/usb/dwc3/ep0.c           |   4 ++
 drivers/usb/dwc3/gadget.c        |  10 ++-
 drivers/usb/dwc3/platform_data.h |   2 +
 5 files changed, 126 insertions(+), 26 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 2bbab3d86fff..ff5773c66b84 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -116,6 +116,33 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
 	return 0;
 }
 
+/**
+ * dwc3_soft_reset - Issue soft reset
+ * @dwc: Pointer to our controller context structure
+ */
+static int dwc3_soft_reset(struct dwc3 *dwc)
+{
+	unsigned long timeout;
+	u32 reg;
+
+	timeout = jiffies + msecs_to_jiffies(500);
+	dwc3_writel(dwc->regs, DWC3_DCTL, DWC3_DCTL_CSFTRST);
+	do {
+		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
+		if (!(reg & DWC3_DCTL_CSFTRST))
+			break;
+
+		if (time_after(jiffies, timeout)) {
+			dev_err(dwc->dev, "Reset Timed Out\n");
+			return -ETIMEDOUT;
+		}
+
+		cpu_relax();
+	} while (true);
+
+	return 0;
+}
+
 /**
  * dwc3_free_one_event_buffer - Frees one event buffer
  * @dwc: Pointer to our controller context structure
@@ -367,10 +394,15 @@ static void dwc3_cache_hwparams(struct dwc3 *dwc)
 /**
  * dwc3_phy_setup - Configure USB PHY Interface of DWC3 Core
  * @dwc: Pointer to our controller context structure
+ *
+ * Returns 0 on success. The USB PHY interfaces are configured but not
+ * initialized. The PHY interfaces and the PHYs get initialized together with
+ * the core in dwc3_core_init.
  */
-static void dwc3_phy_setup(struct dwc3 *dwc)
+static int dwc3_phy_setup(struct dwc3 *dwc)
 {
 	u32 reg;
+	int ret;
 
 	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
 
@@ -409,10 +441,43 @@ static void dwc3_phy_setup(struct dwc3 *dwc)
 
 	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
 
-	mdelay(100);
-
 	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
 
+	/* Select the HS PHY interface */
+	switch (DWC3_GHWPARAMS3_HSPHY_IFC(dwc->hwparams.hwparams3)) {
+	case DWC3_GHWPARAMS3_HSPHY_IFC_UTMI_ULPI:
+		if (dwc->hsphy_interface &&
+				!strncmp(dwc->hsphy_interface, "utmi", 4)) {
+			reg &= ~DWC3_GUSB2PHYCFG_ULPI_UTMI;
+			break;
+		} else if (dwc->hsphy_interface &&
+				!strncmp(dwc->hsphy_interface, "ulpi", 4)) {
+			reg |= DWC3_GUSB2PHYCFG_ULPI_UTMI;
+			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+		} else {
+			dev_warn(dwc->dev, "HSPHY Interface not defined\n");
+
+			/* Relying on default value. */
+			if (!(reg & DWC3_GUSB2PHYCFG_ULPI_UTMI))
+				break;
+		}
+		/* FALLTHROUGH */
+	case DWC3_GHWPARAMS3_HSPHY_IFC_ULPI:
+		/* Making sure the interface and PHY are operational */
+		ret = dwc3_soft_reset(dwc);
+		if (ret)
+			return ret;
+
+		udelay(1);
+
+		ret = dwc3_ulpi_init(dwc);
+		if (ret)
+			return ret;
+		/* FALLTHROUGH */
+	default:
+		break;
+	}
+
 	/*
 	 * Above 1.94a, it is recommended to set DWC3_GUSB2PHYCFG_SUSPHY to
 	 * '0' during coreConsultant configuration. So default value will
@@ -427,7 +492,7 @@ static void dwc3_phy_setup(struct dwc3 *dwc)
 
 	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
 
-	mdelay(100);
+	return 0;
 }
 
 /**
@@ -438,7 +503,6 @@ static void dwc3_phy_setup(struct dwc3 *dwc)
  */
 static int dwc3_core_init(struct dwc3 *dwc)
 {
-	unsigned long		timeout;
 	u32			hwparams4 = dwc->hwparams.hwparams4;
 	u32			reg;
 	int			ret;
@@ -466,21 +530,9 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	}
 
 	/* issue device SoftReset too */
-	timeout = jiffies + msecs_to_jiffies(500);
-	dwc3_writel(dwc->regs, DWC3_DCTL, DWC3_DCTL_CSFTRST);
-	do {
-		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
-		if (!(reg & DWC3_DCTL_CSFTRST))
-			break;
-
-		if (time_after(jiffies, timeout)) {
-			dev_err(dwc->dev, "Reset Timed Out\n");
-			ret = -ETIMEDOUT;
-			goto err0;
-		}
-
-		cpu_relax();
-	} while (true);
+	ret = dwc3_soft_reset(dwc);
+	if (ret)
+		goto err0;
 
 	ret = dwc3_core_soft_reset(dwc);
 	if (ret)
@@ -555,8 +607,6 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
 
-	dwc3_phy_setup(dwc);
-
 	ret = dwc3_alloc_scratch_buffers(dwc);
 	if (ret)
 		goto err1;
@@ -836,6 +886,8 @@ static int dwc3_probe(struct platform_device *pdev)
 				"snps,tx_de_emphasis_quirk");
 		of_property_read_u8(node, "snps,tx_de_emphasis",
 				&tx_de_emphasis);
+		of_property_read_string(node, "snps,hsphy_interface",
+					&dwc->hsphy_interface);
 	} else if (pdata) {
 		dwc->maximum_speed = pdata->maximum_speed;
 		dwc->has_lpm_erratum = pdata->has_lpm_erratum;
@@ -863,6 +915,8 @@ static int dwc3_probe(struct platform_device *pdev)
 		dwc->tx_de_emphasis_quirk = pdata->tx_de_emphasis_quirk;
 		if (pdata->tx_de_emphasis)
 			tx_de_emphasis = pdata->tx_de_emphasis;
+
+		dwc->hsphy_interface = pdata->hsphy_interface;
 	}
 
 	/* default to superspeed if no maximum_speed passed */
@@ -875,12 +929,18 @@ static int dwc3_probe(struct platform_device *pdev)
 	dwc->hird_threshold = hird_threshold
 		| (dwc->is_utmi_l1_suspend << 4);
 
+	platform_set_drvdata(pdev, dwc);
+	dwc3_cache_hwparams(dwc);
+
+	ret = dwc3_phy_setup(dwc);
+	if (ret)
+		goto err0;
+
 	ret = dwc3_core_get_phy(dwc);
 	if (ret)
 		goto err0;
 
 	spin_lock_init(&dwc->lock);
-	platform_set_drvdata(pdev, dwc);
 
 	if (!dev->dma_mask) {
 		dev->dma_mask = dev->parent->dma_mask;
@@ -892,8 +952,6 @@ static int dwc3_probe(struct platform_device *pdev)
 	pm_runtime_get_sync(dev);
 	pm_runtime_forbid(dev);
 
-	dwc3_cache_hwparams(dwc);
-
 	ret = dwc3_alloc_event_buffers(dwc, DWC3_EVENT_BUFFERS_SIZE);
 	if (ret) {
 		dev_err(dwc->dev, "failed to allocate event buffers\n");
@@ -964,6 +1022,7 @@ err2:
 
 err1:
 	dwc3_free_event_buffers(dwc);
+	dwc3_ulpi_exit(dwc);
 
 err0:
 	/*
@@ -999,6 +1058,7 @@ static int dwc3_remove(struct platform_device *pdev)
 	phy_power_off(dwc->usb3_generic_phy);
 
 	dwc3_core_exit(dwc);
+	dwc3_ulpi_exit(dwc);
 
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index c0eafa6fd403..044778884585 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -30,6 +30,7 @@
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/otg.h>
+#include <linux/ulpi/interface.h>
 
 #include <linux/phy/phy.h>
 
@@ -173,6 +174,15 @@
 /* Global USB2 PHY Configuration Register */
 #define DWC3_GUSB2PHYCFG_PHYSOFTRST	(1 << 31)
 #define DWC3_GUSB2PHYCFG_SUSPHY		(1 << 6)
+#define DWC3_GUSB2PHYCFG_ULPI_UTMI	(1 << 4)
+
+/* Global USB2 PHY Vendor Control Register */
+#define DWC3_GUSB2PHYACC_NEWREGREQ	(1 << 25)
+#define DWC3_GUSB2PHYACC_BUSY		(1 << 23)
+#define DWC3_GUSB2PHYACC_WRITE		(1 << 22)
+#define DWC3_GUSB2PHYACC_ADDR(n)	(n << 16)
+#define DWC3_GUSB2PHYACC_EXTEND_ADDR(n)	(n << 8)
+#define DWC3_GUSB2PHYACC_DATA(n)	(n & 0xff)
 
 /* Global USB3 PIPE Control Register */
 #define DWC3_GUSB3PIPECTL_PHYSOFTRST	(1 << 31)
@@ -652,6 +662,7 @@ struct dwc3_scratchpad_array {
  * @usb3_phy: pointer to USB3 PHY
  * @usb2_generic_phy: pointer to USB2 PHY
  * @usb3_generic_phy: pointer to USB3 PHY
+ * @ulpi: pointer to ulpi interface
  * @dcfg: saved contents of DCFG register
  * @gctl: saved contents of GCTL register
  * @isoch_delay: wValue from Set Isochronous Delay request;
@@ -673,6 +684,7 @@ struct dwc3_scratchpad_array {
  * @test_mode_nr: test feature selector
  * @lpm_nyet_threshold: LPM NYET response threshold
  * @hird_threshold: HIRD threshold
+ * @hsphy_interface: "utmi" or "ulpi"
  * @delayed_status: true when gadget driver asks for delayed status
  * @ep0_bounced: true when we used bounce buffer
  * @ep0_expect_in: true when we expect a DATA IN transfer
@@ -739,6 +751,8 @@ struct dwc3 {
 	struct phy		*usb2_generic_phy;
 	struct phy		*usb3_generic_phy;
 
+	struct ulpi		*ulpi;
+
 	void __iomem		*regs;
 	size_t			regs_size;
 
@@ -800,6 +814,8 @@ struct dwc3 {
 	u8			lpm_nyet_threshold;
 	u8			hird_threshold;
 
+	const char		*hsphy_interface;
+
 	unsigned		delayed_status:1;
 	unsigned		ep0_bounced:1;
 	unsigned		ep0_expect_in:1;
@@ -1035,4 +1051,14 @@ static inline int dwc3_gadget_resume(struct dwc3 *dwc)
 }
 #endif /* !IS_ENABLED(CONFIG_USB_DWC3_HOST) */
 
+#if IS_ENABLED(CONFIG_USB_DWC3_ULPI)
+int dwc3_ulpi_init(struct dwc3 *dwc);
+void dwc3_ulpi_exit(struct dwc3 *dwc);
+#else
+static inline int dwc3_ulpi_init(struct dwc3 *dwc)
+{ return 0; }
+static inline void dwc3_ulpi_exit(struct dwc3 *dwc)
+{ }
+#endif
+
 #endif /* __DRIVERS_USB_DWC3_CORE_H */
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 2ef3c8d6a9db..69e769c35cf5 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -727,6 +727,10 @@ static int dwc3_ep0_std_request(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 		dwc3_trace(trace_dwc3_ep0, "USB_REQ_SET_ISOCH_DELAY");
 		ret = dwc3_ep0_set_isoch_delay(dwc, ctrl);
 		break;
+	case USB_REQ_SET_INTERFACE:
+		dwc3_trace(trace_dwc3_ep0, "USB_REQ_SET_INTERFACE");
+		dwc->start_config_issued = false;
+		/* Fall through */
 	default:
 		dwc3_trace(trace_dwc3_ep0, "Forwarding to gadget driver");
 		ret = dwc3_ep0_delegate_req(dwc, ctrl);
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 8946c32047e9..333a7c0078fc 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -291,6 +291,8 @@ int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned cmd, u32 param)
 			dwc3_trace(trace_dwc3_gadget,
 					"Command Complete --> %d",
 					DWC3_DGCMD_STATUS(reg));
+			if (DWC3_DGCMD_STATUS(reg))
+				return -EINVAL;
 			return 0;
 		}
 
@@ -328,6 +330,8 @@ int dwc3_send_gadget_ep_cmd(struct dwc3 *dwc, unsigned ep,
 			dwc3_trace(trace_dwc3_gadget,
 					"Command Complete --> %d",
 					DWC3_DEPCMD_STATUS(reg));
+			if (DWC3_DEPCMD_STATUS(reg))
+				return -EINVAL;
 			return 0;
 		}
 
@@ -1902,12 +1906,16 @@ static void dwc3_endpoint_transfer_complete(struct dwc3 *dwc,
 {
 	unsigned		status = 0;
 	int			clean_busy;
+	u32			is_xfer_complete;
+
+	is_xfer_complete = (event->endpoint_event == DWC3_DEPEVT_XFERCOMPLETE);
 
 	if (event->status & DEPEVT_STATUS_BUSERR)
 		status = -ECONNRESET;
 
 	clean_busy = dwc3_cleanup_done_reqs(dwc, dep, event, status);
-	if (clean_busy)
+	if (clean_busy && (is_xfer_complete ||
+				usb_endpoint_xfer_isoc(dep->endpoint.desc)))
 		dep->flags &= ~DWC3_EP_BUSY;
 
 	/*
diff --git a/drivers/usb/dwc3/platform_data.h b/drivers/usb/dwc3/platform_data.h
index a2bd464be828..d3614ecbb9ca 100644
--- a/drivers/usb/dwc3/platform_data.h
+++ b/drivers/usb/dwc3/platform_data.h
@@ -45,4 +45,6 @@ struct dwc3_platform_data {
 
 	unsigned tx_de_emphasis_quirk:1;
 	unsigned tx_de_emphasis:2;
+
+	const char *hsphy_interface;
 };
-- 
2.53.0

