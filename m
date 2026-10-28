Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FED606A320
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jHBksvuK;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PhEpQgzM
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C18544082B;
	Wed, 28 Oct 2026 14:47:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PulPJfyo--ud; Wed, 28 Oct 2026 14:47:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 844DB4051D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198850;
	b=X/PmoANEPJtMZc6oO9OBK9KxqcVjLaQ3f/KH7YTLTorhyQv8N/OisXRblo8uXHZt3nR5
	 o6BkWzTmiLVfFE8ePrbHA+YfpMnc9OnFKu2GkHB1YFN7rJzwE/pw251rR3D8GGW9V+OZm
	 NIfjLBFQ2j+qeR6GR4aldfJLuIlH5Tc0YHrZqssbzvl6pKMmzcnR96N2BAY7cOv04z/hC
	 XYrDdYmBPheURZCkBCd77xWzdC1IHKgDwmY/UODjz8nTE+PCFbfVJ+5XDZlGzDq5q5iZb
	 ICrLvffHFXbNeFawYzOWmcR6LS78cLISEXF3MT4yj83CCoxoot7qBzwMBbB347HArag==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198850;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rvlahFlK8i4ALBJoN3w4bBAJCwlXwkUI5qSF1ddzQuI=;
	b=LOwutb/GPvPPZujwDKDAPwbj99AvKyrWfCbx7v88PznLslsFCI1HvJQYn/oAjxadct45
	 l9eruapWPcL6xTjLw7S4+zKhzyoZQ4HQCHMcCKcq/9Z0bdADU/yL6LIxTQ6t/yXsCC38b
	 zJD6GUG/vDnaq9jqBQ6p8rR2nEOotF+VY40KyVm92Ta40CZmjTTLXVaxYMR/UaRy+E74d
	 glEv+DBWWR87vDGD5sBwWwPedFuWEMQPtGMn6fO44XKZY9yDa20KwQwWeAtQjkFADXmDI
	 gwmZl9FEAjxlhcMpuE8DOtftbO9HsSfNP1M7gLSiiu7p1lwT2BE/8fvQHUHXe860SpA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PhEpQgzM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198850;
	bh=rvlahFlK8i4ALBJoN3w4bBAJCwlXwkUI5qSF1ddzQuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jHBksvuKfBY3RU89EzzphtLFW/roT/WIHOjOY/z5nn9uZNT4hlBICdtuZT17JDi8h
	 yAdGiIJTe0CJ3QHBTZN8i5mdjsiD3MAKgVjqGwiZzM4z1m7OfdA80AF6/TQ/Vq6w4Q
	 gIR3tzIrwYmPPeA18/2fCwRK68rzRyCYjiioF3htkk4IRcg/4tT1rsc3oTireeZw7d
	 h5pNR/o8E/AezfLYOCl8oxlDS/4DaJ1UrV1aCSmLiCBUHtNSoi9z4sAccO+uWUyLwd
	 UoKN4mtf6a2xWyaQkDF8KRd3gYnHSMPwnKBDHMqg7tSzSkUlJM5a/+cQMMLxBWT7gO
	 8isEQvzq30ZqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 844DB4051D;
	Wed, 28 Oct 2026 14:47:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CB43F529
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:14:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BD466404DE
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:14:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xXk7g5hjeiir for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:14:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7161F40471
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::52c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196844;
 b=U3WKPiXnqVuWf+XUV1XpjW2uC4EJokCO+aLAIqVqBQwmTK4+cF1eGtRinxrQ/FiDEKcV
 xccfnG5MvjeUI1YO1NMmbqg/DrlG3fRxvECZhZbFETdsoxXoEjiRcLrmXelFqrr1Bum+g
 bqSRd1Ay1UyWp0FDQOupjWn7doRpALSHgprpfTqLES0apyvDET6s1p+G4ndwKawJAZ+VQ
 qdfuj7gpWWP6Hv+4vamfLztzfjjcdo/YaKQNtMM2DvJlsbFHCItWINwK/cjt+R96ds1SF
 QhKOW3ZFFKsmDTBd/iZ1wTwVgqHM6L6lzONZzWcsh/KrXs8M9/nWkSlkxcPUGYxtvLg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196844;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=rvlahFlK8i4ALBJoN3w4bBAJCwlXwkUI5qSF1ddzQuI=;
 b=X9LvbueppEEzBBkVzQBDmfZLN1tXj8kWQKsEwck/1Ex/EEhsUYCp0RgeAmRzfsYYNTbR
 pui2zlAextehfdAx4wpVyEtWcLWWVK5xi4aglK4E7ctT7lPyjMFVODTIWFlH7cjepF2Nh
 X9s1HWvc6SzeqzeE+s3IgwmwJt/8yU5q9wxTbBAqNkRcPPP6XP+Mu7AiHh5uD/0l2WXSr
 FrHOvTQH1SCFLVDCNQTfs+L1XNxMEe278NARu9uTKfMDv5/w/rTaqoIoIyIGDeaL5aFU+
 /NOsMzkexeXj/GFLrWVw9ufcHaiLTCoJXMCpmaPxzJYNA4MXU9U8PzXVC+Tn4+zTOqg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=PhEpQgzM; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::52c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=PhEpQgzM
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7161F40471
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:14:04 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6b1b34ed603so215728a12.3
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196842; x=1793801642;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rvlahFlK8i4ALBJoN3w4bBAJCwlXwkUI5qSF1ddzQuI=;
 b=PhEpQgzMb+/x/pfMbU47gUX3TvXphuA5zmuCQCXeI6YAxuugLF4XQgP38A+6tTmZ8D
 BY9fPQusV1j4n5Z7up4BrE0HAqnxTaM6y9F/JeMnf+Xe1wvdEYfMoV6VEeTVMUKwCW3M
 s85Fp51rsMujXz2fYQzxVvn8m1VCGF2487kQOxXiviQLC09/2u97jhfkbVYhkhdCvfyS
 FRTsfaNUCudAvPpQJuTxU/TvwCANwtgPgW5Uef3SiDGGNF7FcwBiigmh8oQuPxUC8NsA
 ZcgaVQZXPzaAluzRFlEsVdtLe7OIzCgdBDWd6g83/Numvud+QSN/rVv+7GyiD0t6TME7
 t6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196842; x=1793801642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rvlahFlK8i4ALBJoN3w4bBAJCwlXwkUI5qSF1ddzQuI=;
 b=XmZ4YNbylJ7i6tR4mdnH2rmOGVwBKXjAR0t11JdJBIve3xc53d3pm7HeN4b9uw513S
 76XvCIlS/wkDR1PpbKoKm+e0PpJnfdyw4Cb4UwypTtai020Hw/QHLSSf8HXpqfMoFimm
 frkLODO0tMQSuoBDU3Gx+JaIflXodW8dhVx4ZXwEaQZFTZu/+bx2Onloz2S2SkvOXfRZ
 4u2wcnh1py+aYjhgoYpCo8VgrOxxfSjzfWZDduBlVriOqUngcIpQSzNKe35mbzkXKrIO
 TofiKe4crczc+Yx6Z4veRHZwPDWx0UtI8b8dzSrT6RjKlMxXr9cRKD6aUlsQY+gB9PgT
 vxmw==
