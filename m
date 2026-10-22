Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6E7606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 14:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dgjkPxy9;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=JVf32h8O
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A37A405BB;
	Thu, 22 Oct 2026 14:19:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WR24y9SFNblg; Thu, 22 Oct 2026 14:19:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 548CD40904
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792678777;
	b=CON1qzmZZLOE/KY1gdt49BcxF4H0zNWKy+0AyOm7LaIle0M33mp/Y6dxu1kW7zTlu7RI
	 xlLiec00ZuHhmD6lywNE1F3tDvrXzEjkRIIbPLzd6d8ZFCeufmGT8amhZjFr0Gkq+11Dn
	 ZUyaVAaXj595dmgeicF529Jo7XH82ZdcdPJkFSmUCOJsDuO7RimpnHY4Yy+gKkD5CGL8s
	 6nAnw1yTkLOOPyW4XN/rJDelgB8BWwpl2GEhfNSL5rFcy9xmZxQ+liP5UiLD+Yn53ljDZ
	 GE54BdeC5J19UrZ0C5+cI5LQM1mlOpaFHHVuHvjTC6ZhhD/QD/L6rfpmVFlZJMNM/GQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792678777;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=8ukqgbvlahRSTFpxOQT00lcsPu1cJNHM01TUbkMEI00=;
	b=sUECcnPn5bW6/1Tyjk6M6NM+Bt0kkBfwFsVhRtsizIEfM2YHCbtJ9KSMbmYKo0Cg1DFh
	 JMhXf1u7MDsi2inD0vEAL67PoDv4J/27xsr0nUi5X2AP/dfDmpd9Xmk5/3WVCrcuSjHJ5
	 yzjfH6m6nDUTEhv+KaeIvQySZ57daFtiN1NGCsprwffNY4jqq3w/HxkoyvTYiKh+dZcIs
	 dW/O7dI1uazySjnfkRWejzUXVYfOTBXdjZgaPUQNYwj9K8BPRDLTfCXBHhnXBDwO/eyKL
	 l3xfjhCBpzEBixZP0+Dz9c8nxrKM36+mEdPbL29KzaC7Wb13KyOIfiaI+LcHE3gAndA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=JVf32h8O;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792678777;
	bh=8ukqgbvlahRSTFpxOQT00lcsPu1cJNHM01TUbkMEI00=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dgjkPxy9wKJvZDKkctMfOgslqoXCVAYX+qZ1yTyqYfIV+aWbpFfUDr1MkmKQifW0B
	 690gC6WbGm+xxer9IIdBLc6xdcem2sKhujzGJYeLW1x/Wq54zUkF3mxCCKSQH/uOOS
	 RekfgFtKG2+lifuAzbF2gLRHOSVBURFyHaDl1nglStaX65BeACTAsYC9/NFxe58ZhK
	 eVwc3BCXazy8mqn6x9FmlN/+kkrNMpHIwFdIJOH19+Kcupp57a5lxdVVN1sXrGl1dn
	 ZAvUm3iA5vjigZ+bBYY+TV4071/Lo+tv7wIEfnUV+itIYj4LJ3XLG0fQC/7N5mKHw/
	 RVaQmUWu9yQ5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 548CD40904;
	Thu, 22 Oct 2026 14:19:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E70CC2A8
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:19:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D92DB405A9
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:19:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GO_ndXX7Qaqe for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 14:19:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AE6C64054F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::329"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792678764;
 b=Z0L3y19vCboAb2zAmCZ2fa1WzVa9Uj//FFxp8YH63Q6XGLoCQBm9K9lViW4MbZM1eJdX
 Zk9E8FDp59qMpPwHDt/lUPaBUN0XqdhZZDHnOYZqojydkJTw6bRsUUNtdAXmmADy7w5sn
 6I07ZKayFeqI6URQkSSXwaFf6Hkw/Nd0s5BghkjHy7fvT+qySQMxFDy6thrA17TNFkJnA
 +K6E2eATTQEeLbaPi1sJx4eGtDrJ5RkxHPvryz1Tz/K4ECQh8CPghtR/YKtRcvQJXz+a2
 4dFfpspN6p6IBY3FvBsoFyRG0Y7AIYBuDJyaIyfHHTqcbzA86jy2mvWvYIEtuT3SNlQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792678764;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=8ukqgbvlahRSTFpxOQT00lcsPu1cJNHM01TUbkMEI00=;
 b=J4jWGBbPRjBdD/gX4jOScvYNeuhSDxnzesoMYxDW/2L86+urLutUdTSLTVpTC8W/VtWW
 h7xWNNPAtu4Ivv/FdXbmF/HSkgEmh4NHXWfZ8OAT+mEx1/eOkPGChe2UDNwYPeuaxAIC7
 sg98jZAOeVPGriXKEGgle36WGpqXnS2urUf8V1ynQNbfSoWK2Hv3zlEzHOrkFP6NpPTpt
 thLc72OazIcttGU1OgfktIkaugfeiYFmOsHz/myo/U+rqNqQmBviPs+84gyWwQ4Xf4U2K
 gVCOENSrRzyhbtNPcEQlkq0SmaMFtEwf6KPg78mRFH9JZqLEMcaNaKOu30N0StpkUng==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=JVf32h8O; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=JVf32h8O
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AE6C64054F
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:19:24 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-81ae6aefdceso1833916a34.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792678763; x=1793283563;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8ukqgbvlahRSTFpxOQT00lcsPu1cJNHM01TUbkMEI00=;
 b=JVf32h8OITPtFdtGAO9Ge5PJ0pZVzTKcks2BCTkoXj38BrNrvuKq07uyY41ASeFLAz
 e75koUcShyXyjps1KWDpMl47iuGtwMeWJh3giRaQB9SPRZaC6tz8d7q2uIM3UUVO0Hdr
 hLLg21q4zkOyKOZx2kiS/M8fWKWrCe2ur3HaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792678763; x=1793283563;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8ukqgbvlahRSTFpxOQT00lcsPu1cJNHM01TUbkMEI00=;
 b=pfSnDGaiYvAHLIy/jIDcaHG149SHJG6oJlTIWf6YkyvNsSO2fDxBNIMrxdvVA0uA5W
 9mwb7z+Kw5Moeg8T8OQQ4WM0ryo8S/AB4LtKYDOON3K7scjAOrd8k6y2MXkqqbuG9wUg
 Hx2EbjNUrCtt9qI27qwSlGIi+/8M415RYoRLgJvJCIZ3MtanwAcrsOqwVO85P+T7Bukn
 kySfs0ETXiZbXVlQYOh0yBWia+XVc5CRKfgCBovLB77cORuZeF8fK6NThiY1XEoLpFt/
 6RkJL4OeIEp84480fUZCuGtEkAYXyFw8IDs4V/yi6YQJd/C9w3uIQlcZdUlFVnoDEarL
 WixQ==
