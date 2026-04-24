Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3953FF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 17:04:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 589FF84394;
	Sat, 25 Apr 2026 19:04:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="c9RSuBU9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D118C84359; Sat, 25 Apr 2026 19:04:23 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2ABC84309
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:04:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CC43E3F9CE
 for <u-boot@lists.denx.de>; Fri, 24 Apr 2026 12:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1777035320;
 bh=OPwj785u0HBNg3C08m/UW3Vs1ssEWbUA4yf1WTwWrls=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=c9RSuBU97RvijE2ZQWhgyLAW4VtedWRoXUfhY1GomBfGMewJwY1l9MBcTjaNX0ZMf
 M1XHX3U1kpx4CBHIG1NtpNLwwQVohpIjwsHXkY5IaKdE71LFK3x7yT27K7oZRtu26v
 k4gQSFmFKccrh31XhyoztzuwwBKFOgp7icqUT/y6Y/+xXoa5J8NXPfYmBr+HROuIIO
 Y9cGMDv95yS1E0nTM1be4VFKq8f4Kis9sApiIWte1Vy6YjPyBz2Q2rNR2eyo99RC4C
 9tRAPId9cztV2c6syu+BcXrx3ue0Dlyb4jtN3RWV0k1gYU0wZ44mcbSYMAqBzrBRGs
 5Rn0DA0Ft7Aa4+eZn8YnEMZizXkOYHImBSry5IqOnC4QoKvfSNzH8bbCWh4vkoZXHq
 ezQ57dO8d2m85ApNADffVUNFizPcMfQJYHg/TUMSMT98Loj3QvihvCcMmxn9+6wtVW
 1AT4pmoRlg3MA1bj2qDQqFLogXZfoeLtChyRnrLZJhKiM8KLBaHQblZA4u0bh65n12
 idE461+CPtBvUnyx7hzYSryiz9bIOKLrcIw2M7m+kQ4zT4hsXzPcQ4+XNS7XEArjHe
 i6PYH8R1BpA/Ah5Srd+/w0EvW0D+AVsFKALDXUbiJhNLa8SKPPtBMT66Z3F6h6aIHi
 bYC01CY47deOouMfTHWobkEs=
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4837b6f6b93so85286245e9.3
 for <u-boot@lists.denx.de>; Fri, 24 Apr 2026 05:55:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777035320; x=1777640120;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OPwj785u0HBNg3C08m/UW3Vs1ssEWbUA4yf1WTwWrls=;
 b=fIhqZ0q85vNWnLy4thn8HVUpzKbygZIhFQHjeuz+vGpIYdcQ4DhiMeMialm2w8DNXH
 52HHzxEqvwKN32MuQKMB9TRqnFmkmSrSap6iVynWXxFTsaGv/W3BV0GNBw3w6vsY/QZu
 ggwUadxkcKItYGv+aryyqMJxozX0AHJBVZa0DEPZjnoPy3aploWmvB+QGnq4oRimUb6m
 BDfb82AUsWx2dR3tDpY2AreNxnxvvlPF1lLIYPYlxnSTF7rhrm971Tmw0fg014yK6Ndf
 jTrCiLKBo6ss67Z+j5+afv3RfSnh+sWn53COLoi9c6svNgmj+CSkda3X0b272ntNtDlr
 oTUQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+IXd7L84ZCPj36NpsI4/NKNYETezi29OJndajqPztHe6i6w4/wBit/j9ZZL8kb+LiuzEvzeq4=@lists.denx.de
X-Gm-Message-State: AOJu0YzfMU+KOMbPMf0MvkIX/m6rKlKRjbSzT6NYQLDbBV65l2iS1GcE
 jGXxDKm5UG9uHWoQw8YQlNf/sdOYI3dBwTRlnqO+VphWeulhW4oxrj04pM16n8o0DG/oCgntkm/
 MQ3cIter2cKSfdGgzYKe6Q5gARsZMJZRjbWkxRGiBTDJwGEf/fh6s62tF1eR8R6hz+UWp6SPQqc
 R1iwI=
X-Gm-Gg: AeBDiesVC80fqnp5nGqbMJXlhRBSD31ORdIKYoWiSBngqGEJXWobEaY+9YscnOK2/CE
 WF0jt5Hara099NicEIrbKK13dV0xeZCPMaFy88ikQd3Y+YnoEGJKirH6P1OI/KATtePac82B7zB
 FycjFENVOnf8ckvjJ8SzVjEysD3wst1XcgsIUnY/SscYtoHhJflNwQNUQbqJivvueaijy8BGcdY
 a2LXu3lfjuTT23i/WyxC/WFiBfB5ZuQSTvzfnJeUw0Cb7dhD8cYdVxtwZQbGXHxp2cLWpUWvQQK
 cOfFBR9654mZcX+rMHWbpC5M+VY3nAnkvtuZWgXz2iVdZWUKXMJiOxwisqnyg2lT3/0LSsCE6VL
 ysvPrVY+KS3ly2lvgNeuK0QPNJykncRL8BgL9cd5Xe9pITAkdGkxKh0HcYswD4opQGfJcInapom
 bTkm/pZ5DIOUk3oV3NDtfHppDyiaqzMYs2GST++q16tl7iF2rgPzCVyL365Hhv
X-Received: by 2002:a05:600c:5297:b0:485:9a50:3370 with SMTP id
 5b1f17b1804b1-488fb74a431mr503260635e9.8.1777035320374; 
 Fri, 24 Apr 2026 05:55:20 -0700 (PDT)
X-Received: by 2002:a05:600c:5297:b0:485:9a50:3370 with SMTP id
 5b1f17b1804b1-488fb74a431mr503260225e9.8.1777035319875; 
 Fri, 24 Apr 2026 05:55:19 -0700 (PDT)
Received: from workstation5 (ip-176-199-115-125.um44.pools.vodafone-ip.de.
 [176.199.115.125]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48919f54572sm155274865e9.26.2026.04.24.05.55.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 05:55:19 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Javier Tia <floss@jetm.me>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] .clang-format: add U-Boot specific for each macros
Date: Fri, 24 Apr 2026 14:55:14 +0200
Message-ID: <20260424125514.274350-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
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

Formatting via clang-format is controlled by .clang-format.
For each statements should be formatted with a brace at the line end:

    for_for_each() {
    }

This requires clang-format to know that the symbol is not a function
but a for each macro. We use some for each macros which don't exist in
Linux. Add these to file .clang-format.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 .clang-format | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/.clang-format b/.clang-format
index 48405c54ef2..22ca6955568 100644
--- a/.clang-format
+++ b/.clang-format
@@ -748,6 +748,19 @@ ForEachMacros:
   - 'ynl_attr_for_each_nested'
   - 'ynl_attr_for_each_payload'
   - 'zorro_for_each_dev'
+  # U-Boot specific
+  - 'alist_for_each'
+  - 'alist_for_each_filter'
+  - 'for_each_bl_params_node'
+  - 'ofnode_for_each_prop'
+  - 'ofnode_for_each_subnode'
+  - 'ofnode_for_each_compatible_node'
+  - 'dev_for_each_subnode'
+  - 'dev_for_each_property'
+  - 'fdt_for_each_node_by_compatible'
+  - 'for_each_console_dev'
+  - 'mtd_for_each_device'
+  - 'for_each_tpm_device'
 
 IncludeBlocks: Preserve
 IncludeCategories:
-- 
2.53.0

