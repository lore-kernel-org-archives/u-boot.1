Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD610C5AE59
	for <u-boot@archiver.kernel.org>; Sat, 31 May 2025 08:45:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73FF682C7D;
	Sat, 31 May 2025 10:45:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RNGlHs5a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B20638003E; Sat, 31 May 2025 10:45:07 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22B0782CA0
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 10:45:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a375888197so1403394f8f.0
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 01:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748681104; x=1749285904; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5vOoP8Gu7lhdrKyl4UYQ/V/1BY2oLaEVm2VemAdUsqU=;
 b=RNGlHs5aSzbwg76HD/wuRM4ApDbYJUmAGYRlHoRVdnmGRYLeAbPJ/rZCin/8NV11WJ
 XHQrk2KebEb0tawCaAFRt6STxvj/pO3Pl3Drs3iP5d/LTdzJERyGcwFjbrUm2THUuRxa
 QvPNOXpOQF9O9e0aI5FxPpHVVMCGoGCq0tLy1O3Vy1MwAAkUC1ynNJprb6cR1Ir8K8Xl
 oYBJx+BQf3xQc0KN1alBRMAu/AqMdGif80MNT1jsB9ZXXyQW/uzwdJcLA5MjRruAN/cr
 gMIZRzjxoBwQdn3cFKh+yZdnM5K2AEXjPR2lROx535r5c/Be/S+Ms5lGg5x4WS7MfvmV
 O4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748681104; x=1749285904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5vOoP8Gu7lhdrKyl4UYQ/V/1BY2oLaEVm2VemAdUsqU=;
 b=saJflkwdX+xmKp3iaBB0LlKNboriJWT20vH0HCjDRf1vLT3Ou7WHDVLKpfSEVtlJU/
 +iMDIIUIDmakIGKhd/6BGDxFm+EuGscR3HRoPIqBEzLkrUAy4sa+xNbt2hqqxxPRQLX8
 7j2iWBw3+d4lvV9Im1fUSgXmicB62y3eutRcl/7EFNFnnPHWAsIprRMPSHLQnCTb7h9I
 Ez4EBloeMxYBowlW17jferZ1LGb8LNme8DE8NtoKCbJ1bdBIor+9qqqJ1FS6Mboky0gM
 /4qidK9NqMhpVN0GUNFHC0ElpfiALHW9kRVp6VoUepz3drH739dyxtvtRa/8DjmUCak8
 Yx8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpmfE2vR356mTg09/Nuhm3VjoiIIsWKIcKzCIMY/bSu5NfA+ukBntRhJ4LTtWrCwnEfbEVR/M=@lists.denx.de
X-Gm-Message-State: AOJu0YwVDmqoC5PP1jJHQufrNQmfWaSiu0QDFa1ZZKtwoyK+jIweH0rs
 jdmAYdiOkJieb4vjNncBZg6MF1HQ5pUhd9wNt67Aqvz1SRYwVnqrqZVLB7o8nCSIzMI=
X-Gm-Gg: ASbGncvnrRnC8Rk24X5sCYS/y8bGXFrJm/cICk1uPmwbSabrGny+rQ3XxP74N2Twr2y
 30k6aJdJ75DlBFIxphcG1Y8SStlD9yl52VR2ktRzO6mJNE4v9Z8VFBNTw5zC2mi1i5IyU5rs2yS
 xNBni/ReEw0KcOQTzzCMsb7J8OocDdrn/nCbxfKcs4ARkOvU3QCwDNcUu4P8h9Ey1dkTy4b/kVh
 DNKEoElBmsyUW8EoxjN8DmWofaTC7R9pERf1QA+sBsD4TPx0pJ+9/5Iy0NnccxcLOhrzthyIy7q
 tb3o5dj/n2HZWZZmZdKktskArzXmv47DBqBdXkfGeZRH34ucsix5iy0b2odJwUC1zvEg+4nwVGz
 WjTsxIaB354VSa9GcPepPeMsvbJNKiw==
X-Google-Smtp-Source: AGHT+IGxof9/pF1oLVLPgeyMtmZhcmJmqBPPTAmScb+IdCVI6aJ6qa92xY3ygYvEmTU65kzV9Wtmhw==
X-Received: by 2002:a5d:5c84:0:b0:3a3:7ba5:960e with SMTP id
 ffacd0b85a97d-3a4fe3a8214mr1043348f8f.59.1748681104367; 
 Sat, 31 May 2025 01:45:04 -0700 (PDT)
Received: from localhost.localdomain (ppp089210105145.access.hol.gr.
 [89.210.105.145]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe73f3csm7153986f8f.42.2025.05.31.01.45.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 May 2025 01:45:03 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Yao Zi <ziyao@disroot.org>,
 u-boot@lists.denx.de
Subject: [PATCH 06/13] kbuild: gitignore output directory
Date: Sat, 31 May 2025 11:44:34 +0300
Message-ID: <20250531084449.4125187-6-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250531084449.4125187-1-ilias.apalodimas@linaro.org>
References: <20250531084449.4125187-1-ilias.apalodimas@linaro.org>
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

Backported from kernel
commit 3a51ff344204 ("kbuild: gitignore output directory"

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index 48a0af51bdd6..6758ec4103e8 100644
--- a/Makefile
+++ b/Makefile
@@ -513,10 +513,13 @@ PHONY += outputmakefile
 # outputmakefile generates a Makefile in the output directory, if using a
 # separate output directory. This allows convenient use of make in the
 # output directory.
+# At the same time when output Makefile generated, generate .gitignore to
+# ignore whole output directory
 outputmakefile:
 ifneq ($(KBUILD_SRC),)
 	$(Q)ln -fsn $(srctree) source
 	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/mkmakefile $(srctree)
+	$(Q){ echo "# this is build directory, ignore it"; echo "*"; } > .gitignore
 endif
 
 # To make sure we do not include .config for any of the *config targets
-- 
2.49.0