X-Gm-Message-State: AFq9FYJWYRS9viKSOZJPeKt+5wZAUeXPnnBwsvbWQ96nwXjBsJ54AqFD
 UWoKupNZz5nQoS+3ZQri+NBtqdtkEgnqKSfWPe0EJvxvJHfDSrdcvIuVtSIk4x363VvSU2S4CVH
 S05Ic
X-Gm-Gg: AYBFou0Vuw9ahWzUGIgWa3zE2jyREUkP2Tn3MUjYgmJ5i6cXFQ2xlp5JLrXjOfm1hyb
 7gTyiTE6OlI+/6klLNx2LyhcTVL3ZBHH2hPFn7vLkda3/ooLT4ZKhZsGCG8b57U4tL1Sd+jEyB/
 9v6QK4JgiU5U1aTFo71g7BrZDuf4nPm/hLvGvWqRWR+FSnYPxkKN9IyYFbLrUB6y0EtWjY4OlG7
 WY/S/F2e4qrQU7lLQ8LrtgqtEwzID0DfYcVfHHACP2d7mzr/wSgXyO1YqH3Bi5NoyGvtbM81+lJ
 CGvLdYVJOGGvOqOqijZf4Uk8BpamjqRiTYjfEXcIp08PpxPofuf1rgMZaRBDTTZx0vNJMH+BLG/
 Ss1I0M9VGXT/1jRh7jPT/lT0OgJP/l3hC2I3y/oTlVp8qzo9GDehu6qVFGe0iNDTB45EzNdYVlm
 Y7+YXmWV1BUOkMWyKTgqk1N4LtbGgbRrcZCuwMeqZBN11Isz88nQN6Z6OB3r6uPFVjWhNFyoWM9
 w1T+LFBoRKd+aq7cnTL+8rRH6DCAmI50qBuhEweK1jXrUgvEtUfH81Q67Oefo8zPnaHArkgQJEV
 /UoWj1QE1SIguu+z/CrU8wPWTu7jOdmyYZGHH5MNIYFUWH3hRLQPDiONfBpy6Ol3GQKuBF4xRn4
 wK/15FxPj0ziFLRqzuZdau374pL/qR9k=
