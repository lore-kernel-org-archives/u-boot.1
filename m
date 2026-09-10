Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08111C79FB7
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 05:37:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 25F7B80F24;
	Thu, 10 Sep 2026 05:37:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rw_AvpV9wNwp; Thu, 10 Sep 2026 05:36:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 21F5980F0F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789018619;
	b=XaYXJBVHkhEJRZcEm2JoEQQy5oFF+co8WDqaCI5NYO7VZ2dWb7hT4GtsLTbbAvBMu4U+
	 WEf6AcbOPNzVvt4v+/MeUVV4ISQOEuSIeM8eqwxbIQC4FpHRBaPlfRyX8fWCaWYufdkKm
	 Qb8Z1hPfVbEjkz+JQ/nEN3d3cTOS0xwS1WXbHn9KdYTqLyEQ6CUPmSzA0hI/8m6oWHZt7
	 s9oOYg3+IgTSdYuiQYfeVcN9Dg/xHx0JxmRD4V456mdd+LwlhJ1feOiIO4lr5gIQ3pmny
	 u79+OsjXpW/I/nWQnJZwcALdwNg+PcWXsXqSKCK0GKXJSWBXcGl/00VTSlsfpgOu/8Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789018619;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:X-Yandex-Fwd:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=M5qQ7OE6ggwZXvrAj0XEJIH3psPod5ma6e8OahWsJvE=;
	b=s7p4eL729dLsw5ahYpg3JynIb496LgNysdXirwl/ApUg854zeOvRfzSInYBBgRMNoDxf
	 doO/m5PGoPox5rLOUXC0Xd4luYhkVKNOhU9pq+j3coRKx7lFMvC1uTzfDxrlf4Xdb/NWc
	 vMe/6a4B2CgKwWkbLl2sgwgQ4kFwW3NbiADAGTJRcRekff3LSLSe6bOulJo8qULGPItDZ
	 2whJDgTEmwJaeie3eNZiP6PdZHyCPBdB7N7NsNNbmtnToCTjnUBcUFt95+686XHhn+54V
	 5f0Qag5mjskeg/2pHTgm1LccG9EvR5XDJhP0ivcybHo1Ss4c9cStGElCVYHSafG3jeQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789018619;
	bh=M5qQ7OE6ggwZXvrAj0XEJIH3psPod5ma6e8OahWsJvE=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=xDdC13M0ECeCd+BVZLPR924ypzQU67UG/oi+LdWXMeywIrob75e8Vtd2FWygqoaKd
	 lPBIKuT7bWwTuk8CuZIsJ7p2vwt9gjgT8hVYqVy9clZmKIcEVngnLgGRQMcw/F9ND0
	 eBnZamKpBJPTPpWVG9KWgJqH8z+Hw6waanOtumXgMv5hwYMBx8LcQuAwfVmgerx+HV
	 KhaUsXBohtj00HsBZMiFXhwWuvkrmbwqGbB6WXg7UMOks6QeksRgfPwxht/KVVupGs
	 S4zVRdXokkrRRjIZlrquEbv9YUMww1DaQldDEmkVX0x6kLL0POzcOYzr/KtzCwGD0v
	 3hCX2ogqMlqFg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 21F5980F0F;
	Thu, 10 Sep 2026 05:36:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5BCBA362
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 05:36:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3DF1540851
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 05:36:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qZ3pYMpPWR58 for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 05:36:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8D3F6407D3
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2a02:6b8:c41:1300:1:45:d181:d101"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789018613;
 b=KwujCQUUJDw5imb0+DktNU0nOM1oTvdS328r/CWjroNui+IIgc6U1TVMumeUM6Lhg58T
 ahzpc+nvVFq3uMuVbj47MAyTnsqOPBmGA3b+tpDFpJlI0B9gwLJ4FRvpmHH71X9zQDlUH
 VKyOVhaqU/efwjuJ1SNFMnQ1eVdkz+Zp0sKXozoeAKo9YRwBudjMV8L586tjKTXLHMCYR
 FfDCwgnHIqqNMga3tk3QnE7oFhUg7dhy7q+1gNshEnY32YtaPf13Ns8IfikBleNf3S0Wk
 QvKJCis0RZ4Mli58MiyaQgJwp/635rxBDt9WbjB4zxi0c3vjh+3MyIUqT6xZgCc/ixQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789018613;
 h=Received-SPF:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:
 Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=M5qQ7OE6ggwZXvrAj0XEJIH3psPod5ma6e8OahWsJvE=;
 b=HlBH0oDHq2rGsIkGQ5q4BFh3LMnppO+Jn8YJYhMps6ACpgrAgO5OSAxO6ppfG7Sbbc/L
 Vx6+C42a3C4aSxbj8HofLZww1i84jeq+q/+o3MX6thD+caXRP4hBjNl5zxwhQlSjnbzaB
 pIfUDMrK5clDSdu1ZSx5KggnTtnDew2zH4v1fb2ZStyw4GgZ6qjT5kmus1eQMVjfYGp1c
 soLUPjd+Z5zYDZt30bxH5OGparEwKsbazGWhlwdjLq/67aUHiz6iHgyojsFNEcHr8L/9q
 34M9wXIrOdOWDM3PgMdg3+TH1PNrtY0A+6HR4ry+T8W2f2MGeqpWgMV679315fv/kgw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=maquefel.me; 
 dkim=pass header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=KcLIE2sP; 
 arc=none smtp.remote-ip="2a02:6b8:c41:1300:1:45:d181:d101"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a02:6b8:c41:1300:1:45:d181:d101; helo=forward101d.mail.yandex.net;
 envelope-from=nikita.shubin@maquefel.me; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me
 header.a=rsa-sha256 header.s=mail header.b=KcLIE2sP
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net
 [IPv6:2a02:6b8:c41:1300:1:45:d181:d101])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8D3F6407D3
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 05:36:51 +0000 (UTC)
Received: from mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c43:9cd:0:640:e66:0])
 by forward101d.mail.yandex.net (postfix) with ESMTPS id 562A1C007E;
 Thu, 10 Sep 2026 08:36:45 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net (smtp)
 with ESMTPSA id haHu9dld98c0-RRjGoDHr; 
 Thu, 10 Sep 2026 08:36:44 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1789018604; bh=M5qQ7OE6ggwZXvrAj0XEJIH3psPod5ma6e8OahWsJvE=;
 h=Cc:To:Message-Id:Date:Subject:From;
 b=KcLIE2sP9+CQVUkM2mVjbSbQ0ZmmSYXz3+koI32rHmu3OtnlDlmIYapMpidNyzAhi
 bJVGC7xflnO/MHqz4jo8RfJ2BjO2UI10tch9gPLmeWqDsPJ5g1BjRXi9oYW9DlF6OW
 MtrzV2WnTUvI2Y5chbQ5y6EyaVivE2TkxJznZ10s=
