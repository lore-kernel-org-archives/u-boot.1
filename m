Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23758606A32D
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 05:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ryeHZc15;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=K1SLc/bv
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E54D140643;
	Mon, 23 Nov 2026 05:23:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FnQUStEuDSa8; Mon, 23 Nov 2026 05:23:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1E38240648
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795411398;
	b=tEMhrihD/CYnWKTSZAzkZREXEKKZ3688Q2uxOHpBDWvOaJO4cx5f3qG/HVocA78xVlkE
	 +3WFsWZJp2X2HhCX1jE26upacwpW7n86cYZlXoXm3jiDWwQ9cExVK3T9tDA10Vt3SNUYj
	 2esdwh/bs2y45zDJL/yOjJB6vWQdhcOHIm6Z1kAnKwNzH+eXSfD/+hHHSo7aHdAJ3lUYq
	 9ZVKuY8AQ0eRdW69uBRNlCK6FCmd+spKglW1AwpIQFkG0h97GHz9Xc2oIKNYRtEJ39dWn
	 6oCE1a1zojQvwiAB+BvofjAgLfWHjVx3yz1aNXxcH8IaeD2FzsRJFLUMq5XAR5GSC8A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795411398;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/pg8EuQGbrqTM37NdPboAKzUZzRbsLMd+Yn5/Mivm0Y=;
	b=kIakgtC0e5Uf1yX45MU2XcoUxQnWtWNrNFtsSeOMVgC5BE7GEV9ble6k1HADHhnFN7kC
	 Yt68nP6ujhvgDzcemBxY6SsrYzP90YEY5JCcuptjajVUnC4JqvGp3HW2BNInurh48uA1o
	 VCTj9EzkaA01NYFFTG0giMgZy6S/tux9NEaZ0udJda9T4inKbwmLhSOPnZ4kW+hu6HbRU
	 BZGtneEqgteaaFQyWZrgjlVoea2KoE7lJ2KaJL5EiWr7AhgkTVIygXqapsjbxZ3m+MjqY
	 F1o/Hu+y3jN6kj5P+x0TmjzLfxmjWQx09Feg2/0dFR4/hZQ0934qM9hKKSFd5icwimA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795411398;
	bh=/pg8EuQGbrqTM37NdPboAKzUZzRbsLMd+Yn5/Mivm0Y=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ryeHZc150VB8G64IMq9A+r1lgzfdOZ2lW4JOZGXmvhfQJLBFSxITM+q4x+DYhamud
	 BEqNjhllkfl5C5KVELtcMiwkl7I/EdOSFWdRkTc0ZnG5jrsF+GAudmtNZoVFF2XEWD
	 zTNRMDcuBnmXTPdFQKpOdzrvFn7MsZ9luBdKyaOpnFRRQpCc0x6+g9ZqYkgBBIkmgI
	 5zFSHLroTeQJg3gYxWkwO3Vc9WMdjh6L/NYTcF+7gnK9tZCGerOWeolu3bMFsIsLOa
	 7/Aehbzv7e5tPr1b3SKJJvBXSMq2uCCxu/16XrUB1bL+j5wfrStat2TLWnhWAp8MZ4
	 frW49R5K1NZ3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1E38240648;
	Mon, 23 Nov 2026 05:23:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 251D0392
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 05:23:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 169B460697
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 05:23:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QfFFHx_Az3P5 for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 05:23:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 099D460603
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=K1SLc/bv
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 099D460603
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 05:23:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9495411026C; Mon, 23 Nov 2026 06:23:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1795411389;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=/pg8EuQGbrqTM37NdPboAKzUZzRbsLMd+Yn5/Mivm0Y=;
 b=K1SLc/bvLvqJtN4I21SH410rW31nViGG5n+e6vm/v9P9/44jzPX6D/Ce8xc8gFt50d5/e4
 hFfIGhoY4mC2NUAq5th/66Pm7f5Cq8+cFtMuJt3UTCrZOAKLJ1sXDQ/z/PM/AIvchAq+PC
 RbyeZA7uPUPrQUDuJc3X76ZcA2jd/ptfOrS+1WgerL9HWnjZvNXiKrK3+65V5ejS/Yj4gm
 5+ULlmJZQvxcHoF5FdWaccWxGVZanhlEOYNqnGVei4Uy5DjDAKZ+3dj3qSjyZxb3dhrE87
 F0SYapra61OPOE7FNosL/ci5bCWYFY60YO0AG3EKgQe18EFBdRXJLuyKDQ3Ibg==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@nabladev.com>,
 Marek Vasut <marex@nabladev.com>, Michal Simek <michal.simek@amd.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v1] Update maintainers and get_maintainer.ignore
Date: Mon, 23 Nov 2026 06:22:52 +0100
Message-ID: <20261123052301.473945-1-hs@nabladev.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Dinesh has left Altera (Info from Alif Zakuan Yaslami) and
has not changed yet his email address.

Signed-off-by: Heiko Schocher <hs@nabladev.com>
---

 .get_maintainer.ignore | 1 +
 MAINTAINERS            | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.get_maintainer.ignore b/.get_maintainer.ignore
index 76b816a4d56..ed350dc4d2b 100644
--- a/.get_maintainer.ignore
+++ b/.get_maintainer.ignore
@@ -1,3 +1,4 @@
+Dinesh <dinesh.maniyam@altera.com>
 Pali Rohár <pali@kernel.org>
 Simon Glass <simon.glass@canonical.com>
 Simon Glass <sjg@chromium.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index 6edf740a9ce..33af5ed3075 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1137,8 +1137,7 @@ T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-i2c.git
 F:	drivers/i2c/
 
 I3C
-M:	Dinesh <dinesh.maniyam@altera.com>
-S:	Maintained
+S:	Orphan
 T:	git https://git.u-boot-project.org/u-boot/u-boot.git
 F:	cmd/i3c.c
 F:	drivers/i3c/
---
base-commit: e578056c766d653270b14557c2a9d8daec414c17
branch: maintainerupdate

-- 
2.55.0

