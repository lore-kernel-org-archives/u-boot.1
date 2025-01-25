Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA17CC0218D
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 22:42:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2251580EF4;
	Sat, 25 Jan 2025 23:42:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hqSj2fqJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC58A80F48; Sat, 25 Jan 2025 23:42:14 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEA2580EC0
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 23:42:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5da135d3162so5185644a12.3
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 14:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737844932; x=1738449732; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GxFzzrg2BQ5qQdc0TRL3eZ8awBuGyiVXkghGGlH8XjE=;
 b=hqSj2fqJZX6/8M1uNVd5/k9U92kWMSekicqjrB6KHZSy0WY98JD+HmgCbX8XePL0zQ
 iDNvO2Jybv0H6p4p9/wAXUFFANogtz6Kym4wBl03o0ibVP/94E5hdB09DcvfFj5YpslC
 Bm++rxfK3VrPBB9IWr/1Mw8PMwOz6mmOOWp0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737844932; x=1738449732;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GxFzzrg2BQ5qQdc0TRL3eZ8awBuGyiVXkghGGlH8XjE=;
 b=f/OoUQep0/BKBxCZ4tlLww/QVPk8PPq5g8Sq3/oQJ7B8pagR+alKpzx3nXqQPgw9MC
 HQLBOS7IXYW/NktI4ATGGkofjdCA62W5n+Y5JTZJb+ODL6J1OFrY73Mdtf3Y6NasQ0jy
 BN3J9/tEirRdW5UHhkWi/XKLvAmLrzaCVEQxsb29FnOgbAstk0blwPpRDQZCHG0FuuWn
 FmBxJ0Qdoxv4Gf4SQsWkGaQY+STC3D9BBiW1HIO5hmgVAPexaaKnVJF0lTm/S/iht3il
 IWYTkBgOZPB/2lNCf+5KJ06zLwP5xgstA0TEjEV2cwjnORfKGYNCCQQa9Lk6+/NyFwN9
 +sPw==
X-Gm-Message-State: AOJu0YyZctLe+0XdksTr0Qpj7jXTo8z91r2BN+flOKFHqifL4sXvQJK0
 Y/E3THOTHihMOwE5HthKH0w23q/hfU0KQDpWjxJH6tYNBwU6vCjZstH5Ja0KJagKOTnltLBKEIa
 JNxQrZn21bNk0AHOStPvO/FDbSidmffNSk84G
X-Gm-Gg: ASbGncs8/XNkAN6B1z+dnDquk+DYNZ29AGn48rKjjM8EudVrZSGsM4PsqECUBoZgd8h
 zdzcI8jRGcya4ffCmUWrnGvp+PaSuvyS19J2Q+b1/I+Qh0IVMPwe7dauYNmmwvZQ=
X-Google-Smtp-Source: AGHT+IHq2b6ITll4yJBXu0vJijeOLOEJNE0zSYB4fW+9GhuBtP8venoWhQ9aCLK2BzsNCD2LBRkrw+6Gae2XDKW7/rk=
X-Received: by 2002:a05:6402:2110:b0:5da:c38:b1cf with SMTP id
 4fb4d7f45d1cf-5db7d2dc135mr32336799a12.3.1737844932216; Sat, 25 Jan 2025
 14:42:12 -0800 (PST)
MIME-Version: 1.0
References: <20250125213150.1608395-1-sjg@chromium.org>
 <20250125213150.1608395-2-sjg@chromium.org>
 <20250125215055.GF60249@bill-the-cat>
In-Reply-To: <20250125215055.GF60249@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 25 Jan 2025 15:42:00 -0700
X-Gm-Features: AWEUYZnS7_IeCWffdJA7OdJPnemnLo0CmhbjmJi1FSsyWJa7yXrZlsqk5b3j6fM
Message-ID: <CAFLszTjG0P0bdwziV4irtiU1JGNMwnoiLO9xhPxLQa9GZPVBtA@mail.gmail.com>
Subject: Re: [PATCH 1/4] test/py: Shorten u_boot_console
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Huang Jianan <jnhuang95@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Jens Wiklander <jens.wiklander@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Joao Marcos Costa <jmcosta944@gmail.com>, Julien Masson <jmasson@baylibre.com>,
 Love Kumar <love.kumar@amd.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Michal Simek <michal.simek@amd.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Richard Weinberger <richard@nod.at>,
 Roger Knecht <rknecht@pm.me>, Sam Protsenko <semen.protsenko@linaro.org>,
 Sean Anderson <sean.anderson@seco.com>, 
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tim Harvey <tharvey@gateworks.com>, Weizhao Ouyang <o451686892@gmail.com>,
 William Zhang <william.zhang@broadcom.com>, linux-erofs@lists.ozlabs.org
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

Hi Tom,

On Sat, 25 Jan 2025 at 14:51, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Jan 25, 2025 at 02:31:36PM -0700, Simon Glass wrote:
>
> > This fixture name is quite long and results in lots of verbose code.
> > We know this is U-Boot so the 'u_boot_' part is not necessary.
> >
> > But it is also a bit of a misnomer, since it provides access to all the
> > information available to tests. It is not just the console.
> >
> > It would be too confusing to use con as it would be confused with
> > config and it is probably too short.
> >
> > So shorten it to 'ubpy'.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> [snip]
> >  102 files changed, 2591 insertions(+), 2591 deletions(-)
>
> First, I'm not sure I like "ubpy". I believe "u_boot_console" is because
> it's how we interact with the stdin/stdout of the running U-Boot. And
> indeed it provides more than that. But ubpy is too abstract and unclear,
> and looking at the diffstat, I don't know that big global rename is
> justified to save text space.

I actually get quite confused hunting around in the fixtures so I
suspect others do too. I would like to settle on some better names.

Yes, I don't like ubpy much, either. Your favourite AI suggests
'fixture' or 'test_env', both I which I prefer. The only challenge is
that 'env' has various other meanings in U-Boot.

Regards,
Simon
