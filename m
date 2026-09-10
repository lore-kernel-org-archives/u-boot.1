Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE3CC79FB9
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 05:36:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2688340873;
	Thu, 10 Sep 2026 05:36:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kPV-HodZtRLI; Thu, 10 Sep 2026 05:36:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6C1A340850
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789018617;
	b=lUDmgXjIT/WbnTTbDRrmBCNXhJmmME+yhlvygjWE/Jw5hA2TyPyU3IaDw1tzu+hUS0xW
	 nIhm37he9bIgzpmbxSSyyr25SUv3spyQlPq69kNip17TnOZEk9ipFBaEfO0N7lHogLTo9
	 GrlmCbsDDnU92UWQoWXhYpEF5NE22MlS7j9PHiCd2ZOG5cE40NnBsoBzPgu/8X4sF0OsJ
	 kiaL0n0F6H4yazMjFbQMl279U4czXeJWRwGyuiqW/yGSTNh6FLUuOJwDcBY/XBLqfFR37
	 iD2okQzxouoKmiB24mwcA41BsOSPaU+0nZpNjRU77sWN+RdcA9thKlRbpOL2FwJ144A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789018617;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:X-Yandex-Fwd:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZVL9/esCsirmvPFASuo/zxWvaE0wJC/TYRTK19kwedQ=;
	b=EgfP5+RmpnVT8Uvy9NzuIX2p6Fr6u/2b4KkdhKAZXYNB26mFr1eSYQOpUy/hqQ/GT6Xp
	 ih39NhitGlr7JpZbk2Z84/Z+IFlhwZYu7CzXs/ldin3LSWf9GiZqaAPigDif8TGlC5lUI
	 8afHZizBkGCaGGk3+vGM1zeRLoNPBF0Lh4XtiWI198z1gjVcH7SsNWleOVm5Z5RAJC7Rh
	 gvBG0FtDRHjIauDANRvN68MJ/7mTOY+MiMDMAevK0S+SFdI95+yd+6BdEoMAWBRw4Sh+u
	 JB1FWxisZgSMuQQyHVQIC7tm65GBhKQXL6gXX5J16Le0HA+F48yOMzcw4SpsCXfe3Pw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=maquefel.me;
	dkim=pass header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256 header.s=mail header.b=rO1LNnBu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789018617;
	bh=ZVL9/esCsirmvPFASuo/zxWvaE0wJC/TYRTK19kwedQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u5W8odO6On/+ed81e4UFZdDj0bfS9XjeeYNjGhSP23fe7fvKqKDBJ+hFjx8UmWNMO
	 JQFvNN8n2WL2BlwOzODSQEDJEqGkDUBkBBvlya7MIdmaI4hCUh9vpg7UtZkfkHPqNJ
	 xIqFtZyfJI3mHmEAfP720NZ7dZ2apeFFp/sd+TLkUH/P6oSwaRs+5ZhT963GXpbkTm
	 QIE7XejzlF744MeffiTvJyOd0yFrBAiTDaaO9PpNCZ9cKERbODgFF69HfpWKc/cxWZ
	 DGYJEhbaTA3ypAw/Jf/i8gYOZKEramx2rxUlG71Z8dUrt13N4o4APqSuZ43sqrXRIE
	 JkpeSPKkvGexA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C1A340850;
	Thu, 10 Sep 2026 05:36:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F4FF1EA0
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 05:36:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 35F0A40850
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 05:36:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xDjgQxXGa7bn for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 05:36:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4342640851
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2a02:6b8:c41:1300:1:45:d181:d103"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789018613;
 b=mN6Aec7VUiJKUkA64AWeA+AmxnNqEzGd+y3jTFPBJ5+9a6YH3yf13l+Imq6dPkBOdBL2
 Pu+z//XhmUAwjP6OXsFl8i3hjCQM6imf4HI6cEB2c0JbwLtE3vdNyzaM7quX7Uqhg3/AN
 j+08MLCy60585oB0fV4wdZJspuhMzbA/A6ommPw4f5GqJdeoITLmALook2CcUeSrDTrWd
 32Eyn5Q917Zf1ogoVXVqJT+zjaeCW437gcG3iExlP/J3Me35lPu1JBGKPQZh8v+HE82mN
 jGh+A7F8/JYaJvDRxgfJl53AqJ9bh8Nm/1aHD71zTeAbysHa88T50f2pUkUAu6tnBHA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789018613;
 h=Received-SPF:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=ZVL9/esCsirmvPFASuo/zxWvaE0wJC/TYRTK19kwedQ=;
 b=Nb81j99Q4te4i0HQKoPsu8B8NTDGfsh3GNAlb0oorQL6hQVZrwLNtZECWNKszYtn65+9
 gIBBY0+v2ls7af00LLMVIOOboJgVfsg6jQj6F/txoaieR+Ja4qocHtPd0zmiOJkcyKiSD
 BjFqmAqiEcYck8X0yn5/0jRWmze9IvUkRqMDg95vGNxEWn0XqDu6TMnO28vxgxVmn4DgN
 hgpde1XAG6XZt39rSQfqMAtO+aq8cnHVO//AGN8Zh50xtDSGdSMf2/60pXmT5AHAkPFpA
 MmBO8Uhv6gT59dMK2yav3tqfpT1BoouOoCs7EH74d/liOqinYGWjVKj8szPloODVZEw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=maquefel.me; 
 dkim=pass header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=rO1LNnBu; 
 arc=none smtp.remote-ip="2a02:6b8:c41:1300:1:45:d181:d103"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a02:6b8:c41:1300:1:45:d181:d103; helo=forward103d.mail.yandex.net;
 envelope-from=nikita.shubin@maquefel.me; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me
 header.a=rsa-sha256 header.s=mail header.b=rO1LNnBu
Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net
 [IPv6:2a02:6b8:c41:1300:1:45:d181:d103])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4342640851
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 05:36:52 +0000 (UTC)
Received: from mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c43:9cd:0:640:e66:0])
 by forward103d.mail.yandex.net (postfix) with ESMTPS id E6259C0066;
 Thu, 10 Sep 2026 08:36:45 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net (smtp)
 with ESMTPSA id haHu9dld98c0-SFIE4dL0; 
 Thu, 10 Sep 2026 08:36:45 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1789018605; bh=ZVL9/esCsirmvPFASuo/zxWvaE0wJC/TYRTK19kwedQ=;
 h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
 b=rO1LNnBuX70pmPP7AbuxCyzDiclolrCC9DXd4TQgNbuKMWdqROQ9MNNRGE8elaRUo
 ISFDoc4vngd1kWOut0DbHJhOyJEa+iasvszA25vE6PdMDU351E1bZwODUqdIsDUZAT
 t/KgsKqXgi3W4hqS473j+5zFtz8bcgao3mThqOOg=
Authentication-Results: mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
Date: Thu, 10 Sep 2026 08:36:44 +0300
Subject: [PATCH v3 1/2] riscv: timer: Make RISCV_TIMER definitions weak
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-riscv_fix_early_timer_mmode-v3-1-52b569fa1d6d@maquefel.me>
References: <20260910-riscv_fix_early_timer_mmode-v3-0-52b569fa1d6d@maquefel.me>
In-Reply-To: <20260910-riscv_fix_early_timer_mmode-v3-0-52b569fa1d6d@maquefel.me>
To: u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789018604; l=1142;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=amiFzjuu0PYEGbtuow08KDapnd8p3SrYwc48C19f3wo=;
 b=9qpyaG/hgdmjXCAEBZAQhMqCoto/X2OOguWIOX9TIst7FBZbYJ6d5lUK3S7HGUewG4+gC0lQI
 tpDpvKuffqyCpP73VjUVeodx/Qhhmr1c6J7R1iogSsh+ouYM48GbE1/
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

