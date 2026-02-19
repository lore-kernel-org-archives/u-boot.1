Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5471E9A048
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 14:31:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6F0B83D8A;
	Thu, 19 Feb 2026 15:31:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="F0YgUKw6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 801F483936; Thu, 19 Feb 2026 15:31:32 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62B0483936
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 15:31:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-65807298140so1465265a12.2
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 06:31:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771511490; cv=none;
 d=google.com; s=arc-20240605;
 b=KT3VmKSXs743qGJwQhBbwnUYi3FzQcBkifUBwyFVj2h0IBQGiNYslUKuEkCuGxHK2H
 v/dRRNik/eSXyacsnwzmLRZ+nDu6azCit2GcB5uud3hUtx3nxdK8KIMh7Nl3wkhiSYm4
 0iajA8UrSke9ahk0G5f3PY8tq0xxhlCMpblo8McfeCQaTxziloySQaC7dBHV9Jecxzxs
 cNYa2U8k19PKQhvQ+CO3Kv7c4+tKE/h+/yIP4p/g0CpFH6UBMYlXRFRH9eZ/PZRW/d0q
 tcNqHzbQHYipUbgz/TsonuShCG5jsuLTK8AXtAHJf84LkrUxPaRzfLCiL/r+udKkaMLv
 wE7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=oYQJeeEbaWEBUufd1KoQI+RA1/toCfib5hdSlGVoooU=;
 fh=Yuk3V/34b+FX9QDxa4PDTsq/QGIOsBiUqlZ9jSvK7ig=;
 b=LqsscWspabx6iMtF/8ybYExTEEO0H9yYUqEqgVQdUqKjP3ShlY+7flAYytk4MLzqkr
 iTLl7uJm3l8aYGBAhLPcubNbM4FFCuksoT66YrFRsrfITrCqrRWkbFjT028H6R8Dz4qk
 4MHAQrKjloyxub0gT7ASyxY0FhHBcvmAHewyfh8W744jSTBxq/Nrj9fbao4gVkWupVkW
 KOjDnTO7dLQ3zwN6iWn5LhjQJhIddeYMzufbqmjLS+UqJ+lMhaF6mQRz5fwGCPoVS8YC
 hdmBXjoEU439u6c3cJQ5m4aw6bErzLEAxWfM6ZSyY0eNqQPGv9ltZw56gMX/GWnuBKeQ
 sI4w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771511490; x=1772116290; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oYQJeeEbaWEBUufd1KoQI+RA1/toCfib5hdSlGVoooU=;
 b=F0YgUKw6X5wStQmBSqQnXzH214lC7LY2n32XytTZcoWPcSD/6G5Bml0eJu6YuMmfYd
 lA6gyRvMmnHwo+9xHKlW4eHwrlGqQmixxMgDYxtyDNf1CRIKl4c+BLn877ie8tA0Hwqc
 1Cwftqn2RoXogaXe1uudQrPIccRdMC06lm+To=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771511490; x=1772116290;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oYQJeeEbaWEBUufd1KoQI+RA1/toCfib5hdSlGVoooU=;
 b=JNLykf0dwIbBj7uJPTvQ0R8ZYn6KoCcac/EhgaaZyFIoe6Scp3+jY2iTUJZCAvByEC
 fkqGwY0pLuinwuuxYVfzZg2Z4EGRw2x9r6L/CSQLBFB43Rv0qula/aRR0hwRdUAh1wYT
 a0F7gqHfZS7228YpZoFkkub03CaIxzBYTii04WM/Q0HjLQbdh8zmFIWZl4fgEgEYQS5M
 JkifjH2wPdXyvRs12lB27K44jwihxkOIsG2+Ech1P9Lva4cMfJOMPstkBdeH6oLRdusg
 xGEwW7S5dmwflBw123Ovf2bAzN+n3qBJIfRqh+9TCLSvLYEjgS7kggTW1CjXpSeXOtAI
 z9kA==
X-Forwarded-Encrypted: i=1;
 AJvYcCURe4+PWGg5DwryNqsz4c0wifEdMCPYv8KsUQsaOuElUMKgtpVqcVmI8orespeEYzbGKYnar9g=@lists.denx.de