X-Received: by 2002:a17:906:66d5:b0:c49:9a88:75f6 with SMTP id
 a640c23a62f3a-c49bdedd106mr235771766b.2.1793196842108; 
 Wed, 28 Oct 2026 07:14:02 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd524271sm628414666b.35.2026.10.28.07.14.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:14:01 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 52/63] usb: dwc3: import from kernel v6.7
Date: Wed, 28 Oct 2026 15:09:18 +0100
Message-ID: <20261028140930.3025368-53-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v6.6 to v6.7.

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

List of commits: git log --oneline v6.6..v6.7
Commits imported:
8bbae288a85a usb: dwc3: set the dma max_seg_size
97789b93b792 usb: dwc3: add optional PHY interface clocks
e24bc293a6a6 usb: dwc3: document gfladj_refclk_lpm_sel field
e72fc8d6a12a usb: dwc3: core: configure TX/RX threshold for DWC3_IP

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c | 190 ++++++++++++++++++++++++++++++++--------
 drivers/usb/dwc3/core.h |  19 ++++
 2 files changed, 173 insertions(+), 36 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 343d2570189f..b101dbf8c5dc 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -854,8 +854,20 @@ static int dwc3_clk_enable(struct dwc3 *dwc)
 	if (ret)
 		goto disable_ref_clk;
 
+	ret = clk_prepare_enable(dwc->utmi_clk);
+	if (ret)
+		goto disable_susp_clk;
+
+	ret = clk_prepare_enable(dwc->pipe_clk);
+	if (ret)
+		goto disable_utmi_clk;
+
 	return 0;
 
+disable_utmi_clk:
+	clk_disable_unprepare(dwc->utmi_clk);
+disable_susp_clk:
+	clk_disable_unprepare(dwc->susp_clk);
 disable_ref_clk:
 	clk_disable_unprepare(dwc->ref_clk);
 disable_bus_clk:
@@ -865,6 +877,8 @@ disable_bus_clk:
 
 static void dwc3_clk_disable(struct dwc3 *dwc)
 {
+	clk_disable_unprepare(dwc->pipe_clk);
+	clk_disable_unprepare(dwc->utmi_clk);
 	clk_disable_unprepare(dwc->susp_clk);
 	clk_disable_unprepare(dwc->ref_clk);
 	clk_disable_unprepare(dwc->bus_clk);
@@ -1094,6 +1108,111 @@ static void dwc3_set_power_down_clk_scale(struct dwc3 *dwc)
 	}
 }
 
