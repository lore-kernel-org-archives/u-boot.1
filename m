Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 459BFC88E4D
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 13:35:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0980A81000;
	Fri, 11 Sep 2026 13:35:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bnwIo80Eb0ea; Fri, 11 Sep 2026 13:35:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DE45F80FFB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789133745;
	b=S8m+vPhcMbyOB0UtTqi1ZhJrAsu3kLHblI6oYUDHAAlHuU9xs5IkJaU3uXLwbiqXeARD
	 7I01jxXZs3XSokNOOszUoEKzMcOoqlXsl6TokmmXMC3RJozCgqMELRu33p/8mWSutKzu2
	 MzOjcCdh7eAZkoLjqnSkWXKmA/qDK1tg7XzBs0y0mfYsMmNZPwBEiUA6DIFBHgj1GjfOV
	 ei6b0plIHtYy18xPPQ43aF8feKcgw0jZD1PZFy7gaVjgGmvcxVUApnfxgFbHdN2kH9ijH
	 Bi8A13JWQjByy50fF6aenHOC4JTxGQb3KTrUTllligtCRFKIhlARUNFTJxcLY5w41qA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789133745;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:X-Yandex-Fwd:DKIM-Signature:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=YhhabqHICKXYr80b4+dGn0c28W5yuAPTMnT96jC3EuY=;
	b=h3ii9DGYmzc9eCz4mazsaF1ogw2DA+X4T6fjwHsq1lmQP5AivmtlV7X4XE1s5s8+jn4d
	 dBJbbB29zbN29V+aWQNc1Ca1KktOCARJZlhg1jzNEZ5ELeP+TurhAGtVbRwEW9kNF0FNB
	 V7lur5kogXpZuI5GhPGmLgeUhrDzMwpMQu7zz7UwGAEgEnfMyHKn9+CqoQP8uV9nwnnaO
	 ft+VIMMy48Pwi1OjJeiXKd0yPZwuy/a5qlPk7FwkXwJVGaj+KqQnh2L7ctY4dTqtja1DA
	 xAcx7XQiPGhqAYPidQR404ztAUjIsffaRbaiw4v26FTUbqFhrTnsHIpc1C/NlqVtrkg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789133745;
	bh=YhhabqHICKXYr80b4+dGn0c28W5yuAPTMnT96jC3EuY=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UKWmCQ+aItt1mYd6PROG04zI3wYSNr5vAlCYgiRAwTTonkWtIJrZNObi9BDooN4X/
	 oIiXAy0dEwDuXfzkhk2RpWuhs9yr1ZgUKqRDrZb8kKlmBZSFC4sOWDXmVMVt2LvKUi
	 W8zmGsFccDLeetfybARaz8NAD4yI2/Nq3kCUzWfE3zG9wnDY/8UimVriipkTtoidIC
	 V2q//xWojsKmWeL5ymezq6DcvhnEPXEflmy7NucrN1A7qOhcCveShmtXsxQbchGrJ3
	 p+K09mbC/XEnq4TNvczQSS45o/Jg0OL165eEf60qnFuEi//KIvCA8fT6XyWf6rpYUt
	 8t25WfoybJlaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DE45F80FFB;
	Fri, 11 Sep 2026 13:35:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B4935786
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:35:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9AA934069B
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:35:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dk1Tbf3p9Tlb for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 13:35:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 26C7E40699
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=178.154.239.84
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789133738;
 b=L03QCy6K3h68Du2HVrY1hbt28Mpf6MyIFcgQ9kruKid7Dazif4HRewwkrKDg85jXV7pl
 ctIxnS25pY40ryd4phUOHc43m7g0hPySNwdCE/kp247+yqtRqWbSuLsmRwX6gs3aG3DKn
 glNpz+Ahf1bc0aEnY4+8AVOMMWESVrJF67XL5MSHLuG0aM3T4AP1RqAPYz1JzjYSpswsb
 DtSzCDBZK4giZwLpWZmSTEoYLP/+xR23jEym1gXIVfxg2CVXnfbL3zk/gNPDJahsRomNo
 zy8t2S7JzVT9/0G7FBYhuOUGYPeoQDCv8nT9JnlMxz4/Y9CxDUTIYJReHrJKp226IiA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789133738;
 h=Received-SPF:Received:Received:Received:X-Yandex-Fwd:DKIM-Signature:
 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=YhhabqHICKXYr80b4+dGn0c28W5yuAPTMnT96jC3EuY=;
 b=qjvtLWuPmxZaleS5C9yuPu+mnZm+V7Q0TXFbCSbWhU6LIKiP9ItqdfB5feLEsfytQmwf
 m26NKfkWhUw1SEb8Cer/UtXltlg/5q4TvR+zpCPIMnj27BmsLR1xCba0u6dJsOSR84AFg
 vPsyZxRwbgZj+WH77H6bNBMhT3q4w3Povezm9o71HSqgLlYi5Bt5neEVd7ax7n8LTNsYQ
 B4ok66o3XnGPzeQNt3ZgUsFzGzjmc0IBe/0oW15c+SdsaYy5onhEI12MLLJ2IDHd9BN6a
 sjcwkCnQDPsGP9Qac1Cv+SwNaYi0lnEUAIjRS5BtAOCWUGWszFV1KKci+xPC3brAQRw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=maquefel.me; 
 dkim=pass header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b="gY0S/8Tt"; 
 arc=none smtp.remote-ip=178.154.239.84
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.154.239.84;
 helo=forward101a.mail.yandex.net; envelope-from=nikita.shubin@maquefel.me;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=gY0S/8Tt
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net
 [178.154.239.84])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 26C7E40699
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:35:34 +0000 (UTC)
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net
 [IPv6:2a02:6b8:c41:1300:1:45:d181:d101])
 by forward101a.mail.yandex.net (postfix) with ESMTPS id 8D7BE80D12;
 Fri, 11 Sep 2026 16:35:29 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:49a1:0:640:3edd:0])
 by forward101d.mail.yandex.net (postfix) with ESMTPS id 77FD9C0046;
 Fri, 11 Sep 2026 16:35:29 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net (smtp)
 with ESMTPSA id RZQKjqwlda60-u1boB688; 
 Fri, 11 Sep 2026 16:35:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1789133728; bh=YhhabqHICKXYr80b4+dGn0c28W5yuAPTMnT96jC3EuY=;
 h=Cc:To:Message-Id:Date:Subject:From;
 b=gY0S/8TtSmA7Rm6bLqdn1VCy83ftfMWofiZi36GzHXxCv2TBV26uZ5HZU/UKzwG+K
 4Ujxa9Lgq1TWi2HL9O4Xht/5rk66qR0EvtOMKx1q3ytZfjAUAslKHu61v8le0XjETk
 Sl5qDnWu9Dyp1uuKm4NO+db5cha6Ljw5b1CbjBlA=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
