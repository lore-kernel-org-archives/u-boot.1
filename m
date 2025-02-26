Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55AF0C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 13:57:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 900EB80F12;
	Wed, 26 Feb 2025 14:56:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="OeOpmJll";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B14C80FD1; Wed, 26 Feb 2025 14:56:54 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 541E280F12
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 14:56:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-aaecf50578eso1354007066b.2
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 05:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1740578211; x=1741183011; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2tEqZOZAqF/RgHyk/xvmtYPrBDVBKMG0hic0evkf7pU=;
 b=OeOpmJllpko1+2A6QVhy6XLxbdiH0olcUZBfee5R/WK1X4wbMyRN+FO7UrgTbfVthp
 nYhCghYu+EKzJiMQvzBEIJtem3xLQf0Axv2x7qycc4FSgIXf7gGmWzaGe9kTpYIcsl4D
 HdVd49dbV1ALqCJeP5o192k9tT4QCdiLM6C9GpZguP9muF9mVRj2r3IO5FUipqad5gC9
 8RtrSghuW9WEaYSUy7Z6N6KkuBXkhf5t79mwd9OktcI/C6mcLul42F7H+TMRmdzpo2bN
 tWTu92morhHIOO87F9ByvZIRP9PunPjVgcF9gcx8JDlH/iZ2MMjM2dcsVfZNS3rQnsqA
 Eljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740578211; x=1741183011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2tEqZOZAqF/RgHyk/xvmtYPrBDVBKMG0hic0evkf7pU=;
 b=DVViB7ENE3XzNO4h0Lh0D5+wuRUfaApDJhzk9GpSxQm1nd7f5oaNocv9kjAor7L+Jy
 P1A8sd1UB0VVsRUf39K0GAWXEmnpG9G2B5goVO1E9TYGM5WR4WCuUlS7HGN1ZdKGLrB3
 yVwM0lQKps/e81EwPigfU7EJlHjJZhjWbaSnlBT+FvjiySqOU1M00BkCZjr8e2EAQ5AE
 Fqgar9oZLi8oe9cW8/PgszIsjAFRfltGFN6h2ZdBXmcrBI80s0KbOyG3BJ5CJc697Aqs
 x3GIufyOpvdMue0o7uHERQMBfTs+l/eUcnr4KGWPKGf/iXbvvSwH/Bkk+P+b+vS5ARH4
 5fHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLFQXh32AQHIjmcpxPOQoV9VUCUpYCYn7cT5i1g/rzdte82TQzKS6LFzRkjFXI3HfKfcIcs78=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+CAAs2HBNByUtN2SGnEMsnsYQ+rjmxr/nviR55bcaJg4nMUQ8
 14IcXBdiqaleMLXYIYLAqcFxAB1j7BkzDiirQCqX4yyz2PG577cSqnZuELQB5HQ=
X-Gm-Gg: ASbGncvVWY08rWsInR8NKUHdusYnFEYD/wBGbyXrhGhCX8dHt0OOh7n8OU920dN4Tjl
 kr1Mpp8+XTjhyza0zsWVDJUC2v2sDFkDyncckaIsOLY8nySXW2UxKYRKV3skb2FjwjJ7jW2e/RB
 bpBRybJhJnoonpxS6gmXi9usc62KlVCH99Uq+d/qBoANOroLjOXhXCDwIMpDvxmfQLdG3W+w3Va
 mo+Ib8OHmlNBnt5fR3pwGCK2pXBNo4GNau7dV8ULt9WKu+eWdpuxHhK6oQ27qRsR5GSRyTTnUFB
 P0ukWjyc0yRUR1XCPqQk78257KaRIDqsax0jG9+UfH0T242XdvGh9lVemS9RLtu7T2tdY9m9PIF
 SdLp2kF9rhtXuZrm+KnLWiKqM
X-Google-Smtp-Source: AGHT+IGJS+c/vOwI6C/ANWiZSdkXcwxcz/6egE0SjLdJwJaIe29EQwYlEBBwv0Id6NrheY03a1yTSQ==
X-Received: by 2002:a17:906:c148:b0:ab7:b250:aaa with SMTP id
 a640c23a62f3a-abc0df5a73cmr1928508166b.54.1740578211468; 
 Wed, 26 Feb 2025 05:56:51 -0800 (PST)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abed20121adsm335104066b.91.2025.02.26.05.56.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 05:56:51 -0800 (PST)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: Tom Rini <trini@konsulko.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	u-boot@lists.denx.de
Subject: [PATCH 2/3] emulation: qemu-sbsa: Select SYS_PCI_64BIT
Date: Wed, 26 Feb 2025 14:56:43 +0100
Message-ID: <20250226135647.194842-2-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226135647.194842-1-patrick.rudolph@9elements.com>
References: <20250226135647.194842-1-patrick.rudolph@9elements.com>
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

qemu's sbsa-ref is always using a 64bit CPU and the PCI prefetch MMIO
window is located above 4GiB, thus always enable SYS_PCI_64BIT.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 board/emulation/qemu-sbsa/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/emulation/qemu-sbsa/Kconfig b/board/emulation/qemu-sbsa/Kconfig
index 72c76b351fa..f4ad63e681c 100644
--- a/board/emulation/qemu-sbsa/Kconfig
+++ b/board/emulation/qemu-sbsa/Kconfig
@@ -33,6 +33,7 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	select OF_SEPARATE
 	select PCI
 	select PCIE_ECAM_GENERIC
+	select SYS_PCI_64BIT
 	select USB
 	select GIC_V3
 	select GIC_V3_ITS
-- 
2.48.1

