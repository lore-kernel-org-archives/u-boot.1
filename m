Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041BF606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YI6vneUv;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=l4exMPnP
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C5199811A2;
	Wed, 28 Oct 2026 14:47:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vr1YjcUXobrY; Wed, 28 Oct 2026 14:47:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2C4DC810F1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198816;
	b=LLTTMr5x4UWASMgzjoSNtukcoIWS2VUu1Wbl0bsl7WzIpszEUC94bY9a4FXwBhmjeAMp
	 XeDc/qsmUJifUDR5wERVXrvhZz3VpM2MqHqshnlAJpp+elYZAfKSlajbA9OZmAox4OvHd
	 bmDAwXxxT+BWGjIrWjb8A2KoNPSIUwPsr/0+CxBrHnVFg8uHsfjAVdOyGQSAGOagEtfiy
	 N4twUu46UH54Kxj4poZO3Sz8J3UccX7tgpZgSSYnR3MLO2z2GKS1StafpGz3u9k18MBrS
	 PcmCHFqTN/ezzKKjHLlAb93A6LLOAYR/44SuA1Yjmru074evLMm1w7IWkLyl///HuQw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198816;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5AgmtkAxlG9ErH9jpQ50Lmouj6SlkSbwjBSm01ROfds=;
	b=R7uPfI+d0LoRTtRR2ZIlFhpldFZ3YS9ODj2jJGfIFptiLcjouAci8s2PnonsHbw066hI
	 ID0x/TovWQlAOt0UnM/ZtAriYdVoxo2sVt4mS6sLavtfGQuHjcVEL9P1p/O8x4I4Po9p9
	 kX6Me/Cl16RHb0ZlcDJaYyEqDgKrQScOjCLKM7JUATzOr8wJjEBQslfZB+oPxpBTapRwv
	 tjoWhROCZxAMPbmbaUJ3xh3khrAA3X7iKOpjcUqwUiad8ieoC74dlXjhZA8r2zUEmIXCa
	 KaVOkVQ54tzh1AHV9ffcbyYSv0biYns7A+ohTszC1x8Gi9WfhSggvEsZVKdvA2+4+eQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198816;
	bh=5AgmtkAxlG9ErH9jpQ50Lmouj6SlkSbwjBSm01ROfds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YI6vneUv8DTpsWYicF5ukt1kmV6xBy+XNNcA4LA5KcHJh2vFtzHjqOMN09clxBIda
	 MExm9ccRRRTGZx4eHtxPe+wPRC5Puzz+9BnnizUa8A+t1wbtpA4d4REjaOrL+kTnj0
	 sQAztV3HsEDZtob36qKwpAJEd/9lnJn5OHeik4M3j+/9BTIn1Fuy/IblU408qkJx4H
	 uY+W3pjul9Nv3fhu5N5LGrdTbR7lgEI0j6c+71WNPgwZOY+hLtupIqR7vnJeucWPZS
	 3DU4qVE5Y2fu+p1zW1mj9KHEgdTF30PaONE5LnDc5ggqodiHeWGsbSUFBaYYiIQqKr
	 xBuYwrqsnIUuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C4DC810F1;
	Wed, 28 Oct 2026 14:46:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BDC5D356
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:12:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A3615605EA
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:12:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 73YCABuNlYYw for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:12:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D2F80605EB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196749;
 b=evbmH/oo15eUxER+S9b4wy1ugLXXn6AfuuAfDY1RiQtgUSOrTYdFUosM+It4P1D5hQXN
 r/y0Gd5cE6WctbDZj8iBe3w/j4p9LQQ0tr0C1u+zMeboIQQ5hz++OD7/nZYaBuxRIyJxZ
 IqEhlF83HYtI4f6mFLtgnir4Oueh7mSQkc8akxjI2RMjy9Wnjj5SJDr8xfByybCnIxEV6
 0VY6TSPH2FCqaT8lPV6Ucf2rt1W2pseAThvz0Z30cNc/1nOr0ic+gK6dhovVdQfWTdIIk
 CimDdqpEZkXYoEOdGKV65ClieQKgc67PLwYVuYSzAM8f7NMuKzagA9jdINMJ3fdM8vg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196749;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=5AgmtkAxlG9ErH9jpQ50Lmouj6SlkSbwjBSm01ROfds=;
 b=KQ9ohzvPhCoaehUWkEABLpI0xj4ub53N4Vx961EiPzH/Ud+vJKspVHQaJ9LfcONK0ncJ
 oaF1Mnekupqp/MX5s3Swk7s2D/EYaYYRSzhOSrwz9G+LfklKb8So9FNvtRzyl283bNM3v
 tERGuKZZecYlYHh/R0/5YSfyC/mFLmsPNiQx5+ExNaUtTGvCJW7Uiduz+5yxaQKEjiMY5
 NGGzInzrxarpt1+pyXRZ6SaLwmP0eRi6XSEtaGheDa/mLJH46Sr/Dz6YGey4T6+TA2szX
 0/8/t859/UnFpnWIaQDq1M44SjOBXwLLfmywMjTA5/xbIViDikQsQg3B9Pgq/hQ/ydQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=l4exMPnP; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=l4exMPnP
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D2F80605EB
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:12:28 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c33700b6435so16170466b.1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196747; x=1793801547;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5AgmtkAxlG9ErH9jpQ50Lmouj6SlkSbwjBSm01ROfds=;
 b=l4exMPnPdmRs2VgNq/V/JI+Un6osuiyXRonjILITdtqilcl28v9194ItY+l51v2kOJ
 z7vizt4qkljyKb5s/Cedq55whQOFhNBQyH39j/PYDVvtrK0ev6YvqtiBholcUKNd4paZ
 WRWXoU/5nyQP126Xqh88q5pA0pykPnCzt2ccKFXB85B629tfy4JGvWuqS9Il/NaE1P6T
 YlOw6008O17ztt+XMuIQ7yxYUUWaEZXpDPIJRqjEbE0NEAZg5kjyVixgeaviH/AuKkCk
 6aGPmgy1dE6yPWpVLLwGLOcmKZl1Hqj9riiXTWGxAujL/Rm/fIwfweZW8keTCnbwT23n
 4aLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196747; x=1793801547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5AgmtkAxlG9ErH9jpQ50Lmouj6SlkSbwjBSm01ROfds=;
 b=eUr7gur678ZAWm7m0+OToq3W80wYHbHxc6kVHhyoIBCl85n3QNZsrIXup519o2oDrf
 HWzyHMOv+11UKphHo3nQqpAtNU5sU68R5ILOfvmhqkFVVg9P3DEnEVOZDkBKkagqGpGw
 8PrtOMyseA7ZhIltalKGd661jEmo7Qi4peYkBV+w/6/uRldDy6f7Lfx0MbMbcaOa2cob
 z2ObVt2ZFxQJbaZuJa2bExXa7Z/5/hpA3+i9EhaxUygTjIMq2nvfcLHV0NQr3q/mlL8B
 5yb6JxGY6yMGXhezcxw7WxhTjDRz27FswT2K7+XE5Z8odYV7LwkGjlYX0aH7/HYhIE2d
 JI4g==
X-Gm-Message-State: AFq9FYId0JlWMwLJNUje4+jRdyZT7y0u2XOcyeGNQWQT9LVuZ01JP8O/
 YjoSB2jlF08UbNO2QloeP3pd0mgT4rC0VQY7GlaxXdlNbtnfFAh1oE5R1qDRfPWr/Dc5TJtmwWk
 on5oW
X-Gm-Gg: AYBFou3v13Zs9wcYSYpgwZmbLLzCu+YX4GBruxL7G5/ZmCLelSwLLbilKUUOQRc61KN
 8v0oGw+1CsxLKkHLYOhlHZ4XNBpdOWJInm+z2NEs1tiXrSY0dwVBG6bjPDUoxPFzaM2kNb+h0X0
 eLlLomsQCgAbdTGrThSaNeFMQiUOscSrctyVKzSSJFNa93GwhnWuUsOf4cYopZPtKRI5sUFixij
 2MhpZD6RurBYWOf9yD2SehgYIpESaZAeK2iSbVfhCDohHOHuKaJYgI84F7FK05mWYlBAuPwGjnY
 TIlDCqD2yV9jp83VZpfcNtf8iDAxv1/DoJIupwPymzr4+2zxMwiD/Pl1PpG6PMql+ml8Jjog8aR
 UVpCGRvnMiMhfXUB6speNVILMXMRPbUOLq2Otbb7LyENxMdYOQ7w5xGf45+FzRegzGTFwOQspZT
 dkMp/ya3UCR751zySmwVcYZOvdUkziL5ZPdmzGNlKpbUWf4nt/QMb7BrmmTHi9gl5gkRQU1wbXt
 m/ANhdjJiazd57xzaSvN+SBtan8NI4+MXPKH2eX+CnJJvSCoafQYnjvhwX9R5lSYS5Z0D47B9Go
 YsSol4DYKUsOTGafPakVrK0075bb8vXlIx/MM9fuLGrGmfivTKKY5kv7wc55Htsocs3APUQ0+fq
 bRgqSvgm5hA==
