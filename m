Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C72C3601A
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 09:55:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9ADC82E0A;
	Mon,  7 Apr 2025 11:54:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hOxwn+IQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9151082E0A; Mon,  7 Apr 2025 11:54:56 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94AE982D5E
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 11:54:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ac3eb3fdd2eso439019566b.0
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 02:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744019694; x=1744624494; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=resvhYQ+t8eeLG1/k3yLTpo63axZ9gR++7sMNJe8Kyo=;
 b=hOxwn+IQtiP7SnPNTBTchIzuS/phWTQQnp68+2oDPhrXYr6pYtvTD1p6dCHxYyTARM
 lszGY03rNV+ka2mdYgF9Gut2HfIdHJLZohG9rAoDpGpMWS8UDYpw8Eg9wcE7UZ2Ipeun
 MbYs5beeNVkd/XTFtSfbqsoBbhG7tP/B8Ui5g/q9ZemLCwkqPiwd/skBEVs4k0SsH0UY
 scqMfFaERdzkA9lQCdOYqlj4jXR8rphF2KcHOeekeahZv2v5ZWDzbnVxU5tPXdsYturt
 AuuoxUvPmjIL6l4hMO6sHWd2woNiWKgUzUmGEItOTqSgVEGTI4W+hwJcNaYuHmb+25bW
 79cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744019694; x=1744624494;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=resvhYQ+t8eeLG1/k3yLTpo63axZ9gR++7sMNJe8Kyo=;
 b=AfMYabQ8B1zBFwY2OdHNPABInBsgs45Z+UWsAsDXnpVGjTSMjO9xR6/1p5+pTCmwS9
 //eAoLwsIF0D9creEcw6eVV6Dtu69WJINHKC7za6JilO3gp/2AeNUYSBae4d8QxcEVCV
 aCCb9nvNhqJXW+RMEAfDAkP8AD0ZpJw3IYcy2u/d8iC5R55rTLEFihzxDWQWOj6rsubI
 PCBhJsMlxcpJn/GQFVZz9fK17+ucnoX1IL5Tuqkvccx1PNCDzCPEzlcnNZb/XYSB43uV
 86lzATOLnPlzyAA7RHRnmJXCmb5FrAr/fmtzJip91CdIgHdbi4KxEjDZkuwg5Pu94GM7
 c8sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUl8fpMR02UowUtssCGtewEF19haJ6UW7esz33FUi2o9P0VwvAftXBbEknFhMQPCRP+6JbPQwY=@lists.denx.de
X-Gm-Message-State: AOJu0YxxVdtZ/34aRD/dRUvmpDgTwdJKLDeUU24V0FFuzkHbarG7P4ul
 NVTaSez3OhQ/D7VA/treuFU+MWI713xhAW7zAjmgugC2Nhxp0KUqYiJoRf8VKgHz3QILN6+yqn9
 Q
X-Gm-Gg: ASbGnctavrr4EYsGFMuAJ8igLikBxF0g/xsFD+bnGiWMjPqraHZy8fUSa3GwIZhNmX+
 JZpntxHh1C9s3zCPU3WUayg+0e3g+rRuVBYIdArVmqyCrEBtIcL8M+QzgzyvLHdvwyKRT+H1Isn
 HEMUcH+QDgcRVHkWMGZsk+0nPe2aabixqWohH3GqNk1PLVyq39llvfS+9SAHSz5446MTCExjxkE
 KC1vVrR/jcfqjskS6ta1af+Q9uGVFG0TTEzo2dPpjr4AusvGAs3FULHZmayaRwWg35hz0ZMaK/k
 4z/HRv3q92cSXzpX9D52SvC4T9LaV5e22JDsdJLX61ksA4oYwpCZw42gDA==
X-Google-Smtp-Source: AGHT+IGyRRo5tWWghPWG5Cd4SjnyPeLb+CKeT+YZNeTn117RsPG4xldP5luf/cWIHZTEqx3nHMunyQ==
X-Received: by 2002:a17:907:9727:b0:ac4:4c8:5e30 with SMTP id
 a640c23a62f3a-ac7d1876af2mr1220505266b.17.1744019682447; 
 Mon, 07 Apr 2025 02:54:42 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:7d3f:b102:5311:c65b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7c013f6b5sm735733766b.109.2025.04.07.02.54.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 02:54:42 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 07 Apr 2025 11:54:25 +0200
Subject: [PATCH 5/6] usb: host: ehci-msm: Drop redundant EHCI register writes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-ehci-msm-fixes-v1-5-f8b30eb05d07@linaro.org>
References: <20250407-ehci-msm-fixes-v1-0-f8b30eb05d07@linaro.org>
In-Reply-To: <20250407-ehci-msm-fixes-v1-0-f8b30eb05d07@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>
Cc: Sumit Garg <sumit.garg@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Jianfeng Zhu <JianfengA.Zhu@sony.com>, Jacky Cao <Jacky.Cao@sony.com>, 
 Sam Day <me@samcday.com>, u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14.2
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

ehci_unregister() already clears the CMD_RUN bit with more careful checks.
It also ensures that we only do this in case we were actually in USB host
(rather than USB device) mode. It's not clear what the extra register
writes in the Qualcomm-specific ehci-msm driver are supposed to do, so just
drop them.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/usb/host/ehci-msm.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/usb/host/ehci-msm.c b/drivers/usb/host/ehci-msm.c
index 17cfff8380c3953900fe6383bee396b147287592..659a917ad27372f8f5c7138c40881b60413323e5 100644
--- a/drivers/usb/host/ehci-msm.c
+++ b/drivers/usb/host/ehci-msm.c
@@ -87,16 +87,12 @@ cleanup_clocks:
 static int ehci_usb_remove(struct udevice *dev)
 {
 	struct msm_ehci_priv *p = dev_get_priv(dev);
-	struct usb_ehci *ehci = p->ehci;
 	int ret;
 
 	ret = ehci_deregister(dev);
 	if (ret)
 		return ret;
 
-	/* Stop controller. */
-	clrbits_le32(&ehci->usbcmd, CMD_RUN);
-
 	ret = generic_shutdown_phy(&p->phy);
 	if (ret)
 		return ret;
@@ -105,15 +101,6 @@ static int ehci_usb_remove(struct udevice *dev)
 	if (ret < 0)
 		return ret;
 
-	/* Reset controller */
-	setbits_le32(&ehci->usbcmd, CMD_RESET);
-
-	/* Wait for reset */
-	if (wait_for_bit_le32(&ehci->usbcmd, CMD_RESET, false, 30, false)) {
-		printf("Stuck on USB reset.\n");
-		return -ETIMEDOUT;
-	}
-
 	clk_release_bulk(&p->clks);
 	return 0;
 }

-- 
2.47.2

