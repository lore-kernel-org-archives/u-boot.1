Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D45E5C28B24
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:13:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E66A4817C4;
	Thu,  6 Mar 2025 17:06:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mI74RADj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6572B81335; Thu,  6 Mar 2025 17:06:21 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 372A181D58
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:06:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-85aec8c95c4so68384739f.1
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277176; x=1741881976; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7m0dRG5L/Oy2x6iJJX1kErjw86Vokdkx0LLphPFz9Zg=;
 b=mI74RADjJcyrXBtjrJpuhVA+2FekrPGVrTYG+tZfrUX+CZCYFzfI3+xsjbqUjg4Ut9
 gJP3cgdIPIfLDnI8paNRy54lxQqpTNbOS7iAlakaX60XjFMLuyvqh/b3p3gUD88KoL2J
 LxgYIbZ0wtIcHcije7R0xGjN4/SuxgiNxN/S4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277176; x=1741881976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7m0dRG5L/Oy2x6iJJX1kErjw86Vokdkx0LLphPFz9Zg=;
 b=Z/NvFBlD836Znz7xES9NADeogfEc+pTBW8mZQVg4DhWePQdCNHnw05AANZ0nhChABD
 J2k6F2r1Le9GwyLgBb92JZmgpZV5lqK0ITTFFXFARmhv/4oDvFPTOnikw3TFO4GKdOnu
 +JHeZo0nyC/vbMCddKQZkofR24UHTbXMIplpvi443czOBYtshGGxGqVCpjFOfense93P
 aHk3IyaRPi+yD/ieq5pgBuCcya/uc5BB5e4TXpYTPmc84v9SQHWwj9hm2mLXazWCf9Zw
 JYeUPKUfwfoaf5zk7hs8ysTj2tj/OHsI+xEOchtT425TlmiBrayxtj3Iy3hza+WP2tgM
 Pbpg==
X-Gm-Message-State: AOJu0YwFSvIqRtcnzAecOdSGGVPIb/MXYhpGNtjXdTk5LPFxM3eU2wE0
 P1cKpnYfyXMtYgI3X1oqEmf75Dz4pITi5/uhcRwcD0LMR/gnBCnCf56FUw1l2FuJ1xM7HWdl7f8
 =
X-Gm-Gg: ASbGncvrTWblf308ApV2rLEAp915S6rHMzmC0wkpSyKU351dMrIsy8ug3cfrJzjZkSi
 rhl6DxYBE7yFVcFiqNOc6xT1ZSj2KDLHeB8gYvI47joLI4uqECf/K7Xz99HvoZrZqXsSKT9wAK+
 5X9DG1kqwELrx/mrzJx6S5WA1ZuSsDwLlWlahf/njD4Mmw9DR2C9N8MzOeOeIhTQMx08jBWCABM
 t/+vo+oPJPvoHqwyHIzZJYRAKcXe7qRIcQvSdGEx2YQU513KZMiYd7rzGV9l4UEUGcoiazj46v6
 Mq0sgmV21hjdxDDfRQm6Fp4ABK4Z3DQe5lnrSI2vaHGB9PHOt8IrHyNhiHxDowNDGlneucutx9V
 O1lwwXA==
X-Google-Smtp-Source: AGHT+IED9DWmRZUKpkwJtOOvftrBM1zZgYIC4wVx15FJoLb0PudjgfTIbVbFQjkoBZUkH6Lyd4zf1w==
X-Received: by 2002:a05:6602:7219:b0:85a:d86c:8fd8 with SMTP id
 ca18e2360f4ac-85b1d05a40dmr4303339f.14.1741277176116; 
 Thu, 06 Mar 2025 08:06:16 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.06.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:06:14 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 41/47] sandbox: acpi: Avoid a warning about FADT
Date: Thu,  6 Mar 2025 09:04:08 -0700
Message-ID: <20250306160428.3041057-42-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306160428.3041057-1-sjg@chromium.org>
References: <20250306160428.3041057-1-sjg@chromium.org>
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

Add a condition for sandbox, to match that of x86, to avoid the warning
"FADT not ACPI-hardware-reduced-compliant".

Signed-off-by: Simon Glass <sjg@chromium.org>

---

Changes in v4:
- Split out into separate patch

 cmd/acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/acpi.c b/cmd/acpi.c
index 094d9d4e858..2273176f106 100644
--- a/cmd/acpi.c
+++ b/cmd/acpi.c
@@ -58,7 +58,7 @@ static void list_fadt(struct acpi_fadt *fadt)
 		dump_hdr(nomap_sysmem(fadt->x_dsdt, 0));
 	else if (fadt->dsdt)
 		dump_hdr(nomap_sysmem(fadt->dsdt, 0));
-	if (!IS_ENABLED(CONFIG_X86) &&
+	if (!IS_ENABLED(CONFIG_X86) && !IS_ENABLED(CONFIG_SANDBOX) &&
 	    !(fadt->flags & ACPI_FADT_HW_REDUCED_ACPI))
 		log_err("FADT not ACPI-hardware-reduced-compliant\n");
 	if (fadt->header.revision >= 3 && fadt->x_firmware_ctrl)
-- 
2.43.0

