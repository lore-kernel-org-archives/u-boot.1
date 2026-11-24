Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22673606A326
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 19:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=i7dRXu4z;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xSZMlLzw
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 98EC880C8B;
	Tue, 24 Nov 2026 19:29:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jifbFf9IJzIN; Tue, 24 Nov 2026 19:29:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B441280C1A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795548579;
	b=ZDwuAjCEu/dbA1dTNsZRNQYNQyfjobQOQhTgYly18tKQAgJ6/xcxG5aXMA3mBCPbClaG
	 GXUwyKq6W+gyd4rDcVfD7Qu6VxYKBeSmqObLGci/WvJ90VIiXHUZo42Oz44gGF48fhBQP
	 753rN4caekgnTcI65MMLp4GywXWLKOAzQrqUr8Am5Oyr06WhOJjzBTxqcgffXwo5iud1U
	 v9J/EcS3IK60XK2YLVY2re55LFkszEv09rzrpbGoJGUOUOhlMs/wZxbGYwIIIFdAtlsiw
	 kFqNvyhSKSP1M+x1A3UM6ld5F6PiiZV/LQsIxblvXDdMJ8101lHJ7VfS53Zx0zObnWQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795548579;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=kqLJCx39lPwKxRaRPIv0LCmgK3e7xnMGEBkKK1oZyWg=;
	b=qDk5PMhaFLhd215J81R1KjE2GTZCBZoFOxXPW5Bm/5AtQHrMd5XL5r71BVG0li4hqbmx
	 imvG0dazx4yzG6jv84pyD230U4bC96zdCxbdwlWOOtT7C4mBNxG6SLmHUwLN3vxFQCLav
	 lU5NywZiLuSmd2GtSJFemew4ujRd9eNCPM7ZJEq/94A3y2PzlLdhQvC+1taNqR2sr8mKx
	 cWrPc5Mseo4+48+/gJ9Dx0HyT6sK5fIR96O86McEU4kU9CZlGaJwxGG5vinl9VOz2/hkg
	 6toACmDV73lKT7tHl3qZ2yQjmpSsNLtb72RvO+OzZl2aMgxBSqcADnHh5RLClxXlnEQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795548579;
	bh=kqLJCx39lPwKxRaRPIv0LCmgK3e7xnMGEBkKK1oZyWg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=i7dRXu4z8Eq/NLqrLaDaUpO9NGRzAuOfRZLhOBTQWf7NQGhZIoIun9cdgdJu6ufKO
	 vfKUurCA4cf8QMIw55MrBqg73R+AfXuQZ9UdSMejDcdltidawUUgJknOTtwaQUzpEW
	 z5DqfGo1nsetzrganPfKeKUTE8t/q7HexRfx95mSBDaz5maAXXUrk1hqy1Hx+BuCxc
	 GgBD5YBPVlCVT7rRrcDumh70o1twXXuJ8zZSWYYcbv3A1tcKia7Djrxxbl+Z1Aztc7
	 b2kij8KQa4I6jF/dVYcMyawxXbK4Wm8SfW+21CAvrlygZDFBPX/MUtm5/r6lD3+qT0
	 hxnXvTg8pkPRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B441280C1A;
	Tue, 24 Nov 2026 19:29:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C66531AB
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 19:29:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B763640311
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 19:29:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rv6E71FwSONI for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 19:29:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A197A40310
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=alpernebiyasak@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=xSZMlLzw
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A197A40310
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 19:29:37 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4bb666304fdso52873685e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 11:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795548575; x=1796153375;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kqLJCx39lPwKxRaRPIv0LCmgK3e7xnMGEBkKK1oZyWg=;
 b=xSZMlLzwDTH4QTEBR23rLBiWzfZqMkD7r9T04oyrnhSOMsZ0m32Wn6G9gkhpZe7qXa
 wg7qo+VS20Uka18QJWnv9qyJ6NxoItRwNTgil1kT126OA0SDa0/A0Q313e2WdF1p2kEZ
 LN2Vy81p2CrDZtrcblbDXbRYgI6VlKsth9OVEGEy8tT42g2ku33kLoFSCdAmSwzHEowz
 JepECyC5p8PJin2LmL4JVd1a8P2131vIvyo9Mw2F2r2nPXnhB1Rxb3zzUJjYroBnRwTv
 J2fRMX/Y38gCOVcDdDD+PCzCBstQ5AlkBxo4xJ/sYGXZVT0w6KmypHWt7uc7e7qRwdiV
 BTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795548575; x=1796153375;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kqLJCx39lPwKxRaRPIv0LCmgK3e7xnMGEBkKK1oZyWg=;
 b=oKqM0cnkVMm4qLw6EQlIwxSiS9UQBYYmhFTf64g0ip9AkNInXaET3RB4JYppbbmsnP
 joc6wkN4qB1x2SJIzu5xA67zSHqoOLNJtcTne+cuwU3Wffnc8Pgs9aSLcPxgCM176PEl
 vZ7zPgM9KqIlH9AANa8hBSF9XASmK2zzGPQ/OtNNNNMkzjOlwNr2o2k3o1KJGRKK+nEW
 n4SuDiuaCisVu5eHkKEq5WRzPj9VMdh6Gq2g4ZFdtLkmPli10Wtecpp8nvBYaEhU4Uv/
 5z3v/3MAQsAW0mlIvR6jWqzFBAVFuPpnQUkf5wVxzhOeA59FFEpnyALVZlgkFj2PY+Pv
 NCmA==
