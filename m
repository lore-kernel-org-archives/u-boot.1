Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109A4CD6E68
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 07:38:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED00684915;
	Thu,  4 Jun 2026 09:37:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bwm2oeBW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 822A384911; Thu,  4 Jun 2026 09:37:50 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A564C84908
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 09:37:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-490a765d410so4048355e9.1
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 00:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780558668; x=1781163468; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w1pPiJxYSBR7uOhsrOEauZ6bnsK/ZKpZyZak9BiCiiw=;
 b=bwm2oeBWSWQWdgNERDcRQ9VSogzQ6whMBg5DxxnmTsFArJ2bpi/E6XH6tq/j6uQu02
 SeqlCkD3NhHOUU94vAZmAZkHO53ihj2Idq2lImUqULI4U8fltd/t2PoKZJr0lonRGmUM
 YiyZrM6KmUQU81We6qK/2HBG3HQoFpOZaYpxZboWbYsZY/Ak/AHqCuIiOrDPmVckxtXn
 p79ezFo/Nc1BgnUPu6hfNe+6xljbQHbPFmWdNz6Gv8avChW2Nl2gv0qLFiLtOetYT23H
 XU3AfHbPnb1JtpdN44/nggjSiibXxV7hcOI3acdFjN/6Ujn2JTUQksh+tWKlPuLlxZtm
 xL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780558668; x=1781163468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w1pPiJxYSBR7uOhsrOEauZ6bnsK/ZKpZyZak9BiCiiw=;
 b=dS9T50wl2X1TPp8HG46NfsCmqbJiRgtWifcIyeBHbDALhDHikmHGcADdOb7YlKd9Vy
 4+AC9poeNPSSF4zIYxVcNeyFNHtkEjBf0gHZ5PLC8XvGWGzMEN+G5MKMibVPIRsyiFvp
 Jomtiqov0Ptcbg21r1nPdI5Xfa+6YPjrM3vCruWQjEZEJt70E7NRX9W8DQvvKNUHA/WY
 340V2RNOwMgy1zXmO5wLz0WRhodIjTb+O/maeROUA/Jnu5ZCKqJHPOYDbxaiQItXhBw7
 mXbSkfjsaJbxKfEADIaYWdwUaa0TV7RP3maNH2cdlvp0nXk8tNx+4KEigB8UxvmPYxID
 KhDg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8KSv1+tAFeQcaZ+rAbwo+YDNDDuZzs4uk3vnU9AqODUsrRnfSW699Tp17gDEo/cUIASxeU6w4=@lists.denx.de
X-Gm-Message-State: AOJu0Yw3m9uOaUYrk+fByigDcRNScAHePKg+k4Xxq0/Ke+UjFdoK3kx1
 uq4nvex0gXVI34F+M/nEOjpJjIDmgNiUCQHdVUY1s9yQR0bP6zIwb6vvGAQSFmJFr8E=
X-Gm-Gg: Acq92OG/Z6oU2CQyFA90+W3eOEW9NFb6NdQ/9z/7I7RX1b3HBpEso7XkRC40201lwgC
 xtwVWkuWBhl95jeFK7Cr32zkihe2ohFonyDI0nnJavYDsm0L92AukWmPhxM7YpGsl8TJhcDxPH/
 RWUZ1kI3WxwQqQ3eaQCTWEHcxsePGWwMMEuJFPdDt9Av0cq7RLcrviHxltrZJ97ZEv2nSLFfdea
 ShXbTLN8N21qvM7RfXvGL1MEwVKyZawgJY6AJ6R6ceebD18+BT+uko5/yfDEUFNTlh322aJUXtR
 695QPtCNQaRRovyfHWoLQYaXXm9qODz8Uyic2xzTKj+X3MBGniZcKNjBOnWDNxAHvcvh+ykyTr1
 jPcA493+tOrZD/1ANh0EXsfXWqki0f3dQb5xZI/WK9PKJry/Ip/r+Nyl1OR1U22SCNsOEvJHlTd
 lU2GKhtYlDX6P1JoXQZiUAcgmf83J7JnnN3vMJp5s9hHEtzBir3C4KCJ2tYDNcqaN6fkthHiSU2
 jjZBNNrVc8/cOU24Rn/1lODa09+RvlXLKIybMwHQY7oO8kESJM24CmD1NhYnMhfFiMqFQCU0InD
 pCs9rjm2UB1PhgOsCW1cqFRRRyurfWi828lHXLtmia9JWXuPrlTfjT+QdTg8LzUdI4BXUlSYhKZ
 Q3Rwx6c0G3WSEqTGOgz69TIjgGlny+sy9LwJpae+xTxV8bXyiey017BJv2QYJtJmCwSIq72Ka5a
 MuY27NjgyMFDxEE0KTWlW36DWg6SnD6gy7UQlxLVae3MJfElXvma4U1+gCUyYrA6GQd1C6xZTS5
 1TmyZO8e2YZKKPhEtqtMVLbC0JSpKlsBu0v
X-Received: by 2002:a05:600c:5288:b0:490:6237:521b with SMTP id
 5b1f17b1804b1-490b5ed0021mr110027305e9.27.1780558668150; 
 Thu, 04 Jun 2026 00:37:48 -0700 (PDT)
Received: from hera ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3918d7sm46436675e9.2.2026.06.04.00.37.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 00:37:47 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de
Subject: [PATCH v5 7/7] doc: Add a warning about using RELOC_ADDR_TOP
Date: Thu,  4 Jun 2026 10:37:12 +0300
Message-ID: <20260604073719.48723-8-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604073719.48723-1-ilias.apalodimas@linaro.org>
References: <20260604073719.48723-1-ilias.apalodimas@linaro.org>
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

Since devices that can't DMA above 4GiB will misbehave with this option
enabled add a warning on the documentation.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 doc/develop/memory.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/develop/memory.rst b/doc/develop/memory.rst
index 5177229630d1..ffee06c1530c 100644
--- a/doc/develop/memory.rst
+++ b/doc/develop/memory.rst
@@ -110,6 +110,12 @@ U-Boot Proper Flow
 
       This follows the same as in SPL flow. In board_init_f(), a part of memory
       is reserved at the end of RAM (see reserve_* functions in init_sequence_f)
+   #. Relocation address
+      By default U-Boot will try to relocate below the 4GiB boundary. If
+      RELOC_ADDR_TOP is enabled U-Boot will look into the dram bank config of
+      gd->dram[] and try to relocate to the highest available bank. Use this
+      with caution as devices that can only DMA below 4GiB will misbehave
+      since their buffers may be allocated above the 32-bit boundary.
 
    #. Code Relocation
 
-- 
2.53.0

