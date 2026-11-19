Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED24606A325
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 22:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=t9bpUE4D;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Jzxr2uq/
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C5BB815FD;
	Thu, 19 Nov 2026 22:26:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lFTji8JrqhnZ; Thu, 19 Nov 2026 22:26:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 79B34815D2
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795127214;
	b=cchbEXBXH45Xxh5wOWMTZBVxpVOHqxQahGqhmuO2AKjRkvzjAs1w4+A9NPJgHmWw/zhj
	 4d/zVfWrFtBWtvfBwBouQakKVK2+tgCZ3WqtFSDvSRAszQXlbETcv35CFCT4v0ouF8Qi3
	 Jey38USr7btU+KIVIvaygd0OtUKO2boTztmE1O3SHrVDpuCT1mqPWbJfnGme9zgYJ/RNp
	 Q5jyFLmYn3McIIWAXB/qhhXq0cAVQAUi4c6aQ3a89gdv5lbvl5Ossi47BxyQTtXSiZ/t0
	 YBvQyCfnVXiGu1F5DT7o/AFOQzPwFWUOhctW/GdBxI36kl0qTa5rZgsC5xKPiUoXMwg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795127214;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=lZqRHL82eNg+IOt89lcAe9pWEOmyrzAu0ckVEk8LL7M=;
	b=IJOSjQbKqhMBVl3HtUKnfVx3mQVQektqXdQPrWiwIK2nZ60xdQUmHowYyWpyeOjzPdDF
	 hEtSzyg5dyEReErkIcxtfS2aK+b/f/9LXTQGPaSXVh1JvmAf/enBKsfbl6whyeoY7IurE
	 4W2UOaAGjv06xDxXpiY/iYBy7HJX9N+XGL8+bkDaj1Kx8w0ZLkP3nD9Sh6ZVq2fmecDl7
	 GelE3ZS+7YulqVUyWNA7ZVYOZpvWl7T3qlz3zdiQiAsWSeIRzJN9qMnWH05vJemmeWeov
	 UOQKl0bV/t+d3hh8Nd/ayTqoLclnvQZQ4TxnHVZocodPkIV9Ua+Rb5Y9j7krVeemYVg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795127214;
	bh=lZqRHL82eNg+IOt89lcAe9pWEOmyrzAu0ckVEk8LL7M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t9bpUE4DnOdRCiim3NBRXuN1njsRFjME6Q8Rwbi8iGcQxn5BBQFEnEF6uIMoJCkc5
	 ROY13U59qxPeCFSBLvXUQ8vzNeQrv5M8IfPGbKseAkETgtN0NdqoP1QWfK8Ynr9ndj
	 ba0lO9aQBdrT5lu554+cok56kv7L0GgStTh7Si2l+M56K1PnKQ4hA7IHMiLf99VAU+
	 oUXpYTjvoeN6ShLSyPSW6K3JZtAaWg4yk/S+BZlE3cNYecAChi8dzRzrDrJHerKzSw
	 kGrzVK4Y8CjcLpNnZpxw0lQOTlXjf5Y1bzKj8t4idTzqxCDygz2l75uuayn7v3qj9O
	 NdA99cz7wrWwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 79B34815D2;
	Thu, 19 Nov 2026 22:26:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A2BA479D
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 22:26:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 929B840DE8
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 22:26:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IzqjREdl1lU7 for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 22:26:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C841540E01
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::336; helo=mail-ot1-x336.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Jzxr2uq/
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C841540E01
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 22:26:44 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-843cf077f10so386042a34.1
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 14:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795127203; x=1795732003;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lZqRHL82eNg+IOt89lcAe9pWEOmyrzAu0ckVEk8LL7M=;
 b=Jzxr2uq/WdaQZ7tccPV802OG+2NnkZnbUM3hV0qiga4/pJt1CZkGp8RVOhxkiuIFT0
 hObQxXlVqNqcP4TjuTzqZhm1a6F+tHE+Y3k7jhv6YZ3SpcPMPPvL9kkADMQ00+rlS11D
 Mn4hZGB5tE1PjZj/3FCKmBXhwP2VcIN3tRmHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795127203; x=1795732003;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lZqRHL82eNg+IOt89lcAe9pWEOmyrzAu0ckVEk8LL7M=;
 b=uXNX77jXPTyLpdvk8MEjxkBxwHLSiBdXv6dfGFyCl3EvkGpp6lrrE1VCs72DywHcAE
 LQ4Dut8vW19ZBk9urTBWZJG7MyvA0g0wUOM4FiX/aU3ZQFOeeUIG2h7+zzzw3ARpR6Xn
 95HpJRK11KelrwZDxnLDcJ+U1Fk57NMDgol+iZT0EHw05bjVHF/VRBc6Hw468Yaq+qn9
 0uGdN+KMuwPeLkgR23QQvhUH/lLGPpYaX9nGvbpMjDLLr3ImRsl3WnCizYxesBd/6hX5
 jFnIPjjzyHmZ2+J9EC9Dnaw/GF1o1e7Rdk4zy4CxwEDBfoMciPzmkCeUjkKXUUGndffH
 KLHQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFMVZBes76LW68+nj9Uj4hIVlNrpyvk4NaHi/JWHugbZBtc9ZPsFVtVWLylcPY/DBRED7VI3oU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+VFBdLA/rIwbpUjRq4HdPCKEzoh2vpJJhWbkz+oC1TgQmS8rMQ
 Ij/Q2N9E5yGi2giEb3ljq2dvK3xRkGjFrbIpu9ZZMvihUn6NBE9LvIKKbyV93gKjHzhCEYal5s9
 sfiSyDZs66A==
