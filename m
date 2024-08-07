Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4672C52D6F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 22:48:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1AD0889A3;
	Thu,  8 Aug 2024 00:48:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V+Qf7g8s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E3FF889BE; Thu,  8 Aug 2024 00:48:10 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19E83881E7
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 00:48:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-396e2d21812so1601945ab.2
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 15:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723070886; x=1723675686; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tqYwDwOSLx0ihxHHzrIHxU16O+SMROHfMeqCbeSYKxA=;
 b=V+Qf7g8sXpSpxKFHSa+RsaApIvv6kvFox8d4mOeKLH1NRl8sTMXjJIBi9iIpNQqj23
 w3KcR7fANbJl7h3jUqZo0kaXpY9yjVgDuufMxoCD+r0e9wyfilbBBAtZOcxLnsKpp2jO
 m4aNUGUndZxDNrO6fOIbUuta6UUSlXKxUnoug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723070886; x=1723675686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tqYwDwOSLx0ihxHHzrIHxU16O+SMROHfMeqCbeSYKxA=;
 b=ta6sW4995cft/Te7Pe4NVMCPHEsiJB53yHfiQkOLNvhnRrrbF8eiRe0IZ+LNr623NW
 BEU8BQt6Rqo8oRaKIVCdpE67TEQ4BgokuYqymvNR0Y+3j4yS8jGIwhDmrin6Eke5Eeh9
 8GLNjvkxYi/WO6mdKeP/FXXAKJpF7RILQoAMy2av5wMJqa/A1qAJGGqREj+R1IoRZJMm
 UkuvrspO6jFwmlevBXm5DXHOG4cRXr99Ac4Rq19iwmp2U/G4pohiMYrIqQPCiDYRBsRu
 oYaPqE3EAM7iduXQwJqtnzba64r5E5I4jonY2p+BTQ4VdAmI+1IYKyD/KJmuVc/drB3/
 Y3ww==
X-Gm-Message-State: AOJu0YwUaQRJT1MmFtX2+O6pvm70q0ymlHawIEAQiaAkstFNxI5dAshR
 raX16z3NsPbG/NXHRddgaztWrqrmi3Vh2S1r/mz596pufcqQqXGrm6mY8OHN5quCcldv/wNbJ3k
 =
X-Google-Smtp-Source: AGHT+IER71f+TWk7jJUqGgykVN2aGYt07GG7ZXnTKIjTcO2rU6BkJS8dEXOEM/69vXPzKFlVKKrIPQ==
X-Received: by 2002:a05:6e02:1a0e:b0:397:5d37:6205 with SMTP id
 e9e14a558f8ab-39b5ed3a513mr600395ab.28.1723070886500; 
 Wed, 07 Aug 2024 15:48:06 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20af1528sm48275205ab.80.2024.08.07.15.48.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 15:48:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>,
 Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v4 02/21] sandbox: Fix a comment in os_find_u_boot()
Date: Wed,  7 Aug 2024 16:47:20 -0600
Message-Id: <20240807224739.3858517-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807224739.3858517-1-sjg@chromium.org>
References: <20240807224739.3858517-1-sjg@chromium.org>
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

Fix a missing dot in a comment, since '..' is confusing.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---

(no changes since v1)

 arch/sandbox/cpu/os.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sandbox/cpu/os.c b/arch/sandbox/cpu/os.c
index a04eb5aa18c..da96ebe43c9 100644
--- a/arch/sandbox/cpu/os.c
+++ b/arch/sandbox/cpu/os.c
@@ -964,7 +964,7 @@ int os_find_u_boot(char *fname, int maxlen, bool use_img,
 	p = strstr(fname, subdir);
 	if (p) {
 		if (*next_prefix)
-			/* e.g. ".../tpl/u-boot-spl"  to "../spl/u-boot-spl" */
+			/* e.g. ".../tpl/u-boot-spl"  to ".../spl/u-boot-spl" */
 			memcpy(p + 1, next_prefix, strlen(next_prefix));
 		else
 			/* e.g. ".../spl/u-boot" to ".../u-boot" */
-- 
2.34.1

