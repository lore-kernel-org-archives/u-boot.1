Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC979C5CFC1
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 22:48:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9518140807;
	Sat, 15 Aug 2026 22:48:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hy2CSIC6FPSB; Sat, 15 Aug 2026 22:48:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 109FD407FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786834130;
	bh=62qjbErmgBLqyrsjCtPZdemW5IHuaXEDM6hVxXUf//4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WkeZk4t16Mtb9SbRnpTMWzQpsg6eknvU+f2JFk+ywQlrgm2jqUn0ldo3Cw5IeHSB5
	 HlRBHCGnL6/IHN9WIsw5g0b2W7Nefi4Bv0ohR4CJuIpH+Ub12wRcR2ZONsw+FQU7ex
	 HtohT6ovFjzTqx3pFXaUqyPJDmFrPaOZp9AEp9BAyPy7NdOrHCc6DAsJ+OyDH9a+eZ
	 9/wWXEjS+g276hSoDWx2fDdRjxWjrixWjXzO2Xc1VAAWbGMQMu3hrCBkLGPAGKdNeG
	 vj/OgvW3vokgQu5XwdBTl4a8TphWcU8M2qAzoI6EN6e01u8ExlfBA1K2edV3skfOJW
	 DYmmHiypCVY+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 109FD407FD;
	Sat, 15 Aug 2026 22:48:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B028337
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 22:08:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 29007400E2
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 22:08:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d6OG9_oyFoIi for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 22:08:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=pranavkasthuri@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 424D8400D1
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 424D8400D1
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=CQDqPVHU
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 424D8400D1
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 22:08:01 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-496bb7cdf51so28185365e9.2
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 15:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786831679; x=1787436479;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=62qjbErmgBLqyrsjCtPZdemW5IHuaXEDM6hVxXUf//4=;
 b=CQDqPVHUCjUHANMvEQz8W9ZIiX3CiVltntMo57TnxKbvsLJuwIQe0KrQuRPRAmafEh
 jA3TfVH0pq18nHrcGffaAaM2KZN6ikRDwHSvNu9Id66TAnsfbIJDso82RNi+CxeD8irB
 /iisT7cUmziFRkzFwnNNTcvU5mlYdjqEjSf3lGol/EIViBog6EYSJGBix+uJU9BgYvpW
 sxoSWjl/8D4Lv9sC9u1gXguUxlU050Py6f0j2in57yrxvOmRgrLb64PNYiiFBAuYurir
 ZfAtWGszLSQNeS2C89d5eEdRbFVrjXneVzZ84Kvz1kS/1whFrgGTJDoJ+4t0j9AHa0dJ
 lh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786831679; x=1787436479;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=62qjbErmgBLqyrsjCtPZdemW5IHuaXEDM6hVxXUf//4=;
 b=WEmu62NImlzBaWozXW+3lxDQuENyymEJh7D5W5SF3hrWQs7GECQd1z2Rkraef3Dj8C
 G5qGcxNf+ZRTRsrd+xeMcEBSQhpo5icHujaJ23jiUcvis3Obl3otP4bbKyHtQ6f74S47
 1GKdElM9gUgFjlR71p4Qf2YC4EQA0OnnV4mCC35ZjHj6zln4X2hamjkCQkX6B+lI0Nc4
 alwNsu2N4OT0l4B7cVyZr/DpqTO5sj1GBTSvvvJ8MxuZCxEveHc9gdJDNdQd2fUn2ZRL
 fdaDlWGHFIa7Wymic7k93xibBBTwF+zrUQCuQgBopfgulXBk6lSboZqkW+CM0Y/yPN0N
 Pv/A==
X-Gm-Message-State: AOJu0YyDxBonFUNs4v7J3nm4MvVPJvhnB4S/BJfVFp1yTij1iwpUHjTd
 AAipLZDm+bCgZ1LLlS4FG3y4POz5Idy81QxvJGtobaA5qDEDHsBkMzDPa5Czb6ATleQ=
