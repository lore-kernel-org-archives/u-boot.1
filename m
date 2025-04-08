Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87299C369A4
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 05:57:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6A9E830A0;
	Tue,  8 Apr 2025 07:57:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="HfJMnB4k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84B73830F1; Tue,  8 Apr 2025 07:57:00 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29E3983095
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 07:56:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-af6b02d9e5eso3538090a12.0
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 22:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1744091816; x=1744696616;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=whwpo8kqwB/u6lM4dTES14MzneqZ23WfxjZrEYkujsI=;
 b=HfJMnB4khVWwtiDm+ZUMZyCQAz4A2IXknFt0c7ULjAzWcW8xFyEibtM4/Ci67z8Iti
 hyoh6qh6MYealTlIPGHRbEPcQyjiX7nNV7/K9ukFZT4QrUwbXS5s0L9jj+ezGcUR72F3
 zyjl9BSDBTmJLmyCt/Ra4Re3Ws6wqqp7nIYro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744091816; x=1744696616;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=whwpo8kqwB/u6lM4dTES14MzneqZ23WfxjZrEYkujsI=;
 b=aHA591NThToiwr6X/LCQpj6xv/Q1F4tHu1WfV0oqyjj4aVb8bf1SLfNuNp7crDa5/v
 vO0KDiCYfY6BSxU7WQ2aga2iBgrHi1LDwl7cTtoDIfc4cd+6aiKPOSeHn/Cwk3vdUkmQ
 3PKlofdC1GozzKFhEqNOe3/itv6mMQQcpmVF9EzNRJ5v+4AGdVvec/UZP6FpOZ3FHW1F
 eKvMj8PACXowf8Hj6NwiMidZle8L24/fZWcFIUqkF/kV2iaB7z787fSAgvmmbslcUiTS
 tlriujXzQMqmu3e6XOTMXJ1y45amINfLCFSWL8ZxIKyUAgOYSTURY1W849VLLz88B2Y4
 +9Jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhQJ0p/IEG6XqxqhyDr3iVu+DkvSWxHsqkgIIKBpsUGopxBpW342LIYRwsVcNep6w6GdX+5rg=@lists.denx.de
X-Gm-Message-State: AOJu0Yyncmuc7swgAzGHYcLxaOr6kDC0GNww35EMG8vEKDZnhXewYulT
 zth4VhNG8xO6teADmW9b01qHicJm/ZTkX28EyucoxPs3z8/SnmwbxVVwbchXIaaGBbeDplqTo3C
 8uaIZuZBnA7i/osc0HN1oCBZCaG5BQNfxbxMXDQ==
X-Gm-Gg: ASbGnctqQ++vTNkuUW262yx7mi6TA5BWZT3NWTGROVIfua8EWs9mWkZShlarKnTXYKA
 RkLDjvvMig2roXmOeWyhcjThPCqLyXg13/K3r6fNjH7iMg+bDV+AXfhy098TdQ60PL0PH5EHIKj
 dpU4xL8AtryQ9QmV/UN6XGP7LdWMIw
X-Google-Smtp-Source: AGHT+IGXZ53B7au+58VWMgA0MQDB3sTXkOg70/ADztMOSQABPrHnd84bPee5zGvoIlmqmftFsuGNihX+qTJe4o/9iM4=
X-Received: by 2002:a17:90b:3cc4:b0:301:1d03:93cf with SMTP id
 98e67ed59e1d1-306a4b84678mr20374928a91.30.1744091816385; Mon, 07 Apr 2025
 22:56:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250315092420.793-1-ansuelsmth@gmail.com>
 <67f42db9.050a0220.16b640.abd2@mx.google.com>
 <CAOf5uwkU_hTEa_D+pEouXmsiQYMTNkHdr+z0boVO43BW7wkA7g@mail.gmail.com>
 <CAOMZO5BFntJ4kFFrtrFRL77RsM18LtjJDv1kHWSZViZMW1m3XQ@mail.gmail.com>
In-Reply-To: <CAOMZO5BFntJ4kFFrtrFRL77RsM18LtjJDv1kHWSZViZMW1m3XQ@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Tue, 8 Apr 2025 07:56:45 +0200
X-Gm-Features: ATxdqUE1-VnvDWWBN4w8m5YYVR65xQuwU10XVhhhAImJ3meutBlrxUOLZiS4wF4
Message-ID: <CAOf5uw=Sueqm+5XbqpjVJFVzLRnHZZyU6hV+=07DDXSEqqwApg@mail.gmail.com>
Subject: Re: [RESEND PATCH] clk: fix crash on clk_set_rate clean rate cache
To: Fabio Estevam <festevam@gmail.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Tero Kristo <t-kristo@ti.com>, U-Boot-Denx <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi

Il lun 7 apr 2025, 22:03 Fabio Estevam <festevam@gmail.com> ha scritto:

> On Mon, Apr 7, 2025 at 4:58=E2=80=AFPM Michael Nazzareno Trimarchi
> <michael@amarulasolutions.com> wrote:
>
> > Can you review it and pick if needed?
>
> This is not assigned to me in patchwork as it is not i.MX related.
>
> Someone else needs to handle it.
>

I was thinking that you are handle clk tree too. My mistake

Michael

>
