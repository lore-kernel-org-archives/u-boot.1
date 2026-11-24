Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F03606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 13:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RXBwAnEP;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MSaxCAC+
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6835B60815;
	Tue, 24 Nov 2026 13:22:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yoPJBrRjw1ec; Tue, 24 Nov 2026 13:22:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 86CAA607EB
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795526572;
	b=o2pAt9Bwl5dqm2NhLCTREYwlxyPHueJIpECRCekr1X+SxdloBYmb6l5MZIIegJjpjkTw
	 Yyb9DcZeZrRXex9YlztUtr8AAtZr57BgZaatnd+npgrtHn5opsyr7MVRpHDyi4ksafsl9
	 054Odx4YCHUaljE0vGLjE6A5eSne8VwaZH8dweBUFxm1E4/MQmbqtuy6q+a0Kc2FW5Bm6
	 Py60pjTHeoLno0tFxOLzfVTOCEwlqViOoTlLWm9H46NuzKrxwAif28Cpvy/E8BvKSqBBl
	 7HJsyKO1ZIEut8fNvJWvtmnWpsPI9xSx+4uXPGx55hgNVNMlnxCsaeYfohgqlsp09Fg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795526572;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=0p+z8V7ioNXKJBlEmlxyaewpcaFtJJtS6Wmykgz/hUU=;
	b=ddESTHANI6wpgvJMwWNJ9tF0mCxNCF6APp1WrPCkT3YI4uGvkgoJKrwGKjo3y0KmlxDq
	 f6qDAM1VjetlrrxSm0hB1+Bn7WqXnb1jG6mXXPMgZ4G44BSkjWUVhYCie7GXqscvWssYc
	 MGhwpawi5aIL8RuuryGiHkBA69qt2nqMrtmT+y3xpfMWKaDXKCrdF7bbwe/kwFAArLwu5
	 TXSK8cX3bWICoCHkZUxVkxYvADDbHl+WhIfvPk9MP/+Z88pGDrnr9TZ1CdLz+uHxEggzv
	 DxK2m2MfyF80vXGC0oZ8osQEmqCBlZNXNrdSzt3yrU81M78Z1SHSXA0oW81COBK9H/g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	spf=fail smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MSaxCAC+;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795526572;
	bh=0p+z8V7ioNXKJBlEmlxyaewpcaFtJJtS6Wmykgz/hUU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RXBwAnEPv4TrfEuMhcF5Pe6jruEVVizMvZGA7jq+ptgwz0Nq4mujm87AFZlu+8AOl
	 b+pzJsiiTxf3KcvciZV+cCjZmat0s9EZ2bhnbu9YUf4wcUphKSl/nGOEX9Ekp355ql
	 lTpZLzcV11qUkBK9MVC1R7IsGDfVEdbC4uenQZ1/NSO4F0KJ4S6iN1O7rXqSp49aXw
	 v0LqjrHTMhyXPXIA2mEGKhCWgdixQtKFwAfMpzz7y37UEcZ3Sbb6B+/lIPyxxgqzZV
	 +ffT1pFDKx4XquQex/fheLjuhPQyM0qfBDYq9fe45/g6GUkPdcv+63MeB49EUTOvzo
	 iNbjqsWkyhoAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 86CAA607EB;
	Tue, 24 Nov 2026 13:22:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E22AD43
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 06:57:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2F999606C7
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 06:57:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C1WPDCM6x27N for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 06:57:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C9B57605EF
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=leeonion.muyu@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; spf=fail smtp.mailfrom=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=MSaxCAC+
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C9B57605EF
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 06:57:09 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 092DC84409; Tue, 24 Nov 2026 07:57:07 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4877A83108
 for <u-boot@lists.denx.de>; Tue, 24 Nov 2026 07:56:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=leeonion.muyu@gmail.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3b44bdcea8aso1906809a91.1
 for <u-boot@lists.denx.de>; Mon, 23 Nov 2026 22:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795503417; x=1796108217; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0p+z8V7ioNXKJBlEmlxyaewpcaFtJJtS6Wmykgz/hUU=;
 b=MSaxCAC+JCWhg9BrJc8R8xO2D7L+uGhDf8R2THT2Y9IG+R0z91PedrLx7lfSFMhMFK
 7RWeEyZ9GblPgY/a0YyArL85w8CkBmdiDb5k3t8iG7ewJ70x7XMLuOqnhqo/vhI8XlFk
 Rb9UVBIO/4xE0tjikaUl30aGQeeKR4tunL6aiQiTJgdlunB+Qh6+1YWgQX0QA2+kAuRu
 1Yswqat/eWoCP3Hy36LRg6oHx7PXQyyCvLW7b9QySUHg7q99E9GCPgbhy/LdtHrW9MMM
 0y4KEnm3OH+iXnZWLclJTcSEmGp+aXGCbOx4UUKgHAyzr4KkzRgsU/whKzPseLdCJKVE
 P/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795503417; x=1796108217;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0p+z8V7ioNXKJBlEmlxyaewpcaFtJJtS6Wmykgz/hUU=;
 b=w/YUnLutafV56Y6BvCTaKiJO3dQG7HdYy3h8lXa651fYE8NGqH92JJ3OzFHpD8X0Hn
 R/usIpLV3nxOC2fPXpHgcQ9PRCTqwLJ+I1SokXPO9dvhmwjVNyNfeitviLQla+q76kl9
 GDM1gyX4M5jvl8b7xftMZ5gvZ0dbl5AVyqRYBI42lc6Ws0O8toPej+A4oyQVngbbkckR
 tvhrekyHjwMKwlW53xVTYYLazMQ+btwoPrekdE5F1oHnPLyekbBb8+M+8kmMkqzKSoCn
 MnM0f5SnJPZXI54dEvzP1aNe1x8OvExQfJlatPo++NxcISRwjp0aGYtKHbuIH+h134RD
 5Q2g==
