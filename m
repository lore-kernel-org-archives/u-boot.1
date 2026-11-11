Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC81C606A324
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 22:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LrJ3U7z/;
	dkim=pass (2048-bit key, unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=kB8zc+gK
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 853F4409BB;
	Wed, 11 Nov 2026 22:28:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id juKKf7kXc_xH; Wed, 11 Nov 2026 22:28:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DD8B240ACD
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794436130;
	b=m+xB4QnQabNQZiZDUkRbX+AVkejADCt9U0HqxvWBmDs0E33VpQTPi3Sd7X1PlPdOg6nc
	 /7y9DAJZGJxu636fYZYdWYUyNQEM5oUGaRH43R0fhx2OQIseVgi6Gx7qpnwPTldp9QGst
	 Y1YaN1Cehz7RiqOT7WkGZqWByUg93ww9TQlFdpkK1J6gnwfNTzEDeeMuqpCA4nttK/4xx
	 I68rS8ZYFDYnDFAhFLEiL4ox7FmIsnnvqO2pr0tcNTfo+AZl5Xh/J0CUqvEWqahqMw4Cg
	 8FpFYIzwVHVUoYr9gyaIG3mcKXamum/5vFJ+98PpL1DuLHezolv9lj5xrjcNKO8A4ag==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794436130;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RRrvqyAGokP+YOEqYqL45G5ydU2QJ8XVIRXjxUDT/QA=;
	b=qSFIKtRdqY+qHN0gPX3HrOFtrthWF/sxfrmYN5jUmIH4D9jBAYQWg/ad1fppitH2qGWx
	 hEEmBDcr9vuc+GcjK4qF4XmKbhWGn7vUOXBUL7SgX2Y/GNmOKwY7ziWkJknbiIv69SG8o
	 8PbP+tp18AaiCQBMgb7eE96vWh28ApvLboUUAkhf6/CdTYQb50D9GD05TqYWKmaLNteR8
	 AQFC3I33gmI7/uputdAMpf5jQ5CqJXGCy+YIlvXaVDqF+Dj68I1HKRcbeZ57yJZ87weUL
	 +0bOQg4wLy5E1PvyQww06BwHUuSVgjhdLaCp9Gfu7DoVHp67hRGlk8qwnnjuINaVdDA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=kB8zc+gK;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794436130;
	bh=RRrvqyAGokP+YOEqYqL45G5ydU2QJ8XVIRXjxUDT/QA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LrJ3U7z/Iq1IqtdkmqMnw/7PTlVyaGqmAjHpMUKyAaCNDs7UMAetsa50RbAVYXtqz
	 wYTMKLznTufrRPW5N5T2W1Qn3tN4vf1QiTJedPbr3nq6j81qJAxB8GKMbZ+adEL7SZ
	 sq+Hpojb+lZ3U0ivGq2BVqLJGj2ha5Ovo7M5D599cW5nsrOgE/jIevnodGMBQ9pqF4
	 sN1LyyC+wi1p6pn9RM0KRGrdvataVPaSkUqu4J8j6tEwsJN1ElMq2uCbnRFhjcNUXB
	 jRCeGAbw6tlXBDKkUts/b/d04luZHRHSDkXvwV4G35LllcsmllE3lmLrODX+M27lRJ
	 s8w1VYRAGPrOQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DD8B240ACD;
	Wed, 11 Nov 2026 22:28:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2FEEF335
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:28:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1521940ACD
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:28:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VqB0eX8-InmX for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 22:28:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 93A6B409BB
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=33c1=jb=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=kB8zc+gK
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 93A6B409BB
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1794436122;
 bh=RRrvqyAGokP+YOEqYqL45G5ydU2QJ8XVIRXjxUDT/QA=;
 b=kB8zc+gKg4yj3UgSbGcrCMM5HHZ56Jo+5Wv4HEoM7h/AySx4ihpzNk2LH1keesBYQTzE1UFId
 1U46LFMaeJX+wByUjS60Rx3IMj1Bug7R+FFy3ELOJneDUiO/PeogU4kdxRBRDCHG91slfJzhX2f
 iGONKnxH8YMOG3oIt6lSeTb0cZR1VXE3KPHtpaQi1oB11pZAqMSp2zIIe8No0iTJsTAwij7VkdH
 tA4we4LLoXQU0TFIud1VqBjHWryoK8m+8WgVXaQBpmtl4yLHq8PANn8K+A/8AEzbACLIco9hH84
 i/ofTQ5vW5QY97s2cewDSmAzQewXJ9UO9uAgcZ4NMfng==
X-Forward-Email-ID: 6af4ec186e1792a74d36a47e
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.19.18
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>
Cc: Lukasz Majewski <lukma@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 0/6] rockchip: Miscellaneous PLL handling fixes
Date: Wed, 11 Nov 2026 22:28:26 +0000
Message-ID: <20261111222834.157842-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series fixes a few issues found in Rockchip PLL handling while
working on a cleanup and refactoring series for RK35xx clock drivers.

The 'special pll handling' should ideally be moved into clk_rk3588
driver, something that can be done in a future follow-up series.

Similarly, any refactoring has been held back for a future follow-up
series.

Changes in v3:
- Split the series into smaller series

Changes in v2:
- Add patch to fix automatic PLL fractional calculation
- Update commit messages
- Add fixes tag
- Collect r-b tags

Jonas Karlman (6):
  clk: rockchip: pll: Fix fractional PLL rate calculation
  clk: rockchip: pll: Fix automatic PLL fractional parameter calculation
  clk: rockchip: pll: Always write the dsmpd flag
  clk: rockchip: pll: Always write the k parameter
  clk: rockchip: pll: Use PLL_FIXED_MODE flag on RK3588/RK3576 PPLL
  clk: rockchip: pll: Limit special rk3588_pll handling to RK3588

 arch/arm/include/asm/arch-rockchip/clock.h |  2 +-
 drivers/clk/rockchip/clk_pll.c             | 75 +++++++++++-----------
 drivers/clk/rockchip/clk_rk3576.c          |  3 +-
 drivers/clk/rockchip/clk_rk3588.c          |  3 +-
 4 files changed, 44 insertions(+), 39 deletions(-)

-- 
2.56.1

