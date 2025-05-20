Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01562C3ABDA
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 05:23:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 675D882C7D;
	Tue, 20 May 2025 07:22:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FY+ryaIL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CBC482BF2; Tue, 20 May 2025 07:22:26 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DE5482BD7
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 07:22:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a36abf5df9so1484648f8f.0
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 22:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747718543; x=1748323343; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=siqFNQWCvueAM0VVXekArN+vDPNhJjXRQCAFGK43+g8=;
 b=FY+ryaILzAJdAFg0ZhWS/BuX/O7VgBUYpWW3bIzWfwIRPCIpMot3oC1TGI4m8dhtpN
 9ZYroSddK7T/CW7AyBvtBTuDoUlV2a1Ysli2fzwxPCeS5+oIkwyNQkj7xsPu3npDRR2q
 FosvJJpReYq+wDXKXqOOssZ1/EbkE7xStw8oOqcBdBW9fTeeUkRZJF09y5VgwNeH+6+c
 ltz26UKxzqVTUlR82ThaHNsV6HsaR3FeDh82i39QHkoja9rq9Wn/fdTkInzwGp/H3UPC
 8RCJ7Ci19i+Gzls6H7VtFUrutUlm5ZO8dBGlyF7r4hpHFLxFyN7J5jo1RbajWaROs19U
 e8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747718543; x=1748323343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=siqFNQWCvueAM0VVXekArN+vDPNhJjXRQCAFGK43+g8=;
 b=P9mKLrST8EbOslJAzAAPRBoPmSi28Fy28kkWSIVAoAsGtY5xXMZTd/CmsWfHBNgZyu
 kt59qcZRlH/hgw4yM9whGG2waacj1B3CM1ZwnTEvownhO+Dogk4aCUyt+ORTr//MV8hL
 1QTz23b6BTno0C0S5usFKEXBqFo3JZ36WQv6LNwhJNRbjK3XIOzC9oJCpf+WQaSNf9mj
 KghtrjNk0O7TLqWEL+9ddbzLA3o/JR2QLBQzqYGwDEALhYBWH1xv+8vZWSyzhu+T4VCl
 bVyfNsmMeysAvfQPi4gXnwF4v4gxPvxoQ0vzo5Z4IsJt04d3dq3l3yUBqEg8FEhL43oa
 VLSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0L/YBukiDBcTw1p+bfevvO6hudyrk3zNyyeSUc77S1nlUrv0+VUgw/lKCq4TxLx4LeAEllFs=@lists.denx.de
X-Gm-Message-State: AOJu0YxoVt8sXkTJobKPFqFt0KVyCjS15+/KHiddgz7ib5OrxCcidG1J
 DMAj+qQcYCzpMm0VWIwTdcKSSJGegvDXm7WrmEJh51pB7RmqFF8gq6t3dlaP/GzhABo=
X-Gm-Gg: ASbGncuV0N3ImXNbLsAHq5CQCQc9DjLrMDeDzmOkur+5N7/44PYbmFUuL2ysBzvEPya
 E6Y97xQdcMS6+x9GyOgMG7TG6ULI4HHpVoGeUne8CxRIuo9ijAvpZe9fBEuhMGPMpWHTvDCPCqh
 8UotfEbtNg0JUnXocBJIe6y76vCU76H5JdIRhldQF2q7HbZ+33adtqbMFOJiMVVroEtisjSiSao
 k28EfbrPtJGYHm7N5jssfb62VV9uRNVJYX6qdmh6d264ND3voM3+0OYhRD/9M7KpKNg0TndYEfu
 tYxPfoEVOkEnnuNwaO9o1UXgx6AJ0kXHewipVy7LYlbpoXYiH0zCsvyrEFqsQFogKXAgmRfc6qY
 =
X-Google-Smtp-Source: AGHT+IEy1tUQjnivywss43jTdWJS08t36o55uuYT7mYpk8JHZDdB4nO+ZJ5C+KnhzHb1aXUf7TIp1Q==
X-Received: by 2002:a5d:62d2:0:b0:3a3:56e1:dff1 with SMTP id
 ffacd0b85a97d-3a356e1e170mr12474126f8f.4.1747718543613; 
 Mon, 19 May 2025 22:22:23 -0700 (PDT)
Received: from localhost.localdomain ([46.198.180.244])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca889e6sm15100762f8f.71.2025.05.19.22.22.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 22:22:23 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sam Edwards <cfsworks@gmail.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 u-boot@lists.denx.de
Subject: [PATCH 10/24] kbuild: move archive command to scripts/Makefile.lib
Date: Tue, 20 May 2025 08:21:21 +0300
Message-ID: <20250520052153.307194-11-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520052153.307194-1-ilias.apalodimas@linaro.org>
References: <20250520052153.307194-1-ilias.apalodimas@linaro.org>
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

Backport from kernel
commit 898f5a009f22 ("kbuild: move archive command to scripts/Makefile.lib")

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 scripts/Makefile.build | 4 +---
 scripts/Makefile.lib   | 5 +++++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 73e1d71e30df..d90b0b7aa6a0 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -355,11 +355,9 @@ $(modorder-target): $(subdir-ym) FORCE
 # Rule to compile a set of .o files into one .a file
 #
 ifdef lib-target
-quiet_cmd_link_l_target = AR      $@
-cmd_link_l_target = rm -f $@; $(AR) rcsTP$(KBUILD_ARFLAGS) $@ $(real-prereqs)
 
 $(lib-target): $(lib-y) FORCE
-	$(call if_changed,link_l_target)
+	$(call if_changed,ar)
 
 targets += $(lib-target)
 endif
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 28295c7ff125..c441be352da1 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -278,6 +278,11 @@ $(obj)/%: $(src)/%_shipped
 quiet_cmd_ld = LD      $@
 cmd_ld = $(LD) $(ld_flags) $(filter-out FORCE,$^) -o $@
 
+# Archive
+# ---------------------------------------------------------------------------
+quiet_cmd_ar = AR      $@
+cmd_ar = rm -f $@; $(AR) rcsTP$(KBUILD_ARFLAGS) $@ $(real-prereqs)
+
 # Objcopy
 # ---------------------------------------------------------------------------
 
-- 
2.49.0

