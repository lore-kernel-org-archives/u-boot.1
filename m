Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60352C02198
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 17:12:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87A3F80A2A;
	Sat,  8 Feb 2025 18:12:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dRv22PeE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1B0A80A0A; Sat,  8 Feb 2025 18:12:17 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76A8E80820
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 18:12:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-844d555491eso84495139f.0
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 09:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739034733; x=1739639533; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dIZ2DRC6jPBljBq+MLVYSPuvk/RjboZ8gXqo8WfkEGQ=;
 b=dRv22PeENL4ldATeE6nliLVvz4RvXDkOkP7Mfcp4z/6eYKYpMeSck57vajy33AVbiJ
 P/yumn/mPMp+qitcOHgBEaXeNwzYJQ4+TxbrPUHvXPLWDXv8cg7b0gAxhF2nORRt4lAQ
 6E3RYcYPLWrriGGdnhdi8YsvHwGrpPDMnIH20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739034733; x=1739639533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dIZ2DRC6jPBljBq+MLVYSPuvk/RjboZ8gXqo8WfkEGQ=;
 b=AKsBlJFotHLJUkt+DhjaLB2W9fK6jI1dYj7fOmhFiHTw+QcSpvHZUstCK1BOffBijl
 iNpP50NsYCN/oty3LyzDjo1HhvS4yQspsf2+bT5fVx2OEsLcgbc7GCGuau5dJP6Hc76G
 VAJR66Ze+iEhQdNo12yT9luTSZSH2X6cRnujEdqu79lEIDb6e94Wko6fnaSHZgAQ/JdX
 HmXFhrGRjTFnWvS8NfwjuFao3pTTP4Y3D8FV24EuPQSEL5zWzzcc7pn/3wjYbpSOWFwQ
 Ow18ON1CIVWue8P2h0o8ItxROlRHPvhykA82NtwEoOGDRfZjCTqgYIRP/zE+99nBcSX/
 uoMQ==
X-Gm-Message-State: AOJu0YxkG4SR9z8s8VVup2GhebVX7CxWm24YCvPuqMaKOcjaY92FUZ4P
 y+U8/BFO3m4wuO51KVEbRZuQVS1l9cl9EpD+fYeeCqsPE2k0WOJSRWd73F35qI6krrNN3fI6FC8
 =
X-Gm-Gg: ASbGnctj4in+l3On5LXGh3r0UM5ksn1gYoqMxsCRjGPRTNpaXbVrAcz+HNdquPtJ//I
 ssRrzH1PnNR/i8F7LHfwID5alyXKSTaCwTJvvas5bBrHKJ2RjpeHnF12nYYWS0iTWM/MXX5wsu1
 71u8/IW2iV2RU+pzb1bBm4ZdhjdFab4wWYkgBFpZCQI9toJt4F0n/QXq/3hSObNF6gqMeRGVSw5
 EC9MdZbPzeILLLZ8X8hws3kOcmdm3rNbWl9G8SezHPMEBL40RwlLQHCz1+58R7dL96A05CPys5m
 tHCSQyw2Sv3E5uusOpVrX8R9L5ptAVpaRFIAzS+Zx0T193LaIJX+
X-Google-Smtp-Source: AGHT+IEKKaKfNnd6n3AeTdDnx5Cr7biSAhML2mL3BC4LCltPHLhNxUWnb3n8zpFPAK6Vo2HoQmc/HA==
X-Received: by 2002:a05:6602:3a01:b0:84f:2929:5ec0 with SMTP id
 ca18e2360f4ac-854fd897901mr836078739f.4.1739034732963; 
 Sat, 08 Feb 2025 09:12:12 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ece80badb5sm371754173.68.2025.02.08.09.12.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 09:12:12 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Matthias Brugger <mbrugger@suse.com>, Tom Rini <trini@konsulko.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: [PATCH v2 04/29] lib: Provide fdtdec_get_pci_bar32() only with PCI
 enabled
Date: Sat,  8 Feb 2025 10:11:24 -0700
Message-ID: <20250208171154.1305761-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250208171154.1305761-1-sjg@chromium.org>
References: <20250208171154.1305761-1-sjg@chromium.org>
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

This function calls dm_pci_read_bar32() which is only available if PCI
is enabled. Add this condition here too, so that the EFI app can build
without needing --gc-sections

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Matthias Brugger <mbrugger@suse.com>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 lib/fdtdec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index 3b4247be25a..0244e8a3a72 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -248,6 +248,7 @@ int fdtdec_get_pci_vendev(const void *blob, int node, u16 *vendor, u16 *device)
 	return -ENOENT;
 }
 
+#ifdef CONFIG_PCI
 int fdtdec_get_pci_bar32(const struct udevice *dev, struct fdt_pci_addr *addr,
 			 u32 *bar)
 {
@@ -264,6 +265,7 @@ int fdtdec_get_pci_bar32(const struct udevice *dev, struct fdt_pci_addr *addr,
 
 	return 0;
 }
+#endif
 
 int fdtdec_get_pci_bus_range(const void *blob, int node,
 			     struct fdt_resource *res)
-- 
2.43.0