X-Gm-Gg: AYBFou1nJgJU5WH71Ou1q4hb8GPVZEaFT8c9qogCSTOSyDIJHHNOm0seYo0ifQm3xlI
 s6ubyAi05oDAMuAdBivCy9tKV4WIXobZVHJONiCoyXTmB6fawqfo3I+X5OFe10vC10s6DecQxm8
 X6IFWxEvjBVg6DjyxZhCQJjtTv+huyhSKiNul2esN3CDVVZfNSTQmS6C49WLHO+iTGaQnhYI0cF
 Jm/jmaM2qxVTAHvDH1U9ORqjOIqsc2l3+0tORnxcHBJJvbE2uk90BvUVSY2ePUCoIezcuKyqVqJ
 GXHOAsdB98zyRyLrTr+07VyM5UA03+bmnIz5lc+scUJKQK/E0veNcdb8bk8HDwZ/oNloFQh6uhR
 xMlAD7OrpD+J9Xvhe5j0JROXUx17Odyka3WcUoJaQcCyYfy19R40c3Hoqk8Uw6xiQ2DP3Ekoqhn
 RF+VxxXxHU7YHsOi7qOsf4rPr9zIle+63z+qfrBOQzsOOjipQeVpHXV/T+MK0EkL/II78GZPWfL
 YLIe5y9AKFphKD/ZeRilXkHz/C8IR0E/PRfxZhFYoFx3cH2wTCuRY7DGYxO5jXyIfMCJWLDTPVZ
 giGdi3w2k5r94raSxrf3ANzDacXA11A9MSl2TDoEDj0IKGGXwxzM0CiuvY9qrWum/heOxdRDKAM
 9AjX1xofwNtvS1mMX+coMYNJ/1goxk5eGlqEPXgYs7n8EI1tnE3H1DYYD1L6RmevRVl1edV6DGs
 6ZsYKm+Gi0IeMXSQkGEO+bQ9J9W6l6/VSZeKCYfCRQBYiMN3Oq67g=
X-Received: by 2002:a05:6830:82f5:b0:862:9deb:85c1 with SMTP id
 46e09a7af769-863157866c6mr1804360a34.14.1795127203466; 
 Thu, 19 Nov 2026 14:26:43 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-863168c1bc5sm649069a34.6.2026.11.19.14.26.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 14:26:43 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, u-boot@lists.u-boot-project.org, 
 Tan Siewert <tan.siewert@9elements.com>
Cc: Lukasz Majewski <lukma@nabladev.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Pedro Maione <pedro.maione@9elements.com>
In-Reply-To: <20261111-ast2700-clk-scu-v1-1-4e6c71b1cb0e@9elements.com>
References: <20261111-ast2700-clk-scu-v1-1-4e6c71b1cb0e@9elements.com>
Subject: Re: [PATCH] clk: ast2700: Bind the SCU child nodes
Message-Id: <179512720267.764313.9044766186227635392.b4-ty@b4>
Date: Thu, 19 Nov 2026 16:26:42 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 11 Nov 2026 00:32:22 +0100, Tan Siewert wrote:

> The SCU nodes are bound by the clock driver, which matches their first
> compatible. Their pinctrl@400 children are never scanned, so the SoC0
> and SoC1 pinctrl drivers never bind, and a pinctrl-0 reference to a
> state under them fails silently at probe.
> 
> Scan the children from the clock driver bind, as the generic syscon
> driver would.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] clk: ast2700: Bind the SCU child nodes
      commit: 79497816056122c49b3b135e14cbac59374e636c
-- 
Tom


