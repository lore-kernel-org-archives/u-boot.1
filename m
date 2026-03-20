Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2429F1099B37
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 20:56:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C1058412A;
	Fri, 20 Mar 2026 21:54:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DFyWgkQ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF2B684105; Fri, 20 Mar 2026 21:53:56 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9924D84082
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 21:53:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4670bcc40d7so804339b6e.2
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 13:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774040031; x=1774644831; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=+9p81hGak2mH9+hBu6UFoaEFp5ZU1H8djCNpHY/XSiM=;
 b=DFyWgkQ3LLCGI1PlQH5djWwkcacgP6V6uzfGpKLSiI2ffcC1l5jHgjnuI4vMgzTjWS
 2TlJn15RGuVOK+beYRvNiJcMxrpdbQSoMThYevmtCgqvgOJFjmzM6aF5Mi57BNth4Sou
 3E+QIxwgk4426fMFVcpKzCTHYCIwAa7LP6+5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774040031; x=1774644831;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+9p81hGak2mH9+hBu6UFoaEFp5ZU1H8djCNpHY/XSiM=;
 b=ssXNKMjZu3AgoLWCeGI6Ew2g+hcltSLJsJEB5iBqpCMDQE44kbOkSMaI83ssvqGCUx
 olQbxenAf8qRl2VLBUA1+C6OeOuHsQTxRq9Tfv/u5Rq4enP/a9wSoxiwGdwXuTdPArbR
 t4hRFg+LV04uKLpTa6H2Q+aUSAvpgduK6sPvpwZ2NUAhu1q7IbzR6VnH/2wjX1xfLEwb
 a+iy3yol+vP5o/HE5HAnbXANfFndIVnipVzzqbZOacyZ64tTt9K8Jcq2c6tVI0L+28ef
 XhuqSTYa0v7VmeECh6ig05DcElab3YYrHGwCoPspOlyuazxBuzBKf377n7KxdyEB+d2n
 9D4A==
X-Gm-Message-State: AOJu0YzgKyEksbjsHXc0SAH8zd76NjpgISU3HuE8AVQa3xtj2rjaEI7b
 L1dx3qeHWeCn3OzGTwANe6HthSNWN+viF/FgmTG99qJk344iEXUTfPzNew8J/pvmgYZPimggqSM
 Os2dbXo4=
X-Gm-Gg: ATEYQzyN9XWcK66/0amNri+HP6J619kV2Wd8CDYQezUyCsxd1yzzfNxEc8P7ND32nuq
 SJAItmSH91nThp9BJ8Nso9nTH+gxoxYuFvC0UtBm5DY6ZzaMybch1j/pMWn8vHkHdK1bSeJ1XAK
 ypGDkJ+XlzAKPi0W1XBD4TkjB2V1iPA4Gc2L+dJmPJpvkMu8iQrr6BVxtUuoS79NKog9toEj/cx
 2eTlpYcHIDWPQUgDXU8TOBns16DLF3ZCJYY97xE7r+zcJgT2riWWQunxHmfujgtwQcBQNs67P1Q
 sAzz+/6JW8Uookye1u6yo90G5T/flooWuDo8qHysFTm7sayBobm9+pn29NxDAm0aAbq/O8cQIzp
 k9vx5887/RpHjDrm4j+jvqDjoAjzNjTEerLBLwEfqMXY425FTep89CwDg9lWWiqUNqRsuhD9WS3
 dZTWSaROxgTlN8wwJJbKo6lUNPprqaMscBe++NjxNJSCuN4gUU6wR5KC0rWEIwYhmhjS/j8KkHU
 mIFvJfZlsRDmK9HsGg90XUMuDm24fzlCQ0yKnOgc3Apd6awP1A=
X-Received: by 2002:a05:6808:1392:b0:467:255a:7453 with SMTP id
 5614622812f47-467e5d9638fmr2378936b6e.14.1774040031245; 
 Fri, 20 Mar 2026 13:53:51 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41c1497485esm3192441fac.8.2026.03.20.13.53.50
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 13:53:50 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] misc: Add missing dependency to CROS_EC_SANDBOX
Date: Fri, 20 Mar 2026 14:53:49 -0600
Message-ID: <20260320205349.3789093-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

In order to build CROS_EC_SANDBOX we must also have the hashing API
enabled, add that as a dependency.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/misc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index b2dfc7f5b663..ea785793d18b 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -257,7 +257,7 @@ config VPL_CROS_EC_LPC
 
 config CROS_EC_SANDBOX
 	bool "Enable Chrome OS EC sandbox driver"
-	depends on CROS_EC && SANDBOX
+	depends on CROS_EC && SANDBOX && HASH
 	help
 	  Enable a sandbox emulation of the Chrome OS EC. This supports
 	  keyboard (use the -l flag to enable the LCD), verified boot context,
-- 
2.43.0

