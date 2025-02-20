Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701CCC021B1
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 10:00:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E07080EC0;
	Thu, 20 Feb 2025 11:00:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="KOMHWj1b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73BB180F32; Thu, 20 Feb 2025 11:00:33 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 497F680C98
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 11:00:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C05BC3F2CA
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 10:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1740045630;
 bh=niOMAIEiUjzcKpy1Kv9su1zaRz0OdO3+F3x9bHCL860=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=KOMHWj1bdRKc95fsL9c9eVV4rftWKu1ubRQ5jFZVbXlSFGtf5AIyu81yREiCoizxA
 LP/k1R+PLnFlNOBiTNgmgRBorff8cVPwqSiktoQwANeuNZZyHJ6uivo51WPQzzOLSp
 YcxCK5kKs0KadESSnfs7TrksNs2FCO7L3Fy4mNazDAWVFCj/AtyqIIrd+/8+tuxKXd
 mBIMuVbEB9Q5rgZM0GTv40TfXjHAJbMtB8QLPwlRwd/2Mw9P/c5Akx1oLe0Yzbnttl
 ib03ETdxSfCQ6ZQA3gqypylw9f21u1YWpyXBqlCEZ9o5B+m43oovlFloRq+WvbhLyl
 9VAZtaOS57ubQ==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4394c489babso3575255e9.1
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 02:00:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740045629; x=1740650429;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=niOMAIEiUjzcKpy1Kv9su1zaRz0OdO3+F3x9bHCL860=;
 b=YLnbpFaWImPgD/LklOQslWi11eu9VusaNicg6r5UFd7Zs2bNLaYTK3fbh+fdsZeCWs
 b33XazFRe4UC1PEPhf1jILAf6dv0An+LJQkEU+1cURWvqxqhJ92IpFhjvxC0OU+YCIVd
 fEOLKK5ing3lr+TTwqvItnnPhYbGd8YQwLer4peTVvMCIA5PqS+42V9qoRj4CgFMdqpi
 a48ZSIBAo6tAQW6SXS0qpm+6D7DV+t6Wl5A48qkqnnv+9O1NEKXbiyKb7Xsn8w2VPNj5
 0cIiQn5m6pwWd2trj8gfbOhaiQ6jx6LsHFrE/4rpIueXVoIhfWwk5F5VC1IHPU53E/7x
 /ciQ==
X-Gm-Message-State: AOJu0YwGrjhudlG3f3dt5lRriy/YnCJtNXxQyTdASpr59CSHWCoe1/nd
 nqezK5j7Iu7neImw8K+SBLyWkuImXhUQkOhEbBSLBuogmKZRSt3LiE9xnGQSemthxTZ170lJNxb
 rK6ANv88EZ9+6WJJp7Zb/wgiEEtf5s/21bmIvLavVwnMgo939UmmsVtr29jZeUqHRyc8=
X-Gm-Gg: ASbGncsniRoMq6s3hEcA71tjp+yETWH+zkCGC/JdMWgB/h7rbGUTGfBCBW/8LzQer5u
 VOIa0kM6LEgrOeQt+NF6+YHMHKP09lETwxVBrsrZvLHOKgT5QHoXu2EQWix0WTH6nj74k0WmzQ+
 CILknpqZEjuEls5rEA6H8LlP7uGtTVzKBzIerytFDKn0AaI06jBW+LvLt8zMMsA0Q3hxYkaiEyo
 GPC6jmPVGv9r+Q/eAm+Yr4CVtML2QS4eliPWnXkMDdnccZpjAwAT2JOnAPeuVQHzqkKhtLp00/g
 JUi9QkjlBFqMCixYqgSuONRpo7kw2STRUo7qvA==
X-Received: by 2002:a05:600c:3b27:b0:439:98ef:5d6 with SMTP id
 5b1f17b1804b1-43998ef07c3mr67031035e9.22.1740045629650; 
 Thu, 20 Feb 2025 02:00:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/vAWesCAgGATPj7gkhiGXLCryMJ/t0aOWd8eubEXCwfG0QfrseT4YpRkimrFicYJz0e1M9A==
X-Received: by 2002:a05:600c:3b27:b0:439:98ef:5d6 with SMTP id
 5b1f17b1804b1-43998ef07c3mr67030715e9.22.1740045629263; 
 Thu, 20 Feb 2025 02:00:29 -0800 (PST)
Received: from localhost.localdomain ([2a02:3035:6e0:1d2:497a:3557:382b:d853])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a1aa7bcsm235578005e9.28.2025.02.20.02.00.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 02:00:28 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] scripts: typos in event_dump.py
Date: Thu, 20 Feb 2025 11:00:13 +0100
Message-ID: <20250220100013.43496-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

%s/even spies/event spies/
%s/EFL/ELF/

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 scripts/event_dump.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/event_dump.py b/scripts/event_dump.py
index 24dfe2bda91..61bb3a8eb92 100755
--- a/scripts/event_dump.py
+++ b/scripts/event_dump.py
@@ -107,7 +107,7 @@ def main(argv):
     Args:
         argv (list of str): List of program arguments, excluding arvg[0]
     """
-    epilog = 'Show a list of even spies in a U-Boot EFL file'
+    epilog = 'Show a list of event spies in a U-Boot ELF file'
     parser = ArgumentParser(epilog=epilog)
     parser.add_argument('elf', type=str, help='ELF file to decode')
     parser.add_argument('-e', '--endian', type=str, default='auto',
-- 
2.47.1

