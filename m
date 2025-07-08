Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24483C83F0F
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 11:34:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1D6483123;
	Tue,  8 Jul 2025 13:34:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="huC//RxN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 550A083242; Tue,  8 Jul 2025 13:34:55 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CE158305C
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 13:34:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3ab112dea41so2300147f8f.1
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 04:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751974493; x=1752579293; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=S+NMcbjKHVmgPTHUhj1Yf+qG+1KgczemAGf9JeCYIBo=;
 b=huC//RxN9VCgkxB+sSRc5x11qUL8RaXr3adoC3tv+OmrTigb5AUxItzFs+2q2V1vv0
 a+TmrEfReBEkxPLTmUYP5jK6W+izImt6hn3RhxXvfE3+hCQtX9WrtrImw772bWI8NEoU
 4ARsm0fHSlVw4vnHO8h11QcxMY41lt+0ykJhVHz7tqT42UFZh05/eZk8Ic+NVlfWqcBf
 QPjSnKDr9CdA5vl+ymA5z3VuTFcn0qVenocKRJuTDSZn/ESgQsFLGD8lu47P6WC7kr9+
 N1sHwJc+PX0x0tiBrYARISggpz/rGEemS6dqIuW0+PedM139gaoIc8viD9dwyNsEiK8u
 WghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751974493; x=1752579293;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S+NMcbjKHVmgPTHUhj1Yf+qG+1KgczemAGf9JeCYIBo=;
 b=YANY5L+BO6mI/M1Yg69wBwcEQw76uB4MUyD3tVESCpZpl6wVVjAe44THD+OluxdCSr
 m3x1N6PfnpNgTAXXeumvJ4CrLAnm2j/MyiuhBJBfypUgDmKUnR4SgBjKXf3USCpChaxk
 RtGq+gEFfwWGubi1TaJQlzLrGggvX4uo9ifpARznIN9UROIuYhd7CXITDp25C2ZYX1De
 JVoFZzdRQ6KRApdI/tG3+aCA70x6qVg/TsPQUQaSgqU37/JXdxAFtE5WhZLxokn7ArOw
 Oe8cetEXvItJ9g73atIwNYWxKmzPCuhgUiF2jFMoEbuXZlGcN+padd4IBCtkroTWCgz/
 lfjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTrV1viOR9M2KphuVJmRQqqWE6cos8sIkRJpydtraz3aoUqnYWjWv6ghmKRSjVn2uyJcSEgAY=@lists.denx.de
X-Gm-Message-State: AOJu0Yzb+BsJTZ188921i4L/kuS+rgTsvX5Ig1P70jBnIqjIW38vHYga
 koYBPcQJ4maEUFezA9+tbfNVgNug+qb0uH+QySpPHGpcDHgsqsvU/AGJkOKpwSyqQss=
X-Gm-Gg: ASbGncs07v/bTHKAoY2l8PJeFr0tbiMXN8RYOpOs2iBhWhDKHQAoPX0Q/t7Uwt3gTQB
 1lW9nfiZ3sw4n4FTe4N682N8jopsEmRjDl+ZPtmollUYXmnGV8BhGj7YVMgGlJxWar/vJlTmbIt
 DTt0FQlmkW9seaHrgjcAF+vAde5sWVGMsNz24JvITlYFiD2592Co3Zu1JTXMIBAgglzLXEGqtxY
 8reUaWR57aN4rK9MhwyMIciwMa+k9FwwLo+dXcI4j+8OT0+cH59XQJ3+uUxNvO1F1PGIw9nwcRl
 8lBa/C4ZZTU6iIwp8KB3/pDSn86/SkiYEofVRbr3Vc5FMJjGc8kcSoyA4TQFSlWUhM1ZDjswVM9
 w6HHQmpG7z3S9
X-Google-Smtp-Source: AGHT+IGmlNnP64MFWAL3+YAV1n7vQLupS0xRegglRx+zdUNXiYH/ZN2ATI3xu8dtOFu50jrLXck/iw==
X-Received: by 2002:a05:6000:2187:b0:3b3:a6c2:1a10 with SMTP id
 ffacd0b85a97d-3b5dde3f94fmr2198157f8f.12.1751974492420; 
 Tue, 08 Jul 2025 04:34:52 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:e07:801:a08:6480:3e01:6cde])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47285d3bbsm12900668f8f.96.2025.07.08.04.34.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 04:34:51 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 08 Jul 2025 12:34:49 +0100
Subject: [PATCH] fs: btrfs: Do not free multi when guaranteed to be NULL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-btrfs_fix-v1-1-bd6dce729ddd@linaro.org>
X-B4-Tracking: v=1; b=H4sIAFgCbWgC/x2N0QqDMAxFf0XybKGrDoe/IjKSGmce7CQpMhD/3
 brHwz2He4CxChv01QHKu5h8U4FHXUFcMH3YyVQYgg9P3/mXo6yzvWf5OQxtJG5xajqC4hMaO1J
 McbmLFS2z3sOmXPz/yTCe5wUznzn6dAAAAA==
To: =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 Qu Wenruo <wqu@suse.com>, Tom Rini <trini@konsulko.com>
Cc: linux-btrfs@vger.kernel.org, u-boot@lists.denx.de, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
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

multi is guaranteed to be NULL in the first two error exit paths so the
attempt to free it is not needed. Remove those calls.

This issue found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 fs/btrfs/volumes.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 5726981b19c..71b0b55b9c6 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -972,12 +972,10 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, int rw,
 again:
 	ce = search_cache_extent(&map_tree->cache_tree, logical);
 	if (!ce) {
-		kfree(multi);
 		*length = (u64)-1;
 		return -ENOENT;
 	}
 	if (ce->start > logical) {
-		kfree(multi);
 		*length = ce->start - logical;
 		return -ENOENT;
 	}

---
base-commit: d1d53c252a4a746db5ebcdf0d6de3aa0feec504e
change-id: 20250708-btrfs_fix-a24cbe4ad37b

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

