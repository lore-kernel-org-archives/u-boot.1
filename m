Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1D2D5B85B
	for <u-boot@archiver.kernel.org>; Mon, 15 Dec 2025 17:19:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BE4B801CF;
	Mon, 15 Dec 2025 18:19:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L5XePVZg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2BC8830A0; Mon, 15 Dec 2025 18:19:53 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF3E38003E
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 18:19:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7c7613db390so2386146a34.2
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 09:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765819190; x=1766423990; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S52kLHYcf1lbaBSiSQ7D0ojVeNlk85CtcliphFdg8ho=;
 b=L5XePVZg4AyZqu3kEqk5S5XgSVYxeDAYbaIyTJ/084gGjv8s5C6NaETZ9DZYkFrDp2
 mhRdU8nGPL4igmQlXbyk2ZmAjFOyZmmw5NvspM4ke1nmw26cuGjav6qgBnZaukhD0LQU
 8U0Gr10y2nBLNJsh2LuidkmNccSUr/0cTK1ZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765819190; x=1766423990;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S52kLHYcf1lbaBSiSQ7D0ojVeNlk85CtcliphFdg8ho=;
 b=LSfjqC6+9Q3zaIqmmrVcYGtJmXAtJcRnTPek1IAvGzE7lNlF/9+Qt/7AfsSwLwWtQq
 QfGr4K9bq9Ki8L9uMpNPs2f24YcDHiY6DWVwbpyfYQp8OtVJKSjAOyzBXBUpIE8d1jT5
 3S1mC85zMi7ysY0ptfz6XESo/OP9H8RdzpmM27UZIyuMvOGjx5XAEXG4GfRgAi8Frj6l
 2dC59mXkoXrXvSIVifHhIklmhWgZ4n4lwjwcUennYsy6zS2Bmv62d/aClDVhcoATltcK
 I2csB1zvG2i5I+FWDsC2eUbUSAN8y5j5GbMd5Z7sSs+c848CRbuEHsFIybNfobbtNos0
 3YVg==
X-Gm-Message-State: AOJu0YxAAUZB0MSfWERM1tJommVUGf+iF7sGvx5GyL0Tegal0QOFwVy2
 MZNagO0hg3DMWhg2C2u8/w0d75JFq7IyjFi4TkJS8H1lHI4k3SJEg+pVGVHEM3PT/l0=
X-Gm-Gg: AY/fxX4RlnUmoqFiN+Nxud6DdMh091KstLM/k6PWqC3a5DFBX4t1IDznvXe42df9tSI
 JDZ3UODPJJd4b2Bf67NhQAYjz3unuJEwmRsu/sOjUtgyaLd0z3CzlwRUO+gZPU4nYG3Xht9itBJ
 Ur7E4PP6b9s0BJiywUDz1b6u3cLPJZ9fdcCJZxSH5u5tUQyzD7hNvEj8fSBuylkEykFY8G6kkcU
 MPqXqmtWFrcymWEe6/IUiUwCd2UOmzjyInG5P2p3jPu4OdFy+kHq1g7JHtoGKP2PP+mHRCM+wJf
 OZ21RuFgWVvV9QKFd8sosU7n+FLILQCWntGU4t60GlcqCqzN1XOl7S95mJzRrbAhDut9jcbfa6Z
 wr2dUKHarofYpWBFct375Mly8exXCxVJ6WQq/ePC5drqMl5FIvi6rqTnn/C0W4VpNKUe8UaBSdG
 9E0OSyl7gjkstViNB6BQaqZOJkk8ZoMYEPHFpFHNPTUPyTlga8
X-Google-Smtp-Source: AGHT+IHdKsfGYh3bbA4eXIqdRFIf2Nv80AdL/bTCK7FiKO81r1IkfSWmP0cpsag8jIneuIruteOMWQ==
X-Received: by 2002:a05:6830:d1a:b0:7c7:8280:9205 with SMTP id
 46e09a7af769-7cae83b81dcmr7287697a34.37.1765819190468; 
 Mon, 15 Dec 2025 09:19:50 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cadb345977sm9710691a34.29.2025.12.15.09.19.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 09:19:50 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Cc: Simon Glass <sjg@chromium.org>, Kory Maincent <kory.maincent@bootlin.com>
In-Reply-To: <20251128-topic-simple-pm-bus-optional-clocks-v2026-01-v1-1-e38040c88b6d@baylibre.com>
References: <20251128-topic-simple-pm-bus-optional-clocks-v2026-01-v1-1-e38040c88b6d@baylibre.com>
Subject: Re: [PATCH] simple-pm-bus: Make clocks optional
Message-Id: <176581918938.1844985.2310142573160120855.b4-ty@konsulko.com>
Date: Mon, 15 Dec 2025 11:19:49 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Fri, 28 Nov 2025 11:21:21 +0100, Markus Schneider-Pargmann (TI.com) wrote:

> simple-pm-bus binding requires either power-domains or clocks, not both.
> Allow clk_get_bulk() to return -ENOENT.
> 
> When no clocks are present, bulk->count is set to 0, which works
> correctly with clk_enable_bulk() and other clk functions used in this
> driver.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] simple-pm-bus: Make clocks optional
      commit: 447bd8f1e5cf4d3c7d50df40d8cb46c7b911d7c5
-- 
Tom


