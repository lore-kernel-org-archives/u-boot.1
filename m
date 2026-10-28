Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761FC606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uf1FONq6;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FWUSzAIa
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4CA6781551;
	Wed, 28 Oct 2026 14:49:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c-cO2Z2ExcZs; Wed, 28 Oct 2026 14:49:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 923EC811C5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198870;
	b=M+q9+XwvvWtR+2Ljpj+pan/ODK4CJNjIggCvWUhXvZzIeknK4O3LkaLragtlkvQsbRRn
	 xCekj4EU24UJun4OTqRZ/kszcWVdBEHltxUgAPynXLY6i6jX6BFV0i2ucxQCi4mEO7ewO
	 h3h1HXua0QlDUbffIPHlrREXPtyXN7Qt6WHo/ZhHvjtal858wQWnmusG5uwAG7hKMZlQ2
	 MaR5cnZwgJzy/LEnsh10L6DBdO8qXzFTsYLx3zcYaz3CQyent8loxb7xzCK8IA+Ma7WGz
	 KVb8KsqIXUE0Zc1K+lcps1QPyMJqIa3/nOlki1tnrkb/wrJBAOqz8+lmPcHtP8D/3VA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198870;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=N08ZBrgMsyjx3ftDO7O7GR689tqBX00t5T5ExBAfNHw=;
	b=PaI7ks6SCbiA4IEbjka360rzRobgp9J6Kx/yXT5re/0Vop+JCERWymhsFlrEpKQml9mi
	 jULw6JLnrp1HGMoP/qGGsQ+xAQ+EH4gsGV8H67/3F9/tSGaqkKLUbQ6rs46LcpeHG/5NJ
	 ++Acvzj/pclgZzxow1D1HxtieOgzv/GFaArsj0AIyZdWakonrZUbqTUOohMqNeu+ep5Ci
	 ei+JdRdGLIBgSWEqHgDotnGSByKdxPJepKntwONJP55AaCPQHD4a6LO1hsZ9HAQxTZs8G
	 bOllgKW4qPIy38RjF4Mr3tHFw+GIF3/mbxaIcpmGMmapb4H1gm72Xg3oQRQE+OMR1Og==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198870;
	bh=N08ZBrgMsyjx3ftDO7O7GR689tqBX00t5T5ExBAfNHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uf1FONq6A6JReI95yaDVn7SgoflgOMtXjLRRbnf1RYFJrUs8/p0X9L3m4rbfHMq9I
	 1ZaZ3mKYpfyp4BbYtFI6xJc574Q4KfOQ4Biiyb5wRZK1NJ/GiT4XZvBsGd606aKn9F
	 j9GNAw3RX+2h8xAWjNahOoyIn4NWFR0KjdxVsDJhAI/C9uigd0xh7bADsY7VNhrgrk
	 EhssO+c/V+qq9WI0Y69YhC6GJaYHuCwkFNIzOm+6iHlOyUrGRRkvlVGSWrUe3yqyZP
	 O3LGmngZLu+obFqkkXSO3yaofDr5RyVJQIMmBqQG+rcxmVaXGV/6Su/Fxmnvp8CxS4
	 7diZ4jH3cgs0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 923EC811C5;
	Wed, 28 Oct 2026 14:47:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 484394D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:14:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 39E7A605EA
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:14:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2DGh1ZLcoZzt for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:14:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D5073605F1
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::634"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196888;
 b=WNTPGj4C9jSFVVz/q2YmBziOoTVRtC0IqkjQjyFpt0PNQhD8JHSVXiV6ae1QI1M6VgE9
 s43nGDkao/wLKzEZz72eccZIc8KxXrCH5U6ONFF/aMmW3DMN6qhxrW8UMgpIgAjTC8t3S
 Zvrgo9qpE8qkS1uwpoF37Nu+ehRUU57+kXKKuA6UU9pWrtP/jmQ2Gki7/QRzkkaISx1rl
 3x2dab8Gj6b4rODrIzK8a1ovuJQSBK1tfvtUfNzEt6qNnfeOVkkdYE3hEuGfo70cnFfcn
 GXy7xnlc56Er4tCb2RiwKbmlNInpvv6ZxQZC65Dmm22kJerny69978Hsx1VTw0PubnA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196888;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=N08ZBrgMsyjx3ftDO7O7GR689tqBX00t5T5ExBAfNHw=;
 b=KAlFw16hHB7dcA8TU6aNOw3gs9Bq8XTK6F8Q18fXHqeureqDt1LCCV+5UFBbXXSe8zVo
 zSBDvv0sEDxqp9FVV03p7pOkWHIx7ehkaDqOkOEEHB15LZGevoHfhx2Y7TiaTtMUq5MNE
 pmRKKUMmWkFR+jFFYHEc7nkgaPUOaVmYede3oqtSfsw1OGc5fPIesLc3HH+OdkMhTqPG7
 4Weuh8g8wICD4tFpnB1OGqJNuG+jQA88s11KcSnP9zh08412RK1RLhj1TXYEvm5R7Hikb
 mJzC5HpmwYEtCEt6utxiEZ/XvGO1bu2lnck0GvRVta8ZKqUIU881c0SX2TWnMiUAKnA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=FWUSzAIa; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::634"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=FWUSzAIa
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D5073605F1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:14:47 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c40f5077425so11756166b.1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196886; x=1793801686;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N08ZBrgMsyjx3ftDO7O7GR689tqBX00t5T5ExBAfNHw=;
 b=FWUSzAIad+xyanwl2ixRmq0XC+Nvk3mGTEsRfGFY80m80jPHSJcLjlvxFFvrx7KO8E
 BvPEan6c4qc5JYdG9VlWG4dmhQy2auelwH1yKib9aUqIy22zEKktIseuRgbCL0P8cVK0
 IYSaeC+nDKtTfvOmbjStgQFfoH1OiTWGozad1tSCimRPxRxoOYOr7i3Y1RZnKjKDCjte
 Wsa2HpTc0C0NpLg5CAuEA1e2XElsKLAKZpALCYYhp5nILzWb0aAdbZBEb5HPmlaC5l7u
 Y/P6bCUJbtAIaB5UueWX15M9NmpFI4euvPpeK5GmHSyUMigeD0cPj4uXbDu8td3JATPH
 FBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196886; x=1793801686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=N08ZBrgMsyjx3ftDO7O7GR689tqBX00t5T5ExBAfNHw=;
 b=PAmTvZ97XEEuaITJSws+CJ4mGtYJhdxISLRoMct70OwFpABtwpkviTJlArGvp1oEIx
 hVLtUdP9hpbrtSARorgxbqZ/zt0miJD4FZs5c2spriQRNNAVbnt24mCAWeA65RqtqCQ0
 hT7uWfR/yUjbw+LB3oXBtevoMYXYR+axggr0Dw52UC/J71fGpV9H9AV3OvliKpaqxdLL
 ZyCc8t4CJWrNjE+T9/Cs3uM3yglUzi9rn55W24PlrgUcxtuTet1WW9YbcFjfvU4iI2cT
 qFbGNRew9G3uOeAeiM2qonzaGqVrPK8Z/wFa8zDkPEqPlb0LYhPlCf+QLC3sQ0NDcv/d
 TRgA==