+static void dwc3_config_threshold(struct dwc3 *dwc)
+{
+	u32 reg;
+	u8 rx_thr_num;
+	u8 rx_maxburst;
+	u8 tx_thr_num;
+	u8 tx_maxburst;
+
+	/*
+	 * Must config both number of packets and max burst settings to enable
+	 * RX and/or TX threshold.
+	 */
+	if (!DWC3_IP_IS(DWC3) && dwc->dr_mode == USB_DR_MODE_HOST) {
+		rx_thr_num = dwc->rx_thr_num_pkt_prd;
+		rx_maxburst = dwc->rx_max_burst_prd;
+		tx_thr_num = dwc->tx_thr_num_pkt_prd;
+		tx_maxburst = dwc->tx_max_burst_prd;
+
+		if (rx_thr_num && rx_maxburst) {
+			reg = dwc3_readl(dwc->regs, DWC3_GRXTHRCFG);
+			reg |= DWC31_RXTHRNUMPKTSEL_PRD;
+
+			reg &= ~DWC31_RXTHRNUMPKT_PRD(~0);
+			reg |= DWC31_RXTHRNUMPKT_PRD(rx_thr_num);
+
+			reg &= ~DWC31_MAXRXBURSTSIZE_PRD(~0);
+			reg |= DWC31_MAXRXBURSTSIZE_PRD(rx_maxburst);
+
+			dwc3_writel(dwc->regs, DWC3_GRXTHRCFG, reg);
+		}
+
+		if (tx_thr_num && tx_maxburst) {
+			reg = dwc3_readl(dwc->regs, DWC3_GTXTHRCFG);
+			reg |= DWC31_TXTHRNUMPKTSEL_PRD;
+
+			reg &= ~DWC31_TXTHRNUMPKT_PRD(~0);
+			reg |= DWC31_TXTHRNUMPKT_PRD(tx_thr_num);
+
+			reg &= ~DWC31_MAXTXBURSTSIZE_PRD(~0);
+			reg |= DWC31_MAXTXBURSTSIZE_PRD(tx_maxburst);
+
+			dwc3_writel(dwc->regs, DWC3_GTXTHRCFG, reg);
+		}
+	}
+
+	rx_thr_num = dwc->rx_thr_num_pkt;
+	rx_maxburst = dwc->rx_max_burst;
+	tx_thr_num = dwc->tx_thr_num_pkt;
+	tx_maxburst = dwc->tx_max_burst;
+
+	if (DWC3_IP_IS(DWC3)) {
+		if (rx_thr_num && rx_maxburst) {
+			reg = dwc3_readl(dwc->regs, DWC3_GRXTHRCFG);
+			reg |= DWC3_GRXTHRCFG_PKTCNTSEL;
+
+			reg &= ~DWC3_GRXTHRCFG_RXPKTCNT(~0);
+			reg |= DWC3_GRXTHRCFG_RXPKTCNT(rx_thr_num);
+
+			reg &= ~DWC3_GRXTHRCFG_MAXRXBURSTSIZE(~0);
+			reg |= DWC3_GRXTHRCFG_MAXRXBURSTSIZE(rx_maxburst);
+
+			dwc3_writel(dwc->regs, DWC3_GRXTHRCFG, reg);
+		}
+
+		if (tx_thr_num && tx_maxburst) {
+			reg = dwc3_readl(dwc->regs, DWC3_GTXTHRCFG);
+			reg |= DWC3_GTXTHRCFG_PKTCNTSEL;
+
+			reg &= ~DWC3_GTXTHRCFG_TXPKTCNT(~0);
+			reg |= DWC3_GTXTHRCFG_TXPKTCNT(tx_thr_num);
+
+			reg &= ~DWC3_GTXTHRCFG_MAXTXBURSTSIZE(~0);
+			reg |= DWC3_GTXTHRCFG_MAXTXBURSTSIZE(tx_maxburst);
+
+			dwc3_writel(dwc->regs, DWC3_GTXTHRCFG, reg);
+		}
+	} else {
+		if (rx_thr_num && rx_maxburst) {
+			reg = dwc3_readl(dwc->regs, DWC3_GRXTHRCFG);
+			reg |= DWC31_GRXTHRCFG_PKTCNTSEL;
+
+			reg &= ~DWC31_GRXTHRCFG_RXPKTCNT(~0);
+			reg |= DWC31_GRXTHRCFG_RXPKTCNT(rx_thr_num);
+
+			reg &= ~DWC31_GRXTHRCFG_MAXRXBURSTSIZE(~0);
+			reg |= DWC31_GRXTHRCFG_MAXRXBURSTSIZE(rx_maxburst);
+
+			dwc3_writel(dwc->regs, DWC3_GRXTHRCFG, reg);
+		}
+
+		if (tx_thr_num && tx_maxburst) {
+			reg = dwc3_readl(dwc->regs, DWC3_GTXTHRCFG);
+			reg |= DWC31_GTXTHRCFG_PKTCNTSEL;
+
+			reg &= ~DWC31_GTXTHRCFG_TXPKTCNT(~0);
+			reg |= DWC31_GTXTHRCFG_TXPKTCNT(tx_thr_num);
+
+			reg &= ~DWC31_GTXTHRCFG_MAXTXBURSTSIZE(~0);
+			reg |= DWC31_GTXTHRCFG_MAXTXBURSTSIZE(tx_maxburst);
+
+			dwc3_writel(dwc->regs, DWC3_GTXTHRCFG, reg);
+		}
+	}
+}
+
 /**
  * dwc3_core_init - Low-level initialization of DWC3 Core
  * @dwc: Pointer to our controller context structure
@@ -1246,42 +1365,7 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
 	}
 
-	/*
-	 * Must config both number of packets and max burst settings to enable
-	 * RX and/or TX threshold.
-	 */
-	if (!DWC3_IP_IS(DWC3) && dwc->dr_mode == USB_DR_MODE_HOST) {
-		u8 rx_thr_num = dwc->rx_thr_num_pkt_prd;
-		u8 rx_maxburst = dwc->rx_max_burst_prd;
-		u8 tx_thr_num = dwc->tx_thr_num_pkt_prd;
-		u8 tx_maxburst = dwc->tx_max_burst_prd;
-
-		if (rx_thr_num && rx_maxburst) {
-			reg = dwc3_readl(dwc->regs, DWC3_GRXTHRCFG);
-			reg |= DWC31_RXTHRNUMPKTSEL_PRD;
-
-			reg &= ~DWC31_RXTHRNUMPKT_PRD(~0);
-			reg |= DWC31_RXTHRNUMPKT_PRD(rx_thr_num);
-
-			reg &= ~DWC31_MAXRXBURSTSIZE_PRD(~0);
-			reg |= DWC31_MAXRXBURSTSIZE_PRD(rx_maxburst);
-
-			dwc3_writel(dwc->regs, DWC3_GRXTHRCFG, reg);
-		}
-
-		if (tx_thr_num && tx_maxburst) {
-			reg = dwc3_readl(dwc->regs, DWC3_GTXTHRCFG);
-			reg |= DWC31_TXTHRNUMPKTSEL_PRD;
-
-			reg &= ~DWC31_TXTHRNUMPKT_PRD(~0);
-			reg |= DWC31_TXTHRNUMPKT_PRD(tx_thr_num);
-
-			reg &= ~DWC31_MAXTXBURSTSIZE_PRD(~0);
-			reg |= DWC31_MAXTXBURSTSIZE_PRD(tx_maxburst);
-
-			dwc3_writel(dwc->regs, DWC3_GTXTHRCFG, reg);
-		}
-	}
+	dwc3_config_threshold(dwc);
 
 	return 0;
 
