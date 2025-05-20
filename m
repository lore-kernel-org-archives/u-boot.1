Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A7FC3ABDA
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 05:22:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FD1782C38;
	Tue, 20 May 2025 07:22:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rBNkEozn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10CB482C30; Tue, 20 May 2025 07:22:12 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EFA782BD7
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 07:22:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a0ac853894so4495230f8f.3
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 22:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747718529; x=1748323329; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JsINoPKzYyO319retZqnRO2Ca2xaXXbDc9IMIr2DgW8=;
 b=rBNkEoznB5760cYFv+HU15bkS8gVUGY7MUY/94DiI9+TcA/YDWOrbBFaStC4uvibGS
 6xXTmyIy18v4eEoiE3RZnLW9lDGrgdq7eViXc92hIEbr+Wpq/cjI7cBr96eXH+CLN8ms
 yrDiV4CWP54FfYOfzTBAFgPq8C1RLL1rvCLDydQi4QPV0zxo6SPTf6uxSBlT91IbTV9P
 bRyoMOVNT9WVRc4u3VlOfFV33WSIwQF4Dru07sIO/WXO0BvxpOdwcL1XQhnP6y0xsaqW
 t007doCiC4vx5x5iswlrvqEzXxeqiQmaAipdTiyTod4gK2iV1DUhRIRVAYVs1ahtV8fV
 tBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747718529; x=1748323329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JsINoPKzYyO319retZqnRO2Ca2xaXXbDc9IMIr2DgW8=;
 b=kHb0qbrNWapeJvstlapMnq8bNEmNGEDWmxhMehL6494lMGVQP2A8QlqFrNThTgVFUd
 +6Yvdnh0qxbzSYG4vwi6IcC3Wdjin6nC8kXlqskq2H1BnNM4AxQSBCGeI1VfRVlxv6bf
 ee2T0VauOso6R2AR5CXGRBJKgZEmIqNRXDOQF9b1KRwvMW1og2UO5gS1P/AyDRHT6hFw
 jIRn2tvtcBniMLcrrXoFowAfysYcq4RUjB1ah/09UqvWo50lucHidBF7T5tPb7kf08xC
 Sfgy+pufvdbFo1Og8XiR7pYVF4uaRLSolj4GwXQw4ipNyqHgOo9Aew3JoCR0ae/oGd/c
 Leig==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTYXYXUlNXBf2WcL8l1W8fFaGOdSb92YZfpxT5TqsRyrqWZdrHVW4kpUH9adzHSqL9YrfcIcg=@lists.denx.de
X-Gm-Message-State: AOJu0YzZKk43PrGF29jmpP+nST9x+VfweZdli8mN3FUAfDPEFJ5unpre
 fOFQciecK48o8tzMu7WImZFG3qWosZB/9+qUnb9E1Jtw1foDE4nRRDv30awFEWXmiC4=
X-Gm-Gg: ASbGncvJVBvHE5ay9jaTYYGFCgxMubViM0xDIEI6y563RjJR7Yft5NZzrZ6+szkbe88
 DevqBwYEvhnWdGKxQLM8nk17pZhdhqcKpI3P827pBPjonN8a5MXR/tmP+lCFmDCkpkMxvv4ssKG
 uQNBlj6vm7Rb/W08WPLeGgupL0zf+BAladJ+FfmiL2+tK82d66qTRMlsHzAyDoyq3bTrCb2+7LF
 VqKaHcRYNxRFtSk+eLb27jPUcCtrNETnXuh2EwZgUWRNRVa2F58anXshAk1VZRRKuAgD3f216hM
 sygBBhvEMGZcWlqCKLSNEOS+J13yjx40ARrZ7hNNukaCX/1keWfmLrvPaAQx2YanE3tVgeYK52c
 =
X-Google-Smtp-Source: AGHT+IHxq23qfu7wTDzm9ZDQBeVRFVCmIXukFt6bX0WHMW+dzyvSbp/6FOM4AcvAm+8yjiZRCA5FeQ==
X-Received: by 2002:a05:6000:4304:b0:3a3:6ae4:6615 with SMTP id
 ffacd0b85a97d-3a36ae46750mr5772110f8f.13.1747718529552; 
 Mon, 19 May 2025 22:22:09 -0700 (PDT)
Received: from localhost.localdomain ([46.198.180.244])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca889e6sm15100762f8f.71.2025.05.19.22.22.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 22:22:09 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Michal Simek <michal.simek@amd.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sam Edwards <cfsworks@gmail.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Subject: [PATCH 04/24] kbuild: remove redundant 'set -e' from filechk_offsets
Date: Tue, 20 May 2025 08:21:15 +0300
Message-ID: <20250520052153.307194-5-ilias.apalodimas@linaro.org>
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

commit f3fd4a3f3a38 ("kbuild: remove redundant 'set -e' from filechk_offsets")

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 scripts/Makefile.lib | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index c3c6c941bef4..a2b3b2e63872 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -718,7 +718,7 @@ endef
 # Use filechk to avoid rebuilds when a header changes, but the resulting file
 # does not
 define filechk_offsets
-	(set -e; \
+	( \
 	 echo "#ifndef $2"; \
 	 echo "#define $2"; \
 	 echo "/*"; \
-- 
2.49.0

