Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1F8606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=I5hMX5+B;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kj7x6ak/
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B466881021;
	Wed, 28 Oct 2026 14:46:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ulx9gyNKI7rO; Wed, 28 Oct 2026 14:46:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8F4F280F92
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198770;
	b=MrbndUAYpBrmDuF6kvgsz+WeYV2IxvkYLr2zLQFbyZG4Afa4LatoL+XIUPJ+z+S4eBU0
	 WkoPhQHe0k5eZpsntWy7L4xefTkvBirLhzXhjDzuV+u1M06sv4Btkz4GWu06Wn7Y/ThnV
	 SgMLD2ifHeLUiy6zihEsVDLmjMg9MJJ8eIHHI/9f3LX19hPVq8rmu+zkFlorP1+mxJ2U0
	 N4UvG6ysisqHsGVkQ5BLodW4RGZ5c2/mLXTLjUKlymrp51ktlqubUEgPbomd7PgP3mBaS
	 qZV8BFmbTkngjnkEsJGttl+6Di6CUkyDbv4ltLEIxt4+tTv3BQJLdoxUjMt1h2ux3GQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198770;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ievz7h6QBZFXHn2aHR3IYvRvfJl0Qx0Yu50CQh+cktU=;
	b=nFjRWkZVuxFnl7quSVBGz/XZ19b61XkXFUhi7vivCKKB7S7XC3pkmrJoMgW1fcbXbYDy
	 OTlkFe7kGOj0wUv5/gUpbLADga0BpI9e3nE4IfwvpxSpf+qWdJO+H1x+qN8nb8RlGb9fy
	 l14WYlIsMxG14IrT6a5/fcSFoFKmVcCpM3KC9oC+LHuuQtZhl7sQjtJthSt7PCCiomLUz
	 aUgzDUUvVUmUvk0bxVVqGl+wLjhdg7pXJoNjLchteLlKRH3nUV6hlUv21vzxw1tbyW+65
	 EtBZkTOo2mnDyMdKD0NVuh3LPeVt65yakQFR6aqtp/aGHzd9ue2sBYCRb4OeKazRRqw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="kj7x6ak/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198770;
	bh=ievz7h6QBZFXHn2aHR3IYvRvfJl0Qx0Yu50CQh+cktU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I5hMX5+BZ8M+aBfMv5CKKdAC+ji5t0oHalIAVvqu41K1nRWab2O0HBQcTXw4nzsve
	 pTKZZ4lcRkiaKxCUOfRU0orz62NmVEBBaQX75vRUn1WnpNeEP4PB2z9yobZcKEwGyx
	 VL9hb1hTfggDsm1pIBBpNO1ADtotfvI6lJwFSPYmxLPOik60QEpvuiBFybYtZjI0hQ
	 DZr0571YylER2vPzpdcQufRk8Uwk3ZxXXleFVB8ExIZRU/g31gVtEYZZHPjApr4Gdz
	 o7LT+3WjHvrTpvOczOtnzz566UYgDqoljlEicvTrkdENKIUTBDk04LXzfhnK6HGAz3
	 JNv8XAm5FS65Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8F4F280F92;
	Wed, 28 Oct 2026 14:46:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8973D380
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:10:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7B3DB80CCA
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:10:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gKj1j6XWAQTz for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:09:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C631F80BE2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::634"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196599;
 b=VR5nErOX8c9s0o+NIK5q5A+q6uT/oDabdqZz7Tw/w0ccGsMUx7MuHG+8OGicTrQq6RBV
 zlBXZoPUJA+UNV42VSgeKlQA4KdG5tBXmOD7/3Q0jyEOaQPUAs4FmRa0GcIVRylTr5ERO
 dC/WqHYBhxSfv6vqMtOn0Bwsl5jR120Gk4+ZK5eN33juwhkCrD4HZ6jkE2S+WCBi0Eyr2
 1dUs4NkJLvsUoGc7gEV9vicBP18hC0O2orLRKmn+PR2RHdB7RLaTupyVSU/qKVBjXz6Nx
 dI1N6rLDz/df97eGTPXbQ3Z7+nFzUokoxglW/BxazeHCUnPn/JsQvmNh8Mebv3GpjOw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196599;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=ievz7h6QBZFXHn2aHR3IYvRvfJl0Qx0Yu50CQh+cktU=;
 b=fu4Mzen1jfIG7j6eCxuu5ZwFdY4smFHvcjUppBeXlGLA5ve0TO/Uwe9/VUrCTF1lnjmj
 hBW4Ymy7EtVTvzUNNtrna54AwXYK+qv1OuBdm4UVMTU3g4sKkb2DVgGK+2RaZxZOTy00g
 O1CbEETVUXYoVPX083x9tepfPUxr2qhI/hW52pO/QMnqHWCk8k8gqa/8piLx+pqdDIqpp
 2Ay7U43IojupviJwv2f7E83RAhpqSc1ILKG9M71FzROvoCbUQ+aX4Lkxh3F4X1I94uPPf
 Is4Uz+phe/+raZsQb/4KtcqnaT1D71MSot//fRZZdvA8RhuRUs+GTq6N1AJF30c9Y9Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b="kj7x6ak/"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::634"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=kj7x6ak/
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C631F80BE2
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:09:58 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c411b7a2710so12117066b.3
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196596; x=1793801396;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ievz7h6QBZFXHn2aHR3IYvRvfJl0Qx0Yu50CQh+cktU=;
 b=kj7x6ak/7bQ7xzgpMPLruP1Gtp3dsFkLu61olWdtv0WKDD6FwWCf7B14SQXBI1jrNc
 /TedoI/6zkgpfJteg63W2RV5pGYtXK6l85AWrQJNr2LFfLjCwzSHWPWuymI0AgAPWPN2
 /+I6TaEV/G0vMY7jkAC4f+0FUI/09Qgk7HTUmeyNOblBxz2rXH9WeWI+pYrifahrkBq7
 yfS8b2R8q5w8CKa9UpjvleJUVsM+jvJzO8seXiDUgu8jD1ErqPOkK/2PgHShWxkvz47f
 thIxxIzv1KwRgBeGltvl2wGHPE4aMrhUZpzenwxLcQ5u1jSAWZpqKFVv4GzXANpy/z/J
 Q+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196596; x=1793801396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ievz7h6QBZFXHn2aHR3IYvRvfJl0Qx0Yu50CQh+cktU=;
 b=UUbUiK+PxkldddMlWGvKajQH4rVf4LfzeMOLjMiQ1U9nRcoBUt1JjuO+J9Scj0cRNk
 eqkkFtUdoXrc6j/dxJGKqDEysO4YvsoX/iUBdKJtq1oTDHd+Ev/FrAIcWu17YdUdARtq
 iRghvL0zyG233VORy4t19ZsbZGR9p6nTuSD2TlYRtgQ59IWZXUf7mQctZVG9koZsfexR
 eT2pzNzXb0kUgZ86ZFj5e00ra6+Kxleu9jWKLTqBNOKHJSFHB3ri42/Ct68J3i30qQJg
 nzc5PSIq/c/ibcRqiTcqewxxPg+0etmEmErrMj05yB1aLHCdnJPiVylCWa2vdpxOdADv
 ewrg==
