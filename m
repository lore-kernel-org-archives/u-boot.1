Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46ED4C83F1A
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 17:41:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B162882C84;
	Fri, 11 Jul 2025 19:41:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yTDEVWkI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70B2A82F6F; Fri, 11 Jul 2025 19:41:28 +0200 (CEST)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 411868277D
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 19:41:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-311bd8ce7e4so2146438a91.3
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 10:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752255685; x=1752860485; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uqXCCpzu0Xc59qOw0Os+9vJKZ1TiwoJAdlBtaqJb/54=;
 b=yTDEVWkIMB5Yri5whP8nRVTpLlshLbhD0PotMMJPeMRVDgjP16trPbMOyQwXXiJ53J
 vUUEJO72ZKA2MjxLckwnaFSF451Cc/3Gb9/gxPMRLPGaAEXF1bH6YoXXivFwDU+RUtHQ
 OsDqOuCsS/pJ9oeNDyedwifDB9AWUnI8kA/+vAelRXM6k6b71fc6rD999J7YVfSVYoAr
 gXEPexriKYA3YzqPiDJa1n5qZCX1l6cp7lGlV8wfu5nJHIMAaqFaIXu/FcD1trSCquXi
 kXpFGi8nvd/k4GXo07hYw0NGstGTgkhiBU5MIC5/GIHsTV/eeYHiJem1nxNTFakWo5Xx
 kFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752255685; x=1752860485;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uqXCCpzu0Xc59qOw0Os+9vJKZ1TiwoJAdlBtaqJb/54=;
 b=XDUEou5VqHw5OlD20B+dYPeDRcwTV+uFjMJLQbi7xv7rvFkvf0kDlKPcFHh8TCPmdI
 vTOnhT+BIThpoN+XyEwBlnfQvxjliTEyVRBpzXKB1irvVVOLgKPmXNeCbk6+OliIajsG
 TWn7zF/O2/QT9FsLIyEj2p2Lf727x9yivWjcN3VEcHtFjQIZi75DhyJF2HESnmcj1Oqm
 +CwCObq+o8Nlo7gHzsNfmr7TmyAx6WTNxUjnVzbGjIHQfEk2YdLpVZ5ShCE3gB9Ul9iH
 OJ0YNlU9LKh+4NPolLEeHpgy1v44oMJSc8gkBFXe8kLzwhEA56D8G6/MY4RBKyuVvjQQ
 o92w==
X-Gm-Message-State: AOJu0Yymd2wKJv6sy4DDjhPwKk2kPOwpRmv7pRclvIXNy1LpZJEGDflG
 7X8Q2N/Tzkh3810l1rzYq/RjNpeI0QtPjB4ugsGZp7x78DZMnwhvaeOhY7HRxbtt35P/6Zu0hmG
 CizNawKtigIyGoUZSRB2PU9aUpFB1aB4XV+utEOP/Z7jiWd9rRfzw
X-Gm-Gg: ASbGnctSrcSYiyDbJTSYrfuS6VzeWN008ZfU0m4cDjv/I6smZCw1RvM5ORMTHF4KGrE
 nF0YTdphDLgc+QoeU1+gsRByf+Uav9nSvGSXgVbC+6V1wKVbUSqEZ4h5v9DfkTxaGVnh2VzFYx3
 30NHcyISTQ9XXYYp4q1tS2knaYHALsasrM98gc0FMwHTaJb19XpLAtyklNYKHki3GJ2rrj6+VZN
 VmDnAd9
X-Google-Smtp-Source: AGHT+IFNdFo+pCb/VM8A1OBUWIomT32T4SXp1UMsm9vznF0L5nnQvWAU6VvYvHvh6fiiBjF72JuMHD6MJCwPH78y+HQ=
X-Received: by 2002:a17:90b:4d0a:b0:313:f9fc:7213 with SMTP id
 98e67ed59e1d1-31c4cd6309fmr5643797a91.21.1752255684712; Fri, 11 Jul 2025
 10:41:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250704134208.2895595-1-raymond.mao@linaro.org>
 <20250711154538.GI6424@bill-the-cat>
In-Reply-To: <20250711154538.GI6424@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 11 Jul 2025 13:41:13 -0400
X-Gm-Features: Ac12FXxuVnIpglGjW1T0BLH-mvAB-8_jGTLoxmTxhysSBckdErW38VsRHVOrXP0
Message-ID: <CAEfUkUKyTO9BjEWSRegVE-_f_v-cqVNCDbPapefEJ4KhVEVjRw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Add support for DT overlays handoff
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, venkatesh.abbarapu@amd.com, 
 Simon Glass <sjg@chromium.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Harrison Mutai <harrison.mutai@arm.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Levi Yun <yeoreum.yun@arm.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Matthias Brugger <mbrugger@suse.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
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

On Fri, 11 Jul 2025 at 11:45, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Jul 04, 2025 at 06:41:59AM -0700, Raymond Mao wrote:
> > The series include refactoring on bloblist and fdtdec to support handoff
> > of multiple DT overlays and applying them into the DT base during setup.
> > All changes are aligned to the spec update for supporting DT overlay
> > handoff[1].
>
> Which for the record and my tracking, isn't merged yet, and links to
> the doc update which also isn't applied yet. I'm fine with the concept
> but also thinking that applying this here to master isn't the first step
> towards getting all the relevant projects in agreement FYI.
>
No worries, both the changes to the DT doc and FW handoff spec are
still under review.
It may take some time to get everyone's agreement.
I will try to keep my patch up to date with the latest docs changes
and address all comments.
You can merge it after the docs changes are accepted.

Raymond


> --
> Tom
