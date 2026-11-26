Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D078606A321
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 14:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=enOR1Qjg;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ABvnk3z2
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5995460ABC;
	Thu, 26 Nov 2026 14:22:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xAOPsRkaMV88; Thu, 26 Nov 2026 14:22:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B9A1B60A80
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795702929;
	b=B0s82ZbPP8rZ9zJy9hF4Vb5CajX7etWXmBDJh9uhvm2q2JGXkS4nfrqZMwjDdD+hQ5Mq
	 QXym3V8htdROePpOLv/ZGp13ysQzLbzZ7Vpy6v0kwKJkIL9OW/oJGYSDNH67SVdD9HVUi
	 VdmykWjSC3hrzeokYhQ0zQ8eF8zXHJPmvS8gEo7DfMT3z9HXa2V42whHGxVX5WNao6ebr
	 43Jv7Kr+hi8vyY3ho28fsf6lrmEeI5nXScAyFEDeBDnFmodTmLHz+LAXL6BenxJDNhBdo
	 OzpNMvbBtcd0AMB3p6xVZBInHxTFpEBPOQ6DslQMfX9tKF7Y/k3WXYeeOExH4OTy2ZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795702929;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gJh3guO2ElnADmsboRV5qRkqpADoORQPHCOfoQFp09c=;
	b=rv8ZgbZe4S+gZhoSbJONau2WF4rOIo0W6EkwIGATuk3wJWtUzbwIPWDkg/d478hHCpR/
	 eYw/+hvojw36WeeTJDaYYmffkcC6aUtU9l4Yv/uK7OYo2Jzuw3uKp4jCV7ClpHdAM/rhw
	 99hQAiu/fi/lvmFDoGS8D5UTttZbuzqZ9DG6L5PpSXzKaaChylkOFPLPVvK6Ckzpvsvfu
	 laFQ/F2ymBvJWDw3PA++rvzC89Vr2DqHofD7obiV92RB469sgggzYIjWy95jKCDtTjylS
	 pjyUjRKLyLpmlCezqsbFtvBi36yrn/s2PXOdwoKjq8iq6hgKRTGNQLLAvgUozWphdPQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795702929;
	bh=gJh3guO2ElnADmsboRV5qRkqpADoORQPHCOfoQFp09c=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=enOR1QjgcFTvvXHKMx5g+o5OJWMQnylYReCRnSVYk/AdWL6eejvOpiMmN2Gb5hinG
	 bTffob1cB4ZuazXdpogRl+5JjArW2XlMONP2ttd3FqspwyZp62StYlcTIm5lGeGkQL
	 UTcTovSqnSYWRbqrp30dtmGNGSr6e0gGllGwtbmzmkqCLinedAIeOgFKC0hvkmtAqP
	 G/Gr5t2b9pezllMCD9tStHuajN2pgniEQmkrYoPArulMHsENosM2kMl/RlJSFVatkn
	 V4qrOZ4jVv/8n4K8MB0ZYloYZgv+D0Q3SkZ5BsR74yw1ortbFb62SUlA3fKDxixhzX
	 +oNY/jm4yD9nQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B9A1B60A80;
	Thu, 26 Nov 2026 14:22:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8DCC210B
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:22:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8A85C8117F
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:22:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JWYKztbz6q0l for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 14:22:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5882780F8B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ABvnk3z2
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5882780F8B
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:21:59 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4bb6adaf0f1so61507295e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795702918; x=1796307718;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gJh3guO2ElnADmsboRV5qRkqpADoORQPHCOfoQFp09c=;
 b=ABvnk3z2k1QeVvKWEtclpgs41LecE4fA/U2Bdm/TUvNUQW5h7jmkv4tESG0ZNANs9J
 BJA6Kr6kT4hsHoy4A2tsw/zNqiR5ZE+6rI2Zo71/s67H2+4iCj16BgVOS07uyVH6e5yi
 LkAoVxXwlmq9n5zCEHWQacWmqksLp2KITKOduUmYX3GNpeVqVxvD4YirSSrHGD+08o0Y
 v309fdsFo29JnaoBT3JjBF7y/ENuCqFCH2Wp1pq7Uu5BlXeHP4KLe/s0ZGqbjkYeMfFn
 EFoUw7y80JzTuEtK19lco0Ull1ZdCoiCuBSsOZOjkWPw6ellbgY/zSk2Z8RPeJliKqbL
 DKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795702918; x=1796307718;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gJh3guO2ElnADmsboRV5qRkqpADoORQPHCOfoQFp09c=;
 b=SkeFoxpZb2zL68A7PpFjJ/sPwZqFQ56HBPj+5nN+Zg6gmCE0cdF8QnZsI/guagQGiJ
 ilonKUTynWHzTREPm8UcRo3mHcNedVFfn3fEbLnT0qyR0IxaoIc6SizdMcbocJCJ1PMf
 drrCIVEQV6nVzEdsMa5IH5YMQEL2TPN9zGS4hvSqXKytlUFrrWcvLiGM7uRX6nWK2EQK
 wdr+V7k+HeSimMMxWL6AU/w0ZuGpQ50Oyl6SAWUQb3ZiCT+ywgGw5FxWHTDWpbiZp0bf
 jii9P/uefEZCoap+3yFSxKBBib05NrPLaHO7KxYS4aJAzClO1J1bAzJBYyI7On5CQ8ey
 zdew==
