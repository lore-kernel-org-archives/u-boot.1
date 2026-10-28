Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163C1606A31C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fH8iAqln;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=dsM5vGMf
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C375481470;
	Wed, 28 Oct 2026 14:49:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id foHaQnbvKONB; Wed, 28 Oct 2026 14:49:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C430A811E1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198860;
	b=RZhNJKD1kk2AmO/W6GPD1uqstvoj2EmWy7acw9zRJoXgDGwqhHUuYP6iw3ehGR9mKBk6
	 03MY47R+H0p6Cy3Sex8tuiRXlcwW6gCSzoN3/DjFN2hOQBSdRrmppYdGygTRXokbuDYxZ
	 diKWGfWOCy8d1Pvx/SWA0QN0a20Au8l5/Qn4TPYPODIpfCp1s/SiMsRTUwv7r8Zq0EhzG
	 CAhYzxeCAHhdmM0Q5LWR7MKOobz1hxXrwOoa8kkT2EdRmwCzRNslwpHP2Ns2ytgOFNmEF
	 Id4CQVvjYxL0GWrHqWNAPsQwmPSno8TLKSs5qZYADgtKnzbr+2JejD6wXhAzh1ONrNQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198860;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nM5bY1ZfJVqY3TBpEZPLy0Pbz02Wk3i27SowhRb7xqU=;
	b=iZMCwR9jUKnghEKeWGCJ4BEflbLy59xnhkHi+CAxdrJjJ5iUh4q9Zg+pYfz+8USLcFbs
	 hoSpDt5SR8Si6ophrd/J9pn9FgIJIbVs6cyBW5JbVppx90YsWTzDtaqX88AW4ps1vcsxq
	 kruucDF+gyp3KP59NCiKnrwPJAYnH/i+TCVIZEGfxy9xrvmCu+8ozfQs0XINo+65PAvnV
	 6NHh+GXFdDplF6+6HFg6PoMMPSFJtdDjZBRE/cncKV7G7EYRLqqrM9hHYSGS+cj+Ve+Gx
	 wp/TZh4imeNsPs0DHJIWYb2UgzIHKt5nZEE5QW6ZDs92deCAAlj0ROgnYIzo1QSwc2g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=dsM5vGMf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198860;
	bh=nM5bY1ZfJVqY3TBpEZPLy0Pbz02Wk3i27SowhRb7xqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fH8iAqln2bE9DWvGfZf8tNSM4MHAEwOQZVLppFBID4BSYP0XHRV1QXuYjN6pNcXSQ
	 BL+tf7LtBsF7CObmf3tqDp/lLHK4Q/yWylh475e9FXCUF1DkM/Rr51rgmSBxH1XkrP
	 AEAgY/UvE0SeZ5kvDPQyGkaP9Oe8K9hnhk5/fgLf7PQdyT3mlk+B17RhA4NKFjlU1K
	 /xjcP/2W0JJsWGrlG7jYXnUQOIvcUb7T4pKAWI5yxMQOFUUXHVJZh2zUSPWh1k5e2+
	 xDuC00jZic8OPJBx5phrok6LTAuRZbCgnZsp0USPfp1axu6gWCjtx2/fiYeGZWon7s
	 luA6cIa+sKetw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C430A811E1;
	Wed, 28 Oct 2026 14:47:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1C2474D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:14:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0DC8080C1A
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:14:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 966U5hlktZ1F for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:14:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C9F7280AEA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196850;
 b=bTW+hk8KRwtu+NgkzvdlB5XFc+AX7QZHlggvUDAjSty7O7LbGieb6sZvZb5y1IetFYcp
 sUPf2I4hhqF01wrIEFIxRDCRNZsrXII9HEFx3Suw/N4I8AjOrHWLNdZrd57NGEZ1ZcIp4
 glrt7wqY/X0bEVISxr/AazFEINV+wOgC94ckW3s+EQGYjyzDdIgDQkCYMcV34NHAT4az+
 rMRj0pAQZpVwbZEml6cGvrLnh/kQHvcikhHOwvogCXxx7h+hRJBqQx9nokWoVGKHpbxnI
 P3S1TthUTdml6raucrvxKm9v+HQhPspd869oZvsJXDoe6GCpvvB0137j1EGTO+Ecivw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196850;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=nM5bY1ZfJVqY3TBpEZPLy0Pbz02Wk3i27SowhRb7xqU=;
 b=FiIDBq0gbVvcW+hc+0hcfslUzGuqpJd9j+Zq6tEHXxM85H2K0/iESwfoSRKWkZPnVlwK
 rRKpCvOnl8JcBTqx3qiM5s7px92rJJIaCx2AS7mY7okk8QnLsMLmiHNB6Ti9r69UH6/2G
 RuPGKOMLJHMn0GTPuCVb9TFylfav+GLMDPPOapGvbfgV/12H8Noc5eB8M7Riw4tTsxcOl
 1xOjNAuBndPOvdvfYyPvL3Xb8IXNshn/gc1xQAeItWyKeuR5fRCxyTCnISEelEIADuqS/
 9cgJFJ7ClYJvOa0jGI1w4DyHBXuTUhqCMGTo6XQMPFoON+lBRRxuJC6gzuH7mfU2OeQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=dsM5vGMf; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=dsM5vGMf
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C9F7280AEA
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:14:09 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c40aa03a96fso11238866b.1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196847; x=1793801647;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nM5bY1ZfJVqY3TBpEZPLy0Pbz02Wk3i27SowhRb7xqU=;
 b=dsM5vGMfGGgGMl+Btdcn+gO1TBlQcAT04L+bsAWZ75a1/8bE/82WhRlV8gtwrLQxvx
 32ASq0LnFcqA7S33dbBtJmolufmLygmktCK6KfgOV0nkuP1kUBfq0ew8vcbC12UstTCx
 fDDgi+K4upi9WSuEjgFr/rcALqjpbFK2iOlMHhJkAz0P6xKWKezzSDOsHf1lK6cJ/dUa
 ORadJDiM+AsyyceejsV00yvVXq5snIlymVpoqDF8cJwh2ekMEyo4dDUdhXl6hXuhzIq1
 NGx4UiXt/mTa8yqX2l83cy1F5P+8YzDMd9BFN6LhIlUCmzSWgwxksa12oVgTdVLcJH8I
 rdfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196847; x=1793801647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nM5bY1ZfJVqY3TBpEZPLy0Pbz02Wk3i27SowhRb7xqU=;
 b=StKnoukT6j6Mg26IyhzD9WXVJvi0zZkEtEaqvdUOliFOXoaTTh1lwF4onVBFUBudCe
 GE369yb/5fOTL0P2/hmMbSfjOa2No4ICvdprnMI99/zW87ObCYcREVT0y+On9gmUA+Cs
 xwSlfoqgR2XTBOJ/j0Bcn1ArBORdANNJ+Q/bkX5rH8d6mejHIHm7G2HOJ+X85pVZHAdt
 by47YHmVLVyT8nubp67m/ZSKEDxD6Q3vSvUdcZeAM7ygVLFb17Mehb9wEvY3I98bOkyZ
 UtM6mtK5HY7kjtfby2AgKC0cfgzZQxjQjzCw98E55lLd6PzT7vJXDGolE/gLe1gUOY6u
 jShQ==
