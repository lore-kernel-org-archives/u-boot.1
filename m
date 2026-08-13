Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACAF3C5CFCF
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 16:22:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 621F64086A;
	Thu, 13 Aug 2026 16:22:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OPsC0zJ28dgo; Thu, 13 Aug 2026 16:22:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 230BA407DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786638131;
	bh=zKuE7y9zBWyTl9wVZ29rw1R1FyGIXEcc8+uX7XjkfG0=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=W1C1M/QJeDqad1UXWO7YVkZS0MGXoCO+mAfJ7Sdhbhxd9+Q4o6kgEjruCmpqf2ok5
	 OKJjACrQXNPcknxZM+MewmnGd4TIAAszpkHkg6i+BmKXUrYHbrm246wHIIER9w89FF
	 0tnvUUI2qEueF1U7TbeGyghj1JfFC1zHlvHN15UIsGfnlgR8y91wxG8wn8h9kC+f7/
	 V7v4TTFNQ7xIuLtv0ydJsEswERgDAevSphwRTudMLRIYAzDp+3RI5iiYIbQHNuGq/Y
	 LAQvsE2YZUSFayUlObij7eIfe6PiaWgiecP+vsqdv5KEV7FNrDRlimedaxQrSRD3uZ
	 zdGM1ncF/agaQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 230BA407DA;
	Thu, 13 Aug 2026 16:22:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 067C8259
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:22:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ECE8940418
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:22:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ryjj_g7noZzE for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 16:22:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::31; helo=mail-oa1-x31.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A118440168
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A118440168
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A118440168
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:22:05 +0000 (UTC)
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-455ee8f529dso14889fac.1
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 09:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786638124; x=1787242924;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zKuE7y9zBWyTl9wVZ29rw1R1FyGIXEcc8+uX7XjkfG0=;
 b=AHCh2S0PhIkH+2yDEgyYaXG/VnD+caua076W2ssNu2Y5k37okbyRzL5w4n6QTZU/ZI
 M3Tlbw5lgVAmdCEXVCUAlyvLxkNu86O6GwQdRjrL4dpUPPB8TUsTeIa/MizU9dTdrxGa
 a/q2qn6AkaOt95WpMcB6xGNeChIfE6wE+cOTQYYSISIVsB6DV/gjZDxBnyG2j8pMeh1R
 CHnvdfVaIinIwrJK/qTZpDZmqxr9rURJU4JUgbq/9xFE3/C3DYdwok7LdEv7T5aVcF4c
 EGqrduffJgcR5u8i/IyvwGiJjPSpAXt8YQYo+yvsQ+dnZjuoImIXb/g6bRskr8jw299p
 QkWg==
X-Gm-Message-State: AOJu0YzZEmmRonrCxaaMO/UWGdEueqsSddn1MlVCnhvQJHCMC5WsxYrm
 kTzveoAB7sEfM6ElZovVBTm5DUZuq2uFVWZB6ZrcSYr4TBtpnWq3QBM8bPwOOoeI/NU=
X-Gm-Gg: AR+sD11KWOSI6CEOtqHPgls9tN8xiGUTEFrWn2e8O4XFo76nLqAcS5Aese8tCd6MdL4
 JbMYDOGLcWpfJ/g/e53rfwIGeQe4C/A8lpCxl/4qSDObkvOszl6mFrR33uqdmi7n/XgiaXojR5N
 szXnqOhb8j7y/FwJtu/u5kSHWpktnG7fLBOXbAlxUh2eRsIWthbe9/oPc2gRmmop5pFNOMV6nnS
 Q/ZiGpeCw1fz2TQl28KC1xzEmEcvE3XfK/NqBd5Wa2+0nJExZ1sAWwDvsO6nrdEokbOvc2+3Srb
 7hnDVy4Hz5WvB6SUSE1pNw3fVabJqYYDsCCCdkCswmpY77snasSsspsKYBnZvArHelfYOD75ZeX
 ttVWgmSCKmWbfTOVElsMreLS7gY99RzF3Mz9VfyywuPTJfEa0hXcc11nJe1nz8GtKQll/YSLeB8
 FnPMWDpdUm4Y/3AbII/EB7Q0bsY6PojDn6liJbrKqwjb6MH6/LlvFQWa23AnyrYOT5
X-Received: by 2002:a05:6820:c8c:b0:6ae:47e0:be20 with SMTP id
 006d021491bc7-6b0c4194e3emr6412205eaf.7.1786638124431; 
 Thu, 13 Aug 2026 09:22:04 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:3678:ac91:e955:c25])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-45e64f8ebcesm1967704fac.7.2026.08.13.09.22.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 09:22:03 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 13 Aug 2026 11:21:52 -0500
