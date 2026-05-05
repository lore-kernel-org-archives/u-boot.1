Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F38FF8855
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 14:01:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2272184948;
	Tue,  5 May 2026 16:01:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KmsmR3qL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D69138494B; Tue,  5 May 2026 16:01:44 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A3FF848FC
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 16:01:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b936331786dso629231166b.3
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 07:01:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777989702; cv=none;
 d=google.com; s=arc-20240605;
 b=Qayn6tmwjhmOyeQ3VtZbpSCnrKOaGoBBcCfb63ONokGUoMeWCmWOZdKNzS1FoBYETB
 cTnk7fmlSMApIubWNG1A65mpx35tBJtyJulFoD1iShxdmSTeJ4Y0ScCIhCJsgJ0BNWbB
 O2gsq0YsXVsFRyB09/BZ0yaxjx+aZLIrWBsV+yDaQ9YeUP4UaSRtHlCOUt7sL2oAWv+g
 77GLbNJ+HWBNV63gESyZb9UaKScaIJF5V+GM1I92RLwhar0KmNL2s7qUSGk/JBaScaWV
 4EoZoXES273oc7K2pkOmfsgM7sI1/urGIZlr+z5tQkI1jmhXlXoOj/TSlTImvVqeTR6O
 rvgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=x343E9z+qsopH5kFKKA+qiVrnv11WGyM1PP4qkFx96A=;
 fh=GpG0ILApjOziwMpWxVdtEc+pDfvf/OdWX72BncHhg/s=;
 b=O8Q8yJzjwEmS3852Q4lH7GpQztsxUuRoEyN/wcHG5usUqNLdQSWsojX4XAL/M/Pd18
 Jo3UdyiLLNsLiYHsUzxF9Nfw58umf+bAIcss4cvDEdZgdn7kSygBd6JAi3ABqt2sTXZe
 XfFcN7QZqf+u4cOWIVDpYzjjdbemfgmJPNtcl2D4LcD68k57VfHBc7hG4bky/OypUO3h
 JFKY/gh/b4Iy5cVfrDfq0eEHxjxH0chQmKmSKDlrVaR/73w50ES+ukTY9VGA6h16h2u1
 dVF1qd1BAiZ0tnx20iGApaNH+pCwBfHj+WO9rdSOE8p3Otq3P+rhjyxLsSc/Q7yQj4m/
 ivjw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777989702; x=1778594502; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x343E9z+qsopH5kFKKA+qiVrnv11WGyM1PP4qkFx96A=;
 b=KmsmR3qLEC+pRV09cTCnD/uBxg3PBkYQSrh3k+Dd7EAdkaRmECOMp4pEOf5R85OEQW
 JYskYopWz5yElxAKrIFvpMzBxcOgEhuTnA+EmjLr2nHBHOEqIvJoSeOurIBaeTMMKPQ6
 yDslq0AivjVmx93fmDZtIqy53Dh4SWz35Qr8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777989702; x=1778594502;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x343E9z+qsopH5kFKKA+qiVrnv11WGyM1PP4qkFx96A=;
 b=ajqmaM+mWj38xBSDxXbjn6gA4yvfQ3D05BLjpkKnADIngVPpQEvVsWYkO0apAqyAhJ
 Va3qi+UqCr+atZil/ocSzv0v6r+g9iCdgZal49GvyfFleHjitclbpOI/81fGdmqiCO2Y
 l12isbpMLEE7sa7JcQCuzjqvPFtc0XwqM0yuqpEiCWgPUMpAPo2atVPw8uNCBX+hDnxx
 bcwBBZ+dBYb7pys84GiN7syyv8qJiVQQERWNN2bJzpKJjgNVa5ltg6ALll42jz9zHNCB
 +VoyPJD+ugnEu/+u8I4ZUEJ3ca/GQLXfPJVszzMJTtEkiXzez3EpNUNEE5pYLsVgbBLp
 xIuA==
