Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CDF3C88E50
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 07:14:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1483260B18;
	Fri, 11 Sep 2026 07:14:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e0yNigCKeVZQ; Fri, 11 Sep 2026 07:14:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 26B7A60BEA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789110864;
	b=dNfOR4qBb1S5ip2rZcTjfPGxFuv6Hs4REjlW/y+8fLCffE1/k9XGpHP64XVzEyWbgsYX
	 NJ7OaNBYQA3boXO+ZxD0VDIcT7jxQE5oyskjvJBICpKK2t/dhiKCy00pL8aN3zbXBflIF
	 0fL1vU9x+4mBErZyxvbUja62hwdIqzxVYf3FfFBtPlkgknWbCIXbVu6Mn5VsgcjULRlDS
	 a1RVJhXmffA8XOHtDIaMSfWdsyWuCKn1zUzJySfas4pRWXFrjmV9CGhsP913CbwpL8R/B
	 NQ76CEF+iFRwsRyiCEzrMrQ5/yImDoXnxBO2inD7d0Ny+l36RwlSOoe0O4vWhj+XNjw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789110864;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:X-Yandex-Fwd:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Qah/Jo4e7p1bVqjF9W+pD/uqSr/MaC0MyRuTwNLT8nU=;
	b=mlcdRgi/tSEzAXZCSSwA1RCFVZ84Nj+v4QdjwTzgGxrGWYnt8T/NyaQ/gN3enMQ5ZEhD
	 YD9hcof+PISgaOae7dcva4rrtPnBmlwxp0CMpR21Gq5YpgPo6DeSMATUJzjg6CXa992oi
	 QqNlNj41OkuyGvq96YYdMgFIOp1jBh7tcx2Oi67S4XBP8j3HFZ+ADiz1saHjGBAAybdil
	 r72CfNq2qlLNpRi5ts40R8OVCwJ8V0cK2kfp7M6009e6RUshiNz3rFv3GHGlNLyHgLyX1
	 At/aIZSr6f6YQA4dgbaS6j5XhvVAcseUbEeKzuK618DMV2mKoiarGj0EuA5/Q5e8Urg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789110864;
	bh=Qah/Jo4e7p1bVqjF9W+pD/uqSr/MaC0MyRuTwNLT8nU=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fXoUO4o+PYdPpmXE6FEIh02rM8lgO/NCHGAxUaNN2Vd0i6wQa0Af7DLmntP3p9H3x
	 YOBcR40kXjztV6gnAYbqrh9KPAzzQ1Ifil/2pNYqQQ+DxMeYjIDJzLxow+3Lc+P8G2
	 lTo3SV65cvYin/wFe7PlRvI5+f5W817AOT+yGG4nkXvXcBroT9ZXViDXuWTj4lS5yQ
	 PGY0pxtexJZOt2k29Yw6mK1e3kJtzx7r6XD+81FZ7WnQi5lykSq6vD7HRh03rxsp+W
	 UQoIczw8gWp6urGpLVGVDKaqMPT9+wvAY0uSliUUjBa8e4sGHpJlytKeSPYa6TY23W
	 otqI0RavkblGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 26B7A60BEA;
	Fri, 11 Sep 2026 07:14:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 68545362
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 07:14:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4E3DD811C6
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 07:14:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jS9Je2HksHli for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 07:14:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0C66A811EC
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2a02:6b8:c02:900:1:45:d181:d101"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789110858;
 b=SfLfJa0mrQwdfmsbS3HReVlhf84oSWcIp+m4hKOx0ivR97ZQ173ayVgPHiWKBw07ofar
 xIHFkz7anvuqARcyRAuwClrhe1cCEQHYAaU8HbTxY+YITXSwDcp0pR+BR/q1qrcyI4e+j
 QDEjfPIHCIxUP7Sx3HUDz/dxsFmuzkR/qxTuoZ9dw1/cCumg4ow1QrpgCCQafbpmFTdLZ
 Gq4DjBZvFbeSBLUGnKZLXrx4z+Jk8acrHvG+r96DrUP5MMyctl9l44qcTluPrdwEokJ6R
 kk44nh+Ku5s0dNxbut/BlGgVQU+o55CAJhLGAhlYwFb8FmfOy2cbYIB4LUtzWftUSDg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789110858;
 h=Received-SPF:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:
 Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=Qah/Jo4e7p1bVqjF9W+pD/uqSr/MaC0MyRuTwNLT8nU=;
 b=RH9Jj7r9os5Vel0xpkDbdOmWl0OXSWxQRGgoRYMd5Z4rAkBibf4gAhuX6/Mdf8lbJdVS
 Pbp3DyIttu/jL/4jXLAJk39NwbNBxvF2yQsJ8midFuT29NEKYDHce3f80DJOfeOJBOJyH
 /nlCPB+Kht8qrc9VysP05++tv6FhIpe5JyTur897MJMdtcYbxkjCvxHmydO99K6UifaRc
 7TZdOWAWv6VnqdbtSU7PZ+puTEP3oOm/dRlYA+9kgU/8mV3tpO94tLmIdI6JJQ6YG84HP
 szsnZgaGLWzVFwWKaFkPsYXZJsAz4ehzUlB2kLxzcQEQT9GNsob2C68TsoWkIw2Nrsw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=maquefel.me; 
 dkim=pass header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=sxHY5M71; 
 arc=none smtp.remote-ip="2a02:6b8:c02:900:1:45:d181:d101"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a02:6b8:c02:900:1:45:d181:d101; helo=forward101b.mail.yandex.net;
 envelope-from=nikita.shubin@maquefel.me; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=sxHY5M71
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net
 [IPv6:2a02:6b8:c02:900:1:45:d181:d101])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0C66A811EC
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 07:14:14 +0000 (UTC)
Received: from mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c11:4021:0:640:30fc:0])
 by forward101b.mail.yandex.net (postfix) with ESMTPS id DC1E0C00E8;
 Fri, 11 Sep 2026 10:14:08 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (smtp)
 with ESMTPSA id 6EKFZlKoaKo0-XjmHAQqY; 
 Fri, 11 Sep 2026 10:14:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1789110848; bh=Qah/Jo4e7p1bVqjF9W+pD/uqSr/MaC0MyRuTwNLT8nU=;
 h=Cc:To:Message-Id:Date:Subject:From;
 b=sxHY5M71xQ8fOPgOT1u3OBD72P92BVG8nhgSFbeI6YW4twTg1hYdxqdUvznWj7ovq
 krVR36D4wSITx9yu08VCbr8WwnuKj2Irw0j2AdovUTHotOwg9rSIwe7rcTJ13Q7rl1
 8ImwvbhqQLDC6io0+YGATo3qcWcBcyNrkcHo+iJg=
