Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB24C79FAA
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 06:31:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 682D260770;
	Wed,  9 Sep 2026 06:31:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y63-OYSF_zVS; Wed,  9 Sep 2026 06:31:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6ACAD606CA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788935470;
	b=jWKewD/CFUtUdI4AECqFltoz8Uc06YXeMekZJcTqFRtEQY7ssOBWCIceOfUNF0EnzI+1
	 KhTnsAgE2S9euTGIF4X2EP1CysWW/buXeubiSX1g2BasjSiouYsr/pqb5/p/Q1HMWqzh+
	 EovV80uoFoqvQSoQV2D62XDCxcrO6jUDUWaryqGExuCT7JmY1X3rITxpZqlMrwSgNah5d
	 wgvZefQCfox2yDNsVScAbE1n6RlfwanbiUOtfDQDfSwTiHpRld9fkamEJ+HDg6og8dP+D
	 RD65c8tK6w63/SBjcPUil7RFR84TM3JrG0IWcyS3ep6kuCWYSrS9NpvWwfJTVstnaew==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788935470;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:X-Yandex-Fwd:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=z1b52XsiOkL+ntRQ7FVIh3DVc6Nq0JqrokqSSevMWnM=;
	b=ncJxa0rTKRUs52UlNwgUni9bfDU5yaRjQMaScmhWCkyrHf7apIn4uIwCmJxT4kgpjj0s
	 zpntjLFfq+l435Nm7I6lQa1sTUTo49N6Gv88/pyuPAw48LDrt7wYjNugpe1NMrOeJ4bRM
	 v2SUxm5CLpAZlmhtHOCWNoN1bEj4ZHXGh5BcZ20xCbepzgOg0G8v2vnWyWAI39Ms1ks8j
	 8QTr2Erf5K3mZkZfvh6dKP8kctmeVz5QSqtGxm95BhNHip96LerbDr8rvQmYHWEWAzPBz
	 SVWh266snIIqDP/TJy7kqu4B8vV1BuD1CDjcPghGSUgbnBrzfePvi+ZBqhXzoa3mSXQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788935470;
	bh=z1b52XsiOkL+ntRQ7FVIh3DVc6Nq0JqrokqSSevMWnM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MEwxCBckk4j8J+sXv/qdTXHdQ2nVo3R3COretv9r1cNZh8XlajVtDIWrdVp9NQNtU
	 YrjBSIKuiKnxh9deVH/3lNfNFfmFDLR74up+62WmFwfIM7X5/KgE9NPgf239GJLzOh
	 kVzzo3Pq6cYN+BDOt41zz0sNlORMg9MpRJynXbjXayyu8h7B1hUB/Hs4ZVG97JiyaU
	 /8OvXh4kjAkYApkTOOxqaW6apMidP/nFH1J/TR/Um9MehRVesEAELTmLuX4c6FhXuh
	 5MbRzXiJ2sMIsvKLtN9Ab4gRNPid1SLy8oylml6S4pHqArV8asb3VyPTZaD7VqeqYE
	 UCz8FsKnklnmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6ACAD606CA;
	Wed,  9 Sep 2026 06:31:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8403F4CC
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 06:31:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 75884400C2
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 06:31:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KSUYxlFU0mKx for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 06:31:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 7311C40055
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=178.154.239.214
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788935467;
 b=R9RT0ekMGH0unlqfHQGdvxONoCkzd7BgqCo5GkMkB97BBnB7cW9FIlQeBbYoH9xd/aSf
 Myc8j2TY61C9Gdm6bKnQNvAXv7y62LqX7ONckP+CCjb+xdm1vMvTJY4o+ST1XsZVBAuoJ
 Ubk5kEYQ/wfhPcbkiTbUCOQm8Zv1/qZp0sIsYsiX05XrspKe8sY9ST/2xsYqRvuMYtFad
 3iA49X6SA/JJqjJZA8IPA53AVx2/9SiYBCZpCDvFgVgRARMBLDlArBtxhmnUKyuXvwEKr
 BWqZv4gKqfgXsq41glCj/JRxN2y0DfKiUh17uMREUWLodWOGXGYAtW/ibOpODv+59RA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788935467;
 h=Received-SPF:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=z1b52XsiOkL+ntRQ7FVIh3DVc6Nq0JqrokqSSevMWnM=;
 b=LptF8v9kCo/TZ9xGhlUVkoslcvir3Fd8MmXyNO0QjaD+9Pyol76MoxWpS0zwBIzK6/1B
 5e5AmStep87ehi49OMT3hULg/tz2gCq7RVSL8s4tD/b+TmgTYU0BK3c06Rx5fatIs0dbb
 Mp9pOQ+6GwaSGDUo36oeE4z1xuBvHBDMCEdrwLqli5//rCgm70g54zkjo5RelPMhYecEx
 Bh5bT1Y3PrhAxBgwfcEOb1R9OSOllwQ29VxDS2eSerNJwO5914Rxf6Xkglg6Nl1ayPn0j
 InqHm7/yFaDJSjar5zwdVh5xOFQkecC6kYhVR04xw4WinOvXaazdeh6dCNovfLeCn/w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=maquefel.me; 
 dkim=pass header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=i4R55F9W; 
 arc=none smtp.remote-ip=178.154.239.214
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.154.239.214;
 helo=forward103d.mail.yandex.net; envelope-from=nikita.shubin@maquefel.me;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=i4R55F9W
Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net
 [178.154.239.214])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7311C40055
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 06:31:03 +0000 (UTC)
Received: from mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:49a1:0:640:3edd:0])
 by forward103d.mail.yandex.net (postfix) with ESMTPS id 60396C0095;
 Wed, 09 Sep 2026 09:30:59 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net (smtp)
 with ESMTPSA id vUHHbfWlcSw0-dNQnZFME; 
 Wed, 09 Sep 2026 09:30:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1788935459; bh=z1b52XsiOkL+ntRQ7FVIh3DVc6Nq0JqrokqSSevMWnM=;
 h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
 b=i4R55F9W2VSLsFYQ7cKSHM4R9wXJHaY01trTWA/BD1QyoOyigY3CwpoQxw1h6LzjJ
 KR4smnsqZz7R/uk8il2AXm6CMcpJRDQWF579xHcGyDdpFTTBjdj+Ufv2UY/OhEvpub
 cvP1QAQiszmuMmMBNsfJjZcqfgExAeHx6Oov4LfM=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
