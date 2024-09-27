Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D141FCDD1CD
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 16:52:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3071689148;
	Fri, 27 Sep 2024 18:52:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I3HYSbIF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E195B89150; Fri, 27 Sep 2024 18:52:51 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB12389133
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 18:52:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6cb259e2eafso20369976d6.0
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 09:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727455969; x=1728060769; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WO7oXAMxl9zS3HB89ycSybVjvqNYFoBB790ZqN4KMhk=;
 b=I3HYSbIFJH6PWSZzlnazgh6t7/jOF7ATC2qMGNMWZ3WXTSzpa6SNkSsAApvzzNskIJ
 rBPPizS5xeyzR3T+KvDkGykFz2DV9ONSWboW3HPSAlqi8anuw7QtyCf/fkj46oCiAaH6
 YPfmhoa+73HOoT8EMKDXsiT2eSz6rYeThF4qQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727455969; x=1728060769;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WO7oXAMxl9zS3HB89ycSybVjvqNYFoBB790ZqN4KMhk=;
 b=RLFZRkHm0TX4RjY5qKCmEz6o7gb++oHOh+G6r6kVlTRs/w+Ak76p2Mg+OuZ463YUUY
 ozAOzmZKpaZKjXTRTfV5gchpZ+fM+6Bn+U7a6MID0emG37/yboU6UnHCcXQczdKo80IO
 3FHnbn7a/9QQIBioviE0ekjGP1QGTP9CO0uv/uM28Cy2vWvpxxUXYnSNThXYHJaAcTB0
 9AqalKpKF5vgJLkUjfY8QBfbdjuKmZ9APlBaQNoDgVjBKObFC7S8cHzBlR8hrKv2FqrG
 AEJSFHODufyrYAqD3ltGUY9pK/VMlPl4WvEiltY+sJx5RL3hfk/bhX0GN5zyLogbNvX2
 bL0w==
X-Gm-Message-State: AOJu0Yw9FZm29cFywQdmsO65Y1tGQsDEVeT+eWGr404Lo+9gjmUxJUtA
 VE4WzbKp35DjSYECfrzBmTR+3IzRNllziy+gQfMHeclvgnGBdeWqgWSSkOIGu6dRDWvPKmk+6V0
 JHEUWV5jjOumK7Xxl7u1NQD1ubMUgNIU26ckU
X-Google-Smtp-Source: AGHT+IF3Y5zc2yojFzBqr1ChTrMfQxDDpJY7eArBalCIgVwmSS9n6Jsab3vegUfLKCKY7Acwpne7LMOIyOYvoVxFPGk=
X-Received: by 2002:a05:6214:5907:b0:6c5:5388:6ecb with SMTP id
 6a1803df08f44-6cb3b405463mr90188876d6.16.1727455968769; Fri, 27 Sep 2024
 09:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240926223009.1270197-1-sjg@chromium.org>
 <CALeDE9M4DrdsDrJEGehWuXyfNSd1K=sWE8RpSk6W5uySBoGUQQ@mail.gmail.com>
In-Reply-To: <CALeDE9M4DrdsDrJEGehWuXyfNSd1K=sWE8RpSk6W5uySBoGUQQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 27 Sep 2024 10:52:38 -0600
Message-ID: <CAFLszTiqqiQD3S03y3_g8LDehJ3dE1stONUzm+MWHEDppZCMjw@mail.gmail.com>
Subject: Re: [PATCH 00/27] led: Remove old status-LED code
To: Peter Robinson <pbrobinson@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Albert Aribaud <albert.u.boot@aribaud.net>, 
 Alexander Gendin <agendin@matrox.com>, Alison Wang <alison.wang@nxp.com>, 
 Andy Fleming <afleming@gmail.com>, Angelo Dureghello <angelo@kernel-space.org>,
 Doug Zobel <douglas.zobel@climate.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, Johan Jonker <jbx6244@gmail.com>, 
 Kamil Lulko <kamil.lulko@gmail.com>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Mario Six <mario.six@gdsys.cc>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Raymond Mao <raymond.mao@linaro.org>, 
 Sean Anderson <sean.anderson@seco.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Wan Yee Lau <wan.yee.lau@intel.com>
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

Hi Peter,

On Fri, 27 Sept 2024 at 09:52, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> Hi Simon,
>
> > There has been an LED framework in U-Boot which uses driver model for
> > about 9 years now. Recent work is underway to improve it and provide
> > more features. It is probably a good time to drop the old code, which
> > is only used by 5 boards:
> >
> >    ./tools/qconfig.py -f LED_STATUS
> >    5 matches
> >    eb_cpu5282 eb_cpu5282_internal mx23_olinuxino pinephone
> >    socfpga_vining_fpga
>
> Why aren't these boards being migrated to what ever the new frame work
> is rather than dropping quite useful functionality on these devices?

I don't have any of those boards, but perhaps their maintainers might
like to weigh in?

Regards,
Simon
