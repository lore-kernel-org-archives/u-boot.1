Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4626E606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 16:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cYnMojf9;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=MHEuUiE7
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 24165407FC;
	Mon, 16 Nov 2026 16:14:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XgcKuZmPHsxc; Mon, 16 Nov 2026 16:14:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4F80440797
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794845657;
	b=Ny0bgqOZ9D3FsvK7Os9DYEpWYz9AsnjbT1qnoNfmOLR7otgfAUFzvL9Hgkazvjj/NWiK
	 FpZm6kJtV7uNU/ma0DbDPho9A7OQYqRVB/4Q45k7tAr582s6qV4PzsZ9kCEMP7qGgyakx
	 xECxkz8+wHuF+xZvMImPr4VfpXYx7bqt5WQk0/an0dGWJDSZoU2I11fcVddMGs7SeNHkW
	 SVJMGywb+Liq+l/tPZUZI3nxmoi1zQdUwT8eoyo9Uk/Ev114CtHJ/d+LJrnACzJGa5yR4
	 WY9VrULGZWBhhlSvF86oBLY3moJHsC1kr+hPwxaiTg5kBcFUNaBhVcybtP5tczo9ypQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794845657;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Infomaniak-Routing:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xHk60Yf7Gz3r0BJimplo0lZKgXP6V/DFzVdCCJup+MY=;
	b=rb7evw7DKhhvZA5OexjZ0L6HodI9qi47mE6KH6ArKffmLsiD/b1msBs4DvkNzqRFeHnp
	 TADI6PJrmnJs9OjUQvoPprSDU3WmIHnV1Q2AOqiciPfxJULmtq1CSx1KBdUkfSwWa4OTQ
	 UyrtodyaYXanZRBr/w18u0aeYiQ4AEFgVTt+ec/UtEbRE8n6pNEtElj3sPn5TGPR/2dzN
	 QTcT7/xKVQfIwjQpA97pErn6ivKAlSa8U7kd6fXXbhrcDSHt63+4DUrxCZb1BLHjiY5mK
	 dtG7pGmBG4E99SNz5JZyTLUy1HYW8jz7e8oeLh+/bVDKfERxYXUCHkFskPXBJJ9sifw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794845657;
	bh=xHk60Yf7Gz3r0BJimplo0lZKgXP6V/DFzVdCCJup+MY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cYnMojf9SXrtSojBw+fXD8iP0CT2cMSfGf81Yw/y+ramckxggInF3Ps3gzHLiAtRG
	 pcR5Rc0DfPLqn+9m8CtfJDmDpW7k9EzdN5er7LT4MdFjC//umV8CRAoX/d17/NiszI
	 dlo+v7rMF2z0IwNjHW8l2DX7tmkiIUXZbU5J407Brf0X01ZMsn2XB+uFTkSCUOO3bp
	 pweOsTydYUFP6eaKMx7roaGEQXgK8Ly9U2ATZgTBatvpvSy9L2PLYK9HfmkYH4zilp
	 FuOFCLsWy7sM+LpA8C0tLAGQUxOb/0xTqjDPorjz6nKP2vLfZXWSvE5VtXRoUM0NMr
	 0H7mfdSQVtAVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4F80440797;
	Mon, 16 Nov 2026 16:14:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 01447169
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:14:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DC36E402B5
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:14:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j3KUCm9P-LBK for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 16:14:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E0A714009E
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=84.16.66.175
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=84.16.66.175;
 helo=smtp-42af.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=MHEuUiE7
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch
 [84.16.66.175])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E0A714009E
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:14:06 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jStGN2dX4z2KxN;
 Mon, 16 Nov 2026 17:14:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794845644;
 bh=xHk60Yf7Gz3r0BJimplo0lZKgXP6V/DFzVdCCJup+MY=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=MHEuUiE75eCWbC8d7Qfuvo8j89XGidc4GCakkgtrGAPzVb3J0aZYetiOFBLBvM65G
 iLrUgCLc6WpZ6b5oxsDe+Aw4uX3pr97yTdBba7VCheSv2gNu09q6VfLLGFbR2a+B7L
 BWXqDcjrKtkMJTk2fAf2+FAUEnUPq82s16L5Xp/mKiBmloelVRofsJqBERkflS/FnB
 4Xfo04EXiAZnsyeYrqx0trWVy4qnqiLZ5p26XZowoyiVNqylE4gsbNQqL3BieiK5IL
 t4sxmLRRXP0ISlP6fvM5+FXtWNk8kdYCsGhDYsKIiC5GQv+fPjyamUSKKEJoGoa9MR
 rZpXFarRF13hQ==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jStGM2FgZzwqH; Mon, 16 Nov 2026 17:14:03 +0100 (CET)
From: Quentin Schulz <u-boot@0leil.net>
To: Quentin Schulz <u-boot@0leil.net>, Lukasz Majewski <lukma@nabladev.com>, 
 Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Heiko Stuebner <heiko@sntech.de>, Jonas Karlman <jonas@kwiboo.se>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
In-Reply-To: <20261115200447.120668-1-jonas@kwiboo.se>
References: <20261115200447.120668-1-jonas@kwiboo.se>
Subject: Re: [PATCH] clk: rockchip: rk3576: Fix ACLK_TOP divisor value
Message-Id: <179484564328.1840799.16943522314597850861.b4-ty@b4>
Date: Mon, 16 Nov 2026 17:14:03 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
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
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 15 Nov 2026 20:04:46 +0000, Jonas Karlman wrote:
> Write the calculated divisor to the intended divisor field instead of
> the parent clock selection field when ACLK_TOP rate is changed.

Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip (u-boot-rockchip-2027.04), thanks!

[1/1] clk: rockchip: rk3576: Fix ACLK_TOP divisor value
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/79486455744acd15714203801ee474fc2dafd9e6

Best regards,
-- 
Quentin Schulz <u-boot@0leil.net>

