Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2C7C02198
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 03:23:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD8C480ECC;
	Sat, 15 Feb 2025 04:23:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FkI2gzDO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6DB480EE5; Sat, 15 Feb 2025 04:23:24 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBBF080ECC
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 04:23:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3d285a447a7so278915ab.0
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 19:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739589797; x=1740194597; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dIZ2DRC6jPBljBq+MLVYSPuvk/RjboZ8gXqo8WfkEGQ=;
 b=FkI2gzDOVxg87ZkOundMbeV5u07IL7IPOe5hrq7pefP4Zb2jbtjiBxQO9moulGyqG4
 XqwQHFigonvFSA/SeNRomLHJaWNNYL48qo2u9GCVE9vI+PRNS/pj4HIbRCScmRB1EbJz
 S1HRD/zCGrxfpTSjoFEdkaXYXpQtqxtdnYdPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739589797; x=1740194597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dIZ2DRC6jPBljBq+MLVYSPuvk/RjboZ8gXqo8WfkEGQ=;
 b=KGQkUyseMmp+QGmEaLO0CXW6REqY7tY7ULk19gNXH4FTxVbGQY2/J+LukRpaiZ22C7
 At/izEbYEt0BE9oh5tHK0gDfMR67S0ly0xnUnYhNrwl+DPh/mKCACk1gBT7wpq38LYJa
 Z49+43egp2euHs7uHwb3OqS0MEf4fX/mp0q4joZszASF04KgguF0PRkgYurub+lEINCG
 /9kp7dup4hiE91HNlqoB7pcS7JvHh0FQ4Q5S13sU3iuFERxDrhatdKH7PlomvhdZuc24
 5009YlROOXmszI1ls2eaRtPyaYAfxkH02hy9m42sxMYsdGB6L1PNJKZkl2DCZ7tZzr9k
 T1vw==
X-Gm-Message-State: AOJu0YwbnMjnYcs9GKyI1edtFxSpi5xPTw2AskOI7g01czB9ahDeKjPj
 JT8TAXDeoch5UFyrVpswYqTzqqU1rHIB5SgCPCoFvbUgFRsRF4cBrl9tSS60QGyAQCMfRURUhAM
 =
X-Gm-Gg: ASbGncuAUXebjSU+G3MlXr2ynsu0vBUX3P3Lwq7Dq/7+XDRsro++2pVEo1h3uKbMptP
 0zMJTiqWOJWs1QY2pev2DNacv6IBEmLCCxwJ9beRvQ0i1064C9BAK4BL+Mrw5qolpCr1ur42fCd
 cjuAmDbQ2ejcaebKS9TDEB5uVJBlTTpny2WNQS8F++9jS0032Q6gPcXQ/9NTKJt+BBAaunhjrlo
 WbPaRoezsR8jV0+1xyqGsGOykA+VoF+AEJJ8N1GWfB6Cap97SodFUlBOqcW72E/cfmnRvKQM5FT
 7cEot/+JdsHzDtUVhihpj7LnT8oSh5lxcPIYHJkUnWJCljKYDnkF
X-Google-Smtp-Source: AGHT+IFzynPLw2+B02HN/JoiXxQf0GQ8sIVXkGFcYgl6o+u45+skyu74XBpOUkRyCpJM7QgXjuCgdQ==
X-Received: by 2002:a92:ca0a:0:b0:3d0:d0d:db8e with SMTP id
 e9e14a558f8ab-3d280771c6bmr16932415ab.1.1739589797404; 
 Fri, 14 Feb 2025 19:23:17 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed2819d0f5sm1087697173.67.2025.02.14.19.23.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 19:23:14 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Matthias Brugger <mbrugger@suse.com>, Tom Rini <trini@konsulko.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH v4 04/29] lib: Provide fdtdec_get_pci_bar32() only with PCI
 enabled
Date: Fri, 14 Feb 2025 20:22:25 -0700
Message-ID: <20250215032254.4121030-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250215032254.4121030-1-sjg@chromium.org>
References: <20250215032254.4121030-1-sjg@chromium.org>
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