@@ -1417,6 +1501,10 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	u8			lpm_nyet_threshold;
 	u8			tx_de_emphasis;
 	u8			hird_threshold;
+	u8			rx_thr_num_pkt = 0;
+	u8			rx_max_burst = 0;
+	u8			tx_thr_num_pkt = 0;
+	u8			tx_max_burst = 0;
 	u8			rx_thr_num_pkt_prd = 0;
 	u8			rx_max_burst_prd = 0;
 	u8			tx_thr_num_pkt_prd = 0;
@@ -1479,6 +1567,14 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 				"snps,usb2-lpm-disable");
 	dwc->usb2_gadget_lpm_disable = device_property_read_bool(dev,
 				"snps,usb2-gadget-lpm-disable");
+	device_property_read_u8(dev, "snps,rx-thr-num-pkt",
+				&rx_thr_num_pkt);
+	device_property_read_u8(dev, "snps,rx-max-burst",
+				&rx_max_burst);
+	device_property_read_u8(dev, "snps,tx-thr-num-pkt",
+				&tx_thr_num_pkt);
+	device_property_read_u8(dev, "snps,tx-max-burst",
+				&tx_max_burst);
 	device_property_read_u8(dev, "snps,rx-thr-num-pkt-prd",
 				&rx_thr_num_pkt_prd);
 	device_property_read_u8(dev, "snps,rx-max-burst-prd",
@@ -1560,6 +1656,12 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 
 	dwc->hird_threshold = hird_threshold;
 
+	dwc->rx_thr_num_pkt = rx_thr_num_pkt;
+	dwc->rx_max_burst = rx_max_burst;
+
+	dwc->tx_thr_num_pkt = tx_thr_num_pkt;
+	dwc->tx_max_burst = tx_max_burst;
+
 	dwc->rx_thr_num_pkt_prd = rx_thr_num_pkt_prd;
 	dwc->rx_max_burst_prd = rx_max_burst_prd;
 
@@ -1785,6 +1887,20 @@ static int dwc3_get_clocks(struct dwc3 *dwc)
 		}
 	}
 