Date: Wed, 09 Sep 2026 09:31:00 +0300
Subject: [PATCH v2 2/2] riscv: timer: Make RISCV_TIMER definitions weak
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-riscv_fix_early_timer_mmode-v2-2-563bff2a50c5@maquefel.me>
References: <20260909-riscv_fix_early_timer_mmode-v2-0-563bff2a50c5@maquefel.me>
In-Reply-To: <20260909-riscv_fix_early_timer_mmode-v2-0-563bff2a50c5@maquefel.me>
To: u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788935459; l=1206;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=e8Oh1SzaadRXZPBu96qPPngChE5WboGSlnyG5g41XwM=;
 b=fpYp3496pqk9hD4tluEKqaKEKRnMXhKQa4G/tCpq0CFefWFIF2lvCmpUD2f4cs9CXLyJJBBJ1
 iJhqWTD8go+Bl4v1B4te8Oypy9x2/XSh/x0P6zDFHX27OPODP4e99aj
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
index c2e617317aa..58878445e4c 100644
--- a/drivers/timer/riscv_timer.c
+++ b/drivers/timer/riscv_timer.c
@@ -39,7 +39,7 @@ static u64 notrace riscv_timer_get_count(struct udevice *dev)
  * timer_early_get_rate() - Get the timer rate before driver model
  */
 #if IS_ENABLED(CONFIG_TIMER_EARLY)
-unsigned long notrace timer_early_get_rate(void)
+unsigned long notrace __weak timer_early_get_rate(void)
 {
 #if CONFIG_IS_ENABLED(RISCV_SMODE)
 	return RISCV_SMODE_TIMER_FREQ;
@@ -53,7 +53,7 @@ unsigned long notrace timer_early_get_rate(void)
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