X-Gm-Message-State: AFq9FYJ5fecYvtu17BOQxsQC7nreDlTAtin7k4nmC4bcomAlIXBbatTu
 VnAuriByEz93pXxRyd1z5IlvaMZ9wG+gVyDeO8pd588Pj5ePBsRQv9K24zJ8A9/VwH9KQljY2g+
 Rj4jA
X-Gm-Gg: AYBFou1E6SF/yGrk0lwPmTvDHWwIgMqAY0Xt8bYpe4wpSn2ho1BtYn7MjaFChPeITtP
 6BxhsHEUKapTxG0guD2QqQu4HD7AZif3sXfuPHOCjSj7cHIoJ+UEroHQBAUxQ48PiF1w3JHodFG
 Tii8SN4aKLiY/023YD3kBYD1wKCRzKCJc2IhtT53tv8czVWvr9csmiixj7FTSXIyyse30HqKRQD
 qgN+q4H4xQfMTgB/N6xTkkNpBBxAh75jMDL4TssXH3SZ8b8WNvmDvO58gq/1mdyhtpXAyz63lx3
 SRN1ISqSVlruu7/cuN1d/L/iaGBzuT5+Jom7yQatT5bKTZxhaCBaAZ8gQW1d45jDCILLIt3sik7
 FNFkFbL7TBB1/ObOqAyo8rFAVlxKnyw1OrR/JipaJRL1h+K1jXTOcycLq1lGDohdL80uoflQwQL
 22T3A/lrWpdIvFN3e+neQYWAPXB+vZdgXXzD5CxSCCp4cHOz769aohqb7o96PQzSIZYJHFRULMw
 +hzX+rHNUyrZnFiUdQmtcgYqJl8M5/4C5BuNaCoz2u5HcqR+lfPq7mh++XN98Xa4WL0GWdiaVzB
 fxk7bzRi7Yrsi4vo19UjrhmSxOmkWuNjdfYRa/EA+rrJ7uUuXEnAbA4kYkdJr9Q8miHgDxoP+3o
 5JOSzTMVulQ==
