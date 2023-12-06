Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D4DC4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 20:08:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC5C587243;
	Wed,  6 Dec 2023 21:08:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Z/DH41rF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC5E387663; Wed,  6 Dec 2023 21:08:40 +0100 (CET)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 198E286590
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 21:08:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6cbd24d9557so166366b3a.1
 for <u-boot@lists.denx.de>; Wed, 06 Dec 2023 12:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701893316; x=1702498116; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kjI9de/IC8Rs1ow/U0Rhd2rs6aCl8G10ySaqdYUyH3c=;
 b=Z/DH41rFoTRrdcuOQtQLOclGSZfIGb1otsEzSG3ShMUxgsmMJo4kbODsgLAy8+U/2X
 IbmvmCet5PN3ddNK/QB212o1saY/zGPaiByEMsBvLLSAktXbK1tCM6pEi6PjvOSQNsWH
 a8GaUEpgflGfuaJGkW9/3akH2wUzksa8ZmDjXLcm/v6EZvsehl2xakgQTMJHj3xCWqvn
 uL5X1kUYwVPj+bB2OrYRsOgVmAmsadBqbm6yR0pYUBps8O9s5deyi0JAwprntooNqyY1
 W0/Ksm9F6rd/ChU7Ny6LN7TJQlg4DsfQJlE+gEe8PK4YDAjrigp3P6bY//xmqOb0Ce/Y
 APLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701893316; x=1702498116;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kjI9de/IC8Rs1ow/U0Rhd2rs6aCl8G10ySaqdYUyH3c=;
 b=SwDa+gG1CkWU8Ib+tTKOidFd78uMeAqBI8JCd4XjM02rkz70GT7Da90W+8kQpsEr+e
 JbqklzyZK7Kf5wY2eT9JyB36tuXgy2yImM7qtc3IawR61Dptd0ZaRLTso6TaC01BfE4t
 OAboGIEKB1nGb1pBPdmYTvGE+NY/8+4Sji5Evy3lP4DuSLnYHunQtXQmOz1FAGZ5I9EA
 jqnZkrcGiJxlfQq1WtAPKIWSQSzzjzBQ2OSKXj7cJuk9lyZ+GLL0cH8BzkSabuOp8L7L
 Sk0HaHwq+BJ7MLkqso8MwRClqJy0i+CBG+B0BzIOvk4/T1TBih4YuKbC98YkkWxdvd0N
 EJMw==
X-Gm-Message-State: AOJu0YzHDyBRK3tphEATgDAPLhjZ8/eExL1LeZN8hVTZEy7h/ttbdqHG
 ANmB894y3zAsKx3B9rdbOYesqTZMhJTJZvrWlc08Fw==
X-Google-Smtp-Source: AGHT+IHtnEkENzadkJc1eVcmSYwvR9rmmpw2MAsMn2UAKx7/UE+cQgUFWLZpcINHyS9Dnl5FV1Jlpf2gyAlEHAgooJg=
X-Received: by 2002:a05:6a00:22c3:b0:6ce:a1be:ae08 with SMTP id
 f3-20020a056a0022c300b006cea1beae08mr610332pfj.35.1701893316451; Wed, 06 Dec
 2023 12:08:36 -0800 (PST)
MIME-Version: 1.0
References: <20231127195029.90951-1-raymond.mao@linaro.org>
 <20231127195029.90951-3-raymond.mao@linaro.org>
 <CAPnjgZ3_LJRBhTQHEuu_Ow+6GB4r8ZtdgEBtxxHtYG1m8LmJBg@mail.gmail.com>
In-Reply-To: <CAPnjgZ3_LJRBhTQHEuu_Ow+6GB4r8ZtdgEBtxxHtYG1m8LmJBg@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 6 Dec 2023 15:08:26 -0500
Message-ID: <CAEfUkULSsZuY-Yszg-O6H8PfQYWhMa2wJHgKO0N0ZtKnjQJ5fw@mail.gmail.com>
Subject: Re: [PATCH v2 02/18] bloblist: Adjust API to align in powers of 2
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, 
 Bin Meng <bmeng.cn@gmail.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Nikhil M Jain <n-jain1@ti.com>, Baruch Siach <baruch@tkos.co.il>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michal Simek <michal.simek@amd.com>, 
 Sean Anderson <seanga2@gmail.com>, Qu Wenruo <wqu@suse.com>
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

I am wondering if I shall put in your review tag as you are one of the
authors of many patches...
What is the best approach under this situation in the U-Boot community?

Thanks and regards,
Raymond

On Sat, 2 Dec 2023 at 13:33, Simon Glass <sjg@chromium.org> wrote:

> On Mon, 27 Nov 2023 at 12:52, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > From: Simon Glass <sjg@chromium.org>
> >
> > The updated bloblist structure stores the alignment as a power-of-two
> > value in its structures. Adjust the API to use this, to avoid needing to
> > calling ilog2().
> >
> > Drop a stale comment while we are here.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> > Changes in v2
> > - Update the bloblist alignment to align to FW handoff spec v0.9.
> >
> >  arch/x86/lib/tables.c |  3 ++-
> >  common/bloblist.c     | 24 +++++++++++-------------
> >  include/bloblist.h    | 12 +++++++-----
> >  test/bloblist.c       |  4 ++--
> >  4 files changed, 22 insertions(+), 21 deletions(-)
> >
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
