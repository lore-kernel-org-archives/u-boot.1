Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48486C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 22:49:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3128788A9E;
	Thu,  8 Aug 2024 00:48:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HrkJkMYg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51D9D88A5F; Thu,  8 Aug 2024 00:48:12 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37684881E7
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 00:48:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-39b38295008so1446625ab.2
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 15:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723070889; x=1723675689; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n+KspJSEgLGNC+JIS+cgwqgwed39oKyrTYgtpd2+aeE=;
 b=HrkJkMYgrxnYgTImWqRzC1RZFminL45SaJ0WRoPC2+LF+lzzDDkXsmpTzIu5RLcAVd
 CP2oUNJyoeL3HEE8UAOrZQI/ZyBqYE4e0GeMUCTuVQEZBk8bgnMr6mDmh/DwrphHXUEL
 sK4zp9qx6T3/5FtMPFhFkhq64wH6sSveK2Mz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723070889; x=1723675689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n+KspJSEgLGNC+JIS+cgwqgwed39oKyrTYgtpd2+aeE=;
 b=cqfjNVWAeaYpths5oxt1MwI7hNq9UR0FlFW1uBAtRkCIpU306kgddz2B9xK6O3KQ5i
 l5KpKiaLIwiOoMBGTfvNHSLu/hYlGbIQBXvVq220MLA0OtSbn2baE5TA65X9UCRdDaXq
 9SKrwYTZzaSReSK49LkPGCu792sTx5iT4m5Xaj6H6wu8RWX6c3WWXEWR6RsbL7oJZWBA
 taXlD4fsexjlUqGHDI6P6zpuZY6ZdxqzQVc3xAZefr2NTy/JL0rFK9lLkFWz/CZYEDrc
 VuE7p+BAlHU4oYiKphgyMkyty824qhqUhdPUKWXrJk56z5W03PWV4ThkpuVSFkHQLfgg
 B0HQ==
X-Gm-Message-State: AOJu0YxXQZVqQ9zIF4yB8e1Fkn5tGhVedup7U33V4cNPX8X2izV3/l8i
 BZgvDagJQEnKUSA9r1KAbe5UiwbR7s0acDmRg8noLDdP4YJJSeuBRSmq+SjWhdIEx6sNpAoKEGU
 =
X-Google-Smtp-Source: AGHT+IHuVlvIIRGAfunzfapgMPF35v7+pEL1d8C5THLs1D/lUPJO2qqpwvQkTQ6FSr7ugzhV4FwYZw==
X-Received: by 2002:a05:6e02:2182:b0:39b:324a:d37f with SMTP id
 e9e14a558f8ab-39b5ec6fa7cmr975365ab.2.1723070888829; 
 Wed, 07 Aug 2024 15:48:08 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20af1528sm48275205ab.80.2024.08.07.15.48.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 15:48:08 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>,
 Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Jerry Van Baren <vanbaren@cideas.com>
Subject: [PATCH v4 05/21] sandbox: fdt: Avoid overwriting an existing fdt
Date: Wed,  7 Aug 2024 16:47:23 -0600
Message-Id: <20240807224739.3858517-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807224739.3858517-1-sjg@chromium.org>
References: <20240807224739.3858517-1-sjg@chromium.org>
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

Since the removal of OF_HOSTFILE logic in board_fdt_blob_setup(), the
logic for obtaining the DT is handled in the OF_BOARD option. If a
devicetree comes from a bloblist it is immediately overwritten by this
function.

Fix this by skipping the function if a devicetree is already present.

This is sort-of a fix for e7fb7896 ("sandbox: Remove OF_HOSTFILE") but
it has only come to light since bloblist was added, so I have not added
a Fixes tag.

Unfortunately it is not possible to report the correct FDT source with
the current code. It might be best to use an error-return code for
board_fdt_blob_setup() so that an error can be reported if the board
does not provide the DT.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Fix 'handed' typo

 arch/sandbox/cpu/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sandbox/cpu/cpu.c b/arch/sandbox/cpu/cpu.c
index 0ed85b354cf..4f15a560902 100644
--- a/arch/sandbox/cpu/cpu.c
+++ b/arch/sandbox/cpu/cpu.c
@@ -340,6 +340,8 @@ void *board_fdt_blob_setup(int *ret)
 	int err;
 	int fd;
 
+	if (gd->fdt_blob)
+		return (void *)gd->fdt_blob;
 	blob = map_sysmem(CONFIG_SYS_FDT_LOAD_ADDR, 0);
 	*ret = 0;
 	if (!state->fdt_fname) {
-- 
2.34.1