X-Received: by 2002:a17:906:5a73:b0:c29:4634:5c8f with SMTP id
 a640c23a62f3a-c49bda28beemr270050966b.0.1793196885527; 
 Wed, 28 Oct 2026 07:14:45 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd524266sm630210266b.38.2026.10.28.07.14.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:14:45 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 62/63] usb: gadget: re-import epautoconf.c from kernel
 v6.16
Date: Wed, 28 Oct 2026 15:09:28 +0100
Message-ID: <20261028140930.3025368-63-anders.roxell@linaro.org>
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

From: Jerome Forissier <jerome.forissier@linaro.org>

Replace drivers/usb/gadget/epautoconf.c with the one from the Linux
kernel. Fixes will come later.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/gadget/epautoconf.c | 292 +++++++++++++++-----------------
 1 file changed, 133 insertions(+), 159 deletions(-)

diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
index 495460473e9a..4fbea9137240 100644
--- a/drivers/usb/gadget/epautoconf.c
+++ b/drivers/usb/gadget/epautoconf.c
@@ -1,172 +1,123 @@
 // SPDX-License-Identifier: GPL-2.0+
+/* Imported from Linux v6.16 */
 /*
  * epautoconf.c -- endpoint autoconfiguration for usb gadget drivers
  *
  * Copyright (C) 2004 David Brownell
- *
- * Ported to U-Boot by: Thomas Smits <ts.smits@gmail.com> and
- *                      Remy Bohmer <linux@bohmer.net>
  */
 
-#include <linux/usb/ch9.h>
-#include <linux/errno.h>
-#include <linux/usb/gadget.h>
-#include <asm/unaligned.h>
-
-#define isdigit(c)      ('0' <= (c) && (c) <= '9')
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/device.h>
 
-/* we must assign addresses for configurable endpoints (like net2280) */
-static unsigned epnum;
+#include <linux/ctype.h>
+#include <linux/string.h>
 
-/* #define MANY_ENDPOINTS */
-#ifdef MANY_ENDPOINTS
-/* more than 15 configurable endpoints */
-static unsigned in_epnum;
-#endif
+#include <linux/usb/ch9.h>
+#include <linux/usb/gadget.h>
 
