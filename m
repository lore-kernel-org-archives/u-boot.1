Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCFE7E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 13:54:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FFB080283;
	Wed, 11 Dec 2024 14:54:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cbPQqt0F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A33E680274; Wed, 11 Dec 2024 14:54:31 +0100 (CET)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 704D680239
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 14:54:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3a7ff5c85cfso2157615ab.1
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 05:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733925267; x=1734530067; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mEadzyK8w+Ja0OfkJpOd+GM1w3vjSbI20amUPvF+hcY=;
 b=cbPQqt0FxNLMESOMhIxHIRQaPHb/jTMX6xehJo9JbtyEmK3r7+bLS+4UUUiXs0jt32
 flpm4uyt37nKbLIeAZpZDp7IHSQDds90ByhGouLVnIZLxtTMdDxPUMHsVFZAUMviFkja
 joJwI5uebFjNWyoP9Fo5HkSv7lBx4Msn6V2+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733925267; x=1734530067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mEadzyK8w+Ja0OfkJpOd+GM1w3vjSbI20amUPvF+hcY=;
 b=GNsTt/ViVEmW+RjcDb2jTuwVq2SamlnhRDFYmFIYTUK0n532aOu12dCiwCD8Prjj4U
 aqQG+Dr7dEoxI+ymU8AVrHtcnG10LFfBEC9MZjzSA8EInhRm7SGM16TXkKELss3cAmJ+
 ZKbaqmhN/dUB9Zh5chD+MmkBsE+a9CIAm/IRi1/EeaiMWICdJzhFTIDMOaZEjRFaX0fa
 o/9WauRnFRnbejtx22KZ9SN/1EWFfroqcHLIs5WCPIUIFljbK8/W1ktNMK8Mz3IiKfgG
 9kiWyCY6gpzklzv4Qx7WItnQAsYR2huyyPBCSc3z36ijn+rskQnjFGxm9VoMeYmcdIY1
 n8Jw==
X-Gm-Message-State: AOJu0YzEuufi3sIXdRubOmu9pKx+dRGfWOuHJhKfwL6N7+CPlczjv+d3
 QYIK+u2+gAGFmCa+HWgUpu6yS7z4kaP0uuSVd9ci5a2PNIEMSGJovAl3GhcvIFG5wnMEX6ljKhI
 =
X-Gm-Gg: ASbGncvKGGn5Ez7+j6NuNNnTEQrVN3w1xt2oFbK2gFpiRHXz7noMWAq3HsyxVAF9BJx
 W3G3YcibZxy9g+2nsL/Xvh5Yo1WML8mknbb28SkKcPOFeY8YzKZuLEnCXBI5nqmrjodgFtbTnN3
 YvcMPOxKy7Bj4H60k+jZh80Nuvmd8AwOiQyxei1n1gxBHo6MlH6sSeRcZjvM/8atBnmN+MXR7Of
 aSai8FVxgFkhImLWLe4GjtnvKOTr+M2DkAn3UY/tysOq01CK+9jsunl7inhLU8GWKugGSIIrfvd
 sie/BBcBPNlbzDA=
X-Google-Smtp-Source: AGHT+IEI+CkEsG8wC7d487krbwr84bBkrchGgy+WXrU35L1X4bXkhhtYrs8W2hzMt3CMpuFK7QthYg==
X-Received: by 2002:a92:c943:0:b0:3a7:c563:d3ad with SMTP id
 e9e14a558f8ab-3aa1db6daf3mr21983465ab.11.1733925267683; 
 Wed, 11 Dec 2024 05:54:27 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2d46f66f0sm695441173.30.2024.12.11.05.54.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 05:54:26 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Matthew Garrett <mgarrett@aurora.tech>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v5 02/23] efi_loader: Fix typos in enum efi_allocate_type
Date: Wed, 11 Dec 2024 06:53:56 -0700
Message-Id: <20241211135418.563803-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211135418.563803-1-sjg@chromium.org>
References: <20241211135418.563803-1-sjg@chromium.org>
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

Fix 'indicatged' and 'adress' typos.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 include/efi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/efi.h b/include/efi.h
index 58838e3ff2c..cf5c4784b61 100644
--- a/include/efi.h
+++ b/include/efi.h
@@ -178,7 +178,7 @@ enum efi_allocate_type {
 	EFI_ALLOCATE_MAX_ADDRESS,
 	/**
 	 * @EFI_ALLOCATE_ADDRESS:
-	 * Allocate a memory block starting at the indicatged adress.
+	 * Allocate a memory block starting at the indicated address.
 	 */
 	EFI_ALLOCATE_ADDRESS,
 	/**
-- 
2.34.1

