Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A5A1CA5FA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 12:52:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E90E660853;
	Tue, 29 Sep 2026 12:52:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QaDepi5aaU8A; Tue, 29 Sep 2026 12:52:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E73AC6089A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790686372;
	b=J4P7/PEHxpn+BXNOPvnirL6K+Zgj+x99dngp22GcMWXIWgOyhwwr2DAXBBrldf8aUjyy
	 3rSuV5v1Q1rw4b/DIC8n1M6QotLppPgQEPI7qk/lRBi6ABm4eppOTz8DXesKJUfIKSafL
	 ePQ9ENvS+v3W+8xSb7U5NUI7vM4T0QkQjl89HlxkrNFRkE9ykHI/mb0/SB+ANckbFRGZ1
	 PUCbu26fYvL1WTa/7nW2lwILyYsIiPl9T7nO18J5U7Ah32lqmqWLYbl9iDfMaPacx5YZK
	 kdeIA19fKAHIO3zqSItQqDLzKD3mWQf/XypjeCXK9wT8keb9nufTelWzrAdk57FxGHw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790686372;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DREthz3FRrR4u9sficMEJU38+Vfyo3ptIbitU98yf9w=;
	b=YfW/rKjWHZR6zalvFqA0BKUC52O41uAdZlFQ15KH5NUG2BtDWUREgcUTwoIBUnGeMYuM
	 1oXyUw+obHjqyX4flWuf4lMEOhWvMqJWfdukrsmnW4KeNDbY/qHUX2qHFlpLX1VwETDjb
	 PAwQaeArrPpqSUlT9jqVyfFBhm4REaJZLOh/8HuDKW22L8A4boqo4sRV5QY+ETILI/733
	 YzJUJ4/qugDiDRy4U8zKxv7mqy5yKQWIyOOEx+ZGLzK3evk2WeUCCw2TuYJDHB+zOC0eu
	 /u0pSnn31Ni8g9+W1Uplq350WIt+tZss7SM6BTrNqUkosCxO7tORfmSNsx8cZUWZAlQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WQwz7RPj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790686372;
	bh=DREthz3FRrR4u9sficMEJU38+Vfyo3ptIbitU98yf9w=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NPTIkQvkpl3r94gRLG4B23l5tpgJSlVeeU9hgc+9NN4JvmD/yziHQjPMqXG4LfexC
	 sBdOAB3d6KjzM6FZAYJKeM94rHywvnllPYrKg2ZYuYhG7sWJxJtTVB1z1FGBXDa8YE
	 Xov27w65R0tQsxmRlYWnQYTbhEp+XG8fcvpfaSXE3FBwNYFLFUGvsGUlXGBAkhC799
	 hgbN4/4sxK2TxH2w4ee5FGCJumHpcm14IztpO1osMTVWu8yFBVybWlmCGuFLGzOktf
	 3Hpfoy9FtQjhwTVSwz26sjh/F+TfG+UT96Z7yT1cUnck8y9BfJ5net41Xz1FjVdPVe
	 1BXMjxn8Sk95w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E73AC6089A;
	Tue, 29 Sep 2026 12:52:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 85EE1D1
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 02:03:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 73FD060703
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 02:03:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MSgjZ8bcVUyg for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 02:03:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E04D160613
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:3b::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790647425;
 b=BcHTVv2D04O1qq1SF0X/sztgWg7Xg2Fy+yEBU5EOlYjlG/5B2Q4EUTzyLUlIJp1h6i+G
 wLEq32zkr9o7TB8XU/BIAQUGI+9nf13hWVkZLpf0cJu7WiPR5Ujra/xN/V+IG6UtE36zD
 55kL2oZcSDjotk8yQ981Zg/s6ps7yv5cN34QWfB3w6Z02RwsfiwFB+9L1UvLkwd/HoY4N
 O0BSCkOq6T/Qfk0rjmJbtYl65PpAPNiCoAOXkQhGAohRM/bfINpwpsH9QXuflFMpOiVOr
 zMjWV5XxHmCNrFE9qc24QVTOIdnmBpCAaqiccehEgA7YhQM1vjNArNHsHAX/nSH40UQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790647425;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=DREthz3FRrR4u9sficMEJU38+Vfyo3ptIbitU98yf9w=;
 b=OG1OhFE+q3nB376V4+KoTxDU8oKos2k5bHFu7UwPahH5H/eA5dr9zYzyV7BCf57hwcUO
 GUhxGbvOwSRjdF04t9aCyxT9mhRzCrWzAnlCLxg0AR48EiFx6eVA6kMrsUf3th8SEYq5b
 fxY5ymorlUKjYKEE0BGhCHt/jRWVup0olcNNWoAN1pO9xH4jQZ6BIVRDL0deha/YsjDOq
 T/1tL81tbuxHyVKbFuMXDCRut8XGoY7hnlk2CHlPBKDwDj18wHmeX2pBHEtxIZdGcUTF3
 izagFM5Ih28EgpkW9JD6YuOZIp1BxygmXsNw5rgvgz9B/H35dgW0JlPyN6FjhOCaT3A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=WQwz7RPj; 
 arc=none smtp.remote-ip="2607:f8b0:4864:3b::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com;
 envelope-from=jun85566@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=WQwz7RPj