Subject: [PATCH v5 0/2] riscv: timer: Fix M-mode early timer support
Date: Fri, 11 Sep 2026 16:35:22 +0300
Message-Id: <20260911-riscv_fix_early_timer_mmode-v5-0-98e7aaf91396@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NwYrCMBDG8VeRnDfLTJqkZk++hywlaSdrwNg10
 bAiffdNPVWE4vH/MfzmzjKlQJl9be4sUQk5jKca6mPD+oM9/RAPQ20mQGgwIHkKuS+dD38d2XS
 8dZcQKXUxjgNxbKVviCQhaFaF30T18KHvv2sfQr6M6fZ4VnBe33MLcuQCgVptHNhe7KI9X8nT8
 TMSm+UilppZ1wQHrnTjvBdWQa9etWahIaxrzawJp7TxFgc9vGpyqeG6Jqu2bW3rlHXeqO2zNk3
 TP3gkyRqyAQAA
X-Change-ID: 20260904-riscv_fix_early_timer_mmode-174f3ee4e106
To: u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789133729; l=2070;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=fu6I8UBEdLX3CJmBl4Z3WCbz+4lKiVxmQPYPBjlAqkE=;
 b=A9Ocwi9AhmejymEoZ3PHo06o1moFUxDpAxGnxwQdj5rDLfVs37RL/lK+Vxe5wpzaak+DdhzBb
 8VmfQ620nrGBbS2L73xS7+shVBZ696eJV3inCheCD/YSJu+uBDmisl5
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
Changes in v5:
- Rephrased commit message for Patch 2.

- Link to v4: https://lore.kernel.org/r/20260911-riscv_fix_early_timer_mmode-v4-0-87a7b5abf958@maquefel.me

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

