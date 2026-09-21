Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B527C982ED
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 20:05:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3CE1980D23;
	Mon, 21 Sep 2026 20:05:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BfvI0jnNGmOJ; Mon, 21 Sep 2026 20:05:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8AE1480D43
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790021125;
	b=cdCcIzXtmyoYU5FXdaRG0lkZeqAcRmojwtnuhmiq/tB3iPbVi3fgxuSXKp9RVOBlpGl8
	 vQwk8GDs3EBBe2Shk6Byuvm1Sc6C5HVmYYhPjg6NoBPIooOWoWGmnzt2sd/qTXbQSSlNA
	 i2mJaKyt1aGzHWwlORU8ndY9Q0sx1TaH4cal0y7BRChRbnUUSsKrnreuwCM2WJrJ9mKqt
	 h9P38v4gmVEeEmKpUIJh5bBhSC7Mcqdq1e60YyLdyS+1ukhrp68ER9t8reDxQ+J+KGMTG
	 qCTJXtQEfLrNc3Ro1REvfjEhw8EoVZ8tsuyr7u6Wx49uJYuEhvs1VtNQMQ4qd4gcF/g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790021125;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=krOMjPc0x2E3G7tZnpK3FW0IUsUaHHneGzEgshWNFgk=;
	b=XkCM2lAlU8uxNJ8ulL3o77XlcCfzVaKBxK4a9B+6bH0OgmzK/V8Z4uPTtYqgPFD6WdVS
	 Qnc3Qfd6euPIxdAmHmTVbYXkqHq7zySXg1tnobgHbyAXMnTQuDoM3jlUqJfeIN3BEI5a4
	 6Z5RMNecmzopccGxqUQajLD+GYASLEE97dYygYhrK7gnKEpJgO43rzc4j6DJZbcoypqRg
	 9Yc9/tniK5J15Lbj6y5eeF8TPmtX7TEMe5k+o3m4bpQOmcBm53WP6DeR1E/i5zgtiolFQ
	 9jOxvxvfhSvxhcZFDk3+v5pIiMQfgBd+ZaKYuoaMZQOf2fGRMN1mNKWaUYHcZu1uThA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790021125;
	bh=krOMjPc0x2E3G7tZnpK3FW0IUsUaHHneGzEgshWNFgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zj/e5IaDuzoNkXu8onbelaVIdvOpfVqjrFwBMcnXwqd5J86fZRf1EvhzpJ4ZzTEuT
	 Gaj4pH5xB3SXbIaX3M8XcVDBRZPEdCiah6rnq3GViRVRhYXa4ZJJwvqYUuaNi45GjE
	 y/dyg2m6qUXfsZcEh8x92tIXUyHexorhxgyAQuNRarQnS+N1+785ATrM3MZkDSr3l0
	 bDtpibCjJDqVm+/FofsuXXC0atD4fSCEA6pbPT/k63HcKG8rwCs4/godiY5hhRvjnl
	 pGLoHJuRtg28rQbhLD/mvEIartu+wx9fObyAvvUvkrbRb35+NNDCupLVRwoKrs+CB5
	 V22Jt297ONrUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8AE1480D43;
	Mon, 21 Sep 2026 20:05:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C264113B
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 20:05:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A87CB40177
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 20:05:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kAyQShPs6Itc for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 20:05:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 1C51840176
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790021122;
 b=YAQQQjEVnCBMPj3SrCPaxDx8mmopmosIkUIisk41K6snfpL8VAR7ntwqs1rrbnwnF8dc
 rHVs8jjQqEFlj04THKhQK722TaZb8tzZPUBwQPGJC4t9XCv6LyU+8qlQgmnNp2ROUWNz5
 l+h5UkTGD19HR8FT0m8r67M9brpp98kl+dKB30lIB+HtS8xlpdi3rs2YXWHdER3pKpvE+
 qRBXBDjtCJFYlQfPjhgHOIZWbSHQtYBv+67gRYl3hsZmqQ0hyPNKQZ2Qu546ESVtOEv3C
 bBRfbEL5FgLdYrtQ/FWfFX4qb3eNV78yrnyen9W5B1+mtQWpht3eVAVRncUYiJu7QCA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790021122;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=krOMjPc0x2E3G7tZnpK3FW0IUsUaHHneGzEgshWNFgk=;
 b=rGXl3xaDez56hZ7Zmg9xV3p4gWILP3fM4FRAI/JnOjL8yB5yC/9Yy0WBAWif0u6Ea9iY
 EWct/uxAAjI8sZEq/rIghEK6gIZMpb/v26jFYKdID6gNCPtEoek/Kocy6eUj2ChHFsxWY
 clW0C2vQgwovGCJlggGjcUzpNzLbzMJe/022OFoBMQzecCdFQT0i+EU0WEGJttl9quLXU
 5c/HQhU/Mra9i6BR9kbvZZYjOAbJdvnzYC3zvp+qFm6OPGHuLoeII4Q+vImUjQss0AfRY
 SSbwFFpAieLEYi+mKvfBQw+pE5PC/Dt49V3XwqqH2yXUuILk0O6L2bDp7FOqYcp+kiw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=jnwGLHFz; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=jnwGLHFz
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1C51840176
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 20:05:19 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f633ecdeso2943880f8f.2
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 13:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790021118; x=1790625918;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=krOMjPc0x2E3G7tZnpK3FW0IUsUaHHneGzEgshWNFgk=;
 b=jnwGLHFzFIbT8AhZhh0ADKcy9tYMN5pp5BhsJI1Zm3cknUQzmqyLbe3ScJ245in0iY
 ht511aKWw7JV/vppApRD83YZcLokEk5hnorTKgPO/1nFTGV+eL8Vk6219LdlLvCZaoRv
 3QiLRMFGHrVIhdvGSwz+I7qu5YWab5htZ+gfWszj9LhhHMCxUxO2YXebFRcOddGOJk6i
 SCD1usVx3UoZJCjThO7Qpd3/UaP1eLblb1MFAkrd/TaSS6b8Dfj1KtbOPpGRgl52QRNK
 b2zT0piHreHeFQRuaL/gwg15pDIrYUSQAJ+yczeKiaAw8iR2spEN54HYYgot7LiQNKYp
 WyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790021118; x=1790625918;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=krOMjPc0x2E3G7tZnpK3FW0IUsUaHHneGzEgshWNFgk=;
 b=gpdpnRb/FhZWIKv7tODgdM1/bvHHR6yPf2Qi+eJlQ9hQQrkAmVvmiTEng4EBnQG5QY
 PKOLvakp+mwl5mDIGTcfsjm6AgRbk+x5rNPvwI9jhLKT7E7EWbndXNgXtmOMZPBFeaDy
 7xK1ShvbIHZS05ORDOH1C47M649++m1lFUzMEk6799lir6KG7Jr9hXmfsMky6XR2SyWr
 jpSUlDPCPZDmWAmkfXznAKkQxAVYhvF65IQTStp6Tkf9vETLFB9WQP/M/rd+2gI6YETP
 L7bWN5AJN+foA/bwwvsGZ4XE0UBNfJXccaf2MXGszvTVvlx2hkp35ZvBjb1LP0U8vMz0
 Mjdg==