-/*
- * This should work with endpoints from controller drivers sharing the
- * same endpoint naming convention.  By example:
+/**
+ * usb_ep_autoconfig_ss() - choose an endpoint matching the ep
+ * descriptor and ep companion descriptor
+ * @gadget: The device to which the endpoint must belong.
+ * @desc: Endpoint descriptor, with endpoint direction and transfer mode
+ *    initialized.  For periodic transfers, the maximum packet
+ *    size must also be initialized.  This is modified on
+ *    success.
+ * @ep_comp: Endpoint companion descriptor, with the required
+ *    number of streams. Will be modified when the chosen EP
+ *    supports a different number of streams.
+ *
+ * This routine replaces the usb_ep_autoconfig when needed
+ * superspeed enhancments. If such enhancemnets are required,
+ * the FD should call usb_ep_autoconfig_ss directly and provide
+ * the additional ep_comp parameter.
+ *
+ * By choosing an endpoint to use with the specified descriptor,
+ * this routine simplifies writing gadget drivers that work with
+ * multiple USB device controllers.  The endpoint would be
+ * passed later to usb_ep_enable(), along with some descriptor.
+ *
+ * That second descriptor won't always be the same as the first one.
+ * For example, isochronous endpoints can be autoconfigured for high
+ * bandwidth, and then used in several lower bandwidth altsettings.
+ * Also, high and full speed descriptors will be different.
  *
- *	- ep1, ep2, ... address is fixed, not direction or type
- *	- ep1in, ep2out, ... address and direction are fixed, not type
- *	- ep1-bulk, ep2-bulk, ... address and type are fixed, not direction
- *	- ep1in-bulk, ep2out-iso, ... all three are fixed
- *	- ep-* ... no functionality restrictions
+ * Be sure to examine and test the results of autoconfiguration
+ * on your hardware.  This code may not make the best choices
+ * about how to use the USB controller, and it can't know all
+ * the restrictions that may apply. Some combinations of driver
+ * and hardware won't be able to autoconfigure.
  *
- * Type suffixes are "-bulk", "-iso", or "-int".  Numbers are decimal.
- * Less common restrictions are implied by gadget_is_*().
+ * On success, this returns an claimed usb_ep, and modifies the endpoint
+ * descriptor bEndpointAddress.  For bulk endpoints, the wMaxPacket value
+ * is initialized as if the endpoint were used at full speed and
+ * the bmAttribute field in the ep companion descriptor is
+ * updated with the assigned number of streams if it is
+ * different from the original value. To prevent the endpoint
+ * from being returned by a later autoconfig call, claims it by
+ * assigning ep->claimed to true.
  *
- * NOTE:  each endpoint is unidirectional, as specified by its USB
- * descriptor; and isn't specific to a configuration or altsetting.
+ * On failure, this returns a null endpoint descriptor.
  */
