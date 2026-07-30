Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8826EC55165
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 13:38:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4A04740AF0;
	Thu, 30 Jul 2026 13:38:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VqRWXTlTWKqr; Thu, 30 Jul 2026 13:38:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A519640AF6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785418731;
	bh=1X3dHsozQHse/m8Aspm7ZZeqcpU6qXsoO71dRt/Dwo0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AB8NMFROKNJHQnpAornvh/5VJzA20B9oys7kZaJzbEhzM9FefK4tOW2JDhtaylpMA
	 I4wjkwYeeCMbIz/6lQGOWhbydWCn8wm1+qCS8jLg2WHouRVwfd33VJn18+DBrc2Uld
	 Oos7sUFaD3U+AH6h9xQFvmMfbmKgrmqI/EaJEZ8nirkXG5bHLrv2spS86uxsnOTRP/
	 mnXPLIoOPBZaeO80jwj3piKXpoNEHdEhQATV1WsSQdS21zltS5gvh/pPpvlPi1x7GI
	 8Z+d1gAD0G2hH1EQBu8pflVxC1oj3vWDvCGzh/PMXndwEJpTF7OB25A2h8qNrC2m82
	 9my/JNT7JhjBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A519640AF6;
	Thu, 30 Jul 2026 13:38:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E040C197
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:38:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A7CEF40AE5
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:38:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id evWaLxoOUu_0 for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 13:38:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c32; helo=mail-oo1-xc32.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A583840A83
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A583840A83
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A583840A83
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:38:44 +0000 (UTC)
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-6acbf97e9a1so365690eaf.1
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 06:38:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785418723; x=1786023523;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1X3dHsozQHse/m8Aspm7ZZeqcpU6qXsoO71dRt/Dwo0=;
 b=kh2vJIJUdG3tYnhXFaNRgqjLClbuF8Aw5Ptx7W4jpqJ5MfB2Rlw8S4kaB9Xo8CBFOV
 WdEk5nmBAiKBe+GTw6RadiXVad3wp2U2mMcVTU4t/mkF9+TCKSyTJufghmmCEwlePXyg
 v3iE/vJ/CXD6ArCcD2m8DSwVIBS2kEPaVdg3Inih5psOruIUhgtXdP7WB5aDB3l1oYGY
 vUpvTCkzD9R9rcj1Kk1SImGc2zKmELa8Qd3mWu/++TY2El4mznKMoKKaiHSccbBuWL0Z
 rOLHlO7IZW1cRGlqmNi2ZlWANp+n/O9JKm8ZzH4MqFsuWPJXkN5aYLXo7tU8UvLZHesG
 Fghw==
X-Gm-Message-State: AOJu0YyI1kMa0w7aEni9uxe1QC0oaDuYlLHBXAZFI0Qqm3LnYY3rAEuX
 5ypTJZgy/c6RM6zbekw2zABG+7NUas0zmN22MVjWD65rCbQuZkRarBkqu0pIhf0jWQ+bXSO8iYZ
 wJwjf5Ko=
X-Gm-Gg: AR+sD107s4duG+yvMVsdaDusPnxS4HYqp01dr4O9f/98wCfmTqxWUH+ZGX+6U61JZQX
 jJEqhn3HImKtdw90KcidhKGNM2LmAk8UnPY7vk614+7cWKkDdDRj9w/A+JHjf3A3fsK0G4I9Eza
 3p8tQHMMXd5B0wPF7Ewebqp9ho2vtPosxa/w8bOaszl1aXPfjeTZ8cuivU8Ando81WqqDH0PdxB
 tOIdhadYFGoni3v/WAPHZluJ2kYWxVag7m10e/M2cHzbEubTIkN/4jM0IuSnGJ0xL9DsWR2GqzC
 S0AB+SyKm0fxVuWpVgnGNj9BQdVeQquORut/R3SdWlDPhsoS9bOTc2BcasxNy83SseMVPGum4yi
 dusBD7z1+U5JS7yq5dtMx8VMU5j8VYA2v+EzWb/BEA5Mn8zviktCdXW3pnY5EE13snjMs3PEHj/
 th0I2bcnXgt5y9HAIhGB/XU7hEEorkpMYrP4tWbzoPL8FhAbLh8dcUfRmblK5GINyGaWHjobEan
 UYaSomOXO4krk8XXzDFnQwagkYi52mFBpnJcAZ578/gvsZwLxF6LAvQeFiQ1Hd6SZ/dq8XDs5pt
 0J9Fw4KgVEVoa6CAW9E=
X-Received: by 2002:a05:6820:151b:b0:6a3:87fd:2130 with SMTP id
 006d021491bc7-6acbc161aa7mr1544776eaf.67.1785418723570; 
 Thu, 30 Jul 2026 06:38:43 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6acbc554a5esm1457983eaf.10.2026.07.30.06.38.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 06:38:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 James Hilliard <james.hilliard1@gmail.com>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>, 
 Vincent Jardin <vjardin@free.fr>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>
In-Reply-To: <20260721031123.1949018-1-james.hilliard1@gmail.com>
References: <20260721031123.1949018-1-james.hilliard1@gmail.com>
Subject: Re: [PATCH v6] crypto: hash: use DM providers from hash command
Message-Id: <178541872170.2173019.13597581873722309368.b4-ty@konsulko.com>
Date: Thu, 30 Jul 2026 07:38:41 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785418723; x=1786023523;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1X3dHsozQHse/m8Aspm7ZZeqcpU6qXsoO71dRt/Dwo0=;
 b=ZkkFyCqPzMWGY7/OXSoX/qs06FtTQ0cvPcmZTMnsBQ8ugLdKJKt4Wqpb3Czw2ZYsOR
 GPqn9ABa9RdgXrVWL5FBaP522H/mD4d2VG5B7+QAEAjjBy6VBQjRvZsw+qnQ9DCEl1BJ
 tAKfIrgirDZIJ0Jjl61tIAf28KMs63nn+L2vw=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=ZkkFyCqP
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Mon, 20 Jul 2026 21:11:13 -0600, James Hilliard wrote:

> The hash command currently always uses the software implementation for
> the selected algorithm, even when driver-model hash providers are
> available.
> 
> Add a hash_digest_wd_lookup() helper which probes UCLASS_HASH devices in
> order and uses the first provider supporting the requested algorithm.
> Continue past unavailable providers and unsupported operations, but
> propagate a hard digest failure once a provider accepts the operation.
> Remember probe failures so they are not silently hidden by software
> fallback when no later provider succeeds.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] crypto: hash: use DM providers from hash command
      commit: 94b349bd902d9e38e1846c157fadd9054c34680a
-- 
Tom


