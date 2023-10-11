Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC830CD6E56
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 10:12:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0CE586E0B;
	Wed, 11 Oct 2023 12:08:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="s07xYLfu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6700286DF2; Wed, 11 Oct 2023 12:08:09 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9999B86D85
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 12:07:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-57c0775d4fcso790187eaf.0
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 03:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697018871; x=1697623671; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5fJTch9PB9zkacUWjbf2mgcKlFFPGY+OkV/KT1STzU0=;
 b=s07xYLfu52l4MW8FMKr+h5t/DIzRtVOBw+yPm74IcFxEfQp742s+yXYyW/s36OTXeJ
 np2cm5kzvEiDnPlKVl2HdFXgJ4HfpFUAlH/1gilpGaPuyzvwn5tViSbwGuucU6vlQzsZ
 Ne4bz1+oRU7qNcZRsM8sJjGRsH8Oz4O50uxmRKMB/G+yJYiWVu8OwFWN6M2i9BaciNSY
 4SEQvoRqoZt+UzEI0kKzLGEAfbC/qFjR0w7F1CQiasHkbs6DlbmylmopG0I8KjCx9R/1
 wbWknxc8qUt+ZdR2/uL+cgS8Tj9ia3bkJBU7jN7UBqjE8KWJMBhCYKyJAvGVuQJaIKB5
 R83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697018871; x=1697623671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5fJTch9PB9zkacUWjbf2mgcKlFFPGY+OkV/KT1STzU0=;
 b=gDHJvCrH7NLJZaXLrrRanvlLwmVCjXQaeej4iBCoTJW9Y5aQt9pmbSc0IPhsFneRwC
 owhqfrpWINgsRge6EjxkR5/JrNYxksaMFleh22MvbGsV6NAA9fJX8FLWl4oSv21shFcR
 /v4dxqKsu7AO97qPZ7DmIpPpk7aDeLKUbF1ud2SQWnYk4wUQBtd/vPxUFI2H6T1Zsx0L
 sUitDej1rMOZJ/0YpBmJOdmiEcfCtrOsLLbfFltVhRWgfbswZ//vwmbL6parQbHJi4LC
 vAXMA4VVUqYmZdBrldG47So9LK1mxH+1VUywoKOEE4GRD4ZRd0oF3JcIvusDlbWn5NGh
 vaxQ==
X-Gm-Message-State: AOJu0YyegDAN8lhZTJztJ/f9FoFW0gVkQukYJgJOf6RMJrSKdzbVItSq
 p68P1SijkEG+0Fx/t6HpAfKXoo5mU2XxZEi3KDn6tA==
X-Google-Smtp-Source: AGHT+IGdtjZPB7khO+gdp9X8bQAC2JTZvx8t+zTkSyQKfBRW8ZhZ4lmgx6DVxXCzn73JtHFjxUJG2g==
X-Received: by 2002:a05:6358:f17:b0:14d:8792:1cec with SMTP id
 b23-20020a0563580f1700b0014d87921cecmr13236828rwj.1.1697018871022; 
 Wed, 11 Oct 2023 03:07:51 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:5c6c:b11a:476c:8ebb])
 by smtp.gmail.com with ESMTPSA id
 e4-20020a62ee04000000b006889664aa6csm9663358pfi.5.2023.10.11.03.07.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 03:07:50 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v6 12/14] sandbox: remove SCMI base node definition from
 test.dts
Date: Wed, 11 Oct 2023 19:07:05 +0900
Message-Id: <20231011100707.1007417-13-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231011100707.1007417-1-takahiro.akashi@linaro.org>
References: <20231011100707.1007417-1-takahiro.akashi@linaro.org>
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
index 73224e385b8a..a335445b984b 100644
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

