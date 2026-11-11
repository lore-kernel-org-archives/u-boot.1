Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAD9606A326
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 23:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZcddXvKK;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=eP7Gtm+z
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A217A40801;
	Wed, 11 Nov 2026 23:13:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id APFDkx9VAtgy; Wed, 11 Nov 2026 23:13:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4DFFF4057C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794438783;
	b=jDXIMIKUeZodXJWFZjiNS7ke5EahK3EcR/I5qRP+WoWt6r/RYY6xpwB1Lfe0eAs2K/Aw
	 c2uUlXPqPR+T0GMGjIspDsXqOfzVCBPu1eilqGRGXtxEHbH6xdEA1rpthIxCMZ3+apEUg
	 1FLNnTfvq/62D7S6BhJVoHhILxA/8vNYRgT1qEdMszD474d78F6l2EQnUs0B8WzRbWzMb
	 dV9FILQtliASAmzRypXNfHLjY3AcA71g+CWX+WKb9JsWhxb5zFa5OyYN3G1qlprfD0Oo7
	 XNJucKsh8AB5KCUkbqhnhMqk2ztLyhlC00qGBbXLzKrNHpnuxPJRmm50wBSUI5K1nBw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794438783;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DNDj0+8i2k0GveoBd9EegiqyQ7cVTMtw45EPJhPKduk=;
	b=kD7NHlTAGakkgBZ5XFAPZ7yJ/SCtK6AFRHczbI3rlwNUUVghObiKTRRLacXC3xV8iDhq
	 9V1yRKWx87rpaFYZkwZIUFLJcV71UeQpSktGKAAXWdbpUfkHWGECZAnn+qvvb0o+FwGYs
	 zUV6gKGFprnq+MjLe55kKzCVYH4j2Pd9izpCOIAi6vNyWK6ELhJDbO8ZGeq0X37honBLQ
	 We43nIDgWK6ToN261eITm69PlqErcwbb+x/DV9d45c6UcHUrpOUqNNinie0EXH7UeqpSH
	 H3u43v8E/epRO/EH+Hi4FfsdI3TJWcvbLPBKYg0SbSJf7oN5rB42PIumAFLQZpWiRog==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=eP7Gtm+z;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794438783;
	bh=DNDj0+8i2k0GveoBd9EegiqyQ7cVTMtw45EPJhPKduk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZcddXvKKKz+ntA1q5NbUdRaJc590D1mbxg5FCgaGnkx2D1KqoIOEYp0h5sZUFAFiM
	 KQXaKOW4d545iWtOtmUZJifMdbs3MzAdPerE33r7fSZrBX0hXv+s79TZ53ufSZaMdb
	 4v6V+nMDO1SHgt9/hx+kh7N/x217NFEdRZrPUIX6/FyEJ4ruCf6kKrZ/PWqPndOSA0
	 snMiKFENBAT51oXRKiE6aHLnP94siaV9YQW14kaNisskkC6p2Dbw6ju1uaiyy7JKFd
	 wj9gscblIoazzA5rOJDygDDNgY0p5G5YoQfuk4Hc86eXfVd/kXm25THb69soi7/YRb
	 mPH+tSEdnegQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4DFFF4057C;
	Wed, 11 Nov 2026 23:13:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8493F335
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 23:13:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6A82A4057C
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 23:13:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3HCpGNLcMbFc for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 23:13:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AE71240573
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=33c1=jb=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=eP7Gtm+z
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AE71240573
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 23:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1794438779;
 bh=DNDj0+8i2k0GveoBd9EegiqyQ7cVTMtw45EPJhPKduk=;
 b=eP7Gtm+zIUfN0ywoKo7A5qgdvsP52ump6LM/xwnRx28XAcyaICaVkwqTrWRVKWNLSksaBrYzc
 gcwNyRMb7X26xIdW+rx7IonD3eyXR44Wb2v+5LtKeIqYRdcUuxH2e8QQrZWIakcZItWbmlzUHzN
 dum0+0MOWT/ZViYhuCJepxF55+Jb2qpebTAl/ocjTQtv25L8fLNeCLnGiwVmdu3WwA3KelqqwNR
 b2ol+Tu+cqi8lWeuf8Vs33mq+RawRks7QBBkRKprtPQmy7y6s6g5GsMjBnSF6Ogr42OpHRYNnuP
 PCCZMzwTq3dwufIjRPckrGy2qJ5JFcNe15oB42GnzVHA==
X-Forward-Email-ID: 6af4f678f53292d6859f3354
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.19.18
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>
Cc: Lukasz Majewski <lukma@nabladev.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 0/8] rockchip: Miscellaneous RK3588 clock fixes
Date: Wed, 11 Nov 2026 23:12:41 +0000
Message-ID: <20261111231251.160051-1-jonas@kwiboo.se>
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

This series fixes a few issues found in Rockchip RK3588 clock driver while
working on a cleanup and refactoring series for RK35xx clock drivers.

Any refactoring has been held back for a future follow-up series.

Changes in v3:
- Split the series into smaller series

Changes in v2:
- Split "rk3588: Fix trivial clock configuration errors"
- Update commit message
- Add fixes tag
- Collect r-b tags

Jonas Karlman (8):
  clk: rockchip: rk3588: Use GPLL rate for CLK_TSADC
  clk: rockchip: rk3588: Use correct PLL rate for SCLK_UARTx divider
  clk: rockchip: rk3588: Fix ACLK_BUS_ROOT divider encoding
  clk: rockchip: rk3588: Set ACLK_BUS_ROOT to 375 MHz
  clk: rockchip: rk3588: Remove redundant PLL register macros
  clk: rockchip: rk3588: Rename PPLL register macro
  clk: rockchip: rk3588: Align BxPLL entries in PLL table
  clk: rockchip: rk3588: Use SPLL_HZ constant

 .../include/asm/arch-rockchip/cru_rk3588.h    |  5 +---
 drivers/clk/rockchip/clk_rk3588.c             | 28 +++++++++----------
 2 files changed, 14 insertions(+), 19 deletions(-)

-- 
2.56.1

