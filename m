Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7EB8C87FCA
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 05:25:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91FF183990;
	Wed,  6 Aug 2025 07:25:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ldPfHAod";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A9EC83968; Wed,  6 Aug 2025 03:16:50 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 919CA8394E
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 03:16:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alshenqitieiz@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-61580eb7995so997529a12.0
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 18:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754443004; x=1755047804; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=TCXhrhQP2QQRb6grh43n+vfvc6/ep9Na/a8Vwn0URog=;
 b=ldPfHAodFAtBN2JAUiG6IyhQ48jrbjACz0bqQhPt7d5QvL1/HRNJk33ADmgCz+/IZo
 EWfTm36CTVnDRtLsFPcZEn3hqlCAmk9kwz782G6esV4/fjJx/xgbHJRhjuh9pcHATuwq
 W3fZ5XtwIe7fl69u1gGximlG85CuVAbn/K+gsl02rUvQFTLwwQJ7UB7prEoFk5g2NL+p
 JG9rYMV4K/2YpSy1JUN6PY9vZ6vdMPokDbKZEgPiiBfLJBh9SqQXQyvGf3iy1pwHpHbA
 zhvsLlkJu5jlWdT/aVNLoqYCLPWHiCUzUWYY6gMTVxomuTsMIkV5h/15t9y2vc+3AuJ9
 jZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754443004; x=1755047804;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TCXhrhQP2QQRb6grh43n+vfvc6/ep9Na/a8Vwn0URog=;
 b=IRk521lR59RMqUAdLh/EWIwtvy9hVjb/V0NE/SZvCkaXKUGVET8m/w+2ZVMJYyfJ6d
 1nE8aCgkYP0tf25+9I2suaYJJuxgpRtrYXivVGkgmWdLPfgMJbjHfUE/jGBf9Kgi3w/M
 OyxmjqMzE75du+z1qLteC+6jwN1kHlHjM/WWBDKgiE8w5SRaYLxMSWQTsv3YB+Mf9yWF
 S5ORwt78giUGAnznz+embk3E1diDPb9WM3U/r/tx6pETEhshD3JSEKfKGFc1tuvBFktg
 8WbhFv/k6n8De6a/Vbtp0fT5h1fjxHZ+9rU3Q6BRk0Gh1mxjO87gg/aNWgKFu54OhUyl
 ZCBQ==
X-Gm-Message-State: AOJu0YyChy8/+vT/SAyq4isly1XX7aBcG8xLmDBlVT+EV19E7mD16tiQ
 dqvBwU+OnaeiZU2XPS5GIFY2nqb0bsyGB+fN1PD0oEgG3UvnB8NyhvXzfJojDeC0uym8ApV8CbT
 TBtFOgGeS2IKZZ2UWNckkk9xfOsSuCZyWN43u2As=
X-Gm-Gg: ASbGnctUr9w/+0UrEA64H1W/FfM3TkMorpxtLcvSDsywRszKmxe9IJBU49M4OGLbD9Y
 08bHukJiNPFaRQ/Lf8qs/+bPjxgI3TQTosqZQ923dBmNDzXQG0HF5LzN6x9HLlONfKcHR/CzcJK
 6aO7YxCgGWAIXhESoW2lOw1lNmAH1PnvlYyjR3Y9tuqwpjV6QebKW3EoSNQb4PzFotHLEd3NhH6
 RxmO+YLewKcYRXDsIVcVcqiouNNOlQ7CB8daJDRlA==
X-Google-Smtp-Source: AGHT+IHjlZA0UGwHmU9tIPVNKNjbfqMpNCkFf3IncwUGPY+xfclxWwS/zBFM8VheiToeWYTJ5SRLMpeu0HX2BWpRlXk=
X-Received: by 2002:a05:6402:5186:b0:615:3667:f4eb with SMTP id
 4fb4d7f45d1cf-61796bd7e9emr833410a12.6.1754443003742; Tue, 05 Aug 2025
 18:16:43 -0700 (PDT)
MIME-Version: 1.0
From: AbuAleiz Ramy Al Shenqiti <alshenqitieiz@gmail.com>
Date: Wed, 6 Aug 2025 04:16:29 +0300
X-Gm-Features: Ac12FXzd05WTKUjzMy2YkqpsVtjrx8NUVf_aCTdDzbIA9O40KJUeTMM1Sq_xkUc
Message-ID: <CAFggsaFgFnuTwGO7_LZgZJPVaHfmXvf96OxtAAUsEBsf2ooKuw@mail.gmail.com>
Subject: Re: [PATCH v7 03/12] drivers: i3c: Add i3c uclass driver.
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Wed, 06 Aug 2025 07:25:39 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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


