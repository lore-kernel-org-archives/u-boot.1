Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D66CAC44501
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 18:11:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BA8684AFF;
	Fri, 10 Jul 2026 20:11:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="CQZt6V28";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E61F984AA8; Fri, 10 Jul 2026 17:34:00 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 126DB84A3C
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 17:33:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C68783FA70
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 15:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1783697638;
 bh=Bvi/iFg3ZOYF7WD8G+AZFSAqJGozlwK+kgYE7n/mptg=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=CQZt6V28qsmYFXL89XQvW8C6Ke6DaRaTpnax3ESFSbThvAoNaYzEq+5t2RCDhzheU
 5LaHGK3Ai6w9bUvDGpBXhhHXTeHRQcpL+m8c+2k4txc2FIE0OVbLfY3lq8wfmeQnfO
 I1tiFRxAb+U+b8hv59gFd0rs0/tzlNTJxMCeqSRBcYsWb7NAq4RXk8BItdhQ0tg4+z
 ZQ6+Zi/7PfSRx+qD6BjMMdEeCIfR0HDuixi2GTnJdxcv3bKMEAwCCiI9S5VrPzvonQ
 LtGxVTvz9FMyd7OVgVBg5MadcJyp3MU2PWnLv+2mNcK8cFNvLzUNeIBgNUlZwkZGgT
 /BvWlDtqiUe/RYb+sZZNDR4Tq5rq2i6ZDIQ7KO5RKBfQb9a9pLLe9T5rP6l46PzMPz
 W7YFbUFcuA/MiizwqfaeCT5DQeQqa4n0kjuiSi8Vn+YyafMcUsrr3n5VfXY+hBZoJu
 xkZ5HRLWzV/bxKV2JLOFQwl7DgF++dUVw5t4CyljhCaJjnF2lE5oUNO4YqFh2gZ9V5
 6Uc+pLmQKSkpO5mR2cwQuE7kwKWaRKbSXdTuVdNJTFizHrg236D1QlPxilHz21Ecc0
 +JFl9HzXYnemgRHTebEC9io5UL1mO1c6VGkCNaD+LFmEP5z9trCsk1p6y2TJzSplxe
 k/zA7+eoOXIsYwRaFpYQTajo=
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ccb6f6a3f4so17632805ad.1
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 08:33:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783697637; x=1784302437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Bvi/iFg3ZOYF7WD8G+AZFSAqJGozlwK+kgYE7n/mptg=;
 b=HLozvqF/JhzVTdEI8vJO1zXogP82HfsJ/Zh1dSAQ01nIERPgMRpjenqQTYxMgvBCGP
 lmR040YR8bHOGnqGOL3OzERlWUS2KS9g9xdpn+FeGbc/B6Zgi5AloyeUP4LAlVKlPlW4
 VgUabnvRUlPnPzK2afztwicsqCHbDOfGYpSYb7mD06hOEfAe7K4ACZ1F87rNWr23LCpe
 JmulTzY4o/oyoFCbN7PJfDhIMbyak210PaPmZ1XcfuryuBTLbNNrxk96k6JTYXlA9mRv
 4dpGezxbwlrK2Rgi6cGROdCrNglsTUYlP5qi/G/X34Igb47pzjd7ZRqsHga3064TY2sC
 DQbQ==
X-Gm-Message-State: AOJu0Yw9enM64DhHFqsceVElQBIu4iiKFP099v682A6u25Vy/HSw2RY0
 fJmE0eAO5p3wRHNHltp39ELufI05Wu1K7ofr9m2i6ufZTIajMlJMAPGoNYcs3/XaqMdYv+Smv2j
 g5/B8agNZI/J2jp7lLJO7OwvMII/tZxxhbLu6XQjIxApBZge7T7AXcUNVoadzB/TWhRYpLDcLjQ
 yjy7k=
