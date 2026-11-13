Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8023606A330
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 17:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WOGvqjxK;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=gFnmvHnv
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 96C844085B;
	Fri, 13 Nov 2026 17:08:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k3x8JWX89Mln; Fri, 13 Nov 2026 17:08:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D9593409EB
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794589685;
	b=jyEPBTP7m0Ic6Gc7BCBFIDre6x9YO5jwHulRT46bzRAkyrFASOuRzjCJNAsvnm3K83os
	 9Fyk+GnmPsn4fXdLtnsvcFLx14QTpZbVpA3KgxYJgFyLUEQ7niiFhrkKC2k5bYIOpLF7z
	 55zRI4TpW/vrwKPgpm7xmjO/voJ6j2CD2czWwKPQa1TlG/UuS1r/+IigT5JfZ9vgdcU0K
	 Mm5E7c+anrlz4xTEXHJBHgFc5jgwUFqWtjURqizX9t3apDn1AhryHWbFQWHRR8BfJA0Sn
	 cs3ieBye0efVuaWRrCpAUIiL7/33n4Up4XEzB8L/UnkunMvdNRRcMsvEQliEQyYY9ZQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794589685;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rUj1EhTBbtYO6UehSQMNXpg44+HYOeQmnEyPRX2A6I4=;
	b=U7G4GCYlc/7+Kz9wy+wwgiIC+4198kd7kHS2n0Yy+Tcw5AgaU3WnL4l2JvD8if7/ArKl
	 tqYVGLbsZkZ0OD4u6pzNXkHBMezKhMMv4//Vfsgmg/27GBgMQlmxLYnMKGFNz8obZSfGP
	 eM8vErylnteI2m6Bl7bEhxLDYkVfUf7IlDn20D0qkvAtydGto/9FB25I50kWLOxgQVail
	 WFVIEY1c/WyYqLF00R/9jLgZ4zYS+8S0mxVFuf5pdAK0MhsII1d+FqV3cO4XdfvECCoSe
	 anBCnrF7+DZ0hNGtk3FPXMtYxC1SZ82By02qhc3IbWvXGjMw5GS8321qL0tWrNk83kw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794589685;
	bh=rUj1EhTBbtYO6UehSQMNXpg44+HYOeQmnEyPRX2A6I4=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WOGvqjxKAtlx48dnd1ehsOYz4dMzD46YWM4ANI9hVruqb59FXr6/Zo/f2FKmTElu7
	 XQnzjqqViIa3GrYNL6RccbijjfnkVm96SOKMfX6/WJs6tnYqrITK8eve/JfdlnG1DV
	 jtG/QdVrlDJy5VDn6R5G1BfXJlpM6fozSF/1z07eB/lOG8eMvvRSkoLSxn+IrCc6Xh
	 Vp6lIiyPlzIIKrh1IowTeNkJTftoXy3YgWIdVP7HfMkx/UHpW4D4ymD8ZYc3/BgZgr
	 nsWDN/At48hOuTOzlDc5v9uciQLD7KzWHGzBb8ye8aZZJBXNbV6CnU17IPUtzUWK5B
	 A0NcPJMb1/3kA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D9593409EB;
	Fri, 13 Nov 2026 17:08:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C512628C
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:08:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B15C5404D6
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:08:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yoQApw9VoD5k for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 17:08:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EBAFC404B0
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=gFnmvHnv
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EBAFC404B0
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:08:02 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-85c1135c286so1523064a34.1
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 09:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794589681; x=1795194481;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rUj1EhTBbtYO6UehSQMNXpg44+HYOeQmnEyPRX2A6I4=;
 b=gFnmvHnvCMEnythURV73wHsgZpiH+mDN0sv31vU/rpCK0hp7XyVJ+ZKKS6Yo+A8KEl
 MVO6jhxnpJgTO9Xr6B8G+Zj1/5pEeRq9RlF+REYnD79z0EdQ+W2zKctrjV3NuA7h5PUr
 HvW80WDFCtyO11SKITNOYsYm0uqH+xOPLFCI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794589681; x=1795194481;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rUj1EhTBbtYO6UehSQMNXpg44+HYOeQmnEyPRX2A6I4=;
 b=RcnpbtxGb6dz0IiZlOmrIO4JZ2vCWxBWTrhWf/HdF3xsv8Xzde3eQ5MB9YNhUPEZHV
 y85lBGeBTCooaDELaLxN546atfOIgdCw0psPIHSYgwtj2u2MQGfXIHU2pS6NmApy5mnP
 50WI3Zk8sziFVhTA3rHixWjo9Y+2ZePItxJCkgxxLWtv3I3+VIJceBDwPqpZfqHlh5Mm
 9nnqbiOMZIWnDJNyqNIghENEAKCybzeropAQVznCha0ga5wkOTkc4OXBUW6TXV5pzEVZ
 aqKsCwSyFBmeeRlGwU8u07t/jW880pk4dax4OcO36YxiqjrwMVdlPLzDqHxdpbwIO8qR
 BweA==
X-Gm-Message-State: APuU4Z/Jr8stY/KxLnVRoJ4ufHGE+EzVvtUXMxKjpehY2CnDTMyE/QFg
 xpq+00OIQmJ0wBLx6fGrKWDOSO2l6weFFS0vJaR88KaAi3Bw5IVMH4pv7ALl2KeDHQpZZHZ9WxO
 0NcCW4pm7kw==
