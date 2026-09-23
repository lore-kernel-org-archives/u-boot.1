Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34BE3C98304
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 21:30:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD70341307;
	Wed, 23 Sep 2026 21:30:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BlJRxIxMbYsQ; Wed, 23 Sep 2026 21:30:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E038241305
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790199051;
	b=qnUWCnRpZ140gXG/qHRhTei47egldbfYFuYD9xi8uNA3QUJxdOXHZ7YMVbf0ZsIsCZ4D
	 2LJE2NhPSBiup4kGfnLkPHTA5dD2rRIUUUMSmrX/CMj1YaG2WfC2qSsYxX1fcGmNco2tb
	 v9V8P43vugFXKC8/at314UWvOG010TfnWCNihJ98JlCddM3mKlqRB2+iaO36RpbnrVlHX
	 EdmlKanruLFIn9jXvtF8I3IrOGlPrViT//2RMQoR4N753PSLNHIs3D/+S552jzjUBOxRC
	 oYjihlUhpPSjvxQ/cYdq9EVhuEOBFmuKlQHY300iJv8aL5KHXlE05gyKNICB2i+XjxQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790199051;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YVFeLjR1SXS1XUIJZ79QmN8gmIyGPJPbAmpqUwwtzbk=;
	b=nRZ54z7zBqFmDJ8QPG3KFxjmS3UfJMZ/4frc6RR7SEMBgDuFQwH6g+Za35Sg9pRpU2I/
	 KwwVhJsFJl3/nGInxvH1c/qDV5fti4XY+2VXJBcVOV/2smDsgWYI3ZOiEMoqEqSt9bFyq
	 Kw0fvG9saVOXVe4MlOyI2urlPxsqscRFqKzHxTSiNHxYglttXJT+cmmSG/KkODRszTHFm
	 M/k0cL3zR5n3C/nGcLiJabTHCY1qGjp6s2of4k4yOyFj5xQ885tKTpCt/4aHs3NnPZGPk
	 lOWK3GFTw0o+WVc/EPb1BW0wvGl6m6+xaxy5Dor33b6b8wo6HlmzD1iR1GwX6kPeK4w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790199051;
	bh=YVFeLjR1SXS1XUIJZ79QmN8gmIyGPJPbAmpqUwwtzbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aozQByeiOLTP29PZ2wsQ7q1L3KF9BhzjoH8BeQ4DACU7qvfe47d8eMY5BdnWpoWrn
	 AYBDbW8Tk7baax8bBgeF4ZUYGMOQBk/qLJc6PAr8AYMl6L+xeHkyyULyBTh9PYdi3r
	 KttaeciJxdJmxixGO9UBw9oLew5Xuc6rcsW2FizlwQDz3suPl0i7vLB0ucI61ivLNn
	 Pn/jUcjflWeigmg/X4M6uWFzQhHW80u+oTapn++N4luzwB2pQxoGGFP9bFpscD0CI/
	 xXWrl999LExJA9q5W2HaiwMvOV6yS9yj0mFpiHEgeJGYqr1WmsxVvpMoNteEG6mHEB
	 9AFN2bu5VP/Qw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E038241305;
	Wed, 23 Sep 2026 21:30:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D6BCA3B7
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:30:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C880C60B85
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:30:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p3nXqcjpNCkT for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 21:30:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CD56560B3F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790199049;
 b=iVIsTuw0Qz4UJlDzsgsbCoWI3vkZ08OxLih1o+iJsaVquplLDQlrujHGIs5GVy7vBN7c
 F/6A4O9hfuEsfXnHSFTMmCkx9Ok19UqHGbPsA43weesDtT7Ey7YOFb1CztaLQAA5OV6OL
 jLhWIcbbrPtbIwgvAktG8C5a1qOhsn7VLM6sO6M9OBs9b7GiGs4QBIY0qthRHFrEYnKAg
 B4e6MNP8TjKWlf8m3UfBxkdpNv4F3eaeJGDiswWqqnJBMfCH5rsYt5KFudmWD8IecJMiF
 7eqLsynGO5BA98v5wtsv8DbeAkIstNRED+pdGY8o/kAw0QAAjZdoQkzajMuaw1tZ4QA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790199049;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=YVFeLjR1SXS1XUIJZ79QmN8gmIyGPJPbAmpqUwwtzbk=;
 b=LS2fbCS+vtndXUQGByH1cd9lJ7/y0G8B1i4h7z37POX13+sXUL9nlF8OjEsrPcCSXp0E
 oio2yhw51tW8NEKTLzxx3GLf8BBKiNJ+2LTUrpZ7naQtQO82ZYWMODIfW66fTxX62Dlg1
 ZVHu5XgYBGDYAQSewbDet/ELzTOOV1OkrSkQ9Q8AJpoBDPhsk4jw1fnDAvPLbAzwhPsTk
 Dgpyo/sCdIRrDLlro4DDdziJE8aZgti0wXmGbHDLKEOzD63PnB+RtTxs46UqUWFTMxtsb
 FPhzSREElY3rVSE4G/HnUXNPLbswdiAIJhpE0gEnLadz4ANKKrVKYXTQCrYDWpazhww==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=nIswVgrd; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=nIswVgrd
