Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F23C88E4D
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 13:35:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 323186068D;
	Fri, 11 Sep 2026 13:35:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 01Zu1GrtLtRZ; Fri, 11 Sep 2026 13:35:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0495460664
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789133741;
	b=Hj8E1qNok221LMXqIGiXC7318tMww4dmPEbD8dnaFlnpBmWIMYMriYm6dFoNPRI0KkHE
	 ecaKmc1kXQnEn4HiJI2Lk2IatwqkuxPKKRKHElHSSYL5SKeKiViiH2siGbNqPB5WWK0Wm
	 MVMeUCaLbI3Y23YxMJbvZCsJV72Wt7OfO9wQH06b9sKhF+UnV3Y3hCcSsXnipgkiuMvJf
	 PpYQv5iBagljXlM9tsLLu4DSBU1EgJbm2U38rm0AOVpLtBI3mKG5zT3MylmtgR49+jlBm
	 HW52gO/vdYxY97+MrZg9jwbqBYtM1Uxmbj6q7QMnJmB5GNfG8ltsFiKbu8DIYUTJXYw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789133741;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:X-Yandex-Fwd:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ZVL9/esCsirmvPFASuo/zxWvaE0wJC/TYRTK19kwedQ=;
	b=ctZz79kiXTBFOXotMn79LasOQfn/VUITlrfqgTWoHB1LxOJz5FMXIaY3YZBa65LQtNPF
	 BcnOpbxfB16t2dOoXBSzK1/Lj7qkMkfMp2rk/56lvowb/HUD42iQCyekRxCIxcAAGkkHo
	 D0MOLvJTfSWfVRKMaJAoFdk+FhtcxQDf3D5SZP5LZC8As58DFgvq+kq48P/4O0nbxtZiu
	 Ve2lUnfE/2RgqNmGNvZXEKW+wE30AEf4BlR12+9DRT6YprQws9z9rlpeyWMGQ4CJF2Ea4
	 m4kfyynP9KS2TAYIyiMBf089fZg+IJxvRC3JE3K2t/H13aDJ6nlEzlnY3D7u+5wNTCg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789133741;
	bh=ZVL9/esCsirmvPFASuo/zxWvaE0wJC/TYRTK19kwedQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=km3dgcWCDzdGd7FygwKOctIKdvk1mhH+p4aLdKOJ5kXjdGeca8omDPiP4eLydaU+h
	 TQ0pDqS6VeCZcTg9j4K0GdEJ/VPnaR7zRXDw/AvBt0fFbj4MODMv2S0C+JtC++v1Up
	 X0lkG8Z6vR0T5VAH0Px1YmwYqcAi06lIHMFkIXdpzSXbgIhFLaN5YvI0lX7CFRsont
	 j048fO5i+i2woGCtqEwVGhcqYLJSmABT7uLzvMoA+Xmcd0cjtsgkash5bsfhnPEFSa
	 fNLWuSGiMZqNpXfYaiYJPLcRSZB31MJDccgi0CD7+NZNk+wGBjYbcDDRV4Y5E+EKJ1
	 Z3y5oVLV2UQxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0495460664;
	Fri, 11 Sep 2026 13:35:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E5B1786
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:35:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F09F180F78
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:35:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5-4-BoyXmVdS for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 13:35:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6497A80F7A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=178.154.239.83
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789133738;
 b=qRZ2ywZEaoO0eZMXfB+kpnJkXq8LkU3SrlL+LmpMitAnOSKWPc9zssgynK9meTsUqiw7
 o2r5rI7f439MG/ZSND7lrR/fA8PYTWtQHo12gDIhB//yH5CsSJ1DbNx5MgHQqgFFs9GH9
 rm+iSGxOt8cGyYPlRCWLVV9jOOi6yjnZ23tPNZVznOvWZDOxiJb1HQb+tsws+YCEudF0u
 VicbP7k9vbF+23LbJIKv+2kZuRccRl3QTjvBBkJOG0JPgghXtr+uSwJlLXncBFmQB2oYz
 brXznmMpBNdI8t4Kys5nMMuKBka8K5tknw+9n3dSlUAlqT7EnNUcv2SjnKhY4RNdz5g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789133738;
 h=Received-SPF:Received:Received:Received:X-Yandex-Fwd:DKIM-Signature:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=ZVL9/esCsirmvPFASuo/zxWvaE0wJC/TYRTK19kwedQ=;
 b=AuwkL0mTQ0chJTAbgB/oqus9o8S+YmnDUYZIvlXfUrBYqGheb753UF08o64oaiYyGsOq
 1grxJYhljIp+FgDfx4WRK5xYldwcJ2Ezcgezj8dzaEOTegTOoW+kE3xaoEJfuD/X1H7l+
 PsL9qUAB7lO8BOssuUGetyHBGmEOSYo6AY2MybbqNBjJ26I7yF3GZaq+thyD+5ckRXbUV
 ZV3UDBJFo0paOVgHV1ZvkJq0PS2ewlVIkgjnuymgocDoddDh6A1RXeN0Um525FQUy5GRT
 bq8uRoYmLOaoOJF0jxoweh6U64NpFcZJPY3mrwI7ngg4SISKqsc0e/9CP8voe+ig8aQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=maquefel.me; 
 dkim=pass header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=RKQx84hY; 
 arc=none smtp.remote-ip=178.154.239.83
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.154.239.83;
 helo=forward100a.mail.yandex.net; envelope-from=nikita.shubin@maquefel.me;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=RKQx84hY
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net
 [178.154.239.83])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6497A80F7A
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:35:36 +0000 (UTC)
Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net
 [IPv6:2a02:6b8:c41:1300:1:45:d181:d100])
 by forward100a.mail.yandex.net (postfix) with ESMTPS id 304A1C03C8;
 Fri, 11 Sep 2026 16:35:30 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:49a1:0:640:3edd:0])
 by forward100d.mail.yandex.net (postfix) with ESMTPS id 1A381C0059;
 Fri, 11 Sep 2026 16:35:30 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net (smtp)
 with ESMTPSA id RZQKjqwlda60-L88E4hkM; 
 Fri, 11 Sep 2026 16:35:29 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1789133729; bh=ZVL9/esCsirmvPFASuo/zxWvaE0wJC/TYRTK19kwedQ=;
 h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
 b=RKQx84hYwMTAkUFG6snS75olFVIVe9hUotqHyXH/8R8tJ3H/EOYMnkTd2kYki0hQD
 VCLDg7Tr+MqKY7WSyM+deiNcRHmJ7clibNu8Mwhw1rNGsyhkL+4qAuEmB1EzbZ5V6A
 Ed+5PAVSGIpdw3rFhBwV1n2clrCZejaLs9a4wbcs=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
Date: Fri, 11 Sep 2026 16:35:23 +0300
Subject: [PATCH v5 1/2] riscv: timer: Make RISCV_TIMER definitions weak
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-riscv_fix_early_timer_mmode-v5-1-98e7aaf91396@maquefel.me>
References: <20260911-riscv_fix_early_timer_mmode-v5-0-98e7aaf91396@maquefel.me>
In-Reply-To: <20260911-riscv_fix_early_timer_mmode-v5-0-98e7aaf91396@maquefel.me>
To: u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789133729; l=1142;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=amiFzjuu0PYEGbtuow08KDapnd8p3SrYwc48C19f3wo=;
 b=QxhyghovVoz3CxqZarcl7mUrjCMfripMg4w83c5amZqC6wO/wqyGAcbG2mW6+U+jelWi/MlGY
 JgC+Brlb/GBB+kvMGkwpNN/p82HDJv9aNG1Kx5Bjwf4CAcWNeIA+Rm3
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