Authentication-Results: mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
Subject: [PATCH v3 0/2] riscv: timer: Fix M-mode early timer support
Date: Thu, 10 Sep 2026 08:36:43 +0300
Message-Id: <20260910-riscv_fix_early_timer_mmode-v3-0-52b569fa1d6d@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NQQ6CMBCF4auQrq2ZFijBlfcwpillKk0oaIuNh
 HB3CyvdGJf/y+SbhQT0FgM5ZQvxGG2w45AiP2REd2q4IbVtasKBC6ihoN4GHaWxL4nK97OcrEM
 vnRtbpKwqTI5YIANBknD3mA53/XJN3dkwjX7en0W2rf+5kVFGOQOsRN2A0vzs1OOJBvujQ7LJk
 X9q9W+NU6ClyBtjuCpBl9/auq5v7KPp8BYBAAA=
X-Change-ID: 20260904-riscv_fix_early_timer_mmode-174f3ee4e106
To: u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789018604; l=1614;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=r0Rm4T02sjD5xVqhNCCxCHOgVct7bJwRWm7HjpNypPg=;
 b=vuoUDihIAmyPOigFFPXK13+P7bF5fHI4bbMtgytWLLwSBst3ltuiaazXlbsAdv9yDYAK+XaG/
 kpzUMyTgSJmDn0sHE8dATOZHjSk3a5Iu2GVdiH8wXstbshSXCe1koA3
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

 drivers/timer/Kconfig       | 13 +++++++++++--
 drivers/timer/riscv_timer.c | 16 +++++++++++-----
 2 files changed, 22 insertions(+), 7 deletions(-)
---
base-commit: cc557af4553382f6f50e3ed62b9577054e7bc54f
change-id: 20260904-riscv_fix_early_timer_mmode-174f3ee4e106

Best regards,
-- 
Nikita Shubin

