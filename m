Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A691606A326
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 21:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gwkVoxjY;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=SRKdc5WS
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5F6C1409EE;
	Wed, 11 Nov 2026 21:26:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nfSFrIpfPTq9; Wed, 11 Nov 2026 21:26:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B9EAA409FA
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794432381;
	b=CCyOkv94aGsz/TZtWcMI18Vw+emvQh1CLdzvtPYVTc5XT8m789BbGtILFYSqnzkxPjay
	 VGw4xWVXVUonAxGdaJeqUbI6Hq8eew7N1bL3NgF6Ym5QJJZG9h0gvKfg8Dy+YgCYalJ5h
	 f4Rk8PfyWoNtQWSL97DIWqcj/Uhcfu1ILY66yCF9YTJaXrJvNnD/w8uLAK13vp5AKMgyK
	 NTKY5acAsw5qTV0gzcgYA+i880AZ6NMkt7tjo3N2XonXBdKD7V++a6iHmTrk6yYnESl85
	 lj+onD9T/j1ZhQY0vQwGTJyUQCmU7Dy/QZkfnhMIkajoyJK58CmmiV46bzxJc4pX9FQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794432381;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=i63OUBtxI1yEECdFJ2eDOnfM7ySnjMFF9VSZm3WwWAM=;
	b=JHD3av2WaywOIXRAdw3hC5IKlnonSmdJn46kulktRkCc0G6V0pbZyJiLiFr+sKKmWtcp
	 81cIAjl/bn6gLGMfe0239LxY7+ZzlCPQrqVUIZZ2Syf1FimaZMq+iLNou9QQz9d4cNLhT
	 Fa3lE+JnlrEQbqwCTP5Ft2oMSNz+o+oqUllf2Bnc7HFYTOVx4iVMrs/HBkoEGE6RP69DG
	 nsetOxXKNsRbF3wU1h+dZHD2shW2jzdIM2sxE13rVxfFFfziR7vaR8Y9lU06vaOF8AfB1
	 oq6VYFNcOhep3ggegMSwgtAePclFzn9FOBqxaKvnMFoAP7LVAOi9NhhACQcjLNqGFEA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794432381;
	bh=i63OUBtxI1yEECdFJ2eDOnfM7ySnjMFF9VSZm3WwWAM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gwkVoxjYunSUj/5g4QDmeORuid7DAjyclyvhw+03mA4SjfxPp+ZeHrj0HIWQ56xuJ
	 37WuhWJyHZQHEEM7VzCBKPpCwyjkWHARYHMyLC7jIjmql90+afLJc6iGvwOwwqX9FO
	 DVpKxF4FXOvGbXnBkX2sw588kqOS2wEhkEzGIWIKdxQwOrwjiAkyTJYtXyjSoQAuoe
	 NqrQWKtZdYqBzCmVV5/1G8P+hudn/rsuCjueqeI0MQQyZpmilzC8ep+kUaIdNIzykZ
	 Bg/sN9cbCb0d6nJw3+OYiYaSs4yymmtB1oNSm0BXK2ATxoU+ldKUfpbPCrL+2vm3iC
	 YY3zCQw40fqbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B9EAA409FA;
	Wed, 11 Nov 2026 21:26:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id CF6A2335
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 21:26:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BE3F460902
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 21:26:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g9nZ2dNKdC97 for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 21:26:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0FF4360D9A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=SRKdc5WS
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0FF4360D9A
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 21:26:12 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-8470d7d430fso1871029a34.3
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 13:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794432371; x=1795037171;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i63OUBtxI1yEECdFJ2eDOnfM7ySnjMFF9VSZm3WwWAM=;
 b=SRKdc5WSyXKxp66mLwSWYkx5PbQSOdCD3c8rRyFGwV47yJmKkk0gsMD2IRmmtrKSWE
 /8D2Ik9khBb7VeGhvN655RsmtK7mfogSP+QmnhRuY8FIq/2OWOpgRQwleA36lFix3t2C
 nd0g5ytrYh7MiJ1IcVFchgun68UN4bYwh0J7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794432371; x=1795037171;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i63OUBtxI1yEECdFJ2eDOnfM7ySnjMFF9VSZm3WwWAM=;
 b=vg21zOhSEFcvqgVVLzhMqgFHfpyZZ+BZWE5qToR7pLs+KqIfL+wQ/cLtW/fmKDQe8q
 4/wKaA78vC31nhoav8R2YmdRe7mdBeoS95YtkI/6tQ7ID+uP2VINjqmSR5kDUAHJJqPX
 tef2LD6ExgPsIdhUm/bAgSlw17vo7ISKNvx8OViO2YIPdHctS6QoXtucHxjh3K4Kjg5+
 EYwNONYoq/m52VMyWxTSnCmDclyLjxYfnmPrnJHYk9RRZ3H6fY9oxsUQZ4V6ZlXftTE1
 S2QjN0BSCG2veffGIUyg4EvPEhTElOURBvZ3aXzg/PrJvpn95mnyqV2lMMoUvXUUi/Cl
 o6+A==
