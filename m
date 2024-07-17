Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F879C3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 15:58:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F64988A82;
	Wed, 17 Jul 2024 17:57:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HKSqk/Wa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CAE788A91; Wed, 17 Jul 2024 17:57:26 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 678CA88602
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 17:57:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-368380828d6so526795f8f.1
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 08:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721231843; x=1721836643; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xaBB5sgSYz9Ukl/IWhLwKPEgiKlNC755XNbBGwb2KfU=;
 b=HKSqk/WaKTDiflipHbhxD+bAyxw706wdSXtai3fM1STYC0YP5AFCPgINmHKgtLkXhk
 NccEO9VDSarlbmaiLzW1lPV/N9kPe6XRxpzLhq75wRX95orDwLhnYLaZGO8eTb8xPgPM
 yLRUSpLlcUfc6q/NvUPNT7ehGhMUuhZyRa62k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721231843; x=1721836643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xaBB5sgSYz9Ukl/IWhLwKPEgiKlNC755XNbBGwb2KfU=;
 b=oD+l5BUaufWSCPXwEYJosN4fhNbstULz+o5l0moLP9MSuPw19lZZxfAsjXSjXAC9lg
 SsO1na9ATt7Qpzn9SUqWKnWKC1hW30uScmRxWDtfLEwDpY4G3cBR0/ZjlLCmMIP6g8xr
 ycvNLvVhNgdJkU+7/sQz+EptRmZcQdnbeD7un8PAZ/a/yVgkEDUN1osvIFGaFQ+rSMAU
 L5KCFaeXLZoDuzmKi4Awkm2B0eMzet5l7JK7iEykf6v3D9WTs0V9aP9SrgU1BptM9bBU
 NPP29jSl5jk4q1eBifGa5MC2Qe1v7Rr0H9MzaLenhT1qxh03yFNofjn7+NoIy90zpbzX
 xvfw==
X-Gm-Message-State: AOJu0Ywkk6Olno0SlbPyiOgtzBT64wmYO6sZXyrzNnpfmgjqFEbKCUOY
 08ldws5OLJLq1NO+mbY7almvHXTCmert6jK8tMajcExIZSx0Hc6leGg0ccfzyyLt13Qw2kgJkNM
 =
X-Google-Smtp-Source: AGHT+IHyBz3YtCElepcUTW30MRtiCbD8erbIDKMH4CXa/NrHyP7hv/JOlWQmJubkSLVfuYdmtFVpsA==
X-Received: by 2002:a5d:58f5:0:b0:35f:48e:fe59 with SMTP id
 ffacd0b85a97d-368317c88ebmr1267945f8f.66.1721231842706; 
 Wed, 17 Jul 2024 08:57:22 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafb877sm12173958f8f.69.2024.07.17.08.57.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 08:57:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 06/24] qconfig: Rename the doc link
Date: Wed, 17 Jul 2024 16:56:54 +0100
Message-Id: <20240717155712.2913651-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240717155712.2913651-1-sjg@chromium.org>
References: <20240717155712.2913651-1-sjg@chromium.org>
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

This was missed during the renaming of the tool. Fix it.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: ea4d6dead37 ("moveconfig: Rename the tool to qconfig")
---

 tools/qconfig.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/qconfig.py b/tools/qconfig.py
index 8a2384d895b..07d78387465 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -3,7 +3,7 @@
 
 """Build and query a Kconfig database for boards.
 
-See doc/develop/moveconfig.rst for documentation.
+See doc/develop/qconfig.rst for documentation.
 
 Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 Author: Simon Glass <sjg@chromium.org>
-- 
2.34.1

