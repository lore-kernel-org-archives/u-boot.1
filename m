Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB7FD767F4
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 18:00:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7494C892F0;
	Thu, 31 Oct 2024 19:00:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kP+ezEsR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C91B6892F9; Thu, 31 Oct 2024 19:00:45 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7CB988B55
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 19:00:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20b5affde14so9890345ad.3
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 11:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730397642; x=1731002442; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jtriioGLRVP7aGmIkNt+muSefqp3i1LWGJAoyuOfsU0=;
 b=kP+ezEsRk2m2N4vaSUq5+C/vQsWGjI2lDFPxCfMzAfYkIvY/mJWt7taEdApyyqH59L
 wu+zGC6bOx0ht0FbDhbbRtqOwnA3xWrQsMM06hC0vCrThejJGArH7nVFVqvkowPbucdO
 iCk7Cl3mLjUjWjBFd0rvkW7l57SU03wYFmsrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397642; x=1731002442;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jtriioGLRVP7aGmIkNt+muSefqp3i1LWGJAoyuOfsU0=;
 b=t2Y/MTpM+KRsnXFs9WmDSDRei4l+wcOki+css6rprNi/UMyRHIOYNRKPfBqPHZMuK0
 eVZk8nFJxb1Vxffo+gcAJ6JPuHUMtyxuRCfAFx14PxtAvgcxX8JgWKpWOHiyys4nUfPs
 A30i4dIpqtFWADuS1tQSxOaaVbgxaKgA9FliUDkqvmMPiBcoYd/fDlRJpSTGfpr8qthE
 JFv62hnXz4R7Cw4ktgSW7bruOPSxm/vMHdmy9+sHWdUuyGowAGE/dg28AK6k2J3EJ5HI
 lGKVximpezcAd3Zzk5J79KPFa34EuygcEy8fVIkT1/Keob1j9S3PhSCP1hwzHtMKiYTH
 CQNg==
X-Gm-Message-State: AOJu0Yzm3d5CCnRjawZzzRWyNcdldEUfK1mMoXzTeUaLklUZLfBdewZe
 Uvv8W0Sp7lJDv6WMKpV3ZIg5JTVl2keWVA21ws5sZZhDCX7xRKubBejF9FOMfAbtcFS/78tOv2s
 FPew74GTL5/docGXVi9ff5e41oWHGTOUhhcMnvBmeSyA+Sb9vmg==
X-Google-Smtp-Source: AGHT+IGPZXdNN/tQDdnpNxe4oEYJ7IB/nUEU9ln2BjoD28+BovHyxc/twPIIb3zp346hLOPHiSXmAqqKkWGgoByGxHk=
X-Received: by 2002:a17:902:fc4c:b0:202:26d:146c with SMTP id
 d9443c01a7336-210c68728f3mr269717195ad.5.1730397641953; Thu, 31 Oct 2024
 11:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <20241010015145.1977999-1-sjg@chromium.org>
 <20241010015145.1977999-4-sjg@chromium.org>
 <20241029235308.GD2558755@bill-the-cat>
In-Reply-To: <20241029235308.GD2558755@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 31 Oct 2024 19:00:24 +0100
Message-ID: <CAFLszTiuA_-xZZoca=DpXZTd2GRsdJb4Z2O3nO5Ab7bjaAxXfQ@mail.gmail.com>
Subject: Re: [PATCH v7 03/11] test: Allow connecting to a running board
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
> On Wed, Oct 09, 2024 at 07:51:37PM -0600, Simon Glass wrote:
>
> > Sometimes we know that the board is already running the right software,
> > so provide an option to allow running of tests directly, without first
> > resetting the board.
> >
> > This saves time when re-running a test where only the Python code is
> > changing.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> I'm not NAK'ing this, but this is not a open to errors kind of change
> that I like. It also feels like an unrelated "I find this change useful"
> kind of change.

Are you saying this change is open to errors?

It just avoids needing to reset the board when I know it is already in
a good state. So it is a time-saver.

Regards,
Simon