X-Gm-Gg: AfdE7cnpnBHDh0V3UZ9+wUANpUTLd4MEtbNA9N02ajwZUH5Y7ZMD7duA5ynmrR7rpcU
 TqQhqWYKTOmmxofjePZXkhFRjmExsHKJLeZM6QgSrhB4ta3fHsH4MFn2wt/wIBVyss6e6l2H7A9
 p1mvyBSeOK7ec/OAneAy8K4ic8Xjl8LspYahS3zhoJeF1ApxtKlS8rOxTZmN+tdaANTM67CQZCD
 lMiKtKUnp4+6MxNACA/TTi608p+lsSPl4Yv8T/Ic4nP/Frqm430oCbVjJimM3ZCrJ3IwhJEFTnG
 s6Q5+TUMqWzTQNEVD2AqCg/71xGf2ojGR3BujOnYwTJ1OZqV0Y00oMbp66UKpN+2u7xvdYpk02f
 z5niERqhW5aKq5IWJaiRH4OXwlpx3rUMtT3JEQSo7wLz9MxZ5Gz+zvSiPbboa/WYbBzbc2peDJY
 mJ8gcu
X-Received: by 2002:a17:903:249:b0:2c9:e9ad:3ed3 with SMTP id
 d9443c01a7336-2ce82c65861mr38440975ad.17.1783697637317; 
 Fri, 10 Jul 2026 08:33:57 -0700 (PDT)
X-Received: by 2002:a17:903:249:b0:2c9:e9ad:3ed3 with SMTP id
 d9443c01a7336-2ce82c65861mr38440795ad.17.1783697636904; 
 Fri, 10 Jul 2026 08:33:56 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9bdb882sm61390895ad.16.2026.07.10.08.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 08:33:55 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Rasmus Villemoes <ravi@prevas.dk>,
 Daniel Golle <daniel@makrotopia.org>
Subject: [PATCH v1 1/2] tools: mkimage: fix stale data pointer in
 fit_import_data()
Date: Fri, 10 Jul 2026 15:33:39 +0000
Message-ID: <20260710153343.1839357-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710153343.1839357-1-aristo.chen@canonical.com>
References: <20260710153343.1839357-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 10 Jul 2026 20:11:14 +0200
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

The data pointer and the name of the external data property are
declared outside the loop over the image nodes, so their values leak
from one image into the next. An image node that carries data-size but
neither data-offset nor data-position then reuses the pointer of the
previously imported image: the previous image's data is written into
the node before the import aborts when it tries to delete an external
data property the node does not have. Since that abort path only prints
a debug message, mkimage fails without any indication of what is wrong.
The failure mode also depends on the order of the image nodes: when no
externally stored image precedes the malformed node, the stale pointer
is still NULL, so the import skips the node and the hashing stage
reports a proper error instead.

Move the declarations into the loop so that each image starts from a
clean state. A node without an external data reference is now skipped
consistently regardless of node order, and a malformed node is always
reported by the later processing stages with a proper error message.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 tools/fit_image.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/fit_image.c b/tools/fit_image.c
index 5831b07c090..7e59bc43b77 100644
--- a/tools/fit_image.c
+++ b/tools/fit_image.c
@@ -898,8 +898,6 @@ err:
 static int fit_import_data(struct image_tool_params *params, const char *fname)
 {
 	void *fdt, *old_fdt;
-	void *data = NULL;
-	const char *ext_data_prop = NULL;
 	int fit_size, new_size, size, data_base;
 	int fd;
 	struct stat sbuf;
@@ -941,6 +939,8 @@ static int fit_import_data(struct image_tool_params *params, const char *fname)
 	for (node = fdt_first_subnode(fdt, images);
 	     node >= 0;
 	     node = fdt_next_subnode(fdt, node)) {
+		const char *ext_data_prop = NULL;
+		void *data = NULL;
 		int buf_ptr;
 		int len;
 
-- 
2.43.0

