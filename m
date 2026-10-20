Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6265606A31A
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 19:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IIjy3Rv5;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=ZBO1CovX
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1D9B0810D9;
	Tue, 20 Oct 2026 19:52:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LA5cu5zAaEhp; Tue, 20 Oct 2026 19:52:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6435B810CB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792525924;
	b=cHLfAyWGic/lt36Nyc9z8w3GcbMrNBIEJP6LSt/Qa31xtnJwUp7ODxEfXd2rTpdxhXmt
	 OlBhCzThNDZ0HwKLG4wFmxfyPsKQgUy0oGuGSZo0OlswUXl0uyW0VgGv1OMb9CQE5iq1K
	 soCRJScA0tNInVNKdZvaRwGvWmMGZnDDPX6d1olOniMpwEUn5l+mx0edUwpaOGnD/XLPf
	 64Zdx/bKuqsWTRmCh/7GRuTGTW3CgePreseUONaqwfT1RZMneVON9w4CI8osaDn4IJAbZ
	 jWHJgb0Qv6PQzGq5Vp8bD+pUvHODWM9ZpMFpEidYpufV7VX0RFUZuF+C25Cwnxnyf7Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792525924;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uSsdTZ5R9NA8Gvdr6ndfdQur8Cw7c1wdKAzT7W1Lnqs=;
	b=IwX3A47L5pCxLRIfg1XVfoOMRgazYcC8gAoa+F9p1AMdTPyRRBtmsgxDInQTMbshJhn7
	 /bKabN6EMRogpEe4zcuEHvAe1TXzF+QuBGSflfGQxJaQHhI1nUHr48mqZY+2bFtgRPFzY
	 M9YdaytayGxNQJeAjzF3VOgW+tA7hWtw+x80cbgI9uPGf34ViyIBbrIx4mlO0BbMhuGOo
	 qy0ph3eeH9mUGOnD7i7jeZHwMYZCFT4B7Wt/d4eTEhKLk1gsR0bcE2e4w/mb6eyd6kvBF
	 2dkmId/eP2iuhNGvfd/EOrt/rPZfEyc0GcvWaN2vg0qT4U7VO3DOug4Ze+QwWs8L5+w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=freeshell.de;
	dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=ZBO1CovX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792525924;
	bh=uSsdTZ5R9NA8Gvdr6ndfdQur8Cw7c1wdKAzT7W1Lnqs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IIjy3Rv5qAmSnBsaBbGMRImmKanRU06657TTZwShrhaPBt+gEspYyj2Vo2a2onwn5
	 lfDLuSgCZaz5sRJSymReDiJP+hMhyNoQdyMCotLkxQW7TqNvioRe/YUuF1kmKM16/v
	 cd0/lcKSbqsmqEfqUcgg6XthZIAzDf4Ck7aS+AaIW6vjs+MQoI5ZEG4gEcUVupKazt
	 KfbWKn5i3AOVMwT7IRADnvT9+cjrK7Cj58bSALzoqToRmU4SJZg92NUPpOoazF/9LY
	 tK2epJWMvjc1pbw1flk0cUjdRO0M1cLxS8TonfE81vmqwPiqZ8nX+0xR5ORQfEKw6L
	 TfqpK/AyxFmpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6435B810CB;
	Tue, 20 Oct 2026 19:52:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 163EE3A8
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 19:52:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0827D80F4F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 19:52:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L32jF1VduuuL for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 19:52:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 964BD810C5
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792525921;
 b=nsNuSShGbg6Pc0nIbLjMclw358JgNwGDsuc1tsuVTQSkipihe/TVNIuqhpQxiJ0H1Ffr
 8jNfNgVX692RZXds+TAU6wQjINhfYtuYHe93Kj0khqAM1Co3rHj02DguUojYy8G3o29Iv
 4vbyKgGQtXAf4z3B15MuR/3wNuoaBE+VfYwSZMAOLKQCMH5DKBLsQpxmibdNDJtmyi+Rn
 tEQxMIZjnb0eeKfxJnck5XtX/Bd6t8/adY4Aq5Dssl+TzFMJ/JH378blTAXAfNmfnOUmq
 ALRdPew8rywHMGjyi8DSik7ihm8CVga3ZSKrwQMDA4yXBZROTQsEPbcA7fXwGbKZO6w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792525921;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=uSsdTZ5R9NA8Gvdr6ndfdQur8Cw7c1wdKAzT7W1Lnqs=;
 b=bvYYBaGZxAQXmtId5rToD96QmEV1eIWNvpPJnO1D2NXf1zhNoVDrQuOqBlVke+gD2gLQ
 msRvjcaxGQgufzMTxYl+yD3R/3dgHvAF7y8Wx6OSKLQYdNhhgTsafNxKF1D38aGhbjzc7
 OnELIbXa2jgLklvIIxYgWL9943t7zqPJvuTo06IikuhLl+JoNnt2I0rvp+ES5BGdFxH1O
 v2B+RUMrmAiJI5ZxDSa8SLFU7dIhEVk6eiApMZ9Rx4xFkY73Nm950hQ5dZW1At96VT8z8
 KC/+aorlqcARkOfDf2Zf4tkZi0XeWey7YgCAUVKLByRWgJjxuB0EIMhDClvVCsAzT/w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=ZBO1CovX; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=ZBO1CovX
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 964BD810C5
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 19:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1792525910;
 bh=uSsdTZ5R9NA8Gvdr6ndfdQur8Cw7c1wdKAzT7W1Lnqs=;
 h=From:To:Cc:Subject:Date:From;
 b=ZBO1CovXAGIYVpXuTia2SFvDpLPmtDAO+b7YlKkILjGLfwrkMUlTwbprAahY2ZSSV
 0T8muPgRu2xhG9AvxcNHZ2OQY6uujtX09Faua8uQ1rggf01oh1SKFZIfOHja8zfPS5
 4lUnD4Rhu4Bk9eFnMG59e6Tyjjg14gwM/Zo8d7NQwBor1q9ySl1WHU3qeeYXwzGv4a
 lV/IdLGfoQYaudKWCJ8UHyeuFTClLyhtxVl9JrLcxI+auDPKclaF4E607ZRANpHsww
 xURXJEMSiaZleTdGTnE6V58In0M5S1BKOPSk9f9QYBxvYWnTNS1yRmnjBNHqblm2kb
 wAqnUIW2PAO1g==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id BFF00B2205DC;
 Tue, 20 Oct 2026 21:51:49 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: u-boot@lists.u-boot-project.org,
	Yixun Lan <dlan@kernel.org>
Cc: E Shattow <e@freeshell.de>
Subject: [PATCH 0/2] Enable SPI NOR flash for SpacemiT K3 in main app
Date: Tue, 20 Oct 2026 12:51:09 -0700
Message-ID: <20261020195126.1325187-1-e@freeshell.de>
X-Mailer: git-send-email 2.53.0
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable SPI Flash command, mtd part names and locations, and store U-Boot
environment in SPI NOR flash.

E Shattow (2):
  configs: spacemit: k3: enable spi nor flash in main app
  configs: spacemit: k3: enable mtdparts on Pico-ITX in main app

 arch/riscv/cpu/k3/Kconfig     |  1 +
 configs/spacemit_k3_defconfig | 11 +++++++++++
 2 files changed, 12 insertions(+)


base-commit: 40988fb81ef17c15c36aab94297f5a7a6bc79671
-- 
2.53.0