X-Gm-Message-State: AOJu0Yzq9YcR2wcgtbeBW4crAc65zo8e7l8nZLoGCRQEq3HtIN3af1SY
 uw7MmcDL41Qzxu7tZIyeW+Tyf0eBV7RlrLULDcS68sqmnqliPYP50yRXKzmYHPaWnNBDv66NMD4
 hQkoVMz+YiT0TKvXlnziErX7jNP19KYH10fh2pAMMVbBQEiTVow0/PQ==
X-Gm-Gg: AeBDietVcr63yvbeq4QDXRrlGSmxrs3AhUbO7I3DhPt+1ydPNTsTXuo6OOQ9bxtgT3Z
 75SPDrnmpSuhpspyBc8XHIIHcOqlGagJTj2c2DIApuWcivqLQWaneimT/bk1vwZh6q1dLiCHg0/
 Dh5M3whlj/gPqxdEIX6cxHpUjclnOIee54UEQ7Xa/soUwCeQ9C9BUXMWztkWv/R2+phB5k9n50q
 /TDgxIE6YxCSLBhI57NYoXKHUIFOQL8o0oWFpkdLfhSW+eZ7q/gLEe1sS8zlwXk1KiRfPwRf40h
 fNUmzxT4UvFX4PM9
X-Received: by 2002:a17:907:c312:b0:bb8:fd89:4a30 with SMTP id
 a640c23a62f3a-bbffb95a912mr835196066b.31.1777989701694; Tue, 05 May 2026
 07:01:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260429141850.1.6f48ecca7f833b4f4b90ba78432475de1461e838@changeid>
 <CAFLszThHeODorsKtPCqFYmfSPuCJNGMTvdtUQ10yiHRhJnuCPA@mail.gmail.com>
 <449bbab5-3451-4034-a643-771d9ddb0567@siemens.com>
In-Reply-To: <449bbab5-3451-4034-a643-771d9ddb0567@siemens.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 5 May 2026 08:01:29 -0600
X-Gm-Features: AVHnY4K--5BCPLFWHAqR6F8YKXckscOxkbB4WQbHtaej-Nas5EMQPdLWlocS1BM
Message-ID: <CAFLszTif8nRi8MGVmgj0hwbkCm+P3YV1trfvuVU7XxwiDAOeLw@mail.gmail.com>
Subject: Re: [PATCH] patman: fix use in worktree
To: Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

Hi Ludwig,

On Tue, 5 May 2026 at 02:25, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
>
> On 5/4/26 14:31, Simon Glass wrote:
> > On 2026-04-29T12:18:51, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
> >> patman: fix use in worktree
> >>
> >> When using a worktree '.git' actually is a file and pygit2
> >> init_repository() does not like that. The intention is not to create
> >> a new git repo anyway so use normal constructor instead of
> >> init_repository().
> >>
> >> Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
> >>
> >> tools/patman/cser_helper.py | 4 ++--
> >>   tools/patman/cseries.py     | 6 +++---
> >>   2 files changed, 5 insertions(+), 5 deletions(-)
> >
> >> diff --git a/tools/patman/cser_helper.py b/tools/patman/cser_helper.py
> >> @@ -309,7 +309,7 @@ class CseriesHelper:
> >>           self._copy_db_fields_to(series, ser)
> >>           msg = None
> >>           if end:
> >> -            repo = pygit2.init_repository(self.gitdir)
> >> +            repo = pygit2.Repository(self.gitdir)
> >
> > Thanks for tracking this down.
> >
> > There are more init_repository(self.gitdir) call sites have landed in
> > cser_helper.py and cseries.py - please can you convert those too,
> > otherwise the worktree case will still be broken on those paths.
>
> In which branch? In master I can only see init_repository() references
> in tests.

This is in the master branch at https://gitlab.denx.de/u-boot/u-boot.git :

$ git grep init_repos
tools/patman/cser_helper.py:            repo =
pygit2.init_repository(self.gitdir)
tools/patman/cser_helper.py:        repo = pygit2.init_repository(self.gitdir)
tools/patman/cseries.py:        repo = pygit2.init_repository(self.gitdir)
tools/patman/cseries.py:        repo = pygit2.init_repository(self.gitdir)
tools/patman/cseries.py:        repo = pygit2.init_repository(self.gitdir)

(I've omitted the 'test' ones)

Regards,
Simon