Received: from mail-pz2-x10.google.com (mail-pz2-x10.google.com
 [IPv6:2607:f8b0:4864:3b::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E04D160613
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 02:03:44 +0000 (UTC)
Received: by mail-pz2-x10.google.com with SMTP id
 d2e1a72fcca58-8633a38df87so1522262b3a.2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 19:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790647424; x=1791252224;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DREthz3FRrR4u9sficMEJU38+Vfyo3ptIbitU98yf9w=;
 b=WQwz7RPjMFKUnbDARkkrF9KqF2r62TbzgNa0a+4+1+lPR1K3FflbYjggX5MROCTsew
 OuAHuacSnY3dmnRmaY/ulPq2VZi4VimdPTzLX0kEVb4rpeokNJdeJJOTPxhtmupztcks
 M0Y9uex/G+lITxMiIr01YMwsgL3dcbirrMo/rCeqI3NVirlRG7q+6BqF6Mi6TPjbRil4
 5A8K7Nns3PtuQZ74GXk+banW7nSvQYN/qoZTVoR2tSwfCJlW31Yts00VddB9rF+h5zrI
 zBj5tdpDCILJPLVfRtvK6M0QhzP6UgLlujLEfYL+CNfT6iPOWGu+3Rm4tU2WfZJTzpvq
 HGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790647424; x=1791252224;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DREthz3FRrR4u9sficMEJU38+Vfyo3ptIbitU98yf9w=;
 b=QxeTGoXnQfdBxS2QYUpGFf9ZMmbaKRYCzGN42tahfSmZM7TToQXOuQAXIG5leilh7X
 vY+/6AQBX8eWWrPd3ibKw+Z+Tngz7mPFkn7+zZ1g1icYoGdiSbMQNwZmElrY2Q+F9Xmh
 wETLns95i9qjSbCw8Flja5mnQ5jzEQgINfTluRzFVy2b1YR+8ecIASX+YKWmW8jQ5Y5P
 Vc0YZ91PTieWuKfUdMF2Y2yv35TZmr1dCZzlzYryMo+lrJrUOA3Fv2OOTrsKhp+I0W/B
 ls0Dn7k9F+EpDScfL2r/60xo01kq31Hc//zN+q/c+dqn2CsI1AJdiRldejUETG/errhU
 X3fw==
X-Gm-Message-State: AFuF++mLkp4vdIQNDeG6hKlyRe0PkL3gD85JngQ+nxkhdhdHd4BYd7y/
 MVqXBulWunqRcomm42rWhfDselBzeQwfGG+6rpvRtLho2doVyl2NVUSZiEuzNA==
X-Gm-Gg: AYBFou39frusv+HyLsiXw0Qw5ulz2hwJ6Rhe+xHIawzXrsoR8YTwKsRNVLQcQ3RzBho
 MAROzPMwZIx588FYRLwE82i9dgM1uj7KAEaYdJoK4VAkrKrkCon2DuF+TppmzhBgfAIdocMFJZd
 q5SV+4ONJRJk0zkUBsWDgcNrJcA4aEmoonzYl3lL8br011HIsFSL8qs1YtGjejCQrh/GGUU5jyW
 DzgauekESBhD4LkExhHg09e6+DcbPsANGwyeAZKc1xQp1EtMdawOve+dFKmqRipwLf6IqjNcWpm
 tGRpgHUvTGvuveqHQkgw3h3ku1YEn4JOC5aYk4l3+FRyUUZxGP4supq9IeugNI0r7p1fYqMhxel
 j/xovQjE1TGBt+sAIA9IbQOKkVL5vfP1KO9l5NUyGjcj67cBirq1PIqxReY/QJ3OOJH6jx7JFuA
 g5Jq6cqLL4ZidpVDZnkOq5J3fWT+dTwRO5qzTuBETavYQ92F91jEiRBmuPkZwYvrG9sKqpSUWqm
 qKVUFHwiDYzUjfhunw=
X-Received: by 2002:a05:6a00:1823:b0:881:1c44:daa0 with SMTP id
 d2e1a72fcca58-8811c44e986mr6917550b3a.4.1790647423709; 
 Mon, 28 Sep 2026 19:03:43 -0700 (PDT)
Received: from LAPTOP-GHDOQM75.localdomain ([112.217.167.202])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-880b28dd5casm4273760b3a.7.2026.09.28.19.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 19:03:43 -0700 (PDT)
From: Lee Yongjun <jun85566@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org,
 Lee Yongjun <jun85566@gmail.com>
Subject: [PATCH] arm: arch_timer: prevent recursive function tracing
Date: Tue, 29 Sep 2026 11:03:33 +0900
Message-ID: <20260929020333.123572-1-jun85566@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 29 Sep 2026 12:52:50 +0000
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

Function tracing uses timer_get_us() to obtain timestamps for trace
records. On ARMv7 systems using the architectural timer, the
timer_get_us() call path reaches get_ticks() and get_tbclk().

When built with FTRACE=1, both functions are instrumented with
__cyg_profile_func_enter() and __cyg_profile_func_exit(). This causes
the tracing code to be re-entered while obtaining a timestamp and
results in:

    trace: recursion detected, disabling

Mark get_ticks() and get_tbclk() as notrace so they are excluded from
function instrumentation.

Before this change, tracing is disabled by recursion. After this
change, tracing remains enabled and function calls are recorded
normally.

Tested on QEMU ARM virt with:

    qemu-system-arm -machine virt -nographic -bios u-boot.bin

Signed-off-by: Lee Yongjun <jun85566@gmail.com>
---
 arch/arm/cpu/armv7/arch_timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/cpu/armv7/arch_timer.c b/arch/arm/cpu/armv7/arch_timer.c
index 36c557d4a8f..579b6feb1b8 100644
--- a/arch/arm/cpu/armv7/arch_timer.c
+++ b/arch/arm/cpu/armv7/arch_timer.c
@@ -37,7 +37,7 @@ int timer_init(void)
 	return 0;
 }
 
-unsigned long long get_ticks(void)
+unsigned long long notrace get_ticks(void)
 {
 	ulong nowl, nowu;
 
@@ -57,7 +57,7 @@ ulong timer_get_boot_us(void)
 	return lldiv(get_ticks(), gd->arch.timer_rate_hz / 1000000);
 }
 
-ulong get_tbclk(void)
+ulong notrace get_tbclk(void)
 {
 	return gd->arch.timer_rate_hz;
 }
-- 
2.43.0

