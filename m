Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3C8E77199
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 12:32:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26ABA806DD;
	Thu,  9 Jan 2025 13:31:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mwqRrJBW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA6AD806D4; Thu,  9 Jan 2025 13:31:07 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3910806B7
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 13:31:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-844e55a981dso24766539f.3
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 04:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736425864; x=1737030664; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xvqInPzEadCAHlXsufpUWzF/izBdfFyx6bDUEXgnCbw=;
 b=mwqRrJBWEAovp4uaubdALgVmXqrceC8i5ANtldVURNG32ux38FA5v/Z7ubxDucqmU9
 8Me2UcR2iP0P7QbNYeRWJAjnzwxY1N2x5uJbSIORKuxM9qGvtcwiJ8zkvmJISyOa2kLS
 26XabQU8HFgSd1pR3Vp5hg/uxap4EpNtE0Bko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736425864; x=1737030664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xvqInPzEadCAHlXsufpUWzF/izBdfFyx6bDUEXgnCbw=;
 b=OukjvYgWHSq2gVDOcaD4jJadZm1Eq6zRbBj5Gm4TL59RpFrkXZk73O6CHtNljp3MIT
 sugWfT9rTun8S13Z7fr5i/AocBPOkE5BaPRnMkYAkphJ6ieiAVygiRFIYwdto/hv4J7/
 VYGVPQLOZovAYxFui0nbYECq4iIubYSYLo7WNul7QczoAHl9WZSPeaEyCCEUwlWQAPmm
 u9gx0IuhludFxw26npnlMaxzD3XFkMiyUMFjGHAZY/cw7dapzQ3Z96zrudgx/6Vlsp0G
 9R3Mxex7BtMWvUvpGYoG1aGbOfCzFbmKgRqzTDBh6jUgs7P6cZRRq2fiaWDCxYKAfG4b
 xJlw==
X-Gm-Message-State: AOJu0YwRwYiLeDxgApTYwMSoDqli1OEm3XSOh8tjFUgvmaTt8EYJraOL
 FTn/oyU6nDVcuY3az2nsTVz4cWy7LCW5JHIglqFl1PXD/QXxy6WFYJMwSe20/yG5gbWnIlrBwic
 =
X-Gm-Gg: ASbGncv2LpsMpuLarSku1alKZwWjGIwIM8F5Dfvhqj5LiWsgudbouBZfVOOBqV/OBdb
 zPVJdeddpjol16cEkZDX0TD49YJ7xZdlsZdlol+dYmmQL4JhBNvLGVQpJBZ1325MtY/U/1iIpBb
 L2UKA9OzZcWFijH6/qsCPKNu2WW6pQcKuLk5H0NW1Zo6IWfifun5RULpAQjq3ZWRjwebXxngM4R
 e27xc776QjomH4405rdHvaHSY3AlUXbOxZQNndIshj63uMxfUPofekC7xw0AAxxyneKbu4ptiGS
 t9jctM+4oH1ccYE7/Q==
X-Google-Smtp-Source: AGHT+IGbkKNUeRcXHacPA0T1C7aiaXKf0lAl1ijj2HQM+6iHjXxVpTGAz5ozq6WkvpvesMlRMmrDKw==
X-Received: by 2002:a05:6e02:1fe1:b0:3a7:e7a9:8a78 with SMTP id
 e9e14a558f8ab-3ce3a9c1918mr41200185ab.17.1736425863798; 
 Thu, 09 Jan 2025 04:31:03 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm281678173.20.2025.01.09.04.31.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 04:31:02 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 13/15] vbe: Support loading an FDT with the relocating loader
Date: Thu,  9 Jan 2025 05:30:08 -0700
Message-Id: <20250109123010.4005298-14-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250109123010.4005298-1-sjg@chromium.org>
References: <20250109123010.4005298-1-sjg@chromium.org>
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

 boot/vbe_common.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/boot/vbe_common.c b/boot/vbe_common.c
index 742e754b133..46b39cf8910 100644
--- a/boot/vbe_common.c
+++ b/boot/vbe_common.c
@@ -173,6 +173,26 @@ int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
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