X-Received: by 2002:a17:906:5154:20b0:c49:ce7c:8a60 with SMTP id
 a640c23a62f3a-c49ce7c8bb6mr45020066b.2.1793196746554; 
 Wed, 28 Oct 2026 07:12:26 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd4ea351sm606060666b.28.2026.10.28.07.12.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:12:26 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 33/63] usb: dwc3: import from kernel v5.8
Date: Wed, 28 Oct 2026 15:08:59 +0100
Message-ID: <20261028140930.3025368-34-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v5.7 to v5.8.

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

List of commits: git log --oneline v5.7..v5.8
Commits imported:
63c7bb299fc9 usb: dwc3: gadget: Check for prepared TRBs
1c0e69ae1b9f usb: dwc3: Increase timeout for CmdAct cleared by device controller
b10e1c253577 usb: dwc3: gadget: Use SET_EP_PRIME for NoStream
140ca4cfea8a usb: dwc3: gadget: Handle stream transfers
aefe3d232b66 usb: dwc3: gadget: Don't prepare beyond a transfer
e0d19563eb6c usb: dwc3: gadget: Wait for transfer completion
3eaecd0c2333 usb: dwc3: gadget: Handle XferComplete for streams
548f8b316563 usb: dwc3: gadget: Enable XferComplete event
2e6e9e4b2ed7 usb: dwc3: gadget: Refactor TRB completion handler
b6842d4938c3 usb: dwc3: gadget: Check for in-progress END_TRANSFER
4244ba02edb8 usb: dwc3: Get MDWIDTH for DWC_usb32
9af21dd6faeb usb: dwc3: Add support for DWC_usb32 IP
d9feef974e0d usb: dwc3: gadget: Continue to process pending requests
f7ac582effc6 usb: dwc3: gadget: WARN on no-resource status
36f05d36b035 usb: dwc3: gadget: Issue END_TRANSFER to retry isoc transfer
9bc3395c2496 usb: dwc3: gadget: Store resource index of start cmd
8d99087c2db8 usb: dwc3: gadget: Properly handle failed kick_transfer
8bb14308a869 usb: dwc3: core: Use role-switch default dr_mode
fcd2def66392 usb: dwc3: gadget: Refactor dwc3_gadget_ep_dequeue
8411993e79df usb: dwc3: gadget: Remove unnecessary checks
a7027ca69d82 usb: dwc3: gadget: Give back staled requests
cb11ea56f37a usb: dwc3: gadget: Properly handle ClearFeature(halt)
c2cd3452d5f8 usb: dwc3: support continuous runtime PM with dual role
b33f69f56352 USB: dwc3: Use the correct style for SPDX License Identifier

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c   |  62 ++---
 drivers/usb/dwc3/core.h   |  83 ++++---
 drivers/usb/dwc3/debug.h  |   4 +-
 drivers/usb/dwc3/gadget.c | 469 +++++++++++++++++++++++++++++---------
 drivers/usb/dwc3/gadget.h |   2 +-
 drivers/usb/dwc3/io.h     |   2 +-
 6 files changed, 452 insertions(+), 170 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index edc17155cb2b..25c686a752b0 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -85,7 +85,9 @@ static int dwc3_get_dr_mode(struct dwc3 *dwc)
 		 * specified or set to OTG, then set the mode to peripheral.
 		 */
 		if (mode == USB_DR_MODE_OTG &&
-		    dwc->revision >= DWC3_REVISION_330A)
+		    (!IS_ENABLED(CONFIG_USB_ROLE_SWITCH) ||
+		     !device_property_read_bool(dwc->dev, "usb-role-switch")) &&
+		    !DWC3_VER_IS_PRIOR(DWC3, 330A))
 			mode = USB_DR_MODE_PERIPHERAL;
 	}
 
@@ -121,17 +123,19 @@ static void __dwc3_set_mode(struct work_struct *work)
 	if (dwc->dr_mode != USB_DR_MODE_OTG)
 		return;
 
+	pm_runtime_get_sync(dwc->dev);
+
 	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_OTG)
 		dwc3_otg_update(dwc, 0);
 
 	if (!dwc->desired_dr_role)
-		return;
+		goto out;
 
 	if (dwc->desired_dr_role == dwc->current_dr_role)
-		return;
+		goto out;
 
 	if (dwc->desired_dr_role == DWC3_GCTL_PRTCAP_OTG && dwc->edev)
-		return;
+		goto out;
 
 	switch (dwc->current_dr_role) {
 	case DWC3_GCTL_PRTCAP_HOST:
@@ -190,6 +194,9 @@ static void __dwc3_set_mode(struct work_struct *work)
 		break;
 	}
 
+out:
+	pm_runtime_mark_last_busy(dwc->dev);
+	pm_runtime_put_autosuspend(dwc->dev);
 }
 
 void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
@@ -257,7 +264,7 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
 	 * take a little more than 50ms. Set the polling rate at 20ms
 	 * for 10 times instead.
 	 */
