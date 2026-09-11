Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFCF3C79FA1
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 07:14:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E590F60811;
	Fri, 11 Sep 2026 07:14:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IlFrUN9zzWlm; Fri, 11 Sep 2026 07:14:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BD84060B18
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789110860;
	b=CmJF6SMRxRSxFCK/spcrrBVD0lbuTwe+czeaGA9wmeJfirlnJZrjqN8mFqQ5ESH0iIeP
	 JLZtGH6a316ZQeJh6PHe2ikaXgoNRwmgtthLn30HC0mWWkv+NUF5QqPiMICXc98u/yXKI
	 5nFdrWI7kWpuDop3BBJnwmVStub2B7B5nKvRdSmujsrKrfRr5lFfXxGUbRz2Bx0X1n6N9
	 dBj1c7XMcG3LYcp2RittQyor8FWrImTRXq+WQMXrkWcrSFK5xkp5tFXRCrCr4Y5cPZuvR
	 KTBcCQxqkzyyt150guxcxcvkRORWVjPEZz7WpXYfN0yA4wbBIC6z0ksQ0wu+NTwMDnw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789110860;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:X-Yandex-Fwd:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZVL9/esCsirmvPFASuo/zxWvaE0wJC/TYRTK19kwedQ=;
	b=UfayZjXW6ZKtvp9rHY8GzRDSLQbu/hpGpXMTJYAL3RavyC83quEtTNAuhilR3krPNevD
	 lCfxeVnxUDom+rMGJbFllMW7CsfqC0vKCXUqF/RD6iUTlPrN6dAPylVer/OMh7o7VdDvR
	 0e9BMbG/GR8psiYwWl+VFD7lCWgnlGSexwqcPhwUr+baoK2kqGVxwa/XrFN7qYfmfRpxP
	 QCitEgsmHOEd/A7qrzLs5eXwcKfLLcYrpKoPQ4ieo6mqqeJ5G55ySrSj1nMeBqU0h3ULf
	 lvjQ3sFN7jB9ohTokvWWkvP7hQv5hkaRFWmfrbPJRZmt2B9QOYE+k5iJFfzNYXYqhqQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789110860;
	bh=ZVL9/esCsirmvPFASuo/zxWvaE0wJC/TYRTK19kwedQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XFTHBfS803pN/b74UNJdbeFYtt9KGhb9muhU3C/pFRczrX2yac2N4gvKPXrYniupb
	 dldaQXIhg3QKVJ/NK3ki1+r1gwgvbFpmN6bUE/8OKvOM+yzcT1/SmIisDtNGbwV1Uf
	 ZVPZdhrPE6f44RVBn5uGjPr8rLs3xUZB/ZWtkETB7cB5HO0v8MiuPJY9UNp9FR0SSm
	 nOysW56cpoIKxHRasjas9/uxZbNpVVzmWRb4pt+KIpGapJm2g/mVJ6BQag+aZGvxCs
	 yNHlIVYUwTtpqdtc0qch4++u+Y+PIt6UXOpixXluqtWGXugfJjGD+3MA3w8S+u8u3m
	 3X0FethlViCgg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD84060B18;
	Fri, 11 Sep 2026 07:14:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E84714D
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 07:14:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 202A640B2D
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 07:14:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XmNIR5jOQUAi for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 07:14:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6A76440B25
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2a02:6b8:c02:900:1:45:d181:d102"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789110858;
 b=dnbFaD3jxrJNw7rArPblb/Jd+VuITnVPsogLhXMe1nSi3fSXWUOQYQtaWpuVg41SUUQf
 sYcYMcMrYVheub9xRkhPUXH4WlBAG233CRgnGvb4x9VqkfI7OGHFCYnz0okUoP77qh2fz
 B6DapK68SJzXq6Mm30qb2QZqiyfUN+RVkXNhdmEn6I8E5fWq0bLqXCtklrIJvGqmXmsUq
 foLB817gg5FNU2I/hMu+PWQDeyrdy4V9io+zIM15ao1/2rDN2cnkQ/06bxI08uyNHfoHt
 xKpkKoH5HbSxD7TSwC/l5T8V246GHRSd5/jvbARmmRTGRJ7KDO+xpMMGijkGhO7cPIw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789110858;
 h=Received-SPF:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=ZVL9/esCsirmvPFASuo/zxWvaE0wJC/TYRTK19kwedQ=;
 b=Xx0BDjU9ApTlmfXyWgvjMKVCNTWt5ves+pzXeo1FlBx0sT3l4EuG2tABFKMkY7y82zgl
 tGXHAi/FI+mu0LzRTsS319sh41n231l4nyiw4KbLD7JslBlgsOYdfsVlKrAQ9Anxih7Sr
 J26rzFp+7XsvFRABP24nJDqQmFKCX+vh5hFswW945GkTBHbYXjkfOzbqaApi5TdGbPtY9
 gL8kETSPx3JbKFg51wIfQBGiE0KLt3Ns7hp1+IoyVUfJocyPaKQgM+8bMBMLizGQFW4yT
 ggXZpLVm4oDt2IK3Upkph6RWfhT2belc+UMkozg5R/BR4PyEHSWIf1vfCEuaLjO8l8A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=maquefel.me; 
 dkim=pass header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=eKSZ2Nzv; 
 arc=none smtp.remote-ip="2a02:6b8:c02:900:1:45:d181:d102"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a02:6b8:c02:900:1:45:d181:d102; helo=forward102b.mail.yandex.net;
 envelope-from=nikita.shubin@maquefel.me; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=eKSZ2Nzv
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net
 [IPv6:2a02:6b8:c02:900:1:45:d181:d102])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6A76440B25
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 07:14:15 +0000 (UTC)
Received: from mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c11:4021:0:640:30fc:0])
 by forward102b.mail.yandex.net (postfix) with ESMTPS id 78D58C07BC;
 Fri, 11 Sep 2026 10:14:09 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (smtp)
 with ESMTPSA id 6EKFZlKoaKo0-FCPDYQZK; 
 Fri, 11 Sep 2026 10:14:09 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1789110849; bh=ZVL9/esCsirmvPFASuo/zxWvaE0wJC/TYRTK19kwedQ=;
 h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
 b=eKSZ2Nzve8DfhR2+DDIM7gO1c8fhsgEeNAyyUjeHOjf8bQ1IWhUUMQftIwTEs+qaE
 c7UpTLm1H1T0wIdW9I7PzN1KSv4+GJvLPIvsTuLRiOXxZPBrHNEC+K2pB+B3jRWemb
 40hI3XKy7ZeNgc3aVeAmXFlRXAM5eZsZe1Y2zwHc=
