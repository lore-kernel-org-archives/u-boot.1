Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D19C79F80
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 06:13:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7AED980DB4;
	Fri,  4 Sep 2026 06:13:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hPD3O_6t9J9J; Fri,  4 Sep 2026 06:13:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4D0A480AAE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788502390;
	b=NxmnZKYHZR/yV/d3xpg1FR4AXvaUJZjHsq/sVHgpEnI++qVX3DDFAUtFz/hUOgX5HvhD
	 hm7Gcqv+exH5b9MTtWB8A0N694mrrrDeOyMpSIVa1ZaIqdm+pN9PAGQ45IJVJjkgYbYhB
	 ywdmybA2rVyJ1v2CxNzhi4pDAiuq/V9cZCX0NXSsSVCwZihFxn22GLqnurzYeG7d2WLla
	 Xq3bQ9iuCBoE4/Re/b0C/ty+SArL3DJI76dK01QnUqy4JO/tzvuDtzKCw9k6bhlrAXHR6
	 Ds2nw88a6wGwJnaiLeSpIvFFviWhtw0biTUV18wD4wMpyN3hS2JPM6t5pKsDM0mrwMg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788502390;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:X-Yandex-Fwd:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=txGy795D7pXLntMm/XTb+QUHz25hW22/V8P4amU5Ce8=;
	b=hhkthR+S+CguZIJctTx3NoWVGzJyE2SrHFqeinR4ochfl/+srJbuuoFaJic8xvjvtLio
	 5+p1qxdFujAO+uJVxs5SpZ9TPTkH5diloCTKwJdjSwvynw0VwSwBlmD3pmtLzJ7uELeoa
	 Yr941BeA3MBMdTrGWJt+VG0+uYOfIYV+LeTGbE/Fd/lr8owzlBne4AxQ+jgntDriZWMdJ
	 UVVMwOwZ/nXIIi2BXVQZzgc/n7cjN+lcwax50KcFlWwlKBo6atvDjKpou11+I2OQO8HKp
	 rK6iChViIp1c6A0YcaKuKSydxhLKklTClCUAPlTKVXTQJGB/qtx6TBMAJ4ZKkoaxwOQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=none header.from=maquefel.me;
	dkim=pass header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256 header.s=mail header.b="DK/W59Ym";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788502390;
	bh=txGy795D7pXLntMm/XTb+QUHz25hW22/V8P4amU5Ce8=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ujIAaztgKW6a/ohhfWQjrvRiiuxcGLBqZhcgnI7wIyJGdcGNCvnxy0X1H4oAJrAaV
	 eFaX5gSa1p3qyVT0i2aYmy+AG+iCSdfV6ujdtwOeQUkAtz5C1RF9rI+Y4mZFEfdd2/
	 WAAKiEfgLk/g60vW6xS065t4HHBIPOXK1Qp0NAi5qoMgYb3wcCp1f23jJiJVOaOGx+
	 utNHlxsfNQNBOekrWRTSkOWcpPqeksWphXKewUIRH23wDjPjFx3al42tfzhLuc27M7
	 SwBe+Y2UfnLUh3YBTP3ABuS3MZUzYsC5lc0yq4p/17E2EPQsicWV2vsiPYdKKgShrh
	 LBdCn+aW5Bw/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D0A480AAE;
	Fri,  4 Sep 2026 06:13:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2729B3AF
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 06:13:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 186A580AAE
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 06:13:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IzLjj-NlEvwa for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 06:13:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 91F5D80996
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=178.154.239.211
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788502388;
 b=gDM/PG1GpqSsnECObUJOstb1gl+zkHWIcMK25hM4T8SWut/2NJyx8jI/ZUkLD/PebVsU
 QwuH+u6MczngH5OMyu5Ey5YhUxPTiZoV0NlaOkyxsW1M658tEb5HnSV63KdHEbA+nlDu9
 LayMjUAVFW36rY5lvJMnWAKCVB0x5OOa6lDU7XRBP0l3Rj84kZyoXXN8bL2vs1xx36Agl
 uplyQ27YOSrq9PWWBBqaySzsX0m4Bqh1bIzgRU49qm+jAXQ8Mj1i1akWrKA++1/i7gwDZ
 6qYUsh77ebYdurYh4WSLSbtLhzm0hmz+rhy52ZRn4/7KnUsw+IwwYQnVDqpZELN3gmA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788502388;
 h=Received-SPF:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=txGy795D7pXLntMm/XTb+QUHz25hW22/V8P4amU5Ce8=;
 b=UvGTd40nNoWv3y7IVSwUy3onCZKwgWS89z9W6akMwE601RAaCnXKC8mdMBouv7WRz1eg
 g8xJd/o1H6WE6jehwdMs9TBOIUgnw7/W+IBjF+9g7MLNBpnifybkADhpVDEPhgspqrHQe
 K0+UDcHeaFTGdPFN1j4K6s3Y8WJuVlozER322tvoysr5qJJ/NbcSvxwVG7ZnQahx4RZOF
 nmkkfNkUfYQhRFldMVm6ULvHwHjFpb3ir4Ewt9eXHzAinVvq7Cebkzonwk3dTx4k1qkrh
 SFtVvE6iETa4EmZOXBjl2IwdSP2PnyOsn/EZKoYm1+uBJaWXjpX/8GmQicCPdAVb0Aw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=maquefel.me; 
 dkim=pass header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b="DK/W59Ym"; 
 arc=none smtp.remote-ip=178.154.239.211
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.154.239.211;
 helo=forward100d.mail.yandex.net; envelope-from=nikita.shubin@maquefel.me;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=DK/W59Ym
Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net
 [178.154.239.211])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 91F5D80996
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 06:13:07 +0000 (UTC)
Received: from mail-nwsmtp-smtp-production-main-92.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-92.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:f25:0:640:1f20:0])
 by forward100d.mail.yandex.net (postfix) with ESMTPS id 44A72C00AF;
 Fri, 04 Sep 2026 09:12:58 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-92.iva.yp-c.yandex.net (smtp)
 with ESMTPSA id vCCQqxGe8qM0-PBDCHtcb; 
 Fri, 04 Sep 2026 09:12:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1788502377; bh=txGy795D7pXLntMm/XTb+QUHz25hW22/V8P4amU5Ce8=;
 h=Cc:Message-Id:To:From:Date:Subject;
 b=DK/W59YmyTTc0A9MNDrIx5I5Sth9NXORgVSEjx4WqpfZ9rx444evaPSS0IHPbA5G+
 Ep/4zu5arROdIhJmoaCsllDJDAhZVxkYsix2YRg3YEEI/43BXoOL4k1rsK79UicLza
 xiHjGWaj4lLRhc1B/4t1kS3EMXox655kIIpTOfvc=