-static int ep_matches(
+struct usb_ep *usb_ep_autoconfig_ss(
 	struct usb_gadget		*gadget,
-	struct usb_ep			*ep,
-	struct usb_endpoint_descriptor	*desc
+	struct usb_endpoint_descriptor	*desc,
+	struct usb_ss_ep_comp_descriptor *ep_comp
 )
 {
-	u8		type;
-	const char	*tmp;
-	u16		max;
-
-	/* endpoint already claimed? */
-	if (NULL != ep->driver_data)
-		return 0;
-
-	/* only support ep0 for portable CONTROL traffic */
-	type = desc->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK;
-	if (USB_ENDPOINT_XFER_CONTROL == type)
-		return 0;
-
-	/* some other naming convention */
-	if ('e' != ep->name[0])
-		return 0;
+	struct usb_ep	*ep;
 
-	/* type-restriction:  "-iso", "-bulk", or "-int".
-	 * direction-restriction:  "in", "out".
-	 */
-	if ('-' != ep->name[2]) {
-		tmp = strrchr(ep->name, '-');
-		if (tmp) {
-			switch (type) {
-			case USB_ENDPOINT_XFER_INT:
-				/* bulk endpoints handle interrupt transfers,
-				 * except the toggle-quirky iso-synch kind
-				 */
-				if ('s' == tmp[2])	/* == "-iso" */
-					return 0;
-				break;
-			case USB_ENDPOINT_XFER_BULK:
-				if ('b' != tmp[1])	/* != "-bulk" */
-					return 0;
-				break;
-			case USB_ENDPOINT_XFER_ISOC:
-				if ('s' != tmp[2])	/* != "-iso" */
-					return 0;
-			}
-		} else {
-			tmp = ep->name + strlen(ep->name);
-		}
-
-		/* direction-restriction:  "..in-..", "out-.." */
-		tmp--;
-		if (!isdigit(*tmp)) {
-			if (desc->bEndpointAddress & USB_DIR_IN) {
-				if ('n' != *tmp)
-					return 0;
-			} else {
-				if ('t' != *tmp)
-					return 0;
-			}
-		}
+	if (gadget->ops->match_ep) {
+		ep = gadget->ops->match_ep(gadget, desc, ep_comp);
+		if (ep)
+			goto found_ep;
 	}
 
-	/* endpoint maxpacket size is an input parameter, except for bulk
-	 * where it's an output parameter representing the full speed limit.
-	 * the usb spec fixes high speed bulk maxpacket at 512 bytes.
-	 */
-	max = 0x7ff & le16_to_cpu(get_unaligned(&desc->wMaxPacketSize));
-	switch (type) {
-	case USB_ENDPOINT_XFER_INT:
-		/* INT:  limit 64 bytes full speed, 1024 high speed */
-		if (!gadget->is_dualspeed && max > 64)
-			return 0;
-		/* FALLTHROUGH */
-
-	case USB_ENDPOINT_XFER_ISOC:
-		/* ISO:  limit 1023 bytes full speed, 1024 high speed */
-		if (ep->maxpacket < max)
-			return 0;
-		if (!gadget->is_dualspeed && max > 1023)
-			return 0;
-
-		/* BOTH:  "high bandwidth" works only at high speed */
-		if ((get_unaligned(&desc->wMaxPacketSize) &
-					__constant_cpu_to_le16(3<<11))) {
-			if (!gadget->is_dualspeed)
-				return 0;
-			/* configure your hardware with enough buffering!! */
-		}
-		break;
+	/* Second, look at endpoints until an unclaimed one looks usable */
+	list_for_each_entry (ep, &gadget->ep_list, ep_list) {
+		if (usb_gadget_ep_match_desc(gadget, ep, desc, ep_comp))
+			goto found_ep;
 	}
 
-	/* MATCH!! */
+	/* Fail */
+	return NULL;
+found_ep:
+
+	/*
+	 * If the protocol driver hasn't yet decided on wMaxPacketSize
+	 * and wants to know the maximum possible, provide the info.
+	 */
+	if (desc->wMaxPacketSize == 0)
+		desc->wMaxPacketSize = cpu_to_le16(ep->maxpacket_limit);
 
 	/* report address */
+	desc->bEndpointAddress &= USB_DIR_IN;
 	if (isdigit(ep->name[2])) {
-		u8	num = dectoul(&ep->name[2], NULL);
+		u8 num = simple_strtoul(&ep->name[2], NULL, 10);
 		desc->bEndpointAddress |= num;
-#ifdef	MANY_ENDPOINTS
 	} else if (desc->bEndpointAddress & USB_DIR_IN) {
-		if (++in_epnum > 15)
-			return 0;
-		desc->bEndpointAddress = USB_DIR_IN | in_epnum;
-#endif
+		if (++gadget->in_epnum > 15)
+			return NULL;
+		desc->bEndpointAddress = USB_DIR_IN | gadget->in_epnum;
 	} else {
-		if (++epnum > 15)
-			return 0;
-		desc->bEndpointAddress |= epnum;
+		if (++gadget->out_epnum > 15)
+			return NULL;
+		desc->bEndpointAddress |= gadget->out_epnum;
 	}
 
-	/* report (variable) full speed bulk maxpacket */
-	if (USB_ENDPOINT_XFER_BULK == type) {
-		int size = ep->maxpacket;
-
-		/* min() doesn't work on bitfields with gcc-3.5 */
-		if (size > 64)
-			size = 64;
-		put_unaligned(cpu_to_le16(size), &desc->wMaxPacketSize);
-	}
-
-	if (gadget->ops->ep_conf)
-		return gadget->ops->ep_conf(gadget, ep, desc);
-
-	return 1;
+	ep->address = desc->bEndpointAddress;
+	ep->desc = NULL;
+	ep->comp_desc = NULL;
+	ep->claimed = true;
+	return ep;
 }
+EXPORT_SYMBOL_GPL(usb_ep_autoconfig_ss);
 
 /**
- * usb_ep_autoconfig - choose an endpoint matching the descriptor
+ * usb_ep_autoconfig() - choose an endpoint matching the
+ * descriptor
  * @gadget: The device to which the endpoint must belong.
  * @desc: Endpoint descriptor, with endpoint direction and transfer mode
  *	initialized.  For periodic transfers, the maximum packet
@@ -187,11 +138,12 @@ static int ep_matches(
  * USB controller, and it can't know all the restrictions that may apply.
  * Some combinations of driver and hardware won't be able to autoconfigure.
  *
- * On success, this returns an un-claimed usb_ep, and modifies the endpoint
+ * On success, this returns an claimed usb_ep, and modifies the endpoint
  * descriptor bEndpointAddress.  For bulk endpoints, the wMaxPacket value
- * is initialized as if the endpoint were used at full speed.  To prevent
- * the endpoint from being returned by a later autoconfig call, claim it
- * by assigning ep->driver_data to some non-null value.
+ * is initialized as if the endpoint were used at full speed. Because of
+ * that the users must consider adjusting the autoconfigured descriptor.
+ * To prevent the endpoint from being returned by a later autoconfig call,
+ * claims it by assigning ep->claimed to true.
  *
  * On failure, this returns a null endpoint descriptor.
  */
@@ -200,23 +152,45 @@ struct usb_ep *usb_ep_autoconfig(
 	struct usb_endpoint_descriptor	*desc
 )
 {
-	struct usb_ep *ep;
+	struct usb_ep	*ep;
+	u8		type;
 
-	if (gadget->ops->match_ep) {
-		ep = gadget->ops->match_ep(gadget, desc, NULL);
-		if (ep && ep_matches(gadget, ep, desc))
-			return ep;
-	}
+	ep = usb_ep_autoconfig_ss(gadget, desc, NULL);
+	if (!ep)
+		return NULL;
 
-	/* Second, look at endpoints until an unclaimed one looks usable */
-	list_for_each_entry(ep, &gadget->ep_list, ep_list) {
-		if (ep_matches(gadget, ep, desc))
-			return ep;
+	type = usb_endpoint_type(desc);
+
+	/* report (variable) full speed bulk maxpacket */
+	if (type == USB_ENDPOINT_XFER_BULK) {
+		int size = ep->maxpacket_limit;
+
+		/* min() doesn't work on bitfields with gcc-3.5 */
+		if (size > 64)
+			size = 64;
+		desc->wMaxPacketSize = cpu_to_le16(size);
 	}
 
-	/* Fail */
-	return NULL;
+	return ep;
+}
+EXPORT_SYMBOL_GPL(usb_ep_autoconfig);
+
+/**
+ * usb_ep_autoconfig_release - releases endpoint and set it to initial state
+ * @ep: endpoint which should be released
+ *
+ * This function can be used during function bind for endpoints obtained
+ * from usb_ep_autoconfig(). It unclaims endpoint claimed by
+ * usb_ep_autoconfig() to make it available for other functions. Endpoint
+ * which was released is no longer valid and shouldn't be used in
+ * context of function which released it.
+ */
+void usb_ep_autoconfig_release(struct usb_ep *ep)
+{
+	ep->claimed = false;
+	ep->driver_data = NULL;
 }
+EXPORT_SYMBOL_GPL(usb_ep_autoconfig_release);
 
 /**
  * usb_ep_autoconfig_reset - reset endpoint autoconfig state
@@ -224,18 +198,18 @@ struct usb_ep *usb_ep_autoconfig(
  *
  * Use this for devices where one configuration may need to assign
  * endpoint resources very differently from the next one.  It clears
- * state such as ep->driver_data and the record of assigned endpoints
+ * state such as ep->claimed and the record of assigned endpoints
  * used by usb_ep_autoconfig().
  */
-void usb_ep_autoconfig_reset(struct usb_gadget *gadget)
+void usb_ep_autoconfig_reset (struct usb_gadget *gadget)
 {
 	struct usb_ep	*ep;
 
-	list_for_each_entry(ep, &gadget->ep_list, ep_list) {
+	list_for_each_entry (ep, &gadget->ep_list, ep_list) {
+		ep->claimed = false;
 		ep->driver_data = NULL;
 	}
-#ifdef	MANY_ENDPOINTS
-	in_epnum = 0;
-#endif
-	epnum = 0;
+	gadget->in_epnum = 0;
+	gadget->out_epnum = 0;
 }
+EXPORT_SYMBOL_GPL(usb_ep_autoconfig_reset);
-- 
2.53.0

