Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F31C1C27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 22:35:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44A96883C2;
	Tue, 18 Jun 2024 00:35:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H+hnYIQt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33A2186EB5; Mon, 17 Jun 2024 21:49:55 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AC6F883A4
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 21:49:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexthreed@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52bbdb15dd5so5370341e87.3
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 12:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718653792; x=1719258592; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LXXi/Cgj7O5qRRCu4B0r1vEcE07p4zz2tufdZsci5l0=;
 b=H+hnYIQtZyfrrz47hYVr2FAcdvYiVy2dIu1ctVv0Vox7cAN4+q1NO4Fgyu1BHTvhLR
 Fn4epAjDw53T4OZ4b8Vhaz1A4dGBsIVA1+Szi3tP/Ru+9K5rqErL6J7gXO2JL6cx6Ram
 QZvbxktWkNEKXoBpQ5dxqWdSqhYRgTR3NNnk/lm9giizSamWKdYzSZOfgh+rfY3ek6Ys
 zLx+GBND4rYpPOUCIEFjDb0brDELyMSYF1Dd9CX5J4Vpg/16pR5xD2SpJAnjUeIOTCxV
 EAyjcyJ/g583/NFb2xW+Qpn3uCTsZe6OmNXRjs93TMffnARMhhftqAHKT989tr1B9mvL
 gqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718653792; x=1719258592;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LXXi/Cgj7O5qRRCu4B0r1vEcE07p4zz2tufdZsci5l0=;
 b=jF+uB7jlR60dryRBfdpO2z62w/kWQz8h+SuzEkUli5WcG0VxnGAALsTwpAgAQm3kOB
 q0yeIs9UdMs1yAc8TJ46UZkpRQQFnLr/do8Wdz0yj/dDV6DN08B2wktKPvuUL/oo/qtz
 610zNfjYc16CBYLiIJwv8LNg78hGvj4pk8m+aFWqwxlPtLeGquiSaZWVdLIv8cAluA1O
 MI7B4K676HFn15Tr/WJii+BvJtlOyBoTM6upz85ZFlsXRu+TGiCHl6m4ON4EiaXDuxsR
 jXKmGIdcEExmbLdhOOHJOLOvzqPzy2SuCKqnl8b7Cd5l6yNm8rEdsHonILX+eVb4oJPB
 UOiQ==
X-Gm-Message-State: AOJu0YwPhbQsmk145GkmkqneHLl9CGwZun9CIMIkqFL0+yguCIsPp6qG
 R6GtBBaGVcbU8sAZcuGzk2bJnNKLRzJESq4yRepjDxJhLR0r8ZsdIHaq8X6AViw=
X-Google-Smtp-Source: AGHT+IH0ikRVJ88LUs9iCWD0vp5IzrdVUxxUJd4NkNtMCCqaEBI6w65n/LAuQNqUdUtjFUaUGX9nyg==
X-Received: by 2002:ac2:4cb1:0:b0:52c:8fd7:2252 with SMTP id
 2adb3069b0e04-52ca6e55ab1mr5761206e87.11.1718653791930; 
 Mon, 17 Jun 2024 12:49:51 -0700 (PDT)
Received: from alex3d.netup (team.netup.ru. [91.213.249.1])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-52ca2825670sm1334557e87.43.2024.06.17.12.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 12:49:51 -0700 (PDT)
From: Alex Shumsky <alexthreed@gmail.com>
To: u-boot@lists.denx.de
Cc: Alex Shumsky <alexthreed@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Qu Wenruo <wqu@suse.com>, Tom Rini <trini@konsulko.com>,
 linux-btrfs@vger.kernel.org
Subject: [PATCH] fs: btrfs: fix out of bounds write
Date: Mon, 17 Jun 2024 22:49:47 +0300
Message-Id: <20240617194947.1928008-1-alexthreed@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 18 Jun 2024 00:35:09 +0200
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

Fix btrfs_read/read_and_truncate_page write out of bounds of destination
buffer. Old behavior break bootstd malloc'd buffers of exact file size.
Previously this OOB write have not been noticed because distroboot usually
read files into huge static memory areas.

Signed-off-by: Alex Shumsky <alexthreed@gmail.com>
---

 fs/btrfs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4691612eda..b51f578b49 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -640,7 +640,7 @@ static int read_and_truncate_page(struct btrfs_path *path,
 	extent_type = btrfs_file_extent_type(leaf, fi);
 	if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
 		ret = btrfs_read_extent_inline(path, fi, buf);
-		memcpy(dest, buf + page_off, min(page_len, ret));
+		memcpy(dest, buf + page_off, min(min(page_len, ret), len));
 		free(buf);
 		return len;
 	}
@@ -652,7 +652,7 @@ static int read_and_truncate_page(struct btrfs_path *path,
 		free(buf);
 		return ret;
 	}
-	memcpy(dest, buf + page_off, page_len);
+	memcpy(dest, buf + page_off, min(page_len, len));
 	free(buf);
 	return len;
 }
-- 
2.34.1