X-Gm-Message-State: AOJu0YwQ/O+HRxJvGiB5EpK8GcQiMcsQWG7cSDRvj78yH6kBuXhGaVoU
 p8pQQtLsAb21UXfqUGayyWXr+eXG0zWLOQ+Qd5AQ7qL21Xfwlx8wXr+b11/x62K7rxNALywk39g
 B2AqsxMegvjkOQuzEiCfyKYZ159JldePIaDhEsQ++
X-Gm-Gg: AZuq6aJ7Bzd1NmOvjgK9U6Vf63aHWK2HCSFu0mXJUKj5khLLJS0Ra+viS669YxRoCst
 keTJob/FJOCaAfjRtVS72RR/MifAl6MbFd4haxgsTpJpLzewzCJurzXN2zzDiRXXgGa5peL3XvI
 rFWTUIdLsEgnVF1DwbH6DG3PoXqEw55NlECKUA6/TxEaJz3KJXANegIkqG0v4fCJSdMSsToQqIa
 JK+G1GJy44s57pBNEjBAC/xdtUZ9qQfOtwRf9lm6OczcSOqUJ60TBkkLVCzngjHxexNBsexmpRX
 1eLShQ==
X-Received: by 2002:a05:6402:5106:b0:65c:2120:4055 with SMTP id
 4fb4d7f45d1cf-65c76a62449mr3431989a12.17.1771511489647; Thu, 19 Feb 2026
 06:31:29 -0800 (PST)
MIME-Version: 1.0
References: <cover.1771275704.git.daniel@makrotopia.org>
 <46dcab5fc58e9116ca017a63ed07922ae3093913.1771275704.git.daniel@makrotopia.org>
 <CAFLszTiE82Bo1PbvK7Lx7P4Gq=-z+hhgLcgXORtSrYha4R7sBg@mail.gmail.com>
 <20260219140002.GI3233182@bill-the-cat>
In-Reply-To: <20260219140002.GI3233182@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Feb 2026 07:31:17 -0700
X-Gm-Features: AaiRm53SWZVwcwouP1uZidfWMjxKmehIHvRSidL9npsCTt-ghO42VeMdcPodD_c
Message-ID: <CAFLszTj9BzFK3hcRRGtwzZWBO39WwtLjbYJ9ajFQ_c2+rDU=FQ@mail.gmail.com>
Subject: Re: [RFC PATCH 13/20] boot: bootmeth: add OpenWrt boot method skeleton
To: Tom Rini <trini@konsulko.com>
Cc: Daniel Golle <daniel@makrotopia.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Aristo Chen <jj251510319013@gmail.com>,
 =?UTF-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Frank Wunderlich <frank-w@public-files.de>, 
 David Lechner <dlechner@baylibre.com>,
 Osama Abdelkader <osama.abdelkader@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Mike Looijmans <mike.looijmans@topic.nl>, Weijie Gao <weijie.gao@mediatek.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, u-boot@lists.denx.de, 
 John Crispin <john@phrozen.org>, Paul Spooren <mail@aparcar.org>
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

On Thu, 19 Feb 2026 at 07:00, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Feb 19, 2026 at 06:09:28AM -0700, Simon Glass wrote:
> > On Mon, 16 Feb 2026 at 14:23, Daniel Golle <daniel@makrotopia.org> wrote:
> > >
> > > Add the initial bootmeth_openwrt driver with:
> > >
> > > - UCLASS_BOOTMETH driver, compatible "u-boot,openwrt"
> > > - check(): accept block devices via bootflow_iter_check_blk()
> > > - bind(): set BOOTMETHF_ANY_PART so bootstd iterates all partitions
> > >   without requiring a filesystem
> > > - read_bootflow(): stub returning -ENOENT
> > > - boot(): stub returning -ENOSYS
> > > - Kconfig: CONFIG_BOOTMETH_OPENWRT depending on FIT, BOOTSTD,
> > >   BOOTM_STORAGE
> >
> > We don't normally write out this much detail in the code
>
> I assume you mean the commit message? And yes, this reads like an
> AI genreated (then human proof-read) commit message. Which is something
> I wanted to address, once done with the open questions I still have in
> the cover letter.

Yes I meant 'about' the code not 'in' the code.

You can normally fix it by asking for prose, or giving it some general
instructions.

Regards,
Simon



>
> --
> Tom