X-Gm-Message-State: APuU4Z/kKrl8cMu+wp8HzpMbt2bdy2pD1+ie2HZH/htsMbMbj0A0vh3a
 Efmr670pfEFf44A88X9YTtjZrqpEYYrT7oGRG/PWffydVVJsHUADrp+KUerKZV7A
X-Gm-Gg: AZFdTZczOKWkIYsRS1JhzdxPFs/NAtiBFwMnEt2ry9Nb5dFqKD93c/qR0iHp1Zv6P7w
 mTo+DfyG9/SfDY3wzh9gTvCgthSI3KC0zvz4u0RdghuOst5R/63HQyBt6sKdKAfl4Wq804mLfCp
 8RRCqeR9RgEK/2UsAjIpC/tRNNSUt/rLv6qKBYRo58mHDjEfMpvs826yP7BDu4D4B5TKzC30Yvy
 j5nvY2yfvtLn5QR3Q9gfc8rD+tgqlCL3juyJbNEIi2fBJiekikRlJWx5n0duhx7oBrYqGva5bf2
 spArPRT6De8rkzTA2ssMkZwTIAn4Snj19+Y/dH701bcOWVFGCKI2L3eedJuVnVAh0XVp5WUho8L
 mrTe4IimayjBwSX01QcDKLZJWNqu9sz9Lfaa1Yfm5Xbt+GNm0gizZONX+c/Nb/eqUB8yW/DfjPR
 BCMhpeMIJ29spPJEv1sELoDTdx8EOwDMEMuOP7vf8gStaZa6JDvJw3hZKpgZfgsaRqM6KuT03eV
 D9k+UoNys7HQ32M4ozZkMpeCnq8mGzbL4/BHPpg5RObfgMcpG9EeKtzFDsDEBdDGD0pw5rgoOaY
 +2Rs4z1a303gXpeBj3pocG7N1+r/roA1FQc5tfsbRH19A5vC9awGuRE=
X-Received: by 2002:a05:600c:a085:b0:4bb:85d9:156e with SMTP id
 5b1f17b1804b1-4bb8880fe46mr318520745e9.11.1795548574990; 
 Tue, 24 Nov 2026 11:29:34 -0800 (PST)
Received: from ALPER-PC.koi-vector.ts.net ([178.233.26.179])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8849247asm462176155e9.7.2026.11.24.11.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 11:29:33 -0800 (PST)
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] samsung: smdk5250: Add Alper as a maintainer for spring and
 snow
Date: Tue, 24 Nov 2026 22:29:10 +0300
Message-ID: <20261124192912.242000-1-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.55.0
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Exynos5250 "Spring" Chromebook is due to be removed if nobody picks
up maintainership. I believe I have this board (an HP Chromebook 11 G1),
but it's in uncertain condition and want to try my hand at getting it to
work. I also have the "Snow" Chromebook (a Samsung Chromebook XE303C12)
in working condition.

Add myself as a maintainer for both "Snow" and "Spring" boards. Drop
Simon from maintainers per project decision.

Link: https://lore.kernel.org/u-boot/20261118155218.GX554944@bill-the-cat/T/#u
Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---
 board/samsung/smdk5250/MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/board/samsung/smdk5250/MAINTAINERS b/board/samsung/smdk5250/MAINTAINERS
index c60b6f81e9bd..45e2925f1fff 100644
--- a/board/samsung/smdk5250/MAINTAINERS
+++ b/board/samsung/smdk5250/MAINTAINERS
@@ -7,12 +7,13 @@ F:	configs/smdk5250_defconfig
 
 SNOW BOARD
 M:	Jaehoon Chung <jh80.chung@samsung.com>
+M:	Alper Nebi Yasak <alpernebiyasak@gmail.com>
 S:	Maintained
 F:	include/configs/snow.h
 F:	configs/snow_defconfig
 
 SPRING BOARD
-M:	Simon Glass <sjg@chromium.org>
+M:	Alper Nebi Yasak <alpernebiyasak@gmail.com>
 S:	Maintained
 F:	include/configs/spring.h
 F:	configs/spring_defconfig

base-commit: ee1b3477e3af6af1ae9b8f98bc84d2cc6f32a3a6
-- 
2.55.0

