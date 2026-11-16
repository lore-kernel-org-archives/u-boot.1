Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133D0606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 16:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kL6Q/2lz;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=CSiZt+x2
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E33C58101C;
	Mon, 16 Nov 2026 16:14:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iPaJ02uubvB3; Mon, 16 Nov 2026 16:14:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 07E558100D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794845659;
	b=La6q0Z/8idV7VUlS8zPZxvBahnt6U71ppx1EL6n7nInall9aMDCLFJH3EDxn4++bdLDg
	 LMD5fag40myCHeGxkpFO/C4LjNk1ckul+9hQRX8XCy7yAssT3AK4E3kw7hGH4Sl5CWub8
	 /MOochYk2l20IRxCazd/j+NibVlfVSwO7cZrDt7ILVR+/xmZwyoCdTBcHw6vIGnJ+5zrL
	 hpOgKWDuxWhdmmq7CGKIeck314UVT2tyfne2pJVmErnfm/ODCbgL0d2EnQYj9L4TMs5Qa
	 UAocLUNCYNyrLKDRWetdgNv2Pmk5aZnPPHKe0X5bvDEvO1yIcjgYQbqQhW05Rr9pPBw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794845659;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Infomaniak-Routing:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=HAJkRgTmZjFdizEkMU6cPbc7HNOydi+n9VkPFur0CrM=;
	b=AxY274UATGnRk0V6lISezekvn5AzvsVukVUisHhb6JFHRf0Bv4D0GlFz4YacGt62QHyO
	 UxhMu5MmMHRVnr0NeFzIofjoQXdYVpmmQJp/5YFLcG8A2Ak9x3cfz36+93IIhmVjZbqns
	 47H5UUekXJS7m451w07Q/tos6rX5lR7O0d2jjYKHpQbW+qx5e3qOuuIrOul96ip4SrGS/
	 Yc07G+4OiBMLLNdz98v7IUIJlTWbHnRyIRSK/w+cNHDjv6XVb0Yb0NMdaThQ1q37UHtDZ
	 A2Q9uxRJtax+spcq1JD2QRt6muflokIbBEMNC9SRaLs1oNySq1hjXAX6oi77NbA78nw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794845659;
	bh=HAJkRgTmZjFdizEkMU6cPbc7HNOydi+n9VkPFur0CrM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kL6Q/2lzKIcJ6B6dlA/X9QpY8gk8uv5BB06O68l/N4+RwVDDHfwy96vPbSSRMNvgg
	 QtKUV7LYJF7E6B74NCS+JOe2yPcHJySviMfz8+e/AemewdJ/ivomVkqo3OQODTfxWB
	 FvKFkirsDfItg+Vii5xkZWjcQ1AVudrRXjYUVlmqeXN0Ac/dh2qyLnR/wagwG/NQRH
	 vzS4U1/jtj7fW//xeCNJ98MsmOagOlY4T4RFPIuoPGof5wsj/xrmDMlqIAdPZM8viA
	 DnUNCqcy2K6QThqtjDL5JQZO+veT71WIDStfyIJY1RpvlQg/PUMCbp7TLdWbOArPRk
	 F1Ksyp6Wwcaew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 07E558100D;
	Mon, 16 Nov 2026 16:14:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0EBAA260
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:14:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E807340790
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:14:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PSUbm_T8ExUe for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 16:14:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D13174078E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=83.166.143.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=83.166.143.172;
 helo=smtp-8fac.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=CSiZt+x2
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch
 [83.166.143.172])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D13174078E
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:14:07 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jStGP1WBtz2PM3;
 Mon, 16 Nov 2026 17:14:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794845645;
 bh=HAJkRgTmZjFdizEkMU6cPbc7HNOydi+n9VkPFur0CrM=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=CSiZt+x2d0amTnAtk83ZYHnRS/w4DEUz1+NyNJLhDYUl0CrQqSYZsveb1nIA9As7c
 cJdLeVhBiF2p0814qdHBx9wyOXspBGhb1mqFJ+3TecWDCpmrDNs5gvGoGU88TkZjI9
 o+wCD2l/regKiLXKIZNW6kcEZWR8l/h3oPbK+iws4Jf88TIJIHrfPAxZMu9mdsvPjd
 Ir2VBZST7iqzicXyns/qa2SrPZ5hhXVIEovTSME4LD0ABTRKWFuD436uVUoI+TaqA0
 kSGw0Gx1us+WPVCfCOkG3zM6YYS4Cc9LgGnT/S+fLDKoDOQxBgP1h9ZW6rYGYtkHca
 zf2NZs9Fns16Q==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jStGN209ZzwTv; Mon, 16 Nov 2026 17:14:04 +0100 (CET)
From: Quentin Schulz <u-boot@0leil.net>
To: Quentin Schulz <u-boot@0leil.net>, Lukasz Majewski <lukma@nabladev.com>, 
 Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: Simon Glass <sjg@chromium.org>, Heiko Stuebner <heiko@sntech.de>, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20261115200526.120871-1-jonas@kwiboo.se>
References: <20261115200526.120871-1-jonas@kwiboo.se>
Subject: Re: [PATCH] clk: rockchip: rk3576: Use correct mask for UART1
 parent clock
Message-Id: <179484564425.1840799.10669181884262764679.b4-ty@b4>
Date: Mon, 16 Nov 2026 17:14:04 +0100
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

On Sun, 15 Nov 2026 20:05:26 +0000, Jonas Karlman wrote:
> Use the parent clock selection mask instead of the shift value when
> reading the parent clock selection to correctly report SCLK_UART1 rate.

Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip (u-boot-rockchip-2027.04), thanks!

[1/1] clk: rockchip: rk3576: Use correct mask for UART1 parent clock
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/40393084b930d7ed5dcecf7952cea06b9006df68

Best regards,
-- 
Quentin Schulz <u-boot@0leil.net>

