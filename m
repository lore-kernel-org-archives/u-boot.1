Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8FA3C021A0
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 22:23:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB9ED80C72;
	Wed, 12 Feb 2025 23:23:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pGOXvYxY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C47880C72; Wed, 12 Feb 2025 23:23:33 +0100 (CET)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58E40801DE
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 23:23:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-471b5372730so2078271cf.1
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 14:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739399010; x=1740003810; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WbcqE1f/TrYtCAcYxUwdnuh9fXUxAALyjprm1CQsxzE=;
 b=pGOXvYxYYz0lq8CStXMqJ6RQyI1AOhoISkerfWi5Ma+k9G9clVj37J5BPMqcJQ2a/E
 vzXbqFSKgSkbHrY+LL5T2/f/J0FqXOh1OKMzCy/64VB25SZD8APnl/x8A+g2G7Qn1oEl
 qfmOfQqsvBEsJHX/+lqw349cZDzwY+tu/v/Gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739399010; x=1740003810;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WbcqE1f/TrYtCAcYxUwdnuh9fXUxAALyjprm1CQsxzE=;
 b=CMzVy3shncyBWIbgz/XMVXTm8qDmGleaSDDf0Ux03X4ZnAwnYggTIh8RNQ8sfY/c1y
 /o6Ow3KWGo0ibifYq26i7VeXNgAEBcZKu2lKM4YD3NOdqnXkz8NWHQx0wRy8K+8U6wz7
 2/tkB8/C8gPUU1w2tQTNc+WYwFV24HCITXCiAMhROtxICzmOj2MktyIPzpOUmgb9yDUv
 wdg0gRWz0u+AKuDIAqVw0SOj1Lu/0LozW42IfoO6innz02WLnPSx8bIfgneGdR5nV60T
 5CdvSmbj9sU1yePXDQU5tlnivhgSUcsjEYH+Hhyr1zgxYV3/vm5AZLOXd7XxP61xJg0Z
 hsxQ==
X-Gm-Message-State: AOJu0Yxrih39zfHCeQ7hPTu+v2IZr2bJQvuetl02AeTE/p1Z70KmbKIp
 mw1IDe44Fi3bSA8zqUMgzkZkYVf16gEX333Th0+rskkNyct01zJ+BjtXxVMe37TVsSjnvlMBKt6
 v
X-Gm-Gg: ASbGncvXVLEGJSr95OGpnJwlGG3DTrPzeMDm1/3ktfCf0SpAGgkG8lZZrh3gyPNH0vB
 Jj4Bi3C17Vwi9oKHLWKr+aV/K24UaNsMvvYfMWHm/ksrBBhvkP5LjoLFbpuuZhIHl/N88X/7nde
 MXTiHgkM70dNswiYlNg72niX88dPA71eJxmosTpcJ2l5fi1lqVuRAVC+Q0e1H2SvHws0Eecud0V
 gL5yio2dDcRMho7SuXfNeiHxQ28tUlsvGAxlmGiq3sQ3w9JV9YwBP6o5KVV+BXEmVP8RUAy4wdt
 UQzy1JVdbi4iB0AUGA==
X-Google-Smtp-Source: AGHT+IFS02cVLTAZvzBY2yWvQel0mPhfi6qTsawq0ic3tsVkgJNYEjtazE3JUKufZV7+xGKrZUx+IA==
X-Received: by 2002:ac8:59c1:0:b0:471:aa83:b6b9 with SMTP id
 d75a77b69052e-471bed300eemr15429981cf.6.1739399010202; 
 Wed, 12 Feb 2025 14:23:30 -0800 (PST)
Received: from bill-the-cat.. ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-471837527c3sm57304741cf.47.2025.02.12.14.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2025 14:23:29 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH] buildman: Fix some newer pylint warnings
Date: Wed, 12 Feb 2025 16:23:28 -0600
Message-ID: <20250212222328.684416-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

With a newer pylint we get a warning about "color" or "col" being used
before assigned. This is most easily handled by setting them to None to
indicate no specific color is needed, only the default.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>
---
 tools/buildman/builder.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/buildman/builder.py b/tools/buildman/builder.py
index cbf1345281bf..492697310808 100644
--- a/tools/buildman/builder.py
+++ b/tools/buildman/builder.py
@@ -1093,6 +1093,7 @@ class Builder:
             printed_target = False
             for name in sorted(result):
                 diff = result[name]
+                color = None
                 if name.startswith('_'):
                     continue
                 if diff != 0:
@@ -1359,6 +1360,8 @@ class Builder:
                     col = self.col.RED
                 elif line[0] == 'c':
                     col = self.col.YELLOW
+                else:
+                    col = None
                 tprint('   ' + line, newline=True, colour=col)
 
         def _output_err_lines(err_lines, colour):
-- 
2.43.0

