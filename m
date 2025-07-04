Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9243C8303D
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 12:32:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29FCD82A76;
	Fri,  4 Jul 2025 14:32:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WHOOvJBi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DB8482ED0; Fri,  4 Jul 2025 14:32:46 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0890F800D7
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 14:32:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4537fdec39fso2597255e9.0
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 05:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751632363; x=1752237163; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s+4lDWcRw8iWBg262ecXUgakXV9vB5EGmenijLnpD+E=;
 b=WHOOvJBig2JikK0+ZDk0soKIHpe3M0KH2aePCFOm2wq1MmNuxYgN3L9sNuFEhfLuUr
 vdwgf+2Hsm19MhOhXCcJZe4WhWf7a9RXB3CebBaaQxFbQPCCmu/p0VHdQoVcftrMve/6
 uccy0tGToqmmTqiiTGS+/k0hRjclZN/8me9fyErMmies0Vfzdz1m4a/X4ZxvlrrDcobI
 YNZ31sqm0myMDEXW4JJUBpZeW15OgRh4RG8kAJFzbZXpruJQog1Q54kiufRZk35QdZgG
 7g6151FNWth2atwKMhMvQn7tn7+tGikF/plWoAukdl+Qzey2o9300kpaNWbVNeh88KGm
 m1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751632363; x=1752237163;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s+4lDWcRw8iWBg262ecXUgakXV9vB5EGmenijLnpD+E=;
 b=Cf0Tg3/TCqTM+fcTnj8qnuCah6bbA3NEnl5yaCjeHCoZ1upocVpytHatgUZINjW22E
 LJuH6fLtWLVe80b9qS4ZG3lp9lSoi46eHAIJRVpNfkY/8J2rvmTMtde3VpmFKRXl8vnq
 N4wf6IlJayF4aD8LQoAEdGLCZDnZN/BF/fwz6PGyio5zBquef7ZBTPC6VBGvSHE4VOBO
 +fAUrDrGohXpGKF07h+FGbBU3Bvdhx2GCuJbx52NbUPg4jk3sWhW02iHnoMQWKvwuZ1x
 jekvSACiXNfXvHSEm7Jozd6KLNaP31ghsshgjbRxyOKx3MHCSCVsT1fASOHpKGA5wCYC
 mkmg==
X-Gm-Message-State: AOJu0YyWYmuHHTsHiMY7L5OQj//Fbu350kWW+Jg/fwInJi8kHwUBiNKP
 nkUFeA4NUA4CkcDOl23BdHe0SkToso5fx49P2KJ7g9Wd3Srz+boo/Tn2eolcbYLICdMRmWBV92+
 ZOgT2
X-Gm-Gg: ASbGnctq2HbK7H+L1YNvVgilcWYmBvITP/JrI2BMlYC7HgKCiBJWCD7D9DocP89Kg0X
 L5bIju0fVWq6/YbblIP1dyU3bIjYF3jFDNzGEckrcK29Kkba/tM36ElZXRs6hx5Pq/6j71h1ISo
 uoVI6vv747SuAkTfekaLA40CnCFGIzp3omXhmOWs3/OtuQ65X4wDIPKINBIlyaoSKEBfbYEC2pR
 P2qN9vAfcLWYuaRc7jjQmBmnYSFNtr7RJsVmzhyF2Ez1AkaPYwlu3sxKFLZvZhxSgEkVXPHzXYL
 HL3FPCt0vWAXRXKo0RSPyM2yyHKy9SxEwcCT0NzqVhCXaLlz4PuH/Jt9A3xEAwuv7Rpwub4HDAB
 gzfOVp8+s7jb+/A==
X-Google-Smtp-Source: AGHT+IFkWtdUK9Be/yQMAwI4hsDZjOf23TNKaKESiknqT8UaZZOzKi2of3KdpDS0FW6+mztPP3OIiw==
X-Received: by 2002:a05:6000:18a8:b0:3a5:3b56:974e with SMTP id
 ffacd0b85a97d-3b4964bb5f7mr2040564f8f.6.1751632363312; 
 Fri, 04 Jul 2025 05:32:43 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:e07:801:2854:bc73:8076:c06f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47030bc5asm2367760f8f.20.2025.07.04.05.32.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 05:32:42 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH 0/3] fs: ext4fs: Fix some issues found by Smatch
Date: Fri, 04 Jul 2025 13:32:41 +0100
Message-Id: <20250704-ext4fs_fix-v1-0-5c6acf4bf839@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOnJZ2gC/x2NQQqDQBAEvyJzdmGjbsR8RURGbeMcsgkzIoL4d
 9cci+qiDzKowOiVHaTYxOQbEzzyjMaF4xtOpsRU+CL42lcO+1rN1s+yu9o35XMKXCI0lIKBDW5
 QjuNyJx+2FXqLnyLt/y9td54Xqnf293UAAAA=
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

Smatch reported some issues in the ext4fs code. This includes a
suggestion to use an unwind goto, to not negate a return value and to
ensure that a NULL check happens before the pointer is dereferenced.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Andrew Goodbody (3):
      fs: ext4fs: Do not negate error before returning it
      fs: ext4fs: Use unwind goto to free memory on error
      fs: ext4fs: Perform NULL check before dereference

 fs/ext4/ext4_common.c | 10 ++++++----
 fs/ext4/ext4_write.c  |  6 +++---
 fs/ext4/ext4fs.c      |  2 +-
 3 files changed, 10 insertions(+), 8 deletions(-)
---
base-commit: 7027b445cc0bfb86204ecb1f1fe596f5895048d9
change-id: 20250704-ext4fs_fix-70936d5a3e59

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

