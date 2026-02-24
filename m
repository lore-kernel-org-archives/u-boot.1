Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71370F357AD
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 14:26:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3369683E7A;
	Tue, 24 Feb 2026 15:26:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QMI1R/hf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1351A83EB3; Tue, 24 Feb 2026 15:26:30 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0930283E7A
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 15:26:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-4645dde00a7so2336739b6e.1
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 06:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771943186; x=1772547986; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7kibB+VM8hSEjYY3aEjJtPtdCpWCuDI04OrFi39Wf3k=;
 b=QMI1R/hfHzWg1qmNZiBLt1Ri10mIGE4/cFV0SEcV40LM+2e4aSRPpM6MtiolndMdgU
 K4HhlyoSAhCNWK2TVOm/kwm/4Mg2jLdcvy78G1aS/IHoyGsWNAFSWQ9YX1DSAiNsWxEQ
 qBf0H9ogu4Nq4ADmnGFMb8kJVaVQqNJt2sw2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771943186; x=1772547986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7kibB+VM8hSEjYY3aEjJtPtdCpWCuDI04OrFi39Wf3k=;
 b=T0rXoc5siln1uBSCOzYS7Vopa4wlLA3OUf7D/EtbRUAtWM616i/Mivj0+TASUeQMHc
 wzaO/RWqbXhCh1RR5yYg6kYzSduSa6mwfD8I4LOIi9Ww3zZ3Faftyv1RBXv7VyLbupJX
 DzsI9wZSIhdXmh5VLxfnGjJWC2VmZp5kEeqhvR4/9trkG0EJSaVtoQsIsEEyhp9K82XT
 HtQo59erbNBdiipggmrJRHShyOojzhrMk74oh2mPCip4pkIWvTgL/vL489UG+FDmjEXr
 +M9qQt1oIJ7L+/DjzzqNniHhp/bfGmREqgzDcochqcoUwpRECs9M+zEcF/xM2aBOKgHJ
 ZdKg==
X-Gm-Message-State: AOJu0YxWovdFoLXCK2CW9Xpg3d+FC0PjAvAyr+Ozy90iNbwYmG6Sf3u3
 0XQy/BaYaqFNN/oXFXAZM038tWYLq0PS6vZrj/9qhV92Za6UrvozgoNfcRtQ5PwzR0fprrG+xOQ
 oy7U=
X-Gm-Gg: ATEYQzzyXyZc9SivFlTKVtWkJ7sQUrj8oR3ArWyfZiqNSzNj6A6q/VCK6oVMu20nQpu
 kaLg6l35sQ84lvMhWgZSGZkmXiCEu+J3mzKk7w3Xj/AKJiNoiFNXf4fbYvXF3A28uvs4seFkh0+
 IdVdjdLhenLRfa7Up+rMUSSK97dYlzPsNtNFPetGFUwZBKH8A0voceqgHkD9qtnbfnC4f2yfMl7
 rX/XS5eLqWzwXsCZ6fi7GVXYuOQsCglZmzpXa/g9tV3MoVg9rcRmxedmRAP7LG0vqKPGOLjczaf
 gmIj6FjZeKCnZJIaUjjURAfiF+DbUxcRw/yOaBxSoVjhccvUw5b5ZuNK/hE+cpGiDLhe2ut5uCC
 Ff5k7PE6GhuVKjmhDarE+Egd8N5Vg6B1CGyFsqbuOk162H0T16/k/TxTjUVwgqW8IfvXlAJXfY5
 s0TyvhKF3K+4utZJVW01cS1JFUxzyV4WYp7JOlEN6C
X-Received: by 2002:a05:6871:28a7:b0:40e:f203:eb4d with SMTP id
 586e51a60fabf-415e588bdb7mr66870fac.2.1771943186180; 
 Tue, 24 Feb 2026 06:26:26 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157cd5e168sm10199478fac.4.2026.02.24.06.26.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 06:26:24 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
X-Google-Original-From: Simon Glass <simon.glass@canonical.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 3/9] bootm: Add a message when booting
Date: Tue, 24 Feb 2026 07:25:45 -0700
Message-ID: <20260224142553.1608883-4-simon.glass@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224142553.1608883-1-simon.glass@canonical.com>
References: <20260224142553.1608883-1-simon.glass@canonical.com>
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

Add a message about starting the kernel.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

Changes in v2:
- Drop comment about EFI

 boot/bootm_final.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/boot/bootm_final.c b/boot/bootm_final.c
index 263cd95dcb3..71661334e11 100644
--- a/boot/bootm_final.c
+++ b/boot/bootm_final.c
@@ -10,5 +10,7 @@
 
 void bootm_final(enum bootm_final_t flags)
 {
+	printf("\nStarting kernel ...\n\n");
+
 	dm_remove_devices_active();
 }
-- 
2.43.0

