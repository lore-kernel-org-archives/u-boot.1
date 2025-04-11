Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 535DEC36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 14:55:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 134F884129;
	Fri, 11 Apr 2025 16:55:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="K7c05cC4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C26368410C; Fri, 11 Apr 2025 16:55:36 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69D02840D8
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 16:55:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43edb40f357so18005495e9.0
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 07:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744383332; x=1744988132; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hUo/xxIeSk33E3I90k0hSLCkhtsyd01BxqbF5etgvbc=;
 b=K7c05cC4mZvhh5lOnkB5tRDMiE3bY5ZPcWads7oCgJohFnX4SIDF0iJLXRRY074VDP
 OF0kyOsXqjKJ1YYyuKsS4DBJjnQOkYAlIhyjdbGktoT2lzLJhk150sNEjEYq+MInoO8s
 rVeO0zLrGI9hgSSbB4dc7V9t7qnAKh4q/IefjR7iDiU4NJd7VOMMmcVZStdO3Gx4SqCj
 m+MMpUZqnphznOVaousBXlDqRENOt+EjFwNBGja6RcEbjoH1lFiCzjsnVObZEfxMhZKh
 duiekw5pXW82tbv7ltZJbDCuAIiFK18bza3cbr1eFGiC5AxYhkFGOomUweo81yY/WP5H
 wH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744383332; x=1744988132;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hUo/xxIeSk33E3I90k0hSLCkhtsyd01BxqbF5etgvbc=;
 b=kTGL8J6tibc7U3EbVxBomo2fhz/Phpguk3/kPF1g7GB84iZzM02dKtJGqgg+Y8givZ
 QtF8MJ7Z/wi5JxpsX3vyozkYcKE7Ean5M3aHfPOAx8cPbv+BwIXPN6SVqqT0BRDrMb66
 NNnhF6l6SVLttQq9cW5/aqNFz95o2cqGMv9MlrLGKPMllocxJGvBkJuCKIPNRLfcjbhJ
 r8LjQ3RuVhIo5F/UaM5Pi+GqrGrpZ+pPtczchCHeTfZCrOxJVRPLD/VFq5AiSE5VBPfm
 jLiQ0U/Eqx3faEnIo/ih6Yq+9Bcfs7Ux5ynEMcPTMoOPvQabeWzxtK4I5JTITGtB6dTt
 Echg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUEo6FPPTm4s/j4e6rYLkzJ14FTtDDpNepn6eBox2gMu4U6W/i0SNxodKlZ3yEe7/6Mbl1Op4=@lists.denx.de
X-Gm-Message-State: AOJu0Yy/kVEmsiYB0tv5LZ/7xKCneNNILPlFjTQuqQyHDKTXJIGrWmZw
 J9Cn6WBZE+/zIgEgqx8lxt9K7iS8kvSEuF5NIX+suAqqYpLyeddde6vA5vCHq+f6WLVrYyrfFNR
 U
X-Gm-Gg: ASbGncuQ9zFTcgyTnf2P/zpJrxWX8uRtiThMI2wzWHm+GsargD9t8qtm/nCgtRmVrRR
 wQHDc3eeq+acv/mRo+60xvD9R5XJrqa1qmmXZ/NZw0+pYpq3/zOJjPsxSq+U7u0vPS7OvqIU2x8
 FESm7rVjSTsfSgHD6xcENGJ5GDqxQgqMq6WLVuN5v2Cu0dGiBjE0TsmkqvLzdrBUJKo8Hpg+M5R
 t7n37cJPkaV7DP6bMK5O4PSY2NjsM+UItAoWdDK6qjSSiKcZL5f98IUUnnLW9phejT63Ms9f1By
 iFXZz8GUXUizBPnsddY+nxz6X56ueRM5HqmBz76Jl0ftg/nNdlbQp3XYj4fBNg==
