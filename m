Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28920C02183
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 15:03:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76431806FD;
	Thu,  9 Jan 2025 16:03:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DKtp8XhX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4823806DB; Thu,  9 Jan 2025 16:03:03 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C347D806DC
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 16:02:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-844e7bc6d84so31967139f.0
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 07:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736434977; x=1737039777; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=anFoy/rR+907YELCcY15IayNOKz5aiT5TAcZIeXRlso=;
 b=DKtp8XhXqFp0NRKhltNveAN+0WIsdmI4aq4Hdgz766XQ4LaRMqUiC5BSbVKCDwJL8X
 PECvOeWrYzEOa3TocMGKvSVcsrgQ8MzT5H7ZaaWisbQ4Em2vc7YPKxdl14IYBxtXJyTj
 h3I1Bpz6XurkCkARw+Pvp8dygX/Op0Oa5ACZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736434977; x=1737039777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=anFoy/rR+907YELCcY15IayNOKz5aiT5TAcZIeXRlso=;
 b=VpnT9yBbJoOt1E7JvYa3Mr6hvEoZaTuYiPsPpVDTFVdND8PvV/PkHWbqVDR8APZMAc
 Lfhq9oXBA6ywTQ6mZK2kFqNINiz00ZiBMJ/5ZjychB4j1bW0+qpKF0tTNF9kBjt5c+eQ
 VSZ/K4v++aMzJpuQrS6hBDfxs8EXdpKLPUJM5OJdSuRm5JEUPqGI6CGGyt/UwvepxE62
 tVZ2BF7WO3DmbJCwApRkvf0BEYmiM4d6kKoh7niuZJQ343bmH2DF29DRzsvBDjKTlJas
 VJ9kAEOo1WyB/BkRfZBOAt4fMSfEa0p5au5nHZqoHDGOrpgyLdvUkJMh5KOIpZpppneO
 bLVw==
X-Gm-Message-State: AOJu0YxyPCa7ykwyay53Gioq/DUee6Sv8r8sizOOK3VuiDTfwSm6l2b7
 fIU3yNNi00JMrJPCTYXbCk9btoheHJHJIh9UZfsxR40C4YVvVqCCFhtDOVjQigFr1BiLPh9UszI
 =
X-Gm-Gg: ASbGncvm6lZJApLe2RfcqnaQDxLQt5Gj2CsxtAfZum6SCEpr37KWpneZavXOGCeZ5Ck
 SQk//9nSqcbT5Osyx8+ChvrG4HnEcvBP3qRbjQVYMiFve/2PFwtZWHbXFriQLCHFf1NUXuRFlPh
 lYwoimlFuBmxXb5CZLpLfGfyK8iqVFUP3GIgPzqCtySyiki0ScPsvpFPtAWY0ZcCU+jxPfIpKcr
 Cg2T2FgmITa+MwOhZEMx/3Je6bWJ6KayAaO4hg6Gt7Jyz67do95OPyLA12WpDjlU8+YjkQtQK90
 vEgOIthWE/26Xd43AQ==
X-Google-Smtp-Source: AGHT+IF8vJRm9aGWBeITl4V2jU5rP4SzvZTYenV4bQe9DuSKKad4EormdX+XoGyvVRb0wlwurKEAug==
X-Received: by 2002:a5e:974b:0:b0:841:99cb:776f with SMTP id
 ca18e2360f4ac-84cebf87cf2mr261254439f.6.1736434977610; 
 Thu, 09 Jan 2025 07:02:57 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b7463d0sm350530173.123.2025.01.09.07.02.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 07:02:54 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Adriano Cordova <adrianox@gmail.com>, Moritz Fischer <moritzf@google.com>,
 Patrick Wildt <pwildt@google.com>
Subject: [PATCH v4 2/7] efi_loader: Make efi_run_image() static
Date: Thu,  9 Jan 2025 08:02:39 -0700
Message-Id: <20250109150244.141173-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250109150244.141173-1-sjg@chromium.org>
References: <20250109150244.141173-1-sjg@chromium.org>
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

This function is not called from outside this file and has no entry in
the header file, so mark it static.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---

(no changes since v1)

 lib/efi_loader/efi_bootbin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index a97d3a025a2..428991df88f 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -159,7 +159,7 @@ void efi_set_bootdev(const char *dev, const char *devnr, const char *path,
  * @source_size:	size of the UEFI image
  * Return:		status code
  */
-efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
+static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
 {
 	efi_handle_t mem_handle = NULL, handle;
 	struct efi_device_path *file_path = NULL;
-- 
2.34.1