-	if (dwc3_is_usb31(dwc) && dwc->revision >= DWC3_USB31_REVISION_190A)
+	if (DWC3_VER_IS_WITHIN(DWC31, 190A, ANY) || DWC3_IP_IS(DWC32))
 		retries = 10;
 
 	do {
@@ -265,8 +272,7 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
 		if (!(reg & DWC3_DCTL_CSFTRST))
 			goto done;
 
-		if (dwc3_is_usb31(dwc) &&
-		    dwc->revision >= DWC3_USB31_REVISION_190A)
+		if (DWC3_VER_IS_WITHIN(DWC31, 190A, ANY) || DWC3_IP_IS(DWC32))
 			msleep(20);
 		else
 			udelay(1);
@@ -283,7 +289,7 @@ done:
 	 * is cleared, we must wait at least 50ms before accessing the PHY
 	 * domain (synchronization delay).
 	 */
-	if (dwc3_is_usb31(dwc) && dwc->revision <= DWC3_USB31_REVISION_180A)
+	if (DWC3_VER_IS_WITHIN(DWC31, ANY, 180A))
 		msleep(50);
 
 	return 0;
@@ -298,7 +304,7 @@ static void dwc3_frame_length_adjustment(struct dwc3 *dwc)
 	u32 reg;
 	u32 dft;
 
-	if (dwc->revision < DWC3_REVISION_250A)
+	if (DWC3_VER_IS_PRIOR(DWC3, 250A))
 		return;
 
 	if (dwc->fladj == 0)
@@ -579,7 +585,7 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	 * will be '0' when the core is reset. Application needs to set it
 	 * to '1' after the core initialization is completed.
 	 */
-	if (dwc->revision > DWC3_REVISION_194A)
+	if (!DWC3_VER_IS_WITHIN(DWC3, ANY, 194A))
 		reg |= DWC3_GUSB3PIPECTL_SUSPHY;
 
 	/*
@@ -670,7 +676,7 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	 * be '0' when the core is reset. Application needs to set it to
 	 * '1' after the core initialization is completed.
 	 */
-	if (dwc->revision > DWC3_REVISION_194A)
+	if (!DWC3_VER_IS_WITHIN(DWC3, ANY, 194A))
 		reg |= DWC3_GUSB2PHYCFG_SUSPHY;
 
 	/*
@@ -719,15 +725,13 @@ static bool dwc3_core_is_valid(struct dwc3 *dwc)
 	u32 reg;
 
 	reg = dwc3_readl(dwc->regs, DWC3_GSNPSID);
+	dwc->ip = DWC3_GSNPS_ID(reg);
 
 	/* This should read as U3 followed by revision number */
-	if ((reg & DWC3_GSNPSID_MASK) == 0x55330000) {
-		/* Detected DWC_usb3 IP */
+	if (DWC3_IP_IS(DWC3)) {
 		dwc->revision = reg;
-	} else if ((reg & DWC3_GSNPSID_MASK) == 0x33310000) {
-		/* Detected DWC_usb31 IP */
+	} else if (DWC3_IP_IS(DWC31) || DWC3_IP_IS(DWC32)) {
 		dwc->revision = dwc3_readl(dwc->regs, DWC3_VER_NUMBER);
-		dwc->revision |= DWC3_REVISION_IS_DWC31;
 		dwc->version_type = dwc3_readl(dwc->regs, DWC3_VER_TYPE);
 	} else {
 		return false;
@@ -760,8 +764,7 @@ static void dwc3_core_setup_global_control(struct dwc3 *dwc)
 		 */
 		if ((dwc->dr_mode == USB_DR_MODE_HOST ||
 				dwc->dr_mode == USB_DR_MODE_OTG) &&
-				(dwc->revision >= DWC3_REVISION_210A &&
-				dwc->revision <= DWC3_REVISION_250A))
+				DWC3_VER_IS_WITHIN(DWC3, 210A, 250A))
 			reg |= DWC3_GCTL_DSBLCLKGTNG | DWC3_GCTL_SOFITPSYNC;
 		else
 			reg &= ~DWC3_GCTL_DSBLCLKGTNG;
@@ -804,7 +807,7 @@ static void dwc3_core_setup_global_control(struct dwc3 *dwc)
 	 * and falls back to high-speed mode which causes
 	 * the device to enter a Connect/Disconnect loop
 	 */
-	if (dwc->revision < DWC3_REVISION_190A)
+	if (DWC3_VER_IS_PRIOR(DWC3, 190A))
 		reg |= DWC3_GCTL_U2RSTECN;
 
 	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
@@ -957,7 +960,7 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		goto err0a;
 
 	if (hw_mode == DWC3_GHWPARAMS0_MODE_DRD &&
-	    dwc->revision > DWC3_REVISION_194A) {
+	    !DWC3_VER_IS_WITHIN(DWC3, ANY, 194A)) {
 		if (!dwc->dis_u3_susphy_quirk) {
 			reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
 			reg |= DWC3_GUSB3PIPECTL_SUSPHY;
@@ -1004,20 +1007,20 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	 * the DWC_usb3 controller. It is NOT available in the
 	 * DWC_usb31 controller.
 	 */
-	if (!dwc3_is_usb31(dwc) && dwc->revision >= DWC3_REVISION_310A) {
+	if (DWC3_VER_IS_WITHIN(DWC3, 310A, ANY)) {
 		reg = dwc3_readl(dwc->regs, DWC3_GUCTL2);
 		reg |= DWC3_GUCTL2_RST_ACTBITLATER;
 		dwc3_writel(dwc->regs, DWC3_GUCTL2, reg);
 	}
 
-	if (dwc->revision >= DWC3_REVISION_250A) {
+	if (!DWC3_VER_IS_PRIOR(DWC3, 250A)) {
 		reg = dwc3_readl(dwc->regs, DWC3_GUCTL1);
 
 		/*
 		 * Enable hardware control of sending remote wakeup
 		 * in HS when the device is in the L1 state.
 		 */
-		if (dwc->revision >= DWC3_REVISION_290A)
+		if (!DWC3_VER_IS_PRIOR(DWC3, 290A))
 			reg |= DWC3_GUCTL1_DEV_L1_EXIT_BY_HW;
 
 		if (dwc->dis_tx_ipgap_linecheck_quirk)
@@ -1049,7 +1052,7 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	 * Must config both number of packets and max burst settings to enable
 	 * RX and/or TX threshold.
 	 */
-	if (dwc3_is_usb31(dwc) && dwc->dr_mode == USB_DR_MODE_HOST) {
+	if (!DWC3_IP_IS(DWC3) && dwc->dr_mode == USB_DR_MODE_HOST) {
 		u8 rx_thr_num = dwc->rx_thr_num_pkt_prd;
 		u8 rx_maxburst = dwc->rx_max_burst_prd;
 		u8 tx_thr_num = dwc->tx_thr_num_pkt_prd;
@@ -1371,10 +1374,9 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 /* check whether the core supports IMOD */
 bool dwc3_has_imod(struct dwc3 *dwc)
 {
-	return ((dwc3_is_usb3(dwc) &&
-		 dwc->revision >= DWC3_REVISION_300A) ||
-		(dwc3_is_usb31(dwc) &&
-		 dwc->revision >= DWC3_USB31_REVISION_120A));
+	return DWC3_VER_IS_WITHIN(DWC3, 300A, ANY) ||
+		DWC3_VER_IS_WITHIN(DWC31, 120A, ANY) ||
+		DWC3_IP_IS(DWC32);
 }
 
 static void dwc3_check_params(struct dwc3 *dwc)
@@ -1395,7 +1397,7 @@ static void dwc3_check_params(struct dwc3 *dwc)
 	 * affected version.
 	 */
 	if (!dwc->imod_interval &&
-	    (dwc->revision == DWC3_REVISION_300A))
+	    DWC3_VER_IS(DWC3, 300A))
 		dwc->imod_interval = 1;
 
 	/* Check the maximum_speed parameter */
@@ -1417,7 +1419,7 @@ static void dwc3_check_params(struct dwc3 *dwc)
 		/*
 		 * default to superspeed plus if we are capable.
 		 */
-		if (dwc3_is_usb31(dwc) &&
+		if ((DWC3_IP_IS(DWC31) || DWC3_IP_IS(DWC32)) &&
 		    (DWC3_GHWPARAMS3_SSPHY_IFC(dwc->hwparams.hwparams3) ==
 		     DWC3_GHWPARAMS3_SSPHY_IFC_GEN2))
 			dwc->maximum_speed = USB_SPEED_SUPER_PLUS;
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 4c171a8e215f..013f42a2b5dc 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * core.h - DesignWare USB3 DRD Core Header
  *
@@ -69,6 +69,7 @@
 #define DWC3_GEVNTCOUNT_EHB	BIT(31)
 #define DWC3_GSNPSID_MASK	0xffff0000
 #define DWC3_GSNPSREV_MASK	0xffff
+#define DWC3_GSNPS_ID(p)	(((p) & DWC3_GSNPSID_MASK) >> 16)
 
 /* DWC3 registers memory space boundries */
 #define DWC3_XHCI_REGS_START		0x0
@@ -365,6 +366,9 @@
 #define DWC3_GHWPARAMS6_SRPSUPPORT		BIT(10)
 #define DWC3_GHWPARAMS6_EN_FPGA			BIT(7)
 
+/* DWC_usb32 only */
+#define DWC3_GHWPARAMS6_MDWIDTH(n)		((n) & (0x3 << 8))
+
 /* Global HWPARAMS7 Register */
 #define DWC3_GHWPARAMS7_RAM1_DEPTH(n)	((n) & 0xffff)
 #define DWC3_GHWPARAMS7_RAM2_DEPTH(n)	(((n) >> 16) & 0xffff)
@@ -491,6 +495,7 @@
 #define DWC3_DGCMD_SELECTED_FIFO_FLUSH	0x09
 #define DWC3_DGCMD_ALL_FIFO_FLUSH	0x0a
 #define DWC3_DGCMD_SET_ENDPOINT_NRDY	0x0c
+#define DWC3_DGCMD_SET_ENDPOINT_PRIME	0x0d
 #define DWC3_DGCMD_RUN_SOC_BUS_LOOPBACK	0x10
 
 #define DWC3_DGCMD_STATUS(n)		(((n) >> 12) & 0x0F)
@@ -697,6 +702,10 @@ struct dwc3_ep {
 #define DWC3_EP_END_TRANSFER_PENDING BIT(4)
 #define DWC3_EP_PENDING_REQUEST	BIT(5)
 #define DWC3_EP_DELAY_START	BIT(6)
+#define DWC3_EP_WAIT_TRANSFER_COMPLETE	BIT(7)
+#define DWC3_EP_IGNORE_NEXT_NOSTREAM	BIT(8)
+#define DWC3_EP_FORCE_RESTART_STREAM	BIT(9)
+#define DWC3_EP_FIRST_STREAM_PRIMED	BIT(10)
 
 	/* This last one is specific to EP0 */
 #define DWC3_EP0_DIR_IN		BIT(31)
@@ -949,7 +958,8 @@ struct dwc3_scratchpad_array {
  * @nr_scratch: number of scratch buffers
  * @u1u2: only used on revisions <1.83a for workaround
  * @maximum_speed: maximum speed requested (mainly for testing purposes)
- * @revision: revision register contents
+ * @ip: controller's ID
+ * @revision: controller's version of an IP
  * @version_type: VERSIONTYPE register contents, a sub release of a revision
  * @dr_mode: requested mode of operation
  * @current_dr_role: current role of operation when in dual-role mode
@@ -1110,15 +1120,15 @@ struct dwc3 {
 	u32			u1u2;
 	u32			maximum_speed;
 
-	/*
-	 * All 3.1 IP version constants are greater than the 3.0 IP
-	 * version constants. This works for most version checks in
-	 * dwc3. However, in the future, this may not apply as
-	 * features may be developed on newer versions of the 3.0 IP
-	 * that are not in the 3.1 IP.
-	 */
+	u32			ip;
+
+#define DWC3_IP			0x5533
+#define DWC31_IP		0x3331
+#define DWC32_IP		0x3332
+
 	u32			revision;
 
+#define DWC3_REVISION_ANY	0x0
 #define DWC3_REVISION_173A	0x5533173a
 #define DWC3_REVISION_175A	0x5533175a
 #define DWC3_REVISION_180A	0x5533180a
@@ -1143,20 +1153,20 @@ struct dwc3 {
 #define DWC3_REVISION_310A	0x5533310a
 #define DWC3_REVISION_330A	0x5533330a
 
-/*
- * NOTICE: we're using bit 31 as a "is usb 3.1" flag. This is really
- * just so dwc31 revisions are always larger than dwc3.
- */
-#define DWC3_REVISION_IS_DWC31		0x80000000
-#define DWC3_USB31_REVISION_110A	(0x3131302a | DWC3_REVISION_IS_DWC31)
-#define DWC3_USB31_REVISION_120A	(0x3132302a | DWC3_REVISION_IS_DWC31)
-#define DWC3_USB31_REVISION_160A	(0x3136302a | DWC3_REVISION_IS_DWC31)
-#define DWC3_USB31_REVISION_170A	(0x3137302a | DWC3_REVISION_IS_DWC31)
-#define DWC3_USB31_REVISION_180A	(0x3138302a | DWC3_REVISION_IS_DWC31)
-#define DWC3_USB31_REVISION_190A	(0x3139302a | DWC3_REVISION_IS_DWC31)
+#define DWC31_REVISION_ANY	0x0
+#define DWC31_REVISION_110A	0x3131302a
+#define DWC31_REVISION_120A	0x3132302a
+#define DWC31_REVISION_160A	0x3136302a
+#define DWC31_REVISION_170A	0x3137302a
+#define DWC31_REVISION_180A	0x3138302a
+#define DWC31_REVISION_190A	0x3139302a
+
+#define DWC32_REVISION_ANY	0x0
+#define DWC32_REVISION_100A	0x3130302a
 
 	u32			version_type;
 
+#define DWC31_VERSIONTYPE_ANY		0x0
 #define DWC31_VERSIONTYPE_EA01		0x65613031
 #define DWC31_VERSIONTYPE_EA02		0x65613032
 #define DWC31_VERSIONTYPE_EA03		0x65613033
@@ -1298,6 +1308,10 @@ struct dwc3_event_depevt {
 #define DEPEVT_STREAMEVT_FOUND		1
 #define DEPEVT_STREAMEVT_NOTFOUND	2
 
+/* Stream event parameter */
+#define DEPEVT_STREAM_PRIME		0xfffe
+#define DEPEVT_STREAM_NOSTREAM		0x0
+
 /* Control-only Status */
 #define DEPEVT_STATUS_CONTROL_DATA	1
 #define DEPEVT_STATUS_CONTROL_STATUS	2
@@ -1400,17 +1414,26 @@ void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode);
 void dwc3_set_mode(struct dwc3 *dwc, u32 mode);
 u32 dwc3_core_fifo_space(struct dwc3_ep *dep, u8 type);
 
-/* check whether we are on the DWC_usb3 core */
-static inline bool dwc3_is_usb3(struct dwc3 *dwc)
-{
-	return !(dwc->revision & DWC3_REVISION_IS_DWC31);
-}
+#define DWC3_IP_IS(_ip)							\
+	(dwc->ip == _ip##_IP)
 
-/* check whether we are on the DWC_usb31 core */
-static inline bool dwc3_is_usb31(struct dwc3 *dwc)
-{
-	return !!(dwc->revision & DWC3_REVISION_IS_DWC31);
-}
+#define DWC3_VER_IS(_ip, _ver)						\
+	(DWC3_IP_IS(_ip) && dwc->revision == _ip##_REVISION_##_ver)
+
+#define DWC3_VER_IS_PRIOR(_ip, _ver)					\
+	(DWC3_IP_IS(_ip) && dwc->revision < _ip##_REVISION_##_ver)
+
+#define DWC3_VER_IS_WITHIN(_ip, _from, _to)				\
+	(DWC3_IP_IS(_ip) &&						\
+	 dwc->revision >= _ip##_REVISION_##_from &&			\
+	 (!(_ip##_REVISION_##_to) ||					\
+	  dwc->revision <= _ip##_REVISION_##_to))
+
+#define DWC3_VER_TYPE_IS_WITHIN(_ip, _ver, _from, _to)			\
+	(DWC3_VER_IS(_ip, _ver) &&					\
+	 dwc->version_type >= _ip##_VERSIONTYPE_##_from &&		\
+	 (!(_ip##_VERSIONTYPE_##_to) ||					\
+	  dwc->version_type <= _ip##_VERSIONTYPE_##_to))
 
 bool dwc3_has_imod(struct dwc3 *dwc);
 
diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
index 4a13ceaf4093..d8f600e0e88f 100644
--- a/drivers/usb/dwc3/debug.h
+++ b/drivers/usb/dwc3/debug.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /**
  * debug.h - DesignWare USB3 DRD Controller Debug Header
  *
@@ -68,6 +68,8 @@ dwc3_gadget_generic_cmd_string(u8 cmd)
 		return "All FIFO Flush";
 	case DWC3_DGCMD_SET_ENDPOINT_NRDY:
 		return "Set Endpoint NRDY";
+	case DWC3_DGCMD_SET_ENDPOINT_PRIME:
+		return "Set Endpoint Prime";
 	case DWC3_DGCMD_RUN_SOC_BUS_LOOPBACK:
 		return "Run SoC Bus Loopback Test";
 	default:
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 585cb3deea7a..80c3ef134e41 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -95,7 +95,7 @@ int dwc3_gadget_set_link_state(struct dwc3 *dwc, enum dwc3_link_state state)
 	 * Wait until device controller is ready. Only applies to 1.94a and
 	 * later RTL.
 	 */
-	if (dwc->revision >= DWC3_REVISION_194A) {
+	if (!DWC3_VER_IS_PRIOR(DWC3, 194A)) {
 		while (--retries) {
 			reg = dwc3_readl(dwc->regs, DWC3_DSTS);
 			if (reg & DWC3_DSTS_DCNRD)
@@ -122,7 +122,7 @@ int dwc3_gadget_set_link_state(struct dwc3 *dwc, enum dwc3_link_state state)
 	 * The following code is racy when called from dwc3_gadget_wakeup,
 	 * and is not needed, at least on newer versions
 	 */
-	if (dwc->revision >= DWC3_REVISION_194A)
+	if (!DWC3_VER_IS_PRIOR(DWC3, 194A))
 		return 0;
 
 	/* wait for a change in DSTS */
@@ -273,7 +273,7 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned cmd,
 {
 	const struct usb_endpoint_descriptor *desc = dep->endpoint.desc;
 	struct dwc3		*dwc = dep->dwc;
-	u32			timeout = 1000;
+	u32			timeout = 5000;
 	u32			saved_config = 0;
 	u32			reg;
 
@@ -356,6 +356,8 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned cmd,
 				ret = 0;
 				break;
 			case DEPEVT_TRANSFER_NO_RESOURCE:
+				dev_WARN(dwc->dev, "No resource for %s\n",
+					 dep->name);
 				ret = -EINVAL;
 				break;
 			case DEPEVT_TRANSFER_BUS_EXPIRY:
@@ -387,9 +389,12 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned cmd,
 
 	trace_dwc3_gadget_ep_cmd(dep, cmd, params, cmd_status);
 
-	if (ret == 0 && DWC3_DEPCMD_CMD(cmd) == DWC3_DEPCMD_STARTTRANSFER) {
-		dep->flags |= DWC3_EP_TRANSFER_STARTED;
-		dwc3_gadget_ep_get_transfer_index(dep);
+	if (DWC3_DEPCMD_CMD(cmd) == DWC3_DEPCMD_STARTTRANSFER) {
+		if (ret == 0)
+			dep->flags |= DWC3_EP_TRANSFER_STARTED;
+
+		if (ret != -ETIMEDOUT)
+			dwc3_gadget_ep_get_transfer_index(dep);
 	}
 
 	if (saved_config) {
@@ -415,7 +420,8 @@ static int dwc3_send_clear_stall_ep_cmd(struct dwc3_ep *dep)
 	 * IN transfers due to a mishandled error condition. Synopsys
 	 * STAR 9000614252.
 	 */
-	if (dep->direction && (dwc->revision >= DWC3_REVISION_260A) &&
+	if (dep->direction &&
+	    !DWC3_VER_IS_PRIOR(DWC3, 260A) &&
 	    (dwc->gadget.speed >= USB_SPEED_SUPER))
 		cmd |= DWC3_DEPCMD_CLEARPENDIN;
 
@@ -573,6 +579,7 @@ static int dwc3_gadget_set_ep_config(struct dwc3_ep *dep, unsigned int action)
 
 	if (usb_ss_max_streams(comp_desc) && usb_endpoint_xfer_bulk(desc)) {
 		params.param1 |= DWC3_DEPCFG_STREAM_CAPABLE
+			| DWC3_DEPCFG_XFER_COMPLETE_EN
 			| DWC3_DEPCFG_STREAM_EVENT_EN;
 		dep->stream_capable = true;
 	}
@@ -603,6 +610,9 @@ static int dwc3_gadget_set_ep_config(struct dwc3_ep *dep, unsigned int action)
 	return dwc3_send_gadget_ep_cmd(dep, DWC3_DEPCMD_SETEPCONFIG, &params);
 }
 
+static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
+		bool interrupt);
+
 /**
  * __dwc3_gadget_ep_enable - initializes a hw endpoint
  * @dep: endpoint to be initialized
@@ -663,7 +673,7 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
 	 * Issue StartTransfer here with no-op TRB so we can always rely on No
 	 * Response Update Transfer command.
 	 */
-	if ((usb_endpoint_xfer_bulk(desc) && !dep->stream_capable) ||
+	if (usb_endpoint_xfer_bulk(desc) ||
 			usb_endpoint_xfer_int(desc)) {
 		struct dwc3_gadget_ep_cmd_params params;
 		struct dwc3_trb	*trb;
@@ -682,6 +692,29 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
 		ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
 		if (ret < 0)
 			return ret;
+
+		if (dep->stream_capable) {
+			/*
+			 * For streams, at start, there maybe a race where the
+			 * host primes the endpoint before the function driver
+			 * queues a request to initiate a stream. In that case,
+			 * the controller will not see the prime to generate the
+			 * ERDY and start stream. To workaround this, issue a
+			 * no-op TRB as normal, but end it immediately. As a
+			 * result, when the function driver queues the request,
+			 * the next START_TRANSFER command will cause the
+			 * controller to generate an ERDY to initiate the
+			 * stream.
+			 */
+			dwc3_stop_active_transfer(dep, true, true);
+
+			/*
+			 * All stream eps will reinitiate stream on NoStream
+			 * rejection until we can determine that the host can
+			 * prime after the first transfer.
+			 */
+			dep->flags |= DWC3_EP_FORCE_RESTART_STREAM;
+		}
 	}
 
 out:
@@ -690,8 +723,6 @@ out:
 	return 0;
 }
 
-static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
-		bool interrupt);
 static void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep)
 {
 	struct dwc3_request		*req;
@@ -912,7 +943,8 @@ static u32 dwc3_calc_trbs_left(struct dwc3_ep *dep)
 
 static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 		dma_addr_t dma, unsigned length, unsigned chain, unsigned node,
-		unsigned stream_id, unsigned short_not_ok, unsigned no_interrupt)
+		unsigned stream_id, unsigned short_not_ok,
+		unsigned no_interrupt, unsigned is_last)
 {
 	struct dwc3		*dwc = dep->dwc;
 	struct usb_gadget	*gadget = &dwc->gadget;
@@ -1005,6 +1037,8 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 
 	if (chain)
 		trb->ctrl |= DWC3_TRB_CTRL_CHN;
+	else if (dep->stream_capable && is_last)
+		trb->ctrl |= DWC3_TRB_CTRL_LST;
 
 	if (usb_endpoint_xfer_bulk(dep->endpoint.desc) && dep->stream_capable)
 		trb->ctrl |= DWC3_TRB_CTRL_SID_SOFN(stream_id);
@@ -1032,6 +1066,7 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 	unsigned		stream_id = req->request.stream_id;
 	unsigned		short_not_ok = req->request.short_not_ok;
 	unsigned		no_interrupt = req->request.no_interrupt;
+	unsigned		is_last = req->request.is_last;
 
 	if (req->request.num_sgs > 0) {
 		length = sg_dma_len(req->start_sg);
@@ -1052,7 +1087,7 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 	req->num_trbs++;
 
 	__dwc3_prepare_one_trb(dep, trb, dma, length, chain, node,
-			stream_id, short_not_ok, no_interrupt);
+			stream_id, short_not_ok, no_interrupt, is_last);
 }
 
 static void dwc3_prepare_one_trb_sg(struct dwc3_ep *dep,
@@ -1097,7 +1132,8 @@ static void dwc3_prepare_one_trb_sg(struct dwc3_ep *dep,
 					maxp - rem, false, 1,
 					req->request.stream_id,
 					req->request.short_not_ok,
-					req->request.no_interrupt);
+					req->request.no_interrupt,
+					req->request.is_last);
 		} else {
 			dwc3_prepare_one_trb(dep, req, chain, i);
 		}
@@ -1141,7 +1177,8 @@ static void dwc3_prepare_one_trb_linear(struct dwc3_ep *dep,
 		__dwc3_prepare_one_trb(dep, trb, dwc->bounce_addr, maxp - rem,
 				false, 1, req->request.stream_id,
 				req->request.short_not_ok,
-				req->request.no_interrupt);
+				req->request.no_interrupt,
+				req->request.is_last);
 	} else if (req->request.zero && req->request.length &&
 		   (IS_ALIGNED(req->request.length, maxp))) {
 		struct dwc3	*dwc = dep->dwc;
@@ -1158,7 +1195,8 @@ static void dwc3_prepare_one_trb_linear(struct dwc3_ep *dep,
 		__dwc3_prepare_one_trb(dep, trb, dwc->bounce_addr, 0,
 				false, 1, req->request.stream_id,
 				req->request.short_not_ok,
-				req->request.no_interrupt);
+				req->request.no_interrupt,
+				req->request.is_last);
 	} else {
 		dwc3_prepare_one_trb(dep, req, false, 0);
 	}
@@ -1194,6 +1232,14 @@ static void dwc3_prepare_trbs(struct dwc3_ep *dep)
 
 		if (!dwc3_calc_trbs_left(dep))
 			return;
+
+		/*
+		 * Don't prepare beyond a transfer. In DWC_usb32, its transfer
+		 * burst capability may try to read and use TRBs beyond the
+		 * active transfer instead of stopping.
+		 */
+		if (dep->stream_capable && req->request.is_last)
+			return;
 	}
 
 	list_for_each_entry_safe(req, n, &dep->pending_list, list) {
@@ -1217,9 +1263,19 @@ static void dwc3_prepare_trbs(struct dwc3_ep *dep)
 
 		if (!dwc3_calc_trbs_left(dep))
 			return;
+
+		/*
+		 * Don't prepare beyond a transfer. In DWC_usb32, its transfer
+		 * burst capability may try to read and use TRBs beyond the
+		 * active transfer instead of stopping.
+		 */
+		if (dep->stream_capable && req->request.is_last)
+			return;
 	}
 }
 
+static void dwc3_gadget_ep_cleanup_cancelled_requests(struct dwc3_ep *dep);
+
 static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep)
 {
 	struct dwc3_gadget_ep_cmd_params params;
@@ -1259,17 +1315,26 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep)
 
 	ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
 	if (ret < 0) {
-		/*
-		 * FIXME we need to iterate over the list of requests
-		 * here and stop, unmap, free and del each of the linked
-		 * requests instead of what we do now.
-		 */
-		if (req->trb)
-			memset(req->trb, 0, sizeof(struct dwc3_trb));
-		dwc3_gadget_del_and_unmap_request(dep, req, ret);
+		struct dwc3_request *tmp;
+
+		if (ret == -EAGAIN)
+			return ret;
+
+		dwc3_stop_active_transfer(dep, true, true);
+
+		list_for_each_entry_safe(req, tmp, &dep->started_list, list)
+			dwc3_gadget_move_cancelled_request(req);
+
+		/* If ep isn't started, then there's no end transfer pending */
+		if (!(dep->flags & DWC3_EP_END_TRANSFER_PENDING))
+			dwc3_gadget_ep_cleanup_cancelled_requests(dep);
+
 		return ret;
 	}
 
+	if (dep->stream_capable && req->request.is_last)
+		dep->flags |= DWC3_EP_WAIT_TRANSFER_COMPLETE;
+
 	return 0;
 }
 
@@ -1402,17 +1467,15 @@ static int __dwc3_gadget_start_isoc(struct dwc3_ep *dep)
 	int ret;
 	int i;
 
-	if (list_empty(&dep->pending_list)) {
+	if (list_empty(&dep->pending_list) &&
+	    list_empty(&dep->started_list)) {
 		dep->flags |= DWC3_EP_PENDING_REQUEST;
 		return -EAGAIN;
 	}
 
-	if (!dwc->dis_start_transfer_quirk && dwc3_is_usb31(dwc) &&
-	    (dwc->revision <= DWC3_USB31_REVISION_160A ||
-	     (dwc->revision == DWC3_USB31_REVISION_170A &&
-	      dwc->version_type >= DWC31_VERSIONTYPE_EA01 &&
-	      dwc->version_type <= DWC31_VERSIONTYPE_EA06))) {
-
+	if (!dwc->dis_start_transfer_quirk &&
+	    (DWC3_VER_IS_PRIOR(DWC31, 170A) ||
+	     DWC3_VER_TYPE_IS_WITHIN(DWC31, 170A, EA01, EA06))) {
 		if (dwc->gadget.speed <= USB_SPEED_HIGH && dep->direction)
 			return dwc3_gadget_start_isoc_quirk(dep);
 	}
@@ -1425,6 +1488,27 @@ static int __dwc3_gadget_start_isoc(struct dwc3_ep *dep)
 			break;
 	}
 
+	/*
+	 * After a number of unsuccessful start attempts due to bus-expiry
+	 * status, issue END_TRANSFER command and retry on the next XferNotReady
+	 * event.
+	 */
+	if (ret == -EAGAIN) {
+		struct dwc3_gadget_ep_cmd_params params;
+		u32 cmd;
+
+		cmd = DWC3_DEPCMD_ENDTRANSFER |
+			DWC3_DEPCMD_CMDIOC |
+			DWC3_DEPCMD_PARAM(dep->resource_index);
+
+		dep->resource_index = 0;
+		memset(&params, 0, sizeof(params));
+
+		ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
+		if (!ret)
+			dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
+	}
+
 	return ret;
 }
 
@@ -1457,6 +1541,9 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 	list_add_tail(&req->list, &dep->pending_list);
 	req->status = DWC3_REQUEST_STATUS_QUEUED;
 
+	if (dep->flags & DWC3_EP_WAIT_TRANSFER_COMPLETE)
+		return 0;
+
 	/* Start the transfer only after the END_TRANSFER is completed */
 	if (dep->flags & DWC3_EP_END_TRANSFER_PENDING) {
 		dep->flags |= DWC3_EP_DELAY_START;
@@ -1508,6 +1595,10 @@ static void dwc3_gadget_ep_skip_trbs(struct dwc3_ep *dep, struct dwc3_request *r
 {
 	int i;
 
+	/* If req->trb is not set, then the request has not started */
+	if (!req->trb)
+		return;
+
 	/*
 	 * If request was already started, this means we had to
 	 * stop the transfer. With that we also need to ignore
@@ -1556,39 +1647,40 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 
 	spin_lock_irqsave(&dwc->lock, flags);
 
-	list_for_each_entry(r, &dep->pending_list, list) {
+	list_for_each_entry(r, &dep->cancelled_list, list) {
 		if (r == req)
-			break;
+			goto out;
 	}
 
-	if (r != req) {
-		list_for_each_entry(r, &dep->started_list, list) {
-			if (r == req)
-				break;
+	list_for_each_entry(r, &dep->pending_list, list) {
+		if (r == req) {
+			dwc3_gadget_giveback(dep, req, -ECONNRESET);
+			goto out;
 		}
+	}
+
+	list_for_each_entry(r, &dep->started_list, list) {
 		if (r == req) {
+			struct dwc3_request *t;
+
 			/* wait until it is processed */
 			dwc3_stop_active_transfer(dep, true, true);
 
-			if (!r->trb)
-				goto out0;
+			/*
+			 * Remove any started request if the transfer is
+			 * cancelled.
+			 */
+			list_for_each_entry_safe(r, t, &dep->started_list, list)
+				dwc3_gadget_move_cancelled_request(r);
 
-			dwc3_gadget_move_cancelled_request(req);
-			if (dep->flags & DWC3_EP_TRANSFER_STARTED)
-				goto out0;
-			else
-				goto out1;
+			goto out;
 		}
-		dev_err(dwc->dev, "request %pK was not queued to %s\n",
-				request, ep->name);
-		ret = -EINVAL;
-		goto out0;
 	}
 
-out1:
-	dwc3_gadget_giveback(dep, req, -ECONNRESET);
-
-out0:
+	dev_err(dwc->dev, "request %pK was not queued to %s\n",
+		request, ep->name);
+	ret = -EINVAL;
+out:
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return ret;
@@ -1598,6 +1690,8 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol)
 {
 	struct dwc3_gadget_ep_cmd_params	params;
 	struct dwc3				*dwc = dep->dwc;
+	struct dwc3_request			*req;
+	struct dwc3_request			*tmp;
 	int					ret;
 
 	if (usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
@@ -1634,13 +1728,37 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol)
 		else
 			dep->flags |= DWC3_EP_STALL;
 	} else {
+		/*
+		 * Don't issue CLEAR_STALL command to control endpoints. The
+		 * controller automatically clears the STALL when it receives
+		 * the SETUP token.
+		 */
+		if (dep->number <= 1) {
+			dep->flags &= ~(DWC3_EP_STALL | DWC3_EP_WEDGE);
+			return 0;
+		}
 
 		ret = dwc3_send_clear_stall_ep_cmd(dep);
-		if (ret)
+		if (ret) {
 			dev_err(dwc->dev, "failed to clear STALL on %s\n",
 					dep->name);
-		else
-			dep->flags &= ~(DWC3_EP_STALL | DWC3_EP_WEDGE);
+			return ret;
+		}
+
+		dep->flags &= ~(DWC3_EP_STALL | DWC3_EP_WEDGE);
+
+		dwc3_stop_active_transfer(dep, true, true);
+
+		list_for_each_entry_safe(req, tmp, &dep->started_list, list)
+			dwc3_gadget_move_cancelled_request(req);
+
+		list_for_each_entry_safe(req, tmp, &dep->pending_list, list)
+			dwc3_gadget_move_cancelled_request(req);
+
+		if (!(dep->flags & DWC3_EP_END_TRANSFER_PENDING)) {
+			dep->flags &= ~DWC3_EP_DELAY_START;
+			dwc3_gadget_ep_cleanup_cancelled_requests(dep);
+		}
 	}
 
 	return ret;
@@ -1756,7 +1874,7 @@ static int __dwc3_gadget_wakeup(struct dwc3 *dwc)
 	}
 
 	/* Recent versions do this automatically */
-	if (dwc->revision < DWC3_REVISION_194A) {
+	if (DWC3_VER_IS_PRIOR(DWC3, 194A)) {
 		/* write zeroes to Link Change Request */
 		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 		reg &= ~DWC3_DCTL_ULSTCHNGREQ_MASK;
@@ -1818,12 +1936,12 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
 
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	if (is_on) {
-		if (dwc->revision <= DWC3_REVISION_187A) {
+		if (DWC3_VER_IS_WITHIN(DWC3, ANY, 187A)) {
 			reg &= ~DWC3_DCTL_TRGTULST_MASK;
 			reg |= DWC3_DCTL_TRGTULST_RX_DET;
 		}
 
-		if (dwc->revision >= DWC3_REVISION_194A)
+		if (!DWC3_VER_IS_PRIOR(DWC3, 194A))
 			reg &= ~DWC3_DCTL_KEEP_CONNECT;
 		reg |= DWC3_DCTL_RUN_STOP;
 
@@ -1897,7 +2015,7 @@ static void dwc3_gadget_enable_irq(struct dwc3 *dwc)
 			DWC3_DEVTEN_USBRSTEN |
 			DWC3_DEVTEN_DISCONNEVTEN);
 
-	if (dwc->revision < DWC3_REVISION_250A)
+	if (DWC3_VER_IS_PRIOR(DWC3, 250A))
 		reg |= DWC3_DEVTEN_ULSTCNGEN;
 
 	dwc3_writel(dwc->regs, DWC3_DEVTEN, reg);
@@ -1942,6 +2060,8 @@ static void dwc3_gadget_setup_nump(struct dwc3 *dwc)
 
 	ram2_depth = DWC3_GHWPARAMS7_RAM2_DEPTH(dwc->hwparams.hwparams7);
 	mdwidth = DWC3_GHWPARAMS0_MDWIDTH(dwc->hwparams.hwparams0);
+	if (DWC3_IP_IS(DWC32))
+		mdwidth += DWC3_GHWPARAMS6_MDWIDTH(dwc->hwparams.hwparams6);
 
 	nump = ((ram2_depth * mdwidth / 8) - 24 - 16) / 1024;
 	nump = min_t(u32, nump, 16);
@@ -1978,10 +2098,10 @@ static int __dwc3_gadget_start(struct dwc3 *dwc)
 	 * bursts of data without going through any sort of endpoint throttling.
 	 */
 	reg = dwc3_readl(dwc->regs, DWC3_GRXTHRCFG);
-	if (dwc3_is_usb31(dwc))
-		reg &= ~DWC31_GRXTHRCFG_PKTCNTSEL;
-	else
+	if (DWC3_IP_IS(DWC3))
 		reg &= ~DWC3_GRXTHRCFG_PKTCNTSEL;
+	else
+		reg &= ~DWC31_GRXTHRCFG_PKTCNTSEL;
 
 	dwc3_writel(dwc->regs, DWC3_GRXTHRCFG, reg);
 
@@ -2154,7 +2274,7 @@ static void dwc3_gadget_set_speed(struct usb_gadget *g,
 	 * STAR#9000525659: Clock Domain Crossing on DCTL in
 	 * USB 2.0 Mode
 	 */
-	if (dwc->revision < DWC3_REVISION_220A &&
+	if (DWC3_VER_IS_PRIOR(DWC3, 220A) &&
 	    !dwc->dis_metastability_quirk) {
 		reg |= DWC3_DCFG_SUPERSPEED;
 	} else {
@@ -2172,18 +2292,18 @@ static void dwc3_gadget_set_speed(struct usb_gadget *g,
 			reg |= DWC3_DCFG_SUPERSPEED;
 			break;
 		case USB_SPEED_SUPER_PLUS:
-			if (dwc3_is_usb31(dwc))
-				reg |= DWC3_DCFG_SUPERSPEED_PLUS;
-			else
+			if (DWC3_IP_IS(DWC3))
 				reg |= DWC3_DCFG_SUPERSPEED;
+			else
+				reg |= DWC3_DCFG_SUPERSPEED_PLUS;
 			break;
 		default:
 			dev_err(dwc->dev, "invalid speed (%d)\n", speed);
 
-			if (dwc->revision & DWC3_REVISION_IS_DWC31)
-				reg |= DWC3_DCFG_SUPERSPEED_PLUS;
-			else
+			if (DWC3_IP_IS(DWC3))
 				reg |= DWC3_DCFG_SUPERSPEED;
+			else
+				reg |= DWC3_DCFG_SUPERSPEED_PLUS;
 		}
 	}
 	dwc3_writel(dwc->regs, DWC3_DCFG, reg);
@@ -2226,14 +2346,17 @@ static int dwc3_gadget_init_in_endpoint(struct dwc3_ep *dep)
 	int size;
 
 	mdwidth = DWC3_MDWIDTH(dwc->hwparams.hwparams0);
+	if (DWC3_IP_IS(DWC32))
+		mdwidth += DWC3_GHWPARAMS6_MDWIDTH(dwc->hwparams.hwparams6);
+
 	/* MDWIDTH is represented in bits, we need it in bytes */
 	mdwidth /= 8;
 
 	size = dwc3_readl(dwc->regs, DWC3_GTXFIFOSIZ(dep->number >> 1));
-	if (dwc3_is_usb31(dwc))
-		size = DWC31_GTXFIFOSIZ_TXFDEP(size);
-	else
+	if (DWC3_IP_IS(DWC3))
 		size = DWC3_GTXFIFOSIZ_TXFDEP(size);
+	else
+		size = DWC31_GTXFIFOSIZ_TXFDEP(size);
 
 	/* FIFO Depth is in MDWDITH bytes. Multiply */
 	size *= mdwidth;
@@ -2270,16 +2393,18 @@ static int dwc3_gadget_init_out_endpoint(struct dwc3_ep *dep)
 	int size;
 
 	mdwidth = DWC3_MDWIDTH(dwc->hwparams.hwparams0);
+	if (DWC3_IP_IS(DWC32))
+		mdwidth += DWC3_GHWPARAMS6_MDWIDTH(dwc->hwparams.hwparams6);
 
 	/* MDWIDTH is represented in bits, convert to bytes */
 	mdwidth /= 8;
 
 	/* All OUT endpoints share a single RxFIFO space */
 	size = dwc3_readl(dwc->regs, DWC3_GRXFIFOSIZ(0));
-	if (dwc3_is_usb31(dwc))
-		size = DWC31_GRXFIFOSIZ_RXFDEP(size);
-	else
+	if (DWC3_IP_IS(DWC3))
 		size = DWC3_GRXFIFOSIZ_RXFDEP(size);
+	else
+		size = DWC31_GRXFIFOSIZ_RXFDEP(size);
 
 	/* FIFO depth is in MDWDITH bytes */
 	size *= mdwidth;
@@ -2531,10 +2656,8 @@ static int dwc3_gadget_ep_cleanup_completed_request(struct dwc3_ep *dep,
 
 	req->request.actual = req->request.length - req->remaining;
 
-	if (!dwc3_gadget_ep_request_completed(req)) {
-		__dwc3_gadget_kick_transfer(dep);
+	if (!dwc3_gadget_ep_request_completed(req))
 		goto out;
-	}
 
 	dwc3_gadget_giveback(dep, req, status);
 
@@ -2558,41 +2681,53 @@ static void dwc3_gadget_ep_cleanup_completed_requests(struct dwc3_ep *dep,
 	}
 }
 
+static bool dwc3_gadget_ep_should_continue(struct dwc3_ep *dep)
+{
+	struct dwc3_request	*req;
+
+	if (!list_empty(&dep->pending_list))
+		return true;
+
+	/*
+	 * We only need to check the first entry of the started list. We can
+	 * assume the completed requests are removed from the started list.
+	 */
+	req = next_request(&dep->started_list);
+	if (!req)
+		return false;
+
+	return !dwc3_gadget_ep_request_completed(req);
+}
+
 static void dwc3_gadget_endpoint_frame_from_event(struct dwc3_ep *dep,
 		const struct dwc3_event_depevt *event)
 {
 	dep->frame_number = event->parameters;
 }
 
-static void dwc3_gadget_endpoint_transfer_in_progress(struct dwc3_ep *dep,
-		const struct dwc3_event_depevt *event)
+static bool dwc3_gadget_endpoint_trbs_complete(struct dwc3_ep *dep,
+		const struct dwc3_event_depevt *event, int status)
 {
 	struct dwc3		*dwc = dep->dwc;
-	unsigned		status = 0;
-	bool			stop = false;
-
-	dwc3_gadget_endpoint_frame_from_event(dep, event);
-
-	if (event->status & DEPEVT_STATUS_BUSERR)
-		status = -ECONNRESET;
-
-	if (event->status & DEPEVT_STATUS_MISSED_ISOC) {
-		status = -EXDEV;
-
-		if (list_empty(&dep->started_list))
-			stop = true;
-	}
+	bool			no_started_trb = true;
 
 	dwc3_gadget_ep_cleanup_completed_requests(dep, event, status);
 
-	if (stop)
+	if (dep->flags & DWC3_EP_END_TRANSFER_PENDING)
+		goto out;
+
+	if (status == -EXDEV && list_empty(&dep->started_list))
 		dwc3_stop_active_transfer(dep, true, true);
+	else if (dwc3_gadget_ep_should_continue(dep))
+		if (__dwc3_gadget_kick_transfer(dep) == 0)
+			no_started_trb = false;
 
+out:
 	/*
 	 * WORKAROUND: This is the 2nd half of U1/U2 -> U0 workaround.
 	 * See dwc3_gadget_linksts_change_interrupt() for 1st half.
 	 */
-	if (dwc->revision < DWC3_REVISION_183A) {
+	if (DWC3_VER_IS_PRIOR(DWC3, 183A)) {
 		u32		reg;
 		int		i;
 
@@ -2603,7 +2738,7 @@ static void dwc3_gadget_endpoint_transfer_in_progress(struct dwc3_ep *dep,
 				continue;
 
 			if (!list_empty(&dep->started_list))
-				return;
+				return no_started_trb;
 		}
 
 		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
@@ -2612,15 +2747,124 @@ static void dwc3_gadget_endpoint_transfer_in_progress(struct dwc3_ep *dep,
 
 		dwc->u1u2 = 0;
 	}
+
+	return no_started_trb;
+}
+
+static void dwc3_gadget_endpoint_transfer_in_progress(struct dwc3_ep *dep,
+		const struct dwc3_event_depevt *event)
+{
+	int status = 0;
+
+	if (usb_endpoint_xfer_isoc(dep->endpoint.desc))
+		dwc3_gadget_endpoint_frame_from_event(dep, event);
+
+	if (event->status & DEPEVT_STATUS_BUSERR)
+		status = -ECONNRESET;
+
+	if (event->status & DEPEVT_STATUS_MISSED_ISOC)
+		status = -EXDEV;
+
+	dwc3_gadget_endpoint_trbs_complete(dep, event, status);
+}
+
+static void dwc3_gadget_endpoint_transfer_complete(struct dwc3_ep *dep,
+		const struct dwc3_event_depevt *event)
+{
+	int status = 0;
+
+	dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
+
+	if (event->status & DEPEVT_STATUS_BUSERR)
+		status = -ECONNRESET;
+
+	if (dwc3_gadget_endpoint_trbs_complete(dep, event, status))
+		dep->flags &= ~DWC3_EP_WAIT_TRANSFER_COMPLETE;
 }
 
 static void dwc3_gadget_endpoint_transfer_not_ready(struct dwc3_ep *dep,
 		const struct dwc3_event_depevt *event)
 {
 	dwc3_gadget_endpoint_frame_from_event(dep, event);
+
+	/*
+	 * The XferNotReady event is generated only once before the endpoint
+	 * starts. It will be generated again when END_TRANSFER command is
+	 * issued. For some controller versions, the XferNotReady event may be
+	 * generated while the END_TRANSFER command is still in process. Ignore
+	 * it and wait for the next XferNotReady event after the command is
+	 * completed.
+	 */
+	if (dep->flags & DWC3_EP_END_TRANSFER_PENDING)
+		return;
+
 	(void) __dwc3_gadget_start_isoc(dep);
 }
 
+static void dwc3_gadget_endpoint_stream_event(struct dwc3_ep *dep,
+		const struct dwc3_event_depevt *event)
+{
+	struct dwc3 *dwc = dep->dwc;
+
+	if (event->status == DEPEVT_STREAMEVT_FOUND) {
+		dep->flags |= DWC3_EP_FIRST_STREAM_PRIMED;
+		goto out;
+	}
+
+	/* Note: NoStream rejection event param value is 0 and not 0xFFFF */
+	switch (event->parameters) {
+	case DEPEVT_STREAM_PRIME:
+		/*
+		 * If the host can properly transition the endpoint state from
+		 * idle to prime after a NoStream rejection, there's no need to
+		 * force restarting the endpoint to reinitiate the stream. To
+		 * simplify the check, assume the host follows the USB spec if
+		 * it primed the endpoint more than once.
+		 */
+		if (dep->flags & DWC3_EP_FORCE_RESTART_STREAM) {
+			if (dep->flags & DWC3_EP_FIRST_STREAM_PRIMED)
+				dep->flags &= ~DWC3_EP_FORCE_RESTART_STREAM;
+			else
+				dep->flags |= DWC3_EP_FIRST_STREAM_PRIMED;
+		}
+
+		break;
+	case DEPEVT_STREAM_NOSTREAM:
+		if ((dep->flags & DWC3_EP_IGNORE_NEXT_NOSTREAM) ||
+		    !(dep->flags & DWC3_EP_FORCE_RESTART_STREAM) ||
+		    !(dep->flags & DWC3_EP_WAIT_TRANSFER_COMPLETE))
+			break;
+
+		/*
+		 * If the host rejects a stream due to no active stream, by the
+		 * USB and xHCI spec, the endpoint will be put back to idle
+		 * state. When the host is ready (buffer added/updated), it will
+		 * prime the endpoint to inform the usb device controller. This
+		 * triggers the device controller to issue ERDY to restart the
+		 * stream. However, some hosts don't follow this and keep the
+		 * endpoint in the idle state. No prime will come despite host
+		 * streams are updated, and the device controller will not be
+		 * triggered to generate ERDY to move the next stream data. To
+		 * workaround this and maintain compatibility with various
+		 * hosts, force to reinitate the stream until the host is ready
+		 * instead of waiting for the host to prime the endpoint.
+		 */
+		if (DWC3_VER_IS_WITHIN(DWC32, 100A, ANY)) {
+			unsigned int cmd = DWC3_DGCMD_SET_ENDPOINT_PRIME;
+
+			dwc3_send_gadget_generic_command(dwc, cmd, dep->number);
+		} else {
+			dep->flags |= DWC3_EP_DELAY_START;
+			dwc3_stop_active_transfer(dep, true, true);
+			return;
+		}
+		break;
+	}
+
+out:
+	dep->flags &= ~DWC3_EP_IGNORE_NEXT_NOSTREAM;
+}
+
 static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 		const struct dwc3_event_depevt *event)
 {
@@ -2665,8 +2909,12 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 			dep->flags &= ~DWC3_EP_DELAY_START;
 		}
 		break;
-	case DWC3_DEPEVT_STREAMEVT:
 	case DWC3_DEPEVT_XFERCOMPLETE:
+		dwc3_gadget_endpoint_transfer_complete(dep, event);
+		break;
+	case DWC3_DEPEVT_STREAMEVT:
+		dwc3_gadget_endpoint_stream_event(dep, event);
+		break;
 	case DWC3_DEPEVT_RXTXFIFOEVT:
 		break;
 	}
@@ -2758,6 +3006,14 @@ static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
 	WARN_ON_ONCE(ret);
 	dep->resource_index = 0;
 
+	/*
+	 * The END_TRANSFER command will cause the controller to generate a
+	 * NoStream Event, and it's not due to the host DP NoStream rejection.
+	 * Ignore the next NoStream event.
+	 */
+	if (dep->stream_capable)
+		dep->flags |= DWC3_EP_IGNORE_NEXT_NOSTREAM;
+
 	if (!interrupt)
 		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
 	else
@@ -2838,7 +3094,7 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
 	 * STAR#9000466709: RTL: Device : Disconnect event not
 	 * generated if setup packet pending in FIFO
 	 */
-	if (dwc->revision < DWC3_REVISION_188A) {
+	if (DWC3_VER_IS_PRIOR(DWC3, 188A)) {
 		if (dwc->setup_packet_pending)
 			dwc3_gadget_disconnect_interrupt(dwc);
 	}
@@ -2897,7 +3153,7 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 		 * STAR#9000483510: RTL: SS : USB3 reset event may
 		 * not be generated always when the link enters poll
 		 */
-		if (dwc->revision < DWC3_REVISION_190A)
+		if (DWC3_VER_IS_PRIOR(DWC3, 190A))
 			dwc3_gadget_reset_interrupt(dwc);
 
 		dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
@@ -2925,7 +3181,7 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 
 	/* Enable USB2 LPM Capability */
 
-	if ((dwc->revision > DWC3_REVISION_194A) &&
+	if (!DWC3_VER_IS_WITHIN(DWC3, ANY, 194A) &&
 	    (speed != DWC3_DSTS_SUPERSPEED) &&
 	    (speed != DWC3_DSTS_SUPERSPEED_PLUS)) {
 		reg = dwc3_readl(dwc->regs, DWC3_DCFG);
@@ -2944,11 +3200,10 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 		 * BESL value in the LPM token is less than or equal to LPM
 		 * NYET threshold.
 		 */
-		WARN_ONCE(dwc->revision < DWC3_REVISION_240A
-				&& dwc->has_lpm_erratum,
+		WARN_ONCE(DWC3_VER_IS_PRIOR(DWC3, 240A) && dwc->has_lpm_erratum,
 				"LPM Erratum not available on dwc3 revisions < 2.40a\n");
 
-		if (dwc->has_lpm_erratum && dwc->revision >= DWC3_REVISION_240A)
+		if (dwc->has_lpm_erratum && !DWC3_VER_IS_PRIOR(DWC3, 240A))
 			reg |= DWC3_DCTL_NYET_THRES(dwc->lpm_nyet_threshold);
 
 		dwc3_gadget_dctl_write_safe(dwc, reg);
@@ -3019,7 +3274,7 @@ static void dwc3_gadget_linksts_change_interrupt(struct dwc3 *dwc,
 	 * operational mode
 	 */
 	pwropt = DWC3_GHWPARAMS1_EN_PWROPT(dwc->hwparams.hwparams1);
-	if ((dwc->revision < DWC3_REVISION_250A) &&
+	if (DWC3_VER_IS_PRIOR(DWC3, 250A) &&
 			(pwropt != DWC3_GHWPARAMS1_EN_PWROPT_HIB)) {
 		if ((dwc->link_state == DWC3_LINK_STATE_U3) &&
 				(next == DWC3_LINK_STATE_RESUME)) {
@@ -3045,7 +3300,7 @@ static void dwc3_gadget_linksts_change_interrupt(struct dwc3 *dwc,
 	 * STAR#9000446952: RTL: Device SS : if U1/U2 ->U0 takes >128us
 	 * core send LGO_Ux entering U0
 	 */
-	if (dwc->revision < DWC3_REVISION_183A) {
+	if (DWC3_VER_IS_PRIOR(DWC3, 183A)) {
 		if (next == DWC3_LINK_STATE_U0) {
 			u32	u1u2;
 			u32	reg;
@@ -3156,7 +3411,7 @@ static void dwc3_gadget_interrupt(struct dwc3 *dwc,
 		break;
 	case DWC3_DEVICE_EVENT_EOPF:
 		/* It changed to be suspend event for version 2.30a and above */
-		if (dwc->revision >= DWC3_REVISION_230A) {
+		if (!DWC3_VER_IS_PRIOR(DWC3, 230A)) {
 			/*
 			 * Ignore suspend event until the gadget enters into
 			 * USB_STATE_CONFIGURED state.
@@ -3401,7 +3656,7 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 	 * is less than super speed because we don't have means, yet, to tell
 	 * composite.c that we are USB 2.0 + LPM ECN.
 	 */
-	if (dwc->revision < DWC3_REVISION_220A &&
+	if (DWC3_VER_IS_PRIOR(DWC3, 220A) &&
 	    !dwc->dis_metastability_quirk)
 		dev_info(dwc->dev, "changing max_speed on rev %08x\n",
 				dwc->revision);
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index fbc7d8013f0b..24dca3872022 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * gadget.h - DesignWare USB3 DRD Gadget Header
  *
diff --git a/drivers/usb/dwc3/io.h b/drivers/usb/dwc3/io.h
index 70acdf94a0bf..9bbe5d4bf076 100644
--- a/drivers/usb/dwc3/io.h
+++ b/drivers/usb/dwc3/io.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /**
  * io.h - DesignWare USB3 DRD IO Header
  *
-- 
2.53.0