Received: from mail-pj2-x11.google.com (mail-pj2-x11.google.com
 [IPv6:2607:f8b0:4864:39::11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CD56560B3F
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:30:48 +0000 (UTC)
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-398c066106cso862673a91.1
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 14:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790199048; x=1790803848;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YVFeLjR1SXS1XUIJZ79QmN8gmIyGPJPbAmpqUwwtzbk=;
 b=nIswVgrdn5lEuf2lB16ppUsMfhT0VuIQD/VGotrpgleMDp0tG2A3DuiS835I9wSucN
 qAgQhwcLxx2/4Ln5LfnTRZuhuCAJPMXl5Qc8CaV4IQNd7pp20ddXLu2sWc82sy7W95po
 cq7Pbtl6zGxBsLbKicvBV4157Bhu6u0rTUe5ecs0lvzWKEklNfRCfufGnc0cKYkww9ZR
 QRJ809VXkUx3OplCWjING/XuqRD/18lFlPzAYlczmSwlzpLLOSpBDMZVnyA38UqnObF7
 yQrfoKOiKvEo1O/JPrUP4FTqLGjckEZ8lPo0lJ3Uq+JkPR+2NtBg5JyFAWQMKEifmnPM
 NC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790199048; x=1790803848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YVFeLjR1SXS1XUIJZ79QmN8gmIyGPJPbAmpqUwwtzbk=;
 b=VjWJfJgYahplrrCUon8K6LB5xni+Zrig8ReCwRsZ2p0y3ARLbrkabOe9LZyAb4Xwhg
 zgA4HOGKNPCnirZWzp1cq9xEbFv8fOr/Db2WlzRElDyTplDT1cJm4QCZAJNsQVBeTVqo
 Nk5XGLI+ukTQ8TqjU+hyTgCQc22OPCJm47CYnhwTQ0ylDJWOzAkzfXRPOOUTdoKLzBh0
 2aGFAKt0gg1T/lubkT2PXGum8lOmYfXOswzwiFaiqKUbUZCtcBUXK61F65Upqof1O7cP
 bXh/LQt9I8tIAlZ1FsvWRd685D0+/6aftfsnd5zwPzOwEo2K6bAzO70XWe94qXYEzegV
 tETQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy/HaS65uUvgmv9JwJiI1IZtV/u8joH/HsM3pqZ/8wnNJAhDp7RH+2FwAmuEigdbh+eSGJ5Wq4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++ntTRuaAROGtbFyBjf3t8yMCi1LfbgaLdqG3KHFTz78uYe1wo83
 N7G7eUhyXyHpbuAcuN4Sr++TgXC+ApXJmcGmMFlr0rrDnzbhDa1LmXFQ
X-Gm-Gg: AYBFou3PfVo7fOcctMGPnhv+l2V7V60LCqinjYoCSDxNZTcpyDK/Pdve3IoVuguHJSr
 ElMCn/FR7gpm2mRVY/KCA7WoQhbX34Ar16sRCe6DMYvy9Mhl2s7MUfj+xqrNS7mWeZHBYvP/6Hh
 XAXRtQPGB3HVGcp8iUgJbNqET2JaWxY64zMKIf4KTfsOxpvV0menheSVoh2H81VdJKbfICGlWjh
 8w7KixNFUDphmP17RL7EUyV9Slzsow8ahFIiiiMpvLVr7DAxnVrp+0j4yAopNFR19ryuCocG+7m
 7jybcQGz+VcQQilLdMUqFMw4LMctleF+rPLkbLkhK/ZoRst6t0endErWuavbaJcBtBjuaDCzPZk
 gDDe6BWpdDii/f3XLd1fkmqVcUPADxLUR2mH/4R5/uwGptiKu101frfznLiynwO3oG+BI84nAmi
 tsGrIphvR6Yv6gy8BjBPSu2DeioVYjBWKPZooYczHXNkQILoXzVT2t28dXBXdJkCbKfF+6NLJnr
 My42tRBWR7EJAmGwqOFhh7rlKQ0yLdXn16YNGmPJZ/DuIDujsXxM1TsvsJUp7uIkGo2NVmcpESN
 9BNlsYT18zY=
X-Received: by 2002:a17:90b:1a91:b0:39e:3554:4d0e with SMTP id
 98e67ed59e1d1-3a09856fba3mr327623a91.1.1790199047632; 
 Wed, 23 Sep 2026 14:30:47 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (202.176.229.35.bc.googleusercontent.com. [35.229.176.202])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0973c4fb4sm909513a91.17.2026.09.23.14.30.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 14:30:47 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: trini@konsulko.com, tuomas.tynkkynen@iki.fi, bmeng.cn@gmail.com,
 sjg@chromium.org, jerome.forissier@arm.com
Cc: jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, marscheng@google.com,
 u-boot@lists.u-boot-project.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v3 2/6] fs: 9p: Add 9P filesystem support
Date: Wed, 23 Sep 2026 21:29:58 +0000
Message-ID: <20260923213002.1070404-3-visitorckw@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
In-Reply-To: <20260923213002.1070404-1-visitorckw@gmail.com>
References: <20260923213002.1070404-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Implement the VFS interface for the 9P filesystem.

Map VFS operations to the underlying 9P protocol client and register
the 9P filesystem type, allowing access without traditional block
device partition tables.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 disk/part.c    |  16 +++++
 fs/9p/9p.c     | 185 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/9p/Kconfig  |   8 +++
 fs/9p/Makefile |   5 ++
 fs/Kconfig     |   2 +
 fs/Makefile    |   1 +
 fs/fs.c        |  25 +++++++
 include/9pfs.h |  60 ++++++++++++++++
 include/fs.h   |   1 +
 9 files changed, 303 insertions(+)
 create mode 100644 fs/9p/9p.c
 create mode 100644 fs/9p/Kconfig
 create mode 100644 fs/9p/Makefile
 create mode 100644 include/9pfs.h

diff --git a/disk/part.c b/disk/part.c
index 4923dc44593..8fa1dfd4c19 100644
--- a/disk/part.c
+++ b/disk/part.c
@@ -482,6 +482,22 @@ int blk_get_device_part_str(const char *ifname, const char *dev_part_str,
 	}
 #endif
 
+#if IS_ENABLED(CONFIG_FS_9P)
+	/*
+	 * Special-case a pseudo block device "9p", to allow access to the
+	 * 9P filesystem.
+	 */
+	if (!strcmp(ifname, "9p")) {
+		strcpy((char *)info->type, BOOT_PART_TYPE);
+		if (dev_part_str)
+			strlcpy((char *)info->name, dev_part_str, sizeof(info->name));
+		else
+			strcpy((char *)info->name, "9P filesystem");
+
+		return 0;
+	}
+#endif
+
 #if IS_ENABLED(CONFIG_CMD_UBIFS) && !IS_ENABLED(CONFIG_XPL_BUILD)
 	/*
 	 * Special-case ubi, ubi goes through a mtd, rather than through
diff --git a/fs/9p/9p.c b/fs/9p/9p.c
new file mode 100644
index 00000000000..41d46b7328e
--- /dev/null
+++ b/fs/9p/9p.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026, Kuan-Wei Chiu <visitorckw@gmail.com>
+ */
+
+#include <9p.h>
+#include <9pfs.h>
+#include <dm.h>
+#include <log.h>
+#include <malloc.h>
+#include <part.h>
+#include <asm/unaligned.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+static u32 p9_root_fid = 1;
+static struct p9_client *current_p9_client;
+
+int p9_fs_set_blk_dev(struct blk_desc *fs_dev_desc, struct disk_partition *fs_partition)
+{
+	const char *tag = NULL;
+	struct udevice *dev;
+	struct p9_client *c;
+	int ret;
+
+	if (fs_partition && fs_partition->name[0])
+		tag = (const char *)fs_partition->name;
+
+	ret = p9_get_device(tag, &dev);
+	if (ret) {
+		log_err("9P Error: No matching 9P transport device found for '%s'\n",
+			tag ? tag : "-");
+		return ret;
+	}
+
+	c = p9_get_client(dev);
+	if (!c)
+		return -ENODEV;
+
+	if (p9_client_version(c))
+		return -EIO;
+	if (p9_client_attach(c, p9_root_fid, "root", ""))
+		return -EIO;
+
+	current_p9_client = c;
+	return 0;
+}
+
+int p9_fs_ls(const char *dirname)
+{
+	struct p9_client *c = current_p9_client;
+	u32 fid;
+	u8 *buf, *ptr, *end;
+	u32 actread;
+	u64 offset = 0;
+	int count = 0;
+	int ret;
+
+	if (!c)
+		return -ENODEV;
+
+	fid = p9_client_alloc_fid(c);
+	if (p9_client_walk(c, p9_root_fid, fid, dirname))
+		return -ENOENT;
+	if (p9_client_lopen(c, fid, P9_O_RDONLY)) {
+		p9_client_clunk(c, fid);
+		return -EIO;
+	}
+
+	buf = malloc(4096);
+	if (!buf) {
+		p9_client_clunk(c, fid);
+		return -ENOMEM;
+	}
+
+	while (1) {
+		ret = p9_client_readdir(c, fid, offset, 4096, buf, &actread);
+		if (ret || actread == 0)
+			break;
+
+		ptr = buf;
+		end = buf + actread;
+		while (ptr + sizeof(struct p9_dirent_hdr) <= end) {
+			struct p9_dirent_hdr *entry = (struct p9_dirent_hdr *)ptr;
+			u64 next_offset = get_unaligned_le64(&entry->offset);
+			u8 d_type = entry->type;
+			u16 name_len = get_unaligned_le16(&entry->name_len);
+			const char *name = (const char *)(entry + 1);
+
+			if (ptr + sizeof(struct p9_dirent_hdr) + name_len > end)
+				break;
+			printf("  %s %.*s\n", (d_type == P9_DT_DIR) ? "<DIR> " : "      ",
+			       name_len, name);
+			offset = next_offset;
+			ptr += sizeof(struct p9_dirent_hdr) + name_len;
+			count++;
+		}
+	}
+
+	free(buf);
+	p9_client_clunk(c, fid);
+
+	if (ret)
+		return ret;
+
+	if (count == 0)
+		printf("  (empty directory)\n");
+
+	return 0;
+}
+
+int p9_fs_size(const char *filename, loff_t *size)
+{
+	struct p9_client *c = current_p9_client;
+	u32 fid;
+	int ret;
+
+	if (!c)
+		return -ENODEV;
+
+	fid = p9_client_alloc_fid(c);
+	if (p9_client_walk(c, p9_root_fid, fid, filename))
+		return -ENOENT;
+	ret = p9_client_stat(c, fid, size);
+	p9_client_clunk(c, fid);
+
+	return ret;
+}
+
+int p9_fs_exists(const char *filename)
+{
+	loff_t size;
+
+	return (p9_fs_size(filename, &size) == 0) ? 1 : 0;
+}
+
+int p9_fs_read(const char *filename, void *buf, loff_t offset, loff_t len, loff_t *actread)
+{
+	struct p9_client *c = current_p9_client;
+	u32 fid;
+	u32 read_bytes = 0;
+	loff_t total_read = 0;
+	loff_t remaining;
+	u32 req_len;
+	u8 *dst = (u8 *)buf;
+	int ret = 0;
+
+	if (!c)
+		return -ENODEV;
+
+	fid = p9_client_alloc_fid(c);
+	if (p9_client_walk(c, p9_root_fid, fid, filename))
+		return -ENOENT;
+	if (p9_client_lopen(c, fid, P9_O_RDONLY)) {
+		p9_client_clunk(c, fid);
+		return -EIO;
+	}
+
+	while (1) {
+		if (len == 0) {
+			req_len = 0;
+		} else {
+			remaining = len - total_read;
+			if (remaining == 0)
+				break;
+
+			req_len = (remaining > 0xFFFFFFFF) ? 0xFFFFFFFF : (u32)remaining;
+		}
+
+		ret = p9_client_read(c, fid, offset, req_len, dst, &read_bytes);
+
+		if (ret != 0 || read_bytes == 0)
+			break;
+
+		total_read += read_bytes;
+		offset += read_bytes;
+		dst += read_bytes;
+	}
+
+	*actread = total_read;
+	p9_client_clunk(c, fid);
+
+	return ret ? ret : 0;
+}
diff --git a/fs/9p/Kconfig b/fs/9p/Kconfig
new file mode 100644
index 00000000000..bc6d4962288
--- /dev/null
+++ b/fs/9p/Kconfig
@@ -0,0 +1,8 @@
+config FS_9P
+	bool "9P filesystem support"
+	depends on NET_9P
+	help
+	  This provides support for the 9P2000.L filesystem.
+
+	  To use this filesystem, you also need to enable a 9P
+	  transport driver.
diff --git a/fs/9p/Makefile b/fs/9p/Makefile
new file mode 100644
index 00000000000..c7f7553e8f4
--- /dev/null
+++ b/fs/9p/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2026, Kuan-Wei Chiu <visitorckw@gmail.com>
+
+obj-y += 9p.o
diff --git a/fs/Kconfig b/fs/Kconfig
index e0b0b901e1d..e4aa726ea35 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -26,4 +26,6 @@ source "fs/squashfs/Kconfig"
 
 source "fs/erofs/Kconfig"
 
+source "fs/9p/Kconfig"
+
 endmenu
diff --git a/fs/Makefile b/fs/Makefile
index ce5e74257a0..5aa34b39172 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -26,5 +26,6 @@ obj-$(CONFIG_CMD_UBIFS) += ubifs/
 obj-$(CONFIG_CMD_ZFS) += zfs/
 obj-$(CONFIG_FS_SQUASHFS) += squashfs/
 obj-$(CONFIG_FS_EROFS) += erofs/
+obj-$(CONFIG_FS_9P) += 9p/
 endif
 obj-y += fs_internal.o
diff --git a/fs/fs.c b/fs/fs.c
index 2824c7defa2..b18ccec8cb4 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -32,6 +32,7 @@
 #include <squashfs.h>
 #include <erofs.h>
 #include <exfat.h>
+#include <9pfs.h>
 
 static struct blk_desc *fs_dev_desc;
 static int fs_dev_part;
@@ -400,6 +401,26 @@ static struct fstype_info fstypes[] = {
 		.mkdir = exfat_fs_mkdir,
 		.rename = exfat_fs_rename,
 	},
+#endif
+#if CONFIG_IS_ENABLED(FS_9P)
+	{
+		.fstype = FS_TYPE_9P,
+		.name = "9p",
+		.null_dev_desc_ok = true,
+		.probe = p9_fs_set_blk_dev,
+		.close = fs_close_unsupported,
+		.ls = p9_fs_ls,
+		.exists = p9_fs_exists,
+		.size = p9_fs_size,
+		.read = p9_fs_read,
+		.write = fs_write_unsupported,
+		.uuid = fs_uuid_unsupported,
+		.opendir = fs_opendir_unsupported,
+		.unlink = fs_unlink_unsupported,
+		.mkdir = fs_mkdir_unsupported,
+		.ln = fs_ln_unsupported,
+		.rename = fs_rename_unsupported,
+	},
 #endif
 	{
 		.fstype = FS_TYPE_ANY,
@@ -501,11 +522,15 @@ int fs_set_blk_dev(const char *ifname, const char *dev_part_str, int fstype)
 	if (info) {
 		fs_dev_desc = NULL;
 		memset(&fs_partition, 0, sizeof(fs_partition));
+		if (dev_part_str)
+			strlcpy((char *)fs_partition.name, dev_part_str,
+				sizeof(fs_partition.name));
 		if (!info->probe(NULL, &fs_partition)) {
 			fs_type = info->fstype;
 			fs_dev_part = 0;
 			return 0;
 		}
+		return -1;
 	}
 
 	part = part_get_info_by_dev_and_name_or_num(ifname, dev_part_str, &fs_dev_desc,
diff --git a/include/9pfs.h b/include/9pfs.h
new file mode 100644
index 00000000000..130cb06ac3c
--- /dev/null
+++ b/include/9pfs.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2026, Kuan-Wei Chiu <visitorckw@gmail.com>
+ */
+
+#ifndef __9PFS_H__
+#define __9PFS_H__
+
+#include <linux/types.h>
+
+struct blk_desc;
+struct disk_partition;
+
+/**
+ * p9_fs_set_blk_dev() - Set/probe block device for 9P filesystem
+ * @fs_dev_desc: Block device descriptor (expected NULL for pseudo dev)
+ * @fs_partition: Disk partition information
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int p9_fs_set_blk_dev(struct blk_desc *fs_dev_desc, struct disk_partition *fs_partition);
+
+/**
+ * p9_fs_ls() - List files in a directory
+ * @dirname: Path to directory
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int p9_fs_ls(const char *dirname);
+
+/**
+ * p9_fs_exists() - Check if a file exists
+ * @filename: Path to file
+ *
+ * Return: 1 if file exists, 0 otherwise
+ */
+int p9_fs_exists(const char *filename);
+
+/**
+ * p9_fs_size() - Get size of a file
+ * @filename: Path to file
+ * @size: Output pointer for size
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int p9_fs_size(const char *filename, loff_t *size);
+
+/**
+ * p9_fs_read() - Read file content into memory
+ * @filename: Path to file
+ * @buf: Destination memory buffer
+ * @offset: Byte offset within file
+ * @len: Maximum bytes to read (0 for entire file)
+ * @actread: Output pointer for actual bytes read
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int p9_fs_read(const char *filename, void *buf, loff_t offset, loff_t len, loff_t *actread);
+
+#endif /* __9PFS_H__ */
diff --git a/include/fs.h b/include/fs.h
index bec02117737..8afc81c0017 100644
--- a/include/fs.h
+++ b/include/fs.h
@@ -19,6 +19,7 @@ struct cmd_tbl;
 #define FS_TYPE_EROFS   7
 #define FS_TYPE_SEMIHOSTING 8
 #define FS_TYPE_EXFAT   9
+#define FS_TYPE_9P      10
 
 struct blk_desc;
 
-- 
2.56.0.rc1.310.g51773c2048-goog

