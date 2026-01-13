Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5478CF45D4
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 01:29:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C5FD83700;
	Tue, 13 Jan 2026 02:29:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QaY1XemJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0812A83935; Tue, 13 Jan 2026 02:29:24 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D755A836AC
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 02:29:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-45391956bfcso5226761b6e.3
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 17:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768267760; x=1768872560; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9LM0TD69yLTtwiAj53KgR24IDz6tEC12umiNwLf7Twc=;
 b=QaY1XemJGrrJmBHgBiB5EzV/r/W3Uo+P8tEJ4bdUuwfYWcmns8RQqTx013BMsQ7De6
 /zjCYxw45uv4tlcl5JUTc416nP7QLhqwhdWfrHn1fpQ8p5D+beSkf8/RxkeigsUsKKGo
 /I0H0NquUkxrNUDM/SpzqjmuC1L2wduSXH2oU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768267760; x=1768872560;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9LM0TD69yLTtwiAj53KgR24IDz6tEC12umiNwLf7Twc=;
 b=PjODW4R8MEoPRpGNJtch6ms/ohwUpHo+RqCxykXqEBIo4q5flJTXT+6qNWbtTTPdwL
 swyiEYOppWXuDhGvonWVU3QTcsag8vo/J87XNyZYnY1vH1NX/LvJ1x8wEYXhfQXDaR1u
 n7hfXIrKUsprCNgQhAR8dsknEAOnC9h2f59TrvUIktyWc3jJVmKM9MUWCU2SmSoYE0RI
 +izVs1dWG0QQro7wPmDRu7thDtaupFV3wD2mvBpkJ/CXAIooihm6rrhfzJyfFXYCW+/F
 FH0vb2uZcPW831ntJeYRv29cpigc6Y9oCb5Wam97cPTCNWRJ23bcl4DL7uzc6+NvY8Y8
 R+Ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkhl5rDaig0nHw8OF1y9dIQ2UJSmnYTCgmBM9SkBBWapZDgoRF5p910dXcZiEnpW3Lv7rkwjs=@lists.denx.de
X-Gm-Message-State: AOJu0YzA7qFeKfuEV9kZYT8v+Y8RN21wR8Dad/WopxBk/Ad0qUmpbaf5
 etHl92HsM95JiA9T+fmeoLNozrClq8+evO8a0PE+nMhhqZHYdn5fV0V+44D573cNxhQ=
X-Gm-Gg: AY/fxX5wcePTk/FG77RYVzXH5EHSLZ0468YUsHuSFgTL7U7AJ5aQsdZZhMxPEuDW8Dp
 oDXpxkGbJzqp8G7Gm8YYvvT61TZjUCuOw1LeOYXXdGP4uInqHMlp0VYYQhaotzU0mnz3A4+ffdw
 DO3YlIEtzjpzLJ3QaawvHTxDOQcUPE5T2QjtmMQKPqtONwFwAunbNQ+6xVhunxhs40D5drlSs3B
 fAuIbDmthY+Cg0QsgBjxTSVNRyDhiBwljO6AE1XmsUUOi6WXOh8Qc1cz6dLhfbXeTD3eI29sZ22
 RZenhRuWOgX1nCqf8UVXb04gD9AczmDi9wP6MUcsz2c3MaN1eV6LkUiA/CRcbwy5jt+txzks4Bl
 Z2IRoXd4CqnJIgJEFG545wSzrvjkVFNgSsWwgbo0M4DWT6bZGfi9w6YRDTeQgcqIYizc44KRmKx
 tlZpPoIIc39UhIFTdx3STE2sm9i8sXtbY1IJcongiCOQ8HinU4t8MFTqPsRlkqyJZRCYsAZEkBb
 GsmNgp/gY7waZtE7AwoJtaa2H7aMRVxImy47Q==
X-Google-Smtp-Source: AGHT+IEozM53e2qQTgcDjDkkwC4Hkbv+7pStot8OrzP9wlxrOQRKO33v7Rway7bPIlZB0tJjSXy9Qw==
X-Received: by 2002:a05:6808:2208:b0:459:bcff:a9ff with SMTP id
 5614622812f47-45a6be8b053mr9618575b6e.34.1768267760456; 
 Mon, 12 Jan 2026 17:29:20 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ffb279e939sm11992690fac.16.2026.01.12.17.29.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 17:29:19 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 Simon Glass <simon.glass@canonical.com>, 
 Jerome Forissier <jerome@forissier.org>
In-Reply-To: <20260105-a-few-test-py-improvements-v3-0-fea38243ca5b@baylibre.com>
References: <20260105-a-few-test-py-improvements-v3-0-fea38243ca5b@baylibre.com>
Subject: Re: [PATCH v3 0/3] a few test.py improvements
Message-Id: <176826775894.1946884.4714077261731142918.b4-ty@konsulko.com>
Date: Mon, 12 Jan 2026 19:29:18 -0600
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

On Mon, 05 Jan 2026 10:49:12 -0600, David Lechner wrote:

> While trying to run the test suite for the first time, I encountered a
> few minor issues. Here are a few patches to address them.
> 

Applied to u-boot/master, thanks!

[1/3] test.py: check ubconfig exists before using it
      commit: 637942ac8e093163742d7b74bf80836c3b950c4e
[2/3] doc: pytest: mention additional requirements for venv
      commit: c85d302bf2394a9c3fe95e100e014156a2e0faf5
[3/3] pylibfdt: add requirements.txt for setuptools
      commit: 487ab1c991d77b0236b30f55d7c2f89e3b948ec1
-- 
Tom


