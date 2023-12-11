Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D97DCC4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 17:54:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5A28877C6;
	Mon, 11 Dec 2023 18:53:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mihBtlyK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF350877BA; Mon, 11 Dec 2023 18:53:11 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DBD4877A9
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 18:53:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-dbc662854adso2007681276.0
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 09:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702317185; x=1702921985; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=petkZ4p0QHcTWt9NS/GnWE9K1OqBj6pxmd7IMetzKRY=;
 b=mihBtlyKKNow0e2bWi8J8w/zpw5ATQiYLKk+6xQgTIa/1ljp/LtzWxFQi33RDE0h6+
 JqpL/vvSVrfbpdGgoVsG8uKztRUHiuGPoFum+255IuwbQxKhxodKlsoctn0H4RCOM+eW
 rV8U55q0oPkbnO2UFumczbBe9lIS5wghoOEbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702317185; x=1702921985;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=petkZ4p0QHcTWt9NS/GnWE9K1OqBj6pxmd7IMetzKRY=;
 b=kVszRz0t4axH+dxLJD9DPUrbvfyg252epDAFaaKqpWZHjOLaYgBJb9N1qsojmTM12b
 gf+r7djg4gfU2LjN9FA+ag8m+/XHqISM12co/h4jAgOr/0hVyn6C7RVc2jGKJeC+Pa1l
 Jb4vzGnQuhHrcoqZTtxGnwYs5IVM8HtueZdzlJBHCkScYnFWtZDdTKj271HeiCShkyzO
 OWHdSLThJh7O+JwdlRq7r23+F0PswkDQxLSa1pAvwvdTK1TIEWK5fLnOIpZVnuwbOmyO
 xjynNp8HQ4EQKkmpe4WNVBjRzMT+Fg+ykhgFOPGSHaOzM9bS+XAkeu1qzfpFqxi6YB9D
 QFyg==
X-Gm-Message-State: AOJu0Yy99BJuyEsVvpmjK1ut4xTGIqomGwsoO0MMmF7Ul+CbCBylvwhS
 6rmJijfU5iRLoIF8Brm8HkPiAZv3RSALHJsmBKiDcg==
X-Google-Smtp-Source: AGHT+IE5C6SV8FY1TgUWxLBQnkwywB/6/VPxotRdso8ZB5NnNiYcnbjXXGnuc399jw/mqJCO9pzE0vsrc5K0tQv9AEI=
X-Received: by 2002:a5b:50b:0:b0:dbc:b0f2:94f8 with SMTP id
 o11-20020a5b050b000000b00dbcb0f294f8mr525564ybp.108.1702317184845; Mon, 11
 Dec 2023 09:53:04 -0800 (PST)
MIME-Version: 1.0
References: <20231204002642.895926-1-sjg@chromium.org>
 <20231209190932.GZ2513409@bill-the-cat>
In-Reply-To: <20231209190932.GZ2513409@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 Dec 2023 10:52:07 -0700
Message-ID: <CAPnjgZ2qtrJZQ=x32Z9ESsYkhRv+1aseHSpoJo9_VW8_uN+guA@mail.gmail.com>
Subject: Re: [PATCH 00/18] Complete decoupling of bootm logic from commands
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>, 
 Alison Wang <alison.wang@nxp.com>, Andy Fleming <afleming@gmail.com>, 
 Angelo Dureghello <angelo@kernel-space.org>,
 Angelo Dureghello <angelo@sysam.it>, Bin Meng <bmeng.cn@gmail.com>, 
 Chanho Park <chanho61.park@samsung.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Eddie James <eajames@linux.ibm.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Leo <ycliang@andestech.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Mario Six <mario.six@gdsys.cc>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Nikita Shubin <n.shubin@yadro.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, 
 Rick Chen <rick@andestech.com>, Safae Ouajih <souajih@baylibre.com>, 
 Scott McNutt <smcnutt@psyent.com>, Sean Anderson <sean.anderson@seco.com>,
 Stefan Roese <sr@denx.de>, Thomas Chou <thomas@wytron.com.tw>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>, 
 Wolfgang Denk <wd@denx.de>, uboot-snps-arc@synopsys.com, 
 uboot-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 11 Dec 2023 18:53:38 +0100
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

On Sat, 9 Dec 2023 at 12:09, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Dec 03, 2023 at 05:26:16PM -0700, Simon Glass wrote:
>
> > This series continues refactoring the bootm code to allow it to be used
> > with CONFIG_COMMAND disabled. The OS-handling code is refactored and
> > a new bootm_run() function is created to run through the bootm stages.
> > This completes the work.
> >
> > A booti_go() function is created also, in case it proves useful, but at
> > last for now standard boot does not use this.
> >
> > This is cmdd (part d of CMDLINE refactoring)
> > It depends on dm/bootstda-working
> > which depends on dm/cmdc-working
>
> Since I would ask "what's the size impact of all of this?", I went and
> checked. I rebased your current cmdd-working branch on top of current
> next, and compared. While I'm sure this will change a little given
> feedback so far, generally platforms shrink a little (probably due to
> the bootm args stuff you dropped, but may need to keep). The only big
> growth I saw was branch specific and your "rpi" patch, oh yes, that
> grows rpi_4 given that you change a bunch of stuff there. So that
> doesn't count.
>
> So generally speaking, I'm OK with this series up to cmdd-working, and
> will continue catching up and providing specific feedback.
>

OK, great. I have had a busy week but may be able to catch up a bit on
the plane.

Regards,
Simon
