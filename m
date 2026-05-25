Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A21A6CD5BC8
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 22:43:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB4A9848C5;
	Tue, 26 May 2026 00:43:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="A0nqfuDI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23D808493A; Tue, 26 May 2026 00:43:25 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97CD984903
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 00:43:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7de46b8e432so9192386a34.1
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 15:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779749001; x=1780353801; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=K57pBxqNqN4nMxqMD1tGjup0zWehrADrJpGRE9y6KXo=;
 b=A0nqfuDIhDJJlrbRdOab1W23VOoIt8q9zGR4FmL+JdZzvvIQrAvbYBXqAl0v+G+aYi
 2a+2QvS7NwfwG/FHJKhUdCtnXqsF+BuGhgJ6vR9bDhB+Ckg3xGeVUdbBlCEFinEa6Buv
 Pn1eEPbpZUezxZcVyTCZBRMUyzXlDGCo/YHQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779749001; x=1780353801;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=K57pBxqNqN4nMxqMD1tGjup0zWehrADrJpGRE9y6KXo=;
 b=oTc9+2XR1E+8tgqBdGFxdKUH8WsVLpdDbUECE2W58ZdUvZo3acqAMf1u4X3Mp0zTWo
 dffyQA2oMQbvsWUf+x5j34yW6pT+u7GFseL49GCF6Ff2MwoGtmApmCsuF/3ZtmBPNaoH
 sWYadAepGhJD5TnQnaz92cbcr55n2pgNLUGWwx+9AKyoFT3qfOur7ycOGdKAhDYSzTom
 ahuQVRVqwb/bvWdnIKyPseVnKy9RffdHK1iV8OyRxMgcQ2qFJBB14PcKlke3raFZYaQH
 yVxjKQwDw0oLPHLgfdbTW3FBPomPKlBVTzDISbU0Q9UfJS0d/ltDKUhJSaFQvjQxPS5S
 5TjQ==
X-Gm-Message-State: AOJu0YxI9QsxnEGd8YAizncd2knRKwEu81Wz9e2e03HttqcrUWy5dNil
 gvwr5ZOK0WPT1VYQ/acmWLdAEbv+EGoe3FR/CLjKXIXQngzMCKXNGsiEpEfnUSLSLnlVg+5u0Ed
 KAO3fsj8=
X-Gm-Gg: Acq92OFrlB3ioev/zvzuADxVjaEYu5YtLCsfXAscyT8/pj6miqI+j3Ly/dS07EsK2/k
 awmaVXTJ1d7HLJ/ZcjoEYhH0J+hrhBFrZZEk6Ur+OIJ0UXsQVxdq/wV8Qg+IYTEAwm4mNu7zwJb
 3nUm+L76LcKrMSS5RgBzHZWTtfwQLzsTiKDpbaxDk10NA39jT9j83LwRslHW4acxSARjZQ0WkSi
 ZXmUi5btC3JcvhtMjrtd2cxLqmI4e4epfyX5XkgYqQ282sxtxk4M4b3ctMU9ciBMnoR3gjt+H82
 B2sQbELXNt17oS6Jy2Uw0Hegn89xnXhaouFD+btKP4ItG1BGGdKTsxMqjYRH0bcdU5svKFz2+p3
 67oW+m4rxNJuoGHvnoH3PWzmcyffMVc1rwr5CXieMvFkyh9i9MWlmQmYnDTAAcCrIA837B9qiPR
 SkJEFb9HVZSGM5Aef1P49BZytj4pPyLLnV7sNhY/+Y+Z+C8RanlPY0vLMyUY5PswjgefK2T5SZD
 0mA55jByeR6CHkvB8KGa0snPN5z40XT4+SoMdyc4m9Z
X-Received: by 2002:a05:6830:6d0c:b0:7de:44a5:51d1 with SMTP id
 46e09a7af769-7e5fed7f5a7mr10578512a34.7.1779749001357; 
 Mon, 25 May 2026 15:43:21 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e606667796sm8076073a34.23.2026.05.25.15.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 15:43:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Francois Berder <fberder@outlook.fr>
In-Reply-To: <BESP194MB2805FFE6CC316B1923542634DA3A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
References: <BESP194MB2805FFE6CC316B1923542634DA3A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Subject: Re: [PATCH] led: Fix toggling LED on initial SW blink
Message-Id: <177974900081.3696278.4371645036031487280.b4-ty@konsulko.com>
Date: Mon, 25 May 2026 16:43:20 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Sat, 09 May 2026 19:30:53 +0200, Francois Berder wrote:

> If the LED is in the ON state, it is briefly set to OFF
> then to ON immediately due to falling-through in the default
> case.
> This commit ensures that no fall-through occurs and thus
> a LED initially in the ON state is turned off before blinking.
> 
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] led: Fix toggling LED on initial SW blink
      commit: 422024172f3b989d575dc5b2951899439c59d3f2
-- 
Tom


