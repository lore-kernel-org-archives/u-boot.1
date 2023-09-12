Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 624E2CA0EC3
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 06:22:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAD3586E59;
	Tue, 12 Sep 2023 08:21:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mejUuZI2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4D6B86E56; Tue, 12 Sep 2023 08:21:39 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C47D86CD9
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 08:21:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1c3c4eafe95so2648265ad.1
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 23:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694499695; x=1695104495; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vhAR65M4soRG9S95MgJJZMHxp3xYHMV9h+mVgJ4WbmE=;
 b=mejUuZI2uwT/ajy3aHKIdGis6e6raodm9eQzyXBpd0aHdpMDc4xELEYOjw0/anwe1S
 6fv3RrCiBzzWdPl+Bj/ZldEtfCLqraBgwRkDRUezJl2niUrbzXDY2t/aToiun4p/pZ4V
 0mDenjny37HLwnsNtunwGteKXmGHByYMxGEz/s6EVEf3lJi9REkas4/dkqB3xZ7WStDZ
 0yDtu/2YzM699J6I2XDp8KzxTmX8S1hKszHU+YKVK0n796BD2ts7PEZiv/LM2bZUKQN+
 RNu8tSMAHd0V9nEHhEdlV79n1iDvohsQ8aea+noPBKLuSr1yuFdmo3MbjUrSXLYF+9fS
 xyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694499695; x=1695104495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vhAR65M4soRG9S95MgJJZMHxp3xYHMV9h+mVgJ4WbmE=;
 b=qEwy4/trr7MMuy9+zWAHTg0f89giLgDlpXyMqfKkVhzd1rKXXOaTvhS7DbAVwayO3V
 J6A34IgxPZ7gNKAjKUAYmPTnXPE/33l4tShf9/UK/u0DF9o+EXcicRl2KL+iXoY4y2ME
 8fOHsI7N17fo+zBCayawRrukkYxhtdM52ceylIRCMlju6xpljjR0wbRcEC1rXZ/oiZhH
 ZxvfmDt0AU8ZbOh/5k6gNMIcF/7tBCba+pMb1CaAliP/JbUu9kWkkmIZ0/Nlpnict1ec
 FLjZ4UQXqPIZpmTaojrNMDTjW1MtAOe1yMIMHYTSmnbMtGuIHCdVjotD+p0GxD0WmMX9
 kIdg==
X-Gm-Message-State: AOJu0Ywi7zKeFe9eEjCdszZ0hZqVttxcgE3EFcmT2an8RcKbYiCOSt0r
 9gLefjshP51qpzuQhIzzRo/ZHg==
X-Google-Smtp-Source: AGHT+IEHH8tcXMmQ+JHst2Ij5uF55VBy+OtsqRXhXjeoQTkU6p3JbXeyNGDO+07FxzIKTTwT4MFofg==
X-Received: by 2002:a17:903:2843:b0:1c3:a4f2:7cc1 with SMTP id
 kq3-20020a170903284300b001c3a4f27cc1mr7883061plb.5.1694499695374; 
 Mon, 11 Sep 2023 23:21:35 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:bf3d:658b:e9f7:3af5])
 by smtp.gmail.com with ESMTPSA id
 a15-20020a170902eccf00b001bc2831e1a8sm7503970plh.80.2023.09.11.23.21.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 23:21:35 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v4 09/13] sandbox: remove SCMI base node definition from
 test.dts
Date: Tue, 12 Sep 2023 15:19:58 +0900
Message-Id: <20230912062002.57361-10-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912062002.57361-1-takahiro.akashi@linaro.org>
References: <20230912062002.57361-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

SCMI base protocol is mandatory and doesn't need to be listed in a device
tree.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>
---
 arch/sandbox/dts/test.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index f351d5cb84b0..dc0bfdfb6e4b 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -693,10 +693,6 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			protocol@10 {
-				reg = <0x10>;
-			};
-
 			clk_scmi: protocol@14 {
 				reg = <0x14>;
 				#clock-cells = <1>;
-- 
2.34.1

