Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2239FC3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 10:50:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B322887FF;
	Sat, 20 Jul 2024 12:50:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Hswkhukx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 095B8887F5; Sat, 20 Jul 2024 12:50:05 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BE8D886F3
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 12:50:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-427b4c621b9so16842645e9.1
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 03:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721472601; x=1722077401; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DIuWAzFusG1pW3qaFVr2xSJcZPUvnNdPkoF845RKU6k=;
 b=HswkhukxBFBqF0Damx7IJ7psso4mc4Q6axCxuXOub/Ty1KdCaAdynEOcvEwjEoy+zk
 cL2t5lhfldFp15DPAjo53bgjZoYF7VlbUpgAXStAuIl+icYH6RfkZAmc7EOLBIG+EpIb
 5fm1wBb40kJoZpzVKM7F2+/0TACACyStI4EnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721472601; x=1722077401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DIuWAzFusG1pW3qaFVr2xSJcZPUvnNdPkoF845RKU6k=;
 b=ZGHwtpnPzoEYx8826TvFtbRI3j1DDqhugKai1MKG16pYvFXaLFV8N3uZJZ4Hdg5o9u
 ewSZKz2HpmvwE6/wQcdQA9YGSZM/6tHqxZuTBoASbQhNJ/ISxvSe0G0v4avn35p14atA
 d657MrYvqH1aIy8GhBSRmna3+TsZJb5wT4LaeuySh6nR0Bus+d2+1jZ5iBYXg4BHIV0L
 e/hafO/8rY/iPfPHaPE0LlnS4lJqZ+LiHyt1TXkxkxaRI6YvVqwPI9H5S5I/zeW/PuX6
 BPTf3L7N2vnUz6NP/TmmUHa8dMJoJSRSEUcrR3Xk+x50wsB6V0tMx5iWD8w3KdtXBi1i
 gRpg==
X-Gm-Message-State: AOJu0Yxu5TOfUXYi/ud4YosK63t7SJk0+sAKIrKyaZN4DMXGzDD67COb
 gmEtbgX4dK7kfl+aug28vmb8iXS/XGjC2PVTC+1p4FDNfNAKKA9+vwg6GlnSDT2pwuC8zhJyk9Q
 =
X-Google-Smtp-Source: AGHT+IGDOItT0gqs4Trysk1R/UaqP3Y9mIFW2adHpwyjT3SwoPnC2ge2LH0NtsxM7DiE0qv+UvZVDA==
X-Received: by 2002:a05:6000:156e:b0:367:8f81:fa09 with SMTP id
 ffacd0b85a97d-369bb2a256dmr790657f8f.47.1721472601661; 
 Sat, 20 Jul 2024 03:50:01 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878684225sm3715616f8f.9.2024.07.20.03.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 03:50:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 01/20] fixdep: Support VPL
Date: Sat, 20 Jul 2024 11:49:31 +0100
Message-Id: <20240720104950.2730773-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240720104950.2730773-1-sjg@chromium.org>
References: <20240720104950.2730773-1-sjg@chromium.org>
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

Add VPL support in this tool.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: f86ca5ad8f7 ("Introduce Verifying Program Loader (VPL)")
---

 scripts/basic/fixdep.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/basic/fixdep.c b/scripts/basic/fixdep.c
index 5ced0f6b069..3d40bd7ee25 100644
--- a/scripts/basic/fixdep.c
+++ b/scripts/basic/fixdep.c
@@ -421,6 +421,8 @@ int main(int argc, char *argv[])
 		strcpy(tmp_buf, "SPL_");
 	else if (!strncmp(target, "tpl/", 4))
 		strcpy(tmp_buf, "TPL_");
+	else if (!strncmp(target, "vpl/", 4))
+		strcpy(tmp_buf, "VPL_");
 	/* end U-Boot hack */
 
 	xprintf("cmd_%s := %s\n\n", target, cmdline);
-- 
2.34.1

