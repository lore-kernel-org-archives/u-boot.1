Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F1EC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 13:39:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6FBA84AE3;
	Fri, 10 Jul 2026 15:39:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qWujNs2L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70FA884ABE; Fri, 10 Jul 2026 15:39:42 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A21E84A7A
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 15:39:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-493bf73ec2aso6034595e9.2
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 06:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783690778; x=1784295578; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yVYxP24nfoQhlZR7LjTrBOpaZmawq/16Ee5PXZ45XYI=;
 b=qWujNs2L7gzeByHODZPI7cjxhl+JjHIB173pofS7AP0IHSrh9yudYPEFQoP6LGrcXJ
 deYjquwekZJ9ae+YzExDe4oV5xdiZ8hutBuT9+tpEX+/kcORYCFhZ8hR/k7vimAxJdTV
 OuhmKiIsVju1erg4Wm7zA1C2wkM1JAZ8c3GrxY13uw+iztlgPq+tznU61/DZNW1rIm8V
 MhIKN79H2QTZQKZeROsAmKwhgz6tLOOXY0bxsZ6vWBOyZqUYk/ELCWT//SI6YG982+Gf
 rTYJW5nC1MYkLOaXBUoZHmRmN7NanE0UGDuPVcvO8bBUKDAeKk8ojGv/XzKoy9+WznTU
 LXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783690778; x=1784295578;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yVYxP24nfoQhlZR7LjTrBOpaZmawq/16Ee5PXZ45XYI=;
 b=kQFaYZavFLZpzNEExb2Yh5gdD9sUd1LaKKcXBYbliAQvIazsy5oOpKy5unYB3WN/T5
 0KtUHXmADpkZZr1+CkUvAdzJt0zxk3bcoDP2N6mVh2pySEsFrkQOcR/GY93kgqKxkdT+
 U8RZAvZrpgQFcCQAz6CxnZConMP54R6Hpj+yyfNOSzoimJQKlj40J0xDyNc3ULSxKQli
 YNFVnWwFMv2B6L2VMpUwf49qdIvxPKs7NFK4D7BlRyI+x9Qf4FGGwgewEJwfTT1kTZb6
 LGAdNeEZ8b0FND4sDs8oEBhMHWEnDHGPK1DqH5ka3k71Pd4oEb5KB6Ovm2Yu5juc1ocN
 t0Lg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrwo/Vn9ERD9VC4rcbyfCeNRkhq//xlkhp230FayqtwZokGdm7PBs6LC/yG3LS0IIUng8o2AD8=@lists.denx.de
X-Gm-Message-State: AOJu0Yy42xpa4RYXIttnBKRuboQ8KjJe36UUqi8kFOg5iM1rAqGrpNlr
 bjcmqYA8YbYE+LaJCMMR0W98eKZvjqlEKPY1v3u7G+H/33hOmm9dsK20
X-Gm-Gg: AfdE7cmR/VJRUmM5/IeODL4M/OUuB5Ej2PiIc3r/Ok1BFkrdi9jHDmwGXI7fDqaYzoD
 wX6P53W0AooMmRdgyhXgvCIjO44v29Kanc2txY5xZx5tkb37n6pcKMhhGbQJ5Zvr/mZymkdYhrE
 EOsOGEIRXdUartqpTXJhrNOVxml3CPkx3x+d2uy4SMmjnysDYNDqyuZT3Np2cJ1XcOYz425ok9j
 E5RAuvJzGX8MGMCFWCOhJb89vS+SY963F9tzSJmaJ70CQ0uwbMAMb/XCylUGi3AiYJ/d1zOgUsU
 I72p3GyNV9tBbgnial+QSwRtAvc2ePQERAe/JNmAcIbHrWF7+YONjaDXm7ocbBYPxPY9+7dvDp8
 ok/tf7AQuk9XA6POSJbmqsAwNMkaWvSvCRPVRDNwSME/+/5MbC5IcZ9AdPgCSqoJXMelYgHv4p6
 zmrrKDE6D9/xaIIlZpf6RW6N3138wQjrIwXC+YMwu+pW3Eh1sZZA0eeXHzRoAY782lIw==
X-Received: by 2002:a05:600c:3f19:b0:493:e79e:daa6 with SMTP id
 5b1f17b1804b1-493f47bf9ccmr29864295e9.33.1783690778243; 
 Fri, 10 Jul 2026 06:39:38 -0700 (PDT)
Received: from emanueleg-nb.. (host-87-5-34-196.retail.telecomitalia.it.
 [87.5.34.196]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f2e714a3sm39801495e9.2.2026.07.10.06.39.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 06:39:37 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: "Francesco Dolcini" <francesco.dolcini@toradex.com>,
 "Tom Rini" <trini@konsulko.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 "Stefano Babic" <sbabic@nabladev.com>,
 "Fabio Estevam" <festevam@gmail.com>, "Peng Fan" <peng.fan@nxp.com>,
 u-boot@lists.denx.de
Subject: [PATCH 0/2] board: toradex: smarc-imx95/aquila-imx95: detect RAM sizes
Date: Fri, 10 Jul 2026 15:39:07 +0200
Message-ID: <20260710133913.388770-1-ghidoliemanuele@gmail.com>
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Use alias-based RAM probing to detect different memory configurations
on Toradex iMX95 modules using LPDDR5. The address wrap-around is not
linear on LPDDR5 modules: address bits above the module capacity
alias back with some low address bits XORed (bit 32 -> XOR 0xc000),
as measured on 4GB and 8GB modules.

Emanuele Ghidoli (2):
  board: toradex: smarc-imx95: detect RAM sizes
  board: toradex: aquila-imx95: detect RAM sizes

 board/toradex/aquila-imx95/aquila-imx95.c | 23 ++++++++++++++++++++++-
 board/toradex/smarc-imx95/smarc-imx95.c   | 23 ++++++++++++++++++++++-
 include/configs/aquila-imx95.h            | 15 +++++++++------
 include/configs/toradex-smarc-imx95.h     | 15 +++++++++------
 4 files changed, 62 insertions(+), 14 deletions(-)

-- 
2.43.0

