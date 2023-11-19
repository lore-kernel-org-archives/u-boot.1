Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED00C072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 15:38:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5F0B870E7;
	Sun, 19 Nov 2023 16:36:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gmT7OjY1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20DC4869CA; Sun, 19 Nov 2023 16:36:34 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F25BB8714F
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 16:36:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7b06841efdcso151958939f.2
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 07:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700408176; x=1701012976; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pel2U1kgIvGpJvsWg703Hsr9FPfCAvRECTGPDM6G6SA=;
 b=gmT7OjY1rzP/nXSST1ljMXEe9vpddFlYfdsBcISDSDcyuMKJOmxq2auGUtQ2zucrwQ
 XtM/cSha5W8+zmy6lAMiXR1g522ocF6Qkab+AeY9UufV6gLf9Mi6hydEi45rB6TnsKjx
 H2gdwi7sSGeblDuROqkvCZ9wvi96+I0vwHH8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700408176; x=1701012976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pel2U1kgIvGpJvsWg703Hsr9FPfCAvRECTGPDM6G6SA=;
 b=k3atkP+bVPGeSkWN2mdE5sx1Z+3lul5XYkPvITftGE30jxdvZrioT9L28vteeAldXI
 W30/hfrwQO9liauSbc1ZYB6XYwZSSjKWuU7aqEiKt0d11LHAtDMJc7ImUvpWzyzJTKET
 PZaFhTkqanhwnEjQW5e8cv4gnW0Y2Wo87p1fmn+jZW41A25LdU76unVbYK+z0Vk8zMJY
 cI36emyrH+VpKoEPKOUR7bxG6I54rqEU2fYSy4LvHnGxwWqIeCep4vkxIcXPufWRN/Qq
 X84QBl2NjZNGN/r/v9y7sn8FEs0UmQe1AQfwFmJxRpnARsRdM9eq/Ds/vYt7Ev1M+Iun
 JDcg==
X-Gm-Message-State: AOJu0YzVF1ifst0PTs26sx8csehfMUyg67wRjuvsViRAnSXnTMfBRzXv
 YxrKy/jOaG4VMv2B06KBxIczVg3+2/Mw0+UuTTg2lQ==
X-Google-Smtp-Source: AGHT+IGuhr7haH2GatsIg/VULRpfT1h1T8o94TA4N4PwAuduXO9KDx5OqkO/kiahTeQHWCjYip6lVQ==
X-Received: by 2002:a05:6602:641e:b0:7b0:1bbf:b050 with SMTP id
 gn30-20020a056602641e00b007b01bbfb050mr7893293iob.1.1700408176612; 
 Sun, 19 Nov 2023 07:36:16 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 19-20020a0566380a5300b0046456924383sm1466712jap.73.2023.11.19.07.36.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 07:36:16 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH 5/7] tools/make_pip: Add mention of u_boot_pylib in tool list
Date: Sun, 19 Nov 2023 08:36:04 -0700
Message-ID: <20231119153611.639252-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231119153611.639252-1-sjg@chromium.org>
References: <20231119153611.639252-1-sjg@chromium.org>
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

This is not a tool but it is handled by the script, so update the help
to include it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 scripts/make_pip.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/make_pip.sh b/scripts/make_pip.sh
index 25a4049271c9..d2639ffd6e43 100755
--- a/scripts/make_pip.sh
+++ b/scripts/make_pip.sh
@@ -39,7 +39,7 @@ flags="$*"
 if [[ "${tool}" =~ ^(patman|buildman|dtoc|binman|u_boot_pylib)$ ]]; then
 	echo "Building dist package for tool ${tool}"
 else
-	echo "Unknown tool ${tool}: use patman, buildman, dtoc or binman"
+	echo "Unknown tool ${tool}: use u_boot_pylib, patman, buildman, dtoc or binman"
 	exit 1
 fi
 
-- 
2.43.0.rc0.421.g78406f8d94-goog

