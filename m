Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEBA5CD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 12:41:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 263058485F;
	Tue, 26 May 2026 14:40:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=binarly.io header.i=@binarly.io header.b="aRCqU+HJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E018083FF5; Tue, 26 May 2026 12:55:46 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEF1580433
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 12:55:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anton@binarly.io
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-8be236ce888so101915476d6.3
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 03:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=binarly.io; s=google; t=1779792944; x=1780397744; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DRFU48Hrrfhwj8Rkew8Ypn5UziuB4dEfALhC5FGA5Mo=;
 b=aRCqU+HJMuM4Q2u1vYC6Vg6g18+cOqyQ0d7MFKTKAvbSJ7w2K16nNDkhuJCtfwkC68
 IiEtMa08ffKdhC53noIdRAP4vR5rU3BUaGsITGWFJfDnd4lN2uyOb7bnQz5hD5nkJvKT
 i4sqOTxNyU7LO8HliwCeyRiz7uKHRH6P07eVKjUOyG/iZRUv4oM2WKlf0NZpksmJ0BNV
 OjNLHLtd98cqpnDo6J2Sv6fHJKgqKibRgJChEjmNiWUv11d14VN5nGSC39svplkZfIwO
 9sxTx/3tBrsAra9Inkc7JqvVcKy8LLOfhbb1RvfNsE8hEaKkQm3/S75LQ3qNtMtN+wb+
 zUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779792944; x=1780397744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DRFU48Hrrfhwj8Rkew8Ypn5UziuB4dEfALhC5FGA5Mo=;
 b=h2Y4FmjxKioaOciqaMIERVV2KOKzUC1ic+tp9TwsXrUYAt3xO+odse3GpQHTQ+zwNh
 wTAMWcLOtRIBDcNNBie6FLnWEZNWznxRjMxIAarsZQbE97UQguu/PCcFd4VjQg0D4nSd
 JEEaZGmUEbG+gfmXtFS/AjAh/mDjogxzeen0ZKEQ0scUpepRxRxwEIG5+aC/C/hZN8bJ
 2N+VpM3atYeUtfRtvoT0dYilPz1D6XbwWKnbR4M2I9EQspqsMghH+gpI7C1ojWFhRhTg
 ywdDJ/3DEifZLMc/L1V9GORVfs61J7lh9FmcIauvl5Ug9zO3hNRGp+lcdCKY1CQF/H45
 so1w==
X-Gm-Message-State: AOJu0Yw5TctgY8bUCsrmBA5BpwoDxFA7m1VxikW7pOgqGW19L0flsKH5
 9z60/tsBJQIGqdLEHZAHetulT8Mu8zio8qURP4evw8DHOD3oBUN+HjZfiJllLjzGyRW7m5qREB6
 yjdx2gXE=
X-Gm-Gg: Acq92OFe93FoaTa4wU639xH5DVIZDQv2Re0ALVd1Cw2QggYlgoTxUVtB7EpGJALdDNY
 KVfUCwElHLWHarV9w0dVIqdWCQsspZHVQa8OWCFFT+I0PUPGPFYtuYs5SGlrExv5Kds2DK26lvk
 GPDCfo1JlqZBNxpUKO/ajLMKafGsFnaGc3g+TjN4aam+XGdhTxlI6m/DMjgz1HvL6uGyFkqTJo2
 h+p6ECZlJJQ+YGbfZulvjYZcH3sLMxOnZYXcbM6U76J53qnhq1PucAqxd92V2Yp4ULK9O0d9vMi
 j0C4KHL4S6Jr5yJyGkP+T18xcoDewDHJ4cpBNblnRtCUAQHS/f5dMRemHNleXBVFX9HaHfA7r9M
 XQwlKSdyG679YMw57z918LnGShf0fIXrNQOTTe8cOxgdOy/+BfbF4vKBC84eM24lx0sVkjSMlLx
 q5FnJbFSMhFCM52WvRI15qrPEi1F+rbm5ZAhE6uncsCokSottyED3iGCeJ
X-Received: by 2002:a05:622a:4a0d:b0:509:44c3:5ffa with SMTP id
 d75a77b69052e-516d4666746mr281099571cf.52.1779792943654; 
 Tue, 26 May 2026 03:55:43 -0700 (PDT)
Received: from localhost.localdomain ([93.174.85.138])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bddc3259710sm483778466b.24.2026.05.26.03.55.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 May 2026 03:55:42 -0700 (PDT)
From: Anton Ivanov <anton@binarly.io>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	vr@binarly.io
Subject: [PATCH v2] image-fit: Validate external data offset and size
Date: Tue, 26 May 2026 11:55:39 +0100
Message-ID: <20260526105539.50736-1-anton@binarly.io>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260522123024.6292-4-anton@binarly.io>
References: <20260522123024.6292-4-anton@binarly.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 26 May 2026 14:40:44 +0200
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

From: Binarly Vulnerability Research <vr@binarly.io>

fit_image_get_data() uses the data-position, data-offset, and
data-size FIT properties without bounds checking. A crafted FIT
image can specify values that cause out-of-bounds reads during
hash calculation for signature verification.

Validate that the external data offset and size are non-negative,
and that the data region fits within the FIT image bounds.

Signed-off-by: Binarly Vulnerability Research <vr@binarly.io>
---
Changes in v2:
- Rewrite commit message to be concise per maintainer feedback

 boot/image-fit.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index b0fcaf6e17f..4d0e8ffc79f 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -1084,8 +1084,24 @@ int fit_image_get_data(const void *fit, int noffset, const void **data,
 
 	if (external_data) {
 		debug("External Data\n");
+		if (offset < 0 || offset > UINTPTR_MAX - (uintptr_t)fit) {
+			printf("Invalid external data offset: %d\n", offset);
+			return -1;
+		}
+
 		ret = fit_image_get_data_size(fit, noffset, &len);
 		if (!ret) {
+			if (len < 0) {
+				printf("Invalid external data size: %d\n", len);
+				return -1;
+			}
+#if CONFIG_IS_ENABLED(FIT_SIGNATURE)
+			if (len > CONFIG_VAL(FIT_SIGNATURE_MAX_SIZE) - offset) {
+				printf("FIT external data is out of bounds (offset=%d, size=%d)\n",
+				       offset, len);
+				return -1;
+			}
+#endif
 			*data = fit + offset;
 			*size = len;
 		}
-- 
2.53.0
