Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172EA606A31F
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 19:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QZCzc54g;
	dkim=pass (2048-bit key, unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=Hawkt/dn
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D4F3F80DA8;
	Sun, 15 Nov 2026 19:56:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bpleO4YHOUid; Sun, 15 Nov 2026 19:56:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EADFF80DB0
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794772574;
	b=J0YktfH3FZ/+A0rS0WYLbaGSTbUTqoEQKIzWeuOxMN8+xJrjkT2fvG5jQzJvXUciSTV8
	 wNHEAnOyOAWTvs8nXd6omKi0xlgAmwPAOYn3icSjtQs073ORoEdU1qQlWgUm4x9XXVitl
	 5M/MLFWXXl4MxqV1uTeDAgFFQqMDsKFPI1vswh/861zYU/BFxQN9Y2I022fejGXFWrj/M
	 BKhpG5WfMF6m4Uw9fkH5JzJrNVq/vlZoJlwzsSU3wysYi1PBSdoBipiWKSNExzwldeHNH
	 FZ0+UGM8dI6fFvINvhdFoV5sKusEeJ1EojUytaY8mmDecQODAEXd8UpCmdprr+xW5/A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794772574;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XaDgyXinFQnvHFI6e+oqlCQDyokKQ5kVgbOBG0dIf3Y=;
	b=JhXEgZecdo9IHPbidZkz/S1GDhBlsUhE+pOw/zeQFiYLqXNNlTXrv8P4CUmPEG+U8WYU
	 TAov8mfd3YTwIp1Phjlxs6SM+ZKiqDZSKCIfv5R8gCRzg7D1Q8D/twDRGhDD29MvKYSIx
	 4PD7+Gxcq3GtL9w5OWovir56KNFm5v4gV9muC9QzcG0NJVc86pXnOcjaNlqRFfVg6+M0t
	 BLvBejcApuOObZqpEPQ79amxHecyxgu/Y4/tBXDzCJcWz8ra2xIFseKrX8mSsX+3B6DHq
	 A4I1clU27z97LmG9YSkj3X5relTdlrmZraeMUIGVEcs1+HuZ2ojmJeZ9SU9fsNyhsZA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794772574;
	bh=XaDgyXinFQnvHFI6e+oqlCQDyokKQ5kVgbOBG0dIf3Y=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QZCzc54gB3btNDjTeOi6AZSeHxMHgRcsJGqY+MuGoIJaZvAhivv9caLXCxY6xxXIG
	 z/EEHClcgtXZ2n1sNO1efZo3g1sCEP8ql+l1UXhiBY+BeTmYf3bO4T0fJtx/C8HHon
	 mUNafAPW2l1yGrw4mMZ34sHkTEFk+r7vCTzsDjpXshPYrswnv38M2j6cX7BsFXchYf
	 CM8o9g6CbR0pjYW446HUwuU2Z68vs0wDNpBnHiexL5sSeI6lYULSwZy14dA9e8eBAe
	 PtINf9249DcKVEgrzVpR/Y+QcKhvMYiMrpl/l9AD5vj1qdiZhYkLbkB8Jrw7dCjDQ9
	 PdsBvv160zpjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EADFF80DB0;
	Sun, 15 Nov 2026 19:56:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 51D73D7
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 19:56:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3B3CE6067A
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 19:56:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sp5HEqheGg94 for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 19:56:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7C6D160672
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=0bb9=jf=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=Hawkt/dn
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7C6D160672
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 19:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1794772569;
 bh=XaDgyXinFQnvHFI6e+oqlCQDyokKQ5kVgbOBG0dIf3Y=;
 b=Hawkt/dn/MjdN+R3WfvtgkHuvBrtBwCfy65YRIO84nyZJ81ah+zHnV5Aztf/gDrEjAl3JEVWo
 F7BZjy/DkneeMEbS7J0RMpo687rO+K2sch6wJpx+NDa36G0rKz3unW74sFcoKc1CMQuFARUzMbR
 sHou4n+bSmGCXwXVLQkfIWzXmtbTi07Q7J2Cb30CnGbqwx/uwwTO75QH1wdzZxp8wZyfRZrhxmy
 8OZt6v3be7zrSSX6KeD5qr8q9oEMucyT88MlOMaQaj4p3hyv7xVWkVPgQ8VxyiqQOm+wCXODuen
 IKZAnV6uhvCH/lOP9nsPt+oZ4QPHqLHyeLt6EdKAboGw==
X-Forward-Email-ID: 6afa0e572aaf531b6d7404b7
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.19.26
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>
Cc: Lukasz Majewski <lukma@nabladev.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v4 0/6] rockchip: Miscellaneous PLL handling fixes
Date: Sun, 15 Nov 2026 19:55:52 +0000
Message-ID: <20261115195600.119868-1-jonas@kwiboo.se>
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

Changes in v4:
- Collect r-b tag
- Drop uneccacery type casting
- Update commit message
- Rebase on top of u-boot-rockchip/WIP/20261110

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
 drivers/clk/rockchip/clk_pll.c             | 73 +++++++++++-----------
 drivers/clk/rockchip/clk_rk3576.c          |  3 +-
 drivers/clk/rockchip/clk_rk3588.c          |  3 +-
 4 files changed, 42 insertions(+), 39 deletions(-)

-- 
2.56.1