X-Forwarded-Encrypted: i=1;
 AL+hErHs6WZk6eh74aoPR9xJHd1PPV/ppqWPcHojs4IIdhY54hibhD6h0Akf0MdWCX2QjgCWgCqwrRU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/JzB1qQOx1VDUNbkQQpjKq9v6ZuTsbF2OBvmYTCQeJz8xuRel0
 gCLuBS2zWsu9e0rXch82Kz8T9qBXcIfjZ1Dr3tqyolBUfzyqFYk3QQqur26aRR9L4aw=
X-Gm-Gg: AYBFou2/X7fPGXUpYCLp6Srr28HGISFHF4aOAAZWUFjgvvC8qikEBy2h1HcxNOexnH0
 agO6fO/BJ9Kea87rrAs2uhLKe5z1wajVihjHmz9R6GVaXrXYqgUpNOMFfb1NZV53nyRZTht34DL
 C1CZi6AQM9QbJ0ztXE6Wa9A9HLwZl299RNlJs8QeNDOp/21XZia13fm8o+KHKUddeZPNRq9thzs
 qfj0Pb/nMu3GLv0zj5be7qq2GghBsCirEUu5x1/ALAWI+TCcPSnncl6RWz/N9oAd3vM+Mozjw/s
 9nMwPBJpbZDVKuWf1M3u+gjTfHxkcR88wYx7a11u8wMAQuq7n0/iSBjuVoGPn+0TTOHixZh60q7
 YDJfuxtMVrJKbJprUlTXM9pTLrUN5h+whZC5Rr6SiDX7GQXeQSX/BairoXBaGkmbsYV0yUk9dNZ
 MUo0mUAnp6jmHkEyvf592z9RJE0xWCGe7dktT+4sMXKoMgEf/Ltk3KfhHjLlZubVdBA7mNvskpO
 UCnGy96k0H6dFqjALss0HvIBaXDx64tP943tM+RCqk+3X711rR0L1rzlCVn0Ub8fWQrhsIxVAcb
 gre9a39OnrqrFAcumN1iXvg8yf12L4xYD6N/cJ2gDB5wlKIhHsmhuywoTGy2Wv8A/PRKUx2ecdE
 A1Y8GIb4m4QZYQ4kU5acbdLE41wXE6kSq99kSw6oDLWdP8m2B9QHvN2fFRih5ok7hjElpQZjwyo
 Uo7O97GIX94QMzg8/Q9tM3L5IXm/ge/D9XZTZi/k4WgQlFPXzPHfY=
X-Received: by 2002:a05:6830:448d:b0:823:e626:2765 with SMTP id
 46e09a7af769-860f29fc60bmr3892702a34.31.1794432371523; 
 Wed, 11 Nov 2026 13:26:11 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-860dcbbf1d6sm5205628a34.13.2026.11.11.13.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 13:26:11 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, u-boot@lists.u-boot-project.org, 
 Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Lukasz Majewski <lukma@nabladev.com>
In-Reply-To: <20261102-clk_syscon-v1-1-197c255ccb95@aspeedtech.com>
References: <20261102-clk_syscon-v1-1-197c255ccb95@aspeedtech.com>
Subject: Re: [PATCH] clk: ast2700: bind the generic syscon to the SCU node
Message-Id: <179443237076.664252.11979758934798756857.b4-ty@konsulko.com>
Date: Wed, 11 Nov 2026 15:26:10 -0600
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

On Mon, 02 Nov 2026 17:01:21 +0800, Ryan Chen wrote:

> The clock driver binds to the SCU node, which is also a "syscon",
> "simple-mfd" node, so the generic syscon driver never binds to it.
> The SCU then has no syscon device and its child nodes, for example the
> pin controllers, are never bound: every pinctrl-0 is silently ignored.
> 
> Bind the generic syscon driver to the SCU node from the clock driver
> and select SYSCON for the AST2700.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] clk: ast2700: bind the generic syscon to the SCU node
      commit: bd65e595541fa2da2e82feead6868b5e18c1bc2d
-- 
Tom


