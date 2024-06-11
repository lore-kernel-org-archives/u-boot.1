Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8146C25B76
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 10:10:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A4E787FED;
	Tue, 11 Jun 2024 12:10:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZET1jA55";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 595BF885E3; Tue, 11 Jun 2024 12:10:05 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BB4E87FED
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 12:10:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-57c714a1e24so908114a12.2
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 03:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718100603; x=1718705403; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BNBDxEJQQPTqoKrDzvv+efLQRZYDlDtdjzZP2OnDea4=;
 b=ZET1jA55Km/ZkxJX27PjFL/T332Wwa0Xc3qnrDkyh1OSlI17LRCZ7S73z2zLmKS5wu
 W0D715KxGaLvoyaArkRQgcSZG/GCOJ1ybtSFomH2w1RsPehy8krjMd/ytvSdMxCO517s
 RN+kdH0DcU3ZowaJzitlFGoLr/5ggZ+LsEwXZzBpQMHxxG83hMNsG3hz1BDrI3i8sRPn
 sYpbw4x80H71jibLeIHwgsG5CRznGGEt+2OOUNhenrXfBn1U7/mtQ9yGxuQVRpAGmA1Y
 NrKVqjcHDU4fXdqaZCePi8E0NU9GezCv2nTt6IJLKiqHw2lvaVfJAjf+1NyVDWKcB/E1
 hcdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718100603; x=1718705403;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BNBDxEJQQPTqoKrDzvv+efLQRZYDlDtdjzZP2OnDea4=;
 b=XzQnvRe6bdBITQMCObyuZd/yuERB3fvCKb3txFqulVLP8eyCRMuyUUhL2b/q3vo6+/
 kc3sp26m6a17a0D6Z/s3rcMbJPo6+UcDXdN5Q0v8BxogBIQA+v18ruY5uSO6613riPKm
 iDr3gTI4GydBXDI1kbyO1KIn6zYodHST/WjVub2wXHjbLUPZrD9MVYje4yK218TrxqPq
 z608b+a7g2di/WkHCEm22ThJpE7GzG4T9ZCpiCOA1OIyZWpdBu7yrTZN667Olq9g/Sfo
 z4vfeP+QsWxzvswNcA8lVDcGycT/Hxn6x0o6bU8lqe5JmQg4bfeJBz01JbtNdgi7CXHc
 ydBw==
X-Gm-Message-State: AOJu0Yy/wgG6Vrb4eaHpOpcHDrIEIot3aiOkDFBlwtqEtDHt5DavAMJO
 zdbRJF7fc9umYnqTCfPmXaT7M+WecNuXKhRbJbABuz5h1d/fLdRFKm8J2BRDp4RMEwC2omNFenA
 2eWd67aaSH3etPAfp0D7WMwdbk1Xj+GMLni2ecA==
X-Google-Smtp-Source: AGHT+IEPLQEMD0HkRoLcq+VdTAgVOEkx+oEfAcdybBdFzvOoYB3r/WcNgCgy874PlZP5eLsYqaxfQiNyY/oBxaie6n8=
X-Received: by 2002:a50:d59d:0:b0:57c:76fd:11a8 with SMTP id
 4fb4d7f45d1cf-57c76fd1258mr3140534a12.40.1718100602535; Tue, 11 Jun 2024
 03:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-23-sughosh.ganu@linaro.org>
 <20240610174450.GX68077@bill-the-cat>
 <CADg8p96rjN48peBf=cxbs7k7ku0stV-4bBhL5+RrTnPJVS1tjQ@mail.gmail.com>
 <f490a30f-046d-4bb1-bbc2-5820f4623ca1@gmx.de>
In-Reply-To: <f490a30f-046d-4bb1-bbc2-5820f4623ca1@gmx.de>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 11 Jun 2024 15:39:49 +0530
Message-ID: <CADg8p95dpvBsEzTG_-oBN7OLcWH=fXA2=k62SzrJXFRNDyaWHw@mail.gmail.com>
Subject: Re: [RFC PATCH 22/31] test: lmb: run the LMB tests only on sandbox
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>
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

On Tue, 11 Jun 2024 at 15:31, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 11.06.24 10:55, Sughosh Ganu wrote:
> > On Mon, 10 Jun 2024 at 23:14, Tom Rini <trini@konsulko.com> wrote:
> >>
> >> On Sat, Jun 08, 2024 at 12:22:31AM +0530, Sughosh Ganu wrote:
> >>
> >>> The LMB memory map is now persistent and global. Running the tests for
> >>> the LMB module will result in the memory map getting reset, and this
> >>> will have side-effects on the rest of the working of the platform. Run
> >>> the LMB tests only on the sandbox platform, which is meant for running
> >>> such kinds of tests.
> >>>
> >>> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> >>
> >> I'm not sure about this. We can reset real hardware as often as we need,
> >> too. Did you run in to problems with this test on non-sandbox?
> >
> > But do we want to reset the state of the LMB memory map on real
> > hardware? This was working up until now because of the local nature of
> > the LMB variables. But if the LMB memory map is to be persistent,
> > should we allow it to be changed for running some test? That would
> > have side effects? I think running these tests on sandbox should
> > suffice. I mean there isn't any aspect of the LMB module that is not
> > getting tested on sandbox, right?
> >
> > -sughosh
>
> We should run tests on systems with different bitness and endianness.
>

I would think there are platforms in the CI suite that are big-endian,
because if there are, they are surely exercising the LMB memory
reservation functions multiple times. I am only talking about running
the unit tests on sandbox.

> As the LMB test does not rely on any sandbox driver we should be able to
> run it on any system.
>
> If the memory map is not usable anymore after the test, the system
> should be rebooted.

Yes, that will happen when the test is run in CI -- I am working on
changes to have the LMB tests run separately and then reboot the
system. But if the tests are run by a user manually, that might have
side-effects. Btw, even today, the LMB tests only get run on sandbox
as part of the CI run. What happens is that the tests are enabled to
be run on other platforms as well(snow as of now).

But OTOH, an explicit reboot can be called after having run the tests.
This would handle the scenario of a user running these manually from
command-line.

-sughosh

>
> Best regards
>
> Heinrich