Authentication-Results: mail-nwsmtp-smtp-production-main-92.iva.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
Date: Fri, 04 Sep 2026 09:12:55 +0300
Subject: [PATCH] riscv: timer: Fix M-Mode timer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-riscv_fix_early_timer_mmode-v1-1-210e769b0ac2@maquefel.me>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3M4QpAMBSG4VvR+W21sYhbkZb4cMrQmURy75afT
 729DwUII1CdPCQ4OfC2Rpg0oX7u1gmKh2jKdFboSlslHPrTjXw5dLLc7mAPcd5vA5Qp7ZgDFkY
 XFA+7IIb/vWnf9wP07cX2bQAAAA==
X-Change-ID: 20260904-riscv_fix_early_timer_mmode-174f3ee4e106
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788502378; l=1653;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=RR+EO79zynDvHuUOgMHrmQzYqTB0CFe9aW+3uQHyYek=;
 b=p2VMwQjs3pAEGhIEqHR8vikGKunocONZo1/UnYTxuVi9sdANFD74kAhHDe8sTYOJL8piRn/2D
 uTAajc/LJnzB30nvmft3EOasU7XRcJq1imUDjQR1hqrsb7QVXXAGqdb
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

RISC-V timer is missing timer_early_get_rate() for M-Mode.

Also timer_early_get_count() is guarded by RISCV_SMODE for no
clear reason.

Make timer_early_get_rate() use RISCV_MMODE_TIMER_FREQ in M-Mode and
move timer_early_get_count() out of define.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 drivers/timer/riscv_timer.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/timer/riscv_timer.c b/drivers/timer/riscv_timer.c
index 1f4980ceb38..65f174fb879 100644
--- a/drivers/timer/riscv_timer.c
+++ b/drivers/timer/riscv_timer.c
@@ -33,14 +33,22 @@ static u64 notrace riscv_timer_get_count(struct udevice *dev)
 	return ((u64)hi << 32) | lo;
 }
 
-#if CONFIG_IS_ENABLED(RISCV_SMODE) && IS_ENABLED(CONFIG_TIMER_EARLY)
 /**
  * timer_early_get_rate() - Get the timer rate before driver model
  */
+#if IS_ENABLED(CONFIG_TIMER_EARLY)
+#if CONFIG_IS_ENABLED(RISCV_SMODE)
 unsigned long notrace timer_early_get_rate(void)
 {
 	return RISCV_SMODE_TIMER_FREQ;
 }
+#elif CONFIG_IS_ENABLED(RISCV_MMODE)
+unsigned long notrace timer_early_get_rate(void)
+{
+	return RISCV_MMODE_TIMER_FREQ;
+}
+#endif
+#endif
 
 /**
  * timer_early_get_count() - Get the timer count before driver model
@@ -50,7 +58,6 @@ u64 notrace timer_early_get_count(void)
 {
 	return riscv_timer_get_count(NULL);
 }
-#endif
 
 #if CONFIG_IS_ENABLED(RISCV_SMODE) && CONFIG_IS_ENABLED(BOOTSTAGE)
 ulong timer_get_boot_us(void)

---
base-commit: cc557af4553382f6f50e3ed62b9577054e7bc54f
change-id: 20260904-riscv_fix_early_timer_mmode-174f3ee4e106

Best regards,
-- 
Nikita Shubin

