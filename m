Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5952606A331
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 22:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=acTFGByP;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=V8r4ua+b
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C70E8135F;
	Wed, 11 Nov 2026 22:31:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T2ZYsiMK0eGm; Wed, 11 Nov 2026 22:31:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 76AD6811F5
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794436310;
	b=N5RH76AJpBh62GrD1Ur9cm6DZKXNIGd3iM5IWdHurRH99j18Qm14PaTNbdm3Wxc/+hyh
	 IwitDbdalnEJLG8m9aOce42Ah2voe8mKerYGSlhWyyII6iWbGL2IlzkW1qBjxHNKpZceq
	 LKN4QKDER3nKucYkITTBQv8gFjudBV0JC1eKVL2m7JReRHC6zEj4+LK9hp+YubdSOfYtH
	 liDmSiqIVV8M4Bs9HxM8IP3xneKJnxm+/2XfNrh5KzMCOdw1hNSX9QDtnACPmEYZQrERS
	 UHHGJbR8sBiuACLdd8SCORJiumg08+/mptEUSpU9aX7O2CcUyE59YSnpFZyE3O57ICg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794436310;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=kRvIy19NNcFUq3S+jGgt3cj9f4vYqZS52UwdvIs8tLc=;
	b=QY6JR7NUcqUBhCI4LQ2nkW780ia2z5KU+Q97uYDP6DZvk70q8B+AI4OBX4TLVfTshfwB
	 tIlebiVqsxlvkxPGIH3HzzNTftOPFrT34/LSy58D0fevUwlpnO7aCtOJKbE7fLkRX7MXk
	 R2UShoADL3JdOht0FZOELOioDzQtG+rZRtyMW3g9IB5p2XGY7CZphRiXLkCM9y8qHxDJi
	 p7PJuZIIGvR1VoVwqrpM+kXmynh+7R7JA1OhZ6YmgcSbIx42wXrRxyvyDRFTfW7DN5fGS
	 Y53fV3jn8jfxc5c8asLXsB4B6XijJZyYsD7xstyCys3aty5loipczKPvCzSMlnaNEzA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794436310;
	bh=kRvIy19NNcFUq3S+jGgt3cj9f4vYqZS52UwdvIs8tLc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=acTFGByPvbDdXVsDpQX/DMfVRmwsEyYa7XEQDNCrfgSpGaCz+1Fxzsm7z/xOmphXq
	 vt9JzbqTf50ioh6QvSf4/mTrJSeWVuLpx15Sn2JCvNfNkxGNUimLNC8SJQVejzfzFU
	 dAG1nq73gLU5pCag5vIZb+HSuwIdY9i/v3ycPIWOYa/qDm6wVSL4xeHpKbuAFLT0H7
	 +D5MVbaVj+hWmFbOMffbaiof7B9Mtt+ThgacurZQJ16RXTREU38Hm9HeL3DXaRImUe
	 8mzUPZ84YQ5CypPSNvPRUIjC3O2E9BXRX4qqbgB5yzsHs+LWmPN5v/VjARthHzmzr/
	 LBg2n3zwvLhJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 76AD6811F5;
	Wed, 11 Nov 2026 22:31:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F386770B
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:31:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E51A540A71
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:31:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BINY2VDM7Wor for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 22:31:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 60D2140990
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=33c1=jb=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=V8r4ua+b
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 60D2140990
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1794436307;
 bh=kRvIy19NNcFUq3S+jGgt3cj9f4vYqZS52UwdvIs8tLc=;
 b=V8r4ua+bmg5oSgwVgjADwxulcW4WGFgZ9Z2JDvZreBb7P5p3XbpYU1TgHXiRvNikhcNvY40Oa
 4iKVPuVG+TJkKS9Dlpurf8czSoY9PrwVcGUxPlLSna+iwcZYpqEwqc78Rc/d3B2Xy1PuZJJ4blb
 OxDqz2lQ971i4+jfQg1hDAC2dhn0i49D2rqMkUX9lefF0HlVqDUxUGmeikAGcN0Ad3QtBxUkt4B
 3Rd7qskxIjku5LWTGJwrED8qyER+ORcMKZzmC52pMw/bSqSOt4NU2QSqSXybPU7BgCs35lW9M19
 1tkXFnku+YEESe1OvRibhsgVEvMEPstxidLCCrG6QlPg==
X-Forward-Email-ID: 6af4ecd3eab6e8cc0ce8c04b
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
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 0/3] rockchip: Miscellaneous RK3528 clock fixes
Date: Wed, 11 Nov 2026 22:31:38 +0000
Message-ID: <20261111223142.158361-1-jonas@kwiboo.se>
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

This series fixes a few issues found in Rockchip RK3528 clock driver while
working on a cleanup and refactoring series for RK35xx clock drivers.

Any refactoring has been held back for a future follow-up series.

Changes in v3:
- Split the series into smaller series

Changes in v2:
- Split "rk3528: Fix trivial clock configuration errors"
- Add fixes tag
- Collect r-b tags

Jonas Karlman (3):
  clk: rockchip: rk3528: Return correct rate for CLK_PWMx
  clk: rockchip: rk3528: Fix VOP clock configuration
  clk: rockchip: rk3528: Align PPLL entry in PLL table

 drivers/clk/rockchip/clk_rk3528.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.56.1

