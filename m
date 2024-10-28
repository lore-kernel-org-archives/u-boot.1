Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A966D3E2C2
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 20:02:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61C5D89080;
	Mon, 28 Oct 2024 21:02:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Vxb6EVym";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C80A3890CE; Mon, 28 Oct 2024 21:02:34 +0100 (CET)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8501889080
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 21:02:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7c1324be8easo3985996a12.1
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 13:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730145751; x=1730750551; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H0Yrfhf8aWx4KxVZW2XStx6VujwtRe0IhgBI9hg/9i0=;
 b=Vxb6EVym8ucvMwKPgdkzV15U/jpnyUGlYQiG24hNhHOYRfr2xlD6GbokS4nrjeNLrH
 6fqgJWG/BXuu96hS+ai2O2tX+tAGLZz1FNEioSyayfyWEfnU3PXto+oNFfBjgZqnMp6J
 ANTSStFalF3CXJCOg9JdOEF08gdzmVD3y6cxhai69up44ptFYqoY/lai3KE4GsvQosCY
 i6NkD6qQxka+ehWvPxLUEHMX7Mu3u7jRb10+U5cp58qjEM03o5qnjUwEcjxPo55Ufh+y
 0rWY+gtXUIr6jmSteqqEHZYnYBlUhTeoDYt/TV4l45Tps/Fyz505wLzSnTpqFsmdnYuN
 a8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730145751; x=1730750551;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H0Yrfhf8aWx4KxVZW2XStx6VujwtRe0IhgBI9hg/9i0=;
 b=w+6d6gzNiUCyP0rkhIwNrhQaIMd6oEj7B3t8jbqZjTvc8rP0SEK97LBul7JJK7ZPMa
 AXE96gHcbSIkn3+x5Ev2O/MSLl0A9XJGBtsrB+vKSZh+Il4GVJkyxdMhG4WOZpQc3SBC
 AVxt/ViFLqUukgYuj5C7SmgvF5KJBpU4Wcj+5zyzwRY7cqudnS036R0VuHIC9iAfjIAk
 CZMjqTSSel9PHb2wRisPmoG89OX3P+DgkbgocGqkQFLrpqgB0iUBbMeyiwTLcF1uBcqK
 ZsGs3VYrVf//df8hZr/Yyvtam0/jEJaT0mro87u1CjwafmdLyJX6uri/4JGOQ7KwhDjI
 6dNw==
X-Gm-Message-State: AOJu0Yy2yxYiZHJFYb91ZisRXDwKbN52j4nVuV8/gyFzGuwM1XXVmHy3
 BLIFPqH++zmz3TH73fTvnB77+krAOdfvAk60h/jCmOpu9lTCl/UwiHh+La+zJ9qj/ulHZxAnXwS
 u+lm8f6d8FM+r97s411t89h3ps5240wKKpAjQOA==
X-Google-Smtp-Source: AGHT+IGrbFIfOfN01l6hTUiooIg90WBakJ4tFEU7HaIhxs8OHPFT/W57hmMSrppoyNOPjZSha6uZrl24viWCr9AfZmQ=
X-Received: by 2002:a17:90a:9a8:b0:2c9:90fa:b9f8 with SMTP id
 98e67ed59e1d1-2e91e84d2aemr1157234a91.10.1730145750940; Mon, 28 Oct 2024
 13:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <20241022200543.116343-1-raymond.mao@linaro.org>
 <20241022200543.116343-8-raymond.mao@linaro.org>
 <CAFLszTgRxuiQOZOr_fvAZjmZewKHPi3k5Hdd+CgeExpVDycnVA@mail.gmail.com>
In-Reply-To: <CAFLszTgRxuiQOZOr_fvAZjmZewKHPi3k5Hdd+CgeExpVDycnVA@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 28 Oct 2024 16:02:20 -0400
Message-ID: <CAEfUkUKJSVcuMGVVkiOYrGgknDrmzFvBa7LUSDgWU2T5GBuqVQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] cmd: update smbios cmd
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Stefan Roese <sr@denx.de>, Wan Yee Lau <wan.yee.lau@intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Alexander Gendin <agendin@matrox.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>,
 Peter Robinson <pbrobinson@gmail.com>
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

Hi Simon,

On Mon, 28 Oct 2024 at 13:05, Simon Glass <sjg@chromium.org> wrote:

> On Tue, 22 Oct 2024 at 22:07, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Update the cmd according to the changes of the smbios library:
> > 1. Refactor smbios cmd print functions to match the content defined
> >    by the specification.
> > 2. Add new print functions for Type 0, 3, 4 and 7.
> > 3. Update the expected pytest result to align with the smbios
> >    library changes.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> > Changes in v2
> > - Initial patch. Move all changes related to cmd/smbios into this patch.
> > - Combine with #9(v1) patch.
> >
> >  cmd/smbios.c                 | 342 ++++++++++++++++++++++++++++++++---
> >  include/smbios.h             |   5 +
> >  test/py/tests/test_smbios.py |   2 +-
> >  3 files changed, 319 insertions(+), 30 deletions(-)
> >
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> OK, so it should be possible to expand the test for sandbox to check each
> field? Something like test/dm/acpi.c ?
>

Yes, I can add some more field checkers in the next version.

Regards,
Raymond