X-Gm-Message-State: AFq9FYKhQLXsuZ/WEUWjSEbFEh36vDy4Er+JO2s/EA7QJi1goHwJHcec
 8KevjZqlW6y87VI/SrSQcJJ4AWxxIlqrkBQjSGVmOfI0u598HCf2xt1k2kXBMUS2lzKb0NepLie
 IBUM5
X-Gm-Gg: AYBFou3pJGfDQMCU2iqe7QoTp59wNS8iXm5YRvLrwZR5NsH6UAP3u0QRnGtY8j7PJW+
 9meUmFxRhBvSrgre3dZenNlJAkWDY4IfnV3gnr8EH0XhkQe8HOOQc4sGHQzX4TiEwlBoeedm7rs
 jp2v1k5gQG+24VMEE0opLkONXU0CjX9O482ZfviB19MEm+qfHE0bubbp7MoOMHc6Ktx3nkNFMD8
 ChgzbLiLJIJOxx6kzff2+YCy/MJdyT0NoKXrw4/nnXKWwHltO14s9qVhqItRVtAmyyE35HFsRiJ
 xxqoTPeg54qn9hXRbQ4n3ajNZkuBEasZm+40dOJwG8fugd/ddbqEQifzu7YOMVW+Yd95HVwuh7k
 xv8xYs0oENiIEvVH0zgUFwVIJVcYLEEvSAzrkLcHR8BePO1RwI/NuKSFELPPAPIGwDtC5phLrVW
 mpUjYFU6nCE/PX8GONYRbr5FALj1PXUOeIkX/gCM2/Ff9RTttkTMOC4dics2hDqYO6vyUvpHrts
 /TprPcJf01MFjPzjT3n3zf9X4+LY3lPjOP650aYXMOak8LbuX7VN5gYZ6GiA5U+GpPy8/oQGr7o
 o2zVfgD94SnTFXxELiq4uCxcd5mgq90plKAAiGz3foUHy5ZVHob2quo3c0D4US7rGSjFLQ1wKQJ
 bLYW3UHQxnSO2/fmKzPbuGLz6cuUaUlU=
