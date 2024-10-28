Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56EE1D3399B
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 16:48:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 974EE890DF;
	Mon, 28 Oct 2024 17:48:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gt9AOa9O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 076A389098; Mon, 28 Oct 2024 17:48:51 +0100 (CET)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F06AB890D0
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 17:48:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-46090640f0cso38498021cf.0
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 09:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730134128; x=1730738928; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T5SStAwg7J4xaENIslg07NrYkUl2rVDrtBTx9qocrqM=;
 b=gt9AOa9O3j7QUyDcNmC9Xef+WOvWfppTn5z+i91pFXHv8QvKZasCzfOW4jXnV2xTAH
 Sod4um86/W5/vodLsky56EzQEeWDetxjVMU6dQK9/GFuqEx/vRYmqNwoEYskZhk0nKmS
 tymtEHM3ArDlvBZ7g0Zatx2tQ6LOHpTDs1yZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730134128; x=1730738928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T5SStAwg7J4xaENIslg07NrYkUl2rVDrtBTx9qocrqM=;
 b=ft28gYAkFUTStfBSr4KGLRkLe5D67jPD1dAT0BpTIisEBMZvFTtlLe78rffdsSAMTf
 RUu0qtMGDtmnLM7i8nD8JnlGQbC60kZW64u7txcDvpBueGhLywwLTMKeqSc85VFT2vSY
 9gCjjRdpZgXcIs5ucmTDNM49J2x7sMh/yYYpOFmyeFTUdlEdbME+IESZMHQwTljyxShR
 3QzgIasQJOesWIEvI/Yd+U/5oVgtIepBbqIFCWbL/PxJod0b5koAdYF4cyhQRZGwuA2w
 t7fW4lW4bL386R5i8wn92GHm7Yixey4DTt7u3/FToLA6n3fHO/r9JXl7bLJJwf8CcpRJ
 A3/Q==
X-Gm-Message-State: AOJu0Yyq80glzS/HfIuWw6h047mBCksN8ZzQa5SAamHmBRwwfHEFH9WD
 WasGB1+GShNnMO+irWEd9S88A4TbeNqA+c/tNADy3T9MxKtGdvxc8OX+V/jXnPdigL3qEuL7zzJ
 Ox2g=
X-Google-Smtp-Source: AGHT+IGU4zE8g5O3GdUL0Uq+0FxL79pOfAnlpjfsgiLrXkxAm73CG+BcDZ2ZV//ty1gyMpKLsmociQ==
X-Received: by 2002:a05:6214:5348:b0:6cf:b3b8:19bd with SMTP id
 6a1803df08f44-6d1856fb7d0mr169197956d6.27.1730134127657; 
 Mon, 28 Oct 2024 09:48:47 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.104.2])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d1798a8455sm34254486d6.32.2024.10.28.09.48.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 09:48:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH 2/3] test/hush: Add CONFIG_CONSOLE_RECORD where required
Date: Mon, 28 Oct 2024 10:48:43 -0600
Message-ID: <20241028164844.2308549-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028164844.2308549-1-trini@konsulko.com>
References: <20241028164844.2308549-1-trini@konsulko.com>
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

The "dollar" tests require CONFIG_CONSOLE_RECORD to be enabled so guard
with that.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 test/hush/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/test/hush/Makefile b/test/hush/Makefile
index a2d98815e501..4c3a0be857ae 100644
--- a/test/hush/Makefile
+++ b/test/hush/Makefile
@@ -5,6 +5,8 @@
 
 obj-y += cmd_ut_hush.o
 obj-y += if.o
+ifdef CONFIG_CONSOLE_RECORD
 obj-y += dollar.o
+endif
 obj-y += list.o
 obj-y += loop.o
-- 
2.43.0