X-Gm-Gg: AYBFou3AGaGswaAjGbXX2oNhP+mDeH83kVJb4SzmFmATUV4qGgYB4i/eYm99PxM7Qxo
 k8CJwTHddXxQPAnLh/W2OCjX4Xw+qkzY5PNv9ZawhsV0c0ZU3+g/aWzUS0DFfnOyxJNQEl5mBlA
 ENIP5pW5z02I1NChezj1aiez7sPyPn+d+Hc4UXx5FhxUpaV4rdRheyG+25wN5Topd9d3OJwoJhh
 HkF9KsKG9TE3a9uDU1QXA1oIKCcRBzsxHY5y5tUtfa//ZRODVx3LnsazdPpPgZTU+42NIkL0BMy
 R0j1xMIdcI2bXSxYuUEzZzLKr91YKSkCKLn4ozop1oMI0+Ft4Z8MjEJ2a/lMVr/byIM0SckTmgD
 5Ut/ZLcfU3q9hz5CJlaF8+xWOOzWx8qPTVuqBUJiNKFbOd5ZzMhnIeMe+bfGagvueiXCGZFYe70
 9fcLVvHetxpUCT3nUIITXFqI512SaTNuG1a4jNCClb5L//tps2DJeSNh/Hb3/spMjOviHec9CHO
 u7GUx1bD6LpbC6Sm9D/Whh382F1rJodBq0+hDFvo/JS25iYz2XYrIKZ74+KAVvR5ImCS7ZoNLRN
 TujtAqT3iKVeBMsnOpK0afVYcDC/doS7YSk2l6Q9qNMYU7oz950OF+KZlQfg8PuuADaXEqT7Cdz
 OfDLrCdBnPo5jFe7JDyI5tsydUkUf2vQAuxpZsBYSlc5ghpe1lc1ZHsaGJ5uNDXRezuZnEx0nZA
 00/YO9AEwjczn3SUrzdKgekWEkJLzoafXmW5lPJbFDcpeNGOC9cbsu9Fg=
X-Received: by 2002:a05:6830:2306:b0:822:a76e:95a3 with SMTP id
 46e09a7af769-862895350ebmr2603678a34.0.1794589681354; 
 Fri, 13 Nov 2026 09:08:01 -0800 (PST)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-86288133265sm3184672a34.14.2026.11.13.09.08.00
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 09:08:00 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Subject: [PATCH] google: Take over maintainership of coral/link/samus/panther
Date: Fri, 13 Nov 2026 11:07:59 -0600
Message-ID: <20261113170759.1231845-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

These boards no longer have an active maintainer. Take over these boards
for now, with the intention of dropping them if no one wishes to claim
them instead.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 board/google/chromebook_coral/MAINTAINERS  | 2 +-
 board/google/chromebook_link/MAINTAINERS   | 4 ++--
 board/google/chromebook_samus/MAINTAINERS  | 4 ++--
 board/google/chromebox_panther/MAINTAINERS | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/board/google/chromebook_coral/MAINTAINERS b/board/google/chromebook_coral/MAINTAINERS
index 904227e2e21d..699f13c36308 100644
--- a/board/google/chromebook_coral/MAINTAINERS
+++ b/board/google/chromebook_coral/MAINTAINERS
@@ -1,5 +1,5 @@
 CHROMEBOOK_CORAL_BOARD
-M:	Simon Glass <sjg@chromium.org>
+M:	Tom Rini <trini@konsulko.com>
 S:	Maintained
 F:	board/google/chromebook_coral/
 F:	include/configs/chromebook_coral.h
diff --git a/board/google/chromebook_link/MAINTAINERS b/board/google/chromebook_link/MAINTAINERS
index e7aef53390cc..e5f8ae5e7d2f 100644
--- a/board/google/chromebook_link/MAINTAINERS
+++ b/board/google/chromebook_link/MAINTAINERS
@@ -1,12 +1,12 @@
 CHROMEBOOK LINK BOARD
-M:	Simon Glass <sjg@chromium.org>
+M:	Tom Rini <trini@konsulko.com>
 S:	Maintained
 F:	board/google/chromebook_link/
 F:	include/configs/chromebook_link.h
 F:	configs/chromebook_link_defconfig
 
 CHROMEBOOK LINK 64-bit BOARD
-M:	Simon Glass <sjg@chromium.org>
+M:	Tom Rini <trini@konsulko.com>
 S:	Maintained
 F:	board/google/chromebook_link/
 F:	include/configs/chromebook_link.h
diff --git a/board/google/chromebook_samus/MAINTAINERS b/board/google/chromebook_samus/MAINTAINERS
index ca4b16500af5..67555dbc52cc 100644
--- a/board/google/chromebook_samus/MAINTAINERS
+++ b/board/google/chromebook_samus/MAINTAINERS
@@ -1,12 +1,12 @@
 CHROMEBOOK SAMUS BOARD
-M:	Simon Glass <sjg@chromium.org>
+M:	Tom Rini <trini@konsulko.com>
 S:	Maintained
 F:	board/google/chromebook_samus/
 F:	include/configs/chromebook_samus.h
 F:	configs/chromebook_samus_defconfig
 
 CHROMEBOOK SAMUS TPL BOARD
-M:	Simon Glass <sjg@chromium.org>
+M:	Tom Rini <trini@konsulko.com>
 S:	Maintained
 F:	board/google/chromebook_samus/
 F:	include/configs/chromebook_samus.h
diff --git a/board/google/chromebox_panther/MAINTAINERS b/board/google/chromebox_panther/MAINTAINERS
index 4963a895bbad..43b973ea6cb0 100644
--- a/board/google/chromebox_panther/MAINTAINERS
+++ b/board/google/chromebox_panther/MAINTAINERS
@@ -1,5 +1,5 @@
 CHROMEBOX PANTHER BOARD
-M:	Simon Glass <sjg@chromium.org>
+M:	Tom Rini <trini@konsulko.com>
 S:	Maintained
 F:	board/google/chromebox_panther/
 F:	include/configs/chromebox_panther.h
-- 
2.43.0