X-Gm-Message-State: AFq9FYLuzSvxgKBbo5A9q8HwNuLrJejLYoMQ9uT3nJ0CZcTSa1kKN0lA
 D1cJcp6/gUrUuuM/YknySgaaHsM+wqlrHuqZBiPfQ3Q7lW+ODIuhPNZdq25jyxvxbcCBBZ1xWs0
 NoqNV
X-Gm-Gg: AYBFou1sbQaJw3vagTR2KrnAifwCu7xeQUNkhTE5uI4mt4i1WMp+0TgzT3vc93bBMAZ
 ScxRj/xgmW6Flr3vXmiiddYx1epLCCKkNUcpeeF6xoxq6BSCjrt2ClAydTKQyAzieJuP55urGT9
 8jG6QoqSZ90wqvdLoAdRvZHbrIGAfMlAEFC0xKqb8l/usftZ/gkp1rRHEmKTbehgVqOTKaZoWi5
 1ts4Eq39u2b3yzzmZtGLyWjjFZp7ifd/KrjXBulCN31MqyG0GRw/vZF+uqKzOJ6uM8ZWtY32qr1
 wewGoCbxncmR1HINfOdJVSgdzwmJLUybOfaDn7v+FvLbkXzWI9XEhRlt5Bz869jdFNpI/22tBAQ
 qq7KWALgs6nkhH98Xfd4t+jYQRVvDLSGEz7nheLW7OeEVTsPF3cnL1EOwDz2CCgtrkN73qE2/s2
 5hDk/Keumshv7NuhkELZZNCzWf4w2AQ8YoyGKI9sBWD8dpOTQprHMzvqWYz4fTBvBHi6CQ7pyJy
 7p+5wsERlReITfiApb5ZwnaKUBU5TfaVRh6+2Tegj1MbEgNtf65A5M1SXTmdqCok2y2trQO339s
 ahrzEXWMJOfwlUfV3nQfkEG3nymv6t4nhqibVwUC7LaQzRsJHV10jjaCE2lOiW65MpqYa+AzcJS
 cybe+icUmSw==
