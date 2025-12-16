Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B4FBD637DE
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 22:19:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9632B839FA;
	Tue, 16 Dec 2025 23:19:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ceUjOBGA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACEB483A24; Tue, 16 Dec 2025 23:19:40 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97D978334F
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 23:19:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7c7503c73b4so2929738a34.3
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 14:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765923577; x=1766528377; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=TcaCqikivxFcsXRRVKCh0sXLldUIkEMn78FCmCoYdmI=;
 b=ceUjOBGAv3J1USLNBDr3A5CzwnFv0x7aFwAfcOYt9b/XdsonsATeZY6BWR8HYBcQrK
 LuNRoqK77hxBbE8Kqpri/oFpRvrOUrzO5iPvpB6kLz9cu3dm4ogU0KjzK1W0d+L6lHQ/
 tZ72IX+rMNgRjvBSKJ9DFMY3YCfLTCrWF34OE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765923577; x=1766528377;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TcaCqikivxFcsXRRVKCh0sXLldUIkEMn78FCmCoYdmI=;
 b=uaHyfhU6R6xgPKRrVgnSBBgY3hsSFktxa62StH3P22PSehDC/Z42wDqtck1Lqoiitk
 /S2aGapB1vVj/jsRV9ub7aGy5S2litJYzMrMG1N1iN5qyTDOAtrrbAk+sZyL0uFMfbYR
 ilL76dOBZ308bs1+s+zftrZ518T9RLH5/0tp6sNMTDNRXodh0ODSTao/wWMkMLuywk+K
 dpzqNQxngt+kZsHBH4dL7jYCpQ8AeIHhI9+ozvDlLDuDQQ2OMzX0gVCLXToYyni02LZK
 7kDG8ROj2lAZCr9uSAM5BYNiNkHvjKkJW9byDO/0i5VQM8cYArI7wQwTi1Lm/9o/p+Bt
 VInw==
X-Gm-Message-State: AOJu0YwyBLt7MkOEpYTg4FSmh+ZclV72SdwoOOhFblmsuBTLIqOQ4I0M
 vnr+l9h2Igwh0juTCrEv2iznMs3lNbsj7bTydF/qJNkda3uhxrfX5eyMaGjUliqsDgIezDmOyqA
 Il+7wSeQ=
X-Gm-Gg: AY/fxX7eJ31L+6G+1w++D+dtli2TqCoJhBXIDYWDimUOtKReCAVd3+Zw+/dMPSk5FGZ
 yVysdxUw2TtF5no/xnKmsOCqkZ2GrEHGeibJzaebqMYyd7ZfPRkw9kKrz5zUfInRD20HoX+TEni
 xJVrkK+hRv8tzH/IEWxI/bnFgVcdzJOwVx2t21NG6N9KKXDQfq2eaaQlK4b17JucK2NxxQJHfF2
 s2iCZCZjkSDrn0Yi5sbDqgP0uHp1ygJ3SccORYCxysywcUC1EMSVGwbldKsFjUdi/ZTmKXjX8ig
 8Q18hGFGUbIBgozy20doVnAiAouCFHduHW1Ds1t6rbTWWRwkgAgnDSSVz+nglru6WlAhWwUcF03
 1DT5BJQZN789KKBBr7E253Mt6oq2o5WnKKJOLHLqVuhTzJJ9yMMg58JJ3jifSzvpDBPf/MXBgGG
 QMNqECOljK0eF5iiWfjh8386ssG8dsJ/54+IPlo76vd53vfSwiDHX1
X-Google-Smtp-Source: AGHT+IEiCt5k/VfVi8R08Ul78So9W4sFenP5yA0xlkh+ZGaY9J/sIAJZ7hLiEILPVRqzQeD5eSnU+g==
X-Received: by 2002:a05:6830:3688:b0:7c7:5d01:a888 with SMTP id
 46e09a7af769-7cae836699amr7770227a34.28.1765923577320; 
 Tue, 16 Dec 2025 14:19:37 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cadb2fd262sm12212337a34.15.2025.12.16.14.19.36
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 14:19:36 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] test/py, buildman: Update filelock package version
Date: Tue, 16 Dec 2025 16:19:35 -0600
Message-ID: <20251216221935.2230490-1-trini@konsulko.com>
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

The GitHub dependabot tool has reported a "medium" priority bug
CVE-2025-68146, with this package. Update to the patched version.

Reported-by: GitHub dependabot
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 test/py/requirements.txt        | 2 +-
 tools/buildman/requirements.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/py/requirements.txt b/test/py/requirements.txt
index f9eac7901fbf..e080d0f051c0 100644
--- a/test/py/requirements.txt
+++ b/test/py/requirements.txt
@@ -1,4 +1,4 @@
-filelock==3.0.12
+filelock==3.20.1
 pycryptodomex==3.21.0
 pytest==8.4.2
 pytest-xdist==2.5.0
diff --git a/tools/buildman/requirements.txt b/tools/buildman/requirements.txt
index d48650cd1e58..d8f76e4e73d5 100644
--- a/tools/buildman/requirements.txt
+++ b/tools/buildman/requirements.txt
@@ -1,2 +1,2 @@
-filelock==3.0.12
+filelock==3.20.1
 importlib_resources==6.5.2
-- 
2.43.0

