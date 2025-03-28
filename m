Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92684C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 23:38:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE2F780ECC;
	Sat, 29 Mar 2025 00:38:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FC8n2kA1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1114180F0E; Sat, 29 Mar 2025 00:38:32 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64B3B805C8
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 00:38:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5dc89df7eccso5072690a12.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743205109; x=1743809909; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uHBEax4lBfew5jeFBU5GP3NYpiBRW+0cIPgVFddmZrU=;
 b=FC8n2kA1s6/P8DG67TvAo+0m4j+njYxrnJ4xPrH7P3MBVZEhD4xOcktSCTaE2uq7xK
 O0aUNm0iUYvrh4QYNU+m0JYVTzWuJHbDJhUSxuHToA4JUcJKI6sBG1tpGBGhNcVVMhi9
 OgMavlRl3tJzOtUv1SFC0JDnEx3sKgidOLBr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743205109; x=1743809909;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uHBEax4lBfew5jeFBU5GP3NYpiBRW+0cIPgVFddmZrU=;
 b=CqZnf4MXuhSMTABgZEmtNSYF/mP0N9iK8nCzipDBv8LcKUbUZ5pJYmfvYkuMqFCQQw
 78M71NY0zS6uBh41LAhOQ7X6BQ41XZRz8k2aYzNQK8yHJ307II3FYAUGD5v02gmHBTha
 XRaj2vGoGyUpXPXULJFhqu2ty9qvesPOiKqCL6CgG1yeNMlZTUgMvx5RO7Q/85JB/qtx
 m29hHHCJJytZ+zWPxBbkVaEKKpj+czNjY0PToVe/p0j1xklIKoCbkh2BlV/HACPrHSz/
 IZI6zsLC/i8+LK2z8X3DJ8f/QJJXz8MQ42xJFh2ZE0elEvrYll3GxZYajuzt4Sh4Ju+Y
 MCkQ==
X-Gm-Message-State: AOJu0YwHWVoMOh67uPUgVRaxoDbjt7ikSX2Ascy7uEvyVzzzEIVqvRDb
 YZWMH4/PFW3RpZvLQoDHTmX2wJDDtcMyOYCW33D3JmQ5Ip4wu6lFy3w21aUJYneo+mf0vkHW6ON
 VbS/eCMOxp/3I/HIqGKf0fh9/s6XzT05X5VOu
X-Gm-Gg: ASbGnctdGYRc2ug8dKaHw2srcSwt3CGsQ10m/M/8MQ1pnhIso66UYQp8biFHgBuhtxT
 E93FVpNNbU0Qp3mEPImwsc4FlnqdORwlUEIsU5AcKyoTMJyA7u2+Q5OWkAOPSKU21Yzg5lA7Jvm
 FfXHwem7VYcVnzZmFAnZFTohYUyjY=
X-Google-Smtp-Source: AGHT+IEmKiNlly8m2SExgmcCL22RfZIsJyc+/9cg83RCDy7DzW6pYHv/DKmGdkNMR2ss9G+KdXBWYqLLSyJAHvnp5tw=
X-Received: by 2002:a17:907:3f26:b0:ac3:154e:1391 with SMTP id
 a640c23a62f3a-ac73897af75mr83339666b.10.1743205108641; Fri, 28 Mar 2025
 16:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250328154401.3563921-1-sjg@chromium.org>
 <20250328161845.GB93000@bill-the-cat>
In-Reply-To: <20250328161845.GB93000@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 28 Mar 2025 23:38:14 +0000
X-Gm-Features: AQ5f1JrzxBWXRGiNWrBUrT5E4yPYJmx0aU2bBDkbt1gLCdKb2E7KIUzpiuOGnyM
Message-ID: <CAFLszThKn0xTmLdR7Hs_oKO_paYTtr-Y1xA_eoNY2rcjeuHX9g@mail.gmail.com>
Subject: Re: [PATCH 0/4] bloblist: fdt: Clean up the code
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Harrison Mutai <harrison.mutai@arm.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Jerry Van Baren <vanbaren@cideas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Levi Yun <yeoreum.yun@arm.com>, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Matthias Brugger <mbrugger@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@kernel.org>, 
 This contributor prefers not to receive mails <noreply@example.com>,
 mason1920 <mason1920@use.startmail.com>
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

On Fri, 28 Mar 2025 at 10:18, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Mar 28, 2025 at 09:43:54AM -0600, Simon Glass wrote:
>
> > The bloblist code took what I consider to be a wrong turn a year or so
> > ago. As discussed with Tom, this series proposes a way to arrange things
> > so that it is simpler to understand and manage.
> >
> > - Unwind some of the nesting in bloblist_init()
> > - Avoid needing to init the bloblist just to get the FDT
> > - Create a deterministic OF_BLOBLIST option rather than using guesswork
> >
> > It is to be hoped that we can get a platform which uses OF_BLOBLIST into
> > CI at some point. In the meantime, the standard passage series[1] could
> > be resurrected to give some coverage.
> >
> > [1] https://patchwork.ozlabs.org/project/uboot/list/?series=281465&state=*
>
> Based on how it's documented to be run in
> doc/board/armltd/vexpress64.rst in the next branch, have you confirmed
> that platforms using the handoff spec still work?

I believe so, yes. I don't have that board to test it though. Raymond
may be able to test this series on QEMU?

Regards,
Simon
