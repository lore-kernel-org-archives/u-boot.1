Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5677CD342A
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 15:04:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2181A889ED;
	Tue,  3 Sep 2024 17:04:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="b5nwN4il";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C37C188C1C; Tue,  3 Sep 2024 17:04:08 +0200 (CEST)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E93B88754
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 17:04:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7b0c9bbddb4so3742601a12.3
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 08:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725375845; x=1725980645; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JN9BgUwppSh4gEW8vFcrzYVmU+3v2Krq1mU5gJ5qdrc=;
 b=b5nwN4ilYpWlXYD9rsi8l8bU+BgKy/rxWpltxCZ2DlSNHpipdDA5AyWXoF1U/SCq0i
 Wl0klB9Fwo6fO3Wgu6Gw6HaILkqA0UNCkw/32Rf82sbFej9k+93ugVm0OCvtmxDvXZTN
 g1pUY+0oEFLWiyIIRbzQBgkTsJatA3tQ1jIdWoRYNFqYdRZCn7au/Bpncb6a1ZGUoNZr
 veOdqao2/+Te2fbcfnFAXojFIqaOAa4seJu/veOl2BntXSj3JwfqMLHfyIC+4lJUtYoP
 R8P7+MX2/PLt5N9XSZRd+7Q+TqUb5VgcDGkiabHQdiSKe/I+nhhj9eEzMnKfJLF2Jexl
 UOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725375845; x=1725980645;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JN9BgUwppSh4gEW8vFcrzYVmU+3v2Krq1mU5gJ5qdrc=;
 b=Yjxo8yfTrgUJFMc65Y1VLHGYAe0JKxwTy1EMnh0jkTnaObyDmC96NUNJfvQqVy7RtI
 f8TwyyplCPBPKjyUuQbH1zAehEbR+HypSP16zgU42qhZPB1PIfVy9xTLwyc5dXvIEL6m
 ZgpqhCfFHfu23Fb1JvswpjlXwqvduQ/tyCgIF/vMBIgWhkSZK7vVsIwTVyt0xd0YpzPR
 V0J/BKcjbQxZCzzm/wOSOPaxMptGQKhMY9mjeKkXZw0Lhn6kKIzEaCGJu7oIXPtRlniz
 LYIifNXI4ZOnGc67aW387cvCYuCf1a2soPdIA9yWirmLJw1w+GHgMNZCAUvAk2uQMJyq
 9qGA==
X-Gm-Message-State: AOJu0Yz5kywtkQubwIF4OIpIuxQwqPIVBLFk8BPlTIFRbkqnHqps64UA
 ZRVbczO19O2kXLtRJbR9DmNA+KcQSoYy0p34mHLaqt1nJP/XAZGM6VxNQvmslJjb4zcJs0WaDsx
 SgK5QONRXoRngsGwUao4YoWEFjQse2o1bFmcmOA==
X-Google-Smtp-Source: AGHT+IFvKpRs4eShT0F79ax0YlgV7FTGD5BQITGk7xecedc/YiK1F3UF75GbQXoxIrs2KgMRHIwyVyAO+n1HAK/S13I=
X-Received: by 2002:a17:90b:38d2:b0:2d8:b205:2345 with SMTP id
 98e67ed59e1d1-2d8b2052574mr9355773a91.23.1725375844927; Tue, 03 Sep 2024
 08:04:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
 <20240819210437.GH1626301@bill-the-cat>
In-Reply-To: <20240819210437.GH1626301@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Tue, 3 Sep 2024 11:03:53 -0400
Message-ID: <CAEfUkU+SDHcAb5sJe5ccRzQ9NjNq3g7MGsr15WWtX16sfxY-uw@mail.gmail.com>
Subject: Re: [PATCH v6 00/28] Integrate MbedTLS v3.6 LTS with U-Boot
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com, 
 Stefan Bosch <stefan_b@posteo.net>, Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sumit Garg <sumit.garg@linaro.org>, 
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

On Mon, 19 Aug 2024 at 17:04, Tom Rini <trini@konsulko.com> wrote:

> On Fri, Aug 16, 2024 at 02:43:49PM -0700, Raymond Mao wrote:
>
> > Integrate MbedTLS v3.6 LTS (currently v3.6.0) with U-Boot.
> >
> > Motivations:
> > ------------
> >
> > 1. MbedTLS is well maintained with LTS versions.
> > 2. LWIP is integrated with MbedTLS and easily to enable HTTPS.
> > 3. MbedTLS recently switched license back to GPLv2.
>
> Whereas I think v5 did well with global build with mbedTLS being the
> default option, v6 blows up so many places.
>

I didn't enable it except qemu_arm64, sandbox and nanopi_a64, I will run
it on more platforms via CI.

Regards,
Raymond
