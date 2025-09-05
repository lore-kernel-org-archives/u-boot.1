Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 594C0CA1017
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 20:54:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE64A838C5;
	Fri,  5 Sep 2025 22:53:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jJiQttbj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3CB18391E; Fri,  5 Sep 2025 22:53:56 +0200 (CEST)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com
 [IPv6:2607:f8b0:4864:20::92d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB10783930
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 22:53:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-8972e215df9so718048241.1
 for <u-boot@lists.denx.de>; Fri, 05 Sep 2025 13:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757105633; x=1757710433; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6A59u5+J80G2FT4HMGbgN+1muuphaz6EBi3mpQ1vmK4=;
 b=jJiQttbjxVm0XWsBZ7mWZirfdNRK1EnxGOZMwF/olemrftwn83qA/PExQjTfvgl84e
 4vM6gPRqgMHuSdcHsLQvmlqssjVH4EDZN2tFWrSBaEt7Vq7POOq0/r/Wu3YOCAqdWgFL
 W6rJJHqaEYOin4HBjciz1Aq/dRNDE+4JuxPvnULb2wDmXtXcMdo2pJXjmZoTMy4reYI7
 ILc1xGTH6Aqcw29w1NROsw+8UjyFl4VnzNTFFio8pwCkABUkahJitzrJ6mLFzbVH1Qg0
 NXi1soEZOP50v4Ev6zIPaY+TJzMYZUKOuaVslwL8PLbvQBGqI5wofQupfHl0nVmVDs1V
 4GSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757105633; x=1757710433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6A59u5+J80G2FT4HMGbgN+1muuphaz6EBi3mpQ1vmK4=;
 b=LK1AkMi49IyQatI37/+zndttZxxaYtR5TSN8TTirLdcAkgUvzR6quT89FQJ2ocRpaU
 86n8rmEObxW0hRGkiM0somO9Mz1CKZOzwh21CqHdLC592jwbcjXgBWNeKUlcmkRmYiqs
 l0lZbuckaDe0c6poZL7zyj+iGzBX+tktxj/iOcCdZn/dBoZ0mmRy4AQESdhkfgNIWVqn
 CH8tKpKLh8iM06y/1UeZYjoUUqzeFk02bKky0En3PNdpfngh4jTi0LvyJnJhd1jL6R0v
 ocOW1sYFj4MB1yBHVZcdlQG0S0ssEaQCl1lFhQa6rNXGQI6he+OMiQXNaAjY4E0j9b1U
 nbQg==
X-Gm-Message-State: AOJu0YyiacHgr9kCAI9Hmp+NoTa6W9mK4tUGBOLIjzoJR9dpZ2gAW3DN
 YB5RTmRsp8IqFFFUkJtc22ZDNcTFTIXArbvbuhN67BrurxOrvT4XVw7LlfQKHUQN41OTe+1bl+f
 7lZO1
X-Gm-Gg: ASbGncsSDbRlHpfWGH1ZInAwE10UyotMXj7jrAR8tVLCSEmqIlHWyhc0Kt8+DgwrNw4
 FVIfrB405bD3AzooIgoVvmPcZmHu9qSr4keydoeiL3DwWXuGSxvVXXks8pQQAEAlm175hdsv2gx
 M2kij2OW3gGzppf9mnnRZH5kJfU3gf8izBNWCFaIE+WI7ONe2vkWPy5zrsrHH0qY9833tnYOykV
 +NtRPLpoHZqqrYbIJOAl+OvSm4YT2musIcpZLNrO0s+OwZHrH4a8eftGhpd0ZY3txYiAZe6TKK+
 zDwViLFg9OkkhiuOfFBR6VbhrofDI+VC6f067ANtpQ9AYldZs9e5mLHalm204UH8IpPnpDSPaNj
 szivFaIBv2vacKkRJZR7AO19OtN5cIUMwyGbatdUmEgV7pxfopeRbTxGtmHs=
X-Google-Smtp-Source: AGHT+IHtvHRmxnzUpWiDxcdeCCms2lPKokVQw1roU5qE67y9+Lc1FM/Kf1RRr1IGQ2OrcZvyz0Y/0g==
X-Received: by 2002:a05:6102:4a95:b0:523:712d:4499 with SMTP id
 ada2fe7eead31-53d150735f1mr131010137.26.1757105633313; 
 Fri, 05 Sep 2025 13:53:53 -0700 (PDT)
Received: from jetm-rog-crosshair-hero-x870e ([177.93.10.181])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-52aef459c9asm8395330137.1.2025.09.05.13.53.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 13:53:52 -0700 (PDT)
From: Javier Tia <javier.tia@linaro.org>
To: u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 2/4] tools: zynqmp_psu_init_minimize.sh: Switch to
 clang-format
Date: Fri,  5 Sep 2025 14:53:45 -0600
Message-ID: <20250905205349.127333-3-javier.tia@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905205349.127333-1-javier.tia@linaro.org>
References: <20250905205349.127333-1-javier.tia@linaro.org>
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

Replace the use of scripts/Lindent with clang-format in
zynqmp_psu_init_minimize.sh. This change is made to align with the rest
of the codebase that uses clang-format for code formatting. This ensures
consistency across all scripts in terms of code style and formatting.

Tested-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Javier Tia <javier.tia@linaro.org>
---
 tools/zynqmp_psu_init_minimize.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/zynqmp_psu_init_minimize.sh b/tools/zynqmp_psu_init_minimize.sh
index 5c8b73703bf..f8b729ebc97 100755
--- a/tools/zynqmp_psu_init_minimize.sh
+++ b/tools/zynqmp_psu_init_minimize.sh
@@ -82,7 +82,7 @@ for i in $FUNCS_TO_REMOVE; do
 sed -i "/$i/,/^}$/d" ${OUT}
 done
 
-scripts/Lindent ${OUT}
+clang-format -i -style=file ${OUT}
 
 # Prepend 'static' to internal functions
 sed -i 's/^.*data(void)$/static &/g' ${OUT}
-- 
2.51.0

