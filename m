Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0F9606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 21:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rcCA5smX;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B7tfLks1
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A480A81463;
	Thu, 22 Oct 2026 21:32:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fnuyHTyPk1_t; Thu, 22 Oct 2026 21:32:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C529781493
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792704743;
	b=LySMPQU/BOjEoehSq9Z/A/OYOJqrvU8PpNK50f93nab8w/AXT4EqeZRZeTJF+ZmQeybS
	 zyyglvfCONCH5iGYdgwb+4efK9e7v458WOcFNqtZLBmLjw/dTQni0DdbGtgiWW1lFsjYx
	 lBKfkMfzmnQq9+Q0cEQzL5N3HgijMgm0lxUU2cLkpFKIrhW6PiCEF9rr5l4kTDcY5PXYq
	 OVYILgmbcyy/2gUPerd+1DDe3sXP3mQ6Uf3VIFCyt4YCMICGsidfcGbPl5qfxleyX3Ull
	 JQjn34A5ZkCTYFPXguiYtQeSucy/ALMWz5zsutoN/gQRJwHl+lP1nYFyR3ldNfLsFQg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792704743;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ASYH/gC+pFcAbAr0RqjT66VMZaXgw7LbAbaaor0BcD0=;
	b=c1+bAaWnjJYygvVY+Pg4RX6LEIgMxoUpBahRw6Z6PjUQYtIu8yxG9wRJoK7m9AUrHqX0
	 GxLcRsGWWVxNu7MhjpCzKfhIvXldJqeaLICUuR4UbAUvsAofjKXoIB74sEKdHp6pIVCfY
	 06OqJUUKLrdZsKLUXszl0Mz7CIeJimeP12TjM4FmMAzlcXhtWNll2uXtNNR8dlq4XqY+B
	 NCEvkiMOHhV9MQHku1EPaJ+6abq3f1onbY5Uc2MyoeCr2V6ZBC5etcc0W5QKSIrGKfW7/
	 Ur7cXjzYRvPlkgp1Jb+10f6AUBE/+f7pEHrlwxCs9VQcFQsxKmB9qXj+LQCD2Xqfc/g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792704742;
	bh=ASYH/gC+pFcAbAr0RqjT66VMZaXgw7LbAbaaor0BcD0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rcCA5smXUg0fS0pSu0QJXQkJ4X9DI8bddgUFnfFnKc9rj1a6HbxZWuGWZJB/iYfMc
	 Y4iQmuCIQN4g+ZVnbYIo4Zo0s9T8L4oINn9FqubTfgG8ZODaCc7w247ir3LC+1HZ6T
	 7hX3+1JU1Aah8++UG+zu4KtetfbwWORUGH4McPVsQ//J8bQSmmPdar3RfBUMkMAclx
	 rFh45yh9xC+1GTDjul/NcZFPwXu3OnlXSTsEinVSfNcWyHitRQkTMjuYijZlohNmQH
	 jYRrodWswB5ySgxkzk0BH8JxFoHjbzfhI1Pcf3H7eGVLqv2oDwCAOtcFFg56f0GIQW
	 Z/53usMy3Vesg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C529781493;
	Thu, 22 Oct 2026 21:32:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6E17C499
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:32:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5FAD640443
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:32:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lNKSIRkmgC4n for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 21:32:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3ACF24040D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792704740;
 b=dv0BGQg7Pflbux5+CkgK+qRCv1BJP4mef+lGuWY77HZZHCzMYvOB+/BR9/EU2J7J2Pk7
 6tZ9qLF+p9IjeTaDjpRjEl7JJqCd07fTQpdnvtsYuuP66OIqjtrIyoVkyeiioRYlijNt/
 cI0w0gkTX2smqg2sNLZElYwK7ciD4+FFj/bR3Ck+XawiXb4WE8rdQFueaN2DfeK7p0LBA
 KNfajobTA9p7qhXpuc/qoT1ujzz5jqmwx+2gb79dgwsSGd9Sad7rB8fFMWYvzPIzrhCRd
 CLr8ev72xelMfYs4EfE+XJH9yhdFBPC+rDmg3isE8FyPo1HBrI9Q8CSLbKXCOJtCe1w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792704740;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=ASYH/gC+pFcAbAr0RqjT66VMZaXgw7LbAbaaor0BcD0=;
 b=oRp8gfEkOi0YrnAJkQb0SelqEa+hTQ2VRP2A0FblxoiwbXrnxh8GuQ6wamtr+VLbW6gH
 guSuNqKztk8F7bwgFJV+EyUbpmreyswDsUEKd8Fxs98SbxXIqUnS5sEPd/6iKldNuZl4U
 Ppo2/fWiKGFKLYdQtskyErnJtl6Lskwxeyn4vEw3xNbsw/RKy+AEvaGae7uFIaWexGQ9B
 GWWsG8bJIDLq+qq6xQkKnS0UIKbqobPJjDLE8wjZsHgx9n7HrZlf1+TjP+UW0cscgtr5U
 aHnbQweDVlo6EvPmW8bF5S8YRjjmlGVgKVV5efMUU+36yuEA1xgbfMYpvDthfVO2daA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=B7tfLks1; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=B7tfLks1
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3ACF24040D
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:32:19 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a2069b9710so2024165e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792704737; x=1793309537;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ASYH/gC+pFcAbAr0RqjT66VMZaXgw7LbAbaaor0BcD0=;
 b=B7tfLks1K1uUtL1rnNCLVq/27fvHEJnwNpSJV3EbMTCl8xKLkVItT/iL+IvwItZSFk
 sBRcD7znsRGxlztqL3e5MLd0hvnsJsGnXmf04Gu2zMjQEm7cbdeER3lktwVJVvWcR/u9
 nGV++F9raJOa8yE0cEBAagv8DcA7FWLKndcVpC42QHLIgDiD8A7ImSYMR/RkNsJk1YXE
 AAh2r+t/egkMHYh2M0rII9MVFCzf8GnjHctFWHbgOS89GmoBEBourYSr9ijPt9ZdILBf
 n7XdiHusTto5dnNtfpejlMmZIR2ZoJhMULbDXe9zZn7nA9udTuw8CEj1u2nmZWOvfYC1
 eeLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792704737; x=1793309537;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ASYH/gC+pFcAbAr0RqjT66VMZaXgw7LbAbaaor0BcD0=;
 b=Jv5zUZQHQvOf4H8LMR5W4TsRW5WJdHfNKkDmWX8Op3QcJE4MONqMnA4JqjuaUgaY4b
 REtJYJRLyNkbIg62QN7H4M0d7DSLxNYWlJTI5CUX58NRO8pOuW+5r0Ks+FKYGRYp8UT/
 4BZ+Q2kSaH7lw3Tg1wWTqHhcnc1/OrPoPRHPeDYoRFlQw7Q+NE4O5jbi4gJu9UmhdojV
 ktqa1EYWslG3oTaP9+QnunxnIZJnmnVcgq4itLJ2MPNRHxiFhXkElWJc5YZ20IwPUvQr
 KWyFrZ2iuzceRgUTkcgKpsiHqpYt33Z8jt3CTRu8eGEqrGE4/sC6XbIR2rOCqtnnBc2m
 SnMg==