X-Google-Smtp-Source: AGHT+IF/k6f2fGkNmHIgVGlQ1f/MaZ/0zcOcGbqg0q4shKj7Z7s64EaCKf9pJ0R/EbHh6An/F8peVg==
X-Received: by 2002:a05:6000:2912:b0:38f:37f3:5ca9 with SMTP id
 ffacd0b85a97d-39eaaec991cmr2093373f8f.50.1744383332690; 
 Fri, 11 Apr 2025 07:55:32 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eadda64ecsm2279119f8f.0.2025.04.11.07.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 07:55:32 -0700 (PDT)
From: neil.armstrong@linaro.org
Subject: [PATCH 0/2] ARM: meson: finally switch to livetree
Date: Fri, 11 Apr 2025 16:55:29 +0200
Message-Id: <20250411-u-boot-meson-livetree-v1-0-ebe31909cba5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGEt+WcC/x3M3QpAQBCG4VvRHJvaEZJbkQM/H6bY1S5Scu82h
 8/B+z4U4BWB6uQhj0uDOhshaULD0tkZrGM0ZSYrTC7CJ/fOHbwhOMurXjg8wNU0Sm86qUxZUmx
 3j0nv/9u07/sBpLNHOmcAAAA=
X-Change-ID: 20250411-u-boot-meson-livetree-8fd1b0a18066
To: Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Beniamino Galvani <b.galvani@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=722;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=nKOit0fq2sUwUDJGEK+Ty6gDjArDGGJQFnmD7JttoaQ=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBn+S1ief5B0clj1m4w8uR9SxA4QmMo/rUyCYIMcdsH
 MSqvNfGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ/ktYgAKCRB33NvayMhJ0XkuD/
 4ldkwg231SmVQrhULsImBA4yppSJvyjZEFdSN+/6j1PXQ0Ux5WmPShIE/eO5oXAGMkH48Y5A9a0mdK
 g6xYZvOTbT/FjP7MdCXKci/WV3r3jv7AIMCnRpB4MG+trboM1jhdlIdt5gcOLFyF7oeyJV4mgyCmpp
 hiAHYrd6nscp7ux2dJqrRSFRu48xZTPGgHrILz8/V+7852+iq8oNMemDg/9KNgWt7rWZei/XmXxzyd
 IXTSaO51VTkJ8SnGEaB9RryIxyMgxkNiHN6x83crq3l8WB5WMeVMiLHfISPWGlfXOLW2ClHGe129n1
 rli5oRWyocwcyO9ri06DopGG4CsyiVj9Z02SAWmZxpXoXeDtI9nbqERV0LMmOWOkWu0YrDvM/upovj
 JxB+yFMc6miBwxZMlkL8sB/mtD1WUr5x/YjErd5dJGhUI2OcGZn0yk/vIjVEDAOOh0sLEAlG4gcz2B
 DZGXFnFq8bx2Y51BRMrb9Va9sXOxAmCyA8ShHVwzPDVpFgglV4+IQLSBBxBqUAX+n+3zT71lYGFwMh
 DBEH5I3uIy71tmCrE4DLZv+fLoWE6FRi3CgRpXHeTlDl2rD/hv8cyu0SrBjbYjzyymzSzXsIcNsRYa
 tvub70OHCnUmH6nrVscIRiDUsX0QjWAYFiupBEtvAV++/dtFt5gQXD2/yNTw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Never late than never, finally try to land Beniamino's
"pinctrl: meson: convert to livetree" from 2017 to finally
be a modern platform with OF_LIVE !

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Beniamino Galvani (1):
      pinctrl: meson: convert to livetree

Neil Armstrong (1):
      ARM: mach-meson: use livetree by default

 arch/arm/mach-meson/Kconfig           |  1 +
 drivers/pinctrl/meson/pinctrl-meson.c | 73 +++++++++++++++++++----------------
 2 files changed, 40 insertions(+), 34 deletions(-)
---
base-commit: f892a7f397a66d8d09f418d1e0e06dfb48bac27d
change-id: 20250411-u-boot-meson-livetree-8fd1b0a18066

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