X-Gm-Message-State: APuU4Z/q6cwYTCwcTim9XnRtJmDV7BHeyeOSf5s7+U8ZM/0/nulokfni
 YFk2tx1Lc9uGp6UthMaIkCu4p0Whwj61GGJtq8P2/Vl+Zk26CJKu+RN4c62T8LdQRjk=
X-Gm-Gg: AZFdTZdLTTA7x9IhG5r/BQ5oWy2I3nk4SEoe46yhenMUs4CUX+h0yCcyU5M5WxgpQbK
 uMaY2PJNytWv7cPxeRyM7qY0WNfPEcHHSZb6U94SfPmejbA6f72BZ7h1PXriX7ULPrRXogHjAQn
 Cl64u18WOpMAmrBEh9efMKAQ15RZlLarjryYNrREPxjG4KzIBNtRh6p2uwtscPWYgwlnKA2/VKw
 n/ly8PAIaGIpaziPoWMr0jUaoi7SVK2tAcaiRK5ORnVqo0DOvu4HD7qaPcuoiOxpyXrKB3C0t8J
 mxjuXY83cxbUspyvZ57wdh8EUPYsF4pwh2dgThlu1v8dPnPhkOcRoPIlcyBpK83iT0R0Rvk72O4
 cfS1JQa2fetLMGFMOnjLZaITuAyQI8g4ty4EBMprm9SFhygqwVUkYWxhdlgFhoxFl3l55yBzW+m
 BORp7eOVdSm3H6G2O2+a5C/CeOfBXm8KqlbSr6eN12/KjpvLJB8ydxAxcBy+tJr1HZB5swwwmNB
 GyGgFzZXwiBc0R8LCsplA0ywLUgKwh7fX4e1xjIndS+sEOA/OYx/cgiCmNdch00Hjj/JissMjr0
 u3gPgU+rtF9eJZ777yljKKLHLLzISFFwGhe0aBaN2Eyv+uXY3dI=
X-Received: by 2002:a05:600c:3e1a:b0:4bb:6814:7391 with SMTP id
 5b1f17b1804b1-4bb8881921cmr424237655e9.25.1795702918085; 
 Thu, 26 Nov 2026 06:21:58 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb90655f5asm387647325e9.1.2026.11.26.06.21.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 06:21:57 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 5/5] configs: spacemit: k3: spl: Enable boot from SPI NOR
From: Guillaume La Roque <glaroque@baylibre.com>
To: Yixun Lan <dlan@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Yao Zi <me@ziyao.cc>, Junhui Liu <junhui.liu@pigmoral.tech>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 E Shattow <e@freeshell.de>, Guillaume La Roque <glaroque@baylibre.com>
In-Reply-To: <20261122-06-spacemit-k3-spl-nor-v1-5-33beb921011d@kernel.org>
References: <20261122-06-spacemit-k3-spl-nor-v1-0-33beb921011d@kernel.org>
 <20261122-06-spacemit-k3-spl-nor-v1-5-33beb921011d@kernel.org>
Date: Thu, 26 Nov 2026 15:21:50 +0100
Message-Id: <179570291087.2502540.9638660226515225455.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795702912; l=390;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=OaGCQ0krm4ScZjix31TN3H0UGPnLcZpm4njZ9rai8DU=;
 b=Y4dE4uPgpjX3+B0e9dJtLRfDCR/oMQClTQ6uBoBNzIafpRvLLSCGF2+GALKb+sPr1EaGAm+QL
 +dR5ZF2xlx1CO0jZQok9zk3ssp0Fgm4XJ1mMcp59YqPv05r2w5uLNSF
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 22 Nov 2026 02:34:13 +0000, Yixun Lan <dlan@kernel.org> wrote:
> Enable the driver-model SPI NOR flash and load the next-stage FIT
> from offset 0x210000, matching the board flash partition layout.
> 
> Enable FIT loading and OpenSBI handoff to invoke U-Boot proper.

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
