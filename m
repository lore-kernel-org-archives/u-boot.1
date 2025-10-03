Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44542CAC5B0
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 22:27:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D2EE8387E;
	Sat,  4 Oct 2025 00:27:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kbKNZhqE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9775083887; Sat,  4 Oct 2025 00:27:19 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0662A8381D
 for <u-boot@lists.denx.de>; Sat,  4 Oct 2025 00:27:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-638135d9f65so1131176eaf.0
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 15:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759530436; x=1760135236; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TWRrkXJRYY257eBlNlAr3KjpMGDK4g102XSzMxbEKFk=;
 b=kbKNZhqENoCq9sTHKhLFgSIebbawX6sKumo2uxObUPP4J+zQE1nCcrxoiwk2zk8O7I
 64n++INVgvMIR3xeBxSh9b6LqtURBbCLFLehoA12VlJgYI7RsVnAwRdk2ynHCYST/E5e
 B7nGDp29fBINXPccJcMKMTeZCNjztGkpeCHDlV3nBFgYpo+B9ppU+a5+FIl7Xad9+E6G
 P7/hqKJBBqoOpNZuoQTiwzZMyd1mUNvMDlitl8knmv2RsrOwDbUBwFNe938BOuR1PMIJ
 X9v7AKPBeiXEejNNjngmBERGd1aQdHs0Ho8jImHcRf+n2NZUKsoSKH5LlqPt37QOg20O
 k9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759530436; x=1760135236;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TWRrkXJRYY257eBlNlAr3KjpMGDK4g102XSzMxbEKFk=;
 b=VAQ8/nyw/9/ov4jZ4LKAey/t0B3xS8maoZ8+6wtcaVZl41QMmjWl3PwbFZObFiODSv
 IXTBQx1aCqBIgkV0f8T1j73zUzYBN7Evqh2GzOyWC7WZiEGaS2Q8JyvggzCwkiKFhvVR
 Kos5/mk+xfcFM9nAhdohxwaRrS/h9ztPipS1nsv1XxxKRU+PaHy4sBgRebhMzkNV9nlD
 TiDpkpSJe5swVW4mZkduqnYpx+5kZVg0bg+w0Fq7yXnsF5MNvUDpSKjO9RH4pIP3itTg
 f771z/rS/ezaD+2tbpK6V1hCWKk97GEt2R2iUyHcciEi0uKkDf7AFhNYGHvmUZwY2zai
 c18g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5jTbRkSFIPMu55FMeGD0kNhsuww+3tLnbj4mtsPVjoa9Ka8Kyqsvz5ZoKKaUEkvcKCfkBc9E=@lists.denx.de
X-Gm-Message-State: AOJu0YwsuwQxtTLvYUOnQl0BaSwEVy6cncFdIOgsEH3F8NeeM9uTaicV
 MIikvOCL/IjuXzSIg0sBmHE8OKo+pKrPwB2K6oS11QV69V4MBhHa8K79UDS/EWPB4t0=
X-Gm-Gg: ASbGncugEHl0okrpG2QLJjOjc7ZAPEyerQSV0SlFmEd3YD/gDfVezMJIK5UVyvPLfHI
 2DMkwPqEDjsuoSWX1MK7xiloDpVQAHuDJ6xmGx4jyrmh4wC+VRV0ewRIRcTWkna4M8fqo0NDKjb
 fkJZ6i/jhG30sEKDPEbCBNmQ8+uctwRJjccQiduBOdoocr+7raTQWA1E/uuOw0BP4IxYNl4ro+Y
 MhU9FZzzO0z34Y625tHa1+sgWRVbQOGUsZZxhhBBisvjaS1/Gjs7npfwNITCjc2xtAkajGYXtmk
 buFAt3meHv1HRa1jAXL5HUR/OUqIqUi+sq+DNJSBs7qnOorj62rU6c5dHZiQ3x5sY+cwjzbExph
 u3lQTK22LtjjABRDhaX8BHLd3wOc6DyA46zxUEvwA5RWptrt27UrD/Qed3VEdfnhV
X-Google-Smtp-Source: AGHT+IGB9ACwiDWBqAV7xtqyrApgqRqeT9HprJIi3X3T8Cd8nVUgrEtdlTobKi+VXk7oJQe2H4ghQA==
X-Received: by 2002:a05:6870:a114:b0:315:8985:d81c with SMTP id
 586e51a60fabf-3b11ad3fe23mr2417412fac.11.1759530435691; 
 Fri, 03 Oct 2025 15:27:15 -0700 (PDT)
Received: from localhost ([136.49.61.16]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ab913db5fcsm1911814fac.22.2025.10.03.15.27.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 15:27:15 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH] bootstd: Fix bootflow info for efi_mgr
Date: Fri,  3 Oct 2025 17:27:14 -0500
Message-Id: <20251003222714.4921-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
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

A "Synchronous Abort" CPU exception happens on an attempt to run the
"bootflow info" command for a global boot method (e.g. efi_mgr):

    => bootflow select 0
    => bootflow info

    "Synchronous Abort" handler, esr 0x96000006, far 0x8

It happens because do_bootflow_info() tries to dereference bflow->dev,
which is NULL in case of efi_mgr. Add the corresponding check to prevent
this NULL pointer dereference and make "bootflow info" command work
properly for global boot methods.

Fixes: 2d653f686b6d ("bootstd: Add a bootflow command")
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 cmd/bootflow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/bootflow.c b/cmd/bootflow.c
index 551dffbb8b89..081f64e12ce9 100644
--- a/cmd/bootflow.c
+++ b/cmd/bootflow.c
@@ -404,7 +404,7 @@ static int do_bootflow_info(struct cmd_tbl *cmdtp, int flag, int argc,
 	}
 
 	printf("Name:      %s\n", bflow->name);
-	printf("Device:    %s\n", bflow->dev->name);
+	printf("Device:    %s\n", bflow->dev ? bflow->dev->name : "(none)");
 	printf("Block dev: %s\n", bflow->blk ? bflow->blk->name : "(none)");
 	printf("Method:    %s\n", bflow->method->name);
 	printf("State:     %s\n", bootflow_state_get_name(bflow->state));

base-commit: d33b21b7e261691e8d6613a24cc9b0ececba3b01
-- 
2.39.5