X-Received: by 2002:a17:907:180b:b0:c25:2ded:ad36 with SMTP id
 a640c23a62f3a-c49bda65ea2mr310032466b.0.1793196847395; 
 Wed, 28 Oct 2026 07:14:07 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd524271sm628414666b.35.2026.10.28.07.14.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:14:07 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 57/63] usb: dwc3: import from kernel v6.12
Date: Wed, 28 Oct 2026 15:09:23 +0100
Message-ID: <20261028140930.3025368-58-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v6.11 to v6.12.

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

List of commits: git log --oneline v6.11..v6.12
Commits imported:
9cfb31e4c89d usb: dwc3: fix fault at system suspend if device was already runtime suspended
705e3ce37bcc usb: dwc3: core: Fix system suspend on TI AM62 platforms
c96e31252110 usb: dwc3: Wait for EndXfer completion before restoring GUSB2PHYCFG
0d410e8913f5 usb: dwc3: core: Stop processing of pending events if controller is halted
897e13a8f9a2 usb: dwc3: re-enable runtime PM after failed resume

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c   | 48 ++++++++++++++++++++++++++++++++-------
 drivers/usb/dwc3/core.h   |  7 +++---
 drivers/usb/dwc3/gadget.c | 21 +++++------------
 3 files changed, 49 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 9eb085f359ce..98114c2827c0 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -544,6 +544,7 @@ static int dwc3_alloc_event_buffers(struct dwc3 *dwc, unsigned int length)
 int dwc3_event_buffers_setup(struct dwc3 *dwc)
 {
 	struct dwc3_event_buffer	*evt;
+	u32				reg;
 
 	if (!dwc->ev_buf)
 		return 0;
@@ -556,8 +557,10 @@ int dwc3_event_buffers_setup(struct dwc3 *dwc)
 			upper_32_bits(evt->dma));
 	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
 			DWC3_GEVNTSIZ_SIZE(evt->length));
-	dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), 0);
 
+	/* Clear any stale event */
+	reg = dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
+	dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), reg);
 	return 0;
 }
 
@@ -584,7 +587,10 @@ void dwc3_event_buffers_cleanup(struct dwc3 *dwc)
 	dwc3_writel(dwc->regs, DWC3_GEVNTADRHI(0), 0);
 	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0), DWC3_GEVNTSIZ_INTMASK
 			| DWC3_GEVNTSIZ_SIZE(0));
-	dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), 0);
+
+	/* Clear any stale event */
+	reg = dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
+	dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), reg);
 }
 
 static void dwc3_core_num_eps(struct dwc3 *dwc)
@@ -2336,6 +2342,19 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 	u32 reg;
 	int i;
 
+	if (!pm_runtime_suspended(dwc->dev) && !PMSG_IS_AUTO(msg)) {
+		dwc->susphy_state = (dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0)) &
+				    DWC3_GUSB2PHYCFG_SUSPHY) ||
+				    (dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0)) &
+				    DWC3_GUSB3PIPECTL_SUSPHY);
+		/*
+		 * TI AM62 platform requires SUSPHY to be
+		 * enabled for system suspend to work.
+		 */
+		if (!dwc->susphy_state)
+			dwc3_enable_susphy(dwc, true);
+	}
+
 	switch (dwc->current_dr_role) {
 	case DWC3_GCTL_PRTCAP_DEVICE:
 		if (pm_runtime_suspended(dwc->dev))
@@ -2454,6 +2473,11 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 		break;
 	}
 
+	if (!PMSG_IS_AUTO(msg)) {
+		/* restore SUSPHY state to that before system suspend. */
+		dwc3_enable_susphy(dwc, dwc->susphy_state);
+	}
+
 	return 0;
 }
 
