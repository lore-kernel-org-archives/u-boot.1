Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B770C79FB5
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 06:31:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2EDA680D7A;
	Wed,  9 Sep 2026 06:31:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ol8J318mEyCq; Wed,  9 Sep 2026 06:31:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 01C6B80D6F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788935474;
	b=WjfgKxowIta8RLosdJ6p97FO5/Cjj63y2n/5KILabs3rbviBpjcRftqGKFRUHlMyYgSq
	 Di2ohg8I54xMwLDX12giqzsVr9EM1iLM26YgBs8o0d64ku7NEjB9T/yLNybXHH+EW2CAP
	 /FvxbPbd+nEPMuPOaesBMoJ41MBYg1tI0Ky9z3TixpMcywRIdgmLYoHx/jGZiRlcOr9Ob
	 1sdqWVvbJRRzz3400NeKrN9Gu0eBz60pK7nSWPGDYvpF1huBDMy6LkpuOsR1YhCXbN9D7
	 mg4g8xM43wHxRoIdHCGpejLk75VkuZVhQbWAQCyDmvzdu+EIosnHuDvkka2/dq1bXgQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788935474;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:X-Yandex-Fwd:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Eg5g/cLb/21ePlgbewSaa+XvN7A7u2H3UpISC8/50hM=;
	b=DPWXaL+d2M+DYimX2r0J/CmSETnJZj4OmPvqxyhFcS68/f6QGBatZajW9otvOpcfOsdc
	 5qahbRnyh+MiMBPOFHcgDyCnXoM1ntPUok6d03na5g7MwNGRc9Gqxthh4RLpEh+pHgUn6
	 QhuPdBQRvdEmFzCR9GD35GSc6EFYi9zhre7GCokoVjWf0IMR7EIgygRRdt5e7TgBvJkFq
	 ZMKsyPAjD7ifV9AqcPiNUKpTzgCJPEMeY4BievN4iIbW/Gc7Wb7qa0YHex2Ds0JNE6Xc7
	 DuGQFyshnHaORtt5QitFxRkdvUnaKYJnb4wQNxfR03n7EYmJcpvUYakhvGqKEOJeH6g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788935474;
	bh=Eg5g/cLb/21ePlgbewSaa+XvN7A7u2H3UpISC8/50hM=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=eKZQHA4a9C62m7UjydJB2kg1/RD7IBTWJXOJ0vJcxVvpQHq4/QIT30NpFfkHwbBo7
	 0GcO4tyOrjHnWCh+2cfMLIVsXrAFY/pULMWGLrFQ9YjY6nKevlt14r6n6Dxvxc5LO6
	 FVWlR3pcir52EDdjPv/8BzP9q+i1gykp8KF+5te8iEGHWlNYk+BOLFS0AlAt0HOuJb
	 SDqjZoIXGtjHI9F+zrjds1drjLTleW6siUg4Pxs8eEQRHiscx0vSJPsy+zBaKaxUfK
	 pIbX/lGV9cWamkdBAmZb2SeiO8Yn0KeBjUpDrjXRTF9T1fD43trOJ3uOex2Yma77Dx
	 jixqFSHUTZbKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 01C6B80D6F;
	Wed,  9 Sep 2026 06:31:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 863F0701
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 06:31:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 78187406CF
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 06:31:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NQS-ysHLgiRi for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 06:31:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6B180406D4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=178.154.239.212
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788935468;
 b=M3j6lrzEZmCmBXG+uDAoKFDbfmdOZdSFqVw161qpGrd4VVCmD3JVyaC8oWQDUOEDqO/Z
 6MQvEFQLyimuMowK3vPHFZfVHPTBKnBTye85QRLlDLsw80c682Ic0JMDJIGzNP7aIHsHt
 4BQ2KZPNMFW5zbT8UrYYfWzoJdxsVwgIC6BhkIX2MuQjN6BinQpCDXw8JDWEdIHGXwTIi
 nb5gWEOfoSr2uoMAV95pmfL7thkyH0/wjAC8JSpwrNTUPZZYWIjr7nM5G7e+DXrFO0MtP
 T7+DxWdgfq36sK0pw7t35iTuzHoRceRtZrTqqZieLjISZaB3tgsPR1hWqZXJ/ZubhQw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788935468;
 h=Received-SPF:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:
 Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=Eg5g/cLb/21ePlgbewSaa+XvN7A7u2H3UpISC8/50hM=;
 b=SB70fsGoOKcOrYRR3XIf996EU4T+wHpLp5l6NUgt+MGHgQwHw17X31XE6Q70WomeYP8X
 dgjzSyNrLzlpUcSqh/FvGcVu+H/3HdxoFhr/4xOgULzUhUpDYzozi5hBJuMft/RX7KOk5
 //fhaNJgAJ1hnASDWmlq19Zg1jFBKqfyssnPYwbBdeFNJKBM3wMXMya6V8vgizx7uBHEm
 oqVHHMwuUywu6sRZh5xZYcr+QAG46iFxA5C4o9wz8boA/HYV3DugacA5HBatcwxaJZMdd
 GVPX/vTsr9Rj8uY1DWQN/nx7OQWrtiZeMIgUAYzFZYRI+U8FnPHmwAwBVl0XZhcAcAg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=maquefel.me; 
 dkim=pass header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=LlrkRgZC; 
 arc=none smtp.remote-ip=178.154.239.212
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.154.239.212;
 helo=forward101d.mail.yandex.net; envelope-from=nikita.shubin@maquefel.me;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me
 header.a=rsa-sha256 header.s=mail header.b=LlrkRgZC
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net
 [178.154.239.212])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6B180406D4
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 06:31:07 +0000 (UTC)
Received: from mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:49a1:0:640:3edd:0])
 by forward101d.mail.yandex.net (postfix) with ESMTPS id 551C6C00BC;
 Wed, 09 Sep 2026 09:30:58 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net (smtp)
 with ESMTPSA id vUHHbfWlcSw0-loU382kB; 
 Wed, 09 Sep 2026 09:30:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1788935457; bh=Eg5g/cLb/21ePlgbewSaa+XvN7A7u2H3UpISC8/50hM=;
 h=Cc:To:Message-Id:Date:Subject:From;
 b=LlrkRgZCryqUApTARCaKeTEHJFlLZ9YXLrKMhEbvpMpIxBrG3lpLt0Z12XA0NItVn
 BvlSJ8SdUvkoESsGOgzmyuYf+x/wCL2/HnzaXXWVX9va3kE9najczI0NxArHdH46gA
 cpUV5oM6j7CiNSsBP7c1o25HoZ9APHAcLIV20n8k=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
