Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96AAEC0219D
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 02:02:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 754DB8091A;
	Sun,  9 Feb 2025 03:02:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cCrMMCTG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77EC18083F; Sun,  9 Feb 2025 03:02:03 +0100 (CET)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A73680840
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 03:01:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3d15ce78fecso263835ab.2
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 18:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739066515; x=1739671315; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dIZ2DRC6jPBljBq+MLVYSPuvk/RjboZ8gXqo8WfkEGQ=;
 b=cCrMMCTGNanKUuDxgWL6QQiwi0ySZYeKlNqAmK0F5SYN+jvmzKXktV4Rl5oP0pnVp2
 KA+tII6J0X/awBbUHIVdzAvtsRTjR4+4AWMkOVgAT61yWydDPNbMjkQnVq/EpFOaAgwW
 FNLFUb/1PH/DtS5wWUfkx4LsGaHSrztiDSue4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739066515; x=1739671315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dIZ2DRC6jPBljBq+MLVYSPuvk/RjboZ8gXqo8WfkEGQ=;
 b=APLfSrYOfGuXKfS5A+XZVmiQfSn0MNQ3EUQUaTbpp6aYgk+kTI61yB8TDc7sKnCMlW
 /be2o0sS3LvUsWJFG30Wa4+BVCcJ7ljYMA2fnMXoceRe27FhLs4xzleH1ZJlxxmniZCv
 xF4Jfi7dEKsCIAf6tQmelkeETgJurH+r/SRgSmx8MV0bMajqXMi6MpK5zstUpyE2nqlD
 yZgIXBejk1RCNRDhT5coTLkkrc0jFWPa+AQMz8V4vfPoFR3AK3LKtIqJg1+AkfFn0Jse
 wsSGwDdE4HGkdwTvx2KI3N/bysfz8zsiNSeoyJTFIYRG/cX8m6m26UIpwrm0uaykqef2
 4wCQ==
X-Gm-Message-State: AOJu0YxYEku4mBTUDqbIgTqgS7ByDIl+8Gc90+208nlmfFpOxCNHSdet
 h8L32H9eS7gobeMNUBFIwIIwkWbcwuIBoEbXsIXYaBhrLjjIO2WqUd4sMHt/j/TpxQQF1LtgrwI
 =
X-Gm-Gg: ASbGncsLBakOGDbGDnBeU3fvbkcwh5kjV63LLkFzF22wqd8GHrUo4nqlEnV4RXC4LNP
 YGlxkZ/sckpFgFRSTaj0RfmL2fyH2F2wByBF1DpxCFK+ztWBfII41prugJcoOzUZFW73pIN/rMU
 ov9PdGhiVTku7cwclBk3+rslzNj53IZ2UtZ9TtRc9PWpT0w4OtbyQNi44tMPmd/3L2CLHmH2hEI
 JLXdwiyzcPwI9LqmDAVCp5in4bg33KmukU814xw2a2aq7HSydGhWtmoVQc7P84nEdVFX3LgwATp
 ppC5H1dKFUkebt2gM/gpLmZV0wF7O5mulBJ/0v+vkPbseuv3K5Qs
X-Google-Smtp-Source: AGHT+IGpICNfBjPQr/UemSGTi5eJMgWLUP6u51yEp13N63GpNi5WTA2QHVMAXb+92FYV3WTQ705J8Q==
X-Received: by 2002:a05:6e02:1a23:b0:3d0:25d0:8507 with SMTP id
 e9e14a558f8ab-3d13dd23621mr68140545ab.6.1739066515156; 
 Sat, 08 Feb 2025 18:01:55 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4eccfad03d4sm1506705173.75.2025.02.08.18.01.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 18:01:53 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Matthias Brugger <mbrugger@suse.com>, Tom Rini <trini@konsulko.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: [PATCH v3 04/29] lib: Provide fdtdec_get_pci_bar32() only with PCI
 enabled
Date: Sat,  8 Feb 2025 19:01:03 -0700
Message-ID: <20250209020136.4108987-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209020136.4108987-1-sjg@chromium.org>
References: <20250209020136.4108987-1-sjg@chromium.org>
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

