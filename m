Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29582C3ABDA
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 05:22:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5703282C0C;
	Tue, 20 May 2025 07:22:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="p8MgiHDM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AB9882BF2; Tue, 20 May 2025 07:22:09 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A43A182BD7
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 07:22:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-442f4a3a4d6so33159265e9.0
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 22:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747718527; x=1748323327; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ivTMYryFiugSVHlDJyBnwzVVzOeu9ckLXmKQbnYxhmY=;
 b=p8MgiHDM21qjvVCRTvOTDYMKAAXuxiFIogHz9B5ejr32mdNJql1pv1p0NQUzjEJ341
 UaEqArqhBpw3vzOkozhwLCSs6/cSI+jmgNxlDZLL35KPkJ3l7DSXbb/sVrP+hl6Kkg9U
 /trWBgZVFrCIuAxXkGmmqGJ3hLT+aM3VPsGFEwHHKLWaS/ihHXvwbAX0ib63Eltq8mNJ
 GzubfdpSn30euDUW6J7VV4/YxYEbe+lLoOpRDcKY7uUhinLBe4fh9oEgOHEBz7KeZHM8
 v4PE+fXgft6XxSxowg63Ms9tx3BNuE21S8F/LOWZL+84ItZ8fRKVMgDdj29kmkIo8uSy
 hROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747718527; x=1748323327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ivTMYryFiugSVHlDJyBnwzVVzOeu9ckLXmKQbnYxhmY=;
 b=XHo/+iPw0kIUgc+Q/JGgqrVon+Lxfz48yJiYjauu8IMieakVcWxupJZFWTmDNIIH0P
 jJcxrLtwt2S/UWeNvvat/At3Q6BfTiZtwIIBilP27dWOJrE5oqXAyXc/HjD9+lXL2Yqp
 eAQKU6KfNE7kE56EOBly0ip4/m0Jpoy925mRMMl+3gYw7RkN4eIL+1BfVv1GkXU8AXPE
 IWSMWjmtZmXSGbj904W66/LyQcl6DDkORSZHymdvqlDX4UXtSr6lFzPIL8xJlUoFo+Bf
 lBNO2pBF5PgA1ZAMqVkN40OuFPblT20yeWLoCypIBAfVFtXivqXojfb7B7qVoo21kYt2
 y+Cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWffcYJR00t5SGQK5ChqmUG/NQZkId9gpXz85CDazVQOzQeke7znL0mZ/pIPbF7nZU6ZD9V1YA=@lists.denx.de
X-Gm-Message-State: AOJu0YynmFhc/OYIw+XM2QD+870btsrZKJtgKQ6O45A2Ysi3x32AlvST
 WhY9rboBcHViwhJaHeQlZIXHlcwIwP+x0YWlKZ793OUGGAjJl3xymmUC0mMIrYW1cHg=
X-Gm-Gg: ASbGncvV0smGJqnts3aqx9sEQXFJMQate0QbRxz9kjvbYyIVAkbcYoxrb2flPVAKO7W
 m6nktHbAcmaWmAeVSaTU9TzXFuKCUhYmyKSJ2kNNcXVQSZS4fcn/uy+7RSALMUfwvEvk4PmrwI4
 rHRcDjhe0pLUlrqcoUD+Bo3qffZdhE1A81d2Q2uFVyxqPPJBIrHXiVyu2PeMyoGi2PRXNy3ZLtW
 QYFKMhG1VX16+oI7S+tf5tPbn+X6RdzTZNYzQ5dzEux5YQiHYEbQpmMvLT9onyo9uMzK1359pQp
 2m5EvuUfOTG3OYyiWmbysr8q04MKzXASkIWZF7/W7EwcEVQUIoqJhfpDtsB6H6lPC9XRv8/32Bm
 Q6UeHksJt+g==
X-Google-Smtp-Source: AGHT+IGGRfZ9MDaVR2t/AyHMvT0q0UU6iC+/noshTIP+wWZE6zYES9MvxmYJ4ToDtwdwu3Zr+FoU1A==
X-Received: by 2002:a05:600d:19:b0:442:7c40:fda4 with SMTP id
 5b1f17b1804b1-442f84c209dmr165502775e9.1.1747718527113; 
 Mon, 19 May 2025 22:22:07 -0700 (PDT)
Received: from localhost.localdomain ([46.198.180.244])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca889e6sm15100762f8f.71.2025.05.19.22.22.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 22:22:06 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sam Edwards <cfsworks@gmail.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Subject: [PATCH 03/24] kbuild: Enable dtc graph_port warning by default
Date: Tue, 20 May 2025 08:21:14 +0300
Message-ID: <20250520052153.307194-4-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520052153.307194-1-ilias.apalodimas@linaro.org>
References: <20250520052153.307194-1-ilias.apalodimas@linaro.org>
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

Backport changes from the kernel
commit a2237fec1e06 ("kbuild: Enable dtc graph_port warning by default")

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 scripts/Makefile.lib | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 2422ac980a46..c3c6c941bef4 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -301,7 +301,6 @@ DTC_FLAGS += -Wno-unit_address_vs_reg \
 	-Wno-avoid_unnecessary_addr_size \
 	-Wno-alias_paths \
 	-Wno-graph_child_address \
-	-Wno-graph_port \
 	-Wno-simple_bus_reg \
 	-Wno-unique_unit_address \
 	-Wno-simple_bus_reg \
-- 
2.49.0

