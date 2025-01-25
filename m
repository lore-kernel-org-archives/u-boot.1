Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 847E0C0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 22:59:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0343E80EF4;
	Sat, 25 Jan 2025 23:59:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Eue8plAj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB4DF80F10; Sat, 25 Jan 2025 23:59:04 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A33C080ECD
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 23:59:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5d3d143376dso4538877a12.3
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 14:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737845942; x=1738450742; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FQDxLWZK0PSMqeIIXwAZknm+uppi6AqfqfZC2CcX9TY=;
 b=Eue8plAjnox9Beo4aAp49BuwHHqMtZOKYJN8wYxRByxk0oc7JFSY7BQQh49+7MqoeT
 rbN32eC6/2J07IMi+uPO3esiu6MCbjdyYhZqBjL8nOEzMtaHUqDMw31GMOVDDGYTt4iD
 7/Ai0AI814fMzzevn7lM6tX5xiHQUNmnUrISQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737845942; x=1738450742;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FQDxLWZK0PSMqeIIXwAZknm+uppi6AqfqfZC2CcX9TY=;
 b=SnGUc+KV2E/Ix7A7bg4ino2RY5rotbK6G2kBDXIrrNLzHXrBERbEoEjdUqz+VKSH/K
 Mh9JHIBK2XRrLLzLe2eoPj5VRQ2mjLt7QpnwdDh8XIqjRZ2LApOCxHwoq4uEWSkkMujz
 Iq5eOhw3t3+IEQB1bbZNpDfaOkrns/7TALLwvHPTad1oiX8SVPoC8x8hTCuY7dE0USjw
 M1sqSS2/7q/H2+DQJJBTWBrD8gBXR2SwWXUwUXGEE76X90x+9Ml5WmMiZEArXc4NXgNn
 zGGQTVRouSwJFb9AZy6MNAhYSdt7JmxiChI0u7SzwDZrH2RRopKphSwzbR4nk7w7v4AQ
 jCxA==
X-Gm-Message-State: AOJu0YxtNzQ7KkZL5uuH7mDxbnCviIyT3SvBeyJytiASZOCbxMt+L0Yt
 jFLHzUJNYB++qK30TqRxR/FmzoLo44rrUvdxT4dhVmZtBd3WWvrIv1TQsodf88pRTqoGiXATGGR
 HFmeqgvhTuN3pq8jKrMkPg2fORVwNo0zF0Sq/
X-Gm-Gg: ASbGncvWrws1g6MQ9ypxttMd78cUYd12HB2+kiGmxu/P4wpOMf/TvTQ5zTEfUoOpvaO
 q8AWEHSvJRwhuwND5rbQZDIAIsWl+eP/IMwXTUVbwzoJxEyGIPsvlXvysUSkkkE4=
X-Google-Smtp-Source: AGHT+IEaYBTqG2tAT1zhbmQwiTblASeuVykK2jZDd82x5SHbhBgiYyAqIptOczBScj9omt56ca2d93/LWrtWPLDabP0=
X-Received: by 2002:a05:6402:520e:b0:5d1:2631:b88a with SMTP id
 4fb4d7f45d1cf-5db7d3012d1mr36824478a12.17.1737845942038; Sat, 25 Jan 2025
 14:59:02 -0800 (PST)
MIME-Version: 1.0
References: <20250125213150.1608395-1-sjg@chromium.org>
 <20250125213150.1608395-2-sjg@chromium.org>
 <20250125215055.GF60249@bill-the-cat>
 <CAFLszTjG0P0bdwziV4irtiU1JGNMwnoiLO9xhPxLQa9GZPVBtA@mail.gmail.com>
 <20250125225510.GJ60249@bill-the-cat>
In-Reply-To: <20250125225510.GJ60249@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 25 Jan 2025 15:58:50 -0700
X-Gm-Features: AWEUYZlrr_7C4dsjCu1hmrc4ah4Gcb6lYpTZ6nWdgbFlVzkb5cx0K8afXcNI3t8
Message-ID: <CAFLszTj7no1azG+Us4toZA00O79sZpr3qgtoD69UpQFVNjAhoQ@mail.gmail.com>
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

On Sat, 25 Jan 2025 at 15:55, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Jan 25, 2025 at 03:42:00PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sat, 25 Jan 2025 at 14:51, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sat, Jan 25, 2025 at 02:31:36PM -0700, Simon Glass wrote:
> > >
> > > > This fixture name is quite long and results in lots of verbose code.
> > > > We know this is U-Boot so the 'u_boot_' part is not necessary.
> > > >
> > > > But it is also a bit of a misnomer, since it provides access to all the
> > > > information available to tests. It is not just the console.
> > > >
> > > > It would be too confusing to use con as it would be confused with
> > > > config and it is probably too short.
> > > >
> > > > So shorten it to 'ubpy'.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > [snip]
> > > >  102 files changed, 2591 insertions(+), 2591 deletions(-)
> > >
> > > First, I'm not sure I like "ubpy". I believe "u_boot_console" is because
> > > it's how we interact with the stdin/stdout of the running U-Boot. And
> > > indeed it provides more than that. But ubpy is too abstract and unclear,
> > > and looking at the diffstat, I don't know that big global rename is
> > > justified to save text space.
> >
> > I actually get quite confused hunting around in the fixtures so I
> > suspect others do too. I would like to settle on some better names.
> >
> > Yes, I don't like ubpy much, either. Your favourite AI suggests
> > 'fixture' or 'test_env', both I which I prefer. The only challenge is
> > that 'env' has various other meanings in U-Boot.
>
> Yes, until someone has a better suggestion than "ubpy", we should leave
> things alone. "fixture" has its own meaning within pytest and so that
> would also be confusing.

Yes, ideas welcome. Arguably it is confusing that this one fixture
provides a gateway to all the others.

Regards,
Simon