+	/* specific to Rockchip RK3588 */
+	dwc->utmi_clk = devm_clk_get_optional(dev, "utmi");
+	if (IS_ERR(dwc->utmi_clk)) {
+		return dev_err_probe(dev, PTR_ERR(dwc->utmi_clk),
+				"could not get utmi clock\n");
+	}
+
+	/* specific to Rockchip RK3588 */
+	dwc->pipe_clk = devm_clk_get_optional(dev, "pipe");
+	if (IS_ERR(dwc->pipe_clk)) {
+		return dev_err_probe(dev, PTR_ERR(dwc->pipe_clk),
+				"could not get pipe clock\n");
+	}
+
 	return 0;
 }
 
@@ -1918,6 +2034,8 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	pm_runtime_put(dev);
 
+	dma_set_max_seg_size(dev, UINT_MAX);
+
 	return 0;
 
 err_exit_debugfs:
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index a69ac67d89fe..efe6caf4d0e8 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -211,6 +211,11 @@
 #define DWC3_GRXTHRCFG_RXPKTCNT(n) (((n) & 0xf) << 24)
 #define DWC3_GRXTHRCFG_PKTCNTSEL BIT(29)
 
+/* Global TX Threshold Configuration Register */
+#define DWC3_GTXTHRCFG_MAXTXBURSTSIZE(n) (((n) & 0xff) << 16)
+#define DWC3_GTXTHRCFG_TXPKTCNT(n) (((n) & 0xf) << 24)
+#define DWC3_GTXTHRCFG_PKTCNTSEL BIT(29)
+
 /* Global RX Threshold Configuration Register for DWC_usb31 only */
 #define DWC31_GRXTHRCFG_MAXRXBURSTSIZE(n)	(((n) & 0x1f) << 16)
 #define DWC31_GRXTHRCFG_RXPKTCNT(n)		(((n) & 0x1f) << 21)
@@ -991,6 +996,8 @@ struct dwc3_scratchpad_array {
  * @bus_clk: clock for accessing the registers
  * @ref_clk: reference clock
  * @susp_clk: clock used when the SS phy is in low power (S3) state
+ * @utmi_clk: clock used for USB2 PHY communication
+ * @pipe_clk: clock used for USB3 PHY communication
  * @reset: reset control
  * @regs: base address for our registers
  * @regs_size: address space size
@@ -1045,6 +1052,10 @@ struct dwc3_scratchpad_array {
  * @test_mode_nr: test feature selector
  * @lpm_nyet_threshold: LPM NYET response threshold
  * @hird_threshold: HIRD threshold
+ * @rx_thr_num_pkt: USB receive packet count
+ * @rx_max_burst: max USB receive burst size
+ * @tx_thr_num_pkt: USB transmit packet count
+ * @tx_max_burst: max USB transmit burst size
  * @rx_thr_num_pkt_prd: periodic ESS receive packet count
  * @rx_max_burst_prd: max periodic ESS receive burst size
  * @tx_thr_num_pkt_prd: periodic ESS transmit packet count
@@ -1106,6 +1117,8 @@ struct dwc3_scratchpad_array {
  *			instances in park mode.
  * @parkmode_disable_hs_quirk: set if we need to disable all HishSpeed
  *			instances in park mode.
+ * @gfladj_refclk_lpm_sel: set if we need to enable SOF/ITP counter
+ *                          running based on ref_clk
  * @tx_de_emphasis_quirk: set if we enable Tx de-emphasis quirk
  * @tx_de_emphasis: Tx de-emphasis value
  *	0	- -6dB de-emphasis
@@ -1156,6 +1169,8 @@ struct dwc3 {
 	struct clk		*bus_clk;
 	struct clk		*ref_clk;
 	struct clk		*susp_clk;
+	struct clk		*utmi_clk;
+	struct clk		*pipe_clk;
 
 	struct reset_control	*reset;
 
@@ -1273,6 +1288,10 @@ struct dwc3 {
 	u8			test_mode_nr;
 	u8			lpm_nyet_threshold;
 	u8			hird_threshold;
+	u8			rx_thr_num_pkt;
+	u8			rx_max_burst;
+	u8			tx_thr_num_pkt;
+	u8			tx_max_burst;
 	u8			rx_thr_num_pkt_prd;
 	u8			rx_max_burst_prd;
 	u8			tx_thr_num_pkt_prd;
-- 
2.53.0