Subject: [PATCH v2 0/2] riscv: timer: Fix M-mode early timer support
Date: Wed, 09 Sep 2026 09:30:58 +0300
Message-Id: <20260909-riscv_fix_early_timer_mmode-v2-0-563bff2a50c5@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQqDMBQFryJZNyVJRbGr3qNISPVZPxi1PzZUx
 Ls39QRdzvCYt4kAJgRxzTbBiBRoGhOYUyaa3o1PSGoTC6NMoSqVS6bQRNvRx8LxsNqFPNh6P7W
 Qusy7C5BDq0KkwsxIw6N+rxP3FJaJ1+Ms6p/9rxu11NJohbKoHso15ubd640Ow9lD1Pu+fwEns
 CheyAAAAA==
X-Change-ID: 20260904-riscv_fix_early_timer_mmode-174f3ee4e106
To: u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788935459; l=1607;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=qvPB6NxGb6QSOjG3VO9A4yHTTkBjo7gm4SEVlHNLJvA=;
 b=ML9+ZAkdvzwu9Flim1uxmefa90ziqsaONS1HPOrdGl0QGmTd2hyrujDBBRksHQhzyOFXLNlic
 hZObYW+WBT6Dq43rDlHuB1DdJJyhP1fILrvXfK1Q/OB4Vm9z1QKdEfU
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

Patch 1 adds proper M‑mode support: timer_early_get_rate() is now defined
for M‑mode using RISCV_MMODE_TIMER_FREQ, and timer_early_get_count() is
no longer guarded by RISCV_SMODE, making it available whenever
CONFIG_TIMER_EARLY is enabled. This is necessary because functions like
net_random_ethaddr() rely on get_ticks() which uses timer_early_get_count().

Patch 2 marks timer_early_get_rate() and timer_early_get_count() as __weak
to prevent link conflicts with other drivers (e.g., ACLINT MTIMER) that may
also provide their own implementation.

Changes in v2:
- Updated Kconfig help text and driver comments to clarify M-mode support
- Simplified code a bit
- Added patch to make RISCV_TIMER definitions weak

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
Changes in v2:
- Updated Kconfig help text and driver comments to clarify M-mode support
- Simplified code a bit
- Add patch to make timer_early_get_count() weak (optional)

- Link to v1: https://lore.kernel.org/r/20260904-riscv_fix_early_timer_mmode-v1-1-210e769b0ac2@maquefel.me

---
Nikita Shubin (2):
      riscv: timer: Enable early timer for M‑mode
      riscv: timer: Make RISCV_TIMER definitions weak

 drivers/timer/Kconfig       | 13 +++++++++++--
 drivers/timer/riscv_timer.c | 16 +++++++++++-----
 2 files changed, 22 insertions(+), 7 deletions(-)
---
base-commit: cc557af4553382f6f50e3ed62b9577054e7bc54f
change-id: 20260904-riscv_fix_early_timer_mmode-174f3ee4e106

Best regards,
-- 
Nikita Shubin