@@ -2499,7 +2523,11 @@ static int dwc3_runtime_resume(struct device *dev)
 
 	switch (dwc->current_dr_role) {
 	case DWC3_GCTL_PRTCAP_DEVICE:
-		dwc3_gadget_process_pending_events(dwc);
+		if (dwc->pending_events) {
+			pm_runtime_put(dwc->dev);
+			dwc->pending_events = false;
+			enable_irq(dwc->irq_gadget);
+		}
 		break;
 	case DWC3_GCTL_PRTCAP_HOST:
 	default:
@@ -2552,7 +2580,7 @@ static int dwc3_suspend(struct device *dev)
 static int dwc3_resume(struct device *dev)
 {
 	struct dwc3	*dwc = dev_get_drvdata(dev);
-	int		ret;
+	int		ret = 0;
 
 	pinctrl_pm_select_default_state(dev);
 
@@ -2560,14 +2588,12 @@ static int dwc3_resume(struct device *dev)
 	pm_runtime_set_active(dev);
 
 	ret = dwc3_resume_common(dwc, PMSG_RESUME);
-	if (ret) {
+	if (ret)
 		pm_runtime_set_suspended(dev);
-		return ret;
-	}
 
 	pm_runtime_enable(dev);
 
-	return 0;
+	return ret;
 }
 
 static void dwc3_complete(struct device *dev)
@@ -2589,6 +2615,12 @@ static void dwc3_complete(struct device *dev)
 static const struct dev_pm_ops dwc3_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(dwc3_suspend, dwc3_resume)
 	.complete = dwc3_complete,
+
+	/*
+	 * Runtime suspend halts the controller on disconnection. It relies on
+	 * platforms with custom connection notification to start the controller
+	 * again.
+	 */
 	SET_RUNTIME_PM_OPS(dwc3_runtime_suspend, dwc3_runtime_resume,
 			dwc3_runtime_idle)
 };
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index c71240e8f7c7..eab81dfdcc35 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1150,6 +1150,8 @@ struct dwc3_scratchpad_array {
  * @sys_wakeup: set if the device may do system wakeup.
  * @wakeup_configured: set if the device is configured for remote wakeup.
  * @suspended: set to track suspend event due to U3/L2.
+ * @susphy_state: state of DWC3_GUSB2PHYCFG_SUSPHY + DWC3_GUSB3PIPECTL_SUSPHY
+ *		  before PM suspend.
  * @imod_interval: set the interrupt moderation interval in 250ns
  *			increments or 0 to disable.
  * @max_cfg_eps: current max number of IN eps used across all USB configs.
@@ -1382,6 +1384,7 @@ struct dwc3 {
 	unsigned		sys_wakeup:1;
 	unsigned		wakeup_configured:1;
 	unsigned		suspended:1;
+	unsigned		susphy_state:1;
 
 	u16			imod_interval;
 
@@ -1675,7 +1678,6 @@ static inline void dwc3_otg_host_init(struct dwc3 *dwc)
 #if !IS_ENABLED(CONFIG_USB_DWC3_HOST)
 int dwc3_gadget_suspend(struct dwc3 *dwc);
 int dwc3_gadget_resume(struct dwc3 *dwc);
-void dwc3_gadget_process_pending_events(struct dwc3 *dwc);
 #else
 static inline int dwc3_gadget_suspend(struct dwc3 *dwc)
 {
@@ -1687,9 +1689,6 @@ static inline int dwc3_gadget_resume(struct dwc3 *dwc)
 	return 0;
 }
 
-static inline void dwc3_gadget_process_pending_events(struct dwc3 *dwc)
-{
-}
 #endif /* !IS_ENABLED(CONFIG_USB_DWC3_HOST) */
 
 #if IS_ENABLED(CONFIG_USB_DWC3_ULPI)
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 291bc549935b..4959c26d3b71 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -438,6 +438,10 @@ skip_status:
 			dwc3_gadget_ep_get_transfer_index(dep);
 	}
 
+	if (DWC3_DEPCMD_CMD(cmd) == DWC3_DEPCMD_ENDTRANSFER &&
+	    !(cmd & DWC3_DEPCMD_CMDIOC))
+		mdelay(1);
+
 	if (saved_config) {
 		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
 		reg |= saved_config;
@@ -1715,12 +1719,10 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool int
 	WARN_ON_ONCE(ret);
 	dep->resource_index = 0;
 
-	if (!interrupt) {
-		mdelay(1);
+	if (!interrupt)
 		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
-	} else if (!ret) {
+	else if (!ret)
 		dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
-	}
 
 	dep->flags &= ~DWC3_EP_DELAY_STOP;
 	return ret;
@@ -4728,14 +4730,3 @@ int dwc3_gadget_resume(struct dwc3 *dwc)
 
 	return dwc3_gadget_soft_connect(dwc);
 }
-
-void dwc3_gadget_process_pending_events(struct dwc3 *dwc)
-{
-	if (dwc->pending_events) {
-		dwc3_interrupt(dwc->irq_gadget, dwc->ev_buf);
-		dwc3_thread_interrupt(dwc->irq_gadget, dwc->ev_buf);
-		pm_runtime_put(dwc->dev);
-		dwc->pending_events = false;
-		enable_irq(dwc->irq_gadget);
-	}
-}
-- 
2.53.0

