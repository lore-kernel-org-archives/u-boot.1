Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9200606A322
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 16:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KPjAPD5v;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=VRrO3kjB
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA17540790;
	Mon, 16 Nov 2026 16:14:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id upzXNJ-cBbND; Mon, 16 Nov 2026 16:14:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D312040792
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794845651;
	b=bNLZ8k6vbWf+4BRj6zWfLW3JlNiUtNN+bLauW9RCjWmM08zJUiIf1V9R2qNZIsxSw+Vo
	 2XkklK2lUJLVQHaxdAy+ZQrxI0L+LsFdjlf+AtGM1rRkrkFWWX95bvCD00D6+t1f66h69
	 eEpVqOLPQtNgBcjgYClNldhcw8p0HVd3ni3o6fzlKSVLVZ6NEyeMC3Jt64KyUYoB/MVxG
	 czACfjKUVFW2RMq39NpxMUJkioFlIIoDEA+uakyfGc9vAUL/nJLlt6mZWxYKaQPjF4pgC
	 VglDZok+aH2AP1r+QMEnn1ItHFV7Qz1u8j1UGNq/KbWBCIOxbolSB7p7fO9mic65tUA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794845651;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Infomaniak-Routing:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=TrNsMtrIhUPe1RJesTUxYVJ1J8HRIIdXQLH7ASpo11I=;
	b=IIazThYXHaAqQbDcHndCW9elYuSiU0ip7SLKW5rp4/JugpAm+hHyx8Wbiymi7G+dhv+h
	 kRwiHBbIVpcTKLP0rqrqhj7BTEdWAo5imqA7skWmPuftNyCEBESDi0JzB5LJW4azLMcjr
	 /ThLYi5A3fuy2OPNf0MhWFDfu8y5nKy/aMzS7953458yZoeyRgZ1D6AMayEAjJfYb+Q2l
	 1wSraPzeZ+KFb52+R97Wcdwia8kvrjboTfyMh6bO7FiIOrx4jtI5tH/tqTMDAnczBv/aR
	 cyX/+covYH+Q1V+1/c7UEQFIlt0DvbXT3E02OK28bfbaQftXMcNjZRtwncSHiovXMxQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794845651;
	bh=TrNsMtrIhUPe1RJesTUxYVJ1J8HRIIdXQLH7ASpo11I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KPjAPD5vruAKTSxOxKmQolze651I1J6mFnLIh/112m4L4D53/0tsRSeGdmOvGmp6J
	 n6CHHRg4jBfw12zdeq7OP1WFwjWHPRegkaqehbUyVkAKEWAAitXxiReWKG3jghWEUX
	 pKbAhZTeWwWLk4hZ+XvTihYbMkmxJ63/V+1XCL9qaK4gJAKd5keE4ftmZeYieT+35m
	 MSNi0ucqNOVug1/j13bhlvZMQDrY5uNAXLiUEOpdW9HTu2StYMxEWtmh8GkG87cGQ3
	 tWfjs/zvpF/FQLXtdQSUg3t1biqpizPG20iH+e24KN2iWgYL+Vuqhh5N779E0MLaIy
	 y0nafgzFfd+iA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D312040792;
	Mon, 16 Nov 2026 16:14:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1C8F04DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:14:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0EBDD402B5
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:14:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 22j2zEjkLrkW for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 16:14:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EB0044009E
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=84.16.66.169
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=84.16.66.169;
 helo=smtp-42a9.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=VRrO3kjB
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch
 [84.16.66.169])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EB0044009E
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:14:03 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jStGK4dY4z2Mc2;
 Mon, 16 Nov 2026 17:14:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794845641;
 bh=TrNsMtrIhUPe1RJesTUxYVJ1J8HRIIdXQLH7ASpo11I=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=VRrO3kjBnaKecfJ75qYoC/N656pLMQhVIc50MDv1ERCeaAkuFbUPE+bCFTGqOl082
 ubj6WOTYNKw+EgNxQDtNmBjanGSOv0tZvJsMq9Kdp46cVHOFdgUVv1xeYsoN72ILBx
 tqGxoo5H133c8SfOFMd4Y2rQGhdvT3m8n3MI0ntc6tnVYJMbp8rG1/r8wEn8X2AEGu
 RD0SCcDtM3vAcFHQ11GoZQehem2o6uoOu4IbEZ9c/OXMCSM2vmdBbkjPnRm41ihzVA
 TVASonsJvx9Inuhjg5/bux6P8+7V6w5W43Rv8HT6/d+EodNJuFmngE63Li9eZZF872
 RgGHsIxSfoZ3Q==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jStGJ4rK1zxdq; Mon, 16 Nov 2026 17:14:00 +0100 (CET)
From: Quentin Schulz <u-boot@0leil.net>
To: Quentin Schulz <u-boot@0leil.net>, Jonas Karlman <jonas@kwiboo.se>
Cc: Lukasz Majewski <lukma@nabladev.com>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20261111223142.158361-1-jonas@kwiboo.se>
References: <20261111223142.158361-1-jonas@kwiboo.se>
Subject: Re: [PATCH v3 0/3] rockchip: Miscellaneous RK3528 clock fixes
Message-Id: <179484564065.1840799.10861424707704455356.b4-ty@b4>
Date: Mon, 16 Nov 2026 17:14:00 +0100
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
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 11 Nov 2026 22:31:38 +0000, Jonas Karlman wrote:
> This series fixes a few issues found in Rockchip RK3528 clock driver while
> working on a cleanup and refactoring series for RK35xx clock drivers.
> 
> Any refactoring has been held back for a future follow-up series.
> 
> Changes in v3:
> - Split the series into smaller series
> 
> [...]

Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip (u-boot-rockchip-2027.04), thanks!

[1/3] clk: rockchip: rk3528: Return correct rate for CLK_PWMx
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/b1064e9347ec44ff0e6d3fccb6db5a92a540d6ec
[2/3] clk: rockchip: rk3528: Fix VOP clock configuration
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/3f926ce3a61a15e37b83b17cd83e4b693f79b22a
[3/3] clk: rockchip: rk3528: Align PPLL entry in PLL table
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/9c652b5e08d5d29c37f8310cd3f1d0a4e6962e7f

Best regards,
-- 
Quentin Schulz <u-boot@0leil.net>

