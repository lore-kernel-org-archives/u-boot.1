Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 796B0D767F2
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 18:02:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7580389318;
	Thu, 31 Oct 2024 19:02:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eRubwQV1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9EF389308; Thu, 31 Oct 2024 19:02:36 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B565892EF
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 19:02:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2e2e6a1042dso905767a91.2
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 11:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730397753; x=1731002553; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KiWXCkpXNPnCzj0xbulid75cbBHtsfPGYmcKqQ1qPSU=;
 b=eRubwQV1Nmr04CaykQhK7/JbKMcVGQrpq2vO/XaoYLX+fUFeMOzfFhNC0ZfrtsB/IA
 Op44v08Ui/KHD3JxJIkq6evqhmq+34WFFI5YUfuUsAZ9yQ3rWHnBoYser0VGLKlI5PpZ
 5hkwu8kDV6wjERvzkUG7rK/Gn43GGhdpWMTrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397753; x=1731002553;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KiWXCkpXNPnCzj0xbulid75cbBHtsfPGYmcKqQ1qPSU=;
 b=Wrlrq/uhurjNumc+h5u0B2s2FbMPO3xTei1gS1Itb6Ql3UBwRbYd/k5CHOIsN/NKgD
 umHPYMohgZyeFyaBUMCmXmHOeYKtJbNTGhJuzVNdCoGWzGg0jTFMsYoVi1k/JXUDVMW1
 QK8w1KLw0B5vYGaZHX03cCJCakqjBBJhd2ZrQr/7bIthmE81d09iKtQ60Oshf0F5K0CR
 STcYSLFMRoA9ydt8IQHMeaApo2tzSTloXpW5xdFBN0EauqHuJWn9dh2gFJin+N/j4qYm
 rBr71TsOl7cHUD1TH/tziI6bynIADsRii2dVIuRGnVM+VyrekLYDMmhCNrdlq6DMFMNr
 t7Mw==
X-Gm-Message-State: AOJu0YxNxbLmh910PyqJnBa6Gga+wsOe6aSJBZaVtkbWXQMCa9CxHbl7
 VhLB/wC3qsnKe0NmMdjN4/kzpGyiEo0j48nk1/Bst4TZzid/UJ5VAKYfJ8nL3Jfvchy8gNqzp4o
 FQCZnJtxNt7TxlMtHAIlIr9/ThPkZ3yy6xB3o4zg8YmTtl87uRQ==
X-Google-Smtp-Source: AGHT+IHWUKA3vls+bOy3mPQmW02Ba1p0naWxHSOL709bq4J9KzTicBHZntQItkN1v6wWVI18TJUMgZub5T2tmP8dy3o=
X-Received: by 2002:a17:90b:3844:b0:2e2:a8e0:85e9 with SMTP id
 98e67ed59e1d1-2e94c2e43bamr1073866a91.18.1730397752823; Thu, 31 Oct 2024
 11:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <20241010015145.1977999-1-sjg@chromium.org>
 <20241010015145.1977999-7-sjg@chromium.org>
 <20241029235324.GG2558755@bill-the-cat>
In-Reply-To: <20241029235324.GG2558755@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 31 Oct 2024 19:02:06 +0100
Message-ID: <CAFLszTiq9GTS4iSFg=nA2CL5t0Ym8yFQzVDbvW2h38bVEjuwtw@mail.gmail.com>
Subject: Re: [PATCH v7 06/11] test: Improve handling of sending commands
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Wed, 30 Oct 2024 at 00:53, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Oct 09, 2024 at 07:51:40PM -0600, Simon Glass wrote:
>
> > We expect commands to be echoed and this should happen quite quickly,
> > since U-Boot is sitting at the prompt waiting for a command.
> >
> > Reduce the timeout for this situation. Try to produce a more useful
> > error message when something goes wrong. Also handle the case where the
> > connection has gone away since the last command was issued.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  test/py/u_boot_console_base.py | 35 ++++++++++++++++++++--------------
> >  1 file changed, 21 insertions(+), 14 deletions(-)
>
> This looks good and I wish you had refactored the series to include this
> (as well as patch #7) in the generic test/py improvements series.

Good, well let's get this series in and we will both be happy :-)

Regards,
Simon
