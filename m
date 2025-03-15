Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5693CC28B30
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:33:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6168D81F00;
	Sat, 15 Mar 2025 15:28:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ccH+disN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 716D481E51; Sat, 15 Mar 2025 15:28:42 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D66F80ECC
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:28:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3913d129c1aso2385981f8f.0
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048919; x=1742653719; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g9FRdhxIV8N4ZcpK+h1yudR9Pzm+gi2mHz2SxX69GmA=;
 b=ccH+disNIWz4GrwE6crnxuzYaz0rYvPYQ8d+r0I267tXNzbH8PQH2CMviMjVyzgNdD
 bKS/hY43eoVhpKDtMSZlxAlrLwO5yletSKhj+227uSVIcXhCaWoYg/8X1XWQc/9uMtL2
 vDSqLsdSfcCDgCoCEPJikcXs6kKW8gZyDkvvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048919; x=1742653719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g9FRdhxIV8N4ZcpK+h1yudR9Pzm+gi2mHz2SxX69GmA=;
 b=nfTpOm5bSt6HZOidkuExw33rC6a7wyEV82AoBtYkzcRDpuPAjNG6ngmJ19CUK/Ll90
 51u1p55h9+/PynUoqiafJUPy1OUBPtDmX0+J0uXE893rv00dSVti5InkOukGuEEMvO9+
 YJFopVOWQDLYwLAE+t7VOLEPPI0sE6HXEyKRG8e9fTqZ5cC5Qnzz985Dxkfe9c6SAWLf
 JDQqii/ET2PUL0/EKYag9g5YQyVnUiv1Lyf9c31hpIHgfZN45EpiRBIDNxDq4g/YX7cw
 3CFJmcMWILL4ys8nhf2c31vmRx/ysT68SfaNshWtyF8NQ3lPOGlc/oj0mookoCv85GRP
 iEJw==
X-Gm-Message-State: AOJu0YzT7dPFkhJYHf1YoxaMsTRGJ7ax347gpKSGg9EITyNRXNMP1GK+
 83kFrJ3jIu9ebJW5bCE8EKYwV9j++P9Nyhq+l3d0NUus9psndfxR23de/qpOxJAZeBuU/T9jGUJ
 auw==
X-Gm-Gg: ASbGncs6hDPfwmpUwVzbcuxXus3Y64jrzKYA6bDDVl60W8oz/KI3xh9MnMt77aifRf3
 mMjsF6QBAj0l7rl6f2c0qds5xtIdUWTbYWaiswmljowiA1NsWB8KnS6fwIEJ1zd6wAeMnuGhShg
 Q1/7A4iXlIo/dF2n+MyDKSFcGy4IvHsmCA1RkJHibhYc5QDIcxHS1JCBIRaoUvz5Dqm/x6KJMn1
 3qtv4uXhcrXl+xFx6yEMKMl6BP0Rg/TAWmwgoh35qQZJKTlUzdSCRDOjertjA1eSnDJ2lsDrPyn
 iTX1CGFAQ9C4J5N4A94Y4t53MSuYL1hFNdOgBC+5cg==
X-Google-Smtp-Source: AGHT+IGs6sqaPaYYXgK2PYR+ZQ5veZJDcrO0KoN9uf1wxr/zepLTCNiPidWANxubSICkrEWJOWGoUg==
X-Received: by 2002:a5d:47c5:0:b0:391:22e2:ccd2 with SMTP id
 ffacd0b85a97d-395b70b79b5mr10725746f8f.3.1742048919465; 
 Sat, 15 Mar 2025 07:28:39 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.28.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:28:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 41/46] sandbox: acpi: Avoid a warning about FADT
Date: Sat, 15 Mar 2025 14:26:01 +0000
Message-ID: <20250315142643.2600605-42-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315142643.2600605-1-sjg@chromium.org>
References: <20250315142643.2600605-1-sjg@chromium.org>
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

(no changes since v4)

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

