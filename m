Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED29DC02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 01:30:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E83580717;
	Thu, 16 Jan 2025 02:28:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WZvx/2Mr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90C0C80703; Thu, 16 Jan 2025 02:28:36 +0100 (CET)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6399080214
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 02:28:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3ce4b009465so1252125ab.0
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 17:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736990912; x=1737595712; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0JXAAz56FL+vUyRzFUFA7/n8KXAPrQC7MpJuL5Fll3A=;
 b=WZvx/2Mr+URUt0jz1fGBMGEkuX9iAsqU5JY2t8F31jLdLAAKtObsxCpfpuKfjRL/0k
 wKR4bot8WVwOA7mac3JprrMDiz4iz9n1e61MVaIohvhxkyYm/AwQfzX5j1/9V8nf6CfC
 BQ/G2dyGhCyKBZUumdi/U8UkZFDGPzVBhoKp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736990912; x=1737595712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0JXAAz56FL+vUyRzFUFA7/n8KXAPrQC7MpJuL5Fll3A=;
 b=Vk9WISJ72MUjC/s0c4DeLQAxO0H358PbwmwSjg70xzdx9sVhaYaIqLolZdjzLNNiYg
 QUZHweZofAawGlX9u4O/DrfAqj+djVELmhfa0FfY3Ht2fJ92G1dEASyasHDYbVRxDwnY
 91Hk562iBj4G42vMkomhf0vrvqeTd20S7vFwzDKhLMLJggi4p2RbRwRakdO/6Ieg5w85
 HcWo7Zusn5/q6nv81m5xoWoPTnImRkfbGSbzKMz+hAccUA0xvxfUMKhYqp7c4tB4zyjJ
 5MWYCliFqy9SaR23lBJ5KwNUQei4fn03CLL4jY5/abS3nroqT/ePhj17IRiBlcIEFvgz
 cYdw==
X-Gm-Message-State: AOJu0YzJKu/Ne/EeQ1TI3mVUKO37otzDS8F5sLwbpZvs1yARnTgmeNv6
 khBDTuuxhOaBGQAOEYAWAj/N+c9dr+XtNHOQ6lE0OTH7C/jI+BhxHMkPo6PXPWmEODYHi4pEAwY
 =
X-Gm-Gg: ASbGncvUe/4m2AIXjHlZHkKJ9ZTI7CFfmy7gRvp0U960QCOO6RbGXLiYWlg6Yp4LbiC
 2SynhdrefeulhuMCgdIF75CPHMCAvqDTJm+a+rqT56OtJJj40c41wUxFdfHhXZLLuKX/9ZpiSEg
 WP4dMSCMus9Td5urFeV3buKCl+rLsd1vHrPRYRD/zN+gXcVBGByrYOiAZp8tSu+skluEWNAR4Uc
 OBXPtvd2tGfl+/hwsfkWVCXT6sEw06MbjhbTFKZqrhk1sjIWMB1z6Ln0BC8SpEc+kvlp5wdZQLv
 pLrNF5OGlwEnp9qwbg==
X-Google-Smtp-Source: AGHT+IHX2j69QJtlhFHXh/eLNDeo4Oyem5/HmSJuezcejdlhvcVpcCnrnaHYVqjgA5hmzTR1HS32wg==
X-Received: by 2002:a05:6e02:19cc:b0:3ce:8065:e421 with SMTP id
 e9e14a558f8ab-3ce8065e484mr72506245ab.21.1736990912594; 
 Wed, 15 Jan 2025 17:28:32 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3ce4add8570sm42587725ab.32.2025.01.15.17.28.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 17:28:31 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 20/22] vbe: Support loading an FDT with the relocating
 loader
Date: Wed, 15 Jan 2025 18:27:21 -0700
Message-Id: <20250116012723.2820301-21-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250116012723.2820301-1-sjg@chromium.org>
References: <20250116012723.2820301-1-sjg@chromium.org>
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

Add FDT support so that this can be copied down in memory after loading
and made available to the new image.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/vbe_common.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/boot/vbe_common.c b/boot/vbe_common.c
index 30dd18d3c38..1926e851398 100644
--- a/boot/vbe_common.c
+++ b/boot/vbe_common.c
@@ -260,6 +260,26 @@ int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
 				memmove(fdt_base_buf, fdt_base_buf + extra,
 					fdt_size);
 			}
+#if CONFIG_IS_ENABLED(RELOC_LOADER)
+			image->fdt_buf = fdt_base_buf;
+
+			ulong xpl_size;
+			ulong xpl_pad;
+			ulong fdt_start;
+
+			if (xpl_phase() == PHASE_TPL) {
+				xpl_size = binman_sym(ulong, u_boot_vpl_nodtb, size);
+				xpl_pad = binman_sym(ulong, u_boot_vpl_bss_pad, size);
+			} else {
+				xpl_size = binman_sym(ulong, u_boot_spl_nodtb, size);
+				xpl_pad = binman_sym(ulong, u_boot_spl_bss_pad, size);
+			}
+			fdt_start = image->load_addr + xpl_size + xpl_pad;
+			log_debug("load_addr %lx xpl_size %lx copy-to %lx\n",
+				  image->load_addr, xpl_size + xpl_pad,
+				  fdt_start);
+			image->fdt_start = map_sysmem(fdt_start, fdt_size);
+#endif
 		}
 	}
 	if (load_addrp)
-- 
2.34.1

