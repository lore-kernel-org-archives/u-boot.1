Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07715E83829
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 19:39:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7280283C72;
	Mon, 16 Feb 2026 20:39:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IiHNqIyE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B38BC80FA1; Mon, 16 Feb 2026 20:39:02 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5486083AA9
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 20:39:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7d18a9d2b1aso3287894a34.2
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 11:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771270738; x=1771875538; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0ZGp2qMQ7gex50NDlP1cuWk46RCrPuvgkRmTTz5fMqs=;
 b=IiHNqIyEfWsl6jvsVR9E4wwDXoqdRaw7g4QSuPOZ7GQot0TlSvEERDg4bCmkIiAQdN
 F7jqp+9aMLCirvYZYKd9/I9DZoNnBOGrFUn8oPJ7ttsSpNXcjd4QPi4Fg0nHvc5qumIm
 u0zZGGYwmzNoZXw3gVWI3sAkqOKMaLeE2AzGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771270738; x=1771875538;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0ZGp2qMQ7gex50NDlP1cuWk46RCrPuvgkRmTTz5fMqs=;
 b=v1jvBXCi861Qpy3eki9DfGaSy/dEuSJmjwqlpmVo740wVLDVZQQYkR1mKot2KD6Txs
 cAo7ekBNxdieREGCMVwLUE6ylEETHMaB4T83D+z3sNiIQhOdt2rP0QhhZpFER+sYDYuK
 Z52q4n/cEMbtXvGFL26JvylbyRiXBJVI1pY0CPG2T/4Apbe95PvK2U0ryLeDRiBYq/em
 0z8HBISNuGc+H3xhOmbzUkDV2om53K1J/GtjPZUQPBKBf+mTxLPwB4H7+KTFo289irwd
 JpHtXp5nu/noJpYPDWyJ7nn/DIzatH2IzmijXpyZx9MXzCbUGDIY3geNCD1qg0sWNcLp
 KIjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIXxtVLKbB3gV7ykxMP6xTz9Rlmzucre3WcDEuru1SK5tHWJxDe7+GuWUiFUs0VS6pRKjdxdE=@lists.denx.de
X-Gm-Message-State: AOJu0Yx7ofK4EzSXCRuMyq8pyWcbBqumSZghdhynp+SAqx3X+qrWRymF
 vqz2mSG1Rz4muGatLseaZYFZ5k6osTsJ0sWLufUUJe3cvKimlC5jDqt7LU6FgTEYrMqpLX6WtuN
 XRBNLkNM=
X-Gm-Gg: AZuq6aJXy5PS+yYjChhPgeKFSg6OoFhb5ZCjbgIEvkg5jRXzpdOWC129KBNPkkgr32A
 nzR+8xcjh6+oNEeHceFCmsgVghj3/a5Co9K1okHTIwd/1SqM73BH3QSQ1HzWw6/SGH2rdTFq4Iq
 QR/4oymDhLgVstxyMm0dqFEfX+Bge27zion/h/SSF9n/YGWhEfuXuRjTJRyMwhGrtmAULJkCgyl
 bm0hXlI37Qfw3tpIiu5B8d6TQVlVcE6drnrx/PXwkRP1C5hrk8ovryDG3feUxMK8+vyBQDlmLvN
 qeYAyJ8zgRFDWhEztA5yb+i72Lj72NvUMY4QLGZ7pqP3qzKhTVWnc8htTk9GpgPaGzUEVF2Db+E
 9N1M9Afk+Xmg0L4c+4NsXWgN7J1SGnkroPqDbqXzMc7T5ZRoYxqjeCebdqbQ9iDEfPoEatOlz0W
 Q+6uv2XnkQVFlUm6HUg/G4xcdm3cFdE6ZevZ3HsViZDKTM2o+1UQ+ZWpEymREmgsU9+pn6I+G2l
 xnaVY2AtJvljyufZJMwKLXeF3spJPnVcwc7I5/SIqkSBTqCfg==
X-Received: by 2002:a05:6830:6303:b0:7cf:ce25:e38d with SMTP id
 46e09a7af769-7d4c4ac0981mr7412286a34.24.1771270738543; 
 Mon, 16 Feb 2026 11:38:58 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4a76f9483sm14142543a34.20.2026.02.16.11.38.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 11:38:58 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20260206-test-py-source_dir-sp-v1-1-057435f85e45@baylibre.com>
References: <20260206-test-py-source_dir-sp-v1-1-057435f85e45@baylibre.com>
Subject: Re: [PATCH] test/py: Fix spelling of source_dir in docstring
Message-Id: <177127073793.2634449.13436815135962581626.b4-ty@konsulko.com>
Date: Mon, 16 Feb 2026 13:38:57 -0600
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

On Fri, 06 Feb 2026 15:31:14 -0600, David Lechner wrote:

> Fix a typo in the docstring for run_build() where source_dir was
> misspelled.
> 
> 

Applied to u-boot/master, thanks!

[1/1] test/py: Fix spelling of source_dir in docstring
      commit: 6f96026b1e33207762ca0a936abd3b132a8fc0ee
-- 
Tom


