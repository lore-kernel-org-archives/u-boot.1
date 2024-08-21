Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A30A3C52D7C
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 16:24:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21A3088E8F;
	Wed, 21 Aug 2024 18:20:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L7TRe05q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 130AE88E82; Wed, 21 Aug 2024 18:20:06 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF22488E40
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 18:20:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-70942ebcc29so4691202a34.0
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 09:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724257202; x=1724862002; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F4G0YWPb6Ypzaml5yjhEsz6oeskiXYPPZugMgD1i3eQ=;
 b=L7TRe05qYYGMjVXRWCYn6LFaOXSWQlkiL2PHeDeGDeh/qEWWu9PBzgZo5m6Bf7Nhbx
 8JxHwMh8a/YA2h8GsOHZKE44KWfPK1Mba8mnZUqfH9lsJsAeSx+ZhMo6xcpOuPYKR8d6
 nIJbVNXmvxhD1hMgoU1UzqcCOn1i0dZLiM/Io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724257202; x=1724862002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F4G0YWPb6Ypzaml5yjhEsz6oeskiXYPPZugMgD1i3eQ=;
 b=U5Q9gu0N1DBH2w8MlnCrjHrD31H+cFCsIDbevAyPfJJIBEplA5V21khdzF20p+l2kq
 n3xtL4AIg+o4Rj+MWY/qYgr6Wym6USCmAYegZF7XTlxvVazz99vTSt9N71oRQlZRjqp3
 iR5itMph17UhMDUvCiyNu9brPYN0seuvRxL1KxrarTlUJR4LnwNZElJnD2ZpbBiw+8Dj
 u9m9LPMg4V7kNwRAgwbScXB9FjFzsWtjI8FzU5CAqwUlE3yuDOoOds1Yzs7s6hz7CBbr
 VqstO2/qQ0HtTmCveuRWpi6/mJhefdnxJ5Zd9V+IKSBJBBHRhNryFcPOT5lu7Lp0lhLc
 Sikg==
X-Gm-Message-State: AOJu0YyfifLWmzxqhoRwNmusNQP2WW16lg0Ogka4N5Vgq5eMevb3c+At
 eiYyo9s23fx5yklz6hSO/1R2H4mcGRWvPGFaURR4lWhLLFJnHk048I6gg6OXkVQdvQZ3CT+JMRU
 =
X-Google-Smtp-Source: AGHT+IFaGdLWy03J2OVKUkpsJScAn+a1HDfj0NACtoLiJh/S7AcOwC3v1dTyM6wPDxC35O0CGkvMRg==
X-Received: by 2002:a05:6830:4186:b0:704:4d29:65f5 with SMTP id
 46e09a7af769-70df888dcf1mr3245323a34.32.1724257202293; 
 Wed, 21 Aug 2024 09:20:02 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca6629792sm3222376a34.72.2024.08.21.09.20.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 09:20:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 29/35] global_data: Put phys_addr fields near the top
Date: Wed, 21 Aug 2024 10:19:21 -0600
Message-Id: <20240821161927.695717-30-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821161927.695717-1-sjg@chromium.org>
References: <20240821161927.695717-1-sjg@chromium.org>
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

Put these fields near the top and together, since they have the same
alignment.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/asm-generic/global_data.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 3296813e86a..774e757b179 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -49,6 +49,14 @@ struct global_data {
 	 */
 	struct board_f *boardf;
 #endif
+	/**
+	 * @ram_size: RAM size in bytes
+	 */
+	phys_size_t ram_size;
+	/**
+	 * @ram_top: top address of RAM used by U-Boot
+	 */
+	phys_addr_t ram_top;
 	/**
 	 * @flags: global data flags
 	 *
@@ -102,10 +110,6 @@ struct global_data {
 	 * @ram_base: base address of RAM used by U-Boot
 	 */
 	unsigned long ram_base;
-	/**
-	 * @ram_top: top address of RAM used by U-Boot
-	 */
-	phys_addr_t ram_top;
 	/**
 	 * @relocaddr: start address of U-Boot in RAM
 	 *
@@ -115,10 +119,6 @@ struct global_data {
 	 * GDB using the 'add-symbol-file u-boot <relocaddr>' command.
 	 */
 	unsigned long relocaddr;
-	/**
-	 * @ram_size: RAM size in bytes
-	 */
-	phys_size_t ram_size;
 	/**
 	 * @irq_sp: IRQ stack pointer
 	 */
-- 
2.34.1

