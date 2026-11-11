Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6027A606A89B
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 22:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LwJf/oq8;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=fXnIAs5h
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2BD6540A9E;
	Wed, 11 Nov 2026 22:35:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id juYHWhiJ09uK; Wed, 11 Nov 2026 22:35:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8C8E140AEF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794436516;
	b=cDfGT51BKhIOr9ba1HNoQrfh5ynqMAn6QiQtp4+TseJJnL6y91bjQ4VQjaFezVA8aVG7
	 cMACSVaA1Vn29sxAXWbq/AR71Tkz8wkUGhoQ2CYC+KE+0fibbZZDMsqeW0awVzedyKmkJ
	 fo1EMqKTm/fY5l0YChJ0PmGzLCbq/w4nBF1rh7F+p0ZLbK6a4ZoakE+M0w4z1YrTjedTo
	 PoilQ/QkjskTK4ifBsrOBjZeeo9e9tmzbI16wKeOFCYaGl74xv9/aiCTTJmgxrBHGxaO/
	 dz4yfXcoLDu1vdNvm8UhA2uz0NhxHF7OhL01LLPTDi+ICsdm40tw5v2hJPNFe7ttGpg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794436516;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tB+QQtTfWOrkL/fCmbJt18nyRsq1MFCxxPr3kC8k3Hs=;
	b=peAwLV2FkbkZwMci0d7ZEJmpN6KGDi+dXFfF/vFM3s9eSLc7XVm9omU73pWl4AyaS/4m
	 tH1a6SirZd8qvMTypwUxb8ZH4DRkwO8yLwJpQT04C1lN2XhHFUTr1QI+yhhCuMXJCSN3C
	 qj6U/bclrD388PX6+FWSawcDcBHkyFrU/KWc273fV3m4A0Tj57jJ7gILvlD2jXDlWJriN
	 d3uJzXmnvenE2XKVP6DouvqhbdjzWrLmk8FDc2RbPJ5PVfD1Z5hfMlTuJRn+Rz4n848F7
	 bx9L5hKy++tOPB65PT8GXZrv5sxntHbVoBapbp9nMZn8ZBlaA84WwqhxyOVS6szuZzg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=fXnIAs5h;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794436516;
	bh=tB+QQtTfWOrkL/fCmbJt18nyRsq1MFCxxPr3kC8k3Hs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LwJf/oq8DBgcO78ocVh+vnN+DGCE9twkejlMaXiB706wK7QbM1H/yfuwOpcLaP48t
	 D/GDtfK7kavKtVzJd3crCdCPwcJmjf6daV2mGURs7PhiOJ4zOh7T8D6t2qj0a8RXm/
	 Ts2GTmURCHfFpM/INIjTElD/XhGg50orwrFeQvyLdVNMJp0EkjYIKawhVtRAoBVRF9
	 XYUsrydlYTlRoGxQTClIOI1qLCrx7ljvw8Vv4CzWb0MNpgxEP5x2PsGSzXOGXxwNW/
	 W+obNMYOQ8V6dtrAbae72dG0MxogNMsNCyiVk3TP3QAGFAL9txH/xAEog79Raqu/Qo
	 1vNOwu+gdN3TA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8C8E140AEF;
	Wed, 11 Nov 2026 22:35:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 733D170B
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:35:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 60C1340B0B
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:35:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6CEEK1e9u4jL for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 22:35:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A759640AEF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=33c1=jb=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=fXnIAs5h
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A759640AEF
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1794436513;
 bh=tB+QQtTfWOrkL/fCmbJt18nyRsq1MFCxxPr3kC8k3Hs=;
 b=fXnIAs5hU4BhQUbgLRIo0WZEPbdmvzA10oJ7VVm40QB+wzNUc87lh6ge05Kx143WkMtQOrus2
 z/W/yP5cfEj5C0VIeBEI8PXckfiTeNCwtXx210rQxSfRpX7W1bwyBvzxahKNln3StLyqI9ft2SY
 o5uLQuh6s3pOw3paUmyOxPSLU39zOd7eH/TvF91Cm3CfVj5AE23jCKWQWmpEIq0UpAaQPEwCtms
 S4C9ZSBg+z1EQ2y4yeWXYjMltJJA9mlZfPz34qnMcy/9QKPtYL4kbgr7S73LpOBEthSFbDdrW7J
 s2qG11DDrm65HhX4bHYFyp5mAaQd/crlJBaPCZ8yKRQA==
X-Forward-Email-ID: 6af4ed9f4e7b1f439360f025
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
Subject: [PATCH v3 0/4] rockchip: Miscellaneous RK3568 clock fixes
Date: Wed, 11 Nov 2026 22:34:59 +0000
Message-ID: <20261111223505.158852-1-jonas@kwiboo.se>
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

This series fixes a few issues found in Rockchip RK3568 clock driver while
working on a cleanup and refactoring series for RK35xx clock drivers.

Any refactoring has been held back for a future follow-up series.

Changes in v3:
- Split the series into smaller series

Changes in v2:
- Split "rk3568: Fix trivial clock configuration errors"
- Add fixes tag
- Collect r-b tags

Jonas Karlman (4):
  clk: rockchip: rk3568: Use correct clock id for GPLL
  clk: rockchip: rk3568: Fix PWM0 parent selection mask
  clk: rockchip: rk3568: Use PWM0 divider shift
  clk: rockchip: rk3568: Use correct PLL rate for CLK_MAC0_2TOP

 drivers/clk/rockchip/clk_rk3568.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.56.1