Subject: [PATCH] arm: dts: mediatek: remove mt8188 tphy fallback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-mtk-mt8188-drop-tphy-compat-v1-1-9e28ce95ed75@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2OQQ6CMBREr0K6tpGCQOEqhsXv7weqgWJbDIZwd
 4u4mMVLJm9mY56cIc+aZGOO3sYbO0UQl4ThAFNP3OjILEuzMpUi52N4xkghJdfOzjzMw4ejHWc
 IXAFCV1c5UJ2xaJgddWb92e/tyX5RD8JwKP8NR68lzoazxqIHhzjaJFoLoEIDoSp0pfJOg5JlI
 TAXqpCobnUlNHbl4VHg6XgxmtAk1pneTNeJ1sDaff8CvZ/Ob+QAAAA=
X-Change-ID: 20260813-mtk-mt8188-drop-tphy-compat-bacaf973ae92
To: Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1268; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=EpTdPnWoAO0lHjrX/t9npTUXTOze1autD3rnLJ8tumY=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqfe8hnGZYNATAI4KrcofX63EGw2EVdNVO80Zv+
 T7I6SXs9geJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCan3vIRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AwzYH/jnxeHhxVXbdDjWDDWf5uN4zkN+dTbkW97Nyagd
 y2rXigfhuYuStCdF6NrzOJOPvtgV6ZJafaAtS04zbX71pc67nrc88VMQa0NfqTnkx5t+ttqiKal
 654omGeSbcbUvLggyASiPJRFzyCjU97gj+b61wFs4H3QOdOfd+KokbMa5bm3imGc+OQjmHbZ3eO
 V77wqeRyqIjyTYFBp99ltB9JASCUktFW+WD25pQg0prqNcFbmUty5c3eexVCNbzmqM7XWDh7Kws
 9RpB1jrZMtA7ODyoQyxfEggoqmOWw/NNwc3LjaplBgPgbYN27pkX1rfnMNZmKc0tKr3Vm0RhBBS
 5HiU=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786638124; x=1787242924;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zKuE7y9zBWyTl9wVZ29rw1R1FyGIXEcc8+uX7XjkfG0=;
 b=WtjwTZVPbY/IZ9VNytZ8IdTpFciFIRxkDWH8j/14RypbfZLbBiYcWDUoV3Z/a6blas
 mM0cuFLj3J+KDYUSTFtVsfT8R1pmyRkSOWjyeP0skZIbD8+WoDkqLB6tIgBUjG8dik1d
 6vX6QCsi3zU5DPiLaBzsM2PaYEpZGRXZf4x3QURESEjV8GpzkuUkpNxhjtygwJ0UK8C/
 sKP/WsZxJwX9wSPUMWtd1TqWy8vx8zcJBZCvVfCnDyV0Gv8H7pCwJ/xjfsyaZiu8CZZQ
 wzcCPFVXh9F8D3hDQrGUOiKeVL8JOM1y77Fcg8KdHpDtOq8qmAJO1EOM5d1WYEMY7F0U
 T/dA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=WtjwTZVP
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Now that tphy-v3 support is added to the corresponding U-Boot driver, we
no longer need the hack to fall back to tphy-v2 for mt8188.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
This depends on [1] and will likely conflict with other patches we have
out on the mailing list. We'll see what lands first and fix the
conflicts as needed.

[1]: https://lore.kernel.org/all/20260805-mtk-tphy-v3-v1-1-f1d6268b8d89@baylibre.com/
---
 arch/arm/dts/mt8188-u-boot.dtsi | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/dts/mt8188-u-boot.dtsi b/arch/arm/dts/mt8188-u-boot.dtsi
deleted file mode 100644
index 6d1b2ab82da..00000000000
--- a/arch/arm/dts/mt8188-u-boot.dtsi
+++ /dev/null
@@ -1,10 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
-/*
- * Copyright (c) 2025 Baylibre SAS.
- * Author: Julien Masson <jmasson@baylibre.com>
- */
-
-&u3phy0 {
-	compatible = "mediatek,mt8188-tphy", "mediatek,generic-tphy-v3",
-		     "mediatek,generic-tphy-v2";
-};

---
base-commit: 5a92645e1f9020d24d19e03fff2ae63f30080770
change-id: 20260813-mtk-mt8188-drop-tphy-compat-bacaf973ae92
prerequisite-patch-id: dd1ae5daecb5d7b3fdab8651c31b58cb4971dcf6

Best regards,
--  
David Lechner <dlechner@baylibre.com>