X-Gm-Gg: AR+sD11OjZid4A689LqjoArqvL+Z4oqPMmjHQ+whk56cjaqcBcoCgHRu7HapfrGTCzB
 nxfnG7hd5RVPocUkEQlxYK/0xunBfmmVmFAqIkhrvK9fv6DR0aBF5s8KmDaTkcPyQ14+k7tKQjo
 ACLqb+BH8n1VI4iKfxYItsckAYTOoAsN3fBiN5R3BDdTQPhHQ/+UG6nKaoIq9gSj7aKC0GLYYcF
 6nbHBMiOpdv2DlQUsRjg5iEUCV5J1XmHONTgclW+7H9n/dYOsRmK5ePevgWysnXeq7fTsJ9vKAB
 UfY1V5yKxlLYQzn/1eusHrbgeWwXc3g2t5q314B2gXvlH8SbpFOyFArVTNUfeFgd4jmdkTy3svh
 jYMSbrClg6iJhb+KsCAcIMSR8G1yo4xlo2vcZ3LdzIYTEtTZqA8BdhTfWRazgFMQxLd9I6kpQ+Y
 7Xglpb2gRsrk1j8aloXhWVUhs0mq530UsCMxugnq8C1knMw6DhJRfKNvqXdR+iwofZHdNNN/W3U
 hrkyEkktaITKdSYoODbCFJofhT4GEFDGtsqtF9/PLV69qaaVkwGbIgsgcuArzEtQCK26h8aI7xK
 UWyzYtaVEpw/PGsKr09qce6U
X-Received: by 2002:a05:600c:4708:b0:495:6396:8b67 with SMTP id
 5b1f17b1804b1-499879419bdmr175865195e9.4.1786831678971; 
 Sat, 15 Aug 2026 15:07:58 -0700 (PDT)
Received: from Mac (default-188-240-185-161.interdsl.co.uk. [188.240.185.161])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49988b1d33asm179598285e9.10.2026.08.15.15.07.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 15 Aug 2026 15:07:58 -0700 (PDT)
From: Pranav Rajendran <pranavkasthuri@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: philippe.reynes@softathome.com, trini@konsulko.com,
 Pranav Rajendran <pranavkasthuri@gmail.com>
Subject: [PATCH v1 0/3] fit: cipher: bounds checks on the ciphered image path
Date: Sat, 15 Aug 2026 23:07:51 +0100
Message-ID: <20260815220754.11724-1-pranavkasthuri@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 15 Aug 2026 22:48:45 +0000
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Three fixes in the FIT cipher path, found while auditing for image-
controlled values used as buffer lengths without validation. They were
reported to the list earlier; these are the fixes.

Patch 1 is an out-of-bounds write. image_aes_decrypt() sizes its output
buffer with cipher_len but decrypts DIV_ROUND_UP(cipher_len, block)
blocks into it, so a 'data' length that is not block aligned writes past
the end of the allocation.

Patches 2 and 3 are the two halves of the unciphered size never being
checked: the 'data-size-unciphered' property is read without asking for
its length, and the value it yields is never related to the amount of
data that was actually decrypted. The second matters because that
property sits outside the per-image hash and signature, so it can be
changed on a signed FIT without disturbing verification.

I have kept them as separate patches since they are independent defects
with different consequences, but I am happy to squash 1 and 3 if you
would rather have one change per function.

checkpatch-clean, builds for sandbox (CONFIG_FIT_CIPHER=y) with no new
warnings at W=1, and no change in test/py results.

Pranav Rajendran (3):
  lib: aes: reject a ciphertext length that is not a whole number of
    blocks
  image-fit: check the length of the data-size-unciphered property
  lib: aes: reject an unciphered size larger than the ciphertext

 boot/image-fit.c      |  6 +++++-
 lib/aes/aes-decrypt.c | 21 ++++++++++++++++++++-
 2 files changed, 25 insertions(+), 2 deletions(-)

-- 
2.50.1 (Apple Git-155)