X-Gm-Message-State: AFq9FYJjAl4ZOnIUeS6rceAcn1+1fI32R0EwOsUiCXdpWH7vjPCBYjJj
 LdIN9eWaW+D+FGBbyFu96SUfxLlmhV//w05BvuZbGHFuazwBMjvKxkSvyQITC9Co
X-Gm-Gg: AYBFou1uAqBBWMwL/M+g/0ZyC1Myfy2Zg49U5niQPrbe7qPjJul5AXrU87gEHVM2B4p
 /9v/xDdgEDK/nBDesCpb7jWTm4/PAgs32yFXKExmyohJoNOZuh3VsI5ZN3+y2BihW9n8k3W4T8m
 sQ2ve7SiG6gZMoECJ8saRIhNWXDsHocJjcdGphHSjupUp00LAKN9zz9ACAzcyOiOK1Y34wEgz+y
 VjEIzCmspjCEwkZ54qsC68ClmBQLvgFf4l5zYkeiA252OTga/nDkz9pSIxmADR2zaZJWEJUth62
 MMZvGAssckmr0OoLl2l+7eUPD2ZmZ0996VnPgKI5lkIDtAdFKVFh8MEo42joX5WQy6BJ3fldFAb
 C+EIF6htMayPGTbsOhVuWbkGuE13fM178ca7gfKTfhcg43yRKInZlbmkJHMZ8u6+2t6Q+PzKZMh
 0ak/D1fbn8wT3vaZop9VkBsRAK9VMW02i1lIH36ju0z4JgUNw3LvHHg550K8q91OnGBe09IO3qe
 DBUq1FHvdIYYb3PuDg9RpiRBncPigC5vy4UfYJmxQ9ZEM4dyuLWwRd7nnK9PskZfzmT8hxVHIsP
 LLhobMYKpDM/dOYGa9fVjx5fmHcEa+u4Tb1IJtxzDu4E9EC+cy5y4TDwCLCL/xXywcSv6UADO6Q
 Yh3sPt0z2Ac92JCB3bYtczT/+wQh0DhTTLN8+1UfeJ/jYwZAdvDl3lrLKYyLKRNEDeRs4S1sjt+
 lvUosj
X-Received: by 2002:a05:600c:3514:b0:49d:1fa8:b266 with SMTP id
 5b1f17b1804b1-4a211ed7602mr4322325e9.26.1792704737173; 
 Thu, 22 Oct 2026 14:32:17 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-f91d-6411-2ad4-29be.ipv6.o2.cz.
 [2a00:1028:8388:a84e:f91d:6411:2ad4:29be])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2123a1797sm2785725e9.1.2026.10.22.14.32.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Oct 2026 14:32:16 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] doc: odroid: Update the link to the boot binaries for X2/U3
Date: Thu, 22 Oct 2026 23:32:15 +0200
Message-ID: <20261022213215.30119-1-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
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
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The links to the X2/U3 boot.tar.gz archive are no longer
available. Use the binaries from Hardkernel's odroid-v2015.10
branch instead.

The binaries are newer, retain the same boot media layout, and
work with U-Boot 2026.07 on an ODROID-U2.

Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
---
 doc/README.odroid | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/doc/README.odroid b/doc/README.odroid
index 8fe226cf..79977b0a 100644
--- a/doc/README.odroid
+++ b/doc/README.odroid
@@ -26,10 +26,8 @@ This version of U-BOOT doesn't implement SPL. So, BL1, BL2, and TrustZone
 binaries are needed to boot up.
 
 << X2/U3 >>
-It can be found in "boot.tar.gz" from here:
-http://dev.odroid.com/projects/4412boot/wiki/FrontPage?action=download&value=boot.tar.gz
-or here:
-http://odroid.in/guides/ubuntu-lfs/boot.tar.gz
+It can be downloaded from:
+https://github.com/hardkernel/u-boot/tree/odroid-v2015.10/sd_fuse
 
 << XU3/XU4 >>
 It can be downloaded from:
-- 
2.54.0 (Apple Git-157)

