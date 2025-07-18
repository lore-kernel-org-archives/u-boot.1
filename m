Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F37C83F1A
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 12:20:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E90B83655;
	Fri, 18 Jul 2025 14:19:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cYyyRr/+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B60618365E; Fri, 18 Jul 2025 14:19:57 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E38983623
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 14:19:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3b611665b96so1109364f8f.2
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 05:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752841195; x=1753445995; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EoxPV6TnrvvQ0ok6/UtvhX21TdTEcshWZPoYLn9AeeI=;
 b=cYyyRr/+ZMEOuPbD92Hw1OaxgpXIRM1GDyXdTn4/1NGp7lc7s2dIT6SqTrQDA4+3r0
 hJuCCOb4R2BbqVkSb24+URLyhj29u04EM6+TpU7md6mHkN/tJAjqHVH/E/g0zO8C6onb
 7AqXyfwtcSUQ4FX4tCk9NTjz8POiff5ioLIAaKse6CaBRFcxhmd4AC7e+bMWQ41zial6
 bft3Gmx11i56+UGHAuB4kBew1qqd4T93snvCiMkaHJB0GnIx8qItlE0hzoYPnbJR+KeO
 FwbcaV5JZjFy42XX8YGLTwcVOvuQ5Kp3e86nQtzHRP2u+tdCbtfgFVzcCOTg3ST08Cim
 qkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752841195; x=1753445995;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EoxPV6TnrvvQ0ok6/UtvhX21TdTEcshWZPoYLn9AeeI=;
 b=h0IXCXO81PoV1sAiLvTC8Jrh1S4O8glwrLDK494cIkIafzDkkrrfeK3/Zq+CbR55Ba
 zBf0ctOvUDNnJ/9d59oiWqWQl0d7T8LLS09uO8ZQv1eHhVmlghefySIC3cWIfqlGLko0
 hG+3jq8SvZbXKi7wKch6Nv5045u5CWnPOIeMuagU47PlG8rfFtKIYPKPu4jGkR3n0pgE
 K5NOvPOXQPeNX+u7L+5Zdfq6hMs5TDPAFgV2qSZeeEG76B+2xKzshG9B60IHbn6SJCbs
 /r4Z+Tqr4n8pEG/tj9MH5vrScaqsk5f4oZs11LcWSYx/l8O6TkpWDbTk7uVqS+jsPaLI
 6HKA==
X-Gm-Message-State: AOJu0YzU0DUdqZ0d2z7/71zhWgcP1c9iinjHRbmSEJuzUmaTjMKITW+K
 L7elEQI75F/UR4VrhVgTHObR7MwQjsQ+FmS0CczPY0benesLyLVr2rYfsAnhsIHwUN8=
X-Gm-Gg: ASbGnctim+7STTmH7LrBISfTC/l2URXUWjDOycuIKRhd4mvIH7Kzg1X33TDdEZkKjpx
 nb9zP0ICC7dGOcL7KzAueT/+tDSRRX9DyyZWP1m6dMFkMwIcg2Lq89mXj0zk70cyQqs8EICv7LF
 y1Jl/rRmNs2n9Y/R1qNzIF3+c+I9N1NKz/Qa95vurl8ZbeF5SMAuI8kts3vZNO55ewPjqs7/SJ9
 /n6pTJlsyac/2Stg8EIru2hYIDsu81a/EZ8aefRQnIO4F3/kD+wnkxGe9Th8KsAN+rZBIg6bsfp
 vqAx5nN9oRm/ltYCfjCoX093cxYfBqMZHUOCE2szAdroA7JTRMuTc0qPO2jU4tryHQApi10/60I
 Qb9jWXeNFHkN/jaF14ngvhXqS9OaLG1KIb+MvA2Hh4NJXneWMktQ=
X-Google-Smtp-Source: AGHT+IHmsNDczM1dtu3XbPuNZ8UktTjypn46R5Wny/q+lqP7b7VoZ3O1BrGGfnhHUQ7U7m2mHdAvfQ==
X-Received: by 2002:a05:6000:2013:b0:3a4:e8bc:594 with SMTP id
 ffacd0b85a97d-3b60e4c5132mr7930973f8f.8.1752841194710; 
 Fri, 18 Jul 2025 05:19:54 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:eb9:1701:ef2b:6c47:de09:6843])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca4894asm1706494f8f.49.2025.07.18.05.19.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 05:19:54 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Fri, 18 Jul 2025 13:19:54 +0100
Subject: [PATCH] spl: NULL check variable before dereference
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-spl_loader-v1-1-835ff557b9f4@linaro.org>
X-B4-Tracking: v=1; b=H4sIAOk7emgC/x2NXQqDMBAGryL73ICmf9qriJSN+VoXNMqulIJ49
 8Y+DsMwGxlUYPQoNlJ8xGROGapTQf3A6Q0nMTP50l/Le1U7W8bnOHOEOjRn9tFfbqEG5SCwwQX
 l1A9HMrGt0EMsipd8/5e22/cfuZrmAnUAAAA=
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In boot_from_devices the variable loader is not NULL checked after
assignment and before first use but later code does check it for NULL.
Add a NULL check before first use.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 common/spl/spl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index d8e26605d20..ed443c645a7 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -634,7 +634,7 @@ static int boot_from_devices(struct spl_image_info *spl_image,
 		if (CONFIG_IS_ENABLED(SHOW_ERRORS))
 			ret = -ENXIO;
 		for (loader = drv; loader != drv + n_ents; loader++) {
-			if (bootdev != loader->boot_device)
+			if (loader && bootdev != loader->boot_device)
 				continue;
 			if (!CONFIG_IS_ENABLED(SILENT_CONSOLE)) {
 				if (loader)

---
base-commit: 0f83825802d8938fb584c12f115bde900efe71c1
change-id: 20250718-spl_loader-e93a2d246b8e

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