X-Forwarded-Encrypted: i=1;
 AL+hErFKzfNSz3q3+5/oUOADBqJhWm70oFs3iDpxNUhRwK9X/bq+JiOs6sEk5Tj9AK5UHa3WDqdGR+Y=@lists.denx.de
X-Gm-Message-State: APuU4Z+x8YMPMA72YtzhrnbPFukh/+egf/QXRNA5tUjbOoBXuXhQc9Ie
 hcL1pS4mzywH+g8g1TcO2fGmoBBTQ7PMQjmHgFI+ELLOCfxMMvRQclr9
X-Gm-Gg: AZFdTZe6MNTFb/fSpbOzuw4qq08lZI6Sn7zjxMD5RyQMFcr1AuKPJpRJcN3w6yk5p9s
 ikiAljBIctLhTCGVVmj31D7tPR368OJ1H5sn+HDen/Qh9TV3XZgiusubp9CBbV4H7OZPFqSuDU/
 u2t5O+dsdpRoUYosWV2rYLjqhQxlwJcwXEaYN361woFqvN1PHgBCbbCZH3N5l+EHDmhl0dod34s
 Osxvm321+mE8hSUvA9aE8xPoRZoq8ZN2cBMg7cs9kz5MGb07DNGuV4osNVgmsPNjyiE3wwXR0K/
 YV3DnM9SYUt0dHvKE8jndb0W/QyTuJEdFSJRxpJAskU/g5PMQanlD/jeCaFIccxJ1mV3NV00Q5r
 vYRPvFtgLJCrM702cwKa0Xy90vzah4nRXRwyJloLjgZcM+2QvYzv7gwXli5recrMuGvGBCHl+QV
 fBqQN/zU91UGUeUwG9qTux+kCqPEpA092sva5mzX1zkxbDMhwOqpE/fZsP3lr2cOE6UreJuw1yI
 IFlLbackW0eECz+gNT3BeSip6clCkn3EOeJyw9nFQCUB/CAJKQdFsS94ZUZuP43LWuwKpOAW5GS
 SAJ0BaNHwNpPhHDF26LdKbGYkK0CTe48+w==
X-Received: by 2002:a17:90b:5546:b0:3b4:1e3d:ef99 with SMTP id
 98e67ed59e1d1-3b41e3df0aamr9878515a91.56.1795503417481; 
 Mon, 23 Nov 2026 22:56:57 -0800 (PST)
Received: from server225.. ([39.170.101.209]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03f105b66sm64966685ad.51.2026.11.23.22.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 22:56:57 -0800 (PST)
From: Ping Li <leeonion.muyu@gmail.com>
To: catalin.marinas@arm.com, will@kernel.org, palmer@dabbelt.com,
 pjw@kernel.org
Cc: mark.rutland@arm.com, alex@ghiti.fr, emil.renner.berthing@canonical.com,
 masahiroy@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 u-boot@lists.denx.de, Ping Li <leeonion.muyu@gmail.com>
Subject: [PATCH 0/2] arm64,riscv: boot: emit standard LZ4 frame for Image.lz4
Date: Tue, 24 Nov 2026 14:56:48 +0800
Message-Id: <20261124065650.1968930-1-leeonion.muyu@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 24 Nov 2026 13:22:50 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_FAIL,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The shared cmd_lz4 rule in scripts/Makefile.lib passes -l to the lz4
tool, producing the legacy LZ4 format (magic 0x184C2102).  The only
in-kernel lz4 decompressor, lib/decompress_unlz4, understands exactly
this format, and all of its users - the self-extracting images of
arm, mips, parisc, s390 and x86, and the lz4-compressed initramfs -
keep working through the *_with_size variants and plain cmd_lz4.

arm64 and riscv also build Image.lz4 with the plain cmd_lz4, but a
compressed boot image on these two architectures is not decompressed
by the kernel itself - it is handed to the bootloader.  U-Boot, which
implements this via the 'booti' compressed-kernel path (boot/image.c
image_decomp -> lib/lz4_wrapper.c ulz4fn), only accepts the standard
LZ4 frame (magic 0x184D2204) and returns -EPROTONOSUPPORT for
anything else.  U-Boot's own host tooling (binman) likewise emits
standard frames.

So the Image.lz4 targets of both architectures currently produce
images that no mainstream bootloader can decompress.  Fix both by
emitting the standard frame through local rules, leaving the shared
cmd_lz4 untouched for the in-kernel users.

Bootloaders that decompress the legacy format do exist in the wild
(mkbootimg on Android offers a separate lz4_legacy option), but
U-Boot and its tooling only ever supported the standard frame.

Testing:
 - Verified that the lz4 invocation used by the new rules emits the
   standard frame magic (04 22 4d 18) and round-trips with the lz4
   CLI, while the old rule emits the legacy magic (02 21 4c 18).
 - No full kernel build environment was available for either arch
   here; the rule changes are mechanical.  Boot testing on real
   hardware, especially on riscv, would be appreciated.

Related: an arm64 'make install' fix that recognises all compressed
image formats is under review at
https://lore.kernel.org/all/20261119041945.3624785-1-leeonion.muyu@gmail.com/

Ping Li (2):
  arm64: boot: emit standard LZ4 frame for Image.lz4
  riscv: boot: emit standard LZ4 frame for Image.lz4

 arch/arm64/boot/Makefile | 9 ++++++++-
 arch/riscv/boot/Makefile | 9 ++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)


base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
-- 
2.34.1

