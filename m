Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD4FC3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 12:34:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D22A981F59;
	Mon, 31 Mar 2025 14:32:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oC3RDTlO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34DEE81703; Mon, 31 Mar 2025 14:31:59 +0200 (CEST)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9C9282047
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 14:31:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x443.google.com with SMTP id
 ffacd0b85a97d-399737f4fa4so2151486f8f.0
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 05:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743424316; x=1744029116; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iz+pWSRan5RcbHuOAmgsyvPmB2L2wa+fNWwBN2HgjWU=;
 b=oC3RDTlOsQx5CDiSonf6Xg4x2cIL0Ip5LLVLQjAnudBWdfCQuc2NB6IV+f9apT2si2
 mf1n4qZGE8fjUoLMYWalABiRFfAZyCQ0bWbzyR47Mdo6hgtFHL4s92kiOumgl19CmeW9
 50H/9KWS7v4AIe80pvi+LFjXEUnvhwhtl9tZH1AzL6p+UfbQDi2oXxfhIwbhZV6i1oys
 b196AKyWxQOVGSklxF0YNBE3PGNUyH5GXrCpFVRXrNxDLW48txuSDA63/+Cp5yJo8P7Z
 xFOm3zX6FImxoZoUpn+pMRDQpLQQY1VEstTap5nhjy4sa35Z7ONOXCPZy2k++tU/mCqM
 wvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743424316; x=1744029116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Iz+pWSRan5RcbHuOAmgsyvPmB2L2wa+fNWwBN2HgjWU=;
 b=DkT0L+n50jzznjhTw3CzlXRGpvDCHdYdxsjQCGWHuKPfwaRymBh7HB5BYzcuVyVRKJ
 X6IjN1OcJXNKSlWKv/+AWU8HZU5UF+rCBtRIlho8RxHZkRbN7hMk6AFHhYOp2dnRa397
 uKzWWrXvzQ84QTHC6yQu7jyCDnDyz5KvXj/P/6R1rXjDMbenOpomeO9xtFGUgEX/SkPZ
 mtI+kDWviEqet0nH9chxvVivxTm7YJ7PVPPih5jSGZpgjMfkFC0sPpdPmhANIuU4ewIS
 UonaSmEf9JrFmagfUnZrCpEJ4RUxdrdinWHpszOVFwPrHHpCHr7QC4hOBWArajmiXvAa
 cUoQ==
X-Gm-Message-State: AOJu0Yxoesp/2wvJqy8ZmqP4HuUN3TAnsN0s58e1G4bSEdevMONZHEFs
 AAbE/Pb3BkdVnXK4uC9h5CVFQnhS7SjIYUM64TFp7II7zJ+VYZtBm4uFztHfo1lSNkM1T5Ejpl3
 xzgLfxyTf
X-Gm-Gg: ASbGnculS88GwobkUcXGkvdyXN6BYJhnI/EQaJP8RvjnzCurw8e3NDksAoVYjj0ikyM
 5K/CcpqWzvpWOgaV79pFVGH7x/fV6G1k8qtWDzmsD45TxYPP3d2W6JnaB1awY9rjjho+6MTP+sX
 8vrJNvuEdqEskg4gr59PLnFOA93XRy9nYFctp/mDSTokCLA/C3c78AzGr+AAx9d70pwPYxNQUU1
 L0NOpp+BVxO9FIcQSrPU1Wo2D1Mileq0V+S0m3uQR/ZfYj8Xj0VyT40jCDnZvRnCWub8IoK8LPp
 FTlswZO9oJO7l452LIUx+iJ901xQmmYUxPjjX391GNG5Jr5n0niC
X-Google-Smtp-Source: AGHT+IESDASZTP5ptD15HPYja0uQTWV8gQlakW8XxD/o4M1v5RzzHaoXDCvZSJGBaXEi3mGNASqMcg==
X-Received: by 2002:a5d:47a7:0:b0:391:487f:280b with SMTP id
 ffacd0b85a97d-39c120cb53amr7228862f8f.10.1743424316108; 
 Mon, 31 Mar 2025 05:31:56 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:f23c:25c9:dc74:be1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b6589e4sm11337029f8f.10.2025.03.31.05.31.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 05:31:55 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Greg Malysa <malysagreg@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Simon Glass <sjg@chromium.org>, Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Robert Marko <robert.marko@sartura.hr>, Sumit Garg <sumit.garg@kernel.org>
Subject: [PATCH v5 16/16] MAINTAINERS: add UTHREAD
Date: Mon, 31 Mar 2025 14:31:10 +0200
Message-ID: <20250331123120.2025062-17-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331123120.2025062-1-jerome.forissier@linaro.org>
References: <20250331123120.2025062-1-jerome.forissier@linaro.org>
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

Add myself as the maintainer for the UTHREAD framework, the spawn/wait
commands and the associated tests.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 92d4a158fd0..4b6bb7dfcd7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1817,6 +1817,15 @@ T:	git https://source.denx.de/u-boot/custodians/u-boot-usb.git topic-xhci
 F:	drivers/usb/host/xhci*
 F:	include/usb/xhci.h
 
+UTHREAD
+M:	Jerome Forissier <jerome.forissier@linaro.org>
+S:	Maintained
+F:	lib/uthread.c
+F:	include/uthread.h
+F:	test/lib/uthread.c
+F:	cmd/spawn.c
+F:	test/cmd/spawn.c
+
 UUID testing
 M:	Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
 S:	Maintained
-- 
2.43.0