Authentication-Results: mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
Subject: [PATCH v4 0/2] riscv: timer: Fix M-mode early timer support
Date: Fri, 11 Sep 2026 10:14:04 +0300
Message-Id: <20260911-riscv_fix_early_timer_mmode-v4-0-87a7b5abf958@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43N0QqCMBTG8VeJXbc4mzqxq94jYkw9y4HT2mwk4
 rs3vTIC6fL/cfidiXh0Bj05HybiMBhv+i5GejyQqlHdHampYxMOXEABKXXGV0Fq85aoXDvKwVh
 00tq+RsryVCeIKTIQJAoPh/Fw1a+32I3xQ+/G9Vlgy/qfGxhllDPAXBQlqIpfrHq+UGN7skgWO
 fCtVuxrnALNRFJqzVUGVfarJRuNwb6WLBovM1FoxWpRf2vzPH8AIHyPcGQBAAA=
X-Change-ID: 20260904-riscv_fix_early_timer_mmode-174f3ee4e106
To: u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789110848; l=1901;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=EfU7+cjZKvwtTVs4P5Azqis7OYSS2qiOsjOnHimGWQM=;
 b=AGbFC2g1G+1qXZIBWzQgdp6ThrV+VHFpkz8zbi2OFmg2vV/m/lOAjRjv4dXr1t2kj4Pzghb+9
 btj85gE37j+BqBgHJtlGbhJn6hqYioq4YTq+UNYr8swJf1HHcNqUphX
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
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

This series addresses two issues with the generic RISC-V timer driver.

Patch 1 marks timer_early_get_rate() and timer_early_get_count() as __weak
to prevent link conflicts with other drivers (e.g., ACLINT MTIMER) that may
also provide their own implementation.

Patch 2 adds proper M‑mode support: timer_early_get_rate() is now defined
for M‑mode using RISCV_MMODE_TIMER_FREQ, and timer_early_get_count() is
no longer guarded by RISCV_SMODE, making it available whenever
CONFIG_TIMER_EARLY is enabled. This is necessary because functions like
net_random_ethaddr() rely on get_ticks() which uses timer_early_get_count().

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
Changes in v4:
- Change KConfig description for RISCV_TIMER: drop ACLINT warning as we
  define funcs as weak, rephrase note about macros and make int make it
  more compact.

- Link to v3: https://lore.kernel.org/r/20260910-riscv_fix_early_timer_mmode-v3-0-52b569fa1d6d@maquefel.me

Changes in v3:
- reoder patches so weak definitions come first

- Link to v2: https://lore.kernel.org/r/20260909-riscv_fix_early_timer_mmode-v2-0-563bff2a50c5@maquefel.me

Changes in v2:
- Updated Kconfig help text and driver comments to clarify M-mode support
- Simplified code a bit
- Add patch to make timer_early_get_count() weak (optional)

- Link to v1: https://lore.kernel.org/r/20260904-riscv_fix_early_timer_mmode-v1-1-210e769b0ac2@maquefel.me

---
Nikita Shubin (2):
      riscv: timer: Make RISCV_TIMER definitions weak
      riscv: timer: Enable early timer for M‑mode

 drivers/timer/Kconfig       |  9 +++++++--
 drivers/timer/riscv_timer.c | 16 +++++++++++-----
 2 files changed, 18 insertions(+), 7 deletions(-)
---
base-commit: cc557af4553382f6f50e3ed62b9577054e7bc54f
change-id: 20260904-riscv_fix_early_timer_mmode-174f3ee4e106

Best regards,
-- 
Nikita Shubin

