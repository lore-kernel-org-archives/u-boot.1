Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF6DC3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:48:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D3E88215E;
	Fri,  2 May 2025 16:47:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JEuWjPfD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 239768288D; Fri,  2 May 2025 16:47:35 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F27EC81F7E
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:47:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-85b3f92c8f8so250615439f.1
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197251; x=1746802051; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YoOVsigCLlaoRTBOde1EyGWEv51cbWXlW0oyV9m1/sM=;
 b=JEuWjPfDViLdtbUHfB1yeSNSVjz01YGfnc4KQLmIJlMYRIoK9cnvyIEJb1OZ4Qhce6
 q+MiXI6+9UNxNBy/HTeMDXWeEjuLi2/setl2qYw6ddyHssOMuMMw+1LhuxM/vi3BevhO
 EGj299zJAkeoupYKdWnnVuwgwpBWi5jPalw68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197251; x=1746802051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YoOVsigCLlaoRTBOde1EyGWEv51cbWXlW0oyV9m1/sM=;
 b=Qh8WSWX+Nrrtf5KtoIZZc1LzWMr+ld6eKdB26RbC4YrgWtVErFl1A8Ka86xots+y52
 1rgS0l+zx0mqgkB88BjtdrqLxzQaEltjcD84WE59zAufrhPKTv8sZL1SVMklZvW+2DqE
 E3ByfEcLx6qN28pn8HoJ/WHDMOaCx3ah2EncUs5hZJrSWI3vBJMCOpNg8SXG+o1ZG73u
 V6uPRWD69Y/RPiqcEU3NikcHqn9tbbFED5SVCMF+GHUyCRK/Ynvd3sBHvsW9AhFBOy06
 DUAzz9cD2J+fXwhLOgOegnOTaGhBIfaxi0CDMj8pEMTLeV0RO0A8KMAIvPvanEgtA0aV
 ofBQ==
X-Gm-Message-State: AOJu0Yz+ZSQf48CdR6erHUVqkUkVqqUaqpIxWwyYXK0MCPuxcxvhg/gm
 Y08m1Ix3UwP+OcOFrA00uGnhKyoCF/KcLXyDglfCFUZHt7zMdCzSC3rtEbopEMPwEdv0s79oies
 =
X-Gm-Gg: ASbGnctk6rReBnVAENwX8poOWhWKKMR6pYHVAcUFBYAcl2HNZa8n4Jyk/JcB3Tcel+g
 zp0TCoVjzTzZwYBV2Ps9jeFngkambiyJABVnAKa5/tEkpBuYGF8gq58/Kow2IysxH1oQKvMI+I7
 mRwxkrnO01Wht7ChhXWbdh5N4hmWR2OX6UP6HvkmDUJHasD+oxBg4AqK6Yy4cbgFMRAXSziyDkY
 s/5UefmWm0IGe93PaOZBX/fv1YAKAk7Qx1e+28cEf5S6vHGYDN0vQ0ACovAJCxPg6tY1c0uzrBZ
 n8QEZ+IeelcKmH0thgFmDU4PULRD9TdYKlI1x25UHHUqhe2FCdju0nqvfzrsFiO8JnAcvXgMulv
 F7w==
X-Google-Smtp-Source: AGHT+IGKeTlpCYy+KapUmgkj3J1b3Hxy3B13rL8kMUOO2Bz4bnk9TYGLsD0DX10kUT7PMuUJT9c0YA==
X-Received: by 2002:a05:6602:c86:b0:85b:58b0:7ac9 with SMTP id
 ca18e2360f4ac-866b46673f1mr422927739f.10.1746197251229; 
 Fri, 02 May 2025 07:47:31 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.47.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:47:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Moritz Fischer <moritzf@google.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 04/60] sandbox: Select white-on-black
Date: Fri,  2 May 2025 08:46:02 -0600
Message-ID: <20250502144718.313633-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250502144718.313633-1-sjg@chromium.org>
References: <20250502144718.313633-1-sjg@chromium.org>
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

Use white on black for the expo menu as it is easier on the eyes.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/sandbox/dts/test.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index caec8c8fd01..2087c91285c 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -130,6 +130,7 @@
 			font-size = <30>;
 			menu-inset = <3>;
 			menuitem-gap-y = <1>;
+			white-on-black;
 		};
 
 		cedit-theme {
-- 
2.43.0