X-Received: by 2002:a17:906:fd0:b0:c40:b180:db3b with SMTP id
 a640c23a62f3a-c49bdf8d67fmr244384866b.3.1793196595857; 
 Wed, 28 Oct 2026 07:09:55 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd790afasm607807266b.68.2026.10.28.07.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:09:55 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 09/63] usb: dwc3: import from kernel v4.5
Date: Wed, 28 Oct 2026 15:08:35 +0100
Message-ID: <20261028140930.3025368-10-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v4.4 to v4.5.

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

List of commits: git log --oneline v4.4..v4.5
Commits imported:
c450960187f4 usb: dwc3: Fix assignment of EP transfer resources
6a4290cc28be usb: dwc3: gadget: set the OTG flag in dwc3 gadget driver.
d9261898a4b2 usb: dwc3: gadget: don't send extra ZLP
95ca961c758c usb: dwc3: gadget: pass a condition to dev_WARN_ONCE()
04c03d10e507 usb: dwc3: gadget: handle request->zero
b5d335e5ea6a usb: dwc3: ep0: fix setup_packet_pending initialization
ac7bdcc1b3ad usb: dwc3: gadget: simplify next_request() return check
acc38c4970ca usb: dwc3: ep0: purge dev_dbg() calls
1407bf13e3bf usb: dwc3: core: purge dev_dbg() calls
ec5e795cdefb usb: dwc3: gadget: purge dev_dbg() calls
bb423984c28e usb: dwc3: gadget: simplify dwc3_gadget_ep_queue()

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c   |   8 +-
 drivers/usb/dwc3/core.h   |   4 +-
 drivers/usb/dwc3/ep0.c    |  17 ++--
 drivers/usb/dwc3/gadget.c | 204 ++++++++++++++++++++++++++------------
 4 files changed, 157 insertions(+), 76 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 22b4797383cd..de5e01f41bc2 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -272,7 +272,8 @@ static int dwc3_event_buffers_setup(struct dwc3 *dwc)
 
 	for (n = 0; n < dwc->num_event_buffers; n++) {
 		evt = dwc->ev_buffs[n];
-		dev_dbg(dwc->dev, "Event buf %p dma %08llx length %d\n",
+		dwc3_trace(trace_dwc3_core,
+				"Event buf %p dma %08llx length %d\n",
 				evt->buf, (unsigned long long) evt->dma,
 				evt->length);
 
@@ -608,12 +609,13 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		reg |= DWC3_GCTL_GBLHIBERNATIONEN;
 		break;
 	default:
-		dev_dbg(dwc->dev, "No power optimization available\n");
+		dwc3_trace(trace_dwc3_core, "No power optimization available\n");
 	}
 
 	/* check if current dwc3 is on simulation board */
 	if (dwc->hwparams.hwparams6 & DWC3_GHWPARAMS6_EN_FPGA) {
-		dev_dbg(dwc->dev, "it is on FPGA board\n");
+		dwc3_trace(trace_dwc3_core,
+				"running on FPGA platform\n");
 		dwc->is_fpga = true;
 	}
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 36f1cb74588c..e4f8b90d9627 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -37,6 +37,7 @@
 #define DWC3_MSG_MAX	500
 
 /* Global constants */
+#define DWC3_ZLP_BUF_SIZE	1024	/* size of a superspeed bulk */
 #define DWC3_EP0_BOUNCE_SIZE	512
 #define DWC3_ENDPOINTS_NUM	32
 #define DWC3_XHCI_RESOURCES_NUM	2
@@ -647,6 +648,7 @@ struct dwc3_scratchpad_array {
  * @ctrl_req: usb control request which is used for ep0
  * @ep0_trb: trb which is used for the ctrl_req
  * @ep0_bounce: bounce buffer for ep0
+ * @zlp_buf: used when request->zero is set
  * @setup_buf: used while precessing STD USB requests
  * @ctrl_req_addr: dma address of ctrl_req
  * @ep0_trb: dma address of ep0_trb
@@ -734,6 +736,7 @@ struct dwc3 {
 	struct usb_ctrlrequest	*ctrl_req;
 	struct dwc3_trb		*ep0_trb;
 	void			*ep0_bounce;
+	void			*zlp_buf;
 	void			*scratchbuf;
 	u8			*setup_buf;
 	dma_addr_t		ctrl_req_addr;
@@ -853,7 +856,6 @@ struct dwc3 {
 	unsigned		pullups_connected:1;
 	unsigned		resize_fifos:1;
 	unsigned		setup_packet_pending:1;
-	unsigned		start_config_issued:1;
 	unsigned		three_stage_setup:1;
 	unsigned		usb3_lpm_capable:1;
 
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 5320e939e090..8d6b75c2f53b 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -555,7 +555,6 @@ static int dwc3_ep0_set_config(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 	int ret;
 	u32 reg;
 
-	dwc->start_config_issued = false;
 	cfg = le16_to_cpu(ctrl->wValue);
 
 	switch (state) {
@@ -737,10 +736,6 @@ static int dwc3_ep0_std_request(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 		dwc3_trace(trace_dwc3_ep0, "USB_REQ_SET_ISOCH_DELAY");
 		ret = dwc3_ep0_set_isoch_delay(dwc, ctrl);
 		break;
-	case USB_REQ_SET_INTERFACE:
-		dwc3_trace(trace_dwc3_ep0, "USB_REQ_SET_INTERFACE");
-		dwc->start_config_issued = false;
-		/* Fall through */
 	default:
 		dwc3_trace(trace_dwc3_ep0, "Forwarding to gadget driver");
 		ret = dwc3_ep0_delegate_req(dwc, ctrl);
@@ -817,6 +812,8 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 
 	status = DWC3_TRB_SIZE_TRBSTS(trb->size);
 	if (status == DWC3_TRBSTS_SETUP_PENDING) {
+		dwc->setup_packet_pending = true;
+
 		dwc3_trace(trace_dwc3_ep0, "Setup Pending received");
 
 		if (r)
@@ -916,8 +913,10 @@ static void dwc3_ep0_complete_status(struct dwc3 *dwc,
 	}
 
 	status = DWC3_TRB_SIZE_TRBSTS(trb->size);
-	if (status == DWC3_TRBSTS_SETUP_PENDING)
+	if (status == DWC3_TRBSTS_SETUP_PENDING) {
+		dwc->setup_packet_pending = true;
 		dwc3_trace(trace_dwc3_ep0, "Setup Pending received");
+	}
 
 	dwc->ep0state = EP0_SETUP_PHASE;
 	dwc3_ep0_out_start(dwc);
@@ -971,7 +970,7 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 		ret = usb_gadget_map_request(&dwc->gadget, &req->request,
 				dep->number);
 		if (ret) {
-			dev_dbg(dwc->dev, "failed to map request\n");
+			dwc3_trace(trace_dwc3_ep0, "failed to map request\n");
 			return;
 		}
 
@@ -999,7 +998,7 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 		ret = usb_gadget_map_request(&dwc->gadget, &req->request,
 				dep->number);
 		if (ret) {
-			dev_dbg(dwc->dev, "failed to map request\n");
+			dwc3_trace(trace_dwc3_ep0, "failed to map request\n");
 			return;
 		}
 
@@ -1063,8 +1062,6 @@ static void dwc3_ep0_end_control_data(struct dwc3 *dwc, struct dwc3_ep *dep)
 static void dwc3_ep0_xfernotready(struct dwc3 *dwc,
 		const struct dwc3_event_depevt *event)
 {
-	dwc->setup_packet_pending = true;
-
 	switch (event->status) {
 	case DEPEVT_STATUS_CONTROL_DATA:
 		dwc3_trace(trace_dwc3_ep0, "Control Data");
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index a58376fd65fe..2363bad45af8 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -265,9 +265,6 @@ void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
 		usb_gadget_unmap_request(&dwc->gadget, &req->request,
 				req->direction);
 
-	dev_dbg(dwc->dev, "request %p from %s completed %d/%d ===> %d\n",
-			req, dep->name, req->request.actual,
-			req->request.length, status);
 	trace_dwc3_gadget_giveback(req);
 
 	spin_unlock(&dwc->lock);
@@ -388,24 +385,66 @@ static void dwc3_free_trb_pool(struct dwc3_ep *dep)
 	dep->trb_pool_dma = 0;
 }
 
+static int dwc3_gadget_set_xfer_resource(struct dwc3 *dwc, struct dwc3_ep *dep);
+
+/**
+ * dwc3_gadget_start_config - Configure EP resources
+ * @dwc: pointer to our controller context structure
+ * @dep: endpoint that is being enabled
+ *
+ * The assignment of transfer resources cannot perfectly follow the
+ * data book due to the fact that the controller driver does not have
+ * all knowledge of the configuration in advance. It is given this
+ * information piecemeal by the composite gadget framework after every
+ * SET_CONFIGURATION and SET_INTERFACE. Trying to follow the databook
+ * programming model in this scenario can cause errors. For two
+ * reasons:
+ *
+ * 1) The databook says to do DEPSTARTCFG for every SET_CONFIGURATION
+ * and SET_INTERFACE (8.1.5). This is incorrect in the scenario of
+ * multiple interfaces.
+ *
+ * 2) The databook does not mention doing more DEPXFERCFG for new
+ * endpoint on alt setting (8.1.6).
+ *
+ * The following simplified method is used instead:
+ *
+ * All hardware endpoints can be assigned a transfer resource and this
+ * setting will stay persistent until either a core reset or
+ * hibernation. So whenever we do a DEPSTARTCFG(0) we can go ahead and
+ * do DEPXFERCFG for every hardware endpoint as well. We are
+ * guaranteed that there are as many transfer resources as endpoints.
+ *
+ * This function is called for each endpoint when it is being enabled
+ * but is triggered only when called for EP0-out, which always happens
+ * first, and which should only happen in one of the above conditions.
+ */
 static int dwc3_gadget_start_config(struct dwc3 *dwc, struct dwc3_ep *dep)
 {
 	struct dwc3_gadget_ep_cmd_params params;
 	u32			cmd;
+	int			i;
+	int			ret;
+
+	if (dep->number)
+		return 0;
 
 	memset(&params, 0x00, sizeof(params));
+	cmd = DWC3_DEPCMD_DEPSTARTCFG;
 
-	if (dep->number != 1) {
-		cmd = DWC3_DEPCMD_DEPSTARTCFG;
-		/* XferRscIdx == 0 for ep0 and 2 for the remaining */
-		if (dep->number > 1) {
-			if (dwc->start_config_issued)
-				return 0;
-			dwc->start_config_issued = true;
-			cmd |= DWC3_DEPCMD_PARAM(2);
-		}
+	ret = dwc3_send_gadget_ep_cmd(dwc, 0, cmd, &params);
+	if (ret)
+		return ret;
 
-		return dwc3_send_gadget_ep_cmd(dwc, 0, cmd, &params);
+	for (i = 0; i < DWC3_ENDPOINTS_NUM; i++) {
+		struct dwc3_ep *dep = dwc->eps[i];
+
+		if (!dep)
+			continue;
+
+		ret = dwc3_gadget_set_xfer_resource(dwc, dep);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
@@ -519,10 +558,6 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep,
 		struct dwc3_trb	*trb_st_hw;
 		struct dwc3_trb	*trb_link;
 
-		ret = dwc3_gadget_set_xfer_resource(dwc, dep);
-		if (ret)
-			return ret;
-
 		dep->endpoint.desc = desc;
 		dep->comp_desc = comp_desc;
 		dep->type = usb_endpoint_type(desc);
@@ -664,11 +699,10 @@ static int dwc3_gadget_ep_enable(struct usb_ep *ep,
 	dep = to_dwc3_ep(ep);
 	dwc = dep->dwc;
 
-	if (dep->flags & DWC3_EP_ENABLED) {
-		dev_WARN_ONCE(dwc->dev, true, "%s is already enabled\n",
-				dep->name);
+	if (dev_WARN_ONCE(dwc->dev, dep->flags & DWC3_EP_ENABLED,
+					"%s is already enabled\n",
+					dep->name))
 		return 0;
-	}
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	ret = __dwc3_gadget_ep_enable(dep, desc, ep->comp_desc, false, false);
@@ -692,11 +726,10 @@ static int dwc3_gadget_ep_disable(struct usb_ep *ep)
 	dep = to_dwc3_ep(ep);
 	dwc = dep->dwc;
 
-	if (!(dep->flags & DWC3_EP_ENABLED)) {
-		dev_WARN_ONCE(dwc->dev, true, "%s is already disabled\n",
-				dep->name);
+	if (dev_WARN_ONCE(dwc->dev, !(dep->flags & DWC3_EP_ENABLED),
+					"%s is already disabled\n",
+					dep->name))
 		return 0;
-	}
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	ret = __dwc3_gadget_ep_disable(dep);
@@ -985,8 +1018,6 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep, u16 cmd_param,
 	cmd |= DWC3_DEPCMD_PARAM(cmd_param);
 	ret = dwc3_send_gadget_ep_cmd(dwc, dep->number, cmd, &params);
 	if (ret < 0) {
-		dev_dbg(dwc->dev, "failed to send STARTTRANSFER command\n");
-
 		/*
 		 * FIXME we need to iterate over the list of requests
 		 * here and stop, unmap, free and del each of the linked
@@ -1044,6 +1075,20 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 	struct dwc3		*dwc = dep->dwc;
 	int			ret;
 
+	if (!dep->endpoint.desc) {
+		dwc3_trace(trace_dwc3_gadget,
+				"trying to queue request %p to disabled %s\n",
+				&req->request, dep->endpoint.name);
+		return -ESHUTDOWN;
+	}
+
+	if (WARN(req->dep != dep, "request %p belongs to '%s'\n",
+				&req->request, req->dep->name)) {
+		dwc3_trace(trace_dwc3_gadget, "request %p belongs to '%s'\n",
+				&req->request, req->dep->name);
+		return -EINVAL;
+	}
+
 	req->request.actual	= 0;
 	req->request.status	= -EINPROGRESS;
 	req->direction		= dep->direction;
@@ -1141,7 +1186,8 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 
 out:
 	if (ret && ret != -EBUSY)
-		dev_dbg(dwc->dev, "%s: failed to kick transfers\n",
+		dwc3_trace(trace_dwc3_gadget,
+				"%s: failed to kick transfers\n",
 				dep->name);
 	if (ret == -EBUSY)
 		ret = 0;
@@ -1149,6 +1195,32 @@ out:
 	return ret;
 }
 
+static void __dwc3_gadget_ep_zlp_complete(struct usb_ep *ep,
+		struct usb_request *request)
+{
+	dwc3_gadget_ep_free_request(ep, request);
+}
+
+static int __dwc3_gadget_ep_queue_zlp(struct dwc3 *dwc, struct dwc3_ep *dep)
+{
+	struct dwc3_request		*req;
+	struct usb_request		*request;
+	struct usb_ep			*ep = &dep->endpoint;
+
+	dwc3_trace(trace_dwc3_gadget, "queueing ZLP\n");
+	request = dwc3_gadget_ep_alloc_request(ep, GFP_ATOMIC);
+	if (!request)
+		return -ENOMEM;
+
+	request->length = 0;
+	request->buf = dwc->zlp_buf;
+	request->complete = __dwc3_gadget_ep_zlp_complete;
+
+	req = to_dwc3_request(request);
+
+	return __dwc3_gadget_ep_queue(dep, req);
+}
+
 static int dwc3_gadget_ep_queue(struct usb_ep *ep, struct usb_request *request,
 	gfp_t gfp_flags)
 {
@@ -1161,22 +1233,18 @@ static int dwc3_gadget_ep_queue(struct usb_ep *ep, struct usb_request *request,
 	int				ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	if (!dep->endpoint.desc) {
-		dev_dbg(dwc->dev, "trying to queue request %p to disabled %s\n",
-				request, ep->name);
-		ret = -ESHUTDOWN;
-		goto out;
-	}
-
-	if (WARN(req->dep != dep, "request %p belongs to '%s'\n",
-				request, req->dep->name)) {
-		ret = -EINVAL;
-		goto out;
-	}
-
 	ret = __dwc3_gadget_ep_queue(dep, req);
 
-out:
+	/*
+	 * Okay, here's the thing, if gadget driver has requested for a ZLP by
+	 * setting request->zero, instead of doing magic, we will just queue an
+	 * extra usb_request ourselves so that it gets handled the same way as
+	 * any other request.
+	 */
+	if (ret == 0 && request->zero && request->length &&
+	    (request->length % ep->maxpacket == 0))
+		ret = __dwc3_gadget_ep_queue_zlp(dwc, dep);
+
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return ret;
@@ -1246,7 +1314,8 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol)
 		if (!protocol && ((dep->direction && dep->flags & DWC3_EP_BUSY) ||
 				(!list_empty(&dep->req_queued) ||
 				 !list_empty(&dep->request_list)))) {
-			dev_dbg(dwc->dev, "%s: pending request, cannot halt\n",
+			dwc3_trace(trace_dwc3_gadget,
+					"%s: pending request, cannot halt\n",
 					dep->name);
 			return -EAGAIN;
 		}
@@ -1373,7 +1442,7 @@ static int dwc3_gadget_wakeup(struct usb_gadget *g)
 
 	speed = reg & DWC3_DSTS_CONNECTSPD;
 	if (speed == DWC3_DSTS_SUPERSPEED) {
-		dev_dbg(dwc->dev, "no wakeup on SuperSpeed\n");
+		dwc3_trace(trace_dwc3_gadget, "no wakeup on SuperSpeed\n");
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1385,8 +1454,9 @@ static int dwc3_gadget_wakeup(struct usb_gadget *g)
 	case DWC3_LINK_STATE_U3:	/* in HS, means SUSPEND */
 		break;
 	default:
-		dev_dbg(dwc->dev, "can't wakeup from link state %d\n",
-				link_state);
+		dwc3_trace(trace_dwc3_gadget,
+				"can't wakeup from '%s'\n",
+				dwc3_gadget_link_string(link_state));
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1604,8 +1674,6 @@ static int dwc3_gadget_start(struct usb_gadget *g,
 	}
 	dwc3_writel(dwc->regs, DWC3_DCFG, reg);
 
-	dwc->start_config_issued = false;
-
 	/* Start with SuperSpeed Default */
 	dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
 
@@ -1825,7 +1893,8 @@ static int __dwc3_cleanup_done_trbs(struct dwc3 *dwc, struct dwc3_ep *dep,
 		if (count) {
 			trb_status = DWC3_TRB_SIZE_TRBSTS(trb->size);
 			if (trb_status == DWC3_TRBSTS_MISSED_ISOC) {
-				dev_dbg(dwc->dev, "incomplete IN transfer %s\n",
+				dwc3_trace(trace_dwc3_gadget,
+						"%s: incomplete IN transfer\n",
 						dep->name);
 				/*
 				 * If missed isoc occurred and there is
@@ -1887,10 +1956,9 @@ static int dwc3_cleanup_done_reqs(struct dwc3 *dwc, struct dwc3_ep *dep,
 
 	do {
 		req = next_request(&dep->req_queued);
-		if (!req) {
-			WARN_ON_ONCE(1);
+		if (WARN_ON_ONCE(!req))
 			return 1;
-		}
+
 		i = 0;
 		do {
 			slot = req->start_slot + i;
@@ -2004,7 +2072,8 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 		dep->resource_index = 0;
 
 		if (usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
-			dev_dbg(dwc->dev, "%s is an Isochronous endpoint\n",
+			dwc3_trace(trace_dwc3_gadget,
+					"%s is an Isochronous endpoint\n",
 					dep->name);
 			return;
 		}
@@ -2031,7 +2100,8 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 			if (!ret || ret == -EBUSY)
 				return;
 
-			dev_dbg(dwc->dev, "%s: failed to kick transfers\n",
+			dwc3_trace(trace_dwc3_gadget,
+					"%s: failed to kick transfers\n",
 					dep->name);
 		}
 
@@ -2053,11 +2123,12 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 		case DEPEVT_STREAMEVT_NOTFOUND:
 			/* FALLTHROUGH */
 		default:
-			dev_dbg(dwc->dev, "Couldn't find suitable stream\n");
+			dwc3_trace(trace_dwc3_gadget,
+					"unable to find suitable stream\n");
 		}
 		break;
 	case DWC3_DEPEVT_RXTXFIFOEVT:
-		dev_dbg(dwc->dev, "%s FIFO Overrun\n", dep->name);
+		dwc3_trace(trace_dwc3_gadget, "%s FIFO Overrun\n", dep->name);
 		break;
 	case DWC3_DEPEVT_EPCMDCMPLT:
 		dwc3_trace(trace_dwc3_gadget, "Endpoint Command Complete");
@@ -2202,7 +2273,6 @@ static void dwc3_gadget_disconnect_interrupt(struct dwc3 *dwc)
 	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
 
 	dwc3_disconnect_gadget(dwc);
-	dwc->start_config_issued = false;
 
 	dwc->gadget.speed = USB_SPEED_UNKNOWN;
 	dwc->setup_packet_pending = false;
@@ -2230,8 +2300,8 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
 	 *
 	 * Our suggested workaround is to follow the Disconnect
 	 * Event steps here, instead, based on a setup_packet_pending
-	 * flag. Such flag gets set whenever we have a XferNotReady
-	 * event on EP0 and gets cleared on XferComplete for the
+	 * flag. Such flag gets set whenever we have a SETUP_PENDING
+	 * status for EP0 TRBs and gets cleared on XferComplete for the
 	 * same endpoint.
 	 *
 	 * Refers to:
@@ -2253,7 +2323,6 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
 
 	dwc3_stop_active_transfers(dwc);
 	dwc3_clear_stall_all_ep(dwc);
-	dwc->start_config_issued = false;
 
 	/* Reset device address to zero */
 	reg = dwc3_readl(dwc->regs, DWC3_DCFG);
@@ -2744,10 +2813,17 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 		goto err3;
 	}
 
+	dwc->zlp_buf = kzalloc(DWC3_ZLP_BUF_SIZE, GFP_KERNEL);
+	if (!dwc->zlp_buf) {
+		ret = -ENOMEM;
+		goto err4;
+	}
+
 	dwc->gadget.ops			= &dwc3_gadget_ops;
 	dwc->gadget.speed		= USB_SPEED_UNKNOWN;
 	dwc->gadget.sg_supported	= true;
 	dwc->gadget.name		= "dwc3-gadget";
+	dwc->gadget.is_otg		= dwc->dr_mode == USB_DR_MODE_OTG;
 
 	/*
 	 * FIXME We might be setting max_speed to <SUPER, however versions
@@ -2785,16 +2861,19 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 
 	ret = dwc3_gadget_init_endpoints(dwc);
 	if (ret)
-		goto err4;
+		goto err5;
 
 	ret = usb_add_gadget_udc(dwc->dev, &dwc->gadget);
 	if (ret) {
 		dev_err(dwc->dev, "failed to register udc\n");
-		goto err4;
+		goto err5;
 	}
 
 	return 0;
 
+err5:
+	kfree(dwc->zlp_buf);
+
 err4:
 	dwc3_gadget_free_endpoints(dwc);
 	dma_free_coherent(dwc->dev, DWC3_EP0_BOUNCE_SIZE,
@@ -2827,6 +2906,7 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 			dwc->ep0_bounce, dwc->ep0_bounce_addr);
 
 	kfree(dwc->setup_buf);
+	kfree(dwc->zlp_buf);
 
 	dma_free_coherent(dwc->dev, sizeof(*dwc->ep0_trb),
 			dwc->ep0_trb, dwc->ep0_trb_addr);
-- 
2.53.0

