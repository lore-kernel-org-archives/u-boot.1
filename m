Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1109D63939
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 13:38:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 806BE8966C;
	Wed, 20 Nov 2024 14:38:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L0FdGvIF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9061B892DE; Wed, 20 Nov 2024 14:38:02 +0100 (CET)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 603C889270
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 14:38:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7240d93fffdso4571435b3a.2
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 05:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732109879; x=1732714679; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r5twkrmUInkmLdgJhVkrvOtAW9OtCQJz0Q627j6Kcng=;
 b=L0FdGvIFSPRnLNHM9+lXKzP4p48v/IVEzOw6fb7CWhIvWeexR9dzXgQ7x0Gt3gBEEZ
 w5OsLM+U6vMEHObUFViikilIk58cnOCh0uYtplG/n6r2K2UKwhubeWWpmDssBmvwjdlL
 mJ17VqpW0GpEj+LOMupT5O6Wxy4OZnyZmLf3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732109879; x=1732714679;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r5twkrmUInkmLdgJhVkrvOtAW9OtCQJz0Q627j6Kcng=;
 b=RihmVx7E9eDwR5tameLw50spuUMtbRb0zKa816yLNzkgz1XOF4FlKjbXKfhZPDGn2c
 oEXan1tWSLGzSSH568/s71i+7vJNBrW2s0ulOp1fNhynHnKIzn9jSprvd2fEiqoZ6caA
 sB9jSpZLAcjqN+DXXpqsYdKh08scDC5rxuTOiMOaX5tLtW0+oJBUWK5ymnZobcHgWvG+
 BLGr9PJJpzTwdnUeE3CkkrlzhIwjGExULcfcMkdl0SwJ6My6gW1rPCPW+vNdpqeDPCLn
 eHY4fK+Bk/ikoZ6JSRf9ez8GtRjGnYXM16BTslCtm4tgZcF+8N1Z+yPihf/Sw9F2he6O
 rQWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX290y3yiiQvMce94OtfZXn7A0Uj8k2aMvuqDkg9CcKD+jkQWrmTwa6A8MB4WONYAAjQvZ6Zso=@lists.denx.de
X-Gm-Message-State: AOJu0YwOA+6cl5Cs4pDpSngzDP6PrNZA/N/yWmvGhERYDSmZ/3sgwmUv
 QgFBeMlcH9OioRE5q3KF7vhUIyxeTiapCTdxSzTLNC9jiWch8KOmmZU6axWh/biEtxO1V0z8IRW
 cRwc6bi7USu9txJ4kIG1F6aIba97oz6kTD7FA
X-Google-Smtp-Source: AGHT+IEzD9Cq0RlKVccWTyaR5Wy5wj0+ye7+T+e1qDbP026Ff3fUQwp/6yg8yv4CxbebmKzSbfwJA4QIrdZcgC7Q6cA=
X-Received: by 2002:a05:6a00:c87:b0:71e:7604:a76 with SMTP id
 d2e1a72fcca58-724bec8a716mr3558056b3a.1.1732109878936; Wed, 20 Nov 2024
 05:37:58 -0800 (PST)
MIME-Version: 1.0
References: <20241119222837.27550-1-l.rubusch@gmail.com>
 <20241119222837.27550-4-l.rubusch@gmail.com>
In-Reply-To: <20241119222837.27550-4-l.rubusch@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Nov 2024 06:35:45 -0700
Message-ID: <CAFLszTiUwscvAX20rtP9HdVzzE-4UDAnR0m1TVSHEjqmSrvbNg@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] doc: develop: Fix typos and wording in
 binman/entries.rst
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: trini@konsulko.com, alpernebiyasak@gmail.com, ada@thorsis.com, 
 xypron.glpk@gmx.de, mkorpershoek@baylibre.com, 
 dario.binacchi@amarulasolutions.com, pbrobinson@gmail.com, n-francis@ti.com, 
 afd@ti.com, al.kochet@gmail.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Lothar,

On Tue, 19 Nov 2024 at 15:29, Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> Fix some typos and wording in binman/entries.rst.
>
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  tools/binman/entries.rst | 104 +++++++++++++++++++--------------------
>  1 file changed, 52 insertions(+), 52 deletions(-)

This file is actually auto-generated, so you should change the
individual entry types which are used to generate it.

As Heinrich says, we tend towards 'International English' rather than
US, but it depends who wrote the original code in question! But we try
not to do patches which just convert one to the other.

Regards,
SImon
