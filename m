Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B51C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 21:07:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 864FA8862C;
	Mon, 22 Jul 2024 23:07:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H250Jefh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69612885A8; Mon, 22 Jul 2024 23:07:31 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 707AB884B2
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 23:07:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-52f00b703ecso299623e87.3
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 14:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721682447; x=1722287247; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HkkKUmCjOs3ym6cwSx31v48qF4rx77AMFSYykb1Ra1I=;
 b=H250JefhjNYcnzx8vuj/b0TGegM4LCJiGVgS7IqdAacU5LqqDdqMPnN15BcIgqGX/I
 61i2xledD3RC0+aJcfMG/USvyeFdi7Ivulv4vxDYwidioTyyIege9PQ+o4cBZ5Y37o5q
 vqRY5eMvur9HfrFQhgfck/jrKYn04mjclpyAxeK58HMbpJRGxwjVu0mCw2RZ02ncgx9L
 dmDC6nSFHd0nnOjM1BAy1pzlUBBgKhqTvu1n8357bHGdZa3vCpUOMWuh9ZbhN9ULvdtJ
 M20upLoylCcEyC0N+mO7k2cCoR+H+XhkHW4ZQ3uLBWaR7V2NoBK+FXLEbJvsTaZ6NLdn
 MCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721682447; x=1722287247;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HkkKUmCjOs3ym6cwSx31v48qF4rx77AMFSYykb1Ra1I=;
 b=BknWMFVFlr4ZC/bia7WPKkYedTKNQEOuZXGXJj+samqMJkMcQdEvPehu9F9f3YPj37
 w5f3pxH4LAW0Z8+fHENCDAZzJ13sKsc3ck6meuFG8HpbnYT9W+P/JDSMruO/m5RMEkS2
 03NqdVN5ApTiQms6PIOaihRU8clGWiA4uhTaChpf58ul9QjcDWeTz1UJxx/pQPXmEleA
 XsbvE1FhJwaE7/b6pYqT1g6qoNbZaOv5HM+5HeijS7F/ZBwx7r12aBpssJo0hslz+Fic
 gA84xAHgda6xZE5y7rq7LGiwOYcK7PQscu0BhCFllj5WCqy7GlqS9q5nnTV3Q/7yYbsN
 OgyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+tV14bPZxPtil9bbmCcc9jzmkAUMFUJygc8zuZk161GpTuikPHkqqMWR6DoZWsCg1ZiSzNtzTWXg9AOiWCUY2RA5GWQ==
X-Gm-Message-State: AOJu0YwAQTUl67/6sjXpsY5CktQG9LuNY45OUng+wGWMg2ZyjFq4oz1b
 Qlv9zfuv7M8DEdGJGE0HWJZkF35alGSyhGNfDvmyrRKMWHORbrFysWr5mW5rgo/scvIOOAUzXKA
 YS+kh3gd16P5O0pm1rgLF/0bRfrs=
X-Google-Smtp-Source: AGHT+IF/JcH88E4kMkd5Ve7510bnH6wNMWlVwiASe5PHGrxmzvI64L1b3foQRklDReWZARHrH9O7wYsURWWDeAVZZOA=
X-Received: by 2002:a05:6512:3b21:b0:52f:4b6:bb4b with SMTP id
 2adb3069b0e04-52f04b6bbb3mr1143356e87.9.1721682446431; Mon, 22 Jul 2024
 14:07:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240707082001.20746-1-michael@amarulasolutions.com>
 <20240707082001.20746-2-michael@amarulasolutions.com>
 <CAOMZO5Ddm_2rerosTctkCzcd_+ku7VfsrxfXOEU1NynEOgoQbA@mail.gmail.com>
 <CAOf5uw=wktwcRrPOXmCjehKSsQvzAAhmM4KKsbdxyE6cRVBMrw@mail.gmail.com>
 <CAOMZO5CyFvpa_Fkfjmte9FvPROdNyTS3X1gzweeatu_Evpz2_A@mail.gmail.com>
 <CAOf5uw=_dqeehnj7xk9J_M430nt8OAU78gyTi7eEOTLLn0tqEw@mail.gmail.com>
In-Reply-To: <CAOf5uw=_dqeehnj7xk9J_M430nt8OAU78gyTi7eEOTLLn0tqEw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 22 Jul 2024 18:07:15 -0300
Message-ID: <CAOMZO5D2GFdvYJj3Q16-XHdOoX9O2ARrk9Trm5hNK5Ey_=qiJg@mail.gmail.com>
Subject: Re: [PATCH 1/4] clk: imx: clk-imx8mn Fix nand and spi clock parent
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, 
 linux-amarula@amarulasolutions.com, u-boot@lists.denx.de, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Marek Vasut <marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Jul 11, 2024 at 2:56=E2=80=AFAM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:

> I will rephrase the commit message

It looks good as is.

Applied all, thanks.
