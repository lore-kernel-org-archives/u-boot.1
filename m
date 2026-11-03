Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EF9606A331
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 16:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pDjI0deW;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cd+cP/3K
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CA7BB605B5;
	Tue,  3 Nov 2026 16:50:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2IphsJ2gpLoS; Tue,  3 Nov 2026 16:50:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 23693606CE
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793724614;
	b=noO+KF7coMgRqgpztCmgyA0OOvywNq6ixoyhI4afsjq4MQvaDQCBPFA1BmbX2yrus/oM
	 X/C7j2Mt4B5/LVWR3ZFgNVxe4jcEAolK3WPjo80xOH9rJ5DA8DCm4xZ8NPVuXGl5Xtws6
	 i4CQ9QCJ8RmttA7GE+Ynh4JdbD0hxek7nVZ8Mm11dCub7sQQDOPwekmnF61r6iNMmJKWa
	 Q0vZyx+OPmVna5w3PXCBhhE2DV4OQY2zlYX07MTYAy09bUlDXjMYbfxnApmEPX5h9g2IL
	 otblLDo3C2qkRNEc644pYakv6ekOJmr7/r5f7sduScOc7Ssv4Y7cdbQa9aDm0P9TOSg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793724614;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Virus-Scanned:X-Virus-Status:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=La1dibXF3oZ/05I7jyTVx5/57ddqni9keast6vEUmt0=;
	b=J36etjsgHItZBl08P7yC27H33UK/xvCkrY27DpuE1L/sHBDuqgucY5Htd+ysJUIMWeJm
	 o0JeRYfpGKOZwDCUUx7VuEDwjSoMpO+iKXrzreXC3nkJLXL7dUPoaaPcZvvLO8peQoE6Q
	 AT9f8T6ofsDNFQCF/9NICZHEyzrsU+1hN3SrN3LT4wEN5nm1/F6RBsf7AkRy2EBXxU4k9
	 CgZZXi82vbV3GCtZdMVbryurFjM5SK1ino+j9AxzUhBEzwHIh5YZQD5jQWgYLe6Lcj4i0
	 rNV060uae9QVDAdFE+gPprJgFXci1UAbLq83XFaq5mwWlwYJf0i/zRuTJKpQK3wUhBA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793724614;
	bh=La1dibXF3oZ/05I7jyTVx5/57ddqni9keast6vEUmt0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pDjI0deWHOa7Tk2CCgrcgLjhGyRMVsUvonst+mgnQXD/QO2EkwwALpDlaoLQD6Hcm
	 a2b6x+4APmKLghAm5EHVjMO70hrpJd359wB1Qcno+oVlh8K1d9nxcjoiM0iSrnhRYZ
	 oFis/bE/uUE63vlcFLv8deFX2o77ZKbhL2uQ7o7+awhe0o+gQ9zcdxqMYNCKZaaOhB
	 IVCchb7pr0huaSLrKLC1xQDwEdL6eDHoqzJBSqYacsG4AhhSArbAGF/htZhgM+rBZk
	 B91gzNDg+8VM04/Ov9D9uwa78lP0J2uQEZqyygQX9IByifozdDdaWuuWHrqURHooQF
	 kkZu7cAp43qig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 23693606CE;
	Tue,  3 Nov 2026 16:50:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 06AB24BC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:50:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E04E240068
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:50:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EKY0YRHFmquP for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 16:50:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 951A340062
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=85.214.62.61
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793724612;
 b=GTyUTH1p3FsIQ2dF2tUGbqRC1oRSTCnCPytbnGJ1rpaRG9vDZ8G+/Rqs5c41iTGEjo08
 HZP779sY3OmZ429HiYsaFKAEBFSrkvRYrtI3HLBJXODZo5lTq/z4+oTvQyMVRu8mgPZCb
 DmxEWPtiMgjGhZMOYr0oBP2G2QJVW0yIHc8wTg5RwQ+OtZZs+avNbDkhKHq9LYceIVRWp
 8zyrlkHPa1Nf30lC6NRvMQUbsgFbeIwDH4JGYjL3iShprMWccIhao9qW/lIbG5lxd/C31
 lWcpFAReJMf7Pro+Q2d4tScERsW8OSTm9vDC2Zk413rQaf/dWbToiXs6Q6vhAnopImg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793724612;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-Virus-Scanned:X-Virus-Status;
 bh=La1dibXF3oZ/05I7jyTVx5/57ddqni9keast6vEUmt0=;
 b=FBg7Q/XGwYG9sOFauAffdY3TwT+mN7csrQEr71G7NdpIaw0qXJN+Nix3xsEEJ0URB9bO
 rU0VaftLnjR30OUFFze28l9qNDcDeuOfzoFZ8mSkuAH61vnjZx12xCDWp8mQEop+YEQDL
 lqruX7j5inCrVr4YUYgc11HrmbhAuMaJbql5WKyABWSkUMYtEdsofueyM5gd7HHXvt25l
 sKKYrLNEYts9R1DAm3cYvNprQGdCTVnGMpFKkwjhz7z3ITxzKRc8sd5Avlao0Bl7Ie9yx
 4eqkv74uk1ujQeERfyc26pRPDUPoU5IIzWGxPpnJB/h3tYJvdl7qH9e3sDWQfK2zaoA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 spf=fail smtp.mailfrom=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b="cd+cP/3K"; 
 arc=none smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=wpopov@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; spf=fail smtp.mailfrom=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=cd+cP/3K
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 951A340062
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:50:11 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B6568482A; Tue,  3 Nov 2026 17:50:08 +0100 (CET)
Received: from mail-yx1-xb132.google.com (mail-yx1-xb132.google.com
 [IPv6:2607:f8b0:4864:20::b132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F4A18480F
 for <u-boot@lists.denx.de>; Tue,  3 Nov 2026 17:50:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wpopov@gmail.com
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-67a6cc9acbeso2119084d50.3
 for <u-boot@lists.denx.de>; Tue, 03 Nov 2026 08:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793724600; x=1794329400; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=La1dibXF3oZ/05I7jyTVx5/57ddqni9keast6vEUmt0=;
 b=cd+cP/3KHRf06NZCOgKk/0anFLrWTtD6aQrpvV/WCUAjTwnl+nWF6YDwnmOqrlfD9n
 hHZzXpJnUKE/lgyu1h+C2wbRiNkpDsx0+3W43biBqM3lklugGRGO1iDcnoohGZXJ57mo
 zz+/rEyIAPjypAJqkclrhcMHKF87vT6buQ2lNIQqs1eei1hRYz9W7ZIMUYGDEhyc0gXH
 gaDIWIiXQKmIkKbWbYqca4ngCHMVzlAgcHv7cpl7es/6xCEHPUEO1P1wQ32XJzrcn4Gs
 GgkSt+KjMgr/cA5swFZ6r3ongRcWuc90WK9VTKt1Z6H2E0VtfJy8R9C5QHeRNY2xOTKU
 2/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793724600; x=1794329400;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=La1dibXF3oZ/05I7jyTVx5/57ddqni9keast6vEUmt0=;
 b=FVFTk121ksUGipHot0QPcZpCsMOYCTLLsDa97LmvgpOj4Y5CohQqeuafcm7G4uIzF5
 8foCmjeHSP/gPPmZ+blfo6avrj23X4ZsVSEttVHz8aMG6GLnuWb/gHLvAmkzX0RSW3Ql
 RMrMXk4VMVfhkcjg2AM39lalZvYUo17IrAPqP7TYHHbgbHHK0u3brSqzjtzGa9YOVuTp
 NRYHKb6P2McClqDgbhbl5wFCBbROgusnhC7K/wWfs1CRL5mWR4/IXHFfTlL9lmwQBwI3
 RSpWxCtzEQSlm26ko0kp6lwjcaa8T9gw328dy8EDz181WOfTmpMosEo0eRZpgeb2XSAs
 FQoQ==
X-Gm-Message-State: APuU4Z9cj318XuZ2btIcVa70i3DYGmL1OW+TL3LXBcnAHC86PY7vRjJe
 oytO5ksub7djaaPFV/yPHpNE1KrouTLc8FNGL4BtOgi6OYf0WZdlcFTdbEpcMfyF
X-Gm-Gg: AYBFou0ehE//ed4L2kKOO5SRcp9a7nXIXAAqCrWNJ5xXuQZi9OcFDcu/9SFsS3gBkJP
 FaDsCBu+oaQPXpV8WlC9r94GWJmOS20K2ovq58WBkIKx92BXpqHHcu8FHUOuCgbXN1OwNhA4DuI
 SSfqoH5KWZ/8aZDgnlurXb8yqu3fY6QNv7GkYeCpkkpSxyOG7sDuM8+8K/O4wx0QKItQQJoqa/k
 MKA8fPsdOFKn57YxDut4qc0EG/mzw6G/uKSXcrzsOOnSkY24WTRTtlhdR4NNDmDoKWUcS2Jc7rm
 DOZZOS5hiSrrpeYDwqVI8LJQXvHY+HushHcWDeh0/wcEQ1VhoOY0bsRLk4vRywFNVLGhcSfp09o
 1/SBoUmuMOTl2Oi+y3frWZBSb6BFfuN2nujEJqDi5jEvt1dZTadrCtIFt9d7sPtdGX9NuTltZ3h
 Bcf0YsVfDv5slsdQSKN6aZ0nf4/3TPLtaz+ueyF9buIjLwC8j/c1as64A+Ph74OiTho4EgVriKO
 kaUNMyvDsce+3ILK6dIxxzNWlAM+tCXUgU6xRRfXmdPRj0KBB1Rx3ahfpwj8wr4a2c5u4BRRT5r
 wYsDdYSsOFqrOpWbYfTJEu0g+dIxnBote5IaEYo2s9FLv8vGq2at4M6/CA==
X-Received: by 2002:a05:690e:438c:b0:679:a4f8:e47e with SMTP id
 956f58d0204a3-67ba4f9f1c4mr6691918d50.32.1793724599650; 
 Tue, 03 Nov 2026 08:49:59 -0800 (PST)
Received: from ABELHA2618-VM-UBUNTU.autotrac.corp ([177.174.221.194])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67be800b325sm440329d50.0.2026.11.03.08.49.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 08:49:59 -0800 (PST)
From: Wagner Popov dos Santos <wpopov@gmail.com>
To: u-boot@lists.denx.de
Cc: wpopov@gmail.com
Subject: [PATCH 0/7] fs: jffs2: improve one-pass reader and add metadata
Date: Tue,  3 Nov 2026 13:49:46 -0300
Message-ID: <cover.1793724561.git.wpopov@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series improves the robustness of the JFFS2 one-pass reader and
introduces CONFIG_JFFS2_CACHE_TO_SPEED_UP, an optional directory
metadata cache designed to reduce repeated flash reads during sorting,
directory listing, and pathname lookup when loading files.

With the cache enabled, directory entry names are interned in a
configurable hash table during both full and summary-based filesystem
scans. Cached names, inode numbers, and parent inode numbers allow
lookup and sorting to use in-memory metadata. When fragment sorting
is enabled, listing can also identify successive versions of the same
directory entry through interned-name pointer equality before reading
the selected raw node.

The optimization trades additional RAM for fewer directory entry reads.
Names are allocated from 10 KiB pools, and
CONFIG_JFFS2_CACHE_NAMES_HASH_WIDTH controls the hash table size,
defaulting to 256 buckets. Cache memory is released with the filesystem
cache, and raw-node comparisons remain available when names are not
cached. Listing still reads selected directory entries and inode
information, and loading still reads file data.

The preceding fixes address unchecked node reads, missing inode
fragments, incomplete file loads incorrectly reported as successful,
unsafe symlink target handling, leaked dirents on comparison errors,
and incorrect handling of the selected raw dirent during listing.
These fixes apply independently of the new cache option.

The final patch corrects the sorting documentation to describe the
existing post-scan merge sort with O(n log n) comparisons. This series
does not introduce a new sorting algorithm; its performance focus is
reducing flash accesses through cached metadata.

Wagner Popov dos Santos (7):
  fs: jffs2: check cached-node reads before dereferencing
  fs: jffs2: reject missing fragments and fail incomplete loads
  fs: jffs2: resolve symlink targets safely
  fs: jffs2: release dirents on comparison read errors
  fs: jffs2: retain the selected raw dirent when listing
  fs: jffs2: cache directory metadata during one-pass scans
  fs: jffs2: document post-scan merge sort

 fs/jffs2/Kconfig         |  29 ++++-
 fs/jffs2/jffs2_1pass.c   | 261 +++++++++++++++++++++++++++++++++++++--
 fs/jffs2/jffs2_private.h |  30 +++++
 3 files changed, 308 insertions(+), 12 deletions(-)

-- 
2.43.0

