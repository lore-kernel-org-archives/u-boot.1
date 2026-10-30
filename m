Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8932606A31E
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 17:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NiMldODB;
	dkim=pass (2048-bit key, unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=Y7E8Mcg+
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B64DA40BA1;
	Fri, 30 Oct 2026 17:18:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DHlc0Vj3qQX2; Fri, 30 Oct 2026 17:18:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C3CC640B86
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793380692;
	b=iz240QEYVNekD8OK7t4pZHKQUOG9WLRsSKD5CVbUHMfNGkvrACgOBk1ntwLQtC0osr0d
	 omUkw9toOgMGkTv6cM4qbnXsXBBVk6ZRdvK7L0Hte8caoSx4Ss56brbQ29RnElI2Pjztc
	 P7WtneLTRajHb1mpuYpCqJEH0JrBFfJkVHvKG1G7JCVAiA7cHsyslXf0e2PCgGgdSIB4+
	 Rb7xx60H3hXPq7aFm4LWSvEZTHs0PEHfvUbgakxABrZvwvGhz1BAWOwrmk4s0HicQS3FE
	 I1D+iETKj+dM9In+dSVinLI16ZMPy7rmLo4xumzUmdQI4RiGKfCaFMIdihrHoMwyUUQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793380692;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Infomaniak-Routing:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=0RLwoLhkubsMfpP2cOMR0F4RpznHPz8xW7/I6Pivb6I=;
	b=ndMKhOtnVZH4FzdToNzAW+5LcXQsPFa0MtNhUhp4J5O+uZmFEsIftNzBZrmEDnQE33pp
	 re+d05BsZ5P+X1stfE/KMIIierx8ut/ONMIjZs/zKm8a2hFLssGVSnEQ/UEjubG6gvM++
	 wtJaXPX21iYTdB7fvWw6euKUgfTnAC/oPx4L6fF7lEn0k1NnCkq4+aEmu+HVVMbFgeNp+
	 mU2svUDXb+or/fsay05C0+3wrFuRmDYyux+YGAWYOf5tzJnVsES4mCAett6YRG6wbsLRa
	 fj4NUDV86M6pGZla6rnww2t/nlUupTF/TVeVWj1FsXmWhlHWj3QqlGgK2kDgy0a3NkA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793380692;
	bh=0RLwoLhkubsMfpP2cOMR0F4RpznHPz8xW7/I6Pivb6I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NiMldODBFELN7Zx/fwaYNbmW0M76C/YsH96pgvWqWvPN+90bZuLUNijZD4+0QMIge
	 n8T5r3dZanyKPQhtznqTbQosnqfKJETvZNjPIn9y+9dOuPznk/oJMTBiGbM6DbDA9X
	 Ebiz3EHUyyiU4zt/eG+sSNjMpBp7WAPp/PRVZS5oBatSbpM4A15g7JWcrJPI3vFsHi
	 Q+QAuBG3n3iaUK8qNzr4nZ7fPV4iLEDFlHQNyiq5terwSNJlxMrVkrW7Bm5zr1VhAC
	 uwnNXq1MVGFTNe6LLwAYpblgkqZoAB09i7oaJRMixi8zJ6zfGMCOdq4bU0lgHIEG4w
	 KIJcG7GFLMkwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C3CC640B86;
	Fri, 30 Oct 2026 17:18:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5CD56411
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:18:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4B8C28130A
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:18:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z2qmqptqnHzt for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 17:18:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E584E812BD
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:5550::190c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793380683;
 b=RBm5ASd/qZA92PhE0HkzQxQDdywi/nAqHR7o/6LvkqrLX98TgYwMywbYVR+JM7zEj/wj
 dFxE8gZF0yjcT+lWV+zRZSp+LgDffID2z5cPsefrGGCYwty01/6I0m0fcWLA5aiKSt8m1
 ddxJoQMHDnVvRGV78dlHTESU4jNb1BDngykGSvAmZVyGdm8rEpSLj4AYShdHGFDWQG5fe
 TiNZX1YsEQT92ayMe3YQvWLT1Xuk7IJSBrK5krsd980lg1LhpIksMryQzNHPzED9Jhu8d
 RyoZrkA+rrWPgjG4AyaGiKHOQNNUTO/GIDVM0rXXVqwOId47lpyuQHfZh1G3ZGij52Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793380683;
 h=Received-SPF:Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer:X-Infomaniak-Routing;
 bh=0RLwoLhkubsMfpP2cOMR0F4RpznHPz8xW7/I6Pivb6I=;
 b=Skqw87ds4CLeMA7WeLIHt4+fwUiw+oIzyxw4s7yedad+uGyScYiQsSkuR63VCr1oLpix
 G7MAIe9GRENlzTqP6j1fQVtKcFrG9HjODDseA5IP2jG7DfogiC6NHhK/VarxMgNTlp/Ta
 sOIi/udHmaqJb8AQy5wRf33TuwHw0F/lNVNkE71YG8YrtHQ1l7v/FBBPN+pHxBM1pIKQn
 YD+W1w0qyYDszNGtLDQNnn8iHvHoAgR0jVNIVUGNFoXtDdR+8jnbFBn8HrIDUjNMHt6NR
 8UzYYsPCP2H6dW9O6G3Eo6VNLGR6fykSNfXgy++th8QMWB51UbefGBJcLmLg8zSzwkw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=Y7E8Mcg+; 
 arc=none smtp.remote-ip="2001:1600:19:5550::190c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:5550::190c; helo=smtp-190c.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=Y7E8Mcg+
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch
 [IPv6:2001:1600:19:5550::190c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E584E812BD
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:18:01 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jGSTy2WZdz6gg;
 Fri, 30 Oct 2026 18:17:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1793380678;
 bh=0RLwoLhkubsMfpP2cOMR0F4RpznHPz8xW7/I6Pivb6I=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=Y7E8Mcg+bAFPQA/N8IemYEKg34yCboeFqezVwSiCmuMcVVl/Q8PNiYL9BKSKbf2YS
 aFKQ92rZBy+PV+Zf8q94DqBswUiTZby01YTKqPNAuRPrL0C8/DcH7PnSRRGAFYTeAX
 GZ6+iW3r/D51+FnkxD5UVJn6mzsku7NDaNN5Zq+7jakTYrwyCzSw9+gQYefqdSkqDr
 GJ7VXJbVRxuQ7E3dR0hi3aK0eXT3KVbfX640SaAZ3Q5mh53E+Z/WGKTUCLSfn2I818
 51HmhyxOEwS7fJgUr7XqghMEOfIg7qXeUyhIyuXE4c73rgBPyMR+ZyPS9KKw06FYZI
 G69IMHBVpaJzw==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jGSTw4tH3zZQ7; Fri, 30 Oct 2026 18:17:56 +0100 (CET)
From: Quentin Schulz <u-boot@0leil.net>
To: quentin.schulz@cherry.de, u-boot@lists.u-boot-project.org, 
 Shigeaki Asai <y-asai.0816@docomonet.jp>
Cc: u-boot-amlogic@groups.io, neil.armstrong@linaro.org, 
 jh80.chung@samsung.com, peng.fan@nxp.com, kever.yang@rock-chips.com, 
 sjg@chromium.org, trini@konsulko.com, ilias.apalodimas@linaro.org
In-Reply-To: <20261028020618.2844987-1-y-asai.0816@docomonet.jp>
References: <20261028020618.2844987-1-y-asai.0816@docomonet.jp>
Subject: Re: [PATCH v2] power: regulator: rk8xx: add RK818 LDO9 support
Message-Id: <179338067662.786412.9023930308177381461.b4-ty@b4>
Date: Fri, 30 Oct 2026 18:17:56 +0100
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

On Wed, 28 Oct 2026 11:06:18 +0900, Shigeaki Asai wrote:
> The RK818 has nine LDOs, but rk818_ldo[] only describes eight, so
> LDO_REG9 indexes past the end of the table. Its voltage reads back as
> garbage and it cannot be enabled or set.
> 
> Unlike LDO1-8, LDO9 is switched from the DCDC enable and sleep
> registers (bit 5), and its voltage selector lives in
> BOOST_LDO9_ON_VSEL/SLP_VSEL with the usual 1.8-3.4V, 100mV range.
> 
> [...]

Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip (u-boot-rockchip-2027.01), thanks!

[1/1] power: regulator: rk8xx: add RK818 LDO9 support
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/a7d8b31958518d93f425369c0c76e76109d3981f

Best regards,
-- 
Quentin Schulz <u-boot@0leil.net>