Authentication-Results: mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
Date: Fri, 11 Sep 2026 10:14:05 +0300
Subject: [PATCH v4 1/2] riscv: timer: Make RISCV_TIMER definitions weak
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-riscv_fix_early_timer_mmode-v4-1-87a7b5abf958@maquefel.me>
References: <20260911-riscv_fix_early_timer_mmode-v4-0-87a7b5abf958@maquefel.me>
In-Reply-To: <20260911-riscv_fix_early_timer_mmode-v4-0-87a7b5abf958@maquefel.me>
To: u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789110848; l=1142;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=amiFzjuu0PYEGbtuow08KDapnd8p3SrYwc48C19f3wo=;
 b=ecu7eI+BOhEDR+sdyeHv0K4NIVjD22eildG3PfpZkUJ5GYgk40YxP2DYAKYIEt2XOc1xHQ/hK
 BvGS1dJvwtSCbDeZfKr3Xjmgcy7BjMDtlJ7o78qNEDvqJjGbsCB6461
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

Mark timer_early_get_rate() and timer_early_get_count()
as __weak to avoid link conflict with other drivers
(e.g., ACLINT MTIMER) that also provide this function
when both are enabled.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 drivers/timer/riscv_timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/timer/riscv_timer.c b/drivers/timer/riscv_timer.c
index 1f4980ceb38..eb7c78c3bdd 100644
--- a/drivers/timer/riscv_timer.c
+++ b/drivers/timer/riscv_timer.c
@@ -37,7 +37,7 @@ static u64 notrace riscv_timer_get_count(struct udevice *dev)
 /**
  * timer_early_get_rate() - Get the timer rate before driver model
  */
-unsigned long notrace timer_early_get_rate(void)
+unsigned long notrace __weak timer_early_get_rate(void)
 {
 	return RISCV_SMODE_TIMER_FREQ;
 }
@@ -46,7 +46,7 @@ unsigned long notrace timer_early_get_rate(void)
  * timer_early_get_count() - Get the timer count before driver model
  *
  */
-u64 notrace timer_early_get_count(void)
+u64 notrace __weak timer_early_get_count(void)
 {
 	return riscv_timer_get_count(NULL);
 }

-- 
2.54.0

