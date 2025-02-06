Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3760C02199
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 21:27:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5CD580ECB;
	Thu,  6 Feb 2025 22:27:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S7mwYuES";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6411280EFB; Thu,  6 Feb 2025 22:27:40 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CAF280C6E
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 22:27:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5dccc90a4f1so2948511a12.2
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 13:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738877257; x=1739482057; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RTXemap5HE7WYO7vp5ra/SGWfyzk018Yw7cNUU4JRqw=;
 b=S7mwYuES0xlD2V85nMX0v8yGQFtmDurv7Sq6RLg1RXIe4Y/TO+ReAM9MREXp2S/60O
 AOVyZoSPvevOKDvt3Eeohd8l9ZT+/3MxFTYTTlUEnniG7jKF/vgKHnR2erFvZL52zOiD
 K2s/pvajuQcFKuywG6XCyPEVXctoGXxcJjB24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738877257; x=1739482057;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RTXemap5HE7WYO7vp5ra/SGWfyzk018Yw7cNUU4JRqw=;
 b=hVdNZ8yuDndZLdeJaE6jSNuQMgKLxij6rqMY3figc2Mca4QGYoSsrPYomgsa/m3iTx
 N+zz04tKsJhQ6yZnUwMisIizYpM/p3RoAOdGjPulbFU/fpwtYfisomiDiTKowPrZDcRX
 fdZqiQfi+XMuyhm7faLBhMJwE5BOuIgBT3UTalu8geJpIlduhwEcSDH26qD7St890KTO
 Xu8Lio//32CDgp98DzbRj4lycUW7rC7ZLw1TZs7Th+sHxOCqUwta57b6/oiTIpZB3Vh6
 XhrJ7n+3LATrimE/qUOy0aQ+DGx+YNoMJzpkwlCwtVfcCVvLJoqHJk0K9KGZVLY/KudT
 qJeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfPQmsVwlNTupZ4UbDli53529Y9S0QkJveOGmvnNZKfjJ9iVwtAUbioUg/eYqaPGubX7wRPPc=@lists.denx.de
X-Gm-Message-State: AOJu0YzT7+dYrDhz/vllq8ySXAKrfYAyXHotW3sd1YtIgPrNZR87C8UZ
 h+RSZBH9GT+Kh3WEXxlrKkYrZDyU+6j0y3a5G1vkUeaUWPsfABil+Jg6KJ1w/5ZqlTFZWcW7s/D
 rbWo70gSPVWWE2yI6aARHrVmNzT8BRNmfB7l1
X-Gm-Gg: ASbGncsVgKP+92LrqKN4XP382plC0JYs0OsRgKmeVp+i0qDka/zxEfXy4k1/eFcoAjK
 Ss1He9pNCjQ1qIlE3ddbzBjixoFuxpWDQqrFfB/L7TT9qMldVayp01IYGUB92KygjZiRsfVDkqA
 ==
X-Google-Smtp-Source: AGHT+IFWvaB8+TYwfMxsG1Q6oJ2oG/LPQJYJXDg4UVXvHHn0llShz00Lyt9UG8QluIQnvtyVUUgL71SSindY/3a7fUk=
X-Received: by 2002:a17:907:7fa8:b0:ab6:eeca:f548 with SMTP id
 a640c23a62f3a-ab789d3577cmr45005466b.50.1738877257464; Thu, 06 Feb 2025
 13:27:37 -0800 (PST)
MIME-Version: 1.0
References: <20250205015606.2686149-1-sjg@chromium.org>
 <20250205015606.2686149-29-sjg@chromium.org>
 <CAEfUkUKoe+1LQaqOUb8_1M5yy8ELr=jG66+wRd1b3Oq5BB2bSA@mail.gmail.com>
 <CAFLszTg=UDJUdjCPsyMBjZ3r_r9dNyWYiXNrmhm8mxgEbQoaOg@mail.gmail.com>
 <20250206162347.GD1233568@bill-the-cat>
In-Reply-To: <20250206162347.GD1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Feb 2025 14:27:24 -0700
X-Gm-Features: AWEUYZm-YIO4IUe2zkpsaofo3aaaIG-XdOWSKkLsanuyKlXexpz8078mvw1m8WE
Message-ID: <CAFLszTjo7b6TJw0oRU9O8mLjy4Gtdws1ctjop5oteWQjZJDk4g@mail.gmail.com>
Subject: Re: [PATCH 28/29] Revert "bloblist: Load the bloblist from the
 previous loader"
To: Tom Rini <trini@konsulko.com>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Levi Yun <yeoreum.yun@arm.com>, Patrick Rudolph <patrick.rudolph@9elements.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Thu, 6 Feb 2025 at 09:23, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Feb 06, 2025 at 08:41:09AM -0700, Simon Glass wrote:
> > Hi Raymond,
> >
> > On Wed, 5 Feb 2025 at 08:25, Raymond Mao <raymond.mao@linaro.org> wrote:
> > >
> > > +CC Ilias,
> > >
> > > Hi Simon,
> > >
> > > On Tue, 4 Feb 2025 at 20:57, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > The logic of this has become too confusing.
> > > >
> > > > The primary issue with the patch is that U-Boot needs to set up a
> > > > bloblist in the first phase where BLOBLIST is enabled. Subsequent
> > > > phases can then use that bloblist.
> > > >
> > > > But the first phase of U-Boot cannot assume that one exists.
> > > >
> > > > Reverting this commit seems like a better starting point for getting
> > > > things working for all use-cases.
> > > >
> > > > This reverts commit 66131310d8ff1ba228f989b41bd8812f43be41c3.
> > > >
> > > > https://lore.kernel.org/u-boot/CAPnjgZ3hMHtiH=f5ZKXNniOfV_-vFryq1Gn7QZ5hKU8Wjo8igw@mail.gmail.com/
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > >
> > > If my understanding is correct, you want to add some logic to control
> > > when the U-Boot should or should not get the bloblist from the
> > > existing register argument.
> > > But xferlist_from_boot_arg() should be called when a valid register
> > > argument is there, I didn't see this in your patch.
> > > Maybe you plan to do this with other patch series, but simply
> > > reverting this results in a breaking of handoff policy and the
> > > firmware handoff won't work.
> >
> > Yes, I certainly did not want to revert it, but the current code is
> > too hard to understand and I did not look at it at the time it went
> > in. I've had three tries at working with what you have here, but each
> > turns to spaghetti.
> >
> > I would like to build on this and get something running in CI which
> > uses standard passage. As Tom suggests, perhaps we should disconnect
> > bloblist and standard passage?
> >
> > On the CI point, is there a board we could add that uses the
> > xferlist_from_boot_arg() call?
>
> Yes: https://patchwork.ozlabs.org/project/uboot/list/?series=442824

OK, so is that 'vexpress_ca9x4' in CI?

Assuming those patches are going in, it's all the more important that
we apply this revert and tidy things up quickly.

Regards,
Simon
