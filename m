Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278D3C2BA18
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 17:26:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65410882D4;
	Tue, 18 Jun 2024 19:26:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xYPRBSba";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81644882F9; Tue, 18 Jun 2024 19:26:22 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53EE48812C
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 19:26:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1f862f7c7edso37872235ad.3
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 10:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718731579; x=1719336379; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e1ae6aAODTUheD5xSnAvT1mUBtURlEYXcJi4pA8nLvs=;
 b=xYPRBSban5V0vkLxsYQAFqiDaj44Cf48QlFqqosQ3Nw3IkCwlPNWH60BfPHdZo1wrt
 56Bmy66MzCJluA/in1/jj8II/FfA177EHYuCTROQWOvqPHI9Nr4wV4E1/3ra35gR2TI7
 zL6SHJSTLfNqpkGAJWVBf0n5cOjwJ7tMM++zcEpwygfv5kZokBxpQVydccf/TCLTSeLq
 e/DjchD8InAejZmYeM8VgGFaNwHFnj2cpGfw9BiASMLUCnG29nYBlDTJ0dfZtPlMv9AM
 62Nu1lMwJT/X+7OkdeExGBp9HNSNjvNdltw0hWjkaXYgDDvaL9MP4EGmp6a07x/3IhJ3
 pfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718731579; x=1719336379;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e1ae6aAODTUheD5xSnAvT1mUBtURlEYXcJi4pA8nLvs=;
 b=tMtt7pGA1/gQGeZciQs9qOItYNcRvd+cGoMsB8UxyUbnSovR1YmkQJx1EM8xIKJ8GT
 ZJLcKxkSY/IGo/FPgIWU0AnnCevPI7lKZZmzo8iiiBMVAiu56S9qGE7USrbcqGW3K9LP
 cayuSB32CwUuMKPKWEGy2NhcmTdjkT1lCMgEc04VlxTJz53Fk/wHgum8TD6lqPHls+mS
 mSFRlagQd0kve8W79RUbWKZA9bRs0GlQPzPhChnxb2/ad3zZfounm4r1B9In5grU6bfp
 X5XuLbWsZIGzkO8t9yUFvmf7M+VuoRkz7ndDJ/zc/eNei7fvaa5IL+zu667PpSRY2ebV
 FU8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtcFbPtFdKo3cDOZjolSxcxv5GpOT0Lg0Mwoz9tllOqOabiK8SA99JHCH6yNFbaBaB9H5a1IN28RlXc1DWbsIulf95KQ==
X-Gm-Message-State: AOJu0YzLxIBhd1KTJvfHnM7RF1zDgEz/+zMuJsdfN6Cx+BBP9YBislTm
 St9HLUafGv+g7EpRB9abOZMc5NmEtz8lpoIAnuPrAt8ClurSv8znNXq/7mBkgwSIbSJbhtBU0dW
 7QYpjRB1v7rkP+qHjKB8ROnkUKY1WbVvhnzvEsB9MxzWHDS6rsUoKwQ==
X-Google-Smtp-Source: AGHT+IGAOjKdFSS4Ie0PWVuXS24xX+89UCyb6XuizbO5bYezXvJ3rqY5/0pEP5qYSRCMHa7fh3FSvBtxrzhBGuAkzJQ=
X-Received: by 2002:a17:902:eb49:b0:1f7:1ba5:85ff with SMTP id
 d9443c01a7336-1f9aa462935mr2347645ad.57.1718731578678; Tue, 18 Jun 2024
 10:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240618154952.12314-1-ilias.apalodimas@linaro.org>
 <86iky6i4b9.fsf@udb0321960.dhcp.ti.com>
In-Reply-To: <86iky6i4b9.fsf@udb0321960.dhcp.ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 18 Jun 2024 20:25:41 +0300
Message-ID: <CAC_iWjJVSJCokmQsDVJphAVWX=vfwrDGmj=cqyiGHCvkPPbcug@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: adjust config options for capsule updates
To: Jon Humphreys <jhumphreysti@gmail.com>
Cc: xypron.glpk@gmx.de, u-boot@lists.denx.de
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

Hi Jon,

On Tue, 18 Jun 2024 at 19:49, Jon Humphreys <jhumphreysti@gmail.com> wrote:
>
> Ilias Apalodimas <ilias.apalodimas@linaro.org> writes:
>
> > EFI_IGNORE_OSINDICATIONS is used to ignore OsIndications if setvariable
> > at runtime is not supported and allow the platform to perform capsule
> > updates on disk. With the recent changes boards can conditionally enable
> > setvariable at runtime using EFI_RT_VOLATILE_STORE.
> >
> > So let's make the options depend on each other and clarify their
> > functionality. When EFI_RT_VOLATILE_STORE, setvariable at runtime is
> > supported and EFI_IGNORE_OSINDICATIONS, which also breaks the EFI spec, is
> > not needed anymore.
>
> Hi Ilias,
>
> Is there a corresponding effort to update fwupdmgr to set OSIndications
> (and set it correctly so the change persists a reboot)?
>

We are not trying to fix anything atm, we probably will in the future.

> Otherwise, fwupdmgr provided capsules will now get ignored for boards that
> enable setvariable at runtime.

That goes beyond fwupd, EFI variable changes will be ignored in
general unless you sync the file manually -- e.g. dd
if=/sys/firmware/efi/efivars/VarToFile-b2ac5fc9-92b7-4acd-aeac-11e818c3130c
of=/boot/efi/ubootefi.var skip=4 bs=1
after every variable change. Unless you do that, enabling
EFI_RT_VOLATILE_STORE makes little sense (and that's why it's not
enabled by default).
So, I prefer making EFI_IGNORE_OSINDICATIONS, which was a hack,
mutually exclusive and start going in the right direction.

Regards
/Ilias
>
> Jon
>
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >  lib/efi_loader/Kconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > index 430bb7f0f7dc..c84064de1366 100644
> > --- a/lib/efi_loader/Kconfig
> > +++ b/lib/efi_loader/Kconfig
> > @@ -220,6 +220,8 @@ config EFI_CAPSULE_ON_DISK
> >  config EFI_IGNORE_OSINDICATIONS
> >       bool "Ignore OsIndications for CapsuleUpdate on-disk"
> >       depends on EFI_CAPSULE_ON_DISK
> > +     depends on !EFI_RT_VOLATILE_STORE
> > +     default y
> >       help
> >         There are boards where U-Boot does not support SetVariable at runtime.
> >         Select this option if you want to use the capsule-on-disk feature
> > --
> > 2.45.2