X-Gm-Message-State: AFq9FYIW8iGfD4yvYV8mmXuhLGk22UURW7RMQSEDu4byhUYQew4Ijlu5
 VDN945+CfM349/UYJI3q3T1xFvClpGA6hgwM8t5L71BPe9r1e6dx5E/im61iXhHf1wM=
X-Gm-Gg: AYBFou3Qzwui953nkouhft1vazGWChDPKwEjlKK8pQcR3IVL+DTC9rPi8vp5RBlbE5I
 OjNdJO68mhT/ahSUSL8V88kkM/wdPmWjnC6yYrdQbJ7A3hZRP7Q5bK6PB36r4EdqswgwhIDlUt0
 7EsYk0APKZSXyGGY0C3rbKCwj53/tBhXHdvvEtyBp4wy/2cC24Qehhd3vwtd167BH/qXjVwowUq
 /U20/PAiDctN6NLR1Vpho0l06VD6PxiN8lXnVU7qyDhkgkmFWJt5ShJQQpsw8crFRqU5Cw/0B/+
 NsGhJ6LG+zwXESatjx/3jKb1M6gqwNWf/uEoj7z5PDhub5JoXDbIqAvkZAGpRS7mOVpN11QTwIT
 5uzUGZXZgVUNax7vIdU3mo5DtBbqWcuXPub1+hZ2FVoJlKcjehaL7IY9vwOT2skAkAzxLZ9BzVl
 cbmqIf/7DDZUQGakg9AE/ewV8yO6aXHuH0tjNboa8CO9+mJPoCDQw4egC6l/mMAe0DMkV7XKLn9
 E4zlkYdBiEv+3lTb8tZZwGkf10m1hWPpJLZvv88+AmMMetwJieMwkf1AO6wWcKtaCjS2jO4lB1O
 Vp/1N0OIIvr0DV+NvQwg+vtqAs3gWghCBV0xw0jRn0rFDD8mHHBL+c0dywhpqZjyBFTRRqB5tea
 X
X-Received: by 2002:a05:6830:440e:b0:81f:da91:c984 with SMTP id
 46e09a7af769-84d08900a29mr4607285a34.11.1792678763356; 
 Thu, 22 Oct 2026 07:19:23 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-84cbd2d2a76sm5506744a34.18.2026.10.22.07.19.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 07:19:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Petr Hodina <petr.hodina@protonmail.com>
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 David Heidelberg <david@ixit.cz>, Simon Glass <sjg@chromium.org>
In-Reply-To: <20261004-b4-framebuffer-stride-fix-v2-1-923af6708491@protonmail.com>
References: <20261004-b4-framebuffer-stride-fix-v2-1-923af6708491@protonmail.com>
Subject: Re: [PATCH v2] video: console: clear rows stride-aware in set_row
Message-Id: <179267876269.3588521.7925917538837117945.b4-ty@konsulko.com>
Date: Thu, 22 Oct 2026 08:19:22 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 04 Oct 2026 21:47:24 +0200, Petr Hodina wrote:

> console_set_row() and console_set_row_2() clear a row with a single
> contiguous fill assuming line_length == xsize * pbytes. A stride-padded
> framebuffer inherited from a prior boot stage (e.g. via
> simple-framebuffer) breaks that assumption leaving stale pixels after
> scroll.
> 
> Use video_fill_part() which already steps per scanline by
> line_length.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] video: console: clear rows stride-aware in set_row
      commit: e16958bc076d842df20c8ea96d9fbec479e54459
-- 
Tom