X-Gm-Message-State: AFuF++nG+qChr7IbeyEu51vAyrPn4Sjg56jiO/wZRpk4qlZs1D/XYD6T
 4HYYAR7+UkfWnoRlDCRHJcSeUITtcJuXfWDG/eQP5aLpl5nA46LpVft9LZ+c4Ko1scY=
X-Gm-Gg: AYBFou2oqY4FeO8IIqrmiON+FKM+iZikZDXOY5OgVKCnnhyAgxl86V8PZ5iRuGBmUly
 sy7AxB6o7Ufh63awkg/rLgeUz17msPKo2BdeDQq1QrBtPMFRGIJS4E+fD7ydPvAenLGE6Hy/Tc8
 xZ79v17bOT8tAeN7uiQyk6h2njEW1JMH2wW2E32w5vwo/Of+9Vyl7S0W8kq4i+Hzji5i9rwO1Li
 MFTmwkZdmDfC9LZVroYrb4apJlwCCfAC4sWHtpOb5MXYvahLW14eGbvBgYaE9naSBftxaOYdNVt
 woWWIoeKPx9LZRPUiyelCUeWcNLmbnf1PS8wZ427fwC4/Y5n4VoyojL3oPVyGdFm8lipMpZeCd0
 vEyHrkvRq8zAO37e0dCj6yXi5sfAbs2cAt6u/NSAWxy29q836dJSbQozEIitDw6KwNmCS+c+1NP
 9P/X34nFP3otTNj9eM//mGWSQy1MGilsTQ47h/D7+b/h3R0l8I4ObJCj38+k+PH3vLriQGxFHks
 4gwR9aCBwdqVZNpX7kz9wVswzFxMhkJQmfcv7ksfx6cvJby1cQfmOYoX3D64tPQPiXZkM8Fj5+I
 RVg1546ucUMQGrI=
X-Received: by 2002:a05:6000:22c4:b0:485:aabb:af2b with SMTP id
 ffacd0b85a97d-4871e21d419mr17190583f8f.24.1790021117863; 
 Mon, 21 Sep 2026 13:05:17 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-232-147-181.retail.telecomitalia.it. [95.232.147.181])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-487245a869asm23141306f8f.37.2026.09.21.13.05.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 13:05:17 -0700 (PDT)
Date: Mon, 21 Sep 2026 22:05:15 +0200
From: Carlo Caione <ccaione@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, 
 uboot-stm32@st-md-mailman.stormreply.com, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Alexey Charkov <alchark@gmail.com>, 
 Johan Jonker <jbx6244@gmail.com>, Richard Genoud <richard.genoud@bootlin.com>, 
 =?utf-8?B?Sm/Do28=?= Marcos Costa <joaomarcos.costa@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 David Lechner <dlechner@baylibre.com>, Julien Stephan <jstephan@baylibre.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v3 1/2] spl: mmc: select the boot partition after device
 initialization
Message-ID: <arGNB4QpzpkZPfib@macbook.homenet.telecomitalia.it>
References: <20260914-ccaione-upstream-part-dynamic-v3-0-a38c19e74563@baylibre.com>
 <20260914-ccaione-upstream-part-dynamic-v3-1-a38c19e74563@baylibre.com>
 <20260914163557.GA1764417@bill-the-cat> <aqhe4KnMjO2HQiDA@macbook>
 <20260914213307.GJ1764417@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914213307.GJ1764417@bill-the-cat>
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

On Mon, Sep 14, 2026 at 15:33:07 +0100, Tom Rini wrote:

[...]
> Reviewed-by: Tom Rini <trini@konsulko.com>

Hi Tom,
who should pick this up?

Thanks,

--
Carlo Caione

